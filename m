Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A87C5475B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 02:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E970B10E5BF;
	Thu,  7 Mar 2024 02:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cPx7k5Yy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABA310E5CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 02:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd8AIfo90QjxUblJg7LmoEKemkU32+ft9nfXKi3WRF32Vet5KWu3CbfaU7m+FzcFTOlW+n4wk0+lJWiK09j0a7zUTDWXVSLkwdQ8OIvrxnWS+YGixGd0HyjxStLLDIgTD4i6bVbcmEuSlfkduB0Fl7fLPqIxIFsb/k3jDm2IhdBWrrJgFsqobbO+E3kRaHVNBBhRKgHy+hpKsaFCigThh+aOoh98Jdnw+E5MAQpTo1Hyk6VyCCyvC8mH96/B9jXnE38XZxsIUmQJ+tFek+ntWhuWLtHwz8fkh8pVUd6sEbDX9qNyMynYO0Eh29K9UYns5tA0dHa9CI2lenxP3L0Ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxb3+TvOaP7aQbIY8jEx4h1mrRVuKsr+bZwnMwulyng=;
 b=gt+wBtFqB7iIMgKOgCD1wmlEavWuIvMpR0Te4DDuB0+Pj31KShvoN7n7oopVUqX2fRpERHQk6DsZv4CKvBXuuA6leRTAkoioFo0FZWLFjvxBplTJH/fOjlbZNs4lFUiRaL46KxdcranBXmb12lQ6tvP3GWw87WfO3/F/2jfpcjLbdqlu3duU9ihapxHlgCyzY3JpubT0ehQHw/gVX5QQGr/eXJvrDbe8BoCSe3G7OJ1KR3Yjwvl3vUDrtevGSzxsbVu8DN8iSoWXcQT0Z5JPevrTU+jSYV0g4qTpCoZFPb3Jx9IPqcd7401Zz7QEQ8WstQqs5R60cPIYGe428umvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxb3+TvOaP7aQbIY8jEx4h1mrRVuKsr+bZwnMwulyng=;
 b=cPx7k5YyHD63rFmAWWhaErFsIGaP9lb4oBTFPS/+D1wABnE8dU+KbTSQHJxA9F3k1B7uECA+vLrfNRLiCBBT8DMX88Bj2GufF8tsdBRa/FzqLwv1d2+ttNOcgzunsWCKmn+MVHV1kAMP8lGIQhu1ZStJ4cPsESNfV9lm91NJBjM=
Received: from BY5PR20CA0035.namprd20.prod.outlook.com (2603:10b6:a03:1f4::48)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 7 Mar
 2024 02:49:18 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::ca) by BY5PR20CA0035.outlook.office365.com
 (2603:10b6:a03:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 02:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 02:49:17 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 20:49:10 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: fix mmhub client id out-of-bounds access
Date: Thu, 7 Mar 2024 10:48:54 +0800
Message-ID: <20240307024854.2244635-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 04597304-5a42-486c-de4e-08dc3e512ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWsppugmtAvPCeVTiUeH3m9Iqad3GnyXMHknLourJ2zqZrPHOpiYp0mnuF3sR19FRK3Jljx9gmy6PMudNwofcL/l3MLRWDbPMAhK0XYMVF+feByHuYqEuWWqxwwXDZfoNy1yZj8FNipNNMGbp1VkCEpkVBYD2Pqcs21U5geM/gnx5LI4Ub+2Id9XJOICPxqrRc8KHaow3VBhjqZGM9Oi7RIFoapNr1x2VOsGKky8YcXNsi+rHSbicE4Ld4JMD7TZgN6sykgc1E+oC73TbSMmBr8q4lsTPDfiRlUeybZCHAN8uIjTs+9EUHRVZgMOk+jv/biFUQou03nejGuUgx51GoALaAkZR7AbOgAZJbc1KE40cN1gvFCAHNV1fKJNnbsb6ixwd4j9Kf0+ZB94fN3D9ubUE8mUtUWQdwzZyDu1a0ZAfrQX1i4TLb5QFxeknFxTqVW/qMdhFDBK0NNQM6kvNQOg98UeM78z1RuC7QUBVBYiTDGPlgmcmcBx8nbWQKdI7fbpx784gVaUbWbOK5ic1hAgnpFLW6JLVRKynf4mMZA/jQB3QFoipSwLQ4B9uTYzYvYB5FCn6ycYD/i0oRd3avFTqkIVHuQGE0XJPUnatA3V+d6NVzY5OO/7e1HLKQE/5GEbcV4MfwaIaI+syNrlvNij9dtS4jjpoKvZwyBSJALUacf8EHh0SOyemsDQR7hDvRZ8fNlQIlrWJ7s1u7ITBYc5OTxIjvHCFgo2P97WqBcdTZfkxq1HY6gZhscOIp/e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:49:17.9383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04597304-5a42-486c-de4e-08dc3e512ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
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

Fixes: aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index b3961968c10c..238ea40c2450 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -99,16 +99,15 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 3, 0):
 	case IP_VERSION(3, 3, 1):
-		mmhub_cid = mmhub_client_ids_v3_3[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
+			    mmhub_client_ids_v3_3[cid][rw] :
+			    cid == 0x140 ? "UMSCH" : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
 		break;
 	}
 
-	if (!mmhub_cid && cid == 0x140)
-		mmhub_cid = "UMSCH";
-
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
-- 
2.25.1

