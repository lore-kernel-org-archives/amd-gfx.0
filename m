Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ABAC43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFBC20719
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="meq3bGE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFBC20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A59136E3F4;
	Mon, 14 Sep 2020 08:10:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD9989FF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 08:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmdB+Z2vlHhzl/hMzB52i+JatpWJEZSIg6r77z/cr7o298HjYNfyt73JNhEBn0p4hr7fNuE4lBnPmz9K4uOqGTEMBz8CmMH7+dgaifdvs61PUjGq+aNbBNoco1MciR4WoU1jKsgbBwOCsol+3NTIX6lSlPZLBFNjoXmgYf/mTfJjWinBmoGKolfVKsuYxV9gKtvYksdp0EP0938Cy8ZSuylCeyxl6zgtQ21OXaEfEOs2r4Zo5EhBwauH8gWkD90j0yDcHF5TLYmU8hO632/OHP7PCTz7cRogxqFH2VbJESb6AV6jw4mqO4p6fx7wsGttDXnRAVbu1MwaS8u4pUH6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7GMJAVajVe/o6ydQZpUN50YN1iLpLj9B1vRSW1JVwQ=;
 b=mmGpOsz4iNSNg2MiwkLvWVdyN4lTiL+jLeQAenquHuBethxo4fjkR+LQ+NXz4nTKPDsjJLyVvQmtNOEznbfFgn7udDH9Ufi1WQ2GG66pwyQ8iiHZv6vp7wniqIXl86pfNRY39rbKIVa/SCQV741kRZ2gKCxnRT1PIoK05f0L5iDuiNHvjATRE3K3d8Ic06LfvTeWgmHPyWaR9QAeuObAsd/eVJZ4+bN+OK2HbHYYvOK+2i9Jk845SpfWn0hmar1GMa3IKC62duLhk/QiX0Eri1sqMKk3yl7XFRl0x8+AdmBPASzrqlHdfXbDIfTD/P/iv8Xp2X172Jr+LY0fKCaCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7GMJAVajVe/o6ydQZpUN50YN1iLpLj9B1vRSW1JVwQ=;
 b=meq3bGE7zbCDmriKDCXcjbvuRF8bjlD7qBVWmC0lpeU+NNhGc/sc4Thvdq1mxpqVxwo9xBL3XLPzip+yZsEJXtzZ7xEyY/k97fnF9KxsLsAPdUv7pc6GxmZo7S4+5gz6kyB9vymANX/OFO1b1uSzAE6aEIZJCK+pSeHVKVFQbU8=
Received: from DM5PR15CA0031.namprd15.prod.outlook.com (2603:10b6:4:4b::17) by
 BN8PR12MB2881.namprd12.prod.outlook.com (2603:10b6:408:9d::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Mon, 14 Sep 2020 08:10:14 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::a7) by DM5PR15CA0031.outlook.office365.com
 (2603:10b6:4:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 08:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 08:10:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Sep
 2020 03:10:12 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 14 Sep
 2020 03:10:11 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 14 Sep 2020 03:10:10 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: support runtime pptable update for sienna_cichlid
 etc.
Date: Mon, 14 Sep 2020 16:10:01 +0800
Message-ID: <20200914081001.3932-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95c368f1-99bc-4e07-1e53-08d858859b9a
X-MS-TrafficTypeDiagnostic: BN8PR12MB2881:
X-Microsoft-Antispam-PRVS: <BN8PR12MB288193E9FD0BB7C2EFA854C5EA230@BN8PR12MB2881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qg4qN/jFem2zw+vbJorVg//S5KvIOUzg9hjF3MSTirh1fVBMuFMIo7j3CzBfH6AskADt4wBd8UlJlUF4C0GM4mZWX1NjnYgzLncgyulBLWM50BnSq/B0kAf5zIqzi/lAhjzdm+Z9Hgbgp6B1XFYGQxFJX6feKNBIHIFCz8r83T2qU/idc559I+d+ViG+dgdw7QYvQvBTwt4A+XwdqDg5gsD459KRa+OFUuholMRNtbnwNtKScVA66O3NoV0NUpKA6N9jwT6LcqfxWMACJ3lhBmr4b4utb12/OSxr277KqoGNlZzokciVsBa1AhV7sGokcgRG474u6/Juh/UboquI+Bd0mA8ZjkniguJYm2OL0Xs26V7B9VqCkKE5yA/05pQBcmXexz4ISKjg2dqbwJn5oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966005)(478600001)(426003)(15650500001)(186003)(6666004)(70206006)(5660300002)(70586007)(26005)(336012)(4326008)(82310400003)(54906003)(83380400001)(8936002)(2616005)(82740400003)(47076004)(1076003)(86362001)(81166007)(316002)(6916009)(36756003)(356005)(7696005)(8676002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 08:10:13.6549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c368f1-99bc-4e07-1e53-08d858859b9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2881
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
Cc: tao.zhou1@amd.com, kenneth.feng@amd.com, evan.quan@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This avoids smu issue when enabling runtime pptable update for
sienna_cichlid and so on. Runtime pptable udpate is needed for test
and debug purpose.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I70b704ab4d6efd169f579c392e5dbc2737dc1fb2
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7a55ece1f124..7618f9972b8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1129,7 +1129,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_NAVI12))
+	    (adev->asic_type <= CHIP_NAVY_FLOUNDER))
 		return 0;
 
 	/*
@@ -1214,7 +1214,9 @@ static int smu_hw_fini(void *handle)
 int smu_reset(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
+	int ret;
+
+	amdgpu_gfx_off_ctrl(smu->adev, false);
 
 	ret = smu_hw_fini(adev);
 	if (ret)
@@ -1225,8 +1227,12 @@ int smu_reset(struct smu_context *smu)
 		return ret;
 
 	ret = smu_late_init(adev);
+	if (ret)
+		return ret;
 
-	return ret;
+	amdgpu_gfx_off_ctrl(smu->adev, true);
+
+	return 0;
 }
 
 static int smu_suspend(void *handle)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
