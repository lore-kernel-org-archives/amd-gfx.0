Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45750C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 00:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F067421835
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 00:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sTOC0OuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F067421835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD0996E446;
	Tue, 14 Jul 2020 00:44:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFE46E446
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 00:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVcL+/jNF693rlhr895GNyxQ+ZTq0E71au1J8XCjeqJHbn1BSlb+thi8M71Vwf5hjY+js9K4gwnHxO119IW5aToAfWm2ey+5IRBJE2S0EGgr3nRsbhbKVxyd5YaA2eH+bIManplmEBDoprUR97mCKv99OvAM9V0l/jfXsMBzkqSGWyNHKp5JWV8ggCqft3QGjlb3yj745LE5JP+CcCtJPz8lT1Wg0z0C+332xeS3EwAwC6/dplvPRb3MFjhBGQx+czyMxPqGkSVR4GL6CIFrAAFbj26P7hyr3n9e8S4m7Evm/0jt7a2joIzNAYYy0alI/5Q0u8qYzoFI4kQuZJgy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rEIXcsk5sCnbvR1nkH3cPhzJWOTILyAXSYxKpcNnE0=;
 b=Pa0UCeDW8SA3399CYe7kZWzM8AhqwSQaM1S5wckTyMik7TI3+6b0DWqT939VxAFSZurbxKu3HH9UjPKsgcRBA4K/F/tmMF0yhIZP0x2gEQzqcnWadKrbW81vt6g5JtqUnduZFf5rL3GGd0GMyN7i0/SwVjyO8sQnlMlh2PzbeeLJQoG65wpCwTtxeS9IOylikBYtJ4zSfWBo+PanRFzKmw9isL+fXb8jKSb8eHiG77F+8KZMuLlzTZQlPZOB2cJw2PpYO5X4pIeKLbMgObuYwUBGMORuUeWcRLfJaMcZ154mB/+lHMZ+yvUu/3iMwHHy2P0+q5pjqePyCQg+1B2m3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rEIXcsk5sCnbvR1nkH3cPhzJWOTILyAXSYxKpcNnE0=;
 b=sTOC0OuWXA9CI8eoNw52+Y+tJ3cube3/gz+U5aYddG6gzgE+RZaH0+jivmWf+SqXLmIIC2ntpyuMUCe0b9RlzgVmjvNJqoJLIeYX3EXXXsom0nh/Jlr20/Ngr2iDkqey4ecy4R+vD4pI7gET+p67/Z4+18w60kqL26iGrRqkyCc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM5PR12MB1675.namprd12.prod.outlook.com (2603:10b6:4:5::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Tue, 14 Jul 2020 00:44:07 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::9c20:aa3e:1b50:7ce5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::9c20:aa3e:1b50:7ce5%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 00:44:07 +0000
To: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Failed to find memory space for buffer eviction
Message-ID: <9f1607ce-3f40-41f5-662f-501434625773@amd.com>
Date: Mon, 13 Jul 2020 20:44:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Language: en-US
X-ClientProxiedBy: QB1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::38) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.53.25) by
 QB1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 00:44:07 +0000
