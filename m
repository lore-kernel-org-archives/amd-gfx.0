Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC3DCD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 15:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDBE10E327;
	Wed, 13 May 2026 15:44:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qeWy38kp";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE30310E327
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 15:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/mAgT7o7cNX4US5Y54LU1SU/zY6jjzNVmp71kNtpQV2JP+u/h+DAFovNZWYFE2tEv2pMC5bBgeDSVWbggWMEfAz6lnLosD5Eu6Lx969b5X4yBqAHL0vJyQ7H62krG7nYuhFDp8gwni6wL19ly8U0NJ4ccHD1/0/WG77gO1NbLv/cny2EyLKhyxRBdD7hyUALyMNg2Vy1sU6uPzpEvqKynEtHxNZsUnqG0Cuub3+B234GJPdTJ5SkP76TtxeKv0SvXIuCmHmKWa6AC9FOk749JToZ7H5FhV9TyepPiuj5xQ4bSeVKLEQ6WMfXhORo3GzUbzmbLX5MwrR9bSoBKpJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfKrvlntPg/rSxpRUc/OWUNZ9Rc3A2lXzc3TuiRUuTI=;
 b=cSXI0LHhTtYBPloQvQPltFfvMsrNMDmLhl9aZcqoTfOpCv4FyLpF9lRXRndp8M0bcoPeBB0kwmA+aQBdJjfVMdzaziQ6ZFOmAiUjFxDU/8wha+TIwYybTlN888FeUARCgXIVT+GqMxihNNv8K+8Jg1e8TJbG1w4dTtAE8qypTi4FPCGjrg5ZQ3mhed+oIxnY0kZDL0J7W1bNM/y4r0A4OlNFeIPeT/upTT4vejk147S4ToP6DCcNpRfciHUZktevdRCnNLPc9JpivqBTBaJfBiNfD9T5nm2QSkcX0mLyTKHsFLggLChDlntuBffNdppizLkbz70U7tJCh5rF8m8Xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfKrvlntPg/rSxpRUc/OWUNZ9Rc3A2lXzc3TuiRUuTI=;
 b=qeWy38kp2t8eHw0g3Nm0pNHhYbR9ooivh3E7E+Z9E8cKb5XcyYqt3L1k6LL7/l01+fn5lHCbmQr8qk0R5rYwPXLdjohbAgN61HtbwtuVEJsP4JX7uB6TYN6d0z/gYk5MdiGsJT8fGgV6USpHwudGCXbZFxz/ZknyxK6jToDm+qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 15:44:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:44:28 +0000
Content-Type: multipart/alternative;
 boundary="------------0EGIvSYo6Ok0H12IqAtk3EB3"
Message-ID: <13772eb5-d551-406a-9f51-9ecd8ac220df@amd.com>
Date: Wed, 13 May 2026 10:44:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com
References: <20260511142259.1424915-1-yifan1.zhang@amd.com>
 <f40f3088-073f-40cb-9e3c-38da7b101f27@amd.com>
 <b97010c2-75e5-43cc-b844-ce61906eafaa@amd.com>
 <87e9bbe1-ccd0-4093-ac09-0ca88a6e4a47@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <87e9bbe1-ccd0-4093-ac09-0ca88a6e4a47@amd.com>
