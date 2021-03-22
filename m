Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79703C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160426187E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160426187E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A837E89FC5;
	Mon, 22 Mar 2021 05:57:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D62889FC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 05:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCZPjcG4zTZDctfr1uRw71LT/vsY7hOt2IE5mloQbZdVtWmaPbf6JNK0N+42WlzcgupIpuHHSPYg3poBGsnClEv1qTKGkHlg79d0o8Iy6AG128lV9JDjGyQ4MZqpMdBkme+znOq+819sfvrSNLVkzcx9DZb48j4QPzXlF0FWtjHTL/VLUilXV+g+A8cfItyL2CVkKiK3PgXx/1fReCSyevP0dtTVRdlx8ZLdfLzkpFlkW5na9Y9Mv87PWOpdZ2WqGCYApMCqx+s54Ok0VKk+/WXvIRLViIH70pDZ+dS7ki1zIjGTt2m5rROdg5XR665n89AFeorlhqPkEiUMhH9CaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GPmeHPkXSAoxi2tqn1EUDvbJuLfv83BNDPX3/qyx34=;
 b=Pz5N0ImexC/fQ5EvDkXRrnwHLAFTHm7EuL+0g+avdoSSvUBNSxDSRD+h+SEnWMv5NyWN4rAk/n9b+sTskMIE5Xm3mLnaRDMlB5yW1ZPZokfYCPL+qbJOF7gziFcyRcxk/1PuEmS8wO3oEzKNWmvS+K2LDq7ZDpVj/Jo+3HrkiP3vyEPNBl23IWtvtZ1CU67937unqQ3wgSww/wHGF6kgoTUQz144fezEI2DI3e5JKAP96ciWOPuPIywKcYgJre7thN6hrd4UHproqWf6B/EvlJ7BhqZP94Ljz8cOmdaY5Mtpz2HKlNtnDqKs+dtZWx1pfiv6b7YjP/i6X45MAuFDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GPmeHPkXSAoxi2tqn1EUDvbJuLfv83BNDPX3/qyx34=;
 b=NVwImm/snfaDIKFDVAIBEunOrAr5/x+j5LLVq7bTV3TeNtPramJgPHfUqyblnul7j8+ErDVKamXAbWd4xwM4q5uxmzG6v/FhGQZr/ANa0blXLnVKIcKqd1STjinEVlvjhSFLpiMdNoYia6nkUpF7kVqRZY2Uu1XBSM1/6n4rPLE=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 05:57:04 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:57:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/8] Add mode2 reset support for aldebaran
