Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37749C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 200EC10E5EC;
	Mon, 28 Mar 2022 06:25:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D4310E5EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLLpj10rm0iAZm+ze/Bora39k2RTVcYRi/KUEt9hATfrMVNUvlvOd53oq0uV+xGGmjf9JoBXVu1daEQNATSA6EIExV8uO6Pz5Rev73UG05C4qJ+4Qw2QKQWPtmqOpV3pc+96Z9RWakHjPFMfG7uEirlYrG11gnRfmbbadCYoccqaG6Ty9t1YgJXhdlEP9A7NWrX9qwU7Q4l64LE8ttb8ip9fp5Ydfh+Zuj+JdXAqGQjLTJ7hEVXgWsqHq6ekR30zC277291a2EJgDopTFbEa06a0iUh2StzCrTBigBbEz15jmiTFGVy3NaoJCo3tdlj5QFF5kYOhK9HPtjrdtyZmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi8cXp7+NEmig5H/S01NG1iynuHiT33j3flcX025Z7w=;
 b=R8puKSKxbzl+Cw2C14Z+yhOsYEWcm849cpE5PebhmzkmGVmOJi8aYo0zjvq0naiFlEjAoE90DEEaNT2HQ+e+vSgFnNwZCR87tKMWjv6H5VzCj5gyaHfDadMRDoKXVyA+bdJS5V95wE41TQWbbtUS6S62etAeoPZmiYG2FsJvoSJ7fax2Jet5oPo++TFogI8U9c0PsG1beZofEZ+76zDvn9rho8bAyHLQDL6z/fq/mfJl6qcJJODpXlgrau6abd2yKEtc7gqwRyKu2GpMHT/S0b++EVwGn1CtcMOoakCxiM3xY4TUmq+j8sxW3+DHiH6v3xdpYGkZW9TBwwJexm4C4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi8cXp7+NEmig5H/S01NG1iynuHiT33j3flcX025Z7w=;
 b=MZ/Lynu1jZwndzP/hdCCF1ryrKMRaaUIZ7/ZUG/q8vHtc65kmrvByQCc+DG3tyNI67X7NmS10u9+ISxYv3D/L3IrfKzPwBej+LYkKH4HPLSxMILGzXfi0FX3ajE1H99f0VoEjb8AoBPDHtxRtKgRZNF5CI0Ox53pswSO/COAlRw=
Received: from DM5PR21CA0042.namprd21.prod.outlook.com (2603:10b6:3:ed::28) by
 DM5PR12MB1690.namprd12.prod.outlook.com (2603:10b6:4:11::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Mon, 28 Mar 2022 06:25:17 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::17) by DM5PR21CA0042.outlook.office365.com
 (2603:10b6:3:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:25:16 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 01:25:13 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/6] drm/amdgpu/vcn: Add vcn ras support
Date: Mon, 28 Mar 2022 14:24:49 +0800
Message-ID: <20220328062453.4156191-3-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ced112ad-ff18-47be-7510-08da1083b99f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1690:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB169029D5D47B3DACB93BB82C981D9@DM5PR12MB1690.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5dAQd3g9OOTBZlBPEeU6YdQn4M6T/z8IldMt9yYp2AffqR0iUtPe4iXa1L1VBKs9QR47TZfdUahmo9sAo6ROsyN0mHwiUfx5vyvm/k5wWprgcbzlwte6uwmDMKXEAJ13/Gh6ivoci8tDlG0OMWSjmhJV6XqlInsvLnq76n7Ku69V/WNIaP7qDSc+GFsm8f65rt9v0MlvgpMZxKQ5PKhyAIPhtv+V2IgzLy5eQCFmQA6/XjLoT+Yb+WyHt6mZg2yQZMlLs1SmSbRyzkKDGusUB4zMmqHr0URPvbaIhd6FWo2XgDOwP6VnvQLtRG1SvrZs1ovObK/V8modQ8VkKmqj9IEufae79BLFbCNFO/SFbwqTucVxDQhAPUwOUR1dqD07N9Tyzj7TbL0PgXD6SvTtqOFtOA69HPXv5Ua9j66shB4Ctc6T4sUuljQxTrcIs99tz30MZYEMMHGAp2aaFsaWdav8VEpX3aI0fS3dNZCBY6ivYxoiLFXdBWLgPcsFfpZvkf7szUsi9I2aa+xAN65ybaYX/gh+XsZuvret1+DLtUULcmOSmuITJ40p7sT28t3tivrDI8XgBgbjQ1Po0fhWCVUDovELAkqDsS7iO84OzzXcQgitFOGlhWpORdonbInIGq44S5jqpJonDMV1h9bf1xvQtdhwLW7/LJGMWB6MrwxVnFsX5HFkpwTh4wenLkK5ga/k+x5qL76QmSvzCPVzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(82310400004)(426003)(186003)(83380400001)(4326008)(8676002)(508600001)(6916009)(54906003)(316002)(336012)(86362001)(16526019)(1076003)(2616005)(26005)(7696005)(6666004)(81166007)(8936002)(2906002)(40460700003)(356005)(36860700001)(36756003)(5660300002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:25:16.6248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced112ad-ff18-47be-7510-08da1083b99f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1690
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
Cc: Tao.Zhou1@amd.com, lijo.lazar@amd.com,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN block ras feature support addition

V2: default ras callback removed

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index e2fde88aaf5e..ea07974ef6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -24,6 +24,8 @@
 #ifndef __AMDGPU_VCN_H__
 #define __AMDGPU_VCN_H__
 
+#include "amdgpu_ras.h"
+
 #define AMDGPU_VCN_STACK_SIZE		(128*1024)
 #define AMDGPU_VCN_CONTEXT_SIZE 	(512*1024)
 
@@ -232,6 +234,10 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_vcn_fw_shared fw_shared;
 };
 
+struct amdgpu_vcn_ras {
+	struct amdgpu_ras_block_object ras_block;
+};
+
 struct amdgpu_vcn {
 	unsigned		fw_version;
 	struct delayed_work	idle_work;
@@ -251,6 +257,9 @@ struct amdgpu_vcn {
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
+
+	struct ras_common_if    *ras_if;
+	struct amdgpu_vcn_ras   *ras;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
@@ -339,4 +348,5 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
 void amdgpu_vcn_fwlog_init(struct amdgpu_vcn_inst *vcn);
 void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
                                    uint8_t i, struct amdgpu_vcn_inst *vcn);
+
 #endif
-- 
2.25.1

