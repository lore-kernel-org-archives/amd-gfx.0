Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB6CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 04:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CF789F73;
	Tue, 12 Apr 2022 04:08:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B5610EDCE
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 04:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YURmrvbOqTxobF/UWboS0nNdFMtXK97smKCCdMlg385aAYxzC4ZpLaWAJHyiTZ94SQblK0zf0iyJ5Y/b0dEU1buZYQ8uVg9l8E9UjHDdJzIG6LVfsmpQ64UAzoQTNMNuLXWiapF7einzWk4Fcn1LgKzE6KOh8sr0a4liWzAqeJSXAk6t1qD6oXgVlH6OCNhQlsDISxEEZUlYzpQ1yKCL0LtImw0AetgcqTU7z8lB3Vmp7FAgF4scBuec7or2BsDWH6SfpTpCc7aSq3Jm9lAFOGQyBbKDSPZ3a74jsEhlR49q/jEYbdCQxD1dv6yzuHWXPYak6chFkqw0UDXo+1GIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW6Zz80P6/AaekL2UKSgt9KVHpudV4OlnintWtxYek0=;
 b=CF9eQkZihYrL9jsoWVsRGWk04NTd6WvH36JZ/4XkeFuPJNZKjnruFv6Q4ucGDuQBHY0tXFTvQ9E8q/OYkKHW4tOzFjz+GDdFcLk80vWzY+ZK8baNxfhFkhlZKcrnUEAS8A5t44p8+in7Vh0G+uECCYn1cvmAXNmdHtf+1Ub8QWLpthuy0TlfbFzfIVtDxlH7iEFT2chPGfaRrZQN4uzlrw77dmHqBr835WEHAJ3A8PxAtxURgPCHlM4vIxk7qvGxiWT2JZqAsgyPhQR2Qqzx3UsXjRTkPHDPzbUIuWiny9w2MyjaCT7ujot5/Ye3v/l5ZfEgQfotLEHuu6q9UKrQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW6Zz80P6/AaekL2UKSgt9KVHpudV4OlnintWtxYek0=;
 b=TEoW7QZnSeG3aRYgjgkAZSnl4U1AHtDLg/j9N7WdwY/mCSMTuU3fWO9uVGJcBlgUVOhkT6mhq33rFpvlwZhn2DLs7zuNX/4HY/GLHFQMmDAjyPXRQU9ng98lq+pRBNekqBp6Y45cmxkkbDG4ii260DFK7XpBzJ8YKqrt70Y2plY=
Received: from BN8PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:94::17)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 04:08:17 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::54) by BN8PR03CA0004.outlook.office365.com
 (2603:10b6:408:94::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 04:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 04:08:17 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 23:08:16 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] amdgpu/pm: Clarify documentation of error handling in
 send_smc_mesg
Date: Tue, 12 Apr 2022 00:08:01 -0400
Message-ID: <20220412040801.19905-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf45a73b-2f01-4281-864e-08da1c3a12be
X-MS-TrafficTypeDiagnostic: CH2PR12MB4119:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB411984E3373016BC645657CDF0ED9@CH2PR12MB4119.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYms9ra40XDx0av+lvpIPKh355I8cp7g7La1eJx8rha29bstKx6UTIA8i29AhFezKez4dyMRhyXOBKoqCHpd94tm4isjZvIxvPT7tkE440KtPSITImPPTirhZ8IBQU65PScXPZafsWCm7ODSDg7sHl+5tGwm7NVc/LeOOvKYYgpu92QiTGdWUsIYZlCbFz0ywkRniausCeyvPzBKDpYE4MN2ss/P+ArNxdumoBpX6o+DTZh7NqOoYm0Y1+n/QQz3j5bwrWFleedGiXJP48fYilyQ/uHxu8+XS+Ro/oWaHu31980q+WSi0KGwRuUy0qXztZaQzufcTvwr2iV0Ln3qjPi+xiL3CCQYFu37ZGGO6SlrXXMzckxXmHjh37DVrpCPcN4+pxsI5UFtP6f0PCJhp0jS8BjTo8WcrGWYqjWv/ZCkHQXflExxM850ZUjuqiVIPW+nqNd4W9tqhUU63tkVwDwDbg+i6SRxJttJR+46rtqz9SS0q4AjOH1zZs2nzKLMCCWrOuizI82r+yM367t/s7zQWLXxIh9SepIhnDlxuK9kV0Wg9RYvXNA/8RqpEfdjorTn81O8hMWyMAmaQj7ZtRE4TBtyybI88uvad2ofZ9Jjz+vIPbcsovATQGiIW8J7ato/SOcGQSht4f4zSVBC7vwAVRUIcz/auM4RfhR6HG+00FrVXYK7UN6wDwmJhkfOtlY3xf3DmJKjsJbYY8up9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(186003)(16526019)(82310400005)(508600001)(36756003)(6666004)(6916009)(47076005)(83380400001)(336012)(36860700001)(4326008)(70586007)(8676002)(70206006)(54906003)(44832011)(8936002)(426003)(316002)(5660300002)(1076003)(26005)(7696005)(356005)(2906002)(40460700003)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:08:17.3722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf45a73b-2f01-4281-864e-08da1c3a12be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
Cc: luben.tuikov@amd.com, evan.quan@amd.com,
 Darren Powell <darren.powell@amd.com>, andrey.grodzovsky@amd.com,
 pmenzel@molgen.mpg.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Contrary to the smu_cmn_send_smc_msg_with_param documentation, two
cases exist where messages are silently dropped with no error returned
to the caller. These cases occur in unusual situations where either:
 1. the message target is a virtual GPU, or
 2. a PCI recovery is underway and the HW is not yet in sync with the SW

For more details see
 commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
 commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW state")

(v2)
  Reworked with suggestions from Luben & Paul

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b8d0c70ff668..8008ae5508e6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -356,9 +356,11 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
  * completion of the command, and return back a value from the SMU in
  * @read_arg pointer.
  *
- * Return 0 on success, -errno on error, if we weren't able to send
- * the message or if the message completed with some kind of
- * error. See __smu_cmn_reg2errno() for details of the -errno.
+ * Return 0 on success, -errno when a problem is encountered sending
+ * message or receiving reply. If there is a PCI bus recovery or
+ * the destination is a virtual GPU, the message is simply dropped and
+ * success is also returned.
+ * See __smu_cmn_reg2errno() for details of the -errno.
  *
  * If we weren't able to send the message to the SMU, we also print
  * the error to the standard log.

base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7
-- 
2.35.1

