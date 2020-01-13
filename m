Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7348EC33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 18:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A7E214AF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 18:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iXww9b9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A7E214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572CE6E14A;
	Mon, 13 Jan 2020 18:57:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463786E14A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 18:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4M6XUvJIgsIFfiSafkjSiSH5PPh4198x9kiK6WrfEwtCP3MKICp2fJRjaZy0cZQc5XOkeivm2gPZztBzP6PK39cQV0PpYF4vYxUi48Jii3so1XpHavRkd26alhxROoCAYmK7OLa0+k/4TbOwOyp+avmxXYRCEbkNhKgR0q0XM55tPHOQvumPuOTH8GWfkdjHepzS/NWUVWvvbTGIXBfU8jW7msu798pn5bl+W1XEgG4U4tFSdkrR128x8aMkR/lb6OBg1kN9YdCvev5sILuC/GVD0D31CXkuQJSKNh5RGPYHTKYrbOt76zSLooR0W2/OBgDLYeFfRtpgvlr69kwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krBLSI44lR/pZg2r6qItXE49XU5Gvge9lWUod0JmbH8=;
 b=BAAr21fEQTWp3ekx53g9oz6wq8pkMAu7zl9gZ98ERV9qs4/rEye+N2JprTfbIcBUdIUvJovD2ENL2yXn3n1nCYMTbW+nhvQpXPgQBLuOdqg4EOWvN2M0Mj6/0O7tPWNYk0H/KksWWMnGe5WXzJi3VWIcLhE4TYMuukfrdMTOU2g+O+q2786mTRDcg43Idl+h3W3idWQbkVA0tdug0I2KPAiiyXVkJRKaQH97mhnf4ulE7TOZebQvOu6na9y1PPT7PAlxh+bbur9R3xeI4IifQZQlWKiWET4xoNPxUuxbhEO6isN0vwmR2FQQ2XdSwpara1lBf2R7F1t2JCCJCUcoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krBLSI44lR/pZg2r6qItXE49XU5Gvge9lWUod0JmbH8=;
 b=iXww9b9j8WmS8Vao86XYIK2WTWhtgdVx80hvKLhBJYFRR3vSu5uH962A/nbqKWLl8fWEWVqZD8PZTR8hDMrBnYYExiVpCCwT/BTdVinDcc1OHoujUvrgJEAoXzAHS6+ySciVEh6Eo5+tdsnnAOG6QUBgPJELfQsj4g5l8psofHg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0107.namprd12.prod.outlook.com (10.174.106.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 18:57:00 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 18:56:59 +0000
Subject: Re: [PATCH 1/8] drm/amdgpu: drop amdgpu_job.owner
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex.Sierra@amd.com, Philip.Yang@amd.com
References: <20200113144055.3416-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4706848a-1ade-1138-95cd-a7bd741414ec@amd.com>
Date: Mon, 13 Jan 2020 13:56:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200113144055.3416-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::16) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 18:56:49 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: caf06ba8-8c99-4583-84f1-08d7985a5963
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:|DM5PR1201MB0107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107A56ED06554255B99575092350@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(66476007)(2906002)(53546011)(31686004)(66946007)(66556008)(26005)(186003)(16526019)(44832011)(5660300002)(2616005)(31696002)(86362001)(956004)(6636002)(8936002)(36756003)(36916002)(52116002)(6486002)(81166006)(316002)(16576012)(478600001)(8676002)(81156014)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0107;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIm5XPt49f8VZBKqmaX9r8pwI61V4wdR1oqZZHvarDc0Y6/iqVWuDDrSHTkD/MUlTbROrmCsZ+UVLMmXyOG0SM6ajBaL3SUXizJQplrNIIDp8otUX8berYFZZ3LmQ171FlrmZr/3KW/4cu8gD960ucWw9CsrK3qgySggH/aQQS9oAzB88CaKUv8mr6fuTNdz/pz4RumxnWkxzfPmcgfx6ILwissZ77QgnMfwpLXnxKsCx2vhkbBFRvpfPJVkTgv0Wq+cG4F02MGbHco3QPmjE53m8rJ5B0cr9+LuUyh0a6DwhzlE0s4X6O6TAMdOg2ZcAxbEn4Y4V3PomrGv0fIX2O2oBRE6S2V1tNI3VosBHXBQVOLnCDI1SWn/ngzG8etYeCcMJe/3Uj8mwMVOcg5g1K6pWcw8+K9yGWj9v6zCKZDFIsESGtL2c098P34wu6UL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf06ba8-8c99-4583-84f1-08d7985a5963
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 18:56:59.7528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDqulaLq0gjSlPoM5rrAa0LstLUvM+DOaXCBlYtPJNLauSybEL63NCDUmzwIZTeh/hLTjmOQhPCOfzFyXX3a6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSByZXBsaWVkIHdpdGggb25lIHF1ZXN0aW9uIGFib3V0IHBhdGNoIDQuIE90aGVyIHRoYW4gdGhh
dCB0aGUgc2VyaWVzIGlzCgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+CgpPbiAyMDIwLTAxLTEzIDk6NDAgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3
cm90ZToKPiBFbnRpcmVseSB1bnVzZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3MuYyAgfCAxIC0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9qb2IuYyB8IDEgLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2pvYi5oIHwgMSAtCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+IGluZGV4IDYxNDkxOWYyNjViOS4u
YzRhODE0OGI5YjZmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMK
PiBAQCAtMTIzMyw3ICsxMjMzLDYgQEAgc3RhdGljIGludCBhbWRncHVfY3Nfc3VibWl0KHN0cnVj
dCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ICAgCQlnb3RvIGVycm9yX2Fib3J0Owo+ICAgCX0KPiAg
IAo+IC0Jam9iLT5vd25lciA9IHAtPmZpbHA7Cj4gICAJcC0+ZmVuY2UgPSBkbWFfZmVuY2VfZ2V0
KCZqb2ItPmJhc2Uuc19mZW5jZS0+ZmluaXNoZWQpOwo+ICAgCj4gICAJYW1kZ3B1X2N0eF9hZGRf
ZmVuY2UocC0+Y3R4LCBlbnRpdHksIHAtPmZlbmNlLCAmc2VxKTsKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4gaW5kZXggNzMzMjhkMGM3NDFkLi5kNDJiZTg4MGEyMzYg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4gQEAgLTE1Myw3
ICsxNTMsNiBAQCBpbnQgYW1kZ3B1X2pvYl9zdWJtaXQoc3RydWN0IGFtZGdwdV9qb2IgKmpvYiwg
c3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKPiAgIAlpZiAocikKPiAgIAkJcmV0dXJu
IHI7Cj4gICAKPiAtCWpvYi0+b3duZXIgPSBvd25lcjsKPiAgIAkqZiA9IGRtYV9mZW5jZV9nZXQo
JmpvYi0+YmFzZS5zX2ZlbmNlLT5maW5pc2hlZCk7Cj4gICAJYW1kZ3B1X2pvYl9mcmVlX3Jlc291
cmNlcyhqb2IpOwo+ICAgCXByaW9yaXR5ID0gam9iLT5iYXNlLnNfcHJpb3JpdHk7Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuaAo+IGluZGV4IGFhMGUzNzUwNjJmMi4uMzFj
NDQ0NGIwMjAzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9qb2IuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuaAo+
IEBAIC00OSw3ICs0OSw2IEBAIHN0cnVjdCBhbWRncHVfam9iIHsKPiAgIAl1aW50MzJfdAkJcHJl
YW1ibGVfc3RhdHVzOwo+ICAgCXVpbnQzMl90ICAgICAgICAgICAgICAgIHByZWVtcHRpb25fc3Rh
dHVzOwo+ICAgCXVpbnQzMl90CQludW1faWJzOwo+IC0Jdm9pZAkJCSpvd25lcjsKPiAgIAlib29s
ICAgICAgICAgICAgICAgICAgICB2bV9uZWVkc19mbHVzaDsKPiAgIAl1aW50NjRfdAkJdm1fcGRf
YWRkcjsKPiAgIAl1bnNpZ25lZAkJdm1pZDsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
