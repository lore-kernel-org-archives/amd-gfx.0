Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F02C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 06:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B33613C5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 06:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B33613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8CF6EA37;
	Thu, 27 May 2021 06:34:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBCE6E7DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 06:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h50lfCdW2JHGB0624R9Yn8WRAke2RFZDDmD12egX4S1kLNDglDK9VNl3LpELfJa/eeYbBEzBbyaug7A5FkzjQdQkpqtU89G82Yzfvk1OcKXMxLeciwouCzDuI7d0gFofq5N1BtaU5gF/boE0ulGCrRMN0jBPwDmyyIS5avSs7GgLD96QmZNU9SlJdf7x5HVWtJreP2UJ2D9Zi08zd1hbdXYCCX83mUaR7tyJEUL+FBbjpkzksjZ5mUshcMI8rF7O4O8zKbK4kdDUmaGFZsyR8qttnV7lSisimAbYGXXivaxuDZpsMEvbmWotyef98N4BlsR6ava8NyZKHjOYqJIIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+M7BvaZV0EnbOwzQfNcDcuTK9y2L1ho9VqISkqGkD4=;
 b=AAkFqbkls+SuWVgjL5rCIMkdidc8Z0ZzulD2wiQhlk15ZftGCe8x4imLRaQW/948S0pTJbJZUxKwtikCkck/n84PShDwBUHvxQhro4Ge0bBB0iVUhDnAqc0Chom3mrZ9e5OCARmLZo0l7V4wR/UCXlc7gajG/tKFRCaypS0oFqNomyReLdeHkauUW4j8K7yRSNlzjrhmV2mmpQSlcdl/pq7yO4ddw3caIf+3SBmM/BBrDj60gSEs+cM8WAoOk1em1qIcTEHVPbIbnme9536gnNBmgslCN0QIipVweaUwpCrik6C9hAQvr5Wvfago5rcQJMOiJ1c+vrH2RpUAbWaAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+M7BvaZV0EnbOwzQfNcDcuTK9y2L1ho9VqISkqGkD4=;
 b=qwXwjWnMWivJG5xIqcZGPPFiWTFnueoXUKJDOJJv5nmvOe9nT/6zvU7DZ8U2AFGBIVwghaaesohdw/432SSjPYK0fmJG52EdfjPISBPfgUbZcJWCOF0eas4as1xJsZtJi589fAKR4l21aDDiLfFGuc8CUqUfsSVXERZVn1v2grw=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 06:34:35 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 06:34:35 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)
Thread-Topic: [PATCH 2/2] drm/amdgpu/acpi: make ATPX/ATCS structures global
 (v2)
Thread-Index: AQHXUjgvel6R8sS9t0Kssl3xdexwlar2y6IA
Date: Thu, 27 May 2021 06:34:35 +0000
Message-ID: <CH0PR12MB5348DE08B3D60E0AD4880B6A97239@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210526140503.1541686-1-alexander.deucher@amd.com>
 <20210526140503.1541686-2-alexander.deucher@amd.com>
