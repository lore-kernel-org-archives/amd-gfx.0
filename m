Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831CEC352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 08:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AF8208C4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 08:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e4Eu35sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AF8208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAEF6E937;
	Mon, 10 Feb 2020 08:33:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58CC6E937
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 08:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlMpJTF3ueWCa8dBWMKH992j1/uC0F/L+NdiMj1eEHU74dcamN7mfVKyJj7eteRTFITtQt/wQNavGy2SC/MP9OP/VvZBaT7xBI2cuE6OI4dz9EPNOMddN1LFbm+//S/wSclKRgx3ifytfWbOhRRbpM8eIt22/rfcqlOxTeNtmOcs9nymibKpT7KHFO1or6q3ErzEdlv4SdqCaLB8r8lDEet2N9VqfeOloLWSBu2fMfPni8el4Udkb4G3wkZ+j+3EpgJK3cA7ki2sqkIbBBS6XgAu/qAA0wZ6kOfz2Z4FnF9G7moWUO7NzeY6JqV0U2DIup7UUuSMGm7uCDEYHRBHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oIIHVgMwwIMJzjAjM3ooOLjJWhNAJftcjksGA896ro=;
 b=j0foKSMs2mY32X9ltLNa01EDMiOn4f2Ya7aPXmEo9dVMuyx/+l3IvqgUvG1C7kqJaDSc86OKOOp/JRL9OzyZEFbjFiThjfWEeIaJalBtHqjaRRuXLeDaXuJOTtLUfMQpJ3EbdOa3FQUj6jv70fZvFuV/oZOwelxaHzLjnn9mF2cgNSnHAX8iUCkLaxdmaIMivEblEG3lJHE71bNDe1Xo8CbwaHu/H3S1hS3Ogv+37eM2hZ0OJICl3QUosRvV1Ovb3i0ytBWqq1klOu4IGt+dxhQyFkDopB9/kWPkW2btvUGEclpN7jrFjzZoXOn4pNEOcbZr7jNbHnGZXPdZZylG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oIIHVgMwwIMJzjAjM3ooOLjJWhNAJftcjksGA896ro=;
 b=e4Eu35syGq5AJpyWkhw5Ao8EsFHjiQOLEjUd9CiAJMakUkCKqU4dUE0KObiJz7kJ913Gfl6fz+/gj6F/c/erAHBimh6OhCxTbeKQ3MKRqoOUTPoy9OR18Ff31baNrIvWqUAUdgDPFIZORKR+RdWdIPety0iK4/S1NRMgr1qAs0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB2950.namprd12.prod.outlook.com (20.179.91.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Mon, 10 Feb 2020 08:33:48 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 08:33:47 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org,
	James.Zhu@amd.com
Subject: [PATCH] drm/amdgpu: limit GDS clearing workaround in cold boot
 sequence
Date: Mon, 10 Feb 2020 16:33:27 +0800
Message-Id: <20200210083327.12487-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 08:33:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72e99c0f-876f-4e11-2419-08d7ae03f29c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2950:|BYAPR12MB2950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2950BD9B744AA0A86934BCAFF1190@BYAPR12MB2950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(36756003)(6666004)(6486002)(5660300002)(4326008)(66476007)(66946007)(86362001)(1076003)(26005)(6636002)(66556008)(2616005)(186003)(16526019)(44832011)(7696005)(2906002)(52116002)(478600001)(316002)(81156014)(81166006)(8936002)(8676002)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2950;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kd6U9dST4r9RKxe1pIB3Ph6Pj2LYC7TIg80rsY4/HDHx0tc9eRKIOCMNgrTSHN2oXrrVjsVWq9O1d4eJyD6CxQRnNntP5bl/2TnM81iNpCSYOdLsNOGfd19mMhBRk4E1BauO1bEAMBmWiM/Mv6oboGoyNKap/UF8R6zVKwwk35nqk4iVy22IBHYl5cKh/vrZx2gXtxTWFaYK95db4fI6bsTo7kt0C2z5QxmqMvvUDecJb1d7s2QQU+EqEaiMqOIBUENqEosn/ewBxXAHkN4QkGOg2cgKgiZwvY+Kzc71itWPHtKuCgOAsoHB3IxXCi2ouukyCHMo0nxcYu3cfP7KrOVzP7ZIfjhY9GyTefZjlA5PWYcvHbO/UCp1jTi0pjTdtbJabNnUir+sSkPpErhIOIVOW8sMlFIQ9BOFlKYpWv3HemRioFN+2IRTNmAmqbfn
X-MS-Exchange-AntiSpam-MessageData: 4D+4FKy/nHwN9HAa2vFj7mpNQ1QXJn4N+Sg2n6IpRx7fAHNm1bhBWGJbJbMDs3hwA7XcSmFqcrGGvpBqb1RUP/Dzc+fRtJjMp0fugKwRA01doPk3Y2p6RsMMP5a8+El+URKmpcHkDOZUvWddwPUytg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e99c0f-876f-4e11-2419-08d7ae03f29c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 08:33:47.6667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaURn29krPSJfaUs7of16hx6weJzs4FGYapu6yQBvEZRR6Jc72FdhEKHKhJ33O5zD820vCWBVdZerce8kx+GGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2950
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GDS clear workaround will cause gfx failure in suspend/resume case.

[   98.679559] [drm:amdgpu_device_ip_late_init [amdgpu]] *ERROR* late_init of IP block <gfx_v9_0> failed -110
[   98.679561] PM: dpm_run_callback(): pci_pm_resume+0x0/0xa0 returns -110
[   98.679562] PM: Device 0000:03:00.0 failed to resume async: error -110

As this workaround is specific to the HW bug of GDS's ECC error
existing in cold boot up, so bypass this workaround in suspend/
resume case after booting up.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index de59defa91eb..33f282ff245f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4320,9 +4320,12 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	r = gfx_v9_0_do_edc_gds_workarounds(adev);
-	if (r)
-		return r;
+	/* limit gds clearing operation in cold boot sequence */
+	if (!adev->in_suspend) {
+		r = gfx_v9_0_do_edc_gds_workarounds(adev);
+		if (r)
+			return r;
+	}
 
 	/* requires IBs so do in late init after IB pool is initialized */
 	r = gfx_v9_0_do_edc_gpr_workarounds(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
