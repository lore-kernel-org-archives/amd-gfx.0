Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA841C636C9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FFE613C1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FFE613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6706E6E8D8;
	Fri, 16 Jul 2021 01:25:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A126E8D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVt0AqVSspsVJ/6KUlpFIHUjQsyMFaA3zV7JVcA7lGUcFLJHCxy5QYBUleh7LgtsXIVTxCfeg1a3wZopdtCAz6REAu/yvesowLV7HzYM8XXLYhu8bmPZULbSdcS4niU38YdaFMyLlVwuv7vktUC7aaA+jAAmDRTJBfXPjajmp3hVcNCoEZrLFosQh/910/LWRfAvoO8pLgtyXDZT9NmSEBEGTI6m6Cc71x2vxUn8PlZ8ydI9mxMmX0ndEe9FUMM95QvsENTfMGO5IjDdJXff3SAGx0haB5QUFnWPXxNpDa5BAv5QhHIOhZU6Gk4vZvoVV/iqJuRIFnYIxBAYiU97ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSo4f0Y2IlscCPmjHPvotxeKbnfNPdbS6C+Yoyj9r8E=;
 b=BEiKZhgu1lHzrCg2N3aep1MMp37ggbPfGFsNiEkcyN6vS78tjprr2gKPTPTu8KX8XkNYGw6iKJ8HBorjyVQUUdHeTnmKdxquqPQ8IYI3f72nbhgdgnaqZN5CujkdfpWTSPLvZss/kHsmxz+TiMKuWfYjlYW38rhKk0AEs4UfpTo1Ul5WD6jtTiSSZ+K1Zwvj9ZwB3awe4ib0klQRdcyud00s9b21BDb6gCkPijnuGw2L6oNjbY5IxT1GV1VCvWiPvcnYvgLDdQccCVUim9Wln+grM+Wpq7fYTpljaTbp1FSU37kGL5dBbW48dJBj2K9epregSMP+BhLEIfANn0wMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSo4f0Y2IlscCPmjHPvotxeKbnfNPdbS6C+Yoyj9r8E=;
 b=x2p7XkSqWQuuIj/4fK+0ag3nvhbqMDfXGAQQEtj9Ob8HiRemPaxasB6oK6XeTIAtOjwoTGFpDCPIA0qM9lrXxzzsguAzFcdcL8TvuPjRit4QaTGH2FMQo2pPvVCA3f08/4/47U1YpPX1/+tbYPmWd2OLn0Fa72GxzC8DPPy1gdg=
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by MWHPR1201MB0256.namprd12.prod.outlook.com (2603:10b6:301:53::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Fri, 16 Jul
 2021 01:25:27 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::eb) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 01:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:25:26 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:25:24 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdkfd: Set priv_queue to NULL after it is freed
Date: Thu, 15 Jul 2021 20:25:14 -0500
Message-ID: <1626398715-6419-5-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
References: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5094b32-9ed9-4aab-7d39-08d947f89753
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0256:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB025676CA3D2B3F83CBCF6CC480119@MWHPR1201MB0256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbfz+wPyO0ngYFoP78M80+CtHO4ugsfZovgEda2fXXIFzsOILI+xVc0W5R2JMdGNTsaXvQ7I/A5aiOPfrSO7cdp4rhwtiIEFwS+VRnWy6LNOif0HfQGEk+J0l0kWVAGa5nd4DbWSTtE5Lk9+wFoTCkqdLbR/RsEEc0XcrLoDC/CP8qtBcKIeblrzRegBi480t9HBg7C9x8eoD0r871GZIHWe7t7s3MmvIkyiXMp9wBTEPo2hIPhFyPjS9Nyo0rg3vUZQm8HUSEM+mc+RuiAnpxV1FWtLsKMViBm3YX1idOZTH6/vZeeqHy4hfGqgrZy3XEns9SiAVsSRRze7+zVQPhP0hVgB9WUhbnl5otkw1ekMTn6YTHiF8J73pkqvXhpi+qK0cQNyuCpK53+c4Eo72GY+n/ETT0VU7REpUeBpPY2JTZ4XpfD7oCw5/z57CW0JEvYDxMHFFJHoNNvCOioAoXdgTj2Yeh16QQQd3AJ88Op31RoKThLFlaSRVFTk+QxWRWvDl9wNh4Pk0t6nbxFHQVspKR+J1SyHwa4N4aKzwDSfU9rRQr+4V+5L3KqqA8lOJClc0MmDcpOKeiUgtNDKPK81VBwQ2DNYmncPnlfYumvueRVd3FaxGstPoBlifIMMS2Ed0tHzelSIVcRg+7TatbhMVbOMDg30vQTHAN6SFXHHtBaTKhxDfhMt6zsdIobJDyK9aZ/pyr9L2l7xGdyS5bFaRlMCM6IkK8odOmWF55w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(81166007)(36860700001)(47076005)(82310400003)(426003)(6916009)(8676002)(356005)(336012)(4744005)(2616005)(7696005)(83380400001)(86362001)(5660300002)(6666004)(186003)(70586007)(16526019)(70206006)(8936002)(82740400003)(4326008)(316002)(478600001)(36756003)(54906003)(2906002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:25:26.5408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5094b32-9ed9-4aab-7d39-08d947f89753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0256
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This variable will be used to determine whether packet
manager is initialized or not, in a future patch.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index d8e940f..b130cc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -278,6 +278,7 @@ void pm_uninit(struct packet_manager *pm, bool hanging)
 {
 	mutex_destroy(&pm->lock);
 	kernel_queue_uninit(pm->priv_queue, hanging);
+	pm->priv_queue = NULL;
 }
 
 int pm_send_set_resources(struct packet_manager *pm,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
