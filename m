Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC4C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F6A20716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OZiuCqKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F6A20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5296E97C;
	Tue,  3 Mar 2020 23:27:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3356E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2rpAzDESwwq0zWNEZJe/00RO14UrQeZ4wNEOUcOM3ZGoRysXXWCV7Tb66AKOV0d1sGR6vRVvU1AfpkBK2cuNcfCArRTyy2SknW3qd9qY7QnxeIKabYwDiadQNpiQ339fjPQdKVLVTbiPKP3DGWFaCNwMVtwiF93KKhmleLAI/AjqAn42rZW0PQSN15BnR6IjHqI8wb75Eqff3iDQPN+kquSNjMh4y5122Qaz5EOc8pRgpUCaTWaZPSR4XfGhsZwsasd4z6Ku9MfFxFf9huSwyqs4XeeErY3Kfzd3LW+143Z/HpE9UvP6cF+s6C79jn8JIkHVnPALAT5mMl3roY9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6VLZaTYY63l61p6KnYGNpGreCEYFqpvKFhOPhuyWfg=;
 b=gsHUvzm2k0doYHrUTnO2ntZrx+NoIWSOoau0JXd+cYV8mnLbznt8lmeneZMkR6kseoXoqU4Q7n420T9RasGMSIK0Nm4a1C9WV3aTx+kY+ne7gSPVr29FH0TcNhQkVlgul7Hc4cYAwszCCp+CXo24dDl1SzKSeFI/BJs4+gJWHDemGRf5OetYOUQ9ETvWFfrvcbZR5nwOBTicu0zIbsW5vCHLPRhRzGLceEEGQpIjc0ZeF3Mak+giyChXlkUiAv1O/9mRuCxPZMTKiU05U84KMIuRaOpw0T1er5q9R0xW5/g8G3k5tAcsoIDc7ltOBKYOF4XF/R54qRD2tiCCzO8xCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6VLZaTYY63l61p6KnYGNpGreCEYFqpvKFhOPhuyWfg=;
 b=OZiuCqKNUWrWXeD2Xyo832LmWPOVFajG7ReUYNgmERG2hOs2Ln2fKtQbPoasagTL1k7cUra0jNxory+n35OxMv8vqLHYVKt5udXgGc1DFFfCyDhNZRSWxHya1pVJn/SDECaFOzhWwMpqvpFOJiYIcByqjWbEtj3aAy9u6t0yBAM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:35 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:35 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/12] drm/amd/display: Add stay count and bstatus to HDCP log
Date: Tue,  3 Mar 2020 18:27:08 -0500
Message-Id: <20200303232718.351364-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
References: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:34 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ee1b93c-1cf8-43f3-ebb9-08d7bfca745f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2441E5121C855FD3B2CD5D2098E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(54906003)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(956004)(66946007)(1076003)(478600001)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1UiDir7fLXlyLYaQOwZq2Kuz0XeZmfzqhqKe/Fk4uAYCtyM4hONe/igrivdzWPhxB8IE3vs25VnWSCyUmisOceC6VbWwtxm8Ab0TCIjkbWu57ExG1wVsN1h4Fhk6E5SmXMu5kNFwnxiT8HezlEdKMGph59d56KBlB01AkGQBkfsfRUKnUEdO+l4x7tFIW6wOKZudAyr32tK471CIrutBllt3QIWqk21FbFI944Qg6PZrC+jhcDDOHPO/houL9zYHupDgEbUVUWezenEfgWlK8Y5vCVoNBHXX0E5V11AHabNuTmFcTFnj0ys4lziahgDNMPkZaark9+8LZn6w6QtlCgYKM/UHh2gWpdNudwhn/9qeyocAUacTE+R+Zy6tW4TjmXepxltkeetEdlmNGbn+Ansj9Jmyp93Dhk1tlX5bRZwvqL+tqPkk/Ahk7Q3J+dS
X-MS-Exchange-AntiSpam-MessageData: V2kkD4ME8+JmTR+xvuC31JPSQWywAWMVRqLW93fe8NZi9ErEx0Px8/0GiUwjhztMb4xpe6Fpf+pIYU1XYW65Rbofb4jnCBx1fDYfC7WO5RvhPzKreSVaDuJTe80vsPdk7Y5OVvxSf/DULd5fwP61vQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee1b93c-1cf8-43f3-ebb9-08d7bfca745f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:35.4745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMn8ID9L74Ww5C3jEoj6Dysd5JZUTbZMwB1Pgfg3fW8tcYyOnQwRfjumP+te9tqI9KRh4E24wiLu3g5q21+bDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
Cc: Isabel Zhang <isabel.zhang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
So the values of stay count and bstatus can be easily viewed during
debugging.

[How]
Add stay count and bstatus values to be outputted in HDCP log

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
index 6e844825ad23..d3192b9d0c3d 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
@@ -37,10 +37,11 @@
 /* default logs */
 #define HDCP_ERROR_TRACE(hdcp, status) \
 		HDCP_LOG_ERR(hdcp, \
-			"[Link %d] WARNING %s IN STATE %s", \
+			"[Link %d] WARNING %s IN STATE %s STAY COUNT %d", \
 			hdcp->config.index, \
 			mod_hdcp_status_to_str(status), \
-			mod_hdcp_state_id_to_str(hdcp->state.id))
+			mod_hdcp_state_id_to_str(hdcp->state.id), \
+			hdcp->state.stay_count)
 #define HDCP_HDCP1_ENABLED_TRACE(hdcp, displayIndex) \
 		HDCP_LOG_VER(hdcp, \
 			"[Link %d] HDCP 1.4 enabled on display %d", \
@@ -111,6 +112,9 @@
 				sizeof(hdcp->auth.msg.hdcp1.bksv)); \
 		HDCP_DDC_READ_TRACE(hdcp, "BCAPS", &hdcp->auth.msg.hdcp1.bcaps, \
 				sizeof(hdcp->auth.msg.hdcp1.bcaps)); \
+		HDCP_DDC_READ_TRACE(hdcp, "BSTATUS", \
+				(uint8_t *)&hdcp->auth.msg.hdcp1.bstatus, \
+				sizeof(hdcp->auth.msg.hdcp1.bstatus)); \
 		HDCP_DDC_WRITE_TRACE(hdcp, "AN", hdcp->auth.msg.hdcp1.an, \
 				sizeof(hdcp->auth.msg.hdcp1.an)); \
 		HDCP_DDC_WRITE_TRACE(hdcp, "AKSV", hdcp->auth.msg.hdcp1.aksv, \
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
