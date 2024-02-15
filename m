Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AA7C48BC4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90B810E409;
	Thu, 15 Feb 2024 20:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRgZd4tK";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 683DD10E15C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGUfDR9V67U1WGeuG4q6dTSWyiVPkyJmL9586YczpKbb67ogWgzLc3b2QvRVTlReQ52mOa9shaynTvwIfNoWHwwECpYP8aidp+siG64JJE4rzyX6mlp0nezxKiUv2/XfbVffz4ECLI1Jszaroa+gtk06nZHrLn9RqX0hXyi2x2zu9bsUrOxz9FTDIFI0Mn3nhiGlsmHb6nIAH6QEqbBaY6BzdqFjPhnGKs4yzzkPhVSzgWwEwo1+qeGVccqOiu+HbZSUahv3UCP8Cv0ZlIMFuj8iHC1xIjtRWDZqhcYCg07UlCFjvucLUfavInrnqyNT1N8nbFieMYW2/3/TBPaRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo5bkA6BYslK3XLYZJqUcTYTqqQ+rOw4gSL6yJlnO6I=;
 b=Em5jI8wCqy3UmmktYCc0bL/7Ln+map0hgN4k+EV4aYQSMY3meks0XWKKD7G7Slrwx2Xt/1v2AwYHkCoichdIG/cDpsB8H5LsYCPRFk2JJ9VDHLQNE78PpP1CvbB06UkRnNTNRiOsaMxcmXbPlmWYK1nAJpU9BDNfsMFKJZjsJbXYPcbhf4/FSTIhrxOscctxjSzea3vYz3MopI5c17OxT9D0k80Rjz3FJ+TVD6P1GGayMYq9NzSYSq1AqYyKilGuLWrQ+xllB4Z+oT5bu6w13MMNELKIQ8cLN2jlql/EpdD+pgdyWL7Oc1PUTFczjCUdrHd75w689kONGZ0l66+XQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo5bkA6BYslK3XLYZJqUcTYTqqQ+rOw4gSL6yJlnO6I=;
 b=mRgZd4tK7j47XbBNr2QLVZDjCJibcrbTvaahHyxDFhNsFekOrYY7wxrzs8tQfDiqcdMArP62qcqDAE4GX8f+Hv/CDJoFXur9J4XLE708SMhK+Op3ogv8qpA9xxpXuNAzEhA7UgoGUNOooegLBh4H97nusOC/C8T4hCWrroN1CVE=
Received: from CY5PR19CA0007.namprd19.prod.outlook.com (2603:10b6:930:15::21)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 20:27:33 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::18) by CY5PR19CA0007.outlook.office365.com
 (2603:10b6:930:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29 via Frontend
 Transport; Thu, 15 Feb 2024 20:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:27:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:27:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add initial GC 11.5.1 soc21 support
Date: Thu, 15 Feb 2024 15:27:14 -0500
Message-ID: <20240215202715.415164-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ced02a-5646-4d12-be7e-08dc2e648a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kkQq3lmyCtsq0JBPVtoMPmb5mNhLDkjKJXTfGo8vNTLNOy5LD1sp7v7+fvbyv/BOpyfoedTjuCDj1zeg0iPcKlu3Yg4cPrY2eE45cRweMt3t2oeMSwMSCLeQg0aVa0dEe2zkayxxG6Dmn/4sBfo4ZCZW7VXM7jIyigKWxSr5X5sDEnSCKpPmkPgGYu4EEPAlFxDmJBu8BUfMC+knjVouV57jTjlV12M6euo43+KmUTgCrFuHk514CHxRn5ECMps2XkoUxcH9hWffefoVS2qiqTLJJEgFLg87pmc0zbx6+lrBIgEbY5kZ/MvVKQD9IBRXkrVZRIolms0ycVdgDcLCOROjvanCrd8ry7eGYZ/G7eIO6wfvVyVIzblmWWeU9Wdymdx+45NMemw0Jjo1t9BB3MZPXBBwHvOpQB2avFOwbaM7Krv67cbjFuQVHOVK+Gk0YdF7UDtzFeKivdCBMy/sZhzxpAVjg15+WZklY+bFQNx7rShZkDoqESdjpSb0DAlyer3lyRdZcNuFQ7gyTy99Y47CJXYJzf6KUIqXnSJDVNab5VCyBpX+AwC5FqD3IsTwWdSvAkOioECMCUV7DU0SksEpiTs3Botlwz6667nE3d91pnVh6lnN8eFPlbX5uwDshqGzCArAluI1rtrrml3abbKZmKOfnE0PFfK7kWfT2I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(230273577357003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(36860700004)(46966006)(40470700004)(4326008)(8936002)(5660300002)(2906002)(8676002)(4744005)(426003)(336012)(83380400001)(356005)(26005)(86362001)(82740400003)(1076003)(36756003)(16526019)(2616005)(81166007)(70206006)(70586007)(7696005)(6916009)(316002)(54906003)(478600001)(6666004)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:27:33.2038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ced02a-5646-4d12-be7e-08dc2e648a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

From: Yifan Zhang <yifan1.zhang@amd.com>

Disable clock gating and power gating for now.

v2: squash in revision fix (Alex)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5f81c264e310..71b3a0688555 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -717,6 +717,11 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
+	case IP_VERSION(11, 5, 1):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0xc1;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.42.0

