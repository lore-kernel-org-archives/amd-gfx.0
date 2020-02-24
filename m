Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8CCC38BFA
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 21:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE1F20CC7
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 21:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z+7gaDPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE1F20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9576E98E;
	Mon, 24 Feb 2020 21:59:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C776E98E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 21:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj0KICftsLnaQdO2xip0ak3nilyDBbK/GQWGXOYQwx7AmTXsECEYnjZgM0XaZ//EaPd8C8fdS0zhOJ8A1+2Da2WJBVjOZFrtpqpNIFwwS+egE2nU18n6Z2448lcRGVyShcjVWY5FLyJnEIXNTW0VMCCb7lbq4qQRLijdqZJdYnAdyhuKXBoR2d66FtZ2yon4Csc61AvxR+f3ro1nks+4eL7Zo/n9DClB6P+Xza/X3kJFzqd/99LDszhSoFlRedgpM7lTra23snrIAmJz1tMtFvskm889+fyPe2XytUHldcw3DkEC4mpGgB9frWXzeQSQAhJ5lovDa1ZZjVVLY6qN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQpMAwD4Epoxgm4/t6BvDIZk1oD47nXbPACbUHzFUjw=;
 b=QkwN6dY2KNkJz4+YT4LAx7oVKA+UEufR9PSRMA5iYxCxv+hAf/+GYTblueCI14NmCltyNDcP9XEt7drBFrFDXT+i8l2y2/v7CWQFfRsqrxvNtwNxoskPUDVyjmAWG2R7+PwB92dVMTiaOs7I73wC+6GinvJHudzwlVuPfTGZl7pOBECkTjaBf6xQb3Qpdh5yfhOfD0RjgwblrMOTmXzHlwsz9AMza1vtRiZ42jSDn4EMVe4DiIzLHuRgktwM8gYq5TAb7asQ18PovzGAChlEhPnKIzGjlP61VugvTLtbYDGu7c+7K5ch6lDFywF4e1xmVPWvwEDMz3YX/RXEg1ogBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQpMAwD4Epoxgm4/t6BvDIZk1oD47nXbPACbUHzFUjw=;
 b=z+7gaDPlzx6pt/qjPIivzjuahRGtu0qYevtQYAomc61Xl4IKml9oM+3rPNhfKKBOh3TmW5Dnar+qxXjCvvSi7ybvdT3pDOPniY3LsRNG2Q3dl25DDp7WPazejdg/GjBMF5OfLF+LoehKEfSQg3vyw7NsSel3SQaks0j4btvROQ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 21:59:39 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::2ca3:d95b:6303:76a5]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::2ca3:d95b:6303:76a5%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 21:59:39 +0000
