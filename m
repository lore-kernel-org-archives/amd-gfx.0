Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D79C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 22:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA6E21739
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 22:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YKrdk3+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA6E21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB9E890B8;
	Tue, 28 Jan 2020 22:42:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373CD890B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 22:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2epL3utBb1TIV3qVwYeu1b2rMO+/U/IZopEQKVriCzZZHY+QQLYjiwkMJIMKGLLhD8O4XSxExmEw73fRK51wiofxj1QT+Qy1E6DIoAu4N9WJVtV61oLXGjlnz4mMaVaoYWKXwqzv0ON/FOo4jKNrZ/QbeQ+zuayF38gGt2zL5fTDYmshxnbS0/rUPt4sAxMvX/Y8ywGCa84AvHT88ALSLxgUdH7wFOC6wk/qphe7PVOK4KU8xXBgbb94DA9CkapzzhcsKpCUfaZb8Gk/DhN4Hyr23UO59HOsU+tLXwdb9zTHkOfq88qiIreql36xHtSoVzMd/FTeKTwwdqrILI79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0UeW1k9Pa9UCUNDoAl/HpPosCNj3P/aeRDqstqxvBU=;
 b=Jf0WVVfRHNrBxj2zgr0yN9+bVxn9roOpOx06SXeX+q8Ef/X0F9SKS80zuMHkJ7gRR698b44w3lOTSe5AJ6Tei9kpzIS93GLAV6w/avmDzjiqvjgHUaQlHusGYO5Xxxu1KusYoPLqgCzEXWaNSbrtRHUIks461x5PxuRS3Htl/6oXQKERtNI3l3MraF84oi2HIEAXy/bJfKk24CS1HHPag/RaLJtmbudqEcvY+o7XzUeP5RJpZA8bAvPzd27iQZZvfUVTZUF8oSUHyIGJxKBUd0lIXD87j6d267mpPlVGThpvZgTSEPnuO7+wVhoH4Cl3cPSj1FAzbkZnf8UeLi7uww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0UeW1k9Pa9UCUNDoAl/HpPosCNj3P/aeRDqstqxvBU=;
 b=YKrdk3+XKIMeVUdGk9++sKpmwfr6tIa3qZ2RQj5madMnM8vWROhbEOo8kWS8dIVbyYDAU6eVY+ZlYLjEdBYCWavAj4KBIGjyEw6FNidO9Vp8yDhdi/WoJGikpMexMrDSjnZHpOVIbiE7nra9YRI3HleBpvZYHH0IMCx4ehEPFQM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2536.namprd12.prod.outlook.com (10.172.90.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Tue, 28 Jan 2020 22:42:14 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 22:42:14 +0000
Subject: Re: [Patch v1 4/5] drm/amdkfd: show warning when kfd is locked
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-5-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5209ef6a-693a-db6c-4ed2-6f234cc00a14@amd.com>
Date: Tue, 28 Jan 2020 17:42:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200128012923.25536-5-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::40) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [192.168.2.21] (142.116.63.128) by
 YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Tue, 28 Jan 2020 22:42:13 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcb277ed-724c-4966-1bfd-08d7a44351ab
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2536:|DM5PR1201MB2536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25360DAA45110536A375E999920A0@DM5PR1201MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(189003)(199004)(2906002)(44832011)(66476007)(316002)(66556008)(16576012)(66946007)(31686004)(478600001)(5660300002)(81166006)(52116002)(81156014)(8676002)(86362001)(31696002)(8936002)(36756003)(6486002)(53546011)(16526019)(2616005)(956004)(186003)(4326008)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2536;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbXHVT9UFmmQyBGkC7BsELHbhaqwn73QywzxTSc1jjpr1VyJvQPSmMQr7VOKiCXilfxoGgEu8I8GzOFRQPpikp07+7h7bf+0o+3LG0XCKc2Gwv7x7snPL83YKqn3IyYNo8GAQra+Wm5tuPA1TtZBXBWjsqrg3xBtjdEm/NDqAJUmqflLiVJRHqtlj0uvSgoNmEZvJ/jCI9F0RUXLCOXxeGWA3JjbPSj/sSCjprZng6hZ1qA/ykaJnDyDgjpvF7l/of/d6IDw4GmH91acrN/rTKIsQnoV1EGnjVHNgyuutglVeyduKJ2AI6Hpyme1XzN7Zd6DofvyGNeZ9KF/HFh0w3dgF2MJkwLp6m4klUEgrhUPyHE9MC4ZHMd9R3A7I3k0bft2nD0viu2/W3xgezBu5FoxVgt5Q2I7daurLu/DOXMkzT+dx2FdyL2i2mCzUJFN
X-MS-Exchange-AntiSpam-MessageData: 9moZVu5r90n3EaW2AWXjcVh7ostmCyE4rreT9ZNTJ+8sXWn11MCUukCpTH27Cxuy6pw8yTtkhEdUclat3u4vSXNwI9F7oY0iSPHKYIg2EscYCCl3nYHpRDd+gt3vGNxAsvG4Qg3wnUQkksY3eY/62Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb277ed-724c-4966-1bfd-08d7a44351ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 22:42:13.9715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMRF+5S/UJzE9GPZM2dYm6br9zzqNDDkKo/+0zp7pdWy565lgSKkNwRu7bO6ruKmw/RJgp6JtrKE4nhhXu1Fxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2536
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMS0yNyAyMDoyOSwgUmFqbmVlc2ggQmhhcmR3YWogd3JvdGU6Cj4gRHVyaW5nIHN5
c3RlbSBzdXNwZW5kIHRoZSBrZmQgZHJpdmVyIGFxdWlyZXMgYSBsb2NrIHRoYXQgcHJvaGliaXRz
Cj4gZnVydGhlciBrZmQgYWN0aW9ucyB1bmxlc3MgdGhlIGdwdSBpcyByZXN1bWVkLiBUaGlzIGFk
ZHMgc29tZSBpbmZvIHdoaWNoCj4gY2FuIGJlIHVzZWZ1bCB3aGlsZSBkZWJ1Z2dpbmcuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBSYWpuZWVzaCBCaGFyZHdhaiA8cmFqbmVlc2guYmhhcmR3YWpAYW1kLmNv
bT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCAy
ICsrCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKPiBpbmRleCAxYWViZGE0YmJiZTcuLjA4MWNjNWY0
MGQxOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRl
di5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+IEBA
IC0xMjcsNiArMTI3LDggQEAgc3RhdGljIGludCBrZmRfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBzdHJ1Y3QgZmlsZSAqZmlsZXApCj4gICAJCXJldHVybiBQVFJfRVJSKHByb2Nlc3MpOwo+ICAg
Cj4gICAJaWYgKGtmZF9pc19sb2NrZWQoKSkgewo+ICsJCWRldl93YXJuKGtmZF9kZXZpY2UsICJr
ZmQgaXMgbG9ja2VkIVxuIgo+ICsJCQkJInByb2Nlc3MgJWQgdW5yZWZlcmVuY2VkIiwgcHJvY2Vz
cy0+cGFzaWQpOwoKSWYgdGhpcyBpcyBmb3IgZGVidWdnaW5nLCBtYWtlIGl0IGRldl9kYmcuIFBy
aW50aW5nIHdhcm5pbmdzIGxpa2UgdGhpcyAKdXN1YWxseSBjb25mdXNlcyBwZW9wbGUgcmVwb3J0
aW5nIGNvbXBsZXRlbHkgdW5yZWxhdGVkIHByb2JsZW1zIHRoYXQgCmFyZW4ndCBldmVuIGtlcm5l
bCBwcm9ibGVtcyBhdCBhbGwuICJMb29rLCBJIGZvdW5kIGEgd2FybmluZyBpbiB0aGUgCmtlcm5l
bCBsb2cuIEl0IG11c3QgYmUgYSBrZXJuZWwgcHJvYmxlbS4iCgpSZWdhcmRzLAogwqAgRmVsaXgK
Cgo+ICAgCQlrZmRfdW5yZWZfcHJvY2Vzcyhwcm9jZXNzKTsKPiAgIAkJcmV0dXJuIC1FQUdBSU47
Cj4gICAJfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
