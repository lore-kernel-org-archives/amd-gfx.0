Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F181C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 20:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A571128A6;
	Tue, 16 Apr 2024 20:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i8qv60tx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E54C1128A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 20:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfEWpsDZdNIOqej51ZF8qf3c/zDJgObKQ7HuBflEFG8A5gB/uU3xneIOjIEnW4SCkc4EWDdZLUY1BRcOrr8ZutC70JHkA+kSWcOVkH3jR4DctdqDBeok8L/do3AINIUgKKe16J00GPuL59i6RMtpwdMdUv1Fk62/mtLI8S/MxDWsB6bmt0CzvOZ1LqWJDNpyiTGVSgxp0j217IeuW1A6nP5eXJQtvco6mJHS7V/p4n1rTAgB+TRsKt3I0vS8PPAqEYzlw5Sj68TElGHEOO8HaKUvnso/owMI1TOLsQKbAAs8jaOCrBxbwZxVM1eRA+tmJJUSVbo6zN30Ij7Wn/UnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUdigZ5eCSlixz3rspF0pH6sIfmY6XdIt8frTs51TJg=;
 b=XT06IMDYeKOcMCtdtkp/ZHl5Kh3AkoluDPuL93Q0i1lsEHuc5yut3CIxulHSzTaS9aCAjHoztFxz+bitHdrilfemX7x/hKl7S2ysCxu9oMgy5Zverqn9LyKab/jkpr+XxAxEyRM9UQXCahkW8sYCy75Oyc9SypLGEbkZu8DLBdfPWMtefgkeA+BBxAli6ZjChM38DjSpIgXB5PWDeY6y2VU+tdYF9OhRxMbFMaqWGGzoz0oIA7JcL5BwlOLX+6VEer9AroWRFIDMJGn8uBLinHjqWh6WBITLn5Eo2SjpqRZXqib1m9IQFUqNkmtN/FTOQHs5d0m0OV9NeOeScSR1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUdigZ5eCSlixz3rspF0pH6sIfmY6XdIt8frTs51TJg=;
 b=i8qv60txX2wahIZuTVUBJqpwKcPbS+RCtciat6ihSibu5o2k6X0iL7OuP8aacYeGHP0EL6iIiXmFsfmjrVqsx+d4ZbgYxO23f4V/Uy+6NA8LtluUzFxc+G+mBdy/swABWmzCCCr1h1HKcGE2CFVORfp2nHtsKwkuV6qIqUCaIoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 20:30:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 20:30:29 +0000
