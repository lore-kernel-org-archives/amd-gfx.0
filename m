Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DD9C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 18:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B5F10E254;
	Thu, 14 Dec 2023 18:39:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2294410E254
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 18:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kkz90nVoutE/fN6Z90zStM7pRYR7xsdWWFSsJuGgEkci3WPNbYo2pqxt/+CrAgURKJwRYsdjy3CY9ouJt3cNEyxgCxBKwJCMFLpoCNhrKI8eFruR0KyTfX8wDUWgKo7jENDnge6mULwRCjpHrpvkX0lGVtsRfGXWSRwUtAj/DPN4OTNn29HWObq+apldHNH9fwoilnrV5hT8DFkjE86U4vo+fwsp/QofO33glpbcE97QP8/5pGbmfIyP3uoQW+qgFXIKceWX+nz1BBd3KIUo8yY2b+dsxCbirAhQzOJU/l/iZcKdfhWKrPEVpqsb6iQC4BtU+M0aRyv7NfnLPEccUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MQ7n2TAHFLgFvWVbrvCSxuk7TXRDcLjYOv7MRcMEIM=;
 b=ISTBgcQk4CG6A4K/IltBuBesQ6dQn4Si4E6/R4AI73mqHH+s8VZEPYDuSwKbQN0O8IlZ/BY5uUh+HtULrOqcse6vX/Ml2EIxlpNUbhiIWMWLQ+aa9uOCi8mYdKl655LFSj0jJ+HLnP/ATiIRrbdnRM6sipg6zqWNImqnaRWBptetsC+7n61ADbmq1tG06eqvJuvqkFD48Dxvh1q6Tg/Si71Ku4Kyeo6SfAKbghJaTdTGJe9GzHnIBX50ccqaXh9vgnKpnfxVCgjyBbZRbgQhcSRHtglZksn7OcP0/MyE668o4XiXDjVngky6ePj+6qTpG3muSJShAnPBm9J8YNUfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MQ7n2TAHFLgFvWVbrvCSxuk7TXRDcLjYOv7MRcMEIM=;
 b=fasZwoV1D7SHtPvC9d3Wdd+y+3w0kgqTLrzLgPjmIvZuBtCrfm8Y5eWgMfBhZe/akGhrrtOvTmix4vjX0wwF90t+GSeleLdiPi9iGFMHkK++XIBTbJPDgcAyaAjp4AcGAkZDK1KSm91Q+DKsLeNPdQF6Cp1qIMu5H7dH1QjgS8A=
Received: from BYAPR07CA0038.namprd07.prod.outlook.com (2603:10b6:a03:60::15)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Thu, 14 Dec
 2023 18:38:57 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::3e) by BYAPR07CA0038.outlook.office365.com
 (2603:10b6:a03:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 18:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 18:38:57 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 12:38:55 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix NULL ptr for debugger mes flush on non-mes
 asics
Date: Thu, 14 Dec 2023 13:38:39 -0500
Message-ID: <20231214183839.129977-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 39986df1-d977-4c19-e00f-08dbfcd3ee8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKNr4Hy9Y4M1TkIMeS2dwo8M+bML/XEj+atlWuVSzIwWWFcGxJLNf777kzEurXlfnRSx05DhTQm5fmb/fOYGcNTMqEeqfE5B/y89Kd1wd6YyL6wdeEIDKfQKr9MK7mqUIULtXABAsWCvEojFfpodfvF1EdDctMoF+g0MCyl3UxqxeKug0OOei/1ENeJX1ggejn7cDy/ViQunGsQypmVLGYoVxoR9DwvjgO6M2TRzMRU5bCOqD+ShPkILEyrj2pjx6rvGW1IDlP/DzzXNa0+yxCUmHCr9f90XKCp33dztblhypJUBeHO2VG7OLR3IqkTos8A3TJHYUcK02kqHqpfbhtoQaIJm/BDZ/HRok1gJiNI6Cl/s3boDjxN1Uis9e4W0BNR2UhLovofxudmcOnNwJ11XlelNRmHe4qDZHymZkxIXI9TtX1BZZHQ8ociJ6hsHLhWl36oK3CD7pSXCqdrTTHxVxmGQGqCuK4pi6RqzgwmcukTtIDLkr8CSIXF0/vcZ426+Pko2n+kRhbwSX/sMZCLsROMVjq49WJdoip9aDy/qbBlvAeqfJpWGDBJqmd2iya1gz4CEgrkRVqQapDTSuDX7ozNPQBED+pxf0/Ek3LtnDgs0LM+AF3NZ0aZaJy0CQpesF5ebWLEmDtSVFvpKFtFWvX10o0DZekVqee6eru01k0SnFhK+cyDzvkHymALJB9RtD+LyxiUN9QS+/xgjWcy2IwSXFVUFHKaYvDA6mwjw1MFoeXXXcdv+MfdNGALGv8jdxJzckSf817HD796LIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(36860700001)(5660300002)(47076005)(16526019)(2616005)(26005)(336012)(36756003)(86362001)(4744005)(70586007)(6916009)(40480700001)(82740400003)(70206006)(41300700001)(83380400001)(426003)(2906002)(81166007)(478600001)(356005)(7696005)(8936002)(4326008)(8676002)(316002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 18:38:57.1847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39986df1-d977-4c19-e00f-08dbfcd3ee8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The field adev->mes.funcs is NULL in function amdgpu_mes_flush_shader_debugger
on non-mes asics, add mes enabling check for call this func to
resolve the error.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 8e55e78fce4e..43eff221eae5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -87,7 +87,8 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
-	amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
+	if (dev->kfd->shared_resources.enable_mes)
+		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
 	pdd->already_dequeued = true;
 }
 
-- 
2.34.1

