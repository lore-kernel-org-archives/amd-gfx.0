Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEFB606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TnHqxu5Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1122610E47E;
	Tue, 27 Oct 2026 19:59:49 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A15F10E486
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 19:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHCVqFKUpnDlTDd6b4WvKb6eB0QQkA1mSlJ6O2rPTfy2/E0wm2P5MAMqLTLsmgNYKNUtrWRJQAIzJze32FYO8hM8O9XflLzwGNsPGsTCrxvrYQiim/Rftcz9ooOjUifrjELq+EkvSgambo673SNoroLoEMpmK0DQ35+pvYV6Dz5lMvWNpF8do71MRKAoZjYIspAydJy18h/We5SbFDDuj3TZ6vP+pQbUowPq0tfuVxf3XCUN/ORufex188aCi7Gy1YVKNV7OV+GFLc7x5LSeFjbxgfN8L94h9ckNYKwSClZvw4t8+tbh7JdMdgQluoWkAUJ54uysfd1b3D1lsELxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+TEcSc28qat8yAzcNf09fq6NGiDvV7cScUK4B2/F5g=;
 b=iHx8jaO/D/qJygbQphapjrB3Sp1pRt+Ix5eTlHOdHhFN06BrPtljzqiyuEp4v3VWVNeLF0u39FgS/TE3pPjjG6hkBQxnO4cfdoEJvGPY8q6DUD30pfW/7pPYAEW4Nnavyx1I38bQAM1Hd880mJVBySBfEoYktRzaziUTbENQSO47zluNpWy82RqYVuyyXaSHhO/bt5RfoTyBO4w3tRY4rzYKSMZPDHCBfCQIgGoSZvUocQCNj6NFI3DaHMtcNt41zZWjkJp9mFKBLJpWO/GMbPmac0IjLr69v0ak15jT+4KWjOMCDiOgW5uhvX1HBV8fjRwix2z22tuSm1hm+bFbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+TEcSc28qat8yAzcNf09fq6NGiDvV7cScUK4B2/F5g=;
 b=TnHqxu5ZOKcywM34c3W37g0O4ebWNn3vmJllbHQuultmeA6KIwxMWXvNmpKHmntQB/TbNWvMDX1VBu/Dq9fHUNNAQs9+SbvSoAJAiJ1og1sKmKM/CNIl+R9DNhwBm4mxmbEKbxf9OT0DWplNByJt58AzzZv6wCu68LWAhGJ0E5s=
Received: from SJ0PR05CA0071.namprd05.prod.outlook.com (2603:10b6:a03:332::16)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:59:36 +0000
Received: from PH5PEPF0000002E.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::62) by SJ0PR05CA0071.outlook.office365.com
 (2603:10b6:a03:332::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 19:59:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002E.mail.protection.outlook.com (10.167.243.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 19:59:35 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 14:59:31 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 7/8] drm/amdgpu: Reject config updates in UALink loopback
 mode
Date: Tue, 27 Oct 2026 15:54:20 -0400
Message-ID: <20261027195913.1794477-8-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027195913.1794477-1-mukul.joshi@amd.com>
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002E:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: f5000ec4-8631-44fc-8889-08df3464d369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|6133799003|22082099003|18002099003|261026121527099003|56012099006|11063799006|261021123027099003|10067099003|261021121427099003|261009223027099003|261022105027099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: E7cMGIyb6uvtwzIWuNMDabb3M3cyS+LATwlk+rtiaizTY9sMsU4udhrrqqmhJAPgNrlpI3YXXWs3UgS0fylJP68fFp5xVOkyZhfKP6FJl1Kk+A7aklIMkh6RHg2X1y9i05xS0DhlGBOheTuQ7WfgDN/myU9xvcsGQEtZ9sv2LxArQGWNY3SsfliQKD79T2xl1v9GsHY4wKikgddL9BW1gEqh9K5Ene2VCYYbL7joYY2XyUpxjaMasrHouHOCzMJhM4WmPMVL0have+lEv55G196CfeUqAqFAhjfqFqSUk/NtvtPCCdiUgDbuZ5ITEbafr1oIq1VwEHZxB2XiNM7P1/dvDumUJ19KtJVZF26S6d4I+eGrTOQELR5fVSdVlzTe2/tsND4UlOYsYtnYvdtgttLurkBDBbK0TZ6uOLXIXxUE0dGxTIC8wOMLwCKUOFhafvbG9yHZ3R03TGg/sc89eXtjJunyJWnXci5Z5OpEKjIV/oNbWXbSXGJvCHhHAyl16ddMwstkr2hBZJ7rqyIK9ZIjzw81ICBVIsMrF/xs5EiLIFIyCSkXHnCYFUchqSBnZvaSFhuHwue2pu26yeJZCEm2N93oY3gGICoOtJXf4xBDAwKw0z+qlF7T3pPLegDxX6NQ0dcZPhAZOSBD9HqpZ4Z5v8a1aZP0k5Pplgiqc9kvPf0jkRw+wRRcBMNlnBqfyCK7NFtF3W3GXxpGkktvnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QfSREH+iyHV+j8/lETPoBi9QiNA/Y6Cxpk3vMnaK54zyveR8taBpLiNfwzfQYsf+l9fxmY7gbDroWHSbNPdO2UVGMlNiobN4DG4kYKCSvOx7c2HpPNiWmqgPtPH7TrEsm42e0f0etPRy7hEDBjuTHWrof/CvT/ImNuejxIb/CBamsoblBw3QE1LyF6kUIoMqlsQCG6fZJ85uDFdjmUSiFslBPc0fhh946SuclRROzPnkZSbQA2ziquvmhiqVn3EeP42elxoT4cvp0x1P+giXFaJ5dttQQmZdj4BlAaIKfZyrZ2V+Zvz7OmLMWfyOHNBrO1ncGf6Ut884ii8wgUeEHuVr6dwjDO2d/dd0uBa26nVfPXsV+24pzccp34kEOYnXA/vSI5e/UzHu1PxCVWKXUJTbmSnOXBIdfz2cAUWrDEXZ15deRA5YNlrUT3cuBxwe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:59:35.7459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5000ec4-8631-44fc-8889-08df3464d369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In loopback mode the driver synthesizes the pPod/vPod configuration,
since there is no user-space agent to configure the pod. Keep anything
else from overwriting it:

- Ignore PSP config update interrupts. Re-querying the configuration
  from PSP would replace the synthesized one. Still send the completion
  so PSP is not left waiting.

- Don't create the pPod setup, vPod config and station config sysfs
  nodes, so the configuration can't be committed from user space. The
  setup, config and stations directories are still created, empty, as
  they are when the config sysfs nodes are compiled out.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Do not create the config directory in sysfs under loopback mode.(Lijo)
 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 49 ++++++++++++----------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 14b9c05a0f0f..1c2203ff175d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -486,6 +486,18 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
 			PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, status);
 	}
 
