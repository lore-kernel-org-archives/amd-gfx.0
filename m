Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B5DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 16:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1996115B
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 16:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1996115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CDF6EA8B;
	Thu, 15 Apr 2021 16:06:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9D96EA8B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 16:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7TX7L7ZNntaZTjEfY10abDt4o+1R50le1tbwCAbxWuAWJadoAwpbQd4xrTUjE9PC4A6fDYl2Tu9kLMI+m4gnuc7UPPRKRQh/nBQVIzRm72MwSSBdUH2bYM9IFsG5MFi4b8FTKlb137AgJRf77xD98aYaZ5ydQZYdpyMH4kbk4FYrpDSCuZ7Zl/eilE9UVqMNLSfy6VDm7Mw0LXqppW3dLbEYJQL5ky77ZzMgdWFCJ0wS6JTb4oF5Fboa/Yq9Tg190TyGomKnAHG8XpaCqng5NjcywG9S6CwN+x3Pq7ezqSSVxlmzueOXD3UFX6TdaaSdbcvwjBWPxDD4EgLvhglPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3hnkLOsYO+bngMRtTH/B4Zw1/hjhP8mW//ie7ouUY8=;
 b=KOMRfB0FtoQlaJwhpDb7EzYLw2/WrB9WV5Ilc3dRbHXPkNTfNTgLZauF2bt/MTvcY1SUGzEtRei//KxPd7QwqN7YOC8hQQdJGF0VXc3oEu6mnQnQ8QWGa/gWATUytzY2NKf6nxtbMnTWZ+EAW9JNPOHfW4ae4crz47foWIWzLlmsU0fza0uQ7i0filUmJTz4KOm4cG5ZfRXPIvwL1SZAqOUXVr+l/lbIpILVvDGSElgakO9CIG+LkUhC8u2+WnG/nejZiNG5srN1AutMF0uA/Wx7QEeE1hts3V7d9a63KJEDYIeb0ZPQsW0zU9GzsS6sVomVmuLV4P9acQb6pyYJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3hnkLOsYO+bngMRtTH/B4Zw1/hjhP8mW//ie7ouUY8=;
 b=4FAO0bBBrj+N5yFq6R4lGdMiGuKILBTYaFUlZUMfJQxWogmK1Us2ZiFp7MgTalu45STWa+YB3If576R04Y0USJwLUe1BIKS4iNExjWT/k32NfJ2iyH2E5aaf0tBexN6c2ANTujD7FMAj9AsFSUOfoY9cYBa4vvHBbRGMAz1xMAI=
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 16:06:49 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.037; Thu, 15 Apr 2021
 16:06:49 +0000
From: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: RE: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3
Thread-Topic: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3
Thread-Index: AQHXMYbjbkqVYgyfhku0Lm6ukFhsnaq1cQ2AgABMlqA=
Date: Thu, 15 Apr 2021 16:06:48 +0000
Message-ID: <DM6PR12MB2939FC23A4404409980F7D1AFB4D9@DM6PR12MB2939.namprd12.prod.outlook.com>
References: <20210414233533.24012-1-qingqing.zhuo@amd.com>
 <CAP+8YyHU8GtCzFk71h1qjQWKYQpMwrA=s88dw2Fu3_0LXSMEWA@mail.gmail.com>
In-Reply-To: <CAP+8YyHU8GtCzFk71h1qjQWKYQpMwrA=s88dw2Fu3_0LXSMEWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-15T16:06:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b9c573bc-fe6b-4795-9b81-df6674b5ba76;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: basnieuwenhuizen.nl; dkim=none (message not signed)
 header.d=none;basnieuwenhuizen.nl; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35fe01ea-0c80-4271-3cc7-08d9002879be
