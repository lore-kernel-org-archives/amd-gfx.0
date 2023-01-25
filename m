Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41914C27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 17:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA80410E7FA;
	Wed, 25 Jan 2023 17:16:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BBE10E37B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 17:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsz7nCCpnszeViMFxli+BYqYIOzZHT94BOKZvcv7V/gGW7RG9sqth60lHBNd76Ku+6Uf3I67qdoA1NCl6hj44uvqKelzgEqWuXTUvbOTN0fKaSTVIvHgeRAkuJtOjW+Sxjzu8gJd2Vj3CoN1uKZmQIDsNyiVYFtRHDkFEXy+Yly+Dk+s2EBQ84eT7crZvWPuoqFMU++sCPBP8kPVpfhESmysPLPXtT/mpLIslxQVOSFwYBmqu56V33bRzeD1Km1Ffavm+1nIVRrOftX6IafiuNdQRo3yANpBkLm/k7orIeNm5KBl3noheKY7F3pNEVqm1F/YfoE/jJQYfV4EkUWzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viXsyhYsUdw3z/N/92UUxgcUNqjHQWCKbDZm2UogAdA=;
 b=GqjWa67cyOzmS3pqdCYZwEDQDfs9WfaSl+QBpWdgsKnBpVgw4udRNIZd6/aqL+YwQ/YYnbbSXUk1BBFdWTaJEr+DGzjcQ7+Tu34gxAaeLFCdUGDOBRf49T+ryJefO6VWPay89tXVw0f7GysL8Df+DRD73ArUiQQgU7mN0c6MmzAUTwZZ/3SL7VaU29Qc/kKiWlXNp7Zekw+82JAEyIlNCONgJK9PJ7NgrxzB8IJsTOfrI4Mm9JstyOAIzEIA0Mtyw3guvakp5xxfy+FP2sbeFDE3eiCwP0BHuUHfgauY4lqODxZayJigCPTT3V+CCf6fbi/hbuos6r98le3mIxgfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viXsyhYsUdw3z/N/92UUxgcUNqjHQWCKbDZm2UogAdA=;
 b=J7afKUl2ZsWMX3WvPu2Nh9++BeAg4QlxwecQKD5yCQxT/tAkX9kEdc5pr3hUz2gA2t5yC3AhH+WLkoR7PpaKJkuEv0WjwiOMxGz7fgYbefTEdeerYzTwMizkUJZAq+NBwfaLUhvoU7l361vcZdIFGrctbOOozqQYeARF45UQOx8=
Received: from MW4PR03CA0252.namprd03.prod.outlook.com (2603:10b6:303:b4::17)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 17:16:34 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::90) by MW4PR03CA0252.outlook.office365.com
 (2603:10b6:303:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 17:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Wed, 25 Jan 2023 17:16:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 11:16:33 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 25 Jan 2023 11:16:33 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: always sending PSP messages LOAD_ASD and
 UNLOAD_TA
Date: Wed, 25 Jan 2023 12:16:29 -0500
Message-ID: <20230125171630.112605-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125171630.112605-1-vitaly.prosyak@amd.com>
References: <20230125171630.112605-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|DM4PR12MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b91fa47-5ba3-4079-6865-08dafef7e904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 327hPr44rL8U6zjb6Y5skrTsedJ1beDsXNghWIg6IPJDrTmKIVAkrcghIdnh4xJRRehZmWkTjDR7IqnSK5CvikhkWocxeKmJiOweX+CRZVO5snjxEwlNkHhkWbv0Miuht1PKL5RcR9toRESSBzGsMWudo0/Zl56u+led4SAmReQ5nz/a2EegMvgpUcy5wBt6kOk6YjqkffhroRPZcPRHEH5VB+E0TpB06gUFTOyw/ewQ52p+Ns3EopvZ6UVv9InylGhIhGIKwWaegmbC5yNztDtS+BPG9v9h4EJjSxzzptt28L+WD7tJCt5jZiz7FyKOwyqn1q/YVxhdb/ajK1vh7s3Y2Ar3l+OZk6PLmnZeKb74RBi8jFHc2I/F28jXHHbr4eW1VjPle+PckCv2KNQ9KzcCUR7sxCiWUx4YtIqOiii3Qu7xl+GYGuaK3L+VEkvYncuaCL4UWjar9q3i+lPWne/pF+Lh8v5Fe2Omn69BZK7fiETRySDqBA7Aai+lj8x75219an2hoc/rny+fdXHsUF4EqQZzu/P00R2fOThYWwgc/INyiCMECmFl6tFFjLI2DmULW7uUqBaXzqfijv94EDaXl4zCLmXineT8nm9EIhHHNdrC6MchTVx/0JGCRFtgTAaP/GftB44K732sFGr342TyjY1+3RRPJCNaujKTrcabt4IR1sGUXCzNmDE9PhUwYvq/3a/b72cA7rBkpk53QPyQwgcK8U4EMWCvXbwy7/A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(81166007)(36860700001)(36756003)(86362001)(5660300002)(40460700003)(4326008)(2906002)(1076003)(6666004)(83380400001)(26005)(110136005)(6636002)(7696005)(316002)(8936002)(41300700001)(186003)(40480700001)(15650500001)(82740400003)(356005)(478600001)(426003)(2616005)(336012)(47076005)(70586007)(8676002)(2876002)(70206006)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:16:34.4541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b91fa47-5ba3-4079-6865-08dafef7e904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

We allow sending PSP messages LOAD_ASD and UNLOAD_TA without
acquiring a lock in drm_dev_enter during driver unload
because we must call drm_dev_unplug as the beginning
of unload driver sequence.
Added WARNING if other PSP messages are sent without a lock.
After this commit, the following commands would work
 -sudo modprobe -r amdgpu
 -sudo modprobe amdgpu

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by Alex Deucher <alexander.deucher@amd.com>
Change-Id: I57f65fe820e2f7055f8065cd18c63fe6ff3ab694
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a8391f269cd0..40929f34447c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -606,12 +606,21 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int timeout = 20000;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
+	bool dev_entered;
 
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
-		return 0;
+	dev_entered = drm_dev_enter(adev_to_drm(psp->adev), &idx);
+	/*
+	 * We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring
+	 * a lock in drm_dev_enter during driver unload because we must call
+	 * drm_dev_unplug as the beginning  of unload driver sequence . It is very
+	 * crucial that userspace can't access device instances anymore.
+	 */
+	if (!dev_entered)
+		WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
+			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
@@ -676,7 +685,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 exit:
-	drm_dev_exit(idx);
+	if (dev_entered)
+		drm_dev_exit(idx);
 	return ret;
 }
 
-- 
2.25.1

