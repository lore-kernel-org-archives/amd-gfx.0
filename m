Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239B4C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 07:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B808610E906;
	Thu,  6 Mar 2025 07:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l8JYuq5x";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3544610E848
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 07:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktiURog9nnXd3aCL+yt8xD0C1cfliD/hPKYxxF3sDZk//xJNM82YWFzZ/SJxNdI9tboxazeKRU5DO3p6Q0QrYGoB6IcxZsw7Exbi0QPrk9b3DXTzr+YIJwestBRQN/0Jdl0JpgPxdZ3VfvWEG4EWfFZairuTMrgdxFQ29Zje9SNpMTxUJE8I2Z+03jkDdE/sRfxWp37JavpbU0Nu6/1RPHLFBBlgz6VBBReOI5PkG1qbQYn7bHmxwYWRCpeGsjL2DS/D2Wn5lValed/6F9flyL7VX4fS0/QpW6G4u9EG/TXJzfmYdsga4sftEUNPwOb9tLqViB9U51oHLudsjdtS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0ttjHoDV8Hke2xIXiM8LVK7D7MBMjh/HFirZITuFM8=;
 b=rkuKOiqkbwKbM9Pkh7I4awoyG9VVZuu556nh6l/y7BBb7J7lLIJL653lDqoXMs2At/Oq1kKo6CiSyDoEFcBobBjHOutogvb+Mw0iYqNgEGUjLwbcQntJcEL9AraIf9sRvM4rrPX8JZvbSI09klXWMx95n+sSOl2qFbO3nBM7rOgyp7vPzTSTezpbvk3mtkP2SxWLRGkM/os6H5871DxSVZxWlBhHQr78Mw8ZhQMmjeNDbzTNEz3EVpT44ov7095N+kpE1ugABjU8A9KwLH4AO1MLFW4tYWWYNHdrSyBaBIb0LaAmuaMkARY8xFXyy49zVuB5rVep/Em01l8mEXcMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0ttjHoDV8Hke2xIXiM8LVK7D7MBMjh/HFirZITuFM8=;
 b=l8JYuq5xA98XEumF4uEi3h5SAPy2na+URuh8D8ZHvyh5DoKV1ZPUx6f9XbQK1Gt/v5DAn9fJHtm5+fByDAzghva6bu7kctIDZIpWl26G30fzZW1I0Mj35kghZHjC6W2sLgWuXpUQtIxojXWpfgqaZIYGLMqQ3dOSv2RI4yFv36U=
