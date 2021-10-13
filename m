Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EFAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 07:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BCF600EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 07:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77BCF600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221286E09E;
	Wed, 13 Oct 2021 07:28:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0042A6E09E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 07:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdBE+8Vt6PRSpkc1jMEDd0AN0zblnCJA+HYFOJZQ7J46Y2r+DX1KU7LhZzyD1UvaisQmUzVYLqKuUwL7NydyvJWSnWH1DlJR8PNPDbMwDkjFljffVeeX+jow6aepdOrwnz8VLC6voksMnwWPrDQGL5KJbFsG4FmSxdqiRQfafEWSUR4XLv9Nimy+ihp7C9cC9+cAvbdZCR9ZyUkwsjW9PSSp2ZgZ6ZIv1uuY2wleOenV6YzpRLbC23J0vOuYYlTOs6acd62wuVVa2fN5zUq6lMnyT9nP6TIN4o6Stvq/7AEPiYUmv0+ETZ1ipnnNDGHbu1UQaCBG56OcpQbu3B5jFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/rbSS25XQ7vtSgQd0zv4AK+jz0cvhLjCP36+G911r8=;
 b=h0P7fIptbT4WE2+MBWmrkTr2HCVrRMpAu0ZkTDWMIETjUjF2BA9/6qQ+ESyTyoW67yCLSoW9sA6fU0Xs1/qnW/rUghX53oV2+5Peuyp/+HESgCFPD6PIEX1Jw7SC9NXO2rTdGAsn8yHFstX28OuQozb30CVQNPpcP3BYzG8PEwCMcOy6hhy4Zso6ir4bBnS1oto5cpHtwq3lBZelAZoyJVsjBgSOy+1xnIy3g4sv6FAHqzsfSlF4+w1ir9vy7WYXacsnabdTeZ/TVT/YoPTuoMZEDb9P2c3eDahIvGYMbnJxZ8v3Ju8JtHd7A4kLWdh2pfhy0zRR7hXaOgvCksS/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/rbSS25XQ7vtSgQd0zv4AK+jz0cvhLjCP36+G911r8=;
 b=fj0X52fuuXoRtpvp2LGYZUNjHsWULOaVYmBxSb0KRTfPiKBvpzBGua6P5B1CWCn6kFbSYNMJ5lM+0ILfSAfm3jTaNxFdLXU18/CShpqA/B9hsvhb9I+l1FZunL8aFQqNhlW1By0FI9RYjiBz6SXJXdn6XWasAo+t0uny4nTAB84=
Received: from BN0PR04CA0206.namprd04.prod.outlook.com (2603:10b6:408:e9::31)
 by DM5PR12MB1673.namprd12.prod.outlook.com (2603:10b6:4:e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Wed, 13 Oct 2021 07:28:42 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::54) by BN0PR04CA0206.outlook.office365.com
 (2603:10b6:408:e9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 07:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 07:28:41 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 02:28:39 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <lang.yu@amd.com>
Subject: [PATCH] drm/amdkfd: Fix an inappropriate error handling in allloc
 memory of gpu
Date: Wed, 13 Oct 2021 15:28:24 +0800
Message-ID: <20211013072824.985175-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f096b7f-efe9-4578-c60f-08d98e1b14f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1673:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1673DC8FA36DB0EF7EF89FC6FBB79@DM5PR12MB1673.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XM25gysOmqh2HwmmF5Hli7o/VRNlZRzT/T8qvxJukN1h9lF7ssO560k7dJ4NAletG4Iy5/yyJVIBabMmzGFwQGhzZi+hWk96mk3sWpugq2aJ1vTrJFZo9onjFF1NyC3jox9OyRtN+gC/z4XILUbBGcT9oH10Zopw1de5gYwUAAHUmv47WvROFwAyXyU437FyTOHedoWWSvMFe9Yh95xPqwjrmKYakfbgTtYCWNSVcyVQDBITToRTb/TBq2u8/gXLtElLF2JYOUBjWfcbgXdoAUQm4x/g9OdREsQl4iuUYQmZUZWQZOubJcQeODNSlQ7gNPad5FLiaVpxs5Q6Y6TjlxfYQLGKUhDGzUwrOvO4QsPn0kFMBQJ9Kr0hLySKAeZRZm15quQMHBNphNGS9DeqdGe6eXHuyx5igg8wUCmPGaz9wkFaHz+4lYW7chKOtgv7A4t4INrDT+CKt9dnyFBvX1c6kCtCg6suxkLNlwh54X1V2YxDUa+WBHn85tM/qPSrUUaPwwHco/bBfjQd6hqdJKqQzBjgRT4vATJPSI09vSuxcHgcrrta3wS5uY9jAT66IS/zFn16rc/pUY+Fvg8L/PyoS9idC/YNpHkPyHtbWp2Dl9K+YVHitCbZrGOyj6AnY+/tUjpPgnCvgPrvq/nNR+L95YjLZffGd60Gm3xO1QNS8kMxn4YuYM1TJVcHSISP6D8WtEBazlVS3rDeUwEUECdT/wq39YHWA8qHhjgRlvUXUF0yvvUH3RhboA17FLqOnJkgxQMrppplPJj0XeOXAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(4326008)(82310400003)(36860700001)(2906002)(1076003)(316002)(8936002)(186003)(356005)(426003)(36756003)(81166007)(44832011)(70206006)(86362001)(6636002)(7696005)(4744005)(508600001)(110136005)(26005)(47076005)(336012)(16526019)(6666004)(2616005)(54906003)(83380400001)(8676002)(70586007)(5660300002)(49343001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:28:41.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f096b7f-efe9-4578-c60f-08d98e1b14f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1673
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

We should unreference a gem object instead of an amdgpu bo here.

Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 054c1a224def..cdf46bd0d8d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1503,7 +1503,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
-	amdgpu_bo_unref(&bo);
+	drm_gem_object_put(gobj);
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-- 
2.25.1

