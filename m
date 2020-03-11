Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B949C10F25
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 06:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D439321655
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 06:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HxysnYMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D439321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C2B6E41A;
	Wed, 11 Mar 2020 06:37:43 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F85C6E41A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 06:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMnzXxKzViCYE/1o7PWbaJZtHcMuhYfhG7AZ3eUjKrLw+jAE3HJFL9uObjG897HGaEqA+U9CoPWXv8jBfQ6f3XXhCAn0VmN2jpxcxh7QHnYOJFXGVp1EmbezaUWU7UqTxThXqL/+f4QbeouvwANY0zOGCZpxU7Xeo1TyCP3G3MNF9CzZCUj/yAk8T+Mdn39CfznUCAXq4BLCwCo/JMd1oocgDvs4SH/IYPNWXq79CshrdgG9J6+ajgVZvdW9ab8X3XEuruXkyk8Mm4jAqSq3fciDiJjaUDCaZMmnPCf2+ljZlooShUf8uCIpOBDnteqtYhCKdQz4+ZkPwbVDAL9quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pyeyeb/ndeJStHHrXmNY/FJR7R9m7Mp3/oISd9fTOpo=;
 b=MdgSA5vqmE//uqTwtT6AhgP5rfJd9giBMthVj7lIO84lC4iDgrRtmOn1c6iAzax+7Nr8L2D7FeiGwYydIWc/Y7Gdh4JTANyuhge58loICvDPipHLAcS/OjELKTI6VBq7GAuTAnq9qpz+fh0Is6CRNpDjbDCcVb//7fZhj/cNSd4/KFUN1YLaP8GIkoygFTgxobuRPYTMD6eAbWHwFq8u9xgzkjwiTbLDPNcZY2hqb566oovjd5TR1pie1qjE6Z9wiJyTtJmheDeVxjTMJsz0EnJpHre6hu+dXjuZt63TPWhf07yL0cXYRkMdZ5CvBGoH0Pjel9Y+vbjs3dEAr6zdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pyeyeb/ndeJStHHrXmNY/FJR7R9m7Mp3/oISd9fTOpo=;
 b=HxysnYMRI1tvA0fhOJUfupiAidB+GFgNSeoxHljYsXu7D6dxyZiRWVNHQU4yW3LhU5KcPd8TfWfNOWorwlAX6yFizJrYevV+XwEeZ8bDQhykWIIdvX5MF4ZvcE8Ij291GxSP/e3ZV/1S5OzfRC1cWqxNGjM5PRaLIB+NxaiAtVI=
Received: from MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12)
 by MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 06:37:39 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:237:cafe::82) by MN2PR15CA0043.outlook.office365.com
 (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Wed, 11 Mar 2020 06:37:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 11 Mar 2020 06:37:39 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Mar
 2020 01:37:38 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 11 Mar 2020 01:37:37 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use amdgpu_ras.h in amdgpu_debugfs.c
Date: Wed, 11 Mar 2020 14:37:30 +0800
Message-ID: <20200311063730.4156-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(428003)(199004)(336012)(426003)(6666004)(5660300002)(356004)(2616005)(7696005)(478600001)(1076003)(86362001)(186003)(2906002)(8936002)(54906003)(36756003)(6916009)(26005)(81156014)(8676002)(81166006)(70206006)(4326008)(316002)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3485; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 837e0e26-fb56-48ae-9bbc-08d7c586b1af
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:
X-Microsoft-Antispam-PRVS: <MN2PR12MB34852D571EE08CB0FDA3D58D9AFC0@MN2PR12MB3485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:164;
X-Forefront-PRVS: 0339F89554
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IidQIvSOP8qcU55dzDXPG8zPUunoomAAo/YoF9Q+6BjzC6IhKEMqe1f6XKjPSIhsbEAKKlosLiG4I6guOz/wxNFHxa7zzOJHX+JeLoqvYWTwlWs2SMe3Eb4kidMhJ6AYg0z1tOJVc9jGzVcoturkECK/ducx0Jh1+s4niHiD+Io22VcLO8FFRzbXwdCQxnwoaYf8TImn3scGfG2Nmkh8NC467OCHrDgvYCNUjxA7tOD9hZVZJYGU0bNCDjiPofzHuppNKWCDEC/bqr9GvklkNQIUKO9J9LWC2Vaw9OkT/qIoeXN52DrqFGtAmCqvezCmUsIO4SeoBKTj/OqWlqcFSrkMTfivpWnCd+iBApEtpuiWwL4eG6aNaoijrpGrezfvS3cwhf4Hrzp8H5FWmjXIgU7K7HYKPWdsqIPLB4+24sZGw3W1njSL/O2Jq1VRnoFE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 06:37:39.3150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837e0e26-fb56-48ae-9bbc-08d7c586b1af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3485
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>, john.clements@amd.com,
 Dennis.Li@amd.com, Guchun.Chen@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

include amdgpu_ras.h head file instead of use extern
ras_debugfs_create_all function

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I2697250ba67d4deac4371fea05efb68a976f7e5a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 1d513e4f9934..a9a278f87498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -34,6 +34,7 @@
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dm_debugfs.h"
+#include "amdgpu_ras.h"
 
 /**
  * amdgpu_debugfs_add_files - Add simple debugfs entries
@@ -1315,7 +1316,6 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
-extern void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	int r, i;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
