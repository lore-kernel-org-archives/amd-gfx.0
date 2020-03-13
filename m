Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF35C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 16:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63260206EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="28qcKOLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63260206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAE56EC04;
	Fri, 13 Mar 2020 16:10:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F196EC06
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 16:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4J5xbSYGVMZ3Z78xF4FtSrQN60Eq8a8t/VqupZ7d2Bdb6j41mlExrjtGxtV1/xoOcNZ+YcS8x2+eGv68USWW6+GVtbeqVivOrzU67lvAflBbWs6FSnbwxZLuXqu1r0xd5DCYu06GYLI5JxZHO+YSOQGG4cbDL6pFJ4DKSPJmxtk/iOvN9asjzNYulkPaQmHWdCQBD2BdKNT2nitN1AXEDcpLUOh0ejrgIPru9YKpGjUxulZOep6y3UJTimtv4L0LHZNLX7WyDZFDu2wbuZdwR00w7vc7lmG/0fA4cTyrFbujBohJxOqHvoxJEtPe0RdGPSM5poHYOFXJjR8WkO3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IR+4Yvebm9WbLoAdAV2CiyV27sAl1kulYk0X/xjz54=;
 b=mwsVOYLIFJHiL5RsLUcf17sOCDD9eZ+OijCiMvcbb4cJSvFvOmasXKQImt2mTPTf8y6CXZ0KdWo6/J6GRM6giMJErB6Op5kXHiJ2U9AefynYWaRk2gzaTLPNjNLe/13o83m0TUgCnihU29KoxOdzQndWeXESUJChrTyHK5boEX57AuY3g3+uaIUMVnheC2p491ccGcg8uYzFhL2SVd5MHomO01wC10DB3AP+dSGvPlR0MpeDTAunfh7RA7B76HQMpjYjKo+z86ijveifaM6KZl1640G6b8GGS0T6v12f5MFcjPOhEw436lJcf6JNLyGzurLbn6eevvfP7bdJ2lcJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IR+4Yvebm9WbLoAdAV2CiyV27sAl1kulYk0X/xjz54=;
 b=28qcKOLu6OiCxJoX04hnHWvxZh/QbQ8BoAi688KbKy9dg51R+4TNAuz3E7UrnF0UhtXSZLj+QIi6G2WglAuRyIOGqjKmrZvWKvnTDPlvGNFkd4FhN77MFBvFkQxu5468xN/pdP3J+zkK9fxqUd3Xaddgt0GLfEoNBhHlXyBUEpY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2703.namprd12.prod.outlook.com (2603:10b6:805:75::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 16:10:03 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 16:10:03 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 2/2] drm/amdgpu: unref pt bo after job submit
