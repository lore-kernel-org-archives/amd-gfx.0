Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108A7C5DF9D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D142224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fl3Fs+mO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D142224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B9E6EDC2;
	Wed, 21 Oct 2020 14:23:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921836EDBC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdMAy/iomScDK56wOZrc6NKMP9nD76pXDQZcyi4jjJ0Eu0VX4fsP2mB12TbJoaHyDfDuQeDXHuV26CotMaMdzg7UgpX0423ju2apwdwj9OzstiFDmPGhxFQ5f35uoVQLmTwKtIZFGs964gaYeI/ndiy6wPUr8Cg0QXyZLnFNvrprSfZiTbk4VCSoR7Y12C1axMto5o2LEKI3JWfdMNB03wVniu/2TMWKgRquuUV+dnT3Hu2KHs8YzXfJOwwViNd9aPlbomWu0GeRWX25kd+Mbl1KArcDKkhJiwHVYLWAYHkeZySUdUcr2h73NkFvaaj//47YX2hkTwaDbRoiTXRflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNSAMUb+6LYPCboSy61/x56wJrHO7Yd7PVrkp5td1yI=;
 b=Nzve4VPGIIt5kI0FEK1zQSKH4RnFzUSCptZjLJTym8jJKW6Jljl+27EiU5lCvK8lKIfwm0bcoiGBpJaalD4SHh5jSORiKhIyBuuRKVO/IWhWfBFdNxcFJHX2vmm9wvGo3He6lJ/GMF5snbfefD+sxcYXTt+9+31+jUHbfBQxHbcoKBiYZTcomtkez9KTf8j5Wd9Ci3qcwIoeZpHJIZL4Zyxo3ZNiKAyZuq3EVx2XPa0e8X2WozLLhJQp+yv8EcnZypvrB/qGWGneQaSexd6jSGPdNt1bcCfGM6V7rtbri0taHy7eGDAgXi8PTMPMc5fQnSeCh0E1BGb4aa9IGR8Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNSAMUb+6LYPCboSy61/x56wJrHO7Yd7PVrkp5td1yI=;
 b=fl3Fs+mOQW4OhRjKBo9ghxWHeVbGcGez2Sr92jqEcpZAdDJCRX3egOsxUGuux7MY5YnxOtKIYza7iSmr0fl6vzO/PiQm4/g69PRyG5ymQIBLg/rfhFbfiTh6tkqiQlVexcHvqJZIuiC9h1FZlxRxlCl6SX1pkcekX5IXlPtMBCY=
Received: from BN6PR06CA0019.namprd06.prod.outlook.com (2603:10b6:404:10b::29)
 by BN8PR12MB3474.namprd12.prod.outlook.com (2603:10b6:408:46::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Wed, 21 Oct
 2020 14:23:11 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10b:cafe::66) by BN6PR06CA0019.outlook.office365.com
 (2603:10b6:404:10b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:10 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:10 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:09 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/33] drm/amd/display: Define PSR ERROR Status bit VSC_SDP
Date: Wed, 21 Oct 2020 10:22:32 -0400
Message-ID: <20201021142257.190969-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c72734f6-8ee4-47cd-52ed-08d875ccd6a3
X-MS-TrafficTypeDiagnostic: BN8PR12MB3474:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34747E46633ED85BDE8A21868B1C0@BN8PR12MB3474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CT2fZqMdkVhHoI2pJ3Am8aObnVhDEJH1DH+KPm4d+j6+4u3djtWwVhBhHMeWFgahpLvpxV9z3/Nes6XxRvAoeM1KKJqdkPwPYP3sy7b9bDJA5al1bX4z0UTgFfqYqhKJlW5ocuYOnC6v45R5lYBOK3pFE/llnXB2D/bNumHLxk7FuhxoPYMwswC2WGhm7fOQjAhyHCRDRcI938cK9QfqAa03brfcisBbONi39j5CutYlese93tnv1m7WOrVKdd92UqNfzw/35YdfO4IZZo7vTs58BOsupBBhAsbo+s7T6YXxAi542+GcK06m85tQjkG8vt1CYdld90XhJR5vuZkwriIZXmdt//JgpbVjKzK4CkPijT3IoqiyL/JirEODzWzRSCLwc2BxeoqzsV5G+4e2rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966005)(336012)(86362001)(426003)(82310400003)(186003)(8676002)(70206006)(54906003)(83380400001)(70586007)(7696005)(36756003)(26005)(6916009)(478600001)(81166007)(8936002)(2616005)(316002)(5660300002)(47076004)(44832011)(356005)(4744005)(1076003)(6666004)(4326008)(2906002)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:10.7281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72734f6-8ee4-47cd-52ed-08d875ccd6a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3474
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
Cc: Reza Amini <Reza.Amini@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <Reza.Amini@amd.com>

[why]
So we can track VSC SDP errors from display

[how]
Define the bit, and use it in driver logic

Signed-off-by: Reza Amini <Reza.Amini@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index c2b392a533b1..7f5acd8fb918 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -90,7 +90,8 @@ union psr_error_status {
 	struct {
 		unsigned char LINK_CRC_ERROR        :1;
 		unsigned char RFB_STORAGE_ERROR     :1;
-		unsigned char RESERVED              :6;
+		unsigned char VSC_SDP_ERROR         :1;
+		unsigned char RESERVED              :5;
 	} bits;
 	unsigned char raw;
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
