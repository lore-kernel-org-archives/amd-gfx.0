Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA31CCD19F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 22:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B2810E533;
	Mon, 20 Oct 2025 22:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iBzn4HZH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AE910E533
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 22:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnTtfxnc86CkC/Eu8WThfu6dZPYkNiiRsXzfpLS6YRaJ3A/BssjTy91LIX4xZPplVxTLi8NhFg7z1H+FcdIUJPdcovOuKIzglWVKdOLucxrJDTOsyixpblcJ9zv5ncgu4gu4XWIM0g3AAVreXY9LcRQRa/pyz8EgyJ6EpuENxQ7YVEtz4zzuQpNo+cam4x43Iof7SU7C7qYUFUxFFj5rVwbmmeCne4DMXpHfFM1n7+3OJw40s71B2TeAbyQXrtjNiNO8UxXnH50NuaznG9VD3DQyoTMKmvacdG3UbSffcr9qAxkPmWL2pR+IHBUIewMlgjqNBvHBn3drRSThjbNpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu8s9N/bpnVhx7wE4Z2SDtu9HQ0HaHop0vLLjeCtYwI=;
 b=LfGKZVWpajXnY0+42QWsXLJbni6TyAhI8hgg2TSG0AaeABiXWnBuhLTARigge/9IavdvPfpRo8g+EhU73MJarOqe0aoxk5AL5mp/rOvRIT4JBDN1mfK9cy54MLZtYQUfzeevprwcr9Yk5xy91XQez4OyZPA5bbyW/j7KVjpCdpw2YERCLuv7/VNsh1mTD0pSf4ycAmhKUmBFL5HdPfUIYT2Dj6LDFxEgdyw9zTlCX6L/zwTq1hEeX3KzljeFV8twfBg1YuPI1hGIzkeYAx6xCOfpp4ji6mCDy9R2D3XdWlP1c9nBfNEqjqJc1WqJMgXbmtpIZAB34SWVKbcpET0Ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu8s9N/bpnVhx7wE4Z2SDtu9HQ0HaHop0vLLjeCtYwI=;
 b=iBzn4HZH5RWjhDi07WIgHNOPzCSE1cqAHPPjjAzGW2LIPwa6/jazjdthbFiaOHspzmIQ3ljRiPljUYSOrZuDJruXvCZRRXVTTdlY3bLuAw3zQi4c0LiJLj2hq49j8tfokGCyMI2juigHXbkeHCXwnxTh0c5GlAY/UZX+k2PY7/s=
Received: from BL1PR13CA0315.namprd13.prod.outlook.com (2603:10b6:208:2c1::20)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 22:35:16 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::41) by BL1PR13CA0315.outlook.office365.com
 (2603:10b6:208:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.11 via Frontend Transport; Mon,
 20 Oct 2025 22:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 22:35:15 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Oct 2025 15:35:15 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <stable@vger.kernel.org>, Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH] drm/amd: Add missing return for VPE idle handler
