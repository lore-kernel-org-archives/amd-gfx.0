Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF80FEE20A4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF9D10E7A8;
	Fri,  6 Feb 2026 14:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YAuNZIYg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FFD10E7A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYHgAVamqPtzgVLxSEirNhfPqXq4n9bwzsZ0edkyBB5ziwvvPahsSYHhbgNvRSJDCFDEoZJSRQ5R3jVmmbU35RxAG2MzTU0/5dnzPbTJcDkkjEGmC8WhzIU54eIB52fnnkZ4jxs2H1qyEHaVV9fqT6Bj15aLgIoIIsbG83Q48CqHBPsoQWg6zBDZLx+jzOkFPB0tscYHiAgVm404m/d8l0s5uap3QzpNMwgxxP2Jlw1iyoVLC2aXMbltvG5tFYDqtqi0snJiqgajtogdscerpRdmlMA2G+rqbhh2oCs09RkYz/EGTESsLHxavMhd4ReOkAG+d5RjGt/g3ITr3GHNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=Cll0PIRHtz1mI/3NaJvXRwUnPZiNmqTmiUBUDWPAp0WXwnwqPg08moqaj7k3eK6MAw4Qju1ChFqQXqyW0cQxFgrlab4vzI2GCPThzj9V5AsUjKOq2XF9MtlbDkp41ECYcb+LkQOAWPbYV3DbNcTmFHntoc1vmiWUXlHQxeivq4T3OoTEon/tbQNbP0gadNkR0za5BohRZvzzhEsvJRH1HLBaHCjSB6BT7EAy/emmrNcMbMXW1PQVOwePZe3KB4W0npTmaeZ6BCA2o8LE/XgFlHvm2K+5jSoeMJ+76beTXJpel5m172Ze19vGAIFZQX4mqXx57B/megeLzPcxnHBVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZnBZNXbu4Z4m+2NG9+kB2+tP2plt7/K+VfbDu5MgOw=;
 b=YAuNZIYguMpMFocLykEBTvAhjq0TOZW6MusbS80z4U2xt6EE8SqF+YyX2R/uGqC4KGS3p8jsgCEZ4ShQaqEN4QjygpI8QCFjTR9Om5nqFiksBGaimi6eNofAb5tVXQNrP6y4dubcNVg5GiwUlyLWzUpGYEOY62rg+CjsVeYjdVE=
Received: from MN2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:208:23c::24)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 14:01:37 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::82) by MN2PR18CA0019.outlook.office365.com
 (2603:10b6:208:23c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:36 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:34 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v5 09/11] drm/amdgpu: enable mode2 reset for SMU IP v15.0.0
