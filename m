Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7DAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 09:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52D06EDF7;
	Wed,  8 Dec 2021 09:20:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 794E66EDD7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 09:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=munnkGaYy8Qdctrj+sqrq4F3APFZ62eGekuGWOOS6n5SdyRdGG7eTZhfAn6nrfx8sSWscYS6dF14gfZWYy54PD8oOZlw1QbAgF/N7YcYosBE8X+RweJnaUuYlCBrHEsS1qzjPHw2ela8S2Oew2X0vPMLteqrpGcpGSf/OvSpl4YALPdvJqqYTmA1OpK8WHAAC0m8n3uOK+IskzZ2CqBGnCtKps4KbXORTmX5RYg2WzRyWFIGv/XYrp0KTQUdg2JLI5kTbZHpiROeMk5NYgYzoeJvilZppmnmPqfAFBrRzp41eoxA6oIrAh9ASl+s+KdNZkvsuHqjlVSyx0npbbz2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4slwNDkPmqprzUwB571H+esnu4DurrhZYDF/dxHH30=;
 b=AQYpqVWV+oXIBSthB9oRyCUP2Iygcm0i+aROShzJ4UpMnAkCcAIWpc8r40t/ZQSNu4D7oK2X6/1qHTojD3dcaEetqBqEbzIXlhTZYWZhc36oXWwUXOG5E0ebr+Q4zo+MjYqsvdEROFOMKHr8pCU6hNlYBGLBCmMpLGku7GgbBJ5nPRkpJlCZdgSZBm0K4yGcNwbicKPa6qk2/+7S349z3AE3BaRB5ajvi8KaJNKrvIQEu/M09FPEmNh5KxsKMK1SaMzsVHldE02tFmGhXfH8fKjSiRKh7m9uaJMbMozLYwVdKB9U1XVgAwsKmksEVNRPu9PaQfPsPs9qPeu4vmGerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4slwNDkPmqprzUwB571H+esnu4DurrhZYDF/dxHH30=;
 b=P+LPGsM1mKD66U+zutYFe5cAlZIr7YyD0Q4PSGs+p7joZGTpX+aIjzCGI472Scp0aKyUFWLXt1oe+UF2PL8eqR0GANXpgCtz/CuN7Wwi4TppFXmi6VYbXIeFUeS3I42fcQZ7XJu+kKn1lw0AkewN8iXcYiueL4hwoylsByp/i1s=
Received: from BN6PR14CA0021.namprd14.prod.outlook.com (2603:10b6:404:79::31)
 by BYAPR12MB3590.namprd12.prod.outlook.com (2603:10b6:a03:ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 08:46:28 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::7) by BN6PR14CA0021.outlook.office365.com
 (2603:10b6:404:79::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Wed, 8 Dec 2021 08:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:46:27 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 02:46:26 -0600
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add modifiers in amdgpu_vkms_plane_init()
Date: Wed, 8 Dec 2021 16:46:15 +0800
Message-ID: <20211208084615.437375-2-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208084615.437375-1-Yuliang.Shi@amd.com>
References: <20211208084615.437375-1-Yuliang.Shi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddd777b7-6362-4ddb-1e4e-08d9ba273957
X-MS-TrafficTypeDiagnostic: BYAPR12MB3590:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3590CFF9232364180B2E6620E06F9@BYAPR12MB3590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEWcy4oTTQ1QI6Pnq3T6sRcIu6XgrGMGOJRdkV7nRhndq7F8DJs3Oj/ymqRywkuteQjzXK6jT30bpYgS4pX71GFE20H3rv94E+1KcX9aWsOR8QnEEYkWyNdGMEg89ealkOJYzhnex78R61sCamO5wwct125hrMK8Kskp7OQfgrzvoUOICUoIXW/qK0CXqNKWenNpzEW3lEhOdPbSCbsljUiVV3lgCYE8fZMuZtvQDtLlum4T/MNGv8M2dNuPSzN0oMTXsnSsTgbWu0Ucvox+hGpy7Gg+DOEbalGVLo4B10xwlnAPwukns9ryP1UPHiDUEebQDPoqOtuTRQ2iJ1PbBHIqmgguDflv4NO4rIctVJ5f3mFa0ifjTIFgnbnOu5kowC6MEw8aJ5wTwU2uzbWLswp2NDFDjdqRRYlCuM9L0dJfe0NqEOT/BxtG8oRCSV9tbygGpSG6cSUIz112oj+tlz/fdoRLwD8RMOe14P+sGrZisDjGCrc9DkmT0wTrVnY76LwxZ7o2uO9Q8KWUFfV8LK7iQXcF0LNRFDSlo6jGmJlBmzpyFCGshgfqJw7GKgAwPllaz95+0eQoZ7ChQ7O1eBNR1t0l+z5spRNpfWprqQFFKRVBo2L9m1IC8BCvYhNVV6TZnyaa52aOBRhtuw8Zil/JTIbzi6xww5XdQXDZYwHe75lDsngbN434/AdYHhrAvwFrJ3z/NhtgQ403cZnqQNRvi0gWr/jQvUAy826sZWR/emFZZTsm2b1WBNH7T92oYC4Gctp8UYAJGNCg5lGfTWqMWAsy4z1kaF4V3Cz+2AQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(508600001)(1076003)(83380400001)(8676002)(5660300002)(82310400004)(70586007)(8936002)(16526019)(26005)(186003)(70206006)(426003)(336012)(6916009)(316002)(81166007)(40460700001)(7696005)(2616005)(86362001)(36756003)(2906002)(36860700001)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:46:27.7668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd777b7-6362-4ddb-1e4e-08d9ba273957
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3590
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

Fix following warning in SRIOV during modprobe:

amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:1150 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index af3a2f8c12b4..03a13771a9f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -390,6 +390,7 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 						int index)
 {
 	struct drm_plane *plane;
+	uint64_t modifiers[] = {DRM_FORMAT_MOD_LINEAR, DRM_FORMAT_MOD_INVALID};
 	int ret;
 
 	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
@@ -400,7 +401,7 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 				       &amdgpu_vkms_plane_funcs,
 				       amdgpu_vkms_formats,
 				       ARRAY_SIZE(amdgpu_vkms_formats),
-				       NULL, type, NULL);
+				       modifiers, type, NULL);
 	if (ret) {
 		kfree(plane);
 		return ERR_PTR(ret);
-- 
2.25.1

