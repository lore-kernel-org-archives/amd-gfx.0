Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E373D41D74
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 10:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123BC10E1F5;
	Mon, 15 Dec 2025 10:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G7pktkm/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D7D10E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 10:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpHj1nMpxujPlmClATrWf6U+LvgbLg2xL+IMxx4pmNcnEVU4KkJ8dloxOg1vIb2jD+0kZiuy/aQeuBNCc/gVrc721+k1NC2HGIa7mDaUj1TRztL4jW04gtPpZ0z1z6yAudA4Fg0+yIPlzVs5R5U+B0BFzizk72Dcs6ppbROkT/Gz2ZEvhItfCQorfsoriZi4wcvxuMF/X5HgKr6rkBPd6H+RtQBXtSkwi9aUF3E8Vv7fPKjQ/J3k7zlQAmM3hwKyB8ub/FxeWPT8H8QaFM2Zdo5lLit/vMRm+ks5WKQXUwbLmLNnOHCvJp6wBFhmWgByv6dPt2VBcI9rptj655y2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phZhPwVhiaCZe2SfJrCaNNQIaB+L0LA+hLr064mK6v4=;
 b=xsLGGjN3KUS+0KN4M/00CSMFSR7vcFwRmB8IMpKg7UQfu4e6l3aiTF4aEQGkha56daL+aRK6coJQQ1vo8CLSWqHdlruev100zOHAA3pk75MuVi4n2fv55joDLC+0WGgL/37rSAfk5j+fnu5s7fqRf5Opq4MKzT9XX0QKxwsVxc+h+DReKtSG7x10RUDxWs2KIFByjbGJNLkZRGfyKxPqay6r1su13+L1VVEeWQQZLdvtXjaIGUhno1h8FA9+WvFXy64VHsu587AIVNixxcmkRJpZxbgSPqiZqPuy1qGXgGNYeGp9uRoviFgknVSCil44X0IK9Jk+N7Wc42H8yo2C4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phZhPwVhiaCZe2SfJrCaNNQIaB+L0LA+hLr064mK6v4=;
 b=G7pktkm/jduxWA6RQrp+yJREur1501THaKV+hIJd26CORjkbwRR8P3JEZej400KwPkhYFTkD2RpRpMheWWZj2Ok9i1mGA8N0cXoEYTM22Jye++dpwPffClgS5AI5SD/BtL88Y5KPpW8aNWPOHn5h8VJoDVGK7xnhl88KAXsAaxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:22:33 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:22:32 +0000
Message-ID: <434a49da-09e7-46e9-8f97-29f0ea91bae4@amd.com>
Date: Mon, 15 Dec 2025 15:52:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: force send pcie parmater on navi1x
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20251215095735.977069-1-kevinyang.wang@amd.com>
 <20251215095735.977069-2-kevinyang.wang@amd.com>
 <bc2c2437-a726-482b-9f97-6dacd6978627@amd.com>
