Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 09:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D2A61107
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 09:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8D2A61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC326E104;
	Thu, 23 Sep 2021 09:18:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3AD6E104
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 09:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N44Pdi2D2Lc+NbnOg0lAetX89Ut9ZMw/jLrwM8bVsoOtHnnifB4oatN3fXGNwhH0aeyYGNHfdY66EI6P2rAkaEHMp+o3ep0kRFuAG2ZK1BiLeAzm2CH+yQWv9ALuN17wHVlRTSfFpXjEBhz51XcKT1/axtKfrHfx/VOCJTap+5CB2G28cAbRByDL12DG43XK+QQ/4mdhWolGtERb1BVktq7uKikhi5u9Xv7KnXGBOAGHaXHv7rl3JqErrtJ7KA5xKXW6VGNvaZCUF3xb+BtJTLK7YgVmELGHS/L9Mr8LXh8vElDlbi7DlTGwdU+vjlMvkIG2dB0ednRAOConCPAwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xivOGrlTbQLLnlM/Qyn4r47JSzr4hX6un6yUg6lZUbw=;
 b=H15fTJyqpEn3tfph31WGqAou/HLZdpoRyB/3slWEN00qa8zhBmkVg4erDLElF7Rbx/beUvyx421rWMmF48zPYyy8L6EyiJG788aolv1TkO3QxJGbUI0ZJnG7wWSfBQWgxod0aFpdEpuMRiawDqUk/VdgQT9DSqJCdfnjLBgQezY6MOHFYdwQNQ73FMFVoJCgbs+AhjgCXQuA/qtIkDETqrUtEl9/+WXEi4jz6Y2lxHvablOraEYuEFKlpJCv1KytIdUx6n+Iebq3Joq/zARs5GOtzGeTi7fuqA/QlbZghfpdtlI/Decl07uLSzcYIzv77fEBH4rNqpVDQ3POyw3HKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xivOGrlTbQLLnlM/Qyn4r47JSzr4hX6un6yUg6lZUbw=;
 b=eWLiikZQ0tnlBP7fcUfHGMyAOx0/CEzHa+qYYnxTKkt5+TDKs0Ni7m+ELNcfKmNv/Yiv5InQ8XeAIOCR0lsBmIByUyNkreA70XbyOyQsjNJn89N5ChxcCtfvUZc3W3q//ka8n9h+9lVgBOmDNGAkdI0weIZ4iVUpxXjVWmfN0a4=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 09:18:44 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 09:18:44 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove all code paths under the EAGAIN path
 in RAS late init
Thread-Topic: [PATCH] drm/amdgpu: Remove all code paths under the EAGAIN path
 in RAS late init
