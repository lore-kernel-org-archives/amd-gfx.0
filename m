Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B48EC33CAC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 17:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C52F214AF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 17:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JWPXcGbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C52F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C30E6FABD;
	Thu,  6 Feb 2020 17:09:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48B56FABD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 17:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mjv7tT3u6BUtLkpCaqs+fsRKtty7m10f/RpxD1i0BNcfwVSD0rBVw1aEQCH4RAC79j954DS6QE9xj5bxk36rdzeC8hpP5Jiv6K8ZTRUWyuQd2YdoVDAv3111/A2lLbLH58gyhEmyQUalam0nOUJXz3uERQqLrewbfRYyQH2+jLaha/vybY1H2L4j4r+TYP1vAW9L054tweexmKv+UgyN8A76rflQ2SSl3YP+cFlSo/3SRrEaMtoXlGdcwRYjLcQ7iZ085lofSBPKLGas9b63vYSvIUAGFQ9aW0icT0oiIrwFSgujLDWjiVC3Hj323+CqfLyp8740YwXYkK1H8+VUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smwbcj8HUQjMbG7y95sTyExtMaO/GQJK2b4prOhzoRU=;
 b=LNiul8Hwvz0Zhi5TaQwFIwRFBPu+Llu3MOGse2prGu7zUQV0/1GG1GzYdOU+760BkAKPrwakRfxKPNNyxB6gHX2OwPkNBxmKCfOr+6hRZ+22uBDsfBmeGy95YzkhpLNpxgqqBllEXOiqI+MA/OozRSom8ljdII5WDfHvWYYcQ1zyqcgmVlUkL0RZhW7jswNXdlY36NQiz6q4jPWmW/UdyGBBYVoCnfL/64UZPn1v30cjKNZCI0hBUewQdBL2zePShnaoHmS5rGQ+WwS/5KGqdu65w+c+yR4v02vftrCg2Fe3khFGefF5im1Ns7JPa5OplmcG7fiIRJMNMAdVQs1Rvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smwbcj8HUQjMbG7y95sTyExtMaO/GQJK2b4prOhzoRU=;
 b=JWPXcGbz4AJZvl+W3AwRTm/xHXFw5XIgnZbVj1gldRKm6IKqQdom7kG0uRiCX2Ai/XDqP38+SnXA0GXA2E7oBrkA1+qbjFQjHrB1uUXORo/7J44YNm09Dkpea4ryEVHiF6Jj/odzBTNeXKALsoVbyUwF+wJ5iza75MXL1OAjni4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
Received: from DM6PR12MB4314.namprd12.prod.outlook.com (10.141.184.86) by
 DM6PR12MB3097.namprd12.prod.outlook.com (20.178.31.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Thu, 6 Feb 2020 17:09:04 +0000
Received: from DM6PR12MB4314.namprd12.prod.outlook.com
 ([fe80::91ff:bd7c:2bb2:d8b9]) by DM6PR12MB4314.namprd12.prod.outlook.com
 ([fe80::91ff:bd7c:2bb2:d8b9%3]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 17:09:04 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix amdgpu pmu to use hwc->config instead of
 hwc->conf
Date: Thu,  6 Feb 2020 12:08:47 -0500
Message-Id: <20200206170847.39102-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::15) To DM6PR12MB4314.namprd12.prod.outlook.com
 (2603:10b6:5:211::22)
MIME-Version: 1.0
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 17:09:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a3ac9a1-ab55-4b27-26ce-08d7ab2744a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3097:|DM6PR12MB3097:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB309780FC90CE201C91BBBA79851D0@DM6PR12MB3097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(44832011)(8676002)(66476007)(66556008)(81166006)(81156014)(956004)(2616005)(478600001)(66946007)(5660300002)(4326008)(6486002)(8936002)(36756003)(26005)(186003)(16526019)(86362001)(316002)(6916009)(2906002)(1076003)(6666004)(52116002)(7696005)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3097;
 H:DM6PR12MB4314.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYhuGkJ29LNIkVsmSrHmMuWJftZXw14btwvET9H5C25ubUaQm22X0y5AEgocYjASrTqCuxpOxcYrRaatHbeorOsutejeLpzRTZ0Vo9uFI6VASW5MrUrte+tGbAc1BJqyasGXcegLy5KeYRFKexIY2SP+qnjLm5SrDz8Hr4iyFYv5BbAj1JF+Vw0SrHbggYXFz+Mv3RKZ4RhJLWR/Koj9683dzmskGZxDOt7Itkj//cBmXC3NniehnfJLW/8BMeq1TBWdZIiTLsk0AQVf/6KyF4wowbvv4+y8Y283T8t6TjStB4HnBqSNIg0pN6+XcncpzPJ5KeJ/ZgGy/tSW6uTGBvojg9u3qzhfPXrnUfeTrO+1FRvkn2iLJwDfVM85fqWWvCSFFo7xWHGeLQakIS49dC143Vcd3/yQjHeoHYZEyC/7/7xa8XNHu+9rBI53Xmlo
X-MS-Exchange-AntiSpam-MessageData: GrRD/rqmbiQNVdl4ozBeqLacg/IoYe5Xr1whvoasu7OuQn9wuCooTuf6xvJqwMhJ4eDsreuUexsEYulvTTXrUFzFK3uTOKJNG3h1d8JtcjrZHqtdNDG7UGY+2WL4diARYC++hkrJScHFgyhw5yVT6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3ac9a1-ab55-4b27-26ce-08d7ab2744a3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 17:09:04.1016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbnBwBs5Mx3A4HkRPYcTtQnNkT6V88ab7ZoEANMizUHYks9KwvsjJTJ/NQQQgkJJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hwc->conf was designated specifically for AMD APU IOMMU purposes.  This
could cause problems in performance and/or function since APU IOMMU
implementation is elsewhere.

Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 07914e34bc25..1311d6aec5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -52,7 +52,7 @@ static int amdgpu_perf_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* update the hw_perf_event struct with config data */
-	hwc->conf = event->attr.config;
+	hwc->config = event->attr.config;
 
 	return 0;
 }
@@ -74,9 +74,9 @@ static void amdgpu_perf_start(struct perf_event *event, int flags)
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
 		if (!(flags & PERF_EF_RELOAD))
-			pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 1);
+			pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 1);
 
-		pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 0);
+		pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 0);
 		break;
 	default:
 		break;
@@ -101,7 +101,7 @@ static void amdgpu_perf_read(struct perf_event *event)
 
 		switch (pe->pmu_perf_type) {
 		case PERF_TYPE_AMDGPU_DF:
-			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->conf,
+			pe->adev->df.funcs->pmc_get_count(pe->adev, hwc->config,
 							  &count);
 			break;
 		default:
@@ -126,7 +126,7 @@ static void amdgpu_perf_stop(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->conf, 0);
+		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 0);
 		break;
 	default:
 		break;
@@ -156,7 +156,8 @@ static int amdgpu_perf_add(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		retval = pe->adev->df.funcs->pmc_start(pe->adev, hwc->conf, 1);
+		retval = pe->adev->df.funcs->pmc_start(pe->adev,
+						       hwc->config, 1);
 		break;
 	default:
 		return 0;
@@ -184,7 +185,7 @@ static void amdgpu_perf_del(struct perf_event *event, int flags)
 
 	switch (pe->pmu_perf_type) {
 	case PERF_TYPE_AMDGPU_DF:
-		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->conf, 1);
+		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 1);
 		break;
 	default:
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
