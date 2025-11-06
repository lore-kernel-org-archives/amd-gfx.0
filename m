Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E858BCCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 08:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D67B10E83A;
	Thu,  6 Nov 2025 08:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="28OYE/OA";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2D910E83A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 08:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQQpgphcpR+tm6peTlYS5L+s0n8BwnrWnY1KBLU0bJOOVNJ4PKI017eCmXRH/gfJ7m5rUZXlXVHR+hRwG+QYEedwW0D2LWoWP4XqOhxoapDr+N5ZQiyrKKwO7A7V6JcqZdAzVpicwvyUyLais/pJpV5Cvzj8Rr5UDuSPkWywrS0PmijxPmSZ5jCdEOt+JyZpwPP8Ffq/kntVFyKHHVhGCnhtccb7PjU1T7ojUFwru2joFgfsjUiFSFCw8LvtznO4yhkTenbYT2S0A/MgPlTL9y1Tnla4XiDFpwycx8GL9oB3xkZCBMa15yhJzKTzGiKPIjagGc35EiQMRuRwPSYObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzZjco+qQT6hwm9zVTDQSZECvYklfZ+6LX3zMp1EhRA=;
 b=I0eyIpjzGubXmLb7MVR3usJA8Cj85045y89N7QZgDd3ODpX09ixCzaky49UnNAuEd/YLQmu6CtUOr8riub5kgETg1m81fv/xzSqdXqyW0cUeDJKyTUpLTsR5kaVLmsaqC1YBfR8ryf9Q494DqMPVdxvhiFZBzwhF0P4wv1DqUV7ZHOavhw3qFXRnjUN169MbSs+nM7jKHctiSgWoF3xuS+4IcvcosLxAZ6yYtp3LN0OJJq5pktZZRsEpp7vSZlx5oI5YNhQguPyuvyKIpw/ysZ/QRDUAzxyc8jgHOr0p23UVogCFz0UIt/maaFX/ittYUYMmOK5MVMiHN39cUXT5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzZjco+qQT6hwm9zVTDQSZECvYklfZ+6LX3zMp1EhRA=;
 b=28OYE/OAMlMNrEqEmM/cXaOuM7eo4H7SFYYQ7qia8MPsdmnkTRZb8uibzYDQiliMQlDBS41ndc4mEIzi/LwBxtEdGR8L5GV7a8RC+jrBzk3bl6iWX28pVDZRmsudQBdUMOA5vfQrV6yh247EMuGgDaWbJ6/NPOIa7iSI7zuAt3Q=
