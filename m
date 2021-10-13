Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B108C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5F060F23
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 15:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C5F060F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DDB6E44D;
	Wed, 13 Oct 2021 15:05:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CB96E44D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 15:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPiNAyBI8ACQL/Bzdxzl3g/yur6b/DChO6NyDRuyCaEljMduh/jEnnavFl0SeOHNP3cluJm2wRHH0AOkS3k0rgjRmKOSddOMa2539OGnVErvNvTW93ULu4YX9ocpSIdFJUs+Zvo/xO+EePzi+2GUPs+etOZqe/3KaXyHXY8Sq8klKtZchnCBQGWLB5XEX6mCuAMpvKy3w19awopw6+f8ZaEZJ2AwjV2MRqAOZJbJgW8k9a3hA7c9g5FnEK5ry43nGtRh6XdO3RAsHwRilGuovcsdirQOyu9dMgBkOsxWV/51iRS0FMNtb6LnLVxxAFI5xijgu+rH+qqs90Ryz2WUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAtBHpFCW6iHoadzZMXpZCtMoIzPsA932l+o5fCbpX4=;
 b=ks6K4qnN7TAJeNdh6QnuHqg+5skPIfq/HzG1ztONC0dq/W4cyIZyqxq4VY6EYcR0vMiz9a0NCIZRbPY1tRn3/tRUe5iJzI8m/x3ijh2nW+nBbPs5zgZQqzXbabk+u8Zvc2dth6fdi7GL6A7uc1+dXO4hheSGn7llJxQFHnjO+4v9KyGy69s3bu+kf3yTwRqaHKBAhJehCH9ka3+Hzy/qwXs47b25HnOBKJ6aESwSEedOrqVBz6iM1lxk+vxkCU68H2UZ9e8ZGGS2z9UmkpcAsNQj3InQ1SgT4tGv1vkeTV2s+Hr67D730AYo3xgSB7LOfCZmenV2yIAdBjalgDQs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAtBHpFCW6iHoadzZMXpZCtMoIzPsA932l+o5fCbpX4=;
 b=JRj7u7KTaUoorsAtWrurJhpNdS9i9IPWeR1Q12FZ8qdu8R/C5uiZCmE8EFxM76ymxJ8ivzRN9OAJVUqzHBglLsv64YJq8VOLL4OOOsIayZiG5DwBTQ++OiOYLRFB4DWHeV28zzcVicGjy84LJyZ4iw05WLafZlODUQYzmx7vNps=
Received: from MWHPR11CA0013.namprd11.prod.outlook.com (2603:10b6:301:1::23)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 15:05:11 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::23) by MWHPR11CA0013.outlook.office365.com
 (2603:10b6:301:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 15:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 15:05:10 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 10:05:08 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>, Nirmoy Das
 <nirmoy.das@amd.com>, zhang <botton_zhang@163.com>
Subject: [PATCH 1/1] drm/amdgpu: release gtt bo after each move test
Date: Wed, 13 Oct 2021 17:04:57 +0200
Message-ID: <20211013150457.5268-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012121018.81693-1-nirmoy.das@amd.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b92f4fa-67e2-462f-3f31-08d98e5ada59
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383554B9FFDE0ED30375CB8E8BB79@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKxl3se2mWoN2p2K4BZIcddBZe6OHcbPmzsRjPKhxMSwkZ4LwwaRj6W1aN5N9fZIf6PeKo+fDuaE16uuY5Z5pw+mpGt2xpGtagA7ckJq4+y0exksuqRfFD3nmahlSTmkT7Vh3SF9orHwsd1IDXHZW5nNQRqnCtvCtWIQKEryNjXXLm9DsHhEE8dyx0/4+zyTIivIQiQ6Jgl23EaGHZwd4A4FTbVkC7PhYt8OnP4jO+v1H26ootAye9caDCVFS0yY3DrKuI3lD2NelulpnV9R89ls+vdGuwrCz8WN3ueAGgDWVKCT3M41fLMoPKyTEvMxTpknzu/KD24vMkiqpeCvtJ7LpVvOiG6FFD0u2Ynv2PdajKO9vWJy5JRBTLUJu/mBxQwGfDMVXFnR4kIOp2PmGgovk1urk2c70pmgX7oJVlf/sPEF8Smgz+WmjdkGYPuv02wLKBV11RxMex2TKNqlFhLeTlFdRWTfpnBesJ4NEkS4UOkNFW7WeYczkD4jKWdoG0XO35nTMZ1uU/LvcrwgY1namyqDPkB31JaT3K4MXfFOWIuo7ffUqgmsP//1AFpoZdkUwvOKnGb+NnJPQ3eBfcRzuBhFO20wBvwbj/E8spWktjNGj9vV/KPTmL3QAS73K8qNkI+HKxdFRT3+ZmA8zPNP8JwqIXzZ6dUe0YlpMnJPCgFB4mok5iS90LsLQDA5e4A4ZPVWfHIb6iXCjGDLmOBWOpQkxNg4wm+H9OaChH8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(82310400003)(47076005)(44832011)(4326008)(7696005)(6916009)(86362001)(508600001)(316002)(54906003)(36756003)(356005)(2906002)(336012)(1076003)(2616005)(36860700001)(8936002)(16526019)(8676002)(6666004)(83380400001)(26005)(426003)(70206006)(70586007)(81166007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 15:05:10.9576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b92f4fa-67e2-462f-3f31-08d98e5ada59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
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

When gart size is < gtt size this test will fail with
-ENOMEM as we are not freeing gtt bo after each move test.
This is generally not an issue when gart size >= gtt size.

Reported-by: zhang <botton_zhang@163.com>
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 909d830b513e..0cf2a560d673 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -212,7 +212,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
 			 gart_addr - adev->gmc.gart_start);
-		continue;
 
 out_lclean_unpin:
 		amdgpu_bo_unpin(gtt_obj[i]);
@@ -220,6 +219,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		amdgpu_bo_unreserve(gtt_obj[i]);
 out_lclean_unref:
 		amdgpu_bo_unref(&gtt_obj[i]);
+		continue;
 out_lclean:
 		for (--i; i >= 0; --i) {
 			amdgpu_bo_unpin(gtt_obj[i]);
-- 
2.32.0

