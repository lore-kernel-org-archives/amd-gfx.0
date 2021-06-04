Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99E5C4743C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 23:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87060613EC
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 23:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87060613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4DE6F59D;
	Fri,  4 Jun 2021 23:10:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BD36F59D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 23:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOCzGs8F9wMXOCoHYWhW7QZEOuCe0tq+mAPiLzi+zzsxrwqewqUkiX1v5eCEalkXnuqWhVYN1jQkzFJD9sSR7R4HqIGZE+Wjey1lcxYcg21cldt3DFiSsI3z7DxVfWckt2bkT+Yjl5KGRO1e2lBaMFzOcdiDEMcZCovcZbF3cCZ0srxqzDF6wfoGH1kVlhr/HK6Vcf6qlFJZBK3rHHAdlR2XG9GP+YJF+2bI5uuPyo0LhEBGQkAgFE0NUHafq36E26hVrn9a6pyQUtvLnGMItcBJ0tjvf2L+YZsM9vDKDyw3fZ/RAydjwKisnQuL8hrm4NF3TI1LQVK0qwiiPRY8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gSibGbBZnUj04oJBCHaDVc1ykGXQXS9n4r3NlCyZj0=;
 b=Iz+jJuj5UH53zbvFjYNbb/ZKNF7tEnMTIAW430fRvfMwISMBHbEr65KVsMIK9yLwa9ed41+T8xlC6l5H/+pAZKLyB+xgSEI0U1JMms88Vi0rVgMe+b/V/cOPyiyf6knq7UDKGMuU4LpBx1PcZ+mpEe5F5Wd2cw+fUlKz+PN9cdoqGC3qeQRSJT783Pz1e/5R9oChasE+P6e2LtWWWl19PJM+nQ6E18HpbnPCXZ/PWi9aRn+JLSrRX60I6ufLL2b32UH6h+PDOyqcamfJRxhLd6PLsfnn0Xcs6ii43jCymgEER68wgE7AYUIaazcyryRf+H/rC6g8m9/DmvbAZJrRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gSibGbBZnUj04oJBCHaDVc1ykGXQXS9n4r3NlCyZj0=;
 b=kQEl4Cl3M7H+iDKprpXb4FWC235XPckHD+WGn7ZchrRsCucVXthQY/jWXAf8UHTTXCRkS8PHNwZCAdMjhL/9UPMYbK3CwRV8zf9NRpby9myIMqwQMJvBf8H7MQ5sa/tuNqYn1LQVK0BP0Q1VjeAsFxt+x5R4wGd+7F81/Y3cV9s=
Received: from BN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:ee::34)
 by BN6PR12MB1220.namprd12.prod.outlook.com (2603:10b6:404:1e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Fri, 4 Jun
 2021 23:10:52 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::f5) by BN0PR04CA0029.outlook.office365.com
 (2603:10b6:408:ee::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Fri, 4 Jun 2021 23:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 23:10:52 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 18:10:50 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: pages_addr offset must be 0 for system range
Date: Fri, 4 Jun 2021 19:10:39 -0400
Message-ID: <20210604231039.27518-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7aefa47-7585-488e-7890-08d927adffb3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1220:
X-Microsoft-Antispam-PRVS: <BN6PR12MB12207B15302E17175B111575E63B9@BN6PR12MB1220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsWIUuSk20tCAsvSi/2A+NywF8GBNpoA/pAjnqyiogB80owCX/I5uwDAclhSAQyYPckTMHzkjMu1cNVnaXgsAi0pCZHI/4fCW/37XvnnyljUUodN9HxtYODm3Nf9un1qbiutX3HYmt2Pz+0qBg4GAWQ+eE9WYO5Qrj4NQt4l5w7WMZaaNm4q2d1RRwFZm4j18rR4njcYnanQx+651ViD/tW30+L0RVHp9icB8Ss82OKx4PCt4DOixb1UYH2vJv61fiaWUTJaw38I43zAmnkEehQdsllwF/wIbXJYAo081mZwxIl/biWGfvA6bRI5DsyYKy01IBGnCpyTQCPQMi9+6Aa7pGan/r0uaR7fQSOB4DiQqOxUe4pJgUCSeob3w1SBcFHoyn4oml58e18WR/klN1Ywe5W1CA95Co0v9dfLCLnRUsp/awyAlo2DgdK4Wf9AbCupHLCyfIefcRlMSrw6keBZ/xiv0yUAEAg4WDQdGRsay/kKSrd5hS3MweOub/xJk8FU3jsB6suRbax7YLY7kAtEQwvUHFMbmFPCEPdO2oa6UzbQO/uKireIalpP+Oar2eXy9AS5VFwzcMYa3UvJzujBX86dVWdbG6W98E2Qd6CyFrX+AdOCxShSUhf/mGzO1HqFL1vmSfmpo2tyG1aby0Ae0mIBrTZ2CsvFI+RQKFrqcaKtq4BByhZ5oknBctgP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(4326008)(82310400003)(6666004)(478600001)(2906002)(36860700001)(47076005)(82740400003)(8936002)(83380400001)(8676002)(36756003)(5660300002)(426003)(26005)(186003)(16526019)(70206006)(70586007)(7696005)(6636002)(2616005)(86362001)(336012)(81166007)(356005)(316002)(110136005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 23:10:52.1973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aefa47-7585-488e-7890-08d927adffb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1220
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

prange->offset is for VRAM range mm_nodes, if multiple ranges share same
mm_nodes, migrate range back to VRAM will reuse the VRAM at offset of
the same mm_nodes. For system memory pages_addr array, the offset is
always 0, otherwise, update GPU mapping will use incorrect system memory
page, and cause system memory corruption.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f2901e7a993e..0f18bd0dc64e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1153,7 +1153,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	prange->mapping.start = prange->start;
 	prange->mapping.last = prange->last;
-	prange->mapping.offset = prange->offset;
+	prange->mapping.offset = prange->ttm_res ? prange->offset : 0;
 	pte_flags = svm_range_get_pte_flags(adev, prange);
 
 	r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
