Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36D606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p4+wM5Mc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB6910F952;
	Wed, 21 Oct 2026 06:27:01 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555C510F956
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRMX2dsXezI3cD04GB9yaanS8+4z8QxSRIO2z+mg8ehlRTVon/uad+n0CJ2+9iJS1csymi67lRIMfno6bhDxsBrBZ17G0uQx/U7hJPmm2xgPPXrkzG1rxRmgmz2lE5Zd1i9ypP9f4WFKv7e3V65PxGSYqgTLYiyxS5hNcvOjoHZsHl2vqy/CFJb/V02kDe7DqcJXbF3u0HH0fZAV88OY0LKKAxJ9+u5RoptJOJriblGG48YFGnx09VrY8qAHx3DV30culbF+d7y4zWN6oFZGkk9MjfpWmuNUIO7uLwNMMjIxNAFPrVXwyiMmuOLMlvOey3MCs/kIGI56p9xEP6hdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XtVhmRz8LvOtt2ZxhCbkdqgEUtAi78/ib2PGkuUhSk=;
 b=Bct4avvsvJ+WI1kAKki+ItXLo/4h4eG98p58Elkt42JjYms8zZy5ZIyiUiYmNzuJt7sVg5qIV3xkDaxx0f/PrXzUeqPv1DMUIxRT5xRpQcYTtXsKqnVAgh6CSo8iqYi2Ldl2Ko0GB0uN3CTY/ZKBz0+PzKiAswa5s30ZOMJur0JpKhtPWeQe041lxxx4VPbrKexcN2slkTv9u3Z6uSjSZK1FILGc+GLptsbyZhjFw/dOpMP4PV6oZUcbytXKXTcsHe2eU5y2+aoA2Nuy59MwtZzSd7kW52A5jX3rRzZ0vA3R4ByzUTvQRh3lNrwEoKERPftj/gs01g+FEET3bWmN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XtVhmRz8LvOtt2ZxhCbkdqgEUtAi78/ib2PGkuUhSk=;
 b=p4+wM5Mc5mCX84avVDZ+2RZT/cJ1ljtWli2kpmO/8CXbrCRSw1y+O1MpGWYfo/JPE44r/9FYADVdJpzS1mwqRa8tj0rCZ2NAcUGHn9/94hRqzbG26p8nNdIGYBihnxrkf9/ZISZ6yKknt6w/Vu/K0gtXuW748scqHb73AnfDA7A=
Received: from BN9P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::14)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 06:26:51 +0000
Received: from BN1PEPF00018549.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::38) by BN9P223CA0009.outlook.office365.com
 (2603:10b6:408:10b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 21
 Oct 2026 06:26:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018549.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:50 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:26:47 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 24/49] drm/amd/display: Add dal_gpio_ddc_open_aux_once
