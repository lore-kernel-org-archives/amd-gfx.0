Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6432BC0219B
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 04:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BDE910E422;
	Thu,  6 Feb 2025 04:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YGhgNti1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED1F10E421
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 04:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGnQxMbTeIsvIjHegY07WkJvYzM5kfcDrwXyo44rJKxiWnEhcRTHj+BXQ4wnelLpa/BndizjgUQsHzMXCDva7LWiRHvNkARHVrYeTKTNf09LifTI/sxiFzcKqE2JGoHI9ooXSrmtyucvyqn6JSuYDjMnwUQz5zRRPklWmNQQiUMJEwlK3u8TgyzHG2dlaPFykMUtXSycai9AwzBow4DE+0PaB9nSg/RwLKoL9y64+WKOkDYRW2pWjMnQPn+42hWZtT0yBX+5mfNK0SDjEahs4vsusHRAIvT59FoNi1/itqN3SMbV8fZqrglR1jnMlQaX1cdZTnnBxMjLdraErUH78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JNdYZxqPOHUdt2vpKXQ6NdDvMORM5NGumGk3Jy4A/M=;
 b=v8jlTF7xCO0xf4NlvB96DvljAtkoeHacgvh/QQ7WvB2x/kt2oslqKjQ1yFJ5Hnq1XCFXg9wgHn30JQrkFpFndxPiBMaE4ATZF2Ky63n08oE9Xd9+qt3rdUON+zGojKjuUSmf7wYEjxEyH914NRVEM7i1WTpf+/EtUd9ycjmMIJle+V1NXl+T7/GhD9puSxSN2Qugw0toE2dLebfZoVg4oTBDXIymFzA9FxkCm5pEFeqqsbIyKIdCOqw4Gx8isQ6HR6MBhRzRZhe1L1sU5rtFZWrk8TtcpW5UbeBsTz3k8wjsJCBjPzeSB2Kyh5/GERvkFU4gYDrAlHA7cprNBxkG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JNdYZxqPOHUdt2vpKXQ6NdDvMORM5NGumGk3Jy4A/M=;
 b=YGhgNti16BO2oL+oYG2H1VA5YYVymQyU5YBGnCdfzPR1/cNdAk4FihgserIvZfuB9nXCC2S9bF32jIcuAqiZxzofvrJkJOiyqCvzld+bIcpfZAJ2PuUeQjca0MatErCmGPoHwsn9cV3Gw8dLhbCVinjm5h7/z4uFPeLg9o9ZdKI=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Thu, 6 Feb
 2025 04:23:45 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::20) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Thu,
 6 Feb 2025 04:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 04:23:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 22:23:42 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Make VBIOS image read optional
