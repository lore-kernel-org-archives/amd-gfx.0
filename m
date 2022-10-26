Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D55C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 20:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5967C10E084;
	Wed, 26 Oct 2022 20:11:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6628810E084
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 20:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAInQltApP0pA4Iq5X4sbqAiV8YcaMHKin49T8cjUxh8g295GBgJ5vICJXgLT5/V+6BEoyn7JnzY5srLgyiONau9OhIO46xsU+c1qTmV9GBJkkb8v48PAJ+SJOkEFb/sfKDj9/kbCcyAB+/k3s+Q/D04nLWEOjPb75y3iUzOQDJARoxgUw8cV4ILvlWXVSEnqcyoLJBbbLL3n7E+D6WHBey46w54bTVeBVcS/mRW9IlIemvlsa88DlinRiyARgNDjchruoPBgjl+wfQt9SBcNEDUgBwxdE+rgJX8KxKYsW8frKm5G8SvPDvMS+vBvdl2VngxoAfO1t2kfQ4o4FnNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIjHLuFexhgUpsbipAXlucLHhEZPR2z3qnjd+zUXAYU=;
 b=W/ZndNb1Wuo+MwL5M95HSNVJzUoVD4sarr37XFIjbSjx6IqgdY9SoxchB0noIJYHe4dvHNCAGcjdkWzWE4cIWz3rpq7zHJ/Y3JolwFrWyXpLm0gzZ/vlyux7Yu7HNIKF4LKFlh1mdFGBhzbqaH/GBJ08bUUN6X20FU13KcIjV3vNLibWZuIJBetW+Lh3x/xA6DWnu/2ZwGujm1uWpYcQANJlyDgHJBjSZqt3kLf6mJakqvs0PBlqnfMxuiOPC1GZeS9rjZ/k8Pi6TeVtsS+WHh0Mh+jti8QpwfVPGri+uw19gyYLuzAb11791pvt1zrHQUwyoFiSK4gZOfmfY8GubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIjHLuFexhgUpsbipAXlucLHhEZPR2z3qnjd+zUXAYU=;
 b=aAewJcjFj9WEqetgtVgi+JpQkxSWUA+rUXbLw5ObGhZz6M4N47CtLhCXrkCfTRMTGyhMG4LZB9pB15x+e/jpvr77pm2KNhzgmxBZ/zHFzmsSBsXrrJNkr1WZGwGWIC/O9S7Qb+px3kWqAyZ3NPrGQxPtSE2nakBblY1E1KzAJyw=
Received: from BN8PR16CA0021.namprd16.prod.outlook.com (2603:10b6:408:4c::34)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 20:10:58 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::56) by BN8PR16CA0021.outlook.office365.com
 (2603:10b6:408:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Wed, 26 Oct 2022 20:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 20:10:58 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 15:10:57 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable GFXOFF during compute for GFX11
Date: Wed, 26 Oct 2022 16:10:42 -0400
Message-ID: <20221026201042.989337-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 295cada9-e55f-4a10-f83b-08dab78e325b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDUKrfj/FAiYxWu0wW+y6wDKIGwwHv7GVosT1cLIRW42UzeNRNY8vHnFYfPWiFXEkS8w5xgP+hSF6rJ3Jg329/xJQCQNZaORqDJnzdF6sX/qRaPVpySXE/KkK8z8FR++xpqiGwSelgZUhQ88dYiUJv1/qe+trbFKYzFJsWcE9gC+VpS7tSmiiI03SlG7AKyvhdgD+ARTcISm1x6m69XrkKxn7BKUGw6Qjv5+Tnpd7zR9l4Gfi3MUk2qR1Q/5PdySIDzQ05UJvB7iceI80lwb5raldHpwJyVpx+9RcGIE33xqFkJYlYXFFhJxF8NBHdw0BBS4XUWW19upXZUzICygAogLY5lRFBMp3uOrBPINkmpUTgAxm2KY9rphr/pJwhgRCCU8G1cJptUzty2GkmvX6jYp3u4qanQzJgkzyb7mGSTheIUUkheH1tJ8ZK7w6vA94WGbyd9z5ZTxxyXkHD36x2NSHHT7FBwVAG2Nz+ey+NNWuZMvjbU1UfoqkCFNTVmj1p/qbLxO9jm8Zntk5tCiTlJP37y74zZuwxd5TH/EwiWa04Jo5t/rqc72n1nAMVrMoMcNKCVgZOm0/OhgykZKStyly8FnwdTthGqDKjggZsoq7Rbv2+582LWtTcUkvYzqESDrlC5y7FGvDJ/8l55nGiHfo4xT4+oXK+jtH9N2PLtJ3J21UcJq7M8mYXoE8rGJjNPmsZkl7e1T895RRYGsqGzSmz+rl18Jo4uDnQs5a+hVzIgTquNqqY8+9r1XNRnUsFr/adlhfxGJzS5EF2uoAEpb6AsEjBWK/6YWWpHqv53ovBKztFZTH1cgqHLRdZlv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(40480700001)(36756003)(8936002)(356005)(5660300002)(478600001)(316002)(6666004)(4326008)(86362001)(2906002)(82740400003)(70586007)(7696005)(26005)(2616005)(186003)(40460700003)(1076003)(81166007)(336012)(16526019)(8676002)(41300700001)(36860700001)(70206006)(6916009)(54906003)(83380400001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 20:10:58.4004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295cada9-e55f-4a10-f83b-08dab78e325b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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
Cc: Harish.Kasiviswanathan@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Temporary workaround to fix issues observed in some compute applications
when GFXOFF is enabled on GFX11.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 37db39ba8718..0d764c15f6bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -706,6 +706,13 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
+	/* Temporary workaround to fix issues observed in some
+	 * compute applications when GFXOFF is enabled on GFX11.
+	 */
+	if (IP_VERSION_MAJ(adev->ip_versions[GC_HWIP][0]) == 11) {
+		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
+		amdgpu_gfx_off_ctrl(adev, idle);
+	}
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
 					!idle);
-- 
2.25.1

