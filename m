Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3967C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949F923D23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UIqtBePG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949F923D23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB1489C1F;
	Mon, 29 Jun 2020 12:45:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164B889C1F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 12:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4LHUTsAjAj+IJiNJAspVeUmLn57ybsIR6wmukeHAUkLXsNgAXsijEBu4PzG2KixV91AeTCt9d+wr7AwYhu7nTO4w+PMnSsqmYJOvz95ovnxH9xSjs0Uq3gkofJG3Wlgj4ZWeFrnY0wqG6zX1WaUW/MdhZwahwu9g6SaQ/i8biqLM66Z7KvRsEMjhc5yBV4WcgVPZorFxkjTi1daacaKKB16ngPDdatrfaIz0Oh7HaBLRLFop0s3XoHRxNE4BZK/2W/j30vQcoUoKzFR9CVbbzMX4t3Ch+TPTpukjDdjKKHZ3fuBthsKUYcabdQeKMxq41JSi9Ao400ILhcwtJzS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOMa/38wZucN6oA6ZicDZIHIEEiNgRt0AQFx8tVNhhY=;
 b=Neg9TUDU64f4OyygMXDP9AisiM1iupaKMMXG8mDJqOCFZJ0SW6a7Jg1xHq/NvJJ8OVoKylwIpP3rmrbDmAFUNJzWZpqJvnkUzvziUlzUoMBfn6kkKp6PwDMagxgYPePB1lmPYpkjxsbyc8g85rw6/gixY9dUd+NVoEv0qULlkITp5WDAm/aQYizzReQgZwF43ocHAB7+UE0s4EWxj43HFpmMDk4BUlpztAvWIORkUf0lLkAKY7kBDtNMu5MfXQHmUkf5c+qxrhmX0iIlhYBcE1MS8ppr90yEeD3hZ8YmxdA/uQQ8tuLjgXyw1ViGkztI9ndtCg9RrCfRw9yDBRfevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOMa/38wZucN6oA6ZicDZIHIEEiNgRt0AQFx8tVNhhY=;
 b=UIqtBePG+EifTBir5uUljKUik1IwtxZs2NouUGTGp/UEqHQS5aPgkyCrFPPP2CnYiCO7GYkGuBEcN2QPlIY3zlLich2e+bJCyhfh/EkKsXqMhIKoruE192sb+doa11qq4C0uonISDa2y5ggVm0I9t87lJa4ONUIi9/zCSBt7OBk=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 12:45:03 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 12:45:03 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix compile warning in amdgpu_fru_read_eeprom
Thread-Topic: [PATCH] drm/amdgpu: Fix compile warning in amdgpu_fru_read_eeprom
Thread-Index: AQHWTg6wOnOSS3DB9USE4UrWxAOyQqjvgkCAgAAAYnCAAALngIAAAEvAgAADM4CAAACXIA==
Date: Mon, 29 Jun 2020 12:45:03 +0000
Message-ID: <DM6PR12MB3721D27D96E214A16069AE0F856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200629121313.18064-1-kent.russell@amd.com>
 <ade43f8c-6ea1-ea69-d173-323e1d1f1867@gmail.com>
 <DM6PR12MB3721818B463CF5BE7BFD5F72856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <10dc15f9-4657-12bb-70ba-fa44ea137c88@amd.com>
 <DM6PR12MB3721970740F9380319133483856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <1b7f620b-22f1-a80c-00b5-4ff980058890@amd.com>