Date: Mon, 20 Oct 2025 17:34:34 -0500
Message-ID: <20251020223434.5977-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: e42c77d2-d56c-4942-632b-08de1028f0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DBAmR31dQMNYVRst83LC5RavYbgblrec7NruFfGS2MSE43gO/QVIczaTVyTz?=
 =?us-ascii?Q?LEz7FNCgweEYDixFGiPv5kUvmuDc0heiHfAzzRUjXAZhBAXDUktHC7Quh50u?=
 =?us-ascii?Q?t09+BoWIeQsXz82SQelERLk4gTcEWagaC6sfuUJULgA5a2HIhYNr2o6SYkhE?=
 =?us-ascii?Q?wJwJZaDyGpvdsHL8IpW7uwBMpTjwhRpRTX6dj+cFsHLLMOEgrG8LS7Y6AS5k?=
 =?us-ascii?Q?ddXPZzHOjvw2a4+Nv020XZQg8WowZlV8xrH+h8j0XpV7+BRt4exUIijycqtm?=
 =?us-ascii?Q?HlRF+COH8o5s7uK66WZVPHW7l6GM5i0jlw9U4oCOX4QJmbS9zHbx7e3tnzll?=
 =?us-ascii?Q?q9Zh7ahUFt3OFP0vjlRliKx1nYpFokvoeS3VgjCs2G4K77By2r5iP/wD4Dvf?=
 =?us-ascii?Q?A4HEk+uYhRC+xwVGSkYmb0YcDMLzT3uH2gthm4arvasmjFiyeTivs/z2pyhg?=
 =?us-ascii?Q?qtblz8RzcDRM3tcgE1xzAM8dprwmnCFou9Q3bniNstOxcPqTFLfIunDPpGXD?=
 =?us-ascii?Q?M57BN8bp9cNNi8WlZZqMSmyPv+4lanrbcxKVftjqxpXiBwl7fNkNF4yZXIA0?=
 =?us-ascii?Q?LZmVpW2QIlX0wzB108tfDGLxjAuEmfRL0n7WkXal9baw0CV0VURfbfHsOCNJ?=
 =?us-ascii?Q?D65Odu35hUX9kb4AjTsMD6PEo5DUIj0bt5mhKPLhZCMYzlMMOpkHpL+V3YWP?=
 =?us-ascii?Q?2mopHh8AuIC76T6uxc0H4ZRejOPhVOUA5te8YKtsuRs/FoHb8BFGEPe5Ublk?=
 =?us-ascii?Q?GPFOuIiXnt3e/fDawB+lcSANwgmisuk9/jR4/fMuafun2d9mMBeKunYs5lQ+?=
 =?us-ascii?Q?6i3yn/QH1fTGXQ6rUFi5XCKfa8iVhmSpO6qMRbzCSgZzWNZJF84kRqq2LN0j?=
 =?us-ascii?Q?jZeiuiHpADtAPidJIP9c+W+C02h8hb0s2T7jwPr6GzIut6YNKs+9GbIWEVZu?=
 =?us-ascii?Q?2RNiiMBxztb/KwKfNOovBZXMhjgIeRxtCMNCP8B6MEwKw0YlbVMFrGMBQxrs?=
 =?us-ascii?Q?tAFMRxsPF6Fgl26Vi915VVYfrw+NA3UqY3/NH2Ck8RKOGrZP/9HUpObucjXa?=
 =?us-ascii?Q?JIZrYKuHS+DvWgmP+7tY52zhb0lmrGm8wFnDmMY9dMnIiODNPRFGJV9I+85B?=
 =?us-ascii?Q?qoAV1/AV+PE+B8T+DSs/witYq5VNMgjn1kFnFQoxbXs0KOYAB6eu1QIkoHas?=
 =?us-ascii?Q?OYYa3xSLnHgJQtydRlR+nObQLabhTql9dgfsop+JpS2VNSA9xZwFw1lBNFHJ?=
 =?us-ascii?Q?0mrcmHP/ixmqnxNfne/0+3uicc7tIstnT/YuUimgd43lishSf9CdFj2K1WK5?=
 =?us-ascii?Q?sgpmpTx9PqlaWsrUstsvJ24m2vl/jISznXcRuLE34CjXa7dXrAhjA+vNtXrL?=
 =?us-ascii?Q?/q0ZnwZcPHcVcTOkYHo7m3Iydo1huC+44s5H+YZfWJc73kRN4j5a64kRfRAO?=
 =?us-ascii?Q?1eG25MEJkYFX9mKCh/4Y1ah0UHD35d+xbs9UNipuVYRftqyIr7SHrxZEmKvJ?=
 =?us-ascii?Q?Fz1EQhnMiQj3751w7CVTJ8ZO2vkPIwMVUCw+x2H93nrRE/dZ/sG+Zk3VwpJB?=
 =?us-ascii?Q?r2Gu9oBYWHmWS05+vcc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 22:35:15.8015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e42c77d2-d56c-4942-632b-08de1028f0d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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

Adjusting the idle handler for DPM0 handling forgot a return statement
which causes the system to not be able to enter s0i3.

Add the missing return statement.

Cc: stable@vger.kernel.org
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index f4932339d79d..aa78c2ee9e21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -356,6 +356,7 @@ static void vpe_idle_work_handler(struct work_struct *work)
 		goto reschedule;
 
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+	return;
 
 reschedule:
 	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
-- 
2.49.0

