Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A678CE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 11:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A588310E239;
	Mon, 25 Sep 2023 11:32:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051D110E239
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 11:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIM0rz6vRUnTka9lS9s+kkPKVXE0RoknWWn0lXVWu2XhjDfv1D1FWKF+Bo6wWBgNncWqmfucBZcJ6diu70lavFjpMOlO6HgzuUpgMiir5sappApBTfrTCDhKtI+TlSQlUIMcRCU+SYlplHzrKXbUYiXGbk/7Ez2XEX1iOqBxkTfn8SKXNvnzIXb1gWPiK6dyG186835pHysUxHjOmD5kt+iJzwdEJxPblPjg6M8o4H41O3+zc06mLWnRgUMSIXGn/UPPTPZeBKP55EwWVomKEM5AJZl6alX0/FoVo/y3fFtgqmKGt5P3fs21r0g/wv2tq/OI8zI6R6T3rJ4tNB970w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxoWFZKQbdRTxTgY4wMxeK+YGhBcK9xoDN82QExvdYM=;
 b=Vt4jJKA5IkGuE3eMqjKpnqolupfh64WHlsqdI5ARllbnL5bDn39pkUyby6csQrOk0R5mG1YGlP7nNPpYd2v7ALanwEkjFnutVnNAc9mBApiKuQkrk43cmg5hGEK81B9bQfxKs3Lfnx1V8aG0s8kXr/Lh6ri89nL76/2LTKZmRAL1m1SRYuDUnPFml+Wj3n1dCprSiMdtBdidLLbwI0LXLLfIq/wH4Nfq/ux2KiB6FIbDci1FPhBuv7g0q9jlVWuwdsrZfa+DMtp069/jltTFXm9sr/s239BQVKtYnjkLVLOw9+ngaBCV+4HufDj27FPLuW5C3XtmOE/Sf1d0yWzt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxoWFZKQbdRTxTgY4wMxeK+YGhBcK9xoDN82QExvdYM=;
 b=rB8RIKvmNL5vrmAhj19ydaG9jd7SVFzuBvDHDreB/XdXv0bU8Vam1KKh3QGx0/LwUksEQwqDpwRYFZGIELPH0G/2Jq8WDZshpNh43AvruqPXDvQlOvIl5lwOUnPwQkt/eW4dYrDdUahR6AS72TeYni2ta6gKaj9HDhveiPEHVp0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 11:32:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 11:32:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
Thread-Topic: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
Thread-Index: AQHZ7g+FdxVj9o2bqU+vq86A2bVmBrArajgQgAABEKA=
Date: Mon, 25 Sep 2023 11:32:37 +0000
Message-ID: <BN9PR12MB5257AE0760BA4835714303A8FCFCA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230923111651.719593-1-yifan1.zhang@amd.com>
 <BN9PR12MB52577619DDE258CA1F89A5E4FCFCA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52577619DDE258CA1F89A5E4FCFCA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fcacfb65-9d07-41a5-aa85-42239f0fa70c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-25T11:26:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6084:EE_
