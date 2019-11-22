Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD32C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 15:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D928B20715
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 15:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D928B20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE6D6E11E;
	Fri, 22 Nov 2019 15:31:24 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750041.outbound.protection.outlook.com [40.107.75.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FB26E11E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2019 15:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/ALHQG/EOQ/FKnLvJQOzk1Kv+vIdyNMfbMZ6T3Xpso+6fa41Z8AxNcNj3tmtqs/0OWIjlnufzorD5JFQl7TSsEBiXBabgpVsU6+y9ygLzwj2GR5VPeomal2NBT9v/7gAs8Zw89iquuB1UMubUgOm/YWGFmGO1BGX2HBvdAP5pUIDvkIJa7n60ck7YGPzOggFm0c/Gz0kg1jwSDvnHl3NwTRxSrLmmcCrG4GGMEXAnv5yK7TAt5paEzM/BSsVeKnK8d+88tXlGGhJxC2grfalcP54UTJlTNbMo7akpPDvjsLd+03/0a/RL9Ssvk9Yl3t5uEZ6p6kD7WijQajBN/XWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZV2xXqgm8UC4PZltAroOtdugrPr6RwIgikAxk4r7VM=;
 b=FzWE8ztHeqidbuBEUcta8/MijiCJVynGIjbh2w1dsA/Z9wImRwgX9+Us+qrkcjinUZOiV4LdrOr9YI5Et3cV+AkgBXtyI8CbZ21dRIM69595vT1wWjg7ui3DJG9UQ2k0yCbtk7Gn6nmK4Z/H5X+IxGt/uDRY6x/pCY32GMmXAkCg0I97y2qGk2pfidENqZtrbyEqZXMskbFUkcM1Oaz5NqfMrxUqWHEQBMmxrnHWXFlDZ1zByz9tRorK0Sggmks4z4v+6AEtaZrtyBxzSMwryBHjHAz6Z8NEcDryL2tm34ibU/Ze8FbNT2C0QprCgN9CIVaWyrc270alzf5wqLwtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0023.namprd12.prod.outlook.com (10.172.79.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 15:31:22 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2451.031; Fri, 22 Nov 2019
 15:31:21 +0000
Subject: Re: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
To: Louis Li <ching-li@amd.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
References: <20191114034212.1106-1-Ching-shih.Li@amd.com>
 <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
 <3c30b486-7062-ade2-0dbd-7288fbf595c1@amd.com>
 <3ee8d870-c461-c68f-4a36-f2bf17e9e81f@amd.com>
 <20191122063359.GA13420@swae-HP-ProBook-455R-G6>
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
Message-ID: <2d828fee-b8c7-ec8c-f454-2574fd68ed45@amd.com>
Date: Fri, 22 Nov 2019 10:31:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191122063359.GA13420@swae-HP-ProBook-455R-G6>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::27) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffbead62-892a-40f6-22e3-08d76f6106e6
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0023:|CY4PR1201MB0023:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00231A0CBC8600F5B4CDAA358C490@CY4PR1201MB0023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02296943FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(47660400002)(199004)(189003)(13464003)(478600001)(99286004)(6636002)(81166006)(66556008)(8936002)(50466002)(966005)(14454004)(23676004)(6512007)(31686004)(81156014)(66946007)(2486003)(54906003)(316002)(110136005)(31696002)(66476007)(58126008)(4326008)(5660300002)(52116002)(47776003)(6116002)(25786009)(446003)(2616005)(6306002)(76176011)(6436002)(386003)(65956001)(6506007)(4001150100001)(53546011)(26005)(14444005)(36756003)(305945005)(8676002)(2870700001)(6486002)(6246003)(3846002)(66066001)(65806001)(186003)(229853002)(2906002)(7736002)(11346002)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0023;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P159sSZj9o9uW1R5pI7yFHZ43XGedZK4A0tjBOcc8NiW8hzkHcrUNZbWLVBNMybyQXOiwIioDap3wwQJBACo6zus9Fon3pIoQ4hqceifkYqzao1M3kz87lRukbFFxY2vAAX3/beHtWC99ipZjX0ZS7a0Vg3DE0Cs4CTAOiGTO46ZwEw7vkxEkwqdS95Ge+WQiT+ECK8LJUTwTin+QnA10sBCeR+rG0jHfsw9Y14Yp8lQDSlNm/f6Gh5O6DHreyQXT5p0Q6UBzLem3Q+pQaCJQXnOQUmJugsz/xGU78eK6hFrBgQUpFFaIFgNQvsXVgkFC9anG4LNeAn8OmS0gTtmdSvAjTwbTuRut6EJm8mivEWmR/1o/NShPzyP4BmL2pIJkynqvTi9h2C0MoarWTUVi5eq1EEhfGsDZO+UezTMD60TnLF+BLL+tI/Eu/ewvNcrjeoPu54QrBmQuHb8qJEEh81salXL0sMo/N0TNNmK5wo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbead62-892a-40f6-22e3-08d76f6106e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 15:31:21.8549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElU3AkWk4FzaybGFU2AMOUgPxKgGomQaVF0w2m8Dg5b7uF5LskzUYu6UTV4NIIQBN6WhsdNHrTNmReV5LHSJGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZV2xXqgm8UC4PZltAroOtdugrPr6RwIgikAxk4r7VM=;
 b=4Jn0Qt0/SUF+0DkTP6zqAFnYFzvR/bWoN691+Tttlf8kw4ScwDHCZVOppKFV6RX+Zc3bphvc+6r2CJpHRFqERIrxEqQ7Q40ZH2pG1RLFIoDnF9cgzbIdHPaS+p7EHFfCIiNcVrW1wx6qhJBEGR3Ktbdbp+5zW8H8GNGSoPePPzY=
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ching-shih \(Louis\)" <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122153119.sOS-vcdIuVlwFvc3ho0YSdZtD6oDMk6Z5IFvNciSpkE@z>

CgpPbiAyMDE5LTExLTIyIDE6MzMgYS5tLiwgTG91aXMgTGkgd3JvdGU6Cj4gT24gVGh1LCBOb3Yg
MjEsIDIwMTkgYXQgMDg6NDc6NTBBTSAtMDUwMCwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6
Cj4+IE9uIDIwMTktMTEtMjEgODo0MCBhLm0uLCBLYXpsYXVza2FzLCBOaWNob2xhcyB3cm90ZToK
Pj4+IE9uIDIwMTktMTEtMjEgMzozMSBhLm0uLCBMaSwgQ2hpbmctc2hpaCAoTG91aXMpIHdyb3Rl
Ogo+Pj4+IEhpIHJldmlld2VycywKPj4+Pgo+Pj4+IFdoYXQgaXMgdGhlIHJldmlldyByZXN1bHQg
Zm9yIHRoaXMgcGF0Y2g/IEN1c3RvbWVyIGlzIHB1c2hpbmcgb24gdGhpcwo+Pj4+IGNoYW5nZSB0
byBtZXJnZS4gVEtTIGZvciB5b3VyIGF0dGVudGlvbi4KPj4+Pgo+Pj4+IEJSLAo+Pj4+IExvdWlz
Cj4+Pj4KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4+IEZyb206IExvdWlzIExp
IDxDaGluZy1zaGloLkxpQGFtZC5jb20+Cj4+Pj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDE0
LCAyMDE5IDExOjQyIEFNCj4+Pj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+
Pj4gQ2M6IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+
OyBXZW50bGFuZCwgSGFycnkKPj4+PiA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBDaGlu
Zy1zaGloIChMb3VpcykgPENoaW5nLXNoaWguTGlAYW1kLmNvbT4KPj4+PiBTdWJqZWN0OiBbUEFU
Q0ggdjJdIGRybS9hbWQvZGlzcGxheTogRml4IEFwcGxlIGRvbmdsZSBjYW5ub3QgYmUKPj4+PiBz
dWNjZXNzZnVsbHkgZGV0ZWN0ZWQKPj4+Pgo+Pj4+IFtXaHldCj4+Pj4gRXh0ZXJuYWwgbW9uaXRv
ciBjYW5ub3QgYmUgZGlzcGxheWVkIGNvbnNpc3RlbnRseSwgaWYgY29ubmVjdGluZyB2aWEKPj4+
PiB0aGlzIEFwcGxlIGRvbmdsZSAoQTE2MjEsIFVTQiBUeXBlLUMgdG8gSERNSSkuCj4+Pj4gQnkg
ZXhwZXJpbWVudHMsIGl0IGlzIGNvbmZpcm1lZCB0aGF0IHRoZSBkb25nbGUgbmVlZHMgMjAwbXMg
YXQgbGVhc3QgdG8KPj4+PiBiZSByZWFkeSBmb3IgY29tbXVuaWNhdGlvbiwgYWZ0ZXIgaXQgc2V0
cyBIUEQgc2lnbmFsIGhpZ2guCj4+Pj4KPj4+PiBbSG93XQo+Pj4+IFdoZW4gcmVjZWl2aW5nIEhQ
RCBJUlEsIGRlbGF5IDMwMG1zIGF0IHRoZSBiZWdpbm5pbmcgb2YgaGFuZGxlX2hwZF9pcnEoKS4K
Pj4+PiBUaGVuIHJ1biB0aGUgb3JpZ2luYWwgcHJvY2VkdXJlLgo+Pj4+IFdpdGggdGhpcyBwYXRj
aCBhcHBsaWVkLCB0aGUgcHJvYmxlbSBjYW5ub3QgYmUgcmVwcm9kdWNlZC4KPj4+PiBXaXRoIG90
aGVyIGRvbmdsZXMsIHRlc3QgcmVzdWx0cyBhcmUgUEFTUy4KPj4+PiBUZXN0IHJlc3VsdCBpcyBQ
QVNTIHRvIHBsdWcgaW4gSERNSSBjYWJsZSB3aGlsZSBwbGF5aW5nIHZpZGVvLCBhbmQgdGhlCj4+
Pj4gdmlkZW8gaXMgYmVpbmcgcGxheWluZyBzbW9vdGhseS4KPj4+PiBUZXN0IHJlc3VsdCBpcyBQ
QVNTIGFmdGVyIHN5c3RlbSByZXN1bWVzIGZyb20gc3VzcGVuZC4KPj4+Pgo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IExvdWlzIExpIDxDaGluZy1zaGloLkxpQGFtZC5jb20+Cj4+Pgo+Pj4gVGhpcyBpcyBz
dGlsbCBhIE5BSyBmcm9tIG1lIHNpbmNlIHRoZSBsb2dpYyBoYXNuJ3QgY2hhbmdlZCBmcm9tIHRo
ZSBmaXJzdAo+Pj4gcGF0Y2guCj4+Pgo+Pj4gU2xlZXBzIGRvbid0IGJlbG9uZyBpbiBJUlEgaGFu
ZGxlcnMuCj4+Pgo+Pj4gUmVnYXJkcywKPj4+IE5pY2hvbGFzIEthemxhdXNrYXMKPj4KPj4gQWN0
dWFsbHksIHRoaXMgbGl2ZXMgaW4gdGhlIGxvdyBJUlEgY29udGV4dCB3aGljaCBtZWFucyB0aGF0
IGl0J3MgYWxyZWFkeQo+PiBiZWVuIHF1ZXVlZCBvZmYgdG8gYSB3b3JrIHRocmVhZCBzbyBpdCdz
IHNhZmUgdG8gc2xlZXAuCj4+Cj4+IEknbSBub3Qgc3VyZSB3ZSB3YW50IGEgZ2VuZXJhbCAzMDBt
cyBzbGVlcCAoZXZlbiBieSBleHBlcmltZW50IHlvdSBzYWlkIHRoYXQKPj4gaXQgb25seSBuZWVk
ZWQgMjAwbXMpIGZvciBhbGwgY29ubmVjdG9ycy4KPj4KPj4gTmljaG9sYXMgS2F6bGF1c2thcwo+
Pgo+IAo+IFllcywgaXQgaXMgSVJRIGNvbnRleHQuIFNhZmUgdG8gY2FsbCBzbGVlcCgpLiBNb3Jl
b3ZlciwgaW4gY3VycmVudCBkcml2ZXIsCj4gZXZlbiB1ZGVsYXkoKSBpcyBjYWxsZWQgaW4gd2Fp
dF9mb3JfdHJhaW5pbmdfYXV4X3JkX2ludGVydmFsKCkgaW4gdGhlIGZsb3cKPiBvZiBoYW5kbGVf
aHBkX2lycSgpLgo+IAo+IEZvciAybmQgcXVlc3Rpb24sIG9mIGNvdXJzZSBub3QgYWxsIGNvbm5l
Y3RvcnMgaGF2ZSB0aGlzIGJlaGF2aW9yLgo+IEJhc2VkIG9uIHJlYWwgY2FzZXMgd2UgZXZlciBk
ZWFsdCwgc29tZSBkb25nbGVzIGxpa2UgdGhpcywgb3Igc29tZQo+IG1vbml0b3JzIGRyaXZlbiBi
eSBUQ09OLCBoYXZlIHNhbWUgYmVoYXZpb3IuIEFuZCBubyBjaGFuY2UgdG8gcmVhZAo+IG91dCBh
bnl0aGluZyB0byBkZWNpZGUgaWYgZGVsYXkgaXMgbmVlZGVkLiBUaGlzIGNoYW5nZSBkb2VzIGhl
bHAKPiB0byBoYXZlIG91ciBkcml2ZXIgZ2FpbiBiZXR0ZXIgY29tcGF0aWJpbGl0eS4gVHJ1bHkg
dGhpcyBzaG91bGQgYmUKPiBwcm9ibGVtIG9mIGRvbmdsZXMvbW9uaXRvcnMuIFdlIGFyZSBub3Qg
dGhlIG9ubHkgb25lIHRvCj4gd29ya2Fyb3VuZCBzdWNoIGEgcHJvYmxlbS4gVGhpcyBjaGFuZ2Ug
ZG9lcyBub3QgaHVydCBvdGhlciBjb25uZWN0cywKPiBhbmQgc29tZSBvdGhlciBkb25nbGVzIGFy
ZSB0ZXN0ZWQgb2ssIGUuZy4gSFAvSHV3YWkgZG9uZ2xlcywgZXRjLgo+IAoKSSBzdGlsbCBkb24n
dCBsaWtlIHRoaXMgY2hhbmdlLiBJdCBtaWdodCBpbXBhY3Qgb3RoZXIgdXNlIGNhc2VzLCBzdWNo
IGFzClNTVC10by1NU1Qgc3dpdGNoaW5nIG9uIE1TVCBkaXNwbGF5cy4KCkhhdmUgeW91IGNoZWNr
ZWQgaG93IFdpbmRvd3MgZGVhbHMgd2l0aCB0aGlzIGRvbmdsZSBhbmQgaG93IHRoZSBXaW5kb3dz
CnRlYW0gc29sdmVkIHRoaXM/IEhhdmUgeW91IGNoZWNrZWQgaG93IG90aGVyIGRyaXZlcnMgKHN1
Y2ggYXMgaTkxNSkgZGVhbAp3aXRoIHRoaXMgZG9uZ2xlPwoKSGF2ZSB5b3UgY2hlY2tlZCB3aGV0
aGVyIHlvdSBjYW4gcGFzcyBEUCBjb21wbGlhbmNlIHdpdGggdGhpcyBjaGFuZ2U/CgpIYXJyeQoK
Pj4+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYyB8IDUgKysrKysKPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+Pj4+IGluZGV4IDBhZWY5MmI3YzAzNy4uNWI4NDRiNmE1
YTU5IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jCj4+Pj4gQEAgLTEwMjUsNiArMTAyNSwxMSBAQCBzdGF0aWMgdm9p
ZCBoYW5kbGVfaHBkX2lycSh2b2lkICpwYXJhbSkKPj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYgPSBjb25uZWN0b3ItPmRldjsKPj4+PiDCoMKgwqDCoMKgIGVudW0gZGNfY29u
bmVjdGlvbl90eXBlIG5ld19jb25uZWN0aW9uX3R5cGUgPSBkY19jb25uZWN0aW9uX25vbmU7Cj4+
Pj4gK8KgwqDCoCAvKiBTb21lIG1vbml0b3JzL2RvbmdsZXMgbmVlZCBhcm91bmQgMjAwbXMgdG8g
YmUgcmVhZHkgZm9yCj4+Pj4gY29tbXVuaWNhdGlvbgo+Pj4+ICvCoMKgwqDCoCAqIGFmdGVyIHRo
b3NlIGRldmljZXMgZHJpdmUgSFBEIHNpZ25hbCBoaWdoLgo+Pj4+ICvCoMKgwqDCoCAqLwo+Pj4+
ICvCoMKgwqAgbXNsZWVwKDMwMCk7Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqAgLyogSW4gY2FzZSBv
ZiBmYWlsdXJlIG9yIE1TVCBubyBuZWVkIHRvIHVwZGF0ZSBjb25uZWN0b3Igc3RhdHVzIG9yCj4+
Pj4gbm90aWZ5IHRoZSBPUwo+Pj4+IMKgwqDCoMKgwqDCoCAqIHNpbmNlIChmb3IgTVNUIGNhc2Up
IE1TVCBkb2VzIHRoaXMgaW4gaXQncyBvd24gY29udGV4dC4KPj4+PiDCoMKgwqDCoMKgwqAgKi8K
Pj4+PiAtLSAKPj4+PiAyLjIxLjAKPj4+Pgo+Pj4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+PgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
