Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81888C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 20:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C7B11BE7A;
	Fri, 12 Aug 2022 20:56:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3719B10F814
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 20:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw7Rana6rtI2scKi5eGJRJDxo1fUzWote6g/nBpRGrTL96ej7VWwpJYoMSb3owOy1bTwHp5MiWvrCcz0xq44Pfp42xKoS/6ZXjnNnPSm6EgerpKbyV1g+/6dz0x5PkjFKeVRLCe2We31mhgqlTQDvr2fmdxlsB3nK9pclUr2J/j5G74AsVOC2DGZsnfSxSXi6xqU9eRBHJCxxqw7Few94cIE+Ou+SooP7iCVxMxiwbTzK1UWxvXab56tp0Y+OGHTtfegfDwWbg+D+TgB79v/5/l5fEODV6JcbdrevpGL2QdGE+hBOitS3UKT96D+cJQ9ZXKSeVPaIRRrcYNNgOa0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQLXE8sFy56J1Y8I9wI1dfltrukMDFZfPt2f22Iruy4=;
 b=KFF+sNK+2U2tvT3gDfpSn9+ZrhfnM9DIFyFBYloZTrBTEqHyFibhp4IOgYPij9JTsxr2wG+D1Reu4wPIasqwlKtw8n8MR7l0VRE7JCOVrYuZRi2Ydu9tr4BpOu5T+n0HObHsrJoPTGo1sJGkeMqrNUtJOG79cuGpok9iELAIZakNGcbyrPfaAh+EzqenfD5W4C6Mcow1LkzxYcT9IsS2+uCKSAN7BpAodMDFLsK+z/hOQMdHmWAEmJYEICR8NPTzeOyOKrFFlnvsrLUmuLr4lH829ixaB8YNbM+WrsuPXiV5hZF2B5F5ny5o0EvLkDd+07kalgDSET6OcYzM/YeZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQLXE8sFy56J1Y8I9wI1dfltrukMDFZfPt2f22Iruy4=;
 b=ZA7YTozH+fJEkLx3pY2ypRSeQKjt6UNN0A0dxibfFkMshOGssqIKUBaO3fuaX1y2zaIDLpTwxBCsLHIeQhSRiEWYDQeQKxwVCXUTrqw4NzrwcDeef7A9fO3OG9epni9WkVJ508zUHJ4Oh6uKZrjeH28uVxZ0J11co6XttO3ilUM=
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 12 Aug
 2022 20:56:38 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::95) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 12 Aug 2022 20:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Fri, 12 Aug 2022 20:56:37 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 15:56:37 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix interrupt handling on ih_soft ring
Date: Fri, 12 Aug 2022 16:56:24 -0400
Message-ID: <20220812205624.2902630-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf916d8b-af56-43df-bf53-08da7ca5263e
X-MS-TrafficTypeDiagnostic: SA1PR12MB6678:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbo80fIAzOrlZPpKeicnipAYlpHu0zwcVSNnUgdwNKvDvXcLrUOZ7xVSH97+fOCnIT6Kw/G+A6ZAoDrGR7hkrz/tgz5j6RGMK6gYxt3gjpGtxbDjgyvqT2h81nJXNNk3zVBmjTljKdgAN0mhGUAWErLlC2kPz+MPIanTeuZM5Js6oqTX0nroJYbpq3k5pcUumv7jLnDEo+/BfsTuv30UNYKuZcJ98lZITRX/Etd0CurWq9Qp3+Pv/w/x5KOJ6UnTHFO9ZLWugA9w/rG/zrTTnSRg5466Qf51y7JXzoMLKGBffuZQYRJP/1TwgRYcr+zoYCFIdNQdVbrvab6WHCUtvhSFGvjtZFAtTPjNMcbEUNbAv/Qu8bi/LLoha8zwfcDzWqixT1gE8M5c2qd7I3vwhhLlBbpBdKuNMWji07dX2Y1NsRTvfnrlqryVproXNXNHsot6Hj5olqAggbydJn3D8cQGvINi4VcW/pR57pSW/P5WzvmFGllMTUMlyyDNVTnLRPqTOCE8VnoZLQjNhldUGWy7mfJgrjXLDD9Qk2ubX+SuwB4GkYmBBfyQv4eLsyRunp54x0YxdfvmPnCdDl287HKS21RL+IK900cVp1+pOWRgTOwRJFszgR1icziyF4mMZ2AlmDX9aGK3ovlJfqUiwGOk5OWFCH9wlGQEZW4CM+bAt4wCQ01yuUvPaA7eVPUz0bhqC3acCm+0FB3OJm/c1rK0c+IH/LapNR3bI2y3W/oqbC5mJ2Px7Oald+rcONQtPoJG/k0tKPkK4o4zKuXyLqiy1JlxZHwg5T1iNnhQY5vRBxKpSiEcvUjd7NZOHVESvT8Fk5c3hm6cBDIIsbS0X/a3FYj3lzlnZqrcBoORYLU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(40470700004)(36840700001)(356005)(81166007)(82740400003)(83380400001)(2616005)(40460700003)(36860700001)(8936002)(336012)(47076005)(16526019)(426003)(186003)(86362001)(1076003)(44832011)(2906002)(36756003)(5660300002)(40480700001)(82310400005)(478600001)(4326008)(8676002)(26005)(41300700001)(6666004)(7696005)(316002)(70206006)(70586007)(6916009)(54906003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 20:56:37.8816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf916d8b-af56-43df-bf53-08da7ca5263e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are no backing hardware registers for ih_soft ring.
As a result, don't try to access hardware registers for read
and write pointers when processing interrupts on the IH soft
ring.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 3b4eb8285943..2022ffbb8dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -385,9 +385,11 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	if (ih == &adev->irq.ih) {
+	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
 		/* Only ring0 supports writeback. On other rings fall back
 		 * to register-based code with overflow checking below.
+		 * ih_soft ring doesn't have any backing hardware registers,
+		 * update wptr and return.
 		 */
 		wptr = le32_to_cpu(*ih->wptr_cpu);
 
@@ -461,6 +463,9 @@ static void vega20_ih_set_rptr(struct amdgpu_device *adev,
 {
 	struct amdgpu_ih_regs *ih_regs;
 
+	if (ih == &adev->irq.ih_soft)
+		return;
+
 	if (ih->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
-- 
2.35.1

