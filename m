Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29497C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 19:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BEB20650
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 19:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BEB20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C436EB4D;
	Tue,  5 Nov 2019 19:01:54 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DD26EB4D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 19:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISnWmwShm5FjBPuouL8eLghr4bpK9CcRQIqfSj3sJ+gpUrnNAns3znT6mB3elBBDFpEbbelshJHkXkHtIA9OR04zRZZoZnwTK6TFTcScYLsYssGB1L28EJDKcJhbJjnesYq/dWv2ZuGtfjSRN2oaPZsqofmpy+uiJay468eHjgFlpudUVGK09uwu7rk8jWj2b4MpugHCb41EtheysTag/T9AumGwNkrtxoomMXc38KWZW2KJtJOH03ILAnzYwYVwxX0Uu9GtI1hAeQ/5VMHy/lXmuKFyrHRLu/kt1qdBdFh0OBf21SjZZpGqJafJbRq0Bmce8tjQsxghcPNFOWRo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuH1Bn9575EfWKzyL4vVGBrcjkdkbAfUTSeXWojcCZw=;
 b=kcwG80m/2sI1NkCU1adCbHVxKz5hNSaJsF+6OD0f2OGikeCpTsVOvfH9sCx0HtICOctTd6A3eU+mXxqwc/jR6370RRwkQckdyDvHmiM83CgjEmZX0ynlcKCJDfDEzhciWb61XLnXCqmsyfk8Tcl9L+3dvs0t7gRR6ahgih+9vGrPnXVgej5lP3Nw0qOkk3L+gggKzIazRUYOi/587vLf40/TnO5axv4lyeZufRoYhLvPPuWarlBvVhQbMo6Z9PTiV1opiOT82H0HUWRTUFcWIGB7wOGHTeaKjdp3Apgi3y16HF8xONViMjQ7lhPA45us+WkLPeFe3UI+e4c3Yy7E5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0073.namprd12.prod.outlook.com (2603:10b6:802:20::44)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Tue, 5 Nov
 2019 19:01:51 +0000
