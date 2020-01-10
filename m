Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C465C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 21:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF292082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 21:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l+hnTmZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF292082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C176E0D4;
	Fri, 10 Jan 2020 21:30:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149E16E0D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 21:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTlMdpEidjcnS27p+ejjIHTwC7ZxT1j4qiPwJgQvDbrrFoqmBRvd25rg7RZLG3PsEpvV8riVbXE7RUFqRwNbHCKpVYlrczYDbMU+P/xE//chspIkeQnVpRTHTCGtXgQTLr25tX7hY9cr3lyW3U20ZOoq7COQgCOF5ltljTMxhIzy75XaoiQxl4mswofsPyclazVcVaVZAqdodgM1g54tOFUfBDRAMuGZ2mMKg3lu30oeSiXSubdKcfwOm+DpZn/h83U4UcSSc0Idr+3l4muOj/k6oLjt9pF9BQimG4Fu4W/0L54GZ7vEhWCWi77S2tkwvy69biuLdMS/3eR5VWJQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luXQLjSvlKD/wuVkg+GPhQDf1HXv0PBXurU/BrjFJGo=;
 b=nVty4G3Ss9NFPYfDIXWG9k3x+t3oYTGu/tL4LxLDdcO9CVM5EMdjjdEWKF1SWy6xWbCS1AgTzHQpBFp1vW9++JY0E3+jofpMBDRQ4okyQQWAMRJXyG6AM83UUZrJMZiK0RqQb3Joc39eKt8zr7e7sbj5VDGANoIFkbwzrO7pb+b2hugRNaiOscEihhlY74K+FQ1A+bI7pFhHjG8eFdJu3681KWDyN8RXNkqvsGczwk1uNMLhYqHYFpNzqp4b3dzFjLHPStDJuOBbnyHWnxyiU85YrPtC7Z0lwWngtp3cNXiWorM1w4NIo+NCK8UlGM055Kx0Ai0orpBobvjctcvmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luXQLjSvlKD/wuVkg+GPhQDf1HXv0PBXurU/BrjFJGo=;
 b=l+hnTmZLDCDyQflVOsGAk7uj3N3gaPUXj99/fWiP5g6KC6plWJrd0xxwmcBrt64gy9AnVoEztmwIuMbqePMU3Xc8EQWR6vo6xdCLXbfN9CduXigm6RoWMuIEX0fOZrua5Gj+QclmRH+0Uy2R9tTqVhM3MYKRZZ8LCq6PeZggAz4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB2516.namprd12.prod.outlook.com (10.172.121.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 21:30:46 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2602.016; Fri, 10 Jan 2020
 21:30:46 +0000
Subject: Re: [PATCH 39/43] drm/amd/display: Use udelay to avoid context switch
From: Harry Wentland <hwentlan@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
 <20200110144655.55845-40-Rodrigo.Siqueira@amd.com>
 <e5846131-ed59-2790-30c1-c44b19ad8914@gmail.com>
 <DM5PR1201MB25546012AE5DE4AB84B38BAD9E380@DM5PR1201MB2554.namprd12.prod.outlook.com>
 <3b143333-21a8-6075-ae85-026180eae286@amd.com>
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
Message-ID: <ea175487-1c3c-c7f9-e3be-267e6d2c6566@amd.com>
Date: Fri, 10 Jan 2020 16:30:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <3b143333-21a8-6075-ae85-026180eae286@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26)
 To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Fri, 10 Jan 2020 21:30:45 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2f0ec27-1df9-4db5-fb49-08d796145a96
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2516:|CY4PR1201MB2516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2516E3D8058DCF0603550BC38C380@CY4PR1201MB2516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(199004)(189003)(36756003)(956004)(52116002)(16576012)(26005)(2616005)(81156014)(31696002)(53546011)(31686004)(8676002)(81166006)(5660300002)(8936002)(54906003)(478600001)(66574012)(6486002)(110136005)(66476007)(2906002)(66946007)(66556008)(316002)(16526019)(4326008)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2516;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luFSs4qixNv8J+lviIXgm8g0KyqoxXDPH1Sji06z6J9IP95FcwH3/FecLWWl9eAzy4oe9HWAs33HaHqtOzgINa+e/cNkTBVjLoQvW9XsJ0AzziZM2bvjDZJxgr54BCqOVf0TWbBOlpUpg9FCTWnxd1TdqzbvBhl9E60+O3NUBbIDvNhStsouCbzYNHN5N7jGa0m6fITvb/mXXIj2P59TL/O6aTd6jFSpOgfFZ4BgiAvCJ1NydMtY/BtEIvAEc+YD5J/qMiRbf7ee+/ZkZgZika2ca4nDBrNcTBk6jv0T97CJIwL8R3csErT5VPbDdsEGJeRtmEYYxYpL9+f/XysmUu/F2jZ9nHJ+tt6W7qCMehDzasW6jPNSUIlIkqjRC6fkVhdbfyBmdO2Oh8Q/Ew7WAd3ojSjHugI+hOtITtb9szSHkaBeZrvpjRscu+MsZAGS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f0ec27-1df9-4db5-fb49-08d796145a96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 21:30:46.1420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTqFb5UUviGOEznEcinZ/G688Wwro+kTw3Y0VVwBF/rMRzeqpfJY/65zOpi7KHe3c6QVG0qt04Vk/Uq/M6I8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2516
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

