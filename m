Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E64CECE58A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C1C10E699;
	Mon,  9 Sep 2024 20:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LR5lk++X";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A18D10E693
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJoGmvz3ts3MwUt2vLSP8X0v4UJ9OqpRFUTbZN3zma8Zcc/1yihZXi1dQW/U6BkoWq7iTpXZoGGgSOTx4hwScP4TGoQ6fT7ucZ67qLoAMDfxMY8cRq8RZgOb9oar80L1NTYpm555x77Y6PoAqJjqYRJrFEoXdb5In9+3Jg0tb6fwYYXiUjG1xKsoGZa/lRM42wsdFvAZTEy302ho3cQyseYffyPEwRa2zIIiEax0+bzcE3U5NPWVBfWA15yv9trtPHVsL2y4bxzTOp0hhRy0Tfy8OWtqrA25rvW41fW27pgMokGVC4WQCt8vpIgyHeA4HqJVi9d8XAmJ7jV5/RBMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=px4bCMTIyixJ9bJsWBGJFxtz3A4vsWZDss/jrW64SgU=;
 b=iwDqDaBEZMx+J/zwxNl+GjMjw7YezX4PBVRRvv39KQfGq26wVsR+23+zPphsQbebj81yi82DrY3qcUZM9wv/pkRpm9amomYoUKkmdDaE6mb5BOyr7iRMgiQ4KQqjNedK2VWaQAe3v4Mx4hc2SSQ4rxZC/9QVPCbLbSwFX33w1cKGi3gHCh6cz149qk38p1LF7lUYPQhGLs9zwTEM4onkzyG7Iyo/QdNqrnI2DRpbm8kTBMqq7FcKS/0mNfneXT3ilbC/jsmkMyFvm4MjUPDleGGrmCaSdwERp2BIIbJw03h+i2O/Lw9hyo41FQnghhVVoFfl55NTdjFrN1PXhuRYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=px4bCMTIyixJ9bJsWBGJFxtz3A4vsWZDss/jrW64SgU=;
 b=LR5lk++X7VVrvp4Y5xkfoMEnYxyhCRkiHYoYk2HPo3dXjgrxEJQ/TS1RAb0yjXrHBOkZOG/wu/gqHBl0O4XUNZo9LymdFxwdMu3nWFTvhBmxOfabKMMT7HZGcm9Kvqpd1H+AaJa9/3DpLC3s+Zo7fwJ96S7jEG9O+snS378tmMA=
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 20:07:29 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::64) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Mon, 9 Sep 2024 20:07:28 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:26 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <contactshashanksharma@gmail.com>
Subject: [PATCH v11 27/28] Revert "drm/amdgpu/gfx11: only enable CP GFX
 shadowing on SR-IOV"
