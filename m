Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F78C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 00:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A06B6101C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 00:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A06B6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1120A6E0CF;
	Tue,  1 Jun 2021 00:06:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3596E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 00:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnDkGkyGblcaDSkQaXGS9bo/U+Fwtji/5st5CscxMv4QYdt36erhow+itKXs6Qe2dfxhuQlB+W/fM6HpJB5fyfkRA9z3pXCxJ/+8NJmfqdEDWyvfg/dCqFJqMO/+xE72ZrHmDefsmew4Ame96LKhi9o17SSbX+keUm2AIM4XsjHuIGYkjmWteLmdGJP1Z2tyTUtUi748bHxR+Axsw5rWehH0poVXIE4JE6tnhWKYCpEsh9wKnZcQJxUYpp0IOBOKh9aISeFNV/aBGjwANvoWASttSfDGBCm8OE5JIhOeBWXZUOszQnd/ZeiuT+cov3lJjQ5X1etbPh91YzKUG5lLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oisG/kALgNF6Cw5fQ5eyl4gWu6eph0ApXVAXFJYPTk=;
 b=jMAtK+LL4265bCiC2NzrPLmV/nOw41fWGSJP+10o1YNCCy9GfaQTkXkuWyzIQmLEnubvQLTZeNz4jqbimhgKXaEnfCOUaZLN1LtxW9DL5qZLdbmPJqAPafWkVSoZoW/+wcO6e2qTgESn8vuJG6N7HkIfpJFkvNg9MdSzhEkf9ahrSCdK6GbRN0ZvY8q2tsQYFSwQcZkLNYBPLlqmXFWObCGMr/plDBQHQXwGuHNjRGBryINPhFSuxf0JfBmNpiP2JmtL+AbQAhlTpTpLs0kjkXlCUQD4pAV1ATEbcSiS/l1ENuZMeahWCXySHGfEQPkVAeHdmzU6AgtqtYXuZfze6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oisG/kALgNF6Cw5fQ5eyl4gWu6eph0ApXVAXFJYPTk=;
 b=zjht2AoXZ6+bpy2BFznlRn7n/OAHw+vo4EnGxnIj3JLiiuziCwiFhCsaqGdyIqKBaOJNdt6+Nv+C7N0fqR8mN3C2HUuiaCdvKDMsHZgAcNTgZw9ZPIAMOgu1QFpFm4GsfTfDbwIqg7FXbR5GAZcaaloi0MRNjsGGdmqXSmzcL1s=
Received: from BN6PR11CA0024.namprd11.prod.outlook.com (2603:10b6:405:2::34)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 00:06:39 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::9c) by BN6PR11CA0024.outlook.office365.com
 (2603:10b6:405:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Tue, 1 Jun 2021 00:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 00:06:39 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 31 May 2021 19:06:38 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: Fix a bug on flag table_freed
Date: Mon, 31 May 2021 20:06:24 -0400
Message-ID: <20210601000625.551445-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 338aee61-8eb5-4219-f5ce-08d9249120fd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4366:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4366B4862A270130EC802DD5823E9@SA0PR12MB4366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ox9h8kDeTXoIAhz1F1pONRY2ZjE0Ux/PRBhXInyjNyh/+FTjfDzX+spQN0PCLu798bVWPuB3PXAlArHUs7Rx8M3JKA59Pvg6PokAE7DKU0YGFnBr424QON+rHCf0Hn59RX7bmPa2EpG0U49BtTSoHN/oCRrHAsQ9Iyq62dIDwbFFGhXM0MYempgfgh95UMldAdNv0fpPxVrecbc1lhhs8uBfZFXCcf2vLNWswF/d0KuGI2Z86XGL1ww/ltIWZlDluqy6xWMoODaJwSP/5JlW8+PR4TWcU7yLCfRRyAT3SI/tZrsJCUZnhhCVeadhIG7vjN42gVIBCTZ4h0PV/PU9GRa5jwV0WQlLhqYH5fXUm63HmValgt3cr+rRNxGKwZp5GkGIpdQCCLITXj39zxAA6+GYXK0ARXvRVQddzX8PhYMqOtRatvPiR8KB6E+3mqn7+Q9/D0uQKQM84EyUgHQAzxNW7pFNR9BAOaYAho0LTiZeRrlGC5IitV0OzcYMHPLSFWhDlMjLsS8S+0oTB5BCnPRyrNeAnNiSnnwSI6p+q4DB384YjNfYBItp2tKnIkQYxGrO0TUZRO11fzMU/LXJcguiwocARUbFmDN97lW4GLzG8Pz6zXAXePrmT658I913253RHbLQ5lEf23nxRusuc4RjhugjPliHDZED1N19QMjKclwMvzpYFG6joazKTmyS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(8936002)(1076003)(82740400003)(356005)(47076005)(36756003)(336012)(5660300002)(70206006)(81166007)(316002)(426003)(478600001)(186003)(2616005)(7696005)(4326008)(70586007)(16526019)(8676002)(2906002)(36860700001)(26005)(6666004)(6916009)(82310400003)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 00:06:39.1568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 338aee61-8eb5-4219-f5ce-08d9249120fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

table_freed will be always true when mapping a memory with size
bigger than 2MB. The problem is page table's entries are always
existed, but existing mapping depends on page talbe's bo, so
using a check of page table's bo existed will resolve the issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 539c117906cc..2c20bba7dc1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1582,9 +1582,12 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			 * completely covered by the range and so potentially still in use.
 			 */
 			while (cursor.pfn < frag_start) {
-				amdgpu_vm_free_pts(adev, params->vm, &cursor);
+				/* Make sure previous mapping is freed */
+				if (cursor.entry->base.bo) {
+					params->table_freed = true;
+					amdgpu_vm_free_pts(adev, params->vm, &cursor);
+				}
 				amdgpu_vm_pt_next(adev, &cursor);
-				params->table_freed = true;
 			}
 
 		} else if (frag >= shift) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
