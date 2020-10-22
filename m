Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E7FC2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F5E208C3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wL0Wp/2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F5E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D616E041;
	Thu, 22 Oct 2020 03:04:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E25A6E041
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKIp+T3eiDqzkz3FIGCbc+4b3BN7C2/JBPiAhlW/93F2nDn0NzjNvjmHimOHVUbWe5yuE77v7uOIKOqXSNZ1zPcrdcS9Pv2i7H2+kHW0K+ib0xzyDM+rsqCd1nozKZ/ikEJR3TxvBdWp3IOtXhTPSpB2YaXzXCHfcHLZiSHD9lqlCcLKfh9ocRSzostScBI5pQtRRhYOK+ZyUydbo9eBD4vnAKUt9ejntt4p5DWewgWbL/rblrDv5e0voUnoDwBDpeMf34UCjoRlO4MK8edH2qrhfL1MB3ZgDPgHYTH3e8ueINMmmDDR9tkXgbo0Ipns2o9rnpu6b2NgnFTVxZs5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V47mnsc6l5GmcNoRqQ6EW+NQNc9fdqdW3sNEg3ewai0=;
 b=FZqldCrvBxErf24Y3krb5UrY5RAxx7UlzP9wDLMI+tJzvnhwmlpR5SbCnZ3b/MAisvRc+OfyJm3sgTnyeEypfCPu3elM0Toz4TnqHw01/DB7ysKtvI+lvyc/5q4BNpMGv2+MbCxDk3IbRBDYo9DLsKI8GT/obIfmVnXBXwzXiHFdGuICYKydtJ8bq7B/D+3gPCx0eTCkcpH0Mb2PmyvZJ8RobfvrIXTBqgkyadxKIx2vVNt3guifd+QeA4+NxrOpqvVefDEon1yCbRyzxzjzzfOL52pQHD8IJfmOKFqo+6gNgVKHodBImyzV7pf+c0F2E/LZHVE8EhyO6A27bJGFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V47mnsc6l5GmcNoRqQ6EW+NQNc9fdqdW3sNEg3ewai0=;
 b=wL0Wp/2OFpMwtiihOZ4vCMavI9/Qiv6cPknPMWdULszOE9fqRRoKmnjKYrWpzZEqYuecOoV5zpzBVA+cCgl2Wle3Rx+8OyAJaYiRtxJqwXyHPuoRBpMNHoNlUAtvED0i+87hLJPzmiRKisU3xzrAXUw5kr186cJrGn4h3fbCGGU=
Received: from MWHPR14CA0060.namprd14.prod.outlook.com (2603:10b6:300:81::22)
 by SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Thu, 22 Oct
 2020 03:04:38 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::aa) by MWHPR14CA0060.outlook.office365.com
 (2603:10b6:300:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 22 Oct 2020 03:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 03:04:38 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 22:04:37 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 22:04:34 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU
Date: Thu, 22 Oct 2020 11:04:30 +0800
Message-ID: <20201022030432.4011-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e6a2700-4b96-48c9-23b6-08d87637367c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2702:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2702FDA6B4CF6BCADE16B762951D0@SN6PR12MB2702.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKZCBotvV9ejmO0KQloFOlEuEvfIzr8K2h+euHn3R9oe1MXTR2900NB4Xgj/ckCI3L82ma5keOVZucZV/qDAdQHik8egO9t5R0o5gPGg6LzbuLc6d1iRtBJ7Z0xbAq97Z3qFXvmG9jF6m+FBE+P8MLdl8eFunvDblVv014BGVwCWlsFUuwSRk4QJ54ByosKPectM6xjh2w4uXzfA1YrLlTGniwoQTMwuMVXxqlrIqm6bgc9rk0OSKLvUl1z6NlFPkYe8MlPUxPYlaYGOtTbaAB2qWGr+8PtAtaBm5ya5yeMUmmq5ooIfsBapzWKZgu/PzA6hpHoiK4TtU60ZTotSqtwXF4qgCSazWYb1RPre2xStlPKCusroIiVpHPTA+9net+Qg6a1mD9t5k/K9T0WJcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(70206006)(2616005)(70586007)(82310400003)(478600001)(336012)(186003)(44832011)(5660300002)(6666004)(4744005)(7696005)(426003)(82740400003)(86362001)(356005)(47076004)(4326008)(26005)(1076003)(8676002)(36756003)(6916009)(81166007)(2906002)(54906003)(316002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 03:04:38.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6a2700-4b96-48c9-23b6-08d87637367c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2702
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

Change-Id: I58129e3aa88369c85929e4dde002cf43c3ff288a
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 564336c2ee66..13723914fa9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1066,6 +1066,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7319, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
+	{0x1002, 0x731E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	/* Navi14 */
 	{0x1002, 0x7340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
