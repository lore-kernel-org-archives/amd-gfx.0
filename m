Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E595C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 15:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA23613F7
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 15:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA23613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C496EEB7;
	Fri, 14 May 2021 15:19:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BAB6EEB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 15:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Itp1RzMpBJVVvYiERJi7sAt0sjqtTYq7QHJRAhNaq4XalcgRdcJpsHPuQGUjlPEA959L4t57rYxyJwJGFEK7dBxbgOG3WZMUiUgkwMG/AY12UNW3lbCiKhWQlF2so0/N2cQZxolIJcWqW3qnsdh/ynavlrU6hEK9znMAwwV8p2Kui159ZokBX7a/cT963/Ng3xU7t+ZffzI/bqXhGk8oQC5rrvB0jlhgzAWhSRlwPxTLatpEBdALxoEaJkzKqwhwBTB2VPpCd4K4EKnNfZVxiX7cci4TSJb/LU1lHgdmuIJHwQZBiIcKfhnq+yc2eiKrM5mqP0UMB5sPrBHwTOitGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+ArTE61S5eyyEcULXg5E2xl5uByyVJFeg6GzZ9LsEA=;
 b=Hn5GgF0Cez8L6shSYUSu0E1v37Xzrr8W0h3r6wNB7CFY13GehMCJaUfioh2V8SZKkjTfg49VcXhnl+L2a3F8IVll2+IA2Ya/hkQsenwMHbsRRV3JwJJsEfJx6/g3/DS0M5EpcJ91NPCu38z9dHRc3SpAWx+orsumI0tbV6d+RpmrfJwa5rR6smbst/0TpNYt7cDkQ6m+qZtvVMlNhckXEzsX2Z3y/htDzn5va62URWnrG2XJ5Y53t8wljAO8qy6+rVIAuCWfrJTpm4UzbiamKQfj7QdC/nqS7j35fqegafqfLIdHLoXw8TL+/NY2kU0Q/yjNh+LDcK7fTGtd1TnRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+ArTE61S5eyyEcULXg5E2xl5uByyVJFeg6GzZ9LsEA=;
 b=31hg/Abp1iPLXhTr8/aeC5Fx269Z3DexBRbzU+HR/WYmIptAIOoNjBnp4DsGwS0tjaJ8tr7B0AvEY8C0bZPuHDV7MkFIw5nG22zIY/bN1Kan5LZq+RQQubplYy90enZVHXiCMV0zJS1gJB0B+mxgbldMD6oDaOYA6GA2ksVuXbk=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 15:18:57 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57%7]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 15:18:57 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
