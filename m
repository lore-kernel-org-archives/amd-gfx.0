Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457EFC021A9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 15:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB13110E137;
	Mon, 17 Feb 2025 15:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wsB+Qdjd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1B710E137
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 15:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nxgb1jCHyBJ/Ce+l0zD7ss0xsf7mCmNyABqNZXBsDRh2TCh9D6C8s9Najjt5TYcwBM8zeegSMGz0aQLgChXvhvOMadV2oWx6UVJivoRKCGWV4pYt9gBqs/05VsqSFk+6+UISyxglfXoULmeb2ixuV4td5C4qsEhoKM1CNKXP6Smfjz71VBiFdyQDOsABGAHzVgHj0hZPISTipIAV3q6Zq3c7qCYZ5+l4evu3xS6/YQKJH044pN9b3S1NjFmeCKuG+17I7E2+9x4IsO7m0B1sJfBWcgzVsP1IzR+RYg+T1sbqq/z0bvCGhJSoECsgftZffVHnDb4ZW7nymmLsLmvPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/WTDP1nQFkXTO8dWL4YaGEZDNj1/hMpb9krahR3rDA=;
 b=yFy0Sj7bXkHDJQsDuwMXgAikGeo2Z46MV0vAVxlAVynRm+SR6M5HceNVsz6w6Ht2E2TTGyiQGgVx4kduUWX+E/lUMYzplS8fvvINt567x+ZowO8YCCrx+OppzhMIPxyXmZMaT45EHjj72rFXJZ0KChFr23R5pzlWY8FcmrxUzNKeQxFEo+zFUeYxUJkNsOY0rows9NT1Yn/N9eH40vLLTIkYna0DHgwgtxyXccwCLgdlYleQ6oJhWoYdR36AYEw6T3OiiDvHIVuOAkqh+Tb9E5Nb4BQj1ToEZckRxOV38uXrKXgRTbI7haAZ/pdlWIWHTdCTygzKTfmVnN0EhhrzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/WTDP1nQFkXTO8dWL4YaGEZDNj1/hMpb9krahR3rDA=;
 b=wsB+QdjdzMW848KwFvHickfFx6I6Vt+REFTcDo/G8eEAwqBITTuiI1gyriXCNp/NzXPc8oXP5//xZrzyxkGtWGEwq1XpTb8U1VJ25uRdFtvP3sjB8D4GvaBn0Abw4f8+yoKepxZvYSgTcjmszAIiTcXjoisUTyZVQQMCKql/c8w=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 15:11:08 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::e9) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.8 via Frontend Transport; Mon,
 17 Feb 2025 15:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 15:11:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 09:11:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>
CC: <Mario.Limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Nirmoy Das
 <nirmoy.aiemd@gmail.com>
