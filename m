Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4507661283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4507661283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E61FF6E3F0;
	Fri, 19 Nov 2021 19:43:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7586E3F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjLLZYBCk93V0pl2JdCwzkmqalzcov9JsV8roLsssocGwdBbsyhj5pFzbbuqi8g/1tWj3sO1k+fzmjAcvykKHf1BK59nebEtQuShE5aVIryinLw2Mw5jPG+FJGuvxO+32SkzhlKWIUffqxii9L7Tw5+RKvKyGD2Y6I3xjF8eC1KSiC0tqOaSV0IWZHQMdQYWF+Haq/a8P5BJFE4iU2Ih6U1vV7J0qrvAjsAl2aH6bi4P5OSFs5xxdj38gg5bbfPqXfXr54Ok0FvPOnSLPDuWb3VDD3mHlIdJplyNJxVY8DDoKwHlqlvyPXOAwWwdjzmISbsbk8bVEXk1KNESwkiZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DGnYM/926qUL1RbHqsjWmvbDsd6TMQlcnXNMCQejtE=;
 b=M6cLnTTcqwyaMd+aVth5Wh1QY19fb+bnqP+2Bc45D9zZ+exj0ttQvR3I2X3P9ycKbg7TujmP1zoTiXZkv9WpxoT77v23HPRJDQNCf3evqaS9pswOCJINxPKQGw9tDn8uoAVgVHr5BOZDvmXK9HaWaHTpO2KKbFoQ0hTCHroSPPS+nKTAUC0dr8G9yNCdFsiH6M7qLCXjIqdzBSp3RX+zeD76Xx3JLbbXuYKaWi43uFQieE2k9vtRp00UP8DLSncYBlzMreos2Ok6feiDH0vtBkxakNRblXgtsMSq4SRbg2BXsn0dqJhIjupvwTM6JB2HaGMZUOyUtJAZvU9kB2ZVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DGnYM/926qUL1RbHqsjWmvbDsd6TMQlcnXNMCQejtE=;
 b=fay4mCWi4t4fJFTMGBjVd5fvNui6LId+2Et2ZXthkhw919h2tfQybdVlA7R/ptPIbJ+7sjtvdlgu2gXcEZ7F5YdNp1lm/aTrwwrXFy025MtQ2RBEi/o0tmXTN9SHWa6vdkYEvDATlmq88LxcFMbsWAGmLwtF3GhumQVX+YeVNq0=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by MWHPR12MB1840.namprd12.prod.outlook.com (2603:10b6:300:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:43:56 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f9) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:43:55 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:53 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Set plane update flags for all planes
 in reset
Date: Fri, 19 Nov 2021 14:43:28 -0500
Message-ID: <20211119194339.97573-6-qingqing.zhuo@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c85726d7-b863-4001-d8ab-08d9ab94ec70
X-MS-TrafficTypeDiagnostic: MWHPR12MB1840:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1840751961EBDB35174138CFFB9C9@MWHPR12MB1840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAleuKYIFNpqyD7dEXTPqtNP46H2W3+X08nhC+6xQWNbgqqXlgCwrwPJxdsxZdnOR/4kM+kotq1jqKU/UOVILIsh72rxk5hrcQJTnMEIonKYsepV+dbbZ2gcbNUGYRzq3I4B6Dy1EbQyfFGQJqrDxaJDi5hpbtUTG3y+flB7ErvRg2XJj7iBxg0T0K+ZwffgdfKw/mWyd3cKCvshlYzku5MoNAlTy6vN5u85zRRCM3pe6vxeK9twNxmOC8RaLJhXcvkQfIGfuA1XeDkItxxzsuhLETT0R2KyMSb9yEwQCfwOsGtf7tpEOvLnmGt4GW77M0lvXDwtWRhXYvesjPuJLaLuchFlVWJvMvmD1sH4C7VHwmM1bFcIrJOTGDt53ieZwjNlSSmcIRyUVLdPXqJF8euAudjrQPw+RBTYuhs17NH0VENJE3I/N4sUzUm7Rsc5xVZ5jcyIInY7RC8CIsRuRZoeoozbynIcJwS1voLdccXNcGwBa9N1TYhPN8M85vJFDe4aQV/jkGmt+hLjc107+mQfsKEivUp5dCPunpZNOuns/flhb4glIwOf0+D1CMrd6bvQeg9OhftX+25issYaRLv5r4+griEBT3ZbliWVgVWhMKjHbEjXGgADVPycvV6qH3QWCCAqqRmFDsI5U5bmFziAw6O1QMnIE+7U6qRFJ21hrmfLMK0E8yn9GHb8lO8u+VMb7zHcT9Q1GrBPZ5AKln/ICSRWhWYpt+LovmKtl6w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(44832011)(47076005)(5660300002)(70206006)(86362001)(356005)(82310400003)(81166007)(70586007)(16526019)(36756003)(426003)(36860700001)(316002)(336012)(2616005)(15650500001)(508600001)(54906003)(6916009)(2906002)(8936002)(8676002)(1076003)(6666004)(26005)(4326008)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:43:55.8374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85726d7-b863-4001-d8ab-08d9ab94ec70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1840
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We're only setting the flags on stream[0]'s planes so this logic fails
if we have more than one stream in the state.

This can cause a page flip timeout with multiple displays in the
configuration.

[How]
Index into the stream_status array using the stream index - it's a 1:1
mapping.

Fixes: cdaae8371aa9 ("drm/amd/display: Handle GPU reset for DC block")

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7b1b88dc98c3..8411445e9c43 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2573,8 +2573,8 @@ static int dm_resume(void *handle)
 
 		for (i = 0; i < dc_state->stream_count; i++) {
 			dc_state->streams[i]->mode_changed = true;
-			for (j = 0; j < dc_state->stream_status->plane_count; j++) {
-				dc_state->stream_status->plane_states[j]->update_flags.raw
+			for (j = 0; j < dc_state->stream_status[i].plane_count; j++) {
+				dc_state->stream_status[i].plane_states[j]->update_flags.raw
 					= 0xffffffff;
 			}
 		}
-- 
2.25.1

