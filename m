Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CEC1B08C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A658F61073
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 09:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A658F61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F8696E5BD;
	Thu, 15 Jul 2021 09:14:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0325F6E5BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 09:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdvNISf5YQ7P7NfrZ2q5kTSrdUb4bjl5thGgsXmbcmMS4m7Ke5YR8W2ZoSEQowdqFEeLl1867d8E5EEo+2YUjchgaNjUj8hoKntbbg/XvB8TCPoNTQ80Nkh4KcS+fdUF0CIa/oWevhJnYSDHNqFY6eseKxNxxJ1owymEl29oVyzaakywQeIE+PNyDpweb0Ll9MFfwpgpg68DrzXP0oviMyieLE8zkf8qEfvYcL2H2VnGlq/grUWMkdKp6u6qxFXZhnV6q7DqEPV0sZ2Fx1J/294SgD8k0ZQhuTEOBT1spXJWFBBsv5FEwkL4ilAChBfJgDMqRqEUx7np5V+N3O7xrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daVIWQZGSHBPO6CXUZ9v2u88K7Xraz+8CUZ893P93lc=;
 b=lqmBp7nvTmDwBE/HVdIuWqSejPQqcXZGvQRS8DYdBgARBrNra1VAyHvqPT5hAG4qaExnuZFc8YneD3bwbMYWVkvaMBD00m3T6VTH1l4FsKNAywKB+oMNNZAYvhwqCTlSGCXO2/cCOLu1dYSmoMVpx0oPUv6DJ5xFl4KSJLCjEYE0C96eQh7KBINeEoCwujMj6ia8qGITyoHggL/Ih0t9rYX8OfUKLEDOkAURw6+02yRyxzWdD6WF7o+oem0o+SCYvbRkvkNLOmAkwTJbbLicoNcZRceFuFwer5P4njP/h5kIyVeoQWQCf0xU660ykJ0S+SubCytIkLH61Jbzx8/jjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daVIWQZGSHBPO6CXUZ9v2u88K7Xraz+8CUZ893P93lc=;
 b=09FzlQekB4uYfnoN4Kg+q+/4yMTDFyFfU53JZRgcZ37kyXRwk7WSmFD7QEblQjyGgq8CW1pzKA/LIiA/4EWdCixjC1DkdnEKkzHGDl5o7uBeCsqlAS2XFhSQUBx0v/SzjTwQ2r8x5Y+4fO/dCbLZgQYRxENemrGZmmqYywue/V4=
Received: from MWHPR22CA0020.namprd22.prod.outlook.com (2603:10b6:300:ef::30)
 by CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 09:14:47 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::56) by MWHPR22CA0020.outlook.office365.com
 (2603:10b6:300:ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 09:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 09:14:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 04:14:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 04:14:46 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 15 Jul 2021 04:14:45 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: set noretry=1 for renoir/cezanne
Date: Thu, 15 Jul 2021 17:14:43 +0800
Message-ID: <20210715091443.830741-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 475c496d-264a-494e-15f6-08d94770fdd3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:
X-Microsoft-Antispam-PRVS: <CH2PR12MB482466CF932960FC4F023FD5C1129@CH2PR12MB4824.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWvu9TNJgMeLpHIKGYGsUrtsxHoT7WxNwfcQmdtleXEDxxFjJFT7ZTQ1Rq2mtT1uvNgnRL/RVIhQwN5GqmXiwoqjP+p4aq/BV6Wjr12UH+U41oYIGvu2D0b5uqtNF5tWybhW6T3WGNqnJ35x/pntLDyffbxS5Yp/mfdnR02C4j98vYAvTwEUpeH1RWWPNTERJfnOjq5xPrDBEz9okQHlA7HOcRVmuc5hi8sivZncGolgI3i3ykZlPqojDFBvX810dmjMCh61G/oywSrWFXZ+WrugJrkADcTMgTbBTQ3xroOKMy9CoaxbOy++7Dxfhe72+WCRxJd43OAWiTdIxUfA95w6BubWboq3O579W3xx4Cnj+HbwM7PKgTtO4heqNukoM9FGakaxVY0r8hRlCSWZvkEGi2lVPW0SmMJ/dPVBiKkKeLrKjkODQ7qIsU7OnFqZfS+//elLR9y24MaXxlElTYL+Q16w9Ryl+sikx4nIJwfTzWVVTfBkDwx2Wv2LKswzkdP9GaSNfFYVLpz30+1LID1kgFFkkKgpSbQrpGSJHPa2gsJ9bXe83plnoAXyg6zBfulbq6eQNQR40XqJAUoGE8SBEEoDU5SLfwW7wX3cpbHbcWA/IMjtv+dZRyus1409IA/I6Zq4zdoss8wp9jTXeSYpOW/vYMXfJZznIxoFYelkJDFO2ZvLn42J5uF5OeBTv3kHp8871/ummSAjpsWnjKVYku6gy2RJWjXn2rfDPto=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(6916009)(186003)(5660300002)(336012)(426003)(26005)(316002)(2616005)(478600001)(70206006)(8936002)(70586007)(7696005)(54906003)(36860700001)(36756003)(8676002)(47076005)(2906002)(356005)(81166007)(83380400001)(4326008)(86362001)(4744005)(82740400003)(82310400003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:14:46.8335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 475c496d-264a-494e-15f6-08d94770fdd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4824
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix kfd svm test failure in renoir/cezane

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d4e9704dec62..00dc2824dcc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -592,6 +592,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	case CHIP_ALDEBARAN:
 	case CHIP_BEIGE_GOBY:
 	case CHIP_YELLOW_CARP:
+	case CHIP_RENOIR:
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
