Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52CC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B4F2084D
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B4F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF4B89D2F;
	Mon, 25 Nov 2019 14:25:05 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700059.outbound.protection.outlook.com [40.107.70.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AADC89CA2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 14:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmcQykhaBo2defJ4VvFrkcPn+k1bYPlEj03GcEi2Hfebn1NSRH41trLPQ1gPxKzxc/krVkdkOHeCWPWjLmn9ogbYz/bu3wuX9hdnMxmQlgeGDfl9grKT7P5SSeKf4alB9SemvlPwMU6aK1xyZ6yE+1o44mqhsK78R80kHDjDuyFoCz1hQnI4DSlgdZzNylpIm9Z/DE3aeIG+b+zi6wrmSCy5F1xck0ELuHcD5zBsbEvPuNHA4cehOnrWmK1CBq0c3Ekvi9NmC9jWBqGRgQHEIOd02+5DzGRqhzwgVtvKN4Qkstq/mb4YJPg3DIl8Q3MdSScfdTa7ble4xD4UZQm+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n84xDo2TXMob3b8i5bU8chGcDWjydvFpG40aJIx5C/E=;
 b=m1UroIJOjeGgjTLEmvngEpE0Gl0VhWjWtpsxBL3LK2+FJIwh6joeIrsjkmdZuJgE3e4Rb66zLndm/ryRSkLm8tmQ9WUEwheKYRWyh2PLunnLdtBgqGOeiANkdzpSy/2Nh6TpUxPQs4ok3QOR668oL29HSD0tWaBA8kB+sqZz1z7SPpv9SUwSlaQiCOJvVc3OsjjqnerPRdFEGcTmgMxFgZgwBkVPIyHev0V4tzeEH4bD1yVZeTJw5oZFbEna8zvxRCtue1Twgpf/GVVDFe4qRaB68AxX50xtJrsbVwinu/EEpNTTH0nGZIWP6v4jQiDvlalkd/G8WHAcweX8Dqr+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0150.namprd12.prod.outlook.com (10.174.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 14:24:59 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 14:24:59 +0000
Subject: Re: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be
 successfully detected
To: Louis Li <ching-li@amd.com>
References: <20191114034212.1106-1-Ching-shih.Li@amd.com>
 <MN2PR12MB406250AEB8A10A080050D952AA4E0@MN2PR12MB4062.namprd12.prod.outlook.com>
 <3c30b486-7062-ade2-0dbd-7288fbf595c1@amd.com>
 <3ee8d870-c461-c68f-4a36-f2bf17e9e81f@amd.com>
 <20191122063359.GA13420@swae-HP-ProBook-455R-G6>
 <2d828fee-b8c7-ec8c-f454-2574fd68ed45@amd.com>
 <20191125094956.GA18516@swae-HP-ProBook-455R-G6>
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
Message-ID: <95bdabb4-e216-559e-1a93-fb492903a7a0@amd.com>
Date: Mon, 25 Nov 2019 09:24:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191125094956.GA18516@swae-HP-ProBook-455R-G6>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 994edeb3-cece-495c-49ff-08d771b34031
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0150:|CY4PR1201MB0150:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB015077FAD3FFBAA703850D2C8C4A0@CY4PR1201MB0150.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(47660400002)(189003)(199004)(13464003)(53546011)(386003)(446003)(6636002)(11346002)(66946007)(6506007)(99286004)(47776003)(66066001)(65956001)(65806001)(7736002)(2870700001)(31686004)(36756003)(2616005)(58126008)(305945005)(66556008)(37006003)(6246003)(6862004)(31696002)(14444005)(4001150100001)(966005)(14454004)(186003)(54906003)(6116002)(3846002)(2906002)(5660300002)(26005)(6436002)(50466002)(229853002)(6512007)(6306002)(66476007)(498600001)(23676004)(52116002)(2486003)(6666004)(76176011)(8676002)(8936002)(25786009)(81156014)(81166006)(4326008)(6486002)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0150;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMfUMRAtGrzA91Hy/PYKSzDIh7Q7iKBekzOX5zeQMwxvjHEaHHNVc/2AGrN4CnGmq1z+LAjbag/ecEOYdRq9YJ5bffreT89ZBkjZsQw8re7b8weqqlp6HT99h0+A+LtcmfRjJmlieD2DOr5lM59b6e13Lc+49TlIDvi9nfF4i6nbweBGlnbajLJRBRBoN8YxYyVmXbdK6wZE1SonyVO1GBZGmopA8BpT76UPmdYT932KBJe4zlBmDrhXv2H8yiJtq/kxPNajtXLm5gwxvDC2DBAa6GQ73ECnBZtr63TkpbnGjMJdZSEuKQuBydfdzCF57kq88v+DmhDnSNBhk+Y6fuvav58lIkOQ+tOt169HqffbZK5Wo5C4Z2dnDpsSZXUpl1gYhTosZAdlHmdDOtp+Cx/jxiCHfn4HfHIFeHIoEXPYcGstp5RGgmkex0X/wdoMZuGuvNZWWru4TC7x6wiM0aPdw3cX/n0gDSo07pvgdEo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994edeb3-cece-495c-49ff-08d771b34031
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 14:24:59.0639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcPiBwRsTcfv1i2sr7r939DenMk6UxrneEb5xfilkLTthHETr04N1YXWGGKt/ktBpGCArYKkVpa+oFkc/hNuZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0150
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n84xDo2TXMob3b8i5bU8chGcDWjydvFpG40aJIx5C/E=;
 b=wrN407BrtgtTNQeMAMFLURz/gFdLBX3xdTlchKC+BkGEYUrcxsCQPDwCynoruFfJKOpW3hvPJJOZrPe2Y3m/zoAw5NCxYN9F5D/9cb4omFq398rfZnLnWiRoNibfTmYl1dsjHrrUBZJff7pXx7d5ROUrMvBphFuncH88X3925Ik=
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ching-shih \(Louis\)" <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125142456.mgRO3l5zsFjjj5gc2LsRQ7E2aRrfc8AlhG-qgKcHA4c@z>

CgpPbiAyMDE5LTExLTI1IDQ6NDkgYS5tLiwgTG91aXMgTGkgd3JvdGU6Cj4gT24gRnJpLCBOb3Yg
MjIsIDIwMTkgYXQgMTA6MzE6MTlBTSAtMDUwMCwgSGFycnkgV2VudGxhbmQgd3JvdGU6Cj4+Cj4+
Cj4+IE9uIDIwMTktMTEtMjIgMTozMyBhLm0uLCBMb3VpcyBMaSB3cm90ZToKPj4+IE9uIFRodSwg
Tm92IDIxLCAyMDE5IGF0IDA4OjQ3OjUwQU0gLTA1MDAsIEthemxhdXNrYXMsIE5pY2hvbGFzIHdy
b3RlOgo+Pj4+IE9uIDIwMTktMTEtMjEgODo0MCBhLm0uLCBLYXpsYXVza2FzLCBOaWNob2xhcyB3
cm90ZToKPj4+Pj4gT24gMjAxOS0xMS0yMSAzOjMxIGEubS4sIExpLCBDaGluZy1zaGloIChMb3Vp
cykgd3JvdGU6Cj4+Pj4+PiBIaSByZXZpZXdlcnMsCj4+Pj4+Pgo+Pj4+Pj4gV2hhdCBpcyB0aGUg
cmV2aWV3IHJlc3VsdCBmb3IgdGhpcyBwYXRjaD8gQ3VzdG9tZXIgaXMgcHVzaGluZyBvbiB0aGlz
Cj4+Pj4+PiBjaGFuZ2UgdG8gbWVyZ2UuIFRLUyBmb3IgeW91ciBhdHRlbnRpb24uCj4+Pj4+Pgo+
Pj4+Pj4gQlIsCj4+Pj4+PiBMb3Vpcwo+Pj4+Pj4KPj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tCj4+Pj4+PiBGcm9tOiBMb3VpcyBMaSA8Q2hpbmctc2hpaC5MaUBhbWQuY29tPgo+Pj4+
Pj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDE0LCAyMDE5IDExOjQyIEFNCj4+Pj4+PiBUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+Pj4+IENjOiBLYXpsYXVza2FzLCBOaWNo
b2xhcyA8TmljaG9sYXMuS2F6bGF1c2thc0BhbWQuY29tPjsgV2VudGxhbmQsIEhhcnJ5Cj4+Pj4+
PiA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBDaGluZy1zaGloIChMb3VpcykgPENoaW5n
LXNoaWguTGlAYW1kLmNvbT4KPj4+Pj4+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2FtZC9kaXNw
bGF5OiBGaXggQXBwbGUgZG9uZ2xlIGNhbm5vdCBiZQo+Pj4+Pj4gc3VjY2Vzc2Z1bGx5IGRldGVj
dGVkCj4+Pj4+Pgo+Pj4+Pj4gW1doeV0KPj4+Pj4+IEV4dGVybmFsIG1vbml0b3IgY2Fubm90IGJl
IGRpc3BsYXllZCBjb25zaXN0ZW50bHksIGlmIGNvbm5lY3RpbmcgdmlhCj4+Pj4+PiB0aGlzIEFw
cGxlIGRvbmdsZSAoQTE2MjEsIFVTQiBUeXBlLUMgdG8gSERNSSkuCj4+Pj4+PiBCeSBleHBlcmlt
ZW50cywgaXQgaXMgY29uZmlybWVkIHRoYXQgdGhlIGRvbmdsZSBuZWVkcyAyMDBtcyBhdCBsZWFz
dCB0bwo+Pj4+Pj4gYmUgcmVhZHkgZm9yIGNvbW11bmljYXRpb24sIGFmdGVyIGl0IHNldHMgSFBE
IHNpZ25hbCBoaWdoLgo+Pj4+Pj4KPj4+Pj4+IFtIb3ddCj4+Pj4+PiBXaGVuIHJlY2VpdmluZyBI
UEQgSVJRLCBkZWxheSAzMDBtcyBhdCB0aGUgYmVnaW5uaW5nIG9mIGhhbmRsZV9ocGRfaXJxKCku
Cj4+Pj4+PiBUaGVuIHJ1biB0aGUgb3JpZ2luYWwgcHJvY2VkdXJlLgo+Pj4+Pj4gV2l0aCB0aGlz
IHBhdGNoIGFwcGxpZWQsIHRoZSBwcm9ibGVtIGNhbm5vdCBiZSByZXByb2R1Y2VkLgo+Pj4+Pj4g
V2l0aCBvdGhlciBkb25nbGVzLCB0ZXN0IHJlc3VsdHMgYXJlIFBBU1MuCj4+Pj4+PiBUZXN0IHJl
c3VsdCBpcyBQQVNTIHRvIHBsdWcgaW4gSERNSSBjYWJsZSB3aGlsZSBwbGF5aW5nIHZpZGVvLCBh
bmQgdGhlCj4+Pj4+PiB2aWRlbyBpcyBiZWluZyBwbGF5aW5nIHNtb290aGx5Lgo+Pj4+Pj4gVGVz
dCByZXN1bHQgaXMgUEFTUyBhZnRlciBzeXN0ZW0gcmVzdW1lcyBmcm9tIHN1c3BlbmQuCj4+Pj4+
Pgo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTG91aXMgTGkgPENoaW5nLXNoaWguTGlAYW1kLmNvbT4K
Pj4+Pj4KPj4+Pj4gVGhpcyBpcyBzdGlsbCBhIE5BSyBmcm9tIG1lIHNpbmNlIHRoZSBsb2dpYyBo
YXNuJ3QgY2hhbmdlZCBmcm9tIHRoZSBmaXJzdAo+Pj4+PiBwYXRjaC4KPj4+Pj4KPj4+Pj4gU2xl
ZXBzIGRvbid0IGJlbG9uZyBpbiBJUlEgaGFuZGxlcnMuCj4+Pj4+Cj4+Pj4+IFJlZ2FyZHMsCj4+
Pj4+IE5pY2hvbGFzIEthemxhdXNrYXMKPj4+Pgo+Pj4+IEFjdHVhbGx5LCB0aGlzIGxpdmVzIGlu
IHRoZSBsb3cgSVJRIGNvbnRleHQgd2hpY2ggbWVhbnMgdGhhdCBpdCdzIGFscmVhZHkKPj4+PiBi
ZWVuIHF1ZXVlZCBvZmYgdG8gYSB3b3JrIHRocmVhZCBzbyBpdCdzIHNhZmUgdG8gc2xlZXAuCj4+
Pj4KPj4+PiBJJ20gbm90IHN1cmUgd2Ugd2FudCBhIGdlbmVyYWwgMzAwbXMgc2xlZXAgKGV2ZW4g
YnkgZXhwZXJpbWVudCB5b3Ugc2FpZCB0aGF0Cj4+Pj4gaXQgb25seSBuZWVkZWQgMjAwbXMpIGZv
ciBhbGwgY29ubmVjdG9ycy4KPj4+Pgo+Pj4+IE5pY2hvbGFzIEthemxhdXNrYXMKPj4+Pgo+Pj4K
Pj4+IFllcywgaXQgaXMgSVJRIGNvbnRleHQuIFNhZmUgdG8gY2FsbCBzbGVlcCgpLiBNb3Jlb3Zl
ciwgaW4gY3VycmVudCBkcml2ZXIsCj4+PiBldmVuIHVkZWxheSgpIGlzIGNhbGxlZCBpbiB3YWl0
X2Zvcl90cmFpbmluZ19hdXhfcmRfaW50ZXJ2YWwoKSBpbiB0aGUgZmxvdwo+Pj4gb2YgaGFuZGxl
X2hwZF9pcnEoKS4KPj4+Cj4+PiBGb3IgMm5kIHF1ZXN0aW9uLCBvZiBjb3Vyc2Ugbm90IGFsbCBj
b25uZWN0b3JzIGhhdmUgdGhpcyBiZWhhdmlvci4KPj4+IEJhc2VkIG9uIHJlYWwgY2FzZXMgd2Ug
ZXZlciBkZWFsdCwgc29tZSBkb25nbGVzIGxpa2UgdGhpcywgb3Igc29tZQo+Pj4gbW9uaXRvcnMg
ZHJpdmVuIGJ5IFRDT04sIGhhdmUgc2FtZSBiZWhhdmlvci4gQW5kIG5vIGNoYW5jZSB0byByZWFk
Cj4+PiBvdXQgYW55dGhpbmcgdG8gZGVjaWRlIGlmIGRlbGF5IGlzIG5lZWRlZC4gVGhpcyBjaGFu
Z2UgZG9lcyBoZWxwCj4+PiB0byBoYXZlIG91ciBkcml2ZXIgZ2FpbiBiZXR0ZXIgY29tcGF0aWJp
bGl0eS4gVHJ1bHkgdGhpcyBzaG91bGQgYmUKPj4+IHByb2JsZW0gb2YgZG9uZ2xlcy9tb25pdG9y
cy4gV2UgYXJlIG5vdCB0aGUgb25seSBvbmUgdG8KPj4+IHdvcmthcm91bmQgc3VjaCBhIHByb2Js
ZW0uIFRoaXMgY2hhbmdlIGRvZXMgbm90IGh1cnQgb3RoZXIgY29ubmVjdHMsCj4+PiBhbmQgc29t
ZSBvdGhlciBkb25nbGVzIGFyZSB0ZXN0ZWQgb2ssIGUuZy4gSFAvSHV3YWkgZG9uZ2xlcywgZXRj
Lgo+Pj4KPj4KPj4gSSBzdGlsbCBkb24ndCBsaWtlIHRoaXMgY2hhbmdlLiBJdCBtaWdodCBpbXBh
Y3Qgb3RoZXIgdXNlIGNhc2VzLCBzdWNoIGFzCj4+IFNTVC10by1NU1Qgc3dpdGNoaW5nIG9uIE1T
VCBkaXNwbGF5cy4KPj4KPj4gSGF2ZSB5b3UgY2hlY2tlZCBob3cgV2luZG93cyBkZWFscyB3aXRo
IHRoaXMgZG9uZ2xlIGFuZCBob3cgdGhlIFdpbmRvd3MKPj4gdGVhbSBzb2x2ZWQgdGhpcz8gSGF2
ZSB5b3UgY2hlY2tlZCBob3cgb3RoZXIgZHJpdmVycyAoc3VjaCBhcyBpOTE1KSBkZWFsCj4+IHdp
dGggdGhpcyBkb25nbGU/Cj4+Cj4+IEhhdmUgeW91IGNoZWNrZWQgd2hldGhlciB5b3UgY2FuIHBh
c3MgRFAgY29tcGxpYW5jZSB3aXRoIHRoaXMgY2hhbmdlPwo+Pgo+PiBIYXJyeQo+Pgo+IAo+IEdv
b2QgcG9pbnRzLiBNU1QgYW5kIERQIGNvbXBsaWFuY2UgYXJlIG5vdCB2ZXJpZmllZCB5ZXQuCj4g
Cj4gRm9yIFdpbmRvd3MgY2FzZXMsIHNhbWUgc29sdXRpb24gd2FzIGltcGxlbWVudGVkLiBBcyBJ
IGtub3csIGl0IGdvZXMgdG8KPiBwb2ludCByZWxlYXNlIChQUikgaW5zdGVhZCBvZiBtYWluIGxp
bmUuIENvbXBhbnkgTi4gaGFzIHNpbWlsYXIgc29sdXRpb24KPiB0byB3b3JrYXJvdW5kIHN1Y2gg
YSBwcm9ibGVtLiBGb3IgaTkxNSwgdGhlIHNvbHV0aW9uIHNlZW1zIHRvIGJlIGRpZmZlcmVudC4K
PiAKPiBXaWxsIHRoaXMgY2hhbmdlIGJlIGFjY2VwdGVkIGlmIGl0IGNhbiBwYXNzIE1TVCBhbmQg
Y29tcGlsYW5jZT8KPiAKClNhbWUgYXMgZm9yIFdpbmRvd3MgSSdtIG5vdCBjb252aW5jZWQgdGhh
dCB0aGlzIGNoYW5nZSBzaG91bGQgZ28gaW50bwptYWlubGluZS4gSWYgdGhlIGN1c3RvbWVyIG5l
ZWRzIGEgd29ya2Fyb3VuZCB3ZSBjYW4gYWx3YXlzIHByb3ZpZGUgaXQgb24KYSBjdXN0b21lciBi
cmFuY2guCgpIYXJyeQoKPiBMb3Vpcwo+IAo+Pj4+Pgo+Pj4+Pj4gLS0tCj4+Pj4+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgNSArKysrKwo+
Pj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Pj4+Pj4KPj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jCj4+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMKPj4+Pj4+IGluZGV4IDBhZWY5MmI3YzAzNy4uNWI4NDRiNmE1YTU5IDEwMDY0NAo+Pj4+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
Ywo+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYwo+Pj4+Pj4gQEAgLTEwMjUsNiArMTAyNSwxMSBAQCBzdGF0aWMgdm9pZCBoYW5kbGVf
aHBkX2lycSh2b2lkICpwYXJhbSkKPj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGRybV9kZXZpY2Ug
KmRldiA9IGNvbm5lY3Rvci0+ZGV2Owo+Pj4+Pj4gwqDCoMKgwqDCoCBlbnVtIGRjX2Nvbm5lY3Rp
b25fdHlwZSBuZXdfY29ubmVjdGlvbl90eXBlID0gZGNfY29ubmVjdGlvbl9ub25lOwo+Pj4+Pj4g
K8KgwqDCoCAvKiBTb21lIG1vbml0b3JzL2RvbmdsZXMgbmVlZCBhcm91bmQgMjAwbXMgdG8gYmUg
cmVhZHkgZm9yCj4+Pj4+PiBjb21tdW5pY2F0aW9uCj4+Pj4+PiArwqDCoMKgwqAgKiBhZnRlciB0
aG9zZSBkZXZpY2VzIGRyaXZlIEhQRCBzaWduYWwgaGlnaC4KPj4+Pj4+ICvCoMKgwqDCoCAqLwo+
Pj4+Pj4gK8KgwqDCoCBtc2xlZXAoMzAwKTsKPj4+Pj4+ICsKPj4+Pj4+IMKgwqDCoMKgwqAgLyog
SW4gY2FzZSBvZiBmYWlsdXJlIG9yIE1TVCBubyBuZWVkIHRvIHVwZGF0ZSBjb25uZWN0b3Igc3Rh
dHVzIG9yCj4+Pj4+PiBub3RpZnkgdGhlIE9TCj4+Pj4+PiDCoMKgwqDCoMKgwqAgKiBzaW5jZSAo
Zm9yIE1TVCBjYXNlKSBNU1QgZG9lcyB0aGlzIGluIGl0J3Mgb3duIGNvbnRleHQuCj4+Pj4+PiDC
oMKgwqDCoMKgwqAgKi8KPj4+Pj4+IC0tIAo+Pj4+Pj4gMi4yMS4wCj4+Pj4+Pgo+Pj4+Pgo+Pj4+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+PiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
Pj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngKPj4+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
