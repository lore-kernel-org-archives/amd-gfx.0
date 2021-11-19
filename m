Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736DBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFAA61159
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DFAA61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D006E422;
	Fri, 19 Nov 2021 19:44:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCB46E40B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvEQ8+l5N1s0ULYfFZvcQ2QtU1G9t6ZjkI9Ehwbw3ZA0LrVynn7obF4Jee5Ylz0vz5UIDLH/lTz/rx49wEUMuwPt97jDpSpdHKy0ry6gmN/pOvHAbzDSESmIRa/98wfB3xTtEcMo0Lw/8sEiH+GKKkHjPzBdewMQburGF7/h9hDGefUX1xIVtZTBse97a8Vp9EjRYbyNpdzO+EAKzU1jdZChlAVPdyGrc+TvxZCy7DuIcCGUqLgKBrFVHtHiWCgW3lpDv5+8fZ67YRCFjEWb8/rbVcZMZIvVnL5QfC8zjxZFFYHzNo96zXOpkku8bjb51qQfL3vm4o8Lr2+HemEhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qov6hoQuIlaMQfnjM1NdcCDsXeqmowccRoQpBmghF4I=;
 b=JSeMzG5Csq7XSg/FudJgAmN7vOOLHUHGMqixSYAXnX0ixN5SVlzIUIijM+VixMSgHJ1aflFWRif8DnS3dsCdToKmzwgLDfLVxPLJVpe6TZmFQnMjuXRoFN4pJYCdBjw7wAR8EX5Q//lrOt93hYYUW7oS+p+r1+sN+Oip9Tw8fCtGbHlaQ9DqOcc8EHcWe9PN7MzC/49njtLzh0UDuqJTELkpLJ7J7sdM7bxnaReBt90MAv6rk3/Qo04Wpir2K2YFjeneirFYvNnnTwooqlbKsomLFHnFzgMKEdS8zuQ8DzaWosdTrLpSYN3SaMu0Fx8iKWUft1QkNSeZtGDJB7A9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qov6hoQuIlaMQfnjM1NdcCDsXeqmowccRoQpBmghF4I=;
 b=Hz6/BENjoU8vsruG0+JbrCPCYiA19cGfOGZKGXgEUnspTJ5YWGZOaxhTSP5x3tuF9I/MI2oRYU06Rr2SDGGd90ljzuuBxkC+M/g8dD+WSIoDkeviJO2i/2L2WDJAM2ggHfjeODZ5Z2qvCflURzuuggaPLIxUiouho5xOjVwL4yM=
Received: from MW4PR03CA0297.namprd03.prod.outlook.com (2603:10b6:303:b5::32)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:44:04 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::22) by MW4PR03CA0297.outlook.office365.com
 (2603:10b6:303:b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:04 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:59 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: fix accidental casting enum to bool
Date: Fri, 19 Nov 2021 14:43:33 -0500
Message-ID: <20211119194339.97573-11-qingqing.zhuo@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 15007a6a-a068-4ab5-6716-08d9ab94f16a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-Microsoft-Antispam-PRVS: <MN2PR12MB433518B955B40BD622710139FB9C9@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+FF5ugB4BJ7Ci6ns9SMBB3bEsQ0iVqzP2PyGFLRKcG1358wnV71p9g9ocIucBbIDftEFfJnX0pkNYEzCl0BbxQX0g5PYDoVqDjaUSvdUIIEphI/a3s8wPojMqIM5eXizKNTHyIiJP/Jj1aNv691OLIsQ/4PMtTToB4lzzlZlYZ/FZG3to2/AUN5qd/ZiKz524c6ewQhYCrFEdrbpBDAhXXH6ejNOEriWjMW5hUWOwtKZLEGIjl0SZeBSa1UHEU6+crjmQDb4LIUG5qMuxS2Elebhlpa3TU6wcG2w+5lXVRLdV+TMUFfaH9Zm4dcHNXBDcCpPAvXsyBTVXaOiDl8+kMn1JCe1qpVDq9C4ErV/gdU9fdlFlqQBPAKjfFWbisBsXQCAJ6oak66XpzCeJSb5U6ecSjLdJ3iBoXhe+wCi1FhIqXkngTeLOFgwc1svnpJgsogASSLxbkyrA/JLCisjjLrQ/Dxetua9py0mkE9L59MDm1AwXM+gVB20y88wcjbUGZXxOMxJs1xka96XK4Qsl+qIntMCkvGlxaBQ+tN9YL3PBptonLuK2dKaStfGfUJf+CHFZRY6MWKiWScvmrKDAtKSXj8DVzvG3ppKziYGb/Lg4DS5RrRfFjmP/sYFyWrAzA5b7Czf7KbOSY1LrQXjARtBLVjtQTNU7dykSpTWsNHXGIotLO4Rt0uoFHrHrt2KqCQl2XBjstB60abRINmYD1W47crLgaJp05togXvlgc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(6666004)(316002)(36860700001)(54906003)(2616005)(6916009)(83380400001)(36756003)(1076003)(4326008)(2906002)(70586007)(508600001)(47076005)(426003)(8676002)(5660300002)(86362001)(70206006)(186003)(356005)(8936002)(82310400003)(16526019)(81166007)(44832011)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:04.1678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15007a6a-a068-4ab5-6716-08d9ab94f16a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
 Nicholas Choi <Nicholas.Choi@amd.com>, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why/how]
Fixing -Wint-in-bool-context Clang Build Failure

Reviewed-by: Nicholas Choi <Nicholas.Choi@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 84bcbf0c06fc..e8e70840a622 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -584,7 +584,7 @@ bool dm_helpers_dp_write_dsc_enable(
 		ret = drm_dp_dpcd_write(aconnector->dsc_aux, DP_DSC_ENABLE, &enable_dsc, 1);
 	}
 
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT || SIGNAL_TYPE_EDP) {
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT || stream->signal == SIGNAL_TYPE_EDP) {
 		ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
 		DC_LOG_DC("Send DSC %s to sst display\n", enable_dsc ? "enable" : "disable");
 	}
-- 
2.25.1

