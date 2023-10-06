Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1E8E92FE6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 05:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4815E89A5E;
	Fri,  6 Oct 2023 05:22:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B4310E0A2
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 05:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmBByUimQUIWrOMGKCkBw9NPQvpSE8ooAM7tcWEeveOlO9KNACHkkLUf2EMZOxO5aMr09y2LJmFYs+ROCVQYBWbdk3X6QU0aq2DJK7cI1ock2rgSQkE0OXm4vNmOi7JKVPxjJgyv6t06aLaOMiWt2aN+7fsIKiQhtRyb6pOKa+JAGYT+vk2JVQojb8d+TVplreQTJNGfyceV+NXReD5Un4NIemgQYLvduCrj58COo65fCeiDPDVfucVibo/JcbfdBv6TUf61iqiDehQGpmSTYugOb9SOEd5tBAyVyHhxRSjL0s5sVRr/9mpYd9ncMvMBMR91G6mzElazfByh0227Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AmyX6mvL7Y1bcbrnBmqBedHgsmEcioiBId02KGXdgQ=;
 b=g4Y9o06cmeq20HwTe4f9RfFflCwyH1hTWAdgrlu1VqEYwyx61CdayY0fCi0AIEkrmpvLYVGF64txFb1hK7MELajP8Us4AXWveeWxOxooCfRYnPbGmPGCZMT48t33ZseOrGHgfgKHXBVTnfIvV6bmZiA6VVIGlmnFpxcKlBFXDdlVOkc+jAaGa1UOlXNEyo33ewXjdVpBW/SqpmEo9l6YR6e3iSHL9qSRtLVua2YrGCNIz9fDYxaQjU4T0C9yw1HrcpN4BfBoEbzVGFcxiZC/UmnIKYyJyX94kzqmANkEEHT2mKgLFurWa5CJvGCDGSTEeOj03r+d7AGXCDEil6ScZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AmyX6mvL7Y1bcbrnBmqBedHgsmEcioiBId02KGXdgQ=;
 b=kNt8/6IeKXpO/8If05EmlrUygehbv3cKGPL11Uwq6BjF21qNLUK5Q+Z7dpzLioTT9F0BWQFOEt7lqWecg6+gIRiS6D0270d+HE50MtDzf1esdLirbQl/zda40hi5XhLAWdOzw2bYu54HuV83N9I9axjLtTLDmIwAd/5rTGYaKLU=
Received: from SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) by SN7PR12MB6887.namprd12.prod.outlook.com
 (2603:10b6:806:261::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 05:22:09 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::ec) by SN4PR0501CA0057.outlook.office365.com
 (2603:10b6:803:41::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.11 via Frontend
 Transport; Fri, 6 Oct 2023 05:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 05:22:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 00:22:05 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
Date: Fri, 6 Oct 2023 10:51:46 +0530
Message-ID: <20231006052149.1566154-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: de51ca87-b36c-474e-96da-08dbc62c3024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXvyDxhrQzy0NCuI6lz4G/iQAikUWxHAVw1sqARiBu6GLrgOHiF2hYyl1+SHV+sg+rC6zyuFCaVBudwOZaoZ4I4yLnwECF24po11me2OndroPbANZ5Db3iv37XgNs3dQDHnyyvGrX6qcmr2CPfeACLZTncQ2Zi0WwS5BH0pjeMDXZuIk/AooqvOj8aO9ItVhK1pno6Q+8XHxFs4RW4/R+/DWCgxTh5mmKfEymdDLrW2eDic4jOy6Ag0pV3rLL2onDkz2Xx3jYO3Oaeb9M8tYp+ba/cn4kNkJR2GSQoCUfFYbl5K1N/xAbD5Y2DUOWwe1UO4otJSpNe/6EMpTzdVtUbknBLHhFHrVfTZv3xzOxd6yM2c5qGNwYzWIgZ92W+3EFmJ+rPtUOkVxbGf2UEO6ocYfgPpLDYYzN/7jfJ7tswCBE2fq4UO8780/0Nz4gMgHDWN0OyU66rLScT2cShMx6EWup+Xw64Nn62Mg+UD6ZQBU1Xa9Z1/C+SPgKHOKNxUjBvcGWSyyzcAJ+e0IS0TnAJuTDTOcb4hzBWio43Ibl8hhlaTmLoH7rnODQHRG5SPI0OniPWffaOYXEOy62HYI1BteREXqZZJmbs+TcPE6Ju0EsiwcFBTVUYLF1WAyAy2g7jozcOsiHYpJPKpO4+h3Vx3va8+Em+fCBpWLrk3tJskiw70FOAs+vwoznmYGg5wdd3t7D0aNOX9K2lmh71Raiqu3YWuEYpnCRs5RjuEQ5pr6gDDbsRoVA9LkgjBnt5xC3659OG6a6xKSHDfXAV85cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(44832011)(8936002)(8676002)(5660300002)(2906002)(4744005)(4326008)(41300700001)(40460700003)(316002)(54906003)(70586007)(70206006)(6916009)(36860700001)(40480700001)(36756003)(6666004)(336012)(26005)(1076003)(7696005)(426003)(2616005)(16526019)(82740400003)(356005)(86362001)(47076005)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 05:22:09.0840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de51ca87-b36c-474e-96da-08dbc62c3024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kevinyang.wang@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Define the pmlog structures to be exposed via sysfs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index e0bb6d39f0c3..9905228fd89c 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -980,4 +980,19 @@ struct gpu_metrics_v2_4 {
 	uint16_t			average_soc_current;
 	uint16_t			average_gfx_current;
 };
+
+struct amdgpu_pmlog_header {
+	uint16_t structure_size;
+	uint16_t pad;
+	uint32_t mp1_ip_discovery_version;
+	uint32_t pmfw_version;
+	uint32_t pmlog_version;
+};
+
+struct amdgpu_pmlog {
+	struct amdgpu_pmlog_header common_header;
+
+	uint8_t data[];
+};
+
 #endif
-- 
2.25.1

