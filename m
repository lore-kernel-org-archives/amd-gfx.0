Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E970C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 17:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201BF10E0E7;
	Wed, 13 Apr 2022 17:31:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0D710E0E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 17:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvUvVpRMI4ARvlgMBdwxLVwquF/c+W+NthPgN1W6DR/D/nfEHFge/n19x9U0dFixl9X5NrKmnPP4+FGn8n26MKgPGXhReJ40sQ8YrTcwa3AEP823smqm3WoqJQSsBsH3kkTCjgZjH+N9HxCtX5H8Do96PuSiEyDKrv+cqqUH3S0NjK50DN2y3NRmaDjocGAMMVChVR7e59hdkWZxl68fWo8oXKajh7Kg5eWVlG2dZ3kgaehlqOnCjXUvAq3R6zR15AX9ezDayCsn7Z+NTPeo9vNbM7kywhaqchET000ry+KCIUrbgFt/PLh0cSAx+2szfHaVKfIJdE4ypIZJA+tMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HocrxGb+NmX8ufCL5h2lc+n51jhB5bLecpuNn1lx2kM=;
 b=gQHccUhzaEctOllt9X8iLD4mqN+0lMuVspnITEaQIuke64JYC/A620KVz5qCDArLzwvHluG7s7vUr0pMWwZEri4ZYas5yfYG7HnVBeJ+uXT0QxZMslM/DURlzBFpHZWGkbYrcECeCzNc4WZenv3IA3NEyEjg8c1xEET06L/3kEnEDwSbIUSJHLho7RGDD4iKYYFmr0m6kHD1icnZeASidxsuxh2PNZ+iJUMRl4EIg0kuxl0FrxQHf11iIarPw+aLPcGkBuB9hVNVMB23xen3l5Cd+z1GNrkS7YA4Fn+iQF4hoESdGSLVF435aZkSIUo0kJFNi2mbtN6dRvTQTuQPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HocrxGb+NmX8ufCL5h2lc+n51jhB5bLecpuNn1lx2kM=;
 b=x1z56mxDJOGpcFiUAvRSOPU4Eau0CbsB6E2LroAynlaaR1k2P9Nf9KrUI55HfXDS4NKMBy8GlM968lEpxp/Ne76FDYwgUi8SkwJGw6HZ+VEDcP0cUvCXacSZ9k0q9Iq+ffUd6CWgscT7oqSisQzGjHJA9FWzdVRP62yp2ibbtF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 17:31:34 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 17:31:34 +0000
Content-Type: multipart/alternative;
 boundary="------------G3H54jcSug8dUQAAb1sXllUz"
Message-ID: <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
Date: Wed, 13 Apr 2022 13:31:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <20220408084544.9313-2-shuotaoxu@microsoft.com>
 <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
 <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
 <5c22aa65-f75d-bc05-e210-f28533d9f0f8@amd.com>
 <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
