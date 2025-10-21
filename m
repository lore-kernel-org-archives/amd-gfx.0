Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B119CCD1A2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 02:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E037010E049;
	Tue, 21 Oct 2025 02:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H08zY4m/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD8510E049
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 02:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bk1kMblOnkfTNi1Zw8OikUNfvUKNpoBV8osBg7xRWeh03j9fFxzRe0tqJnTjFWsj80v0vwu58zT27qBVrmt1MPYJ3qy4Nq6T83KQBhFP9t/ThXnLYVynRbcgqjfI5n/zJSL/Pae3Y6pCmrVoeQhWbRmZOVi4L+mr6Ge8HVCpaJ2U4T5iPByYq9Z8V7lXR1s5CdRr29iMg00zxDzerL2bLA/Xw6aM1EIltSOSXa5XOsBVb4e81p8WVfED7Zx94bfhXw2lhPw7wM9CsNVRjRktdSIYBFnIyVNPO9MsoyPJHPMon/eY28FxRDTESqc3i6ZS0vfQcoIboMtvakACR0mIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsM6/M5lDIPDRG2GMMxBD5adAzjeKOfWNrpLV2CxpRI=;
 b=ySXLHBHyIWRQqDGHMPz5AKfBEk/g0/m1IASvvq2b2gFFkdVkWwFEDylSyNJ2j3vYTejRlqax5IkOIzexCB8SAtxxcQT3OoEU24Tz+gHyjthA44Vl8ynb684MIJZpM8zwW3P+oC+5onckHorlTHFvW3cKV9+588J1ZOnbiVJbXZls1uVOHmxPJJXbVorYwKRvj/FrUAQwuK0D7BlQk7sOmUMlZPRtLpgr/cJ2rJnmIim+KaiDLej1SWBFxQ6pinwfzrrTiuK8e2JsG2P8+dmOHdO/Vs3/8hv+Vm044rImRW+c13pZLnN3/CG96g/m1S8FpInFM24Pz2WjQhYgHVJOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsM6/M5lDIPDRG2GMMxBD5adAzjeKOfWNrpLV2CxpRI=;
 b=H08zY4m/ANtCtQgdlGYicaYvUMXwNEFiLysK5oXZXpmQme3Nb2ta7IjeS2p1n2Ah2J+/7Gnc/+XslXo+/CyB1bRsUkYciux7324ToVswmHH45Y4ZjN0hff9A4Jvwm4kqIUKn6x+p/pRpGEmtJNahR5G/zhABLkrMOA/2Ribis90=
