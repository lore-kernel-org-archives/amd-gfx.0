Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4095EE83040
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A0710E4F5;
	Tue,  3 Feb 2026 04:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3BbT6s9t";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D3710E4F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDYRKwE1kiNrhS4F/txtIMnNWn9Hr0b3lTis+X6+I8P3SRJTvYU9tUc+sWvfp9MX6ZzCZQmRuqJwiNsP570OHuvSZs1254wU2LZYhnMeICgg/uDC5PZtDmG197tmwmHJHVVXlEHE5BZxOyxSUyYivtHFuj0XktPDNIsb2LNVKowJIE3uF+OKCOBjpXIvIrG/FHUhQtUw8UpydESEaHOXFu8S8ME60wor5uXTApgwhk+Y8+mUnsyR5MxZHhhPzOHNYBbl9GrFV/O6JwMUDsdmDzSTrIZJZ5/p6Mgh9Y+KaAS7pxSmH4Psu/7H/6WzHztXgAv3225RoBRlD5NbCNWIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9Ka1u8+xoRmvPizUnUOhdHEN7bAYb2O/GjIsrweETk=;
 b=SZERcmy7FP9vFHqEkEdXdgv/Iow3JaBmJexiEjuTowQ0aGaD8Jbl3OD8mwGgckedFtii5lQzf2yuEd/x6PDYIk+1CUc81i2D120wnH9JKMsRWox0Ks8Vp9RLCuSEh/KaRNNbzHV07wHZh7BRDUQy4RB6hq05Ks4Leq03NF61Zf73bFNFW4rb4FZhUwIW3nrns6z9XHYrZL4kEJg5jcuXXAD7jwBG51nU6vr5cNFPNWhV66gtEvxhWLTXyiBFcGEZ0lMVocfiuHYMNKStIJaIArdpvS1ljEsqDQL5J4a/WZ5xwJ0/p7B+N1zzwQSjEQ29AhL1zM0P3r4mGLCPEyQVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9Ka1u8+xoRmvPizUnUOhdHEN7bAYb2O/GjIsrweETk=;
 b=3BbT6s9tvUfJo34sIwVVxs6CgxmG2gsesQvTPkhppBc9CBYHW660eLLH8inC/Yo9I8PLyYMHJl50DwIifNoiDfHZ/fmu0QWs1QmJNh3YPDCoyYbVGop2Ig1YQz+vE+VMKmoEiBWiIkVXTIcaXB2jjYg6qu+Ce+HNWk4cdv+y1WU=
Received: from BN0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:408:ea::29)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 04:12:59 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::c) by BN0PR04CA0084.outlook.office365.com
 (2603:10b6:408:ea::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:12:59 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:12:57 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 09/14] drm/amd/ras: make MCA IPID parse global
