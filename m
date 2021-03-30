Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC58AC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05FD61957
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05FD61957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736C26E51A;
	Tue, 30 Mar 2021 04:42:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475B96E51A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTT0/poRfF35Kl73OD35iyRlu23XA7rFUULi3qzaWXBlsEv3ET0J0pITBbHkPR5AlQqiQMqJwMcS/q+Ook0HaLRdtDPuuHZU4ndWoJ7zR/oHBhQyDibN9+orubdD0x/1i9I4fvIR4f7WmYpJIvDmIYwLkxR/KJt1C+4cSEJMkQ/ykNAmHAWjyOd1LRaQIdEmv9loumW4u2WLsIHf3y/z4Ky2136ezjy6jLk5iunp8r9wnVaurhccSQbGIqPoeiUTqyjeMLGIKT5d8IhOiIHZnW6I2t103+17oyBSc6Tg6JEL7AEb1wwPwONU0xWvs5KEXfK7R9ByH7Hiz/u+zCgI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AsOl43f9EiKbFASYZpDRqXClYFkrhtTEoL1XzvFlhM=;
 b=c21JVmtpP1yDKrvloZh5Bw7VtWkTqYxj46CFQ8IwIbhPxXQzppUj9TlPObxzb8XZOFP/qAjCFX3/ushZAsOH1Enx+k059i7VlmFPLpGCewIslQr6Y2btx+kIx10DImGJO5D4RYm+EcIEFmiPQa+xoqMdhw69jcCdpQY/YlteNiiG35uPCttxRY45puoW9hiAAkDpjlki8kr9dJjCgnBcAc3H2dEpVXZ6YVN8oflC0r5e1Q9pvoOwZSVcMXhosDWPGW4VZ+m6KbKJge/Hf4oAM0t+I0r8ezu7Bg9ndkcRqDBkdr/frrHlJUiZ53ZFxShdzG0No08brxa83MLAYQnDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AsOl43f9EiKbFASYZpDRqXClYFkrhtTEoL1XzvFlhM=;
 b=P4w9HaWe+9sJygNOUwv+xEyZr0Xudlal3Whak4eK6akberKtybJ5rhw1Muni1tlAaFar4R0+UHA40RvjnGMMxzJOyyh0eSoY28aY+Vp0odo0/CgRrKhpWHEoMolleNsNrhEA4x8n1noQo2W0oF3AfD7N5d8dxUksxbZV0wJRsT0=
Received: from DM5PR04CA0064.namprd04.prod.outlook.com (2603:10b6:3:ef::26) by
 MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 04:42:08 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::62) by DM5PR04CA0064.outlook.office365.com
 (2603:10b6:3:ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 30 Mar 2021 04:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 04:42:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 23:42:07 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 23:42:06 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Date: Tue, 30 Mar 2021 12:41:47 +0800
Message-ID: <20210330044147.57802-6-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330044147.57802-1-Emily.Deng@amd.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae540531-874b-4983-8edd-08d8f3362cb9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32936DB84D2198CCD0B745DC8F7D9@MN2PR12MB3293.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaEwnvnudr2eUBtAgYhYJO4ofDK6QyT+Ra+5lFFGZG8CmiRot1PcklCLFWOcHUVSB8YDyX/md5VeOxVBI16LQxO3raAVNCTIwRRiqnTCOwkufz7Usotc6DDfy/dXWAfiDbuEP+wO/tKwui6nbnWLtnjFAu3ta5lVIKb6XaxMOhb56fkE8kicA1ne/lK23FMF0AcqY+OjD3VLKJuw9/MP3FYlpHu0YJvrWI15MziXvu2JIy6nt546StGZEzQ9MgeZZDG1NqqeHRZGs29tIxjxlZRNM8jUsu+02qx8N6ae+8K1ZqajfHuMeyFyjVXsdbLNi26GHHFSzrg1cNdQNNkSo6RgNqzuQfR5vp/Cwcl7El310sQqkF/IRZWBBTa4wg1SidQGLJz5OZArTygg5vwuK5hVQQsszSQVgnNnJp/rmB8ItlQXzeEnRFqTKueAUo+3IqXstf7iiCqhTi2cZ91mxJxwMN4PIEsm+zuMdCKO2+Trv9INdaWSmsxrEF0nG/oHfDV+jK9yILtLkTvUmtEMJ/cluM4U3DDouSc3HGCeUnxN/y1YTx44fh1mLhSMU9cmH8ruCXxK8623weYByXd9h+ufe9mYAw1dmKD3WiUhCWA0pBYrZgLYbfDqaqkmWuZFYOie4VV2p3HbjUQWRRQchwMNHcVOMQpIdH7qPDhHueyGolkQIoCS30GWbue4z3OB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(7696005)(336012)(316002)(70206006)(82310400003)(47076005)(70586007)(82740400003)(1076003)(478600001)(4744005)(6666004)(36756003)(8676002)(5660300002)(81166007)(6916009)(26005)(4326008)(2906002)(8936002)(186003)(36860700001)(86362001)(426003)(2616005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 04:42:07.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae540531-874b-4983-8edd-08d8f3362cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During driver unloading, don't need to copy mem, or it will introduce
some call trace, such as when sa_manager is freed, it will introduce warn
call trace in amdgpu_sa_bo_new.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e00263bcc88b..f0546a489e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -317,6 +317,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	struct dma_fence *fence = NULL;
 	int r = 0;
 
+	if (adev->shutdown)
+		return 0;
+
 	if (!adev->mman.buffer_funcs_enabled) {
 		DRM_ERROR("Trying to move memory with ring turned off.\n");
 		return -EINVAL;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
