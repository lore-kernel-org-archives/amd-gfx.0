Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D84C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 08:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF2610E5B1;
	Wed, 21 Aug 2024 08:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbqJgTnC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D61289226
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 08:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cESU9CXISgZeUKrLaDQfa66nrUFe5nTP+rQanwx5JQi+4QJmgC2JzKDegg8XlMHSXfFK0eO/kt6fKxxnuuQWsXXb2861qxrXg04xPE6cTsdhdLxyrOKCdeulblppWEcexj5EkwMTm2DtcpUE+oY7buwzLnasHR+1ved0YLgMWcbWpSUtgxGqYLe7dCaXSHZ5f2B6MCLDO9B4E4Z+Votd/BRHmzGuH8tLi2SJ6rI21DXUMLI6Q12ZQE+5nA1WEujU//rh/5AwH/unsunWs3PiR5KFHU0crVf6r84heN82B4JE5sdBWDDPF5nAcbZKcrO1EtWHJS9m0H4Ra0SU+7saew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHobq14fQ9IxHe6gclZTqBnquigE767JKXZkppO33W4=;
 b=L8F6a+x/5WwDXQQj+egQ0ExfobryWuX/CEQ689QVgyZ0ufKBlemkSa+lFHxX0L9tW83CF8I2kLIz2Aaq/iJBDMBK5KHP1s7upgys94ZoSFxv2vkN5C07kY1RmTGkh3qIpbXra3/Ctt97tmWKXZKUMu5IbfD2EUOz1rqgFT+Tb7wMod1JOOIs7XIAGiQcnWLbWYWq9/mFeYgyl5s1CRbPBCX9QHOhiha1xEz544123vm3tQjNFqmVF7RUgwINHAkQ+iO+dR/PxMUoUtBPy6gyJKBq6fIpzequp42ztTX6q1GNgWzH8hSiVcqHuoFJ79yZ4YtKGyfEsJ8z08HoZ40qmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHobq14fQ9IxHe6gclZTqBnquigE767JKXZkppO33W4=;
 b=bbqJgTnCXyixShnnOm9uxCN1sRHZQdBDd0MZxZC8xV5GP6CiYoGx/gAPzNErXCxbGCJbTEW/V89dQlDSCopvoDwPHdCFCnrvATXaM/kUsKDfkhKGu4S5xWiLYEiYG5Ba8GX6DbIaW2Qi6AYOsTl6dIbvPHfr9oNtI1UlI46ZZaw=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Wed, 21 Aug 2024 08:39:44 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::6) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 08:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 08:39:44 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 03:39:42 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH v4 0/2] Improve the dev coredump for gfx job timeout scenario
