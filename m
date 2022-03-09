Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1188C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 02:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4B510E26A;
	Wed,  9 Mar 2022 02:24:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E752C10E26A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 02:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAThBhGQlfhIJEWQyQr/Nvm+a2E9s/xHnUGGjaV09Xl7Uqa8+6mT5UcRhPNvhh+ZaozDOk5c+3u1O8elbd3mialSmLdic0MVKW8evNcQ9ZHR/i/MvjMOeXqFDrzLwG+PB/VSIKrZ1ab4r1zEzg5dcicXNv/2v8wJ7/1R5nZ7L49b1Nxp5Plj/HqaVjHJcSCtt/9tXxcA16e+3t/Ozsk70Ankg2bZF+n98jPeJo0TSaaIbWfRcQJVt3J/zxhrQkqopbfkOXV6LneORkZYKMoNq0vMYhqfQmGGtq0zV94bl36UcMroOTQf1De8qNGKr/uumddBeDZeuFRJwJuc8aeHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mInBYBtTPcB5ilqR4WT73bKnr/teFj3ZSJFQQCdJt6c=;
 b=BosKit508i8eyh01l/I5mae9ISbA+Zx9s2rzXzfyz+6cR7gCejG+uG8TjAysvBuyvOgA4wefkrHtvF2YLZ0snDmi4uEbN4rQLu/MMQzrH7CSWGhejVaubIVWY1Em4NyG7sNdKcXtRPRXgc8jrYODZnk/4kDxybmdRGvwB+23+roO6pVSFt9xSIUqRzz/NJLz0tsRvKpf3gzIL75KNi1a5+18pCKC6PPxuT1+vkBe2QPWdtizkLAzJGbv4IkeB74WSlFYjmd87LbNnDGOrRJoTGJubK5JoztRzsGOtU5rmzqNYTfjtwSKzU0iWzciuytSqAl3ydkvDWVhkXs4pHyBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mInBYBtTPcB5ilqR4WT73bKnr/teFj3ZSJFQQCdJt6c=;
 b=CzkZvHiCTNKw6JEH9ls05nysWj8WoLP3urvgbM1iRA/SlAFW/wlI8qcBQIhgW6SCiSEccQ3+omkCl4Fh00qkM9ujiByHO94MrFZR4p8ZcFSxDctanhL8k6EnKoOza7Lju7cBQEnYhLbeoA4kRTgGx/P0p6anekrno2Sod8trSMs=
Received: from MW4PR03CA0344.namprd03.prod.outlook.com (2603:10b6:303:dc::19)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 02:24:16 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::76) by MW4PR03CA0344.outlook.office365.com
 (2603:10b6:303:dc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 02:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 02:24:16 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 20:23:29 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amkfd: bail out early if no
 get_atc_vmid_pasid_mapping_info
Date: Wed, 9 Mar 2022 10:22:42 +0800
Message-ID: <20220309022242.2625842-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7612789c-a0b8-440d-ccfa-08da0173e8a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB321004EA74C7CAED98B43DE3C10A9@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Vbb7AvvyHXg4Y3/awnZs5tI1AFH2QmRMLue5jSja3J0HLYNwIJJWX3xl343l7oD3yo2aEdnKY2sj4p10WASd+FdiGXBe49tC/+97QTnhAbRBbzJumRiaNuqsMCXBIX5OUAYAn9NRTMREgswzGDCFk93RYNOw1up3bQ8hSW+LmcfhTA1RSjkFd2kRXwp543XOzK6Xuve0VC7PrCSRfGXY4eadAXyiPhWuTVGvgFGkyvf8Q3VWyesFZiya3sAznz1b532CW0kclS2VLjEb28G5Y6ZPj12k1fKJSNJaw4erNoblM5Tj035dzGO5rLuMfodAWIV0gngtwGB+A1WYeLRx9IU/aPZXylmURnpI6jPL/6xG4i0aFTPV8/gTn48akuxbIoYV2vxcmn0d0f5Ltikvr7QeBJLru/CQOVqdDwYklfdAMfQucIZIN++MEquDE9ovyslpVCifEWAVeNmK8Iw0W+EwEZTzDo5/VgpJJPkpAYKRyVn4HdUJaiQmT5IcHwEOtbqSpJef3Y8NVSdiSQvMgjhw6wVdbTj+CVQ2LHQ3qxVEOVbbKez8rmrpV/pF5YwUnDJ+RkdIT3ZGpsJo1POetYCzDZEKYMb+jFEPwbZzznip+2l226gpAd6pRDPGJ9500P/YzjY9VOjnjo58pHVyH0WS7AuRr29fAG8AZeUSTWrcotD6QdyeK+326MFWZRT7iUOpeUVa4s7SUw3gCFAuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(5660300002)(83380400001)(356005)(47076005)(8936002)(16526019)(36756003)(2616005)(186003)(426003)(26005)(336012)(1076003)(2906002)(6916009)(82310400004)(508600001)(8676002)(4326008)(86362001)(54906003)(316002)(40460700003)(70586007)(70206006)(6666004)(7696005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 02:24:16.0452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7612789c-a0b8-440d-ccfa-08da0173e8a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
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
Cc: nathan@kernel.org, Yifan Zhang <yifan1.zhang@amd.com>,
 Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

it makes no sense to continue with an undefined vmid.

Fixes: d21bcfc01eb1 (drm/amdkfd: judge get_atc_vmid_pasid_mapping_info before call)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 77364afdc606..acf4f7975850 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -500,21 +500,24 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process
 
 	pr_debug("Killing all process wavefronts\n");
 
+	if (!dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
+		pr_err("no vmid pasid mapping supported \n");
+		return -EOPNOTSUPP;
+	}
+
 	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
 	 * ATC_VMID15_PASID_MAPPING
 	 * to check which VMID the current process is mapped to.
 	 */
 
-	if (dev->kfd2kgd->get_atc_vmid_pasid_mapping_info) {
-		for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
-			status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
-					(dev->adev, vmid, &queried_pasid);
+	for (vmid = first_vmid_to_scan; vmid <= last_vmid_to_scan; vmid++) {
+		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
+				(dev->adev, vmid, &queried_pasid);
 
-			if (status && queried_pasid == p->pasid) {
-				pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
-						vmid, p->pasid);
-				break;
-			}
+		if (status && queried_pasid == p->pasid) {
+			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
+					vmid, p->pasid);
+			break;
 		}
 	}
 
-- 
2.25.1

