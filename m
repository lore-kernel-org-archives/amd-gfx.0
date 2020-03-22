Return-Path: <SRS0=k9Mm=5H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF77C54FCF
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Mar 2020 19:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CBE20719
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Mar 2020 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o0lyIFxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CBE20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39FA89F47;
	Sun, 22 Mar 2020 19:55:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EA889F47
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Mar 2020 19:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBMhS1Z7TL2LbVZJhSfdpmaDva+C3DjKcK5becUAF4ysrCnK7nNJKKB+Xg1RUToc05mtG4s4RfU079XKgVmwG6lMjmsW05vfX0Lru/4pajxhVlRULrvbC7deSb8gGuOwU/sQhZbYP/aIQZWII4an7dlNQlu/QwCNMCMiTdF2oKmbxR8F1FYVzC/naWJ4MWF/Nwww8j3+3WQ6nRMuDhBtE3w8MfcMXjCfCxjjKtwsEaeuf70hSSZdrL407mhxliO2m/9ij5/yoJVLa43WZ/I0yNjRsNMVTh8UZA0ciMcUsH3hpvLf0OuqLP+dDihn6Rij24B2b+UXGl3ExTIU5oXbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abGlNjfity4M74yreT8PQPhvWVyUbVL4Q4ds4zopxL4=;
 b=E2OgxRHY67q+ZZsdnJbk6Vt7aOXo1hsXWg6+RwgfkUDyOrZ0hZnAXNFtSQ/F7WgZK6bqG4VsLp+ZBLezkuM9miuXa59V6UoT/RH+YJOfY2393fZbJ7kLWHbhSdzezGyP46Sku8EIe30VSYDZngJLwyUw0K68PNRaZJjokhmLykyK13AU0DfIlT6s255L3m5n14v3p62EcfzIwPaQOyx/3fJGXoTv2M5rsVSvYqTIjKzqKuZK0G3udFmVuRmuXdLZyJVGu99TTGZ5h6c7SmFIO7uk7LHUbQkKf3FzfYGMhTds9QrGeKm4CjNIMs7X2ObohKnXeS/qSsl0+EldqeWuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abGlNjfity4M74yreT8PQPhvWVyUbVL4Q4ds4zopxL4=;
 b=o0lyIFxC2ZXpxoeaIcuHeOl4MptgoU1Is64OSraBOAbqJzZzE/K6HFfMznje0TME26516sGaWiH3X5u2wu7xfVfE+QmCY4nkV11HdvogR3lX7VEle/38JJU+heB5tFfFYiLFqBJ9dDinEfOo0ByAXH9qs0JbxCWtnFB7LejPDHQ=
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Sun, 22 Mar
 2020 19:55:18 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.021; Sun, 22 Mar 2020
 19:55:18 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: add macro to get proper ih ring register
 offset
Thread-Topic: [PATCH 2/4] drm/amdgpu: add macro to get proper ih ring register
 offset
Thread-Index: AQHV/k3M1UVmHe6RLkewHd7Jx2qpkqhRi66AgANwRmA=
Date: Sun, 22 Mar 2020 19:55:17 +0000
Message-ID: <SA0PR12MB4576670DDDFFCD564E76491EFDF30@SA0PR12MB4576.namprd12.prod.outlook.com>
References: <20200320002245.14932-1-alex.sierra@amd.com>
 <20200320002245.14932-2-alex.sierra@amd.com>
 <07bf8db6-f94a-f863-e4cc-074883227a66@amd.com>
