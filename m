Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C99C10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29604112F24;
	Tue, 30 Apr 2024 20:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LTSvvGwi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516CB112F20
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esKTB3qLUgt8rATcB9aO6Of3SIs32apSpe4eThDEYoBw2Wbf79ZbIuSx/0mQ6jQ9JOcHk3PUv6cFhiI4jevKOsk6Ac+W13OysKNZJnmZyctMH0i1hrWexTG2xctI8dyT3Qi37wGH9wL1NAg7TGv0ZeWOHImGS4rN578X6wYw3ieh2uJ6N/GAmji67/bgu/V0mUwf3xfbmVrJqc3k3FUHckc0++EhBAdN3SivDH6dXCCGwU6pa8+p7qEqh3pWFWxvPqf+IQwo0PagP8sAw4oG1dtbAEPyiL5m/5w2SKRLH3trkiknAh5bsoXLjA9+k5v9qZ3rBUSyx9N5ErCy9GLf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/KZnAwvL2wB1beiDKLsFnYYTWOGewBJ3MpMQH6YJhc=;
 b=HGoY63/4+9EBgkNIdGLBHpYUgQovUO1knY7xd5kZl5vKMu33kONik3lTvBF/rOpa0wzEkApMQTY8ejOx2jojoX0vJ+mfHvxpj+yh4oRR2Z+JnuDA1I2VRrMWwO0syhkgFLfguYTaJL2h6150rtEnatS6kd/QeKz7mchlH7VW4Z/BoWYSLGoi361j8kT5Bb6O0RIaws3dGFQJcLY2Y8TzZ1I1XEwif6BoDGI+eoE6+SCVIY6B/Hd1V8LecO1e3FW8A8kl7Ih9OVfElqOAL5yAe7hjoxPpAZlS708tvm9PK73mFNGH3rMnKRoQUUwTGL+Y7UTdPQbu6luI387oIrEVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/KZnAwvL2wB1beiDKLsFnYYTWOGewBJ3MpMQH6YJhc=;
 b=LTSvvGwi/UGXIWEuk0nIzvXdcZAk3U72s5cduUmwYQcmtgoo7z2irvsqIl0+/GOcVLZZvqZ3A/XF8Jd6qivEDrWqdrGHK8Z18sy8u9qy4P3eB4lxQU+lHLuntj+y2KUOWQMiZ0i0lMWJOpaivzBF7ASF2MtCZj2330bIPEtgJ14=
Received: from BN9P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::32)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 20:34:22 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::72) by BN9P221CA0020.outlook.office365.com
 (2603:10b6:408:10a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 20:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:34:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:34:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amd/amdgpu: enable 3D cgcg and 3D cgls
Date: Tue, 30 Apr 2024 16:34:01 -0400
Message-ID: <20240430203405.798798-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203405.798798-1-alexander.deucher@amd.com>
References: <20240430203405.798798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 838af1ab-2201-40f3-552e-08dc6954eb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F6l4TXgz+Ua/1UfJ7pQPDHYUBiWJb590PMztBnDFGHAgvYVazsvOw/u9h8De?=
 =?us-ascii?Q?vJi5lxkOM0l9g8nQ5RifCiifNIn1GWCedEBraRHTZKZo56p1nBJSr00+dr45?=
 =?us-ascii?Q?LtjQ20Pp+PrWhtQisB1pfDQAykZs3RaS/ZHD7b3CYuP3e/TsbM+gcqKXOXBe?=
 =?us-ascii?Q?N+ZHWqWWrnfHXl26lAerUbU+iiS8olnYxJ+uDjf9LrtBACZtu1Z6fM8jB+Kj?=
 =?us-ascii?Q?+l1UMJmMwXeFN+ZGAv1I4/ca0HWRVnUzeYjWmlfKzepBkd4fzarulO1dhZ8P?=
 =?us-ascii?Q?idp5ggSXm8nMKV+JlLkUrlD6wpO+tDEV2VkXxRXtm0fGunhrURvjc0zVFdA1?=
 =?us-ascii?Q?3zVqOH5aYP7ExCl+TAxYQUF54DtJ6cA02s59j5NcGhVCW7BNKMLb3IQqrDHh?=
 =?us-ascii?Q?vsN/Ev6G/LW8Usm3vtGaCl0EnUecO5/SIZAKVLpGl6RnADbWnTbmTK/xiNNd?=
 =?us-ascii?Q?/QYClWc3U1Yhc/CJQSe3guS1cyiClNW+prbXNStQWmxocKEL4zl2Dc6iRTHL?=
 =?us-ascii?Q?01NcWdn/VgYF1UqI+k4Uv7gt9qSQX3/HOMgf8CX/WJp6d37CRxvgk3VS+MtK?=
 =?us-ascii?Q?iO30YhPlqSwhwOlAUn1ui3XZP89BPnJqEja6Vx6Z1T/ADVQEiBnESQVQzQtK?=
 =?us-ascii?Q?mI2eKYCdHNmE9Q2vbRCau3jBLHJbVADrqK+213hND3YATMGzDNUBLAOFOpXo?=
 =?us-ascii?Q?5z54/ChnrwsZbZwL23cX8mZGpMfZfi7KQ7mGrplquVVJLV4cITuLUJ2JwafO?=
 =?us-ascii?Q?CdfLOWlZ0+zn1GB5YGaAqjKSEiY7hjQXL71Jmv9jq8ijlA559gbi+2V1p10b?=
 =?us-ascii?Q?yVyd39H8cWY0TEZnVtFpF1T8Po6WrBvksk3nFv1d2d9wzVtqDW4f4E6195Yb?=
 =?us-ascii?Q?KkJqnNd89dvbHi0AAQD3QtLi7C9aZklttxT5BHzHLvX3ApSwa5M5LA2WWlQ6?=
 =?us-ascii?Q?xi9Ft40Gaa0S5te6FemWhp8ve6rlvmJBrccxPleo5mdodCm2hZjJ5A9C3w9Q?=
 =?us-ascii?Q?FzdJA7ItXL6ltVo+SoW/+qkGvXRPRYKXoU8qkjTnG7M3XRy4bWQQdRAEDWqV?=
 =?us-ascii?Q?MrWwqbkB4Wb+51Oqu5M7dpeMJbeUcg5BXrOoeoBLgk0R9W5LwdoJiZ3wV7ft?=
 =?us-ascii?Q?zlllDHyeyHRwuPhnYlQCGrabA2hlkevRUfziKQwn9wg8yh/g4EaV02UFvAeR?=
 =?us-ascii?Q?v+Mg8KP09PzUFiVwXjQdHmGL//8dq73olFveqnSk2K/KWAZ8KaMP56I0KWc5?=
 =?us-ascii?Q?+MMFMh6ljycEiszGqKCDYs4RuE7mT0TrBzrxV5ejn9KtlIJ2GCz4NWANQJZa?=
 =?us-ascii?Q?z9A19scgYvN7Cb1P3xuEyNmoC9wG+lIYCRxhgcyI711SxTq3rCHpDkwOzIWh?=
 =?us-ascii?Q?lZt9XzVdpF2F4hOYJPGkDB/S/E2O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:34:22.6124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 838af1ab-2201-40f3-552e-08dc6954eb59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210
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

From: Kenneth Feng <kenneth.feng@amd.com>

enable 3D cgcg and 3D cgls on gc 12.0.1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 30e166004e39e..780e54b74979a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -403,7 +403,9 @@ static int soc24_common_early_init(void *handle)
 	case IP_VERSION(12, 0, 1):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_MGCG;
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_VCN_DPG;
-- 
2.44.0

