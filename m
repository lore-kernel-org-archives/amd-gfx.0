Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1EACC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8458D10F53D;
	Tue, 13 Oct 2026 07:38:38 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D963710F53D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG2npTriw+TaG74V+fHeXG8imSnu5seSMckx7S878Bj6VNq1rsX7AT/n1V5Dt2008UnnI1VvuZtjxI+YEuej55jGG0lOEC7PuhaVKqDsEZ1dZe5Fdvdi63Yj8OeevlylpUxyuDlsDTp5tXl7Wt3v6/0BSjsmKDaQY9exXuEf3hn5tmCIS7Ih4hJPwzimOFBrq74kdxs7afkHom3W+AmNQatD9xKjDFNBLEvmHT1DtH84hkBstXlY1Pf+bZsgaVIlRHIfHKMHN8wXlZdmZ8fqrcGm7cnkntje1PR9nBVL9y/iNG29J0qBGUp8JE2If8lTEFc2uqZNmZxfLCBI8g33Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2CA7aHBlhCGzKxUAYIdsNagaX/qnycFRTeNtCl3fJk=;
 b=YybQM1KVFzB5HVRMLSKIhmCfImzdnOXN01Ez7OvJHNuELLVSI5fFSV187d2OQucRS+hriR2eLV5NaJVlEqRmmh5sxuuN43xQTq97Hew/19fIrSExo4lDNmIr6MxfpCng3rAXZr5tb4vh4BDbb7Lejr4TLY30eW0xhXi6As2JBWDFyBbQhdI2EWV4BgP2zJgwZQXt930WgdnBG2+BjwQkrxoGw30VuVgDYVtX/N4i+Iswh3nSkVvQZt59YMaD8adyChvqlXaui8EQ7fsotpjZ3WzRwI76U+IawBenHnZxkO1mq6MJdi7I/BTQI1Fb0x+SoEI8dkQ/nXUfKlw4ulRWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2CA7aHBlhCGzKxUAYIdsNagaX/qnycFRTeNtCl3fJk=;
 b=pToEzxhGO2y3Kvonfe3uFpwplmj7WnpoxUzqPeVNZqQ1Q5cN2eUXQVnTaYP+A7eRhvvpVoX9uF+6VNvaRNPOlnvKTPD51bvwFeANnL6Vvlo8uh5ghY5ZQAsnVLkQ6I1WhvtadWkNrosQazQB+HcMEl59Dmq64YFEZlAaf8bd1rg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:37:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 07:37:51 +0000
