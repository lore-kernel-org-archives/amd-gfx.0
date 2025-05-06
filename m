Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC99CC3ABBE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 17:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA68610E70B;
	Tue,  6 May 2025 17:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ro5hwOvM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608D310E6DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 17:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxK54rgqAGxgOpEyKj3W2e2C8vsxFKx8Ptxb8mzQ6VPTT+Z3uJtAmRjFZNJILFvPzNBVIXDtI0ebq4brKbuIOCaCzvG724AyJ0GO07IaBZe7xkpv5CjTU/+7qTjIQP9CPj5NhIr2PDWUwa6xdJBUkyIi98G+ONnuVFq6L3XvHzIhkf9QXHXu5LGRIRUFpMxuuXzPGVhC04wf/wyQiIgqES0QxEo8dxxcgZ/iwEbUpNzGe3DV0iADvNkYHDCDJdJ0UIHTR6lYDqKRRFS3ucErwTgN2m20tMAkAQp8iW8fv90DVWaRDHuU9f6H2eVPaW3iv5nCA+dM5+UgjDolrj+NHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpenFpEJ3p2V9T1WisGonhwF+ia9D3alZ21TGYnaRWQ=;
 b=qt7SFoQ1f5f2upTLreJ32r3Wkr9ftX1vS76n8ihxkEOhDn5xg65QjGpruoGscmPafX0HhZmVAHjn11lgFS0NPmCyuqf3buRMNqODMOf2YpSv5KFW+MVygxI8xDj+JoEq7BZCGRVtfHH9690BNFq1klx0cfli/b0iBzLGjlj9ONDRIVIcP24xxtxYet/mrtfyBqBs/RTzGATEh6xc2s9iwRUquAUvdaEa9v40NPz5rM87ej1gSNUTrnAe2jq01dWLg1wlIn4HPxmbCQeRyfd8DP5LrcjL8m05+AX2YW6RGuyTEt8vcgj4QvnltXc2qOmml8N64kzfNIIsXU8849WJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpenFpEJ3p2V9T1WisGonhwF+ia9D3alZ21TGYnaRWQ=;
 b=Ro5hwOvMcXaSADE33jcSjp/k/qSUvXSmZhWuUFBVxypEEceyH18EEsi1ldSzojCDuOXIBnEZi2FrotcV87dwet/GVSjgIAHzsIoK5iKfgvYcT3Fi0EGARjafvqK0iw/mN8F+hbC8LWM5GFSpu0eoVMsUr2wqMSBoibsDJmG9+hk=
