Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD1C88CB9
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 15:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEBAD10E48C;
	Mon, 11 Aug 2025 15:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cj+AJqZn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A35E10E114
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 15:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJj4edsgK/rrBASvyKLkVFt9xx0WgDflzJ834FapaezeuWMo9dXYSbe1NXkXVuEpSwxH3tN5J0ds1r8OQJVpnmXycHdXGw+QC4vuoJVGV3zl55M08lIkVFmky/1aOFATlRpViRDt5Q3dqA0eZOPVELcvpVEX7F6m6uiNCNSS7F1ZkYQ61TgcZAV6NT38ro9c7eY6vmWyPxWccEBPe0zrUq9i1nEbtoL3vBZFHX+90qWem924y36gifUPBrTIuAbxb+LYOoyvO2nLsD4fldAzpTPgO8Z+7E9P55R9wiPMP39/VI30lxevaOuiG2ClCm86I6pfE1izfS/9pJG5+LaK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/1lRTRKcBTEsBC3IgQHmi90r66ALy89ZutOW1JyRPw=;
 b=HF4UeITCalz78StbBacj5TKBC7hfXoaBnFHYo1CnkVJQ1q1H652t91SPlfejP6s1t7XCzrOi9OPsXVO9whbS0PNGdlNfVbQxs0MEcQMBILPXyYRNdsDwbZysqV+Q3F4fERdr8k9QLknPtQ7/9NspczkQ8VVqFokLPzoElFv5AYx9LWB4yAS2YR+9Y0MzVigW3UFZjYDbhfIhQz1gzTuf48cSYBfHQQwZ1+HqKNOrNM12ajEnntd9cynJHhP3M/QgQ6rej4mh0+qxznQjlaCOmc7CckURzpUCyv/+i7wV6kCO7SuU0BFRUL/b90Qkh53fkAsN/+WWhkj8M4nBB6rVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/1lRTRKcBTEsBC3IgQHmi90r66ALy89ZutOW1JyRPw=;
 b=cj+AJqZnYH549NkJ3CV2BNCJDqYclqMh/hS9QRcm4xmK+Ie4RxYIt2RX8TBjbBMC93mQPrD/hNSPBj+jueFhtpfqha63175i2P7toXO0oOv4XSYbx8Zjc/FRcWdMg8enNBMlF+UDF85LRtiMbCVuFzUYuxSVDpL5272GOq44A1A=
