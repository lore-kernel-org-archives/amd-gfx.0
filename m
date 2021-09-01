Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53922C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 14:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A95761056
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 14:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A95761056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839B88945A;
	Wed,  1 Sep 2021 14:55:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B728945A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 14:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeSSer5bFZ3yc2O1nQBeUfmTiXnLiHHdEUJq1E3iNrmwCHNEKPQwQxdJMi15zYj10/4Eu6nMrbVllvgZBFqSNxjjTvrwUqtRYOroqw1307cFKdu/1GEWBuesKje2ZYNAhLrJjnF+T5eT/Iv/F2TC8cX2sm6HUF3aw79kJaU2PwHJS39LDBudmtLKJ7EjRnlrkpc8hNdCztlkbe9PJk9ljEgicLWZ+qKHRUDOi5Yk3mxzeFKMTmjRkqTEFXFzWI8mZtOHAYx5WFIVCWNOVF/7lTARdfWW5Kd+DRPPtpLfSbx20FqIIAcJrwnUQLQE+Nnyx+ezfAf1i/rQX6gwW6CqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K5rFopl4I/9eThzT4JN+eShR4lw4KEuGPEL7eYFMcA=;
 b=ZWEBWgu6WXJssESe6X8xqd8ZkTl4rcFxUgNsDZHpkbmTUuDDvLGtpCdvNWyAS42lHnbWryzKpNOWGUJlsC9bqBfQIGmDzsrcRvPHA1f207OOFafqrC6rB91upcmAin1qnHtOu6BdeVS0cROIg1fuDwrw6bBvWPw+DPbJh8A8bEhi2biS69UgzJLh4Yy2cGqAFGBuIj7vNa/eNKSq5Q28i5xk2Z1m6R8tJGzkfchpUVuplLroHb9xXsoyjaxkT/och2JStClBSR/OkD2NOeu/A6Ai+W+8l+w0slOsP3zRgFROZD+3LMOn8XkfJxZk4ABa9qc+MCzfdt4AecaS0oHwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K5rFopl4I/9eThzT4JN+eShR4lw4KEuGPEL7eYFMcA=;
 b=10St4sLsxJCdGX1JHucumhLAmfVTzha4LfYwkRtoCYEv7+4a3cIiFmb1XKaEqCufod7MC5tstcbd9kiKLmC359gG8ZzqW/v++Jnwg+Mh9C8xggppFZ9x7pIeRMctNonYUR6wY5rbNQHWivU85MlDdmGcvTsEW2ALhjxDpJtrePQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 1 Sep
 2021 14:54:57 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 14:54:57 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210831215632.195506-1-Felix.Kuehling@amd.com>
 <239a99fd-835f-cbbc-152f-afae6861bf60@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2c63bf17-2404-8c68-fa63-b14d94de3e90@amd.com>
