Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBB6C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B12206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1+IVAAn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B12206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 100736EA8F;
	Fri, 16 Oct 2020 03:29:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585646E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLKDCagtPgbxcyiqNEJnEoUwi1XefMjaJ5g7VVkrBxxUBZ181P+mKoRkS7VxuPfyvAHTkWcSEvFY8/TnI4XHa7f5YfxE5GoWkzmoasycMzCeXkh5WSShopbp8y7TpKXDFAfoppBa+3pddfbjHAa9cy3x6l6tL8xanLSDl/+oS56rkA1kGCMMdUPkW+/2tZSfCxknr/Wvw2Yoyt+5HT7XoSjtlCJOgArXPD4Ls52NBKwcmxsWrGG5Z2Lk4tHMqI2BZuuEUz8x/sC+c2/Q884mS0CXWdYof52gFVsqkcvWqqHfuMBhHcJ9JzPpgn1kaZtKhrI+749rRwyqsMYWvbeqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqz5tCsdcS/Vtfffz/ddYlNBAUOwLYQK7dgclx0H1AA=;
 b=bMGvV60dzy7+wkVxWDxoLlJPwYcdt1DyNjgBbNTTlQhYJcd6UHJSizyvbb6qd+Z2H4FUkHoPcKyc65aLpvBXsKtVoUv/fZpv3QrtfVyrPDMCH2Jj21m6zxSO4+624QdHIxmwP6czfYLZ3GQAiiaXZnu25/Ef0QZq2pJ6qs/bOpyYOtH46sv9OyhYmq4XL+LR00229CVGfH/QSL2jjAIPFMtrFzqGlIFeoreE+Rvj2fPsI88hgFoHJP/AhFfGzPVK5w/Y/ovEv2qGpTfZOtXDK8+uP808b7ebTeb/nHQMSqTdextziBizAqttXPupJqEdVKuWL7mLdih8a6lRjax/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqz5tCsdcS/Vtfffz/ddYlNBAUOwLYQK7dgclx0H1AA=;
 b=1+IVAAn2NZM59SEknEU7G6mWCstwmGiNTYeIUK8kPsxdFQGUiPr9F9RrggNRcFTfF1LeOV8KN02cyK4RrlFsBBtw/weqVuJ9RCttpWzwGSYSEyBaOM9YLybGlBY+j29UVb1NrHJ6EFeG4WuMljAMwk5j/1KEBH4Pig5g66gHVzU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:29:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:29:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/40] drm/amd/pm: drop redundant display setting
Date: Fri, 16 Oct 2020 11:26:52 +0800
Message-Id: <20201016032652.507-41-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3529eaf-49ee-4b6e-ab4e-08d87183959d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13543A8F0E59384ED65722A1E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +c1BKNKU9FW8E/5fW+vBn4EVShT7gQ/QnZ1G24UC3wGD3ruTbpzi1kQkhyhfMbARlDRICURff48mMQvHomugMSWGnzlZFOouhAhaPAjI6UJrGsmwqTBR4VpqIep3upzJ/LalKDbt35uVUZ2pqduLt+n2EJFgeZTCKlAcMJvJOCFACLuASwSzksELMi5LzKGIlknQAEPFDqa62nMO5u5fhKsxKejryWLx4k+a8bbejGhibFAnZ4Y4gd9eKsTWpxRzXxI642iyuseQ2AK65C3gteHcqa7tw27p3swdqJjZFZue4wXgw30Cq6qRKmVn9Bhf2yrB5oZD2z69LcEsqgukeaqEMCfWLFP/TIbxPVedJ01q50rSGdCmQiP+Ygtm4o/m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 24nJ3OSANYRnLtSKZY2Uvojm5WOpcv6KIeVrQjl2i1/tQt9byhUgs6gRW8BePtbC2WsP/t7H7oo/Qc+5NZ0VgoPCKVL368XbCXy7G0xxtOK90ntvV3Hrlvbahu1HfEKK14SXZI1EBbkZczkTO9n5gyU89H4AI2jKP+h7et2fT92ewYWDETVXbH1Z+E6rrTFBukQJ47rhU74EdxGXBmacNmSwccI8pLRh5DKaIlLvfXyuCSUOZKum6e/1ne+dVkHcZ6w8f9rS1ec6yD8jaakm0aRIPIj7OGraYFop9oVu2OQVjqww0pNfFW3ZapqogsdNRzcz4KE/c2fLbgCPzoGh1EIjDpuNrvNtv8jkJIxhjqkbn0GAEUISieH03RGGmyeQgeB8uNJVNCFEGqosiDCM39DPSZ/4H9TiY+kFWrc4YcHHJWllX1vh5MLaCgant7TGXKl6q/oREl80kqub/bq0SwGjixoEaky1i3eNoFpFNsBIiZkFx/AzcYDbH/Aqih2M+qZoaUbqN2KDeSjJmWeLvlzJTbrOI03TRPHR5xM2YEWW2VRrBpsyw/xnNvI7Lcp6RM6DLCTNBwHI19c6VVHD984ZhF/h4I0QjqPGZ87mon/x558SFGVSdHiKallFKFGkV2QUkrlMrkIHfG7cVuoG6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3529eaf-49ee-4b6e-ab4e-08d87183959d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:44.0886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNOgmoYnk6jRe2hSGNQi1UeW5s+qjHKpYp/jXg2Sal0IF2lb94aG9V10UGkfJrBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As this is already performed in smu7_set_power_state_tasks().

Change-Id: I2b44e9f872c9b7ce7b38df4b97139c1f293efaf0
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index d6c903e80692..49db61a89505 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -4424,21 +4424,9 @@ static int smu7_set_max_fan_pwm_output(struct pp_hwmgr *hwmgr, uint16_t us_max_f
 			NULL);
 }
 
-static int
-smu7_notify_smc_display_change(struct pp_hwmgr *hwmgr, bool has_display)
-{
-	PPSMC_Msg msg = has_display ? (PPSMC_Msg)PPSMC_HasDisplay : (PPSMC_Msg)PPSMC_NoDisplay;
-
-	return (smum_send_msg_to_smc(hwmgr, msg, NULL) == 0) ?  0 : -1;
-}
-
 static int
 smu7_notify_smc_display_config_after_ps_adjustment(struct pp_hwmgr *hwmgr)
 {
-	if (hwmgr->display_config->num_display > 1 &&
-			!hwmgr->display_config->multi_monitor_in_sync)
-		smu7_notify_smc_display_change(hwmgr, false);
-
 	return 0;
 }
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
