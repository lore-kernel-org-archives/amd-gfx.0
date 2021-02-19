Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3BEC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C37160C3E
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C37160C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1086EC2A;
	Fri, 19 Feb 2021 22:16:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C096EC19
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blxW9Ib9M02XZMHr2gZryBfbX96SNaZBP5qBXm2KfHijPQXzBSN8xHjdH+x6aHr/K7AGg7Daw7DkvnQ6HpCmS/qoxEoi9L0oD2PPtxHQLTHtkc+A/nO6Ifocoz401SlqdwQibiSNZcdPeTpKN7znWw+wExA9Vb+v50HBNXDU8UsPvfXNLcrI2WHHEbndgAjRDSnJO92CrXNY1Cj7SASxm+9A6j+8QkEMOgC0Wseqgnoh3KQryOljtZGMUPSusZlsT9l4ixemPWo6FxaYdp4INq1e6KwINnKGlAbaw8/f7jGt47rlhrhB9AeCCtih+kvFbsehrLyQzFnEoWZlmCxp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3LQBKWjqt+r5C9RvIXLx0ivaKBVDQTiIIvtzK4auOI=;
 b=PYZsOK5J0u3V2vpUjUh/9YHzpq2ZdGJBrFfZgYVpiWfruLW+dg5dmTLlL+7cTJyjlM8mnj5wTFg2BoIj8zR/o/IhHNu17XnH4W+xX3uqIRFfnh+OMP5Tz6xhtkmI/uy6PwfetBuwVbcPedAiZ0u844l/ndTcMPLOqdyZYqgdFTu5OdyBsCOdtbw5QnJ/1N8pfvjz1yF6oJxn35++Tn5JEmnjw1oiTQLGaVNNAa1omNB8w/F4M/sVAkuEw/shuLs5k0uOAlwlIFtXfJ5pYCEU9Ne6I7XxDsIWJ3tZzwoqlS9IqAHZ/X1ImV9dljoVM3eDJrC0lAZwKw454AKPJcsqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3LQBKWjqt+r5C9RvIXLx0ivaKBVDQTiIIvtzK4auOI=;
 b=t5wYzQfqhIWegNsHGDjo9CdNQ+UpOX8L/HtIUmB30cIzEyj1T32vfyx4KDXTCBaltVjenhYT3xBfBx/3h8rpr1IYbWiNqXXQmJLXVE5x9ui4YHfVIcGdtfleUc9dqr3VnzZb0LuFMNNkPZs8wNjbn2XyhGfoPwBEwFTau/wFPxM=
Received: from BN9PR03CA0857.namprd03.prod.outlook.com (2603:10b6:408:13d::22)
 by DM6PR12MB3066.namprd12.prod.outlook.com (2603:10b6:5:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 22:16:43 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::e7) by BN9PR03CA0857.outlook.office365.com
 (2603:10b6:408:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:39 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:39 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:38 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: Add vupdate_no_lock interrupts for
 DCN2.1
Date: Fri, 19 Feb 2021 17:16:02 -0500
Message-ID: <20210219221612.1713328-4-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 118300dc-07d4-405d-eddc-08d8d5240901
X-MS-TrafficTypeDiagnostic: DM6PR12MB3066:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3066CADFBD9A5E9B306CFC1BF5849@DM6PR12MB3066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYXnU4e3qDxciECyCRP+Vfj9rPRIZQSAcOZ8uj8sVI9gHoBJPd4wlNway27bGpXiJZ1OjNdjw68ibH3eWQ80VxjylQmBmqB5+UrJjkadtNPcaviJrZ1LJJi22YfULP/ehipJsCfOaqEjk5NbbqBy1MAkVj5wcF220BEzYx99hC2ttqV+Dnw6sajknqC+qpI//7khwNNTHo2C03GS/xsz3GoK8SYRkX5WlJFfR1T6LylprscX3xq5k508uU5MuC5M8D4iuLnqVQP7MRaarfTCVEy0rJngjiAIOX/Q6J0jktwfNKG2rZ3l8n6eVpnZs4oSoLGTnrUuYdyU/PyMNhbc4ElfeVHoTOUF5JjIPJYhXOg/WMQjfyy8uIVWXF0nxg8Brsm74GNC0VlAV+0kT69ap4SyHBcUbUGx96wri+/Z+0O6IAg/iRRv8XlEH3W/CxiMwBaZuX1c32gCelYZkOgmb0DBNYqge1muS/25lPKRfS60v8KVeV6ykgZLzJcrpDRyr8nKBz6GgC5SG3R6SLnJJcyWbT9Zj9Ys8LyG0hqJEHRN1qBehiOAV2Kc3sLlUand0Myr/tkhLxy9V7qJDtBnk4cTh8tyL/phIl6pDxOCYwMwlPOSnpsYLNM5rMXKU+cJhzQP+hM1ZAAexWpkpVoFe7lnTzxckn9s4SgSbAhv27vIpqYFg49/JiQwmRHkHQm3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(6666004)(186003)(2616005)(36756003)(1076003)(47076005)(316002)(36860700001)(356005)(86362001)(82310400003)(8676002)(8936002)(6916009)(336012)(478600001)(81166007)(7696005)(4326008)(82740400003)(70206006)(5660300002)(83380400001)(54906003)(70586007)(2906002)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:41.9135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 118300dc-07d4-405d-eddc-08d8d5240901
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3066
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, stable@vger.kernel.org,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

When run igt@kms_vrr in a device that uses DCN2.1 architecture, we
noticed multiple failures. Furthermore, when we tested a VRR demo, we
noticed a system hang where the mouse pointer still works, but the
entire system freezes; in this case, we don't see any dmesg warning or
failure messages kernel. This happens due to a lack of vupdate_no_lock
interrupt, making the userspace wait eternally to get the event back.
For fixing this issue, we need to add the vupdate_no_lock interrupt in
the interrupt list.

Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../display/dc/irq/dcn21/irq_service_dcn21.c  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 1b971265418b..0e0f494fbb5e 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -168,6 +168,11 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 	.ack = NULL
 };
 
+static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
 
@@ -230,6 +235,17 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
+/* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
+ * of DCE's DC_IRQ_SOURCE_VUPDATEx.
+ */
+#define vupdate_no_lock_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_INT_EN,\
+			OTG_GLOBAL_SYNC_STATUS, VUPDATE_NO_LOCK_EVENT_CLEAR),\
+		.funcs = &vupdate_no_lock_irq_info_funcs\
+	}
+
 #define vblank_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_VBLANK1 + reg_num] = {\
 		IRQ_REG_ENTRY(OTG, reg_num,\
@@ -338,6 +354,12 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] = {
 	vupdate_int_entry(3),
 	vupdate_int_entry(4),
 	vupdate_int_entry(5),
+	vupdate_no_lock_int_entry(0),
+	vupdate_no_lock_int_entry(1),
+	vupdate_no_lock_int_entry(2),
+	vupdate_no_lock_int_entry(3),
+	vupdate_no_lock_int_entry(4),
+	vupdate_no_lock_int_entry(5),
 	vblank_int_entry(0),
 	vblank_int_entry(1),
 	vblank_int_entry(2),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