x-ms-traffictypediagnostic: DM5PR12MB1659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB165949E3F4AE8A9C8E0CEC2FFB4D9@DM5PR12MB1659.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7o4+BnLtugBq9ZHVS92yNgaUyH7WXs7VYFqjV9YASI/knVstUAr/zveKZNBdHM22ZcARIC3O+m52aA506mqIYAMWbzHa0kWAmjFfOKXN91jBuFIF6vaCh7uOSQbhgj7pxN8LyT8dyQI3yKRv/czpbVZIX8/l7G9ejhHf9QjjbVBWeYzwKcuQ94JFcGBjsMhbmrDrr4H9W5tiZSJBcG5irihbbrK23Ag60vstl40RRDEBpkvW5FTtFgoKNcqeFlpWJYGT4PW0Eq2xNv82X8Bl/S+kIdfqFU7+w+MPVw1ezaRPp4TbxI4fRPm89f3MYXQsJ46xvhL6ZRpHd5m2gc/ffhER3x9tG7HbwiJXbxpHHAPxKPNQd1rd3SrrS3zyyqVydDW0DRMfalVAUFOe/V9bdyYmObkP70+sek1W5+Qf5NBAnBF2JN/W4dYYZytAdeT6Gp5Q4W6+5Gh0ccOn7tvk2F00BF5aEjLEhAKniHHcjh5S9fovsCJQBfTN96+fjVQAYT2+UK5HH/hvkXBtO+fCW23Wgf7Gfm4QaFIHh+NiS/4W/RgPN3sW94Pq7AU7PMsfNeoasV3mFlUTTm3tC0BBKMyZ2MlbGz8lRDJnMwNkouU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(6506007)(53546011)(8676002)(186003)(8936002)(2906002)(86362001)(4326008)(15650500001)(83380400001)(478600001)(6916009)(316002)(38100700002)(66946007)(54906003)(9686003)(64756008)(7696005)(33656002)(66446008)(26005)(55016002)(66476007)(5660300002)(122000001)(52536014)(66556008)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LMVPh/rys1Cyac2uOWLXsA4faslW+Y4XljJMGC73dseQQbORPIIUTfJ2rA5f?=
 =?us-ascii?Q?PHvytD44CTOtB6vSxxQ379YaEr+lxUY1kPLoCV0xsTJojTG2TD3xsrJSwREu?=
 =?us-ascii?Q?WhmjhwyOszs2DpweJc5MYJbbBC6fDLoGgYPfW+cXR7O1W/TslMhPoJhAty/p?=
 =?us-ascii?Q?w1WOkboqLoaxXJ6M23S2d4xX8gtbGPteiRZSKWVtVFRBe/mMU900ZGr8VqsD?=
 =?us-ascii?Q?uQzWwwspVSTpchU+OcFfTlVRQ9lsCrSZ34OeZwGOQKw52yWXozTh9v72IXdZ?=
 =?us-ascii?Q?/Y4oOsD0xHTP6JPmdEEMGu0B88MyoxiyeCrKuqDotTemaK/Rifu4imVZllPU?=
 =?us-ascii?Q?PEcvek02Vy8LboOA1qnFvoQy5JY+VFn0Thr93nDBuoUqOMtbQlvJPBvsdWNf?=
 =?us-ascii?Q?lT1M1uR2g+XA4fMhD0CmIIV4E3nuN0WUdXRYXcfmUoa7DlpeHb0I9KTJfb97?=
 =?us-ascii?Q?4ZcpUKJJzZkiyGgi0PfXZoD6VEUyYYYIOqAR23kT7Z5PWoTUSfFSfoPbK5bd?=
 =?us-ascii?Q?4ba/jVo4wwyjNmmYEcEqhxF7yMH5MR5qGLUU+Voyqq7YTzHGLuGYrMOGhDTL?=
 =?us-ascii?Q?65BeaD71Z1FfjXUxVyZGkntiE71jQ/POSbhrpMMTpYi2T+je0Vt5w8Qfu4AQ?=
 =?us-ascii?Q?gI+k8aqA/hgk6im8dTowYV/K5+Hp2QNi4rP4cvHXxjj59AbCqI4mBUNUr/4l?=
 =?us-ascii?Q?oubOxMl86opHPE+EasKt1eRB2T81c//hAgH+1Nz1ocRFduMyC+FkpKbXmEu9?=
 =?us-ascii?Q?AlViIUpIknDBVZI6L9LUxU0h9eh9U0hNYYv7H3VNfrAdgj4nNHRqFytSqLTf?=
 =?us-ascii?Q?io15Lah9fzGe8EwFYo7cN9PxzotOA8QyqZS0dVAfItFECZT1NkpUX42LT8X4?=
 =?us-ascii?Q?TlK8i+1Reao6XFRsKN6vIHurtcn7yWOA5rqiurYDcojsTPn+2RrEvBhnTWYm?=
 =?us-ascii?Q?mVcz7jgr4tuCCo75Wfx0VvFE1nM5MGHKv5FA9iYC5sw18jTf6+dktMfISLR2?=
 =?us-ascii?Q?kneoLvKlEe2ABwNGfRPt92iIJtfkJ+GfxQlngAzB93pHtwslOEVMDZpAA5Sf?=
 =?us-ascii?Q?6cDarj5dSLAIe6kXRCwbXeWWwgPQ1VmajLudL5g64rPD3KTYjcWSvh/H3Ah1?=
 =?us-ascii?Q?fBTsNsNyUIUKZbfbWBxAXMqc6lh3B6WUKUeAst9QGbVWar4kpgsnq1P4VzNy?=
 =?us-ascii?Q?Vdo6v8kRctXirM8fr0iXUQHrAZ2/xiFWHgB2FfB52BihRd2aD54STtikMqzN?=
 =?us-ascii?Q?gMU9YbV6wYajGe0YIl8JZugvt8zFP4iYV/5H37iSXPjMP5hv72DUEbAs1Ir5?=
 =?us-ascii?Q?vn2Zzw/PCYReQy36PmvECwf0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fe01ea-0c80-4271-3cc7-08d9002879be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 16:06:48.9009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4kseEvw3SzbguMqLcItKBZplxs+B/toq19RQCnd3WF4Zm35Pa1xYT/X+f8IMtTk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
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
Content-Type: multipart/mixed; boundary="===============1371727078=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1371727078==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2939FC23A4404409980F7D1AFB4D9DM6PR12MB2939namp_"

