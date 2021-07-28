Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E605C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 15:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD7060EB9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 15:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBD7060EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866E56E09C;
	Wed, 28 Jul 2021 15:17:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAF46E09C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 15:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY3/hKA6YhI+rs/l8y87IMpw+NhKu/Q6OJVzOAp1eh6Q7zncELBry92iyhljo/YyhRdWpg6m1J8l/A+GVGBR8UgjbOyCGVHeo691Qejqd6i5FK85Tw9WjtFbg3pUi2BKBidNWwMnBDuRSd7/PeWW1l1xI86fIL34nYEom+lY8i3AIzdOTrJyXKLFe6aghGQXnrl0yDKehTSnv3IJ0bbaeesDaJDw38ad2fevUoYzyYyRBEEE56UZzt/jfkizmXnr2AopLlwm+rHpdegRXc4/XDMUVeILhJIbQprKfq+/PUPwYPAZppaedlnO8s7WTXx1DWDXQQnhSt1nPQu/WsqmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+RBAySRhRmgig2Otc+laAaezhC3P9QJTLwPdpD2Y18=;
 b=Eoi+Yp0uEsZGU1YIPCHtNhPvuSgi3PNlwUD3ykyqJrq7+iwTYstPE31nZByCnWY3nD8s3QQec/K9xLa+WKWa5oG4aDv+suI18R+/AiCWZxvMrnhol/+JJqoiusthTd1CIP2tyBntBT0/oUTa/Euot1kGtSLDR6jpMBwdrptcLnnIeViM7tXi9GX9ngjGmBwuFAdGfNZhuZHHMrOQh0bZqyYWZ59s++xDZYsOOY3ivQJQvZOWFkjl4Iql3YKEihX779kHF2cyHEpl/s0V0Rq1ZFFqnMxeJegUMj5IdNOQ9amly+bDNdnFaTdSKnIsZd6XI2AlZj1vIg3LmI4RGT1qKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+RBAySRhRmgig2Otc+laAaezhC3P9QJTLwPdpD2Y18=;
 b=dMFNIy3yt6uZfb55VY/TxsZ8EIFru1iks9mDbKvgLiEWc7+kk+VgG8o0wbP2fmmPGsBzyT84n/78IUffDuuiR9Fdq/TwzyaymhRV2ZXGDuptxUoikp6Ns3Z9BGU/BcjdO5JWfQSxEmkbdelNw0biwGltuRSRvnv4LG+/QdQT5fw=
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by BN8PR12MB3620.namprd12.prod.outlook.com (2603:10b6:408:49::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Wed, 28 Jul
 2021 15:17:55 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::2f) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend
 Transport; Wed, 28 Jul 2021 15:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 15:17:54 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 28 Jul 2021 10:17:53 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix a bug in semaphore double-lock
Date: Wed, 28 Jul 2021 11:17:40 -0400
Message-ID: <20210728151740.100794-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14dbcc89-99f5-4d3c-dc3b-08d951dadf8d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3620:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3620C97AD9BAAC1E2C393A4499EA9@BN8PR12MB3620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIRW8CEXIZpbMcbXMNRmD4ONyujFEBR300Zy54s4Th9Zd2rXsqsMBGi0MysApP3zZOtgDw8P1Is37QSGP/AsbRUQFyPAlG86QbEv/s3dPj/uGlDjRLd521iWDp7cQoU3DKXirl2st5MlK0LdoRphWStN3HyYhuh6dcqr4e7gm4QHd2fYd1Sr3ExOXMqQeUker7CWxvqVCzYbVEcOKV3zICLjKWgNpsPEfY6UnzVqQdgz5l+s+Is3C+91Ix5vC5OTunmT6TDf1b/xBWeUFLf5K0FHLVPO5bNkZdK1hLy157pqlR/QOGpmZCOhdA2DdlGtHSCYzjXr/fwckU4I5wonP7V2qiPW20sJcekk5aywYuLr7qnG9TqwsrSDf9U8XctHJHfehufmReGF2/XjzdqrwoJs5eSTHl8PRak5bJmJ2BagN/G8ETo0z4oNn02LQCF32zxPHY+LpFHeylRU4WVAMHtHjH7RNUCqb3JFPu+ra3NaehYG+E3TENh51jd4Dc4n1OwQ5lQErp6YaMpGnNk7dlPXfbMd8qn4szwJQghSKIpepDtusWxiecgKvVVAJLd+XKDnlxiX8pTosmm3WZdsop4/A+zOeoVEeoB08Kkm2OSD0ZkJUInlrbelpvB11j2iBoFTeIM5fZqgOqLt3COZt8XgE2f7GmzguEJR08XhDNh3J+T6chirveN2znNyFNyDP7EKw2ot42EjY+VrJxjxmro+h6E95nOWtyeY5EbYYBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(46966006)(336012)(86362001)(70586007)(1076003)(36860700001)(7696005)(70206006)(36756003)(6916009)(83380400001)(44832011)(82310400003)(8676002)(16526019)(8936002)(2616005)(2906002)(82740400003)(316002)(26005)(47076005)(478600001)(186003)(356005)(5660300002)(81166007)(6666004)(54906003)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 15:17:54.3453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dbcc89-99f5-4d3c-dc3b-08d951dadf8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3620
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
 Luben Tuikov <luben.tuikov@amd.com>, Huang Rui <ray.huang@amd.com>,
 Changfeng Zhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a bug in smu_cmn_send_msg_without_waiting() in
that this function does not need to take the
smu->message_lock mutex in order to send a message
down to the SMU. The mutex is acquired by the
caller of this function instead.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Changfeng Zhu <Changfeng.Zhu@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Fixes: e070ba49f3a764 ("drm/amd/pm: Fix a bug communicating with the SMU (v5)")
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a0e2111eb7838c..415be74df28c7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -259,7 +259,6 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	if (smu->adev->no_hw_access)
 		return 0;
 
-	mutex_lock(&smu->message_lock);
 	reg = __smu_cmn_poll_stat(smu);
 	res = __smu_cmn_reg2errno(smu, reg);
 	if (reg == SMU_RESP_NONE ||
@@ -269,7 +268,6 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 	__smu_cmn_send_msg(smu, msg_index, param);
 	res = 0;
 Out:
-	mutex_unlock(&smu->message_lock);
 	return res;
 }
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
