Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D755CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 12:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F37B10EE73;
	Tue, 29 Sep 2026 12:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fnhdLA3l";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011067.outbound.protection.outlook.com
 [40.93.194.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF8C10EE7A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 12:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvWXHASSDQNDFIKlQRnpB89PDaGLfIyOT0nG+Tl6k0MdbnVlAOqYjoJrEcwLKSw1hSvkIrZTseFwLmYPbHlWbMSRieK2QBO0+Xtcad+GaJCcktfZfw9qkQs6DwIihWsGC3H3MhZbw62JG7P+8lqcaMy7ezI/lxxJk1kSCM8EYjlKODNxEU4L21OEnfhCuQl6z9KT6lOsXe3lqnTABJCjpY5IYQ5FzaAlsGcO2iEqOjgNP4/kxF51nd+0JPTbEAmQl8BYAUXeGhG996GBrq7Hnrm5u5ONWbgUsCZFl1hHTW1gf262v3JW2UuUlCL4TXc6g1PTYXLHSrFiAKVpBS4m4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3pZd2wWD3/djf22AdptyaVS/kNn7hyAAeBm6ZAkH/0=;
 b=MypLOX4dof1/ZEODPAG9EJpoKnhMv9trvjDIcl0PsmuuE0i9aAQU1Ic2vBCqxRCnxVMoJnDvRhD6w/BTM+CEHpBOHd1LMvfc7V3CJFUu1RcU77qV4KB4Bm9VI2TiG2iDr/Kmyp1uJyvpKgq8jUC5q24qSZysQSXua6KE5XcjuJIIF8xLFmErjDoMe72yagvgxmu1JmxUwP0TMnAYCVz+T5Nd28Conp7m5emooV6df6OxXw2qJ6rT9oESQej0nMfllo7HIMaKbhLmvdQBe41T30N9LMcNbzYET6AAe/8hNSD6M8gisCu3iAHFIhB2jylhmzCxqfrfBytfrOxtaVpaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3pZd2wWD3/djf22AdptyaVS/kNn7hyAAeBm6ZAkH/0=;
 b=fnhdLA3l1z2U9XFdMDx6xsjwHP1fgyTe/qmuc9GLK4u5mh7Curb5MjrJeZ4RU5KOWzpzGEUGhxUrf7OQZPy2zmPmzevid1TDf5p82J35oNIbbz1Q5W6aMPo8/8Q8S32NBwR73NOxIjuWZOKTVA4MrpdgATTkGzMKQ/J5dKrm4co=
Received: from BN9P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::22)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:02:41 +0000
Received: from BN7PEPF000000A6.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::e) by BN9P222CA0017.outlook.office365.com
 (2603:10b6:408:10c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Tue,
 29 Sep 2026 12:02:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A6.mail.protection.outlook.com (10.167.245.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 12:02:40 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 07:02:38 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: report threshold status after bad pages are
 saved
Date: Tue, 29 Sep 2026 20:02:14 +0800
Message-ID: <20260929120216.1230237-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A6:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f21f75b-e322-44b1-dfdb-08df1e219007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 16gkcdUXG0OtCt9tdCao0fuU38MG3fsjdz1OwSJHGysL3euvQKDxft+SLTaLTjsVJaW9S561ENiL5rIGdP7wE9QQ8qLcFCI+U5VEItPtWBCooO8nG0P7mCNlSymai/Dfvqd7MSXtkPd5GRca0bToau14Y1if442g2iXDcaIX+oD+J7J1K8o8JTzoD077S7bIvSYXj7hKXNVnBFd7tlTSvEX+dWWSwUwqlfY+TxyJWSqYPqvC/2MPLgrTgS/Jwg76R5hkRg9SwwrmH3W6mMwpLRY4vUCPIWz3eKEpwpkWZhgO7LOE6NaoluL7Q6vqJUvnNxwO0yp0CV4iIQ5E9jefv3/znBD420Vd17Lee5iDGyP5MMz74FBajkNpCK6ajShO/wQa9FxgC2+X/+wLD1/GGYmwcuN1SbOSXYcf/QmyeCdYrvLgbeCWPDYQWhNbTVv87LEUMDS7gPJsqpDKasvJrtbhG9gN01OMPNBp4P+rA+PW2OfuETQkvkALWtYZfeCH2NGTGbnbHpLwfFM2Z4aa+MV98H+CmkIsrJEaOgghEacTlOUnrQzOOMFmgEdVz5UEY+KEpeJFNceDdY2f+zNxT2Xf/4RoeiZ/RzNFrPkdjOxR53I1nkyJc76dP9X8TiWLwD3Re/E8IGJcDXochUkyatqlRHWdsDBEiKvV8DqIpli3h1aNE5dzqYVviLOFASPq0pJFU1/ljF3SylXgjrloTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(6133799003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: trgkFmn+Cz6UN4Cs32HReTnqh1uleVPOmQc0wLGyOeqmtJfjNPX3IOAn6kBf4KDW+Afv03Kj6dgXStc9HkLUcQlbnuiFJw+OKhz/k6cNX/wVr6nrIcK2S9kBeyoAcQHm7c1e5NxO9SX2geR/J7SskIJvoXmMd6an34l5BZBZnajrj6zzHqvqSmLN+C4A0A4n9ITAyIT49oK1ukPLW6zxAco+8OClgo4tkMPvalN/Q+OlRRU52be0DyRZR1j+A4W9cs5P7ttZ8bQSgN09CP0wuaq6Q4FvZa5vMx1iDWointiKs7pf7Md0t6CY75lvRIJqwCX8HUp/2YDkmuWdaZEOLPrH4UwHBuPJQij03KlhtNT2QPQ36S+qvs8T7ylnU9yB8NuYR2Vy+hR4huAMzoONRG48LZE/jpTs2FXANNhioMRVga49G02GWlsBoVEHG+X/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:02:40.8663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f21f75b-e322-44b1-dfdb-08df1e219007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

The EEPROM table is tagged as over threshold while the new bad page
records are written out, so the table status queried while the records
are only queued still reports the table as writable. The device is
therefore never flagged as having reached the threshold and neither the
in-band CPER record nor the out-of-band RMA reason is emitted.

Re-evaluate the table status once the records have been appended, so the
report is driven by the state that was just persisted.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_umc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index b3f30da19a78..c2663f84a883 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -848,6 +848,13 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 		RAS_DEV_INFO(ras_core->dev, "Saved %d pages to EEPROM table.\n",
 			ras_umc_count_valid_pages(ras_core,
 				&data->bps[eeprom_record_num], save_count));
+
+		/* The table is only tagged as over threshold while the new
+		 * records are written out, so the status has to be
+		 * re-evaluated here.
+		 */
+		ras_eeprom_mgr_check_and_report_status(ras_core, true);
+		ras_umc_report_badpage_info(ras_core);
 	}
 
 exit:
-- 
2.34.1

