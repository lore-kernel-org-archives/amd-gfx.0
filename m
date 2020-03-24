Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC9FC4332B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 11:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBDA20870
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 11:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bc8sm60W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBDA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED706E128;
	Tue, 24 Mar 2020 11:49:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E216E128
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 11:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIV+tnnovtBMKo4ykZUKvUzC+7KCcG7hr/R8f0NuMx3NUoavNtSmRlzDgYSys+hDG7gW4yJuswpsOCYneZMFuv/A2cJJI7gj9mYnxgxrzDWOvclFnlMwKOdZEL1bomF48ACqYn+aNoc1LkZYzsErwE3sC+beH/O6rM38HHMx8dSBMZnknS/8939NwH9LYtKUP59tBwEsplkw0i71dFMp7GtGdbaSfyPUi7LuV3arBjvPzAtLpa6GTCKpxLhOR8zb5x2w19mIL+VUVEdrbPik8vyDLd6G0g5lPsJtFnccx/N9/8hlFLOX/CFsyYK42TWiGfFij/SJRRt+7YR48qcf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIOta6ZCaAlkstkskCWZ2l0n2mQXCu5a0MFI5QKwoWg=;
 b=OqRjCFSHuxOLU/TJqS0/4b/zMKl2JubmbxxtivEA8alK38YLwhGMp7X8PDVNQBoa01rF2FBFf0YGdImxhAIGjEGjxcvDdSTSif80GzIJo4PPtydk1ACYOp0rtWBiUn82WLwpkfEj4u3efOtdqUMF3i4qHaXFRk6Qg1upSS8oMPaSjd+V7ozeRMo4uM+cU93j1gOfikjBlLDZKM5ymCL1DhhVbmzfy2ZOuRwKh9Aa2GVuiMNTqIhrP/u3sUv0YD0tit1I6bTxMDwvZgLfG58YBzRr5MfxvTDNCmc40Q9MIpY9eaPGNI9oO7c9C//g+39o/Fu/NtXcwat6HgIcVw11EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIOta6ZCaAlkstkskCWZ2l0n2mQXCu5a0MFI5QKwoWg=;
 b=bc8sm60Wjcahf826O+ltpIuw2qfVE9QLOWE4p2Ik5b4lGu/GczUZCKEe/m9bw6mO8VJLA0Hcjy6/Ak0nTJQR5WAcWC1d/2/G0uOrpjepROZTIwQ3cK8/czrdmCv+/ekQqu1ZISN20HxjeIJiUYD8l6/dhBEuselfwolQ4PaUk5M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3148.namprd12.prod.outlook.com (2603:10b6:5:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Tue, 24 Mar
 2020 11:49:48 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 11:49:48 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix FRU data checking
Date: Tue, 24 Mar 2020 07:49:37 -0400
Message-Id: <20200324114937.23299-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 24 Mar 2020 11:49:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fe6fc3c-da5d-4de6-c9ec-08d7cfe9745d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3148:|DM6PR12MB3148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31484CA61D167124664C580D85F10@DM6PR12MB3148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(44832011)(8676002)(7696005)(52116002)(2906002)(86362001)(4326008)(478600001)(316002)(36756003)(81166006)(81156014)(8936002)(6916009)(186003)(16526019)(6486002)(1076003)(26005)(5660300002)(6666004)(2616005)(956004)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3148;
 H:DM6PR12MB3721.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IQExuVygy5TsNw3S//sykI6vnFNGZGEc1A8Vl4puvO1OS7YNIrzPUjaux1/sDxYtsPqF4DqEfoP+nwtnkZaZa0BCYRNfuyxukDp+86LNBEeKDQU6Ax6BfwP2NLExSZ3WIFq6qZ5VH0/BsIYCT9ctQVzn2/LJ6Im12dy/8EipdGvtXdII7+pI9/TJQw+TWpxK6L1Tvek0zajjCZYWDXnjEZ0Gr2Klz0np98e7cnvixXHanwk6SgAVXTB8GpT3UhUrj0h+L1nIFjwNyZGLoPE3CRATkOAJeMN/fUznVZc0u6c8OvpWgrdhj0bUoIE00iqdnQPaPPd8193DpODqxU9U7FG3DN2Uk++wyOMmKw93rg4Tm3SBWtABp8oKUWb2rydp8sH0zSLfBo/cFjQZ/hAQg+e65K15sTwvPg76HlBMFysAkCz1ykW8dukLqc8u1kI
X-MS-Exchange-AntiSpam-MessageData: 06585eNfz2NwleTVbHk3byZnXX686za7h+rnfy6y9y/xPiqv5K94ufLdJ6p+oGemOHCaG/L3yxsLsXcS+Ud2QQKP332PCQ4pUsgTDPCiWbhbdZjy9w39dRylHk+qHgMW+294L1yloyG8/kkm8d/zkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe6fc3c-da5d-4de6-c9ec-08d7cfe9745d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 11:49:48.5196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTuc//BgpYSKymEpDhJJKPgB0oiTvy/zzqifLugSceXrRlA94bcmb5yFpCb3UpjbuUBKPWi6tukw7tZVN+UJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3148
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ensure that when we memcpy, we don't end up copying more data than
the struct supports. For now, this is 16 characters for product number
and serial number, and 32 chars for product name

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 6f5e98fda181..bfe4259f9508 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -116,6 +116,13 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		return size;
 	}
 
+	/* Product name should only be 32 characters. Any more,
+	 * and something could be wrong. Cap it at 32 to be safe
+	 */
+	if (size > 32) {
+		DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
+		size = 32;
+	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
 	memcpy(adev->product_name, &buff[2], size);
 	adev->product_name[size] = '\0';
@@ -127,6 +134,13 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		return size;
 	}
 
+	/* Product number should only be 16 characters. Any more,
+	 * and something could be wrong. Cap it at 16 to be safe
+	 */
+	if (size > 16) {
+		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
+		size = 16;
+	}
 	memcpy(adev->product_number, &buff[2], size);
 	adev->product_number[size] = '\0';
 
@@ -146,6 +160,13 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		return size;
 	}
 
+	/* Serial number should only be 16 characters. Any more,
+	 * and something could be wrong. Cap it at 16 to be safe
+	 */
+	if (size > 16) {
+		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
+		size = 16;
+	}
 	memcpy(adev->serial, &buff[2], size);
 	adev->serial[size] = '\0';
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
