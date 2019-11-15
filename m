Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1A6C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186B82072D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186B82072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09FF6E8EB;
	Fri, 15 Nov 2019 15:46:22 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800048.outbound.protection.outlook.com [40.107.80.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8071A6E8EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 15:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUz60l5DXZpJmJvi3SWJZo5/d/I+FaMT3i148nyyy+gpZyG9OPFUzNdXR5qa4R6yAYYdYOTwQFLSshC9MECoZGOcFxj6jW9W7TW7LcMYH0a4rHe9HbVFuJ/K/uTi8okjVZj+KYS/+NKSepAN01IGmEnN9n9bytspak8jdWP6fZvl0GLnaYjfrArmz3G/DKc3PsF7cb6FNg5O+wP72M+s4Ho+dpx+Z2ExL71mdt7teeluXQAaCbUgj+IVpHblK9ckqp7CZXxmDapXCfGDjLpywzHCBFIrDFgAII485Ao5NAzliU7X4DpzpTA4QsS4eUh+srGz5DKsag750fmxq99Qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Wsb8xhCU8jp4LhqOJcnwgtDrrJTrCkwzb/PBuUMYP0=;
 b=oPNtVZ9CiMRolYj8xGyus+UkyddueFSh/n+UNtsdv5/iS6Ok0dBeyZuTluEej23cN525VgDR9pziiCa7WMykCjfR0bkopLu+0f0hhxp43HflbZWLe9N95klZlSxHGpWHW6vf6CZx4MNaMPjwWsqpSF1x3W4d80IOc7gc6CvUMrkSlV8TLD1vuAAEpAyzl8c1hsQ5/4jq3BhFe79EjnecmCkw9hZM9D4kz+OnJToufjkwvlUfM2IJYJyVr6TrMgxuRJstRJnE5hQJqa6CeYwrUvDz4PY+Bc+ftvnocHfj+7WKGy4JNUGK9mzz/q5Xz2TY2lXT5p/Bz/8h+zSBp09vPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3253.namprd12.prod.outlook.com (20.179.91.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Fri, 15 Nov 2019 15:46:19 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.025; Fri, 15 Nov 2019
 15:46:19 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: revert wait in pipelock"
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191115151308.578774-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <e090a73b-9e39-9641-6765-f466741cebfa@amd.com>
Date: Fri, 15 Nov 2019 10:46:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191115151308.578774-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9bd80cd-9935-420f-9c50-08d769e2f53e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3253:
X-MS-Exchange-PUrlCount: 2
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3253718AC3FE9D19CB9AE57CEC700@BYAPR12MB3253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(186003)(52116002)(305945005)(386003)(76176011)(316002)(58126008)(2906002)(3846002)(6116002)(229853002)(230700001)(6486002)(6666004)(66556008)(66946007)(81166006)(66476007)(81156014)(66066001)(65956001)(65806001)(8676002)(4326008)(5660300002)(47776003)(486006)(966005)(7736002)(31686004)(26005)(6506007)(53546011)(25786009)(6436002)(23676004)(14454004)(99286004)(4001150100001)(14444005)(478600001)(6306002)(6512007)(50466002)(86362001)(6246003)(8936002)(476003)(2616005)(2486003)(11346002)(31696002)(36756003)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3253;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKyMyttl9d1q6KJKLAwnISvcPEN8EHnfOnX2kwV6+M1JRU7L0UB8tkHtQuOW/9Tf7iMQfw4ye9UlAtxXcOO2OdbJkNChorfpNug/L527OINK7FwLJuOnVusbrdtaJeQFdjzTg0k51ktXGTDzBGVST2ApRTx9okcoVY0niaq/teAV6yG2MBUTqU81XF5TRqRwch7aMygO4yCrKdVbX5tZWO2SyIS1IIFUk00aCi5OUTiy91KUKE811fW2sx/cHYkBKoTJfOa0gxg/ByFifqGvclwV68bcXfagJx1VyYA/K/Oodyjxb2XMrJuMiCSoQxxeu+n7Os47QgNFwypXYQEdoIZaxJCzOSghx4YRITnAXoTDjCtxUIQ6eEzOcBYq2Y6nbApawFB1uYCt2hCdHc0oYFjyluhh1mLvb3JG44894OLmAVIZLoLnvVRMWloXjAYIV9sx+Qn5O5TX4hNI9JTcknSjAiMFBqsP61A1UzvbffU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bd80cd-9935-420f-9c50-08d769e2f53e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 15:46:19.6879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYEwUYmjROp9Ggt2zOzOnCi4gC/wV8SVCNLzqEDvQmtunEiZIg3WXb+Y35eaekRVld5e6INCZvGVVQH1vTI4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3253
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Wsb8xhCU8jp4LhqOJcnwgtDrrJTrCkwzb/PBuUMYP0=;
 b=XXtFz+HOG07QN84RcVaqN2yuwnhbARS5S2xSAZFop0ryKbe92vVVsjCvJTl7wo853VCTnnTW2o8KpZdaKAAI063Hp7GxUwvtMq6tSeHVVxABkBRz/FsDk1P+l7FsvKI66miLVJf/Dze6Z9rJasN+pJK+LCOxxzxqv3oulBW285A=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115154616.52UuQo8S_Vn9jfFJrJPlPokk3ksjd3jzqM46XdeO_sg@z>

T24gMjAxOS0xMS0xNSAxMDoxMyBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gVGhpcyByZXZl
cnRzIGNvbW1pdCA2MTcwODlkNTgzN2EzYWE0MTY3YTljNGFmYjM0OTI5ZTBkNTI4MDVkLgo+IAo+
IFRoaXMgY2F1c2VzIGhhbmdzIGluIHNvbWUgZ2FtZXMuCj4gCj4gQnVnOiBodHRwczovL2J1Z3pp
bGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTE2OQo+IEJ1ZzogaHR0cHM6Ly9idWdz
LmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTEyMjY2Cj4gQnVnOiBodHRwczovL2J1
Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTE2OQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCkkgdGhpbmsgdGhpcyB3
aWxsIGFsc28ganVzdCBoYW5nIHRoZSBzeXN0ZW0gaW4gc29tZSBjYXNlcy4KCkkga25vdyB0aGF0
IGlmIHdlJ3JlIHdhaXRpbmcgZm9yIGZsaXAgcGVuZGluZyA9PSAwIG9uIHBsYW5lIGVuYWJsZSB3
ZSd2ZSAKaGl0IGNhc2VzIHdoZXJlIGl0J3MgaHVuZyBpbmZpbml0ZWx5IG9uIGRjbjIwLgoKU2lu
Y2UgdGhpcyBjb2RlIGlzIGluIHBpcGUgbG9jayBpdHNlbGYgKHdoZXJlIHRoaXMgdGltZW91dCBj
b2RlIHdhcyAKY29udGFpbmVkKSB0aGlzIG1lYW5zIHRoYXQgd2UnZCBzaW1pbGFybHkgc2VlIGEg
c2ltaWxhciBoYW5nIC0gYnV0IG9ubHkgCmluIHRoZSBjYXNlIHdoZXJlIHdlJ2Qgc3dpdGNoaW5n
IGZsaXAgdHlwZXMuCgpUaGlzIHByb2JhYmx5IG5lZWRzIHRvIGhhdmUgYSB0aW1lb3V0IG9mIDEw
MG1zIG9yIHNvIGxpa2UgdGhlIHBsYW5lIGVuYWJsZToKCglpZiAoZmxpcF9pbW1lZGlhdGUgJiYg
bG9jaykgewoJCWNvbnN0IGludCBUSU1FT1VUX0ZPUl9GTElQX1BFTkRJTkcgPSAxMDAwMDA7CgkJ
aW50IGk7CgoJCWZvciAoaSA9IDA7IGkgPCBUSU1FT1VUX0ZPUl9GTElQX1BFTkRJTkc7ICsraSkg
ewoJCQlpZiAocGlwZS0+cGxhbmVfcmVzLmh1YnAtPmZ1bmNzLT5odWJwX2lzX2ZsaXBfcGVuZGlu
ZygKCQkJCSAgICBwaXBlLT5wbGFuZV9yZXMuaHVicCkpCgkJCQlicmVhazsKCgkJCXVkZWxheSgx
KTsKCQl9CgoJCWlmIChwaXBlLT5ib3R0b21fcGlwZSAhPSBOVUxMKSB7CgkJCWZvciAoaSA9IDA7
IGkgPCBUSU1FT1VUX0ZPUl9GTElQX1BFTkRJTkc7ICsraSkgewoJCQkJaWYgKHBpcGUtPmJvdHRv
bV9waXBlLT5wbGFuZV9yZXMuaHVicC0+ZnVuY3MKCQkJCQkgICAgLT5odWJwX2lzX2ZsaXBfcGVu
ZGluZygKCQkJCQkJICAgIHBpcGUtPmJvdHRvbV9waXBlLT5wbGFuZV9yZXMKCQkJCQkJCSAgICAu
aHVicCkpCgkJCQkJYnJlYWs7CgoJCQkJdWRlbGF5KDEpOwoJCQl9CgkJfQoJfQoKTmljaG9sYXMg
S2F6bGF1c2thcwoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24y
MC9kY24yMF9od3NlcS5jIHwgMTEgKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMC9kY24yMF9od3NlcS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjbjIwL2RjbjIwX2h3c2VxLmMKPiBpbmRleCAwMDQ2YTA5OWM5ZTkuLjliNDQ4OGVmMjdkMSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBf
aHdzZXEuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24y
MF9od3NlcS5jCj4gQEAgLTEwMzMsNiArMTAzMywxNyBAQCB2b2lkIGRjbjIwX3BpcGVfY29udHJv
bF9sb2NrKAo+ICAgCWlmIChwaXBlLT5wbGFuZV9zdGF0ZSAhPSBOVUxMKQo+ICAgCQlmbGlwX2lt
bWVkaWF0ZSA9IHBpcGUtPnBsYW5lX3N0YXRlLT5mbGlwX2ltbWVkaWF0ZTsKPiAgIAo+ICsJaWYg
KGZsaXBfaW1tZWRpYXRlICYmIGxvY2spIHsKPiArCQl3aGlsZSAocGlwZS0+cGxhbmVfcmVzLmh1
YnAtPmZ1bmNzLT5odWJwX2lzX2ZsaXBfcGVuZGluZyhwaXBlLT5wbGFuZV9yZXMuaHVicCkpCXsK
PiArCQkJdWRlbGF5KDEpOwo+ICsJCX0KPiArCj4gKwkJaWYgKHBpcGUtPmJvdHRvbV9waXBlICE9
IE5VTEwpCj4gKwkJCXdoaWxlIChwaXBlLT5ib3R0b21fcGlwZS0+cGxhbmVfcmVzLmh1YnAtPmZ1
bmNzLT5odWJwX2lzX2ZsaXBfcGVuZGluZyhwaXBlLT5ib3R0b21fcGlwZS0+cGxhbmVfcmVzLmh1
YnApKQl7Cj4gKwkJCQl1ZGVsYXkoMSk7Cj4gKwkJCX0KPiArCX0KPiArCj4gICAJLyogSW4gZmxp
cCBpbW1lZGlhdGUgYW5kIHBpcGUgc3BsaXR0aW5nIGNhc2UsIHdlIG5lZWQgdG8gdXNlIEdTTAo+
ICAgCSAqIGZvciBzeW5jaHJvbml6YXRpb24uIE9ubHkgZG8gc2V0dXAgb24gbG9ja2luZyBhbmQg
b24gZmxpcCB0eXBlIGNoYW5nZS4KPiAgIAkgKi8KPiAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
