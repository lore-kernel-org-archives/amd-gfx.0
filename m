Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83201C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A3722AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A3722AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38E66EC79;
	Fri,  4 Dec 2020 21:30:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EEC36EC79
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djqSDZmm3eZj45PqEmA1AqaSoT0LDa+Y6sQQPrAmdoqM7z1u+ybQQgK+Z4Cq12DJysqF75VN2hPyfP87Id7nf6ItobTnxe+wGQY5i/l2xnduCkOKwAl0e1vLv5nJOyBAOcbrsAfK5vCcm6Z/P8h6urhj6ltt1dri0feL08sDM29BnsqOsOSbJJPHz5JN9LiUDX/2NYjJUtVg67a8xTy88NkcFpfl3BtJCbhqc4JgMWozZSzDA3gpjRNDcZvwSq09WzXztK+bzptAKNLUmqXLHZoHcy6ljBxNZdGQ8y+5LKJIRkr7bgEfYzked7PlaPSr/5teu19pMrr6rHehe1A7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKWmhNbByDatApmgWMQT0WqbNpUh4YEVeADIIqU6iHs=;
 b=ej/DcKsWl69wAU2+r/AjGlZpuQpIf6KreI9JtAE3IOpoc6jcpAEnRfEO99IGZlLy0e4KKLMG+TugdD+mGT6AkeTttZ6nJA3nu+Cx825UhyNncM6C8FgTUXrlIS4jTfTHqXW61SeBfFj2miypyEN39ICMs6mVP2qHsJpzq3uolmmjJNQAkhdyh1cC9BF7BNoO7gd309fgRrPmYSjM0AUXyOCtjkk+Y67+LmLAdOoMVpHx9zom6mJ8e4o2Tlm8+Ji24a6FMKHXw8TomyJA/ybwAJqPiO2Q0UcPpX+XHoEj9dQaRKReSrA8nt2RAGmEKllsNOhcjO5tZB/FGr3HnZGrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKWmhNbByDatApmgWMQT0WqbNpUh4YEVeADIIqU6iHs=;
 b=vVVvWgVP6/MFbC2TlZ2lb3QUdhmkwfDC5G4MHCkjFtYXkNe57ABmv4K7niwNMSD8fskkVg//izvYg44n3MkNqa0SaOMFBgEzwx24ahDhlMs5d0gyMQCax531jCbreL+u78dYPQ/cEYWerrhnE+KW+DlW2gUzw7wIyrogQauBEGI=
Received: from BN6PR06CA0006.namprd06.prod.outlook.com (2603:10b6:404:10b::16)
 by BN6PR1201MB2512.namprd12.prod.outlook.com (2603:10b6:404:b2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 21:30:02 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10b:cafe::bd) by BN6PR06CA0006.outlook.office365.com
 (2603:10b6:404:10b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:01 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:01 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:29:50 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/17] drm/amd/display: NULL pointer error during compliance
 test
Date: Fri, 4 Dec 2020 16:28:36 -0500
Message-ID: <20201204212850.224596-4-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2e4e3c4-5924-4bcc-6df0-08d8989bc26a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2512:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB251292C19B27FBA4B1599B98E5F10@BN6PR1201MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmqK6LricQoloA0DcPcrPpVp/JH6ODyXQ8Id5vhsfKG800z+ituKpHvTdXozpVarWX6ui6Gt6Tdle77ID3EQ7+SoQXKMjEbjvOElXpW4sd29qzGVnt2xD0FdvMnY3PxrX+JaVZzzATOaIYydhP5Xu+8S/90+AibM+wn6lELrIKK58eBSKOtdF5lwBzITrF5ZDdpPdXwTkqss8Hrb7K5XQ4GCleJx4fSCiFh30rWHcAUe0mRv7t2HpPQXGaVzw9zUChkN45S/f0SRpPgPsfqfm+627W8mLCUCirgxXmLU99qGl8BEn34qEAPbVBK+1TNmdsSLrQg3A+3AUlbcucHk9jNvTbkA9cfDm6pSvP0yODaZKSlhqEqpSfSbcrGHKaafoxtUlHD6dtYVajtOBgcKhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966005)(36756003)(8676002)(1076003)(186003)(2616005)(83380400001)(356005)(81166007)(44832011)(6916009)(8936002)(70586007)(82310400003)(47076004)(82740400003)(2906002)(5660300002)(336012)(70206006)(26005)(426003)(4326008)(86362001)(54906003)(316002)(478600001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:02.1583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e4e3c4-5924-4bcc-6df0-08d8989bc26a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2512
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
Calls to disable/enable stream should be guarded with dc_lock.

[How]
Add dc_lock before calling into dc_link_handle_hpd_rx_irq.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5cb4654983eb..2d2c8a3c809d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2563,10 +2563,11 @@ static void handle_hpd_rx_irq(void *param)
 	struct drm_device *dev = connector->dev;
 	struct dc_link *dc_link = aconnector->dc_link;
 	bool is_mst_root_connector = aconnector->mst_mgr.mst_state;
+	bool result = false;
 	enum dc_connection_type new_connection_type = dc_connection_none;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	union hpd_irq_data hpd_irq_data;
-	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 #endif
@@ -2579,13 +2580,15 @@ static void handle_hpd_rx_irq(void *param)
 	if (dc_link->type != dc_connection_mst_branch)
 		mutex_lock(&aconnector->hpd_lock);
 
-
+	mutex_lock(&adev->dm.dc_lock);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL) &&
+	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
 #else
-	if (dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL) &&
+	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
 #endif
-			!is_mst_root_connector) {
+	mutex_unlock(&adev->dm.dc_lock);
+
+	if (result && !is_mst_root_connector) {
 		/* Downstream Port status changed. */
 		if (!dc_link_detect_sink(dc_link, &new_connection_type))
 			DRM_ERROR("KMS: Failed to detect connector\n");
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
