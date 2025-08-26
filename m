Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69225CA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F13510E5F4;
	Tue, 26 Aug 2025 07:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g5lEgi43";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F5010E5F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQRmTTYFpqAvprNUkmliCSyjCgU0+TgQ366/7FA0h7xMNJs1Z4XNkCy+aNyyxnMDMG+8vluN+O3HPn6Xp2BvcJAsz6lNwcpZQs0IDx2UN0v5sjzcM62Mrx5rJCGjFRj0QgXQbV4W2nWgP+0ppFtwtbOdNOy7fu4yUhSMeSdv4EPj7MVSoFcaOBziQRu8za7qW48INBdwHXYFHPPPHVnXEqEp9BH9xN+mUmr3pf8TqYVTh3uMsD6h1AA2GaDbDIzdrxEz2ULbDFHgNdw1pluZ24lrl6wxF4VyAQnU1hyBsIA0aqQyew8QsyWWC4Sgb1zzzj5FllNNnXVPhShLyF5ojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEZkaZFzssbYJaP5hj8FPmoYiU63lgqoq/smH0UeTkE=;
 b=jbioBW/6s22DFTQsFV3KhI1NgWDfEkJKtcWr9jhKn4gdM6mRvmQ4GnTgzWAxzkPgG9k28itsoPYDc0zWnOZ66bok7P3hfxjbdEa3gazmK4bdso69g0pJ6Atnef8vM2FNOERmUP6L6x2oTca0/3/X4FVvpvgDvJztTT4DesfrEhV2bQdSY97hwf2s6ZyzzTyG1Sn6ejfZBa5tgexGOLaCevQwYaLEp+pRUEWidQIQ1/7tziLn2G8oiP1aTSy+6IhE1a/NVDFWlSOneBPMFgeVHr6jambcqnLySEn5OGGVB39f4LvqlTtVY5Y/KoUs2I6ZqOzUnYXQfj7+A+QHGMD7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEZkaZFzssbYJaP5hj8FPmoYiU63lgqoq/smH0UeTkE=;
 b=g5lEgi43PA7dlOVCuV9kGLdhE48enO2X8MQ9aLcSTxXPNr0bcuQE2GGZ4JjRzAz05DXr0d7IeGecXykqgTDA6rWtmAuABm4JOl3vY7bwMC9D6BBuZSjLZ5RUE3AzPpIaNfrtQjcZ1CEY9XRAX7DJTDrIluxwRsBoVPbwT7jnh1I=
Received: from MN0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:52f::17)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:47:08 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::92) by MN0PR03CA0015.outlook.office365.com
 (2603:10b6:208:52f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 07:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:07 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v9 05/14] drm/amdgpu/userq: extend queue flags for user queue
 query status