X-Originating-IP: [142.117.53.25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 080f2220-52d6-47e7-2c69-08d8278f0414
X-MS-TrafficTypeDiagnostic: DM5PR12MB1675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1675305BFA94502F4C33EA7A92610@DM5PR12MB1675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBfti2sE6qYFQmfDkf9FtbyeO+9x4i9dhL3azoDks5A6KkkhvkAtd8gIMkajCrBy33kDoK1cv0E7FfeRLrnwZwczyvjQJsclamVoCj5HgxjIC+sr8t6HJZHYX/wZj07u/9lse2uxpJ9AZjR+OzSoRf/F7JYE9MUiE8MR+QgDBjIhuGWi2wFxjoBQtxprIZWOFxPHkMv3SoTT7wZdVYAlGW9V1VKqxrzCHnquYD0KB0soP55hUyOfj5h3RFka4gpApDUY8OyuoxoOfFVxck6cllsBsE2JRo+c7JQvw4OR/ahYatRv3pePizqLyPv3GxBzZQU0owshuyNNXLXmgJBpdcll7/vDcNAl1aWa3bNEfFj5gTIDolIF0XhiEBS4Wzd2BZRjTq8WWpiCdf3FUektXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(6666004)(316002)(66946007)(16576012)(66556008)(86362001)(52116002)(66476007)(5660300002)(36756003)(2616005)(8676002)(8936002)(956004)(31696002)(6636002)(6486002)(31686004)(26005)(110136005)(44832011)(2906002)(478600001)(16526019)(186003)(37363001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eXVPM7VjpRoBkpxEDGERwUBxhFB1t0wvH26FomyjdpUNj2uFTDHTaCKybJdsOfhRjT0hd98xFrm5xjkZxj//1KABBDZZ2C9X9bJlEnEk/c2/siSh3jyAIlHUBDmIVNsMlJzudQQQm3Iw64V0yr2LAjpPwN5lcBgW0CIcPdfQbroPrNOvhamk45tyLaX8Kie60l/UkEeTzbBpM4iOgDC2rh6BrYkQEyURPHQZirbyG2nhfPfpQY87tV7iNPzDBvUEcqonMTSpMx0d68mQCTz/yApp5UK5+L1iXabf8fLz+6uBnpla5zoOVR92zBabalKLY3XDxZYM3mYQ5b0QaToSbGd1FiWnZlcbg7gCnlSkH1xYvQsB4xA+6QvHZTUOaNR6T/DY7jV1inov86Y+3PisTM5oOGdcmJzotNwhVx59zZl3iS7XVRxmPgnaQ4JJOLigGIYmaFlmwTzrtbnLySZFwR3My6x3TOZj4UfuuiavW38OAex5MVLdJGFN/hvGKzfx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080f2220-52d6-47e7-2c69-08d8278f0414
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 00:44:07.6631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKRAEUKo6S+AD7LzQ701R4xP1GvLVJoyHBhWuimj1Q2tQw9KVqEO2AeJg8+jfk13YvruCb3IdrtDBx+yDgOx6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSdtIHJ1bm5pbmcgaW50byB0aGlzIHByb2JsZW0gd2l0aCB0aGUgS0ZEIEV2aWN0aW9uVGVzdC4g
VGhlIGxvZyBzbmlwcGV0CmJlbG93IGxvb2tzIGxpa2UgaXQgcmFuIG91dCBvZiBHVFQgc3BhY2Ug
Zm9yIHRoZSBldmljdGlvbiBvZiBhIDY0TUIKYnVmZmVyLiBCdXQgdGhlbiBpdCBkdW1wcyB0aGUg
dXNlZCBhbmQgZnJlZSBzcGFjZSBhbmQgc2hvd3MgcGxlbnR5IG9mCmZyZWUgc3BhY2UuCgpBcyBJ
IHVuZGVyc3RhbmQgaXQsIHRoZSBwZXItcGFnZSBicmVha2Rvd24gb2YgdXNlZCBhbmQgZnJlZSBz
cGFjZSBzaG93bgpieSBUVE0gaXMgdGhlIEdBUlQgc3BhY2UuIFNvIGl0J3Mgbm90IHZlcnkgbWVh
bmluZ2Z1bC4KCldoYXQgbWF0dGVycyBtb3JlIGlzIHRoZSBHVFQgc3BhY2UgbWFuYWdlZCBieSBh
bWRncHVfZ3R0X21nci5jLiBBbmQKdGhhdCdzIHdoZXJlIHRoZSBwcm9ibGVtIGlzLiBJdCBrZWVw
cyB0cmFjayBvZiBhdmFpbGFibGUgR1RUIHNwYWNlIHdpdGgKYW4gYXRvbWljIGNvdW50ZXIgaW4g
YW1kZ3B1X2d0dF9tZ3IuYXZhaWxhYmxlLiBJdCBnZXRzIGRlY3JlbWVudGVkIGluCmFtZGdwdV9n
dHRfbWdyX25ldyBhbmQgaW5jcmVtZW50ZWQgaW4gYW1kZ3B1X2d0dF9tZ3JfZGVsLiBUaGUgdHJv
dWJsZQppcywgdGhhdCBUVE0gZG9lc24ndCBjYWxsIHRoZSBsYXR0ZXIgZm9yIHR0bV9tZW1fcmVn
cyB0aGF0IGRvbid0IGhhdmUgYW4KbW1fbm9kZToKCj4gdm9pZCB0dG1fYm9fbWVtX3B1dChzdHJ1
Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLCBzdHJ1Y3QgdHRtX21lbV9yZWcgKm1lbSkKPiB7Cj4g
wqDCoMKgwqDCoMKgwqAgc3RydWN0IHR0bV9tZW1fdHlwZV9tYW5hZ2VyICptYW4gPSAmYm8tPmJk
ZXYtPm1hblttZW0tPm1lbV90eXBlXTsKPgo+IMKgwqDCoMKgwqDCoMKgIGlmIChtZW0tPm1tX25v
ZGUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgqbWFuLT5mdW5jLT5wdXRfbm9k
ZSkobWFuLCBtZW0pOwo+IH0KR1RUIEJPcyB0aGF0IGRvbid0IGhhdmUgR0FSVCBzcGFjZSBhbGxv
Y2F0ZWQsIGRvbid0IGhhdGUgYW4gbW1fbm9kZS4gU28KdGhlIGFtZGdwdV9ndHRfbWdyLmF2YWls
YWJsZSBjb3VudGVyIGRvZXNuJ3QgZ2V0IGluY3JlbWVudGVkIHdoZW4gYW4KdW5tYXBwZWQgR1RU
IEJPIGlzIGZyZWVkLCBhbmQgZXZlbnR1YWxseSBydW5zIG91dCBvZiBzcGFjZS4KCk5vdyBJIGtu
b3cgd2hhdCB0aGUgcHJvYmxlbSBpcywgYnV0IEkgZG9uJ3Qga25vdyBob3cgdG8gZml4IGl0LiBN
YXliZSBhCmR1bW15LW1tX25vZGUgZm9yIHVubWFwcGVkIEdUVCBCT3MsIHRvIHRyaWNrIFRUTSBp
bnRvIGNhbGxpbmcgb3VyCnB1dF9ub2RlIGNhbGxiYWNrPyBPciBhIGNoYW5nZSBpbiBUVE0gdG8g
Y2FsbCBwdXRfbm9kZSB1bmNvbmRpdGlvbmFsbHk/CgpSZWdhcmRzLArCoCBGZWxpeAoKClvCoCAz
NjAuMDgyNTUyXSBbVFRNXSBGYWlsZWQgdG8gZmluZCBtZW1vcnkgc3BhY2UgZm9yIGJ1ZmZlcgow
eDAwMDAwMDAwMjY0YzgyM2MgZXZpY3Rpb24KW8KgIDM2MC4wOTAzMzFdIFtUVE1dwqAgTm8gc3Bh
Y2UgZm9yIDAwMDAwMDAwMjY0YzgyM2MgKDE2Mzg0IHBhZ2VzLAo2NTUzNkssIDY0TSkKW8KgIDM2
MC4wOTAzMzRdIFtUVE1dwqDCoMKgIHBsYWNlbWVudFswXT0weDAwMDEwMDAyICgxKQpbwqAgMzYw
LjA5MDMzNl0gW1RUTV3CoMKgwqDCoMKgIGhhc190eXBlOiAxClvCoCAzNjAuMDkwMzM3XSBbVFRN
XcKgwqDCoMKgwqAgdXNlX3R5cGU6IDEKW8KgIDM2MC4wOTAzMzldIFtUVE1dwqDCoMKgwqDCoCBm
bGFnczogMHgwMDAwMDAwQQpbwqAgMzYwLjA5MDM0MV0gW1RUTV3CoMKgwqDCoMKgIGdwdV9vZmZz
ZXQ6IDB4RkYwMDAwMDAwMApbwqAgMzYwLjA5MDM0Ml0gW1RUTV3CoMKgwqDCoMKgIHNpemU6IDEw
NDg1NzYKW8KgIDM2MC4wOTAzNDRdIFtUVE1dwqDCoMKgwqDCoCBhdmFpbGFibGVfY2FjaGluZzog
MHgwMDA3MDAwMApbwqAgMzYwLjA5MDM0Nl0gW1RUTV3CoMKgwqDCoMKgIGRlZmF1bHRfY2FjaGlu
ZzogMHgwMDAxMDAwMApbwqAgMzYwLjA5MDM0OV0gW1RUTV3CoCAweDAwMDAwMDAwMDAwMDA0MDAt
MHgwMDAwMDAwMDAwMDAwNDAyOiAyOiB1c2VkClvCoCAzNjAuMDkwMzUyXSBbVFRNXcKgIDB4MDAw
MDAwMDAwMDAwMDQwMi0weDAwMDAwMDAwMDAwMDA0MDQ6IDI6IHVzZWQKW8KgIDM2MC4wOTAzNTRd
IFtUVE1dwqAgMHgwMDAwMDAwMDAwMDAwNDA0LTB4MDAwMDAwMDAwMDAwMDQwNjogMjogdXNlZApb
wqAgMzYwLjA5MDM1NV0gW1RUTV3CoCAweDAwMDAwMDAwMDAwMDA0MDYtMHgwMDAwMDAwMDAwMDAw
NDA4OiAyOiB1c2VkClvCoCAzNjAuMDkwMzU3XSBbVFRNXcKgIDB4MDAwMDAwMDAwMDAwMDQwOC0w
eDAwMDAwMDAwMDAwMDA0MGE6IDI6IHVzZWQKW8KgIDM2MC4wOTAzNTldIFtUVE1dwqAgMHgwMDAw
MDAwMDAwMDAwNDBhLTB4MDAwMDAwMDAwMDAwMDQwYzogMjogdXNlZApbwqAgMzYwLjA5MDM2MV0g
W1RUTV3CoCAweDAwMDAwMDAwMDAwMDA0MGMtMHgwMDAwMDAwMDAwMDAwNDBlOiAyOiB1c2VkClvC
oCAzNjAuMDkwMzYzXSBbVFRNXcKgIDB4MDAwMDAwMDAwMDAwMDQwZS0weDAwMDAwMDAwMDAwMDA0
MTA6IDI6IHVzZWQKW8KgIDM2MC4wOTAzNjVdIFtUVE1dwqAgMHgwMDAwMDAwMDAwMDAwNDEwLTB4
MDAwMDAwMDAwMDAwMDQxMjogMjogdXNlZApbwqAgMzYwLjA5MDM2N10gW1RUTV3CoCAweDAwMDAw
MDAwMDAwMDA0MTItMHgwMDAwMDAwMDAwMDAwNDE0OiAyOiB1c2VkClvCoCAzNjAuMDkwMzY4XSBb
VFRNXcKgIDB4MDAwMDAwMDAwMDAwMDQxNC0weDAwMDAwMDAwMDAwMDA0MTU6IDE6IHVzZWQKW8Kg
IDM2MC4wOTAzNzBdIFtUVE1dwqAgMHgwMDAwMDAwMDAwMDAwNDE1LTB4MDAwMDAwMDAwMDAwMDUx
NTogMjU2OiB1c2VkClvCoCAzNjAuMDkwMzcyXSBbVFRNXcKgIDB4MDAwMDAwMDAwMDAwMDUxNS0w
eDAwMDAwMDAwMDAwMDA1MTY6IDE6IHVzZWQKW8KgIDM2MC4wOTAzNzRdIFtUVE1dwqAgMHgwMDAw
MDAwMDAwMDAwNTE2LTB4MDAwMDAwMDAwMDAwMDUxNzogMTogdXNlZApbwqAgMzYwLjA5MDM3Nl0g
W1RUTV3CoCAweDAwMDAwMDAwMDAwMDA1MTctMHgwMDAwMDAwMDAwMDAwNTE4OiAxOiB1c2VkClvC
oCAzNjAuMDkwMzc4XSBbVFRNXcKgIDB4MDAwMDAwMDAwMDAwMDUxOC0weDAwMDAwMDAwMDAwMDA1
MTk6IDE6IHVzZWQKW8KgIDM2MC4wOTAzNzldIFtUVE1dwqAgMHgwMDAwMDAwMDAwMDAwNTE5LTB4
MDAwMDAwMDAwMDAwMDUxYTogMTogdXNlZApbwqAgMzYwLjA5MDM4MV0gW1RUTV3CoCAweDAwMDAw
MDAwMDAwMDA1MWEtMHgwMDAwMDAwMDAwMDAwNTFiOiAxOiB1c2VkClvCoCAzNjAuMDkwMzgzXSBb
VFRNXcKgIDB4MDAwMDAwMDAwMDAwMDUxYi0weDAwMDAwMDAwMDAwMDA1MWM6IDE6IHVzZWQKW8Kg
IDM2MC4wOTAzODVdIFtUVE1dwqAgMHgwMDAwMDAwMDAwMDAwNTFjLTB4MDAwMDAwMDAwMDAwMDUx
ZDogMTogdXNlZApbwqAgMzYwLjA5MDM4N10gW1RUTV3CoCAweDAwMDAwMDAwMDAwMDA1MWQtMHgw
MDAwMDAwMDAwMDAwNTFmOiAyOiB1c2VkClvCoCAzNjAuMDkwMzg5XSBbVFRNXcKgIDB4MDAwMDAw
MDAwMDAwMDUxZi0weDAwMDAwMDAwMDAwMDA1MjE6IDI6IHVzZWQKW8KgIDM2MC4wOTAzOTFdIFtU
VE1dwqAgMHgwMDAwMDAwMDAwMDAwNTIxLTB4MDAwMDAwMDAwMDAwMDUyMjogMTogdXNlZApbwqAg
MzYwLjA5MDM5Ml0gW1RUTV3CoCAweDAwMDAwMDAwMDAwMDA1MjItMHgwMDAwMDAwMDAwMDAwNTIz
OiAxOiB1c2VkClvCoCAzNjAuMDkwMzk0XSBbVFRNXcKgIDB4MDAwMDAwMDAwMDAwMDUyMy0weDAw
MDAwMDAwMDAwMDA1MjQ6IDE6IHVzZWQKW8KgIDM2MC4wOTAzOTZdIFtUVE1dwqAgMHgwMDAwMDAw
MDAwMDAwNTI0LTB4MDAwMDAwMDAwMDAwMDUyNTogMTogdXNlZApbwqAgMzYwLjA5MDM5OF0gW1RU
TV3CoCAweDAwMDAwMDAwMDAwMDA1MjUtMHgwMDAwMDAwMDAwMDAwNjI1OiAyNTY6IHVzZWQKW8Kg
IDM2MC4wOTA0MDBdIFtUVE1dwqAgMHgwMDAwMDAwMDAwMDAwNjI1LTB4MDAwMDAwMDAwMDAwMDcy
NTogMjU2OiB1c2VkClvCoCAzNjAuMDkwNDAyXSBbVFRNXcKgIDB4MDAwMDAwMDAwMDAwMDcyNS0w
eDAwMDAwMDAwMDAwMDA3Mjc6IDI6IHVzZWQKW8KgIDM2MC4wOTA0MDRdIFtUVE1dwqAgMHgwMDAw
MDAwMDAwMDAwNzI3LTB4MDAwMDAwMDAwMDAwMDdjMDogMTUzOiB1c2VkClvCoCAzNjAuMDkwNDA2
XSBbVFRNXcKgIDB4MDAwMDAwMDAwMDAwMDdjMC0weDAwMDAwMDAwMDAwMDBiOGE6IDk3MDogdXNl
ZApbwqAgMzYwLjA5MDQwN10gW1RUTV3CoCAweDAwMDAwMDAwMDAwMDBiOGEtMHgwMDAwMDAwMDAw
MDAwYjhiOiAxOiB1c2VkClvCoCAzNjAuMDkwNDA5XSBbVFRNXcKgIDB4MDAwMDAwMDAwMDAwMGI4
Yi0weDAwMDAwMDAwMDAwMDBiY2I6IDY0OiB1c2VkClvCoCAzNjAuMDkwNDExXSBbVFRNXcKgIDB4
MDAwMDAwMDAwMDAwMGJjYi0weDAwMDAwMDAwMDAwMDBiY2Q6IDI6IHVzZWQKW8KgIDM2MC4wOTA0
MTNdIFtUVE1dwqAgMHgwMDAwMDAwMDAwMDAwYmNkLTB4MDAwMDAwMDAwMDA0MDAwMDogMjU5MTIz
OiBmcmVlClvCoCAzNjAuMDkwNDE1XSBbVFRNXcKgIHRvdGFsOiAyNjExMjAsIHVzZWQgMTk5NyBm
cmVlIDI1OTEyMwpbwqAgMzYwLjA5MDQxN10gW1RUTV3CoCBtYW4gc2l6ZToxMDQ4NTc2IHBhZ2Vz
LCBndHQgYXZhaWxhYmxlOjE0MzcxIHBhZ2VzLAp1c2FnZTo0MDM5TUIKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
