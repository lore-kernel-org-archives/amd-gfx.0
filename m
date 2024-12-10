Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047CAE7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 03:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A818610E0A4;
	Tue, 10 Dec 2024 03:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0Ek33Zq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA7310E0A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 03:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWe71X4no8H7tuh3ibOT4xfeiCL6rCaySMG8mIA08F6AZQNi/E7ZMsPR164fAT+OorShc4C3hFBJIt3O9HPCCHsMxOGpF1qG8WQL/HjLQff0/hi6kdlCUXoEO0kXpvghVN3BjM6cyRmGE9DuTjwIiLS4h/VmlQx/KiLp+JUhEamP+Y37qTeACoO9O5bfYT9BaB8ny7t6QQuc/EjvnXAbO87xpP9oFF3Nxxa2TgHxq5+h3vIhxSrZo2i2mD/ZfIFCpe6SFi+ZzYsB13P10BMeH7UYjm3f9Hj4o+GyElBJw16NuFvrYGS/mTY8IJGOHDTisI59yPzdQHltLe30V/PvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpXHp2UXV9w3he2gptxgeQsyfRg/sehMrvjucRzsAqE=;
 b=ggauvNlHrTih0L7hczBvEDFYax5iB9dE88CeWqYho/frIHug+Pw1HKaNyYbkKmVlEenPzHgurAVVjH8r/ewhHn7K+yT0yw/5SHEbrOYauAr7Vetwadhe4wWHbHU/frJJPk+7YJGyJQUjpvVjLHLyckN/F7P4jUxYOyZaoRrPTTiaMz/UPicjbSWQhnTWwo48R3WPdKYumdENNqaMgK9ZYldFJJmd64uL2HHlVm6S6jw2TuNecAZqHOAagAU+hfvgY5M+HHKFmIXw+lgc4kjQsSOJk3tu3MN/qdUuyRbmLxfbfpqcYj2lpL/TMpw23BCiIOJYk6PZzxYAjivXQKzSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpXHp2UXV9w3he2gptxgeQsyfRg/sehMrvjucRzsAqE=;
 b=F0Ek33Zq6kVnK9YJ4/vQ3+97BqKAOkKnvdEKnYzR4yyLHJ74AgGUVpQfvnbv20qgyVJvmPQZOeFc/GvaRoB//pkhUVB5Wpx0822MkcCPNfpagFj3clmQf52/Tw5flxfTQlvpvVQ4a9z6iPv7/fccYplsra8keeKWle+A2Rou+bs=