Thread-Topic: [PATCH v2 0/8] Add mode2 reset support for aldebaran
Thread-Index: Adce31/4KuLMVGQgR/K1fu1T4rIRdg==
Date: Mon, 22 Mar 2021 05:57:04 +0000
Message-ID: <MN2PR12MB45490FA91C151ACEAA0D88C797659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T05:57:02Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e349814e-87ec-4ade-9d22-3e96bab52ea7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e19a8b9b-2788-400a-cb28-08d8ecf75197
x-ms-traffictypediagnostic: MN2PR12MB4302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43026FB804AD79C616B36B0597659@MN2PR12MB4302.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eM53FxJs6xUG24g1MgO7aUVn9SqtUaQSuYqukT6vOepBr92zNnnUEDjACNr/LozKJ1h/B6lt43zUvH1VdG7VMVPWJxq+pLxVh3m6ydRDKj5HqGaF3iOPMU5yIVe5+KGKTC6rAQXgHhg/U1bNk0F4tDKvKR/55wAq8G9kgdP297V4Kcrpo3j1BELDvDWRgFvXW9OiW75remxj2D+abhq5daX1mbZEvtD7+0qPRtvnQvLLls3vHoAvo46xel8ZgKjK6LSG3L5+BXsBOu1zsS593AUYGPcsXCRpTz7k4nMcvBcS5loZdDObvjQ8t0Sv+m5SJ1VmaqwUHicygPsYQ6A20VEaHl9mFMTgYkpgXz81WR40u0MXsdBqZFPWLATjPd3Dprbdet2ewHUgOm3f+2AO7RosbpHUNLwzqNsEbV1QBKFLkHj0TeZI/zYY3nyk7Cde+wmvcqUm2fW7WC1d59I2tfODdY083hIk7vlcyqfdE39Th81yf5mafmN7kqee2ReK5zWe5xZpzSmqme0VVhZiyCI4J+2jYefnk9WkpbRaR65uMDsc9GWUG27oajoE8B2j6bODMaugib0+H3KBFh8H1y9MQ7JLL4lk50/Q0SDBksGZpIls3v7nNktCiLQIeNY2vUOHjMFsFJkazu9uvBl1QD+I9u9MNE9Qp7Uzcr8pjbQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(64756008)(66476007)(55236004)(33656002)(66946007)(38100700001)(6506007)(8936002)(5660300002)(4326008)(54906003)(186003)(76116006)(83380400001)(7696005)(66446008)(66556008)(8676002)(71200400001)(2906002)(52536014)(55016002)(26005)(478600001)(316002)(6916009)(86362001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GegttNdWA/W3Vaaf7mVBtq9IFom7imTgWWZaZ3eAUaVM4w6JgllUGGu8fYSj?=
 =?us-ascii?Q?cI2qp6rd15h5/txeGqLGdJGO6szd+dIyi1amEMGUpWGcx4SxQvUW69oUNNin?=
 =?us-ascii?Q?n+34U979puZmoyEXeda9eAgsr/0PNR2XBRRWPZOPyDoW8kahdvnPLhK3UY5P?=
 =?us-ascii?Q?RMwz2XUQRDOdUgoxJeBCOB406C2W1HEMkxyQtTbsZFxbb1IC9GCoht5QF4vK?=
 =?us-ascii?Q?6nTJ/bR+Xy9lkeq5WvEv5aQ6fApO+FKvnh/PB5XpXccrrZx2OZ5VuPsGM33J?=
 =?us-ascii?Q?lG1e0FzOqyXL50U2pHaY0nb3ZQkzahCOf4wgMW+ebUPETFEyDPUkcUbIs35t?=
 =?us-ascii?Q?OGpKJl13toAjDlHdxMUrKTd6Byw80zlPpusZPRYMbU4XWvkoEDPPrfINmpuG?=
 =?us-ascii?Q?LSLpy0o0aAWYawsi3pgVcPFZBlgHoI1h38xA9mak9JRw6muyK3AdNtSUKpeD?=
 =?us-ascii?Q?Xu1iUeFB37DmUXndHs8nF5fYSHwCoHV1kpB+M/qwltNH3kery8ABskfv7zo5?=
 =?us-ascii?Q?4KB53DkvE4B5A8JCrMGaCrvGafUCNDQCEwNzhpwhM4sV+DfxPFcpHP/GZhwc?=
 =?us-ascii?Q?u6GYCLSurIfexHaYsVWLyaNoHrdS55zrEmq+CkWslrN5DkGZGJGmaQxHwGCl?=
 =?us-ascii?Q?fe1ssaVhyhENus5OCVttJbtjYWPlDBifxOIxAiFDYV+EibcvHpnbM9lZBCh0?=
 =?us-ascii?Q?voogx/XCid3n2jwz6920nhP4n7glB27VG7Ekjpg44Xx/eo6K8pp3lTBvQf4u?=
 =?us-ascii?Q?v3KvySzdmVT6nKzChbSGtezYdZPj4dxpvyC0MtPREiZ23/vQhxgdUEc6//MY?=
 =?us-ascii?Q?P/cHQASRGnEI128mEHY6tjCmTVI7XysibMHeW7m6oN6KqW80fbLlDm958pnv?=
 =?us-ascii?Q?F0TzrK3oZ1FkJAYJbzp9YuTT0aaxI7Ad2XE0jS6oiVj/NvFhIGx6sMSDPTbJ?=
 =?us-ascii?Q?BS8UUaF3LQed6Cj733HHrMRDrQZcrN11xXfJFEqw0mq7slDeJhGoOIOXgZI4?=
 =?us-ascii?Q?QeptRmyNWyvwQ3B7gzCwfXdxF/qt9qSb0nJrqLgs4DpCgurUAn595tS2G8sv?=
 =?us-ascii?Q?SdAeuRF7MPk3/fZs9U0uFBBmHvyYqe5iUMIPC/ua/Jiy60ZoHkGVRdAWmwy7?=
 =?us-ascii?Q?UmjAH/P5ljRZ6H+g40d8FQt8n70LzQThLp7nYy0r7MJOVHi5q2ErZ0i4Z3Yu?=
 =?us-ascii?Q?wyTSM7MG4oRKhEkVIWDKs4ID/sHmxQt54x3IyEP992dx6yiHpT5pUVYgiRpu?=
 =?us-ascii?Q?AcelaMuX6L5AZVjH7jKtbg043yyzmDrYObobeCGlSoOl7XTf7quoxAMTQPHx?=
 =?us-ascii?Q?RA1AMPixDHIOaLuV0kJcau9r?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19a8b9b-2788-400a-cb28-08d8ecf75197
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:57:04.1003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rhyr1k2MgvHyCtQJafxO34OQHx3KCyuOtKbpxR/0iETvvpCE8EkN15PMbgOdCcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0535021177=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0535021177==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45490FA91C151ACEAA0D88C797659MN2PR12MB4549namp_"

--_000_MN2PR12MB45490FA91C151ACEAA0D88C797659MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

This patch series adds support for mode2 reset for aldebaran. Since the
reset sequence is completely different from existing ones, it adds
supports using a new reset control method. The reset control and
handlers can be installed and handle specific types of resets.

v1:
1. Changes to the mode2 sequence as PCI space gets lost during the
sequence.
2. Add support to wait for specific events from PMFW. Reset complete is
considered as one such event.
3. Add support to wait for reset completion on aldebaran
4. Add a new reset control and reset handler method. Reset control can
be installed at device, hive or ip level. For now, it's done only at
device level
5. Add reset control mechanism to the current recover sequence.
6. Expose PSP function to load a list of firmwares
7. Expose CG/PG set functions for use outside of device
8. Add mode2 reset and restore sequences for aldebaran.

v2:
- Coding style fixes
- Mutex protection for new smu api (#2)
- Clear bus mastering before reset (#8)

Lijo Lazar (8):
  drm/amd/pm: Modify mode2 msg sequence on aldebaran
  drm/amd/pm: Add function to wait for smu events
  drm/amd/pm: Add support for reset completion on aldebaran
  drm/amdgpu: Add reset control to amdgpu_device
  drm/amdgpu: Add reset control handling to reset workflow
  drm/amdgpu: Add PSP public function to load a list of FWs
  drm/amdgpu: Make set PG/CG state functions public
  drm/amdgpu: Add mode2 reset support for aldebaran

drivers/gpu/drm/amd/amdgpu/Makefile           |   7 +-
drivers/gpu/drm/amd/amdgpu/aldebaran.c        | 380 ++++++++++++++++++
drivers/gpu/drm/amd/amdgpu/aldebaran.h        |  34 ++
drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  20 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  96 +++--
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +-
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  17 +
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   4 +
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  98 +++++
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c.ald |  98 +++++
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  87 ++++
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   8 +-
drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h  |   3 +-
drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  16 +-
drivers/gpu/drm/amd/pm/inc/smu_types.h        |   1 +
drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |   5 +
drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  14 +
.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  57 ++-
.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  42 +-
drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   2 +-
drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +
21 files changed, 956 insertions(+), 52 deletions(-)
create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran.c
create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran.h
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c.ald
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h

--
2.17.1


--_000_MN2PR12MB45490FA91C151ACEAA0D88C797659MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">This patch series adds support for mode2 reset for a=
ldebaran. Since the<o:p></o:p></p>
<p class=3D"MsoNormal">reset sequence is completely different from existing=
 ones, it adds<o:p></o:p></p>
<p class=3D"MsoNormal">supports using a new reset control method. The reset=
 control and<o:p></o:p></p>
<p class=3D"MsoNormal">handlers can be installed and handle specific types =
of resets.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v1:<o:p></o:p></p>
<p class=3D"MsoNormal">1. Changes to the mode2 sequence as PCI space gets l=
ost during the<o:p></o:p></p>
<p class=3D"MsoNormal">sequence.<o:p></o:p></p>
<p class=3D"MsoNormal">2. Add support to wait for specific events from PMFW=
. Reset complete is<o:p></o:p></p>
<p class=3D"MsoNormal">considered as one such event.<o:p></o:p></p>
<p class=3D"MsoNormal">3. Add support to wait for reset completion on aldeb=
aran<o:p></o:p></p>
<p class=3D"MsoNormal">4. Add a new reset control and reset handler method.=
 Reset control can<o:p></o:p></p>
<p class=3D"MsoNormal">be installed at device, hive or ip level. For now, i=
t's done only at<o:p></o:p></p>
<p class=3D"MsoNormal">device level<o:p></o:p></p>
<p class=3D"MsoNormal">5. Add reset control mechanism to the current recove=
r sequence.<o:p></o:p></p>
<p class=3D"MsoNormal">6. Expose PSP function to load a list of firmwares<o=
:p></o:p></p>
<p class=3D"MsoNormal">7. Expose CG/PG set functions for use outside of dev=
ice<o:p></o:p></p>
<p class=3D"MsoNormal">8. Add mode2 reset and restore sequences for aldebar=
an.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v2:<o:p></o:p></p>
<p class=3D"MsoNormal">- Coding style fixes<o:p></o:p></p>
<p class=3D"MsoNormal">- Mutex protection for new smu api (#2)<o:p></o:p></=
p>
<p class=3D"MsoNormal">- Clear bus mastering before reset (#8)<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Lijo Lazar (8):<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amd/pm: Modify mode2 msg sequence on alde=
baran<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amd/pm: Add function to wait for smu even=
ts<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amd/pm: Add support for reset completion =
on aldebaran<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Add reset control to amdgpu_devic=
e<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Add reset control handling to res=
et workflow<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Add PSP public function to load a=
 list of FWs<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Make set PG/CG state functions pu=
blic<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; drm/amdgpu: Add mode2 reset support for aldeb=
aran<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 +-<o:p></o:p></=
p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 380 ++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 34 ++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbs=
p;&nbsp; |&nbsp; 96 +++--<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 98 +++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c.ald |&nbsp=
; 98 +++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 87 ++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h&nbsp; |=
&nbsp;&nbsp; 3 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 16 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/smu_types.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/smu_v13_0.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 14 +<o:p></o:p></p>
<p class=3D"MsoNormal">.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbs=
p;&nbsp; |&nbsp; 57 ++-<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbs=
p;&nbsp; |&nbsp; 42 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<o:p></o:p></p>
<p class=3D"MsoNormal">21 files changed, 956 insertions(+), 52 deletions(-)=
<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/aldeba=
ran.c<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/aldeba=
ran.h<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_reset.c<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_reset.c.ald<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_reset.h<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45490FA91C151ACEAA0D88C797659MN2PR12MB4549namp_--

--===============0535021177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0535021177==--