Thread-Topic: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
Thread-Index: AQHXSLb9LG4KeNZM4EqXcttEBWbH7qrjFbEw
Date: Fri, 14 May 2021 15:18:57 +0000
Message-ID: <DM6PR12MB3529C3D9FAC6B61B6627FA089C509@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-14T15:18:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9f8593e1-711d-4712-88a5-75dd5670024e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [76.69.133.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a36a5b9-1380-4f76-9d3b-08d916eb97f2
x-ms-traffictypediagnostic: DM5PR1201MB0090:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0090A757C0AB392B258C6CC19C509@DM5PR1201MB0090.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:39;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t42fDZtORwqs+QwmoqJQRVHXxZRTlbUC4AqMm+Bhe6vUcXvoK2vAXmudqruWhhWk2YRnSEE6e8b++0LD5vgJmiuSJab5ClVmqTfM59ppMsygYGIvyE+h3qPCYyP26V6td0vbrBwgK7q1QmzFTMx7dQ1Xs0giwqsRDl+J/O9sNDAmIJtErkg55LD1ARQCNN2unjzwwzpITDdiZH2C5XabTkvzCkhCcvo06mfy2HMbpFkcAhh/GUSNH0sXBaD630tM5Mh7Bi+kzipJ9KMPfC79C1IDQAL25iVYxu338l8VFo1mz3T+qtQtapIgdy6PfGqF3JHIyG8NdNt24DjbWoA6C8O9RvTv5um4e8LDeGh5xdmqj61kgBNmveki8XrrhLHWDfKxSzOQoIMPi3ybcNZrKBDuw7g+phkh2nQx40udxwrMKBoN6tdPRuDt1E8VuhcSWA4YFGs25+KJZm8o1pe+4xWjR60aF2bzOcvBc7l92/hWDG+KcoLznBaCzSoB6/5iz3TLoxcyczxpdDd8iX8UDY7aCzoEEA+JlefGTkT7p5IFWbV1EW+b/F95xSA6LGx6gD/bK4VW5p2y/G3y8zj8NZx58uFNbL3CehWUKWrKyc4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(83380400001)(478600001)(8676002)(38100700002)(33656002)(122000001)(55016002)(71200400001)(76116006)(9686003)(86362001)(66946007)(66446008)(66476007)(64756008)(8936002)(66556008)(53546011)(6506007)(4326008)(7696005)(2906002)(186003)(54906003)(52536014)(316002)(110136005)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?W72LDMSTKh32hMi3HLB+olBuywebNety5ITTAMDaHdwkVnLIQG4JVFvo2L?=
 =?iso-8859-1?Q?6py4B4cMCTjEK6Z0qSkBQOxgqCdri0Y0gIxSVgfH4uHhgTS5hCoE0pm2dT?=
 =?iso-8859-1?Q?SILJzWq64Io0ytfBn+sPaf4HgMjpnadeEvODPkHTe6fEs8sD3fYU6IDzsq?=
 =?iso-8859-1?Q?G2LMuhawnOiJJNnTewSxnCt7LKhM9x/NgBqLv1CtzahyiZMVaavxbTEEzU?=
 =?iso-8859-1?Q?h67HljIg+KxQGauLcbV3G7kA1LM20Sj70K27k1xuVah+nFy8EiAqJTVxft?=
 =?iso-8859-1?Q?QU9Fll8vT0F0GW0514I6aFgjNY80uDAo4IZAjwPGexDZ6WEarXW3Jb7YHX?=
 =?iso-8859-1?Q?yrDVx6FMAGykZSrE+HPjHeQFejKNrqCG/1aJAwXqQd/zpDb1EVjfkcmLAz?=
 =?iso-8859-1?Q?NiyMwYpbtWY09tH9YFBXHt/5aEC6oYjEoN9gkobhPELJZakwWGMU+wfEBv?=
 =?iso-8859-1?Q?WyrcImhsq71sB2hxi/m5osaLaDvp8gOM156dvuNlUnxv1kYbwf2KWwxHjU?=
 =?iso-8859-1?Q?N3mapW8Ab67Bu2aM+PySXrU/3VL5eRpvKiNwFKW4e11ZTWhz/lgZv3vb7p?=
 =?iso-8859-1?Q?feEy8rf5+W5EE9Pd+oU0jY8OADEKx2UcFiHSMJJaYjg++/SpEAmokypAmY?=
 =?iso-8859-1?Q?eRNJRAJbPU7qPEf7H3AZnvZhf+8YL2UE7rGPnOL25P79PSoZscs4dbTGe0?=
 =?iso-8859-1?Q?TGZC1h1neE+eOLV0EeEKZCvX9Q7EVcVs9TRTeyoaLdvzJjGrpFIsnfM/gD?=
 =?iso-8859-1?Q?57c3d5OJ/64rI+MHmEHP8DNVXzo2JOBV03beX27iPWeyRF+0pNHDsWB2UF?=
 =?iso-8859-1?Q?6gC/sh8Eow/2L9hxmPqW2eNyZTC2LvOAXmEiNNABN76JqkuqAlUiyXY0MH?=
 =?iso-8859-1?Q?q/CUa5zvu29A4ZWhR65emVuhAWpaMMw7Kn3gpT0XlT6jMw550X+KesdxLp?=
 =?iso-8859-1?Q?pVJWaoL2qmsG5Mylm0atmqE2mzgWEnz5JccrKM+TKyrsO5qwktAkwq3AsO?=
 =?iso-8859-1?Q?d0fofLi9lm+qtpUgjVgMW2q7TBsSRlwN2bnGE6HLAcUmy5QF7vHX6jy8hg?=
 =?iso-8859-1?Q?+fmTB/RZxtBD6ZHOd75M8UhJzNCiAFnejo02O0BMLXcb9rnXU3JSfvTN6c?=
 =?iso-8859-1?Q?R/jqibic0Fqm8HHt8TnUgOFHxerKgJhTuko4t5ZMbNhe7EC8jNSeYpTNZ0?=
 =?iso-8859-1?Q?F8YbwCnhL5bPH8vuJFeIOgWZfbnfyQ+WsFd5YOdDSqys7zyx/e54DE3qB4?=
 =?iso-8859-1?Q?8Ixo0iHiH8jf39uCZwdE7Aq8DAOkW7iRSwfBu3/hTxcbzqQ9xHeTePgEUa?=
 =?iso-8859-1?Q?Qp9ATSRudl9ysWrwQDI1Dtdc65moJ6kpGfWKwWWZ6AXKkJxhZ4EEjE7/2B?=
 =?iso-8859-1?Q?7WJPVs+H7b?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a36a5b9-1380-4f76-9d3b-08d916eb97f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 15:18:57.1351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZR1iAV7I5fUBq2au1FLz0t7S5C2ASmDA/JNolYy8uxD9Yj0vTwcEA+gQzbGaC9obgusDo6gPY2N/aDY0fAuvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0090
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Choi,
 Nicholas" <Nicholas.Choi@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

The tests that failed previously for me were:
amdgpu/amd_plane -> mpo-swizzle-toggle
kms_atomic -> plane-overlay-legacy
kms_plane -> plane-position-covered-pipe-a-planes
kms_plane -> plane-position-covered-pipe-c-planes
kms_plane -> plane-position-hole-dpms-pipe-a-planes
kms_plane -> plane-position-hole-dpms-pipe-c-planes
kms_plane -> plane-position-hole-pipe-a-planes
kms_plane -> plane-position-hole-pipe-c-planes
kms_plane_scaling -> pipe-a-plane-scaling
kms_plane_scaling -> pipe-c-plane-scaling

After testing this patch on a HP Envy 360, with Ryzen 5 4500u, a Sapphire P=
ulse RX5700XT, and an AMD Reference RX6800, these tests all now pass. =




Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

 =

Thank you,
 =

Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com  =


Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display
O=A0+(1) 905-882-2600 ext. 74665
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com> =

Sent: May 14, 2021 7:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wentland, Harry <Harry.Wentlan=
d@amd.com>; Choi, Nicholas <Nicholas.Choi@amd.com>; Lakha, Bhawanpreet <Bha=
wanpreet.Lakha@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>=
; Mark Yacoub <markyacoub@google.com>; Wheeler, Daniel <Daniel.Wheeler@amd.=
com>
Subject: [PATCH] drm/amd/display: Fix overlay validation by considering cur=
sors

A few weeks ago, we saw a two cursor issue in a ChromeOS system. We fixed i=
t in the commit:

 drm/amd/display: Fix two cursor duplication when using overlay  (read the =
commit message for more details)

After this change, we noticed that some IGT subtests related to kms_plane a=
nd kms_plane_scaling started to fail. After investigating this issue, we no=
ticed that all subtests that fail have a primary plane covering the overlay=
 plane, which is currently rejected by amdgpu dm.
Fail those IGT tests highlight that our verification was too broad and comp=
romises the overlay usage in our drive. This patch fixes this issue by ensu=
ring that we only reject commits where the primary plane is not fully cover=
ed by the overlay when the cursor hardware is enabled. With this fix, all I=
GT tests start to pass again, which means our overlay support works as expe=
cted.

Cc: Tianci.Yin <tianci.yin@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Choi <nicholas.choi@amd.com>
Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Mark Yacoub <markyacoub@google.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ccd67003b120..9c2537a17a7b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10067,7 +10067,7 @@ static int validate_overlay(struct drm_atomic_state=
 *state)
 	int i;
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state, *new_plane_state;
-	struct drm_plane_state *primary_state, *overlay_state =3D NULL;
+	struct drm_plane_state *primary_state, *cursor_state, *overlay_state =3D =

+NULL;
 =

 	/* Check if primary plane is contained inside overlay */
 	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new=
_plane_state, i) { @@ -10097,6 +10097,14 @@ static int validate_overlay(str=
uct drm_atomic_state *state)
 	if (!primary_state->crtc)
 		return 0;
 =

+	/* check if cursor plane is enabled */
+	cursor_state =3D drm_atomic_get_plane_state(state, overlay_state->crtc->c=
ursor);
+	if (IS_ERR(cursor_state))
+		return PTR_ERR(cursor_state);
+
+	if (drm_atomic_plane_disabling(plane->state, cursor_state))
+		return 0;
+
 	/* Perform the bounds check to ensure the overlay plane covers the primar=
y */
 	if (primary_state->crtc_x < overlay_state->crtc_x ||
 	    primary_state->crtc_y < overlay_state->crtc_y ||
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
