Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80357C04FF6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 17:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB4810E42D;
	Tue, 16 Apr 2024 17:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yq8GLwdn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1744510F20F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 17:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2sy+RgaaF6/RrHUpCfIIS4U/Tr62dL3JpdTVQhgXrOMbGoS/eIfrGW6Ps+Lqb6I2f3Umt9R15W3/PmoggEXMxblwwAi9r2Ulw8JFuHzGEhldDAsmayo5BjpFOO4oMvV1Ph7OF5Dp1M0/ASvNasFPFu6ki4nNxoAwPi6SO+tHxl9/tLl4Klj+/u6/IK6kb/lPqPKt5ll5GAtWOI9mIRpANfh4hoNYg3f/+8UUSDP39Jawy8UqgAU9EC7kaTxfJovT6MDAs0x4Aur66ctBAAeOqvUmSwFAJsXMjBpBXFXBYVs3hF+4lxbzmmEh+a9di8Crhpo0zAlVGeW5uVDRS6GeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndNFubKlRrFBanT8bWEdoUa9C7YsckXqkXQlManTFQ0=;
 b=YVrCG93wQWqgB8qMvlxKqmOWlo/BUmqdGmQkT4BTgckxqOZhMROpK0W89XvhxhaaJcZfimmoHfOMa3Ht4tCfnIZ4oTGzukNNM4i2CqNc01UNA/oim7NNXxF5kpiYuPIrEvMGb1SX8HpLsrkWnSagsHukCdpCgPbUH9DrwZ5JJ/8OSyFPioHXpkDOPi+jO25GgzfRQmaVCIKpuMTuHG3sIhi+xAeAt6mNAA7D1OoOlNBQtjwNZMqVC37HtFeazp8yATIokMI8XeoQ9Vp1ienL2I0nlyPk8ls0Ewn/Cl77JSByELLHIXdT/xbRvVmphIGuE//l3hi41TW/mGjmKZuEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndNFubKlRrFBanT8bWEdoUa9C7YsckXqkXQlManTFQ0=;
 b=yq8GLwdnZ0T2mGqRsZvqA+N60Xy75B5NUnnX5AxkXThbL8ExEzMCzERgUab7rWzKV7n11+VU4Us1djrKxLVEn5rTjEsrlPyGWWPOr3ckZW5roV3k7LjGc9Ct0tY+6yi5FMiSmM9cgGyH8ThmyqtQ8pozSViiK0ZQEcHmuJ0IH68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 17:02:45 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c94:963b:9aa0:78c8]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c94:963b:9aa0:78c8%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 17:02:45 +0000
