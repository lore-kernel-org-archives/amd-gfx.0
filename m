Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A063C02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 08:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C1610E52B;
	Wed, 15 Jan 2025 08:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N6UdcWls";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99ACD10E533
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 08:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf3yhU3eecfO6H7fM30+yxKQanx+zDt4hnhhnMOmc142XZneY+Sfw9Hk6rnawkIEHZ9UUdxAhALqhbbCN/wMv2Ql9CO0GOfCnwpizl2FDu3kjP+Jd8JOyvBb8DOzIL6kp+FSGKJybfenQLWnU/qXO5ZAvy7dPvsGdPpTOwdvsfPcooYf6CqX32YuY6z1/eVpcX0R0wc7gEVp4E9IslmoF8AEIQFgmzoM0Z1cXLP3NOmirqGvbdQD40H+eGnwuRoPxX38HS9G7KNczsqK9QKvPsi2qyNbdQwUufTad1qVa+CfnuHJptg1cQjInsWSTq0EGR7TLzDYKfLcpGU2msEOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVXm5M/t59AAUjhH4AFC/jqqABeCrW48GoxTLz8cJKc=;
 b=ekR6ruQH4pDXc/+excKadx8ubB3yrfGMoQUEXhZxgiGQLGfXZLnOBILyXUtRIDzSaLHITR3b3YPJOHPJw/AY507nf0iA8nU6AlKY69pQbhaOQy2I2ggxtxmFnt52APdmcNxvk+rZTNvfTbZHtRmWY/9tDv8DsTA8oGvk4Q1wrjIyHOARJPrcPykQxzHHI4Frp3Xk9tOi9RANFfXezJJhiqS+WGJMedc0LQ4zgbZ4k+tj2AbTWkp+ZwxDCfK+iRM4E56TAULVbj/mwZRt6t1Cs5KzO7cCUC6kfpvs7NSqLuZdlF9CLniX3C8mgGce7RgoWqElOKV67GZUrxV/A4wQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVXm5M/t59AAUjhH4AFC/jqqABeCrW48GoxTLz8cJKc=;
 b=N6UdcWlsy7kY6LK+S1lcxwxQaZms39IjL9iU80VUugqnIHT3zcgSPkKkgJuW9svSsExggWlagsg3xZIH5+mkkoE9FPjA9HYX2FFe5uRawkGGWO2SYq3rL2UhxTWv0/c+bZtxKHgL1/kep8jcQgSvQQtSZkPuC+c6S++dFRQkruQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 08:22:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 08:22:57 +0000
