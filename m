Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F76C4332B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 09:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687222072D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 09:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X9tUzXVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687222072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22AFF89DC9;
	Mon, 23 Mar 2020 09:07:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA6289DC9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 09:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtUBcKdV49n6EgYfUUD26QW0aqXKSsChcI9t1lCT5G4lWIUTbZgnNVDj//wFSMMaVdr09IBSdlacdmWEmA+AJlYQNyJ5kfo0HoPC9TYxP4fQ9XwIl5qnsvbhbs1l2Qhbp6c4WoeEWDuQ9LSdFjZgqaS73aTzOD5kSEviWsEwLAV6Rt1/KECDwXSAlqp140AMQZSeCylt7h/ZCuKnD5V1nnWW3BSL8+qz7QDlMJlMlyYeekNVoadx9mt+Jr8jyEnEzYnEVkn/uWGHgOSralDJ3UmylNShhS0oT7aY4lEM+mx8zDQX8QGaqlVqrWjQNIS2TCHSwcsyt8Rfeg0hqJngjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDk8YFXA5UMSSASLJuZuvgZcg3bz9Eq8u4bQ6HxbAn0=;
 b=laOHR5bv+vc+LdGbYro5mPH+6lb6PTSJ83rnux3OFQrSx/YS5kzpQSVdlUCr2WmIks3BlUuYQIBjgR01r9Zww0x0/s0GocZr7ksqKNezSVShD7rnF1kS0IjvjwsToqNf8X3pLI1QGrEn43F/BiNVhS9FspIn8MVXGPir9FlEYhXV9VVGomhk4rqTUdy8ZC26OvWxX82YcERklGM4cBnIYhZisXfpPP65Ngo7wZ+WZuea7RD3MVSYXBJrZvY8ltCcpPIgg0CQsMPvImWivffil4kZpBeyHq1DAe62fPvPPLiCJ7ScAbesvTPqFoV2c3cxLNFbjrzLahHcb/tP46hyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDk8YFXA5UMSSASLJuZuvgZcg3bz9Eq8u4bQ6HxbAn0=;
 b=X9tUzXVOSZzux+SU/hWa2Vdhz/HtuVOkCgSo55EH0zU/Lp1ScEw3OHnwk7Cy8CB+MmvKr966XKoyCFeHrkWDbxpK3ak33QuKFhjCCCOYn5/1FvfLXcT9asBzP7ecwTgSNkFg0G5ksgB2I1cHi8vN37zbGHurcthT73PdnEvC5Qc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 09:07:25 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::2837:8b52:486b:ef0b]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::2837:8b52:486b:ef0b%4]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 09:07:25 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add full TMZ support into
 amdgpu_ttm_map_buffer v2
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com
References: <20200322154835.2702-1-christian.koenig@amd.com>
 <20200322154835.2702-2-christian.koenig@amd.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <0ec03ebb-a5d7-0548-d23c-0c82d34ed72f@amd.com>
Date: Mon, 23 Mar 2020 10:07:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200322154835.2702-2-christian.koenig@amd.com>
Content-Language: fr
X-ClientProxiedBy: PR0P264CA0192.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::36) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.219] (109.190.135.109) by
 PR0P264CA0192.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Mon, 23 Mar 2020 09:07:23 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9adf205b-9e63-4942-369e-08d7cf099a42
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2459893613D5E5914917F7038DF00@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(86362001)(55236004)(66476007)(31696002)(53546011)(66946007)(6486002)(8676002)(66556008)(26005)(81166006)(8936002)(52116002)(36756003)(2906002)(6636002)(478600001)(16576012)(31686004)(316002)(186003)(5660300002)(2616005)(81156014)(16526019)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2459;
 H:MW2PR12MB2586.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHSXZAZPUQ65I86kMzpnIcpxIfNpU27EggS6bikMQjOwBRue44PTj5FEPgSvilwuvyF4Oi9W72+Dx4u0OAKB+RNW4EGwuvH5gFWHumjbiPko5KgdL1Lf1LIdxHQSL0vPs4B3ZEdJRkCoai3lGWHI7n5TekfmATMb70OwU2LE64lZYzQFXiWp9ILTVpF0RVtEIA9t2EJBMygZkf06MSUwx/f8jisYHpk/Xikbu9+MLF6h31HDkOBnPpP5l6hqkk/S4i0W46BVxLMbQp3PDFlUbo9zvqp1LZyvJG6RGQVcPzKWBNF2UJkZNJMxzqwr/N4TOWLsAhSgw5Qh1ml+LYBTLDU+EScYlaUlmcgOfXBAJ+CBojccAwNvjcikveHrwaK1/xfv1rzSygfkX4aEgglethhD7Yj/gYN5XZSKg+9ummJnmUdo0jfKgZqPkXBwljEV
