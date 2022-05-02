Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7226C43217
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DA810E277;
	Mon,  2 May 2022 19:08:29 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B3E510F2BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANILoZdr+C3jrEVIbsMj2TmecJD5SB7F3kLFUeGv8xpzSVyn0aGnmCcCNvYndWjL4WaL1zSWGAwuap6ADP1v8ZWm26LelmIUD6GvQpaTXNghobsFp4QiuZnU8L4HV1zXXEK6xjamhfdkVY1c/8AKUSiFf0eirb2m5p0r+z3CRmjPp3uoZZCOIh0CVFvFr+GCBliQQ/O/FyYnaHXMJhKOrnb0mq9x2bXP2VDjC+jy+5eEUr13YBKNJ7rDU4u51suUCAprFIGTOlnwOb2HUGhYfGotX+MwP2b0pkAc8eWVFVavBOxJX6XtwCj5vrbQ3NpKLJOjTJHXOoHarWw3bOeNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHLzIsgEKwr4/Sy7l35Af2tgkvFsC1tfCjDnc9AMB1Y=;
 b=M226DfXkFTkCKJZASqKFV+byZRkcvFEhjCvJxwBac/0wHvjJGf0SwPEZVFXml8FXeDB1sihOlch47zmokYz3FF2V7WJiRgsK6UuS2A8U/kt4FUyHvWTJpbFpO5H7GEIvIi8HN0G+vkyli4JTlK+BiwhGxmpInkrWpmb5rosqYe8aPOHHoTMsC/G7hJALpK8bUx+qVSJxrJcJJ3L0nYV8Y6BPn8PIWzaTJ7ir6gt1ync9KkcXZgOpElW/itVSIynVYpWfzfmGyI+yDgi912Uwq/ZnSMdSknVfzkmWtJ8nD4BRyJ0qrp3o++U+vmmMp8aOELL45ip8QfY8oOarurYbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHLzIsgEKwr4/Sy7l35Af2tgkvFsC1tfCjDnc9AMB1Y=;
 b=ugmC1jir8ruo/pQnkk9hn8l+3jR8RpXW1il6rJBRoJP366MAF/N37pwaqwacRA2pE+/EQ7f/nvsWtaKP3jT7omnBbarIgCRAZ6Pj9rYbDL5h0GzOiirFPK7j3bdbjg1XNFbrJEwYjVS/JeZ5LIl9Nnlr686DWlT2YKGuSzd28OQ=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by BY5PR12MB3954.namprd12.prod.outlook.com (2603:10b6:a03:1af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 2 May
 2022 19:08:24 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::c4) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 19:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amdgpu/vcn: enable vcn4 dpg mode
Date: Mon, 2 May 2022 15:08:02 -0400
Message-ID: <20220502190804.784271-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190804.784271-1-alexander.deucher@amd.com>
References: <20220502190804.784271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 217a736f-752d-4013-73cc-08da2c6f2164
X-MS-TrafficTypeDiagnostic: BY5PR12MB3954:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39548FA87C8D3D0E71702629F7C19@BY5PR12MB3954.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62L6JK7qtGl3gCIDkmAB9/2S/wJUsMOQN06EKnMBAxcXSSPk2g2nScFeHtIw/S8GW9ZfVlmHCo0vcHYZoF8886CAUQyT4GbYrwzsfDDioWNVCPRwfpF/bvGR57n447rkE73QgeXSbVFduME8u/Xy+CWA36lw2bUW+fiKq57X8SHoqXS9D+IbxgsTl8pPEh6QqOGN2eoLdCG4YV9+9nRQlknA3hhwIPeR6fsd8MNtOTY2kMxwDPxLPxncDbhG3kzzY9N9mMiJqT2j74/cO7nrIYsyq7ipN0e3j/dFd31no/TCE7CUXk3hziBUID+KZ7rOFoJXhOYt94ShiQAGjGQGdOZY1yFPnfZ1BKg0MLxJVLpVlsrDvTYy2Tdp3UtXYUH4WqyIGc4W11oTlPfCdjQ2l+36wWWGzKjZkfixxOIhB5TwEKLsd5CDbMiNFkc6ucNbwkWDBADW4zASWwPwEh11QF/KKTIQsA175J6CwBOxSXmRiteHT/rnV/zdzZoucMlHz/BjYzFwMYEWxCXKulCAWOJdOD7I+MFVQxzNJhmyQuPrRoAz6PCmTTUUeAdFegfrcazV9HmjlBcx6rUbLhNYQIl9DhdXgCq58EusJETzjZ2vcTkVxffjx4VMT6HiiKLzG8VUhg0MzObs3ixgVxJ95rHNWWNGoj6FNi7gmno+jZJ7VCe8h3d61wrsgOnP8P1PChucSydC7wwzbRKN139w6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(47076005)(86362001)(4326008)(1076003)(8676002)(426003)(70586007)(70206006)(186003)(336012)(16526019)(4744005)(2906002)(81166007)(5660300002)(356005)(40460700003)(36860700001)(8936002)(54906003)(36756003)(6916009)(82310400005)(26005)(508600001)(6666004)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:23.7851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 217a736f-752d-4013-73cc-08da2c6f2164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3954
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

Enable vcn4 dpg mode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 66309992f9c5..6b06f8f61e2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -486,6 +486,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_ATHUB |
 			AMD_PG_SUPPORT_MMHUB;
-- 
2.35.1

