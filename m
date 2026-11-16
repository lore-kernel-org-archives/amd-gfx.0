Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9E606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QxgEMnfr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499B910E384;
	Mon, 16 Nov 2026 12:21:14 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACE310E384
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 12:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjCcL3CsLBGIqYLFAdsFK4W2iolsnOw28vMKUHnduFsUVXcTh2sLryneLEorKsvlvQH7wMC3OMBlzdA73t7AkXcjvlMQ1ggozxW9xzx63PVouOmpon+bSbkTwjA/tfk3ZYEHraekBPRFtk8wCG1SBm1YyXNsQskmQeKZtYFuuuUL36RZ24yh9l4os+eP8DNABrN5dd64lMq+lYlTZnjbH6NLddjMs9XYUQWzwUJZmmLnVgzDJh53jb8uUAZ6g/bglsWPzrzCiWSxr2qVIhRtbHC61Yw0HCr3aBBnNAId+vEI09V7zVRyj4qBrk3DBD7QCI4XSTgW0mHxonZ/DPQEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXWNzJw+YJ4c4c8nTQPgd1G9pNL8T9z7odOWPYUQnDQ=;
 b=vNcpBnS02jNsn3x7cVUQx3MGkq3q1rHrbPheL8vl8njAJDtmhZ/MlCm1ox+RBPD4Tr4dvbYdiYWsPzxFfy69ZgUVMYGPo9NKpJ0bXUulhtMmuJBnAzLsYPef5Nhy5KNdDKo+5+5DbUU07j2jOuVhy63AMBpBJ7RyRC1/lgTbZ80jw3jr6iMuVQZX+yHd4WMqvQf5NcfJW1WIPoXbzXLdGyp4STuSleuofmNk3KgbAwKgmuGEFNNd3dSuebvRQxaQzNu7ESg1dMsWYpvz1mB2/Gn5UoPxVkB8cz1Z+rTfYsN+40uN3YQBOjADKEhTAfC2emjNb7QEcxqcaIZFy6CdKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXWNzJw+YJ4c4c8nTQPgd1G9pNL8T9z7odOWPYUQnDQ=;
 b=QxgEMnfrXlrp7+aHS9qcdSTmTzDBh3QIJ+CXbJe2sI05iva76savt5qKlAlpUnyPDFQTcPv01pbyeqCY0H9MukVcLbdM7zWh6BoCudC39J/j4OkQkNra+fL6S2/2ZEMeswbNOELVXs2c1JTaWR5Gg9V1a330bIQkXWs8HtN+rQM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:20:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:20:04 +0000
