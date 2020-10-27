Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B055C388F9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A11922202
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GHjj5iOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A11922202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BC996EC60;
	Tue, 27 Oct 2020 20:53:05 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700082.outbound.protection.outlook.com [40.107.70.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68926EC5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqCxEInzRCvJgcLybA5mkVbYeoBPAYDL10zTEehJ5LuDz0URwOdCBHf7xbuXRDWrvpX8PO/k11eClO6K08hKSZ1RhHYwpnQAWO3oPJIzDG8WmFGduxlZCuaT9jt3rWqyxMak3+15ybIKZv0CT8pgJ8HpYBjz1LuoflvFLxrPD80S7KubwYpgifC32riCDhFc7iq46MC0sfBgMrYm4Bte1TVlaP7nEIrU1MqMwIVljHYgfpcIh2z6Ai5I3MJHJOsdrCqOLqjGlel36/mCpakXMCyac5BpF+IsUT2X9uLo8X//7HO5EZeJBDHJiN18XomSHG6Aw1NJrOXoSadiLL3iVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arR6dO3DulIcAigPwd+XE3YLzZgXyLKHxSbeMnYp8RY=;
 b=g/VrKHiVOLmxSnCccfPUxyl79HUGXoWvPXgf2etz2V2bzUyWeHvRYnviRmJnPGJtsh34B/AxgaV80AtNtUK6d+jp4FGB3qYtYiBolciXoj17CNGYxT9XLgNxgngX6/QEfB4RA5m7M5/FiQHUzlboy5kGHYE9JPfd+mIwLW8Mesogm/O2POLYlLgzY7kMtf+5zgC4WY5EdZXBFSXsFZfv+2vPPEPzad3456pIjKLSvyoY1U+YQXPkKTigSxt3y1hpHre9b4L+w/5kqKjqeUAFns6s0gD1TZ+23tRWWeD8cu7pOw+tQR4s3aVIKyTL5UNrR1bdA09DfMfiAgu8Tewdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arR6dO3DulIcAigPwd+XE3YLzZgXyLKHxSbeMnYp8RY=;
 b=GHjj5iOBof+xsG4yHts+2/8POIgTj1WTY5hVfc9kvHTxcx6qR9+FpqhEzpo5q4r7iDQB5dQY3G5qe+brhcODV/o+t6JLWn/MF4Wthy28D6z1XncgSoFqKBx+jDl/a/t9Tpdr5e/HYgaZHk4N4bnq/kOj2e0JOaZDkZCDzY1JeGk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:59 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:59 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/25] drm/amd/display: Update panel register
Date: Tue, 27 Oct 2020 16:52:20 -0400
Message-Id: <20201027205234.8239-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1b5f852-359c-4c12-1f4c-08d87aba4583
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35957A9F060BB0A012183F8EFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G852mVCECzOhCsbldJ8laXr7ZRJH9QRB0l+vJc2PDtZQvYUPMSAYqf92j+Pb4brwuSQgbajM+k5pZYTHKetst1qfmXWWaD8Q4HNrlFHjnUKW3bXwik7FULyMvviN88WkROiZWRH4iwi3lJ2Wg4ugva/VsqXwMTeUeUY1zVpcDaEXN11NdgRvepnBC78J/9ayPfLG1LF/aP0nOVfkTSE2Eft48sSMwImATrUmavgVGVR8XY8CcXCO5af+1ZGLUF+4KkwSWrZDr2Mu5nb0q5KagLxuc+Q/SU2tUwD4EXb7TQongQzmJN1/rJh+bs/8Qz5/YZLcRnMHcNAPLUCWIWhZBT8FtJshuZWd3GPdtwHsyyw5yPKJjkmm6F4QB0Y5R3gN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: anGeTXwgDAtUvNJCvS73OIF9D4FcpiIAGaLFrknhDUHZPA46t1LeurMG4bQcnUQntuATuLnu2RrImYv6wWQ0ap2NxTEABG9h2WYeEmdDzVBzYOjV512PQcfjDjGxIgradAVGIZxhz9jrjOfbYA+CPC7oykCI2kbQr26Vl06zJpLKjaq/n3b6R1uUrjfBIaPPR7xp7TFzJXjVx09z8p69O/ovy+RsPNht7q+ZaRjQpc9EvPlkPaj8zxKY16WeYmrDAltgCo2wC0p6kQ+rwKktCXfW7YJSzLnBA8h9YXclnWLD5r/zDx6zZn3VdUiVxGCxITt1Y8jA8sDOmychV265rJMDoEaV8PxQFR0d1K5go/O5/HWm6sC52lM1DlgcdzrvTEBQV1JiCFjQo4wHIzwkl9brzGSKqPwR7nsIFEsWGePf0TY0NXkRaAoo7JkpgpFQs0UfrjOzLRpjTO+P9UE/5P2yY88mW2RtZuwih7psI0ziN3g3gH0bOvMjvWs7n69w/ziOgqlsHhFzXxd8xk16LozK8RfRvfY0FZUpTo7kEGalGqEU+rjUa9J+EBGvWpzwJogJoFFz0lJyhw9Or36TAvjJ3vrDU2WerdONl6hxNcx8BIWssyOtIk1MyA4QbFmxP8u581QTc5vDzCIMR7jbew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b5f852-359c-4c12-1f4c-08d87aba4583
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:52.3421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhLgzj8GW4MiQ98bGbQaVjPHRSf4URIdQQ2/qedsv0M8OTgJESqV80Lzco03lopV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Chris Park <Chris.Park@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Incorrect panel register settings are
applied for power sequence because the
register macro is not defined in resource.

[How]
Implement same register space to future
resource files.

Signed-off-by: Chris Park <Chris.Park@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index c4ffed95d35e..2345f12ceab3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -967,7 +967,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		[id] = {\
 				LE_DCN3_REG_LIST(id), \
 				UNIPHY_DCN2_REG_LIST(phyid), \
-				DPCS_DCN2_REG_LIST(id), \
+				SRI(DP_DPHY_INTERNAL_CTRL, DP, id) \
 		}
 
 static const struct dcn10_link_enc_registers link_enc_regs[] = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
