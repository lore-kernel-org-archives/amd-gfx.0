Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D82C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F7F10F02D;
	Fri, 29 Apr 2022 17:36:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8CDD10F04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5ewQzdY+4ozXqOznI6u08TTcjMJ3A3GTujHsQFibb/Bd8EkQL6Q4AJD1q6UWsNIqcIG5a3hChc5iPdTXyWQeIKUQTQi9Z2Rn1WxIwvfNzUVU1+QXjkDVEAIfW8yTSzGPcsEkQTUAZ1amfKRJxnXWJnGRacWqxlyNDUH1aSvUfE4FF/HHY5EB3LdIxkaXhXWudcaFmOv96SwUMBO1jTN5nvUeUryZxoyOKnuUHtxbeSDMEj0YigsQ0slDuukqPdoN14vCr6OGM+nUq+vN6TNLoGqx7gy+HmwJXj8+UkZAHRdo/tRxXTCFckGYDHHmlEU2mysG4Gu72ySYCxVAzJUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgeU5bDGPNS7GiU9v7yq3E/0hbCJqfchUuZtb3KTkGE=;
 b=VpbUvFrE67EJG1vlHrjrpcyoD8JjkPt/F2YmHj66cfsV73tHjnx9fkxG8Rzig3/20ReE4WKdbRdFF/uHoUI8wWo2pbxIarjPRppxUgo7QIPhE+Xg80pdL9vMmvokWwIc3Ust8mlbTQIKUZUmlfIQfwQ+5Twb9+yoRfFcCrICL9Icr8NrU8JQHHHKmUCtcLRf6g9Y9HP9eA34hFDYeXRYpolfzCCgN2I1IIorgErJ3jmK55QAxCubXrIhCkUp7jGk7EhDSSFxSoNIwvdTb9fXVfVRYp1nF60yDgsSay4eHWlwpWRkIChJ+DGGcN1Km+phEHerLri8QIOaNKOLo9e8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgeU5bDGPNS7GiU9v7yq3E/0hbCJqfchUuZtb3KTkGE=;
 b=bw7AAF7Ewe+JkVwD/QtBIaUrLBMd/us3KF48Rk0dQjPHGZDuZGnW/lFoL82t4VlewjnOCGDoTh22AhW7G48KrokqUYwl5gsa1x+fwxgZHo1cObJxniu7wSUHJx9+X1Wf5rFvNWQ6jqyVmWjlj8gerRyJUUS3cyMDAgOCg4tkvxM=
Received: from BN9PR03CA0315.namprd03.prod.outlook.com (2603:10b6:408:112::20)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:36:38 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::3f) by BN9PR03CA0315.outlook.office365.com
 (2603:10b6:408:112::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 17:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:36:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:36:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: add FGCG support
Date: Fri, 29 Apr 2022 13:36:15 -0400
Message-ID: <20220429173617.433334-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429173617.433334-1-alexander.deucher@amd.com>
References: <20220429173617.433334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8a363ea-5315-4599-cdd8-08da2a06d0c1
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6314:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6314F1F2E0CAAE7783B5A8DFF7FC9@SJ1PR12MB6314.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bMNxSIsltlr0YDTlQIa9bKEnNsI7OOcpkZEZFmX2DLt9cy84CTj//zxiE75RQCamLoiHW7gozhteEyUe9T7/ji5djuoZB3u7LHWHM6MTSElInElZjG5VJO2C3YaN08tTnfbVQL//8hJCMCfCSpRHeXcTml9Q/TuGy0Sh1tLvV9U3Hrt4AVb/HJQcWpwvdVRin09mZx1dBknx6wvqvhfF0gEeKm0QZUGvQtZEbwJ9pegZuxK8qhotFBdH8cyWRkJ/zvmHFofSO8i9WdQvB9Mj6/iZT9vxQaiDvAis1QLGnLr+vqi0I0L7ABAueXYQ3I3fkvWA6JCjZXoyiMM7jPOSByBGjKBjbdy7s9NxV8PHdDamPud8BaJval5ElRLKUDjZe6HQcMK8mgJFFjHyib5ZEm3O4bhCR8cPVsSSQft6Y1xZtQ2eBeEGqpQzu2ibk1b46tfe7qCJYe90uKOzYH43jTlUFpPA2e34SehzEa+a7G+cyL1866yzXNcoMpeczzHCb1OOLyD2EoX33WCyViLgunwB16n9EuslQ1IGT+RZVPpVrpwQp1ayt22jPWgaIMWdvLDZYbvzx37CmudJzAeqA5Wasy349bbj6VIsXxASr5CMNebe3wFvR393wlEZ1A1IHc5v/nP7woxh26GpdGejavrVW1f/8SLnfvnhRkZpwvH8IQe5LNXMQdaQQu1SnlnftMVOju3WJavOJl4E4T9Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(6916009)(5660300002)(1076003)(8936002)(2616005)(36756003)(6666004)(81166007)(54906003)(26005)(356005)(36860700001)(8676002)(40460700003)(70586007)(83380400001)(70206006)(16526019)(508600001)(186003)(4326008)(47076005)(86362001)(426003)(336012)(7696005)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:36:38.6097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a363ea-5315-4599-cdd8-08da2a06d0c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Add the CG flag for Fine Grained Clock Gating.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 9086df53660c..9ae4060a9d0f 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -148,6 +148,7 @@ enum amd_powergating_state {
 #define AMD_CG_SUPPORT_ATHUB_MGCG		(1ULL << 29)
 #define AMD_CG_SUPPORT_JPEG_MGCG		(1ULL << 30)
 #define AMD_CG_SUPPORT_GFX_FGCG			(1ULL << 31)
+#define AMD_CG_SUPPORT_REPEATER_FGCG		(1ULL << 32)
 /* PG flags */
 #define AMD_PG_SUPPORT_GFX_PG			(1 << 0)
 #define AMD_PG_SUPPORT_GFX_SMG			(1 << 1)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 05f1ac355ba8..e92d07f88048 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -66,6 +66,7 @@ static const struct cg_flag_name clocks[] = {
 	{AMD_CG_SUPPORT_HDP_SD, "Host Data Path Shutdown"},
 	{AMD_CG_SUPPORT_IH_CG, "Interrupt Handler Clock Gating"},
 	{AMD_CG_SUPPORT_JPEG_MGCG, "JPEG Medium Grain Clock Gating"},
+	{AMD_CG_SUPPORT_REPEATER_FGCG, "Repeater Fine Grain Clock Gating"},
 
 	{AMD_CG_SUPPORT_ATHUB_MGCG, "Address Translation Hub Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_ATHUB_LS, "Address Translation Hub Light Sleep"},
-- 
2.35.1

