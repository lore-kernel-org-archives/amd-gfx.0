Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D777C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 21:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41CE20848
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 21:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IPuVftit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41CE20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793546E0D0;
	Fri, 10 Jan 2020 21:16:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB97A6E0D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 21:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsyMpVd2vSb77w94l6411V8KuMC6sJtLGBNr9zr1C/GF0STIHjYn6BjtSiMYJZJNcTvzN5tvAK9mz/h9NNTp7xSvQwkUQpnkOPA0PcFQ3E3qa4jHSW0jfb+OixL+SL/anOwSdiscjZu6vxCX3paa0hQ0/m4xQuWZxY8Tn6ra0WWJUkrA9mcCTlQz/IU7x6d8CfeYFiOwww7f+R7Y2rjlRgrxotkbyY6BE7eelMjEy1yeIA/TXTkDA2bdr9MQjOSGToLCJeViNlLZ8clY6MhZjbwqmgRSQMdP7v8qWLZGWLNsURXA1tVd9MC4vIjDfFo6yx69SEY3n6UvOvmj6jGHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SkmLhjOjOU8/sTqKKBzXl16nkLOVpYZFulQbLcYebo=;
 b=S0Y0lRn+1fTQsSro3qIJ/C2oxawoMs2q3wS1grC/V7eFeKscLofEX5zHuTtDqNTVwATxkVopeL9QYnQnRBU56TnEaLGilSYgjg+BPiZ05m4iiTWOWn9+kx5H8T/48SUNpw2JTDJRkkhaL6gIYMyvNwf8QavJv3y62bannUtQq/fLuYUeKh3Kx23USKAZ/H/OnB4zKaOGYCgQ24R+Z0vZL2+f2K/IBc/rUwFEKyqsFmw1NLaAxf3FpmwqtVplfQ8Pe+UNAQsex2NynKsBB7ipA9BxysUhQAxgm1MvQsIbhJJKkAFzhkPB1JyLd/WldAlIlkQ4yzdvuhZHTGikL+/1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SkmLhjOjOU8/sTqKKBzXl16nkLOVpYZFulQbLcYebo=;
 b=IPuVftituGj1hc8Se1/I2iW0Q19CXU3Q66yXa9m5GUZu80WwqLbUq3Y8yaUNfLJLtR6uOJ/HZlp/4yuQ/q0vxlpvQmOvXGNNJV45y6waTXCYy++FQXr9B2z8xJ/eeQPiSRY0WAmboqhC55XrvYn1Am/NIVYz4AjPk6jau83h/IU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0037.namprd12.prod.outlook.com (10.172.78.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Fri, 10 Jan 2020 21:16:44 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2602.016; Fri, 10 Jan 2020
 21:16:44 +0000
Subject: Re: [PATCH 39/43] drm/amd/display: Use udelay to avoid context switch
To: "Liu, Zhan" <Zhan.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
 <20200110144655.55845-40-Rodrigo.Siqueira@amd.com>
 <e5846131-ed59-2790-30c1-c44b19ad8914@gmail.com>
 <DM5PR1201MB25546012AE5DE4AB84B38BAD9E380@DM5PR1201MB2554.namprd12.prod.outlook.com>
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
Message-ID: <3b143333-21a8-6075-ae85-026180eae286@amd.com>
Date: Fri, 10 Jan 2020 16:16:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <DM5PR1201MB25546012AE5DE4AB84B38BAD9E380@DM5PR1201MB2554.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::44) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTBPR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10 via Frontend Transport; Fri, 10 Jan 2020 21:16:42 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab3fe8d0-0c71-48d3-9ca4-08d796126489
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0037:|CY4PR1201MB0037:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0037B4EBEEC02D877163BC518C380@CY4PR1201MB0037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(956004)(6486002)(31696002)(16526019)(66476007)(186003)(66946007)(66556008)(5660300002)(4326008)(478600001)(53546011)(110136005)(52116002)(54906003)(31686004)(36756003)(2906002)(2616005)(26005)(16576012)(81156014)(66574012)(316002)(8936002)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0037;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lp2lAaJF1PslxPnR7oRo4BTpFZKdL9X8YyjvwwC7xEUPHsraOA+aj5TINw40k/pDHi24Tb524KDcBUzASyJbd+OkPNdTI3WEb6mF3GvB7VKH4cDzJDOhtjyjAdEpV4YljILoQ3jPSRBERdwCvrgCacQaTxVMwQjPbGhEjbZDIyIKXN7xNqp7q14c0czwuEnbpdLiVfO2yd4DUUbShnTuTFrMdR7iz/eI6Bm/VnH4JZRs9jwBs3PI4Eq7MDzGt9zaMlL38vvo08mrVyxQOfkcYfUaDI+gpqvWVHHZfH7TfJkv8CxAwN6hObSkq6QzFTMKDKrQXWy6TdIQiq+RU0DAgu86G7uSQbBccsHP9W90SLl/L3R0TXvkhcWIlZvBbDJ7iy2Ztu2r6L4lx+PDXdpfR9TYymYsxzuftZmXTMaE9gQonIaodrPP/2e81zfvw9j3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3fe8d0-0c71-48d3-9ca4-08d796126489
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 21:16:44.0690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+bBbCdKs0aRr6t2VAwpjxdE1RFYG3CWF5/RSCItb4su8cH/pxEVP4il/2UWcL3o/NNhwpWXPV2Vyepmy/qYWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0037
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Tsai,
 Martin" <Martin.Tsai@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMS0xMCAxOjQ3IHAubS4sIExpdSwgWmhhbiB3cm90ZToKPiAKPiAKPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mCj4+IENocmlzdGlhbiBLw7ZuaWcKPj4g
