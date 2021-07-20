Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCA3C636C9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E1560FEA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E1560FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0D76E43D;
	Tue, 20 Jul 2021 15:45:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA2B46E43D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1MXb6aBdiUHsG2Tw0+2HiCokAL5htIf53ha+UXrsuyQzjqFq/IFj0KTpmymABDveb9tWEJU1356hUWbEKw/IY7Hw/RgXOLJZX9cxwkDXJkxwi3g+J+7pclESsM6huibf5dqgQ6OsigxiB/0beR9cQJ4f3pgpYRNWUqkEnuwxJrXxUQurCTZzscY05Qqdvd7Jn8euo6cKa0/0ZiKJMSkN0CO//sRbuLSe3mcvgJOaNt0y/xIy/3oaj9txsbEwOartorqPfL8sWuWyWMbGaD/x90JD82JjqTAu+MDOh41Uiz+68Lo8ny9pK22gVqMqjubUkkYeanfGkvjXNQw18FaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtJ+68Vmnz0VnQKmq8bvVW+xhum72wrcwfcHuvpvVkU=;
 b=ke5+iaBkpxs8HDh5UifkVsJnqe7NS1COYHdCnR/MMcGAzUaCgo8A3HDE++IHv/s2bnLDHvIgCKdrZKaikGYa7GrhE4gjHMhFPKExSRGCHmMOL5Na16FweV16PHONmey5NAZyz0aAMSDT+89CS8afuY8kz21vYbhWm/8TABtJ33Y3tUvi69ak4ODWTbjOPZu281Ye9UesY/va/yaeNlOBkv0o5A7jY2uufFXx2qQSSWaHqhCVkna/qA9IIXMs/jPyt8jhce29/cPbMZdnNjJzb5JujyWhoPCo458LU5WkyeGmMpbOan+k90ta72CChsSfYonPTI6Q9tqtOtdDtxJ5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtJ+68Vmnz0VnQKmq8bvVW+xhum72wrcwfcHuvpvVkU=;
 b=snKBGmU/Lz1GHHfuYipBoElsOQOUTRmPT0J6KwLLNSXkAGBc4MveP+4JIYsDU9hTWVk8rpC5LD1mJHZTq3mdNkANUJF4IJAlLmL8FZg4IqMCFGQTaA/2pqAl3j+RvEwfeTdIL1fosJIKQK7ffAXYx0IGPYES+BMWL9J+2RvQoDU=
Received: from MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17) by
 BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.29; Tue, 20 Jul 2021 15:45:13 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::3f) by MW2PR16CA0004.outlook.office365.com
 (2603:10b6:907::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 15:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 15:45:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 10:45:11 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 10:45:11 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add a new line to debugfs phy_settings output
Date: Tue, 20 Jul 2021 11:45:04 -0400
Message-ID: <20210720154504.657918-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a23635b0-39ee-47b4-f520-08d94b955cbf
X-MS-TrafficTypeDiagnostic: BL0PR12MB2545:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2545F21215FBAE6179CF8F6DEBE29@BL0PR12MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zfMWufRzp/i3yfaZCluwnJFsSorEheHsGciBxM6PFHwu1S6x07zNkPBSJ6pe3XmwYGsOPCmUjbmubflMSp/xYHejS8ZFo7wVwffb45DRvU7bv62ivdBl2TBMCCdwFvp+2HQLuA3hdhKYMDBw/Muci+J5SKEVg/ADeYs/63X6T1vq3e+i145/Kgu6SapkDHU/7bdD1cRGs5Lj6Wr6VMontLmGxAn2UFnU0XXzmcoud7VDM9i+O5jzNDFUr7xbw4Ci4DmKPmy99MW3HAicZLclJR2dA9+kSEz1cvGv6QW7GFzeuVHJm4u0Z0GH64ZkoQqJ3a8sbZMs+4s6joq24/SNDO/wm9dqTvEzrqbeW758JYjNagouOvVsfVoyeyw9LAd9sXY2sduT32WX8Obou/pObMvXCThJLPir91YUjYqbHjHu5nYYNlE2twBQHIZVLzC0NbfZSy6Eh5TJyFzHKoq1bVB/G76B8Ux5igwlnzm42SGYpdAjU2WKLYI5sQLRxv9MkYiBV5ejmlTsfsA80El/kR32g0joftmKdvkA+9klUTHgOnJmgnf3XBDoehOqelgWsCvkW/8RZovrdd9ZMCv+Cl+p0w3+SLc3QeLUEuCyA52GL4cFzlBLs0k+/IHa8ZsbppuWmYhuUGtEWead7YW9UjXRZ7vhj+KXKqS7UioPWbQbjw4+7kdZoelthNkbckwovMBOAyFZtvLw+oZeIgZygwCrAigYsqUq+UE8sQuLV4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(36756003)(1076003)(6916009)(82310400003)(478600001)(2906002)(70586007)(83380400001)(316002)(36860700001)(82740400003)(426003)(8936002)(86362001)(8676002)(47076005)(2616005)(336012)(6666004)(4326008)(5660300002)(356005)(186003)(26005)(7696005)(81166007)(4744005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:45:12.6121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a23635b0-39ee-47b4-f520-08d94b955cbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
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
Cc: Anson Jacob <Anson.Jacob@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new line to phy_settings output

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1d15a9af9956..87daa78a32b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -377,7 +377,7 @@ static ssize_t dp_phy_settings_read(struct file *f, char __user *buf,
 	if (!rd_buf)
 		return -EINVAL;
 
-	snprintf(rd_buf, rd_buf_size, "  %d  %d  %d  ",
+	snprintf(rd_buf, rd_buf_size, "  %d  %d  %d\n",
 			link->cur_lane_setting.VOLTAGE_SWING,
 			link->cur_lane_setting.PRE_EMPHASIS,
 			link->cur_lane_setting.POST_CURSOR2);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
