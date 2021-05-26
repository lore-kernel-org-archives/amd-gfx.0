Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284FC47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B290D613C9
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B290D613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D016ED12;
	Wed, 26 May 2021 14:05:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A4B6ED14
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 14:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvZbl+KQ2znvqYiuEdWSoBDDRencFy1vhNXFvpOrI5Eng954XD7vsqCPo2kE1wKY89LU1YN+culYoHckRHYveQ514/wlgLaIwIugHqQnmFrub1YPQDlwnyIFGCQMQ016/QmB37XkuQsjZyTKN0xZHBDPThRi5H9l3CTN9e8mSjNi8RZ6Be+gx3wGvjKHT3CGIAHsvk0qHmAlq8YmTA2ytP+A9ur8K7VaiSuLIYwXDahh+AZwEOzVc07HGLVeGINB43vOw6ZoGYMrIHfkTpXhDC+uNwFdGIGV9oX3WGm3S03jtqG6L83Zrp0aOWN0YHkw33H2t+grYdoHuGNsOZd3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XZ/bozLxw2pJRFmBmMq0XXkGPCLGoy0BUvr27sbd6Y=;
 b=LdPp6Fy1eIlms9S8LHIDcXVBDwFRN5o7xeqcs1T6dYF4HpfNYnL9vFNnvjoc+3E4IYtO87KNUrU3F1RfAiuJK31fRBJfaJBG4wyRvaVqRU1Sfw0cSjARS14gtGYO1inNpwku5YRuH6T6SmMr33PAm+v12AngLu7SIA5gnm1oegw57MdFbTA8fZsckFlHnIU109cSu33QKf9oFps0ffe9eLPmkx49fuKQrvuPhMG3Vf3P0asYzAy36TxeTvvYb78CojTjZ3d6TugWhQAoMpwga4VYz/NJfGukBZKYA8Sr3y98vW9k8NFFWQSaZj74ZBI7rNy96XmTHlk7kImJRZ7Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XZ/bozLxw2pJRFmBmMq0XXkGPCLGoy0BUvr27sbd6Y=;
 b=VLAs+tjOrrTHXV6+bh5S5l1l7y4CfMGlY0AZOWDTOKHKUyyVE6GNM+JaE68f+NyDAo5UTMOn4nz1CyFAcNYdypdYNovyKR+o2dJVUAz15F53IOFNVpUYk3q6XT4XiroOekgr99fpa7CH5yGsAOOaNS6HBecOejxiz4iaC9vzHu4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4158.namprd12.prod.outlook.com (2603:10b6:208:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 14:05:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::116c:b06f:9a20:ebf5%4]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 14:05:21 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)
