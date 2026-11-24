Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0F606A326
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J8rS7xiu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAF610F53A;
	Tue, 24 Nov 2026 12:15:56 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7932E10F537
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 12:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQgpQB4Jm+FLiComF/dkBEC1Acz8Ha98UuZahbVxovtA836NxxrtLKOP/6lQ0+wyhHzt5CfEDYzQBrHWXBxUJ30Zt9v6HvSuJyLl+tVx7YfHd/FNPK9r5oFLJSu6il7vijk+jlNcSCrRw5ZWxtkIaAzXdpumVsXqa7mwt1vAJdRhXq/kUbyQeHU5eFLq+iBmMnoO01pg5JBHsInz5x+hJrsDan/lz+tjFY7Ucf63HkkSgRgXeQtoMJmSmm24AWB9rBvyWWDZWhWs7HvacXZsQrGBRNaSSLj4Ftl0kBYCRjqK4KFujY0svr8yAvcwYeRcLv44yTGlYft4fbiW4hxxqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUlO2ghEeKzIofAYAAnvhvfIv4FjnCjUVLDoYFJHeBs=;
 b=ChEewXwXRIgD8Sdxa0hecmCxoykiXkX9frnYJIRaPsO0W8O+xJoECCc24XkzAD/jywjTsiK5MR01Eg27ruak8zg3Vr+o46nfhK81TX5T2v6DAD2DgfpdhLUWiRrmn3BHt8Nn6yl38EWHQ6rveF4Jw+u2z0jrQcXdew0gSqW531rrWwwHIaUQEHdVrhIRUrd09TgFOxBhDcvvzXFVDdo7mTOwdqYUdalkEA6V8AK1GnbcdDFsO+5HnVFgMO42e1RIl5EVLyfGpQIwy7+cC86bAuP0Vmr2QUXhG9Q6zLUNWn9FKPHtXB9+BvGOG7IN1R7fNoopvWGxcnhBZjZa6cXO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUlO2ghEeKzIofAYAAnvhvfIv4FjnCjUVLDoYFJHeBs=;
 b=J8rS7xiuEvNd7HIGCcxZQl4W9vDnOiV4mmHQ+Unc4CvPdUw+DohZ5bGylcFc4xHVzDUmgYVRGcH2guAFVBJGoUZ+C6jK4R5GaAJtYMugjWsv1tQ9c6jML6XsiqyaNcKIqUUoTyEReStUroITbd2XE0zi5vGKQWkqQnLbZnsX/uw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 12:15:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:15:47 +0000
