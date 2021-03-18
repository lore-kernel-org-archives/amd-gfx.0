Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9725C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 11:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5D964F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 11:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5D964F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E266E04E;
	Thu, 18 Mar 2021 11:48:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1206E04E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 11:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoVKUGHcRJHxq22r09MY3leq2fRrC9AzD6N0NC71Mi+3oQNtUmjaBsYLTUtCwF60vKNEbhmRSzCDiVN+UaVByjj646/NVF7UfvCuETX1vQTy1HAuSFIemlAZKnNooXPQynd8Zm8PVF7dgP0QWEd/usg5rXN/5eqlfoZZxApeop+6DWQQZe11wHLNcQ+t99fsU56JTQQYvcby4Nhh129EWiD++5ViExtm4FZPdQFfCD86LwoOjNmAEhfvSpro4sdKbk4HMhAb383yDqMs3SFq8tE3ZDKG7lcivti61cgKFOcPT4i/S6AR+6S9IuMBqnE2QEa9c+TcvNxD0GjCHsgWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh1npgLejiO767xIy4HypppuMTRNqvZtxcpmS5ZOAdk=;
 b=U35/Ja1nC+7dCGVWPiPZ/H+oCQy5rlRbJBPBtOpfqujcpOQ0/TgzsxpChUiaJzunh32HNTdNaLUZ0VuMqWTNYB2bdSIIpheyXFzL/gFB0qgrW05ULXcOf9jTo2MpOo5tD4kPm0eBnm2TmIFi2wmsyeTNb+YWeotPjq3cvKv54N/WdQKsGO4Ks8zYrZV9CzEaiMLUMcB6WrxwpjAHAR0BQYLS8FZYWUM4KwbOsZrqRFCGIKy2Jrr+FtAr8dxJGMhqKbSHuVkdO4JP2QTs0kZkoQC9XzOmjF4sHPBe2nBjpfEjAP+5OlsVnzrwLlAPgTfwpjU/SMVp5SzLZU9RLmDapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh1npgLejiO767xIy4HypppuMTRNqvZtxcpmS5ZOAdk=;
 b=ElF4eV6uCWKvbZ4p5Fu82V7zqGRD1oAC/2tCoYRl1R64dRQyCbAVOrlVJBDMnhilWL7scYzjc1rwtDx+zv+05PdoF1ovD3hxvZ71EbZEdl7yPYS/2aVHQnSE3RC9uCiNEFsJjn3/VRNzBRgg04fP/X+WCtQb4VMiVJfLzR6jvi0=
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by CH2PR12MB4837.namprd12.prod.outlook.com (2603:10b6:610:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 11:48:28 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::4b) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 11:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 11:48:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 06:48:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 06:48:27 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Thu, 18 Mar 2021 06:48:27 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the page fault issue in amdgpu_irq_fini
Date: Thu, 18 Mar 2021 19:48:12 +0800
Message-ID: <20210318114812.407295-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6be8158-bc5c-4bec-abea-08d8ea03bf1f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4837:
X-Microsoft-Antispam-PRVS: <CH2PR12MB48374DFF26594682E2377AB88F699@CH2PR12MB4837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVWwyn10vpqvtlMW1+zf5aSyMjdZRSqppJFzuV/ydv8VtrLwhWM12wyfTlDsDYfdi4sGOOETjsSmwTry3VdLnQJAEWsM37EQ5wuVsehD9NKwVQyUPog6ZZE5YpXweyjx2cpvhqv/GTc/r1Bcfz91ARahKHQvhgFBbjtHQnB9Y12nXq+G3LmtWVMzRMDtx/owberXKCIA6S0ph8uECgJdOTDzwfuZYiblbAbnodS/YeiP6yzfHtmeUG9PrzJ5vWvHLwtAOrwI0ny6vLYA6YzYkVIFZo5cX92t3pqBI61s/5AFhbz0oqAJqlR/pmZ8jfJrspE0IiAEaY+cWgXeTQcCkQlQUSU1RXiT3NLf7lQW+ozhSYno3Sd+/eK7bKccCCFj69LOzN53BUqZs1vPAyVx/Rf/xvT6LiDsxKLrMe5p/5eC5YUY3AT7nvKGrAIny0B4zvkKGOiPHWWKH6VHXmFu2w8yxDKCpi67/Kwdg+V/mZQL0YG7pnhBfQ+FwD+e9mM632AoIJ8L79w4NPVUcgUtoqTaZfl7eXFSYek/ym2Is2ZEazXGqix/krU4f5WcqZWG2KYAxuPSD9rML2xHaUEJpRQarPoykT9bP+7vfoOgmGeE+ayFpNcuDolVKLlnYbBrh9NRM6iZcmluTgC8AQmhUw9OL+QF4AZrD+8Co0ZuLy+H40pce2TFIqLf1KmTSxKV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(81166007)(5660300002)(186003)(478600001)(70586007)(82310400003)(86362001)(6666004)(1076003)(316002)(2616005)(7696005)(70206006)(8936002)(36860700001)(8676002)(83380400001)(6916009)(26005)(47076005)(36756003)(82740400003)(336012)(2906002)(4326008)(356005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 11:48:28.4810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6be8158-bc5c-4bec-abea-08d8ea03bf1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4837
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some source, it will be shared by some client ID and source ID.
To fix the page fault issue, set all those to null.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index af026109421a..623b1ac6231d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -359,7 +359,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
  */
 void amdgpu_irq_fini(struct amdgpu_device *adev)
 {
-	unsigned i, j;
+	unsigned i, j, m, n;
 
 	if (adev->irq.installed) {
 		drm_irq_uninstall(adev_to_drm(adev));
@@ -380,12 +380,22 @@ void amdgpu_irq_fini(struct amdgpu_device *adev)
 			if (!src)
 				continue;
 
-			kfree(src->enabled_types);
+			if (src->enabled_types)
+				kfree(src->enabled_types);
+
 			src->enabled_types = NULL;
+
 			if (src->data) {
 				kfree(src->data);
 				kfree(src);
-				adev->irq.client[i].sources[j] = NULL;
+			}
+
+			for (m = 0; m < AMDGPU_IRQ_CLIENTID_MAX; ++m) {
+				if (!adev->irq.client[m].sources)
+					continue;
+				for (n = 0; n < AMDGPU_MAX_IRQ_SRC_ID; ++n)
+					if (adev->irq.client[m].sources[n] == src)
+						adev->irq.client[m].sources[n] = NULL;
 			}
 		}
 		kfree(adev->irq.client[i].sources);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