Message-ID: <c8dc5d21-4250-46f6-b18f-3c3d2e4b6c25@amd.com>
Date: Tue, 16 Apr 2024 16:30:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rock-dgb_defconfig: Update for Linux 6.7 with UBSAN
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240415194924.2181989-1-felix.kuehling@amd.com>
 <c66d6db8-5253-4f1f-a434-d46f2f7da214@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <c66d6db8-5253-4f1f-a434-d46f2f7da214@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::11)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8626cecb-6c12-4e22-8ff6-08dc5e540e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Vcvdn9MItZUUeiLnZWGV4z9ij9NeHt0D/EulH+Mo4t3e0Zi7nMJxtyFFgRHct0n0S7g227ZUqTbS/emNoo5a14OKxQlhkk7t4dNKzPQYx/SO61GPSQ2PYyz0BEaU9dtvAbSkX7AtkTDbdwpvdfhsxgmMkEWl6mWUlLddoPOgkVqPepp+DV5kIFiuw7ZtSeYbmuWF9+Zdy5jXOPDvzwFJ+f9g2ajPX3i0Asj0Q102K1fAYSl2eBKgUN/cK2c5aBAI/4MRzbcci1ZGk+uI2UHS61qtjM9z9HjMFmAAO65NsBqL3F8Vp6G9lckDo1MB6sSgARjmu3nj7wf9fIlDyAJmjJoYtjeNSd1dAMV2yD1XXxwUIs5u7/+Ep8PC/jvmjjUhn2Nd99VfO4Be25f2dptvCr4t8rEBYzLqG23wU1zGfhxvpgSLEaINYqwZcniZleMh1ew62Ix3k+oRLHyX02Q7361BXjbdsEyWjgDR3p3AgRTW/4Sn46dlENTNxcaoG7/yoJtF3D7b6yfkC+ZZTqnr2UYmxAWTFiKqh98OWckoLnXJYRh/xITLNhNcP1ev8G7Kt6KSH01vyvl+fiEMMtqVW3QVw49JybtnDUlfNLxb9c/N/10qleA2p7fXaOmKx9gqJL+sy0OsEToEmD0l6CBGnSkkncWgS1Ft2NDTBCOQwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akIwcmgwMW5KTGZTS3htYkIvMC9yRkNMWEY0T2lUZWxaTmVPd05rdWR5amRT?=
 =?utf-8?B?cC80c0t0VTk3VzBKd3hHRmJUM29QMUVWYjEzZTZhZjNwM0FGdlA0Q2RINFJX?=
 =?utf-8?B?RHZrUDhnUjJvcDlseFI5Njc5UnVxMzN2SVJjOHFSRHNIdWx5WXZHYkQzQ2Vj?=
 =?utf-8?B?eTZHQzhrWEc3MVVpWE5RcWQzR0ZHQU1PcDhLZlo5T21tQkdsL3hoS2RVL3dD?=
 =?utf-8?B?dUhIU3dPaDF6bjBBMnhzUXVQSkw2YWliaTFDVTFLdFRWb3prTWJTc2NGMXF6?=
 =?utf-8?B?b3o1QjcwclVCQ283K1lGSFM5WW5SUmNtTTFUbTViWUJGVm9XcDRGT0U3NUV4?=
 =?utf-8?B?YTdUZW5WemZDdXAvRVcrZ0tONXFqclN2R1J2ZW41b1p4a2txZGtGbGtoSEpO?=
 =?utf-8?B?QzB5aVBJTmNMdWllL0phbGNYWWwrWTdlWDYzWDVWcFBFVU44NWw5RFdOWVd6?=
 =?utf-8?B?b3BnSGNtV2RvN2lVaURhVUpGbkRrbjVNeE1vQlBCSE1jRUpmcGxhamJtdzNK?=
 =?utf-8?B?eG5jSnhsTnlVcmZCNWUrN1NQKzBsMDl3OVV2d056VmI0b1M2eGhkWXNFNHh4?=
 =?utf-8?B?UUF2QVE3Y1VtbVJRY0xNbGRHUFBUeEtGd2w1enlTWFlLa3R6RTM4eXIyRjcx?=
 =?utf-8?B?Zm40N0FPNDgrUmJ2bjdlUzFmWTZjdGlVSjNVK3p1YzdoUUtaQ3hXTUV2Skgz?=
 =?utf-8?B?amZKWHJ5bEhPRC9XRGRJVU5IcE5QOHQ2eFdXSHExcXRrZzlPSjlld05ad3A0?=
 =?utf-8?B?RkZsaUk2TWMrWkJNNWRjd3Q0K2p1cHV1MmlFK3R6Nm93a3ZaOXR0ZzNrVVpj?=
 =?utf-8?B?S1pnTSsxUUNZb1pLL292N1hUZ1JjcjQvUm95WE9TSzhvaG1rSkxpamc4VVor?=
 =?utf-8?B?ZW9FSzEweTV3N3VFTkNteHRaMVgrNUhEUndiTjV4RFEvbDVkeFhINXlsT042?=
 =?utf-8?B?a0t0dEVDSlpDUkJLcVByekR6bEhMbVV2RVEzZ2hEMVp1SFJFTWhnQktUL1c4?=
 =?utf-8?B?WlhrZkFrYjRwV1MycVZ4am52LzlkNkY4cDFkRVZyYTJGdEJWMzNFYkVra09T?=
 =?utf-8?B?NkFZamVBanFWclkyRWFlZGk3U2RsMVdNOU9XS1JhZVRWUnZjNFhMYkpreGtY?=
 =?utf-8?B?bDhvNm5YYW5VUjgyc3EvMlUwb1hqVjh5MGpWRlE1WDJVSm44RGJYek5GWjRC?=
 =?utf-8?B?bE1yWjdGV21IM0hJbFE1VmRjSGNZa0JuUXBEblhTWHhBZmZUTkhPVXJ2MVl6?=
 =?utf-8?B?ZjVJVVFVd1FnYSttWlprQjNya3A4VzlNT0tYbDdtUWRFVmV6dUs5VFR2OENI?=
 =?utf-8?B?Tnd0ZDZNTWJsZEFsbG9sNjRidkdkZUVqUTl1MUtFUk5yR0dvTnhoRzVMcW05?=
 =?utf-8?B?MWRLWnJrbG9HQ0ZNZGZGS2FTMVR4NVJQUENxY1cvbEhXaTh6NjNUcDU2Zkk2?=
 =?utf-8?B?YzFRNjhYMlBGd1VKeEF5V0gwSlBEUjgyOElxYzNyaWJrSXFPa09NRlROdXI1?=
 =?utf-8?B?ellWdnZ6eTRlY1BkaTQ2d2dnZnZ1RForUWhBTUh6aEVlL2RjaThGODFqSlRW?=
 =?utf-8?B?TVpiNW53a0VsbFoxWDNsRVdLTjZIRXhxZEpnYVBXUFQvaXVuUlVXN2dDMkJx?=
 =?utf-8?B?bXJEN3BQbkJESTBRdFJGSlR3bFI0a2M1dmRwSnVKazJsL2xxMzB4MEVhcU9n?=
 =?utf-8?B?N0kvK3JoYkgwdDJYSkdpekxsNm5mZXVrb0pXNVJYbEZjSk51Rk1DWk5BcVl1?=
 =?utf-8?B?TWNja2dtTS9nOGsrY1E4dDV1Z0RIc1JaUXRoUzlhV3RLR1hhWUpKTzRtS0R2?=
 =?utf-8?B?eU96YjArMW1JZE0yWERIekMvM2VYUmwwM0l5eDkvN2ZYOHdsODdGaWNEcTlN?=
 =?utf-8?B?WmRqVlFTallqVDNjK0ZCQTY5MStzUjArdG5Qc2lMck1JWWFBL1B3WjF0MW4x?=
 =?utf-8?B?eXVIZzlpZTdxOWpGS0RNVDcxZnBhR3VVWUZCc1MrWFVpRW9mOVY4Q2ozMGFt?=
 =?utf-8?B?b3RJdEJNbzVpc2hEZ1BvMUFmNElHVHFXaitQOXA0WENFcVJKWkh5R1NQaFZL?=
 =?utf-8?B?RG1sYTZtNGZDSnBkUjh4cGtjS3JRMUZmTDlJMnhQN2Yvem1VMk9VSHArVnUr?=
 =?utf-8?Q?4Lfw2vbmTqMO4O9n9Mg8ruqzM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8626cecb-6c12-4e22-8ff6-08dc5e540e60
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:30:29.2768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifbxZTgPA2iAStTfkiX8mbifmTu4pn3kqgly5d0OX3BYGdDmH0SB6BrLnxFKzYpcW2JMR0l5I2FrPsc+NKpAcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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

