Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123CCC00A89
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 03:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91025207BB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 03:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eZa3o+7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91025207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258F36E59B;
	Tue,  3 Nov 2020 03:11:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C79B6E59B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 03:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWLk9u1xxbWEJX+hLQclrLYEsHaingtWXhgd9AC0r8qOR+06t4Xmu0dQHJ3HF7vVYrtgCPvzfHITWvb7uY+5MWJAov70Ywu4rrsIZ0N3+oSNW9iuYG+FITKuAe0HK8MD8D4BJVB3apx0QyJ6NgttCDqQKVBzcYqz5hfugo7uh4oG3mDNhOQz80zDKCZQd/P+an1eVU19ZXBH/vvd5ImGhGqmFGyg6N22ZFbm6NQO3cnDgbqopFo4cJ3mR5JJfc7u0Tj1xrCM0pUkdFSB3pch+Y6hNXwr9EuDEFSaM2Mc5M5BXzCcueOioD/eAZBAPnVXrc8zJrw/fatYkcbNIbZIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oL5U1QcHmQFLTY4bdfoKRKn/fSpwDS0tzxlQxV5UKE=;
 b=Daik/I+8tuYqhsJpw8wZchjcilUBrPRJB93gPimB/Z9lalWzlc+PooWqfcShMgRda1klVMMjlqnE5CidtlRrrZmMfdYbnQSTJJNNevb5heXQ1UuDosRinNCGWqJ0gvFgGV5COfxn87zwf127+qCXjAO9SKrr1lwNQA3h8hL8eO5BcfL6jpSC4IhDcEzz4Zmf/FS4fuwMdT4wGXSk52lrn+6G6okE13jnzj7/oiJVzYPgxfi5ao4B4UKJDCNsp1wjmprmPrE0dErq/68tmiaNSSXkroUsGXU3UVxtTFhcKF6j4GA8LRV8teM/sGrqDeOvxFIIsHKiwHKlLleYFlpWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oL5U1QcHmQFLTY4bdfoKRKn/fSpwDS0tzxlQxV5UKE=;
 b=eZa3o+7ymtRkRsF5BJ0TAvyk4SC386MvRiUJRGYu5G4H4dHJxj50O3NuWZj8vkpiQthh5xA0Ti63QE0pNaU4ZrK4NSM8FHsobIr++gnOHxITKKVSLdmluAUPxfmJlxkiEWePIBQJQaaZD7hPovgtCxDZEY0fjLTPg+9bPXZuXnY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2525.namprd12.prod.outlook.com (2603:10b6:802:29::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 03:11:17 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::95:a9c7:37dc:d070]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::95:a9c7:37dc:d070%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 03:11:16 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Enable arcturus devices to access the method
 kgd_gfx_v9_get_cu_occupancy that is already defined
Date: Mon,  2 Nov 2020 21:10:50 -0600
Message-Id: <20201103031050.22474-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR12CA0009.namprd12.prod.outlook.com (2603:10b6:4:1::19)
 To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 DM5PR12CA0009.namprd12.prod.outlook.com (2603:10b6:4:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 03:11:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eec25236-c4a8-4af7-023a-08d87fa620f0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2525EAD0267D4356145A4E1FE3110@SN1PR12MB2525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DS90cV0xf+OQcVIqIhUDKWakZuruJGYWg6bR72y1Q3FZ0FeMszLqp2lfoayj2a8nUi4sXgAgCc34GAscmGqL6JOkBnIZNLhB+aPcHwBsCBPJeYTo6RiGnPZNzEjmStMJpzVtUC7FvaixNyN1EbSyf9yt06/91eW3hexeCsUuyIqFLFOHiXFoei4P5I1aU67TQZFWI4mki2Pe9IqD3qJLO4hy7Dtt0F9eGP657ZY2Js9V9lOMCL4+P+cIo1BFW9aiUkeWvS+ZxfSXTEsHDELKyq9muHimL7w4lYi0g9mxOTdisp9Un/Zyye5yQuT7cHeO/wzoj99YU2JBS9iZgf4CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(26005)(6666004)(6486002)(2906002)(478600001)(36756003)(16526019)(5660300002)(186003)(52116002)(6916009)(7696005)(86362001)(66476007)(66946007)(8676002)(8936002)(66556008)(83380400001)(4326008)(956004)(1076003)(316002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 19U84mQR3fMzmempCx4fsJKWQsQGaEkmTLeWOmDLocxrW++5dU4N69mZYpqXduJsfcOWs9oCjrTvKyGK0tXk/h9y+NSh67ByHsxivKU7f9r9X93aG5HSvmcO7Rliwl5kODmAAzY9iYLIWez58348oH4IXmXAMiyxudr3sOQndvJ0x5Cj9iNKwzO4mqCyehiMqDxrIbctvEOJBnynUue3D9Qp5o1VuJ3oE1gWRBhYPObIHv9SEdx80p+E6s8/ZvKYX3IxzEIpQsGvpUcQtt9hSuHxHto3q/bn6RWpVdp+kX0Id5dsJX9QWUS6p0NsJbiq65Hmr9eziawOkZvQjLD7ErtQkEP+hREFUd/h9+bT+1AG1zWRM64PIRKXMKj0g81Sc6L3xazybUPOG0wNkKVbB7MD+AbS4XN8APsmnMxb89qHlguaQrLqEUI63gyMHplp7/sNpZDTU/Q4KIuJ9CqBVs0YwqUqKbKbVRi6KuQCCzc0T0ox9rfpas8czavCrGkWVPvlC0vNkUs3SAdq2/EV3SUIXqtZITEMGpMbaG2uEAOmT6AYzaxEY3Qc+garxptwrYZROpdKVGvZDHF+Iy6W6uBOatVGQz/L60SvPkmWMeWds4ZCgVCTCCNQBH33JR/5u/hTeUv9kYu4zFPMK0MQbQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec25236-c4a8-4af7-023a-08d87fa620f0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 03:11:16.8353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOQFHXhI5AD7mNnCVP8jqVVmwN1DDFRgkBawAjYYiTZbNkukJPsFTyvMLAg9Ojk2ZQlKm42VhkNgGbwOBW7USg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2525
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow user to know number of compute units (CU) that are in use at any
given moment.

[How]
Remove the keyword static for the method kgd_gfx_v9_get_cu_occupancy

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h   | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 1afa8f122e7d..604757a1e440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -304,4 +304,5 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
+	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e0d5110701bd..b75bf0bb05ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -799,7 +799,7 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
  *
  *  Reading registers referenced above involves programming GRBM appropriately
  */
-static void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
+void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
 		int *pasid_wave_cnt, int *max_waves_per_cu)
 {
 	int qidx;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index f098e88d3a0d..de9eca55b0ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -63,3 +63,5 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
 
 void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
+void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
+		int *pasid_wave_cnt, int *max_waves_per_cu);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
