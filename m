Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804C6E95A9C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 10:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4723610E1CC;
	Tue, 10 Oct 2023 10:18:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596E010E336
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 10:18:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/bXBBZHc6GBtgLlUUUQmGS7FvzkuLh09Jq7P+5OvgFv+FTss3GwxOHeFqMgjhHvEi5NYI6pmywI2zFl2c0F4wL2JMM/2F4F5A5XaMJx/F9rleOvQUNJ3nD7wImRm6KGCjT7Rp/KvwCeW/y2nIYQ/suIkuCccJwOZS1HHozh0Lzsbn/D2FQ91h16AQYXUmf9GS3y1OmolxdSTflnQZ/FzYQh/2Se3j54eAIpVASAyjz81DyuN+kmupUmlZTCw7i6yeGMo7lKvvU1B+XZDmlbxf/mZlnihYE0nG/9Rj33ktjVV1QUcxtW5aQJye70v//DRanC5hS6TtwbDql1bsRhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGt8PYRGijdXNsuNxmG+0M7upQP6QpDn/gvdfLcV9E4=;
 b=hPUYbhR45XLfWHxrijxnDNsXnCLoJ8nNBphrrJZq3+n39fKhplGzqaPjbgr88zWrC+YfqBBHaXTD6chMnC4cnvrzoWsywR8MK1D98/FmFXIMxPQzQk7iRd3S6RZI8L9Hx2tpy3OShLWGkijt4K4Z/0Cc07LVfcYpEBXf9vpRJrAgtr5MBQs7cWOGdefqdVNJS70NJZJL6sU0b4uKjsTCFf788yO6Hd5WleNIGHmypXp91zAC6yP0e/M6cM+FE5oxYr4uXpM+Ukird+vEMiBPYIsEdbUHdTGvAx1Vg2t7G960HTanQlA/AseKCnz6WLOp8okrOPsLCeNBW4tk3akmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGt8PYRGijdXNsuNxmG+0M7upQP6QpDn/gvdfLcV9E4=;
 b=LfSUgLzGCbAgFFIqKgjnwzxX9IAFnw0W2US28S7LZmBvCe2S1lWFK93ttb9sLPuOUvoxuHFaVlLDs+UU9wnFGYngga3a008QT9vpQKL9nyd/54kgw0yYBh3Hb2kEJOQvCHB9ko354aia0J46jxV/shX3xY5YnpkVAdNdnAoDbc0=
Received: from SA9PR03CA0029.namprd03.prod.outlook.com (2603:10b6:806:20::34)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Tue, 10 Oct
 2023 10:18:50 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::f1) by SA9PR03CA0029.outlook.office365.com
 (2603:10b6:806:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 10:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 10:18:49 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 05:18:48 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v7 12/12] drm/amdgpu: [REVERTME] block usermode queue IOCTL
Date: Tue, 10 Oct 2023 12:17:52 +0200
Message-ID: <20231010101752.1843-13-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20231010101752.1843-1-shashank.sharma@amd.com>
References: <20231010101752.1843-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|BN9PR12MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c34574e-4b0c-4d47-818f-08dbc97a4bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3z1xwuMLseVohgH+vSGY23jLeKjyauahQE+CEMxD0s5HikY+KuJq2odg+W3aooPYOlY7mWIWe0Zql1SjdZ3dz06fvPm7+wRemON45OxrGTWBtirqT1l/22jizFoxWikRsM/vQ4cf+2V3wID/7cs/s2xyI7IuGInX7mRN1R6tgPEhVQxKi2PEJ+xn7yOQV6v5OZawu7y8g44FxJ87YqT6CmtdHHskYXGNTekF1qu12yLpdeQQ5JEdKyevStPMzBI71mEIkiiVjx75jJlEzVJVQIedkFENytjf7IZ+PiwZF18DLHQ32pmiG6X3uTP5rHJHvsv+sutxXraaErwca9sfNC2XWtH/wcgkd/mWvRPTy8FoTUoHh6bdaopXhLIga33s9Z6mTM2lAr2HWfCGzhI+sh5z/q/LW+wYyPAw7MmnLGzySbDElt7aNW6jaIGgVS/fdK2zpLM8xFRpcwvjYRLhPBF25KNpaTF5CGG3YntxofLIf6a+x88Y1XvIUGNATJKxrwTASRQvrjZdlYNFr6TT9Wsm6yQDwrhjHB+++9reElGurmGPE9PXDPjB0Ld8+I+pTcom5EU9UBYzTNxyftriQItxS5FdWsKJGtSRpFOdAyxphoVuKThxZg+iJz6QTxe1WGW/R0CevCio754/sfc0y47VZ5IrylMAy/g1Ec1PrIXchovLu3aPDdlRVEtR6mM2rCo8xWQRwhCXhzb4OUl5IdZtBoHuIbj2j5XErpdL+T/dCtWnh8iU/ubMxtm+lHjYol4FHnLlObRc+yereJQCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(36860700001)(40460700003)(8676002)(8936002)(70586007)(70206006)(4326008)(54906003)(6916009)(41300700001)(316002)(44832011)(5660300002)(478600001)(4744005)(2906002)(86362001)(6666004)(7696005)(336012)(426003)(40480700001)(81166007)(36756003)(356005)(2616005)(1076003)(82740400003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 10:18:49.9390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c34574e-4b0c-4d47-818f-08dbc97a4bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch blocks the amdgpu usermode queue IOCTL function until
a valid userspace client gets merged upstream. This patch must be
reverted as soon as we have the mesa-3D consumer stack available.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 26cdd54acd74..22daeee5bf7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -330,6 +330,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 	union drm_amdgpu_userq *args = data;
 	int r = 0;
 
+	DRM_ERROR("Usermode queue is not ready to use\n");
+	return -EOPNOTSUPP;
+
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
 		r = amdgpu_userqueue_create(filp, args);
-- 
2.42.0

