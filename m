Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EAEC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 17:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106E910E5E3;
	Wed, 10 Jul 2024 17:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fkjtm7LX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A55510E851
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 17:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA9CM+O04uZfhWa3/PhRh/+gDN2pUlqyTqgQ6jfg1UvbPp2yTHAGfyKCjsFTY4ltdJsIYW01Ih7v3Be0sk9GdqBd/cu0yGFjQMK56SXwgT83SVWndRLIs+61mcDMsidDQYrOBug7macsjU+TEbjmGPKpm0EVyVSHVs1V/kLoL3gcntX/TrlYF9c3hbvdHkIUQYMI+VYHkxTRmA4dkygZR7UEetAWTdOULS1J+eSuN+BCa9rxcUlsQz10horRNeZmUv+0OGX+dFk/znN2qFMJpL6BR7PZikbpgdaZ5rsYBxrPJTyyJaaN/hV5JTUtoXQuLJEh81fWezJZctc6FPA/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8b5ZRezw2HR4g6S98G9mPB5brc9lg41/t2xtGN6cxY=;
 b=etk/DFB0swD84igyHoUOB5LOf6cpv5/rf110MS8UIuZslQLJd0gSKyleOCce38E2BJukU6TrKujQROjUEHx7VfXRpZ6wgUJEZ3gzQQgS7ENvk8dUeXfbYwFDd74KNvDWLRg1BeC36EkpLccDpS/59nG+dRE1MEtqbLc+k4uh63hw3AQba5/Evfjt9gx88RFiTENNdnuErxkheybWI/IStWTxMOcB/pnDFgo/L+lghIfcLjgYbJ80x+SV+CJWGVf2Rf3nBTVQLf7DQcv7dLZREr6ujMA7xBtlX3WwelNRwPHoYG7COsyZ5J7EPZjPAHeRb2+KBfafaD7BDi6NN5E6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8b5ZRezw2HR4g6S98G9mPB5brc9lg41/t2xtGN6cxY=;
 b=fkjtm7LXPipJVpd+HKr2B4kRfIyhFY/4WitIymuO4z8KQLJq0KTU15OMDWsGek964Bmjo2E96nCHYklGuxhpKO1LjDjBRrDNYWvcyDidiR02ua3uX6umNPL0a1UCeVcpsIBxaKKxCe9uqPPoKsTxQYikZ5CA61/6v5C7ZMyxg7A=
