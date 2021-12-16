Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8839DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 20:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADFA10EDAF;
	Thu, 16 Dec 2021 20:12:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1900B10EDAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 20:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Awg8NT5gh7UFwPKpzeju3Y5Ch/E6yCiKmIX7foNVvanQ66gaUjBHtDt8O2uunIv0fQkhfy3E3sqbrQHjkZy+ekDoy0unvmy/JRqgSo79fLn1eA1hy6Nu9ngy2alDR0KZ0pxpsncd7qRuKR0VWqcYGLjFk+PBAdIXjUS1Pg77txIv7mnhaHSQjCOgYrzyh3lkgYsq6bKVsAjJSBmZO5pcb5jZ7Z7MRccsHIbkSra+IYhAZgVJigK8c8pJPN8qk4SYksGiSraqwVJIs7+jsdxBlQXlZC4JtiZPmmucd99C2Byl+8Ot6fzwJKyc4MuS7jIwhdZCMY2r7veMqab2GFSWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltDf22u5F7M+l0+plC8Vq3zCQBxOfAtWY6Yd2lKBd+E=;
 b=W8RF19PYmIHijmhhfYv3YsOHSbUl2p4XJnHpsfMm9TakGpY0kG7NUcBSP9HZJhcsEkH89PB2Y0vwlrwN3cF4XCG0FtKkUpfruaiHkr8y+vErQnEGrHyMi3lgZ3LqfuIWC/SFx7lqCmMfZsU0LtEOIrR2pWY0fzCmpn2YkqD1Eiv4qH25VQPHrbocWrdjPCkfu46gv/rAyiFZpHkBVz0or6Q5BGCxpz0Xz4beiaI9A95FBHPqYN4TNSMJ01P4IA7bHovrpYKKL1VulxDmMcPpLcy0m9Y4J0aU4RLGQHyR9qEMdDMzFksAvENIvA5PeqoRWEGU20FfBVtwkFVeG19tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltDf22u5F7M+l0+plC8Vq3zCQBxOfAtWY6Yd2lKBd+E=;
 b=Vj6OgwJFNwho/8LBrNUFOjuU2lKdcJCyR3pYcV7xKg6XZX0xhvpp+DF7ykcDb3U5N1GZ4RD1CCiXec2sb01nU6togK2PQMGxkmJu2AipWvzoFl+42gNKMNZXpj2Iq/iM6vnr4tuSA3Rw66A3SL+qeCthiPch4XwD2rh6X63EvAk=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 20:12:03 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Thu, 16 Dec 2021
 20:12:03 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, JingWen"
 <JingWen.Chen2@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Nieto, David
 M" <David.Nieto@amd.com>
Subject: RE: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init
Thread-Topic: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init
Thread-Index: AQHX8rUg1i1TEPBKpUWPxQELqOTNQqw1jM0Q
Date: Thu, 16 Dec 2021 20:12:02 +0000
Message-ID: <CH0PR12MB5372BFDA80F5FBEED48ECE87F4779@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
 <20211216194233.3839-5-victor.skvortsov@amd.com>
