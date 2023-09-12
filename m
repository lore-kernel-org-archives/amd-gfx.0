Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C47DEE3F37
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 21:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF5310E083;
	Tue, 12 Sep 2023 21:29:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D269910E083
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 21:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5xIlxQQ7NIpQZr6N5FFTDhDn5rwIeJRyEyiYaQMQnDG5Tfm74yDunx8t6w9MAzIfY8BskYFXQrkILufVeE2Rh/pBFrkn2rmcYqFv3+8RY/TdGNGTvqsXpXA7mM28KuulOugNtaDugyEkCxoNb38hQt6jwiecsWp+dd3Kl3XMD0cqaZDCYHiX3qk5ceVSls6r6+FAd7E9F0d5NcH7SmFqrq/JlbQjYZR+6Rkx57hlV2sR31JQ29zoog4/cW+LIbVb50Ahgw05NRt6YTv1glhOVnmxpWVfK6lRHLhRhpe3VvvnC2JN5VDeLL5ylcvJZ9Z1OxuG2oEQLlXKjy7mYoaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xlg2r606Jc81aQYGSKAtBnUl7VvvwFIKX3SOXsbJn1Q=;
 b=GeLWCoISNRPQI6ZgIVfVxVvT91kkWCP9XBOnrGk4MepjLFYRYzW65yO1zIVSxsB2E7A2roexLf5wp2u156UWKZJdHrETFKorE/Ggmu2362dNxP8A+JVYCPjy8d0MC2tn0hgjAKFqTtE5J3smJRYzwKMnKCzuZY7ESSJFv1EjElEMdRmZT0pqK3Vgg0Pi93tGxLheaab0d29fI50CbmtJrTywqX9M7SFLJmWjdLBZmaS3pKjGdvh8DuHJEvZD2gr32pLXeONxSCu4Lx21SWOhY/igIdPwWjg1PPkrRsrGVteTNsoJSYGLXmIRGh0LUU8TFV/jmY1T2D//HVGizpG/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xlg2r606Jc81aQYGSKAtBnUl7VvvwFIKX3SOXsbJn1Q=;
 b=JdXOvRcyb1F5oG7UlRM6MwkIzZ7XJecUTSqksxGx9Z64FPRuxSQAsVTa7bcXxhAKbEqbN8ktLm9hgx64tyn8i1Gj4f3taN16KsA2aqRuFaSCdfhaYGgfXXr6w0SIF8PBWMQdeU+rSaHubkXXiwHzOkDTzafOkg9DSghv/UMSQCk=
Received: from DM6PR05CA0052.namprd05.prod.outlook.com (2603:10b6:5:335::21)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 21:28:57 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::ba) by DM6PR05CA0052.outlook.office365.com
 (2603:10b6:5:335::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.17 via Frontend
 Transport; Tue, 12 Sep 2023 21:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 21:28:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 16:28:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add VPE IP discovery info to HW IP info query
Date: Tue, 12 Sep 2023 17:28:43 -0400
Message-ID: <20230912212843.2807760-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a635a95-40c3-4994-1271-08dbb3d745a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUHw8Dzavuz4+Pqfv+twtYlHZ09bnRbDVB7vLKHTkgS6Puj0tScFQCsi/3H7N4to8MWOvlAUYaNm6Rc+0ZhOhNPe5GW8GN2pw6QHFSd2nji8u2/21XPAr+6bFY0LO6lbK6wwdw7U/suAQYhJSfgfZuCaHabpwJIq713DOaTSvi40zSOgmuVL/19/5jpI/Qe2MV05oZ1LDZtoQezCwXZYXXNK5zWzKgHTZXAuA7FrDCXmerWHqUs+sJPwrpgEyHtElOPTa/mjEBTnUp3vMICTyYDewqCxRe0HoJjKSFpaxOJ2/7JK/K+4qHnahNn5ahrQr3ji/N/abYGW7iaABiBjFTX6rSuKeK3YZg9sBkx2YPD8fEG6jgDSJmLdi+HnXpMyr3WuWASNZRg7ptNVDyGzrjVLhIJM8UR+Qhv1PkkrN9KmcriHo4uxHpg+ovykAa7V9ldwi9SFnwMcg4cAS7tTU+IkEE0wLtNCk7sp4Kwbf7W+ftxg1kOQHPVSPmNWqEpSiqTO5n3qntVQR5iKhPgLmCF0D31cvPNy135WLiK2834eQkx5XpbkGWRNvflbIi7kgGEKNp8/XQmcV6lnlSKqpAmUaLGQYZjBzuMrdcrQKkXIq7agZTGnPoCo1uFMZuiLt3tYX76YesYXlQYmtAUFNb3XT0EQDJntQqPSxYHmG7n1COtxrW8+U8Js5xSSnFEzYqFJTaR8/VdiXyO0k6yryo1TrUqObLPwgugVT6lJ9w6OHDRK79N7wEUhisegMFBe44W8UPH3msg/OQDqbpidsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(4326008)(5660300002)(8676002)(41300700001)(316002)(70206006)(8936002)(6916009)(70586007)(40460700003)(47076005)(81166007)(36756003)(426003)(478600001)(40480700001)(6666004)(83380400001)(2616005)(336012)(2906002)(1076003)(26005)(4744005)(86362001)(16526019)(356005)(7696005)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 21:28:57.0193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a635a95-40c3-4994-1271-08dbb3d745a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing IP discovery info.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a74ea53899f6..512eb3d8eaf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -514,6 +514,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		case AMD_IP_BLOCK_TYPE_VCE:
 			result->ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
 			break;
+		case AMD_IP_BLOCK_TYPE_VPE:
+			result->ip_discovery_version = adev->ip_versions[VPE_HWIP][0];
+			break;
 		default:
 			result->ip_discovery_version = 0;
 			break;
-- 
2.41.0

