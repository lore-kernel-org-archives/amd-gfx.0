Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496B606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EYPSscMp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C37910F966;
	Wed, 21 Oct 2026 06:27:59 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB71310F966
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX4MktvDr4BPT/YraAnUhg9UUPmyfSRnJaVtkS/YG0DVJ5DNovK1cMgFcepKUeXscp0b0jjjKMyLGYQwdU4+9lqfSFgs9tuidBFQXsgjbJ0ihfDruLFLxYi+BJfvXdmhJiNhV29+gOwSQBWcNvQgoeleInLYOfGBM4Uz9Qc1FNQBtNqdBFzjMgeU+1F+PfqHe3au8AAAPSsSo8Rt5um8DtzOBwG3JjRpzN1P3Q5YEw1o7Bola6zntiuWOBCj0vDu5xvSFrs8IKPrytzTlv2q9AfmCceEsYwsrchjHu68rQLgLxsLWsh53CIsNXI0giCU0D67Kvx4k276UEOBcR/RLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eafpTqkMoEVTaVKZal81vbeWN7DUE4+yttyGk1beelw=;
 b=KzX7BJagYuDJo6dqSG4LuR18x1W1heew+qsLX/fGdUVgrhkjNDOH5qNDcyEguwY6F7afa7BL9y6WbXPx4lqxkMgdjAZMTcKrcNMt9tLCSHrrj1+2UgGAToV9JCgJlAFd4DaI3103bxB23y2zyQ2p/kC37ez3iwZqwsH9nPCiIHIkKaPGCks58gv0rsYW2KCQEK1u7/Dk6Nb7IaYkgq5ez8SIqD5WOM06HInNVin/aQY2HERwOHjZStooLPNWmuA4peB7LlVNWQcYzgESpMPZsY1Z9yNNt5yehLcK2wMAMD1DvY7CtDhJYHJB7Gdsj7IkQiLHatLm2GQ2gKK9dawGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eafpTqkMoEVTaVKZal81vbeWN7DUE4+yttyGk1beelw=;
 b=EYPSscMpmGDd54jnneK3CPY+Zq8sHmm9O4Qf7dt4laKLBEG2nTX2bnWrp4yeuHCTiXAsARW8kVaKAfb4GJmulr+XftgysEJMfuPc12bDEANJOEolapBwc3zpPiDrHhc17OxiYi9fQy6NJjcnUBTV9hFPuoKbGu5ISENDauJ3LDc=
Received: from SJ0PR05CA0138.namprd05.prod.outlook.com (2603:10b6:a03:33d::23)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:27:50 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5) by SJ0PR05CA0138.outlook.office365.com
 (2603:10b6:a03:33d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Wed,
 21 Oct 2026 06:27:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:48 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:45 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 39/49] drm/amd/display: Add debug flag to support for
 different DMCUB FW loading
Date: Wed, 21 Oct 2026 14:22:45 +0800
Message-ID: <20261021062519.674697-40-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 59faa127-43e2-4e0e-3a83-08df2f3c6de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: DGsz5787STGt7WNiz5r4qiMIvVhMzHQG/fa9DnQsT0DBjnKVmA2lU6WzpK+Cdjm3d+GrnQ+mTmwY9YKbG4qdLYkD55qsd+WaWvwhnwOecsnG5XrKh1JguqZpvVvSR3ADqGTw0o3vXKT3yGm1LH51Z8DOSAZpypaQ9IgzjhG5zTZZXujECub/TabV+yoLf3ymvWA7fBLQZ9hYvtNfrEiCESzy+sLYzGwXm0sGmGb3Ls8ttIUpzcgKtZMMWPnttG3JhyGwKwDL7JUXufw91cpmwZMVubul1O8jWXleCO+6EZI+rYXmy22CGKoAX334/I7E1HVjlV7ec5C6YMOEaqtZIITu6QL86WHcEqmZJtV11gJlYnC6ZlwhKlOO2G+ZmYAgkI14Z5HPLbEHAgFbQKZj+gDpVnJRbBCZYzz3S7DvUkYl07ZMt/X8SdZMgu3CTuJTeyMHH8MFAXiv/MrbDcn2unA/M6KXaWhzy9EJLBYIZ/mCSRzTSgDy5y4NYu65AeeCTqrqf2dSDioRhY2IsieXoH8pyMLPHjSZk4Z7kw44l/InPDY/VxYdptn/yLAV0Y+QAgnPhiz8EXFHHjs4jIhVi9322wH44llZV7QJzPSY4jXmNbzz7a9snciMqudkuLycckALoDkJn1rX3Rmeg+xYV+OZMGTzDieYulFjkr3ofmVSIYIEQuhtbGT0gB9ztFwOT2Abk0IDC08mXFStvhdCgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QuQh3KFsvB8cSvtKe1PHCoMp1JqiTZkDgfvpOFZmStvjT1K7CSyFXCarNdxc3mQgnNrmqdvV2Nz7cwqa0qJ+6//mZYLLrVLi8+QOZtOTP+0YJiCWpU4iIgfSEULoRjRqaz5QSECi1FKdzQ9dP9r12h/Ea6Vog1pm4wqvN0oINrMC6EVZit2DSS7kGbMnwTMEsZlY3NFybKuvC3cBiPisRH/t9IEmNv4mYkYtW2Q8qTlzIggaFXU/1jO9p6ku+R7vHBkOl79ar8w6mRFVcEjTLa5eI44vWkviQY78N3qynXDT5v0t9QgVpKnPAEbpcsL0xzn5+oyyh75qTJIAQmu4PPHRuXbzD8YFZmULvjq3/638vvCEW1CiTo5KMTIqsrtfDenfLbXM4Oc+9CremLFAP7qTDquUuTe3+uM0E1AUbUFAYn/iYJz16ue5gQouGkTr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:49.7444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59faa127-43e2-4e0e-3a83-08df2f3c6de9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
Add debug flag to support for different DMCUB FW loading.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7f779e289213..51472d6849cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1319,6 +1319,7 @@ struct dc_debug_options {
 	unsigned int urgent_watermark_override;
 	bool enable_block_sequence_programming;
 	uint32_t custom_psp_footer_size;
+	uint32_t dmcub_fw_load_type;
 	bool disable_deferred_minimal_transitions;
 	unsigned int num_fast_flips_to_steady_state_override;
 	bool enable_dmu_recovery;
-- 
2.43.0

