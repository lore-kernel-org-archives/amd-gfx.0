Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF76C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 07:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBD610E5AE;
	Tue, 12 Aug 2025 07:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8QNCtcr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C20E10E5B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 07:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW+/VqsTGd88F10fqE9h7am0VZnowDqM79hvwruFRSHSh6GmcU6HHM/R86xn9iju6iuxSv/XjtazyU2BnFwP16CCMezlrIgPaEjZ7VuS9lNzh126Tp/zTt3cSYgf967L5Z5vQqxNV72uZ2we9Dt1PXUTwKwX5KBhAPPgC+YDq7ZzYRtx8Tp1Q5pW+yVxj4Z3PHd2+UUjDnSVNJdipAhOmzo1+mB/8TJSkglXuIKtE8osC8IYAEm94UPpA7DWRe2BfEt5SMGWuippe8IK4SzDukp9JSlGgDJznV/4WstkE8BGTFiboBNnFqH1Q7CpJdfCR/tMVRZ1zXMsY/remL07wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6nr5rfpcPs9rMmVIiTVWB00nmT+Tqfklh9i47X/6CU=;
 b=Qzh3SHrywvm5gayLXM6hDhSZYZ8/hXLXC9BDQaCBrtV9oL5pui+i5+zgqsa5zj470OZI4T6JH6dLmbNdz8dUcHmMabT355gWfIUDmY6SeVUfCEHc+Z8yRE0XZiIOzMeQSF6x2/TcEjJXSXOTDB5Pv8w05UNknuVqaQKZAplI3kbfyCvbgV89uSG+oIL/VJesRl+S/7cc6IxTYrUtHVgO3FrxylZMI0IqSARzkYTnmTop6EWTy5qLKvsS+gT+V2nkpvIORNEWq1wxTgRREuDOkzkgYWbYjW5yTmqH7iwNeH4BsRLxPyZDdcigabfK3FkRXtaGOLlJw4jRH+XdpHlc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6nr5rfpcPs9rMmVIiTVWB00nmT+Tqfklh9i47X/6CU=;
 b=g8QNCtcriUl9EvxaVIQGwm4NKt8G2dfNy25UHzi9OHSPxq6qZuQ3xM2kOsOAefFtQ3ODzE9BeQXu7xddBNmwiL44Rf/WhTSkvSE1WV8UMRiQJISpAGT+thoZaUfM+q83HiTv/7WVs0IivH6hhn6hkh1UX/Z9b0DgWQx0BX+HCXY=