Date: Mon, 9 Sep 2024 22:06:13 +0200
Message-ID: <20240909200614.481-23-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9165e5-0b14-44c7-e507-08dcd10b0810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ee7pRSULzt1WFQx3JPxno9gfjZA0dNjHikcNbLamEv6nb8mUl9Tsmxm+UHK/?=
 =?us-ascii?Q?vzJILyTzso3bmbRG3epDgCjB3YhF9lNoC8qIaWMHn2smcbqq+DxQQRB+L6eR?=
 =?us-ascii?Q?yYrRc9ysQiTN+XPD2ldvxXhOkrOsRYJqBtvgoUMZXb1on5HG+tnXrzguaUcP?=
 =?us-ascii?Q?+daSNvKvsfFsxGxnbSSfMcllZqUoQxPWaLyo0u7NZcX+sc1qhFmIEDiTYx0C?=
 =?us-ascii?Q?cuPlVKxNuJpMzjCLAY7x33+N0VkZX1zKrF8sNp6XSvmJ3ZdkxMv9I6qPImvx?=
 =?us-ascii?Q?MeUA0QNc6Amwr4Z2iKlNPUE3X8a/AA4GouEFmlJOJH8rzjK3GdR/iD4O+Oc9?=
 =?us-ascii?Q?XBNBC6mk96CaqtLblNa2n8FwvUsmHjsaLwTmmXkU0joZwMFxtIG7d8FxCIf8?=
 =?us-ascii?Q?9mEKOWB6ZIQ6c7gkUbNaNpkjEL4d5CAK/cWVcjwLJ92obry4K0iXHHXNP1Zu?=
 =?us-ascii?Q?8fGEBl2kgOgDmI4U2vfiMLijrXOYDe0VUlzdknmw7W5/9HBwV87r8+KMwD27?=
 =?us-ascii?Q?cMcq5RNkd152m0RB7lT9cfSrdt2L81MMZIrlnDth98F5o2kwBy4zOP1okg4m?=
 =?us-ascii?Q?PVuMl+OepbEzYd8qbQiiE9/SCTl6hRiqQ29xojl+vbXQ4TfkJOTPpJPKW+FV?=
 =?us-ascii?Q?CsZDRZ2vRjcaHD/WjBl/wyBfcftzukuIeGW+7FdBYq4OIONnjwEpwpf5aKVP?=
 =?us-ascii?Q?4SOiDI1kcPRnfI8V3ohVFnx7AGhGWfH0K42Y092BjO7y1viiTOTB1uOcyqw/?=
 =?us-ascii?Q?XhCLGoAGoNZ0ezUjDic/TWpLLXuEndO1MrfQoEcUT0uZzi9qUnkN0dHXJS78?=
 =?us-ascii?Q?eaxjN6ff/+bIF57fpbZGDVv6Tc85COLpPcwRy4eHufk05p0R2JHLZsTzPlbU?=
 =?us-ascii?Q?rXOnf4WMukxD8vsa7erKhCjX+mrUadRcZFHsbI3Zt0egcA6YtVIHp/jMrlQJ?=
 =?us-ascii?Q?QzazeMs00o43l2xHtW2dLofGisSovIHYrCJzDgMFJ8fBJe5IKL73J68qKIxC?=
 =?us-ascii?Q?dB9dUd2RPQfmNrN+K6nvfnjGjMgYYq2u8XtL4MeI5uSUDGB0yBq0/4w05MR7?=
 =?us-ascii?Q?evqOz9Ny5w9plwLTFA/RuaAhUkNLh1/ArPUNPNwlz6dCyBYkU0u9X1CS0CzZ?=
 =?us-ascii?Q?BN8W3ClhH+0i0M9hhDjmMaV6KVE++gGIzrZ8EguLX0i/mKKfZBgWLI7QgM7e?=
 =?us-ascii?Q?ACcGWcoJ5ZGPgxSKGAFW2jzFYkJZQlRKq/5MEseihxFdV6KGhko0u75GomIg?=
 =?us-ascii?Q?FaN2NxffqnA4fsAGIqwwURTSbyz6Q2aWItgyknz7wxu7ksOp02nG41IDSIB6?=
 =?us-ascii?Q?kNJAsDsDHO1GHVFpgDHCHiqc+AWvjgwwelbb2x/bO8mTSaxdt5W5Nn4LigXk?=
 =?us-ascii?Q?VDbnI8+ejOKkgwhu7sb/UHx8jguBWRjKjgUjdrdGTVZqUs8c5RJ2V/T3dp1B?=
 =?us-ascii?Q?cnxWPuvFGXoPxQb7xMBqFO/Ca5ZCOh9E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:28.8375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9165e5-0b14-44c7-e507-08dcd10b0810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

From: Shashank Sharma <contactshashanksharma@gmail.com>

This reverts commit 81af32520e7aaa337fe132f16c12ce54170187ea.

This commit prevents a usermode queue client to get the shadow related
information.

Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index dbf3bcadee32..1f0f7ec0facc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -661,12 +661,8 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 3):
 		if ((adev->gfx.me_fw_version >= 1505) &&
 		    (adev->gfx.pfp_fw_version >= 1600) &&
-		    (adev->gfx.mec_fw_version >= 512)) {
-			if (amdgpu_sriov_vf(adev))
-				adev->gfx.cp_gfx_shadow = true;
-			else
-				adev->gfx.cp_gfx_shadow = false;
-		}
+		    (adev->gfx.mec_fw_version >= 512))
+			adev->gfx.cp_gfx_shadow = true;
 		break;
 	default:
 		adev->gfx.cp_gfx_shadow = false;
-- 
2.45.1

