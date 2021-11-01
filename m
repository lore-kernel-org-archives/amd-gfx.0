Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFBEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 18:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0275360EDF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 18:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0275360EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A026E442;
	Mon,  1 Nov 2021 18:02:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E09C6E442
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 18:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNEufr41sq8zPA0qJr1+tRV8sCOb1EWgMlozB6NaUWBHgZzKx1gzgUl1D2gAjbgFBZHjmQu1khEahlPonOIfDG4GHe+lmnaFdTck5RlT2XluUyYpmS3Wp5Vy1ZUiAfkC+Y57l41O3YmirbrXQ15cVWc6wW+s380usyePPzAZh8/jINBgESHx3BGwL4FI0fgG4HAWy0qfwifvlprF8OQI6RgDxLd3d/5w5XM7MtEDiVQ3tWalkT+Uj6yBUBs8IAS6eLQcjBThRDDFmxBLPSiN+O+sdqMmE54cVsH6jCWP5ehjzo+3DNU7hbjbFg+ToUBtKVQIzul6Cu9+Uv4MEx5fJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O3Kq319A++GpCVNbtNBJ0FYGg0qaT9Q25tWM/PvgBw=;
 b=GwUgLy/Ap9k5p8+sVrulNyvHJ5XGvDfilaCGxcqcvrnvrS6QesOfJgxGuSXuEebucBgx4gzbNTMa89M0r+D5X+HlF2AycCpVbWH3jWbz6fOlR3kiuiXDwp76VVU7nEMfahIQ00fHXfg7jkVJQ0a8toxbOxYNOATlM2Hq0U61k9ZNxw9qEh5D8uRX/GRQwqMsBfh3AHBbhXrvDIq+EQ09eaKW2aojuIqAJnro25W4F+d9iWxO4qTk3rnXL894OwSHIHqGjwLh5wX4AP1WPcQRWK3rl38y8yis3L0O+671ImVBwGzCTG0WJbQecJ19R7Vqr4vYrumjVmjfKu2adBPzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O3Kq319A++GpCVNbtNBJ0FYGg0qaT9Q25tWM/PvgBw=;
 b=GNaqRDVGKTSdjGgduQ7C2ckM5XpP57cZJoQQPPU4yj2/Nm6yOG5r4OM8gZx9toUjXnVCkaHoIAllBVkgraWvsLbhOEuLAwC0Ml8TqEjGed03pn7saOo9LH7jYuh0LIWXtTvyeCDuyxjMbbnFroK27WkAxMqTPVX4it0YXiIy4Js=
Received: from MWHPR15CA0065.namprd15.prod.outlook.com (2603:10b6:301:4c::27)
 by CY4PR12MB1765.namprd12.prod.outlook.com (2603:10b6:903:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 18:02:07 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::34) by MWHPR15CA0065.outlook.office365.com
 (2603:10b6:301:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Mon, 1 Nov 2021 18:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 18:02:06 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 13:01:52 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: update gfx target version for Renoir
Date: Mon, 1 Nov 2021 14:01:17 -0400
Message-ID: <20211101180117.144165-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b12591d-86aa-467d-b998-08d99d61b7c3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1765:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1765B1645A39D1743D8D2BE08A8A9@CY4PR12MB1765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjAWbiNgF9VaX+oyf/S5KDBpRZBLE090f+z1qXJH3t2Cwx0sWDo+RLspN6DSbm8ijMPV0y2yck2gX5eWvdWxZ/7q8g3q6qcWD8CPX71Zpa+u6VkeQkqWtC/IFuGvRTjOpezhMzDPvW1TgyiWx0OWi3UFQe92+INsa+oEVIW5B4gmvLwaBof20Ai7zty0V+vmlsZN2qsfEm/Mv7P6Xx+6lG9U9H12gqQ+qTSHaC59fJIm6ZWmrsnwQ9rquSx9icrCshSE7sTDOsqpAxA1qvRWMVnvQhS/SKzxSmAVFfumQchIlvuf6SG3dHTbuzMwYZvXbr81JFCTWRT8otV2m26iyF3YHFODe27/RTDKvkM+qZg4Br5mCdpmGnfrO6j+4d9u0L99vizq4kIFPyxF9VGVaODIxf04bl52S63vnSHDFFlA7eiW3PZWgEcYRAeHZmqXVw9l4koNAQb+vQVuWEXOt8EhpweHCsugbmZ2NgfKgw0L1brFoNIYicGqUyV6bvc1nDJR9rpD7vZcVweZHuPbFvOZ0yFOBi77RkRHe+v2x1ntsyU9Kjlf026Nbw6Tm8+eaR2TXYXdSduziJXsmwjZGm0gHT6PdxQkfsayL2HspQp0/nMCi2VtAYvEVPJLnHPhk2tecc+RXIto2Yi3oiyqHd+96yUott+WeIH1OrNcb4G46BGsmJDV8mxgYxw1nMCiEXgtIkO6BN8ykjbKjGrDPgNZf1LVLtaSKRPve7ITtBs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(36756003)(6666004)(26005)(15650500001)(4326008)(356005)(36860700001)(86362001)(186003)(5660300002)(82310400003)(81166007)(508600001)(70206006)(6916009)(1076003)(4744005)(2906002)(83380400001)(8676002)(8936002)(426003)(7696005)(336012)(2616005)(316002)(54906003)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 18:02:06.8392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b12591d-86aa-467d-b998-08d99d61b7c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1765
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
Cc: Ray.Huang@amd.com, Graham Sider <Graham.Sider@amd.com>,
 Joseph.Greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previously Renoir compiler gfx target version was forced to Raven.
Update driver side for completeness.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7677ced16a27..c8aade17efef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -406,7 +406,7 @@ static const struct kfd_device_info aldebaran_device_info = {
 static const struct kfd_device_info renoir_device_info = {
 	.asic_family = CHIP_RENOIR,
 	.asic_name = "renoir",
-	.gfx_target_version = 90002,
+	.gfx_target_version = 90012,
 	.max_pasid_bits = 16,
 	.max_no_of_hqd  = 24,
 	.doorbell_size  = 8,
-- 
2.25.1

