Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33341C3B185
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 10:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B2720725
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 10:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3gC6TRO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B2720725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AE689B98;
	Mon, 17 Feb 2020 10:32:58 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B511A89B98
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 10:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTtnCCJgqk7lbl0rlw8PqVUeOPXrGlQW+tRHimp0Jo+XEa8XNCldyc2liI5ib3+bCfMFWC6tZfbkLTJ2giJ3OZcWDXv+YRbUJ783/8okVKXpErx/lVpKndxnuPKRdDJaksFQR7TRALyem5rcBqiF6l5qaS0xhZvszqjqrNzkXh8IIwv8Xji9HP18MiW3BaZ2aRtu7RKO94aC1gcamhSUFQXNKdGTzpW+QTzQuK3w98ySmlLha/bQJA03gdqhHy9FfLKyQAJVXmHYC3dbjRm1p0r/oxrrFV21fjpuYXruM+7/mqXg0z46MUWAtoMAIf/IyemBg4ZoCRKPbhxaUjIGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCjBIWHhBI44uKbljAo+lp54Qzuo34BU5mfGd1msr5Q=;
 b=ZYhuFLEtbXfoCKpkQpujG7GqNxB5JFaVjeYwvla2Mv0JYdjxNFxCm+GG9RzOA2pX4jAGPjTGO3tspBvnMSqKbCRJX1Rm+BtYFJyxz0spTuk2cSGYUojPDe29TJRYzObbBRD7UTRdBS0Hyro33NJXbPHTRQKzA/0fopnEdESEy2Pss2owAld98HwJO9y6zu7kmOH5a0wQY62Tq+eUmmOP5lyxqfCElbpaHqVZrYqriCNU1iK8SmDuZrmX0yZCDUJ8aOg/ttwTIm9qCllltuz3NqR7c9vPMAcA0/FZ6HRoM7eWvR+dxrhhSG/3J272BD4mEEotWaQdpOijtOhTIhJgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCjBIWHhBI44uKbljAo+lp54Qzuo34BU5mfGd1msr5Q=;
 b=3gC6TRO6XFAiOCxg4q/ZnvkP6VyUjjvD+sjapV5nRkMfkvbat4GZuq6V0Mz62LKfE921YeBTMbOjIfOltLU0zkOkf6rD2v0W/RB3TThCl+B/jQCjusO7TaDh4Od6dUk20mGB42fUzMSOE8fOETCy169qOMLA1Ux/hk2zft6HGlU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4046.namprd12.prod.outlook.com (52.135.50.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Mon, 17 Feb 2020 10:32:56 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2729.031; Mon, 17 Feb 2020
 10:32:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop the non-sense firmware version check on
 arcturus
Date: Mon, 17 Feb 2020 18:32:36 +0800
Message-Id: <20200217103236.23783-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0059.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Mon, 17 Feb 2020 10:32:55 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fe63813-f488-4ad7-f900-08d7b394c083
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:|MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB404682169A62FD35907935CEE4160@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(7696005)(5660300002)(52116002)(8676002)(81166006)(86362001)(4326008)(36756003)(81156014)(8936002)(1076003)(66556008)(26005)(66476007)(66946007)(16526019)(44832011)(186003)(2616005)(956004)(6486002)(6916009)(6666004)(2906002)(316002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4046;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/3IazZ318ew6FLmrn/i6wfJg0rLLcHvvEhgHFzzlEwCxSGO26POLSwDNS3XdXojbYy0vhd761dJNws1qPHh0CT66FL5bces/wVDrI64/NYj3tzGg80PD5vJH50NyrBXF+M7L7zHHu9tDnaWseX/0EE7WurVitYmeWpjn8r3X1VayDEs/hyzY5ZKHAzao+PiI6uC1srTPeac+HiNPqFaDFAgUKcUySD8TULhpRvD4sjDcFehU5QEZPZeRnHb30kKU9IJnjVw0PzXI6J3SxK2jN6mLd8ep8QYoI1bzgb+QTEVg7W9SCGfwmjOfCbaktSRUmh3qG/6Qo5p/cFHnZ6UtldM9Qig7oHvsxvsWg/ribKjedSAsVeJNpQu5n+u/lusOOJct4YBLG5hO49ZGUo6YyKY4zpkmzsGqCs6zT2CAX/+CpbiJz5w8r/1MrmRFjwM
X-MS-Exchange-AntiSpam-MessageData: lRbPKohpRMbyq1uhrGICPUCo5lEW48wmEQC62MXWfoouB0o08IxpjFico5lSnEBz5/A2xA8XVPHzyXDpZpC3Ezd2mW6z7L/b1ZJTjvPh7CAbLzZ3z8G4FcuonQMTyMIvibkwVE+7KaTVBNAKw9Cs/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe63813-f488-4ad7-f900-08d7b394c083
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 10:32:56.7637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frcbr+a1zHb1DSaE2ErEn6eMjp1zmFzL6TFNwTFtOtNb4juijGijqzu9uhZoYhUe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As the firmware versions of arcturus are different from other gfx9
ASICs. And the warning("CP firmware version too old, please update!")
caused by this check can be eliminated.

Change-Id: I04ab0e435b6ff9712be502e6ebb8d6e1f0a776d8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9b7ff783e9a5..1c7a16b91686 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1106,10 +1106,11 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 	adev->gfx.me_fw_write_wait = false;
 	adev->gfx.mec_fw_write_wait = false;
 
-	if ((adev->gfx.mec_fw_version < 0x000001a5) ||
+	if ((adev->asic_type != CHIP_ARCTURUS) &&
+	    ((adev->gfx.mec_fw_version < 0x000001a5) ||
 	    (adev->gfx.mec_feature_version < 46) ||
 	    (adev->gfx.pfp_fw_version < 0x000000b7) ||
-	    (adev->gfx.pfp_feature_version < 46))
+	    (adev->gfx.pfp_feature_version < 46)))
 		DRM_WARN_ONCE("CP firmware version too old, please update!");
 
 	switch (adev->asic_type) {
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
