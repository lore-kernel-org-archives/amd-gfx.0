Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5506DCA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3542820873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3542820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 081006EEAC;
	Thu, 31 Oct 2019 14:42:36 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740071.outbound.protection.outlook.com [40.107.74.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9B06EEA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYa+NArrFwy1SJYxvWKhjzp/scU3DE6CarqJisuGWJi6Uraa7Ii/+k5zLoZ5ySTCEO10uTo3dOyA1btKEvkJEwKhnk2g2SuswU+pZtLQktAOu0a6ygixeSg1bE2F/iuMLk4dHV/wKTfM/waLGdNJq+Xq2fwxP4wQmJd413DGAIYqdzl/I+Rg59v9LuElRDXJKpbWDeaP1882U8ztGc9qaiQl90pkx1mw2u2+r2oFagqjmhKkENEEWJOIATMcl7P58NmgYPeLs4HE5gXqMJryAfpVhQrdwTV5ZKKM68yPGGeAsyTXxTN3ofUk50DkO+uGQW2RtmS3X1/YaNbKiyUnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVimn9L79Kr07Xew7WdLkNb5aLBP7+VVo5u15l82Rhg=;
 b=Sf22La+E39sl0Ni+jebKMpZWmp2/KxvaD0kgspWlpUzyO8PcrFQ5Ce5kUIBmxDSUjn+5e4Pw+OAVwW4L+zlMwm8+gL/+wmY79JZySrNPovY0W2d7fWq4U51A9fNRRA3Id2w0QDLsqCuUhFZTZQl/TMfFJCZCGIE6IgbKHSBG1AP9RIf6OFYBpSMh/UHmb5n8/cAS2TIYO28yiEQKRc27ILbz9qzBWtNSTw9LzWu9386kZ5sI5A0jJtYlwveHxRH1bgBX8T6JaJtwFHZ5pxtBltyixGdQZ0k9XjPxr0SYNoU/r5ev5hufVN0AyLZiz1I1+gxd76cBaGmRnEqM3FYwhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0064.namprd12.prod.outlook.com (2603:10b6:0:56::32) by
 BN6PR12MB1585.namprd12.prod.outlook.com (2603:10b6:405:9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 31 Oct 2019 14:42:32 +0000
Received: from CO1NAM03FT034.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::204) by DM3PR12CA0064.outlook.office365.com
 (2603:10b6:0:56::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.18 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:32 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT034.mail.protection.outlook.com (10.152.80.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:29 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:29 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:29 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/20] drm/amd/display: Renoir chroma viewport WA
Date: Thu, 31 Oct 2019 10:41:54 -0400
Message-ID: <20191031144210.24011-5-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(428003)(189003)(199004)(26005)(305945005)(8936002)(186003)(81156014)(1076003)(50226002)(2351001)(76176011)(4326008)(81166006)(8676002)(426003)(14444005)(336012)(7696005)(70206006)(70586007)(51416003)(36756003)(486006)(53416004)(2616005)(6916009)(356004)(6666004)(446003)(47776003)(2906002)(50466002)(63370400001)(5660300002)(316002)(16586007)(86362001)(478600001)(476003)(11346002)(126002)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1585; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 356ef951-45cd-4692-c42c-08d75e108f00
X-MS-TrafficTypeDiagnostic: BN6PR12MB1585:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1585B7A196FA61152715C3BDF9630@BN6PR12MB1585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOec0C4N0gDNj4/XsTiYSm1/RAbW2Ds8eFYL5BKqpH6pA7b1BxhO0wGcysvFQSnKz7CQ8LQQS+I9HjYgpR3Gampr9LQKCUCeQna3oNxoJuBvqdI9YNEHQacOgU4S4p4PHuSM803axTwDxFlqu4ybbhPfhe7zj5EtcHc0mIXGOzvyhY5qq5Bfbs6rGHhwvMO6/1XdR/yYaRZV9MCXQ2QliYkKgB9TT6zDUTv7L+Kixg5e9N1tUzJ4sKfH0/YrhU0rAXWKcbxy5xZMRnqRuNFnTYGZKFB0vk8BnmAD0xNLR0W0rKCTHf07032hPTfTFYeDdHBW4tl+b70JhHi2VRDZjpJW0HsdKQyHApOgC/teBXQGphqg2yR7kvN1qanuD5HMH0mLW1DFxCGL2G1G7TWP8xES6zk1BH7mtbJGYvAytUf1zz5EJI2UK3DGYJvZsAvo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:30.6252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 356ef951-45cd-4692-c42c-08d75e108f00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1585
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVimn9L79Kr07Xew7WdLkNb5aLBP7+VVo5u15l82Rhg=;
 b=nqgSH6lGRafmpzm8idmVSTQ5118L22IVat7MUVYe9Ub5L1wIAlPFIWVE4LNhGgb9/pLgHR2MTJucB1ImQm7mQGM5/rw8GAbA6/H9wUsMhOPkp1Av76V6gp7awUzpz0BKq1ftbJeaLC8wW0JF8m8Sw6h8lIKMBpPlL+6UW57lZbE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=temperror action=none
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
Cc: Eric Yang <Eric.Yang2@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144154.hXRIP-Sjb6ar3XODewrDWii8cBwIaQJuA-QiMzPria8@z>

RnJvbTogRXJpYyBZYW5nIDxFcmljLllhbmcyQGFtZC5jb20+CgpbV2h5XQpGb3IgdW5rbm93biBy
ZWFzb24sIGltbWVkaWF0ZSBmbGlwIHdpdGggaG9zdCBWTSB0cmFuc2xhdGlvbiBvbiBOVjEyCnN1
cmZhY2Ugd2lsbCB1bmRlcmZsb3cgb24gbGFzdCByb3cgb2YgUFRFLgoKW0hvd10KSGFjayBjaHJv
bWEgdmlld3BvcnQgaGVpZ2h0IHRvIG1ha2UgZmV0Y2ggb25lIG1vcmUgcm93IG9mIFBURS4KTm90
ZSB0aGF0IHRoaXMgd2lsbCBjYXVzZSBodWJwIHVuZGVyZmxvdyBvbiBhbGwgdmlkZW8gdW5kZXJs
YXkKY2FzZXMsIGJ1dCB0aGUgdW5kZXJmbG93IGlzIG5vdCB1c2VyIHZpc2libGUgc2luY2UgaXQg
aXMgaW4KYmxhbmsgcmVnaW9uLgoKU2lnbmVkLW9mZi1ieTogRXJpYyBZYW5nIDxFcmljLllhbmcy
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNoZW5nQGFtZC5jb20+CkFj
a2VkLWJ5OiBCaGF3YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCAgICAgICAgICAgfCAgMiArCiAu
Li4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9odWJwLmMgfCA2NSArKysrKysr
KysrKysrKysrKystCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNl
LmMgfCAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCmluZGV4IGQ5MzFlNTg3OGI0Yy4uNWRi
NDQ3N2NjNGI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaApAQCAtNDE3LDYgKzQx
Nyw4IEBAIHN0cnVjdCBkY19kZWJ1Z19vcHRpb25zIHsKIAlib29sIGNtX2luX2J5cGFzczsKICNl
bmRpZgogCWludCBmb3JjZV9jbG9ja19tb2RlOy8qZXZlcnkgbW9kZSBjaGFuZ2UuKi8KKworCWJv
b2wgbnYxMl9pZmxpcF92bV93YTsKIH07CiAKIHN0cnVjdCBkY19kZWJ1Z19kYXRhIHsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9odWJwLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5jCmluZGV4
IDJmNWE1ODY3ZTY3NC4uMWRkZDZhZTIyMTU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9odWJwLmMKQEAgLTE2NCw2ICsxNjQsNjkgQEAgc3Rh
dGljIHZvaWQgaHVicDIxX3NldHVwKAogCiB9CiAKK3ZvaWQgaHVicDIxX3NldF92aWV3cG9ydCgK
KwlzdHJ1Y3QgaHVicCAqaHVicCwKKwljb25zdCBzdHJ1Y3QgcmVjdCAqdmlld3BvcnQsCisJY29u
c3Qgc3RydWN0IHJlY3QgKnZpZXdwb3J0X2MpCit7CisJc3RydWN0IGRjbjIxX2h1YnAgKmh1YnAy
MSA9IFRPX0RDTjIxX0hVQlAoaHVicCk7CisJaW50IHBhdGNoZWRfdmlld3BvcnRfaGVpZ2h0ID0g
MDsKKwlzdHJ1Y3QgZGNfZGVidWdfb3B0aW9ucyAqZGVidWcgPSAmaHVicC0+Y3R4LT5kYy0+ZGVi
dWc7CisKKwlSRUdfU0VUXzIoRENTVVJGX1BSSV9WSUVXUE9SVF9ESU1FTlNJT04sIDAsCisJCSAg
UFJJX1ZJRVdQT1JUX1dJRFRILCB2aWV3cG9ydC0+d2lkdGgsCisJCSAgUFJJX1ZJRVdQT1JUX0hF
SUdIVCwgdmlld3BvcnQtPmhlaWdodCk7CisKKwlSRUdfU0VUXzIoRENTVVJGX1BSSV9WSUVXUE9S
VF9TVEFSVCwgMCwKKwkJICBQUklfVklFV1BPUlRfWF9TVEFSVCwgdmlld3BvcnQtPngsCisJCSAg
UFJJX1ZJRVdQT1JUX1lfU1RBUlQsIHZpZXdwb3J0LT55KTsKKworCS8qZm9yIHN0ZXJlbyovCisJ
UkVHX1NFVF8yKERDU1VSRl9TRUNfVklFV1BPUlRfRElNRU5TSU9OLCAwLAorCQkgIFNFQ19WSUVX
UE9SVF9XSURUSCwgdmlld3BvcnQtPndpZHRoLAorCQkgIFNFQ19WSUVXUE9SVF9IRUlHSFQsIHZp
ZXdwb3J0LT5oZWlnaHQpOworCisJUkVHX1NFVF8yKERDU1VSRl9TRUNfVklFV1BPUlRfU1RBUlQs
IDAsCisJCSAgU0VDX1ZJRVdQT1JUX1hfU1RBUlQsIHZpZXdwb3J0LT54LAorCQkgIFNFQ19WSUVX
UE9SVF9ZX1NUQVJULCB2aWV3cG9ydC0+eSk7CisKKwkvKgorCSAqCVdvcmsgYXJvdW5kIGZvciB1
bmRlcmZsb3cgaXNzdWUgd2l0aCBOVjEyICsgcklPTU1VIHRyYW5zbGF0aW9uCisJICoJKyBpbW1l
ZGlhdGUgZmxpcC4gVGhpcyB3aWxsIGNhdXNlIGh1YnAgdW5kZXJmbG93LCBidXQgd2lsbCBub3QK
KwkgKgliZSB1c2VyIHZpc2libGUgc2luY2UgdW5kZXJmbG93IGlzIGluIGJsYW5rIHJlZ2lvbgor
CSAqLworCXBhdGNoZWRfdmlld3BvcnRfaGVpZ2h0ID0gdmlld3BvcnRfYy0+aGVpZ2h0OworCWlm
ICh2aWV3cG9ydF9jLT5oZWlnaHQgIT0gMCAmJiBkZWJ1Zy0+bnYxMl9pZmxpcF92bV93YSkgewor
CQlpbnQgcHRlX3Jvd19oZWlnaHQgPSAwOworCQlpbnQgcHRlX3Jvd3MgPSAwOworCisJCVJFR19H
RVQoRENIVUJQX1JFUV9TSVpFX0NPTkZJRywKKwkJCVBURV9ST1dfSEVJR0hUX0xJTkVBUiwgJnB0
ZV9yb3dfaGVpZ2h0KTsKKworCQlwdGVfcm93X2hlaWdodCA9IDEgPDwgKHB0ZV9yb3dfaGVpZ2h0
ICsgMyk7CisJCXB0ZV9yb3dzID0gKHZpZXdwb3J0X2MtPmhlaWdodCArIHB0ZV9yb3dfaGVpZ2h0
IC0gMSkgLyBwdGVfcm93X2hlaWdodDsKKwkJcGF0Y2hlZF92aWV3cG9ydF9oZWlnaHQgPSBwdGVf
cm93cyAqIHB0ZV9yb3dfaGVpZ2h0ICsgMzsKKwl9CisKKworCS8qIERDIHN1cHBvcnRzIE5WMTIg
b25seSBhdCB0aGUgbW9tZW50ICovCisJUkVHX1NFVF8yKERDU1VSRl9QUklfVklFV1BPUlRfRElN
RU5TSU9OX0MsIDAsCisJCSAgUFJJX1ZJRVdQT1JUX1dJRFRIX0MsIHZpZXdwb3J0X2MtPndpZHRo
LAorCQkgIFBSSV9WSUVXUE9SVF9IRUlHSFRfQywgcGF0Y2hlZF92aWV3cG9ydF9oZWlnaHQpOwor
CisJUkVHX1NFVF8yKERDU1VSRl9QUklfVklFV1BPUlRfU1RBUlRfQywgMCwKKwkJICBQUklfVklF
V1BPUlRfWF9TVEFSVF9DLCB2aWV3cG9ydF9jLT54LAorCQkgIFBSSV9WSUVXUE9SVF9ZX1NUQVJU
X0MsIHZpZXdwb3J0X2MtPnkpOworCisJUkVHX1NFVF8yKERDU1VSRl9TRUNfVklFV1BPUlRfRElN
RU5TSU9OX0MsIDAsCisJCSAgU0VDX1ZJRVdQT1JUX1dJRFRIX0MsIHZpZXdwb3J0X2MtPndpZHRo
LAorCQkgIFNFQ19WSUVXUE9SVF9IRUlHSFRfQywgcGF0Y2hlZF92aWV3cG9ydF9oZWlnaHQpOwor
CisJUkVHX1NFVF8yKERDU1VSRl9TRUNfVklFV1BPUlRfU1RBUlRfQywgMCwKKwkJICBTRUNfVklF
V1BPUlRfWF9TVEFSVF9DLCB2aWV3cG9ydF9jLT54LAorCQkgIFNFQ19WSUVXUE9SVF9ZX1NUQVJU
X0MsIHZpZXdwb3J0X2MtPnkpOworfQorCiB2b2lkIGh1YnAyMV9zZXRfdm1fc3lzdGVtX2FwZXJ0
dXJlX3NldHRpbmdzKHN0cnVjdCBodWJwICpodWJwLAogCQlzdHJ1Y3Qgdm1fc3lzdGVtX2FwZXJ0
dXJlX3BhcmFtICphcHQpCiB7CkBAIC0yMTEsNyArMjc0LDcgQEAgc3RhdGljIHN0cnVjdCBodWJw
X2Z1bmNzIGRjbjIxX2h1YnBfZnVuY3MgPSB7CiAJLmh1YnBfc2V0X3ZtX3N5c3RlbV9hcGVydHVy
ZV9zZXR0aW5ncyA9IGh1YnAyMV9zZXRfdm1fc3lzdGVtX2FwZXJ0dXJlX3NldHRpbmdzLAogCS5z
ZXRfYmxhbmsgPSBodWJwMV9zZXRfYmxhbmssCiAJLmRjY19jb250cm9sID0gaHVicDFfZGNjX2Nv
bnRyb2wsCi0JLm1lbV9wcm9ncmFtX3ZpZXdwb3J0ID0gbWluX3NldF92aWV3cG9ydCwKKwkubWVt
X3Byb2dyYW1fdmlld3BvcnQgPSBodWJwMjFfc2V0X3ZpZXdwb3J0LAogCS5zZXRfY3Vyc29yX2F0
dHJpYnV0ZXMJPSBodWJwMl9jdXJzb3Jfc2V0X2F0dHJpYnV0ZXMsCiAJLnNldF9jdXJzb3JfcG9z
aXRpb24JPSBodWJwMV9jdXJzb3Jfc2V0X3Bvc2l0aW9uLAogCS5odWJwX2Nsa19jbnRsID0gaHVi
cDFfY2xrX2NudGwsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMjEvZGNuMjFfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24yMS9kY24yMV9yZXNvdXJjZS5jCmluZGV4IGRhNGFhZGY3MmE3ZC4uMDFjYWZmZWM5MWU1IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVz
b3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFf
cmVzb3VyY2UuYwpAQCAtODQ1LDYgKzg0NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGNfZGVi
dWdfb3B0aW9ucyBkZWJ1Z19kZWZhdWx0c19kcnYgPSB7CiAJCS5zY2xfcmVzZXRfbGVuZ3RoMTAg
PSB0cnVlLAogCQkuc2FuaXR5X2NoZWNrcyA9IHRydWUsCiAJCS5kaXNhYmxlXzQ4bWh6X3B3cmR3
biA9IGZhbHNlLAorCQkubnYxMl9pZmxpcF92bV93YSA9IHRydWUKIH07CiAKIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZGNfZGVidWdfb3B0aW9ucyBkZWJ1Z19kZWZhdWx0c19kaWFncyA9IHsKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
