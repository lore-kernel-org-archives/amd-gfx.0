Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178F0C11F66
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 02:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21AC61468
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 02:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21AC61468
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAE66E12B;
	Thu,  1 Jul 2021 02:23:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0AAE6E12B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 02:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFHO2cnCmczGzJTZJDdHQwcRK9dANVmYdKNuQ8GfZ836F5EczGWAVOLL30CLYsl9vhhLrx7aYxkV9eR3ehNMgDnSlSdNYSHbqrYOA6L7wfTcSnEeIh9adlA+ouU8+1e3P52Q0m72Rfy7MlR4egyC19Z1aDcZFHDATXkb9C4oqnKKAgpOMoo0PaZfmn+nd0BezMXmhHN4JpVYDNV1J9XoiBUiOBasZNS5CC/wbc5Lc3ogWQPbvtTKqqsszGJoKT+IPcXAyNKVoajFXAswoRMg5Pr+sjXjaGJr6/78F6IQ2Iuz0m89DMF3T4OlbsK2pSIoqySyqjMw+QOnK32bR22lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioofc/YKo0jh0wLwSgH1ZG6qwevmMHiljw/iaTYgd84=;
 b=LzZyTUm2jKfDm5fpMIm955cgVgw60s/AbA1OVYY8S9mKPORUDAn55MNTKz81I8V2DMNW0pvNQbSk1NoPNzVKhYWjpq3MGNHAhqCSoY9RC/khgoXWENMLpYKOJzH9TdU7GBoMNYnzPMeaqG16MYOEae/lOPKiq8RCgCCLvlIl5uQULLTNTHdM2VQRF5XOgJsglEhqmGLjMfTxnwLfHLKTF9fyj0LHYU0Qd0hKspSmzElKJTOK+oTHmN0dObk0SdnisCumt7lC6TF0QgCgOzwjM6idTccBmXWdqTRNco38eCpRfgNvGmpPB9qg4BlyMPvCbKHbEwH7Y+7xHnbBoC56PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioofc/YKo0jh0wLwSgH1ZG6qwevmMHiljw/iaTYgd84=;
 b=edkCSOsFofC2lkjmWIxmMIDS+NvhvZ4jrkMFb4u+qG2IO4XxnDRZn2QI2bfftFomx4Irt8076RgTiUh+izSw1dw4ftlxPXjYwnfrXDq+2Z3gNbKa5gRvROCs9MaXgp5jbdPmGi7jmKPqcFl2mL9+SdOlZx2xx5nAD0D5IYuq5PM=
Received: from DM5PR07CA0125.namprd07.prod.outlook.com (2603:10b6:3:13e::15)
 by CY4PR12MB1304.namprd12.prod.outlook.com (2603:10b6:903:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 1 Jul
 2021 02:23:13 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::95) by DM5PR07CA0125.outlook.office365.com
 (2603:10b6:3:13e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Thu, 1 Jul 2021 02:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 02:23:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 21:23:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 21:23:11 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 30 Jun 2021 21:23:10 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: SRIOV flr_work should take write_lock
Date: Thu, 1 Jul 2021 10:22:57 +0800
Message-ID: <20210701022256.763468-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168cedc4-9f71-4369-dfb1-08d93c372ced
X-MS-TrafficTypeDiagnostic: CY4PR12MB1304:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1304EE1782DDB6A9387D5154B7009@CY4PR12MB1304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3h3V+ovii/af3sOq1RgMP40f9Zbe9FOUFQzOB18MGd6Fw4T8sSnGaAilB+LRB4KVWGObzpu9k/OQNTU97pnW/sPQy+47ewshL6pTIKDHOakQ8yT6dmMoUQ+GZoh/gEWKkVR7GP5TX9ahy1ucLKziH9zahpJwedPu6czFthMcpBbNaJZ3cZYvINCJDS0M1udIogR8m6T5BllBNVJtBVUg3pHediu7WHLEapEvKiQrtOcsmFVY70bNHZN84HpI4niMqvIW73+eZEcfHDIxpuouLbm8xOlJcwQnhqjGw6w+KQVG5gRAGJzN20aifUcr5KnnRdwbIKv5q9BDre/lGuEY+dvR5kVZI039XsZWSdNvqbb2p3SHFIjcNbkl/KGQMcKzLl6Ygix0YJo6DkAPKYDo6BhbA5rivuGARaKuR71TeEbHC7NzwbIfdufwTAuTvaa03geouhmZspGB8LnCLKGlUVrPdhYDy6Hw6EuCX9eMA5o+IVh4yHHFjifbdvDdml9ETfnyWfDRLeyR2IoJnNQhGQpXNwd/Gg0+DEmBJsrqc/BjfzHXvogk/kbtyoVD39CLGUGq/x/44H5Ex5jEizZAMWLECQFjVdCRwK2l1d82fSENKcI6YtOG2wlKwgfcse+3KA0XlkbnAlIvcoAuASppHMZ/37djIPuoBYgUJxDCF3QJBHCfjfqHHg2bY6KMwEwtGApRxTTu2AVGsK3/bK0yOGTOc5s+3VkS4HrkmkTTHo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(82740400003)(2906002)(47076005)(356005)(81166007)(70586007)(26005)(83380400001)(70206006)(6666004)(8936002)(7696005)(186003)(1076003)(63350400001)(6916009)(426003)(36756003)(63370400001)(336012)(316002)(54906003)(4326008)(2616005)(478600001)(5660300002)(82310400003)(36860700001)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 02:23:12.3201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168cedc4-9f71-4369-dfb1-08d93c372ced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1304
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
Cc: horace.chen@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
If flr_work takes read_lock, then other threads who takes
read_lock can access hardware when host is doing vf flr.

[How]
flr_work should take write_lock to avoid this case.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 3ee481557fc9..ff2307d7ee0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -252,7 +252,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (!down_read_trylock(&adev->reset_sem))
+	if (!down_write_trylock(&adev->reset_sem))
 		return;
 
 	amdgpu_virt_fini_data_exchange(adev);
@@ -268,7 +268,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 
 flr_done:
 	atomic_set(&adev->in_gpu_reset, 0);
-	up_read(&adev->reset_sem);
+	up_write(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 48e588d3c409..9f7aac435d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -273,7 +273,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (!down_read_trylock(&adev->reset_sem))
+	if (!down_write_trylock(&adev->reset_sem))
 		return;
 
 	amdgpu_virt_fini_data_exchange(adev);
@@ -289,7 +289,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 
 flr_done:
 	atomic_set(&adev->in_gpu_reset, 0);
-	up_read(&adev->reset_sem);
+	up_write(&adev->reset_sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
