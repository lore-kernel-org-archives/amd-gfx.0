Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3618CFC267
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 05:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCEB10E2AC;
	Tue, 15 Oct 2024 05:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1rSQQAVE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9070610E2AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 05:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN6U263kuA8+2iA1dL5UiAhtWVmIiP7G1F7mMFQ+F9YJ3/UtGaJf0Lv/uvAjL2QPDuAPNpgvOjNpeOaIIXo258i0KzS1wDSmWmECn5XPKVaEkzJl8xbZAvUNleApff+9KAOwkC+aTBF20414S9dY/XGIld1ZRosPCspezTqOUVBtH5TGoGMZQFvwCk3vPEekDxxITlgHWvEQAGBnmvu233on9l3NrS5B6Q7cAz9oUdV84uqkta2QErIeoLAuyXPV/qXDISqti8md87zdyywgFrfSE9rrWoilB2UblS4BNH1THDSJAzkgtXYpQjU1wFti26dA+Gyens0tNGF5NNM4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33zaS/L+D0zmtKc7TUeMZRnH5OG8Zj1b1kd7Y7tXk3k=;
 b=BD6TkIipB/dwxO/cvUBq9oFgycWB6rIGPEshi1Yq6Ml9iiVpjL6rlHYJo/I59+O1ic78V+0PQW1WGSDKl5N8XqdDhotTqbOShXI0j1mshQZxKDpQdy14qcix9Cqj2lxWkmKI+qwKVeuWK3sQ9mvBRZ5XRp6E0d30qjAMMqhmMYfyqJ0bgfdHV/YC05Pnamf36wagpeU9QkMXnQMVtn5rimUqNkbl95pqQsmwqqsEXaXrKJmkZ6MxhloNax6R26Q5W44iL/LWfcieug/DBbC50q6mpv/LwTHlzoNjFXY7X/WKRmpjmgNEgx0PE6K+dNzjLXPcWsfbbTpdoGyprXi74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33zaS/L+D0zmtKc7TUeMZRnH5OG8Zj1b1kd7Y7tXk3k=;
 b=1rSQQAVE0DcIPCzScQL/pqnmkBMEhliRqW7ZHpwBds//sSLoNeWv7bXPBN+WRF/LpeTd9xR61EUs4AqV1biGuOgot5taheQWzrSE1aBh2pHeMp37siJ7Qwpo0JsjN7vicN6rpGS9qHi/LJH+qcLi1/D8ohu/wnEbX+hSQd4AEVA=
