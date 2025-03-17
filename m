Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C621CC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 21:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE8810E19D;
	Mon, 17 Mar 2025 21:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0v2jGIHy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DC210E19D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 21:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj4SMKyUH8gDzeooG6/vHJDSbzcFPDxIjZC0gIxIb+gtSSk9FiA6cc3KCPFfGpLbXJoYGGBZc4I19+kDkZcvq7F0+4ysCnb68G998iaqzPDmMq33EoLtE7+VvUqZEprPQ0oeQUq7IIO/+LgonyuWj4vIZVJX8eTlxzqKy6muuWYv/SgtjWNm616b2MY3yXIZuuuN/y7wRig6mT5kX7sewD51zpRfcRgSWzqDxdIbegJc2S++ggPvOESsU7M7QOMDCQjxombvYe3qiaXfZiOA+oklzL7tnWN0cVtBRd42nlQo4+FiNqGuIt0LXGO1MMTqYffsiJFeJI8S7FveZxGFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2wIdwnxpA9wHaPQeal6S3lVo2T/1EWUnSxIBAwFkLA=;
 b=N6zTsoTmHpK6WW36hZPctXh4nX7mebsuqxu/MmdTHQgQPeILG5EHL2jUvQfh9gha/NpJDgC3Tmmwwk8p+ncAnd2sj8WKsnyZB2GZjvPhvLyjSK7HYCS62LXAjwuszdu5Sk5ByuDEtyq1MUH0p5JZC8OIlcJgreDUBO3eyQVxKEj1No2ytGis9TGCOgt0M71lvcGJxzP94ofGEa3wDbEBxz/tgHa1k75l4yAu2Da24G0K+aPGoB4iasOoBYfGg5jt8sO94zMWeYRFqy0+tE3l/oJ0APjveu6zMGGmEC5OhrBv0jTp1eJZ4MyQ9Lwt09G2AUBiVXA+4vHRPXC5GzkujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2wIdwnxpA9wHaPQeal6S3lVo2T/1EWUnSxIBAwFkLA=;
 b=0v2jGIHyrnAJY4BIRACmUlkSQL9Z810WZPXLLbsg/KEolFFozxqeZlzEXNjqCMfi/vo00HAXn7WpY96DUN1skZIl9o5CVxG0mh9DieBh5iAPRwLfYTxN1De3MwKiw/3GlyMYwKAXMuW3LD7yVKb/AYhZMtNsqs/zv7xpsfKGZRY=
