Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEFEC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0653810EBCC;
	Thu, 28 Apr 2022 21:34:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA87310EBAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6FlqaaiK4wKv6Fid0mfGhjTpUS0ag7j39dg13MX6KPlyIFXYAIYeNI1FdCAJRgY7Hg5Sz5c/YN2JYxVSFNOwp1evMKGDjgPi32Vc4ZpI05XVkzgVr1uinvL9nkF7UXp6u9nabcDw7ObzAXWt4494KD1He+oQpKr6B+K0tP/5mykNE6s9oaF3zKOZZlUje/HaaWcBqCzrLy55xungqXI0wltnOllmJ5MWO2v7BcdSzJSY+xd3sLmWaHYqMKzKLasHGOpKem+mIXei6E1HpTruc6MRiZa3HN4VACYSCtOQ6hU8xxD3t5rChjnCqDGjiy1AWhqEilhIqN31ccLH+GqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6fpBAP+9xZxSeSILsW6fuuTiRS6qoSHICxvcflxK+c=;
 b=cf30xc7kOQgY+559NbLLFQ0oyPyv1a5owjC/gqC5EsdLUKP/pD7MfCMBnedABQVuwg3gENDankJ4hra/I/5rA6chFE/0bllsGF8tSKzs2adypvUjMTqSpI2HzM2g9QaZ34gPfJ5j40JUZMTPSrC4SxsJg3kEl4wqX4SHhoMxg3hSi5E77nThIk9N4ZeuyGOY2elz7WAiHRS1MctCxl1B1Ao/TyjkZ2wrHPeT8RXZ9n5yo549ofGUsOE/mjgVwAIB7fdabS41lS2gauhxLBBvJma8N/kZ9qy4Mu+8+7bl0pa4ym50H4nflD+EGOTUcfi8DGeLxWLPNchL4rNTERBT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6fpBAP+9xZxSeSILsW6fuuTiRS6qoSHICxvcflxK+c=;
 b=WsNQ7ycJoWBV+IKGrnEL9BlBYnamVm+XSNcl4iBRaotqV+Y0miQvFXOOKxZTlMEkRkw/WGlNJB0s8V/s4CPha5/134eWkjJeoId4WZZRrCI3Z1VsL8L6sPc1F2C0ReryMBG6sGh01nN3DOPKBzyQXHkZQaACVF2LB0OPl0H+90Q=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by CY4PR1201MB0198.namprd12.prod.outlook.com (2603:10b6:910:17::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 21:34:50 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::bb) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:34:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:34:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu/soc21: enable ATHUB and MMHUB PG
Date: Thu, 28 Apr 2022 17:34:26 -0400
Message-ID: <20220428213427.700543-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428213427.700543-1-alexander.deucher@amd.com>
References: <20220428213427.700543-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d17261d-0642-4792-f05d-08da295eed02
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0198:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0198033696E3DB5357490AD4F7FD9@CY4PR1201MB0198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WOPc9TqXwhy8kmK1YIDVrZLTqbShtLImK94GmlVabwbI1xD+H4vXxqCTForWbGk6JhlGwdc1/Om7kcG0aJO/fxJhM7Htb0GBTqunfRN3pYS9UP8Qj3VbOl2spLBYWJkNYIbYEmLNagUGnZt5un7CRenmK3wDfKKsvXyMBJBY+kR2WB15x22nilam6MvGhgWPPDezv9L5vcx6RNk1UruwURoGszp6X4f47s+lCnO4VFiUwflJg1dqWtUIHsZRvk/BhKoeVcRtLBd3sW61yQ6aisVtfjNz6Upus0TGKn7gLP/OKEtBHaQIwLAHfnDBLk2mfUCofhunK14QPz6nOvKAbn9JnayTxXtXpW2C3JFZUjlvcM+rO7fjntKbLPbWAOoF4T56KXdiTAT0y4cFNY4S4J1sSnOtyzQbSC00BOEc3y8g1ZNxL/uHr+0wZ3bPADgPYfmXRafn68TJ1fPnuR7glXvhJXjGTlaZDEfuaECbbKs+2jp0CHJLxFOPPwozjWX971oPPcQ8KIP90BgVdrtYLK2lVwzaduXIjrqbjo29MGjrWbZEFrU/T9PCNHjZcd074eWZi+CV9TtB/D7SESqSgotQ8L2+d2I4Q6v6lDmnZiY1O3dy4RP29MISvewtKHqj4XI/R1fBFg/8rghtzF86q+tBKEmQ8MtYQtO+M6grL00xEdghhGFhQQh/DlR8iOQJ8LqxLr/dPILf7Hku+i7HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(8676002)(16526019)(82310400005)(186003)(426003)(336012)(47076005)(83380400001)(36756003)(36860700001)(40460700003)(81166007)(8936002)(70206006)(5660300002)(70586007)(6666004)(2616005)(26005)(316002)(54906003)(6916009)(4326008)(508600001)(7696005)(1076003)(2906002)(4744005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:34:50.4529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17261d-0642-4792-f05d-08da295eed02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0198
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable ATHUB and MMHUB powergating.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index a139fd1d3127..c3069f5e299a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -476,7 +476,8 @@ static int soc21_common_early_init(void *handle)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
 		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
 		break;
 	default:
-- 
2.35.1

