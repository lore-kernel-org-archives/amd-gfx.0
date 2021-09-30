Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AA0C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 13:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE52E61528
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 13:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE52E61528
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 335826E084;
	Thu, 30 Sep 2021 13:18:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24676E084
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 13:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzvcPC4H+Vpr/u8BYJ5eDjnkuPiDXxvRNDCJqR/bzHCV5y5PsMrevu8DZ43Lo/CWaqPjG92C/jfuXcYMKxtr5eJjqD80p8e69fabE3NqN6+H2w0dm3P1wjs5L9vVYDkJ3c4GmXtv98o00XjuDYGZ09CZb9/RdHAcLtgYEBERX/BOJWOsP/GYFoqsoFPK+YOwdCeYW9yRu5OZZN2M1lIayzvemdQd6qzisGtCxojfyqKOccx7i1IOwEXiXYung2B8em1GjbGOldbMS9EQ0BlbV2r7g3T3ToggORaFBW15gmxXaG9MIPlXTNiNoZ7+POW6hUt+LJqJBAlFJIRzWccwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=JB6MygCnVATVdGSAKecq3oNGp7C7hR0M+Ii2OpRWbKA=;
 b=DEajqWdvIwIaiMb5P6/RldJwkUGm1ciH8SY0tbXJNRFTdf6H42QGA+z3X+a0UFrTpQIhHymdFIkw8fqAbXfRKeBE9RfxTTZQ7DSs+O/Os+ekX2Eqy2UFwr6rTqZnmP76NSzW9ITJGHqALysSi82GSwSMvTvLyOyW8SFF2mW3UrHDRqWOioQ67dvE4BrYHICQNgm0aud6Blxyikak33BFTpDZWexOjXZjjGSpI4oIsAMbk/EuTtkJI4Yov6XZOj9KiaiIeGRVjIHnRUDFZM6BEYA34esl8/b9CyErEaTKzsJ7SbNHfhQwQYmOnA0iMeg8zdY3kn9CH3Wpi1vrf3ShPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB6MygCnVATVdGSAKecq3oNGp7C7hR0M+Ii2OpRWbKA=;
 b=aSqTnLXj6f2L6Fn4MwkoANYke+CNw0VQYk0WgNSTFw1RYv0g/WFCGn35rJ3XhyNGMZJQuafqHFrH8x+Vei4qNcXPqfmTPoR14F9/uwk5yqrZIT5GSFa+6om2Vs2bZ96UpY7ND+fxXOT9A/nxgOXz5oPH7JLD1F8/wrP3QCuyzLI=
Received: from MWHPR04CA0072.namprd04.prod.outlook.com (2603:10b6:300:6c::34)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 13:18:27 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::3b) by MWHPR04CA0072.outlook.office365.com
 (2603:10b6:300:6c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 13:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 13:18:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 30 Sep
 2021 08:18:25 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Thu, 30 Sep 2021 08:18:24 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Anson Jacob <Anson.Jacob@amd.com>
Subject: [PATCH] drm/amdkfd: Fix dummy kgd2kfd_probe parameters
Date: Thu, 30 Sep 2021 09:18:22 -0400
Message-ID: <20210930131822.2194663-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8680714-aef8-47a0-3ae0-08d98414c9a8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11474DA522DBF0E53153A8E8EBAA9@DM5PR12MB1147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iB5rC83GFQTbcK1qOUo2VBGH2TDdW3/c49tOTIcVRP/mPuDty6ZzZEp93u74U1bPAYixmOjormCHPo61b5Z1wlHLGKMDS/2SL9MzKbdZasUwXv4cy8T2viPO2T9smrnxIgSwX55WadkkOkR4J6tR0/0S8hkBmqK4T9JBYVqH/VlESJS3lZVuoWeBc5VAQoeqQQM9VmIkjVbMaGy/grxAtzbSMMhKgtfVUwqe/y8RauC795fKyBuHeIr6o2i8LMtExT+j+bHDjR+p+KWMVrEGhuf8PCIsbx65wWtw5iX6ifLwWsS2/9o9OM4K/6dCjJOH9AVvQ/D35/Rp1oogi2nJDQLLK23Aux7jghzi8S7vJctE7KL5oq2BKEaC3UcYRnib+j3t2EpXa6T2W9t39im/i4gvOohe/ACe5bDwJ3cHOLgnPXimOBcOoDK2FiHfG4giv/xi+HwNJ+8xTM+hTRuJ7BP9mY0odfQXEKU+5BIeQfGV83IllC6gCxw8qYnwjiizHXlkbPIStJrFE3yCNr+stdkY0vhXoK+prCufHE6fs2uXIIBzEUmcb9Ox/WwMk3J4eJ4z+njQva7yyemFWXq3ilNbEodWp8bkgwKULMu8CCVDWtPcHaTEoJyxjA1kUCek4aCqXHMA+COfJwMxQnNzcEq0LgkOx4u2XJ90YcpvrBYQtOzCX4DPGKi9nbsTuXrM7vcnrbmpUJp7qN6umeXYhbeuqxhiqZFTm6Fudsg6jig=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(7696005)(2616005)(1076003)(36756003)(426003)(86362001)(356005)(186003)(4744005)(336012)(26005)(5660300002)(6916009)(81166007)(316002)(82310400003)(47076005)(8936002)(2906002)(83380400001)(70586007)(70206006)(8676002)(4326008)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 13:18:26.5474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8680714-aef8-47a0-3ae0-08d98414c9a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
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

Commit 4d706ed6825f ("drm/amdkfd: clean up parameters in kgd2kfd_probe")
updated paremeters for kgd2kfd_probe. Update the dummy function as well
when CONFIG_HSA_AMD is not enabled.

Fixes: 4d706ed6825f ("drm/amdkfd: clean up parameters in kgd2kfd_probe")
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 38d883dffc20..69de31754907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -346,8 +346,7 @@ static inline void kgd2kfd_exit(void)
 }
 
 static inline
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
-					unsigned int asic_type, bool vf)
+struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
 {
 	return NULL;
 }
-- 
2.25.1