Subject: Re: [PATCH] drm/amd/display: add HDCP caps debugfs
To: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
References: <20200224195553.28137-1-Bhawanpreet.Lakha@amd.com>
 <b6d16c38-0945-3915-05ba-6194db5d2a50@amd.com>
 <aa3c7758-0597-fb2e-e89b-7a66263eb54a@amd.com>
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
Message-ID: <22faf110-5ac9-fc8e-c9b1-c29cccc9ebf0@amd.com>
Date: Mon, 24 Feb 2020 16:59:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <aa3c7758-0597-fb2e-e89b-7a66263eb54a@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::35) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.4.41.132] (165.204.55.251) by
 YTBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 21:59:38 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e8d8a9e-ffa2-4031-2277-08d7b974d82b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4476:|MW3PR12MB4476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4476D17C484D884A53CB12508CEC0@MW3PR12MB4476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(189003)(199004)(956004)(66556008)(26005)(5660300002)(186003)(31686004)(66476007)(66946007)(2616005)(6486002)(2906002)(16576012)(316002)(81156014)(8936002)(53546011)(81166006)(16526019)(52116002)(4326008)(8676002)(36756003)(31696002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW3PR12MB4476;
 H:MW3PR12MB4379.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE/Kh5ram/tswj5WnT8mEkYqxN6vwvTSydIxGn+WGU1RyRQfcA4x33Jfvl6xpeO8mnBFa1nnjvGoayJIEyMqkCBarTySJb7x7aP7jtpmstwydYhvvVMv0bWxoNm3t2EilgJgLD1XQWvzHU6xeshOVwatVBwfH9CzCZl7nOgy0D0IkpBChfZW37M3nD+ZoGhcdqzC8kGUoBkrLoYtvyClw2INqv+rQ5EUrUSGFkldglwfhLU1mf39vOzrJyJuNHLUNPLnwRnVKVdxFmv/sy1r1DFaDQyy+gqu40wufmj2Ct7IZN0N/rLPll8z2Cpzhtuv/OxfK4jM+CGPx3CvIAX3bLURp4Edo2T1wKQgdAXq379I9gDo2VzEUWPSMfsbxyLm0tli5yoS90JqdrdRaievYgn0aODOkebrwBN6vbiyTbql70X8p9GSQ6oxpxMECoGA
X-MS-Exchange-AntiSpam-MessageData: usL27dZWA+zYNBeCGzqRzZy5/0b1T9UrHxzcOs6H70JB9r+oRiczr8zaXFxuUFEdPxjcFh/LA7k8JxCpcjbe9DbTqzqN6dQm3ETunlSrf7wB2p3N9J6ToOMpYMkO1Qiy8e/APmT0Is3zIiJl1mb7Uw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8d8a9e-ffa2-4031-2277-08d7b974d82b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 21:59:39.2734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p74z/zyJdlJdmJGU8Ht4GS2yCPxn9TIC8atHfngeVk4p+gJ3ObH0kmNv8gpnwccVuFVhrIM9eQOgY7nJ5yw8fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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
Cc: harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIwLTAyLTI0IDQ6NTEgcC5tLiwgQmhhd2FucHJlZXQgTGFraGEgd3JvdGU6Cj4gCj4g
T24gMjAyMC0wMi0yNCA0OjE1IHAubS4sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+Pgo+PiBPbiAy
MDIwLTAyLTI0IDI6NTUgcC5tLiwgQmhhd2FucHJlZXQgTGFraGEgd3JvdGU6Cj4+PiBBZGQgZGVi
dWdmcyB0byBnZXQgSERDUCBjYXBhYmlsaXR5LiBUaGlzIGlzIGFsc28gdXNlZnVsIGZvcgo+Pj4g
a21zX2NvbnRlbnRfcHJvdGVjdGlvbiBpZ3QgdGVzdC4KPj4+Cj4+PiBVc2U6Cj4+PiDCoMKgwqDC
oGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9EUC0xL2hkY3Bfc2lua19jYXBhYmlsaXR5Cj4+
PiDCoMKgwqDCoGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9IRE1JLUEtMS9oZGNwX3Npbmtf
Y2FwYWJpbGl0eQo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3
YW5wcmVldC5MYWtoYUBhbWQuY29tPgo+Pj4gLS0tCj4+PiDCoCAuLi4vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbV9kZWJ1Z2ZzLmMgfCA2MSArKysrKysrKysrKysrKysrKysrCj4+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQKPj4+
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fZGVidWdm
cy5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
X2RlYnVnZnMuYwo+Pj4gaW5kZXggZWFkNWMwNWVlYzkyLi41Mjk4MmM4Yzg3MWYgMTAwNjQ0Cj4+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9k
ZWJ1Z2ZzLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtX2RlYnVnZnMuYwo+Pj4gQEAgLTgxNSw2ICs4MTUsNDQgQEAgc3RhdGljIGludCB2
cnJfcmFuZ2Vfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sCj4+PiB2b2lkICpkYXRhKQo+Pj4gwqDC
oMKgwqDCoCByZXR1cm4gMDsKPj4+IMKgIH0KPj4+IMKgICsjaWZkZWYgQ09ORklHX0RSTV9BTURf
RENfSERDUAo+Pj4gKy8qCj4+PiArICogUmV0dXJucyB0aGUgSERDUCBjYXBhYmlsaXR5IG9mIHRo
ZSBEaXNwbGF5ICgxLjQgZm9yIG5vdykuCj4+PiArICoKPj4+ICsgKiBOT1RFKiBOb3QgYWxsIEhE
TUkgZGlzcGxheXMgcmVwb3J0IHRoZWlyIEhEQ1AgY2FwcyBldmVuIHdoZW4gdGhleQo+Pj4gYXJl
IGNhcGFibGUuCj4+PiArICogU2luY2UgaXRzIHJhcmUgZm9yIGEgZGlzcGxheSB0byBub3QgYmUg
SERDUCAxLjQgY2FwYWJsZSwgd2Ugc2V0Cj4+PiBIRE1JIGFzIGFsd2F5cyBjYXBhYmxlLgo+Pj4g
KyAqCj4+PiArICogRXhhbXBsZSB1c2FnZTogY2F0IC9zeXMva2VybmVsL2RlYnVnL2RyaS8wL0RQ
LTEvaGRjcF9zaW5rX2NhcGFiaWxpdHkKPj4+ICsgKsKgwqDCoMKgwqDCoMKgIG9yIGNhdCAvc3lz
L2tlcm5lbC9kZWJ1Zy9kcmkvMC9IRE1JLUEtMS9oZGNwX3NpbmtfY2FwYWJpbGl0eQo+Pj4gKyAq
Lwo+Pj4gK3N0YXRpYyBpbnQgaGRjcF9zaW5rX2NhcGFiaWxpdHlfc2hvdyhzdHJ1Y3Qgc2VxX2Zp
bGUgKm0sIHZvaWQgKmRhdGEpCj4+PiArewo+Pj4gK8KgwqDCoCBzdHJ1Y3QgZHJtX2Nvbm5lY3Rv
ciAqY29ubmVjdG9yID0gbS0+cHJpdmF0ZTsKPj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9kbV9j
b25uZWN0b3IgKmFjb25uZWN0b3IgPQo+Pj4gdG9fYW1kZ3B1X2RtX2Nvbm5lY3Rvcihjb25uZWN0
b3IpOwo+Pj4gK8KgwqDCoCBib29sIGhkY3BfY2FwLCBoZGNwMl9jYXA7Cj4+PiArCj4+PiArwqDC
oMKgIGlmIChjb25uZWN0b3ItPnN0YXR1cyAhPSBjb25uZWN0b3Jfc3RhdHVzX2Nvbm5lY3RlZCkK
Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPj4+ICsKPj4+ICvCoMKgwqAgc2Vx
X3ByaW50ZihtLCAiJXM6JWQgSERDUCB2ZXJzaW9uOiAiLCBjb25uZWN0b3ItPm5hbWUsCj4+PiBj
b25uZWN0b3ItPmJhc2UuaWQpOwo+Pj4gKwo+Pj4gK8KgwqDCoCBoZGNwX2NhcCA9IGRjX2xpbmtf
aXNfaGRjcDE0KGFjb25uZWN0b3ItPmRjX2xpbmspOwo+Pj4gK8KgwqDCoCBoZGNwMl9jYXAgPSBk
Y19saW5rX2lzX2hkY3AyMihhY29ubmVjdG9yLT5kY19saW5rKTsKPj4+ICsKPj4+ICsKPj4+ICvC
oMKgwqAgaWYgKGhkY3BfY2FwKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlcV9wcmludGYobSwgIiVz
ICIsICJIRENQMS40Iik7Cj4+PiArwqDCoMKgIGlmIChoZGNwMl9jYXApCj4+PiArwqDCoMKgwqDC
oMKgwqAgc2VxX3ByaW50ZihtLCAiJXMgIiwgIkhEQ1AyLjIiKTsKPj4+ICsKPj4+ICvCoMKgwqAg
aWYgKCFoZGNwX2NhcCAmJiAhaGRjcDJfY2FwKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNlcV9wcmlu
dGYobSwgIiVzICIsICJOb25lIik7Cj4+PiArCj4+PiArwqDCoMKgIHNlcV9wdXRzKG0sICJcbiIp
Owo+Pj4gKwo+Pj4gK8KgwqDCoCByZXR1cm4gMDsKPj4+ICt9Cj4+PiArI2VuZGlmCj4+PiDCoCAv
KiBmdW5jdGlvbiBkZXNjcmlwdGlvbgo+Pj4gwqDCoCAqCj4+PiDCoMKgICogZ2VuZXJpYyBTRFAg
bWVzc2FnZSBhY2Nlc3MgZm9yIHRlc3RpbmcKPj4+IEBAIC05NDAsNiArOTc4LDkgQEAgc3RhdGlj
IHNzaXplX3QgZHBfZHBjZF9kYXRhX3JlYWQoc3RydWN0IGZpbGUgKmYsCj4+PiBjaGFyIF9fdXNl
ciAqYnVmLAo+Pj4gwqAgREVGSU5FX1NIT1dfQVRUUklCVVRFKGRtdWJfdHJhY2VidWZmZXIpOwo+
Pj4gwqAgREVGSU5FX1NIT1dfQVRUUklCVVRFKG91dHB1dF9icGMpOwo+Pj4gwqAgREVGSU5FX1NI
T1dfQVRUUklCVVRFKHZycl9yYW5nZSk7Cj4+PiArI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0hE
Q1AKPj4+ICtERUZJTkVfU0hPV19BVFRSSUJVVEUoaGRjcF9zaW5rX2NhcGFiaWxpdHkpOwo+Pj4g
KyNlbmRpZgo+Pj4gwqAgwqAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZHBf
bGlua19zZXR0aW5nc19kZWJ1Z2ZzX2ZvcHMKPj4+ID0gewo+Pj4gwqDCoMKgwqDCoCAub3duZXIg
PSBUSElTX01PRFVMRSwKPj4+IEBAIC05OTUsMTIgKzEwMzYsMjMgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgeyJ0ZXN0X3BhdHRlcm4iLCAmZHBfcGh5X3Rl
c3RfcGF0dGVybl9mb3BzfSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB7Im91dHB1dF9icGMiLCAm
b3V0cHV0X2JwY19mb3BzfSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB7InZycl9yYW5nZSIsICZ2
cnJfcmFuZ2VfZm9wc30sCj4+PiArI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0hEQ1AKPj4+ICvC
oMKgwqDCoMKgwqDCoCB7ImhkY3Bfc2lua19jYXBhYmlsaXR5IiwgJmhkY3Bfc2lua19jYXBhYmls
aXR5X2ZvcHN9LAo+Pj4gKyNlbmRpZgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHsic2RwX21lc3Nh
Z2UiLCAmc2RwX21lc3NhZ2VfZm9wc30sCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgeyJhdXhfZHBj
ZF9hZGRyZXNzIiwgJmRwX2RwY2RfYWRkcmVzc19kZWJ1Z2ZzX2ZvcHN9LAo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHsiYXV4X2RwY2Rfc2l6ZSIsICZkcF9kcGNkX3NpemVfZGVidWdmc19mb3BzfSwK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB7ImF1eF9kcGNkX2RhdGEiLCAmZHBfZHBjZF9kYXRhX2Rl
YnVnZnNfZm9wc30KPj4+IMKgIH07Cj4+PiDCoCArI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0hE
Q1AKPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHsKPj4+ICvCoMKgwqAgY2hhciAqbmFtZTsKPj4+
ICvCoMKgwqAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyAqZm9wczsKPj4+ICt9IGhkbWlf
ZGVidWdmc19lbnRyaWVzW10gPSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgeyJoZGNwX3NpbmtfY2Fw
YWJpbGl0eSIsICZoZGNwX3NpbmtfY2FwYWJpbGl0eV9mb3BzfQo+Pj4gK307Cj4+PiArI2VuZGlm
Cj4+PiDCoCAvKgo+Pj4gwqDCoCAqIEZvcmNlIFlVVjQyMCBvdXRwdXQgaWYgYXZhaWxhYmxlIGZy
b20gdGhlIGdpdmVuIG1vZGUKPj4+IMKgwqAgKi8KPj4+IEBAIC0xMDY2LDYgKzExMTgsMTUgQEAg
dm9pZCBjb25uZWN0b3JfZGVidWdmc19pbml0KHN0cnVjdAo+Pj4gYW1kZ3B1X2RtX2Nvbm5lY3Rv
ciAqY29ubmVjdG9yKQo+Pj4gwqDCoMKgwqDCoCBkZWJ1Z2ZzX2NyZWF0ZV9maWxlX3Vuc2FmZSgi
Zm9yY2VfeXV2NDIwX291dHB1dCIsIDA2NDQsIGRpciwKPj4+IGNvbm5lY3RvciwKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmZvcmNlX3l1djQyMF9vdXRwdXRf
Zm9wcyk7Cj4+PiDCoCArI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0hEQ1AKPj4+ICvCoMKgwqAg
aWYgKGNvbm5lY3Rvci0+YmFzZS5jb25uZWN0b3JfdHlwZSA9PSBEUk1fTU9ERV9DT05ORUNUT1Jf
SERNSUEpIHsKPj4gWW91ciBwYXRjaCBkZXNjcmlwdGlvbiBtZW50aW9ucyBEUCBhbmQgSERNSSBi
dXQgaGVyZSB5b3UncmUgb25seQo+PiBjcmVhdGluZyBpdCBmb3IgSERNSS4gU2hvdWxkIHdlIGNy
ZWF0ZSBpdCBmb3IgYWxsIEhEQ1AtY2FwYWJsZSBzaWduYWwKPj4gdHlwZXMsIGkuZS4gRFAgYW5k
IEhETUk/Cj4+Cj4+IEhhcnJ5Cj4gCj4gVGhlcmUgaXMgYSBsb29wIGFib3ZlIHRoYXQgaXMgY2Fs
bGVkIGZvciBkcF9kZWJ1Z2ZzX2VudHJpZXNbXS4gSSBoYXZlCj4gYWRkZWQgdGhlIEhEQ1AgZGVi
dWdmcyB0byB0aGF0IHN0cnVjdCBzbyBubyBuZWVkIHRvIHJlY3JlYXRlIHRoZSBsb29wLgo+IAoK
SSBzZWUgaXQgbm93LiBUaGFua3MuCgpQYXRjaCBpcwpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxh
bmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CgpIYXJyeQoKPiBCaGF3YW4KPiAKPj4+ICvCoMKg
wqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShoZG1pX2RlYnVnZnNfZW50cmll
cyk7IGkrKykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVidWdmc19jcmVhdGVfZmls
ZShoZG1pX2RlYnVnZnNfZW50cmllc1tpXS5uYW1lLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMDY0NCwgZGlyLCBjb25uZWN0b3IsCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoZG1pX2RlYnVnZnNf
ZW50cmllc1tpXS5mb3BzKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+PiArwqDCoMKgIH0KPj4+
ICsjZW5kaWYKPj4+IMKgIH0KPj4+IMKgIMKgIC8qCj4+PgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
