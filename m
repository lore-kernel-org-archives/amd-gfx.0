Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96776C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 08:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5EF604DA
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 08:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F5EF604DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E226D6FF0A;
	Tue,  2 Nov 2021 08:52:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296846FF0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 08:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRChmmFh4yldDjy1bwiX3q2CyxU9G2bY85rRgNAxCbR0WJvBxTifcyTPDeUZ49EWIb/ulL6NDxhbOTtfhpRtQUQ5tcGGU1occVt9OZikWj/yqVbmtVlubdvTIz3id0dhGgqegpgvb+l6c3hA+llgZv0ZLirMABIMMevb6ls96/Spyj0iORY4y/X9HE8fcEYIH5cSGd9QmSFzcxqEe3vnDjew4BrODKHvEw7ch83IUr/iVZfyp2AchsUvyVcZhcHfi7xn/HAHaL8nWzyIrzHXWfsm66CzyVUvG5ZdAw/WyszeU+U+V8CuKVK0tbanURLlC74YN1jFqI9Md1hIv8VjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N331n2kx69bA8ce6r6SdoLEdpFyCJGO2/i4JuKxW+WA=;
 b=WcEH/Rj8c/BrQ06uSPL1ZMZgocO3iz8MB/NGWDiAPaLJiQu8lLHhjcDnv4ZazgepARonP7BjZfqEUEBiNYGpBeUwvzOVrTywpwXmCUPrKh6xjwVauCp7kOd5HxH55pKpM+gyughKNT4EPq+4a9ijL8qSuWTlhUEcPP/p7kowMWrxqkGOfyU6TP61E9+JZAUdPp1o2DV+sS1G7emk90C+V3r3cE0EwY3IXU99lJXZyDy+Uu/rzvuirtxq86hIG2BR47mNesDiZtWe9yaeSbZ/Sy1nnu+oaAESyxaUbEnnAkXkmUiizVhoX9UXTNI2gpl5gy9d4vDsz/2kqhh9NuvjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N331n2kx69bA8ce6r6SdoLEdpFyCJGO2/i4JuKxW+WA=;
 b=uJHr4momONoup2AL/Zru3xScwQaBdObiKoaJRjQAk9ajpez3rc8vs38LgPSknt1quPqbSs+R9rIgAycgPejRtIHriOVNd8kY5qlBvpEW/oT2WtN9iE6LfOrHOnzrtnpceEO7h6BIRM+DpVwpxjGhTrV9u92/Eob2bkzpr/52Nxw=
Received: from MW3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:303:2b::11)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 08:51:56 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::79) by MW3PR05CA0006.outlook.office365.com
 (2603:10b6:303:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6 via Frontend
 Transport; Tue, 2 Nov 2021 08:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 08:51:55 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 03:51:50 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update RLC_PG_DELAY_3 Value to 200us for yellow
 carp
Date: Tue, 2 Nov 2021 16:51:18 +0800
Message-ID: <20211102085118.1465543-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb06c087-2662-4fff-f9b6-08d99dde0609
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42171EE8121F0AA88B104CCDF08B9@DM6PR12MB4217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oy4Rtw6K7L+D6WeS/5gacIm3DCI51tYQpFhq/ViWtQd8IrONn7Qr76G3BGLipIvZh5gWSIYdFcymnXvLwhZu0uEiu/4hFSQ1nPkyv1EW+6cxAEMqPQtKsKYh0wO1Gfk3NCgHQ56klSaIEMZTBxIGN4VTs63y2hszB86xOXk8h8K9B4q/T5tNoBGXzmI+F8k1s5lpO/I8JA3DXT5/jqEu8CTaH0KwvVSoMJ+YP2I3Q5aAN+MB9CY6TmVuVLnNC2ijm/jBc25HJtD7ilxZXpaQWf99feFja4QNa03CBNF7BGXII1TIq6LZPzxkFw96Q0Nhy71u2EJ5ltTWNaBX5wqWRHtqQa5v0pHQPg1/ZJ6X9z+ty6Soy5ZqOafDPck3h9R5YvJbb+cEqRMRqYcryNwlXYHprCxHtKm2j/rIK0997tmdidwVpjLg3L0kZMI6goVrn7sWHntc62WToJDBdiTmZ5yStWfq+QwT2Mc3Bfl++QPoxznhsqP0NzkLDFrS9fUyU+4Yd0eYX/TGAz8Gth+HhrEWlEiwibOdGB63Py3t7KM4S1jxDG9MjtCZwcn4hglpftupfZtP4pnUTfJFW/h31jjHPI0NNvIqDxYciCOeBuSmqxH5PU1tp39p0c5BZmX7qJx+iy5aFuvXJ56UIShzUd/T2fFdiuvpcUK5Z6DHrVfeHOkpAP64VrxLgZInBHHagRPab/YY3aIeyTFxHoJDEY0RzGI9YlLIJPhgi7qjeaI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(81166007)(83380400001)(356005)(7696005)(8936002)(70206006)(2616005)(70586007)(8676002)(44832011)(16526019)(186003)(26005)(36756003)(508600001)(6916009)(4326008)(426003)(86362001)(82310400003)(47076005)(1076003)(5660300002)(336012)(54906003)(36860700001)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 08:51:55.7524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb06c087-2662-4fff-f9b6-08d99dde0609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

For yellow carp, the desired CGPG hysteresis value is 0x4E20.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 90a834dc4008..b53b36f5ae92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8316,11 +8316,8 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
 		switch (adev->ip_versions[GC_HWIP][0]) {
 		case IP_VERSION(10, 3, 1):
-			data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
-			WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
-			break;
 		case IP_VERSION(10, 3, 3):
-			data = 0x1388 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
+			data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
 			WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
 			break;
 		default:
-- 
2.25.1

