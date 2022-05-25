Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E162EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E3610F7D3;
	Wed, 25 May 2022 16:20:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A18F310E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeOwXOP11RrLSX/NKeOV0QmGfTEz2bGuz8Gtc5BfhXHHzKixCHkeFDoi0Wne6qdCiMWrCDZ+eJL2YS4R2q2QKJsqc9eq5VQ0aADnl5H09PeCEJjMiJTBhHeSWg/jAkyD9JdYRZ8/QaxUP3IL7AdnEpPPzYcgzxEaFfh1UzJsbtjtCU566PxMjcpPzVVaAo5NaY1SDJHS0YEf6xd7aq0ltB6ziFzzzpSsVi/jORZFzbe3xzFYIbC2nYN2LbPgeQsEYnJzP4VGPvg1QxACLxjrsgL7k02thhTNj3ALouPHBWMG0nUawgjHliP8Lk5vnKHahkhKBAiJF+Bgrc3eZE52ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csx+E5a2h3qzS8hYgvdTMzYigs2ZYprJflTOOpw+E3o=;
 b=AFO9dQaq1vcsek/BMme93mvBWMVdSvNIWorfV23VIE6kzaI3BsQ2KuM+a3jeL+vYNwlHLryMMlOk6U7srky5g92Uc1pOyLE10DOgPCTJMLKzvZpyFbRR2J6dcsfnjm01Tq8VGxU8TL+m1MLHNqSmrWWBFWj+MpQoa68mJxcSqOLkxzbueVLuty9ykCrRbxBOebMmJoiYdbNoe46Ztx7EsF75p/KOeiFv3M2NWnMnbLcqGG9AOqAmJ0uOPRkL2Z90Z6Y1V1BB+W/Ig7+5LX1DndDsVVWwoYr8XPZdeA6u4tNFOA62zrJkdeFrOlJGUCf7QGr/Away86Dz+q6tGSjEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csx+E5a2h3qzS8hYgvdTMzYigs2ZYprJflTOOpw+E3o=;
 b=qFNldOrUau8oK9dGqCOyBM/uJD57ZXdXzXeFB67hyJTJO5Tc7GqZSCExe0Um3GlcKzOgVK6+HuQe+NL1QCUCjuHb8nLifMWru5qyDmdS4i8VtInYJdOi5LufcXAP/3OJyozkDfCikVpc3NQ+Jp7Kw1GnbEweuPXkAQZkmtrgCY0=
Received: from DS7PR05CA0090.namprd05.prod.outlook.com (2603:10b6:8:56::13) by
 MWHPR12MB1677.namprd12.prod.outlook.com (2603:10b6:301:11::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 16:20:12 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::37) by DS7PR05CA0090.outlook.office365.com
 (2603:10b6:8:56::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/43] drm/amd/display: add DCN32 to IP discovery table
Date: Wed, 25 May 2022 12:19:11 -0400
Message-ID: <20220525161941.2544055-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b8e09f-aa32-43aa-2088-08da3e6a717b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16773FA292F84C77F0DC2442F7D69@MWHPR12MB1677.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qv7/RPgE6ZaYQFciXaVS1y0QgQfv7Afo4yi1nj41GPYjZOEijdThginveC6NNq1UiFMklqvi9AseUAudUL4/Wc/5UcJsNetnen9/cfkGJBKv2QApct+YQdeYp7uwFAUlOEjRw0OeOV8dCEXa6KtLBJ22LpIZr8AFroKldoS9YvKX+jSW3GKCq7VxZBgje/pUPvfBDgw6NuvmKyGC2OBv8Ff9vJmi/ikqvipLl9p4S84U6GPOuWEubLd7JDKa6qAb8UAB7qvVUG8Pu/PNrFXbUEfpTOUC6L05xX4YqpddPaZdwjpXa1GVs4Vl31JZ01Iur/Z95Bw+DQhA7m8sQbB4vFJRf15dA+KpcoTOYa4dXZVCQjI33A0jMVSZ1kTSNjIeq+sBzyJoFQ4HYS6FywRQc9C+wxF6Sq1Br/BTDSGKKFu1AFM3ck0pRYedIaOmDuDJvtOiCRoa9Hv16UeGIp7+fyG3FoCfN6g0CrsAKjtuEmye6eHoSkiUm6plBkfntD5KXXZJtq9/t+kU92viYC0PbSf1MYzh+376tTYnPVtkleWmwryB9hi8k1QRaiap27ivM34/EINPd5ysLluSpGN+cqgBeLiJEUghvsEDeLDKAxOVTXIP3Xd+R2nFyUdcrG7wZGe2LodRGde5xEqL2wykXI+hI7LYHH/E72Q0GJq1vEUxJ59OnTrHdPPyKdL4By8s6ylnue7YLwQxsaKMA9TE1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6916009)(81166007)(316002)(356005)(5660300002)(426003)(54906003)(4744005)(2906002)(4326008)(70206006)(70586007)(8676002)(8936002)(7696005)(83380400001)(47076005)(2616005)(40460700003)(1076003)(336012)(186003)(16526019)(508600001)(26005)(6666004)(36860700001)(36756003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:11.6602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b8e09f-aa32-43aa-2088-08da3e6a717b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
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
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Add DCN32 to IP discovery to enable automatic initialization of AMDGPU
Display Manager

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 47f0344205ed..91f21b725a43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1709,6 +1709,8 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
-- 
2.35.3

