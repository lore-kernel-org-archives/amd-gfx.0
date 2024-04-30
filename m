Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46B9C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1C210ED52;
	Tue, 30 Apr 2024 20:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="joJ6O+6Y";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBB110ED52
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3aWN+zDdUmh3DmhVKFE9wkoc7ZqMsbjrGXyM2Ba4YuGH+FP/nfLVfILnlJ1l3fUcpO6hIwv1hesFztpeIdf00oUygovQx2a9my7wxyuj50gBWF9bTZxhmjth+JzJveEGY1C2IjzxHlquACSO4DOaDNDoXUVddHRkGkMOVfo7KyWn2essQCCYhBzWW7aeGRyUGcPxJJs6/WaNxRgl+NUYAyOjDTWiFfXq+mUgCt41rhkWwC8peGHiBg6kXM9KlnX8ASrUW6rLw3NFiHt5PruK4A9+HyAa24bSQ0FYkQoJzjHa3dsW09El8R2i8tiZv6uCISrdy8TeYHVA/EfENItZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yL11wWZEOI6ZUWOS5I3y+NToslmdIfS63TlXLyG85Q=;
 b=IGDGO68rSxEL4eZ8QhZD1WW/X0/bgMtvZ5oKWS5pBRIoela5/f5DD/uJ89Irre/TzkCmZ856D3i0t50FcjHJwOHL7X7xwIN43NXN1mKT923U3Hh7bn7lq8I+tOmffgNIIU44Y2ZIU9DowVVj9PoB23iCTcMS3aEwYtSoP0HZs1/KnlS2Xqu7FEUgGhu5DygbCYXyfwQNPGOXN7ZoqI1YHGeF8EdE5+u2egqdhfOiieGS8vzbkQlyi5G5OPSUOAUk1SkgN5mL42MxNAkUWeEgPhglMu8nBR3GIkmCJCqSoWkJj9NSJ0lKfEaATo6TI09szTbugqT1aIpkP8ZKwOsxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yL11wWZEOI6ZUWOS5I3y+NToslmdIfS63TlXLyG85Q=;
 b=joJ6O+6YgCX1v9TcInaCBHcYKQXwU0GvMPGmooC+sj75ibseaRIjKywh7H5tdllj/DaTDz5wjy/rzjV7SIPqwDbHqEp8Isw+OHz+VUg/UmNsYmzMhusTzrnhPBzxWUYtlMz4QWdEpBhRREk4V7bnDRavIcXra06VdBybh1d16k0=
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 20:37:33 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::1) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Tue, 30 Apr 2024 20:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:37:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:37:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: enable mode1 reset on smu v14.0.2/v14.0.3
Date: Tue, 30 Apr 2024 16:37:10 -0400
Message-ID: <20240430203712.800427-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203712.800427-1-alexander.deucher@amd.com>
References: <20240430203712.800427-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c1c363-612c-4dfb-e66f-08dc69555cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4eHFrbXe2geZlp6Qhz457DT+Jeowdfj0agbIrX3gwFEDU1w195KSePvQtPI2?=
 =?us-ascii?Q?5C2TmFsuYYCAht1F0HkKho4OaUeey5A1rl+8hIZTKFDA1PFH56tfJC25QPRG?=
 =?us-ascii?Q?ETLPhltT7vD7ni0402baZrwlkcWcMP8703LBBY0EBFwyUSnpG+TqWELIekAb?=
 =?us-ascii?Q?5nXrdVeXaAdRPl7grDD+is90jkS3Rx6oZ9f1buRDsc/aaGA+zIAc6eaNcONH?=
 =?us-ascii?Q?61x4OZBC+lWi36s1+hyMgQG5sUeqY+iWPllKH4EcDvDvI1x7RtpLXa607sjZ?=
 =?us-ascii?Q?3t7Up8iBJVGSPWetHZOYTrdIUg/FRZH2GJPPWpKlNF1Fm8lxh2P8qouaLmW5?=
 =?us-ascii?Q?jQjZ9IrZhTHGNvfn1jQwVPbhuw/L2mrvCO17vMGz1qCmD1dZKWqlTHDIZR2C?=
 =?us-ascii?Q?41xbcj0L8Ik3dGeNf/nICWQO1QoIadHGT3/h2z5hohE1Iidx6H4uTh/pM8jl?=
 =?us-ascii?Q?qWLnisHcoMDzDs0ctSRyHh9x5B9ofvFCydtzOpbSjm88MHGIN+cw0T3f41xF?=
 =?us-ascii?Q?qYcKrwQ8ImaYIdUBIQ+yLomTdC5jfFB+lCs9gK/Pv6PH8VUKPWlTTagbIMLD?=
 =?us-ascii?Q?2lmIfk+4dCUxibH0TvyAOqANL95lu5z9IKeQ8ouiX4VlLpKHrrUZcYM10o/J?=
 =?us-ascii?Q?VyMF8Rr8yWIn3EMEWKdFOnWqQVGWkkjwrmdEbngxXkbiWgmm5q2Csn2g6zob?=
 =?us-ascii?Q?6Q4Bcx1rQFNCbIy1ihnaqzyWtpFS0An4/TXBbOgf/0sB5v/iBuEf44fcV8ES?=
 =?us-ascii?Q?EbYjpXI7OCMSXf068OuQOR+q4DbZcYPE04i6Ihz8TFbMB9hiLkM/sFIrOcW9?=
 =?us-ascii?Q?93XubmCOViUKfYwqTXGZxeM6aP6h9LjqbLS+ebKTeUsI/nh4PdXEm/Q6P2lD?=
 =?us-ascii?Q?Z924MWluI/aAa8cmAXbVuf/g/G9g2IQNv5Pw1w0i+xPFRYX5vxZMaCVH8FSW?=
 =?us-ascii?Q?zVleTe0mu/0rfnfRWhlVjFVMqWuHx4blhtH5hN3/gktLREY3mtMZubvhuA/G?=
 =?us-ascii?Q?e49dbUNx548k9Q+L44q88dNIr3dcnB7C3QuKECscFq3rjzrirOTfXPZuDJqO?=
 =?us-ascii?Q?wJTKvOF7Ztb6XcJFjz9RRpIAGk9oYX3b3oQueyRgj4FixKFjQVKQVJkmJCcR?=
 =?us-ascii?Q?+aaFJ0M//RGMMeSIHMsrFR1Yp40XcjcYD2uX9DVNKaLDj8gKlx2bOZ6L3Dbo?=
 =?us-ascii?Q?6xiZxrvRo5OV5n5QrKRTAJbkflmBrsTThqqY8nUDISkbkxcpAC0ggOB0CwFa?=
 =?us-ascii?Q?899n5xkEuIcm73dPSADU9n2HzBA2fcoDxupP90FT5FyXn5a7vEX8pAXTwfFi?=
 =?us-ascii?Q?+VoqZpLQRsMmrs71U9K8oBxUV85vUBrX2FGCumTVMwtuE5BmuG0xBTr3POdn?=
 =?us-ascii?Q?8FXXFMI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:37:32.7381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c1c363-612c-4dfb-e66f-08dc69555cbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
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

From: Kenneth Feng <kenneth.feng@amd.com>

enable mode1 reset on smu v14.0.2/v14.0.3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 706265220292a..b5bd8dd38dfdf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1637,7 +1637,13 @@ static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
 
-	// TODO
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	if (!ret) {
+		if (amdgpu_emu_mode == 1)
+			msleep(50000);
+		else
+			msleep(500);
+	}
 
 	return ret;
 }
-- 
2.44.0

