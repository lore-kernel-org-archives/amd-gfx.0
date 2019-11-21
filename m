Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D76C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 21:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027272068D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 21:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027272068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6AB46E1B4;
	Thu, 21 Nov 2019 21:26:54 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED2C6E1B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 21:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3YJ3cLz2fZzuikMx6do+BrlT5GA9TE9yTJaZULfmh8Vf3c0OYcbaNsFWlORCDeQHRwSj1H0tZ7VYamxlKVIcUNwnHjk/tBUwNmvvBzRThN/US2PBzLcW9Qmcr7FUByZ3iv/2H0NqPklfLAa5q+tH0eAkVP0E1VxnPIcbSp8bKMgEmnC4dn2U9yOk+ZLkYy7eakHulE3DjR4dkVM2hrHmeOZRBtz7IQV66wHW2QYQ/Efl5w48LNKz16Hz9MSzR2TDJiIi/6vZLf5NW9kvloVHf81xC1VLB7aoqo/LJpahqyvU+u6QcbRqgRv3jrrAHM+czRinBjDsXtaNCBRatZIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXNyKo1f5+Toxb+WYWxr/6Nl2qS1lN1A+x9Fcj0aeG0=;
 b=Ec2hUMkgaZvuiGTyfKqM5XdIaGRDZoruxtNzpUTp3lPAX1bl6Z999x5TfgAUKEULgDmFDTuMgY5JfvEeuDPUrKNs25cZcGmEitKj0tdz+NBnxOofxBSx75zEmacI4JU2/iHlF00OvoOeNdI2NU8y3bwtW6hnoAXX7BYmkiKkaV1Z0oNQDB/AbfuTz8z53EiPwaPE/BoavPhXWNYkH6A0KdN/0d7qat1BAlJOazbxVAo8aZoXRx3ASnyAUabJxqEeur6A8CsHFXNHqGbQ9kpyXmSJ8pk9KePgyfnjvH7itRBK3XaUYe1SFL2umpj/4xMw8ZjrwBNiz58zR4s+14SVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 21:26:51 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 21:26:51 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: Rename pm_release_ib() to
 pm_destroy_runlist_ib()
Date: Thu, 21 Nov 2019 16:26:38 -0500
Message-Id: <20191121212639.4057-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1960fa11-5ad9-4ee1-9141-08d76ec98606
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:|DM6PR12MB2682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682C876F7A5883593616458F04E0@DM6PR12MB2682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0228DDDDD7
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(6506007)(478600001)(14444005)(47776003)(6666004)(7736002)(305945005)(66066001)(16586007)(5660300002)(186003)(86362001)(4326008)(2906002)(52116002)(51416003)(99286004)(36756003)(26005)(386003)(316002)(2361001)(3846002)(48376002)(2616005)(66946007)(66556008)(66476007)(8936002)(6486002)(81166006)(81156014)(8676002)(6436002)(6916009)(6512007)(2351001)(25786009)(6116002)(14454004)(50466002)(1076003)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2682;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+mTz1HVOgBn6vEpJcCpjVGv6N/MZoykNiz0iDVWXryqIrPqllTjoChVf6sKiiPSq7QYCCKjtJoCiEdT9c+eATfo/AQ2eRwcqD1hPFWuIvQxZUKxbpSGZ/P1u9QKyllRVX/og5v3joC6xZw3Ef7Hh9P8xR/9WLtwvJNK6SVqDv6WZUACz5idJQdhdCo86Hg1iZqzdNB4+aGUvY89fg0a9v57ry7UilqezKumhsSDkK2ZwcfmM7PM31Ct6+vpi0A3G8eFQQThOsVTAfLiy5ey77t8M0GWVA0j3Aid/dkve0Fdkuo8Y5xQo3Sf9wxbZLWs188VjJ8VOx2dMS25jUNotw76no/X1DdsWj/Wcledbtirj6wJDpXeBuqR4zCdkb0fTbd5tz4vocDleLDbvRBC1bngBkieyT/4gwOIWAwbrw0Z2bvD2GvTYVdQqyRG6PUB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1960fa11-5ad9-4ee1-9141-08d76ec98606
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2019 21:26:51.4172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxKQajv5vYC9AVNP+NHnV+KowetkrCxx9LZjXjRWbpzBOZjBAGWeKkuUY9oxsdPw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXNyKo1f5+Toxb+WYWxr/6Nl2qS1lN1A+x9Fcj0aeG0=;
 b=I3aXVOdqf/mqQAlYpaygKnWoh7Osil669sGZn9WFsehEq41DEcktoT4IgBdDGIqwipW18eTWR88zKMtObz9U99CrssPw1lDS+sx2YowVSii4FAYg06P6HKIzLOypI+MVlYE1m9Ow0IfDxmnhkmgCPeEXRF5ourtn1Sb0Ftp1CFM=
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
Message-ID: <20191121212638.25L_VqdMLPuDl_UGK-TfSUV39Ot-q_45jD5AAbRLB4s@z>

