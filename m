Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E6ECD4F2C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 07:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9398210E96D;
	Fri, 12 Jun 2026 07:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FGuLZgR/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CA110E96D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 07:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u16xTyQ/kVGoJzXtCCizgoWbwmH5a2P+F0AG5+/mvpcSAvOy9Igj+kS++NPAnyqzzOeI35Hs7QKvEYwqmGMKD9VE3QWWoVQQjO2qF/GUINNsiTZ7lQlNLSfU1FExnSk6cqhycN7EEYlC0qZGyiWEwO1lPFVFSeLq2YhdzoMx32av24uYdA7VeBCYx3SKMSnehmak1hRN0HIelTFaKKgRSXQowx4rUC6Sxt+FTUS7rnLkEFEPlFDrqYB8b/XLjraCFa8BbGLAX0jLMRaULGBPW5IxXL2awWB5WRQhE/5V3gPZGyJpVS7mxvWPCnH8+PG01KGMmqN9Pjd0w/9bPe65eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYb0wzxgXabXepPq6DizEWkyQ8gcmicI+jVt8OuWerY=;
 b=C4H4S66d+aGHoZJw4ut6j+536DL7kZMvTr54xJgkq6uPQuf4PsQQh5vFcfYebbxLIRFqeqT1rShxxu9kdHZtk+WnraallMaqbwZCSDQPxEC4YOLPfl38vhbhZDng89lhkrNO0Yg9kHsXzCS78iBslIRGzEFOV/vx4sSGydDJwdy1RgtlQHoDf/Bd6zSixV86MLQn1QRjMArbm9wC+OrrDe5j2/JU316mxS0R1YjZev32HQP9zCZMIuIO0accrbwDRXQpMy6NpWRUiSck7FWsvCJdHjjs6LfiUIWibcfkV1Gkxr+ZqxKZJKOZkUrHQMtEGRb+HGkQLxqKb9XW3yrukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYb0wzxgXabXepPq6DizEWkyQ8gcmicI+jVt8OuWerY=;
 b=FGuLZgR/UGVOZvmPntV9fx8mdF0szfV9YKGxHAcbqgiN+MAvfaB4+YNFSxD738w7A6L/IvVoQ7fJcnui54JHT9dGFoRhc2JbU3nIz1i6atFbWG89O62HFJkQetWEK4Pjz2bLNWmM75WUgODrJKEdKTpA8RLEIUjlz/1C4K0aQ9w=
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Fri, 12 Jun
 2026 07:15:15 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::12) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 07:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 07:15:15 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 02:15:13 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: Sync bad page count on EEPROM update
Date: Fri, 12 Jun 2026 15:14:26 +0800
Message-ID: <20260612071426.1615878-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: df12d0cd-4117-425d-2bd8-08dec85259bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: MzlYKpm9cbRzOffZxO0KEJ3NU7qu2vDqbcvwL7UgRm2LX0cQBEHmROnr6rdbBV8PdclnPRGSXvADvgOUL0Okb8w+txfnkFOkYixvObPAEu1ccqX+osusw7CQXdj2lf96CWAgMKKFHWSGUiPIJBSOYrl4iPMadzbuHp9EmXHb8+v8cZLIGrEmWxr3sT8Yc+fR/CRgVUjp2KT2qhziaOfvlFm6bfa7TsZvtCPACQ/L2t68Aa970MNXmkzH+q05bQIoDKuFMqboURlThw0IraxsDPNAYMEbQkBtzpzaNOcmClvz6J1lvRA/WA/jpexR6/sxTV4DCDwT1p5gvOhjbblNJeUAT0HVQc4QGmyDVUQU6tR06c17RjjainoChd7P0maBtiRnkT0XcrDMeQcvdVCrymfCfPrhlYB5/uXuCocLyVL55aqxLIZtPSWQI2sJ+8AMCA5b7i+MofHg2yR10dAWbEWtOiO/3HScAYpRJSYgJ5js2YgvW7RGXiZybyaeUIt8C8v1rMMh7pIPMMkN8SmBODctwFUQOQQ+WbSJjfKbwQwBYpSOiXv1g6UYmyujhSP0w/0yxXMkBg4/9YBWh/18Po3ZK3vpsAYwmtm5AkFc0+IMPokF7uuJ/BpsqUhhbOne9tI45lD9m/fnce90Vou0oHQQmZ/9UfoPeTe9vYDWKh4kUgL30/9tTUs0bmufbOV93cpRxUFa2Uq7iZItdMXJad76ZyWK7N8TQGKsE2T2aHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DgUSY2+j+lTy4c6gJkIX+y49zkyNQkwOlsTNrDqrwAJURC596PVjhNYhZIjJ/Eeng8pCGMiRFAsXQ98ECTZmpJCKIQxv5MKZElN2Ww6wjmORF7rOzFxVKrhAo6O9X3ssDB+Jb89CamqeiZYFPeHTOZ7FQN4YIMlbkyDDL7xB8fEqgqT4naClFY3roOJw9K8Se/qidPsf6bi6XAO2+VReLys6QK/0+FlrSzZ4oBCD80qqfybTw6B+/lXRQ2u79qQNoZ920puwvKDKAaUtRTf2yvA1bFOYdzrh24isJB2aAphIMsU9JElPPVTDN97btWHidLpUVvpcJA9oz3vs/hutQFc6BemVZeqEqUD3DTk8KNCHAP+J2DmY7WWHUaJKiqPnygb5wyHH1C3lRQuEuAioIr38BWPj6vzItOq7jlgYrk4aKN0ua1Z/UfMnwzli2J2X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:15:15.0726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df12d0cd-4117-425d-2bd8-08dec85259bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479
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

The rascore EEPROM runtime append path updates the saved bad page
count in memory and EEPROM. Keep the SMU bad page count in sync when
the EEPROM header is updated so firmware sees the latest count from
the runtime threshold path.

Notify UPDATE_BAD_PAGE_NUM after computing the rascore UMC bad page
count.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
index 3a0ea036c9be..62d1a319c08c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
@@ -746,6 +746,9 @@ static int ras_eeprom_update_header(struct ras_eeprom_control *control)
 	int res;
 
 	bad_page_count = ras_umc_get_badpage_count(ras_core);
+	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
+			      &bad_page_count);
+
 	/* Modify the header if it exceeds.
 	 */
 	if (threshold_config != 0 &&
-- 
2.34.1

