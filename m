Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C6C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 04:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DD920674
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 04:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DD920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778C46E978;
	Thu,  5 Dec 2019 04:13:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504276E978
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 04:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEUroAQtBJDFWpr6GPUhRVu+qd/RL8oV9FxF/i48IO09iUT6ChzORhPM5uCu5xthA20bRi6o7EjeWOO/ZvSGm8WiOVkmssHidf7CXpXdmTvxNlwkZWReCnsqOCjQgdxKAHUBcF/NA2dziqx0xGyIwW0ACLN2IEbsHZG/PbNGSsWqFO6fEgiI4gMx6Dho0wzH1tIyuURDIXgPK4lrxVNiog0w6BId7VxArWKd/wmvb5nvT8SsQDwH7Za34/4P6iluuKy+SDsCT9z7eCicpr9KWX8MJxCifeiit6bKVv2JjJmzbEGcudyOOmqI4VVrSmuMoMbWwQDC41LNIh2OABv7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUIH/FDvweDezllq9hmyYzVUXu5Zm5JXXAx7RFTbcJw=;
 b=FtdU86uRpHUNeFoSl+iAVcZYXTOK4CE2Mvw9fCBybaxOsBxhCZZ2SGEHo5Qm+8OGp0SGXsV+anFro964IT1RxSNhglR3KmNwna3Ms/oR7jIOtHTlsVCAS6TXAFNr7W4ZVi32TLLZFVSI/lrKs/wAdn0qcXMqsFBEZh4UGCmolAaspvRINEtiYaMwtrJ/SHA5SGFGk6MBiS6hyqWwqC/RbDMF4bG0/sZ+og2kLTDi/sfyi+nxEeOlhusr2sk2sQ5ybh//kRav/lS04Wq6V7r464qaJ6N91SaaEsJTpdW5xif1ZmEA9zYTdgSitqOkybLCp6AjqHu0GrYq+UYe4eBxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3179.namprd12.prod.outlook.com (20.179.104.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 04:13:47 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 04:13:46 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Improve kfd_process lookup in kfd_ioctl
