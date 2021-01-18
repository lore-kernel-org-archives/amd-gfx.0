Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB29AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819E62137B
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 01:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819E62137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2630E89C1B;
	Mon, 18 Jan 2021 01:29:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB6689BCD
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 01:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aesrhcW921Jzo/yUiqihtTvQhPZG7b7nhwQ9Lwg21fW2X6iQpEDEg/mXvYbfI58FfuIbqt1c2syeGuo0EmkoYUAWEmXJB4zQmsLZm4Pos5n3fKNJRfxHFot4QEhhL/f0DDPWyTIQcVlM5VNvIcGIOhFVTJvBtnTYduX4ElPxSjPU+ko87N5IHD9KfFvFlFXKzOO0JvPz971OZCxoui2II/xHpY1U+bp3RIb0qK7JbWlirYXLN82oPt+kys51ysYvqWFW8JItmSxspJfWjD4HRokBFrDSdIGoc5wwiYzBU0G8LkhH0ignBxDov7JgIAnzz4Cowdl+OJFfbnPig2C92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SafDDwVcCWNwxJXBOzjMBrYGZ5JKNSaEM6VEF6lx4tU=;
 b=iPs/hHMuq06SSWZcea4bBl80U8fEtk42P9oWyzHWUJ34vTuTpFKiB+yWOOrtkVkbApnkkplOgmp/M1XKbn0zCA9HK1TGQ1mTv/ifQZTRSam4JERQcg1KW7TlqaSfkrZ0D3UFxETI/tLrp+oqJLGb+XbwCrzWKbx2SqSUG18N51adPaocVei/dKPnV5Js+y97NpGHhmgMTVxPuWpC73YFnbnvDmS7NU9Clq9frWzITZGueMMOHeVhGrvLwT/cVWFFxEZbvRbqNwbQz8wzbhfA3ubp7SVfOIAVDGw9vloCIBMKKf8o7YLomPiY+Z3zrPBv7u24Zc/OG1Ns4nxowu9byQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SafDDwVcCWNwxJXBOzjMBrYGZ5JKNSaEM6VEF6lx4tU=;
 b=0wGTefq1lHX7JGSodHSkVPEqnliLNx0YXyrWgPyEc54toZfMe1AcJUyKn1r0fD4gH46uREQaAfKACLMdvQcUIRH4Tpw25SdrkW/isb0gBqoJAlF4tQmme1lN1MjrUC3tVoAxuaG/41BwX4SWqNXmQPkZcESJ6DRsrVGWRuyAIYM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Mon, 18 Jan 2021 01:28:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 01:28:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Thread-Topic: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving
Thread-Index: AQHW6yGcm9atOe6/vkOQ0S7pfVohraooyESAgAPTQ9A=
Date: Mon, 18 Jan 2021 01:28:56 +0000
Message-ID: <DM6PR12MB26199710314ABD9872F49D78E4A40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210115093406.389563-1-evan.quan@amd.com>
 <BY5PR12MB4885E2F10BADE35CE3B0FA39EAA70@BY5PR12MB4885.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4885E2F10BADE35CE3B0FA39EAA70@BY5PR12MB4885.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7c310fcf-a3e9-4e89-bbb8-c090dd58d7c4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-15T14:40:32Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43dd5f01-ee4c-4b80-5c3d-08d8bb506d46
