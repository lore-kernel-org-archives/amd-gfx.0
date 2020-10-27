Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D3C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDE3206DC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kDlAYMPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDE3206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BD66EB31;
	Tue, 27 Oct 2020 09:04:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 167F16EB31
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWhuWA7nZsNwudIo225I/lkmuBVTQJcrvdenuaPXQl5z4PqyfnZ5OoBkyAPdmT+G6uz3UgHx1xhSgfKYuQHm59kdTZQ6TQv+LwJ0x6uQOWC5zIktH5XVL1VJNnSt4IuSTyqQGAW1Qxsu8SUf9ectetUXxPtBy4L6b3cKHgbdpqND+5xyyP6ssbx2BSMMOWMMYd30f0OiPvzYkRVZn3u+xF8kuBfKXFlNl4C3IEF3gH3SltToFYbwDOU2zvZ2mVnQ11+rJoinwKhmn/U6eaNYRQ/9SLyO58wy3GQRoroAkz1Hz4t5nDGTY3qydsyjmuz0iQaLMvNonAczeBfWCN4FGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYNPlPLtWgUZWBryzEhWErrRTNK4q3TAfwAS7qA+OPg=;
 b=cGiQDFt46mSNHppAkFbL/wfKPWqDLFExR/SLolq6NtGYmc6cXxTCiFwlDW7hJrqKOdY6TghLzbm8KXhAes3Lezdt1u2Hqb1+12S2WSHqV3PP1XKRT9pekcIlDy67FJdWYk4/K6Fx+6Wj92a748erCzTRmP9NMhvOZ2LNIKuaLdknSGZJBnymYEKuWNdlohyEQSakCSWDNPxkPDGXE4MnM0iIPGbih8LN6b68koMYN5hiVu/bjCXOkAjVW5FLe5eldnmUiUB4EJY1sQbYDodi3yOMTCqB85pAJfm0B0UVYYfL6OakO0BVERRWFRwHILEiBE3MemD8entzkuLLvCY9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYNPlPLtWgUZWBryzEhWErrRTNK4q3TAfwAS7qA+OPg=;
 b=kDlAYMPdCqRN9FdFBS1x1GmDCP6WvJvWS5Pydcn37ID8mglPa1LMwiOuE2Z/rbhxZyvNnCi8PCcP3xyAZP+ipOTH74xPw5BZTpFGgGPf8DZMeNcRps/MtL0hPFFBR1Y+B6SDIG9MQfGy02mDQIImcN67HnlyKu24u1XUWePHxNE=
Received: from MWHPR17CA0091.namprd17.prod.outlook.com (2603:10b6:300:c2::29)
 by BN8PR12MB2897.namprd12.prod.outlook.com (2603:10b6:408:99::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 09:04:43 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::8c) by MWHPR17CA0091.outlook.office365.com
 (2603:10b6:300:c2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 09:04:43 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 27 Oct
 2020 04:04:42 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 27 Oct 2020 04:04:40 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: change to save bad pages in UMC error
 interrupt callback
Date: Tue, 27 Oct 2020 17:04:31 +0800
Message-ID: <20201027090431.3545-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c495ae-637b-438d-f8b9-08d87a575851
X-MS-TrafficTypeDiagnostic: BN8PR12MB2897:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2897C92EFD42918B4B668D94ED160@BN8PR12MB2897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eykrfZCDBm8XB54h8gUYC3jg6roRMubdVwuf7X/saja0qf48RWB5oPh2n+3DMOh4LqykD9o1H26DEZd3r4fQj8+fgs8eiJe+cLla5dOMSHRjeQuX3ygbptm3E6b+2JskWNd7VQIbm4gbkO0OdHSMWyG3PEAdQvthkvgS9Yy8PKkjzgvUXF9qEBpysJuNqaKXAqTcblQclnuAqjDi9yoxFIVbQzXS/8JC9ICq9LxmeZmjcaaRw8N+tozzMI6BsyuYgZ9H8Aqpo6o71HawTm0VV51bMz/BIzN3ogayE41YtAvn7rFq8WbfFOprEO18ToKnSpv8iGjqz3Zwi2PK4tFp02KosSORxsZ3oX4/pbyp11AOZ0rPza9Jmo4vmbSlBfLHnnWhYoXtHEfFbRUP3oYTIYy/fhCWWhSbcxInyCsCWfg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966005)(70586007)(8676002)(86362001)(82740400003)(81166007)(356005)(82310400003)(6666004)(110136005)(478600001)(5660300002)(70206006)(316002)(1076003)(8936002)(47076004)(7696005)(336012)(26005)(83380400001)(2906002)(186003)(4326008)(6636002)(36756003)(426003)(2616005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:04:43.3746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c495ae-637b-438d-f8b9-08d87a575851
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2897
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of saving bad pages in amdgpu_ras_reset_gpu, it will reduce
the unnecessary calling of amdgpu_ras_save_bad_pages.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 7 ++++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7f79d25fbccc..0f57a0003df6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1690,7 +1690,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
  * write error record array to eeprom, the function should be
  * protected by recovery_lock
  */
-static int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
+int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
@@ -1863,9 +1863,6 @@ int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev)
 		data->last_reserved = i + 1;
 		bo = NULL;
 	}
-
-	/* continue to save bad pages to eeprom even reesrve_vram fails */
-	ret = amdgpu_ras_save_bad_pages(adev);
 out:
 	mutex_unlock(&con->recovery_lock);
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6b8d7bb83bb3..0926c0770d7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -506,6 +506,7 @@ bool amdgpu_ras_check_err_threshold(struct amdgpu_device *adev);
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages);
 
+int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
 int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev);
 
 static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 262baf0f61ea..a2975c8092a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -126,10 +126,11 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 				err_data->ue_count);
 
 		if ((amdgpu_bad_page_threshold != 0) &&
-			err_data->err_addr_cnt &&
+			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
-						err_data->err_addr_cnt))
-			dev_warn(adev->dev, "Failed to add ras bad page!\n");
+						err_data->err_addr_cnt);
+			amdgpu_ras_save_bad_pages(adev);
+		}
 
 		amdgpu_ras_reset_gpu(adev);
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
