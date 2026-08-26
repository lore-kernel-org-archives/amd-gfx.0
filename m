Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF84C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 03:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14C510E260;
	Wed, 26 Aug 2026 03:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yoa8yZUb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3312010E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 03:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgblgbrRbvxvkfSKIZr22s9cBI1TVLotJ2NaVm8lhT1K8KmxpObG4eLoC3Ss8889FTguz/LHoxsf+I6HTuPZdcpqAXaVJYiYgFkfDRe9Gqh+YFM3/kNowS1AzbvsnU4OLQW94Dl8P00MZM8FLmEjD2m3MaR5e9gzPhqHe7lopJtDP7MYRb4G+TOWArfw6/UIqSKp6CtIVI4yb4F5+B/dlPFIOs3e1wv2X8TTuD6MAftDkPHdrNpRnfwhM1LG7yoIZOUVfCWjftXEx2rQdoEo8kfP6tQEhHVVMZDuX5OoI2r41ocwb+7JVtIZDQ/94Q76pDKF6lhBmChpw9so3WhXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7imhlFrxHkBvAMtP6B4VbkJ+qklErl2Rtx9kMSfuAg=;
 b=NtF5+37r+ROTH8y/UJ+VgiYd1c2kTbO4JA6mWvvkQvbcbSP6vwjfn8OxJCnrAwAIpxkfM2uWtmaz0Y60nh09Fg6gCnhyIzTgb7xZG8QO8ErHEyJKqAeAerjPxBhkI2yS+WtI4wrJQdoh4IIKa2gRMxU86p/UH0B5GiVXIbd3buF7vxwo0DZQpiieQbvRTn+Yulpaj6FtViWF7JD4aq/IBEh5Fr68kmOXiE7rgalkNgfjysoUdSyn/Adh7hVT+MhNSK2oswiyXCQGSkDw1mBwKT8RwR4T1UkJapWRciKIqo46UdtTcVf5btFRVIxbYCCzJ6vM6XNuIpisU3MSx/17tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7imhlFrxHkBvAMtP6B4VbkJ+qklErl2Rtx9kMSfuAg=;
 b=Yoa8yZUbHtzfdoJKBBStpP6SZ/Jj6lrTZ7yA3zTREZDU1sL0PVbIfyTlgQh4bv5zg4dUt8rj5SlCGBeudvu4tPDw427Cigi1AVUbgO1uH6Y6wX8C8lidHCBwI4Df8XFJSSmbqW56DLN6GrUFlg3o5p/OJZX1rKKW9T0IBGalHIY=
Received: from MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 03:27:29 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::31) by MN2PR16CA0046.outlook.office365.com
 (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 03:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 03:27:26 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 22:27:16 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 3/3] drm/amd/ras: report the banks the scrubber logged
Date: Wed, 26 Aug 2026 11:26:06 +0800
Message-ID: <20260826032606.470702-3-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826032606.470702-1-xiang.liu@amd.com>
References: <20260826032606.470702-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b90cabb-0c1d-48d9-2a0b-08df0321f3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GdqlYvDR4riCJ5P/8Bcu3wOadNMGfPp4cze9q0cxce4bTnbvQQAUWRakJhZ8TqG3I5HBNFcYCRggX1AmZJwn21EV6V1bK3fHrKQ3JO/RuLOZGTG4+yCXnOmNL4yq1ZSvyPHq90T8q9vevUOR62qnPExTJyiVifmRWsqKuIZrrq75WB6NDmNM9EQ5pJ2ucsidJoonM21paab4h1gP57lHXcZNq/BkPD8XVPAXVGx3OTd81gWIm22F7EN20l64qYi85+D4eFXXzQleNY/0f8nixidlqZFXvfcvwKYfOtZ37yEJCc+iqRqqvRI6aTCNiXCVQlVvQP5vMOb5ic9uRvesWfLsaAYp0oUY/33whbzkOiPpjUlQn9D/UYorBLQM/DBIDrjh1z9mmffJzTd64O8nvLerzUfA3F6W8pRIqdsJU1HXnhk8HAsS2xRqf7Mq7ET5RK6NkYNPZT+aptihgE+mW1rVcDfDTpLfFkQDBkrbsgbNbadQWm3Y6EjALazt+hb6trOrt0KupVf9H9QpiNpbAjZc6HOjFzs3rkvLekUyvga1U/2jthozGvBU3ptM0qdsD82lTbZyXqbh9f9uLZBcxfQNVqtf29Io3fWYcp+UCVsBbd4SlM0nnv15rCN3SRmxTgtWgZ+R6zJs/UfjmbKTyr2db3ltLU6te48LyhovZMUC/jkLZ7pOYr9nvThyvGSd3+4Imw8GoAO4oE6sMuiaeA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kORUASdBpr6pz50Qs2G3VFezSWLsxz9ZUdiRZADGUHpnBzeHcsNVIzBdrCyYgn/KYSfGLhctJt5TQ2hde/QQgDTMmSlHaBeB3v1uae1HBJf05d7PSUoGdZCO3WHKAYURHJdlJFqki6TalfCOd4uQegDy4x4lqCLqtRd1BYusaSyBp8Wr3lR46D9KH7qP6fX1zdyYHWxnkvdSnTMQM12hdxbw4odxUrckGtHm7nJ8+LPoCZ2ELF9OxhgrgpWfdToSTVn9DXFClix0EgaflP1zk7VzgmcfM3lJ4tPxaL1hkpeJSst+HHv6ddDlNzLk6EQSmAOCVnpKdmSvI0l0ZVrdaUmXJ3ZeFQ7eliOJjLc5Ul9OqxMO4tcy4s4LxhhmdfhdELcSkf17nkjJOtPulBfHteKvfc+jZDIxCLo4h0tcZkgNmqd+bgGJUC2bFJIXJiqN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 03:27:26.9499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b90cabb-0c1d-48d9-2a0b-08df0321f3ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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

A bank carrying the scrub bit was found by the background scrubber
rather than by an access, which is worth telling apart from the rest
when reading a log.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index b40098406174..881681ea9f3f 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -128,6 +128,11 @@ static void aca_bank_log(struct ras_core_context *ras_core,
 			"{%llu}" RAS_HW_ERR "ACA[%02d/%02d].%s=0x%016llx\n",
 			bank->seq_no, idx + 1, total,
 			aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
+
+	if (ACA_REG_STATUS_SCRUB(bank->regs[ACA_REG_IDX__STATUS]))
+		RAS_DEV_INFO(ras_core->dev,
+			"{%llu}" RAS_HW_ERR "hardware error logged by the scrubber\n",
+			bank->seq_no);
 }
 
 static void aca_log_bank_data(struct ras_core_context *ras_core,
-- 
2.34.1

