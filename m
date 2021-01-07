Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CEDC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 10:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42ECA2312F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 10:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42ECA2312F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66566E429;
	Thu,  7 Jan 2021 10:47:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FE56E28B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 10:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNEiKGrJfy3PE/rePvI6rSOCoQsmvb0wViDYsiaFgMVHPUcu6fZXdveGzyRhJvDok4Qk9cZKUzpM7jMkkS4ERPZ5O4uRFc6GCAsAW2W4Hqqs0Zk88PVfivlIskxHI8II0qPpHe+iTnXzhSAvRCU1z1ZyZ3eldK6zfzImoNdCnLXaFmT6kPhAuAj/yJbh7dtv7IDo7JvQJpR7B5yAj+/7WAkQVw6eJ1MGdLUYIndcxe6iAYyu6nPWMnXBs1X/sKO42mIbPhk2zHvSr08EAd5lML3CtqTJpeh1Il8H4lQPa1DAHAzyS7z4ls87oEmj1UH9m5jiq05d5vJafw6Emplzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0ENDa3OXgfBNwa7GQJk8HJ49OCj/w9K/IDdKdPpQTk=;
 b=aP1fCuWCTyBwllzFH+LzmTMP2Ze4GrV15aryReGODVFkX+TmpapvXXlb+0s8m/9DM0VE5MuVCSbYwZJ9tIvzOgZYw/WUTXP9Oq35edJhXGaBXSQfu79KjJp+nNsOiI+c2/lNvl5ZDgpkjxUNxNa1EB4H6dXdlXSCd6YxsLMY79P/4HbOM/87PuzM/vM+pXd/fBHH2jxP7pxyceVjXjA+I3wlVG3uGWuY4sFBI09WidAYDH2sUMqZ/RRAT1djXva9bD+zY3nIFaQc1S8QBm1J0yp+S+J6gmrMgawsQgH0qdLX5K8GObYGBt80mD0PYSPg5owFxW9Kf8gE9MCwAfagpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0ENDa3OXgfBNwa7GQJk8HJ49OCj/w9K/IDdKdPpQTk=;
 b=mBEpBUKgmGVlx773aulTOM7r0xlxzRFp3ntTGUepZHPU+exHKHU/kbifjqloWS/w8b43oB9ggdoJ2VCa8JcgZqyGcPhZ1XPemTecFuAb4K+n8SLiIDW0Q9hAUTtv6OZqXv7sruRd0YD0GK7FowVcvdAAT/3WwTi9zeCt1yLk+8Y=
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 10:47:04 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::75) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 7 Jan 2021 10:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 10:47:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 7 Jan 2021
 04:47:00 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 7 Jan 2021
 04:47:00 -0600
Received: from ubuntuBBNew.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 7 Jan 2021 04:46:59 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset
Date: Thu, 7 Jan 2021 18:46:56 +0800
Message-ID: <20210107104656.24107-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d652bd36-c5bd-4908-40fd-08d8b2f990a0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4397:
X-Microsoft-Antispam-PRVS: <SA0PR12MB43975D5D3352F98CFE649A88BBAF0@SA0PR12MB4397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpuCSbS4zXtJ8hsOBiIavzapq259Zzo4DsAZhbNvpQ/BOf8VrQSyTCg+eJ133QQeuUuDN/eQb+sLy2U6mVnGDCt4sQoaZ+nuHpVdfiYrxLs774pXe69cKSvsw1SstKQ3ebTmBFM97f95XcXUPEV/+nL1JDPH9WQggPsdc+HznQp/n/1NfgGlykR1M/UV30l3+66CzUzKMaG4eqUjk7ucJDqChdUJ7uz5D+3rQWB47WzP8HJRFJB0Sf0BHcTGthO9eoPJq1w4zDpgofADeWK5P6t2AOAXfgjspBXn7b7wxgzYv8v4rywLdkowq0k5WBpHOT5oi+wQlkGaw7zniMWzyhf8MK2silSO5+bTqbrchfUpVKUbITx6KSwlGkY4HCFgMFV45zS5F9J1Y59NSxiqtzi1cmw1CMv6rMqxQwSQb5wy6NkUmY3mGKWfXVyFsc6LD5NEFVp4CtSD67gdZDDO738Zt/Z8zJpTyv1XMwWZKKCcDBBUm1HDBz35jxoE0Wck
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(2616005)(82310400003)(8936002)(426003)(6666004)(8676002)(186003)(86362001)(7696005)(47076005)(2906002)(336012)(54906003)(356005)(83380400001)(81166007)(316002)(82740400003)(478600001)(4326008)(1076003)(6916009)(26005)(5660300002)(70206006)(34020700004)(70586007)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 10:47:01.4268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d652bd36-c5bd-4908-40fd-08d8b2f990a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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
Cc: jazha@amd.com, Jack Zhang <Jack.Zhang1@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
When host trigger a whole gpu reset, guest will keep
waiting till host finish reset. But there's a work
queue in guest exchanging data between vf&pf which need
to access frame buffer. During whole gpu reset, frame
buffer is not accessable, and this causes the call trace.

[How]
After vf get reset notification from pf, stop data exchange.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 83ca5cbffe2c..3e212862cf5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -571,6 +571,7 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 		DRM_INFO("clean up the vf2pf work item\n");
 		flush_delayed_work(&adev->virt.vf2pf_work);
 		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+		adev->virt.vf2pf_update_interval_ms = 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 7767ccca526b..3ee481557fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -255,6 +255,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	if (!down_read_trylock(&adev->reset_sem))
 		return;
 
+	amdgpu_virt_fini_data_exchange(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
 
 	do {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index dd5c1e6ce009..48e588d3c409 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -276,6 +276,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	if (!down_read_trylock(&adev->reset_sem))
 		return;
 
+	amdgpu_virt_fini_data_exchange(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
 
 	do {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