Received: from CH5PR02CA0004.namprd02.prod.outlook.com (2603:10b6:610:1ed::21)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 17:54:44 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7f) by CH5PR02CA0004.outlook.office365.com
 (2603:10b6:610:1ed::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 17:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 17:54:43 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 12:54:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
CC: <David.Wu3@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/1] Add workaround for VCN 4.0.5 timeouts
Date: Tue, 6 May 2025 12:54:18 -0500
Message-ID: <20250506175419.3518-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fc7358-085e-47ce-684a-08dd8cc7151a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WvMzPKKcHDDRf+9+JeJqXmelQkL+VFaJvLAtehjuo7tCFWAJd8rlkXyjnZU0?=
 =?us-ascii?Q?zo0ZOS8dRfIxQlVmvuwctieJ6iMVsxABOm/d1Xo80EOqEibOywnRP4fP5C1B?=
 =?us-ascii?Q?rZ9oeXV4kJKuFPoYSs0na71IlJjSpnv29MQOT5bUm57fbNHysWx6I8xPhhbQ?=
 =?us-ascii?Q?DQwT9CltE9o+bRK/mgxjzJj0p1Frrn0kEdSo43xtk0ijxwxxUsZP+Zd71zwj?=
 =?us-ascii?Q?Mf8pb99YMU+E7Por5zAlRw5lSkQjEBWMJcadl5gHX4lxSquqTuVJtPYGVsDr?=
 =?us-ascii?Q?TOIcKj2iJzbOsY+/xcMi5LkOWDPg5NQOlVnWGoDaWWQn7YDybjt1L7OdJaVd?=
 =?us-ascii?Q?wrqz8HqBcbxuOjrxaxRqkKIyUosARq0E74BfRasZDQabiTLq7dpHAcXIGzzE?=
 =?us-ascii?Q?fcDSTEBqdX95MfwaTP7ynvkcpu5+j+X0nGPaD1Ew+JTiDs3kLMsQrJ4apaeH?=
 =?us-ascii?Q?bL2vSu/FHSew0ilr8V8/vLB7zyUO9B0FkHsANqsdfPnV2lBjodkARCTQ7Ulc?=
 =?us-ascii?Q?BGjfDgjsRvTBQuC6p7g3rNOKhM8twzpBqnNGe3iPb5m81kwBAGsEX9asr2ar?=
 =?us-ascii?Q?Y6UOZ6EuFhwGyqB9MGCZhWoar4xJy6GQ9gH6cbfXIQEqIvAHaI5fYZ2+sDZL?=
 =?us-ascii?Q?nuuTCx+9YeKvqK7m4++q/cJoZQ6rQqJ1bEqJhJI1P709+IcnHpIHRVYmpbZX?=
 =?us-ascii?Q?QHgnig+MAhbR7EzyYdsBoEMtA6BtHXNOYO8QJc8PWnyWKFvhnD0o/+rGijFG?=
 =?us-ascii?Q?1tSRJ0Y4DUVdooDu7Y354W6YUEsio8QO9v/CYrwa+WBXuxspgwTMtoQm4b4T?=
 =?us-ascii?Q?/DK6wK0uVK0TE4UramGyJB/Hd8xaglmNP1Ynmd2cuhzVhuWB1CkYZC9izowO?=
 =?us-ascii?Q?oqIFwbp4WsPCRy33KA0B3NCFzTcDr6k6B106Ps+cA+WZkEb7a6inIWe4fdev?=
 =?us-ascii?Q?IHsucApTBne0DRnFVUMvMPPmJApPgnmsJOaDSI110Sq24qypijIVjWNI+YC/?=
 =?us-ascii?Q?uzZ92ugFngnfqyw3wzdnNtHLPeW70HNAIrofRW0WyXAgHwS5Hucc8JpNtx2J?=
 =?us-ascii?Q?CtbQbKFw1n/Zg+GON0rMwnIACiv0L++GlyTsjFKHT0zZKQ80/X6GQuwFdQRS?=
 =?us-ascii?Q?10cAdXiSQGdF2pL+N9EHgDChhcMgQfmfNqZV1DTK7bJ8KjOj+WggP4KNgIXY?=
 =?us-ascii?Q?qICWhMT36LifYNioBkCT8Z33o1cLkc3R0bKKnaLvEQBpcAJZSd02NGf4UZh7?=
 =?us-ascii?Q?iJC8wf/ds8af/B/M+vxEtm0IzdlozTLFNX0NGgziC/0EAokRgbJK4TbIZcTx?=
 =?us-ascii?Q?a1lUWtR5SRduIFCGHRooa9ybPOR4tP1EoNgMWrO2ELLt79sakzhf3LfyNCn/?=
 =?us-ascii?Q?RcSB0ZvyAUxB55yuS24OUCcAvAoY2UOGoryXVJoSY0L1nQw45t99z6ywI9kb?=
 =?us-ascii?Q?/OwBNqrn/ulYz0PK8xNfZ2L7MtO8PA6lgoMhCuh1U8S+iA9nbEy5/1HYrAwp?=
 =?us-ascii?Q?p+0Dt8wLai4l881bClAhPUJ5+u7dKN7LBJxv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 17:54:43.6247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fc7358-085e-47ce-684a-08dd8cc7151a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

There is an issue reported on platforms with VCN 4.0.5 that some jobs
are timing out.  This leads to a full GPU reset.  That full GPU reset
exposed a number of problems in DCN that have since been fixed, but
still the GPU reset means a black screen for ~500ms while the GPU resets.

However the issue with VCN in this case doesn't require a full GPU reset
to recover, just resetting VCN is enough.

For a workaround while the VCN issue is still being root caused lessen
the impact of VCN timeouts use the per-ring reset functionality to reset
just VCN.

Mario Limonciello (1):
  drm/amd: Add per-ring reset for vcn v4.0.5 use

 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.49.0

