Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BEBC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A8460FE7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0A8460FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D05A6F39F;
	Fri, 30 Jul 2021 02:40:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FD26F39F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 02:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx0nqaPMOWL1nxuD/JIbeyzM18XpsGYUT+wsRTFFwbF1M/+FpdAzXrdRjd6HdZBFHbqwLtmz3al/Y0STfavWFU7E0kXYiaJcgP1symgTeyWDpaT+zFythbFx1tSE7gh/QRzmQkQjC0sdFr/zEypGbgdPnmhtzsLiNuIxut6ZNYEWsZunE7PYnqoCwkq20YnY3SzTaEgyE8qG11IzLOlBaa9tsGhBMvnN5/hl2qxAJ/pHmfX0H7wHRC/Iwmkok/izPFZrubO/tkS92HKhFnQBfIHL4GgjycSCP6r5X3gKonNE7gTfL0pvARhyb0ZmyjcoYMqEu3J/kmSetI/VeUoFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4cH1h3mAH1sOIa7LERWF9LZprUIjL1O4J3fM6sSMjE=;
 b=ErUFzz8kTivZ6r7tPhgSiAz7quuG6Rie9chkV195cjTCSvVgcdFeiEjw26Fjz1wsp4nc4x36mM5NhNal8iVU+ZrNyxKi4dBPkwLBtt0EPi7FIUUh9z10MqgMBl+sqArbKeMGoD5HBkSmIpVLSzOJHOHWWbMv1gYX7QdJS0tOzJTVXdhQLsCk3HYdH0SDlXx0MLGdhSRoPSf+S2clD2wRwclEpCRRD308CM4qEZMmNRoOf4QIvidAla6ba7L9R6Ul0kLTM4Wb1AKUNXiZyOyoQyPK/8Gjzreb8YfHVx6WJkSJU0H01F9V8GYMbQxffU6K2LV/Cih11vHpA46BdEFlRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4cH1h3mAH1sOIa7LERWF9LZprUIjL1O4J3fM6sSMjE=;
 b=goBYqApOB51dkRMpSVastto65F33wGJ9G3H1+IxKDrt4iayny+tzfCOr+mXY8ehzMdAz/NOzQKXI26V/SpFZ1UPR9CGWbqSIVQ0GsBBDqiQUZyEIZmVX0wFhcqTNitX37QoJaUOxvIrje+zWI3E0bIBGElHYkEgcrxzz9hLZQkE=
Received: from BN6PR2001CA0042.namprd20.prod.outlook.com
 (2603:10b6:405:16::28) by BYAPR12MB3206.namprd12.prod.outlook.com
 (2603:10b6:a03:130::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 02:40:46 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::dd) by BN6PR2001CA0042.outlook.office365.com
 (2603:10b6:405:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Fri, 30 Jul 2021 02:40:46 +0000
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
 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 02:40:45 +0000
Received: from code-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 21:40:43 -0500
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update yellow carp pmfw interface version
Date: Fri, 30 Jul 2021 10:40:18 +0800
Message-ID: <20210730024018.4356-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b28c53a7-8c6d-4bac-2fc9-08d953036e93
X-MS-TrafficTypeDiagnostic: BYAPR12MB3206:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3206968E4CDE06A75B61826C9FEC9@BYAPR12MB3206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9I8oCrPBvmlFpaVdiyYdvYw3zWw4tLczsPaN6xgMKH8VbTjDrk/tD4HT2hvX2QN0Ei4NE6opNng1XmmqfltNpGrLzaM6+QaDCgYoR3jVbvKZx8LQv6oRDJI+nR24fa4WbOIRvPLrb93QO0hbDJtrEgeUjbg5LqRNG+eJHxJzE4CSZubywHv3Mq1Bcfh3IBKgZYkYt0iIoKHDTco2JInL4xSQ2H8DuffjiHM4MzZ4nmM/1IdrcgWzhlyhEFJhcMXI7N3nHj7Cg+gtfnpx2ysXoPo4HfW6j2BaO9jYKOo+I1WLQDX3TnjgumI9Jue43NoLYEjq5yFd7X7L4vX8WQPx4+Zswg9HIKlo4n+8kZhEeaLb6WRToiLuSbSM7yU0MEol168fpWP09UWRbTrhvq6DkpSn/TLiQQ21QZkyRgspJVbVEGuEvhZ0Z+M3XxjwcK6tz9A0NgQZb/rtJFLOsjrbAEp2HTGjQNyHVmEzRl7wryehd6ILEksIR4YQi3GuV5ZTr0t6vkTfnDSmg1FWRIv5Xtx6idvvXYxcRm5TFrN2nH54yHK1d4G2z5DRKkb4KILiNt0Dv+rz8b0V0+He0aWRb99t12iTISrywHtaCuD6m74qEMkTVswveUTeXbfyEy5qcbozsOEh3RDQZo1m9wtyH1WdpXuIIU7IIU9GurWVgFUJhvo7vXaGwG8311wDqc5+baWsK509WAPOJ5T8FaCBcPmPXp3ZZvoEsYSq9YX2es=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(26005)(2616005)(1076003)(36860700001)(426003)(6666004)(7696005)(86362001)(4326008)(82310400003)(4744005)(36756003)(5660300002)(316002)(81166007)(70586007)(54906003)(356005)(336012)(83380400001)(8936002)(16526019)(47076005)(186003)(478600001)(2906002)(8676002)(70206006)(6916009)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 02:40:45.4353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28c53a7-8c6d-4bac-2fc9-08d953036e93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3206
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Aaron.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct yellow carp driver-PMFW interface version to v4.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index 3fea2430dec0..dc91eb608791 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -26,7 +26,7 @@
 #include "amdgpu_smu.h"
 
 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x03
+#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x07
 
 /* MP Apertures */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
