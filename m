Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C978EC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 15:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59D32084D
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 15:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59D32084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7BF6E150;
	Mon, 25 Nov 2019 15:42:16 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790041.outbound.protection.outlook.com [40.107.79.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF1A6E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 15:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaCRe70LXygtsSr993MqPDzCRjNSBqnffpmbbg3NMDC32VuQIiZfOW2Wdo+SjgUCUGPJdj+ZiRx1lGqJWGHP4KsNhb5uuGvYqXwfnXyleYH8NBxcDtdkPum0d4plvHHTZkK8k7mHSZB8ZBEEk/QXnjM+onmoP7jhgSoyXg4nVJN+ikUuCF2U1gFeXo3CPoTlGM6gPc5aCOZUWPfDwz9R+CSoNByJhpv1SwqRouuG/T0WaC/wOWzcieW8wJwLhxzePvuC9SvCDEHIGq0h04f9716Q5zbJmEd9aeeazZddOaUGtNzDdqkamAj4db7qOV0eXnZBrlL5P3iZcnr6AteNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4VCFAiqERvJmFP3xXcpwqBAcHWfCIBaEGgZfL3zCAQ=;
 b=jYtavRbv5YxgZ2frDovV6OfKlp3h6elD7TCPmtVDzXTmmJsp5C+hb/tcVItxJHbUiAqQLu1XpCmsmLitm5drI896hF1aMvE0k6VVEBoP+VwF8uMH/Vse58UrG2OlcudMluKno+W3onQo0EzpB2O2HdB/RcYRhLXbk1NUaSJqedLqJQJ55VepC9bNNYhuVbWpuDgKx1F73pLkh8p6aJrBPKrsyfaNCT8pvTMQuTUah7KmRb8ZdbwVvoevPnjS7YZFD+t7Yuzn/tbpbRlsWrdK84YHgBPRlgfMw/Sq1eMQYbvj3zDmweAhHlpfSRGDPmwZjLjIeQ7RIwCFxE1y2Xyd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3431.namprd12.prod.outlook.com (20.178.54.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 15:42:12 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 15:42:12 +0000
Subject: Re: [PATCH] drm/amd/display: Null check aconnector in
 event_property_validate
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20191125154024.21218-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <154c20c5-8fe2-b26b-aa5d-1ed1838998b4@amd.com>
Date: Mon, 25 Nov 2019 10:42:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191125154024.21218-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d5e6819-008d-49c5-9d2c-08d771be0a16
X-MS-TrafficTypeDiagnostic: BYAPR12MB3431:|BYAPR12MB3431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3431435D1D5B3B2BC488EDF1EC4A0@BYAPR12MB3431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(65956001)(66066001)(230700001)(6436002)(6116002)(3846002)(5660300002)(6246003)(2616005)(446003)(11346002)(99286004)(58126008)(36756003)(6486002)(2906002)(76176011)(498600001)(25786009)(4001150100001)(31686004)(2486003)(23676004)(6512007)(186003)(386003)(6506007)(31696002)(26005)(86362001)(53546011)(52116002)(7736002)(66556008)(66946007)(305945005)(66476007)(14444005)(81156014)(50466002)(8936002)(47776003)(229853002)(8676002)(81166006)(14454004)(65806001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3431;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uqoxid/90YatYCQbwjIcb/1aDvtwLcpKpY1bZjdIBasePRo1CPOPsQ+8HH91g3lJ2WcYDKVgqX1R+V9iw7KjPpAgmrN8TjWoEDy7lyVDr7/Vx/6h5kAJFqRh1th4OofS2EUKqPC5veJa/uJEiK03B1DpC98pxPEdMQtpUo4aGaK4nvfEV/17nIv0pQZIM7bugvnTPNu8B1HAHx94VXiT9Oswrm4dRL+tUvQzINrezneoeOOZO7waqmGKjoJXPTccbAedXqsGv8ZqSa8yRpQIPPZQ5XytqRbKbUyfvUE0dmFUhlr9QxjIsbcIAhQbnf6c3mcVrW2wtHoXRQU5x/qzRhUrFKN8cVUUDwUOVX8SVGhuV+TFx1jsCeMBoWj7YTj+UcLUJQbvX3faXAtt0qpsXKhYoeoEeWDPrn9zlsXgEXRLJ67Nn8lyRFvZ/ZoLj65a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5e6819-008d-49c5-9d2c-08d771be0a16
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 15:42:12.6431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJJXPnWVKMtnJf023gmVuw7sd4mz0gA8banXkSgS5Zdwt9kINHndCwbjLih1JbRami7K+ZJawWmaHsg4XcSKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4VCFAiqERvJmFP3xXcpwqBAcHWfCIBaEGgZfL3zCAQ=;
 b=Ne7UgYhynAs3zeWeBGKm5tEtRXC1gEoJRCQglV9V0YilGo6urKWHncf0CZ3aqPR7XQYz74eP8VrDcfYNl+jCEijub6ERHpYyUSV9VEj6Luc6MOJCdU8b22RSIrUbXGxXIcOQdLXgvNJmTPiuC0ylkyH1UtbknPnDpvA/7/GWO8M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Message-ID: <20191125154210.2QVdX2F9RjkKigHOr8iXl79V331prnDj8zgueByGwHY@z>

T24gMjAxOS0xMS0yNSAxMDo0MCBhLm0uLCBCaGF3YW5wcmVldCBMYWtoYSB3cm90ZToKPiBbV2h5
XQo+IHByZXZpb3VzbHkgZXZlbnRfcHJvcGVydHlfdmFsaWRhdGUgd2FzIG9ubHkgY2FsbGVkIGFm
dGVyIHdlIGVuYWJsZWQgdGhlIGRpc3BsYXkuCj4gQnV0IGFmdGVyICJSZWZhY3RvciBIRENQIHRv
IGhhbmRsZSBtdWx0aXBsZSBkaXNwbGF5cyBwZXIgbGluayIgdGhpcyBmdW5jdGlvbgo+IGNhbiBi
ZSBjYWxsZWQgYXQgYW55IHRpbWUuIEluIGNlcnRhaW4gY2FzZXMgd2UgZG9uJ3QgaGF2ZSBhIGFj
b25uZWN0b3IKPiAKPiBbSG93XQo+IE51bGwgY2hlY2sgYWNvbm5lY3RvciBhbmQgZXhpdCBlYXJs
eS4gVGhpcyBpcyBvayBiZWNhdXNlIHdlIG9ubHkgbmVlZCB0byBjaGVjayB0aGUKPiBFTkFCTEVE
LT5ERVNJUkVEIHRyYW5zaXRpb24gaWYgYSBjb25uZWN0b3IgZXhpc3RzLgo+IAo+IEZpeGVzIDpj
YzVkYWU5ZjYyODYgZHJtL2FtZC9kaXNwbGF5OiBSZWZhY3RvciBIRENQIHRvIGhhbmRsZSBtdWx0
aXBsZSBkaXNwbGF5cyBwZXIgbGluawoKVGhpcyBzaG91bGQgYmU6CgpGaXhlczogY2M1ZGFlOWY2
Mjg2ICgiZHJtL2FtZC9kaXNwbGF5OiBSZWZhY3RvciBIRENQIHRvIGhhbmRsZSBtdWx0aXBsZSAK
ZGlzcGxheXMgcGVyIGxpbmsiKQoKPiBTaWduZWQtb2ZmLWJ5OiBCaGF3YW5wcmVldCBMYWtoYSA8
Qmhhd2FucHJlZXQuTGFraGFAYW1kLmNvbT4KCldpdGggdGhhdCBmaXhlZCB0aGlzIGNoYW5nZSBp
czoKClJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2Fz
QGFtZC5jb20+CgpOaWNob2xhcyBLYXpsYXVza2FzCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5jIHwgMyArKysKPiAgIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5jCj4gaW5kZXggZjY4NjRh
NTE4OTFhLi5hZTMyOTMzNWRmY2MgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5jCj4gQEAgLTIyNSw2ICsyMjUs
OSBAQCBzdGF0aWMgdm9pZCBldmVudF9wcm9wZXJ0eV92YWxpZGF0ZShzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspCj4gICAJc3RydWN0IG1vZF9oZGNwX2Rpc3BsYXlfcXVlcnkgcXVlcnk7Cj4gICAJ
c3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFjb25uZWN0b3IgPSBoZGNwX3dvcmstPmFjb25u
ZWN0b3I7Cj4gICAKPiArCWlmICghYWNvbm5lY3RvcikKPiArCQlyZXR1cm47Cj4gKwo+ICAgCW11
dGV4X2xvY2soJmhkY3Bfd29yay0+bXV0ZXgpOwo+ICAgCj4gICAJcXVlcnkuZW5jcnlwdGlvbl9z
dGF0dXMgPSBNT0RfSERDUF9FTkNSWVBUSU9OX1NUQVRVU19IRENQX09GRjsKPiAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
