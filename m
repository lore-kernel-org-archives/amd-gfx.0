Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A87C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 12:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3955D24654
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 12:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KuOlrLn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3955D24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15B56E5CA;
	Wed, 19 Feb 2020 12:48:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FD86E5CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 12:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvpSe9KThZg1f8OmPpiAr0xNqkwytzk4anM90/vwOyawXX621mp/veEk7d01Y2fOWR9NFQ73yD41VqsbPtWDTEoJLR/WH1fgaqFJ9SoX5MvyxXYc5Irbg2QlcTzSa7smLLjjv3WnRdrrXGmWD0uQ701sZJKhTGv6wWPv8cS6yAs6CLz0+LgqFWLEb067CTZkhsrQNdflZT8zSvHvBOOskwMxDwlx9RhZXFSKK9w3TYKXUMVs0GwvQo0c6eIHnEJYg2ppEpKvOChCNuVVGpCGZqyZW0/MBZRYybbB+8mIt7+f8uQGo9yLjLiObevur0m8Trwz3ENRtKNxN/R4SUCJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvvKW+w7S5peqC7xL4EBNLiSLUsKbpLIPyk2ktWEcFM=;
 b=LDVAwDu015FEq+KBa8+dHu4gJZLtdK5zltTOcEWbZoBGqF82+7CxFAklPfGWfooNgtOTQh/XHvsBhszKsWDyMss5Y3znYpHdp4PAo1ADDpSNmAJALfwmBmuGm+USfHoU49ZpBHo37beXDxKh5TuuW7Ltx9f2UZduT1Px0QQpebsdEdU7azEKl6hOS3stpREjYel741G43usDyPLbbYggb4HghfJDxaAqAtyDEDtvjgDntzEQlfGzL7hQjYtlOGogOswSrZ/wb1Jy28rOrMgH8RqwyvGq7X1+Jth8yIRzPAo8NQK7dvbgvjiqQoXc0yqtflo0Ej4Dmz+HcWi5ApQJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvvKW+w7S5peqC7xL4EBNLiSLUsKbpLIPyk2ktWEcFM=;
 b=KuOlrLn4r5cUPta1/CqsEuiBfYOyriW6c2g6T8W8OUvjxva8M/thfK8Df7K6XlkynFp8yAFZ835E9vVl5fP2lkA2TiBUtdnDIXKoB6cmhEMXijWoHgKmmiG4t/fgc0JBxUKX7KSw44wMLNjMpoCxBC3F68Z6g5tnPhiQy+tCCV8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2608.namprd12.prod.outlook.com (52.135.99.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 12:48:03 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 12:48:02 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH v6] drm/amdgpu: Remove kfd eviction fence before release bo
