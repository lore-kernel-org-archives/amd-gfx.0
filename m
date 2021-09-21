Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AC9C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4729560527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4729560527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBE76EAC7;
	Tue, 21 Sep 2021 18:08:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA13A6EA90
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgRb0wnt2zJDLjQmhTeVGcMyzFlQfHrsATY135LHqS9rxjYE43ExKuhUQjIBpRqXuX/6J7EDFds1DmFNjkFLCrtbwrPqpbrztjJflJvoJ3cwaMLvPgnif7WszlfXZ2cb/j1X1ZSpTn/tV0uDCvRNQO8kySz+BNn73SMpooUWF4roQzee98dXFrlyZb5bazPLmCSKAdlg1v3B2JHbjfVb5D9jJgaad4K7znKBJH1G/YK5yLhOzVueQJDd+yYXtChHU3uuwogZJuWvKg+d0gi+l+WtSOts5jowp2K9v1Kc6cHH6rAlamYnO2pK9Kpg3+mf5VZcw6CSIlbQqadC0ksQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hyzUfN9wZWUIWHpOx2j3zNctjhTTUZr4zLLgOpbe9eI=;
 b=PoCmTtQYWQxuD6eg9gRPCLFQZDynjQUxHkAD+IdugFMtGcolXqTEPZ8ze+rOALujEnQSiabr/lRWaajuBL/ssFcxkyJbZlMcC1jh7ySjo1hAQlpqhUv+MEPmtn2tV1U0VGLRO3A0xNVda+Wni+5HZw/VA4pSnb/os3Bd7Yv/aYuJp9Dgm6+EUksQk/LOO1eGEuLZGTaTORQufgypWEsBDYLo8d4BxAhFjRPN4JwzB95Au5mPAJRaDnR/0f7f2dULJsoraaKJ+nR894x2HxcLmUERoGw5OMQAJvqhVWWvxIdoodZt2/16FjOadwCuoC1U5Seu/Zh+oOjpqWoWv+zSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyzUfN9wZWUIWHpOx2j3zNctjhTTUZr4zLLgOpbe9eI=;
 b=OBD8J6NrOSOvrmXNKmqiLP7uQk9PCPbknYScBiyQz9JzYe5C1Lwb7ufN+HBdSDJlAsMCJzdrqmxn9nBjhca1NCW+2ewOERGDFYvAE/DzA40XrlvKz3zFA2bgswrsWxu+TVRZ5e2eSnKPX3zRAgSAxls6XPMiABgw8LLBYR85V2U=
Received: from DM3PR14CA0137.namprd14.prod.outlook.com (2603:10b6:0:53::21) by
 BN6PR12MB1476.namprd12.prod.outlook.com (2603:10b6:405:11::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.17; Tue, 21 Sep 2021 18:08:07 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::21) by DM3PR14CA0137.outlook.office365.com
 (2603:10b6:0:53::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Guchun Chen <guchun.chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 53/66] drm/amdgpu: add HWID of SDMA instance 2 and 3
Date: Tue, 21 Sep 2021 14:07:12 -0400
Message-ID: <20210921180725.1985552-54-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff2acb07-ccee-4ae7-96aa-08d97d2ac363
X-MS-TrafficTypeDiagnostic: BN6PR12MB1476:
X-Microsoft-Antispam-PRVS: <BN6PR12MB147672B5D2CD04DF4CFF7AE7F7A19@BN6PR12MB1476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lztOh0iHUFOFRIunhPvWM3lg8XF+rUhFm0fR1PoARx865YF6cHGxkHMoN1zO8vWIopkx/kAaxO74G8bcUgPykoDlM/JbVj4OwS4wBhHxeZzqWIThfqT3FTTk/CnhboeCJCPLnGwGnahBJ4zH3ihWGn38FTZSLBZWCUuJUREfGkQL9PVYrLf95JVvSBNjk1emQvI68bwxwrhrf1Wy0rlO3xGtZuHGM8Zd2v+nJ5sdGkPTo1UrRzgkU238v4vTDWJMaQYG97z1Hb3aEKNPhAerTVjBOEkAP8wpyKjdGqSV1cLNejokAnocO12/NuHeXnrvizQOIyQ5WsqHagW9XL75Sd1zc4i5OxJw6GZNkS3VA+B1waSJ5nxH7snC8+ju9/7c3QImH2MJdKY79qahejbE2541KA+VuhVpCmZYfokQIGtY+k+zdjfZRpJ9D6OlIN8VX1rGs8locwdYouvJNgchn9l5U+f2l19u6THQmZDCo+XmfONrafFt+WaJxSqFAfYXMIwqOaUgNXcCcQItw4WLcYnFVj1cpU0M2gLw7gwW0ZZP9RU/u1a1OkY/y+K/bL25i9aLRQUB02wzKhA2GWfoLTZ9vFj3+bpWVBx/XT6cNHrRy/2GMp40r/2WKcdUEcom0/78NvRch2Q56Qp3sWZ5sJ80qdZ5PIU6NoXIc3Oe19A6Nt8GluFlEuhJFSAuZlcHcWWjRBSoVWB6dzzV5O7Av6bSG+1Z0rJYNaI52+afxew=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(4744005)(2906002)(508600001)(356005)(54906003)(186003)(86362001)(36756003)(82310400003)(47076005)(6666004)(70586007)(70206006)(2616005)(8936002)(7696005)(316002)(1076003)(426003)(4326008)(8676002)(336012)(36860700001)(6916009)(5660300002)(81166007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:06.8968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2acb07-ccee-4ae7-96aa-08d97d2ac363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1476
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

From: Guchun Chen <guchun.chen@amd.com>

They are missed.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/soc15_hw_ip.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/soc15_hw_ip.h b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
index 45ca4c921a66..c1519d20596a 100644
--- a/drivers/gpu/drm/amd/include/soc15_hw_ip.h
+++ b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
@@ -80,6 +80,8 @@
 #define L1IMU15_HWID                                      65
 #define WAFLC_HWID                                        66
 #define FCH_USB_PD_HWID                                   67
+#define SDMA2_HWID                                        68
+#define SDMA3_HWID                                        69
 #define PCIE_HWID                                         70
 #define PCS_HWID                                          80
 #define DDCL_HWID                                         89
-- 
2.31.1

