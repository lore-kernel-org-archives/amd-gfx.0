Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C22C47DB3
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 15:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBBA010E052;
	Mon, 29 Jan 2024 15:56:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB68910E9B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 15:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXttY58mOBN2zGsdThM73XOpuEk4/AqpWOo/2A8xeslcYuyNQa2gw6VzSnn8kHSWgv8VvC4MHv43yPnP0kpLr2BQzlfbWfMkC0Zh+mtUSd7LvZC7KvpB1R4rMY+WNYQ9VVuvD0W7oA6u6ihuVYwJ1Cfu3zjl9PTM5EgTJobZinA4I3YVFwJc5MgGV7LzdqJrC3vdzVKQqrAvlagsmmXuXaURL7f8z+AEWyQ2wX9Hob1CeA6XbuZ2J9OdLX05OtwNmBLYDnHi/fvkNcE6iRZZ9HcZSWOAc3Ksh2MdKHapFgIw/rRVNreSjfy2OnLL6BQuuVAVSIZUpcHwnFEwZ5ejag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAtQ2IG8winm8NciQdHSONCJKIJwDNhr5nRj4bLSkf8=;
 b=l7vew0EjUOnjqz8B8Yrzb4VUqs7vQmCznvXLww+uSWvYXuaRd/5FVTazE+pmJ16zggF3g4+fcoV2Pvyi/NgvB5Dv6g1dxnBJ97YQTbVnIF74wvWPuNGoDLp75jNOvslau5Y7xane3kHxZuDPlM6JBwBW8x0ZfAFlEX88+FZlUADQ9+RwgMJBROOaGGzPjnjoCZKAC8LOHJ6XTgQ6pAUSnteqdVFtfWSG2V2+FOPhd9fUalSc5FUcxecSfbagRhxvp8uti8CeApkwwyGQ88aXIcyN/1fyO9qCxYU8JUisroKpgCPP8mASwCExhRTtFLx1UZmucWcnpSZSxgGDlcGorw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAtQ2IG8winm8NciQdHSONCJKIJwDNhr5nRj4bLSkf8=;
 b=PlsqUEFVz879m/xzs8kc/ZKRYkKmUGosdhcRFcpNzTgxaouvTqUvzyHPyvZ7UxTE/clVNptxJXilpKYFVTjsP3V9RFM6DbyzisYahT7qiz9cMbmQ+jduFBj9gecc5BrYBwVUPw9/vRNkCtKNOg7ztXItQf7w6IDNX1U1Gb8xxN0=
Received: from BN9PR03CA0455.namprd03.prod.outlook.com (2603:10b6:408:139::10)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:56:36 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::30) by BN9PR03CA0455.outlook.office365.com
 (2603:10b6:408:139::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 15:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 15:56:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 09:56:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
Date: Mon, 29 Jan 2024 10:56:21 -0500
Message-ID: <20240129155621.824237-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b125ed-9c32-46eb-64f8-08dc20e2de73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/KwdXKclyx/bAQYFH0ID6aLuPP3zluSWAy1+L1trCsOftN72ryKD+RHtGhP3p0snwQ1MLhCzg0vxhes+0R1LKJO+Wv/9F9l69VBoCUgX0GEskCNSP9fzCqEcROV10i9GzNWyDn3jN6HKK/4iCmC6mYYjcTZx8xw8OHGrOp+W6AJXA4+i3RLVqJ5JYTcTPNaARr0F4Av1Q6L/ChIvBvxHbFAz/VgBBIoHaNZMwHtziMAvVRKtS9BC5PMvgqxdnPk/R2zMImsTO6D3kXiQKv6WTFR2SYvOUs1te+RhEE6pPcFg0S6j45ZvrkKxleMpf9hmVL553cooWP6BAsbpNIv8mbWss/0CkdP+Qh+7t3uZ1+p0ewuQL2PcKnZCaI1FowBHGRItWfie2UfYYlFUhCjmzYD60EO2E7+mMs8vRcHj1EF712cMaAxZWgDKeeDcmrVyDjmql7CMnn9NH5KG8kbk0o0x5opU1fI5NRjNwidLJxWn6c4kSlZ6zTentObhLxEl7ltiKLfgwaBlfmz4VkkB1w2iJLg1Wdep+JRcGAR/vXziw5GMOHfemOxEcS2TDgzWKSVOrfq51QH+YLFBkJzm+SWnliaxlmsPnwpel42k/nzr+PW+Va8igxKFQcUhdKWHWs+oy6WTDCX5eOPkzvFtx5qGno/pS55HdbKEVyao/Rsf41GkyfZmOVLJyYdaiIv97pCEmOvH643fQYd0DQhGKS4fHakB/Anf2aGSQ/DodcUzjxc4qSV8h98HQx1c7IGmb0yUMgw5eqCxgef5L4G8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(26005)(16526019)(1076003)(426003)(6666004)(7696005)(336012)(36756003)(86362001)(82740400003)(356005)(5660300002)(81166007)(8676002)(41300700001)(8936002)(4326008)(36860700001)(47076005)(316002)(478600001)(70206006)(6916009)(4744005)(2616005)(2906002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:56:34.6257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b125ed-9c32-46eb-64f8-08dc20e2de73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This avoids queries to read registers or query the SMU
for telemetry data while the GPU is in reset. This mirrors
what we already do for sysfs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a2df3025a754..d522e99c6f81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -607,6 +607,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	int i, found, ret;
 	int ui32_size = sizeof(ui32);
 
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
 	if (!info->return_size || !info->return_pointer)
 		return -EINVAL;
 
-- 
2.42.0

