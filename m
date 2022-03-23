Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EE8C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 11:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A0210E6B5;
	Wed, 23 Mar 2022 11:49:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C33F10E6B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 11:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY19uPY83C0dQeTSKguLrF8mQIPCGIvt9u7d2ka3mcd8a2JrDTx7YW7DZ4vVW0TQWwavMesURk+TzryfGFdfn2nh+KxM9XnOxoS6AsQj1jRFyNNJPA9QBqmoVW6FZlYnvTu9OxKotu1xqRAiirmoIDlKaiw2tB9mMAf0kWrnCaVLxK343OTWwdiKRmdaV39WRXK3yozGc2yYD62J6BbdrXFFtbdBGaxjpcsp861mT6mU1gW2WmPH5BRdcWbMgM9dVK0/K105LA0CFUskhabAambuT4d2ghQ+/zqcrnDDRHe7jFCvvQnYGQPALIDS88j9p4FqsbsKtC1u2vHNSaiAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTANCvTYFPyi8JUlHLdE3p8MSB8wHw81nZGdLDdQl8M=;
 b=kTWXS7aUzGP/+Rc9SfboLzW/7Q2CYswbyaDtPERNiFej2FgZm6REDZvPyZIAQ/Y0Fn88TIeiESS8sf/+POYFFtchPY3JbVkqb5s1mWO71XN7AXSLQgKC95iQg1+/+iauLdE9zsIgFUa1mu6RoKiIvsb3GRDxIK0Cba/tbw+n9aTAX1nO5v0xjrbSJDuBvwbPG3VzVzf7EtVmSp82NqReiqfCEcnldB0w9t+tQWo1+iv19l2TZ4AXKE7QSQOLnhalFe7LrwABaJGBmtoEAaSytsdPbwY6V1H7M+tPFEX7Z7vBfxErSrzYglgKbODqdPyl8DCPk5BWibSlkL93PoJIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTANCvTYFPyi8JUlHLdE3p8MSB8wHw81nZGdLDdQl8M=;
 b=4lR1BObFHI9+rjcCbx55r+t89rhLJzurUkMWP/ksl04eJWKTvVVPiB6HCZV61OdD1/bWqqDZOKKHLGnfLBDdooOpYm+/eoarBnAH/svfEDaI26t4u4WbuRXXA1szeE2DyOmEByGP83Pcx00xhgLhnNapVWlquNSuB04lZudDUfQ=
Received: from DM6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:5:80::23) by
 DM6PR12MB3034.namprd12.prod.outlook.com (2603:10b6:5:3e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.16; Wed, 23 Mar 2022 11:49:21 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::80) by DM6PR08CA0010.outlook.office365.com
 (2603:10b6:5:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Wed, 23 Mar 2022 11:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 11:49:21 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 06:49:13 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] umr: Replace and reuse ipblock completion
Date: Wed, 23 Mar 2022 07:48:41 -0400
Message-ID: <20220323114842.78516-6-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 647fed34-8d9c-46e4-5e60-08da0cc32b78
X-MS-TrafficTypeDiagnostic: DM6PR12MB3034:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB303473D032606910B0FA14F499189@DM6PR12MB3034.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKsvCcts8Ypt47PvkSrMNRpNf5JBbGB8nh1TeFsv90gwvJinkPcFKkmXFcoPYZjPjJ4AEDazwJs2IXbu7X3s7x3tVQuFcXSKmjyKa3cS0hcJST8nHPnQYCqJ54EIvlR1lDwDrT546OEGKhrpolBzJVcZqjTDhh7mFYvgfdrY3mw6Fzi5ecab26SEelVEGSGDKgFuWvjZGqG/+PDlqOWr6zNCpcRr9lvDdexzBx35uW+k290U8WKZoWTjWf/JqMKRc0mt2m5q8elzmHCssBkhQWrESHmQDQL8ceyqRmyLEkV9UaD22XMF8E3cs4oInHWT62FL4ble2nGLbWvthdMwn5hXx6eqOU3V9EImkmT3h5rui44vVzfe2RGxNzo/77A74S1D+Trz8RPsR0bEyPsOojZn3zPAEHnJVUvnGUQgJx6G19LhVcsDU4tPKQ6JlTOnI2m6UVrtzDoKqb3WitR7rbH70/Ch12usL3FJPsQinp22iVF3UaFt8voq4oGW1RD+g/hPeZkOIQaagbTfL1BEL+OQKx0J7iblOOeiWV8G4R6CH/IS2SBscBrJDO1WfbVQok1DoESa1cws9r+vfEfHVNZjL4HgYW2DsZgJ8BHxgrJ8UG61kc7XSSBGBR8HLiJGsvrEg2rvpz6myiwk4EWHgrASYOgCTdl95kvHrL8Q/G4zsCZmhWeeYiF+GGsfAN2/QAZ/Sy27eIrJzGghfJMomA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(70586007)(70206006)(8676002)(2906002)(16526019)(4326008)(81166007)(356005)(86362001)(36756003)(40460700003)(44832011)(47076005)(82310400004)(83380400001)(8936002)(5660300002)(36860700001)(1076003)(508600001)(186003)(426003)(26005)(6916009)(54906003)(336012)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 11:49:21.2873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647fed34-8d9c-46e4-5e60-08da0cc32b78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3034
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

