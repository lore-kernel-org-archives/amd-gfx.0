Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C47C87FCE
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 16:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B11C10E0C0;
	Fri, 25 Jul 2025 16:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aqsTcJmB";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE0810E0C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 16:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN94aC4IO8gv6A/Rd2NSw54hr1k69SrICMqwAHBpzkvDtWbWZXShkhuoN5eX8fUhfLIg+HRulXajJ3ttHX9JbsQ6pjVsuU2YHCHePsYu87eIF0qwE072zpsIw8os8pTszFV1ZAQgCfBpAYtRScqZBYcixPlJY1P0v6EiDrKtK+0pIQLJDiott8Z6MTCXg5qNPTJ62amCXTA71PyC1JarXCSD41bUm2qARZgWoVLwUZO6IN6HcNgJ4QtmNBhXJe53fXpyLqFuzt1OGaiSO0DukqSuS+Z77JEuMArYc9xeROYrHawH92e1nSLfkW05IWu49va3IEfYKtTBTiIWLhSquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDBHBGtJaTImcMcnYF/NpyklKH5yszbsfhPLKAIurlQ=;
 b=O4rMew77FC8h/0Ppno5vh9AsRQq0epghxHQREZDjMwEUQxID0HhWr8GXNSACNM/UhEwy3+457DsTBnLL32bnHM/+fv9o3OAS28fJNZFkmiR6m1av+DVAbibNfmyYmeWDptDI4I02GaXDn4k93M+iF+JPbJYjKlMcn0o4gHsH9PMiCy7fR33Geq5ALmy+fyJGkbduBfSLoJJfun5KeeitdQ/hg3ivd8Za3Qu3VYhw8AN4L3ExjXx1joRthZH/bK35tlrwPubLcKQX6NxlJGESBZA+0mdrc/PKVrVt3SBZE9qGKK30gbvgYA6UQn3Ti268bpqfaa7YZcBwOrBcEIdTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDBHBGtJaTImcMcnYF/NpyklKH5yszbsfhPLKAIurlQ=;
 b=aqsTcJmBhNG+QpzgU2lJhOa8gSz1NT+uVstWcATgGmjVBsCGQ4J2yjuMQlzFYCAi7rKC6gOYuihDbzS1iGV/hjAP/22RFxhgeM2PD0ptu9luTMHRIJwtAZ90eqzcVmW1bEZhdoSpTP7LHy1AzgB4AlDlQjThZwrkpJ6jL93zwBc=
