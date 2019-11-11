Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC6CC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA4420659
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA4420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215A76E2C8;
	Mon, 11 Nov 2019 20:29:08 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0306E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 20:29:07 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xABKQcU1103004; Mon, 11 Nov 2019 15:29:04 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w7c1tdqqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2019 15:29:04 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xABKRhRf006405;
 Mon, 11 Nov 2019 20:29:03 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03dal.us.ibm.com with ESMTP id 2w5n366mu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2019 20:29:03 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xABKT2NN50856302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Nov 2019 20:29:03 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4C6D6E04E;
 Mon, 11 Nov 2019 20:29:02 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D6206E052;
 Mon, 11 Nov 2019 20:29:02 +0000 (GMT)
Received: from oc6220003374.ibm.com (unknown [9.40.45.99])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 11 Nov 2019 20:29:02 +0000 (GMT)
From: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
To: 
Subject: [PATCH] drm/radeon: Clean up code in radeon_pci_shutdown()
Date: Mon, 11 Nov 2019 14:27:58 -0600
Message-Id: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-11_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=750 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110178
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
Cc: David1.Zhou@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111202758.QpA_1-VLeMM7ADek5wjq06-DcS-TXKBMe3_F1RRYFNs@z>

RnJvbTogS3lsZU1haGxrdWNoIDxrbWFobGt1Y0BsaW51eC52bmV0LmlibS5jb20+CgpUaGlzIGZp
eGVzIHRoZSBmb3JtYXR0aW5nIG9uIG9uZSBjb21tZW50IGFuZCBjb25zb2xpZGF0ZXMgdGhlCnBj
aV9nZXRfZHJ2ZGF0YSgpIGludG8gdGhlIHJhZGVvbl9zdXNwZW5kX2ttcygpLgoKU2lnbmVkLW9m
Zi1ieTogS3lsZSBNYWhsa3VjaCA8a21haGxrdWNAbGludXgudm5ldC5pYm0uY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIHwgOSArKystLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kcnYuYwppbmRleCA0NTI4ZjRkLi4zNTdkMjlhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kcnYuYwpAQCAtMzc5LDEwICszNzksNiBAQCBzdGF0aWMgaW50IHJhZGVvbl9wY2lf
cHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCiBzdGF0aWMgdm9pZAogcmFkZW9uX3BjaV9zaHV0
ZG93bihzdHJ1Y3QgcGNpX2RldiAqcGRldikKIHsKLSNpZmRlZiBDT05GSUdfUFBDNjQKLQlzdHJ1
Y3QgZHJtX2RldmljZSAqZGRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKLSNlbmRpZgotCiAJ
LyogaWYgd2UgYXJlIHJ1bm5pbmcgaW4gYSBWTSwgbWFrZSBzdXJlIHRoZSBkZXZpY2UKIAkgKiB0
b3JuIGRvd24gcHJvcGVybHkgb24gcmVib290L3NodXRkb3duCiAJICovCkBAIC0zOTAsMTMgKzM4
NiwxNCBAQCBzdGF0aWMgaW50IHJhZGVvbl9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYs
CiAJCXJhZGVvbl9wY2lfcmVtb3ZlKHBkZXYpOwogCiAjaWZkZWYgQ09ORklHX1BQQzY0Ci0JLyog
U29tZSBhZGFwdGVycyBuZWVkIHRvIGJlIHN1c3BlbmRlZCBiZWZvcmUgYQorCS8qCisJICogU29t
ZSBhZGFwdGVycyBuZWVkIHRvIGJlIHN1c3BlbmRlZCBiZWZvcmUgYQogCSAqIHNodXRkb3duIG9j
Y3VycyBpbiBvcmRlciB0byBwcmV2ZW50IGFuIGVycm9yCiAJICogZHVyaW5nIGtleGVjLgogCSAq
IE1ha2UgdGhpcyBwb3dlciBzcGVjaWZpYyBiZWNhdWFzZSBpdCBicmVha3MKIAkgKiBzb21lIG5v
bi1wb3dlciBib2FyZHMuCiAJICovCi0JcmFkZW9uX3N1c3BlbmRfa21zKGRkZXYsIHRydWUsIHRy
dWUsIGZhbHNlKTsKKwlyYWRlb25fc3VzcGVuZF9rbXMocGNpX2dldF9kcnZkYXRhKHBkZXYpLCB0
cnVlLCB0cnVlLCBmYWxzZSk7CiAjZW5kaWYKIH0KIAotLSAKMS44LjMuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
