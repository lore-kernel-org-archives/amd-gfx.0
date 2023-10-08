Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68730E95A67
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Oct 2023 10:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7330710E067;
	Sun,  8 Oct 2023 10:06:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E9F10E067
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Oct 2023 10:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzFVhrdcdF5/FZvTczDqkH7gZBybZ+DDH0+BUoIZyKXAKn5ELO65xaRYUuo7tC9mCcO9v8GXSJYt+Gjjc4qSm2ttgqXks2s+XnqDAMoLBOyvQfz2P1sORp+/1ouT8+STqq63Ce8sOUXXH0uOy2lUHXEk2gknbdj7DDK2ZC+aKw+I3IWIpQNGk1yy5VUHtDJsiXDeMuzv3YZ5+ioHblbevQ2Lbegj7fplgysjtZTSu2jurit+aH0mXnkwUtRsUYYMv/QktpR4wH/uecnMyi640zfDjXObX/a884RCbLlaZCV9k24QwebLLv/M7e4CncSA3n43BlW7nq9XJFB9H1STWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZgl5W0TPo53ejOBuHQsjLHXf9WxpEEBPbAV93ePqgs=;
 b=XO6f+OaKrMZiJlULXy9xGW99Zwx3iV0/jQ4hapJfDCzGTKcBvATCDAXKxOYweqkrKhmedAnPJazFw7pZLCCGQKfe2iXrmT+2xDDZzDXKsQu8+hDDG5JZosLwHoMYSA11OU799934f1GShBksuKYBunaD30+49SLYnH18aWbWrXgsfDac09GZ2pHXGgcUHMImV8WgWaOahRBKZdLw6QevK44tWi3yGXfap5fSxB8mIoMwKSJU6usQLGWXtJjAUmUeGKgJFepHLqfRsB8TpfMqE56bgSVtHvVO3qLTsfwrk8n1Ci8eNsdYlA2faRO67GRbobpVrE2LQoerNuTyzeF2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZgl5W0TPo53ejOBuHQsjLHXf9WxpEEBPbAV93ePqgs=;
 b=l2nuZVGhGzhVYvOHZtKFX4h28tbjkaPev5Rv5Raw4AtJ2l5XQ+4km6oR/x13v5PpZ1u1zt6NZcQxs7Ezrz0rPGqb6/dpYCkz8Q6k+p+JzlxZzTy3oNRqltvvKVX5wB+wQmPLeCRVETJ4uoijP6T8+LpV5/Inva+l5gy25nsE4Fs=
Received: from DS7PR03CA0040.namprd03.prod.outlook.com (2603:10b6:5:3b5::15)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 10:06:46 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::c5) by DS7PR03CA0040.outlook.office365.com
 (2603:10b6:5:3b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Sun, 8 Oct 2023 10:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sun, 8 Oct 2023 10:06:45 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 05:06:43 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Return -EINVAL when MMSCH init status incorrect
Date: Sun, 8 Oct 2023 18:06:27 +0800
Message-ID: <20231008100627.111795-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eff63c7-e8e0-4bb7-7808-08dbc7e6477a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Khq5bor9EYsUU2yx9t/kn9kOQhGcSu52zLIvFFTm7FO87pw/hjzNImrcSO7b5TLh+1FRrckApBqo01OMNYwXiOLC74wm7di2nWtf6x/0S1nTGzQgvcKGJpQE9wVB7oal8uxXLz7BV1lqFP3PtdXcuzL6P2yxul001ZvI5H4DSRXn4KvssbRq4rz5KrY6jLe3zqO/tHmTDoqXhlvhGuUc2aVzGCOsvBmWjGyB7zx9JAe755h84nIh0ngStYN/obJaRFqQ6FnjNuyxUt0La6BgiH8vvyM3mcLZ5MnIgI5GrOANYgAItllUGu2C1wMW0YqzYiOKX1GPwzAZAnO8UsWGqyK+pw+i9GkDeZX3Nwc7DI6UkMs+5ydTAs6Sqz6QOA5Tf/IZmnC1jkuoZGWm1I1hyrC5fcwZpi7apCHoX5KeNxtKsvPjDZKgvRxciwa0ntmGkmWFPfVu/UG1IATNY3JeoHdfESRtrks3LrNTgV39p6gBe2C9V71mcyFR4CDYnhy3OWqAZ64gXM/393taye7Q7jH0UpbPwz0fZfxckxA6lnQcVhxJVy3+mvVl3uBHIzJWH3XIXJECqNADkOZHQxEb6WwkrYvHXBw4dHG2obc29QGbv/V8bqfEkw8PfTLSGay+GgX7CVEpIAtka90MriUieMy1hLmjd/NqPTmYP8Ytsl0wkh2BsiITZqJJ2G3SdecIJLlHNXIOwRxA1YW0TkglXoQj8RZt5NRFhpeKiz3x4/vtMsKHgdVqYTqdnh3b3mW1d+AK5pywOLgVidH6gJMrkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(83380400001)(1076003)(2616005)(336012)(426003)(26005)(16526019)(47076005)(316002)(36860700001)(54906003)(70206006)(70586007)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(7696005)(6666004)(2906002)(82740400003)(4744005)(478600001)(36756003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:06:45.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eff63c7-e8e0-4bb7-7808-08dbc7e6477a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
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
Cc: zhenguo.yin@amd.com, jingwen.chen2@amd.com, lincao12@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 jane.jian@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return -EINVAL when MMSCH init fail which can be handle by function
amdgpu_device_reset_sriov correctly.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index ac614b869aaf..a3768aefb6b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -518,8 +518,11 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
 			return -EBUSY;
 		}
 	}
-	if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE && init_status != MMSCH_VF_ENGINE_STATUS__PASS)
+	if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
+			&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
 		DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n", resp, init_status);
+		return -EINVAL;
+	}
 
 	return 0;
 
-- 
2.25.1