T24gMjAyMC0wMS0xMCA0OjE2IHAubS4sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+IE9uIDIwMjAt
MDEtMTAgMTo0NyBwLm0uLCBMaXUsIFpoYW4gd3JvdGU6Cj4+Cj4+Cj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQo+Pj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mCj4+PiBDaHJpc3RpYW4gS8O2bmlnCj4+PiBTZW50
OiAyMDIwL0phbnVhcnkvMTAsIEZyaWRheSAxMDowMiBBTQo+Pj4gVG86IFNpcXVlaXJhLCBSb2Ry
aWdvIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+OyBhbWQtCj4+PiBnZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4+PiBDYzogTGksIFN1biBwZW5nIChMZW8pIDxTdW5wZW5nLkxpQGFtZC5jb20+
OyBDaGVuZywgVG9ueQo+Pj4gPFRvbnkuQ2hlbmdAYW1kLmNvbT47IFRzYWksIE1hcnRpbiA8TWFy
dGluLlRzYWlAYW1kLmNvbT47IExha2hhLAo+Pj4gQmhhd2FucHJlZXQgPEJoYXdhbnByZWV0Lkxh
a2hhQGFtZC5jb20+OyBXZW50bGFuZCwgSGFycnkKPj4+IDxIYXJyeS5XZW50bGFuZEBhbWQuY29t
Pgo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAzOS80M10gZHJtL2FtZC9kaXNwbGF5OiBVc2UgdWRl
bGF5IHRvIGF2b2lkIGNvbnRleHQKPj4+IHN3aXRjaAo+Pj4KPj4+IEFtIDEwLjAxLjIwIHVtIDE1
OjQ2IHNjaHJpZWIgUm9kcmlnbyBTaXF1ZWlyYToKPj4+PiBGcm9tOiBNYXJ0aW4gVHNhaSA8bWFy
dGluLnRzYWlAYW1kLmNvbT4KPj4+Pgo+Pj4+IFt3aHldCj4+Pj4gVGhlIHJhcGlkIG1zbGVlcCBv
cGVyYXRpb24gY2F1c2VzIHRoZSB3aGl0ZSBsaW5lIGdhcmJhZ2Ugd2hlbiBEQUwKPj4+PiBjaGVj
ayBmbGlwIHBlbmRpbmcgc3RhdHVzIGluIFNldFZpZFBuU291cmNlVmlzaWJpbGl0eS4KPj4+PiBU
byBleGVjdXRlIHRoaXMgbXNsZWVwIHdpbGwgaW5kdWNlIGNvbnRleHQgc3dpdGNoLCBhbmQgbG9u
Z2VyIGRlbGF5Cj4+Pj4gY291bGQgY2F1c2Ugd29yc2UgZ2FyYmFnZSBzaXR1YXRpb24uCj4+Pj4K
Pj4+PiBbaG93XQo+Pj4+IFRvIHJlcGxhY2UgbXNsZWVwIHdpdGggdWRlbGF5Lgo+Pj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogTWFydGluIFRzYWkgPG1hcnRpbi50c2FpQGFtZC5jb20+Cj4+Pj4gUmV2
aWV3ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KPj4+PiBBY2tlZC1ieTog
SGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4+Pj4gQWNrZWQtYnk6IFJv
ZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT4KPj4+PiAtLS0KPj4+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jIHwgNCAr
Ky0tCj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24yMC9kY24yMF9od3NlcS5jCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMjAvZGNuMjBfaHdzZXEuYwo+Pj4+IGluZGV4IDg5OTIwOTI0YTE1NC4uMGRjNjUyZTc2ODQ4
IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9k
Y24yMF9od3NlcS5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
bjIwL2RjbjIwX2h3c2VxLmMKPj4+PiBAQCAtMTY0Miw5ICsxNjQyLDkgQEAgdm9pZCBkY24yMF9w
cm9ncmFtX2Zyb250X2VuZF9mb3JfY3R4KAo+Pj4+ICAgCQkJc3RydWN0IGh1YnAgKmh1YnAgPSBw
aXBlLT5wbGFuZV9yZXMuaHVicDsKPj4+PiAgIAkJCWludCBqID0gMDsKPj4+Pgo+Pj4+IC0JCQlm
b3IgKGogPSAwOyBqIDwgVElNRU9VVF9GT1JfUElQRV9FTkFCTEVfTVMKPj4+PiArCQkJZm9yIChq
ID0gMDsgaiA8IFRJTUVPVVRfRk9SX1BJUEVfRU5BQkxFX01TKjEwMDAKPj4+PiAgIAkJCQkJJiYg
aHVicC0+ZnVuY3MtCj4+Pj4gaHVicF9pc19mbGlwX3BlbmRpbmcoaHVicCk7IGorKykKPj4+PiAt
CQkJCW1zbGVlcCgxKTsKPj4+PiArCQkJCXVkZWxheSgxKTsKPj4+Cj4+PiBXaHkgbm90IHVzaW5n
IG1kZWxheSgpIGhlcmU/Cj4+Cj4+IEFzIGZhciBhcyBJIGtub3csIG1kZWxheSgpIGlzIG9ubHkg
ZGVmaW5lZCBvbiBMaW51eCBzaWRlLgo+Pgo+PiBUaGlzIHBpZWNlIG9mIGNvZGUgaXMgc2hhcmVk
IGJ5IGJvdGggTGludXggYW5kIFdpbmRvd3MsIHNvIHdlIGhhdmUgdG8gdXNlIGEgZnVuY3Rpb24g
dGhhdCdzIGF2YWlsYWJsZSBvbiBib3RoIHBsYXRmb3Jtcy4KPj4KPiAKPiBJdCB3YXMgdXNlZCBo
ZXJlIGJlZm9yZSBzbyB3ZSBkZWZpbml0ZWx5IGhhdmUgaXQgZGVmaW5lZCBmb3IgV2luZG93cyBh
cwo+IHdlbGwuCj4gCgpXaG9vcHMsIEkgbWlzcmVhZCB0aGF0LgoKbWRlbGF5IGlzIGluZGVlZCBu
b3QgZGVmaW5lZCBvbiBvdXIgb3RoZXIgcGxhdGZvcm1zIGJ1dCB3ZSBjb3VsZCBnbwphaGVhZCBh
bmQgZGVmaW5lIGl0IGlmIG5lZWRlZC4KCkhhcnJ5Cgo+IEZyb20gdGhlIGNvbW1pdCBkZXNjcmlw
dGlvbiBpdCBzb3VuZHMgbGlrZSBtc2xlZXAgd2Fzbid0IHRpZ2h0IGVub3VnaAo+IGFuZCBsb25n
ZXIgZGVsYXlzIGxlYWQgdG8gaXNzdWVzIGhlcmUsIGF0IGxlYXN0IG9uIFdpbmRvd3MuCj4gCj4g
TWFydGluLCBUb255LCBkbyB5b3UgaGF2ZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhpcz8KPiAKPiBU
aGFua3MsCj4gSGFycnkKPiAKPj4gWmhhbgo+Pgo+Pj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+Pj4g
ICAJCX0KPj4+PiAgIAl9Cj4+Pj4KPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
