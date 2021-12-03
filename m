Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC661C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BCEAA48F;
	Fri,  3 Dec 2021 22:58:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DD57BAEE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeVLV4oeDmwYn08IWxzZtTWF0bxyMoWokq/huqsX6d547q5yLnCF93pv/6Crqiy152HgGma0PfiOFn2GjdoNpUNFaRfQoC0izsh0fAk/ThQV99+e0RKW4c5WGzMrCQTVe/Y5ojibwcE/6tqTriGw33mjMPJxr3LJy8hRNv0mtX9KlbIsTgbFZUDQ2yTfpstLAWE7RbCc9nt9D3tsJeV/DvC2cWiWyohuUiTnsFjTQ7uhGn/nRH/BqUdxvR6OFGbGlJ0plgAz8xQZ5inykjanWkMga8Z8/tjlsNHos3nhNx9Z1MqRhgKzAnEUVZfi9CrnAPdeNNbx7lNjRHLW9VaPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7ZPUCH/SMfnJ4ZigQra+sCvV5YAXmTSqlJLJu5+aDE=;
 b=fvnBNgceDxj7a6I0hRRcReAOWz3Uz/gzxOCxw1WkVRGtyvGOUko5toD3qLr7RreNKwKWWZMeQhQ5WF5/Pmi7+0mWxJow86iNDwfnY5GdRM7NYpJpgW+iyDTNm9+i392tLxovLlzKgH1zOE2e5S5rwfm6edIMmhra5uVjvwAMM64Q0XIoM2+fa1ZEyqfd1ebx3yGQdeBntV+VaQhNMrHACPjbFa48Ix0vQsSg60gtyXZ9nD+WL1/YIFMzSOGJc6CkrQpWjiatQMq4FGwST9/AtzMgWjxM0v05QqtKELilB+67Gq+1P0JmTG5gxMjYJoo6yudBoTu4IFCUrHNsFiB93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7ZPUCH/SMfnJ4ZigQra+sCvV5YAXmTSqlJLJu5+aDE=;
 b=QFFK94L/w8Gph5yJXzeH4hxJ9a5upXJmPudzA++GPZPYsx2v2Vn0/kRgSOnDngoHOK+Lxbthhmk00mNRvileoWzbcR56swGC5lr/sGKkuMHUUMjGG140f8YVQTjZhdJ3mZBs0CrT6fghD6t3vgq+6Y7uQhlCrmWf62VddLIbNcw=
Received: from BN6PR12CA0030.namprd12.prod.outlook.com (2603:10b6:405:70::16)
 by MWHPR12MB1390.namprd12.prod.outlook.com (2603:10b6:300:12::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:58:51 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::f1) by BN6PR12CA0030.outlook.office365.com
 (2603:10b6:405:70::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 22:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:58:51 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:58:48 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/15] drm/amd/display: Prevent PSR disable/reenable in HPD IRQ
Date: Fri, 3 Dec 2021 14:57:51 -0800
Message-ID: <20211203225802.651367-5-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8aaa8a0-9a0b-46f7-03d2-08d9b6b07907
X-MS-TrafficTypeDiagnostic: MWHPR12MB1390:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13904E23FD3CE32A2943862AFC6A9@MWHPR12MB1390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KZQ0OgR7zYM+aKH30W3hrZ3cWkLu3f50yTS8iuPmJKJGYbAO7f6IvYJU8fNKatQwBVxU1WnoyIrW9NMgwOKM8Rd7xFX/zQgkJPtQx1IduPBlNArciEcB3OaE4zmZmsCWlAR2xN5X0+OqfB7QN42zm7ZdnLo2HESeV1UsiTjuapEIjzmMGbvjPSoFYhvv3O0mG8yDgpS49tHWi6LJJy72m8BawFUbm+rO4C/Imc5HBS/1o1CIjuJxxL3kKsxsOrjXD9Gv6BDU2JESj3zuSkix1WCXlr9cahSd+6zh9n0AEdJI8LGIs9ZT8WaSSthMbNHmIOUmxs0Mx4FQfAswp0DsY/tMCeVNdiTYeHTwb1qEQaEehNvl4OBZI3cYkO6PUzye69oFOaiTDYHog2u369c7D1VoG4AaulZ7T+lD9b8kedia9YY4dkV1Ierw5LOsMb9j+CvlIr1c56KeGaqwVEVzEYdSfhe9M9gCIg91Acgg3chN0m18HXbTd4qiYgzKhEpb/gYEAB80a8VZZAw1khgpwb+iFhCA7TUfmIcPTrR5tSCOU7Hce3xyWi3mG5/NCjWokbmalV5jXhnU2+rDHyCX980w/6Gm5nMRaJvgV2Ad2L/YFCM9/WXFIEDmRt5tnrMZF8shfB2uNlb9y6Ye/DieRoEiEe9olmdqPqWso6MWA6Me2PzWfeRC6nDWiKBWTn9+emsw7WM3msSbwPj0cRs09CQm1fW2nzzdQ3Oi68zOC96/h1kMSwjTxd+B66yZCk6Q0VKjG265Cw/a7a9MqnJfTa1xH+h/Drv98keJqH6JRA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(83380400001)(4326008)(8676002)(186003)(54906003)(508600001)(8936002)(1076003)(86362001)(7696005)(70206006)(6916009)(81166007)(36756003)(6666004)(82310400004)(2906002)(336012)(356005)(16526019)(2616005)(5660300002)(36860700001)(26005)(426003)(316002)(40460700001)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:58:51.0169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aaa8a0-9a0b-46f7-03d2-08d9b6b07907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1390
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
When HPD IRQ occurs, it triggers a PSR disable and reenable
directly through dc layer.
Since it does not pass through the power layer, the layer
that tracks whether PSR is enabled or disabled and which
masks are set, this layer is now out of sync with the real
PSR state in FW.
Theoretically PSR can be enabled during hw programming
sequences or any other situation where we must disable PSR.

[How]
Check if PSR is enabled before doing PSR disable/reenable.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f5e43a79c562..2cb40912c144 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3841,7 +3841,6 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 		&psr_configuration.raw,
 		sizeof(psr_configuration.raw));
 
-
 	if (psr_configuration.bits.ENABLE) {
 		unsigned char dpcdbuf[3] = {0};
 		union psr_error_status psr_error_status;
@@ -3873,10 +3872,12 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 				sizeof(psr_error_status.raw));
 
 			/* PSR error, disable and re-enable PSR */
-			allow_active = false;
-			dc_link_set_psr_allow_active(link, &allow_active, true, false, NULL);
-			allow_active = true;
-			dc_link_set_psr_allow_active(link, &allow_active, true, false, NULL);
+			if (link->psr_settings.psr_allow_active) {
+				allow_active = false;
+				dc_link_set_psr_allow_active(link, &allow_active, true, false, NULL);
+				allow_active = true;
+				dc_link_set_psr_allow_active(link, &allow_active, true, false, NULL);
+			}
 
 			return true;
 		} else if (psr_sink_psr_status.bits.SINK_SELF_REFRESH_STATUS ==
-- 
2.32.0