Received: from CYXPR02CA0065.namprd02.prod.outlook.com (2603:10b6:930:cd::9)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 07:34:15 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::64) by CYXPR02CA0065.outlook.office365.com
 (2603:10b6:930:cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 07:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 07:34:14 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 02:34:12 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Correct the counts of nr_banks and nr_errors
Date: Tue, 12 Aug 2025 15:33:57 +0800
Message-ID: <20250812073357.257876-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f440fa-75fc-424d-ce1a-08ddd972a389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5pBqdzE6g2gwSwTYLuDP1c/LZQLL/IB3qzjIaZdxO2Wk3jhfGI/u6ojErlyN?=
 =?us-ascii?Q?Lj1GLLhK4zn0p2A14quDvWANR5LGFaatKtzDXnxCxJiIrfl5FRMkeNUmPQtT?=
 =?us-ascii?Q?jy8nkLdNEVyYFvlnu5htAcDRCzauGDDtqED/t7zGxxjt+EuOTYWweDcH7WT9?=
 =?us-ascii?Q?C5u7Ubli66OshArUe7mWiQunp0T2xh9NgSmcK9M0i2idaD9gb/n4JCCRC4n3?=
 =?us-ascii?Q?iTXxlr9VVPZuwfUnObi3NFtE2GdSaD5+pYRmFmrmBEU8wcHn1urCdmYdMza6?=
 =?us-ascii?Q?bV7mOq9bdSeR4hiu2suj1Aod5XGtN4W+EQqLkPX4Emg6mmgKbSZgwdb77rnC?=
 =?us-ascii?Q?MdHojc1lhhKyJV8VCZX9mAVyvqwA4f1E9XIez9BvYqWZO6b7LoeDUvg60hW2?=
 =?us-ascii?Q?l3rkLTfWC8CVXfCb8u+P/TN6uk0A4DEOGTrqE47o8SlqPzir9XFFwTy7CMnd?=
 =?us-ascii?Q?CjIzvf6hTffp1jtNwOxq6k/rUiCW30okBUxdggOiSk2HpVJHz9ZIuMS21mMW?=
 =?us-ascii?Q?8gVv/CBIgRHi9aV/dKN42WqHH1kZfJx8ONKzboABwqhRCLLu4gJdVombc3R5?=
 =?us-ascii?Q?osgfLPkDjWU17CI+JwxnZ4prBAr5Dp3g/sjUMBH4Cm6eTWEEvFRm8MR++4Vb?=
 =?us-ascii?Q?0B/EAzxfw3WfhPwLXDxDT7770stf8pyV6qUPZUu8SFLTe95ZMGM8Bgxe/1eV?=
 =?us-ascii?Q?cHN9zB3bNnIdq6KSxbk62bgYvY3jM/GpTw+DzWqZViGAj/YVbihR5dSgp48M?=
 =?us-ascii?Q?s7LtH7IzNuvXG32U38SS4HCCFnod8R4ZofEEN4xwzB/lpY6SGrPK3NWvl5JY?=
 =?us-ascii?Q?fGXOZoWZ+FBLMteto5txoCaOg7E9PNz7HylEavfEvfLHYWSytyJrbBrX/MPU?=
 =?us-ascii?Q?TQE6g/1MwSgY2UjjaoAmcXdlA2RSrJnhExOESzfsjwWnUgMPuDfYPm4eFLea?=
 =?us-ascii?Q?7cL88sQhy2OsKvWy8Cu6NH6NeOvF6Y9BnqMwyhlSf3utdqQzisY5fIAqzXx5?=
 =?us-ascii?Q?YDgy3d1kHb6FPj5nil/YJXEXAV/wM/2w54xC1NslVq2qKgvWLnvBBB61IfSC?=
 =?us-ascii?Q?gIszQpAmEeIOV2XJ3klOnoQOD3HMAc/feAo7O2H9o14qstsZCjOSb///lhqy?=
 =?us-ascii?Q?9Ih9XWn1WPqUVFuF5eYDIYKXm48nA4UMOhi0iBEnHs4fbjhgICqyrwBbBOms?=
 =?us-ascii?Q?C7f010yb3HymXIkoPJsKy41nupnopJxHzTPHEab5YRcF0A5a/J8V9KPla03U?=
 =?us-ascii?Q?Rc1zxSZ1GDZnM0oYaExKqeyWbRARTXt72azXh5O///DhHAOARLNQKYGYlwS4?=
 =?us-ascii?Q?qcf0xfP9tHf3E373jpi5UCOURCSWWpYiBiu1vi5a837iCKJWXQ4JOgXGnYzE?=
 =?us-ascii?Q?1qHy6Oaq6jwzd9diizJ7Ey04sUMyGiv/4zO4nNddtcqY2k+MQRX4mn6wDYfs?=
 =?us-ascii?Q?ai4UYn3sxW4pMg1DCUOE6C2WHCfR4ID5u6+O/7CCks0K14hP6tIe/ikd+gbx?=
 =?us-ascii?Q?p3VPXSi4i4p+BXa/OqXqy00eNt2x4auebf3Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 07:34:14.8823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f440fa-75fc-424d-ce1a-08ddd972a389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

Correct the counts of nr_banks and nr_errors

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index d1e431818212..d14dee8d6632 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -76,6 +76,7 @@ static void aca_banks_release(struct aca_banks *banks)
 	list_for_each_entry_safe(node, tmp, &banks->list, node) {
 		list_del(&node->node);
 		kvfree(node);
+		banks->nr_banks--;
 	}
 }
 
@@ -238,8 +239,10 @@ static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_
 
 	mutex_lock(&aerr->lock);
 	list_add_tail(&bank_error->node, &aerr->list);
+	aerr->nr_errors++;
 	mutex_unlock(&aerr->lock);
 
+
 	return bank_error;
 }
 
-- 
2.34.1

