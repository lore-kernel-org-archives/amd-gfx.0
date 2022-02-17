Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D54C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 14:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805E710E158;
	Thu, 17 Feb 2022 14:51:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60A210E158
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 14:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8UQ1JQtZRrd98/d5CpAnA3CEoCc30YVVP4ECzGRXD86JOUS/Gxk1VSrH89eSEZbCEX3oLqAIjj8zQhZIP/b92JnzI8VettL8rkOGuSJv5U1G3b9QefQDt/Vyxdz20dj3CGDXd6mFw/ktdV+PRYuhHy9hSi8JF9m1u19IwSuzu3rA4/UoUsWCPl2et8Ed3uKQ765KjHrT+qTg8mJnkNzx4s4MN8lu+wutqEtGwuDX2Rtw5ZIZTIbBvtd8FlEp63HjcWv3Q6rcaligPY6bg7pljt7S7abIjUXQ4BmNvmV/TF8oHTN12pOlPfQ7jwlwPJimWt/q1/gIdSD/eR8wOE6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ0sv38AT2BBdtVH+/khXc6/Jw0B/BBfIK5RNZ1MDKc=;
 b=FzZMgpcXMMh0Q/CGAjWadNoBlXvtPAUjQ3WsskP0W/7uZOoU/+w+rcRK9JuPpFIR2LozVygYTckwqDXhytWXO9zeLwBPag0Q7KHtY6o1FJNP7lD79obrMhDq/qiKyVveCeipvpi1t4OteD4BopNMyZxEvQ/cUwfibW6hIhusmGH6yqutXKE9Jy5O3uu816NhAg3gvWFdqLkNcqEW3mreirRU9yk06bjn/aotoWACsaxSFvm4pjQXGFleKbuiZjr5/qmXmZseSddtdi5tUfvvinvDAAe4WCv4CYXdfWiUe6qlxjVwDtw/h/My2SiGJKQ9oGmz274RVq7Hni4Zy7vzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ0sv38AT2BBdtVH+/khXc6/Jw0B/BBfIK5RNZ1MDKc=;
 b=dUT/qxiZWN+zXKAGcXFPQoN2ZrVSxDhHTBLWzLnmPoGliliae1J2dzNs/sy23ZSoyWDEmHD0p/XUyGc70UZdd1EwZxwjeCV5kZAOiJwQ9Ku05jE6Unr5kWwVlKYnQKmWZ8ec1MbjsE+5AQK4bBZValuELRrPdfNnQCmKm9gSHZk=
Received: from DM3PR14CA0129.namprd14.prod.outlook.com (2603:10b6:0:53::13) by
 MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 14:51:32 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::8) by DM3PR14CA0129.outlook.office365.com
 (2603:10b6:0:53::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Thu, 17 Feb 2022 14:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 14:51:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 08:51:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: add vcn support for vcn 3.1.2
Date: Thu, 17 Feb 2022 09:51:18 -0500
Message-ID: <20220217145118.11974-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd6b550-85c8-4682-7c3a-08d9f224fcff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175A236EDE834C72C13B1F7F7369@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1WzbrEid7DLZEw5SheC3gl7+blmAQZBy3o7X9vW7yhsfX7u2bey6aZxixM/1M6b1IC61w+suOz8x82lUFIiY8LDgOA92ic/OxxlKjvi2g/HPqqc3g6kjq2ocKyTJiGra+slCUUcUcypeZyr5uADEU3svfxzY+VlZ6aqmtwL0KOWEeY1RdwSQwaH0RNGteu6/Gy+pgrApGj/0s4Stx5BVUyKpbPd/9fVExtiemPAHF6geQrSocfM7jU3dM17A11cWqd4xJ64f7u9K/QsY/fvAbHwwe+UDaA4EhSGTwJgnoj67WbN5Lum4vASgX5M0LLwWCP0OKJgZ/a+U/Kfs4Zto8BqvJHpHDXydPqCHfajbmhO+iN4zzRY2f2FDzVxyERxlx15sEfq5rMewZr6YctidTHibzU7D+15+xz43CWVrcr4JERZ9Kx7ALnATWLw/n9MJYJ0nkY0EDDh7ikivleKMV5eV8g3UJ9FSjEDUdawq7MrZ340pD6uU6xZgBkVzxfYeUw7VYmgJnXV3eX4Qqg1gprKn/SLUoC5uht3JVUEWuD3UcTrWijpL66jXhLSiNKP+hRVlvu2JFqJcXBuR1iTm4BUQtCZQ10/VojNF6L8dKc8uH4oxML/nM6kGtMJum7FJKnDzz+5AxvOa7uJogEVyEQrRpOJ75L+aC5HEL8Xmrpvckehfjp1jSHA2ttN53Vmcz0PSv3BbfNnQPP4hGnFTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(2616005)(40460700003)(7696005)(83380400001)(6666004)(508600001)(47076005)(26005)(186003)(16526019)(426003)(1076003)(336012)(36860700001)(54906003)(82310400004)(70206006)(316002)(70586007)(6916009)(4326008)(8676002)(81166007)(86362001)(356005)(8936002)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:51:32.5888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd6b550-85c8-4682-7c3a-08d9f224fcff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, Huang Rui <ray.huang@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Load VCN FW, set caps.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 955d8d674b49..da4541e6b23c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1533,6 +1533,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 0):
 		case IP_VERSION(3, 0, 16):
 		case IP_VERSION(3, 1, 1):
+		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 0, 2):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			if (!amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 38036cbf6203..e9abd23a21d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -51,6 +51,7 @@
 #define FIRMWARE_ALDEBARAN	"amdgpu/aldebaran_vcn.bin"
 #define FIRMWARE_BEIGE_GOBY	"amdgpu/beige_goby_vcn.bin"
 #define FIRMWARE_YELLOW_CARP	"amdgpu/yellow_carp_vcn.bin"
+#define FIRMWARE_VCN_3_1_2	"amdgpu/vcn_3_1_2_vcn.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -68,6 +69,7 @@ MODULE_FIRMWARE(FIRMWARE_VANGOGH);
 MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH);
 MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY);
 MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP);
+MODULE_FIRMWARE(FIRMWARE_VCN_3_1_2);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
@@ -163,6 +165,12 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case IP_VERSION(3, 1, 2):
+		fw_name = FIRMWARE_VCN_3_1_2;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index feb8a0a123b5..1a25db6958a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -202,6 +202,7 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 			*codecs = &sc_video_codecs_decode;
 		return 0;
 	case IP_VERSION(3, 1, 1):
+	case IP_VERSION(3, 1, 2):
 		if (encode)
 			*codecs = &nv_video_codecs_encode;
 		else
-- 
2.35.1

