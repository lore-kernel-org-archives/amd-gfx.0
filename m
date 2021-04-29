Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A6C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF846145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF846145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795826ED8A;
	Thu, 29 Apr 2021 07:54:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E116ED8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKWjmpLZfvB8ywq3xFQxikWbjJgFzAHRCjmjIL+ikyWtlg2EGL/r7GWOLkrToJnaxCJQyGhlbbph2uVEdNdnGURrJ9MEP+ysd5qZ0j4vVrpQZ5BkUuUGW0jSyXTpCiSY7DMgqfETDJukS2GQMu/FFlcjFe6JgssM0sZ8wHChcfNfqCWRSWpchfSS2/HRzT6B8XQ5hPktTcPAYqtXM8KetlNuj21Y3h8TKtRhJVq3sTlp22rnlFTazt7yK6bgYPOiR4GBWi8ffWHsP53JVneZHgMA1d+sVw76aRmGz6I2A3tHIkJFI1X1z0q8U/4siRgQMlvLZfVBILno4TawIbYwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQocSsCQOwEKURTeumVaa7EQlnIXVlZDS2KBGX4QOn8=;
 b=OIOiDOwOM3uvmFHi+9hywzNSdRhlg8g4/LQqXvJ1ejGsBkdH5z9Y/jgO0FeoIWzcCGK8mg3ak5TuRDpHf4SsKKa8BOpv+j/fOVlKOgIOm11D2/hgbPkSj7l5FtLFEDn++L/y1BV3X63cXJlgs2qOSxZL0j5d30HpBczsb4xSZ36qhD2kpkjuP9tS00QdONmvJR44voQBJpgDO9oMDR5MzxxfWqMD8QywsqR+dPqxpHj8j9aLu7bgZow9SReCU0Dh9jCKHzoCi3qyi8b1FrdGvyzt3l1kAwXTbeiRaXidg27AtMwkRlH61y2PZrQh8BJNuwPKp+rINSLx0x6xl3m74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQocSsCQOwEKURTeumVaa7EQlnIXVlZDS2KBGX4QOn8=;
 b=GlPUQ9Pir6WBC7pMJESfdCs0Ig0AwauB5uHyGIYajSY4tfbTj8C79hTzq1AYMd4xqIu8ctENILrGVfjQX1vHQUUd/7eLHwpXx8H37okhNZvL87uNf5HGz074TwDS5LL3MaN+uG0qoc9Ehfu5BjL0cArM8AmAWMtzxKrRVLDUTtQ=
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by BYAPR12MB4711.namprd12.prod.outlook.com (2603:10b6:a03:95::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 07:54:50 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::a8) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 07:54:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:49 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: Avoid gpio conflict on MST branch
Date: Thu, 29 Apr 2021 15:52:04 +0800
Message-ID: <20210429075206.15974-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d069940d-6e44-4c30-a086-08d90ae41123
X-MS-TrafficTypeDiagnostic: BYAPR12MB4711:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4711C472E989A8E56310CED7FC5F9@BYAPR12MB4711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TPh5/paVu162g3Qam4ljOB3jlOJEtpzbdhxCoaR2wx4l8LDC81PbfZJc2VAjz34rfjErIuHyB0Axp6GyX2Rb4TYvA+4d1J6bhH2o2jX3j7HgDG74tPEH80I5phoSDhEyU/CyknUMjsMkr6nw11rGt9SrMRXkJbjHcu4VbbvAqIGJFqLm460edZMKb0R1ijC6EnGkxMjloeirHdfjadaUvIuTqssBzx4gdRxDZq/J5PDkPdFKKDYZXGrvrszLvc2Kg6YA4t+/2qBJnKoArHGstwRWpGKam6GpjQC8XL3nFINzlI9rkL2Bt3fG4fDQsgzq2YbXQAkc2V8+7tUMaKT4ZcjVkiY1lQKgztqMmaeNQfud26BlDdI2nXwQ8UCKIOSiS+l7P3Om3x5TiJgh6nRTS4jvfM12+zxd2RLRvAQ8wv35ZXu7mW9wwShbv2KHtCR2oWLyYBuL7U+flw8r7dW/QXMQ34XqYlwkkTmNuQFLlvlcd6k5EjtxMvaZzBhy32TMtG5t2q+5h5pCZvWNjT04DMWm78vVYabo48fJteaQ6gpBdazxrsMCImLSdWjZ0rWL1zNfjYkZlR/6PVYDVLOTQbmynXemGmEdPkbp3jWkXAEuRGk/UwZ/37hViDxpEsXI9v/bKQeiSnzeuI7YeLchCFQ2HD2EiAk0fxeEEpSaUKneQKZKd1w9C04cqjgm+LP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(5660300002)(36756003)(4326008)(6916009)(2616005)(336012)(1076003)(316002)(426003)(2906002)(70206006)(478600001)(54906003)(26005)(82740400003)(186003)(36860700001)(82310400003)(47076005)(356005)(8676002)(70586007)(83380400001)(6666004)(81166007)(7696005)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:50.5574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d069940d-6e44-4c30-a086-08d90ae41123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4711
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
Cc: Zhan Liu <zhan.liu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <zhan.liu@amd.com>

[Why]
Similar to SST branch, gpio conflict also needs to be avoided on
MST. Without doing so, there is a chance that gpio conflict will
occur if multiple gpio interrupts arrive simultaneously.

[How]
By mutex locking/unlocking &aconnector->hpd_lock,
we won't get gpio conflict when handling hpd.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Acked-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9dbb9c29c059..23ba35730c7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2752,8 +2752,7 @@ static void handle_hpd_rx_irq(void *param)
 	 * conflict, after implement i2c helper, this mutex should be
 	 * retired.
 	 */
-	if (dc_link->type != dc_connection_mst_branch)
-		mutex_lock(&aconnector->hpd_lock);
+	mutex_lock(&aconnector->hpd_lock);
 
 	read_hpd_rx_irq_data(dc_link, &hpd_irq_data);
 
@@ -2822,10 +2821,10 @@ static void handle_hpd_rx_irq(void *param)
 	}
 #endif
 
-	if (dc_link->type != dc_connection_mst_branch) {
+	if (dc_link->type != dc_connection_mst_branch)
 		drm_dp_cec_irq(&aconnector->dm_dp_aux.aux);
-		mutex_unlock(&aconnector->hpd_lock);
-	}
+
+	mutex_unlock(&aconnector->hpd_lock);
 }
 
 static void register_hpd_handlers(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
