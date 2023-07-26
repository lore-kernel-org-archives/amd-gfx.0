Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6029BC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 16:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C207A10E499;
	Wed, 26 Jul 2023 16:24:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E6210E499
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 16:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vkn3SIUsrav/csftU0PFhioTxCY/ezhIkra4+e4R7hgMeesqiLF4NsaEVeFgSuGdJiV32bMMNuBlqXgaAEatWjMDfhExyHcl7mfBNcOw8EpasU/FYNmox72k4Hm2W0iRjcXnBlXhyTBR8ZQqMA3QAuah1rP1H3ceEiKVIp8pQ+ruGy0uHDhmwy9WP5S5ttidcAnTM4YYIhPpbvjcEOkcXXwntZDInt3ZlD/dxv8/LGI6KoPDm9wYdwZkxUeUpxD+BQGFv4bpvGC2ly4uh0UoklC1cJYGrUp6dCpEbvyzg6d7Efsc5jW5SR2EFNLfI/KueFHQ5WmOAHTCOehoHRIoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrSyrNoYRcOyIy0PC9ny49CmSbIE2qwhWiANQp1El20=;
 b=GCkVuefKeDkD3PJTQxGrCzH986td8V4kbnLPFFdwiEYK78uGxyT75BtwjOHFQ6vVJB3oGQYFGxAcvrN6hu+IJtCLzfpdoDmWorLrj6gh8Dn2gz6IcgSYLNlZkkCLJgnvk5y6niHjiLBuYryhdk9xRE1MNpVncbnBjeJ92zbyVtjIhbvHJmbIq8HWC5ZA6KkECYLdy80aF1tKEm46Hap4iLBN/cdIezBxfuurM9TpVxFxB5QGOUdww+Q7+au06e2ITQpqpnaPRysPdgYr8DOPNQll3sDpR0/GAiRSVMHYbZEffvyGJ6lBqx7nXHJ7TQ5CAXQKXRZEzqfdTnjcTthvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrSyrNoYRcOyIy0PC9ny49CmSbIE2qwhWiANQp1El20=;
 b=vuU47AHm67KtEVHGtxdgS9tMQzjR6Hlj2/hyn12ISY0KOkHUhwwzfb/hbtknkROkP7l5aXYqchsiUno7zfpthem+Wr8SH/0iHfRhc0yLMGT/Hewov/FfYwMjqU+WOHKX+MMCK4vv3UgjJT6HpzKD9GSjw4uZyitW99tvCiic+4M=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 16:24:13 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::ae) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 16:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 16:24:12 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 11:24:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/radeon: Remove unnecessary NULL test before kfree in
 'radeon_connector_free_edid'
Date: Wed, 26 Jul 2023 21:53:57 +0530
Message-ID: <20230726162357.2499855-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ac5896-c90e-446e-4ab9-08db8df4bfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KX2blxPWxbAUoqRdIlXgMSVBBgrUr9tercHRqU8xV+BVgmERqJsqvbfMDEyhCkTUGM/XoaP4wrS7Z0XSO7NGz9kRmXAN/pmUCYuOJNG5fYSvdCt4zQEuNE7dO+ud1I++O0b6yjayPhnwHD4ypmnD5ST0LPHiZ8AoCJOPYYN+G9zhFaN0zImcapS0bEuGXDA6Wejs52BEUZDrs9+omkXeY/saarvIm0EOtV8VhoQ3gTc9warpqjHfGSP2UkNChFRSFSZbQOEAc+dQx/3eZc5Go1a8huk3l4DOP38lcEFb7HfxKj6AjFsNolfTVTmB81nP481AWZYGNivKNYuIgzZYiinAtDbHE0znndFMTgitQOQSE3ZSpc1GJhYihqXClH0lV8/GY8n3uF1ehSSbQpGWKsAyvP3n/Kn9rvwumo8vmHEx0S5D7SZwEesyFj8oKsvjG6qZ7T2QzlMD7a+sm13YzSNRzw9yYXwpnK9ojFE/i3GO1GbeKWIEh1RdQJSc8r6E3L6MMlOuaGXss/C35cdTt1qG5x1Cxx6yp6HY6VCfZm9Bq+NviJwey7yJiQX5Q8lOVQE7o0tcy2H6X9QqTKeoeS05ibsj865E2GhltdzH97vTtn3MTpYnoItfs+cZIE11tsx491PVuLe90mlBwU5VKuPkiB/EgE0eSw7L2g4AoQ2DVj7SONnstpaAY9fbIZhW3OKCVqmN2cx2icspTXTWxF5h5Ft2LbAy0vctrE93iGzs4wfhvYXCCcgW0vBoLmKJ/28nxhi8yf7A1PEqmmcFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(66574015)(426003)(47076005)(40480700001)(2616005)(1076003)(16526019)(336012)(70206006)(70586007)(26005)(186003)(6666004)(7696005)(110136005)(478600001)(54906003)(36860700001)(86362001)(356005)(81166007)(4326008)(6636002)(41300700001)(8676002)(8936002)(40460700003)(316002)(36756003)(5660300002)(44832011)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:24:12.9068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ac5896-c90e-446e-4ab9-08db8df4bfa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
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

Fixes the below:

WARNING: kfree(NULL) is safe and this check is probably not required.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 4ceceb972e8d..d2f02c3dfce2 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -333,10 +333,8 @@ static void radeon_connector_free_edid(struct drm_connector *connector)
 {
 	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
 
-	if (radeon_connector->edid) {
-		kfree(radeon_connector->edid);
-		radeon_connector->edid = NULL;
-	}
+	kfree(radeon_connector->edid);
+	radeon_connector->edid = NULL;
 }
 
 static int radeon_ddc_get_modes(struct drm_connector *connector)
-- 
2.25.1

