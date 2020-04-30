Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D4BC8300A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580AA20787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 00:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ungcLXP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580AA20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939126EB2D;
	Thu, 30 Apr 2020 00:01:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FFA36E10C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 00:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPXZKsF5K4NcV7U2ns8N2PARtha2NPomCntxVvviJcVhvKPKDm3nzisM9MP7bWBOaOVSw3j3bwiRVLfc7creTBA8KAJStLsRKQY33tGGCvAmpFUYZWiSSm91QPYiIKlIVAo8l4vc7DSgkxe8kwJaq2Sj9kwbLCj1nWF2NjzNytq61aLSeQ20jV9DIsbC7MKI1BeAsf1GR6iuN9NsHVzeN/sM4gT6X6QI2DHLVwhB7hFbrc54+H/h17o8GWa6xuYDbgzlo/xRY2zTQlMvbqdX4C4EzrFfSpNtLKAiFka+IM1FrTmQM72yfYPVHhWeXmTJzGdcr1O+1O/+wI3ysiyVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoR8MaeoJ/1IzMxQRHn68AO85/QWZ/TpaMZ45x2NaMY=;
 b=XktPTTnVa2LiUjC/ZMEAu/2sL3DchJNqYrlqOqKSKjj3zwLaYxn3E6nHovNyF61iganRLJz8V64awt/97wmPZTTkaXNsTjPZpQC2ziZKJlhyFFPw7PpOzu3Fpa+M2zDSoFN6yeGLeUm8liUAAuk8G0nyOfJ9HH4owZNKnf6xY9eF09lGA5GeWwemm9VULq4fdlpqrp6e6tXdtb0EsujxMw9PIHp1wjPHDt0m0tR4ZovmjWMeIOOKV8BdJoFkaMsddAqXTyPciqctIMaC90HduPBryxvfMXA4qwPpQRPK4gJZdjzhZ7BYlgS0xg1VVOeHt/1pdLXvtWAKubwTlLCI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoR8MaeoJ/1IzMxQRHn68AO85/QWZ/TpaMZ45x2NaMY=;
 b=ungcLXP711wYuu/BCxQlHnBsCUEWz9aTw0g7XUuSM3+5nF7gTtPt0CYiu5F5pSF2HU0d3FyyqiPGFuzkSaOp+BdH8+7W/mmNMf7fGaIv6cr/qtCoKfu6LN/UvpeMgml9xxVxgXKuUYPeLpI0Q8bYga9T7ZglwesEFP4ao9e4ArI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 00:01:22 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 00:01:22 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: Changed CU reservation golden settings