X-ClientProxiedBy: YT4PR01CA0379.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8ff704-89ab-405a-b422-08deb106842e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: t6dFLWk0ybQGVVPKdeHUxX9lKY/tG0gfWzSM+5JxrtpyL+uyLy0v9EGKpwHAsGATiC6CZwYJNY9HqUlPmJstQPyhpHSlxy1AaOK+pC+lsqUQgDEDIYXe/FXWhA+xultRijCgvbN3WdUI9zrTSX9dA77X4uIb9bERtx/5cqRTaTbyvQtdUevgA/ciFuRzeNM0hcnAh4c6EcrYDTUZTLQmbY2tV6uAW+j62IlOBBbT5MECYyqhimVzhdeUuKtXKMSBCl1kXvufE9bRuVj9dcU96xN0qkI16oMkSD65/5j3RAxHKBywI3QeRn1wlMI1nQs6fqsDbCP/uTe5JEZkyei3O2C/EA2B2UE1Fy6e/4ZUZu4IHKmH9XA4BOVfT+eHDoX967OEmemowoW5+PvgyQZM1tdM7DAIYPQpFrhzH4J4zW8XDohmQ9sYZobKWgs9b/GjCLMbm3W8sjXWYvQrKkmEmXFszRE4CNgWCczwX7mnjamlJAo0SnCpcG9QZST0qCAbJQVspNm6jWmBvjNSuh94A++/OyGScLESlhOdbS28+JnnhUf06ODSEEalVFjs8LYreXKBo7Go0shHj0S32LXHQXksDhihhUAduX4vpW3b1kCkCp7MnSLfLn7IXrdro76rAhS55A2h2YPqRw8OKXEQ5JtTmoxxImlWtEmt1jdfPKac3PFTkfdNMjGyhkcwGsyO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enQxWmdIdWV6VFZFTkZIL0JlNUdFSXpSUlVpV21GSFlYeTB4S1BsVlZIanNx?=
 =?utf-8?B?cTZadTc2YUlqKytmeG5LcHBGblRJazZyY2thMnlDT1o0blJjYnVaWFIzdEpq?=
 =?utf-8?B?ME53VU9UdFYvR1VVTlBQYjFBSktSQ1o4T2RqbTV0aTh2VVhab1RydjRlWTlI?=
 =?utf-8?B?QzdCelNaQVNTSC94Wk9naFpqSGg5dFhGYmhMOTVyWEtrV1JOaG5OTElsRlVp?=
 =?utf-8?B?bnVmbjFnVUl5d1VBNWdrMlpHMmNPUTU0dGpMLyt4T2FwemFFR2g0cEU2Y0Rz?=
 =?utf-8?B?RFhXSE9vQ3lGTVdPUVZ1M255b2x5ZjNaTU9NOVB5VFZkbXlWeVFRTjE1Qklp?=
 =?utf-8?B?N3pWYXp5Q3hVd21VQm8xbStyMzQ1THdjQ01xWGsrL29uRUljbWVNdU5ZVDNV?=
 =?utf-8?B?YWxHQWhVaDJ1YlhjT3hFSWVtdkRUVWl3Qm85aWFaaWZBQkh5aFpkZXVFYlBF?=
 =?utf-8?B?V2ovYUNlQjhFSXdVZ1pxTXdXdGM4MGJKcU54WmN4TDRsT1JiaTRFUVlNeUtC?=
 =?utf-8?B?a2ZWL3pTd2dvbFc5QzlPV1hEQjNuMDlFL1BuYnNoeVMzdk9TKzk5Vjc1VWVE?=
 =?utf-8?B?Vkl2dmRpMk1FY0pvazJUUlRveDhDOGVnMk9rd01HZzFoQU1QV0hibkZoOXB6?=
 =?utf-8?B?UVZwb1N1UGxkU0h4cFhDR2tQQitXQWthWGJPak8xNC9oM0phWWhMT0Zjek9m?=
 =?utf-8?B?c0svSTZEZTlHY2VlT2RmVWpocTgveTRmeFFEd0NoQlNEdzFEc0JLSTd3NVB4?=
 =?utf-8?B?Uy9Ub0JJSXljTDB2UlBRV1pybmFsbnVYQ1dNdE0yWEdKcUR6d3NqUEtmK2pS?=
 =?utf-8?B?Y2RlUXVWUFlvRTRXUDRiUkw3VndOejljSEsxdXFVejRyWmxnTjZ1UUFQWitY?=
 =?utf-8?B?dEZ6Q01nZ3dMZG4zWFNIRWtYNG9rZmtjNWl0bkx4RTVBcDdWTEVLcS9YcEZQ?=
 =?utf-8?B?MjQ3R0ZSMk1GVTU2Uzd4dGprdkY4R0xBYldVTjI2bi8xbDlMbFNvRkRZMWY5?=
 =?utf-8?B?WCtIRmEzamtZRkRCYnZkcHRCcVFsRXBjby9YU01LaURPWXF2N3JzY3RyaHFM?=
 =?utf-8?B?MEVKRnVlWk55NWRVU2UwWU8wMHk1NmFnQXEyQWMraDJ5Zzl5NElDdDdrMWw2?=
 =?utf-8?B?NG81cDJMTlNaRjdOK1RSWG8yWlAzNGQ5TnJFTFNZNHBaZmRicVRVd3BFYmEx?=
 =?utf-8?B?Ykt5TUozd1lsN2tKVkFPazdCbVF1WjBQVmd3Q3Z5N2Z4MFdrY0xQd2dMNEdW?=
 =?utf-8?B?Z0l1b2ZTOW54dmViS2E0NGpBaEJIYnZzN2FqSWIzdjFKby9laWFyTlBIWUZ0?=
 =?utf-8?B?eTV1NVNBUlJyOGY1OEFMWmxIbTI3Q2pmbHF6Q1RLVGg5N3RxdjFkT29ZN0I0?=
 =?utf-8?B?bDBWRDFtWDF3QWNTSWJpRHFDMlNUdUJEYkE4UFY2RXJpaHpwWWZwZm9aUktK?=
 =?utf-8?B?OVBXTmlvbzl6Z1hvMzl1bTBKOE96ZS9rdFVmdlU3eHVRQ2hvbXF5eXBrSjd5?=
 =?utf-8?B?Z1UzdDZmRXVLeUc1aXlKVUNtV1Iyb3poUjVIYXdoVElzbFFyVHVnSTdNM3Z3?=
 =?utf-8?B?eDBKdU5kWXNzQWc0QkpjYWs3bDU0eVdnTGoyWVJlZ0V1LzBOeHJHU1ZpaGMz?=
 =?utf-8?B?Zy9jMldrME5UV2FPc2hveEljb2pML3ZWbmFPUWZNdzcxeWZEc00yY3U1TFo3?=
 =?utf-8?B?TFl1bTFIYnZDS2prY0JMNzczTExIR2syTkl0WlptY1pCREpKVTRZSkpKS2FH?=
 =?utf-8?B?V3ZVd1M5ck5sMUlTdEpQUHZ3dXhQOXdDNkQ1L0VONDlwcjErT3MxUmVyaDND?=
 =?utf-8?B?MVVQanJLekpUYXRjaDMyWFAvWU1EdGRXbEYySDgwRkliRUd4cjNYMU1VNmFN?=
 =?utf-8?B?R0M5YU1VRE1VRUtmZ29iclFxeEphRVpkbEV5cEZVTzl3dVdWMGs4SldKSE0w?=
 =?utf-8?B?aWplNThzMGlkdE9hS1BpNEh3NEFqL3dUQkVLZWNBNWdlblE0a2Y1MUQ1U3Z3?=
 =?utf-8?B?WkR1T2E1TXRzM3ZTN0paU1k5aW0yaUROME85VFl6YU9wYXBjcHNSaXlBUURi?=
 =?utf-8?B?SC9pT3EvRzNZNW5QY3ZrdjdJZU4rM09pNWZ6MjBOYzBFc25uMGZGRk9Dbmdt?=
 =?utf-8?B?RVRISnpHZXk2b1g1VGVneGFRaWdDanZYMWFFYVYzcmxnc3IxclNmR0U3a2RC?=
 =?utf-8?B?RzQ1bmFVUWhmazNLUldVOGNOcTh5dWJRZHc1UERGa3Brcm9aL0IyUmJJSHly?=
 =?utf-8?B?S0V6MWxFNk0yQUFFR2RONDNXUFBacjlkQTFtWTVxMG5MTFdTaFk1T0N3Q2J2?=
 =?utf-8?B?OVh2czM2a05tbGFXS1liZkoydWR5dkxQS0toOTFjUXlha3BGWGUydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8ff704-89ab-405a-b422-08deb106842e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:44:28.0417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHjInwhzLpkBfXZc61v/SBbBq5AD6mKVM0KiGmmzkfGegdfA3WHW2DR6Xk8907V26usInG3W8c7Ifp+U2BwBvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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

