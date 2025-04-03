Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904C9C3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 18:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C4610E20D;
	Thu,  3 Apr 2025 18:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tbY06QOC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25FAA10E20D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 18:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8FGO1bybcA83OdUM0PRcl3qBYdKupbv8pP8MqnX2Ix42kX6sGjHoJJY8qhyMDUoyfDL8MTHfdrijSHC8w6XJg+1gpubEFBicKV4/VXyjphRE1GQ/wrwaUKSSAqZZMQNZgABC5KQRKNZHLoy7Bi0vwawdfAWX8yTmsP7JeQuYxYk/IqqWscg3AHJykDnVSKQSYXvcPae/gpy1vEnprnb/jV7Vj1UMYznkfaj6YAJqzhAk58//VfN8ADTpWJSkcL7HEE8RZTa+MNkuVyymWfo9AA2c0U91bUr8Q7JEOsNLAtCkI3M6eJAi9Zk2KU9TrJgUNaadzQa0kZtcZlb4JU22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtJp4RupSufP66Z2sC2Oqalztr/AnA/Z98q9WA3gDLE=;
 b=jVEIAsjM0P2ZJmDBvqBir2wdyam2Pqz65FE5/F66z4gXSYh2JrLV2H/47V8yhcVhZZmTJm1/fBDkr4URPpH8jvHU1bQ1aIuCdByon/T5DJ7+CgWRjQG0PKMO3x94BI+l6wmg29eado2XRIsKJm36GBCy3uiwpH5TKRM+rfN05K8NCm9XPYnKtW8yMw6i+PW4M1qkznBhXzDtdMK4UDGK4/6gGB6Mpyg7MgrM0276OdcIFyh7U/j6o78tKP831kLITSO0eInPsgg97ckTAv3wmb0c/tIX8UqtyLm1V+pyANMrDX7WQd8b4/0p9+/5bGMPpuZsuxiI3eV3IO9qPMRT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtJp4RupSufP66Z2sC2Oqalztr/AnA/Z98q9WA3gDLE=;
 b=tbY06QOClM0hODnvovuI6CqATOeTSuk+/LTx7mhnMih7OByqI9EH+ji6XAgjyblWMmznU/BsH/EBXBJdoo6G/7PHqV9APkM3hCx39WyEoJLbhyG0GXUFGndIVPKG3l6SN2IFuPWZHZPxTs63HjMfdixQyWF9SkuNwpFzQT9hwm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Thu, 3 Apr
 2025 18:32:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 18:32:20 +0000
