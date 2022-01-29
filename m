Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54547C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 05:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04DE10E1E0;
	Sat, 29 Jan 2022 05:09:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA5D10E19F
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 05:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArRp0MNb7Wt3yM6lCgbumsoC++qbP/ssbXY9e4OWAkALXd88rcsQyJ6gACoamPpNexoxD1PrjSbdqlCNkvINJB5uPYptLVxtM4AKlvYgwLyYCtFNOiLzhPy38xxcUvfqiVVDee9Auksls6jHNaS8l801tC85FxYBkj9P6AJ8FeCQ693mcATmjC1HE+f9pG732ULwGD2/VGD/MecfHNxTDkAed0J5B27mi/rVwWqrKLbp6Pj/jZV5P0xyGFGDjrPug1t3is3CWN3ooW1hBFcxZBUz5QtGVc/LH3M772ksSY003ayj5buC2PXMy0vxQq+qILav3qQAOpYWG8+Jo8O7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqGzeFomWOcxRaSHvTI1wCLafk+C1V0XT+Mzv3un0Dk=;
 b=JysJRZBrLhxnIhbJNIJP/3y3NEXiyw9xElFvN5doLfzoLZcnk6yi0nscQFNqsVIHEaPshLD+nbp4t1P4ntV/K6Kwlfz52HPx7LSkL7MBwMDrSQbDlIc3bHLpG17RO79BlhCJIMVSVxcnpBjW7uc43TNjgTYI8WoGGPHYB09KnLRsLryVWtMd9loAdIQTHjzi5zLK+j+/6PSYgM8zQU/ZppXEah6MXVkk72zOAbv+gdQ0nR6CZlkKO++j/ydqbgTvls+hDV3xMO3NuDmGVC+Jh5vCilRkVK2YCeWQejnonMjQFTxZCO4kmgmc1VraqoGnwc/UE/992q0t0u7K4c+6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqGzeFomWOcxRaSHvTI1wCLafk+C1V0XT+Mzv3un0Dk=;
 b=l1fvkVB01mtu3dtpePZQvJ5gStqAnXJdcmgNPnXSP4RmWMTynL+enm2ZTxWPmq7hDaZW9aYaccQiXqxXldj5Dg7h6X6t59CV8F0yCA/I0ElBLz9MMt0lrHrErOd3CMf/PzY6v7FREKxayH1lScEUZa0gtAndzzC5RwLcBMO1E8E=
Received: from DM5PR1201MB0139.namprd12.prod.outlook.com (2603:10b6:4:4e::8)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sat, 29 Jan
 2022 05:09:42 +0000
Received: from DM5PR1201MB0139.namprd12.prod.outlook.com
 ([fe80::6985:aff5:ed97:178a]) by DM5PR1201MB0139.namprd12.prod.outlook.com
 ([fe80::6985:aff5:ed97:178a%8]) with mapi id 15.20.4930.019; Sat, 29 Jan 2022
 05:09:42 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Thread-Topic: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Thread-Index: AQHYFMPQQFKE3NomE0OW712BGX+esKx5cr6Q