In-Reply-To: <20211216194233.3839-5-victor.skvortsov@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T20:11:28Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a3dfabb2-7cae-486b-840e-d74544ad0e8b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-16T20:12:00Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9c4ef836-6fd3-407d-ade0-501fa3e1133f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0543b080-d93f-460b-3fd2-08d9c0d05323
x-ms-traffictypediagnostic: CH0PR12MB5107:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5107BC1508C73361C019FDCBF4779@CH0PR12MB5107.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: us7nv8Q6xpD6mvKyBIxMfz+BJTc5//SR5zTRuJmkDWxZKopJ/D4GagXGqy+YDqWkQa4FqV+FZNR4h8cdvEzCLuAZfWyns5F5y9mm3ejwjLD3VXSzq/rDJHmq9C/Y7V/y+MmgaGnPciu/WldZWkzueCmgO+aSvLoxJwYA7LCG+TbNDys7p79z/A6KNwmdyRu9w0pRZPvlz2o7hcy+NWY+4uSBKubxRNnUzaDuZvRrPofvDdi0lktRjSzBeCASpki8mS5J6c2OtgQ+S9819kiUePeOopebD/c0Tl0UHMusD0vAfVeVj9k48d9TX2jKh02JryCWwUzELf+PxP/Ort5RKvrQidvtnzqIgx3Cw3clyiH9auU51sgY6QoNOBrjLpKumeZu147mI9heMg2AXE5UcMLpgEP/B9RmPuA+26MnlCmTmimgoxBv5P0N2thTkKX2w9W1pre0v58Z5lYRiMqGXVxuUI19toavptcp/Bg4KTVow7tkrxaTUt6wJXwSlH+6f1s9c0m4JQJsMhiZXl24SJ7a/7sbWiBTngFMvWdIk37eJANOVEdaAxv5ybrQ3QfRavx1LdeCfKoZo25VTMwAsj5YW596qwL+f3A01Mj8j9fa6CKniAX0kSl05q463WqRjocxga/B++/uD/7Vki6Dg9XYHG7Iu9jr/ZSCZsUs+PaQqlO6ZylTwzqDYcFBuEG0O9egJQ0rblimHxKO1qp+t4BfjwbqPw80NAE3hoSAU2I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(71200400001)(9686003)(38070700005)(6636002)(86362001)(66946007)(8676002)(921005)(2906002)(26005)(83380400001)(33656002)(64756008)(110136005)(76116006)(316002)(6506007)(66556008)(66476007)(38100700002)(53546011)(186003)(508600001)(52536014)(122000001)(7696005)(8936002)(55016003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CjiDU+VXd+wpQTC7z42c2i/95pl7gnQm1o5flHxE56bBtEn7erAJSm1GzVnX?=
 =?us-ascii?Q?00LJOKJYlO10nD0U14q7Yd6p5IrBu8NEYBEd2i+q2Jfs8kjqrho9eOxASV8a?=
 =?us-ascii?Q?VOETZZQkY3LKdd19krttvnpeemtUt6bFpYWf3xANM89j3mqjl1EZt2a/V0tD?=
 =?us-ascii?Q?9UHMDsndQ8yCKmtDaObFyjrF8bOdUgPFqzWV1E5EJOwqxQuLfMdQVbjGM2sr?=
 =?us-ascii?Q?zJzPHV1iPJMOuX4sc5REc0lLVND0rIOgHHxssSHWlIqQhiI4puZX/IxGd4w7?=
 =?us-ascii?Q?uxAJr79MNPdGC+nA62C4yCDeVVMll76Nbdj68hqtviMArxwwyavU4+QDN1zD?=
 =?us-ascii?Q?O2wEhUrYSGCGlR1lVpAdlNdW4vHStLoODv1ZcxAAsHEOwqoVU1drCKLM86H3?=
 =?us-ascii?Q?QqGlD6WwxpJK2nz9UGYVeqBybHqhg588h8ZcppfggukDSECTr/iSf4P96Jo1?=
 =?us-ascii?Q?9MY//P8S4FcAOIzP3boRlC2QujvTFj2gnN8pPkEvi9t/PRJPFaG8EWRXEjTm?=
 =?us-ascii?Q?pOK9lij3rQf3fiRV2xeHkH1ZGIMpXPdHsp7YRvZYQOmzwJDqIfKmEFJU7lVb?=
 =?us-ascii?Q?/zmuNYRs5mh95ca2VTMtX5e/FayF1iXPfi90mLC60U1iVnRgT+I6YBD8Q1t0?=
 =?us-ascii?Q?XhNID6N/fT7cjQFdbeGOgZPfClIBdYa2+MEKzMGvOEvPeUPKKDtXswSzi0gU?=
 =?us-ascii?Q?lHKJPpLEhAY9zOndiiysbf9ezF4ZJ3/A1i3sosnK0ABuK8hbI1j+FKDqN2MG?=
 =?us-ascii?Q?PaMlunDvgmlsqZv2IHnrbBeOFvXzBZ9qr17N+GzDy7NuNUFT118W1YrMHxmB?=
 =?us-ascii?Q?Oib2/4ADsgnlH58yqDxgCHd6ZmzrXW7LmrQ/DZoN7xS1/RVIe6GJqOoTl42w?=
 =?us-ascii?Q?nauexzdaH6hhHlHog/eTjTbS+A3KPGCZh9JztPUgxYCYGpvmquO1ES+fMkOy?=
 =?us-ascii?Q?toi3CiRVYllGimlnlq8JKj4IC3y0P3BV9iGzIEHep+17MURs7AEQ00MzWFBn?=
 =?us-ascii?Q?qFpPzYOAR8ONE2Rpb6JD+X9XRlj854zobjgt/W7GvfCEOFFrjUFgDYkCM6OK?=
 =?us-ascii?Q?fs6sV9ri5FzIueFVf2zwffbBtJz1Mr7paxjc+OBjE8rtI6dN6u+XDqp1WO/b?=
 =?us-ascii?Q?PFAlUN4iKPBICdfrEEStWLP3i597skDMcuxu9wIcSpTGgvd0Fi10Ucpqg4Tl?=
 =?us-ascii?Q?TfWa4jwD6EClFH9LyzpsnHTeP5owN9faZoAI0p4fXy08vcybfLKqgk/BBCuO?=
 =?us-ascii?Q?kLgnCkvOEMusb7MHRGJf4Gnqo82frqwL6N/V4lulCaChMRx6E0/V0xXWWCJF?=
 =?us-ascii?Q?Zmvab6huShgGA5ZaruPUrHllO3fUNqD+xbVJ+hxR9NHPn13fv4GcqJ8InN4w?=
 =?us-ascii?Q?7E7owQ3WSJVW9fWHa8eAWgupNE36++aqEhHyq5f29NW+1FPP5GfinWbuJc7j?=
 =?us-ascii?Q?fedVpUs8t8G1er6ZxjiqwvpWqEBGmJBE0aFW9xtmODqZzw8jem1h5L3+cTXo?=
 =?us-ascii?Q?c5PLiAfsRa/48qeivpgcqd5R80QSqrZheOBTvBWMtYwB2Uzh33PS2zRjJ0wu?=
 =?us-ascii?Q?AwR5hmp8uLf353unPLgIRjUUx+XRoqVOKgK6p0301yUL3sPdDw+propjdumL?=
 =?us-ascii?Q?vIbAuUV6H/8lPahWljs8yHk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0543b080-d93f-460b-3fd2-08d9c0d05323
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 20:12:02.7616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /76cQEz2HiJQZM2lovs/XG8Zaow5PdXtmrbQ/+xgyiU4D49ssLBh4vQSa6hzuW5P4r711h8f2c595d7Y6RMvAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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

