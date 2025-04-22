Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A7C369D7
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A244A10E5A0;
	Tue, 22 Apr 2025 13:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2kxSNfbc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218AF10E59A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glPJupPMg9DeffICCITfgD2Vdi7BSrAHvlwgixI3RsEKzVENrtqO1RzWn7b3LDdnnKNB2Hg7IcbdNcakCyjaH07yhKYEj15pZfhII8ZpjUQQNeWVm+K+E/GH3GxRCNZ1UaSjVWoembjgVDHCgzx10wGhhX0oLY2DHkaNpAzsS+pKfucgHW8HTPsvSDc2et+U4B7DSFBFpnZCJ2cstMG3CoHMr5LqOYLEiY3BJHKTdmz1oI2F8wYQfY35fawU7rcQVxwThBoKpM0p68OwzFucGQwGRwUeHwo7+CJcsPFeOXHuv4Y3FCNRcpePLE18Ir85kVUEbH+Ya6kTIEt3VJWkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tLIDvnvglNcdQrVVOhzCmC4yRrhAvPoVkU1zQXx4OU=;
 b=v9N4sMyPKS366YFlUVELt4DaijLYhES4HtxLu/zfbDR1x2Q4ZuVxXr+w5Ag74AfL3+sjBbuYHMyOsq/a9K5kNRcznGeRpK74tezYivTs6Kw9PAWFBr7Fq+HQdys0GUObDxQESI584rcS8hLlFo352VDZzrAxFI6capRxUkAvppgflTE44VJCgIYBjPMpSn87H8gM6Ykjfv6dM716dHIDviLi2S8kMYi1JNcLbnPeQQy9mhNzvKYayDL7AsNZ+rL9GLAn2qpNHeHERLC+k8Qjw0DneZTFJ/u8bOqVPNzPDlrENELBGEsm81GW60NsZkENKzQ7sk4wIlTOEi2aOyXC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tLIDvnvglNcdQrVVOhzCmC4yRrhAvPoVkU1zQXx4OU=;
 b=2kxSNfbcNRtoFb0LZwLu0sE+W+tQpFPioVpY+AZmzbbfaoVZE80aucRzYYGD4rUDpKoKTyebTvZ3Mtal21uAD07Ef1XnjB1VWAJAGtIHWYMmeelpNdKkW46j6p/9phwv8Ihp1Mxo+jKBbBZr5GIYJJdmkQ34s3SL6OL2zkxxrmc=
