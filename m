Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A42EC3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 15:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8BDA10E40B;
	Mon, 15 Jul 2024 15:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uFNbPMQ4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574CC10E409
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 15:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ids5PX/y1u/V7bicathIpsgwg2T89BVV54S5xzCy54hAJIvjFFLkn81+W+M2AF6g0P/llkINq7UhgBKGkw1dYufXJbQAm1+aZ7vRre5efyOoKLPu1OepNJQ1bMnt207/hzOHuW6PLCSAgP2r2wk6O2zO3mgvLeB0b9Ip82Ilq5QnsG9SJS6oIk/a9Tx5TODh2U3XTcJouy18LjLpjCKiQAyn9rpGptmMP1tIZsLj2J4q3DTLPdR7sW1qHjS8/b6doaaHAND86CXDorQLpJGguwSSfRg2ljQekdfp/9EfSLh3GwT16TWc2MA9WhMiUVhXAFZVp3FMT8Pe8kBTjonNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr457bMHVblKLn8tk5Xp+87KL7yNcryZl1T2IvKzqnw=;
 b=nCOMipCpzcYrNsyK7z6ETWSiXRhQClxTUY5VAfQtWeGH6buv4vZpmB3AwPZ69ymXsPlt+TcoXBdBhPJ2qtRwIYIZDNgypt2P2/wxitQ8GdmhiCGNKKus+V5FOgVClZzBOiO5TwxzHivXSZf68Vp8bGHZxM2kv5mJOsm+A1hO+IcvriU12o7A71kZGTqVGny/tOsGFwSAjOmGMB5uaVFi5iZ23JByrpc84mQGkS6zCWerD/BNgap9VuVvPLRra2ugha4SV0SRkegfMHj+oiS0b17t7J3wvQa1nz/rOYjQujW6ksw/Qgdt02XEHwfXbLaf25XQFhdAag1RSXOnL8Melg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr457bMHVblKLn8tk5Xp+87KL7yNcryZl1T2IvKzqnw=;
 b=uFNbPMQ4w7r1j4WUhPnA9vWK0bnX9Nd+msTuxZpTlfMdGNoDxBw91U7tL66UHm42Vale0d6uuluWVsTy9/lF19uFuPTS2ROXPSNMHbIvh8T5H7IGtnzkw56VYUIQFf/m5KD2Wia+NqAd9ok5Fz2jc2h3sQHn2TL7d3ScBxSvgMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 15:08:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 15:08:40 +0000
