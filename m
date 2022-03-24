Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984C7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 03:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4F210E047;
	Thu, 24 Mar 2022 03:00:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B2810E047
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 03:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXbpGQSN+u7PBa666CA6IN9hpXFf0zbVcCwJY+MSHBDg9dmFGpcJyaRwTF2FOaxpnBQA9SeujCTLqKZroQYCTrqQPoEMPNad4DEBgj2CqYDgVC63XaLuM3bF9p58hKWtBY9aFoEacePPbRJZzCpBJrc7PqomdGsAQRJfiRtKGe3WwLZDAGAEXttl7PrlJzlluKUWrVbMm5nztnGeDtNGCcQvO6H3AmzThxo1M/SGIbbaOcTmj937dwHd7fl9wRJLoahMMw/iV93xmxzucXY2EQxCEjcxxo75rNt0B6jLvaSQWEkrwvMN9ccPAjCcOGF67yYdksl0TVB82ZOZB8tlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onQEdj8l+wq/FQWPv3fwCWrGVZx4WKU98LZuqKnHL/Y=;
 b=cX2Vt0lC1BUJW3eTmyccTCChg25KkgjG8gO2esUXlrVZQiJ8/J+zUIRbUxFso5aHPaK9vKRfzdgLGXrNTeNacv3WZInXHS6+AXVzeWF7b5g1di8Hl7Xb6BgUTXxPA8TqpP+nbp6DPNcWay4GriRJG2KhHx/Cm2Y5P8RfZJfR2O/dVvXory1BC3yvphfbCTK5bdAnSozQ0lUQKZYuyr2N3/SjTPyy2Dvl76NRzXpuGkwBf7yym2QbWXn0y0jLElObhQpQuArAg86NDdSrWcfmFXQjURusAfViizKUFa/MdsNaapTzprYsYmRBXIhb+rMWkxtH7DzvOSkQoc/4A/eo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onQEdj8l+wq/FQWPv3fwCWrGVZx4WKU98LZuqKnHL/Y=;
 b=NWNpkb/DYfS2E6pr2rb2Lp1NFtwB8GB/1bsh01f8l9LgywhJJo06jp+ha2y4xTHybtAfvCIxSq+C0UWrleSaKcfghMNVFUfZ53ShZeNCii5AbGHHsxz8hzPgSNieXGGNJE5BZmZawlHe+fHmLom4HYz8NiKVXfcaBSY1dGF0z4c=
Received: from MWHPR14CA0066.namprd14.prod.outlook.com (2603:10b6:300:81::28)
 by MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 03:00:37 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::f5) by MWHPR14CA0066.outlook.office365.com
 (2603:10b6:300:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Thu, 24 Mar 2022 03:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 03:00:36 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 22:00:32 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn3: send smu interface type
Date: Thu, 24 Mar 2022 10:59:14 +0800
Message-ID: <20220324025914.718674-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c31477c7-7308-4f5b-0882-08da0d427876
X-MS-TrafficTypeDiagnostic: MW3PR12MB4569:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4569269CF44AF07CA6CC774AC1199@MW3PR12MB4569.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztKxL4D7KazAOY9WifQhVLVPpXGosHq4Jm97d2H06rCZCWC3pZ8eisz1CdUHc0KbE3cM6ynUKYQ9zaomepLI4Oz8NfJNBaRHb71Y3EInR7EMQD9JwzxjXOj3HxbYVmleKHJKU+FYRYrBtCMAv+q2Ng6LY7QTnL1+1wTVv0n6ZfATewMJ5tK89lbbj6oIGq7d40UAEKG4FLzMZChuX+aITlOaWi2WGyV4C6o7ylXysP+VJYQB+9XXkm96SioSLen9VbJAz0IUqtCLNlulL6nG5nXcv9FhlQbWRapb+eIB6RK7OmdMgBZbptVSXpOM4+vpDudiZVDIc0xdZLtYlTgO3UpMkdpokoz8zVgaehpWEnb7mQc72T8EYJQfY5Iwd27I2KRSOpaxlqjuIZqEUexYGjRrH7aY6gsVCXiYgjZWZIRx2vn+M1L6lSeWRv/ZW+exUScd1ZVVmcnI2YGJC8/O0QquwNfq6qeFAlGxVAoHV3iwQWq4RL5pgNKJY/DAzUIedynxONrQgzhF1a7NathWyu3qTmJGwgkWPIxjEzqjYFdUeAxxv8TjCecK9GrFuxNQOdIWdWb5umxRJGlJLc02khQsFEu2Bj1FMgyNsI3E1eKZD8XYJ2uRXfZgXzP/UIvYhe3A7sIKT0G+BeEAMn/4MTgq1T5XL5GK6XP1XwYp31KiJS4A47EFYxHgRnu7fBvhy9YUK3mVPTUHsSWq3FhqsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16526019)(1076003)(2906002)(2616005)(8676002)(4326008)(83380400001)(8936002)(70206006)(70586007)(426003)(26005)(336012)(186003)(6666004)(36756003)(508600001)(7696005)(36860700001)(47076005)(356005)(316002)(40460700003)(81166007)(86362001)(82310400004)(54906003)(5660300002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 03:00:36.4475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31477c7-7308-4f5b-0882-08da0d427876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569
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
Cc: Alexander.Deucher@amd.com, Boyuan Zhang <boyuan.zhang@amd.com>,
 Ray.Huang@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

For VCN FW to detect ASIC type

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 7 +++++++
 2 files changed, 14 insertions(+)

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
index b16c56aa2d22..c5bf7cbfa82c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -219,6 +219,13 @@ static int vcn_v3_0_sw_init(void *handle)
 					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
 					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
 		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
+		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 2)) {
+			fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
+			fw_shared->smu_interface_info.smu_interface_type = 2;
+		} else if(adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 1)) {
+			fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
+			fw_shared->smu_interface_info.smu_interface_type = 1;
+		}
 
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
-- 
2.35.1

