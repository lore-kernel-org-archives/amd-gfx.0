Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2D7C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 09:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A0C207E8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 09:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I7ZliA/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0C207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5461E6E876;
	Wed, 17 Jun 2020 09:44:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D5806E876
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 09:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGiD3sS+dHPR2ZaANdf6o28elL8Toe/j/g1tuZD6U0JJEIiJ2ZIFRudp5wfGycafb0KYt3We7pCKi+PhXC/swPGEaMTOdpLbbsYMJG6JH081S7XvYR7ChrvkBwOtW0XAQZTCrCPfLzxnwmjmLcoP8d0ShVWIX1ocxtgqxxzZbvscT/XHjnRXU+XQidprK30F8sWMTMRwWRMLEjA2Kbvtcnu6SRD5ApXPgsVsHrsMlQN4PxPlBWRbvoAHEsS8ZZl0LOgHKHqfeCGBAZLfGTWRRgFbwuZ+fkspwhg3F3V8dg8qb5wNMeXH5oBNcZC7MzSqPei0Oz/gon1RK1eNm1bvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We/B6RaDv6pVAzBcro3oDSLIlEN2NNqs8Iv4+KXZ+H4=;
 b=DzdNhEj+5cnEGYgELte0NZtvw5K6L0UN56n4fMJvFsJvKg3nFG1RNQgUyhqpXukyOpp8h4OGwTX+Znj3VttSOCsZde14URibnB7G9oDWRQ3ZfoCl9cSD4MHZ4ydpi0ThuIFuXQEHjEGF3eQ4ucY8szTwtcDcpB5ApptuhN3rWz1I6sxwZNRJWtuQpTprkKa4Md49znAlzOWiLUeaJlcAOVkGhof5oiVHOKO7HkBup6fj4ayOLTmSOxrWHRTJycJrTzgSEyozyC2EUVKq03Wvje2REUBXME2tJUvE6WiprfPrmnVPPk9TMiBSxdbgp1AmRlb2TnbHPSzwvOMtkRZSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We/B6RaDv6pVAzBcro3oDSLIlEN2NNqs8Iv4+KXZ+H4=;
 b=I7ZliA/mpUueSGr1TmrRufRJm3GsDLkOkNLWkzlWpWRViWmz1+OjJ0UPoicrN50UZkv327EjL1GNHgFQSEKSFHhgGy/N5VK0pgMWsZLeBwpZmquvrdqcoINWqGLXDNL5gp19HkzdMx6S1cRFjmin7rAQDEylAl5BuSEPVbB3b/Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.23; Wed, 17 Jun 2020 09:44:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 09:44:51 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: declare driver if version mismatch as
 "warning" explicitly
Date: Wed, 17 Jun 2020 17:44:31 +0800
Message-Id: <20200617094431.11411-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR0302CA0003.apcprd03.prod.outlook.com
 (2603:1096:202::13) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0003.apcprd03.prod.outlook.com (2603:1096:202::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.10 via Frontend Transport; Wed, 17 Jun 2020 09:44:49 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e72d07ea-8762-4959-d6a5-08d812a314d0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB183612ECEB0CE6172FBCC721E49A0@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:53;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGHMXF5/6lzR0MfI/U5hDXqmKlMVdRBtTUTUoEp9rkWIRdIiydxcXaV0cke9MNWR54A6gwP2LRELG03+q3uaIlWDnMGvnmOc/ixMNvLE32HLkfA6DChfQ8hGBLo18KJpadNrK+jLNsywLx+9POqGME/+sZI3llrtySveLS2ETOZ3+IoWm7cNIeh0+WngfToz7QVb/phK9orY8MP558Y+3d3n91s4BqIvKDeIwDNk/6ddtq1JX40mSWMHjbnu7U4qWWaWvJuKd5URnXWxoxuFX0mPWYJFuWlLMOeBhk9qQqp+8SrD9cIcbO5mKQ+x173y5fHSy1imhJQ0P722i073Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(44832011)(2616005)(52116002)(7696005)(956004)(86362001)(478600001)(6666004)(316002)(83380400001)(36756003)(5660300002)(4326008)(186003)(16526019)(1076003)(66946007)(6486002)(26005)(8936002)(66556008)(2906002)(66476007)(8676002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P49ByAsdGTx342rCED/DBB8tLCvLPkPXmzQp0zh7Jq6JUXbyHp4E6cLnSpOt+QTcjgr/dJLRAbKhyLWDnBBgQFYCVH8F0wx2E93Iidg9u/MYqw+CahJgMknnC2JrK6H0me3hrtm04CvNjCpA9DTXsknXZZPNtRHnWfm9Ht8QvlxBFy6rJBhL32yjUvXuqsHPqHQs5ZnLkafBjhhoIj7z7dUmbsHZYNk5xc3FX6fmKWbKoqeXshUCi4d+4N5tJiIpimztJI66tYBJ6KLDL97U6rM1z7JsvZZ8IeXIuAZjT3kHJMzXdwxNBltU6ap9ckUhaR8dZkGYpFHSItnHu39SKSGQsIrPhK5n5s4BHBx4ZCQmwTIfqiCeYV+P8I+HtyV9RS8T4ZMIcLEYSiSa5CEIg8oxGu6nborgkgC5/65z3rryUDS/ZRq0GFIf/nVROD1GxzeWC4/MVxTY0LHN3T9d3mVXxVxlzdkCSGCMsiiKkXuH8rosZhEBuVpk4yAeT6Xg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72d07ea-8762-4959-d6a5-08d812a314d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 09:44:51.8131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV9HHscJxl38fXzlBJSsoqSn2sE9WTzKDXW0qThG08aq/OjdD0o9NsXvnp79lx7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Pramendra.Kumar@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So that user knows it's just a warning and can be safely ignored.

Change-Id: Ic518ec3eb68c6bd6682e6131e32cfe90843341ff
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 2bcb8d16f1b7..22eabc10ea8e 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -318,11 +318,11 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		dev_warn(smu->adev->dev, "warning: smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			"smu fw version = 0x%08x (%d.%d.%d)\n",
 			smu->smc_driver_if_version, if_version,
 			smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+		dev_warn(smu->adev->dev, "warning: SMU driver if version not matched\n");
 	}
 
 	return ret;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