Date: Thu, 6 Feb 2025 09:52:59 +0530
Message-ID: <20250206042259.1927200-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206042259.1927200-1-lijo.lazar@amd.com>
References: <20250206042259.1927200-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8941cee8-0054-49c8-4deb-08dd46660ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8/QCUDG6Ivox5OdZOSeZB4SXMexWQITn4YgVH1Z71Ah+xUrPvbleBAlYTURr?=
 =?us-ascii?Q?vH+/8WmLIFUVE5ofO4hNUtyR4wB4GmFQwJRg61uaOBmjKzsiqG2+wJAATWgV?=
 =?us-ascii?Q?A8UZWoHOssRes9NjU6xF2Vsw2vJ0+aNKPRCJd9HWZ9kyxAbk0lM6ujdNQo7h?=
 =?us-ascii?Q?XW1Is/AB0Llta6RYYI0kmNajvSxFqWkCzq1r6gAlOdo1Rak+10fvYOa0sB1f?=
 =?us-ascii?Q?UxYCSilkQqwg9g54RZOhSWxwaV9BDuZPhomOyUk7Zqotj0Gm+H99wiFl227v?=
 =?us-ascii?Q?1u86zWYZ+h14b0VDfy/b/AWDTwLMtoARWw5s6oMB17koIDLOnEJbIItSazUO?=
 =?us-ascii?Q?a5NJAFsjLCDUuZWn2+VY7NpxMhXLLXwu5oThmN5B9OT1klfisluzT8oJvq00?=
 =?us-ascii?Q?TFWwefb4BITG7i4vvfkZ3e3KecC2y6NDbT0PbdKhUsiIFXOBGyH2Hjrjc1Yc?=
 =?us-ascii?Q?iWGjsXDlPPHxWwDfzWlLVtoZrDSfygSXu2+in3TRE64M2zQWmPqE8VZ8qJ8e?=
 =?us-ascii?Q?sJ3OnpGs/SpKWSM2zifoigsjLF7xNiF6keaMr0Ibw/icNopJ8OB7CuYSwBPZ?=
 =?us-ascii?Q?+qzu2VzOaOf2z9w+Ac6+PyTbg0fxxZHnAZtQLI3ufYlHjL8erpqa6j+MdcdA?=
 =?us-ascii?Q?6ALnqj6CjrqoRmTsqrmXm17jGU93Rm55rC5AlmwoFoJbBYwiEN5iZyCU5HgE?=
 =?us-ascii?Q?vWb7TZm2NmgK+VHCGJ6s8D6n1ZYDpj+SYsYdPCkcn6rWeGfwQ4cI6gpX6tuq?=
 =?us-ascii?Q?rZg1xZJsxpgznHa6hQvwv/BTyTki/KJm9Xtdfoa6K96fk+84DX/Hdr1w/5oE?=
 =?us-ascii?Q?/HZIkzu6et0TLq+bsvfvUo3VvlaHLdq6oRjnIF9ZXFlZy/BuuNMhmSThXX5R?=
 =?us-ascii?Q?+KE/nGZX22XuIDijURHIekwlcUL0+RWLokvUBiE3F0ioqxQ4TKHebfzhjltK?=
 =?us-ascii?Q?XGobHJ0Dge2aO/Yj/y4CJVvE1nRbZDeCNCQf1YF6uUUE0JsYDMPaPwdaZtZ8?=
 =?us-ascii?Q?648plOXUVQUxmIEAriQnvTNv6mF+k1+aD9nJrsqo/s2k5mgU9DqAaM2jOqP0?=
 =?us-ascii?Q?oTOSLrwSjjl3ugk/HAnyvViND8KEtG4QJgH0COdhb3qABaVM4hYFE1S7mkpg?=
 =?us-ascii?Q?PDBPdPkgsI0a+FJ0LTNfP3oQc96mW9VytMfGY4T2+ZoIWduhCRiUUI6dzR86?=
 =?us-ascii?Q?Nqfr4fMDAqZQTGsg8MGoJqB+nY02VTjAZjxWJeScGnC3RELHtJXQmafH9NNZ?=
 =?us-ascii?Q?eCgN/qtWfqXe1IcdzbjTnnjNsD+5YdhQ1jeeSFJ/AV6LAezxr88OYaYKjm88?=
 =?us-ascii?Q?TRGfhS+BdtkhS4/lflgrOewrd1kq7TGEH2jkw5OnmraTSl2TP+i3JqejEH3k?=
 =?us-ascii?Q?bP4VSiZuR5oJnB5oEimGvSVvF1N8/mLViS4l/S82aIDgA1i5FF9fUK7ZmHdA?=
 =?us-ascii?Q?OBoAK3vmPxbDLx7yY9JF38bEpRfkxyD7MFI3X/lzyfpa7DDm4sJ6dxUtPdJk?=
 =?us-ascii?Q?n+cwNUkAcPvkNi8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 04:23:45.0554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8941cee8-0054-49c8-4deb-08dd46660ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
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

Keep VBIOS image read optional for select SOCs in passthrough mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 16a61fa70afb..eab530778fbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1397,6 +1397,9 @@ static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
 	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
 		return AMDGPU_VBIOS_SKIP;
 
+	if (hweight32(adev->aid_mask) && amdgpu_passthrough(adev))
+		return AMDGPU_VBIOS_OPTIONAL;
+
 	return 0;
 }
 
-- 
2.25.1

