Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA85C4320E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B096113A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29B096113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB8D6E0C2;
	Tue, 24 Aug 2021 19:22:54 +0000 (UTC)
X-Greylist: delayed 918 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 19:22:53 UTC
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (unknown
 [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3796E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6G1lN/v40onLJGXbCDJl5KeUUOyorwNXwsm0cfyuo2VKl6E2imRjppE9n6u9fwUyZuoNowu8bcRWDgsoh6y7SjqwJD5B4DV5XsUyHky7VZlVhQXDEmls8ohEOQG6UlVEdhHEQ/NyHod5MAfJyFka9MdMQ597XD4VrNRzLFNLsw6YFPV3A9rmRkVfpr5jvAf+0BWGUFDoN9RuMSN3aWOby92qjusDd4eESwIJdmHMMEZIFkwgS1lfoyic4iPLmogty8m6kIjtrESlK0mlb3YEI0I2mm9w1dKOAtskPcBdXbC7p1xTMogu8lKb1s+QaaCrlkIAmP9tvJAZYZM+nUPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3GuaAMQVzZewhmJr2EKiLOkUu/y1eKJc7Bvl5LJ2eo=;
 b=GkhpOAs3mT8UC+sRIqUtAcnkemdwnwgodyHIPx1wOxIksdvhXnbZn/xylmxCSq5YxKiL0pJpaKrPnxMuzfdWO0kK31rtPqz+7cl2AHDhsE3pzIDJCO2mraOqUTJcfLPDbX2y8PAGEelLZk+zsDQPY+pAn9kdd97SGiZvd8cGxn+39ZWaUfJhSVrBG3Gx5mXzRgTnZrxwYM7UmF7KfwLvZrnONvmZLTNaphWGd/OuXYnQSK/KLb0SOpDHm1SJSMb7A8qqJilYbD8RPsLP6eubVsFN9HTVGpzXoiioqg5QxXU7McW8jGSnryeuHnRfcBywG7Crv+1XrqtmY8Aq6cxs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3GuaAMQVzZewhmJr2EKiLOkUu/y1eKJc7Bvl5LJ2eo=;
 b=vB48iVOc+fOlbuUypyQ9tdUhD1BN1VTwrHOIQZGA897yQsNNt9lSiQJ+R03eHNp/KkeH02TmGouJoNYXn1s9IRHhbyoVWL24lu1DNAyB5X0I3PXfqtWxeSIcQe9PEsCDKgK1XeL0+V1uZK1yzJzYZ/iji3MJYLpoAZbH0A0WydI=
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Tue, 24 Aug 2021 19:07:32 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ed) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:32 +0000
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
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:32 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:30 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 01/18] x86/configs: CRIU update release defconfig
Date: Tue, 24 Aug 2021 15:06:22 -0400
Message-ID: <20210824190639.6288-2-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9102a49-4fba-4e71-bb2b-08d967326ce2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB012142F51B02D4E87B8FC1B595C59@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5X6j9P4/xH+ukc//uoKYLL7L/a0DWm4TGXiNWoeEEXSM6O6rTXuBKwGBlrBSP/vJNLFiwGVecZbOtv2NuUcXDxxFPIcnUtpLNy+RLIW/dWo62o+gdTY0n9WpJOA/fA8GatR9D5E8mpHT+dvMUVkcDavvMhP2FlNYfFguLKUunthhhP9xHakJS4aWW9l2f3QFqhlQCRWs1lOHelFJRXlDCWoAWKqUw2k1pSPXHo5duVFixNp+aUToGMmEzcpJtkcmhPZ8yF8ay3Q9RrD4zefFHeoVJNXHYxs/DDzm9DYphtjJvAbjy8T/XxD6ESNJfVVQk6gLotMSqB5p5TVNN2cXlCquoCEnUMFZsQyS4oFgP5NRH7nFPMo9kMVPQYkRPeVX61qwwEVl2DtGMrUXYgprvdwTjkb5gSfdeAKuxXhmxjT/YNnYozMqgvTWW5HN1zFGKhqsILkZeBgatnkVAn2NhLQ7jdtztTHn/YbzKzTTldVULnOWpnSlHYJX8rNSKFST1O4DRgprmH27NI1Nm8oHFaWPcaLteXxA+zw8RfH2oqxa+94Pw9982Tv6QwtkEeXqZi7oe+2o3WahS7EecnogS+gUF0OB3uSVOj/DdjgUqC+gHBDCWH1L8tWQ/qUV/h9Fl7rlCeJocwjo7wicTtV4JoUo4dlF4Fz8LkxbjsKe3vj1Ctpg1iJ4QWSJWgOX3xdW46MutdhWwOxOG823CLQopHYQEZkMH6dvhK62gWHkv4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(47076005)(16526019)(186003)(7696005)(86362001)(15650500001)(6916009)(81166007)(26005)(2906002)(478600001)(1076003)(8936002)(6666004)(8676002)(336012)(36756003)(5660300002)(426003)(4326008)(83380400001)(82310400003)(36860700001)(316002)(356005)(82740400003)(54906003)(70206006)(70586007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:32.1400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9102a49-4fba-4e71-bb2b-08d967326ce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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

