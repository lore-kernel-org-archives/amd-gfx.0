Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49482C27C40
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA51F10E5CC;
	Thu, 24 Aug 2023 21:53:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2895910E5C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE1dBAn9L4ETrSEhaHlo5TM0aVUXU/yqyGbiK9RnHzhyMyZrS1el8kRwGNEgnkV/NvrRJUZu+Wte9+yHGfRh36S2skNO/mPeyStRxrDxZ7vbkh6xeYIzeo0qtCUL5W6SYGE3G1OeT4CHGQlGFXZqinj9lD2u8LMJKOtVu+PM2Ll4L05osydZO3lC/QFM9oBudVBxoao0B6vLWhv9P9Iy05lzQ3kyruMoj99eTcuZa/WYVRIvIelZN0QBqGoB+g5Lum8bAWTw7N65Vuqa3M57CzMQt8I71FFaU8+D8riN9nGaDUvXbBWdo5kHVzIz74fGSLMAyH/Cy5z8ZZR2U4cO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqHv+XNCM6qwRbQCnUNMeu8jpkF0PehTTQvqKmftN4o=;
 b=IGcb3lms7hE9VDaikJW0WZAFo/9XpVocyaPvg6rqUVH5swToTcW3+m2AkYen0eykmR6yNXCXL7K6a241pGjMnu/TvuGaoSEVDWdjJ3tUpIzmUfQsoOiIWTtNkZURCJVv0b8M/FEWalpwL6I+VwyniuxR6NEDCke3ATt/w3Hj+Pdi0rwUEbwzeqVv28+xIFGh7eP5v5BPvaCK5ZhDzRg/YLaoMxM1YXPYz3LtwDFPG3BHJ2ImBr6fFGXaXhT9H0LcnhskT5uBseb6IjfkOpdWrKAmoz8n3na5cV45gmj9A8/PZFEK6Q1Z9yQyx5nq4gnXFBqr11+xdCNqQ6Y2baT3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqHv+XNCM6qwRbQCnUNMeu8jpkF0PehTTQvqKmftN4o=;
 b=xcJLl/kQmZEc+CY3HjwJtWkwr32QooTGLX7IkFcVHtby8ovXVw/vHuLx2lIkZpW9gBiogpmM1VYS0IDRCxo/CZUY0pts/iJvoWOeqXbGlZDlfCy9MQw+v6RceZOwUvWkMBUspg161OGe2AFDvnE/K1vVEmeSHhWaQINuwZD2Dbk=
Received: from CYXPR02CA0027.namprd02.prod.outlook.com (2603:10b6:930:cc::17)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:53:17 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::34) by CYXPR02CA0027.outlook.office365.com
 (2603:10b6:930:cc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:53:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:53:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/9] drm/amdgpu/soc21: Add video cap query support for
 VCN_4_0_5
Date: Thu, 24 Aug 2023 17:52:58 -0400
Message-ID: <20230824215301.2739707-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7b2e69-4a04-4779-38e3-08dba4ec865d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWLhlBElLa4oqZh8C0uyDr+Hfchtcrr17ULKiwcaia+PhZQgklWCKWg1U1ncEBsDXHphBKph8MAgR08hcbGiw23B5lt6Q6ey6ln6YREVNHwpGEUIvxJ7JszEJiVaA7pzQhdaDlxMKzDyX4ezXbI/1L7e4jQRECpN9efhmxjp2hxQ6WGJwDDyhHAOIQnOKIaojUshTBjWYLJ/am6ijUen55YI1igPg/L/qoQubXUOqnJqkRJOasPyiXe/ryDjrcOrD+gYjbzh86FY0670fOFgQdHEp2jHK506ayaz6YYoMtU59aKGe7eOT23apo6JwXsmTMmJfyuQNOs4pMHHXrWmoNKxJO4xdR6zne0HXA6nwB2dEE8xDt2rg0vIieBgtMS9ggyicwDyR+yLoEHD89GLsuBh3iOt4E9aOI6CvstO1p0xPBLJ/cm/c85Qz0Mc8J9bXEKG4PX+gqub10C9BNFrYqujo84PXvZDY8ZhHR3b5D00epPaY8abAeOAsZLhdG1Yp9Zb7dqYgibhsttQsGHjLR+9/+8t6t09TqeJbXP7xHxZ1u6YgguUByP1Rq4/e8Uw5UgIOlmMScogXmP7WHllrLFnN7N+oCJI+tYPWVl7Vg2BAXHQjDGs/IRSLPqC1MEDY+4O1vQy2SMKDp7Cc799rvFIWW8OweBaTNlV6OtHgjv1sE8ZlqcXXjvDAWaasPVEu5slkc1t63M91fXspNV24R9ku5VYVgjFtJH0UN2udQdJ6eGi2qQ46SrRVyINLBUQEdkqt4NNdIdQ0b4w5nXRGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(81166007)(478600001)(16526019)(40480700001)(26005)(6666004)(82740400003)(41300700001)(7696005)(86362001)(2906002)(356005)(4744005)(4326008)(8676002)(8936002)(2616005)(40460700003)(5660300002)(47076005)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:53:17.5456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7b2e69-4a04-4779-38e3-08dba4ec865d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Added the video capability query support for VCN version 4_0_5

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index bb281ee3bd15..6416e9575f36 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -157,6 +157,7 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	case IP_VERSION(4, 0, 0):
 	case IP_VERSION(4, 0, 2):
 	case IP_VERSION(4, 0, 4):
+	case IP_VERSION(4, 0, 5):
 		if (amdgpu_sriov_vf(adev)) {
 			if ((adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) ||
 			!amdgpu_sriov_is_av1_support(adev)) {
-- 
2.41.0

