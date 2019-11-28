Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C38C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 20:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C2A216F4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 20:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C2A216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6016E030;
	Thu, 28 Nov 2019 20:23:18 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700047.outbound.protection.outlook.com [40.107.70.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4287B6E030
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 20:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXsOVmZDjfRUXden43yFBg/7vnEg4SijGPgbTHk6mxnqFl2beHwFfcskjbQCv/yw57e895HcQO+obOWcSS9agr+H2RRp/G39JsowM4M1NCISXE9z1zaFytcHgdHLhaCcy9zVk3U3ywGsoDDRWydUSIlr6muzWYqJawsRKY/lOs0FYJ/bkZKlCFXUEbE1kmHeiOT1VzPerRQXfdFgaxfbwuyK33scTVMJAKtfV2+T/rBnc6vR1mv1ex9+0mli6Km7WlQBo3EJBJpitbBSG11NspDF8WJslfWme1IrDa8vu0wCR8MInbs5/ydqZJrP16oJp0fL67rC1a5FldaUXxD7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkgXlY7Xx7hAKv3GEeZ/WeZAyi08XJsLUBLB4Q1/J0U=;
 b=PvM4wbUWyLNe4cNGZXA6KiZLLyHz2O5/YElIRXeRSBd4Ob+rs77QQPiJlnqa+XHBeFRpwBy/vr93rnw9rWwcIJHnew/O5CPGFaNCV4yisx0o1uNwh1bXyavITKqVRv1bsxxGyGXYo5my6qJhxvMKOIHKR06TRGfnk8rHxFYSEzU2Y0OdCuGqNibq1twTyXO/qWN9lhDka1hki0VO1Z01PXRcqxwAL9WDfFwMU3CL1AEPTv3K0+1ZFnWFpiydw4bNjv1UGcUAF8Wcq6b5g5qNL2kyGw1GY1OZbn+oQo9RJpvlBpGe2E36cffcmcZi1HZLaN2YqoEKSec2kaUNhCjDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0054.namprd12.prod.outlook.com (10.172.77.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Thu, 28 Nov 2019 20:23:14 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::1cdc:d782:cce:6d2b]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::1cdc:d782:cce:6d2b%9]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 20:23:14 +0000