X-ClientProxiedBy: MN2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:208:15e::32) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ce0a27d-ddf7-463d-ab18-08da1d73746e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5947:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5947604121827364196B8C71EAEC9@BL1PR12MB5947.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIzUYiv5/X7xfB8LHrBdXrap4J8ksJQfo6IQtxG5aqcL66kUtMdMlF5/55B//36nUKN3KrG8nuVdXMVEVIgCiIEwhEm/ZX0vbHRP8U38tfZkVQyrM0vFKaonWuRW2L/7+OIg1bCGXfhbQZU9vmNgO0xnRyyEXGxxYwkOFqEE3w/910QNdb2NSeoBbth+t6HOB5G16GAqxJ8kInhl3pOrl4MrZT5BBWPOjQTRMZu2ZnlxACORU0bUJfypChYdVTBO9CSZSvMkuFBzveaCT9bJRvJD2UxcReFSeKeQMEmKvDBTvbajizzZbOlP2cNB329UzaOs9S9i0mJ9pOQweOHK4pJb73AbXHyETPkg3DIimvqR6wyYHeTGkbQ0oL6lpGQD/ptmKg3U7DfUdob91sunEJdsbF87JTo3k/Yt9wO6zixooMCb6g129nH9mkfTkL3/Q2mLq/nLXiVU8mfNbIANI/uGUvxo/x4ZdqVKArWWd38sOscQSSYlM4+vSufK2GmYmvBS6MXLoEgJ7UYlfSrBSGnYIsqYVPYbeiZOIpnwAGWqZ+ptDIWRS5Dca8h7iLT/6FAvENIjGhNifcWb0qXz0ScSaIa+hSE0Qld7Cn/QnS9dao+mH1EAWtKlX37wSsZeiMYe+r2wwqEPcpR0Y1aWMYMBvPpRCgJRtpeRNQ2/MPLamaoUSjGo4SF9JOv4+6GXPpWCmKWkgFQd7bAhBt5/1GDbtEO24oyOILRS0OmOfpgH8Rj1r8d5YLzouZKSBbuchSiVeYqVz5zDbyXU5+HmIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(166002)(316002)(6506007)(33964004)(83380400001)(53546011)(5660300002)(38100700002)(2616005)(86362001)(186003)(44832011)(30864003)(31686004)(6666004)(31696002)(2906002)(6512007)(45080400002)(508600001)(66946007)(66556008)(66476007)(8936002)(966005)(6486002)(4326008)(54906003)(6916009)(8676002)(36756003)(45980500001)(43740500002)(579004)(559001)(10090945011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S05sZFd5TTZBa0NGd1FuZTZlamdNWHhIUFJLS254KzYxUzRNRU1JN1Rua3p3?=
 =?utf-8?B?T3B6Mk5PWmpiOGVZU1hBYTMxV3lLanc3UGlKT1ZrQ3M4dFNIV1E1a1pYRkww?=
 =?utf-8?B?S1Q1RFRCcFZMQVlrbXozbVYrYlpGdFNQWjgweVczNldkdXdDSzNZZ3dRY2NT?=
 =?utf-8?B?YlJ5dHU1bTE3aUVUUFlNOEVzV3JyNmdsajUyUml2ejhod1M4Y2VUdUM3N1dD?=
 =?utf-8?B?dFVBSDI2YjliMHRDYk1QZ25UMmFEOVNZUkZKMkFjZ3RmbDk5cGNnVGxjY2Fv?=
 =?utf-8?B?UUFhTy9WWVFuam9UTW5ZWTkrdGFTeTA0MEEvV2kzMWExeGRPOFdaMWxHNjJC?=
 =?utf-8?B?VnpyWU5EMnJlcmQySWZRRTFlc0MzSE8zSEtqNjVCeEdvak1teWdDcTl0UGVX?=
 =?utf-8?B?dDVnRFZZNXJ5aEt0QjFxOUJNSHFrNDZzWWxLbE4wM0FKY3FWWnRvWVd1Mk1h?=
 =?utf-8?B?YW1MNDBndnZVSnVlQ2tWTGZIcStZc1FYV0dLOGVJWkMvb3JCSE9WZ09HQVo2?=
 =?utf-8?B?UE5MS0JhWW82TW9uY0I2dTVvM3dDVE9RenBlWHhJNTIzdGhENTgrRXlSWGZ5?=
 =?utf-8?B?MEwzNVhRd1hvUHdkcnJaU1JGbUNOenh4ZmpYZ2g4dGJmbEM0ekY2eTRSZHVH?=
 =?utf-8?B?U2ZsNDJLS1JvM01JOVUyR3FvU2ZQWThnOWFjWHd6SGtsVXk0WE5TdldpREFJ?=
 =?utf-8?B?VHVhaVF1MHBHNy9UWi90a3ZzSFU5cTRKTS9lZ0F6TmxYTXZkN3A2YmNZV3Ny?=
 =?utf-8?B?RW05ajl4UTZxQTQ0aytHbmJtd1MwZVFZVHd1azhhOUxvb3RaVWhTN2RBaENM?=
 =?utf-8?B?SFFMYjMwZ0ZrUEFjNFdCQ1V0czRHbVJ2VGl6cU5jcVo2R2piM2VXZ0x2WlIx?=
 =?utf-8?B?dlNicEJBR0VENU5FZmhPVGtYajdsZHhxQWNlUDV1ZFJkNnhabGFNUmNWZHFE?=
 =?utf-8?B?OVJjNFVLZlMzUWM0QnpVNkFTTXdzWUkxcGNIYmRwYkV0ZWpzMDQwc2NnQWU2?=
 =?utf-8?B?MGJhSkNZRVhMVzJkZ1hQN2ZSWGxoNDZmWTJXbWJncC9YSEVNa2dwbkwyWUw3?=
 =?utf-8?B?K1dWOTk4Q09WTFJIRGVrOUIyNHg3RDFXUlBuYkJrUUVNK21jc3RZNERVdXpl?=
 =?utf-8?B?Vy91UnJCeVg5Q3M0Kzh6bnFXc3pST0lsUDBsQXJzSVIzaWJ1d01zdlBabTdH?=
 =?utf-8?B?Nlp2ZnpJdyt4cTlvRkZBaytWWG4wQWhpSkFhRHhudXZHOStnY0ZTd1VEWTEw?=
 =?utf-8?B?NlBNUjd6U3cwK0JJbGp1NUtzY3BtaEgza0Qyd1pZb3pCSlBDOXQrcm9MU2Ey?=
 =?utf-8?B?SjZJVmlJbmoxdlcydkNQOUpuSXZVdG10bTJ4aVNkY2JCTkpKQWtGUGd3Z2xT?=
 =?utf-8?B?YXVTOUk5NmtoT0dFekpyeU14eGkveElNcEdzTllXM0ZxWDVmRnZuYWlSRXcr?=
 =?utf-8?B?MW03Q0VjTGx4elNmMS82cUFDRU1ZYlFJTlRqNDNwZUkvdmc2M3c1TXBvZW5Q?=
 =?utf-8?B?c0RmczFOdGNiL2E2TVM1RzNKY0dGNUE2TjExR3ZGMW9SYUlNOHh4Vm1lQ3cr?=
 =?utf-8?B?WDE1RHFvWXdZMmZMNlVqTDgzVG56R1M3clhyTXVDVnNJTGNiaXBPa3hrbytx?=
 =?utf-8?B?aTJCNDg0YzAwMTJBQzVDOHRBSlZjWFFjY3lrY01qYkRUL05yMnpnelJMYTZR?=
 =?utf-8?B?c2sxbkdlTmpTZndmMmY2REpZOEFJeFZNT3BhZUZ5cEU5RU1sNkNmK1NKdGtE?=
 =?utf-8?B?aitSNkVNbW1RZUtLOWU4cHFBN2NtZUxraitLQjM1MWtvdFE0YUw4MG9ZT04x?=
 =?utf-8?B?d1pqLzI2NmJXWllpekFOVUd4UFZLTTB3Ni9zRWxKM1YrZmoxcStCYW1YeTRV?=
 =?utf-8?B?dFRKNHlDOEZaQ09CRTR1WGlpRkNYVk42NGF2TkJIcFJ0eXozUnJjcGEvcGJo?=
 =?utf-8?B?WUxCM1M0a2VPNmJwc0lxK2RscnFNTU03enhSQ2RiR20wK2MvWjg2bE9MMzNC?=
 =?utf-8?B?VEt5RXEzVEVBRVdtN2svaXh5MnNMbndNNnkxcjltMWNMKy9ZMDJUL3ZYaHNI?=
 =?utf-8?B?SWp6VkFzb0taQ1FjRTdLUzQxZm9lWS8rRUtGcWVmSytvSTVvcjZsekh3UjNV?=
 =?utf-8?B?MWt3bDNYS1l3R0w5RTkrWmdrdjFCQXd6UFdqd1h5T2pNMWl5a0JuaHFRdTl4?=
 =?utf-8?B?enJlVVUvMmJ6MjJwODViWnU1bTFzRTMxNkwwRk90bll0cGlKT2F4b1ROYS9H?=
 =?utf-8?B?VmYrMWlxSWZ2dzI4cnFiaFZSQ1pCMXpRYlFNTCt5ejFoZlIweWgxYldtVW9x?=
 =?utf-8?B?ZXZFbmFvU3lrQm1Oc0c5eFhyZXFUUkYrNG5ENnNwR083cG5aK0VxSWNmdStp?=
 =?utf-8?Q?2dV70gEjhLm6KkxNgZRUQfLnklcG2gyktEqhch2eqnxnV?=
