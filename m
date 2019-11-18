Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B2C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 11:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610012068D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 11:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610012068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D0F6E483;
	Mon, 18 Nov 2019 11:31:30 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C506E483
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 11:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCG8blJcccwohex7yd1g3DxDSankBxrpyTbbNRVx9GzkMy8hr10OE9GLWko/nzgRiRwFveONGsR+os+DMGgcWYUAV2yjKVroUcs6UV3XZyc+Hs+faAZ9E4vVUrjTOedxv5U2hMG5qOF3tkPGcryrIAH5H84MMqGbpQ5Zj0EUHntfVQaCtA1IM7iy6DG+JrE1Gy2nJTj2FXaIrxuHJyecCoYpZpCVn9/IzxuEmRkDqKjvXnOrJwdcLQhL+Yts2pYgt1ZfkyMny0hjoo8O5d+NWPmB4KuJEGFfcU+1KXKo4Qp0AICvSYjMp7BT31PGOWIqghvFnnmET3zUbpuVCzN0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OehtVApBazrw6Q/1qGj0f6JiHxZou7qEqxUMF+TBKHc=;
 b=cLE73cfhXAsd1Kj/irpQfjl3o/IReh9EwuGL8HRNE1Y5KqadkMm1zrOHOKjpoKekC4ULDqjbSJPjfiQiw2EygWytib0jicFZd8S9VPHT9D/jJH3uhXyIiPDX21ErAWpEavJ9R4q2OYgwwwpAjcIoETI6R4SMBiIakLOR4oo12Ta8HqUVAKVp95JFJxEnMCCHom7i+X0RvaMchN9Ncds8/pCnuohEEbv0lxJ4d8glK67WTpoLoV/2gFZELmN6iPPK4BJjDHIdxpmk/JdCIoTSPc9z00xDfnEmXiIoeZVKQUFH9Y9sZF2s9mnGoGxevxMDd5hPNKDBwjg4Z0hGzYeJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1148.namprd12.prod.outlook.com (10.168.237.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 11:31:27 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 11:31:26 +0000
Subject: Re: [PATCH 07/12] amdgpu: using IB flags for TMZ or non-TMZ
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <1573788895-3936-7-git-send-email-aaron.liu@amd.com>
 <20191115093220.GA20622@ray.huang@amd.com>
 <ea9f95d8-a444-270c-85e6-ab062954320f@amd.com>
 <MN2PR12MB3838B600C9A44A584ECFF53EF04D0@MN2PR12MB3838.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7d498deb-bd7b-202c-49ec-7fb7868af33e@amd.com>
Date: Mon, 18 Nov 2019 12:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB3838B600C9A44A584ECFF53EF04D0@MN2PR12MB3838.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BEXP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::18)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fde75b3f-c275-4a46-a821-08d76c1ad930
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11486B375130BD4C249E7CC3834D0@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(13464003)(199004)(189003)(50466002)(36756003)(4326008)(5660300002)(6636002)(81166006)(81156014)(86362001)(65956001)(6512007)(110136005)(54906003)(316002)(99286004)(58126008)(31696002)(229853002)(8676002)(230700001)(386003)(14444005)(66946007)(6506007)(53546011)(478600001)(2616005)(305945005)(47776003)(14454004)(6486002)(8936002)(6436002)(25786009)(66476007)(23676004)(66556008)(2486003)(476003)(2906002)(46003)(486006)(6246003)(65806001)(11346002)(7736002)(446003)(186003)(52116002)(76176011)(6116002)(31686004)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1148;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6z6iFtiWA2ry5ADbl3aVG5wkTVGuAmy9tOw1JSkCIlBvcwDeJ87Kijtx1Y7kTRMZWH++GbA/YcR601GDHhHSg+tuEpt6jwK+1K1mSjYllXk/WYOIao4nxoItaW4HXCw0CuTlyBwRzPNEBZ8lfa1v5c71QuNFpDj08JltS1Oiq5GUABdDwC+h2qpA2er9iOlvs+ens9NLPHoekfOuP5iGyYAfMm+Mz59g251QESidAyznYhBxji30z/bZq7RO4jEhEd6yfju4XmfooLqwapoRgaTBSnFyZe7MImM+jl6gz342rVpSja6RLbs5eR+Egozr/kZw0HLqKXaUDkhk2rzxluqCxLeWk7IhShMbN0YD4xugnNKtdnepYXcBginUcZ8PbiXOERO6cZ96G/vj/QEIYD348QIyAtx5PVyYgiW51rRtmUeyT7frG7O73GPdnXt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde75b3f-c275-4a46-a821-08d76c1ad930
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 11:31:26.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMsOvg7pyzuEh/IxPn7vFPQOJk96YGWJGWdcVUA4JinRbINIH5T1xOuolrtTpaF6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OehtVApBazrw6Q/1qGj0f6JiHxZou7qEqxUMF+TBKHc=;
 b=fQS4VlSHR4+4XQJrp8t/GzrSAn0ySzCuMsuR/5a8miSnyrfgPimAKEpdz2pLGYtvQb5805v4zvec6RPvX1FdmICkUZMZMllNQ9vI8yIvsT8zeuLHUrpbLzpE0cq4xNxZdVGBQHcO9U7JiMujzdjX+dTe8UOfkeLMGXbxPbH42C8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118113120.GUTr7tOnYFXB_4dal7QKpudNVVfFBrgVOCdiyUet7uc@z>

