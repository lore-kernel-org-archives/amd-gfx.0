Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD31ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC9A710E7F6;
	Wed, 14 Sep 2022 03:33:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93AC10E7F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu3B7kUUl81B+1YGEWmZRK36zTys4qDppILBZXeGMsmUdNuOu/MYIkmV5IU9kv3Zrs8d2Iy6WoNLpxEqyYyNtGFJPTCL5dLpTgwlngPYJph/bjEB5zLOp3JsPUu2UnxkyjRhl2YDxbILpdER/IndF9/UyYngi1c9iLl+lxtig13mTMz1SrFrteSmoY+aZS7iUl0stOzLwr1TF45s3af4LeC46Vvwz1eSAlhuu61pntG9RS1Y1oJEyvtsGHF32aNcWkU2BqN9QM2LBd6IImTfF4oSJTy7TSrKJFvFEKzsbe5X/KD7Hfx8yrXZkR5yp9G+RSvb4eAzW2bNX86vKA+ZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8moY3LDdRL700blhswLKYPgDUqM5zVJ7gO7NA0jCQw=;
 b=TnfC3gAQgQb3RRrBMCkmn/dCZ4T/LqnLtgb7EPkR4uIcKkhj51127z4cIrkiSnJXUhTXSfKnohWYfzlBgRVUSLnOVu2hzmT9dYXUxySxidl2Clwssxi0ebxINjtnLuJAV5N2xw1e5XtdCsPfsx4MkelQ45q1oXn4TRVURWdGqP+7NqI2shqBzFXfiTwSL6LzmMTCiwuGmEgi0u6I7G30zOAe6PNQGps0cg0lOoO6kB7mht+i2y2C2NA51XB4LObCUTfraS8YBZt75Lcr6NMSOfgbiP/IeJS1tJywxn58RAotbEL9ndvQuIhH5a327Rc8XLWoRYdZCgo0xmBA3NBnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8moY3LDdRL700blhswLKYPgDUqM5zVJ7gO7NA0jCQw=;
 b=q2bHm8+2pf2ar6JZixJjZA5AvjZ1Ovo9LFBXPEfH12ic8dyXPUTdv2lmJR+hXHxaf0qygW+iC+Omx7aKPlzYf7R80e+dj+wRDlSIjNPTEfXKJ/CCGTGahmQ1gfexY+zdlFtOQ8eTM9L0h5xaWXvzoVeNCNNYEmLFFndzl3MHBow=
Received: from DM5PR07CA0049.namprd07.prod.outlook.com (2603:10b6:4:ad::14) by
 DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 03:33:51 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::52) by DM5PR07CA0049.outlook.office365.com
 (2603:10b6:4:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Wed, 14 Sep 2022 03:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:33:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:33:33 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:33:24 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/47] drm/amd/display: Added new DCN301 Asic Id
Date: Wed, 14 Sep 2022 11:24:19 +0800
Message-ID: <20220914032441.1075031-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 51378143-b38d-4e9d-eddf-08da9601f112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lirctTfUSeews9eI+fA3K2Ajd6a+QIA2j3p/y58zieozKedDjnGFT6tmr/HRasQs61FRXwKu1Den7kbwcc7+KnxtJtpDWwnKN85Z+/elot3WtilOe4w1KlDGPdfjzOpDSriGSsg7PnAt5XTdNaI85x+GyvRlO7Y+vATlK2uwHaYIsokqpbR9xCrg8HbkowO5SisDsNmqMWyd92sUEe2a5cE2wY3P1IYEt6VNs3mBXvf9yuGYhvtpVBXMyfjvR5ctlP8A+YETY1bTfCe3hsBTFeXoaYaJB2nyi6xE0Ig8FcWs3FQcTqo9+HF9zGpMF1lD4D85jb3iga+d4x5H5QhTVLybrU5DqREUbkZOcREo/eIYCxeM31YsEpFDf+zMHGCJVulenSa9odFzMJucTGdO4s5pusdzmsVJoDzPQbXAAwFEvCa7PYvon/KQ4Rj6SGMXhGQRzFxBGJnR4RTCFoyBnl3RPbxfXMD/l0l3KymXuQ7/TzfKJ29mnDOFJKrsQwO2iKjH1ohGg/0fcytwhkq0Tb6x953HWjqsGO4bvjkLdx+69V4hvt0C00/b4kxVZIOo1eCsT1SwSwYd2NM5L+kqtoah3718L9rL/F/VB7X1y2gGjVX72aY+HyujIpmTWOY5CQFnFTfJccAq0xiF3ftWxc6e6Q6au9rPfG82ZSU11pgeS+De0J2VZX3sEwQuwqJDAXbcNJCHknDJrlBpYkF2n3AF6z68pAUNTC1DXi7zGLk1Wb6qbv1cLAw+yNdXH9jKM4fq/pbl3BWBpRgLWJXkS4QACUJXiYv1wwSGW24gH8uzkAo1vUqAM9BoNZ/Ml3b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(186003)(1076003)(36756003)(478600001)(26005)(426003)(81166007)(356005)(316002)(86362001)(70586007)(82740400003)(5660300002)(336012)(70206006)(40460700003)(6666004)(8676002)(4326008)(2906002)(40480700001)(4744005)(2616005)(36860700001)(47076005)(7696005)(8936002)(6916009)(41300700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:33:50.9092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51378143-b38d-4e9d-eddf-08da9601f112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pavle Kotarac <Pavle.Kotarac@amd.com>

[WHY]
Adding new asic id for dcn301

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 9f3558c0ef11..c3089c673975 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -215,6 +215,7 @@ enum {
 #define DEVICE_ID_NV_143F 0x143F
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
+#define DEVICE_ID_VGH_1435 0x1435
 #define VANGOGH_A0 0x01
 #define VANGOGH_UNKNOWN 0xFF
 
-- 
2.37.3