Received: from SA0PR11CA0096.namprd11.prod.outlook.com (2603:10b6:806:d1::11)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 08:46:38 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::a9) by SA0PR11CA0096.outlook.office365.com
 (2603:10b6:806:d1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 08:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 08:46:37 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 00:46:36 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: optimize timeout implemention in
 ras_eeprom_update_record_num
Date: Thu, 6 Nov 2025 16:46:22 +0800
Message-ID: <20251106084622.1431571-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SJ5PPFB332093D3:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd2cb2e-9830-484a-ee23-08de1d10ffbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ufI+2Cu9HFwb4kdKGemKXI6KmydEPpNmbl2UdyFu7nOEUkgXW7dZ2Xml1WI?=
 =?us-ascii?Q?laKtqtWecFoyPqVZjdKQWZFuYrQ2WDu76u0hxpQyrVSkPt4hwchL3EvsXkZY?=
 =?us-ascii?Q?0O2XnSMbd57Wbr/irI5Wqw3Q9BRI1EWh6l5ViD4phar4F1Djqafd6Diw+6oD?=
 =?us-ascii?Q?DUaHzdzA/zu8bhJRpHgbLFaqG3yQr+JOVa4v1agAG56ZQlroZsesJBXvzl2X?=
 =?us-ascii?Q?5ujVijWLms9C68shuZraKB/WZESbOwxWoDxQf+HbEqrA+zs120QH1KXxpgzF?=
 =?us-ascii?Q?5EJv9wZV9nxlAcwXgG/F917b2UUnKIZceL3m9f6gEC/uAhffwG5HK0jkYilb?=
 =?us-ascii?Q?hLp6QW7cGPG8Rf1jINCPdIU1HL2SJPtpKTrSINzsVC8VjAfTkmAXRaWOQkTW?=
 =?us-ascii?Q?7CIqDsJzqOoFK/Q5wpJD5STEc8C52N8YYevUzJk/I8fsrfK6bdmz3zouNey8?=
 =?us-ascii?Q?TqBQM+yCJDGxDJiMGmrwG0HYIOPyoRTr2uwH2qZpUMg87K/w/lFJ3l/T434p?=
 =?us-ascii?Q?N4y31ptrn5ASzU+ixi6OYj0gmr69EwsHJs+1DLH9tw/SzXiXOBRrKizCP9tS?=
 =?us-ascii?Q?STwzCWAZOUGw546PnZbxK0R7XD2Eib55NbqYHqrcyv9mgeresng6CYS1gTf2?=
 =?us-ascii?Q?Urq7JCL5B2+7A17+bMufxxdkfy4GMPpXsD+MD4azBlxYaezgFfCvCrMpWGy1?=
 =?us-ascii?Q?58E5F05xymtydlxmqybaUwWDFdcAKBmkDQLPW8s3hIqN2bNMOu/NP+sZuK6M?=
 =?us-ascii?Q?nQbf/7jikIlxjoHxe1ABVC6aQPMQgj5KBTqbEkWtFJ6/sKeCwWEUV4tsq80F?=
 =?us-ascii?Q?W11rnYy2Ty5vimvYDTImWq+PPwRlPFpWcdNtPUt+E5JPgkqlRn7e7i3osdh3?=
 =?us-ascii?Q?9RR+I3BHsS5drf3xqSVW2EgKmcsBnRMNHb9BkWJY7WwBbtaDTt7XUAr5Hj8w?=
 =?us-ascii?Q?We3//ljO44txe8iGaPC44lPw93gMO2iv9eLgMQLX2KT3bsys1YM2Jc2/2Tow?=
 =?us-ascii?Q?WXubaiDaX4CIux8PhZpHHOnSX4rYS+6s6FQGw3MP6PqiWwYT5ZxuxSL+SgzP?=
 =?us-ascii?Q?QVrfqnBnAAHzdVgXCIVPvre+yadvaOGzd5sHDESFT73aYjcNeZVR+cWKw/st?=
 =?us-ascii?Q?Eh7JPOR8j6rTsqHqH+90QzQdOLAze0JE9NV1P796Ri/6n9PAkDRcjQEWmhk9?=
 =?us-ascii?Q?C4L2aZIB7L9qik9J0riGaTF23FH7QfEVYQkDsL1XAVsyNdnTSP8tre8c/Mhq?=
 =?us-ascii?Q?B6JQ1fSjMwXzPJyfIL+mRIt27PMRcJ7x1kKM9XaH71pRIhthvpwfk89LHG+F?=
 =?us-ascii?Q?dzgj/w+y1rnMZUnG8EGyOM2XGPtvPuZnHbG3zfNQtlqUvIXBOrNcPJpSZH/0?=
 =?us-ascii?Q?SPGtu2mCsmzaPXnFGw1m4/GFHRWCoPSbp7XPqYO/83FXMjGFAhHu3SK551z6?=
 =?us-ascii?Q?Ji48u69iqHsRC/b7pZoEaA7XeTjuPhmv8prNvxe+n16Zmn+ZQoz83HPDOJIq?=
 =?us-ascii?Q?197lek8Qj01ke2fXg9sx+dxGAOotpytJXjcJ1pViDqxjVPYXNwmT1PABC8Ss?=
 =?us-ascii?Q?N1oTXQwFTqTtTxUHGUE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:46:37.9997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd2cb2e-9830-484a-ee23-08de1d10ffbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The busy status returned by ras_eeprom_update_record_num may not be
an error, increase timeout to exclude false busy status. Also add more
comments to make the code readable.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 99aa1908833d..ff9f86d5ef15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -874,7 +874,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	int ret, timeout = 1000;
+	int ret, retry = 20;
 
 	if (!amdgpu_ras_smu_eeprom_supported(adev))
 		return 0;
@@ -882,17 +882,23 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *contro
 	control->ras_num_recs_old = control->ras_num_recs;
 
 	do {
+		/* 1000ms timeout is long enough, smu_get_badpage_count won't
+		 * return -EBUSY before timeout.
+		 */
 		ret = amdgpu_ras_smu_get_badpage_count(adev,
-			&(control->ras_num_recs), 12);
+			&(control->ras_num_recs), 1000);
 		if (!ret &&
 		    (control->ras_num_recs_old == control->ras_num_recs)) {
-			/* record number update in PMFW needs some time */
+			/* record number update in PMFW needs some time,
+			 * smu_get_badpage_count may return immediately without
+			 * count update, sleep for a while and retry again.
+			 */
 			msleep(50);
-			timeout -= 50;
+			retry--;
 		} else {
 			break;
 		}
-	} while (timeout);
+	} while (retry);
 
 	/* no update of record number is not a real failure,
 	 * don't print warning here
-- 
2.34.1

