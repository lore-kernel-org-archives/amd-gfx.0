Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA080C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 09:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581F188647;
	Thu, 26 Oct 2023 09:08:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8BD88647
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 09:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgvfPjSZ9kLMc8yteL4R8bGQadYfWhd/d7u1FlW7o25sX2V/Gtdmv1FHVXWEomd+QgWQnLIngAXXrgwCzNOtTgnNTHLLGm+PniN+sXrknJAi0A2Y0MsMzK5yocLwn9to0wOBHKYbBotrpeTGSJzyGyiDCT/xFEHuS1QhPXKIi3YgwmiDNP5Uj0iK9NYzp57BPSngrXR+lcZKTl4sHbYm4BdGxuUBrJ9le/Tq7TpwA3m0zo/wQoBpj3n6INfBsE/54gMLweTpqd9zEpg9AzLWDQ5OpltMWogwNt8+CHjliUiFM++55UVcpEusgDyKwxl5ChVuRZD01OiNQ4EbxThaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8geU0MyyyS4tYb5V/XZFisxiUwS5jUmoK2uCu8O5rg=;
 b=WYCBnbfi/dgl4PzA06vZKHg81jsICADzTJK7TvjzNC3KL3Rb6AvFV0/wfYAqXRMWOKaJN3akYu3HP+e/D/i7wXuZN+WlqV+RhLfyH90NflPpSRDKk0ajyA/auu6SJS5IIiYUbAJWRnQKcc6xt1UNS0JRLCSg3JhP4rUN4tz0sOun9M6Qy2x9tSC0MC8qvJfvUEW4OV1cy87Tt06a+FwW2uSRsN4BVkKp7ucKG3uqxy50eFv+wiLPnkhTGmQpC7uO+ROFqUHp1HY16n+fZnqrVG7E4twyEZvgucan/v7HUFdMhNIlEBgv9bKnn7RDiFJmN92FcplgKEUoPg/UftxjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8geU0MyyyS4tYb5V/XZFisxiUwS5jUmoK2uCu8O5rg=;
 b=R/YVDvwfijCZzWZa+obyxbG2+mzGfacBPRS8N0iN3Udv1nJLnNEoZSguQKgsZCM6SYwJo9zgV26vc/U1+fqryD8P+yhXs4klvX1nYItkEAKhXhGi12LRybumCTHEOHq3wvZHXY2669xD18aleHrHiYqfSC9rFoBb+oYjl8Ww/6I=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 09:08:06 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::a816:3644:9c05:6016]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::a816:3644:9c05:6016%3]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 09:08:06 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix NULL pointer issue
Thread-Topic: [PATCH] drm/amdgpu: Fix NULL pointer issue
Thread-Index: AQHaB+eOK1K5MGvxskGqDk2Gh9ej27BbxEoAgAADg1A=
Date: Thu, 26 Oct 2023 09:08:06 +0000
Message-ID: <DM4PR12MB5152A5827B60124E9FD02B7FE3DDA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20231026083633.947965-1-jesse.zhang@amd.com>
 <MW4PR12MB6875B77EAD16F08396A967A191DDA@MW4PR12MB6875.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB6875B77EAD16F08396A967A191DDA@MW4PR12MB6875.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM3PR12MB9350:EE_
