Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40CEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 11:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293C610E6B2;
	Wed, 23 Mar 2022 11:49:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7110010E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 11:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkgaDC6bQN4KwWQGCsVS9kP34bmErlK+BceaHiu2A9KUhQgJ+PWTjAktcvu1iBJG0J+anjnarASu7oxac34wAJNxRqHKxv/4ot8liQOu/yFVR0khnxzXo3gaNeAEDja/uiBr4UaXj/T65eR0WtRySvac/keJ40d7j6wszFLwf0pwUE6FKLoCpyB4tm7SdX6OWa26W0lLsFZE7j+2lfbfyXU35sSkHI85H83n57pmkg8M0y1Qm+dYUnP0vVdvEgmBq3Qx2Bla0yTyoZ3Y3FN4oLCZuqKWNrWJLQyO6VgP0J57wFgxj7ODhtWRxf03d0Z5YPmoNXMMaavhB6l9qYuxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd3PVBbyPQfdtqZGhYYzM6M4mhza+a/u7B2/YBcRY+Y=;
 b=jdIserKavsoNWVuBKHJR6dUD5yX/TBq9r0lIyXE4PeKJ+qnDgj3H533zAILMBcIgnVND5Rz9VqqGfMYPdc/WSfDGrDrk7crv8h9vElgWnep/eiG2D6SIbYtj1imJf3cFIzg8cr8KjozHpNqGFvcWINC9tbh0Klk0jNTygB2K+jU9HwWGFJ7gmR7PKBmt8bugtw0XMmJj9rzA8ytq76zQw4C5BjwM8oxwdrt9r5uXxDTjmM3dO6iL7jkN7shxMwcuLUX+H9Zt62oQTBEHqeZrye3V87une/ZMuSIC8BqLMXsBRZRbrZbZvBifcN43C/CZBkGWBL5XZ+LrLMDaDTPuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd3PVBbyPQfdtqZGhYYzM6M4mhza+a/u7B2/YBcRY+Y=;
 b=qiq9Xu35ZKd05WAWG2PTLuMn/nBtp0YIwAhCkqPAEdqXPl2zsxlPDoc5TER0Ra/AQqt2fzxuqMVkODPYG8yspnxCGDscF/oCM133+7rshI4W+n+7IDgvD6LcZUkUtziMvjs03mDkqrwu636Wvtd93O/E73qe6lSJXSrn4QOF7Mc=
Received: from DS7PR03CA0138.namprd03.prod.outlook.com (2603:10b6:5:3b4::23)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 11:49:20 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ef) by DS7PR03CA0138.outlook.office365.com
 (2603:10b6:5:3b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 11:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 11:49:20 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 06:49:12 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] umr: Replace and reuse asic.ipblock.reg completion
Date: Wed, 23 Mar 2022 07:48:40 -0400
Message-ID: <20220323114842.78516-5-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
In-Reply-To: <20220323114842.78516-1-luben.tuikov@amd.com>
References: <20220323114842.78516-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ef0cf21-dd43-40be-a838-08da0cc32ae7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4275:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4275BA70AE786AF35245C05999189@BY5PR12MB4275.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGXQ5dzB+DbqSNzvMpNzYhp7ydhBvjVZzkvXf+o3ecS56/GXTK0xHlO67LPtfMpioMON3s0oSXLvD0cC2RCaqQpNktccjjIdCFE2o/EKQRC/3QztgxTJTPwHtyGBDZ9N0L/5GXYrcgtzrcwWKF+IGnWifR3lyFfRQU9PABwMUYAPkprsGe98Mlr6mMbxojjpnlDoKgHgTNm5qFPZ5x2qmbf3pcDoz2oGlXyRh2t6OUZOyMRzNGvFA9ndheaEOGfbSP2aWb7gmd2U+6JzZg6av062nJ6ctdUV66KNubtBryzYiYSy7k7mVJkRHF2F4ECUdynCJQqeXxRu0Hgd0j9VmoxUxRCg7bhYqgzzkqz/WshD/8PlttzTQqgSgwDl5jHCZBza3F4/7KA7fsjUG+J2oneOurvrRHR6e8HFh47hdrZvX2QeZ/OSw/RaXjigeykdEHJgPXiz2sUroBNMN6tg8WmUIlqG5S1zY3EEubIQHykdqJq0huX/FpSCoz4PzTPpZqku3q9wU28X9g9lJlgsO6WU36b4JGeOOoK7A3pGqa4omagYXsjrYkn3hbJR/FUWmO6FhpSWzOu4uGlcOImY6Za1/UpfhQXCCZW4ACPlVCyOFFqPir97K3F7qe/bBx2VeEwo4aknCmftHTn7sYVH7dlU4t8xC537MLIxwGzWSTcN0zLL8fzludziJV4MFfDqpAGuMoDP7OZVbeeDjvoSGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(47076005)(36756003)(426003)(44832011)(40460700003)(2616005)(316002)(86362001)(508600001)(6666004)(16526019)(26005)(2906002)(36860700001)(186003)(83380400001)(82310400004)(1076003)(70206006)(70586007)(8676002)(4326008)(54906003)(6916009)(8936002)(81166007)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 11:49:20.3233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef0cf21-dd43-40be-a838-08da0cc32ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom StDenis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace and reuse asic.ipblock.reg completion.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/umr-completion.bash | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index 7029264ca5f725..ab1637a090e5d6 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -55,27 +55,6 @@ _umr_comp_blocks()
     fi
 }
 
-_umr_comp_regs()
-{
-    _umr_setup_ips
-
-    if [[ "$cur" =~ ^[^.]*'.'[^.]*'.'[^.]*$ ]]; then
-        cur_asic="${cur%%.*}"
-        substr="${cur#*.}"
-        cur_ip="${substr%.*}"
-        if [[ "${ip_names[@]}" =~ "$cur_ip" ]] && [[ $cur_asic = $asicname || $cur_asic = "*" ]]; then
-            reg_names=( $(sudo $(which umr) $select_gpu -lr $asicname.$cur_ip | grep -o "$asicname\.$cur_ip\.\w\+") )
-            COMPREPLY=( $(compgen -W "${reg_names[*]/$asicname/$cur_asic}" -- "$cur") )
-        fi
-    elif [ -n "$cur" ]; then
-        local array=( "${ips[@]}" "${ip_names[@]/#/*.}" )
-        COMPREPLY=( $(compgen -W "${array[*]/%/.}" -- "$cur") )
-        compopt -o nospace
-    else
-        COMPREPLY=( $(compgen -W "${ips[*]/%/.}" -- "$cur") )
-    fi
-}
-
 _umr_comp_option_flags()
 {
     local FLAGS=(bits bitsfull empty_log follow no_follow_ib use_pci use_colour read_smc quiet no_kernel verbose halt_waves disasm_early_term no_disasm disasm_anyways wave64 full_shader no_fold_vm_decode no_scan_waves)
@@ -396,13 +375,10 @@ _umr_completion()
         -lr|--list-regs|-s|--scan)
             _umr_comp_blocks
             ;;
-        -r|--read|-w|--write)
-            _umr_comp_regs
-            ;;
 	--lookup|-lu)
 	    _umr_comp_lookup
 	    ;;
-	--writebit|-wb)
+	-r|--read|-w|--write|--writebit|-wb)
 	    _umr_comp_asic_ipblock_registers
 	    ;;
 	--waves|-wa)
-- 
2.35.1.607.gf01e51a7cf