Date: Sat, 14 Mar 2020 00:09:33 +0800
Message-Id: <20200313160933.10394-3-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313160933.10394-1-xinhui.pan@amd.com>
References: <20200313160933.10394-1-xinhui.pan@amd.com>
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16 via Frontend Transport; Fri, 13 Mar 2020 16:10:01 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 417267c3-02c6-4cb5-945f-08d7c768fd12
X-MS-TrafficTypeDiagnostic: SN6PR12MB2703:|SN6PR12MB2703:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2703052E7452B157C3ECCF6A87FA0@SN6PR12MB2703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(6666004)(54906003)(86362001)(36756003)(6916009)(316002)(6486002)(4326008)(16526019)(186003)(81156014)(956004)(2906002)(26005)(2616005)(1076003)(81166006)(7696005)(66574012)(5660300002)(8936002)(52116002)(66946007)(8676002)(66476007)(66556008)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2703;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhiZcGw4jI7MgsQ7Rva7DIENzq6BSZj0eZ/BtUTpZB+zg+GGNK8/Wo/10lausJW3c99gwd6dptLX3eOZUbXrywL0lusky4cA84l7Rrh2pv8PdrlnRO3pUJvRsPpas3hie4e4pFqlXRgYoAXRV/otazA7DC4zhiBXV84YB/Q88PjCgTBO2K62Zv1RiDwTYUDKiK/tbbmCxR+lPNZwJyHvosUuwsn/mgnIVrfbiBfCtR/5EixfjVWZgGAfgV6CKjksuhB33HziUDneox53oUhPXT8k7xFOztVYoZ98HSRTsbHr23zcpqY/eiAJ/xrujbKdXdrHdogX3hGtpA54SCfGlQFLFwUNtHkArFwiWPnOHSPpGHrL0O2CNCVE9CAq4ZhGTZLfK6mEkD7AuKa8V5IpZuWvBCWhAvyRxMX4VaAJkh1QYvQnMCnZl1BNgl9iZ2eq
X-MS-Exchange-AntiSpam-MessageData: ivPGYBCnrOvs1mHzuozhgd734awN11STCbN7blYrjbZsHuWON01gvDS3U9FXvYw7IHzfJHILOU8fgs0zjL3WVM1yxHVnCywwVbyBkzcL/ZmuSx0KAPJJTMXkznl5IqvjgUZZngudyQjcV2mrxHYpdQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417267c3-02c6-4cb5-945f-08d7c768fd12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 16:10:03.5822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6NvdIm9RJKEqyFQ/dkujVhTa1KH8S0GdRIDqqUMIfzOOCawMHWobvdeIyziq3d9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
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
 Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJlZSBwYWdlIHRhYmxlIGJvIGJlZm9yZSBqb2Igc3VibWl0IGlzIGluc2FuZS4KV2UgbWlnaHQg
