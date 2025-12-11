Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766D5D3E791
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 04:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A7C10E07E;
	Thu, 11 Dec 2025 04:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R9oHvCra";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0CA10E07E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 04:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jabBJDp5YSeyLScmtU2fpnURxdqlwr+fMfGXKSIr/VgcLI1esg1adWcWhXRTLux8DD5ftXcPqukkoS08xg1n6kjvEq5rPLFrrOwb8RHWV4WjezTcjosVXhH90f8il/cC7PeInms7hr16Q45UL7sEVhjv9GFNXmHI+mJZHUZxyaXOiRLFiAc/bEV09Or4pOHhuYS7SmfJW104KFJf2HjHW+Jhd3QZvpuCxMZRvFGSCBNCmCqoEk+Vl7hduhX3gzsgaVaeE/zyonqYoqB7+XijtwdfbU541jkzuXhhGIYHtj/KqmzQh4Qc0ZnDrt9lfw8zE0YXZgfgl78r30chbuIoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi8xE+wedul/ALLwLGxshyYA9x9F8yu9vok2hXeesBU=;
 b=Lt1QbkZ76d1jESqLucn5TjrJmizej8RrdWATRYe8EF2zBcGygTq/DaperMSmo1l/c4CcpuCKCc0Wxik//C9YI/UpBofp11+8aWjwaF67TKYipQ77dXd0Ftt8BxEAZtXNZg05hn+j7eAv4NCS2zm6A8MB1qKNMxqXevcPGyaJiGkIYf7GmWmzz5nkYwKeZ51p3D7gXs24bMX0hgIEINJqF7fmPCsZOFrlKQDY7HTlVOkk0SiTbHGBSAl0AUHSXcIpMU78x/YBHqg2b6aqYBvBKadddRGcEAKmV7jzCpD/2BeG6bMeIb7KLBvlIxTWAbdK4dJJWv/tnb1ttESJbeQ8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi8xE+wedul/ALLwLGxshyYA9x9F8yu9vok2hXeesBU=;
 b=R9oHvCray58uL33Y0GK6iBOcn5sEVmfLyPkvM+wUrIs7iSQ7STxLjp4OVEph3EwwkaGDOQ0IXb4icOW+90Jo6TCpvbgB0L4LuK668glSeDdyEmphYxEZ5zDfkhd6kzCfDzAgbjIbxZtsi/IE9kMbNm7Poq2pDYJUulnXi/ZIIOE=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 04:44:08 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 04:44:08 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Matthew Brost <matthew.brost@intel.com>
