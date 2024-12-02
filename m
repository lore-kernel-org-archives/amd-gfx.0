Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D81D10DB0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 07:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC06A10E0EB;
	Mon,  2 Dec 2024 07:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4/UERicx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B97010E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 07:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x80gMKPwH8WDADMR1DVwoxT2jg508H+U6RkjDKz/JYXzdvd2NpKeuPCtoFtirHrTOGCJ/xn+Ey57UAa0ZEHeVqvDJhuLJR5xuRv5VILsxCASq/G6kchCmuTR+CQhUgwx1OWrmFyUZiSNltt3lV6SWbrVZJ310iD6y/T4p2WwSfnEBKpuGj25+r7cLSuDWGcjijapoVPASVk+FKbXqd6Pj1Q0nDxbe5hZ30n0ecsNTCwO9Ck+9iwqm9MMVqWXnyOhvI+nv4Uh6hEzPwQQjZL7Kh5BxcKRGa2MJkRCqzFUqKoyu311yXlC6J9xmhCVJ6ksAARG+Ri0T+G27j4sPtoG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfrH8VEs0EURixGEisOPuJFx9+S8PqjOSjuDoFTDzhc=;
 b=m3hrgxl6NBADwu/q3sLl7UMIs+jTLtIX/tmZAAHaXzmPcp583RydwvIoWmk7/uREgMB0pAG2MHj6exOSQX3MNfKcLxqwyH5oqO69a8WWAR/gz+kT/k+TRDhEEsBxD+FRJrf7TIqPc2a4wLEJytSHXuHlQQac+iQBcdZWNgi/VqhE1iogvCHufxGEs6Hvag+n9NvkvqdG2V3FbDERIff9bC+2TFLBH185pv9kgOKgAp+QPxq4G43L4l9ixsrHWfWCUdNJsOkcl3QocfJuHZYBC/8VruvqHbmcR0du3XDHsd3OclMVc/Wa07kCssCnkx1DNRSuUFTTXGuaU8i2qrGHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfrH8VEs0EURixGEisOPuJFx9+S8PqjOSjuDoFTDzhc=;
 b=4/UERicxHToQGN1/0Hsw9yvouPc2zGapAITjx4bX+dcOC/wbltjT3pfUgCtqqPJHaBPzX6AsAp5Z9qLTBN2By3A0mZo86Y9AW3hfuR0pGuRdm49IcuoPoxkUmSVC8XEtNXDPAkh0o6OxC4n8PoHC9uI8WYLHJIvnPToQrBVbX+o=
