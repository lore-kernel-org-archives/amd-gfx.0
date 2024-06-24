Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B0EC2D0D1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 19:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126E910E0E2;
	Mon, 24 Jun 2024 19:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zrPDD/yE";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF16710E55A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 19:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF2sG5H0Rle1hS9KutgiWQsfth0hSlD9eiTEROK1YMt4m1W9ThqJJgjROuzrNb48N4fWVPew/9gnFuvpbF7SWaxEBfHTJkKbQvUntSTuZrDVEpEPvjRJpCTd76XpqjW2wckbr6BxU05uroii5PbV4K4iEzd1uiRZw4GpdQURur1rBywWA8HYKqeX1OVzsudYBb/6SgCPsl489DgS9UO68YbnkrT1mQpUIFlnLSsvKCocbTJVLQV0P/mRFNaESG5+SPeFQi6Ur0nwCC/5w0p0JVjPWqfcrIUUerDKFpSqSvFCA1ejsOmhQHXSdxwHlsS2RzDjy1Gf4V8DOrzBF9g7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9oaSUuJdo0YIDGEvjR8FqPO+M/WiZuQC56CcKd8Cvg=;
 b=FfbQNIEG03mHhjuL/cLmc9LLfOBhW4gdVXz1/9aajNdY0AxsSaA3pNc18ZIujDvcXjoZiKzUDoG1zPBFFe1+ehuuXORqrUjv4IXBr0gZyxwP4AtcR4DUMfPRBvvNHdViSnWbbMuDjqZUfOpROYob2w+/oPSPjOgAaXRetcsToYFknw99VbBPxZIyHbJwidYcPKZx2CU1W9PXMDVJa2+OhGCEqcxVcW4sEKQaQEmEQTEciyxZb65bcWarO3fD7HvCd+BcFv2j3Jqkvaq1eTggTL/HtIqiWYv9UZBjcycd+FB+/YjJAZyuAhJnjL4elE6WPFDkQMQAxvAe8oq/AwE9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9oaSUuJdo0YIDGEvjR8FqPO+M/WiZuQC56CcKd8Cvg=;
 b=zrPDD/yE2e8V8pIpQPVmOWpuiziOl2rKcbwOrW5ixSpV1qWecNNNNoyHi7M/Yl/una4NgxHG9SsxQapLdp2y2+UpUjKTmjG94ewqMfPHicjVKKUu6WGZF9PiKYTC+gQdzUz8quyw1GMxdcxyZxaGr/S5LFFRuO60CBsdw0MHb7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 19:09:22 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::eb6c:c1fc:66f2:1ca]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::eb6c:c1fc:66f2:1ca%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 19:09:21 +0000