Date: Tue, 26 Aug 2025 15:46:37 +0800
Message-ID: <20250826074646.1775241-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: d11739c0-3d69-4101-40ea-08dde474c1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dZeeguvekZ0EoknOjHaoorIQIfXMCjGZqPOaJ1yHkzo70f+RTn/3o/7RXGqu?=
 =?us-ascii?Q?dhQ+oUjiPVI8F3XfE+FRp9Gwwq6/OdPCr4J7qyt/aGVk7zD+6tGDJE4dtAGu?=
 =?us-ascii?Q?zrjC2/HVLd+Tiu4+04Clpg3+Np6Cuc/H1Bp4X5ZbU1fs/C3yVhGiHH5lNzKq?=
 =?us-ascii?Q?+vljC6083iVswNAbtDqLaV6b/XFTXJ1Qy+iHHZLmrvAka+4Isi5IhZTTERNy?=
 =?us-ascii?Q?G8NFcAQXC750R1HgN/1cyjZg4GHQh351pj/CFMuj0G4VutyEN2QEo+HBTaBl?=
 =?us-ascii?Q?iJ4/imz0o5zPccxg6a0snzkHY2k5TrBj5YD44b32CIDMjI7ujkOzNXsmWmQf?=
 =?us-ascii?Q?CbxB6AgoDv27YI4eVPIw6st0xCM3IAOBedS+keUM54FX1csHU80IMzKovjG/?=
 =?us-ascii?Q?dpb5NH3b4Q/dob0rYPj+JCCX2PdbUW4HfTCUoMy28dRcFvj6ri1CtT+BM02c?=
 =?us-ascii?Q?dbB5Xqi4am468ORf3z9UXPqc9O66n9fBQjh9qxRZYjOJWMulhGcf+8Y8nDnc?=
 =?us-ascii?Q?PvCyM6fTmEvmoLUr32EhzWLzUu7YzYiIkPuvn4EC/ZMVljlJbfHuNrL6xVd2?=
 =?us-ascii?Q?MP6I7eM3LJcag6DeHfdhD7Y7u2CP5wHP7PDmsOZGtnN0bOuMIUCeronhuvCp?=
 =?us-ascii?Q?twDcmn0OE3pJvU0pQJSu56Wj7Kqbmny6zv5dpdKVV/8xu3QWZ933a8zwlA9q?=
 =?us-ascii?Q?k2dNh1Szm8cosve1WaN7TjNJEZeGdvIju2i5wmFOBNClp6w9C/kZQwJboKJQ?=
 =?us-ascii?Q?OSqdrtx9kGhEaaqfTtjnTyIwFrAQpbPpECAz3KpWoZ8/ybzBWUlRWzGfdiPC?=
 =?us-ascii?Q?GoXDeWn5z6pkXBmsQoeCrYFUps16vYjC4ibAJd+5RH1eE/TFPuttFUw9tOfJ?=
 =?us-ascii?Q?7UXXwVvkHIkwave5/VZrLtxqA1SCiaHa5enF5R5HYViCvyZ3TROpUbYUaJws?=
 =?us-ascii?Q?1Iddp/JByqqxgq89aGYWrPDyhCl4oV7lDFPefnNQ1C12MiHa1mw3fG2oDPzN?=
 =?us-ascii?Q?IggW1trnmUqZzx85NZNmN8NfWYMifL8vrdXnLFVy1q5s7g8W4bPIWRyR4RBy?=
 =?us-ascii?Q?STSRJKiVPwwZXdNcsSpL3cPWO4hjHGRQgfZ6o0lM0ei6B3CFUWGOxPa3nGLI?=
 =?us-ascii?Q?2vkV14Hryty4PtlQpXqaSLCaUCYWA8dWnhXjdUVzlnmtjCAMpY6hu5VvOqyg?=
 =?us-ascii?Q?WMX7XPWe4hSu4Wd9jhHDiogYpYD97xVa2m1XiV2Jx+RJxXEnfA9+E5p5FkYe?=
 =?us-ascii?Q?l3lwqDJg/vJS9yyKBi6aGzc/YrVQ7gh0JcmthVt3cRWz7C4VhFrQAEzC8UST?=
 =?us-ascii?Q?jbQqN6I0fq7ERisdnAxdH/3FvH7QTRs1vlVjKGw7PWsmgBexOzqtEiu1Afzr?=
 =?us-ascii?Q?lwrJTxYn1DvXCYrTkKf+dDnJXNGYbdRF/XqPxLkCdd5vPmkGCvDeXrz+8uVR?=
 =?us-ascii?Q?7ZgjtdXF7HN5/09dszigYE7f9aFF+vva4s7eXcFM6mCjYjAzWC8ilXSuIVmE?=
 =?us-ascii?Q?J4644LwwYa6YMjtjws8Y5VJwnD7JcF5Emika?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:07.7968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11739c0-3d69-4101-40ea-08dde474c1fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
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

Add the userq flag to identify the invalid userq cases.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index efd0d2356077..3c536c8517cd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -346,6 +346,10 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq input argument */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_ARG (1 << 2)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 3)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