dG91Y2ggaW52YWxpZCBtZW1vcnkgd2hpbGUgam9iIGlzIHJ1bm5pZy4KCndlIG5vdyBoYXZlIGlu
ZGl2aWR1YWxpemVkIGJvIHJlc3YgZHVyaW5nIGJvIHJlbGVhc2luZy4KU28gYW55IGZlbmNlcyBh
ZGRlZCB0byByb290IFBUIGJvIGlzIGFjdHVhbGx5IHVudGVzdGVkIHdoZW4KYSBub3JtYWwgUFQg
Ym8gaXMgcmVsZWFzaW5nLgoKV2UgbWlnaHQgaGl0IGdtYyBwYWdlIGZhdWx0IG9yIG1lbW9yeSBq
dXN0IGdvdCBvdmVyd3JpdGVkLgoKQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
Q2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5
OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKystLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgIDMgKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwppbmRleCA3MzM5ODgzMTE5NmYuLjM0NmUyZjc1MzQ3NCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTkzNyw2ICs5MzcsMjEgQEAgc3Rh
dGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CXJldHVybiByOwogfQogCitzdGF0aWMgdm9pZCBhbWRncHVfdm1fZnJlZV96b21iaWVfYm8oc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCXN0cnVjdCBhbWRncHVfdm0gKnZtKQoreworCXN0
cnVjdCBhbWRncHVfdm1fcHQgKmVudHJ5OworCisJd2hpbGUgKCFsaXN0X2VtcHR5KCZ2bS0+em9t
YmllcykpIHsKKwkJZW50cnkgPSBsaXN0X2ZpcnN0X2VudHJ5KCZ2bS0+em9tYmllcywgc3RydWN0
IGFtZGdwdV92bV9wdCwKKwkJCQliYXNlLnZtX3N0YXR1cyk7CisJCWxpc3RfZGVsKCZlbnRyeS0+
YmFzZS52bV9zdGF0dXMpOworCisJCWFtZGdwdV9ib191bnJlZigmZW50cnktPmJhc2UuYm8tPnNo
YWRvdyk7CisJCWFtZGdwdV9ib191bnJlZigmZW50cnktPmJhc2UuYm8pOworCX0KK30KKwogLyoq
CiAgKiBhbWRncHVfdm1fZnJlZV90YWJsZSAtIGZyZSBvbmUgUEQvUFQKICAqCkBAIC05NDUsMTAg
Kzk2MCw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2FsbG9jX3B0cyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxlKHN0cnVjdCBhbWRn
cHVfdm1fcHQgKmVudHJ5KQogewogCWlmIChlbnRyeS0+YmFzZS5ibykgeworCQlsaXN0X21vdmUo
JmVudHJ5LT5iYXNlLnZtX3N0YXR1cywKKwkJCQkmZW50cnktPmJhc2UuYm8tPnZtX2JvLT52bS0+
em9tYmllcyk7CiAJCWVudHJ5LT5iYXNlLmJvLT52bV9ibyA9IE5VTEw7Ci0JCWxpc3RfZGVsKCZl
bnRyeS0+YmFzZS52bV9zdGF0dXMpOwotCQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJv
LT5zaGFkb3cpOwotCQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvKTsKIAl9CiAJa3Zm
cmVlKGVudHJ5LT5lbnRyaWVzKTsKIAllbnRyeS0+ZW50cmllcyA9IE5VTEw7CkBAIC0xNjI0LDYg
KzE2MzgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKIAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJh
bXMsIGZlbmNlKTsKIAogZXJyb3JfdW5sb2NrOgorCWFtZGdwdV92bV9mcmVlX3pvbWJpZV9ibyhh
ZGV2LCB2bSk7CiAJYW1kZ3B1X3ZtX2V2aWN0aW9uX3VubG9jayh2bSk7CiAJcmV0dXJuIHI7CiB9
CkBAIC0yODA3LDYgKzI4MjIsNyBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAogCUlOSVRfTElTVF9IRUFEKCZ2bS0+
aW52YWxpZGF0ZWQpOwogCXNwaW5fbG9ja19pbml0KCZ2bS0+aW52YWxpZGF0ZWRfbG9jayk7CiAJ
SU5JVF9MSVNUX0hFQUQoJnZtLT5mcmVlZCk7CisJSU5JVF9MSVNUX0hFQUQoJnZtLT56b21iaWVz
KTsKIAogCiAJLyogY3JlYXRlIHNjaGVkdWxlciBlbnRpdGllcyBmb3IgcGFnZSB0YWJsZSB1cGRh
dGVzICovCkBAIC0zMTE5LDYgKzMxMzUsOCBAQCB2b2lkIGFtZGdwdV92bV9maW5pKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKIAl9CiAKIAlhbWRncHVf
dm1fZnJlZV9wdHMoYWRldiwgdm0sIE5VTEwpOworCWFtZGdwdV92bV9mcmVlX3pvbWJpZV9ibyhh
ZGV2LCB2bSk7CisKIAlhbWRncHVfYm9fdW5yZXNlcnZlKHJvb3QpOwogCWFtZGdwdV9ib191bnJl
Zigmcm9vdCk7CiAJV0FSTl9PTih2bS0+cm9vdC5iYXNlLmJvKTsKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmgKaW5kZXggYjU3MDVmY2ZjOTM1Li45YmFmNDRmYTE2ZjAgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCkBAIC0yNjksNiArMjY5LDkgQEAgc3Ry
dWN0IGFtZGdwdV92bSB7CiAJLyogQk8gbWFwcGluZ3MgZnJlZWQsIGJ1dCBub3QgeWV0IHVwZGF0
ZWQgaW4gdGhlIFBUICovCiAJc3RydWN0IGxpc3RfaGVhZAlmcmVlZDsKIAorCS8qIEJPIHdpbGwg
YmUgZnJlZWQgc29vbiAqLworCXN0cnVjdCBsaXN0X2hlYWQJem9tYmllczsKKwogCS8qIGNvbnRh
aW5zIHRoZSBwYWdlIGRpcmVjdG9yeSAqLwogCXN0cnVjdCBhbWRncHVfdm1fcHQgICAgIHJvb3Q7
CiAJc3RydWN0IGRtYV9mZW5jZQkqbGFzdF91cGRhdGU7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
