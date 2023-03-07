Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDC3C678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 07:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B6710E087;
	Tue,  7 Mar 2023 07:03:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4850010E087
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 07:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCPfoKoNQVfrpAwe3uMgRi2jD15cjojYZON+mj1Kzf1NUIB+Qp+0yVo0jeUfP6Dlgp1sCS/5DC3QEp2r7aZ+fG3YRxG3LKctXlQDFurIANBQjudCIxXeCC4IaBzTmHdIFyCIPpUPFHaW5OlFI1nbO9huCqBHAMvt+7jfEiDzKQfiGSZl+RObj+GUoZFzeYqXdozy20wdf+jWo17dIDbUKnABdB6ot/B4sn6DjcbJyPaR4PeuQcMSIl+pspmVRu427a+PUra19o5ZZ8QfeYtA9F7+lXgTnPYzWedjlPObeLRqtavAdKuY9d7sfN1nIgF9guHn4GxvrnXJWTTo3fa8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69I7m9Wg3MdLCRSuO5POHAjKDLa2D6Chk1qvt938KJY=;
 b=mH+q2ESnhT6r7cqVLbDrHH0krRw5XWekg7ZFyDTK9pYj+1eVOMbbYw1FfPDAt/lgdueZuz7ctpLDQmtzeOSSr6Cqibt4Fp5VdwLe0e/eDfllbj5t6AR3YmonHcfdVemj//2aXqYN5BrMbGz4g3Qk/4K3V5uxTuVgX2iAcITdygzcZJDZxqviLXEe/SNOD0rtaQhzeI0vYCnnAuAGwtVVp9CJuXqgPAWIwJ46DtAHNHlI4N5BJtMzOzvUxH/nOJuosE+L80TynP31zK4BgI8QR0Wg974yjFf05lnoIT3r6NVBq1NdS8BkzUVHHumaU7doD1riG6NkP/apHU29GB+w7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69I7m9Wg3MdLCRSuO5POHAjKDLa2D6Chk1qvt938KJY=;
 b=j7DQyA6LAiPfMNpJxUIi0ccUzWN6F+CKMYBh+HxWbIZBKeHjJKK3JsaevyslzhL1DU2pWlS5/ddUDubwGFRUBYf1OZs39/Bl+UdT8k9xFMA+3uHCbJrZ/V9dRw+nVdQtOST4dbAV4MVWtU8/tLCRElwq0tJFuKsAuiJW0c+7Uvc=
Received: from BN9PR03CA0528.namprd03.prod.outlook.com (2603:10b6:408:131::23)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 07:02:57 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::59) by BN9PR03CA0528.outlook.office365.com
 (2603:10b6:408:131::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 07:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 07:02:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 01:02:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 23:02:56 -0800
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Mar 2023 01:02:54 -0600
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
Date: Tue, 7 Mar 2023 15:02:31 +0800
Message-ID: <20230307070231.3807549-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b14d90-10c7-4487-8252-08db1ed9fb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pY6KpLtgh2XhNmIec6nSCeMnHIgsxVX2H+6aggPdxjnRdjAiYIhuBZO1nf8A5a3F3Yk9kCgiuTCA4r324iOHRd7+cnr23CLlUrfm1QDL/aUPHkkRQAnl2iAngfe01Tk191zh9Rw/Zr6P/Vby2FTezzRSTFlzxJ1ib1gzilcRkKDk4H4wP4yX3RINStKOIWiSQlr70sD+Pu+3JiuRSamj3jPf9nvYWFLziuEVA3NIYTYZbtGjlAn3L11bcMBMuJI+zQp9sr4CT4QhAMvjPNSw/0wtGuTJ06DXKuacqab5k1bJOlApT2HLIWsWUCYloKKj4XzhD0QeR8jHWKZob/WGX+y3QGkKZOALVlwt6T57D9IL0FJ5cJLmGWw0KtrC9Wa2bheRhardwWyrbpOqZGweNoVsDoE0P0UB0CYC0pONrQ83r6O7yRwldpfXeE87ogpTGpKKuSJbjRTOzpZltNEQT6xUaSHG2cbvzvPpHKl9lEgwVlsKzPbG7UoAz0dc1nMxnWtzHlnCeiK7xS4+5O3/cLNDeaxE3g8dWlxt3mmvcFEcuXygsvkECDG8Y3EeEDfhBWENE2YcAvoKk753mVYDPvUZCZD82982yCA0l6hXh7O+StwtG/4E+Pu2lvCM1liSHGQxtYT3m0PTabGvEKVyPavj/zsmmGqCMkjpGSW9tnPK5AD7swp0cTZ4w/Vv9pzzoyIE6KsFYbTgZ7Ra4m+IZR60J/kwtT8hzH3At3QZep8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(4326008)(36756003)(70206006)(70586007)(6916009)(41300700001)(40480700001)(8676002)(8936002)(1076003)(2906002)(5660300002)(82740400003)(81166007)(356005)(36860700001)(86362001)(7696005)(6666004)(316002)(54906003)(478600001)(47076005)(82310400005)(40460700003)(426003)(336012)(186003)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 07:02:57.3847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b14d90-10c7-4487-8252-08db1ed9fb34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
For engines not supporting soft reset, i.e. VCN, there will be a failed
ib test before mode 1 reset during asic reset. The fences in this case
are never signaled and next time when we try to free the sa_bo, kernel
will hang.

[How]
During pre_asic_reset, driver will clear job fences and afterwards the
fences' refcount will be reduced to 1. For drm_sched_jobs it will be
released in job_free_cb, and for non-sched jobs like ib_test, it's meant
to be released in sa_bo_free but only when the fences are signaled. So
we have to force signal the non_sched bad job's fence during
pre_asic_reset or the clear is not complete.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index faff4a3f96e6..2e549bd50990 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -673,6 +673,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 {
 	int i;
 	struct dma_fence *old, **ptr;
+	struct amdgpu_job *job;
 
 	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
 		ptr = &ring->fence_drv.fences[i];
@@ -680,6 +681,9 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 		if (old && old->ops == &amdgpu_job_fence_ops) {
 			RCU_INIT_POINTER(*ptr, NULL);
 			dma_fence_put(old);
+			job = container_of(old, struct amdgpu_job, hw_fence);
+			if (!job->base.s_fence && !dma_fence_is_signaled(old))
+				dma_fence_signal(old);
 		}
 	}
 }
-- 
2.25.1

