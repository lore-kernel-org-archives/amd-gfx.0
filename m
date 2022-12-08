Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08327C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA11E10E465;
	Thu,  8 Dec 2022 07:51:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD60610E465
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhrSLRZ1sIZ+s5Hz/N0DMjK/PrTG/Xrw9qt81aEMErSvQbfT0+J5gxFNKR6+UjZCUaigjsYcy/h80lLpfk5W4FAMpgl0i25J+RaDFBa6fFSew4VJ9G4S3cEueidHzHjhJYlu3IDcrw7JRMGRqojGQkAa9/c3EDnUP68q3E5pKHXK9MLn65WdhQnNBjvxXfngTduTnY12m1JDdre7d1fKSe3fewRrhihP9WjDZ2fTaszOc9Eq3Y280WmmIUlq4iXgss5xpIfNwbSsD+EnkqLo1GtK9tOnXPJ60c8m5qyc+yI7hK2m2qEvQCMI2iS7aFslFBlcUYUgMl0h3yn3J54few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm8Cekp3zXx62CvQ1O6gpGIu48FnWMIWcFVgg2ioSJ8=;
 b=cEF1lzPyrn+ZifAum3LPjFBv6HCHOMT7+3Pjqs7fL52qRIj0Co5LResx90TRqenlWCOVC0OvldFDbgDGc3Uec6nFXaXOKUYTp2uVb8TVtmvwFQ9zZOWITs4IOoe2pUapgvMguC695TvMWQQWsRIOPGbto0YT0rDQfzFZ5fx9/JaigxQhy9IPRF6Nnsyz9LM1d1TUXEnLfGyqYeCYncvKssOJANvYTr4E4QTLL0Bj9Si/PjMPhJsgDJWveVS9PHqpkD2qz9eX3cDhq2xidOIrBISyFwBFS1bdM/PNAwQFIGH7z2/d2HlbhS8kRTtrUUt5O3VNjZzCmyChB9KcFLqAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm8Cekp3zXx62CvQ1O6gpGIu48FnWMIWcFVgg2ioSJ8=;
 b=4ERubx9ty2W6LVYZB724+TvvNQaXYJCwQogSydRrGkDjpG/4pvToaADjhRG+bHki24ng4qmQWGBKP1VjnCPhb+q4VGQBeFIAdTz27F6rueZ+RklZvKpzCQhiNyNkzNhmYjVs6wR+Il9w6X6iXXwnj8hJ8Zvy8GJaWdSTh/Fi8MM=
Received: from MW4PR03CA0302.namprd03.prod.outlook.com (2603:10b6:303:dd::7)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 07:51:35 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::14) by MW4PR03CA0302.outlook.office365.com
 (2603:10b6:303:dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 07:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 07:51:34 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 01:51:31 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add RAS poison consumption handler for AI
 SRIOV
Date: Thu, 8 Dec 2022 15:51:16 +0800
Message-ID: <20221208075122.28702-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b09d4cf-9652-4c0d-4466-08dad8f1074e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /u++NDZMkGVArzDgB4xMh7Mr7JZjlwcJHpezP+Ft9ZiFK3+npQhU/PI6Ipvy9AXoZ9kPCgkISZKxs1+ozVjHy3r7iPoVHNbyYrlOIja3K9Fpg6YwmugWhDaLxJNxCUG7LL179pYV3/mwFOAPDIg003asyWi3yd6UT6oFRsl5wZ7ONNUSTv1LLNwhnxxMTMKe99wrULfnQlcwg/ZTMs1tqUM2aWI5S7S2AstQglobAtlKC4gAZTfM6Q4eeU+wYW0o/cP9sM3S2JgVV8Mu4NW6V5BUkf5Ynwao4f90KhnH/7BL836ndBBT0kvLk54DoCfxD3EvDe5oRyW4XZdO/AdGP2bK2MW4jNH6qTyI2TFDQqe/ijpheAyXHwzck+w3FcQs3ECxkbxPj7vGzQc4xihXoapV2x3KGmJdWeUc8oCg1rETxD/654dqeab5ZTo8Q9ifaqzQntXWqIHTu7wznKagoNYV5TkPvV77v7Hp65C7sy4lbK6/Aol+7/ceaQEX+EDSw/LU4zqKM9TuVDcBfz5/D37fLawbP5DqjfU4Kov26/CrYZ9b86+qdK+6Axnk2+wQeU/97g+Eyn070ofmmCJm6W9reQbvz2c5Fml5EQGlF+esyIPKSCyJ76Zn9XhJxGR4pzo5txaHfD3BdODObZDVjvssf4D1/2uVYexfVD70H6TWzTZM7JBsO0WroAXPFgvN5oGlJpAhxftJ/phj0JVPR5rRjMO7oICgKUDV7DN6nDk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(36756003)(86362001)(70206006)(83380400001)(47076005)(426003)(70586007)(41300700001)(6636002)(8676002)(316002)(110136005)(4326008)(82740400003)(82310400005)(478600001)(6666004)(7696005)(5660300002)(186003)(8936002)(26005)(40480700001)(336012)(16526019)(356005)(81166007)(40460700003)(1076003)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:51:34.5915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b09d4cf-9652-4c0d-4466-08dad8f1074e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Send message to host and host will handle it.

v2: split it into two parts, one for mxgpu ai and another one for common
poison consumption handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 2b9d806e23af..b9e9480448af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -88,6 +88,7 @@ struct amdgpu_virt_ops {
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
 			  u32 data1, u32 data2, u32 data3);
+	void (*ras_poison_handler)(struct amdgpu_device *adev);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 12906ba74462..63725b2ebc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -404,6 +404,11 @@ static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
 	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
 }
 
+static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev)
+{
+	xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);
+}
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
@@ -411,4 +416,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.wait_reset = NULL,
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
+	.ras_poison_handler = xgpu_ai_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index fa7e13e0459e..af1a784696bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -39,6 +39,7 @@ enum idh_request {
 
 	IDH_LOG_VF_ERROR       = 200,
 	IDH_READY_TO_RESET 	= 201,
+	IDH_RAS_POISON  = 202,
 };
 
 enum idh_event {
-- 
2.35.1

