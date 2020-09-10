Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA50C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 18:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B1821D40
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZaiM+Rs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B1821D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837C96E071;
	Thu, 10 Sep 2020 18:06:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C22A96E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 18:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngnxlKIvPKot+XZJo8yDqou4z437anfLQbA83IjPyOuqtEp315cfqdFiOsq6YHDfWsVD/TiCER4kqvVUsqZN0isbg9b5PmbsrVjqXJBUYZxHdqIcIOKaKsngwOJrwPeKeL+64HJFNUCSwiaW9hZa8iJ5CP+faOzvuIq3cq3X8p7mdhiwYMCDw9MTz8i6AJdPLDbuycPIIfTvJJRNXNNhSDsMqI91GNuk+e0Wu2IRSyvmFXykGjx5y9GCXcYsGsFb7ZJdRne1K5+Smr5ewxvY38ZPlC/aBcbAMGwkS55iefXdBiWaSTlkIgSjcfTsdtTlHyEeFko6heeh0uisc33/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cws14avWHJc38o/M3N5668LEiewx4iU/CB0xne8PBk=;
 b=I7lI00pN52BlajcHOPvyz8HGZcT8121QRoBsjfuuqZqrJXB6Sgm5GWTtD6/HW7LtfCGKrSvuFK96IOVMcb1ZhXR2pMW+CyAUqGnyAMjhTK9730pdkkPR1GLYAwC1JVlj+oNvnRZvqWW26yQ5TyTuzNBd2uQcJH/IRP5DhqWqnXoB9RKIaO1zUTs8S3zVxDzf7hoEYKIHuR5I1MLI/rhqqfok+rEe1I2x+AGMc0ivxNfaldXWw5goi5TLfkMTpB1TJbBIkhAru0wyqOJUsdRdKCASDDI4MU/cKj/JO16FsFcxoaWl1p4YK328TxgIznRF7Go15g2e/YXN0FEWG0Yovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cws14avWHJc38o/M3N5668LEiewx4iU/CB0xne8PBk=;
 b=ZaiM+Rs4EVKXiqzwK+6tuYFlztMtjewdmI0x0GeVCcXUv3V3YYEiegDn/htukRqeTpx49UgQM/DawMTEOsTv3dRif55+3SFqpFYuIu8U5Eds/Mgna+5pn7ymsESRQG2T8EfEG02vSUVelp6NP+hTNUWgFP9XRtZcHSKlil+Qz8o=
Received: from BN6PR16CA0003.namprd16.prod.outlook.com (2603:10b6:404:f5::13)
 by MWHPR12MB1758.namprd12.prod.outlook.com (2603:10b6:300:10f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 18:05:58 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::4d) by BN6PR16CA0003.outlook.office365.com
 (2603:10b6:404:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 18:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 18:05:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 13:05:57 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 13:05:57 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Thu, 10 Sep 2020 13:05:56 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Include sienna_cichlid in USBC PD FW support.
Date: Thu, 10 Sep 2020 14:05:53 -0400
Message-ID: <1599761153-13679-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36f4e434-afb9-477a-58e1-08d855b42b2a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1758:
X-Microsoft-Antispam-PRVS: <MWHPR12MB17580C53C9F336B3124F2FABEA270@MWHPR12MB1758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mv/Z2FNqhcjUZOQt/WKOUxu9qk4ZoHcqLekgyGJUXO2aTswPtdOCigPgV/lw0sOZH/lUjRzD7gIHS6WQ1XSnOkmJm0arlpkWx8CyV0/TdL5y2VZnZpgr/w5Ud3azX7t1vZcPRfI1uoX4/W9SXyZm0aHV5LIxrxCIvo00B2ZSdTCcNMbwkWe6RhHwggaceWsC/H9uIftbD4ixWLzdPevowW1D9xV6jh9B4n0CrlmeklmXXGb39AZQRM7mJGn8t4CI1Wd/CDLzi2j4+3cj/buwwuW/xePuGzLH+7MngHVIORrpUbBWXhLXAb/+hD03sZxE+INYcKhI1CMxFoNvgOGjdTRFuiHx0Y0HNBH/ClZd8007STdh30dLCyIr4WArTvY6I7vrLyC9dLHnW8kZ/JckDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(7696005)(82740400003)(54906003)(5660300002)(86362001)(8936002)(36756003)(70206006)(26005)(70586007)(316002)(2616005)(4744005)(47076004)(6666004)(8676002)(44832011)(6916009)(478600001)(2906002)(426003)(336012)(186003)(83380400001)(356005)(81166007)(4326008)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 18:05:57.9165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f4e434-afb9-477a-58e1-08d855b42b2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1758
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Create sysfs interface also for sienna_cichlid.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a7771aa..600015e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -178,7 +178,7 @@ static int psp_sw_init(void *handle)
 		return ret;
 	}
 
-	if (adev->asic_type == CHIP_NAVI10) {
+	if (adev->asic_type == CHIP_NAVI10 || adev->asic_type == CHIP_SIENNA_CICHLID) {
 		ret= psp_sysfs_init(adev);
 		if (ret) {
 			return ret;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
