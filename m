Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE8BC2BB1D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F512051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tKk4cOfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F512051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9406E456;
	Mon, 16 Mar 2020 13:49:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271ED6E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YchReHQH2K+i5Qr/HPwf/UWDxXRI//+1JD2tZEsYAr0oSmGjCDrinpX9lJsAGveGsHsdsON2piK1Nc8CAhWsYefWL7YDi1PQ54musgY/6W0/LNWCq8eNl3bGvDjKpRzHx9nUoTcS637iXyPyDSuNsaj+1Mh6zYyBAP5tP303BWoZUzZgsM7WWxxZ160KshO22NuDw/viFzAP8YYsZwndshspOqrgqcEAQUIwsMtYFaXmf8ptWlIDRqUa/qi/8WDKAdLi7mCTwPgPcgamDcj9QDc272hDHr0kqnXtkftAMwkiOaFbBtELQKpypH1cucGBiBt6lt18p7SBgDKJs4ptjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+1QV6P8OXnSlsa7IfzRpckwYtTYQ3sZMkW7G8ksJzA=;
 b=mWzkOaROjZKX5KkbQfEBVKMXZq1ZFiB2HN8lMwTyhwegceoh7ApKU/cjN6Eribz85qMy04fCnku+VYPbMK1nYwm9z//ZrAoWfgIGoT98+DlCT5A+JsyX9pC2ho5Bdu962eeBHJnDHEuH1qT+QYijC/j+lNEgejhqMnONThYbPotj2vycmpqZiI5TIZAYAZ66owWaSZJbt7TdqNO4bTu0niSaIzM3lFVbuVFdHQkDD1p70MBk2IaVB/Ae2BYBORuMjio/5AuvWffrUfsBafG5yhEatRtfXgtK1VwItlb5MCl5CA3/LcU+wvvVmbdQKeWGdi6SvNBODGcDkkMkY0cG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+1QV6P8OXnSlsa7IfzRpckwYtTYQ3sZMkW7G8ksJzA=;
 b=tKk4cOfC7R+giR8jzZKc6lxtCnlycoByQQTOQCLNxOgQ6LmdLgrjGpYlqy0IvTBJv1yQGoZXwn8r3N6TvLvLL3EDhB1oNuyCwiX0UIgskTWkwG2+R59uyg/CLAcKZoZW8iKNAuDae8Velr7HcApaz7J+1tFiwWTL+qyA/kyt69o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:49:56 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:49:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/19] drm/amd/display: workaround for HDMI hotplug in DPMSOFF
 state