--------------0EGIvSYo6Ok0H12IqAtk3EB3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-05-13 10:01, Christian König wrote:
> On 5/13/26 16:21, Kuehling, Felix wrote:
>> On 2026-05-13 01:58, Christian König wrote:
>>> On 5/11/26 16:22, Yifan Zhang wrote:
>>>> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
>>>> inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
>>>> this window can result in uncompleted PCIe transactions, leading to NMI panics or
>>>> system hangs.
>>>>
>>>> To prevent this, Unmap all of the applications mappings of the framebuffer
>>>> and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
>>>> during the reset process.
>>>>
>>>> v2: remove inode in kfd_dev (Christian)
>>>> v3: correct unmap offset (Felix), remove prevent new mappings part to avoid deadlock (Christian)
>>>>
>>>> Signed-off-by: Yifan Zhang<yifan1.zhang@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 22 ++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 22 ++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
>>>>    5 files changed, 52 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> index 7b10bbe28caf..d1dac3412a66 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> @@ -36,6 +36,7 @@
>>>>    #include "amdgpu_ras.h"
>>>>    #include "amdgpu_umc.h"
>>>>    #include "amdgpu_reset.h"
>>>> +#include "kfd_priv.h"
>>>>      /* Total memory size in system memory and all GPU VRAM. Used to
>>>>     * estimate worst case amount of memory to reserve for page tables
>>>> @@ -320,6 +321,27 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>>>>            (void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
>>>>    }
>>>>    +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
>>>> +{
>>>> +    struct kfd_dev *kfd = adev->kfd.dev;
>>>> +    unsigned int i;
>>>> +
>>>> +    if (!kfd)
>>>> +        return;
>>>> +
>>>> +    for (i = 0; i < kfd->num_nodes; i++) {
>>>> +        struct kfd_node *node = kfd->nodes[i];
>>>> +
>>>> +        kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL |
>>>> +                        KFD_MMAP_GPU_ID(node->id),
>>>> +                        kfd_doorbell_process_slice(kfd));
>>>> +        kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO |
>>>> +                        KFD_MMAP_GPU_ID(node->id),
>>>> +                        PAGE_SIZE);
>>>> +    }
>>>> +}
>>>> +
>>>> +
>>>>    int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>>>>                    u32 domain, void **mem_obj, uint64_t *gpu_addr,
>>>>                    void **cpu_ptr, bool cp_mqd_gfx9)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index 2bf6a31c194d..5333e052d56d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>            uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>>    void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>>            uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
>>>>      u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 1202a72ff063..6760c9331f46 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -5844,6 +5844,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>        /* We need to lock reset domain only once both for XGMI and single device */
>>>>        amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>>>    +    /* unmap all the mappings of doorbell and framebuffer to prevent user space from
>>>> +     * accessing them
>>>> +     */
>>>> +    unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>>>> +    amdgpu_amdkfd_clear_kfd_mapping(adev);
>>>> +
>>>>        amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>>>>                          hive, need_emergency_restart);
>>>>        if (need_emergency_restart)
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> index 84b9bde7f371..1be1b1dd2341 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> @@ -69,6 +69,21 @@ static const struct class kfd_class = {
>>>>        .name = kfd_dev_name,
>>>>    };
>>>>    +/*
>>>> + * Cache the address space of the chardev on first open so that the reset
>>>> + * path can drop all userspace mappings of doorbell and MMIO ranges via
>>>> + * unmap_mapping_range().
>>>> + */
>>>> +static struct address_space *kfd_dev_mapping;
>>>> +
>>>> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
>>>> +{
>>>> +    struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
>>>> +
>>>> +    if (mapping)
>>>> +        unmap_mapping_range(mapping, holebegin, holelen, 1);
>>>> +}
>>>> +
>>>>    static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
>>>>    {
>>>>        struct kfd_process_device *pdd;
>>>> @@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
>>>>        if (iminor(inode) != 0)
>>>>            return -ENODEV;
>>>>    +    /*
>>>> +     * /dev/kfd is a single chardev so all opens share one inode. Cache
>>>> +     * its address_space on the first open for use by the reset path.
>>>> +     */
>>>> +    if (!READ_ONCE(kfd_dev_mapping))
>>>> +        cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);
>>> That stuff looks really odd. Mostly @Felix why is that necessary?
>>>
>>> Apart from that the patch looks good to me.
>> My understanding is, that kfd_dev_mapping caches the mapping in a global variable, which is OK because there is only one KFD device node. Using cmpxchg is a reliable way to update it without holding a lock the first time kfd_open is called.
>>
>> It's not pretty, but I can't think of a better way of doing this.
> Well you somewhere allocates the device node and that should have an inode field which in turn has an i_mapping field which contains that value.