Message-ID: <398c7b66-4727-4bf2-88bc-6ce5a2442678@amd.com>
Date: Wed, 15 Jan 2025 13:52:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com, jiadong.zhu@amd.com
References: <20250115014035.3681642-1-jesse.zhang@amd.com>
 <20250115014035.3681642-3-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250115014035.3681642-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B1.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::d) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af408cc-0f35-4d15-f484-08dd353dd09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WU12UHVpZC9iZVBjVGpiTjlrZ1ZGVXMvZG1kMkZ2SzYxbHpOTkRkb1hYcnMx?=
 =?utf-8?B?Wm0yVHRYV2F6YWNTWXlVc2ppOEdESDdUYm5zVFJoRmswTVoyQnZpSm00SnpC?=
 =?utf-8?B?dEZ3amdCUkR6MS9YODJzT080ZmVWRkswRWhNZk0xM2RGM25sRGN4ZTlsdnF0?=
 =?utf-8?B?WW0xMVUra2thU1hLSkZRcHhWSlAzM0w5enh6c2gwYWMyaFkxTlVMczY3RU9E?=
 =?utf-8?B?cmdOdGFIZHFhUXRsQXJtNTBNbUpxN2s5OWs5QVJLbnpPR2J3QWpPQmdueERQ?=
 =?utf-8?B?UjBxS2FJMFA5NFV3OGMrTWR3ME9yZnhQc3RFL3NqRDQzRWFGRXo4MTVmTWp4?=
 =?utf-8?B?Z1NzRzMzdVdFY202bTVXdVBPd3BVc2FKNW4yS1JPcTJyeTRZNk9GSW1zNmwx?=
 =?utf-8?B?cjhFd090ZGtjdjFYUDVobFo2WGpwTVNpaTZnZzBNVWhQWWE5YUhsdk9TS29y?=
 =?utf-8?B?Si9PeFBlOTE0N1JOUlRoUFh0RHUvNnB6YjVNOVJrMU9wcUtZT2IyUmViSHd5?=
 =?utf-8?B?STRhTlF6c0oyTldYQ002eGdISjVkVUViZlRaWWZuNzZveVdyT2gyV1E2ZTNV?=
 =?utf-8?B?RHg5bHBDSy92ZXdFLzRCTmVyNTdDaEs2eGFFVkdaWUYwL3p0SHVSWGpHNWw5?=
 =?utf-8?B?QXVDTmQvNnp1bmxDL2ZWd1pKMnBxcThjMkpIbUlJTnhFQ002OXVXdFZwVXA0?=
 =?utf-8?B?UFRnZS9kMzVvaU5JdG5JK0QvZGZDWDhPNjc1Tng1Y2tIOGlDcFJXZGlYK0M3?=
 =?utf-8?B?aXdPV2VYOFBzMmRoeVg5WXJXRUJQUGdIOU9pa3Y0c2VGN2EzT0hlVHJCMHIx?=
 =?utf-8?B?L3RxNzFORUl0d01FOUNVeDFJQ1V1eFA3Zlg3UklkaU1vL1J4cXljMVk0UXF5?=
 =?utf-8?B?NjNaak10Vi9ISlpUWXhQQzZ0NXlVaFdnTVBDTldVVUxFQ2k1dlM0cGVpdmJh?=
 =?utf-8?B?S1A2T1FVRHJOVlV5M2MwTlFHRTVRbjk1TTZURFI0c284NnlpcTdEajh1cjd0?=
 =?utf-8?B?VHlwTGlieGpubUVteVdMdWdkWXZXTVR0MkhSeTVUdldSZ25ZVlF0Q3RKWDJS?=
 =?utf-8?B?NDlobzFrMWpXeXhRYkNCVit6blEzdkhQVmJXMElHbmRhcERDRDllMjJNMk9P?=
 =?utf-8?B?dUJkaHU2M2l3M3VKdHA0eWVJOGhrbndSYjd0VXVzYVFGUGJGdDFWOC9FZDIz?=
 =?utf-8?B?dHdPZmlhdFczSXVWcTRuSTZDZDNhdzdSUExHclFJSDhaY1V5R3pYeDZ6bU5Y?=
 =?utf-8?B?L3p3d3Q3WTVaR1R1OWdhRHFFQzFoWS9vY3hYZ3EwUUY0Nm4rdUozVktiQjlu?=
 =?utf-8?B?Z0o2L0I3eVc1M0g1cXRXQXdteUxzbTRDeXdxUU9LVkVta1hOOFhNLzV2dUl5?=
 =?utf-8?B?WDFEdFd0L3pHZHJ6VUZNZW1OdDJTRVNGdzVIWXRTeEs2UmpDaDZoMFphbE5r?=
 =?utf-8?B?V1BaNWpEU3BOaXBqOW0rNXZESXoxT1NIdHVTdks2cmhpMUVZQm1pOHR5UFBP?=
 =?utf-8?B?SDNYRUpOdnRtK2NvS0YvQjlRSjNKOGloQjJWR2N4MXZrREVEZmdHWFQ0MDBu?=
 =?utf-8?B?ZVB4Nk9JVlEzOFowYlZ1V0U3SGV4dVRzWUhGNGFTWTU1M3JkZGFwcDdqRTZQ?=
 =?utf-8?B?RmtnbTgycnNYd0hzY01iRFBybjAwbHNyTlNWK3hyNzU1Zm9QKy9QNXRCS3dv?=
 =?utf-8?B?M1pieUQ3SnhjT3U4VFl2Y2taSnFZSFBUWlpIT3FtOW0yTXFJZnR4cXRUcjd5?=
 =?utf-8?B?dThjSGhqOWRWOGN1Rm10MnRDK2d1Z1hmZjRUVGJ5RGczMzd0R21RM2h5S1ZZ?=
 =?utf-8?B?ZFVPQXZNZFkvYlVpbndTNkdmdDlpajVXdHZBZUNybFNVZ0M2UFp0dVBsTTdN?=
 =?utf-8?Q?pZXNsWpcSppHn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRqeXZOR2Y2S0hhK2NjY0w3TFJDb1RWWG4rak5ZS25PYWJzS0p2R0RnaUU0?=
 =?utf-8?B?c0doRWJCS3VickhHMlJSVWF5djdSbjRraVc3eVpvV2VGS3BhMDNZQmVSOWtU?=
 =?utf-8?B?cXhJZ2ZoK3NtV2dWNHRQcVhWcC94TlY4WlRaQzdxTHJBbmgzTDNmeGoyYjZs?=
 =?utf-8?B?d1o3Yk5FbXFxM2pQbkhqc20yYWdqRmVRdFpsMjg2VXBqbnpFaS92U1lhTVQ3?=
 =?utf-8?B?S2NiLytJbDJLaE1QN1NMZGpJcTNzV0NnWXBVVG5sRWNDSzJVMEJsS0dvTm95?=
 =?utf-8?B?NTNTWXZSMTdEcTk4L2hMK1BmNTZKTVJsK2xSRVlmUFh3M2ZXYWwzZmNzanJq?=
 =?utf-8?B?MW9mK1pRTk9nVElrWFlPRWIvN2NxdnYzcnQzckc3UHQxaXVsM2JUWWhGVVBX?=
 =?utf-8?B?SkhsSGk2Q0NZOWI0d0o5WnFscTNRTXJKSDh5ckRVMlNzNlhtcHhDTDZ4YTlj?=
 =?utf-8?B?enFpcG5Ra1lLMHBuN2Fsd1VTUjZoMG1tdG9NNGFWSVhyOElVZUplYmd3NGJ0?=
 =?utf-8?B?azViUDJLR0x1Qzk4cHg2OTB3eEl5eVM0aVhwV3RyVnZhQkRWNWRjMnEwclEv?=
 =?utf-8?B?NGliSWhabmFEUWhObEFsT0VGZ0RQSE1mNTlHMFFUbDdJbmRxY0VKMmZ1M2FR?=
 =?utf-8?B?OStzNVBmR1JFWnM3alBvdjYvbHRoREZZbWx5eDFjUzNYc1AwR0psdEF6Q0Qv?=
 =?utf-8?B?M0NiSFZwb2U1TUZUNkhDa2gyVnhjejhCNW1tM3NZdFFWS2YrV2VLYTZGN1Bv?=
 =?utf-8?B?N3ZxOGZFSmRkKytWQUtvTEVzRFpFT3FiR0J4YXd0MXRXWGJ5c3lrWTVIWXdP?=
 =?utf-8?B?U1NwS3JyaGpFYk0veGw2V045RjE3SVdyanR1WDFPU1NGNlBvWDliaVVWZ3hP?=
 =?utf-8?B?TjJFV1JnRm5QeTBLT0dYWE9qdTdVZzRvcEtxcU9XdWlkZnFMNWM2aGsyODhF?=
 =?utf-8?B?ZjBlVWFHY25yTEI0aktwa3Z2bXhzL1luZXV0QVVaVUIvWVFDd0lUR1ZGMnpQ?=
 =?utf-8?B?TlJxSjlDZittU0hNQm1tdUpNaGh2RTVDeElaMFBYaWZ3NXpxR2c0Q2pEaTBm?=
 =?utf-8?B?NkVrUng3WTdxWDhrdjZycW9ib3ZxQkZNek5nYllheUxHbkgxL2lWYW9odC81?=
 =?utf-8?B?Y1ZVdm9mWjFnRVZFM3JQYkJiblZycllaRXl4MEF6OUJVZzgvYWlIY3B2YWZ3?=
 =?utf-8?B?S0dRME9BMGErNExHYVVTZ085UzkwYmhqS09ndGs4UjE0VjA1TmFKMlIrUXdH?=
 =?utf-8?B?YTlIckZ1cVpTZ1BBTlUvQ0RJWnpmTCtoRTNoYmY3bEFxUG1ZRldGNmc4QTFJ?=
 =?utf-8?B?cy92TVZaNkN6WXhEZkp3UWxHQjlkR1F2ZlpGVFJKQWpKNVJKNGxiNmRGNlRO?=
 =?utf-8?B?UlJTZWNqMUtBWnA0eXBhZUZzOWd5TnRVTncrOGViK1B4UmtmaDNDWHY3alB4?=
 =?utf-8?B?Q1ZGaUZWUmVTcXVXRFlmcTE2RFR5OFNIaEdEZ2xaamhXWDJJSm82VnZCT3BH?=
 =?utf-8?B?OWtMMjF6ZmJXWmZLbnZUd05FWnNiZ2lHTld4YXZmdXcrUVpodG4rZTB4ODdl?=
 =?utf-8?B?MUdKeG8rZUI1NkVWUWEzNlY4S3lZNTBEaTg4cDBLN3lCM2xDUVNML2tWYUg1?=
 =?utf-8?B?aWFDQlVMRFA4SXFtaHNQaCsvYlhFQ1dvYUt6R0pFK1Z6ayt4SUc0V2VWc3hp?=
 =?utf-8?B?RDlGWUNPeWdxOVE5TFlLbkpOMWJyS1pENDF6V2VLY3JlOVpNUnlCdU1YTHFv?=
 =?utf-8?B?UUFQcHY1anNmdlZWamgvNTB1c2RFOXp5MmR6elBMMUlScFdKYTNUSVpCSjFF?=
 =?utf-8?B?SWQwblA3Q3R1blcrUjRWMWtEcDQyZEtBUWdpYmR3ZVFzQUVUTFpkdTIyZ2N2?=
 =?utf-8?B?OHA5ajVialVDUGZ6ZkFmbXc3TG0zeVZybGJZR01VWW8wQk94cFpkbXREVGpa?=
 =?utf-8?B?dFdRMDFpSVlaMjBacWVFMEFJVms3bmZZMks4NExyOW9hdW5waTUwaGVYTlU5?=
 =?utf-8?B?czBUMWw3alRSY0hNeExyZ1JNZWNKQlA2RUREUStGK3JDRGRSTk11YVFBWDIz?=
 =?utf-8?B?QnVaMXpNcTgyT2Z1YXV4djZZemFKNHYzbWw5U2RCeDhrU1UwaFp6dnRiTUNI?=
 =?utf-8?Q?8zf2I0DrZzRnyB6yVoyf+VBTh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af408cc-0f35-4d15-f484-08dd353dd09b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 08:22:56.9566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEFaev7/sFPIfMUVC1J0kIHxZ0FIFnE2kArXHau95cmX76wJW8pfoAleskuDFwtu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/15/2025 7:10 AM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> This patch refactors the firmware version checks in `smu_v13_0_6_reset_sdma`
> to support multiple SMU programs with different firmware version thresholds.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 650aa9d0548a..5a5742571d29 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2745,11 +2745,15 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>  {
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
> -
> -	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
> -	if ((adev->flags & AMD_IS_APU) ||
> -	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
> -	    smu->smc_fw_version < 0x00557900)
> +	uint32_t smu_program;
> +
> +	smu_program = (smu->smc_fw_version >> 24) & 0xff;
> +	/* the message is only valid on SMU 13.0.6 with these pmfw and above */
> +	if (amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
> +		((smu_program == 0) && (smu->smc_fw_version < 0x00557900)) ||
> +		((smu_program == 4) && (smu->smc_fw_version < 0x4556e00)) ||
> +		((smu_program == 5) && (smu->smc_fw_version < 0x5551200)) ||
> +		((smu_program == 7) && (smu->smc_fw_version < 0x7550700)))
>  		return 0;

I think this should report error code for not supported rather than
reporting a fake success.

Thanks,
Lijo
>  
>  	ret = smu_cmn_send_smc_msg_with_param(smu,