Date: Tue, 3 Feb 2026 12:12:01 +0800
Message-ID: <20260203041206.1299104-9-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cfab62-e278-45bc-1066-08de62da843b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PZs5DlTpCRbGfWPLPCWp2o8JNU2dEZT1etyFank4RTvDfeLFLKx3S1lwRfBe?=
 =?us-ascii?Q?PQQKeaKZxXOgBgq6J9kJJhkJlIq1Hmx/vqA7n8zLIPYOGq+sejN08xhbgK4S?=
 =?us-ascii?Q?ske3dJYXY4tgVHX5V8/41xleSTV7lLjZ+Idt1SAQIyc6O1Qv9/P2oDHUAL/6?=
 =?us-ascii?Q?9lWUali/s2bDA4mDQSFd2XzuP8QngnRyZ6Ht8uwlB/ULF/co+LK2dFxR704A?=
 =?us-ascii?Q?mZ3Dkz4l8+3FDCqA2Z0418IwNg4bgaM/y6Vws8WRYGL+AlklCwRsse8C7IK0?=
 =?us-ascii?Q?jmatBz31siGzrDCnuYY81ySXw2JkLx1KlyAGwtoCBKCx4Xp+8AJQ6RNfSgLH?=
 =?us-ascii?Q?Iu69E3STXpXBSgVyMZMlQPdtAuI/GqPLFWZX8fylINzwe9UwPS9oT6sqR9tH?=
 =?us-ascii?Q?NqHkeGkpfZxuU1Yp0NgC74t7JvSLfjmwoEwl2zraCwwLIpKUPmO7wVMnb/2v?=
 =?us-ascii?Q?oFhMOj8xKzJi6z+xPEA+B2zT5NhCz25hLYHZI2Ge9zyUFlL91X/aITok0WeD?=
 =?us-ascii?Q?/TVYg6ge8aheD5nH0KjzZqIanB931UuQgqwUycP0HeW194dXWO4VGC2Vh+HC?=
 =?us-ascii?Q?JN5PgIHfRlpog4xb5zQ6WgZa839L/sFsHgKvU1Fy7Crdq5HN+HOuHt67U8Op?=
 =?us-ascii?Q?tEdsllIVHh8ghHQmFTMuocKLg5bGKeyXJMiaGHAMjglpNuyqTQEloCpOeEb7?=
 =?us-ascii?Q?aKXsN8N0YQP4TLGl8rFx5uBmzEkRXGdnEd/psL54X/72Q8qHUVxr1wq2A8DQ?=
 =?us-ascii?Q?Y/qmAHCUDxSHAzWPcbEw0xR/9dPZLju4nAk6Npga9BlokLAZg92bt+ATjrEC?=
 =?us-ascii?Q?KBaiDjvoUPCTcDyEp3dZ2QtAfPz6Fe0PgX1EFHGK5JdrCfFdTSosu5YDWbTy?=
 =?us-ascii?Q?4cBIDjwPMw1zrvtvBoeDDuvZaqbo5U+dC9HAdiYQO0gx61twQ0uVCHSDCvSO?=
 =?us-ascii?Q?IQj8ukwMtTGcE2V/61ptmvQmzjsWFAVD7HfD5J+zK0W5xe+6ARt4QSLicq/S?=
 =?us-ascii?Q?0FoLMstBFAR/Vinq8QNxZD1vhjbZ1UtiqT53//SXsNTSK3cdj3gNVDYeLH2j?=
 =?us-ascii?Q?7tIh/69KdOkzRrQ/7KV3WWQtX46BSYTSgO8XxsxAQB/yXpyxyHXQvpCKUBhB?=
 =?us-ascii?Q?AV/ysZ7Qys7HMdAipBnq+Bs2BuZFGhoOidrJ/kpARv+/rkCnOBd5fJIIGeTL?=
 =?us-ascii?Q?7jRh5YCYUtHtdXoSeOHMPDgW+gL9X3zSC2TITJQAj4qTJ+tuu5p+ZnKaujPI?=
 =?us-ascii?Q?8NkBgAW4HMT1DtydkBN8iPy5ZOsUMCDB3M5MQX0Xv/uVZ90U+fAsMzpKiq5x?=
 =?us-ascii?Q?81qVJPqHvHmBJ4G1nKnaLXn/URx46JemU/virl8u896vF4+i7I/Rb8Bp+jwT?=
 =?us-ascii?Q?zAmynav0Q0N3ZtDF6j5PREF/ape7vyUR0yYYTjPeOJSnw7s2o/2DfOq1tJAL?=
 =?us-ascii?Q?O/nIBn5dmRSu5r/mIAPMFM9jP052Vkm8+LlqR+J8QbiUJJCeFKFsIfG7wzBr?=
 =?us-ascii?Q?Gq9Gw0bfMQ6k5dt3XGtGSIcWRJgk8Wsz5L1ypjGpv4FahaS/K1J3yqBS26ST?=
 =?us-ascii?Q?uxOr6+yROJ+hh1RRyI7fWpj7kYzZOP0OZONuVxNIEw0H5T7eaUNrYwh6tdWm?=
 =?us-ascii?Q?mZhXuUoD1mFyRLJdOtz6cB/OqMEJV5Zok7cp/ESBro1iRJUGFJ6Udvbc3uqW?=
 =?us-ascii?Q?t4cWeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 06zzLAJUW8x5fJ3/XOHKpXm6Jmc+7WuXIMrJEClJBkyEKjLCrI7T6u4n0xvHd6rdosqdRxgieFys5wsUD5p5ITBFejVgESp2J4dEXr2jCTQH1LZ4x6AeAefqJUL32l8JFv+N6atQDV3UmRRdHCZKvgiH+c45ZiJ9DcmmUXuBvtpyo9ZJMm2XqkQfGRmWPNTozyJW6SbK50HJa1x1jgkvnSz1LKMDWZxc1k4e2X6EZNqOTMnE5vwp5wcsgJVBUML3UjAZanFCtZZ5pDwT8zbZ7MXnK4E8RPw/tE2LOjEJgnH1bClDDP4xtXyz+QddiJxZ+yfnnHQN9S4NcgI2ahm0nhy0Jj+eZwlPkMGex6wrI2VnQYJrmqPqXljAt99fNuiS3VGH0odPYNmFxbKP7X07sxXPfc0/lrLP0YLYHDOJAEU+gWFkh81gLZLsRipXEQp/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:12:59.3625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cfab62-e278-45bc-1066-08de62da843b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

From: Tao Zhou <tao.zhou1@amd.com>

add a new IPID parse interface for umc, so we can
implement it for each ASIC, and so we can call it
in other blocks

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h       |  2 ++
 drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
index 7d9e779d8c4c..795fa351258e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -108,6 +108,8 @@ struct ras_umc_ip_func {
 			struct umc_bank_addr bank_addr, uint64_t *soc_pa);
 	int (*soc_pa_to_bank)(struct ras_core_context *ras_core,
 			uint64_t soc_pa, struct umc_bank_addr *bank_addr);
+	void (*mca_ipid_parse)(struct ras_core_context *ras_core, uint64_t ipid,
+			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
 };
 
 struct eeprom_store_record {
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index 5d9a11c17a86..e2792b239bea 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -501,11 +501,25 @@ static int umc_12_0_bank_to_soc_pa(struct ras_core_context *ras_core,
 	return 0;
 }
 
+static void umc_v12_0_mca_ipid_parse(struct ras_core_context *ras_core, uint64_t ipid,
+		uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid)
+{
+	if (did)
+		*did = ACA_IPID_2_DIE_ID(ipid);
+	if (ch)
+		*ch = ACA_IPID_2_UMC_CH(ipid);
+	if (umc_inst)
+		*umc_inst = ACA_IPID_2_UMC_INST(ipid);
+	if (sid)
+		*sid = ACA_IPID_2_SOCKET_ID(ipid);
+}
+
 const struct ras_umc_ip_func ras_umc_func_v12_0 = {
 	.bank_to_eeprom_record = umc_v12_0_bank_to_eeprom_record,
 	.eeprom_record_to_nps_record = umc_v12_0_eeprom_record_to_nps_record,
 	.eeprom_record_to_nps_pages = umc_v12_0_eeprom_record_to_nps_pages,
 	.bank_to_soc_pa = umc_12_0_bank_to_soc_pa,
 	.soc_pa_to_bank = umc_12_0_soc_pa_to_bank,
+	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 };
 
-- 
2.34.1