Subject: RE: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
Thread-Topic: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
Thread-Index: AQHcahLwBcrNXy3GTUKiX+wfLCBOm7Ub3RFw
Date: Thu, 11 Dec 2025 04:44:08 +0000
Message-ID: <IA0PR12MB820853BB88B551F345463EB890A1A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20251210202347.63243-1-alexander.deucher@amd.com>
In-Reply-To: <20251210202347.63243-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-11T04:43:08.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|BL1PR12MB5851:EE_
x-ms-office365-filtering-correlation-id: df07456b-2a10-4998-045d-08de386febec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6u9HqrZhxs2xZZG/6vsnlIjNTdgnMmNaKLyjVjxMh1BCnXyGMiCTtKGKprse?=
 =?us-ascii?Q?3z0wjc6Vanx1SdOeccBeK6hormD12cja0j0HDhfh7ix0lz5mNYjXCa9wmnVv?=
 =?us-ascii?Q?3J/fLmvcP9rzZyiKpq/FurFCiuqkZKkOkc5ZTQXF1GKOwoOFnF7HyCKQ+mNg?=
 =?us-ascii?Q?i++LHyMQn5fEcyxyNVkXhQ6wZJUDJZ86SC0ncIhCJoK2PJqKQflEOUiSPdLs?=
 =?us-ascii?Q?7DaSKT3GvI3I1WrESaZu3Bdoyy371mz7W2BX5FHY92lyjcGI8NH7R+KSOaV8?=
 =?us-ascii?Q?h+wWhn2qAV67RuEAabjOuyILkqUtphTRAq0fAdRHxhXZexacQi556IVrAkWV?=
 =?us-ascii?Q?nO0SyQIMZDpLJxTPtieiQ5CVigjw3xQ38xXCAhG4sV0iw20ritsi4nzB7yTm?=
 =?us-ascii?Q?2y/K54OTiwsMQXsAizEjdwqs6gZdpw8QsWT/uxaQiOCcrRKthP6PZGKxku7c?=
 =?us-ascii?Q?cs1D+i7519j8W9snyycwv3hwRU+fk0R3wl0Xsz2hzb0vtkGwpNlRbAmXD5Aw?=
 =?us-ascii?Q?tIQ0u0EuUTcOwsaFGSDEcyWyFbdj85865at1VXw6XXGCz0rhAm/4MQ/Ei/p0?=
 =?us-ascii?Q?w/FtBGbbVzBcTY/bvudwU7HOS1r8SARe0HnwgCFah4ELoWvpWk3ACenXjHFV?=
 =?us-ascii?Q?wScDtBE8NIsvAYd0gFTiyLgaV/meeAXNcNa9dO0A2AcTUkLwxJy7/eq0Fy/K?=
 =?us-ascii?Q?Vlo52oArJPTzt0Qzb5bI7ADHRo0uQaQfp8sUfIgJgk0zr++dy9h0QvgtIq+y?=
 =?us-ascii?Q?q46E/h281TkKrj/RD4zaEpYEVogIKg6pCxSdu4SDNRoffGZIVcxNwi1T0K2B?=
 =?us-ascii?Q?0QA8XM+wHZMZQEWNN/OGG5SVcfLUDhSukwoLo+kDmNj3GC3cA/7qIxMmSvZO?=
 =?us-ascii?Q?ZkH86K1W2rGSDVfy28eTbXfhEXe47wGgWyvgaBYdg6tZr/L5LhRzEzJl/qiI?=
 =?us-ascii?Q?CuwVAIF/KBYMf1OGEyf04y6AOH4x8fWVbEWDQv8uV8k9V/22AmQSykYq/mVN?=
 =?us-ascii?Q?dahmo8zVW1BY5OCGek2AU8zxtNFsn3E2b007xg+zv/cbE5ij1XMS7/9bYnGz?=
 =?us-ascii?Q?kWq1CkzGfZ4q+rmYMWAGju1HIqrW6Dbp5PgcCHGXk9zlQ780COaTR9hyCR9Z?=
 =?us-ascii?Q?jsZy44hZXBVMhAiia+TX/QqmxvteyJYCCyEDJNFgjNLb3VvYiSM5XFAbv1wk?=
 =?us-ascii?Q?Xpg2HOvb/E3SAj6V+OrYG8CsczRQms0CYFbIO/FhBng9stcgdJmxgc9W53NP?=
 =?us-ascii?Q?x4dY4ua74cJU8/BunPhaBBpnP8yOXVDDnuMgMysi2nUVegzc+4MOdhxkq7Wi?=
 =?us-ascii?Q?vSulfSGEAhj5WqYAd4or16ZXhKoG0PPhvidtartZYGjl0Hjp53AVRpwGdeQk?=
 =?us-ascii?Q?/5zbX/agCm2tTCqiW5lvhyU4gFJAOcQNpkkObS0O6Eobo4hm0j0n4+axPJvY?=
 =?us-ascii?Q?5WgtBqEuqwi1jBv138KkoJZrqaNl6jYuK+lSXcNPm5DWsRxheH95jp0PdYed?=
 =?us-ascii?Q?TQ10xlRvYiEKLkJCTJfExg5J6v3j9j2YCON+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1R/PVhz73oTDSSqMObvMm/kIkpOLYCIzLY5iqyn9x1aQ6tnz0+QYzgyKmeg3?=
 =?us-ascii?Q?rWJFr7UmduyAq+Mw3BlaPtZQ5MBOTBj6DjDvtDOxYKTIUo/AIiElAyl/Q1XP?=
 =?us-ascii?Q?vGh2W8n2rHDBmD5aj8HAteHv4TYmsGFBvn1XTnQq6PkoGv1SX4B+jd0sXO7y?=
 =?us-ascii?Q?lttZln2JazZ4yL2yvCUHk6FeEoXIPnI68Wwmgk/e7Lqv0nbGU8xHPA8uiCAA?=
 =?us-ascii?Q?MmmPNw0ryBllSM1vk7oC4oFOG6mfn9P0m3gQjy8XcABVV+QYe4h/Ful1B4gh?=
 =?us-ascii?Q?n0rzPxcfQHG0C6+00BQKARploacFM3Yjfmn3hquL0J3ymLAAZ9oh8lce5daZ?=
 =?us-ascii?Q?Rm4IlSB14JiBT0p0eIVwlfvgulj0TAGcE4X156v/jJgJ9LYHJep9EMjkiP1X?=
 =?us-ascii?Q?djT/ZJh1j4pFbMwfkULHzqsF6cusz0JLCXImT2/XoTz6HveXq7sIHvMU9x4o?=
 =?us-ascii?Q?lnXGVKdoK5LDEs2s0UPeGsxk+Hgmn4DTiCknRXw4lyNWm9KLcAadndaB0k+2?=
 =?us-ascii?Q?HYX/ceDUuiCB+uxRhz29piF/fdZNMYhxsrLtAvGse6qdXVlsFDH/0PwLMn5V?=
 =?us-ascii?Q?xHD31rDAJArTe6J2wLX6VTGtbSYF/md8yB8hwV0KXBi3Gd2l16/QhbWIM19h?=
 =?us-ascii?Q?jsuHVO25KjOuDhE/DYkXM5y7LKlOtMEVkgL9uwZMAsXp9+uz6ESS/fbKAYW5?=
 =?us-ascii?Q?Xi3oX+7TvsDICaAFjasXIUYEi5A00BaIdu8B63ZMgyUI4Wuf5CPyJ/wmunyk?=
 =?us-ascii?Q?KNdLOuXHUoD1EI8dRRrZ8THkiVZCt7ncMfdPqW1WoJsn+VGYI43amPKPuBv5?=
 =?us-ascii?Q?rrPUvyv5NSC/q8rfsg2BOs/Ly5YRHxp1uSnj8v7IgWLT6ZWC3cvdU4e9W1l0?=
 =?us-ascii?Q?XxhAopAcsCuI4BHJ9DjIdDz5nhb3WeedKR24Fm2bMFzvpUCNEg7hrFGu+cQX?=
 =?us-ascii?Q?UwZmdV0vaYiLwE5/gebXFRowfSil6jEmiu9gIe1/YVQPjVg6frEw30cCUNef?=
 =?us-ascii?Q?v+PHQu89wSk+RmylRuTgNa45okKtzlVl7i/EzWQ7GMPYcdLbjuaYoyhsx2Ir?=
 =?us-ascii?Q?WWcp/dsj5mbj5/7PPmqibguBLWR9waPIxX7VMFViCZ/NmId/1KLCaFINl2Jv?=
 =?us-ascii?Q?ABje2NTJ8+OKqHu/NMQL7l1+6fRR9xIwk/f2bO6/5JtOHl9CKcy51cPHsls0?=
 =?us-ascii?Q?BdjVA8WpbbSYIfO0kyOQDR6R0nvsizfm+2MEeSaYTMMELFreJOS7zrymzT48?=
 =?us-ascii?Q?+CGL6dWNgn21aAlmR8FzPpGBcyLXwGK0cpkqI07fJFU1+W3uJhaChTCEmiHW?=
 =?us-ascii?Q?yMi9yxnCHm/abeefbfrRctR3YGdzmzn+youBuF2UcO6vT6ZUf/OEtWeDhCBr?=
 =?us-ascii?Q?4aQ4elDXNYiUZ6RdmeeXjdchmV6TWcYqNd7rBAiAVoJAwJoANYu5qcJjq9St?=
 =?us-ascii?Q?vSknQtR3h8aZ17vVygYvQ4yhhml7lm90JYj5CDMnbu4WK6OHINz8s6xX0XWs?=
 =?us-ascii?Q?NW+SBo+d4c5pQaWtDDgaWaIa0w0R1BJeTW5eGlncQHCYwMAeyUr0lrVo2JQn?=
 =?us-ascii?Q?US4nw/Fvxmbp2bLdvvg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df07456b-2a10-4998-045d-08de386febec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 04:44:08.3517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VoYsMDmIRDLclad8WQWOtsOpTO0w7O4BUYo6c7x4Yi0k1cGmtEWzPg79tOtMd9dmvamaimmGLNZ3SffWT1ErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851
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