Date: Sat, 29 Jan 2022 05:09:41 +0000
Message-ID: <DM5PR1201MB0139753E505B9E662D088EE8FB239@DM5PR1201MB0139.namprd12.prod.outlook.com>
References: <20220129035311.3734878-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220129035311.3734878-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-29T05:09:39Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=778c61d8-3568-4716-ab98-2eb0442784ba;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-29T05:09:39Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d81b7f47-29df-4608-b420-5f89e2bdfa91
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7673612-c1ad-4985-882f-08d9e2e58ec8
x-ms-traffictypediagnostic: DM6PR12MB4091:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4091F636C054DD51CF6463C3FB239@DM6PR12MB4091.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bnqIFd0Dz//aJNeC2EdY1bRId75oR94Jvzyeuh3ETjEJzxd6QcHtS3jdaTI474u07SlDGL/lHTY+hFkAbpFr14KerqZ/CjIcs4wR5M3fCpT3ME/5PPuHXbOTfjeGt/5yBsrL7YRqHgBOyQltXwmEXPSTYd4/vEQ59+cVVN9LxhhR2sbyBC1M0X/VYRKeBlv+NglMYJp7UVyOJLhYhzkcxXI/R6W6o0WvfvyAbkqyjAV+GZbBl4XeqBHahbVpR2kvr6ds3AgWf5BLbJ8t6aQ2ldZssQOV4aNQsACZTkmiZPuP5GqGR8HgIzUWLuL7nUCGOIQ5+BJBBGvcF64CLy1waAmRVbp9ct5RmflysUgp/GJVEmdN3Qi/G7nMN43+hjIpvF25w6JKJbxeb6F2ukrqC4EXGhz3BdZ3nq6tZKNBkZe0ReJtKTA8nGnXbUN1QeqRjwgdKpxDZgpYsXTb1An/8YRzXi7slLd+YI8Q8VZ+fYrRgXqEDP9p9/Ho/7ewdpkElAe2TtuOTDtS6z9Q8jPBntaLG83gu9J14vEK7CsvAcuJ89EdyT3a+UCtrbN+GAe6wcNE/vdb+1nOdL8m5OlQpFSKo7XyqHc9hCrEm79POi1j+CoGPBRbsBe2A6T6tDD0M9Gzi7qLsplhB6ypoxS1V0B7mPpSjKl5w95cihE5f3n5pbrRUiXjrvpwFeq1mhvox4suVpH3fNs6L69n4IxGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(316002)(5660300002)(52536014)(9686003)(33656002)(508600001)(186003)(71200400001)(110136005)(26005)(54906003)(86362001)(8936002)(2906002)(122000001)(7696005)(4326008)(53546011)(38100700002)(8676002)(55016003)(66476007)(66446008)(64756008)(6506007)(76116006)(66556008)(66946007)(83380400001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GYvN9x/Y6NLqz+OUs5j9KwNM1XfnowpV+j+kcaaXYME5J4t/SUGrltMJ/9SE?=
 =?us-ascii?Q?AazKoyk85MDC4QoIeCkkyW5p87laiY4Cttu2vZg6m0ZW+8g6EcTX23DmrJHA?=
 =?us-ascii?Q?DoVajGs02ks0iJovxCZFqKpNvIx6fvqgsGo3Ph+WGMQjsthLfcXmphMRIKYl?=
 =?us-ascii?Q?CXxiPU4ZmzqAFjKiCb9lqavW98LXsiasOrJuUy0n2RIpU+0BevrVPTVGr5Vk?=
 =?us-ascii?Q?52qioBy0DjspMqxo26QJtvoYhzNYpFO2N3a0WKz0dsV0DC5eZGP6AX6eSCor?=
 =?us-ascii?Q?nygfCbTbU1xvcFx2jgLGh55s/530RkJwjkeyhTCmEz75Vu05UDJSyXiqvgT3?=
 =?us-ascii?Q?DFFnriE5EA6FhKNYscEkSmHFZHjDSTUfJkggewuSGgCkvt2+vtA8mwyBVKsO?=
 =?us-ascii?Q?9DNozL3mwK9GmOfg3WJNhjLgbHgOSJMpXr3DiW7c7KGOKvO6OChs15+WcXCv?=
 =?us-ascii?Q?GWSGtAuingYFnWO/L7Whf4HwnU7M7Fpi5KRfMvWUiVDWMu7r8XshGRI306mj?=
 =?us-ascii?Q?fjTMr9y8yTnhm8s8Q31GqaJscC72GXG5su9klhRsW+/kT86+VZS8/5+0BqTN?=
 =?us-ascii?Q?xRS4zxHy8Wa5hxBqOPl16tSAWNSq6gVxJ2rwWEjgRVIim7kTSA0dOJwrtAdc?=
 =?us-ascii?Q?BgVE6MmG92KYXKOFk+qWrPwgBVhZxWSsynRsm3qWc529NIwdvj9nbVytC4PC?=
 =?us-ascii?Q?PYfMGlGlTncrsKeCg3lGTGnpA8ruyiJzj/XR7unjTPWVPwn3LDA88lKwUCLa?=
 =?us-ascii?Q?zNbSJBQzqHMdNIvzSCnWLo3x2oHeGaZQe6VBcl3T6F0UkfxlJV9yhYsuBBuG?=
 =?us-ascii?Q?lLqzikOjhLtXCLe4LOPHLYCNSDoFfjC2wVRKOinLJQaujpq47aosaLhbypX7?=
 =?us-ascii?Q?Jq9dpeSXat0lMwKNGUGVKWZ3/10lPCEN3In2F/lkFnqv8zN5S3Oy2DIsG1PN?=
 =?us-ascii?Q?HsIMENj7s0kFflEMT3cmbzS81JRjo3OAu9wGpQc4T61ft5TUYDmtmMIOSRLW?=
 =?us-ascii?Q?mhmvNEaeJ4UyiJUzumXYzulr4KK1NwaMQ3md1afhlgzDaY41Xb/hsI+o/KHM?=
 =?us-ascii?Q?hpBSPMW+yOs+ITZqUoCrHogk6v4Wothy748rTH+gjaj9+63DCoiTPH13ikd2?=
 =?us-ascii?Q?ZGRmpgcSDU8aC3qZfD07Ldo5r4r1RKzoMrhcheFY3D/txFrwhw93F2Jpx1Sv?=
 =?us-ascii?Q?+P2LYqrtbMpTy50/It11LHZGW1yh8M+M3H8nlb5J5VxDmoLcTREqNQiU2jGs?=
 =?us-ascii?Q?oOr5fZHyp8f7goGWXBvyHPVENh/BjFzCHbTVz5miBuaD2FWgx2TL77Wfzk1N?=
 =?us-ascii?Q?lr0WPGPTvGrxQIJ+IkkLp2dbzxyeqJqh6ZK2efWIzqkjGUH4RPDtqBEPtYTi?=
 =?us-ascii?Q?NYkyN/d/qfVNAVMqO17jCrmT6C3354E0JokumYeX7omrwJsNSAWYGM0+qAK7?=
 =?us-ascii?Q?t2TF7WJcDQJuQy7ffIZ4dYNKNaxDuzoi+/B77KHmkrOagIO8oE0/0izCHpNG?=
 =?us-ascii?Q?pmSZivv6xrfGXsT84ELbbH2SO7GBo+dsXn9UAIG1LJD+JXSCOaTeZ5Zx4YYK?=
 =?us-ascii?Q?bKdOfdqc6qBonSls/8Es3HeQYzP1yn1kVOoPqtQ2dIpjrfZq0b3zkGG3XsGp?=
 =?us-ascii?Q?L1a+QxjEoalX8v1boezg7yI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7673612-c1ad-4985-882f-08d9e2e58ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 05:09:41.5687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/qjW/NscgtKxNJ25sfWyGsspsgzUVcxHAMe8ktukmfNajnijDcAcfSuJ9Q3i0A+BCL9OWiGCEWSaU1BWTDWzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Saturday, January 29, 2022 11:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop

