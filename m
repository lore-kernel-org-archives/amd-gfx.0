Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC55C001DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 02:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729CF10E0C1;
	Thu, 27 Jul 2023 02:33:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2313110E0C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 02:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuFVLNMB4NMWJ2QEy8YsEErtl4NCimCE1SrRv7i+UDN9hOrcmhTKgfma5GpTWMobzyleJNN9aNUDEdpNvcM6TpOuYdVrBavSO2GMlADdQlXgIe0RMxCC8Y8k/rA6MNVZ9ssQMwExkdj6F886982PLVua4kamTCjbGO03i91bdaff1m0lgnNXklDxr/4Su9vs4Bpxap0UTxiUZ4ifq+M0J41IR9PqUWGzQi2dJd1uzg072Utw//mKF1AEmJi1sbTBBSr6k2a8Y9h2lqWzf48PYc2XFcdPg8J3408o8/vG81NqlYOpVz581/dxLXow9jZio4GFrVrHUfazgF2D/hUogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD/obWK1voyhzSDTxVPA+TK5sGUh+/nxR73OGnYqKsM=;
 b=cCs9p7216qbLylAX7EztghvOKC3QMbGU2pHjtw3rMwrlTmmhWFrbROJW9EgzAy7t6zQeSaOZsQRRNmhhP2hz5e0BGNYUTkGeM4UO2oP2I37+TvEBJxoWAk+lfOjm+PBMUDlh55G5DJL48NDsY8bx9xomz5mtnH8xtkPUCqau9rWHs/rJ3rrZEXnd4LHvVpBojTim2qMVkVwb0hw2d9/2c4aeE3/lONHM58oJOIq/B5F9cMwu3RKtCfQOa+dYfjAI9f1gVL5JEDguEzWIzpNTm+13tM3lL8FOaBiwLh05OckBsoWUf0hHI/3MgmFXzyr5N6WBH7XFXzX9ElflYe92Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD/obWK1voyhzSDTxVPA+TK5sGUh+/nxR73OGnYqKsM=;
 b=K4lceUNvtHdqTnvPEyDK9rTgE+jM3Ymm3SRbUhA39V0yuSbm+n3rVijN+lj8SAZ2rFj3QEoDbgYiS3CfOfzCIVvFBV94GrmfbWuyPDVw3stAXxaF+YHPz1LosykBnYwSahqKK+glvZFwll80bpUqzXcuBMv0/nN6VDoKoivbPaY=
Received: from MW4PR03CA0148.namprd03.prod.outlook.com (2603:10b6:303:8c::33)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 02:33:24 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::fd) by MW4PR03CA0148.outlook.office365.com
 (2603:10b6:303:8c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 27 Jul 2023 02:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 02:33:24 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 21:33:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Fix printk_ratelimit() with DRM_ERROR_RATELIMITED
 in 'amdgpu_cs_ioctl'
Date: Thu, 27 Jul 2023 08:02:46 +0530
Message-ID: <20230727023246.2544384-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: b02e314e-c89f-4463-61a3-08db8e49da10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vg/oDlgyoGkYdnJy6rq1ewJ32i2Jnf5jlOEgp9WyQW1ncnxiJB6a8GVMT4SMh/NJeRbJX/0zp3Jd3x+19GsxhSkpF2AJpXrKHOrKsE3+QaWA94r5HW69H2WYHlQKB5n/5U8EbenO8bFmo4EhzuG5Tra/Ow4DybTPodlwftvo4m3+dyz6Lh3ELL2HSP+tUBLckcCmI0Js6CxOFZueBaKqmsFOHAqIZfSStoC3AOczZcP5jl1eRe64+YskXIqMp7JAnsV/fVSWORp8jnnipX5WQC7CpimdxTpViUB9BZKcHSdGSWDY6e/o3UcJYKt8RnTq2E2IG8G96rdc2UAb27qjNnueDWX7I+ZRevKpWv9GHdfqQmVu7QLaA/qNVOPg7kgTnGENZtQzffEyKFG9VkDsH+oTPd45LQEjIWyxoN/WAsEyZ8pLW26SLmV4htqS/2sfpD3gjeztGdZz3EunvCPUCw7npQxo5jgD/FAjbN8jwb53e48/hncUKsykvXKkm4IK3EZb4pbsxmB2bEU+W42tAta1CNC0VG+w19M8VQauOAUgy1UQ//KfKQ65VGJUar1NvcoCGQQymfEZ8DbT9MAw/oAxQNrEa8dcm80FFheR4sbftDu+z/RqZKnpRt+1BYjjT8k+watp/Wntaa+C7U43ip5TR3pFe5R/bzqolRcudJEqRCVElKPZ5cZ2PnKCZRNZZYAQar4ZyiveTsFl59jjf09SmfqALhw0j0oV748o25IL1HBuIlQbYzkkriJdbC4lsNjPMvfVmQIZ3YnmfzVyrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(336012)(41300700001)(66574015)(26005)(36860700001)(478600001)(86362001)(36756003)(4326008)(8936002)(8676002)(6636002)(16526019)(70206006)(81166007)(70586007)(186003)(82740400003)(316002)(5660300002)(40460700003)(2906002)(110136005)(2616005)(47076005)(356005)(83380400001)(44832011)(54906003)(7696005)(426003)(1076003)(40480700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 02:33:24.3758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02e314e-c89f-4463-61a3-08db8e49da10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replaced printk_ratelimit() with its DRM equivalent to avoid flooding of
dmesg logs & hence fixes the following:

WARNING: Prefer printk_ratelimited or pr_<level>_ratelimited to printk_ratelimit
+               if (printk_ratelimit())

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 040f4cb6ab2d..a3bae98c7803 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1430,8 +1430,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
 	if (r) {
-		if (printk_ratelimit())
-			DRM_ERROR("Failed to initialize parser %d!\n", r);
+		DRM_ERROR_RATELIMITED("Failed to initialize parser %d!\n", r);
 		return r;
 	}
 
-- 
2.25.1

