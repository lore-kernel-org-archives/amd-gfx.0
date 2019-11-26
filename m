Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B151CC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 19:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888882073F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 19:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888882073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C43F6E169;
	Tue, 26 Nov 2019 19:37:26 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680056.outbound.protection.outlook.com [40.107.68.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BD26E169
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 19:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSLOD6d/rStnOvtLvHvp8MEIl5fE3FKkL3ojRj1chLnqiYElHrwdlnYt+LYjR5i5YXwBMLji1IuityUoa4oAsV8Ii1XH5VZV8jSrZ6Q9siofvtpQmP1wSEbgqhZcQEz+1r8RXwEy8HDtX6WEGAydvrEDuKpJ4uiPMg4e4cQq41jE/0jkrab5+8SbrY429fcMpu4VAKzCn6Y9niRRyahjmjPZF1+iOJ5jWjJXjXfCynnJmcaRaEXr8KyVBTomfgbT2usJ8s8adRp5mkUu69L5OerljgFJEwvSf8aWkS0AoaSHj5hLWXtR56PtWcVrYJiEg66V2VMsrGMW68+2FnsKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd3BoPywgUH+XZM058BhbonRw8DtATBJTIVahQd6oT4=;
 b=dcaxmJ4yeftqik1aWIkkApE18Io8KEjAajiDjsjl1SZLRVRoIsdcMWL063tC5H6VT5B4Xs9SuEllJqUlzH2imZ87b/vk7Uue8K0ctnsqBIGOF25dw/Vcx5pEJcujM9jTLn+80+ZMMsCtdbm+rM5eNaemdRc+1R9WCWBGCWUcO2zi/bxzn1jjucsB/1YLz/LFU5av8pqVCVmoSGnVCm/2u80RetF8R6bFOWSGmC5Rm1pa3zn4K8ryU0ARV69xzC0axPxFkFZAMf8B+zkpwgri7i9bGW7Fo62Zna99pfa4EOMEedLwf06hfFSBTfwX4+imlUotyabPDQCyYzwoVILN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com (10.174.115.135) by
 BN6PR1201MB0115.namprd12.prod.outlook.com (10.174.116.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Tue, 26 Nov 2019 19:37:22 +0000
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::4ef:7b89:177d:966e]) by BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::4ef:7b89:177d:966e%11]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 19:37:22 +0000
Subject: Re: [PATCH] drm/amd/display: re-enable wait in pipelock, but add
 timeout
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191115160119.658620-1-alexander.deucher@amd.com>
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
Message-ID: <e6dff12c-c993-fd34-9e96-729b7f9546b5@amd.com>
Date: Tue, 26 Nov 2019 14:37:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191115160119.658620-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To BN6PR1201MB0228.namprd12.prod.outlook.com
 (2603:10b6:405:57::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4566255-eaee-45b8-f4ba-08d772a80ec9
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0115:|BN6PR1201MB0115:
X-MS-Exchange-PUrlCount: 2
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01159F05BBCEBE45E47237B38C450@BN6PR1201MB0115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(189003)(199004)(31696002)(229853002)(11346002)(446003)(5660300002)(25786009)(66946007)(2616005)(7736002)(53546011)(14444005)(66556008)(66476007)(76176011)(52116002)(2906002)(23676004)(2486003)(305945005)(6666004)(6486002)(4001150100001)(31686004)(6506007)(26005)(6246003)(6306002)(386003)(6512007)(6436002)(186003)(966005)(8936002)(81156014)(81166006)(230700001)(14454004)(50466002)(6116002)(3846002)(4326008)(316002)(36756003)(66066001)(65956001)(47776003)(478600001)(58126008)(65806001)(8676002)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0115;
 H:BN6PR1201MB0228.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLbKc7W2t7Tqou1jxK2qjzinZhm72SmykUhcjzVISLBKTgNTtbqwpxi1Hp2C2VLgtLX2PHJ9DNQb8YuAKTls6IM13/Shx3Bjs9vqP7R0yniMm8061WRs8vDzu+tGOKUFZFdg3AC1/SlIaII7JZkCr32nLfMV3FSFoV0VqvSs+pVpM4Js+2KPVRQVk5lt4NsMl1sqvNczA0X5QrryVQ6cH4FMeTs6Hk5uGYIMYOquGjxrVWTFodwLbbUC8YQAm69uZi6xJ6uGX82t7ugjXarqM9TmzUEXQ8pk1f27dzrgjG+3aNkIVJy7Bewkiede1VM8cCnYl36NCbHmwNhZ+Ut8e9mQf55CsYel4ZiMBiIuLpzFOjf4h2OAAKECg2jYLCITMdyc++6LSPPM7V6Qy6Smp2gLeS7B4dnxYBFs532sTYGpodTp939FLYvhzBOPr5fhB+tDX1fueXp42MTMOBdnJ/wtm7gKdv9nIO9qhOLau4I=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4566255-eaee-45b8-f4ba-08d772a80ec9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 19:37:22.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsvZqcvH6JOsJeX9G12iZu1IEg1IrJ2gOcRqBEn5idW6UaZ1Bg5930yYZje6ORgCjitDc/sc+1j52+0aki1mPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0115
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd3BoPywgUH+XZM058BhbonRw8DtATBJTIVahQd6oT4=;
 b=TCLA8luynBceQNGvLBvVax9KkckvuhiwmhkUjrfN/kwpqiO8Ca27cF2m1uJMIpN1iOuZFlueKgoeuMeouC7fAoglMHRc8hNr645Sso+lwIkeKn7hyiKtFMIHwhgCSUzcUrbbZ0i8KcZt7m/pwnTAAgk8xRkpQZMwnnMhklnDDmc=
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126193717.EYG7lGil3XBzI1zeFArTqBOzmgwU7cYYAEuyVhO7VLg@z>

T24gMjAxOS0xMS0xNSAxMTowMSBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gUmVtb3Zpbmcg
dGhpcyBjYXVzZXMgaGFuZ3MgaW4gc29tZSBnYW1lcywgc28gcmUtYWRkIGl0LCBidXQgYWRkCj4g
YSB0aW1lb3V0IHNvIHdlIGRvbid0IGhhbmcgd2hpbGUgc3dpdGNoaW5nIGZsaXAgdHlwZXMuCj4g
Cj4gQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTE2
OQo+IEJ1ZzogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTEy
MjY2Cj4gQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIw
NTE2OQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KClBhdGNoIGlzClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxh
bmRAYW1kLmNvbT4KCkhhcnJ5Cgo+IC0tLQo+ICAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIw
L2RjbjIwX2h3c2VxLmMgICAgfCAxOSArKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxOSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2VxLmMKPiBpbmRleCAwMDQ2YTA5OWM5ZTkuLjEyMGU2
MmM1MTkzYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjAvZGNuMjBfaHdzZXEuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24yMC9kY24yMF9od3NlcS5jCj4gQEAgLTEwMzMsNiArMTAzMywyNSBAQCB2b2lkIGRjbjIwX3Bp
cGVfY29udHJvbF9sb2NrKAo+ICAJaWYgKHBpcGUtPnBsYW5lX3N0YXRlICE9IE5VTEwpCj4gIAkJ
ZmxpcF9pbW1lZGlhdGUgPSBwaXBlLT5wbGFuZV9zdGF0ZS0+ZmxpcF9pbW1lZGlhdGU7Cj4gIAo+
ICsJaWYgKGZsaXBfaW1tZWRpYXRlICYmIGxvY2spIHsKPiArCQljb25zdCBpbnQgVElNRU9VVF9G
T1JfRkxJUF9QRU5ESU5HID0gMTAwMDAwOwo+ICsJCWludCBpOwo+ICsKPiArCQlmb3IgKGkgPSAw
OyBpIDwgVElNRU9VVF9GT1JfRkxJUF9QRU5ESU5HOyArK2kpIHsKPiArCQkJaWYgKCFwaXBlLT5w
bGFuZV9yZXMuaHVicC0+ZnVuY3MtPmh1YnBfaXNfZmxpcF9wZW5kaW5nKHBpcGUtPnBsYW5lX3Jl
cy5odWJwKSkKPiArCQkJCWJyZWFrOwo+ICsJCQl1ZGVsYXkoMSk7Cj4gKwkJfQo+ICsKPiArCQlp
ZiAocGlwZS0+Ym90dG9tX3BpcGUgIT0gTlVMTCkgewo+ICsJCQlmb3IgKGkgPSAwOyBpIDwgVElN
RU9VVF9GT1JfRkxJUF9QRU5ESU5HOyArK2kpIHsKPiArCQkJCWlmICghcGlwZS0+Ym90dG9tX3Bp
cGUtPnBsYW5lX3Jlcy5odWJwLT5mdW5jcy0+aHVicF9pc19mbGlwX3BlbmRpbmcocGlwZS0+Ym90
dG9tX3BpcGUtPnBsYW5lX3Jlcy5odWJwKSkKPiArCQkJCQlicmVhazsKPiArCQkJCXVkZWxheSgx
KTsKPiArCQkJfQo+ICsJCX0KPiArCX0KPiArCj4gIAkvKiBJbiBmbGlwIGltbWVkaWF0ZSBhbmQg
cGlwZSBzcGxpdHRpbmcgY2FzZSwgd2UgbmVlZCB0byB1c2UgR1NMCj4gIAkgKiBmb3Igc3luY2hy
b25pemF0aW9uLiBPbmx5IGRvIHNldHVwIG9uIGxvY2tpbmcgYW5kIG9uIGZsaXAgdHlwZSBjaGFu
Z2UuCj4gIAkgKi8KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
