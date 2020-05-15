Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC31C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F29C20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mW/K+9/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F29C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285F06ED2A;
	Fri, 15 May 2020 18:14:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700054.outbound.protection.outlook.com [40.107.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C87C6ED29
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck5KlptmiZhb3xwdH73nBgRbQeMKWpE97oVR3v8Bl5qhWgX3Z2bszsO/IVGYLtaTo7GjfQ+I7VqEIseeZUSWiaiWVWfHO8WFJ4zgberdhRCvfhmu+H2xFDzmbqLhqJDV3l6s27+H6U5l1SgpARE0wR/nprfGG7lxawjjRDxzSLNXFXg3kHmy99P1A4noAZGhIxqgx+yLwzqFSUedihZeh96E57yzQWYsW6DDqmpN/1nAIqai6jmKK0liV3pEIfMZFHYTMpA3xSq5oWd396BfRgg6JwHEoarcvpo8H+NOKDJ1MdOMn4FjVdIX+nAAw5r7nwnEG4cJInsSgS4yMLweiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhziK24uE14h/nicLEX0N/nTJWee165oatIQD7ikN8E=;
 b=HMDvujhLFs1PnJ+VcoxXxSFPt9Pa3DcJxYHq2ire7mxsYL50yjI85/4vmzMHAFXiqrcKfs0XKiPFqAQuN6FJMcq9lAkJXgxW0X66eLGV/+PRg6bDBYUltFklhMBIM2/MTfudqBZ5miyedB4MKJD48GJEfqK3rWZ9UfBN/rAzxS6A2NijM1H0QpQL6SUquYl4o2vHsWXMlPG16KeBWqbZRbgdxcb8wDSBFlPzPSTx245AqwTIAP56eMcPBCcl8tlbpZ9+Fm2rjikD2+dmLGzwjC3IFbZfoaLRlJfqAlLz9cy+ZCEQrExuPyVn16p+RtCboQ8XyXOwCL+4ychRYDuFVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhziK24uE14h/nicLEX0N/nTJWee165oatIQD7ikN8E=;
 b=mW/K+9/ohNjGKTcXQhspyvGt2Ve2ohWGjIEwefxHIdG5HhG7itp7+fGXO6riwMcfsEkkCpf5yPSR52ScHYyfY5wQzs7vafBriK8xtaXb0UFw9kXXvvzKw97gYTqTHaFxmucRK5L/iQY3jFjZ/4XP+AuEN+297Dijt7T/kUGQt4I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:14:01 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:14:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/27] drm/amd/display: fix dml log2 function
Date: Fri, 15 May 2020 14:13:10 -0400
Message-Id: <20200515181315.1237251-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:14:00 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95ac87cf-95a4-414a-26db-08d7f8fbbe36
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39740E5018E486A8FE6E37C698BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0KS6heRTcj7T1gb//IuET2F+DmjX4xa+BXubxzXf+ZH27IVG/4oxIngxZMIZPefndGiyoJCLsw94hlhlVtxBbxDqXfYmg4yvmbi5c7nyZmw47S3nHZSs1GOjofZFISKOjVWBIlX2YkV0J9loXFrB8O8e8jENmqVnp9IsJpZvd4yL5zm9938t72pdMgITZ/0Tk2hOOEOzarDV/IT19MmWWxF8zzCW62bXSkdJwfYA6K6fieY3rZw2fi1G8XBbhnJllC/YK8qde5gexGLLTwl2KpRjkTTXHR2PLDFrNPvqE5Ku64jphPHizCjOIH7LBvDwn7emGknva2YBOLv7TQdS7qy/SQFtEw+stUQzs8Hqy1hgH0EfV6473tDqbMYNyM+7fzgVKf3gGJ3fG8etXH3bnA8LRCZnmwWidGc73/c0DtF2BOmtYQGB4w0IMt2mNVJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: c84kudFTC1CK/sq7dy+lMJO5cjTSkEd+05ss/nRkDIq/CM5WuH1ZENTgZX6x0lO9XRQOKt6HKjiX39bXqeRcvlW7NAE738ZIj9+NSB7wov08L/RLKNhdHusB+vs2qlUDrsSfah4GCZuffX+8vCRdvMnFuEf95Q0D5AhdtpVmgIBWP8DiBGkIzcx/qhoGDTYn72RyR2m5QeiQe6O5ZnxRKhQsPdIkL0AjPB8DEoUFw4bskguQwVsiqKASW/ctT4GVeO+vokGy524afXSIeO0XI+mDgFqRRsDoH6zyc5Mme/3u7pOgJfVS/aYrsLMRZahWFTUccBvbzWyIz1B6PTdNowwleKMEQTy8DUoF/Bv2I/474qCqKLFsIv2YmKg1Rl9FHl4II1LPuU2/7kRdJ7grHE7Tm+aP1ZRdI2Ors5cQCet9iLCrqlJQvE5XZmAPpBZ8g3Tmyu+BnPlKGZ9gZpj3FC8Z1EBfY9RmVza4nJYuTJPYj3hogRDpUXEvAuqrBfu2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ac87cf-95a4-414a-26db-08d7f8fbbe36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:14:01.0209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkGQ8eVm5X15/rLIO/tU7YR2tdlJAFrEeAnCB2lvsPPiXcq1O/jlIDyJs32lWzvH+Gr0Yd4Vohco4ShrxMTFOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This change removes internal rounding in dml_log2 function.

Dml_log2 is expected to return a float output. In case an int is needed
dml will floor the output on it's own.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index 02e06c9b3230..ab0870e2a103 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -86,9 +86,9 @@ static inline double dml_round(double a)
 		return floor;
 }
 
-static inline int dml_log2(double x)
+static inline double dml_log2(double x)
 {
-	return dml_round((double)dcn_bw_log(x, 2));
+	return (double) dcn_bw_log(x, 2);
 }
 
 static inline double dml_pow(double a, int exp)
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
