Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03FFC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 17:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8EB611AB
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 17:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8EB611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF366EAA5;
	Thu, 15 Apr 2021 17:37:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421826EAA5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 17:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1ATqe/e20y2B3UoWaaT5pAMEWCEuNPVPr6RpNuv5KDX1xROraqjM20RJfQ0F2ONoRJNDV7rQIiSlJ5HgkYkKfQ97rS9PTSWWKshTxpeZTyAMTEWBHgSeqvusq1NOFlRrvhR43nrpHUD+g66g4lJAOStq7bGCxmIhMHjS6lOKT2fx5uZwMB1IC4oh4pwEKntnT2QmqVwkq0bcT4SrzjzmBALIrJufEDZRB66dYWdtYsBDucIslxW8tY4PU/L8x6liAAD6FlGNy6fDAqNmwQrkbf1cx4PxWocsn+lER7hIc54m/vcHiSpfS44jOTFGItsY//RaTXWl3ggm8vD+pW6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plmb7Wn6ToOu3uqRaX3Wzm+G3To2P0huYrkJDlo8w/I=;
 b=KrZ4titlKF18/FXOBztSY1CJphMUckmcL+fxHsh3sV9BX5nus1z9gIKPvu+CqFYq0NbKdxUxnbDAUOA+nb8aHGNqi2898fV8QR9GU41ONveGIdqxl6tLpZNSZmuRtW7wA4NC8dPd1DpWJJrg6BOQIfmIc20x+90PwusjRUupJSe5RfnaQ/bSEvEIU8iBD2jcIM+BZaiVsq+7Z4noLgLN30QA4qFfjijwuNxK/sNenDbIQ50A+KI4NT9wzFJ2G+3V5JFZb4faf2LvC9cZlZOrg0ZDNqX/FYMUOJ7LOwDRFY147IQgRZmpphAgOcMxv57FeZi1SU+Svhi1Ufl28c5odg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plmb7Wn6ToOu3uqRaX3Wzm+G3To2P0huYrkJDlo8w/I=;
 b=BdSHviTWRqkYOwm9XC95DauMXwxKqU1ezAlnTinO58s3JseU6+e5AAwCaXeAoHGql0Hh8iIsB6G/pnPcsLc/LcTYHRParjGL9x1m9LEdoH7lVJYL0cePBviHzCmJ1h6b7TOw+vOOq1w50OplXxrFhRhdL/eC/GveVFZOeO+2iXA=
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Thu, 15 Apr
 2021 17:37:54 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.037; Thu, 15 Apr 2021
 17:37:54 +0000
From: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: RE: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3
Thread-Topic: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3
Thread-Index: AQHXMYbjbkqVYgyfhku0Lm6ukFhsnaq1cQ2AgABMlqCAAAexAIAAEwpg
Date: Thu, 15 Apr 2021 17:37:54 +0000
Message-ID: <DM6PR12MB2939D0D3422741E64383306EFB4D9@DM6PR12MB2939.namprd12.prod.outlook.com>
References: <20210414233533.24012-1-qingqing.zhuo@amd.com>
 <CAP+8YyHU8GtCzFk71h1qjQWKYQpMwrA=s88dw2Fu3_0LXSMEWA@mail.gmail.com>
 <DM6PR12MB2939FC23A4404409980F7D1AFB4D9@DM6PR12MB2939.namprd12.prod.outlook.com>
 <CAP+8YyGkpq=Ofq67_LVrTb5+9f6oJO6HuvBNcXzyji2Zu1Wqig@mail.gmail.com>
In-Reply-To: <CAP+8YyGkpq=Ofq67_LVrTb5+9f6oJO6HuvBNcXzyji2Zu1Wqig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-15T17:37:52Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f0ae58ae-b413-432b-b1d8-a552602ae6fe;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: basnieuwenhuizen.nl; dkim=none (message not signed)
 header.d=none;basnieuwenhuizen.nl; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07282a49-b4f2-4107-b883-08d900353362