X-MS-Exchange-AntiSpam-MessageData-1: H1cbp7jJUTqKHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce0a27d-ddf7-463d-ab18-08da1d73746e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 17:31:34.0231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nzl/52gUZFRuF/vk+gFqd4WNesi5e3UE4sWCzUSASb5NsFsKTd7LQIdhlHuzAyuPIyK2HQRb8ne3Ds2V8/ofQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------G3H54jcSug8dUQAAb1sXllUz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-04-13 12:03, Shuotao Xu wrote:
>
>
>> On Apr 11, 2022, at 11:52 PM, Andrey Grodzovsky 
>> <andrey.grodzovsky@amd.com> wrote:
>>
>> [Some people who received this message don't often get email 
>> fromandrey.grodzovsky@amd.com. Learn why this is important 
>> athttp://aka.ms/LearnAboutSenderIdentification.]
>>
>> On 2022-04-08 21:28, Shuotao Xu wrote:
>>>
>>>> On Apr 8, 2022, at 11:28 PM, Andrey Grodzovsky 
>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>> [Some people who received this message don't often get email from 
>>>> andrey.grodzovsky@amd.com. Learn why this is important at 
>>>> http://aka.ms/LearnAboutSenderIdentification.]
>>>>
>>>> On 2022-04-08 04:45, Shuotao Xu wrote:
>>>>> Adding PCIe Hotplug Support for AMDKFD: the support of hot-plug of GPU
>>>>> devices can open doors for many advanced applications in data center
>>>>> in the next few years, such as for GPU resource
>>>>> disaggregation. Current AMDKFD does not support hotplug out b/o the
>>>>> following reasons:
>>>>>
>>>>> 1. During PCIe removal, decrement KFD lock which was incremented at
>>>>> the beginning of hw fini; otherwise kfd_open later is going to
>>>>> fail.
>>>> I assumed you read my comment last time, still you do same approach.
>>>> More in details bellow
>>> Aha, I like your fix:) I was not familiar with drm APIs so just only 
>>> half understood your comment last time.
>>>
>>> BTW, I tried hot-plugging out a GPU when rocm application is still 
>>> running.
>>> From dmesg, application is still trying to access the removed kfd 
>>> device, and are met with some errors.
>>
>>
>> Application us supposed to keep running, it holds the drm_device
>> reference as long as it has an open
>> FD to the device and final cleanup will come only after the app will die
>> thus releasing the FD and the last
>> drm_device reference.
>>
>>> Application would hang and not exiting in this case.
>>
>
> Actually I tried kill -7 $pid, and the process exists. The dmesg has 
> some warning though.
>
> [  711.769977] WARNING: CPU: 23 PID: 344 at 
> .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336 
> amdgpu_bo_release_notify+0x150/0x160 [amdgpu]
> [  711.770528] Modules linked in: amdgpu(OE) amdttm(OE) amd_sched(OE) 
> amdkcl(OE) iommu_v2 nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo 
> xt_addrtype br_netfilter xt_CHECKSUM iptable_mangle xt_MASQUERADE 
> iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 
> nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc 
> ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter 
> overlay binfmt_misc intel_rapl_msr i40iw intel_rapl_common skx_edac 
> nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel rpcrdma 
> kvm sunrpc ipmi_ssif ib_umad ib_ipoib rdma_ucm irqbypass rapl joydev 
> acpi_ipmi input_leds intel_cstate ipmi_si ipmi_devintf mei_me mei 
> intel_pch_thermal ipmi_msghandler ioatdma mac_hid lpc_ich dca 
> acpi_power_meter acpi_pad sch_fq_codel ib_iser rdma_cm iw_cm ib_cm 
> iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi pci_stub 
> ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10 
> raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> [  711.779359]  raid6_pq libcrc32c raid1 raid0 multipath linear 
> mlx5_ib ib_uverbs ib_core ast drm_vram_helper i2c_algo_bit 
> drm_ttm_helper ttm drm_kms_helper syscopyarea crct10dif_pclmul 
> crc32_pclmul ghash_clmulni_intel sysfillrect uas hid_generic sysimgblt 
> aesni_intel mlx5_core fb_sys_fops crypto_simd usbhid cryptd drm i40e 
> pci_hyperv_intf usb_storage glue_helper mlxfw hid ahci libahci wmi
> [  711.779752] CPU: 23 PID: 344 Comm: kworker/23:1 Tainted: G        W 
>  OE     5.11.0+ #1
> [  711.779755] Hardware name: Supermicro 
> SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/2018
> [  711.779756] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
> [  711.779955] RIP: 0010:amdgpu_bo_release_notify+0x150/0x160 [amdgpu]
> [  711.780141] Code: e8 b5 af 34 f4 e9 1f ff ff ff 48 39 c2 74 07 0f 
> 0b e9 69 ff ff ff 4c 89 e7 e8 3c b4 16 00 e9 5c ff ff ff e8 a2 ce fd 
> f3 eb cf <0f> 0b eb cb e8 d7 02 34 f4 0f 1f 80 00 00 00 00 0f 1f 44 00 
> 00 55
> [  711.780143] RSP: 0018:ffffa8100dd67c30 EFLAGS: 00010282
> [  711.780145] RAX: 00000000ffffffea RBX: ffff89980e792058 RCX: 
> 0000000000000000
> [  711.780147] RDX: 0000000000000000 RSI: ffff89a8f9ad8870 RDI: 
> ffff89a8f9ad8870
> [  711.780148] RBP: ffffa8100dd67c50 R08: 0000000000000000 R09: 
> fffffffffff99b18
> [  711.780149] R10: ffffa8100dd67bd0 R11: ffffa8100dd67908 R12: 
> ffff89980e792000
> [  711.780151] R13: ffff89980e792058 R14: ffff89980e7921bc R15: 
> dead000000000100
> [  711.780152] FS:  0000000000000000(0000) GS:ffff89a8f9ac0000(0000) 
> knlGS:0000000000000000
> [  711.780154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  711.780156] CR2: 00007ffddac6f71f CR3: 00000030bb80a003 CR4: 
> 00000000007706e0
> [  711.780157] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  711.780159] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  711.780160] PKRU: 55555554
> [  711.780161] Call Trace:
> [  711.780163]  ttm_bo_release+0x2ae/0x320 [amdttm]
> [  711.780169]  amdttm_bo_put+0x30/0x40 [amdttm]
> [  711.780357]  amdgpu_bo_unref+0x1e/0x30 [amdgpu]
> [  711.780543]  amdgpu_gem_object_free+0x8b/0x160 [amdgpu]
> [  711.781119]  drm_gem_object_free+0x1d/0x30 [drm]
> [  711.781489]  amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380 
> [amdgpu]
> [  711.782044]  kfd_process_device_free_bos+0xe0/0x130 [amdgpu]
> [  711.782611]  kfd_process_wq_release+0x286/0x380 [amdgpu]
> [  711.783172]  process_one_work+0x236/0x420
> [  711.783543]  worker_thread+0x34/0x400
> [  711.783911]  ? process_one_work+0x420/0x420
> [  711.784279]  kthread+0x126/0x140
> [  711.784653]  ? kthread_park+0x90/0x90
> [  711.785018]  ret_from_fork+0x22/0x30
> [  711.785387] ---[ end trace d8f50f6594817c84 ]---
> [  711.798716] [drm] amdgpu: ttm finalized


So it means the process was stuck in some wait_event_killable (maybe 
here drm_sched_entity_flush) - you can try 'cat/proc/$process_pid/stack' 
maybe before
you kill it to see where it was stuck so we can go from there.


>
>>
>> For graphic apps what i usually see is a crash because of sigsev when
>> the app tries to access
>> an unmapped MMIO region on the device. I haven't tested for compute
>> stack and so there might
>> be something I haven't covered. Hang could mean for example waiting on a
>> fence which is not being
>> signaled - please provide full dmesg from this case.
>>
>>>
>>> Do you have any good suggestions on how to fix it down the line? 
>>> (HIP runtime/libhsakmt or driver)
>>>
>>> [64036.631333] amdgpu: amdgpu_vm_bo_update failed
>>> [64036.631702] amdgpu: validate_invalid_user_pages: update PTE failed
>>> [64036.640754] amdgpu: amdgpu_vm_bo_update failed
>>> [64036.641120] amdgpu: validate_invalid_user_pages: update PTE failed
>>> [64036.650394] amdgpu: amdgpu_vm_bo_update failed
>>> [64036.650765] amdgpu: validate_invalid_user_pages: update PTE failed
>>
>
> The full dmesg will just the repetition of those two messages,
> [186885.764079] amdgpu 0000:43:00.0: amdgpu: amdgpu: finishing device.
> [186885.766916] [drm] free PSP TMR buffer
> [186893.868173] amdgpu: amdgpu_vm_bo_update failed
> [186893.868235] amdgpu: validate_invalid_user_pages: update PTE failed
> [186893.876154] amdgpu: amdgpu_vm_bo_update failed
> [186893.876190] amdgpu: validate_invalid_user_pages: update PTE failed
> [186893.884150] amdgpu: amdgpu_vm_bo_update failed
> [186893.884185] amdgpu: validate_invalid_user_pages: update PTE failed
>
>>
>> This just probably means trying to update PTEs after the physical device
>> is gone - we usually avoid this by
>> first trying to do all HW shutdowns early before PCI remove completion
>> but when it's really tricky by
>> protecting HW access sections with drm_dev_enter/exit scope.
>>
>> For this particular error it would be the best to flush
>> info->restore_userptr_work before the end of
>> amdgpu_pci_remove (rejecting new process creation and calling
>> cancel_delayed_work_sync(&process_info->restore_userptr_work) for all
>> running processes)
>> somewhere in amdgpu_pci_remove.
>>
> I tried something like *kfd_process_ref_release* which I think did 
> what you described, but it did not work.


