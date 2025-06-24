Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01233C7115B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 01:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A208210E497;
	Tue, 24 Jun 2025 01:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKLaXYzn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F7510E49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 01:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxiRmOmHz8Au+r+EQ1QQq9OjxjEmjpBllBR0QHk2pmdMDMXSeb4ICuWcBsbhdrz3hYP677j+SwN4ocXRqEhWtinJz/u6sIIrDeTUhGK7nuINOxbk341fe+SG0/vYREfqYI0vdMf9KUAo7ACBCjyZor159OapnbnuiEANN4MQm5jJ2guhqU0p/4EFuLYb3CkKjsKTTRUzuaJvW+WvHlBeFkz5l5o/VNIp658zcLQFsFTvCeBuBmxMj0t8MUcZ37ct2C4Tz/4+A0JRNjaGggDsDbafhnmC96zLFjr1VQpFZs3OVm1wZLJ8qQMn6lqs1+FGcaE5cug7ZykXeq/2kRkSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1uSM44jpfHkaIvBt2tX7UHc2MbF92gd2s/6iqr3FA0=;
 b=HaiwKVs969KQH4g+tTvBmfoE5BIEbeGvfymmi5rKg5V1saTRpiSArmmvIiaXEBPTbQtgh+MpVCepiA/AR6yQr55ELBKsZo6/ACbMmDYxcpKzxf0X8ZR5l+Lcot91eArcnlN84biBnfvYkj07YmWGWuAPwoXruLm83/2TYiWhUgFr2qNhkQXD4eJM14bPplX2wgCThURGPK30ftwL712RXzKhXHeLmvDYRevEBOz0r9Z7OVn6x8+zNrGEnpaZ+sM1avjZZwCOjMmD/epAyMEE8z8n69hNPdxREzLbT1M8fK63mxuyyoQPlU+dky6kWilpndwDa+RhEBg7QGPyi4TXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1uSM44jpfHkaIvBt2tX7UHc2MbF92gd2s/6iqr3FA0=;
 b=zKLaXYzn9XSBPCwpqJVbNYnAeCeV6DBUQ2cET1e7d9kmheDho6QfTNbIQSNwSkEbAo4SeTUMKDmZq0RFRp6wX0AFl3mk4JGVGt2fgm29dkZRwG5P8vLccpuiKbqJlcf8zCjMVDu3/LfPmrEasolEMcfM/DVMibY1W+tT6/eBiF8=