Message-ID: <3fe546b1-f27c-4183-8586-f5fcf32a5a65@amd.com>
Date: Mon, 16 Nov 2026 13:19:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix page fault by not skipping VM flush
 before tlb_seq update
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261109140616.2326304-1-chongli2@amd.com>
 <bd300bdd-21e7-49e7-bb2c-2d0512c7fc8c@amd.com>
 <DS7PR12MB5768A46AA81FED421E1593C39B722@DS7PR12MB5768.namprd12.prod.outlook.com>
 <a4f245a0-8144-4eaa-97ca-e12a2686e4f8@amd.com>
 <LV2PR12MB577362CE0249AE1136FA25879B7E2@LV2PR12MB5773.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <LV2PR12MB577362CE0249AE1136FA25879B7E2@LV2PR12MB5773.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dc80c7-37e7-4cbb-b677-08df43dbf050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|260925021311599003|260925022911599003|260925021911599003|56012099006|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: HU+MtJZX9zFT8JxOUT0486aorMD2lcaoGFpobOpMQY60GwK4tIGKM7M/e4byOhl/BaxVD0Eil1QZqBO1wbv9WL6hHXgIQ46nUXA9DxO3uvL64WsR2vTAR2Ow3C3S14xn4uPAjWSqkojKdrDXx+tZtrSF3JNfM0Db+WeJyv+dLvgYG33qBe2RSwxDNmI2nJDlLXbbxvF1LQ2qFBtOl/CGftJrBAYPEiyfhDuch1qrTaF1loxk90SiTQOyk22CkxwXCZsqabTd4FniEPhaiLfJIlpSfIMTtSYowD5xDlEjrhvPV7fT/sB2ZRZlqQaqKkIs+hoDlLtnB1OUS1IocxksbG0aFAIfVxdERryUrJDeedeLAxEBzGOkeGZ1XDKdtgd/WzyXIHCBMOAHm/m6vKdQipuOha4CcpV6pmUGIdndCFHXApyPS8TFuGfP8Vzzxs1dHhc6snQ5xy1E7xHOcTpG+/48swMKgBRzuQmbKEKWOYaMDNNkLuqxIDe0W71doV/u9H459SzXpB6ZJ2ghXsHLoAtQJ9BCmlZQ5p3aL7mhxB+OWnYT+a/2T6A3jraCVeiGXGWbDytgMITbjAHV0hecuAUUnWOzeV/fRcdFYokwP87EX5dpmtRdUPw+ZfLrQ/LdqmO0ppHDuYR/3JPa1Jo/AOx0Rawll6+z+h+X6JslAcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJ6VHhSYitRVGNwSnA4N0hNNW9CcWlodC9jczdyaEZQVTB2U2lVZXQ1MXgy?=
 =?utf-8?B?UmdVNG0zZEVsTGczeTU3UkhhWmVYNHBBRktwbnI4TDZvcjZ0L3VOalE1cFlB?=
 =?utf-8?B?SGhtOTAwd1lZRFVjcFgzalFzdkloVktFT04rVUF0MDl5TWxLMTdReXJ1V2U1?=
 =?utf-8?B?dGZOY0J5SGR0VExZTE1KMENJQk9icnZiUXpEaGxob1ZTWTlIQ2t1U2RQWXZx?=
 =?utf-8?B?Q0pZc3hLT0ZCMS9ycktiV1RNNjVsNFF5V3hCcGFnVWp0WHdEWVRNQk93YzI2?=
 =?utf-8?B?THlWZlZIZUtqL1NSTWlQZVd3UXJ4Snl0RE5saDR6Ynl5TW5vbXVLY1cyNW5R?=
 =?utf-8?B?Y3BYU2VtZTJkcU9sV0VCcXFaUG5YaFRZVXNXTWFxK01tdFZ0eitXZFc0cWI1?=
 =?utf-8?B?a01GK1VXaGNnRWZEWGhSckNtRGxKVEk5Y3NYTDlNR3Bjdm5zMlJzZEJOS1lQ?=
 =?utf-8?B?alJRN3VyRDdNVzZUMUt5OXR1dmo1bzQ0ZENOODhGRHlMMGo5OEFCVDhwRWVG?=
 =?utf-8?B?WlUvMDUyN0UxSUE1QTQ3U2Z0Y2dUaisxQW1Rak9FeExBeVltM05jVEh4TzVQ?=
 =?utf-8?B?eXQxWXRhUzU3NFlidVVFZzFiZmpxME5CaDd3dFNaZG5EOGVNb1I1L3hBTWlm?=
 =?utf-8?B?N3RQUWowMVR5TWNSTndLNWd4TW5pT1ZnYUNlSVRsZGhCZnNUZUdLVGVMSThk?=
 =?utf-8?B?blQ4ekhnV3NUOHN0dllYdFhDYzE3TnZoaUU3amVwdVNyQ1cxMEp6d2RFMHN6?=
 =?utf-8?B?Nk5wMmtpS2psMHdMVDhvTDN2RjV6N2NQZEswZU04Q0dadFBWbmk3RGRaYTAv?=
 =?utf-8?B?RHBmSUlZQXJDa0kwazRwaVlvYW9LbDVueU8rMTlyT0JvbUtLTGltQzE1dGpC?=
 =?utf-8?B?SldXd3pqTEJWWldLVGVDNGRUeUFPbTdNeTVsZDBCeUx0WFdhaERIdHJOaXpZ?=
 =?utf-8?B?VHZnZXhhM21mTE01REZteXN6d29Fc0RJZFpYR2lHU2FBVkpNUXRuY1ZxaXFC?=
 =?utf-8?B?TG8vNmxUMkZiMW9iRGZPODdUQkIrcGRuOEJRZ0dKODFMQzU4aVBldkNwbDA3?=
 =?utf-8?B?Z2g5Wk1OTW1lQzdBNURuUlM3M3JxS1RJNGtKaWFLLzEzTjh4MWRRY1ZSdXo0?=
 =?utf-8?B?VzA5YWlrZ1VTenIyY01ETzJyc1ROYU1kQ2RWamtDeHZGMEU2VHZaK3ZnZFV4?=
 =?utf-8?B?cGtacUEzTTJ0VWtyZExPWEhNSHkwN2tqbUpEZjNCNlBqajlRTnpPZmZGWE8x?=
 =?utf-8?B?RGI2RGg2U0NHcjNOYXJUd2lBRW5RYS82QVdOWWQrN0RuM2Riem9DZ0lZQkh5?=
 =?utf-8?B?SGpVSHJmMUdvcEFJbVVIZUZiNjVkQUExSWN6WE13YXVIa3NvbjFtT0M3cnBo?=
 =?utf-8?B?aTdrdk9kK3lyY3d6R0dsZkxWU0FMRjdLbklhRWtEQUFFUWN1alZIMzRUeE82?=
 =?utf-8?B?dE41dXJCOENzNk9XdC9wQUZuVGZOYmtvZFBxbXcwd2luL2pQMWpBUkR0N2Nv?=
 =?utf-8?B?YVp3Nmp0YUVOZ0c2enlNSmNkZktKWHAvNnlmT2R1Q21Va1NoZldDcmY5OE9E?=
 =?utf-8?B?SzJyTTI3NmRCeG9DaVAyV1NXY1dyUzRFdXEwS29rak9FZEZtd280alBuL3Ax?=
 =?utf-8?B?bnBKT01GcmZvV2JBRVVsWnVNN3ZrOVphdG1CTGQrdnk5RGozaENDMTYrcWNF?=
 =?utf-8?B?b0Jkb1JwM3Q4QTRSTGF4OUs0Mld1TGxvdjM5Z1kyQ3JhOHY1VXFvTVc3OTJD?=
 =?utf-8?B?bFM0WjE4UE5SMWE4KzJtOFVnN2xTQzZndGc2TjkvZWpUZitkdk5uRnlEMUU5?=
 =?utf-8?B?cG1MM3NvQnZjd3h4VDVraUVQN2pQSlZmaWJWMktTaFlsRHgxdERVNTNTT2ZD?=
 =?utf-8?B?OTVmVEZUMTVZeTlMdnRQRkZBemhiTUp3Zk1ZWmkwV1FwY1BhVmFOYjVpVjN0?=
 =?utf-8?B?VXJnOXRPWTJNNGZVYjA0S3hNRjlRZUhwMERVanJobHhWbHV2WHVMSUVCQUJZ?=
 =?utf-8?B?RTgrR2FnWjRNeWRheFkrTCtGUWQzb1VvaHg3dnkwRStraFNJZmlFYkJLc3k3?=
 =?utf-8?B?RjZhU3BYeWN0cWx0SHM3cncyTWxTYU9EMUdGMld2OEJaVXdVMGlyVHpvRkVp?=
 =?utf-8?B?amN0QUFJRXhwZlZxUDVrQmZqQ0J3MUZ6SWJ1U2ZGOThaQUttTDQwZkRnc3py?=
 =?utf-8?B?NTc3eHJuVlBLSVFZaDhRVXFYZmxJeWM2MTF3ZlR3TUppS3I2MmozZDUvOUto?=
 =?utf-8?B?YXR5cWFaK3VLWGI1UUdzK0IxbkNDRHVIcm9SRWNEL2hqOGl0RTRVM0p5SC9t?=
 =?utf-8?Q?7oqfjatrOJZPirJ0/R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dc80c7-37e7-4cbb-b677-08df43dbf050
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:20:04.4496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bhMCYb+a2TegfoG9A3Yeww7veRQBx70U7/dNSZrSPXdU2fmM8NwSC+pFe3WTds6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 10:54, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Christian.
> 
> Sorry for the naming confusion. My patch is based on a tree before
> your commit 27911d89ae30 ("drm/amdgpu: fix TLB invalidation fence
> handling v4"), which renamed vm->last_tlb_flush to vm->last_seq_flush.
> 
> vm->last_tlb_inv is not involved: in my reproducer ('Sascha Willems' Vulkan
> examples in benchmark mode), logging shows that vm->need_tlb_fence stays
> false (user queues not enabled, no KFD) and vm->last_tlb_inv stays the
> signaled stub from dma_fence_get_stub().
> 
> The root cause is a window between the fence being signaled and its
> callback completing tlb_seq++, which the lock in amdgpu_vm_tlb_seq()
> does not always cover.
> 
> If a job that depends on this page table update executes this line
> during that window:
> 
>     uint64_t updates = amdgpu_vm_tlb_seq(vm);
> 
> updates still holds the previous tlb_seq, because the callback has
> not had a chance to increment tlb_seq yet. If another job flushed
> this VMID after the update was submitted but before it completed,
> (*id)->flushed_updates already equals updates. So the condition
> (*id)->flushed_updates < updates is not met, and needs_flush is
> false.
> 
> Moreover, taking the lock in amdgpu_vm_tlb_seq():
> 
>     lock = dma_fence_spinlock(vm->last_seq_flush);
> 
> does not always wait for that callback. Each scheduler fence has its
> own lock

Well that is an intersting point.

, and by the time the signaled fence's callback runs, a new
> page table update may have been submitted, so vm->last_seq_flush is
> already the new fence, with a different lock.

Ah! You mean that the callbacks are still processing because we wait for the lock of the scheduler fence and not the HW fence.

Yeah that could indeed be a problem.

I tried to make the sequence number of writeback a few years ago to avoid such issues, but that never worked correctly either.

I think it is probably better to switch the whole handling to fence chains instead of the hack you came up below.

Regards,
Christian.

> 
> 48689.629231: amdgpu_vmid_grab: tlb_seq: vm 00000000f0406e73 last_seq_flush 00000000ed6892e2 lock 0000000070a2e519 unlocked at 48689629229784 ns, tlb_seq 34
> 48689.629232: amdgpu_vmid_grab: tlb_seq_vmid: vm 00000000f0406e73 pasid 24366 vmhub 0 vmid 7 ring comp_1.1.0 sched_fence 201888:7 updates 34 flushed_updates 34 needs_flush 0 vm_needs_flush 0
> 48689.629235: amdgpu_vm_flush: tlb_seq_emit: pasid 24366 vmhub 0 vmid 7 ring comp_1.1.0 sched_fence 201888:7 vm_needs_flush 0 vm_flush_needed 0
> 48689.629410: amdgpu_vm_tlb_seq_cb: tlb_seq_cb: vm 00000000f0406e73 fence 00000000f48cae4d lock 00000000fcae5430 signaled at 48689629208744 ns, last_seq_flush 00000000ed6892e2, tlb_seq 34 -> 35
> 48689.629615: amdgpu_vm_tlb_seq_cb: tlb_seq_cb: vm 00000000f0406e73 fence 00000000ed6892e2 lock 0000000070a2e519 signaled at 48689629413834 ns, last_seq_flush 00000000ed6892e2, tlb_seq 35 -> 36
> 48689.694858: console: amdgpu 0000:05:00.0: [gfxhub] page fault (src_id:0 ring:8 vmid:7 pasid:24366)
> amdgpu 0000:05:00.0:   in page starting at address 0x0000000401400000 from client 10
> 
> - Fence A (00000000f48cae4d) is signaled at 48689629208744 ns, the
>   "signaled at" value in its tlb_seq_cb line at 48689.629410. Its
>   callback runs under lock 00000000fcae5430.
> - 21 us later, at 48689629229784 ns, job J (sched_fence 201888:7) reads
>   tlb_seq 34 under the lock of fence B (00000000ed6892e2, lock
>   0000000070a2e519), not the lock of fence A (00000000fcae5430). Job J
>   sees updates == flushed_updates == 34 and skips the flush.
> - The callback of fence A increments tlb_seq 34 -> 35 only at
>   48689.629410, after job J's decision.
> - Job J faults at 0x0000000401400000 on vmid 7
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, November 10, 2026 6:13 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: fix page fault by not skipping VM flush before tlb_seq update
> 
> Hi Chong,
> 
> On 11/10/26 10:42, Li, Chong(Alan) wrote:
>> AMD General
>>
>> Hi, Christian.
>>
>> The lock of each fence indeed never changes.
>> Each PT update fence has its own lock.
>>
>> The issue is in the fence locking process.
>>
>> When a fence signals, dma_fence_signal() holds the fence's lock and
>> calls amdgpu_vm_tlb_seq_cb(), which increments vm->tlb_seq.
>> amdgpu_vm_tlb_seq() waits on the lock of vm->last_tlb_flush until
>> amdgpu_vm_tlb_seq_cb() completes. The lock of vm->last_tlb_flush
>> ensures that amdgpu_vm_tlb_seq() returns the incremented
>> vm->tlb_seq. This is the normal flow.
>>
>> But vm->last_tlb_flush may already point to a new fence:
>> amdgpu_vm_tlb_flush() replaces it as soon as a new PT update is
>> submitted, usually before the old fence signals. amdgpu_vm_tlb_seq()
>> then takes the new fence's lock, which is not held while the old
>> fence's callback runs, so it is not blocked and returns vm->tlb_seq
>> before it is incremented.
> 
> No you are mixing things up, vm->last_tlb_flush was something completely different.
> 
> vm->last_seq_flush is the fence where we install the callback on and yes that is replaced with the next installed callback, but that doesn't matter the lock is always the same.
> 
> vm->last_tlb_inv is the TLB invalidation fence which actively invalidates the TLB for a passid.
> 
> That are two completely different things.
> 
> Regards,
> Christian.
> 
>>
>> Finally, updates = amdgpu_vm_tlb_seq() misses the increment, the
>> condition (*id)->flushed_updates < updates is not satisfied, and
>> needs_flush is false, so the job reuses the VMID without a VM flush.
>>
>> Please let me know if anything is unclear or if I'm missing something.
>>
>>
>>
>> Thanks,
>> Chong.
>>
>>
>>
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, November 9, 2026 10:08 PM
>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: fix page fault by not skipping VM
>> flush before tlb_seq update
>>
>> On 11/9/26 15:06, chong li wrote:
>>> amdgpu_vm_tlb_seq() waits for the tlb_seq callback by taking the lock
>>> of
>>> vm->last_tlb_flush. Newer page table updates replace
>>> vm->vm->last_tlb_flush
>>> immediately, without waiting for older callbacks. A job scheduled
>>> after an older fence signals but before its callback finishes takes
>>> the newer fence's lock, while the callback runs under the older fence's own lock.
>>> The job misses that tlb_seq increment and can reuse a VMID whose TLB
>>> was last flushed before the older page table update completed,
>>> without flushing the TLB again.
>>
>> That's not even remotely correct.
>>
>> All fences use the same lock, that's why this works correctly.
>>
>> Regards,
>> Christian.
>>
>>>
>>> how to fix:
>>> Count the flush-requiring page table updates whose tlb_seq callback
>>> has not run yet, and request a VM flush when a job reuses a VMID
>>> while this count is non-zero.
>>>
>>> Signed-off-by: chong li <chongli2@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 10 ++++++++--
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 12 +++++++++++-
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 10 ++++++++++
>>>  3 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> index 9c879ac68352..b9e058da162b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> @@ -393,7 +393,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>>>       unsigned vmhub = ring->vm_hub;
>>>       uint64_t fence_context = adev->fence_context + ring->idx;
>>>       bool needs_flush = vm->use_cpu_for_update;
>>> -     uint64_t updates = amdgpu_vm_tlb_seq(vm);
>>> +     bool tlb_pending;
>>> +     uint64_t updates = amdgpu_vm_tlb_seq_pending(vm, &tlb_pending);
>>>       int r;
>>>
>>>       *id = vm->reserved_vmid[vmhub]; @@ -405,6 +406,8 @@ static int
>>> amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>>>            !dma_fence_is_signaled((*id)->last_flush)))
>>>               needs_flush = true;
>>>
>>> +     needs_flush |= tlb_pending;
>>> +
>>>       if ((*id)->owner != vm->immediate.fence_context ||
>>>           (!adev->vm_manager.concurrent_flush && needs_flush)) {
>>>               struct dma_fence *tmp;
>>> @@ -456,7 +459,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
>>>       unsigned vmhub = ring->vm_hub;
>>>       struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>>       uint64_t fence_context = adev->fence_context + ring->idx;
>>> -     uint64_t updates = amdgpu_vm_tlb_seq(vm);
>>> +     bool tlb_pending;
>>> +     uint64_t updates = amdgpu_vm_tlb_seq_pending(vm, &tlb_pending);
>>>       int r;
>>>
>>>       job->vm_needs_flush = vm->use_cpu_for_update; @@ -480,6 +484,8
>>> @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
>>>               if ((*id)->flushed_updates < updates)
>>>                       needs_flush = true;
>>>
>>> +             needs_flush |= tlb_pending;
>>> +
>>>               if (needs_flush && !adev->vm_manager.concurrent_flush)
>>>                       continue;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 2ba33212d507..6d15fd001a42 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1095,6 +1095,9 @@ static void amdgpu_vm_tlb_seq_cb(struct
>>> dma_fence *fence,
>>>
>>>       tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>>>       atomic64_inc(&tlb_cb->vm->tlb_seq);
>>> +     /* Pairs with atomic_read_acquire() in amdgpu_vm_tlb_seq_pending() */
>>> +     smp_mb__before_atomic();
>>> +     atomic_dec(&tlb_cb->vm->tlb_pending);
>>>       kfree(tlb_cb);
>>>  }
>>>
>>> @@ -1281,9 +1284,16 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>               start = tmp;
>>>       }
>>>
>>> +     /* Must be visible before the update fence can signal */
>>> +     if (params.needs_flush)
>>> +             atomic_inc(&vm->tlb_pending);
>>> +
>>>       r = vm->update_funcs->commit(&params, fence);
>>> -     if (r)
>>> +     if (r) {
>>> +             if (params.needs_flush)
>>> +                     atomic_dec(&vm->tlb_pending);
>>>               goto error_free;
>>> +     }
>>>
>>>       if (params.needs_flush) {
>>>               amdgpu_vm_tlb_flush(&params, fence, tlb_cb); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index d8e17f493f61..312fd0d268ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -337,6 +337,8 @@ struct amdgpu_vm {
>>>
>>>       /* Last finished delayed update */
>>>       atomic64_t              tlb_seq;
>>> +     /* Flush updates whose tlb_seq callback has not run yet */
>>> +     atomic_t                tlb_pending;
>>>       struct dma_fence        *last_tlb_flush;
>>>       atomic64_t              kfd_last_flushed_seq;
>>>       uint64_t                tlb_fence_context;
>>> @@ -578,6 +580,14 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>>>       return atomic64_read(&vm->tlb_seq);  }
>>>
>>> +/* Read tlb_pending first; pairs with the barrier in
>>> +amdgpu_vm_tlb_seq_cb() */ static inline uint64_t amdgpu_vm_tlb_seq_pending(struct amdgpu_vm *vm,
>>> +                                              bool *pending) {
>>> +     *pending = atomic_read_acquire(&vm->tlb_pending) != 0;
>>> +     return amdgpu_vm_tlb_seq(vm);
>>> +}
>>> +
>>>  void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>>>                                 unsigned int pasid,
>>>                                 uint64_t addr,
>>
> 

