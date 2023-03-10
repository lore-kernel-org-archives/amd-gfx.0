Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E17CC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402DF10E9AE;
	Fri, 10 Mar 2023 09:33:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAFE10E9B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0Rh84VBNOb9hXhyQetsXUGeJg5teiQ3tU3T1eZp86MRi6ejJWWmZGAKMc6ob57+Ksk2o9vtJx2MIj41X/E4p6hOkPJykIUCGqDM0Q9b5NWQp2F9WL0LTtGkG5EJJW9h9blnKqq5BolKSZeMWaXUwonR/cVMOQIX/GZdGau3NzjELSRFAF0GZ04KxkW7YCbWsnRDH7IxYWgnoUHz65sUBhRf0Lb8wQXQFte9UYbIZL/k0nKiK8132nhWmWWA6bMxVMyWUaleNU5JFfwqG0+pdL/gSw0Q3qySIv2qzXrWLXcEK8KqGENBtjHXnNisvlGunVegLLrQLs99B0aBc/f+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4zP+GfD3iAMKuLiGAKvsxmH4zLwk0JpGZt7h6ZI05s=;
 b=G69gRPnhJYRH+VbNFL+trUuzoR4qq2nYBLx5vh0Vm5T+4kP2wFZBi5iqjj0OHK9lQy1MdDpU/yzxOZEeICS6287BGL8oif1JV3vlL8sojb9Xc6zlCZQXf+29lptSft630JVDD5Gj+kmGU9wiKLojmPgrdors0z3BTd1aOm5q+zxMm+Ovqds7Jg8HzopDRolWzNFmD7cSz3/Ruwg7cl0/wT9QeXZnrF/Lcxvw24HKsNWLDqj3i0Emu6Wow+b97J3qnkJl18KgFkf4gdzqwu1JVJLjjViX+vAGHU5nnLdSLKcjcvcHc+u0d3JhU/bCzvm6YjEl9xdrIif6+ISZEaEoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4zP+GfD3iAMKuLiGAKvsxmH4zLwk0JpGZt7h6ZI05s=;
 b=k7Hb6Dw0tUvkI07kc5Pb9vBCNuI329ON5rPafDZdK8f8kZMAQXuLho+mT7EkFnXAcEwvIYOglLnbZ0nf1J5TM99dp9HwCb762GuNrkx+T7aFiQrDBm5p63/SU1RR/+Ldxx/E9xx0aDRAG3q0qIFd/fRujLOPyj+JTdUcLy4Dh8w=
Received: from BYAPR06CA0004.namprd06.prod.outlook.com (2603:10b6:a03:d4::17)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:33:33 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::2a) by BYAPR06CA0004.outlook.office365.com
 (2603:10b6:a03:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:33:33 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:33:26 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amd/display: 3.2.227
Date: Fri, 10 Mar 2023 04:31:17 -0500
Message-ID: <20230310093117.3030-20-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A61:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bf7e15-b2ba-4d6b-7a19-08db214a842d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4t9g+c5XQAEVi4Wl7mkMuaQ4Ir2P13ard1UIfWz6ab/I3mo8VuiWD2JFn3+cWPhut/qiuyFltD+1Op2oMSmCSiYD7Zalw8EWQljjcgyEX7gdSs6gIwSsCbffWUdD3AROJlPCIaNEJHGQCfeJtc8n7PnCrUiL2JYT3A67r2yuYLr+8FREmZVfDyBHwxJgzZamNSFHzR98eyjjU/xYli3UR5Mvk215tij75tdXCvd/a2c2l2ATEYgFuTeabzkUSbDJ3Smuli+CTZG5ASqu13HvNCGiCxQwOd1McyiQu6j7/vY3ut5x8En5cUnwcCYPfd6PSo9Wt+XZuZemlQ6Jj66Okt6nNB9/pUiEPafoBhlPWZZz8KIIk9Gnj8rytkUs4w+Iyx4ZYl3QmbckfRL8c7EsUkSvGFsMZ6mDVTGIUc/1ycNi+V+FZrPe9YMKkCUnfsWJs6jHKNv3nr/bMX+QBsSGX9YN7WsFK8w8A8u8u/Xvu9QmymLaFmUvarVRD9l/gSs3+JJ6Rv8JGqeuhtEHPztOg5JViuaaFig584HFuzn1dUDCbFSHWie+lRPiGiI2/RSbGCr663caQm6tB11VWKGfkfn3xOmIcGudcRwUR86V1H4qXyfJ4G2EUwnD1aXzxD337MEmzr9bCH8qTGAZf9GYgdrEJ8UZIft+GM1VveKaxLtiyQuOzZQrSh+ndcXJXWmffhgSAj2DCOcItV6v3G5m2B+/GkxJJQhiGtC+9zMSltg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(54906003)(478600001)(4326008)(316002)(5660300002)(8936002)(2906002)(44832011)(8676002)(70586007)(4744005)(70206006)(6916009)(41300700001)(36860700001)(356005)(81166007)(86362001)(40480700001)(16526019)(83380400001)(6666004)(82740400003)(186003)(2616005)(26005)(1076003)(82310400005)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:33:33.0207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bf7e15-b2ba-4d6b-7a19-08db214a842d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- FW Release 0.0.158.0
- Fixes to HDCP, DP MST and more
- Improvements on USB4 links and more
- Code re-architecture on link.h

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3f25a1620f4f..2818483964dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.226"
+#define DC_VER "3.2.227"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

