Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF42C352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C55620715
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y5FKmI7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C55620715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1258F6ED17;
	Mon, 10 Feb 2020 18:48:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582006ED17
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 18:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFtmRf/KMqYloThcuwUCANlJ8SMI5a8kvQ88ZIhO7HH30pYvganO/uDW/StZOH7A7oy2dTPY0iwcj9lIXn9xMEJjkw4fCtSVcWwjsYkScgx1Pmrt3kM8qiCTHO3UmNOkCWAfXya5pm76AcUiOJ9DcMUKZXrwmM7+p4GnqRfOqUjWJlhiy1qZPExqTdKEDIKsKArhqy8r+J2zAf3LZX/1ndExkvot5a+Dp2wDCD1eVBEXuWBIsbPRfH8/g2fVFaJODflohl7hD8ogUV34Y7avmGNUq2VLuWr/7vip5OYY7SPLeJ0WypQ9FU8yY7/RTHi0cPB3iDHQ5XDT5jbQDSE3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYy4/GedHAmsJsTnFsDSAECp9kvO95kqQuplMmUSpbQ=;
 b=A725uDUvBPgAKSnI2THtEwwgFUoXhL8DwEwbrG4OI1aHdnwqKl6VRr6cjzXA646tbQvQxH1nfiaW85Pu1qfPYbB2VTLIN/f3eGMGpdXpwisRLnbrbZROIYMz8nIAQqxOzCBNUz8ReQBvRDA+l9ipAzb3pboCNz+lTWrr/1+STkpt1Z3i4c3q4jUKRYjyLTtUY+SQI7MLfzYeV/IqYlWGB59QLlR8TrEIbG3wfuS3OzGY4jDwfmLNMTw3yqvC8yA9QT/w7g9pbCXWCAjtF3Eze9pFW6B5132aKPJhYcw4fb7kAnCtx1tc+YdHDP4p0Yw/MdyxKvlcUuxjpwMZN7yA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYy4/GedHAmsJsTnFsDSAECp9kvO95kqQuplMmUSpbQ=;
 b=Y5FKmI7Z+x94abtGjMY1Qg6X5zCTw82TowiOtubqntHPzGiy6orfeL9uW9WIkVDF3d0vpEqViNfSGSRbFXNvFxkNxbNoSnKddV0WybZnOmN77mmm7sXKdpSoPp9sfplSCl3aVcpj7uxZ6L+bvzL6QW7B3o6q3WNsgivPKjKHJ1Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Mon, 10 Feb 2020 18:48:24 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 18:48:24 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v4 4/4] drm/amdgpu/runpm: enable runpm on baco capable VI+
 asics
Date: Mon, 10 Feb 2020 13:48:07 -0500
Message-Id: <20200210184807.6271-5-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
References: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 18:48:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 725d9306-cc0d-4d07-6dcf-08d7ae59cf03
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:|SN1PR12MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2384892696D2CEBB14E06E3CFE190@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(6666004)(4326008)(16526019)(966005)(186003)(26005)(316002)(5660300002)(956004)(2616005)(36756003)(66556008)(66476007)(66946007)(478600001)(8936002)(1076003)(8676002)(81156014)(81166006)(2906002)(44832011)(86362001)(6916009)(7696005)(52116002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2384;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkGWPnVDQzAZ3o0VizaTwrCrDtAxvSN/GhbhIFM6nSwy43O1udqJ3Rdl+9U696xn3kmNMySbh0L2hq1P0+hooZ8FTT/qrTFvpiaEFCxoy+QEFjTE/xD/WpozjnfVrpNQItyXMLbcS3vkIfTkX3klnMEVlsTMgsXNhfsniOEz3896IQ9V1i0NpDMYSwra4iCc6ew/ykn4DdKPSKiYXLPfDFORX7nyrLq3CWi+/ZreGaKlGhwdEGWQ+iwHWdfDrEifrbpLpmGyN8hi81hzGXwy3rZ6zRiCAiX67eW75OtOXWHivO1Y8xaBqHK/wtiX2SJsANdVqY5UmuqnrirJUiBF9DzJRr81YjPN+KBdzrzwHeN9+kbHsYziRXFKglg7Y8ZABv3gjiD2vh6y9GKJ8UH3Inc34gAR4OS56U97PBBRy5TOyCtDOVIW7C2ko1hayc1+WQ20J0vwZxxx1IzzWgdr+3pU6cl/H6LvZTp4NJ1dG2PgMpsHcm86X3eZCZP6RK//CWM1OYAcmGFx2geCcPzDrg==
X-MS-Exchange-AntiSpam-MessageData: bHaL+tuq719XDEB6iHJ7PyahIYjE98q5boqMCd42hCoeArZDrZUQT1XK3rxLXDUxSNZEFzfjSqAJRvCX265E+BEc1CI/fJwZkdh9L9lLRsxlufFM0KRochqX6J6ykjj1jQKImLmKYIQBxrxURmMv7Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725d9306-cc0d-4d07-6dcf-08d7ae59cf03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 18:48:24.6454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aG9g30qF0W+W/f+sk9i2b++lkSZIJnmPFuwi4YR0+ahXwvCe3EcTHyGD9U91X4g017SYwZxhTpgqpYZHYUcHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Seems to work reliably on VI+ except for a few so enable runpm barring
those where baco for runtime power management is not supported.

[rajneesh] Picked https://patchwork.freedesktop.org/patch/335402/ to
enable runtime pm with baco for kfd. Also fixed a checkpatch warning and
added extra checks for VEGA20 and ARCTURUS.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3a0ea9096498..0f3563926ad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -170,10 +170,16 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	}
 
 	if (amdgpu_device_supports_boco(dev) &&
-	    (amdgpu_runtime_pm != 0)) /* enable runpm by default */
+	    (amdgpu_runtime_pm != 0)) /* enable runpm by default for boco */
 		adev->runpm = true;
 	else if (amdgpu_device_supports_baco(dev) &&
-		 (amdgpu_runtime_pm > 0)) /* enable runpm if runpm=1 */
+		 (amdgpu_runtime_pm != 0) &&
+		 (adev->asic_type >= CHIP_TOPAZ) &&
+		 (adev->asic_type != CHIP_VEGA20) &&
+		 (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
+		adev->runpm = true;
+	else if (amdgpu_device_supports_baco(dev) &&
+		 (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=1 on CI */
 		adev->runpm = true;
 
 	/* Call ACPI methods: require modeset init
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