Received: from CO1NAM03FT032.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::203) by SN1PR12CA0073.outlook.office365.com
 (2603:10b6:802:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Tue, 5 Nov 2019 19:01:51 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT032.mail.protection.outlook.com (10.152.80.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Tue, 5 Nov 2019 19:01:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 5 Nov 2019
 13:01:49 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 5 Nov 2019
 13:01:49 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 5 Nov 2019 13:01:49 -0600
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/display: Disable VUpdate interrupt for DCN hardware
Date: Tue, 5 Nov 2019 14:01:47 -0500
Message-ID: <20191105190147.7283-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105155802.1302-1-sunpeng.li@amd.com>
References: <20191105155802.1302-1-sunpeng.li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(428003)(199004)(189003)(8676002)(14444005)(81156014)(8936002)(81166006)(476003)(86362001)(70206006)(126002)(11346002)(446003)(2616005)(486006)(36756003)(426003)(305945005)(48376002)(54906003)(186003)(356004)(336012)(50466002)(76176011)(26005)(316002)(2876002)(6916009)(50226002)(47776003)(2906002)(51416003)(4326008)(1076003)(2351001)(5660300002)(70586007)(2870700001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4059; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac994935-9e31-479f-3e2e-08d762229dca
X-MS-TrafficTypeDiagnostic: DM6PR12MB4059:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4059F8BDEC770542C9615FC3827E0@DM6PR12MB4059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0212BDE3BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HFCOC+7hiCveOBdGUIxlQiNJT0yHTovvaq1MQIoMxJtb8qXmddLij9QsTXXUr3k8ckJ/zV9GHDBAdyLhPWyO313Bvxdh5MGi4nBZ7vpfIo0TeqjqRqoHDBCo2GFAu6tLz9ort3R+DvcB/piNaVQhbY9unOvThWXlvtF4piB4RxHnztdqrXSHMPCQBmCs41NWpxoowh/CtoLgvwBmwo2NJvbjrP2eP9CUCi545PoS12w5uwQMERMHpD74zZJSJMMgW1N7jhEGdXBreKhKxEkdqy4yYpthMFu30SNyfBdFOEGkibzP1PPHUVeE2K7DdRkpZmIrIWQSGIgK0B0PPKuPGsV8rySOfPUBfBsYw0mWclpxv9f2TTvlXvNEbEzN+6+v14+6t6YOf/2zE73M89hRu4WZulrXdk24Pg6nZF0b6ateGxj1OKsYLLVhZjxYuNj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2019 19:01:51.0290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac994935-9e31-479f-3e2e-08d762229dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuH1Bn9575EfWKzyL4vVGBrcjkdkbAfUTSeXWojcCZw=;
 b=Zxxb5G/RL4+rKFHvos0r34vtZ0x5TofoRzvxIahqzgRaHyrg93IZlgcQSADTYLrfgBhk1iU2waOqUp9Uy2I0Ipgvrh7qsk8/RL20+RFuKHsBFPq/4QRkca2Kbcs93HholHL9AouQ/CrGQ7hjXC14x/LBkLuy85Sj+ZgvUS6HLhU=
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
Cc: Leo Li <sunpeng.li@amd.com>, mario.kleiner.de@gmail.com,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105190147.3TPIQCmiAYQEumDsjfysXMLyKhD9-5VKz6rFvLpskDQ@z>

RnJvbTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CgpbV2h5XQoKT24gRENOIGhhcmR3YXJl
LCB0aGUgY3J0Y19oaWdoX2lycSBoYW5kbGVyIG1ha2VzIHZ1cGRhdGVfaGlnaF9pcnEKaGFuZGxl
ciByZWR1bmRhbnQuCgpBbGwgdGhlIHZ1cGRhdGUgaGFuZGxlciBkb2VzIGlzIGhhbmRsZSB2Ymxh
bmsgZXZlbnRzLCBhbmQgdXBkYXRlIHZycgpmb3IgRENFIGh3IChleGNsdWRpbmcgVkVHQSwgbW9y
ZSBvbiB0aGF0IGxhdGVyKS4gQXMgZmFyIGFzIHVzZXJtb2RlIGlzCmNvbmNlcm5lZC4gdnN0YXJ0
dXAgaGFwcGVucyBjbG9zZSBlbm91Z2ggdG8gdnVwZGF0ZSBvbiBEQ04gdGhhdCBpdCBjYW4KYmUg
Y29uc2lkZXJlZCB0aGUgInNhbWUiLiBIYW5kbGluZyB2YmxhbmsgYW5kIHVwZGF0aW5nIHZyciBh
dCB2c3RhcnR1cAplZmZlY3RpdmVseSByZXBsYWNlcyB2dXBkYXRlIG9uIERDTi4KClZlZ2EgaXMg
YSBiaXQgc3BlY2lhbC4gTGlrZSBEQ04sIHRoZSBWUlIgcmVnaXN0ZXJzIG9uIFZlZ2EgYXJlCmRv
dWJsZS1idWZmZXJlZCwgYW5kIHN3YXBwZWQgYXQgdnVwZGF0ZS4gQnV0IFVubGlrZSBEQ04sIGl0
IGxhY2tzIGEKdnN0YXJ0dXAgaW50ZXJydXB0LiBUaGlzIG1lYW5zIHdlIGNhbid0IHF1aXRlIHJl
bW92ZSB0aGUgdnVwZGF0ZSBoYW5kbGVyCmZvciBpdCwgc2luY2UgZGVsYXllZCB1c2VyIGV2ZW50
cyBkdWUgdG8gdnJyIGFyZSBzZW50IG9mZiB0aGVyZS4KCltIb3ddCgpSZW1vdmUgcmVnaXN0cmF0
aW9uIG9mIHZ1cGRhdGUgaW50ZXJydXB0IGhhbmRsZXIgZm9yIERDTi4gRGlzYWJsZQp2dXBkYXRl
IGludGVycnVwdCBpZiBhc2ljIGZhbWlseSBEQ04sIGVuYWJsZSBvdGhlcndpc2UuCgpTaWduZWQt
b2ZmLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCgp2MjogRG9uJ3QgZXhjbHVk
ZSB2ZWdhIHdoZW4gZW5hYmxpbmcgdnVwZGF0ZSBpbnRlcnJ1cHRzCgp2MzogTW92ZSBGQU1JTFlf
QUkgY2hlY2sgaW5zaWRlIGRtX3NldF92dXBkYXRlX2lycSgpCgogLi4uL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMzIgKysrLS0tLS0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggMjU2
YTIzYTBlYzI4Li5kNDAxODVkZmQwYzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtMjI0MSwzNCArMjI0MSw2IEBAIHN0YXRp
YyBpbnQgZGNuMTBfcmVnaXN0ZXJfaXJxX2hhbmRsZXJzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQogCQkJCWRtX2Rjbl9jcnRjX2hpZ2hfaXJxLCBjX2lycV9wYXJhbXMpOwogCX0KIAotCS8q
IFVzZSBWVVBEQVRFX05PX0xPQ0sgaW50ZXJydXB0IG9uIERDTiwgd2hpY2ggc2VlbXMgdG8gY29y
cmVzcG9uZCB0bwotCSAqIHRoZSByZWd1bGFyIFZVUERBVEUgaW50ZXJydXB0IG9uIERDRS4gV2Ug
d2FudCBEQ19JUlFfU09VUkNFX1ZVUERBVEV4Ci0JICogdG8gdHJpZ2dlciBhdCBlbmQgb2YgZWFj
aCB2YmxhbmssIHJlZ2FyZGxlc3Mgb2Ygc3RhdGUgb2YgdGhlIGxvY2ssCi0JICogbWF0Y2hpbmcg
RENFIGJlaGF2aW91ci4KLQkgKi8KLQlmb3IgKGkgPSBEQ05fMV8wX19TUkNJRF9fT1RHMF9JSENf
Vl9VUERBVEVfTk9fTE9DS19JTlRFUlJVUFQ7Ci0JICAgICBpIDw9IERDTl8xXzBfX1NSQ0lEX19P
VEcwX0lIQ19WX1VQREFURV9OT19MT0NLX0lOVEVSUlVQVCArIGFkZXYtPm1vZGVfaW5mby5udW1f
Y3J0YyAtIDE7Ci0JICAgICBpKyspIHsKLQkJciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYsIFNP
QzE1X0lIX0NMSUVOVElEX0RDRSwgaSwgJmFkZXYtPnZ1cGRhdGVfaXJxKTsKLQotCQlpZiAocikg
ewotCQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gYWRkIHZ1cGRhdGUgaXJxIGlkIVxuIik7Ci0JCQly
ZXR1cm4gcjsKLQkJfQotCi0JCWludF9wYXJhbXMuaW50X2NvbnRleHQgPSBJTlRFUlJVUFRfSElH
SF9JUlFfQ09OVEVYVDsKLQkJaW50X3BhcmFtcy5pcnFfc291cmNlID0KLQkJCWRjX2ludGVycnVw
dF90b19pcnFfc291cmNlKGRjLCBpLCAwKTsKLQotCQljX2lycV9wYXJhbXMgPSAmYWRldi0+ZG0u
dnVwZGF0ZV9wYXJhbXNbaW50X3BhcmFtcy5pcnFfc291cmNlIC0gRENfSVJRX1NPVVJDRV9WVVBE
QVRFMV07Ci0KLQkJY19pcnFfcGFyYW1zLT5hZGV2ID0gYWRldjsKLQkJY19pcnFfcGFyYW1zLT5p
cnFfc3JjID0gaW50X3BhcmFtcy5pcnFfc291cmNlOwotCi0JCWFtZGdwdV9kbV9pcnFfcmVnaXN0
ZXJfaW50ZXJydXB0KGFkZXYsICZpbnRfcGFyYW1zLAotCQkJCWRtX3Z1cGRhdGVfaGlnaF9pcnEs
IGNfaXJxX3BhcmFtcyk7Ci0JfQotCiAJLyogVXNlIEdSUEhfUEZMSVAgaW50ZXJydXB0ICovCiAJ
Zm9yIChpID0gRENOXzFfMF9fU1JDSURfX0hVQlAwX0ZMSVBfSU5URVJSVVBUOwogCQkJaSA8PSBE
Q05fMV8wX19TUkNJRF9fSFVCUDBfRkxJUF9JTlRFUlJVUFQgKyBhZGV2LT5tb2RlX2luZm8ubnVt
X2NydGMgLSAxOwpAQCAtNDI0OSw2ICs0MjIxLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IGRtX3Nl
dF92dXBkYXRlX2lycShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsIGJvb2wgZW5hYmxlKQogCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gY3J0Yy0+ZGV2LT5kZXZfcHJpdmF0ZTsKIAlpbnQgcmM7
CiAKKwkvKiBEbyBub3Qgc2V0IHZ1cGRhdGUgZm9yIERDTiBoYXJkd2FyZSAqLworCWlmIChhZGV2
LT5mYW1pbHkgPD0gQU1ER1BVX0ZBTUlMWV9BSSkKKwkJcmV0dXJuIDA7CisKIAlpcnFfc291cmNl
ID0gSVJRX1RZUEVfVlVQREFURSArIGFjcnRjLT5vdGdfaW5zdDsKIAogCXJjID0gZGNfaW50ZXJy
dXB0X3NldChhZGV2LT5kbS5kYywgaXJxX3NvdXJjZSwgZW5hYmxlKSA/IDAgOiAtRUJVU1k7Ci0t
IAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
