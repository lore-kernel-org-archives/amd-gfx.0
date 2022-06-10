Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94419C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1F4113FD1;
	Fri, 10 Jun 2022 20:53:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73D0113FD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCnlxWUwjqAtOrYMZ+q5rrxSqN8bqgccEfsTmVDkBE506LA8G/ssoWsToYA2nE2mvFAhImXDBERBdj7inpWOihIjcL1MO8+fvjooCEzkW9OAHKdPt86AR3bqW9kNgWCeMjYIC9CW1tWm1P7ZKgROs299CRWVzKl2q+tl2/xTvxV8f3sGQCerRLeP/OMuENigAN1YUyPVJFkFl8Af/Cs344lqoRrOfu4M1DlaXFP/kNWxGXeh7rB086AG/WZQocCY8Srx6hWR56EqIpSLozPvYRc3/UXnxbFE7+LdlbRQjttVvF9xxBjS+F+iiuR0mPCjeZ+WNZS4I/+tgjqWoQ0hoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXCCX2cnOXPccsfo4T7aFOCwzJKRSDvrIykrh7czeZ8=;
 b=idpxgppDRM+Z7MC5sB6MZnaRjPpqHkc1fxsU6R6NRGOk3h5Olde+mPN9r4Ez6+CoHWMVpIu6eQhdkC7V4UCA5Z3gBiswwXtackWEIENTkofjNZUlyVdOSVcjQ2gLYY41E+h7OXUQ8iDGop8o32Q2rOCpPkJ4KVXGX+drG0XkXU8lcPDJlQrGRu+2c+qKVTaLEztnzQfBdd+dTLSY4tB0iCXvq+lbGg7u35kNwEEgvxGd/NklUEb0ZKAA0GpBWZ9PbSqMJmcQPbSjHkwc8i36rqiGK3X1kTuL+1ADkYP2rftHVIIffGzjBSZjhB7pfA8bLjviU0j5bKjh0WHa7PrKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXCCX2cnOXPccsfo4T7aFOCwzJKRSDvrIykrh7czeZ8=;
 b=ZGcAK4/AIAsbJvVphIOC1ws3PEmzoOjb/kKHQpNiBPunQQ6bU59p6TB/DPsSX3IFnMh543EUF8xQS5k370wTn4ixjMjw5TsPDFOaYqYOOO2qLYDMsC2b8HkRBx/AAjWIEgGpYpkjz26x62dplHMn9A6Eovcs0mnoEV9DDyW1sL4=
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by DM5PR12MB1690.namprd12.prod.outlook.com (2603:10b6:4:11::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Fri, 10 Jun
 2022 20:53:21 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::30) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:20 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:18 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/23] drm/amd/display: 3.2.190
Date: Fri, 10 Jun 2022 16:52:33 -0400
Message-ID: <20220610205245.174802-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec1420c-b208-4cd1-b9d6-08da4b2340c8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1690:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB169012372D44BA89E4871867F4A69@DM5PR12MB1690.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0qMHzil8+0SxCCScFt47e7+4WmawmnhO8cEPVSLYK+/mMa+Jn23Eszctrn2TajPOt5LsJg6/sCzN0uxUHPHf/h+HeytmiYfcdfr3QiomuWj/qIRGkBB8I9r8nM45biXEQxfhLd8zaNySneJkdC3l33f5JR210gl6gH6+bXJZh1QuiSq/1/goFO5M4a4TT9iOHFFaxzO+NpB1EzXqsg3ctceGIChkJV6nWj+a1pXZ0Pc3Gyf7O/Rayfe1Z50egQ+PLD/vetfkTv9ESsHso8le0XkWerQ8m/qpavIXVhUOIxCuPE28BRnWXlm1y1W4aqzRmWkp18OAmMVR9l20aRaN5oHSPN5XBP0YLMNRmVGkTAQ6P6o0jWTAuG9AXvB1NazhPfxXH8+BYRwd55jTnsYkNoahyNfYuq021jtgnE1CFJmbQVI+3fLolgZVovP0yNIB8t0VrnuUM7b/mMTECGnpCCCHo/3zsVh9HiBYNFBhqRvlF0wJ4X3HxzTc8ws4U4FY6F3e5cJQMpnX2ilsDgI+S5USnR1xfbE3t5kjQtvCr08wP7OXYFzB2ewqXD9MklVKAFtyCvELtpFk0lBGD2UDtrSR+NbFVL8+hHVx+Q4F7zuGM2hRlTSmldnbR6D56ybxtUv79Luczcw/ChVJb0fV/gmRvIKJulo9zBCdzPqHgr/biCCw2WKQEsTHcUcj1p5d2E1Jk5rR93Kr5opH+fuAPH6nnHDcH8nLxpaaqpPo8GoeYVnPS/UczbvcyDB/8xV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(86362001)(4326008)(7696005)(81166007)(44832011)(70586007)(4744005)(70206006)(6666004)(336012)(16526019)(8676002)(508600001)(1076003)(2616005)(186003)(2906002)(54906003)(6916009)(316002)(26005)(426003)(47076005)(82310400005)(83380400001)(356005)(36756003)(36860700001)(8936002)(40460700003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:20.7463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec1420c-b208-4cd1-b9d6-08da4b2340c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1690
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
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- DP fixes
- Reduced frame size in the bouding boxes of a number of ASICs.
- Exiting idle optimizations on mouse updates

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7191fc48c2e7..0549fa2c572a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.189"
+#define DC_VER "3.2.190"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.36.1