Message-ID: <c66d6db8-5253-4f1f-a434-d46f2f7da214@amd.com>
Date: Tue, 16 Apr 2024 12:02:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rock-dgb_defconfig: Update for Linux 6.7 with UBSAN
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240415194924.2181989-1-felix.kuehling@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240415194924.2181989-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:806:d0::13) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: dca9c884-ccd2-4994-7b50-08dc5e370949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdQtGMtU/ASiwjGB+9z6vKT1Vg48OkkQYevkh6vawaa6KxQeO6pQRr3UYFfTTQzZO2aEtB3negtmhv/SRxB5xmZJBlKTQzWpTxcwFp8uKBTWdnWVN7/t+7Il/GK+htQCyfrQMDALa7FCtYGgj6N98sDUdYC0LMPGZDkZYqQ7D4xks7uqBzEWp41Xz8sOcePLC+wT2bqLtZz5odWLopowldbhnIMXVXlHMj0kUseS2i0CrCpohiAiUsCvESg+1OPn/IyX85BLOVHleDfOYzdGXOkb1kgbmxsIwRYH2RyBxHev42cIETOGjPGNAJVGJzngeZBL5au0hzEwjc/I8FqmgJE9npUWyuW9f4J1eHywD0ecouiCybqfFXmAaThIfMOmuW72O+qJpMx6jVc+XVHfpvLN/YUnJn0w2gQYB8/2pU3nLyP70v93/bhu1V7YnBDKx7dmgt+Rm37ygGqzceyDE9HB/+065AN5EshAnsgzYV+ryZuqk1hFVbsADwTtVG4CICmepxFDbIuy/9eyL1TJjy8AbvcQAgQAVfvJJL6cnvWOdUPp6blGV//M0qoAQrzMXyX9+sLv9BX6+a4vCYkO6coorBXpehYBkentWrOjXEguCYDjLt9qOjSa4PKgaoNTCdOO3+v+yopR+3cFntxuRKpSa2dKTFLHRsb6ofiQM4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3k2MVVTRUFLbHFUVXVDQmVqejkvNHN5VmRJQmZYSUhTYXN0aVgrdUtNVkgy?=
 =?utf-8?B?c3MwdCtsRGE5RzdjV3VTb3hwZXR3czVOZjVhdU5HVVFJK0lxc3FOWEpjZTM2?=
 =?utf-8?B?VUo4RUI1NGF5MjcwdFppUVIzVDNGa3VFQTVpVnJtV3lMVFA0TXlZMERKT1d1?=
 =?utf-8?B?b05Hc3N6SzZ0Ukl3eng2dlg3SVN4RTJUQnU3aHlzWWVXcTBFQ3hLanRvM3JC?=
 =?utf-8?B?czV4RDRJcEN5MjBFSmpYQm1wWUFyd0k4Y0JxKzZoaUpyVHkzRlk3cnZwYTc1?=
 =?utf-8?B?VzBPRWQ0SFlpS0k3M0I3WmFZdzdRUjBveDMyb1NSbGxnSjVGVEwzckxtUVp1?=
 =?utf-8?B?M21paTRnRVpkb2xEZGI5YUpVOVFSZlhCN2R3WHEzRzAvVDFYenk1Zm5mYy9Q?=
 =?utf-8?B?dDFWcFhOOTJoc0dCUUhNQU5NZ2paV09CVHFNNjF0M1FaYUhIUk1GOXZCZi82?=
 =?utf-8?B?L1NQdmxqc054cEM5TFVld2E2Vzc5ZFowT0lYcGVuNFpPSEJxMWtjU1Vnem1p?=
 =?utf-8?B?dHBVckRZMHJLMEVFMjFYc2xzTDVMc1ZDUDlTR0x1a2JkNW5QaUJJM1k5MWtZ?=
 =?utf-8?B?YndhSit1SDFtRE53dHJ0aDdoZFQvd3pvOU9NNklka3RzMHFCMUdvYU5TczRs?=
 =?utf-8?B?WEdxODhLVVpqRFhVeldGSGhWZGhZRzZ2VU9KV2xnbFpVV3VjS1RqWUlPS2Ra?=
 =?utf-8?B?a3NFNERWN1gyRXVuTnFTRUdLK2RGRjJnd2lIdzlleTA0aEFDZmIxNWhXY1VF?=
 =?utf-8?B?YitYaFRxQUZGc0lwYUd3cTJleDREVkd2cDdCM2pEYVVUQ2VjU3hUeDVIdm52?=
 =?utf-8?B?bUhCaW11eW8wWW9jQ0dTOGtkL2QzQStwSEJ0WkVyYjVxYTM3U285T2E1L3Aw?=
 =?utf-8?B?NFcxSzNKZ0l5eXBlaGp1TllXWWlpVmVTMUJqNVNmbnhsUTBYWkJRMkZaSm1F?=
 =?utf-8?B?bGFwUTBGMWRUTGVWTFRTTXFrNEx2M3dQVDY4Y0lTSHVqM2V0a0FTM1lJRjFq?=
 =?utf-8?B?TzhhY1VUSk1xYjRBeDFvaDROUW1yTE9JNFIvUlJqdW9PNDV1SlB0N3BUdkgw?=
 =?utf-8?B?Qmo5dHR0b0dBU280aWpzUCtBYTNxY1VuRTFzaXpiZTJFcEtwaDRxYkxIYi9t?=
 =?utf-8?B?K2VxVHliWFRkRVhqakxTaEdYYmRvM0MzenY5WTNZdFF0bjRscEZxajdubW42?=
 =?utf-8?B?L2Zjd1Uwc0JDOFA0ZjRsc09iVit1djVkSk01Zm5wZ1J5SjdnK29hcjl6SzN6?=
 =?utf-8?B?a2pSbHQ5UW05WkV2dU1BSTFFaXJDTEZNSjVadDcvY1FKSEZxdStMVmprY2E3?=
 =?utf-8?B?NGZrL2doNzY3Mms3REVyQ3BaV1lMeHdHQ0VtNlFKVHBIQ0hpZmZFeVo2NUpz?=
 =?utf-8?B?Wm9JZDJSYTNjOEVpeE9KaEJUVDZxY2tJUnNSOFo2NGFUMjgyN24yNkVsMEFQ?=
 =?utf-8?B?N1ZzQVJIcWpUblk1S3NicGF0MWk1MVpnTG1abkVtV2NNeDJLWDZnRzkzMng1?=
 =?utf-8?B?NE50L2I5Mlo3RGxySm5KMFFqd0gyVms2WWhETElhUUhmRTg0K2pNRVJZSjRr?=
 =?utf-8?B?YlVGNE5lc2FuakE4WG1TMGVPL0pKRVZaN3MvdGZUeEU4WERQbHRneUgvMXc5?=
 =?utf-8?B?YVh2QXg2S2lNaXAwS3JZV01TQVVRR2I2K05OOExTTk5DTFk0OHlZTVp2Z0Nv?=
 =?utf-8?B?a3A2aDAzMVRuUVpoa2VJR2JEN0RPWTlVZndqK1dOb2JicFV5QUhEVFA4eUJr?=
 =?utf-8?B?STRLS3BVTEZFVnZQelVSbDZ1bzdESlpOWG9LS0k0UkdqUk1MbVhBaXQ1VUlP?=
 =?utf-8?B?dmpoenZ6eEl6Qlg0eFprRlF0YnJHWEJydTlyZS90WWRhVC9zQ3IwR29yMmxH?=
 =?utf-8?B?OWYyamhKQSs5N21LQmV6aW5ISWNpb2RtVjVYQkIrOU5rcFVCQytrVnRkZ1p4?=
 =?utf-8?B?VVNVMjhzSmFxaHhRSFV1azMvS0RLelhGNWVmeDA0aEhpallnR3E3Y1ZKN01z?=
 =?utf-8?B?TnBEZWZvcC9ncmlsKzA3eUV3TGc4T2IxeUErdmxCS29VekdvYVlud29QRXpy?=
 =?utf-8?B?S3pPTGVuSkRydXA4WjFjZmpkN1NZSU9RUUtQNEUzV2NOcmJsOUFLaGdMeVVN?=
 =?utf-8?Q?rt3s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca9c884-ccd2-4994-7b50-08dc5e370949
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:02:45.2934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDDrKGVZcITF0xvZUk+2xeoz3NncJnO+cwECHPulQSAl/Y7wQqfqyaHHBgOK8B21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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