U2VudDogMjAyMC9KYW51YXJ5LzEwLCBGcmlkYXkgMTA6MDIgQU0KPj4gVG86IFNpcXVlaXJhLCBS
b2RyaWdvIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyBhbWQtCj4+IGdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPj4gQ2M6IExpLCBTdW4gcGVuZyAoTGVvKSA8U3VucGVuZy5MaUBhbWQuY29t
PjsgQ2hlbmcsIFRvbnkKPj4gPFRvbnkuQ2hlbmdAYW1kLmNvbT47IFRzYWksIE1hcnRpbiA8TWFy
dGluLlRzYWlAYW1kLmNvbT47IExha2hhLAo+PiBCaGF3YW5wcmVldCA8Qmhhd2FucHJlZXQuTGFr
aGFAYW1kLmNvbT47IFdlbnRsYW5kLCBIYXJyeQo+PiA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4K
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAzOS80M10gZHJtL2FtZC9kaXNwbGF5OiBVc2UgdWRlbGF5
IHRvIGF2b2lkIGNvbnRleHQKPj4gc3dpdGNoCj4+Cj4+IEFtIDEwLjAxLjIwIHVtIDE1OjQ2IHNj
aHJpZWIgUm9kcmlnbyBTaXF1ZWlyYToKPj4+IEZyb206IE1hcnRpbiBUc2FpIDxtYXJ0aW4udHNh
aUBhbWQuY29tPgo+Pj4KPj4+IFt3aHldCj4+PiBUaGUgcmFwaWQgbXNsZWVwIG9wZXJhdGlvbiBj
YXVzZXMgdGhlIHdoaXRlIGxpbmUgZ2FyYmFnZSB3aGVuIERBTAo+Pj4gY2hlY2sgZmxpcCBwZW5k
aW5nIHN0YXR1cyBpbiBTZXRWaWRQblNvdXJjZVZpc2liaWxpdHkuCj4+PiBUbyBleGVjdXRlIHRo
aXMgbXNsZWVwIHdpbGwgaW5kdWNlIGNvbnRleHQgc3dpdGNoLCBhbmQgbG9uZ2VyIGRlbGF5Cj4+
PiBjb3VsZCBjYXVzZSB3b3JzZSBnYXJiYWdlIHNpdHVhdGlvbi4KPj4+Cj4+PiBbaG93XQo+Pj4g
VG8gcmVwbGFjZSBtc2xlZXAgd2l0aCB1ZGVsYXkuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWFy
dGluIFRzYWkgPG1hcnRpbi50c2FpQGFtZC5jb20+Cj4+PiBSZXZpZXdlZC1ieTogVG9ueSBDaGVu
ZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgo+Pj4gQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPgo+Pj4gQWNrZWQtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJp
Z28uU2lxdWVpcmFAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyB8IDQgKystLQo+Pj4gICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+Pj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+Pj4gaW5k
ZXggODk5MjA5MjRhMTU0Li4wZGM2NTJlNzY4NDggMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2VxLmMKPj4+IEBAIC0xNjQy
LDkgKzE2NDIsOSBAQCB2b2lkIGRjbjIwX3Byb2dyYW1fZnJvbnRfZW5kX2Zvcl9jdHgoCj4+PiAg
IAkJCXN0cnVjdCBodWJwICpodWJwID0gcGlwZS0+cGxhbmVfcmVzLmh1YnA7Cj4+PiAgIAkJCWlu
dCBqID0gMDsKPj4+Cj4+PiAtCQkJZm9yIChqID0gMDsgaiA8IFRJTUVPVVRfRk9SX1BJUEVfRU5B
QkxFX01TCj4+PiArCQkJZm9yIChqID0gMDsgaiA8IFRJTUVPVVRfRk9SX1BJUEVfRU5BQkxFX01T
KjEwMDAKPj4+ICAgCQkJCQkmJiBodWJwLT5mdW5jcy0KPj4+IGh1YnBfaXNfZmxpcF9wZW5kaW5n
KGh1YnApOyBqKyspCj4+PiAtCQkJCW1zbGVlcCgxKTsKPj4+ICsJCQkJdWRlbGF5KDEpOwo+Pgo+
PiBXaHkgbm90IHVzaW5nIG1kZWxheSgpIGhlcmU/Cj4gCj4gQXMgZmFyIGFzIEkga25vdywgbWRl
bGF5KCkgaXMgb25seSBkZWZpbmVkIG9uIExpbnV4IHNpZGUuCj4gCj4gVGhpcyBwaWVjZSBvZiBj
b2RlIGlzIHNoYXJlZCBieSBib3RoIExpbnV4IGFuZCBXaW5kb3dzLCBzbyB3ZSBoYXZlIHRvIHVz
ZSBhIGZ1bmN0aW9uIHRoYXQncyBhdmFpbGFibGUgb24gYm90aCBwbGF0Zm9ybXMuCj4gCgpJdCB3
YXMgdXNlZCBoZXJlIGJlZm9yZSBzbyB3ZSBkZWZpbml0ZWx5IGhhdmUgaXQgZGVmaW5lZCBmb3Ig
V2luZG93cyBhcwp3ZWxsLgoKRnJvbSB0aGUgY29tbWl0IGRlc2NyaXB0aW9uIGl0IHNvdW5kcyBs
aWtlIG1zbGVlcCB3YXNuJ3QgdGlnaHQgZW5vdWdoCmFuZCBsb25nZXIgZGVsYXlzIGxlYWQgdG8g
aXNzdWVzIGhlcmUsIGF0IGxlYXN0IG9uIFdpbmRvd3MuCgpNYXJ0aW4sIFRvbnksIGRvIHlvdSBo
YXZlIG1vcmUgZGV0YWlscyBhYm91dCB0aGlzPwoKVGhhbmtzLApIYXJyeQoKPiBaaGFuCj4gCj4+
Cj4+IENocmlzdGlhbi4KPj4KPj4+ICAgCQl9Cj4+PiAgIAl9Cj4+Pgo+Pgo+PiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
