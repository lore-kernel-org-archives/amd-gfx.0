Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9BCC77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AC3E10EDCF;
	Fri, 14 Apr 2023 15:54:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1960A10EDC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOOxD7fYrbi56zufDZc2A35jsfcGgZ0OSXxcyx7ezZldR5GWQ86aPjHqHz6Gv2hiFu5kP4Ct+A2hN3FRe9krI4uz1du7DWAk69uE5xlxB20kWZUbMle2uRCUseTceuc09UPqGgGKn0lRgnugaUJ56XDqCG6BfoLDMCVUGXDj1BV/chluRtgr0lZxGC33rTqBoRTcQfRG1eZm67vz1IiXlAqJnNf7NMzZn2hA/zMldz9KGD0SI/rU0tIzzo0GfwQB19IDkjXRRncs6/7b0Ttro3FTPuWwBkXnZaMctEH9bWKqQZWfDVWOGdmkcxY/IFXu383hcr4hIRxyPlTjXgTSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+Ro55udRl8eeZIA/Vq7Sm+0V0HpEfGt/QlFflR9xWw=;
 b=FSEggWxGW8agx2HWnEx5mufl+jYiheW7dQkX0EbedABt2v8SFnni1cul9iQHMpqsEeQmFEAwvmfuK84Q36T+vWX2QBmsRz/cEeVro3jDG2p8mulmrgvbkHMJUpGI/KF+I15UWWLHuYeyBrMdszwC4Tw9cUvA01hTM9VpsWeQjsZSTqJ9685jPkbPILUfGYJcmF22pBUKtoBU8wQB2mTSVJ+7LgqvGBoEmLLSmPm/FRevMOdB78JGgcQbfzfNkDGnYIh0KLynfpls87u+w+d3qmvo/6/zIwdDq6hLj9kDX6M6jZW0ZgUEKvD0u6BlwDuZOEPshXXn4XH1BibRpX++bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Ro55udRl8eeZIA/Vq7Sm+0V0HpEfGt/QlFflR9xWw=;
 b=pen1kA/nsU9NRpUYRceDD5T2s1LTCHw0+Nmd6405vfGEh5/ooZBuzynBra03lQ/HUlsImMudHcxEZMBv4Mefk9J2C9i5dh1YEUZzrD/4HR8n8mOljdzG8xCPE2ZbuFB1PPNhBOQVVwIvleW4J7aB+n+gIUIi3K2JKXooo2uvxH0=
Received: from DM6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:5:1b3::15)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:15 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::17) by DM6PR17CA0002.outlook.office365.com
 (2603:10b6:5:1b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 15:54:15 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:12 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/66] drm/amd/display: update max streams per surface
Date: Fri, 14 Apr 2023 11:52:42 -0400
Message-ID: <20230414155330.5215-19-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b97f6b-0ac9-4839-3abe-08db3d007fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzyAlQDl0IIIpezH4xbeJ19VgTC18ow8UJqm0UBnCJYwritD5gK04D3tv/oPdoTZXLudNbbVxhhUFS+Z8jGODSOgM8yOIcoEF8UxqkZZvjYzsQa88w0y8GkAc9kVqWyra1fec79JCggn72eH8W51VMWCpkt1NS7zUAN905CApoA8tiaEQ4V8/nVBrX1qxeaO702vqVTxDxpDqReGCggItb8KcChTnAr5iuboDrPPqtzRAKE8uyV2/QFY4oSvczFuZ7iWfIfVlOiKnfSKP1b2XpsGzjb7hMXPriieSXY0jm1+NtsrpO/0lC6bz+1+jOYB1QVFd1gZdxCzMFeWJ1ZrQsedbxypSgLlRYh/jdVZN7zPUksraiyqi/CVyVv/3pocNoQdlDs+x7680GidaD+62WqOdgilVLddLnJ3zuwz7WPppFDa/QAriOsr6mPDjWbHVNHHb9hVctJUQC2XFrwhawoYIDD4io6AGjI/KwH7c0slIxUrZjuHhevXnyV+f2zTe7/I7FO0Rwl4jFpfhl7VMfQKqsEFs5uWCXMO1nlEUczHymDY90+ykpIT5rCgiIMrX1sQMQX/bsjK8dKp1Q2ROIesYWdbu88x43//SBEXWI3f9sn2lBRnKkfKqOLhLNpqJGxBp1A6PJ2SFHTzx3x0VPom4b8x/qi3vAT0mAng7pHSi+ilO13QY+p47MgybSU+cgGHhKZMeaagKgIa7uk382VBrU90+OY33tsv0LlyXKw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(4744005)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:15.6840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b97f6b-0ac9-4839-3abe-08db3d007fde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Increse to 6 as that is the max surfaces supported asics can have.
The is no practical use case yet, but this is valuable for pre-si
validation.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 45ab48fe5d00..34c848311455 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -83,7 +83,7 @@ struct dc_perf_trace {
 	unsigned long last_entry_write;
 };
 
-#define MAX_SURFACE_NUM 4
+#define MAX_SURFACE_NUM 6
 #define NUM_PIXEL_FORMATS 10
 
 enum tiling_mode {
-- 
2.34.1