Date: Wed, 26 May 2021 10:05:03 -0400
Message-Id: <20210526140503.1541686-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526140503.1541686-1-alexander.deucher@amd.com>
References: <20210526140503.1541686-1-alexander.deucher@amd.com>
X-Originating-IP: [204.111.139.213]
X-ClientProxiedBy: BL1PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::28) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (204.111.139.213) by
 BL1PR13CA0083.namprd13.prod.outlook.com (2603:10b6:208:2b8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.14 via Frontend
 Transport; Wed, 26 May 2021 14:05:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b96f3d6-ddad-48a4-5b4c-08d9204f4ccf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41587D78E8FDDCA679B744F5F7249@MN2PR12MB4158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmZXG2dI71/6mepIkIGEm0ZLL2LafMfmEZXZzwL/VVULl8spEBZ0XZq9rbxKrfzt/uCW1u116aK4sAlNsw3qtzHB6eG0VjWbj5FV92oa0LUM5UMrUvVkxhqsJKesI9a8hdLlMiXrQgmKy0R8btj3oXj+TsGs90Op3m3E0tBgJf5EXoiNwqsSWMcrpNdi/IbVwBG46odreWzNe4OQ1DVvXK6D2/Yo7ERae0XbsbgRkUa9YW4JlerdX4LKW/bDiHG36wjgGNddqSbikxs7cqGU1+Rw31uHNnoxYADCAC1eQrBPaAlfrhiSX6DK4cyy3zw/+xMrt/zQazrbMcpuuEXXuU7FMhny2sBQW2jpH9JDcM4Aqmub8ktoZEbBAuuskhyGtaDfmaqdrCI6M8UGXEL6sgmLISPcp01ESgmuKsSaPq8xxhI+PTrABK3s4hsbu7M5NCjbT5fx1WVG5Wb1X1XPznRtVBTzMwJCq9t7Z4XIcCrz2Ifzcr/LYDgtg/Br0N9+iIXGNdLN0Z3IfFVo3LlZhiWPJkBjKl8fGJ5chFRTEY2uX67cVmCX1IV7uKbZ9/UI2P+Y/0mlgC/5hryWIm9gSz0k5JnZDPahGI2xhf8sLAlCQdfZiUbTeXJ9Um8w0fO9Qec+GH8kD8aUEePdBaGQ1JlnD9RrtNEFwdNMV01ODESqaK2Jcyu9OpJSdKx9bbp/RqApaI6ZLv2HBFeFRZ+BmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(396003)(346002)(376002)(136003)(316002)(6512007)(6666004)(2906002)(8936002)(52116002)(26005)(4326008)(5660300002)(1076003)(30864003)(16526019)(2616005)(956004)(478600001)(6486002)(186003)(36756003)(66946007)(66476007)(38350700002)(38100700002)(8676002)(6506007)(66556008)(83380400001)(86362001)(6916009)(69590400013)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LWWBxQ1E+QtZXc06rlopbQQf+vW3KOBrda08yMtthG0oB9QkyVsVhPHLVCuN?=
 =?us-ascii?Q?yATzryXfJfzyC/gDK7j5kGvtnTiqxy05bZnyHLSMNR+G2j0T3GRhONg5GOuH?=
 =?us-ascii?Q?tz5DF/KHIgbQSQVJxty9j91Q/qlcKrrV9WypL8MTLUDUAms+VIonalsUe26W?=
 =?us-ascii?Q?KXdFJzxy+pnz0pJ+YobwjF8d5O2SGLsgLWIdcj5XDIU8u3rb3Y1I9d0XkPxG?=
 =?us-ascii?Q?Egocu+dvcfN5chbtXtZ0SPajFxxFgBq2+QEqAhXOw64eKvAJr3Lvez21lmaI?=
 =?us-ascii?Q?ai2B5OBI7KEsFa9zz9uv89sCMpnHUCZdzwM3v07a5ITtQiKzemhcTnu4ez7F?=
 =?us-ascii?Q?KIcp2OM1LzRaRFDxi59ginEUrpPTFHy0uQetoKm4RwcZJYOZLTSF65+YMLQ/?=
 =?us-ascii?Q?iUxA3qzNV20DjPGTAsmp3cEyWyjQ/4VM1J9BafQRYv2xmzCDtyVZKikNPXiW?=
 =?us-ascii?Q?GC290OL7BQcgN+H41TmhSJw77atzLjGwTuSP7TNT62k1KjgKTutIuykzVBDM?=
 =?us-ascii?Q?wHEVfAAPri82jNugOKaiZK+7Q8P/ttA5yUVEQGCsWs5iYnAcpygZr1irRBU1?=
 =?us-ascii?Q?K7D5r2lauygeny+X6WlqJ9kHYtszxu84YIbIr8ObB/AcaB9WBCc0llCSGe17?=
 =?us-ascii?Q?sJQxN/n+XR/NTvRsK0dJ2pQLPHybFT8/4N0f+o1jftTRIJXUfMg1LJTg1hOZ?=
 =?us-ascii?Q?nndW5hA0uNjZ1Fo6HuZNk0gNa4rLhJeqXWth/K8Ehy+4ZKkEqkJe9JwOpaim?=
 =?us-ascii?Q?KyQBW6ydvCCxZihDMXtrJ1bPMSOSre5ygwwdmMS+QA2hONXdxFaVDMqIJnH2?=
 =?us-ascii?Q?TcUSu+ZazWUijcKoaIEZTffOH4+tVHD4EOkwsKqTSNlQG0oZpbP+DCgtdVSh?=
 =?us-ascii?Q?A+8SSllt/zZCSkkdB/aIy9e5h4ypHcnl/sKiqSnd+s63PNIvByGYcFIoRR5c?=
 =?us-ascii?Q?Z5+Rw7wAbyi+CUKFlr6Odu5PU6eQbgE6HrddplUh/lrshMpOs5uyY5D+JQoM?=
 =?us-ascii?Q?35KjTufw8wifvnepaV74qw70X1qM8PfCVWgbxVCm6uIGj26sJjCGhw2BzIuj?=
 =?us-ascii?Q?gDlOYwUzhXsR035Pi78u9TyHuocELWZXXOsV21Zn5PofwZYvruapIo/TQIMu?=
 =?us-ascii?Q?MjqUP0S+LPsOEoLnYvzw1mguTJYhgt/HEnKDju66bQUZPoJBAB6p+gEycYqK?=
 =?us-ascii?Q?5+EuX0lpJpnzkVOdol/Om9aYmAsyg/3L8V3izn/CkyLBWfPczyG6rHGb3WCB?=
 =?us-ascii?Q?MF25aJdxjA1BAELVXalC5FhL+G/xpb8k2Mn98dxVwz/NTkvpjxvmL6g7Q8LZ?=
 =?us-ascii?Q?gmLJkdY5JAIpH63B8P8isZLd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b96f3d6-ddad-48a4-5b4c-08d9204f4ccf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 14:05:21.4999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD7BERG9CU6CfzAeyXQQCOx1Ts5KcKeZXcSg7gOGbRsG3BS7TiWTmSpFp2/gar2Bnc6sEK1z1XPxcDxxU0jPaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4158
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

They are global ACPI methods, so maybe the structures
global in the driver. This simplified a number of things
in the handling of these methods.

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
+void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
 bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);
