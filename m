Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B058C433FE
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5489F10ED13;
	Sat,  5 Feb 2022 04:33:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5506010ED0A
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwmbUJyjPk0ixcB/0/0YpW7WOSUNoWzUWY7RazAnyuAsXhoH7ESTf3JJGwqN9epxJvqj8GcL71MsiDWSv8U5uFc2o35tWfAAtHQHvEkqsAV7kAxt0b2fnHRnUuuXWj8Nw1wJ/LzCVmkke6SPIDhd0Xxr30L5h5wMct5a5l0L4QYg5XcBNAzz7lmDBV1nY+baXyLvc0GHBA0MAR95JZhEXlctfgd7CcWJg1CixxQUcTrO/ANGUusowvqB/LG2+skdOYoygoLKeWPFN0qOpxTzPk4Glk1ec1baHf0okkDX8VOSX+VPVFYR6gFVAKbhaEZQghlDFZ6h5IYmxiyZVRQwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B6MW5NlRDcMt43wkoSV5FLSpxf36+2lUkldWeu9NAw=;
 b=muAVth7c62S6Zn1jaZDOt+Cb4yRDr215qNxhpM2DL+inN0xDL8iUIVLmBLjw2192TMkn2hfprNkH8jkBzBPuzHxKvOLCumr/45wqPW3UYP6eDW6L5wKBLjQ9hkTUd7C50OYfpGIHofu60iCzBqvSdE9nXLxhYEYa3x9OSl5BvfS6UAMAieYHTSuu+zllBW7/HkY/qZmEA5HN/QubD07GSwzo7iAlmumT/zEW/Vi6NhM/lEM9h0wiaky/3oj0cxYerUPaGjnl4arRUB5rESYYKUpA+vGikt9jdhPKCgug1/6OJGW5jqahg4CulbjWRsHS2TrIpt5htX+i6g1jMK1sFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B6MW5NlRDcMt43wkoSV5FLSpxf36+2lUkldWeu9NAw=;
 b=q35bXRuG1B51XmeXHOs/NC//XaQf2ILRIFEOjk63Pk7OFbmoDMxBcesjtvEdGPXCaZLjFMORJLNoUskoZNniB/JLMboio4cVgeC9DB/dkRGN0zllOuv449j+aQMgsKGsb67xn+pzZB7zBRhdrPhqj6qywp8mw/TVrUmqu7GwjT0=
Received: from MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) by
 BN6PR12MB1204.namprd12.prod.outlook.com (2603:10b6:404:1b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.11; Sat, 5 Feb 2022 04:33:35 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::18) by MW2PR16CA0009.outlook.office365.com
 (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:34 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:32 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amd/display: Fix DP LT sequence on EQ fail
Date: Fri, 4 Feb 2022 23:33:06 -0500
Message-ID: <20220205043310.165991-10-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c80dc7-c1eb-4b21-cba9-08d9e860abe9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1204:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB120423F856B331D566D97A8DFB2A9@BN6PR12MB1204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBUYUivWC9F8GPxnbHNRh2D1UTCc+tKYwjSP8PZ/FjYZjYINo7bk1s7UXYm66e3pO25g0Zx2xawsMYh91XFVFbboSDlaKWRM2iJXR8ZJ4hnIHcfDRfbcuCy0YCGnZRuIVq7uELUSos2Ta2FeJcv6DDgeRUxmnyWunYISjgDp5J0K9HPG2MvJL11wBs6CieYa64QRYL1FqHXLjnYc/mWgtvONXdlX8QhA6+f+Je8o2V2UE5HvpMt9U5+x0/v9iPKBmpnvCQTGICVL4pDi65kXPRWXtzgFNjUdG/X9gUR0dBTjZPHQkhsL+H9tVFwww2+HCNlE00zoAGwKBH66uG837e9uwA0hjfsEDWweEtbKzp/JOTNv4tmhvcCvCDn4kRhMbNHl1LZFg/3vu6tSrbDUZA5bf1BrN3cRgB3Y1CWToPsbLTna3Qu9yKdu17idLrN9i641zYjdH0nSKi/GKnE6W56c7azCzacSTK6d5FVJL7QZQcsVXIl4GoZqoVUOlvr8tR6HLsu8TG8Wuaxe2xOXexUeZS/PU1zEzha7LlQDaIhbsdzGn657LaHRkLo0Atfzmqyikdls0WT6w2ylTJGy74vv3B6hXbHRLo9AOa78j9CR08QVFyYqvypP4Dmec3LQussdlhLpe8uX93fSfSKQAMPfPOxhmiGMtZrV/gCYi0KN4LfDvmxd+4oUZ4BMI0mRjc5eX+JSWAbHbjMi/OUGfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(47076005)(82310400004)(5660300002)(70586007)(2616005)(6666004)(36860700001)(356005)(508600001)(186003)(1076003)(54906003)(83380400001)(6916009)(26005)(316002)(336012)(426003)(8936002)(70206006)(4326008)(16526019)(40460700003)(36756003)(2906002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:34.6491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c80dc7-c1eb-4b21-cba9-08d9e860abe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1204
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
Cc: stylon.wang@amd.com, Ilya <Ilya.Bakoulin@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya <Ilya.Bakoulin@amd.com>

[Why]
The number of lanes wasn't being reset to maximum when reducing link
rate due to an EQ failure. This could result in having fewer lanes in
the verified link capabilities, a lower maximum link bandwidth, and
fewer modes being supported.

[How]
Reset the number of lanes to max when dropping link rate due to EQ
failure during link training.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Ilya <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index d0cb40df60a4..cd9c31b5e55d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3504,6 +3504,7 @@ static bool decide_fallback_link_setting(
 			current_link_setting->link_rate =
 				reduce_link_rate(
 					current_link_setting->link_rate);
+			current_link_setting->lane_count = initial_link_settings.lane_count;
 		} else {
 			return false;
 		}
@@ -3516,6 +3517,7 @@ static bool decide_fallback_link_setting(
 			current_link_setting->link_rate =
 				reduce_link_rate(
 					current_link_setting->link_rate);
+			current_link_setting->lane_count = initial_link_settings.lane_count;
 		} else {
 			return false;
 		}
-- 
2.25.1

