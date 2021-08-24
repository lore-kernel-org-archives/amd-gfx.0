Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03136C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C8761151
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8C8761151
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DF2897EE;
	Tue, 24 Aug 2021 19:21:46 +0000 (UTC)
X-Greylist: delayed 845 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 19:21:46 UTC
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1B2897EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ/c71V7W2PYstVLV7I35kNH7n34Xuk3EuFZAkhtH17aFGJiND0ImjpZ5gtciGHTiMiin4WMHx8tloqt730xz6nbyGw1qekC/5XsbIet9X4hFGUiQ7r340cxL0PnpWaenEptYTJUkhJs09tmYGabS3RrGg1bqxjS+1ivEXAk1k5P/V4O1FI7MczhyhdtZdYcvEOR8jJ7JfVoWFDdJYG+yuuz427d2HLSV0K3gnMmuPc/KhQCJ7pnKD0GpU/uDC1c4vNMeeW6M8I7S9p5DGxZwGLWmUBWFw3bjreqRE0quE2M8Nq9LTV69jfb1bfuym+cKwQeZQUZT0L6sNbbcpOu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3cL0tp7gNsVRQ5Ep7L8CF58eM1SCLdCCF5a0tC9Q0E=;
 b=hgonOHMUNFAgymXn0wiUsTXQHx95BGbKh9CiETZyeGms3ENr/foY+mwtuuOBuga1Z6/PvdH/dKIAp1hTWWLIyd3sP00jCV7AtcQQgHK50VpOCUBHKajm0XATpzEo63nUwr4JgujYnTgzxQLcoOMiZMgi7RN/v2DfrRuHlx4F+IvJUm5O2jPYf45HeSbtZPRx2uulEmp01bXcUNLwcSStWBu9IH0pF4QFIA1xc8J9SKKJNHFJ3g0wovKpmA2qCqpjLsMGhRSeOUjcaV010AHlqymQtFOGj7RL3kkuxGzt2wBRM7ogCU1OSijOVbuaMVEFbVcGZXUIGKv1emTk2iMQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3cL0tp7gNsVRQ5Ep7L8CF58eM1SCLdCCF5a0tC9Q0E=;
 b=DN8ywkPE91AfEFZFqzAX49Hmm3NjUVyp3GWBUJy9qTIPgHJ0aM5qe8mgfgmn1ejK7r8LX00UGLl2MTiyvwqtsF9IOyGCVJlEQNa4DcOBD/3g5X2y1tLCBsvGTdE+oH/OYJuSlZ6/gzPi5Rju66+nR5bTvuUrq86e8Lol7fgBLWs=
Received: from DM6PR13CA0011.namprd13.prod.outlook.com (2603:10b6:5:bc::24) by
 BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 19:07:33 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::af) by DM6PR13CA0011.outlook.office365.com
 (2603:10b6:5:bc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:33 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:31 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 02/18] x86/configs: CRIU update debug rock defconfig
Date: Tue, 24 Aug 2021 15:06:23 -0400
Message-ID: <20210824190639.6288-3-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824190639.6288-1-david.yatsin@amd.com>
References: <20210824190639.6288-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4edccbe8-0025-47f6-0fba-08d967326d7d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:
X-Microsoft-Antispam-PRVS: <BY5PR12MB496572ED78DE93CDED823E4395C59@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSxZ6xhG4jqMZ5uf+va0oi33Ejl+uew6YbQW/fV9gnvRezZiJF5kTqVxdtOJwS0ZyxJqv/wy3kkINiMq1amC+HxPvD4gHPg4afLOSl1ga6T7VTGQqAHBLTT8rGfHvDbKuZPi+xKdMqZxpqd/POkVNxeAeBS4tQhszVN5/f2V+O52/8Ctqv/uPbYOFiosAv+BaYNRKCjXPnkOZvueik/mHtykmxu3SX8+l1cK/MBkGl+bP1GQ8aZLa6VElvNvN53dpeW0CAtUAb96+2qHnuK+yCJyaTlubum93xAamnLCkfK6DbvmOa5jNEfkK381myKtBzrmec12IPPTEAHJHCOJYR5J3BQZKLa5sWJJLLnL4jH5CAPl7MAz+Bew9QrPHgKk6WcPfbheI4z1Qb6dr48Uz8H/0iu6x3UJcQDvXfEI5e676ro2pTq77CKac7xyjIfLR4Tof76Tnbdxgt9bQNESMp/JR6St1Gluv9/pDk0SxlzLIVpBtavYT1X8phIkGmClVtTgtP7AoG6FH2T8/d9kClCylfhhZJpKn1Tc0acJIKeRn1hNzPW+o8oucComEh4r4CnJcJF+pbm0iYhETWCZUvAeANaPDjoYzs/bjyjI/XgfkeUMB/nagfciwKHrLGmkmoAlkV6hWqOxLsCo8db6O3NVLzaaMUPf008cSwZpnCt+Ndg+KMamt2WfQ5t1L/0SfssRDTwUZM2gDrAYBkV7uWn9/iYw3CcVz8xCdL7tc50=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(356005)(2616005)(47076005)(4326008)(6666004)(82740400003)(2906002)(70586007)(70206006)(81166007)(316002)(5660300002)(6916009)(82310400003)(54906003)(36860700001)(26005)(186003)(86362001)(336012)(478600001)(426003)(16526019)(83380400001)(1076003)(66574015)(36756003)(7696005)(15650500001)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:33.1504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edccbe8-0025-47f6-0fba-08d967326d7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

 - Update debug config for Checkpoint-Restore (CR) support
 - Also include necessary options for CR with docker containers.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 arch/x86/configs/rock-dbg_defconfig | 53 ++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/x86/configs/rock-dbg_defconfig b/arch/x86/configs/rock-dbg_defconfig
