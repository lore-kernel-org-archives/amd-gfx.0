Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4050FC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12CB910E707;
	Mon, 25 Mar 2024 10:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BsWFFPJQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3530810E707
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 10:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOTRECFm0xM/36TE24CIifsb49abjLVm6cZ66Uvl0LCyYtC4vg4QUNpEza/qe92aKHjpSvF79CkV/2YjgBU1NmMudFj9c6BSIv8Gy70s9O0Mz1gHKJR5izOhEXwwhbA1LKV1Mu7Jin78B2KklFTYYZjCKnoc1zBg3bJO63YxM1+W1E8tBeJJ6FOD59XfskFqsUmIpafjDt/PqCWOnFFZcJEQVhlkTbR3xFzn8NgwuJzsCFXXBjGHVTloqzWnuoUXQ5N8Flwv2bD1udjygjCSny2nYVI40mYRE7BaxLNvhAkH4ijcK4ZdxpWjCjh7WUAJOv4uWaA5JFwt09Qim+6nwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U64rxFg9bCX1pRwJPhUBvFU1svYzO6nOZBfaPLURv6w=;
 b=a5RBtt+dZQQBQo9Qnm/E5jgu1NxGLmuWK1KEL7z+jpI+K0S7M/P+uPwOzSHSCjUaiUaGW7O41HfQRhnBQif9n/a9Ef5CjefY/qjHWzteCih8SI/gw8gURn6efc/HgjLezg4wAyT7cy2b8V7y9B0PXPRZzbE9j3T1Q3W7pW8ZBPP2UD5HHaPSJhG2r3dZTToVURnWThEeInk44a+WILQCeGySm3ZsZsSNkmD5BizT/z4dN/5JCeOE2ab5sI5dUOnd2366nEmErOhM6U9JeFPAweCHBl/mb8AcXfJf99SJvJcsi9BNjRgKgTVGHY/PUVmoj6iZdiUWr7zJulo6rgm3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U64rxFg9bCX1pRwJPhUBvFU1svYzO6nOZBfaPLURv6w=;
 b=BsWFFPJQNvE4QSGhp0X1AOekVmuaai/TgM4qC7lDowo79blFcA0nBUgibMr6Covd87XmhsADGZRJNIaj7a4RAHweP4oJ6uDm0Z9Vi12SUwZUts85NK9EAvn1vLkAbu0fVyt51LO37vTbNPXEbDC/LBIEDFxptPM5jt9ECLffaTg=
Received: from BYAPR06CA0022.namprd06.prod.outlook.com (2603:10b6:a03:d4::35)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 10:16:24 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::33) by BYAPR06CA0022.outlook.office365.com
 (2603:10b6:a03:d4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 10:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 10:16:23 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 05:16:21 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add a new runtime mode definition
Date: Mon, 25 Mar 2024 18:15:55 +0800
Message-ID: <20240325101559.2807629-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb7ba47-5489-412c-7776-08dc4cb49fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ggLpkt9LfgoHDhDpvQ86ghhoPZCsb/qu0MnCkzNpasvuIyDP1i/2c5EZ8wwZVIWmSGYHzf++qbDy9EphA+aaYykm3w9mO8g/HxRjFRUP1v3DmiXtMuP8S5YVGKSSPbZmk6IThRxkZjqKmje5DqSFCuM6bkWe6RFlSFfOO9HfehHHW8EMEAAkCAk0UXat2CHzKCiF4GLB4gt1m5TfKYbTmtsK57b9+XyRukMypOUnXlf9pbCsyLFByo3Y3+AbYeY/xSMj6ypammbk/Zoox307U8tcYALex4ukZyJBDoVhKB4/nSy6oka4P1cHI1Sl8MYAEhKDnXsaFi7sxvUGvDMO7W4Fqaq9PF7A37xeo+rxeSaZ7wrJbF28brNwWx56U/mZ7Hb1e55Z3zElkSISkDTLW7Rpqau8Oa+uq5RgUwcmjNFljPTUDJxZt6n0a8eiIgLawa6sVOxlHwmLKuqPXyVi/EQuEBvZLOKJRms6ppe+jOsUNjXpHU97RtZ8TCx9YWMG+CRz5Se9goj9U5LNeTqR90PHkyfzmymRo8Xlv6ABInFRRjMjB00im0Jjyy6iLrNQkPtaecMU7FP2sUwpXvWGIe7rkKjVLcinftJyF+bkHoGxlMz+KtDir8Gmrv3RHt2NUDai+y9N3pK3y++7kZGGTXk65ZrfnywpnggT1ZHY1Y3XdS3Xd+e7qYDbyUbb8W7fVVmtl1FIqvtOLkjBPgtw2RJAner54G6pTKduKecjxd3e8b+w9pKn6vAvo0HjwWd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:16:23.7637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb7ba47-5489-412c-7776-08dc4cb49fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
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

Add a new runtime pm mode AMDGPU_RUNPM_BAMACO
and related macro definition

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 621200e0823f..e6cad9f7aaeb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -50,8 +50,12 @@ enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_PX,
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
+	AMDGPU_RUNPM_BAMACO,
 };
 
+#define BACO_SUPPORT (1<<0)
+#define MACO_SUPPORT (1<<1)
+
 struct amdgpu_ps {
 	u32 caps; /* vbios flags */
 	u32 class; /* vbios flags */
-- 
2.34.1

