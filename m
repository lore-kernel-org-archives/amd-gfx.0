Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C04606A598
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IDJvv+0Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9640E10E648;
	Mon,  2 Nov 2026 16:02:30 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB20D10E637
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1v3IZZM2Fk6rQTddIwQVOVFFuqJhRZr6kCNxZ145SWmgrnDPyIPry5F8TiObzFis2O8DP3SXwydADpUJ2BR56Y6Z3q8ykWm1+9oCKfcpE0/yO5PcPFYJQJ+EceyruxSkPTeZSYYdzUZl5DIfm1N/Jgo1KLRuxU6c7gJ0x8MYdKvQc67/wGtMq5RJaeAYe30wEjWOza/f6PI17EcNWOSSUz3cULwND61ExUCVUnOoj2EV0/ma6Yt/GJJQ6772PEXXmzTm9fstYPBfubc4FNTLb6C2GzzvNpbO6NseBReBXe1cqyrXQXKv0c80JoLaXe2DL/+ckoYGsFc6nTzderFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN9+pog2ejDY5jSyQYOtzjubENVahMKk8/OZqjPpzbg=;
 b=s29eUKDX7mteP+tmmSxARwK4ixfzmbdkPyGENs7VbtxR8aPmcN8FSUdR2YaJqHNs7wkgSU9XK3SdtocopNPvLMvld0kgHNcX5KN6d/ENo03TWVJtrDly4Nc5Y5NikbYkyyahDnEJZ7ylewG5ty6JeXKZC6VXbMsn3EIkUrk+8s8Mp8pV3bix6oMCTKlZyVNEPuob/bIdr9Yj3a1ET5j4VqVkFat1kin+nVvJKy1oo3HAbMwc1chsfH5s4YSIqMZ/rvqc3JMJ5Pi3KKJhn311Ss+XzZSO1trP0HI0PfvkRlCF79ZSYOib+MibsSYh6NrBDcS8UoP/mdVPW4Okxsl8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN9+pog2ejDY5jSyQYOtzjubENVahMKk8/OZqjPpzbg=;
 b=IDJvv+0YlCk/DKF341m2s4DU2LOSaXPctULin/VkKzHrTKUK3tWAueN5JxWhT/ZFsn7VVPcOQ1rl3PEi2H3o4fSr6x9NKSCNLb4yQ6brUqHc+CD/UOn4m88BNAlwlKESnNEr6vzdK7BEQPzKpj4TGRdCRG+cH72rH1qv15ze4ks=
Received: from BY1P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::7)
 by DS4PR12MB258939.namprd12.prod.outlook.com (2603:10b6:8:506::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:02:21 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:59e:cafe::4e) by BY1P220CA0039.outlook.office365.com
 (2603:10b6:a03:59e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 16:02:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:02:20 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:02:19 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv3 7/8] drm/amdgpu: Reject config updates in UALink loopback
 mode