QW0gMTguMTEuMTkgdW0gMTA6MTkgc2NocmllYiBMaXUsIEFhcm9uOgo+Cj4gQlIsCj4gQWFyb24g
TGl1Cj4KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4KPj4gU2VudDogRnJpZGF5LCBOb3ZlbWJl
ciAxNSwgMjAxOSA4OjUwIFBNCj4+IFRvOiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47
IExpdSwgQWFyb24gPEFhcm9uLkxpdUBhbWQuY29tPgo+PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcgo+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IE9sc2FrLCBNYXJlayA8TWFyZWsuT2xzYWtAYW1kLmNvbT47Cj4+IExpdSwgTGVvIDxM
ZW8uTGl1QGFtZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4KPj4g
U3ViamVjdDogUmU6IFtQQVRDSCAwNy8xMl0gYW1kZ3B1OiB1c2luZyBJQiBmbGFncyBmb3IgVE1a
IG9yIG5vbi1UTVoKPj4KPj4gQW0gMTUuMTEuMTkgdW0gMTA6MzIgc2NocmllYiBIdWFuZyBSdWk6
Cj4+PiBPbiBGcmksIE5vdiAxNSwgMjAxOSBhdCAxMTozNDo1MEFNICswODAwLCBMaXUsIEFhcm9u
IHdyb3RlOgo+Pj4+IEluIGtlcm5lbCwgY3MtPmluLmZsYWdzIGlzIHVzZWQgZm9yIFRNWi4gSGVu
Y2UgbGliZHJtIHNob3VsZCB0cmFuc2Zlcgo+Pj4+IHRoZSBmbGFnIHRvIGtlcm5lbC4KPj4+Pgo+
Pj4+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+Cj4+Pj4gLS0t
Cj4+Pj4gICAgYW1kZ3B1L2FtZGdwdS5oICAgIHwgNCArKystCj4+Pj4gICAgYW1kZ3B1L2FtZGdw
dV9jcy5jIHwgNCArKysrCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9hbWRncHUvYW1kZ3B1LmggYi9h
bWRncHUvYW1kZ3B1LmggaW5kZXgKPj4gZjQ1ZjlmNy4uYWVlM2YzZAo+Pj4+IDEwMDY0NAo+Pj4+
IC0tLSBhL2FtZGdwdS9hbWRncHUuaAo+Pj4+ICsrKyBiL2FtZGdwdS9hbWRncHUuaAo+Pj4+IEBA
IC0zNDIsNyArMzQyLDkgQEAgc3RydWN0IGFtZGdwdV9jc19mZW5jZV9pbmZvIHsKPj4+PiAgICAg
KiBcc2EgYW1kZ3B1X2NzX3N1Ym1pdCgpCj4+Pj4gICAgKi8KPj4+PiAgICBzdHJ1Y3QgYW1kZ3B1
X2NzX3JlcXVlc3Qgewo+Pj4+IC0JLyoqIFNwZWNpZnkgZmxhZ3Mgd2l0aCBhZGRpdGlvbmFsIGlu
Zm9ybWF0aW9uICovCj4+Pj4gKwkvKiogU3BlY2lmeSBmbGFncyB3aXRoIGFkZGl0aW9uYWwgaW5m
b3JtYXRpb24KPj4+PiArCSAqIDAtbm9ybWFsLCAxLXRtego+Pj4+ICsJICovCj4+Pj4gICAgCXVp
bnQ2NF90IGZsYWdzOwo+Pj4+Cj4+Pj4gICAgCS8qKiBTcGVjaWZ5IEhXIElQIGJsb2NrIHR5cGUg
dG8gd2hpY2ggdG8gc2VuZCB0aGUgSUIuICovIGRpZmYKPj4+PiAtLWdpdCBhL2FtZGdwdS9hbWRn
cHVfY3MuYyBiL2FtZGdwdS9hbWRncHVfY3MuYyBpbmRleAo+Pj4+IDQzN2M0YTQuLjZmNzA3NzEg
MTAwNjQ0Cj4+Pj4gLS0tIGEvYW1kZ3B1L2FtZGdwdV9jcy5jCj4+Pj4gKysrIGIvYW1kZ3B1L2Ft
ZGdwdV9jcy5jCj4+Pj4gQEAgLTI1NCw2ICsyNTQsMTAgQEAgc3RhdGljIGludAo+PiBhbWRncHVf
Y3Nfc3VibWl0X29uZShhbWRncHVfY29udGV4dF9oYW5kbGUgY29udGV4dCwKPj4+PiAgICAJbWVt
c2V0KCZjcywgMCwgc2l6ZW9mKGNzKSk7Cj4+Pj4gICAgCWNzLmluLmNodW5rcyA9ICh1aW50NjRf
dCkodWludHB0cl90KWNodW5rX2FycmF5Owo+Pj4+ICAgIAljcy5pbi5jdHhfaWQgPSBjb250ZXh0
LT5pZDsKPj4+PiArCS8qIGluIGtlcm5lbCwgX3BhZCBpcyB1c2VkIGFzIGZsYWdzCj4+Pj4gKwkg
KiAjZGVmaW5lIEFNREdQVV9DU19GTEFHU19TRUNVUkUgICAgICAgICAgKDEgPDwgMCkKPj4+PiAr
CSAqLwo+Pj4+ICsJY3MuaW4uX3BhZCA9ICh1aW50MzJfdClpYnNfcmVxdWVzdC0+ZmxhZ3M7Cj4+
PiBfcGFkIGlzIG5vdCBnb29kIGhlcmUuIEJlY2F1c2UgaXQncyB1c2VkIHRvIHBhc3MgdGhlIGZs
YWdzIHRvIGlucHV0IHBhcmFtLgo+Pj4KPj4+IEl0J3MgYmV0dGVyIHRvIHJlbmFtZSAiX3BhZCIg
aW4gZHJtX2FtZGdwdV9jc19pbiBhcyAiZmxhZ3MiIGhlcmUuCj4+IEFjdHVhbGx5IEkgZG9uJ3Qg
dGhpbmsgd2UgbmVlZCB0aGF0IHN0dWZmIGFsdG9nZXRoZXIsIHBsZWFzZSBzeW5jIHVwIHdpdGgK
Pj4gTWFyZWsgb24gdGhpcy4KPj4KPj4gQXMgZmFyIGFzSSBrbm93IHRoZSB3aG9sZSBhbWRncHVf
Y3Nfc3VibWl0IGludGVyZmFjZSB3YXMgZGVwcmVjYXRlZCBpbgo+PiBmYXZvciBvZiB0aGUgbmV3
IGFtZGdwdV9jc19zdWJtaXRfcmF3KCkgaW50ZXJmYWNlLgo+IENocmlzdGlhbiwgTWFyZWssCj4g
SW4gYWRkaXRpb24gdG8gc3luY29ial9jb21tYW5kX3N1Ym1pc3Npb25faGVscGVyIHVzZXMgYW1k
Z3B1X2NzX3N1Ym1pdF9yYXcsCj4gdGhlIG90aGVyIHRlc3Qgc3VpdGVzIHN0aWxsIHVzZSBvbGRl
ciBpbnRlcmZhY2UoYW1kZ3B1X2NzX3N1Ym1pdCkuIFdlJ2QgYmV0dGVyIHRvCj4gcmVvcmdhbml6
ZSB0aGUgcmVsZXZhbnQgY29kZXMuIFRoaXMgZG9lcyBub3QgbWFrZSBtdWNoIHNlbnNlIHRvIG9u
bHkgbW9kaWZ5IG9uZSBjYWxsLgoKV2VsbCBpbiB0aGlzIGNhc2UgeW91IG5lZWQgdG8gY2hhbmdl
IGFsbCBvdGhlciB0ZXN0IGNhc2VzIHRvIHVzZSAKYW1kZ3B1X2NzX3N1Ym1pdF9yYXcgYXMgd2Vs
bC4KCkkgd2lsbCBjZXJ0YWlubHkgcmVqZWN0IGFueSBjaGFuZ2VzIHRvIHRoZSBkZXByZWNhdGVk
IGNvbW1hbmQgc3VibWlzc2lvbiAKaW50ZXJmYWNlLgoKVGhhdCBoYXMganVzdCB3YXkgdG8gbXVj
aCBwb3RlbnRpYWwgdG8gYnJlYWsgb2xkZXIgdmVyc2lvbnMgb2YgdGhlIAp1c2Vyc3BhY2Ugc3Rh
Y2sgaW4gdW5mb3Jlc2VlbiB3YXlzLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+Cj4+IFJlZ2Fy
ZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+IFRoYW5rcywKPj4+IFJheQo+Pj4KPj4+PiAgICAJaWYg
KGlic19yZXF1ZXN0LT5yZXNvdXJjZXMpCj4+Pj4gICAgCQljcy5pbi5ib19saXN0X2hhbmRsZSA9
IGlic19yZXF1ZXN0LT5yZXNvdXJjZXMtPmhhbmRsZTsKPj4+PiAgICAJY3MuaW4ubnVtX2NodW5r
cyA9IGlic19yZXF1ZXN0LT5udW1iZXJfb2ZfaWJzOwo+Pj4+IC0tCj4+Pj4gMi43LjQKPj4+PgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
