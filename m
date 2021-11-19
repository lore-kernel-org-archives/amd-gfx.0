Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDFEC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E445C61159
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E445C61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7272A6E44B;
	Fri, 19 Nov 2021 19:44:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE09A6E40B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp3KHILmMlFTfThfae+lzfejh2kkjCDeH7GDb8YH5/5ndZes6TLUsvuuEKYVc+U47fqOa29hSm6Fy2j1tZSqg0FZe7ooA2Zu6c/5ZQ8RKU/dd+HrJItzXz6BUKcru1RQ3DcRBfjN1M1dBeo52jkFknFXTztB9mIhjviPYRl86eQMc7R5kgi0azt8D1qIBzK7RxRxkavIVQh+7IfYnnNlZSaZf3poEAqbNOPtU0stCVG6yA3nJZtcBPWgyiAHlf5rHaMYGjnrwB+3j+h+f89phcM2W+lC8vfRkgdK7mcAGgxCkPsqodFO2RBADmiM79o8cCRVq1bvX/WMBqgyXVXkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KGjFZZXSff/XPpFs7Wblj/j1ATOT9zCTOv5eDvLFvI=;
 b=l/X4RaOyCQAySMJQ07YwKOdbA7LYfsZGM9QBHW0W5XxgFpuhnTo/TalkX0EfMkKxJtYjuaWICeatu3w23ildNBe4hGZfCKF4CMOQi31C6ogHF3AqycKEB5i7eLYKppSexIgmeBBzt6oFjeOOwJDB+rSHuk1mHx9lBGbd7Id8xlkKRsYuMwH8uFKRa1GOgCl032jZ7+ezfifkEtsMRGtr5pbaDZMrTX2HdCYpFLvoYRvhp9dr/PbyVSUX238NH2A8GAg04oWbTo4TvscwOr0d1f9VGXCeq41Yugq+njlguI1ueN3rIlz3pnmv5DWcc/xsTIKv4mrX9+Gr8L8be6C44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KGjFZZXSff/XPpFs7Wblj/j1ATOT9zCTOv5eDvLFvI=;
 b=Lj2K9Cy5TD2XjrJ+o6vtHdgj+IL02VbUy/G9TLgoAb2QWo8Y/IS7JBD96ZSPizukpYqOSNSh5GxXT+tFN8IyXE4EY9jwmn7S78HqreRvJG8xLonI+8/qaapoR08YpQ32G0WbHB2ecE0lssDcTMToemSenMenx5Y7WwYumWBgqXY=
Received: from MW4PR03CA0287.namprd03.prod.outlook.com (2603:10b6:303:b5::22)
 by DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 19:44:06 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::49) by MW4PR03CA0287.outlook.office365.com
 (2603:10b6:303:b5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:05 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:44:00 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Display object info table changes
Date: Fri, 19 Nov 2021 14:43:34 -0500
Message-ID: <20211119194339.97573-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eafe10d-6a8d-492a-a10f-08d9ab94f219
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3771BF3BBC1CB7B14FD04AC9FB9C9@DM6PR12MB3771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aw2UNyl0K1PmDqN0jA7v3ttSLsU4thNmE3OvCEUuyVFMH8g7xQoeNjG+34mgxclGdEIcC6a8OIi8dT8+EHI8FnJSnYWvkSVlxkXtinyiHBQX+79lEgriHj0QMhYJkMFooasLZ7J8D79bpfWiruhzMl7gSaKGoVevbkHz+7uBNHvUnUsYycCSkNnYKC+pKnYFxvDuSFCNvOdauxc9OZPF8LNp5HZpL23cAqmpPZM4kl0DmVHH/CasC95+NFL0Wj1etdbFMeMgkNf4/JSGlUedHMxiRskxsyMtpct1RckcHN5ludA0S3cVasI8NSEv2LK3VL4bbKkag23Msg3Fyzh0CUeCK9+pbWgutkE6fcBHRTk3R1ChqiOD8mD+FPrmAblbS4GV1sktgv+B1+w6rmwRwArykWb6Iyh+j08W+ZhopjDLRYBwsLOYvxohA6dTsK1dHguFYnf9N8zce7kfic+FkFiUt5paG0YWtiZy5i1PpEwtWniANh3XiFSR1Zeq+hRNfpxkNxNHIGtNCbujt9kkzk+Rt/JnNuFNnjKhI9j3p2TS6e7w7qf1vk5Ok4K+M9fXSIyVTxxA95RSNL61WncLDAdMSARJjDqap69ijee3MbtPz3s2lhy8tRfIX1F5hSfMA/GDy8P7XAkdri4H2aaBocQ4VF9lUgDo+87AckDAelGJwovtheVuakH8j1yRICV+OLDoprdUaS5dJPSO7k6KsvVKBsjx/fIJ4XoEXhTIUg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(44832011)(186003)(6916009)(36860700001)(36756003)(82310400003)(16526019)(70206006)(8676002)(83380400001)(2616005)(316002)(8936002)(356005)(54906003)(47076005)(70586007)(336012)(508600001)(426003)(2906002)(6666004)(86362001)(4326008)(26005)(81166007)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:05.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eafe10d-6a8d-492a-a10f-08d9ab94f219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

[Why]
display_object_info_table_v1_5 with atom_display_object_path_v3
will be used.

[How]
Add bios parser support for display_object_info_table_v1_5 with
atom_display_object_path_v3 for all existing, in use bios records
as well as for new records:
ATOM_CONNECTOR_CAP_RECORD_TYPE,
ATOM_CONNECTOR_SPEED_UPTO and
ATOM_BRACKET_LAYOUT_V2_RECORD_TYPE.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index a4bef4364afd..1e385d55e7fb 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2995,7 +2995,7 @@ static bool bios_parser2_construct(
 		&bp->object_info_tbl.revision);
 
 	if (bp->object_info_tbl.revision.major == 1
-		&& bp->object_info_tbl.revision.minor >= 4) {
+		&& bp->object_info_tbl.revision.minor == 4) {
 		struct display_object_info_table_v1_4 *tbl_v1_4;
 
 		tbl_v1_4 = GET_IMAGE(struct display_object_info_table_v1_4,
@@ -3004,8 +3004,10 @@ static bool bios_parser2_construct(
 			return false;
 
 		bp->object_info_tbl.v1_4 = tbl_v1_4;
-	} else
+	} else {
+		ASSERT(0);
 		return false;
+	}
 
 	dal_firmware_parser_init_cmd_tbl(bp);
 	dal_bios_parser_init_cmd_tbl_helper2(&bp->cmd_helper, dce_version);
-- 
2.25.1

