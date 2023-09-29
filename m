Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E2DCE7B1F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 09:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D37D10E0F5;
	Fri, 29 Sep 2023 09:38:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3053510E0F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 09:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxHrcW34QZJV4jdJykKiGw5DAHLQJXIUwjQgpmScniI0KSagq1lfgbIl3YAXV1oVsyxwaAe7hYo1Il9sPR7LOwFmLHspUJuyAJ+Sxw5miXvr9ZFwL8EYAV7eaIjYngejSADbkXxTwsJJwvLEnV5vYyhuqhib5iWVxrC8bfvPmtRj/plQhlo+0lFKfehnVk58u+UMWCHhMNh6SxV+2E6C8hpQsHKUupyw3z3jpNvB0zUfcwijgseUEsIPxwvyGyNs9Gi6pnmddu6C7WIZWnkPb+75SClE4MUrhB20G8ABkVAu4Lp8aSpi8CWjZC9y0R4SZYJFDy7nORjzSXD2U/38uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ncnVPaE7opGEbMPO02zYHp8Mm6Rs7lKezWIg7ZHndM=;
 b=B+yA6Frb77om1KRDCN9HCTax9L+q/SG20AxqUUWcXUJinVUVeLqSobaYxFTyMUkA54gJaA3ZPugAtYwQXW8OJEB20DRZLaSKmhkgAfgdsGw/kYWm10M7DziHJd2+KptDannpYadNR8pKNELilreSY6OpnHgwPxki3fN83Kj63aXA6Xnfhh81jFCKrpahlvw/ws3VLki1+Tp74PhIZ2QfOE+o8r/Q/on9tMBKKyYzcO6+xylj3CGnKgys17lRBIrMDZshbqBS1MCkH+c9s1kzrE30MfheFoj4PT8iXrpGzCekOC6bNtTFZxN0qAq5KD/a/49SxDQP9DiMXmoGUQoRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ncnVPaE7opGEbMPO02zYHp8Mm6Rs7lKezWIg7ZHndM=;
 b=17PFbHqHewOIjr9tN159IcF07KlmipJtzrPUm5Cce8DgeT03SsFynDS/HVK4VahZu3b8+HeqNgxRSfkQnvbuysAT5epGCNydQfhtJ/5Sr++kWdum6raLOwuXPtg0PoCQMwVpjv/ZNYL4+QJTmRX8zDKkrwEguBvkHmqkXC7mse4=
Received: from BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::15)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Fri, 29 Sep
 2023 09:38:11 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::7d) by BL1P223CA0010.outlook.office365.com
 (2603:10b6:208:2c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 09:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 09:38:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 04:38:09 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
Date: Fri, 29 Sep 2023 15:07:43 +0530
Message-ID: <20230929093747.1456991-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d60c48-b964-495e-2090-08dbc0cfcb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKC9VZ/FCdnAZSxvQBCVefvb9WBgZPTpiiadenOPDmWVb5WqVRYUZCJJWeObPaAPRJDL7HPeKzLE6a3OKR67gnGzmotu7zMZauDhUhuhkkrEsT46m98PIW/Aw0xvF9kTK9bZpvKhSKIokUEBqPOd355B8ty4CCptLhFkuyTzImtmRqOfvOjS7k+dBYx1VgPaJLo5/AjEM6Ou/S8FCuyVWEGfE3mSCaleRSF6HKJbKe9U+tEr6xV4wk4oV+A66NC073Jp1kH7EXd+zXOECpA20zUM9YQHqnu4kl6s5jrRr61l5ADXttiYlZhGExfGZkXRPz/eHc0Kx8pMhoqils/OtR8OsP8zYCzT2LleZ6qVg2Xmm8Lxql6mKoT04YLRsUE/wqJDYsg7+enWgYlyp4Qt3HpdLOxEU6o1HzYkKfmHBNPtXDnxCfzyzMrkJnTU7AS0Jmn5GEwKtkP5zxPKl2yQLWztrFPDc8KyulDXtkFCUasLpxX2bK6JLxjRT16rOB6oueh98NWLZNmK91eFVdE07xrHw+SF0di1GUnugKj6DNEbrhyditdmo7g9wqm2VpHrwxmqijI+bufBo7yFENm9j4VRiENTvOKPNUm3l2GPnc6gR8P5fIfR328Vkm5SrDruYkjRjwjUOOpzVa7tzzDpv1L3gzKJ3h419rpNxXGVGc3IRr0hefK/XRs2VBYOCLucly7lgtLZPaAeZqm/Izb1HmZrseFdbIpR/5RaDHdYluR+gh+Umx8CXgosLj61+b3gtDi301N8kcBCgwJ1NxItCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(7696005)(2616005)(6666004)(478600001)(83380400001)(47076005)(336012)(16526019)(1076003)(26005)(426003)(2906002)(44832011)(5660300002)(70206006)(70586007)(6916009)(54906003)(8676002)(316002)(4326008)(8936002)(41300700001)(40460700003)(36860700001)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:38:10.7916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d60c48-b964-495e-2090-08dbc0cfcb86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move definition of package type to amdgpu header and add new package
types for CEM and OAM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 73e825d20259..ac048a77e97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -302,6 +302,13 @@ struct amdgpu_hive_info;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
 
+enum amdgpu_pkg_type {
+	AMDGPU_PKG_TYPE_APU = 2,
+	AMDGPU_PKG_TYPE_CEM = 3,
+	AMDGPU_PKG_TYPE_OAM = 4,
+	AMDGPU_PKG_TYPE_UNKNOWN,
+};
+
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE1_EOP,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 42ac6d1bf9ca..7088c5015675 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {
 
 #define NUM_XCC(x) hweight16(x)
 
-enum amdgpu_pkg_type {
-	AMDGPU_PKG_TYPE_APU = 2,
-	AMDGPU_PKG_TYPE_UNKNOWN,
-};
-
 enum amdgpu_gfx_ras_mem_id_type {
 	AMDGPU_GFX_CP_MEM = 0,
 	AMDGPU_GFX_GCEA_MEM,
-- 
2.25.1