I don't see how kfd_process_ref_release is the same as I mentioned 
above, what i meant is calling the code above within kgd2kfd_suspend 
(where you tried to call kfd_kill_all_user_processes bellow)


>
> Instead I tried to kill the process from the kernel, but the amdgpu 
> could **only** be hot-plugged in back successfully only if there was 
> no rocm kernel running when it was plugged out. If not, amdgpu_probe 
> will just hang later. (Maybe because amdgpu was plugged out while 
> running state, it leaves a bad HW state which causes probe to hang).


We usually do asic_reset during probe to reset all HW state (checlk if 
amdgpu_device_init->amdgpu_asic_reset is running when you  plug back).


>
> I don’t know if this is a viable solution worth pursuing, but I 
> attached the diff anyway.
>
> Another solution could be let compute stack user mode detect a 
> topology change via generation_count change, and abort gracefully there.
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 4e7d9cb09a69..79b4c9b84cd0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -697,12 +697,15 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool 
> run_pm, bool force)
>                 return;
>
>         /* for runtime suspend, skip locking kfd */
> -       if (!run_pm) {
> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>                 /* For first KFD device suspend all the KFD processes */
>                 if (atomic_inc_return(&kfd_locked) == 1)
>                         kfd_suspend_all_processes(force);
>         }
>
> +       if (drm_dev_is_unplugged(kfd->ddev))
> +               kfd_kill_all_user_processes();
> +
>         kfd->dqm->ops.stop(kfd->dqm);
>         kfd_iommu_suspend(kfd);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 55c9e1922714..84cbcd857856 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1065,6 +1065,7 @@ void kfd_unref_process(struct kfd_process *p);
>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>  int kfd_process_restore_queues(struct kfd_process *p);
>  void kfd_suspend_all_processes(bool force);
> +void kfd_kill_all_user_processes(void);
>  /*
>   * kfd_resume_all_processes:
>   *     bool sync: If kfd_resume_all_processes() should wait for the
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 6cdc855abb6d..fb0c753b682c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2206,6 +2206,24 @@ void kfd_suspend_all_processes(bool force)
>         srcu_read_unlock(&kfd_processes_srcu, idx);
>  }
>
> +
> +void kfd_kill_all_user_processes(void)
> +{
> +       struct kfd_process *p;
> +       struct amdkfd_process_info *p_info;
> +       unsigned int temp;
> +       int idx = srcu_read_lock(&kfd_processes_srcu);
> +
> +       pr_info("Killing all processes\n");
> +       hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +               p_info = p->kgd_process_info;
> +               pr_info("Killing  processes, pid = %d", 
> pid_nr(p_info->pid));
> +               kill_pid(p_info->pid, SIGBUS, 1);


 From looking into kill_pid I see it only sends a signal but doesn't 
wait for completion, it would make sense to wait for completion here. In 
any case I would actually try to put here

hash_for_each_rcu(p_info)
     cancel_delayed_work_sync(&p_info->restore_userptr_work)

instead  at least that what i meant in the previous mail.

Andrey

> +       }
> +       srcu_read_unlock(&kfd_processes_srcu, idx);
> +}
> +
> +
>  int kfd_resume_all_processes(bool sync)
>  {
>         struct kfd_process *p;
>
>
>> Andrey
>>
>>
>>>
>>> Really appreciate your help!
>>>
>>> Best,
>>> Shuotao
>>>
>>>>> 2. Remove redudant p2p/io links in sysfs when device is hotplugged
>>>>> out.
>>>>>
>>>>> 3. New kfd node_id is not properly assigned after a new device is
>>>>> added after a gpu is hotplugged out in a system. libhsakmt will
>>>>> find this anomaly, (i.e. node_from != <dev node id> in iolinks),
>>>>> when taking a topology_snapshot, thus returns fault to the rocm
>>>>> stack.
>>>>>
>>>>> -- This patch fixes issue 1; another patch by Mukul fixes issues 2&3.
>>>>> -- Tested on a 4-GPU MI100 gpu nodes with kernel 5.13.0-kfd; kernel
>>>>> 5.16.0-kfd is unstable out of box for MI100.
>>>>> ---
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>>>> drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++++
>>>>> 4 files changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> index c18c4be1e4ac..d50011bdb5c4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct amdgpu_device 
>>>>> *adev, bool run_pm)
>>>>> return r;
>>>>> }
>>>>>
>>>>> +int amdgpu_amdkfd_resume_processes(void)
>>>>> +{
>>>>> + return kgd2kfd_resume_processes();
>>>>> +}
>>>>> +
>>>>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>>>>> {
>>>>> int r = 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> index f8b9f27adcf5..803306e011c3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
>>>>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>>>> int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>>> int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>>>> +int amdgpu_amdkfd_resume_processes(void);
>>>>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>>>> const void *ih_ring_entry);
>>>>> void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>>>>> @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>>> int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>>>>> +int kgd2kfd_resume_processes(void);
>>>>> int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>>>> int kgd2kfd_post_reset(struct kfd_dev *kfd);
>>>>> void kgd2kfd_interrupt(struct kfd_dev *kfd, const void 
>>>>> *ih_ring_entry);
>>>>> @@ -393,6 +395,11 @@ static inline int kgd2kfd_resume(struct 
>>>>> kfd_dev *kfd, bool run_pm)
>>>>> return 0;
>>>>> }
>>>>>
>>>>> +static inline int kgd2kfd_resume_processes(void)
>>>>> +{
>>>>> + return 0;
>>>>> +}
>>>>> +
>>>>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>>>>> {
>>>>> return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index fa4a9f13c922..5827b65b7489 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct 
>>>>> amdgpu_device *adev)
>>>>> if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>>>> amdgpu_device_unmap_mmio(adev);
>>>>>
>>>>> + amdgpu_amdkfd_resume_processes();
>>>>> }
>>>>>
>>>>> void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> index 62aa6c9d5123..ef05aae9255e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool 
>>>>> run_pm)
>>>>> return ret;
>>>>> }
>>>>>
>>>>> +/* for non-runtime resume only */
>>>>> +int kgd2kfd_resume_processes(void)
>>>>> +{
>>>>> + int count;
>>>>> +
>>>>> + count = atomic_dec_return(&kfd_locked);
>>>>> + WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>>>>> + if (count == 0)
>>>>> + return kfd_resume_all_processes();
>>>>> +
>>>>> + return 0;
>>>>> +}
>>>>
>>>> It doesn't make sense to me to just increment kfd_locked in
>>>> kgd2kfd_suspend to only decrement it again a few functions down the
>>>> road.
>>>>
>>>> I suggest this instead - you only incrmemnt if not during PCI remove
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> index 1c2cf3a33c1f..7754f77248a4 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> @@ -952,11 +952,12 @@ bool kfd_is_locked(void)
>>>>
>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>>>> {
>>>> +
>>>> if (!kfd->init_complete)
>>>> return;
>>>>
>>>> /* for runtime suspend, skip locking kfd */
>>>> - if (!run_pm) {
>>>> + if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>> /* For first KFD device suspend all the KFD processes */
>>>> if (atomic_inc_return(&kfd_locked) == 1)
>>>> kfd_suspend_all_processes();
>>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>
>>>>> +
>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>>> {
>>>>> int err = 0;
>
--------------G3H54jcSug8dUQAAb1sXllUz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-13 12:03, Shuotao Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">On Apr 11, 2022, at 11:52 PM, Andrey Grodzovsky
            &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
            wrote:</div>
          <br class="Apple-interchange-newline">
          <div class=""><span style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">[Some people who received this
              message don't often get email from<span class="Apple-converted-space">&nbsp;</span></span><a href="mailto:andrey.grodzovsky@amd.com" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px;" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;
              float: none; display: inline !important;" class="">. Learn
              why this is important at<span class="Apple-converted-space">&nbsp;</span></span><a href="http://aka.ms/LearnAboutSenderIdentification" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px;" class="moz-txt-link-freetext" moz-do-not-send="true">http://aka.ms/LearnAboutSenderIdentification</a><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;
              float: none; display: inline !important;" class="">.]</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">On 2022-04-08 21:28, Shuotao Xu
              wrote:</span><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
              <blockquote type="cite" class="">On Apr 8, 2022, at 11:28
                PM, Andrey Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                wrote:<br class="">
                <br class="">
                [Some people who received this message don't often get
                email from <a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">
                  andrey.grodzovsky@amd.com</a>. Learn why this is
                important at <a href="http://aka.ms/LearnAboutSenderIdentification" class="moz-txt-link-freetext" moz-do-not-send="true">
                  http://aka.ms/LearnAboutSenderIdentification</a>.]<br class="">
                <br class="">
                On 2022-04-08 04:45, Shuotao Xu wrote:<br class="">
                <blockquote type="cite" class="">Adding PCIe Hotplug
                  Support for AMDKFD: the support of hot-plug of GPU<br class="">
                  devices can open doors for many advanced applications
                  in data center<br class="">
                  in the next few years, such as for GPU resource<br class="">
                  disaggregation. Current AMDKFD does not support
                  hotplug out b/o the<br class="">
                  following reasons:<br class="">
                  <br class="">
                  1. During PCIe removal, decrement KFD lock which was
                  incremented at<br class="">
                  the beginning of hw fini; otherwise kfd_open later is
                  going to<br class="">
                  fail.<br class="">
                </blockquote>
                I assumed you read my comment last time, still you do
                same approach.<br class="">
                More in details bellow<br class="">
              </blockquote>
              Aha, I like your fix:) I was not familiar with drm APIs so
              just only half understood your comment last time.<br class="">
              <br class="">
              BTW, I tried hot-plugging out a GPU when rocm application
              is still running.<br class="">
              From dmesg, application is still trying to access the
              removed kfd device, and are met with some errors.<br class="">
            </blockquote>
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">Application us supposed to keep
              running, it holds the drm_device</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">reference as long as it has an open</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">FD to the device and final cleanup
              will come only after the app will die</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">thus releasing the FD and the last</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">drm_device reference.</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              Application would hang and not exiting in this case.<br class="">
            </blockquote>
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
          </div>
        </blockquote>
        <div><br class="">
        </div>
        Actually I tried kill -7 $pid, and the process exists. The dmesg
        has some warning though.</div>
      <div><br class="">
      </div>
      <div>
        <div>[ &nbsp;711.769977] WARNING: CPU: 23 PID: 344 at
          .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336
          amdgpu_bo_release_notify+0x150/0x160 [amdgpu]</div>
        <div>[ &nbsp;711.770528] Modules linked in: amdgpu(OE) amdttm(OE)
          amd_sched(OE) amdkcl(OE) iommu_v2 nf_conntrack_netlink
          nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter
          xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat
          xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
          ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc
          ebtable_filter ebtables ip6table_filter ip6_tables
          iptable_filter overlay binfmt_misc intel_rapl_msr i40iw
          intel_rapl_common skx_edac nfit x86_pkg_temp_thermal
          intel_powerclamp coretemp kvm_intel rpcrdma kvm sunrpc
          ipmi_ssif ib_umad ib_ipoib rdma_ucm irqbypass rapl joydev
          acpi_ipmi input_leds intel_cstate ipmi_si ipmi_devintf mei_me
          mei intel_pch_thermal ipmi_msghandler ioatdma mac_hid lpc_ich
          dca acpi_power_meter acpi_pad sch_fq_codel ib_iser rdma_cm
          iw_cm ib_cm iscsi_tcp libiscsi_tcp libiscsi
          scsi_transport_iscsi pci_stub ip_tables x_tables autofs4 btrfs
          blake2b_generic zstd_compress raid10 raid456 async_raid6_recov
          async_memcpy async_pq async_xor async_tx xor</div>
        <div>[ &nbsp;711.779359] &nbsp;raid6_pq libcrc32c raid1 raid0 multipath
          linear mlx5_ib ib_uverbs ib_core ast drm_vram_helper
          i2c_algo_bit drm_ttm_helper ttm drm_kms_helper syscopyarea
          crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sysfillrect
          uas hid_generic sysimgblt aesni_intel mlx5_core fb_sys_fops
          crypto_simd usbhid cryptd drm i40e pci_hyperv_intf usb_storage
          glue_helper mlxfw hid ahci libahci wmi</div>
        <div>[ &nbsp;711.779752] CPU: 23 PID: 344 Comm: kworker/23:1 Tainted:
          G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;OE &nbsp; &nbsp; 5.11.0+ #1</div>
        <div>[ &nbsp;711.779755] Hardware name: Supermicro
          SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/2018</div>
        <div>[ &nbsp;711.779756] Workqueue: kfd_process_wq
          kfd_process_wq_release [amdgpu]</div>
        <div>[ &nbsp;711.779955] RIP:
          0010:amdgpu_bo_release_notify+0x150/0x160 [amdgpu]</div>
        <div>[ &nbsp;711.780141] Code: e8 b5 af 34 f4 e9 1f ff ff ff 48 39 c2
          74 07 0f 0b e9 69 ff ff ff 4c 89 e7 e8 3c b4 16 00 e9 5c ff ff
          ff e8 a2 ce fd f3 eb cf &lt;0f&gt; 0b eb cb e8 d7 02 34 f4 0f
          1f 80 00 00 00 00 0f 1f 44 00 00 55</div>
        <div>[ &nbsp;711.780143] RSP: 0018:ffffa8100dd67c30 EFLAGS: 00010282</div>
        <div>[ &nbsp;711.780145] RAX: 00000000ffffffea RBX: ffff89980e792058
          RCX: 0000000000000000</div>
        <div>[ &nbsp;711.780147] RDX: 0000000000000000 RSI: ffff89a8f9ad8870
          RDI: ffff89a8f9ad8870</div>
        <div>[ &nbsp;711.780148] RBP: ffffa8100dd67c50 R08: 0000000000000000
          R09: fffffffffff99b18</div>
        <div>[ &nbsp;711.780149] R10: ffffa8100dd67bd0 R11: ffffa8100dd67908
          R12: ffff89980e792000</div>
        <div>[ &nbsp;711.780151] R13: ffff89980e792058 R14: ffff89980e7921bc
          R15: dead000000000100</div>
        <div>[ &nbsp;711.780152] FS: &nbsp;0000000000000000(0000)
          GS:ffff89a8f9ac0000(0000) knlGS:0000000000000000</div>
        <div>[ &nbsp;711.780154] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
          0000000080050033</div>
        <div>[ &nbsp;711.780156] CR2: 00007ffddac6f71f CR3: 00000030bb80a003
          CR4: 00000000007706e0</div>
        <div>[ &nbsp;711.780157] DR0: 0000000000000000 DR1: 0000000000000000
          DR2: 0000000000000000</div>
        <div>[ &nbsp;711.780159] DR3: 0000000000000000 DR6: 00000000fffe0ff0
          DR7: 0000000000000400</div>
        <div>[ &nbsp;711.780160] PKRU: 55555554</div>
        <div>[ &nbsp;711.780161] Call Trace:</div>
        <div>[ &nbsp;711.780163] &nbsp;ttm_bo_release+0x2ae/0x320 [amdttm]</div>
        <div>[ &nbsp;711.780169] &nbsp;amdttm_bo_put+0x30/0x40 [amdttm]</div>
        <div>[ &nbsp;711.780357] &nbsp;amdgpu_bo_unref+0x1e/0x30 [amdgpu]</div>
        <div>[ &nbsp;711.780543] &nbsp;amdgpu_gem_object_free+0x8b/0x160 [amdgpu]</div>
        <div>[ &nbsp;711.781119] &nbsp;drm_gem_object_free+0x1d/0x30 [drm]</div>
        <div>[ &nbsp;711.781489]
          &nbsp;amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380 [amdgpu]</div>
        <div>[ &nbsp;711.782044] &nbsp;kfd_process_device_free_bos+0xe0/0x130
          [amdgpu]</div>
        <div>[ &nbsp;711.782611] &nbsp;kfd_process_wq_release+0x286/0x380 [amdgpu]</div>
        <div>[ &nbsp;711.783172] &nbsp;process_one_work+0x236/0x420</div>
        <div>[ &nbsp;711.783543] &nbsp;worker_thread+0x34/0x400</div>
        <div>[ &nbsp;711.783911] &nbsp;? process_one_work+0x420/0x420</div>
        <div>[ &nbsp;711.784279] &nbsp;kthread+0x126/0x140</div>
        <div>[ &nbsp;711.784653] &nbsp;? kthread_park+0x90/0x90</div>
        <div>[ &nbsp;711.785018] &nbsp;ret_from_fork+0x22/0x30</div>
        <div>[ &nbsp;711.785387] ---[ end trace d8f50f6594817c84 ]---</div>
        <div>[ &nbsp;711.798716] [drm] amdgpu: ttm finalized</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>So it means the process was stuck in some wait_event_killable
      (maybe here drm_sched_entity_flush) - you can try
      'cat/proc/$process_pid/stack' maybe before<br>
      you kill it to see where it was stuck so we can go from there.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com">
      <div>
        <div><br class="">
        </div>
      </div>
      <div>
        <blockquote type="cite" class="">
          <div class=""><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">For graphic apps what i usually see
              is a crash because of sigsev when</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">the app tries to access</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">an unmapped MMIO region on the
              device. I haven't tested for compute</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">stack and so there might</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">be something I haven't covered. Hang
              could mean for example waiting on a</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">fence which is not being</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">signaled - please provide full dmesg
              from this case.</span><br style="caret-color: rgb(0, 0,
              0); font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
              Do you have any good suggestions on how to fix it down the
              line? (HIP runtime/libhsakmt or driver)<br class="">
              <br class="">
              [64036.631333] amdgpu: amdgpu_vm_bo_update failed<br class="">
              [64036.631702] amdgpu: validate_invalid_user_pages: update
              PTE failed<br class="">
              [64036.640754] amdgpu: amdgpu_vm_bo_update failed<br class="">
              [64036.641120] amdgpu: validate_invalid_user_pages: update
              PTE failed<br class="">
              [64036.650394] amdgpu: amdgpu_vm_bo_update failed<br class="">
              [64036.650765] amdgpu: validate_invalid_user_pages: update
              PTE failed<br class="">
            </blockquote>
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
          </div>
        </blockquote>
        <div><br class="">
        </div>
        The full dmesg will just the repetition of those two messages,</div>
      <div>
        <div>[186885.764079] amdgpu 0000:43:00.0: amdgpu: amdgpu:
          finishing device.</div>
        <div>[186885.766916] [drm] free PSP TMR buffer</div>
        <div>[186893.868173] amdgpu: amdgpu_vm_bo_update failed</div>
        <div>[186893.868235] amdgpu: validate_invalid_user_pages: update
          PTE failed</div>
        <div>[186893.876154] amdgpu: amdgpu_vm_bo_update failed</div>
        <div>[186893.876190] amdgpu: validate_invalid_user_pages: update
          PTE failed</div>
        <div>[186893.884150] amdgpu: amdgpu_vm_bo_update failed</div>
        <div>[186893.884185] amdgpu: validate_invalid_user_pages: update
          PTE failed</div>
      </div>
      <div><br class="">
      </div>
      <div>
        <blockquote type="cite" class="">
          <div class=""><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">This just probably means trying to
              update PTEs after the physical device</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">is gone - we usually avoid this by</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">first trying to do all HW shutdowns
              early before PCI remove completion</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">but when it's really tricky by</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">protecting HW access sections with
              drm_dev_enter/exit scope.</span><br style="caret-color:
              rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">For this particular error it would
              be the best to flush</span><br style="caret-color: rgb(0,
              0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">info-&gt;restore_userptr_work before
              the end of</span><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">amdgpu_pci_remove (rejecting new
              process creation and calling</span><br style="caret-color:
              rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">cancel_delayed_work_sync(&amp;process_info-&gt;restore_userptr_work)
              for all</span><br style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">running processes)</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <span style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">somewhere in amdgpu_pci_remove.</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br class="">
          </div>
        </blockquote>
        I tried something like *kfd_process_ref_release* which I think
        did what you described, but it did not work.</div>
    </blockquote>
    <p><br>
    </p>
    <p>I don't see how kfd_process_ref_release is the same as I
      mentioned above, what i meant is calling the code above within
      kgd2kfd_suspend (where you tried to call
      kfd_kill_all_user_processes bellow) <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com">
      <div><br class="">
      </div>
      <div>Instead I tried to kill the process from the kernel, but the
        amdgpu could **only** be hot-plugged in back successfully only
        if there was no rocm kernel running when it was plugged out. If
        not, amdgpu_probe will just hang later. (Maybe because amdgpu
        was plugged out while running state, it leaves a bad HW state
        which causes probe to hang).</div>
    </blockquote>
    <p><br>
    </p>
    <p>We usually do asic_reset during probe to reset all HW state
      (checlk if amdgpu_device_init-&gt;amdgpu_asic_reset is running
      when you&nbsp; plug back). <br>
    </p>
    <p>&nbsp; <br>
    </p>
    <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com">
      <div><br class="">
      </div>
      <div>I don’t know if this is a viable solution worth pursuing, but
        I attached the diff anyway.</div>
      <div><br class="">
      </div>
      <div>Another solution could be let compute stack user mode detect
        a topology change via&nbsp;<span class="">generation_count change,
          and abort gracefully there.</span></div>
      <div class=""><br class="">
      </div>
      <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
      <div>index 4e7d9cb09a69..79b4c9b84cd0 100644</div>
      <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
      <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
      <div>@@ -697,12 +697,15 @@ void kgd2kfd_suspend(struct kfd_dev
        *kfd, bool run_pm, bool force)</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
      <div><br class="">
      </div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; /* for runtime suspend, skip locking kfd */</div>
      <div>- &nbsp; &nbsp; &nbsp; if (!run_pm) {</div>
      <div>+ &nbsp; &nbsp; &nbsp; if (!run_pm &amp;&amp;
        !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* For first KFD device suspend all the KFD
        processes */</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (atomic_inc_return(&amp;kfd_locked) == 1)</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kfd_suspend_all_processes(force);</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; }</div>
      <div><br class="">
      </div>
      <div>+ &nbsp; &nbsp; &nbsp; if (drm_dev_is_unplugged(kfd-&gt;ddev))</div>
      <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kfd_kill_all_user_processes();</div>
      <div>+</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; kfd_iommu_suspend(kfd);</div>
      <div>&nbsp;}</div>
      <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
      <div>index 55c9e1922714..84cbcd857856 100644</div>
      <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
      <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
      <div>@@ -1065,6 +1065,7 @@ void kfd_unref_process(struct
        kfd_process *p);</div>
      <div>&nbsp;int kfd_process_evict_queues(struct kfd_process *p, bool
        force);</div>
      <div>&nbsp;int kfd_process_restore_queues(struct kfd_process *p);</div>
      <div>&nbsp;void kfd_suspend_all_processes(bool force);</div>
      <div>+void kfd_kill_all_user_processes(void);</div>
      <div>&nbsp;/*</div>
      <div>&nbsp; * kfd_resume_all_processes:</div>
      <div>&nbsp; * &nbsp; &nbsp; bool sync: If kfd_resume_all_processes() should wait
        for the</div>
      <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
      <div>index 6cdc855abb6d..fb0c753b682c 100644</div>
      <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
      <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
      <div>@@ -2206,6 +2206,24 @@ void kfd_suspend_all_processes(bool
        force)</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; srcu_read_unlock(&amp;kfd_processes_srcu, idx);</div>
      <div>&nbsp;}</div>
      <div><br class="">
      </div>
      <div>+</div>
      <div>+void kfd_kill_all_user_processes(void)</div>
      <div>+{</div>
      <div>+ &nbsp; &nbsp; &nbsp; struct kfd_process *p;</div>
      <div>+ &nbsp; &nbsp; &nbsp; struct amdkfd_process_info *p_info;</div>
      <div>+ &nbsp; &nbsp; &nbsp; unsigned int temp;</div>
      <div>+ &nbsp; &nbsp; &nbsp; int idx = srcu_read_lock(&amp;kfd_processes_srcu);</div>
      <div>+</div>
      <div>+ &nbsp; &nbsp; &nbsp; pr_info(&quot;Killing all processes\n&quot;);</div>
      <div>+ &nbsp; &nbsp; &nbsp; hash_for_each_rcu(kfd_processes_table, temp, p,
        kfd_processes) {</div>
      <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p_info = p-&gt;kgd_process_info;</div>
      <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pr_info(&quot;Killing &nbsp;processes, pid = %d&quot;,
        pid_nr(p_info-&gt;pid));</div>
      <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kill_pid(p_info-&gt;pid, SIGBUS, 1);</div>
    </blockquote>
    <p><br>
    </p>
    <p>From looking into kill_pid I see it only sends a signal but
      doesn't wait for completion, it would make sense to wait for
      completion here. In any case I would actually try to put here<span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
        font-size: 12px; font-style: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        text-decoration: none; float: none; display: inline !important;" class=""><br>
      </span><span style="caret-color: rgb(0, 0, 0); font-family:
        Helvetica; font-size: 12px; font-style: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; text-align: start; text-indent: 0px; text-transform:
        none; white-space: normal; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; text-decoration: none; float:
        none; display: inline !important;" class=""><font size="4"><br>
        </font></span></p>
    <p><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
        font-size: 12px; font-style: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        text-decoration: none; float: none; display: inline !important;" class=""><font size="4">hash_for_each_rcu(</font></span><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
        font-size: 12px; font-style: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        text-decoration: none; float: none; display: inline !important;" class=""><font size="4">p_info) &nbsp;&nbsp; <br>
          &nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;</font></span><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
        font-size: 12px; font-style: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        text-decoration: none; float: none; display: inline !important;" class=""><font size="4"><span style="caret-color: rgb(0, 0, 0);
            font-family: Helvetica; font-size: 12px; font-style: normal;
            font-variant-caps: normal; font-weight: 400; letter-spacing:
            normal; text-align: start; text-indent: 0px; text-transform:
            none; white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; text-decoration: none;
            float: none; display: inline !important;" class=""></span><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; text-decoration: none;
            float: none; display: inline !important;" class=""><font size="4">p_info</font></span>-&gt;restore_userptr_work) <br>
        </font></span></p>
    <p><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
        font-size: 12px; font-style: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        text-decoration: none; float: none; display: inline !important;" class=""><font size="4">instead&nbsp; at least that what i meant in
          the previous mail. <br>
        </font></span></p>
    <p><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
        font-size: 12px; font-style: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        text-decoration: none; float: none; display: inline !important;" class=""><font size="4">Andrey</font><br>
        <br>
      </span></p>
    <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com">
      <div>+ &nbsp; &nbsp; &nbsp; }</div>
      <div>+ &nbsp; &nbsp; &nbsp; srcu_read_unlock(&amp;kfd_processes_srcu, idx);</div>
      <div>+}</div>
      <div>+</div>
      <div>+</div>
      <div>&nbsp;int kfd_resume_all_processes(bool sync)</div>
      <div>&nbsp;{</div>
      <div>&nbsp; &nbsp; &nbsp; &nbsp; struct kfd_process *p;</div>
      <div><br class="">
      </div>
      <div><br class="">
        <blockquote type="cite" class="">
          <div class=""><span style="caret-color: rgb(0, 0, 0);
              font-family: Helvetica; font-size: 12px; font-style:
              normal; font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none; float: none; display: inline
              !important;" class="">Andrey</span><br style="caret-color:
              rgb(0, 0, 0); font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <br style="caret-color: rgb(0, 0, 0); font-family:
              Helvetica; font-size: 12px; font-style: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              text-decoration: none;" class="">
            <blockquote type="cite" style="font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal; orphans:
              auto; text-align: start; text-indent: 0px; text-transform:
              none; white-space: normal; widows: auto; word-spacing:
              0px; -webkit-text-size-adjust: auto;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
              Really appreciate your help!<br class="">
              <br class="">
              Best,<br class="">
              Shuotao<br class="">
              <br class="">
              <blockquote type="cite" class="">
                <blockquote type="cite" class="">2. Remove redudant
                  p2p/io links in sysfs when device is hotplugged<br class="">
                  out.<br class="">
                  <br class="">
                  3. New kfd node_id is not properly assigned after a
                  new device is<br class="">
                  added after a gpu is hotplugged out in a system.
                  libhsakmt will<br class="">
                  find this anomaly, (i.e. node_from != &lt;dev node
                  id&gt; in iolinks),<br class="">
                  when taking a topology_snapshot, thus returns fault to
                  the rocm<br class="">
                  stack.<br class="">
                  <br class="">
                  -- This patch fixes issue 1; another patch by Mukul
                  fixes issues 2&amp;3.<br class="">
                  -- Tested on a 4-GPU MI100 gpu nodes with kernel
                  5.13.0-kfd; kernel<br class="">
                  5.16.0-kfd is unstable out of box for MI100.<br class="">
                  ---<br class="">
                  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++<br class="">
                  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++<br class="">
                  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<br class="">
                  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13
                  +++++++++++++<br class="">
                  4 files changed, 26 insertions(+)<br class="">
                  <br class="">
                  diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                  index c18c4be1e4ac..d50011bdb5c4 100644<br class="">
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                  @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct
                  amdgpu_device *adev, bool run_pm)<br class="">
                  return r;<br class="">
                  }<br class="">
                  <br class="">
                  +int amdgpu_amdkfd_resume_processes(void)<br class="">
                  +{<br class="">
                  + return kgd2kfd_resume_processes();<br class="">
                  +}<br class="">
                  +<br class="">
                  int amdgpu_amdkfd_pre_reset(struct amdgpu_device
                  *adev)<br class="">
                  {<br class="">
                  int r = 0;<br class="">
                  diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                  index f8b9f27adcf5..803306e011c3 100644<br class="">
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                  @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);<br class="">
                  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev,
                  bool run_pm);<br class="">
                  int amdgpu_amdkfd_resume_iommu(struct amdgpu_device
                  *adev);<br class="">
                  int amdgpu_amdkfd_resume(struct amdgpu_device *adev,
                  bool run_pm);<br class="">
                  +int amdgpu_amdkfd_resume_processes(void);<br class="">
                  void amdgpu_amdkfd_interrupt(struct amdgpu_device
                  *adev,<br class="">
                  const void *ih_ring_entry);<br class="">
                  void amdgpu_amdkfd_device_probe(struct amdgpu_device
                  *adev);<br class="">
                  @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct
                  kfd_dev *kfd);<br class="">
                  void kgd2kfd_suspend(struct kfd_dev *kfd, bool
                  run_pm);<br class="">
                  int kgd2kfd_resume_iommu(struct kfd_dev *kfd);<br class="">
                  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);<br class="">
                  +int kgd2kfd_resume_processes(void);<br class="">
                  int kgd2kfd_pre_reset(struct kfd_dev *kfd);<br class="">
                  int kgd2kfd_post_reset(struct kfd_dev *kfd);<br class="">
                  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void
                  *ih_ring_entry);<br class="">
                  @@ -393,6 +395,11 @@ static inline int
                  kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)<br class="">
                  return 0;<br class="">
                  }<br class="">
                  <br class="">
                  +static inline int kgd2kfd_resume_processes(void)<br class="">
                  +{<br class="">
                  + return 0;<br class="">
                  +}<br class="">
                  +<br class="">
                  static inline int kgd2kfd_pre_reset(struct kfd_dev
                  *kfd)<br class="">
                  {<br class="">
                  return 0;<br class="">
                  diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                  index fa4a9f13c922..5827b65b7489 100644<br class="">
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                  @@ -4004,6 +4004,7 @@ void
                  amdgpu_device_fini_hw(struct amdgpu_device *adev)<br class="">
                  if (drm_dev_is_unplugged(adev_to_drm(adev)))<br class="">
                  amdgpu_device_unmap_mmio(adev);<br class="">
                  <br class="">
                  + amdgpu_amdkfd_resume_processes();<br class="">
                  }<br class="">
                  <br class="">
                  void amdgpu_device_fini_sw(struct amdgpu_device *adev)<br class="">
                  diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                  b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                  index 62aa6c9d5123..ef05aae9255e 100644<br class="">
                  --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                  +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                  @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev
                  *kfd, bool run_pm)<br class="">
                  return ret;<br class="">
                  }<br class="">
                  <br class="">
                  +/* for non-runtime resume only */<br class="">
                  +int kgd2kfd_resume_processes(void)<br class="">
                  +{<br class="">
                  + int count;<br class="">
                  +<br class="">
                  + count = atomic_dec_return(&amp;kfd_locked);<br class="">
                  + WARN_ONCE(count &lt; 0, &quot;KFD suspend / resume ref.
                  error&quot;);<br class="">
                  + if (count == 0)<br class="">
                  + return kfd_resume_all_processes();<br class="">
                  +<br class="">
                  + return 0;<br class="">
                  +}<br class="">
                </blockquote>
                <br class="">
                It doesn't make sense to me to just increment kfd_locked
                in<br class="">
                kgd2kfd_suspend to only decrement it again a few
                functions down the<br class="">
                road.<br class="">
                <br class="">
                I suggest this instead - you only incrmemnt if not
                during PCI remove<br class="">
                <br class="">
                diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                index 1c2cf3a33c1f..7754f77248a4 100644<br class="">
                --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                @@ -952,11 +952,12 @@ bool kfd_is_locked(void)<br class="">
                <br class="">
                void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)<br class="">
                {<br class="">
                +<br class="">
                if (!kfd-&gt;init_complete)<br class="">
                return;<br class="">
                <br class="">
                /* for runtime suspend, skip locking kfd */<br class="">
                - if (!run_pm) {<br class="">
                + if (!run_pm &amp;&amp;
                !drm_dev_is_unplugged(kfd-&gt;ddev)) {<br class="">
                /* For first KFD device suspend all the KFD processes */<br class="">
                if (atomic_inc_return(&amp;kfd_locked) == 1)<br class="">
                kfd_suspend_all_processes();<br class="">
                <br class="">
                <br class="">
                Andrey<br class="">
                <br class="">
                <br class="">
                <br class="">
                <blockquote type="cite" class="">+<br class="">
                  int kgd2kfd_resume_iommu(struct kfd_dev *kfd)<br class="">
                  {<br class="">
                  int err = 0;</blockquote>
              </blockquote>
            </blockquote>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------G3H54jcSug8dUQAAb1sXllUz--