Message-ID: <ac0f50d7-9133-45ac-8ba3-cd8567963f61@amd.com>
Date: Mon, 15 Jul 2024 20:38:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add empty HDP flush function to JPEG
 v4.0.3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Jane Jian <Jane.Jian@amd.com>, Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240715144748.168556-1-Jane.Jian@amd.com>
 <cf9dc5a2-39d1-4973-b06b-6b791f6298b6@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <cf9dc5a2-39d1-4973-b06b-6b791f6298b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 01622f3b-54d2-4e1c-5107-08dca4e00259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVVMdVcrZC9DclJnckt6UnY5M1g5V0V2T0VSMWNXVHlFYWw1MThHVW5NUXBv?=
 =?utf-8?B?OW1WTnRQTkNzYnBZaFlVRDBUbmFqSVJCRXo5UFc5eFV4dEZ3eGNkY3VqVGtr?=
 =?utf-8?B?OWllbnIwV0JYQnBMZlplNmZqVGJJY3JrcXp2SS85R3puVGJZWUJ3Unp1UExu?=
 =?utf-8?B?SVBSVTZFT3RIUGJLUjRRVm1RN2FiNU5jOVpTNm1qL0ZRbFZGc1hHci9UMmVR?=
 =?utf-8?B?OVFWRDVYYWtqeDNVOXl0ZmRCWjdOV2txQkl1T3B3Ky9peVp6bGhxL045R2U4?=
 =?utf-8?B?QWI1WW5MMkxwRmZkSjU5ZnppcXRwakkrUndRTFA5eXkyWXVTL285K09KNGtO?=
 =?utf-8?B?QURLYjJZa1JIMnZsc0FsUG5wS2ZDOC9zZGd3alcreklhRUVlRHA4MEVud1R4?=
 =?utf-8?B?RGt6dXBSd0w2clF2L2RrK3JJVithUmhMM052ODlXZjU2aUgrQnUweUc2NS8y?=
 =?utf-8?B?OTErZlpMSkpsK3JTYWVmQzNUZXo3cUowd2pocndaU2VTYTdoeVpJZ3NOZDFp?=
 =?utf-8?B?L3hCV1psRnA0cUxNekY3UjcwbVRyYkY3eFZDdHRJTkNCeHlkZ2RJL05jT2dh?=
 =?utf-8?B?TGR2WUJpQ1Y1VzJ6d3p3M1AvVWpuYmQ3SnJUeGRnVFpmeUswV0s1MnZCU1BL?=
 =?utf-8?B?QUlTRmEyNU5zQXpHK2wxU1VPTHNUT0JxMHpReEJZeVdjcTZldUtVOWNlR3dM?=
 =?utf-8?B?OGtQQ1pRVDJYRjZJV29CSkZxU2ZmZEtwd2ZMVGYrOGVoTFdEMTFEcW8xcnpq?=
 =?utf-8?B?dkN1anJTcXZ6Z3J2Zk9BbVBxMVB1b2I1Mmp4SnozWVpOK3BNOGljN280dVgw?=
 =?utf-8?B?RTJML3VKcEtmcGtENkpwOGtnNjQzOUZGNnUzUDl0Y3RrRlh4NU1kN0RwdEw1?=
 =?utf-8?B?bnRtRzNlUjIvSU9NOXNPcUUxdXRxTGk5NWl6d3J6RjA4YnkybzRuTzlaQ21y?=
 =?utf-8?B?anFHT1Mwcm4wcVhPMUJ4RHFpTmo5TzdlbitPTFhZM2t2WU4zR3hnVGM1UFZv?=
 =?utf-8?B?YjdMYnRabHJZdDZkNXlvblA2TTBsSlgxTlp0REtFWmtoN3lzM2xML2prbFMw?=
 =?utf-8?B?Wk1ZdlJ2VVZuZDdDSWlPZHlFWUJ1Y3FSaExtNmQvZlJxd0RaYXpaaWlUcU5t?=
 =?utf-8?B?bFUvbnJnU25QeEU3MTVXSG1EZkpBVTJzalVFcElYc2dHL1JIZUMwb1Y3Vjk4?=
 =?utf-8?B?WFlOcDJIS014NVczMjl5TzhLOEhESXdEYzAwclhJcnFXLy9POVh1L0ZWVjc3?=
 =?utf-8?B?eVVPZjdtUlhNa1BINzd6N1I1a3AweGJJV1N1ODI2ejRlVlBFbGhPZmo5cGQw?=
 =?utf-8?B?cG1ZNFhDeFJLYk4rVklONDZHV3RuNmtYc2VlTCszOTZyUVAxTWZxVmlwdkFt?=
 =?utf-8?B?eVl4R0lMSnhNMkpjTUZWbzkvUFluR1Fva1ZtNnV6MWlhenZURXBFUzF4d3JD?=
 =?utf-8?B?c3ZMUTFUbjBPMXVsSWZjbmJReEZLM2xLaGFicHQrMkZqNmkxV3NiZW45OEtp?=
 =?utf-8?B?eTRsQklueFNCYXBsd0dpcnk3V0xYQ3NBZWg2elY3SmFxU29DUXo4WWM3R1Qx?=
 =?utf-8?B?TnNZZG5iVGFHakk2RTVwbDBCOFJXME14YkVOdGgySlFScUZ3VzROb3VYbWg5?=
 =?utf-8?B?UjN2ekVNLzJvUjg2clgxZGJ6cEUva0M5dnNpMUljaENyUU1NT3RCajJFT0tZ?=
 =?utf-8?B?dHBoajZITUlqeDNnL2tST2d3blpuMndHWnpzaDJCWGRKcU90OHJldUhsY0h6?=
 =?utf-8?B?QThTOFY4NWRCQkpwRC95WnpsZlBLdWNNRW1GUU8rNFdaa0d1QWpGRzJiK1Bp?=
 =?utf-8?B?Y0Z1QS9zK0JHcWFUY21HQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0g0cnF1YmllNnVJQlcwZVY3Y0tDQ2ltb0l1V2YzWW5zWC93K2RjY0trcFdU?=
 =?utf-8?B?Mzd0ZHhJck9xR2F1T1pCM0UvV2RKQUJnQ01IVVpIc2N0MG1IVmI2eGJ0Mm9Z?=
 =?utf-8?B?MUtnalk0Z1JjMHFLdFlXYjFUS1lNSDlmYWIzM1djb0F2K1U1VVlkTkV0OExN?=
 =?utf-8?B?VTVMTmZscTRWVGsyelJGaEFGRGdadzEvaVhQeFg4R3dpSmJCTWxHQkRXejl3?=
 =?utf-8?B?UE1OSmR5UTVHVVphaDc3eCtZSDU3RkM3WUZaWXlaSkcwOEJxZmFKK1ZTSXNG?=
 =?utf-8?B?OWxKc01jOUFoaUpTMzZLVG9OdndXWmx3MndNV211YWZpTndLRzMwRk1mVGdI?=
 =?utf-8?B?d3JpdWRrUFdDVmpQWmlSQkw2aW5zWU5CTmRpd2gzWWlCZzVZazhzVmszd2V5?=
 =?utf-8?B?OFBlQnY1L2ptSUFibzBoeHFiWjZ0L0lkYUV4QlFVRlNVaHRtMm5kZW9TUXFC?=
 =?utf-8?B?dEU0TjZpeCtMMFdSaHpoc042aEt2SVZTWHdmaVNsVkJPcVlxS25BTU8xM3Va?=
 =?utf-8?B?dkFrWktqb2tSMDBFY2VWNzI2dXQ4YTZoZlRldFRjN2lZT2pBdXRBTmJtVXdy?=
 =?utf-8?B?Ris4V0tOTTNHdXM1TjFrWlByY1JPRC9oN0JhaGhObGhzMytiR1hKL3VteFpp?=
 =?utf-8?B?Y3R2bnZodHRhL2NFdVVuRHZXRHlzZlZsdXBwV2ZGaW9EYzh0dUJSaFZjSWF3?=
 =?utf-8?B?cnhDb295U1F2VlNwb1hKdDNzemRUSFZlUU1WdXZNZ0MwT3EzVk8weGZQRHlu?=
 =?utf-8?B?bE5WUHRXQnpOKzhjNDU3cWFmSWNpaktlOVZiNVhGN0JQN0tFNjNqU2JOS0NH?=
 =?utf-8?B?ZThKcndLSnRoSDZnSGY4MEdSMEF1UjAxMGxYaU50T09LMDh4N1Q1Rk1PQ2JJ?=
 =?utf-8?B?aVRKV2FlaHhIcEdob1dzSllIMlJDdlNPR2hZNHVnVnc2WjFSL2RWSGJxeURS?=
 =?utf-8?B?ckE0Sm5FYjJ1STU5Mi9DUjlWYlZLSnBGZGpYV0lxVi81WHIvWUxnOStPUVdD?=
 =?utf-8?B?VmVFWThvOWppSTlIbHhPM0ZyeXpKNkRrQVdIekMwL0VIV1lIOGF6ZmtraDZt?=
 =?utf-8?B?Mlk1c1BxY0VIM0RXb3BjOXF6bk5Xd3JXeVYzRWhQRlh3YWcyY25vQmpQT0dI?=
 =?utf-8?B?c3FlcG5ONGVOeTlqdnFHeVRQNDZNZUJzUmhyeUJwY3VJNnVOZHpDNDlrTzk3?=
 =?utf-8?B?TVRRc2ZVWmErbm90NHBTNlBrRUl0MitaWEx1N2poTlJUUE8yRFViRXBsbVZQ?=
 =?utf-8?B?QlA3cXVxckdtRitoeDg0TmZtd1ZlcUM3Vk42SlVWc0kzMHJuVWRjMnRVemg5?=
 =?utf-8?B?UlFlZTExOS9kN0V0cVlKSUpjQTVEL1VvdU9PN2hJdExWVXU3dU1CNUYxSjV0?=
 =?utf-8?B?QWJQRmhLQ1hCczZsT2xhWVBsN0lBYnNDUjRQdVZwWGFVNlo0T1Q4Z0tuTGwx?=
 =?utf-8?B?a2JNYlNKQ3dhcmtvRUR4TCtKc0JOV2Y4eWw1L3lyWjdyN3NVWnJhTHJ5V2ZB?=
 =?utf-8?B?MlpKclRZYkI3SER4b1BqUjQrV0RYdTNRc3lWZ0FIN1NzTVVOMGpnSXp2RnlP?=
 =?utf-8?B?VFV1MkhLYVVkQjUrYlViMHBQL1V5eVp1TVRYdjVHZVNFTCtkd0V4QTFmOHBY?=
 =?utf-8?B?RWRYalFRWDc2aWR0bm9SalFYRlN6ejhVS2dUbW9FdW13ZEdJWlE4dW1HRGta?=
 =?utf-8?B?UTZPVlpFWWZsbXVLTExBam56Qm1YVEJwQkh2S0RjblkrOFJZMHA2U2tJRFVN?=
 =?utf-8?B?L3hwSTA5clA2aUhrZVRMRGZlK0IzU0l6Rmp1a21zWGpOYjZwTnVQRUVRYTNl?=
 =?utf-8?B?S3prRzBhN2dyN0FPTG0rZVkwanc4L00wN2Y0dFVGRitUd2lYY3VBRzlsN3I5?=
 =?utf-8?B?TjJNVHpMR2FrWTllWXRKRHA5clpFQzdHb0VIb0s4UW11VVFFNGVSWDgxSzFt?=
 =?utf-8?B?QmFySm5tcmdIdHpDRmVUbjRwTTNkU3dzamZEbHgwOVZsMmZyWjZDV0pTN1kw?=
 =?utf-8?B?ZjM2K2tBOFF0emlpZWRZUmdlZXd1bkdKZmdTSS9LNFpPeGc1Z04zUE1jcXdE?=
 =?utf-8?B?QmNaUjk5aC9xZjVuUnY0MktoOE1LUEFSK1htaFdwclhRYk0zOEpEY1ZrQnZD?=
 =?utf-8?Q?20scmCH/gbGh+Umow53ogJMoW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01622f3b-54d2-4e1c-5107-08dca4e00259
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 15:08:40.2843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GozB/vRYZcROm1zd+ZHbOsMY9F3YPkYWGjLu9xr4hKhJ1LK7TS3oRVRTthXFG89X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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



