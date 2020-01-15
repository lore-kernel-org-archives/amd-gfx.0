Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D5C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 04:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E26214AF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 04:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FAYEYX4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E26214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D19B6E844;
	Wed, 15 Jan 2020 04:21:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4CC6E844
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 04:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAsiTPRNeE1HFnQt7PsZr0UD9Qlz2Tq6DrZDZ+4i5sn4Ufx+CwaPjWNU6r0CLdoWou2n/KIuXQp6YRsbqZLVe4oFZm/IE4hGO5oZBHGxrdBxGFDagEN7/UqWYNK3GYiTN9Ze3aHfXLzvfr5LlyCA0/wJVzGx7WcyGCnZ/CabSkmzrzeSvJuzWwvna5vm4l9rpeL8bnLIM64AXWIlPhej2j2zGtuzhMh9KHCnXemmm1qEXiQ7PLjEOmVc96iJwS2PsD3CRB/wWi6ioL32f51/UHffvPkEYSG/JshdlJ3rnHnL83lbC8wqDHtiln0vF9IKpHbAAfsp0/Em78ZYEpWknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W23ZsZ5hTZwm0OV80AEXjS+WNaVDNIc4aSHTGX16Ffw=;
 b=CIHUz7QfhcKyvzQnwC1q9mViSerLvH+scUoeAfHf71whRuiihFqQ7ZpdcDfwR7sAzP6HgR9rNSZoUt+MSDwmceoEBbFicpgmZOfHEggIyOGNeU2RPo0kBDJnwFqYzp2hH/Dpayn9QfvvssVfdMRYUP7Zxdf3SOCF+SB4i1YTq4GQJUmJLtvRlDo7UIbO/A9qGqY2mkdIDQm2WnBCKhhogbJohsyLgjspFDOWnZzCJJ4bfYvd/xmWwz4ziWr1vVKZuPbXb+3k8tlXlTSK6jREORzlSu44i1b8Qw0WeSWqpE1Of/O6rTSMfImKvfQpVgGSYguSiumK7/FgHlE1IVzOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W23ZsZ5hTZwm0OV80AEXjS+WNaVDNIc4aSHTGX16Ffw=;
 b=FAYEYX4ZsmCSpXhhkEjSdyfUoMyfSzkAbYHMmrqYSKTHb3exsv2/tFndvdprtW3ye8ruBiu3nuKyFmAlxmlfFDenHXHgD9+h2Az8q+hftyjlFLXrNxpMZuf0rkkL3z62qw4fJFxizPx0cVsjJ5iciqa5cj4x+87N4mmdFqWu9I4=
Received: from CY4PR1201CA0017.namprd12.prod.outlook.com
 (2603:10b6:910:16::27) by BYAPR12MB2967.namprd12.prod.outlook.com
 (2603:10b6:a03:d5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Wed, 15 Jan
 2020 04:21:22 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by CY4PR1201CA0017.outlook.office365.com
 (2603:10b6:910:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Wed, 15 Jan 2020 04:21:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 04:21:22 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 22:21:21 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 22:21:19 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.chen@amd.com>, "John
 Clements" <John.Clements@amd.com>
Subject: [PATCH] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Date: Wed, 15 Jan 2020 12:21:16 +0800
Message-ID: <20200115042116.7408-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(428003)(189003)(199004)(6666004)(356004)(186003)(81156014)(81166006)(8676002)(26005)(8936002)(2906002)(36756003)(2616005)(426003)(336012)(70586007)(70206006)(478600001)(4326008)(5660300002)(1076003)(6636002)(7696005)(316002)(110136005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2967; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fcad5fd-e323-46da-b42a-08d7997260a1
X-MS-TrafficTypeDiagnostic: BYAPR12MB2967:
X-Microsoft-Antispam-PRVS: <BYAPR12MB29671EE16DC822D07B08E9DDFC370@BYAPR12MB2967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02830F0362
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moonQk3oBiSPCNCwadXA9IVVE2cIy2KeJrk8jPPEfviMB4fT6YA1GdD8QRRxkVn18KJIbU5qkA6GjOCJi6tgu/Ga2FIW7nrZ4OCcrbMsDDx22OKcdZh0INScqnI9+rlLCwv65ePw775WsBy1PdyeAvwkvc/Rx26m0rlCHYq4WSeyL5Ke4acYtVwf8nv/10/pawR6VcLyetk8Igsj/XIA+dH0BcBsnBzUYScaQfRfyDXws1IOLcQBZxrCmW290ohVum6CObNh1x8OdqjPDkuM2t5E4B0SBepMsMIgzd52HjYWY5DkdW6MtMfFSvXwjoOfl6+XcHZDWPcX3NElk8z2ggwJzrOXIbIiHHcQDaOZNH/IitOqnlkph+dzexRmNuieIB3gcBfamKxzcRQzUcQJW+btmpBzCclcMu/vc2uVcS02lpOmwxfth0B2j+o0fyjF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 04:21:22.1895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcad5fd-e323-46da-b42a-08d7997260a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2967
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow the flexibilty for user to disable gpu recovery
in RAS recovery path by module parameter amdgpu_gpu_recovery

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 706a30e81fcc..8e2f0a380461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3799,6 +3799,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_VEGA10:
 		case CHIP_VEGA12:
 		case CHIP_RAVEN:
+		case CHIP_ARCTURUS:
 			break;
 		default:
 			goto disabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac9926b3f9fe..492b3ba685cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1356,7 +1356,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_ras *ras =
 		container_of(work, struct amdgpu_ras, recovery_work);
 
-	amdgpu_device_gpu_recover(ras->adev, 0);
+	if (amdgpu_device_should_recover_gpu(ras->adev))
+		amdgpu_device_gpu_recover(ras->adev, 0);
 	atomic_set(&ras->in_recovery, 0);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