Received: from PH8PR22CA0019.namprd22.prod.outlook.com (2603:10b6:510:2d1::28)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 17:34:17 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::16) by PH8PR22CA0019.outlook.office365.com
 (2603:10b6:510:2d1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 17:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 17:34:16 +0000
Received: from AUS-HP-PV-STX4.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 12:34:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Fail the suspend sequence if the GPU doesn't use S3
 or S0i3
Date: Wed, 10 Jul 2024 12:33:51 -0500
Message-ID: <20240710173351.23610-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f75b874-d053-49f7-fa95-08dca10685fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jRz2AFvRNe487BNzG03CipUW4L4QWiwVK18eQg3ZFD7QdFB0q/HmAheSBRvR?=
 =?us-ascii?Q?Pg6W5ZXfsgPOr0myfYGLfswinvj8OZ0Wu656bR3wklV52E2tu/6gJSWb93iZ?=
 =?us-ascii?Q?rdtQSWyP5G5JaLufhzM3ZHcdzZC5vBlSkKsDL0rPkm48OadaToGwuYZp1B+s?=
 =?us-ascii?Q?nTsubA8wS812V1MVHLEvamlnb5hwfiCkFfA5Ge4e+qIQEa7WUl0GFxE5VoWP?=
 =?us-ascii?Q?Of4kV+GqSrxq/7Noj/vpqbvbQDGqu+8OfJ+DU4EhcRynD/m2qC1q8+REaagc?=
 =?us-ascii?Q?FIKLTKfXMlzHTRZRADL3yCr2F3Cpp+q7f49zn5nXOJvR/vEGelb4z/82TVX/?=
 =?us-ascii?Q?IAGIQVohv5410m3CkUoeHiJoW5ERxqdbMNCBkQFGTGJgw2D+jfNx327GXlsn?=
 =?us-ascii?Q?iHDdRnVDkJODlTqYf1LlSDc2mX1MD8z4EUS6RIu+7j0ftvjXD+tMD12V3Dm6?=
 =?us-ascii?Q?k7sJ24t2v2oKfqihebML6QOIzkXhkxUTVjnsH2zC+LqpnaSX3jWLCrC65Uiu?=
 =?us-ascii?Q?v2Wgpg1c4XMrrrYMWptpNJICfM+n6QKdYMxWT6J7OJVEMrdYlblmFxzaiqs2?=
 =?us-ascii?Q?rOebM5mC4BZgBJVWIIeP/x67n70tRmiQgE1RZC2MiPXUxzSRgE8d/euR/Jc8?=
 =?us-ascii?Q?QG8WUqxw5eBE8XXzETBlx47o/NZwY7EWZGk0aWb7qXRwCpCleOjP2GIjBAom?=
 =?us-ascii?Q?o11G1Nl4ZGBHMiotbyo9M9O2VfZ2l370SOP9oBRZXLQ383M/Yyoalz2Vnw85?=
 =?us-ascii?Q?GhNvxLMRO5tlSXZuS9aBW1WKCFMK5cUSItF2K0XsQxLENJ2tVHoltYobx3z6?=
 =?us-ascii?Q?sYczvA8cNxQHCRDVGcaBaze9MZGmxq/DxavSDvI/6CimWvovqj2FKy8oihF6?=
 =?us-ascii?Q?YpjFu8mHPZzjY8dqAWTo9eoKlHaggKFcZq2KR3qEaEq9JkFIGqGnVIkjp773?=
 =?us-ascii?Q?U+7f2I9mvqCXC1JlH6xYxB70GDejG8AiTWQ0as7JlpdP6BBvhhE2Qua2KIBd?=
 =?us-ascii?Q?PEU9TnKDn9pPMyyEZcywCX0jkCZtg47/EonWiK4HV0pBnYnBonojb1BYt1Ah?=
 =?us-ascii?Q?Tw9QX4H21Knng25FhFcjbkATlV0BXkajZGi6oLGf3J6kxuG2hhsRfaQ00eDu?=
 =?us-ascii?Q?Q+2lK7RnVNgxk8Uff/FFLosA//+c4gDP8N2ugG2ZJWW761zUyCKcqZOKyt5p?=
 =?us-ascii?Q?um0KuV+dRI+VqqGB5WgP7GPYQD0eV/ptmazDkLSsTD6ogDtKTzbYHCsXlsZt?=
 =?us-ascii?Q?bIYpIED5GgnMvIEvHOCw2VBTP7f9kZKa+06Y+hxtrjjCQvTSvtGnFQ7FBF3L?=
 =?us-ascii?Q?fenlIz2Sc0QSC2nlFNYQ7DGD3+xS/535q7Zt5k5LFh6xRMh/T0AZyib44Gy4?=
 =?us-ascii?Q?qQtX87EiS64DJ4uslsJu/qOQC1KQaoi609VzqN7WWhBg3so88g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 17:34:16.6754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f75b874-d053-49f7-fa95-08dca10685fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

As part of the S3 suspend sequence dGPUs will evict VRAM.  If there is
high memory pressure at this time, there is a chance this fails.

systemd has a policy to try to "fall back" from S3 to s2idle and see
if that works.  When under high memory pressure this also fails, and
harder.  Really we don't want this flow to be possible.

Fail the sequence if the dGPU won't be suspended using either method.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
Link: https://github.com/systemd/systemd/issues/25151
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 802debd8d9f0..6a5a3e132319 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2562,7 +2562,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
 	if (!adev->in_s0ix && !adev->in_s3)
-		return 0;
+		return -EINVAL;
 	return amdgpu_device_suspend(drm_dev, true);
 }
 
-- 
2.45.2

