Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD52E77178
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6B210EF26;
	Thu,  5 Dec 2024 17:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JNsDFi61";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B7A10EF26
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHTlo9bVSVe3dVWBu4E8oUUP29n0w3yyH/FM210iQ3hwcj9818odWIaxHP2dq3TwYGYbRvJA/qPszLpOo0x51ADh4KQrgVA6P/VxJqam/hsnGVzj4grF8YOt707mZ/QHJPNmeg02jI+MhYwna8RNqHn+4hgxWnm/fCp/EMueo5Nw4EDD2Kn1zGyJI1HvKivCiZykt9IyC1VOS+Os4XGYILsTaTHQZa0ocHw0e0indJIpb++BqF1oSGyoXBCPokkoVBMIJbPzgR1iFzEnvgJUnNc1fRm6YOeo6Djyn19Q0EB6xJCAUzE+X6fC6P6xI2bTvXgpLNDNUikk+7/GZhTUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5+Nw+zbHLGAgQFbsZn/ZwurHV7jaXJvitBqKhslvaQ=;
 b=n7ensN1kwqaPuI+ySB+u6abMvXrC0Kv8CWtMkHtcvdAhTz2Ok6OJcPOgihe+wIVCgelh00AN7taRflVK8tUOzWgKlq5GgOAAfNr/hcsNFXYfAmE88PxhVJatP2eP3S21nR7h64NHXK/5usi4FHZtolpOJMR95UTqbtfPmsZHr44ORJxxALzYdykkaH+nk1ONfPqhGrJ/eBLQ/PmL8eJY4/C1dyIGKxDaYmYVI3Oi3aNThvb8df+VzwD0ZghR+qbAAijcQObgi78kt0sGmJoL2SSVApG02ngukEr0SH0b0Zo+9UtSPwSdPriSgAZnuk7GXw5dojByedCgV0tDUHACdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5+Nw+zbHLGAgQFbsZn/ZwurHV7jaXJvitBqKhslvaQ=;
 b=JNsDFi61QSH7fw3zkhAlRJD+AOlwovHDw+2INsZj2U4TcrUEEE0Sz1iGkNxySWLDB3D25s+ME2jpb+tzZKNm6DjKy8EnftN/AwYF7C+IOvMrDqeZbNrmbZV1f1hA//B9UcFrhobtGTnZUzrOudlcok2D1sKoPO58JYl24xMGmm8=
