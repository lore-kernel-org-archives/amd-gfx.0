Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA736C432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 15:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990C620675
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 15:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990C620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CE789BF5;
	Tue,  3 Dec 2019 15:02:49 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690082.outbound.protection.outlook.com [40.107.69.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E74889BF5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 15:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHCFMI1Y1XFM67kzUBRJT6nkDCPvum8aM8Q8rtl1ckZ+Ezf6/y9rh71DCLNi/O13UeMu+67DmVv0lZeuaKIJM55sfE0PbkfquMXj3QofcWI7wsE7le22LqSYLvHGXOVZ2YjjGEm+YEhIASPoPZQOCwpr43XcxrFQ6fgGHeeYqyBmI1IPBHvWErg+j/OIkPIA6EPlE4L3ogQrYusjtvV94+ZrxQSx6iMQR5Q+RyvucnKimCPKiQ62fO9lomeSu35SmxgwnJdMlamgRGdUDFGHmnwuSCy73GyAib7UMsyHwcKouFiih23qdj3/KCEnfuL/blC3o0PBvP8ZX1L6kXST9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCndDQEVvbd/V5RsDXbBFhfqq1d7UpEoktZcShdtUFY=;
 b=NxSW84Kfw/X3cMHjBFvzUpNK+oPwAMSLqQDwxcEDonE0BuBa7c/JajuTtSZJ0r83zkUL6d2J6P83Gjt2HcaLtEsIioYe/VYssieTSn+Ecu3ZnHI3gn3TRozDlUTJspJpFk0PM1AVH46LWw54adb2YbUjZX8XMqCHEP17ohBwioiFA1pYziX0JsIEsmHULkGrgFOVPXOBcbK0VCnZ9aBCHWgUgAftktqIWkwQz3W3mAJwmJkvkkd49CEf7EMWoMLJoc23xfwn5J1juSeLs24g9Z9mpaGEXM95rPY7F7HbhgLwuxWtjiqx3EkbJ8ekppoKRF28C35IkRRjPUjWAxmQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0057.namprd12.prod.outlook.com (10.174.109.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 15:02:45 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 15:02:45 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Contain MMHUB number in
 mmhub_v9_4_setup_vm_pt_regs()
Date: Tue,  3 Dec 2019 10:02:33 -0500
Message-Id: <20191203150233.10228-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d2ee8e4-7851-48fa-a7e2-08d77801daa6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0057:|DM5PR1201MB0057:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0057055672FD9714C0EA772AF0420@DM5PR1201MB0057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(36756003)(1076003)(4326008)(8936002)(81166006)(6512007)(6436002)(16586007)(48376002)(2351001)(186003)(26005)(99286004)(2616005)(498600001)(6506007)(386003)(25786009)(50466002)(52116002)(66556008)(2361001)(3846002)(305945005)(81156014)(8676002)(6486002)(66946007)(51416003)(6666004)(66476007)(50226002)(6116002)(5660300002)(14454004)(2906002)(7736002)(86362001)(14444005)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0057;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: px0WQhiGkK5DBx1KR7UiA+4S11JYTN6VP0hawtfZRcStmsE5iv8rJ9mv6AunV5+8TI/wM1eSRl2YjSjuv+fAvAN3t3G+IX9tPzwe1NtmVGu5CCpub+TqUy/QKgLEB8842oTny8TScJN0p1jiVgwxzHXMv/M45fiNsAcAidqmfgcYvKeBGuMtfo1+yR0IpBlx1ghJS6HEfNhBeHWCpGK8esl9xxjITNH5YdKJHX+3wadbP+OcIXQ6nm8oVe7wwRnP+M8iO5OkkAi3/QFvoiVmQ3AME4hIvC8u2PPzWunf8gVlGGALmhA/j8lNInnFzMhdEUOVut+ZIuqAFb0uKYEeMC8XTVYTPGg1NRgT83Gsz4mucjZtnGWObiw/aPKLG6JyL28qEz1Lhab1586PmWvY7MagfKzHUToppMF2jTsTeKJUIFFvQm5Cgp8YyrMPiSSI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2ee8e4-7851-48fa-a7e2-08d77801daa6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 15:02:45.7798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkhC0hb5IJ/lO4Pb/JVgDIeLfUA9LGkpvuXCOICRlHiH5lVx7ClfNxxG5Nt7F0fM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0057
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCndDQEVvbd/V5RsDXbBFhfqq1d7UpEoktZcShdtUFY=;
 b=vQepHu0MTuwMfrhP3i2eQBysv/aAAmEskPWPAgBG0zCluFMYXOwVCN4QxEa6Rb2p4WCsx4w/GtetDBovEvMt5BcSk5j5ie5SuOJtjBZ1+9reupEtFUF+stVkX4RMTVy5GgZKZa0fa7KRn05X2EXv330efMskA0El862MTPqc0TA=
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

QWRqdXN0IHRoZSBleHBvc2VkIGZ1bmN0aW9uIHByb3RvdHlwZSBzbyB0aGF0IHRoZSBjYWxsZXIg
ZG9lcyBub3QgbmVlZAp0byBrbm93IHRoZSBNTUhVQiBudW1iZXIuCgpDaGFuZ2UtSWQ6IEk0NDIw
ZDE3MTU5ODRmNzAzOTU0ZjA3NDY4MmIwNzVmYzU5ZTJhMzMwClNpZ25lZC1vZmYtYnk6IFlvbmcg
WmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9nZnhfdjkuYyB8ICA2ICsrLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y5XzAuaCAgICAgICAgICAgICB8ICA4IC0tLS0tLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgICAgICAgICAgIHwgMTQgKysrKysrKysrKysrLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuaCAgICAgICAgICAgfCAgMiAr
KwogNCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92
OS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYwpp
bmRleCA0N2M4NTNlZjEwNTEuLjZmMWE0Njc2ZGRkZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jCkBAIC00MCw3ICs0MCw3IEBACiAj
aW5jbHVkZSAic29jMTVkLmgiCiAjaW5jbHVkZSAibW1odWJfdjFfMC5oIgogI2luY2x1ZGUgImdm
eGh1Yl92MV8wLmgiCi0jaW5jbHVkZSAiZ21jX3Y5XzAuaCIKKyNpbmNsdWRlICJtbWh1Yl92OV80
LmgiCiAKIAogZW51bSBocWRfZGVxdWV1ZV9yZXF1ZXN0X3R5cGUgewpAQCAtNzc0LDkgKzc3NCw3
IEBAIHZvaWQga2dkX2dmeF92OV9zZXRfdm1fY29udGV4dF9wYWdlX3RhYmxlX2Jhc2Uoc3RydWN0
IGtnZF9kZXYgKmtnZCwgdWludDMyX3Qgdm1pCiAJICogb24gR0ZYOCBhbmQgb2xkZXIuCiAJICov
CiAJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTKSB7Ci0JCS8qIFR3byBNTUhV
QnMgKi8KLQkJbW1odWJfdjlfNF9zZXR1cF92bV9wdF9yZWdzKGFkZXYsIDAsIHZtaWQsIHBhZ2Vf
dGFibGVfYmFzZSk7Ci0JCW1taHViX3Y5XzRfc2V0dXBfdm1fcHRfcmVncyhhZGV2LCAxLCB2bWlk
LCBwYWdlX3RhYmxlX2Jhc2UpOworCQltbWh1Yl92OV80X3NldHVwX3ZtX3B0X3JlZ3MoYWRldiwg
dm1pZCwgcGFnZV90YWJsZV9iYXNlKTsKIAl9IGVsc2UKIAkJbW1odWJfdjFfMF9zZXR1cF92bV9w
dF9yZWdzKGFkZXYsIHZtaWQsIHBhZ2VfdGFibGVfYmFzZSk7CiAKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5oCmluZGV4IDk3MWMwODQwMzU4Zi4uNDllOGJlNzYxMjE0IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmgKQEAgLTM2LDEyICszNiw0IEBACiAKIGV4dGVy
biBjb25zdCBzdHJ1Y3QgYW1kX2lwX2Z1bmNzIGdtY192OV8wX2lwX2Z1bmNzOwogZXh0ZXJuIGNv
bnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBnbWNfdjlfMF9pcF9ibG9jazsKLQot
LyogYW1kZ3B1X2FtZGtmZCouYyAqLwotdm9pZCBnZnhodWJfdjFfMF9zZXR1cF92bV9wdF9yZWdz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAotCQkJCXVpbnQ2NF90
IHZhbHVlKTsKLXZvaWQgbW1odWJfdjFfMF9zZXR1cF92bV9wdF9yZWdzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAotCQkJCXVpbnQ2NF90IHZhbHVlKTsKLXZvaWQg
bW1odWJfdjlfNF9zZXR1cF92bV9wdF9yZWdzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBp
bnQgaHViaWQsCi0JCQkJdWludDMyX3Qgdm1pZCwgdWludDY0X3QgdmFsdWUpOwogI2VuZGlmCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMKaW5kZXggODU5OWJmZGI5YTllLi5k
OTMwMWU4MDUyMmEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHVi
X3Y5XzQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMKQEAg
LTU0LDcgKzU0LDcgQEAgdTY0IG1taHViX3Y5XzRfZ2V0X2ZiX2xvY2F0aW9uKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCXJldHVybiBiYXNlOwogfQogCi12b2lkIG1taHViX3Y5XzRfc2V0
dXBfdm1fcHRfcmVncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IGh1YmlkLAorc3Rh
dGljIHZvaWQgbW1odWJfdjlfNF9zZXR1cF9odWJpZF92bV9wdF9yZWdzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCBpbnQgaHViaWQsCiAJCQkJdWludDMyX3Qgdm1pZCwgdWludDY0X3QgdmFs
dWUpCiB7CiAJLyogdHdvIHJlZ2lzdGVycyBkaXN0YW5jZSBiZXR3ZWVuIG1tVk1MMlZDMF9WTV9D
T05URVhUMF8qIHRvCkBAIC04MCw3ICs4MCw3IEBAIHN0YXRpYyB2b2lkIG1taHViX3Y5XzRfaW5p
dF9nYXJ0X2FwZXJ0dXJlX3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiB7CiAJdWlu
dDY0X3QgcHRfYmFzZSA9IGFtZGdwdV9nbWNfcGRfYWRkcihhZGV2LT5nYXJ0LmJvKTsKIAotCW1t
aHViX3Y5XzRfc2V0dXBfdm1fcHRfcmVncyhhZGV2LCBodWJpZCwgMCwgcHRfYmFzZSk7CisJbW1o
dWJfdjlfNF9zZXR1cF9odWJpZF92bV9wdF9yZWdzKGFkZXYsIGh1YmlkLCAwLCBwdF9iYXNlKTsK
IAogCVdSRUczMl9TT0MxNV9PRkZTRVQoTU1IVUIsIDAsCiAJCQkgICAgbW1WTUwyVkMwX1ZNX0NP
TlRFWFQwX1BBR0VfVEFCTEVfU1RBUlRfQUREUl9MTzMyLApAQCAtMTAxLDYgKzEwMSwxNiBAQCBz
dGF0aWMgdm9pZCBtbWh1Yl92OV80X2luaXRfZ2FydF9hcGVydHVyZV9yZWdzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogCQkJICAgICh1MzIpKGFkZXYtPmdtYy5nYXJ0X2VuZCA+PiA0NCkp
OwogfQogCit2b2lkIG1taHViX3Y5XzRfc2V0dXBfdm1fcHRfcmVncyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKKwkJCQl1aW50NjRfdCBwYWdlX3RhYmxlX2Jhc2Up
Cit7CisJaW50IGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgTU1IVUJfTlVNX0lOU1RBTkNFUzsgaSsr
KQorCQltbWh1Yl92OV80X3NldHVwX2h1YmlkX3ZtX3B0X3JlZ3MoYWRldiwgaSwgdm1pZCwKKwkJ
CQlwYWdlX3RhYmxlX2Jhc2UpOworfQorCiBzdGF0aWMgdm9pZCBtbWh1Yl92OV80X2luaXRfc3lz
dGVtX2FwZXJ0dXJlX3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJCSAgICAg
ICAgIGludCBodWJpZCkKIHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L21taHViX3Y5XzQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuaApp
bmRleCAzNTRhNGI3ZTg3NWIuLjFiOTc5NzczNzc2YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L21taHViX3Y5XzQuaApAQCAtMzQsNSArMzQsNyBAQCB2b2lkIG1taHViX3Y5XzRfaW5pdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBpbnQgbW1odWJfdjlfNF9zZXRfY2xvY2tnYXRp
bmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgICAgZW51bSBhbWRfY2xvY2tn
YXRpbmdfc3RhdGUgc3RhdGUpOwogdm9pZCBtbWh1Yl92OV80X2dldF9jbG9ja2dhdGluZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyICpmbGFncyk7Cit2b2lkIG1taHViX3Y5XzRfc2V0
dXBfdm1fcHRfcmVncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwK
KwkJCQl1aW50NjRfdCBwYWdlX3RhYmxlX2Jhc2UpOwogCiAjZW5kaWYKLS0gCjIuMTcuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
