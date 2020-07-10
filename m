Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95BAC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A643420748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A5niN3FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A643420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4686ED0B;
	Fri, 10 Jul 2020 20:34:08 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63ABB6ED09
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEclNMt4AEcfXFNIVtylwPvd3XASLn7INKbWqn87lhAmCZvAarKAgXNuP0K4kmU3LCviXjiAK/p3FOoJlF9OjJgPwytUYm+okTqt07mr2FQw7Uw1j6gg0NopOGp7RnrJBA1ptmNo9vzgcL77D17yQVGgbcSRYOEsy06+rQDU35jdGfoPoEEeHVbjC5cV4hJgV8TMqjOvF35yUpCRc3iuYglPKtzKigTLJWDsBfT7xVe4y1742mTOpoTPe5qxX6jkM/gmQ2yZIEZSnSJrVxaGtcD8ieB7A3RJ8awSiU5/BqHQF/5T+MBa+64humCn7YDWUL7feRxanEnTsGp+Ov3R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN5UwhteYtoxml3Ak4BoRL/xX/HWJqs9qyXbNaW7GRI=;
 b=nrwj9jt+oFHomt+NkDFK+ZPwJbIrPpmeP6YDaLSDxWfLVdsR/+Z45hFNFY8XYzQzZ5GAwzI5ko6pEUZROKqhqZzWdUNOw7Dsk3yq+aHN0s8XTdxtp2EK5bC/90WDFAao3PQcGQRf3wldzCur8olJI5MU9Q6Xiz1hxKroEG9v3DtzZg1fc+mejvNZ6DJoHCVZSZCCUmgYmdqQZ1aaC7i3ZKeA9r7NoLI+XzR2gPlxAlt8UZIB+fivL7Ip49r5LT+Yv00J3LU3atZXp4OqkfrXy0d0EdmE/cao/8nXszMpJIxUP1cSY94c/J/1+l6cW61/pcdfkaFqS+jZqMDiFnZTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN5UwhteYtoxml3Ak4BoRL/xX/HWJqs9qyXbNaW7GRI=;
 b=A5niN3FZt329ySaTK5OF4YuWKgqg0JUp8p99q407o9lQpPjheSSZAnH6jCLn5rBqpWmIHthCA9RR9mbEtL/0FHWZ1/b13hIwSAbr6GVcRf9CCy2JS5wIr5i7bpJvkwohq3HE/E3/7Jyg8k/O8tIzjeU0//8bQu4yLgBQXSuID5c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:02 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/10] drm/amd/display: OLED panel backlight adjust not work
 with external display connected
Date: Fri, 10 Jul 2020 16:33:19 -0400
Message-Id: <20200710203325.1097188-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:34:01 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ade2866e-8867-402c-a016-08d8251094aa
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4231394AC9FE163BBDA5727398650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTpHADZ6u1FtNBstKZXUopvZuaQi4bXAjBIIPoad0eOhRZoJvnaGEbB0vWMmh1Hx5sZtqqgnRlDP5xosEcSLyMsm5HbBGwFyxEjrfZ8JgapbN1T9apqcM3RCx7EJf+cND+hd6WjB4JZ/bWbgG08Mx0dtlwqudSFXZPA0NwSdhmCC27kpPkJ1wwn4NSOgxB1GpOYqjYkzuswwY9bM8prhm1tHG/Wd0hXAXdR8qFNaT3PtUS4IbvOqIpaRbr896w8vCHijywM1t/BNJyKwy1vIuWvpWcmsPZ/bqHPDWkt4fbBPbIAWOesnpz5OQak/L3PLNRkyEvUc9SbO8pg0m7/m2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(54906003)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Wo9ZNqWgUdg2WhsL5gc2C5hiSd61gZ6daIXB4gMbf1CtQo9ML1w/0zBtzw0yksU1R/P8gerwApNWxm7SWirutDAabcXv+8utH3ViYTFwVxPPsjN26LV3W7aEWqDtlfz4bqt13MtzVVfJxDra2MiPyqaEwYbhoxgstMkbogLpgDMv+dkXhl/jFgAFs/eIAXYeKYerSyQ4f5DsfgTCMVadBw1/YYg3KzpMzxrrK11Rx5lYGnn/nBIkQWcC+V5QcI4EcErvrGfIvME9hYv+gNAya4nMaky9RLglloH2m+uXCGCrEPQKG5Jff7K+Vx1adu+ekazpjLZjMcNj6vZncynUt9tNb6fxMLlJOc0SBUta4CF+ju9Znn+m1etrmE5JJbFYXiAdtgXruzYdTNf59lPNkkASl1JvdLMXR1Y9YkpdufbmH+S25Mu5mh0D5hC+iYH5o5lKlaxhda+risX9fjDw90s47lSYF9FZhLNFDFonsJ9qbuoyk+eltzVWlFrUfK5RPT/FwAcuk7F7G/WH2vfoNA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade2866e-8867-402c-a016-08d8251094aa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:01.8412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1xR+Hyb3ZDYzu2rLebRZOFK0C5PYok3J0FtERDxwYR7vUC5jIoVWpuPPeM7V9k9wmEaqCrpScF6JsyAuhnZNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, stable@vger.kernel.org,
 Aurabindo.Pillai@amd.com, hersen wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
amdgpu_dm->backlight_caps is for single eDP only. the caps are upddated
for very connector. Real eDP caps will be overwritten by other external
display. For OLED panel, caps->aux_support is set to 1 for OLED pnael.
after external connected, caps+.aux_support is set to 0. This causes
OLED backlight adjustment not work.

[How]
within update_conector_ext_caps, backlight caps will be updated only for
eDP connector.

Cc: stable@vger.kernel.org
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b4e120e95438..5569e0500734 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2019,6 +2019,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	struct amdgpu_display_manager *dm;
 	struct drm_connector *conn_base;
 	struct amdgpu_device *adev;
+	struct dc_link *link = NULL;
 	static const u8 pre_computed_values[] = {
 		50, 51, 52, 53, 55, 56, 57, 58, 59, 61, 62, 63, 65, 66, 68, 69,
 		71, 72, 74, 75, 77, 79, 81, 82, 84, 86, 88, 90, 92, 94, 96, 98};
@@ -2026,6 +2027,10 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	if (!aconnector || !aconnector->dc_link)
 		return;
 
+	link = aconnector->dc_link;
+	if (link->connector_signal != SIGNAL_TYPE_EDP)
+		return;
+
 	conn_base = &aconnector->base;
 	adev = conn_base->dev->dev_private;
 	dm = &adev->dm;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
