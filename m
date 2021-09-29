Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BCCC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 19:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9601161501
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 19:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9601161501
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025A96E219;
	Wed, 29 Sep 2021 19:57:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E4E6E21C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 19:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQA6N06/9VVfWuHSw+aNaHeXF9oHQmxXb207M0qxkJ1RkYiDdMsBiX8uvgZghjnLGgflyg1Cy1EqlrF4fQaq4JlKAUx106CShEDbYvzxZo5BIjlrS/4Gv6NcqcCxAfOsMXtCw/wwMPd1VVi2XVA9aw3L8CSB2JBd0Bag8xUBdz1tgMGXUasZ0UAQLcxPutCAqObhTvwnP2SePSgoGEQIvMV5SKM0XIrtWrfl+1RbDjLV7Qbvc9F0ajxV73lkRbRteBr2ug/Dq5Ha5lqCQ7wWOznrcbyIImUMowib5z+c7ioMZhTxc9FrKUxNHhQrg4DTgWD+7rie3LUYWRXtcb5tMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=xBIP9iZfS2rluYYAQ+0NrYHi5IlaEU4lLad9MgGiVfw=;
 b=Q6PuIxZBZ5WOJQ8hjPqt9LYz0oMAMQGhm4O0NCFDAVqpZFYWH6D5SCeV7v3DMtJMgpVc3Le5n9wn3IDMd2t5jmLro5ywBsADEtfE/NIcgfGg1Wg6bUl5TFuY0mwPRBf0waUXGVVFEbTq8LkD0YdLXu3uY2wVJRBfJxpGfg7o496dcPJVAQd3w1iApIJyeQqbUDSTHFlvOKsdzcdKCdyTz1Yp9OXwGf3LpIxtIHQvDr9xAWZepoEgPr8Ku5+x8RWgxivuUS/CNHuS4dizLiz7OKXIZlIDwGwjC7Dj7u2NE/E+VLeu+APoZf9qq9H57nC+NDF0BQe+mCrix3C1dMmTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBIP9iZfS2rluYYAQ+0NrYHi5IlaEU4lLad9MgGiVfw=;
 b=jwrRjEjPeoUAqP7excBbfSJ5FvQ/9xZbrJ323R1ETBX9qmMB3L+7K6FHmNxaFtuEGn7WYW94i9oCqT42bLiFQ6fvkhFXS4q6S9C2XIhb5oF1hKcbOwaX8wNa7uuXt4n5grQvoudtlgRMn6iMb/APoaqTOjW3q+UaNm72FL7p190=
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 19:57:19 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::9e) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 19:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 19:57:18 +0000
Received: from work_495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 14:57:16 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jamesz@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/jpeg: add jpeg2.6 start/end
Date: Wed, 29 Sep 2021 15:57:09 -0400
Message-ID: <1632945429-7902-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632945429-7902-1-git-send-email-James.Zhu@amd.com>
References: <1632945429-7902-1-git-send-email-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c0cd696-a5b7-4844-114a-08d9838357e6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4323:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4323BCB6A0CB0C5CBF6D0D14E4A99@BY5PR12MB4323.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaAHh1rVIjekZBN5m510CBfBzXv74O9asJVDSzds67jDT3ijRhiQglEJyN7GrzakwoHcD6ns7wWoUHornTbmXewPqzoc4XEksAP4HgOVM+ii+0zStPkQzS/B0pByA57/eqX77G9Y4/8V7BTmfbJo43XG2aeKZBESz1Fu0E9aQUP3mDLVBQKWCFnfq90Qlfs4y7nIBDWx6GC9JuJr+NSllQoAAhUon3eHXEu3cW2TSr7U8+hfMZm1+us6mruRnlG01Zv1eJ0jTplekF/LcqopjUN33+oql25488wmKdT+VpFMCEEI9WwmNHmACAaKMjinv2sHHF2oLcEWjchSLwRbFPl1bq0iZ7vnq0XJ0NSw7Ln/wsLufxQWr3Hx6WFsOKQDyRiJDbc6ize/GFp4IJ/fTvGLMT/AAK6k4SGwkVxGHnXPxDKIlilub8/nnqsLuRB7pS83v5HAQs+X+Bs34WZqUS4OMkyrSJu6szCbnPcQKg4OlV6vyAs8AzxeQgh4xe2hL7vLR68HUcc/GiLxvhrRNi5OxktufijGxfqWfvIscQGk5Jjwn25hFfGat1B6tH7O84CsIWUoa7I3gPbu0TGFtGcUdWUL7cWcyHKZD24S1fzDj3rKg/cdxGEpDKheVnw6Ec7NEpUc/UvkzL27SCEOpI1T7Ibc3ijDHOnW7iOAxYpbBJpfVxTXippuQKjldM4ertKi3QGiAzMG2OOUkqqE+X24fXckpOTBhvoy1WBklDo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(86362001)(316002)(83380400001)(2906002)(8936002)(2616005)(82310400003)(36756003)(5660300002)(47076005)(508600001)(426003)(6916009)(186003)(4326008)(8676002)(6666004)(336012)(70206006)(81166007)(16526019)(356005)(36860700001)(70586007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 19:57:18.6866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0cd696-a5b7-4844-114a-08d9838357e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
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

Add jpeg2.6 with updated PCTL0_MMHUB_DEEPSLEEP_IB address in start/end.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 40 ++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 46096ad..a29c866 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -423,6 +423,42 @@ static void jpeg_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+/**
+ * jpeg_v2_6_dec_ring_insert_start - insert a start command
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Write a start command to the ring.
+ */
+static void jpeg_v2_6_dec_ring_insert_start(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKETJ(mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x6aa04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
+
+	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x80000000 | (1 << (ring->me * 2 + 14)));
+}
+
+/**
+ * jpeg_v2_6_dec_ring_insert_end - insert a end command
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Write a end command to the ring.
+ */
+static void jpeg_v2_6_dec_ring_insert_end(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, PACKETJ(mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, 0x6aa04); /* PCTL0_MMHUB_DEEPSLEEP_IB */
+
+	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
+		0, 0, PACKETJ_TYPE0));
+	amdgpu_ring_write(ring, (1 << (ring->me * 2 + 14)));
+}
+
 static bool jpeg_v2_5_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -633,8 +669,8 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
 	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
 	.insert_nop = jpeg_v2_0_dec_ring_nop,
-	.insert_start = jpeg_v2_0_dec_ring_insert_start,
-	.insert_end = jpeg_v2_0_dec_ring_insert_end,
+	.insert_start = jpeg_v2_6_dec_ring_insert_start,
+	.insert_end = jpeg_v2_6_dec_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_jpeg_ring_begin_use,
 	.end_use = amdgpu_jpeg_ring_end_use,
-- 
2.7.4

