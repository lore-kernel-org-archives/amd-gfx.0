Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF284CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 08:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E82710E766;
	Wed, 29 Oct 2025 08:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHC7mAbR";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013044.outbound.protection.outlook.com
 [40.93.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4B010E76C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 08:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+57KbbBAV8OE9kB8bsKfV8ZMQ9a6w/FIXvPl0INEn4fsENo1YM+Wl5mAvrLTBCuNi4IO8xI+dsjZSNDJh/4GO5I6DLUmgGHIk8MD4qjDzJcFenCcwfSJUCU7YIMFCooDPHR4MHbEJTXDDPNxGPTN+kKjt9o2f5rj2guh4M0Nj9Dp6siCBeofaTEXLzwe8tI/Q6RwE0g3X59JYTciJnbKgRcSic/9G+JDkm7ZyhgM45bQa/v38L/5rb+bj4GUSGtvyMUHOGWO1GRirpxcUBvR3PdVUhrycvfFpiqAKlNt+lyBn07H4dFt+PWYhNpHjnhyPZOjipeVAkoj/nIkR5pDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj2Og1D/rqSVIF50inuS/b+g/XGBg0NMh3Dj/mRRpLg=;
 b=eXopM9JYnw6l2IkHkHCK6qxlwOU15RTqbAOqnCCsJbjXvTT+8PZQw0hVHhhNKhwL13w3/lfsyc/CV2J79BpW8SSDtNHw2gm+WIueDdFrC1QpdYz5kiD5z4MYV6K4aBoi7dYP4cALk6hGUTuLZudPOk6n3EyNyanyVk12LAlXpi75uS/xeVGtKUb723PfcKKXpImSwxNV7G0zkexi1AxBqKE0BNsevHcmiSDIVWgh/8DRh9ZfwW3SiTsxl5At0pK4hp3M/JRWVC5D3gTkN9A43IYE3XiQ7AxQfgz4ogRLbade7JIxmiris/XQ8T/dIhXhlYejjoj71Fc8LjUD3dMt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj2Og1D/rqSVIF50inuS/b+g/XGBg0NMh3Dj/mRRpLg=;
 b=UHC7mAbRamKfh+0u8rH6cFao7YXMlLH2KxbuqW+7W/b25plUCPvNeyx1nX2pHCt1WpEMKGCbk/1vD8Epc89vdUwMddfoO31enXx5m6U2XD65MdaIsOBjOQ4yDSZXtW9ZPWKDIkTeaxXnyLUY2UT/Rqt2TC9B8k5Axx8H1IbDTSQ=
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:48:25 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::da) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:48:25 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Oct 2025 01:48:23 -0700
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: add check function for pmfw eeprom
Date: Wed, 29 Oct 2025 16:47:50 +0800
Message-ID: <20251029084751.1701305-9-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029084751.1701305-1-ganglxie@amd.com>
References: <20251029084751.1701305-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: afb8432f-2a1e-4a2b-1715-08de16c7ec59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MPyjnF0uZZylfvHvZrjdfhjWunaUoU1HlIagYU0Nva9fVN49kNwTnoNI1O52?=
 =?us-ascii?Q?xr+piCyvcm6gcSGyfAVF2vAHjdWV3kPBFW5ZZ84mhxfga6Xbx3XNi4RA0eh+?=
 =?us-ascii?Q?LzUhzh17V7kyx9Y4Y7GcUynyhtcJ9KEinbMH5quj+wbK+SBgdMwX8bNLNTqW?=
 =?us-ascii?Q?oQHl9wsj94EcqUTP/tQ7qVur8Hu3vgn37FV3c0hmq2qHfv/36VlXPzV42haS?=
 =?us-ascii?Q?WaRBbBydVhbOG1/D+qkeveoO53E6rvhKhb5VTrUPJwiDDW2MwWovOWz18Mid?=
 =?us-ascii?Q?CXFCDDm16zO3D/w4xXxbgcL8tTvWBiFqqJWSTQusqsxXiKCbisudupP/2OpE?=
 =?us-ascii?Q?OOGwErMO4mrRj7RDGYc2xI0jWGyOt9wVKhXc9vyqd10PNspzU0ABIA6Rdy6y?=
 =?us-ascii?Q?7et4nG0RivxXhBSvBZziEQKrnMHe7CqT4mxaGfyOGjnDvK35x2+ZsBtUSmzs?=
 =?us-ascii?Q?CKNEbbbUhENgM/iiGW/3MwKWt/sV1qkd6nc4L3e3fn5ZjWFJE+NegRPPs9x6?=
 =?us-ascii?Q?cgpa7TkrkjzSB7zyDL1Gv5qiGUzvhHQ2mBBY96bghAUOoEcBguMgKWSjHdI6?=
 =?us-ascii?Q?ml9nkL44rR6zSDIDKEf+XrmyL3IzZLzwPjdVovb55E2JKpPZxWkr4yhxBvSp?=
 =?us-ascii?Q?6Hp8Vj4d13BiPFDIZZIsGLtfjqWAuQHI7j6dH9od9FM4YYRDAl/yfW5I81eS?=
 =?us-ascii?Q?o5vII213wHY0VkkxWeBvc8YmM626Rr7Z/ahampAQTUIgJt9qUuQ4GFJcLuWn?=
 =?us-ascii?Q?uWgMWB63GCGaN5QIxEI/oyJV3pLXkH9NtEBkaA1EZEGsU2RJkd8vkKWJ/NUV?=
 =?us-ascii?Q?MWKvMIfmWW/z82B63f7SF/tK6ls8jcOVze+7xO9fRt8bTC2lzvhlvJl1/sB+?=
 =?us-ascii?Q?qL0Ney7Z0fGovr2saEoWHSXOwxzNb72pr2tVy9nX6pHy70nzrvemzIiGJsVm?=
 =?us-ascii?Q?2A6QtRCb8eBQwhngPKZAeXiUQ6aZ3+M0ChHVvURL5zQWokXaldmrkleXcrbq?=
 =?us-ascii?Q?m319VsCiwO8KE7XL5Cv78HY/0LYWoxSLNn2mmTqvrWd9yG+Qec3uj6BtS+ZS?=
 =?us-ascii?Q?IDIEvwJ76C6jzkAP4Il1+xroCrYFv3qumbfEv+pHINxTwh4WJOxoyak8lbex?=
 =?us-ascii?Q?kIG8lLkDFLDEBpi2e0NJk7examHe8M5DMEx5Uvk/NI/6OWk6OYVfDRRxlHhY?=
 =?us-ascii?Q?+R0e0iQymjMoobztU8A9kMfuyWGPqlFXxsFj4m2rWNiCjVT2Fbc6nFpLpSV3?=
 =?us-ascii?Q?2xPiilhv9iuOgqWBxbSRwo4PSe+DBdWott0U9VCUZJZ072sGisr5leCkTimc?=
 =?us-ascii?Q?i4BEwtd99mFe/w1l4XzX/0+RrDbKjOqOU+Eyio1MKm8bAUGq4M306s3gXFL9?=
 =?us-ascii?Q?jdJ6jxzo9AyL/XFYC1EjBD+7trH0G4n2+tvmYou0LuM4jSEkGwH9N3aZqIMQ?=
 =?us-ascii?Q?FLoAE/j2pDnzrBShRa2MR9AEF8/8wYjeZwffU1dGDeei1qu1JGQ7bpMdliks?=
 =?us-ascii?Q?7PTzb+HXUHII448IWxN4Wjh+KvrDtt8mRlx6upOWdAktyPstOBcCCvg2umty?=
 =?us-ascii?Q?MSLq2IfKfcM+N7ke84Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:48:25.2329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb8432f-2a1e-4a2b-1715-08de16c7ec59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

