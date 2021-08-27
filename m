Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC2C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 10:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107B060FDA
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 10:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 107B060FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE486E027;
	Fri, 27 Aug 2021 10:56:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED32E6E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 10:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giZTqwBIlToZuW0aQ3lRks+EgI4M0fuF8pg9RstxJXC2PEQsonN/oszn+t7xSkc2WZJIeH24DG3YO1kFZKXKPEaQ3gXHv2o5HBJJi2FFAvpMh6u8n9aRZvYNkR7QSLwZWSYJJOjJ0b5TtAUcHHYETfEQmx0CdEduwH0qM0L9roV0VtOEw9G0Fm8N/Iw9OKMKDLdeCahyTE6thhiGrj9RNkiPk63KGebzoTmwIUQg/7oyD13qowSWBtpdtWz9Q8eTTIMVhHupmPe1jfP4Zw5CLfo548feW1aa3qpuQ2/P5PFPymBooACR+iA8M/ClwZjq14NltdJ15qg4QcG47VBUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qipczX3u7h8AJlToGIbTHFQ+W5SLiadp7rZmdUIO1Yk=;
 b=Og/T1I4i9NmSDIe8wSxK38X5wvsoXp6Z+t/392Dyy8ENgrNTWAK74VD2azd6DRN7fGIubYKw4K0yQvfYOGeTcgp8hJUCH2YJ3KzdJtiBuABSxEt2IyeN/36CFVzWG/OhAkTaQ6BquI7VmVeGRNVW9v2C8Q9/HawjkqPg7xUXLJBDawo4peRHG1HyQ6BHvkzRE8EWQzMOMG89hpRl9o9l2tB3hKVNmO1H2k+Jidxt07fTr8HYNprnKdJ1DcrXQJy/4tW6wCyKyu3HhCTEgr76XxPCvLVj6CHU2gvenQ3/2zrJ9it8z/JJsl39BdV3O68R6vKj2/1NUfsfaoI68xaE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qipczX3u7h8AJlToGIbTHFQ+W5SLiadp7rZmdUIO1Yk=;
 b=06g5za/eCZsfgrfE37U22+Iu82XELPt/pu8Lf+kSyMh/Sav5TfHOadk69jNtV5nPhjUEBca2Fk9b5oi3VNEABCRQkLYytFVsRvBRtCEFnYSjxORb6Rn9VPCrqQfAT2Gh4TFxBXBBU5Z+IguYHvmc736ykcMujDNGCWLhZ49GLq8=
Received: from MWHPR22CA0072.namprd22.prod.outlook.com (2603:10b6:300:12a::34)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 10:40:55 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::ad) by MWHPR22CA0072.outlook.office365.com
 (2603:10b6:300:12a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Fri, 27 Aug 2021 10:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 10:40:55 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 05:40:52 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <christian.koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <mike@fireburn.co.uk>, <alexander.deucher@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: stop scheduler when calling hw_fini
Date: Fri, 27 Aug 2021 18:40:38 +0800
Message-ID: <20210827104038.4945-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcd27be7-942d-4f01-29fa-08d969472629
X-MS-TrafficTypeDiagnostic: BN9PR12MB5131:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5131910A965954AF52674CFBF1C89@BN9PR12MB5131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JNgAmYHaMVMLOjSE+H16m1b2KJuxcjDdyND9o//JJVLROATqpGTggHAqHV+XVmAyv2eQIB9GmtdiFd8DlJJT0Ec2vctan0SCf+9AWUN3f04n++xTdii4Wv6AQCeWYxZKweu+7e0NQ1SU8aMe7g4hxjJA/1pzOK29vojeUA/LMnL1DJlDL+C89bHyDnOaOZtnbEs7hKFDdS4kVz9u58SR0ZE/1iI4WZS2SMcCEqJUlwA4fREiFxbcUQaTjDQeIl7okX5NsXwFiHAERdCnLQeuKq3Ee6JG/XJ7qRrWV3fU/liY/W6N9RIp+c/uhz7McFXBLpgUKlJ7SPXBETS8Fp4zFhJC14FJajG4kmRt/WFQr8W4adLkiznbkVoV42cRe5VAqxI27r8QTtKizzB97SkOsRrg+/2gBjpW7viZ2AA86bTA6n6W0LXsZONO64IywaTt/BI3BY69ZJjR6c729A3n11xTcrQO8nEcMtyffMDiO7KdkHrEh1CPiHTEBIPiGj0V+y9KuAjV7EJxODhHKgVJHM9TalrCj5d7TCaxUbANUtOEsdmC9ZVa3DgGnbj8kxmvI5Be2kSQMNz7WbWBKt6u5TjA+4TuC3dIE9GUPUm3mTFImG2GhamjEEDkh14+Yz6tvx5CYqQbW4+xBkmyRnmaHnsEkPH8RODCCphxFww1w06xXGJNplz8NaGlprt1ws04p9Q9/ZgTsDuEpGrR4Nr+Hqso7xtFoTSiUnBF41HE4MI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(36840700001)(81166007)(6636002)(316002)(110136005)(86362001)(1076003)(336012)(2906002)(426003)(356005)(478600001)(82740400003)(7696005)(47076005)(4326008)(70586007)(5660300002)(83380400001)(16526019)(70206006)(186003)(8676002)(8936002)(36756003)(44832011)(82310400003)(66574015)(6666004)(26005)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 10:40:55.1883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd27be7-942d-4f01-29fa-08d969472629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This gurantees no more work on the ring can be submitted
to hardware in suspend/resume case, otherwise the ring will
not be empty before suspend.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index b439eb7d4177..d6e429e63604 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -552,6 +552,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
+		if (!ring->no_scheduler)
+			drm_sched_stop(&ring->sched, NULL);
+
 		/* You can't wait for HW to signal if it's gone */
 		if (!drm_dev_is_unplugged(&adev->ddev))
 			r = amdgpu_fence_wait_empty(ring);
@@ -611,6 +614,9 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
+		if (!ring->no_scheduler)
+			drm_sched_start(&ring->sched, false);
+
 		/* enable the interrupt */
 		if (ring->fence_drv.irq_src)
 			amdgpu_irq_get(adev, ring->fence_drv.irq_src,
-- 
2.17.1

