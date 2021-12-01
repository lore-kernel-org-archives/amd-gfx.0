Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 21:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D037B6E437;
	Wed,  1 Dec 2021 21:36:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311A96E2F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 21:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmkDvwTL11PVPsuShNR2P+9YQcrLizi3HoZU2GAxLXaQnz6C2fzpTn5mr8+lkKhSY80sfDlhZOqZ/t2nKDhESy/YsHRfx0SG8n3Ud7GlZDFREHxDLMVNvp0EuuhqiYM7Hk30kA7sorP9Fqvfo7FKL68om8ggoJEOF9l+LW6UifbzNHybfOHsxjGPqk+46Hdc8Kip7cJKY0H4B2FQA7mRpltKoeh2C2tQR1ucNu30v8ELPu6JXRl4bHWjy6140ae1jtSqAnt7HXqXpWWZOvdFfxSJApMna7Y0p4/M+4ekHpNq8DE1Bk+BGtPlNmxoBBDDZpvPIjQw7f0qxD15IqR1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SmMSInLsaVFqoqwHw9E2rhKLrdRn2dEW2VJMi6Dp/A=;
 b=duJGYW3ZNiUlmFQDKazDzi4m1KYB0zk4hwJIeQs4G/KUmkuN6vF2h4QtG/uJKb5PbXimcQwTHXZf/FbOlZeB5oxdnLbgHuTBpsbmQiQEEidsIqCHPAuUaymfL4TkOi1vN9MWxPf4T2NXHi/zjoqE4qrEf53HokJZnh6ohkVH6xXbMIUuRBp07/wq2ZBhFZUosC0kJiLgv2pNzkRZZl2eiKq0oj9+lRMhe9bTdGD0HYaanKVurfO1e+JVgQAhr6PVenjLnlcFnOjhUsX4u+LcugWzuDmiK3jiSUSdXtBeAVB+sYPsU6t3lb9fDA39v6ZA0AI1m9T5qHvD4E+GDPKX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SmMSInLsaVFqoqwHw9E2rhKLrdRn2dEW2VJMi6Dp/A=;
 b=NGWgsL3iFDrfeTEhJNpRTCk/Rfrlz8inf8wQ6bzJ/TPabS56JmMAV4cMc8nr2eXYWwdX6EyvUf7W+zS7i8k/dQtYAuVVtjR1r2GtBtc3c9XXobDN2uSIRWx5jvwgsHSJTEYKv9aKQxYtFKwr3UKnECb+s5PzwvzQ6xyeLqL5SxY=
