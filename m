Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD47C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 19:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2115B10F191;
	Thu,  9 May 2024 19:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwqCOhZg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03BC510F191
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 19:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnN+cV1sHdrKEqk++s90QXFZM5OSXODLZr+ybFnKG2VvNG8uU5j2Z9sazoSFMVxIPzheWLCbBUJxjgvaK5WlOyN/bpf7z+pf/TZF4dF+yCdYZHCetBq0MLJCf3gLC8HRxlKIfFj3heIgxP4vRCZxRCyRxml+dHE8gN4Bl1RYwdptiN23w0mS0jIAMk5IDeybp6VowQY7c2umBCW2QISCbq5qSlOdlVLMC8lmm/WFZZz8+oZOlMzIfaLUHCeHuStJ2h4czflKC+i+4I2/WfwZBq6yhG89xTKbHuKO86O5isX4N3h0udch/3zd72FJNM7hDk6Sgv37xjxwHJyxWHaiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMSINbr1cF4+iDrSigsLiQv/Pj4tKNGlild+Os9tfNQ=;
 b=NrXAksHtqlTVL/6toGZiWDRS3hC4uJhvOfYUj5UUrRPK0BVdtb1MSXVnIu+GlLC2IS1mzMx+LXa8fSJnI84sv9VZrjcbHfip7Ecgeqp1HruMWGP/S8YyjrGTaCb5Kr5QH9qbxUnB7M1+Ftoy9Iwib0LeB5QskvD2W01cyPLcO/IZA77pmvj6YRkaPQhkxN/RjxpLOzGawY7O+exW+s6wPyfh4Fa5WNEchGZiKP2m+QvqXQ6rBiLocz7rPmphwy/n2YchiDbEq8RXZukwY7GC6PWFiA2qtDeyLC7hBD3ulZCDsMzxezzOLN3nrMi+lT8baRGvikHDdNtUyAeQaDy7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMSINbr1cF4+iDrSigsLiQv/Pj4tKNGlild+Os9tfNQ=;
 b=lwqCOhZgs5kAcJQlPY0A8Vw6R/OX8lox/0w+wc1qftXPfHv2j/sY1bWVwYA6fbynuW7tGBW4lBpupvzg+LAum7lOGzBRKUImN3VVfNEQVeBHFfhCwGANulAlfde44zUh0bAaBNsN0/7J2Is7WpuLnCAxPhZejQciPOwyWhkgXcY=
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 19:35:48 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::6b) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Thu, 9 May 2024 19:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:35:48 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 14:35:47 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <mlimonci@amd.com>, <benjamin.chan@amd.com>, 
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH v2 0/3] Add ISP driver support in amdgpu
Date: Thu, 9 May 2024 15:35:28 -0400
Message-ID: <20240509193531.129092-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: d05e93e5-3182-494e-992e-08dc705f3a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Ia3Obw0q+krzaowv8dfrJOd4z/BjlszcQ1/UGeN9btTNNrqhhEHdvm1DJen?=
 =?us-ascii?Q?mXwEXt2S60aqYflkW7cyfGSc4aH9xOzRL9NoWfOMzuXqg5uOeDvT012vMLwW?=
 =?us-ascii?Q?l1jGLZ93fQDtNqsT2Q9TSs+S1jfiJpiaUGv7WUlIRqqi4KmzR0pJttNPJXle?=
 =?us-ascii?Q?6yNqHIKJG7WzmAs8tOwjCBYPbbC5i7P3uXv4bjXNAkSh5LSHj0+J+8aa+rLR?=
 =?us-ascii?Q?3HO4ez6/VGkoomLie+QVmAfD/hoOuZdKPNX5r5JVeFRjjYxerRMaB4pOB4BK?=
 =?us-ascii?Q?djBFo0jXxYahQXkSF1NVtKYTTTLUM86OZEPguhDIlXSWCnzYW6MF3/HGBqQM?=
 =?us-ascii?Q?tXAnLOt65NLaKKpj+fLzlg2FApJSdLkVKd8fGRFuZb3vLPcJ3Nrs+0r4RPzh?=
 =?us-ascii?Q?SMmaB0L8/GKgq7oBzTjtiT/g+HRnidwObQ08mac3vIq9jkxQwcCTWepj4w/a?=
 =?us-ascii?Q?/djfTbUYW7+sZUq0dp6SMyFcwTHSmQQdBVgTOsTG75hG6f4sxnlNKLyQiW8f?=
 =?us-ascii?Q?R/qqEPUTmzbAVxwFJ8BERTMOr1sEGBg97PldvSG14CQHeAHFP/GfOp3N1gGh?=
 =?us-ascii?Q?Rn/j9EobjB7+aeLNtTjLIVeFCjqY8+gaeenarnRIgNkYetSdj16M9ccaUSaA?=
 =?us-ascii?Q?yBmBoX3P/ItB9YfjFEMXpUERtO3ADnVAxGAeTbpBOLjP7XCbdlWruyO5MVxb?=
 =?us-ascii?Q?jwHS3cbKXB1o2r/+lCqwQqOfD+PIKUNGWQXFuGG8aNTP5OwsJNIime1Cm9Rf?=
 =?us-ascii?Q?XZc92I/fCDoNOlmiZ/IHWIcDth8sUor++RxNpTcb9nACOmJ2Zj+eX/rnxfXF?=
 =?us-ascii?Q?q3XdtxCNAyutlhH96svOy4NKffnL3p5bsvOi9Tge44FLo3BnBccr+xjY9ErJ?=
 =?us-ascii?Q?iOglOG9auGm3iOVR/BdipMvdsoYg/Kvy/qQ16NE9KGf0zPJ7seMU9Q4ooPMK?=
 =?us-ascii?Q?O9vWZPz6dFe6lSj9Rw4lLhv9iqvsdQa5l2AM0rPcnYTwSDO6E+c30IafXMhp?=
 =?us-ascii?Q?SUFwh/ZPBThHF9y/9qyGpf3frIwRl518Ygus1kOItJ5EHuBHt/qv3IFRj1HK?=
 =?us-ascii?Q?dvNbkuVRQ8n68FS1bm2xGIL5Oe3pK/B5+AvSPWPiTOf+pJO2h9eQYKnsR3XU?=
 =?us-ascii?Q?Sqvq2x+i2jBczFB8d3ZW4RBy9P+iIf4e3yP4LlRIkW99cUKHnuyJWd8IRAER?=
 =?us-ascii?Q?wV777MT7VdpMu3qCaGg18aJS2G9cFMyu9IeDyLOE/gFOsom3INX5U47VugG1?=
 =?us-ascii?Q?CkFPJzv2HNg1hi2cl9AHiUkMbFlIe4EqKYXm0Npc6YIr1axAp2dNXTntV1yh?=
 =?us-ascii?Q?7X1hM2r8KDWMEYCnZtHeT6eQIlOYUYUb6OdeRd/cmihjbGJC8wKIQhUrJZKb?=
 =?us-ascii?Q?SQBSc1ekl55NKIe3ZeWOB57YBb4+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:35:48.2584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05e93e5-3182-494e-992e-08dc705f3a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

Add the isp driver in amdgpu to support ISP device on the APUs that
supports ISP IP block. ISP hw block is used for camera front-end, pre
and post processing operations.

Pratap Nirujogi (3):
  drm/amd/amdgpu: Add ISP support to amdgpu_discovery
  drm/amd/amdgpu: Add ISP driver support
  drm/amd/amdgpu: Enable ISP in amdgpu_discovery

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  23 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       | 287 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |  54 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |   1 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   1 +
 9 files changed, 382 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h

-- 
2.34.1

