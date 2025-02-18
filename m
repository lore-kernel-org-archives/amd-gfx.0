Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFA7C02198
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 12:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B57C10E3A6;
	Tue, 18 Feb 2025 12:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R5Jk0gYi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0095610E3A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 12:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxBCRGkR8JTMX2sVfWExezhW3vyTf0y4m/GhCgaSOVJu+nysSAf+1aF+BSvCHnV6IYk4oJEXIjQf4pJIsO/EUR9zGPvYiqvtW0hd+4O1miN8UJBG2Ed3mG7xnUBfYXjkzEAhlhD5DvtUHxlLvvnx5R6RtTo0kRCrD6ZmfG+sMfMddcYLVWeuNnwzjT3Ycg/FczfBUYpY35pyACXv5w6wnzZwAZVa0LYmMmtSGgUqf6rIoyJTZBxdtzTA1/GGvDsGGybQyboakmJBe7mSgSmaIBdwuZvdvmHF91icvWDKPCRT+uTWyoEhqX1Sxk8n2XROhNJd34FUetkZWhKAgwGaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxZd3TcFQhyXVDymhcozyuE33xA2nSUTkDkZgXAPzME=;
 b=v9O6hkT/AtNbbK9uUUjzhdU5klqJDeS2ffd3ZEhLVxFhLbZ1VB0AGYd+KX27r+U/4+AF0QQORi+YUKfNSYxMNPjKz8EcjsZdqhOhSdqIsiFW58E25WLGyKzexIoY3KgLwwiKN7Qb+fUHbahrS9+pC3ZZiGqfD3pnX33Xz7Gzh1XNwL8SshWw7mFY0eF7exfvg82iyOGg/ObXZ9uhJUfNOYWaeTYxnjafiS15FaBX+UjwpgxjwAwQW3eGWOctEuarb9VmFfMl5dQOP44Nypxy8HbXopJ2XgPep+5V4KEPgf/iQNQPxA2WLf5kMXmao1P86kqbeQgOQGqIAJf4SgUleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxZd3TcFQhyXVDymhcozyuE33xA2nSUTkDkZgXAPzME=;
 b=R5Jk0gYiq0V+6nekmCo+Q6SN6usd5Qd+PvsUiMpJWAoRXF2TSamqP8RhVVLcie4DsYm2Mq3kanj3XE/FCubZ9UD5r6AskYQGsSh34xuGUvG9lIPd8vhr1VYJhxvixD2vSPr9il7khI1fgaznvpKeZkA8A+jkyJlNSz4HvjOODd0=
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:16:49 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b8:cafe::f3) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 12:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 12:16:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 06:16:46 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fetch current power limit from PMFW
Date: Tue, 18 Feb 2025 17:46:30 +0530
Message-ID: <20250218121630.18577-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 864ca5f0-f761-4e2b-23eb-08dd50161e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4qGUFiapCg4FGqhZKvIMIu6pwLeXqgwKgzNN7oAqXtlGkQBPogvoVsdn7m+X?=
 =?us-ascii?Q?LrP6Kz28M4Kg4CBT7KOkZQTmGz039PGkjcd/MSVzc/4jtQf2Y6683m3ssrYR?=
 =?us-ascii?Q?XVlitwIzQWcQi2eGyg3G/EFbi4GpgXZfKWOSl5KyQLVkeRy5eAC+8kRJKUUE?=
 =?us-ascii?Q?IXAa28X+9GnjdPKxhK/QIl4/Jpv4ajbg7vHXlFs6PAl+kUUQB66Hui47vWLf?=
 =?us-ascii?Q?xr8UG6RnLf/1qOoPVZLz+9JoMmgZbUV6gbCaz1Urluam5rdKkrK0Sq1T1gav?=
 =?us-ascii?Q?+OtsTkGYEqtNSqMfisxJ3fSVBPZQbE+k1Ex08NPRJBGcjk8VyyAVCJgLDAQx?=
 =?us-ascii?Q?MjN92ivQzbkFqGYHZRY7gdsrDH6waDfEyLkpB1Dkx91URTrM9+4ucG/3hngw?=
 =?us-ascii?Q?SQLEeJ93nh2zys4NQ1feg62h3udaQ8d8s9nrXi/CT69lFZAWVJUhaSXEYqgY?=
 =?us-ascii?Q?7imb3hcLvHoMAhU49dWuDDS1w/7FdFLA8HR67R8ROw+t77BqiOJctHy4twsg?=
 =?us-ascii?Q?522i3jTDi/4hsTtrSJKjn+I4SK/6f9xgnYgLc+UCzhwhQDsDQW3Bsqfz8Q3J?=
 =?us-ascii?Q?lMiAEGpmljo/TpJgCP2VBkYHyWnhgtYrp0ld+e+5amoXn6sxoJKBNDbzLr5w?=
 =?us-ascii?Q?aBEpkaubrda82xnyjtHVn81uBF88+ZiyJVVPKJLhZfwgILcegChY8KqtCB8+?=
 =?us-ascii?Q?XhdxxfWOp62Duw4e8vPmmxbez76No6iAIFZGn/sATAeVlOgc1caa62mgmbv/?=
 =?us-ascii?Q?oniVtEoIIeYe+fizX89hXlDvg52gwTs0cA7IQY/SyzCgGyQ/smSRFvNUOj5P?=
 =?us-ascii?Q?j11xxnX2EhAHc/iufXr/TXt+uUk98pow/G5ZSLnjHa+7YTLwx9yEgXtJsavu?=
 =?us-ascii?Q?pG0Zf+/oKs66JdoDw752KetpAEKdHYNYNpk71ntcu5OzTFTcYhmbNUaLBnpH?=
 =?us-ascii?Q?lcV33EMDliVcHnOxF5HdIDLSVO5Z+N0nbF8VmqZLSNGe3/JLoI6hMcIp94ha?=
 =?us-ascii?Q?rQIdXPJM2eX6ZvbSVUdwXlc02CVbJ5hemDb/Gn0QWk1Po18MbCcihbCOg5pf?=
 =?us-ascii?Q?1K0FwSNqLjUWFYJgATT0EBwfgyAqTUOaAMrtpMPQDMgAvG0CyaVcwegx/RWf?=
 =?us-ascii?Q?YXHH/sjz9VvhedS0TrYPTCHERlO4AIYmiABB11fCcGm9mURWZyLwcQ2NkEDL?=
 =?us-ascii?Q?/7kwULkYxECTwVwZVZK7M5xn7243KA4EpPw78kuekQbixfiS4IelYsSa7QCr?=
 =?us-ascii?Q?2+vEVED6BKoZdUID7/+R98P4+NbH1NR+s/aPkPTg5f0pidksSLtuw44UKWuW?=
 =?us-ascii?Q?XI8dlXgf4+16DS3xy4DInEIQPfv5ic0eUcFFwEpvhVC5E+xQYO1WQ+dZ1//d?=
 =?us-ascii?Q?fKv6MjMcBRx4nRK64NciEH32dTO4/8cFqQvhmZOI8Fxko9GI6EJ+oDwkbdmA?=
 =?us-ascii?Q?8hHL2vBnx3v484TQdteEvFr3L4DleveZti3WkfFJWG49LzdJwci83nOq+2JZ?=
 =?us-ascii?Q?CX5ypvopTN9Yj3c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:16:48.5805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864ca5f0-f761-4e2b-23eb-08dd50161e7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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

On SMU v13.0.12, always query the firmware to get the current power
limit as it could be updated through other means also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7fdd7190a0c6..f0a14496d2b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2791,6 +2791,7 @@ int smu_get_power_limit(void *handle,
 			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 			case IP_VERSION(13, 0, 2):
 			case IP_VERSION(13, 0, 6):
+			case IP_VERSION(13, 0, 12):
 			case IP_VERSION(13, 0, 14):
 			case IP_VERSION(11, 0, 7):
 			case IP_VERSION(11, 0, 11):
-- 
2.25.1