Date: Wed, 21 Aug 2024 16:38:39 +0800
Message-ID: <20240821083841.477392-1-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 725cd3eb-74d6-4b33-a887-08dcc1bcceb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qFxjW6TC6+W0LD2xUMyZveAxUb99EqUe+Ps5FNfRgyylgGQYbXYP9h0E0ab9?=
 =?us-ascii?Q?IAQ252OX09GXw5wajWex/TopKq/fEBFQ372Zn6TKtTuCOxSEfcBujIuC2PbU?=
 =?us-ascii?Q?Un3sUStp2F1slTt5i9NTlMyVUcMZVGS222wJRhhE9jmyFGbkaz+3ayzJdc8Q?=
 =?us-ascii?Q?CH+wyGC8qy/6lsP7zlklh/yWOq08eCuqom2ADbjys9FkmjfTI1XElDqGAEc3?=
 =?us-ascii?Q?3g736iEPbv97b/F8X6vPwF5f0QP5L+9RZXr+vS0PeVFrU0yEsJqiBtHWMUwH?=
 =?us-ascii?Q?cMj52HLFlsEa+6bAepoPaQWt+a6f4c1bYrwsDSDM2Y/uqQgOqILW1gcS4rSQ?=
 =?us-ascii?Q?sAl87BrlaY/AY4UONgUg4A4Q5p5M7apGvHPN7sQK+lIAhaIW38/o1ElCCd1z?=
 =?us-ascii?Q?Ctjjoyceyf10RN7hSpOm0rpjbdtM3MvHdn/UynZobYPzMnXyG2LemEvJIQWG?=
 =?us-ascii?Q?HU1waYfaYxAt2Asz7i7V+MqTh8nFlAild7I8U2ea4+ils01ccpQRnQHO+NS8?=
 =?us-ascii?Q?oDZudnw1pOoVfQ6M4dysfh11SEnnisEl1pvRS0LorSEqHLTf/s9QOZhqIAnm?=
 =?us-ascii?Q?2guzjwK+Pyslmby2oXR1n3BUT02pwkJ5RE8dpKpE1IdyMg0ALpobxz+eeld7?=
 =?us-ascii?Q?K86f+0Wa+D64f/V6puEDF9os2pn7WzoC/FWXRuYW6v76zvvUCr9mlTQf3cPZ?=
 =?us-ascii?Q?T2Y6xvNNMxZoLlj+M0d6eI2Tx/IxrCgC3EkznB+7f4HIu0yUoG3esgdycaSV?=
 =?us-ascii?Q?y04qcQhysJgLu+u1pfIZMp9JKfy/2Z3zVHxbqwrKRw3OkukwN5+iP+iya6J0?=
 =?us-ascii?Q?6FK6hPN9Noc1jGeQXb4q0SfuvwPq/temDivO91cDVtKHi3uBoJe2nedAv5+t?=
 =?us-ascii?Q?rU7qFD9EBRmRRg2XGC4isXwhc/h6odrP1WkS75h8QkRVCWzgj64Zm/sd0Eyp?=
 =?us-ascii?Q?AXxH24HRw9hoY+RbaZzCtGlxITheocZodNdNCmESc+HiVZv1qXoc5OxWsawb?=
 =?us-ascii?Q?D5Es5orgo5dBSLgu3QdFE9HcQmDIq2vfkJEYgw2C8P50hoTRCnYTDuAVgZQ0?=
 =?us-ascii?Q?KzPe1LjaV0BTTbbxZWhg4OVmAPkeuXGqKjw+SoQxNiem2ItvbytfvOLUG1o4?=
 =?us-ascii?Q?FDyPAKOqkac1lJxq3+5tbUcbaq9TiKZ5Ul1pseKoxZ/ZxVOHyYlvGE8Fwfmf?=
 =?us-ascii?Q?N6OhjpTvhQGkpV/fVKAvKJ/rjPFFZAjVukzEeI8I8ly6GtkrfBOa4DpI3HVS?=
 =?us-ascii?Q?TVLypFv6yflTyuk7mbGErYRpLWul4IBhAl8eXSWyQ9LfaO/gHzJBv70G85UP?=
 =?us-ascii?Q?WqPl7RfEwV4mNcoY6LLUi12oYRsyBJ44KU+fBH/akExzE9scqG4R9Ocu3r2t?=
 =?us-ascii?Q?M/UDBryZ6LZ77ifq+sF2x7hzaqNa7XufDBAA/Phd6l9Ka183GLxzQRJmB3Xv?=
 =?us-ascii?Q?49RPHY9COdTKfU+i4ns6fPoL6PNEFinH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:39:44.4672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 725cd3eb-74d6-4b33-a887-08dcc1bcceb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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

From: Trigger Huang <Trigger.Huang@amd.com>

The current dev coredump implementation sometimes cannot fully satisfy customer's requirements due to:
1, dev coredump is called in GPU reset function, so if GPU reset is disabled, the dev coredump is also disabled
2, When job timeout happened, the dump GPU status will be happened after a lot of operations, like soft_reset. The concern here is that the status is not so close to the real GPU's error status

The new solution will unconditionally call dev coredump immediately after a job timeout to get a closer representation of GPU's error status

Trigger Huang (2):
  drm/amdgpu: skip printing vram_lost if needed
  drm/amdgpu: Do core dump immediately when job tmo

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 20 +++---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 68 ++++++++++++++++++-
 4 files changed, 82 insertions(+), 15 deletions(-)

-- 
2.34.1

