Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C86AC07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 17:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C616113A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 17:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C616113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFD26E1F2;
	Mon, 19 Jul 2021 17:49:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEE26E1F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 17:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRW2HuVrCAHcBglbUMqDzHf86GkVXrKR8N4INU3Gnyi9Zy6Xs6+0QeJLoQW1JT39Zu8EWW+zBmPqthiNggOL48B3de/jD1mYJrdMPOzUGNb2zS8A6Ko/ulSnJJ0zauzrKheSFxfK5CMt8+trn2Tmqs7IpkBXpNgMSikNq4+4I5U+RPdF4XrrQtk8d3Fq8aMfU+JzeZ1BhGUAHH7VQk3JRmsB6cWGbr5vjXPBi91Zu0ZdJwDnJH3+U13TV0VhU4X6ApzieQCSV9t7FYKejGLMz55Qe6e5m/mX5kROJtqwR0FtrZM6DdwurdQ+HTaunmtTyPp2IztRsjkzoKDSY2OGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2RRdmq58/zPfDu/hYGy12uJQ0rV/wyJyRZUrNUZY+E=;
 b=A4dXtcilL4WK474UyfdBlilsiKWpeWErrGEQj/WH8NqOSx3qS5QRQJnxA5VPqc5F+wz81cIjvrZ8hgaNLrOED7N8qdWjyrmTiMuRSbLVLFOBXOHFpeNFsm/oGXBVAoUyE4UggmHZtep/U9GIj069iLEfsI6A29fmxKYtZhHE/NMNrxnOITG/dF9cmt+eAQkrdkvx8ixLnz1Y8z89n0kSE9ban9oHw2ovmnWhqOgxlqfqvghHubbHm2HvVoKyfVEmjtWNRX8B0AvitF7BMjkkkC3w0W/m2TCS+PZMJE+TOkql21RQKvsSUwAqUc5CtMSJH7MYelwo3dxR7/Ifep55IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2RRdmq58/zPfDu/hYGy12uJQ0rV/wyJyRZUrNUZY+E=;
 b=h9Ot4VY6uW6+6p8wVwJUw/5irS9DsQqN8pElilM0FKpl5IKp88jUeZ2FpYscV0dHR5Hx6mOv4Fwx3IoqwScd55eqD6DsdtPSn2vTIQUlWHmB/BmoFVRzgAW2Y6u3IkHt6r7ZURVDlDZkobLY9eoq1Vu4+ro+yyiiKPZsscM3XfE=
Received: from BN6PR17CA0031.namprd17.prod.outlook.com (2603:10b6:405:75::20)
 by BY5PR12MB3651.namprd12.prod.outlook.com (2603:10b6:a03:1a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.32; Mon, 19 Jul
 2021 17:49:18 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::41) by BN6PR17CA0031.outlook.office365.com
 (2603:10b6:405:75::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 17:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 17:49:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 12:49:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 12:49:17 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 12:49:16 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix documentaion for dm_dmub_outbox1_low_irq
Date: Mon, 19 Jul 2021 13:49:14 -0400
Message-ID: <20210719174914.381575-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e1677e8-ba28-4223-c327-08d94add8815
X-MS-TrafficTypeDiagnostic: BY5PR12MB3651:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3651A77EED32C468FC53283EEBE19@BY5PR12MB3651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvVrad77N6KH/QXTji+Wb6r7J1uaQM6UIRM9IiatSILaz0j2I5uNjdEoVX0LgRZ+LAhrrDgWCrajj4tFcAznAat2ZPAz1Cm07DTynyPLlyZOPggCG0o1DPkIcsSwjxtNp2AHXCZWk3E6+kzUsDTQkUkH3uOSJ/VV9b3NaguKuSo+zxohnOAW+S7AeN+MHCnrFP02eddD+9io0Gy9YnXSAIGOG70wpZO+IpH/RY/0PYRZ8r4uxlNyZVq2wu/OcsFLg435u6HYciWXULeuhDPRO9mpFMO8mxhnTJqgvQoq0lrbjq34lNEM7I14GUN0wpum69N1RHMkrrFQYnGpytrD57IlvjyCYEP5EgknhIVhrdWq+b3ri7Rxs96Kl2cLD8o93o3WZPPvxk1QxA4MHIU2U8a4K4yLIG1aObfb8n6LTWiuFzk2KURt8JKK7ssVd1e03jwcaJf2aiNAtACUtQEWKo0/hI7MSn47eN0DUkNHGJ828P7/BKneys6HDmIFf4o2T3rCud2hSJbaXpWDpFBHguEfs15te1lbTQYCRwTrWygQcklpV5z/w7pFOLoLJrBPZ0KuSu1KbEpoxdlMC0cBNjp7XKS/8dzdOT84FVUxqS/cCtq8he5ImwHtkodzcTl8aU4zKcRRutCoWY8yl+ERCX7cTozPp7mWGDeXHVGjB4iKzDY7mRl6wso4YEu5j3ObT+Fi+JVRuqB0MwLRDZpkjrYqXGpwF0o5779LXKAqG2g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(4326008)(47076005)(81166007)(356005)(426003)(8936002)(508600001)(83380400001)(8676002)(2616005)(2906002)(82310400003)(36860700001)(86362001)(70586007)(70206006)(6916009)(7696005)(5660300002)(1076003)(36756003)(316002)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 17:49:18.0461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1677e8-ba28-4223-c327-08d94add8815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3651
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

Fix make htmldocs complaint:
./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:628: warning: Excess function parameter 'interrupt_params' description in 'DMUB_TRACE_MAX_READ'

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7ed104e3756b..02bba9a202a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -625,7 +625,6 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
  * Handles the Outbox Interrupt
  * event handler.
  */
-#define DMUB_TRACE_MAX_READ 64
 static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 {
 	struct dmub_notification notify;
@@ -635,6 +634,8 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct dmcub_trace_buf_entry entry = { 0 };
 	uint32_t count = 0;
 
+#define DMUB_TRACE_MAX_READ 64
+
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
 		if (irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
 			do {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
