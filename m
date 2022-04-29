Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ACFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 22:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 434D210FAE8;
	Fri, 29 Apr 2022 22:06:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F52B10FAE8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 22:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhpeA3AZyl9M23mkKuAmQCmsIIeARu4ax0aY6CBcx/rwLNjL9FRwG4I3VEXs69C7di8wSY2lfdSo0gGplm/jJ05v8Cd1FqUvan2IdOAzJ1qSL/EOJ4q3Qga2FqleCpKB28qJu1AiYiUUravfMwlslJia+BXj/gES1ny22c83yaPNIkJzyo1bd165iLV5/BI5Q7gUfpJELi1EopYhNvFaUftJ8WB/X8x97oeNz+aI0Q5LeKIfjR5TlhTT2450xXsH3LJXWLYtksOLEfkgseZ7LKHgMbqJRxe4WsX36v9aWHcQUgEs5zKEHfFUX/bGFO3kByu7Jpko7NCadbU/x9Akxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypObzf6Vq+LTe+hQxGKeJ2WE/tea5TC9nrjgvUuYiEU=;
 b=J0M84+hAi2z/S7ODXlW0KWiC0tBrS84tl/IEtU3Mr5H7fZd8KHbJAkfOf5UcZhnhVNvBVd+RfbdFfWHrqIE7VjfRvUM8F5Fgh0GNgUsJ5u7QZjlAqHSC/q92yEwKjQ5AEwZbpw+TKFGNJ/E2oTmkYd+2iRK36rVhPiChrrgZsJ6s5n+NC6mWK2L3dD0lEyny+qZTxnzIZZyOTdjmmT9ew34IskCPgfGONSZ5EQzKeGaH7By4hCjcscevSPzcFVf4hHNFR7+GPN0fAr86Gxs701mJVevUDx4b9yYomgoa3y8ZZ2RX8ENrO8KZTzgUguldziZYg91FnvwjT48Cy8WJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypObzf6Vq+LTe+hQxGKeJ2WE/tea5TC9nrjgvUuYiEU=;
 b=d02Hxm5wqbf7Gj799m7/eWrBxsb0V5iEEVyC3yR4cvQThp9luQULoA2VDtV+QB8nZrJO1HuzMvBRkZnqRjtk19OqjNvvfaN857uPz1WfFMIbK9J1aJsyCcN36m+nhWABBu7MIJn+kjlOOUvVpKefhZelcQkPsegkwlUPYUvVf/k=
