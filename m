Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB85FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 06:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BB610F745;
	Fri, 28 Jan 2022 06:40:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0DA10F743
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 06:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddq0Cnb78dsdTofW2OyVpXxbhSpmyYjIVRZ5Dlh4FG3ADRS8c3BLAieIfvScBSIFUWOkUbnl0XwCWVXegf3Oo17XeO1zXQLMPgPYsgaQjH5+WjFn09Awv5QB/O8szYdAMi+7uBQ9gsD6xyWpyiTCK2l3dkXPFJCs3F2i5W1NnAus7DCBM+KeI2VPZEDrwhDXwV1WuLkdaLFybrPRlDk6TnhXPy8xeC296LSnxVUb6+lZM65FRv5uEkH0MWnGQUoDZmCyRxmro44hgNyUysstyaBKNE+yFB0KNdOzRDZonUiyWkYsWMeKeteMD/Hllpy9LkGPkmR/T6Yzii5AcMSo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wigVDc28KOF5nHC1DnGEUt59RZhgkqaOtxRTdCvFuM=;
 b=M0xN7vN3EQLE5aLHsrwzg6QdDRmysmc2dFA20eguChqpZX8rQc/w/bHPcCqkF7rTR460UZ4aOLqiD/TCIfFjeg1dmsScP8ZoLOQrG+6QOvALACVJ0xHFfJrmiWpaUn/v9TpWgHwqXpurMYMLYLvrsETcnBwJs2nOBhdAJucwNhUbZj+4HymJPUdXEei9tu4qt5mzFEua614V5b4mytfp1FkYKApb5td3YzP0iKPRMqp4BL9HcHTRv9JW8FMgmVFBT5MZJ+uWyQm3XA90RRkwRP6LOmFQ2PdyLaBT1KcKJGBqWSVv418Tw3IM/UzMb5cQdJ9IMNRoIVO4pvigOOAX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wigVDc28KOF5nHC1DnGEUt59RZhgkqaOtxRTdCvFuM=;
 b=3mTwqMSeHJNNizif4+3UVR2WlQqOU1dtNa81dmsJDQcVjwL1IPebM/HxwDvaUD6VbV9H/CUyuKwI/oEo+bYP3GGpwqoOTY9wZ01syf3PwJA6o2cXNxzhxrBPXtMIoMjN72jjpllwKKPU7rDiBnyeMdCIG8ZJeEufERvroi6PAB4=
Received: from BN0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:408:ec::20)
 by BYAPR12MB2677.namprd12.prod.outlook.com (2603:10b6:a03:69::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Fri, 28 Jan
 2022 06:40:39 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::95) by BN0PR04CA0105.outlook.office365.com
 (2603:10b6:408:ec::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 06:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 06:40:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 00:40:36 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix uninitialized variable use warning
Date: Fri, 28 Jan 2022 12:10:19 +0530
Message-ID: <20220128064019.2469388-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abd3cc15-f7fe-49ab-f284-08d9e2291883
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2677CA46CEFD5D91CC0767CE97229@BYAPR12MB2677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1IyhDRLb8cM8iwIZe1q6PQXo+23wVL3famRTNexxoMa8THaE2nCxbjoeFwxbsRjXL4BOvWkmKZN1jgxEHFpjoU73DyuJG8o0LIff9P6n0WsyxUU1yEvZNoNp6+TgKnHAdbJne3wXslK2xkzHr+7FH00TcfFuOM9vDpQ3Tv6eroJiIqnzEYz+FWugqAxfw8uqX5lJrDRPhImVboeUFl7kjS8K75yl07unx+RP3kNfkbxrKghDIdy5P4CbU9rbHGca3dUOHwq6n1tO0N3nC0ZuX/T005LE28ZPjjmdfbSYkP5U8NWWm5o7CnqIMnbcsaLMpjLe/Hy+zaE4qKN0Xx19MCk7CFovN7qCzdBUkvM62YO1Hvdh1lNKXeI7arfAVcT6vHo4tr+SJAwlim88tAYr+puZVZlLP49/ybaEbgDU869EumGASbtleqkhHH2WoHENc2zoWxkK5bUGwoBS1lth7bv22IZ86IwWvp7nu5nPYMdQuwVYcGknIlTeTOYsILmhr+VCuW2Ofl5TBf7Dc2FMoK39w/IGHNI5r3PsedBMJ1xiMiGj3lbc3JOTZMXtZjokSG25W7UOqjDChvM7MoMKKpPTSMxctiphltmyp1wHmKZCTR6WoAzqCifkDJMx/JiJMdySIAwsnbrH9vk8nQjMH4hagwNmFjhcik0rO04ONtFw6h3gGjXrjOyk/spCcl++Exxr2Fz7mFd2pvgQTOU0DxChwD4861sSfzVj86vwin2tdNANewtwpWeJp899AyTuQszFmSV2VxbdALP04YUMs+a2DfkUt67IxLVvnA+7Fc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(54906003)(16526019)(2906002)(2616005)(6666004)(8676002)(82310400004)(4326008)(70586007)(356005)(316002)(36860700001)(426003)(508600001)(336012)(70206006)(26005)(6916009)(5660300002)(83380400001)(8936002)(40460700003)(1076003)(44832011)(7696005)(186003)(47076005)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 06:40:38.1847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd3cc15-f7fe-49ab-f284-08d9e2291883
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
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
Cc: Alexander.Deucher@amd.com, kernel test robot <yujie.liu@intel.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix uninitialized variable use
warning: variable 'reg_access_ctrl' is uninitialized when used here [-Wuninitialized]
     scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;

Fixes: 51263163eb3f("drm/amdgpu: add helper for rlcg indirect reg
access")

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 80c25176c993..c13765218919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -875,6 +875,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 		return 0;
 	}
 
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
 	scratch_reg0 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg0;
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
-- 
2.25.1

