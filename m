Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC902C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 08:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69920611CA
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 08:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69920611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F276E87C;
	Tue, 28 Sep 2021 08:28:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF8E6E87C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 08:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNSKd7A35A5PSd3GggcXj1f9M846N1JSBHhp0adDb9eLh3AbYkQBIwGl/geccAxBF5E6tzEFIXftVwsQn6ioLvIDFlyeCAJ7CXxTufSLloFk1vQfBCzJmT/yjPxKXkwZqJ6f19jwLHZUoFZrLVkbQgn6eDzlhl7cFoXTkGYgwljbitoem/BIk0JASzUH28k0c96nyxYgLWcf+wzg8y07pJ3y7GiYLfgeUDUASw3r7KlN03Lm1OUgCHR0oJkxotcBiii1PPpZfm/3+CbtLyYLPnAOyJpNhGu63jqU20f+k3UM3uLoU854C+QPeWgl1qY3SHmi+EAfyUY3x48p4OdCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=iNG5F5k1g67ZhBois73Cx5iPCX9vdJMr2iSS0LUpVTo=;
 b=lMXZmVzgiPig1ETjBp1EzPzJBNB6feqRLlnzndVyAYOVLuZK8eev7gGh8ISqDPnnD1hX1S51B5t39sdjC4K+rnCg+MgYlcsxkmuViuuENQRmqAg5xpCIbg7C34wJTXOAqmk1o8ewNCCZd/+yppRliVGWHr1Lba4iTSUi93as7ijgRWtOPF/YBXCg+oZaCjrLu5tLzAbumEcs6IQwOA0TFDxnyuDfENhRZGHNapyHTzmHfAm3YG/Ng2G3g/mfd1YFGamrCY0YkPerdXggDISMS995O1KcHmIEyf77oOjNtxidFq+nFClFbDUWL+sZm2bciwvK9V9B+nbVEHaAjKRogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNG5F5k1g67ZhBois73Cx5iPCX9vdJMr2iSS0LUpVTo=;
 b=NOu8NWXUQ+NvxbHzHBP990Rm/OYxp6okvpQf6lKEp3JVLA79l7LpjgpoSs1jhE6kvkzn11RrWA88vQpKJMwKkGLHriCL3ngQ+hr28C8pjRCPGVW73agGDGzJnOp4knZPs96o1jp4fwhq5xD/VM8wZ0cDMf+v9GFIe5iCQ1170Rs=
Received: from DM3PR12CA0106.namprd12.prod.outlook.com (2603:10b6:0:55::26) by
 MWHPR12MB1598.namprd12.prod.outlook.com (2603:10b6:301:4::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Tue, 28 Sep 2021 08:28:39 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::97) by DM3PR12CA0106.outlook.office365.com
 (2603:10b6:0:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 08:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 08:28:39 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 03:28:37 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: remove redundant iommu cleanup code
Date: Tue, 28 Sep 2021 16:28:18 +0800
Message-ID: <20210928082819.205231-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fe8b1d8-558b-4282-6463-08d98259f91f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1598:
X-Microsoft-Antispam-PRVS: <MWHPR12MB159871CB9ED94D80B1731B3FC1A89@MWHPR12MB1598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2Lp4RjD1A1RBLtPbLozTWGaUil1m/fvbrhXQkw1H7/Ibumi8UGVOSY3ss7zucKdpthH44/qdbeKUh/q+EVUzHcroyzlHpCYAy9F3MVcaH5+pjUWr5saHHm0xUX1GfcUNMRj/wYWkHqlO9MSHVTnBk/+Z8yEXKhUWMtondqURpmvIBb0tpIald0rC6nk2r5E/Iyg9a2wwZ/ES86sJMiewqY9BefuGldX0AYfwe0nUX/VpKi7SSjFkBjjmoxCevDUg99zBIoEMiFYNb38opqNUJpcfW+KUcX/gb6qTbikMg099/ANqSYkcZuIH4HN+Vq6wJ0O/szYyUxXTRpfFpTuSw3PATkfycEk6PXr1lU5bgvTpDihLvcZuJi6ltDy/56TNL7Tnk/2NbU7hk26YCtfIJrKq3/crlCByRqWpDoOBhw18xsG0R5dqcoGPZoIEccH9kTya1f2+naJu9zWYUGjmnubjasa3/1K/JcZw30csJVUQHYpz+A0Ahk0zKHTc9VVNFStj3vqfHHpht0FcIMq1Wb1JYhGlyIPent0MLStC0ntOXZPNhPN7FKdyQ8LUh6nPB9su1LxR2aL+JfvmAyVv+3oB6B97Pwa1WuNWQuJH32o7+gDoup65jm5tTTOCubetpfK70MaBlxsqJaDVWz80mi6uUvgKx7XVKRIro6WJ7mPowwfHI5cTqyCUT7rdO+XA8B4ilYoL4Lpf3kzl8e3Hcopyru+87IrN3VHagowx1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(186003)(7696005)(6916009)(16526019)(83380400001)(336012)(36756003)(2616005)(8676002)(82310400003)(5660300002)(356005)(8936002)(6666004)(426003)(1076003)(36860700001)(86362001)(508600001)(47076005)(70586007)(54906003)(4744005)(2906002)(4326008)(70206006)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 08:28:39.2130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe8b1d8-558b-4282-6463-08d98259f91f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1598
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

kfd_resume doesn't involve iommu operation, remove
redundant iommu cleanup code.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c2a4d920da40..4a416231b24c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1085,18 +1085,12 @@ static int kfd_resume(struct kfd_dev *kfd)
 	int err = 0;
 
 	err = kfd->dqm->ops.start(kfd->dqm);
-	if (err) {
+	if (err)
 		dev_err(kfd_device,
 			"Error starting queue manager for device %x:%x\n",
 			kfd->pdev->vendor, kfd->pdev->device);
-		goto dqm_start_error;
-	}
 
 	return err;
-
-dqm_start_error:
-	kfd_iommu_suspend(kfd);
-	return err;
 }
 
 static inline void kfd_queue_work(struct workqueue_struct *wq,
-- 
2.25.1

