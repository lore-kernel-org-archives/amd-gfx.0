Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866BECD8C9D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 18:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC8910E90F;
	Thu, 13 Nov 2025 18:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fDB1evsp";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 879F410E90F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 18:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtS0QxZQR3vIu0xvN+fhTej3cVmt37HX82bv4qVGPBpPbvQ77rR7ayFQUuU0XNzjgAJE3js6QhFXPg7MJo8zCapK5s1xBFtMHsGiILm7z9hH5FkjOjSP/JcYzzayyZgDZkhVxbU0aeYwiWE/DDLlPTF7dIC95tgbUvmODSH2LO9lrglOV1H6mlQw8H63/v9bXoORg0LnYBmnmoTEMHyWiU7dGIHbOIZ1WptKEgUwN2fjdLY9q6wt6+mYToqjsQMF+F6e7og+pzKmWoZCducIW8DH7STMs6J8ssq0SIEe6DGphnLtA+aYc7gkyzZDaxqQYAycKkwiHfHB307ous1WZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wffv5PwJJqANV+ex3tovfiWy7HyWBlL4SH1Ghyuk4oI=;
 b=XG0j4lsXgV0OXt9M9jIegCQCRGtv+ExJrTSeMJeJ/ZZUYHnb45fptDt83HA5vfZz+2UUPnqYrttM9RvOESBTDvdgtaadFFcKZxHPmZAcz+fBp3RhW9UPTxtxb7c72m581AQU1DLpx1Zw92Sbq9vXcJ/0n6cDQgxuVXYhtgshkrBklPHgj8wqp7OM1zIDj7w3MRqZbBJ0JyLsKdj+k7atsebjCcAUZu6ziwk43pI+Wgzfc361wteWQ0VmfYWnufduZN1ww3H18rBj0dnphY7ZkD0ltmyXaCa/YcmL2IVkngpgHwP2+FccL+O9j901tHhDXuw+9yvpC51lrsV9xHUn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wffv5PwJJqANV+ex3tovfiWy7HyWBlL4SH1Ghyuk4oI=;
 b=fDB1evsp1UFbaDzXPySNpYO7K6kwurClo3PjZlHPNTy6pa3yJDxo8MX2UameqtkIP5sxRVsWGb5CT9ku2WY0cIGVWgJtuniC9mp7v6wTko0V4yNBPquFlj8AjTwEhP5TVPb/VgdFYyo3bwFT1rmR4/9SOiFG+wNMyaKdRAXPf9I=
