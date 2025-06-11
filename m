Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2C1C61DB2
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 03:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AED10E38D;
	Wed, 11 Jun 2025 03:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uP+kz/01";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5414310E32B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 03:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQIRg+gdKA3XKm5rr7udEAQJYNQQCvUFbq/qbgGWByMUP5IRJW+hJTXuGCvRbwOouowVUI/IpBIbE/OMEWvPMmCvH6OP4xaB3baKGFg24fssUnOAbEeffnB6s7WBgB18rFyF6gKhginStQapvC9KBRzphhmGzj2pI1EKNlLxBYvlOSiFFvFkUxwXCMjbAC/iXPjdCX4MSAckrqWRQnnvXmP8Bdkt/GhATLQuiFzkKST4EUNxdXEh5vvIbXa2SuJSX3DNCndCTIJn/UpWiVwK51bDGSHLvNDxV3VKKH4HIaBqtPh1OxdwxW7gh4YR59YFSauQnnsusiV3tQPkCd/y0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/A8PAPi3zyBPhvI5ERxFN7NoL978+bRmXGnVjOU5JE=;
 b=aoC31GYGjBylg5l62NMOg9nAcK9xpAzdP3r8DIG6Vgsjv1m3vIOnevKi8fIfOCJnmGfq9jwNRVr68dfopusX9LbxRUAWPiT2ETPeDerg0dusZPz5dLO9ROUdPZ5EDWTYO+Bb0WrGVg9j7u/KKW/r2c+ngo8sXEhSZ3lUP9mfLZlzQEC4HTQAvLECbICyPrh414a0ZKWKWtVHnfTg97nZECZO5TG/UhImroF8YLZYiUqaSuVZ6FkmguaUGhYz9Hiw8vSZ0Zh/URyFN9Yx4MMcBleQBN1RbQZFJqAAHHUQREYJioLj4yhg/sMeFw3myt9yR15oRW59wHhVKCMZOVRxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/A8PAPi3zyBPhvI5ERxFN7NoL978+bRmXGnVjOU5JE=;
 b=uP+kz/01vop9klpciYZ4jph5lvvUp/dboK9MxiZXrZOQGata3xJNxW/bIMEsEX7NIhWJVzTsl5H48daI36WngLfQvkkUbAczxiaQ8OKz8hl6yWwVT95Q/xmUTeCM5kAhzvTgdYQdLYG9hgf+fDh03ppL0ur0EgZOyx3xyqXwkxk=
Received: from CH2PR07CA0032.namprd07.prod.outlook.com (2603:10b6:610:20::45)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Wed, 11 Jun
 2025 03:35:12 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::11) by CH2PR07CA0032.outlook.office365.com
 (2603:10b6:610:20::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 03:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 03:35:12 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 22:35:05 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/4] drm/amdkfd: use queue reset for SDMA RAS poison
 consumption
