Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D27C636D7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Feb 2023 07:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEE910EAC4;
	Thu, 23 Feb 2023 07:12:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885BB10EAC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Feb 2023 07:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbAGibcHXQv1HfrXi6mQpzykGjQyq9naarW+WIvX31ZwrbWq+t/AFIZtaTozo0Yqow2v5Q1VUzUSxIdKDP59JTnoOGeKhI7vZViPpc9RQPR1b/b3NgSiKoRJ2cmZ+B7Bp5mTnJ9AQZPOpNBGhNVe1lNq8ediBX1jzcEZAIyCmrWIq+IHkzPmDmuo/Wim3zrPtZe7XfPk/hZR6DzPrIqWFCF8R8PHo81EhCHM7P6fFXJDBSehZuQVbdnh0gE4DI7NW26HPdimfkPii4VGwE4RVXmepxAcsgNHVbtlVn4gylOClKdPiNCV7jL9uQVLyHgb4z75sE+oLsWLbj05QAGoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSDGtZjaJ4nUigT6Kb44F/DAs8Fvv9hAejxCNx82ZQE=;
 b=YhDzVDqqUW7X2W+oUS8SFBXQRmhvHVDwiI/HwQzRw+ubMl0pDws+Dg34GZi6kiisYNUgjfA4yD4VgICw0cS+St3FbLMOVGOuaKtFoClcz+ZFDpxqeK0Wo2rOYeji4DXc0XQnwo/ffHGtosltpaEXX06OXb5bTJReQyp7gOZs+lF0S74i/06eUmL0vU/SdLkuEdA3OiU6V6Bm7terT1wtAqc64aH5lg6dHZe9KfsSjd8uqvc8m2V0HhFiiv35PG5oyGpg0YtHFyhA/7Te2u2fb88vjCfTsX3L1ASwwVBgNfj+FbG/88CVk/GR/C5f5II+eajmtUvAcmDczMjquPlB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSDGtZjaJ4nUigT6Kb44F/DAs8Fvv9hAejxCNx82ZQE=;
 b=aAjudc2SqgusHZxo1+GNn7cqfPhc56+mHjwB4DtAjDwtb8elUgC41ex6fSnfTnS8a17zCmCwhPJ+UkrXd4U16a/rNzlE+Tnq8c3atrII2ykcRHYV+heaVdqWMGBonMQogCj9WsYCOEzCFEla44bNviQLaUDZJZaNPRMKE9NdFg0=
Received: from MW4PR03CA0357.namprd03.prod.outlook.com (2603:10b6:303:dc::32)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:219::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 07:12:48 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::c4) by MW4PR03CA0357.outlook.office365.com
 (2603:10b6:303:dc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 07:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Thu, 23 Feb 2023 07:12:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 01:12:47 -0600
Received: from bob-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 23 Feb 2023 01:12:45 -0600
From: bobzhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Guchun.Chen@amd.com>,
 <Flora.Cui@amd.com>, <Yuliang.Shi@amd.com>, <majun@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: fix compilation issue with legacy gcc
Date: Thu, 23 Feb 2023 15:12:44 +0800
Message-ID: <20230223071244.5025-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT100:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cf7cf3-b8e7-4758-76bc-08db156d5e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMdtqWr7F28mwELw29TAuErI/xy+j68WfuHjUmsnMjjfEftpw/QOhQfM+m7dt1UbmrY/3tTv6gkmkRF87Gq0p6k4y0t5fPMrW11goKvBha79Fxnmn5E231pw4UK00hMAjIulST7JhpAD4y4VpgdKVUdPuWO0cT7SlaWDCPOZq/TIpSZdHNMQFyhfKgPbUMzJ0rmZMbGupHSw7J095tm4WjFEgaF+ph/uSkqltOOvBSp7+3lHZyh/3lynYN79mx81MHobfj3ThPVSKMV5aPf+igbo90RNp5TQ0K9ciRYTLyw/ZCVD/5AdM+WMP2LFUWzliQJrE4vvrS84JlPngJjIzP+4SNn5gzVnvWbw9RbR62wM/eFQmqLhg+Ajfv3HgqzAdRqtGUP/iVZVTAPqD6kS+mnl3Op1ggv18dZ69bTsgaYMLG/VYMqdJtOcCUPBYNpBmef3y4QroRd7lY/guBrb1Yz0CnKJ3FsrD2iogAnRQcrUFNb2LiZaPEOQn270JPMfw/XGocJcgtRvEeGeLELlarJIItotgCdVTEO4BTQg+wqcdFYN1oFeU+4t27NcymPtRLLRDWHkaBaRorUNEjEaZgnERaKQ+oQll+ExHKyrp25wmpTVXk9pCmsOe0amPLF8OvJf2mrv9vYptCuezwlDB+H7Qw8mjXvUUxSzsEHePcXQQpG6eYJyxxARv4Rw9+sHT50kSCenHLpvEzcxPkKZSUbwxUmQAOjjBolOgL+ad63cA31b6p4Gu3sNsQK3pYKYhpwrbpO7YhgvJCkAprLxog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(316002)(6636002)(2616005)(8936002)(36860700001)(40480700001)(2906002)(82740400003)(81166007)(356005)(26005)(1076003)(82310400005)(186003)(36756003)(478600001)(110136005)(7696005)(83380400001)(40460700003)(336012)(47076005)(426003)(86362001)(41300700001)(70206006)(70586007)(4326008)(8676002)(5660300002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 07:12:48.2918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cf7cf3-b8e7-4758-76bc-08db156d5e85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
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
Cc: bobzhou <bob.zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is used to fix following compilation issue with legacy gcc
error: ‘for’ loop initial declarations are only allowed in C99 mode
	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {

Signed-off-by: bobzhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 213b43670f23..2331383490ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -79,10 +79,11 @@ static int vcn_v4_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
+	int i;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
-		for (int i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 			ring = &adev->vcn.inst[i].ring_enc[0];
 			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
 				adev->vcn.harvest_config |= 1 << i;
-- 
2.34.1