In-Reply-To: <20210526140503.1541686-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-27T06:32:35Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fcbf597a-7fb3-4d56-b36a-575ae41b2680;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9e1aad0-e3af-4a6b-0c9e-08d920d97e96
x-ms-traffictypediagnostic: CH0PR12MB5124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB512471450C5A695E3D01ADFD97239@CH0PR12MB5124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: upA5/BVm3RWFm9Jfn9y8DGjTJlDxk6+65Kf4UDEYvpmrPlgOdda5KD0lwdiAj8jHlU3ql0aEi5aUbl2MU5tDhTbi+gH/MILxtq1wzwzqATQJPNtN8FTiKDm78jha7zHhZQDJwLjU6ZVvhHYE8Uj45uGnT8S6ZXR9ypaLkx6Pn+kLD+pkME+mDHvJ7pi+yge45XgS9H+dykJbRgjZo74fVBYfFNQLv/YffK4U3cejZyPL6HGeCg8SNCZVSRexDdx/QdXVid7eLdeK7pM4zZVVetA2jOirEMuUp5QZrDsCHr8k5rREjNnANbRqu40sOn5uo3CZVKYKvBFe2UHW0ScBPS1mL7xIai188Ct7XUElXmyx+H3x+vjYCeKF+EGWJqGg82LWgj+sXssBRmz1uTPViSTzOXEtuvSOKJ/BE0AvdhWhq11sESh4IhLJGyGz0MRMVJDrFmZF35ygGqHE4FcxZFc2okD2BTwWUtK4jq5KIGFru1+Bg45DUdLxGRGfMsSUGNLttM5GuzvAmPuQVhlEJhMdUeJk3rwBA2nhyT+uPkWrFhwh27EUOKEj+g11rZ3qfrYGwoqPjESFd24QkTo09/IQOY6F0Ga3YDpyCwKcK0XAyW2OLXEy2cIniZ4zmRK1vh+JCmr/AymYTwaw2aiSwzfigHJ0QWXI2Rz2IZgeL2S7erROtPsgI1aZMCa1Z4IU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(86362001)(186003)(966005)(478600001)(55016002)(66446008)(83380400001)(66556008)(122000001)(6506007)(66946007)(66476007)(64756008)(52536014)(53546011)(76116006)(38100700002)(7696005)(8676002)(8936002)(71200400001)(33656002)(9686003)(2906002)(110136005)(316002)(30864003)(45080400002)(5660300002)(26005)(4326008)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?o0r9VVdOqky4jK1dhJ7tCSb6FaVl2ZS1cc/MdOe3YzljPTQY63bxVUZJLXKq?=
 =?us-ascii?Q?ODt2wmzPu6QsJi0tGuRhvb9+1HusaOtwcrXTFOGF6MrfjyGmLEqvQ1Ap4FJN?=
 =?us-ascii?Q?kLNOXP8LHJlAijzypNT6yrVL3tu5guTHdtkh9vqUdtncN8z6LyX5YsM4NEnP?=
 =?us-ascii?Q?/2wqneFPSWL4qN3nwIT7NoDbxYDx7tfdaKy0h5dgXv54Zcgu0mfvGXerKkHY?=
 =?us-ascii?Q?Ck1HmDbRuYfCwJf0tmGY8/TUIvm35xy8nJ+LEGNDm7ASF18p/7NndMrG/8bw?=
 =?us-ascii?Q?Qi9kwmEI4oEqeA4NwM5R0g7x7maGxyRQnA9cR+aWczWLAPPdNAT8W/7jkvZl?=
 =?us-ascii?Q?CJCJhBw+PZj4FJBpC1TmmCZ+0HEdch2KBZ6qPLMT3uYGn5dqp+hpuUDIJmwn?=
 =?us-ascii?Q?P/tJz9DWccOfl4WnBQVcX6xNRjL8RbsmQj2v4JhNuRcp4efRAhneSzLhrJ6H?=
 =?us-ascii?Q?G9nzVewimezRKk9aPnjPg5flZyohUVwL/c1/ai2GJn4Cm7ovBS+f7gKiHTw8?=
 =?us-ascii?Q?UpfkhwPkGrHsueWwHVXZXOp2Tju3jOm83ekZJDkyCSO87qAWHloUw5GHOv7W?=
 =?us-ascii?Q?lSMMum+qVjbW8ef8ZLcm31Nv1t0vR7BEk7RYEYfTVQdqohtn5jV51DrRV/qG?=
 =?us-ascii?Q?ffsrIY7QBnR33syIeMQiwPsHvp7Z1lYTINWzLqZ4lRQtnV/FWskknKQRYSbz?=
 =?us-ascii?Q?3UVXF4zkqTzIN79XikdzyNaAWSDubsks9az2DEuziSWuSrhFf2xrlBE78+en?=
 =?us-ascii?Q?fMIbVkoH18lIhsxPaOshRK7U3yc4Ju+Qm6WD8rPr+3hs2WTGl9mbTjQkDREi?=
 =?us-ascii?Q?Viw0fipx/TmNEmNEcRp2u+meEJFiqygv8zP8ESBIhF+VZsGVcLM17w2lS9Dw?=
 =?us-ascii?Q?yT3+FU3j8xzV/rFgoXHrr2KEjAtuxr/dPONXT3Q70e/ANRcN2OqR/t/57E/Y?=
 =?us-ascii?Q?JZASmgy/UkizGa/jjt5Bi5GGz7+i45YKUtBGuIwGk1bVPfLncN8zrtgvCfI9?=
 =?us-ascii?Q?yl/bFKEZdpnozWVOBaU6gazqfyDI+bRmEoJw8RyGYYZ+qtgcB+4HwBdJUlyd?=
 =?us-ascii?Q?BBuXEOvweync24+xzVl518AJQWfsR3j9n1lvvyqAR3LEp1yWZYfB38oITVlg?=
 =?us-ascii?Q?O8QwAjH5Unj5VwZj0eMjw0HTWYEDl8VQXQxp/1RXU6qDc6PImS3ilgULqRWR?=
 =?us-ascii?Q?sms3WII/os3KEzx1q/3iSkM4pufb2BlmgWMM5z82grctbLkcIqyVcr7RFYaB?=
 =?us-ascii?Q?M1k87P2Gxd3OQbdTdE1j+JMGK66LMkcANWEj7tXUGKTosIshkhRi1yRv/S9U?=
 =?us-ascii?Q?IaVb4OV3S5jnu5vZHjfIIjaB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e1aad0-e3af-4a6b-0c9e-08d920d97e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 06:34:35.1379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJ5Da1F+ny9zFRqAMe68sBbewKqsGqzF3ZeYLGSUeirbmlzSADbb93+hpacNBsYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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