x-ms-traffictypediagnostic: DM5PR12MB1884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1884D1972A63D5EA76E608A7FB4D9@DM5PR12MB1884.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOc+hIAl+JldJm2kxLbieYHgk9YNwL0Iag35tTbbHTB9WJlFNmund/0ak6rrfGgvh0TeClYZP9aNj9Vz/nFkogWP/wPZpBAkVskelnBpukwCHdzpuDpvpoUN9M9RgyAn6KQ1gLXji+yDEHEzFOkGx6/WDeZBslzTkE1oAIQVvi2O7Na7mU1Q8dnmwO8tz/BI/LDHLbiFWN72USLKL7Mzxh9nlTwBlNv/y09DuT6pDl9avJZDC0eWRqfQifg/4TgJsDSMnRsQadf8TkgdSx69vbrhTyV8HQ9ph85BaEFy4VEBgYGgH7b82m10VTFIHj7AZ9tpzwhJs5suvL59/eoRNjB3CDv8dupZosSi1Y15ztsp7IQ8tXlJCIsERZAWnBw3ZYuT519hxyWziW5Q/JdvWS/gudQxfkhD6Bs2kYcx2nMXl1IwinHoFNvLTZ8XJoG/KgxdQWFifAkBOjvs+kZd/VsaJrwcFOSGEWJ3gPFQD7sb3IRo26RJYqFxRAR0DSQJZtrSpWeBcLuYJJ2cSnbHvCeaLWUc89agxr2JD9lwRyk3Eh4r/kt3R5UfmF+OkBzbO5RZqc9/CgTz/KJ5ZB81blbCZW1bVgBYtfInHrVAah4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(66556008)(64756008)(66446008)(8676002)(66476007)(478600001)(15650500001)(55016002)(53546011)(52536014)(26005)(6506007)(6916009)(186003)(316002)(38100700002)(7696005)(66946007)(2906002)(83380400001)(8936002)(9686003)(54906003)(122000001)(33656002)(76116006)(71200400001)(4326008)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?we7IYOK0GYwbBruINtIDSm61mbC2Pa+tQqKkEWJ7hKEbi1rXmsfHVAXrqMQ2?=
 =?us-ascii?Q?CuGNG1ELqxKWflnrfRiHa6gO5v9hPHigqZrz27AHThz/HDXXLaxUx0BHcY+v?=
 =?us-ascii?Q?FGl9Mi4WR1hUSkeDG5TIWyA2CHh5JbcccdMEXyNs05qU8tbCFZwG55ougMu7?=
 =?us-ascii?Q?XDOInbGJ95TUEV9H5gNi9nIrs2rdZOEoGiyKsZ1vL6WUxaLWihp4ciTqaXiu?=
 =?us-ascii?Q?hvpaxUerPK/LEmXPyFpYD11xdh5l1TACIi28f+AVFJyA4vYhoJGmU+u4nOYg?=
 =?us-ascii?Q?OI66+gesAGfVOn1EhmqNX8ZzwofOzssneZGLcfxbiSXzOIJcuH2LveHCN0fW?=
 =?us-ascii?Q?nXmGz/EYW1IriG+SNfu4DYn6mZyomHh65Fltn84l34PvTpDQqHYaMeg9J3Sy?=
 =?us-ascii?Q?m22ceLOpDHGgXo1Vo+W1HL1pfgyvLvGTWtsUGgWmIAuuYBardLLb53X/S0Qk?=
 =?us-ascii?Q?Uejy/Iq162dgwuyBc6wldI6I1A5BSJ6nQ34sVfNLDA2gKR7VB0hZm5St6B3g?=
 =?us-ascii?Q?XevbyVFWyIv1BAmRxbNAjY6/M7CDHWdbE0n1ivKx5AoT1bjFhSKqZ1IbB8NC?=
 =?us-ascii?Q?vroK1gtjw2nGEBlrkvsKRHBFUQY453gMf2hPa2k7uAvljaCqmMblDVoZlekx?=
 =?us-ascii?Q?u91BE5HXLJgrB1H/LMw4CBDx6BH9+wFWtTDtkwbQDiblVp/2UmcghdKK+74M?=
 =?us-ascii?Q?wvF9TB3e0cgitTri12UfK2iVMUV37R3eDzYxiLKRrdJotFG9zdCqjsoYiFC8?=
 =?us-ascii?Q?jdSyBBVgekwOF2APb0Ikn9mN1UUew1sB1MH1vwxPWpyV4SSAbpZhLuybqhD8?=
 =?us-ascii?Q?08hpR9pvvx3vDmSJPTzDhjoh2agEnbsaHdHSVxT9i75i+oCgsMf5NmjCkjfA?=
 =?us-ascii?Q?z8dsKb1Quv6yHht/U8Btv0a7MWDU2CFP1oZiXk9ke+qBwUqUfeMHJ2QEPYxr?=
 =?us-ascii?Q?rY27dTqr4OvlNCAJQ4b01R9XwtSGRcNIiCGSosLjlFJ+X9zlOgIy6+6mxlXz?=
 =?us-ascii?Q?7iYw5Q6Mvttbn8taHwzKxv25Ig93fsX5uihTIOJiSy1db1WsEQz2X064Pk1R?=
 =?us-ascii?Q?q2i0iNAlPxwr+PqGt+tFSeHE4D4/sB2z1mDvrV2dy2pGBmFJC5Ro4/P3VpuB?=
 =?us-ascii?Q?eq/X4Wk+BPWXk5ZgYy7+8VkhOKQiT6nj6jn4CYOyTxo9s03yoCrrjvhcL4zI?=
 =?us-ascii?Q?cNtxGqmyx2sIzBRFNNsYsjJq4SMMRlIOgMyC5x2tDmZxiAwe+ELoAc7Ir1Cs?=
 =?us-ascii?Q?Tm3JT0b/NrnAiPZnhILdwykcGzfGZwh5Gh4GT1uYlJxCo7dy7/5TBvDRKweQ?=
 =?us-ascii?Q?Mds=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07282a49-b4f2-4107-b883-08d900353362
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 17:37:54.3131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhbizDfGkr1FywZAtHmSaFvbozZLbsf9w1XlCWTp4DdbUBQHXuueqhcEsFSzY102
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
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
Cc: Mark Yacoub <markyacoub@chromium.org>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============1186168812=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1186168812==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2939D0D3422741E64383306EFB4D9DM6PR12MB2939namp_"

