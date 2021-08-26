Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB188C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A5C610E8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92A5C610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4246E5AE;
	Thu, 26 Aug 2021 10:08:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133466E5AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 10:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UABeHZS5gV7vgBBct/sIR3q7Yl9cYiESzR73VPqHuX6U0+UOaAV99tQ7wmIGRJ+DcaZBU0VZv4ye9b3uBHr0t2gNS3LZFc32qaPgBFxt7YwNmzzS1/kpXfdJUA24bOyRPQlsia9SiG/a26Fl27Hqyy/Nqg+AAdVTyQsnkYCp5RRSbm5WmYdRw3ORSNQ7qkRj/Gvfe7QKYEMBpDQVKS0IBoVt0s8cFzVOhcbz6mMapLND994lzM1X6GG/AQFZNX448XQpQwO+QUxruKeulXZAFI1Qh2phuwrhc00HTtQnk71yxi2Z/k4H0o4GgQi/8zOcfeEWFozFK+zu8eTysRjIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDaPbgwrz2TlPP3qwOF7yhUAmR1j8Ks3v+1ex3tKgIA=;
 b=Y656XhQa5a2KrvmuEw5CE1HVxfhEASN820RwEEGcmsU/KOFSXS2PKum0o2qnZdenkbSCmPdWkjiImCeS6i6FqjbBGAkutmtqccUh+PnC0qNuf3ehnFXsdatZIuuEt+g1km93RB86qVEmUMDaoQDG9q0dxP4Sc3NuRxj0XIBGrfJ1BzKu5blEH4h72DdJh2GHyfHv+H29adY1vG1SbkSYqECrzVcM54ZgBhidQbPUJMUYP9CYzMS4TOMJUvK6OsYq2KOqAU7J9uHfYzvwAjzwlnKNt1xquH1ZCyz00X7zwNTMg+M1PWLmQvqQf66xiBUI8k65eX6rAiMhD+tLf2z01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDaPbgwrz2TlPP3qwOF7yhUAmR1j8Ks3v+1ex3tKgIA=;
 b=QFANEFhGa0KwpGC1J0fBXRXgaMjtGM3rbdfKVDngy3ZNoQdVvNnq4UeVrX4yj2puxM6w8ULa7U9sX+KdzO2zbL+9E8YoSfYwWW5Tgd1BWasE2Okt1sc1Pf31auUeQpd7IkUBOy+HKNn5avhhdiVzE4RD8s+sWEQUTKfZjuzz7TY=
Received: from BN0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:141::13)
 by DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 10:08:39 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::3c) by BN0PR07CA0030.outlook.office365.com
 (2603:10b6:408:141::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Thu, 26 Aug 2021 10:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 10:08:38 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 05:08:36 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <lijo.lazar@amd.com>, <satyajit.sahu@amd.com>, 
 Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v2 1/1] drm/amdgpu: detach ring priority from gfx priority
Date: Thu, 26 Aug 2021 12:08:24 +0200
Message-ID: <20210826100824.38041-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfeccf78-1ccd-4391-74a2-08d96879798a
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55498F6307BF2656E9125F3D8BC79@DM6PR12MB5549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9T378J6BWSWUKZnm8mexbKYqvSrrKsqKTS2e1FYfNZNxpDc+Rw/0/jRyHYVtPmUMjcz8MFbgeqxMmjoqdI8moWkXiGF2G/+GvEBwuqVOCfkclV776x5eV3HyyboYALg3CHJklUW6OB2VoK16PjZRJC9YQOMFzXAZRa4x3L3Xv/wX2m5c1KWgy1E5ArMpPknk9dv1R1gsKZlT3MEPigl/U452erBKTGfEBhrhvPhbbRnDrSwcqKcJMiIqdOYooDq2T7DyW9qi4pG4fiGZtCzoUgHOkFc0uSK/0YZPUe5PAkMHzoX8SKekGYYxjzu1QCNlcXJn2ipRIW8vDFipG8aG52tQ8/zO4C3LIQiAHBYsnxJc+/d9hqhiH6fSY2Zh7oODcfhwwYcZntxM6NM6OZWd2QZFqZ2Su8zjvTTJSBVLgT3uTvNtDorixRUYPhmmhYO7VjRPvG+38aBy4mVynF33kg0zy70AWBTpZVp7/reo2gyIT4kmX2dTNrANhRieBE26zZe+cu0ncxqR76OHZ5rzPlwud5Tz++XRztzPk/8E1HBfv0xylbTVcSyLTHHYlm5ow8ghh91rbi4p6HYaaGiiiq8C7xSlKOQnI3VfpJwiqq00qEQ4EIXpp4UiPFWpQhCY7T9d5l24Fqbz4rf/WqCuR4AWipFucwiFI/65tJYiufblHCThJ6SNLt0Ue11y7DDrt7wpI2rDfwnEE7QLjozuMxawq44BOZ/VhevA5N8wYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(2616005)(36860700001)(70206006)(54906003)(5660300002)(44832011)(8936002)(8676002)(83380400001)(36756003)(2906002)(426003)(70586007)(336012)(47076005)(186003)(16526019)(316002)(7696005)(6666004)(82310400003)(4326008)(478600001)(82740400003)(26005)(6916009)(81166007)(356005)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 10:08:38.8654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeccf78-1ccd-4391-74a2-08d96879798a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5549
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

Currently AMDGPU_RING_PRIO_MAX is redefinition of a
max gfx hwip priority, this won't work well when we will
have a hwip with different set of priorities than gfx.
Also, HW ring priorities are different from ring priorities.

Create a global enum for ring priority levels which each
HWIP can use to define its own priority levels.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 9 +++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d43fe2ed8116..7f747a4291f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -43,9 +43,8 @@
 #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES

 enum gfx_pipe_priority {
-	AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
-	AMDGPU_GFX_PIPE_PRIO_HIGH,
-	AMDGPU_GFX_PIPE_PRIO_MAX
+	AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
+	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
 };

 /* Argument for PPSMC_MSG_GpuChangeState */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e713d31619fe..88d80eb3fea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -36,8 +36,13 @@
 #define AMDGPU_MAX_VCE_RINGS		3
 #define AMDGPU_MAX_UVD_ENC_RINGS	2

-#define AMDGPU_RING_PRIO_DEFAULT	1
-#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
+enum amdgpu_ring_priority_level {
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_DEFAULT = 1,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_MAX
+};

 /* some special values for the owner field */
 #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
--
2.32.0

