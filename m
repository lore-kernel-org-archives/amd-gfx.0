Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82944CA9EBB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DE020663
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 10:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DE020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099CE6E1CD;
	Thu, 24 Oct 2019 10:10:15 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C48896E1CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 10:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3Cq4pfbAsKVHXvsgjXrfav3AtjhdJSyjqEnXZhufo0WdtyCDEDfHw45KGU91lNxMGjvf2a7xQLDybnJAuxYG7aDaHuHi9mDPGRRFHahBWfz9oFbvcfuoXsfjnaSZhyJTaJoc8E61MYSbr8Hw+qtr7DcrtIRA2cnYco3B/8jp9Box+eVpCty6wYJT4JtNCuvOvUrBkn5TjPBptu6a8ddJW+iMVUqUGpfxBOzt/A1oHjx2TLo7sdU4lCNhgGVoFQ82ZBaKBOmykXi46m1KFz6CnJqzrctBmUjPxsMDyXFqoJlEj5Ce3p7IgSKpitDunhyMFeI8+rcWVpxeOjLfJThgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEauWjL/QToI2EDFU4NEEb6bw5bx5y3rT5ejY3IoBmM=;
 b=h77BvdSqZDLVwdrcJ9bLiKN9ofq7b1rifP66JXDm31+FS8HZNf5GhvT9C02CGJJtEJ/7t7P/1OeCD4ijHRFi5vthuoU+DaezWFce1kNhgtHxaAW78TkEmPjIXzaGZ6OSlX510SdjRdKyBt/EOkPyrG4f+WlLnyn25WsKo9AWajoHjM5Q5ukLsEfNQlecQHezli8pjGlx/y2f0tFtVm1nrk9yMp2eJjfafxmKtBfgGh9dFFUHNXiTjazKEYf4+EWW1a5nfy9ucb3vQY/6lMV83u2WdDEu+NCxnhaVKEOjqF2nIDynb69D/ApZV473nFLEowZWJl0peVGE1wotUtStzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0073.namprd12.prod.outlook.com (2603:10b6:0:57::17) by
 CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Thu, 24 Oct
 2019 10:10:11 +0000
Received: from BY2NAM03FT016.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::202) by DM3PR12CA0073.outlook.office365.com
 (2603:10b6:0:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Thu, 24 Oct 2019 10:10:11 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BY2NAM03FT016.mail.protection.outlook.com (10.152.84.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 24 Oct 2019 10:10:10 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 24 Oct
 2019 05:10:09 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 24 Oct 2019 05:10:07 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/gfx10: update gfx golden settings
Date: Thu, 24 Oct 2019 18:10:02 +0800
Message-ID: <20191024101004.17247-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(428003)(189003)(199004)(86362001)(36756003)(26005)(6666004)(7696005)(70586007)(186003)(14444005)(356004)(70206006)(47776003)(8676002)(5660300002)(81156014)(81166006)(8936002)(50226002)(50466002)(51416003)(1076003)(336012)(2351001)(2616005)(426003)(53416004)(486006)(126002)(476003)(478600001)(305945005)(44832011)(48376002)(15650500001)(54906003)(2906002)(4326008)(6916009)(316002)(16586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2519; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f498bb7b-43e1-4092-d384-08d7586a5a9a
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2519:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25192D916E523637430569C2956A0@CY4PR1201MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0200DDA8BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RT1W98tsnruTg3Vpveag3I4hhF0zlKxBcCoUcFnf6yJHyLauleQ4pDMu1jomuT+OPiLz8hCL4aBdL7IiEvKjXx91Xqvbwud3BQ1oIcX/iok/Gcn26OfwGBHOxbPFW4cp/fZMOndH0cg/LtifnFBCvZKLjj3ao0qe5i81aALxGDpbrUPucU/WXH7LC5BR7GXtdTkvB/ofwgrN0QOuJ6BMwiA9njZmAjYdX/EBqdJp8RMvOGdwE1PrN3AO9kcT3YysJvdLoi4R8kT2lfrS3JGOC+kPzb6+CMM2MWNF3IYOwsvOKjscqciUGGt8TfGOHBntEVb51IQfPjsFakXCOsy+/eLb9tOdcvRXHZ99bS01/8r52GV2THKLM6zlXgqDJntXtlOvAWTVy+nuG2WSwI+FHy09P0Q8b83h8A7ttLbxp2pCv822tJ5w7XZDL/zibUKQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 10:10:10.4776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f498bb7b-43e1-4092-d384-08d7586a5a9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEauWjL/QToI2EDFU4NEEb6bw5bx5y3rT5ejY3IoBmM=;
 b=3AEdOpnrLyfQ1etfzuyAfXVhwsN4xl9jF5UA0mip+pb99gLfT0GajJkX7GTDlwUZzbaaa5We/P2WxInyj2V/mLIs2B5ly8Vx+pQ7rnnk4MpzoVM4bUsMyCCemGXxxy2kcvXHvGi2buLZAhNpiPxHCnMmmq93SQaxaWXHnyb8pBY=
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Tianci
 Yin <tianci.yin@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024101002.s2RgB9Q_LCnYtr78EMIr7TkJvnsohKmK01L723iwpvg@z>

RnJvbTogIlRpYW5jaS5ZaW4iIDx0aWFuY2kueWluQGFtZC5jb20+Cgp1cGRhdGUgcmVnaXN0ZXJz
OiBtbUNHVFRfU1BJX0NMS19DVFJMCgpDaGFuZ2UtSWQ6IEljNjRkNTMyYzYxYWRmZGViNjgxOTAz
ZjExMzNkOWIzNTM1NzlhYzU1ClNpZ25lZC1vZmYtYnk6IFRpYW5jaS5ZaW4gPHRpYW5jaS55aW5A
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggYWM0M2IxYWY2OWUzLi4xMWU4NjNj
NGM0MGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC05Myw3ICs5
Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGlu
Z3NfZ2NfMTBfMVtdID0KIHsKIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUNCX0hX
X0NPTlRST0xfNCwgMHhmZmZmZmZmZiwgMHgwMDQwMDAxNCksCiAJU09DMTVfUkVHX0dPTERFTl9W
QUxVRShHQywgMCwgbW1DR1RUX0NQRl9DTEtfQ1RSTCwgMHhmY2ZmOGZmZiwgMHhmODAwMDEwMCks
Ci0JU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1DR1RUX1NQSV9DTEtfQ1RSTCwgMHhj
MDAwMDAwMCwgMHhjMDAwMDEwMCksCisJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1D
R1RUX1NQSV9DTEtfQ1RSTCwgMHhjZDAwMDAwMCwgMHgwZDAwMDEwMCksCiAJU09DMTVfUkVHX0dP
TERFTl9WQUxVRShHQywgMCwgbW1DR1RUX1NRX0NMS19DVFJMLCAweDYwMDAwZmYwLCAweDYwMDAw
MTAwKSwKIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUNHVFRfU1FHX0NMS19DVFJM
LCAweDQwMDAwMDAwLCAweDQwMDAwMTAwKSwKIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAw
LCBtbUNHVFRfVkdUX0NMS19DVFJMLCAweGZmZmY4ZmZmLCAweGZmZmY4MTAwKSwKLS0gCjIuMTcu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
