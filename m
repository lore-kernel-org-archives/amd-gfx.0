Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64C5C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A682010F69A;
	Fri, 29 Apr 2022 17:48:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57F7510F66D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOQTCK/Uiuh9548OeFJawqXZIK7tjdoAt64gn1iUqvXyhtG6wzZLZKvHCbJxIpFGFNpeCVrGx1781k21KqLT20/vc2dDMYUJklV8+Oq5jPM7rJLRSkJDHnWRGyYZ1NRZgAFO9VZKOGa4Iv5/WrFGNkkAaB8t+LAaMpmql0rKKnLsxhhczRL3VGzwAqNrYCedj0OpnN/7wCQvZMLU8nEbQkXiVkrSHEmJQd4r24BAn1wRAo5K+7kvoRK0ajdh5EY41qJJktocwEyRpkj6+v1/pVf1IL2eH9PL40U/kx45jB5n9L4ajd/oqZ5tABU33/Z4FCyYO+mZHSOBNl/AU/hWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdGXrl/dcSvupGrRlP6PeYDo0XnQzQqoMf7t6YfE788=;
 b=ikQjrGm+h/ZEVgw0QzuwlvUGt4Py4Jtnvk8l98ZMrkc6dnWEAHmclAAgzDAC0IzfnxtNv4toIBRn/0p5R4dYuGJoMlwJO5KMh3ADSiyuKXM6A0H0eYtyPaHUKrHXT81qqzrRxL/QuredjBclhDcobjLI0uOtHDINCf0cN2dYRgaIK/9CUlwLmgCZQkXVr9PDuIiB/sQj6zEJYH72oP5K8pRje751LFmHis65r6J/C9hEUoAQhbxyFdBOxpG+hMroQEqS0yK+Ud0rsDjPM9PCy1heX19deFcjW47pvjXwJEjmFPjonupb63S0hEzjZdB74PZ8d1vY7rlkdgocxIjjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdGXrl/dcSvupGrRlP6PeYDo0XnQzQqoMf7t6YfE788=;
 b=I8qLJnl7EQ8TyUdzDxQk6x97fVhgnSSGpvf+FspBd1KuJjYZdK0IlCcB7St5t6rAVvcIb3zmL+bONQTnpLXPBJ6LzfG9nkjBZ8rKvvG3k1WJCnNHE+4/afB//loRZ7H2YtXBDigoYb/2BTfEZ5ERhd0JfyDQr74nzaKrakP6s5U=
Received: from DM6PR18CA0026.namprd18.prod.outlook.com (2603:10b6:5:15b::39)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 17:47:22 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::82) by DM6PR18CA0026.outlook.office365.com
 (2603:10b6:5:15b::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 72/73] drm/amdgpu/mes: disable mes sdma queue test
Date: Fri, 29 Apr 2022 13:46:23 -0400
Message-ID: <20220429174624.459475-73-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d385b7d1-77f8-48a6-3a90-08da2a085031
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB151465D47AB48B19F243AC40F7FC9@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DX/MU8FvedGcoOYUlFRaw6VaPr0qsNp3HPsABJ5uC06KibbdUnzug47AIToivBwgsOi2+/2z9C1wTybQpEXmfO3wnHsutX23srNc/s4UXlOKdrXZn1sIyznxdsg3ox5ZmSYlb3vQLV+aYb2Rxr9sxsB8QEnpK4/5cUHrVmPykivm/S+tNhObaqPXD4NVbdmFVcVYQ/HkfREb28xU3DG/a9fEv8U/mcKwUKquxFFatDCPBJur2Uoy/PaCza+blA15sI2HihGgJdi3D3IleQ64Hu2B8NNtkaDJimNxQilCB0QoiAQ+Cqn6ec8WbxZCpK4RhQUQNaPj5HLG259vac1IE5WNkjlFFXiSu96t8FRdlbTBx51Xg7gh86krITqhBx9mkYnWODp2lBZmkQTyXZ2X/IiWrXi5llhZ/IlpVUWN5shb7xuBbbRH1zJH/WppFd2Qwlcy1hkibPDdJe8XWRsKrZsIo8ym05N6cBxNoJr2DztQfqg/5vCB/HAmrUObHvr0RlTf5Mxg3CuCBHgPf8jj4A+OdtorB2Xu8h9ImRCF+hoR9qqcrUYMkhA5lotZvFLaShgWjlkayeJ8XGSxI1nMX3u7RnlX3xlrFls1bgBq+I0HyqIZMEJoxZ/SKjT7bSaE+rc5gjUkQ+DuB8jtpSTQBoa5sW9CNj0UZXW6PSk/I0Cip6EeRkNX/b3uVG8oKy4qlFQKMn0JcB036pw1xOReMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(47076005)(5660300002)(40460700003)(186003)(508600001)(1076003)(36756003)(336012)(426003)(316002)(2616005)(54906003)(82310400005)(356005)(2906002)(6666004)(6916009)(70586007)(70206006)(81166007)(86362001)(26005)(16526019)(7696005)(36860700001)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:21.8917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d385b7d1-77f8-48a6-3a90-08da2a085031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Disable mes sdma queue test on sienna cichlid+,
for fw hasn't supported to map sdma queue.
The test can be enabled if fw supports.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 51a6f309ef22..e23c864aca11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1079,6 +1079,11 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(queue_types); i++) {
+		/* On sienna cichlid+, fw hasn't supported to map sdma queue. */
+		if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+		    i == AMDGPU_RING_TYPE_SDMA)
+			continue;
+
 		r = amdgpu_mes_test_create_gang_and_queues(adev, pasid,
 							   &gang_ids[i],
 							   queue_types[i][0],
-- 
2.35.1

