Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE2FC7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9E010E5DB;
	Thu, 24 Aug 2023 21:53:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0F810E5CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOdsOU8ZaMOCwaLqpNqis05vk6ISYWam9ihi9xfd+UE9X2+KLHeDQmwkTHPF+h13itk+XvAp9/u3uFWyojifRq+c4zcJrCfwmNi/HVeINiwbkTP2MGGUM9rDiIYrAgJOWViYTHJJdJOhlD3RI21+D6cMr46vfcecHr7shx5wDIspyB+SIZqfCY6PMbHlESsDckg64aqrzF3QIQvMhXVXUS8u6nc+WCILW1qDZTyl/LOT0Ox94Ra5vbO059i90s0w8cN3ORdrrDgA9SYAyxVkS5zEUhRbGQzCiSVoobEI5kTXdRscnb4ojXL/7Lcdju2RnZlRJe2nlOlj+6aM1dk1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Akk+ZoQCLAGL28RUPgec2kSyg+LDZUqRbPtvu2BX7Z8=;
 b=FtCgdT0QqNsr3D9fzw2pVNOBsCX/TP2709cbLhhr7dH1nAVM2gKdrmRdWrH6cIaA60+916nRErE2ltvOCxQ8Bz2x/n4azD+YZwwyqOsSaRt2fuVwV6Ja1yZX1UmpjFkO6u1f5tBpBrhOhr7oC8hCMzCOZPKZJ6rXqBQiT9oMdoTdM1Yj/6NnL7YspzIPmZArEcUWSqco3oRjVVcOE14ssAHibaCyWcIOekerx0LhCJXZMeHd2EDWvzfJqDKnSPmtXUqRS6woX1n+Z03BlA1kY0lxaDw8uEsZk5yfwzhUjRTTF9bbKyZjjIcemngJv6dXFbwYRIiznFIbgjrjxUf9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akk+ZoQCLAGL28RUPgec2kSyg+LDZUqRbPtvu2BX7Z8=;
 b=XXcy1atM/Wuih2ajjELcsqqVQHD/C7Yn4dkIILC3t2HX9Ie3QisXfLPBK4k0++iGy8LGwiRHI+S8BxECoJMXjNjDwLiT/i2GJJ9ewJd2EDPKO/WkKb8EP6GSbICf9TCYTmIKckQJbPFD0eR65J8XFzjOEgkqjinaAIU3o3pBysA=
Received: from CYXPR02CA0033.namprd02.prod.outlook.com (2603:10b6:930:cc::8)
 by BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:53:19 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::6) by CYXPR02CA0033.outlook.office365.com
 (2603:10b6:930:cc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:53:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:53:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amdgpu: enable PG flags for VCN
Date: Thu, 24 Aug 2023 17:53:01 -0400
Message-ID: <20230824215301.2739707-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215301.2739707-1-alexander.deucher@amd.com>
References: <20230824215301.2739707-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|BL0PR12MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 3730212e-f57d-487e-4757-08dba4ec872a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/hlKkplQFgfuRFE2F9PxGX3HjSKIniSKIfnbG/+O0hw9ZSR7qectFu2qPaVxEebdSEZr0hjueoN/YvaUH+LHaovKqJwhTcq+I04IRRVwXt6FpJ0bFvSDG9dAHRTfe4NY6H2vYf+GblvgpeEDDMKRb42trpNmgP/h9mbVHVGYUe+1G4GjAc21Nh0OQVGCjDlf759hk7Gw8HGHtjcEqltozE6bxKmcHnmuRHn6VLV4IIyFaGVehVIEs1RSx3H4Q65hbC5klbmenSvxoJWs5M0/cIuD5zHSM5CwE5HpiB6y+Ch6K5nZPMzQzfZ4B+5a77aU4zXdQc0YIKB9glHATIw3oFZRNt4LZB+yOkksN1PyY7IeLHINfTllGtEP5pOLnNuVo6WApTPFWNkKpB1AcZhv2ERb95tA5uUbzVUajI3/AUEiVUkwnlMLVyUdFPgoEzmPch7nDb4zTaJrM+f6qPx1Zdnbr7sE/eR+0CgsTLRFsNr5P77ODqOY2akUdgiU0PKJtgVVoF/Jdg8EM8gz88UGrasoTkUZ1PPg34Sfq1WDOUUAfbZMXuU5S2bzwxoeqkR3PrJ4Sivac/+EAvMnIqov+Bgq0mlfGGc9wWS2wOF0kVLAtI5pZDlmo9CGckTs9HWLK/58gxqWjCOKfJ8P2fDn9pcmdiks2+3eghOMAlUCbM5NzfhfZIeP2LNRYxAd408WxMWBy1X9nFB/hDjG7icQA8epikbqFV1P8hWZ4dI34O0mtYX3U6+01a1gu+5E1gAZtgVt4fJQr8Y8pjDA1UjyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(4744005)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:53:18.8894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3730212e-f57d-487e-4757-08dba4ec872a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Enable PG flags for VCN and Jpeg on IP 11_5_0

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 6416e9575f36..ef297b41623b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -695,6 +695,8 @@ static int soc21_common_early_init(void *handle)
 		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
-- 
2.41.0

