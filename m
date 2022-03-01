Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3346C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 12:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C3C10EAF5;
	Tue,  1 Mar 2022 12:30:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1560810EAF5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 12:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZMgzQvBywdIpzoBNFNy0rdJq0b/PhqrMnUOsE2TjtEVB9iTRx0cJtk4kjMXUpXtGmKVl3Ih9b8whFO0rcDqtH6NU4AInhg050iF9MxbqBJtdqClEYdPnTpIDiS/+I1eq1LdNwuMX6GRmbqBmxWZfY+g8MPuW24JLUyUXchfRe2Bco5/4c2t6ekmv1yWe4JElXq+i1Lm8a9QBSXzp1qgh/LZfUUat/9Br18DMQaqqSS3C9MIrLksu4xmfXDB0Gf70AGq9fBxP47G5uKVP6QnzO4+cWPKRSKnTQ2zO7rvyoSpKPNJI1RQBwcxN9iDqVm5ChK1YcE61AhrboF5tR6Qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A79IDzp9Ik85cwWEfwYhhKWKlLQwnVjJHHUVjP+NeAY=;
 b=AXtJVfjPpcsS/xr4RwhrPAeCVAfNswm4y9pf571eavl3w2aNpEe/ERUnSbh0ZJ7ee8jUAl6l9c2e+Y36QdCrAsmjod6cBK6hinmgS03478LuH6OMJKEvE0m+e8VUriw2lAgcyfrRG1oBEIsmMRJ0nAlmtXHlsmn4dPlS74/RJ0YWuJZDydqRwKIYwgtOKmIvnSu4upG9C+04P+pHWtu14BPLsL6TsduTt2QDYc2xaZ9aWd8iaHSDID5BfYKDcwQvAT6tWLw5Wp6hDpX3PJ4ky9F0TDzM46kjh6Bi81G29fAxQXIrVxk1QRbhpZQVkX3mTFgesYPKvrXQZonDuG5SsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A79IDzp9Ik85cwWEfwYhhKWKlLQwnVjJHHUVjP+NeAY=;
 b=5M1zJw4OENCFP8e5M+7hKkf1ls8rYZGHXJ1Kgj8v+/plTdchJY5JkxhX6oE65YzXX73vbNaxl+642HvglPXt5TNA2TqgZ4rBV5SGHYQ9lkWUaMZLYZGGQhzKvH9FGYGFyU8MvbunJUwjGuI5KBOpWfeLASrc8OGDmQ+0Tlg8ZSI=
Received: from BN9PR03CA0521.namprd03.prod.outlook.com (2603:10b6:408:131::16)
 by BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 12:30:49 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::a9) by BN9PR03CA0521.outlook.office365.com
 (2603:10b6:408:131::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Tue, 1 Mar 2022 12:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 12:30:48 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 06:30:46 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: enable gfx power gating for GC 10.3.7
Date: Tue, 1 Mar 2022 20:28:13 +0800
Message-ID: <1646137694-12053-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646137694-12053-1-git-send-email-Prike.Liang@amd.com>
References: <1646137694-12053-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 436ef85a-e9e3-4051-07ea-08d9fb7f50f1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3079:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3079C03D24428633B50237A3FB029@BYAPR12MB3079.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylf0e+//GhmMkiSpufF7+w8ZuP9pnoo47PAeEkkEhfvDKokK70zHav59rqmfR6YbSERAFOSSIR/CJ/sgx3Czqqp1LOY0z4kUHLf8VCuviQYDQq88Mv0nx4uG47DAIWDeoIP9fHLXeTVTkNKlPv7T3IHt1rqYXU3LARywhfF96/PjmDbLQeGcdzluUw1Pz9qsQuq4uabqabCOCEQiV5ouR2/Ue9DXaM8Mg1EoCCQ3MjmE4pfrUO4kqMu+Tvh1WzcNJkwHje+tU+kTYwEjUp4ojKVPXW077Z53tXd6lfJFzO9tOw+cXn652z+cpsNQO6008BVD9QHe9dINDOsFdP5JZTlOpLyh7+tbwBLppba+uPQQHAIpC9JGKD9wh4o3OiWuRIjBRcdwSMWztduVkqADwPWEWMaZ8GgLEP//PelDnSCz1kvNx9ZUEw05oZnXuU1OiVskAjeHGYRLthNubCDi5Vkr5jDZbpjnREN8JtaK4tsfQd2lpOH1i7KaepOQy1emHM5N/0t/sqan90b39bjbApjvGsaSlsh3PSkKg97I6U/pod2M36uGuCh151W4RLOMU42gyH/BcMFrh3XmYFjugwJv87gvSyHveILq30HP2lzWvjc823Fs1h2uhPH4bpJkOgfS55lmHIQsWlIa6RKQB7STKvqXOnuq87fcyktEwS/t5x71qqNdbuntonS5wzCHAdf6TXuFrwI+vifo1h7h+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(8676002)(8936002)(4326008)(508600001)(5660300002)(86362001)(70586007)(70206006)(54906003)(6916009)(316002)(83380400001)(47076005)(356005)(81166007)(6666004)(36860700001)(7696005)(426003)(336012)(40460700003)(2616005)(16526019)(186003)(26005)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 12:30:48.6246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 436ef85a-e9e3-4051-07ea-08d9fb7f50f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx power gating for GC 10.3.7.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/nv.c        | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fd7ded7799e2..e048635435a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8348,6 +8348,7 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(10, 3, 1):
 		case IP_VERSION(10, 3, 3):
 		case IP_VERSION(10, 3, 6):
+		case IP_VERSION(10, 3, 7):
 			data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
 			WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
 			break;
@@ -8417,6 +8418,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 6):
+	case IP_VERSION(10, 3, 7):
 		gfx_v10_cntl_pg(adev, enable);
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 05487894120a..e19f14c3ef59 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -959,7 +959,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	default:
-- 
2.17.1