Received: from CH5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:1f4::25)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 02:10:04 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::84) by CH5PR04CA0008.outlook.office365.com
 (2603:10b6:610:1f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 02:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 02:10:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 20 Oct
 2025 19:10:03 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Oct
 2025 21:10:03 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 20 Oct 2025 19:10:02 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: smu13: Enable VCN_RESET for pgm 7 with
 appropriate firmware version
Date: Tue, 21 Oct 2025 10:09:31 +0800
Message-ID: <20251021020956.2384561-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef8f315-103d-4dcc-d551-08de1046f30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9A5tPFs4Tk/V49bM+Lb4mLaq6Jt2FWmf2cpAY9L8H4tQDn3jAMt7QjMCUZIR?=
 =?us-ascii?Q?ZUcVZ4SToVOYamdLKrFbvNoW5sRiLuskMVDgLC2gCPjrvYNZIL+15Y6Ry2/n?=
 =?us-ascii?Q?SsEP8CnRn8J10MsI85QdvH3OeUgLi2qclcTYCgt8VFy1uWsVQXqloM3i4NlS?=
 =?us-ascii?Q?Q7A83rgioL1b1rczXupckiXdIBldGHH5vC/muUr2gvSGQQ/FpprCdOZg0glG?=
 =?us-ascii?Q?RpYCN/mKg3MT5VE7HHvem3y71jWS9zEhPBxwvpCpBTZaBERbNHlIjs5YXZHe?=
 =?us-ascii?Q?rn1OZFG2Uk4mBsVXFAKwmdpo2B7UzGCHutUa7I41Odz4UEtsdKdVgfA3eMzc?=
 =?us-ascii?Q?7ExcN8k7pHl4UzYJZHM1vboNAEf5AAtDZ/l+aFFz3cRvdhkoMzjvy3gN+2ry?=
 =?us-ascii?Q?38DvX+gwsWZN6TGdm77CYC4CXgrv64hWD49NCsdWPSFDP9Cq2t4cFH2mpRMa?=
 =?us-ascii?Q?6i6yNEYQeQ3nHWhrXIGmGU8CQk0sE0UkB8z5VcWOULnTv96UEUkj+CyUyN5H?=
 =?us-ascii?Q?bvSJrFyUBRfpnWRp2hjRQS6hf7/kptQ7hCSjk0YfbVeQFfO3yV/eQab+qq8D?=
 =?us-ascii?Q?ELjfwkG3fr8L4XvxmoF/D97fKWRUd7n5thXyZHlUe1DBhaEYDMS58f8ajICE?=
 =?us-ascii?Q?4j8UAzB+ErKAMW98MvzD5InKAVKojHsGBKzIsFhk8uPfC5WRmX628mk/1Awq?=
 =?us-ascii?Q?fQVKTimjuje2eNLl78+JBZRRhBeeXddjYnGzSz4XCR8dh4i33UXpWTwn5Qpf?=
 =?us-ascii?Q?XHVZCLT6Gis/uYwlb1Xi4HkIZY/SlWu8g+SRzpFu2xVDTB+ym8a5O+pGAefq?=
 =?us-ascii?Q?o8PAy6ujgDdolwqKyEm11ihWeu2kJtcLHr8YgdW3lmFOZU8YiwA4JfwQUcr0?=
 =?us-ascii?Q?LZ5lj4Io+n4xMin0yL40RZA8VgGNyQifyL1D3phF+CNh9BR3yzWzjFMrzngz?=
 =?us-ascii?Q?MbpM+V/GRKorelXd9nHX1LJjDQNHgY/wHyatR2hbAeRMXdh5lZMQz1RAb9R+?=
 =?us-ascii?Q?mvNjEDW5N1w9NVOpNKHZCLC6hEbOtwh2XTMJnneF/CRtjG+6f85mT9WYyvXC?=
 =?us-ascii?Q?Qtbdr66EPKm3tpPqjfznnB2rR57Y/K5GoS1K9MBvbdsXSExTxJ237d95XKQS?=
 =?us-ascii?Q?E7ldOumztQKeOoJ7+oUvazcgp3gMbCXrtpO/vzmY5zOAmC04xVOlEc5Y5ILf?=
 =?us-ascii?Q?RMzZvgAQEgyb7waujDeu9KkugqgGQcisC57cnyqDPLvUzLbTZG1HWRTG9u/y?=
 =?us-ascii?Q?3+2nGj768fu7P3z/dLD9QghxymF5m0YDmowoREuW/R3FiOTrOx+H9s7OKkpv?=
 =?us-ascii?Q?UxddP5J/ySBZPsq2N36whwrJ+iyGYI0GbjsqGjWtQMbCiyK2K8dha8zYDhGI?=
 =?us-ascii?Q?vHyo7OTcIk/9D1RGd1aj/Z/ysr1jxVQVxwroTkoWrjKtWNg6OMh2HPtMoPA7?=
 =?us-ascii?Q?Yza9g36QfrhYC/vYbRPArhywYT8uXSC+cutNJ8SgscGx6p0K6NAzA4omgjOl?=
 =?us-ascii?Q?Sh5d+vRlCKQHvQDTrmw1FyLgkHCxhYTS2BhKJNdtXAgO6Dq11eH5lhYckvsZ?=
 =?us-ascii?Q?zxANVMO9CQQ2NvoYOnE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 02:10:04.3927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef8f315-103d-4dcc-d551-08de1046f30d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876
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

This patch extends the VCN_RESET capability check to include pgm 7 when the firmware version is 0x07551400 or newer.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cc7a0e061ba1..0a7d2cea7dc6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -450,7 +450,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 
-	if ((pgm == 0) && (fw_ver >= 0x00558200))
+	if ((pgm == 0 && fw_ver >= 0x00558200) ||
+	    (pgm == 7 && fw_ver >= 0x07551400))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
-- 
2.49.0

