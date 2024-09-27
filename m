Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A8ECEBF77
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 04:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1782A10EC08;
	Fri, 27 Sep 2024 04:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S1O04idh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D4510EC08
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 04:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdGEcg2dnISwcNnefjcMBVpIuE72OC5vzg5RP0oxUDZPl6/8fhf2HDFSFQ9FqYZhELVYX79NwED/BJ/AisaM2AR1dcHovApUSJAI6sFOhVBn7NN1f08RmcNzoqhD2QUQonVEj0sr1H3ZMjae/V27eJDWkC9wCaVppgohz/JjjdIrcNx4Z1H9IHQdbSlLtk28Cr+ILWiniZ/nKbr+ISaxgsBpJmRnB+pVQlzQRj2sZQlkzKHbhHvab90EchsSixlT0sBy2If0MrWPFV9K1f5gwchiXlGpi97IE5a32TGivYqOlL9Fo8faPIb4Ze3FT5QP1Etqjf55CRqCihr4D9wmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/gDDOmx3otjr2bp4KueDz2CEk5OT28PYemNFJ4Bgds=;
 b=KqKHhvAoq9Sq72W0w+F5cM6Gi8CtUkT917caud0qClW+1NgLBEVCUIjMLJuUdX8tcRI4bKc7Jmh49hGEFDdFZaZalw9KUFKLLPpOni9sbDS8xporQEU16o+vr2UFMDRsEaDDH9i/KbK2metnIzjYR1NwV+JG2c7Fm4WqZqztVSSNxJAd054N2Q+Eva4uEWemPHsb1Pxq5d0+3zby3XkOp5PM9vREUkXyoaOPJ28ov091rt2xpcl8jglHniiGC+d3/oIuI9DYB973+WS5XZZRroaKHxMI91QJYWiTGU8mq32NrmKs32rtBXux/Ilj1OH2IdMDjdFxUKZ4lLLWb+E0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/gDDOmx3otjr2bp4KueDz2CEk5OT28PYemNFJ4Bgds=;
 b=S1O04idhb5TRuh4nEwUC69uAMvOGaHonXb4YnF7N5vYei+7jqPSd7jlrs8yHl8Aq76TmpyQ67qxkPF81c/Yh7ZpKHvhLr7anbBOAysSLkEdiUSqlCKYcMuE+NezWC+JGfdFHwqzjRzakZ8xyXTost0rduB/SpEqwnrkWn7qqtMk=
