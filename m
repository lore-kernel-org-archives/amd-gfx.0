Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD5C00454
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927F42073B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 17:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uzdXDDH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927F42073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 134A26E0E2;
	Thu, 12 Dec 2019 17:06:30 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622B26E07F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 17:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXYbEyaatRGmTLTpGPSQ6sELowcFmfEAVchbWZBo9pOKgk7W8PnmVsy6wo/VcdZjfm+JLAYmPf5DyRrPKUc7h1TMiEKYdggowMc/26VSGXP89EpgB5HuUhX3tOgbqZTi4aCIVQxPodXEY/JNq3LisjCLfz1ESsWNiUb5EpXjBvm89GXMevT5tgV5KZXfYFAzZcemmFxwElnCNVd3JIloy3kxgKQ5567UkdOlyBSU9T62AANkGAxf0SCrnCNKr0jPRy/cpVTT3i2KvP07yi7qupzyX7O1Pv5X5fnT1fqqY0BirytgXuATrOvYBIXnIiJXifxudoVaCrScl0+75zjKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN8X/6mApmN/11WxERXr8TgFQ+RzSetzHO2EyCPLvNo=;
 b=mzz5SyRnJ8oNB/2P7RniTG5dGl3jDcSaFcUNRquNVYeFg2X8BUcngEFQ0xPl2rI2HP/jaaId+JV0SqkZXiN9kAN4WTrmZawNt2aSKZRfnj9tpZwiMpluIVdscSC7Zpe8PWTKT23r7REbxDqRwtyhmTrRFdZ5brPw4mRqgRMy7lCAPGDgP/+54gXLIuW1TTR7mDZ+x6jZJacGiOhz7cDM4MYoPjCbsy9yOpev1U0joQ5ooVl7WrauT45JTi0fR3XJjISoxRI/DbsCTeLIRslbgWqN8kK5tmyShVdrYjyzP3al37O/qd4GXx4OqmPYCorGIFZeCQ1R6L9knWMukR/rWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN8X/6mApmN/11WxERXr8TgFQ+RzSetzHO2EyCPLvNo=;
 b=uzdXDDH5FVasYn756F6wB7MEitNITYYRfcOgtRHKuJ1kjNEPc8vAVPMDmHWsZwwdrrMb6B0A+7OrJ9pOntCS5P3jSmhREdBz6++j3GHDHbiVUr5Lm4TaDMODi4nPLdYyoF6kD3RxhpUKsCHTlxib1H5PukzhSF350osWec5Nyec=
Received: from DM3PR12CA0129.namprd12.prod.outlook.com (2603:10b6:0:51::25) by
 MWHPR12MB1710.namprd12.prod.outlook.com (2603:10b6:300:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.18; Thu, 12 Dec
 2019 17:06:26 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by DM3PR12CA0129.outlook.office365.com
 (2603:10b6:0:51::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Thu, 12 Dec 2019 17:06:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 12 Dec 2019 17:06:25 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Dec
 2019 11:06:22 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 12 Dec 2019 11:06:22 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amd/display: Return correct Error code for validate
 h_prime
Date: Thu, 12 Dec 2019 12:06:11 -0500
Message-ID: <20191212170614.24837-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
References: <20191212170614.24837-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(428003)(189003)(199004)(6916009)(7696005)(316002)(4326008)(5660300002)(15650500001)(4744005)(86362001)(26005)(81166006)(356004)(8936002)(81156014)(8676002)(6666004)(426003)(2906002)(2616005)(478600001)(186003)(36756003)(70586007)(70206006)(1076003)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1710; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb314603-5523-40bb-ae71-08d77f259f65
X-MS-TrafficTypeDiagnostic: MWHPR12MB1710:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1710E2DFEED362C6C9AC2F02F9550@MWHPR12MB1710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0249EFCB0B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SktxD4+Va1n7zufalnIaCDEkjlO/5esxEVU45RIhAROb+LZIOuFalZG86gfZ14rJdK3mSoIZmZmpXj5JmxqW2lcoE47Ycp6tv3zy7uLmTk98yVQUcVxrQwh3uvEFG2lXWMqcBMDXgLPEEZGk2gmuS/ahqXTrBEJBbdN0EnYLkzFsQsrbkQ8byH1r0H+ttV3XfancZ35wNPLkg8iwK4Z0JRX7aR7wYIfoNI3KC2BnbeJgQsCiNoNQIjh9I5CRE4x4CIvMB+FiNUCEz0v+48KyJue5Gx1TTkqxgWcWffttThOuACCGhSpHiY6Tks6WBnpkkiFEMk0CyIcl9usOIiECQ6h7BoIMPU4Isx7l5UPw8XGyZ7hYmRWEdnAkOY3K7jUExASfnEY5ugkSINArtK3y57RUiJduzNxQVelLTuZyCE15/6zSJczyrxHVr0098VKK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 17:06:25.9392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb314603-5523-40bb-ae71-08d77f259f65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1710
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
We are returning incorrect error code for validate h prime

[How]
Return the right Error code

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 8f2e2fe50710..7911dc157d5a 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -511,7 +511,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_h_prime(struct mod_hdcp *hdcp)
 	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
 
 	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
-		return MOD_HDCP_STATUS_HDCP2_VALIDATE_AKE_CERT_FAILURE;
+		return MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;
 
 	if (msg_out->process.msg1_status != TA_HDCP2_MSG_AUTHENTICATION_STATUS__SUCCESS)
 		return MOD_HDCP_STATUS_HDCP2_VALIDATE_H_PRIME_FAILURE;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
