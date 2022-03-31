Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB07AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 01:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A6110F0EC;
	Thu, 31 Mar 2022 01:00:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2942A10F0EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 01:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD7z92yIU9OJikpXWmrnWMTLPI3TN/FgnTLZyprmKWKZFgiYWUb1iF8ZMpwQDdcjH6AmSaBA/3JPAOFh+sPRySJr9JUHS1a6mjtvGClK79c+bCcyqEr06+AlCqFCIvnx5iTOzQgWT0O9C7su7MI6A7RZgmVHQMIgzPPdQePB0XWPhwUus1Hksz9tVqGSmVOWxFn4cgQ++iuLAFQesWmIYNrY3P+LmVi3OjcuZl2mYtwfcurjZLnxZflhXULkKnfYNfma44932b+fIK8WFy3S6DcSSkWyLEy80Q5qGsovNw7W4IH/5hEYXxoiKVrNT/eWgQdvBf5DFGHQP/ijz2EMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0sAwqAK7ch/v1PpmplMVGeEPpkW7UI6eXQ8ls2+r1w=;
 b=HeA1OFIS7JfdaZx5aNpK8GF4XcmT9FgNCl2y5F6yw+Y8vz1b/BtG7iaKQAi1kcK6HEdIJBpmRxSdxtJMZC0jyYOgdIUT4co9CbVzO3ufdW5dy4s/ARtpN2//UWN6IHH+Krl+58SY0CCGEbw3OeRdZ/MRtXvisZy0xnoiJYZFh5+ZMDNR7ozmeAIBwVFwb3bLxZ7gKb/PFiXXurOVGVFuBPv2CW1er1YRBgUs6m8WUiUShJUNuX6FyMVowj9eFNnMQ4RnQdwONd3NI5gnGW1+AiI+/sZYDAVj5ejnfZEv/dG6qTednNZApbD+HM6MVAQ2RGvEd1pcN9jQjIE4E/uvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0sAwqAK7ch/v1PpmplMVGeEPpkW7UI6eXQ8ls2+r1w=;
 b=xEBiY1Q71xjE0IxmBaC/n7lhKCYjUkM2R0f7YOq1yMmjptj4CvrhkdVIp+Nv18iz2RPA6S/PIG7WjxO4zehtemSkbNRdRTRahV3AJ+6h5lXeKydSpdfJe1yhXz0AVyhmGKbGf4sqCBJZ29tyRfa5zT59fhDHBugaP+YsvmfndbY=
Received: from DM3PR12CA0129.namprd12.prod.outlook.com (2603:10b6:0:51::25) by
 DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Thu, 31 Mar 2022 01:00:10 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::42) by DM3PR12CA0129.outlook.office365.com
 (2603:10b6:0:51::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Thu, 31 Mar 2022 01:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 01:00:10 +0000
Received: from coralband.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 30 Mar
 2022 20:00:05 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3] drm/amdgpu/vcn3: send smu interface type
Date: Wed, 30 Mar 2022 20:59:49 -0400
Message-ID: <20220331005949.34007-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26840e8b-9379-4275-e54e-08da12b1ce00
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40906B3DFBE82A9D05ED245187E19@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cDUYfKwL9nxk+42oSDVvd6sAhdzKHloEDlCWxxVFtcs5Amk8ZpfDzUFPBM1UxkJu0IPXeCXcEZLRApOCr3OvKhSBcbeNEKA4ALk2K86jqZkMO8S5fG5ZXNZNr872RscP8Sf34bUlNiKJ44NNjYgXmVWBYaoImYwB4dT2HtO0/kutKcpQrBMYDprgxLBCTFKFHmKc/WXJxO02TY6Lap3R2bhdWVZd83OoWA3JiF4TBIGQRE7+YFKLMLu9wGofYcXMSYdZ5d4PxH24B6Mw2BmQX0yF9w7dO5ek+ibHcX8ibWYNYJQo7CYacvmcOli+NnxS+xHoaYJsDEZOQTVjO9Cywrgdb9KK7Ig0SadJgVjg889MgXnnNyI9VFpxtCyzKHUGKWMKbvh38+pf0QPf3bFvlGQAVs93VY4S9NTpMLMdNYWzTvgt+DUBzXEE8bh+dha0y/Jt+4CMw8e88KmKqLwvx4Kcl9Grx7HAshXdLKwMIbOaqMZ5XgUtgCGLt2rOCIlOzVVu6VEbNaZA4Vibq7iMegx5w88nINNSCgTU7ZNAk4SgsSDVSXY2L/Svm7h49FrE+omY58VFqdj8gHw0spewPCNtJ00HYmlK98P/5HFoldsHM7zZjDHp1ktiPdSJ+gFdPqn/Hd6Qudxppyfy24o1RFXEZ3w52j7jEIPkbk9qfgQZbU9KATglWAzUvZ2yRmvyaOuBSzrBFkPtP1+FDXHaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(70206006)(2876002)(47076005)(8936002)(356005)(36756003)(81166007)(508600001)(6916009)(316002)(26005)(2616005)(186003)(16526019)(54906003)(1076003)(40460700003)(70586007)(83380400001)(82310400004)(4326008)(8676002)(36860700001)(426003)(336012)(6666004)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 01:00:10.0085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26840e8b-9379-4275-e54e-08da12b1ce00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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
Cc: alexander.deucher@amd.com, pmenzel@molgen.mpg.de, leo.liu@amd.com,
 Boyuan Zhang <boyuan.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

For VCN FW to detect ASIC type, in order to use different mailbox registers.

V2: simplify codes and fix format issue.
V3: re-order if/else condition from the smallest version.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index e2fde88aaf5e..f06fb7f882e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -159,6 +159,7 @@
 #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
 #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
 #define AMDGPU_VCN_FW_LOGGING_FLAG	(1 << 10)
+#define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
@@ -279,6 +280,11 @@ struct amdgpu_fw_shared_fw_logging {
 	uint32_t size;
 };
 
+struct amdgpu_fw_shared_smu_interface_info {
+	uint8_t smu_interface_type;
+	uint8_t padding[3];
+};
+
 struct amdgpu_fw_shared {
 	uint32_t present_flag_0;
 	uint8_t pad[44];
@@ -287,6 +293,7 @@ struct amdgpu_fw_shared {
 	struct amdgpu_fw_shared_multi_queue multi_queue;
 	struct amdgpu_fw_shared_sw_ring sw_ring;
 	struct amdgpu_fw_shared_fw_logging fw_log;
+	struct amdgpu_fw_shared_smu_interface_info smu_interface_info;
 };
 
 struct amdgpu_vcn_fwlog {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0d590183328f..508b3d8464f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -219,6 +219,11 @@ static int vcn_v3_0_sw_init(void *handle)
 					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
 					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
 		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
+		fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
+		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 1))
+			fw_shared->smu_interface_info.smu_interface_type = 1;
+		else if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 2))
+			fw_shared->smu_interface_info.smu_interface_type = 2;
 
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
-- 
2.25.1