Received: from CH0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:610:b3::29)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 07:18:54 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::14) by CH0PR03CA0054.outlook.office365.com
 (2603:10b6:610:b3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend Transport; Mon,
 2 Dec 2024 07:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 07:18:54 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 01:18:52 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: only send PMFW RMA reason message when RMA is set
Date: Mon, 2 Dec 2024 15:18:44 +0800
Message-ID: <20241202071844.116557-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3f24b8-fa4c-403f-0896-08dd12a19443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7w7zme1LFaIyyIK5ub+Qyf32nF3v4Lo9ZJN/Bgqlw0gf87gnSdNobM2qyOkq?=
 =?us-ascii?Q?7YY0sbl/5XqiA0cGa3tlCTkt655o4/UhCqMfPGcELqseFGCilG+eWIyRm7S6?=
 =?us-ascii?Q?bSWsLEnlPcHcSRKuGlX+fQ94bgFEYZ0w3CSmQWt1hMuDuX81uc5AZRII8T3U?=
 =?us-ascii?Q?VvDW9/0lklluIJG8gviR/DAkPMYgfXxbeszuxwvr0dnpAiYEfso7+5JZvxMO?=
 =?us-ascii?Q?/W7lPvPdIxBfd7R9nQRTB7sYbIuAjEUhJq6YqAvJHHSzK/JuMrw7kQ3mOguK?=
 =?us-ascii?Q?TaDSet8qfnKRpW0NfJvQWdAeaFHYmPzINbJO0MCxu7CILj6HSZCsBDA7G+lB?=
 =?us-ascii?Q?HzqAG8pa9odX/CcYoRvfjYvK3sEkm0UCBUF9U6IYxKGNCl9Jc8U7pmQTg1Lx?=
 =?us-ascii?Q?9YhbLlDErzOEwLFinng5ksBQyKnGgfGipim8oRL36iOiMWzebqRNtfbx07i0?=
 =?us-ascii?Q?oW+JjANln61lA5t8YknHRoRBYRlGOO5zglini/yWh3mC2hK4UYPeumKbcqBW?=
 =?us-ascii?Q?4agXE89V/gXaMGFxzdTVHjvZIZYKTFM9GtMGS41fS1qOsYYvkTBRT7bFEN+t?=
 =?us-ascii?Q?6Z68bNrXaj0wsPqL0b1EShtUIBcaUHEmmvBFiE+Rof8ausdKFuJjgzCMJXcD?=
 =?us-ascii?Q?Dtfa/FzfB3lsR4ffNTu3WmoX/88jC4U5NPppvZHpvlZ8zXW22hp/XkbqMdxv?=
 =?us-ascii?Q?hJN+wikHUTJPfHzqsC+SdZ3Y+9NPBjElX8rrfHmh208B4QnnfCs5QzKDZbnq?=
 =?us-ascii?Q?ipSF2ZouAQt5oMJW1MhcMV0vop7R9jQPn/B6ukWPlWXIr2+vPFlVVek2ECQ6?=
 =?us-ascii?Q?27HT++jHJNwxGTzrVTxyrxo7L/j+MipbqN7eBJVn1mNZAa6kcyPTDvuakFOs?=
 =?us-ascii?Q?/Tfr53iEaFRLZ0Ea3F5kYi9mXzQzmX0FLl6eJOxD4zcrz78Bxi7xMSaq47/P?=
 =?us-ascii?Q?KQ77+PujdCdk2G742LpSDlrxDr4vmVChzNqM3cgrFxx5G1UZQEAYWjm+j0gZ?=
 =?us-ascii?Q?M357mFMJt1LBHT69QTk46NkzxDUyk3jCtv8sZ+SZDBoFAkRZgknxSTvDRguU?=
 =?us-ascii?Q?dDe/pSeoV53eGRyb2sklxbzRvIrpQ+wOe8RSWjtOYHj0z8k188XxgMMoKuPn?=
 =?us-ascii?Q?tbqDrP1W5sIXhq2Th0uhaYrpNYzoaLYZOVefkEy6AoUg9aqMLCf1MgBKqvyg?=
 =?us-ascii?Q?oVMDlX+zEEkg+DOiOOs6xyUNaEeqYl7LsgWEsNLI/uj5C3Sy6N2w/90XFqJk?=
 =?us-ascii?Q?pYZ67/Cy1FiPA5Sihus60IRwX8gJSurrMQPTNP34OmiSSeQk7GVCNISj6Sy6?=
 =?us-ascii?Q?svYQT408xNOb2Qh3kEJkBCDiBPIKXL4bj4Pu3TAnuN0J+JapmnBGmkkSxP4o?=
 =?us-ascii?Q?DEBtbI4xBkuMat3STgSuiuQDJHNHqiNw5pY5JE12BKn7p9+QCJhHL5us9C5b?=
 =?us-ascii?Q?oV+5D1cuRf98PC0v10+hV08mkBXL/AyF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 07:18:54.2152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3f24b8-fa4c-403f-0896-08dd12a19443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

Don't send the message if driver only warns for RAS bad page excess.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0d3fdeffd865..2a46a7556807 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -758,11 +758,11 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			control->tbl_rai.health_percent = 0;
 		}
 
-		if (amdgpu_bad_page_threshold != -1)
+		if (amdgpu_bad_page_threshold != -1) {
 			ras->is_rma = true;
-
-		/* ignore the -ENOTSUPP return value */
-		amdgpu_dpm_send_rma_reason(adev);
+			/* ignore the -ENOTSUPP return value */
+			amdgpu_dpm_send_rma_reason(adev);
+		}
 	}
 
 	if (control->tbl_hdr.version == RAS_TABLE_VER_V2_1)
-- 
2.34.1