On 4/15/2024 2:49 PM, Felix Kuehling wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> make rock-dbg_defconfig
> make savedefconfig
> cp defconfig arch/x86/config/rock-dbg_defconfig
>
> This also enables UBSAN, which can help catch some types of bugs at
> compile time.

Enabling UBSAN cause compiler insert code to perform certain kinds of 
check before operations that may cause undefined behaviour. I think it 
catches errors at run time, not compile time, and increases kernel size.

Regards

Xiaogang

>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>   arch/x86/configs/rock-dbg_defconfig | 46 +++++++++--------------------
>   1 file changed, 14 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/configs/rock-dbg_defconfig b/arch/x86/configs/rock-dbg_defconfig
> index 0ad80a8c8eab..80129ca354b4 100644
> --- a/arch/x86/configs/rock-dbg_defconfig
> +++ b/arch/x86/configs/rock-dbg_defconfig
> @@ -34,11 +34,12 @@ CONFIG_CHECKPOINT_RESTORE=y
>   CONFIG_SCHED_AUTOGROUP=y
>   CONFIG_BLK_DEV_INITRD=y
>   CONFIG_EXPERT=y
> -CONFIG_USERFAULTFD=y
> -# CONFIG_COMPAT_BRK is not set
>   CONFIG_PROFILING=y
> +CONFIG_KEXEC=y
> +CONFIG_KEXEC_FILE=y
> +CONFIG_KEXEC_JUMP=y
> +CONFIG_CRASH_DUMP=y
>   CONFIG_SMP=y
> -# CONFIG_RETPOLINE is not set
>   CONFIG_X86_INTEL_LPSS=y
>   CONFIG_IOSF_MBI_DEBUG=y
>   CONFIG_HYPERVISOR_GUEST=y
> @@ -48,9 +49,6 @@ CONFIG_PROCESSOR_SELECT=y
>   CONFIG_GART_IOMMU=y
>   CONFIG_NR_CPUS=256
>   CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> -CONFIG_I8K=m
> -CONFIG_MICROCODE_AMD=y
> -CONFIG_MICROCODE_OLD_INTERFACE=y
>   CONFIG_X86_MSR=m
>   CONFIG_X86_CPUID=m
>   # CONFIG_X86_5LEVEL is not set
> @@ -61,12 +59,8 @@ CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
>   CONFIG_EFI=y
>   CONFIG_EFI_STUB=y
>   CONFIG_EFI_MIXED=y
> -CONFIG_KEXEC=y
> -CONFIG_KEXEC_FILE=y
> -CONFIG_CRASH_DUMP=y
> -CONFIG_KEXEC_JUMP=y
>   CONFIG_PHYSICAL_ALIGN=0x1000000
> -CONFIG_LEGACY_VSYSCALL_EMULATE=y
> +# CONFIG_RETPOLINE is not set
>   CONFIG_HIBERNATION=y
>   CONFIG_PM_WAKELOCKS=y
>   CONFIG_PM_DEBUG=y
> @@ -74,7 +68,6 @@ CONFIG_PM_ADVANCED_DEBUG=y
>   CONFIG_PM_TRACE_RTC=y
>   CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>   CONFIG_ACPI_EC_DEBUGFS=m
> -CONFIG_ACPI_VIDEO=m
>   CONFIG_ACPI_DOCK=y
>   CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
>   CONFIG_ACPI_PCI_SLOT=y
> @@ -108,6 +101,8 @@ CONFIG_BLK_DEV_INTEGRITY=y
>   CONFIG_BLK_DEV_THROTTLING=y
>   CONFIG_PARTITION_ADVANCED=y
>   CONFIG_BINFMT_MISC=y
> +CONFIG_ZSWAP=y
> +# CONFIG_COMPAT_BRK is not set
>   CONFIG_MEMORY_HOTPLUG=y
>   CONFIG_MEMORY_HOTREMOVE=y
>   CONFIG_KSM=y
> @@ -115,15 +110,12 @@ CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
>   CONFIG_MEMORY_FAILURE=y
>   CONFIG_HWPOISON_INJECT=m
>   CONFIG_TRANSPARENT_HUGEPAGE=y
> -CONFIG_CLEANCACHE=y
> -CONFIG_FRONTSWAP=y
>   CONFIG_CMA=y
>   CONFIG_CMA_AREAS=7
>   CONFIG_MEM_SOFT_DIRTY=y
> -CONFIG_ZSWAP=y
> -CONFIG_ZSMALLOC=y
>   CONFIG_ZONE_DEVICE=y
>   CONFIG_DEVICE_PRIVATE=y
> +CONFIG_USERFAULTFD=y
>   CONFIG_NET=y
>   CONFIG_PACKET=y
>   CONFIG_PACKET_DIAG=y
> @@ -167,7 +159,6 @@ CONFIG_BRIDGE_NETFILTER=m
>   CONFIG_NF_CONNTRACK=m
>   CONFIG_NF_CONNTRACK_SECMARK=y
>   CONFIG_NF_CONNTRACK_ZONES=y
> -# CONFIG_NF_CONNTRACK_PROCFS is not set
>   CONFIG_NF_CONNTRACK_EVENTS=y
>   CONFIG_NF_CONNTRACK_TIMEOUT=y
>   CONFIG_NF_CONNTRACK_TIMESTAMP=y
> @@ -178,7 +169,6 @@ CONFIG_NETFILTER_NETLINK_GLUE_CT=y
>   CONFIG_NF_TABLES=m
>   CONFIG_NF_TABLES_NETDEV=y
>   CONFIG_NFT_CT=m
> -CONFIG_NFT_COUNTER=m
>   CONFIG_NFT_CONNLIMIT=m
>   CONFIG_NFT_LOG=m
>   CONFIG_NFT_LIMIT=m
> @@ -270,7 +260,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
>   CONFIG_IP_NF_TARGET_NETMAP=m
>   CONFIG_IP_NF_TARGET_REDIRECT=m
>   CONFIG_IP_NF_MANGLE=m
> -CONFIG_IP_NF_TARGET_CLUSTERIP=m
>   CONFIG_IP_NF_TARGET_ECN=m
>   CONFIG_IP_NF_TARGET_TTL=m
>   CONFIG_IP_NF_RAW=m
> @@ -312,7 +301,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>   CONFIG_DEVTMPFS=y
>   CONFIG_DEVTMPFS_MOUNT=y
>   # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> -CONFIG_EFI_VARS=y
>   CONFIG_PARPORT=y
>   CONFIG_PARPORT_PC=y
>   CONFIG_PARPORT_SERIAL=y
> @@ -363,7 +351,6 @@ CONFIG_E1000=y
>   CONFIG_E1000E=y
>   CONFIG_IGB=y
>   CONFIG_IGBVF=y
> -CONFIG_IXGB=y
>   CONFIG_IXGBE=y
>   CONFIG_I40E=y
>   CONFIG_SKY2=y
> @@ -401,14 +388,14 @@ CONFIG_SENSORS_K10TEMP=m
>   CONFIG_WATCHDOG=y
>   CONFIG_RC_CORE=y
>   CONFIG_RC_DECODERS=y
> +CONFIG_IR_JVC_DECODER=y
> +CONFIG_IR_MCE_KBD_DECODER=y
>   CONFIG_IR_NEC_DECODER=y
>   CONFIG_IR_RC5_DECODER=y
>   CONFIG_IR_RC6_DECODER=y
> -CONFIG_IR_JVC_DECODER=y
> -CONFIG_IR_SONY_DECODER=y
>   CONFIG_IR_SANYO_DECODER=y
>   CONFIG_IR_SHARP_DECODER=y
> -CONFIG_IR_MCE_KBD_DECODER=y
> +CONFIG_IR_SONY_DECODER=y
>   CONFIG_IR_XMP_DECODER=y
>   CONFIG_AGP=y
>   CONFIG_AGP_AMD64=y
> @@ -422,7 +409,6 @@ CONFIG_HSA_AMD_P2P=y
>   CONFIG_DRM_AST=m
>   CONFIG_FB=y
>   CONFIG_BACKLIGHT_CLASS_DEVICE=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y
>   CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>   CONFIG_HID_BATTERY_STRENGTH=y
>   CONFIG_HIDRAW=y
> @@ -456,7 +442,6 @@ CONFIG_RTC_CLASS=y
>   # CONFIG_RTC_HCTOSYS is not set
>   CONFIG_DMADEVICES=y
>   CONFIG_DMABUF_MOVE_NOTIFY=y
> -# CONFIG_X86_PLATFORM_DEVICES is not set
>   CONFIG_AMD_IOMMU=y
>   CONFIG_INTEL_IOMMU=y
>   # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
> @@ -473,9 +458,7 @@ CONFIG_XFS_WARN=y
>   CONFIG_FANOTIFY=y
>   CONFIG_QUOTA=y
>   CONFIG_QUOTA_NETLINK_INTERFACE=y
> -# CONFIG_PRINT_QUOTA_WARNING is not set
>   CONFIG_QFMT_V2=y
> -CONFIG_AUTOFS4_FS=y
>   CONFIG_FUSE_FS=m
>   CONFIG_CUSE=m
>   CONFIG_OVERLAY_FS=y
> @@ -509,22 +492,21 @@ CONFIG_SECURITY=y
>   CONFIG_SECURITY_NETWORK=y
>   CONFIG_SECURITY_SELINUX=y
>   CONFIG_SECURITY_SELINUX_BOOTPARAM=y
> -CONFIG_SECURITY_SELINUX_DISABLE=y
> -CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
>   CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>   CONFIG_CRYPTO_AUTHENC=y
> +CONFIG_CRYPTO_DES=y
> +CONFIG_CRYPTO_CBC=y
>   CONFIG_CRYPTO_SEQIV=y
>   CONFIG_CRYPTO_ECHAINIV=y
> -CONFIG_CRYPTO_CBC=y
>   CONFIG_CRYPTO_MD4=y
>   CONFIG_CRYPTO_SHA1=y
> -CONFIG_CRYPTO_DES=y
>   CONFIG_PRINTK_TIME=y
>   CONFIG_DYNAMIC_DEBUG=y
>   CONFIG_KGDB=y
>   CONFIG_KGDB_LOW_LEVEL_TRAP=y
>   CONFIG_KGDB_KDB=y
>   CONFIG_KDB_KEYBOARD=y
> +CONFIG_UBSAN=y
>   CONFIG_DEBUG_RODATA_TEST=y
>   CONFIG_DEBUG_KMEMLEAK=y
>   CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
> --
> 2.34.1
>
