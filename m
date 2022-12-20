Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32F3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 10:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC4110E37B;
	Tue, 20 Dec 2022 10:33:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA7110E37B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 10:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIQE/A7pauMY+tZKkH6/+fuFWN91H2vLrTLkfE/IJVLB5LW2lDX76cpDrWGcllaAVjsePHecBgnfTwS/+gNyMjxIXfPC7+Neo30zgE7jfyHtjMbvKIxi1dvBGObwEpc6aZninp9nFugNVjFvSTCXTrKwR+Ktyz7SU6r3R/gOkL2PGWQ62Xr3jM0JKAluVclSbZ71E3fp1CaiwaY+F9oObbqCxh9qYuWbQXYNGUUrZ0TXGrlNkh4u7xK0rxUkLi7gGax46Vut+y4JRzNCj62eFcyKqMrlR/pR8mIkR/NTm9/FNtfMYwqCLl68dzHIpMp5xLnDxR+GAKLn3p/kKPotOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2kJjrnXgdQkrtZ4C1GjeX+R6acDBWqrAZsQowe2Hu0=;
 b=OrKybQCXR+QdPqJ2Vbe5pR3WzSAiskrJ2Su8Hsg8bpLe9F43OP+9sJEh/5POq09HA5XS9FMOpwAzzJiwsU5qTAGYnQca/x8c1nagyMhBGEq+ri3tbOWbctgaFXUuvVCqsOprBBR/lgpWcthMP6XE0KKsq2pER8+u732Iq1nwEQuIke9Or4kb7h3cyZDTEfjGhXw4NbyDbirTj5ubST9TKlvnUBkl7uykVIfMcV0SMweIsuPXQXv6g5Xp9xj7i24kdNaxXOP/ohNnQCWPLOPXT43fvyF2d19zs7lylE4tY9CALyg6m3RFH1cJ3cZRfdRIgdSEo2uP1cPBVdCGyCVYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2kJjrnXgdQkrtZ4C1GjeX+R6acDBWqrAZsQowe2Hu0=;
 b=z2BL+3sMi6jj9V3hZh1Wtr0siB1T1ZSMhwgFUKqlr4xTpep4jGq7moUO9h1+yohS8wnV6aGzsO3HuLW5LaJt56n8jwx0LyG0VNfevWJuEyFOE9xu+1s2HxvVqTcSvz3aXQZtF2vGEqN2gNMdTS2oqr1taBcAFDxQcyfeUUYDs0k=
Received: from BN9PR03CA0802.namprd03.prod.outlook.com (2603:10b6:408:13f::27)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 10:33:24 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::15) by BN9PR03CA0802.outlook.office365.com
 (2603:10b6:408:13f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 10:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 10:33:23 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 04:33:21 -0600
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <leo.liu@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <veerabadhran.gopalakrishnan@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable VCN DPG for GC IP v11.0.4
Date: Tue, 20 Dec 2022 16:02:21 +0530
Message-ID: <20221220103221.1775621-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: d06a5439-ca24-41b4-5ef2-08dae2759f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saLUnAkGFqQTNJjejWfIW9lbo8s2/nfhF73HkEfPZNwLEsf10CKdOU7H5Gh2xJTpX3aw974wINXpAbYxyx8B6ugkneWzWKWb+9ggwPmgDKfilOYhSQzyO4VQAZmG6iGbJUr0zqi7Ott73aRji5ycPvCjXWszLLmOgb+5FLD8seip18KuphVvGliMbFOmyQ4qkVT39X8zap61SCmf7Xyow1P8BsHWY528XFGKCNbtQH5J/5UPHg9EaBtoZG1YQ3n0h1WziILAO5lbiordCFRNGm7fjKUcGOY9pbhqQYEeHmbEGa74GRbbSbonnlR6poL8pcZikes/3Vw8jjACOiu+tutydN46ZFkYhMxH+7BGLOJHiiymm8Q42fEM0bQn3IDmiy1NxeSeN317+fjqDUKjJqYr5UuSy6J84eC6EVtYvVz2ne3XMPB5QrblFqa3BqoRvfHCA71E5iMVg7uVW1TXSm9NsqKleNxiqRRas1Nhe+zHq8MMZ/k2eqbTSvvvBbKh5EFuzb7gp+ljPZVOw+9AmyBtk5Q3gv5Hmj4OXbTO1Cg6A7csxpS2yNy1/f4zAfl1jFHpkcjzlwpopZRVdatx7mhw7O3Wd4RNi2M7cjL+HxbEhJAMIbMSjG7Y5Qb7IaqpcKA1OP4YXmN9nTmdgALijMDEBP/pcVbxVB2a8rP1+BIP+NBsk/fFmf7pX6B/kbfKzKgi2X/92RYxLGXEKoyI6cyBhI7d/e5tWImoSHRmFQE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(86362001)(82740400003)(2616005)(26005)(2906002)(186003)(336012)(40460700003)(16526019)(81166007)(40480700001)(110136005)(7696005)(36756003)(478600001)(8936002)(6636002)(44832011)(316002)(356005)(8676002)(70206006)(41300700001)(82310400005)(1076003)(426003)(47076005)(4744005)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 10:33:23.7667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06a5439-ca24-41b4-5ef2-08dae2759f4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable VCN Dynamic Power Gating control for GC IP v11.0.4.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 7d5fdf450d0c..5562670b7b52 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -666,6 +666,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x1;
-- 
2.25.1

