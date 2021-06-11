Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B0C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 10:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C6B613EA
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 10:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C6B613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048C66EE6B;
	Fri, 11 Jun 2021 10:49:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169DE6EE6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 10:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAPbQWocxJZvi9BpTk3k3G9lIn055fZnbdzQXB+82SnE2jH7aI07BEnOH+IxKWlRMaHSVru5z/SniX/aFABgBqugrwQX4KGsm5aMSe9iC/+PeKw9p8MXrGhhmU9VZm0aFzU7kZDp5FYFfrSxi8KO75fykvD9dWKwT9PG1u9U4EG6B/WEXX6m6B3JFvpH7AW235uZmQLoi3iUHnm10fRSuZoSzw9idnKwwvuTelVLhZODOWejtP9Uzt15inC9I8DsEJ1DiVMytiM5eD6I360YxV0prKBgs7o9R9Y550Hz0Xv/x0cv5Vefm9bCmV6GxkOUEHKzWdVKLWYC97bS80OnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15nlumG50TeSM+VJL0KX1DHXGXASohuioFSaWTz7bg0=;
 b=WZ0GjekoY9ODbT95X9iNha0bxQfYOb2V2MdaJtEitNkVPYieDaei6sQaUKR7OotNK29IzdJ5IORwcEhgidv4RmRdT5vfobusZXDPuF/LHQ5kt8tfE3Innq4W6Z+tMlfvmfRcw/0Tg7sWJ6PjK9FBTOGAU+KuV0HLnMEm9qV6RG+seMAX6Q7vgtEKbt82xOi4okzuP8z+F3Pt3iNukDbR/sWlDd5Wc41zvwY2mjCzIFpNavDzF242lkNO3vXsHkMFYiK9layRZXa94ORbv8sx0LbKuiGK8WlKSh7F+Qj37lL2WAEE0X2VDVM7kSnCQNoWipAVBKJWb8TQYGy1yGZBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15nlumG50TeSM+VJL0KX1DHXGXASohuioFSaWTz7bg0=;
 b=ZeYj8eWGzrmwpslArA0Rber/NZmoscRXa98/SsXK8IkpTrLIFSlJUBFCCBGI9eEttbaGMGTzUHGZfUitT41Cp+q57jgYD3LSGqiakJF71bKAd3SGH0p4vQ2HggKCTN0I77G2Acz1WFnx4UBh5zSbgiRn/AxmDQWzpWAW5QmkiH8=
Received: from MW4PR03CA0140.namprd03.prod.outlook.com (2603:10b6:303:8c::25)
 by CH2PR12MB4021.namprd12.prod.outlook.com (2603:10b6:610:2b::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Fri, 11 Jun
 2021 10:49:23 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::dd) by MW4PR03CA0140.outlook.office365.com
 (2603:10b6:303:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Fri, 11 Jun 2021 10:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 10:49:23 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 05:49:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 03:49:22 -0700
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 05:49:21 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Disable SMU messages in navi10 sriov
Date: Fri, 11 Jun 2021 18:49:12 +0800
Message-ID: <20210611104911.121779-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd448624-b67b-4d74-9092-08d92cc69345
X-MS-TrafficTypeDiagnostic: CH2PR12MB4021:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40212F4522739075A8381BA7F9349@CH2PR12MB4021.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBAS82PHjN/uuFYv1ADhTvjfAhEWmhhnn7Snyglqtup0/ZfrSm5N7OLnvXTMOmG0R2KKHG44IxG/ZWyOWD+uSYCYYeACuN+Mymzepmz4l8zMxuV8CJA9ZfQaTqnuzdqSYzt8yDcAS1YqPKJ7b4kK4S6wTzyOxoDm/FqNCDdVhvlC0XYY8wHfiHRLc8bV4MPrlNDii+yVm9WxLtPtLDExEjYkBcE0yeX/kLyIGznhlBeiAcGequH2AoTLc9aacCG6f668nXdG66Zvz6IUNa8uTFOHcaAWFYg6oDJLZFjtNqGtpAoKwJLzkjUrScdko0r7796s0YwczQx/0tlh3agOZrhWhszZPA6uQ3tAiSj4JldDcdBvEszyAU9naG4v7b11O45oe9eAbHVnxzASIhfhozHDmFZl7VTkRRAgLM0JZc+6Y8YezJqIUk8uP2GwoOr3yPNK2EYAVWFMhd44F0Ejk2TXcLkDpWLHT60n8tetlLjzD3jgdfzGm+K0D4yLaWityN0uHjcKYkYsVfVGKZcZTxg3xLF7Zv52+eHalQaZqe8SZmNoMzWh+vjkym4dyXVDFF/CgatPvm8TZa4haJ/jWjogos9FZtnY1TOUd4Njr6AqlPlk6f3UOXurFrAswdVB+yvcGyuUxWmWftLcjjfz/RtnPNpYbQe4AC/y/tcDiFbqiQ8SW8tRaSrL1VxIy+n/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(46966006)(356005)(336012)(82740400003)(81166007)(82310400003)(2616005)(86362001)(426003)(83380400001)(6916009)(36860700001)(8676002)(36756003)(5660300002)(1076003)(8936002)(186003)(70586007)(316002)(70206006)(7696005)(26005)(54906003)(478600001)(15650500001)(47076005)(2906002)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 10:49:23.3993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd448624-b67b-4d74-9092-08d92cc69345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4021
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
Cc: JingWen.Chen2@amd.com, Yifan Zha <Yifan.Zha@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
sriov vf send unsupported SMU message lead to fail.

[How]
disable related messages in sriov.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..e1b019115e92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -80,10 +80,10 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh,	0),
 	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures,		0),
 	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures,	0),
-	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow,		1),
-	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh,	1),
-	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow,	1),
-	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,	1),
+	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow,		0),
+	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh,	0),
+	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow,	0),
+	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,	0),
 	MSG_MAP(GetEnabledSmuFeaturesLow,	PPSMC_MSG_GetEnabledSmuFeaturesLow,	1),
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
 	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,		1),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
