Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB1EFCE4C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1C710EAD5;
	Wed,  4 Mar 2026 22:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y1dUrjVv";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400B410EAD5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6VRq8R4qX5BYDb/ElwKv3Oz0LTEPesKZbMGvAaa9uGXG9c/0Beq1Ompb2+rR/2HBD+uS0D4//QzkcP+nmN6d8VHUDAFuhlfxmV6XWApHa3O86DUX7uvQVUa5VwMrgdk1S72XH6BsFi/z6Kf4s7BQVmizfvYP9cMjEWQRo2C+61Kw6nEQ/A1/J/NOJF6CKehk4Rs3LFo75BSg9X5YvTIYmcD6lMdu4dL7sVmLv6e61WJZVjukFtingsIcBOknBsNdrM/n3bRi4jKkoOqYSQHk9qjgbXatabz9D95N+R12iEPgakVKhxgZ7w64xAsu7DoR5N74FxdRqpxZDDPvQzRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf5Tt61yU70ttIvgYXWlJRVTgrlJqxF/Oyot/+ac+v4=;
 b=mL0IWZoy87PZDtudIC6xvY+RnOQPlx/h7nHKmVEB4WZefs/ARLIt4oJZEJ3S1bWfSLlIoX+/dwvOvsE5iPS0xR+WBxATajOcVTwRqz2q9+JdN0StHNfuwx4IjzcygXpLGVMxwV4fkDNSwNqykBzED0ENnHlmnUr2Td0F5LyJdXVOou2qwFzeUrJdF3+uF1GhTStEmwK9GT4YqQmXn5KP5zJH02iqsN15T5kOyfPluKhV54tWVGvoKGogF0lTWdRXuj/aTK5pStS6UtPLE0GcQR5ISAFtHf/QIr5B2zNGpA0zKzAHrbQ0EF7aOXuN7mKeslZm+Eqs6YDkTugS1wuqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf5Tt61yU70ttIvgYXWlJRVTgrlJqxF/Oyot/+ac+v4=;
 b=Y1dUrjVvAqyPPSrqLrclPDRblENEIuXP+kXMCWbtj3req5xKVkS/PGth9YjwaPpOnmReVz3WS5HxgsZD4+0ElN/ojzhecL+2MsN5keTwJOiDDu6MbbrIRRN3vLrnLsw5ypsA5aVyW85E7T1YuwWUOkmtZRKu0bmIR7VtVdjnZoE=
Received: from MW4PR04CA0124.namprd04.prod.outlook.com (2603:10b6:303:84::9)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 22:28:48 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::9e) by MW4PR04CA0124.outlook.office365.com
 (2603:10b6:303:84::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 22:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:28:48 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:28:43 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <benjamin.welton@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [RFC PATCH 4/5] drm/amdgpu/gfx12: add compute performance count
 control
Date: Wed, 4 Mar 2026 17:28:28 -0500
Message-ID: <20260304222829.3688601-5-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304222829.3688601-1-James.Zhu@amd.com>
References: <20260304222829.3688601-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: eef0b3c1-48ec-4737-27f4-08de7a3d6795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: uwvIj3ymoRZgmuLq01XlJleFXuOGDu0urBRNCH9ZgtseKRBNfZIoYkDqGI+DUqF8Oid+DgHeehyWoqUseL17/Hqf/R56Q6y4Ai13OomJiBorjQi2GopS/rJ6QwHYdgDyUyiqklvKxPTcj3yvh8qZ587lRrbIL32W8lt2TOpVoZELieba3UaLxZ2YJ/FbTz3PKKgQG6QQTSiaejrbvnjqWK1jG1lFUGZTXK4XczKukxBLJGyjbaLVpC0uQZZi5wRN0+189FZ33ipE9ys51G/vxlUcPvG4riSOO2oHuJdbbyhIXb0nZFLTf2N+nlxmct7L6mGgyCLEqoRKmHfrXKrkScWYhb1VnimbUGoCWTaeFYBAUjzFy24SpqoizIil9ENNLoy7wN62EfSgaLIy8pwNsqxNldaAdEg0EUipeLWOv6lQwEQ5kl9fFK5yKbhCLTfI4sZ20GWrn/m41Y315NnnN1WllsClJh+pwEky7EzctgAarXhvB9L6ea2ISs00TCKy0yHICuwMYfUQEtQhr7g7mZkKfqQ/2s6zwo15Y2UCujD/by0eB3jQGNNQQ2DM5g8WsXlD92mEsIWTjxMScFa4800LcscgmF429McnZJ/PLWGVwMvrCuqIWhOME0lJgiiWO3y6D2ytkqXpn0BAbePl8ybxcubUBhWhpujaFLXyqymO3XWqAAzvsV+hznvQfTRDF7oNRa3aZLP1AXg+ihgWDK6nWWQDuFxrqesqBxQZkUXPMchPQt73JycC9b6CSScztSh55oA+ZzkzRnryw+lvwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BKozHrH+Mv9OK2g4DQlOvu1vhRM6JD3UKaGjpl3zTe7v3F9QYF518rc6gXVhjtJ8l+lTbLjAVWtTs2hNfnzwZICI7zgqu0funW0uWyhgqtWIQH6VVQxjpL6dmKTEokk3Tvl/c6H6nNVMWoqkI+NO2BAIp9lvsMOdYaYflgxKG98SDvFH3r4Kumvh3uFyNewHdLH9AofjdpFjYMcpg3R2DCZz6avbVgwN248izpFJ+I0oWTV/KiGJL1alqijLqzKtYRoffayqZSUvRP8e5bNraiv4va+Gk0mKT8sr/gbSOaCQQZMnjapZoL+ri3uMyRPcMBYfQxO85atytYo8glUcLPt4OXJY5HyaHWPDQGN2W88h0EyVTYAFo0N4hP9h0T04EVFsqQB4iwMiFwOf0P3uleTtrH9AQlOsNAK689wx0qLoEUmay/Tp+Jn+jTfIZ1cC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:28:48.1278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef0b3c1-48ec-4737-27f4-08de7a3d6795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726
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

through amdgpu IOCTL AMDGPU_USERQ/AMDGPU_USERQ_OP_MODIFY.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b9c43738bd86..410fbeea4111 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3293,6 +3293,9 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
 	}
 
+	mqd->compute_perfcount_enable =
+		(prop->cu_flags == AMDGPU_UPDATE_FLAG_PERFCOUNT_ENABLE) ? 1 : 0;
+
 	return 0;
 }
 
-- 
2.34.1

