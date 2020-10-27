Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6CAC56202
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B04621D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zlr5oL/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B04621D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5B66EC62;
	Tue, 27 Oct 2020 20:53:07 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700074.outbound.protection.outlook.com [40.107.70.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 584936EC62
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGpgiAuG+YxGuSna0vPenPkgo2qt5XcuSEmU0LQnZ9DlLcVy9s41A+NNwhrPfKcmKn7X6EB16FNByiilebPv9w1Sig6cVevDqrIBOBU98bhZa6BzIx443100VUAzU6vqMlHhq2NoBviwhWAdtmtUj9CFQBucODNV6qLBw9d5+q7TbSBlg54dG/jaIayKpjD1pbqHTCG107YFA1TtvVs9+4LawFgwoKpwt0l6YV0tEE2zNuP+ux4/t/iayaCstO4B8g8p0IW7Zl9grDphvZDZREBGbKCNmBv06/QLPuz2m1hoNmbnF/nfJezNATZkPsgdl/1Y/BHY17CbwX86bX+v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDWCKtSSHi9c2RWrPjcX0BdyQE6WbkSZ7IYOVxHKWiw=;
 b=VI6TxuJaD9znhQkhZLfki2Yd02uAk4rHBZuhTXmjpLo0DTGCAD49WfzPoPtqPWIUKE1sojsM7laxdAeCaf58F7fOlFcx2JLlMbzFiLgLV9jJssFu9lCd8wPFAqksBFMxMJHFReLgGITP/bpRRz3nM+D2e6Roh3hByilUKyj0/zNDmkshMKV94SIVe39bl8GlvidOdJeP8cdyEAWrH9LZUx23HEuR3N3cHrHA4V1oUhLmxOXoflfq5B/egl6P0j62n8oMmEaeCoLuMtqQRIW5GYaD3ASW8M1CfE66Q1qhXcYdAwqN9t7UU4oyU9CU8YVsrVApy7w2lCiEqL+9D6eBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDWCKtSSHi9c2RWrPjcX0BdyQE6WbkSZ7IYOVxHKWiw=;
 b=Zlr5oL/k1CUaKlFlxUzQCSV/gVuu6Gw3VumEbGtXebyRuFnGRjZ2sLZH1/u8g6sMxiu+oy57pv63VDRH1Yy/5Vv7te4zch/tThIlNvXtbjODooR1/QcoijRNkMLGJCAS7umB3Ft7bA9DF958oBMZrcqPvgFD3q97kOGvbiQ5kHQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:05 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:05 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/25] drm/amd/display: set hdcp1 wa re-auth delay to 200ms
Date: Tue, 27 Oct 2020 16:52:30 -0400
Message-Id: <20201027205234.8239-22-qingqing.zhuo@amd.com>
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
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a77e0f1-789b-4f3a-e0a2-08d87aba4963
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35957A054B146BE07AFB15DEFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:68;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQe7VEUTRVAE0WcBk02tbec00C6URuwOTeCAhimw95R3dp1vEb675/b+9IssaELTr0oNvvdTYsBJfcJq5YdXDbPAKelAi//ohII1jcrq0ZB0udmqDHBxqF0YKKUwl9aV5rlwxhtOk1/K4ymOvlrCKcwU3TCUTWhHIlg5ivB4t5dLzWcZaIB5CEGENheSl/kEDIEAHlfO35dN1VAuMidszG/CGzuK84Gn6lUBZvR3w58qtfCNHQlv/CUZ1GIDbGx4eXZzwGQ2bKRmw9Eq350gFx/nk2TYMqKdr3LdQpQcUG1tAUiIs/+4zUCVhywKJPZQhM0u+FR6jR0CpQrf1lx4wezYsqUhRdxMSPucrK6mMV8zKXWEegXSJMEOKK+QOgTe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FEsTv2pJAMxQP9P6087or7hwHar4smdhBZPBHZQDnPdEa92ZZzUTb0QpJR552F2evKv6jlO4Dd8Mv1Tgufd6kSFDxe7euvv+/FfJ0+73/UiDBFky6PJXaKzHYfMW/lYWk/ohT6HiFLthUoOYSNodzDaM/WUsj/ZM+fT2KkbueS+T7g2nhHBKdQOU7sL7y5pWwFM2FkpzqOq/ml45Y8no1GrhBm0qVRkbCFXB2waDiIFuImSUogCaLmIt7UeIaWaKQnc52zZDQLvl4PdUDtgls+chMWZEx8H4a6WjZ+o+ZbDow9m7EapkCHuZgmYWM4Pj+0fEJWVKSS1s8YfpyCcYe2UMFO/u9wgZsdfVDN1mVxU88jnMby09x9DrjnKtpStRWubUILTLtnPPJNF98evNzpYHgFIzP+jZC4e1Iy0DNAbHeUv9QiJKOG9474ODPSenUWycnb8FqsuylbcA0C3TpDX7/8dk+hiTXGwvnDU/aga0+0coZQM7qapGTxhMWqvHafqON1do/LZxIFtZxGEOLPsB1UXULSNePse8xj2Y1ow927xWUF89OuV0f/RrrorLDnfEIiimeqqpZjjpcLaHoh3gErRsG2qgffBYO3vuE7uPFfslL2iss/j4dRe3tj87dB/vKl9Z1HAxxGZusZdrow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a77e0f1-789b-4f3a-e0a2-08d87aba4963
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:58.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABTgNk9WsGx2hA/d+JxMxmnr80vK6bWTA801GXRl6ubYjkwudGq4BpmXLVwqrfHp
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[Why]
Fail and restart timing for HDCP1 retry occurs too quickly.
This would cause some MST monitors to show black screen.

[How]
Adjusted timing of fail and restart to 200ms.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index f3711914364e..24ab95b093f7 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -231,7 +231,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 			fail_and_restart_in_ms(0, &status, output);
 			break;
 		} else if (conn->hdcp1_retry_count < conn->link.adjust.hdcp1.min_auth_retries_wa) {
-			fail_and_restart_in_ms(0, &status, output);
+			fail_and_restart_in_ms(200, &status, output);
 			break;
 		}
 		if (conn->is_repeater) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
