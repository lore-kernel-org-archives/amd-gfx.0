Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2E9CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2720E10E748;
	Tue, 16 Sep 2025 09:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c85LmuTN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F350110E746
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl8c0w0GRFmTyXJmGOO40lQkHYsLwfrBjZLsbjavuwsRugBg2NMeLV+P6uNVN/hVtJl+f84li9PGMGuWJ/McW6V65y6HHha45Sbs1JfcC9fiaVrAXEFASzeAiZMDqhkdVOcaCAf027eg4E+FV57QLZxJca3xLaljnP9CGoFB8Wf575CJZG1YR8SlG0BSdc772AhNOJ5+pfv3qjOVy4+RstxJXWc8gPTeBHbxW8Fkfs9xnUT7lnLG98HVzRY+MbEoKXVVi1i7CAURHAGeglZ/4U28YDGv2lnZTJ+qbefCjbzQdfVSk+M35qkjAAIvLJxge8dTes3L1BjQcahvJ5a8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luBgS/SpNTezgOM0bVagQaHQgL6dkuVqKZ6wfvZ0QUY=;
 b=qCR1Rkhs+XSguGt/b/8qRLSijG4xQeaSqsKwAewpU+Q+2GekJRADQpHvnSECEJePgVAW3ggyLbTK/S6XWkMfxl0XATEENKLR8pHLJprJn1KXYNHQG2uD4wmTjUO2DoDN5okDFIsf9xeWcEZwosHlXPET1vkbrkQtGfqYJib30vNQjhQmJNoXhlMrXIWURr5Ud8vll809IjAQmR/6USKTUp9D6G7BWvkSC2d/ri7sdVG1bEhQS916vBX1fnLIYMZivuVE4Ey23CbIeKdRjvpg+JQzBysTypkMXlQx46mnxCx7iceS+5847jCSDyAGVLVkKqO/x44u5fQJHnTj+KomYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luBgS/SpNTezgOM0bVagQaHQgL6dkuVqKZ6wfvZ0QUY=;
 b=c85LmuTNOYRxzQmL5/mtd/w9tlWA6T57tFdpveV1kjfjZwihVuGXkJtFDLPTLHmY8lJ3hf5bgoNIhTBRotRZPh2s0+1teURHECNVhA+ysnxt8dA6ruWqL0oyqY1iuCFtbX5wlBCnsxcTGN/GNeNgmNOrM4KqevonN81Yn/fbSqo=
Received: from CY5PR15CA0014.namprd15.prod.outlook.com (2603:10b6:930:14::35)
 by CH1PPF73CDB1C12.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::615) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 09:05:55 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::df) by CY5PR15CA0014.outlook.office365.com
 (2603:10b6:930:14::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 09:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 09:05:55 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 02:05:52 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 6/6] drm/amd/pm: Enable npm metrics data