Received: from BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49) by
 CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 05:34:05 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::e8) by BYAPR01CA0072.outlook.office365.com
 (2603:10b6:a03:94::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 15 Oct 2024 05:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 05:34:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 00:34:02 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Zero-initialize mqd backup memory
Date: Tue, 15 Oct 2024 11:03:45 +0530
Message-ID: <20241015053345.3044483-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: b348f6c4-b81e-42c5-264e-08dcecdafb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zwn0l+wEovG1WUhejXL2nrZXIJcdL045DxiSGAbYdRK88SFQrTvuStPzvOIE?=
 =?us-ascii?Q?G5yO8PAHDHJmLZ1gBIZMRvQ8RgJt/pAJJChiNcF9+xwn2DNq4CtukWjIdRiX?=
 =?us-ascii?Q?LmGxIO0ZbltxOI6f4DMA0CdeNstFoFZDVTuiS/E7LvfYsFEe/JBrc1DjpcBb?=
 =?us-ascii?Q?aAD35/S9C9Kf+oyUqI/qt9CrIMSZkoPr3YipDCvz5bCy2iKrwtfYdnTNvBJi?=
 =?us-ascii?Q?L6AJE5gLWk0YfP0El8dqBNkfZd/gKKegdpcZ1inopCxP0hMppFpLU1XHg25a?=
 =?us-ascii?Q?ZtipJjVkKNecpSCswmzIvQMXzJPUSUB29qc7Bl2XV13QQlieG4Kt7P0zWRyl?=
 =?us-ascii?Q?ZyUguQzFkVThAPay0mMD9h397U3eNgYL2tIZTX7tmWOuV5zWsF90bskrQQRJ?=
 =?us-ascii?Q?5JFCegmn/IssBs6upzlVXIGJKHqDWtHz3wvQZsGTQiPsgfl0q6d8L29/LwXC?=
 =?us-ascii?Q?MPQJPH86Ks8yR9cpOgVamsw6MbsAObYndfcd4RD9e6FVsMqmBABbIgvAKQlZ?=
 =?us-ascii?Q?ij+W0jf800t3I2BI+ERkBMNeWf/aliOvxE85Pv5AwXUKxctplkWqnavTaBSz?=
 =?us-ascii?Q?LzkOr/IhovDQSKoyzJIkQHIF1Xk12HnGbyrSRm6Gdvze05YTv/7EL0JHWu9d?=
 =?us-ascii?Q?TMbTiR5r5FdxOHtFFFt2eXeKT/SdBHHcJXJawNKbFIkRZ72IV1t6iE/5ur4Q?=
 =?us-ascii?Q?JEyeMu/mC2RsZHV8M3vNrVvqxHo5SmQSsBVGrxEpaZdEF+EzYJ9B+vrDIZeS?=
 =?us-ascii?Q?luzJ5X9kwj6f6//5APsPTbe6SGHtoOUfp2WIEVgfSwqLS0nExIwY7Cs3z3vy?=
 =?us-ascii?Q?nR8RCwdeAd6nYC9bT3so6rAv3tuTiXYth391FC/1/iILyXQ+XQHlLgWJ98W2?=
 =?us-ascii?Q?sQSpxlX73d6lX6SaI2U/P/atYpsWm39JTsjrAmUdRgLdhum3A9UtOBwHIKG/?=
 =?us-ascii?Q?QsQDLBaqtwe3QFwDBvD4ryURVBSdEsjlV0JHJ9c4Oetl5GV7MIy4jQlzr8GC?=
 =?us-ascii?Q?CsCqW0GMmW4KJKS/7MjykdhOIouT67Mb1ezUvpaAnc/nEuakY63nQYN/3Ohz?=
 =?us-ascii?Q?e/vbttbfsp0BbLzyBACX9+XQM4qE5/hr2SRMCGTtR0ZIU/XZZu1UjtrBIzd3?=
 =?us-ascii?Q?XNvHZZofjs/cFMJ5nRT3jRHV/q0cJIT92DML+J95m9J3gz+vD6mF1OamSZ3R?=
 =?us-ascii?Q?J/vhr2GSchobL4/7VfEce62OqZZ77ZJ0vY5nzJCr/acTii9z4omhC9siN252?=
 =?us-ascii?Q?rzmkeytmrK9/gAyrc034rFWWblhpv9P6kb4HZglLzZTClkrxCotWLItchJNI?=
 =?us-ascii?Q?QXrh4uz1wp+8j4r5/rQoGJEWYFktz4N3z5+zN1zoOY6ZGgebxuQf5kHJevQ8?=
 =?us-ascii?Q?mxXkwiM5v2/UrUvkCcdCTmFfAIoh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 05:34:04.5300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b348f6c4-b81e-42c5-264e-08dcecdafb89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
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

Zero-initialize mqd backup memory, otherwise the check for
'already-backed-up' could go wrong.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b6acbe923b6b..e96984c53e72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -405,7 +405,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		}
 
 		/* prepare MQD backup */
-		kiq->mqd_backup = kmalloc(mqd_size, GFP_KERNEL);
+		kiq->mqd_backup = kzalloc(mqd_size, GFP_KERNEL);
 		if (!kiq->mqd_backup) {
 			dev_warn(adev->dev,
 				 "no memory to create MQD backup for ring %s\n", ring->name);
@@ -428,7 +428,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 				ring->mqd_size = mqd_size;
 				/* prepare MQD backup */
-				adev->gfx.me.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
+				adev->gfx.me.mqd_backup[i] = kzalloc(mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i]) {
 					dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 					return -ENOMEM;
@@ -452,7 +452,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[j] = kmalloc(mqd_size, GFP_KERNEL);
+			adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[j]) {
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 				return -ENOMEM;
-- 
2.25.1