Date: Mon, 2 Nov 2026 10:47:53 -0500
Message-ID: <20261102160125.2743750-8-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102160125.2743750-1-mukul.joshi@amd.com>
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS4PR12MB258939:EE_
X-MS-Office365-Filtering-Correlation-Id: 59198087-b72b-4897-2817-08df38faad01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: hBlq4idly0AXZ6ZyH5smN0lNWlmlduaXwNC8WxkTnx1XwqbwRlk2Pre41nnk6fwNNTG585vSBTEZ9h91LrceeOw9LKAvMQORksVX3bkpajamsrfcxte9lyBEr88WoUc0R6rkRGDeUJekuA9F3q8Zaay5looKHbioKqUUNgAzywrQWDXUOZw/icWQckk+bHrmTnB+7L4u5xyFgDEbZQdfo6+qo5f9kiNCdak+EmEe9C7loepWPFjdCAULOWdelkP7UwZKzox0VqAs8CipZPkHwLYBcCJzIs42VSPwPlC5KmeIsD3IGg3oiKtvwDPCSJ1SL942d46OeiKhLlKikEQROzSNMd6Hjh49Zfl4YVLkg3xp3OhgtFNZL4JWGSS/+CjEBrTz9O1wLrcSd5g+kmn3xnhTzCRHcHV2omczX6Ax3GdQcDBDRW7TNIls//eAckoS97Mcr1fVyfl7s8bBip4qULKVhfvXfZM4/J85RIwEslDVXuTPjlyYNMYH1dCiAyYFtGVW4iZYDxZLcdeMm9fEbdfXNLhgNuj5+ODIaM2/E8PgPFetbr3zaVnaoY99gUErVLR5zHm0zVDheQOOerSCvzKHx8jU3sEjYXUtzqXNvkobK6cKXA41E8LF7AK79JYpwjH75JCRApB+NEPWRQfyxYjGhCvFti8pXgdZXfTc1MrOjfwBXE1MoEQ0/xHLki80XFMEPPisxh0DBsk4XKKTvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wNJuRNPTiMyy0w/8WV+yYhZePJo1MaG/i0W3qdOJ89wVJyxbROMW/WGeE8MWqmJHQS0Epbg896vDsOFP3eQqhRIwUfPykJdNbFaT0PjMDh8+QAEQllo55ehHYbF8S3hQHWfu48U0DnqSgpRRi1cyTOVpGprEFUkK5PrFYNcJGxEegAKFb8bg1u7ywEKlwkD/36XmHC1+dS0gDnYmxRo5VSr9zgUjwLlb3/7Fxekc5A7g6kzu0m1CHe3IlduxWh8EZA985yOMD5fc9JSYnmeQRagshFEGpiHFR5mdSo9u1YtlFb3kjzFvpGFHjyQi4vVoX/VnqWqwFoNIqGXRqtEfF2EylTmaTnzDL84OutOkrboPBfY8wGCzjsIfOR3YC1UZDZ3BPRhFc6ilcHdyfKVAbnf72taRwvhSR0/3JfDOc2CYfqbl2brcAR3iqjHe2h81
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:20.4636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59198087-b72b-4897-2817-08df38faad01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB258939
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
- Do not create the config directory in sysfs under loopback mode.(Lijo).

v2->v3:
- Update amdgpu_ualink_sysfs_init() based on Felix's suggestion.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 68 +++++++++++++---------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 2e1e0a677e35..cf2c68cf7115 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -491,6 +491,18 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
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
 
@@ -1820,36 +1832,40 @@ int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev)
 		goto err;
 
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-	r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj, "setup",
-			    ualink_ppod_setup_attrs);
-	if (r)
-		goto err_info;
+	/* The loopback pod configuration is synthesized by the driver. */
+	if (!adev->ualink.loopback.enabled) {
+		r = ualink_kobj_add(&adev->ualink.setup->kobj, &info->kobj,
+				    "setup", ualink_ppod_setup_attrs);
+		if (r)
+			goto err_info;
 
-	r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj, "config",
-			    ualink_vpod_config_attrs);
-	if (r)
-		goto err_setup;
+		r = ualink_kobj_add(&adev->ualink.config->kobj, &info->kobj,
+				    "config", ualink_vpod_config_attrs);
+		if (r)
+			goto err_setup;
 
-	r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
-			    "stations", ualink_station_config_attrs);
-	if (r)
-		goto err_config;
-#else
-	r = kobject_add(&adev->ualink.setup->kobj, &info->kobj, "%s",
-			"setup");
-	if (r)
-		goto err_info;
+		r = ualink_kobj_add(&adev->ualink.stations->kobj, &info->kobj,
+				    "stations", ualink_station_config_attrs);
+		if (r)
+			goto err_config;
+	} else
+#endif
+	{
+		r = kobject_add(&adev->ualink.setup->kobj, &info->kobj, "%s",
+				"setup");
+		if (r)
+			goto err_info;
 
-	r = kobject_add(&adev->ualink.config->kobj, &info->kobj, "%s",
-			"config");
-	if (r)
-		goto err_setup;
+		r = kobject_add(&adev->ualink.config->kobj, &info->kobj, "%s",
+				"config");
+		if (r)
+			goto err_setup;
 
-	r = kobject_add(&adev->ualink.stations->kobj, &info->kobj, "%s",
-			"stations");
-	if (r)
-		goto err_config;
-#endif
+		r = kobject_add(&adev->ualink.stations->kobj, &info->kobj, "%s",
+				"stations");
+		if (r)
+			goto err_config;
+	}
 
 	amdgpu_ualink_xcp_sysfs_init(adev);
 	adev->ualink.sysfs_init = true;
-- 
2.56.0

