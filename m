Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEF8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C251610FDD2;
	Thu,  2 Jun 2022 13:36:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F90610FD37
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSStm2M+7q9ytCsTgah8niUSVl1E0kv3hZluDeEhuOWbJ/j3pdcQbSOXQQMX5nVX+M/LqN6HamZFAvl4bUbR+Iti/gFL1g2XxxAInlR8322j0c5d/mEcHO/Dd/QbLlNuTB1Hbdit9JP+0rARh7neleF3X61G+fgv6qenlB4WULnaTE2HYGWYYgzvd6hQdZc1QEVBSUOrh+rl1YvrcyWCdZ0nr2m9gBpt1ReUwd/AXv+REqUWDTqOUbwIGXEAKjSc3Ik95p5Qjmb4cIA7Afh/gGdUYhhEmDQcjzDzy4Z2N2zewqdcvmV7Td4mxqlO4RyShJV+QYH4zwk5MZ5SuH+Ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdrddmcsfyGfHdZpYvD+YNrErSJSCORj7zbCyrXoYZw=;
 b=EJtcFwWDjxIrzDm5fLaAbUZ3XcOmX5OwVDB8rjLqjC0grps/J+VXebpadIXYOVRh+L6VekXp/wdr7WnTm5JE4od4vyXixzM3EjG8HIf4NNtxZ12T6vOuBI8YOZz4qqI3f9ioAx/4e/UjLD4ZuXcqE8UNm8nRGSty3+dlB/EaVvHJO+Krgl7ToU/gu2GuWzb6RaVQWGfNXtPra5lSeP3jaZGMpNQq82noM1ogo1CTEsRBZjabDTKFAHUP3zhrsrFjSBAjDt6iKRXHyJEbc73l+Z/IG1/cjn4RAYZzEmkKx1c0+V0g+EZV4i/mX4A7qVlL5zBYSWw3DI7oRO8Akb4Djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdrddmcsfyGfHdZpYvD+YNrErSJSCORj7zbCyrXoYZw=;
 b=yw/+vDVeB6SKH64xF7Bh74Emd+tlwO5xmIoeY9MjIdGWK8dysvDBpC2w/Lu6VE0mofUTUEKMCUFrGxADQEzLqWM33pSzhya6Ukq3xcybUER8xbNDkBxFuYv3yljm6bWZStMF4aKfgz+MnFLqHmKnsvtgLfGCzHGLLvFm+AEEEkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 13:36:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 13:36:18 +0000
Message-ID: <912af5b5-219d-b104-76fc-52b3c9e89979@amd.com>
Date: Thu, 2 Jun 2022 15:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220602132029.6225-1-Philip.Yang@amd.com>
 <60a9c99f-5a19-fd31-d4f5-ccf81717e3e2@amd.com>
 <cf5e5888-3857-9e23-e202-1e274ba690d4@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <cf5e5888-3857-9e23-e202-1e274ba690d4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0008.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a7f1eae-ea36-4eef-aecc-08da449cdf92
