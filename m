Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C9C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 09:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8022087C
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 09:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vePrDH8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8022087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530F46EB2A;
	Wed,  9 Sep 2020 09:32:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A3A6EB26
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 09:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZJbz6DBlPbroEUjBfyC4cRBRcVyfdvuTUq0hcAC0faqqTr3shjmBxLjPyOi3mm4b3RfgMvUbV1bEbpE6XgkRaWW66jgQniaXv9WPQ3SJruehx93PwETojU45TIcsTuxQVi1rfY+x8+GezPIFbBeObFFWFOWnWaAIYMRu3t8tkI4pDApYc6s4YL/cp+cxSBC8Vfcj/txI5wBWKFm3g93D1TJbB0RH4OA+K7+RAaW7JBCmoceEqaw0P/KDmNwSgE4bck0kXkrB+SrfeMLkALbA8D38mmtYQd09YIKi/pxzOkxqPxE+Jj/9IA/EioHHrEjduDeNeKJoCfnmFVcWjkpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnVU+ITkr/KJD74tGtSkOmXnLn+UjowHX/WOVN+ALmc=;
 b=oLheYE+L1UjaO+069hCoF9qSuYOojo4zlYeZCj0MSGPM1GzcWa2MCH3YBxxHNEGm5twvYo4DM9IS96uf6eDy0lvjBoMUA7dqXZOCcU/7fc3fN5YqK5olG2VHxTQtv7DF4ih/okXBaDEGLdiZ36uonbs4EXgfXdZYeH74tBHjErSFsUMnf69daaJ4U6MRuE16Mfqk2K5GfS2OhxwApx698yOB8VglWc7Y/kWY/5PYDWnEvOzyuaqtSXQlJPBDUDJoMUt4Vzaa0LGB3alwU4Onp2O0qed8Cc1ZlRgG/wcSa8YMtuuejgRoL/1ZqAnXbVSVR3DVPNppXVtekvbk8TwJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnVU+ITkr/KJD74tGtSkOmXnLn+UjowHX/WOVN+ALmc=;
 b=vePrDH8r6NQBOwDiExmQ0tcG4LQAAzS8WghUkG8+yPZQMoUoge3C/fWqv0mRGbLzvPJ6JVzCkUOybAvNts3MEvyuoNTye3Ko9zDMVQPsIgXosp4DhiCBhnCi3NcVIuXeQbeQusMtvuAuoWGVP4u9KMIOY3gm8Ls+dyhapTBjswU=
Received: from DM5PR04CA0055.namprd04.prod.outlook.com (2603:10b6:3:ef::17) by
 DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 9 Sep 2020 09:32:15 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::c4) by DM5PR04CA0055.outlook.office365.com
 (2603:10b6:3:ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 09:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 09:32:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 04:32:14 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 04:32:14 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 9 Sep 2020 04:32:12 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Do gpu recovery when no job is running
Date: Wed, 9 Sep 2020 17:32:09 +0800
Message-ID: <20200909093209.804708-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15c483ae-e358-4b99-1c1b-08d854a33d29
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0009CC433D3185228CDEEADD93260@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hI/m9S6YlNPlYb31A9V8FjxC5l66fXIf9Boi1rZ4yjbcJfoNFedOE8a4kcanQ8Q4wjQZTovsLXeYsJ50E3QtUTrzRy6RX6HbaNlosaETqCSqrAmyE8nmDc3HG/9j5bSHpAlwFz9wYU2XQ9vcnQkcQwnsAhIoKLhfnvwMY65N/cMsdyxnKHF/TYg3Tf4lt/vm82R8dUlbI0bBjnLhyUGb8UGm8c7CJxqYKt98rm9X+nYKY2BXKG1r0KoygcTRt+JJGlm8n/Rgi9f5ZcJaE2kft9M7Z1qDOKJ2IcWjRuVuqctqUNb7Q3o/IMBUF/sw9nnH59YpdWmOWYprlbePmA4WS8ZeShX89CaKE2JkV4duLisqimZs1hCK6fk8pppYyZPXTlHKIUwcKNaeshHVwpoFdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966005)(81166007)(7696005)(83380400001)(47076004)(86362001)(2616005)(70586007)(186003)(426003)(8936002)(70206006)(336012)(82310400003)(26005)(478600001)(4326008)(2906002)(8676002)(356005)(82740400003)(316002)(6666004)(36756003)(5660300002)(54906003)(6916009)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 09:32:15.4592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c483ae-e358-4b99-1c1b-08d854a33d29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In function flr_work, we should do gpu recovery when no job
is running. Fix the logic by inverting it.

v2: modify the description

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 9c07014d9bd6..f5ce9a9f4cf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -262,7 +262,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-		&& (amdgpu_device_has_job_running(adev) || adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
+		&& (!amdgpu_device_has_job_running(adev) ||
+		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 9c23abf9b140..666ed99cc14b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -283,7 +283,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-		&& (amdgpu_device_has_job_running(adev) ||
+		&& (!amdgpu_device_has_job_running(adev) ||
 		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