There is no such structure. Even if there was, it would still be held in 
a global variable.

struct device *kfd_device;
static struct class kfd_class = {
         .name = kfd_dev_name,
};
...
int kfd_chardev_init(void)
{
	...
         kfd_device = device_create(&kfd_class, NULL,
                                    MKDEV(kfd_char_dev_major, 0),
                                    NULL, kfd_dev_name);
	...
}

Regards,
   Felix


>
> I don't know the kfd code well enough to judge where that is but in theory it should be much simpler.
>
> Regards,
> Christian.
>
>> Regards,
>>    Felix
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>> +
>>>>        is_32bit_user_mode = in_compat_syscall();
>>>>          if (is_32bit_user_mode) {
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index a6ff1db477f9..f037062c33ea 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -399,6 +399,7 @@ enum kfd_mempool {
>>>>    /* Character device interface */
>>>>    int kfd_chardev_init(void);
>>>>    void kfd_chardev_exit(void);
>>>> +void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
>>>>      /**
>>>>     * enum kfd_unmap_queues_filter - Enum for queue filters.
--------------0EGIvSYo6Ok0H12IqAtk3EB3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-05-13 10:01, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87e9bbe1-ccd0-4093-ac09-0ca88a6e4a47@amd.com">
      <pre wrap="" class="moz-quote-pre">On 5/13/26 16:21, Kuehling, Felix wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 2026-05-13 01:58, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
On 5/11/26 16:22, Yifan Zhang wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
this window can result in uncompleted PCIe transactions, leading to NMI panics or
system hangs.

To prevent this, Unmap all of the applications mappings of the framebuffer
and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
during the reset process.

v2: remove inode in kfd_dev (Christian)
v3: correct unmap offset (Felix), remove prevent new mappings part to avoid deadlock (Christian)

Signed-off-by: Yifan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:yifan1.zhang@amd.com">&lt;yifan1.zhang@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 22 ++++++++++++++++++++++
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |&nbsp; 1 +
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 6 ++++++
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp; | 22 ++++++++++++++++++++++
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
&nbsp; 5 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7b10bbe28caf..d1dac3412a66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -36,6 +36,7 @@
&nbsp; #include &quot;amdgpu_ras.h&quot;
&nbsp; #include &quot;amdgpu_umc.h&quot;
&nbsp; #include &quot;amdgpu_reset.h&quot;
+#include &quot;kfd_priv.h&quot;
&nbsp; &nbsp; /* Total memory size in system memory and all GPU VRAM. Used to
&nbsp;&nbsp; * estimate worst case amount of memory to reserve for page tables
@@ -320,6 +321,27 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void)amdgpu_reset_domain_schedule(adev-&gt;reset_domain, &amp;adev-&gt;kfd.reset_work);
&nbsp; }
&nbsp; +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
+{
+&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd = adev-&gt;kfd.dev;
+&nbsp;&nbsp;&nbsp; unsigned int i;
+
+&nbsp;&nbsp;&nbsp; if (!kfd)
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
+
+&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; kfd-&gt;num_nodes; i++) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *node = kfd-&gt;nodes[i];
+
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL |
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MMAP_GPU_ID(node-&gt;id),
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_doorbell_process_slice(kfd));
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO |
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MMAP_GPU_ID(node-&gt;id),
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE);
+&nbsp;&nbsp;&nbsp; }
+}
+
+
&nbsp; int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 domain, void **mem_obj, uint64_t *gpu_addr,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void **cpu_ptr, bool cp_mqd_gfx9)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2bf6a31c194d..5333e052d56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag, int8_t xcp_id);
&nbsp; void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag, int8_t xcp_id);
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
&nbsp; &nbsp; u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
&nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1202a72ff063..6760c9331f46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5844,6 +5844,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We need to lock reset domain only once both for XGMI and single device */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_recovery_get_reset_lock(adev, &amp;device_list);
&nbsp; +&nbsp;&nbsp;&nbsp; /* unmap all the mappings of doorbell and framebuffer to prevent user space from
+&nbsp;&nbsp;&nbsp;&nbsp; * accessing them
+&nbsp;&nbsp;&nbsp;&nbsp; */
+&nbsp;&nbsp;&nbsp; unmap_mapping_range(adev-&gt;ddev.anon_inode-&gt;i_mapping, 0, 0, 1);
+&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_clear_kfd_mapping(adev);
+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_halt_activities(adev, job, reset_context, &amp;device_list,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive, need_emergency_restart);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_emergency_restart)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 84b9bde7f371..1be1b1dd2341 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -69,6 +69,21 @@ static const struct class kfd_class = {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name = kfd_dev_name,
&nbsp; };
&nbsp; +/*
+ * Cache the address space of the chardev on first open so that the reset
+ * path can drop all userspace mappings of doorbell and MMIO ranges via
+ * unmap_mapping_range().
+ */
+static struct address_space *kfd_dev_mapping;
+
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
+{
+&nbsp;&nbsp;&nbsp; struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
+
+&nbsp;&nbsp;&nbsp; if (mapping)
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unmap_mapping_range(mapping, holebegin, holelen, 1);
+}
+
&nbsp; static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
@@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (iminor(inode) != 0)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;
&nbsp; +&nbsp;&nbsp;&nbsp; /*
+&nbsp;&nbsp;&nbsp;&nbsp; * /dev/kfd is a single chardev so all opens share one inode. Cache
+&nbsp;&nbsp;&nbsp;&nbsp; * its address_space on the first open for use by the reset path.
+&nbsp;&nbsp;&nbsp;&nbsp; */
+&nbsp;&nbsp;&nbsp; if (!READ_ONCE(kfd_dev_mapping))
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmpxchg(&amp;kfd_dev_mapping, NULL, inode-&gt;i_mapping);
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">That stuff looks really odd. Mostly @Felix why is that necessary?

Apart from that the patch looks good to me.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
My understanding is, that kfd_dev_mapping caches the mapping in a global variable, which is OK because there is only one KFD device node. Using cmpxchg is a reliable way to update it without holding a lock the first time kfd_open is called.

It's not pretty, but I can't think of a better way of doing this.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Well you somewhere allocates the device node and that should have an inode field which in turn has an i_mapping field which contains that value.</pre>
    </blockquote>
    <p>There is no such structure. Even if there was, it would still be
      held in a global variable.</p>
    <pre>struct device *kfd_device;
static struct class kfd_class = {
        .name = kfd_dev_name,
};
...
int kfd_chardev_init(void)
{
	...
        kfd_device = device_create(&amp;kfd_class, NULL,
                                   MKDEV(kfd_char_dev_major, 0),
                                   NULL, kfd_dev_name);
	...
}</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:87e9bbe1-ccd0-4093-ac09-0ca88a6e4a47@amd.com">
      <pre wrap="" class="moz-quote-pre">

I don't know the kfd code well enough to judge where that is but in theory it should be much simpler.

Regards,
Christian.

</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:87e9bbe1-ccd0-4093-ac09-0ca88a6e4a47@amd.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards,
&nbsp; Felix


</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Regards,
Christian.


</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_32bit_user_mode = in_compat_syscall();
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_32bit_user_mode) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a6ff1db477f9..f037062c33ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -399,6 +399,7 @@ enum kfd_mempool {
&nbsp; /* Character device interface */
&nbsp; int kfd_chardev_init(void);
&nbsp; void kfd_chardev_exit(void);
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
&nbsp; &nbsp; /**
&nbsp;&nbsp; * enum kfd_unmap_queues_filter - Enum for queue filters.
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------0EGIvSYo6Ok0H12IqAtk3EB3--
