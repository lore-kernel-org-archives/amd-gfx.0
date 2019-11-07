Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF56C5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 10:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A522084D
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 10:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A522084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4AC6F650;
	Thu,  7 Nov 2019 10:25:58 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720045.outbound.protection.outlook.com [40.107.72.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A71126F5A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 10:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciLA5INwjfLhR3ywl6o1g8T/4/WTMmaTq8KLMDkJNI9Z82Cgxl//GTd7rnObUaQvTvNNnmn1s7m4h8zuXwNfvoEYUJIM+7nnW+0KJdKLHaxhTkLGg5UNLkt64lEypw8ejAAgy5EtfyWQoGK0AI4vAfYTSHJpTYo9f6HjrswtdJFy6mvYI/UMjhb/ncqPaMtXT3KSb67UCTzsLC5/YEf1FwA71WXD7G+EyP3l67igy+S1lhie8UoRgu1FhUNM3owRgXiyHTE0KsWqltUDplP3ZlhwzC2exyoI5uwNKSfP29/L5c4r38Jun2KJ0MoNlFxboYmQX9vRYNzG0L/biToa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhjDJChgwdeTB9021aSv+rT07iVXSchhktbf7yOKVd0=;
 b=g6H7AXSYDWkKKL+1VovsRr5jxLYBZWMUAjjV8VYWmKhe605UZ7mPtUsLlCnOgm5oudIPxlYDrmom6YlehKRXHQt43GwfvEhqk4BlFriN4TLJ/Vd3sY8Px8k6fPpvx6CZGBHuzIHhHKgW+8MONtqDFjgXxCXir013G4cWkAPS0jI+rdtGdXo6l/D49Py+5bymy5ZEHdWdRexGJzGvFb6YCz4wqQh8LgtwGMYw6WhyhyKjbMYw2QOFiEMzCaJe70sh4PFolA0AqwmdttQOISZygXoW0AItUi0RF1NqZbwuzeMTp1oJzocw+8pIPbqTCn4xDPPnviVtOh2Z0Oue5vCrKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:405:4c::22) by CY4PR12MB1320.namprd12.prod.outlook.com
 (2603:10b6:903:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Thu, 7 Nov
 2019 10:25:54 +0000
Received: from CO1NAM03FT020.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by BN6PR1201CA0012.outlook.office365.com
 (2603:10b6:405:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 10:25:54 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT020.mail.protection.outlook.com (10.152.80.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 10:25:53 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 04:25:52 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 04:25:51 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Date: Thu, 7 Nov 2019 18:25:49 +0800
Message-ID: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(428003)(199004)(189003)(70586007)(4326008)(305945005)(2906002)(70206006)(47776003)(186003)(48376002)(476003)(6916009)(126002)(86362001)(486006)(14444005)(2351001)(2616005)(426003)(336012)(5660300002)(50466002)(50226002)(53416004)(8676002)(356004)(81166006)(51416003)(36756003)(316002)(16586007)(26005)(8936002)(7696005)(81156014)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1320; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9c0bedf-bdcd-4af2-64d7-08d7636cde91
X-MS-TrafficTypeDiagnostic: CY4PR12MB1320:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1320B30B256E8F5C1E4E45E28F780@CY4PR12MB1320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLVQ/6WyJJstIi1jtl7Uw3A6Qov7pfFR+t3X8pZ7BeaXXG9Qb0t2ovyhG2xbnaNkaWIR6iLPQoQQY0al6NNQSvTefvQcKQ9YpFEuEVXUzyU8TFa3iEX5GNWbNUmWLC7j6obgAc+oGZL1JM8+DZT4pY76Xth4AkPlAF7XClJd4RUbQAtx0d/lcHOtPbuGa8T30lIujAyy+Ad3BHQQjrHU09cvgdOQsIvu2yw9o+OaDrhKCiBErgfAvyaj/fKb4bMwSh9Yg1SFi4iMW82WNa73LdD70TO5lveArBWh7OiMXnZugReFPcozEjGjxgdhVmNxEpdPJp4op9bjusIiRAADYikBrlAQp5z+xsSuzLyY4LexcwNexeVuSzdebzW0gJQAKPTfW7kNla+sW7HDsbZ9Bt1SR4Vri8lFAp/9viCeRO6IP0P/Mgc78y+zrk+ZYoHg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 10:25:53.6341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c0bedf-bdcd-4af2-64d7-08d7636cde91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1320
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhjDJChgwdeTB9021aSv+rT07iVXSchhktbf7yOKVd0=;
 b=03tvAfzVTPecFX2jsUJI4q73+LLGzqffzEm9kvPCp35SQsoLb5iAOOFwqgXUVqAv8cDU3YnudI2RdvUErHzKB0EKrXhuu5JnypO+qB46oC41riFCI77hnpe2QpDrMz2Nyg6je5qLwe4r5VIFIo5OC9DWntTbuurXscMuN8dWdqk=
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107102549.90R5r_VJH2hFOEBpoPRa48htD5V3oUiFZi3a1_0JnxM@z>

V2hlbiB0aGUgam9iIGlzIGFscmVhZHkgc2lnbmFsZWQsIHRoZSBzX2ZlbmNlIGlzIGZyZWVkLiBU
aGVuIGl0IHdpbGwgaGFzCm51bGwgcG9pbnRlciBpbiBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVy
LgoKU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8ICAyICstCiBkcml2ZXJz
L2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyAgICAgfCAxMSArKysrKystLS0tLQogMiBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGU2Y2U5NDkuLjVhOGYwOGUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTQwNzUs
NyArNDA3NSw3IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAogCSAqCiAJICogam9iLT5iYXNlIGhvbGRzIGEgcmVmZXJlbmNlIHRvIHBh
cmVudCBmZW5jZQogCSAqLwotCWlmIChqb2IgJiYgam9iLT5iYXNlLnNfZmVuY2UtPnBhcmVudCAm
JgorCWlmIChqb2IgJiYgam9iLT5iYXNlLnNfZmVuY2UgJiYgam9iLT5iYXNlLnNfZmVuY2UtPnBh
cmVudCAmJgogCSAgICBkbWFfZmVuY2VfaXNfc2lnbmFsZWQoam9iLT5iYXNlLnNfZmVuY2UtPnBh
cmVudCkpCiAJCWpvYl9zaWduYWxlZCA9IHRydWU7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9tYWluLmMKaW5kZXggMzE4MDljYS4uNTZjYzEwZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9tYWluLmMKQEAgLTMzNCw4ICszMzQsOCBAQCB2b2lkIGRybV9zY2hlZF9pbmNy
ZWFzZV9rYXJtYShzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKQogCiAJCQlzcGluX2xvY2soJnJx
LT5sb2NrKTsKIAkJCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbnRpdHksIHRtcCwgJnJxLT5l
bnRpdGllcywgbGlzdCkgewotCQkJCWlmIChiYWQtPnNfZmVuY2UtPnNjaGVkdWxlZC5jb250ZXh0
ID09Ci0JCQkJICAgIGVudGl0eS0+ZmVuY2VfY29udGV4dCkgeworCQkJCWlmIChiYWQtPnNfZmVu
Y2UgJiYgKGJhZC0+c19mZW5jZS0+c2NoZWR1bGVkLmNvbnRleHQgPT0KKwkJCQkgICAgZW50aXR5
LT5mZW5jZV9jb250ZXh0KSkgewogCQkJCQlpZiAoYXRvbWljX3JlYWQoJmJhZC0+a2FybWEpID4K
IAkJCQkJICAgIGJhZC0+c2NoZWQtPmhhbmdfbGltaXQpCiAJCQkJCQlpZiAoZW50aXR5LT5ndWls
dHkpCkBAIC0zNzYsNyArMzc2LDcgQEAgdm9pZCBkcm1fc2NoZWRfc3RvcChzdHJ1Y3QgZHJtX2dw
dV9zY2hlZHVsZXIgKnNjaGVkLCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKQogCSAqIFRoaXMg
aXRlcmF0aW9uIGlzIHRocmVhZCBzYWZlIGFzIHNjaGVkIHRocmVhZCBpcyBzdG9wcGVkLgogCSAq
LwogCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZV9yZXZlcnNlKHNfam9iLCB0bXAsICZzY2hlZC0+
cmluZ19taXJyb3JfbGlzdCwgbm9kZSkgewotCQlpZiAoc19qb2ItPnNfZmVuY2UtPnBhcmVudCAm
JgorCQlpZiAoc19qb2ItPnNfZmVuY2UgJiYgc19qb2ItPnNfZmVuY2UtPnBhcmVudCAmJgogCQkg
ICAgZG1hX2ZlbmNlX3JlbW92ZV9jYWxsYmFjayhzX2pvYi0+c19mZW5jZS0+cGFyZW50LAogCQkJ
CQkgICAgICAmc19qb2ItPmNiKSkgewogCQkJYXRvbWljX2RlYygmc2NoZWQtPmh3X3JxX2NvdW50
KTsKQEAgLTM5NSw3ICszOTUsOCBAQCB2b2lkIGRybV9zY2hlZF9zdG9wKHN0cnVjdCBkcm1fZ3B1
X3NjaGVkdWxlciAqc2NoZWQsIHN0cnVjdCBkcm1fc2NoZWRfam9iICpiYWQpCiAJCQkgKgogCQkJ
ICogSm9iIGlzIHN0aWxsIGFsaXZlIHNvIGZlbmNlIHJlZmNvdW50IGF0IGxlYXN0IDEKIAkJCSAq
LwotCQkJZG1hX2ZlbmNlX3dhaXQoJnNfam9iLT5zX2ZlbmNlLT5maW5pc2hlZCwgZmFsc2UpOwor
CQkJaWYgKHNfam9iLT5zX2ZlbmNlKQorCQkJCWRtYV9mZW5jZV93YWl0KCZzX2pvYi0+c19mZW5j
ZS0+ZmluaXNoZWQsIGZhbHNlKTsKIAogCQkJLyoKIAkJCSAqIFdlIG11c3Qga2VlcCBiYWQgam9i
IGFsaXZlIGZvciBsYXRlciB1c2UgZHVyaW5nCkBAIC00MzgsNyArNDM5LDcgQEAgdm9pZCBkcm1f
c2NoZWRfc3RhcnQoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwgYm9vbCBmdWxsX3Jl
Y292ZXJ5KQogCSAqIEdQVSByZWNvdmVycyBjYW4ndCBydW4gaW4gcGFyYWxsZWwuCiAJICovCiAJ
bGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHNfam9iLCB0bXAsICZzY2hlZC0+cmluZ19taXJyb3Jf
bGlzdCwgbm9kZSkgewotCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IHNfam9iLT5zX2ZlbmNl
LT5wYXJlbnQ7CisJCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gc19qb2ItPnNfZmVuY2UgPyBz
X2pvYi0+c19mZW5jZS0+cGFyZW50IDogTlVMTDsKIAogCQlhdG9taWNfaW5jKCZzY2hlZC0+aHdf
cnFfY291bnQpOwogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