Received: from BN9PR03CA0494.namprd03.prod.outlook.com (2603:10b6:408:130::19)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 24 Jun
 2025 01:53:24 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::c1) by BN9PR03CA0494.outlook.office365.com
 (2603:10b6:408:130::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 01:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 01:53:24 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 20:53:21 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, Meng Li <li.meng@amd.com>
Subject: [PATCH V3 0/1] Release xcp drm memory after unplug xcp device
Date: Tue, 24 Jun 2025 09:52:53 +0800
Message-ID: <20250624015254.1162196-1-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 23927fec-fb3b-48c6-c252-08ddb2c1e7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zq1U41BzgTElxAZ0GlDcVF4ALzLN5sPU6tFCUu1d5AFsFVmssjEE4gopiW/f?=
 =?us-ascii?Q?ZL55jHM23bjWdteL3LBz257Xn+/3c8321F+kXQ98rPoKpL3hk2BpVfw1cUOf?=
 =?us-ascii?Q?qFjZA8Pb5Tpkp8fYy3synbn97YseKBb2m1zJSBSngtOFDspBAARkxGXOMrLp?=
 =?us-ascii?Q?UOHK1lVHYSwnvkBlt3jC4QUhE5BbiEblOZssB6YvqUYIV3i6aB5aSX7HCT7t?=
 =?us-ascii?Q?S+LPTv+M1p703nfg6XNDcFMfX5/3FGI3VR8IOh8aHAywsPmizKFVHeuKdxuf?=
 =?us-ascii?Q?I1xVzF28x4xYIr54VS+HhwtUB/02u+4z17UxXSTCwOy8q+pprP/2jNn+Ih1K?=
 =?us-ascii?Q?+zA338Cbtp2ST7vqXL58HCz/g0pncK2OJ0v1ovCMDb1jaobAF6a2utzSwOAF?=
 =?us-ascii?Q?hGQtVrJB8yDRqPRtpGzgRkkUmM4KNhxtTKonQNGvXsqHbqS0kEZ6VZOgWoia?=
 =?us-ascii?Q?2ueiSA5jp4DAAGDLOk2a26sTfrol23k8M3mSPyngPjIi8IGepSfSe9+Vc+Af?=
 =?us-ascii?Q?TThX07bk+IqRwfTyNHuchrVt3JgEx+msFDLurLRC6q1fVNOErloFZqqwSJqx?=
 =?us-ascii?Q?+3fTtqtkvhSh6f9iVEAHQUQE4rZajP3Hav295i+fKZITvsvCz4KmEPx08grJ?=
 =?us-ascii?Q?cLJpS0o3d1BjBm6ST2EvBqbT7aOTCQfOtpJDAuJ7B+uYPgtbXwjg4ilRgk0O?=
 =?us-ascii?Q?iB9UZVUKrYkAbp6J/YLA1XeQrC5QW9BQshXvnddHuK5JiJmD+D4Ajy7e3PDa?=
 =?us-ascii?Q?7epPj6DRys5aZn9hSE57zqyN82ZToCRsu7/v8S6kcg8Fo5rS4Wjfay/XFt74?=
 =?us-ascii?Q?omuIdDKEFWyvTdh2bdhw0Bmmd6ApK0F9yNZRuY8ehxmJNssS1cgdnuBRyK8X?=
 =?us-ascii?Q?XD99T4IEm7cEAeeGb9j8T5quT+SgCBBAfQETC+RywOl8Py00F33vgVKI51pP?=
 =?us-ascii?Q?yvZCEQIOGuY1F3RytlFTU55rKYDGl974tcj8YorpvZNVtCUS/xl9OcwpCnPR?=
 =?us-ascii?Q?KfOSYgf2TQFVCdNhsPvgHj0XvWQhgZXTrUAVz5pTm0O+bPCLe4f1xmUj7jVo?=
 =?us-ascii?Q?cpy88YZTucahE3AHIa8FkWEPBycoxVgRZImhvM8qRYBoTtrfSPGLPvr0w7JK?=
 =?us-ascii?Q?l9rh17sm7/A/IlgbZ4+McAF/OOr4GLqCZv2mlz7lsQDm89I/z2DOJGwe/5yo?=
 =?us-ascii?Q?9KaQ9HXGlbF+YIH7Sd38SqsNzIqV7GzIbvgjoK5GXlDrsnd+3vbN0zCt1tgU?=
 =?us-ascii?Q?DRbiDZ+xkl3H+5Pffe7BYULD13AMvFXfJiL6YWWALH/d4IMKHiQrFzc+7/C3?=
 =?us-ascii?Q?YwABnyjzJZiIrAXR02aQa66drVRDNjcH23BqpHV5B6tS8fDKHn6+f89IMQlu?=
 =?us-ascii?Q?hA4iEynT6Jk+hvkff5HlhgyL4e/QKT83wRJ+8XCzeHry6gBE+miBhoCpjPJ1?=
 =?us-ascii?Q?LcEmWeis/tYWwTHzNeD3j2dGQzphge8IRnNtLtWXtnRYXow4o0CKObnzNzWo?=
 =?us-ascii?Q?xVRBVFwQQNEm3j+MABp9mn+QA9/I1QjTKZAN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 01:53:24.0625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23927fec-fb3b-48c6-c252-08ddb2c1e7a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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

Fix xcp drm memory release after executing PCIe remove.
Fix xcp drm memory alloc after executing PCIe insert.

Changes from V2->V3:
- amdgpu:
- - Add Gerry as a Signed-off.
- - Unified commit author.

Changes from V1->V2:
- cover-letter:
- - Revise title version number.
- amdgpu:
- - Remove // comments.
- - Add Gerry as a co-developr.

Meng Li (1):
  drm/amd/amdgpu: Release xcp drm memory after unplug

 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 60 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 53 insertions(+), 9 deletions(-)

-- 
2.43.0

