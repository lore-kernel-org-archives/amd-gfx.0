Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D292C25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 08:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83EB510E77B;
	Thu, 26 Oct 2023 08:54:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD6410E77B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 08:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMkU+xRHkFd++uT8E9CgnRZ/3XmRi59Rd0YPaQXk/fYOJYPhqQ7gaxEuxsGevWEmsIrbs+yd1NXfBw/8nFx3vVFS+3u/2kpPAbxpMAI1czMXqFCNJxQ17qlHfOeWZ1aT2N8ou01qk7W55QpYR+bylxB2kmZYLGUQ40QZlgy3anD+qnCtiLYTehpEwlLi3JkUdz8FrgFtyG5+DoX3laqfzIrzWyHVtV6Wz1sXpBRDv3SQCiOaKYnmILbDYQh3eOtfj9O9KnyZ11rPCTAVbvyhLlR1orvZjZc/a9KydsSlrlyM8MNZ+p9rE0gdXo0Bf9iSx11FrSLqzb3YamcTzroBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t04lT7z/4/jASqVnNpNSUmxyB1s8PpGGn3E+TO+dQkg=;
 b=NBK4msk5k9H7BWIyzMlQAcIOXQWb+R0074ATld1z2kj7LA3lKoJxgYbnwA+W22nH6qzNUYSTCJGgf+Iyx3MIGbvpY7epCljkmT5TRleNUwp9t+SZHxTqPdX5fnJd+P/Z5+P1hg3QO14LWj81hMTHI2boPmzyfnht6UV3YSEq2sE8J9nejO1ISKmZ81WasBlNYXz4sV9mr+lxbV+XOdS6yy7MOU8d92f1SX8wakqRRcFd12mzwiRPlu7u3jORdpCzMpmVQm0VHc3C+6aNPSb5xvIYQo33lQSrnlZsNZ4x2ik3bZnXYKj3WfMATRK10zVuBT0ko85NKzfLogZxyy01cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t04lT7z/4/jASqVnNpNSUmxyB1s8PpGGn3E+TO+dQkg=;
 b=IJQghZHuxF3tCt5vJoM9+Ch0m7nXqescZ1OfFu+6fPBERW7OBb7hGINQTQVf2sasA3QJrffYoXQqrG63vDUJoAEitXpBheF9NCnGRvNZTw6Tu3F9kby0amfH1/Evx8fnmqZ7Bzul1eAtl0XO25MMJeAp19ng7GahmLoomXy4hoA=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:54:38 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::9236:d15e:dad2:96a3]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::9236:d15e:dad2:96a3%4]) with mapi id 15.20.6907.022; Thu, 26 Oct 2023
 08:54:38 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix NULL pointer issue