X-MS-TrafficTypeDiagnostic: BY5PR12MB4950:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB495057CC9DF95EDC78A34BFE83DE9@BY5PR12MB4950.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SihKNfoDPslQ+qiP37GfPpK1LUHGalUX7aZwvGcW+d15Sb3vOpVZ4JSZOdQnThhEE3fOZwSWyfXVDWZegUmDLXo5eAAw5V0L/iUt/raI4cea6qlNuxfwaxlKeysLU2si8TzuvxHqZBgYfdNAj84fvMcLk70pnXvtrHAxvTZq1TP7i5YPs/2Idyg/0LjFRFqCE2I259n0VyCXE5L33jpkKvmA2m1vdaR/EJV2ZGkVDdopL/rFlroUAm6Sm82KtcVByyx8rKF06eeGDmfxQUgQpb14TQvO0dw73a+5jSO0IbJYHbl/XjoFONk8cEP8fSc7NcG39fADqKcFW1tmQWwOBpFhwGofqOhW8vqxEi1TuryEY1lrM4FbtOBc+fL/0IrabLxToLyvTRsAplxL5f4oqQcaBVTa1ajtB8Xx3iz/CDxwTqcYZmm10szUjaLt+Q4aj7OzuBVfrBolCSngHLRFKxD0R44KKiCBEk7zSClFxdufwDIs8U44GkJ+Cv/8958o2Y4qjXriyNEZ9emnOqzSStik/9sbIqLMo1xRhx2v97Fh2cG22YJlwf74tzL0kXf3Ky3D26T9cWzyTX/34APgBzpTg4ATiqplTd6wLnntMCDZ8gz8zErOxYNORYb1cqyeyQNSR7PPaYqqZ/kNQYhXoXPvLmSNQkCTrWMaunOlBW5tAm5aPDpUolOxN8k1GXuMEFRuJ2zi5n/ZgkNqxVF7LpPegLBpw5h7QJYp/wQZ28gFpmBXOmks0yGvCmRiodv4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(31686004)(5660300002)(15650500001)(2616005)(316002)(110136005)(8936002)(38100700002)(2906002)(186003)(36756003)(6512007)(83380400001)(26005)(6666004)(6486002)(6506007)(53546011)(508600001)(86362001)(8676002)(66476007)(31696002)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRhTEtvRHZWd0RZakpoYnFlOHZuM2tHNzFMRGR3dktiY1JPYW5CVUdZTm92?=
 =?utf-8?B?TXY5V096cGhlUmFtVDRIYi90TjdXN0I5eHFLRExGMG1IdUtWQjFxTUI0Q25z?=
 =?utf-8?B?SXVleW10VmlOc08wKy9ubS9SelAxNmtsbEFxdEJmVDZYTkVTWjBGMFRGRmJJ?=
 =?utf-8?B?TENmWWRTUnJyMHFRU3p1TWh6SGxibW05akxEQlh5Z21NZ2thaytNdTZ2SUlk?=
 =?utf-8?B?ZDVSZUVPRk05UmJxem9TZjIxdVpzbW9scXUxZU9YT0hHelIxY3JRbFdTSXZ4?=
 =?utf-8?B?bUZxRFZHYkFKZllqSmFLRldNZ2xuTkdvZ01INkJWL0RGaWFRVGp3aDNqQ0lO?=
 =?utf-8?B?eUpmdVdwLzNzaElZcjNielRYNTljcnpNZE0wWVU0ZHZGbUhTNU5kak95WFpL?=
 =?utf-8?B?SGpPdXRlMk4xMzRqczAxc1pmWDRYdWFnR1NUbDRPVUkxVEJFVFRra1RVUVNE?=
 =?utf-8?B?dzlLMStQZWtOYXhZWTB0ZytmZmdFTVNDazZVMUZ3TVF1RkFMRk5LbWhYdEh4?=
 =?utf-8?B?K3krbVk1c21wTTg2MUIxV2Q4RFlNcXA4WkRhd0ZUeEZSSEhVT2E5NzdDSXZ5?=
 =?utf-8?B?WnlUM0p6MmM1TGJJK2tLU3UxamkvS0ZTSE0wbFZZS1NjMmh1OTNweDcrUlk2?=
 =?utf-8?B?VFU1L0tOb1VYQTFwak9zYmhOTFcrU1M2U0RUUG55cENHbDluanlCZkptcm1O?=
 =?utf-8?B?OEdiQWs4ajEzY0YwVE4vRWJGR3RlNU5zSzc2ZVdMTU1YR0FHVXk3dE9RZnNp?=
 =?utf-8?B?NUViVUExRnRMM00xdVpkQnlsM3JjOER2QW1xNHVoQ1UzS25xRVllaXJ3T3Jo?=
 =?utf-8?B?bXJCMml5cXcxd01BQlU4R3V4STRDZ2FwZm82MVJKVmprellBcmNGTVp1bGs5?=
 =?utf-8?B?a0ZBa3phSzhqSnBCT0RMZGRHVWNtbHBtdWg0VE9oS0xvOGRsenhRakY3Ni91?=
 =?utf-8?B?L0RBZVJ2S3YxZlVGTEZpZDRQOE5McTlwNmVKV281Zm5oNXE5R3FoWVJuRjYz?=
 =?utf-8?B?NHkzYWFFcDhkaE5iK1phV3ZnaHBxQzVKcjR0ZUp0WUhrbjF6KzFxSFMyKzh4?=
 =?utf-8?B?b2lleHNTRmU2Sk45Z2pNWnRyL1FhcDBneGlwWk5ia3J6L2pWa1M0WUFONi9V?=
 =?utf-8?B?VFJRa0YrdkJkeXpkZ2dWQnZ1ciszU09jNnkwMXlnNjIrSDg4cTRVMEdpSzR0?=
 =?utf-8?B?NkNXcU0yVU80RGMwMzg1ZWRFaFE0SmR6VFFaS0I1ZWZHVEd3eHdHQWRrWkhm?=
 =?utf-8?B?SXJZMVpUNklYQ3NlVUhKakdtS3NWbG5Bb2tjT3ZYdjhCSWlXNDJRTzlIbTNm?=
 =?utf-8?B?VTFFdjlQcUUxMjdRRDFHb1BsTEFOTmVGQ21sZmgxWWNZc1YwU3pYNjJ2N1Ew?=
 =?utf-8?B?ZWtwVGVhN1B3RzUzYVJlNitHS2VnQnNoWnRwUTBFOVZCY2hWb2NzOG9SMk5X?=
 =?utf-8?B?ak5FZFdBajhYaUlxSDVyOEhXdDNnTkhiOU9mQmhyODBUMXc0bWdxNTBUV3BI?=
 =?utf-8?B?d0lsbzU3VmpQMnZwUlptVmt6RmczMWNEZk5rQnFCZXN5QW90c3dtblFaYWNQ?=
 =?utf-8?B?d21ZeVA3Y2NvQUlWZ0ZsYk1uVjhrTEE5RG43UStjSytHenNMRW0zQXkxTXN6?=
 =?utf-8?B?cGswd1FaQUNhNWpkUVRIOU9LNVM1YUcrN3k3Y0RxbmJETkhkTHdEN3dpaFJv?=
 =?utf-8?B?Myt6K0JJdVk1SElGNzBXaEJ3SkZRTFBnTUxnc1B0RVNoTGlKenN1UXlWTWpD?=
 =?utf-8?B?dXlkUzg3WG1udVNTRk9TS2ZCYVE3K1VQcVQ2ZHQ3ZytISDcvS01vUkxsRDZz?=
 =?utf-8?B?ZFFqckttRWFZbi9ua3E4cWw4ZGZ3WXBCd2FKdklIbFVQWXc0bnpQeXVPQWQw?=
 =?utf-8?B?Z1pjN0xWWDRORE0xZHUwMW5pSzN1ZERJQnpjK2RWckVEajNobFVDa2xsZlNn?=
 =?utf-8?B?Sk9CU0crZ2hCRC9WazMxWXNvaGdaTFhubGM4QUpwWThQa2x3SEdwczFmcVhC?=
 =?utf-8?B?UDRsb0dPcWdLbDJXaEl3NVlpVUE3K2x6LzJzK29sT1JYeE5YamN1Mm9xSTJr?=
 =?utf-8?B?SVc3Ri96ZE4vZ3R6aHNkWitFZitvSUJKQ1NTb3pBbEpyV2sxbENMMFVHc0k4?=
 =?utf-8?B?YTY3RGhtNHNsT1poMXc1VWlrTjhmc1VtUUpHNnp1VEdDR2s1OTh2ZnFHQjJZ?=
 =?utf-8?B?cUhNNkdmQ09ZazJyaFpBMVprYndSUy9lWjNrS0tubVhXWlBIbXFhZVloZkZw?=
 =?utf-8?B?YkVYM3pMUU5QeUJjcWZvbEZ5MG5vZ1dlL2hoWlJPenRWU04yU2pHUjRYS2RK?=
 =?utf-8?B?MEM5ejVMNzRTQVhiMG5pbWhVcmxWeHdvVmplQmtOSUd1MXNxNDFGQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7f1eae-ea36-4eef-aecc-08da449cdf92
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:36:18.5209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNdig5HgueHioGCgPu+fdEHoi6LXgi8a9O+EEgd3YfcgLJBa9cRN/ItmPp3ClApV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
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

