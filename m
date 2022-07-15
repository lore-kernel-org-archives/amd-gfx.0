Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D577C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D1610F5B5;
	Sat, 16 Jul 2022 14:35:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28ACC10E0D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 16:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzV61BuPCaqMni+X/79cjEWKwaPCuEt/kBLEMICd5Zx0KuQiNWvIq8BOs6J65xbdV8g4bIjJ2DOFOCqzAa2N9tRZ/9s4+pWJDdAPCp7hXa/kcqPYijoRRm1jqVP+c75J+5jtqAcd6D/gE/KNvkKHUV5KWL/PrUPnpekx5CdRkgzYDL/vBY6D83+GC9VOdJLdlHcPEuQtxCxKZ4JLDROjLkVR+Ltn2WuZgUp5rdvBghNVw2OKZnywW8uayETXZUSLGLGVGhO9xaAUcRBbNSdukx+FRnk1QviRD0SwCTCQr65p5ESb0VjpuuYNymJA1TEADVQPn1UnAo0E4hKd9akvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAb5/7lUe5nLwlKNze14pLfsx/Tou3G5hNbvXF8xQXc=;
 b=Wm3mk5pHqrPnJSlsk/u7nw4T90qoB0yniK3jMcc5nl1LqVwiFrFOsCPejAK+B53nljL1fjgCKO4cKO13n3W03YrvLi9yUJrvazqShuBk3lSLom/gBFxm425dgAP0ws+3NKhPJqLoMLQzPL7VpL7idB7XlD4N+k5qeBSpE1ifQG5kaIcjRdY2jAY6CzDkpn0Bt9DZNPOcLzZtpUTV1+3zNJYleT9hJO5FfvLI3oAjkOLgOhjLLsSyVN/vc6IQVzfYl/2EoBoMmBklkirFkcVjLyfRPu+JAfZtjRYYk85ubcHBlmJVS6kKJXeBsDQN3n1FFd41BwKIz9redYxraZXzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAb5/7lUe5nLwlKNze14pLfsx/Tou3G5hNbvXF8xQXc=;
 b=kCE40U5kTeCuq08K+u4I5gHLuZ1HfvFwOrXG3mNxHVUapZnzy+07MNUS4HL1VhxYDpNgJLr1PCcFdtnJM4D0FdHr0PMKI2aI9K+ypRXw6QEKog0ypLPdCLzJpGCzJAfJrb5EX6GPvLMdp4YBJifBHm+l9wR0znPr5vL9zPcyUCM=
Received: from BN9PR03CA0933.namprd03.prod.outlook.com (2603:10b6:408:108::8)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Fri, 15 Jul
 2022 16:09:16 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::fd) by BN9PR03CA0933.outlook.office365.com
 (2603:10b6:408:108::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Fri, 15 Jul 2022 16:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 16:09:14 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 11:09:14 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: add comments to HW_IP_VCN_ENC
Date: Fri, 15 Jul 2022 12:09:01 -0400
Message-ID: <20220715160901.137291-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ce2dc8-fe7b-4a66-e8f8-08da667c5d0c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5079:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bE5QbJqZeyN+ZOwesIfvfYDmPFjqKzqTbyg/cMkdeC+LLgoyQxfybTVFWE1MaBWlmtFtnbntm9kcQ2QCgbKGwextlcv9De/xZmCttotyl9xRoZeeGy64S8YGxp+w5WGBgmXcezKme328Nb7hw5gXkrGQteWTAVxvZIyk+fxJmkYMmJF4rZ1nMH8ZzgqQonjcjE7L5gUmXGVDnVAB9LPA6f2f+r90S4nGyyF19ipHyuwdnyoz699dwx9YM5IXqaT1dp8NfqwWtIwrgkvEvb2IiuSCFyFgvr4GP5qQ0XJ/soAsi1aAqpRy7XkN33Q+vNmfDU7qLapU0AuOzjERPnk9UMDHIOE2XLXck4r2nqYmBwtoXW0YvLIq3CXxjyv0zhYQfGRWYepQMqhSo7NLehvAsf7acddIygwDY0bdqe30zXV30ha0YCjJIvpYZ+lRQrhIy0QCFkTaPeZnYlxkvUmlvAJvYDSgwhuAr5bOyaJK1n30DJ2/3ORPu1hfoV3xqaBwoK4SbCahDaMjSvsL0eRW8GTm2tL4SJUkRtWiZ7xtje64DWmFGrCpsnUMBEehbEAMMaRmdA6lY8kyU4Vt/pDg/HiuBR483SciKUwVRq2reDO/t+VVjf/q0SsPQ43JkwiYsRrRR31k/irEGteD9WSeCbRpYqeol0X1Q39Ex/mbJOKXHXXZ0+ID6T2fHEBzYJrugAdjAUFK74VOlEEgrhmFLi5zXkwnpqFICGK+9KQmx3GrD3QKk690lHotoj96keho3iwbDegva+49dC7EdItao/3bQg2wdO/GpvXDKeAEA9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(40470700004)(46966006)(2616005)(47076005)(4744005)(8676002)(81166007)(966005)(336012)(1076003)(426003)(83380400001)(44832011)(8936002)(356005)(82740400003)(40480700001)(2906002)(5660300002)(16526019)(4326008)(186003)(6666004)(41300700001)(7696005)(40460700003)(86362001)(70586007)(110136005)(26005)(70206006)(478600001)(36756003)(54906003)(82310400005)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 16:09:14.8670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ce2dc8-fe7b-4a66-e8f8-08da667c5d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From VCN4, HW_IP_VCN_ENC will be used as unified queue,
and support both encoding and decoding jobs, HW_IP_VCN_DEC
is retired from VCN4.

link: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 18d3246d636e..29e4a1ece2ce 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -559,7 +559,14 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_VCE          4
 #define AMDGPU_HW_IP_UVD_ENC      5
 #define AMDGPU_HW_IP_VCN_DEC      6
+
+/**
+ * From VCN4, AMDGPU_HW_IP_VCN_ENC will be used as unified queue
+ * and support both encoding and decoding jobs, AMDGPU_HW_IP_VCN_DEC
+ * is retired from VCN4.
+ */
 #define AMDGPU_HW_IP_VCN_ENC      7
+
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_NUM          9
 
-- 
2.25.1

