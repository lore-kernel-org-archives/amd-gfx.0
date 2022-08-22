Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9693DC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 13:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEF28E9D8;
	Mon, 22 Aug 2022 13:57:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE9A8F068
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+7i/0PmvqMX1S3RY/e+A112H5W4t/G5ronrzUCOdJKtTQBZXOs5mPSfOdghSXYuGRazmHk2nxHAUEBhIq1WaxlvpaGgNQC/TIIiiijHmCqhnUxiWYdhCIdKnU9LdUgSmP1ZTBQjhBb3LEmTs5oIOL/SMMPedjRkI+LBMPK77A11HuwmVNOOn78u6hN0nyfl442UoaWsaMnf/Uo7YxcKfERhgMjyW3NgS/7P1SR/VYVmEJi87p4X0NW4oVJVE5sXSnZ644ZunF3fl9UaEEIoraSu8DMVwZe7k4eLXziv8oruD0BWFRmDFZZFQa8+NExP4Drpk9Zyxm23kCUv48T34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnKoqs0h+2+dI5Pw8vASI3nvkgVPOE7zbZuQMTXGtVg=;
 b=V+CCwtoNZ69188sEbm8ce16vA7asampeKzWNjZs+i9G/I5XSpOyd8yJDNOBjDSz8z/qBDlvc0zwde/yplTwn4Ajw5TfuuwtnGCMxMoX1ivmqQEqxuuJnQXpOIsrLTSKx/uKHaxknu1DjHFS8ZtDTBWlmPW8alOKVYVmeRm9ioacvjYKbhkG+JOPMyHkLvmGGl5kCHV/LhH1jMG/8pNR+fWIkApJ4LE9BocMC9tg8lUU8oiwpkL1eZDTeLx4AOyOOXIfv8F70yAqwlywYA9wi+UawNJvtoOsvbZnd41jKgZixmNteqnX7+OHIFnz2MNf431C3SXU5vxXH/KD0og2C2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnKoqs0h+2+dI5Pw8vASI3nvkgVPOE7zbZuQMTXGtVg=;
 b=ejOD64e36LpbYjrd99FjXA4/JEEQsjUbMdCX5A3jR0qOeKm3bJvHXfqtXu5M8ojozGH4VIP4xO9Sm0SFF7DmkGbGRAeLGrl9W7NbhDqd43MBFitCHvi0OJ2FlFEuPsHHZFX1WFvKJVWdiokTNaQ/1dUH4PWfVFKyfrOtKVA8F38=
Received: from BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36)
 by DM5PR12MB1147.namprd12.prod.outlook.com (2603:10b6:3:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 13:57:13 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::c0) by BN8PR12CA0023.outlook.office365.com
 (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 22 Aug 2022 13:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:57:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:57:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:57:12 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:57:09
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: 3.2.199
Date: Mon, 22 Aug 2022 17:57:39 +0800
Message-ID: <20220822095752.3750614-2-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86bae82b-d48c-4b60-c073-08da84463754
X-MS-TrafficTypeDiagnostic: DM5PR12MB1147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9q3YPPql7yuACUZKBb6MCUiv6n15dk9U2gDP3F7s1jvNWsedoTYnCx/VdQqzhSqUL39R6wCXjDI6itOA6cogqMQBp6GahYdTJHkqxpWOwB2fAxdDlpTRlKhvZwKIrLkX1K5N8MG211p06GJduv9YzjuShn9VMoymEpiDeUbCldyrFxSZWVl/vucunrJBKZDG7TRT7qnu/oEA88jpcnvgDmey9YSMB0fxDYdYaPrFlSUIYlxk8o495qYV32F6xX4hg8/yUnXwXwdb3/CcEomnTWN/f3lOp9vkrk+09/qix1Q+iyu9hevPtBPJQ37MJ/wOHGcUv0AXAqryCjkxeove+9rWYvNnS/yDO6YnCa09HuBzA7Hhx1Hfms5qKGE0mNte0Vl2XQp8IHt39tJHK0A4Cd7Sl9hNp4t8uoGEg9xWVvzRvtfGXumi+QSVLW+n0x+ciQo3dXtWz5b3M7khInkpS8+2CZLjYkN8DwL+LDjyQcvb4B7YsXkJTWOLphxGbcvm8oaVN4uc2rHGPfkVqNMJkI8UmlahiYbIuZQG/UfSW9wOZRrTXDZFSKkv8NidCZ2PKKPCv7GiF6OCI6cgW0boBD2w7bmYW02jetOGXD51HWYoiyeKerqUuUFfxdNu+3krf17Y1PgAPAg97HM+ZfMcq0HKTCfQBM4gOaXA8gctMJ3mcoC2Y4/Ub9dLtgTzFAqrJfEUUfW15hbDy/QdaZ2qO6T4hfguiY80kWArblefrSKf87qtGoUCzb4ItLNldoS+IYT+PuRf1Arjct77L/Gkn3aXpDilbxdvMLw8MGqiD2yFHueTOJxz6M1Z5b0yNH5FK/jFMpATqQK3YR/qC3evMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(36840700001)(46966006)(478600001)(356005)(81166007)(6666004)(7696005)(36756003)(86362001)(26005)(83380400001)(2616005)(41300700001)(186003)(336012)(1076003)(47076005)(426003)(82310400005)(70206006)(316002)(40460700003)(40480700001)(70586007)(6916009)(4326008)(54906003)(8676002)(82740400003)(36860700001)(8936002)(5660300002)(2906002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:57:13.6599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bae82b-d48c-4b60-c073-08da84463754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This verion brings along following fixes:
-Add scaling factor for SubVP
-Modify stop_dbg_mode return value
-Add gfx_off members and document
-Add GFXOFF function for vangogh
-Add GFXOFF stats to debug
-Fix codestyle problems
-Fix overflow on MIN_I64
-Fix Unneeded semicolon
-Fix comment typo
-Remove useless condition in amdgpu_job_stop_all_jobs_on_sched()
-Add decoder_iv_ts helper for ih_v6
-Add chip version to DCN32
-Avoid doing vm_init multiple time
-Modify size calculation in MALL
-Fix DSC for phantom pipes
-Update clock table policy for DCN314
-Modify header inclusion pattern
-Fix plug/unplug external monitor will playback MPO video
-Add debug parameter to retain default clock table
-Increase tlb flush timeout for sriov
-Fix compare intergers of different widths
-Add reserved dc_log_type
-Fix pixel clock programming

Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fac17d64e5e9..2f2d0095d328 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.198"
+#define DC_VER "3.2.199"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

