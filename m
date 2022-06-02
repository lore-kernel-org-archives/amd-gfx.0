Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C5CC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC64F10FCF3;
	Thu,  2 Jun 2022 13:27:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75FF10FCF3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+lgDCLk+DKfyvcK8/EoTtCj6gGTWB/PS/TFAfCKW4V8SLxF8FHAEA3RGxPjIkT5A20ZC6i3ggrhZ2L/xmJHdryuUMIHnHRIsYzzxpr79z6Su886CKblR3RNCoQKtUmLjbstVQAPTDRLfmVSjVbWgaemyJSchm+pQQ0EL3129bDSFRQsR2w/7orgkxzS2IyhW7HEFCyQ67xnsEFh8Iz6b014o9VM1i8gDsCo89L5EIGr6h0WZsoOA8kwaR3N9/mZhPPtnIVXk/PlyXEq7eVL71iXo/JZsCaScq6re/CsjCT+DpsJNJhuPdPuwbkHRAGHmjrOsPGkrQqB+7ThqGaQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY9jQwAMTADbqaFoOx1e4XGcddcjOn3B12J3Zhz16PI=;
 b=ONrEUxc+yqt8Qo3DtLE1rSfxiEEgnS9yMH0C88W9o3d8OsY8J31d0FWUOs0CQBXORuI1ex1tPujNxfz9P2QeZacKi2YN59+tPEqa1YPWM8i4PxtL3cco+XFu+IT6jcrOI2pwiPnWI/W94ZHG27LrQ3Y5yb+Gy8buhR0zV+LZct0WEisSPuTh5bak6hHm8f8XxCPNyvICTj3vvQfd+Yod7vtPNfK44zloDcQI/iV4SMkl/xp12YTkvQgFTevuL2LDeorca4l6P9Jn2gfrCeoofnPPKVTT/jcSO+/oUeH5xZsySJRZoxrZzlPM1LgPNJUaRwUtbGRqTqBBw735QG+G3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY9jQwAMTADbqaFoOx1e4XGcddcjOn3B12J3Zhz16PI=;
 b=X1UcQ9T1gfOT81KpXehF0eXb9myZU0noN9qbhEcyvsCaw8266JWYriJ9vUheF2MAvA0fTSPg1+omo1VQ/KGtVm6eRVcXcFbMekWuV9auTadOS3fayjRvLKx9ht/pfSGQdx1chqyIY5Eua8mbLd525mh4Jg8WpbqnmLVxcfE1cRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 13:26:59 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 13:26:59 +0000
Message-ID: <cf5e5888-3857-9e23-e202-1e274ba690d4@amd.com>
Date: Thu, 2 Jun 2022 18:56:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220602132029.6225-1-Philip.Yang@amd.com>
 <60a9c99f-5a19-fd31-d4f5-ccf81717e3e2@amd.com>
