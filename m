Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2507C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 09:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F7001128BC;
	Tue, 23 Apr 2024 09:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VvH99+GE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3352113247
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 09:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpFaKxZyBn+cLMQ5N18Qf8kmKzIpDQLEEK0t9e6DouT61VzIIiFaxNHO8sWbMeAI1nS7SYDZxxOiQZ7Xefp83pZnDcRpV0duybC1+UYjT4FFvFvJslPRShcj10Z1dNoqn6nKviOEik0bXPfgLfl3FSsetE27HCMbq4L3d43a0ZkIaRjL3xAplpGJyhcHB0UHd0vnyUxI8aoN98BXATob/xKLBwyx//OVXUpjlACE9oiD7Zd+0aJHOu2AGPBSQmYd7np78G2uJyi39NHL4jKW1Z99uZZYv+0IKFTx20d0h+vbTHXVONG6YWPP5nQ2pKGWUBlIwp0cqaH27LzH/mME5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRklh9Ur+LTGsRI05+eefQ7S4L6icvrZdZ0wWaWJUb0=;
 b=KUo0jjd09G1a/lXQ4fFyfA+ugdHf/0Ii8gHPHPq466oCXF7q47HllvLQjzOsR5qaeLsN/f8sIJpoOnp2P6GK07cIKKO0fYCd5p2IOLJPAvvU43cPob0oBAAxsN0djZqJm9Yo/+QqOhmqQ2jAKcWysAQH7E1aqzZlmcBMSHuw0drdu2asdZZRKhnD0BgZZ87KX5CgqcT8BY9jJvcYikJi4VJn1Tgth84l7mt9X1JrrIRiDjxC1CoWQMZNBewMi6CfG0lAugC2gxcfXvjD9Ok7UT6ilu5k3UWc719e5D2/SR1l4qjcrC4kJNhjavJZBk8kzLYq7GZhL7yeuqkisCMLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRklh9Ur+LTGsRI05+eefQ7S4L6icvrZdZ0wWaWJUb0=;
 b=VvH99+GE4TFEFTi8Wl7O2GtNexZX1+0hh46thFqAvD0R6lWwUe9oelmy8hythkJAwr6Y8qX3dPqiv7IPHuOEVrHY6eExY+5ouh4YioVDap5k6JW30+8YYkBAeMeRt9i7UVPq0eeEpKqSmRZn14fr3Tpl0jq6CqZ2Kxg6K0LC9KA=
Received: from SA1PR04CA0015.namprd04.prod.outlook.com (2603:10b6:806:2ce::11)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:15:06 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::18) by SA1PR04CA0015.outlook.office365.com
 (2603:10b6:806:2ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 09:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 09:15:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 04:15:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 04:15:05 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 04:15:04 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <le.ma@amd.com>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Bob Zhou
 <bob.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: add error handle to avoid out-of-bounds
Date: Tue, 23 Apr 2024 17:15:03 +0800
Message-ID: <20240423091503.12691-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b75894-de1a-49b2-b189-08dc6375dded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/WgHO6NmKoZZbPZVcQVOYb1OvbU8Nno7pFkWxCIlIBD0xNiZO960rID+layb?=
 =?us-ascii?Q?B2q0aJK/acLzGCxCe/N6abaOCn5YfiIdC8BZsq85WsEoG9qvH3mZLDPrXipE?=
 =?us-ascii?Q?/+ttUdtJHT1wWrUbbaHv/aeZK/GznV0ODT6h7Yhx1T93Azc4U/mGuTCOdk3F?=
 =?us-ascii?Q?aq5O/khJkB3GSNCwlHJ9e2Df5c5oB4MNttlTF2qkZiKNiY8+Y7TSTdPNDRvo?=
 =?us-ascii?Q?vD4M4RaaxEnm+wFvABy3LsBA8CxAFMO89Y2F4I0gfQZfCcn9cdck32GLqSVF?=
 =?us-ascii?Q?oykqVQ2mOsO9gRcrhfd99VAhSCXDoQKBFl/hTc27ByiIFfGTendYhTGpjf26?=
 =?us-ascii?Q?TopUGwtTif0CuL9BIqDeRglWnHdFM/DXK+avy3OFCPF9zf71M41Hl1wUEp6E?=
 =?us-ascii?Q?L1r42AjNceS6JIcX5u3yZaECwF4wnMpN9Q6+WSxztUJ2KNyV2DdCV9iC3MRb?=
 =?us-ascii?Q?XVJDq0njSlB+Df0iidumNkUfASH0JOKTeus5+el72Ot5Sqjbqj3GGuT6kBZS?=
 =?us-ascii?Q?/EVWlJhTa4zXieCPsgCTJ+Y/0FXCB5ouohKxwjzOacZ/xSLsnrKQ6lSZR0mA?=
 =?us-ascii?Q?PCtUtx+x6skekDLh//76w3hEVPM/3e925Y1/xo8PbI0KLVau5KMLo0Ukla1b?=
 =?us-ascii?Q?WTyURwutwKmUmfHR3WBkyY/GKmAJyKUpi2VVpqR+VYmTjRyGyQb0qSBki9oK?=
 =?us-ascii?Q?y4uKa0XmT8xRqCMHN2kt693fmbqM3zrejwAybLLd5Xp1MpPo/cV77y+GAVUI?=
 =?us-ascii?Q?ZqeYSR0mEL6jSSqnKogxJUhL1jweIXaAk2V7hJfZZ6lzSnciwr2D3n+jkAxS?=
 =?us-ascii?Q?mbW8SghybdmAlFVN9cPRdjFyXB9Hxdf7LJMf6VVbqQfINmYjjXeRVPlwx/VO?=
 =?us-ascii?Q?qhXZki/CUhgpNeYwGzWxfIGIuZbY4EjeFh+IGf22cI79sWnfaU4a8sZoHCGr?=
 =?us-ascii?Q?tM2dvuiKOv3autvRXLEAkxJ2pRPakNpFo3lq6y3sq01pAPmxGriTHGqvKp6O?=
 =?us-ascii?Q?r25M+QJFXrxflna6yB8pEMOcdlSPkrbk+fSntqu1Ea3sTtcXAS/HLP3M7bgf?=
 =?us-ascii?Q?DBtjypHR6VjVQnJh5foUAQzYc4dGcnCG2VJMLC/hCO2UC41Z+mZNe3Mmnjop?=
 =?us-ascii?Q?nPiP4/W7ft6nzXPIDVTc9Io0oIL5UXjIoU3fr6rcKD3GyBWDiQAscVhniQ0T?=
 =?us-ascii?Q?DXVOaDi+IZRvT10w/iFY4M/U7zi5dmXjCIUDyQNw+bRSOEQZYDOF45JIhpta?=
 =?us-ascii?Q?xMu/tgmjReVdpmkfyIVPn0z7RDsvYYChLLrXg5VI+ZJ+wWNTEkV9f35jPCDI?=
 =?us-ascii?Q?hSvo0yJgb67fLMgf4KuwLOycX6EyM4VtVQUujqX965DTWx0RSBJVvcoOAAiR?=
 =?us-ascii?Q?szJKwtc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:15:06.4652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b75894-de1a-49b2-b189-08dc6375dded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
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

if the sdma_v4_0_irq_id_to_seq return -EINVAL, the process should
be stop to avoid out-of-bounds read, so directly return -EINVAL.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index e2e3856938ed..101038395c3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2021,6 +2021,9 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
+	if (instance < 0)
+		return instance;
+
 	switch (entry->ring_id) {
 	case 0:
 		amdgpu_fence_process(&adev->sdma.instance[instance].ring);
-- 
2.34.1

