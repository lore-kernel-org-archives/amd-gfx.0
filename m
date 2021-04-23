Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF39C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA891613F5
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA891613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E5D6EB2B;
	Fri, 23 Apr 2021 02:40:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4386C6EB2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS55xjtgq/sKnAeRgsTtrUX/6L5LdKG9QeY4ZkiubsGt43GgIvqYW3zOLeNt6qID83zXq2nYdXreJI7NshGEU2J4vsC9Jd3CdLUpZVQb8saYM3K3guZY3dbZYgjeE25foGPSuJ01fqZC+bjzA8MazTbSO5CW/ZF3qbdBfkt9uYjx7CX5r3dDhdyD4lC0cyrrZQSFK+e5NBifVxS3V80qrD+PesKz+AFUJX6G9t3nnnD8n1inzXfOm4je9mzAurfhlnP+YyI4ATCE2Jak1LfruGeKvMZuDcFI1TMTiUYJuZ4qQ4qiivQvIo6BM5SjZ2N/OXNybqniMX3+MIrb1E0xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H1JvANKlsQTRIyyEDA0qjXSo6wh0dsayO/BUGJV9VQ=;
 b=AumFfFxqlrcWLkM3Z1DxCJBhJSs4vn+Nw2/1xXtD3K5uiUwdps1aQsXyBOkH4r2LpHyUXIMj4o6JfXrpqQY8QD8Lmtj/AMPppOD3YYi6ioWQnoXvZpN58eLbdNxZkkBGgEbyP/USq+fAQQ3bObA3tYCLJj8mVZZ322FEzQA2biaHn3+ybIcdsV/ICCwg2ys3RypfTX4zxmBAokiPWLyzwX240CrCdLrjEh5fumAIYaZpT0VFIAO1K9m84x3imeN2pyZoEBZyJxgjHqknDACcNp/JqnxmvzTscQz2hDPp2kZ2FSTfpsN5lvv5sXQjHiMcyBf/BWCRnYIFg7UgmcODbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H1JvANKlsQTRIyyEDA0qjXSo6wh0dsayO/BUGJV9VQ=;
 b=kB3F8IqYkTa/uBHrBOqXguUBHTF0049u4dBjfgGJ5Qwlo8tqoVlQ7VbprfQ9fZUaTBrL+RD9V5S4AAV/zMLQNQzP2K7MQ92Cv8ob2EwsBrxZDV3IcRcxSw2RnweB7NtvWF0/mcpwR33N1BnicBle0Is6oamx3sb9UkZsYR3oYAU=
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by BYAPR12MB3446.namprd12.prod.outlook.com (2603:10b6:a03:d7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 23 Apr
 2021 02:40:31 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::1a) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:31 +0000
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
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:29 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:27 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: fix wrong statement in mst hpd debugfs
Date: Fri, 23 Apr 2021 10:37:09 +0800
Message-ID: <20210423023714.22044-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d631ebec-3d90-4daf-d78f-08d90601297d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3446:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3446975680531E7BDCB93FA4FC459@BYAPR12MB3446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5l9k/UC7l51hvExj6Fc2yqJMEnUceMWwuTXmeYoRckv0pi3W1UN9F67cFc7iEMFcghfNgr8B/F5ql0wdV2T0Fhle8A+Cy4SUZGJI4lOebZHNt8oMqw0BfFryhrCawAHQS9zzF8RFYd/I8ZtFs4WbSP50tX5nHflQyBeGP3ZyFov8cy3Ot4uc7ARDIGJ9RW+5RzyZwIDKJRE4oWZkPG0dPdVxIIA4uHSiimnOun+4UVD8z7JxVlxi5vp4+unmNsbd5N1heFLvZACrG2S80Ad+udqETbuWUOBGe4p5VL8fHr7g3+wLHCCE05rWsQ0atqg29ymhtYGpICgW2iHDosJUKSHoRw7M/GXl7vP1IoD25yHEpmvLqEoahs5v81qI4fiEN+jE5NGHz9TKnqZdb165+PuBa0d9rIqI1jytkBhXNwePpugv3L1p8iK+kMZjQOsDi19ab7CBzGyeGj2XKIV9c2cXNcR9A0W2mOpcOsxRnX6DbFqJIhsDRIg7QcRRbboJU5ruklBjG4pN7oV/2vdZ6rzxc6AWKAaUL/4BbKvskAt5UoOsDJ7J5325Dt5mgP+AmqDJSCcc2R17MAswpXgT9kGSfxSl7/qwVOuqsy2z3KD5Lv56PTJF8h6Jmtz9mVEII7Bx9F2cisCkxld+OaOMZ7cT6l760V6zpEkNppVxH5KpkInNTMDAyDcya++n2Qa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(86362001)(5660300002)(54906003)(6666004)(186003)(478600001)(70206006)(316002)(83380400001)(336012)(356005)(26005)(8676002)(70586007)(426003)(82740400003)(36860700001)(81166007)(7696005)(6916009)(47076005)(4326008)(2616005)(8936002)(36756003)(82310400003)(2906002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:30.8963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d631ebec-3d90-4daf-d78f-08d90601297d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3446
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Previous statement would always evaluate to true
making it meaningless
[how]
Just check if a connector is MST by checking if its port exists.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 656bc8f00a42..8bf0b566612b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3030,7 +3030,7 @@ static int trigger_hpd_mst_set(void *data, u64 val)
 			if (!aconnector->dc_link)
 				continue;
 
-			if (!(aconnector->port && &aconnector->mst_port->mst_mgr))
+			if (!aconnector->mst_port)
 				continue;
 
 			link = aconnector->dc_link;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