Received: from CH0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:76::25)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 16:08:13 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::14) by CH0PR04CA0020.outlook.office365.com
 (2603:10b6:610:76::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 16:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.0 via Frontend Transport; Fri, 25 Jul 2025 16:08:12 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 11:08:11 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>
Subject: [PATCH v9] Add CRIU support for amdgpu dmabuf 
Date: Fri, 25 Jul 2025 12:07:54 -0400
Message-ID: <20250725160757.231780-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 10901d0c-20d7-4bed-8b5a-08ddcb9574c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FZVG02c52xFB1J4rtjzqTW5w13BdXNaHR+0IrkLLPhoVWfGxaUzIxU/7jyp4?=
 =?us-ascii?Q?zdNV/blcvRG8Hmvavqf0di9CX6HFRBqpxjtqC4Md3j4li//qofz+DVLyPcDf?=
 =?us-ascii?Q?V/emL9NfRSuz4YoUnkLSnYVBClxcUhRHeSX7Vi4cpLpz3cvBMqoDLUbdk5Vz?=
 =?us-ascii?Q?rRLtbUBM57z2kTRC7HX47x7Y8wkGvQw9HNsIQN7cFAQHLJ9ai4ZE5UwKz+59?=
 =?us-ascii?Q?6wra3M35kakMelmIE5mnzq7pmmkB52Gjd4ufI23nX4gjBzgj5G80I98d7cIY?=
 =?us-ascii?Q?rhE3Ng0U4OV/heqzuRACsVvQQJgwH2ebruNXzyHL+0xJdzPy0LEN+a84avMh?=
 =?us-ascii?Q?6DAkCCIDGjy80ecxKmxsAR0lYL2CfGVRu/lwsYP+nP1fXBVM9Y0ZpeYu2AQK?=
 =?us-ascii?Q?phGNQOh7hNvCJjHIJLLrp3KYPWSYisLhIbpEtEjnsxvbOWnNXlOBRxfo1deJ?=
 =?us-ascii?Q?DBeglJN2qaPuQgKd82JOtOJZwCvIwzmJaw55qjFP+KjEDsiYh0iQleii1IWC?=
 =?us-ascii?Q?MtI5w/zUCS9iHanBUMznLrUCA7kZThD/yx3LFxhSaMYGrNM+Vn9BHT3g35FO?=
 =?us-ascii?Q?kRyAkmjhI06dDp8DGM1IXHEi4AmAAjCCXOj/Do8XZDd99xKTWbiK4/Ey4TC8?=
 =?us-ascii?Q?1HZdsV1dezooA5/2Art4bX7pOMdnq+4uC6k3JYAptn5MZwZFyWkaKx5feNvS?=
 =?us-ascii?Q?kERhypjBNQkVwxOTQm8DWT2SvMQVRrc9gIUYD07u9bXQ7jDbSD1u6Alxx9cv?=
 =?us-ascii?Q?RQPU0Vs7/Zu1lsSYoVLD4I/EA5ayK5iqQTTrk7Lwoscz06srOUXXD9yZyLpF?=
 =?us-ascii?Q?DJRbNOvDV80DmUzhBuKVXBEPQbOnElW8Vh2lt6MWixx3yeGQXnkOrJFaVQmo?=
 =?us-ascii?Q?EX1/UYFDcSwShymoiAFKOHPIna/uBX0C02bmvhKHzka6+SNv8GQlMsS92BKh?=
 =?us-ascii?Q?dpE5gW7xiRiVTS1YmNYBzdBXGwecHLAjbqwsvR6zqO44V7ty1dEeTKcPs4Ue?=
 =?us-ascii?Q?p9Mk3HXdrnvHxmNCLFi/5iC4+z6n0lnDoviwkNRCkIDy+FvORah7eYDD4DkT?=
 =?us-ascii?Q?mO7YqGKirzdtnJ9GwyehW+HTqs3ZTa9gCpmQEujgvZU/hFlTzdx/OTf8+5ek?=
 =?us-ascii?Q?L3OOt8BuiKjGHd5yyAcUK/bT4FQFlng/8hRNYPhfyL8pj3yvbByDgiYZfWZ2?=
 =?us-ascii?Q?h3fQFCmoClhQdR2Quxrhna00KoTti3itSRlCWD6/clsu1nNLcXrsNDdVMqVM?=
 =?us-ascii?Q?GC1AP1Ndn5FxtnQXYNzO5vjkfB7gZolSVX2tgX1uxAoDRjFWGO2YMh0NIqSj?=
 =?us-ascii?Q?0W46Neuys6I0UUKZuBLoAx4ZdHYtcs6ZVEowVWdas8emjU9OOCbwao14zs6E?=
 =?us-ascii?Q?RyqyqOOdOaZflk/9h3PYOp3tKCG7UoBXGqb+ceqJp/b6x+CO3t9JuJd9WfYk?=
 =?us-ascii?Q?LYClk9kJMAb4Mj3myZnVwquZh+s6dWsy4Owv7p3cPu9A4xrcexxRNRsbo+Qv?=
 =?us-ascii?Q?JdUKJow3SPLkZZYbF1TMTRhRnTWDGNM4TCusUAaK8cHRH5i5Pd8TqNuPRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:08:12.4689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10901d0c-20d7-4bed-8b5a-08ddcb9574c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619
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

This v9 adds padding to the structs to align them.

Adding Alex Deucher beause these patches add two new amdgpu drm ioctls.

Accompanying CRIU changes:
https://github.com/checkpoint-restore/criu/pull/2613


