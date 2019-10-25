Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E69CA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 20:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3A42084C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 20:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3A42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32FA6EB40;
	Fri, 25 Oct 2019 20:44:24 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9666EB40
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2019 20:40:57 +0000 (UTC)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9PKbUmD186123; Fri, 25 Oct 2019 16:40:55 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vv4knf1fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2019 16:40:55 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9PKeGar023843;
 Fri, 25 Oct 2019 20:40:54 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02dal.us.ibm.com with ESMTP id 2vqt48kme7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2019 20:40:54 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9PKernt54002120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2019 20:40:53 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 747C26E04E;
 Fri, 25 Oct 2019 20:40:53 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2523E6E04C;
 Fri, 25 Oct 2019 20:40:53 +0000 (GMT)
Received: from oc6220003374.ibm.com (unknown [9.40.45.99])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Oct 2019 20:40:52 +0000 (GMT)
From: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
To: alexander.deucher@amd.com
Subject: [PATCH v3] drm/radeon: Fix EEH during kexec
Date: Fri, 25 Oct 2019 15:40:50 -0500
Message-Id: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-25_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=692 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250189
X-Mailman-Approved-At: Fri, 25 Oct 2019 20:44:24 +0000
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
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025204050.YhBcpb6IREYAAP_FUtPFzNBEz0ZoAmch7Qlx5jxFZIE@z>

RnJvbTogS3lsZSBNYWhsa3VjaCA8a21haGxrdWNAbGludXgudm5ldC5pYm0uY29tPgoKRHVyaW5n
IGtleGVjIHNvbWUgYWRhcHRlcnMgaGl0IGFuIEVFSCBzaW5jZSB0aGV5IGFyZSBub3QgcHJvcGVy
bHkKc2h1dCBkb3duIGluIHRoZSByYWRlb25fcGNpX3NodXRkb3duKCkgZnVuY3Rpb24uIEFkZGlu
ZwpyYWRlb25fc3VzcGVuZF9rbXMoKSBmaXhlcyB0aGlzIGlzc3VlLgpFbmFibGVkIG9ubHkgb24g
UFBDIGJlY2F1c2UgdGhpcyBwYXRjaCBjYXVzZXMgaXNzdWVzIG9uIHNvbWUgb3RoZXIKYm9hcmRz
LgoKU2lnbmVkLW9mZi1ieTogS3lsZSBNYWhsa3VjaCA8a21haGxrdWNAbGludXgudm5ldC5pYm0u
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIHwgMTQgKysrKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9kcnYuYwppbmRleCA5ZTU1MDc2Li40NTI4ZjRkIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl9kcnYuYwpAQCAtMzc5LDExICszNzksMjUgQEAgc3RhdGljIGludCByYWRlb25f
cGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAogc3RhdGljIHZvaWQKIHJhZGVvbl9wY2lf
c2h1dGRvd24oc3RydWN0IHBjaV9kZXYgKnBkZXYpCiB7CisjaWZkZWYgQ09ORklHX1BQQzY0CisJ
c3RydWN0IGRybV9kZXZpY2UgKmRkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7CisjZW5kaWYK
KwogCS8qIGlmIHdlIGFyZSBydW5uaW5nIGluIGEgVk0sIG1ha2Ugc3VyZSB0aGUgZGV2aWNlCiAJ
ICogdG9ybiBkb3duIHByb3Blcmx5IG9uIHJlYm9vdC9zaHV0ZG93bgogCSAqLwogCWlmIChyYWRl
b25fZGV2aWNlX2lzX3ZpcnR1YWwoKSkKIAkJcmFkZW9uX3BjaV9yZW1vdmUocGRldik7CisKKyNp
ZmRlZiBDT05GSUdfUFBDNjQKKwkvKiBTb21lIGFkYXB0ZXJzIG5lZWQgdG8gYmUgc3VzcGVuZGVk
IGJlZm9yZSBhCisJICogc2h1dGRvd24gb2NjdXJzIGluIG9yZGVyIHRvIHByZXZlbnQgYW4gZXJy
b3IKKwkgKiBkdXJpbmcga2V4ZWMuCisJICogTWFrZSB0aGlzIHBvd2VyIHNwZWNpZmljIGJlY2F1
YXNlIGl0IGJyZWFrcworCSAqIHNvbWUgbm9uLXBvd2VyIGJvYXJkcy4KKwkgKi8KKwlyYWRlb25f
c3VzcGVuZF9rbXMoZGRldiwgdHJ1ZSwgdHJ1ZSwgZmFsc2UpOworI2VuZGlmCiB9CiAKIHN0YXRp
YyBpbnQgcmFkZW9uX3Btb3BzX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQotLSAKMS44LjMu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
