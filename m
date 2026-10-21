Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F0606A31F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gajaDppS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA1310FD55;
	Wed, 21 Oct 2026 11:09:55 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFA310FD55
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJuKMkYO3xVJxF9AAW+UncBg+BdlZpJJe/FOMRCQFpV7073YCuJvaXWeI6nFcDlS8xxmvdVsY4oAqLIbFNq0YLaFIevQnezNy3m9OO+sfX29P5Ry1NrGAtVPszhIh8EV+c2mI0EXOQvHY+2DK0FMkTCY4ZD4YDTgHSe1CwUvVrOmI0yokreFGh3+ZdLP1UlLDtFV+wHufVbfLrxqKUfG5xH3pbtK4ku5lL9z+wUwzSGSzY1ytJaFPnAXLmomEIQxfuUJk5QfWpQOVnHz1EAMGSs2yRIJlZxw0KMIbVfcv09iA/7v91vKjO+B/R39x9KFHxVlKnZigdkaOoqazP/aPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAi+0jzkdY6zpaaw58H4LmHO4mWLAzv6FUr9ytPwuBc=;
 b=U4iRXhU2YF9n5lvXe7rhV7m1e5ruR3MvtmtcOC3xwalyU4UNpS5DDmdtrzpkbL6CLI5oaF50/TbS+FFKufwW/FMJOMDtlcgZ1wfKi/GaWIqVCVXLSv7i1rCDda4Yrxq8HJylEcljTVc+mDQ1Fk2GUMIZobt3X1wtEQhqkWhgAY/BwhBaaYzY7eLow3w33fEcLr1GD59iuNLUVW7e3pZ8+Qeb5Qhm5BMrrTQd/dWyJ9ulX/RBE9d9Lon88hniHMk0Se+9uRoSIMuduqbrzWGfxAJCcc2N9HhzqO8IHHNVnGwk7ROKnLPc9uK+V+PcDzbCVA8yJttLONqf2hP/b4GLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAi+0jzkdY6zpaaw58H4LmHO4mWLAzv6FUr9ytPwuBc=;
 b=gajaDppSFtojcaaUQvyWANHZ8jwkXAH7fPaCsLOWnLGsQf+O/fnBm4zApPf6oMLpHljAzmxFIsMJtKtSdwTSJ90GzPH6W4tY2PHV2Exey/NogQCKfdDdMh21p8Nf5a/NxEyXnd3rwZ0PvsCNBZXVh58zgW/2rgbA6yq+O0gXMQ4=
Received: from BN8PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:d4::40)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:09:43 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::1d) by BN8PR04CA0066.outlook.office365.com
 (2603:10b6:408:d4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 11:09:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:41 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:38 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH 09/12] drm/amdgpu: GFX12: set mqd->perfcount from mqd_prop
Date: Wed, 21 Oct 2026 19:10:00 +0800
Message-ID: <20261021111003.3371005-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 3289644a-dfb1-4b7a-5cf3-08df2f63cdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dONS2+XHMhxRPSfln4Y6UboEcGqf+nLLjuOSMgF+Tpehol2LaXPeK5I0OLkdcOyKpUYjAFvz9WLU7R8CcpsSTsyCEy2Gd2AwEHak54stRX6avwDQ3kWjYsHRg/NOdz464lLFuKbwTyey4flZjI/WzMw814N5dZsPjXXVAIDsatXTMhSKXk7pZtaewVMKWZlg/7TNRqM8QpNmB/pqU4WgSGWFDhF55txgiGC4x7M8eQwpU/s8U0SvFZpmRxf1Qw3NZ7YtMFZ95x2JeimdW5Vawxl3tVBNHR5+RPxTjgTxwmUGIlYMxQBkJ5dpVfbWb/XdPywpn4VNIAZ0BAddUtjcwbQ/bivmh1LvcaG/0m+QG3WMjIM04m0kjDmW1Qk8zy76G0yvt/OkVYKGpjaxNyLNdeb6jU7yEoByFbyK2tPvaOKJxz3IU03RhRk4xWOpbLsRLYfQ8qdr07DlbEibZeWwV7zTt7v7UkePlRSEKnJEp49BAie4u5RjJd4OmpFpD7+U1M7fJL/Ob35gpF4LCfTru1LATuLtKp4unMOSDLeBZK8ds5QBECl4SSnhNw075CWQu3rj9BMuXIhJP5RZJjVA2fsgsEPlke1U+uyoHZbjKfDKXCY95kMjQsg9LVQrwM4eczGfx2hEeSLR+fHrn4n2zwf4cBycWngQBBbeBMDwf13RKFQaJhimEqkN69hfTbUfC/uKMKKu2WiI0nvYZTrWSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(10067099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n99ZSJxrVisuVQd7SpZLKn4KDFtTfUnMXMxCoa/j0hT/qvcIr2R8+M6FJjMX51IMLiBJIZl3xKXyxuL4igchrEcdI5TDTjyJJSd5D9ksbq2A70uoAMmdgPF34mISO7N4aZR5fSMVYVD6T2kJiNa9dQMv7fs4zpR87JGKlYwJiHQ7ZrQNEMS/REwMivp83FR1JKNkCkSAqE2xZp4m5f6ezu8L41h1MTocxjOTArFT3aBHctvabA9oiTtzDeTYlMvYQGwkKm3lO7fNFMP6DEUz0kQj/fxhi3dbXZRYHKaRSNGFy2bmBqtjDFizQrDe8KkBCk5rUnJDWxDqEpLWmy609WndVfmXbpIYAh0IUM++uHkzYdWa2iWDvXBKM+V64eVrEsJrlelDwuGjupZ4vTuaKPAHx3NdrKKpFaXsv8u8Rh7DHKbizhVqQ/EQI7HxG+Bq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:41.2733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3289644a-dfb1-4b7a-5cf3-08df2f63cdef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
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

This commit implements amdgpu_mqd->set_mqd_perfcount
for GFX12, which helps setting mqd->compute_perfcount_enable
from amdgpu_mqd_prop->perfcount_enable.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 398e9c463ec6..3008370ad0b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3163,6 +3163,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
@@ -3318,6 +3319,14 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static void gfx_v12_0_compute_mqd_set_perfcount(void *m,
+						struct amdgpu_mqd_prop *prop)
+{
+	struct v12_compute_mqd *mqd = m;
+
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
+}
+
 static int gfx_v12_0_kiq_init_register(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5547,6 +5556,8 @@ static void gfx_v12_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =
+		gfx_v12_0_compute_mqd_set_perfcount;
 }
 
 static void gfx_v12_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.53.0

