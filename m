Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07BFC61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4702410E7FA;
	Fri,  3 Feb 2023 15:25:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3184A10E7F9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOFp7QEWhDQnn4TvDFzIC1G85yd1R7mvuY0mzEVptppl2YSgG/u/GEW7jQclcDHXfusadSyQyyP9dWsRHivc+kQlTXmCEGuyzuqnieXPdTWTV7yOB8osz5VEg+KUJ7HE1ZhiwMzAgkeXUfBaB3R/VcTQcAiDjnRiGdEDCbPdj+BL+K5Iewfdey9cYwDLvH/Fif64Z4Jsh9MIlHiXHqmKciYi11ONM4CROMpPxLwWR8/Kb1epnXhrvrvO0JB6orEtm84Tn9k+JoUYJ5aelaS48ovBvmRVCm0WAPABCFkokskTscw62yVbozUqprbwoQHPhADF9IRkqNRjWAT2DjDlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/ruU4KRkC0mPoN45yt5LWJK+IGKB0Q8uhG3S9K601U=;
 b=EebZ2QuJdfyp2tSX1hOaXEOqEvOGFHI22aC/6SOQLgxjl4enfqXHoMMxSACqba5h6BO18B/relQ9H8C8529b5klmAN8rO26YvzK2M0WEODffkXF5KzThy7Gz6831T8aXqpWLeWKIExmV4W/+6q8s+je0Dt7GoDfrqdLrp9nNWDbelEKjdGZURMOOqtnTrySBS8WqZtT5M07c4Rq5iaUB5t8ArvElm99PThbFbz2HrZscn/q5D26fKeT3P7AD46DCoQy+LFDT7s2qVPykykZljrd3mDqD7mOgOJsi2U4qo/n6STzMhp13BpQEdvMyn6hsE3rEduK89ebqBSPR8sUt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/ruU4KRkC0mPoN45yt5LWJK+IGKB0Q8uhG3S9K601U=;
 b=L8kWgNmTbEPOr96xK+vTrw7kc0JWoGTn5S8R2mCqDubagk3D/NbXe/1Lfh9h0dQTksrIaxzgLcmABoao1HkbaiMxX93uS/cvfGwz14XjbOQK+qatInMXugNgNxY3jKr7bBUYPtBgqe2qy13wgaFOCuvjkGOixqRbyEHOSPfbEgk=
Received: from MN2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:23a::35)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 15:25:38 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::37) by MN2PR03CA0030.outlook.office365.com
 (2603:10b6:208:23a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:37 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:34 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: [FW Promotion] Release 0.0.153.0
Date: Fri, 3 Feb 2023 10:24:50 -0500
Message-ID: <20230203152452.1441747-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7dee7a-9969-4d04-009e-08db05fae6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fq+Y718R8RDXzSh3R89AlJm/u7tc84Q8dL3fAgXX1uU4J0/n8D+ZpzXRWBb5+1i2EsQd4J8QmZjShcHQrMR+asdJUkFj5gOlRcTW3Vfexqxn0U+FkZ0F6rxmzdQtOyg9AqFMC7gUn21PHOHDZGKpKUvolFWqvtCbew5fpU8dqUSbJCFCfq3tmiOgQaKGECtk7HP0Dz0QMJeUrKTu7jsziiXMZm2UYUh8N1btZLJTBfdWK/xAjJKEIe80fAQLcmnHtXi3QK2vJgEZHJVgz6z8x++vZpYyFAangQW8o26oPvHUE1ZUYt/ibQ6/RB61XxdiDbWy9duBtszXGZJQxSHk4Npm4sM1eNSO7kuLXJpz8Wya/ik0c76nrTkEmFM01BTKDChky9DaFmxaX6GkFLnP40CN9CUyjuwmqb9k7lZOL13xIj6onzLApv6L1WEkowQ2oU7o8HC4VHgG2cQDaex1r0ZYw1gGrFfeWktASz5XKPNmSTRFzn3FcAcp3yG4NmNuBmYq6nHG0FozPJuJSmm0qVR6tkz6vEVVyxA3oI07nT6EagaVfGAOLRvXAmUd8527zKq6e6mg7y2Ubknv9X0xv5v9xtWoY60l5ISNLOXR+Ku7OYlQpjNumen/wzlHFKGyDDy6G47N6glIErR91JYqfrusWMxkXD+AHmQpgQQujrYcvRf7Cv+YAAVmAry5w0irl1DdEmnPZqldmLAo0okU2LiOHNSYbi9CnCDxmSiOckc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(2906002)(36756003)(4744005)(44832011)(26005)(40460700003)(16526019)(36860700001)(186003)(1076003)(82740400003)(47076005)(2616005)(83380400001)(426003)(40480700001)(4326008)(6916009)(70586007)(316002)(70206006)(8676002)(86362001)(5660300002)(54906003)(478600001)(41300700001)(8936002)(81166007)(356005)(6666004)(82310400005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:37.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7dee7a-9969-4d04-009e-08db05fae6df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why&How]
- Reduce reserved size from 9 to 8 dwords to reduce structure size
and allow the union dmub_rb_cmd to fit into max 64-bytes cmd size

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f28f7675d736..88af952b62bf 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -947,7 +947,7 @@ struct dmub_cmd_PLAT_54186_wa {
 		uint8_t grph_stereo : 1; /**< 1 if stereo */
 		uint32_t reserved : 21; /**< Reserved */
 	} flip_params; /**< Pageflip parameters */
-	uint32_t reserved[9]; /**< Reserved bits */
+	uint32_t reserved[8]; /**< Reserved bits */
 };
 
 /**
-- 
2.25.1