Received: from MN2PR20CA0051.namprd20.prod.outlook.com (2603:10b6:208:235::20)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 03:52:12 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::d5) by MN2PR20CA0051.outlook.office365.com
 (2603:10b6:208:235::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.19 via Frontend Transport; Tue,
 10 Dec 2024 03:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 03:52:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 21:52:11 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 9 Dec 2024 21:52:09 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/mes12: Implement reset sdmav7 queue function
 by mmio
Date: Tue, 10 Dec 2024 11:52:08 +0800
Message-ID: <20241210035208.2158890-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c40366-48bf-4fdc-9da0-08dd18ce0721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZH+usu9tgMw9/kooFUkgubLKg5XMuouYb77+HMPJGuoxM3kbtNM6to+gKs1x?=
 =?us-ascii?Q?Il0kHzr4rZKXqKmZDukF+sDG2vahvZYd65xSsEMc7eVA6ULukXG9PzE1kKdC?=
 =?us-ascii?Q?b2A7DAu+jSUm0vc7N5NF+7YMavRbc0cPjERIzM/aUDqP5Y7XnI4qGtis1mTW?=
 =?us-ascii?Q?WGPhHkudl7O8iDWUl4k62FoTEt/OpizM6tVf9uSf0/YB5ET94oDumm9JJ5it?=
 =?us-ascii?Q?Nvhg5K4gxRr5lBHYeMomw8w0iwRZJGFS8uGPc9/Xhv8uc1MeO+XV6mV+Lqtk?=
 =?us-ascii?Q?62RMLrsOeNV0ZaFGtpXfeL6SELqN7ttJlT3FSTi4manJ24Ed23F0xhwck2hu?=
 =?us-ascii?Q?hlghIHVrCvUiwTjdUsHZ9vz8Y6PcHfKG9zH/KaJ7CPSHeoKVKRvGPEhJ+AoV?=
 =?us-ascii?Q?kAJ2L/3mHYqPPx7MTipizH+rXtpXk7O4z0SNd8ZOIMzf1YzQFEy3labkzNQf?=
 =?us-ascii?Q?4mbsMjbYX/Mvm/YCal5GeJt/9g+zEMlL3VyaRMn376CCcA/wCyfyylvELws4?=
 =?us-ascii?Q?0faNC641XTvkw86TLpbsDRaChJO9LxBodfpfgxqXbiivPdrTP/vIzrLsQ8wF?=
 =?us-ascii?Q?l5u59L4rfrOJAykI8VPbZWZDxW9jDrAoJcQyuDvy+UWTadQJhA3McTsWs3yC?=
 =?us-ascii?Q?hmX28iEHeNedWJr/PH2cuhfJIp2bj7sJzZyQBYnbv/GNY0Pn4RzKQoPU2W+v?=
 =?us-ascii?Q?g2YcerLUs6KUMHiaeeb2tTvT87oYOZMXEp9FgrKTa9rioDsUkEwFTK+qgpSk?=
 =?us-ascii?Q?HZP8iDodGrPJ9DW41NIQLsahPDGWiwFX65HZMU+RDNUPMwAeOXG2idt/GQAn?=
 =?us-ascii?Q?zx9rzbxkO5WfbvzyfrQH2kjXnTuUMy0P13Y0mf3wbF7r9+dG5tGaTCO2Jbnf?=
 =?us-ascii?Q?wkRuF3nNFQr24BxLGxu1UL/DycAKwwoLDCJ4+oqtPqXoY2nqVyWcjTH/ncQK?=
 =?us-ascii?Q?cT0qGitCojH2FtbYTFf/2crLGukprmjpTIK1AD0yHTzsnf8ul2iUb7g1FMVN?=
 =?us-ascii?Q?fPb5tZP1cHXKE2eVPZ0+FdUhw/G3t7HHmpmdVVbpRMMnRP7rQlbaBzusiBvJ?=
 =?us-ascii?Q?3j85ei5uc8UQjD9/X437cNtJLhGACiyPlij6T3QHsR7LPf77P7mkWtcb/xpu?=
 =?us-ascii?Q?SSg4ia/Xhvu+KTr1z40ac9O/o+wXTRO63rTASUCoF+VGpesNsYzHpe198TkC?=
 =?us-ascii?Q?JEu5Xpp01JJ3VXe0UBR2rSg0cuGOwxoEcS92J78S0RUkS0xFQDb08DHOPml1?=
 =?us-ascii?Q?Ebg9DN9/IUPCIratMkumqEfBHfyTBaCQG+ZKNjINEoKZtTOd/Q4pQSjS6Hb3?=
 =?us-ascii?Q?F1hpDfmAJAJyP+wlDbifG7dl6/dJwD3BJ0lqQ71slM3Dq6zdxNeIydwZGwjO?=
 =?us-ascii?Q?6KkhcbzNPbIL3s7wSVkPahQ9oFnqx+Bi/EFzbqLCE8KbUU84pdQf7ZZmJ1TU?=
 =?us-ascii?Q?Hyjj8rP/+K1EzjshA/O5S6tFfaGqE5IB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 03:52:11.7670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c40366-48bf-4fdc-9da0-08dd18ce0721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

Reset sdma queue through mmio based on me_id and queue_id.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index c63b3053eb7d..0f6635ee84a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -350,6 +350,47 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				      uint32_t me_id, uint32_t pipe_id,
+				      uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t value, reg;
+	int i, r = 0;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
+			 me_id, pipe_id, queue_id);
+		switch (me_id) {
+		case 1:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA1_QUEUE_RESET_REQ);
+			break;
+		case 0:
+		default:
+			reg = SOC15_REG_OFFSET(GC, 0, regSDMA0_QUEUE_RESET_REQ);
+			break;
+		}
+
+		value = 1 << queue_id;
+		WREG32(reg, value);
+		/* wait for queue reset done */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32(reg) & value))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on sdma queue reset done\n");
+			r = -ETIMEDOUT;
+		}
+	}
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
+
 static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
@@ -730,6 +771,11 @@ static int mes_v12_0_reset_legacy_queue(struct amdgpu_mes *mes,
 	union MESAPI__RESET mes_reset_queue_pkt;
 	int pipe;
 
+	if (input->use_mmio)
+		return mes_v12_0_reset_queue_mmio(mes, input->queue_type,
+						  input->me_id, input->pipe_id,
+						  input->queue_id, input->vmid);
+
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
 	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
-- 
2.25.1

