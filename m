Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCD3C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 17:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC98E10E349;
	Thu, 15 Feb 2024 17:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dH7ZJV7j";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6739110E2EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 17:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHe3IDQAOwW5DPFZCgJH+l8I0IAqddrU7eCHfpHdi5Lw4OdHBJhKatXkxb2cDEFXnfHu6oAppM5IZ4KlWVUE0kO3pFydAqgy+hqp4WewgfwoRp+oPK8unf3OGtbi2sZeTMFmnxllMofu/fmGkJ1Wp+lJTWp2LSp/eOvAm2gGRa0XDnf1vEcjBXxawCr/U7sAFg5dkDNnMfYctHgpf1DD3ecQc9eQVtpgh2Cg4+/bitOt/c2iTsBCdMLuVWn1EXy8nbDIiTHNy5+93pNCGbrpmxsTJVlA3yNPWAVynRbdMjxt7FY235/iR97EgZ1nAe32dsOgHKuVARixIsLgsaXY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS9SdoDwr3xl3N45bHxDU1LOzWp+s8TPYJGbAcvI7ZI=;
 b=LRXbYsVSoafM1Hf7H/rKQGGW/c0BV7QQVgNeOOMwNj20eVU3DwHv6i5+CBemVgFmU77YT9OfUV1Rj6bB08TWRpC+yTN38nFtMpcdAnb+uyA2toYFse+7QDdlH0DLx3aH16qxsowhbIaPTPEWVY78dnCBMaRHHLy0IckuBpcWIJ9Vw/p8nCs0RUmt3WsPwJQXJbPC7DO8a90b76FBylHXtDe9uUQn9yI2EjPoCfupQxxf4b4lDQ+MY1bVek+OdVrYj3xqOGVueH9l/zmD698l1xoN6y8muUPkEdeMyLSqjxxPNN3+0i6GVLFvM2iorwEeHCExSW2Yk/KKPGdsqhTX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS9SdoDwr3xl3N45bHxDU1LOzWp+s8TPYJGbAcvI7ZI=;
 b=dH7ZJV7j+hiaWXpaGiDl9qlCVphHgFLJzeEk1QLl3nHwEpy1q1imL27AwNVh2LMnrthQAzvf+BMoLx9Ey3uZ7XhhmbNVYGjSrzLmT0itRpnk+7ZKqzD2oPcK+uahOT7MqjSlmQXXcGNl6uYzw0OfrzvhPdTIrosjK2o+Zfebrkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 17:54:44 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::9a4d:50ce:1b1b:8472]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::9a4d:50ce:1b1b:8472%6]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 17:54:40 +0000
