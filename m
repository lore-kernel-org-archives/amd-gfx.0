Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1A9C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01938206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y9AwXEIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01938206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA266E32D;
	Fri, 27 Mar 2020 03:42:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96B56E32D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTWvjMQAg2hSSnn2tuIgVxoEnAc1HrxoPjNacuvD+Dkp1MV6na5u055zuk4VYlY6reFBzsa5y33tm8628fcE5tK/RdelctdJn8PJZ+7/edimC9tUHChImuRRWKgyGWwBo4VJmAvD2PzahLI2A0HNGKQUhQ+df8VlFRpvARWcHF9zKaZ65hVg9rnwEkxo1AgbwCfh4Bcs9/sic3vdO5h+olBHkMJG8jMOKx8M7WG2ZdMMzCFsgDuZuLEWRFh0AhRQXc33TugMNh0/tG8dZwSadCKrwpdhjM9Pvt8BWMHB9ZhnPqLepMYV9zS8CYleBfvVWtRgqMd5dv/0Tnl7KFo3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDO+DITy/Bihb0SGkiPlxQHmEwhw+G3z1+DRJPSDQjg=;
 b=BtJhJypTv1s4BqDKt+6bZ+dNgcg53YvMj4yJ23Ef2CSP6l59jkCAduYEH1PyOI3e/zlMu6Ry8QoVyTcl0QpwfjLNpzVYOkJWor4jnKuVqTqmtRhuTONsFIHuS3FXtmKzxU8TY+6Shn6b4NyY7D4pxtNRjpAZznWpJ6KllX2QDKVQYYrIy6F/4Gl74/+uNRNjQJ2kun5r5n6wKTVkxDPw1FGEYc++4pac4isK+geL8r1xw03biwdeyrl9ptcmWqI3llWW38BQykqzcqX2b9R82cO+24+W0o17IY7HUUl2+Q27lxaEqeNykvu0r/De7FOsLdHoldcOrLKK3BKnpPZz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDO+DITy/Bihb0SGkiPlxQHmEwhw+G3z1+DRJPSDQjg=;
 b=y9AwXEIpi6yeui3srSBVcwXyZvAedOq0G6TVOvg1UsziSYj7eo5ff2SibZFdDZusNnnqkpZNfSCsSJZNj331SiVrL1ym/hiO8lzsknh+BIAxQaj9vV75vnEOMyTwx/4pMl9gomzN6kmrwILuWonYD2acdScILDa3hSBez88cU+s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:42:07 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 03:42:07 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/9] drm/amd/powerpaly: drop unused APIs
Date: Fri, 27 Mar 2020 11:41:32 +0800
Message-Id: <20200327034138.7653-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327034138.7653-1-evan.quan@amd.com>
References: <20200327034138.7653-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 27 Mar 2020 03:42:06 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60998102-1dad-40c6-e1ee-08d7d200d2af
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:|MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4373687F112F96CE8829FBF8E4CC0@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6666004)(6486002)(26005)(81156014)(8676002)(6916009)(81166006)(16526019)(956004)(4326008)(186003)(36756003)(44832011)(2616005)(8936002)(52116002)(478600001)(86362001)(66946007)(66556008)(316002)(7696005)(2906002)(5660300002)(1076003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4373;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqpSSq48WkiImXwr86wmD5uyJb+/Br2JN2Fz98ZJib79sYR4FINGWs1osVagecStPIvTRGasMuIm/pN1Vu9fNav5dp4pg+j9FMUYuliTB8uj3r+aIzxfbgtmVoOxsMXd4qlTMkaeJPhbPD1JQ8qkQOh2pOEchA/4bhTJTFptKHv2ngI5H1JR0kCdmNncqv07W7fJB5wyDkfD3gJRhYn7My6RzNy3ImfbpajdzFh2z8GKOSwcRKpJY/6DSOILjoJIh0VsqUW8m2wsAJSUqCTDjIzod9rZzi6ZqkDRDsTLO0um/OjhYZUGYJFPA6XglnAHxPsYsXDGpIFKusUYwhEZhS/HqVVLam0ny7tQmVC7GYctHbjaLMyTmAd1i8xoIg7p7h483BDtEiTC2p2ikxyCmXmXwiKhIiv3SuWDDw8OzDkBCrLej0fetCI4xLF91n3Q
X-MS-Exchange-AntiSpam-MessageData: j89wduT1+T1oarrMtQKzqhBkr4EogadRzPGASfiy2vPKiv3SOQNMbnMDL/gCbXl9JlElQNYTu/EnbHlfBgFEyez8b3Be24RVUukxykQRk7UPwwoFxDgqvy409+AqMgyzw+HziU0y6NwBUfjR+Lz5jg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60998102-1dad-40c6-e1ee-08d7d200d2af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:42:07.5537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mg0TeMFa0NG9H4ghuAzLD/tdWS9ZDOqMINznakLo/GJdIaaHAAwDn/0TBZ3SEnBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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

Drop unused smu7 message APIs.

Change-Id: I8fc13b626fad04241f2b9353419282eaa14923af
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 14 --------------
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index 07460ac74ac5..627fe77a5f51 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -191,13 +191,6 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	return 0;
 }
 
-int smu7_send_msg_to_smc_without_waiting(struct pp_hwmgr *hwmgr, uint16_t msg)
-{
-	cgs_write_register(hwmgr->device, mmSMC_MESSAGE_0, msg);
-
-	return 0;
-}
-
 int smu7_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr, uint16_t msg, uint32_t parameter)
 {
 	PHM_WAIT_FIELD_UNEQUAL(hwmgr, SMC_RESP_0, SMC_RESP, 0);
@@ -207,13 +200,6 @@ int smu7_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr, uint16_t msg, ui
 	return smu7_send_msg_to_smc(hwmgr, msg);
 }
 
-int smu7_send_msg_to_smc_with_parameter_without_waiting(struct pp_hwmgr *hwmgr, uint16_t msg, uint32_t parameter)
-{
-	cgs_write_register(hwmgr->device, mmSMC_MSG_ARG_0, parameter);
-
-	return smu7_send_msg_to_smc_without_waiting(hwmgr, msg);
-}
-
 uint32_t smu7_get_argument(struct pp_hwmgr *hwmgr)
 {
 	return cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
index fe27f46d2f5d..e7303dc8c260 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
@@ -60,11 +60,8 @@ int smu7_copy_bytes_to_smc(struct pp_hwmgr *hwmgr, uint32_t smc_start_address,
 int smu7_program_jump_on_start(struct pp_hwmgr *hwmgr);
 bool smu7_is_smc_ram_running(struct pp_hwmgr *hwmgr);
 int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);
-int smu7_send_msg_to_smc_without_waiting(struct pp_hwmgr *hwmgr, uint16_t msg);
 int smu7_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr, uint16_t msg,
 						uint32_t parameter);
-int smu7_send_msg_to_smc_with_parameter_without_waiting(struct pp_hwmgr *hwmgr,
-						uint16_t msg, uint32_t parameter);
 uint32_t smu7_get_argument(struct pp_hwmgr *hwmgr);
 int smu7_send_msg_to_smc_offset(struct pp_hwmgr *hwmgr);
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
