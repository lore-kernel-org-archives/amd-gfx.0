Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E183EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 01:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD69510E6C5;
	Thu, 27 Jan 2022 01:48:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E9710E6C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 01:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGWr4gmRGicniszyj1+mnWYZpkK9O5KKgGLsHPe7OkfvlW1ORvPlSj/pfBcXTRVN460Rq+9gAQ5CAYwwVx/qFrJ9uv5ZGwMBiNYM0dUpfNQb2R2eWf1pjf5L8VasqDfGHwfdlaIpxDEyFhSI6yMQ59daPSZCNwMBVsXJ2a4zFRjace/HZl94qu4h9rCy7NuHdPK659+S83XxFVQS6Kgd9SGFFZWPb28uf3knt212/ULrSlIoax/b1OSOK8kDc2/LVS+tuOuQzG5f7pZbW9wV0DslXeAw0L10l4TmE7jbPbbNwTth1P6IZ0IM9jUOboeswIkl6vkOKYxGNKCtjJjAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCSLLAiM1s/r0vTjVw8H2ineJC2ntWOHM37jFh6i/sk=;
 b=MojftiKQI7Pvg6HYHtl6DKUTMBCvgt0Y1EQ6V1ZTgZ5dFDr+86d6huFUY0W9uthgRFKn1UId3HdaPOLS35OPONCS1xJjeeHTO4YFRAc40nwI6Tcp9iz4dX61m+S9kaV5TM28Fp+BiN7He3rGWR5H2t49eps3lzncJ8AJh5TJxNDAnGZ44VQ/o7Z2umRE0w06JfEUqEr5QOrEzWS3mHszF/duETiBbaTfbTUP7vaV5bdzt8fsGkKNqvwk6+tl7B/pRVvLJHqQw58cN5t7LBLyYIDRxZTYj2eR3wooDN4PAS+ZMvb8FTYjy0F/9zEO6hk+aaxeMTjUZXrerlyGwACdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCSLLAiM1s/r0vTjVw8H2ineJC2ntWOHM37jFh6i/sk=;
 b=qnGtEAVO9IYN2kJlBVXpRpkdyOfSCvAFHC4pRvweiN1YV/wJe6pWie0CUGEQdjR2HhUudPCFk+sqEZ6JsK4u9NOpIAfwEIJiAEgLiczCMNKRzSQKiRd66IRSTnUIeQtxvJ0gwlA62eOStH/JbEyZNrj3c6tMgqc+v/YBTPlV4wI=
Received: from DM6PR11CA0072.namprd11.prod.outlook.com (2603:10b6:5:14c::49)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Thu, 27 Jan
 2022 01:48:54 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::87) by DM6PR11CA0072.outlook.office365.com
 (2603:10b6:5:14c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 01:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 01:48:52 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 19:48:20 -0600
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: convert code name to ip version for athub
Date: Thu, 27 Jan 2022 09:48:05 +0800
Message-ID: <20220127014806.2592589-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9abe6d85-4ac8-4104-acb3-08d9e1372c35
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB254483D9FAE248D731CC6463F0219@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qGqnew5vJ1B1yUT69pynpB33PU2mnRqv/C6gxjY3g6JANifYjWSBR4f/hv8diLuXuwWsietwjpQp6mDNKygfZPAAdiyTRo3g1ytAx3hNAf+is9zJ6i5Mx0e2jwV4QPF6kufj6yffD9LSJJjyltonVikDgG4EaKmf8Wx09MLDC/zVCYobGvsf8pSz8jMnCIq+0jOUf0ulTcLSlru/uvHhaqLXCueEEnR0M65pRUMP0+y5ToKKcb8yqnyyYhYKPpaw5kABZpZ+Nv4nJ3xKiRb4hGv9lrcjsaen/IOPf6stCoPWmv9v0qo49hozfmNF3pJCwBPC+9HgYjH7uuRz6UvjsZwng13BWhldqivOkpQ1dBg0Kk7EqPDptGTfzg10479/j9mRyNt60rVCIGESJgWsjT3ELNFFZqbms9fiHmJYUuIIFDIKWocCBL3dISnJ/oh3ayuQcXmCThR+a80JKOgHnsOPNokMlLbP9LB3ZBmmrV0zZ1kPkpcEcKPrD9UKKXIkJKhuM2iPp0AqKBSSIhPPE3QCFg+jBfxVwG5DI3T3LSr6Y8sYJLWc3OlPf61O70ho/99kegg8FiDC/8/GSNLnGKG1vdS/YnPxR2wQye+6HPs3mdrxGKTa5IGOwPUimvCy6Aa1I+Y2Wu6JM1KYOZxzXz4eiwTqRMC5iHB2rh/s8GZl4aRnubRSVqrbHtwY/MUO+Q3X7mA8EC3vJAj9zzHHbsjPz3q4wCVKBskYpyzP4RXqGpmSiZLw6Cb+TJvLREkXFZvPEy38EWFYv3xu+5kcE7NUysSN2FQo/uOvhLC9I4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(86362001)(7696005)(70586007)(186003)(1076003)(2616005)(316002)(6916009)(8936002)(44832011)(6666004)(54906003)(36756003)(16526019)(508600001)(70206006)(40460700003)(82310400004)(336012)(2906002)(81166007)(36860700001)(5660300002)(426003)(4326008)(356005)(47076005)(26005)(83380400001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 01:48:52.9708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abe6d85-4ac8-4104-acb3-08d9e1372c35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP version rather than codename for athub.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
index 3ea557864320..88642e7ecdf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
@@ -68,12 +68,13 @@ int athub_v1_0_set_clockgating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[ATHUB_HWIP][0]) {
+	case IP_VERSION(9, 0, 0):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 0):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(1, 5, 0):
 		athub_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		athub_update_medium_grain_light_sleep(adev,
-- 
2.25.1

