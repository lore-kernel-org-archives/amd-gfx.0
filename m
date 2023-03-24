Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF88C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A7A10E4D2;
	Fri, 24 Mar 2023 06:52:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3479B10E4D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yoh+wXvsa4EZJQez2jlGi0ejWpEj/I2zV3PFMKtAg0RXU0HCU0uMpCi7uOlMe8CZwFA7yweUiDt++4S8VpO1fUx+WkGV3XkrjCRa7uDGx7f2KjUSEiX+52CHJsqcXzKM5BV3uF6XUc8T/Y07tpMUrae65gCHKIqOvcG5vJI1n0OgbR1YMBotcW0lF0GLDUuglnPjyRM26GIIpEi0Jxd6tkHYxPwwo8AynGCvWW3hLWvaXVsr1s5ZmEYOVKJNXaCowjo8S3bF2SIXD7/4IpyETVXRUPqnKKMlrMfRkqcbNHtmvncORqi86OgKGY3IZ/LRhaITjXuYrdlg/7/8Nz83LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qaIpUx054Sq4eJNn4jIJ6HwV+o9n32gyuHltOw7bJw=;
 b=LRQwUmUg87fOOWGhQZpiW1ezj2zXXAWEzbOXHyYqouJ7cbYR9DbgDluodqgowVZ06rwNCjUjep4YuP4C+idIbtyfSjTNpPq+zvpsY+MZPNzBGad/UHM06u/F70mrMh+pK2mKiVncu/15muIjVvXvdSXTKZgrpfV08w1pCOeEId/vP8UZXVF3b1kSC/CQN3yH5VSYDu5z7KJeaa2bn4sYJirIlM6IzN9bMJggiLcpwKyrRNMFI2CTuWcfv2PC/2h9w0U92Pf+4nPktJmjaJLrYWS3ZE7L9cyydBzyLLBB1hdJVlxvXb5OKj1J0i2wYf23eb+gztxWZkuSiepYdL9LWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qaIpUx054Sq4eJNn4jIJ6HwV+o9n32gyuHltOw7bJw=;
 b=gtV2iIA903P3GzaJbMLgDrutzceeOHIGGG6rO3QvbjeW0jJLbzZpbxQgiH70sLjlNEthntpdaxUkYjM7EamyIyVBXPLOFqZZUInizqY1KPMhrIvsl2TWdah6ivx2O4pDqJX0S3mWkINkHEHxENsFBs14mRgebOXjRyPdfqMSUVs=
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 06:52:01 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::93) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 06:52:01 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:51:55 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amd/display: Update FCLK change latency
Date: Fri, 24 Mar 2023 02:50:55 -0400
Message-ID: <20230324065111.2782-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 9949e5ba-5a72-4455-8486-08db2c34453d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOhOJVyUlkNIGJEoyc+ayXw7Y+FVlV8PHMdLjDj382fYZiGsvOw6J3Ucc2PLrq5A5e5PSvL6/m69B+6GQB08zcLxs7RhAdqf+v+1RlZeMtcaegvh0ySi1G7mrOUaz2pdXKq8H/kstvGCEm1ZqGUbjCFFe+M+F651iymnt54xDHL0IrVOfrC5VRNAaVcGYozQqrnAnWuICieytY8DzC8zsQzPMHmr1dmI4NsoxdUzS2vCFLelhubOuOa7YzIy/obVAZ95qvl8/XwWih4u+IGtwDK+JRb8xtdtH6UbMvKYXZPdG4fvgn821QHsyKn+LJHhb/symc+qnbXxS2WTNFkIdy4ZHmXa98ccEKMSdGS6W5+Qmfu4tI/fzq7epsL7qnIgafqoV+ZG8cTDTBAQuOdRlepQHDHph/9+tRvmYuqv2ItkvpFAVyPkmPiH/H4t7mK/8KjXqLWoSD09DWGhNZA+T4n8kkhXDLYDxL8f9JB9BXiZcfb9TEwzty7+/hrJbGi+/UX6nuW/9kS9c73jEoQsiMcjsrJWeMm+IS18hBFDWmBTRgjo80KxJEG5CMVjpNfNTaWOGuKA98b/GWTsbOn6pe+YZ5XrxZNgO8iVSDloPomzj8a4plzrKoiEVBtaS9nmRugt0AIPSwJCpdKDLdOuYu1nQQ0QivoX4tSYIxuGfdaeK1+P51+zNvI5X8/5JG+6rYzRV96clqZA2KaOWT+ql2WqId5FBRIF2Q2IO49C9l8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(40480700001)(356005)(2906002)(40460700003)(36756003)(2616005)(336012)(83380400001)(186003)(16526019)(478600001)(86362001)(82310400005)(70586007)(36860700001)(6916009)(8676002)(4326008)(70206006)(54906003)(426003)(47076005)(316002)(1076003)(8936002)(41300700001)(26005)(81166007)(5660300002)(44832011)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:01.2919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9949e5ba-5a72-4455-8486-08db2c34453d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Descrtipion]
- Driver hardcoded FCLK P-State latency was incorrect
- Use the value provided by PMFW header instead

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 4e17f2c8d2b7..6ab60facc091 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -131,7 +131,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 	.urgent_latency_pixel_data_only_us = 4.0,
 	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
 	.urgent_latency_vm_data_only_us = 4.0,
-	.fclk_change_latency_us = 20,
+	.fclk_change_latency_us = 25,
 	.usr_retraining_latency_us = 2,
 	.smn_latency_us = 2,
 	.mall_allocated_for_dcn_mbytes = 64,
-- 
2.34.1

