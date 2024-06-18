Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96ACC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0F110E6E0;
	Tue, 18 Jun 2024 15:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDzY8lvh";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66ACB10E6E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOyX393kXngoJiDJ8m5HRZnzEs1BQDqcr0e4fGEtr7J9+U55H28jqHhC457JRAZyCRmUtNrzub13qWEmoLFUF/dSz1mJoY1xg6GrnRklmD8tOCgmF0k3/8npJRKY6ztvqHYQ0rFzcecbhW8bzhjcP0H/i8pERNCVpI1xeeZ9zkP+iDTMd+v8MUvz5wSBWT02HSN6klRVsIDGZlid8h0IMG9bCyk1MHI//aHja6ncs45DDZv0D818MP2lkHxzv3SbG/KybyaNE0yvzjwvOOf6BadzUAM7kGahyvgyGQRkHziFexhFK2Adv9k16Q3pVvai96MaWqgJwIy7B7hlAJA+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPx/KyIPlsXnFCJdmKmFE6XsBUQMYFGtcKZ9r9c5dv8=;
 b=O8kLU5MCBIFn/OLkTfMeFNp8Eo+fGC/5X/fcuPpElLHx2WjQVjp8nV0iwMZdq7WdndR1GLiZg5XqrSiXLPVtPEHsfdKDi9+h2cut2iwPGcBtEORz4HypJkWTaJX7vZPnUjwRPj7fmXleDacczZReaak1fQWF0YUKDw7/B3T0YMO5U4NnhvLFMrmZF68Qwj2uhM+VCgoC/tlg+L5M9RwRxVaEHIBjMKCx7hOtRuwGNLk3aeDuKRL8V6FaSXxEkD5uTAmWJglzFW/T3CeEQfAEFB68Z8vI59uGo0iAingHyIYu5Vxtd9WWhKe/agE76ujtZkpCo8hGPqu9kiyt/qmhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPx/KyIPlsXnFCJdmKmFE6XsBUQMYFGtcKZ9r9c5dv8=;
 b=yDzY8lvhGiyVuydXPMUWc+ThbZULlqAUlNfOS4KK1q63ClhS4kjcm1lwCU9z8Z5y+ALbJ1zOWM7mAOA6z5TFHPNp0Sp45DXCoMvVn92Xb8DnLfD6bKCLMOXi9RgTpvkbauqjSG+vpHROnGBS1nvmn3pKXKv9MEC95HK6CKwxgXk=
