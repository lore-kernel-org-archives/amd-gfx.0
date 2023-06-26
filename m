Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2DBEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A747110E216;
	Mon, 26 Jun 2023 15:04:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E63E10E0B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cggxcC5xxPeaqGvUMk1lKqHggDCxJZC01gA/aRqR6SkXd+LOvgXJAbQ8wQaRFdi2YdsTQ9XI49hpATMI8en7bywuxJGyHll8N5t2g6lP7B9RQjXOl8i4nC/as5QN2Byg18oWx7TrtZnz9R9am38jCQb0zbRoglx0vA38oaG+MubFr5lV7pUGB3D5O1az29AU+A1E24Yb58GAW5odoxxMEoHkLbb5bISNU5pURMTNpuUBpVAqkW2PhuDShCi5QnSmw+HVPLfmWsp/7WlgMvj1fVPzouske2m0bdmgop0R7XdesgbtqLd+KGCOXX8KrmAAO3n/hIqdA6lGuEDPMmSHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEz05I5vYx+YlZary10X6xat0qlWJiCHBun76DPLbcI=;
 b=Bm08rs3Gj7wfNDcem5GkcX7QRBbSlzSBk39GsvJCCD+okByoxlhYf1o2TIx1U5pIMVP+gXKx1cVcTFIcHEcOAsOvNNM7XFTywslUVA4d0gP73IchzUyU2zUd33e4WhcQJh5LEglPUUFtV8VT4m5Oj9A2sf10nU5n7Ut7BbdXf/gA+S05CRn/RxOcpFaGhXIzVIe+sDXPJTCADHwPLgC8qmnQplFPanNUUY+AIMLuRXw4Q7M6Mq8isgT82JKnQU6s7fIF3J40Tlgng3jOLgz8Wd/ToPFxtnUu0/FYebRqRrK7/uaABdOy5UUxhctKO5i66o0HK/1XzDU5P7/nkU9ugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEz05I5vYx+YlZary10X6xat0qlWJiCHBun76DPLbcI=;
 b=FSc+3aKp56FTUCaQRxPo8jWYty4h7Tto9idbXIjahh/kZEltHg2qbWQJ3C7ObrUEqEMxAkdofYPbBku+XEGV/rnBXdq0e5WPYOhB80GBPKzq8kClZTXff78DftAvpwfCdvgSbqCDtKrJDS7i/2isDwMNqaHYE25bmwuzNm7dpBc=
Received: from MW4PR04CA0345.namprd04.prod.outlook.com (2603:10b6:303:8a::20)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 15:04:26 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::16) by MW4PR04CA0345.outlook.office365.com
 (2603:10b6:303:8a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 15:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 15:04:26 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 10:04:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amd: Make flashing messages quieter
Date: Mon, 26 Jun 2023 10:04:05 -0500
Message-ID: <20230626150407.1447-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626150407.1447-1-mario.limonciello@amd.com>
References: <20230626150407.1447-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 074e98d5-65c3-4663-522b-08db7656a23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIRmjqSp6STZ3ZE2UqGicSorfkisN8Qzf1w3L7lGfO7yHzN/nvJO4jxWRMOSzAnxVSSjjBHcqdmTodCE6iWK5Jr8D3g0MiD7KhmNsoAoAuoHlG+6R5qkbrGWBcxDHAM4pCS7KJ9KuPKMruiOY5TfXwCkIkmxHCtlzEipHHSR9NIOyNm9mDFDOxVmp5+m71PqxkOX6tPrClQsjGrNdictsxUdqWVlZTs6z5d/DEHYfvBqFjJlnswvar6hIwlyCUhTEy4TJS7LUnUlCx+FVhnrDRxpWWDJFnjDaFPxzDBuvWnN4Qwfd+KXRyhwhZNqYkzueUp/eV8GjwXDC8VyLuBrlXougqOiD/9NRbYiyEGm1uAZbvUu3wZb35YzHfpBPVCrUn726xMeufbhZJGtY+0FldUaS683335mXtnLSxhVxQ2qh/XW5uxKtYc3a65KooHRIojVZZVVEthnkbYN5SLb25Mi9V1Sf+BF4JQiT9VPC/BBG8fFObSnQxhEl8oVdFZA34NKCp1rEVAKuWov5jM4C++owbAqUsyXPmEf9xSsNS6MT91mGU27QiuDNS/QmhJNxHHiDFqx6XJ7IEgAU7EgPPmR7Kz4j6ApBbNm+zGE+00B7ITpON62jvqa4gkffn89AZs62WsemJGkMtz4OR7aE40gt1d64XfknvRToq+bQU+Cfztu3RVpbfSaHHYYAsfAeHn/UfmVyN0kFWCdOsHTthKjIgOjTFPlyyDtnJOl9XYrkj8o+OoZMhBn6lE8RgRjZSv45r4oGvD5/I/jycbgHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(8676002)(4326008)(70206006)(41300700001)(70586007)(6916009)(316002)(186003)(1076003)(16526019)(26005)(336012)(2616005)(478600001)(6666004)(7696005)(40460700003)(82310400005)(2906002)(15650500001)(5660300002)(40480700001)(44832011)(82740400003)(81166007)(356005)(36756003)(86362001)(36860700001)(47076005)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:04:26.2334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074e98d5-65c3-4663-522b-08db7656a23a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Debug messages related to the kernel process of flashing an updated
IFWI are needlessly noisy and also confusing.

Downgrade them to debug instead and clarify what they are actually
doing.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4286c0b4beb90..93d014e69ee39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3531,7 +3531,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 	adev->psp.vbflash_image_size += count;
 	mutex_unlock(&adev->psp.mutex);
 
-	dev_info(adev->dev, "VBIOS flash write PSP done");
+	dev_dbg(adev->dev, "IFWI staged for update");
 
 	return count;
 }
@@ -3551,7 +3551,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	if (adev->psp.vbflash_image_size == 0)
 		return -EINVAL;
 
-	dev_info(adev->dev, "VBIOS flash to PSP started");
+	dev_dbg(adev->dev, "PSP IFWI flash process initiated");
 
 	ret = amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
 					AMDGPU_GPU_PAGE_SIZE,
@@ -3576,11 +3576,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	adev->psp.vbflash_image_size = 0;
 
 	if (ret) {
-		dev_err(adev->dev, "Failed to load VBIOS FW, err = %d", ret);
+		dev_err(adev->dev, "Failed to load IFWI, err = %d", ret);
 		return ret;
 	}
 
-	dev_info(adev->dev, "VBIOS flash to PSP done");
+	dev_dbg(adev->dev, "PSP IFWI flash process done");
 	return 0;
 }
 
-- 
2.34.1

