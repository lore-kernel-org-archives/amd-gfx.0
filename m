Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3540C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A462420848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A462420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB55C6E29B;
	Mon,  2 Dec 2019 17:35:52 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800075.outbound.protection.outlook.com [40.107.80.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1603F6E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIPch68epfF2x2OOI62G7qdLjOEe1mTUfpEsilxnyDEsruzrcbRLbeJcbEKnKQGnLDB7Nnv8cxeIsreZ7nLdTPlBX0w/Y60PeUVgbTK2z7bQvqZPCuUVFoIQk2gt1dV0VJeh2EXlp/h2KuRVt1LwsfebP847m/F8kuzgoT5l/BoKFre1MAevTp4tN5koOwjDRo/ivLQWLa7RZsDRlpKMW2ZU2e4uWR5mOvPINp6NuHRIaRUbqQw7WhpFB7Y72+ahXQiroC+aqyLdwBuzA6o9ue3uWJyZgNjaJplkn+b+bobUeUeGKxNeWSUBJbIKy7f4sP5sRx1pQ+fNesyxeTPrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hV4hx9z/gU79Y85On0BNArb284hr0/Mupj7KrFvvrE=;
 b=JRjLj975U/mV6E+9NyYthNFZwfsWUBiWr00JZzt39EvMKaYfEj3Hh+NeVXY1fsNbrvZu8PIG61yj31QJFR+76mS1QTupToD9bGJX2GYR0a74s+KC+aSneQ2aYw/8ElNsDn1U6u+2/xCGw+1HLFBR92A+Su48HlUfiM2EvZ5g8XPCl4tRrJKk4ZFwZpwi5Y8G37U+/DDr2TOhASV9skxpgewFd3kSy4P7p/sZ1zD6F33b4W+0tyDdoZLPK4u2Z6YRPri8A3z3TfHcYUUPDzihKRgbHDd+cGokOo4ShnxaJqTHw0msLx4ydzfB6TGGhR+d+yVVHJLGFbQKCUk6on/qBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:48 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:48 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 35/51] drm/amd/display: Modify logic for when to wait for mpcc
 idle
Date: Mon,  2 Dec 2019 12:33:49 -0500
Message-Id: <20191202173405.31582-36-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1139817e-a777-40c9-e464-08d7774e004f
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610E8BE051A68D9BE529C5882430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmSG4VXWxXPR+I8uGoiLhgKR5HYv6kz0YJn+jnZtmxkMuahq+4hQoE1fAVJuDfjL+pvFr/dhfM1na6NTTOp7xUmwrLrhtujbm84uJ5CYG3Mpxa+JEt8cnSV3z+R65SzgOboHfCOnMqhUr1R7m8pQm9WyxD3hw2aspASHYH4jww7MAmlBF5p6+KE8Sci2Vll1pekBLH0S1n0o8vRG6WyTq1vJGcPjtFWLb6ATo05mjxJivJaBKVCIRxBWVp4N32UR7SFGpMkPm5991KDUKcEeQXcXtoOspPZOxMKsVkKI8DJFiiWxM1OsBlKEqg9KBy02tn3S82XMurfEHkL+pwnrhYemTw3DbA3cwSAhZZuz/zQj8PNpzsa/QcMByaNrrDqsX0nxc07wyRHYflIcHRn3VKXAjt1ImMxUnGSdI0K2Jb4t/oPeZo6KtK5iF76xSB54
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1139817e-a777-40c9-e464-08d7774e004f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:19.5033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFmszGbninQ/dVbbF1mY5ElG1Xh3E9DjlChehTO+Z5bfso7wF3qFRuyXuHxPRqe2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hV4hx9z/gU79Y85On0BNArb284hr0/Mupj7KrFvvrE=;
 b=35YVTgwN2uuUHnaWVPF0l6Y5toWe3/oDkhF/AkEs7JEiRj3xSOpzRayvwwXRoKb8XqmZ9IEbvYQVeVnZBkhNkPqgAcycHXQfpcg2h++HT9PegoCywGlquR6/NQNG3iKZuXOSW95tflqLL0p0ET8dm4XN29lm1/M936OKdtDdLFo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, Noah Abradjian <noah.abradjian@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTm9haCBBYnJhZGppYW4gPG5vYWguYWJyYWRqaWFuQGFtZC5jb20+CgpbV2h5XQpJIHdh