Message-ID: <c896f5f9-fc3a-4eb9-b81d-a3a3cb1b37d5@amd.com>
Date: Tue, 24 Nov 2026 13:15:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] drm/amdgpu/userq: fix S3 suspend hang with user queues
To: Arisa Snowbell <arisa.snowbell@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <cover.1795482456.git.arisa.snowbell@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cover.1795482456.git.arisa.snowbell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: ec897a00-6bbb-4456-93c7-08df4a24aba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|6133799003|18002099003|261009223027099003|3023799007|261022105027099003|261022075727099003|11063799006|5023799004|56012099006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: Qtz8p9eGhTnwnye3im30BbFObvwJeDnLpbSi5APelf0G0gzQkENwFcAEw8oC/mLfSy3wvbKDNWuefpN/V+MvJW/Vnce6HVYkg0wBRfl/wgt0ueqZZVn+GDkdzEq0PzpnvKQUbeDamMcl+1bdQFFZ/KbJqfgi4N7qQDzGhMb6VpxWgCEj8vG1+5hYidKlQjlOT/yvI3e11rkfYPv6IP+5bX91/RYgHSNB8X/sWapaIoNy/YX82O6MdSkyL2HLgDpJyvhcHFK56KPJN64vdsiQ8NYGSAeDsT1xKWywpObaCrUslcUSnmVtgbKuLeaFrgRxXLWwyyPjmLyfhGgH9oqqsWe3Q189nvYEPhggQX2J+34UZzZJkhNVfm4bBORuEsC7hBF1L1zinqmEGsR5cAQB1Kk8xTS0ria+K1UyHMHhBoPzCQ4spCYed2VZHvMa7d3FtkVCbMRyu5zp0IsUws4ZdidXLHFjYPvkvVlLQOAXSzla9a+x/4eXE/XqOlH15aiKfioS3OmRCgTmlgXKpE19ylpuEF/Sd2Biz9TS0qjawrS93S+Ft0DOFM0kyu/wsqXPaAL+KKNEhFNh0nVvw/Wwb8836hKC/hlJQdKO+srjcC/QuIOoDoUHqpcEcdTc9UzwNTqqdZz+cWOwplg8CqLQzsulasUbqRvaKpWbv+0dBw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(6133799003)(18002099003)(261009223027099003)(3023799007)(261022105027099003)(261022075727099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1RXNXN4amdhN3ZXR3kvdkpDL1pIaEoxMytucDFMWmdrSno5N1dGMkdnU2Fw?=
 =?utf-8?B?c0c5bHNCckt3S1ZMaFk5blRWcHUzbEw1Z3lPSU1oU1RGeHlDNTNFM2tOWE5G?=
 =?utf-8?B?bE5WY3VzRFZUOS9VUERvR2tzZ3cycWhqOWVaSEZlSDV2VWdvaXJXMWlrUkdw?=
 =?utf-8?B?YURKbjhCb1VBMGFFcXd2LzM4aE5CZE00K0VRVllhUktyTzlzL1RoY1lyT2FI?=
 =?utf-8?B?SGx5VHAyeXh2K2k5cHE0c3FNMDhJODV6YlFsdnVncWVxV0FycnBOME1XNFpE?=
 =?utf-8?B?c0p5cFJmSXpLaGhTc2FGRTIzRmc1WGMvbEN3U2UwZFRuZ294dzNUdFNsMENR?=
 =?utf-8?B?VWRzbmRDU0RRT2t1L2JWTS9QMGY5VHV1c1V2TTFXMlZUTzVFaXNpK1NSeDdD?=
 =?utf-8?B?dE1Kdk56NHBtQ1Q0VzVIaXAzTTJzdk9WSkl6RGlWMlpUYzFiYnVsamkrd1cx?=
 =?utf-8?B?MXJKcFFUV3ZOaXJpam1MNHpDZnBCcjBibzM2NHh4UFZzTzZVaE1nQTUrdU1z?=
 =?utf-8?B?ZmRwMHRYZ3FDR1hmNTBoOW42OXRxSlFLcFhBd2dFU3F4VkV1TmdCbCtEek1s?=
 =?utf-8?B?T2dFVE5VZWR0N1FpelQvTmRGSTE3dlpKQjh1cE55WHoxRWlBT29CNjhhMmlQ?=
 =?utf-8?B?QTRkdmhvWThURDVNMXl5L0tnWElHS0RFY1pWSTJ5TE1PU2lCOU5UdXV2OW5M?=
 =?utf-8?B?YTBaTGRZbGlvVyt1dWc3RVk2VVp1ZE45cVlsVW1yVlRnLzZpWHVPOXFsKzBG?=
 =?utf-8?B?TzlZTUVXcWkxVUx2WEN0UGgxVnIwYzFHZncwN2k4NnhybGVWc2hacGlGemlR?=
 =?utf-8?B?dHA4akhiRzN4aHU4aXZVaDE3N2t5d2ZSY3YvbnczcUg2TmNMaFVXbW5GQXcy?=
 =?utf-8?B?SDFzdTlyUTVKdFlaSGhrOTRYeEY0NW9IRVFPYlIrNFQzQVA2SEJ6YklOOW9j?=
 =?utf-8?B?TEtRSHpuNW1ib2NsbXorazdxeG1LK25SL0dpS0xaNEhBaXJUeDlXUGlJMk9L?=
 =?utf-8?B?ZjNJMVpjV1pJN2tFak5qK3ZxM2hJT2JPMFZYa25yczlZb0M5TlZCZzZ1NG8r?=
 =?utf-8?B?NCtuY0VJckZwVmVBVFJFRXpjbGVJL28zZ1BaRzR1UkNpVGRnREdWWkVqZGNB?=
 =?utf-8?B?cXRaWmlSWi9KajRjN1lLeXQ2cEJwYW1qQjFHRWxxT1JycCtVQWtrSXY3YXFG?=
 =?utf-8?B?bjd6RHdjR0RmdUEwRHR2QmVUcnlrbk5yNDY3bmY3MDQ3YzFoeSt1emxxWWFB?=
 =?utf-8?B?YmlVUXFEQ1Judm52RDB5RjUwV2xQbWYwVWNrZnYzRWtqK0htLzlOV2QrTTI4?=
 =?utf-8?B?VjBVTmFwa1Z0c3JVZmlTZHc0VStWYzZRMi9ILzZTNFhvNHVhQ3U4T0w2UWI2?=
 =?utf-8?B?OGRvZFl0SGpmZWpoS2dqSzZCb1pyT3ZBelFYVGIrWFFmK2dlRGRCYWNzNm5o?=
 =?utf-8?B?UW41b016VUFZYm1yWlpERk5vNTlZQVZlaWpJU2laZE16M2JpSlhvVXR2WHZv?=
 =?utf-8?B?OVk2dkswV1pEelZDNDNvc2dQRHgyWUI0TThmOFcycFdPdm9mMWlVaXpiNnJW?=
 =?utf-8?B?TVdFenhuNllPSzlFRzg4SGtITG51M3lFZG8yZUhjNTJCUGpEOUhNNW9DM2pw?=
 =?utf-8?B?UmJJV0ppcWgwWkZ2ZEN0K3VNK3hhZmtHME5aTjhENmZBVW4xbVBBRStseTdJ?=
 =?utf-8?B?Mk01ck9MR0tKRytXTVlZS0xscmg5dkhCY0kvd2lNdkIrclJudG5kcnJwV0Z1?=
 =?utf-8?B?S1BkNkdrdC9jR3hENlJBemwxcVVsZWZRSmkwVFpMdU4wWndqaWM4RHlCM2E2?=
 =?utf-8?B?QnMwekVnUTVHaXQyK2FtdFJSaktDaGxDV3dMT1ROdDJyN0JQK0FQZmJMUk1F?=
 =?utf-8?B?YUZXMVB1Q1ordzFPYjU1MXdzc0QvZ1lMalpzRitvK2FxOWNPd0FxbDNBNHE4?=
 =?utf-8?B?R1dOSUx0M3JXMnp0aHFFemRMNzRxZGRZMCt2VThkeWtzVlZhbU45QTN4YW5i?=
 =?utf-8?B?cm1WdHRSL09YR1czM3JYd1pnSXEvT0dTb3VYcGU1dXlWOXA4dGpZa00yVWw4?=
 =?utf-8?B?MWlOTFh5NjFXQk5sci9TbVhLWG42Y29yUE9TWGh4aS94VCtBdXRzT0Z2Q3Ro?=
 =?utf-8?B?Wm9RcEdjamRzaGJ5OGtZMngrWW5HRWVQYUIwL2UzeTZ2dFlKV3NCRlRaYUw0?=
 =?utf-8?B?SXpqQ2dFYm5qMmtyT2ExbzRuMkxQK3JHQXdkWHVWcVRPK2hsTkhuSnd0YUU3?=
 =?utf-8?B?OGZPUVB0YlIxUlJkeDZkc2UwZHZrbmRhb1ZEelRiV3c4USthTDhoR0Urczlv?=
 =?utf-8?Q?jAUG4fJ5AhfSJJiSgU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec897a00-6bbb-4456-93c7-08df4a24aba7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:15:47.4145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01R3hbzX10RsLawEg5WffDd3hvlcrz0yEMiqSagqxumn0Q8zUCXJNLjPaawkqCPM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Arisa,

On 11/24/26 03:32, Arisa Snowbell wrote:
> Hi,
> 
> I've been testing user queues on my RX 9070 XT (amdgpu.user_queue=1,
> with AMD_USERQ=1 for everything I run through Steam) and came across a
> suspend hang. After a few hours of uptime, S3 suspend sometimes never
> finishes, and I have to reboot the machine by hand. What I see depends
> on how the suspend started:
> 
> - When the screen locks in parallel with the suspend, the machine
>   freezes on the lock screen.
> - When it locks first, the screens turn off and the suspend starts
>   after that, the screens stay off; the machine looks asleep but never
>   wakes up.
> 
> Either way it never actually sleeps. Short sessions suspend and resume
> fine.

