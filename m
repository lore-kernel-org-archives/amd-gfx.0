Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10EFC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 14:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92820613AB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 14:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92820613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2206E1B3;
	Tue, 13 Apr 2021 14:42:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C90C89C21
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 14:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S84LT67QnElx5KIop7UWVA4o44GALpzCD90BNJ+zamR1e1UGpi32MZGGldotmS7YJ+oJO4y/TdC5CpD9mm9lROSDRBOV34bApEp+uOA+M9ynsGaCOeGsbCGLG+loxwORF3jizue4UMAiL6rb8Vgr+MNfC7w57iQPSDliM5v8TFlWdlX5aj34yJzF5p5T84SIujiuhh+DKA6oJ4KmEu1ZXvm2B/mxLnCNIMLVMLQBxP5edNqtt1fO2Qq+zk+k6LCsbgq6YVHsfhPtsUnj/ZqJ3MPfxby82KknTLlUDGGn9VgZKKNKyhvsCuLwgFNAun6k33KTCVyrBP98+IEXNN1OCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KvoAPOy6RKATXNMnw9SLYJ8N0kPCdGjKywlZ1Nt+Ao=;
 b=MzkP4uo5qEzWCuF+hMi+dqDuJRKWzaAMjaOz10i0tgZtI4xUHObMHEty3LGwPoBQQHmVlMeIXRYOTv4Qv3KHEPVpIpLljTaf9dzebip+3wG0cVlUIBkRBqWuwuL2K3xA+p3K6Rh5F31lPplmyvRuVqK21BcTDYuzN3hFhz/oQNLI81IBWfn4uPlNvfvvYQPc9yA+jpTIcwJtwmrUnQub/ZZCp99irbIf8Vm74AJLehJK3WIfAd122q8dBTk5a5xzGVNO0RLzU7+yFdHcIdki6WsVnyG0bEx7+4RNUNAf6fhZH3EwjV1aKh5WONTcKMEX6ECDyEhp3Ay30jZaCGXR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KvoAPOy6RKATXNMnw9SLYJ8N0kPCdGjKywlZ1Nt+Ao=;
 b=ZnOweQLNf3IngIJt/51FxFbbUk1nPeJKMEL7wtK3QMRdi/xovQgHjIGr5qZiBeACKKq8V0E8AN41ErU3CdCJxEU6eIjMucDiYXNwrg6e95lsbDmDnvleFfho+gqUC/zPa6m4Ofmq/p/i88vwhIyrbLoF6ZBSb7ibaq0X/q+B9uQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2435.namprd12.prod.outlook.com (2603:10b6:207:48::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 13 Apr
 2021 14:42:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 14:42:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: correction of ucode fw_size calculation errors
Thread-Topic: [PATCH] drm/amdgpu: correction of ucode fw_size calculation
 errors
Thread-Index: AQHXMFtlQns6Pdsx/0eK1P78m4nuQaqyhW8h
Date: Tue, 13 Apr 2021 14:42:07 +0000
Message-ID: <MN2PR12MB4488855CB194EC60EEB9FC2FF74F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210413115119.15962-1-kevin1.wang@amd.com>
In-Reply-To: <20210413115119.15962-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-13T14:42:06.801Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a2fa782-2fc4-4257-6354-08d8fe8a5003
x-ms-traffictypediagnostic: BL0PR12MB2435:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24350745FDDC76CF1A4AB499F74F9@BL0PR12MB2435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DoOd1uouWnKBeQvPFAVQcF2krvG9q1H0AQpweLMcqHpw2mpHGCeSYpAUKB+6gfERARdlJFFrjsUl7Si+9kLoSKxl29Bqgs+XJyvQXNALhIXeN886GTfC0WSlSiPK5bv925hceoI4KfFBXR9Fs8k0vT1mHM+kGDSEMaXlpY0zTZNxSiLNBY8Udep4Olxdu1YWB1OjyRj0rQDAk+n4nY/6KVameicBo0c1/1BB04e90Xr1P5c/r/9tZPlU765tzXQvlzNh8K7LX6KQN7Q4ErHWnTnuks1xX+Pi5Yloy1I5KJOs6Pn0LbRaROST/1aKfqkDpV0F6B9sLaA6PbvIU22ranYht2pL6EwlPlVUuqnTa1dx2AfnkIeh5TfFWkkhuKiUWg5vUsNdEvfzZ2ZR7TPcY/OJ2XYQK4BT2CVRUXTjUZWYbfgdfJrOM5wt51/pzpMj0p4PO0KsT15AVPAGLycgSZINEo8SNTJlg/D3v6wJharciuz/wXJ5pyG42R1qLRm/0Jm9HCXydO8oFi5eZ614LIj3SbG4qt19b3xU4CMXGOdDglrwgFXEvIx932LgDJLzR/8hMyQ9h+kAz4qj7qFDVFa8EOvyhuH5sE6B/cBaau2IS8aBiDrrP+J8pMM0b6qeXLxRvXVj9sRlt9ce55Depg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(316002)(53546011)(186003)(26005)(9686003)(6506007)(2906002)(66946007)(966005)(52536014)(8936002)(8676002)(7696005)(64756008)(45080400002)(110136005)(66446008)(66556008)(66476007)(478600001)(83380400001)(55016002)(86362001)(71200400001)(38100700002)(5660300002)(76116006)(19627405001)(122000001)(166002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uVneeXnRbzhzK6EX5yVQhefOrD0/Cgf7s8Bd8QOEKqhcG0W1StL57UzrOoJJ?=
 =?us-ascii?Q?W9YPcydJ1VTfp0aXIBWm3vu1pf7aO15L//GhiLydhYpZLSxKwxitlq8lmi8E?=
 =?us-ascii?Q?HkaznRcEoypGaIgpG/GE/qtMMETFUBL3LybMFSasSow0cVfw/euUeG8gMdGN?=
 =?us-ascii?Q?IdC1Gd8d2Vk+1MMYUHyLtSeW5KPbdV/1c5503Z8ThSNj6nlusAoOXzpxecwJ?=
 =?us-ascii?Q?fRpmv1ssiMQ4jMMokRYlXDu76k8nNA0PfFrwIhS2xvpfl2K7UlLxf584chD+?=
 =?us-ascii?Q?yU/Se44Kulm26LHruS7LvOT4F/s1qfVXW73gK2XyiZB8F6G/b7BIy293U7HK?=
 =?us-ascii?Q?opxRR8RHuCSqYliLCaZ1nA7C/4OxIrvbdXruyM4J2QiEg4QTzUcseLYgMIrl?=
 =?us-ascii?Q?OAjERhIex/7DXvwyJYSI9IONtFD/tmF2qfGQc1R+n8K6vvDUttSr7/klGC3L?=
 =?us-ascii?Q?CMWdODuMYBwsdGXkQwyrIt17v4bVzAaSW4Zfrpn3PfPx8fWcuhEJziA0LOe/?=
 =?us-ascii?Q?/CUvF8wN3d2gIZaHKSZZo53KM48lj6PSXzgkYX/AH3Hm28WmKeQwa6cEr744?=
 =?us-ascii?Q?Z8j3w3W+OO07WY1q3jDMdYqmHR0FF7n1eEow7yBIAdneK28GBKLlLV560fxB?=
 =?us-ascii?Q?P5A2OevFr2uspl2NUT/Y0fly9Y+gGBxwLnE0eghzYB2+2K0C1TtzEcoe2arh?=
 =?us-ascii?Q?GIPa/UxjlE0u2XwbVo6aYVaH31uYl8Cq55nSafVD8r9NQSTQuyPGmA0+3Mxd?=
 =?us-ascii?Q?3J4S/iYOzg1htpZwba08sOWRnoiPNRznRZozcNot52uV4dkDFy61FK5qyXXD?=
 =?us-ascii?Q?dPH76rx0NqKGpdWjryORXlIXBz4So0QmuTHbjwlqxRqZ9GWF2uvpDoknaNhB?=
 =?us-ascii?Q?8ZlEBIS9/xwUEeaJ0I5oghjISnrLFQSMBTEXUKtonoGZE64Z36EStTdTzKF2?=
 =?us-ascii?Q?F3/7Q8+hwOBKiDP8dOwZEErcbEPXTrn6I1mdN16cdUiXSCJDmenJEQBU9yzP?=
 =?us-ascii?Q?BSQNHafJ8c23XQxsT7zKj2HvcZIy7RrwXRF8+OrkNLzHDDDG7rEasE1R4zwe?=
 =?us-ascii?Q?dYknR9Wjz4xyWk6LKkI+v42Tq78wMtO7bCaaO6AmrXAePKrOF/KMLhW2XYWg?=
 =?us-ascii?Q?Nb17HQujqX5BnH9pxqCfneShRkRf7wsq7lakCrtn61m/Kb2/W4ahox9w8+3u?=
 =?us-ascii?Q?YljGOLNTFcBRUdVNV5U0OR14uYdwaz0p030duT18WXwLthU6A7hHYpliTXfo?=
 =?us-ascii?Q?mKK3Qr0Ro3JAaEKCwDOnyhiNxPmUa3X3Bto3cndDsMp1+xuepPPUfFnArhPr?=
 =?us-ascii?Q?dkTY7UHgOy3O6VSYv79/si1s?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2fa782-2fc4-4257-6354-08d8fe8a5003
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 14:42:07.3410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olG/KeCoi2ilk1NXGk5BYQIArfl64XB05v4Tzdb57mn2zO7ObCfvPfkGgo45LqQUVPrtCKMcwDA2fURTr36bRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2435
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
Content-Type: multipart/mixed; boundary="===============1072724355=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1072724355==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488855CB194EC60EEB9FC2FF74F9MN2PR12MB4488namp_"

--_000_MN2PR12MB4488855CB194EC60EEB9FC2FF74F9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kevin Wa=
ng <kevin1.wang@amd.com>
Sent: Tuesday, April 13, 2021 7:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: correction of ucode fw_size calculation errors

correct big and little endian problems on different platforms.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 85a6a10e048f..0a00a7cc8eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4354,7 +4354,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *a=
dev)
                          le32_to_cpu(mec_hdr->header.ucode_array_offset_by=
tes));
                 fw_size =3D le32_to_cpu(mec_hdr->header.ucode_size_bytes);