cyBhZHZpc2VkIHRoYXQgd2UgbWF5IG5lZWQgdG8gY2hlY2sgZm9yIG1wY2MgaWRsZSBpbiBtb3Jl
IGNhc2VzCnRoYW4ganVzdCB3aGVuIG9wcF9jaGFuZ2VkIGlzIHRydWUuIEFsc28sIG1wY2NfaW5z
dCBpcyBlcXVhbCB0bwpwaXBlX2lkeCwgc28gcmVtb3ZlIGZvciBsb29wLgoKW0hvd10KUmVtb3Zl
IG9wcF9jaGFuZ2VkIGZsYWcgY2hlY2sgYW5kIG1wY2NfaW5zdCBsb29wLgoKU2lnbmVkLW9mZi1i
eTogTm9haCBBYnJhZGppYW4gPG5vYWguYWJyYWRqaWFuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBE
bXl0cm8gTGFrdHl1c2hraW4gPERteXRyby5MYWt0eXVzaGtpbkBhbWQuY29tPgpBY2tlZC1ieTog
TGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCmluZGV4IGZiMjMxNDJj
ZjUzNS4uMmQwOTNmZjBhNzZjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwpAQCAtMTMzMCwxNiArMTMzMCwxNiBAQCBzdGF0aWMg
dm9pZCBkY24yMF91cGRhdGVfZGNodWJwX2RwcCgKIAlpZiAocGlwZV9jdHgtPnVwZGF0ZV9mbGFn
cy5iaXRzLm1wY2MKIAkJCXx8IHBsYW5lX3N0YXRlLT51cGRhdGVfZmxhZ3MuYml0cy5nbG9iYWxf
YWxwaGFfY2hhbmdlCiAJCQl8fCBwbGFuZV9zdGF0ZS0+dXBkYXRlX2ZsYWdzLmJpdHMucGVyX3Bp
eGVsX2FscGhhX2NoYW5nZSkgewotCQkvKiBOZWVkIG1wY2MgdG8gYmUgaWRsZSBpZiBjaGFuZ2lu
ZyBvcHAgKi8KLQkJaWYgKHBpcGVfY3R4LT51cGRhdGVfZmxhZ3MuYml0cy5vcHBfY2hhbmdlZCkg
ewotCQkJc3RydWN0IHBpcGVfY3R4ICpvbGRfcGlwZV9jdHggPSAmZGMtPmN1cnJlbnRfc3RhdGUt
PnJlc19jdHgucGlwZV9jdHhbcGlwZV9jdHgtPnBpcGVfaWR4XTsKLQkJCWludCBtcGNjX2luc3Q7
Ci0KLQkJCWZvciAobXBjY19pbnN0ID0gMDsgbXBjY19pbnN0IDwgTUFYX1BJUEVTOyBtcGNjX2lu
c3QrKykgewotCQkJCWlmICghb2xkX3BpcGVfY3R4LT5zdHJlYW1fcmVzLm9wcC0+bXBjY19kaXNj
b25uZWN0X3BlbmRpbmdbbXBjY19pbnN0XSkKLQkJCQkJY29udGludWU7CisJCS8vIE1QQ0MgaW5z
dCBpcyBlcXVhbCB0byBwaXBlIGluZGV4IGluIHByYWN0aWNlCisJCWludCBtcGNjX2luc3QgPSBw
aXBlX2N0eC0+cGlwZV9pZHg7CisJCWludCBvcHBfaW5zdDsKKwkJaW50IG9wcF9jb3VudCA9IGRj
LT5yZXNfcG9vbC0+cmVzX2NhcC0+bnVtX29wcDsKKworCQlmb3IgKG9wcF9pbnN0ID0gMDsgb3Bw
X2luc3QgPCBvcHBfY291bnQ7IG9wcF9pbnN0KyspIHsKKwkJCWlmIChkYy0+cmVzX3Bvb2wtPm9w
cHNbb3BwX2luc3RdLT5tcGNjX2Rpc2Nvbm5lY3RfcGVuZGluZ1ttcGNjX2luc3RdKSB7CiAJCQkJ
ZGMtPnJlc19wb29sLT5tcGMtPmZ1bmNzLT53YWl0X2Zvcl9pZGxlKGRjLT5yZXNfcG9vbC0+bXBj
LCBtcGNjX2luc3QpOwotCQkJCW9sZF9waXBlX2N0eC0+c3RyZWFtX3Jlcy5vcHAtPm1wY2NfZGlz
Y29ubmVjdF9wZW5kaW5nW21wY2NfaW5zdF0gPSBmYWxzZTsKKwkJCQlkYy0+cmVzX3Bvb2wtPm9w
cHNbb3BwX2luc3RdLT5tcGNjX2Rpc2Nvbm5lY3RfcGVuZGluZ1ttcGNjX2luc3RdID0gZmFsc2U7
CisJCQkJYnJlYWs7CiAJCQl9CiAJCX0KIAkJaHdzLT5mdW5jcy51cGRhdGVfbXBjYyhkYywgcGlw
ZV9jdHgpOwotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
