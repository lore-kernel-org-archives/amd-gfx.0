Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B53BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81E010E1A0;
	Thu, 28 Apr 2022 21:30:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894AE10E1A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aglo4C4iqgZIiLs9XIv2n1gDQbyrb8N7CTJpTSvYPtnth6/0p/cniynVYmmcaawltdxAt2reGMOLdHxZfrVcI5fPPA61kBGey767SPVdTOBn/79vKJCePH9O6yOmPjfUXO89UM8Wah5UeX/HR5d5086eDl4y4R6rHuC69xWbGS0gl8jVEVFUurTtrHZ7W/fv8cfumQ1dUVVsrJYnbbAXj/4yNirhDK4KDbEb66dsVuAbK7Hq/8ULNluKvOZy1ufW1oNHfzXFE0p0gXUlcBfNYcNQTu7uHjrP3fG8cVyVCa9IZhal03zy9QF7hGhDeD2ldsBqD7NhKph1N+0R6Rt47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H71pVcnB9+KckhmY3UfmagzSkViJdQXFa9548HHFmQ4=;
 b=ANnUs2my3p4t3vs6dSnTew43bxZdb3Pp+DuRm0CcAyGx9ERvVVpWPbCXKwLV/6V8RtOfUBSmha5Y+ScnhL01szM0NbrXLxT5Rr2pawqQmNhICkSFBmr1l3TOGYa7vcOGPCIk7EzH2B30yVzyq16H0cWPzCnu1xs2JP1Uzfqq/6Gbj9hyQJ9QRD9JnPz06OjfjT9f5ihuM3KAd2I1JJjqPxY40TSbVKcvUO6aJ1Aw/rPlqeUZqxlR3AtXv27+pFmKVOXpwkSOzAtvU5EfWiCmwWETWKFk9AOqrOkjKTl6bcT1Sk0E4j25C1lP8bNhqLcbxzw9yr/ib03cdXjUTQudnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H71pVcnB9+KckhmY3UfmagzSkViJdQXFa9548HHFmQ4=;
 b=ncSWMcWG1GWiVhI6RTCxVWM8UhXHWC/30zwXQFkAWEU9hwJK0AAz5o9DWM6O30YNn2M/2jzbw2l66v1n5gvesIDd1v+SK5UjBLC4VwoJ/YnmSX4FFiusNgC3KDZI2C+RXPZKhAjr7Jp4wdhfR3V8oU00W+9q6urqkQPcbVcdtSw=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by DM6PR12MB4715.namprd12.prod.outlook.com (2603:10b6:5:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 21:29:59 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::4b) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Thu, 28 Apr 2022 21:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:29:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:29:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/smu: Increace dpm level count only for aldebaran
Date: Thu, 28 Apr 2022 17:29:35 -0400
Message-ID: <20220428212946.700296-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33f84d06-78e2-44d8-3dbb-08da295e3f4f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4715:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB471536CAE8433BE0D4CA5142F7FD9@DM6PR12MB4715.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9xdkXZWfl9iouhmWfH/utrb5lS/yUfpNavgucf+6Z8yHU3jmiQW0tx73C2YQFuxfx6bQ24NuQ/7ieznInJtLrr7+qq+aZWTqDwR2Im4R+Jq783pTmR+JL2n+Fd4+6At+7VqXrpwZe11SmibXcu4LntXWwCox80eMC3NUuhBq+/9FQOWg2iZ8E1JfcKATjmrvb5dNd5TqDOk+cUpdVyvsdT5G95lhEUuBBsXiqJWtgSeOKcH5vLWoLX+2EE3zZBorVe+sfZztH6VNeGEu+7X1XQf0w4le7TOPG6W9ezfvp94xu5W/QQRaaADof2s2kPrEkw1zx6CJcZcjuPTFNnMXypoeylM4N4WN3p6SlluU6lzhAsGy2GZds+q8bUlN/Ofdj/6o9whU66Jc6abTssfN3KTMgZIXSO2f9/Wqdf5ZfNEkAW4OFa2QO5ZSP4yWXepdxzAYqMI+7x7eYl4jQV10vlP1rC5GnbHRB5VPHLbcfMdEx1HDXOOA48XS8P8VTos0EM6rKTbLPVWy7mHjNCUF9rt54ZytdNcHJ4VP/UlsbLeDVP1nR9R+QdPB/dEYPTXY+sZUeMKXaLEXn9VN/pyk3trCtYLUyQ/vprzys2bJrr71NSZxYSsu60Q3VzKOeujSWX4DdQ1oUrOxeK1bGqVJ6/78YUPkEfAc4DQ3rRmQpHGLzFkHPixXO9BvVbHIXBa7q5l83kh6WGYAEYXtwVCYWPD38aZd+vyR32LumuqkaM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(81166007)(356005)(6916009)(2616005)(5660300002)(8936002)(186003)(16526019)(6666004)(36756003)(54906003)(40460700003)(47076005)(336012)(1076003)(426003)(2906002)(86362001)(26005)(7696005)(36860700001)(8676002)(4326008)(83380400001)(70586007)(70206006)(82310400005)(508600001)(143363002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:29:59.0450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f84d06-78e2-44d8-3dbb-08da295e3f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4715
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Only aldebaran on SMU v13 will get 0 based max level from fw and
increment by one, other ASIC will not need for this.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf09e30bdfe0..21b1187028fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1750,8 +1750,8 @@ int smu_v13_0_get_dpm_level_count(struct smu_context *smu,
 	int ret;
 
 	ret = smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value);
-	/* FW returns 0 based max level, increment by one */
-	if (!ret && value)
+	/* ALDEBARAN FW returns 0 based max level, increment by one for it */
+	if((smu->adev->asic_type == CHIP_ALDEBARAN) && (!ret && value))
 		++(*value);
 
 	return ret;
-- 
2.35.1

