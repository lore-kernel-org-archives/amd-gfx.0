Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B5DC87FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 07:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA47B10E1CA;
	Tue, 29 Jul 2025 07:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IGSPdyt2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9550310E1CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 07:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgOu6VmgZbP5DoSXLkaqLXwDx/TZnmlRhqwe4SoLe4hOLRAhvIAphfYsiXIlhUr5jIJQbjV+Uu4Xdqpg4ThGfsN4WcYSBcBGyh8+GmfiYti/pPM8qDu8UTokuNQZErPbnQieeThRJ7glOWntM8OjXXhvvnFPFmVasaXrjFnk6J4dEQZ+/lcMIPlze5Crx59F/bAypq/MKvR2uHXfd+kXTYX47/CcFvB/v50KlEEbXqisVw/GmIgD/ZLxw6z396WRDtDwNGaoTyaT4I66QwG+TfAgFVKtUhBQQjUecFbr2yXpPNLzF+NVJC3OpikePVM7j7z1LfAK3oL/y3jtroThZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf1naDI04cSkjkPA5RT6KH2rOjFDd/Fpc60wcCKyfJ0=;
 b=yzKpuXgJ0/WwdEpRoGaecMf+Oz3QGHh+A23U/LBOuOeqxpttDPE/04fF4dfux9aFhu1y+SxFuwIFcjPm/mNR4LUj3Lfd0ajF8vaf5ru/k+sKFteWq5Nem4tI6DmktjizZ5YpADwgJUp4FYS4rBmJnrJWouQJ2EuEqQ6xwjdUM5lWgVIAXmCgFpBZgYEmkpQUx33n6nRLWrp2/wQZhp63RuKa034jpdNDso9QAnslSLD9uvLCPhVVj29iKnHVPl5WNDm6KwKRQVdsvmUaVAsUSsM83FNV6RDuENrlBDjvA4R8SOcG5S4EfCB1tb4v1hhjfwZwiY/Yo1KtpUppWpq64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf1naDI04cSkjkPA5RT6KH2rOjFDd/Fpc60wcCKyfJ0=;
 b=IGSPdyt2XvXbKvjNNCuW+xajyflF6u+Hl/k3U7MCh2tsLy8SIRQRyrx7MfNBTGEXgJpwR2dSKOitUtB0k9q97j3QYgaxUpc0m4W2FhUcyiK7iCfTQtTqU1nnj3hO2QHdr77LfEPJ+4S0ItkPEbYJjoWyxzzUd3GBOMuYgqzCvMw=
