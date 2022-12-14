Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFF1C001B2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9103F10E483;
	Wed, 14 Dec 2022 20:22:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9944910E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb+CK359ONpVUPLlbU/do1Gnjpcjh8vtjdmgJ8yPkVboRmbbJF/A0LHtgjaQrXaT0IIgzJOY6s8Td1l7raJzI97qMUmQQNiROCDo40qUAVl7+wIJfj99MctrBCzFC47DfFWMizOCJZNEAr4BlMseC4wOqJ0DB33OFIorikhnE2z+S8TO9UyvBC4FjCLDeuQhs13QkEyq2cJrteRN0Fe/7Ehks1gfRj40GqjZ4FZ6Vd/GJkmmo7xo7m3vJiZcmMTlIpB4ol+xhlYhqd6gZwvM8D1sRIgFwtSwPWlgyPX+T/ObvjO5WguD2Zy0rOzz9tCD5s5U+ZpVq4RAUgnsTk0g+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Obnisb/ukhOqT7jiOH9y8ICDmoU3OQipOMyplSTsedY=;
 b=hH3rP67qLxhNnZ3vkLw6EuKhlA/M03jAgKFYXxxaTpoA8Xya9dKjkVcWjIPh5a0N1DEuhjIyNdQytWvGbTI6IT2FR5vs0Fr+vpvs9JBC0xOe+ZkBPz9yZ6/4dIH5/0f/L2QufEyPpg/dv6fI/1yHYIYIVV0O2LRQMveMcNzGg9eKsRNNSq/Ryx60nIH6l4rgwAJ842EnerqUzlHtxOEaGKYljDUUJRpxfvNOYf7zD3FHRgWl2knqC+ze10U/XB5YdAAK1piHffEscWymRin8tAfT2RvgHuet47EOQOK5rZzBDah8CtsFrBwPrlgfZruz0nP4LetRJGYDAToeD4uBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Obnisb/ukhOqT7jiOH9y8ICDmoU3OQipOMyplSTsedY=;
 b=mH6alcjfwfQXgP9ALaKBvCG4nvVEHzi2GqyK4KtJXqjzJWyrfgHWn0Y7wADrenpXf/JfTNXyaEN4YkJMUbATr3gANjCGJQIQrZENADUTAEYblhA/fNADIUyP0UaTWbpgVUDX8VhWJMd2ccUr2YZTB4d2i/RqGa7F7OLucGWmu3g=
Received: from MW4PR03CA0081.namprd03.prod.outlook.com (2603:10b6:303:b6::26)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 20:22:21 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f5) by MW4PR03CA0081.outlook.office365.com
 (2603:10b6:303:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:19 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:22:19 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:22:18 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/18] drm/amd/display: 3.2.217
Date: Wed, 14 Dec 2022 15:21:41 -0500
Message-ID: <20221214202141.1721178-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c206dc-1bb9-4d63-ea09-08dade10e7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/rg0EIdBc5DLbb6saAbkRq5GiQeGsOk9az4o9dMmie2PiNiZ+CTj9DM+fn9IX7mbAThmQpNuTLYM3Fx3aS9YBI6xunBjHL/RaNU6jxlZKg0hzAvHYQ40HpawyvlbkAcePe5QMiYOObpDEGE77z9a4iPI8RZnDydmYSIBDrsVhBzjLkMH02EsTvNo2Po1lgttxAW8LSR+1FheiZv6uhvWCWxmTLKYYAbmKg0Pe4MyPjuWxJ7B+GwY5/LehIzVgktTAejA0Ul71nplrOgq5Oym0pqX7MySpbCL8CYVbMtY7vbPzP/8M3vyhOmhYJRvKM/OGaK1ViZ6x49bC5F0NcDawHbpyk7KSQOLn6vxpuSZ2FfYLpZEjN5yNMUsIa+Ot1jBeR/azZC8dUonjTRZyRJiipz52jtz3nFLofWJaw36qQZdI2OBjlsbZJtIqdKPq8MaBC1tT0P8iDoLAvZapbWOq1Q5pzddO1ONtCwydsLDgwdaMFSMCee2U2QAXjglrXlsXYbq4+nDWFa6UFgtpb+WQQ+a6pT+EobmJkl03idJhBp1kBifj4chQTimXdw8bJCisNiVUHXXyNOdjFUJraFcMBKWes9YG1+fhpI3FJL/6dIRdEzUYen/PKWdaHryubC9NSZ5KGAEY0urhj3EUr4ZiMSD7vyEmu4SlBAG9H6vArmNICuR7dQcutMSR3UPtfvKcjiXqO6p5ZFuYwU2ouDcNro807CBkA/dVmXWSjlx/g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(70206006)(70586007)(41300700001)(8676002)(4326008)(5660300002)(316002)(2906002)(8936002)(186003)(26005)(7696005)(6916009)(54906003)(6666004)(478600001)(426003)(47076005)(86362001)(83380400001)(40480700001)(36860700001)(82310400005)(2616005)(336012)(1076003)(36756003)(81166007)(82740400003)(44832011)(4744005)(356005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:21.2193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c206dc-1bb9-4d63-ea09-08dade10e7a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2896157b37da..0f7b7ccfcb40 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.216"
+#define DC_VER "3.2.217"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.39.0