[Public]

Series is 

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, May 26, 2021 7:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)

They are global ACPI methods, so maybe the structures global in the driver. This simplified a number of things in the handling of these methods.

v2: reset the handle if verify interface fails (Lijo)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      | 288 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 4 files changed, 139 insertions(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c759d5a8a3a0..2c063c550101 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -268,8 +268,6 @@ struct amdgpu_job;
 struct amdgpu_irq_src;
 struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
-struct amdgpu_atif;
-struct amdgpu_atcs;
 struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
 struct amdgpu_reset_context;
@@ -812,8 +810,6 @@ struct amdgpu_device {
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
-	struct amdgpu_atif		*atif;
-	struct amdgpu_atcs		*atcs;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
@@ -1348,13 +1344,14 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 						u8 perf_req, bool advertise);
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
-void amdgpu_acpi_get_backlight_caps(struct amdgpu_device *adev,
-		struct amdgpu_dm_backlight_caps *caps);
+void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps 
+*caps);
 bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);
+void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }  static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }  static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev) { return false; }
+void amdgpu_acpi_detect(void) { }
 #endif
 
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index df216d12c507..5caa54ed6662 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -85,6 +85,11 @@ struct amdgpu_atcs {
 	struct amdgpu_atcs_functions functions;  };
 
+static struct amdgpu_acpi_priv {
+	struct amdgpu_atif atif;
+	struct amdgpu_atcs atcs;
+} amdgpu_acpi_priv;
+
 /* Call the ATIF method
  */
 /**
@@ -221,62 +226,6 @@ static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
 	return err;
 }
 
-static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle) -{
-	acpi_handle handle = NULL;
-	char acpi_method_name[255] = { 0 };
-	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
-	acpi_status status;
-
-	/* For PX/HG systems, ATIF and ATPX are in the iGPU's namespace, on dGPU only
-	 * systems, ATIF is in the dGPU's namespace.
-	 */
-	if (amdgpu_has_atpx()) {
-		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATIF",
-					 &handle);
-		if (ACPI_SUCCESS(status))
-			goto out;
-	}
-	status = acpi_get_handle(dhandle, "ATIF", &handle);
-	if (ACPI_SUCCESS(status))
-		goto out;
-
-	DRM_DEBUG_DRIVER("No ATIF handle found\n");
-	return NULL;
-out:
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-	DRM_DEBUG_DRIVER("Found ATIF handle %s\n", acpi_method_name);
-	return handle;
-}
-
-static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle) -{
-	acpi_handle handle = NULL;
-	char acpi_method_name[255] = { 0 };
-	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
-	acpi_status status;
-
-	/* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
-	 * systems, ATIF is in the dGPU's namespace.
-	 */
-	if (amdgpu_has_atpx()) {
-		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
-					 &handle);
-		if (ACPI_SUCCESS(status))
-			goto out;
-	}
-	status = acpi_get_handle(dhandle, "ATCS", &handle);
-	if (ACPI_SUCCESS(status))
-		goto out;
-
-	DRM_DEBUG_DRIVER("No ATCS handle found\n");
-	return NULL;
-out:
-	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-	DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
-	return handle;
-}
-
 /**
  * amdgpu_atif_get_notification_params - determine notify configuration
  *
@@ -455,7 +404,7 @@ static int amdgpu_atif_get_sbios_requests(struct amdgpu_atif *atif,  static int amdgpu_atif_handler(struct amdgpu_device *adev,
 			       struct acpi_bus_event *event)  {
-	struct amdgpu_atif *atif = adev->atif;
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 	int count;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n", @@ -465,8 +414,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 		return NOTIFY_DONE;
 
 	/* Is this actually our event? */
