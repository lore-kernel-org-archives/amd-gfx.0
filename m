Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F534C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 18:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B24B2078C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 18:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jW7PKyvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B24B2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7A76E8C5;
	Wed,  6 May 2020 18:25:38 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680075.outbound.protection.outlook.com [40.107.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D1596E8C5
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 18:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZLT0pdqtg+tLmTSIeQz2f0h3CXbS7EFjo/cBvKkSjrhnC8kuy0aEnDilxYAyL13+rqsAaux6fMRCsHbvAKn2wQwXNm8bXgdmqqM6WtNIWmuivoG+jVPg/l+z3pQbSSNiWWQg63FokhxdBybRkYDKpYy2wwpCe3B8RZJv88ftrbtgTbcQv3sal9P584Xr4JiXSdwrz1gQKHlVhjiP3cpcxAiS8pb9Jf3Psh97mC3y2gzdPhC++34EmO36lh1ZdUGymOHE57CqhbnmlJaOGFMd7JekOJhAL1JI8SeUdV6iBLmTVBrvkELZclDlp1Vvlcick2B99Pp68Mr2uopAz9iKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cic4/uYNbIkLhuwH+Sbkkw7yOAkGfrCzGM5BKR1dRNI=;
 b=IQMX6YpLcm1dOLioMVDXmu4f2uYsZDefz3WNx84wqsFDusKv2AeqKysLFRHFloqKWPgb44FsTga5bzuVUkN/dby3FCTxHtvMFu7fcjm3NsZU5CLtYsaeJMj+i+rpwJvV1gQn56JnaaZRn0ejiMJCIanP4indqOMz5CFV9ngEkFSIOm8Vpwlv11fVteiwBDpyRzmJvRgKuhd6F1shY2XmoZI03b+h5OjUjZVNOEfKFQ30ECuiHvT8XR0IU4V4hoKSYyOaqTQ1wZtDZP7NKw1MGFESeRq9Iqw4UFiNR/diTq4YALgLGcLXGMZpLzHB2G6GOhHpZ2QO2XRnAJOc0GF6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cic4/uYNbIkLhuwH+Sbkkw7yOAkGfrCzGM5BKR1dRNI=;
 b=jW7PKyvhUFCK+hryoLCznyfzyLOLSrSySmXK2/WBSiVLpOaSbjI/cAFnX8jw3LsrZM3eWX1xdvBHuNwFckGE9V1POxMR+hXAdeTOwOWpq5ztzMqP0DvHw9yyAQT1VYnB56KwAFzPJ0fpZ51zsi55zv3Q5Ys2q6K7yuRhC7BquI0=
Received: from DM6PR12MB3418.namprd12.prod.outlook.com (2603:10b6:5:116::31)
 by DM6PR12MB3642.namprd12.prod.outlook.com (2603:10b6:5:11f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 6 May
 2020 18:25:35 +0000
Received: from DM6PR12MB3418.namprd12.prod.outlook.com
 ([fe80::6179:2a38:bc35:9ecc]) by DM6PR12MB3418.namprd12.prod.outlook.com
 ([fe80::6179:2a38:bc35:9ecc%5]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 18:25:35 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Use GEM obj reference for KFD BOs
Thread-Topic: [PATCH 1/1] drm/amdgpu: Use GEM obj reference for KFD BOs
Thread-Index: AQHWI0HLPa+R5yaBp0SWCiPLwPQjHqiatXIAgACraaA=
Date: Wed, 6 May 2020 18:25:35 +0000
Message-ID: <DM6PR12MB341839F30106DC07B705BEFEFDA40@DM6PR12MB3418.namprd12.prod.outlook.com>
References: <20200506005911.21544-1-Felix.Kuehling@amd.com>
 <9871d538-dbf9-0ed5-03ef-b2232cc83872@gmail.com>
In-Reply-To: <9871d538-dbf9-0ed5-03ef-b2232cc83872@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-06T18:25:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=787ed8c6-a5a4-4488-9e50-00008c3f8da5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-06T18:25:34Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b21c8e31-635b-4bd5-8c7d-000065362850
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [136.49.240.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 211098f2-a24a-4faf-0365-08d7f1eadeb0
x-ms-traffictypediagnostic: DM6PR12MB3642:|DM6PR12MB3642:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3642EBCE09A7CF9924864475FDA40@DM6PR12MB3642.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mom2UXUkSOyHErh25Hc6AWpnXNIih1FgeefIjs7S2Ht29lqeuRc5f1UTwmutnRPAMsu6HdcKf7/JHjX0nt1WkTH7ZKLdoiecGpsR4G2vB5BRV+GcC8WXZWAAibxp6tMjWsaEKPZWmxbGi7SkZXvMJkN24vZFIoxZts5DzfJdz6gOu+2DT+4+EZ+KDmJAVp+0Lr0pr8iN00n+/DSWm9XsJQeIWv0XMkHSMivu1Pp7iSe1vtx+72rShAOe3o5H9Y3xrPM1CaTcmM34zTL0GVWEPgqMO6xV5UT+RkUxPa1AEzRBXK97ofOPhj0QaLwqK41lgs9VFhaueFcEH/tawpcQpmDa8G42eXSG7DzTmvRQSs2k32VytAwBM987j+Z4fSyObMvHaA8W2qVufiiJod8NlaUb4ujcgdm4NeDCsFrRMWqjKL3dq6JzrjhJAynVQmuNRKpL9222+pOWx259mtRvju44oI5JyoOdWMFs0/sVtDteVC69Hf+3K86SqG0VWzqLDW0GGWFj9rMbn1J0ESnErFN0mJV6BXjl03v4v7X2N7IY+ex7Ls85FlZnhulK1njU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3418.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(33430700001)(71200400001)(6506007)(186003)(26005)(7696005)(9686003)(55016002)(110136005)(5660300002)(86362001)(52536014)(966005)(66946007)(66476007)(64756008)(53546011)(2906002)(8676002)(316002)(33656002)(76116006)(66446008)(66556008)(478600001)(8936002)(66574014)(33440700001)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: n/RMCBRPjWEZIgqKlCmTxqKmH3eKRe8g3rrQhocFUhfkl33fk5dhfug+EhlWElB+lIPy/pCEHFzlM6J5ICVMQUSm6K9i5aA18+b8Fqei1EwKZSSfF81301Mzz/BIZPn5LowGnyeMGAHxyobUUWk7yDHTWHFm1k4KPKXmY8wBoFUvieQpVNZM15jVMVRdmRrgxpzWXLTAfMw6auKswrZP/16UC6nuyc0cfZnd/GsvMus4j/Cf+NgM/G79woCX4nKOGCd3JKodlPE0UBqPVQg81KaJ7nsSSC/Z0+MD7udYiVnjfHdYUq25IiIsJO3cUX8qZyAgugWjS1yj0wfYjdkYUb+mwvsmQq6aMF6/xtEateUagFT0By17GqNmkazOgvOKuVP8ZFyFuudKrjgcUXIngN5E2mbGgq8uzOfdHRzx+5ZqnKulzXo6X+m9z0hxSJ544fRCc0K7cRPTE9UYNuqqRejdVRriRFxkhXANf1Qoxc6bqJIVwlFIffER38THox0G7sE+fl3fBC+iW6meB33BQWZfKriOh1oYtiL71o6zyOoIaTSUTUQXsEq9MfjpiCyHhLa5sbahfGNqbPhnc2dadCOGrqd3F2O9wMmcOF1nIKZTmIAU7/OpIo/Ol5jex6TgxXhr+W/SgcXYdRnIngLBGgx6k8U0YF79MLXFcLnfKij/23Lix3B2PcZkOO3Kt4Zygo3oFhf76aV5riljxo7NR/VhKRhAA+6iRFgqscjC7EuIFJfWOjLJUiCRqV2B4vo40BptUEBOpRG+li3Qa9Ny3sgYL9213LXrH9fPx8+nK9U=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211098f2-a24a-4faf-0365-08d7f1eadeb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 18:25:35.6123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6Qm+yQocL1x8dzXHHLv6Bk1nPtcMRHCe/q06iG8FuRhED6Dgb4b1IFwxmOGsyhzCw2NsdfY/VpRCku8etuAiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3642
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQ2hyaXN0aWFuIEvDtm5pZw0KU2VudDogV2Vk
bmVzZGF5LCBNYXkgNiwgMjAyMCAzOjEyIEFNDQpUbzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8xXSBkcm0vYW1kZ3B1OiBVc2UgR0VNIG9iaiByZWZlcmVuY2UgZm9yIEtG
RCBCT3MNCg0KQW0gMDYuMDUuMjAgdW0gMDI6NTkgc2NocmllYiBGZWxpeCBLdWVobGluZzoNCj4g
UmVsZWFzaW5nIHRoZSBBTURHUFUgQk8gcmVmIGRpcmVjdGx5IGxlYWRzIHRvIHByb2JsZW1zIHdo
ZW4gQk9zIHdlcmUgDQo+IGV4cG9ydGVkIGFzIERNQSBidWZzLiBSZWxlYXNpbmcgdGhlIEdFTSBy
ZWZlcmVuY2UgbWFrZXMgc3VyZSB0aGF0IHRoZSANCj4gQU1ER1BVL1RUTSBCTyBpcyBub3QgZnJl
ZWQgdG9vIGVhcmx5Lg0KPg0KPiBBbHNvIHRha2UgYSBHRU0gcmVmZXJlbmNlIHdoZW4gaW1wb3J0
aW5nIEJPcyBmcm9tIERNQUJ1ZnMgdG8ga2VlcCANCj4gcmVmZXJlbmNlcyB0byBpbXBvcnRlZCBC
T3MgYmFsYW5jZXMgcHJvcGVybHkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBUZXN0ZWQtYnk6IEFsZXggU2llcnJhIDxhbGV4
LnNpZXJyYUBhbWQuY29tPg0KDQpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDUgKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIA0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiBpbmRleCAxMjQ3OTM4YjFl
YzEuLmRhOGIzMWE1MzI5MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiBAQCAtMTM1NCw3ICsxMzU0LDcgQEAgaW50IGFt
ZGdwdV9hbWRrZmRfZ3B1dm1fZnJlZV9tZW1vcnlfb2ZfZ3B1KA0KPiAgIAl9DQo+ICAgDQo+ICAg
CS8qIEZyZWUgdGhlIEJPKi8NCj4gLQlhbWRncHVfYm9fdW5yZWYoJm1lbS0+Ym8pOw0KPiArCWRy
bV9nZW1fb2JqZWN0X3B1dF91bmxvY2tlZCgmbWVtLT5iby0+dGJvLmJhc2UpOw0KPiAgIAltdXRl
eF9kZXN0cm95KCZtZW0tPmxvY2spOw0KPiAgIAlrZnJlZShtZW0pOw0KPiAgIA0KPiBAQCAtMTY5
OSw3ICsxNjk5LDggQEAgaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1faW1wb3J0X2RtYWJ1ZihzdHJ1
Y3Qga2dkX2RldiAqa2dkLA0KPiAgIAkJfCBLRkRfSU9DX0FMTE9DX01FTV9GTEFHU19XUklUQUJM
RQ0KPiAgIAkJfCBLRkRfSU9DX0FMTE9DX01FTV9GTEFHU19FWEVDVVRBQkxFOw0KPiAgIA0KPiAt
CSgqbWVtKS0+Ym8gPSBhbWRncHVfYm9fcmVmKGJvKTsNCj4gKwlkcm1fZ2VtX29iamVjdF9nZXQo
JmJvLT50Ym8uYmFzZSk7DQo+ICsJKCptZW0pLT5ibyA9IGJvOw0KPiAgIAkoKm1lbSktPnZhID0g
dmE7DQo+ICAgCSgqbWVtKS0+ZG9tYWluID0gKGJvLT5wcmVmZXJyZWRfZG9tYWlucyAmIEFNREdQ
VV9HRU1fRE9NQUlOX1ZSQU0pID8NCj4gICAJCUFNREdQVV9HRU1fRE9NQUlOX1ZSQU0gOiBBTURH
UFVfR0VNX0RPTUFJTl9HVFQ7DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0
aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2FsZXguc2llcnJhJTQwYW1kLmNvbSU3
QzE0ZmM5NTVhNGM2MzQxMWIzZmU4MDhkN2YxOTUyMDkyJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzI0MzQ5NTEzNDA0NTY3OCZhbXA7c2RhdGE9M1FyVXR1
RTRMVThWMXhHUlBqYVFKOVFlQXY5aEtoRlRaN0dMQ3Vza1ZlTSUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