Content-Language: en-US
In-Reply-To: <bc2c2437-a726-482b-9f97-6dacd6978627@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf0b7f9-f33d-4b38-4262-08de3bc3dbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHpjdHJLTExOVlFwS1grSmhITEd2Z0pGOHVsNmdyemp6bjJaSlJqZ3ozUHZO?=
 =?utf-8?B?TUtxRUpmT3ZjUEZPeFVOdGNIL0VJcGFYL0k2WlpvOEhGOVZjUHNHQ1dXLzNJ?=
 =?utf-8?B?M1lCbEFGM3FEZ0paRVRld2RnbHdXS2UwaWhPQzIvbWlsWXVzWldCSjNBSTFw?=
 =?utf-8?B?aC9kSWxla3R3N0hYR3NlZXpjQ1JoSU9KaXJJUDhGNWhvV3JXNCttZngxYlFF?=
 =?utf-8?B?OE56K3ZEWHUvcmRqVTUzSXZtcko4QUxGcXFweUlCTUFkMk9Rd1pJQnNDb1hG?=
 =?utf-8?B?dTc4bkhzc3JIOGdjZ09lemozVTgyWUVBYVJrU1RZbzVwa3NFZzgzVGRTQXNW?=
 =?utf-8?B?bUlIeHp4R1pRd0VRc2VocDlHcFM2aGtKVHhoL0RXOU8yZVJwYTVvdmlKaW9C?=
 =?utf-8?B?ek1PNzkyTnk0MHQ4WEFONkEyWkVOTjFvL3F4Qm5DTDRreWFocE1uMFdQRnR3?=
 =?utf-8?B?dnF4aTNWMVlidmQyTUxLV2h2bEoyY2FxeTdzcTFwRnFOYUNnTFBlR0gvbjhw?=
 =?utf-8?B?NG0yeTY5dVJTTzRVelRBd0UvOHE5Q21oYUI1WFdURnNZdUlVb1dVY2ZQV0t1?=
 =?utf-8?B?V0dySTlQeUsxNFhjeG5vT2ZjaDBrQ1NiRmNJYmdJcFlHUUNZYlZUSHUvM2o4?=
 =?utf-8?B?cWdYNEc3NEtIazBwdXpOY3BCMXl1Vys1dk0yS3hBK2F0WjV1QVM5UUd4VDVK?=
 =?utf-8?B?OEVPSTI0dU9oM09jbTZwSHEzSlRMSldWNVpZNVM1eVRRQlZGcnZHcTJvSmZt?=
 =?utf-8?B?dUVyMUJFUEczeTN4TWVZTVVIeWJ5a0dQUzZiVk16aGVQQmQ3S3RaWEdMbFkz?=
 =?utf-8?B?bkE2RVFQMUtTQjZLdnByNGNJWWVmeEljM1pZR1l3Q1NrVkt3MnBlK0dpRWt4?=
 =?utf-8?B?RkhXb3dUWFRNa0xlYmhvbXNGeFR5dmJ3UlFjaW5ycHl0cENVTkNrKzRITXNO?=
 =?utf-8?B?VHk1aHc1bmFFQzdKcUFDa0o5d3gwTm9xSU15T0RhSGJKZVpsY3J6dUR1MFZw?=
 =?utf-8?B?Nm0zNVNLUUlwWXo3VUNhQmFVZUR5a3l6Y3gvdFdIdmNyaFlzQ0FnNmRzSEdI?=
 =?utf-8?B?ZlJ4Z0NJUzdRZzJTVFd6QzlUWXNkRzg3dmp0cGYxb29sMTJIanpsTTdiZGpy?=
 =?utf-8?B?Zkw4bkp4TEIwUml3MENQRlRWeUpZbGMxNjhFMVpMOXlsZTFxWVVXb2hzNWE5?=
 =?utf-8?B?TC9TbTdNNEF1NG5EK213SWhyTld1WWV0SzNtV0JQZHM0S0UwYUU1eXhvNzho?=
 =?utf-8?B?cGJSVm9KZ3hvTGhlMXhKVnJyOFpNUmlmYjJTVlJzRGNrQStzQjlIdVJSR1ha?=
 =?utf-8?B?M3c4UkpNOW5YckVuekxTdmU4aElTS3JxSmFFWTBxdXZPTFFLTUN3UElzR29C?=
 =?utf-8?B?TDZYYUh3QmIwMEdNVU1lRVZiNWxwTHBETGdUZmpmR3hTYmtESm1nY292L0dn?=
 =?utf-8?B?NFpTMWsxTXZoWDhBZDFxUnhDUzh3MERxV0NNczhOVXpPMXpmRmRtM1daUnkw?=
 =?utf-8?B?YVE1cjAzL3ZwZEQvcEpNNkdZR2YwWFh2dFd5VzVxUzROVUYyQWVZTTVLRTIz?=
 =?utf-8?B?b0FiYzNwakFvYXd2L1V2MndsSkI3SHFvSHQyQ24zTDVSazB5M085ZndNTE53?=
 =?utf-8?B?eWNrQ0pObkw1M3FiczVZUTM5N0x0SDhRbmxYanMva3R2NVV2SUNPVTdXbENt?=
 =?utf-8?B?cGNrTCtCQ0ZlRm1Lb2EvYTBKNnVGUnlnMDB5NjVaY3pTTGxkeUhtQ2hwbFBZ?=
 =?utf-8?B?cE4rU1phRzNLV2V0anQvS055UEFnbmhHMXg5TkJFQzBZOUhpc2ltcVI2eUpE?=
 =?utf-8?B?QUNYclNaU2FSaEpDSXBMUWhnQUcvTHJNMEFYMFRzNDRBc1VXSGtjKzVmV3l6?=
 =?utf-8?B?VndXUUdzdUFwYnpOMlZBRGtweW9Ga215dFhGajJnVFJJNnlxVDR4QUNtZ3J5?=
 =?utf-8?Q?Qi3A/JYABOh0ozm7T0qAdAwx1NFlfCKn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE9ROVJTcytKUzhCRjlSSFJNRmpOOXAyb1lLMzRoU2lwbEYrQzRJYms5WGJN?=
 =?utf-8?B?RWVHTmZnWWQyeHR0RkRvRjEyZjEvYkZPdnErcWl4QWJGSHl1YmVvSzdkemd5?=
 =?utf-8?B?aklqSWp4L1NrOE1IbmwzV1M3em9aRGFPZDB6R0tubWNFRldCbmRyNVA4YVRH?=
 =?utf-8?B?b1MzVi9OSjdSRzJaQVVnamxGc3luZzV4amdlaFdRbHJ6VEw3MnhqdkZRSFRl?=
 =?utf-8?B?SDUwaXZraGtLdElYaDFkb01lNVY3VWVhVmJjcHBENXVZUE9qYXA5dm44RWlL?=
 =?utf-8?B?OHZTdTcwclJydG15a25OMUxzL3R2UjR5cG01T2tONGptR3cyQnBKZlJ2bmlo?=
 =?utf-8?B?VmYrN3pMSGxTZmdpaFFLM3E4VWtPdTlyOEh4azdMN1JXdUJVTmNLWmFCVzFm?=
 =?utf-8?B?L1pMMUM3cnZxeG5adXl4ditYRmdQTHVxb0lWODF1Zm1DcXZnUUtwWjd3UFN3?=
 =?utf-8?B?ajUvT0J3MER0U2lFbXFidTFEOXRyeEtudmh1c0tuZW9CZThhMGFDVW9wUnlK?=
 =?utf-8?B?RHp3RDBQU29BREw4cnNOTjJkU1N2ODFNSm1ZT1F3ajRZbXN2UjR1MzhaQW1i?=
 =?utf-8?B?RW9CREZTT1JPYnkrcWxMRG4zMVhyTFhBa2JYU0FjSSttTTBNcWVCbGhpRVpC?=
 =?utf-8?B?M2pPTHlCL2pzNElPcjFSaCtybFFIVWplblVyaTk3cmYyYS9Qa210RUlIc1R1?=
 =?utf-8?B?azhFZ0R0WG4zUWNOOGlZczNZNWxOTVJFWXJvWEpzR3IzV3J1MDg0SEtKK2Z3?=
 =?utf-8?B?dnVGeUIxWlR0SHE3ZC9TYzNsakZ4ZHdha2FGTkY4NUxuazJORHIvQW9YUkhR?=
 =?utf-8?B?WW1penB1eGJOWGxNQVBYSTlPckx5UEpYdlkvUk9NMVZVa0dYd0JlYmd1L1ll?=
 =?utf-8?B?ZzQ3THZ0TFR6aXFxa0lVa2UrZGsvUTN0K0k5QnZyZFh3aUFSYTZWTm1ZMm1Q?=
 =?utf-8?B?U3J2UjVTR3o4dWdRVUQxWHk2Q0RTQzBDS0lKKzlXK0hqTWY3ZEw0cVphRWh5?=
 =?utf-8?B?eTJ5eDVLWDh5d2Zia2ZpeHFVNktGaHpmWmNkQ01tVWkrSnQ0TDJXL0VKdkNu?=
 =?utf-8?B?YXMyVVYyZG44NzNGWE9tRWdRQXdEdUExRnovbmFzangwT0pnMERNQ3JLMTF5?=
 =?utf-8?B?cURDRVpmQVRtOFR4bkJlYVQrMFhaQ0VEY3FsZVZWV0VxdFFsd3dMbTFHc2RQ?=
 =?utf-8?B?TzF5MWN0OFR1SXpMU0ltRTNwVm5iREcxMjdpZnhQaVBFUmJ0TU9FWjUreTFj?=
 =?utf-8?B?eldmc3V5bU1lUmkrVWRTYUMwQjhPYVN4OVZEZHVIcm5iOXZWdEdOaldyZW1K?=
 =?utf-8?B?QWlrd0kyUDBuODJzeUp4WFh4K252WGN3UWpETmRmVkUzK25hSVdDMzZyaEVW?=
 =?utf-8?B?aGdkaXJCSkw4SFR1Rk1xejIrSWJiU0c0eU9CZGN2Znp0Y1NOWk5zOFdsOGxS?=
 =?utf-8?B?Z04xekZFZXUvS2EwT1pxYmF4VENVQTJLa1ZNYkdRcE5SZTJCeVp4aCs0Q280?=
 =?utf-8?B?NkJuNnhSdDJqdUQ4c25nVXJPdWhRbWlIdlA3b2l5WFNrNzVNS3BYQUZ5RDNm?=
 =?utf-8?B?NmVldjRlT0todmVadXIraFlXRGh0SnVTeTk0Qzk0WXhQeFlYQklWQzQxSFdQ?=
 =?utf-8?B?c0dOeXczQlpxdnJHRWw2aytGVTJoSE42TytERFVMTER3eU9WbGpiazlNS29V?=
 =?utf-8?B?U09PTXRESDNudGcyNjRYaWZmZENQR1huVEYvbG5oOCtpZ3J0VEt4NHgwQXJu?=
 =?utf-8?B?dVF2KzRINklCV2RSYzR2Sk92VE9HTEdIdkpodXl4K3VMWWl4bDU5K1JPd2dP?=
 =?utf-8?B?aGgyWFBnand6RzJWREdoZFhxNFV4QzFwWHFHdmFOMW5zSHNPRmIxbXFjUEMx?=
 =?utf-8?B?U202ejBOMDZwVG5OQnZYMHNUdVNIYUwyQzdSbk41cHFESDVBL2RYTEVzR3Z4?=
 =?utf-8?B?SS9Dcnk3d0lrMy9kMnBwcldrOVB1QlJrTUNzNmx3YmFMWllmOTBUZjRiR1Vw?=
 =?utf-8?B?VCtZQTREOGFPdlpmTlFnR0o4amI3Z1lxeE5SczB2bUZoMEFDcDBWS1FVWGhZ?=
 =?utf-8?B?YkxhWEs5MjJ6ZFBjSUpReVcrT243TklRNVBURFJwR0tsUm10WFdTS3RZa1dB?=
 =?utf-8?Q?SUeI0mhHox1QHqwwbo3Bg1Btg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf0b7f9-f33d-4b38-4262-08de3bc3dbdf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:22:32.8141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gQnCbq6yZEF/w7vq0IZlDzGCazvUipkXcUIV37aClBvl1m8uXMUvMF/0+60oA1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317
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



