Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87291C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EF2610A8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EF2610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75DE6E48B;
	Wed, 26 May 2021 07:10:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4610B6E48B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 07:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaIXIhtjuGp71GpjGHcr68anvHKwPAsZRIYQ3aRGn3KQrXhaqgp2PixogryH3HPoxC3JTiwJA8P7XdN4G5cXdsego6JZKFBG6QpO7g3aHgmXn633QX9rVQm1QvYjEqGKqivjYCZqqUfgcZzAWo8bY2yohIPHerLWMaTsfrm7i323d+4xYnKrX2hipReVnVCQizJdGjcDynyzLj+WqVBJcvG8Tv/JY8IGpPu2QaQnD8zy9k+VKGEWFsSgYXbThiPN+m7AJH8I6thsfPgcwazeSGcQ7TcI4BHmPC/hqlj925+3e+gTV32Mh9e96iZ9/S5sWGqTfpxoAOBs3aYMUpCSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXY3eDa9DCtwoNmmoaX7bWiiGW8KshsyiMSEdHcPQW8=;
 b=GYO0QugkAofrVzY11gghCtYYH7bhe0Fbqgpbnz4+v0YqQY9ekXmVTnrx76Pj6If+18aOmE28MfPMMvANjH3AScDyy+E6zs04UJa0rH0h6c44pHM5EF12CPb57RiaxynlZgtFDm+QR8lPyd9/8xEua0DFGOjtZO22JMF43CEiQ5/ovLRmfgKsewJyiFTfIKfFKOo95qx1FhMQydrnTYFG7w7+EUfaPHF5uA5stoTmGBtWP9aLbTmJ/OYtmUSeHMeR9vWwdDuMIGLYyWTMqcPpCETP7tU51T3Kv2P6m6MU4PDtq7blqKQjcR7vA5WbCfmWgn6L0bzh4gOGTg9s02+Cag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXY3eDa9DCtwoNmmoaX7bWiiGW8KshsyiMSEdHcPQW8=;
 b=tMQ/P7lfijXNhCE5COhb+8gsXJR22qWT1MKOtoIBhwnqkQcb/+lb8NAKOENRPjVB0QlBLonbkF0wmQ16w7BjPjFPtZZv8E6D9mLVsp9OO6QvBM390i4Sz+HWFxdgI8xOe/FnprP+f2BwoyAt/d8nKWs9T1mO8Ds0a7jYwNyHcDw=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 07:10:44 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 07:10:44 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/acpi: make ATPX/ATCS structures global
Thread-Topic: [PATCH 2/2] drm/amdgpu/acpi: make ATPX/ATCS structures global
Thread-Index: AQHXUd5wVYfWCdRKVEis9YkQWPiP86r1VrGQ
Date: Wed, 26 May 2021 07:10:44 +0000
Message-ID: <CH0PR12MB5348B487FBBAEDF9A5CB3AFE97249@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210526032233.1260674-1-alexander.deucher@amd.com>
 <20210526032233.1260674-2-alexander.deucher@amd.com>