Am 02.06.22 um 15:26 schrieb Lazar, Lijo:
>
>
> On 6/2/2022 6:54 PM, Lazar, Lijo wrote:
>>
>>
>> On 6/2/2022 6:50 PM, Philip Yang wrote:
>>> Flush TLBs when existing PDEs are updated because a PTB or PDB moved,
>>> but avoids unnecessary TLB flushes when new PDBs or PTBs are added to
>>> the page table, which commonly happens when memory is mapped for the
>>> first time.
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 9596c22fded6..1ea204218903 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -737,6 +737,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>> *adev,
>>>   {
>>>       struct amdgpu_vm_update_params params;
>>>       struct amdgpu_vm_bo_base *entry;
>>> +    bool flush_tlb_needed = false;
>>>       int r, idx;
>>>       if (list_empty(&vm->relocated))
>>> @@ -755,6 +756,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>> *adev,
>>>           goto error;
>>>       list_for_each_entry(entry, &vm->relocated, vm_status) {
>>> +        /* vm_flush_needed after updating moved PDEs */
>>> +        flush_tlb_needed |= entry->moved;
>>
>> That is a strange thing to do for a bool variable. Why not just 
>> assign it?
>>
>
> Hmm.. In a loop, perhaps you meant logical OR?

Well IIRC C doesn't have a logical or assignment operator "||=", so "|=" 
is used instead which also gets the job done.

Christian.

>
> Thanks,
> Lijo
>
>> Thanks,
>> Lijo
>>
>>> +
>>>           r = amdgpu_vm_pde_update(&params, entry);
>>>           if (r)
>>>               goto error;
>>> @@ -764,8 +768,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>> *adev,
>>>       if (r)
>>>           goto error;
>>> -    /* vm_flush_needed after updating PDEs */
>>> -    atomic64_inc(&vm->tlb_seq);
>>> +    if (flush_tlb_needed)
>>> +        atomic64_inc(&vm->tlb_seq);
>>>       while (!list_empty(&vm->relocated)) {
>>>           entry = list_first_entry(&vm->relocated,
>>>