-               r =3D amdgpu_bo_create_reserved(adev, mec_hdr->header.ucode=
_size_bytes,
+               r =3D amdgpu_bo_create_reserved(adev, fw_size,
                                               PAGE_SIZE, AMDGPU_GEM_DOMAIN=
_GTT,
                                               &adev->gfx.mec.mec_fw_obj,
                                               &adev->gfx.mec.mec_fw_gpu_ad=
dr,
@@ -5769,7 +5769,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct=
 amdgpu_device *adev)
                 le32_to_cpu(pfp_hdr->header.ucode_array_offset_bytes));
         fw_size =3D le32_to_cpu(pfp_hdr->header.ucode_size_bytes);

-       r =3D amdgpu_bo_create_reserved(adev, pfp_hdr->header.ucode_size_by=
tes,
+       r =3D amdgpu_bo_create_reserved(adev, fw_size,
                                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
                                       &adev->gfx.pfp.pfp_fw_obj,
                                       &adev->gfx.pfp.pfp_fw_gpu_addr,
@@ -5847,7 +5847,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct =
amdgpu_device *adev)
                 le32_to_cpu(ce_hdr->header.ucode_array_offset_bytes));
         fw_size =3D le32_to_cpu(ce_hdr->header.ucode_size_bytes);

