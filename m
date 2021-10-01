Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51DEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 19:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD1E61ACD
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 19:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BD1E61ACD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471036F3A9;
	Fri,  1 Oct 2021 19:48:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AC86F39D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 19:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No98kZgdZyDilTL/a058HS3IAXdIB5QiYI2Oq/7OCQo3EM+eoGSjiy4ov3cE6dSLRtkiR9aRxHiBrhCNz+B2tOADC8SPATUYN33YxciPsXqSIBaWbuNNNrw38ozsOEg3XGKZTyZjhv6KhWLRPmCVE3/N7wrxU7uHaeBLsh/kzKcv3dhgNnH0o1YPv2QB1nCtrk8Dj+cFl1AwjnfE/QBrmJWM721p8Ldxt7tfYpF/k65thNQD/a3FqTwRPe62DFLat0mL2TMbuDn/5HhcWrjm43XFxMH0ZjC1PMlJJBSbVrP67XOyRJ4oKF+nLq0MOb7//srxjXInke8gm3fclyZoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoJyTZltkEGR4+WcHsDygGgr+sHF2XofWOkMOpVFg2Y=;
 b=nxYUGrgYck2+9z5T2ufFFW4U60gFDjHc+yzakY7yosdSs2bjro9AFmSbUkJNsD3YsPyOfloGJKXqb6UInzdU0r1Pgqf73FwxjGQEyaNpQe6mf7YExEOV7fNLiDkYPAVygAWWqFtDnosOmZkITkJzbeDL1OOSQ82t/YR7Alls4sad6hafJ18rb8pgCMV2mXhAZHnkMQz0udGag6HqD7MFIK7wrZPR/BnNurz784jpAYGp+jfdejGi4MYUeaQTPo8kezWhqsRfgqC+wHuLPN8T1yn+dAxWuAt5cGp3rse9e8Slshi3kJ1/damAHErQMAi7cKcRNM+GSpvKE8tv1RReFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoJyTZltkEGR4+WcHsDygGgr+sHF2XofWOkMOpVFg2Y=;
 b=D5vAP76ZduXE+iKge84XkkJ3yxVvGDa+BNZCvFnaaS24x59/STSh1Dp4w5s54j9aXFUsUzCrSBQAuWQzzHrKT27o26Q+FaGftNFE72dB7GUwNzAFe0DAsDXJGIyuKigEaoHoCWa5iq2ZnGvAoR5eTc4AcjHci7DFY3sL72o4q5s=
Received: from DS7PR03CA0216.namprd03.prod.outlook.com (2603:10b6:5:3ba::11)
 by MWHPR12MB1885.namprd12.prod.outlook.com (2603:10b6:300:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 19:48:41 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::71) by DS7PR03CA0216.outlook.office365.com
 (2603:10b6:5:3ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Fri, 1 Oct 2021 19:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 19:48:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 14:48:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: [PATCH] drm/amdgpu/nv: add missing CONFIG_DRM_AMD_DC check
Date: Fri, 1 Oct 2021 15:48:21 -0400
Message-ID: <20211001194822.1818798-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001194822.1818798-1-alexander.deucher@amd.com>
References: <20211001194822.1818798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20425c3a-f8f0-4779-2b57-08d98514782a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1885:
X-Microsoft-Antispam-PRVS: <MWHPR12MB188529F1D524F4AFC17DAECDF7AB9@MWHPR12MB1885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Uxpld+ti2E43D4uJ3nX2OICHrh2/n30JKKTG6bnneNA0Vv5/b88QL93jX4PThyv7kvHP0BnhXE06ryapmqUKYj5d+E2nyQL52ymkM+kxLz6wDtPpUob0f+AhKjgEPm3eTUfFYI/vpG+urNp6c7BjNqwSXHkNSjG7WHhSS8sSwr0Xafh9shUL+WcSWV16+mIqgqQLSYYH9TNSmCxSHXVin4SHJ5KUPmekft8+6PTQ3MismNZa0dFumQjmnCHU0G4HDq4NeH2c53VcobMQ0fpiYD56jdcHzYcj8GM4bNtnaq9xsMJH1wGvUX5fvK/NiQwfD0KvfzfnprrY7CPYxZ2TkA/+nDtlGQ2KZllLzdQnTQ0Tm4YXSgwj1hVMMXseubqwFQQYWjFnaI19O7mSvWPXcedUZODP47hjJr2y7lQVWjuqE/ruty0gU7azVO4/txFKiv7jt7skCbzuQ9a2P7NDzltq5urhodh0FdgFk415gKDVP8C6V066Bgm8SWQIrPP/LFqunHgkmI+t4CbbBmPkMXhnK0syF8s7K5+uMjli0kcYGB3akpaozn8OFBWwNJllyvJ45x7nyt6GeTw+5C1GLVmsOIdNbpWFsuzl6lPfCi3MSL0X/lbQTs0lfAQAe6gtgFzYkayWvRh5COTjqK42BYmA/C4Ts7SRWYXgkhvaBmjeyUdN+tfBhGA/MgpGHipqibZNfpqw8XQSpc8adwXqk1zBuLAGN0ip+XDHpAhvOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4744005)(70206006)(4326008)(508600001)(36860700001)(6666004)(2616005)(2906002)(316002)(70586007)(8676002)(47076005)(83380400001)(81166007)(82310400003)(16526019)(7696005)(54906003)(336012)(36756003)(186003)(86362001)(26005)(1076003)(426003)(5660300002)(8936002)(356005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 19:48:41.0696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20425c3a-f8f0-4779-2b57-08d98514782a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1885
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

Check was missing for cyan skillfish.

Fixes: 82d96c34b0d49b ("drm/amd/display: add cyan_skillfish display support")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 96975c8cc026..898e688be63c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -891,8 +891,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		}
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
 		break;
-- 
2.31.1

