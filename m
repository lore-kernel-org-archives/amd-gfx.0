Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 12:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF8660EE2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 12:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CF8660EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B200D6E4BA;
	Mon, 11 Oct 2021 12:57:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603DA6E4AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 12:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMVFP9na2GzKHv+faaNLvSkN3mJAgIKOHSUGnShUojNDjwGTa9iGoGNd1WWhddlyZeh6x2a5bePNHIO3dfZ59h0uHnNUhDOLc8ypNkWPaI/CBVXrM2IljGND39Amiw82hNyjNCgcxa+KNGBT7r90RVsUuzCu6J2yXSeQPs/mByXOGYQAEZ0zSGUWTyCXSDpCxhYnnq1dCsvZPBrjv4F0fLS5MbYrUZ3+knl93olOCiF5LsP4+Av/B2MHj340WZgIwltfCwbku/nS1/QAtIf3XmJE19/Kwub/r0/GpJTozgpscQ8ktdoVXkx//MZfc1+uf8Cw3oe4vLdo3Ysffdvaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz4m8fe8EZd3qhnlASIeLJHggWtpeGJl4k8e9KvOWVM=;
 b=Y0V78/0PaBsIpsgsf/cWM279STdjCxjxhm/I4oyU9Y7P92xnWwsswDNdV+QG8j/SJQVmTfAjuyY/0wfLheiJSNT4llddcSbXUR072yQAF6duWtHPZNZy75yfc4FCqww7rDtxJcXTOvsi3YxfNqIAydTau9dteGE5IwpkMdMlhZdZ74N9F72WgYEaB79RyAlq3bPv1bkrPISf1Sl7ZPKIm5Nh6+h/df/M/APGoagxicEJ4sdhrbNB8jrJH/nr38LuziSF+0orU+TF01cQwFXrkFe59DyiHQAYvbddOH3o5u5sqXv08Ds8p4SaVkBdFMBwrEOG9K3ctrChrD6NVktDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz4m8fe8EZd3qhnlASIeLJHggWtpeGJl4k8e9KvOWVM=;
 b=S3PhIfcKYPhHbWQo04E2+9w5vwmC2H4crcm6Ilg5zxOod5KqumGtKGFNu3U9/678CJSIsvvSgRtq3O6riRtJWPpXFZS7XVi0gUseYZ2gUq5FqTN3eNQb7U8TRNB/Ev4nUcwG1VMQp2EG4JvJ9QyCppobLpU9rGS2Hwh+T/H6csg=
Received: from DM3PR08CA0006.namprd08.prod.outlook.com (2603:10b6:0:52::16) by
 CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Mon, 11 Oct 2021 12:57:49 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::31) by DM3PR08CA0006.outlook.office365.com
 (2603:10b6:0:52::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Mon, 11 Oct 2021 12:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 12:57:49 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 07:57:46 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jamesz@amd.com>, <youling257@gmail.com>, "Yifan
 Zhang" <yifan1.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: fix resume error when iommu disabled in
 Picasso
Date: Mon, 11 Oct 2021 20:57:01 +0800
Message-ID: <20211011125701.2800114-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011125701.2800114-1-yifan1.zhang@amd.com>
References: <20211011125701.2800114-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19b3e3b6-93dd-4edf-b001-08d98cb6bab4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3782:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37826FFBEF759D9AEBFBF6D6C1B59@CH2PR12MB3782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yxxaQRN9Zu9ArE6SvAcMETNBc7aBfj80DzVxVDPPRylSeXrSS8H5hZP10xDF3vCBhnahFQBr/y1SUQgGTHoc9OoeHrwpgT5ZdkGXr+nZh2Dw0cA/6A2KvrrNnjiVaidfTwBqjfRJ/NLya3bJp4Ynsz27HMhJkb8oWlLAdBy89gB+BUCRbXpE1cr9dLscDic4OhMKTp3UW3Xx6yKp1/TAAwOuFiUNYE6fsi95Kxf0FD8EWHzHTNZn3VpaTQDjyI0kQYVmpm9Alorr/9Jf9cPIdeRPwXN6u9RjUQ+8gJLXZjx7DCRTOK8lh0tbk4liObF73iBdHm8P9a5JBmeayoE0plOdk2pi2B0UvtWtuLK1HkaXL2RTk89cx9eCedxSltvQqHfAkuenK3xONDLTv6IWABeTPYZv1xhwbz00UjprUuTu731n5AsXngbYduWzKmw2Z43YdRIAA3dK/wVzAieoWs9MIirapgS0ZnW/FEErmL7mzSA53afMq3XcK+MNdwCPyT6wrMcwsoAEmb1eEAyUK8qhtSjevoI5HNzmExGpnl26yY8ZT3Wvfapqk3M6fvcPV+dy9hs/KwLgHGe7aglLmPas9r+459ARJjVq1tBtDiiVzOkk7uWgxNyxTS9mEEepCsjxHwrPAYUx56XacFc7OrleiBiM+hqmrAuNxPVp3a2GAqOB39gX8B9+bUqk52I5XaXnfueaJD65yFYEdN3GFXqs73AwOp4d4ib69wShD8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(82310400003)(54906003)(8936002)(2906002)(316002)(186003)(86362001)(8676002)(4744005)(70586007)(70206006)(36860700001)(16526019)(6916009)(426003)(2616005)(1076003)(5660300002)(26005)(4326008)(508600001)(47076005)(6666004)(7696005)(36756003)(336012)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:57:49.3096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b3e3b6-93dd-4edf-b001-08d98cb6bab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
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

When IOMMU disabled in sbios and kfd in iommuv2 path,
IOMMU resume failure blocks system resume. Don't allow kfd to
use iommu v2 when iommu is disabled.

Reported-by: youling <youling257@gmail.com>
Tested-by: youling <youling257@gmail.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bb652ee35c25..1fadc9fb168d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -916,6 +916,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	kfd_double_confirm_iommu_support(kfd);
 
 	if (kfd_iommu_device_init(kfd)) {
+		kfd->use_iommu_v2 = false;
 		dev_err(kfd_device, "Error initializing iommuv2\n");
 		goto device_iommu_error;
 	}
-- 
2.25.1