Message-ID: <20ddb9d9-9d24-41ab-8e18-026cf9fc1384@amd.com>
Date: Tue, 13 Oct 2026 09:37:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>, "Ma, Bing" <Bing.Ma@amd.com>
References: <20260925093718.2737342-1-lijo.lazar@amd.com>
 <SA0PR12MB7091927251394D32F43248A7978D2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <6180206a-85c3-4d64-9c40-e22094176e71@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6180206a-85c3-4d64-9c40-e22094176e71@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: da553727-9556-490c-43e9-08df28fce29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: olZ3FveFqNZwHC2YFrCZ3AIFTqbuly+lZUSkzZQLwG2Ef7Uo4xw4m8B95EhcdLkjJ0chajueJ4W7iStmIHUjsS6yFiw7YgA5F/jEjbvW4yT1+YxFdi3AtblUE2jLj/QDck8k1DP1muRQa3HkLgJr3FL66xhgdPbfxM8jFmvhHWcoxK2YLz0J85uX33Ud4KU5YrZniddL+yvToXcYEShKl6huRMHbAXEi+nxg7iehCCmTYpVNTEoTzwQ6fQfUV2mbVdPaO6JuKzwPSzGuH8GODnxmULYIQVZ+68Sg+vA8uV/8FIEJlUBNSo3YmYhUdsAFEog+C3p1c4lbCjDf6IkTO5xao8xsbG6mAevLbs6vo9nWhWfdeGmNoeN4lr/S13JcShWHndMrW1GU23txwhXiFUoYfg6f1pAjDkf8dX/DuUhgTr8JbnvNE+B1s69MMxMXcEloYQayE7azBDXX3hxNtDO+2/mxYiOk5vC4HfWP5T6mK55YR922VwlzOF5WabxMBp9+KbsGw4/DUsk2iEffuC9m1eDBlnFzAfd2YxDsIqLoPwiZQktsJkR13TKCDwDBQ3nykgdOAyeR6wKK1atE1t+dtD++T663KTU97IQaehvTPZKrO8aiq20n8lqJoAngRkRQHrxwYVA/o0IAYMKrWC/nLMIhU5TX705e10cdnHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhQVkFIL0M3YUdzdS9CWTdzbVE2b1k1QkYwWnAxbnlDRmVadGpQYnJKODJL?=
 =?utf-8?B?VEtMWHRvVXhrZk4zbk5sT3QyV1R5WFlOYkVkTElNeVV0aHJyTUMycm1TMHhq?=
 =?utf-8?B?RnZjM2oydWUwdy8yQVBpblNQREdWdGV5SjlZbUl1eTFqS3h5RlB4OSsyT3VX?=
 =?utf-8?B?S3hmU0l1eTcrZXhYWEttVW5QYlNRMDl5RmxEYXpsSm1DWXdVdVgxQ2NEWlR4?=
 =?utf-8?B?b21mbHZQR2FSVXNuMkhqU1JDSzZCWHhTNjVIR3ByeHBrSHN1UTJuT1l0WTVj?=
 =?utf-8?B?V2ZGTGFyUEVJYmpldk9sOFZxTlhNSS9oYkZNT3praEtVcWFYL0FwMHhXVkFU?=
 =?utf-8?B?cWZ5bmNPL3grMjZldUNxZGloY0FGa29wcUt1OW9LaHNNUnJrdlpsNThPZ3U4?=
 =?utf-8?B?N1o0Y3l2b1E2dlBUMkZYcmVnK1l5U3lCdmppdkxCbE9JelRlSDY1QU9GTWlh?=
 =?utf-8?B?SFc0YjVFQ3NYN05XMVpQZDd0T3RydEdFd2NXalBnMk9SRy80RkMwNHFpMGRn?=
 =?utf-8?B?OS9vS1AzL0szejdRVG5nQlpkRnBqZ0tCelN1bW5kazhxU3RmYXZQakQ5RHZx?=
 =?utf-8?B?L1lVVzJzSlEyWnA2K1VIN2JHQTBXejdZU2lnOFU2aCt5bTZYU3ZZeUpDTlRO?=
 =?utf-8?B?RW83dlQ2QVBka0FoaGtWVFNRakpQMVdMRWtGSHdqOFo1cElpTURyZHZUTExU?=
 =?utf-8?B?RC9yKzYxZEkvc0pBNnRrelJRNTA2NGpOT01pK0xRU2RUMXUzeGJrM0dMZENZ?=
 =?utf-8?B?azNNam1mMzdZK1M3cHViemVqVVp1b1dmZjBCV2RiT0FWKzlMRkY5Z2VzUVlz?=
 =?utf-8?B?K29Nd2VkZ1F5bldxcmQ0Zy9WRGc3bWQ0Ym5lVmROUFZQY3NMMHNybWNrM2VS?=
 =?utf-8?B?bDF3blBTTUo3VFhYQ1kzYUk4TXViVjVFU2hHdm5kZ0Q0VW4vbWZOb2k5aXdv?=
 =?utf-8?B?S291cHZCVmpmV2lMa1Fxb3hqVWFCSUdpZngrb0twb0R3WFIvMHZ2d0c2N2M3?=
 =?utf-8?B?aEZQOEE4QzFCRnRxekdya3hWbGN1Y0dRM2gvT3lTNm50K1paMExzcVZYSzZ6?=
 =?utf-8?B?eExpRlR3Vm1oYlRQU1Rmcm5jT3U2dXY1SzA3dnl4UWJCbUhDd0hVYWQrd0hR?=
 =?utf-8?B?VTNjbnNvS3pKbHUyT0grb3RoVGpPcVF0b052a1lxRTBpd3k1UHRmRVRhd1g2?=
 =?utf-8?B?RWs5Z1BhN2hEMWEyUGZXYWdZM3ZqYUxiS0RqZlB4Rkp3NnY5VmQxeVJYRGxF?=
 =?utf-8?B?em13MG8wT3p5eUd1MU52S3hrd1p5WXljME9yOTMvdGZtMlFDWkwrMXRnWTJL?=
 =?utf-8?B?ZHkvaGhVclZlY3ZQbnlNOC9BQ05STyswTnNmNWZQYW1uRVlNVURDTkFsT0hH?=
 =?utf-8?B?QytoZ1FraG95dDMyRWNXMTlrVHZVVnFPWGRFdm0yaGZtZmF1WVV0b2Rkd0l5?=
 =?utf-8?B?cDdTT01lY0NyaXpzM21qdHlhYUhKWDJZbksrT3dMZno1dFpsMGtZMG84dlk2?=
 =?utf-8?B?SEwvSkpwMUtDc2UxTThwbDB0Y1IweHBPUmdxOHJWclkycHlPL2pFTk40VXJP?=
 =?utf-8?B?OGRwWGhiQTY0ZGlhMnpBU2RqcjZYeHNyNEozcnRaQzFoQWUvZDBwK3did2V4?=
 =?utf-8?B?T0dyMmFLSDRlWmZWR0JkeExWZzV5OXU2aG9uMkJ4czl0dERqbkRlU3ZBSGR5?=
 =?utf-8?B?VC9sYm9qaXRsSUw3VUxhbTZTMVBTZkd5NW1CUVdiYzZjOU5mN0JFaGk4d1lL?=
 =?utf-8?B?bEYrYWRpVjVXQ1I4Vjh5bFNFT0p2Vis4TFZCTkpqUDVQWXJsNFphejdiRGlS?=
 =?utf-8?B?TEk5ZmlBbnFueE44bmdqSkN4VllRL3hYMUFlU09XRVMrQTU0eFZMTEw5d3Vl?=
 =?utf-8?B?RVAwN254MGY1dXlEL3IyTW1ONm5CaTdlLzFseGV1SjNjV0p1YWtNOFQ2MFUv?=
 =?utf-8?B?M3A3REtNVXRIaEl5WlB1NklyWUU0TGlaMXdWSUtPMFpJQXdZTVNVamN4eDhk?=
 =?utf-8?B?ZWhNRzl1d0NnekZ6aytNZmtFKyt4YWs4TEp1ZDZ0WFljMGFWQng3S29ya2hU?=
 =?utf-8?B?SS80MEJ6UHNlM3NJR1A2RFZML1FqUFREc2dVUzdKa3UrL0tMNjZaQXdGeGVN?=
 =?utf-8?B?M1ZUKytQR0dhSnNnK2QyTlRjSXlHNzV4dHZLWlR3WTIxeVpwT2h1Ty9tNzNs?=
 =?utf-8?B?OHBLWklkYjhnRWlXS3ZPZHdBNkRneEltWitpUkdUazdicEhlVm9XbUZyaENJ?=
 =?utf-8?B?TTNRRmRhT01FRlJVV2NBT0ZUQjNzR0U0SERLcHhGOElxc0JjWEZrMmlsbTdN?=
 =?utf-8?Q?AqOtFspJlIFE3bTPwG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da553727-9556-490c-43e9-08df28fce29a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:37:51.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wd+kXji3+c5Yk/wWIHFynMShji+LfvXzHMsZ54T9o4SXcotz4Z8PYi+cNh7auM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1
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

