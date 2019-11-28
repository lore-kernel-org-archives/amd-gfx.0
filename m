Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D12C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 14:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C37E21741
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 14:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C37E21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE3C6E830;
	Thu, 28 Nov 2019 14:35:36 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720042.outbound.protection.outlook.com [40.107.72.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9F56E830
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 14:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In6QYdzP4HQ4uNa65+WURbx4p/xShlxjnEy+jVk3xQ/OBb62I0O/QWto/Hn6OSmLBsdWojNq/uSmLBcCI+Cqd1b5oqraiqkIFilMOqJFitRMSa/UmkBZXBbryi9RA9nOfL7PDi4OtRz1h/XNjSIRLjy2txn1dLYVYUyh9v7KMIKTVbaGRwtH7TYb2l+ejxwfGlc3SyNlmBmhejv3/DmS8bOlXBkBUbGVSXeUrKEcWjoYvqzd0E9iNmN4keCLNQbjDi8q8jkY3iHNUzCkukQicgg/zkPwUTNdD0P9gTwCZhpGY8V6fRc5VXanoIfi9dVRctD2epzzgJ81A2RViKvKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKTrYjI5QDPOAPlwVB4lOtN2Y6BBZI9fOoNt8taZ8lg=;
 b=a0nkNTvOqq4sJvHBh6oHU2TSWR3cwiv5Q+O+4ZkkDygnapBCgJ7Yo6yfjvS0i/97+sbfU9SyDUEMipqDAjujP0UNqd4eAAYL+akMB9QmueWyhU6GYfew0pZtc2ExPZDXvH7SsoF2PeV8ox22l0L/hEl6h/FJzgn3wvhJ6HmAQMHcXg7p5ixVseMQr9DLwiuBxoeguT0jI0qO7BiyQkQMC3Ju++lhFXrEVgs08QeNtVy9MT7boEGwDKHsfnRjx4HU8rVOeLrxpKO/NJgjgMSqP86jITBrY4Lv+XK5SgeXjdmH/etNUJcGiAYKrvhPS80+vKcBqX4uyEpA7+dsfnyzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0005.namprd12.prod.outlook.com (10.172.116.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 28 Nov 2019 14:35:25 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::1cdc:d782:cce:6d2b]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::1cdc:d782:cce:6d2b%9]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 14:35:25 +0000
Subject: Re: [PATCH] drm/amd/display: Fix wrongly passed static prefix
To: Takashi Iwai <tiwai@suse.de>, Harry Wentland <harry.wentland@amd.com>
References: <20191128082714.18609-1-tiwai@suse.de>
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
Message-ID: <8a2e290c-f06d-07e6-3768-59f40539bf7d@amd.com>
Date: Thu, 28 Nov 2019 09:35:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191128082714.18609-1-tiwai@suse.de>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5207ec7e-7856-4b9b-033b-08d7741034d6
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:|CY4PR1201MB0005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0005028D4AF4C97FB5A21D4D8C470@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-Forefront-PRVS: 0235CBE7D0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(189003)(199004)(11346002)(66476007)(66556008)(25786009)(66946007)(6512007)(478600001)(3846002)(6116002)(446003)(14444005)(2616005)(6636002)(4001150100001)(6246003)(31696002)(99286004)(4326008)(316002)(81166006)(58126008)(8936002)(81156014)(31686004)(54906003)(110136005)(8676002)(229853002)(26005)(50466002)(23676004)(2486003)(52116002)(76176011)(386003)(5660300002)(6506007)(53546011)(2870700001)(2906002)(305945005)(14454004)(47776003)(36756003)(6436002)(7736002)(186003)(65806001)(65956001)(66066001)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0005;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAFok5AobHko/6WlVWeUgSX+MgrV0FgbwS7QkFEnmjdJUeZVjPjzk4GAoJ/2UsL3gupcpWM22qEGDTZfE+ANnX5SgKzXhfxPEUXM2aGgF6pmFCUd7ssjYSS5rQwib7pqLgmibOfFi5MkFQGr8zHOYWSfBoyAYHfjtFu3HAkGCF8FijYL1pG5IvJRKSa1tpT22PYlYDP7Bzck6JCZ8GWjl1KbQN4xF4BXz1ccHOtK6T7LYQMw0E3eAM5r8jRmr/Ho+9cLQhJzgnwDNLpiz4/abZHY3hweTdi3do4pnOdDu7dhWCEGlIOhsXM3ZC45YeO1XEzoRdXQFuxL0c/5CU171oimieWKcbVMDVLYYFh+TgbaC2fLCIRXSCVdZ+cMTkH/AtYyWmHM3mHZoMScgcgtL65lshhC/xZpOUKgPbss3qa76jYlb5aWJ2WISmqnURPz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5207ec7e-7856-4b9b-033b-08d7741034d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 14:35:25.4692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEC45NPUt0j7tfMpf+DeDMKxj4ndJ14LRnJqLYTlFAMsTBoV/0haBL3WXDl2orlJ4vZpJSyHKMj2wWe8sQAT8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKTrYjI5QDPOAPlwVB4lOtN2Y6BBZI9fOoNt8taZ8lg=;
 b=knBA+DEO5Dz2pWnxwcNdi5ZwBLdSjwiPy5DhbdEnNOyxJeIPl648QRShDTgfm19e9FZgTKtKkyFZNkLls9/wqr68ZFST99BBeS6+sySlHPRhH8B8gGZGXyT21YyV9EzNo588EQojNhmLc2YNrYNH978NUCG3XvnXLAJ4+u+3MoU=
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
Cc: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, David Zhou <David1.Zhou@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128143523.SulAu75w_NgQFyHs37brLvJibEma98UERrezhtkjks8@z>

