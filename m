Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC02C432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 04:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC192068E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 04:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC192068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C18D18916B;
	Tue,  3 Dec 2019 04:42:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3F989160
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 04:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEXgLKw1IgYU4j5GQfMbgMFiY1BrQqTj4AiaS1OQLAC+6W0G/6l+xXnJTLF8m2Rr4ti/z4DE1V6FV3/EO895P3hNTNvXz29NwPoh5tx9pF1mYzvSnyy0kH4xGfsuOLL0sIvjsBhLigBCFcNQUi7/xLq6zTU8C0WNJDw4yU/ivqdb4tGYzahVecrlH3YAhPBjrPfdk1O7On4g5MKZeDGGP+0VpyF1fq2yLvucZtLetamQ/u+yBZKeDfZiyoW6dbcMveIoFwu5neM69RHzsUN2n8Q1WTyXyhPJZewXjTqfD0Fjsc8yePWV3aOIPmlG+ukmDSMp6FjI8PMmGB2NAkWtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OKapXH41X8xeJtRlT5bH2RQMJRx3rRoPW09sR1/uic=;
 b=f6f90lMBEUiw3/Itx3IO+P2nhgA82v8cvI/a9A3suTKoOnjmfQvHC1EhojoOH1+GX/gwSfpWz+pX3pkyld3T/s9M6YGtfGHIZ0lRXDJnpqOnwoTiBVCJQ51+azIgyWB+jtFhcOpnseHjFBqjRnKSj6bKGwDK2a8ziDTqRdcoaMmyMXp2mApXISDej04dF39U4ebhPFkeeO25+523ppbS/mp4RpF4rm+lm4t7xy9BpExbTjBkWpR4qrEU4wiPoib8keanmjzyruN/H6qxNRaAZq/hO/RRjNVj+MdCl4yxGtZZMVfd2PXI36+2VtNefFAtlut+QRXOZX9362BcJ60Tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0058.namprd12.prod.outlook.com (10.174.104.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 04:42:32 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 04:42:32 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Add Arcturus specific
 set_vm_context_page_table_base()
Date: Mon,  2 Dec 2019 23:42:15 -0500
Message-Id: <20191203044215.29605-2-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203044215.29605-1-Yong.Zhao@amd.com>
References: <20191203044215.29605-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39a8f2c7-cee9-47a7-9a5b-08d777ab3551
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0058:|DM5PR1201MB0058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00583FFAC1077F0B1977A504F0420@DM5PR1201MB0058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(50226002)(8676002)(2351001)(8936002)(81156014)(81166006)(6916009)(305945005)(7736002)(14444005)(86362001)(6666004)(76176011)(386003)(6506007)(26005)(2616005)(11346002)(446003)(186003)(14454004)(52116002)(478600001)(48376002)(36756003)(6486002)(25786009)(16586007)(316002)(50466002)(99286004)(51416003)(2906002)(5660300002)(3846002)(6116002)(66946007)(66476007)(66556008)(6512007)(2361001)(6436002)(66066001)(4326008)(1076003)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0058;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZpTzVLmEG39ePaQ+G95VCNLs/a4Y7ondw4dU+jh1nRiSQ+SyK6Kh8bUNwIviW/wzPLQAFw6deq6rAQz8fjCuPmEsA3NLTZQey8BQsJIsCEnKfTKe8tEZh/lWqkDeFLWN8EfJKpdvUNSCgX8oV318+83eh8Yrfx2zakCTdr/Nkz+vHa5BUkk7Whaet1C6WM6SuT+kX9tn0zKowXK8oBrdnx4P84HBKCt2bJn4o3W8UWJL9O6ugc6rxvq16/dYiTGhFzvT7yZFtxt6eUVs2MK2S8qbakqK+MjHNNSuRp8Zm3ooGYNqVtbzLKp+gFAINL1GTDqs58BsybMUnObGjPkrX0aMPK72CiNUPBDLKHNB2Na1rOoLTAwsjuKcZy8DHDr3YN9huWLiCmazjmSjsmJ0oOLv/QKpyYOvcFfPSLjbmidmSnWMJ+Z9ixUpf1lZ48O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a8f2c7-cee9-47a7-9a5b-08d777ab3551
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 04:42:32.1674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0gXXpKdWqNYQpc3t8tXsORrzeItoFH9l2B+WNmgxoD2kbFNAENDhF/b2ocOz/+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0058
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OKapXH41X8xeJtRlT5bH2RQMJRx3rRoPW09sR1/uic=;
 b=gjZtOpj4m1Vihyh+gqQF4HwxwAQhzLOKlnFDmOJIez5fddmijNgHPSJ4c/lIS9PxAaXEW7mu3kUyZP9fCTzlB58hgwI58iCxoSLRpMlFIMV3bZw17RnfqyhqEXu20Ijx+if72AKDEPfw3ou+zo6UfVxVvM/s1UMATLEacRAJj00=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2luY2UgQXJjdHVydXMgaGFzIGl0IG93biBmdW5jdGlvbiBwb2ludGVyLCB3ZSBjYW4gbW92ZSBB
cmN0dXJ1cwpzcGVjaWZpYyBsb2dpYyB0byB0aGVyZSByYXRoZXIgdGhhbiBsZWF2aW5nIGl0IGVu
dGFuZ2xlZCB3aXRoCm90aGVyIEdGWDkgY2hpcHMuCgpDaGFuZ2UtSWQ6IEk3ZGY3YzAwNGEwYzhh
YzA2MTZkZWQwZTY1MTQ0NjcwZGY1MGY5MmE3ClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9u
Zy5aaGFvQGFtZC5jb20+Ci0tLQogLi4uL2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYXJj
dHVydXMuYyAgIHwgMjAgKysrKysrKysrKysrKysrKysrLQogLi4uL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jIHwgMTQgKysrLS0tLS0tLS0tLQogLi4uL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5oIHwgIDIgLS0KIDMgZmlsZXMgY2hhbmdl
ZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jCmluZGV4IGI2NzEzZTBl
ZDFiMi4uM2MxMTk0MDdkYzM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2FyY3R1cnVzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jCkBAIC00Niw2ICs0Niw4IEBACiAjaW5jbHVkZSAi
c29jMTUuaCIKICNpbmNsdWRlICJzb2MxNWQuaCIKICNpbmNsdWRlICJhbWRncHVfYW1ka2ZkX2dm
eF92OS5oIgorI2luY2x1ZGUgImdmeGh1Yl92MV8wLmgiCisjaW5jbHVkZSAibW1odWJfdjlfNC5o
IgogCiAjZGVmaW5lIEhRRF9OX1JFR1MgNTYKICNkZWZpbmUgRFVNUF9SRUcoYWRkcikgZG8gewkJ
CQlcCkBAIC0yNTgsNiArMjYwLDIyIEBAIHN0YXRpYyBpbnQga2dkX2hxZF9zZG1hX2Rlc3Ryb3ko
c3RydWN0IGtnZF9kZXYgKmtnZCwgdm9pZCAqbXFkLAogCXJldHVybiAwOwogfQogCitzdGF0aWMg
dm9pZCBrZ2Rfc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJsZV9iYXNlKHN0cnVjdCBrZ2RfZGV2ICpr
Z2QsIHVpbnQzMl90IHZtaWQsCisJCXVpbnQ2NF90IHBhZ2VfdGFibGVfYmFzZSkKK3sKKwlzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGdldF9hbWRncHVfZGV2aWNlKGtnZCk7CisKKwlpZiAo
IWFtZGdwdV9hbWRrZmRfaXNfa2ZkX3ZtaWQoYWRldiwgdm1pZCkpIHsKKwkJcHJfZXJyKCJ0cnlp
bmcgdG8gc2V0IHBhZ2UgdGFibGUgYmFzZSBmb3Igd3JvbmcgVk1JRCAldVxuIiwKKwkJICAgICAg
IHZtaWQpOworCQlyZXR1cm47CisJfQorCisJbW1odWJfdjlfNF9zZXR1cF92bV9wdF9yZWdzKGFk
ZXYsIHZtaWQsIHBhZ2VfdGFibGVfYmFzZSk7CisKKwlnZnhodWJfdjFfMF9zZXR1cF92bV9wdF9y
ZWdzKGFkZXYsIHZtaWQsIHBhZ2VfdGFibGVfYmFzZSk7Cit9CisKIGNvbnN0IHN0cnVjdCBrZmQy
a2dkX2NhbGxzIGFyY3R1cnVzX2tmZDJrZ2QgPSB7CiAJLnByb2dyYW1fc2hfbWVtX3NldHRpbmdz
ID0ga2dkX2dmeF92OV9wcm9ncmFtX3NoX21lbV9zZXR0aW5ncywKIAkuc2V0X3Bhc2lkX3ZtaWRf
bWFwcGluZyA9IGtnZF9nZnhfdjlfc2V0X3Bhc2lkX3ZtaWRfbWFwcGluZywKQEAgLTI3Nyw3ICsy
OTUsNyBAQCBjb25zdCBzdHJ1Y3Qga2ZkMmtnZF9jYWxscyBhcmN0dXJ1c19rZmQya2dkID0gewog
CS5nZXRfYXRjX3ZtaWRfcGFzaWRfbWFwcGluZ19pbmZvID0KIAkJCWtnZF9nZnhfdjlfZ2V0X2F0
Y192bWlkX3Bhc2lkX21hcHBpbmdfaW5mbywKIAkuZ2V0X3RpbGVfY29uZmlnID0ga2dkX2dmeF92
OV9nZXRfdGlsZV9jb25maWcsCi0JLnNldF92bV9jb250ZXh0X3BhZ2VfdGFibGVfYmFzZSA9IGtn
ZF9nZnhfdjlfc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJsZV9iYXNlLAorCS5zZXRfdm1fY29udGV4
dF9wYWdlX3RhYmxlX2Jhc2UgPSBrZ2Rfc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJsZV9iYXNlLAog
CS5pbnZhbGlkYXRlX3RsYnMgPSBrZ2RfZ2Z4X3Y5X2ludmFsaWRhdGVfdGxicywKIAkuaW52YWxp
ZGF0ZV90bGJzX3ZtaWQgPSBrZ2RfZ2Z4X3Y5X2ludmFsaWRhdGVfdGxic192bWlkLAogCS5nZXRf
aGl2ZV9pZCA9IGFtZGdwdV9hbWRrZmRfZ2V0X2hpdmVfaWQsCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYwppbmRleCA2ZjFhNDY3NmRkZGUu
LmU3ODYxZjBlZjQxNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9nZnhfdjkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkX2dmeF92OS5jCkBAIC00MCw3ICs0MCw2IEBACiAjaW5jbHVkZSAic29jMTVkLmgi
CiAjaW5jbHVkZSAibW1odWJfdjFfMC5oIgogI2luY2x1ZGUgImdmeGh1Yl92MV8wLmgiCi0jaW5j
bHVkZSAibW1odWJfdjlfNC5oIgogCiAKIGVudW0gaHFkX2RlcXVldWVfcmVxdWVzdF90eXBlIHsK
QEAgLTc1OCw4ICs3NTcsOCBAQCB1aW50MzJfdCBrZ2RfZ2Z4X3Y5X2FkZHJlc3Nfd2F0Y2hfZ2V0
X29mZnNldChzdHJ1Y3Qga2dkX2RldiAqa2dkLAogCXJldHVybiAwOwogfQogCi12b2lkIGtnZF9n
Znhfdjlfc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJsZV9iYXNlKHN0cnVjdCBrZ2RfZGV2ICprZ2Qs
IHVpbnQzMl90IHZtaWQsCi0JCXVpbnQ2NF90IHBhZ2VfdGFibGVfYmFzZSkKK3N0YXRpYyB2b2lk
IGtnZF9nZnhfdjlfc2V0X3ZtX2NvbnRleHRfcGFnZV90YWJsZV9iYXNlKHN0cnVjdCBrZ2RfZGV2
ICprZ2QsCisJCQl1aW50MzJfdCB2bWlkLCB1aW50NjRfdCBwYWdlX3RhYmxlX2Jhc2UpCiB7CiAJ
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBnZXRfYW1kZ3B1X2RldmljZShrZ2QpOwogCkBA
IC03NjksMTQgKzc2OCw3IEBAIHZvaWQga2dkX2dmeF92OV9zZXRfdm1fY29udGV4dF9wYWdlX3Rh
YmxlX2Jhc2Uoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDMyX3Qgdm1pCiAJCXJldHVybjsKIAl9
CiAKLQkvKiBUT0RPOiB0YWtlIGFkdmFudGFnZSBvZiBwZXItcHJvY2VzcyBhZGRyZXNzIHNwYWNl
IHNpemUuIEZvcgotCSAqIG5vdywgYWxsIHByb2Nlc3NlcyBzaGFyZSB0aGUgc2FtZSBhZGRyZXNz
IHNwYWNlIHNpemUsIGxpa2UKLQkgKiBvbiBHRlg4IGFuZCBvbGRlci4KLQkgKi8KLQlpZiAoYWRl
di0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMpIHsKLQkJbW1odWJfdjlfNF9zZXR1cF92bV9w
dF9yZWdzKGFkZXYsIHZtaWQsIHBhZ2VfdGFibGVfYmFzZSk7Ci0JfSBlbHNlCi0JCW1taHViX3Yx
XzBfc2V0dXBfdm1fcHRfcmVncyhhZGV2LCB2bWlkLCBwYWdlX3RhYmxlX2Jhc2UpOworCW1taHVi
X3YxXzBfc2V0dXBfdm1fcHRfcmVncyhhZGV2LCB2bWlkLCBwYWdlX3RhYmxlX2Jhc2UpOwogCiAJ
Z2Z4aHViX3YxXzBfc2V0dXBfdm1fcHRfcmVncyhhZGV2LCB2bWlkLCBwYWdlX3RhYmxlX2Jhc2Up
OwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9nZnhfdjkuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4
X3Y5LmgKaW5kZXggZDllOWFkMjJiMmJkLi4wMmIxNDI2ZDE3ZDEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuaApAQCAtNTcsOCArNTcs
NiBAQCB1aW50MzJfdCBrZ2RfZ2Z4X3Y5X2FkZHJlc3Nfd2F0Y2hfZ2V0X29mZnNldChzdHJ1Y3Qg
a2dkX2RldiAqa2dkLAogCiBib29sIGtnZF9nZnhfdjlfZ2V0X2F0Y192bWlkX3Bhc2lkX21hcHBp
bmdfaW5mbyhzdHJ1Y3Qga2dkX2RldiAqa2dkLAogCQkJCQl1aW50OF90IHZtaWQsIHVpbnQxNl90
ICpwX3Bhc2lkKTsKLXZvaWQga2dkX2dmeF92OV9zZXRfdm1fY29udGV4dF9wYWdlX3RhYmxlX2Jh
c2Uoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWludDMyX3Qgdm1pZCwKLQkJdWludDY0X3QgcGFnZV90
YWJsZV9iYXNlKTsKIGludCBrZ2RfZ2Z4X3Y5X2ludmFsaWRhdGVfdGxicyhzdHJ1Y3Qga2dkX2Rl
diAqa2dkLCB1aW50MTZfdCBwYXNpZCk7CiBpbnQga2dkX2dmeF92OV9pbnZhbGlkYXRlX3RsYnNf
dm1pZChzdHJ1Y3Qga2dkX2RldiAqa2dkLCB1aW50MTZfdCB2bWlkKTsKIGludCBrZ2RfZ2Z4X3Y5
X2dldF90aWxlX2NvbmZpZyhzdHJ1Y3Qga2dkX2RldiAqa2dkLAotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
