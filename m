Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C490FC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3334E10E383;
	Tue, 22 Nov 2022 05:53:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE6010E382
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfkscKYstnrZdL/PD4Y6yAiMlYOapmB3OK/W27Q4Trdyrj/CogVlgZosmvqaokzXUJoXMtEmQYvEi5ff3B1nGTNVcQRSU9QEb4ldcIGHGHafmsOpvbdUrLHwJ6/aAoyiWipd6REkpgqtxLz4Yk15PA/8+HqkIxHc+9hU5adCnqYg0wbg+GvMEPcQgCXzZa6gPqT7KRAnufPYQgNQ06GimNmunl64cbkYTdN/uRcDuhLxWCUNIM5d8IUGY6fhNqAOEcxIijPJ1rAcy2ZEAA07jlBshqK1hQA1NpXfQ7SwiVfsw+vy7vSaVnIJwb0pIZ5vqg8+L3sa1oO0Y8kAfbGlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aIkUld3Fl71z2Qrkj/qjb3nCsxxrQwNZlGdkuZTyyc=;
 b=OcI5QKO6ic2IKKmIOUIwcx3qrnaa6AuOBWmM3HMCDXWOKBuCTw4POAir73tTSyUi2CqoN9bSavZa5VmRyY088BAx2tuwoGasPAqXJc2r2Ma106N3g4f3iDkiKpaEPRta1H4j5GB7T3XbkYtmNC31Vw8z8jQWXpRUDU8VVTaKWLY4XhKFKNqZ83KHlbzWvWC6YXGf6Kvqdl/Wv2nMAK5JvfyitKaWiEd6/YsCSbMvI2inssegmyXAPS3mFfPQDkXRBN+FsT5Dmx8DOfurc3oTYKGsyWApYtw4fMMpXE5/xoSU7Ed/tp09w5WEMykCjFwVUida+cgpViuteJZF9mp3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aIkUld3Fl71z2Qrkj/qjb3nCsxxrQwNZlGdkuZTyyc=;
 b=BD7hLdJMuU6aSM3rxAA9wPFVtVoiqoQ4rz4j04eeU1ROmC1d9VG9uMKN/f5ftSWOlaCKADM4+hg56rh9hwmNR6lGqAdkNSRBM5qXvXA07lbOAGRCLLiu7247i536X3/opU2QQ7gAQsjQZtie3crQYosCAOR9oncW2jd3XRWIwdM=
Received: from DM6PR02CA0085.namprd02.prod.outlook.com (2603:10b6:5:1f4::26)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:53:24 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::c2) by DM6PR02CA0085.outlook.office365.com
 (2603:10b6:5:1f4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:53:23 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:53:04 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amdgpu: add smu 13 support for smu 13.0.11
Date: Tue, 22 Nov 2022 13:50:19 +0800
Message-ID: <20221122055025.2104075-13-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6b391d-a0b2-47a1-d93b-08dacc4dde39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ll9EVDyKBXJiN8HPzxlPh/u1gRyjIAos5Dw2UatcZrFyIoS9uYhQgYTGkc+gIPopCjwXXxLgAPZEph0PfwZ9wJUgI3TYbUdNr1vkSGP3hHzyus5pfZmtoNIGf+T0fozdrsZfjgzIYEFxrh1ZO2GsYivIJ6hwBhURfrg3qX8xI4eNaPd8OOS3rXEpw/gCUn9D8ratfq/NzT5gwPFzkldtfG4an0d1kNlM8hsHRPdGtHjK0GIrgCbk+fv7X2vUcHw6oqcF3POamq+A9sIWwbzrbBWIuwQnfA/onkY0pG/U+6omL4ExvajVZDHjljGSUiAoa5BZ5ENJ0enBDUdee91nKivwEoBSyTe71bAfPjD7E5MR1T+H9IfasMJwZd9sOpLNDdQsYvfh32UQBqC4TatHIvdHSYcH+SQggEV+ii03WJX1kQJTB+O/ugbK2KjcWHT8xtuxXpojQuqGnH2dvkL3Y89ZIOHZiGCZ6+qrmtt2hrGRg367Z0fxdDhcj6HZnHj8W3cgJMIM7O0Pqc8gYQO+yOY5pQfMeBpwQIQm6Oj2iwOaAlc8SYZ92zDGFZ1nbKESRLJ77jQcJJTfPJotKAGPfA/HvKySt/7eTGPUOKH+1NxGCXYSajkW2dXFyLeCEDLaFNfIjzWx7+1EywLYJZnvN8e18nItE6AZk2FQHmhWH9sEHIU7hb1T0718+PArc1cklC3OnK9/84i8XNVJzFDiVvIA8tUVdmJbBxJwL4hdr+w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(86362001)(81166007)(356005)(26005)(82310400005)(36860700001)(82740400003)(2616005)(336012)(16526019)(186003)(83380400001)(1076003)(426003)(6916009)(40460700003)(47076005)(40480700001)(2906002)(54906003)(8936002)(5660300002)(7696005)(6666004)(478600001)(41300700001)(316002)(70586007)(4326008)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:53:23.8446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6b391d-a0b2-47a1-d93b-08dacc4dde39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch to add smu 13 support for smu 13.0.11.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c  | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 19dbd75a6176..ac0f0e09a60c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1694,6 +1694,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 11):
 		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 53abd7709242..6a9bdfda4e6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -250,6 +250,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 4):
+	case IP_VERSION(13, 0, 11):
 		mp1_fw_flags = RREG32_PCIE(MP1_Public |
 					   (smnMP1_V13_0_4_FIRMWARE_FLAGS & 0xffffffff));
 		break;
@@ -301,6 +302,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
 		break;
 	case IP_VERSION(13, 0, 4):
+	case IP_VERSION(13, 0, 11):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_4;
 		break;
 	case IP_VERSION(13, 0, 5):
-- 
2.37.3