In-Reply-To: <1b7f620b-22f1-a80c-00b5-4ff980058890@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-29T12:44:02Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3a5ef805-1544-46d7-8622-000038657492;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-29T12:45:01Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 64c3a3bc-502f-48c6-afcc-000054d4806e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbdf6046-5222-4e73-7f22-08d81c2a3ea5
x-ms-traffictypediagnostic: DM5PR12MB1385:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1385345EDB07369901E8EA80856E0@DM5PR12MB1385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0DLZNcmiKWsPLmsKmcdlanpsgCTjCUWDQ47VlVSafVUW8XWFLjxDYglxjf7tJO+dUuHIZdUhOkDNjIXykAM/9C2E2kib3wu3hY3KEYFSHvBZHNM2QVUyBmAheG4opKPlCP3fNzlqaKAupRqm76880VUqSv9k7YaMDWSV9FKsTNx88rXzJ7otvZn17BB57OEfgID2kAQx088n/ADS86IuRhIVGeTTLxCO/0u5tP9n/LcxlwBtHVFVOINn8PDzU10wcX3sDGCcpsMp2Jey0k7p/J36vq4qVo7ow5KOx/C7+bzul4rqobuj0j+Elttu0aYjSoLrk0ep4NiQkK4vFyY/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(9686003)(55016002)(316002)(26005)(8676002)(83380400001)(7696005)(478600001)(53546011)(6506007)(110136005)(71200400001)(8936002)(66946007)(186003)(76116006)(33656002)(2906002)(5660300002)(86362001)(66574015)(66556008)(66446008)(64756008)(52536014)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: W/IhFffzV5ZPPIUM1Mc0oNxV/wf/MMs3Oc+Phi8aO8iDWiVGYpp1bbz/3LBiOGB8d2Anc6zFJCssXXOugwxwl1yzNJS/7k5Q6+y+EVFV5Hny3xaLkdK4pCPmtJGPosBABbqPD+7bZjeiMokmxH7WMyJpIgngHYiz/Lozz3DJKyDc1kf1l5CF06UPmemrv6zmzMvZJah50mn1bObfbf4ddfuLAl53mWyomN5r5Ev13bww/i7pKbmYfaI+h/dXBBl8K5pitdSNl/ZHHPLQYzvZpiXBjxZJnRnpdfHEJ1E4yk1PMTgabl4A19AH9TuNSVlBrXhUrUbJ+D43K+hiyW6N9V89yI7Krfq5lZwjlK+MaqAoMam+rHvLPHetXWxdHkb/kmkTMLoHlxd5SoeOOWHT1OUyMIgBp+M4l3VJgooEG+73v2w1lzYxXf7be7v5L9sDP7mXJGTERGUALbvaEBx/gQ0PX87t60+Kk8/npb4nxsimwT9JMyikTy86iGN3QoaC
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdf6046-5222-4e73-7f22-08d81c2a3ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 12:45:03.7063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75SHlj25bUu8tZuFW8DhQtYv7Hk5Z+Bfo6uqfU7TYgvXVNytlH/Sudlx1NUlDmmbfw4z9YXbdw1c/WnVzLijmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQpBbmQgSSBhcHByZWNpYXRlIGl0LiBUaGVyZSdzIGFsd2F5cyBz
b21lb25lIHdobyB3aWxsIGxvb2sgYXQgYSBwYXRjaCBjcml0aWNhbGx5IGluc3RlYWQgb2YganVz
dCBzYXlpbmcgImVoLCBpdCdzIGhpcyBjb2RlLCBoZSBwcm9iYWJseSBrbm93cyB3aGF0IGhlJ3Mg
ZG9pbmciIGFuZCBkb2luZyBhbiBhdXRvbWF0aWMgUkIuIE5vdyBmb3IgdGhlIGNhZmZlaW5lIHRv
IGtpY2sgaW4g8J+Yig0KDQogS2VudA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFNl
bnQ6IE1vbmRheSwgSnVuZSAyOSwgMjAyMCA4OjQxIEFNDQo+IFRvOiBSdXNzZWxsLCBLZW50IDxL
ZW50LlJ1c3NlbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBjb21waWxlIHdhcm5pbmcgaW4NCj4g
YW1kZ3B1X2ZydV9yZWFkX2VlcHJvbQ0KPiANCj4gTm8sIHByb2JsZW0uIEkgZG9uJ3Qga25vdyB0
aGlzIGNvZGUgYnV0IHRoZSBwYXRjaCBsb29rZWQga2luZCBvZiBmaXNoeSA6KQ0KPiANCj4gQW5k
IHllcyB0aGF0IGhhcHBlbnMgdG8gYWxsIG9mIHVzLCB0aGF0J3Mgd2h5IHdlIGRvIHRoaXMgcmV2
aWV3Lg0KPiANCj4gQ2hyaXN0aWFuLg0KPiANCj4gQW0gMjkuMDYuMjAgdW0gMTQ6MzUgc2Nocmll
YiBSdXNzZWxsLCBLZW50Og0KPiA+IFtBTUQgUHVibGljIFVzZV0NCj4gPg0KPiA+IFRoYW5rcyBm
b3IgbWFraW5nIG1lIGxvb2sgYXQgaXQgY3JpdGljYWxseSAoc29tZXRoaW5nIEkgc2hvdWxkIGRv
IG1vcmUgYWZ0ZXINCj4gcmV0dXJuaW5nIGZyb20gMiB3ZWVrcyB2YWNhdGlvbikuIE5pcm1veSBm
aXhlZCB0aGUgaXNzdWUgYnkgdXNpbmcgYSBzdGF0aWMNCj4gZGVmaW5lIGluIGhpcyAiIGRybS9h
bWRncHU6IGxhYmVsIGludGVybmFsbHkgdXNlZCBzeW1ib2xzIGFzIHN0YXRpYyIgcGF0Y2ggYW5k
DQo+IEkgd2FzIGp1c3QgaW4gYXV0b3BpbG90IHRyeWluZyB0byBmaXggdGhlIEludGVsIGtib3Qg
ZXJyb3IgZW1haWwgdGhhdCBJIHJlY2VpdmVkDQo+IHdoaWxlIGF3YXksIG5vdCBhY3R1YWxseSBy
ZWFsaXppbmcgdGhhdCBpdCB3YXMgZml4ZWQgYW5kIEkgd2FzIGJyZWFraW5nIGFuZA0KPiB1bmJy
ZWFraW5nIGl0IGR1cmluZyByZWJhc2luZy4gVGhpcyB0aHJlYWQgY2FuIGJlIGlnbm9yZWQuIFRp
bWUgZm9yIHNvbWUNCj4gY29mZmVlLg0KPiA+DQo+ID4gICBLZW50DQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKdW5lIDI5LCAyMDIwIDg6
MjkgQU0NCj4gPj4gVG86IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsNCj4g
Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogRml4IGNvbXBpbGUgd2FybmluZyBpbg0KPiA+PiBhbWRncHVfZnJ1X3Jl
YWRfZWVwcm9tDQo+ID4+DQo+ID4+IE9rLCB0aGVuIHdoeSBkb2VzIGl0IGZpeCBhIHdhcm5pbmcg
aWYgd2UgbWFrZSBpdCBub24tc3RhdGljPw0KPiA+Pg0KPiA+PiBJZiB0aGUgZnVuY3Rpb24gdXNl
ZCBpdCBjb21waWxlZCB1bmRlciBzb21lICNpZmRlZiB0aGVuIHdlIHNob3VsZA0KPiA+PiBwcm9i
YWJseSBqdXN0IGNvbXBpbGUgdGhpcyB1bmRlciAjaWZkZWYgYXMgd2VsbC4NCj4gPj4NCj4gPj4g
Q2hyaXN0aWFuLg0KPiA+Pg0KPiA+PiBBbSAyOS4wNi4yMCB1bSAxNDoyMCBzY2hyaWViIFJ1c3Nl
bGwsIEtlbnQ6DQo+ID4+PiBbQU1EIFB1YmxpYyBVc2VdDQo+ID4+Pg0KPiA+Pj4gSXQncyB1c2Vk
IHJlcGVhdGVkbHkgaW4gdGhlIGFtZGdwdV9mcnVfZ2V0X3Byb2R1Y3RfaW5mbyBmdW5jdGlvbiwN
Cj4gPj4+IGJ1dCBvbmx5DQo+ID4+IGluIHRoYXQgZnVuY3Rpb24gd2hpY2ggaXMgaW4gdGhlIGFt
ZGdwdV9mcnVfZWVwcm9tLmMgZmlsZS4gV2hpbGUgaXQNCj4gPj4gY291bGQgYmUgdGhlb3JldGlj
YWxseSBiZSB1c2VkIGVsc2V3aGVyZSwgaXQgaXNuJ3QgY3VycmVudGx5IGFuZCBhbnkNCj4gPj4g
b3RoZXIgdXNhZ2Ugd291bGQgYmUgYmVzdCBjb250YWluZWQgaW4gdGhlIGFtZGdwdV9mcnVfZWVw
cm9tLmMgZmlsZS4NCj4gPj4+ICAgIEtlbnQNCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNo
dHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gPj4+PiBTZW50OiBNb25kYXksIEp1bmUgMjksIDIwMjAg
ODoxNyBBTQ0KPiA+Pj4+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47
DQo+ID4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4+PiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggY29tcGlsZSB3YXJuaW5nIGluDQo+ID4+Pj4gYW1k
Z3B1X2ZydV9yZWFkX2VlcHJvbQ0KPiA+Pj4+DQo+ID4+Pj4gQW0gMjkuMDYuMjAgdW0gMTQ6MTMg
c2NocmllYiBLZW50IFJ1c3NlbGw6DQo+ID4+Pj4+IFRoaXMgZml4ZXMgdGhlIG1pc3NpbmctcHJv
dG90eXBlcyB3YXJuaW5nIGZvciB0aGUNCj4gPj4+Pj4gYW1kZ3B1X2ZydV9yZWFkX2VlcHJvbSBm
dW5jdGlvbi4gU2luY2Ugd2UgZGVjbGFyZSBpdCBpbiB0aGUNCj4gPj4+Pj4gaGVhZGVyLCB3ZSBj
YW4gbWFrZSBpdCB1bi1zdGF0aWMNCj4gPj4+PiBXZWxsIGlzIGl0IHVzZWQgaW4gZGlmZmVyZW50
IGZpbGVzPyBPdGhlcndpc2Ugd2UgbWlnaHQganVzdCBoYXZlDQo+ID4+Pj4gdW51c2VkIGNvZGUg
aW4gdGhlIG1vZHVsZSB3aGljaCBjYW4gcG90ZW50aWFsbHkgcmFpc2UgYSB3YXJuaW5nIGFzIHdl
bGwuDQo+ID4+Pj4NCj4gPj4+PiBDaHJpc3RpYW4uDQo+ID4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9m
Zi1ieTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gPj4+Pj4gUmVwb3J0
ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+Pj4+PiBDaGFuZ2Ut
SWQ6IEkyYjk0MTkzNjVjYjhiMzhiY2ZiNjU4MmRmNTNiOTZjODM4NjFkNmNmDQo+ID4+Pj4+IC0t
LQ0KPiA+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXBy
b20uYyB8IDIgKy0NCj4gPj4+Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9mcnVfZWVwcm9tLmggfCAyICsrDQo+ID4+Pj4+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYw0KPiA+Pj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCj4gPj4+Pj4g
aW5kZXggZTgxMWZlY2M1NDBmLi42OGVkMTZlNGQ4YmUgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCj4gPj4+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYw0KPiA+Pj4+
PiBAQCAtNDgsNyArNDgsNyBAQCBzdGF0aWMgYm9vbCBpc19mcnVfZWVwcm9tX3N1cHBvcnRlZChz
dHJ1Y3QNCj4gPj4+PiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+Pj4+PiAgICAgCXJldHVybiBm
YWxzZTsNCj4gPj4+Pj4gICAgIH0NCj4gPj4+Pj4NCj4gPj4+Pj4gLXN0YXRpYyBpbnQgYW1kZ3B1
X2ZydV9yZWFkX2VlcHJvbShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPj4+Pj4gdWlu
dDMyX3QgYWRkcnB0ciwNCj4gPj4+Pj4gK2ludCBhbWRncHVfZnJ1X3JlYWRfZWVwcm9tKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdA0KPiA+Pj4+PiArYWRkcnB0ciwNCj4gPj4+
Pj4gICAgIAkJCSAgIHVuc2lnbmVkIGNoYXIgKmJ1ZmYpDQo+ID4+Pj4+ICAgICB7DQo+ID4+Pj4+
ICAgICAJaW50IHJldCwgc2l6ZTsNCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmgNCj4gPj4+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5oDQo+ID4+Pj4+IGluZGV4IGYyOWE4NjEx
ZDY5Yi4uZjQwMjRmMWQ2NmM5IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5oDQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmgNCj4gPj4+Pj4gQEAgLTI0LDYgKzI0
LDggQEANCj4gPj4+Pj4gICAgICNpZm5kZWYgX19BTURHUFVfRlJVX0VFUFJPTV9IX18NCj4gPj4+
Pj4gICAgICNkZWZpbmUgX19BTURHUFVfRlJVX0VFUFJPTV9IX18NCj4gPj4+Pj4NCj4gPj4+Pj4g
K2ludCBhbWRncHVfZnJ1X3JlYWRfZWVwcm9tKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1
aW50MzJfdA0KPiA+Pj4+IGFkZHJwdHIsDQo+ID4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBjaGFyICpidWZmKTsNCj4gPj4+Pj4gICAgIGludCBhbWRncHVfZnJ1X2dl
dF9wcm9kdWN0X2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiA+Pj4+Pg0KPiA+
Pj4+PiAgICAgI2VuZGlmICAvLyBfX0FNREdQVV9QUk9ESU5GT19IX18NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