add check function for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index fafdd7b22316..25471d286566 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1498,6 +1498,47 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	return 0;
 }
 
+static int amdgpu_ras_smu_eeprom_check(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (!__is_ras_eeprom_supported(adev))
+		return 0;
+
+	control->ras_num_bad_pages = ras->bad_page_num;
+
+	if ((ras->bad_page_cnt_threshold < control->ras_num_bad_pages) &&
+	    amdgpu_bad_page_threshold != 0) {
+		dev_warn(adev->dev,
+			"RAS records:%d exceed threshold:%d\n",
+			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
+		if ((amdgpu_bad_page_threshold == -1) ||
+			(amdgpu_bad_page_threshold == -2)) {
+			dev_warn(adev->dev,
+				 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
+		} else {
+			ras->is_rma = true;
+			dev_warn(adev->dev,
+				 "User defined threshold is set, runtime service will be halt when threshold is reached\n");
+		}
+
+		return 0;
+	}
+
+	dev_dbg(adev->dev,
+		"Found existing EEPROM table with %d records",
+		control->ras_num_bad_pages);
+
+	/* Warn if we are at 90% of the threshold or above
+	 */
+	if (10 * control->ras_num_bad_pages >= 9 * ras->bad_page_cnt_threshold)
+		dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
+				control->ras_num_bad_pages,
+				ras->bad_page_cnt_threshold);
+	return 0;
+}
+
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1505,6 +1546,9 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res = 0;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_smu_eeprom_check(control);
+
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-- 
2.34.1

