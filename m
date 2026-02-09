Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406F9EF070A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D3F10E280;
	Mon,  9 Feb 2026 04:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MMF3uJcp";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AFA10E27A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwlynojyagLOqBp3+8AozQDVb3aliQbbfNfOS607hVRnn5bHKMmKL6rsnRA0NJwlD7rkx4+c319oBYPtMDR70Cl5e39GrapNwfgAXXIGvNJUrmUaw9HyljT/uT4PUit5lolFeiHASom3Wg1nK/AiQN6B/J/hlCE0uII4GfTozb1C7t/DWVuMMoiTLoWo7gU0g7/1zREMx40L9hr9wbwt+ANGttyxoB153GRGvfHYSJoW6H4y72QznRPoz0+gH6QH6uQqqskZZkGgeeE2oggOUak0hdrfAgf0G6I46xBRYxNw0cJprA9HBowjpPhDStES3FQRKRsvSKDWG94nWyWxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nqvinp4r26xbC34OtiQ3Q0cJao5jBsnCexFkJSzWuxA=;
 b=NR9pSB3SyNFJXsUYJA3XzFotLRw3lJaGjdvhArjoNQ5vp16xBchzDjSBQcEmsQQJ8D9e06a+9KrT6cwGnOiFvjsLUZYNuj6yigsewJefIm7w7EQNtlvRt1c7GnDrKQhTcVuGykUxZiTc7oxVIxlLvOUvU/OUb6AMDGuDEB8aokra44IT4hJDelYCJStTbXxzrZSv+3E8iqjonlUGB0vGLCL0xmwCiu7u/OUjKK+a0t1h2BLzuixVn8xTruOZpcX0c0rbqfpW6JdyVwZc9+xpFt4fa0ZbJonB7D3rqX+IPy4FZC7CTk+oy3XnPKRXwbPdXXWBcXdV9DXuloazVDmpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqvinp4r26xbC34OtiQ3Q0cJao5jBsnCexFkJSzWuxA=;
 b=MMF3uJcpa27MlXRazSM/UQTaL3+6bU3mkm9n9hTv7T1SOjcchpglnkjEDzDbx27nMstfeq2yDhMfoeL+vO31fCfSO8buQg+zoRV4HS8j8gJEMmDwJ9zPHLQqe1SprAI1QFz2RlDb7DMCGT4tlnz3rZLfCm8HWD1DTDiMhVuZVzg=
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 04:57:16 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::d) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend
 Transport; Mon, 9 Feb 2026 04:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:16 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:14 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v6 05/11] drm/amdgpu: Fix set_default_dpm_tables
