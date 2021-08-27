Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FC9C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 08:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9204D60EB3
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 08:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9204D60EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283306E8FF;
	Fri, 27 Aug 2021 08:46:01 +0000 (UTC)
X-Greylist: delayed 171072 seconds by postgrey-1.36 at gabe;
 Fri, 27 Aug 2021 08:46:00 UTC
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5D76E8FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 08:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpeal5u5k8AaOzYGiYgnWdVj5Mc5oylKFYBxCu8lM0SnVOyVMfq1WTdra7EVE8OwSQKvaCPh1mxLpdg0nAaOlJA/HaVS1xKRCdDYrcIsnmv3KbR97MMNwbm/PjXiGCY8S0HdstmbGd74f0QoZg+IGcUuM/BLqr3tLrptfi8fl9kYxtkFVhYz1c0erv32ZmvL8lwq4v2jzn0+D15rKy36q2KfnciAYHJ53iALpF1i/M6v3XBRI5s94ox6XnurTMo0yjh/ny3CGrl7aFHG06JPZdS8CPQ8w4UXABbCXFzlJ0fiUMdh668gnqfIF+shyeWkBni/WjvSioj3DPNL4ygOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xaZ52CHIBTYJ0C8WXNXA3kYJxSdKiqPL/rQZV2Knpo=;
 b=bsDlQixTiksARsZz7FoxD1D1buhzSZ2WzdkFmezSzVsaBDEkeVTENzSiw7MB31A1MzsgY5JwIFOyduH5gD7TsK9azfVTakzaNXjQpPZ0+uAI5LAv358ClNg/YEO/Awi95gDWvRuy9nKHApnlEHYDLxsDWzYE49w/RDg55S1JMTcqWRn5ZD6lTUDA/FBwQeEoCS4g2xd6xrNB32hL0AvidQXfB9IZpMbal+Xrz6mo4PYpqVm/DDmjjFLeiHQ6qAdy6tEoco3rqvq0QjAhuTSpCVkRZcExUAoqyCzDeAwgYYPjdIN4FzYuEAhA5hhArhPdov+336gu8dHy4nS+G94p+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xaZ52CHIBTYJ0C8WXNXA3kYJxSdKiqPL/rQZV2Knpo=;
 b=qT8FnakOjdX9kPkViRHAPBIRS+0hm95ODyXr6aOS0WVdI9zUjXZw6FhNgInKb+b/2rnEFOr5E7urAIpd5zzR5d1QLl+zxlyTVVQZTtlMIP8f2vs91dBeo8ctt97OswjEz0JH3PuG/qD4+tbFlnQddgWJ1GwG0bhIEl0Ey3B7cUI=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by MN2PR12MB3789.namprd12.prod.outlook.com (2603:10b6:208:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 27 Aug
 2021 08:45:58 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::7) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Fri, 27 Aug 2021 08:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 08:45:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 03:45:56 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 27 Aug 2021 03:45:55 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: adjust get preferred domain policy
Date: Fri, 27 Aug 2021 16:45:49 +0800
Message-ID: <20210827084549.166223-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 979748b7-e9af-483b-50da-08d9693716d0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3789:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3789A165C4DF10A3DE139087C1C89@MN2PR12MB3789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnX8VQS5ua+4yLdvtDhRwm8Av4vVlEA7VxYzeB0wIYUCqcn3Z4/3bfQ49h5sp7KpSZtuSzmP8y/SavRDR0cyI03fNCSg11YX21Q2j8Icf07RaqrxvTUo1AP+riKYzqm7TWkRI4eN5N1PK1jWreHNce2jiFdbEytuSAzm6Q3cCX0wz1WzUIRwaVq66vR6H5xdoYEnd2X+2H5eRdOjxRwxmTjLQY4UTo+GS7GKXsiynfoNqBM63dxaTMjRo44yw25xftMj3foJ+dli9xlAvbxG6psh38J8TSWMNS8vgJZWUwXyZEA1HnT1cKfxtvaQn83yG47FvZTsry01r+60fGvfUVdGC6a04wiXy8etbFNTOHQf4tyXco3lslaut2/CTKfnT8n3LQd2axeIBTZxJzWOwfUdn1Il/+ZS74G7eCtzUS66D3Xf2Uh6bn/TGiWbdEIvagyPCa7ZVutmmAYXmtZnCaP4uA/TahMASAuAkpHg/6KxX+5cRSE+Pduwjwh22vizQ+Zf2AwhwfZnq0Tii3i+6oqahl1B9Me4xwyr9fvdw7Wg0HlCefGcu+6j47HBqnwmx3WoZXBXfwT6mPScbKjSxGS5ATqDpmJLa/omc94NvqycKr3onblIqL6mnU9tiePBDv1H6hI0msBLQ8JTVGgu+UVnKyYvhAJ0OC5+Df4o/DpYWFyvxkUHvOC75xL0gMl7H7FlS7FlNoIpEFYVtdOuUkDyz36BS4EEh0ya2784w+A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(6666004)(478600001)(8936002)(4326008)(356005)(83380400001)(316002)(2906002)(36860700001)(82740400003)(7696005)(8676002)(54906003)(5660300002)(82310400003)(2616005)(426003)(36756003)(336012)(1076003)(70206006)(70586007)(81166007)(186003)(26005)(6916009)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 08:45:57.5571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979748b7-e9af-483b-50da-08d9693716d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3789
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

current preferred domain policy is static, which makes vram > 256M
APU never get a chance to allocate system S/G framebuffer. Change
this policy to take vram memory pressure into accout. If system
support both vram/system memory, return the preferred domain based
on vram usage.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 65a9b23f0a46..ea3b084e3c3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1530,7 +1530,9 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 {
 	if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
-		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
+		if (adev->gmc.real_vram_size -
+				atomic64_read(&adev->mman.vram_mgr.vis_usage) <=
+				AMDGPU_SG_THRESHOLD)
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 	}
 	return domain;
-- 
2.25.1