Message-ID: <6c6528e8-a40a-416f-9418-6adfe0865e89@amd.com>
Date: Thu, 3 Apr 2025 13:32:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd: Allow printing Renoir OD SCLK levels without
 setting dpm to manual
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Vicki Pfau <vi@endrift.com>
References: <20250323145316.859797-1-superm1@kernel.org>
 <20250323145316.859797-2-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250323145316.859797-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0135.namprd11.prod.outlook.com
 (2603:10b6:806:131::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3a946f-d758-41c9-e182-08dd72ddde2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWhHWXJoRlRESGdXSzdNdFAyTHlGLy90MHU1a2dNUVBqWVBXSjdoMlowTjFx?=
 =?utf-8?B?UnYvcnpmMEZaTHBxVFcwbVp1eVFsQTVjSThtMEZNOXg3TmJZbFhmU1dtbVoy?=
 =?utf-8?B?UmE5SjJKaHhqbVk1TzkyNGhMRzFBM0kyODlBajh1Y05jOFdJNHpiL3UrRlAz?=
 =?utf-8?B?S3N2V1hrd085MXk5aGVBU3kyd2ZHclZhRzhuclNGRGlVU0FWSmZHNXNtai92?=
 =?utf-8?B?RzJuNldZRW9XY3VkWC9TTnBQWG9QQWhIcy9JaDR5NnY5MHduYzFTYXpzaVp6?=
 =?utf-8?B?dUVMenkzQmpYaGhRYmZFT0xKdXl6cHI5M0RJRlJDcE9zSUg2V1FOODNwU2k4?=
 =?utf-8?B?bUtvK29yMUk5cXB2b0ZJWWxxMVdsUG8wVjhNL3dZT3l0SVF4Mmg0V2t3TGRz?=
 =?utf-8?B?NHNYNmZ2eVMwdnQ2b3AyeHhUeEFTZGVMc0hGUS96RHFYRlBIdGxRQys0Vi9P?=
 =?utf-8?B?cEZOTWVydDdhS25VTVRDUi9nOEU2SzJjY1lBNkpjZWVITVJEYWpwaVdOZVpO?=
 =?utf-8?B?elNLR1FiekgzdHpvYy95ZGFsYjdWNTNxd3JNOWYySkdKMGE1S211bm5QVlN5?=
 =?utf-8?B?djkxb0NzV3c1YklBMFhlV2wybFlkWC92dytidElCcWgvQkU5WnhRT0k5QVUr?=
 =?utf-8?B?U0xscTZQSTJsS3FNMzY1dFNmem04d2trYmREUEswWUdudzA3K2xXNlE3K2Ux?=
 =?utf-8?B?TWNuZVA4ZytidGNsTUViNDYwdXZWZkZpdDJaN1VRejNKNUFpNXBGUFpsaTVY?=
 =?utf-8?B?eUtrZ3hpV1FJZ3h1dzhNSFlxNmxacHpZY3h6a1lqZlpWRUNpc0pPdmVsSkNM?=
 =?utf-8?B?Mlo3Z1Vpd0YvUzJMekRjRFBPSWpVbUthWUVqbjBSdXhpdFZvTVFHOTdsM0t5?=
 =?utf-8?B?MGxmMWRIRk82TU5EWEd4VGJDc1czS0JtTWVrTkVleUFCSEQ0SmdXR0dEaFkw?=
 =?utf-8?B?b01IU3ZPNjJLQXpWNnl6VStMYiswL2dIQnRNZlVveU5uUVo2U2xxKy9DcDBv?=
 =?utf-8?B?S1VESUZYQkdjNnNRMFcyT2ZhQUxSUmJTRE9UQzBKdDhPYXNJMHU0Z25OTitW?=
 =?utf-8?B?NDBWQzU4QWxFQUMyQVYwVVR1bFBhTkVQUnZkemdJN00rRkd4cjJWcTYwcHFQ?=
 =?utf-8?B?alRCSDVsaWJjNG1DMlFpUnQvQU5mSE1JMTBQQkVVSk5yanQxb1RuVG9weGV2?=
 =?utf-8?B?Ti9yenNoQ1gzUnpxc0RMbjdXV3JqTW50VW56WnRTTW50S0FZVFdzajEwUnkv?=
 =?utf-8?B?V0xyR0tvWnJHVldyTnBieDV4d1g1Y0pnV0pJYk0rNVRmcFF4dFI0bTJWK1Ro?=
 =?utf-8?B?c09kZEZUT3ArVFU5aGlGbEdscW1DaitxUTFBa3NSVllUMUJPMFlvTTBGajFS?=
 =?utf-8?B?U3UwdFNBSFdldHRWNFVCY0htVWhWVHc4ZkRDSmp0L0RLTUt0NktRK09uMjBK?=
 =?utf-8?B?eXgrc0tVUEdudld4R09jTWVzNy82TEpDS3hCQXRHaW5GZWppa2pqanZIb0Fy?=
 =?utf-8?B?aHhDcGhwamZaejd2ZzZjcjhjWE1ieVp0TUd4SG1LNnlPVkZaU3JTbkJvb3Mv?=
 =?utf-8?B?cS9ZeHZ4cVB5UklLOWhicEE0azd6Z29iRXJiRmdCalJwN0F1VG5zcjVFZ3Vt?=
 =?utf-8?B?WHdlMk5LcWRtU0lNdWlCSWhlSzFKUzFtbUFJNlc5R0w4Z2haVnN2MmoxVEZL?=
 =?utf-8?B?b1lYTFVhemNheWtXbHNKU2dkRDBLRW04bC84NVFZZ1pxSlRiMXZQVzNjb2ND?=
 =?utf-8?B?NzFSMUtYOHJXZWNMSTZCaUV3TTR3OFFXQVhFWW9LcFo0MzJYU29sVkkyOHF4?=
 =?utf-8?B?UHQxL0tJUlo0MVJPeWdhUGVrZkxRWnlRSzZuNzRacmFzZEpKRmJ5Nzl5U0hQ?=
 =?utf-8?Q?HGgfH3iu0qib1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWloVlNuQm9GWW9lbmU3bkdKR29vSk5ab0ZYUnU3V1I2TEhGWWt1d1BDRkRH?=
 =?utf-8?B?czl5dEFCd1JHM290SmY1dkw5WSt1SG44bVFkN1FRZmRMVWh3Rm9zOTdhNnI5?=
 =?utf-8?B?RmpyWmJ3bm1EdkZNZlphcUxhMm0rUEEyeml6L0JaTkExMzZ2UVM5TDY1eEJu?=
 =?utf-8?B?UE4wMkFFaW1jOTBadFBUU2JrU2J0c0d6cGdBd2FLMG11bEppTk8zd05ZM1dz?=
 =?utf-8?B?RWl5aUhYTjFlOUhDeTVlSmRJb3BraWJsaFVvUGdzV1hUQ0JQWFhxZFkwWUNy?=
 =?utf-8?B?Q0hSbStpSEtZaWREcHI5cHdQTmVvTStNdUhzazJJaXVwWEQ5bDVUN0dpOXU2?=
 =?utf-8?B?bE12em1DbmhIL1JybXRpeVpSTXRzTUFtYW9TbmlRVG9ydUpRRkZRaUIvVHZ0?=
 =?utf-8?B?R2l4Y3B2RDlzemxhck41NTEwN0xEUXpLOVJHcFFTcFFaNC9rNmxEZDZ2UTFu?=
 =?utf-8?B?aWljQUMrL3FpOTNnYy9hc3c2ZEVFWFpJc0NHYURFdFhxaXcydzY2VXFoOTlt?=
 =?utf-8?B?MzVOSHFpWTBZbnBmZitsdHZRbDNqUlpwcnVnU01pSTBuSnRtdUw3L1J2dnhH?=
 =?utf-8?B?dDlPTXJhQXhFNDB4TnI4dTlnZWRhNzNVR0QwYzRmbWNHSGVHM2JjbDVGR2Rk?=
 =?utf-8?B?dzFVMFhwK3o5RUlsdCtmb29kV2dnZ2EzWUEvZlNYd1ZzMUU0Ny9DNHB5QnVq?=
 =?utf-8?B?clhpQzNzdEdmRHBXUENhVlJVcGIybitEQllTcjdoRkFTYUNoR1VyMVpncmNr?=
 =?utf-8?B?elhWbno2TWVJMUNOVGhzc0ZGSC9nWURkZytJdndJL0UwenpFVUJOYk9Ba0hC?=
 =?utf-8?B?OTYyc2txNk5QaTU2U0YyRUpEKytkOFNUL0dXcUJ2VXVhbDFvV3J6aGdCZVdY?=
 =?utf-8?B?NGZkUDR4SXQrRTVLQ0JnMzZuUjFWYkJicXJrUWtWeTRxM0hxVi9MMzJ6T0hK?=
 =?utf-8?B?Y3hyQS9rbGFWT0hJK2hwZ3N0cFJqQW45cGNINWxibWR3NTNhb1R5OEloVjNV?=
 =?utf-8?B?ZFREQVV2cnZtQUlZdUdmd1ZtMjRwY1hLWjJFb1BFTHRQVWJuV2Q0ZnVIMjlE?=
 =?utf-8?B?NFMrMWlpU2JQcGsvVVVuL1VzWFZaVThsaU9DM2VCTEdyWExPelFJaHFWazNG?=
 =?utf-8?B?a0hLS2drRVA2dktYM0F6WkZZT2FSWkVBdUJpVFdiQU9SRHRhY3hheU5SSHB6?=
 =?utf-8?B?MjBEZTFtcEJCZGZYc1A0TDZEalIxcEl2d1dQOGtEZWtnUDRpSmFodUlKc01L?=
 =?utf-8?B?d3A3UjZTdGVsWHJTOWVWUFRQZ3diUjh0YUR4OTQyeSsvVGprQWtERUFaa3BW?=
 =?utf-8?B?NE52T0RXblVxUnY0WFdBbjV1SnArUURRMi9DVmRVVmo2V3pFS1p5U2lhRkt6?=
 =?utf-8?B?TXN0aXFuWnA2UEM0S1ZteU9zcVZzaDRSUFB5Tk9vNGYwOW1lSWdER0xycU9O?=
 =?utf-8?B?clhTeEpPSkZKV1VZalVaV0xLSUtpYXRVS2s2Qm9iYWx6MlJUSVFaYUhHR1hm?=
 =?utf-8?B?di9idEhwYnNUdXFKbUlvalJBSnhwUWVUR0I1VW1xeUdYZ2cvV3NzREovT0J6?=
 =?utf-8?B?MnNPQ3hlY3ZyS0lJbXVoVzdvUVZvdXVCd3BPNGkydDloMEZzSE9iUFdvblVL?=
 =?utf-8?B?VGlVVmtnVi9WNjRlL0pxRkJaaWJPd2dBZ21adWs1K3Ivdy9lcXB1cjBWUk1M?=
 =?utf-8?B?SUxtYStSMWFRTVRQUENsQ0xpWlVwaUIzNnpJdnZOOU1tT0RiUllST1dxUnpw?=
 =?utf-8?B?dHppM3BwU1hTNFluekovUXFSK0R2c25kUlVnbDJZZmE1a1pQS1BaUCt5aS8y?=
 =?utf-8?B?eXFFSTRjMzh2RnhVMnJuVGE1U0tCTWJ2RjFuVmZPTWczSlB6aTRycFk1TkZa?=
 =?utf-8?B?QVNYWlA4R0ljRHZOLzE4YXFXRnJ4eldncTVWQlh5Y2dUUGhGVTVabW8rTVNq?=
 =?utf-8?B?emdRbHFYakRzdW9wWE9vR3A3TkhjdU54UFd0Z3M2L1U0OFZNUmI0MkdPS0ZQ?=
 =?utf-8?B?aVMzNWRpbjZEbitTT0JhYW1VMldwWWRsTGJUbjNpNkxxbW92N25mcVE0b2hW?=
 =?utf-8?B?TTBFVDRsQWxJM1dSZzNCKzRTaUNnSTA5NGlpVnlpMlU3S0FhbG9WQ0locmhw?=
 =?utf-8?Q?kTi1Rl3WBuj3DdW/aSb1Dg1AA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3a946f-d758-41c9-e182-08dd72ddde2a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:32:19.9645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rc5t+TYZ53+Tk32jicVcPOWzXxqxq74gGeSt8vZQVFlYTWNkSlIZ0VunzFbh7fZH8IFbh+mIWCpTog22Pd8C7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

On 3/23/2025 9:53 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Several other ASICs allow printing OD SCLK levels without setting DPM
> control to manual.  When OD is disabled it will show the range the
> hardware supports. When OD is enabled it will show what values have been
> programmed. Adjust Renoir to work the same.
> 
> Reported-by: Vicki Pfau <vi@endrift.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Ping on this series.

> ---
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 36 +++++++++----------
>   1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 37d82a71a2d7c..93275ff2ca692 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -510,28 +510,24 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>   
>   	switch (clk_type) {
>   	case SMU_OD_RANGE:
> -		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -			ret = smu_cmn_send_smc_msg_with_param(smu,
> -						SMU_MSG_GetMinGfxclkFrequency,
> -						0, &min);
> -			if (ret)
> -				return ret;
> -			ret = smu_cmn_send_smc_msg_with_param(smu,
> -						SMU_MSG_GetMaxGfxclkFrequency,
> -						0, &max);
> -			if (ret)
> -				return ret;
> -			size += sysfs_emit_at(buf, size, "OD_RANGE\nSCLK: %10uMhz %10uMhz\n", min, max);
> -		}
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +					SMU_MSG_GetMinGfxclkFrequency,
> +					0, &min);
> +		if (ret)
> +			return ret;
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +					SMU_MSG_GetMaxGfxclkFrequency,
> +					0, &max);
> +		if (ret)
> +			return ret;
> +		size += sysfs_emit_at(buf, size, "OD_RANGE\nSCLK: %10uMhz %10uMhz\n", min, max);
>   		break;
>   	case SMU_OD_SCLK:
> -		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -			min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
> -			max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
> -			size += sysfs_emit_at(buf, size, "OD_SCLK\n");
> -			size += sysfs_emit_at(buf, size, "0:%10uMhz\n", min);
> -			size += sysfs_emit_at(buf, size, "1:%10uMhz\n", max);
> -		}
> +		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
> +		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
> +		size += sysfs_emit_at(buf, size, "OD_SCLK\n");
> +		size += sysfs_emit_at(buf, size, "0:%10uMhz\n", min);
> +		size += sysfs_emit_at(buf, size, "1:%10uMhz\n", max);
>   		break;
>   	case SMU_GFXCLK:
>   	case SMU_SCLK:

