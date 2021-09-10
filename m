Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77592C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4DE60FDA
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A4DE60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4856EA09;
	Fri, 10 Sep 2021 14:38:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791746EA07
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 14:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI7Y9sqbXwAXPRAbZHalCYxUC4+qJjj4zgQfRl3tYAYwzSs+NfbBEGC0DgWJut+Kznn7MNyANogJBkrtMW7B6iFhWVsaJXf89YMNTn8Pvy9pZYqCJX/E5+sv9ODxq9Zk4oBf4qAIHxkBuhVinoAYbdKEbiUyZYYs44S1Y0XDq+hossRq52jn89L6tRY58gEyo1zybnMRmKpSspUa+1sF1VMj0x3TEW+GZ8zINpqNCzuyJ+FGcBxTcEEYs4WmXX+1Y8dx5vQoeUth2tWUxWMKgNE5YBvBbKR/I9t1GBUw6eSHbhLPt3rhXcl/6r6Oveck386OCKXFgcWQJUYS7r1W5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ni1chf9qn1FvADu4PkPeb9Hb4rwyKA2lVyBoV/mJn1c=;
 b=M9UJoUXZRHoo1eRyjoK8PJ17dcABnY1ZqguzFrhYJBYxlhnHIS0Qd/2eILuFM6GN0dQ6QX6eDeml/ASd4dBpbJoD072UhfqW+F+LoHc6WD+yGjz04Tsgy5IUhtmQEXV9UBRwehGFVpXZvBrx3VX01ibEpUIsbah1Uda0BWDkVDkBhb19kUxKNQFaOeOvQ7b3XSkLlru+w8guh2ZcDypJ0i2afY4UTfUYsYFPb370VQZE5Zq8dGNirpzi/MaorD9nrjhKFH8QELOopSRGrakXQYXFrjkt7YuZ7PJpr0WOQwx9M65yf9aHoMW5cih2U6vcprd5pecF/eI6mQw8wWOb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni1chf9qn1FvADu4PkPeb9Hb4rwyKA2lVyBoV/mJn1c=;
 b=3zKBzBnZIogbAp3o6IK7SPlu3d5Jagx+nKzKj5l3YPqQWHMQoMZWLixGlhlU/44hir6dW2zRhji8Htnwzo8sPbnnQq5cia4j1l5gj6h1m220JkJd/ySZ2x2dRAodAieGBsN15D0jblEfEuRObST73+qBsgvtw3SKOUqco9gjQEI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Fri, 10 Sep 2021 14:38:26 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::54e5:e9f1:8883:e8a9]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::54e5:e9f1:8883:e8a9%3]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 14:38:26 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
Thread-Topic: [PATCH] drm/amdgpu:  Get atomicOps info from Host for sriov setup
Thread-Index: AQHXpk/YoEpJ0RFBWE+xcu6IclHeTKudVjlQ
Date: Fri, 10 Sep 2021 14:38:26 +0000
Message-ID: <DM5PR12MB2469D4A1CDB53D3452F42C44F1D69@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210910142607.3182-1-shaoyun.liu@amd.com>
In-Reply-To: <20210910142607.3182-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-10T14:38:23Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=480d7c98-7f17-428f-b04b-5a3ce8100214;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2fee457-9117-4771-364e-08d97468a61c
x-ms-traffictypediagnostic: DM6PR12MB2891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2891828B1044D1A0AFDB3272F1D69@DM6PR12MB2891.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZy/Guywyrfso5BdR4HadNY0uR3S/7TeH8h95Mj46pojtfpMQqLQdSkkrurESsmG4A6eJ8ASwmTqlpvnRt1vQ6HfG+r5oMfZUW/JKOcbpRrpp6wqQ/iHRI0F/H36fHk94JOW/Uf1Ra9h4AwDsKz+z0oWnAyZjqmZBQDjW+vrQEtOtCbpOY87P+tD+274UCdfna8KpQsQ1oR9v2PqnMNSOZLrRkXFD3mpgLmxGBAnAKI5x7yLFdiRlOXAzc9WK+K4LAnzvlOkuHS37YCuggqt5Sy23hVcPYkoaYMtyskr04j+v3ZNEuGHZPYHvEB/pbMDfAINW8Q7ROnQlTg2WJO41JFUL9dqdzrPCuu1bAoRdZcF6hwqlXPNly2YVnW7/PLhJm5N16fktSttDQbdnU/VWml245Twsuq0KxC/RkM1yhJrrdrmlukS3TlvzpoKt9nx2Y2w9R/iDTFbq3+ST7QqanYb2BppFNKlbh8wDW1nQROvYM/vGvkuYRU+T4uV5rSmog1Bmp/q5JKRwcBWx02rJXhxYUYiEHXm3KXN0QdfHkfKol+jCa+IozMWJ9gJK05NKfd2f40wpNWP1/rxqST/+cGY1pXMdgTzplLrmABebldQdqPV+ZFyfSf2C925oixg3dFHde7s2nn24OyB+QztAJGfPf++Y6np3TXOzx7DM2vBOF7V0pSX2/BT6xIZ4BnLX8JnZQw6BKIRLyqw4jE2zQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(33656002)(66946007)(316002)(8936002)(26005)(66446008)(4326008)(76116006)(55016002)(122000001)(5660300002)(83380400001)(66476007)(38070700005)(66556008)(7696005)(186003)(9686003)(8676002)(64756008)(110136005)(71200400001)(52536014)(38100700002)(6506007)(478600001)(2906002)(53546011)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZQKFdmlPntoTgedrFmZ6KW3s7YhP2rw7tFVf3BiFg526+jLrFvmPoBLa7Mpo?=
 =?us-ascii?Q?Cj68aJnNJNo1jzFtZpV6cR3EUow8HP4g0CEdnBJaNo7YoezrOhLS9+K302Ac?=
 =?us-ascii?Q?R7yz7gFb3brV0gDpKYkWx9oknFcxJmU1XhisqoehgBDZVlUTQpoUoRj2Sjtt?=
 =?us-ascii?Q?truWPOl7rN4AoabOc8emdJdaroSKM5UZkp8n/bMweQWPiSzF0jvpmCAqxuCP?=
 =?us-ascii?Q?mFbOyJjZHfLeQHuGVAAgGplEOBvXyHL8RLScsXf0OnAdh+57m1u8Q14v91DH?=
 =?us-ascii?Q?MGKQgO3hJ0OaZoLUZYGMzwsTgfuNnHPhpiWuLJkZBeYD1mhVj5CaezUzqaYd?=
 =?us-ascii?Q?jtiY7p7QOR3u3jcL1FS6wq7lVDnfpA89iIUxUBmxbDso5/lHI+SZ34W4w0tY?=
 =?us-ascii?Q?lVL748z3kNbiAf0ApMc3C6QjPJel/yCfWUqFR7HPYDWXzDuxfA4kG92huoug?=
 =?us-ascii?Q?73P47VRePVZCt35TDzx3SG3I8KL75hpo2H52Cd4pQtX6tXAMaGOtoN5DMwm5?=
 =?us-ascii?Q?l1ZgwcPQjP3eTpIqcZ9D+Tx0Q3CJC1CnXBI/wm57EtU4Yti/olQe3IZbzBQN?=
 =?us-ascii?Q?6ZhKn+y662Uq8viMstvhHyICNQ/wQSQSBVwb6EmeZWmSbqE4bq4Upy7DIFep?=
 =?us-ascii?Q?I8WQ3fXofeGPUz945yRhYm4tryfZ0yid4PTiLsQga0X66aYaTQT4Pro0yxWo?=
 =?us-ascii?Q?Udp4fz6QxarWdu82gxiRH+lzA48JXJStlhEZzijoCyb36tcnU13JrVHFiyjb?=
 =?us-ascii?Q?KO/6tzOIDx9fIpU4tS6KLx7G12ERaxh9Xkg4ZQJeIm78NFHGwJiWB6C/Tq2p?=
 =?us-ascii?Q?BcYczTU3trvJJjYgzB9mjHvyvDmQE0+pSib6aocWl7Fot2nJtrN0MmUXwA7i?=
 =?us-ascii?Q?Xu6Z8YiclCHJQwLvh6dEXpPtVs+8cidU7MxA8BPacl4LTFR3enNkH5QCq1oH?=
 =?us-ascii?Q?q6gKlOwe/CUgu3uaJvUnlOIwYJDwyMDLGQ/bwngM7WvE3I0szpo1xOUXOFb6?=
 =?us-ascii?Q?wCDAUQb9Dx2GD+DA9DQNI/RwzakkM2RFe3ofoFQVkWJHGJf6AIZHw/CVyD9+?=
 =?us-ascii?Q?onsWYMFkxZLg9vhLV3WMQeBa/+9PBzaS8q3gWC/5HyAODooUyc9afSWMFiwa?=
 =?us-ascii?Q?jKDYwLMFQuFQVHIjWpBiK3LX1UVtvVoAx6Gu4c6m+pBPOWuFKEDxLV1b1QMc?=
 =?us-ascii?Q?G5PyBgf+zTaQNBJO8Y4Q+D8srHKbdw8eiNp5XS1J0fKvc493HV+CzxwXB82g?=
 =?us-ascii?Q?LuxFYu5DDQCpceGVG1GVrDZ5qJe2Sa7dAAPCvb4xSHf9MwE8VFF4N2LPtKrP?=
 =?us-ascii?Q?ZTkCg3uU9fT5EKE0ztVBpJSP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fee457-9117-4771-364e-08d97468a61c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 14:38:26.0174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXWiY+kuZLOKjQi4/FrYR4gTqdL+JJfwcIMpyQlalQmcjrxLS7y29+5OC99DiqePWXJ9WfhkKGf8+STPcLeZpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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

[Public]

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
old mode 100644
new mode 100755

Please don't modify the file mode.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Friday, September 10, 2021 10:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup

The AtomicOp Requester Enable bit is reserved in VFs and the PF value appli=
es to all associated VFs. so guest driver can not directly enable the atomi=
cOps for VF, it depends on PF to enable it. In current design, amdgpu drive=
r  will get the enabled atomicOps bits through private pf2vf data

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: Ifdbcb4396d64e3f3cbf6bcbf7ab9c7b2cb061052
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 24 +++++++++++----------  dr=
ivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
 2 files changed, 16 insertions(+), 12 deletions(-)  mode change 100644 =3D=
> 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
 mode change 100644 =3D> 100755 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
old mode 100644
new mode 100755
index 653bd8fdaa33..3ae1721ca859
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3529,17 +3529,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
=20
-	/* enable PCIE atomic ops */
-	r =3D pci_enable_atomic_ops_to_root(adev->pdev,
-					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
-					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
-	if (r) {
-		adev->have_atomics_support =3D false;
-		DRM_INFO("PCIE atomic ops is not supported\n");
-	} else {
-		adev->have_atomics_support =3D true;
-	}
-
 	amdgpu_device_get_pcie_info(adev);
=20
 	if (amdgpu_mcbp)
@@ -3562,6 +3551,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
=20
+	/* enable PCIE atomic ops */
+	if (amdgpu_sriov_vf(adev))
+		adev->have_atomics_support =3D ((struct amd_sriov_msg_pf2vf_info *)
+			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags =3D=3D
+			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	else
+		adev->have_atomics_support =3D
+			!pci_enable_atomic_ops_to_root(adev->pdev,
+					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+	if (!adev->have_atomics_support)
+		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
+
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_device_doorbell_init(adev);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
old mode 100644
new mode 100755
index a434c71fde8e..995899191288
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -204,8 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
 	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
 	/* UUID info */
 	struct amd_sriov_msg_uuid_info uuid_info;
+	/* pcie atomic Ops info */
+	uint32_t pcie_atomic_ops_enabled_flags;
 	/* reserved */
-	uint32_t reserved[256 - 47];
+	uint32_t reserved[256 - 48];
 };
=20
 struct amd_sriov_msg_vf2pf_info_header {
--
2.17.1