Message-ID: <b50126ba-4206-4acc-a3b1-a02cfc89d4db@amd.com>
Date: Mon, 24 Jun 2024 14:09:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Correct svm prange overlapping handling at
 svm_range_set_attr ioctl
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20240621172823.168595-1-xiaogang.chen@amd.com>
 <4ba31ef6-951e-c891-efe8-dc97470d29e6@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <4ba31ef6-951e-c891-efe8-dc97470d29e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::7) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: b2178451-a91f-4076-a02e-08dc9481275a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3VFK21ZUkhLam9IcmRhU2JYUTFPUjVOdzNjM0NlU21FRGlZQjNJdk9sU1F3?=
 =?utf-8?B?cWtvTjZWaGF3amxGK0JtNHFxcXZnNDlRVWY5YjhLY3NyamN4WGorVXFSR0cv?=
 =?utf-8?B?YVNqTnNlZENDRDhscmY2bmRsVFpZZUJjc1VnMzhVUy8rQVRKOXhOUVJOSnVk?=
 =?utf-8?B?VFdmUkgxNU9MM1FESldzbWxYTGRNRUdFa3lvRnM4OVU4KzJ2WDdQL09LSG9u?=
 =?utf-8?B?c0ZyUjAvWkg5M09IKzJBQjVybEIrU3k1NVhDR3kyTHlFTnRSYjZiZFFaNWVo?=
 =?utf-8?B?VDU1WVhGVkhQMlZNN0MzM3VqRm9jWFZkR0ZkR0M2S1Zoa3pZMGgyZS9TOGdT?=
 =?utf-8?B?YytWVXQ2SVhWa0Y1bVZEM3d6WGo0VGREQ1dpMVIwaDFvQXhWclVDb20zZnpV?=
 =?utf-8?B?c3gzRWkwb2I5NHd2c05qZDBEM0lWNGZ5UEpoTHkzR05GV3ZIK2plQ1dva05H?=
 =?utf-8?B?WEtrZ3p5YkNNN3RSQi9WMmZSMmRESWRMWENFMmhsTVcwSW9saEFLZzNmL1I2?=
 =?utf-8?B?OGc1WDVRdnUzc3ZiRnN5cERiTnM0TmY3LzRUZXRvaHpNa2ZxQ3RhblJERG1F?=
 =?utf-8?B?RmpzZnVhU2ZqSnVxN0YvcThndVNNcFZ2VDV3S2Y2NldrZUFyMnlHU1dSalNX?=
 =?utf-8?B?dU1LWlZZQ2tTZDZ0d0xjTGIzNkNoOWFWdkQ0akNUNDR1VTdTZDhSdFBGZk1X?=
 =?utf-8?B?bnpWREE1NWh2aWkrM1pwRzFtMGVkK1BKZnVUS28wdFltak1pMmdGSUdCZGxY?=
 =?utf-8?B?YlVxSnppRVN1MWFHUENHTmVleFUxL25LbEowajNTRi9VZUo3RGM0ZEI1WlhW?=
 =?utf-8?B?a3pKMmFVVjduUU9zRERISEljN25iQm15OFoyK2l1TW9UWHJ1OXZ3VWtJVTVL?=
 =?utf-8?B?bEZnZllhOGxYeU94MXlHdFR6WTdFWDdsRC9QemcyMU9FdFhWSHZrT1RNR1Bt?=
 =?utf-8?B?OW83TXVQbzMwRmhCbG9hMGMzWlhXd0hiaVIxSTh6aFgwZ2dMeUcxbUZiRGYw?=
 =?utf-8?B?UXJEdTRQU0NPQVlCOEFDUG1nVHduejlzUG0wYXJtMFpwM0tnQlRoWDJzZUV6?=
 =?utf-8?B?N0NQMnVpL2ZQN2F5Y2w4RE9OUHJlS3FnZ1NUMnZURjdSVDRqSExROWdUbUNj?=
 =?utf-8?B?Q3FRMGV6UG9wY0s1UjczNU5rNnU1SVE4ZC8wZmtVdGN6cW9vR0VQa2hzZ3JC?=
 =?utf-8?B?dDJFdkYvTUh6RW1zRHpZU3lNcjZLTFFVNnQ1REc2K3RzNXBHQWw5UXJOc0dp?=
 =?utf-8?B?d01jNVlkVmZOeGlKQ3ZsWnNLbzdxSG5oV3hsV01mNitpbnkwMThTZFl6d3FH?=
 =?utf-8?B?eVJqczhrNUJGYjZKRll0ZjErWVIzN3dsVjNIRW0rZTk0RzlzZnpzMW0yemlY?=
 =?utf-8?B?YjVKb3FwNnlqTFhpZEtjOXhEcUphSzJlb1Yyc2Uxd2JaUUVmL09NVWcyUkdG?=
 =?utf-8?B?Q1V5QVRtVmR0eUhGRjM5SU1pNjdjUGJzdXczeTQxUnVlWnorZ1Ftd0Q4OUV4?=
 =?utf-8?B?VTZySGRxbmMvM01Dd3ZEN01JVkdqVFJpUHBGSkhEV1BYSUdFeXlmU0p2cGE0?=
 =?utf-8?B?Zk0wREMxaDJHNzc1QW8waHpHK2ZLeVR6TGZ2MXhIOVhMWXE4cDNKVFM1T1dZ?=
 =?utf-8?B?Wk1lTjEwdFdzOTE3YzBqaEc5dnd5YWZJQWM0NVR2VnkrTzNsU0U4cHErUmRN?=
 =?utf-8?B?eGM5TkdjNFdzTkUraDBsRHlIL1FlcHFXcWhNZ1V5V1VReDdvS3VzRlJiTlFP?=
 =?utf-8?Q?MUyybEQj3CK+SUQt7Wzm1tLvL9/BDqHGAf67XYe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFB2bmVGVFRuNTdKM3lWVjB5VGIzczlWWUhaVGUxM2lpRGVJRGJXQ3R2K0sw?=
 =?utf-8?B?M3AzMzJzT3Azbm5vZlQ4NVRFZkFBSDlMeUN4L2JjaERqTUl2MjN5U1FEVnZL?=
 =?utf-8?B?aXdPQlFNWjh0WnlpdzhNUVRFMjd6MXM0em1SY2ZNTkRmY3M2OGwwS2xvS0VP?=
 =?utf-8?B?Z0VQZ2ZmQTRQdHZJejNWcEUrL0dPYUhjN2tncnJuTWhhTndxZVlPOCtzS1dJ?=
 =?utf-8?B?R1J2NUY1ak9DcFc5Ylc2YVJMMkt4b29KRzl3V1ZZRm5neGtaWlBJbUVOblFz?=
 =?utf-8?B?R3k4Nmd2ZXZRVG16U2dTV1E2d0dXcjViaCtmSHhrSGFtRFJlNGJGeklMTHNB?=
 =?utf-8?B?MVJ3WTVSMHcwajJ3NG54WGlEVDVGV2RMcDhNWTVMZmtJK2YrS3hwa0syNWdG?=
 =?utf-8?B?WFVDVTNqS1h5U0pIR1doR1pITVN0TW5uOUp1N3NXTHRnRDA0S1pOTHZDTGYw?=
 =?utf-8?B?MXpEZGhpZ2pRWFdwalVBU2E0UmMvdG40NklsaEdJY0xpdjI4Ym1GcHNIc2JE?=
 =?utf-8?B?S0Z2RitHY2lvRlIyam9JcWNzTmhKajZnWGlhMy9mSkY5cXRwZzVucU52ZTgy?=
 =?utf-8?B?cjF2VjIwaWhLNTAyMWsrZGhEZGN2dDB6Z29WeEs2TXBSY3Q1TVdTeTBpSG5h?=
 =?utf-8?B?ZHBPWHI5M1FLWWkyUjdPdkxkclJZUzh4QnhYcFA4NFBTRERtTHV1SDJHZWhZ?=
 =?utf-8?B?cEpSOFVtdEJNRzRsTHl1NTJlQ1puZ2xBVGhHZXJGdWdteWhkWCtDZ3RDNzRI?=
 =?utf-8?B?QjBleGdSSHpMdVd4allqMGVJd09KTGZPNnhJYlB0STFBS0hJWUJ1U2UySHRp?=
 =?utf-8?B?UHFZcmt0MUE4ZnR2Q3RnUW5zdVd4dkJhNkViaTRBVHRDOVlWZC9yNm5IVk1D?=
 =?utf-8?B?cVJZQkxSeGxGR0tmYUtNL2FCSjBPZC80UUR1SEU4SnFBczRxK3RiSWcrQkFq?=
 =?utf-8?B?SE95eldQT2t0c2doOGpObTZHSHpxK3BVQ21FWmNhNCt6ZUxRNXBSUGhJaEEz?=
 =?utf-8?B?TzByMXpTcHAxK1RONE5oZDZsanVPNWxxZ3RJc3VZendpNERPK2R4WlJIZTBz?=
 =?utf-8?B?OEJCOWZJVW5XRXlUSTlXaXZOamcwVEYxUlZrSWZUcFNPRFpNVEN6KzlsWEdp?=
 =?utf-8?B?T1ZQTTRRY3N4aDIrc2NKY1k2RXlaL0NzdnVTQWhTa3RKbjlodzNGWE9jR1cw?=
 =?utf-8?B?WkE3bmRUSGZocE83WndBR2lob1lQSUVlK1ArYXNyYWJScFlGaUhnTFFOQjNK?=
 =?utf-8?B?VkVQN0tzMjFEREV0Y25ZNVJUcFQ2ZGdNYmtUS2g3WjN2eWE0Q1l5Q0t1L3Bu?=
 =?utf-8?B?Tzh5QU9saVk0OVQ0VnJsMUNoWUFJZ3R0UHZvRFV1OTZaQTljN2RYZW5VU1Bx?=
 =?utf-8?B?MldxY2F1cWFZd0phdkpaTTBvYTlFeEFzcjZ0SzdJNmtPY0RoK0FRcHVldXZ4?=
 =?utf-8?B?ODVCUHlTM21qWDk4MXkwYzR2V3hHeFAvNVdlK29uTGZ1SXBGdkhybitxclpO?=
 =?utf-8?B?bzF6akRZZlI5UE9EeVl0RVZmR3MzOG9ORjA4MVROcXVZUWc4L0U1cmxRMzhp?=
 =?utf-8?B?Z2NJSUtLdlkwMExrZFRvdjlhL2NvQ0JvRXZtSy9YMFpqdlJ3SGk1U0hIM1Bu?=
 =?utf-8?B?Mm1IbHhxejFrcEdxYXZjRmNvSUwvWFhYL2UydzU4VFdibVJ4TWtQWGpHaFhY?=
 =?utf-8?B?U2hxT2Z0ME9mSEtwb1EwNVFaRHRhbUl3VUVNU0xqZlV6K3BxeXorNTlSajhX?=
 =?utf-8?B?cXZQNlQvZ2VMMCthNDJYSnh4cHRIUXVsQ09NdUdKKytKWlZjZVo4cmEyZjJN?=
 =?utf-8?B?TVJubjdRZ0NtWlo5eUZUZEU1V09TazFmNysxY240Qld3MlEyU0QxV1VxNkdF?=
 =?utf-8?B?U1FVRU94eDBvRCtDT1haNXc4TkQ3eXR6UHdydEdtWTdkSndJY3FYL1MxaGFR?=
 =?utf-8?B?Y3RxL2dpSlJrOHFwZWFNN25XME9lSmFCQmdmd3hWZmVsMWZ3MlpJTDhPYnk1?=
 =?utf-8?B?OWw0Y1NleWZxYkN2eUtyaEptYmY0TkhldXFjOUl5ekpWazdpTitsL0ZKWVph?=
 =?utf-8?B?MktBMUwzK0VCakpCZHpubXZKYjRWTFNUTUVqVk5vQlNEdjhTMHpFMnFEUUFM?=
 =?utf-8?Q?f0fQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2178451-a91f-4076-a02e-08dc9481275a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 19:09:21.3001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lId9B0uUu2oTrd5zqvx0NCSUV+rUmPUI2Y6UpPK5cBQCANGJtynUfNj4msOUXKRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
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