In-Reply-To: <07bf8db6-f94a-f863-e4cc-074883227a66@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-22T19:55:16Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3a41032d-bf07-44e5-b7d7-0000b229df8d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-22T19:55:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 73de6279-2fe2-4b5f-95e7-000070104cdd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
x-originating-ip: [136.49.240.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ae8b29f-9370-4e93-6b4a-08d7ce9af23b
x-ms-traffictypediagnostic: SA0PR12MB4462:|SA0PR12MB4462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB44620DC0F9D12E02BEA93E2EFDF30@SA0PR12MB4462.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0350D7A55D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(39840400004)(376002)(199004)(66946007)(76116006)(71200400001)(110136005)(64756008)(316002)(66446008)(66476007)(478600001)(66556008)(5660300002)(52536014)(7696005)(55016002)(6506007)(53546011)(2906002)(9686003)(81166006)(8676002)(81156014)(8936002)(33656002)(26005)(86362001)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4462;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CLU6HI5tbKVoqSSec2M/DaCfv1GUqNqWHSMvbaTsn/9Bia8+rGnSXUYIqPdeKd2e/8p6xgrG7L8kZLxs+gQC5z5N4yIgCy91LDdLyVJDmUYNqL3MC7HE79/REKESPur4xyDcXRfCzDqrR5jSk5dGsprSh6yES0Y2bRlmflcmYy9doHq5FgJIoh+agrJZ+KrvVO02uYVKtCp1/K8THsSUR0b7wBBSuqvEjX3zQLzV69MA9ruGDFt0Hc3dBoiZa3vWUXcXULtabSXXAZJGrBiWlevgqZCjccZVmwMNL0cffxxRzgEiRbhpRSAdd/EOYDcXq4fnKS3AD6BQQvGhpwL6UqvFdiNOZIo6PZdZTWQC4uEpaF6Y1EP45GQ4C/g1cfA2pVYlmjtWLLoZdI9Y+QYwB5dpODTQmTDxYcYWQwt3zDI+WzHeAKbCRCmuYHbX6UYS
x-ms-exchange-antispam-messagedata: LclSzDB40+wwj8Sr3JfW8MrnGHOlUh1Nzh4NnNqAqEzZvmtLiqUSHz57MkZ9fQC7l3OIYvqpxVly5elFBLncHkrVBZvhfubb1LyARYqmS1bULr2PYNKxXRVjNza9rR6Ofy+NY2LFp8cN3QK8N/skwA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae8b29f-9370-4e93-6b4a-08d7ce9af23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2020 19:55:18.0002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8n+WESqDcfi5mvAaVbrZUzjgJJvSKXsWpQoPkmH3cV87qSZeKTZJBb2iI89nymx5UYRKox1bY4cc5GapY44/xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpJ
bmxpbmUgcmVzcG9uc2UNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhs
aW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4gDQpTZW50OiBGcmlkYXksIE1hcmNo
IDIwLCAyMDIwIDk6MzEgQU0NClRvOiBTaWVycmEgR3VpemEsIEFsZWphbmRybyAoQWxleCkgPEFs
ZXguU2llcnJhQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVj
dDogUmU6IFtQQVRDSCAyLzRdIGRybS9hbWRncHU6IGFkZCBtYWNybyB0byBnZXQgcHJvcGVyIGlo
IHJpbmcgcmVnaXN0ZXIgb2Zmc2V0DQoNCk9uIDIwMjAtMDMtMTkgMjA6MjIsIEFsZXggU2llcnJh
IHdyb3RlOg0KPj4gVGhpcyBtYWNybyBjYWxjdWxhdGVzIHRoZSBJSCByaW5nIHJlZ2lzdGVyIG9m
ZnNldCBiYXNlZCBvbiB0aGUgdGhyZWUgDQo+PiByaW5nIG51bWJlcnMgYW5kIGFzaWMgdHlwZS4N
Cj4+IFRoZSBwYXJhbWV0ZXJzIG5lZWRlZCBhcmUgdGhlIHJlZ2lzdGVyJ3MgbmFtZSB3aXRob3V0
IHRoZSBwcmVmaXggbW1JSCANCj4+IGFuZCB0aGUgcmluZyBudW1iZXIgdGFrZW4gZnJvbSBSSU5H
MCwgUklORzEgb3IgUklORzIgbWFjcm9zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2ll
cnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIHwgNSArKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3ZlZ2ExMF9paC5jIA0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBf
aWguYw0KPj4gaW5kZXggNDA3YzYwOTNjMmVjLi41YmQ5YmMzN2ZhZGYgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYw0KPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMNCj4+IEBAIC0zNCw2ICszNCwxMSBAQA0K
Pj4gICAjaW5jbHVkZSAidmVnYTEwX2loLmgiDQo+PiAgIA0KPj4gICAjZGVmaW5lIE1BWF9SRUFS
TV9SRVRSWSAxMA0KPj4gKyNkZWZpbmUgUklORzAgMA0KPj4gKyNkZWZpbmUgUklORzEgKFJJTkcw
ICsgNCkNCj4+ICsjZGVmaW5lIFJJTkcyIChSSU5HMSArIDQpDQo+PiArDQo+PiArI2RlZmluZSBt
bUlIX1JJTkdfUkVHKHJlZywgcmluZykgKFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCANCj4+
ICttbUlIXyMjcmVnKSArIChyaW5nKSAqIGFkZXYtPmlycS5yaW5nX3N0cmlkZSkNCj4NCj4gSSBk
b24ndCB0aGluayB5b3UgbmVlZCB0aGUgUklOR3ggZGVmaW5pdGlvbnMuIEp1c3QgdXNlIG51bWJl
cnMgMC0yLiBUaGUgcmluZ19zdHJpZGUgc2hvdWxkIGJlIHRoZSBudW1iZXIgb2YgcmVnaXN0ZXJz
IHRvIHNraXAgZnJvbSBvbmUgcmluZyB0byB0aGUgbmV4dCwgd2hpY2ggY2FuIGJlIGRpZmZlcmVu
dCBmb3IgZGlmZmVyZW50IEFTSUNzLiBFLmcuIA0KPiAobW1JSF9SQl9DTlRMX1JJTkcxIC0gbW1J
SF9SQl9DTlRMKS4gSXQncyA4IG9uIFZlZ2EsIDEyIG9uIEFyY3R1cnVzLg0KWW91J3JlIHJpZ2h0
LiBUaGlzIHdhcyBhIGRpZmZlcmVudCBhcHByb2FjaCB3aGVyZSBJIHdhcyB1c2luZyB0aGUgYWN0
dWFsIHJlZ2lzdGVycyBhbmQgYWRkaW5nIHRoZSBwcm9wZXIgb2Zmc2V0IGJhc2VkIG9uIHRoZSBS
SU5HIG9mZnNldCBhbmQgcmluZ19zdHJpZGUgYXMgZW5hYmxlci4NCkV4Lg0KVmVnYTEwDQpyaW5n
X3N0cmlkZXIgPSAwDQpSSU5HMSA9IDENCm1tSUhfUkJfUlBUUl9SSU5HMSA9IDB4OGIgPSBtbUlI
X1JCX1JQVFJfUklORzEgKyAoUklORzEgKiByaW5nX3N0cmlkZXIpDQpBcmN0dXJ1cw0KcmluZ19z
dHJpZGVyID0gMQ0KUklORzEgPSA0DQptbUlIX1JCX1JQVFJfUklORzEgPSAweDhmID0gbW1JSF9S
Ql9SUFRSX1JJTkcxICsgKFJJTkcxICogcmluZ19zdHJpZGVyKQ0KWW91ciBzb2x1dGlvbiBsb29r
cyBlYXNpZXIgdG8gcmVhZC4NCj4NCj4gSSdkIHNxdWFzaCBwYXRjaGVzIDEgYW5kIDIgdG8gbWFr
ZSB0aGlzIG1vcmUgb2J2aW91cy4NCj4NCj5SZWdhcmRzLA0KPsKgIEZlbGl4DQo+DQo+PiAgIA0K
Pj4gICBzdGF0aWMgdm9pZCB2ZWdhMTBfaWhfc2V0X2ludGVycnVwdF9mdW5jcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSANCj4+ICphZGV2KTsNCj4+ICAgDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
