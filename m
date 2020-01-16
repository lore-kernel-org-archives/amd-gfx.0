Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA406C33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A7220663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HVI4vPur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A7220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8E56E48B;
	Thu, 16 Jan 2020 20:14:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17D16E48B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuspvAFozXL5Pbkk6UzGlrPHn0nOgyvjwEciu3YumXFmOdoMEvp+3MLBLZgYNV0JYxFFQCx/TztC3CD22z5GmGlXq5QZTLnQgnhbZc8vOtNLajKltdDWEo8yWDZlz33tUcr4qhlqJGOHUUCvAib3MofEwVHselDZ6ukeof/Q5jSAiJwjR4BOa5AJ/SoIRCeHTnQ5sNSVI4MI+YbpKqw/RB1gbIU10J6751Fkg2JRdDUUp7SoZt/6w95lkp5i69qlDAcgOlZIogAicMpiLsRPzGfsSJ/j3BTjAeM1Vsik9cCyAiehWbIFQ9A7R1o96Wpd+34c/H6s2BY2vqDil2+R4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8z8MnNSFZ7ZEsFH6HhYg6GOYScx/b8kfUtgyVUPu0A=;
 b=SClUh66ZfnQkNyVcjEKURsZEt8j4K6P92nyuaNcUuDrIfwHanuBAhqZSltcgdHCg59g9FppF09kxO+kBZtLDfyUzTRTHCZoeFhrk/WFMBb9cl2UDT0R6lXglEDtFhEXEQd67HK4VKClgErTl7vHXpkpL3nWJD/w5r3oFPyAUsrpmv2arWegpZZXOcOPsZ8hdnKJ+/DT2vj1DFUNXSVXDGFaGYv8a4lAbj2LxUvjh0FhoMl6hQXlFMrchGSY5AOIggRPDY86/+19AI8elWCoArEpscf/AnySFst6WiC/BOTT0XW233W3a42H6znoM/FWosU4onrJ7Npuh9QC1VfLaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8z8MnNSFZ7ZEsFH6HhYg6GOYScx/b8kfUtgyVUPu0A=;
 b=HVI4vPurzC2ok0WbvD0pV1EG56I3gTcA5tvK2xRE/PqZya+lbVQFrguK+RNnNorYwRXl1/NPCGn+pYGVBx50NlGsn+TZ1VRgC25NTjimJkVQE/62KS05gHarJL3qlsYNI6A5EXV7gosVrKbP0keK8icQVE3YCnlCW58zkQY6z7E=
Received: from DM3PR12CA0133.namprd12.prod.outlook.com (2603:10b6:0:51::29) by
 MWHPR12MB1405.namprd12.prod.outlook.com (2603:10b6:300:13::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 16 Jan 2020 20:14:37 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by DM3PR12CA0133.outlook.office365.com
 (2603:10b6:0:51::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:37 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:31 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:31 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/22] drm/amd/display: Check hw_init state when determining
 if DMCUB is initialized
Date: Thu, 16 Jan 2020 15:14:14 -0500
Message-ID: <20200116201418.2254-19-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(199004)(189003)(186003)(6666004)(5660300002)(426003)(26005)(356004)(336012)(6916009)(36756003)(7696005)(316002)(54906003)(478600001)(86362001)(4326008)(81156014)(8936002)(1076003)(70586007)(8676002)(81166006)(2616005)(2906002)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1405; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13cbae99-0372-4f77-45c4-08d79ac0b611
X-MS-TrafficTypeDiagnostic: MWHPR12MB1405:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1405531477D800AADC87C19BF9360@MWHPR12MB1405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSWV+Rq9+WcggrZ3uXJgCA2PkhR74M1awsgUQN/7HNe8XX4EtZAZEDOGNYuWJ+ju31rfaU3DBhH0fdcYV2Z5PJ9agfhaBCnCWE6gOF3BINjVONmPmvrSLlWNibEOnfa/PmJ7UMqBSFh4Q4UUCU2nHacGrl24ptY8fj9fUDc2anEXuCoANxpMUHJglUQ+XeY5Ec78DqPr/IaE1Da6o97EZIi+fIjU+wtevZ1l22PK5v/IQzrVFN1vYze15ua9hMZZ3P+9L8kDI2sxz+J75vzAdmGGUOSXkaC4uN4rYRoEdidqj06eR+99PJo1VlkxVA0fSVe5UoWv5+7oGwigJLFe+duauopqh9asGCf4JaDL1ATfIhDf/XjeVTTnuP1TkinaRaNCvJjvfUDjHD0BWoEODrWMcX5qhQYlow5hNy5FTMPn/sNHe6pDlyWfjOuEsDiY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:37.4227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cbae99-0372-4f77-45c4-08d79ac0b611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1405
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
CW2 may already be programmed when coming back from S4. In this case
we want to unconditionally replace whatever DMCUB version is currently
enabled with the latest.

[How]
Check the hw_init flag to know whether or not we've previously executed
the initliazed routine.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index ea99d4cf34cc..85a518bf8a76 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -312,6 +312,9 @@ enum dmub_status dmub_srv_is_hw_init(struct dmub_srv *dmub, bool *is_hw_init)
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
+	if (!dmub->hw_init)
+		return DMUB_STATUS_OK;
+
 	if (dmub->hw_funcs.is_hw_init)
 		*is_hw_init = dmub->hw_funcs.is_hw_init(dmub);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