Subject: [PATCH] PCI: fix Sapphire PCI rebar quirk
Date: Mon, 17 Feb 2025 10:10:53 -0500
Message-ID: <20250217151053.420882-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5c7985-5bc1-4bac-9bd0-08dd4f654e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0lmakw4b1ljTUZadytBUi96SWhNNEYzT0lvRU5aNE5xNkR1TWEvL2h6YU1Z?=
 =?utf-8?B?UkQ1bXh3TmU4a1FOdkJ3SFNKb1pER3d3dHVIN3Nmc2JabGJCcUNYR1laNnc2?=
 =?utf-8?B?alBzWDBVQWZHeGt3T05wQkJ2OVFhUkJ3dkNEeXRuaEJqdkg0QTJWN09zTm5o?=
 =?utf-8?B?MzYvTnJZcmNVOUVCdTVOTG9lRmQ1clN1UktHeUs2R2IxU1JyK3F6Um1CelVX?=
 =?utf-8?B?ajlvd3RwaUZmZlEzZ0ZkN25YZUJoMWV5VGg3S0V1ZzVxRElraWpySGpjNSt0?=
 =?utf-8?B?RWowRWkvQXN1YVNJd1lmM0lKaXV1UjVXNG5XOXFIQlYrWm9CaXNtWm1obGht?=
 =?utf-8?B?Y2pNYmdmWEkvZkxMRmRIZVVIOEJWNE53czVjekNaQllHVFhuekdYSktkQzJ0?=
 =?utf-8?B?N0hRZEQyMnBmQlZscm42RFpJQmhaVHlTN0FOa1c4aHVyQjVpSUpZWmM5aThH?=
 =?utf-8?B?WHhsR2VrQmpFTlIyLzA1bExlUjlvNm5BQkpIcGFhSEp3YXNOQk9PMElMaHl5?=
 =?utf-8?B?TnpzdjBQenROQ1ZnV2FWcXorSXhDUlI5U1lOeGY3S2JjM1pGSzVCS094ajVR?=
 =?utf-8?B?eFJoZ0pzSFZZcXlHb2orQ3pyU1BuZ0Vzb0liTnV3V0h1TU5nbkNWYmFsaU1D?=
 =?utf-8?B?a3FCTVZHT25JZ25FUmFnd0JqWlBLb1RYVmVDYU0ybVZ6NkxQc2Z5b2JFSENp?=
 =?utf-8?B?SUdpZDhFZVI2Sm9IYlJ3QnNuckdBUVlpWXFhVlJUbmlPQ2lFMWZFKzNROVNx?=
 =?utf-8?B?U0ZvUTVYK3h0UDd5RlIvc0VIaVdkVHNYRUhvd01LdWoxVkRLWG9UVkdpbjZs?=
 =?utf-8?B?WThwcWM3anJId3RZWDF5NndKOUZHYWE0SkF2MDRtTWFhUjZWK3BETGVIVE5s?=
 =?utf-8?B?WVdJZmhBaktzbEcxS20yOS9kbU1vQVhTT2h3SFFZcnBaQ2xVZjlac2NOM3JJ?=
 =?utf-8?B?TVFsQ0VaTE5oQkluWDJER2Vtd0FDZTF5TGtuWTV6SE0vYVdZZUtEeHFLMEdQ?=
 =?utf-8?B?WnBYV1lrdWlEcGZGOG1talJRM2ZjaUd6dzAwWUx2OGhGKzhCTlBJRy83US9q?=
 =?utf-8?B?VWo3ZU1LWEYzMWdKcnBIYy9ieENLejdvWVpNa3JsZTI4TStLVmNnMlVISXNB?=
 =?utf-8?B?SkpsMUlVS3Fydm93Sjd5Ny9ISTNUNWVYTUFXbGw4U21paFhWbEtmR0R4dVNs?=
 =?utf-8?B?QktydlQzeFgyN2NMRDVpdEFDOUNzeENjRGFTekt0QjZrUThVUE16KzJPS2xJ?=
 =?utf-8?B?YkNJL2NYM2lYVmdmRU1TTkhaOTErQVhyOEJUNVN3UXplSDFjNkIzT0JoTnFC?=
 =?utf-8?B?OUl6cnd3RWRWb0p2RkhrdzZjZzVNdng1UUFla0tJRzRMNEFHd2ZhM2dmaElu?=
 =?utf-8?B?YlpaMUw3bnVwWGFYaXhFVUVTcHV3bm94YVBKdUltYkZvYVpoS0RHUC9jVDZD?=
 =?utf-8?B?SnUrbjNGcGhpVkl5TGNJODZENlZVUGNhY3IzQStzbHhmdnBDd25LVHhtM1Fu?=
 =?utf-8?B?SWFOTDJ5azFEN01xR2FIK1IwMkNnbVppb0FodnFLNmZrZG1yaVZQUnZNK21F?=
 =?utf-8?B?bU05S1J0SmxybFI2NTFiUlprdmZvNVFDRWNQVmxmNXFPcmdCVVVyZkZhRTZx?=
 =?utf-8?B?NmJwNUNnQm8wUnplK1Y4R0U3azdxcUdnL09tUVN6eFZINlpwa2hWTGVOZUk2?=
 =?utf-8?B?VTlqN1VjdXJWRmpNdjZXL2JWeFN4UHQxaitKdElUWG8vbUhyTjlGSGlqdUtW?=
 =?utf-8?B?QmJVNHNJbGJnUEN6c0NNTU1ac0VEbzhKbjFRRUtIRVBhUHhGangxQ0hMcEhq?=
 =?utf-8?B?U3V0ckFucWRQekFOSmRiUkNTdUJtWHdaRVVRUVp0K2I0NmVhaURrZE1Kd3hl?=
 =?utf-8?B?TlNpbFdJMktjMmZzUG5hcFIyeUdaMjNyeTEySmdKNkFGRVlZL2tjVFdiUmdv?=
 =?utf-8?Q?LkKYVH95jFo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:11:07.8129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5c7985-5bc1-4bac-9bd0-08dd4f654e41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
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

There was a quirk added to add a workaround for a Sapphire
RX 5600 XT Pulse.  However, the quirk only checks the vendor
ids and not the subsystem ids.  The quirk really should
have checked the subsystem vendor and device ids as now
this quirk gets applied to all RX 5600 and it seems to
cause problems on some Dell laptops.  Add a subsystem vendor
id check to limit the quirk to Sapphire boards.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 225a6cd2e9ca3..dec917636974e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
 
 	/* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
 	if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
+	    pdev->subsystem_vendor == 0x1da2 &&
 	    bar == 0 && cap == 0x700)
 		return 0x3f00;
 
-- 
2.48.1

