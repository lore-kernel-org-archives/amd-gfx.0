Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA571C352A5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 09:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8AE20726
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 09:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yWofMMMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8AE20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5656FBFE;
	Fri,  7 Feb 2020 09:51:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022CB6FBFE
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 09:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW0Iv22IO3iSiJCDJtN+JP1G2K42vMIzqHL4FFepTdWrYcW57BXR9AzuenLbKASxBxrAcQyBNZis54feX2fKRL2qD8yVdmU1ACIJUsVxIY+IyCWuv6ec52Ox29+TGVzRswRNQUiM8Kxd8HdIYUun0TJEOD16XBxNt8fQJ3AWhfi5/4VZrPFQjbzz6qrPhyPefUoJgCrGpf7DsFMmjv+xVT7InPPtgQf/U6JZEpOD4VjFkbd6uZGuGl1ftlkdrYAEE8235/nAs0po+hecLTM8NIFVR8KZEg7oqEgRqO2R0DF6wXgr4H9zBybTxbcNobTD9Xlf+VC4AHz/ayR6OmSI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIqAcbTU6g2A1IkJ+7SNjOmYeEgke5Id1zYpp9HlT0g=;
 b=gpTbwgR1ry8yZx2QB5O7I7aftTAEJa1nXD3Kv5EoL7L8wmjbKWSEcS18Ga6EJkjtb991k2KPDbw2xnfMplWNVGVywUJNBlK1fKKmsYLca8qZOsHauv3qyAh8W4huZLfTQpqMBpfXvB64xm87QKWuCGc3FYW0e1Jvr0Fbq0rJgBeGoEuKIT/UZ3itR3hZqR3ygFX0H6S+XW+bs5U8hRoiGjjNREfwGZp0zi1WnsbJ7XFOCvyl9U9qmjy3rFGjF78u5ls+E4rSxwh4EbOved8kh1fn2fUW5v8IyhssGelIDrFsJ572FeaRCskhrX82Eg3ThawjLpG8Rnxj/IZZpY+XLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIqAcbTU6g2A1IkJ+7SNjOmYeEgke5Id1zYpp9HlT0g=;
 b=yWofMMMALyiNb+oux3wWsAOahgdNijn1DSmwhSUjYyxRLi3sfhDpB43YVJAqcnFX4BiV+h/BjV8WZM6YzwsQFEFE8UuhGGM/yJenjKM2l2ZJL7/afC3wMlPpwIT/XyMV0+1IyXQC0CCbVCRaqzQVk/nUkI7DAk7pvAZRCCcUAY8=
Received: from SN1PR12CA0103.namprd12.prod.outlook.com (2603:10b6:802:21::38)
 by DM5PR12MB1497.namprd12.prod.outlook.com (2603:10b6:4:d::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 09:51:46 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by SN1PR12CA0103.outlook.office365.com
 (2603:10b6:802:21::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.33 via Frontend
 Transport; Fri, 7 Feb 2020 09:51:46 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 09:51:46 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 7 Feb 2020
 03:51:45 -0600
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 7 Feb 2020 03:51:44 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov set driver_table address in VF
Date: Fri, 7 Feb 2020 17:51:42 +0800
Message-ID: <1581069102-18302-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(428003)(189003)(199004)(5660300002)(356004)(7696005)(70586007)(70206006)(19627235002)(478600001)(4326008)(2906002)(8936002)(186003)(316002)(8676002)(81156014)(86362001)(81166006)(336012)(426003)(2616005)(36756003)(26005)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1497; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3022d11-412a-461f-301d-08d7abb35833
X-MS-TrafficTypeDiagnostic: DM5PR12MB1497:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14976492383E03C4484D7390BB1C0@DM5PR12MB1497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0306EE2ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akX7Nso0D9vku9jY0dWQe9znTXPljPJe4onomXLVrbmnnYV5Erj7wpPX1hQ87fvrIwVg4HeoVDFkjDqfgnnQiy/UfzCeoTN4iOlhvME5KwetxHz6GKmGNPyHb7InsDIdP5K96L5vBliySiVQFkFo1B84dCMjhCB2cJtVEfAGESN8//P1VNAbtLGZFBpf/HNyy1gWHJvwID6IZHyodWjKC+Qt0hCiqLoP+1+Y4cZMGT82Z/znNbIrX2MlDbjTkLgBIJO7zGsPTNx/m77N1K8qS9nca6VtaRupCjWnJDIh3esEpBBxKiRkcFxxklr6Bugv5BNcqoVPqbgvJF4oDRP3/uSbdNH6dP0MRjLPOEv7LTBcttvyb83n7KMpvo2j4mV3ZwWxB0bDSmA425hwKmISIZEt9QeLUF/1UcT89RdcCnlraJehRnFw33PE3arUFRzG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 09:51:46.2549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3022d11-412a-461f-301d-08d7abb35833
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1497
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With the recent patch to unify VRAM address for driver
table(a83f82e). VF cannot dump table info any more because
SMU_MSG_SetDriverDramAddrHigh/Low were deleted in the
function of smu_update_table.

Therefore, VF also needs to set driver_table address
in smu_hw_init to fix this regression issue.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 99ad4dd..b155f04 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1113,12 +1113,12 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 			return ret;
 	}
 
+	ret = smu_set_driver_table_location(smu);
+	if (ret)
+		return ret;
+
 	/* smu_dump_pptable(smu); */
 	if (!amdgpu_sriov_vf(adev)) {
-		ret = smu_set_driver_table_location(smu);
-		if (ret)
-			return ret;
-
 		/*
 		 * Copy pptable bo in the vram to smc with SMU MSGs such as
 		 * SetDriverDramAddr and TransferTableDram2Smu.
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