Date: Wed, 11 Jun 2025 11:34:53 +0800
Message-ID: <20250611033453.48610-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033453.48610-1-tao.zhou1@amd.com>
References: <20250611033453.48610-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 5400b803-366a-4684-9870-08dda898f90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RkjUPo+PbpwqJjYQ3gpzA+AQGYISdUfBTTzBLDQbNPI8VAkwbJ4IhQZ4OgCZ?=
 =?us-ascii?Q?bwHhGk/EokIomFamBCkDcaepGNA0aESh+Fc0dhHpK352TqiRY8y6Dl7K1ddB?=
 =?us-ascii?Q?o2NVkSqWCIM5wKOUZOknXsnfbTxoLrrQOdlOAEX80XvhS4o2V2FxeECTlCPY?=
 =?us-ascii?Q?iW23UwMcrYQwA7N41tC+YAUTpeCBy7Eanuki0uk2gFEKHVnpuKs+crE7obvu?=
 =?us-ascii?Q?eGUDaqpyjHjGmR6cz4OB8CPVyQ650rGf1+gimRtdrYqRp2CxRnmBBF2CCg0N?=
 =?us-ascii?Q?isnv9L/t5PD7jHC1Uw20LwIiqiKyHo9Ocr6O8hLrFhKfi645np9MmVXdUVh5?=
 =?us-ascii?Q?6Q7yFFOBVnw0oJYjXWA02tx9SOY/RBQEY5uAc8r8JyC2LcO53jQFVpRyq6AZ?=
 =?us-ascii?Q?dKvDiV4eerK9kG68gTgZQwFxvcQmmhhstIsm3maL4JCz+EM99WDslCl0mTqS?=
 =?us-ascii?Q?BmACSlKShL7HmXYblng3VAdDZBx6ahA4HuSshPCnOscXqMWpPLpOXCu8XEJ4?=
 =?us-ascii?Q?bRxIgUFSXlE9UHE0TbUrBZZH5EFIivw+gf6F4ns1rzmQUvIVX9QYI2+2QUYO?=
 =?us-ascii?Q?j+qaln8asEI4BUcS/vtgFP3bv3EsQIL0zsnkZAjMYK2u/zA7zsGrGFSVYUB+?=
 =?us-ascii?Q?Hspb7BHQBJsTD3PA+oHULvOhN8nPzsUjsa4qPiAN81iAxa+AwFIu/ZvlqjMQ?=
 =?us-ascii?Q?f08U26lad4qICLoMfM1+c0EbELosDM9o5nJnZqPRAHZcOe5nuakowLqThvvo?=
 =?us-ascii?Q?urWJdfHHwVIr75z7TtY2Wu8t5uuMMpjFhHXhnNLr3hB7N0Z6k84BizpbR3G+?=
 =?us-ascii?Q?d2oBaJMu6TuKDApONIjaRQXk9c/YSOLTL3xLsUz6yUPgNblN+P72EGY/fYFc?=
 =?us-ascii?Q?458exqtaH0Gcd5zilHsJlJR9f3IJZ0a8U/5Cezjazs2kKOAE4l3Uw8HNQuqu?=
 =?us-ascii?Q?YQ99Iu78od6Q/t9wnRWM6bXFvl7ZPsxuBFjSp89GfUUCZyeJxFL7up+Z0G7g?=
 =?us-ascii?Q?zffrHlJN4OKlPnUu1wnGdOzsOUtVQVbns4m8cxW3xs8OhS39LwcRvNV2Duae?=
 =?us-ascii?Q?OXsXbSeBhJR1UGWrPwQIOpzaTWZBt5coJGs/O/CifGcMqv/ZXQaIQYB+KWgx?=
 =?us-ascii?Q?NBmFIVHsKhUmnBG8rJF69LTTFd3abL+QgQcReMPQKoyYaKCzj66Zsqy4sQ5O?=
 =?us-ascii?Q?aZg6H0WonlHOPPR7lK7neVRjRAjG+u0FpklVEjVSR9eU+XH7g9dEuLK+0Yvs?=
 =?us-ascii?Q?kGDyo91ghZTNjpXjwt1CAIsru6ysmINL2DZ9vEBQCUwiy1+HKwkkUY7dJET0?=
 =?us-ascii?Q?npKqlxwFLzftN0S7hchbmmlkJYzQJGfY4ltYmJG5xEZLv6D2NgPHdsfU+hYe?=
 =?us-ascii?Q?Bn2vEgwqPytw976sSREMfA2HYUCNGYN/xSL+ek9vGqRBv6wIqfGTS7LQx2GP?=
 =?us-ascii?Q?Q/3nQYW6cHnVHwwN9OQ1hLM3Ed17x7EShOMP8UVjinUK6SiEgZqwZoG6xuAB?=
 =?us-ascii?Q?/KXMHEyYWbMpwZHZn90Mu18HVUd4T0usLoev?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 03:35:12.2452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5400b803-366a-4684-9870-08dda898f90b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
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

Replace mode2 reset with queue reset to improve system performance.

v2: fallback to mode1 reset if queue reset fails.
    move the queue reset handling from KFD to KGD.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 0018d04f4b33..b9429774a006 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -197,6 +197,9 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SDMA2:
 	case SOC15_IH_CLIENTID_SDMA3:
 	case SOC15_IH_CLIENTID_SDMA4:
+	case SOC15_IH_CLIENTID_SDMA5:
+	case SOC15_IH_CLIENTID_SDMA6:
+	case SOC15_IH_CLIENTID_SDMA7:
 		block = AMDGPU_RAS_BLOCK__SDMA;
 		if (amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2)) {
 			/* driver mode-2 for gfx poison is only supported by
@@ -204,7 +207,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 			if (dev->adev->pm.fw_version < 0x00557300)
 				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 			else
-				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+				reset = 0;
 		} else if (amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5)) {
 			/* driver mode-2 for gfx poison is only supported by
 			 * pmfw 0x05550C00 and onwards */
@@ -223,6 +226,14 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 		return;
 	}
 
+	if (!reset) {
+		ret = amdgpu_amdkfd_ras_poison_queue_reset(dev->adev, block,
+				 client_id, vmid, node_id);
+		/* fallback to mode1 reset */
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+	}
+
 	ret = amdgpu_ras_mark_ras_event(dev->adev, type);
 	if (ret)
 		return;
-- 
2.34.1