well first of all thanks a lot for testing user queues we haven't got much feedback so far.

So I also have the question if you have encountered any other problems except suspend/resume?

> In short: while amdgpu_device_prepare() evicts VRAM for suspend, the
> user queue restore worker starts and moves the same BOs back. One
> restore worker got stuck waiting on a page table update fence while
> holding the BO locks, and the suspend waited for those locks forever.

Yeah we haven't tested suspend/resume with userqueues yet and I don't think we have a test case for that.

@Vitaly is that right? If yes we should probably create a test case.

> The patch keeps the restore worker out of system sleep; the details are
> in its commit message. It builds cleanly with W=1 against v7.4-rc4 and
> passes checkpatch. I'm running it now: S3 suspend and resume work, also
> with a game on user queues running, which keeps running after resume,
> so the restore worker maps the queues again. It hasn't seen enough long
> sessions with suspends yet to show that the hang is gone, so I'm sending
> it for review first and will report back once I have more runtime on
> it.

That approach looks a bit to complicated, in theory it should work out of the box.

In general the workqueue who executes the restore should been frozen during suspend, so evicting VRAM can then do it's work without userspace interfering.

What could be is that Mario's work to evict VRAM before swapping is disabled somehow broke that.

Or it could be that we are submitting the restore work to a non-freezeable workqeueu.