Date: Wed, 29 Apr 2020 20:00:45 -0400
Message-Id: <20200430000047.31083-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430000047.31083-1-Felix.Kuehling@amd.com>
References: <20200430000047.31083-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.211) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 00:01:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34285125-a49a-4c9a-6f49-08d7ec999de3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575CC105DCC066B746EEB6192AA0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(6512007)(54906003)(186003)(6666004)(6486002)(16526019)(956004)(86362001)(2616005)(4326008)(478600001)(66946007)(69590400007)(36756003)(8676002)(2906002)(6916009)(52116002)(316002)(26005)(5660300002)(1076003)(66556008)(66476007)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qs5U8AqJR3SrK6TqQDXZXDlsZIALJr4Z00szlA3FIHXR68IxvWC2CfPc5hipGwyElF0makKQIajRKCiKwL5w4Ku5XICXPA4GZreivO6JoG3Robb2Q6/JxR45q/qcEm7V+jA+8YWcGjLdxGNgG+huxNwBpA+owBQ2ftTGL1gZGzybn+u8Au57sM9D7MzU9MJJucB1t9ni6AhBgPBdDEZhApQ0/qYNYwpE12VDDfj8onsFdvHqmBj+zX866qMGv2ez5hLdNpJMTGnzLiXtem/2UE0Q+aQKZrK4bLlBOCadoaiT7H7O0FlyVJCeOK6/tIzxdVr9mXwX8qFc/vBabIP9aoPuGIcdhh/U4noX+fqPkee7r28pxo36mdk4LB2gTTZBdaBPXprDxoDtyE7EbffluwsiZoB3CETMmXkJukR6Pgr4Y0k5FiwdByMeOCVxLwbnTMR0SidT0vDX6SBmg0FoOJySJzWh/sY9vfDvByLrXKQjsRtN2m6E7Hbpr3gyyorG
X-MS-Exchange-AntiSpam-MessageData: p7asw9ZusFDf3HoAVDXTSQoJFDRnaqqSFpzpC+2W57gotkJML4yeDw8Xa15NxUSfacjhfqklwEfrcszda8HFtiEriano7K2/wJXKlkVJbOarYyWUqeYLrCgjotbBTv7VbOsTcIT3/gzpFO3GJINEi5zCc2R0w5asHpd+pTTnr7IF3sxStivVG6/WY8KSQC5IxNWl8SFqUmtfuxYzfFzOxZWjuJKmrLT81LP/jrXqADdVfPEUFtkJ2MLpCWkQjWyN6UH7Zdi/FacTRtXXXWL8rovhy5OteAnkeKnh/8oF+oJ8Y5/Ouvr93U/or1uJXVHspNuSCK8uXU6ol3n4we1khtFgxbOHSOpx6ZrpLYqXfRUdJPInZ5aDJFfZc8fCDGe30VGw53e3nIciETK7ow69SsZdVUOmDQwAdImCCSPpZeF8QyOPLzt3uscXnG6fjYnAIZmuzZTB8be9vlr2clu1lRCG4i+853nqoxo73YGZJTsfE4cTwNNv9oIhpliyFwrhY3YOkP5n7FXwAigI5F6y0oH9PvMrh1VjdIvBO+JQg+RAcOnufTkJDrUMCWeXRtHoPdJ0jpbHyUnS/JU6X9D+4x7K9FsiUJhkZKot4rKIVO9RdyUgkLr5vVPFHAFydVFbFe0dmTqy9VYcmtrY1NgrZlymLWANkTR3qkd1nouq48rIEiRrCe8tDZ0o0JXtBdLgT/v+wpc31tICm59XHotA+l1YzNX9cOyQJ9AVE+nl8UT9fbAyBiA/Z05LpHDRBiYWjwCU78HwJOmSNqDR6s5xmWnBk0t1JtPYg6AhCO2iAAY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34285125-a49a-4c9a-6f49-08d7ec999de3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 00:01:22.1752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyblgIHW/sGCZVvvdOjkOI6jDrU7y6nQLF5FXbyJLlyqVDXLCYpHi4dliLcLlL+BdW8JVAJyd6r5bsDWuKN0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

With previous golden settings, compute task can't use
reserved LDS (32K) on CU0 and CU1. On 64K LDS system,
if compute work group allocate more than 32K LDS, then
it can't be dispatched to CU0 and CU1 because of the
reservation. This enables compute task to use reserved
LDS on CU0 and CU1.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2767c6d03370..a4e95e03d97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -507,8 +507,8 @@ static const struct soc15_reg_golden golden_settings_gc_9_0[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSH_MEM_CONFIG, 0x00001000, 0x00001000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_RESOURCE_RESERVE_CU_0, 0x0007ffff, 0x00000800),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_RESOURCE_RESERVE_CU_1, 0x0007ffff, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_RESOURCE_RESERVE_EN_CU_0, 0x01ffffff, 0x0000ff87),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_RESOURCE_RESERVE_EN_CU_1, 0x01ffffff, 0x0000ff8f),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_RESOURCE_RESERVE_EN_CU_0, 0x01ffffff, 0x00ffff87),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_RESOURCE_RESERVE_EN_CU_1, 0x01ffffff, 0x00ffff8f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQC_CONFIG, 0x03000000, 0x020a2000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfffffeef, 0x010b0000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_HI, 0xffffffff, 0x4a2c0e68),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
