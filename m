Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D55C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 23:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9247220768
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 23:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KpS9IAht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9247220768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D36A6E99B;
	Wed, 18 Mar 2020 23:38:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE216E99B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 23:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgqipjFcZovNfHw/69mK7MrPt4+8QYeKjzmuBevSe/S5xaE6/7SSuZ0sEc20zGxMmhc3PRtY82+45t+8w2B1IpzmTJ5NDPk+CKFU/jbyXC1oLdyCArBfxvN5l5Ndd58oU6MqVFW7VsceB6tvZLZFuYR0RZKi4f0t+yYsIOdW/rGMdQSx+ymWrH9Kkjrx1oDxfVUr7fwBb630ZNCC09w1iWzSEmNFe9YQ35K8ujOdaq1aToMIeUSNg5mkliMtCk9MkvbdLLrkAtt63lx5ZO623ULeWwm6UjkLGdAyjgPgwBbrmP7yyx/IdGfhfI248xMedUWzKxwAXZ8NvQdsUvy+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esZqwaFm9cdDFeJeABHAergbEqSrk8/yZj6q/OXhjsI=;
 b=WAxaU2+T7FaJ0oYNvb28bApB2fNGbWKx7SPzKkrge9/C+GNdujaj/t7gqZjILCKcxFXsqAGGCj5JLEhuUvl/bTSZVX2RLlqOTms1elRIVT+jT7LBp0cl7IhVBkbabQzSaD/7wUKl9o+mUXO/9XRfIxf05l516hODCJoV+niDLzjwAVnrzqgyrYLl5beBChGgchM4xGojmSOy9M6leDKpUHtG9b/1T3X95mwZX0SW1Y+LSGO4BTAAyBA+SjbxuBqKNynHSrN5RS/3bykqKSSXzquSSNyAF5Zv/6fZYHIlBNarcIGNqdwpuRSY9H1oh77cdV/3zW3dIQlqHMiKAuE08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esZqwaFm9cdDFeJeABHAergbEqSrk8/yZj6q/OXhjsI=;
 b=KpS9IAhtxGBN5UcdDWFF4Yl2DxSnuLJX8bhBYm+9tg8dDLwlMJZ+5W01dCaiXr38jplUP7iaQo1r4OFAuRgg1+gUzzfDnfvKHQF/teCtW9Rcsu0dEnr/Wk20Fd6I54lbbW501+JiEtBs7B/8DAczwnYNYXmG/g1O2vw39Ny9/SQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 23:38:20 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 23:38:20 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: infinite retries fix from UTLC1 RB SDMA
Date: Wed, 18 Mar 2020 18:38:00 -0500
Message-Id: <20200318233801.11866-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM5PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:3:d4::33) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:3:d4::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.12 via Frontend Transport; Wed, 18 Mar 2020 23:38:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da608d30-707a-4b93-4f22-08d7cb957122
X-MS-TrafficTypeDiagnostic: SA0PR12MB4352:|SA0PR12MB4352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4352795990A1EF7564475F40FDF70@SA0PR12MB4352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(81166006)(2906002)(8936002)(81156014)(8676002)(6666004)(36756003)(44832011)(2616005)(956004)(6486002)(478600001)(66946007)(52116002)(16526019)(7696005)(5660300002)(6916009)(66476007)(316002)(66556008)(26005)(86362001)(4326008)(1076003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4352;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0N6wBAWBM6TiXSHNKfbfE5X9oKFE+rFBRC79pHGIv3h4NnC4VRbZI6T6DBdbmNptRMcYaBuCD3fGNdCPYffOz/6pMU0G/X0vOKTybxgQp85B0KQTxiRUnYqsT/9sTCyEohmCSOoB6tV1So3eOt6m+yvkHqvgPkecitiCz2PUKxR0gJT8LUJYH2mH7//CeuS2jBvqDJ4eRe0j830rOo8sO2u1NJYe2sLHDPXqWwhz7gyEJOVVeikj1OpE09NmkxOq4XI6dJkCvPLhaMfVgSMvXQJc6748F0qG1pNJ1mYxv1Zcv5l4c8JAybY3O5RXXOEzsHZrKMkYwDNJYNSCNlBB9yXLk3GO06nClEGhOf4z7yTApjceKk/9c2sCiAkD6MZLWMxi6OumeWM+3VErB3wPlJzzhqmGhRc033VRVOmwHF1CeR+UrR1L92TfC5ek+GdY
X-MS-Exchange-AntiSpam-MessageData: 10NDxwdguN3ixs0lVUB83bLiJWVt4sJGFAWGIM5+IOq8TgVxpKDVj8JH5y3vs9L8QMHeh5Y/za/HDYb7kZ1IydOCdL3QGiEoOcvkldIlUbg8ySZEZbEwSiVnFb2JES3nzGt6n08H5i6E/IDbOFJhFw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da608d30-707a-4b93-4f22-08d7cb957122
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 23:38:20.6536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTIzV1C53oVxCscWf/o646H/JgkvkapbAKTU63/jSYdLVyUF20itNjnb9HwErqsZh/dxiQMFK+pTbIp2NgTODw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Previously these registers were set to 0. This was causing an
infinite retry on the UTCL1 RB, preventing higher priority RB such as paging RB.

[How]
Set to one the SDMAx_UTLC1_TIMEOUT registers for all SDMAs on Arcturus.

Change-Id: I8a6d9b89ea115fb51ff694493c88b8972d6248a5
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index fc664ec6b5fd..94328162b6f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -222,27 +222,35 @@ static const struct soc15_reg_golden golden_settings_sdma_arct[] =
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA1, 0, mmSDMA1_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA2, 0, mmSDMA2_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA3, 0, mmSDMA3_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA4, 0, mmSDMA4_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA5, 0, mmSDMA5_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
 	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA6, 0, mmSDMA6_UTCL1_TIMEOUT, 0xffffffff, 0x00010001),
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_CHICKEN_BITS, 0xfe931f07, 0x02831f07),
 	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG, 0x0000773f, 0x00004002),
-	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002)
+	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_GB_ADDR_CONFIG_READ, 0x0000773f, 0x00004002),
+	SOC15_REG_GOLDEN_VALUE(SDMA7, 0, mmSDMA7_UTCL1_TIMEOUT, 0xffffffff, 0x00010001)
 };
 
 static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
@@ -2011,7 +2019,6 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_iv_entry *entry)
 {
 	uint32_t instance;
-
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	switch (entry->ring_id) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