Date: Wed, 19 Feb 2020 20:46:52 +0800
Message-Id: <20200219124652.7465-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0153.apcprd02.prod.outlook.com
 (2603:1096:201:1f::13) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0153.apcprd02.prod.outlook.com (2603:1096:201:1f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 12:48:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f9dab4b-5f39-4e72-8607-08d7b539f500
X-MS-TrafficTypeDiagnostic: SN6PR12MB2608:|SN6PR12MB2608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26089E38F0CCAA4DFFDE757387100@SN6PR12MB2608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(2616005)(956004)(8676002)(26005)(81156014)(86362001)(8936002)(52116002)(5660300002)(81166006)(36756003)(2906002)(186003)(7696005)(54906003)(16526019)(6916009)(66946007)(6486002)(66556008)(4326008)(316002)(66574012)(66476007)(478600001)(6666004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2608;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: guwkAAnia9wOXZxS/PMDcylCcRF6E+lS+aMe3aT9eRWy9ealzJb7rGWlE4mhCMhoFT/XY33CjzfUOQYSonHtMfBqGO9LfJJ5G2ILE1xDY70NUb7Er9LA7EWYoSaS3PLEwE2nPAlbEK6qsxnIgOaqcuzORnSzk9iiC+Zwh7Z1/Pxf+Yra5FXFVpB+XYcFPCSLv7QW32HRkquv2iAWJpf4nMHF35gaL+o6OxFWTyckpXNaFhR4bkGz7GFbhUvhXPLFhbBqipXLWcx4c04uY4PpyCqTUK8aqtG28Pu3h4m+hwXSzAwzMJRu88LiG53G7YqJIpQp58t1PAFsiulXJckNbdJBxNN604gu8jz2r/vac30KwI2ZN0AgKJLB+hgSbQqLvU3OqRz9C2cieTEOc78wabQ3BqN/QScll7jYpVOaDVi/q7pI6R9VFMh9dlngor3o
X-MS-Exchange-AntiSpam-MessageData: 3IhtEiwgJ/7hwDcoGnJi/xgnA3Q3yosfEQocNneOnBz6zVXeoj0res+NU3z6hS00270w3TOoy0jbpWzbVrSn4fg7Gy8L3o+Jc9E1Y1SJug7HgefHtCJT1FGCQnfjQa3hUCBVGkMX+Dgcca+syE/83Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9dab4b-5f39-4e72-8607-08d7b539f500
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 12:48:02.6978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8Jc1ALe3ZlEZbYSKMnbcq+RsHV0lGLwI+BQBsbNSbgdYL5N5G/cseV62lwY+St4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tm8gbmVlZCB0byB0cmlnZ2VyIGV2aWN0aW9uIGFzIHRoZSBtZW1vcnkgbWFwcGluZyB3aWxsIG5v
dCBiZSB1c2VkCmFueW1vcmUuCgpBbGwgcHQvcGQgYm9zIHNoYXJlIHNhbWUgcmVzdiwgaGVuY2Ug
dGhlIHNhbWUgc2hhcmVkIGV2aWN0aW9uIGZlbmNlLgpFdmVyeXRpbWUgcGFnZSB0YWJsZSBpcyBm
cmVlZCwgdGhlIGZlbmNlIHdpbGwgYmUgc2lnbmxlZCBhbmQgdGhhdCBjdWFzZXMKa2ZkIHVuZXhj
ZXB0ZWQgZXZpY3Rpb25zLgoKQ0M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KQ0M6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPgpDQzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpBY2tlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiB4aW5o
dWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+Ci0tLQpjaGFuZ2UgZnJvbSB2NToKdXNlIHRyeWxv
Y2sgaW5zdGVhZCwgYW5kIGFkZCB3YXJuX29uX29uY2UgdG8gZ2l2ZSBhIGxpbWl0ZCB3YXJuaW5n
LgoKY2hhbmdlIGZyb20gdjQ6CmJhc2VkIG9uIG5ldyB0dG0gY29kZS4KCmNoYW5nZSBmcm9tIHYz
OgpmaXggYSBjb2RpbmcgZXJyb3IKCmNoYW5nZSBmcm9tIHYyOgpiYXNlZCBvbiBDaHJpcycgZHJt
L3R0bTogcmV3b3JrIEJPIGRlbGF5ZWQgZGVsZXRlIHBhdGNoc2V0LgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCAgICB8ICAxICsKIC4uLi9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jICB8IDM4ICsrKysrKysrKysrKysrKysrKysK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyAgICB8ICA1ICsrKwog
MyBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZC5oCmluZGV4IDllOGRiNzAyZDg3OC4uMGVlOGFhZTZjNTE5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCkBAIC05Niw2ICs5
Niw3IEBAIHN0cnVjdCBhbWRncHVfYW1ka2ZkX2ZlbmNlICphbWRncHVfYW1ka2ZkX2ZlbmNlX2Ny
ZWF0ZSh1NjQgY29udGV4dCwKIAkJCQkJCSAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbSk7CiBi
b29sIGFtZGtmZF9mZW5jZV9jaGVja19tbShzdHJ1Y3QgZG1hX2ZlbmNlICpmLCBzdHJ1Y3QgbW1f
c3RydWN0ICptbSk7CiBzdHJ1Y3QgYW1kZ3B1X2FtZGtmZF9mZW5jZSAqdG9fYW1kZ3B1X2FtZGtm
ZF9mZW5jZShzdHJ1Y3QgZG1hX2ZlbmNlICpmKTsKK2ludCBhbWRncHVfYW1ka2ZkX3JlbW92ZV9m
ZW5jZV9vbl9wdF9wZF9ib3Moc3RydWN0IGFtZGdwdV9ibyAqYm8pOwogCiBzdHJ1Y3QgYW1ka2Zk
X3Byb2Nlc3NfaW5mbyB7CiAJLyogTGlzdCBoZWFkIG9mIGFsbCBWTXMgdGhhdCBiZWxvbmcgdG8g
YSBLRkQgcHJvY2VzcyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jCmluZGV4IGVmNzIxY2I2NTg2OC4uODk4ODUxYmVjMzc3IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCkBAIC0y
NzYsNiArMjc2LDQyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZXZpY3Rpb25f
ZmVuY2Uoc3RydWN0IGFtZGdwdV9ibyAqYm8sCiAJcmV0dXJuIDA7CiB9CiAKK2ludCBhbWRncHVf
YW1ka2ZkX3JlbW92ZV9mZW5jZV9vbl9wdF9wZF9ib3Moc3RydWN0IGFtZGdwdV9ibyAqYm8pCit7
CisJc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9IGJvOworCXN0cnVjdCBhbWRncHVfdm1fYm9fYmFz
ZSAqdm1fYm87CisJc3RydWN0IGFtZGdwdV92bSAqdm07CisJc3RydWN0IGFtZGtmZF9wcm9jZXNz
X2luZm8gKmluZm87CisJc3RydWN0IGFtZGdwdV9hbWRrZmRfZmVuY2UgKmVmOworCWludCByZXQ7
CisKKwkvKiB3ZSBjYW4gYWx3YXlzIGdldCB2bV9ibyBmcm9tIHJvb3QgUEQgYm8uKi8KKwl3aGls
ZSAocm9vdC0+cGFyZW50KQorCQlyb290ID0gcm9vdC0+cGFyZW50OworCisJdm1fYm8gPSByb290
LT52bV9ibzsKKwlpZiAoIXZtX2JvKQorCQlyZXR1cm4gMDsKKworCXZtID0gdm1fYm8tPnZtOwor
CWlmICghdm0pCisJCXJldHVybiAwOworCisJaW5mbyA9IHZtLT5wcm9jZXNzX2luZm87CisJaWYg
KCFpbmZvIHx8ICFpbmZvLT5ldmljdGlvbl9mZW5jZSkKKwkJcmV0dXJuIDA7CisKKwllZiA9IGNv
bnRhaW5lcl9vZihkbWFfZmVuY2VfZ2V0KCZpbmZvLT5ldmljdGlvbl9mZW5jZS0+YmFzZSksCisJ
CQlzdHJ1Y3QgYW1kZ3B1X2FtZGtmZF9mZW5jZSwgYmFzZSk7CisKKwlCVUdfT04oIWRtYV9yZXN2
X3RyeWxvY2soYm8tPnRiby5iYXNlLnJlc3YpKTsKKwlyZXQgPSBhbWRncHVfYW1ka2ZkX3JlbW92
ZV9ldmljdGlvbl9mZW5jZShibywgZWYpOworCWRtYV9yZXN2X3VubG9jayhiby0+dGJvLmJhc2Uu
cmVzdik7CisKKwlkbWFfZmVuY2VfcHV0KCZlZi0+YmFzZSk7CisJcmV0dXJuIHJldDsKK30KKwog
c3RhdGljIGludCBhbWRncHVfYW1ka2ZkX2JvX3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVfYm8gKmJv
LCB1aW50MzJfdCBkb21haW4sCiAJCQkJICAgICBib29sIHdhaXQpCiB7CkBAIC0xMDQ1LDYgKzEw
ODEsOCBAQCB2b2lkIGFtZGdwdV9hbWRrZmRfZ3B1dm1fZGVzdHJveV9jYihzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAlsaXN0X2RlbCgmdm0tPnZtX2xpc3Rfbm9kZSk7CiAJbXV0ZXhfdW5s
b2NrKCZwcm9jZXNzX2luZm8tPmxvY2spOwogCisJdm0tPnByb2Nlc3NfaW5mbyA9IE5VTEw7CisK
IAkvKiBSZWxlYXNlIHBlci1wcm9jZXNzIHJlc291cmNlcyB3aGVuIGxhc3QgY29tcHV0ZSBWTSBp
cyBkZXN0cm95ZWQgKi8KIAlpZiAoIXByb2Nlc3NfaW5mby0+bl92bXMpIHsKIAkJV0FSTl9PTigh
bGlzdF9lbXB0eSgmcHJvY2Vzc19pbmZvLT5rZmRfYm9fbGlzdCkpOwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCmluZGV4IDZmNjBhNTgxZTNiYS4uNTc2NmQyMGYy
OWQ4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC0x
MzA3LDYgKzEzMDcsMTEgQEAgdm9pZCBhbWRncHVfYm9fcmVsZWFzZV9ub3RpZnkoc3RydWN0IHR0
bV9idWZmZXJfb2JqZWN0ICpibykKIAlpZiAoYWJvLT5rZmRfYm8pCiAJCWFtZGdwdV9hbWRrZmRf
dW5yZXNlcnZlX21lbW9yeV9saW1pdChhYm8pOwogCisJLyogV2Ugb25seSByZW1vdmUgdGhlIGZl
bmNlIGlmIHRoZSByZXN2IGhhcyBpbmRpdmlkdWFsaXplZC4gKi8KKwlXQVJOX09OX09OQ0UoYm8t
PmJhc2UucmVzdiAhPSAmYm8tPmJhc2UuX3Jlc3YpOworCWlmIChiby0+YmFzZS5yZXN2ID09ICZi
by0+YmFzZS5fcmVzdikKKwkJYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZmVuY2Vfb25fcHRfcGRfYm9z
KGFibyk7CisKIAlpZiAoYm8tPm1lbS5tZW1fdHlwZSAhPSBUVE1fUExfVlJBTSB8fCAhYm8tPm1l
bS5tbV9ub2RlIHx8CiAJICAgICEoYWJvLT5mbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1f
V0lQRV9PTl9SRUxFQVNFKSkKIAkJcmV0dXJuOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