Date: Wed, 1 Sep 2021 10:54:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <239a99fd-835f-cbbc-152f-afae6861bf60@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::35) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20 via Frontend Transport; Wed, 1 Sep 2021 14:54:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad1b5cd4-b54c-42b7-bef4-08d96d58775a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5384213D1704B4AF9CB5498692CD9@BN9PR12MB5384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGtVpaBWAEL+ZnNJQEoFgY+nTcNEPc/rAMJaEyUUVNJ+wY2/OAO98KeWDtQbi6W9xqGOvhXITm5I1AvIk3S27ZSkrxyZdZw75C0mpj497FS7GvvKWksNRBzocgf0d4U9RwE4ajgBuGnTCcUshyt4TltsjborOymP7RpEKwICV9wZK1NZZ/jsW1fhK6+IReEDwgaEgFgHKfm20DkimDP76KeXe7vVT+m/CkbzeWwGtbG5DkDM0rOJCauc701wCR/AqB6qk47IoPxwvtlpJ1ANuFuWn2KDEZEH5rAFEbycbh08Y5QHscrgUQq9uauW73+/e9diX+EKE3bpnaCYGfW+SSnuuMYb0aHv9hcaG05fqCrmez+B6W7lnaWMkZPPeTz2HFQkGju+egxKMyB4WgQrmkYClX2ABHHEPfiDiVQvv4JQDaC1fwOyNNJ1G9CF7KN1JztUufHO39My1nNfz6socyTJAbO14XX86GQluJtzT5OilAR4tDZeTi3F/MZAn0WjJKnEgL6AYyA5R0VQIDE26syedFDi++AmWGSQdeeqQ0im2tjsOyWnq3CADXqUSVF26RE4TmSph5feOCwMewpMKY7Uv3lGau4H6nwCcvZd+wPPgqNZvkgoKl7gs6wNwxk3DaqSYmHknbZcHCxUKIpE1Ylfy5mSwD3cI6w7H3+HY8uNrtfuiYhoOdKEDtZuS9xJAB13lFffxIssP/IeBopWca2nvmEa7Rk2aEvk0B8Z3y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(53546011)(16576012)(66946007)(38100700002)(83380400001)(6486002)(956004)(8936002)(66556008)(36756003)(44832011)(316002)(66476007)(86362001)(31686004)(478600001)(8676002)(2906002)(26005)(5660300002)(31696002)(2616005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzRPdHFkRWVNcXpRNEFDNGhVby96OEl4UG1BOW04U1pEc1VLS0xPRURqVHFo?=
 =?utf-8?B?ZW54YkZhN3laVUJNait5R3lpcVVvcTN0d0hMYmR3QVkzMkdyWm5HNWJsTzRC?=
 =?utf-8?B?cEsyUVc5cG8rVm5HUW0zUVZkT3lraVFJYnhEV1FBNHRsa0pRVUVNcUJKZGUw?=
 =?utf-8?B?V1J1b0QvQ0FjcFV4cjNrQUZiRjZhS3NySlB2Z01vVXVwT25hWEhpUkUrc2Zp?=
 =?utf-8?B?NUszbS9JaEVRaE5XMSs4TTlEZVhlTTB2dTV1STFXMUkrQlBjRDB2Z1FlaVcz?=
 =?utf-8?B?Ky9OeE1TdUZrWmsxMDFRNk1hMDVFcWtPMENIL0VmSm5STHNIZlFrWTk2dEtU?=
 =?utf-8?B?OVM0VmcvMHRMUUpVdmtmbkRTb1Y4U0N5emZoQTVIMUtzMm9LaUVQZkZDK2h4?=
 =?utf-8?B?VExYWUd1Z2JUTlR4NGVNMkk1SjA0ZTJ2bWpMdTdLNWVMZ3RSQmRUUHdyODFB?=
 =?utf-8?B?dTRWTURXSEpVRVhIbExpV0ZhRlBLTmkzdGpJWXZnclpuTTNOcndqVEJ4djIz?=
 =?utf-8?B?SHh2MW1OYlhYUHJvK2I3djMvaGthbGJIVkhReUV2RENHenlrbzFjdjA1U0xG?=
 =?utf-8?B?WjlVOFVVOHhpbEVJQUg2dWVLM2pxbUpUM0gyZksrL2c3bUlvRXdEbDZXaC9N?=
 =?utf-8?B?ckhJWUt5bldTc0NGdVFWWGUrb1JLeEYvSmE4UGkweDJKQ2lnTFlGUzhETkdp?=
 =?utf-8?B?YTNudVRjbGpqNVU2QmE5N2lLbDdtZ010Q3FtVnNtTGcwT3pxVXRKSzJnNFBi?=
 =?utf-8?B?RTk1dkFGTFZsZmRRMWhwMjd4NGduNTVBZVRKa1dIcmVGTlhtNWYvQTFSV2FV?=
 =?utf-8?B?STU0Sk9TOHl1YkhvdW0vdjhTejAwdXJSRHg4NzNpdlF6REpnMC9MY2NLeHZ0?=
 =?utf-8?B?ZHFHeXUzTWRvK1BCM1F5am1vcncwd2Faa3lYUW9hVm5MbnRWTGMzZnV5YzlL?=
 =?utf-8?B?UTlRWW9IcjFad0JTQW9pTi9KcGtHWnVzbmliYldMOGFZQTBzYlkrRnppeTJq?=
 =?utf-8?B?MUVLUzMzZ0sxdzRkZ3ZDRUlmWVRMM1F3UVhDM3dXK2xFV0V4SXUwRFlDQzhJ?=
 =?utf-8?B?N2tnME9SN2RGTnpBMmZ0QUZLSjZVZHBKVDNpSytvNmRwcjJFVnVCcmhIMjNI?=
 =?utf-8?B?aEo3VXpRTzNWUE56Zm5aTm5mVXF6ZGtpdWNRdTRad2VQaTdhVUNSVHZDRklH?=
 =?utf-8?B?bTJvTFA1Y1lVMm02S3BRYVphT1VDQi9OTXRsVkVMcW5NbVdveVVZRW5SSUFh?=
 =?utf-8?B?MVFSUVdObnRjWkk0alpyVmxwY0czc2tqb2h1U1ErNVB6WmdFVGN1THlqOU9M?=
 =?utf-8?B?TytGWE1HbkZMVTNnZGpTS25aQ3JMc09hOGJTeC8xcEdiMXdTcGl3eHRsN1No?=
 =?utf-8?B?aDNMWlg4dHlKUnVIVnltVm1RU3FGdFBjQS9td1NqN3ZvZ3RSZUNGbFM5WW53?=
 =?utf-8?B?ajdhU3hCUkRrVTdBMHE5ODJaeldxNUVOSmtzY0EzbWw4VmgzLzV5Qm1PdUJv?=
 =?utf-8?B?T05DSDB6aFBGTHVhZVBQVUJSQS9tbjdvRWhQcTBQY0pRRTdkVTdsNXh2T2lx?=
 =?utf-8?B?c3o3OGdubWRXa2lPSFlsZUdyNElwVkM4cklnTUhIb1RHS0h5OGNNVk4rU3c0?=
 =?utf-8?B?L0VJZmdoUXJXVDQrMlhXc0QyQU1VdGNRS1VlYWo4N1ljcnhEQ2J0RmFtVmxC?=
 =?utf-8?B?RVFQTmcvODlFMU1HSVpEejhBM2JjRWdNZDdyZ3BFaE9OQVRVN2I1a3ZkdUlZ?=
 =?utf-8?Q?BUtkcRUrk1n+dTlGjHf60OvMr68QZZXIFkGGfAD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1b5cd4-b54c-42b7-bef4-08d96d58775a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 14:54:57.8064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA9FB8g53qZqYyLCfpVGX9KjHJFTOWY3QVR2YxItEGVEil07kAOm2naVQxErQ32Xl20CUilIMfAxHpr9rSM5BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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

Am 2021-09-01 um 7:04 a.m. schrieb Lazar, Lijo:
>
>
> On 9/1/2021 3:26 AM, Felix Kuehling wrote:
>> On some GPUs the PCIe atomic requirement for KFD depends on the MEC
>> firmware version. Add a firmware version check for this. The minimum
>> firmware version that works without atomics can be updated in the
>> device_info structure for each GPU type.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 16a57b70cc1a..655ee5733229 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>>       struct kfd_dev *kfd;
>>       const struct kfd_device_info *device_info;
>>       const struct kfd2kgd_calls *f2g;
>> +    uint32_t fw_version;
>>         if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void
>> *) * 2)
>>           || asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
>> @@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>>        * supported.
>>        */
>>       kfd->pci_atomic_requested =
>> amdgpu_amdkfd_have_atomics_support(kgd);
>
> Should the check be grouped inside amdgpu_amdkfd_have_atomics_support?
>
> This flag is used for setting some link properties. If there is HW
> support but comes with incompatible firmware, should the link be still
> marked as atomic?

