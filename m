Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC96C04A94
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 02:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B9F10E2B4;
	Wed, 16 Aug 2023 02:26:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C04C10E2B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 02:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBS0VSoidp39wpP0978M6wWw6O4P1kpwvIUsT3pwgqPWuti5r2gQL8hrLuhACSSTS7sofCLVB9WeD4RFNScW61m9DCzXQ3P+Fjt4KLAkzFV54wj9JXMYfsFgfZQqzoQe5Vgc5aTadmQdoRqX9zTKNbuy+NEyu1YEDHpdwMDGR96ao2XoNA+0aXV4Nw6ouAIOtD9d8GqgJRxgXlBGrly0/89zGIx1JfKb0rcgoiQalTAPFDFFsz+vXCl14y470e4i/JRZUUwSJXpyWAO9RHCmHl3lJLvp3UishkAeJbNnze6W+/yFfCQCe/pL+4Si+ysC+saA9cMF68x3YJQQCjfzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX37g7mYol+ssBC+scONaD+dtIZHwRPZM4P06KxxNds=;
 b=YB5CBGdiFvP8NmleeSpj0KTg0FsRMp1BdRTwSIR5bje8t0dT2j+pmUbtBwlAhN429+wkwyygoUq345Hwx3mv4x29zLpoqZm7/zoGsgCp8AHqA4+oemNgo78N/5IXAo69ifFFlDRSf6cdINQC7kUETI2gP/6m4zDYJH1ytMXiV8fCtoaU9B4rOjjjtDp2jhjRvpKHSR7SBefl2gRbBR7y7/fBOOC/yIiuw5oGqvZzNESFk599Q41aI4p7N9odzwd/D/7/qivLkrFjfKtsXHXarzufEa8GWRJgVYWvvLMtFsxYk4VlCwm9Ntj2gHV3Ng2+kjLEWrEdYfOM0Fgmf3qe/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX37g7mYol+ssBC+scONaD+dtIZHwRPZM4P06KxxNds=;
 b=ilJETbr/kBBiPQntUOSZ5Vz50i6kowBr5Jx4praXoodg+Q9Vz7NTPFqicdWcRZH8hvrbfcuSG53F+p9341BjBiscgDNFd4+yhfIphRBGWFb5+9Y8FYIgmG/L14+SwIm8xwL4lehFxp6/L6WdFRO83z026Xiu/3a+pYxQy5tj8qM=
Received: from BYAPR07CA0089.namprd07.prod.outlook.com (2603:10b6:a03:12b::30)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 02:26:34 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::ab) by BYAPR07CA0089.outlook.office365.com
 (2603:10b6:a03:12b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 02:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 02:26:33 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 21:26:30 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable ras for mp0 v13_0_6 sriov
Date: Wed, 16 Aug 2023 10:25:44 +0800
Message-ID: <20230816022544.1371378-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 258b16aa-fef1-4954-9044-08db9e003561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2l1Tyc5RjQpN8+XW2t3aUI/pTZIuY3CVb7hm4lOgclEhqSkeiJE3FxshWlQ5rUXhKI5vnN8RpSaUVf5ZydMqQ17NKrNphrRkN0Pj9d+9zJVnqaLahEy65S6pg86+txoJm71UrzUafBEc5CxkZivy8nMJuQ+ikSO8uT0DStF1gHiiwIzJDratFphQ3s0KDEY1dsdul2nbBQt9DscsDFKEe0vE01PWtiFL0pYXu6zrzdtUCQ0o3yWoRKypdu2I9Y8fqTzMHa27jlzUQjdtjIRTy+HRCtiXNjsIMMu1u3WPBrWBMXcDXkXZKxD2kO57J+OQN+9nVwc+xJAmuehF1pvvnMgyMqc9suUsEvpZ4fSL6NOECVnZCB82v1qdwa/6KwgMfjFwuZ8kJgoGRwNwjS7TyVE5F1EmrCjqxvfsYU1QUMS3zLqU5H9cCB1wpT9CSWUAZ5EaCDogxRGAhME+BF8nKSbyssZKejxG9Dm7ca7+WzwFz4LxkQNnuteuodGLRPYOt5sDexmvdzAJz2tOBbwHhLpuFLBN2+I6JNUy4coopeWqzyoTyIMxca110QQrLSkjH28lEQq/3ExmTNpYZNO6SDB+oLj9S0mp1kvGjznAPAKbgHcC5D+V0/I8hayeG0b3CYD7uqVu3RaObF4xxiZdRgxkRAZLR7KYHBcUb6gDbk7ovoTAA1dvF1IoyOH8jEUodDQTDg4Pj1tnuknoxAuaEK0uWr0svhTuaMu8br0ARz3IB9ZGAlQ2kj2dXK6RSflX9FnThFQizAhTVDIVuN0vXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(86362001)(2616005)(36756003)(70586007)(356005)(5660300002)(47076005)(70206006)(40460700003)(316002)(41300700001)(6916009)(4744005)(36860700001)(26005)(81166007)(82740400003)(40480700001)(6666004)(1076003)(426003)(16526019)(336012)(54906003)(7696005)(4326008)(2906002)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 02:26:33.4269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 258b16aa-fef1-4954-9044-08db9e003561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable ras for mp0 v13_0_6 sriov

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7689395e44fd..378478cf9c21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2399,6 +2399,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev)) {
 		switch (adev->ip_versions[MP0_HWIP][0]) {
 		case IP_VERSION(13, 0, 2):
+		case IP_VERSION(13, 0, 6):
 			return true;
 		default:
 			return false;
-- 
2.34.1