In-Reply-To: <60a9c99f-5a19-fd31-d4f5-ccf81717e3e2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5625ae70-2d0b-4f6a-c4a5-08da449b9282
X-MS-TrafficTypeDiagnostic: DS7PR12MB6189:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6189B63FF00C230981C17F4D97DE9@DS7PR12MB6189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XcLmZ94fYcKNFghLZU0VLExQGDnIJquwwqz/T+xtRI56FDlLpqnbj+t830s6qbPmaD2wWctCgC7HuSyxC2P1kz3iv5lGqjQTIiViHJ5n+26hjJjtGO9K5Jh1VsAiQFcjlTS+v85kampthocgSNir87UezSYiDPiOET367RiZ5kBWQeFhnUF/DfSSyeAKCBHZnOpg3NvNZEHaxyp04mtwXW9gcd0YjDU5kd/pt57TJZm62tf4zK/Hlia3ARP0GUw0KHmc15iK1fhlQEUso/PaG5jqtbAnXYwHa8FWNHLoG0b0tACYroriQeqaKeucuNJdx0YqnyHkhgSnjbtPHcAHyAdaODvDP6rin+2Peh/mWtjg4HSR26PAt9KGmtRnJDLvD00UpBhXV1KkhWUwubhkxcYrKEY2XNWO9q8E0s9Y6reiG50gwcDnIyC02umzcHwaiEwDhh0FeOlZRoQCZ9ZbkyFTIneGLp/wuUJQG+bJmoLd9r5jLAIa11ABB6NWihvpkSevixuledCLYXM2qFvAj6e31sAVyjtW4l86wkjP4rkSqkuC+yabyOA2pc8LSGDYPMjUIUCxIHukI5AzUmFcECVDKnEE8FMs2dm3Oq6zmCA5JYQ/1yDb1ajZMB8ay6pmxo9OGy90YPZChP9kjCqBJu3Qa37BUsSiYPnllaxL7L1MrfCUn81TRMeg9IAlAhi8CF+1NSs58x+OJsBdkxRGmx2urLyVWdETA9Lds2ighjKAVhNJzvbqTvaKFeF7Y1Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(15650500001)(186003)(31686004)(36756003)(6506007)(53546011)(66556008)(66476007)(66946007)(316002)(8676002)(4326008)(31696002)(2906002)(86362001)(8936002)(5660300002)(508600001)(38100700002)(83380400001)(66574015)(6666004)(2616005)(26005)(6486002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUphdmlXcXRNb1NUeHlqN3pYR2J5WXBBWGZOc0VjV0JQSVdKbGc3akprL1VN?=
 =?utf-8?B?UEYwMjRSTEw5c2N2K1Zmc2RxK1lxNGhGaVpNOVZWQThranc0R3c1L2ZnZC9H?=
 =?utf-8?B?QXBONWxSSzdpREIyS2JMREpuQm1oK1VIREVyNFhlaktuRDdHMkNLT0lRdkxr?=
 =?utf-8?B?T3NlTTJhaFNDdnJvazl0akd6Q3dyc1FPdHhYZ3BjRHVYajNwMzdkeDMzR3dW?=
 =?utf-8?B?MFhlMmVxWXlhdnk1aVhkRFVpejNOS3cwSlFUM1hjOGw5OW92bnNLZS9LWmVR?=
 =?utf-8?B?azRZRVVpclJXWmVpZ1k1K0kzOENkTFZkcGZQc0RnOTV5cmIrbUVUeFhiWERz?=
 =?utf-8?B?Q3hJcWNyU3JCOXRIL04yV1ZXcldKaHFCb3diYmJPc1N6cXcxRHdBS295eUlV?=
 =?utf-8?B?U0hoMDU4YUVFcEpwVFdFVWtFZmhGZkV6ODh1MHlVWkVEQXo1Vyt3K1NmRFl5?=
 =?utf-8?B?dUhsOU13blF2dVlXckFCT29LZnBscUwreDVDdU9Pd0V0dlRtaUNyM2E0R2l4?=
 =?utf-8?B?bnBCUUtsMjIxVktkZ2E2NjdJWGxqU25QOGJNc0RrMDdDZDVVMnBmcTliVXd5?=
 =?utf-8?B?KzdLTnZDeUhNc050czQ2emJKbk9GeHgyVDJsdXlDMno5TG03SG1hUkJoK1l1?=
 =?utf-8?B?MlZQU1pPb3JKYmdNOWorN0hKRFREMUNQaENTVFRWb0J6bXFmTnhERVFEUEpu?=
 =?utf-8?B?U2dzKzBOYy9Dd1BjK29rNzIzTkthaFNiWHBoTUI1T1lkMjJqVTZlRnV6bHY1?=
 =?utf-8?B?RmIwdDZ2Sk1QdEtkWU8vUCtiSzFLWmhLZ1BMYWNDNHZKV0VuWnZQNkxVTldq?=
 =?utf-8?B?OUNtMDZIcnY4VzlRY0IzcFV0U2EvaHI3SkZvS0NEUGE2WWo2bm4zSWpXM2RD?=
 =?utf-8?B?MUFaV2JXYTNlSGZVSCt1NU1JNjh3TFp2dE5zb0NuZ0FqUGhFK1RXSjVZSjNM?=
 =?utf-8?B?dGwvUUVxc3dlMWNQcnQySkcrZTVQYWRaNDlNWTV0ZXlsQUZjZXlLU0ptcVpO?=
 =?utf-8?B?L0hUdDI0UmozRlY4ZDFxOGhGVHRteUo2Y2RGTC9UOWw1UEkvMjIzZzlCakxL?=
 =?utf-8?B?YlZrdDhaY29NK3FnRVF5R05jOXZiRVhFS1U0bCt6R2ZpaTQ3UzFZOXJ2USts?=
 =?utf-8?B?b1ZUeDR0TWhvTFZDL0NIYWpMK3FrWGVCdi92ejYvdlBib2RKam5OaWFjT3N4?=
 =?utf-8?B?WWJTSTVXZXBpaXJHblNkMzBhS1VhMFZXR2FqOG9TTDJ2UjA4RkVQd2lIeUZs?=
 =?utf-8?B?NFMwbk14WEJXM1NKdllzbzA1cEpNNU91OGYyMURZNVhtNmEyclorLzJ3c2VR?=
 =?utf-8?B?bnlYVTk5bHk0MjJzQjFlaWhkU0N5UStScUdHTDl2TlgvcXEvcGlncFcyR2xv?=
 =?utf-8?B?WEtINitDWFViMUNlWnJXdjZqcTBEWis5MWxEM0VmSFZwSkhwRWE0K3VEcnhk?=
 =?utf-8?B?U1BBUm1lam9zMjI0R3hMRFNaT1o5cUdqYVlPQWxTWkk1OUVJZHR5a3ZTdEVS?=
 =?utf-8?B?Q21iUEgvVzBjeVh4ZGsvaWNKTHV3MnE4VHd3YTJBRVRhWkhpRi9sMEFjMW44?=
 =?utf-8?B?TVV5YTYwT2E1aUZaTGNUeHAxODQ1L3pJcU5jK3ZjRi9DNndWb2FWOEtQUnFr?=
 =?utf-8?B?blI3WmZvY0x2K1o0cVpBa2plTkplbyt2OW1yZFRLQkxJOGVjanByMkV4ZkFD?=
 =?utf-8?B?bG9MNS9VczI5T3YwWXNYWnQwZDdwTTZ0YWN0Z3NIMHhGSmpVQzhBaGZuWTcw?=
 =?utf-8?B?Z2poTjY3dEZTQ08venlPZUM1ejVJYm1KODFlejBSK2I4R0djTllmQzhIMHo3?=
 =?utf-8?B?T05yTlZiTU9iQzRSVFpjUXErdjl2Z3U2STFEZWdvMGphdHpkcTl1czg1Ukty?=
 =?utf-8?B?a3M5cXNITlJMVnFEUTgzVlhZbmxvNzV3cU5QbmQwOSs5RGpVK3VmMGhSWHVm?=
 =?utf-8?B?Smk3eTM1THlFdHowQys0ZTlIME9ueG13NDQvUWhBblFtMUM2SmxNR2FsaEpR?=
 =?utf-8?B?Q2lPSVB2c1F0VERlSWVORkUyZXlqSk0ydURHT2lvM1N6OUlSSm8rODh4Vjl5?=
 =?utf-8?B?b0Jjd0FSelluTGpUQi9zRlBOSUpEbEtuaUhBOVFFS0d5K1FUSDZoajI5TEF1?=
 =?utf-8?B?QVNrWlhvcE1FOFBjY1VYMFJRa092VGY5aFVNWTdJTCs4L1AxcmZQOUxxd3kx?=
 =?utf-8?B?QUpmb2gvSXpRTTJoZHZKM2dEdlZQdG1QekwyMUFEWDh0bEozeUF1Y0NyRVg0?=
 =?utf-8?B?WGRiV0ZHT28yTS9BTlAyNUpQSFE4cVJnVkNTK1lTSWxEaHlvcHFtN3Y3UGcr?=
 =?utf-8?B?MERaK2NydzQvWldXNXYxUkZ5ODRHWVZ4NjNvalh0WVFKRHhRd3gxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5625ae70-2d0b-4f6a-c4a5-08da449b9282
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:26:59.7821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11RdSgpfU9p+0ytuFgZTr7YTrJM6k8Zr2BclpigOXNmDX470N6BdCABWyy+ntxEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/2/2022 6:54 PM, Lazar, Lijo wrote:
> 
> 
> On 6/2/2022 6:50 PM, Philip Yang wrote:
>> Flush TLBs when existing PDEs are updated because a PTB or PDB moved,
>> but avoids unnecessary TLB flushes when new PDBs or PTBs are added to
>> the page table, which commonly happens when memory is mapped for the
>> first time.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 9596c22fded6..1ea204218903 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -737,6 +737,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>   {
>>       struct amdgpu_vm_update_params params;
>>       struct amdgpu_vm_bo_base *entry;
>> +    bool flush_tlb_needed = false;
>>       int r, idx;
>>       if (list_empty(&vm->relocated))
>> @@ -755,6 +756,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>           goto error;
>>       list_for_each_entry(entry, &vm->relocated, vm_status) {
>> +        /* vm_flush_needed after updating moved PDEs */
>> +        flush_tlb_needed |= entry->moved;
> 
> That is a strange thing to do for a bool variable. Why not just assign it?
> 

Hmm.. In a loop, perhaps you meant logical OR?

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> +
>>           r = amdgpu_vm_pde_update(&params, entry);
>>           if (r)
>>               goto error;
>> @@ -764,8 +768,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>       if (r)
>>           goto error;
>> -    /* vm_flush_needed after updating PDEs */
>> -    atomic64_inc(&vm->tlb_seq);
>> +    if (flush_tlb_needed)
>> +        atomic64_inc(&vm->tlb_seq);
>>       while (!list_empty(&vm->relocated)) {
>>           entry = list_first_entry(&vm->relocated,
>>
