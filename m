Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE3C77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 20:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0271D10E2E5;
	Mon, 29 May 2023 20:10:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB8B10E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 20:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzUtzyVUrX3ElZTGTu/xceljrQVQ2qwKYWK+a5G1i4qkst7Y/AQ3g4bPgLDhWjjD3zqfprvpRaVt9IAIXdeuR+kDSj11K3k08yk+54BItGXa5al8z9rb609fGNdv5J2afal/yy4SqSCA/XP2WIvJUO9bwhR++YBr2La1FF9VN5YfvjaMJZqOdcW/Rx4K5WUGfj6UujqHmYBwWMvPQvOxO8JHesyGEl7znw+YZ46CKBJ/DeMAuzBz1vi/mcxJTkeYLnn+bLV+zTGI7jy9MdztxSJEkZO7Q9Ux3/qFWDh41ejfpPh1vaSAMGHA8RPcUKCXUyGCiQRE8waJdgpd1T32gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VViDkC+Rlt15wwcvtnAXdETS1M68ZZAfhvEApLST8VU=;
 b=HFhDLN2tCs6NkJjTqutLe/jMMRBdoc9ABNYTUxXzf7o/Y7a7t/k2iWrmpWQzBtDn5pkyDe5XFtZAxY3EQo+2XCaFFwyMAmEyNCk7KPYqEVNUlkDFz0xJQ3nt5TKVQZwF7ZUyxns5QITGhTdfR+QtM6FEUHUF7aocKxeDyJgEn0FsV5z/KWNNeBEs5LAILWiFuEkntEMTWMq+nioBhg9qCpWAexCjWjMdmMLPB8QEQ01Mh8dEGNKOX8qfI1BvZZQLuXdDyj4pJ/DWcA/vK75gHueNAI5xwXZbU7QETv+NWh2b3UiLbezAdZdnjfvhwdpoze6UWnCQmDdrgM3BcsOsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VViDkC+Rlt15wwcvtnAXdETS1M68ZZAfhvEApLST8VU=;
 b=zWCPgT4g+GokGe86GIQU7XWTs+IEmlkxl4uVO4lXtE2MKSIacI0TNZta4R6ytEM20XSCJQ3H6bUiUi9/7K/Rs0HtcyCT2CCM4F0UvGEjiZbcc/6CNK6bdsk7MFzGeSCdDMaJSOuUGCBDcapuxcUJbMEQEYvkvdGmJ2qx0kQ99Ic=
Received: from BN9P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::26)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Mon, 29 May 2023 20:10:02 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::7b) by BN9P223CA0021.outlook.office365.com
 (2603:10b6:408:10b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22 via Frontend
 Transport; Mon, 29 May 2023 20:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Mon, 29 May 2023 20:10:01 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 15:10:00 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amd: SVM flag error added at svm_range flags
Date: Mon, 29 May 2023 15:09:46 -0500
Message-ID: <20230529200946.11492-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de3ba2c-03af-45ef-ba37-08db6080af4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qgw/oup9viOJfdDsioaJC3g51z6nMWPBAyo8EWKGm9CVpO5zAMkRVdHt4lA42EXJf3V4NC3Vp10DM986xNKvnuOeidIH700BECxDPuQzz3v48R+7fhaaAkH83UPnJOhNmOk7YFKm7aIu1LuAngmmqnoQFogUCUV/69PjVp8QXif2f97Sw0FV6s+MuahkMcMuI//0+wKIBMSaly4vRTsWPEtH4eD4c4i/EsZ6O/+uXm+IHMAylrtFL7oAKHlBL8EQ4LCvDHaF8zLnatuvSO14aWNfqCQN79Qhj/DMf880YsIZ5wau6v8849lQiONeKeM5ciyGRA9jLehB8hL0OjeCmzMLqt0jsMOa/P9PK/iqX20oBsAOnAfYtn6kV/BjLE73G+7zp4DizdYUxhvLhAU+PGtjey5V0ciTaKS4H6k4IIdMLlBQrCivPqziZacA9CEiis67YHIWJtefv82iYYw2qIF717y9JRDPmu2tVUhZq55ggnVYY0kmer8v8IrPWEOra+masLKFmpexUF0zFZg7NOB9PTStJ6JgARr3qW5BM8y5LoMFAFVOZpOn+NrTrkSXxEjIjDwFUrRtaA6MHxywIVsVebThFiHNX5Ppg9vXois4u++32ev5QGVerGMZkBbiF6/o0qeF+3j6QU1n75Ad/Q70kOtBXSRQyJZTfH6ZdeEpmQjGBPNgpkdIiXn0yrtsdTmgWvAQHyBofw5VUt4Esv5RylXihnNhKyQLb8HxF7Zetuu1stDUfwYLeDrxW2mt9XtTuJf8OTY1vDJU1EpzUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(47076005)(83380400001)(86362001)(36756003)(5660300002)(316002)(6666004)(70586007)(70206006)(6636002)(4326008)(82310400005)(82740400003)(81166007)(8676002)(8936002)(356005)(41300700001)(7696005)(40480700001)(110136005)(54906003)(2906002)(2616005)(186003)(16526019)(44832011)(426003)(336012)(478600001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:10:01.5906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de3ba2c-03af-45ef-ba37-08db6080af4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a return error is raised during validation and mapping of a
prange, this flag is set. It is a rare occurrence, but it could happen
when `amdgpu_hmm_range_get_pages_done` returns true. In such cases,
the caller should retry. However, it is important to ensure that the
prange is updated correctly during the retry.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++++++-
 include/uapi/linux/kfd_ioctl.h       |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fcfde9140bce..96abae515bcf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -756,10 +756,12 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
 			*update_mapping = true;
+			attrs[i].value &= ~KFD_IOCTL_SVM_FLAG_ERROR;
 			prange->flags |= attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
 			*update_mapping = true;
+			attrs[i].value &= ~KFD_IOCTL_SVM_FLAG_ERROR;
 			prange->flags &= ~attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
@@ -778,6 +780,9 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
 	uint32_t i;
 	int gpuidx;
 
+	if (prange->flags & KFD_IOCTL_SVM_FLAG_ERROR)
+		return false;
+
 	for (i = 0; i < nattr; i++) {
 		switch (attrs[i].type) {
 		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
@@ -1657,8 +1662,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 unreserve_out:
 	svm_range_unreserve_bos(&ctx);
 
-	if (!r)
+	prange->flags |= KFD_IOCTL_SVM_FLAG_ERROR;
+	if (!r) {
+		prange->flags &= ~KFD_IOCTL_SVM_FLAG_ERROR;
 		prange->validate_timestamp = ktime_get_boottime();
+	}
 
 	return r;
 }
@@ -3674,9 +3682,11 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
 			attrs[i].value = flags_and;
+			attrs[i].value &= ~KFD_IOCTL_SVM_FLAG_ERROR;
 			break;
 		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
 			attrs[i].value = ~flags_or;
+			attrs[i].value &= ~KFD_IOCTL_SVM_FLAG_ERROR;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
 			attrs[i].value = (uint32_t)granularity;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 7e19a2d1e907..2b6f68bd06da 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1125,6 +1125,8 @@ struct kfd_ioctl_cross_memory_copy_deprecated_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
 /* Keep GPU memory mapping always valid as if XNACK is disable */
 #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
+/* Set during svm validation and map error */
+#define KFD_IOCTL_SVM_FLAG_ERROR       0x80000000
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.32.0

