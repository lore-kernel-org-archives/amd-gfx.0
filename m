Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76239C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 19:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5D410E56B;
	Mon, 24 Jun 2024 19:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IUq8gznO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EF610E56B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 19:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhJE2sUmpovBQup97Ce/laJYUcDTF+NOvD3FYg7glpnG7K3+YpP/z+wKOcFSAtafSSMubMOC+JMbqtDqlB131D1S1K/52xs6JQntd4c38d0yMDpBp1atF8lTVR6hjdhp4HedoPOoPVpyUvcE2SY7UGsjIZP9LCtTB6CRzKgoezgGr/jmPdWVXdaCpao8ypnnTczdz5magm5K4gKZvySMzMzX2RxsOpT0AUyg7MoOuTZEL23fnwqn32UDYubiEQ5p6kyoivbLbqKXeBnWeJV9ZROAZ0ybas8Z4+8qcOgflGCOAsk8t/FjtcgzHQoLIvP4zV/vu1U/yn7Fyeq3YMShfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XmWeCxDlA4qBr/bhu2FTIjPZQ9Niex/hI4LQcXQHgU=;
 b=NXO78RuX8hlsSDGO8QkvOc2LNQUfA6Dc0uoI1A9ozSQQ4i4l4SzRzsjDtKv+b/WH5oXPffUW7M3EGZxO3Y7xzHAeXpAQs+pVyY9fiBHXMdJNR24IMpKX297TM9y8GBCE2dPX3yWfmwOC2HKtcah5MPaD9IsqaNmgm2rxSdWyYrFU7HG+tY0e9GcPgFG/cthhSc7UFH6Rnur4vxFAf7CzK3m8TTO8t2wplDsn+CnXmZucejvnZ+/svvRzPuXb7fJDWG4KFgi9YzIJluSRx8ICgSRl5LHOHPaYmv7uQ+4O8HJMhzQhu/YQZAEJ9v5j9z1FhgZuwx8IbNeioYYp8d7jQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XmWeCxDlA4qBr/bhu2FTIjPZQ9Niex/hI4LQcXQHgU=;
 b=IUq8gznOUY6958hTCjjGXJW7LkC4uyA2Ej8mcUol926pjKoXFOSQcAHcuCoA5h/SZFirnuzCR67O+OzlbuMQfubu+igMk+KFooitef8InSd/aGDvMfvPM5rPctlvIj+p69hFasj+LWbGkQLib+8jdfc4RbvoH80Ll2DWH/wiy+o=
Received: from BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 19:15:41 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::ea) by BL1PR13CA0382.outlook.office365.com
 (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.18 via Frontend
 Transport; Mon, 24 Jun 2024 19:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 19:15:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 14:15:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] Documentation/amdgpu: Add Ryzen 9000 series processors
Date: Mon, 24 Jun 2024 14:15:25 -0500
Message-ID: <20240624191525.63787-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624191525.63787-1-mario.limonciello@amd.com>
References: <20240624191525.63787-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: a350173b-fc3c-44b3-298f-08dc948209cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|376011|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ODmfe139DhokRT6CG37udOer9S2JEUQURdbRQ6IWcj14kXw6yu5ep4lJriiQ?=
 =?us-ascii?Q?0nHo5qbJ9S0Pyfpt+jSYkMh/V1pkE+NLRLieeV19y6ayczEAlJ3iIj9rJdP7?=
 =?us-ascii?Q?Mdm8cnHGxapm7TChnVkOMxvCbj77RKroDNDaEgymUNUzgZr0gYvJg9pm4a3L?=
 =?us-ascii?Q?3eki0qRpX2TCWFwwb3HhM9H0sOZEjwvgtvYQqMJHZFYPMJg5VHNBbx8llVTu?=
 =?us-ascii?Q?YKY+Hvyxw4y7mSf8cCOGVeOHd4ACVslQzrVw6q5e6QF5pmLYSeXk9pAITjO0?=
 =?us-ascii?Q?M0z6J1Bn/U3Eeo+Jf7bjhJdOmZY3U8Y+D6dW7n2+dPgn1J7NCNIrgkze0QVu?=
 =?us-ascii?Q?1yVppTtMvQ3JGMExX/57XkmbM+J6x2xfZYNsT+1pStr9EEFa/jHrEc0yFQAS?=
 =?us-ascii?Q?kJkeGqpBn0DxFnf66caQvEkmW2AuVoZeh1I5zBdZznfFXCgKQ63AqtVHj4Ea?=
 =?us-ascii?Q?mgvsRiEMpnqKVA0oO2qwYgVTcSmIdd6e8Gfn/LVyOpweDdEYmaMkPATbRk9e?=
 =?us-ascii?Q?FbbNakx136a2lUXsialmz/b9VVYeGFOzUHrv3vz85rgvwxe2RwjIMxy/rYuf?=
 =?us-ascii?Q?Xb+QZxr7dQIHNbH6LknMB9zClLE6ZEP50e7VZZ3IR+LlaA5+4kcPSQ2bU17O?=
 =?us-ascii?Q?Bx64VuSTG4zTR81vwzWWu+LGzcXstBjpOzPkOJZ9/EJ20RRYmp3vHu2tQBms?=
 =?us-ascii?Q?nteyzsuEmbJaEyw1HJA6YZEG//gvOKxIehR1iu6zzGHa8U5pfhC3WzDzMznC?=
 =?us-ascii?Q?4nKP3dP/woq4Q11fUb7eQmiKsCChATiXPa7T2Yo6HwQHb0AnDsg1jef3gehy?=
 =?us-ascii?Q?6SusMYtanMOnAMNmzgylkgVyDXLRJRC6EPcSs7D/SCgiDwDC1hQwbIUpRKky?=
 =?us-ascii?Q?G4K3J+gJN/SZ0V1az6px86CsOnDIChDWmr13WjcyZEPBh+Drce8IG9V1A+EQ?=
 =?us-ascii?Q?5kWS77KfX0DyywLG/xGOElUYcj4oUTf8Sv5EelznOp/+Jn0zmIRGUor7FNz8?=
 =?us-ascii?Q?kYRG0dny9V2eS0MWKbMiz7uhwdchLmAsILGG0TFVIYfcGjKgft0Num5nXIEC?=
 =?us-ascii?Q?tVLvdI+hzmtp5Cay2/NWcRKRAb8WzKneuZd95VjnwYspZCCDMR8wKolIaaKz?=
 =?us-ascii?Q?KrcKRZveVHpfXNjNRo7BMHiKjNFEzFxGinljeawuUv9v+j70ijSYCKZw8FKp?=
 =?us-ascii?Q?fOY00Ot5UwYMYsAgAYdzl8Kxw+lJVbK95Vipwb1l4vx0AOY7nFN0wpI4Exap?=
 =?us-ascii?Q?ab3ssTjUap4g6ujgIFdnl2RDxBG36gt4LAh2+EVUXAfeX6KoX++44plf0yY4?=
 =?us-ascii?Q?RcVy1MQflU33jWtZwyk+nMRAcmYmCrYQvqgnC6FmNMPc2ETJ+JBVK5zlPMmJ?=
 =?us-ascii?Q?dTlgNVI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 19:15:41.0020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a350173b-fc3c-44b3-298f-08dc948209cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
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

These have been announced so add them to the table.

Link: https://www.amd.com/en/products/processors/desktops/ryzen/9000-series/amd-ryzen-9-9950x.html
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 61140ba32793..5dd4b8762d19 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -7,6 +7,7 @@ SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
 Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
 Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
 Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
+Ryzen 9000 series (AM5), Granite Ridge, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
 Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
-- 
2.34.1

