Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DC3CA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A840D20873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A840D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D956EEB6;
	Thu, 31 Oct 2019 14:42:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F99A6EEB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe0562dTi0KiUOA4Sg8zR3J6Tg7uDJxb4qW59NHRidM71qCVeu1buJVW4i7SGn9MH5BOqy7iADlGKr4n0ofk5Xdly0tQsegQrxiE/sylJxtyGt6rD4M9/3PnhYatvgmhJUIl13uqd8s6xTwXWBkYeGPhJ/sZ5A9j0W45KA8rG1S3Bm2MqZXK8V1BMFBp3k2BE3h9RQvko2ZDWzpv5jHpJM6ysTxXh1/OuhPxj3Dr8Tz8ji6jeMw8NWC52MNlFp/egas2554Ct52lJHKY+sC6JLSvHhNmqRuU678g1dk7RE/Q9mmSD7nE+Oeqj/nk5I6CrV20EdmVfRbwxFdu6jca7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GV/Ffnf+aayJ8tn56WzkcHLoy4OJzpVaj4XVO/4otY=;
 b=hfU1bOeIsonQnf1edmMkIynG/a3+CuECVMdjnzXYktV3Z+wEWN4ismNbV8xStg6X4UiVpDR9bAc2c3yQjB43Vh7AWu8oBX8y3fDhGDwK58jzo7La+JVVoa3Kd6Tjzc6J3JDy36VWru0p9Fsu5j8xBGPg7QJKYqcYjiUOf4e7aEMMAiFHF3P64IXwsE2W+boot3se7mXTw3hw1zRKwy8jz3ZJT1yiZ3grU+32pd99Kqg0fk3YV50xe+Pv0W41nWvWXRP5dl9bryOuY+uaq+MawnCSIDgm/cWolOuWLvIXn6cXLFP2n6KFUuL0aP1Qu5R+i9aW5SWjg0ddnWuAjgZAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0035.namprd12.prod.outlook.com (2603:10b6:903:129::21)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Thu, 31 Oct
 2019 14:42:39 +0000
