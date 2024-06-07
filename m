Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEA3C27C5F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 16:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A8710E069;
	Fri,  7 Jun 2024 16:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uKH8ptrf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A41210E069
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 16:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKfMESIEOpL/Aiao1F/gpKVZD7ce0ycGuLuJfDvl/ceXQYwvtlVoEjxStdLsYuyKsGPhYP6F0ma1H1Ffmayt/UxMXEV4yGfYMdl5hU1I573ipy33ogkJl4WXO2KvpS426+AvBICE4fPznG9obiuSRJjWKowDKnq5zPcsZbOLxSAI+1Fx54kmHyletbx6JGG3Z9Ghh+EwHaT0cp+fLaEknfjrC1eTGkrSjUTrk+m2149vU5PnbzN5F8tOCp9BOi2k53ehr8o531UPtiCI6EctUF/QG/2PS9h0oceEyADbEdnWyDql8fRmefuqvNz5NlFxZBBi4BWb7z7tDCFiAP037Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztWuVhlKqDRUOdOVj9RpHoR9iXIhhy9trWreX5UnovQ=;
 b=GZMwphXhGz49m3qacmRIniKVaH8cBbAc8fqk6dHxmRYORjkprZkhaIolHahiX6c9xU3qdAkNP381lINbQXEPsJrVuDd8iMB/xLX+pj9/QWsm+vNUfpzbWtuO16ZpQXuZ/icUIrewaTKB8lmeCQ+xU+ChhUt+IQKnpXi5I691eHUOni5xOIKbKwFjDjbsQxteAr9P2pUZlgcy+I0Pp16I1UDrO7oV/cOph2Sx6DhZyvonJ3hEZDsYdt1EukbiepO8uIEn4HNv5QSklCbE5U31ya6Si+vdBwxWHyrkY8fmzGIP8t1hW4lr2tygAcadH6f1y5ukblmvsqxoET+PsL9org==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztWuVhlKqDRUOdOVj9RpHoR9iXIhhy9trWreX5UnovQ=;
 b=uKH8ptrfA213u8R6NzJ4AqoDRBp0MllF+7sPc8R9x+2t4WcPkcK+pQVnHXUei1jEtvJH5SE1OrRJTmZzBe5fROfGL1XErPbjpR9ktC3DYORtAwIktnPr3KJ7BiCFI4CNi+YvSnM7m9RMDlG6sBdw6FcvRTnGeiqiPWL1W7xUaqU=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 16:49:41 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::9dd0:4a5e:a7ea:8e6d%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 16:49:41 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Choi, Nicholas" <Nicholas.Choi@amd.com>, "Zhang, George"
 <George.Zhang@amd.com>, "alex.deucher@amd.com" <alex.deucher@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: Re: [PATCH 2/2] Revert "drm/amd/display: Add NULL check for 'afb'
 before dereferencing in amdgpu_dm_plane_handle_cursor_update"
Thread-Topic: [PATCH 2/2] Revert "drm/amd/display: Add NULL check for 'afb'
 before dereferencing in amdgpu_dm_plane_handle_cursor_update"
Thread-Index: AQHauPiOcK+fQHxrW0OxAXnRzaSvjbG8g2Br
Date: Fri, 7 Jun 2024 16:49:41 +0000
Message-ID: <MN2PR12MB4128FBB34A765E0DB78DAB7490FB2@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20240607163359.18299-1-ivlipski@amd.com>
 <20240607163359.18299-2-ivlipski@amd.com>
