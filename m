Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941BFC2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 12:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6D0206B9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 12:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0BHvyI7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6D0206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10CE26E06B;
	Thu, 16 Apr 2020 12:26:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7218A6E06B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 12:26:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG9YsK2ihV/rvKnRn7q9iGUvLRWJuI+DF+c5XgK4ppRXTrzaApZixXRE04ad92/wQdxPB1+vEMNLBTQSTAk4HLCp9ZWkcWnzhw2IEINC0IzG6OntMOKMPsUumPsWUhI38SZ3Ec4cLpyJGeawsqkgLq2FxwwA7H/jC1Bz4QXB3wtJDITVia8A1nD51bYLAcTOx1ldxqETH4Wx0JCWOOpHmZA/8xrEmXEjUWSfv5gdSVrM+8dR8kv5VgdADvYRIfMVRsO0hDxVIIZRc5T8JUJmsM0iyJVj2ZjqCzE8lVGHzjSO2UgJGx6TK/0oEUe1h0CENNTHUAfN3qM68IOYOApPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aT589gCNPD98rYthay4LGn/W7IBhGaY6pjmxEgViDo=;
 b=lk15Rd1spb4vFWf1ZAXE4wpRWpXQUTkdDDZ0ltJCciaSSbHiJUWDZ/X7B5dZwwsUSPwTkFChd+yArCdlOATxlUg1JHOos1+JffIDfkkR06IyqIGUVJ5t5xmISg5AzPzgZTUtEwiKA0rpBDMvXjQIClVPndIMChjQFjVTLrN1vS+tkqy9DINudcLzFH1iRtAqdL4yOMrac2WTXrndxZSkzNTGbGL4BW3VTBeHgqs3olLaJoxkCMEl/lhVQv8EIWu5lW84wtzAwTCp9JyUhsfBrMtkFhO0IoZh8/I3dPyb9g4SF6oKsmKPIxJ1GzliJPfsaFJqbr1obzJiKolLloylGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aT589gCNPD98rYthay4LGn/W7IBhGaY6pjmxEgViDo=;
 b=0BHvyI7eQKFZDBu1WzBYtx7Qs2QYkk2UQirQPU5syGm5x0go7TbdloQZ8twIWJB96vgpdopqrrpZl4m3uen3ST6336kFLcmbhfyID91ks2nb3L1jMEugihZETVdQK5HlY6EaX4taLZFpr6GbpOGBavuMHwjtiyKYHNpmrPnkkBQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 12:26:37 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 12:26:37 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Disable FRU read on Arcturus
Date: Thu, 16 Apr 2020 08:26:16 -0400
Message-Id: <20200416122616.29174-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 12:26:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6c57a27-9414-4506-a508-08d7e2016847
X-MS-TrafficTypeDiagnostic: DM6PR12MB2794:|DM6PR12MB2794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27942416B234589306CB558885D80@DM6PR12MB2794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(6486002)(8936002)(956004)(5660300002)(8676002)(81156014)(26005)(86362001)(4326008)(16526019)(186003)(52116002)(478600001)(7696005)(66476007)(2906002)(66946007)(36756003)(1076003)(2616005)(6666004)(316002)(44832011)(66556008)(6916009);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/KjPAMiZmaX4nN3Pz45jGuqMu3ZQCGMyWc4hUrWsZUDyhid8j1ZCJFAxcBJL7xD9Z4mfL1mTWeM3CwPPO5rt9HDg6rvySY8iVRnOc9K0Iuct8ttnv8AYcVoB9Vagrq0nFnwDfaEPf4/t1zcyNUYyhJjGfqgEV2zKXMXYv6m6pHnN5EjSIX9jQcGnjFll1aHXN66X7pXCuh8CoaZvjt0e02ZykG1zlbOU/ejJbyYIAOXXsOiszURKDFSBUkhQMw7Hz1DAovgXkduq0Tpj0pDf5KnsI76K3qjSdMnIAVEz32D6UMJKBz4NY4KsPWULXaGpiPwS4SOH7HbRhlNTWT+77GxaGiqik1myFbl8Skmlv/BwM+Q17dWKSP25qLS7BU+5v6IBm2YA3FceuJyBVyzpV3kHQHye4JP2iccBge1A/8OcTT/ZyRwPo6u/Yd0qsm7
X-MS-Exchange-AntiSpam-MessageData: 5ggGwO82EKvRK+IwBfwNNzAuEvKWdZ+a/excfw7pirEtYPfjPh4MqDzGwagFVoidXa8dD4SJO+Y1KsQF153/TcTvDBAEp0PBAoHXc3Fevx4oxi7V0ahSUYXzP6zZstV0Nc9orhZN54KXg881dMVjyg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c57a27-9414-4506-a508-08d7e2016847
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 12:26:36.9524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxXkg/eTwhCY7JHWs6MNgsRRV8NF5Fo3sqA/Gpa/r2VuJTLeUg3cXXanJZ9wH9VQEfpaMpkIcq/kDkpje8eizw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
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

Update the list with supported Arcturus chips, but disable for now until
final list is confirmed.

Ideally we can poll atombios for FRU support, instead of maintaining
this list of chips, but this will enable serial number reading for
supported ASICs for the time-being.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index c7e55fe170bd..815c072ac4da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -36,10 +36,11 @@ bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 	/* TODO: Gaming SKUs don't have the FRU EEPROM.
 	 * Use this hack to address hangs on modprobe on gaming SKUs
 	 * until a proper solution can be implemented by only supporting
-	 * it on Arcturus, and the explicit chip IDs for VG20 Server cards
+	 * the explicit chip IDs for VG20 Server cards
+	 *
+	 * TODO: Add list of supported Arcturus DIDs once confirmed
 	 */
-	if ((adev->asic_type == CHIP_ARCTURUS) ||
-	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) ||
+	if ((adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a0) ||
 	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a1) ||
 	    (adev->asic_type == CHIP_VEGA20 && adev->pdev->device == 0x66a4))
 		return true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
