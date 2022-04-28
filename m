Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90D7C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5151D10E9DD;
	Thu, 28 Apr 2022 18:45:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD92010E996
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz//GjPwX4/9QDrqfLrBxJBbEb6nUbq6toosK9P56KCOa1ZvT27euAnE/IYfbmhMGoRiR1rHQ1Aw9jREeqb62mbHJR1ugnAalgdQGo9tqo17i77QYfoGw/IdaygaYF4SE10Ah8Z9eFHm1LVZeOkOpbwwdXmNHC++68BHc+LfH70EqC9f5/6Ji9NBDiUFTAR6UtG8knTkDxgTUeqN0GN7qJ3RiLOn4iKg0h5FNGkM5a+dO/RQgLeeJWyOJKIiiBj+NEnGy1n2wQf5Hd1gaHRx2ox1+NZhOM/+ol1XwvQ/VNwd4mm9BXDOaXSQaMFKyCfGA9SFFOBAI+oNr/WczMIarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoUPZpCMyePuxvP/QMPqcrD7+sj7beu3OTMPCKGRJSc=;
 b=OI3HwyU4shCjJ7sDimYd0MAHNjEOeE27KvEdKsNJkS3iwRv28NXjunFqGoETYwOxiPnA3tlD/J/eDg0uSBZBQGOvyJJxF07Z5y2iW0mwJ7h+PihxvU0BL88VXBrh95rws7PJ4q50bHWIcUyQZ0mI5SDROJbw06bQhSgJasOnRkGYBNGTx+6mM6u3vs34Sw37gN1EnBGfOdAszBT6WFP3rIwpe/EOAcBBacoai2Gz1LMxgz4tFPlPvwiHkIXBe/CDRaR12e1k23tM+pxLpDNgQnJq78BFweJFJpHADJTTzEImpcoGsCVXiCgjZ5OnXKP5R4ypidvKwOCWRogjWPIx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoUPZpCMyePuxvP/QMPqcrD7+sj7beu3OTMPCKGRJSc=;
 b=mFhTmcM/4jPi6QkqFyAMYsQXSZEdx6kYfkJeOptaJOMvggj/IWrAyViqeo9uvs+51Vo+LAF9g7gi/rtbILh2oiroj8Y+LAK+uwdbDRG0pPg9AjgdWy2hOgpKEWb8CG5vQ0poW3m4at3CpDxnRoxGYCKIEjMcRtwKkyHWDv2cRKM=
Received: from DS7PR03CA0203.namprd03.prod.outlook.com (2603:10b6:5:3b6::28)
 by BN8PR12MB4770.namprd12.prod.outlook.com (2603:10b6:408:a1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 18:45:36 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::58) by DS7PR03CA0203.outlook.office365.com
 (2603:10b6:5:3b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 18:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:45:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:45:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: rework psp firmware name
Date: Thu, 28 Apr 2022 14:45:18 -0400
Message-ID: <20220428184520.651971-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428184520.651971-1-alexander.deucher@amd.com>
References: <20220428184520.651971-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 346cc4c5-2b3c-4de9-071d-08da29474889
X-MS-TrafficTypeDiagnostic: BN8PR12MB4770:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4770B76C785A5651830E5625F7FD9@BN8PR12MB4770.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfNkv1WJ7df6EJRw6CnHc5gr1EajfiOSWgtTtmLfD8mn9MQ3hpGs8u1LztEyL4MuVe2trQiANYW27LYJtjSJ+490AQXVMITe9Qx8gttW69hpVTjREAfJj9JgKX2BOi7Z4vS4gwGewxD5BXMxrnxu5f3P8DJ5bH2zHyWYCtahTa7q+i5eDPdvO05ZsWOda+Qml4Wn0hyrTl9MBIWj24yWD2+dyspvZUOOZ2Xtw0/43/m9+v+/ToiRYCmmS6Og9HjNGix1jJ+Tz0uj9fRKjg49L5UEwcm+Uk83A7oMRuHHgLCUHSwaLV/PdhYXCcsH2ojg3cO+CM7eo+Q7ZnpbsnViLTVRv5P8IhDMJ+OaDuXaMV8rg7BcxcAfwc5mr9mnG71t1xLu14ULwC9O4Ys/wOR2A4fxXq0W89+yiAIJ/oB0YqyWEXELXZo8DVyIUW82j8+f8/AeprLflJRH8TS6+m/Wep9+jcr464NgkevQVUvaWlvE9aiiKivxhyPKsMzzRvAJbXyCr/N0VOQnbwXVghvmhrz2gDtyQwNX5LyTlWybZC8wsxzUvVzcxOKcMFNfSxAwimjNK8UFihBuWNVGRy20y2j/h8vJ0Wj3jVgmaf0L7PbcQD04n5Tdq0pnAGZUD7HEjhEKb1VN2y/uXUT8T87sy33hL+DBRqZR8+Lf+cAv/DTIrDZSYYheWu3dgfBxb5cS9UVoRXCPCsXOFZYcbrslSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(6666004)(7696005)(86362001)(47076005)(6916009)(356005)(81166007)(426003)(186003)(1076003)(2616005)(16526019)(336012)(8936002)(8676002)(4326008)(82310400005)(36756003)(2906002)(5660300002)(316002)(70206006)(70586007)(26005)(36860700001)(54906003)(40460700003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:45:36.1609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 346cc4c5-2b3c-4de9-071d-08da29474889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4770
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Use the new helper for deriving the fw name from
the IP version.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 024853eb1cd7..8d3cdfe17f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -53,6 +53,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 	const char *chip_name;
+	char ucode_prefix[30];
 	int err = 0;
 
 	switch (adev->ip_versions[MP0_HWIP][0]) {
@@ -63,18 +64,12 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 3):
 		chip_name = "yellow_carp";
 		break;
-	case IP_VERSION(13, 0, 5):
-		chip_name = "psp_13_0_5";
-		break;
-	case IP_VERSION(13, 0, 8):
-		chip_name = "psp_13_0_8";
-		break;
-	case IP_VERSION(13, 0, 0):
-		chip_name = "psp_13_0_0";
-		break;
 	default:
-		BUG();
+		amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));
+		chip_name = ucode_prefix;
+		break;
 	}
+
 	switch (adev->ip_versions[MP0_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
 		err = psp_init_sos_microcode(psp, chip_name);
-- 
2.35.1