Our GPU HW always supports PCIe atomics (it's part of the PCIe 3 spec).
But some mainboards with older PCIe chipsets do not. Sometimes even
different ports on the same mainboard differ in their PCIe version and
atomic support.

amdgpu_device_init always tries to enable atomics on the root port an
all the bridges leading to the GPU by calling
pci_enable_atomic_ops_to_root. The result is saved in
adev->have_atomics_support, which is returned to KFD by
amdgpu_amdkfd_have_atomics_support.

The firmware change here does not affect whether atomics are
_supported_. It changes whether atomics are _required_ for the basic
operation of AQL user mode queues. The coming firmware update will
remove that requirement, which allows us to enable KFD for these GPUs+FW
on systems without PCIe atomics.

Enabling PCIe atomics with the updated FW is still beneficial because
shader programs can use a subset of atomic instructions for accessing
system memory atomically on supported systems.

Regards,
  Felix


>
> Thanks,
> Lijo
>
>> -    if (device_info->needs_pci_atomics &&
>> -        !kfd->pci_atomic_requested) {
>> +    fw_version = amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1);
>> +    if (!kfd->pci_atomic_requested &&
>> +        device_info->needs_pci_atomics &&
>> +        (!device_info->no_atomic_fw_version ||
>> +          amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1) <
>> +            device_info->no_atomic_fw_version)) {
>>           dev_info(kfd_device,
>>                "skipped device %x:%x, PCI rejects atomics\n",
>>                pdev->vendor, pdev->device);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index ab83b0de6b22..6d8f9bb2d905 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -207,6 +207,7 @@ struct kfd_device_info {
>>       bool supports_cwsr;
>>       bool needs_iommu_device;
>>       bool needs_pci_atomics;
>> +    uint32_t no_atomic_fw_version;
>>       unsigned int num_sdma_engines;
>>       unsigned int num_xgmi_sdma_engines;
>>       unsigned int num_sdma_queues_per_engine;
>>
