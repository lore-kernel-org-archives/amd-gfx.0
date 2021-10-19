Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD2DC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CF760F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07CF760F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D8D16E12D;
	Tue, 19 Oct 2021 21:14:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063956E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idFCccoGvYECsjp2pkdY8pihzL6Bw3fe4hThHZ/QYmdihir7PRMZCpTFdwNvwNqv0pe4aeK4ux5dOinTizDTqBKtwv+E/nDiHsdYsCFydkuSOon/F/kqHrn+m97ijTyvwiBDXPJktF8y9tWolIIHO1NF/b39dFoVy/OihbPG38BEUAIO5DKHtIBDM01N2co9GGdS0Vm8zfvmPQAb6Gd18PlOjYgel/ocO3h+VsouAeK+EHYOlA4NJc3EizN6Z87ZKajgboqOfAoAngaNMt7X1D3FLqqkLJ5mtgIFMWAjb/zbQ355x4C+kiTzSD8lXFZ0WBtqsAatq/kplUH6O9WoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UplMyraw8GNryhlFRAS/d/E/KFW7wr2GzG5omI7Y6k=;
 b=mLNj1PQhUf1RIiztGbasd7aXFQZza0oi4gaTCIYFmkIUpo60polvnSlrl+ZIOs7NMv+1KySHHRYCuDi6GiVyyTkwTxkH/rLKelL4/o+jNfybF9EHsm2KwcJ1AupcuERevdOVwa6oJQWQxDh3NhnGPPjq+kXxkEecDIjvM9kh9uuyatQ4kQsTp89yJ3M7SGLdDpW4TMb4+0WP0Gy/azLj3l9S8APG+n0BQAjJzoG2LuMCc9q0PUG4JaSTfC1uPBbD5O6gW/zbA9lPREuIYIijUD06WnGIB7hiSrE/snf7H2cUN/ROW/h44opNfQyPcxYp0rRj4B+fo69XS0rFax4pSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UplMyraw8GNryhlFRAS/d/E/KFW7wr2GzG5omI7Y6k=;
 b=d/WbOXnK1fCSS9IOkB2j7lTaucDp1QO8C1ogTXY2iqKBwkRSQPoHkawLV0zUmXvbaRw1oR2Pe3eWZGQxqQKE0SftcNtu7CI1umxygaLQX86RXj3DX6aMNMc8YNUAK5mwH0DnbMB986y3eAanO1etDVkeMfsssXmIbAy+idwvfw0=
Received: from BN8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:ac::32)
 by CY4PR1201MB0101.namprd12.prod.outlook.com (2603:10b6:910:1c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 21:14:53 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::13) by BN8PR07CA0019.outlook.office365.com
 (2603:10b6:408:ac::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 21:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:14:53 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:52 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 01/13] drm/amdkfd: add amdgpu_device entry to kfd_dev
Date: Tue, 19 Oct 2021 17:13:22 -0400
Message-ID: <20211019211334.1552825-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d8b3c2-4c32-48d3-09fb-08d993457e88
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0101:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01011DED56929F7F5AE1BD5B8ABD9@CY4PR1201MB0101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFQp8GXShO2rcOn+ssHo9HCL/vnUCUgKwry9SJp4mqpdaqmOzLiRuSgTqi37GBIflv017VxbdS5QfKwIelG5ReBJJQOdDLcFXzX9KeMmo80DHLk1tQSgZlSskilq1wrtiGd88Hhcbv5WO4PKgV5oYkyyK38OiBenwnwhvZ01YPct1zhVXpez41agQS7Vj7kGp172T7irjlMliwSN9pUm90HIR1NhAbOKYwBCxhAiv3VzowNxgefJkTBjLXyew3rP9z4+T2ebxDTlcoxqe2HOYNMIh4CDtyuw1Z7wO74vKujpeNyxXlJMeiLemqEgKlW63ZhhAobSaBrfRXUUEdKh0nb8RALKmIe0E7uCBO8gkLOrB93Hl8NKIVQ7K1QTeBBuE+3AumMP0IsRvdmqlQgzMk0u+tGjTFxjUc8Ee029LZHx7NrG0yq/+zpRq1I42RBQPFURf4BA6xelcjTiSAdJIhhZ5ilyQn/gK6yX/elsLb4NktcrerIldaKtpC0eyynlvyZxUyohi10RoiDER4PDUcu6TWhGE8PP4tnosz4eAioQa1+JUfZLgu/WC11bJao7p/Vcm984vUzkZdwEwDl/MHMH2Sk6cHb+Ff7j8CrzWCaqQ/aa9IwDo+wpOC4xNUUvrqOlpGB+GeFyN4GLClw8HHwrTVm1YwPn3XK5UGYrwScBDJady2noyaNF4lIREAXO6+ZiMrjxkhqdNhAQl4drM4QCXwFFrHjZ4y4x2tuUMM4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(1076003)(336012)(5660300002)(2906002)(7696005)(8676002)(16526019)(356005)(4326008)(426003)(2616005)(81166007)(26005)(8936002)(36756003)(82310400003)(36860700001)(508600001)(70206006)(6666004)(6916009)(47076005)(316002)(86362001)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:14:53.4067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d8b3c2-4c32-48d3-09fb-08d993457e88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0101
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

Patch series to remove kgd_dev struct and replace all instances with
amdgpu_device objects.

amdgpu_device needs to be declared in kgd_kfd_interface.h to be visible
to kfd2kgd_calls.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c         | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h           | 1 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0fffaf859c59..81ca00d7b3da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -825,6 +825,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
 		return NULL;
 
 	kfd->kgd = kgd;
+	kfd->adev = adev;
 	kfd->device_info = device_info;
 	kfd->pdev = pdev;
 	kfd->init_complete = false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6d8f9bb2d905..c8bd062fb954 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -229,6 +229,7 @@ struct kfd_vmid_info {
 
 struct kfd_dev {
 	struct kgd_dev *kgd;
+	struct amdgpu_device *adev;
 
 	const struct kfd_device_info *device_info;
 	struct pci_dev *pdev;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index c84bd7b2cf59..ba444cbf9206 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -33,6 +33,7 @@
 #include <linux/dma-fence.h>
 
 struct pci_dev;
+struct amdgpu_device;
 
 #define KGD_MAX_QUEUES 128
 
-- 
2.25.1

