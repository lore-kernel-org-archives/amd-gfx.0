Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB84C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 02:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6012187F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 02:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UkouYyJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6012187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8231C89E47;
	Mon, 13 Jan 2020 02:06:37 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680047.outbound.protection.outlook.com [40.107.68.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C85D89E47
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 02:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odBjRyzv3Hpp4awErh2MeWvi7rVcxrT4twkd5ebRAYWVSf/3Lx3LH6UrFTm+L0qd32twiS8A/LA1jzqCJfDQW63ht7acgBvkU/q3tp7qe4lV9lgY4E6Ns4ZmHD2O/HnUvb9GIcbsogPsNEBfzr90pOD9WCxKM/ZtQ8RDvV7clq5w6gFAHeSY8ZiRFw+xa9vwD7Rex4BFOjSBUqEaPDQA61C3roPlC7kJmrcd1INlxIA6cYanxuoi4sLNZ6wLdE2X26gF6Upp4769Hzt7Zsna9cqB/cRjCQA0cYGTDoXLus0dK25G/YqNbeyHoCotWOlMgTSJf8yhhmycQ4kBaFcnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uqRrutGi/XsscP1wUZ+OgNymRqAnxMrxaM5ds5yJhI=;
 b=IiC/uC4EnGvTRbIigZoN7wI171uI2kMjNXzHITwCp2wwYPlN0ev1yTYJp/Vqdw5CwknS+lFz2GgXAz1LLaXhHKAyK0TMuOBxWelzFXNei5HaKQYouH3tObHFAdnJa+IiDV0U1ynntqbDo5Wj85FV/JFcBHfp345lpA5x3ju1+ISYUQbRFwbTz2V5ucI+BIk00jsjaQRykfzqTPr4hMsYRCcwcg3kGh7XM1xSQR+unlfu1Y/Dq4H+2iUhSyOUSf76FMvLcGAXbmaZJCEyEMtRRj0BTN2fpWWZaSwrA4cLFOL1+F7CLjf+o9MWeCUUJLAoV/VFzCu/dPnuTav+eHA0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uqRrutGi/XsscP1wUZ+OgNymRqAnxMrxaM5ds5yJhI=;
 b=UkouYyJIyzhILFpkCjeZr3LjLTW53cigJHSyVY+i51w3NYWyEbBrdbo63GlZl3w3Ut3ANzJUYv7ofLnE0HplAbzrwjV8cBEPGfCnAGnUqVGTR1xIspfn3sClrS8Cb7ES6mpmOxl80rTkRQLNFL7qapYyyN9/QdQCamAyqF6xcno=
Received: from DM5PR12CA0022.namprd12.prod.outlook.com (2603:10b6:4:1::32) by
 SN1PR12MB2383.namprd12.prod.outlook.com (2603:10b6:802:26::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Mon, 13 Jan 2020 02:06:33 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by DM5PR12CA0022.outlook.office365.com
 (2603:10b6:4:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Mon, 13 Jan 2020 02:06:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 02:06:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 12 Jan
 2020 20:06:32 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 12 Jan
 2020 20:06:32 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 12 Jan 2020 20:06:29 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix modprobe failure of the secondary GPU when
 GDDR6 training enabled(V5)
Date: Mon, 13 Jan 2020 10:06:27 +0800
Message-ID: <20200113020627.9976-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(428003)(199004)(189003)(2906002)(4326008)(54906003)(7696005)(316002)(1076003)(66574012)(86362001)(6916009)(44832011)(356004)(478600001)(70586007)(36756003)(8676002)(8936002)(81156014)(70206006)(81166006)(186003)(426003)(2616005)(26005)(336012)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2383; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34403a34-3ca0-4103-7b24-08d797cd3620
X-MS-TrafficTypeDiagnostic: SN1PR12MB2383:
X-Microsoft-Antispam-PRVS: <SN1PR12MB238374FF09DA8A6A95BEA9F895350@SN1PR12MB2383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bwc4PtXyshYNnzsh9MMu2AzX/oF2drQcqCnA3zT+9R4Lc6TX0rUQwxKyHju1RlF/52ICMuOLHUkR6nr92n6+Dg4nDar91nx4TaFNovG+jIMqnYoVmn0uiPfDK+sGB/371iEp+GXNaNe8tVtK6HECZ8y/icSO5ZBzEfZVviH0ZM7c89Yk/XsGT3RwRhQa0WoVcOO4hHpA/KiBdj8CmDfdZtKe9wZGvmDWu0Qr35S151ikzvbjSqtr7rXXrGK4w0qPxNAovnAX+ugYsBJwoGyXelbWax3YaPNwnCfz1+j4NIYWFbgCyh1Ud2uZGPQ9idtFBMGAietbqX8vwdjNGp5nEkSedKK16CtB5dPsxjWeirGUBVGSV2QSc80R7aqIeplFkn/SJD5rjNJx4PSyMY4z+R7f2z9AyYCIQuvHoa/pu6QwIIrgv00dpfotAAG/u+Br
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 02:06:32.7982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34403a34-3ca0-4103-7b24-08d797cd3620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2383
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
Cc: Long Gang <Gang.Long@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogIlRpYW5jaS5ZaW4iIDx0aWFuY2kueWluQGFtZC5jb20+Cgpbd2h5XQpJbiBkdWFsIEdQ
VXMgc2NlbmFyaW8sIHN0b2xlbl9zaXplIGlzIGFzc2lnbmVkIHRvIHplcm8gb24gdGhlIHNlY29u
ZGFyeSBHUFUsCnNpbmNlIHRoZXJlIGlzIG5vIHByZS1PUyBjb25zb2xlIHVzaW5nIHRoYXQgbWVt
b3J5LiBUaGVuIHRoZSBib3R0b20gcmVnaW9uIG9mClZSQU0gd2FzIGFsbG9jYXRlZCBhcyBHVFQs
IHVuZm9ydHVuYXRlbHkgYSBzbWFsbCByZWdpb24gb2YgYm90dG9tIFZSQU0gd2FzCmVuY3JvYWNo
ZWQgYnkgVU1DIGZpcm13YXJlIGR1cmluZyBHRERSNiBCSVNUIHRyYWluaW5nLCB0aGlzIGNhdXNl
IHBhZ2UgZmF1bHQuCgpbaG93XQpGb3JjaW5nIHN0b2xlbl9zaXplIHRvIDNNQiwgdGhlbiB0aGUg
Ym90dG9tIHJlZ2lvbiBvZiBWUkFNIHdhcwphbGxvY2F0ZWQgYXMgc3RvbGVuIG1lbW9yeSwgR1RU
IGNvcnJ1cHRpb24gYXZvaWQuCgpDaGFuZ2UtSWQ6IEkzMTBhNzJiYTA0MDI5OTRkZWZiZTUwODM5
ODQyYThlZGIwMjVhODY4ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFRpYW5jaS5ZaW4gPHRpYW5jaS55aW5AYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCAgNSAr
KysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgIHwgMjcgKysrKysr
KysrKysrKysrKysrKysrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCmluZGV4
IGM5MWRkNjAyZDVmMS4uZWRlNGEwZWEwYzg0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5oCkBAIC02MCw2ICs2MCwxMSBAQAogICovCiAjZGVmaW5lIEFNREdQVV9HTUNf
RkFVTFRfVElNRU9VVAk1MDAwVUxMCiAKKy8qCisgKiBEZWZhdWx0IHN0b2xlbiBtZW1vcnkgc2l6
ZSwgMTAyNCAqIDc2OCAqIDQKKyAqLworI2RlZmluZSBBTURHUFVfU1RPTEVOX0JJU1RfVFJBSU5J
TkdfREVGQVVMVF9TSVpFCTB4MzAwMDAwVUxMCisKIHN0cnVjdCBmaXJtd2FyZTsKIAogLyoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKaW5kZXggNWFkODliYjZmM2JhLi4wNDAx
NzA1N2Y4Y2EgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCkBAIC01NjYs
NyArNTY2LDEyIEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX2xhdGVfaW5pdCh2b2lkICpoYW5kbGUp
CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilo
YW5kbGU7CiAJaW50IHI7CiAKLQlhbWRncHVfYm9fbGF0ZV9pbml0KGFkZXYpOworCS8qCisJICog
Q2FuJ3QgZnJlZSB0aGUgc3RvbGVuIFZHQSBtZW1vcnkgd2hlbiBpdCBtaWdodCBiZSB1c2VkIGZv
ciBtZW1vcnkKKwkgKiB0cmFpbmluZyBhZ2Fpbi4KKwkgKi8KKwlpZiAoIWFkZXYtPmZ3X3ZyYW1f
dXNhZ2UubWVtX3RyYWluX3N1cHBvcnQpCisJCWFtZGdwdV9ib19sYXRlX2luaXQoYWRldik7CiAK
IAlyID0gYW1kZ3B1X2dtY19hbGxvY2F0ZV92bV9pbnZfZW5nKGFkZXYpOwogCWlmIChyKQpAQCAt
NzUwLDYgKzc1NSwxOSBAQCBzdGF0aWMgaW50IGdtY192MTBfMF9zd19pbml0KHZvaWQgKmhhbmRs
ZSkKIAogCWFkZXYtPmdtYy5zdG9sZW5fc2l6ZSA9IGdtY192MTBfMF9nZXRfdmJpb3NfZmJfc2l6
ZShhZGV2KTsKIAorCS8qCisJICogSW4gZHVhbCBHUFVzIHNjZW5hcmlvLCBzdG9sZW5fc2l6ZSBp
cyBhc3NpZ25lZCB0byB6ZXJvIG9uIHRoZQorCSAqIHNlY29uZGFyeSBHUFUsIHNpbmNlIHRoZXJl
IGlzIG5vIHByZS1PUyBjb25zb2xlIHVzaW5nIHRoYXQgbWVtb3J5LgorCSAqIFRoZW4gdGhlIGJv
dHRvbSByZWdpb24gb2YgVlJBTSB3YXMgYWxsb2NhdGVkIGFzIEdUVCwgdW5mb3J0dW5hdGVseSBh
CisJICogc21hbGwgcmVnaW9uIG9mIGJvdHRvbSBWUkFNIHdhcyBlbmNyb2FjaGVkIGJ5IFVNQyBm
aXJtd2FyZSBkdXJpbmcKKwkgKiBHRERSNiBCSVNUIHRyYWluaW5nLCB0aGlzIGNhdXNlIHBhZ2Ug
ZmF1bHQuCisJICogVGhlIHBhZ2UgZmF1bHQgY2FuIGJlIGZpeGVkIGJ5IGZvcmNpbmcgc3RvbGVu
X3NpemUgdG8gM01CLCB0aGVuIHRoZQorCSAqIGJvdHRvbSByZWdpb24gb2YgVlJBTSB3YXMgYWxs
b2NhdGVkIGFzIHN0b2xlbiBtZW1vcnksIEdUVCBjb3JydXB0aW9uCisJICogYXZvaWQuCisJICov
CisJYWRldi0+Z21jLnN0b2xlbl9zaXplID0gbWF4KGFkZXYtPmdtYy5zdG9sZW5fc2l6ZSwKKwkJ
CQkgICAgQU1ER1BVX1NUT0xFTl9CSVNUX1RSQUlOSU5HX0RFRkFVTFRfU0laRSk7CisKIAkvKiBN
ZW1vcnkgbWFuYWdlciAqLwogCXIgPSBhbWRncHVfYm9faW5pdChhZGV2KTsKIAlpZiAocikKQEAg
LTc4OSw2ICs4MDcsMTMgQEAgc3RhdGljIHZvaWQgZ21jX3YxMF8wX2dhcnRfZmluaShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKIHN0YXRpYyBpbnQgZ21jX3YxMF8wX3N3X2Zpbmkodm9pZCAq
aGFuZGxlKQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICopaGFuZGxlOworCXZvaWQgKnN0b2xlbl92Z2FfYnVmOworCisJLyoKKwkgKiBGcmVl
IHRoZSBzdG9sZW4gbWVtb3J5IGlmIGl0IHdhc24ndCBhbHJlYWR5IGZyZWVkIGluIGxhdGVfaW5p
dAorCSAqIGJlY2F1c2Ugb2YgbWVtb3J5IHRyYWluaW5nLgorCSAqLworCWFtZGdwdV9ib19mcmVl
X2tlcm5lbCgmYWRldi0+c3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsICZzdG9sZW5fdmdhX2J1Zik7
CiAKIAlhbWRncHVfdm1fbWFuYWdlcl9maW5pKGFkZXYpOwogCWdtY192MTBfMF9nYXJ0X2Zpbmko
YWRldik7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
