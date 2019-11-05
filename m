Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED879C5DF60
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 19:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64D9217F4
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 19:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64D9217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624606EB50;
	Tue,  5 Nov 2019 19:07:21 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720043.outbound.protection.outlook.com [40.107.72.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57B36EB50
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 19:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLzb+t1kODgiMGz/cnqwRM8B8/jUF6lBk+8WfJ8uJIgopGhSzuz3KYJ93K3pqVL25JSFjQM6UABFo2G4NRjo+AoxEz2BFC7jSbk/CwrrmC1k6s0M692mLVzoQYak3SsaMg3/cfdyvL5jBjWgAbWwW1uccYy3OFNuQrBA/31f1Ppzc80MPA26UzyASjUpxv5xc4+bKPUF3HcoNCKyGgD4DL94diewbeW3vRnPREhqGHj1TEnSynO4jEiyfvSCBjm74HXwvkUJZyoaAGYPPkimQSok+h8t7ydoyabnoDgBq6UdXY55pL5fAX0KW99hJv7eqToLb0MRXxE3Vod0A2ryaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Od0XykIvOZ2wBo+OqLC25jS69RaDsjMBOHMik8v5tI=;
 b=eiHBKcq9PR9NcBDQU+OUBHRFGn8n/FWqHArrvhCktThBx78+zUsXBGgUcGRW50eDI52CrLvLE8oj9VzlatLyTg+d8snCXMak+AgwRLjHbjyiuauVEVeWhasYQYo3il4VwkiR0LmAdvFVMT4lJSTd3MCRbBHngtd2ddMA6WroyYGZqztDDRYk+oTB1ZIFDiFlXRRAgiNanXmVZk2gkDorg987YNKm9UeCS54CbHm/m+YQg1Bh6KEAPNT7tM2oi/FOXPz4rUxSriMrkqWefdAe/ViSIC1h/d4Qp8oK8fNAwa5bjo8Wamteeo56843v5GAJtcZ90lWg2jZlZFea1izgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0080.namprd12.prod.outlook.com (2603:10b6:0:57::24) by
 DM6PR12MB3609.namprd12.prod.outlook.com (2603:10b6:5:118::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 19:07:16 +0000
Received: from DM3NAM03FT007.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by DM3PR12CA0080.outlook.office365.com
 (2603:10b6:0:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Tue, 5 Nov 2019 19:07:16 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT007.mail.protection.outlook.com (10.152.82.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Tue, 5 Nov 2019 19:07:16 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 5 Nov 2019
 13:07:15 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 5 Nov 2019 13:07:15 -0600
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amd/display: Disable VUpdate interrupt for DCN hardware
Date: Tue, 5 Nov 2019 14:07:09 -0500
Message-ID: <20191105190709.7816-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105155802.1302-1-sunpeng.li@amd.com>
References: <20191105155802.1302-1-sunpeng.li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(428003)(189003)(199004)(70586007)(81166006)(4326008)(86362001)(478600001)(48376002)(70206006)(6666004)(356004)(54906003)(316002)(36756003)(2616005)(426003)(11346002)(446003)(14444005)(126002)(476003)(486006)(50466002)(305945005)(2351001)(2876002)(26005)(5660300002)(6916009)(186003)(1076003)(81156014)(76176011)(8676002)(8936002)(51416003)(2870700001)(47776003)(2906002)(50226002)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3609; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 243fcf1a-e105-4fc6-be1f-08d762235f89
X-MS-TrafficTypeDiagnostic: DM6PR12MB3609:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3609712F18719C7B7D519E9F827E0@DM6PR12MB3609.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0212BDE3BE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enf+QY0YGhXHYG2H3InzYb8Wj+BU3PVx2kxGzrPgBJvjI+a5Jt4WjAiUYwlxXJt3/YBA30fPb+MIHhUNBfB+iLR9zvZBPRLJMhmlcx/ESLEWYb/ORmKZXTZV0GS627298Bp8In5cB0QE7zEqtLBHQY/W6rPIs89KsItVWA3gTVfYtM6LkYrheyEdgCaBNW9vn4MYuTRTYBV7GNdjne3INpIlneYdR3nDS4sPW/FEI44iqEq7M8NK2MyMGMrf2mnje/3XBfZrvlGlhRtXG2anjRrf3AoNr8P94PRf8Ee09ZGel9KiPAxJ0WfC69yVPh7v+7Ei5w2FXBS1doIL6Xk3hnA3HQZcQOIfk/DrRyvyhWgjx3V3ty9tib8V1nTUzQJ3nwmrKS6M4/XOVbxUo8jDqByZX4vCfKFgOjYhS0sv9wDMQU6EK6uoISFK7xQwaZs1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2019 19:07:16.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 243fcf1a-e105-4fc6-be1f-08d762235f89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3609
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Od0XykIvOZ2wBo+OqLC25jS69RaDsjMBOHMik8v5tI=;
 b=EmboipARlzN03MIegWPghNKW8xBngSmC2Vc8ja7X70vCQhCp45xvddXpf2AXqaY2YVVS+S52i7jElj/Rik+BHziZ8Xy9xLSrSGjby5jBIm0hfcfFCZMIjCzFxkSJ/c1YUbGX5RSEZez4wRYPeIHwcwhH8DxYFIcwlcrLmT4ep9c=
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
Message-ID: <20191105190709.T7sutApxHFYXqfdPk7xIA20KGTIb4cWxlo8LkeH0VUM@z>

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
QUkgY2hlY2sgaW5zaWRlIGRtX3NldF92dXBkYXRlX2lycSgpCgp2NDogQ29ycmVjdCBhIGJyYWlu
IGZhcnQKCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAz
MiArKystLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAy
OCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwppbmRleCAyNTZhMjNhMGVjMjguLmQ0MDE4NWRmZDBjMCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCkBA
IC0yMjQxLDM0ICsyMjQxLDYgQEAgc3RhdGljIGludCBkY24xMF9yZWdpc3Rlcl9pcnFfaGFuZGxl
cnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQkJZG1fZGNuX2NydGNfaGlnaF9pcnEs
IGNfaXJxX3BhcmFtcyk7CiAJfQoKLQkvKiBVc2UgVlVQREFURV9OT19MT0NLIGludGVycnVwdCBv
biBEQ04sIHdoaWNoIHNlZW1zIHRvIGNvcnJlc3BvbmQgdG8KLQkgKiB0aGUgcmVndWxhciBWVVBE
QVRFIGludGVycnVwdCBvbiBEQ0UuIFdlIHdhbnQgRENfSVJRX1NPVVJDRV9WVVBEQVRFeAotCSAq
IHRvIHRyaWdnZXIgYXQgZW5kIG9mIGVhY2ggdmJsYW5rLCByZWdhcmRsZXNzIG9mIHN0YXRlIG9m
IHRoZSBsb2NrLAotCSAqIG1hdGNoaW5nIERDRSBiZWhhdmlvdXIuCi0JICovCi0JZm9yIChpID0g
RENOXzFfMF9fU1JDSURfX09URzBfSUhDX1ZfVVBEQVRFX05PX0xPQ0tfSU5URVJSVVBUOwotCSAg
ICAgaSA8PSBEQ05fMV8wX19TUkNJRF9fT1RHMF9JSENfVl9VUERBVEVfTk9fTE9DS19JTlRFUlJV
UFQgKyBhZGV2LT5tb2RlX2luZm8ubnVtX2NydGMgLSAxOwotCSAgICAgaSsrKSB7Ci0JCXIgPSBh
bWRncHVfaXJxX2FkZF9pZChhZGV2LCBTT0MxNV9JSF9DTElFTlRJRF9EQ0UsIGksICZhZGV2LT52
dXBkYXRlX2lycSk7Ci0KLQkJaWYgKHIpIHsKLQkJCURSTV9FUlJPUigiRmFpbGVkIHRvIGFkZCB2
dXBkYXRlIGlycSBpZCFcbiIpOwotCQkJcmV0dXJuIHI7Ci0JCX0KLQotCQlpbnRfcGFyYW1zLmlu
dF9jb250ZXh0ID0gSU5URVJSVVBUX0hJR0hfSVJRX0NPTlRFWFQ7Ci0JCWludF9wYXJhbXMuaXJx
X3NvdXJjZSA9Ci0JCQlkY19pbnRlcnJ1cHRfdG9faXJxX3NvdXJjZShkYywgaSwgMCk7Ci0KLQkJ
Y19pcnFfcGFyYW1zID0gJmFkZXYtPmRtLnZ1cGRhdGVfcGFyYW1zW2ludF9wYXJhbXMuaXJxX3Nv
dXJjZSAtIERDX0lSUV9TT1VSQ0VfVlVQREFURTFdOwotCi0JCWNfaXJxX3BhcmFtcy0+YWRldiA9
IGFkZXY7Ci0JCWNfaXJxX3BhcmFtcy0+aXJxX3NyYyA9IGludF9wYXJhbXMuaXJxX3NvdXJjZTsK
LQotCQlhbWRncHVfZG1faXJxX3JlZ2lzdGVyX2ludGVycnVwdChhZGV2LCAmaW50X3BhcmFtcywK
LQkJCQlkbV92dXBkYXRlX2hpZ2hfaXJxLCBjX2lycV9wYXJhbXMpOwotCX0KLQogCS8qIFVzZSBH
UlBIX1BGTElQIGludGVycnVwdCAqLwogCWZvciAoaSA9IERDTl8xXzBfX1NSQ0lEX19IVUJQMF9G
TElQX0lOVEVSUlVQVDsKIAkJCWkgPD0gRENOXzFfMF9fU1JDSURfX0hVQlAwX0ZMSVBfSU5URVJS
VVBUICsgYWRldi0+bW9kZV9pbmZvLm51bV9jcnRjIC0gMTsKQEAgLTQyNDksNiArNDIyMSwxMCBA
QCBzdGF0aWMgaW5saW5lIGludCBkbV9zZXRfdnVwZGF0ZV9pcnEoc3RydWN0IGRybV9jcnRjICpj
cnRjLCBib29sIGVuYWJsZSkKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGNydGMtPmRl
di0+ZGV2X3ByaXZhdGU7CiAJaW50IHJjOwoKKwkvKiBEbyBub3Qgc2V0IHZ1cGRhdGUgZm9yIERD
TiBoYXJkd2FyZSAqLworCWlmIChhZGV2LT5mYW1pbHkgPiBBTURHUFVfRkFNSUxZX0FJKQorCQly
ZXR1cm4gMDsKKwogCWlycV9zb3VyY2UgPSBJUlFfVFlQRV9WVVBEQVRFICsgYWNydGMtPm90Z19p
bnN0OwoKIAlyYyA9IGRjX2ludGVycnVwdF9zZXQoYWRldi0+ZG0uZGMsIGlycV9zb3VyY2UsIGVu
YWJsZSkgPyAwIDogLUVCVVNZOwotLQoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