Received: from SJ0PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:33f::25)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 22 Apr
 2025 13:24:07 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::b7) by SJ0PR05CA0050.outlook.office365.com
 (2603:10b6:a03:33f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.14 via Frontend Transport; Tue,
 22 Apr 2025 13:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 13:24:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 08:24:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set the evf name to identify the userq case
Date: Tue, 22 Apr 2025 21:23:52 +0800
Message-ID: <20250422132352.3988185-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422132352.3988185-1-Prike.Liang@amd.com>
References: <20250422132352.3988185-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: a61b8cea-077a-475a-f7e8-08dd81a0f56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wm3aLWYHmP3D9MPzv5tUm/BhEp5KuVJ4SATTgfE8e0dUzMpu40TCXl843a9X?=
 =?us-ascii?Q?WiQpH+qsk/WSEfn0KmoYHpwM34DhNVCNTVABcReX8tCc+efGkPRi3NJq3fvT?=
 =?us-ascii?Q?ZCFpEQmSN1iI1MixFajyLvx5Nbvb2ENR/FoFZ6ns57JVhMuqhlNpC5Bkh69W?=
 =?us-ascii?Q?33iYR+0rVqHru6J2uTsPeP6s+7DArn0oMCGeNL9o7IRgJVPIMuQIkoLbdjuZ?=
 =?us-ascii?Q?WyQdCoV/MuKL2HGbK8zkYPumnSCQk5GdCPYGzt9i/A+4aDtNSDohtD0BgRPa?=
 =?us-ascii?Q?8aWphBR6LyxQXFX1o+elOrI5cxA/X/APuia49ccDhbo4NAnZrGoYrg+ij3tL?=
 =?us-ascii?Q?mHaZJzEULAtQQTdKgCZD8l7DGfXNym0JWFz79DDH1YI3pOB2Quuy9eTtscIl?=
 =?us-ascii?Q?UMNI8ZY+XIUq0YgnPOPaQz8Y1OrBTSLsPFJ0kCsBJmn/mUVrpnDP5XEQ3e+g?=
 =?us-ascii?Q?xluLU9RKxLUaYdEAAOIglVMmialrv0tlHliMEW+Stf9GGU4rkANIizMQ0UwM?=
 =?us-ascii?Q?9/S1BPV+eW4uddqfea769oPzq5tKicoSTlOTk8kAPkvVGTpwat6rAhkmzzH9?=
 =?us-ascii?Q?41NaZNI4yT5cqpSzcEKEPODtjuEAM0ldQJfaLzLrCGk3y5NTGQrzgqptvjjZ?=
 =?us-ascii?Q?RDGVDUXx6mAPv/sLTSQpUn/6unepSXfidhjHeE1ViwY4bQwZz99yFAJIsHYx?=
 =?us-ascii?Q?HMV56KTA/f+KZRr9JTWE3OsHntVm0Al5r7s/KrGhsVWo24N7t1Eg9dzPXqGf?=
 =?us-ascii?Q?B8lJx/BQ49apagRyE/esaW1LcRyj3FLvgH1vCB8pLAYKi/w5Wz15LmYPVEko?=
 =?us-ascii?Q?aJlbF78++E5fP91rUaJiFdHSKI7X326vqvEeFl3GqAs4oC904LVBEz1Ssklw?=
 =?us-ascii?Q?Y+KMUmPi+r1o+VPpkl8pvDS1QNaS4LF3l0tVeqFA70dI3DIdfpfCw4arIc+j?=
 =?us-ascii?Q?SHU271RnWBAoWnR0wRrQBXjyvLSRitPXi8OSZHQX6Kd9EP8RBEACQyxBm14G?=
 =?us-ascii?Q?HtkxMI6et254/iwz5lU/qbglgZIojlUMrZRDOfiXDcdpiCMd4KBHb/rNJgxz?=
 =?us-ascii?Q?Ilyz9O1tUqVowO1WqlIK7Tzv6z6ak89JvR45L6M74h6tSnS3kWO+j5hpXlfo?=
 =?us-ascii?Q?wMV+sru5ecw5DtqVRT3lXpZTggPJE34xEMAf63Dq7EELl5hgmw/MATNYh5yN?=
 =?us-ascii?Q?ZCxBkh1I7fl5lQuUL3xvRJGDnLYswS6kjQ5JzY/qSBxO8M8h1+qvqrwMl3PW?=
 =?us-ascii?Q?HntbQd+xtfzJ2XVyeUB/aLOyWv38bUNgWKqsodHVEroKkklfvJUBaTxxadVs?=
 =?us-ascii?Q?k3G1G1S/eOwXeFEaGFHoHzyFqbQw6XxYNIDIOu22OsP0F2TSPJlEQ3L/raj0?=
 =?us-ascii?Q?axMs8ukCzh9OJIKo1CQ55gNIeTUqO/D+xFKsnWr36OQgbOIB4QdviLYKw5eR?=
 =?us-ascii?Q?6MweOL2TgVsKApKXYDZcDq0qaTLIu3In+8DD69ksgApCAUWB/8YL1wG+Do8F?=
 =?us-ascii?Q?y3zdslsBPQIGbmjloCa/J1x4D4zwxBfF0RFC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:24:06.7359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61b8cea-077a-475a-f7e8-08dd81a0f56f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
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

The evf fence name can clearly identify the userq usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 0075469550b0..610f447ede9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -31,7 +31,7 @@
 static const char *
 amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
 {
-	return "amdgpu";
+	return "amdgpu_eviction_fence";
 }
 
 static const char *
-- 
2.34.1