On 7/15/2024 8:28 PM, Christian König wrote:
> 
> 
> Am 15.07.24 um 16:47 schrieb Jane Jian:
>> From: Lijo Lazar <lijo.lazar@amd.com>
>>
>> JPEG v4.0.3 doesn't support HDP flush when RRMT is enabled. Instead,
>> mmsch fw will do the flush.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index 04d8966423de..ea601047dab0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -621,6 +621,14 @@ static uint64_t
>> jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
>>               ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
>>   }
>>   +static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>> +{
>> +    /* VCN engine access for HDP flush doesn't work when RRMT is
>> enabled.
>> +     * This is a workaround to avoid any HDP flush through VCN ring.
>> Instead
>> +     * HDP flush will be done by driver while submitting doorbell.
> 
> I think that should read "HDP flush will be done by firmware ....".
> 
> Or is it really the driver which should do this? In this case the patch
> here would be wrong.
> 

That's a copy-paste mistake. This comment was originally in the initial
version of the patch.

Discussed with Jane and she'll be sending a revised version. Also, there
is a third patch expected which does normalization of register offsets
when submitted through ring.

Thanks,
Lijo

> Regards,
> Christian.
> 
>> +     */
>> +}
>> +
>>   /**
>>    * jpeg_v4_0_3_dec_ring_set_wptr - set write pointer
>>    *
>> @@ -1072,6 +1080,7 @@ static const struct amdgpu_ring_funcs
>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>       .emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
>>       .emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
>>       .emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
>> +    .emit_hdp_flush = jpeg_v4_0_3_ring_emit_hdp_flush,
>>       .test_ring = amdgpu_jpeg_dec_ring_test_ring,
>>       .test_ib = amdgpu_jpeg_dec_ring_test_ib,
>>       .insert_nop = jpeg_v4_0_3_dec_ring_nop,
> 