Received: from CO1NAM03FT024.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by CY4PR12CA0035.outlook.office365.com
 (2603:10b6:903:129::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.19 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:39 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT024.mail.protection.outlook.com (10.152.80.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:36 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:31 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/20] drm/amd/display: Create debug option to disable
 v.active clock change policy.
Date: Thu, 31 Oct 2019 10:41:58 -0400
Message-ID: <20191031144210.24011-9-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(428003)(199004)(189003)(5660300002)(1076003)(356004)(336012)(53416004)(2906002)(54906003)(486006)(2351001)(426003)(6666004)(476003)(446003)(126002)(11346002)(2616005)(4326008)(36756003)(70586007)(186003)(305945005)(70206006)(26005)(76176011)(47776003)(51416003)(8936002)(14444005)(81156014)(86362001)(81166006)(6916009)(50226002)(7696005)(478600001)(8676002)(48376002)(50466002)(16586007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3901; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4079c665-d7a3-4575-1e03-08d75e1093dd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39015B0B7D3936F5BC38350AF9630@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCQ0byorlsjEIXUB9oOJrH1pdy2xWiRbZ9WGXf5IKWSs2tkDEFMY1M5DgHcLpaNbYuRXsok/H/CcI2/lacdc6Xplk9+71KF5VL0HnDzGyB9o/Gs9CAFJvrp2++bgQKkSn6JB9cwMoEzj8EY8GxKrIQmy+XKznY54sckXHfMRiJdYwSdpLc+sMNPxLUj4UX54bwHweczYYf90qFm96mXV5l8UqVnMHYBePtPhxsmjpswUP5BqGun3N0xTu34Ee5CYVYvNBpDar38hZAA2RTiFos5hHwWN91q/YYSTtjM1dH9v7YiMI0eD3/gOD6x1lscZ+DhGPnPwk7U18seWBq1AajPPZtY7p/UTkH2K3Zrzm4qf+B/kwu4/++Yvg0PXAy+MCs3Q/9PxhPol/9+tjulqRDZqeI136IL/rw8vwdpJf6T7vpGVPAixdutXXUyiG8Ne
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:38.6942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4079c665-d7a3-4575-1e03-08d75e1093dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GV/Ffnf+aayJ8tn56WzkcHLoy4OJzpVaj4XVO/4otY=;
 b=gseZCX/DsS6ub8RYkod3RUFYLd82UczNd+9oJmuUaiSzcojas8jTnViAyZsrXpzZQWkUgPfh9aeDkKO6TmwLG/8L5cl2Y8l+boZrsU3NR0RAiVx4GFmSS+TQKPcNIUWwixnKSVeR39UkuRO+nnez7s6/EqpsGRd3EJJLSBNuHsI=
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
Cc: David Galiffi <david.galiffi@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144158.juJOnKicN6LwnxqnzhldIHRiSqzgPH24XgGmoyVC7B8@z>

RnJvbTogRGF2aWQgR2FsaWZmaSA8RGF2aWQuR2FsaWZmaUBhbWQuY29tPgoKW1dIWV0KSXQgaGFz
IGJlZW4gYSB1c2VmdWwgb3B0aW9uIGluIGRlYnVnZ2luZyBHRlhPRkYgYW5kIFAuU3RhdGUgQ2hh
bmdlIGlzc3Vlcy4KTWF5IGJlIHJlcXVpcmVkIGFzIGZvciBwbGF0Zm9ybSBzcGVjaWZpYyB3b3Jr
YXJvdW5kLgoKW0hPV10KQ3JlYXRlIG9wdGlvbiBpbiBlbnVtIGRjX2RlYnVnX29wdGlvbnMsICJk
aXNhYmxlX3ZhY3RpdmVfY2xvY2tfY2hhbmdlIi4KV2hlbiBpdCBpcyBzZXQsIGRtX2RyYW1fY2xv
Y2tfY2hhbmdlX3ZhY3RpdmUsIHdpbGwgdHJhbnNsYXRlIGludG8KcF9zdGF0ZV9jaGFuZ2Vfc3Vw
cG9ydDogZmFsc2UuCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBHYWxpZmZpIDxkYXZpZC5nYWxpZmZp
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBKdW4gTGVpIDxKdW4uTGVpQGFtZC5jb20+CkFja2VkLWJ5
OiBCaGF3YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCAgICAgICAgICAgICAgICAgICAgICAgICB8
IDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNl
LmMgICAgICAgfCAxICsKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24yMC9kaXNw
bGF5X21vZGVfdmJhXzIwLmMgIHwgMyArKy0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rj
bjIwL2Rpc3BsYXlfbW9kZV92YmFfMjB2Mi5jICAgIHwgNiArKystLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaCAgIHwgMSArCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV92YmEuYyAgICAgICB8
IDIgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3Zi
YS5oICAgICAgIHwgMSArCiA3IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAppbmRleCA1ZGI0NDc3Y2M0
YjcuLjdiZjAyNDE5OTljNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgKQEAgLTQx
OSw2ICs0MTksNyBAQCBzdHJ1Y3QgZGNfZGVidWdfb3B0aW9ucyB7CiAJaW50IGZvcmNlX2Nsb2Nr
X21vZGU7LypldmVyeSBtb2RlIGNoYW5nZS4qLwogCiAJYm9vbCBudjEyX2lmbGlwX3ZtX3dhOwor
CWJvb2wgZGlzYWJsZV9kcmFtX2Nsb2NrX2NoYW5nZV92YWN0aXZlX3N1cHBvcnQ7CiB9OwogCiBz
dHJ1Y3QgZGNfZGVidWdfZGF0YSB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCmluZGV4IDkyNGMyZTMwMzU4OC4uMTg2MmQ4
YTE5MmJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAv
ZGNuMjBfcmVzb3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjAvZGNuMjBfcmVzb3VyY2UuYwpAQCAtMjg0NSw2ICsyODQ1LDcgQEAgYm9vbCBkY24yMF92YWxp
ZGF0ZV9iYW5kd2lkdGgoc3RydWN0IGRjICpkYywgc3RydWN0IGRjX3N0YXRlICpjb250ZXh0LAog
CWJvb2wgZnVsbF9wc3RhdGVfc3VwcG9ydGVkID0gZmFsc2U7CiAJYm9vbCBkdW1teV9wc3RhdGVf
c3VwcG9ydGVkID0gZmFsc2U7CiAJZG91YmxlIHBfc3RhdGVfbGF0ZW5jeV91cyA9IGNvbnRleHQt
PmJ3X2N0eC5kbWwuc29jLmRyYW1fY2xvY2tfY2hhbmdlX2xhdGVuY3lfdXM7CisJY29udGV4dC0+
YndfY3R4LmRtbC5zb2MuZGlzYWJsZV9kcmFtX2Nsb2NrX2NoYW5nZV92YWN0aXZlX3N1cHBvcnQg
PSBkYy0+ZGVidWcuZGlzYWJsZV9kcmFtX2Nsb2NrX2NoYW5nZV92YWN0aXZlX3N1cHBvcnQ7CiAK
IAlpZiAoZmFzdF92YWxpZGF0ZSkKIAkJcmV0dXJuIGRjbjIwX3ZhbGlkYXRlX2JhbmR3aWR0aF9p
bnRlcm5hbChkYywgY29udGV4dCwgdHJ1ZSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMC5jCmlu
ZGV4IDZjNmM0ODZiNzc0YS4uNzdiNzU3NGM2M2NiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjAuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFf
MjAuYwpAQCAtMjU3Nyw3ICsyNTc3LDggQEAgc3RhdGljIHZvaWQgZG1sMjBfRElTUENMS0RQUENM
S0RDRkNMS0RlZXBTbGVlcFByZWZldGNoUGFyYW1ldGVyc1dhdGVybWFya3NBbmRQZXIKIAkJCW1v
ZGVfbGliLT52YmEuTWluQWN0aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luCiAJCQkJCSsgbW9kZV9s
aWItPnZiYS5EUkFNQ2xvY2tDaGFuZ2VMYXRlbmN5OwogCi0JaWYgKG1vZGVfbGliLT52YmEuTWlu
QWN0aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luID4gNTApIHsKKwlpZiAobW9kZV9saWItPnZiYS5E
UkFNQ2xvY2tDaGFuZ2VTdXBwb3J0c1ZBY3RpdmUgJiYKKwkJCW1vZGVfbGliLT52YmEuTWluQWN0
aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luID4gNTApIHsKIAkJbW9kZV9saWItPnZiYS5EUkFNQ2xv
Y2tDaGFuZ2VXYXRlcm1hcmsgKz0gMjU7CiAJCW1vZGVfbGliLT52YmEuRFJBTUNsb2NrQ2hhbmdl
U3VwcG9ydFswXVswXSA9IGRtX2RyYW1fY2xvY2tfY2hhbmdlX3ZhY3RpdmU7CiAJfSBlbHNlIHsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjAvZGlz
cGxheV9tb2RlX3ZiYV8yMHYyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1s
L2RjbjIwL2Rpc3BsYXlfbW9kZV92YmFfMjB2Mi5jCmluZGV4IGQ2M2NhNGNjZjdjZi4uNjJkZmQz
NmQ4MzBhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rj
bjIwL2Rpc3BsYXlfbW9kZV92YmFfMjB2Mi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kbWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMHYyLmMKQEAgLTI2MTEsMTIgKzI2
MTEsMTIgQEAgc3RhdGljIHZvaWQgZG1sMjB2Ml9ESVNQQ0xLRFBQQ0xLRENGQ0xLRGVlcFNsZWVw
UHJlZmV0Y2hQYXJhbWV0ZXJzV2F0ZXJtYXJrc0FuZFAKIAkJCW1vZGVfbGliLT52YmEuTWluQWN0
aXZlRFJBTUNsb2NrQ2hhbmdlTWFyZ2luCiAJCQkJCSsgbW9kZV9saWItPnZiYS5EUkFNQ2xvY2tD
aGFuZ2VMYXRlbmN5OwogCi0KLQlpZiAobW9kZV9saWItPnZiYS5NaW5BY3RpdmVEUkFNQ2xvY2tD
aGFuZ2VNYXJnaW4gPiA1MCkgeworCWlmIChtb2RlX2xpYi0+dmJhLkRSQU1DbG9ja0NoYW5nZVN1
cHBvcnRzVkFjdGl2ZSAmJgorCQltb2RlX2xpYi0+dmJhLk1pbkFjdGl2ZURSQU1DbG9ja0NoYW5n
ZU1hcmdpbiA+IDUwKSB7CiAJCW1vZGVfbGliLT52YmEuRFJBTUNsb2NrQ2hhbmdlV2F0ZXJtYXJr
ICs9IDI1OwogCQltb2RlX2xpYi0+dmJhLkRSQU1DbG9ja0NoYW5nZVN1cHBvcnRbMF1bMF0gPSBk
bV9kcmFtX2Nsb2NrX2NoYW5nZV92YWN0aXZlOwogCX0gZWxzZSBpZiAobW9kZV9saWItPnZiYS5E
dW1teVBTdGF0ZUNoZWNrICYmCi0JCQkJbW9kZV9saWItPnZiYS5NaW5BY3RpdmVEUkFNQ2xvY2tD
aGFuZ2VNYXJnaW4gPiAwKSB7CisJCQltb2RlX2xpYi0+dmJhLk1pbkFjdGl2ZURSQU1DbG9ja0No
YW5nZU1hcmdpbiA+IDApIHsKIAkJbW9kZV9saWItPnZiYS5EUkFNQ2xvY2tDaGFuZ2VTdXBwb3J0
WzBdWzBdID0gZG1fZHJhbV9jbG9ja19jaGFuZ2VfdmFjdGl2ZTsKIAl9IGVsc2UgewogCQlpZiAo
bW9kZV9saWItPnZiYS5TeW5jaHJvbml6ZWRWQmxhbmsgfHwgbW9kZV9saWItPnZiYS5OdW1iZXJP
ZkFjdGl2ZVBsYW5lcyA9PSAxKSB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9zdHJ1Y3RzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9zdHJ1Y3RzLmgKaW5kZXggY2ZhY2Q2MDI3NDY3
Li4xOTM1NjE4MGNiYjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kbWwvZGlzcGxheV9tb2RlX3N0cnVjdHMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9zdHJ1Y3RzLmgKQEAgLTExMiw2ICsxMTIsNyBAQCBz
dHJ1Y3QgX3Zjc19kcGlfc29jX2JvdW5kaW5nX2JveF9zdCB7CiAJYm9vbCBkb191cmdlbnRfbGF0
ZW5jeV9hZGp1c3RtZW50OwogCWRvdWJsZSB1cmdlbnRfbGF0ZW5jeV9hZGp1c3RtZW50X2ZhYnJp
Y19jbG9ja19jb21wb25lbnRfdXM7CiAJZG91YmxlIHVyZ2VudF9sYXRlbmN5X2FkanVzdG1lbnRf
ZmFicmljX2Nsb2NrX3JlZmVyZW5jZV9taHo7CisJYm9vbCBkaXNhYmxlX2RyYW1fY2xvY2tfY2hh
bmdlX3ZhY3RpdmVfc3VwcG9ydDsKIH07CiAKIHN0cnVjdCBfdmNzX2RwaV9pcF9wYXJhbXNfc3Qg
ewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5
X21vZGVfdmJhLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2Rpc3BsYXlf
bW9kZV92YmEuYwppbmRleCA4MWRiODUxN2E2OTAuLmRhNWU5ZDJmZDZiNiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfdmJhLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfdmJhLmMK
QEAgLTIyMyw2ICsyMjMsOCBAQCBzdGF0aWMgdm9pZCBmZXRjaF9zb2NiYl9wYXJhbXMoc3RydWN0
IGRpc3BsYXlfbW9kZV9saWIgKm1vZGVfbGliKQogCW1vZGVfbGliLT52YmEuU1JFbnRlclBsdXNF
eGl0VGltZSA9IHNvYy0+c3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXM7CiAJbW9kZV9saWItPnZi
YS5EUkFNQ2xvY2tDaGFuZ2VMYXRlbmN5ID0gc29jLT5kcmFtX2Nsb2NrX2NoYW5nZV9sYXRlbmN5
X3VzOwogCW1vZGVfbGliLT52YmEuRHVtbXlQU3RhdGVDaGVjayA9IHNvYy0+ZHJhbV9jbG9ja19j
aGFuZ2VfbGF0ZW5jeV91cyA9PSBzb2MtPmR1bW15X3BzdGF0ZV9sYXRlbmN5X3VzOworCW1vZGVf
bGliLT52YmEuRFJBTUNsb2NrQ2hhbmdlU3VwcG9ydHNWQWN0aXZlID0gIXNvYy0+ZGlzYWJsZV9k
cmFtX2Nsb2NrX2NoYW5nZV92YWN0aXZlX3N1cHBvcnQgfHwKKwkJCW1vZGVfbGliLT52YmEuRHVt
bXlQU3RhdGVDaGVjazsKIAogCW1vZGVfbGliLT52YmEuRG93bnNwcmVhZGluZyA9IHNvYy0+ZG93
bnNwcmVhZF9wZXJjZW50OwogCW1vZGVfbGliLT52YmEuRFJBTUNoYW5uZWxXaWR0aCA9IHNvYy0+
ZHJhbV9jaGFubmVsX3dpZHRoX2J5dGVzOyAgIC8vIG5ldyEKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3ZiYS5oIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kaXNwbGF5X21vZGVfdmJhLmgKaW5kZXggNmM1OWEz
MzIwOTNhLi42ZDhiNWM2MWRlNjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3ZiYS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3ZiYS5oCkBAIC0xNTYsNiArMTU2LDcgQEAgc3Ry
dWN0IHZiYV92YXJzX3N0IHsKIAl1bnNpZ25lZCBpbnQgRFNDRm9ybWF0RmFjdG9yOwogCiAJYm9v
bCBEdW1teVBTdGF0ZUNoZWNrOworCWJvb2wgRFJBTUNsb2NrQ2hhbmdlU3VwcG9ydHNWQWN0aXZl
OwogCWJvb2wgUHJlZmV0Y2hNb2RlU3VwcG9ydGVkOwogCWVudW0gc2VsZl9yZWZyZXNoX2FmZmlu
aXR5IEFsbG93RFJBTVNlbGZSZWZyZXNoT3JEUkFNQ2xvY2tDaGFuZ2VJblZibGFuazsgLy8gTW9k
ZSBTdXBwb3J0IG9ubHkKIAlkb3VibGUgWEZDUmVtb3RlU3VyZmFjZUZsaXBEZWxheTsKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