On 2024-04-16 13:02, Chen, Xiaogang wrote:
>
> On 4/15/2024 2:49 PM, Felix Kuehling wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> make rock-dbg_defconfig
>> make savedefconfig
>> cp defconfig arch/x86/config/rock-dbg_defconfig
>>
>> This also enables UBSAN, which can help catch some types of bugs at
>> compile time.
>
> Enabling UBSAN cause compiler insert code to perform certain kinds of 
> check before operations that may cause undefined behaviour. I think it 
> catches errors at run time, not compile time, and increases kernel size.

You're right. I saw it supports some range checking only on arrays where 
the size is known at compile time. But the range checking itself needs 
to happen at runtime.

Regards,
   Felix


>
> Regards
>
> Xiaogang
>
>>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>>   arch/x86/configs/rock-dbg_defconfig | 46 +++++++++--------------------
>>   1 file changed, 14 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/x86/configs/rock-dbg_defconfig 
>> b/arch/x86/configs/rock-dbg_defconfig
>> index 0ad80a8c8eab..80129ca354b4 100644
>> --- a/arch/x86/configs/rock-dbg_defconfig
>> +++ b/arch/x86/configs/rock-dbg_defconfig
>> @@ -34,11 +34,12 @@ CONFIG_CHECKPOINT_RESTORE=y
>>   CONFIG_SCHED_AUTOGROUP=y
>>   CONFIG_BLK_DEV_INITRD=y
>>   CONFIG_EXPERT=y
>> -CONFIG_USERFAULTFD=y
>> -# CONFIG_COMPAT_BRK is not set
>>   CONFIG_PROFILING=y
>> +CONFIG_KEXEC=y
>> +CONFIG_KEXEC_FILE=y
>> +CONFIG_KEXEC_JUMP=y
>> +CONFIG_CRASH_DUMP=y
>>   CONFIG_SMP=y
>> -# CONFIG_RETPOLINE is not set
>>   CONFIG_X86_INTEL_LPSS=y
>>   CONFIG_IOSF_MBI_DEBUG=y
>>   CONFIG_HYPERVISOR_GUEST=y
>> @@ -48,9 +49,6 @@ CONFIG_PROCESSOR_SELECT=y
>>   CONFIG_GART_IOMMU=y
>>   CONFIG_NR_CPUS=256
>>   CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
>> -CONFIG_I8K=m
>> -CONFIG_MICROCODE_AMD=y
>> -CONFIG_MICROCODE_OLD_INTERFACE=y
>>   CONFIG_X86_MSR=m
>>   CONFIG_X86_CPUID=m
>>   # CONFIG_X86_5LEVEL is not set
>> @@ -61,12 +59,8 @@ CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
>>   CONFIG_EFI=y
>>   CONFIG_EFI_STUB=y
>>   CONFIG_EFI_MIXED=y
>> -CONFIG_KEXEC=y
>> -CONFIG_KEXEC_FILE=y
>> -CONFIG_CRASH_DUMP=y
>> -CONFIG_KEXEC_JUMP=y
>>   CONFIG_PHYSICAL_ALIGN=0x1000000
>> -CONFIG_LEGACY_VSYSCALL_EMULATE=y
>> +# CONFIG_RETPOLINE is not set
>>   CONFIG_HIBERNATION=y
>>   CONFIG_PM_WAKELOCKS=y
>>   CONFIG_PM_DEBUG=y
>> @@ -74,7 +68,6 @@ CONFIG_PM_ADVANCED_DEBUG=y
>>   CONFIG_PM_TRACE_RTC=y
>>   CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>>   CONFIG_ACPI_EC_DEBUGFS=m
>> -CONFIG_ACPI_VIDEO=m
>>   CONFIG_ACPI_DOCK=y
>>   CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
>>   CONFIG_ACPI_PCI_SLOT=y
>> @@ -108,6 +101,8 @@ CONFIG_BLK_DEV_INTEGRITY=y
>>   CONFIG_BLK_DEV_THROTTLING=y
>>   CONFIG_PARTITION_ADVANCED=y
>>   CONFIG_BINFMT_MISC=y
>> +CONFIG_ZSWAP=y
>> +# CONFIG_COMPAT_BRK is not set
>>   CONFIG_MEMORY_HOTPLUG=y
>>   CONFIG_MEMORY_HOTREMOVE=y
>>   CONFIG_KSM=y
>> @@ -115,15 +110,12 @@ CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
>>   CONFIG_MEMORY_FAILURE=y
>>   CONFIG_HWPOISON_INJECT=m
>>   CONFIG_TRANSPARENT_HUGEPAGE=y
>> -CONFIG_CLEANCACHE=y
>> -CONFIG_FRONTSWAP=y
>>   CONFIG_CMA=y
>>   CONFIG_CMA_AREAS=7
>>   CONFIG_MEM_SOFT_DIRTY=y
>> -CONFIG_ZSWAP=y
>> -CONFIG_ZSMALLOC=y
>>   CONFIG_ZONE_DEVICE=y
>>   CONFIG_DEVICE_PRIVATE=y
>> +CONFIG_USERFAULTFD=y
>>   CONFIG_NET=y
>>   CONFIG_PACKET=y
>>   CONFIG_PACKET_DIAG=y
>> @@ -167,7 +159,6 @@ CONFIG_BRIDGE_NETFILTER=m
>>   CONFIG_NF_CONNTRACK=m
>>   CONFIG_NF_CONNTRACK_SECMARK=y
>>   CONFIG_NF_CONNTRACK_ZONES=y
>> -# CONFIG_NF_CONNTRACK_PROCFS is not set
>>   CONFIG_NF_CONNTRACK_EVENTS=y
>>   CONFIG_NF_CONNTRACK_TIMEOUT=y
>>   CONFIG_NF_CONNTRACK_TIMESTAMP=y
>> @@ -178,7 +169,6 @@ CONFIG_NETFILTER_NETLINK_GLUE_CT=y
>>   CONFIG_NF_TABLES=m
>>   CONFIG_NF_TABLES_NETDEV=y
>>   CONFIG_NFT_CT=m
>> -CONFIG_NFT_COUNTER=m
>>   CONFIG_NFT_CONNLIMIT=m
>>   CONFIG_NFT_LOG=m
>>   CONFIG_NFT_LIMIT=m
>> @@ -270,7 +260,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
>>   CONFIG_IP_NF_TARGET_NETMAP=m
>>   CONFIG_IP_NF_TARGET_REDIRECT=m
>>   CONFIG_IP_NF_MANGLE=m
>> -CONFIG_IP_NF_TARGET_CLUSTERIP=m
>>   CONFIG_IP_NF_TARGET_ECN=m
>>   CONFIG_IP_NF_TARGET_TTL=m
>>   CONFIG_IP_NF_RAW=m
>> @@ -312,7 +301,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>>   CONFIG_DEVTMPFS=y
>>   CONFIG_DEVTMPFS_MOUNT=y
>>   # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>> -CONFIG_EFI_VARS=y
>>   CONFIG_PARPORT=y
>>   CONFIG_PARPORT_PC=y
>>   CONFIG_PARPORT_SERIAL=y
>> @@ -363,7 +351,6 @@ CONFIG_E1000=y
>>   CONFIG_E1000E=y
>>   CONFIG_IGB=y
>>   CONFIG_IGBVF=y
>> -CONFIG_IXGB=y
>>   CONFIG_IXGBE=y
>>   CONFIG_I40E=y
>>   CONFIG_SKY2=y
>> @@ -401,14 +388,14 @@ CONFIG_SENSORS_K10TEMP=m
>>   CONFIG_WATCHDOG=y
>>   CONFIG_RC_CORE=y
>>   CONFIG_RC_DECODERS=y
>> +CONFIG_IR_JVC_DECODER=y
>> +CONFIG_IR_MCE_KBD_DECODER=y
>>   CONFIG_IR_NEC_DECODER=y
>>   CONFIG_IR_RC5_DECODER=y
>>   CONFIG_IR_RC6_DECODER=y
>> -CONFIG_IR_JVC_DECODER=y
>> -CONFIG_IR_SONY_DECODER=y
>>   CONFIG_IR_SANYO_DECODER=y
>>   CONFIG_IR_SHARP_DECODER=y
>> -CONFIG_IR_MCE_KBD_DECODER=y
>> +CONFIG_IR_SONY_DECODER=y
>>   CONFIG_IR_XMP_DECODER=y
>>   CONFIG_AGP=y
>>   CONFIG_AGP_AMD64=y
>> @@ -422,7 +409,6 @@ CONFIG_HSA_AMD_P2P=y
>>   CONFIG_DRM_AST=m
>>   CONFIG_FB=y
>>   CONFIG_BACKLIGHT_CLASS_DEVICE=y
>> -CONFIG_FRAMEBUFFER_CONSOLE=y
>>   CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>>   CONFIG_HID_BATTERY_STRENGTH=y
>>   CONFIG_HIDRAW=y
>> @@ -456,7 +442,6 @@ CONFIG_RTC_CLASS=y
>>   # CONFIG_RTC_HCTOSYS is not set
>>   CONFIG_DMADEVICES=y
>>   CONFIG_DMABUF_MOVE_NOTIFY=y
>> -# CONFIG_X86_PLATFORM_DEVICES is not set
>>   CONFIG_AMD_IOMMU=y
>>   CONFIG_INTEL_IOMMU=y
>>   # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
>> @@ -473,9 +458,7 @@ CONFIG_XFS_WARN=y
>>   CONFIG_FANOTIFY=y
>>   CONFIG_QUOTA=y
>>   CONFIG_QUOTA_NETLINK_INTERFACE=y
>> -# CONFIG_PRINT_QUOTA_WARNING is not set
>>   CONFIG_QFMT_V2=y
>> -CONFIG_AUTOFS4_FS=y
>>   CONFIG_FUSE_FS=m
>>   CONFIG_CUSE=m
>>   CONFIG_OVERLAY_FS=y
>> @@ -509,22 +492,21 @@ CONFIG_SECURITY=y
>>   CONFIG_SECURITY_NETWORK=y
>>   CONFIG_SECURITY_SELINUX=y
>>   CONFIG_SECURITY_SELINUX_BOOTPARAM=y
>> -CONFIG_SECURITY_SELINUX_DISABLE=y
>> -CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
>> CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>>   CONFIG_CRYPTO_AUTHENC=y
>> +CONFIG_CRYPTO_DES=y
>> +CONFIG_CRYPTO_CBC=y
>>   CONFIG_CRYPTO_SEQIV=y
>>   CONFIG_CRYPTO_ECHAINIV=y
>> -CONFIG_CRYPTO_CBC=y
>>   CONFIG_CRYPTO_MD4=y
>>   CONFIG_CRYPTO_SHA1=y
>> -CONFIG_CRYPTO_DES=y
>>   CONFIG_PRINTK_TIME=y
>>   CONFIG_DYNAMIC_DEBUG=y
>>   CONFIG_KGDB=y
>>   CONFIG_KGDB_LOW_LEVEL_TRAP=y
>>   CONFIG_KGDB_KDB=y
>>   CONFIG_KDB_KEYBOARD=y
>> +CONFIG_UBSAN=y
>>   CONFIG_DEBUG_RODATA_TEST=y
>>   CONFIG_DEBUG_KMEMLEAK=y
>>   CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
>> -- 
>> 2.34.1
>>