Thread-Index: AQHXsFsLxj4croHsuEqAyK3TOkBKl6uxVzMg
Date: Thu, 23 Sep 2021 09:18:44 +0000
Message-ID: <BN9PR12MB52266ED10D88D41C46E05503FBA39@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210923091136.29080-1-candice.li@amd.com>
In-Reply-To: <20210923091136.29080-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T09:18:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=cd12a5b7-116f-4365-b55d-33930fe84e8b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd8a4839-2505-489f-6083-08d97e732463
x-ms-traffictypediagnostic: BN9PR12MB5226:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5226BEEEAD7BEE14EB7415DDFBA39@BN9PR12MB5226.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bcrP7aBJuJgrZ9EgHNQCm8CHt93t3QYcvk14GTR4SnIKuF0HO/pIAJZ5YYfysuyaG+Rs1REVp6F8aZk8mJUnBnzagU8ncleuVm3A7AEDXK6fP3cFZxkD2A57Sk09sWrQuqPJD6kHMCvIy9Rudn18PBVif+/6Nq5wdl5RAa0r+y00TI+4jPG+/yV2xWhRJIeLDmKH0yGZMhtY422l6hq9EL7ZLfPUIgvZAQXXsthSH9l8fpoE+sF1+MxMzBLP7GgfgthH21FsR08GNmeN8qHds+IeyHZU7tCVOpmPss5VZ3mvoiN2wr72YpvABrzvPqg9/VXAIaxzRZXAJaraCVy8N4O1oG6gosSXz88D/nK5M5zAWjTKdmRN/U1kE1565MkEX5+Fy8sKXBuVvih/PbIqCfvYNwzRmdaaPminH3wIkDf4HouZdphMuWFpUkaSoLK7b3AVfQpV81RAnmo26I6BFHnoS+ShMtXAwoZn4/QHQGsFtr0D3t+iegjC4SwO/6DOskvQtwHcJfj96dbqi8Q8cco13/0fYZbH3y4jXmK5YIDv+VU4rf0Jc6WVBshXGOjkYoJ4GmCL5fev4EJhvTjnWfbK+GZVQK3zDbgoPge/QBYFIOtM8BHv0WQnoEmharTJEBqm0n2XPt/JzKSHxh2LhyiOoPAuqIuNSx+90iUEn/pTOFD/soy5KIb96lZGiRJ2IkmfLzbbzF/SuK98kB5C4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(71200400001)(122000001)(38100700002)(52536014)(5660300002)(508600001)(66556008)(110136005)(8676002)(64756008)(66446008)(2906002)(66476007)(6506007)(33656002)(9686003)(53546011)(76116006)(55016002)(86362001)(66946007)(38070700005)(316002)(186003)(83380400001)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vf37o1lQ6n7o4p9QjvcaESiCx1kQBQQteteTa/lg3GFCEgWgklVqXyrusrHq?=
 =?us-ascii?Q?+lfY++gMMkwwHdKsyE5A9CY02QVNJAXwN/7+Rrcy1+yaSdS24vT97lbyFkEu?=
 =?us-ascii?Q?RACr1eHk0ek4ZhDYMSW8hH7rdA6cpQSEUlHhNZDMm2FRjp/Wm1ig+6eRIqCM?=
 =?us-ascii?Q?LomNK6pMz4IK+BEEEwkQzTfie0H2CuII/OdIsp19eUjvnf+2TeDjR2m8HTql?=
 =?us-ascii?Q?pnF3B6bmzHSDxabfW/VtbIU52YE9lo3q39WLd0BTgL8iYZua61MAO3QRrFFl?=
 =?us-ascii?Q?FQ19IbSHJl7+3u2IlKFyQHa3LzIj2d+6zFYlpIfnR/tuHcq1h9HucV0wK0jL?=
 =?us-ascii?Q?uwGyyxBUKzoaKduMyRRqCjULclt5/XWX1k3wxafhNRDbLs8BmQ15rhyE5fJC?=
 =?us-ascii?Q?Uk43qMXCWRfKEQQobXneKsAebIJ5YQuvA+3rv2ZU4di3OjEil17+Us0Judt2?=
 =?us-ascii?Q?XJ7ppd/Gx3saTfz/S2E4u7gDO/O1uCVwfMmFEou+lQ81IvjksJZ8iog6j418?=
 =?us-ascii?Q?DN3FDiViN86pfbRkGmIQMC/8nuI1O3oYkYGJAGPOuD1A/Or6/RjJFvYj2vcc?=
 =?us-ascii?Q?8TTNfoItCfNh5qdeij9UTIuEWs1oVhJ7f66DIaOUOwwQ15fCQxh3mB7hjYDX?=
 =?us-ascii?Q?yZ7NWpcvCXqtFs/KoHqadAFLYnlCSHUlgvnsgDwHNq67KISaHai7Ygjjy1UJ?=
 =?us-ascii?Q?ub4/E/M/sxYMi/ic11X8mOSMEPbIKPNhvBb7lHLp6Qd5D2J//JWPLHW2/AOn?=
 =?us-ascii?Q?uEL68lEansvVAeHryh5jVpIkccwKs75cn09IoggS0dyjHnHEhQylgfMXjVI9?=
 =?us-ascii?Q?mE9K5qe/4QrjLyrhExYQMYuBnhgXeof8UqWTBzIU2yMwrIZKq8qH7zaxli37?=
 =?us-ascii?Q?bHETKKfxU4oqOfbDZ28cSh6UW/tHZnvu+m1mssvOD8ytg5aXurq1y1hod2H9?=
 =?us-ascii?Q?qp0em594HtKecYWsPnfSzaeZfXXiJNMUsVvgRGKKo9P+bHGQXxM5xWY/Hrz3?=
 =?us-ascii?Q?pmZW+Hf5X+LoZPqmJv0avuBXf+YVLyEhM5pZOJVfCRMfNQyGB3y9SwLfznJ/?=
 =?us-ascii?Q?itPw7nGTTg0xn1+fVzc2mkPS2DB3gJpqUATI13kn/9AW6OD/N5/KEuMqV/55?=
 =?us-ascii?Q?9GV653CTkTAvFKYqeXI73GedGcbb+nTZAaZZr+RKVDtbUCYHkP6ViHK3Ln9R?=
 =?us-ascii?Q?OBEvAdW6WwM1S/89aMygMPRZDjOk03kFmTgtmHzXm8Im2hOGzEOsUnWlv6K+?=
 =?us-ascii?Q?VF7G3x/fVbdQaUp/8qHwAFQ5Ttav3pOKaxWD7+48Uny4gEbTwnirAUqIuVru?=
 =?us-ascii?Q?PDEPq445cF7tKa27RR+jUvwC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8a4839-2505-489f-6083-08d97e732463
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 09:18:44.5023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oXvnhXt3zzp4rPztSr4s5JnIkFf+hgtKsPyw3JjOUVikQMP1BBAH7Xztso5IMODJMTTdPUOyFGC3MvCojb1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>=20
Sent: Thursday, September 23, 2021 5:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amdgpu: Remove all code paths under the EAGAIN path in=
 RAS late init

