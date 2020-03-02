Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5201DC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2917121D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YhbR5sBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2917121D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C196E5CC;
	Mon,  2 Mar 2020 16:48:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84676E5C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNQow5/CgjU2rjzGw2NS0tBDvb74cGlmlNHWWZESWyfIevM/DL+YjtWYY9XjLoxz7aF1r6n5Xv38HqBs3jOYd56qFnppUH/IY15lLAeBEBIieuaDZPn1/PDshVjERFzw9j0EbN39h5S7X1cGXVWdPyJ/CSCmqpH97oQZASnZJ01DgCk+//75PFu4avHwO0z8iPUyI/jSfyXgUQRfxTt8R0ub/XqF7VhJoPwSS82DoTAbfMVYkp4+oFHVYum3f8b2ywXd0XJ4Y3wCLjx7RYFJofLpU4pwqjC5G6P8RS1Iu2E4omFgEQO07whdJ5QTcMW3xSWnv6p8FlTvZja0AHkskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RedYPETO3EUYjDTYtymt8mlHxCQEx1Re2yoqooGpV4=;
 b=lvxrnaAiUo68ZBpTKVNjU8mUWivVb7rjRIM7lnvUJOiLRBzc+euKsOuRlKw4TH1ryV9TtWkw3Ob19IDRoDsFGGmwfHPNUOvo67ldMdx9naeWrZpEf1Y4U3czSzaoYjNOqVJQgb0SkWI0IGt5KQo8sMZC0vms5z3c4+qv/8qcDQPXRKWDuJ6XM8zFqhqDzP6lh1tNSEgRZZRiDn310eSRtablK1vlanOg1GM1hMCvJeAjBTBmVcvS8SrU/BY3iAOM5nidz0wMcILJEEhkdqz8Zfi8nNtHxoaGznhTnvjnz2zZ7I3pcdFFdsnlsdc/m+M99cTkTPOVtFYI+OCOY4erKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RedYPETO3EUYjDTYtymt8mlHxCQEx1Re2yoqooGpV4=;
 b=YhbR5sBFNxn6SmR8RLAZ8agaz613GzggF1/On4G1aMdNBgG8PXsyVLziDRjjUZyQbu/sQAkmNDFJujsfBMTszdPSFAPhhQ36D73nX2xThFdTEX6EUsnWNW+jwdDuuxwHnlpHQLhHKhuERTKzoykOkiw7YVfEwEHyKudaNb8H2RE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:48:09 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:09 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/22] drm/amd/display: Add 'disable FEC for specific monitor'
 infrastructure to DC
Date: Mon,  2 Mar 2020 11:47:31 -0500
Message-Id: <20200302164736.89429-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d76ef6bd-262e-4749-3be8-08d7bec97b52
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25402293B29127980C2E268898E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(54906003)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KkVjXiIhSdQA1awlcxZX0WGrMZmKw0qc/UkBbNumm0BVFwid3BPapJ/F+R7PZFsyZo23cHdL2lt/SqS2meQ1JVNlvmCjRfkEMKnN9yc0emgs0sq3z1GWq6rTHyfs8c/VbEPpfuS69DqJvRd83LVo5ybMTnMcUhIpYWBZHrnwsH77WRwbpus5DizoZ3olgiDdXo9bGycamxG44rrPUwoido/AyoHBNiTLUnOABrL3HxhC4aFw2fsENPpPg2UGNNGnHYDwgOf8dnF144jG0cnDFtkyCfnE8Bnh4Pur0IxTjHty8zEPhMhmIv/xVTPJmJXHqDbsDTIjh7lb52jvbOCeBl9Hgn37IPaXefQbrRayVLljR6MgbeKHTFIEdFNibsXRYaoh0BDhkkY6sAH6jR5L3nfvD4nyhSes7xLG2BI1f4QGfBjZ1Qti40PiiIIsbNZ
X-MS-Exchange-AntiSpam-MessageData: +NhKhgTtxUuhnjitQ4VRfaRNS/4vMg8Rol7tUxJRWNaJYdQKdKqyYaEmwVrg62UvXKnIibPO5xrSefFiFjzQaCgBBQ8U807fql8og59hs73psSDihlwDV/jPW2V//MpRq93ARHcymXK+5mIs7Tc4Aw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76ef6bd-262e-4749-3be8-08d7bec97b52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:06.5543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7qvnNI4ynLh5pjPvaKE6MINPAmTH9kMY0ym5/EOx8MKnG00OyTkWhahPdmMmS8V5Ax/4UjxIM2IUVE2LAHdQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
 Nikola Cornij <nikola.cornij@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

Disabling FEC for specific monitors is sometimes required for debugging
while in the monitor bringup phase

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 951b43dde4e5..a4680968c8f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -970,6 +970,9 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			break;
 		}
 
+		if (link->local_sink->edid_caps.panel_patch.disable_fec)
+			link->ctx->dc->debug.disable_fec = true;
+
 		// Check if edid is the same
 		if ((prev_sink != NULL) && ((edid_status == EDID_THE_SAME) || (edid_status == EDID_OK)))
 			same_edid = is_same_edid(&prev_sink->dc_edid, &sink->dc_edid);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 299f6e00f576..0d210104ba0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -231,6 +231,7 @@ struct dc_panel_patch {
 	unsigned int extra_t7_ms;
 	unsigned int skip_scdc_overwrite;
 	unsigned int delay_ignore_msa;
+	unsigned int disable_fec;
 };
 
 struct dc_edid_caps {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
