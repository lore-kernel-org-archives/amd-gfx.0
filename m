Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E7CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 05:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C7410E142;
	Wed, 22 Oct 2025 05:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wRS4gk8F";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B7810E142
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 05:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWIktz8VzYwvZHtsCJMz5zzNGZIqaGL2Dr6LpYwFFRsebui+DB6jvTOj1XpHaZHD75MpYJ1iV/6umnVmk+0fYDf9CpPD+AK+X2QtaT3GuYfyLOA/yJyhgNOBnVeiQPpFgy0RssqYfZKA9Hw9GfA1ugOuXVelRmZzZFixgWf2vqnCZGd2J3qMiLKOWKYnLSn+jWQB6laiIorymRvcGZmoHyv+25z4imr1nTC817cT83pH0UXyk6bL1VE2rYuHHFOqlXzXY8unNogE8eyuD8ttdHzZDVZVduYg1myRofl4VRUMJFyxJ4LSWjF+0xl5oyUqglHloZ2igDrukcV6+aHN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxMkj5U78t5OVJ19LHpbSvuVb/q6U5lguTh5/O13tGI=;
 b=lFr5SmqWE1Vvqm1T+qg8MrO0AJQCvWD/R/9h40G04WgSknIb2Wqn19C8GDR/2rG7vZF0FXM8WIuhHCzp4F2H2om6F+stCGd9DedTUnviNTefBUtQufRrzV/eka9XjereQlqbUfcs5R/KuXvobe3nCFjNMZYg6v1zdEXbMWqVRCehfDe1o9sCSF3Dbb2x17eOMlTnkdd87xa8J61lKaHL3lVVT8LOa/INVefaVRakGOviZ+09XH54zwwMytp6TKRIgHdmeBDB6kVRU/wwzuUnmqdlVZ7tvEx6T5/kAha4TyI8fk15Q0cHzyj4Zxb17w76V+xy495du+1x3VPYWPDCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxMkj5U78t5OVJ19LHpbSvuVb/q6U5lguTh5/O13tGI=;
 b=wRS4gk8Fz/a/H9BNDLp9BgW3SZfG8W8UxrbASEFBLc6XYuO4sms1sL7VJC34ZwTCqRIBHuQMrnDprJv0HqsXNP9z3FbN1YwTYcdm6s5o/W32x6MJbdeNrOM+dLUsm2r+/n3WR2yFRcg1P2IhKBYjaIlXLA6SPMw5Kery80fIiyo=
Received: from BN9PR03CA0302.namprd03.prod.outlook.com (2603:10b6:408:112::7)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 05:08:44 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::df) by BN9PR03CA0302.outlook.office365.com
 (2603:10b6:408:112::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 05:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 05:08:43 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Oct 2025 22:08:42 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/2] Unwind failed suspend
