Return-Path: <SRS0=b4Qt=JW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846CC433ED
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 08:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4A361451
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Apr 2021 08:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4A361451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8882B6ED10;
	Sun, 25 Apr 2021 08:00:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F411E6ECFD
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 08:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQj8S4Bna3Egt3tS9CRIMCGuynaxyGKcMgxIMGnyaHmpi3tuDuxPE+n9SEMdHITXIa3UXgXgnGp/VKt4iFikrDAqd8pN3CDYUegHff0xZdgbsXMyiZ46QhonRlCDxL9Rrcannh987ALOfe50J1rEEdGgxYpOlyFRE8K9DjVo+X3y/n30L/k5UpK5+mLcW3vYzBU0SLUrh5VLU9lWexlXKprv4A7gAbq21brFco9HuMlNH1ltlx+UPngd36Iw34BJXdduXclRD6F4C6c9q20YmXhQhuOMldPgwyVXF5xp4lILcZMLZmlUOF9NLXMDAqU1P/gJzKYCtw7O+e2atEgEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3crTN2GqJca3mD91C79bkyzep/XbfKOf6o90ybx+VY=;
 b=JcCQHfHanvFO/AwR+fgugUBq+7CCVuJJ2jWjaW0jnxc+M89XoWmnKJ0TrfbZVr81q4Ag/+wmzCmxpGxLdVAMY0lhwQcPqhUSqP7YVO1C0sBBv02BY6dRa0vuuQD/lT76zEVgrs85lwEkfpfaQ+EL2FFBzZKlT6eLxLbWY52cbT4eAR4W9e+wDhyZ8fTAPHblsilGIShAyNxFWoJwb08RixcU9rPDYQk45WVeSBwOS8toYfmBRh9NDXbNPo42DwF8D8z3VfD8Bv6rii+NNEOfzEi5BZDtoBbQHeOj8/Dn9paLSJNRenhrUHuPPeR9PMfSAkyWYJXome0x57uwPisNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3crTN2GqJca3mD91C79bkyzep/XbfKOf6o90ybx+VY=;
 b=J5ai7SI6hn48t5uNtLahrBJHIVK1UVccFZkgN6V77yQe+zIm1TrBYkDIODE6pb3NClzBuNyR4OfrdVq98x8cBZ9vSN+CUTwvIIcZyi3q9iXg7QL0yBY5HJZrM7tg80H1/LdYkc5Zg5fmsqklRT+fEX79Q8mEf1xt95nN7Picz4w=
Received: from BN6PR22CA0065.namprd22.prod.outlook.com (2603:10b6:404:ca::27)
 by BY5PR12MB5014.namprd12.prod.outlook.com (2603:10b6:a03:1c4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Sun, 25 Apr
 2021 08:00:06 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::b3) by BN6PR22CA0065.outlook.office365.com
 (2603:10b6:404:ca::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Sun, 25 Apr 2021 08:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 08:00:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 03:00:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 25 Apr
 2021 03:00:03 -0500
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Sun, 25 Apr 2021 03:00:02 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Change the sdma interrupt print level
Date: Sun, 25 Apr 2021 15:59:54 +0800
Message-ID: <20210425075955.49499-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5229da14-606d-4830-c3ce-08d907c02315
X-MS-TrafficTypeDiagnostic: BY5PR12MB5014:
X-Microsoft-Antispam-PRVS: <BY5PR12MB50146C5CA75A3702728FD71AFE439@BY5PR12MB5014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcEgEMUsVSHYp9yXYAKN3UrMepnQI+5Ip/AcRiunchswHNpXnaThk31Y6bSqfoCBxlyXwPt1YyTdMaKKV8AGRvBkCDrjUgXquiCZyeI4vXdNjyjVI0q4y6jMfo4sg9AmKqgQL521FWVZho+JtWjytGQ0xl3+mOiCJDICANKTG2NNsHprTAhtdwoO4Fh6KsnFHNGh9e9ZRmJWL8+48Ixm/Lktdkvn0151NxjHQWQC4601AkBkxu6GVvBHGhm7zyYdvpMXY/rqj8HJPmbzyxG+WoNBiHjOx6yuASNk4oP6VSC/f4CdhYh4ltTj2PwYa5Wu4jE/9lbWFFOy8J3G5h5NjuJLvum2MNruFVchdNYvBfKOvGHcEXPcBFrMZttTJBEAW4YM06Ygvnesmtj9rFAttSjMVEa/J1J1CJUenLSoBdYVDmKkP5rvs2mT4IJ6/FIvbkimt34oiUiazu3QxC/kS9+1CrHF3VTf27SHQ6WY5WD1COkcLl+kLk2Rw8dORXPlVWrtbymCRZUY56FElCRoatlpU5qa0ZWFoAh+kf2wCXtuNyi/rTEZQGW0zMoFIu07Tqmaj4RIvpJNQUscfl6z9gWXnsrfeGF8Ev3SmJdNEzFejD9LqHjYaj07fY9vWxgtyIznktb7lowCBLPaO1G0yk+T+qaGnR48lw5u7KKMpAdpv87zi/wp0j4DTSS3H/5N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(70206006)(70586007)(426003)(83380400001)(5660300002)(1076003)(336012)(82740400003)(356005)(54906003)(26005)(2906002)(4326008)(8936002)(36756003)(316002)(186003)(82310400003)(478600001)(81166007)(2616005)(36860700001)(6666004)(47076005)(7696005)(86362001)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 08:00:05.2940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5229da14-606d-4830-c3ce-08d907c02315
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5014
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change the print level into debug.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 2800b1b1f2ff..7870fd09d98d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2220,7 +2220,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
-		dev_err_ratelimited(adev->dev, "sdma instance invalid %d\n", instance);
+		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
 	}
 
@@ -2230,7 +2230,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-	dev_info_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
 		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
 		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
@@ -2243,7 +2243,7 @@ static int sdma_v4_0_process_vm_hole_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
+	dev_dbg_ratelimited(adev->dev, "MC or SEM address in VM hole\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2253,7 +2253,7 @@ static int sdma_v4_0_process_doorbell_invalid_irq(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 
-	dev_err_ratelimited(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
+	dev_dbg_ratelimited(adev->dev, "SDMA received a doorbell from BIF with byte_enable !=0xff\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
 }
@@ -2262,7 +2262,7 @@ static int sdma_v4_0_process_pool_timeout_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		"Polling register/memory timeout executing POLL_REG/MEM with finite timer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
@@ -2272,7 +2272,7 @@ static int sdma_v4_0_process_srbm_write_irq(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
 					      struct amdgpu_iv_entry *entry)
 {
-	dev_err_ratelimited(adev->dev,
+	dev_dbg_ratelimited(adev->dev,
 		"SDMA gets an Register Write SRBM_WRITE command in non-privilege command buffer\n");
 	sdma_v4_0_print_iv_entry(adev, entry);
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
