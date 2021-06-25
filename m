Return-Path: <SRS0=nR5r=LT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6BC49EA7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 05:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F95861417
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jun 2021 05:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F95861417
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143F16ECBF;
	Fri, 25 Jun 2021 05:58:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81CA6ECBF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jun 2021 05:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWZr95xp52xeHbU60PGBHzTOy+y5SoyIXJ2x8KQ3fUp5g5AGrakH7FnEcy+5s5LuVOl0OEw/B5ka/uWQrS2icNPTx2mqlIq3uaaTIX9JniZSOruOBSWWSq8B0WpujH1hoibbC860Nzf1QtWnA6y9scI1EiBMb3rnt7+5R44bZ9vqXuZNlIBS937s1nKa+1+BCN6Z2K1MCHJU4DIz/z1kPweRB39p8yj+XKN7qG+bH3uO2hQh4BzVjgxquVYLY6q5U3TywPXJBm3CHvAIHzJ4ZkZI0Qht3HIq2JHyz+ajPOcaxhH6NXsUUX+eFoEN9yZB5wiXbjpv/VXqLfKVYjENhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+SQu41ThD24F2aaLZYCX+ckCzkphBbZkN+LRXe9FVI=;
 b=mWYCNfcbVjNJ/KqTqnrjckJbQcfJRZdjzJj+JXddRkktGTNSQWhe9kwM3ySM6PmhGEpvy530Gv1Tco0VwHPY97aRHyw++ApFbAkhyyhDHHZHewopKf3EXjMKXVGh3p6PPsagG9zS1kdrvs2f9ekGgjuMSJbcnoWKuZGd/hbryS1ETuw9etd9cWbUJI/XxccK7CY4ghJCthEZanxg5EFbDQey6UTDT5oj6mdUODulvYQoTNYhQlHLQ9LVtXPstet7iNbYmCehPmFyiA/4k2HQqHgZOF1fYT2IetAc+CvyB8fzP1l/GQ60WiD2sxtdKQnmM6abirl406pGKUhk5GdUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+SQu41ThD24F2aaLZYCX+ckCzkphBbZkN+LRXe9FVI=;
 b=c6boA8b+Zi+pYwya/8Cp4njgY0DyDYMprt1lR9LfQMLry7CpokDJgasYe1I+lqpD8tD6sBVvxVQxtG6jQTgWuSNNIB9BUPa18gBkm6uW/Ck+Zk/iJFiYCaNedVxqbeRYalIyG70s/hYRPhhyjoVMQFhKjMtQLJVvbb2M1q36+yE=
Received: from MWHPR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:301:4a::29) by BN9PR12MB5355.namprd12.prod.outlook.com
 (2603:10b6:408:104::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 05:58:32 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::5f) by MWHPR1201CA0019.outlook.office365.com
 (2603:10b6:301:4a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend
 Transport; Fri, 25 Jun 2021 05:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 05:58:31 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 25 Jun
 2021 00:58:24 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable sdma0 tmz for RV/RN
Date: Fri, 25 Jun 2021 13:58:12 +0800
Message-ID: <20210625055812.2274077-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fb65b30-b05c-43b4-13f7-08d9379e42a4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5355:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5355F41F1FDBD67EAED97A33F0069@BN9PR12MB5355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAZcwCZ4q5sU89sLWyPabUYDGnCIOCx62vRVIZpDNeqiFo41utaJGmhSzi9wb0IvOneR0hRJJAFd9HPAsn8f9Dei8FkLP2uWbPyeMwxfxGB1eHaHxYGvYFUhsvfRpVLclcZ6cTkY/sPxOFuN2SWjWHaxbzItmqRSn2KKMhUQzCHMoycDXcAYBDbD3DrZW485ePT6tcjZX2556MfxFHw9rCeRfHjFVCmN+ynfjakWq7/F64whqqs/gr5waLC21R/i+mVNUSSe9/hhFdLqnusetK7AP8mDrFkTdqbh3uQyUE0rbzy0cKppnXJTrcVJ7uk6QyMjSSa0fXFihSq85DDID3iEOSc2OzJ6vRx8lPUvN54Ce/XjJLrml13ZugkiZeopKHXVI0cU0JEj4ZPZxN2daJTi8Hdu8xRbQaQeA5lz4IAhkB3QD8q8KfO5db/iAJFhCH208EKPfPZf7n5eBsEYyXkg7jLEDzsDIECow8Vx0hKVebV2sU7AC1EVsRgGedrL65aJBHcwbqQlEq9er07h+0SNx+dkTVjozeeeAwsEJo9cqXvpDIaGRKs8SVEqz1j+m90eWWj1ooS99s0dYkhWzXuYBw+EKGMDEfumwToA4FaXVx4kTGQ2T8KCHNvGEdtQ0wQmDRXMTMSRDDFjbrB8aHAaN0kaAR1abubbLRYtIuJ1jMxm7MQxKmskRIgt0Zw0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(81166007)(44832011)(356005)(83380400001)(6916009)(2906002)(2616005)(8936002)(316002)(478600001)(26005)(186003)(16526019)(4326008)(6666004)(54906003)(86362001)(7696005)(1076003)(47076005)(336012)(82310400003)(82740400003)(426003)(36756003)(36860700001)(70206006)(70586007)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 05:58:31.0396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb65b30-b05c-43b4-13f7-08d9379e42a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
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
Cc: Alexander.Deucher@amd.com, luben.tuikov@amd.com, Ray.Huang@amd.com,
 christian.koenig@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without driver loaded, SDMA0_UTCL1_PAGE.TMZ_ENABLE is set to 1
by default for all asic. On RV/RN, the sdma goldsetting changes
SDMA0_UTCL1_PAGE.TMZ_ENABLE to 0.
This patch restores SDMA0_UTCL1_PAGE.TMZ_ENABLE to 1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ede82e0bbd76..97d57c52bff0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -147,7 +147,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003e0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)
 };
 
@@ -291,7 +291,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_POWER_CNTL, 0x003fff07, 0x40000051),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003e0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x03fbe1fe)
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