-	if (!atif ||
-	    !atif->notification_cfg.enabled ||
+	if (!atif->notification_cfg.enabled ||
 	    event->type != atif->notification_cfg.command_code) {
 		/* These events will generate keypresses otherwise */
 		if (event->type == ACPI_VIDEO_NOTIFY_PROBE) @@ -643,10 +591,8 @@ static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
  */
 bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)  {
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 
-	if (!atcs)
-		return false;
 	if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
 		return true;
 
@@ -665,10 +611,8 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade  int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)  {
 	union acpi_object *info;
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 
-	if (!atcs)
-		return -EINVAL;
 	if (!atcs->functions.pcie_dev_rdy)
 		return -EINVAL;
 
@@ -696,16 +640,13 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 					 u8 perf_req, bool advertise)
 {
 	union acpi_object *info;
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 	struct atcs_pref_req_input atcs_input;
 	struct atcs_pref_req_output atcs_output;
 	struct acpi_buffer params;
 	size_t size;
 	u32 retry = 3;
 
-	if (!atcs)
-		return -EINVAL;
-
 	if (amdgpu_acpi_pcie_notify_device_ready(adev))
 		return -EINVAL;
 
@@ -802,37 +743,7 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
  */
 int amdgpu_acpi_init(struct amdgpu_device *adev)  {
-	acpi_handle handle, atif_handle, atcs_handle;
-	struct amdgpu_atif *atif;
-	struct amdgpu_atcs *atcs;
-	int ret = 0;
-
-	/* Get the device handle */
-	handle = ACPI_HANDLE(&adev->pdev->dev);
-
-	if (!adev->bios || !handle)
-		return ret;
-
-	/* Probe for ATIF, and initialize it if found */
-	atif_handle = amdgpu_atif_probe_handle(handle);
-	if (!atif_handle)
-		goto atcs;
-
-	atif = kzalloc(sizeof(*atif), GFP_KERNEL);
-	if (!atif) {
-		DRM_WARN("Not enough memory to initialize ATIF\n");
-		goto atcs;
-	}
-	atif->handle = atif_handle;
-
-	/* Call the ATIF method */
-	ret = amdgpu_atif_verify_interface(atif);
-	if (ret) {
-		DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
-		kfree(atif);
-		goto atcs;
-	}
-	adev->atif = atif;
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 	if (atif->notifications.brightness_change) { @@ -862,6 +773,129 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		}
 	}
 #endif
+	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
+	register_acpi_notifier(&adev->acpi_nb);
+
+	return 0;
+}
+
+void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps 
+*caps) {
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
+
+	caps->caps_valid = atif->backlight_caps.caps_valid;
+	caps->min_input_signal = atif->backlight_caps.min_input_signal;
+	caps->max_input_signal = atif->backlight_caps.max_input_signal;
+}
+
+/**
+ * amdgpu_acpi_fini - tear down driver acpi support
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Unregisters with the acpi notifier chain (all asics).
+ */
+void amdgpu_acpi_fini(struct amdgpu_device *adev) {
+	unregister_acpi_notifier(&adev->acpi_nb);
+}
+
+/**
+ * amdgpu_atif_pci_probe_handle - look up the ATIF handle
+ *
+ * @pdev: pci device
+ *
+ * Look up the ATIF handles (all asics).
+ * Returns true if the handle is found, false if not.
+ */
+static bool amdgpu_atif_pci_probe_handle(struct pci_dev *pdev) {
+	char acpi_method_name[255] = { 0 };
+	struct acpi_buffer buffer = {sizeof(acpi_method_name), acpi_method_name};
+	acpi_handle dhandle, atif_handle;
+	acpi_status status;
+	int ret;
+
+	dhandle = ACPI_HANDLE(&pdev->dev);
+	if (!dhandle)
+		return false;
+
+	status = acpi_get_handle(dhandle, "ATIF", &atif_handle);
+	if (ACPI_FAILURE(status)) {
+		return false;
+	}
+	amdgpu_acpi_priv.atif.handle = atif_handle;
+	acpi_get_name(amdgpu_acpi_priv.atif.handle, ACPI_FULL_PATHNAME, &buffer);
+	DRM_DEBUG_DRIVER("Found ATIF handle %s\n", acpi_method_name);
+	ret = amdgpu_atif_verify_interface(&amdgpu_acpi_priv.atif);
+	if (ret) {
+		amdgpu_acpi_priv.atif.handle = 0;
+		return false;
+	}
+	return true;
+}
+
+/**
+ * amdgpu_atcs_pci_probe_handle - look up the ATCS handle
+ *
+ * @pdev: pci device
+ *
+ * Look up the ATCS handles (all asics).
+ * Returns true if the handle is found, false if not.
+ */
+static bool amdgpu_atcs_pci_probe_handle(struct pci_dev *pdev) {
+	char acpi_method_name[255] = { 0 };
+	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
+	acpi_handle dhandle, atcs_handle;
+	acpi_status status;
+	int ret;
+
+	dhandle = ACPI_HANDLE(&pdev->dev);
+	if (!dhandle)
+		return false;
+
+	status = acpi_get_handle(dhandle, "ATCS", &atcs_handle);
+	if (ACPI_FAILURE(status)) {
+		return false;
+	}
+	amdgpu_acpi_priv.atcs.handle = atcs_handle;
+	acpi_get_name(amdgpu_acpi_priv.atcs.handle, ACPI_FULL_PATHNAME, &buffer);
+	DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
+	ret = amdgpu_atcs_verify_interface(&amdgpu_acpi_priv.atcs);
+	if (ret) {
+		amdgpu_acpi_priv.atcs.handle = 0;
+		return false;
+	}
+	return true;
+}
+
+/*
+ * amdgpu_acpi_detect - detect ACPI ATIF/ATCS methods
+ *
+ * Check if we have the ATIF/ATCS methods and populate
+ * the structures in the driver.
+ */
+void amdgpu_acpi_detect(void)
+{
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
+	struct pci_dev *pdev = NULL;
+	int ret;
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
+		if (!atif->handle)
+			amdgpu_atif_pci_probe_handle(pdev);
+		if (!atcs->handle)
+			amdgpu_atcs_pci_probe_handle(pdev);
+	}
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
+		if (!atif->handle)
+			amdgpu_atif_pci_probe_handle(pdev);
+		if (!atcs->handle)
+			amdgpu_atcs_pci_probe_handle(pdev);
+	}
 
 	if (atif->functions.sbios_requests && !atif->functions.system_params) {
 		/* XXX check this workraround, if sbios request function is @@ -891,60 +925,6 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 	} else {
 		atif->backlight_caps.caps_valid = false;
 	}
-
-atcs:
-	/* Probe for ATCS, and initialize it if found */
-	atcs_handle = amdgpu_atcs_probe_handle(handle);
-	if (!atcs_handle)
-		goto out;
-
-	atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
-	if (!atcs) {
-		DRM_WARN("Not enough memory to initialize ATCS\n");
-		goto out;
-	}
-	atcs->handle = atcs_handle;
-
-	/* Call the ATCS method */
-	ret = amdgpu_atcs_verify_interface(atcs);
-	if (ret) {
-		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
-		kfree(atcs);
-		goto out;
-	}
-	adev->atcs = atcs;
-
-out:
-	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
-	register_acpi_notifier(&adev->acpi_nb);
-
-	return ret;
-}
-
-void amdgpu_acpi_get_backlight_caps(struct amdgpu_device *adev,
-		struct amdgpu_dm_backlight_caps *caps)
-{
-	if (!adev->atif) {
-		caps->caps_valid = false;
-		return;
-	}
-	caps->caps_valid = adev->atif->backlight_caps.caps_valid;
-	caps->min_input_signal = adev->atif->backlight_caps.min_input_signal;
-	caps->max_input_signal = adev->atif->backlight_caps.max_input_signal;
-}
-
-/**
- * amdgpu_acpi_fini - tear down driver acpi support
- *
- * @adev: amdgpu_device pointer
- *
- * Unregisters with the acpi notifier chain (all asics).
- */
-void amdgpu_acpi_fini(struct amdgpu_device *adev) -{
-	unregister_acpi_notifier(&adev->acpi_nb);
-	kfree(adev->atif);
-	kfree(adev->atcs);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1ed9748b9bc7..c21710d72afc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1801,6 +1801,7 @@ static int __init amdgpu_init(void)
 
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
+	amdgpu_acpi_detect();
 
 	/* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set. */
 	amdgpu_amdkfd_init();
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f303e8dbdb5f..434e4183c2e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3414,7 +3414,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 	if (dm->backlight_caps.caps_valid)
 		return;
 
-	amdgpu_acpi_get_backlight_caps(dm->adev, &caps);
+	amdgpu_acpi_get_backlight_caps(&caps);
 	if (caps.caps_valid) {
 		dm->backlight_caps.caps_valid = true;
 		if (caps.aux_support)
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cb04aa10766554a78a6c608d9204f50d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576347308358587%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=hk0oJIS1LdG3Y59C2G9%2FONrTAnarL3fvlgMg3kMqhiM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
