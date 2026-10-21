Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A3606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ofHBHIGp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FA610E07A;
	Wed, 21 Oct 2026 11:09:34 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DA110E1B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGuV7qsnzb2nq4boSF9gOrSfQKVg4axxftgXA9D7Rq1b3P+TCdmdmNTAMPhRRfsSEQ6iTSUv/1+tarjx5lKPv6dI6RUW8LhYyXoMGjh6JPLago+FA+HFkKMdmE+AjtM+7lEgTMWcQeX6+nhPv79q2Ql/njtN8oVwpHDbaD3+H75+l8a7Tfe3xU+3nFinGRzrwUzmk+gpyzBh7PSft7kfXtse+xmwjrMHq8OG6fy9z/Uo8W9JEL5DnC0x9xE7QGwMdkxCy0EuN4vQd46lxkG0MeAcxYvhXXxYuF41FnyjMkj09ttBabaDwyZaq8YkBmjPGIQDD/J1Mx/6WfN7vAdd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqJfzgam2DdUcdebdhDfY9amtEJPL7OaxJSZ1SKC0oI=;
 b=N0AtT2723y9K3iEsrzvUw1nL6lfWJGASLyIP7Ppf3eLDvIwjRFYWJqtKsHdn+T2vE+Vyy0CXlwJtTYLl6zNZocihe63Ffe3Na4pvnXMH6h0N0EVyTMxniMHILk19M5LpnVrocOCvyvGCe6xJ9Dzk0+iQ9Ro8FRJpryn0Zud3SyUpSIf3JoxC/+lloVKOHR5MZKsuUGsCYa4bNvpytkxAsDnNBnljyJmbem+dBYC0OpH+FqjjQecD091TJnFLX0OIfMI90FAy6SULiWES/w1kx9zd3ocEFyT+loRLMA1dgTJvPSC6swuYrQhZ1HFgz/FinsZXu7Bkifzb2THTtlMSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqJfzgam2DdUcdebdhDfY9amtEJPL7OaxJSZ1SKC0oI=;
 b=ofHBHIGp7r5JP33YsYbcZudZdrp8SVMxGC5c9jpGzGoYIImLABtTFiKUG7yBfW+7VB9SEui4/scXu3AzStPTKVP8Glpo8YFWZ3z2Q1duzUadEtiCnpzMrHNLP554aN5MemEhUx6BBfXtCINIRyWhxF6gGvK3FyCmGKmLal8CQeE=
Received: from BN0PR04CA0149.namprd04.prod.outlook.com (2603:10b6:408:ed::34)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:09:22 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::8a) by BN0PR04CA0149.outlook.office365.com
 (2603:10b6:408:ed::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 11:09:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:22 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:20 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [PATCH 00/12] amdgpu: implement Performance Monitor Counter support
Date: Wed, 21 Oct 2026 19:09:51 +0800
Message-ID: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7c565d-4258-4647-dc81-08df2f63c27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|11063799006|56012099006|10067099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: Cy43UJNv5hxh3x27XqNYovtEwfikEe+tFkXeg3RQRd+/afTciav+F52W5MhJsW7Xzf+nXOPqNf4OLyQNBt99RKG9XBjDTZrRGVI2CRjytF/7mCCmllZD/M9wmWer6msmPgQXHiRr3qzYSek48oS5XzWPAK4lFFonZVFJ7O8DEKcUZ29KSIxPMFYqqxmlGNDGU57B/iMYoTkDfzQrJ+yrAkZpqNbCMYIRZon0WB9UIYjGOul0H89NTmDVpkpdqm6RY+95L6UNcmas7eTyW0cXSjeTvRZLUikdM7FssAQB446IHcJh7H6tDopTPNwfncohSUIFKmXu45beFR9x9LIzS7GV48uLewg4/kCjj6NBevhmBzHCMzac+YqzaYMJ4N3oeDmk//eADh3a2ut8tadeyzuIMwup+LugSKzPz0FatAjTtH5iVRSN2yjIQrYTzVkd7tWBDRXmkbq4ZrYQ43A/YxW3ZDzkSNnhjxKMEUcA8CjZB3er8w3xGW5TuUQj/2pK8Sfv1e935RfcTFS0ERQ4S7FxklohDIeggiAT1t4Qr5FzZ/iqlp4/71WOtSfQefAV0vAJyAeDzpkIxRUDVVnKxfkiR/GWjMYj1m4j1AZ0ZO9tQPqh9tBS/iRfCjMXfttvZLrgTUd1TgswAGc/6XbteLkH1pwNVnGPExKvAngfRBeFPXyvzgDnLYIskj7QZypXfepwDt3S7OXtCjci45lEqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M4F7F21lb0Rqaf0zpXbzqcVZTixucTZ8pX9r1qBO7CEhj074htjXhL9vMd3dwQ1k5a5EMc5p2KevEeeyXB7gRpKNXnRgPaa/gYWqYPl+EW74MF69za0631TDoWkL8y+UTeu8KwZcFN7sMHHh6ppyHY5mjg/ce35s9UcsWxBNdyzXyGefZtU7DjkOMNbB5dg3vhNo4KBUA+KgPIoEUVYf9n8gNCnAYFIYsAlGUq2gCnJyP6Xzd+qoXbQi5rnuOaIKoPQQRH6ww/zyd368ItsgCZS30pbIm/tQA933p1k7wbo8kkYxW4wycuLrBgcXxcN0wfBwefiH1cqnszJLDuQHoprAXJuB2EDpwb51+kBJjwQYUpUCjexB0YR68pF3aRe4D1zUZzEAA9ceRH9QUYSwejpf7O9e63fuQQZC/zjbhohZKECnfW2YoOZ1XDE1inXw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:22.0863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7c565d-4258-4647-dc81-08df2f63c27e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series implements PMC support for amdgpu. Including two parts:
1) PMC Enablement
2) Profiler Reservation

The user space should take the reservation, then set PMC.

Zhu Lingshan (12):
  drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
  drm/amdgpu: introduce new helper amdgpu_userq_xa_find
  drm/amdgpu: implement PMC ioctl framework
  drm/amdgpu: add device-wide PMC config
  drm/amdgpu: introduce PMC ioctl handler
  drm/amdgpu: implement reservation mechanism for PMC
  drm/amdgpu: set device-wide PMC enablement indicator
  drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
  drm/amdgpu: GFX12: set mqd->perfcount from mqd_prop
  drm/amdgpu: GFX12.1: set mqd->perfcount from mqd_prop
  drm/amdgpu: implement device PMC handler
  drm/amdgpu: set userq perf state before publish it

 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h      |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 166 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  38 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    | 173 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c       |  11 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       |  11 ++
 include/uapi/drm/amdgpu_drm.h                |  37 +++-
 13 files changed, 470 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h

-- 
2.53.0

