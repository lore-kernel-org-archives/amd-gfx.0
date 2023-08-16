Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2C2C27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF58610E3D7;
	Wed, 16 Aug 2023 21:52:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D5710E3D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayHG3eyi7yyBzSjezBOU39gRRUMRS2hds2sZ8LyNx6GJsZtmeLnf9QxmNR8AJ3yjX4FX7s8liXRaCVV1eDQw6xzy0kqm8go6wVQZZEDo+DPqUtU+gw//LDPGQcsjGNnY3vtRwQkezm6inM2H+JrDtCsUcVnFuicuhhzXYiH83YVFwmj4Lhy9J266BNh2UClEvEBJnKYe+bEFvRJAEs1k9EzTJbDdJle5AzBD+K3ut1YkYb0dFbg9JNioQNtWfAIl/Eu0PF5IQSPEsopWwZPi0bl+Q8Mqnw+hvwX7uRvrDmQkzLKffYbg7tmoZ4SqhegnZYqkZN+vovO+7d+DobHQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QJcO+8tVzEFXF/u0Ll/Uv/oxnoQa9OdqUC5+a+oU6U=;
 b=fB1yNI7rnq1/VzMwagWsTSg8HFoJLvtwlk1Z0cGnMTpjnFw1w2+i08hoU35/JXvyRDObK6Ov9fAESn/KgH9j9rfKhkGMPZ6ugTNbOqaHpOwxy5Lo+STbhklT0utDAYyu7uHtA24rkuHcf7uEyoGmRxUSkpjwIHPd///G36zP4MUbVwTaRmDPDkuRD1a/TfV+qMZIT+UQw+udVmViMCC7H+KOvjc23ZRIwHxPaIpjHcYCwl2fComk/RnU6XMkzPwoRDK8IlYShrYqIPlf1ikeLm52uHkRvvqb+afWU29eo8HhwRYZLqLwFQt+ct5KKsVX1ccNrUogAKCsS/37ZD7VxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QJcO+8tVzEFXF/u0Ll/Uv/oxnoQa9OdqUC5+a+oU6U=;
 b=qcqlAWBSVVDRuUpSv0RyFa+JG50Fj2/71NJ+yCbw6JfaUILBpZYzCll6nNgoxznISE3Ce1CiyypPxszPSrRN7ezpL6S/KnMuH9OLMh5KEFkOEmw7jX3ILpLxj4xgvYcYuIbK5e45wt0N54xJp9/XjDMq0COEmCoewAxtsoRN3UI=
Received: from MW2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:907::31) by
 CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 21:52:18 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::7d) by MW2PR16CA0018.outlook.office365.com
 (2603:10b6:907::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 21:52:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:52:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/discovery: add nbio 7.11.0 support
Date: Wed, 16 Aug 2023 17:51:58 -0400
Message-ID: <20230816215158.826684-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816215158.826684-1-alexander.deucher@amd.com>
References: <20230816215158.826684-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bcf362-59dc-4b76-17ae-08db9ea30fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxGwaNJIly/0+5+LKmzBi7YkjTrXr+w4uh3N8ivWiOw1mG8V3hvyepRxsD86jG58cc7Vn2EQjQV8XJFKm6xaXEPQlQzAnRtbzmy4vQBkoIf4GPKYVQJ+Qj4y3Nf+8RBvKdl6ha30PnuHRZbVLvnblURJkjv4C2IE1MZaakgSAH6lVX810YvzLmj1Vhj5M43vFtbyfep4sM2GEGTK3EFl81LfDChCH72SRRAoMoVj81i9ixxuIp772go3VKFREtcXu/jAPfS7PUonKHKIDgbY+ceaV4HYLBIW7Ty0w8bCiH4HmwmIx1nYq08SA7tzz3YJnwOa9WaMih7nDPreWgSgqlsANLHg7eEQUjcsW3UeCzdAedP+zRlXh4PWiP6spBPHBX7XrGYp9bymnII+GbN/fUoecA5GF+cR65U3HjEJtAwCc3g9QEdRG6qZdBsyuPY0wEvoAsR+Dun5iVSmoPwB6RkwP0NVetX8pOIIdHTn7I9p+iuOEeJPfnv/baou6p/fzGxO8kZCsr3fLPALWYkIi+6AKt6lQUXA2dyffwdioe5xFrwScM18Byjv3kLEY+tVWWFNq9ZV+nRvALhMh5bKay9xcbNQC6+XNxbtxvk9kwEuBws8llvY4UBCTr7UghJwfiPO5G9SEAdhhFa2yUvKrIRzeD1MzrEXPN7MM0BtB0A0fVJKNvsR9JDwtNyaMJNyqAkwXaQFFKTbr8W95/aYkvxSXVvO85AKxnZqgnLTfD+AGwFQlGFexZH5nNAMwtG11AIyH6pm7gQwib0R7GDCFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(54906003)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:52:18.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bcf362-59dc-4b76-17ae-08db9ea30fa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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

Add to IP discovery table.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 704f97116119..6ad2dae3bf90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -39,6 +39,7 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 #include "nbio_v7_9.h"
+#include "nbio_v7_11.h"
 #include "hdp_v4_0.h"
 #include "vega10_ih.h"
 #include "vega20_ih.h"
@@ -2395,6 +2396,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v7_9_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_9_hdp_flush_reg;
 		break;
+	case IP_VERSION(7, 11, 0):
+		adev->nbio.funcs = &nbio_v7_11_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_11_hdp_flush_reg;
+		break;
 	case IP_VERSION(7, 2, 0):
 	case IP_VERSION(7, 2, 1):
 	case IP_VERSION(7, 3, 0):
-- 
2.41.0

