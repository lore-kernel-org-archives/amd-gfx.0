Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89627C54731
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 17:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3093C10E3CA;
	Tue, 27 Aug 2024 17:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tm6b/Hl2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DE710E3C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 17:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+q5iZDCoKqC/EIiZgIYwpoOAC9ir/qSNol2fgjhnKxCvgHdPCHuPSzi52QvqRMoXtoYV9XjIEucwC4TD4udQ/7p/JpsESojUoDKbjqGTBEVH3jIMuy0BQwa2/On3y6fGPXqLd2PmfQI9TFqjJZaLLKOba5y1jbiRjGYlO26Ig0Ntkw0EnmEIblZ5MOPvcI/caDG/zGOfB6QH4BobXROamqEpA0ux9fbWX+lcBXX9xpNv6Flxq8NcElY3DeL3RtFjaiZVL8Hj20q/QFFD6AfaaUq4c9hvxDfiRqGAnzo4KrArnn7d70EuV/HoVyjMJ38msb0PmTlEKqugWxf65sRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ+N43sYDxqBgWmzefaUSt/c9/qeYJmapu0E08OhfS8=;
 b=FaMRwY3aS4GQsutgvR/t3iiCYn1ExzGPTZDRL8qHqXjVkxoCPCK1HmFpeL0jAJ5Rwd5D4ics+S0BU8BSh5rYO3MrxEIRcH78GP1RE9pdPhHmOrhm4RzbC3BHG5VvY36s9/ZtCM58ItV6C/ElQIdPJrxH+La84gpaWjCkQPezId+Gln8dORIvdiw1+hfsLdINlHOtHEfENC0ADuB+Mq8UYFXEFnkMeUPAdsfjRF4rhRkLg72Z6EgX/pOTrsmdiKVCuU2VcDhJHuUz2KoXkSmTx4jke09O9CMpSzpo93zMs3SBCTCwhw0Nr1mBFT71Bew3pE1+XPdzjQNC6cytxu5KuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ+N43sYDxqBgWmzefaUSt/c9/qeYJmapu0E08OhfS8=;
 b=Tm6b/Hl2MTpOhn3ZCDKppEzGTUSPITA2SYpR2STPjOUyJHy80sL8RrhMTniclXM3uRZIbLF/fASIwbyBF5NpULEQ4tadoVX88khiuQ9Up05756kroROjxmJ5H+zK/YhFpPIy2OZsWPdRaLn1RO77tK8Pb1vryxh0ANfmIlx16gk=
Received: from BY5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:a03:1f4::29)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:11:28 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::14) by BY5PR20CA0016.outlook.office365.com
 (2603:10b6:a03:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Tue, 27 Aug 2024 17:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:11:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 12:11:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jamesz@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v3 0/4] Improve SVM migrate event report
