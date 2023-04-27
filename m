Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFCDC77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 07:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F9910EAB9;
	Thu, 27 Apr 2023 07:17:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E2810EABB
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 07:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ6yjEr/qEvXKTan40uIndqoNo2+LHzqWwD3ZjLp+Vwdfv/dMkM0T1c/US7qqGgOWW7EX9H54kw8+fFeA+2aA8r2MvugCxG8PO0Xh4SGFyrl6/7eUZNjSDb/NUlKghcPHscgHiE2riMjFe9UDFPhiViyqo+9P0elJvrACeL2oS3I2VPeP1AOwIuvEssdyHDu2HP+TVPuT6GLh5F6zYg8i+nAWEyz67qwmUbi2h8MSaMAwK38zh0YHclu1yesb6HRbsnn0yMqE+OQMZ0zuAXUBrAmPYVL6+e/MIJ7kl+1Xsi3M2wsbAFnrCMJJ92NHbWD2z9bOrndSUkGco4eWu03Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGTq34fK8wZ1MjnE+sz3aWikWHuhJthLZTSn0cnKfAc=;
 b=S52+J0LCW/1Trm+WtK1rbSZWu2TLGtnWIWVHmbNKYVSLxLEcn4l+nkVZvrqKtm0CDJiBUPHZ63ggsQK/MpIOfID6zI9QN2iqPYTjIVIU8i8x973B2U/nmEyvksg1X4HJtPpY9JgPG5EX3+UrgkkH8jRNTb3VMLtqt7ZVN42I4jRuX4wttJzBqnS0Dj2ecchZtWShvyHQ26+DzeA5L9W2jy7vf8+/ud3jdg0IrtQV8aa4feCArtAbJ8Olpc9ONA4mB4BLa7dGdWzjwFuPwldWkNPQTOQK5J6uQs8HC85tMobQeRLtUFD8t5u81iHV2vjTvlwVKWJ7PqMLa4jii5mpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGTq34fK8wZ1MjnE+sz3aWikWHuhJthLZTSn0cnKfAc=;
 b=TXFiStabmhQU+Yw+JkftOZoKi/ZpeNcAjiITUNZMzGwqRJm5o/B5VadEL5nxHWW+qzlmWvazRQCfQqH4Vl8Slin4shLREyqplTQXXdvCrRDz1X1ZmaIe0QEE9hdU8QkflKMeY4//dpXb1OtNbT46i5Qdgn/FG9/UpCq3xyuPL0c=
Received: from MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 07:17:08 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::4a) by MW4PR03CA0235.outlook.office365.com
 (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 07:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 07:17:06 +0000
Received: from jenkins-vm2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 02:17:02 -0500
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove pasid_src field from IV entry
Date: Thu, 27 Apr 2023 15:16:34 +0800
Message-ID: <20230427071634.1484586-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: d73fffb5-5bdf-4dda-e74b-08db46ef68bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYTkXKIq/GJ+0eSgNKRaIbE2DcW+NHz0gPgl7YJoUIWIydS4EZOle7VzcRq02dubw0MX1buJPdVAZf7sxJB1GYFFbySBvzkQ82Yw85SaZS7/NboUNDvox6jGiWgClUXw5HDMh9V7Bcudl2RhvdV34QwefxZZ597tYlWawn1sGSfAIxdecoZcoWL1dYo/Iu5bPO/695FMGMT+3eFE3sVLjCkGE6twpEojWIbQRNM+El2T1Svv+2kGjssOfdgp36bMhQCZZwpfAH6hpjI4tAdMVE+ZZEYMNnYvgT7XvTSNGsfNYs/dmJ/2oyTidlTLZQX7dT6GB1kmBDzp8zEtzKp0tNJVVrdZyqJ7aky2voQso4BI4Xy9RuRlE5sLRR/Wv+tCpkZzAe5QL2T+KhayeY0Jhlv9aGygjY7P9I827IeVv/M4HeMoxWVoPPMxpm2Dv4RIO7Y596iLDyXoWhAOG+fxHMtbv8zmjTkFwdbKC4eQFA4V1MMJwRwNzM9/+HLDDoqLxLFvxW5ocnp4vmBk5l9dVaPuCA3SWUhXOeed2Q94pypxS2ZMAnwQfeRNqPv+dRr4QpW9MdOmXqpZCxX79WEbrE4e02b9A5ip7Ueagic8dLHuhqtPbBgC5qmHLqCLTvItIxX0Lq/95YPrDEiaSYf5+kiC3tQMMEC/MF+/PW2w/jggyBp6PQDUzTL5nY850W8sCX07YzOJHuPE6WQgbcWZ/QF1wP2zhyY//OQ2wPVQA7c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(47076005)(82310400005)(86362001)(36756003)(2906002)(40480700001)(6666004)(7696005)(36860700001)(16526019)(2616005)(336012)(426003)(186003)(83380400001)(26005)(1076003)(70206006)(70586007)(478600001)(4326008)(316002)(40460700003)(81166007)(82740400003)(5660300002)(6916009)(356005)(54906003)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 07:17:06.9561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73fffb5-5bdf-4dda-e74b-08db46ef68bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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
Cc: Alexander.Deucher@amd.com, ruili.ji@amd.com,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PASID_SRC is not actually present in the Interrupt Packet, the field is
taken as reserved bits now. So remove it from IV entry to avoid misuse.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index d58353c89e59..fceb3b384955 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -271,7 +271,6 @@ void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 	entry->timestamp_src = dw[2] >> 31;
 	entry->pasid = dw[3] & 0xffff;
 	entry->node_id = (dw[3] >> 16) & 0xff;
-	entry->pasid_src = dw[3] >> 31;
 	entry->src_data[0] = dw[4];
 	entry->src_data[1] = dw[5];
 	entry->src_data[2] = dw[6];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index 7a8e686bdd41..1c747ac4129a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -54,7 +54,6 @@ struct amdgpu_iv_entry {
 	unsigned timestamp_src;
 	unsigned pasid;
 	unsigned node_id;
-	unsigned pasid_src;
 	unsigned src_data[AMDGPU_IRQ_SRC_DATA_MAX_SIZE_DW];
 	const uint32_t *iv_entry;
 };
-- 
2.25.1