On 6/24/2024 11:17 AM, Philip Yang wrote:
>
>
> On 2024-06-21 13:28, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> When user adds new vm range that has overlapping with existing svm pranges
>> current kfd clones new prange and remove existing pranges including all data
>> associate with it. It is not necessary. We can handle the overlapping on
>> existing pranges directly that would simplify kfd code. And, when remove a
>> existing prange the locks from it will get destroyed. This may cause issue if
>> code still use these locks. And locks from cloned prange do not inherit
>> context of locks that got removed.
>>
>> This patch does not remove existing pranges or clone new pranges, keeps locks
>> of pranges alive.
>>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 89 ++++------------------------
>>   1 file changed, 12 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 407636a68814..a8fcace6f9a2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -904,23 +904,6 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
>>   	return (void *)dst;
>>   }
>>   
>> -static int
>> -svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
>> -{
>> -	int i;
>> -
>> -	for (i = 0; i < MAX_GPU_INSTANCE; i++) {
>> -		if (!src->dma_addr[i])
>> -			continue;
>> -		dst->dma_addr[i] = svm_range_copy_array(src->dma_addr[i],
>> -					sizeof(*src->dma_addr[i]), src->npages, 0, NULL);
>> -		if (!dst->dma_addr[i])
>> -			return -ENOMEM;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   static int
>>   svm_range_split_array(void *ppnew, void *ppold, size_t size,
>>   		      uint64_t old_start, uint64_t old_n,
>> @@ -1967,38 +1950,6 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>>   	return r;
>>   }
>>   
>> -static struct svm_range *svm_range_clone(struct svm_range *old)
>> -{
>> -	struct svm_range *new;
>> -
>> -	new = svm_range_new(old->svms, old->start, old->last, false);
>> -	if (!new)
>> -		return NULL;
>> -	if (svm_range_copy_dma_addrs(new, old)) {
>> -		svm_range_free(new, false);
>> -		return NULL;
>> -	}
>> -	if (old->svm_bo) {
>> -		new->ttm_res = old->ttm_res;
>> -		new->offset = old->offset;
>> -		new->svm_bo = svm_range_bo_ref(old->svm_bo);
>> -		spin_lock(&new->svm_bo->list_lock);
>> -		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>> -		spin_unlock(&new->svm_bo->list_lock);
>> -	}
>> -	new->flags = old->flags;
>> -	new->preferred_loc = old->preferred_loc;
>> -	new->prefetch_loc = old->prefetch_loc;
>> -	new->actual_loc = old->actual_loc;
>> -	new->granularity = old->granularity;
>> -	new->mapped_to_gpu = old->mapped_to_gpu;
>> -	new->vram_pages = old->vram_pages;
>> -	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>> -	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>> -
>> -	return new;
>> -}
>> -
>>   void svm_range_set_max_pages(struct amdgpu_device *adev)
>>   {
>>   	uint64_t max_pages;
>> @@ -2057,7 +2008,6 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
>>    * @attrs: array of attributes
>>    * @update_list: output, the ranges need validate and update GPU mapping
>>    * @insert_list: output, the ranges need insert to svms
>> - * @remove_list: output, the ranges are replaced and need remove from svms
>>    * @remap_list: output, remap unaligned svm ranges
>>    *
>>    * Check if the virtual address range has overlap with any existing ranges,
>> @@ -2082,7 +2032,7 @@ static int
>>   svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>>   	      struct list_head *update_list, struct list_head *insert_list,
>> -	      struct list_head *remove_list, struct list_head *remap_list)
>> +	      struct list_head *remap_list)
>>   {
>>   	unsigned long last = start + size - 1UL;
>>   	struct svm_range_list *svms = &p->svms;
>> @@ -2096,7 +2046,6 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   
>>   	INIT_LIST_HEAD(update_list);
>>   	INIT_LIST_HEAD(insert_list);
>> -	INIT_LIST_HEAD(remove_list);
>>   	INIT_LIST_HEAD(&new_list);
>>   	INIT_LIST_HEAD(remap_list);
>>   
>> @@ -2117,20 +2066,11 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   			/* nothing to do */
>>   		} else if (node->start < start || node->last > last) {
>>   			/* node intersects the update range and its attributes
>> -			 * will change. Clone and split it, apply updates only
>> +			 * will change. Split it, apply updates only
>>   			 * to the overlapping part
>>   			 */
>> -			struct svm_range *old = prange;
>> -
>> -			prange = svm_range_clone(old);
>> -			if (!prange) {
>> -				r = -ENOMEM;
>> -				goto out;
>> -			}
>> -
>> -			list_add(&old->update_list, remove_list);
>> -			list_add(&prange->list, insert_list);
>> -			list_add(&prange->update_list, update_list);
>> +			list_move_tail(&prange->list, insert_list);
>> +			list_move_tail(&prange->update_list, update_list);
>
> The main purpose to clone prange is for error handling rollback. If 
> removing original prange from svms and update it on insert_list, how 
> do you rollback to put prange back to svms after splitting prange error?
>
> We hold svms lock to access prange, so it is impossible to access 
> prange after it is removed from svms.
>
ok, if purpose of clone prange is for error handling rollback when split 
prange has error I understand.

This patch main purpose is not destroying pragne locks(prange->lock, 
prange->migrate_mutex) since this prange is still alive. We should keep 
its lock contexts. The cloned prange creates new locks that has nothing 
related to original locks. So I think we need swap original prange with 
cloned prange after cloned prange split success, with same internal data 
member updates, then destroy cloned prange.

svm lock holding does not mean that prange lock can not be used in other 
tasks. And at svm_range_add we do not remove any prange, but split it, 
then add prange with new split-ted pranges to svm.

Regards

Xiaogang


> Regards,
>
> Philip
>
>>   
>>   			if (node->start < start) {
>>   				pr_debug("change old range start\n");
>> @@ -3533,7 +3473,6 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   	struct amdkfd_process_info *process_info = p->kgd_process_info;
>>   	struct list_head update_list;
>>   	struct list_head insert_list;
>> -	struct list_head remove_list;
>>   	struct list_head remap_list;
>>   	struct svm_range_list *svms;
>>   	struct svm_range *prange;
>> @@ -3563,10 +3502,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   	}
>>   
>>   	mutex_lock(&svms->lock);
>> -
>>   	/* Add new range and split existing ranges as needed */
>>   	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
>> -			  &insert_list, &remove_list, &remap_list);
>> +			  &insert_list, &remap_list);
>>   	if (r) {
>>   		mutex_unlock(&svms->lock);
>>   		mmap_write_unlock(mm);
>> @@ -3574,21 +3512,18 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   	}
>>   	/* Apply changes as a transaction */
>>   	list_for_each_entry_safe(prange, next, &insert_list, list) {
>> -		svm_range_add_to_svms(prange);
>> -		svm_range_add_notifier_locked(mm, prange);
>> +		/* prange can be new or old range, put it at svms->list */
>> +		list_move_tail(&prange->list, &prange->svms->list);
>> +		/* update prange at interval trees: svms->objects and
>> +		 * mm interval notifier tree
>> +		 */
>> +		svm_range_update_notifier_and_interval_tree(mm, prange);
>>   	}
>> +
>>   	list_for_each_entry(prange, &update_list, update_list) {
>>   		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
>>   		/* TODO: unmap ranges from GPU that lost access */
>>   	}
>> -	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
>> -		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>> -			 prange->svms, prange, prange->start,
>> -			 prange->last);
>> -		svm_range_unlink(prange);
>> -		svm_range_remove_notifier(prange);
>> -		svm_range_free(prange, false);
>> -	}
>>   
>>   	mmap_write_downgrade(mm);
>>   	/* Trigger migrations and revalidate and map to GPUs as needed. If