x-ms-office365-filtering-correlation-id: fd437174-f04e-43a9-1842-08dbd6031141
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gyg0fwLgY7HFhN+a9wtXuTVGa60hrPbH8eTV004tP5GtW28H2clE7eQLB8g0HFUxC+J36AGmkucOzIEvPS15/8QA1yLuJ31SFGsw1uLhDfSns/P2mKzhsC43zpjmKL4noSV1YwLHpl4u2jlWlGz9SKKCfiMRTPtf2tR6u6vHtj73fewWbbDnHGlipBfsc+0DwPscLoAaNppnSDFAL7PmHOkNblCGWwD4DwObuHV2Mziwzu6IgZYzSZyPx283eaaXur45NBCXAe7CNqu7gGBpeZSr12p0I9aUeOhCbPhgXq7SOkemy1+klwycGVyf+10uTFO2R4Xgaj/xdOwFpB8Cfy23Ux0ZjUE0p/yQoblxFkwZp3n0AcZZcdvkWhl/1ot7iHe+gXpjkRT5PtBFIGs3voLRspGvrYohVnCNxASzbB5SnMVypBDkqUVHtsbV73cICpte03bmnbs468PHC43fgt8/gDwFICiIQcyJOG8pjZJ/ejzcG7CEDB21um2A1g8Bv9FdUZUCXPawnoxc5awU0/+NkFoaLNFeTnUKswPOlI2KCqTc7U5TprkX0p06f6pk3/p/b7jUvi78eSK8CfjclfuZIo8xKs4xRRMlYQLZVSWqey/6Pn6aAEfVef/39OVS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(33656002)(38100700002)(2906002)(86362001)(83380400001)(5660300002)(55016003)(9686003)(41300700001)(122000001)(110136005)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(316002)(76116006)(53546011)(52536014)(71200400001)(7696005)(6506007)(38070700009)(8676002)(26005)(478600001)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fxvTWwsXlZe+yZ7cfaRoN/5LYoYdxXfZ/kL2NYMCpVp1MyCMsJoXn/AhUKGQ?=
 =?us-ascii?Q?Gn+G/asb357k4Qvjz/4Id9g1Qu7Szt/BEKxljCaJUz7vfBvm0rgBgdUXZpkg?=
 =?us-ascii?Q?iX3cCgd47bcFe/ftkZJCFDHZPNQXGK/E8/0YLqEQPU1sLY9cSCkOB9o7GLeS?=
 =?us-ascii?Q?uH/FmotBzgLIojIC/wuH/91x4OG3Xw5mPLA0ZT+8AcVXkxTttI3EBapwL51O?=
 =?us-ascii?Q?PCJApWdE9zd2xonsiwC5q+b741OKxUXrHAF8/7+BkwE8NAOZlypmTx+PuiRs?=
 =?us-ascii?Q?urF0TY/I72ykUMGQ5vyAc3OZ0H8v/t9gkr3xQE1a16Y0hLm7nWHN5UTDzeet?=
 =?us-ascii?Q?tdH+zjyf+HaHZMzdPmCrJNcKwrTILW85hZIVlh82l0Lp9l9kvr66BkJUgvNj?=
 =?us-ascii?Q?skw6CwX1v7Mgkzo3l75Z9/3cbsW/B2LxMlvnemPxqiEkiY8V+LokymVjDGGC?=
 =?us-ascii?Q?5J9f+NESIW5xrnC97VoYpE4l8cV8pe75uAYdozCwW2xguaOYX9C4bJMmGTq4?=
 =?us-ascii?Q?sG/oN74SxvI5zfpMftvSjFHaLNqqjbtAL+9yHb/+GP5f2mkbzzVO/PQISQlI?=
 =?us-ascii?Q?dG5/uCKzaWvYIS+jfZpjBfD0ZjgeHJukE2yElFOT5O8sPbOXMg3GWuAX+iMv?=
 =?us-ascii?Q?LuMB35DSlvDItAxFqoLdvEiQJ/NH85ub6s5mAQAY3IEhYvsUphGpbRBB11aR?=
 =?us-ascii?Q?Ip0Mn4bfsp22sJx8d0F8CSC5Sakbeemyt8wB+M+EqNa/HjnK/M3CJHryskWo?=
 =?us-ascii?Q?WSxiR+NWBlvcs2q23MOoECX4NmwM3X7Q4a/oH/Ydo4/QXNdjw0kWhMy21NW+?=
 =?us-ascii?Q?h7dOXZsxY0hHtq3l++Qp/a0qUgLGa+hEH3WUYouW2Co9APwXAIppRtTnzsaP?=
 =?us-ascii?Q?CqGZLmD4FKebJF9X9LL6AuLAqcDkEKOXQarBHClDFclMUVuiuAqTJPN3leE/?=
 =?us-ascii?Q?irsM5//jta3d8LimC6yBcHaZcZI6XNJvuFR3jVhsESzeIQxhEYBPCY0SHXNl?=
 =?us-ascii?Q?dwQEpt011/w6PAPbjblwttZuXQ1PtKJ4lIAVdW7qqoptyp22bS5iPErBsbq1?=
 =?us-ascii?Q?HZBJxXmTTPhFj6Z2FzjdMJiUCruWIi8HtG6+3wZoy6HqpDqfl0wbxWbup5QU?=
 =?us-ascii?Q?dp0ozbegjn0Nh7QPpTBwqX84JGLDSH+RrIjgG2/BuhZ9wz774Rd+zTY+R4Xg?=
 =?us-ascii?Q?uiZDKExq8eArLNeY61t380Jgl/2HEaF7FcSrqcral0UIS+S5K62bdGSqCrJF?=
 =?us-ascii?Q?9tq6QE+neor1Thh/Kk2K8Xk7hFZJjtc8iv2qXECKU58uXtS413AWQnFyAxuR?=
 =?us-ascii?Q?taHeLTqQpPaVKl8iDxICp+YvNv7lp3OMazYTdPCIXeTlK8fw8aW5DaTF0ay9?=
 =?us-ascii?Q?Fpb80O8TkcOoNFfUjGI9pkfs8o+V+N8ieUO9KMjeiTagMDgyCVITBDFu9eyy?=
 =?us-ascii?Q?OIGrKfx4x8YXw7skpI0ONLLEB7KUqdT0UhfUXUk4yjdYyCOdhVbjnT3ZMsB3?=
 =?us-ascii?Q?vSdZG2BqAsZy0RlTKuWxxeYZv+LjhayuB47Q6FNYEgYJV6R/sq5y3eAaX5UP?=
 =?us-ascii?Q?q7xYZ931lMXpotLAFw8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd437174-f04e-43a9-1842-08dbd6031141
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 09:08:06.5417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkXa70PTvwH05lCyLX210Ze1nZMS5iC5gxnnH4K4aK8WijP7Qfhj0DxDLoX5Tb49nIqfEy5qt5PZQHRiBBoZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350
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
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Looks like Tao's patch already fixed it, [PATCH] drm/amdgpu: check RAS supp=
orted first in ras_reset_error_count