Message-ID: <22db7ab1-c48c-c982-8c67-f2418becdda9@amd.com>
Date: Thu, 15 Feb 2024 11:54:38 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Document and define SVM event tracing
 macro
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240215151830.22416-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240215151830.22416-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0038.namprd15.prod.outlook.com
 (2603:10b6:408:80::15) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: ced7099e-7257-4ff4-8df6-08dc2e4f2f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGGkokJv9zF2Z1P25Dp0sywh67OnV7jvjPzzE1bBf1EjRNA9io6zQayTafOs9Xaz/pb1KmZZVE0yv+XVNl+mAyJ5k0jFB4twjn2/NXLLRGVXsyMtSk1EUlQKTAoNgyXchUEB5HgHW7Y/klSXOupMbVY02ZwW8LkRaCKxiDMphDptp939x2vsw/KvFNkW6zjPHpXsspmY9PRVmV6yaEYI+WcDSaVPOm8obhRuzac/ZlpKsOvuHm+iH/HQRMIiFBJMfq6mkuHD1+eGoRM7X28LwtlBP6Pue6otdP0CAP7uI99VE/Q2TEWM5nmqJWp8c0lBKWPXvrtOUnNIzIzBKs3ifTPMosSoLTo+qUstg3fMD3L6ng28c40/E7Xmx2+tCZSsfBNEv6OJ8cEZmLU1UInSktweKM329vxZlmKup0E4mztFs2CQKrB3ecGD0vGooB9jb418x9UKZuzpWisoIMM6+2SrwkeZKSaCpO99ulroIFgyhh4qtVHlTajGzyE4B5QANhvDYygUIK3lHZj6QxQnNo1OLrW55eZcpjCooZe3hVsPon4vGFmpzllg6mmW2/wC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(86362001)(8676002)(31696002)(6486002)(30864003)(478600001)(6506007)(2906002)(53546011)(8936002)(6512007)(4326008)(5660300002)(66476007)(66556008)(26005)(83380400001)(41300700001)(316002)(2616005)(66946007)(36756003)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNDaHptQnpqSy9CL2w2TTRHUDhmY3dKb0xoZUpETHBEOEVYejVxY2E4Z3Y0?=
 =?utf-8?B?a2pKUFJkcGQ3azVxcE9vYTdLc0oyQkpKb2dFU1JNay9ZL3NiRXhsaU9HdG9s?=
 =?utf-8?B?bE9PTlIvR1NyYXhBb29wOWJKZ3EzMlpVZmswZjNXR2JMV3V3Q3VjUFFqdDJP?=
 =?utf-8?B?VzlTUUw3MHM1QUxqbkt1eSt5aWxrYzVYV3FJemNyb2RSU2J5YXoyWFMxa2Nh?=
 =?utf-8?B?cFNpdTMzUVVsRGc1bk9wdlNjN0FvTkpaSXJTR2FkbGluWUlmL0VBb3dpNG9U?=
 =?utf-8?B?ZFEvT0R5RjBKdmtwUTllbmVkZGZNb3kzTDhWM0dyNkhkdFduRDcrbUtTMHhk?=
 =?utf-8?B?ZHpxZjFMMmVKTnJOZXZxUjg3Q281a015aFRqMkRBWHllVi9wc1ZTbGZMT1Rp?=
 =?utf-8?B?eTZaaUVLNlB6bUxCSUJ2bW53L3Q2bDF6aExobjk2TVNMY1cxT1FaYmMzbWc5?=
 =?utf-8?B?VzRhbExGdjNQSEhoV1NNdHVBYXJkbUtIM2FwdFdVK2hudUNwUG4yOXZ6Qlgr?=
 =?utf-8?B?cm54SStSb3pUZHdXUVMzUmxNMFFya1Z3YWlKenhXOEZqczRnVDZ0WG9QUlJi?=
 =?utf-8?B?VzhJN3FDU3JDZHlrRlV5citZdno5VmcyWGN6SVgyU1IrU2RVNm9JOXRXbTdC?=
 =?utf-8?B?S05XWXRjakxXaC9YVEtTNWI5U3FUanBzdzJicXluN3JYZjVPbzB2VXRIVUVV?=
 =?utf-8?B?aWF2Yi9XQlErb1VTRTg0MC9hb1dkcW1MQ2tyQ1BpMUVpTHhvOUFFTWxBeDFK?=
 =?utf-8?B?clFTUlZhK2Y4MGw2eEdGQnkvRHJLSVRIWnBwaG1uMk9EaFZSZ092RkhXUVhG?=
 =?utf-8?B?elVvTkpXOGRqZUJrd2JySVl1eFliYXFmY2pqVW9hQU5ydzJ3aWJERVpRMTZI?=
 =?utf-8?B?ZEROSDF3TEtVOTFWY1JVTkFUN0k5dkhtbGRtcUJuYWNES3M4eTdKaktYQlNt?=
 =?utf-8?B?Qjl3Q05qd2pmL2pYRHdzY3pMRnVUMDFEN1ZmQ1FlTG1yWWZMcEFYSGZSSktY?=
 =?utf-8?B?Sk9xa1EyM1dHSFRqVHJkektyajgrTnJYVXRZVUIzOHZ2Z1c4a3RYMU9PK0No?=
 =?utf-8?B?aDZnSlcyWTA4R0x4ekhPZGhjSUEzd0RsekJnWW44NDFZWHFVd042OXVrSVdv?=
 =?utf-8?B?QnZET3NnMnhZOWt0d091R05hRFBNSU5ya1RSSzhPSE9CaENHSExQRGs3OHlK?=
 =?utf-8?B?MU1ZVmdkZVIwK255UDNuQ3Q2Ty9jU0t5dElEUWFqQzNUVG82bVQrOHJCaXFG?=
 =?utf-8?B?ZW5oT3YyQXY1R2VvdEZ0dFZvSGdWaXpQRVVwUDVmVWpySW9IcWNGcExYVWtv?=
 =?utf-8?B?Rzd6U3lmUUIwaGh1NEZqYStGWXpHVlRoVUN4WWlmMUFnZnd2WW5adzhoa0Js?=
 =?utf-8?B?bGQxTWZLcVdodzlnazhsajR5cGc5VE5aQll3cUVUeWtMZEFZcHQrNUdyV1Js?=
 =?utf-8?B?dTcxeXp1UjhzNit2bXRqNDZtemJoNjdScUZsVTZoMXk1b3dUOVhPKzhaeGxC?=
 =?utf-8?B?Ym1JZFFhYzN1amcvd1ROOWQyVkwzeTJLTU1tS1FZajhmTE9RclJ0L1VQenkx?=
 =?utf-8?B?UWlDbmw1QUpyaElBVDFjaE9XMmoyd25SaklCd0VmN2hFUGxNZitYV0JIYVJB?=
 =?utf-8?B?a29hS1NDNUNDekQ5MSs3ZlZyS1JvOXBNelFINjYrOXNhNTZ2Tm0ydXB2bTJX?=
 =?utf-8?B?RW53b1oyWk91SVRFcFlVSlBxV1NOZmZuWjduUEM2TlJ1eDIwV2gvYnN1RlEr?=
 =?utf-8?B?ZzVJS2dFcXlodTg1dkpobzZsQ2RRRnhwdGJrczFldnRSaEFad3ZLWGk0NEt1?=
 =?utf-8?B?N3RCUVNHYlpUR2Q2SUt5UVNsZUpZdndUclhqTDN6WjJDMVNrKzJRcFFScTd3?=
 =?utf-8?B?aVNkK2JNYk1xZ0JLQTdXWDRabnhpTHE5R3ByRSt4SmZlM09Qdy8yUFFVN25B?=
 =?utf-8?B?MXhad1FmM2YvQXRkaWY1SkNmdHBMdkdZSkZLUHgyVkpkOGNPTk5DVUVmeThk?=
 =?utf-8?B?OUpncjU4MFFvSHplMlVIM3A3ZUhqVmF0SG5CWHN1V0E5TmNxaUZMRWU3bi9q?=
 =?utf-8?B?UE9DVHhTNEVwaTVlQU1mcE5LbDdtcGdNaXg0Vk5TenlxU0JQVDZ0WndHYzRM?=
 =?utf-8?Q?2Kcs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced7099e-7257-4ff4-8df6-08dc2e4f2f0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:54:40.7702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z//Czk/FngLxLsf6PZAIk3xAUFXaGsNrEa0lcjA+y1wwJHPx/9hh/A6rxn7Fb4tB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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


