Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C03C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C0220409
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pX+1CxeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C0220409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0576E5A4;
	Wed, 25 Mar 2020 08:33:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F13C6E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRpXRkXXIiG5UqmOQWVsnmaX2krWwKuLM3+fplt8sHLPpjp3B0IYC3lx9ndp4F7lfJnOZL+DAXXFVB1HhxQI+RD05qybK0tddZwoUe86WfUnxoFvjuOmWH4/wm2LtK3kysRayis9DnGwlLSgjjNF7KlUgNe0GPA/3iT9vmUvvAPi1JorGcavJMvpH45FDbTry+XhGn0nWvHoGALT87PEh+OgYoLUPV79QtwenWoEORDZZGZ7aKyqSZVn2sQPdBKf/LVC7mXYOZCT+D95WM7SB9jHlk9L6GE60q4XTnW+xgjQqmNpvZaa3YsmT4Pip/CwhIu+x0n6ojS68CTXIF35Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9CR0vhwlm8niT0XKCaZo2Nif+7rZc/enFcNLJiFAcs=;
 b=YgXqY0MWtDdAims7uc1o0/yMtd1i+D5epqAx0l4CintNO9FeHiaLFTaFl8lqulKyDeu1N16pNmlVOqCqXhSBR8YF/bxn8fZzXbw3LKTKm1w75j5dPhCIVI+4vOL64uHxSXq7OOl3ubibCR0OgHsNR+BZf0SPdDQdtOxQZVYls1Fc7ldqah6q3je8BZEJsv0VPnCfP2bd+QQn+gij9dUHsif237A0W0CIFkfiPWjVQ4bQrEJQd1K+hBc4S2l5f41biNtvQpq0PAcUdLU2kn2/6MG44giDRWAoEQa3v4kC8DsRoDPAtaX+s1rrUVqgz27oom22WJAiqMq7xFOhHU8PRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9CR0vhwlm8niT0XKCaZo2Nif+7rZc/enFcNLJiFAcs=;
 b=pX+1CxeZtt+p+2oDeLxjQPyvJgbLZvkukm4761go/CqeGEGYdQvoXCPNsqhjXI0sQ3opr1boy0HZS4/8w35udTVSJlkHImoJ1GI3zzmN2hxDJKwQVQqka1MSyqvTSOFVN6xa2HQASpQR97BfEox93x64S7eQBMMRDOPo200kdD0=
Received: from BN8PR15CA0036.namprd15.prod.outlook.com (2603:10b6:408:c0::49)
 by BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 08:33:49 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::92) by BN8PR15CA0036.outlook.office365.com
 (2603:10b6:408:c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Wed, 25 Mar 2020 08:33:49 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 08:33:48 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 03:33:48 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 03:33:47 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] SWDEV-226663 - Ignore the not supported error from psp
Date: Wed, 25 Mar 2020 16:33:01 +0800
Message-ID: <1585125181-14195-3-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(428003)(46966005)(6916009)(70206006)(36756003)(70586007)(4326008)(2906002)(8676002)(47076004)(8936002)(7696005)(6666004)(82740400003)(2616005)(5660300002)(426003)(316002)(86362001)(81166006)(186003)(26005)(81156014)(336012)(478600001)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3763; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d198cbc2-437d-42e1-acae-08d7d0973db1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3763:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37635FFD5311FEF8687CA5B68FCE0@BY5PR12MB3763.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAF73zatxD9Mq+tqaIOP3e8obt0s1O12U+R5NxD6orDM14BKsSgSs7oEsR8f2qZp0j46kJ+SR3y7S76oZ54C8RFEzLkFrlXlmJULrjP0NZ9PiHe7JFDTum0jQqTPh9TSNDEgByg2hK5mzLuDP3H4qhP0F3PFeCmV8QPHOtvegON7Lu94fKw78Dqe8RlU/1R0nqWzqWHmcBpnxPQxDT9qplAnhP8oCWiSMLwsZpS6J92+SLga3JbT4wK++hsJVJLImKRyVJERSypsO5D1q2PGoYCqI1uPxJy1HeY0eZkTEnTr/NIfFr012SmqKyN7JDS/hR+69WNN4Fl2U1ch9bWIUsB3wnm4GvME/k5ukObx09DaRmtGaCjzzCRaZse1Yyh6R4dDrTHky6r4oCEf7aCyoPGI2PS7eilemI4Ec9rZVmxI2yd1LIGD5wTmp9m3g3IdS7BaPATbMrnp4CRNaZZ6X5aqsJ8qshY1pvmEjyw6MS2XRIKxK/e9q9T8Bu9vKcuR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:33:48.9478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d198cbc2-437d-42e1-acae-08d7d0973db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3763
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the VCN firmware will not use
vf vmr now. And new psp policy won't support set tmr
now.
For driver compatible issue, ignore the not support error.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c2bf2d9..1a46050 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -205,6 +205,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int index;
 	int timeout = 2000;
 	bool ras_intr = false;
+	bool skip_unsupport = false;
 
 	mutex_lock(&psp->mutex);
 
@@ -236,6 +237,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		amdgpu_asic_invalidate_hdp(psp->adev, NULL);
 	}
 
+	/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command in SRIOV */
+	skip_unsupport = (psp->cmd_buf_mem->resp.status == 0xffff000a) && amdgpu_sriov_vf(psp->adev);
+
 	/* In some cases, psp response status is not 0 even there is no
 	 * problem while the command is submitted. Some version of PSP FW
 	 * doesn't write 0 to that field.
@@ -243,7 +247,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 * during psp initialization to avoid breaking hw_init and it doesn't
 	 * return -EINVAL.
 	 */
-	if ((psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
+	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
 		if (ucode)
 			DRM_WARN("failed to load ucode id (%d) ",
 				  ucode->ucode_id);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
