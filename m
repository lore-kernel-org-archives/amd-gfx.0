Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08D7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EBD10F126;
	Fri,  8 Apr 2022 17:27:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B291110F123
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8gy62kCkSBE0hrP/V2seUFuUvViJMYv8z/Mwkr8Ic93e2RdXviKOEuknZj16hSLiST2Pl5ADTuyaDSl5aq/Wp0azvMxfhoU+9o68eHXuVMkOArI7gN8VLCYw7l3GcEQtzvsW/W1Fh/TIsm9hvbjFWjmcBEHxtahgGttKi/kSmsoYNs4gjWZLSvnuY5szlXojLLkdNUiYW/ttag2HcmLqlVVFa1YeOv5MJurpPzhDwrmS5+nA84UaCN01Mv6+sppRPu4xa/r8sZ9tNLXWkknd6QBeXYh4ZwD+xrT9isrPE4bqIEfBfkpCWhrh+pAitgqqYW8cv8COZ+uJ1J/XKB0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y43XIHzdJ+1axKb0nXoCTTcoI2+FNAFH3T6RvPHS9KI=;
 b=Rq9W810HtutrB0cdcaaqgQf2/43lIixCwKNRVlRUqLul98dQPwLJQB/J/KTBhWIh1sdvUkzpiOcMiFUeGwTMgv0mQU3VOuY3EgQgI5nZHzsYOMB/TdJtVLlkDQIjhZ43lS2E3h5N2gfH4edSFJNDwSfcGxSuQydaKFQf3UeQmxBU4RYprsNAnBOUUB5CcueN9Sa49negEo/zFl0/EhDyUdgti/+L5/QrC4wHutJX79WXK2fbRqffqgyz3lBYPt8g0azAQ4u7sYYGQjLA2eOORy52kDElqBAtAlnkTxyjpvM7bJqN3WavUJMrjH5NNZTFHpXmxu8viv1wn24LxxkvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y43XIHzdJ+1axKb0nXoCTTcoI2+FNAFH3T6RvPHS9KI=;
 b=z6u7MxPyCQYDIr/PAm6k+xHxuOecox3w6FaLzJFGI2G8Dme+1dskU47Lr87CrFXgH5l6uLFAOkxi8qrcNpKC9og8XT2iXnLwDntzj/Y+KJow06rCCo1F1b3So/GWJOkU0/M2Q/QD4xILpgP2A7N74p/mP94fMjPf86bNQpK/l2o=
Received: from DM6PR07CA0131.namprd07.prod.outlook.com (2603:10b6:5:330::19)
 by MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:27:49 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::fc) by DM6PR07CA0131.outlook.office365.com
 (2603:10b6:5:330::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:48 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:42 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/20] drm/amd/display: add DCN30 support FEC init
Date: Fri, 8 Apr 2022 13:19:04 -0400
Message-ID: <20220408171911.601615-14-Pavle.Kotarac@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5975616f-e159-44d4-8c0b-08da19851a27
X-MS-TrafficTypeDiagnostic: MN2PR12MB3198:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31989449924CC92FD84F5D9BFCE99@MN2PR12MB3198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZiPxd/4V1WFOz4Vk2GDF001AT/UDRnQEaCDpzN15x0IeyFlYFyRI9YCSwaBcxI3p9X+fSWWWRu5W8ZO6/odxJIGBD6djAUu/x/LzYSoTnjDEFaWKRVsLL1hVbUv/3nLSgT3rb1xYIcGKo1w/Z8MoflbOl845XA5WTvJzWfNS9k6uy0pJ6a0Baw0ehVTB74JOA9DRWiWKuPk8TkgBE3CUx2n46hWwniAbSVur6ZRzEQt3AaOlocKdCbYkDsPfm7W9KfmuPBNep7yOoQPvfftnjZhoFtjLj79iQwkKAY8apC6gWGKW9WHxzvoubj1q/+C7JqeXJvYh60S7d3gNCMpni6QLaYYFHxqL4oCb4re+KEUGpXPnkpEd7Rq04k04eHC32KU5c28ivTx5Tg/pfTH7WLtOjUF7jn2Ij/PmfVDAl/vvO1OM3wThLktRDl2E23Gs3WgzbblABeqwU9fNcicy7DsgtCR6hqcDj3PacyqTjj6/oM4yfr80ySPhffZwoKLF893PyDfb1c6BjkTXi2ReYuJObalK5CVwpoUzJcK3ZQI2TCxyIP9Hhh/1hc2KFV8ho3p/QkQiePgcEO/IGvBrG2UpDRUTztvlNGo2YKPjA26ztMm7F2QGtEM8v8aeVd7m9u0nOPwqA+slwLbMGZZkoXaPND0SPB2zvrSqPDCdrZa1MtyjtXxEZEyr1cXbfVMC7CTPTX2bIy3R99/WEziFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(316002)(86362001)(4326008)(8936002)(36756003)(8676002)(5660300002)(82310400005)(6916009)(70586007)(356005)(70206006)(54906003)(508600001)(26005)(2616005)(426003)(336012)(1076003)(36860700001)(16526019)(186003)(2906002)(47076005)(40460700003)(83380400001)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:48.5396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5975616f-e159-44d4-8c0b-08da19851a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
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
Cc: stylon.wang@amd.com, Jingwen Zhu <Jingwen.Zhu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Jingwen Zhu <Jingwen.Zhu@github.amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jingwen Zhu <Jingwen.Zhu@amd.com>

[Why]
FEC init used on DCN30.

[How]
Check fec active when HW init.

Co-authored-by: Jingwen Zhu <Jingwen.Zhu@github.amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Jingwen Zhu <Jingwen.Zhu@github.amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index f61ec8763844..782b8db451b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -535,8 +535,12 @@ void dcn30_init_hw(struct dc *dc)
 
 		/* Check for enabled DIG to identify enabled display */
 		if (link->link_enc->funcs->is_dig_enabled &&
-			link->link_enc->funcs->is_dig_enabled(link->link_enc))
+			link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			link->link_status.link_active = true;
+			if (link->link_enc->funcs->fec_is_active &&
+					link->link_enc->funcs->fec_is_active(link->link_enc))
+				link->fec_state = dc_link_fec_enabled;
+		}
 	}
 
 	/* Power gate DSCs */
-- 
2.32.0

