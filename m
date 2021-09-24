Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0104EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EFB610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2EFB610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630F16E222;
	Fri, 24 Sep 2021 19:10:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4567A6E221
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl3EIGdF+iK1c8Ov16rWgS0NOboMKjrSt5bO0EKl5/tjcRHHb3ZeHazsRJ8drBdq72lUzGAsfa4Cvt/eBFz1MXddJe0l1NaJbsxl82g82kVzC/HEaOWYMVdeLpKgElToNP1S84mTFD/Ex0knoRtzH8qsgLifLR0qnammzcJwbqtgW2KNTRxDT33MIli1i/OrusoB1zaVNPtQiTaVRS0LcBXa4EKrz4PBSH5aSgns3Ue6FJVx1X0Znx7eR/aUmztsWJKP3TBfuXmNVlS3XnJinrMKULERa3WC3eAoYx2zFzqzUrJtFPGu1NJ7iPcBNSbFgWPBcwWYJCQnWPQYA9NflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=im8X9sd/G4gL7XYzl/D/VYS2Urw5c5ksT+sleuj+1Do=;
 b=iLEJ7UHbo0JQwjMzHnwWZeAayS8etL+usKFJz8RGrjGd6xjYgzDG1GfecOWhuMoZovrNadZ1DleSfcekZbWxo4ZBdxnT2kpLQOMCjWCNda5laGgknBZoO6cK+DWlQNchYLV4sqsTP//2R+QVhqyNZpGUxUinBpg4bKfRzca6vZ9UDy3Q0aQix9x6Kju99T8sRPpejSe1eeXYef7p8t/7818PPnArZaWBT5SzkQhLBsrdsByNA4yIoE31Cbtlofzo+q3oEuhWtdPRWocXgssatrn3XYwilTaekWHrUxySCyBE6Mr+RnG8KnJUBTdvvCI4EseEJtkzP75Pt4UNc4LHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im8X9sd/G4gL7XYzl/D/VYS2Urw5c5ksT+sleuj+1Do=;
 b=SexLEfAu/cCf1YCKZqEnhKiskL5hoWuF9HA6qgi+JPNgLabCcephd/v41cWSZPkQ7XEiCQzhEWIuHN6bGvnG1LVMNlsgnVtG/74iu0xU7oRa+dbW0HVke+iidHcBgDaxhazf8E8iZaCSAvOdbgtH+mV3wCxOLJAH7EAajQkh4h0=
Received: from MWHPR18CA0025.namprd18.prod.outlook.com (2603:10b6:320:31::11)
 by BN7PR12MB2691.namprd12.prod.outlook.com (2603:10b6:408:26::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 19:10:21 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::3d) by MWHPR18CA0025.outlook.office365.com
 (2603:10b6:320:31::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:19 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:17 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 17/24] drm/amd/display: 3.2.155
Date: Fri, 24 Sep 2021 15:09:27 -0400
Message-ID: <20210924190934.1193379-18-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc156399-e549-4cd7-ae99-08d97f8ef480
X-MS-TrafficTypeDiagnostic: BN7PR12MB2691:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2691E113C58A116E07AD0124EBA49@BN7PR12MB2691.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqIWtYIdbYKtmkvDOsos7rUKXM8cTOLFTl1k76Zyp2PtxjFtSXUNZKsxKGkneMMHItS6Vmu+2AW77tkKRZznoyw709N304vQyHyEi4qhdsV+zkovKMBbGR5anrnkFLhiNTXwhNZix/GIwx/cjg2mQemI3JdLYL/6cfmuyackKzVxYlI6Oo4umu68z+3GYIFkv0YAerADq5bjvGgtgSZHj02shNq8gd24tSQ5gkpiTLwcrLva4//L/Psx/qIUjtKH4JHUGTFv19NsHMiMhTiWGf4Nh0/JRP359I8SYoIpQj6/zTLcFvfUlCZEVvJaSc4iTOdstMyqDk13amnyllUyXm4i0/XiWQ9iCCcJCmiegTtBJs3pZhZe2D83LfZ+7CeeZuDVK4XB5sIgFqVmZyAJ76PEos1qeFBOSoybuDoBT5DM89WfgRS6icesIgZFumftc7rHwu9w4O8DXLcS7fJXe2jp5VHRY/yUnbySRdtY9VpfN40eQDiHH069O9BPkwtJBaARrG1IDA1114lFBC8fU0DRLCZ6RX7blJOGVU4JfRasQD8gt+EVcsjVl6SHad20hMXMEXoWJ+3SGWaJnY6gA7bGZRG6QyX7Trng0AmVN6uSR4j1DTzpOf+b26YZCxtnn23zSp9bfcFp2yZa5hvkhwfynD3CmhxZYKktAkBG3NLa5L6OUdiZ4TVCGpg/hjsn7DQssVzX2sprRptDdxMduBkn+g5Zc8MlLH2mRWB72DU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(4744005)(336012)(7696005)(70586007)(70206006)(4326008)(26005)(316002)(8676002)(86362001)(36756003)(186003)(6666004)(5660300002)(83380400001)(6916009)(1076003)(36860700001)(2906002)(508600001)(54906003)(356005)(426003)(82310400003)(2616005)(8936002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:21.2344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc156399-e549-4cd7-ae99-08d97f8ef480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2691
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fixes to backlight, LUT, PPS, MST
- Use correct vpg for 128b/132b encoding
- Improved logging for VCP
- Replace referral of dal with dc

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a46c663ed8c5..8cc9626fc111 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.154"
+#define DC_VER "3.2.155"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