In-Reply-To: <20240607163359.18299-2-ivlipski@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-07T16:49:27.6074622Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|DM4PR12MB5913:EE_
x-ms-office365-filtering-correlation-id: 4d3c7007-2fa2-4b73-e87a-08dc8711d378
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?eKElAzNb/z2jUq+jUttnxf7R4Kx8hEqMsSQZzIkO6iI9EI6bMWXgsle/qKDf?=
 =?us-ascii?Q?1vkrc6yan0k0fkLOkShduF2BWuNxv/k3STuTJUSD1rHNtNT3WYpJ971c/gZw?=
 =?us-ascii?Q?WsVMCb7P43E6BrCr7tCHSievIB0wWlz3q3Elg65YHQb3v1CV4jExcnKEP8Tl?=
 =?us-ascii?Q?cuE+zjL/g1gpeyibNxAQhzAHcPXkxf1rJeFWroS2dllIZ8ozrmcEbi0Dih1u?=
 =?us-ascii?Q?53/A3Ox78KlJq5XYPuuo23oszF5JLRPxlg4uvcqAeJEg8ODG0QKMh1HtfrOQ?=
 =?us-ascii?Q?CKuB3+PC7IOWuuMekt1oQ4+KMCyd6sSZz4wBZJw/Hd20OTdmi4hPzUWBB3jf?=
 =?us-ascii?Q?aFP3Jxcs4sNsN5187A35vLh1cl6SMD0mkTDkvvNtd0kM5mxberA7jJofgNZN?=
 =?us-ascii?Q?uquUveK2n2C9z3mJujiM81XoyZCzhuZfd21uKcr134BwRhac3hdnGNZch6Qb?=
 =?us-ascii?Q?ewO0fSSGRTRw6lXdZXOhD95zWnxFCEr/NO3Nq5C5OM35rjI460hehYjKnMWA?=
 =?us-ascii?Q?icELhFIECnQZqjCOQTwEpPmFWzB2jituKziaTMsnwK2iEE/PNcBUWDUocw86?=
 =?us-ascii?Q?kB1b2Ts+tYJz9iA7NWT3i14V2e0dAYVOoU52XEt1rdNDOYVqsspO9F4LOa7E?=
 =?us-ascii?Q?TcqJbIWcmCxr2WXKooB0pABXi7V89LErIVNoT0H7spjhmnUNymWXXyhT+2+o?=
 =?us-ascii?Q?n7yF7dqKqCFJIzEJbu43cbE/1S58f1HSdIg1TNKHqlhsqZ7CyYPdP1xnKMrX?=
 =?us-ascii?Q?lH489WRiQTP/yxX/+vRZrUNQg/q6TjDwO2KTjN81AjIgvlv/uI54CEW6fJy3?=
 =?us-ascii?Q?fLpRD91joR/757AhbTC+sS9qBMreQNTkFQhouLYlLQUo/ap1KyWJJJmrItkz?=
 =?us-ascii?Q?qK1p4+/vy29rfyz9rkYrATju0egdKklgExlQ9Wz3K3ritANcnTl60hCVVzt6?=
 =?us-ascii?Q?/DxcIyIAt83/LhU/Jgsnl4fEmsMMn3mRh9QrhAm+3Sev7NvZ0r2aACSIQq+u?=
 =?us-ascii?Q?7DoeGNxMI1gXfCx7D2vUAnwjqIHYy0+m+wI2y7ncnazibcfmVrqgrxgYXBeq?=
 =?us-ascii?Q?bzo+gzjqp1MBY0Jp11X75J06YDtoC/o/k3Kta7KjTHBtc7IaqGPKFVcJA+qa?=
 =?us-ascii?Q?skHkPGV7cTbjqXRs25w1S+IUB0kSCSQ7XvUBreGuCE0BwGKaOHxFp81tBeBL?=
 =?us-ascii?Q?nVqObzMkM8Nzt5uJPDuqIMoXrJkv5SD0XWFxCQEEzMiCU1AEt8SocmDWqJtW?=
 =?us-ascii?Q?IsM32ECGWSkx1c1Ju4QYU/GKW1akzlpljORuGTOIg4oM6IOqdQzruhK9OscG?=
 =?us-ascii?Q?L1Z+H6d7pi0Maavo2rmXPDmO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qOtgYwzovO6sBm9GIPYaqHiTteFh0vjs4xcg/zkwfvSRAtMpCCR2jzUm+EhY?=
 =?us-ascii?Q?oe9HfjkvIyHg4ym0KQUZW6wnP71CaoqR1Z8Hb6LH9ICAG2ckXpT+uzmXh+yc?=
 =?us-ascii?Q?lErDf4h/pxxJKF5VzN+XxrJ1hQAPpCf+wgp/H0DCBwIoBLIAyICjbgVBz27U?=
 =?us-ascii?Q?jEq4N2VG9vgZU/+CyBtqGEwhyKbY05cj4bMlQ1bl3tKZ+OvRlxojrMcjCVJe?=
 =?us-ascii?Q?qcOeN+qfvZ88TYZ6ztqjzxRFiiQY1eDflBNm/bffFQr5SsFVaaQIsdp3wP+c?=
 =?us-ascii?Q?9HDjpsj2lAzNGMpT5/W8u39J0Pl+nuHyhpEb93fhIROHse32ew/ohJA/4vR+?=
 =?us-ascii?Q?fHjd8w1HlKE8rmHEfuwu3/i6Q6RH33bE8VVhin4D4L8flALVODzeFlN+FwUd?=
 =?us-ascii?Q?7WKrmLpc3xzCwjE1cGnbOaFaD/MUF9JF4PA02qZrKjicq94GZGbLVQnrLwCJ?=
 =?us-ascii?Q?pGUghGU5zscqZqyb/+vCb4W/wSdU22yMoQeSeMWwsq2qY/iNMriKedxfF6R5?=
 =?us-ascii?Q?6mjzYqLWIRMzzgdp3NbAjOb+SayOMTthnN/Q/Oog3RQox3WJ4dGpz/rWrxJg?=
 =?us-ascii?Q?B73ZcxXNxWgA+c9I2C6zgHUpy99fzcXunoCsOJ1tuXzRh9NSNPazAdYCc4yY?=
 =?us-ascii?Q?qTY2XmbizSKgZxNKujjJuTOye1w6xloXrWc6VVNp1iSsHK/Y8iyvhJNhcMVr?=
 =?us-ascii?Q?MF4KmTlaafuQHYXLAqu8eRJGgClaaUHKH7V1t/GoIZeLB0spCa3nMK0nDzAb?=
 =?us-ascii?Q?hKFkGyBzs8e/Y5c/lJpF4JC9KSzFf6cD/ah1FSBkQf8yl/n+fiqIMBMIOykh?=
 =?us-ascii?Q?33KUWi3evw/ue7KJn4EdSmnKgFnm01hBwPO8e51u1HiV2GJ+KsO0oVQ2UNOb?=
 =?us-ascii?Q?fi50A9s1vBfHp3VIq0471SfSy9i8eYosUH5UwZ3T3VZYHnj82VRwbGMNUCz2?=
 =?us-ascii?Q?pKsGGfiQDEde0l/8o9/Y3aSt6CjXR8nX2BWVqjobqvTwXN4NRo/fqZG/OdqW?=
 =?us-ascii?Q?YYrqGsQfITSMM5Ft2sTI5BjhISqJYeK21HR4CnifQrcffyrswCcrgtIuqO6T?=
 =?us-ascii?Q?sYZleFQS6R4vVkzttKPImU5IL4a3Ul6LP4bz9+z/iqWn7c+CujTDBCBzYHJA?=
 =?us-ascii?Q?n1lTaYVvEe1SBpx2wbevqgDNYKNAxNHfRTbl4riqNEbsa25Tef4YacUytwbm?=
 =?us-ascii?Q?l2lk5TSjbDkY1u6gIEMeMgc/OB/QwoPJ7M4aS9Rci5+uYr4CAGzgEcNV1CKD?=
 =?us-ascii?Q?MBSGi1T/n/V+7P2RcIGCkXtvqrq7WLuWEZwH6QpGK0gP1iMI5/ET3B1AtlKg?=
 =?us-ascii?Q?HuK9CO7XJn0AduF1FL+HEDSJSRnJ+WYdvcrrpr5lkI/j9wiMKzZUThv4SX/x?=
 =?us-ascii?Q?GaahiodsDTmo3isduZzxcMwX0DjnDgjl39DkswYwx2H2QwarpBYZlvEF+M9N?=
 =?us-ascii?Q?IIrt7GntoVk8wEZeq7QNQw/g6z5Mq6E2ZCNmFCyWJQ61+1FDbxorHWLu7ijE?=
 =?us-ascii?Q?DqaFQO5GJdP32BStsuZxkV/nAlP+3EXJva9iHVSvp8DHfV05X18C24lrTXDg?=
 =?us-ascii?Q?Bgzu42RD52BtC9bbcaVAaNnkl2EhWTkZmZQiQhZ3?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB4128FBB34A765E0DB78DAB7490FB2MN2PR12MB4128namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3c7007-2fa2-4b73-e87a-08dc8711d378
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 16:49:41.1691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JHudqXFr8FebSjHr/dZHK1OUj9RHMtRRFHQPGOAqT6Cza+udMsigfC7U8uvwstCxp3HQ36CDgMB2LMekM5JXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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