-       r =3D amdgpu_bo_create_reserved(adev, ce_hdr->header.ucode_size_byt=
es,
+       r =3D amdgpu_bo_create_reserved(adev, fw_size,
                                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
                                       &adev->gfx.ce.ce_fw_obj,
                                       &adev->gfx.ce.ce_fw_gpu_addr,
@@ -5924,7 +5924,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct =
amdgpu_device *adev)
                 le32_to_cpu(me_hdr->header.ucode_array_offset_bytes));
         fw_size =3D le32_to_cpu(me_hdr->header.ucode_size_bytes);

-       r =3D amdgpu_bo_create_reserved(adev, me_hdr->header.ucode_size_byt=
es,
+       r =3D amdgpu_bo_create_reserved(adev, fw_size,
                                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
                                       &adev->gfx.me.me_fw_obj,
                                       &adev->gfx.me.me_fw_gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 06811a1f4625..831398e15b84 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2013,7 +2013,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *ad=
ev)
                  le32_to_cpu(mec_hdr->header.ucode_array_offset_bytes));
         fw_size =3D le32_to_cpu(mec_hdr->header.ucode_size_bytes);

-       r =3D amdgpu_bo_create_reserved(adev, mec_hdr->header.ucode_size_by=
tes,
+       r =3D amdgpu_bo_create_reserved(adev, fw_size,
                                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
                                       &adev->gfx.mec.mec_fw_obj,
                                       &adev->gfx.mec.mec_fw_gpu_addr,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 6274cae4a065..00610def69ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -174,7 +174,7 @@ int smu_v11_0_load_microcode(struct smu_context *smu)
         hdr =3D (const struct smc_firmware_header_v1_0 *) adev->pm.fw->dat=
a;
         src =3D (const uint32_t *)(adev->pm.fw->data +
                 le32_to_cpu(hdr->header.ucode_array_offset_bytes));
-       smc_fw_size =3D hdr->header.ucode_size_bytes;
+       smc_fw_size =3D le32_to_cpu(hdr->header.ucode_size_bytes;)

         for (i =3D 1; i < smc_fw_size/4 - 1; i++) {
                 WREG32_PCIE(addr_start, src[i]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0864083e7435..d7ea8215d7dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -149,7 +149,7 @@ int smu_v13_0_load_microcode(struct smu_context *smu)
         hdr =3D (const struct smc_firmware_header_v1_0 *) adev->pm.fw->dat=
a;
         src =3D (const uint32_t *)(adev->pm.fw->data +
                                  le32_to_cpu(hdr->header.ucode_array_offse=
t_bytes));
-       smc_fw_size =3D hdr->header.ucode_size_bytes;
+       smc_fw_size =3D le32_to_cpu(hdr->header.ucode_size_bytes);

         for (i =3D 1; i < smc_fw_size/4 - 1; i++) {
                 WREG32_PCIE(addr_start, src[i]);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C3992236102744469006b08d8fe728650%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637539115132533430%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DpQO64zy%2F99rHa7Vr9uZd%2F9q04R6DDPL%2BnOiw%2Fo2oScY%3D&amp;reserved=3D0

--_000_MN2PR12MB4488855CB194EC60EEB9FC2FF74F9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kevin Wang &lt;kevin1.wang@am=
d.com&gt;<br>
<b>Sent:</b> Tuesday, April 13, 2021 7:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: correction of ucode fw_size calculation=
 errors</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">correct big and little endian problems on differen=
t platforms.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 8 ++++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-<br>
&nbsp;4 files changed, 7 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 85a6a10e048f..0a00a7cc8eaa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4354,7 +4354,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 le32_to_cpu(mec_hdr-&gt;header.ucode_array_offset_bytes));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_size =3D le32_to_cpu(mec_hdr-&gt;header.ucode_size=
_bytes);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev, mec_hdr-&gt;header.ucode_s=
ize_bytes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev, fw_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE, AMDGPU_GEM_D=
OMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.mec.m=
ec_fw_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.mec.m=
ec_fw_gpu_addr,<br>
@@ -5769,7 +5769,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; le32_to_cpu(pfp_hdr-&gt;header.ucode_array_offset_byt=
es));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_size =3D le32_to_cpu(pf=
p_hdr-&gt;header.ucode_size_bytes);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev,=
 pfp_hdr-&gt;header.ucode_size_bytes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev,=
 fw_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;gfx.pfp.pfp_fw_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;gfx.pfp.pfp_fw_gpu_addr,<br>
@@ -5847,7 +5847,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ce_hdr-&gt;header.ucode_array_offset_byte=
s));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_size =3D le32_to_cpu(ce=
_hdr-&gt;header.ucode_size_bytes);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev,=
 ce_hdr-&gt;header.ucode_size_bytes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev,=
 fw_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;gfx.ce.ce_fw_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;gfx.ce.ce_fw_gpu_addr,<br>
@@ -5924,7 +5924,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; le32_to_cpu(me_hdr-&gt;header.ucode_array_offset_byte=
s));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_size =3D le32_to_cpu(me=
_hdr-&gt;header.ucode_size_bytes);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev,=
 me_hdr-&gt;header.ucode_size_bytes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev,=
 fw_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;gfx.me.me_fw_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;gfx.me.me_fw_gpu_addr,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 06811a1f4625..831398e15b84 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -2013,7 +2013,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(mec_hdr-&gt;header.ucode_array_offs=
et_bytes));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_size =3D le32_to_cpu(me=
c_hdr-&gt;header.ucode_size_bytes);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev,=
 mec_hdr-&gt;header.ucode_size_bytes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(adev,=
 fw_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;gfx.mec.mec_fw_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;adev-&gt;gfx.mec.mec_fw_gpu_addr,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 6274cae4a065..00610def69ea 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -174,7 +174,7 @@ int smu_v11_0_load_microcode(struct smu_context *smu)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =3D (const struct smc_=
firmware_header_v1_0 *) adev-&gt;pm.fw-&gt;data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src =3D (const uint32_t *)=
(adev-&gt;pm.fw-&gt;data +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; le32_to_cpu(hdr-&gt;header.ucode_array_offset_bytes))=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_fw_size =3D hdr-&gt;header.ucode_=
size_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_fw_size =3D le32_to_cpu(hdr-&gt;h=
eader.ucode_size_bytes;)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; smc_f=
w_size/4 - 1; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_PCIE(addr_start, src[i]);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 0864083e7435..d7ea8215d7dc 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -149,7 +149,7 @@ int smu_v13_0_load_microcode(struct smu_context *smu)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =3D (const struct smc_=
firmware_header_v1_0 *) adev-&gt;pm.fw-&gt;data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src =3D (const uint32_t *)=
(adev-&gt;pm.fw-&gt;data +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(hdr-&gt;header=
.ucode_array_offset_bytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_fw_size =3D hdr-&gt;header.ucode_=
size_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_fw_size =3D le32_to_cpu(hdr-&gt;h=
eader.ucode_size_bytes);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; smc_f=
w_size/4 - 1; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_PCIE(addr_start, src[i]);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C3992236102744469006b08d8fe728650%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637539115132533430%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DpQO64zy%2F99rHa7Vr9uZd%2F9q04R6DDPL%2BnOiw%2Fo2oScY%=
3D&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?ur=
l=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;=
amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C3992236102744469006b08d8=
fe728650%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637539115132533430%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DpQO64zy%2F99rHa7Vr9uZd%2F9q04R6DDPL%2B=
nOiw%2Fo2oScY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488855CB194EC60EEB9FC2FF74F9MN2PR12MB4488namp_--

--===============1072724355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1072724355==--
