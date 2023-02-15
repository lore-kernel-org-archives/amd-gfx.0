Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F4C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 06:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A3410E05B;
	Wed, 15 Feb 2023 06:44:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE68B10E05B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 06:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6hmBFvoNC8fh7iMPLFLcB23CedeJwlHAN2YKaqG233d7EfSAwIGeeBlfQ+rnSoAwlg11MJPp+FTReNgAtHwACwqk0LK/OaIkkyWgvcYt5Rx0C3aLjyrdvMvQzvtTe1/+2WemMwBv38jB9nQxTYLlMXcdjTsomb9iVwz2zj/C25naVQxHeiYmvXVH8GeL37sodODJbjbhawIcNqJBwLI5PYI98OtGfelOfWYNi6RVfzk89EwKKDpJSFWFiYpUq6R74u/1vrm6xoP4Ml22ble82G9Ued2UNMkwf6dXlLgGk3f3s1z/s6B/Thoj77eNE/7mdBYIpXmDEO1QF799Qk48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW9XC88tz9/gKY+C49R+8htQ4jiQv/iQX8Fx0xwud64=;
 b=aa5f/0OVBopmOhBmnrbNQ3CNVAgLIr/6dgv/uMwqmSuWUJiRpJEwyiGXzTmnwDRTjpEYfLzamq3hWLCa0MkStDs8vjUlOQKbIA/1vSzWCIoFaIl/+y7Ce0+Ou3NtgCz7ad3icLd6oAsTO3weL6REx+ves9PMwJtT4NG8nCbrgfNCyyZXmLPLMbvuwVNHBWKTUEqNErqOESRRmh26NqQziIYqmwWPns4U2VjI7pCBuzPxHJhlNB2nTV/tWPMbTqQjTRtasXNAcDmGs2PnNxrPTOQVR8v7r9DytvzB+CotYH5WFpGcbrkQ/ef3aPtlz63BELlQwCpskLvQYYf/Zh3Kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW9XC88tz9/gKY+C49R+8htQ4jiQv/iQX8Fx0xwud64=;
 b=aGzhIYXSyornEuKFqm47sgHWxHlAcrcQFhfWi/pvSZxeAH8A/TD3bGhx2cYxaHUK79zpfaQ6eJvgIZK3eMzrfiU0ih/1wMSxIdHLpnPD+JsoqzVoBsR2iQSvqgXqQjkNU29PYkSmdXNKbcuMPjKjaJXPsXyJvVDH1hXEMiAjvLc=
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 06:44:06 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::3e) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 06:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 06:44:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 00:44:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 00:44:05 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Wed, 15 Feb 2023 00:44:04 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: re-enable ac/dc on smu_v13_0_0/10
Date: Wed, 15 Feb 2023 14:44:02 +0800
Message-ID: <20230215064402.576609-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: cac164c3-c1ae-4144-c0f3-08db0f2008e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DX6U88kCqyepdjsev0H341oGSAA0a8+VeRN6smIFUBKzkXFDDZwvOKStxNtG1DmvjHQcfE4eQN8gMl7ABlhAjBBKIzBRqzrdU9Ksv6iK7IisXJB+9qYTPpEPuu/Q5UTnD5yzcvn6p7B+IruA9hH9nQB7ibOySDT9oJriUHWeEIxSPaAs27toZ3538XVBz4u0WXT4ZUKEC6N8hYOSvYNDL1Ro9O7gFuONlKiHg5+YEDs1QMQyjT6FA6zbDUiqgyMKJSICmvcePXQFIrnLRN7Wb3OqY2PCS1mNH7Z7PKpa4mttMbBPQXs7RWvnMyjtUfwRLx7i9ie5rlLTauP4BlV8CsK8KAZu+lz1Sr1NUFGeJvJd+7LcEesN9HrG5Aj133JCsg6lsW6rIRhZkaaok71gzFZ3F/iIymXC2PXCHSneKnfMF1rAizf+KR5sXFgq78S7Fvcy5qOqAZbbrhGkgAct6LVBSJwmVVIh+1jRyTEChYZqSrQLJtWoP+wCSHszif0cJvlawdiVw/cShiyPAzVE0OlcNyVWnh42xICTAA5Qaga+cvljXEXlA5Fp70yOaGzJ3rbKW0CbQxrlBTVzngDpI6RfjdBbOD5lTOu2jRQzmAPuScgllY6J7bVXhKF2oeS/zOoor5x4O47bNBFCabVjSCJXRBnb+r3lfEA8jlCqrtTocQdGTQGvzl9kCkc/9qLgZGmmdBHx+mddV6uexhOQCqBvrzKwL2DnTt2/Ar6sTw4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(44832011)(316002)(4744005)(81166007)(2906002)(8936002)(70206006)(70586007)(8676002)(356005)(82740400003)(41300700001)(7696005)(4326008)(478600001)(6916009)(1076003)(36860700001)(36756003)(26005)(186003)(86362001)(40480700001)(2616005)(426003)(40460700003)(83380400001)(336012)(47076005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 06:44:06.5011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac164c3-c1ae-4144-c0f3-08db0f2008e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

re-enable ac/dc on smu_v13_0_0/10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 7c906ab3ddd2..923a9fb3c887 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -147,6 +147,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 			    PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,   0),
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
+	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
-- 
2.25.1