Date: Mon, 9 Feb 2026 04:56:43 +0000
Message-ID: <20260209045649.59979-5-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 90874974-f66e-4306-12d0-08de6797b27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?666RkJy1wAYZQRLs5Llac8FdRx/0zpqNPDPeKic4BJ+eFkS9yvyzIeHTPhau?=
 =?us-ascii?Q?6cVZ37KRdNwzHsnIz3jEM2+QhncvPEG2vFIiAYHRIgE6LzUmKnSuEZWgGi9i?=
 =?us-ascii?Q?xb4HTDgJFq8ePCAzGyRSRJ1Sqhl6YW6xbP09apjsMM3US4iikEPGBhRUdD11?=
 =?us-ascii?Q?iOoca8QWeJNFBcaq6HzuHl9eYYU63RO2nhhDB9mh8vhiVPAHqvZwWFBpGj0T?=
 =?us-ascii?Q?vvmZswhLUAI/c974QqTib69nUHDtErHcptp+QjWnqSw/8TaL6oubI74Gz47h?=
 =?us-ascii?Q?QXJalMOksAZMm9SJWEcvNg8r4lNjI1HjzBPGiSvB4HiHxjaRv/GLujawLMJD?=
 =?us-ascii?Q?9Jn6qVJbfM3OSkT3lun5aN5r6y5zsusZ9QOSeU624klTGMAlEfHJpwg2xkLF?=
 =?us-ascii?Q?TGVzmw9EwPLgR8z5wnKTpVsaOJ86o0Pufd5HHAWXYOGorfBQKRZHbuHyXM/h?=
 =?us-ascii?Q?nrbzs6Gb4Rw5xcghUS6EgVuyO/eQUW3k18HghsXZgZ4ekpEkcaANU6qw6sJw?=
 =?us-ascii?Q?OVE15vi3MqY64gYUKqnhR/t/+C1othTQmc8sizIVqiBJm9RbiNPzLou54kDM?=
 =?us-ascii?Q?ldqC9jA8AILdIuCIQhewiH3pwbMCJ6TBpOXwgFkDTe1cOjULDwHEnzpLI3qN?=
 =?us-ascii?Q?2hAYLCUjewK2YTCwOtkJhwlLW+FfM+UKt4gInka+2qea7u+fdCjJlEaVkPIG?=
 =?us-ascii?Q?Ec+TRxDc9MCDdLZASSTNI24Jjmp6LY2nS/AiRxpz/DjMZ8iItW68/4+tut+n?=
 =?us-ascii?Q?vrH8kbinfBkCz1/jPrnXbUGH4pNeXiU11sCBdLKtREkWk1DWxh1DC0wtMm4s?=
 =?us-ascii?Q?hBwXzSIXBERdED5sdimB1KZJkNM9FBuLtoc/2gE3UfSe8Gocy4XFHIU14gNp?=
 =?us-ascii?Q?4SSbYCWTg0P/tzakxY+xUHHOTI0ifs9cdlEP6EAZFizKg+pg2UcC6LAVgiBl?=
 =?us-ascii?Q?oVvBZeFj0qwwtM4jbKScLp1ZaSQF59GcleILupXDudOH+AaPFLt0bV7ZMXkL?=
 =?us-ascii?Q?3aHtni9wSDoOHoI6RyWzwkBm60oW5nc49cirUz5/WHxV5iv3+dxsqE5e8cAd?=
 =?us-ascii?Q?4bFH5vkghkiihM95BS0Gmlo67mwmgZeXaINUP9BCUTbNXqrcW+097qSqlxW6?=
 =?us-ascii?Q?hAJjBmsCPp37ihMROVO3gMR/kyVyTCrmoqYR4Mqn7XzTGm5SpL3JwBW3EHRk?=
 =?us-ascii?Q?2XIMoXP+tDXv57l9LWo16sZL42NGW8rQSDpyUTFXW/Lfc3VZ78f6hxCuORGZ?=
 =?us-ascii?Q?aZ0RUVsM8ganuu856KpJ3L9VE7d4+A/bNoVnDwvYj7UJCbznHWbF9cRV3D1H?=
 =?us-ascii?Q?1UjPR1VClxY5MJPcOnnK5mHGr/xm4nMRrTFGzpZUKFAthn7xEbkqBhY9p7VZ?=
 =?us-ascii?Q?VO187Pp5/LVIsoNQS2it1EWLDqfHnne0wc8RAD4H45Jf4obN3i81KAWAj/sF?=
 =?us-ascii?Q?bLzmNbYfE5cVVsn0mE36wqxTbw4HCTOfLWtT1FicsEr08r7jED5OeEcLLhN0?=
 =?us-ascii?Q?U64ORms9uKZMeSWiAPO+5EogoA906niUmZupz3+TrOooPCKzrIEmLF8UuHrq?=
 =?us-ascii?Q?8UC6Arg2kpozGKkB6wGIO1B4OdnnkherI8+NY7yeKEHHUaE4lZgEs5MMt8lu?=
 =?us-ascii?Q?qCtqjrSS1g5ed/lF606wjLSstyC+lj+nIbCyWMXPb35qOxpPGCZmY0NTfrzx?=
 =?us-ascii?Q?1/pMuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NqdHyw2gskzIzs625Szl8dCQMLeiVV3uluOV1s0Wxsmn+6GvNH6d4b2jMpoXlPwMN9CwOFxi3LtvUAh3Z2wKEmjupA9ZGwzZ3Ok5TPW6JIgv0c86N4BGg11VHUisbZp/aL7IfcZPDEWPm0y6gsX8OV6FBTQFF01Qni6oeVfSqwA0XXGbgY6a0JSdqi0X6bnHK550udGlB+pqsBiq++cCSHmbcamk6pgTecxBtw+pO4ZyGAoe8VNrrYgJ5Yp8+q4Hep6+6JdDi53ZJtH7+c1OPGp4UH2Acv7oFFMcMUmokDOQQFDq6i4k/aaKinH4uOpMwd6oJBNYs1feaGdSqPBtm5AR3tJ6f2oMX67NiUNOMoBNdkVo/0SKR5R9NVQF3RMEmxGzm1kh0jMHU5+EpswbCPg6fgf8QvgD9jYLX8KZX6q0lY8eE0mnG7JpzMz655U/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:16.4724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90874974-f66e-4306-12d0-08de6797b27a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD
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

Use smu_v15_0_0_update_table instead of common api

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index fe18af12aaf1..0cf5f76e5b98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1790,7 +1790,7 @@ int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
 				    smu_table->clocks_table, false);
 }
 
-- 
2.43.0