Either way Sunil should probably take a look after he's back from vacation.

Regards,
Christian.

> 
> System:
> 
>   GPU:      RX 9070 XT, Navi 48 [1002:7550] rev c0, gfx12, MES fw 0x97
>   Kernel:   7.4.0-rc4 (linux-mainline)
>   Firmware: linux-firmware-amdgpu 20261019
>   Mesa:     mesa-git 27.0.0_devel.234528.a54c80d04d3 (RADV)
>   Options:  amdgpu ppfeaturemask=0xfff7ffff user_queue=1 runpm=0
> 
> What I saw:
> 
> The suspend started about 11 hours after boot and never finished. About
> 4 hours later I pressed SysRq w, s and c, and efi-pstore kept the dump.
> 22 tasks were blocked:
> 
> - systemd-sleep, in ttm_bo_evict_first() waiting for a BO lock
> - 3 amdgpu_userq_restore_worker: one waiting on a page table update
>   fence, two waiting for its locks
> - 12 amdgpu_tlb_fence_work, waiting on their page table update fences
> - 5 ttm_bo_delayed_delete, waiting on BO fences
> 
> All the workers except one TLB fence worker have higher PIDs than
> systemd-sleep, so they started after the suspend did.
> 
> The earlier suspends of that boot worked. The only amdgpu error before
> the hang was one "MES(1) failed to respond to msg=INVALIDATE_TLBS"
> about 1.5 hours before it; the desktop kept working after it, and I
> don't know if it's related.
> 
> systemd-sleep:
> 
> [31192.858314] task:systemd-sleep   state:D stack:0     pid:466006 tgid:466006 ppid:1      task_flags:0x80400100 flags:0x00080800
> [31192.858315] Call Trace:
> [31192.858315]  <TASK>
> [31192.858315]  __schedule+0x400/0x1770
> [31192.858317]  schedule+0x28/0xa0
> [31192.858317]  schedule_preempt_disabled+0x16/0x30
> [31192.858318]  __ww_mutex_lock.constprop.0+0x7cb/0xd40
> [31192.858320]  ttm_bo_evict_first+0x14e/0x240 [ttm]
> [31192.858323]  ? __pfx_pci_pm_prepare+0x10/0x10
> [31192.858325]  ttm_resource_manager_evict_all+0x55/0x220 [ttm]
> [31192.858329]  amdgpu_device_evict_resources+0x32/0x80 [amdgpu]
> [31192.858430]  amdgpu_device_prepare+0x2f/0xe0 [amdgpu]
> [31192.858532]  ? amdgpu_pmops_prepare+0x5b/0xb0 [amdgpu]
> [31192.858632]  pci_pm_prepare+0x33/0x80
> [31192.858633]  dpm_prepare+0x187/0x4e0
> [31192.858635]  dpm_suspend_start+0x1e/0x60
> [31192.858636]  suspend_devices_and_enter+0x131/0x8b0
> [31192.858638]  pm_suspend.cold+0x2bc/0x336
> [31192.858639]  state_store+0x7f/0xf0
> [31192.858640]  kernfs_fop_write_iter+0x16b/0x210
> [31192.858642]  vfs_write+0x258/0x540
> [31192.858644]  ksys_write+0x7b/0x110
> [31192.858645]  do_syscall_64+0xce/0x580
> [31192.858647]  ? do_user_addr_fault+0x235/0x760
> [31192.858648]  ? do_syscall_64+0x35/0x580
> [31192.858649]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [31192.858662]  </TASK>
> 
> The stuck restore worker:
> 
> [31192.862190] task:kworker/0:12    state:D stack:0     pid:466979 tgid:466979 ppid:2      task_flags:0x4208060 flags:0x00080000
> [31192.862191] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
> [31192.862307] Call Trace:
> [31192.862307]  <TASK>
> [31192.862307]  __schedule+0x400/0x1770
> [31192.862309]  schedule+0x28/0xa0
> [31192.862310]  schedule_timeout+0xce/0x120
> [31192.862311]  dma_fence_default_wait+0x19b/0x2f0
> [31192.862312]  ? __pfx_dma_fence_default_wait_cb+0x10/0x10
> [31192.862313]  dma_fence_wait_timeout+0xee/0x1b0
> [31192.862314]  amdgpu_userq_vm_validate_and_restore_queue+0x702/0x990 [amdgpu]
> [31192.862432]  amdgpu_userq_restore_worker+0xb3/0x1a0 [amdgpu]
> [31192.862547]  process_one_work+0x1d6/0x3b0
> [31192.862548]  worker_thread+0x1aa/0x310
> [31192.862549]  ? __pfx_worker_thread+0x10/0x10
> [31192.862550]  kthread+0xe9/0x120
> [31192.862551]  ? __pfx_kthread+0x10/0x10
> [31192.862551]  ret_from_fork+0x2a9/0x340
> [31192.862552]  ? __pfx_kthread+0x10/0x10
> [31192.862552]  ret_from_fork_asm+0x1a/0x30
> [31192.862554]  </TASK>
> 
> I can send the full pstore dump if it helps; the journal of that boot
> has nothing beyond the MES timeout above. I'm also happy to test other
> patches or collect more data.
> 
> Thanks,
> Arisa
> 
> Arisa Snowbell (1):
>   drm/amdgpu/userq: don't restore user queues during system sleep
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 +++-
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 64 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +
>  5 files changed, 79 insertions(+), 4 deletions(-)
> 
> --
> 2.56.1
> 

