Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830CAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F2F113A07;
	Fri, 10 Jun 2022 20:53:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DD9113CFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnnlF00LZvwotXAirNf1ymxRPM+Q5CkY5FdQxEmUZv62KivzjBEc6Kps7emADVLd2Am1p+4i13rttjer4ezAGP1UY7txh63SvxhkOpzcPM98Br0P4GPl7pxGMb4oSjVspZkUGjXwfMTg5tVzAsFJOqS03mEZe5ratkfODeBRYu1D5OGNAw/7SSjxs/A3YGJxT8vL2VXR0XaB4em/jiNTi9Wci5s8z15dhs3Bj9o4bTs3kr76OfHWH7vKdr12c0ViTlpaqyOVLq2QqbLELvUYgk5sSjOsRGutacGdfN2OEdwNmqIaFfNwdHaeQDNuU508Clzyu8VJy0sZRP4MRTKfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdUupKyDMGTU1keOhqbbx/cAV9Z4+e5tEJhXIHYF1kk=;
 b=hwfwTCt/K1stbry+kAiI5pJdjxbOkb6IOCwzla5ZC6u5TmRyA/gcOipOMWvrBQM4G5WNWVSpiFbNVfJndpVIaVXf/GoU4u1yr9u0bJUrs73Repi3NldjgXCshPiQJ5tiDj/8ZFhwxnyEzf28dYzRvQ+7FyBFpwCM9dyKczVGF2P/xT2UPaE2/m4SxSe2zmAhQkKBmh58pksuqDz5S0/8I/b8iDtwrDj0mKqe7Qhx+G9SibWmwne7DMWMxBvqaWQCf1dItvhCw1Adbs2j3gGwhWHNYjnzOKZLAIHDMojqpg2Q9VK3kY+BzTS3j8gMTerbGl0bFmNK57QGr1Bd/QO2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdUupKyDMGTU1keOhqbbx/cAV9Z4+e5tEJhXIHYF1kk=;
 b=U72s+KZ6HqPfA+6aTJ0Y3tn5tZ7FLgdwXxVA7nKVw9DeW/iEKQwkYomZFp0WKrAdvmnApgRAZvG9iNNWveNed9f6nY29vAo4MPrnVBwBAatKJfva43K6zgc6UO0A4Vl3dVWIabRH7dwWC4vFQQS1MTb302YkRind2iG2QXqWh7E=
Received: from MW4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:303:16d::35)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 20:53:44 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::91) by MW4PR02CA0012.outlook.office365.com
 (2603:10b6:303:16d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:44 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:39 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/23] drm/amd/display: FVA timing adjustment
Date: Fri, 10 Jun 2022 16:52:43 -0400
Message-ID: <20220610205245.174802-22-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa5b7fbb-cf45-406d-774c-08da4b234efb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36945B94F180211380B3969AF4A69@MN2PR12MB3694.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UAbPFkKZdZb6rYEEgqHzuNrBSUAXfGKgZL2lU4GySOIqMSj9fT2iJO4NfYWqRi+w/o/DyauikEK1uOOJFzDsPPacJg1fvpfaZcB/cgns1Wurpufu5dRjd2aFez7S/ifcKuGSZEdmXpk6WR70L7JiKUhEQCUw8aJVZek9AYq+fx8zudnnD0jsE/GKKd1j2ovX7BZOino5G0BwFhE+XUMI9Tx1fBYEOawRfRM7vs6/1NDCOYfDqKb5YVfX77COiSIMoiI54cW6HCDMXp8T2C6dZwnZZEY6Sjw+lBVan2Cpojjs8DNuXKRIA8Kd9c2IyU+/aIVPenPKr5JxCGFOb0xapV8ZUkZpx3QXZ6hpdZU229nk2nGpz8neTs+y46eONeTPQVW2pT0TyCCzXIsklQNvCsLkM8D04j5E4HNkzHuqF5Iu4LSa0rcM5OYPb4yEwT7b06q8WZ4cXA+pA4SOmJodeDbjZhksg4Q0yk2WaU+0jAod6jDbC+bj/vhjjqUfelSup+gJfcuVnnKTnToEoiu9y/3bGMbXO7hcdcrXRuJDuWIC2PItT85ue2HW43o4CPQhNuB8rZJJa3K7TcPEb1vxecEVv0rmgq7RZxG0GAUG9lEHPMSZH+2jgZ5k0YX8iHUBBIfAboKGU1ewg2XwhQKbwKH2mlqlta63WEPwwb/bLTCpKhgrnC7KvdhBPBcFEf+G0+CiPrZxlxLt037rc4tjTibi2QIAJrpvNfGiftlmQ2eNhNMHHOoOurIcuc7xR53
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(336012)(508600001)(47076005)(36756003)(186003)(83380400001)(426003)(4744005)(44832011)(16526019)(5660300002)(40460700003)(36860700001)(2906002)(82310400005)(6916009)(2616005)(54906003)(70586007)(8936002)(316002)(86362001)(1076003)(4326008)(8676002)(7696005)(356005)(81166007)(6666004)(26005)(70206006)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:44.5513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5b7fbb-cf45-406d-774c-08da4b234efb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
need to add timing adjustment for fva.

[how]
add hook to optc and hwseq.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index b1671b00ce40..e1a9a45b03b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -165,6 +165,7 @@ void optc1_program_timing(
 	optc1->vupdate_width = vupdate_width;
 	patched_crtc_timing = *dc_crtc_timing;
 	apply_front_porch_workaround(&patched_crtc_timing);
+	optc1->orginal_patched_timing = patched_crtc_timing;
 
 	/* Load horizontal timing */
 
-- 
2.36.1