In-Reply-To: <20210526032233.1260674-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-26T07:10:36Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d0820a5e-c32e-4578-8592-f70619adec07;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.222.148.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d0b28b1-592a-442a-ee6f-08d92015612a
x-ms-traffictypediagnostic: CH0PR12MB5089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB50894D78E31A4C09F75DBF8497249@CH0PR12MB5089.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tF1JdeJjhMZLkzXHfGvgPfN8khMpv+2+LA465ttZDfXGi77kh5cr+WrWGAGjuYZGAqMERmWiMA1Cyuobv5iOWyZORouJXyoPrrddM77pA0a64d9q/PagoVZ/eOJKMZZ3uSW0cartLsvAO0qjFNuwM4Pf+TDvNlm3JkmjyCE/Vak1Zgytm5PvWfEK7KrJqoBjluqOfoq0u0XkLUAKe9/zUReV+cuxYuD7C9LOuK1FhsxAO8b1MTeBPjMi4SuHwg1Lw76dJ6jWaJZRs/0DYSD4jqS7Hq5CcmiDBUTbEvaqtcnBFYR/toHm/W504F4mCml2grv2q90Mw6wLZ2C+quhZXSxuNc8uDsSwBYUAAsfdrF3lAN4bev6ww3fxiKnCpBdrhTM2paU0LIdm2lMgDQynbNONzGvu2OvclOekRsIng8Q4FPm+rLRAVa5YiVgp/ee+RA+frWHj3+S3ASRKvgyvD9QGUxCDMRVV+2IfYgPyjmHq4wPehx4gIl/9DAbNmb9ROmTo6AXdlnt4ar3wTVzZuFXEoTGr+BXq0mHxsQrfCKF7K0ZnSs68ownhetwc81PKAgEY4acM85z/Q/Vi2D9YIG7i70cTmNabnBmghxBotvEdCQK9LsgLc8iY7pBNuRJWm1ulzG9b6Z+6Ct49HWzj8RNU02IiJY6f7x3Eu7K6T8yP4PSFIrvUrM6n/tHws6km
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(8676002)(8936002)(55016002)(45080400002)(76116006)(66946007)(966005)(26005)(9686003)(66476007)(64756008)(478600001)(66556008)(186003)(66446008)(53546011)(2906002)(86362001)(6506007)(110136005)(83380400001)(33656002)(30864003)(316002)(4326008)(71200400001)(52536014)(122000001)(7696005)(5660300002)(38100700002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6tucbRUx473fQ9IOJfjNfIUXGqN41eug7ieAOfJIbSw/4liipfmOvfiObyer?=
 =?us-ascii?Q?WGHcZshn8jizMbk6iEqqr0Rt8xU5p5Pauan6690xBQrJMghDy/Kc6zzMyTm3?=
 =?us-ascii?Q?DXVD1nuiAIGg8xPC/cgnpq6wb2x7Ofi2yl+i5O81fUVqfa/kbteZzJ93R2UO?=
 =?us-ascii?Q?0pFDrwZkSVfwBjqrb3K1jzJXm/4M12hK8a3ECQ2DAiF6wSPsN3yelovtDG1B?=
 =?us-ascii?Q?wwy2UL90q5SVjt3vcVvdvZYhW3OghVKCB/Rnnf55Luc1gA8v0MP4X5lthQLv?=
 =?us-ascii?Q?o8oSFoMCew4yz4sfHTWT2otvnamNKn5g8ayBLOGfttyqPyhKoD4ruXUKWwoJ?=
 =?us-ascii?Q?XHyamxhn2Q6F4sy9P6hggGbhWWoXU0bjZ3FC4P/R107ifbw+9CR7+iUaV2RX?=
 =?us-ascii?Q?mN3jYzfKKmIcHFjh3eGRYkm/AiCKefO4bQOQGSIwW3CFvwkfoggEzBgthBJW?=
 =?us-ascii?Q?9Pl344RiCiElDSM13CQHggi4oGeGp6XorVU7axXPoBBXhIZtoHmRohf/bRYZ?=
 =?us-ascii?Q?ydhGvyAyFtTjdXa+w9MFXAvbp0Bz1J5+yKGIUzzWehmswtOXsQ+GXCLcsHua?=
 =?us-ascii?Q?XPW89VK7dDLHVEcgY5QpBVSapj4uOHHghXPnRiLxJkWN/fZLVA3mbU7eQE8L?=
 =?us-ascii?Q?p65zotJKD3N5ZrSegGp3pClMN7UHiwXWIsHOEupZBqFOLYF0IMZYl9wUKw+3?=
 =?us-ascii?Q?36j3epmXKuLC7f/R6Hpyf96En1ZiquhZfwHZBI7Hq0t21eOmGyxFFcKEoRYK?=
 =?us-ascii?Q?/b6ft1PN3rwm9h9XocPXbpKq+ZZCbgMsl2beSvnn4oH/qAE9lz7NqHwU0ti3?=
 =?us-ascii?Q?Tnotd+vLLLNsFaO7E/H7riRfPdhEa3G6A1bSFnU6b3Uj9QJXyU0TsyK1DAqa?=
 =?us-ascii?Q?HoowJ5KvCEOCRdAA0N1Ku7C2zrGdrKzlu5lCxdg1W0Mw1/vhJpPVCvd8xAgL?=
 =?us-ascii?Q?xd/HlEnXmip63sXyQFmp2aelGqzYHSdPjuXiqv2kX/7YL79aClmbDOFsnIGP?=
 =?us-ascii?Q?A8V0Bu5kDCJABTFEAwg+D8Qz4Xox5PvYXEkJKy4tir9FCKFp+AvKu7njnnkB?=
 =?us-ascii?Q?9XhjtEtRvqd9zPhC7zrFdMlj7qg/nQKE83onxoBSnBdIiMeIDMAIBHW92fxt?=
 =?us-ascii?Q?7/msYxInmiv1lzqWtMtelv63ncq+y1R+8ouAdKV2AYHJpVid9DBPoj/HwnaV?=
 =?us-ascii?Q?OFz9/qUrJEV7IkXo+apH8KYV0Vb2RFXYk4Ci27g8lzQG+/uZj15NCfYfewxX?=
 =?us-ascii?Q?MizACryxyYzvGPtcmp+khCFfw7KzSPMxBpajJQxm7Kc3vBTdbFkqwrfJyxa5?=
 =?us-ascii?Q?uh6ouk+OaUWzfCCUb6v2vlP5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0b28b1-592a-442a-ee6f-08d92015612a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 07:10:44.4897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zfHDduKGQxyYWSJEb927kICXG2J/gsCFHwrEf93qRN9FhSfInuEXUXRNN6rrU5T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5089
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



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, May 26, 2021 8:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/acpi: make ATPX/ATCS structures global

They are global ACPI methods, so maybe the structures global in the driver. This simplified a number of things in the handling of these methods.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      | 285 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 4 files changed, 136 insertions(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8f44486dc9ad..b332dd9f63ec 100644
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
@@ -815,8 +813,6 @@ struct amdgpu_device {
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
-	struct amdgpu_atif		*atif;
-	struct amdgpu_atcs		*atcs;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
@@ -1351,13 +1347,14 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
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
index 2195e24acb69..0594aa0377c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -84,6 +84,11 @@ struct amdgpu_atcs {
 	struct amdgpu_atcs_functions functions;  };
 
+static struct amdgpu_acpi_priv {
+	struct amdgpu_atif atif;
+	struct amdgpu_atcs atcs;
+} amdgpu_acpi_priv;
+
 /* Call the ATIF method
  */
 /**
@@ -220,62 +225,6 @@ static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
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
@@ -454,7 +403,7 @@ static int amdgpu_atif_get_sbios_requests(struct amdgpu_atif *atif,  static int amdgpu_atif_handler(struct amdgpu_device *adev,
 			       struct acpi_bus_event *event)  {
-	struct amdgpu_atif *atif = adev->atif;
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 	int count;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n", @@ -464,8 +413,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 		return NOTIFY_DONE;
 
 	/* Is this actually our event? */
-	if (!atif ||
-	    !atif->notification_cfg.enabled ||
+	if (!atif->notification_cfg.enabled ||
 	    event->type != atif->notification_cfg.command_code) {
 		/* These events will generate keypresses otherwise */
 		if (event->type == ACPI_VIDEO_NOTIFY_PROBE) @@ -642,10 +590,8 @@ static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
  */
 bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)  {
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 
-	if (!atcs)
-		return false;
 	if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
 		return true;
 
@@ -664,10 +610,8 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade  int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)  {
 	union acpi_object *info;
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 
-	if (!atcs)
-		return -EINVAL;
 	if (!atcs->functions.pcie_dev_rdy)
 		return -EINVAL;
 
@@ -695,16 +639,13 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
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
 
@@ -801,37 +742,7 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
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
 	if (atif->notifications.brightness_change) { @@ -861,6 +772,126 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
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
+	if (ret)
+		return false;

< > Suggest to keep amdgpu_acpi_priv.atif.handle = NULL when verify fails and replace the old checks of !atif with !atif->handle; same for atcs also. That will provide an additional check  if it happens to miss on supported functions.* check.

Thanks,
Lijo

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
+	if (ret)
+		return false;
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
+	bool has_atif = false;
+	bool has_atcs = false;
+	struct pci_dev *pdev = NULL;
+	int ret;
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
+		if (!has_atif)
+			has_atif = amdgpu_atif_pci_probe_handle(pdev);
+		if (!has_atcs)
+			has_atcs = amdgpu_atcs_pci_probe_handle(pdev);
+	}
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
+		if (!has_atif)
+			has_atif = amdgpu_atif_pci_probe_handle(pdev);
+		if (!has_atcs)
+			has_atcs = amdgpu_atcs_pci_probe_handle(pdev);
+	}
 
 	if (atif->functions.sbios_requests && !atif->functions.system_params) {
 		/* XXX check this workraround, if sbios request function is @@ -890,60 +921,6 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
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
index 877469d288f8..cce7e8e31883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1801,6 +1801,7 @@ static int __init amdgpu_init(void)
 
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
+	amdgpu_acpi_detect();
 
 	/* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set. */
 	amdgpu_amdkfd_init();
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e9b72e601cee..07f522af62f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3415,7 +3415,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cf0b59860aa78489dc65908d91ff591c6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637575961844067037%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NIBL6ulFIOgjNXRatLOON%2FXmBwNIAzlbMgn%2BYqoN6MM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