Received: from BYAPR11CA0094.namprd11.prod.outlook.com (2603:10b6:a03:f4::35)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 07:25:14 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::b2) by BYAPR11CA0094.outlook.office365.com
 (2603:10b6:a03:f4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 07:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 07:25:13 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 01:25:10 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Use unique CPER record id across devices
Date: Thu, 6 Mar 2025 15:24:56 +0800
Message-ID: <20250306072456.300967-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d030384-6538-405f-25d6-08dd5c8008fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T/sRU7ojgly+7vxxs4zgSxmP8gYU1IHqc0+phi/0hIxLwMrZCnoeXyNQnW1B?=
 =?us-ascii?Q?BfhACTMRFVObN7CdTyB/iidz3uNmFdKwjnizw92Y16UB7Qr3rZN+KX9A9OzV?=
 =?us-ascii?Q?uPhgfrSPEU9NS2h/GGjqHQrKvwirxdtwaJmMcEvlxx5AymVGdwZnsg/eSBXd?=
 =?us-ascii?Q?ZYEoaVTBje2fcbwFXoTyaQTFCRdQ7nqI8XdKEU3iSc0J8T9bTYrZxserZRaw?=
 =?us-ascii?Q?pWUWqYqjbmeYieDRBDGcSMMpB6CAeLySAnOgzbCpQ05uuQN47ZzKgmxx+zsu?=
 =?us-ascii?Q?kGsEPJHmiuKmYzK2t6H7DH2TXUDQbbhkQV3IweqaxhLqBZCHcDYiELh5Nbsi?=
 =?us-ascii?Q?Td5jWs72i8wvQXy4U5yBKVoJj8tK7O47OK/madP7gzcoRHcrj++CiOnBWIPS?=
 =?us-ascii?Q?GVs1zNGIbNXjmd7wseBn5ppKf4hrVmkhnACyjqMO9S1/XFN2XJg/F9FktTQZ?=
 =?us-ascii?Q?Cfy9NQf63XjFLCkllS6EJAKulO/dpsNYZV6wJyVQgllhIn7XMOK/p/yGgqVJ?=
 =?us-ascii?Q?iZV55bP9ihr6YMq3WL988lyMXRNuAWipEUZwHnH3Z4+vrleQMand9zRPbE59?=
 =?us-ascii?Q?oLw/H8NjSLvP1XWfhONws3KhKrmuTPDLfz1BIN33PsB7T0YzEz8L2EqRSf6r?=
 =?us-ascii?Q?JIj/hXVJQ7vjJo/+XnCCc0GQ7ewQcRe8+dened6qbWn3GUoy5wmCUAZzFWLA?=
 =?us-ascii?Q?jrHrFrCICU3IanyX/erz2/m2vhLcLnkrFvEGO04vqV6NgeJ0OCp1+FIXX+8e?=
 =?us-ascii?Q?Ww99fe8ixGTNClLDsWdSJX81Lg8hHAIWU7KIdZHY7BLVxqcdsE6BVaRwgjNz?=
 =?us-ascii?Q?Y9DczrZkc4q+nelqBYzin7A/e2ITcS0YQraEhukk+13lZiKNV3ozC53T+Jyx?=
 =?us-ascii?Q?lUDBltrvGNHlUKUtbVmS+cbRg8F1OWafjPpv4q4YyuJXlpTFqjxTyMmsTtxQ?=
 =?us-ascii?Q?0pVWNU9PgtaP0eC57zq6POXTA1AhrR+F8htXzfxlgJUgmJM05Ym2nyENTHxr?=
 =?us-ascii?Q?sukMBWZh3U8wPmGiq655EHJQHngwu9rK5EekokAPDiwc0ENhZWesT0TsKD6D?=
 =?us-ascii?Q?KBgeG1Smw6b08KldzmtyNNgi0XynLlWlWawkJtmvqxvS7/CZZPjHtlz9fOo5?=
 =?us-ascii?Q?mD6UT3Xh5A9428D02H7/cF+x0Cx7ZO3bzQyYwfUMawh0PpXcLF8iLIFISQu7?=
 =?us-ascii?Q?vF81bHK0dqBhus8vd3pAArnVf3H+SfiJAaOl2iMdecEeqR9vZOCA1Hyq3bGo?=
 =?us-ascii?Q?oBOVx3z7Jvoq00AL0rGOmYVZacGHyxAUf6o0A2qkrIQNdmmCZv4kldBAFVHB?=
 =?us-ascii?Q?NlkPUjpbgd7KuWL3g5qgh6tnedVxNs7iE0pDbQFScyAszxeeWW4V9Nsiz3qf?=
 =?us-ascii?Q?DV5YvlP3vwESPaIlrdqfh/84ct79LP+gVAtl3db9NWY9Umx61LVjy4pDc2jW?=
 =?us-ascii?Q?znFApeqm85enF/8NB1lI6TbXP4tn9VUaziy+qnk+EBTSzRxUSIL+sRKlKWVp?=
 =?us-ascii?Q?t5dni5njuTM9dws=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 07:25:13.0940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d030384-6538-405f-25d6-08dd5c8008fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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

Encode socket id to CPER record id to be unique across devices.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index d77da7ca9a87..6970a489d7c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -57,6 +57,8 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
 				enum amdgpu_cper_type type,
 				enum cper_error_severity sev)
 {
+	char record_id[16];
+
 	hdr->signature[0]		= 'C';
 	hdr->signature[1]		= 'P';
 	hdr->signature[2]		= 'E';
@@ -71,7 +73,9 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
 
 	amdgpu_cper_get_timestamp(&hdr->timestamp);
 
-	snprintf(hdr->record_id, 8, "%d", atomic_inc_return(&adev->cper.unique_id));
+	snprintf(record_id, 9, "%d:%X", adev->smuio.funcs->get_socket_id(adev),
+		 atomic_inc_return(&adev->cper.unique_id));
+	memcpy(hdr->record_id, record_id, 8);
 	snprintf(hdr->platform_id, 16, "0x%04X:0x%04X",
 		 adev->pdev->vendor, adev->pdev->device);
 	/* pmfw version should be part of creator_id according to CPER spec */
-- 
2.34.1