1. The infinite loop causing soft lock occurs on multiple amdgpu cards
   supporting ras feature.
2. This a workaround patch. It is valid for multiple amdgpu cards of the
   same type.
3. The root cause is that each GPU card device has a separate .ras_list
   link header, but the instance and linked list node of each ras block
   are unique. When each device is initialized, each ras instance will
   repeatedly add link node to the device every time. In this way, only
   the .ras_list of the last initialized device is completely correct.
   the .ras_list->prev and .ras_list->next of the device initialzied
   before can still point to the correct ras instance, but the prev
   pointer and next pointer of the pointed ras instance both point to
   the last initialized device's .ras_ list instead of the beginning
   .ras_ list. When using list_for_each_entry_safe searches for
   non-existent Ras nodes on devices other than the last device, the
   last ras instance next pointer cannot always be equal to the
   beginning .ras_list, so that the loop cannot be terminated, the
   program enters a infinite loop.
 BTW: Since the data and initialization process of each card are the same,
      the link list between ras instances will not be destroyed every time
      the device is initialized.
 4. The soft locked logs are as follows:
[  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           OE =
    5.13.0-27-generic #29~20.04.1-Ubuntu
[  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU, BIOS =
T20200717143848 07/17/2020 [  262.165698] Workqueue: events amdgpu_ras_do_r=
ecovery [amdgpu] [  262.165980] RIP: 0010:amdgpu_ras_get_ras_block+0x86/0xd=
0 [amdgpu] [  262.166239] Code: 68 d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 3=
8 48 85 c0 74 32 44 89 fa 44 89 e6 4c 89 ef e8 82 e4 9b dc 85 c0 74 3c 49 8=
b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8 28 48 39 d3 74 25 49 89 c6 49 8b 45=
 [  262.166243] RSP: 0018:ffffac908fa87d80 EFLAGS: 00000202 [  262.166247] =
RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e20 RCX: ffffffffc1394248 [  262.16=
6249] RDX: ffff91e4aa356e20 RSI: 000000000000000e RDI: ffff91e4ab8c0000 [  =
262.166252] RBP: ffffac908fa87da8 R08: 0000000000000007 R09: 00000000000000=
01 [  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12: 00000000=
0000000e [  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc1394320 R15: 00=
00000000000003 [  262.166258] FS:  0000000000000000(0000) GS:ffff92238fb400=
00(0000) knlGS:0000000000000000 [  262.166261] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033 [  262.166264] CR2: 00000001004865d0 CR3: 000000406d7=
96000 CR4: 0000000000350ee0 [  262.166267] Call Trace:
[  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu] [  262.166529] =
 ? psi_task_switch+0xd2/0x250 [  262.166537]  ? __switch_to+0x11d/0x460 [  =
262.166542]  ? __switch_to_asm+0x36/0x70 [  262.166549]  process_one_work+0=
x220/0x3c0 [  262.166556]  worker_thread+0x4d/0x3f0 [  262.166560]  ? proce=
ss_one_work+0x3c0/0x3c0 [  262.166563]  kthread+0x12b/0x150 [  262.166568] =
 ? set_kthread_struct+0x40/0x40 [  262.166571]  ret_from_fork+0x22/0x30

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d4e07d0acb66..3d533ef0783d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -884,6 +884,7 @@ static int amdgpu_ras_block_match_default(struct amdgpu=
_ras_block_object *block_  static struct amdgpu_ras_block_object *amdgpu_ra=
s_get_ras_block(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block, uint32_t sub_block_index)  {
+	int loop_cnt =3D 0;
 	struct amdgpu_ras_block_object *obj, *tmp;
=20
 	if (block >=3D AMDGPU_RAS_BLOCK__LAST)
@@ -900,6 +901,9 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_r=
as_block(struct amdgpu_de
 			if (amdgpu_ras_block_match_default(obj, block) =3D=3D 0)
 				return obj;
 		}
+
+		if (++loop_cnt >=3D AMDGPU_RAS_BLOCK__LAST)
+			break;
 	}
=20
 	return NULL;
--
2.25.1