Date: Fri, 6 Feb 2026 14:00:46 +0000
Message-ID: <20260206140049.105294-9-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c845fc-9722-4d0c-4b29-08de65883e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d3D4nQmXc/FKsdPyLCn1VcRdT8JivG8xs59L9yaNjRo2j7O9dZdcO0MuT9lA?=
 =?us-ascii?Q?RjHboehCvvuFI5aZNhKu3ltEeOZiz/E1Pz333fH9KWXRAfhtS1VsgPFTjulF?=
 =?us-ascii?Q?Q66SP97Mil1shmo7k0rdgbxJnakTd7OVmsji6UR8/3EwlE/UByJxqclx+W/W?=
 =?us-ascii?Q?eNRp63gCTK3XV2RMxAeL0gzijcXvhCy09GKQLScasFV2hWX6ahsRc3RDfch/?=
 =?us-ascii?Q?ii0VZ3eUMU4Tq5Tp1/h7EvYYs2Ip+oofIH08bkeNr37ijOlQxezsgMr6tzx/?=
 =?us-ascii?Q?9JAuXpz8JMtlQaVPs9AUg+AzJHzVv4CCl1UhVLPSm7KJd2jYKiVvS6AxGMEp?=
 =?us-ascii?Q?+aEiz85541kDxOWEgoxWgqRDtRkWp8xcplaT9ILo58xY/gyjSjzadQKHPJqL?=
 =?us-ascii?Q?Kv/upJ27Q2HFEWDfscSyuZLhvRcQbOdRnbcapbg9JAX3kGIhQ/sMabDh9gNg?=
 =?us-ascii?Q?vmQkMwj8Y3+9H4KU+LiLVX+9ZfQKiVPFke3bDhyygAmczXHEB8az3TiZYfT2?=
 =?us-ascii?Q?ARrXztCD5OFQfMIfH/pruH5KFmTxrmB8GN0hpVAMegBRMrPo8SECljgEIZij?=
 =?us-ascii?Q?eM1Os6qPZPyp4EOlcRh0QFljjyouEZci899kADY/ohhtFZa+BXIWFsckBvtE?=
 =?us-ascii?Q?DtmkzCWQu2fOHYJ/IFACNzRQB63psGCPDW2srVbIHT80hNEd3NvPQXBhJM5p?=
 =?us-ascii?Q?3FbFL34km0DkVFmW2ImQ62tFgfvXPkYMIkVMNAA14CoozACAQ9gD9VmvF/lA?=
 =?us-ascii?Q?nOGyTfS0HC7FCtU5B0usClgwnrpsQqBiJp8yP7RRTl5A20HWh0xMoioMmHq4?=
 =?us-ascii?Q?K/VGlDBKEm3Ll0bs7CplKOUk4YZGuO64wo+cD2uR4cg9EwajBiSwd9xx1DLN?=
 =?us-ascii?Q?oMQvGzzzN2rPk31LbRd46G3qiT7uVDStrAbB+ZXb0bsQpjW5PzvYDUrYAr7N?=
 =?us-ascii?Q?Vox0S9yiQHjm8yUFc+pUq9ILpT+lkH7QCT37EQSvAiDZhucPgCH2BITyRhCM?=
 =?us-ascii?Q?oX+Xu6t8KRI1YA4JM7jkufNKmj2aIRW9TscHpqHjBiUjnHwGShcc6aY+mazT?=
 =?us-ascii?Q?VbWeso7IfAp+1VNPfShe0/8jnseBMGWX9FgnSqmSlQ68aw0qOYuqg5L/cGr3?=
 =?us-ascii?Q?OeXgzzNEB4oE3hnsVq0ETi+DH6fHQftWTyknbiHrI/BzY77l/ChnNIrjzfBb?=
 =?us-ascii?Q?Kcp6PolPG6c+V/QaEJVs0JtRZRB1cFm+8NSXxJf1r84X+lbdSAZ/hqLViGeQ?=
 =?us-ascii?Q?5aqltna/Ta+36R9Se4CiKFjol4Nvwne3+VedD5Qs32khXJdmaBJRisbF6JSX?=
 =?us-ascii?Q?NCxAPueOOh3TjUXzoXmXAAHLpKtLnx8xKgmTzcFlLWcm2XOQo6dl9vdM8Gz6?=
 =?us-ascii?Q?O9h7Yj7AGJq8uvv8l/51okpCkkc6ta9ucUme7AQBNOjnh6w/iwF8IqvSjzGR?=
 =?us-ascii?Q?eCtq2wFI4YfAM0iKqs0pgSDgI5jhpbnpGDwmeU39XQd8mbVP4og79DTK6eWg?=
 =?us-ascii?Q?YPOuSkEkw49++E+ctJXdxhZwXNSG9dr68MIAxMlHgJyjeV2jj+FupUYQ0xMv?=
 =?us-ascii?Q?I3luLZx+SCERWRDyiplMI9rIN3YL3LkTSIMol+LlQcPXyJC8AXjZp441zvow?=
 =?us-ascii?Q?JJFKtLdXFn9jJmi2+3xTGjGLGXPymfzsOhMBrPW+ORqyWbb0XzRG7WC9BDgf?=
 =?us-ascii?Q?NUUOTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VDNBu74YSvEkQV91bzAGg4eOyMjB5ohpBjJOhM2S8/sW7RG//CE7FOfcCx+BU8sAyquNnu1tYZgvbk1IAt31d74d+Ghh2al5R0mY14X2E4T+1A0fzzyAZBk03wn2AFdiqTs5xgLzR7ObygM4L0ynpFejAhA3IV3wKWdQiMKZDClecTdg/JdLSHN/YuCdVSv/WQcAWGkrjCcbIH1MZsXbqwUobPRJB9z6UYjlF8/1JL155mgXLUGDalGcg/aLSKrdd/3BrQ4ohrp3+gLepuTycp4MQNNimKpEHrQxxvt0pLHbVEUQIXonn983+gYIQZcSntqSmND3JjSDkySscY3v3RFDoodGgFowbb+klh4qj5jA04PTpYKRC8uayHIRo3pcv7WLCrze0JkuzkSiXAOiyC7K0AC+Rjc2T19wYaLew0KKGIyALkAMU0hNquEREX/s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:36.9184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c845fc-9722-4d0c-4b29-08de65883e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
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

Set the default reset method to mode2 for SMU 15.0.0.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d9cc649d81ad..79d132fc8ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -422,6 +422,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
+	case IP_VERSION(15, 0, 0):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.43.0

