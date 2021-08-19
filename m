Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7FCC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4F1610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C4F1610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D2D6E95A;
	Thu, 19 Aug 2021 13:37:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB14F6E947
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8ErJK8GXgdtcdSpTSoZyhoBS8hc+NK/opWoKmEA5aV0x5mEJW+irKAxj5P8VvpgWzyAuyWYBJ0hzLbmr0lLApHRRiyXJFae1xovGY2RbvXS1SNK3TxdHPwRLwYTwfMtz5DHE5g47SEsg5Hcc3d56OIpwZWYBfY1qwSfAGvqGyZ8kyZ9c/2L3o9L1Z+w3dySMEZwcfyUvAKIYT/LK76SEGJscj9LhPSR4+Jlm5Lpy02iGRqVzLvOE4xSerItGUBXag5BUAq0KraWPhTcOx/lEhX+4ZRo1+vxsBfNwKozo8uJDc1ovxM5vyKeU5K6SUUeklMJ6IZI3ZDr1+sdfTB3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3cL0tp7gNsVRQ5Ep7L8CF58eM1SCLdCCF5a0tC9Q0E=;
 b=M+HerkgUTDKg4Vpwz5D50uPtp/Gw+n8x2Po2mcAXHewQ2v55/R+180t5VfNYRd15UZlRcGWdDbI/fPM5xl8PQGzWd3Wb0l/c1ZXWTg3FK+oazaRpCfn2a8ieROABuh1uptlkGlffrz7DEPk0N/30Kl+dWLAN1WuHMlJ4V4aZ3RdxklBsm8ku58x6PSWWfYuhnmVJN5pvDd0VgGaJpudNoODR1t477LoQB6/wnHVkcSKY99MZOAmnvX0fBXYtnWMfM52uJY1j/dp+r4vf/jpYtoZIG3fcSinoh61O15vVTd0i1xmF3hxQYFIAkGtQy1dCFMOQhW32mRHQDDl8yE/Dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3cL0tp7gNsVRQ5Ep7L8CF58eM1SCLdCCF5a0tC9Q0E=;
 b=ZPrsFQyhFfKZzMVr8MIAuvfZjQYui8WqSA+YVFf/Wnv3WMa8vXtxyUCvTjmUu/wjJgbiFr8Z3L75Waip/vf87KivzJKgBzdYvXjDN1T6ZVY8p8MFX2aZC+URGv/dGgMJgwUzJZUwiSI4Xago7/vZiodK9j5OVhc+FzohHd1UeO8=
Received: from MWHPR2201CA0058.namprd22.prod.outlook.com
 (2603:10b6:301:16::32) by CH2PR12MB5531.namprd12.prod.outlook.com
 (2603:10b6:610:34::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Thu, 19 Aug
 2021 13:37:48 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::62) by MWHPR2201CA0058.outlook.office365.com
 (2603:10b6:301:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:47 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:46 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 02/18] x86/configs: CRIU update debug rock defconfig
Date: Thu, 19 Aug 2021 09:36:57 -0400
Message-ID: <20210819133713.4168-3-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819133713.4168-1-david.yatsin@amd.com>
References: <20210819133713.4168-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57d3ab77-cc50-4d58-a6e2-08d963168873
X-MS-TrafficTypeDiagnostic: CH2PR12MB5531:
X-Microsoft-Antispam-PRVS: <CH2PR12MB55311CAB2D112C55D16A300495C09@CH2PR12MB5531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmhE4p9uZl4iEqp66sqm0Gm1zZu1dqCK8nmnyXC75bWveJxUuYvqd4giMruq9rX37jKBaE2p7hBaA7hwah7q2C3zbvzAAI24a+osvz5Jl9ar4hLnR+IMgcYMYmBtGplDUDZkisFYMcp665jephj8E3IoiKk7r7z1QMo5Jm/aK7Bj0I/gxoGIyHUwWV8iSMro7+8N9A1oKf7sWftY5WwUSzvvf83DhsIW4BxiAOX8RV9zpn11IUukASBr9iFIuxY4+zJYt5+LyEIoBqMAy8YhL1WYLGf6DTAFRa6PCPveClqM9x2KbPO700kdixz9CU6EaYZ7M6ebO+uspm5/32HDQQtRXcGWTH5Y7hWsK2QuguXC78VN/eU538LNR4DW/kGrjhkG3lyxBqAteKOdefY9+DTnYCfIqc3fG1gkaaEmnw8RUa3HdaQx5XjO85zIRcmEPG3zf2llcRe0XY40yMw/pdNROC7DIGNmMd4hcDCsOr7hwMq8XsW48WJwr9ItmJD8jN9MBhAaa1Xnz2hYmby/dKBlx6LROsifT+P5lohirl62OfBHN1P29NFOEDW9VQnIfhvnKCBzBNIONRij6U0z6PNuf4noYDVi6T+sxv/g3ptSew4Tz32JDfTErWsh6BZBQoYMATXNALL8l3xRTJJbdg/tgQdSWb745VY4IkDBP7tMygE+X4VBsVeGTVsaoOnkBNYdQsbmN4b/w6EICLccYHygciqYR84p5Bync0P8XfzPPXDO3yguOo498z1P5ld3G2kaql42BdjqdP8lwgQ5Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36840700001)(46966006)(16526019)(70206006)(86362001)(70586007)(26005)(83380400001)(356005)(5660300002)(36860700001)(6916009)(7696005)(478600001)(54906003)(4326008)(34020700004)(36756003)(82310400003)(6666004)(1076003)(81166007)(2906002)(2616005)(336012)(66574015)(82740400003)(8936002)(8676002)(316002)(15650500001)(186003)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:47.7757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d3ab77-cc50-4d58-a6e2-08d963168873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5531
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