Thread-Topic: [PATCH] drm/amdgpu: Fix NULL pointer issue
Thread-Index: AQHaB+eSE4WwyLXuQUmCfVSCsDoXjrBbxBxw
Date: Thu, 26 Oct 2023 08:54:38 +0000
Message-ID: <MW4PR12MB6875B77EAD16F08396A967A191DDA@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20231026083633.947965-1-jesse.zhang@amd.com>
In-Reply-To: <20231026083633.947965-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7ba61ed7-e321-486b-a471-54238d310382;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-26T08:53:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|CH3PR12MB8660:EE_
x-ms-office365-filtering-correlation-id: a8adcf9f-2075-4fb0-e80c-08dbd6012f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1e2MEP+l2Y3SQL2hxbSdf7hXsuhoxsiFwP/c/B/u29FFze3GP63SDlhktA+LyqjDFyt4hIzA5wFLkm+jBeIFR64EoKmPjsa7+/gul/G9RVSuO8wPeoAkuVTv7puC9EhWW7IZ0Drdu3Y6xtyPW1Wsv7v1iNzGA/NbqVOeSjZrh8ki2ti8Y39QxtgnHDACWqw2vvrDzfXXvajzvpjevSaLBKUnrCrl1J/EITq6bLIPrGfwghNqAhPXkfT3vSr+oSGH9XGfLqsEotBQCr6HNvyswBFlE2ogZy6ZSaM7CpoJzO6768YaKilgXHKBLzSjNCDSFadonCAAraNeIIVu+wdmyed/VrF/9OdoLDf0vU0397ZU1B6MHn6KQ38nZwqb5VjPd9ABB7s6d++mASRJqvArOfnlgnf321tW3i0ckGJ25GSkP2Lu+gasbi3M3/QRgRdLHPll1aG3RVdD/6+rsu7oKUsWmgDYfUnDmpI3tbn1uJZBvnzL7JpB6nkPJWz9TP/49qOeaqoyEJu8nYeC9s8bsbUHgAxYfBJp9ubGJE2eL5vx+ufxRY5s7c/kd8W6Z78HEURVSQXhwKMWFYzryUfYfH9vPedhbQJJ5AlNUZPr+nCK9ZOKhok8Ca4i8d6gyxLf1Y/sSclAz8WCyYD0YGjp4zccwY2h2yx5govwocmCuQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(52536014)(5660300002)(41300700001)(86362001)(122000001)(33656002)(55016003)(2906002)(38100700002)(6506007)(71200400001)(66446008)(26005)(38070700009)(9686003)(54906003)(316002)(53546011)(7696005)(76116006)(110136005)(8936002)(64756008)(478600001)(8676002)(4326008)(66946007)(83380400001)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mB36xU0rYXamseQiBs9NoHS0GsHNdzLv0N3jD0Z67+L4tbT3dmgBrdfuQUsh?=
 =?us-ascii?Q?mUZIkWknBrRbtOMUPF3Wj/5ENUOKqWnmDJQ5vBOi6WM1Rhj9yloCZVjxSmR5?=
 =?us-ascii?Q?nlks+qJuWtzNODL7il6RvQ5EGRL6XjgLODeopSOcr8wEUHyRmh7DO9K/2yHz?=
 =?us-ascii?Q?qSFRVExaOeRwfu/6J8LbpcZNFI1k97RSHhAJA3o/afhQX3u7HALqj939h9I4?=
 =?us-ascii?Q?AiQJUeSLZds3gyVPZoI0W/mBkKg7Y4zXJo48DH1ZZzRv6IiuiIkS21urk95v?=
 =?us-ascii?Q?nu+sxprR/aNZhWHadDeSEwbLRGipqRg5YTrlT2i4ojjLtqQitP0C9Z23CsGa?=
 =?us-ascii?Q?ELlpDeIR0fnUZ2bA33WeGRAtdVyukY0mIARcM4PlqRQHo1VdoqvLEIbtbe9g?=
 =?us-ascii?Q?F0fyT/jd3FRHihXwRpg0XlaHXT3LQRx1ux1dgE908q/NvK2OH8QURXHi6870?=
 =?us-ascii?Q?YodaMpKzsMrpgGjdU+OlweliLR+fJ4B5K1uGMGtpJ9M6scX4NCLe5OxC/1IN?=
 =?us-ascii?Q?LwBFRVcS35Fc7ORgkZ0gKjcxNstrrwARo0xTKEPZpIoTDHgMeqL2talC0hkU?=
 =?us-ascii?Q?B8ROLad0OghrS8gqi7ETs5tAKNbgWuFNOwpZ4oX8Zss2ZAyUeYwgs0E/4mUB?=
 =?us-ascii?Q?OMG62dNQjL7X2L6aDuQ+slI4B7KZ/7NX8loyuUOFs6YWNtCYfsote864qWoF?=
 =?us-ascii?Q?QUXpDaXbjPIxSlL8KwgGlkDwAc+8L4oBbaavP4wSGOhrVsRQXaSvcazoiU3H?=
 =?us-ascii?Q?75+Qh6lEUhsMLfnr9OIa2eFi+/Y+vEDWFG81ZdLrtuutpe7iiMcR4lJW5ACP?=
 =?us-ascii?Q?RTzYINhBLM4NmUia2OIqLd/pF3HpHRtlA1nHlaHRiPZnGetOln74UVr9Crtp?=
 =?us-ascii?Q?++Bfrc3+TYtHeHOHN+qJGTl7kkJw1jdQVWzP++6CMT7VWEoLQb2fnNWnTMT+?=
 =?us-ascii?Q?1WpwjHZVjnpimTA6dzeWQE9XIjcg9gOzEgxnI8tiaWFPzGMsa9jEoC/XY3Zt?=
 =?us-ascii?Q?dFDnkXzsEmAPPa1TmkGaO65VEzABWZjEawdQGQaR5OfO+weQsgShKVR35ewi?=
 =?us-ascii?Q?iWk3rGvHNitJNeJG/1MdazfF6LvKFs2uDVfNMxYRd0cut1GeT7nKrO0LPwqh?=
 =?us-ascii?Q?B4rF1H/GC7aKaY2P7A+E2SWqlQuHcAfqb4MPTPJR66UmrNs0Ph5aq/ukEdQJ?=
 =?us-ascii?Q?4a8yotCvW1gjz7Qould0OPCkEzyrtOLLpjgyDJbuTp1iPQgeLwNuV1rtj+8/?=
 =?us-ascii?Q?9VLBdpdnai0pz35E8IvWWWOH5yFXbbSK84B2MhMDjC0ZUMhKWkf9xvWc/q0W?=
 =?us-ascii?Q?xOMzQiWpxYPF8voH98UmO7q1pVaQ2HNYrKADJCJIHw3hoUdFC15WYQikUa08?=
 =?us-ascii?Q?0QZx9yAxH7tcDC6o5LxfK8C4rFoVvbJJc5oEFNFIim9tgSN2cpK3xA6lizxi?=
 =?us-ascii?Q?5YEiI0NFFg2d5/eDNB0Y2DUf2WqHpHn7f+ZKVVjVtMvP4tHbS7VlgIpl8sw3?=
 =?us-ascii?Q?ppiREifbhflmE8hmu3ZWgn6QevK1ydZpZzWgGatn1DsKE11MRILhRklAFWbL?=
 =?us-ascii?Q?hijzkke6Z7t4uyqUCLo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8adcf9f-2075-4fb0-e80c-08dbd6012f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:54:38.0765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8liBd6UXFYTWYejYsKxurBWUv91cg6Y/XmRjL1aYezANWgtc3mNPbHWCjHgOdQsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, 
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Looks like Tao's patch already fixed it, [PATCH] drm/amdgpu: check RAS supp=
orted first in ras_reset_error_count



