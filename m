Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAF7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 19:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8040310E1CE;
	Tue, 22 Mar 2022 19:23:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2780310E1CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 19:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3VQEpJxz9SOCcknkiT4T7ffg16PkgxXykiPwibmvXZuFvDuf8O2Wg9Bp9iRJGDe8FA+fUcqRHOmvBLNcPK4fPm8LCUNUESb2gMljbFCRDdf+10Yrhi6ntQTwadm6wNVL9QncjeRqyYXvYYZWnUOtGYAzwo8/VUBFMuuhNGy1VJgi0Y9FzlO/PtifYg+fgoHsnw4Vl0h/w5WIkGNXKrQWBjxPLAG8Fw0XDqoU6MB6RoX2twsdcmvffJb//ybEglKoiNoBEiyesxGy6Q6qRfrOLlG2snomsRkM93JitZFZ/jd9M1nABsrAoRQ58z/e74mKkZ9tS/pHGN0/hRVrDFtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Sg1ka9/re/3O7zR6fu77Pgkqj+3Bh128c+B1oR4ifc=;
 b=NlVMpfT2C+nIeGX1S61UraU6uvhlnXdIpyoZnUnpm85GwD1qV2h4SKb/IMJOlikRla3FlhDPUJh8ffSIN7lhALNyOz2D+8gSmJQbC8Yvx3bjdg2vJXEfgdeJSLLsAIpWIlDfvAF2aYg0wVayw7NVT/boHBQb0UxJ7jl3IipA4Nbypg6R/fU1efSE9dysM3KRfwfNmRBkqkVBwp87mUl/zUMTGYq2hON5kR5NavRnhUtAZr0uIGugY4CwuecBCbU5t/6TCVgOmejopId/a/vwXUnbdeMQIpTr1ZsAgYYcZRou5t5Sy5uN1E3aAQuHCjWTsLfDb3H/AhNblv47HwlfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sg1ka9/re/3O7zR6fu77Pgkqj+3Bh128c+B1oR4ifc=;
 b=TjYrJkOGeq+VddZOQKl47buhNYS2uzxj9xb3T2Diwy27AEAM4zfwhNKBdk86UIw1voK7B1WqHJYAnJHTBEZQagt3a6uhN8rHLsMDo16TRrOMaaFzTL41BirGEs5tnSwfNxKWr5IMRwZ8uBuRJNnajmoWmItV1hmwESGpJcN4I4U=
Received: from DM6PR02CA0064.namprd02.prod.outlook.com (2603:10b6:5:177::41)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Tue, 22 Mar
 2022 19:23:50 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::b0) by DM6PR02CA0064.outlook.office365.com
 (2603:10b6:5:177::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Tue, 22 Mar 2022 19:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 19:23:50 +0000
Received: from dishikre-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 14:23:49 -0500
From: Divya Shikre <DivyaUday.Shikre@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd:Check use_xgmi_p2p before reporting hive_id
Date: Tue, 22 Mar 2022 15:23:26 -0400
Message-ID: <20220322192326.1716698-1-DivyaUday.Shikre@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dccef6e1-4e46-4d09-208c-08da0c397ea6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4374:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4374B371483A44251727B95697179@MN2PR12MB4374.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3ebHPmfnHkXYV5uCJdRXN73eJ2RbNGC0OPMw0TfymCQMk3nkebuX/StUlZ1k/DfaQfgFXGXqGVkqjSpf1MT/13GMx1q5gg5FH7zjG/EY28OOyKMKmBCDPF5Y9P5EPfL314LPNJIpMoT++2Hz5/4DlhGE2gApfRfBTgQ+nKj/mHiZdXVRinxbFZIrrJP743eSVQvfJVWBuV1hC6MoCAYn0RJBfy4caaRGOj/qFxR8jzi8DDW41z/SEHk/6xKxm+gbEJMItIwHxFJrxBNK5tBf07fZya/yzzBsg088sPthD8nDbOAUz+h+qUXl7bGKW99XylRlWkNLSaLZPwmzPsZHxGrqLj9d+kKYAQexiuNtCoCnPEyNARUvL9ucOryUCqGciSPI2UJV01d9m0UWmjnvgIUGRixYAjlSwPfumd5g2pYhFWsxqy/cEmF4f0n8jqlSVAmCsS2+eKHIzd/zfnEC89Z19toXonIk0c0WpFGGNmtbu7O2ZtW5NoFpH4EGzkZOL5LsnTNDlPDdKLGVfhpogk+mkk0MH44sjzf3OHPwJbEJ5cy2YFv2HYnFZ7BQwNLsA8H0kQfVnBGyvBbOr48oVzQaLJl3L+QPzGK+ktUWO1DoR+GVz/QnhnAAQCoj+o/RG3u/l8qRXu1aljzf+weYu5/JHuVXYIQB+hWug5yfn9AP54AzYIAz1fZ7vicHUj4QGW5o2c6zXOfzRpK2yQ64g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(4744005)(82310400004)(70206006)(70586007)(4326008)(8676002)(356005)(81166007)(86362001)(40460700003)(316002)(7696005)(83380400001)(26005)(16526019)(186003)(36756003)(2616005)(508600001)(6666004)(2906002)(1076003)(336012)(426003)(8936002)(5660300002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 19:23:50.2894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dccef6e1-4e46-4d09-208c-08da0c397ea6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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
Cc: DivyaUday.Shikre@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XGMI iolinks will not be created in KFD topology when use_xgmi_p2p module parameter
is disabled in a dGPU.
In this case PCIe p2p links will be used instead.

Signed-off-by: Divya Shikre <DivyaUday.Shikre@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 339e12c94cff..d5536e33b3d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -536,7 +536,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto kfd_doorbell_error;
 	}
 
-	kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
+	if (amdgpu_use_xgmi_p2p)
+		kfd->hive_id = kfd->adev->gmc.xgmi.hive_id;
 
 	kfd->noretry = kfd->adev->gmc.noretry;
 
-- 
2.25.1

