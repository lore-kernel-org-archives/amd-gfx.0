Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E049C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 15:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EBA6103A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 15:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66EBA6103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C9A6E41A;
	Thu, 12 Aug 2021 15:07:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A736E41A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 15:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHSRjCHJyyv2egiLyOrZIjcel5Tf5xDSt/Iakqe7sBkvAnxnNN1Oln72fr8N41E4CJW7opHZNjxL6SeGyAI2Ffj8yRy4akbGy0cpqaoqePwU6MOztjXrjR1lYlzMIlkl+lYMNsZCbcGmzkkebijWCYvLo1zDW4SHF0YIPTxFf9daQoEuQLvUWT6doSvppqYMDTvwqXfQCxDPWGE0j3Tdg1J9x5MQ1RP9ZtYpBCrqTQdeoaSYi7Tos7JcAxmBtfQ4gZS4gL7OHFGsjCBSxgNapcF7ZDU4fCxNJlAiUAlcp+ezzKCnwqyo81l8xpi++heVMtLYr5Ggiuw/onv0Ox+ZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fktkEfGRH7gbg7qPchp6I7Q6n7hjzh6veKxAHbMPFL0=;
 b=gdpGOyyZivY8CS5af+9cqBHqntAILEXm4aGRm6dYp/GWBZIFPBn1rP/SbySNevCUl4QtzJ4hqC1fnspjGCaOvZjOT/69Hk9AE7pRvJUyVyDmzVnMkr3C3D2baeC1P3VE0q9Je7o3fRy94k/bc+5fM/yhpi2zlI/Z/vpTF2ldF3JbnYI15HnILNpNUXFSGQC16cHXJTqP+R/PBUFTaHY7fhKfAdX+QGEOgbxKT4qvnVmnnBHJDvZf1hLYcwdneogeFqm75ixN+b+/uiDiaq+2DCnLTZdaSjkHmtwPMup1IkuJo+CFyAsg9rCD9PmV3zweLD/DqeqDD/1M7xOoyaRHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fktkEfGRH7gbg7qPchp6I7Q6n7hjzh6veKxAHbMPFL0=;
 b=E1qp3PtccX7mgeD2Ik/Bwa0CgzqRB34ASGfqW5v9oBTaHoej+qvvQgHnmM8kqPKhTlq2F/hKc/bH9Dt1VyptparwPW4RcGyMMQNPZuQrAkj1HjUj1KL+dArlXshMrbtyulKiomDnaAbVhfCUkcRfxmFiMT/uG4inUQlPogG2vxI=
Received: from DM6PR12CA0029.namprd12.prod.outlook.com (2603:10b6:5:1c0::42)
 by BN6PR12MB1361.namprd12.prod.outlook.com (2603:10b6:404:18::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Thu, 12 Aug
 2021 15:07:48 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::8d) by DM6PR12CA0029.outlook.office365.com
 (2603:10b6:5:1c0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Thu, 12 Aug 2021 15:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 15:07:47 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 10:07:46 -0500
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH] drm/amdgpu: correct MMSCH version
Date: Thu, 12 Aug 2021 11:07:18 -0400
Message-ID: <20210812150718.8827-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c0e9080-7737-40e9-3956-08d95da2f237
X-MS-TrafficTypeDiagnostic: BN6PR12MB1361:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13611CD24555C0FF0E872AEBF1F99@BN6PR12MB1361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wkKn82Galbcvf8so00KAXW41ZsIbUU/lkgzSaM1BwNQQlr6GxJPdfoiDcVZ87HrISQcRRwJVncBDU1FsrAxsP79hr0IrK+WUf/5xkEW8dqDTJ5doZQqABlNWPZ/T4Rqk24lJwVnHCPl7E+rlG/PKo0mp28WV5sWjQ/ICvzXh8jcb8YogmEAQOTNnzpTWO/bsiPni6zQFDhMkxbL1N9Bc4k1P1SuVzEOYjC4joqKVGpHRiYtIteNCj61PAVZvA0YadVqa1iIGqLdYkg77rAT1QZJuWLheiB4sqZHts8VLFqMmE0QQQoJangdHPgw4OnDwkiHyW62N3S9Xo3piV43PbU8fkMbpakqG+MJcIXw+uNpEVt7Zc9TSb8HhnkJffkeIU1dnIkPfDOSDuwYlTYHWDMu2gqeVEY1TbyUqODIOFp/UrbraRoPczVSIDxhZ5SkaAGPtgFQBQ9sbdA5YlkJIjVIAgM7A/IPsM57XsN8fWfKVOCylK28ZKJhr+g1Q0AnVqYgc2aEVfLTyRCjN0wK2R6G1Tr22ShgAHGWNvWp+UQKRWPLnOz23UNEFmBGI5VXSOPOoQPg1mSUi8+YtgWZMtt9qTWr9RmZhK7zt9mfteXruvi2ceSBPKQof5ZkD6gXgEo1hRg8teJFUWf6bPnhUhhdjyBmCNCkfXHenl7bqKsBZ3qNFkn/GCvvT3afMrr40Rs6AVKC6uX+vuVWIWWDMS1BfDaxcdNf3r1oB/PR9M1ONlqrH9mwkp9TK09SW5K1xzn4ToyGtw2bHBvEFFHETA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(46966006)(2616005)(6916009)(81166007)(82740400003)(478600001)(1076003)(44832011)(86362001)(36756003)(316002)(47076005)(336012)(16526019)(83380400001)(4744005)(356005)(70586007)(36860700001)(4326008)(426003)(34020700004)(6666004)(5660300002)(70206006)(2906002)(82310400003)(186003)(26005)(8676002)(7696005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 15:07:47.8546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0e9080-7737-40e9-3956-08d95da2f237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1361
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

MMSCH doesn't have major/minor version, only verison.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
index 20958639b601..2cdab8062c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
@@ -24,9 +24,7 @@
 #ifndef __MMSCH_V1_0_H__
 #define __MMSCH_V1_0_H__
 
-#define MMSCH_VERSION_MAJOR	1
-#define MMSCH_VERSION_MINOR	0
-#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+#define MMSCH_VERSION	0x1
 
 enum mmsch_v1_0_command_type {
 	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
-- 
2.17.1