Date: Tue, 16 Sep 2025 17:05:27 +0800
Message-ID: <20250916090527.2727930-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250916090527.2727930-1-asad.kamal@amd.com>
References: <20250916090527.2727930-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dba517d-e09c-4017-91aa-08ddf5003e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pHcD0OHgAr8Vk7c71st2C015nRVRk7QNnAOGZm4NvluIMMYC4kgvTnf6KpLn?=
 =?us-ascii?Q?qR3M2IpJqf/2V6UDngcbKrJm08EL18QuxvUJKnTFZ6b2yeyq5xuABQyEcC3S?=
 =?us-ascii?Q?eiLfrzba+3FejY8l8+qh1u8sXNEiJrOlrUvkqZTfhavDKKe/xXa2oOUtLyqi?=
 =?us-ascii?Q?bC0btqRbxHNxKkX1NrFfZjRdNAdkzw9N+RtZf5gFPaL3D384G6oI2YiyBylP?=
 =?us-ascii?Q?shy5GlQj6KLSu+79vBFUxyvYdkT+MoKFliYmiSeKOmdSRdtoKS6cZz53w5RU?=
 =?us-ascii?Q?qlkoL8i6x8Wq8fBDRF48tNVPwM2WIX/TZbey4KBYJuv3sc/v3Or4IIHK9Fe/?=
 =?us-ascii?Q?eY308pKoLD8eg8Qocqy+eLjGpyNr5tRVuqb3dKEhx0PdKq7GYH+FkoFvixls?=
 =?us-ascii?Q?4xHj9JgvpwZTNkM5B7JlvdS5Mwyt8kezPbx4EmwRtY8sFBdYcF/4nvFUDvEi?=
 =?us-ascii?Q?7t8/5aM2TIlHxKmdwXHVf7ScyXszrccUeqHofD/sYzdY2mMNLB90ATM7WEk+?=
 =?us-ascii?Q?qPyVp6sCVFfA6LpGv0+tpbO+WgmMMSDOtYe+DuE3uEiWSeYOW7sjWdVAnUq5?=
 =?us-ascii?Q?Nquk+U2W0z7Enk+HzwhhXo8xdFb49Go4CsAm0+Q2oQChazzoZ4VKqpcfYCbx?=
 =?us-ascii?Q?tAUQiLDLztBv+ydKIujfKF06VvZ+ftQLEPFeTb7Tg0uhYctFyp3SCwENed43?=
 =?us-ascii?Q?MLXKxOOLOqCyAFnqHH7ZgQDdSBpl4rgzJmqO25bO0dLmL53UFUJHOQMYLNar?=
 =?us-ascii?Q?uvqu/sD3nwhL4dSkoGYfu0PLnaNKG/Y9MQcmmO4MgodYYwadeJsGbdP/gP8m?=
 =?us-ascii?Q?kn7AoonQelztIL1tLz7J8vvFKqbwXwzQUNwjA1aYZ4KNlcYmz4a8x76e6lWl?=
 =?us-ascii?Q?r7cYcmmHr0pbjIpx0FEPtE9eXN79jE8gSpA+zlw9S96yN6QPWuQT4NGSUiqM?=
 =?us-ascii?Q?8PeVTkB9uiAMnqVr7QE0z4n6R/LHtCN2qlFanpmfX+Hz7Z6U0iNGppSxV734?=
 =?us-ascii?Q?zP4G9gC+y9/xT62PlxS7ZYLnj8lJjm3Gsz3K6OMAypwbH6WFlqiTm1dZ/1sp?=
 =?us-ascii?Q?rpPWX16gOGovAchPZqiJVeTiD/BRFyk8HSBOx5i36p+ISg9Vx4So6pj+Ks9U?=
 =?us-ascii?Q?k5kTFjdU6ZTrekPXQVmsWRVVnmPA/HHmxUNoFFWYQt5m+5r5SfnaArfAetFY?=
 =?us-ascii?Q?13eEMU2T/Tbc7AKGBYLuP5ZuwQbuin9M86R5U3UowFnqJU/6cQkhudgT02NM?=
 =?us-ascii?Q?WikjwRrLXfE15vWYjNfmDmTEgGBlqVk1UG2tZlWMan/2jxyZVizsBk4DmgY8?=
 =?us-ascii?Q?IRqnV+MkJ4j9bokWAFPEN4Ch8vW9YjJlDCKR/DQkf6bFV30gS2P/+dbn64fI?=
 =?us-ascii?Q?wIN4RxguOGR6lVqAWrAs/13YnR0ZAx9gHVeAxDAE6c/gdSjSKX05BTP9JEbE?=
 =?us-ascii?Q?ykDC91l1okTpOxd5Mbw5d4EUgrn6GN5rgY5thiNuWGhT8aBcEZknwCTorSAB?=
 =?us-ascii?Q?afn0ZejX92GtFFTs0qwndkvCWiWs4cy0BhJ/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:05:55.0005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dba517d-e09c-4017-91aa-08ddf5003e52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12
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

Enable npm metrics data for smu_v13_0_12

v3: Add node id check for setting NPM_CAPS (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f749acc7d48e..03b6a9969174 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -356,8 +356,11 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 	if (fw_ver >= 0x04560700) {
 		if (!amdgpu_sriov_vf(smu->adev))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
-		else if (fw_ver >= 0x04560900)
+		if (fw_ver >= 0x04560900) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
+			if (smu->adev->gmc.xgmi.physical_node_id == 0)
+				smu_v13_0_6_cap_set(smu, SMU_CAP(NPM_METRICS));
+		}
 	} else {
 		smu_v13_0_12_tables_fini(smu);
 	}
-- 
2.46.0

