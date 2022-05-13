Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4435EC43217
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C2710E7FB;
	Fri, 13 May 2022 20:51:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E42710E7FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHnwNGXI9lHPNlhY6W06zDHW63jfv2N1ix/03y+8SzErBUyEY+ihvhP9La435UkgvAPy9PSBTnlBmeYjQbF2MOh3fqIp4/8WWVj4IA7n9JOdvF6bFHuHoy86ACtBsDV5VzvITToYC7hBNvLTzByd61Oqjw2emhMZqwn0i95zfwouv3VAlOBc+4D7UUD3gGCDUy7Rzj4yHULl46NUSLnfywYr/vCt/RDfP7dZv3UjFgeKqhX/uf/M0M42P23AB7paNACREZiiW1wo35FV+tga6xwFLLOU9do550E/9txmLHc/GJMBVOQrdy7/a1n7UeZxSu8Ug2PQ0W2B82i9JunY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhsIzhHdWWlSj1PCOmdlXob8J6C0n8G9fbcAMWbEo4E=;
 b=fzmhTz1EYVpGiEkhPqj3+D4pd8IOscyRKKh0huX1YYEvnsR1IEAxOJlV98g6bxWpRKnzzk1XXSKAjhTqD1t426I5VOz42i5OVi7JlklqglwOcvvPvmfT3vuop3lO4AvA4L4Pv8XkaqGTdkVt5Hk8q8dlV8J7rYOYgnkoBUEpwDTwytuGm3I82iQAGtrRxDzgyJp4/VSdIy8oCWa+s67RPusQbWqf77gh/BnZayMlHcUaVQAG8Qh28zKZnBHn1sBoksdz9+z+b/ZIE4sAerNHbmnWkI+PbZq9w5B1BKVgsj6J/sm5nT6R1qm1+JpffGhO3DfZ5A2PRlBotd3VTIsibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhsIzhHdWWlSj1PCOmdlXob8J6C0n8G9fbcAMWbEo4E=;
 b=ZVa0MeZ0lyySuFoERXNXGLOHrUzkMLhntQPd8rWBhZ01U9TY8JEkt+3WQ/1UWpbyJEasazWlE7DPJxGOk2EgZrCEpVfR/U7uZDr747tnJZj1eu8tBcNO7VP+Jxk0tOwufnxsMSau2YJOFu5fl8cS+PPGbMZEXTkNp+6/fLDBJTY=
Received: from MW4PR03CA0297.namprd03.prod.outlook.com (2603:10b6:303:b5::32)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 20:51:30 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::56) by MW4PR03CA0297.outlook.office365.com
 (2603:10b6:303:b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 20:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:29 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:27 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amd/display: Check if modulo is 0 before dividing.
Date: Fri, 13 May 2022 16:50:35 -0400
Message-ID: <20220513205041.1311639-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71489fab-c4b6-4631-a7b0-08da35225ad4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52888B05B8FA18E81F5671FBFBCA9@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Sei1mEIXWtWKzx6/gvFdUx3exuD11DYyXjg+9UGssKR3YzE8aYGkKHaoV38cXotjQk4xZGefOcdS80uLVyQg0A/cRsHp4dZ9L8rukbmhqJDlIlWkNLOolbZoULcIpqqEQEHt34U1ctBdVLzv0bpyLdgI2AATfcJlct1iNy+Nu96Hej4oMfwbcrALvNRGyknqYAqo1aAEWUJNXA9BZ9x5X+P4QAnsbbwQoBdNerZ0wPbBLIFpvROhuQm+/bWEbjDMkW5tH1j6fuVV0kTt4QF62l9FDPzVaHBr2CuRKFraoMkcQDMhwwM2NCv8J2ogRadASIpjd5YKeXSYdT4fQWM8U5Z69/qoHqp+yGES77k2iZGQx47jcrahvKZQ3YHiMpLIx66G6DfdAK6sQrapxe98wPm8RRnC6AWNHMx91Zily8CGBr1fFgS0djuTbEF5Q5g997tJ/+8KGtm6y/JoigPMTChDGf3RsQkAOQ2KcODraQg6avxSuDbxXWAdhpGuyz7y6zr7z7awesse8WVVDu9QNXEtI9s1liyBEuZhzDqqVdmhnEASGu6/O/7KnjSU7G8LvH4H7hHZe0S2Fk8QQ4cAedZP+g/bYPQwSzBJEb64fzpYfbBNrkOA2iYnouGovG3Nib2FrzCC6zD6cTYq1iBRQIqYKwKEBojz1sNojzVQho35Jbl3sLn0kLt0PN7iTZW0nH0BhkuueoGqYGshiy+bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(186003)(16526019)(86362001)(356005)(82310400005)(81166007)(44832011)(70206006)(70586007)(508600001)(36860700001)(4326008)(8676002)(40460700003)(26005)(5660300002)(1076003)(6916009)(2616005)(6666004)(54906003)(36756003)(316002)(83380400001)(336012)(426003)(47076005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:29.3517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71489fab-c4b6-4631-a7b0-08da35225ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
Cc: stylon.wang@amd.com, David Galiffi <David.Galiffi@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[How & Why]
If a value of 0 is read, then this will cause a divide-by-0 panic.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 5e6fea85a7b5..845aa8a1027d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1101,9 +1101,12 @@ static bool get_pixel_clk_frequency_100hz(
 			 * not be programmed equal to DPREFCLK
 			 */
 			modulo_hz = REG_READ(MODULO[inst]);
-			*pixel_clk_khz = div_u64((uint64_t)clock_hz*
-				clock_source->ctx->dc->clk_mgr->dprefclk_khz*10,
-				modulo_hz);
+			if (modulo_hz)
+				*pixel_clk_khz = div_u64((uint64_t)clock_hz*
+					clock_source->ctx->dc->clk_mgr->dprefclk_khz*10,
+					modulo_hz);
+			else
+				*pixel_clk_khz = 0;
 		} else {
 			/* NOTE: There is agreement with VBIOS here that MODULO is
 			 * programmed equal to DPREFCLK, in which case PHASE will be
-- 
2.25.1

