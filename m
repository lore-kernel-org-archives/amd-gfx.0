Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C39C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D505010E623;
	Fri,  4 Feb 2022 18:44:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5802610E623
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry5pGKXhSE3BmYUd41rp28tKbcP5EEUG8CNDU6XEhnjYVqgqWipsNkVZuGGqb4c+8GxvtuahTXcAt2v/2yvw7SsfX/ZBH87FbejPNw0KwX8fPyWFh8fHjmI78hVXPN771nyhEJoXJ0tdgjohL0cTD1XeXmgRMSfU7EtMz4878f0t0K+ze0X/8+jUuIcnwu5XQB4vEJhihY44DZXIykmO11IRMFrfRKRY5lWwxmqetsHk3CBntQXXTU6+D03XoY4TvHHXMIv5oKhLKiLUtmoeeqyXsHytEzPjiPBPdoJ+b+6PNbvN5kfWUAzwJL1/bz/3eGeBChffY5OQxB9WwSX7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASo9lDomJio3oowD4+jH9I2CpFgbRFVdgCOYZKRmBLw=;
 b=cPZ9gw0dzLELSamnypfA8mH0QCOSwQVn9GdXJtLqAPF0viPTQHlsMfYzADhNgx5UTAMYZ/ilYghjMlN8JhRfQ2nsiECMRsk+J1ypUE3/anyQyyh5/IpwkWi2Lu39x5BnvCxgsd/1BiyCRelGoeq1VNI1FKXELzx/IjDSIKTy6Yfu5d8z6CgVYPpOd2Xl6uaH1JE72QXlDInB9N8u/vOz1dO8+nDeN94phsJcgUBf9Dh1jMrhNph/WqQY4j6/1deJLm9/F7h4GLpkXZ4Jq9YU1H67Xmr0WQmfjdjQoPX0ely3WoaMDZPHod9bDWxooAY1A0LrZSu1rVD2V28N1tu0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASo9lDomJio3oowD4+jH9I2CpFgbRFVdgCOYZKRmBLw=;
 b=S/b7qqqJlgUjgmGDBItwICfRQdbpvapJViY9IoMociL+kFBv3xlu2UUgSkfwG8orjQuZtpPoIjQfTfJSNZQM04sDIJYbwQVVOmjw+xox1Itv3J7HNXho/MJV9M5PDjCCFoG7iB5dbCevF3PBIEgzLCKvq/wLpquFE4d1URe35DA=
Received: from MWHPR07CA0004.namprd07.prod.outlook.com (2603:10b6:300:116::14)
 by CY4PR12MB1926.namprd12.prod.outlook.com (2603:10b6:903:11b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Fri, 4 Feb
 2022 18:44:12 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::43) by MWHPR07CA0004.outlook.office365.com
 (2603:10b6:300:116::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 18:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:44:12 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 12:44:07 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amd/display: Fix for variable may be used
 uninitialized error
Date: Fri, 4 Feb 2022 13:43:43 -0500
Message-ID: <20220204184355.91198-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204184355.91198-1-jdhillon@amd.com>
References: <20220204184355.91198-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af39a9e1-4eb5-4987-a7fd-08d9e80e562c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1926:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1926B408786CC2A7EB84A7BEFB299@CY4PR12MB1926.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/Kq/+QxyrOG1Ke6uwoYH8dYk8ivdvNMiNZSwKwLuFvVYYb9U6GjUq6t0yNU0bzm+84y4V6N1SW7/yMoBnryLXwT57oXw7eoGbZOr5pFpKqQorieRAnu5MZ0QUsb6uEARbNnCIl6I+RX1tZ+xzNInOUpq8hPnBDQ1pW6rmmfy8VcMbtDp+ZS8/eraQtpZl/teKQ+HnaCcGVG13qkrJCacKP5XADLm2ye+BZVXx2W5oikPhi5QiXsVtEu6VTRD6mmEIHzayvd7CqVoYNmtUprthZsX+AJMGCJn+tIxN7bT6ItM7iBDBDzE6bFVrisbQjr7HpoBaWFWkHlaSn+GFLR5ZIqRJk6QxZE5CnhjZmOXdaeaT+X+mxobwwPotiefZX1qbaOa4R1czWD/WD3+RxLLKqNG2kauTpruwsfdaPSW3P6ZMn5Q6wKdXABf9leHH04y+81276jz7PvXcMLOw3XHBAfjNgV0DvD908IK6OgUdxJrNbtDIA44wDtK3c5bmd5ik9hjUhC4Dlow55s7VncRERM+Gh2WE9J4l8YPojOmCP60XwZn7lKtHwhD24d8c2t0IE0y50tnQubjhpKnIwJv8Wmp3Kq2TtDPBF2xCP517mNSdYHLyd2iW+ehvDBYz1z8a0z4aMZa705cYGXOfn64iQdQ3GQ0eMlCq2NCmNeXCQrDQXJu6yVLr45wuA5meXkApX0Jw8fWKjehkAYbKiqOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(186003)(26005)(16526019)(54906003)(6916009)(47076005)(1076003)(5660300002)(508600001)(83380400001)(8676002)(4326008)(4744005)(36756003)(8936002)(81166007)(70586007)(356005)(316002)(70206006)(36860700001)(82310400004)(2616005)(336012)(426003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:44:12.0714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af39a9e1-4eb5-4987-a7fd-08d9e80e562c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1926
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Build failure due to ‘status’ may be used uninitialized

[How]
Initialize status to LINK_TRAINING_SUCCESS

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 18fe8f77821a..d0cb40df60a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3199,7 +3199,7 @@ static bool dp_verify_link_cap(
 	bool success = false;
 	bool skip_video_pattern;
 	enum clock_source_id dp_cs_id = get_clock_source_id(link);
-	enum link_training_result status;
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	union hpd_irq_data irq_data;
 	struct link_resource link_res;
 
-- 
2.25.1