X-MS-Exchange-AntiSpam-MessageData: YYq87AP+a7Npe/du+Z1MbJ7Snocs3S098c0bmQRqMWA2cWz+LFh5Ftpe1qQVx3caCmtI20n/9dfm78Lr+BpfcAPwVQea7w7WHjzqD302LQUHIggs5fWtoO3tmHOpePzdHyN8yvM4yaurjknGcq0OqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adf205b-9e63-4942-369e-08d7cf099a42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 09:07:24.8918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRU7e+aVgqGLhMGjaHRs7HcfIPcWOScsRfDarzFN6LjGyJsHmeTt1f01rFKXxw/CY3USFO8VsILm9TxAuylW5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKVGhlIDIgcGF0Y2hlcyBhcmU6CiAgVGVzdGVkLWJ5OiBQaWVycmUtRXJp
YyBQZWxsb3V4LVByYXllciA8cGllcnJlLWVyaWMucGVsbG91eC1wcmF5ZXJAYW1kLmNvbT4KClRo
YW5rcywKUGllcnJlLUVyaWMKCk9uIDIyLzAzLzIwMjAgMTY6NDgsIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4gVGhpcyBzaG91bGQgYWxsb3cgdXMgdG8gYWxzbyBzdXBwb3J0IFZSQU0tPkdUVCBt
b3Zlcy4KPiAKPiB2MjogZml4IG1pc3NpbmcgdnJhbV9iYXNlX2FkanVzdG1lbnQKPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4g
LS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDM4ICsrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jCj4gaW5kZXggNTNkZTk5ZGJhZWFkLi5lMTVhMzQzYTk0NGIgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAgLTMwOSwyMSArMzA5LDIxIEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9tYXBfYnVmZmVyKHN0cnVjdCB0dG1fYnVmZmVyX29iamVj
dCAqYm8sCj4gIAkJCQkgdW5zaWduZWQgd2luZG93LCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcs
Cj4gIAkJCQkgYm9vbCB0bXosIHVpbnQ2NF90ICphZGRyKQo+ICB7Cj4gLQlzdHJ1Y3QgdHRtX2Rt
YV90dCAqZG1hID0gY29udGFpbmVyX29mKGJvLT50dG0sIHN0cnVjdCB0dG1fZG1hX3R0LCB0dG0p
Owo+ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+ICAJc3RydWN0
IGFtZGdwdV9qb2IgKmpvYjsKPiAgCXVuc2lnbmVkIG51bV9kdywgbnVtX2J5dGVzOwo+IC0JZG1h
X2FkZHJfdCAqZG1hX2FkZHJlc3M7Cj4gIAlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsKPiAgCXVp
bnQ2NF90IHNyY19hZGRyLCBkc3RfYWRkcjsKPiArCXZvaWQgKmNwdV9hZGRyOwo+ICAJdWludDY0
X3QgZmxhZ3M7Cj4gKwl1bnNpZ25lZCBpbnQgaTsKPiAgCWludCByOwo+ICAKPiAgCUJVR19PTihh
ZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jcy0+Y29weV9tYXhfYnl0ZXMgPAo+ICAJICAgICAgIEFNREdQ
VV9HVFRfTUFYX1RSQU5TRkVSX1NJWkUgKiA4KTsKPiAgCj4gIAkvKiBNYXAgb25seSB3aGF0IGNh
bid0IGJlIGFjY2Vzc2VkIGRpcmVjdGx5ICovCj4gLQlpZiAobWVtLT5zdGFydCAhPSBBTURHUFVf
Qk9fSU5WQUxJRF9PRkZTRVQpIHsKPiArCWlmICghdG16ICYmIG1lbS0+c3RhcnQgIT0gQU1ER1BV
X0JPX0lOVkFMSURfT0ZGU0VUKSB7Cj4gIAkJKmFkZHIgPSBhbWRncHVfbW1fbm9kZV9hZGRyKGJv
LCBtbV9ub2RlLCBtZW0pICsgb2Zmc2V0Owo+ICAJCXJldHVybiAwOwo+ICAJfQo+IEBAIC0zNTEs
MTUgKzM1MSwzNyBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1fbWFwX2J1ZmZlcihzdHJ1Y3QgdHRt
X2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAJYW1kZ3B1X3JpbmdfcGFkX2liKHJpbmcsICZqb2ItPmli
c1swXSk7Cj4gIAlXQVJOX09OKGpvYi0+aWJzWzBdLmxlbmd0aF9kdyA+IG51bV9kdyk7Cj4gIAo+
IC0JZG1hX2FkZHJlc3MgPSAmZG1hLT5kbWFfYWRkcmVzc1tvZmZzZXQgPj4gUEFHRV9TSElGVF07
Cj4gIAlmbGFncyA9IGFtZGdwdV90dG1fdHRfcHRlX2ZsYWdzKGFkZXYsIGJvLT50dG0sIG1lbSk7
Cj4gIAlpZiAodG16KQo+ICAJCWZsYWdzIHw9IEFNREdQVV9QVEVfVE1aOwo+ICAKPiAtCXIgPSBh
bWRncHVfZ2FydF9tYXAoYWRldiwgMCwgbnVtX3BhZ2VzLCBkbWFfYWRkcmVzcywgZmxhZ3MsCj4g
LQkJCSAgICAmam9iLT5pYnNbMF0ucHRyW251bV9kd10pOwo+IC0JaWYgKHIpCj4gLQkJZ290byBl
cnJvcl9mcmVlOwo+ICsJY3B1X2FkZHIgPSAmam9iLT5pYnNbMF0ucHRyW251bV9kd107Cj4gKwo+
ICsJaWYgKG1lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1RUKSB7Cj4gKwkJc3RydWN0IHR0bV9kbWFf
dHQgKmRtYTsKPiArCQlkbWFfYWRkcl90ICpkbWFfYWRkcmVzczsKPiArCj4gKwkJZG1hID0gY29u
dGFpbmVyX29mKGJvLT50dG0sIHN0cnVjdCB0dG1fZG1hX3R0LCB0dG0pOwo+ICsJCWRtYV9hZGRy
ZXNzID0gJmRtYS0+ZG1hX2FkZHJlc3Nbb2Zmc2V0ID4+IFBBR0VfU0hJRlRdOwo+ICsJCXIgPSBh
bWRncHVfZ2FydF9tYXAoYWRldiwgMCwgbnVtX3BhZ2VzLCBkbWFfYWRkcmVzcywgZmxhZ3MsCj4g
KwkJCQkgICAgY3B1X2FkZHIpOwo+ICsJCWlmIChyKQo+ICsJCQlnb3RvIGVycm9yX2ZyZWU7Cj4g
Kwl9IGVsc2Ugewo+ICsJCWRtYV9hZGRyX3QgZG1hX2FkZHJlc3M7Cj4gKwo+ICsJCWRtYV9hZGRy
ZXNzID0gKG1tX25vZGUtPnN0YXJ0IDw8IFBBR0VfU0hJRlQpICsgb2Zmc2V0Owo+ICsJCWRtYV9h
ZGRyZXNzICs9IGFkZXYtPnZtX21hbmFnZXIudnJhbV9iYXNlX29mZnNldDsKPiArCj4gKwkJZm9y
IChpID0gMDsgaSA8IG51bV9wYWdlczsgKytpKSB7Cj4gKwkJCXIgPSBhbWRncHVfZ2FydF9tYXAo
YWRldiwgaSA8PCBQQUdFX1NISUZULCAxLAo+ICsJCQkJCSAgICAmZG1hX2FkZHJlc3MsIGZsYWdz
LCBjcHVfYWRkcik7Cj4gKwkJCWlmIChyKQo+ICsJCQkJZ290byBlcnJvcl9mcmVlOwo+ICsKPiAr
CQkJZG1hX2FkZHJlc3MgKz0gUEFHRV9TSVpFOwo+ICsJCX0KPiArCX0KPiAgCj4gIAlyID0gYW1k
Z3B1X2pvYl9zdWJtaXQoam9iLCAmYWRldi0+bW1hbi5lbnRpdHksCj4gIAkJCSAgICAgIEFNREdQ
VV9GRU5DRV9PV05FUl9VTkRFRklORUQsICZmZW5jZSk7Cj4gCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
