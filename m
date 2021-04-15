Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD6C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 06:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6D061400
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 06:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6D061400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D416E9E4;
	Thu, 15 Apr 2021 06:11:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60CF86E9E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 06:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqPT7Qhk01H6uf2C9jbcARozcrAA95gwRvwFytZbkXItUEGIMUpOxCRkjeN+NOQzGpczlsKQD4tMf36BpQFY5UymTwrmtaL2XbOkITc23pbJIi5uE1UDLwe8Oyprmy4/LPwxfXx9bm7TfmvRc60djbaQKT4110Tz8yYZb7+eV4956Jmk89TXeKWu1LNEX9uOAW23CfLiGKvTB6ErEIm8Ic353Tj8whjlpjIFKrTRAlxVtUAfI+yCWa88W0tXKkjOwXER3yAQZkVobH1J4fRv+zLwwsdM6PB6rKGBR9BlIWI64xWZo7FBPV+k4hifL2QNDNKJVoLPjpg28iNK1M2g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXrDOwu8Zhhj99BxcG3CD33CdunBmozhE+pmSX5uCJI=;
 b=JiSr19gG7et/Q9SHYycqQWNYLBbxcGHK1fXAqz4ZtH1xIVB+buH79V00h48YFr8BMAkLLIDaBhh6AR6lQBs5Okh/qiOIUVamDsJCAS15ZhUP8C9b8pCi0otIOb1CBmrWMccaIRZxxmY4X0r/y/ysEiL2vCyIckdQZwQvtwXUEHdX/tUlf6NDhv/RneyhNEEikmfwvpU29bIYj0HHYjBCimZMUNUcDxB1dcjbppiwzqjLyc1VVJgOnTKKBmSyBnTBSCxeZmu05O+HPv9ajXxV3FdJTs9O/HR101toq/DAl5rNLsNPj+oXW+x//itETWMkfPJETV214ByLz/2s2ALnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXrDOwu8Zhhj99BxcG3CD33CdunBmozhE+pmSX5uCJI=;
 b=YMreZZkIixfmRMLBpdctKNmBGdxRpWBF4skWSn4S/2x0CIBI/UlRFeXgkD6z0ahfZdgdm4mB83NpU5KCZJ7Iun6MUIeTa/mNw22GXo0WlDfH+Tb+m2zo1r9e86sYqszmc6ZFiOPd4XypVt4jDU/ejFPACVzBUi9emwue7zI4ceY=
Received: from DM5PR07CA0157.namprd07.prod.outlook.com (2603:10b6:3:ee::23) by
 MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Thu, 15 Apr 2021 06:11:24 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::2f) by DM5PR07CA0157.outlook.office365.com
 (2603:10b6:3:ee::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Thu, 15 Apr 2021 06:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 06:11:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Apr
 2021 01:11:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Apr
 2021 01:11:22 -0500
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 15 Apr 2021 01:11:22 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use ratelimited print in sdma4 interrupt
Date: Thu, 15 Apr 2021 14:11:19 +0800
Message-ID: <20210415061119.2946390-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55570079-4219-436d-cbb7-08d8ffd54bf0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3437:
X-Microsoft-Antispam-PRVS: <MN2PR12MB343706F45632F0BF724138DAFE4D9@MN2PR12MB3437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0GHeSuC/11hpWh2QyVkzWgVIaDFA7gQWbscW14xx3gYgSrQk0fa8mkrNyEopZ91GiosBUSTAH8Hcv0s33TQfxgv1eahKDH+2Je89YIBGvtGLWjlCvF/bPNn4yd5T21kYBXFYmBffASKhgu6E1RxEMD+YddlSp4fRi2WYByszKZuu9fE8Z0OJXxuOZ3IAOUiDJsHlHOJyNR/BcH4c9lxQg+tzeXjgK71dMSjOc/R2j3iUUKWP6Ve1qMaoBgYcFs3e3w3e1G8kC29uTHKV8mNwJINQs6eJpj48n3KyVHsj5fb72gZGwTbr86RZGJ2dtcEvQDPiUR0EWfDydPKgDXqWnFHH9VKgu78s0CXPQkTw1LMuynJ8b31tfeLMb8C/0f2d0YlscD4toc6FrByWQOTOftFIiFl96CZXn379NweB5ED9Z65ZEuodAP4VlR6/kqq+qvhIPnFk6utpRqkiEYeykdHgIIknOgWIp9bKxnSZ7LnexZW9wOPpgrjva4yRmCrNy58RPIKTwzLp8o4rgygYM9KLNuEmr1OvqMW3Eug+qGEqz514Zi+PvJTB6MuCA8QsIcANL+cYLsI9LeVhXzoBv8N4n4WAxQlqH3PQkxP+hYgvfr48Uq663rojGkGEC3GQgbeIhKyCEnORg3XsgGXhLR+qIj7qLJwZ9QMjLEtcZ/TvUzwBC/qofhBZLkn6a4/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(8676002)(7696005)(6666004)(6916009)(83380400001)(86362001)(36756003)(82310400003)(81166007)(82740400003)(356005)(1076003)(47076005)(70586007)(70206006)(426003)(478600001)(4326008)(316002)(186003)(336012)(26005)(2616005)(2906002)(36860700001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 06:11:23.9124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55570079-4219-436d-cbb7-08d8ffd54bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3437
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
Cc: Feifei Xu <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dev_*_ratelimited printing will avoid dmesg flush.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 06247ad454b6..1bc5292ebb33 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2218,7 +2218,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
-		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
+		dev_err_ratelimited(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
 	}
 
@@ -2228,7 +2228,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_info(adev->dev,
+	dev_info_ratelimited(adev->dev,
 		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
 		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
 		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
@@ -2241,7 +2241,7 @@ static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err(adev->dev, "MC or SEM address in VM hole\n");
+	dev_err_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2250,7 +2250,8 @@ static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
+
+	dev_err_ratelimited(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2259,7 +2260,7 @@ static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err(adev->dev,
+	dev_err_ratelimited(adev->dev,
 		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
@@ -2269,7 +2270,7 @@ static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err(adev->dev,
+	dev_err_ratelimited(adev->dev,
 		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
