Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4B606A320
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FrftZYgg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC7B10F1C6;
	Mon, 26 Oct 2026 23:03:25 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C57C10E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTaRvnUKqyNGBLdV9zmb+q5AhDL6rohEabQHmQz3ma/psRprmcF82cTCzSXyLDh7wo5mZEwDQ657mVI2kS+HdN6M0FLIEt71reU8M+oSsJ34MkSgLLA46+lg+Bi2cFIRE0ZO3rcasEcVchuQtRIytz0LH9hSnCizCNbXtYp2h8z34il46n5wBzMiViecVF7433Mm8mXTtxlTr69X/49+l5K0VEs7KrsULs5bWaddBc+6IkrFOdsma02IKy78qHf5bAGwgucHqwUgmigh/w9Kga0waQsOX85TJAnuYu2KqTWQAYU9nRajR366mMZ98NyfYTi8FjfK88XhsE0hD0r9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW4Is50M64xkaJethLifVmRfKw6Os04ztyrOs37mKUM=;
 b=m/ZX8+1w5QOMmlyHc0tT3o6TUzi5pnusYNBeRarsg/EIxDC54ZeP7M58xXr+K2p6AoWQwNGunlBA5aq/vQbt9/c4pb5Kemkb8YLQiDcs5edK3WGVso78M/E41Bjv7w4bLKLumdC++ExjT3sLHP1OzYgfBplgLMgdzG5Z1Qprj4SVYLAeJIgPZlDjLvw0YJHzFxth6S+o8BR6yFak2Ao4ELtMTTJZdr2YvTDCkTfuO3t/i5anPG7Q0tL52nNjzjqUDu1eneLLK13AuUh6ZjDYFf4jH3uiqJ8LlQoYynJBv4Ccx9X6uOa4jTXYDWVMD8Cx3pQU7eGD9M2xwTkjmInPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW4Is50M64xkaJethLifVmRfKw6Os04ztyrOs37mKUM=;
 b=FrftZYgg1UwnHHIFVGvNPJKqgL53QPcylhiu1pYscaSoXQuFvjwX4WQ+2y/uwX4uqxY+4VjLeoasJIoaAsgaHCsHNPC1O5rcEkXHPpiG31U1Bv7O16ffplQ5zlLp8MFlJwNcRTtLuzrwEBpR+QcYESJrjwDiyehjPBRqG4ps2lQ=
Received: from BN9PR03CA0963.namprd03.prod.outlook.com (2603:10b6:408:109::8)
 by CY3PR12MB9655.namprd12.prod.outlook.com (2603:10b6:930:100::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:07 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::a3) by BN9PR03CA0963.outlook.office365.com
 (2603:10b6:408:109::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:07 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:05 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: Reject config updates in UALink loopback mode
Date: Mon, 26 Oct 2026 18:59:29 -0400
Message-ID: <20261026230248.1597606-8-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026230248.1597606-1-mukul.joshi@amd.com>
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|CY3PR12MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d976b12-616c-42a2-b2e2-08df33b54c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|6133799003|22082099003|56012099006|11063799006|261021121427099003|261022075727099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: HPReFPzRtxnOdg5nwWSXUuazUXLiKxGPjekHrfwZZboJ3jh5BxIir7JyeDSWBiWpcBHu50AD2b7R0QR8rmICo9E7QukojT4yqbcJ4U9UNc+Ncq+IgjiMR+7xXBIHylb5apnoooV8bdrQmnVwNL4dv+6avolB0eyoUyo3vDu37O0O7SUB2A2dVIcSF+mrq4eKQJYDPc9Chu5O9XwJSBC0CkR6DmIUd290sPz57D/SmYLVxXlxNJKiC91A7yKKCzIWXbm7YoxMm99tN2zGooqFZ+KzUWaOGaRokPQ8Eoyn0MqdhydYFp90709dFB05Q3cPrYRgRJYIAWM98+T3jbmSbi9sSPMIK/VdXB3HyI/mQMkr2+V9FRtI19eqPAMrSBrzdlRVOKubgT/bkSHAuBBlnO4mWeAmE9mXWvBNnICEHb50nyaZs7atSMHtGqFvkLvOKWbFUuEDaBmtbi0oUVpp2V6Vjhlkb4BC1gcGcDvpPCDVHNtBj8shvwBtq6KyEFA3cJbRvoo1YmtIH1fwmHEZUyt7d3/h7M2I7WXZbt8D8St0gCo8GRgoZMsWqfRBrcjfEFTx8Bytr+KtcATqjacmPdxoiZTyji+CAoavpu7VNPB38g2hihfrgNNml9RRsdaMQdji97RMp1a+N7I266NxkxvE2CgiNK45Jjql+1Izz7ocXzbHRJJDUDoXeFCt7XPcxxUOg/P3pB9Zdh767CgbPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XJUsE14gNDLuMCVekUmlAMBD4WqkAXQWm2jZzKzQFoFv131HDSvdibgFmVGECvqn57keCXGpZEy39MW32VjXno7LlbW/KMdfCD9VvaC79MBJVACZASKRp0KeizAT9NRH7lv0haxe777uNvjVxARVRD2HDu/qAoz+7nmN+dQWt/sQ7OjSbXeBSCvJTFeHizCYIQAOjiXtG9KMU5gkqPaqyeNomiHdsz62h4JDwyeUIirmYPLEizGtBnhK1C8RtfheD8KgGPNaus6rhbzmdtyPu8eJj26wWvvYTdPsRnJy+BjzpaAQFjvOE0Z96srx/rWlrx1KkCgkCSS3slXD5biulCP0lBF7PIpDjnKDBTm8zRBJhGLJm3WGQkBwbUwSY/7rKWofkkenZAL1KSRT6/JoDsnNGiz6TJNx0jysIGB3hbDAi0rdgcGG3jQckK6XXH0Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:07.2062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d976b12-616c-42a2-b2e2-08df33b54c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9655
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
else from overwriting it.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 1e30391e2e18..204758c0fd50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -483,6 +483,18 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
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
 
@@ -1128,6 +1140,13 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
 	if (!sysfs_streq(buf, "true"))
 		return -EINVAL;
 
+	/* The loopback pod configuration is synthesized by the driver. */
+	if (adev->ualink.loopback.enabled) {
+		dev_warn(adev->dev,
+			 "UALINK: ppod-commit rejected in loopback mode\n");
+		return -EPERM;
+	}
+
 	r = psp_ual_set_ppod_config(&adev->psp, adev->ualink.psp_if_ver,
 				    setup);
 	if (r)
@@ -1552,6 +1571,13 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 		info->accel_state, config->vpod.id, config->vpod.size,
 		config->vpod.addr_mode);
 
+	/* The loopback pod configuration is synthesized by the driver. */
+	if (adev->ualink.loopback.enabled) {
+		dev_warn(adev->dev,
+			 "UALINK: vpod-commit rejected in loopback mode\n");
+		return -EPERM;
+	}
+
 	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
 		dev_warn(adev->dev,
 			 "UALINK: vpod-commit rejected, ppod not configured (accel_state=%d)\n",
-- 
2.55.0