Update rock-rel_defconfig for monolithic kernel release that enables
CRIU support with kfd.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
(cherry picked from commit 4a6d309a82648a23a4fc0add83013ac6db6187d5)
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 arch/x86/configs/rock-rel_defconfig | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/configs/rock-rel_defconfig b/arch/x86/configs/rock-rel_defconfig
index 16fe62276006..9c46bb890879 100644
--- a/arch/x86/configs/rock-rel_defconfig
+++ b/arch/x86/configs/rock-rel_defconfig
@@ -1045,6 +1045,11 @@ CONFIG_PACKET_DIAG=m
 CONFIG_UNIX=y
 CONFIG_UNIX_SCM=y
 CONFIG_UNIX_DIAG=m
+CONFIG_SMC_DIAG=y
+CONFIG_XDP_SOCKETS_DIAG=y
+CONFIG_INET_MPTCP_DIAG=y
+CONFIG_TIPC_DIAG=y
+CONFIG_VSOCKETS_DIAG=y
 # CONFIG_TLS is not set
 CONFIG_XFRM=y
 CONFIG_XFRM_ALGO=m
@@ -1089,7 +1094,7 @@ CONFIG_NET_FOU=m
 CONFIG_NET_FOU_IP_TUNNELS=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
-# CONFIG_INET_ESP_OFFLOAD is not set
+CONFIG_INET_ESP_OFFLOAD=m
 # CONFIG_INET_ESPINTCP is not set
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_TUNNEL=m
@@ -1097,8 +1102,8 @@ CONFIG_INET_TUNNEL=m
 CONFIG_INET_DIAG=m
 CONFIG_INET_TCP_DIAG=m
 CONFIG_INET_UDP_DIAG=m
-# CONFIG_INET_RAW_DIAG is not set
-# CONFIG_INET_DIAG_DESTROY is not set
+CONFIG_INET_RAW_DIAG=m
+CONFIG_INET_DIAG_DESTROY=m
 CONFIG_TCP_CONG_ADVANCED=y
 CONFIG_TCP_CONG_BIC=m
 CONFIG_TCP_CONG_CUBIC=y
@@ -1126,7 +1131,7 @@ CONFIG_IPV6_ROUTE_INFO=y
 # CONFIG_IPV6_OPTIMISTIC_DAD is not set
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
-# CONFIG_INET6_ESP_OFFLOAD is not set
+CONFIG_INET6_ESP_OFFLOAD=m
 # CONFIG_INET6_ESPINTCP is not set
 CONFIG_INET6_IPCOMP=m
 CONFIG_IPV6_MIP6=m
-- 
2.17.1