Received: from BN1PR14CA0030.namprd14.prod.outlook.com (2603:10b6:408:e3::35)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 18:10:22 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::a7) by BN1PR14CA0030.outlook.office365.com
 (2603:10b6:408:e3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 18:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Thu, 13 Nov 2025 18:10:21 +0000
Received: from mchen-linux-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 10:10:21 -0800
From: Michael Chen <michael.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <michael.chen@amd.com>
Subject: [PATCH] drm/amd/amdgpu: reserve vm invalidation engine for uni_mes
Date: Thu, 13 Nov 2025 13:08:53 -0500
Message-ID: <20251113180853.225907-1-michael.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d93a2ee-6c9e-4b7d-0096-08de22dfe949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sPHts/sehc8ga/dXJf2+xFaxvknG2JXAoxg1NrzR2U3w/ZAm5P1qAnitjvkc?=
 =?us-ascii?Q?XG5m4IzVASwnJ2M988DAqAvJPdh14fmlz8c4z0d910opxGwoxHJI0NCF0MXt?=
 =?us-ascii?Q?/GfBHo/wHK7O5f5oPnqCqio9W71/BksTVzOEs0D0BI+oYAxXOSv6bmu7nYjq?=
 =?us-ascii?Q?seN8E4A5QB2M7acmWFzhXf5qCHytaUaxw0GO66NWJMd3NN5jq1gowZLVtSPF?=
 =?us-ascii?Q?l4WZqx5zXzklD9wBmXearXmhpUXcPhzZNaisGFmxSt1vKtHiehzdzuwKfSTu?=
 =?us-ascii?Q?iVfp13UfHXby+V/LzONey/GXRTwOnzD2mQ/xMqjGgjHKopaYGPnbLTc/Hm3M?=
 =?us-ascii?Q?suAa4q2JrkJE58884Eh4zkvjZty2Hjtcr0KbqEx3m04Sd0Y5Aul/YuSZwViV?=
 =?us-ascii?Q?QRW6xr+78BrnJIOyiAfkONkOuQLodx5ntS/H3vGKgHgNxsYzVtJNZp0wIQt0?=
 =?us-ascii?Q?bQdhwKxpobB83yaD/5Rbo+bqsyEoRcz5RCkYTJ5xGz+80vh6GpuAHw1Z1yK0?=
 =?us-ascii?Q?kGqUdI7lW0b9ehri7RbS7WG+ipFg0L9JgzHCXO+y1mA6OTD8S3LdV7qnghl4?=
 =?us-ascii?Q?STM8bUQ+VqkQTP0QEoXWxJMlsdw6bh0zU/iYl5HZ8u0fim/PKLAzezCetpZp?=
 =?us-ascii?Q?gLLJbDWw+pHM7p6gQf6gNAvSRNPiHrRGVtRxwRplFeP0VZRy+/3JWrHpvZmL?=
 =?us-ascii?Q?MUH5GUGHQ9QBr/2X3xKLerJG19+Z3agDSv1QTFGXkbiWtMhe7HGwhPDj8QVs?=
 =?us-ascii?Q?BwbRDnhTEQvZ3wchBql1IlmutxHzoVvbwoH0MOTqc5I4MQpNAD0duhGKDB2d?=
 =?us-ascii?Q?S7uL0IOVxv6uA8NRG/81GsZEA/4jk4304GEUr5Z4DWWCJs7a/bVFb085wbIp?=
 =?us-ascii?Q?jkQea717EODlgQcicfS8aev7ekNwKgOE0HKNiRynYyhg5t6tj9rntimXurvi?=
 =?us-ascii?Q?7JOb+KolVuUNcwkkcLl4/babwNBAQv0VKGxzWVeGOMTRGftotv6XMXqwHVVi?=
 =?us-ascii?Q?YyS1VPiIGt5oEp0/hRMCXtMNJOoAn2hi5iYrcYXgy/vZUbcDBLTS/oOBc4ZL?=
 =?us-ascii?Q?+3qb3S+VFIHT5JKzI+OjRwtOKM5tHsUXJixpFW13CwY34myoQf7tkszhwZ7v?=
 =?us-ascii?Q?1i4PKrHkKD+2BYToxpwbCLRFIu67oFc+7AGt8XjSu0PMc9yRHGO5JR0yjiDc?=
 =?us-ascii?Q?UMhWAuwOfX0FeM4v4VHvvX4UTmxo3PUI8m8mXLg94wegTKdTi0SXrcyDR59b?=
 =?us-ascii?Q?lu6MC+AjHnvQFP+i/WEaTRYG7ZsmtKnBdfkJa+XKo91a1qcBHYdFWjr974Sv?=
 =?us-ascii?Q?6H4LluX8haWhxXpnexcTcLoADJWEQQeqG22tn9re4c1LmAUjl00jXu5XM61o?=
 =?us-ascii?Q?UK/djMcBotQTDHX1EMlCseV8PoS6s9i+f4nCCn4oA5vvBus4kJNaZCt7waPo?=
 =?us-ascii?Q?PYw8FWO1SrDMkiG68dxh/UVzzRr0qQMpOgedlf0QnIdrMjeHa3qD3ImUfUdf?=
 =?us-ascii?Q?NEvu1NlW82Gc/DCtUkeye6c2SlTCKx2TbCDzg+WEoyKmR6GY7zdPqOP5jFcy?=
 =?us-ascii?Q?Aqqe715q/jG4wsPM144=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 18:10:21.9698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d93a2ee-6c9e-4b7d-0096-08de22dfe949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

Reserve vm invalidation engine 6 when uni_mes enabled. It
is used in processing tlb flush request from host.

Signed-off-by: Michael Chen <michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 97b562a79ea8..4814be022f32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -597,6 +597,9 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		/* reserve engine 5 for firmware */
 		if (adev->enable_mes)
 			vm_inv_engs[i] &= ~(1 << 5);
+		/* reserve engine 6 for uni mes */
+		if (adev->enable_uni_mes)
+			vm_inv_engs[i] &= ~(1 << 6);
 		/* reserve mmhub engine 3 for firmware */
 		if (adev->enable_umsch_mm)
 			vm_inv_engs[i] &= ~(1 << 3);
-- 
2.34.1