[Public]

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Thursday, December 11, 2025 1:54 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Prosyak, Vitaly
> <Vitaly.Prosyak@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Matthew Brost <matthew.brost@intel.com>
> Subject: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu recov=
ery
>
> Avoid a possible UAF in GPU recovery due to a race between the sched time=
out
> callback and the tdr work queue.
>
> The gpu recovery function calls drm_sched_stop() and later drm_sched_star=
t().
> drm_sched_start() restarts the tdr queue which will eventually free the j=
ob.  If the tdr
> queue frees the job before time out callback completes, the job will be f=
reed and
> we'll get a UAF when accessing the pasid.  Cache it early to avoid the UA=
F.
>
> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
> Cc: SRINIVASAN.SHANMUGAM@amd.com
> Cc: vitaly.prosyak@amd.com
> Cc: christian.koenig@amd.com
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>
> v2: Check the pasid rather than job (Lijo)
>     Add fixes tag (Christian)

Hi Alex,

if possible, could you pls add this signature to the commit message for ref=
erences:

[  493.058141] BUG: KASAN: slab-use-after-free in amdgpu_device_gpu_recover=
+0x968/0x990 [amdgpu]
[  493.067530] Read of size 4 at addr ffff88b0ce3f794c by task kworker/u128=
:1/323
[  493.074892]
[  493.076485] CPU: 9 UID: 0 PID: 323 Comm: kworker/u128:1 Tainted: G      =
      E       6.16.0-1289896.2.zuul.bf4f11df81c1410bbe901c4373305a31 #1 PRE=
