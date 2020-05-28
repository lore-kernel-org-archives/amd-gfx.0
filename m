Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9751C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8593F207D3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CrgRxBIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8593F207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116446E573;
	Thu, 28 May 2020 13:47:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829B46E570
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 13:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYkEBwythNreNNwzTaQRus0A6Js4a7nXBI39Pj3ftHk1jTyTJGoVtO6k5MyYQUJN8V1iSZPYFh1UV67PaIltIrVXiKIRMn8q5/8qgZKzZSIjJYVpYnDcOwBzAprWs/xsL0s6h37xvxHZmyH92EVGmEoL5iqvljrRs+56JzhlILmLbEjAVpVBL0hIVdZuEbjtp4WA+AzgiPEQnGFQOwC2zcCTn7zZZXxo0u5ZfzGT+g+EPwGd59cl84vIyfBaMMiTJZKK3GowI8lwyEFH00RBCsS8m/ryCZdGcFH0P6LunMw+NUzzDJ8QaW27uHXJcPinxe2qggh+RCNpPZqJY/Mghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imQX+OchpymE/VwJkUG9p4VE+IyvvvRPw9DjhF7kaA8=;
 b=EvhX8IbPO1VjKfeAJx0V4HFoDTHfzCCVRCEpotIzpzdQ3QR1DbIBcn/hNOm67vg6CrcGXoWTMeRLwzvcxg/h2qxPEiFttz6it0TDXtS5PpuWyXp0rYiwF9cPnKexjBxMaHwy+om5mU8s1AYO6eH9x1YMZC01Uz3SExlByS/nrr5ML8zAold4wPkcQKo2dAnW863mt2gk2c2nbGsO7Ub/g7MQSURoVJPalciM2Xg88i8YoQvXQxiEBNlf9kB5oKTKJmOX1b7Gm2HnGrqgsMtgKDEjuDotBiII4vhrHetr+SvNE8TpZVOXv0gHDKuL6pa18d80nYjrzIZHQ8qLMYdY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imQX+OchpymE/VwJkUG9p4VE+IyvvvRPw9DjhF7kaA8=;
 b=CrgRxBILaT3gDrvPULR5j/RNAclFlwkc+4noVLwk/xUt/ppxBxAPlqYxhuglZBksQtXmuLTC1tkxG5R0yrTTEBty0QMRUDmEy/lOXTghjzNVpN8yPxIFyekt9UPIEfS7wd25NqMAdi3/Hyq9Li4s8YEyQy0UyB0Df9Q9XzTLd8Y=
Received: from MWHPR12CA0029.namprd12.prod.outlook.com (2603:10b6:301:2::15)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 13:47:30 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::90) by MWHPR12CA0029.outlook.office365.com
 (2603:10b6:301:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Thu, 28 May 2020 13:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Thu, 28 May 2020 13:47:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 28 May
 2020 08:47:28 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 28 May
 2020 08:47:28 -0500
Received: from hwentlanstrix.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 28 May 2020 08:47:27 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: disable dcn20 abm feature for bring
 up"
Date: Thu, 28 May 2020 09:48:07 -0400
Message-ID: <20200528134807.5665-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966005)(26005)(36756003)(70206006)(6666004)(70586007)(2616005)(47076004)(336012)(44832011)(81166007)(8676002)(82310400002)(426003)(86362001)(82740400003)(356005)(2906002)(316002)(7696005)(8936002)(6916009)(1076003)(5660300002)(4326008)(478600001)(83380400001)(54906003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e5df866-bc78-4c49-161a-08d8030daa45
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-Microsoft-Antispam-PRVS: <MN2PR12MB396603CA4C28B7F0674058DC8C8E0@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMFIanuXebNTldnPD8pFV7OPyZU3F78iPmST8XDYcnEvEJvSBIgkCv7hRblqJkOdb3HEqc5Rcso6W2P7zZvWFWxUXqhlBGHaOvVYtbCTqmF9sXI+LarBUbRu3QqCfS2QlVRtKTL9dVdAmbAna5148kCpELBuYYHaHNGLDpz3EK/M4zZdT9gbjl/QK3iuifYtkxp1fXQ4+/jdeuNs+FKn6JBYyPCkRqOHXsAhoAqL3xasvL6WiZIP8y6ZMEZ9gh6VuSvvdKjusfvxWrX8XppAWbpdTSwmiq4F67dusl7BPFsaEdNYX5bQxG7TJ0D0c8e4fL7d1saMzZ9NBK/lvnwt0cmDfOf2B0pwePxKkZZyeAtY9wrDaWr7XeyBWyqWmoQW7S7xcz4Ox4Dum/ijbf8c/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 13:47:29.7418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5df866-bc78-4c49-161a-08d8030daa45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, Alexander Monakov <amonakov@ispras.ru>,
 Harry Wentland <harry.wentland@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Michael Chiu <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 96cb7cf13d8530099c256c053648ad576588c387.

This change was used for DCN2 bringup and is no longer desired.
In fact it breaks backlight on DCN2 systems.

Cc: Alexander Monakov <amonakov@ispras.ru>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Michael Chiu <Michael.Chiu@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ddc979e3eebe..acd4874e0743 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1356,7 +1356,7 @@ static int dm_late_init(void *handle)
 	unsigned int linear_lut[16];
 	int i;
 	struct dmcu *dmcu = NULL;
-	bool ret = false;
+	bool ret;
 
 	if (!adev->dm.fw_dmcu)
 		return detect_mst_link_for_all_connectors(adev->ddev);
@@ -1377,13 +1377,10 @@ static int dm_late_init(void *handle)
 	 */
 	params.min_abm_backlight = 0x28F;
 
-	/* todo will enable for navi10 */
-	if (adev->asic_type <= CHIP_RAVEN) {
-		ret = dmcu_load_iram(dmcu, params);
+	ret = dmcu_load_iram(dmcu, params);
 
-		if (!ret)
-			return -EINVAL;
-	}
+	if (!ret)
+		return -EINVAL;
 
 	return detect_mst_link_for_all_connectors(adev->ddev);
 }
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