index 54688993d6e2..87951da7de6a 100644
--- a/arch/x86/configs/rock-dbg_defconfig
+++ b/arch/x86/configs/rock-dbg_defconfig
@@ -236,6 +236,7 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
 # CONFIG_BPF_PRELOAD is not set
 # CONFIG_USERFAULTFD is not set
+CONFIG_USERFAULTFD=y
 CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
 CONFIG_KCMP=y
 CONFIG_RSEQ=y
@@ -994,6 +995,11 @@ CONFIG_PACKET_DIAG=y
 CONFIG_UNIX=y
 CONFIG_UNIX_SCM=y
 CONFIG_UNIX_DIAG=y
+CONFIG_SMC_DIAG=y
+CONFIG_XDP_SOCKETS_DIAG=y
+CONFIG_INET_MPTCP_DIAG=y
+CONFIG_TIPC_DIAG=y
+CONFIG_VSOCKETS_DIAG=y
 # CONFIG_TLS is not set
 CONFIG_XFRM=y
 CONFIG_XFRM_ALGO=y
@@ -1031,15 +1037,17 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_NET_IPVTI is not set
 # CONFIG_NET_FOU is not set
 # CONFIG_NET_FOU_IP_TUNNELS is not set
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-CONFIG_INET_TUNNEL=y
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
-# CONFIG_INET_UDP_DIAG is not set
-# CONFIG_INET_RAW_DIAG is not set
-# CONFIG_INET_DIAG_DESTROY is not set
+CONFIG_INET_AH=m
+CONFIG_INET_ESP=m
+CONFIG_INET_IPCOMP=m
+CONFIG_INET_ESP_OFFLOAD=m
+CONFIG_INET_TUNNEL=m
+CONFIG_INET_XFRM_TUNNEL=m
+CONFIG_INET_DIAG=m
+CONFIG_INET_TCP_DIAG=m
+CONFIG_INET_UDP_DIAG=m
+CONFIG_INET_RAW_DIAG=m
+CONFIG_INET_DIAG_DESTROY=y
 CONFIG_TCP_CONG_ADVANCED=y
 # CONFIG_TCP_CONG_BIC is not set
 CONFIG_TCP_CONG_CUBIC=y
@@ -1064,12 +1072,14 @@ CONFIG_TCP_MD5SIG=y
 CONFIG_IPV6=y
 # CONFIG_IPV6_ROUTER_PREF is not set
 # CONFIG_IPV6_OPTIMISTIC_DAD is not set
-CONFIG_INET6_AH=y
-CONFIG_INET6_ESP=y
-# CONFIG_INET6_ESP_OFFLOAD is not set
-# CONFIG_INET6_ESPINTCP is not set
-# CONFIG_INET6_IPCOMP is not set
-# CONFIG_IPV6_MIP6 is not set
+CONFIG_INET6_AH=m
+CONFIG_INET6_ESP=m
+CONFIG_INET6_ESP_OFFLOAD=m
+CONFIG_INET6_IPCOMP=m
+CONFIG_IPV6_MIP6=m
+CONFIG_INET6_XFRM_TUNNEL=m
+CONFIG_INET_DCCP_DIAG=m
+CONFIG_INET_SCTP_DIAG=m
 # CONFIG_IPV6_ILA is not set
 # CONFIG_IPV6_VTI is not set
 CONFIG_IPV6_SIT=y
@@ -1126,8 +1136,13 @@ CONFIG_NF_CT_PROTO_UDPLITE=y
 # CONFIG_NF_CONNTRACK_SANE is not set
 # CONFIG_NF_CONNTRACK_SIP is not set
 # CONFIG_NF_CONNTRACK_TFTP is not set
-# CONFIG_NF_CT_NETLINK is not set
-# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
+CONFIG_COMPAT_NETLINK_MESSAGES=y
+CONFIG_NF_CT_NETLINK=m
+CONFIG_NF_CT_NETLINK_TIMEOUT=m
+CONFIG_NF_CT_NETLINK_HELPER=m
+CONFIG_NETFILTER_NETLINK_GLUE_CT=y
+CONFIG_SCSI_NETLINK=y
+CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_NF_NAT=m
 CONFIG_NF_NAT_REDIRECT=y
 CONFIG_NF_NAT_MASQUERADE=y
@@ -1971,7 +1986,7 @@ CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETPOLL=y
 CONFIG_NET_POLL_CONTROLLER=y
 # CONFIG_RIONET is not set
-# CONFIG_TUN is not set
+CONFIG_TUN=y
 # CONFIG_TUN_VNET_CROSS_LE is not set
 CONFIG_VETH=y
 # CONFIG_NLMON is not set
@@ -3955,7 +3970,7 @@ CONFIG_MANDATORY_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY_USER=y
-# CONFIG_FANOTIFY is not set
+CONFIG_FANOTIFY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 # CONFIG_PRINT_QUOTA_WARNING is not set
-- 
2.17.1