On 2/15/2024 9:18 AM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Document how to use SMI system management interface to receive SVM
> events.
>
> Define SVM events message string format macro that could use by user
> mode for sscanf to parse the event. Add it to uAPI header file to make
> it obvious that is changing uAPI in future.
>
> No functional changes.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 51 +++++++-------
>   include/uapi/linux/kfd_ioctl.h              | 77 ++++++++++++++++++++-
>   2 files changed, 102 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index d9953c2b2661..85465eb303a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -225,15 +225,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>                  event = KFD_SMI_EVENT_GPU_PRE_RESET;
>                  ++(dev->reset_seq_num);
>          }
> -       kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
> +       kfd_smi_event_add(0, dev, event,
> +                         KFD_EVENT_FMT_UPDATE_GPU_RESET(dev->reset_seq_num));
>   }
>
>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>                                               uint64_t throttle_bitmask)
>   {
> -       kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
> -                         throttle_bitmask,
> -                         amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
> +       kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
> +                         KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(throttle_bitmask,
> +                         amdgpu_dpm_get_thermal_throttling_counter(dev->adev)));
>   }
>
>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
> @@ -246,8 +247,8 @@ void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>          if (!task_info.pid)
>                  return;
>
> -       kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
> -                         task_info.pid, task_info.task_name);
> +       kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT,
> +                         KFD_EVENT_FMT_VMFAULT(task_info.pid, task_info.task_name));
>   }
>
>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
> @@ -255,16 +256,16 @@ void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>                                      ktime_t ts)
>   {
>          kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
> -                         "%lld -%d @%lx(%x) %c\n", ktime_to_ns(ts), pid,
> -                         address, node->id, write_fault ? 'W' : 'R');
> +                         KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,
> +                         address, node->id, write_fault ? 'W' : 'R'));
>   }
>
>   void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
>                                    unsigned long address, bool migration)
>   {
>          kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
> -                         "%lld -%d @%lx(%x) %c\n", ktime_get_boottime_ns(),
> -                         pid, address, node->id, migration ? 'M' : 'U');
> +                         KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
> +                         pid, address, node->id, migration ? 'M' : 'U'));
>   }
>
>   void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
> @@ -274,9 +275,9 @@ void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
>                                     uint32_t trigger)
>   {
>          kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
> -                         "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
> -                         ktime_get_boottime_ns(), pid, start, end - start,
> -                         from, to, prefetch_loc, preferred_loc, trigger);
> +                         KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
> +                         pid, start, end - start, from, to, prefetch_loc,
> +                         preferred_loc, trigger));
>   }
>
>   void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
> @@ -284,24 +285,23 @@ void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
>                                   uint32_t from, uint32_t to, uint32_t trigger)
>   {
>          kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
> -                         "%lld -%d @%lx(%lx) %x->%x %d\n",
> -                         ktime_get_boottime_ns(), pid, start, end - start,
> -                         from, to, trigger);
> +                         KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(), pid,
> +                         start, end - start, from, to, trigger));
>   }
>
>   void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
>                                    uint32_t trigger)
>   {
>          kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
> -                         "%lld -%d %x %d\n", ktime_get_boottime_ns(), pid,
> -                         node->id, trigger);
> +                         KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
> +                         pid, node->id, trigger));
>   }
>
>   void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
>   {
>          kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
> -                         "%lld -%d %x\n", ktime_get_boottime_ns(), pid,
> -                         node->id);
> +                         KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
> +                         pid, node->id));
>   }
>
>   void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
> @@ -317,9 +317,10 @@ void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
>                  struct kfd_process_device *pdd = p->pdds[i];
>
>                  kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
> -                                 KFD_SMI_EVENT_QUEUE_RESTORE,
> -                                 "%lld -%d %x %c\n", ktime_get_boottime_ns(),
> -                                 p->lead_thread->pid, pdd->dev->id, 'R');
> +                                 KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED,
> +                                 KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(
> +                                 ktime_get_boottime_ns(), p->lead_thread->pid,
> +                                 pdd->dev->id, 'R'));
>          }
>          kfd_unref_process(p);
>   }
> @@ -329,8 +330,8 @@ void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
>                                    uint32_t trigger)
>   {
>          kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
> -                         "%lld -%d @%lx(%lx) %x %d\n", ktime_get_boottime_ns(),
> -                         pid, address, last - address + 1, node->id, trigger);
> +                         KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
> +                         pid, address, last - address + 1, node->id, trigger));
>   }
>
>   int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 9ce46edc62a5..430c01f4148b 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -523,7 +523,8 @@ enum kfd_smi_event {
>          KFD_SMI_EVENT_PAGE_FAULT_END = 8,
>          KFD_SMI_EVENT_QUEUE_EVICTION = 9,
>          KFD_SMI_EVENT_QUEUE_RESTORE = 10,
> -       KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
> +       KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED = 11,
> +       KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,

Why change KFD_SMI_EVENT_UNMAP_FROM_GPU from 11 to 12? That breaks 
existing api with user space, ex, thunk use HSA_SMI_EVENT_UNMAP_FROM_GPU 
= 11,

Regards

Xiaogang

>          /*
>           * max event number, as a flag bit to get events from all processes,
> @@ -564,6 +565,80 @@ struct kfd_ioctl_smi_events_args {
>          __u32 anon_fd;  /* from KFD */
>   };
>
> +/*
> + * SVM event tracing via SMI system management interface
> + *
> + * Open event file descriptor
> + *    use ioctl AMDKFD_IOC_SMI_EVENTS, pass in gpuid and return a anonymous file
> + *    descriptor to receive SMI events.
> + *    If calling with sudo permission, then file descriptor can be used to receive
> + *    SVM events from all processes, otherwise, to only receive SVM events of same
> + *    process.
> + *
> + * To enable the SVM event
> + *    Write event file descriptor with KFD_SMI_EVENT_MASK_FROM_INDEX(event) bitmap
> + *    mask to start record the event to the kfifo, use bitmap mask combination
> + *    for multiple events. New event mask will overwrite the previous event mask.
> + *    KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS) bit requires sudo
> + *    permisson to receive SVM events from all process.
> + *
> + * To receive the event
> + *    Application can poll file descriptor to wait for the events, then read event
> + *    from the file into a buffer. Each event is one line string message, starting
> + *    with the event id, then the event specific information.
> + *
> + * To decode event information
> + *    The following event format string macro can be used with sscanf to decode
> + *    the specific event information.
> + *    event triggers: the reason to generate the event, defined as enum for unmap,
> + *    eviction and migrate events.
> + *    node, from, to, prefetch_loc, preferred_loc: GPU ID, or 0 for system memory.
> + *    addr: user mode address, in pages
> + *    size: in pages
> + *    pid: the process ID to generate the event
> + *    ns: timestamp in nanosecond-resolution, starts at system boot time but
> + *        stops during suspend
> + *    migrate_update: the GPU page is recovered by 'M' for migrate, 'U' for update
> + *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
> + *    rw: 'W' for write page fault, 'R' for read page fault
> + */
> +#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num)\
> +               "%x\n", (reset_seq_num)
> +
> +#define KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(bitmask, counter)\
> +               "%llx:%llx\n", (bitmask), (counter)
> +
> +#define KFD_EVENT_FMT_VMFAULT(pid, task_name)\
> +               "%x:%s\n", (pid), (task_name)
> +
> +#define KFD_EVENT_FMT_PAGEFAULT_START(ns, pid, addr, node, rw)\
> +               "%lld -%d @%lx(%x) %c\n", (ns), (pid), (addr), (node), (rw)
> +
> +#define KFD_EVENT_FMT_PAGEFAULT_END(ns, pid, addr, node, migrate_update)\
> +               "%lld -%d @%lx(%x) %c\n", (ns), (pid), (addr), (node), (migrate_update)
> +
> +#define KFD_EVENT_FMT_MIGRATE_START(ns, pid, start, size, from, to, prefetch_loc,\
> +               preferred_loc, migrate_trigger)\
> +               "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n", (ns), (pid), (start), (size),\
> +               (from), (to), (prefetch_loc), (preferred_loc), (migrate_trigger)
> +
> +#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from, to, migrate_trigger)\
> +               "%lld -%d @%lx(%lx) %x->%x %d\n", (ns), (pid), (start), (size),\
> +               (from), (to), (migrate_trigger)
> +
> +#define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node, evict_trigger)\
> +               "%lld -%d %x %d\n", (ns), (pid), (node), (evict_trigger)
> +
> +#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node)\
> +               "%lld -%d %x\n", (ns), (pid), (node)
> +
> +#define KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(ns, pid, node, rescheduled)\
> +               "%lld -%d %x %c\n", (ns), (pid), (node), (rescheduled)
> +
> +#define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node, unmap_trigger)\
> +               "%lld -%d @%lx(%lx) %x %d\n", (ns), (pid), (addr), (size),\
> +               (node), (unmap_trigger)
> +
>   /**************************************************************************************************
>    * CRIU IOCTLs (Checkpoint Restore In Userspace)
>    *
> --
> 2.35.1
>
