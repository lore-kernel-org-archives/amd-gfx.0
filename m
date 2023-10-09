Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2BDCD611E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E1010E2A9;
	Mon,  9 Oct 2023 18:33:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A85E10E29B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQM3bFUklV0/XyhQ1uBlDDlX6dpgGpcViT9lyZtV8400GBg+vLL401wzBKtBwn+3DaACkgrhAb/EVpohb0P2aPAgQ08tuewjOEcSUhR/inb7SyGQ3kByEwPS10bBtRkKvIuaxaEBb5JVvmmnTktjI7zMwt7qUmmfoPCs4WS58KEFia7f+H8AVjVY+3HInmvWO3fqNV0kP72e4mjA3+8AU9qhy7hUhAWM72aSOMP9DViLXM3ZNv3L8h89uYeepA97VnHp+TjnXgSMdwQ9s85C2ZszG/aec8EPZxbZHFp/O/vXw8AQzA1W/+6rPyV7fpSzcvO0I3tvGcoEZaNUchazew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ExaiG68mW+GMunP5UIlXoefAB2nsOl2JPwKF3R7ehI=;
 b=jhX80cZ3nSZ51VqY7Epl6C652wF9GU/S/KHyIHxPbe0hvaggltE0Mv2CafKuLwISjC5CgbPr6nED/PJDl9tIj2f+x3K6M0Sz1wHXnZwemE+4Fn+HrxyHUU9gUCg4Mm2NcXSrAvMEWRxPl5+u/cxshyzkWPCZZHsfbBlhVb0OYuXDap1YbxU6ZPPm28TGPtMPR1z54yOTvE9HfCv6Q9gpe+auoVNHBiHQ0zNBlRm9BBk6+5gH0RLZMtrdnOxah+mKhyYpbS/agAwkqFyF6Fu/E3iqgXlpn227RAlyUNCUD1EhCD5oyVsbeo8/oSp4K1uzoO4c+Iicf3eAmm5tEkhD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ExaiG68mW+GMunP5UIlXoefAB2nsOl2JPwKF3R7ehI=;
 b=N+HcN7vClWyQgD+KQN7donZ4L4xxWg6IbQXALVihY3aYh7oWxQFEUWXfJSDEnp+goakspY6bRgW1i4zrMOhcVy7YXaYqvAFKIp3zrLMJGxm4Z11nFbimimesC9SERFVcaHp8Ua8yFceF2Eq0jrgmz1G/p78zlxyQybOvGSjaZC0=
Received: from BL1PR13CA0336.namprd13.prod.outlook.com (2603:10b6:208:2c6::11)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 18:33:10 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::4f) by BL1PR13CA0336.outlook.office365.com
 (2603:10b6:208:2c6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 18:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:33:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:33:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu/discovery: add SMU 14 support
Date: Mon, 9 Oct 2023 14:32:34 -0400
Message-ID: <20231009183234.518379-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183234.518379-1-alexander.deucher@amd.com>
References: <20231009183234.518379-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: eb06771f-3677-4c21-dc37-08dbc8f6304a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOAVioN1KoIIdL7hcGvoTGqrDM/8uyHQTNVOy1155+ZMBEKBotE/lMgc7uCgTcenyF/iARqdr4J/Ph79pHG63yXk0UL5CFjwxIaaoI3I6cxey5X8dYtQS4IxpRGlnm00s+WBF5YuCyNujVYzo6zNtBf9fD5WddW4k2h/SuFhvSChr08JHf7aBLiv8lpbGLjIXW5uGn8x+SboKyayQqRizW8F9VMtO37G5TYDQn6598a+dUD79QsObO8OvONQBIpAO6xS+Jf3G52TtXf784a/jVCwiyl0diQb/QayGfFv6aSufyp8A6lKtxZ390Nwx3RKpN9HiBFF/mVE25Mp7YcX85kxBw91PYrd1tzH3VwgQZup+4e8oWaXfZVt84fI3oGud1kS0ThjWIuLjVS37Bl9iYBctrsdQmwIuNcF4A3N1HOKXSeKKBXjUtCQUWDQo9cUYECvhFnEhdkCrChJHJKDGz/ksUcjPTQ/rJiKmB/e+Ir7jeI4Loavx1y3JXbCIkPxmhsnic2hp7UJF5Y4XrEJDkkgL2MHRQlXYuLMhlhNr18r39ETBGSpm33ool0ambr32IbqrUIRk+T1z/r90zxwM4ShBb4+iYNoZVN94+UWpzyhgvrJDnlSKlI64g8Rx80PWn22VBG6a4+W7qcGrXrIimzlyx5vqOfQgL3w2PIngJlkHgmRpd1SSqA36UJ6Y+4XGUDbSdXbISUz9bENmLXBxaXHOZY+ihxh/qzYzqOkfJgiE5NMXoeQzmJQJ1oq05ON6q+pCVptZ27rOp38XlCqFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(7696005)(2616005)(1076003)(40460700003)(82740400003)(36756003)(86362001)(40480700001)(81166007)(356005)(36860700001)(83380400001)(336012)(2906002)(47076005)(426003)(41300700001)(478600001)(316002)(26005)(8676002)(8936002)(4326008)(16526019)(5660300002)(70586007)(54906003)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:33:10.0310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06771f-3677-4c21-dc37-08dbc8f6304a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Li Ma <li.ma@amd.com>

add smu 14 into the IP discovery list.

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c  | 3 +++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 68aa271d5aa5..17d4311e22d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1846,6 +1846,9 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 11):
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
+	case IP_VERSION(14, 0, 0):
+		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add smu ip block(MP1_HWIP:0x%x)\n",
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e0bb6d39f0c3..ff72db95c902 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -28,6 +28,7 @@ extern const struct amdgpu_ip_block_version pp_smu_ip_block;
 extern const struct amdgpu_ip_block_version smu_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
+extern const struct amdgpu_ip_block_version smu_v14_0_ip_block;
 
 enum smu_event_type {
 	SMU_EVENT_RESET_COMPLETE = 0,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index da6f018aff12..0b4f9f2ca529 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2268,6 +2268,14 @@ const struct amdgpu_ip_block_version smu_v13_0_ip_block = {
 	.funcs = &smu_ip_funcs,
 };
 
+const struct amdgpu_ip_block_version smu_v14_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_SMC,
+	.major = 14,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &smu_ip_funcs,
+};
+
 static int smu_load_microcode(void *handle)
 {
 	struct smu_context *smu = handle;
-- 
2.41.0

