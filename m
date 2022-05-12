Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B799BC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058D010EF8F;
	Thu, 12 May 2022 03:23:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EF110ED12
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxikFTX0bjYczqp+VJhCI9VcbNQcMmhPd0A+CNYlCs9S0+jnjy1PB8sTYWYxasXB6mNkU3Ae01uJ/KQbmq/6E+I+xakdtaUA7aIO42ordhuQjK1B3RWiX9VuU96uhr66ut7qTWq9QgHKrUHyzCLgnreACDRLLNSP1u1RkUqshH67E3eRbUktHrHVJtgwn2xdXLPGQIuW5LNb91cKynMbc9fmwXFs4ozH/MJbJKbH0Co9yweYx1Bd/G/l22GxwRrE8R71M4Paisa8tRcp91zTiUfMONm5diobAFBaqexO0lts+zp6RdBtWgP3Eq+12nr64yUZ0ZfwWLi1DdBx0lmpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34EOEXwuPr6u4nURvnW06Liqkih0aX4pU7+IB4jiXUs=;
 b=DBoR46iRn+sm6wVqyCq6tlgkD/hwaRLbv29BoYWEVHlFGRvok9YQiBA6/D1Uf6HUoEOUlLw1CEnLnNPaQlAbhf0s2f/GgXCXNVPfXyMQN1ct6k/CBV3GuOw+3jKLtGdTf+1ycxGRLV0jOThVAlFg+HO4/b+wGBPThrtJdWf9yw5KfWHbcDMz6dr6NwCkdjGY6OI8UxzqCGoHHx8y5eecc55i7JXlRjtmWZO+r7lktql8zvmqkxNBCqStQFAM1ceGTFPqX7xwkXqcWc1WG+pg9XmWTxE0Tr9mJ5oLQsSBxdDBa4xqhnhNhGN1hQ9n9lRjlJloIyvIvOtPD/VsW4Ba0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34EOEXwuPr6u4nURvnW06Liqkih0aX4pU7+IB4jiXUs=;
 b=o51MggUwx6/oD9MOWGSf84ENVE0LR+EHtjjc24GmBMhspfsYT+OTg7l6N/lrH+ZOhmyO2jhqKwsW8yEHur2s1ySOcW4j887JjuMN8rznH/nWSI5+FiGVwkGvSBvJTHKi0daGNLEeam3aRK1Qx/Kn5EK+EdM2M7X1nIxe9yfpzzY=
Received: from DM6PR11CA0071.namprd11.prod.outlook.com (2603:10b6:5:14c::48)
 by BYAPR12MB3253.namprd12.prod.outlook.com (2603:10b6:a03:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 03:23:03 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::b7) by DM6PR11CA0071.outlook.office365.com
 (2603:10b6:5:14c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 03:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:23:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:23:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu/pm: add EnableGfxImu message dummy map for SMU
 IP v13.0.4
Date: Wed, 11 May 2022 23:22:41 -0400
Message-ID: <20220512032247.528556-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512032247.528556-1-alexander.deucher@amd.com>
References: <20220512032247.528556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb09be7f-b232-47cd-2378-08da33c6b97c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3253:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3253967F068F55CE582976A2F7CB9@BYAPR12MB3253.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hMFadtpWVboxEZewzE5GmyjruYKERSvMyMbymQPTG/4AG6TMjadgtFs8L3rlQGS01Qv3yaUYVvMQt9xKTZxltMVm3+D18zb5WDuIPdK6Z3v40TnmsnzttLQDM35k43Dym2rRlvtPZdFX1J2ncd86iir+B1DjhO1ktko+FbNswKNY3ZSQPlXHjgAer0orLTISbKnqNBMhnOwfQ2LqPL9mdBWLBVlbf2/zDB69/aRaiuOAdao6T8xrbDCgPqErDuY0lqUqCRGs3oeSrjtZ14jGl2d9AyG6/IKa1QjjjaY0gt3mddMFY33AJXZnktwIrKjAZrdTsnkK//RzM3ZqYlq+x5oLL8632orXi/tJ641wxy37qluzwLD4lG+05a9Y8Gg801bQ48Xw7cAaJH03W7DXtxVFaZi4GvbMKO5I16l412TqEi1Lt91f3/+aHdowWue7YZsdTv2seeIpTZLQOKCGvmKPkcnrKj/ZH3ISUpX5GRY8iTtPiftMYA3WG3Md7m2g151bBhPwoD9HY3n2qKQmah6enErLVveDXwPBnBoBzseVXFI9dnIV51Q7Kma627PiCtPJp31v/iXm12nxT66WSZ4KfrtWXgMQ0O/SOXq968sD3yoZCXZqytJXPfB6hSgWj4Onl+bzvp99XWDmAJlUB3t0myD2AyoRi6oe8TQhJlZ4Jh7isM7S6yIYXqioxCxis41B2g+g1lzl3YPBTc+SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(70206006)(316002)(36756003)(4744005)(8676002)(7696005)(4326008)(82310400005)(336012)(70586007)(6916009)(6666004)(54906003)(15650500001)(5660300002)(508600001)(2906002)(40460700003)(47076005)(81166007)(86362001)(426003)(356005)(36860700001)(16526019)(2616005)(1076003)(186003)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:23:03.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb09be7f-b232-47cd-2378-08da33c6b97c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3253
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <tim.huang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

The SMU needs this message to trigger IMU initialization.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 799050ea7515..a1cb8e73e171 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -233,7 +233,8 @@
 	__SMU_DUMMY_MAP(Spare0),                  \
 	__SMU_DUMMY_MAP(UnforceGfxVid),           \
 	__SMU_DUMMY_MAP(HeavySBR),			\
-	__SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel),
+	__SMU_DUMMY_MAP(SetBadHBMPagesRetiredFlagsPerChannel), \
+	__SMU_DUMMY_MAP(EnableGfxImu),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
-- 
2.35.3

