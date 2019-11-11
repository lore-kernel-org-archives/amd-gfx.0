Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DDFC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F7B20659
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 20:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F7B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE05F6E2DA;
	Mon, 11 Nov 2019 20:38:07 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820074.outbound.protection.outlook.com [40.107.82.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA3D6E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 20:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3RUl3kHr1OMSZtO06hlK+knkMS89g/jHqzderFCNXb9uGvuIJcbVGEQjwHaayK3+RZy3wOH/HI3jpFVC99LA3Hv2f+z5IFtZMMWKM0LDLHR0UbGhSmo7qjEBcfDYyPKkdxc+nDUZ5MTCxPgEiNLR3qXG174pT2b4Bxuwzv79EAydboxJ24Q6SqsUL/4EFG54taPhe9285qpiKeiaxRiit5fhjYVKprWuMSpC+Sm9JhNepmlru9UXq0w3du+1oH0F4yna3RStBdlxHLfDfo1BiS6odA9MnRPTJm7s0jX+B9g7+f2FxXxR1A+nXUBjqPIHfTWtpVqI+l4uMHrudzZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2ZTJ/8ln5fd508ugjgm2/Gbn/SxZX4N69UZE2loaIY=;
 b=YGm+dm2+a9tD9fn3FU2My7p3BwG6TND8dQ5MX2xuJTWi0ZAVdg6nvvU+Zc2P6gDyWgU5R62sjLKjRow5JZKcLSv0DzQZNB/EWo1dVrjSy4Dvx3J82YQfhoz+8mQWeNH9gFdVqUAfR2njtirsRtHShXV6YNTr4FowB+4zu2oXhBAqouGCNWS7AXKzTZu1rzaFicGDi/xj08oA/Ep8MhBlX0D5oK1KAPTY2WXIZb33op/Kwzm/DCIzAxmd/ZP3N9tGJcDBUy9VHytUFcXa6sf2ZykzNzsy5Ho5iKd5I89QgeMbrEaVj10Z7ikGEni8YzZE2dTNeM5ualtmiyqk0fx7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0055.namprd12.prod.outlook.com (10.172.77.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 20:38:05 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 20:38:05 +0000
Subject: Re: [PATCH 00/14] HDCP 2 Content Protection v2
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <09579fab-e12a-161b-fd92-74c4c4bb182f@amd.com>
Date: Mon, 11 Nov 2019 15:38:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::34) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 311b1745-824f-41ba-dd3f-08d766e70d78
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0055C0B60DF308BDCBE7FBBA8C740@CY4PR1201MB0055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(66946007)(2906002)(6436002)(8936002)(81156014)(81166006)(229853002)(66556008)(6486002)(66476007)(316002)(8676002)(6116002)(3846002)(99286004)(58126008)(6246003)(50466002)(5660300002)(66066001)(65956001)(31686004)(6666004)(14454004)(478600001)(52116002)(2486003)(23676004)(47776003)(76176011)(6512007)(4326008)(65806001)(14444005)(25786009)(11346002)(446003)(36756003)(31696002)(305945005)(486006)(7736002)(476003)(186003)(2616005)(2870700001)(26005)(6506007)(53546011)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0055;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lgwEsrRjseiVYPj8VHgnnRmVLJoCIY4kdwX/l2yCO1QedFyBNQQBbbqgUXY8t8jedcLexGecakmNQAEKDrx11SkFXnHGGtsZ3Mn8HrqFMAEd02El6Bhn+w5WimeXM158fYDJNNbnENlZByA9dW87hyGgA3WRbnd8wf42bZHvktjhk68tCjivPVDFaMggKQ753BO+zwa0mZ13i/VP/VaagIrgWj6ShC0RBNkCS2wbz7HN6zWS040kWy9NjNC5sMcBf16VCKW0Q8pF0dFgqdnGYoJD/Aa4kZiVQ62G9cPgph7MpZVwCzEZKgaPMI2wq9zt1oP+y+2lBAMoT57NZTDSIrik10pjcpiwyz4OSH376Nravvq+OjtI9hkRIaZTBpKbXZuvrrGKBPO5EXzhy7qwbZpBu9ee0Pxt52gKe2p3NZVqERmdjYTymWnrRNA1V0aC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311b1745-824f-41ba-dd3f-08d766e70d78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 20:38:04.9866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuCP0IHYpUHl+rTLgKItOReEmTEPQJueeCq+SqJO3JtYa/MVi3xzGQw8GZzN5yF/BW1lBgRSoLib9ITXeRa3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0055
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2ZTJ/8ln5fd508ugjgm2/Gbn/SxZX4N69UZE2loaIY=;
 b=fPWFf5HXLmMtBo1amL3eeTxbAVyEuX7CauB1yZyuCe04uzqMAxm0plWzEZzHeH3fowc5WqMmz4Lm+kmxPtPiGfVhazAH2nTAUX9+u7X9qXWryar8vtTzc08GG3/uo23zZYtKW0Mk3rjTfZG4sWoL9PaFTX/jP+Q4yRhwZnxfhEs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
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
Cc: Wenjing.Liu@amd.com, harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111203802.OTY0sWGD1VzAWvQ2UtPErhcFRpOYt7xKSUCVMkqddzg@z>

T24gMjAxOS0xMS0wNyAxMDo1NiBhLm0uLCBCaGF3YW5wcmVldCBMYWtoYSB3cm90ZToKPiBKdXN0
IGxpa2Ugd2l0aCB0aGUgMS40IHNlcmllcyBvZiBwYXRjaGVzIFRoaXMgb25seSBpbnRyb2R1Y2Vz
IHRoZQo+IGFiaWxpdHkgdG8gYXV0aGVudGljYXRlIGFuZCBlbmNyeXB0IHRoZSBsaW5rLiBUaGVz
ZSBwYXRjaGVzIGJ5Cj4gdGhlbXNlbHZlcyBkb24ndCBjb25zdGl0dXRlIGEgY29tcGxldGUgYW5k
IGNvbXBsaWFudCBIRENQIGNvbnRlbnQKPiBwcm90ZWN0aW9uIHNvbHV0aW9uIGJ1dCBhcmUgYSBy
ZXF1aXJlbWVudCBmb3Igc3VjaCBhIHNvbHV0aW9uLgo+IAo+IFN1bW1hcnkgb2YgdGhlIGNoYW5n
ZXMKPiAqQWRkcyAyLjIgY29kZSB0byB0aGUgbW9kdWxlCj4gKkVuYWJsZWQgSERDUCAyLjIgYXV0
aGVudGljYXRpb24vZW5jcnlwdGlvbgo+ICpBZGQgdHlwZTAvMSBzZWxlY3Rpb24gZm9yIDIuMgo+
ICpBZGQgTVNUIHN1cHBvcnQgKE9ubHkgdGVzdGVkIHNpbmdsZSBkYWlzeSBjaGFpbiB1c2VjYXNl
KQo+ICp1c2UgZHJtX2hkY3AuaCBmb3IgbWFjcm9zL2RlZmluZXMKPiAqZml4IHN0YXRpYyBhbmFs
eXNpcyBidWcKPiAKPiB2MjoKPiAgIC11c2UgbWFjcm9zL2RlZmluZXMgZnJvbSBkcm1faGRjcC5o
Cj4gICAJZHJtL2FtZC9kaXNwbGF5OiBhZGQgYW5kIHVzZSBkZWZpbmVzIGZyb20gZHJtX2hkY3Au
aAo+IAlkcm0vYW1kL2Rpc3BsYXk6IHVzZSBkcm0gZGVmaW5lcyBmb3IgTUFYIENBU0NBREUgTUFT
Swo+IAlkcm0vYW1kL2Rpc3BsYXk6IHNwbGl0IHJ4c3RhdHVzIGZvciBoZG1pIGFuZCBkcAo+ICAg
LWZpeCBzdGF0aWMgYW5hbHlzaXMgYnVnCj4gCWRybS9hbWQvZGlzcGxheTogRml4IHN0YXRpYyBh
bmFseXNpcyBidWcgaW4gdmFsaWRhdGVfYmtzdgo+IAoKQ2hhbmdlcyBhcmUKUmV2aWV3ZWQtYnk6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoKSGFycnkKCj4gCj4gQmhh
d2FucHJlZXQgTGFraGEgKDE0KToKPiAgIGRybS9hbWQvZGlzcGxheTogQWRkIFBTUCBibG9jayB0
byB2ZXJpZnkgSERDUDIuMiBzdGVwcwo+ICAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgRERDIGhhbmRs
ZXMgZm9yIEhEQ1AyLjIKPiAgIGRybS9hbWQvZGlzcGxheTogQWRkIGV4ZWN1dGlvbiBhbmQgdHJh
bnNpdGlvbiBzdGF0ZXMgZm9yIEhEQ1AyLjIKPiAgIGRybS9hbWQvZGlzcGxheTogQWRkIGxvZ2dp
bmcgZm9yIEhEQ1AyLjIKPiAgIGRybS9hbWQvZGlzcGxheTogQ2hhbmdlIEVSUk9SIHRvIFdBUk4g
Zm9yIEhEQ1AgbW9kdWxlCj4gICBkcm0vYW1kL2Rpc3BsYXk6IEVuYWJsZSBIRENQIDIuMgo+ICAg
ZHJtL2FtZC9kaXNwbGF5OiBIYW5kbGUgaGRjcDIuMiB0eXBlMC8xIGluIGRtCj4gICBkcm0vYW1k
L2Rpc3BsYXk6IFJlZmFjdG9yIEhEQ1AgdG8gaGFuZGxlIG11bHRpcGxlIGRpc3BsYXlzIHBlciBs
aW5rCj4gICBkcm0vYW1kL2Rpc3BsYXk6IGFkZCBmb3JjZSBUeXBlMC8xIGZsYWcKPiAgIGRybS9h
bWQvZGlzcGxheTogUmVmYWN0b3IgSERDUCBlbmNyeXB0aW9uIHN0YXR1cyB1cGRhdGUKPiAgIGRy
bS9hbWQvZGlzcGxheTogYWRkIGFuZCB1c2UgZGVmaW5lcyBmcm9tIGRybV9oZGNwLmgKPiAgIGRy
bS9hbWQvZGlzcGxheTogdXNlIGRybSBkZWZpbmVzIGZvciBNQVggQ0FTQ0FERSBNQVNLCj4gICBk
cm0vYW1kL2Rpc3BsYXk6IHNwbGl0IHJ4c3RhdHVzIGZvciBoZG1pIGFuZCBkcAo+ICAgZHJtL2Ft
ZC9kaXNwbGF5OiBGaXggc3RhdGljIGFuYWx5c2lzIGJ1ZyBpbiB2YWxpZGF0ZV9ia3N2Cj4gCj4g
IC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8ICAyNiArLQo+
ICAuLi4vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNwLmMgICAgfCAgNjQgKy0K
PiAgLi4uL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5oICAgIHwgICA5ICst
Cj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9NYWtlZmlsZSB8ICAgMyAr
LQo+ICAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcC5jICAgfCAxMDEg
Ky0KPiAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3AuaCAgIHwgMTk3
ICsrKy0KPiAgLi4uL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3AxX2V4ZWN1dGlvbi5jICAgIHwg
IDQwICstCj4gIC4uLi9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwMl9leGVjdXRpb24uYyAgICB8
IDg4NCArKysrKysrKysrKysrKysrKysKPiAgLi4uL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3Ay
X3RyYW5zaXRpb24uYyAgIHwgNjc0ICsrKysrKysrKysrKysKPiAgLi4uL2RybS9hbWQvZGlzcGxh
eS9tb2R1bGVzL2hkY3AvaGRjcF9kZGMuYyAgIHwgMzI2ICsrKysrKysKPiAgLi4uL2RybS9hbWQv
ZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9sb2cuYyAgIHwgMTE4ICsrKwo+ICAuLi4vZHJtL2Ft
ZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX2xvZy5oICAgfCAgOTggKy0KPiAgLi4uL2RybS9h
bWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuYyAgIHwgNTExICsrKysrKysrKy0KPiAg
Li4uL2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9wc3AuaCAgIHwgMTk0ICsrKysK
PiAgLi4uL2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2luYy9tb2RfaGRjcC5oICAgIHwgIDE1ICst
Cj4gIDE1IGZpbGVzIGNoYW5nZWQsIDMxMzcgaW5zZXJ0aW9ucygrKSwgMTIzIGRlbGV0aW9ucygt
KQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVs
ZXMvaGRjcC9oZGNwMl9leGVjdXRpb24uYwo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwMl90cmFuc2l0aW9uLmMKPiAKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
