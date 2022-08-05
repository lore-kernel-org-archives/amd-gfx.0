Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4866CC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD97B9431;
	Fri,  5 Aug 2022 18:01:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88738B93F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG46yT58+RzsgaQQW1fzyvLvQ3rfM6DYJcvASgXEBkIslOjo/310qqjW6TsQQOY0/+mg8SKtM3ePpE0taI10aM6gMClDP77heKZjxnpqEUBsaPO6yQJAcujcoZ4ajb7ACUP8v1AMrzMIxBFRp5ASVNX1ygx2C0DqhQdl0l/dU25XK0ZdA6Y/Z9Bd5msFa3EhRcz8TtFljOP2fqJcm6OrT4fYuX9ahEqtGHH8qeBA7q8muIDDgwEl9TbzEimBN0P/NgyLZueH8EkIBEcDrTZvlFN/rRdYFq+SSOO0ASd/YeE+xtPJ5Grngc2lVZpZewSW7Twng+BLrdINxONYiQJhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugu6UCYk6M0YyHInxAQLaMhDGHs323UuwTtbeNJVSF0=;
 b=PvQ859z0F4eEU0HVCW/8IA9bPhyZRuM6YSV56074l9c/sz2DOr1Ud/VQXpBSzWUo46Ie5gCDu4J7WzLMRoZt3UF6ttdgqk7PriXCKZOtlIzMOg9u0LOiNZpi8UTrNA9pR9l3iPAChUFbPEiCSeZ553lgXdH2G2tNftLbvaq/Nth48WwzOdYXTrFgYfEfuNdwKmZoz4l20g+d7btAQIFW1Yff8Uha/27H6DjHJxzMYAfJgPg4KbYScmfQ+LNQasq5HgOmOQB693WzrVXtiArXzQBchbN6w1j7peZPRZrNZ0S2bhKNv+kcMdAnvLK4V+QboV6g3GKd6p0MDSFRXvse6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugu6UCYk6M0YyHInxAQLaMhDGHs323UuwTtbeNJVSF0=;
 b=zLNLYbI9M4+4yy+CjF77g0BsPxPqAnleUYysTTgq6nu7UGeAF5ileXDZCMGkPenOhfCUHAnEIcA1/7CMKwfHMxq1KqT+pzi1a1F1VpJBDuyIYqzgAIdM9RkrBu4QsXtSRGpe36Fx0npDRxA066Kv9xMma2MfCiZpp1EqCwlQscE=
Received: from DM6PR18CA0029.namprd18.prod.outlook.com (2603:10b6:5:15b::42)
 by BN6PR12MB1492.namprd12.prod.outlook.com (2603:10b6:405:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 18:01:38 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::f2) by DM6PR18CA0029.outlook.office365.com
 (2603:10b6:5:15b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 18:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:01:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:01:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:01:37 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:01:31 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/32] drm/amd/display: For stereo keep "FLIP_ANY_FRAME"
Date: Sat, 6 Aug 2022 01:58:22 +0800
Message-ID: <20220805175826.2992171-29-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a419f83-4fca-4475-c174-08da770c8b1b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1492:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGkO+PcDgo69Uc5lHWOBriF18fVZKlCYM7DV0CCXH0twQPz/izoRw3G545h4fa2RwrlIP3WzU8AbMuIgU96cixFdK87Pt+klmjLkw1SldBL6VuE7rheCOXawb5UQGgOxR61zqubsyAm3jBlgpzPBYUYq8rphzrPV1Eake97lzpBbI4RflDkDECGWxu35ZRN+knzi//C8YDxgClFfj+9RXjGHmCOkXrzmzwynkE89DeO5wAVYay+X6HIjo2tsNXpGQ1Sv7dZDxtT/4hnLbYLW23r8y7ZLOTlJhf4OBVoCziCy7G3OsRvYVNu4/JMpuwnqasKXRDngIliNxubDiIQhitsj5kCd8RzfeteAVHvfmtsXL+xBreyxZybNdcZUImOY3dxA8jT19hA1zpSq+d+BNPMDd/KLrZyPW4xf7oUMqHvdXt/7eU9J5miKRhhXQLBrODHMgeGwdHF13nxzobBmyQKB/HrAwOqgSnaub3jWu2LdaATwihAfBQ/S2wG90DRoREg1GJ0Cy434iNd4grEmZ80SgL8ALqLgsiGF7kmbjJPnuq+dYm3dIHRpnQxvcbBhz/cwzhgC33T0+AfWKy8erXBHJMq4zb3ru53oc6pAmhtFaQoOdybSatdfiuTdqbWF8oVUHkMz8wipepBDP1Ap3Q3Bo7eWoYdmS3tVvvbNAi3lbEtJkAT0bLR1kpH0Y7/f5GuK+jbRU3Mzlny0p5DVR82ILf57ohpbl5Ji5cb5sYuED5YQN27K5zYDyI5ezbnYCEX46umtUpQdfskZbYggjPG23nzV1Tkasfo9xq8B8wJprPWfvfWzfG7AW4BSLegrdYk/3mRUlCJdeR3jK2H+tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(40470700004)(70586007)(426003)(1076003)(316002)(70206006)(336012)(6666004)(8676002)(47076005)(82740400003)(41300700001)(2906002)(8936002)(81166007)(4326008)(36756003)(86362001)(40460700003)(356005)(40480700001)(478600001)(186003)(83380400001)(5660300002)(26005)(36860700001)(2616005)(6916009)(54906003)(7696005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:01:38.2574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a419f83-4fca-4475-c174-08da770c8b1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1492
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Observed in stereomode that programming FLIP_LEFT_EYE
can cause hangs. Keep FLIP_ANY_FRAME in stereo mode so
the surface flip can take place before left or right eye

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index 6a4dcafb9bba..dc3e8df706b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -86,7 +86,7 @@ bool hubp3_program_surface_flip_and_addr(
 			VMID, address->vmid);
 
 	if (address->type == PLN_ADDR_TYPE_GRPH_STEREO) {
-		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0x1);
+		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0);
 		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_IN_STEREOSYNC, 0x1);
 
 	} else {
-- 
2.25.1