Date: Wed, 22 Oct 2025 00:08:21 -0500
Message-ID: <20251022050827.552763-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 942f1971-7f84-4bca-e493-08de1129128a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F7H8N47hG9jt8j1JMwJTYmdybMgFY5W2GbjolSMSXFFUDdGHyKRikVUZiiKv?=
 =?us-ascii?Q?ANgjE3IVIF1UHW6fud3aQIZRIo9qc0kfoMgifdh1imUIkpxG0J5OtxFr1MrR?=
 =?us-ascii?Q?uzIniXtsS5peCcuaCfKeoO5BHLkqVEz1i+PFzb+dlgjsbMv7Ogj2YlDyTTl6?=
 =?us-ascii?Q?g7kNnu63ofRv1QGG3doN4yFqX1q2EzH8ooFA8YuqnXzDPGx2fpTCTdNA1t/G?=
 =?us-ascii?Q?2r+flog1+Byzciv8nMtvXJEIXdj5CO+nIjvbYEDXZhHBf5/R7LDGcz20Tk6d?=
 =?us-ascii?Q?PKiNx/OxWcqdkRDzC3SpLkkOlpT6H9p6+akiS3l+vxPfXmZerCTJ1TvanWIn?=
 =?us-ascii?Q?0nVTCOp9qu19LpH+quteb+p2vbjXIXNk2DWPgcmg2MM9xo66phTxJImmjDKg?=
 =?us-ascii?Q?GW5u9fKUQ+vq7y2cD9NyqFgmDYil64f7jCRJkXuRmzaZWlp+1UY5oE1SIe36?=
 =?us-ascii?Q?7DDIMNErhbETnn4we9b7U1XFIKQpMkeS3jmM2ixQuPpnQO6RQbEUGWbh9Itw?=
 =?us-ascii?Q?mPzbEfPPZn9JwihmyXSH7RGJoHLTaYJZXzWVO2m18dIQ6uFmkS074CQADVRA?=
 =?us-ascii?Q?YmE/8lX//Odj3zh/ilJEar7oo+WkkWW+3YN9F1z6sx/foDiabs9tH98GLrYL?=
 =?us-ascii?Q?KNOqBzEir5XuPfHDPTn6wGGfs/GdqnMbKPD3Nhg2JWfvCcvu5nHxi8nTY1mx?=
 =?us-ascii?Q?3SxOzQ91416B5PDLlmB0yFugQNrSmCz5n0ChVUOl9+TuMo8TqEWqdZxJwYhj?=
 =?us-ascii?Q?pOtAMKHLXvXa1KyZWfhnTQbib4prP2kv62Kq6bo8J3qcgA6MmIRX+NnnvrDL?=
 =?us-ascii?Q?8Zdcd7cAq8WIYWV1hvaSWZYr4xZHRP8uG5Y8VEDAEzSFA3eDaYCLzbuiumxc?=
 =?us-ascii?Q?iEPzHjaaD1u/A4pfreZ2IWf0huDKJcaViSrrfIgxI/0naNFFdaYALaeTFro4?=
 =?us-ascii?Q?OhlOHwRma2r01ZZJR4daZ9Y+mGGainVB8z7C8ccifcoblsAviaOlXq594H/Z?=
 =?us-ascii?Q?p8ytTUhpdEl0C+R06t+UMimE792kRjxe4+S2mLWTiAsnAkafLatTz8IREP8g?=
 =?us-ascii?Q?7Fya8mgT5LKSj4jSlfge3/o3InYYNDxYlEkGlLz/1V70QaWWFCOH2LCJAogU?=
 =?us-ascii?Q?YlS5ZEwKL9MXPUAAQgOLawG0P2JqF9HKWjDqFQl7WnVaF3rAqDoiwg/i7+u6?=
 =?us-ascii?Q?oKNmZdPIuo8dxBWQ7s5kOOk55bfOEbqRPwKozU4S/FflLKzf+p+lSQah4woA?=
 =?us-ascii?Q?88xrN2UeVr8XRXL1xO5oDe4HF1SWCH2mQeygXr92AiU4UZ+JlOpEQRbQMMXD?=
 =?us-ascii?Q?AvmybZKrH+Kdd27BeF/ctx5PiAlx3dHecFo9+j+QzGoxWfhXsxSg5cX57UQ9?=
 =?us-ascii?Q?zBZUSMdRUNnF/8jUv7zhH4R94nj2PNikuJgt014KgTfauOdoyz7BU7XF4JUo?=
 =?us-ascii?Q?etJnIICdB7y551kZVg3cPzXRnIaY/FKFkMfQh5tD1KWyqhcTnTAj8XLqx0wX?=
 =?us-ascii?Q?8aAK/U9UHhO6ll5N/lJascyaUi/LAc2jZDB3ETPYpFoApJNRWqlBKYlRyrpo?=
 =?us-ascii?Q?cB6L1pRd0QGHC/3fVsk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 05:08:43.5181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942f1971-7f84-4bca-e493-08de1129128a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817
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

If a suspend fails the PM core doesn't clean it up, the device
is just left in a bad state.  If this happens during memory pressure
it could be a hung system from just trying to suspend.

For all phases of suspend that return an error code, add an unwind
flow that will resume the parts that have failed.

If this fails, then reset the GPU during complete() callback.

Mario Limonciello (2):
  drm/amd: Unwind for failed device suspend
  drm/amd: Reset the GPU if pmops failed

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++
 2 files changed, 83 insertions(+), 8 deletions(-)

-- 
2.49.0