--_000_DM6PR12MB2939FC23A4404409980F7D1AFB4D9DM6PR12MB2939namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Inline.

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Sent: Thursday, April 15, 2021 7:26 AM
To: Zhuo, Qingqing <Qingqing.Zhuo@amd.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>; Mark Yacoub <mark=
yacoub@chromium.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wheel=
er, Daniel <Daniel.Wheeler@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@am=
d.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
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

--_000_DM6PR12MB2939FC23A4404409980F7D1AFB4D9DM6PR12MB2939namp_
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
span.EmailStyle18
	{mso-style-type:personal-reply;
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
<p class=3D"MsoNormal"><span style=3D"color:#548235">Inline.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Bas Nieuwenhuizen &lt;bas@basnieuwenhui=
zen.nl&gt; <br>
<b>Sent:</b> Thursday, April 15, 2021 7:26 AM<br>
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
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">On Thu, Apr 15, 2021 at 1:35 AM Qingqing Zhuo &lt;<a=
 href=3D"mailto:qingqing.zhuo@amd.com">qingqing.zhuo@amd.com</a>&gt; wrote:=
<o:p></o:p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal">[Why]<br>
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
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks for finding this issue. Looking at it it look=
s to me like the original entries are mistaken. Can we just change the&nbsp=
; DCC_MAX_COMPRESSED_BLOCK in the already existing DCC entries? Looks like =
Mesa always uses the AMD_FMT_MOD_DCC_BLOCK_64B
 anyway, and I don't think DCC_INDEPENDENT_64B=3D1 + DCC_MAX_COMPRESSED_BLO=
CK=3DAMD_FMT_MOD_DCC_BLOCK_128B makes sense.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#548235">Thanks for the suggest=
ion. Will send out an updated version soon.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#548235"><o:p>&nbsp;</o:p></spa=
n></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">+<br>
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
</body>
</html>

--_000_DM6PR12MB2939FC23A4404409980F7D1AFB4D9DM6PR12MB2939namp_--

--===============1371727078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1371727078==--