[AMD Official Use Only]

Reviewed by: shaoyun.liu <Shaoyun.lui@amd.com>

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>=20
Sent: Thursday, December 16, 2021 2:43 PM
To: amd-gfx@lists.freedesktop.org; Deng, Emily <Emily.Deng@amd.com>; Liu, M=
onk <Monk.Liu@amd.com>; Ming, Davis <Davis.Ming@amd.com>; Liu, Shaoyun <Sha=
oyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chen, JingWen <Jing=
Wen.Chen2@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Nieto, David M <Dav=
id.Nieto@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init

Driver needs to call get_xgmi_info() before ip_init to determine whether it=
 needs to handle a pending hive reset.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 6 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 6 ------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 5bd785cfc5ca..4fd370016834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3576,6 +3576,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
=20
+	/* Need to get xgmi info early to decide the reset behavior*/
+	if (adev->gmc.xgmi.supported) {
+		r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
+	if (r)
+			return r;
+	}
+
 	/* enable PCIE atomic ops */
 	if (amdgpu_sriov_vf(adev))
 		adev->have_atomics_support =3D ((struct amd_sriov_msg_pf2vf_info *) diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgp=
u/gmc_v10_0.c
index ae46eb35b3d7..3d5d47a799e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -914,12 +914,6 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 	}
=20
-	if (adev->gmc.xgmi.supported) {
-		r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
-			return r;
-	}
-
 	r =3D gmc_v10_0_mc_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 2b86c63b032a..57f2729a7bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1628,12 +1628,6 @@ static int gmc_v9_0_sw_init(void *handle)
 	}
 	adev->need_swiotlb =3D drm_need_swiotlb(44);
=20
-	if (adev->gmc.xgmi.supported) {
-		r =3D adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
-			return r;
-	}
-
 	r =3D gmc_v9_0_mc_init(adev);
 	if (r)
 		return r;
--
2.25.1