The patch looks correct, but I've just reviewed the patch from Sunil to completely remove this code.

So I'm pretty sure we don't need this change any more.

Regards,
Christian.

On 10/12/26 17:28, Lazar, Lijo wrote:
> <Ping + 1>
> 
> On 28-Sep-26 7:19 PM, Lazar, Lijo wrote:
>> <Ping>
>>
>> Thanks,
>> Lijo
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
>> Sent: Friday, September 25, 2026 3:07 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhu, James <James.Zhu@amd.com>; Ma, Bing <Bing.Ma@amd.com>
>> Subject: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
>>
>> RLC SPM is updated for GFX subsystem related performance counters. Only jobs on rings that use GFX subsystem need to be updated. Some rings like SDMA could be inside/outside of GFX subsytem based on SOC. Identify the rings using GFXHUB assignment and use hub id assigned to find the right GC rather than relying on xcc id. xcc id may not be necessarily assigned properly for all rings.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 31 +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 ++  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 +-
>>   4 files changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 0f8b097001e3..6ea73ef6e672 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -212,7 +212,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>           amdgpu_ring_emit_pipeline_sync(ring);
>>         if (emit_spm_needed)
>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>> +        amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
>>         if (emit_gds_needed)
>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
>> index 002fae3c380e..f791e1bcbf17 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
>> @@ -27,6 +27,37 @@
>>   #include "amdgpu_gfx.h"
>>   #include "amdgpu_rlc.h"
>>   +/**
>> + * amdgpu_gfx_rlc_update_spm - update RLC SPM VMID
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @ring: ring the VMID got assigned to
>> + * @vmid: VMID to program
>> + *
>> + * RLC SPM counters are used only for GFX and GFX Cache subsystem. Only
>> +jobs submitted to
>> + * rings in GFX subsystem need to update RLC SPM counters. Derive xcc_id from ring->vm_hub.
>> + */
>> +void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
>> +                   struct amdgpu_ring *ring, unsigned int vmid) {
>> +    int xcc_id, num_xcc;
>> +
>> +    if (!adev->gfx.rlc.funcs->update_spm_vmid || !ring)
>> +        return;
>> +
>> +    if (!AMDGPU_IS_GFXHUB(ring->vm_hub))
>> +        return;
>> +
>> +    num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>> +    for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>> +        if (AMDGPU_GFXHUB(xcc_id) == ring->vm_hub) {
>> +            adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, ring,
>> +                                 vmid);
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>>   /**
>>    * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> index 959d60c90dcd..1410954da5a6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
>> @@ -370,6 +370,8 @@ struct amdgpu_rlc {
>>       struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl[AMDGPU_MAX_RLC_INSTANCES];
>>   };
>>   +void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
>> +                   struct amdgpu_ring *ring, unsigned int vmid);
>>   void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id);  void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int xcc_id);  int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 29a66e39f3d6..dc8f85176b8b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -865,7 +865,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>           amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>         if (spm_update_needed)
>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
>> +        amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);
>>         if (gds_switch_needed)
>>           amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>> -- 
>> 2.49.0
> 