All code paths under the EAGAIN path in RAS late init are unused.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 33 +------------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ---
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b5332db4d28730..6cf5f6e06b76ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2060,19 +2060,6 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_de=
vice *adev)  }
 /* recovery end */
=20
-/* return 0 if ras will reset gpu and repost.*/ -int amdgpu_ras_request_re=
set_on_boot(struct amdgpu_device *adev,
-		unsigned int block)
-{
-	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-
-	if (!ras)
-		return -EINVAL;
-
-	ras->flags |=3D AMDGPU_RAS_FLAG_INIT_NEED_RESET;
-	return 0;
-}
-
 static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)  {
 	return adev->asic_type =3D=3D CHIP_VEGA10 || @@ -2310,12 +2297,7 @@ int a=
mdgpu_ras_late_init(struct amdgpu_device *adev,
=20
 	r =3D amdgpu_ras_feature_enable_on_boot(adev, ras_block, 1);
 	if (r) {
-		if (r =3D=3D -EAGAIN) {
-			/* request gpu reset. will run again */
-			amdgpu_ras_request_reset_on_boot(adev,
-					ras_block->block);
-			return 0;
-		} else if (adev->in_suspend || amdgpu_in_reset(adev)) {
+		if (adev->in_suspend || amdgpu_in_reset(adev)) {
 			/* in resume phase, if fail to enable ras,
 			 * clean up all ras fs nodes, and disable ras */
 			goto cleanup;
@@ -2407,19 +2389,6 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 			}
 		}
 	}
-
-	if (con->flags & AMDGPU_RAS_FLAG_INIT_NEED_RESET) {
-		con->flags &=3D ~AMDGPU_RAS_FLAG_INIT_NEED_RESET;
-		/* setup ras obj state as disabled.
-		 * for init_by_vbios case.
-		 * if we want to enable ras, just enable it in a normal way.
-		 * If we want do disable it, need setup ras obj as enabled,
-		 * then issue another TA disable cmd.
-		 * See feature_enable_on_boot
-		 */
-		amdgpu_ras_disable_all_features(adev, 1);
-		amdgpu_ras_reset_gpu(adev);
-	}
 }
=20
 void amdgpu_ras_suspend(struct amdgpu_device *adev) diff --git a/drivers/g=
pu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 1670467c205463..30a3eafbf6d095 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -32,7 +32,6 @@
 #include "amdgpu_ras_eeprom.h"
=20
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
-#define AMDGPU_RAS_FLAG_INIT_NEED_RESET		(0x1 << 1)
=20
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC =3D 0,
@@ -488,8 +487,6 @@ static inline int amdgpu_ras_is_supported(struct amdgpu=
_device *adev,  }
=20
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev); -int amdgpu_ras_=
request_reset_on_boot(struct amdgpu_device *adev,
-		unsigned int block);
=20
 void amdgpu_ras_resume(struct amdgpu_device *adev);  void amdgpu_ras_suspe=
nd(struct amdgpu_device *adev);
--
2.17.1