--_000_MN2PR12MB4128FBB34A765E0DB78DAB7490FB2MN2PR12MB4128namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com<mailto:srin=
ivasan.shanmugam@amd.com>>

Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Sent: Friday, June 7, 2024 10:03:59 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Li, Sun peng (Leo=
) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira,=
 Rodrigo <Rodrigo.Siqueira@amd.com>; Choi, Nicholas <Nicholas.Choi@amd.com>=
; Zhang, George <George.Zhang@amd.com>; alex.deucher@amd.com <alex.deucher@=
amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Subject: [PATCH 2/2] Revert "drm/amd/display: Add NULL check for 'afb' befo=
re dereferencing in amdgpu_dm_plane_handle_cursor_update"

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
This patch is a dupplicate implementation of 14bcf29b, which we
are reverting due to a regression with kms_plane_cursor IGT tests.

This reverts commit 0d84450ae0db367780c3dd2e208fe4e6fe5565b8.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b339642b86c0..a64f20fcddaa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1246,22 +1246,14 @@ void amdgpu_dm_plane_handle_cursor_update(struct dr=
m_plane *plane,
 {
         struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
         struct amdgpu_framebuffer *afb =3D to_amdgpu_framebuffer(plane->st=
ate->fb);
-       struct drm_crtc *crtc;
-       struct dm_crtc_state *crtc_state;
-       struct amdgpu_crtc *amdgpu_crtc;
-       u64 address;
+       struct drm_crtc *crtc =3D afb ? plane->state->crtc : old_plane_stat=
e->crtc;
+       struct dm_crtc_state *crtc_state =3D crtc ? to_dm_crtc_state(crtc->=
state) : NULL;
+       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
+       uint64_t address =3D afb ? afb->address : 0;
         struct dc_cursor_position position =3D {0};
         struct dc_cursor_attributes attributes;
         int ret;

-       if (!afb)
-               return;
-
-       crtc =3D plane->state->crtc ? plane->state->crtc : old_plane_state-=
>crtc;
-       crtc_state =3D crtc ? to_dm_crtc_state(crtc->state) : NULL;
-       amdgpu_crtc =3D to_amdgpu_crtc(crtc);
-       address =3D afb->address;
-
         if (!plane->state->fb && !old_plane_state->fb)
                 return;

--
2.34.1


--_000_MN2PR12MB4128FBB34A765E0DB78DAB7490FB2MN2PR12MB4128namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto"><span style=3D"font-family: -apple-system, HelveticaNeue;=
 font-size: 14.6667px; display: inline !important; color: rgb(0, 0, 0); bac=
kground-color: rgb(255, 255, 255);">Reviewed-by: Srinivasan Shanmugam &lt;<=
/span><a href=3D"mailto:srinivasan.shanmugam@amd.com" class=3D"ms-outlook-l=
inkify" style=3D"font-family: -apple-system, HelveticaNeue; font-size: 14.6=
667px; color: rgb(0, 120, 212); background-color: rgb(255, 255, 255);">srin=
ivasan.shanmugam@amd.com</a><span style=3D"font-family: -apple-system, Helv=
eticaNeue; font-size: 14.6667px; display: inline !important; color: rgb(0, =
0, 0); background-color: rgb(255, 255, 255);">&gt;</span><br>
</div>
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Get <a href=3D"https:/=
/aka.ms/AAb9ysg">
Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> LIPSKI, IVAN &lt;IVAN=
.LIPSKI@amd.com&gt;<br>
<b>Sent:</b> Friday, June 7, 2024 10:03:59 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Li, =
Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentla=
nd@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Choi, N=
icholas &lt;Nicholas.Choi@amd.com&gt;; Zhang, George &lt;George.Zhang@amd.c=
om&gt;;
 alex.deucher@amd.com &lt;alex.deucher@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.L=
IPSKI@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] Revert &quot;drm/amd/display: Add NULL check fo=
r 'afb' before dereferencing in amdgpu_dm_plane_handle_cursor_update&quot;<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
<br>
[WHY]<br>
This patch is a dupplicate implementation of 14bcf29b, which we<br>
are reverting due to a regression with kms_plane_cursor IGT tests.<br>
<br>
This reverts commit 0d84450ae0db367780c3dd2e208fe4e6fe5565b8.<br>
<br>
Signed-off-by: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c&nbsp; | 16 ++++------=
------<br>
&nbsp;1 file changed, 4 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
index b339642b86c0..a64f20fcddaa 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
@@ -1246,22 +1246,14 @@ void amdgpu_dm_plane_handle_cursor_update(struct dr=
m_plane *plane,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(plane-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_framebuffer =
*afb =3D to_amdgpu_framebuffer(plane-&gt;state-&gt;fb);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *crtc_state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 address;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D afb ? plane=
-&gt;state-&gt;crtc : old_plane_state-&gt;crtc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *crtc_state =3D =
crtc ? to_dm_crtc_state(crtc-&gt;state) : NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t address =3D afb ? afb-&gt;ad=
dress : 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_cursor_position =
position =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_cursor_attribute=
s attributes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!afb)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crtc =3D plane-&gt;state-&gt;crtc ? p=
lane-&gt;state-&gt;crtc : old_plane_state-&gt;crtc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crtc_state =3D crtc ? to_dm_crtc_stat=
e(crtc-&gt;state) : NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc =3D to_amdgpu_crtc(crtc);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address =3D afb-&gt;address;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!plane-&gt;state-&gt;f=
b &amp;&amp; !old_plane_state-&gt;fb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4128FBB34A765E0DB78DAB7490FB2MN2PR12MB4128namp_--