--_000_DM6PR12MB2939D0D3422741E64383306EFB4D9DM6PR12MB2939namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Updated and sent. Your review would be appreciated!

Thanks,
Lillian

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Sent: Thursday, April 15, 2021 12:27 PM
To: Zhuo, Qingqing <Qingqing.Zhuo@amd.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>; Mark Yacoub <mark=
yacoub@chromium.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wheel=
er, Daniel <Daniel.Wheeler@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@am=
d.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3

Btw please add a fixes tag so it gets directed to stable releases.

Thanks!

On Thu, Apr 15, 2021, 6:06 PM Zhuo, Qingqing <Qingqing.Zhuo@amd.com<mailto:=
Qingqing.Zhuo@amd.com>> wrote:

[AMD Public Use]

Inline.

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl<mailto:bas@basnieuwenhuize=
n.nl>>
Sent: Thursday, April 15, 2021 7:26 AM
To: Zhuo, Qingqing <Qingqing.Zhuo@amd.com<mailto:Qingqing.Zhuo@amd.com>>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@list=
s.freedesktop.org>>; Mark Yacoub <markyacoub@chromium.org<mailto:markyacoub=
@chromium.org>>; Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexa=
nder.Deucher@amd.com>>; Wheeler, Daniel <Daniel.Wheeler@amd.com<mailto:Dani=
el.Wheeler@amd.com>>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com<mailto:Ro=
drigo.Siqueira@amd.com>>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com=
<mailto:Nicholas.Kazlauskas@amd.com>>
Subject: Re: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3



