Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D29C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46A6610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C46A6610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553AC6E947;
	Thu, 19 Aug 2021 13:37:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7314E6E947
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl5D9ifS6JAyWwpqCpfWpc+A9WphyOIAW+667rmWfHgSqOQ4Xvy8UFxHi9H6oOoEF1r1/KgIvKPXWvm4X5iDiGNfznLaZ204rBtS7cpYBR9Te4FfKYnuaHSEWKXuspG25InGI8kL6AfYQ5grfqy7sQz9F9ncvoAP4QYjrQfV4dYAnM4DjUzXzj24eq8Z8CbNGJvbF3Vasfh9gBRMaJ7Z+CfjrOmbQwFX/7sPPDf0jzJAEv79U4+istWoVOfABP7g1VDAJglsEqiSrfe6Pp1tqO5knAkYQlFM06FqTD5uDMcQwQuNvHZn6aLuybE5EH55JajFrXip9dXsVj4/DNj1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3GuaAMQVzZewhmJr2EKiLOkUu/y1eKJc7Bvl5LJ2eo=;
 b=SfsuKZQuwgav/DWNi/h3dj6txm55STESbxzbssDmt0mV3PqRioqj6PtZgqDJU4f+56xjPO7szhLDHF4gXexQw4/qedR1+uvUWnqxMhxVQDSoAEBZGYysQCSxHayTzq5pX4HqH/ZsAJ8WnLWCnl0CkAx+ATD5/xLyRAlGoNVfxbFm+ddVbie5ku3rB8VUcTV1c+lZ1UrMfH643T0rzw3q1Ikyw+hbUnq62jvRYurCZMKb06dgbZwm30so1QvWf78aqgaJzBV/+maYIcpCn4w20goaeByLbX8k+MUqU/x0f8g6CXh8OtN4bKqtun/1tVeASBu5ytDf2ajzyb2EDpmnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3GuaAMQVzZewhmJr2EKiLOkUu/y1eKJc7Bvl5LJ2eo=;
 b=XnjBKQzV6k6ZvbBEj/oswb+RC4LDazLZLn9aRxcKqedA6lcBKICnLdgxgoBLt5yYF4hpqwVIjgXxEnDBH15KD5G7c+oaEpu5I5sQlbIQpgaEuPeZyhMf8F1XwWJnQpEoX+jwn+xwizI8CMNyOtiqcdEzJYXamGsV5OEA7t2aaCQ=
Received: from MWHPR2201CA0048.namprd22.prod.outlook.com
 (2603:10b6:301:16::22) by BY5PR12MB4920.namprd12.prod.outlook.com
 (2603:10b6:a03:1d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 13:37:47 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::ab) by MWHPR2201CA0048.outlook.office365.com
 (2603:10b6:301:16::22) with Microsoft SMTP Server (version=TLS1_2,
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
 2021 08:37:45 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 01/18] x86/configs: CRIU update release defconfig
Date: Thu, 19 Aug 2021 09:36:56 -0400
Message-ID: <20210819133713.4168-2-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ecb08f3-f670-4e1c-e58e-08d96316881a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4920:
X-Microsoft-Antispam-PRVS: <BY5PR12MB492064BA9170D844D8B47B5A95C09@BY5PR12MB4920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJSm8VeOykrFRKlUsVy7TCtcmGUACzZ2ScnZfJZ0I59aS4YlC7goSPsNpqWG30q+nPKVRr5fL29Q4+97FXPlX/FxuEDdeYx/g2s1aZfF3iITK5CAsB8qWLbfQxAvdiRAwJ5er7bfQVxCGvcKgJj8r4pqMDiWMGIJmH+2UJuPm/6DhWBD3g/6Zvkh9NjA3Coff+Ur0yPk8OCp9fl5H6NehqE+0dz8IXJfwWHMY4v0o2iNtiM8VsAjG4C38FdtvhDudoBYsB0aA37viCEGF38tvx8PPSn12nXMzLMSsA6hWsnKn/3hW01BXILzgxPOz864sSMA+nnvuafjcmNWWNycp9Z2VhWeGct1Y3iCZDiabqbeM6SMZMT3rU2D8d+BedQ6kKrqgXYXN1XUS1/k1Cnu1pPUOuVN+w7NUYKT5/Q0DLiFSxA8CJBt5aP7AkkNt5ARLj5t/dk3c3n9SpxBLzaZWwLfJHq8M20oUZUZjcscwdQm7tiQdXhDDjFCcf4AUSf81+BqPyoFsTkE8r+U6/K8ejJKVtCyvQnRm8pCltW732RvrmgmS4acumOQPUzIEjpWcoslYXPQ2AtJ3nH5+CEnv48PWGtx/m2cW6ulcQRahaPpvVv5/F+gg5iRgiUxCyN3QMl5V/ipBkd5INHfvHxAFpB7k8eRj8fjm5MgIaso1PdjR9nvjqEghYZws8VreCDuSqEgWcXCghEr9TZy09lOd+oHM3NSUPHtKw1IO95E0xAw01Rf7Bs2fnI9xuz8AAU1c5x84IopzKkr6aLg1aSWaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(15650500001)(47076005)(2906002)(4326008)(8936002)(2616005)(36860700001)(7696005)(316002)(54906003)(1076003)(5660300002)(70586007)(6916009)(336012)(6666004)(86362001)(83380400001)(26005)(34020700004)(356005)(426003)(36756003)(81166007)(82310400003)(16526019)(186003)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:47.1941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecb08f3-f670-4e1c-e58e-08d96316881a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920
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