SXRzIGNvdW50ZXJwYXJ0eSBpcyBjYWxsZWQgcG1fY3JlYXRlX3J1bmxpc3RfaWIoKS4gVGhlIG5l
dyBuYW1lIG1ha2VzCml0IGVhc2llciB0byBuYXZpZ2F0ZSBpbiB0aGUgY29kZS4KCkFjY29yZGlu
Z2x5LCBBZGQgcmxfIHRvIHRoZSB2YXJpYWJsZSBuYW1lcyB0byBpbmRpY2F0ZSBpdCBpcyBydW5s
aXN0LgoKQ2hhbmdlLUlkOiBJZDYzYmZlYmViOGE1ZWQ2YWFlZmJlYmU5ODg1OGQ4NDcyNGZkMjZi
ZQpTaWduZWQtb2ZmLWJ5OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgotLS0KIC4uLi9k
cm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyAgfCAgMiArLQogLi4uL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXIuYyAgICB8IDE4ICsrKysrKysrKy0t
LS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCAgICAgICAgICB8
ICA2ICsrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
X3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2Vf
cXVldWVfbWFuYWdlci5jCmluZGV4IGY3ZjZkZjQwODc1ZS4uNTEwZjJkMWJiOGJiIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFn
ZXIuYwpAQCAtMTM1NSw3ICsxMzU1LDcgQEAgc3RhdGljIGludCB1bm1hcF9xdWV1ZXNfY3BzY2go
c3RydWN0IGRldmljZV9xdWV1ZV9tYW5hZ2VyICpkcW0sCiAJaWYgKHJldHZhbCkKIAkJcmV0dXJu
IHJldHZhbDsKIAotCXBtX3JlbGVhc2VfaWIoJmRxbS0+cGFja2V0cyk7CisJcG1fZGVzdHJveV9y
dW5saXN0X2liKCZkcW0tPnBhY2tldHMpOwogCWRxbS0+YWN0aXZlX3J1bmxpc3QgPSBmYWxzZTsK
IAogCXJldHVybiByZXR2YWw7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfcGFja2V0X21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
YWNrZXRfbWFuYWdlci5jCmluZGV4IDZjYWJlZDA2ZWY1ZC4uNGE5NDMzMjU3NDI4IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXIuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXIuYwpAQCAtOTgs
MTUgKzk4LDE1IEBAIHN0YXRpYyBpbnQgcG1fYWxsb2NhdGVfcnVubGlzdF9pYihzdHJ1Y3QgcGFj
a2V0X21hbmFnZXIgKnBtLAogCW11dGV4X2xvY2soJnBtLT5sb2NrKTsKIAogCXJldHZhbCA9IGtm
ZF9ndHRfc2FfYWxsb2NhdGUocG0tPmRxbS0+ZGV2LCAqcmxfYnVmZmVyX3NpemUsCi0JCQkJCSZw
bS0+aWJfYnVmZmVyX29iaik7CisJCQkJCSZwbS0+cmxfaWJfb2JqKTsKIAogCWlmIChyZXR2YWwp
IHsKIAkJcHJfZXJyKCJGYWlsZWQgdG8gYWxsb2NhdGUgcnVubGlzdCBJQlxuIik7CiAJCWdvdG8g
b3V0OwogCX0KIAotCSoodm9pZCAqKilybF9idWZmZXIgPSBwbS0+aWJfYnVmZmVyX29iai0+Y3B1
X3B0cjsKLQkqcmxfZ3B1X2J1ZmZlciA9IHBtLT5pYl9idWZmZXJfb2JqLT5ncHVfYWRkcjsKKwkq
KHZvaWQgKiopcmxfYnVmZmVyID0gcG0tPnJsX2liX29iai0+Y3B1X3B0cjsKKwkqcmxfZ3B1X2J1
ZmZlciA9IHBtLT5ybF9pYl9vYmotPmdwdV9hZGRyOwogCiAJbWVtc2V0KCpybF9idWZmZXIsIDAs
ICpybF9idWZmZXJfc2l6ZSk7CiAJcG0tPmFsbG9jYXRlZCA9IHRydWU7CkBAIC0xMzgsNyArMTM4
LDcgQEAgc3RhdGljIGludCBwbV9jcmVhdGVfcnVubGlzdF9pYihzdHJ1Y3QgcGFja2V0X21hbmFn
ZXIgKnBtLAogCQlyZXR1cm4gcmV0dmFsOwogCiAJKnJsX3NpemVfYnl0ZXMgPSBhbGxvY19zaXpl
X2J5dGVzOwotCXBtLT5pYl9zaXplX2J5dGVzID0gYWxsb2Nfc2l6ZV9ieXRlczsKKwlwbS0+cmxf
aWJfc2l6ZV9ieXRlcyA9IGFsbG9jX3NpemVfYnl0ZXM7CiAKIAlwcl9kZWJ1ZygiQnVpbGRpbmcg
cnVubGlzdCBpYiBwcm9jZXNzIGNvdW50OiAlZCBxdWV1ZXMgY291bnQgJWRcbiIsCiAJCXBtLT5k
cW0tPnByb2Nlc3Nlc19jb3VudCwgcG0tPmRxbS0+cXVldWVfY291bnQpOwpAQCAtMTQ5LDcgKzE0
OSw3IEBAIHN0YXRpYyBpbnQgcG1fY3JlYXRlX3J1bmxpc3RfaWIoc3RydWN0IHBhY2tldF9tYW5h
Z2VyICpwbSwKIAkJLyogYnVpbGQgbWFwIHByb2Nlc3MgcGFja2V0ICovCiAJCWlmIChwcm9jY2Vz
c2VzX21hcHBlZCA+PSBwbS0+ZHFtLT5wcm9jZXNzZXNfY291bnQpIHsKIAkJCXByX2RlYnVnKCJO
b3QgZW5vdWdoIHNwYWNlIGxlZnQgaW4gcnVubGlzdCBJQlxuIik7Ci0JCQlwbV9yZWxlYXNlX2li
KHBtKTsKKwkJCXBtX2Rlc3Ryb3lfcnVubGlzdF9pYihwbSk7CiAJCQlyZXR1cm4gLUVOT01FTTsK
IAkJfQogCkBAIC0zMzcsNyArMzM3LDcgQEAgaW50IHBtX3NlbmRfcnVubGlzdChzdHJ1Y3QgcGFj
a2V0X21hbmFnZXIgKnBtLCBzdHJ1Y3QgbGlzdF9oZWFkICpkcW1fcXVldWVzKQogZmFpbF9hY3F1
aXJlX3BhY2tldF9idWZmZXI6CiAJbXV0ZXhfdW5sb2NrKCZwbS0+bG9jayk7CiBmYWlsX2NyZWF0
ZV9ydW5saXN0X2liOgotCXBtX3JlbGVhc2VfaWIocG0pOworCXBtX2Rlc3Ryb3lfcnVubGlzdF9p
YihwbSk7CiAJcmV0dXJuIHJldHZhbDsKIH0KIApAQCAtNDAxLDExICs0MDEsMTEgQEAgaW50IHBt
X3NlbmRfdW5tYXBfcXVldWUoc3RydWN0IHBhY2tldF9tYW5hZ2VyICpwbSwgZW51bSBrZmRfcXVl
dWVfdHlwZSB0eXBlLAogCXJldHVybiByZXR2YWw7CiB9CiAKLXZvaWQgcG1fcmVsZWFzZV9pYihz
dHJ1Y3QgcGFja2V0X21hbmFnZXIgKnBtKQordm9pZCBwbV9kZXN0cm95X3J1bmxpc3RfaWIoc3Ry
dWN0IHBhY2tldF9tYW5hZ2VyICpwbSkKIHsKIAltdXRleF9sb2NrKCZwbS0+bG9jayk7CiAJaWYg
KHBtLT5hbGxvY2F0ZWQpIHsKLQkJa2ZkX2d0dF9zYV9mcmVlKHBtLT5kcW0tPmRldiwgcG0tPmli
X2J1ZmZlcl9vYmopOworCQlrZmRfZ3R0X3NhX2ZyZWUocG0tPmRxbS0+ZGV2LCBwbS0+cmxfaWJf
b2JqKTsKIAkJcG0tPmFsbG9jYXRlZCA9IGZhbHNlOwogCX0KIAltdXRleF91bmxvY2soJnBtLT5s
b2NrKTsKQEAgLTQyNSw3ICs0MjUsNyBAQCBpbnQgcG1fZGVidWdmc19ydW5saXN0KHN0cnVjdCBz
ZXFfZmlsZSAqbSwgdm9pZCAqZGF0YSkKIAl9CiAKIAlzZXFfaGV4X2R1bXAobSwgIiAgIiwgRFVN
UF9QUkVGSVhfT0ZGU0VULCAzMiwgNCwKLQkJICAgICBwbS0+aWJfYnVmZmVyX29iai0+Y3B1X3B0
ciwgcG0tPmliX3NpemVfYnl0ZXMsIGZhbHNlKTsKKwkJICAgICBwbS0+cmxfaWJfb2JqLT5jcHVf
cHRyLCBwbS0+cmxfaWJfc2l6ZV9ieXRlcywgZmFsc2UpOwogCiBvdXQ6CiAJbXV0ZXhfdW5sb2Nr
KCZwbS0+bG9jayk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJpdi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaAppbmRleCA1MTQ4
OTZiZWY5OWEuLjM4OWNkYTdjOGYxYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3ByaXYuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJp
di5oCkBAIC05MzcsOCArOTM3LDggQEAgc3RydWN0IHBhY2tldF9tYW5hZ2VyIHsKIAlzdHJ1Y3Qg
a2VybmVsX3F1ZXVlICpwcml2X3F1ZXVlOwogCXN0cnVjdCBtdXRleCBsb2NrOwogCWJvb2wgYWxs
b2NhdGVkOwotCXN0cnVjdCBrZmRfbWVtX29iaiAqaWJfYnVmZmVyX29iajsKLQl1bnNpZ25lZCBp
bnQgaWJfc2l6ZV9ieXRlczsKKwlzdHJ1Y3Qga2ZkX21lbV9vYmogKnJsX2liX29iajsKKwl1bnNp
Z25lZCBpbnQgcmxfaWJfc2l6ZV9ieXRlczsKIAlib29sIGlzX292ZXJfc3Vic2NyaXB0aW9uOwog
CiAJY29uc3Qgc3RydWN0IHBhY2tldF9tYW5hZ2VyX2Z1bmNzICpwbWY7CkBAIC05ODksNyArOTg5
LDcgQEAgaW50IHBtX3NlbmRfdW5tYXBfcXVldWUoc3RydWN0IHBhY2tldF9tYW5hZ2VyICpwbSwg
ZW51bSBrZmRfcXVldWVfdHlwZSB0eXBlLAogCQkJdWludDMyX3QgZmlsdGVyX3BhcmFtLCBib29s
IHJlc2V0LAogCQkJdW5zaWduZWQgaW50IHNkbWFfZW5naW5lKTsKIAotdm9pZCBwbV9yZWxlYXNl
X2liKHN0cnVjdCBwYWNrZXRfbWFuYWdlciAqcG0pOwordm9pZCBwbV9kZXN0cm95X3J1bmxpc3Rf
aWIoc3RydWN0IHBhY2tldF9tYW5hZ2VyICpwbSk7CiAKIC8qIEZvbGxvd2luZyBQTSBmdW5jcyBj
YW4gYmUgc2hhcmVkIGFtb25nIFZJIGFuZCBBSSAqLwogdW5zaWduZWQgaW50IHBtX2J1aWxkX3Bt
NF9oZWFkZXIodW5zaWduZWQgaW50IG9wY29kZSwgc2l6ZV90IHBhY2tldF9zaXplKTsKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