On Thu, Apr 15, 2021 at 1:35 AM Qingqing Zhuo <qingqing.zhuo@amd.com<mailto=
:qingqing.zhuo@amd.com>> wrote:
[Why]
Current list only includes modifiers where DCC_MAX_COMPRESSED_BLOCK
is set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B
is also supported and used by userspace.

[How]
Add AMD_FMT_MOD_DCC_BLOCK_64B to modifiers with DCC supported.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com<mailto:qingqing.zhuo@am=
d.com>>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e29cb2e956db..c3cbc3d298e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4535,6 +4535,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,
        int pipe_xor_bits =3D ilog2(adev->gfx.config.gb_addr_config_fields.=
num_pipes);
        int pkrs =3D ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs)=
;

+       add_modifier(mods, size, capacity, AMD_FMT_MOD |
+                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX1=
0_RBPLUS) |
+                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
+                   AMD_FMT_MOD_SET(DCC, 1) |
+                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_D=
CC_BLOCK_64B));

Thanks for finding this issue. Looking at it it looks to me like the origin=
al entries are mistaken. Can we just change the  DCC_MAX_COMPRESSED_BLOCK i=
n the already existing DCC entries? Looks like Mesa always uses the AMD_FMT=
_MOD_DCC_BLOCK_64B anyway, and I don't think DCC_INDEPENDENT_64B=3D1 + DCC_=
MAX_COMPRESSED_BLOCK=3DAMD_FMT_MOD_DCC_BLOCK_128B makes sense.

Thanks for the suggestion. Will send out an updated version soon.

+
        add_modifier(mods, size, capacity, AMD_FMT_MOD |
                    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
                    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX1=
0_RBPLUS) |
@@ -4546,6 +4557,18 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,
                    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
                    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_D=
CC_BLOCK_128B));

+       add_modifier(mods, size, capacity, AMD_FMT_MOD |
+                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX1=
0_RBPLUS) |
+                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
+                   AMD_FMT_MOD_SET(DCC, 1) |
+                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_D=
CC_BLOCK_64B));
+
        add_modifier(mods, size, capacity, AMD_FMT_MOD |
                    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
                    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX1=
0_RBPLUS) |
--
2.17.1