Date: Wed, 21 Oct 2026 14:22:30 +0800
Message-ID: <20261021062519.674697-25-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018549:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ff4ca0-cad2-4784-c48b-08df2f3c4aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|5023799004|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: gB6Kc5mi5n1QCihvyDGGZ9kk62pz+n1iFBaZfdl/lJUOwl0E7yxLqLGgj0JFFMF1agbQaU9FTquHBFUeMp3sU31vfa33Sp1AYmVOCIbEfJogKUSZegOkiE0AcvT/SXSzAEpCIsOF1tpwKzQHlFWHM7XXxeDON2LIlN9AW45CtKgxMmgkwrr4Fwax3DhvjxyzALxquXRz3WrqloFzSfREHeVw08K1BtI2EJbuNwpOVZRMgEaurTn3SKXCda7EeGAut+Tpv9ZbV3DONjb+pYQZgKz86UWTI4DWKILKTkIUuydcfa/q+87rwQJl0pxkINBQajHbfnBAiXen6XywDbS/EFp+t2HB8MyDl6x/4gfLf3O4vtOoKOZUzR13WDHsh+3XC6MqOy8Ea+BtJxMWkJ9hCoDsqn0fbZtn2HsZzZ+vWai4hh4Dguor5inJ3ktUesxvDHAx18NqhQ2vClUv/bH3dkhZoWz19/tzZw2HDm2KATMNT5KWRQZP9XvO6VIEbeFjqLqxf/6Ug0cFS6kH4JZOg11vZ2paNKFxgXqoJ5sDgVuoUUZlVnS9f/vq92C56WvRDTPWAvb7moBn12+J5jeBLzl4rm9g7ZddBg7YbTWvm8/JbSAng1pQUzkeN8UXCjRzUmqlpIBpTRmmrG6hqauD4yTGJjUgWD47S/o9q4kdBAcaZnN3CR16WOPfPfZOdS25DILxb/BDQUmOYLXVGxIWMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(5023799004)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ynCFsBnX35f5gSgjEiQntG3owmVLlgqes+g1lbZiTvhLd6Q5KzDN9LtW3bZxj9ww8/O8FbpIP/e2XuN+Jh+dnMDgP0gJVaZE1ClqVrnpn74kWrJmcEB6hDc+olKlFowmKtI9/OGhcXQ0ALSAtAeVtT85E7VCfux/b6TvI+oLQZ3b/iTSCG+Y76Ncfpsb4bf3fjcW2sX6zwTCPxcZ2Z60QziAyoIpbUw/T0cD1lvheov4iqI+uhxGl/0osXXAuHWUO4hPOA7zMHv419884ZuK7NRlaRlqC1J7vtTrT6aJy1kbz4ElKrRnBr/nBDzIQK5broaAdpCnFX4bOvFQEicqtI8NsxrwcLtz9fcJnmSD7H7D0oCWkHlv+EPV2eTgZcx3AcfutjjDxM0FNCdUD02BJ5Z9s1WZ5/vzYslPQmgCgcK27v+3/NLfIsch9y0t9jnm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:51.1238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ff4ca0-cad2-4784-c48b-08df2f3c4aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018549.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
dcn401_init_hw switches each link's DDC pad to AUX mode with a
create, open, destroy sequence on a stack ddc. The BLS Executor needs
that sequence as one call it can dispatch from a flat parameter
block.

[How]
Add dal_gpio_ddc_open_aux_once(service, offset, mask, info). It copies
the hw_info, creates the DDC, opens it in GPIO_MODE_HARDWARE with
GPIO_DDC_CONFIG_TYPE_MODE_AUX, and destroys it. Nothing calls it yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/gpio/gpio_service.c    | 19 +++++++++++++++++++
 .../display/include/gpio_service_interface.h  |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 95f8b7c7d657..66010841dcf8 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -552,6 +552,25 @@ void dal_gpio_destroy_ddc(
 	*ddc = NULL;
 }
 
+/* Switch the DDC pad to AUX mode, one time only. */
+void dal_gpio_ddc_open_aux_once(
+	struct gpio_service *service,
+	uint32_t offset,
+	uint32_t mask,
+	const struct gpio_ddc_hw_info *info)
+{
+	struct gpio_ddc_hw_info hw_info = *info;
+	struct ddc *ddc_pin;
+
+	ddc_pin = dal_gpio_create_ddc(service, offset, mask, &hw_info);
+	if (!ddc_pin)
+		return;
+
+	dal_ddc_open(ddc_pin, GPIO_MODE_HARDWARE,
+			GPIO_DDC_CONFIG_TYPE_MODE_AUX);
+	dal_gpio_destroy_ddc(&ddc_pin);
+}
+
 enum gpio_result dal_ddc_open(
 	struct ddc *ddc,
 	enum gpio_mode mode,
diff --git a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
index 63813009a3a6..130c78600b6e 100644
--- a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
+++ b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
@@ -77,6 +77,12 @@ struct ddc *dal_gpio_create_ddc(
 void dal_gpio_destroy_ddc(
 	struct ddc **ddc);
 
+void dal_gpio_ddc_open_aux_once(
+	struct gpio_service *service,
+	uint32_t offset,
+	uint32_t mask,
+	const struct gpio_ddc_hw_info *info);
+
 void dal_gpio_service_destroy(
 	struct gpio_service **ptr);
 
-- 
2.43.0