Date: Tue, 27 Aug 2024 13:10:21 -0400
Message-ID: <20240827171027.12910-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 02511828-04f3-49d9-9e13-08dcc6bb49f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ecyHdNqAH6HKke4wHcHHjGdv3ltCGRhnnnKDQDfP1AtlwKw5KNOhuriSoADF?=
 =?us-ascii?Q?kVdRCqQJS9tFS86gz7WDIzlNE3roOO+IX0PAFRhqxJpBosad+KZ5dJ0XBn3N?=
 =?us-ascii?Q?nRHOebr7E2ERw1Cxzmjw63RYJRaEsrY4Ucz4IOuVtDRUcD1QHT4hanx2B8S/?=
 =?us-ascii?Q?9MSx/f2x96xeTHn2vij3FdTYyECAXv4tmRpDBZrAntY+gdmXmmKWEk5m8Wgs?=
 =?us-ascii?Q?2cluCQi4fchX1sCD1JpfVtVxseoUyKWIeXLmb2iEUYgji5M6SmXSd12b4Vmz?=
 =?us-ascii?Q?7uU1i2DInFIqzqCGZ8bPcek0ppJqf8IMULBk9cwI0sd77AtcupGnfFzxwYyg?=
 =?us-ascii?Q?hd4kh5zbpM8QhN7cdhqFCxowwaNNIkOO23bLkKPE+82yuM2Wwl7iLJRPA5lL?=
 =?us-ascii?Q?dZHzNwY/CV+5W7VJtMsMdP2usjLbD8tca02xRJ4pZoQqtc3hz9AuUcqQWl/M?=
 =?us-ascii?Q?VNcwCzDLfRcAOo6UpK2Qs73De74iN9XuVFIp6FBhw4g8131H0Oi9431etdV4?=
 =?us-ascii?Q?K1NKixZtLKqNZDiQi+KbpkJd3VFYxtKbvr7Tt2VB7bvA5fszY5Z53RzkwHFX?=
 =?us-ascii?Q?QNC3Z/QY4uUIIPcoib5kfUNoe2h5n71X1Y8pfxk78/N+onQI9tsawDZk9Obd?=
 =?us-ascii?Q?hbBdGwFRMXKf3PS/VTPN3ovEoC1/QgoEiP7rb5Kcj34XHo482FS0VkF+hLbp?=
 =?us-ascii?Q?JVxr4+vQsUy6v6L0ewI2iKBihZtZFdJqSWsx/txbf+0K6yOUVxnvRfueodYC?=
 =?us-ascii?Q?Q05yl9JMJYCKoJJ3WnK+7oLim251YzWu/XSxpcYp3SEiubmrzd+jQXVOVkuo?=
 =?us-ascii?Q?59Qhu67nJLD1O/Zl5jJvRwFiA8FSC2kg6TwjtYb1fuDHekQGqMae0mQ3TDD/?=
 =?us-ascii?Q?QdAiCpHHsf0YIxug28XJmz0jg6z2dAOQVUr6kofxFuzX7/YnssgeDXaNh9My?=
 =?us-ascii?Q?Y9Wb/uMtC3178qbP8iyvt5CoJCzCEEGKXcfvbnDEv7LKdGIppbDz3lK7OoQF?=
 =?us-ascii?Q?N4krWI+0tRtA9bFrpYLFMLuWa/rghMm/jP0ImzqiO0pIGaPjOBAXrotxOl2D?=
 =?us-ascii?Q?1J/Q1Bajhe2wyYTiH0z9D6OJ1MYLZsjiDq9TIibNShZ+OHtd6QNXG4D3UkMc?=
 =?us-ascii?Q?OlhK1bjMyWviJ7KgOT0NbaxyJkJ6KufVKB7dQWkulT8R7WDWoGV0Ll7QJjRO?=
 =?us-ascii?Q?OZy41Qk2rKx2n+izMz/ECFrxZvOIATnE8AJQ8Q91YIK1jWgXhQ0hsy/pcvlD?=
 =?us-ascii?Q?yNhRWJPGpyY9ME2TE0cs4q6OMbYTswLiwdeSbNo3zZ4Qt9u+tZFILCQOskYO?=
 =?us-ascii?Q?rZ/hMWgFdTYF+aj1NaYyF/UhLVrFGIxAWIrnzrWEo5fG84+Dmmkj588MusyH?=
 =?us-ascii?Q?Y5nKFx28B46p7+IiNitRXC/Ns7auHT5nC3+ZbTeFg305BHrB89K3H13zr911?=
 =?us-ascii?Q?ukeFizKdF80=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:11:28.0026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02511828-04f3-49d9-9e13-08dcc6bb49f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
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

1. Document how to use SMI system management interface to receive SVM
events, define string format macro for user mode.
2. Increase the event kfifo size, so less chance to drop event.
3. Output migrate end event with error code if migration failed.
4. Report dropped event count if fifo is full.

v3:
  Simplify event drop count handling (James Zhu) 

Philip Yang (4):
  drm/amdkfd: Document and define SVM events message macro
  drm/amdkfd: Output migrate end event if migrate failed
  drm/amdkfd: Increase SMI event fifo size
  drm/amdkfd: SMI report dropped event count

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  14 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  79 +++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |   3 +-
 include/uapi/linux/kfd_ioctl.h              | 107 +++++++++++++++++---
 4 files changed, 150 insertions(+), 53 deletions(-)

-- 
2.43.2