Received: from SJ0PR03CA0135.namprd03.prod.outlook.com (2603:10b6:a03:33c::20)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 15:05:52 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::54) by SJ0PR03CA0135.outlook.office365.com
 (2603:10b6:a03:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 15:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:05:50 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 10:05:50 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>
Subject: [PATCH v12] Add CRIU support for amdgpu dmabuf
Date: Mon, 11 Aug 2025 11:05:33 -0400
Message-ID: <20250811150536.3394262-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: ef60f61d-c10a-4a6a-a795-08ddd8e88f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N8Eyqm7is36O9Rs1NWrTsOlM21S6AFSSursTv99izJI/+LW6hH7dkT3XoBYc?=
 =?us-ascii?Q?gMVS7t/DD18bzVYJatISwsVf70KT5LS4Fg/tR/sk3d9ozQcLxiQxJuPZznBY?=
 =?us-ascii?Q?+weB6BcQmfsAWIoTXe5E7hglzoR+miFI+aHLvEAr53WJB4ef63qLLPyw2jpg?=
 =?us-ascii?Q?nSYPhQup2l/NII4usS+T7KRdgy5eSEUA2F44K3XWiHG/9dx2sMKgP+L/1AZH?=
 =?us-ascii?Q?N/oeF9K5rpgXPsTXY1xfyH+iG/xnI1GFSYmgC1kbgWaUj+r6fkhgVfAx9g9u?=
 =?us-ascii?Q?5ejswM7w8bTANWen5KISE+CoGmI45YP3L1FKvCBZCoGvKPflvclrwqYdno39?=
 =?us-ascii?Q?s0rtJ8K+uZTTB+8ImPpPk5rcc3Ikb8qefFiQm1rdAU/T753atzkzdmZR9sNs?=
 =?us-ascii?Q?iCvlkUcai3NyBoLllVqwOeIgWoG0D+zkvNnbzS/NR8XwqZ7JnhGvKf7nyWNv?=
 =?us-ascii?Q?jq66a81d4byOIVOOKRWx/AiRPz3JXqJalyAxuwbDM34nfMOPlhFOPS/6CkDO?=
 =?us-ascii?Q?PNQ+gxU4ajFoZw+JKk+wS0CUFJ14zmRViBkrMQS9SfoGw5RoLpxl8Dueb48k?=
 =?us-ascii?Q?yyAPAnX+u0/PysDzUSLUFenF9lhAHQmBJEnzeDNkFEXKw0NMT+2awArMPza/?=
 =?us-ascii?Q?BqADnU7TEdTPJXMsLoAWb+6YJRWk9eBZxlJGpse1mXZX1g8IkpbTerHxLa8u?=
 =?us-ascii?Q?ReZXl4m2g2BzsUVDqP3uDgL1PnjCVcSQXQNrm6wY3bSXRomGqwNXVAiyrh/q?=
 =?us-ascii?Q?ILIJUjZPahWst+DVd5GWev3f89doNM4/vgHbbX6EFuRv7uPCbwSySid/xvBU?=
 =?us-ascii?Q?vm6kaLXyIWtYHQNgiVK/4K1QQmd0aQNsn2bUh58LdVjaxwvP/CdyDLH8DGMA?=
 =?us-ascii?Q?6K+juE9WLpAvCskpMB736bWIkYpPYden01EzAEYgLe5hf+e2g56XHtoeodZc?=
 =?us-ascii?Q?coowdyU7utmCP1HK7Xq3yGpTC9y8X01PaCWbi9ctfc8t3d3/zLGFfwRTBGdy?=
 =?us-ascii?Q?D06CR8plbz9NdnOOQo6WAU0W51A4h6F0h/d03C8P2jxYYoXUdadZn5EehrDw?=
 =?us-ascii?Q?eMbptG9XA6Zr7BojvVFTNtW8ksqzglnWdh7WyilTVeN+k/4j8HLt0e4p16LQ?=
 =?us-ascii?Q?vQTt1W4gWFNRk4jhQHeldBdG1ZMyO1bWh8vTEcAiMaiQnhb0BJlojYQHLa1I?=
 =?us-ascii?Q?snLDpPjsyATDiE0yzQrnh/Gpaazc2KbANTGxW47IYUEFUojZOQoU+7g+WI2F?=
 =?us-ascii?Q?pUAI051oFUMdrduYXYO5dCobFuffqxcna2RjH/pwIHkfVhvvE9B1davb0tHa?=
 =?us-ascii?Q?c93w62UVHLma4r8CV5AT4cQL67TsOK35+jIqRetyOnd7Cnd7bE6Za/cunqhm?=
 =?us-ascii?Q?H+PrZ+y4t+DpJ/SyAZ+473F8ZqI7pFFwRFUtQTuW7si29dt7LLEjRQkKBB1e?=
 =?us-ascii?Q?6w/Rl9S32iklPisNxQ5FNxGR+b5GrD1LP5cEo8mcCMQu7FDCklo8Vf6TDN4M?=
 =?us-ascii?Q?fK/5yaUOl3KiAmquAKQi6b4P1cpZtev3e6sT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:05:50.8004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef60f61d-c10a-4a6a-a795-08ddd8e88f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
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

This patch series adds support for CRIU checkpointing of processes that
share memory with the amdgpu dmabuf interface.

This v12 fixes some code path and code standard identified by Christian

Accompanying CRIU changes:
https://github.com/checkpoint-restore/criu/pull/2613


