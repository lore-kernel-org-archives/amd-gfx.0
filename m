Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B489CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 08:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4943720684
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4943720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDDFC89FA5;
	Thu, 24 Oct 2019 08:59:39 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680054.outbound.protection.outlook.com [40.107.68.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FB889FA5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 08:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWFh7ZgLDvZ9qE4d4QqmJi2uhxs39zAmF1XwuSFJsqGXBu0VqWDpZqLkse7qtuRZuZETV7ILaLN55M+tVHuiV7I5rN8Gd1OqqaSy21hjLND+CXNMp/bNibMLXVc8+114sqPwE+Qso8wBlp9gASSL3uc2/m8HIuxAvG/7ojm1wHbUmadmeo3Rx7BlEdJ9IFirgimrXg1mFGZ0JPLDxuu9QpGM2VYgKIp2qflIIUB1r5WD25Fa4uRVOcoiaqYc6GmtZSuKY4rwFAR62gmV6Pp7ch1boTzNMkyJUxnIn3uFacBnzXGcDbFH79k6pVMjC9KdnZnO+CkSdtmoyCMgrMcKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjqeFE6mTHQcV2CgkbVg+N8SasTKwhmOufO1K5JBOZs=;
 b=kKtU1rTFeGfVX2anF8Hjg3sF72qY7J0LTAed/dmPQJa4k2TObzh2G5urR3BQko8dEASYCXVKH8ojJNNs7n47wYEGrzmv6mrz/ymutT9yPl58udMlhxXWXA0VvDOS0lc2s4wGTCREzQ7enJj+nT84TtB/D2QB0WdkgNs+x3vRBDJBP7eWUv46zSA13GmyP+8mYhGcM0CLeS+dxtZ3MOOtG5wQGmrfUFWFSfy5ZCPAOol/P7r1vlGHRsKHcriJ0TvkCLDmemiCDKOM2YwGcGiC5bl+2INay2N/DyxzdHOT5G3gv7ulHFDUCQxsGo1llGBu+6I2cIW2KGFCZqZwAXaj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0107.namprd12.prod.outlook.com (2603:10b6:0:55::27) by
 BN7PR12MB2610.namprd12.prod.outlook.com (2603:10b6:408:22::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 24 Oct 2019 08:59:36 +0000
Received: from CO1NAM03FT004.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by DM3PR12CA0107.outlook.office365.com
 (2603:10b6:0:55::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Thu, 24 Oct 2019 08:59:36 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT004.mail.protection.outlook.com (10.152.80.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 24 Oct 2019 08:59:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 24 Oct
 2019 03:59:33 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 24 Oct
 2019 03:59:33 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 24 Oct 2019 03:59:32 -0500
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: modify the parameters of
 SMU_MSG_PowerUpVcn to 0
Date: Thu, 24 Oct 2019 16:59:24 +0800
Message-ID: <1571907564-18087-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(6029001)(4636009)(396003)(376002)(346002)(136003)(39860400002)(428003)(189003)(199004)(81166006)(356004)(476003)(8676002)(8936002)(53416004)(2616005)(47776003)(486006)(336012)(50226002)(126002)(426003)(5660300002)(48376002)(6666004)(36756003)(50466002)(4744005)(14444005)(51416003)(86362001)(4326008)(16586007)(316002)(26005)(81156014)(70206006)(305945005)(70586007)(7696005)(2351001)(186003)(478600001)(6916009)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cfee3d0-1154-4130-6045-08d758607de2
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610E92EE171ECC2FC07DCE89D6A0@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0200DDA8BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUeNHdTr17/oDmpxKFMiA/LugxYiy1hh35BpWJj4eVxBq4+LchxhJop5xwuOfUTq5iGGh3Eh2zt8HVPm+5afwXXu3sEOIJQZyY+WCtUEIbiddiQ4TCHL+qPRys1Xv+YkJn036wYTtkWLMsumOQtA53mBsMqu+Hc8Z1qGlWSqlFcuDCGDR2cQURArO1SRE4z+EHAEcG9hCDBYZOI/kZvprjnCLQ9fzHoTWOFQHfXu+medUJkE/c5iVN0KxlyTE4jWsSj6X6bdt38MqUsJ4FxrXj92lvQVWmBOqel6qwnzxuiY4hggAJApauBotuqMx7/KXceEPJtwf/jAm9q3pe0BMBDg/OeLI6vRgNNOL35FepZwBhUT63QTNnXq6otFGJgtosOweiEKIKNO8WxBSau2hlOZHTOLx1WPCz/X105gTxDf/+Y3ijjucLNgNaHXvpsH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 08:59:34.6715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfee3d0-1154-4130-6045-08d758607de2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjqeFE6mTHQcV2CgkbVg+N8SasTKwhmOufO1K5JBOZs=;
 b=MH5pWiEtQosVLwXSu9FI0D2FgA4mMz1tiRgHII8b7iKMQwvg8ClCjTcFK6iAUvrQrgkDg8p+EwwS/Hcd5+k374wszClZx6RHGcuG+fyboT+1bgBMDP8dsNiIharZpSX4dlLVZgA3B6MC3lvglCHWaDGVt+EiffJxMuWqUfxp8TE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024085924.RCC3ELxLIgc6Rv214uJbWL8lWFMQXwAVWfLLJeAta80@z>

VGhlIHBhcmFtZXRlcnMgd2hhdCBTTVVfTVNHX1Bvd2VyVXBWY24gbmVlZCBpcyAwLCBub3QgMQoK
U2lnbmVkLW9mZi1ieTogY2hlbiBnb25nIDxjdXJyeS5nb25nQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvcmVub2lyX3BwdC5jCmluZGV4IDQ1YzVmNTQuLjRhOTc1MTkgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMKQEAgLTI4Miw3ICsyODIsNyBAQCBz
dGF0aWMgaW50IHJlbm9pcl9kcG1fc2V0X3V2ZF9lbmFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpz
bXUsIGJvb2wgZW5hYmxlKQogCWlmIChlbmFibGUpIHsKIAkJLyogdmNuIGRwbSBvbiBpcyBhIHBy
ZXJlcXVpc2l0ZSBmb3IgdmNuIHBvd2VyIGdhdGUgbWVzc2FnZXMgKi8KIAkJaWYgKHNtdV9mZWF0
dXJlX2lzX2VuYWJsZWQoc211LCBTTVVfRkVBVFVSRV9WQ05fUEdfQklUKSkgewotCQkJcmV0ID0g
c211X3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwgU01VX01TR19Qb3dlclVwVmNuLCAxKTsK
KwkJCXJldCA9IHNtdV9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsIFNNVV9NU0dfUG93ZXJV
cFZjbiwgMCk7CiAJCQlpZiAocmV0KQogCQkJCXJldHVybiByZXQ7CiAJCX0KLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