Replace and reuse ip block completion.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/umr-completion.bash | 73 +++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index ab1637a090e5d6..0e1444357c82a9 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -16,45 +16,6 @@ if [[ ! -d $UMR_DATABASE_PATH ]]; then
     echo " See the FILES section in umr(1)."
 fi
 
-_umr_setup_ips()
-{
-    select_gpu=""
-    if [ $COMP_CWORD -ge 4 ]; then
-        for i in ${!COMP_WORDS[@]}; do
-            if [[ ${COMP_WORDS[$i]} = "--gpu" ]] ||
-                [[ ${COMP_WORDS[$i]} = "-g" ]] ||
-                [[ ${COMP_WORDS[$i]} = "--instance" ]] ||
-                [[ ${COMP_WORDS[$i]} = "-i" ]]; then
-                select_gpu=${COMP_WORDS[$i]}" "${COMP_WORDS[$i+1]}
-                break
-            fi
-        done
-    fi
-
-    ips=( $( sudo $(which umr) $select_gpu -lb ) )
-    asicname=${ips%%.*}
-    unset ip_names
-    for ip in ${ips[@]}
-    do
-        ipname=${ip#*.}
-        ip_names+=($ipname)
-    done
-}
-
-_umr_comp_blocks()
-{
-    _umr_setup_ips
-
-    if [ -z "$cur" ]; then
-        COMPREPLY=( $(compgen -W "${ips[*]}" -- "$cur") )
-    fi
-
-    if [ -n "$cur" ]; then
-        local array=( "${ips[@]}" "${ip_names[@]}" "${ip_names[@]/#/*.}" )
-        COMPREPLY=( $(compgen -W "${array[*]}" -- "$cur") )
-    fi
-}
-
 _umr_comp_option_flags()
 {
     local FLAGS=(bits bitsfull empty_log follow no_follow_ib use_pci use_colour read_smc quiet no_kernel verbose halt_waves disasm_early_term no_disasm disasm_anyways wave64 full_shader no_fold_vm_decode no_scan_waves)
@@ -289,6 +250,38 @@ _umr_comp_lookup()
     unset GPU_NAME GPU_NAME2 DEFAULT_GPU_NAME IP_BLOCKS
 }
 
+_umr_comp_ipblock()
+{
+    # Handle --list-regs and --scan, using the --scan model
+
+    _umr_setup_gpu_ipblocks
+
+    # If compline specifes a GPU, then complete a block of that GPU;
+    # else complete all GPUs and the current GPU's blocks in one list.
+
+    if [[ $COMP_LINE =~ (--force|-f|--gpu|-g|--instance|-i) ]] ; then
+	COMPREPLY=( $(compgen -W "${IP_BLOCKS[*]}" -- "$cur") )
+    elif [[ $cur =~ .*\..* ]] ; then
+	# The ASIC here is the default one recommended in the "else"
+	# case below.  Because of this, we don't use "--force" with
+	# "--list-block" and so also get the instance numbers of the
+	# blocks. Then we combine that with the ASIC and offer it as
+	# completion. See _umr_comp_asic_ipblock_registers() below.
+	local asic=${cur%%.*}
+	local blocks=( `sudo umr --list-blocks | sed -E -e "s/^[[:space:]]*.*\.(.*) \(.*$/\1/g"` )
+	local F=( $(compgen -P "${asic}." -W "${blocks[*]}") )
+	COMPREPLY=( $(compgen -W "${F[*]}" -- "$cur") )
+    else
+	COMPREPLY=( $(compgen -W "${DEFAULT_GPU_NAME}. ${IP_BLOCKS[*]}" -- "$cur") )
+	# This uses the zero element
+	if [[ $COMPREPLY =~ .*\. ]] ; then
+	    compopt -o nospace
+	fi
+    fi
+
+    unset GPU_NAME GPU_NAME2 DEFAULT_GPU_NAME IP_BLOCKS
+}
+
 _umr_comp_asic_ipblock_registers()
 {
     # The format is --writebit asic.ipblock.regname,
@@ -373,7 +366,7 @@ _umr_completion()
 	    COMPREPLY=( $(compgen -W "0 1" -- "$cur") )
 	    ;;
         -lr|--list-regs|-s|--scan)
-            _umr_comp_blocks
+            _umr_comp_ipblock
             ;;
 	--lookup|-lu)
 	    _umr_comp_lookup
-- 
2.35.1.607.gf01e51a7cf

