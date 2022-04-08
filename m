Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85814C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21C910F132;
	Fri,  8 Apr 2022 17:27:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F1810F127
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+e5GQ/pWylHl2ywRcOrl09PxR/QYXEEnAu11GD59CtQ5jfPKrh3nAIq+1i6kiQ1HENwyDG3XjS3kmHi80kTey99GGQLyngJv7gtYgQnOgVtQqdbJPwRiek0DKL/g0o6szUgFn2SZWTDG52T+NjC9PNFjwwikxognTtDPhcC3LntNKXKunuYwgJlWJ+WTvKKFyfsrNuXp9k9d0rVq68qLe2wtZ7sXuEYbxYi2fPK1IMNksxdGR9vOAeTs3QU9tM7BZJ4D47QQy64sXRBr5j7jdFvQEYZlkIbv1iEvbXFnHBgzlPyJe315NgTNizVoSbHk/2R+Le0XB4/vPa6ndd6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWP800HU92CzIWxHuk9twzud0MZuO8aer3HPNDvF2v4=;
 b=A2O0uZIooh37Dgo9k5ybFXXaWrbSpqggZNJoCaLC5Nu944ISESvdRhAl97OTG1ZtRnt78vyLQM8xEeH3b0tPnjOCGUwnsavpPiM7/2ih/hhtCLBPVSS4YStww4Szl7JE4aaj9+tgrzuLBOCjZFkyGEdt+SqLyRacxXADHd3DrjjE9Vs8hL7o5LWQXoLihLRyNBWRWbNekxuCtwoBbGfgWeMwnpLXBZ2+auVCKIU03xCk9hJa5p/0dLeu5v5+euKG/UtKUHfP4YWHGpBCcJM0C+1xgz6czDhsymwLyiYQND9BMTAQxCn5yTpksBNhZpVAUmTTdC2gTOd1HR48uxsU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWP800HU92CzIWxHuk9twzud0MZuO8aer3HPNDvF2v4=;
 b=JSXx8PQMTC4RDfiJrv8EkF3kZZcMIABlqk9TvNdU8DPVgkHxI3XPVDgXUIiQdRzJssHh2+J0thPv8gfZBgIA+2TiwakMU6moZLaJIyFmLW6NDgujqzcDhNcinLZlwAl9ROBqSzWwDX7azrPuwIMva4VsyFCNhGXhUoE7zSMLGNk=
Received: from DM6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:100::48)
 by BYAPR12MB3062.namprd12.prod.outlook.com (2603:10b6:a03:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:27:54 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::78) by DM6PR03CA0071.outlook.office365.com
 (2603:10b6:5:100::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:53 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:46 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/20] drm/amd/display: Fix issue breaking 32bit Linux build
Date: Fri, 8 Apr 2022 13:19:08 -0400
Message-ID: <20220408171911.601615-18-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e987e2c7-3fd0-43a1-e414-08da19851d0c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3062:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3062C4608F2056B46644D835FCE99@BYAPR12MB3062.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfiBt5Vdg629wq254+QSPYOqijiE031Bk0bX8Folbh+4amZsg4u5PRGSg0rqZcyQiedr02FWI+pzmDGsiFo9cT4SZ8OQDZTH/S0rnaMp7zfYP8/u3bn/kxqnHDJJ0q2laWAKJ6X4Ogoao+qdAKTUcQ24sjZv9EPXsH+B4a4WfknZRCDKLUR1YYkyagD0ctDA+LczrJDQzUFCnj2IlIMz2tw55tnC1fYeLXTZt5kjr4hKfOaEuWp+zHK1heOe9Yoplb1WyNh4SQB2Nxuvq7ztilACgevV2w7sjG9ZfAXTSrvGxiyYKl/I6GIOXqAkFt0LNKYZ3ggmCKbhXqrfL3qrYDz6HjwjGbT0E5gfYOVUF4764L1CBnobzBb7rwqiVQrcwKskanq1F8ncjMsHVT4DlwxQEFEf2riCEEV48iNS/EuVuWCfFpHxBF1svWv7/Q+rh2+nDXWotWlgm0rytcTZH2lGQkN5DQBDy33JLbeBrjrfUmGFzXTsUsGZm5IgThG/l10m6KrQ7BpgFssxgEXigPYlU7fDaKzaP8awscvMkfJ0q9/PoCziWe6IKouId5dre+SwMHQj2+m0syUJCxN8HMYgcqF/9es/q5s12knwUhQBZnYSgiKp2QH3/0HFCmjj+d92jmkneCeI3M2P8Dh6Zw0lgcQ97dk9n8xEKPWjYmGCrYSd4eInUFaRUi9kAjKQnA3IH+ghCkTNdsc5ufz0mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(36860700001)(6916009)(8676002)(70206006)(82310400005)(70586007)(5660300002)(36756003)(316002)(8936002)(6666004)(40460700003)(83380400001)(2616005)(336012)(81166007)(1076003)(356005)(7696005)(47076005)(508600001)(86362001)(2906002)(426003)(26005)(16526019)(186003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:53.4137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e987e2c7-3fd0-43a1-e414-08da19851d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Hayden Goodfellow <Hayden.Goodfellow@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hayden Goodfellow <Hayden.Goodfellow@amd.com>

[Why]
Currently, the 32bit linux build is failing due to an issue with using the
built-in / operator with a 64bit dividend. Doing so generates code which
calls __udivdi3() in libgcc. However, libgcc is not linked with the kernel
at this point in the build, hence this causes the 32bit build to fail to
compile.

[How]
Change the / operator to div_u64 instead.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Hayden Goodfellow <Hayden.Goodfellow@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index c1d540f017a8..03fa63d56fa6 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1242,7 +1242,7 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 
 	cur_tick = dm_get_timestamp(core_freesync->dc->ctx);
 	cur_timestamp_in_us = (unsigned int)
-			(dm_get_elapse_time_in_ns(core_freesync->dc->ctx, cur_tick, 0)/1000);
+			div_u64(dm_get_elapse_time_in_ns(core_freesync->dc->ctx, cur_tick, 0), 1000);
 
 	in_out_vrr->flip_interval.vsyncs_between_flip++;
 	in_out_vrr->flip_interval.v_update_timestamp_in_us = cur_timestamp_in_us;
-- 
2.32.0