Received: from MN0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::10)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:03:41 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::94) by MN0P220CA0017.outlook.office365.com
 (2603:10b6:208:52e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 21:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 21:03:39 +0000
Received: from Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 16:03:38 -0500
From: Ellen Pan <yunpa@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shravankumar.gande@amd.com>, <Victor.Skvortsov@amd.com>,
 <Ahmad.Rehman@amd.com>, root <root@Ubuntu.myguest.virtualbox.org>
Subject: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0
Date: Mon, 17 Mar 2025 17:03:27 -0400
Message-ID: <20250317210327.7699-1-yunpa@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 9167cbd1-a153-4d95-7d53-08dd65973146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/7QfSm38xQ6BkQy8YBbjaQiDgJn21codanYvuqIHTlfQ1LJWDTfjpJV3+z3T?=
 =?us-ascii?Q?coT0Xi4qCcjZAx1jn1PAl+/fFcXJVWUb9AHhcVoJY/gc2I8J4Fd2JCdsL7/Z?=
 =?us-ascii?Q?LtJVerxilB1HfP6Kg1XxnrgZzTV8FnkxBgazr1U1Mpc7AUs31c4Br8uLvpYY?=
 =?us-ascii?Q?6rJnq4ReW8aG7/e+7iXdmjFhlMZcoi82kniXDUZcHYwUOnXADvG2csELQ7Ce?=
 =?us-ascii?Q?3k1ZRIf0pxEIzxUuCLZvaJsyu4ZYlajGTJEU8Am+kFjrW4gHXLDVLixniLP8?=
 =?us-ascii?Q?AHNYRYL0FAwQ3K1cudMXRonj4J2PuTF1JCPnDrJmS4Qt3fwXG45JYNef8jk2?=
 =?us-ascii?Q?Zxapl7QevLqDWteGYhXaS34qNALm3+EsAnggA4y7BNI4CEr2RaTTUIArs9QD?=
 =?us-ascii?Q?InE2GTrIdNSASO9g5AOZRRuEj1xRpH28FyKM07b2ZgPYrGa8bG6B0iAqXtb2?=
 =?us-ascii?Q?0dlyyGWLQBPIVUA6CeSh8ebu4gf3EWH/RYpgMkpSHEuLyWXjyCFWL4hMAMN7?=
 =?us-ascii?Q?IOg+HFjDGIjGErYDrEOQ/a3D7LxDKKR9dqJplgnT/ETfhtyQmDXi4S4BTXlP?=
 =?us-ascii?Q?5Wm3dNgLCRIZDfp0LcXUtF16nRMPF8ZLETCxQnxBm33Evie3dJoUVh/VbJ3f?=
 =?us-ascii?Q?puyZGHwCP2nnR59bw4cheNERF7i3EHYLwebE6f/Kkj7N/XGpG5Lah3+hsHNL?=
 =?us-ascii?Q?CPMhBnQD8aifwpepOGyfHnU5dZtjWKYOHypa1GmSr2DGB0jWstKi+NBZIyYM?=
 =?us-ascii?Q?nvYWXRVInbzwCzNwJYhp8uCd8UsMhdF++Y1De5murFxw4sWFIBXCiG1c/R+u?=
 =?us-ascii?Q?9Mv2CYu2KLavGeEhz9bw3uVyIX+qOrzADpZ2KJLFNqWDi03TNFFMw6m3Wa4a?=
 =?us-ascii?Q?r3Muh3V8p/xgq7v010159G3S1ET088KM/q/U9vw8/jhrkCFq6mKY2APV51v0?=
 =?us-ascii?Q?BTZe5k57/A0VIfwDCrT1w/rX1F78njMGWeUQhozs/wBgMJ0d1wjMDG87evCc?=
 =?us-ascii?Q?URXvqfmCdRwzqFTG7c3aAMestLPpum5DJpV7rlO7hSMfrCfG3A092k8JF5WO?=
 =?us-ascii?Q?bbeIFz8R04N/tVs8ngMGHePrzg91N/Bmyw1so7hgoIXfYY7E36YUlpXJyPSL?=
 =?us-ascii?Q?Qp+oqPmTHMSbvNqbHaRtdU5CKeGB89///Ds+AmgvWCATPAWj+z6pczThGBOR?=
 =?us-ascii?Q?JCOS/KtOkFQ1ODg7f9cIgkdw78XWhnMtuZmcEbBuKpi2VemZFjE2ttWPFTqH?=
 =?us-ascii?Q?AIEDm6aWjs1j8zcmT0/EBytDyAx0wKXP++Kvv8r9ilaAHQsX1brS/9CfmBG6?=
 =?us-ascii?Q?sFsoN+O5pUVllWbulaJWnJPK9pin6bIzPqm/h9QdaOgkm7qycNdsRdH04Flx?=
 =?us-ascii?Q?jh5YSpbjTgzq6kpzJAj5MKMIDYlETlea2JH5nOUlN4uvofLLCsvfeZ7GPcps?=
 =?us-ascii?Q?JTyKqWHuCp7+QkhHjL4tlNKRTjL4Y8NzDYVaMefNq1NIZ1yobHQtj+7ltT0J?=
 =?us-ascii?Q?DIsDtxQMPnPh8lE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:03:39.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9167cbd1-a153-4d95-7d53-08dd65973146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

From: root <root@Ubuntu.myguest.virtualbox.org>

This enables ras to be resumed after gpu recovery on mi350 sriov.

Signed-off-by: root <root@Ubuntu.myguest.virtualbox.org>
Change-Id: I77e81e751cf7f31481c6f2ee6bd86758722fd2d4
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ca2ebdd3c95..7ac7fb45d286 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5324,6 +5324,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
 		amdgpu_ras_resume(adev);
 
-- 
2.25.1