Received: from MW4PR04CA0195.namprd04.prod.outlook.com (2603:10b6:303:86::20)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 17:05:20 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::23) by MW4PR04CA0195.outlook.office365.com
 (2603:10b6:303:86::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Thu,
 5 Dec 2024 17:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:05:20 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:05:18 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd: Show an info message about optional firmware missing
Date: Thu, 5 Dec 2024 11:05:07 -0600
Message-ID: <20241205170507.126585-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ca28d9-3001-4156-a72f-08dd154effeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aAxNTLAPcmMQGqY+s7z21WKo6txsqurVaa0Mr2qbcyAmZ91IcSgbl93KRBi6?=
 =?us-ascii?Q?6zFziM3wc7YMGeVrx+ctQGL8DJNKoSfDYUjlFVRy5zaolrbtrIugiK10z1cp?=
 =?us-ascii?Q?nXSIp9b8zfdjjEm3WrclCU3L+w5UDebSaqCvrwMea0ejDjpbi7QPMjDF9gxR?=
 =?us-ascii?Q?anpC2cuzgglgzVLnOYrIss5rmSVQum7093qNsHQ84ZOdVizbWqIkubhbMdmV?=
 =?us-ascii?Q?AgqfodabEZe0avKzgzrKagtPzWQ/5b0VX1VnVHTTcEFZxzlEVl2f761opgba?=
 =?us-ascii?Q?u6dBXhYfmjfKzWvFRtvtTE2U3gwhsHP9DkW8u40sqlblPEWuUs3S/3w5HEYb?=
 =?us-ascii?Q?qKA8Aosp3Q08dpezn9iS7zJIKU+wWMxn1PGpSVnqPJYUGTvRiZTpfepBCOKc?=
 =?us-ascii?Q?n+F5sLId895bU8MlSEZSRKL+zJaOiFHTEdTU4AnDXVr2a7ScLboAbNeJtjOq?=
 =?us-ascii?Q?yWvR27qtLL2FaMC3Di7tt14yUmEMqc6rmscw+Syg56XlQ/wmjVZynuVFB5R1?=
 =?us-ascii?Q?sB33iEgDr8ZqS+oINDZZWbH6VWE0M0Fxa8jtPBYf97NdhHB4Yx+6yifbIf7w?=
 =?us-ascii?Q?kCWhqa7y6UrCpJlYAu97HpxzJdOAA7Sd8Ja+WU4N+l9fbswczuZMPeZ1BPvC?=
 =?us-ascii?Q?z2S4Rds23/QXBdZtM/RoAG5kzbok52vpKvxF0gGS0svwyIx6Gs5cVlpHUO2y?=
 =?us-ascii?Q?ifYKjrSrMcxbPbl7c/k/GSUxPlITs+DjX1BeWZ4zy8QzCsDINtlPUG5AYZ8O?=
 =?us-ascii?Q?w97ayR61wLgJwcbiTQVkr+E99JeYRPk1JjGE112NRD5v5jCQ9h5+Dv8FdEaz?=
 =?us-ascii?Q?QJrXb4au0knZD6JyBL55Hbhkny34Yv8jzPrBM0In8/7JxwRW4FYbH3+L/Bca?=
 =?us-ascii?Q?55w0CwvdfNmizwD3sqla6DqnbG3pfn0hY4cSsk0eX4fSvODY3TopTDmtmNH3?=
 =?us-ascii?Q?b4bbRLI1fa4gduQRysJFcWA0t0A+dRA7nXAAyBOAAuDVNiByYP/JPiESHNUN?=
 =?us-ascii?Q?kJdmpnn7caVH76phHY3Tbpk/VfdFMDW6MZ0WykJNsyztAI0hVYgVHp2umXS1?=
 =?us-ascii?Q?cqY/26BI9Kc/SPCKLlH3/lgeP7mUZj6cDybHL80UrASJcMEa4gH4dn+NjPxJ?=
 =?us-ascii?Q?0WfhpLZgxUAtPK6Zc/0c7G70tmIAJ7j5ugLS+dwPUalrPlUXTXFFq7sri0YC?=
 =?us-ascii?Q?ED+cuECAyGNGzTkmr6aN8tXzXjeEvXHycyTXEWh62+yMnviUuMfg2UPA6jot?=
 =?us-ascii?Q?SnaIE1HEobN2Mnbm9ZFWuOlFMNOA2jY6dI2+/rGog95dwJ4ulU0vPofnMVK8?=
 =?us-ascii?Q?BqmLY12Xq8z3FD+UR9/NonIU1j/+bqG3CUXtm+dH8Wb/ZFkvNF7GKSjD0eSa?=
 =?us-ascii?Q?0v77MF5Wdb4Wn8VdLzI7rAorJ6gjDKfe/ubD+BnyB0qjmUQa2TTCNUMyY/J4?=
 =?us-ascii?Q?/c0AcdJJDtyJIcvpIDNcTYTmibFqa+HC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:05:20.0182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ca28d9-3001-4156-a72f-08dd154effeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
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

With the warning from the core about missing firmware gone, users still
may be notified of missing optional firmware by a more friendly message
to clarify it's optional.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index ffbb3377e0f6..cf700824b960 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1459,8 +1459,11 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 
 	if (required == AMDGPU_UCODE_REQUIRED)
 		r = request_firmware(fw, fname, adev->dev);
-	else
+	else {
 		r = firmware_request_nowarn(fw, fname, adev->dev);
+		if (r)
+			drm_info(&adev->ddev, "Optional firmware \"%s\" was not found\n", fname);
+	}
 	if (r)
 		return -ENODEV;
 
-- 
2.34.1