Received: from CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 22:06:26 +0000
Received: from CO6PR12MB5396.namprd12.prod.outlook.com
 ([fe80::60f3:d3c6:5d5:63b1]) by CO6PR12MB5396.namprd12.prod.outlook.com
 ([fe80::60f3:d3c6:5d5:63b1%9]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 22:06:26 +0000
From: "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix null pointer exception while load
 amdgpu
Thread-Topic: [PATCH] drm/amd/display: Fix null pointer exception while load
 amdgpu
Thread-Index: AQHYXBOr3VDyjHcxV0qEWx21E+j11K0HcnMQ
Date: Fri, 29 Apr 2022 22:06:26 +0000
Message-ID: <CO6PR12MB539677213D7E70D928D1F8AAF5FC9@CO6PR12MB5396.namprd12.prod.outlook.com>
References: <20220429215354.1132706-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220429215354.1132706-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8e44cf5a-4c07-4516-aa4d-3529e850479b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-29T22:05:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 599f8171-3065-49bd-12d8-08da2a2c817d
x-ms-traffictypediagnostic: PH7PR12MB5653:EE_
x-microsoft-antispam-prvs: <PH7PR12MB5653CF493F2F978A509CA790F5FC9@PH7PR12MB5653.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nbsynind7iBH9Oh2rMOnQS0H2l6nsIC4R2TavCXUb/dRZPr98q0Xf0ffJcoPBRRuJZTnB/EAk3qU3eTLjWZ4cIf6OYO55Lq6/yZ/vtUFvgjNcxivN6UzcisZuF5SNUQSxe4i9+DlrJu93TbpgexgR37LhslA4YsEsVVP07z8WFlIkMFtqTBx7YamjaLrXM2KUa/k0OarAK+ms83ynQ0r0qXPip9nJL4WFywK36RToRiRfui7gXxeG9rv2IQmbG3Fyo5LqeakRv94RMKmbsxJEJHH9rtiRK3CMlgq4q0vzKgEMMe6dlQujhIcYtQFFb+vlsZ+rjDQ3p4BhojFC9GlVty+eDwj8pgnGx+GNNSO6DkXrdqqeV1iSpK9u0mt7lo36Yr/CfYJ3plZubQOTfefUAF07hoR5g/3t4enZB6ZJ67GAsg994XLjXX8YC1zWt6Mj4d1Mj+0VtKESazuYfOxSdwh6C5wcSQ8lzOkAkLkdwv/qZ9ZHW9HOfF1YbOcjSgULJj5NvNVJ5z1TPyyT+O9iujT9l046j5ShTWlusCw78Dd21k1LhviH6IdNtDxP+8CveJTX3OsTPAyE3B/7MsjUTGY1rG5JQYRH5EzgQsdcGUtHTqhEz6cSmClJXr5nisFzF2Ifsxn/MoomZ+INvRxg3OZxB3A1TdEnWbt61dsSsXFPy2i8KsPF5F46wWqb1JOSNu9z4pShQ6e0yTKy3Y3PDQMgIy+q288HeJnOegW/fM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5396.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(8676002)(76116006)(66556008)(64756008)(66446008)(66476007)(4326008)(2906002)(508600001)(6636002)(5660300002)(8936002)(52536014)(921005)(83380400001)(55016003)(33656002)(38070700005)(38100700002)(86362001)(9686003)(7696005)(316002)(26005)(53546011)(110136005)(122000001)(54906003)(71200400001)(6506007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+49atPkPBmX/ZcmOMYMgEHtPV/tznJmThA6SZ0SSMzs8KFpu27CN+656q0rf?=
 =?us-ascii?Q?5PeMuEa36WNO4+mUnJtpyVO9Vl7lQMXJBJjsxzTkQn2WQ5fcW09D9HyMUIgW?=
 =?us-ascii?Q?8+xdeLD0DCnFhuoPe9M1MXjn2WvgnHnA34V/B1rAoadTcMEB9k2kr5prn50G?=
 =?us-ascii?Q?f1ZoTE+YqguPfmYGTCoW5VkS2L2PN9wypymheYT4hR1WZS5m+3bAGzvdXdrH?=
 =?us-ascii?Q?DAVr/HMLH3zQ/pRUppEXgYfSYRtEPIa2cX+t/vTASMARaiaX2tES8ta0Zsp6?=
 =?us-ascii?Q?uhCwvvchRWA/I2F2Nw7XqPcrhqXthI1bFmUhVXG+tsVm6OXGYeeElAHmlep5?=
 =?us-ascii?Q?26JGssuLJS9io+xen9sb00FP96yZqpgOoLx5k8HzVNnL/vZPL7jPvzmiRtD7?=
 =?us-ascii?Q?xCqczkXxbow344dJT+QWaHOoiqz7dc/0RAQLpbtoMM6FCMJb8wwE6d89t7KZ?=
 =?us-ascii?Q?GS7AhOoyl9tM+B7fKyLdfZ6czEBSCgSo3hOlv8mA0H+zS+6ScvE2DcMzgKwZ?=
 =?us-ascii?Q?9q8GznDiUYFMlOyprTXeHFlZETowoMm7Ht9rkoEpUpOGOiVf6Qay2ecbIMGc?=
 =?us-ascii?Q?SAp4xXxFz558l5+Owf2pNiMvGjhyIGaouMBFPQEy6YJpoYZfLa5wctcniF7y?=
 =?us-ascii?Q?qyRSUcB0ECJt4FsFr7FRtKpHX11ODpMTHFJiYrh8k6ri11GyVifBe/B8tDi/?=
 =?us-ascii?Q?jxXbHQQFJtxb5WJ/w5KtDWTZHQGKgRm0XfKiGQz9bhV9MBgXwKASNo9Rn3HA?=
 =?us-ascii?Q?fxbZYd6yqKCkxltpPQwinLxHOIxebG78EJMFhpK+rVmTu66cGSPFs90NxgQu?=
 =?us-ascii?Q?vNWvBcAdjRdjqd32Ix7DpE+7HL2CEWgsgNeiIp9N7x40eAnQj7qMkdwaBnNQ?=
 =?us-ascii?Q?QThtni1iKdLEYpFu1b2QVD10RD2L9lRzaiLaq4a6gNQnjYhKydMotsMWfWAp?=
 =?us-ascii?Q?GqLSWW9BIxst8GYSeoBE7w45Vc+2k/MvVsHFHs0OC3iKuKseU3tTQAxaeiGb?=
 =?us-ascii?Q?zo3CLr6p/Snd3TbkxiaZoxvaNguMZEnRo/V8IJEot1vUGR7v6wdqqSLKrb7C?=
 =?us-ascii?Q?nxJZulWUfsvNEkuJfZgxeULpeEi0lqaItJUwbEN3S5rRRvYRuS7lIrJupDX8?=
 =?us-ascii?Q?HSc9poKzvi03dqTJ2qPuLWusoaF0nJSfAL6rVfJOsOQZsEcfC9WbLs/Rvdtd?=
 =?us-ascii?Q?QS8+ZjPi47XPxqC+7duFvJWNpc4XF/WcXt2Tkc6bX4Tqd1uMeD57t4eeyjHL?=
 =?us-ascii?Q?4cjVHrgZ6/uh4zmIcCEsYnq2Sy/H+qBWCsv7mnpNFZNrU0+xhs1QK/hpVWY9?=
 =?us-ascii?Q?TGI+l2rDwU5VAc/jMOvRlOls+R71vvi0bgl+/KsJtuAIpMcWT0m5tBRGBa8e?=
 =?us-ascii?Q?daT5hWGKq1MKa9AcYJSTBCesvD7HafFBy1FFmXlD5iKfUuyxGhfaiFUz3Aqm?=
 =?us-ascii?Q?wcD4s+6BE4bJy9AW4xrMajJxY3jR57S8MMf1dELploLe5h3LuXzHK69I2oli?=
 =?us-ascii?Q?FNtzIiFE3vvVL9V8XOJUwLW1BRSwU758CX1RBJ139PTufGavsRMTS8yjyq1g?=
 =?us-ascii?Q?I3/9qEXxsVdPZkS9vk15hldPA3O9UNdQzsUjexeOs9XxhFUeyyB3Bdk0MRYA?=
 =?us-ascii?Q?N81QC2fjj6u1soU/p/Q7bNpj1LuhOA3hNWH+lEL/pk8aDvFd1LvSu1ymCV3M?=
 =?us-ascii?Q?WL/pR1OsRmvgd/7ZRzyjYv/YTjev+f4Dja3BnFIpbRs8t+4t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5396.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599f8171-3065-49bd-12d8-08da2a2c817d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 22:06:26.5575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQ6pdmjjd9M2P3QYq8gLlokXXhSCCw+Vaqt/sf8accxdfFk9TmXfMGcLGeF78xURUy41eJx6ElAhHpJ+maTKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kim,
 Sung joon" <Sungjoon.Kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+review

-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: April 29, 2022 5:54 PM
To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Deucher, Alexande=
r <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Kim, Sung joon <Sungjoon.Kim@amd.com>; G=
utierrez, Agustin <Agustin.Gutierrez@amd.com>
Subject: [PATCH] drm/amd/display: Fix null pointer exception while load amd=
gpu

From: Sung Joon Kim <sungkim@amd.com>

Recently we got a hard hang during the boot on DCN 3.0.1, which caused the =
below null pointer exception:

[ +0.000426] BUG: kernel NULL pointer dereference, address: 000000000000000=
0 [ +0.000003] #PF: supervisor read access in kernel mode [ +0.000003] #PF:=
 error_code(0x0000) - not-present page [ +0.000003] PGD 0 P4D 0 [ +0.000004=
] Oops: 0000 [#1] PREEMPT SMP NOPTI [ +0.000005] CPU: 6 PID: 874 Comm: Xorg=
 Not tainted 5.16.0.asdn-apr28+ #15 [ +0.000004] Hardware name: AMD Chachan=
i-VN/Chachani-VN, BIOS WCH2303N 03/03/2022 [ +0.000003] RIP: 0010:resource_=
map_pool_resources+0x431/0xa70 [amdgpu] [ +0.000356] Code: c1 4d 89 c8 49 c=
1 e0 07 4d 01 c8 49 c1 e0 04 4d 01 f0 49 83 b8 f0 01 00 00 00 0f 85 16 02 0=
0 00 49 8b b8 e0 02 00 00 89 45 c0 <48> 8b 17 4c 8b 92 a0 01 00 00 4d 85 d2=
 74 24 4c 89 4d 88 48 8d 4d [ +0.000003] RSP: 0018:ffffa92a4142f718 EFLAGS:=
 00010246 [ +0.000003] RAX: 0000000000000000 RBX: ffff9a0b86d93000 RCX: 000=
0000000000000 [ +0.000002] RDX: 0000000000000000 RSI: 000000000000554b RDI:=
 0000000000000000 [ +0.000002] RBP: ffffa92a4142f798 R08: ffff9a0bdb3c0000 =
R09: 0000000000000000 [ +0.000002] R10: 0000000000000000 R11: 000000000000f=
000 R12: 0000000000000000 [ +0.000001] R13: ffff9a0b88360000 R14: ffff9a0bd=
b3c0000 R15: ffff9a0b86273000 [ +0.000003] FS: 00007f4b5641ca40(0000) GS:ff=
ff9a0cb7f80000(0000) knlGS:0000000000000000 [ +0.000002] CS: 0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033 [ +0.000002] CR2: 0000000000000000 CR3: 0000=
000102cb2000 CR4: 00000000003506e0 [ +0.000003] Call Trace:
[ +0.000002] <TASK>
[ +0.000004] ? kvmalloc_node+0x5c/0x90
[ +0.000009] dcn20_add_stream_to_ctx+0x1c/0x90 [amdgpu] [ +0.000330] dcn30_=
add_stream_to_ctx+0xe/0x10 [amdgpu] [ +0.000313] dc_add_stream_to_ctx+0x67/=
0x80 [amdgpu] [ +0.000300] dm_update_crtc_state+0x4dd/0x6e0 [amdgpu] [ +0.0=
00320] amdgpu_dm_atomic_check+0x63b/0x1270 [amdgpu] [ +0.000311] ? __drm_mo=
de_object_add+0x90/0xc0 [drm] [ +0.000043] ? preempt_count_add+0x74/0xc0 [ =
+0.000005] ? _raw_spin_lock_irqsave+0x2a/0x60 [ +0.000006] ? _raw_spin_unlo=
ck_irqrestore+0x29/0x3d
[ +0.000003] ? drm_connector_list_iter_next+0x8e/0xb0 [drm] [ +0.000038] dr=
m_atomic_check_only+0x5dd/0xa20 [drm] [ +0.000044] drm_atomic_commit+0x18/0=
x60 [drm] [ +0.000046] drm_client_modeset_commit_atomic+0x1e5/0x220 [drm] [=
 +0.000051] drm_client_modeset_commit_locked+0x57/0x160 [drm] [ +0.000038] =
__drm_fb_helper_restore_fbdev_mode_unlocked+0x60/0xd0 [drm_kms_helper] [ +0=
.000027] drm_fb_helper_set_par+0x40/0x50 [drm_kms_helper] [ +0.000022] fb_s=
et_var+0x1c8/0x3d0 [ +0.000007] ? __ext4_mark_inode_dirty+0x83/0x210
[ +0.000006] ? __ext4_journal_stop+0x3c/0xb0 [ +0.000008] fbcon_blank+0x228=
/0x290 [ +0.000007] do_unblank_screen+0xae/0x150 [ +0.000005] vt_ioctl+0xcf=
4/0x1360 [ +0.000005] ? get_max_files+0x20/0x20 [ +0.000005] ? get_max_file=
s+0x20/0x20 [ +0.000004] ? debug_smp_processor_id+0x17/0x20 [ +0.000004] tt=
y_ioctl+0x373/0x8a0 [ +0.000005] ? __fput+0x123/0x260 [ +0.000004] ? __fget=
_light+0xc5/0x100 [ +0.000005] __x64_sys_ioctl+0x91/0xc0 [ +0.000005] do_sy=
scall_64+0x3b/0xc0 [ +0.000005] entry_SYSCALL_64_after_hwframe+0x44/0xae

This issue happens because "pipe_ctx->stream_res.tg" needs to be initialize=
d first before reading its members. This commit fixes this issue by properl=
y initializing the pointer before accessing the target data.

Fixes: 9b98e01a28c6 ("drm/amd/display: Add odm seamless boot support")
Cc: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c
index f292303b75a5..147c6a3c6312 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2150,12 +2150,18 @@ static int acquire_resource_from_hw_enabled_state(
        if (!res_ctx->pipe_ctx[tg_inst].stream) {
                struct pipe_ctx *pipe_ctx =3D &res_ctx->pipe_ctx[tg_inst];

+               pipe_ctx->stream_res.tg =3D pool->timing_generators[tg_inst=
];
                id_src[0] =3D tg_inst;

                if (pipe_ctx->stream_res.tg->funcs->get_optc_source)
                        pipe_ctx->stream_res.tg->funcs->get_optc_source(pip=
e_ctx->stream_res.tg,
                                        &numPipes, &id_src[0], &id_src[1]);

+               if (id_src[0] =3D=3D 0xf && id_src[1] =3D=3D 0xf) {
+                       id_src[0] =3D tg_inst;
+                       numPipes =3D 1;
+               }
+
                for (i =3D 0; i < numPipes; i++) {
                        //Check if src id invalid
                        if (id_src[i] =3D=3D 0xf)
--
2.25.1

Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