Received: from SJ0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:a03:33e::24)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 07:52:49 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::69) by SJ0PR03CA0049.outlook.office365.com
 (2603:10b6:a03:33e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.25 via Frontend Transport; Tue,
 29 Jul 2025 07:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 07:52:47 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Jul 2025 02:52:45 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: Fix unintended error log in VCN5_0_0
Date: Tue, 29 Jul 2025 13:22:26 +0530
Message-ID: <20250729075226.3407223-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d60a887-5ced-4956-e0b0-08ddce74e904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVdFMjAyV08rZzVwMGF1OWIzdXNGajFuUVhuOFFidEJFUVVOWlNhK05oeFMv?=
 =?utf-8?B?SHdta0NIanI4NVlrMFZEUCtDWExIQUZBOTgwbWVidXJsb1NxTVFJTjJFRkEz?=
 =?utf-8?B?ZVlmRXh0bVJENWFZb2pxSy9EN1RQU2NkN2xGWUh0U3ZaNDFFbjc3TVNBM0Vo?=
 =?utf-8?B?cHUzWlZ1U2pqMTNjLzRKV3kxVjZuZVRUMDBLV2ZjclZLS1g3emgvVGtkeDhM?=
 =?utf-8?B?L0FEMjdCMlQyT2thNVpDK1dyNUhjV2paOHZ4bk1HVXlBc1RCdlYza3p1OHdW?=
 =?utf-8?B?U1FMdGFMSGlVZ3QwSWsyODBielh3c2VlSnBVWExZMXA1dUFCSEl1VnRJZ04x?=
 =?utf-8?B?NHVHdlpOVWN1R0JhRytDRHZpNzBOTGdteE9pOHo1cGpUQzN1Wnc5U1E1S1Q2?=
 =?utf-8?B?WWpLUnZTQ1d0aVNkZ3RmSDRHN3FObmFWRGJmbVN6THFjMkUxWURSa3VPc0xh?=
 =?utf-8?B?WTBvQzMzc1VSVlc3NzR0UVdsYUZHd2g5WTlDYVhtTFYxa1kyVlVsdU80a2hl?=
 =?utf-8?B?ZkNFOUZhOU91NHR2MkVxT0pxaFRBOWY3bmpiUDdPcVdLZVJtb1JidW9ycnZ4?=
 =?utf-8?B?QytVR2xPYmNJY2N0aUtLb28vbFRlRTVsbno3Qlh3L3NUa1dvNmFkN25oK0o5?=
 =?utf-8?B?c25VaUVKV3JjRUhGNk5WM3hpYmlvTWZybnZFMFBWRmlodGQrQ0dmb1BDTnZO?=
 =?utf-8?B?aVZBTkw5SFFaVmY4aUk3dnlub1BDQXdWczV1ck80MGV3SFpwQ0dWb0hUN3Nl?=
 =?utf-8?B?V3ZmdGZyUUhkR2dBNjdWL2IzcmRBdC91R3FlOHZ0SmF0Q2ZJL2lnUDZvVEV0?=
 =?utf-8?B?T1ZvOHNKK0F6THZ3OVdFYWtVSmVVNUpaTGJ4V0d0Z3dhd2kxWnBIZEFnVTB3?=
 =?utf-8?B?QXlLK24xZGNsWnpOWHJOUUJzUXBuWjVzdlRsZDc5Q3ZxRUhXUTEya0thR2pL?=
 =?utf-8?B?ckxWNVhNd3BhWkFQYkxKMjVWeFgvYTgyUDRkaUJJQ2tYL2JHTGNTTjJOUVhv?=
 =?utf-8?B?SmdERFNnRThHRU1WNUtXRndxUzJJcm1jZGlONEdjS2kyZElmUmtTTFJ6OHNs?=
 =?utf-8?B?ZUNmamRmRktxRGNsa2t2c0owTjBZZUMwaEYwWWZFK3Qxc2xVSmkwd0cvTzdR?=
 =?utf-8?B?QVNEaW9WdlpFUmt1M2dPK1JhanpZVXJCaGM2WVVuY29QNiswMVRqMTBROXlI?=
 =?utf-8?B?UHl6ajc2RFpIVUdGU0RkMzhuWkFsc2RmZkRLTHZKYWFVREJJM3U1a3lRZXEz?=
 =?utf-8?B?UG5XTGNRRmV3VUtGb05mOTdRcDdJblFhY2JCdkt2RVNYRmE0bHNEMjNhZXZ6?=
 =?utf-8?B?eVRvQ2VrbUNjekx6Mk9kYlpOTHpOSkpSWkJuV3JPY3Faelg3MjVsVjBlWC96?=
 =?utf-8?B?MHNYSlFRU0R5eDZFOHpoUmtqVWVCNzNxeUs2RG9mK0R5RTJTcWFFeU1oSk5q?=
 =?utf-8?B?UCsyRnpNVU95bzJWcWx0VURISDJjOTFodDRJalo5cWNZKzVUaGpoalhWNjJ5?=
 =?utf-8?B?UnBTU1JEZml3WEkwZkx5dysvaUs4a2M2MEtjOVNodzFKSWMzeFJWTlNLYit3?=
 =?utf-8?B?bk5FbnkvaHdtNXhaMDM5VVNjOG1BNjRxYlNNL0V0SElXZkU0RWZjQ0xMWU1C?=
 =?utf-8?B?a01LRmpyWTZXK3YvNy90ZkhXV3FwUy9hczUwUDRaV21GNEtjQWhlUnpUMUlu?=
 =?utf-8?B?V21ldmNTZzFHL1BLYVFCUkJnaG1Wd2N4OHdkK3dYOVZoRkNuRzk3ZDAzS0sz?=
 =?utf-8?B?bjVSNVVFSVJzMXR0UGZUYnFod3dvSVpIN0tyZnU1N3hvLzVhM2gvdDVJTEtu?=
 =?utf-8?B?elIxRkV5czA1RmRKampFWWttWXJtV2NaZHl3Z29BTkVVRGlodnRzM1IyQnk2?=
 =?utf-8?B?bVBLMFN3ZmRhck4vNEs0dlYyaGdMVWtOM0lHUTY1UTdNQ003aHlwSnRCQnM1?=
 =?utf-8?B?SGJWZFJPbk1rVm9sVThrV2MrUnJNV1dKT1JkY0JRL3pIRWFSUmcxakVLTlpj?=
 =?utf-8?B?RFFXb1JYc0s0ajl4Y2Q4bUVLQ0pUaG51cENlRUxyTWFtNFhFT1l5YUpnQUd6?=
 =?utf-8?Q?bZQzc6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 07:52:47.6077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d60a887-5ced-4956-e0b0-08ddce74e904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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

The error log is supposed to be gaurded under if failure condition.

Fixes: 29ef09ead572 ("drm/amdgpu: Check vcn sram load return value")
Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 59794bd3d747..378b94d8a835 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -754,9 +754,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 
 	if (indirect) {
 		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
-		dev_err(adev->dev, "%s: vcn sram load failed %d\n", __func__, ret);
-		if (ret)
+		if (ret) {
+			dev_err(adev->dev, "%s: vcn sram load failed %d\n", __func__, ret);
 			return ret;
+		}
 	}
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
-- 
2.48.1

