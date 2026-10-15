Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E47CCCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 18:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B4311242E;
	Thu, 15 Oct 2026 18:57:30 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6798311242E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 18:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt/GQRuYv6Vv/RvISy4poB0IUuRKl2dF8Ig+zpwqUjkY8uaqkQwRHDXdH+jKlhlNXrfXhGGzHXq1rEZkGsmqa4DSM1FPi6U8K/oeSwVB8X/h63jfR1OR+7S7EGvAOpRSNdPWUPXbXfwovzZB4t2juZ3iXJQiThnEWSC3h0odCkFTeFturdDa0SjWXinQJS5e0S4cNNY3u30pLdhTT1YQjnbvOcPG8IKmWydzilukIGr1y14NZFnq4k3GXUotKmf2N0VI54OGVwkAAPdvW9KOg1le9P4lmGyudGJcbBOp5qksph8dCYYFDZMc8vFcSB11QyczvH9AbjxOgxN4qYyfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOvYABbXFr1x+xUDFDzG5ihmwLIUolusZIQFoVVCfwA=;
 b=aVMVrZojoKe4QyViTRFrWTcyAv4LDC+UkhKQToPaSoDmxFfGcxVFmCf52H1m/hgIrR/16DTBBxEma2ixFuWxoGhroFeL3iOIsdnhvnjn75pRUBojsyr+HJY1JDk/sALBtMJT2xE4WI5AeJojLXeSXfNDSCA6dURszl7Q3kds5K16t+x44TzzjMqeDe52sP+K0/YGRJ21B6WFqKMC53naOu3HM9lLuYObowmgw56/mVJiNnX2nVYhAAHk6n62a7EgeR5ahdgI3WeIw8pxZzlZnzh9nq9Q0yKAJpj+sd01Tmidb/98NBnMBpRTPoSlfNAbZeeTpvPIW0fOp0d7FBgPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOvYABbXFr1x+xUDFDzG5ihmwLIUolusZIQFoVVCfwA=;
 b=LK2XBxwxuZNr88WiMA3Tm7iBGiKmquQUR2dzZa5scmrqVnGRY7VLJmQwIkhVVHNJ4nlM+YqNyuE0qTi5Ek/xoNDv3eTmU5pw0ukfTvSUcYq2/2RCeWKnYDphXjDW5buxIYmqHTIvliNTFGqSsl2q4nqGuqhLrdJzwojXMzP9VDY=
Received: from PH7P221CA0077.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::12)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.25; Thu, 15 Oct
 2026 18:57:19 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::95) by PH7P221CA0077.outlook.office365.com
 (2603:10b6:510:328::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 18:57:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 18:57:19 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 13:57:10 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: set SDMA MQD dummy_reg1 on GFX 12.1
Date: Thu, 15 Oct 2026 14:56:54 -0400
Message-ID: <20261015185654.499608-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015185654.499608-1-mukul.joshi@amd.com>
References: <20261015185654.499608-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: d8365098-8947-40c9-58ab-08df2aee234e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|3023799007|18002099003|22082099003|261009223027099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +u8MULcXd9YgHtPBEcryjrl0jP00brwDHMKatNQrhXt6BbBF4FgHKp6Mvi1SQ17e6i7eKYIszvyUbK4SB0mdudyjgGxmSG470eeR3MwSExOtEh23ZzfBwQ4PMzcKYBDm7PAyMuddwNy2uHVgL7A9RPqkV29dLOP8hzdVM5ndoNujWZG7HUjd4IJGP2wFfS9t4thM7H7up0WcKfTKJBFaUttF3hyfbNA23RrFnlvc2LEvLrLsLp0ab31PAJhMJHkrt6gi4f08VEsLJlsM28RR6ru5If+p/RpGM4pfKU5dyBD7UZHCeHqiAbqW+LeTKmGqvmHTsD3wUgGwDw9h0+MNBJWeTBwChyYv3xHH1NLWdYpkfhTLLvW6SGuvJJ5+V+76MZfsd8zNOfHWcN4q3Y1goEibP1ceniLhRIWt9J+RhBJhMfM9ZQP+PMaen+mHt6//lGVHhp+o6RhfwmbWaWNxWav60YvCklSSbjxZFhikMLwH7KNXArGMK79yV/K5gEUSNVuUMNDbzxI2jlfFei+aAnx8eX90lrdNiFwiVG6JnRlXyJNXCRI+wHCMw2cZkhrAgRihVuq1LtMCjhCahol2bMP5OaJ5Zz5YSPSHeZS3t8DnZlb+Y3a3+ypL0fT1Tthkei1ge3IMwbnKumHspB5/sj6A11K0PaM1EiLIV1I87/1Nio2VOEdOsQmr6OdOT9pqSjcC0QhrZZTcX8Ke9SBJng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(261009223027099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hsv/RVl1R/Xv1RKj6G+/lXgOUNq5spjwqke/jdGlzzJSj7UT/GFX60bdMQxQAr73w++FFgeyQ5Kmv61IbvQF4w/Ly+E11YoaUo1ZLGCUzWes+r2+zGGUgRejW73Ru9tM2Op0BMPBqpAVUy74yWb+xHs6HMpUxNArkZP7U9tF84cTPxdB7Qzb1CS5A2oC+RMPuhoNIg6EejPvBOURCaPJ5dGQ10wSUxozOmTbj1exRMguDXQLjnqaXrSfi+BxfkLgvTbjGkl7Dy2+BracB4bUD4rr7FGJYNBGZJuTd7maRjnBCZPWfiQq65DcdDyiHVQjABnfnSQnLCSyew2AVPfxoyyYosWhEz+4T26IQ82zwmgcz0CnZ66HVpgYAF2H8McWE7mq+JnCLqR6zS+qruXUNh8gIdShW9dW8sXXhkkIt9pDq58V9AJneGiBMS5W+7Xy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:57:19.1569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8365098-8947-40c9-58ab-08df2aee234e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
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

Set the sdmax_rlcx_dummy_reg1 MQD field to 1 unconditionally in
update_mqd_sdma() for GFX 12.1. This is needed to enable processing of
the Linear Swap Wait/Signal SDMA packet on GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 2e795adfda96..2bbf5e63f615 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -455,6 +455,8 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
 
 	m->sdmax_queuen_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
 
+	m->sdmax_queuen_dummy_reg1 = 1;
+
 	/* Allow context switch so we don't cross-process starve with a massive
 	* command buffer of long-running SDMA commands
 	* sdmax_queuen_ib_cntl represent SDMA_QUEUE0_IB_CNTL register
-- 
2.55.0