Received: from BYAPR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:40::40)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 15:30:38 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::85) by BYAPR04CA0027.outlook.office365.com
 (2603:10b6:a03:40::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 15:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:30:37 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 10:30:35 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: allow ioctls to opt-out of runtime pm
Date: Tue, 18 Jun 2024 17:23:22 +0200
Message-ID: <20240618153003.146168-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fae001b-b39b-40b9-8776-08dc8fab9a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|82310400023|376011|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u4nBfnOaZ4zaKEVMz/oyq3ZTbMnFj7ptzhsB66lDcQQx1j2DF6pxgWZonv17?=
 =?us-ascii?Q?ytu2h9uiAcMNsuP/XmB7LSVOMKtt2IZW9yz8ZVDbEXqfVpKtDs5LH0g25U3r?=
 =?us-ascii?Q?Y7viL0p/E2lqNLmB96NS/aBMNlj8yOKunhH18DyuoYlDhGDO93ZQ8GLqELj7?=
 =?us-ascii?Q?NOnPktiePTTnOp8bIDu2+3fzLfKM/1NRXzH3rt27MNEJl+fdIRoMzYyS/GuU?=
 =?us-ascii?Q?H7lJ3UiHJQxENBZz9s8Pesy1QLpWFWXI+JkMHTVxPWPY6DYHfrjzc/BQ4kJz?=
 =?us-ascii?Q?V1AE0OKcSiDcjnR/cPeKk9TZoEj96Y9gYTajN9+rtch+5yvgiXPaF/KffEMZ?=
 =?us-ascii?Q?W4fbjsthfN3ixIPyuAuYWyVTQGjIOmLVyKi4Re1NkJFyu1aYDoaFLBADKhFI?=
 =?us-ascii?Q?3T9AtnUWlTNmRS9g4rXpPTpAWS6pwEDzwpcvraze4ngOJlz17jQan3yKw7VX?=
 =?us-ascii?Q?icZJfrdVf2F1YBzRkAEKvMFfHqc8/5uqWuzq9HNLlD62dHyWxo+rD/9vhYw5?=
 =?us-ascii?Q?trl7e7CjXeB23iHiz7b+Nvdyt+YXqZGGesoQL52nPi86Ghr+r6VWSGMH936A?=
 =?us-ascii?Q?2+/R1kZB4MpZWpVLHxg7VjC0kN/cKeE9YCY83ICS+CfhiPWG+mqeq+DAL7DB?=
 =?us-ascii?Q?zd6y4EwhJSdkjj9DI8nN6Tphp7o6qqWPiDBWMzcpj0cvo9NlIVCg2/CORer/?=
 =?us-ascii?Q?/8eEzrSQoiMOXj8pLlUwqYagCpaxQq36G4DbUrKVFzi58VwNzo7UM0UBlp80?=
 =?us-ascii?Q?i+sO82Te0jAI2mozd27xopoUFpT/WrReLDbkAeglF0/eNhXgFxUaZ5IPJeyM?=
 =?us-ascii?Q?if+IGrT1dyIgWyZX3N3YB2n1Ol1cuUjaBwuPeOtSBry6X7l3TYWp2PH5JzY9?=
 =?us-ascii?Q?0X05s1/lWOg1503nG0+myha5mBB6S8hBfvqT4uCMW8eD3PQ2dnQKY4cSIx8q?=
 =?us-ascii?Q?92SJ/OwanjcDQXRF/I34nDriT6oQ00QnrcigtduH3DH49ExQM5+/oL3AC0uR?=
 =?us-ascii?Q?1IrKPxn4ypbtOzg/X/AQp2srM4hUbN4ZrRLp+j9UFHi8Zc54ZazDU/iO1Nv4?=
 =?us-ascii?Q?JkCQDhFj74NuI21B7bAlt7SV/JXPPMO2kWI4YDCF4r3l9wzguoURB+mKd57N?=
 =?us-ascii?Q?OQfAm+ojPJ5d2x86aSU+3QfUWzUyFTp/q9hs2fYun7fpunWPvigo35Pj2A6y?=
 =?us-ascii?Q?VcFeO/08AJtZ0wSyf9uQeOt911y5aKfHkDGIKlTCU1M/4YbEv58Bvquuqs7W?=
 =?us-ascii?Q?6HLq9C+K6+8eQf7nLfS2Ir8h4ujIHFykr36h7aZ3R+s0v4oxVWp0TlyJuchv?=
 =?us-ascii?Q?G5EkopuD+IZYAq+ThorZ/G0QWppTx7uUeq2mW6uGGu5yRJznC82FfbinNRbf?=
 =?us-ascii?Q?HKkg82QPxcCMu8jpVQARhP69R9q/mdERBzqhI37ceYaa/+3NFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:30:37.4163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fae001b-b39b-40b9-8776-08dc8fab9a97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
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

Waking up a device can take multiple seconds, so if it's not
going to be used we might as well not resume it.

The safest default behavior for all ioctls is to resume the GPU,
so this change allows specific ioctls to opt-out of generic
runtime pm.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 60d5758939ae..a9831b243bfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2855,18 +2855,33 @@ long amdgpu_drm_ioctl(struct file *filp,
 {
 	struct drm_file *file_priv = filp->private_data;
 	struct drm_device *dev;
+	bool needs_device;
 	long ret;
 
 	dev = file_priv->minor->dev;
-	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
-		goto out;
+
+	/* Some ioctl can opt-out of powermanagement handling
+	 * if they don't require the device to be resumed.
+	 */
+	switch (cmd) {
+	default:
+		needs_device = true;
+	}
+
+	if (needs_device) {
+		ret = pm_runtime_get_sync(dev->dev);
+		if (ret < 0)
+			goto out;
+	}
 
 	ret = drm_ioctl(filp, cmd, arg);
 
-	pm_runtime_mark_last_busy(dev->dev);
 out:
-	pm_runtime_put_autosuspend(dev->dev);
+	if (needs_device) {
+		pm_runtime_mark_last_busy(dev->dev);
+		pm_runtime_put_autosuspend(dev->dev);
+	}
+
 	return ret;
 }
 
-- 
2.40.1

