Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC09C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 11:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9EC710E6B0;
	Wed, 23 Mar 2022 11:49:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2521B10E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 11:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IozeZyN2ZJ+nI/+WdXc54DRGvGS6qBS0JyStdKlnQZ9/PLxM8TkhViwVvCdUZLaXtiCCPmVNr7HA6fL3ikcOQkAMo53MZAsfFRrjR/tOE4EsbT/0tyD69Ku2X1QT9Cc4Bu+qWIiRzqvx3WAxKDkKhc3GhlxWL3woNNCUyx/W4E6orR6Ue1Y/yYTcXW/d0mM6wGDIkVLkkYp8EyXztSQ2JXIq/jKoU/GGKSdqbPTh1stYvOf6+/q8a1BhB7J3/iEaBK1GjeoSJ3va8LpfI/VSC12qg1nfGTsBk8xAYQbJwjVt+PfLJHjyBu1jBhBOwh2MXfWTkcGXikX4UpH88LgZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deuOtvus7K2k+nNpYnONVawhpMP1L0Mk0LRz9mq9zH0=;
 b=SMGYkjQApS93JYeXIuin1niyNCzZ6uDT5AfbSnJ7iLsmhWagcOBgrEQHkM/tDcB5fjVSdDy5a5HT5+jdU0FEdWj/+kPZ88Wp6cIuQf9aPJ5EzVVOd+3BCyfJSb/slnKA0ab5sXDt/zO1HMTRWtARfw/O3gdlHOKeN//rDqaKZt3S1Nff8snNWls5Gh1sDjAfsVGHnFtdz8id7dQwTrtHYpsoZy0E+OFH3XAogmpXKm0nxClIhY3LU7dxIw6yFFEItA9tcpk/dUv78rpJhdvC/L77bhhi3SPy4EgqhQa8eORYvE6X/O976YVGklZRXjCV0m98Y0uILgpPGWfzS1fKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deuOtvus7K2k+nNpYnONVawhpMP1L0Mk0LRz9mq9zH0=;
 b=WOf+8u0re9XPk/t+I6D7ph/Jr/jpX1h/Mt4JL3SvR7IQB/3/SW1CB4LF9U/j/N7lnubaZMR5IRhkTkhoDANqs1MC1Ck1Ol773QE8mTbd+F7Hq7SAT3j/fM4OzFy5HbEkOHXvDoy54dTg8r9T75AzBX/tKedjybeujyGQmQ5Oe90=
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 11:49:19 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::94) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Wed, 23 Mar 2022 11:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 11:49:18 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 06:49:11 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] umr: Complete umr completion
Date: Wed, 23 Mar 2022 07:48:39 -0400
Message-ID: <20220323114842.78516-4-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 100cd3ef-438e-4dfd-caa3-08da0cc329e3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45428952C8694EE09313E33999189@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ihtu52LO2fbtCcbGod7cbWSY4n7suBI0ZQcA4A820M0lKg1K2w9lsHzjEDaFd4ZnCb4j0M3lrHJ/mH1rMqZnw2y1yr/2IbR4+LLnh3rUAowd0Ch+lpyBZinr06RevkRYLONGzIDZ8uFHJgfDqf3ZEzkZAHAl+/FRSBW/IyfgqFsb1FlerucSThpLouuLZpvzRFc70bPpCox4/Ukm8cbBXaD4NzYtRqaEVVexpexzFhdG4cZ6MrfbBaa2cIyzKj8TY3iH2UqgWCqtn29y7nb4ytY0UYDbspdoz96S9Q1SrtmtiIQ93VASwfbIoAmvqegcke4PiOxFK7r1fdSrKQfs9+1lQPy6zIyHZwOvmzO9cw6iMXI4ub9b/mlnLQ5XGmvDTdF4A4crSfl6uiDR4II0QoFnXuzXmbipZXtMciwirWCWjK2pX+0hgkDvXol0V7tjhCngVVrPlZ7/9rQyXGPO5Y+Q00uwGMUARq7ztSWKKzMW0eeHvRJ05nnPaeRV4TsH38FjbAJlborY40Yh/aEN2kqKLMxHYgDTFfHR+b+d3KRdKvGs6D20rDQaj+dEBjbD+2aQuvySUMjTF+T4gLBz6SPzjg8PnpcBMl1H9VgWSiGVP8iHK+3UGbSqzb+Dil40HF2RsMGPcy8HsVVitAzfR9hlsclHl732yOVFKoEMmzdyRxshiIhTKpifdrH/CZgeJNOfUhqVwvinP9lK5SMyYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(44832011)(30864003)(83380400001)(2906002)(70586007)(16526019)(70206006)(508600001)(8936002)(47076005)(5660300002)(336012)(86362001)(2616005)(426003)(26005)(186003)(4326008)(36756003)(316002)(66574015)(54906003)(6916009)(82310400004)(40460700003)(6666004)(81166007)(356005)(8676002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 11:49:18.6203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100cd3ef-438e-4dfd-caa3-08da0cc329e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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

Complete all commands. Complete all commands' arguments which can be
completed. Data is gathered from files in the UMR_DATABASE_PATH, from the
PCI system and from the /sys filesystem in order to complete the arguments
of commands which require non-open-value argument, i.e. an argument from a
closed set.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/umr-completion.bash | 374 ++++++++++++++++++++++++++++++++++--
 1 file changed, 362 insertions(+), 12 deletions(-)

diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index 79972949b9861e..7029264ca5f725 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -1,6 +1,22 @@
 # bash completion for umr
+# Copyright (C) Advanced Micro Devices 2022
+#
+# You should set UMR_DATABASE_PATH before sourcing this file in your
+# .bashrc. To source it, do "source <location of this file>"--to see a
+# usual location of this file, see the FILES section in umr(1).
+#
+# I recommend you "set show-all-if-ambiguous On" in your .inputrc, for
+# matches to be listed immediately (on a first TAB key press) as
+# opposed to ring the bell the first time and seeing matches on the
+# second TAB key press. To load the keymap, do "bind -f ~/.inputrc" in
+# your .bashrc, assuming your .inputrc is in your home directory.
 
-_setup()
+if [[ ! -d $UMR_DATABASE_PATH ]]; then
+    echo -n "UMR_DATABASE_PATH must be set for correct operation of umr bash completion."
+    echo " See the FILES section in umr(1)."
+fi
+
+_umr_setup_ips()
 {
     select_gpu=""
     if [ $COMP_CWORD -ge 4 ]; then
@@ -25,9 +41,9 @@ _setup()
     done
 }
 
-_comp_blocks()
+_umr_comp_blocks()
 {
-    _setup
+    _umr_setup_ips
 
     if [ -z "$cur" ]; then
         COMPREPLY=( $(compgen -W "${ips[*]}" -- "$cur") )
@@ -39,9 +55,9 @@ _comp_blocks()
     fi
 }
 
-_comp_regs()
+_umr_comp_regs()
 {
-    _setup
+    _umr_setup_ips
 
     if [[ "$cur" =~ ^[^.]*'.'[^.]*'.'[^.]*$ ]]; then
         cur_asic="${cur%%.*}"
@@ -60,24 +76,358 @@ _comp_regs()
     fi
 }
 
+_umr_comp_option_flags()
+{
+    local FLAGS=(bits bitsfull empty_log follow no_follow_ib use_pci use_colour read_smc quiet no_kernel verbose halt_waves disasm_early_term no_disasm disasm_anyways wave64 full_shader no_fold_vm_decode no_scan_waves)
+    local F G CURR_OPTIONS
+    local ACTIVE_OPTIONS=()
+    local ACTIVE_FLAGS=()
+
+    CURR_OPTIONS="`echo ${COMP_WORDS[*]} | sed -E -e 's/^.*-O[[:space:]]+(.*)$/\1/g'`"
+    CURR_OPTIONS="`echo $CURR_OPTIONS | sed -E -e 's/,/ /g'`"
+
+    # Get rid of user-input partial option string
+    for F in $CURR_OPTIONS ; do
+	if [[ $F == $cur ]] ; then
+	   continue;
+	fi
+	ACTIVE_OPTIONS+=("$F")
+    done
+
+    # Offer only options which are not already part of --option/-O
+    for F in ${FLAGS[*]} ; do
+	for G in ${ACTIVE_OPTIONS[*]} ; do
+	    if [[ $F == $G ]]; then
+		continue 2;
+	    fi
+	done
+	ACTIVE_FLAGS+=($F)
+    done
+
+    # If the user presses TAB again after full completion, as opposed
+    # to say SPACE BAR, then give them comma and the rest of the
+    # flags.
+    COMPREPLY=( $(compgen -W "${ACTIVE_FLAGS[*]}" -- "$cur") )
+    if [[ $cur == ${COMPREPLY[0]} ]] && (( ${#COMPREPLY[*]} == 1 )) && (( ${#ACTIVE_FLAGS[*]} > 1 )) ; then
+	COMPREPLY=( $(compgen -S ',' -W "${ACTIVE_FLAGS[*]}" -- "$cur") )
+    fi
+    # Complete with a space after all options entered.
+    if [[ $cur != ${COMPREPLY[0]} ]] || (( ${#COMPREPLY[*]} != 1 )) || (( ${#ACTIVE_FLAGS[*]} > 1 )) ; then
+	compopt -o nospace
+    fi
+}
+
+_umr_comp_instance()
+{
+    local INSTANCE=(`sudo \ls -1 /sys/kernel/debug/dri/`)
+
+    COMPREPLY=( $(compgen -W "${INSTANCE[*]}" -- "$cur") )
+}
+
+_umr_comp_pci()
+{
+    local PCI_LIST=(`lspci -D | grep VGA | cut -f 1 -d \   | tr '\n' ' '`)
+
+    COMPREPLY=( $(compgen -W "${PCI_LIST[*]}" -- "$cur") )
+}
+
+_umr_comp_prof()
+{
+    local PROFS=( "pixel=" "vertex=" "compute=" )
+
+    COMPREPLY=( $(compgen -W "${PROFS[*]}" -- "$cur") )
+    compopt -o nospace
+}
+
+_umr_comp_ring()
+{
+    local INSTANCE=`echo "$COMP_LINE" | sed -E -e 's/^.*(--instance|-i)[[:space:]]+([0-9]+).*$/\2/g'`
+
+    if [[ ! $INSTANCE =~ ^[0-9]+$ ]]; then
+	# The default instance in umr is 0. See umr(1) under "--instance".
+	INSTANCE=0
+    fi
+
+    local RINGS=( `sudo $(which find) /sys/kernel/debug/dri/$INSTANCE -name amdgpu_ring_* | sed -E -e "s%/sys/kernel/debug/dri/$INSTANCE/amdgpu_ring_%%g"` )
+
+    COMPREPLY=( $(compgen -W "${RINGS[*]}" -- "$cur") )
+}
+
+_umr_comp_clock_scan()
+{
+    local CLOCKS=( `sudo $(which umr) --clock-scan | grep ".*:$" | sed -E -e 's/[: ]//g'` )
+
+    COMPREPLY=( $(compgen -W "${CLOCKS[*]}" -- "$cur") )
+}
+
+_umr_comp_force()
+{
+    local ASIC_NAMES=(`awk '{ print $2; }' $UMR_DATABASE_PATH/pci.did | sed -E -e 's/.asic//g' | sort | uniq`)
+    if [[ $cur =~ ^\..* ]] ; then
+	COMPREPLY=( $(compgen -P '.' -W "${ASIC_NAMES[*]}" -- "${cur#.}") )
+    else
+	COMPREPLY=( $(compgen -W "${ASIC_NAMES[*]}" -- "$cur") )
+    fi
+}
+
+_umr_comp_gpu()
+{
+    local INSTANCE=( `sudo \ls -1 /sys/kernel/debug/dri/` )
+    local PCI_BUS_DIR_NAMES=()
+    local PCI_BUS_IDS=()
+    local -A PCI_BUS_ASIC_NAME
+    local SUGGEST=()
+    local ASIC_NAMES=()
+    local TEMP_ASIC_NAMES=()
+    local INST_ASIC_NAME=()
+    local GPU_NAME
+    local F
+
+    # We need to do it like this, so that this works
+    # when run from non-root shell.
+    for F in ${INSTANCE[*]} ; do
+	PCI_BUS_DIR_NAMES+=("/sys/kernel/debug/dri/$F/name")
+    done
+    PCI_BUS_IDS=( `sudo cat ${PCI_BUS_DIR_NAMES[*]} | sed -E -e 's/^.* (dev=(.*)) .*$/\2/g' | sort | uniq` )
+
+    for F in ${INSTANCE[*]} ; do
+	local PCI_ID=`sudo cat  "/sys/kernel/debug/dri/$F/name" | sed -E -e 's/^.* (dev=(.*)) .*$/\2/g'`
+	local DEV_ID=`cat /sys/class/pci_bus/${PCI_ID%:??.?}/device/$PCI_ID/device`
+	local DEV_ID_NAME=`grep -i $DEV_ID ${UMR_DATABASE_PATH}/pci.did | awk '{ print $2; }' | sed -E -e 's/.asic//g'`
+	TEMP_ASIC_NAMES+=($DEV_ID_NAME)
+	PCI_BUS_ASIC_NAME["$PCI_ID"]="$DEV_ID_NAME"
+	INST_ASIC_NAME["$F"]="$DEV_ID_NAME"
+    done
+    # Remove duplicates
+    ASIC_NAMES=( `(for F in ${TEMP_ASIC_NAMES[*]} ; do echo $F; done) | sort | uniq` )
+
+    if [[ ! $cur =~ .*@.* ]] && [[ ! $cur =~ .*=.* ]]; then
+	COMPREPLY=( $(compgen -W "${ASIC_NAMES[*]}" -- "$cur") )
+	if [[ ${#COMPREPLY[*]} == 1 ]]; then
+	    GPU_NAME=${COMPREPLY[0]}
+	    COMPREPLY=( $(compgen -W "${GPU_NAME}@ ${GPU_NAME}=" -- "$cur") )
+	fi
+	compopt -o nospace
+	return
+    fi
+
+    if [[ $cur =~ .*@.* ]]; then
+	# Find all instances of the selected ASIC name and offer them
+	local INST_OFFER=()
+	GPU_NAME="${cur%%@*}"
+	for F in ${INSTANCE[*]} ; do
+	    if [[ $GPU_NAME == ${INST_ASIC_NAME["$F"]} ]] ; then
+		INST_OFFER+=("$F")
+	    fi
+	done
+	SUGGEST=( $(compgen -P "${GPU_NAME}@" -W "${INST_OFFER[*]}") )
+    elif [[ $cur =~ .*=.* ]]; then
+	# Find all PCI bus IDs of the selected ASIC name and offer them
+	local PCI_ID_OFFER=()
+	GPU_NAME="${cur%%=*}"
+	for F in ${PCI_BUS_IDS[*]} ; do
+	    if [[ $GPU_NAME == ${PCI_BUS_ASIC_NAME["$F"]} ]] ; then
+		PCI_ID_OFFER+=("$F")
+	    fi
+	done
+	SUGGEST=( $(compgen -P "${GPU_NAME}=" -W "${PCI_ID_OFFER[*]}") )
+    fi
+
+    COMPREPLY=( $(compgen -W "${SUGGEST[*]}" -- $cur) )
+}
+
+# Sets GPU_NAME with the name of the GPU given on the command line by
+# --force, --gpu or --instance, or default, and sets up IP_BLOCKS an
+# array of the names of the IP blocks of GPU_NAME.
+#
+_umr_setup_gpu_ipblocks()
+{
+    # The regex we use to match an ASIC name is "[[:alnum:]_]+".
+    local FORCE=`echo "$COMP_LINE" | sed -E -e 's/^.*(--force|-f)[[:space:]]+([[:alnum:]_]+).*$/\2/g'`
+    local GPU=`echo "$COMP_LINE" | sed -E -e  's/^.*(--gpu|-g)[[:space:]]+([[:alnum:]_]+)(@|=)*.*$/\2/g'`
+    local INSTANCE=`echo "$COMP_LINE" | sed -E -e 's/^.*(--instance|-i)[[:space:]]+([0-9]+).*$/\2/g'`
+
+    # GPU_NAME is set only when given by a parameter on the command line.
+    # GPU_NAME2 is always set, even when not specified on the command line.
+    IP_BLOCKS=
+    GPU_NAME=
+    GPU_NAME2=
+    DEFAULT_GPU_NAME=
+
+    if [[ $COMP_LINE =~ (--force|-f) ]]; then
+	GPU_NAME="$FORCE"
+	IP_BLOCKS=( `sudo umr --force $GPU_NAME --list-blocks | sed -E -e "s/^[[:space:]]*${GPU_NAME}\.(.*)[[:space:]]+\(.*$/\1/g"` )
+	GPU_NAME2="$GPU_NAME"
+    elif [[ $COMP_LINE =~ (--gpu|-g) ]]; then
+	GPU_NAME="$GPU"
+	IP_BLOCKS=( `sudo umr --force $GPU_NAME --list-blocks | sed -E -e "s/^[[:space:]]*${GPU_NAME}\.(.*)[[:space:]]+\(.*$/\1/g"` )
+	GPU_NAME2="$GPU_NAME"
+    elif [[ $COMP_LINE =~ (--instance|-i) ]]; then
+	GPU_NAME=`sudo umr --instance $INSTANCE --list-blocks | head -1 | cut -f 1 -d . | sed -E -e 's/[[:space:]]+//g'`
+	IP_BLOCKS=( `sudo umr --instance $INSTANCE --list-blocks | sed -E -e "s/^[[:space:]]*${GPU_NAME}\.(.*) \(.*$/\1/g"` )
+	GPU_NAME2="$GPU_NAME"
+    else
+	GPU_NAME2=`sudo umr --list-blocks | head -1 | cut -f 1 -d . | sed -E -e 's/[[:space:]]+//g'`
+	IP_BLOCKS=( `sudo umr --list-blocks | sed -E -e "s/^[[:space:]]*.*\.(.*) \(.*$/\1/g"` )
+    fi
+
+    DEFAULT_GPU_NAME=`sudo umr --list-blocks | head -1 | cut -f 1 -d . | sed -E -e 's/[[:space:]]+//g'`
+}
+
+_umr_comp_lookup()
+{
+    # Should specify a GPU with --force or --gpu, of even --instance.
+    # The --gpu option also specifies an IP block and is thus
+    # redundant--better use --force.
+    # Specifying a GPU is optional--a default detected
+    # will be used.
+    # The format is --lookup <IP block>.<register> <value>.
+
+    _umr_setup_gpu_ipblocks
+    local REGS
+    local FINAL
+    local F
+
+    if [[ ! $cur =~ .*\. ]]; then
+	COMPREPLY=( $(compgen -S '.' -W "${IP_BLOCKS[*]}" -- $cur) )
+	compopt -o nospace
+    else
+	# Complete a register for the given IP block.
+	# See _umr_comp_asic_ipblock_registers() below.
+	F="${cur%.*}"
+	if [[ -z $GPU_NAME ]] || [[ $GPU_NAME == $DEFAULT_GPU_NAME ]] ; then
+	    REGS=( `sudo umr --list-regs ${F} | sed -E -e "s/(.*)\.(.*)\.(.*)[[:space:]]+\(.*$/\3/g"` )
+	else
+	    REGS=( `sudo umr --force $GPU_NAME --list-regs ${F%\{*} | sed -E -e "s/${GPU_NAME}\.(.*)\.(.*)[[:space:]]+\(.*$/\2/g"` )
+	    if (( ${#REGS[*]} == 0 )); then
+		REGS=( `sudo umr --force $GPU_NAME --list-regs ${F} | sed -E -e "s/${GPU_NAME}\.(.*)\.(.*)[[:space:]]+\(.*$/\2/g"` )
+	    fi
+	fi
+	FINAL=( $(compgen -P "${F}." -W "${REGS[*]}") )
+	COMPREPLY=( $(compgen -W "${FINAL[*]}" -- "$cur") )
+    fi
+
+    unset GPU_NAME GPU_NAME2 DEFAULT_GPU_NAME IP_BLOCKS
+}
+
+_umr_comp_asic_ipblock_registers()
+{
+    # The format is --writebit asic.ipblock.regname,
+    # the same as that of --write and --read.
+
+    _umr_setup_gpu_ipblocks
+    local ips=()
+    local FINAL=()
+    local REGS=()
+    local F
+
+    ips=( $(compgen -P "${GPU_NAME2}." -W "${IP_BLOCKS[*]}") )
+
+    if [[ ! $cur =~ ${GPU_NAME2}\..*\. ]]; then
+       COMPREPLY=( $(compgen -S '.' -W "${ips[*]}" -- $cur) )
+       compopt -o nospace
+    else
+	# cur = asic.ipblock.*
+	#
+	# When using --force with the default (installed in the
+	# system) ASIC and --list-regs together, --list-regs does not
+	# take instance numbers, so to pass an instance number, we
+	# need to know if the GPU was forced on the command line.
+	# First however, get rid of user hints.
+	F="${cur%.*}"
+	if [[ -z $GPU_NAME ]] || [[ $GPU_NAME == $DEFAULT_GPU_NAME ]] ; then
+	    REGS=( `sudo umr --list-regs ${F} | sed -E -e "s/(.*)\.(.*)\.(.*)[[:space:]]+\(.*$/\3/g"` )
+	else
+	    REGS=( `sudo umr --force $GPU_NAME --list-regs ${F%\{*} | sed -E -e "s/${GPU_NAME}\.(.*)\.(.*)[[:space:]]+\(.*$/\2/g"` )
+	    if (( ${#REGS[*]} == 0 )); then
+		REGS=( `sudo umr --force $GPU_NAME --list-regs ${F} | sed -E -e "s/${GPU_NAME}\.(.*)\.(.*)[[:space:]]+\(.*$/\2/g"` )
+	    fi
+	fi
+	# Cannot combine the compgen since a match is performed
+	# _before_ the prefix is applied! And if we want to match,
+	# we need to tack the prefix prior to asking for a match.
+	FINAL=( $(compgen -P "${F}." -W "${REGS[*]}") )
+	COMPREPLY=( $(compgen -W "${FINAL[*]}" -- $cur) )
+    fi
+
+    unset GPU_NAME GPU_NAME2 DEFAULT_GPU_NAME IP_BLOCKS
+}
+
+_umr_comp_ring_stream()
+{
+    _umr_comp_ring
+    compopt -o nospace
+}
+
 _umr_completion()
 {
-    local cur prev 
+    local ALL_LONG_ARGS=(--database-path --option --gpu --instance --force --pci --gfxoff --vm_partition --bank --sbank --cbank --config --enumerate --list-blocks --list-regs --dump-discovery-table --lookup --write --writebit --read --scan --logscan --top --waves --profiler --vm-decode --vm-read --vm-write --vm-write-word --vm-disasm --ring-stream --dump-ib --dump-ib-file --header-dump --power --clock-scan --clock-manual --clock-high --clock-low --clock-auto --ppt_read --gpu_metrics --power --vbios_info --test-log --test-harness --server --gui)
+
+    local cur prev
+
+    COMP_WORDBREAKS=" ,"
 
     COMPREPLY=()
-    cur=${COMP_WORDS[COMP_CWORD]}
-    prev=${COMP_WORDS[COMP_CWORD-1]}
+    cur=$2
+    prev=$3
 
     case $prev in
+	--database-path|--dbp)
+	    compopt -o default -o dirnames
+	    ;;
+	--option|-O|bits|bitsfull|empty_log|follow|no_follow_ib|use_pci|use_colour|read_smc|quiet|no_kernel|verbose|halt_waves|disasm_early_term|no_disasm|disasm_anyways|wave64|full_shader|no_fold_vm_decode|no_scan_waves|,)
+	    _umr_comp_option_flags
+	    ;;
+	--force|-f)
+	    _umr_comp_force
+	    ;;
+	--gpu|-g)
+	    _umr_comp_gpu
+	    ;;
+	--instance|-i)
+	    _umr_comp_instance
+	    ;;
+	--pci)
+	    _umr_comp_pci
+	    ;;
+	--gfxoff|-go)
+	    COMPREPLY=( $(compgen -W "0 1" -- "$cur") )
+	    ;;
         -lr|--list-regs|-s|--scan)
-            _comp_blocks
-            return 0
+            _umr_comp_blocks
             ;;
         -r|--read|-w|--write)
-            _comp_regs
-            return 0
+            _umr_comp_regs
             ;;
+	--lookup|-lu)
+	    _umr_comp_lookup
+	    ;;
+	--writebit|-wb)
+	    _umr_comp_asic_ipblock_registers
+	    ;;
+	--waves|-wa)
+	    _umr_comp_ring
+	    ;;
+	--profiler|-prof)
+	    _umr_comp_prof
+	    ;;
+	pixel=*|vertex=*|compute=*)
+	    _umr_comp_ring
+	    ;;
+	--dump-ib-file|-df|--test-log|-tl|--test-harness|-th)
+	    compopt -o default -o filenames
+	    ;;
+	--clock-scan|-cs|--clock-manual|-cm)
+	    _umr_comp_clock_scan
+	    ;;
+	--ring-stream|-RS)
+	    _umr_comp_ring_stream
+	    ;;
+	*)
+	    COMPREPLY=( $(compgen -W "${ALL_LONG_ARGS[*]}" -- $cur) )
+	    ;;
     esac
+    return 0
 }
 
 complete -F _umr_completion umr
-- 
2.35.1.607.gf01e51a7cf