+	/* The loopback pod configuration is synthesized by the driver, so
+	 * re-querying it from PSP would overwrite it.
+	 */
+	if (adev->ualink.loopback.enabled) {
+		dev_warn(adev->dev,
+			 "UALINK: config update ignored in loopback mode\n");
+		return psp_ual_send_completion(&adev->psp,
+					       adev->ualink.psp_if_ver,
+					       PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID,
+					       0);
+	}
+
 	prev_state = adev->ualink.info->accel_state;
 	prev_vpod_id = adev->ualink.info->vpod.id;
 
@@ -1779,7 +1791,7 @@ static int ualink_kobj_add(struct kobject *kobj, struct kobject *parent,
 	int r;
 
 	r = kobject_add(kobj, parent, "%s", name);
-	if (r)
+	if (r || !attrs)
 		return r;
 	r = sysfs_create_files(kobj, attrs);
 	if (r)
@@ -1794,48 +1806,43 @@ static void amdgpu_ualink_xcp_sysfs_fini(struct amdgpu_device *adev);
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_info *info = adev->ualink.info;
+	const struct attribute **setup_attrs = NULL;
+	const struct attribute **config_attrs = NULL;
+	const struct attribute **station_attrs = NULL;
 	int r;
 
 	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE)
 		return 0;
 
+#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+	/* The loopback pod configuration is synthesized by the driver. */
+	if (!adev->ualink.loopback.enabled) {
+		setup_attrs = ualink_ppod_setup_attrs;
+		config_attrs = ualink_vpod_config_attrs;
+		station_attrs = ualink_station_config_attrs;
+	}
+#endif
+
 	/* ualink parent node */
 	r = ualink_kobj_add(&info->kobj, &adev->dev->kobj, "ualink",
 			    ualink_info_attrs);
 	if (r)
 		goto err;
 
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
 	r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj, "setup",
-			    ualink_ppod_setup_attrs);
+			    setup_attrs);
 	if (r)
 		goto err_info;
 
 	r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj, "config",
-			    ualink_vpod_config_attrs);
+			    config_attrs);
 	if (r)
 		goto err_setup;
 
 	r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
-			    "stations", ualink_station_config_attrs);
-	if (r)
-		goto err_config;
-#else
-	r = kobject_add(&adev->ualink.setup->kobj, &info->kobj, "%s",
-			"setup");
-	if (r)
-		goto err_info;
-
-	r = kobject_add(&adev->ualink.config->kobj, &info->kobj, "%s",
-			"config");
-	if (r)
-		goto err_setup;
-
-	r = kobject_add(&adev->ualink.stations->kobj, &info->kobj, "%s",
-			"stations");
+			    "stations", station_attrs);
 	if (r)
 		goto err_config;
-#endif
 
 	amdgpu_ualink_xcp_sysfs_init(adev);
 	adev->ualink.sysfs_init = true;
-- 
2.55.0