On 15-Dec-25 3:49 PM, Lazar, Lijo wrote:
> 
> 
> On 15-Dec-25 3:27 PM, Yang Wang wrote:
>> the PMFW didn't initialize the PCIe DPM parameters
>> and requires the KMD to actively provide these parameters.
>>
> 
> If this needs to be provided always, shouldn't this also revert the if 
> check introduced by
> 
> 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it is 
> necessary")
> 

This check to be specific - 
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c#L2458

 From the patch description, it sounds like this should be removed also 
so that pcie params are always provided by KMD.

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>> ---
>>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/ 
>> drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index 0c26fe6fb949..96dbb7a9d9fb 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -2215,16 +2215,16 @@ static int 
>> navi10_update_pcie_parameters(struct smu_context *smu,
>>               dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
>>                                       pptable->PcieLaneCount[i] > 
>> pcie_width_cap ?
>>                                       pcie_width_cap : pptable- 
>> >PcieLaneCount[i];
>> -            smu_pcie_arg = i << 16;
>> -            smu_pcie_arg |= dpm_context- 
>> >dpm_tables.pcie_table.pcie_gen[i] << 8;
>> -            smu_pcie_arg |= dpm_context- 
>> >dpm_tables.pcie_table.pcie_lane[i];
>> -            ret = smu_cmn_send_smc_msg_with_param(smu,
>> -                            SMU_MSG_OverridePcieParameters,
>> -                            smu_pcie_arg,
>> -                            NULL);
>> -            if (ret)
>> -                break;
>>           }
>> +        smu_pcie_arg = i << 16;
>> +        smu_pcie_arg |= dpm_context- 
>> >dpm_tables.pcie_table.pcie_gen[i] << 8;
>> +        smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
>> +        ret = smu_cmn_send_smc_msg_with_param(smu,
>> +                              SMU_MSG_OverridePcieParameters,
>> +                              smu_pcie_arg,
>> +                              NULL);
>> +        if (ret)
>> +            return ret;
>>       }
>>       return ret;
> 

