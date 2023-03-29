Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A7AC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 10:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F4310EA64;
	Wed, 29 Mar 2023 10:10:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DB510EA64
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 10:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuPVv0tCL0tlTT/m5S2C398MlvcIjalqnwC893wsVsPguJmZaWsOVChMFpnvebXqihz61TkZd7joeMwZ4m0jkS2tB2BVx3zWRf53mEI7ynj+uapdMAkEhxnz78/0RW05dJMQOyaCDIT7A9vzXr8SV3y4WpvsJmiVT0AUYQdTX/eEI0Bq3tNDv/I7a3RddT27xy8j+255zSE/s5lGxoUnEzzIAzgkWxMhICT8nhNIW18KNLLQaPlNqPOeKuPNLfd/BB6Xij71GnzTGvz6sXg4TCnWdZPdDgsqlu9fVLfrhD07wOvCFQubQwzolPLTFhIFHVDoIjJpon/LcSv1OZZg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAmj2loP6cO4LYa3avAxy7W+vg84hkVpYUEITqZ6Yao=;
 b=QNPxX3W0ZMZmFTZI6lZoy2l4tdWuHGSaKl7iasQrCk+SgfhmSNeWaqrr0tLxTbomB3NWMsSXvEJqtkfF9DJNsUW84+awHL2fcSMejnj92UWYSehLLoroGw3CaJeVAxVA4dx1LNymUb/jvKAsTbCFAUImMM+WI9SN1ZIbzV0iWtlP3Un8dmSSDYinuOyzUfkz4Izb4F4tulwDvOHwvpGj9iHMCfnxRbGEP8k77+vajmI5xvdSp3FAl3G8XUx+LIeUo8pzDjZNFKc6EWqIZGxdRbkXL5rXZxe5sk/vB1glPrheB7RXniEjPQgWGXd4QLTIzVdyu2AemEuCUwHvcx/wZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAmj2loP6cO4LYa3avAxy7W+vg84hkVpYUEITqZ6Yao=;
 b=b2OeoLIGfhBfMmGRGJe6krOJm/IU0yxCkJ3ufg42qfMt+YcP+9hwkUkxJfoXcEu75dJkT7tsB98nwB+DM3BpUw/XPju9i9d1t8pz3GzJL04U5HaVXqS9U0c/0BgKX6iHXNaAVNomxmoAXP23ILHCIPEZWOKtaM5A0ZcnNBvWSgI=
Received: from DS7PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:3b5::32)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Wed, 29 Mar 2023 10:10:54 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::2f) by DS7PR03CA0057.outlook.office365.com
 (2603:10b6:5:3b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 10:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.26 via Frontend Transport; Wed, 29 Mar 2023 10:10:54 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 05:10:52 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: introduce gc_*_mes_2.bin
Date: Wed, 29 Mar 2023 18:10:33 +0800
Message-ID: <20230329101033.2581741-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6037a36b-c186-4b5c-a371-08db303de21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxX/Fw66wK0hh2BAMECSFZLSJ0y5fqJu64CZQH2cSN+6o/eh6O71Pnp5XJG8gG+rVZc6e2+Bd32Im64dan+ogRBSX8+dIugFdeD3RTfQccUgerXRJksKUnuy4F4iNZb9WeH0sBQGKqS8R7vt4ASD32OTdwwDRluUWX4KsoGKidVJiZ+nzxeCDr+AUuUPCLWkzLkCca7VbC+JrQ56xfdWRKSYaw3dBspnU5IKemFy/0DwrJOcYPw+J01htiNi9FUsepFYu+V3HAX/TBq5o4Y+bUxfwHXgk2d3FEcbsGqwPZ7Sum6zUjtPZ8WWrZyGSbVkyrESjzWjhenJVMuZHkJ6Z55hwfyy8USAn6H1iGQXQ7ecvkBi3XkM4UwH45ceHkjXyZskI6JCkBfRKls6rdNSmbexL2ApY+FAs7ExMA5NRv+z8sx8zXy79i76XNqzJPGBVORskVr0Is8SbpV6WgGc+ONbWblkIpCOa6EQu+VhCHJDtwu3//7XjDOhdNjc+mgH6JIxa8K6kWpZtudh+WOj5cXTprFEPzqoNJ5sk8jFrE4d/FuCoGmPI2Yh/TpvC4IciPoMk/8TpaNdvaxA2jA7axUdLxuMw2nrEiegf3MNCnKFIExV4x2tjGsGtUQ1HuoEHo7V4A3VkUE1k5hbUJ1PPNaEHf5LEUJvPDZpoBI4ikxzK1/dw5xnNTIC6YIZ3pE0Sg+pTP/tGCsZZExVPWEc5qAELVO3mmH6KYnAwLr0s4/67RqQDg+O/fV/2du5O1E0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(1076003)(6636002)(26005)(81166007)(83380400001)(5660300002)(426003)(86362001)(2906002)(82310400005)(356005)(8936002)(47076005)(336012)(82740400003)(186003)(40480700001)(36860700001)(70586007)(16526019)(316002)(8676002)(70206006)(2616005)(36756003)(478600001)(7696005)(41300700001)(4326008)(110136005)(6666004)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 10:10:54.7072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6037a36b-c186-4b5c-a371-08db303de21e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid new mes fw running with old driver, rename
mes schq fw to gc_*_mes_2.bin.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 26 +++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0e55823ef6ca..f0f00466b59f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1434,13 +1434,31 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	struct amdgpu_firmware_info *info;
 	char ucode_prefix[30];
 	char fw_name[40];
+	bool need_retry = false;
 	int r;
 
-	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
-		ucode_prefix,
-		pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
+				       sizeof(ucode_prefix));
+	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
+			 ucode_prefix,
+			 pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
+		need_retry = true;
+	} else {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
+			 ucode_prefix,
+			 pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
+	}
+
 	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
+	if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
+			 ucode_prefix);
+		DRM_INFO("try to fall back to %s\n", fw_name);
+		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
+					 fw_name);
+	}
+
 	if (r)
 		goto out;
 
-- 
2.37.3