Received: from BN6PR16CA0021.namprd16.prod.outlook.com (2603:10b6:404:f5::31)
 by MWHPR12MB1294.namprd12.prod.outlook.com (2603:10b6:300:10::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 21:36:08 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::25) by BN6PR16CA0021.outlook.office365.com
 (2603:10b6:404:f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Wed, 1 Dec 2021 21:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 21:36:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 15:36:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: handle SRIOV VCN revision parsing
Date: Wed, 1 Dec 2021 16:35:46 -0500
Message-ID: <20211201213546.1090031-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5d23300-af9c-4c36-2868-08d9b512961a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1294:
X-Microsoft-Antispam-PRVS: <MWHPR12MB12947C5541FCC3A121D96560F7689@MWHPR12MB1294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NuRdSPY+HSnskT26hqDqcn05yTQW8PGld3O6giHjheP+PCpjAIqOQ/r9+p00/fc4HqpB+nS4nmwMbRxJ+y7EMnfdhQhCg93gz7of2VBBYvg7e0vm6DbPG5GE6hxnduI7RQnJCWQOG4BwPOTI5sxDJ29EgAm9kuwv9uODPWcTWD493rHWo+BhJCWptdxLYqL9UkFABMBFhiWLuUGjDlGA/W6Kq+wctPBYOF22KXvFHM2PbP4I2Gb3gOROBlp8KfCa+hBaEA4HycDhEcUK66/0BJQ/LwtHmJq8w7wqljFByauN3c5Cyhz+nz/QUOEManWDReddjYNWVBKSDSvZdzlLROkXpeDtqvCPna4cul1uAsQx0zzweBJ4WS4ApEZrZP9LmGXDcQ7dZRosCsFmDwBN7vdNt7stLP8N3yZySZJkZJYbZEoCVf9cer9WoubH0XxNGpJFSLE+KJFillsoIIq7vplFTlD+TnR3R93vnPo4pKROoPdp2ZZw2GGBv7M7/tRPgJgp4lr1Q+Bq5paBVCTafvPsUWrL9ZRIZ3lBZkd/9eovndbKY9v16HZnoAvQfRsG93lTdeP1mcg4Bx9Nq56G55rfGyAq1fwvi100ZGrj7hefyN6CaSCs/b6PotuWQocoqhrpQBgBntCDF5bf/4nEp1E/lqd9y9kBLshClv1UXBQ4dRuvgZbFqYX4JmsOs05jUsQtJPTlYquVoyYTai62C+oNP7V2F0aiBcG3TuNh9Tqft5PWCQpX1227+R1CfCLsxQMjN+fUUZNC7IjbAOtoG+KWpYCoKMNiMwxPxEY6qY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(26005)(36756003)(82310400004)(70586007)(356005)(186003)(426003)(6916009)(1076003)(8676002)(336012)(6666004)(70206006)(5660300002)(86362001)(508600001)(83380400001)(7696005)(2616005)(36860700001)(4326008)(81166007)(16526019)(316002)(8936002)(47076005)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 21:36:08.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d23300-af9c-4c36-2868-08d9b512961a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1294
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SR-IOV, the IP discovery revision number encodes
additional information.  Handle that case here.

v2: drop additional IP versions

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |  2 --
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ea00090b3fb3..552031950518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -379,8 +379,21 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				  ip->major, ip->minor,
 				  ip->revision);
 
-			if (le16_to_cpu(ip->hw_id) == VCN_HWID)
+			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
+				if (amdgpu_sriov_vf(adev)) {
+					/* SR-IOV modifies each VCN’s revision (uint8)
+					 * Bit [5:0]: original revision value
+					 * Bit [7:6]: en/decode capability:
+					 *     0b00 : VCN function normally
+					 *     0b10 : encode is disabled
+					 *     0b01 : decode is disabled
+					 */
+					adev->vcn.sriov_config[adev->vcn.num_vcn_inst] =
+						(ip->revision & 0xc0) >> 6;
+					ip->revision &= ~0xc0;
+				}
 				adev->vcn.num_vcn_inst++;
+			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
@@ -917,10 +930,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			break;
 		case IP_VERSION(3, 0, 0):
 		case IP_VERSION(3, 0, 16):
-		case IP_VERSION(3, 0, 64):
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 0, 2):
-		case IP_VERSION(3, 0, 192):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			if (!amdgpu_sriov_vf(adev))
 				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 585961c2f5f2..2658414c503d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -134,8 +134,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			adev->vcn.indirect_sram = true;
 		break;
 	case IP_VERSION(3, 0, 0):
-	case IP_VERSION(3, 0, 64):
-	case IP_VERSION(3, 0, 192):
 		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
 			fw_name = FIRMWARE_SIENNA_CICHLID;
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bfa27ea94804..938a5ead3f20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -235,6 +235,7 @@ struct amdgpu_vcn {
 
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
+	uint8_t			 sriov_config[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
 	struct mutex		 vcn_pg_lock;
 	struct mutex		vcn1_jpeg1_workaround;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2ec1ffb36b1f..7088528079c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -182,8 +182,6 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 {
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(3, 0, 0):
-	case IP_VERSION(3, 0, 64):
-	case IP_VERSION(3, 0, 192):
 		if (amdgpu_sriov_vf(adev)) {
 			if (encode)
 				*codecs = &sriov_sc_video_codecs_encode;
-- 
2.31.1

