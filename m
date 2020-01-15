Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677EEC33CB3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 22:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3870A22522
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 22:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yWLdtTQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3870A22522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13B36EB74;
	Wed, 15 Jan 2020 22:40:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9E76EB74
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 22:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeB1nGcoFC72yGtD1cPrRNdF0pWAOfMiXIxi9CE3eIh8lYmjnkX8GZChv8+d3LmSHNlpCEKIgcP1o2pYq4OhzB++vX/EwaOYrDt2oLljdzXQZvomU5frzl2zXGLdTBdU3g8pExBD3btPlkWZ9b//+6rlQ5ZHXozqdN+laB+cEqfF0emynCpLreH84MDRFdj3qGaYIbCyUaqxMelIzvViDuN/JTi3DUDhnOz2Chhv+IWicZRF6+KbHDjDh54Wqm4xbGnw4ifC/5eb75uaa0QVh/KaC1j9vFooUVqu6s7kZZoh2vWIv17KprtP/L4C1tZSnOHc0L+efM5YbaXNzTHoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFuZ3mX+LxRCj+kLRBSdU8sd19HPSw+CFYk2oeDR0nY=;
 b=Pt9ZuiiUJh0Dx6YgofuSWCAfkh+4scMAewm4ujR7XnMDzenNOyzIdAFcgj9uj/Zx+SGolnB+9HLGK6EXZP91xlqftR4l1ZLmga4C+Rg/SWKOIbQ2AHxPKj1jVd3H3nqEW7LRZUQEX5IHdu7oMG5J7QpMJf7y4sc2gAthm0l/GlDpxs/4Z1Ve/1aFTHd0jRfs6wC5nX0cOjk0HxTiPtJWFY8o0fV+vQGR5bY+/NVjAewlKwUvQq++QaSjKU3cTNd3Tho34OCqj65b5MevYcFBo4PDEMn8GLN+E/OWPEvWBS96s98qxXhRREdXb99+GFhaPWjB+hUtwikruQ+qXkMBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFuZ3mX+LxRCj+kLRBSdU8sd19HPSw+CFYk2oeDR0nY=;
 b=yWLdtTQZqK1mONJz06w6PJvCVGhyLpxI7pvLo+/3MdN6Ojdk6qwCxl5j5uv53L8NVxk4ZicwfCTqTHYij5KQmsVx3RJZdOkBYvRutSXY9PptlKpui/6O8mEHTJ9hfyKvri2nMlLxFeS06BAQwCHNED3x6KzIXQ3xUR8Z/naMH7g=
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3020.namprd12.prod.outlook.com (20.178.31.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 22:40:02 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 22:40:02 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/vcn1.0: remove duplicate defines
Thread-Topic: [PATCH 2/2] drm/amdgpu/vcn1.0: remove duplicate defines
Thread-Index: AQHVy/FlgmY08Bl5GU2PLopOJ7tRu6fsUUDQ
Date: Wed, 15 Jan 2020 22:40:02 +0000
Message-ID: <DM6PR12MB3914270CA4F7D77B64710716E5370@DM6PR12MB3914.namprd12.prod.outlook.com>
References: <20200115221544.1712687-1-alexander.deucher@amd.com>
 <20200115221544.1712687-2-alexander.deucher@amd.com>
In-Reply-To: <20200115221544.1712687-2-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
x-originating-ip: [2607:fea8:a200:445:7101:5c38:8381:4a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5e790e9-7d69-48cc-6366-08d79a0bdc03
x-ms-traffictypediagnostic: DM6PR12MB3020:|DM6PR12MB3020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB302092F08317B78A32B894D4E5370@DM6PR12MB3020.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(186003)(53546011)(6506007)(966005)(110136005)(45080400002)(33656002)(52536014)(86362001)(55016002)(66946007)(4326008)(5660300002)(2906002)(66476007)(76116006)(66556008)(64756008)(316002)(71200400001)(81156014)(66446008)(8676002)(81166006)(8936002)(478600001)(7696005)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3020;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKI+F6RxsKt5qPMpo5OUA0Ncq1QkqXrV7vg8RQt5vFDAXrVKYCsWRRWw4BI8SQa4J67gBi1+fbMI0MJSVpJCVw/TVnkkRvfFoHALe+z46gu/CvvRkySrtf+F3fb4pciA7Llacp4LowIE7Fq1wQfRtz+/EOu2ZPtEMcxXBtk+oQJYF7Fz/b/bX6y1EOwrn/tqwfKYhTV1T1Nl2a63tU2sjv1GyuGThCNSoS8JgWWIZ57fQ2viSbDXSbsOiirQHTua7Cv9aBw0if4vC1TUBVmQP6EcAZw0csp1JmVXrD1t9I8BYbAQBNbmTrei5famSqR6+v6AAWmOR4xv1O8dRFNFJVP3WfXLoBBnZvyWd2PrplwffX8mztaFJsFL7x+kUGqL2KqnQ7hmGcUVq4hsS0q3thtR5Kw6NfZbGTpOnIHLE2aHvDijYIHLoUQRSWfMbtZY+kBpMCshdTl/ZNc4WXFYFMLZj4GtxBfNgK59MhlPF3c=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e790e9-7d69-48cc-6366-08d79a0bdc03
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 22:40:02.0583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dcLa/Fs8WPwbg67dfIO2oS5SbFve+i99NOfWlQGDyIcG0Ce2xsS2M7q66RQIAlF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The value are different between VCN 1.0 and 2.x.

Regards,
Leo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: January 15, 2020 5:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn1.0: remove duplicate defines

These were added to amdgpu_vcn.h so remove the duplicates in this file.  Fixes a warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index a70351f2740c..2b9e3098d4e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -39,11 +39,6 @@
 #include "ivsrcid/vcn/irqsrcs_vcn_1_0.h"
 #include "jpeg_v1_0.h"
 
-#define mmUVD_RBC_XX_IB_REG_CHECK				0x05ab
-#define mmUVD_RBC_XX_IB_REG_CHECK_BASE_IDX	1
-#define mmUVD_REG_XX_MASK							0x05ac
-#define mmUVD_REG_XX_MASK_BASE_IDX				1
-
 static int vcn_v1_0_stop(struct amdgpu_device *adev);  static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);  static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Cd684fdd7f88f4246831608d79a088016%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147233724222499&amp;sdata=jFi5Npjg6nXtQlA5JEu3dHnjiKHeBZfOWbr2KBrqYI0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
