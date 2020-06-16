Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C1EC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE79F208B3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uZfRUikn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE79F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF0E6E8ED;
	Tue, 16 Jun 2020 15:26:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F0A6E8ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 15:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLhopEichNevC5UUonhtIFtj+G833ViSktsJnQ/liG4LpIHJ7xpeiE+yPtnR7n4c1D0tQ3uHkdzt5+4V2qYNjmDBStSwBlkcaC4YKUj9UDZDmKJqWiLf4FJoElx/6f7VFRtbNgSrlZ7WPckDupCTaiAuD2UBFzobDJUNAMk6DrraTpMwdwPJJHBcS970ICCrmc1Oxx1YNJFC1PBIv0ENp1ZO5vR26PHJjg0cAIpZZ2g15DvPUaHBSqUdzIxkCW845zZCEbvjSmN9XSAI7s7BKol57KHTaIIJ/Q7x+j8a58UhVSpJwktivy5Z/A0n3Z0ApCRiqRRTAvNMaDiqTMO85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqHTvviPqgL7NIQx5wgo31SLxRNvTMLdH/0omEhJXfI=;
 b=jB40AUbh/PkNj4+EAef0OoUHkNvn5aaE3fqVicoTmpbR55gkFXtj6XdknfUnuKdZGph+9xsGTV7a3zgxN8JUF/wPsYgqk1bIkABoH/zbAY5ZZvKty6EoVAYs0KBWKVH3roFwKgovres0M9HFL6RRJqUF5UbZ+5+aKRod/f9GeRy0z7D/Mx/Hf3IAPg5IpPjEu8+IbZSQh+cbJPKMLiofTckPk1jdqu9x2RiSLPHmhjJ7TvU5fI4NtV8yyu1u806bIT7vqlMXfGaEGKa0gjJprEo/ThfI+yTb+zJust/QN/9tfKOmV5HmnGIivfXoLJ3zteiNHoMXEOkJuHZqD9GBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqHTvviPqgL7NIQx5wgo31SLxRNvTMLdH/0omEhJXfI=;
 b=uZfRUiknxkZTiS4kjtmM8/3YJ7kD+aq34+QfHyyPSMLDB9lmyTgCHlnbm3i0ygdiyVVPDc/JgX/dBuYicVV43tkQsqAjBRxZWiE2eZpoZaCq03aZBeWzC6eDu3qgzDjMhFka0HdNDmEoED7KBgIOFk9UYUb7yKGidP36rOzhYN8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3338.namprd12.prod.outlook.com (2603:10b6:5:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 15:26:06 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a%5]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 15:26:05 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix offset for SQ_DEBUG_STS_GLOBAL on gfx10
 (v2)
Date: Tue, 16 Jun 2020 11:25:57 -0400
Message-Id: <20200616152557.2717634-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:404:b9::23) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR08CA0061.namprd08.prod.outlook.com (2603:10b6:404:b9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Tue, 16 Jun 2020 15:26:04 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81d583bc-b4de-45a4-d411-08d8120995ed
X-MS-TrafficTypeDiagnostic: DM6PR12MB3338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB333896AFD4D1593EBD8D4E20F79D0@DM6PR12MB3338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLFb7eJeqZppcJEix9vHfC8C7OivVwlT1OCuLUTeD9bylKn1rpg5KGwvxKZN+V9mkCQNTLBLngyTw3CT7KkKxB8wIwJvj3aPU2mL9nN4W66ii3y4vqht8Ecby8h9MMpuV3q8N/F+Wr9turSFVUDcP6gP7K6fk5fkZt/ilhPy3Zyda5Yw9WjjDJ/esUrdHo2iBfRArNbdKCcDbt9FqaJmfKFmFdrUR6cRi8ogSpSmU87nMD7n0wRSvDg+My3XggKPJA9jrv4iX9Rdq+03lNyxBLNbJPg0HXDqzDDjweTNqlueO9J0vm+KZk9uiHayNaoHyh2xAi/eRGSVqsVhn+3Myw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(2906002)(83380400001)(6916009)(36756003)(4326008)(1076003)(2616005)(6666004)(956004)(5660300002)(7696005)(16526019)(52116002)(316002)(186003)(66476007)(66946007)(8936002)(6486002)(66556008)(8676002)(478600001)(86362001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: A4yvp0gjy1r/YYySogvqym1ivY4p2RUXa2sCxAp9ZvzIsU7tFUeqnOkvXfYSex6Gltck1stl4zyEzzrBv2uMymtlQr7jli3p/6k+ITcBzzLB3zCc1hm8QEBtbr5j0Hnqzd1dBMoGLZPrWlX202K6be6m6G/YiBviXREsSkCdbyFY1x5hC0MEclxrjn94/P/UJAgLhrq0EaPYw9m14XS5PNtooLM/OxbPzw7ex5DQ7T4v5754cOEH5MDFvUj7qjdDZcd98VxWpgG1MXUmloirJQMSwPrwSNUYG0fPCH8yaBYrQuU/2TOvhoAy9Mxjo80yffYGkyAykDhzqYpecKZ0x/POfmuABj3mpWASj3UTZ/xULyob7PAk6Dff7+hTAm1Q6rRxxwKITOeCPfZC6/aYqRU9/F0sJjSlqQY/6hUVeCEcniQtDrUyHLHjoN4r2VSRIadoGx/woP3REwnDJ+NX8b/bS9/1Mlzst2wuDE7TGY8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d583bc-b4de-45a4-d411-08d8120995ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 15:26:05.8968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7HJzlkm+kOwgrqg99jRqIc+JjzgszpiPC1bdx66dP0kjS1GgJyyLqEC/HAhFptB1qA7zQua3boduYzmh3P7Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3338
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Despite having different IP offsets the computed address of the register(s)
are the same between gfx7..gfx10.  This patch fixes the offset relative
to the GC block on gfx10.

(v2): SQ_DEBUG_STS_GLOBAL2 is 0x10 higher ...

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h | 4 ++--
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index baac40fa70e7..18d34bbceebe 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -21,9 +21,9 @@
 #ifndef _gc_10_1_0_OFFSET_HEADER
 #define _gc_10_1_0_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x10A9
 #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10B0
 #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
 
 // addressBlock: gc_sdma0_sdma0dec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 0bde3b4e9567..05d1b0a5f6d2 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -22,9 +22,9 @@
 #ifndef _gc_10_3_0_OFFSET_HEADER
 #define _gc_10_3_0_OFFSET_HEADER
 
-#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x0309
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x10A9
 #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
-#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x0310
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10B0
 #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
 
 // addressBlock: gc_sdma0_sdma0dec
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