Thanks,
Candice

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Thursday, October 26, 2023 4:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Philip <Philip.Ya=
ng@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix NULL pointer issue

Add check for ras pointers.
Issues caused by this commit: be5c7eb104067d61

[ 2312.987618] BUG: kernel NULL pointer dereference, address: 0000000000000=
0e8
[ 2312.987622] #PF: supervisor read access in kernel mode
[ 2312.987624] #PF: error_code(0x0000) - not-present page
[ 2312.987625] PGD 0 P4D 0
[ 2312.987627] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 2312.987630] CPU: 9 PID: 1749 Comm: modprobe Not tainted 6.3.7-38fc8aadcf=
b2 #1
[ 2312.987632] Hardware name: AMD Celadon-CZN/Celadon-CZN, BIOS TLD1001Bb 1=
2/01/2020
[ 2312.987634] RIP: 0010:amdgpu_ras_reset_error_count+0x126/0x140 [amdgpu]
[ 2312.987852] Code: 10 48 c7 c1 ec 6a 54 c1 77 08 4a 8b 0c ed c0 35 59 c1 =
48 8b 33 48 c7 c2 78 a7 4d c1 48 c7 c7 60 a4 5c c1 e8 8c 9e ca d0 eb bf <41=
> 8b 86 e8 00 00 00 85 c0 0f 84 37 ff ff ff e9 26 ff ff ff 31 c0
[ 2312.987855] RSP: 0018:ffffa40402e378e0 EFLAGS: 00010246
[ 2312.987856] RAX: 0000000000000000 RBX: ffff90cf09580000 RCX: 00000000000=
00000
[ 2312.987858] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff90cf095=
80000
[ 2312.987859] RBP: ffffa40402e37908 R08: 0000000000000000 R09: c0000000fff=
effff
[ 2312.987860] R10: 0000000000000000 R11: ffffa40402e37640 R12: ffffffffc15=
93d80
[ 2312.987861] R13: 0000000000000006 R14: 0000000000000000 R15: 00000000000=
00000
[ 2312.987862] FS:  00007fb5d3b33c40(0000) GS:ffff90d006840000(0000) knlGS:=
0000000000000000
[ 2312.987864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2312.987865] CR2: 00000000000000e8 CR3: 000000010ae24000 CR4: 00000000007=
50ee0
[ 2312.987867] PKRU: 55555554
[ 2312.987868] Call Trace:
[ 2312.987870]  <TASK>
[ 2312.987872]  ? show_regs+0x5b/0x70
[ 2312.987877]  ? __die_body+0x1f/0x70
[ 2312.987879]  ? __die+0x2a/0x40
[ 2312.987881]  ? page_fault_oops+0x156/0x470
[ 2312.987884]  ? dev_printk_emit+0x87/0xc0
[ 2312.987889]  ? do_user_addr_fault+0x34a/0x720
[ 2312.987891]  ? exc_page_fault+0x75/0x180
[ 2312.987895]  ? asm_exc_page_fault+0x27/0x30
[ 2312.987898]  ? amdgpu_ras_reset_error_count+0x126/0x140 [amdgpu]
[ 2312.987980]  gmc_v9_0_late_init+0x7f/0xc0 [amdgpu]
[ 2312.988064]  amdgpu_device_ip_late_init+0x49/0x2b0 [amdgpu]
[ 2312.988144]  ? mutex_lock+0x12/0x40
[ 2312.988148]  amdgpu_device_init+0x2253/0x24e0 [amdgpu]
[ 2312.988225]  ? pci_read_config_word+0x23/0x40
[ 2312.988230]  amdgpu_driver_load_kms+0x1a/0x1a0 [amdgpu]
[ 2312.988278]  amdgpu_pci_probe+0x16b/0x4a0 [amdgpu]
[ 2312.988278]  local_pci_probe+0x4a/0xb0
[ 2312.988278]  pci_device_probe+0xd9/0x240
[ 2312.988278]  really_probe+0x116/0x3e0
[ 2312.988278]  ? pm_runtime_barrier+0x55/0xa0
[ 2312.988278]  __driver_probe_device+0x81/0x160
[ 2312.988278]  driver_probe_device+0x24/0xb0
[ 2312.988278]  __driver_attach+0x10e/0x170
[ 2312.988278]  ? __device_attach_driver+0x120/0x120
[ 2312.988278]  bus_for_each_dev+0x7b/0xd0
[ 2312.988278]  driver_attach+0x1e/0x30
[ 2312.988278]  bus_add_driver+0x11d/0x220
[ 2312.988278]  ? 0xffffffffc0b56000
[ 2312.988278]  driver_register+0x5e/0x120
[ 2312.988278]  ? 0xffffffffc0b56000
[ 2312.988278]  __pci_register_driver+0x68/0x70
[ 2312.988278]  amdgpu_init+0x74/0x1000 [amdgpu]
[ 2312.988278]  do_one_initcall+0x48/0x210
[ 2312.988278]  ? kmalloc_trace+0x2a/0xa0
[ 2312.988278]  do_init_module+0x4f/0x1f3
[ 2312.988278]  load_module+0x21fe/0x23f0
[ 2312.988278]  ? kernel_read_file+0x291/0x310
[ 2312.988278]  __do_sys_finit_module+0xc0/0x130
[ 2312.988278]  ? __do_sys_finit_module+0xc0/0x130
[ 2312.988278]  __x64_sys_finit_module+0x1a/0x20
[ 2312.988278]  do_syscall_64+0x3a/0x90
[ 2312.988278]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 303fbb6a48b6..33801a5bb460 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1223,7 +1223,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
        const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;

-       if (!block_obj || !block_obj->hw_ops) {
+       if (!block_obj || !block_obj->hw_ops || !ras) {
                dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
                                ras_block_str(block));
                return -EOPNOTSUPP;
--
2.25.1

