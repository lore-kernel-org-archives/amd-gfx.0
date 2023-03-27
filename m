Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05031C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B214310E73E;
	Mon, 27 Mar 2023 19:46:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D91810E72E
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUdrwMt587fjaWGrTpjxy2lucU+fpsIF8JfyDpS5weG0Lsv4L/oVr9A8UIEQA7vueCMS8n+GS9n/fMcjqt/TIG4zCZ1PmfHpgn+y4Xn810lgXbRGRSW0HCxrG9fwUtPKrjBEc1Bhzp9HsYqARSxHVmC6e/X8ursjw+ICOBvx0ZnARFybywzFHAz69L5pWDuzUkM3AQIp+trRa4wNsOHIw4MhhBtx7Lud6+UoxkWyn+fzkLoJtXVoRYERmINRrGOomATcOo3eLTvPh4aksGfR+BG1lYvrIlmSTLC2wn6Amdvw+2x4D2xTOYFsLSP2/fJnO6Btl0DgG4ZR1Yrz4t9/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/22MDRTGtOLNvIiS98kpEdDtRng9eVEU7kdQqa/r3U=;
 b=MQenA6I3uABFPllDYaH1bgGZOXUxHghQqfyp1ucreaZLCLF2Zt4D0NgYJ7JtYDLQgdwCDbTbib+gGogtYh74PhcFXqz+NVosvDESAeSVaqXTtmg0TJ7+qAfUWQXApo/Cr0ZlroyLEIzSg3g+rLgYjoIgtYiyvqYgzG7ACN7XCZ3TYZGlYsALzg61KYdJokWFylAkRqa0q/Y8aMrXQof8lWkGXivVf/DVctsUqrDCne0KlRCCi6YCW3emf5sqF0i0YGbKTwtVhoWcsX4X9OojHQqow/xDLUhgyPO/Ia1QJyWAjIxfFw70Y936STyAZNnOIJikVxBuQeZ1rlnT53R4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/22MDRTGtOLNvIiS98kpEdDtRng9eVEU7kdQqa/r3U=;
 b=q0P3wEgGLNmwY0eXe/UKSBmMgt672CEYv2y/9vqYrjKnzB3/H1Fhf75Lm0VKkNrTHeusycW/tQCZMvv947a2YZJhG8HvHQIXOkzJ3LbyRbMnkBlKUoPy8hEQJPwv/H3yxp1pPAcbZrV0V6PMaTu/FHBO2UWmCvGQXLmno80CAOw=
Received: from DM5PR07CA0073.namprd07.prod.outlook.com (2603:10b6:4:ad::38) by
 DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Mon, 27 Mar 2023 19:46:40 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::6a) by DM5PR07CA0073.outlook.office365.com
 (2603:10b6:4:ad::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amdgpu/jpeg: enable jpeg cg for VCN4_0_3
Date: Mon, 27 Mar 2023 15:46:16 -0400
Message-ID: <20230327194622.8109-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f004d7-fb8c-4c2a-c637-08db2efbfc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilkX3AMoDlbeWJ6aTN/4FdbXcIqofMK2wHMszbR2i4ocFgxYu/uduWoqzJuosAaHzUzkgy+T8HGMrzzYRN0mQIo1lV3dRuIdGKH6AS/xwx4HiLBTO73eqBm/7pq8T7xvUx63neZSQEAkn/FcF/nxKGdp0VXpOI23lU/ECaH65hddmjLNgIkBohPXSCI8BPlpxyqfH+5CvP/6jYUag8but6LEDdk5OYDpLEnCRVGiL0qMljfy7qB5hNNyn+Kgc/ADd0GVBiwpq+rkupgeEXhTfisTXBWW0ETSduKnUKYuIspt/YM1n83C0WKCudqaSvC5Dw6cyZPnYH7FsMfex92dUENrK2X3AQcRcC9P2drZfu3//55IHrQYlxKsuSGlh+Cy7XvQnVLTzQWb1jGUyV2gR2oPQTtMCKX+h3On7AjE68P5iACw8eAXGL3moso1rOgy0lYLt43u6zKdZc1i5v+xeu0j162/8j8aVape4TQTW+BH7MZl/rWJTFdAgj6TZfItsYMWWmU1cH6653J9sXifbLrdzXnsIndfqUxsiIcly+yhzH2bVSg1qqZll7QoRvsXAHIyai0wUnYKsD9SAoEh7StSYTeHmMICXkCJlGsaTJmfybhQ/Wk7EY5P+bO4V7Af5zhMYlQbRjJtsc1+VQJ28ssmgiNvg3ScaC0vqEIOMz/kuk2A9ushr4apNmthX+pRhT45xgaG2FHuXbA11XO9mGih8G3V9sYNRecZjm2WK/0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(82310400005)(426003)(336012)(86362001)(81166007)(26005)(1076003)(186003)(2616005)(83380400001)(4744005)(16526019)(356005)(8936002)(82740400003)(5660300002)(6666004)(41300700001)(36860700001)(6916009)(40480700001)(70586007)(7696005)(4326008)(54906003)(2906002)(47076005)(70206006)(316002)(8676002)(40460700003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:40.4672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f004d7-fb8c-4c2a-c637-08db2efbfc2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable jpeg cg for VCN4_0_3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index dc43aa5b6f40..b120c2624f1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1103,7 +1103,8 @@ static int soc15_common_early_init(void *handle)
 		break;
 	case IP_VERSION(9, 4, 3):
 		adev->asic_funcs = &vega20_asic_funcs;
-		adev->cg_flags = 0;
+		adev->cg_flags =
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = 0;
 		break;
 	default:
-- 
2.39.2