Subject: Re: [PATCH] drm/amd/display: Load TA firmware for navi10/12/14
To: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20191108215721.13316-1-Bhawanpreet.Lakha@amd.com>
 <DM5PR12MB1820C10A42B4FFC83A093710F77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
 <e883aa84-0a91-d562-3501-927cba50f61d@amd.com>
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
Message-ID: <709008a6-88fe-1238-7a75-5ef3ed9361a5@amd.com>
Date: Thu, 28 Nov 2019 15:23:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <e883aa84-0a91-d562-3501-927cba50f61d@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f880eb97-b6e8-45d2-1ed4-08d77440cb91
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0054:|CY4PR1201MB0054:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00548AF02A69608DC72968838C470@CY4PR1201MB0054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-Forefront-PRVS: 0235CBE7D0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(386003)(52116002)(66066001)(25786009)(31686004)(65956001)(53546011)(2501003)(966005)(66556008)(65806001)(11346002)(478600001)(2486003)(14454004)(66476007)(66946007)(446003)(14444005)(2616005)(23676004)(4001150100001)(8936002)(6116002)(3846002)(76176011)(6436002)(8676002)(99286004)(81156014)(6486002)(6246003)(6506007)(316002)(31696002)(81166006)(26005)(6512007)(110136005)(2906002)(2870700001)(6636002)(36756003)(186003)(50466002)(58126008)(6306002)(229853002)(5660300002)(47776003)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0054;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipCmfI1BU1Qgm4QDKCoYLAA7VqfJoNY0IMT4CaJC9YxIHOW+P3PYQ2QpUSKsZvtMSsPUoSMjgntfgd0HJjzp5oRJxFVFtOM2AkWTbPMwKDE/HiIpgQKl/VTJaJBerBB14SA3Znx0g6V9QvQQeW0g3/P5u5KHsXLXLGyk89ebcDE+7IbMPxGpr6IQQEIH8mRcONY/4KGPVvttrWQz3OH6JEWKpqSgxGcjxbmFuYzgmK0CdmFg2Uo/FunwOnfqQFRxB77Vexjcvc78HZ4y1tRArwUWi/TlZahDisxLWl6omA4+gjTyk75ZXxG0CTpWDjhFQSJvildI7vW1zra/q/FczT3IfjekDSdZf2gbzCNdcdG7jO/SdtJD14TQmZpUc8dyRCQs4Gqt7gKHv4eOlIkaEYS02v0v3SVwyjO7oa+pWFhwJNx66WSDXJi77jkQahz+7/BFSXa8QPoF9npTsQm5eiE5FsH0vTo4FxXV9e2WaXw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f880eb97-b6e8-45d2-1ed4-08d77440cb91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 20:23:14.4246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LL6E+c5ec1MaUMz0+ovlNbmndFEEXqWCLIOXcDkuImyj3QbQq90vHBRy7PRkvK0ofL1BjndNf8xWYs3hTF+OtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0054
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkgXlY7Xx7hAKv3GEeZ/WeZAyi08XJsLUBLB4Q1/J0U=;
 b=gTAxSdniLDMuvpJ3L65hgOAWwPia7jIG6sBgncfszM+qoss3qutQ20okWfdTad65cd1ZD7njoeHBPLVBO6obTjO9LAgPloirbza3yOwrwTcKzKsv5fIFL7f9GffNIJuy5H7BFGBAkNv+ExXH50NbrO68cBkuhlom6DjesW1qXKk=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128202312.oI8szqXOzbw7zwwlQGmGR-kdHDrcnKqdzlLQAt09jNk@z>