x-ms-office365-filtering-correlation-id: a93dd391-ce14-41c0-16f6-08dbbdbb1ed5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4H26hz8WLFik1tS5To13VOopuagaHgs5XusE/EMS4WDzXMb2QgfIGR2i3n29GvCEgQYIch9ZtpLxzs0SR4EOCgxF5HUjmQE7V+K3u0LuOyA/8C4wBJw/77omoDVIwbtS9tBJCtEJD5sgATs27waiJiom5Y36MDmqzjeiz7WmYr8xd5VRCRvW/VHBvM1+M6mHrgPoPu5xs4EMd7GFiUd21SpqCQUWjl6UMZ4C4LgfnOuy0ProdZ8cwwCzRMFiCwI5B4DD5uY8H/76qmWv9Then68Rnl5VoSR3UVqVPn7Yw8ZtQixViTP/t39Edmc4TJhgEsIYn4vcddOqhwWGzMfZzfXQtHjo4A3eUn9+poQa9VQ5RS23XrgJwqZQi4SsIBgHvl5cJAIPZ8zsVsR43OigBX/WN03WzZrtfBlL0MMVWABfEzStOh7yY/UP7ekeaUxmNprYj1+rDmXEK662otsxmcvgE33GJteSqVaonkjwwe8es3FJV2kwKLsYJGXAoWhDbNItMheiVAI2LAtTFLdMC1Jmr3SyemX0GnadKWmoN9Xj32EKL7XrM5khGgjFfVZ6310li0kRPi3BdQhTqvqU5tcVCtG4jemkm/u9R2fYeJEMHMTYNgNzhIe7yl216DBi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(55016003)(2940100002)(71200400001)(38070700005)(38100700002)(53546011)(54906003)(66556008)(64756008)(26005)(66476007)(76116006)(66446008)(66946007)(478600001)(6506007)(7696005)(83380400001)(9686003)(316002)(122000001)(110136005)(86362001)(33656002)(2906002)(5660300002)(8936002)(8676002)(52536014)(4326008)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fLtCqo8bwyGmtzj/U4Hp2zy5u3vzFKP4HY932Bp0bcedEax3XigqQQ4k09Oe?=
 =?us-ascii?Q?jntNls5MFUOYUkHSDGuYbKQ+hMjYJJehKvXVAWqn4/I0ar4bAmDL6yqltU0U?=
 =?us-ascii?Q?fza0hCAgIYWD5dq212LjxcRpJ1N0tc7BuswU/JNIxhCkvioOE1DI4NUKdbXJ?=
 =?us-ascii?Q?1W8pqQer4wGunPgxg52Ge32WnyB4jYk/I/V4f9tJvC93RZsZL+/bB/LSnoup?=
 =?us-ascii?Q?TfD0nSQ8rMCsMWizRpjerskOZ5VSfJISw1X8ep+L34NSQ879UYPIjkJR66Bw?=
 =?us-ascii?Q?2sisruRbasEjZ2a2ZH20cqCiBX/j7KqBI/7fZQt63NRJSa9dsWCdUN02cm2G?=
 =?us-ascii?Q?5Qhw3Qj/eUXpWTq8TiZ2t0ycZxjutJcqVbJs2JLounrRLz5REhK5ZNb9XEp1?=
 =?us-ascii?Q?5qaG8lNzQrA0kLmXu8uWr0KypSPw3ormftUPymXSNddTja4067SDXMlKW95b?=
 =?us-ascii?Q?+qhCv+csQa7eEiczzx/4q39oPMcSGA9N6S5gOG/4O9GwPWm45a/2Mb96TdWY?=
 =?us-ascii?Q?IHriQPliVUM20R5mcHuOa7DDzZhrdmQDXF5wAW8oKMvC8os/wqOf+4iEYy+e?=
 =?us-ascii?Q?DSpG9WjKkYl8Vf6ls3jmHnNmRJqRYESI5LrLEP/+WInRduPu0JqubUqBn5vF?=
 =?us-ascii?Q?k7lxHG9ICNkhMEU6XCxX1C6frke/bYYZPu21c2QD4lg7RPKSH/FTEbjoBnur?=
 =?us-ascii?Q?GK0hl7tquKVyuguvqzEEOCxtcrFPEjC3RbYhcueFeWv8X9tMAzgJPdutkZM1?=
 =?us-ascii?Q?Yp+FhlzTvihBwPIW3pObVvVuXVYi08O+x1NADQ9DMDSf+vKvtuglA7Sc+TX2?=
 =?us-ascii?Q?RgkFDDXO5ASPVuS1s8Kne8/AwX9gvHBghOl0c8NpBmE77dnvbBa+PUW2tsml?=
 =?us-ascii?Q?gqpEmmQQhQxtVTP9zK9FPE0qu7dxlHlcH4BxCMWqsWM4pmjdW9FkyAumNu1G?=
 =?us-ascii?Q?ZNPnE7SndWnQwwH64nwOT8o4K+sadQELU8L/g2Kp36CHMo0px8gTY/Zc8ED1?=
 =?us-ascii?Q?TvAG7kPaCiv1HxFNmzjx0T7dkmgGJbDoG1vK6scQ35nAdwSpQnGBpnK9GLg+?=
 =?us-ascii?Q?x6DTGTiH6/xpQIh99t66Y8BC/7XKx7Ed7DWhwiiqeIRogep5x65yj+iI3qJX?=
 =?us-ascii?Q?VgDTT0ykHfct35mhrTIqMT9/2pSZXEFPbkl3BIuO11WF2kswVF+YZHOdBw9Y?=
 =?us-ascii?Q?Awwof0C/4cdh+DxCVbnowE6v1SaXVvsLlsLRbfaIZT+MgNut2PD6iRSwpRxS?=
 =?us-ascii?Q?Y2QOoiIBCz875QksMHqtNUM3DdE7FacdT0of90LfZhDzvI6Vh8CJWbY5kKvs?=
 =?us-ascii?Q?7QBTvEoV9ztWuTbtwygI6fMzg2WBeGqI/QXHdc7Hnxv94DSEQFe4HpxUh414?=
 =?us-ascii?Q?M6s4MzlQWQy/Fj2V2f9Xj16oMCP2VWDHQljRq5W744ca1QiHmX/BjZIK+5+v?=
 =?us-ascii?Q?wAwugf3y4PjkFLfKy64rHPWEkn7QbGbaLRGSwHs0YVRDWunKb9WRWZwHqrR8?=
 =?us-ascii?Q?C0Mcm6yYOJnxJDNvMj6i+VHjZ0lQQArEmOtoW08WSlY174FCrdFG39Fd/1JJ?=
 =?us-ascii?Q?+07iNo3M4dc17Lo7EZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93dd391-ce14-41c0-16f6-08dbbdbb1ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 11:32:37.6765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcG8T2bhhlNp2RXDxxyi68eSsEJwvhciBtGzujtPRladHyKsTJRVcnPvYu5K193RXPjHE4RRmUoC74TNKrtXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