Received: from CH2PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:52::26)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 27 Sep
 2024 04:53:25 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::12) by CH2PR04CA0016.outlook.office365.com
 (2603:10b6:610:52::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.19 via Frontend
 Transport; Fri, 27 Sep 2024 04:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 04:53:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Sep
 2024 23:53:22 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Vignesh.Chander@amd.com>
Subject: [PATCH v2 0/7] Add support for dynamic NPS switch
Date: Fri, 27 Sep 2024 10:22:58 +0530
Message-ID: <20240927045305.2718867-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: d276fb2d-363d-4e1f-bb1a-08dcdeb05212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m/dbp0yGtFgA4I+tTxzg1KpMhSLe3UyAGbgZJa8//Ldcp2t9vqSfgWD7M0nF?=
 =?us-ascii?Q?ZzMi7HEqTMqsZQD6EZEMmPIPOxkZJpllpsXQ9eSvuHkm6PDMk6Kf2OWtauWX?=
 =?us-ascii?Q?tLh8/A0CTvEdDssutAOTlJayo6RXZ592bmlTB5kPEO2bC5v7zfRDN5G/6O5f?=
 =?us-ascii?Q?EjE8qn4z8Pv5iYRqQ9B56MsT59yQQAusxmQbMeb9aT6IRxq7y9dAPG892FGw?=
 =?us-ascii?Q?F4FJ5frGdQXGHi289omkkSM9RY3t3+KP0dB/9bnS73rM15FjYeSm3iVD41lN?=
 =?us-ascii?Q?sVaUl+mOBsc+u9UbhtTxB0hTl86wSrYQTlMdgN1kSP8Y5ALCES9B5uewUbTY?=
 =?us-ascii?Q?CH95aYDVPalxPttwHOW0W94mTzr8LGNCxit0A3rX5Mfv/BmIJugNw0D9z/qw?=
 =?us-ascii?Q?9Y100cXsZ66Pfpoai72xix/quBmty+jYVCezBYhX+8nH78+ThhELEw3hD3O3?=
 =?us-ascii?Q?GSOcwyczPSoNKPhGVufJ5JJ40NEtz3xKZ4hEQxrCR3LYnVoDRFcX/ddozIO7?=
 =?us-ascii?Q?fDGcom4jOmfwnCUwEjpzjkUXB1DB+lLrX9q/SvCKGq3l3g7l7xRy9ToYEphJ?=
 =?us-ascii?Q?V3W9DEpZ3bn/Hrxsx62lLBQXAIUAiyLP6SeE5hxADuuX5wz3Cjs74sirXqba?=
 =?us-ascii?Q?s4jYx6jZmBU3dZ0sAXS5ZlYJSaOuKkNKJRXdItOLmHj5MFvH19gdGoAGtGaP?=
 =?us-ascii?Q?lJiHPihFN3abkYDkDndCVM2pVIDU+YU5NfMARQaLv+SHhVuodwhPk5GosCos?=
 =?us-ascii?Q?B9oChwFfq7TlTLzP3LKhVjmmxGAMrNOamm5oEsLJRgCom3woA7j4Jr+ZPjAE?=
 =?us-ascii?Q?B6eHXUCDtKzpVDY0cSu+Czepyg0YO75fzKMAN+1hVcJNjc1miaf8TwfPYDIm?=
 =?us-ascii?Q?A/jGJpwvIKIl3QP13V55VU8/ZokQZR6Bs4mvfer6qFlLSFxA6xX1GPuUGCwO?=
 =?us-ascii?Q?ZCwyr9V7BVaX8UuFrqpxMKmoskULf55TlnY6ra0hqQcIVagiGNDzSuuXMTvJ?=
 =?us-ascii?Q?azicocIEw2lUUOf7b2a5PUQaFmq4OCfUwvUJFZtChm/ovYE7OJWxYp2Xpq82?=
 =?us-ascii?Q?FAo8b3dwR5+JivKEHdP956s2acf47FA02Pi7E1/f1YO3XobZwBvVWNqYpxjL?=
 =?us-ascii?Q?x6ZWNB852yhYjt6zorqj6TeR7h54yJvHlyvwRqEudyUAL6jHHyoUbo+rwZJ0?=
 =?us-ascii?Q?D2dONWboysM2uxmE4bsdEB/rGvQN7uDLRWQbCB7FQR2LWNV+P7mxPNWVSfem?=
 =?us-ascii?Q?nuy/eCr+UIqlltM1+8XLT9bRhb5dymMWkK2YvxCkPkcK1FtXhzypG17gcJda?=
 =?us-ascii?Q?DSECvZQlBSv5GKlg0fxt2itcvwlPaSgQSEE2lDJ2kSr5UPnhvj0G9qso2taE?=
 =?us-ascii?Q?ydRYQYVU4MwMi9LwSwk9fuD8Jk6OsViPE0DpKq9JNeCFb4ykD70buAHk3Eyg?=
 =?us-ascii?Q?c9b3WP0BxF79zmZoffuopyrPFW9LlVkb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 04:53:25.1243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d276fb2d-363d-4e1f-bb1a-08dcdeb05212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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

This series adds supports for dynamic NPS switch on GC v9.4.3/9.4.4 SOC
variants. 

In order to do dynamic NPS switch a sysfs interface is provided to request a new
NPS mode. If the device is part of a hive, all hive devices are required to be
in the same NPS mode. Hence a hive device request is saved in a hive variable.
For individual device, it's saved in a gmc block variable.

In order to do a NPS mode switch, the workflow is -

1) User places a requests through sysfs node.
2) User unloads the driver
3) During unload, driver checks for any pending NPS switch request. If any
request is pending, it places the request to PSP FW. 
4) For a hive, request is placed in one-go for all devices in the hive. If
one of the requests fails, a request is placed again to revert to current NPS
mode on the successful devices.
5) User reloads the driver.
6) On reload, driver checks if NPS switch is pending and initiates a mode-1
reset.
7) During resume after a reset, NPS ranges are read again from discovery table.
8) Driver detects the new NPS mode and makes a compatible compute partition mode
switch if required.

v2:
	Move NPS request check ahead of TOS reload requirement check (Feifei)

Lijo Lazar (7):
  drm/amdgpu: Add option to refresh NPS data
  drm/amdgpu: Add PSP interface for NPS switch
  drm/amdgpu: Add gmc interface to request NPS mode
  drm/amdgpu: Add sysfs interfaces for NPS mode
  drm/amdgpu: Place NPS mode request on unload
  drm/amdgpu: Check gmc requirement for reset on init
  drm/amdgpu: Add NPS switch support for GC 9.4.3

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  68 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 190 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  19 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  25 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  39 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   5 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  44 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |  12 ++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  14 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +
 14 files changed, 387 insertions(+), 36 deletions(-)

-- 
2.25.1

