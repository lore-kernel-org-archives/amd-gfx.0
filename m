Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A5C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2622320752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U9URUFo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2622320752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBA56E983;
	Wed, 18 Mar 2020 22:52:24 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FC56E97F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 22:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro6jfh0EIweP68YQ9OxBliGhTL0dSsJ3aHuRNlQVnlWG1nqGyPknva3sfnVt/UB8ZXC0q56G9o+QXTEqNisZmfJhLFSUtdpUFsvRZKkq8VWCJRMxbjHr1rd9AGpVDIToEBmmPl4hwexzitAMCKgpohDBQRoJ7p43VNPdjzSjA7x0F1h1Pm6ro7wyLXKkTpRq4fDLiknjdU9CxqYeYvXEI6nsY3K5oALLLZa5KWwudMPB4bN39RxhnxfesYsKwAqPDTK9pBuXaL822tYAwd+GXK3VDiEM+n9pdy+N7diEqQWcWGENpawFTDwQT4tO0YwfIYvK7jGEcJg7oYp4W+K8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9juZrGbtrpFgN4gETSgsl1ZqeRe9JPOJMvFfJY7TnNI=;
 b=fn2jSBGzGSff6kZg7G/FTwVOx31oxYI2lQN5jEj4L+bkM0M3LtivbvaVzBN/o8qcDnBSHONLQeuCZVwncPUpblI8sOTO5TaSGBBrDbWjTCfNZpLtJtcpC9pX09Zil1LYos2mOYXJr/sYTGiNJkR2ZhlaWSqOq/qLUkWUmozf2wdpOtOAY+DPAbyOckUUKt1m5KkGQyjqLBa2mg1/obz3mOfd5uxdxPSmN52tStTTjVL7UncjE6VsJV6NppqM9BqV0IaUavtrz1lSCim08yFb0OjuOom8AcYGQyv3Fjka7syX5hFRUOawbIMpU6J4Ab1sTHFj0VInzpoVUSxWHdJxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9juZrGbtrpFgN4gETSgsl1ZqeRe9JPOJMvFfJY7TnNI=;
 b=U9URUFo3FUppQ4dSU74icRE4zK+dRFQBlBXhHbBJ4dpQDKDKmJ46r+IO65wwu9y902FzU6CTr6nIfCYS18XXxg48D7xRTww2BXu5ODcFyavJGc5ZFxsHIQ8C5kceHd+T9W9jcj1Km5gbH7jAEOAQ0wVUOltX4YdtjAqAgQjHJts=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 22:52:22 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 22:52:22 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: remove Arcturus references from vega10 ih
Date: Wed, 18 Mar 2020 17:51:16 -0500
Message-Id: <20200318225118.10756-6-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318225118.10756-1-alex.sierra@amd.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend
 Transport; Wed, 18 Mar 2020 22:52:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dd13589-06d6-44d2-fbe0-08d7cb8f0510
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:|SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4415AE721137565F1839B5CDFDF70@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(66476007)(66556008)(6486002)(81166006)(8676002)(44832011)(316002)(81156014)(956004)(2616005)(16526019)(26005)(186003)(8936002)(52116002)(86362001)(7696005)(66946007)(478600001)(2906002)(4744005)(6916009)(1076003)(4326008)(6666004)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4415;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bbUxwCKlH+SCMmK24tjg1bnFbjF2acAxHgHgQTEcWeHIiNDfARNAcaiFmC1OnUqxskiTMDz9Rw25fImZUEdIC1dlFb99mDZPTyxazVGVfpfKR9+t6KVtBBPUqffRtmvx+0PcoCQfHfQmB9h1gxEuJYpuKRr6lK9Sbo9Ub385NI33qeGoEAaNuzg5PRyzsyBYJKKQSeqkCxjYtYOLvlTstszRykExbUCVnpEx1CzAYlUDmkxdu8LoPemp/7KVORzIs4gQ3VrbEwwhfaAtKdYm2n3TzxKeKFpBgPWncyDD1FXSfW7TIweERY9fugKGVOv0qiU4u10b4PWl9ukJe5G1mXOMf18No+2cnnT1Z6bprwhA6HCXxoocP/MzqZCZdvo/H4QFh4JtjmFWHlhypRd4cl3GLWBFn8JwQJWaXC74SCyuZFYaZeOZdvAdEEVMFvn
X-MS-Exchange-AntiSpam-MessageData: wtgcMHTjD4oTYbJ9JvyWOlBF4bijf1/8r3muB6lBAkH8CIIG359hysW9109VoTKF/jS020YXy7A7bYZg9fVTYVvTzxeHQ6CD0b3FA1e3JCVCQWB4OCYaZyJ45M4oAZFweGEAgo1hqQW98fp3Vj7p6A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd13589-06d6-44d2-fbe0-08d7cb8f0510
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 22:52:22.3458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeHq5lo/hhoDB2SS22xtPmx1xHLeMiGr04HOwrLHjkrx+/NX1Oh6L2iIAYRdfAJ7lt2pl/dmKviImufWLKWFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Arcturus has its own ih implementation. There's no need to support
this on vega10 ih anymore.

Change-Id: I29c843e0b12a458d2915129503c0ad852bcebc48
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 407c6093c2ec..608e8da9b962 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -246,9 +246,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
 
-	if ((adev->asic_type == CHIP_ARCTURUS &&
-	     adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
-	    adev->asic_type == CHIP_RENOIR) {
+	if (adev->asic_type == CHIP_RENOIR) {
 		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
 		if (adev->irq.ih.use_bus_addr) {
 			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
