Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E54C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 21:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB9910E30C;
	Mon, 14 Feb 2022 21:56:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6629110E30C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 21:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIbk9mpHbff3WsojXuHgLSaS+ruXMn+BKJ2U9beUmq1jcTYDaD5ROtDXL0qLsFlTnl7fU24yTTPOsJNKWX3mcXJQruBJ4mQYJcWHTp56EOCADbXtBr0+L8ThtGtuXdZxAym4eCF1HoGRcdcmHO7xh3OPirlhrrTqjnZOWsrS9spZT8ojsvPVtpV1UMF/i5hYJ5flUmGPjGUb8fx6YcEtxg67yQaVLsNhFz610DQNMRywTLL3vmH71Ndjb9C79P1AKhhCBfbohts84t2lL0PuULOKIBQfI7YSceA/42GFUTXJ9i7vN2c8zgLRCE+u2dc8zXb0XCqMTGeOcUGWyrAWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfwWH6MfraI/SXkq3h5QD7vFaRS99GIEZ+kDfWGxj84=;
 b=gSLyfpKzhXVtL1uAdwiYPRFg6EBlYHK2t8GktDnRJFMtx27DMqizgD1PVTbE+SYvgKyj2yVs3IdBa5YiqXjOX8NJHHb22cEj/EDPKRVYEEB3acutE61zAiB+POY2KbKx6PMbO2x+uuFAK0hWpEl38ITmrt8yiwNlOp3s5ZdB2ScGE81XbsXf+F2yh5j+oN6u3+6LA7ehHzkQPXoItst0h/KlkhWYxojzXtHG+0+qpfawpg/K9E/ktWY7ZBJPY3UyP4BThnSwp0QmkvuAueLvegOPh7p7j4Ok5fZUspWHrPZ2RCvhvb61VGOvhqw3ud6oXci3jX69LUOf/OZBdDoIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfwWH6MfraI/SXkq3h5QD7vFaRS99GIEZ+kDfWGxj84=;
 b=CZ3n7H68ikBUKx4ccesVIisgkhwKFu3rZIKIajpIcxe+7sWMBxNZSe5LwwCz2Wa/yGuHv35c7Ay19lsEHP7MM7CIiGolF+hDWrRYf1LlMW48bPBkUoBvjxmPDZNiIH+/d1Rx/wrdK5ADZSK/qa98n3CjY6EA5usmSMKEu2y5Vnw=
Received: from DM6PR03CA0070.namprd03.prod.outlook.com (2603:10b6:5:100::47)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 21:56:44 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::96) by DM6PR03CA0070.outlook.office365.com
 (2603:10b6:5:100::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14 via Frontend
 Transport; Mon, 14 Feb 2022 21:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 21:56:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 15:56:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: set sw common init for GC 10.3.7
Date: Mon, 14 Feb 2022 16:56:30 -0500
Message-ID: <20220214215630.2116719-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4830e2f-b949-49c0-420a-08d9f004e3c4
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5407:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB540788669A97ADE0694755C9F7339@SJ0PR12MB5407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z96JliMMqljo5SEbcoxc+Vtzw8EEc+9nU6ojMye+YkssAeHfxcDJOWgq+l5PIYJdAjdWEIRXEM3olouT4W+usz4SvgL27IdY2yVwUkHOYNgu19lIDP0quFvd6bdJ5Dl9GNb59F0P3PIRmZnrroGyH5IAg0fP72TEudW85lS9QxED+lA7Lkjlg1qmNlpHCTxp2tb7iCpiPHjNokm6ZN9RVTdwHHTIc5m/ou5MRNrYgf5izjlZTM39/AJuwfNbxyBwwCmfhK08Ry1UZaUdj6p0woyFZhDA2rwaTpdnfuA0JGfV5AT2/zTymRIqZmLip1D4tvlDJ2ZxpSU4GrseMhSld8F62c2lEH+Tb2CumANypFe/KNzpJ6ZLPsdWzUVX8hZ5gwr4Jt5kqZwFlKi5woqvspx73ATf02851lg416JyYmyJwNfWUpht9laQ9IsqcxTjhK1A5s4vi/8BcGkwm67B+g7LiZ1qtrMThcwJaYy8nl7LXnS1kRZZjHAD/rAvSZr4xCvRDlrzUgmx3lqb4ZFEXwpq7yQY5orj3yUtYQ9hDTuBOwGlETqbDkAz0spJzGHNVErCidIFTEd+gzQXDxXg1A7MYJ0nPrft4gsGAJb4RP3LmzcHVHMi8AM6euSEJXJ4ZZoR+uS1lB6bf32+l7flm0NBmNb4bWFXA3pyTxyz91AuWiXcFK72ips51MDdRDf4DHmwtb0bOIkD+0Gsv2zIMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(336012)(40460700003)(47076005)(4326008)(16526019)(83380400001)(2906002)(4744005)(186003)(8936002)(5660300002)(36756003)(82310400004)(508600001)(54906003)(6916009)(2616005)(7696005)(8676002)(70206006)(1076003)(26005)(70586007)(81166007)(356005)(86362001)(6666004)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 21:56:44.0523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4830e2f-b949-49c0-420a-08d9f004e3c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Set nv_common_ip_block for GC 10.3.7.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a7789bfbe458..d1eaa990848a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1174,6 +1174,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		break;
 	default:
-- 
2.34.1

