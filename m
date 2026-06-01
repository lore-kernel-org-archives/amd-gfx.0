Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE19CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0441133C8;
	Mon,  1 Jun 2026 14:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gp6uYTqA";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3E21133C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oateMTZXCq4kEX07NtpASe6sNhRUMx6OR3/IdmZVUP8qpLIFQlq1Dw6etbiq6a3W1Be5lr56Z9SOLHpxSB2deJe1dJnJYmbv67UCXnVtSTOVnERi78316PtwGiLDqz/4nEUyPUl8csuiDR2KNd9c+98Z9QPthwcJEPhGyRak3fvwPZwbhsIn7waBI76txR04WxICM+72bS6mLFlFcll939CyWj0J58tW89EfGFfOP4xlPyi5x+weiTZm342aIOoDu/2rKxqcHchSHN0yVVcBhyrYmWkXsBK0AQI7nc89mL1aYtEpiOrCF6lVEcn/VK23d2LhieK3/d2tknRxXQIZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd7Riq5VcraJ4rkBHSnCCqi9DyIK3aSZUOil/X5lfqQ=;
 b=W8cvthYJ8n6U1JRSV7pw2gz5nu+UCUJGYakzw5QaTDgPH5TKHQ2RQ3PNso12XGFMGK/jkt3igbQGDPPmDhYztyol3UZhGNrjkWbzGOglXszFUGkSlJ/Hp7LFvrF+XL/n24DC3FV1gOi1mLUM5eoRxSMvAAEQ4Osax1+WL7dgsjNwSDJ21linFgLC72oToV9pFXOT5wEYQvA/6n9ri+uAJXjSCrgMaJEJAs+ldo6Yw1asc+x94CqNkhBAqhj84IACf1kS+HcvXFDncAArp71YHILWXhrLHuXO+iBtAHNBnUxQEaE6gZtFSV2d5pANcQETL2HsXswo79XmpjYcrvZXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd7Riq5VcraJ4rkBHSnCCqi9DyIK3aSZUOil/X5lfqQ=;
 b=Gp6uYTqAvK08ZMQHV2kktW/LbT++q0qkYHEfesJq9JlAW6m9bwU3EClBUbhWtfN0n4/0AKX6uPkN1tP3TAxFk/LJFOimm5SekG9sCKY2PoJFO6TtuAE8DhndNmmdQ0+H0EVkbYxxk+1GnIpKGtjoo+GQPL+aIeSWapdjXi2EQSU=
Received: from SA9PR13CA0052.namprd13.prod.outlook.com (2603:10b6:806:22::27)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 14:14:13 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::31) by SA9PR13CA0052.outlook.office365.com
 (2603:10b6:806:22::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Mon, 1
 Jun 2026 14:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 14:14:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 1 Jun 2026 09:14:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Nicholas Kazlauskas
 <Nicholas.Kazlauskas@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] drm/amd/display: Add missing kdoc for ALLM parameters
Date: Mon, 1 Jun 2026 19:42:15 +0530
Message-ID: <20260601141215.2647457-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc33539-5c31-47b1-c590-08debfe80e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|3023799007|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: WIH1SLaIvcodSRUSBiSV6+KkVlkVReMWZduej8hm/Z2aBpIIIrW62YyDtCmi/rUTCCerr4q/LzoMOfjrZu6/quufHMwFKrK9gUrLpSOvfYCvtSiGopEz/NUhVkxmRpfiDRW9xBVyYVwz/kjwU81E3VCtXAeZT2suMsB2mqgkjMcIDdhEM7jLVq6D+MR9j9O5qIfTB0QxmW0gBRevT9FCphi7IJ7tWJjYGh8c6kNTpmIP5AT5KWUmmgbOQt5nHk0BZ0DunY4iP+snRlPgiLZ4stVaQgNAUIHF8dusT8KVtdRsfQKEnXSmzkwwA9fywLayusT6Ar2cHnrglsEKXBgSt3Ck7KV/gDHNHl8NBdbBYlR+g5lQGzzGj89kInvxJ1lN3yx8nhsmRJjgo1GMxdKcwxIZTYY7EqlAUB8WTFA4ntCgzqQBf8Le+WXYCYpHPmDAk/Roi7oPww0xWmsCQht8uRfd9gkue5WNTtcoEzGOocVtstGACuhFZ1WKRWu22YgjdD/SvU3k3k/tKNOBD7YPkmh6ET8NGZsnc7i38HDrH91mDs6h2yTep3rwtkxjhXignaJiLKU+UW8Ddwh6DUhbQSbFHfJyd/n/yioXqoYj5A59Jq4rW+LVi6eV19fAEnS0GHDlF9Sa+HYLPSA66ejQ8M4DNvtk9effBh3waRvVk8JZqSpd00MR4jQzNjTIB7ttk3cbso16Btx20UgvWzjfXpDjrHYmp8txoAC9Byh52zA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(3023799007)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SNzZCvPcrsUEPy+1i02o0KY9Aks5b6s56D7lCJVxsXrnhCzvE+5HGID3UrYGuyYSZx9lt05Mff9EZc2LxRhXqQUtX6FfTEB85Mf6B6YhHP8TVe/hRrNG0ak2nqRhOHG5Gw8zsXOt6W6C8fTQbMLOYrxPmXI6DEVTSH+m7cxPqCZ+zm9QCdsrea7s6UWLdJ5MI6zMPgMayVdqOUkJgp/maXa85Tv4f8lIm8WkQUFEnSdeMv16HTjEb0/0rbR3myK83ErQOkU/shFpXb7pDa4fp0zXszsLhjDnmwseTx9JzDiChcvF53dvfaXiTnacWfyxi6KtqbgzLg+SRJF8BQcLy+pDhhKqH77pfzGsitDn4boPhVmyP72wRurrCUGBBMy19jpQciJGmFOFKQEVnlJKQ+DqM9CDV02+s/qDeNAQFa+A/92np2F7oZClgYLeSt1V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:14:13.1200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc33539-5c31-47b1-c590-08debfe80e9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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

Add descriptions for the missing parameters for ALLMEnabled and
ALLMValue  to keep the function documentation synchronized with the
function prototype mod_build_hf_vsif_infopacket().

Fixes the below with gcc W=1:
../display/modules/info_packet/info_packet.c:507 function parameter 'ALLMEnabled' not described in 'mod_build_hf_vsif_infopacket'
../display/modules/info_packet/info_packet.c:507 function parameter 'ALLMValue' not described in 'mod_build_hf_vsif_infopacket'

Fixes: 3c2381b92cba ("drm/amd/display: add support for VSIP info packet")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index fa05547c615a..f5ac4bf32a78 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -502,6 +502,8 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
  *
  *  @stream:      contains data we may need to construct VSIF (i.e. timing_3d_format, etc.)
  *  @info_packet: output structure where to store VSIF
+ *  @ALLMEnabled: indicates whether ALLM HF-VSIF should be generated
+ *  @ALLMValue:   ALLM bit value to advertise in HF-VSIF
  */
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue)
-- 
2.34.1