--_000_DM6PR12MB2939D0D3422741E64383306EFB4D9DM6PR12MB2939namp_
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.m1862946999310511708msipheader87abd423, li.m1862946999310511708msipheader=
87abd423, div.m1862946999310511708msipheader87abd423
	{mso-style-name:m_1862946999310511708msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Updated and sent. Your review would be appreciated!<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lillian<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Bas Nieuwenhuizen &lt;bas@basnieuwenhui=
zen.nl&gt; <br>
<b>Sent:</b> Thursday, April 15, 2021 12:27 PM<br>
<b>To:</b> Zhuo, Qingqing &lt;Qingqing.Zhuo@amd.com&gt;<br>
<b>Cc:</b> amd-gfx mailing list &lt;amd-gfx@lists.freedesktop.org&gt;; Mark=
 Yacoub &lt;markyacoub@chromium.org&gt;; Deucher, Alexander &lt;Alexander.D=
eucher@amd.com&gt;; Wheeler, Daniel &lt;Daniel.Wheeler@amd.com&gt;; Siqueir=
a, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Kazlauskas, Nicholas
 &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/display: Update modifier list for g=
fx10_3<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Btw please add a fixes tag so it gets directed to st=
able releases.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks!<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">On Thu, Apr 15, 2021, 6:06 PM Zhuo, Qingqing &lt;<a =
href=3D"mailto:Qingqing.Zhuo@amd.com">Qingqing.Zhuo@amd.com</a>&gt; wrote:<=
o:p></o:p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<div>
<p class=3D"m1862946999310511708msipheader87abd423" style=3D"margin:0in"><s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;colo=
r:#317100">[AMD Public Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"color:#548235">Inline.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><b>From:</b> Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwe=
nhuizen.nl" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;
<br>
<b>Sent:</b> Thursday, April 15, 2021 7:26 AM<br>
<b>To:</b> Zhuo, Qingqing &lt;<a href=3D"mailto:Qingqing.Zhuo@amd.com" targ=
et=3D"_blank">Qingqing.Zhuo@amd.com</a>&gt;<br>
<b>Cc:</b> amd-gfx mailing list &lt;<a href=3D"mailto:amd-gfx@lists.freedes=
ktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;; Mark Yac=
oub &lt;<a href=3D"mailto:markyacoub@chromium.org" target=3D"_blank">markya=
coub@chromium.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexand=
er.Deucher@amd.com" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;;
 Wheeler, Daniel &lt;<a href=3D"mailto:Daniel.Wheeler@amd.com" target=3D"_b=
lank">Daniel.Wheeler@amd.com</a>&gt;; Siqueira, Rodrigo &lt;<a href=3D"mail=
to:Rodrigo.Siqueira@amd.com" target=3D"_blank">Rodrigo.Siqueira@amd.com</a>=
&gt;; Kazlauskas, Nicholas &lt;<a href=3D"mailto:Nicholas.Kazlauskas@amd.co=
m" target=3D"_blank">Nicholas.Kazlauskas@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/display: Update modifier list for g=
fx10_3<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">On Thu, Apr 15, 2021 at 1:35 AM Qingqing Zhuo &lt;<a href=3D"mailt=
o:qingqing.zhuo@amd.com" target=3D"_blank">qingqing.zhuo@amd.com</a>&gt; wr=
ote:<o:p></o:p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">[Why]<br>
Current list only includes modifiers where DCC_MAX_COMPRESSED_BLOCK<br>
is set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B<br>
is also supported and used by userspace.<br>
<br>
[How]<br>
Add AMD_FMT_MOD_DCC_BLOCK_64B to modifiers with DCC supported.<br>
<br>
Signed-off-by: Qingqing Zhuo &lt;<a href=3D"mailto:qingqing.zhuo@amd.com" t=
arget=3D"_blank">qingqing.zhuo@amd.com</a>&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++++++++++++=
+<br>
&nbsp;1 file changed, 23 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index e29cb2e956db..c3cbc3d298e7 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4535,6 +4535,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
&nbsp; &nbsp; &nbsp; &nbsp; int pipe_xor_bits =3D ilog2(adev-&gt;gfx.config=
.gb_addr_config_fields.num_pipes);<br>
&nbsp; &nbsp; &nbsp; &nbsp; int pkrs =3D ilog2(adev-&gt;gfx.config.gb_addr_=
config_fields.num_pkrs);<br>
<br>
+&nbsp; &nbsp; &nbsp; &nbsp;add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(PACKERS, pkrs) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<o:p></o:p=
></p>
</blockquote>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">Thanks for finding this issue. Looking at it it looks to me like t=
he original entries are mistaken. Can we just change the&nbsp; DCC_MAX_COMP=
RESSED_BLOCK in the already existing DCC
 entries? Looks like Mesa always uses the AMD_FMT_MOD_DCC_BLOCK_64B anyway,=
 and I don't think DCC_INDEPENDENT_64B=3D1 + DCC_MAX_COMPRESSED_BLOCK=3DAMD=
_FMT_MOD_DCC_BLOCK_128B makes sense.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"color:#548235">Thanks for the suggestion. Will send=
 out an updated version soon.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"color:#548235">&nbsp;</span><o:p></o:p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;margin-bottom:12.0p=
t">+<br>
&nbsp; &nbsp; &nbsp; &nbsp; add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
@@ -4546,6 +4557,18 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
<br>
+&nbsp; &nbsp; &nbsp; &nbsp;add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(PACKERS, pkrs) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_RETILE, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
+<br>
&nbsp; &nbsp; &nbsp; &nbsp; add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
-- <br>
2.17.1<o:p></o:p></p>
</blockquote>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2939D0D3422741E64383306EFB4D9DM6PR12MB2939namp_--

--===============1186168812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1186168812==--
