Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDDAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F801613A2
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F801613A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 072976EA0F;
	Mon,  4 Oct 2021 14:46:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3956EA0F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeBF2MfnzCThNXtD700db/dtR/z4iX2azftNCd/QOn9wlTN3WpeABkSwuWGAzlf285OcFS2jOuI2Z419UtY4v1Ne5NQFa+uRXMweUrZ+ugAuovS/KttxzFwrRAtilLoG4BzsJvgEpVoDntAqiI47xctlhXlUJvria6BgLmJjCSqf2G9A8DDRbYZ3yjYv21f9QDyNu2pDgL2zulOoxyE8kozpMVPZ02cC6SnjXJCVGamLcUk7dhdhnutZ3MI6l47s7WdlvjNuQyyZV3cOnMf8UBQilMrlZmzWaufY8i0dr+YkwCbl1jz/XX/DqvXOn5sUdS6y371I0bPvOZ48qPoZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsF4kZJZzwQdIz7JEiFfOKAVBNgQs0TWqJ/snY46W08=;
 b=GMHJlpZDBV3Hav6t0E3FCwlZZO5u1Z6CfF7zNfL+bMRnxY24J+pDF6iKqHvHSDPlMCeIPsSbS7ecFuCC7/C3SToU5TRpN6AlukJL/iUNDir6tQcjQ/4U9QR2fWsIoWSpFwCwVW2JIsUX5KisnJCM65IXeyZcN1hXH8GaxFsjk+JOI4jKjdYqbo28Oz43Ff96r+zERvDK8rHVTfjA9QurojKOlav0anqP1WCqDKHSoMHmJXVkBRAWgF4buXzLMN7em180BOikyx00RM3iaYgSQ2Tq6pYVVo5K8JUbo/Kmo7PlbmEjkHj4e1mI8q/Q4Gb6jqJoR1cdVmCNot0WU/TCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsF4kZJZzwQdIz7JEiFfOKAVBNgQs0TWqJ/snY46W08=;
 b=WWdg44K485CudRQC7fZTXIgZO22beqa37sh1UkpYpR28Jz86YTiderKoJb7AWBa9mUQ4UHdVcJEtIvsvf8cOfl5NLoa1I0G7l14OFWmVzXQ2XJWbk0Rt2qjYv3VQLr6A0/f5MY4xjwgp0SpGik4X+jLk0I5G4sH+A6ZsYtzHqyo=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 14:46:19 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::2) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Mon, 4 Oct 2021 14:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:46:19 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:46:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 07:46:17 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:46:10 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jude Shih
 <shenshih@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 22/23] drm/amd/display: Fix USB4 Aux via DMUB terminate
 unexpectedly
Date: Mon, 4 Oct 2021 22:40:49 +0800
Message-ID: <20211004144050.3425351-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4092fc63-59dd-4c0b-c1f9-08d98745ba12
X-MS-TrafficTypeDiagnostic: BYAPR12MB2952:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29522AF4F47A225C025748A0FCAE9@BYAPR12MB2952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSwAvMFaDBolQrLCMTa4tGgBv+xaf/Ab0A4J5Rx9BazPraqKFW/tF8uzK7tEoiC3bBLcoKInoU6ud/a29hfokU+w6VdWDtP3OD1Xt1DMQsyditEOeuOR6yAXAwXv9ERqy8AWD7WumesPE2MNCncE1ZVibkZMXlr3rsu8tNLftnmwPF+MzmQpHU8c/44/la9XfeVRPjBQQzKWmevRjkwFcpG7CBglo53MzpZrqUWPihpBrYF3ZvsTkQo6KGNrN/zR/EuEtlEozAEK/3kURrLi3ZkMdLK8PP1PRZa192GERb3mOtQ5Wghw1FqzD2RATbEd05fiZfkDm+oMQAIdOyH0dgkWWhzxQDkQ0OZuDXakl787/okGHWBVeoMY1xk6Te/rnUZoCQok234uAkDqYDfn3OeiDXYgAuRwlGTlbln5tmENvVmaq4Htrjgcjn6nVeWK6TGQvMtT26g6l/6LivGDN9iaPehx9Q4gcaYfyP9yLUc9iBfwa5VUnmJ10d5fy46GuEJGWpzPmb7OquV22yYZwdF2TUO1Aoivm6uh41YbQtYYG+rwWu7yELrB1JemfDM1IT37r2u8AV+HcJMRWvol41B8cRVU24ZlVSeLRdxYx2LhSt5bbbO0RzrSNbbdq6kJTQ/BLLgoE9nIuPiatt/D0Vd96111NCV+vUEJryI85NOKhmcN54dGD1ai2md+gEI/kEccyLI35CYnxBHwKWqiNcYm0nHSnQ9vsknubkJYUdM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(8936002)(5660300002)(26005)(6666004)(186003)(2906002)(8676002)(4326008)(70206006)(6916009)(70586007)(2616005)(336012)(426003)(54906003)(83380400001)(316002)(1076003)(36756003)(47076005)(36860700001)(356005)(508600001)(82310400003)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:46:19.2401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4092fc63-59dd-4c0b-c1f9-08d98745ba12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
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

From: Jude Shih <shenshih@amd.com>

[Why]
Condition variable sometimes terminated unexpectedly

[How]
Use wait_for_completion_timeout to avoid unexpected termination of CV

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Jude Shih <shenshih@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cbf83a6e56b9..2962123b5f7e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11398,8 +11398,9 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context
 					(uint32_t *)operation_result);
 	}
 
-	ret = wait_for_completion_interruptible_timeout(&adev->dm.dmub_aux_transfer_done, 10*HZ);
+	ret = wait_for_completion_timeout(&adev->dm.dmub_aux_transfer_done, 10 * HZ);
 	if (ret == 0) {
+		DRM_ERROR("wait_for_completion_timeout timeout!");
 		return amdgpu_dm_set_dmub_async_sync_status(is_cmd_aux,
 				ctx, DMUB_ASYNC_TO_SYNC_ACCESS_TIMEOUT,
 				(uint32_t *)operation_result);
-- 
2.25.1