For sw_init, it's fine to move to gmc sw_init phase, but any hardware progr=
amming should be done after smu hw_init.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Monday, September 25, 2023 19:30
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init

[AMD Official Use Only - General]

[AMD Official Use Only - General]

RE - gmc11 hw_init depends on adev->gfxhub.funcs->init now, move it to gmc1=
1 sw_init

isn't any driver loading failure observed? Since from gfx11, GFX won't be p=
owered on until smu hw_init phase. Any programming that touch gfx core is i=
nvalid before it is powered on.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Saturday, September 23, 2023 19:17
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init

gmc11 hw_init depends on adev->gfxhub.funcs->init now, move it to gmc11 sw_=
init. This patch fixes below driver load error on GC 11.0.4:

[   43.928149] [drm] amdgpu: 512M of VRAM memory ready
[   43.928151] [drm] amdgpu: 7641M of GTT memory ready.
[   43.928168] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   43.928182] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[   43.928185] #PF: supervisor read access in kernel mode
[   43.928187] #PF: error_code(0x0000) - not-present page
[   43.928188] PGD 0 P4D 0
[   43.928191] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   43.928193] CPU: 7 PID: 1278 Comm: modprobe Tainted: G           OE     =
 6.3.7+ #73
[   43.928198] RIP: 0010:gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
[   43.928406] Code: 8b 4d d4 48 89 4d c8 83 f9 0d 0f 87 7c 04 00 00 48 8b =
45 c8 44 89 ee 44 89 e7 48 8d 04 80 48 c1 e0 04 49 8b 84 07 90 eb 00 00 <48=
> 8b 40 08 ff d0 0f 1f 00 44 8b 45 d4 41 89 c5 45 85 c0 0f 85 c0
[   43.928409] RSP: 0018:ffffae24c28277f0 EFLAGS: 00010256
[   43.928411] RAX: 0000000000000000 RBX: ffff95bf0ed80000 RCX: 00000000000=
00000
[   43.928413] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[   43.928414] RBP: ffffae24c2827848 R08: 0003000000000077 R09: 00000000000=
00401
[   43.928416] R10: 0000000000001000 R11: 0000000000001000 R12: 00000000000=
00000
[   43.928417] R13: 0000000000000000 R14: 0000000000000000 R15: ffff95bf0ed=
80000
[   43.928418] FS:  00007f2703c83000(0000) GS:ffff95c26e7c0000(0000) knlGS:=
0000000000000000
[   43.928421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.928422] CR2: 0000000000000008 CR3: 000000012c300000 CR4: 00000000007=
50ee0
[   43.928424] PKRU: 55555554
[   43.928425] Call Trace:
[   43.928426]  <TASK>
[   43.928428]  ? show_regs+0x6e/0x80
[   43.928434]  ? __die+0x29/0x70
[   43.928436]  ? page_fault_oops+0x154/0x4a0
[   43.928440]  ? amdgpu_bo_move+0x25b/0x790 [amdgpu]
[   43.928612]  ? do_user_addr_fault+0x325/0x710
[   43.928615]  ? exc_page_fault+0x7a/0x180
[   43.928619]  ? asm_exc_page_fault+0x2b/0x30
[   43.928623]  ? gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
[   43.928797]  ? amdgpu_gart_bind+0x64/0xc0 [amdgpu]
[   43.928974]  amdgpu_gmc_flush_gpu_tlb+0x258/0x2e0 [amdgpu]
[   43.929159]  amdgpu_gart_invalidate_tlb+0x66/0xa0 [amdgpu]
[   43.929332]  amdgpu_gtt_mgr_recover+0x67/0x80 [amdgpu]
[   43.929504]  gmc_v11_0_hw_init+0x4c/0x130 [amdgpu]
[   43.929690]  amdgpu_device_init+0x1766/0x2d60 [amdgpu]
[   43.929858]  ? pci_bus_read_config_word+0x4b/0x80
[   43.929862]  ? do_pci_enable_device+0xdb/0x110
[   43.929866]  amdgpu_driver_load_kms+0x1e/0x1a0 [amdgpu]
[   43.930032]  amdgpu_pci_probe+0x16b/0x4e0 [amdgpu]
[   43.930201]  local_pci_probe+0x4c/0xb0
[   43.930204]  pci_device_probe+0xcc/0x280
[   43.930207]  really_probe+0x1c4/0x430
[   43.930210]  __driver_probe_device+0x8a/0x180
[   43.930212]  driver_probe_device+0x23/0xc0
[   43.930214]  __driver_attach+0xfb/0x200
[   43.930215]  ? __pfx___driver_attach+0x10/0x10
[   43.930217]  bus_for_each_dev+0x7e/0xd0
[   43.930221]  driver_attach+0x22/0x30
[   43.930222]  bus_add_driver+0x120/0x230
[   43.930224]  driver_register+0x68/0x130
[   43.930226]  ? __pfx_init_module+0x10/0x10 [amdgpu]
[   43.930394]  __pci_register_driver+0x6c/0x80
[   43.930396]  amdgpu_init+0x67/0xff0 [amdgpu]
[   43.930549]  do_one_initcall+0x4a/0x240
[   43.930554]  ? kmalloc_trace+0x2e/0xa0
[   43.930559]  do_init_module+0x52/0x230
[   43.930563]  load_module+0x2386/0x2880
[   43.930566]  ? security_kernel_post_read_file+0x60/0x70
[   43.930571]  __do_sys_finit_module+0xc8/0x140
[   43.930573]  ? __do_sys_finit_module+0xc8/0x140
[   43.930576]  __x64_sys_finit_module+0x1c/0x30
[   43.930578]  do_syscall_64+0x5d/0x90
[   43.930581]  ? syscall_exit_to_user_mode+0x2a/0x50
[   43.930583]  ? __x64_sys_mmap+0x37/0x50
[   43.930586]  ? do_syscall_64+0x6d/0x90
[   43.930588]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Fixes: c6f52f1ffd91 (drm/amdgpu: cleanup gmc_v11_0_flush_gpu_tlb)
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --  drivers/gpu/drm/amd/amdgpu/=
gmc_v11_0.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 42fc0cc13fdd..9c4562bda8cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1329,8 +1329,6 @@ static int gfx_v11_0_sw_init(void *handle)
        struct amdgpu_kiq *kiq;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       adev->gfxhub.funcs->init(adev);
-
        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(11, 0, 0):
        case IP_VERSION(11, 0, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 7d61f66625fa..d0e3583a3cac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -720,6 +720,8 @@ static int gmc_v11_0_sw_init(void *handle)

        adev->mmhub.funcs->init(adev);

+       adev->gfxhub.funcs->init(adev);
+
        spin_lock_init(&adev->gmc.invalidate_lock);

        r =3D amdgpu_atomfirmware_get_vram_info(adev,
--
2.37.3