T24gMjAxOS0xMS0yOCAzOjI3IGEubS4sIFRha2FzaGkgSXdhaSB3cm90ZToKPiBDdXJyZW50bHks
IGdjYyBzcGV3cyBhIHdhcm5pbmcgYXM6Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8u
Li9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h1YmJ1Yi5jOiBJbiBmdW5jdGlvbiDigJhodWJidWIx
X3ZlcmlmeV9hbGxvd19wc3RhdGVfY2hhbmdlX2hpZ2jigJk6Cj4gICAuL2luY2x1ZGUvZHJtL2Ry
bV9wcmludC5oOjMxNjoyOiB3YXJuaW5nOiDigJhkZWJ1Z19kYXRh4oCZIG1heSBiZSB1c2VkIHVu
aW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQo+IAo+
IFRoaXMgaXMgYmVjYXVzZSB0aGUgY29kZSBjaGVja3MgYWdhaW5zdCBhIHN0YXRpYyB2YWx1ZSBh
bHRob3VnaCBpdCdzCj4gYmFzaWNhbGx5IGEgY29uc3RhbnQgYW5kIGd1YXJhbnRlZWQgdG8gYmUg
c2V0Lgo+IAo+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgdHlwZSBwcmVmaXggZnJvbSBzdGF0aWMg
dG8gY29uc3QgZm9yIGFkZHJlc3NpbmcKPiB0aGUgY29tcGlsZSB3YXJuaW5nIGFib3ZlIGFuZCBh
bHNvIGZvciBsZXR0aW5nIHRoZSBjb21waWxlciBvcHRpbWl6ZQo+IGJldHRlci4KPiAKPiBGaXhl
czogNjJkNTkxYThlMDBjICgiZHJtL2FtZC9kaXNwbGF5OiBjcmVhdGUgbmV3IGZpbGVzIGZvciBo
dWJidWIgZnVuY3Rpb25zIikKPiBTaWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1
c2UuZGU+CgpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5j
b20+CgpIYXJyeQoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEw
L2RjbjEwX2h1YmJ1Yi5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24xMC9kY24xMF9odWJidWIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24xMC9kY24xMF9odWJidWIuYwo+IGluZGV4IGEwMmMxMGUyM2UwZC4uYjVjNDRj
M2JkYjk4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24x
MC9kY24xMF9odWJidWIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24xMC9kY24xMF9odWJidWIuYwo+IEBAIC0xMjgsOCArMTI4LDggQEAgYm9vbCBodWJidWIxX3Zl
cmlmeV9hbGxvd19wc3RhdGVfY2hhbmdlX2hpZ2goCj4gIAkgKiBwc3RhdGUgdGFrZXMgYXJvdW5k
IH4xMDB1cyBvbiBsaW51eC4gVW5rbm93biBjdXJyZW50bHkgYXMgdG8KPiAgCSAqIHdoeSBpdCB0
YWtlcyB0aGF0IGxvbmcgb24gbGludXgKPiAgCSAqLwo+IC0Jc3RhdGljIHVuc2lnbmVkIGludCBw
c3RhdGVfd2FpdF90aW1lb3V0X3VzID0gMjAwOwo+IC0Jc3RhdGljIHVuc2lnbmVkIGludCBwc3Rh
dGVfd2FpdF9leHBlY3RlZF90aW1lb3V0X3VzID0gNDA7Cj4gKwljb25zdCB1bnNpZ25lZCBpbnQg
cHN0YXRlX3dhaXRfdGltZW91dF91cyA9IDIwMDsKPiArCWNvbnN0IHVuc2lnbmVkIGludCBwc3Rh
dGVfd2FpdF9leHBlY3RlZF90aW1lb3V0X3VzID0gNDA7Cj4gIAlzdGF0aWMgdW5zaWduZWQgaW50
IG1heF9zYW1wbGVkX3BzdGF0ZV93YWl0X3VzOyAvKiBkYXRhIGNvbGxlY3Rpb24gKi8KPiAgCXN0
YXRpYyBib29sIGZvcmNlZF9wc3RhdGVfYWxsb3c7IC8qIGhlbHAgd2l0aCByZXZlcnQgd2EgKi8K
PiAgCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