Date: Wed,  4 Dec 2019 23:13:11 -0500
Message-Id: <20191205041311.19270-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd5a40a0-5063-4e0b-73ad-08d7793985fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:|DM6PR12MB3179:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31796479BC5275005FD9C55C925C0@DM6PR12MB3179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(51416003)(25786009)(52116002)(99286004)(36756003)(478600001)(4326008)(8676002)(2870700001)(50226002)(6436002)(7736002)(6916009)(305945005)(2906002)(2616005)(6486002)(6506007)(14454004)(6116002)(316002)(2361001)(6512007)(2351001)(14444005)(50466002)(48376002)(66476007)(86362001)(8936002)(81156014)(3846002)(81166006)(1076003)(5660300002)(66556008)(186003)(6666004)(66946007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3179;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIaxpajOkxX4Ekp5+PuVAdudRFdmNjzkWbK0TMeIhqfgtzTt/npifuOOu8hleGn7KmMmI3fKCdVnqa8h6APAZ6+KkuoVtJdozkYWfPYX3Q/3LyOlDT++xZSsUfbwNRb84TIh7JYZbWdZfRod5QIGdazlmSq80l2lEuEC3aNgbpHRhH3211IdHdhFtfo6LcPLjU5vDnYQOmbgW8yISEV6+JQcRprtCBGD1IQEMyLbO1qs5OvvQIUKnxe6UX3qY0y5pW7IfPLeaWYeI2mfZ5OZObWKNhDtx8oonI7tpn16wxC5/WLhfyvPwuasH0zjR0IJsuJaySxEs8IyNoAJ/hnm93C0OTB3V/ap3OEFjGVr2NyWnr0ZXDRWLls6MuY3VZcu1No1IjfvtimCjHdOyrxhr24YjwNdhrRP/EDneCdYdhXF6N/VFac4V+JFPy3/vgaf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5a40a0-5063-4e0b-73ad-08d7793985fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 04:13:46.6518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hdpl3vb8BzdE6iKCTz+2e6sqzLuM9KSF8C+rYsVgj/wQtHxQSyIjCQYdBchoMLNjCyUjWOpcciKzWwgvYcMxEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUIH/FDvweDezllq9hmyYzVUXu5Zm5JXXAx7RFTbcJw=;
 b=Fj01Ntm6mkhBAYokVvU2D1Lu07Mdyc2IyHWNtvfo1lX83BQ84ploztQZPFcYqfcnq/NjyqF0aA1OeMI0RyBDyAN0r3qdpB6w94O9JHO6Bfil3fRjBReXmrz7ZwBR+JPS+YwIa7HLmI8V8AM3KJ/pYLe4tuyfB6FFtz3+OnJ4SdI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Cc: sean.keely@amd.com, jonathan.kim@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VXNlIGZpbGVwLT5wcml2YXRlX2RhdGEgdG8gc3RvcmUgYSBwb2ludGVyIHRvIHRoZSBrZmRfcHJv
Y2VzcyBkYXRhCnN0cnVjdHVyZS4gVGFrZSBhbiBleHRyYSByZWZlcmVuY2UgZm9yIHRoYXQsIHdo
aWNoIGdldHMgcmVsZWFzZWQgaW4KdGhlIGtmZF9yZWxlYXNlIGNhbGxiYWNrLiBDaGVjayB0aGF0
IHRoZSBwcm9jZXNzIGNhbGxpbmcga2ZkX2lvY3RsCmlzIHRoZSBzYW1lIHRoYXQgb3BlbmVkIHRo
ZSBmaWxlIGRlc2NyaXB0b3IuIFJldHVybiAtRUJBREYgaWYgaXQncwpub3QsIHNvIHRoYXQgdGhp
cyBlcnJvciBjYW4gYmUgZGlzdGluZ3Vpc2hlZCBpbiB1c2VyIG1vZGUuCgpTaWduZWQtb2ZmLWJ5
OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIHwgMzAgKysrKysrKysrKysrKysrKysrKyst
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIHwgIDIgKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwppbmRleCAyY2I1MWQxZTg1N2MuLjFhZWJk
YTRiYmJlNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJk
ZXYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jCkBAIC00
Miw2ICs0Miw3IEBACiAKIHN0YXRpYyBsb25nIGtmZF9pb2N0bChzdHJ1Y3QgZmlsZSAqLCB1bnNp
Z25lZCBpbnQsIHVuc2lnbmVkIGxvbmcpOwogc3RhdGljIGludCBrZmRfb3BlbihzdHJ1Y3QgaW5v
ZGUgKiwgc3RydWN0IGZpbGUgKik7CitzdGF0aWMgaW50IGtmZF9yZWxlYXNlKHN0cnVjdCBpbm9k
ZSAqLCBzdHJ1Y3QgZmlsZSAqKTsKIHN0YXRpYyBpbnQga2ZkX21tYXAoc3RydWN0IGZpbGUgKiwg
c3RydWN0IHZtX2FyZWFfc3RydWN0ICopOwogCiBzdGF0aWMgY29uc3QgY2hhciBrZmRfZGV2X25h
bWVbXSA9ICJrZmQiOwpAQCAtNTEsNiArNTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVf
b3BlcmF0aW9ucyBrZmRfZm9wcyA9IHsKIAkudW5sb2NrZWRfaW9jdGwgPSBrZmRfaW9jdGwsCiAJ
LmNvbXBhdF9pb2N0bCA9IGtmZF9pb2N0bCwKIAkub3BlbiA9IGtmZF9vcGVuLAorCS5yZWxlYXNl
ID0ga2ZkX3JlbGVhc2UsCiAJLm1tYXAgPSBrZmRfbW1hcCwKIH07CiAKQEAgLTEyNCw4ICsxMjYs
MTMgQEAgc3RhdGljIGludCBrZmRfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmls
ZSAqZmlsZXApCiAJaWYgKElTX0VSUihwcm9jZXNzKSkKIAkJcmV0dXJuIFBUUl9FUlIocHJvY2Vz
cyk7CiAKLQlpZiAoa2ZkX2lzX2xvY2tlZCgpKQorCWlmIChrZmRfaXNfbG9ja2VkKCkpIHsKKwkJ
a2ZkX3VucmVmX3Byb2Nlc3MocHJvY2Vzcyk7CiAJCXJldHVybiAtRUFHQUlOOworCX0KKworCS8q
IGZpbGVwIG5vdyBvd25zIHRoZSByZWZlcmVuY2UgcmV0dXJuZWQgYnkga2ZkX2NyZWF0ZV9wcm9j
ZXNzICovCisJZmlsZXAtPnByaXZhdGVfZGF0YSA9IHByb2Nlc3M7CiAKIAlkZXZfZGJnKGtmZF9k
ZXZpY2UsICJwcm9jZXNzICVkIG9wZW5lZCwgY29tcGF0IG1vZGUgKDMyIGJpdCkgLSAlZFxuIiwK
IAkJcHJvY2Vzcy0+cGFzaWQsIHByb2Nlc3MtPmlzXzMyYml0X3VzZXJfbW9kZSk7CkBAIC0xMzMs
NiArMTQwLDE2IEBAIHN0YXRpYyBpbnQga2ZkX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGZpbGUgKmZpbGVwKQogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IGtmZF9yZWxlYXNl
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKK3sKKwlzdHJ1Y3Qga2Zk
X3Byb2Nlc3MgKnByb2Nlc3MgPSBmaWxlcC0+cHJpdmF0ZV9kYXRhOworCisJaWYgKHByb2Nlc3Mp
CisJCWtmZF91bnJlZl9wcm9jZXNzKHByb2Nlc3MpOworCisJcmV0dXJuIDA7Cit9CisKIHN0YXRp
YyBpbnQga2ZkX2lvY3RsX2dldF92ZXJzaW9uKHN0cnVjdCBmaWxlICpmaWxlcCwgc3RydWN0IGtm
ZF9wcm9jZXNzICpwLAogCQkJCQl2b2lkICpkYXRhKQogewpAQCAtMTg0MCw5ICsxODU3LDE0IEBA
IHN0YXRpYyBsb25nIGtmZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsIHVuc2lnbmVkIGludCBj
bWQsIHVuc2lnbmVkIGxvbmcgYXJnKQogCiAJZGV2X2RiZyhrZmRfZGV2aWNlLCAiaW9jdGwgY21k
IDB4JXggKCMweCV4KSwgYXJnIDB4JWx4XG4iLCBjbWQsIG5yLCBhcmcpOwogCi0JcHJvY2VzcyA9
IGtmZF9nZXRfcHJvY2VzcyhjdXJyZW50KTsKLQlpZiAoSVNfRVJSKHByb2Nlc3MpKSB7Ci0JCWRl
dl9kYmcoa2ZkX2RldmljZSwgIm5vIHByb2Nlc3NcbiIpOworCS8qIEdldCB0aGUgcHJvY2VzcyBz
dHJ1Y3QgZnJvbSB0aGUgZmlsZXAuIE9ubHkgdGhlIHByb2Nlc3MKKwkgKiB0aGF0IG9wZW5lZCAv
ZGV2L2tmZCBjYW4gdXNlIHRoZSBmaWxlIGRlc2NyaXB0b3IuIENoaWxkCisJICogcHJvY2Vzc2Vz
IG5lZWQgdG8gY3JlYXRlIHRoZWlyIG93biBLRkQgZGV2aWNlIGNvbnRleHQuCisJICovCisJcHJv
Y2VzcyA9IGZpbGVwLT5wcml2YXRlX2RhdGE7CisJaWYgKHByb2Nlc3MtPmxlYWRfdGhyZWFkICE9
IGN1cnJlbnQtPmdyb3VwX2xlYWRlcikgeworCQlkZXZfZGJnKGtmZF9kZXZpY2UsICJVc2luZyBL
RkQgRkQgaW4gd3JvbmcgcHJvY2Vzc1xuIik7CisJCXJldGNvZGUgPSAtRUJBREY7CiAJCWdvdG8g
ZXJyX2kxOwogCX0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3Byb2Nlc3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMKaW5k
ZXggODI3NjYwMWExMjJmLi5iYjJmMjY1MzJmZWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3Byb2Nlc3MuYwpAQCAtMzI0LDYgKzMyNCw4IEBAIHN0cnVjdCBrZmRfcHJvY2VzcyAq
a2ZkX2NyZWF0ZV9wcm9jZXNzKHN0cnVjdCBmaWxlICpmaWxlcCkKIAkJCQkJKGludClwcm9jZXNz
LT5sZWFkX3RocmVhZC0+cGlkKTsKIAl9CiBvdXQ6CisJaWYgKHByb2Nlc3MpCisJCWtyZWZfZ2V0
KCZwcm9jZXNzLT5yZWYpOwogCW11dGV4X3VubG9jaygma2ZkX3Byb2Nlc3Nlc19tdXRleCk7CiAK
IAlyZXR1cm4gcHJvY2VzczsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
