Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5751BC47257
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 10:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABE1215A4
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 10:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZuGQ+cQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABE1215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A7A6EAD0;
	Fri,  8 May 2020 10:03:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8957D6EAD0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 10:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d51fkpta9mIG6hVkmT0FgP7TBfSRHKgHS1QVqk0LwvDiMARMSD/1tzlPoHxS1wAocprwX4kpSVVo4KSqHI65QocZmPAH/yFSEMpUcDIObKVojq7yZOT22q338o31dL9XaHem0FlkqKXzWzGZ9mv56Ss8hEsvag3Z0CP9nGjS/b00JorY3ezG+L3613X5JI6Z0odX5OrSMpt4H3jQUMy21flAYY27AsqhaYSK200ja/yHPKqQtplRfIdxRje/Kl31LsRvv5tumYghkCigwe/3672WfET1voOajIVHoKHejXbkAOZ1g+pPxMaZNctQ4CPffyvfRNeJxIkklXRrDqg8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96iKFLrAVK4rcQREOPl9xlMCFvs76IYM6eRkX6nphw8=;
 b=CTy0+WfBNkySRq7eTCZVTBR75fWQabFsNgupUZ84zd45oQDyBgzz/jVrx4hXDxd4CPio1+oPB9MbZIxRLHuUG1G8P1pd2dHXGnHvzPi/ohn3Q8jliXGaeqkGzt7bqt1MDqUpelF8azchmI0LRzAgIkw5c2yQa8+UsXygUi+VfWV72TvqA20C895IHr/7UzO0uN6u4R4BJG80/cZiWaRuiSqKPK1X5i0szGaXISnDIbreVWG1GFRjt6pOuq+pI7Vu/cphlqfJcXlzMlRhWD11G0/cnwqhGv/DhDW3gohDSTjMAy4xoctsYHDTyJVK9UwJYtW7CcnqQjrRIhqEEq3iSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96iKFLrAVK4rcQREOPl9xlMCFvs76IYM6eRkX6nphw8=;
 b=ZuGQ+cQy9+YyRu8ogPp5u6diy2OHLAwr7/Jrzsn8UMFx1IVj36soHkNxBHAkLgGP356HwplYX2n3BrVZKr+ZaajO8o55ee/N2gSbpDtGMp3cyAEHnU/l+Luu/fep6249qvya8s1Ow0JruQf5KHLFi+Q47u3L7+QcBq0qa56ylvE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2729.namprd12.prod.outlook.com (2603:10b6:5:43::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.27; Fri, 8 May 2020 10:03:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.035; Fri, 8 May 2020
 10:03:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: decode the ctxid for SMC to host IH
Date: Fri,  8 May 2020 18:02:52 +0800
Message-Id: <20200508100253.12839-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0060.apcprd03.prod.outlook.com (2603:1096:202:17::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.12 via Frontend Transport; Fri, 8 May 2020 10:03:14 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ec2ef20-1c58-4481-5e5d-08d7f3370688
X-MS-TrafficTypeDiagnostic: DM6PR12MB2729:|DM6PR12MB2729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27295ED36FA613D40D0758D9E4A20@DM6PR12MB2729.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6jrcTHKIWEthI73KKV/F35IPYt2RaesSgNiUaHOENmSpo8IVBNYccFfJvWDwOIuzHiqbG0Kp/kvNuh9YgfigZ9eDexDr4Y0D7PvH3dmGU1TZfOYjYoH2Yjb1GUDwBlIdDkh3FLe4BeWuv9bvp+xb1YdVE88zGVW5qIegoN7LnD+gxrfGeT0TtCkywybhYY/PbHFpVSxqoyPY9QggTW5jZEwVRMHpzG6VdZXfP/u4+0YsStgIHVuiQAtXejlfqcHpWGKKRIwVRB1w4q6AFZOEMSAT5Wxx6pZxhQ4YafWlHzF+Y2hJ90pMTCZkouc5Xu+dw7lk61S1gHErRRy1ka7KaNiLccXgxR+RlpsUAKlYfZSmOJUgBxCcQW4xA6Ea3zPEFU5nO5rZjchGIt2w2TglaEiTs85XQ73Ad6v5M7gQJLQMpTmN5rT80hdqCU69H+HELFCBlCHmB5kkyb5MR7Ey2ZseWqd+XuPropLz34Kf6XblBzbYiFfBhBnqyhOQZF9K9nE3usMLwIaShLnhfrAvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(33430700001)(8676002)(8936002)(6666004)(44832011)(478600001)(2616005)(4326008)(1076003)(956004)(6916009)(6486002)(36756003)(86362001)(2906002)(5660300002)(52116002)(26005)(33440700001)(7696005)(16526019)(66946007)(186003)(66476007)(66556008)(83290400001)(83300400001)(83320400001)(316002)(83280400001)(83310400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cBSgcDBfUgYCSqyDiQZA5PkfAyH9eSvl7ZeoG8P8pPFWRgyXqap+qoe8CMKu7cswoqfI5hevaKnHKXySftdlncbaIFyk+b+EB8qWgUW00DLeh6q3sxwzwUMC/la7SZUSCWgNIxAMR3s5fwg9Ucy1vy6muQPcYMuIDXjkJJT2v3LydbM+W3yUhH1EnmnfsSbfhY1MniQqJRAWhTxtHpHZ3tYn54ZqEBHFCcgJrKT3tWPtfrUFai8yt0JFRGnZ3Rr/qGMjQtRpX4D5TjiCM3JFgugAjd0fKduYCkdK/KNivtf+vxj3zvApuD5/BPlJ41VHHmsL6291e9UHNfywT46Rv7gg54wNSAEyNSFU8BJakUdNhr6GeoBZ53AD26QLKaP8rymUOe49CI95fc+0r4Bd94rgjFzxVkdH4++pbfdZbfAxfD+kphoVfRxbWdpqIK5usA9+8Ii9F9iLRYrp1+sTQlqX3UvDGq1vX0X/qLBvi5RNpfApoinbfyVhDukJKkrm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec2ef20-1c58-4481-5e5d-08d7f3370688
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 10:03:15.7360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wOPUdExJPY6scBszq3+CutdMS78lfjs+vxSt7jrj8m8sddN+nbVj39be6v/CZhO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2729
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver needs that to tell the different events raised from SMC.

Change-Id: I0e44e22527182fbb45a2db4fc3b1cd73fb17ba33
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index 7b1762b1c595..965875b8bf93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -55,6 +55,7 @@ struct amdgpu_iv_entry {
 	unsigned timestamp_src;
 	unsigned pasid;
 	unsigned pasid_src;
+	unsigned ctxid; /* for SMC to Host interrupt */
 	unsigned src_data[AMDGPU_IRQ_SRC_DATA_MAX_SIZE_DW];
 	const uint32_t *iv_entry;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f97857ed3c7e..932dc3eabbe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -470,6 +470,7 @@ static void navi10_ih_decode_iv(struct amdgpu_device *adev,
 	entry->timestamp_src = dw[2] >> 31;
 	entry->pasid = dw[3] & 0xffff;
 	entry->pasid_src = dw[3] >> 31;
+	entry->ctxid = dw[4];
 	entry->src_data[0] = dw[4];
 	entry->src_data[1] = dw[5];
 	entry->src_data[2] = dw[6];
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 407c6093c2ec..e46d1f9f62ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -460,6 +460,7 @@ static void vega10_ih_decode_iv(struct amdgpu_device *adev,
 	entry->timestamp_src = dw[2] >> 31;
 	entry->pasid = dw[3] & 0xffff;
 	entry->pasid_src = dw[3] >> 31;
+	entry->ctxid = dw[4];
 	entry->src_data[0] = dw[4];
 	entry->src_data[1] = dw[5];
 	entry->src_data[2] = dw[6];
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
