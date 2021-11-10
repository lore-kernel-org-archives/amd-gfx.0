Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADDAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 05:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46188611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 05:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46188611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8866E02A;
	Wed, 10 Nov 2021 05:16:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6537E6E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 05:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KalI/Rxy9x0GPQmR0D/C3sHViRaG+4XjQ8wwl1ljZ/yxVEFJm+R3GzdE0uph7mijhshlS/U0xHhmdpPuyTra/vd2AQFkKbsXULTWpnHNMbM2qfGvPKS4RKhRT0T2eBiYMHgyXNs5ebAfaVymXc/Am6WteVbDnX+i4mAkOxcD7u8LeUc9GLV56Ck1w9iQTf2Lpn2IWsKpg2oiqNUExWG9WDqgZRSFb6ULmGQEzaiJbj8AA9iEn4pVq9MNi2V/0I+cPVZ+exrOdaOeQLGmsiwQ/NZwOC6cqB4TMchKWnKRhrdTmeEgk+umsM3sRvXI09aCQHsamFtQpYwbjU8QogTgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WvpFcDVxzeajXXHLgnSr/IfSYCTz4g8jKj6MfB3QSA=;
 b=LQRltNF7bClr1or7otyHnn/IAtYhRsTU99LYusnUcFWdoNcoEGqV8v8uS6xCeHlmpwWjKhs/+0I3gavYUgplFYSFr7JmzOBeDX5qGUwafMwbuF4aVMQmzF+XhM9Uw9HID7Ds+QHoQQTxjyHk8LxIUpzuAUi1R2iu1KypsSNky1qT04Ek3aY2P1mgEetVbFVKy8GDN+Oblu0Lnrkj/yd3vm4oGntCtgFz1PEMRwSCNVxSSrPmq4Ei7JM/ykTXAMpCzN7G1TL25BFrp1AIMbFjwycTbsHgKWU8ux1s6IWmvwrA9mV8AvhczYQWsq74gd4T/AYLIufgDG+c55KSpS1FDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WvpFcDVxzeajXXHLgnSr/IfSYCTz4g8jKj6MfB3QSA=;
 b=ZJcvcCPxOQu8863ewUQOJ0WWsnHz8+ScZ5KuRozh40xyMRGrMyZZQRRT19nQ5aejE+1cdYJBciJBqMtF8MwrBh4tdUk68bY1uGcPYh5bM9zLB9F/jPHb9knc3zRXMIW4EGG46cBOIqNpf5tOEYq0CfPej1qNEZwD8yWxVa7QtnU=
Received: from BN9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::27)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 05:16:23 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::96) by BN9P221CA0029.outlook.office365.com
 (2603:10b6:408:10a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Wed, 10 Nov 2021 05:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Wed, 10 Nov 2021 05:16:23 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 9 Nov 2021 23:16:21 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: add missed support for UVD IP_VERSION(3, 0, 64)
Date: Wed, 10 Nov 2021 13:16:08 +0800
Message-ID: <20211110051608.32696-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 856005e0-6ad3-4e31-5515-08d9a4093d05
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:
X-Microsoft-Antispam-PRVS: <DM6PR12MB46199180CF58C36A09859C12F1939@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7FNXYUKtm6efuEJplSXI6hs1wKQk6PF8glAKlchBBy7H1Bznf9PubUNny2ekXQffnHYRSeUxfj5FmZ4JOc6OZz5a4tnXlCbuncblajWpdSmXbT+CLXOfaEJqX3ePuKlOBIzRRTp0W+Bht3q2jaOHUmqQaBibchb7m9yaTMgx1MxsRKpyMnsMTJFXITj/HLg4DTV7m90+dSO98yswOxkSVkE53RBKriayKgJ+PbG59AfoU+Oj6ioJpOMJ0H/3R4WRCpuyy4qLjz1sgynTJ59oPOkah890Yxle2Tj9r7Lv9guar/nIYknua/tjsiq+cKhe8GcI2Zob4eqWncRc75X3WzBi9vGMU4kNFGjS9Xf+gUID17so2R0EhWuVpb4lux4mOnK53V7iXpbWE7E5XnSPzDkc7l82nOo4DxFZHWrnv1/IlHTV0tQqgVNt1+UBd+2BS2gpZ9tWk4lRrai1LrdDekPC90ZzSQDV6coHcVIQ0AeVWFtfhrsLHmZ0rv18MNXr9TWEf/P/Gqma/mbYoBpxY2F5H7lUQHJIQkB3hWxakI0A9wgjWL/BpFydLI0n6WbvDNInE++kUNQuGqodjZnzTlUHbBZvk5UfcFXZfU5wOfnRirOnwPwPYVcd73KoiNzXb/cweUclRYqy1hVoDFwIHFG3ngMTwJlZCpsHsugOmg9gqoWOjueYzjhfuRhw8VIS/1Su3uz6se8Oygua3SDUpS4x4DxMFAhFzVs3iZGO4NrnqtV/Xs0NUu8GmiS1JtH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(186003)(6666004)(82310400003)(81166007)(83380400001)(1076003)(16526019)(2906002)(356005)(44832011)(54906003)(47076005)(36756003)(336012)(8676002)(7696005)(36860700001)(426003)(8936002)(70206006)(2616005)(316002)(4326008)(86362001)(6636002)(508600001)(70586007)(26005)(110136005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 05:16:23.4626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856005e0-6ad3-4e31-5515-08d9a4093d05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Cc: Flora Cui <flora.cui@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 5b30f206dbd1("drm/amdgpu/amdgpu_vcn: convert to IP version checking")
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a20d21409c95..ff70bc233489 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -882,6 +882,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			break;
 		case IP_VERSION(3, 0, 0):
 		case IP_VERSION(3, 0, 16):
+		case IP_VERSION(3, 0, 64):
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 0, 2):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2658414c503d..4f7c70845785 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			adev->vcn.indirect_sram = true;
 		break;
 	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 0, 64):
 		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
 			fw_name = FIRMWARE_SIENNA_CICHLID;
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index febc903adf58..59eafa31c626 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -182,6 +182,7 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 {
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 0, 64):
 		if (amdgpu_sriov_vf(adev)) {
 			if (encode)
 				*codecs = &sriov_sc_video_codecs_encode;
-- 
2.17.1