x-ms-traffictypediagnostic: DM6PR12MB4436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB44365770617E0AF40BCED197E4A40@DM6PR12MB4436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUxIn/4drCu7BPjLRibipbVEfxy96eEA8REJbuXZQSb/Un5+TmTa/LyInOEzAdpWKn92LjQ2iyd9GL9ru3aWeHhFlppVpOeP89HiRkq/AmeWGN2GBSyfHxgORZKdyHctBMG/vnno0HQ+EIzrm10TejExfu0suqrF2UGRQl+XfbnsvXTdsOpjonzh0ZN6BW5yAnDEl+vo+yiDuVUoNA9Uu+DsvKHLsEHQQ8wolw+UQO88fAG9qLVwekGfgoX8rupbexeDLNFiwtVNK+pkrK3I9+FHlQwCPG/3FFeFfYDqsCuY3g1PGgdh20i3Hk29Yjg7Ax+n6gCuA8EQ3biJrcZqdXKT7MBQikDeIoBlg4/7ie9AAZaBAjALcM5eFsh6oyKsMaEB0lI+CBEQkgVt7Jb2Xj5eev1BA4jhinIGc5VRdFsgVgZjU/6YAtKSf7DYQYGKlqE1Tklt9UFNOLejRK2iWV4i/KiJJ8OnQwnU3U+AEtZpXP46D9CZ7eDJWFbZmaFL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(53546011)(6506007)(52536014)(84040400001)(8676002)(45080400002)(8936002)(76116006)(66476007)(26005)(66556008)(7696005)(66446008)(64756008)(4326008)(478600001)(33656002)(55016002)(110136005)(186003)(316002)(66946007)(2906002)(71200400001)(966005)(9686003)(83380400001)(86362001)(5660300002)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kPx3DRDRAjyEBRsE/i1YEemTdcb6IGmUKqs2shwHPH5Fq/mxYNXYwor9/fbF?=
 =?us-ascii?Q?q1RhhubwLy3quPnx1jYs/yrM9ReRvQ2UTLJ0uFPFc1tnQGF81HWYJh005otf?=
 =?us-ascii?Q?A2og6MsOAQEbcP9JCTptUYjjiJvhOKqf1eqV1qqQhJrbKwPTCgnst0kKxs+F?=
 =?us-ascii?Q?69CScnLXeDM10jcr7HthER6/ClKa88j35351D2fYQyM1mPaIBGT6V5hWr6jY?=
 =?us-ascii?Q?HLnn1j/cL8lHKwhTVPn8AC3yWDidCG5SC/e+PzBbhBMF11jMM5Jb6derLAuB?=
 =?us-ascii?Q?CxKiTHrV0fq5xeBu316bfNOWqPdVZoKOpfc6OF9W8d3FLoSGsz673cwq8Wom?=
 =?us-ascii?Q?saqi6uG/jXQQP3UotX9vXgcw3uz2ZSXdYY8nBiMaKxfgfBxf0GJf9qVd5pbz?=
 =?us-ascii?Q?ZJ94tbRypSM16AQOjR4jwcPTM2HgPPRCp6sQK5VX4CWVOG9PB0dv/UDIn0K8?=
 =?us-ascii?Q?62q/cyyPui+S/VXW8TnixCtXQ+9QKoMNPTsZazqqQ60lfvN96YD9KGtr548c?=
 =?us-ascii?Q?0A8atJwjMoqXR3wpNwMCH4h5Qq+IPilKN5rAlsKAaY9ZUePojiFmM9f43mBS?=
 =?us-ascii?Q?lXTFYSRyAD8j4hoE06V0CTGX6B0si03QEX06wpDALuCAeyFThuNwH6lA8VXc?=
 =?us-ascii?Q?Yqzi7uNxVWkpLU1gr8aNrBA9JLucYfLp4jpJobQbLCJs6zzXNc5JS6CJ3fBS?=
 =?us-ascii?Q?M27ntGPFNf9yVx5rkgFKbmU5VI7XLnV9f57mCFSZLOcMcSWlBy1Q3hClMpb/?=
 =?us-ascii?Q?5sLb4vjCO8Hk6dypX4XSz+ljaWONPt8avloWqP23fKlNhf1NeImQb3gQrrse?=
 =?us-ascii?Q?/3C5zSM3rYLc26TBQ11UCJx0/+P6k87Lz8m3eWz1HT/Kn3jXTHimIR0k+wqX?=
 =?us-ascii?Q?0A8OFd3b9XeLOcjH+2+jqeF6ilwZ1RnXWznToNFd5keiKnq+h3avz/NsuKDG?=
 =?us-ascii?Q?hpqbY7BDCsZ5WNTXadfeTdDZOUdWEtpIjeRzr75T7Wg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dd5f01-ee4c-4b80-5c3d-08d8bb506d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 01:28:57.1324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZplA3/ZE9SolJ5BOuzvfoVvCG3XBSsJ9R2FYhnGs+PgBVtMXFyQxF7AjRatGM9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

[AMD Public Use]

This will help gfxoff related issue debugging. Similar implementations were already added for APUs.

BR
Evan
-----Original Message-----
From: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Sent: Friday, January 15, 2021 11:01 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving

[AMD Public Use]

Can you help explain why we need introduce such a callback?  Seems it has presupposed pmfw's internal Implementation.

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, January 15, 2021 5:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving

Support Navi1x gfxoff state retrieving.

Change-Id: I57aa506b82dc122bbead708c580a4720e536cfce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 13de692a4213..2857f1bf4e9a 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -287,5 +287,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,

 void smu_v11_0_interrupt_work(struct smu_context *smu);

+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..93a3b6b60c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2482,6 +2482,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {  .get_fan_parameters = navi10_get_fan_parameters,  .post_init = navi10_post_smu_init,  .interrupt_work = smu_v11_0_interrupt_work,
+.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };

 void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..50566c613971 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2127,3 +2127,27 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,

 return ret;
 }
+
+/**
+ * smu_v11_0_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: amdgpu_device pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu) { struct
+amdgpu_device *adev = smu->adev; uint32_t gfxOff_Status = 0; uint32_t
+reg;
+
+reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0); gfxOff_Status = reg
+& 0x3;
+
+return gfxOff_Status;
+}
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C72d2ceab33474d94460908d8b938c75a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637463000820920597%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3WeEJ8EjgUYyA%2FAF7r30%2BOCEPNkfLwsPWuFhEIfRkU0%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