EMPT(voluntary)
[  493.076493] Tainted: [E]=3DUNSIGNED_MODULE
[  493.076495] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.0=
3.B10 04/01/2019
[  493.076500] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sche=
d]
[  493.076512] Call Trace:
[  493.076515]  <TASK>
[  493.076518]  dump_stack_lvl+0x64/0x80
[  493.076529]  print_report+0xce/0x630
[  493.076536]  ? _raw_spin_lock_irqsave+0x86/0xd0
[  493.076541]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  493.076545]  ? amdgpu_device_gpu_recover+0x968/0x990 [amdgpu]
[  493.077253]  kasan_report+0xb8/0xf0
[  493.077258]  ? amdgpu_device_gpu_recover+0x968/0x990 [amdgpu]
[  493.077965]  amdgpu_device_gpu_recover+0x968/0x990 [amdgpu]
[  493.078672]  ? __pfx_amdgpu_device_gpu_recover+0x10/0x10 [amdgpu]
[  493.079378]  ? amdgpu_coredump+0x1fd/0x4c0 [amdgpu]
[  493.080111]  amdgpu_job_timedout+0x642/0x1400 [amdgpu]
[  493.080903]  ? pick_task_fair+0x24e/0x330
[  493.080910]  ? __pfx_amdgpu_job_timedout+0x10/0x10 [amdgpu]
[  493.081702]  ? _raw_spin_lock+0x75/0xc0
[  493.081708]  ? __pfx__raw_spin_lock+0x10/0x10
[  493.081712]  drm_sched_job_timedout+0x1b0/0x4b0 [gpu_sched]
[  493.081721]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  493.081725]  process_one_work+0x679/0xff0
[  493.081732]  worker_thread+0x6ce/0xfd0
[  493.081736]  ? __pfx_worker_thread+0x10/0x10
[  493.081739]  kthread+0x376/0x730
[  493.081744]  ? __pfx_kthread+0x10/0x10
[  493.081748]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  493.081751]  ? __pfx_kthread+0x10/0x10
[  493.081755]  ret_from_fork+0x247/0x330
[  493.081761]  ? __pfx_kthread+0x10/0x10
[  493.081764]  ret_from_fork_asm+0x1a/0x30
[  493.081771]  </TASK>
[  493.081773]

This fix matches what we saw in the KASAN report. The issue happens
because gpu_recover() reads job->pasid after the scheduler restarts.
At that point, the TDR worker may already have freed the job, which
leads to the use-after-free.

By saving the PASID at the start of gpu_recover() and using that saved
value later, we avoid touching the job after it may have been freed.
All other job accesses happen before the scheduler restart, so they are
still safe.

So even if the job gets freed halfway through GPU reset,
we still have its PASID safely stored.

This completely avoids reading the freed job.

From my side this looks correct and robust for this UAF

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8a851d7548c00..c6b1dd95c401d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       struct amdgpu_hive_info *hive =3D NULL;
>       int r =3D 0;
>       bool need_emergency_restart =3D false;
> +     /* save the pasid here as the job may be freed before the end of th=
e reset */
> +     int pasid =3D job ? job->pasid : -EINVAL;
>
>       /*
>        * If it reaches here because of hang/timeout and a RAS error is @@=
 -
> 6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       if (!r) {
>               struct amdgpu_task_info *ti =3D NULL;
>
> -             if (job)
> -                     ti =3D amdgpu_vm_get_task_info_pasid(adev, job->pas=
id);
> +             /*
> +              * The job may already be freed at this point via the sched=
 tdr
> workqueue so
> +              * use the cached pasid.
> +              */
> +             if (pasid >=3D 0)
> +                     ti =3D amdgpu_vm_get_task_info_pasid(adev, pasid);
>
>               drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE,
>                                    ti ? &ti->task : NULL);
> --
> 2.52.0

