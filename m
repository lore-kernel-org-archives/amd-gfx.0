Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD374C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D2E61053
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78D2E61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED0796E52C;
	Thu, 26 Aug 2021 07:13:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B0C6E52C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 07:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWrHDtCe8Kuligaogonv4pwNt0J/56fpjQNJEIQnWWJkVjkP2qiYrz4jNJhGludVFhe0N42PS1y+BO25fW1Q88KWwkSKiPM2tdhhELx1XqwGSLV74QlJl2xg3SrSMjgvoFe0nVTRHzdIodrm+NPyhSRrX3atLe0cxor4+WONCnqPIt49snngA2kpn5CGELCro7kTNv5KL6NVvN7JmKidwCgd+oHUvgyASOBETBFQ92RT+KBOh+n3/4CmQItCwrKYa56FFbkgvN9M0fHEfnwzPirX73mZRqojTVKjUizUpDKjcJjJGhCjA0CwU2ZWc03y8Lrt0sk1/XFzdp45z7wGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNt8C5+xyaZWrtW/u8GiesdxQdPzrI+yWaoqaQICqtw=;
 b=bjP4f0QhqH5FAXunmwSm9oru7UlnJaK3FyRxZNyeKUcTC/KSNzs0Fg1uIKeMXjodJlAM2lePfO1JfszYL/qeInBX7vr0gxgvrgUfwvbToQMxusICsWTy2D1Krg7krRgLwcZ+dEner48CCXdr59bpK9vzm4faYcYDddre2gYdCFOVGar07sS/UVYYCjK5tDAGuBpPRIw5lBCVTRn0XMNwQAkbxc6p841iTkm49Wzb+UyeQNoNnGwZRmeTh6Fe2g2XZkPAKrScT5KLG5hNBbgf9Yu9ZID8ucUQS+t+Z7iCZcN4yQgAGftLzNyPwTYjEn2BX7zaDBKxVMP937libgf8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNt8C5+xyaZWrtW/u8GiesdxQdPzrI+yWaoqaQICqtw=;
 b=p6cHT8PdsheLaaK+fxgA29fPwhi8ZqTtrEdKOq+bgiql+MOMpCcR9/12yDcSXDNvjIdNMBbOF6eNiOdBGP/CuHrdlg0/X3Q3PGz4AlKUhZRcNXvmY5PVzdL43WUA6wVqgrWQjyFW4MizT71/h0BVzXyQ1UXXlVfhGl6JbNr599k=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Thu, 26 Aug
 2021 07:13:33 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::10) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Thu, 26 Aug 2021 07:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 07:13:32 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 02:13:28 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/vcn:set vcn encode ring priority level
Date: Thu, 26 Aug 2021 12:43:04 +0530
Message-ID: <20210826071307.136010-2-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826071307.136010-1-satyajit.sahu@amd.com>
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 971cbbdb-d7bd-43ab-1f2f-08d96861035e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5362:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5362D27F8AF60AAE02B7A9DCF5C79@BL1PR12MB5362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaXqowLEaoQLpeg5Crqt/daZ3dG/vJxwbhK4fzt/3f0RAilPGXaGQOOIRl8ymn33Gk+GNV122QCu23rVF+CNhfGz5ENlOAzovwvI1EyUGk/zmaQlat/4Fz7hhCn6q3loWwG6T7fM31fusE/JLdVbeg2UUEo/3RVHUIvI+eewzOpcDsrNClXJKPqU851iLu500QrN6c8oErU+SNfGfffmWOVE0VmSaDtOlqGqwgBACEdrMKPH9I0RSNsfUUKOh5ZsxSdniGVzL2i9Woqo7eYL9v19TUNO9IaopL/VaZCFLRrFTdvfMh98GVpiF1TGMAi4vNFIy8QEN0Nng2VYr1ZhSMFTfRdgPNxVS8AN0hV2NF3TN58rMLwLZH8NCZRuTxxqN8vmpax+WS4XNcjpMWUdRsokszbXl8VFeNZMdRqbcLT2fYdtvgzPfhhnGuZRXHnijdm2KLYddYYt5FVe6xZZhxPRLODmk0ar9aot9bx/vWsqP15ICBil0EcmlMt+IsTHw2D5cZgVwHRBzUZdr1YGLani+tIbihM6BR3nUc3zVysCn2bC3+8z/CYamMQQaSraaoNdIQ+MKIJGI3lOPU3QwjG0vemKpou/uCuoMCuMZOEasb4gP1M1AQoVVRwkDu42gVwnW5ub2eXx+0Jr8t4yJi64U3mqYu5D6GwkU2YUItJG1k4HSZui5fTEq0MCtBfxtou4Ral9+7tnDagEmvL1wpVonNzr6OHJKXFXPxAis1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(36756003)(8676002)(16526019)(316002)(26005)(2616005)(70206006)(82740400003)(2906002)(5660300002)(6916009)(1076003)(70586007)(478600001)(86362001)(4326008)(47076005)(81166007)(356005)(336012)(54906003)(8936002)(83380400001)(7696005)(426003)(36860700001)(82310400003)(44832011)(186003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 07:13:32.5613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971cbbdb-d7bd-43ab-1f2f-08d96861035e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are multiple rings available in VCN encode. Map each ring
to different priority.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6780df0fb265..ce40e7a3ce05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	return r;
 }
+
+enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index)
+{
+	switch(index) {
+	case 0:
+		return AMDGPU_VCN_ENC_PRIO_NORMAL;
+	case 1:
+		return AMDGPU_VCN_ENC_PRIO_HIGH;
+	case 2:
+		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCN_ENC_PRIO_NORMAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d74c62b49795..938ee73dfbfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -290,6 +290,13 @@ enum vcn_ring_type {
 	VCN_UNIFIED_RING,
 };
 
+enum vcn_enc_ring_priority {
+	AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
+	AMDGPU_VCN_ENC_PRIO_HIGH,
+	AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
+	AMDGPU_VCN_ENC_PRIO_MAX
+};
+
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
@@ -308,4 +315,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
+enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index);
+
 #endif
-- 
2.25.1

