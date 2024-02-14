Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9054CC48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D130F10E559;
	Wed, 14 Feb 2024 18:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ohCubVt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2656310E365
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVnjlS0Ee6mbFd7K+QLb62ugO5+ikxftmvovRBIFyhiTxYQuGYzuGJyXgYzuS+RQGQp+29FQG5sjBqlq18T0QGUrMwBaS6slDhcurz6Uf1V337ddgOZ9hAXLAp3vBsB8XqKry8tcH+AqRtm5JaQjnBg7C0yQZQeapWXXwD0oUpjl/8Xz2W/mOVm6LpCzy+bj6LhenqTclMnnWNo4KIjhAaNmWw7w/eO4I96Jo6NlJjzmNMnuU1AqbUXksIlFhLmoCH6uqay35D7wwGjkGfkdk2GoxVw0VHmLjFZr8vFgZsNg6vd1Gd/Og8dmpgJ6tJ1u4irJgfSeI4SxK+0fIMlfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gv0tfVLBTs/zZ4oLtlsaO6YJbOwQv7RU4zg9ygWmHBg=;
 b=mImMAV5YOkrZghv3tkPje+Hs29IMkDhYzCNCZhQaJk/RvdzTk0YwP2abGywTZXHSP3MurHBrZLlkS7FOoFeR6+sS9DXQLdLgHpP9DOBoh5iNnMv9HbItnMlHk1hxVmmFIGonwHllbCnKjAeTfnBDdf7SFVGW7vNZZOAwATBC81WdK1xjGWa+qW7s6VzBSIYYyxdx+xxvI98w/5ZyvxoQbcHfWS2DaPgy96fzMKRpMgfUQKWSedKcCplCfeKTYI0GqRFYV0O2X5pq5ccOi6tyJx6/clvbIKMAL7wkhqvRx1sSHRrqnL10H5jCaBd/AH2ZOI0hO79ll3ZAkLoVd0op5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv0tfVLBTs/zZ4oLtlsaO6YJbOwQv7RU4zg9ygWmHBg=;
 b=3ohCubVtmB4y5Pc0eksDSJydnz0gKvk3wH2+12xlNAns0uMI6Aianj72RxwUV9uSK5YXBjpXF52BWyiqhid1/CiltWkGc2h8juQt2hjvJHAtFlNqTCEUORVFt9TJIEqnVq/af0fpZP3XNYKw8eKDG2x8HEo60NXuKQsjT2bfszw=
Received: from BYAPR03CA0002.namprd03.prod.outlook.com (2603:10b6:a02:a8::15)
 by CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 18:40:56 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::3e) by BYAPR03CA0002.outlook.office365.com
 (2603:10b6:a02:a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:56 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:54 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 17/17] drm/amd/display: 3.2.273
Date: Wed, 14 Feb 2024 11:38:48 -0700
Message-ID: <20240214184006.1356137-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH0PR12MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: f128aa1a-eef8-4390-fe01-08dc2d8c7b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYSQqZAibX32opv5SHavUioDdfUZamU/1lm0Wkp0nyLt2eF2xCfXxCquQG8UWmR7+lmvWzvgJwsG7yIfBDIerxy5gRqKOlZTZgxDMJwpmWaeCYNHj7hH8hwnxNpW5cvE2c+6ke62SFTXgctcegG1JxcT4rK6/En0lTmKT9JpJHTpxEEhxASBFX7dAhgj7SyF98d9Um9VhuMq+UKHol69eQBnqnxb6QJbzbtkaJmtbZo5L9giIVO3cGd71lI8qJ38C27fR/E3Gf99Yuvf6Sf3y/9Kor0PcGHDJPEFav9JytrnqSuMxE5QkKin9H926cb6euEVfaRq0TsOKDB5c8Lhtgpr3a8y1AGPxI/nhasosiESd5m09LhZY81p63C9ZrJyyKkHla6jBua+O1t9QyC7DgUVtsYzPlfQiG2P67ZqMzBoT5KAJlSWJtg94xcTBczUESO9djLjLiuPpd/Izc0R24z9gTX8qLK/YzP6Zn8M8q9gFVWbF2jfd1AcOWUbXsOhKnim4lpSIQA/p6GbFLVhEVELjXjENFP8GqQhd8uSGYTNviZuiumUM9Un6BHgrhUDW/EUkMRqbc38AgxDWIE6Ouyl50m+S+72BkQ+t3uBwMc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(356005)(81166007)(426003)(2906002)(4744005)(5660300002)(6916009)(8676002)(336012)(82740400003)(86362001)(6666004)(8936002)(4326008)(70206006)(70586007)(316002)(54906003)(2616005)(478600001)(36756003)(26005)(41300700001)(16526019)(1076003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:56.2893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f128aa1a-eef8-4390-fe01-08dc2d8c7b18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

 - Re-enable windowed MPO support for DCN32/321
 - Improvements in the subvp feature
 - Code clean up
 - USB4 fixes

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9b42f6fc8c69..ee8453bf958f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -51,7 +51,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.272"
+#define DC_VER "3.2.273"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.43.0

