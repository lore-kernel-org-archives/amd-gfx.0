Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29ABC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE9120818
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE9120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5456E528;
	Tue, 12 Nov 2019 21:53:01 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690043.outbound.protection.outlook.com [40.107.69.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0369F6EBFC
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 21:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs1W57V5B3wi05yBUSS6ydqAP55ZnqD2yV3LEOwd+TwgnurFbgbVjzQ+T75XSz8RSls2UGG9bidpbYPq8lqXkoZrYQqgPbEvtWG4Cl+JRQzghWGwZCnpJhVDl8RU1G0HUisYhUhvn0VtUIzs1MmEzh58CDuLOFSsaN6c7rOtr7picUiPJq1IMSzEtArQ3ITPQppbZ5n4PG9m5FQV/FYpDJ1PkjS5PKwuTVWVveAHcqgj3wVzVNOoAN4wwdpH/9CJ7iRmpPgCOtZDUT3lPsDZS0Gg2+cjGf9sUBI8vm+5OSNow/r7T+DoKN+MvVZL6vFp4MzdFOVFehUNLLSPWZLAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6b7klyHwKp4tmyiluBtnARCR5sR1ts4gVsK+TDcvyM=;
 b=X8Bg8BUAdbZMpaLuZfz1+PlKbVJOj8HojW98uUoCkfIqA4xpY8C6gKkZY3iVng6Z8R6fjmqRf5bNKRq7JEHc0TlgYaoicEx8TN5R0PQ50PAj7qLrLO6EFg0nTTtaqHzCsxXOQY3fS1LJQBLEfw+moIF6PRB05TGN5dZzBx5YYB0lXumLzRfgC0HXj0Y09gim5q7WjQiQuKy0tAsfzaIpLbWS3j3sP7FYkFHluOoi0Sp4nrorDeyNgvsEuujqHEAK9V0+WXP5jrwB7P/l5KDMpa8cZUzQkxuaTyqeBWDyJiB71uRoIl4gsvF13kznaMb2ba7X2L338czJaEZgbGfWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3310.namprd12.prod.outlook.com (20.179.80.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 21:52:58 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 21:52:58 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: Update get_wave_state() for GFX10
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 Jay.Cornwall@amd.com
References: <20191111232521.10528-1-Yong.Zhao@amd.com>
 <20191111232521.10528-2-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <17259af0-575b-ff9f-2252-29dd9424664b@amd.com>
Date: Tue, 12 Nov 2019 16:52:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191111232521.10528-2-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::40) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76c49f1d-4670-4f0d-c09d-08d767baae41
X-MS-TrafficTypeDiagnostic: MN2PR12MB3310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3310E26C66BAA8AD2A774DEA92770@MN2PR12MB3310.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(31686004)(6512007)(99286004)(6246003)(66946007)(66476007)(6636002)(53546011)(58126008)(386003)(316002)(66556008)(26005)(14444005)(186003)(6506007)(65956001)(5660300002)(66066001)(65806001)(47776003)(50466002)(6436002)(478600001)(6116002)(3846002)(25786009)(14454004)(4001150100001)(6486002)(36756003)(2906002)(7736002)(76176011)(31696002)(2616005)(305945005)(36916002)(23676004)(52116002)(2486003)(229853002)(476003)(8936002)(11346002)(446003)(486006)(44832011)(81166006)(8676002)(81156014)(86362001)(2870700001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3310;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMC2ImFNo6syjhqZx7silhrLT9TcEKpf1J/K9L8PTRN7j3mLpbQ40qMh7xD88STw2drwsQfxV76akLrDpmkJfdR5G3FAXm2AF/IVN/JYVaWaSannxaW0JKJwIOVwKAO2JiWIb6y29/2WgOtG3MqpQ2KqfiVF0rSbLqxkjXCmBigbv+U9Yh//wgaxhK/O1UKTX+u26F461kHDYGFB6ldgpjGTUk2YFMlvpapHgcmP75EC5KGBk/pQX4S2+AbwjcpVH/R9hCdx7UnJdKsax5rqN5sYT478beysXcelrzXP5hEqP3xOHj5UBnj/X4GUu/LWwJyx3banbjcNntr+e20hqonnmZGlXA5CTGq5vZr7cz2YDmPz4er1lRHqbiS+uYvtBpMOdXZdTqrx0zTssjr4WrwBOvVtPZGM8FxuU78fD+enXZn7cPfgwoFMk2DqtfNu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c49f1d-4670-4f0d-c09d-08d767baae41
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 21:52:58.3276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBygO7LMSEG2TgNG7gCYU4g6F2UGuDiaREtofZX37e4/KsahdWOQj/JYPRoHd9t2H13fdyCTHWcHXAt1FXH7zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3310
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6b7klyHwKp4tmyiluBtnARCR5sR1ts4gVsK+TDcvyM=;
 b=UTh88qPlMDk7Wb6nPS7+EZ7/tZVjrEENp4oDdcEAfOvyXuNYZD+5xflD7oXkg+XZtJv/M2mU0g14vZzjCMLOzIbRDXLQSAAUtAJbzaE66GaxYSSseee0q5J6MUjX8HAs18k/mIHmZtHzQOHbhJ6Kg7/mOzYQ73h+qVj0UcOAUyI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112215257.O58kV02G4cTdEBvcErtAK_UNT7jUBs2PkK0s8XolEBY@z>

T24gMjAxOS0xMS0xMSA2OjI1IHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPiBHaXZlbiBjb250cm9s
IHN0YWNrIGlzIG5vdyBpbiB0aGUgdXNlcnNwYWNlIGNvbnRleHQgc2F2ZSByZXN0b3JlIGFyZWEK
PiBvbiBHRlgxMCwgdGhlIHNhbWUgYXMgR0ZYOCwgaXQgaXMgbm90IG5lZWRlZCB0byBjb3B5IGl0
IGJhY2sgdG8gdXNlcnNwYWNlLgo+Cj4gQ2hhbmdlLUlkOiBJMDYzZGRjMzAyNmVlZmE1NzcxM2Vj
NDdiNDY2YTkwZjliZjlkNDliOAo+IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFv
QGFtZC5jb20+ClBhdGNoZXMgMSBhbmQgMiBhcmUKClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGlu
ZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCgpQYXRjaCAzIHNob3VsZCBhcmd1YWJseSBub3Qg
YmUgcGFydCBvZiB0aGlzIHNlcmllcywgYmVjYXVzZSBpdCBkb2VzIG5vdCAKYWZmZWN0IEdGWHYx
MC4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jIHwgMTQgKysrKysrKysrLS0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCj4gaW5kZXggNDg4
NGNkNmM2NWNlLi45NTRkYzhhYzRmZjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCj4gQEAgLTI1MSwxOCArMjUxLDIyIEBAIHN0
YXRpYyBpbnQgZ2V0X3dhdmVfc3RhdGUoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgdm9pZCAqbXFk
LAo+ICAgewo+ICAgCXN0cnVjdCB2MTBfY29tcHV0ZV9tcWQgKm07Cj4gICAKPiAtCS8qIENvbnRy
b2wgc3RhY2sgaXMgbG9jYXRlZCBvbmUgcGFnZSBhZnRlciBNUUQuICovCj4gLQl2b2lkICptcWRf
Y3RsX3N0YWNrID0gKHZvaWQgKikoKHVpbnRwdHJfdCltcWQgKyBQQUdFX1NJWkUpOwo+IC0KPiAg
IAltID0gZ2V0X21xZChtcWQpOwo+ICAgCj4gKwkvKiBDb250cm9sIHN0YWNrIGlzIHdyaXR0ZW4g
YmFja3dhcmRzLCB3aGlsZSB3b3JrZ3JvdXAgY29udGV4dCBkYXRhCj4gKwkgKiBpcyB3cml0dGVu
IGZvcndhcmRzLiBCb3RoIHN0YXJ0cyBmcm9tIG0tPmNwX2hxZF9jbnRsX3N0YWNrX3NpemUuCj4g
KwkgKiBDdXJyZW50IHBvc2l0aW9uIGlzIGF0IG0tPmNwX2hxZF9jbnRsX3N0YWNrX29mZnNldCBh
bmQKPiArCSAqIG0tPmNwX2hxZF93Z19zdGF0ZV9vZmZzZXQsIHJlc3BlY3RpdmVseS4KPiArCSAq
Lwo+ICAgCSpjdGxfc3RhY2tfdXNlZF9zaXplID0gbS0+Y3BfaHFkX2NudGxfc3RhY2tfc2l6ZSAt
Cj4gICAJCW0tPmNwX2hxZF9jbnRsX3N0YWNrX29mZnNldDsKPiAgIAkqc2F2ZV9hcmVhX3VzZWRf
c2l6ZSA9IG0tPmNwX2hxZF93Z19zdGF0ZV9vZmZzZXQgLQo+ICAgCQltLT5jcF9ocWRfY250bF9z
dGFja19zaXplOwo+ICAgCj4gLQlpZiAoY29weV90b191c2VyKGN0bF9zdGFjaywgbXFkX2N0bF9z
dGFjaywgbS0+Y3BfaHFkX2NudGxfc3RhY2tfc2l6ZSkpCj4gLQkJcmV0dXJuIC1FRkFVTFQ7Cj4g
KwkvKiBDb250cm9sIHN0YWNrIGlzIG5vdCBjb3BpZWQgdG8gdXNlciBtb2RlIGZvciBHRlh2MTAg
YmVjYXVzZQo+ICsJICogaXQncyBwYXJ0IG9mIHRoZSBjb250ZXh0IHNhdmUgYXJlYSB0aGF0IGlz
IGFscmVhZHkKPiArCSAqIGFjY2Vzc2libGUgdG8gdXNlciBtb2RlCj4gKwkgKi8KPiAgIAo+ICAg
CXJldHVybiAwOwo+ICAgfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