Date: Mon, 16 Mar 2020 09:49:05 -0400
Message-Id: <20200316134920.2526155-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:55 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d14573b7-8ae7-452f-eda5-08d7c9b0e92c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:|MW2PR12MB2363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB236394C626744C0007EB932498F90@MW2PR12MB2363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(8936002)(16526019)(478600001)(8676002)(7696005)(52116002)(186003)(81156014)(81166006)(6666004)(26005)(6916009)(54906003)(316002)(5660300002)(36756003)(66556008)(66476007)(86362001)(66946007)(2616005)(956004)(2906002)(6486002)(1076003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2363;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWThEjyVtA2GsxJFsAWmvRsTAEyft5yojOANNSdN6Ch/4n/6ubxgIRhNk+za47CgMQ3gadaig/noQ26fkxBM5UVuUYgHLeH7gIJRHv09Wn7iscOm1rXF4MInecqK29QR4qCU4VaM405W2FmzL0yyJQOL7rJVSA/SPauSvWdSxkFsK5sK63uW4FGoofF+iG2PDlSusEW6uTDo8hXj8DajXoAuBXaAdMB6RsdFeUMZ20XOHNB49q12anCm8bJiXBAXddQQ2sPPVjM6tmwts31joG/CR7i7Ct2aqj8piNiL18aIiPP3kfs9amC70bgvrStrcyFYqEepWjqm5QO0uZ5IdRvHLdjy2qkTi8RWEkZSLmzH7HErwQ/SOV5C6axFYNRdkep4ulPvPUqQYoF0g289MY23ZOZ9zWLYf86SQ92TPuOTNfuLBfpzaf737IEdLWJG
X-MS-Exchange-AntiSpam-MessageData: 4ff+NmNdgut0SRp1L9bKPllZ1vLd3PVnKOOfX+NB1efKb24LVtui2kUFrDejT/n3XcyHREljLVakDpRX6WMzKJ8+sHBBur4QSqKXkB+D9rmXG62Uq6iV/l7BY1xRIS2NMKpfIfZdKKvULzPCBTU13g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14573b7-8ae7-452f-eda5-08d7c9b0e92c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:49:56.2045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kKXWJ1b+Je7wcvREi0ZVj5qKzLNmIaTCg8oV7kMgAcAPdvQRG1znUJuJrSjlD9bPfXP2fxZMg25VsomkBi1mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2363
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Rodrigo.Siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKW1doeV0KV2hlbiBo
b3RwbHVnIGEgSERNSSBtb25pdG9yIGR1cmluZyBlbnRlcmluZyBTMGkzIG9yIERQTVNPRkYgc3Rh
dGUgZHVlIHRvCmVudGVyaW5nIGluZmluaXRlIGxvb3Agd2hlbiBjYWxsaW5nIHZiaW9zIHRvIHBy
b2dyYW0gcGl4ZWwgY2xvY2tzLiBJbgp0aGlzIHNjZW5hcmlvLCBwbGwgaXMgZW5hYmxlZCBidXQg
cGh5IGlzIG5vdCwgYW5kIHRoZXJlIGlzIG5vdCBhCnByb2dyYW1pbmcgZ3VpZGUgZm9yIHRoaXMg
Y2FzZS4KCltIb3ddCkJlZm9yZSB3ZSBoYXZpbmcgdGhlIHByb3BlciBwcm9ncmFtaW5nIGd1aWRl
LCBiZWZvcmUgZGlzYWJsZSBwbGwsIGRvaW5nCmEgcGh5IGVuYWJsZSBhbmQgZGlzYWJsZSB0byBh
dm9pZCB0aGUgaXNzdWUuCgpTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgU3VuIDx5b25ncWlhbmcu
c3VuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNoZW5nQGFtZC5jb20+
CkFja2VkLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+Ci0t
LQogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jICAgIHwgIDMgKysr
CiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h3c2VxLmMgICAgfCAyMiArKysr
KysrKysrKysrKysrKysrCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h3c2Vx
LmggICAgfCAgMyArKysKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2lu
aXQuYyB8ICAxICsKIC4uLi9hbWQvZGlzcGxheS9kYy9pbmMvaHdfc2VxdWVuY2VyX3ByaXZhdGUu
aCB8ICAyICsrCiA1IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCmluZGV4IDAz
ZjBjOTkxNDUyMC4uNjllYjdiMzY5N2QyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwpAQCAtNjU0LDYgKzY1NCw5IEBAIGVudW0g
ZGNfc3RhdHVzIGRjbjIwX2VuYWJsZV9zdHJlYW1fdGltaW5nKAogCQlyZXR1cm4gRENfRVJST1Jf
VU5FWFBFQ1RFRDsKIAl9CiAKKwlpZiAoZGMtPmh3c2VxLT5mdW5jcy5QTEFUXzU4ODU2X3dhICYm
ICghZGNfaXNfZHBfc2lnbmFsKHN0cmVhbS0+c2lnbmFsKSkpCisJCWRjLT5od3NlcS0+ZnVuY3Mu
UExBVF81ODg1Nl93YShjb250ZXh0LCBwaXBlX2N0eCk7CisKIAlwaXBlX2N0eC0+c3RyZWFtX3Jl
cy50Zy0+ZnVuY3MtPnByb2dyYW1fdGltaW5nKAogCQkJcGlwZV9jdHgtPnN0cmVhbV9yZXMudGcs
CiAJCQkmc3RyZWFtLT50aW1pbmcsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNuMjEvZGNuMjFfaHdzZXEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMS9kY24yMV9od3NlcS5jCmluZGV4IDA4MWFkOGU0M2Q1OC4uYWRhNjViMWE3ZWIx
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFf
aHdzZXEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFf
aHdzZXEuYwpAQCAtMTEyLDMgKzExMiwyNSBAQCB2b2lkIGRjbjIxX29wdGltaXplX3B3cl9zdGF0
ZSgKIAkJCXRydWUpOwogfQogCisvKiBJZiB1c2VyIGhvdHBsdWcgYSBIRE1JIG1vbml0b3Igd2hp
bGUgaW4gbW9uaXRvciBvZmYsCisgKiBPUyB3aWxsIGRvIGEgbW9kZSBzZXQgKHdpdGggb3V0cHV0
IHRpbWluZykgYnV0IGtlZXAgb3V0cHV0IG9mZi4KKyAqIEluIHRoaXMgY2FzZSBEQUwgd2lsbCBh
c2sgdmJpb3MgdG8gcG93ZXIgdXAgdGhlIHBsbCBpbiB0aGUgUEhZLgorICogSWYgdXNlciB1bnBs
dWcgdGhlIG1vbml0b3IgKHdoaWxlIHdlIGFyZSBvbiBtb25pdG9yIG9mZikgb3IKKyAqIHN5c3Rl
bSBhdHRlbXB0IHRvIGVudGVyIG1vZGVybiBzdGFuZGJ5ICh3aGljaCB3ZSB3aWxsIGRpc2FibGUg
UExMKSwKKyAqIFBIWSB3aWxsIGhhbmcgb24gdGhlIG5leHQgbW9kZSBzZXQgYXR0ZW1wdC4KKyAq
IGlmIGVuYWJsZSBQTEwgZm9sbG93IGJ5IGRpc2FibGUgUExMICh3aXRob3V0IGV4ZWN1dGluZyBs
YW5lIGVuYWJsZS9kaXNhYmxlKSwKKyAqIFJEUENTX1BIWV9EUF9NUExMQl9TVEFURSByZW1haW5z
IDEsCisgKiB3aGljaCBpbmRpY2F0ZSB0aGF0IFBMTCBkaXNhYmxlIGF0dGVtcHQgYWN0dWFsbHkg
ZGlkbu+/vXQgZ28gdGhyb3VnaC4KKyAqIEFzIGEgd29ya2Fyb3VuZCwgaW5zZXJ0IFBIWSBsYW5l
IGVuYWJsZS9kaXNhYmxlIGJlZm9yZSBQTEwgZGlzYWJsZS4KKyAqLwordm9pZCBkY24yMV9QTEFU
XzU4ODU2X3dhKHN0cnVjdCBkY19zdGF0ZSAqY29udGV4dCwgc3RydWN0IHBpcGVfY3R4ICpwaXBl
X2N0eCkKK3sKKwlpZiAoIXBpcGVfY3R4LT5zdHJlYW0tPmRwbXNfb2ZmKQorCQlyZXR1cm47CisK
KwlwaXBlX2N0eC0+c3RyZWFtLT5kcG1zX29mZiA9IGZhbHNlOworCWNvcmVfbGlua19lbmFibGVf
c3RyZWFtKGNvbnRleHQsIHBpcGVfY3R4KTsKKwljb3JlX2xpbmtfZGlzYWJsZV9zdHJlYW0ocGlw
ZV9jdHgpOworCXBpcGVfY3R4LT5zdHJlYW0tPmRwbXNfb2ZmID0gdHJ1ZTsKK30KKwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h3c2VxLmgg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHdzZXEuaAppbmRl
eCAxODI3MzYwOTYxMjMuLjI2YmYyNGQzYjU5ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h3c2VxLmgKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h3c2VxLmgKQEAgLTQ0LDQgKzQ0LDcgQEAgdm9p
ZCBkY24yMV9vcHRpbWl6ZV9wd3Jfc3RhdGUoCiAJCWNvbnN0IHN0cnVjdCBkYyAqZGMsCiAJCXN0
cnVjdCBkY19zdGF0ZSAqY29udGV4dCk7CiAKK3ZvaWQgZGNuMjFfUExBVF81ODg1Nl93YShzdHJ1
Y3QgZGNfc3RhdGUgKmNvbnRleHQsCisJCXN0cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHgpOworCiAj
ZW5kaWYgLyogX19EQ19IV1NTX0RDTjIxX0hfXyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2luaXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9pbml0LmMKaW5kZXggMzJlZDM2YzMzMDZhLi5iOWZm
OTc2N2UwOGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MS9kY24yMV9pbml0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIx
L2RjbjIxX2luaXQuYwpAQCAtMTMwLDYgKzEzMCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaHdz
ZXFfcHJpdmF0ZV9mdW5jcyBkY24yMV9wcml2YXRlX2Z1bmNzID0gewogCS5kY2NnX2luaXQgPSBk
Y24yMF9kY2NnX2luaXQsCiAJLnNldF9ibGVuZF9sdXQgPSBkY24yMF9zZXRfYmxlbmRfbHV0LAog
CS5zZXRfc2hhcGVyXzNkbHV0ID0gZGNuMjBfc2V0X3NoYXBlcl8zZGx1dCwKKwkuUExBVF81ODg1
Nl93YSA9IGRjbjIxX1BMQVRfNTg4NTZfd2EsCiB9OwogCiB2b2lkIGRjbjIxX2h3X3NlcXVlbmNl
cl9jb25zdHJ1Y3Qoc3RydWN0IGRjICpkYykKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9pbmMvaHdfc2VxdWVuY2VyX3ByaXZhdGUuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9pbmMvaHdfc2VxdWVuY2VyX3ByaXZhdGUuaAppbmRleCBiMWQ3MzZj
YmNkNWEuLjUyYTI2ZTZiZTA2NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2luYy9od19zZXF1ZW5jZXJfcHJpdmF0ZS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9pbmMvaHdfc2VxdWVuY2VyX3ByaXZhdGUuaApAQCAtMTQ1LDYgKzE0NSw4
IEBAIHN0cnVjdCBod3NlcV9wcml2YXRlX2Z1bmNzIHsKIAkJCWNvbnN0IHN0cnVjdCBkY19wbGFu
ZV9zdGF0ZSAqcGxhbmVfc3RhdGUpOwogCWJvb2wgKCpzZXRfc2hhcGVyXzNkbHV0KShzdHJ1Y3Qg
cGlwZV9jdHggKnBpcGVfY3R4LAogCQkJY29uc3Qgc3RydWN0IGRjX3BsYW5lX3N0YXRlICpwbGFu
ZV9zdGF0ZSk7CisJdm9pZCAoKlBMQVRfNTg4NTZfd2EpKHN0cnVjdCBkY19zdGF0ZSAqY29udGV4
dCwKKwkJCXN0cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHgpOwogfTsKIAogc3RydWN0IGRjZV9od3Nl
cSB7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