[Zhang, Jesse(Jie)] I see it, Thanks for you reminder.

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
0e8 [ 2312.987622] #PF: supervisor read access in kernel mode [ 2312.987624=
] #PF: error_code(0x0000) - not-present page [ 2312.987625] PGD 0 P4D 0 [ 2=
312.987627] Oops: 0000 [#1] PREEMPT SMP NOPTI [ 2312.987630] CPU: 9 PID: 17=
49 Comm: modprobe Not tainted 6.3.7-38fc8aadcfb2 #1 [ 2312.987632] Hardware=
 name: AMD Celadon-CZN/Celadon-CZN, BIOS TLD1001Bb 12/01/2020 [ 2312.987634=
] RIP: 0010:amdgpu_ras_reset_error_count+0x126/0x140 [amdgpu] [ 2312.987852=
] Code: 10 48 c7 c1 ec 6a 54 c1 77 08 4a 8b 0c ed c0 35 59 c1 48 8b 33 48 c=
7 c2 78 a7 4d c1 48 c7 c7 60 a4 5c c1 e8 8c 9e ca d0 eb bf <41> 8b 86 e8 00=
 00 00 85 c0 0f 84 37 ff ff ff e9 26 ff ff ff 31 c0 [ 2312.987855] RSP: 001=
8:ffffa40402e378e0 EFLAGS: 00010246 [ 2312.987856] RAX: 0000000000000000 RB=
X: ffff90cf09580000 RCX: 0000000000000000 [ 2312.987858] RDX: 0000000000000=
000 RSI: 0000000000000006 RDI: ffff90cf09580000 [ 2312.987859] RBP: ffffa40=
402e37908 R08: 0000000000000000 R09: c0000000fffeffff [ 2312.987860] R10: 0=
000000000000000 R11: ffffa40402e37640 R12: ffffffffc1593d80 [ 2312.987861] =
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000 [ 2312.98=
7862] FS:  00007fb5d3b33c40(0000) GS:ffff90d006840000(0000) knlGS:000000000=
0000000 [ 2312.987864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ =
2312.987865] CR2: 00000000000000e8 CR3: 000000010ae24000 CR4: 0000000000750=
ee0 [ 2312.987867] PKRU: 55555554 [ 2312.987868] Call Trace:
[ 2312.987870]  <TASK>
[ 2312.987872]  ? show_regs+0x5b/0x70
[ 2312.987877]  ? __die_body+0x1f/0x70
[ 2312.987879]  ? __die+0x2a/0x40
[ 2312.987881]  ? page_fault_oops+0x156/0x470 [ 2312.987884]  ? dev_printk_=
emit+0x87/0xc0 [ 2312.987889]  ? do_user_addr_fault+0x34a/0x720 [ 2312.9878=
91]  ? exc_page_fault+0x75/0x180 [ 2312.987895]  ? asm_exc_page_fault+0x27/=
0x30 [ 2312.987898]  ? amdgpu_ras_reset_error_count+0x126/0x140 [amdgpu] [ =
2312.987980]  gmc_v9_0_late_init+0x7f/0xc0 [amdgpu] [ 2312.988064]  amdgpu_=
device_ip_late_init+0x49/0x2b0 [amdgpu] [ 2312.988144]  ? mutex_lock+0x12/0=
x40 [ 2312.988148]  amdgpu_device_init+0x2253/0x24e0 [amdgpu] [ 2312.988225=
]  ? pci_read_config_word+0x23/0x40 [ 2312.988230]  amdgpu_driver_load_kms+=
0x1a/0x1a0 [amdgpu] [ 2312.988278]  amdgpu_pci_probe+0x16b/0x4a0 [amdgpu] [=
 2312.988278]  local_pci_probe+0x4a/0xb0 [ 2312.988278]  pci_device_probe+0=
xd9/0x240 [ 2312.988278]  really_probe+0x116/0x3e0 [ 2312.988278]  ? pm_run=
time_barrier+0x55/0xa0 [ 2312.988278]  __driver_probe_device+0x81/0x160 [ 2=
312.988278]  driver_probe_device+0x24/0xb0 [ 2312.988278]  __driver_attach+=
0x10e/0x170 [ 2312.988278]  ? __device_attach_driver+0x120/0x120
[ 2312.988278]  bus_for_each_dev+0x7b/0xd0 [ 2312.988278]  driver_attach+0x=
1e/0x30 [ 2312.988278]  bus_add_driver+0x11d/0x220 [ 2312.988278]  ? 0xffff=
ffffc0b56000 [ 2312.988278]  driver_register+0x5e/0x120 [ 2312.988278]  ? 0=
xffffffffc0b56000 [ 2312.988278]  __pci_register_driver+0x68/0x70 [ 2312.98=
8278]  amdgpu_init+0x74/0x1000 [amdgpu] [ 2312.988278]  do_one_initcall+0x4=
8/0x210 [ 2312.988278]  ? kmalloc_trace+0x2a/0xa0 [ 2312.988278]  do_init_m=
odule+0x4f/0x1f3 [ 2312.988278]  load_module+0x21fe/0x23f0 [ 2312.988278]  =
? kernel_read_file+0x291/0x310 [ 2312.988278]  __do_sys_finit_module+0xc0/0=
x130 [ 2312.988278]  ? __do_sys_finit_module+0xc0/0x130 [ 2312.988278]  __x=
64_sys_finit_module+0x1a/0x20 [ 2312.988278]  do_syscall_64+0x3a/0x90 [ 231=
2.988278]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

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


