Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69746C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 21:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1246E0D0;
	Mon, 29 Nov 2021 21:23:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2E16E0D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 21:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfhv1we0dg5PVFJSMNJJ5uoBPvtGgFjKfyFs9GKGiUuutbkLGwbyebMonEH/rpELr3Y6MGzerLGAc8DlUWlmQd9/1pU6der51iGRMRMM63jo2qy/jThfFb+PX9xyqN7ZXfTFEPn0/rXiYLoxQr8mk+caB3xzzzpeOZcIvWG3zs/o8YkCzw0bbx3L4iuQBo1hJfdrgGL3uBqPsgRA5LopelNXHAFpyLBh9ip3+5kbVagH4XD9dm6fnnxFAFcLTJB3RPf0uT0RZ2K2o8XtQTIs9dzwH9ynjY1I9sq0n37Ugpi041prFfzXCNWMp+0+2QnOczKjtCZMGKrEZ4TS2c0qXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbMb0zUzSmo5vpw/KntbEtDZb9shDmXUx2pbxlBrg0I=;
 b=m3YK4AYJHPkz/uUiICJlhQpALwR0xhBAzfdoF/jZIKJoB784O9FU370jm6IHgikq4vIbTO9EcaVBAAqdTIozgSD4/pYpmB0tLkWePTft/mYBtGQT5eyNvKkMiXIlRcyYAmoIpiN9kxioldYPqlhxZSIB6sH6pafsygXL8uRr0e7+wuEl4AXMlU1Z/oMqmiJNucYa28hXVtIXQc13Da3PvOT+URtDuyiE/LIY5saFuh045oKafwHz2j9jMZRooR4aaEpHhWGJY+zyjAvimeXF981CdeAd9QVvnxhb6EYgBYGR3RkgwCrnPh0rfs7ZQrgAQutRo7MuP7xtLA1yzNQI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbMb0zUzSmo5vpw/KntbEtDZb9shDmXUx2pbxlBrg0I=;
 b=pRZasvzl6GsfUF0lBQX4uafNj2g93AMH84RJFQm8xrcsfbQHqpnHG0zzg/qZYeu8UGLN4jdJrTqq02nViYN6yyEwrlNI/TcC6jjcgtRSWqP1Z0gXVxKTiZw8NaAigycTq+hv2IR4GbljdoGyOtcuWOh8GYHTmRxJ7o/9cyGi8V4=
Received: from DM5PR13CA0062.namprd13.prod.outlook.com (2603:10b6:3:117::24)
 by CY4PR1201MB0102.namprd12.prod.outlook.com (2603:10b6:910:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 21:23:51 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::c4) by DM5PR13CA0062.outlook.office365.com
 (2603:10b6:3:117::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend
 Transport; Mon, 29 Nov 2021 21:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 21:23:49 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 15:23:48 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: process_info lock not needed for svm
Date: Mon, 29 Nov 2021 16:23:27 -0500
Message-ID: <20211129212328.19049-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9395620e-b254-4552-5b04-08d9b37e8943
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0102:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01028B7CB2ED5A45CF3C5D5DE6669@CY4PR1201MB0102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: geWSLLquG9C81fje+UzKpAFMEE4cZ0EszflxNwwuadqy9m1xFJkqn84WDoNvwcjn0t6U1FhuoloclXvJsQWq3Ms/vxoUDJXBm+6n7Ew6mol1yu1z9XpXaGwRaCHQrQcuAam5+ULpB1O3NWxrBMHzwJQBaGHPRfRfcj1vASZ1rEEmjxezgA7s3XeDlKngUtH9r8DPKBlNHCrtcDVXLGn6kJXVCXhXLS5R1dKMgJhE7i2QWiBbU2bK7OBaTEC7XfadP7lzm0ynMCEBat3YrxrhWVd7bzv57m9PrHiefDstiyTbDMtQLYwx2WUzSjvRI9v+seY5+7ecTqXj39ZApSP0AY+HmZD2qAo7bpz/0Yn0jgOTn8bHMCDDlNTAzG9P8QrWKLoUXYR9BmXupcE9nEz5FLK/4fhrvAbGtD2rWfp90e2Mtk62YzBhMO9XKa3dN2sjz+XikN2ORNLstt7zcUZipDcQQSDMabWr2ortMA7udB/9qUv5BAfupJIafkaBjCnQBFmxFKyzW62BzwwQ4DfL1g4mYJ/bJrwx+aeDQ/oG1pE0CcFLkqzGiOyhrXt6pWE/GLAiRhSGsfr4qSPmsqHapz4VLOUDaMEnlBGZoYPJ0lzJX/2pLQhpeqoPKMbzr6th6jO1fXJCTMPg+SU95dappo5o19P8USBlTrFUzvCCNqDJzmSUe7gxvcNHAaIwNO83f7yq9GaodTvCDcxuSqrFgyFvWOyO9OUKzLkiob5KgiM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(2906002)(16526019)(336012)(186003)(4326008)(6666004)(47076005)(508600001)(8936002)(356005)(83380400001)(36756003)(2616005)(36860700001)(86362001)(426003)(70206006)(82310400004)(70586007)(6916009)(316002)(63350400001)(7696005)(1076003)(8676002)(5660300002)(81166007)(63370400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 21:23:49.8710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9395620e-b254-4552-5b04-08d9b37e8943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0102
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

process_info->lock is used to protect kfd_bo_list, vm_list_head, n_vms
and userptr valid/inval list, svm_range_restore_work and
svm_range_set_attr don't access those, so do not need to take
process_info lock. This will avoid potential circular locking issue.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 187e8ab66baa..f2db49c7a8fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1564,7 +1564,6 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 static void svm_range_restore_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
-	struct amdkfd_process_info *process_info;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct kfd_process *p;
@@ -1584,12 +1583,10 @@ static void svm_range_restore_work(struct work_struct *work)
 	 * the lifetime of this thread, kfd_process and mm will be valid.
 	 */
 	p = container_of(svms, struct kfd_process, svms);
-	process_info = p->kgd_process_info;
 	mm = p->mm;
 	if (!mm)
 		return;
 
-	mutex_lock(&process_info->lock);
 	svm_range_list_lock_and_flush_work(svms, mm);
 	mutex_lock(&svms->lock);
 
@@ -1642,7 +1639,6 @@ static void svm_range_restore_work(struct work_struct *work)
 out_reschedule:
 	mutex_unlock(&svms->lock);
 	mmap_write_unlock(mm);
-	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
@@ -3168,7 +3164,6 @@ static int
 svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		   uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
 {
-	struct amdkfd_process_info *process_info = p->kgd_process_info;
 	struct mm_struct *mm = current->mm;
 	struct list_head update_list;
 	struct list_head insert_list;
@@ -3187,8 +3182,6 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	svms = &p->svms;
 
-	mutex_lock(&process_info->lock);
-
 	svm_range_list_lock_and_flush_work(svms, mm);
 
 	r = svm_range_is_valid(p, start, size);
@@ -3264,8 +3257,6 @@ svm_range_set_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 out:
-	mutex_unlock(&process_info->lock);
-
 	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
 		 &p->svms, start, start + size - 1, r);
 
-- 
2.17.1