CgpPbiAyMDE5LTExLTI4IDM6MjAgcC5tLiwgQmhhd2FucHJlZXQgTGFraGEgd3JvdGU6Cj4gSGV5
IEhhcnJ5IGNhbiB5b3UgcGxlYXNlIHRha2UgYSBsb29rIHRoYW5rcwo+IAo+IE9uIDIwMTktMTEt
MDggNTowMSBwLm0uLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3JvdGU6Cj4+IEFja2VkLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
PiAqRnJvbToqIGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+
IG9uIGJlaGFsZiBvZgo+PiBCaGF3YW5wcmVldCBMYWtoYSA8Qmhhd2FucHJlZXQuTGFraGFAYW1k
LmNvbT4KPj4gKlNlbnQ6KiBGcmlkYXksIE5vdmVtYmVyIDgsIDIwMTkgNDo1NyBQTQo+PiAqVG86
KiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+Cj4+ICpDYzoqIExha2hhLCBCaGF3YW5wcmVldCA8Qmhhd2FucHJlZXQuTGFraGFAYW1k
LmNvbT4KPj4gKlN1YmplY3Q6KiBbUEFUQ0hdIGRybS9hbWQvZGlzcGxheTogTG9hZCBUQSBmaXJt
d2FyZSBmb3IgbmF2aTEwLzEyLzE0Cj4+IMKgCj4+IGxvYWQgdGhlIHRhIGZpcm13YXJlIGZvciBu
YXZpMTAvMTIvMTQuCj4+IFRoaXMgaXMgYWxyZWFkeSBiZWluZyBkb25lIGZvciByYXZlbi9waWNh
c3NvIGFuZAo+PiBpcyBuZWVkZWQgZm9yIHN1cHBvcnRpbmcgaGRjcCBvbiBuYXZpCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29t
PgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgoK
SGFycnkKCj4+IC0tLQo+PiDCoGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5j
IHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoDEgZmlsZSBjaGFuZ2VkLCAyNSBp
bnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9wc3BfdjExXzAuYwo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5j
Cj4+IGluZGV4IGZmZWFhMmY1NTg4ZC4uZGFmMTFiZTU0MTZmIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYwo+PiBAQCAtMTg2LDYgKzE4NiwzMSBAQCBzdGF0aWMg
aW50IHBzcF92MTFfMF9pbml0X21pY3JvY29kZShzdHJ1Y3QKPj4gcHNwX2NvbnRleHQgKnBzcCkK
Pj4gwqDCoMKgwqDCoMKgwqDCoCBjYXNlIENISVBfTkFWSTEwOgo+PiDCoMKgwqDCoMKgwqDCoMKg
IGNhc2UgQ0hJUF9OQVZJMTQ6Cj4+IMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBDSElQX05BVkkxMjoK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc25wcmludGYoZndfbmFtZSwgc2l6ZW9m
KGZ3X25hbWUpLCAiYW1kZ3B1LyVzX3RhLmJpbiIsCj4+IGNoaXBfbmFtZSk7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IHJlcXVlc3RfZmlybXdhcmUoJmFkZXYtPnBzcC50
YV9mdywgZndfbmFtZSwKPj4gYWRldi0+ZGV2KTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKGVycikgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmVsZWFzZV9maXJtd2FyZShhZGV2LT5wc3AudGFfZncpOwo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+cHNwLnRhX2Z3ID0gTlVM
TDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9p
bmZvKGFkZXYtPmRldiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJwc3AgdjExLjA6IEZhaWxlZCB0byBsb2FkIGZpcm13
YXJlCj4+IFwiJXNcIlxuIiwgZndfbmFtZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0gZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlcnIgPSBhbWRncHVfdWNvZGVfdmFsaWRhdGUoYWRldi0+cHNwLnRhX2Z3KTsKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIpCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBvdXQyOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0YV9oZHIgPSAoY29uc3Qgc3RydWN0IHRhX2Zpcm13YXJlX2hlYWRlcl92MV8w
Cj4+ICopYWRldi0+cHNwLnRhX2Z3LT5kYXRhOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+cHNwLnRhX2hkY3BfdWNvZGVfdmVyc2lvbiA9Cj4+
IGxlMzJfdG9fY3B1KHRhX2hkci0+dGFfaGRjcF91Y29kZV92ZXJzaW9uKTsKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPnBzcC50YV9oZGNwX3Vj
b2RlX3NpemUgPQo+PiBsZTMyX3RvX2NwdSh0YV9oZHItPnRhX2hkY3Bfc2l6ZV9ieXRlcyk7Cj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5wc3Au
dGFfaGRjcF9zdGFydF9hZGRyID0gKHVpbnQ4X3QgKil0YV9oZHIgKwo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4+IGxlMzJf
dG9fY3B1KHRhX2hkci0+aGVhZGVyLnVjb2RlX2FycmF5X29mZnNldF9ieXRlcyk7Cj4+ICsKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPnBzcC50
YV9md192ZXJzaW9uID0KPj4gbGUzMl90b19jcHUodGFfaGRyLT5oZWFkZXIudWNvZGVfdmVyc2lv
bik7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGFkZXYtPnBzcC50YV9kdG1fdWNvZGVfdmVyc2lvbiA9Cj4+IGxlMzJfdG9fY3B1KHRhX2hkci0+
dGFfZHRtX3Vjb2RlX3ZlcnNpb24pOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYWRldi0+cHNwLnRhX2R0bV91Y29kZV9zaXplID0KPj4gbGUzMl90b19j
cHUodGFfaGRyLT50YV9kdG1fc2l6ZV9ieXRlcyk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5wc3AudGFfZHRtX3N0YXJ0X2FkZHIgPSAodWlu
dDhfdAo+PiAqKWFkZXYtPnBzcC50YV9oZGNwX3N0YXJ0X2FkZHIgKwo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxlMzJfdG9f
Y3B1KHRhX2hkci0+dGFfZHRtX29mZnNldF9ieXRlcyk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+
IMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdDoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgQlVHKCk7Cj4+IC0tIAo+PiAyLjE3LjEKPj4KPj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