+void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
 static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev) { return false; }
+void amdgpu_acpi_detect(void) { }
 #endif
 
 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index df216d12c507..5caa54ed6662 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -85,6 +85,11 @@ struct amdgpu_atcs {
 	struct amdgpu_atcs_functions functions;
 };
 
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
 
-static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
-{
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
-static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
-{
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
@@ -455,7 +404,7 @@ static int amdgpu_atif_get_sbios_requests(struct amdgpu_atif *atif,
 static int amdgpu_atif_handler(struct amdgpu_device *adev,
 			       struct acpi_bus_event *event)
 {
-	struct amdgpu_atif *atif = adev->atif;
+	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 	int count;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
@@ -465,8 +414,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 		return NOTIFY_DONE;
 
 	/* Is this actually our event? */
-	if (!atif ||
-	    !atif->notification_cfg.enabled ||
+	if (!atif->notification_cfg.enabled ||
 	    event->type != atif->notification_cfg.command_code) {
 		/* These events will generate keypresses otherwise */
 		if (event->type == ACPI_VIDEO_NOTIFY_PROBE)
@@ -643,10 +591,8 @@ static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
  */
 bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)
 {
-	struct amdgpu_atcs *atcs = adev->atcs;
+	struct amdgpu_atcs *atcs = &amdgpu_acpi_priv.atcs;
 
-	if (!atcs)
-		return false;
 	if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
 		return true;
 
@@ -665,10 +611,8 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
 {
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
 int amdgpu_acpi_init(struct amdgpu_device *adev)
 {
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
 	if (atif->notifications.brightness_change) {
@@ -862,6 +773,129 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		}
 	}
 #endif
+	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
+	register_acpi_notifier(&adev->acpi_nb);
+
+	return 0;
+}
+
+void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
+{
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
+void amdgpu_acpi_fini(struct amdgpu_device *adev)
+{
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
+static bool amdgpu_atif_pci_probe_handle(struct pci_dev *pdev)
+{
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
+static bool amdgpu_atcs_pci_probe_handle(struct pci_dev *pdev)
+{
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
 		/* XXX check this workraround, if sbios request function is
@@ -891,60 +925,6 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
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
-void amdgpu_acpi_fini(struct amdgpu_device *adev)
-{
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
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
