Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C2CC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264A8608FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264A8608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96E06EC0F;
	Wed,  2 Jun 2021 09:10:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8486B6EC0E
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 09:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkmvlJCZxwRkR8Ri4F46Oqwpv6thd7bGeiK0GUSzcwOx3qviPo+/rqiNmkaMiNIIMybKUeysMx0xRiijUez7sYxwGDdp+NjnkOcg0PyMO4nv8/pDvD26KmS99lLi2xWTA6J2fM47Dn/tetO5ldVleDB3ZFaNGQ21TpXhW8thausO2SYUBiHqYhalLB2VmSSqG03QBn2+Axyjd+VUruTTnRHNZCGlugy89/yZX4bqmeq4rWCyALKB9QAMzvyTfbWP0jGwndKTB8NQT78S5Ehx+yHOteV1Vyo2KtsWOm39M/67UHtb0puqomE3nOrNemVihVFNc3suI3TgB+DyD3zeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fCQ1zOqfmh75fIP1k7X7TTmehOaR3aNpeYiaUGg9gs=;
 b=Cq82bvjQ0+tkz+POLTA47UVxFnqlMynQhjic2vzs8d7b05qG9K4fvvqn+8kiSIMVfOHt7wQT6vLHykCPeMTT70hjLG47BpqFjRCOCKqEoNbzmE5+8yKO0zgHJ2r9eupiQPYoYCJqLlgYsM+fKFV+E1UVZkpv5OkFR959+pw7godJd15uVPrbAznEhrdRl4hi4rvr9DdCDgI1A3/ATn9Fj61zNUlmtsXjaEAKNrJMKjh+WqSnUynTXvyeZP0FlJqjPInpAW1cg/lT4FEQcIGINsuMXr6z+eNHau1N37n5W3tHPzHnctS4gCz+KMSPdTDnHu+tU5b8vlIekKn29TDfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fCQ1zOqfmh75fIP1k7X7TTmehOaR3aNpeYiaUGg9gs=;
 b=rLU4JtkMCEhLXZDVyrUx6RrOB/a3aQq/lvIDfdo2NtcZXJ4acYtQDck7O3GPlOrJVom7pQgYXlsuv4hDiQkmQR4BcUytCnjS5mzarRN4Trb9Gji6dpTWmNYLbc9rc9TnTnGFiBYKuep4h+mq6Z4x7CUXPCycB/IoZMhnWmaBWgc=
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1357.namprd12.prod.outlook.com (2603:10b6:300:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Wed, 2 Jun
 2021 09:10:16 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 09:10:16 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Das, Nirmoy"
 <Nirmoy.Das@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@freedesktop.org" <amd-gfx@freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
Thread-Topic: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
Thread-Index: AQHXV4mPuxNBQdFAekWk59CNPpxBL6sAaqYAgAAA2QCAAAGFoA==
Date: Wed, 2 Jun 2021 09:10:16 +0000
Message-ID: <MW2PR12MB4684CB6391DA014F76CC9C46FD3D9@MW2PR12MB4684.namprd12.prod.outlook.com>
References: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
 <c9c3817a-ddd5-d73e-5a5b-fb3ad25d8ddc@amd.com>
 <9a3adb34-031e-9742-d165-cb6f36c91063@amd.com>
In-Reply-To: <9a3adb34-031e-9742-d165-cb6f36c91063@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-02T09:10:12Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=adfab46e-c87d-413b-9566-fe0b1c8d53a7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e4af4fc-e2e4-46fc-c9fd-08d925a63cf5
x-ms-traffictypediagnostic: MWHPR12MB1357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB135746FB67BBA9816BC818DDFD3D9@MWHPR12MB1357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rxjBGFJiz7dJBHN4+9aSJrK8r/xMxaL4nnMl8Q87Dzz2tzqTwvDmY2KabcWQfZRLRkN/ENxHYZrMn8aU1DJd+fZqUdU2UghySe2IyqC8uA08tu8imt3zLcapco0N9e1EcmS7ZTIlklA/Ag9Jqs0XVLa+xX2QZ7RF2cvoxBmh+TW+SW8LuAyzzfRvIgtMv3aCCAHfR0zquJXiI2VEQTn8Of3t0utNqPZ6mjIr1LgW1cinzgf3+IbQzmx2gawO4AFoGJlOxQIZuv9H0ed+nUKqgIKMXittIkMFa9rS9Yz3JWwIwHERtnvihPfIejJ6mosG5iwYz6VTp7tFr0HhBOAvIUe7KMltM0P7GMQMnUFFCN0U8GPc7D0sxzTSsB8goBZdwwQ+rMx0V0ajrEBPatmH6Yrdi6aHON4DlOpppXG96A7KA90tMoQoKxfLyupjOopowmsJwywxGhiADgAP1BQh54xS4gLqLtaQxdZtfAAMyNJ2PhHQicQrESTNCpN+U7peWT/gaXkSgRQhdLbdMOxyJOaR8fBoGsqxiFAA7OWpuwnO3fHGsrj8foPvg8D80BlAp6NIgSxzegRjW2jZRmML9WhdUrjoue+70qjCj2yx+TI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(8936002)(53546011)(26005)(8676002)(55016002)(186003)(7696005)(6506007)(66476007)(52536014)(83380400001)(33656002)(2906002)(38100700002)(66446008)(64756008)(5660300002)(110136005)(86362001)(9686003)(478600001)(122000001)(71200400001)(76116006)(66556008)(316002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bTFKSEJhZVQvOGRYeHZSb1dhYnNYNkphY3FDUXlkUXo1aHcvWDFQYk1SZ1dO?=
 =?utf-8?B?aTl2Snp5cEIxWnlUekd1c2FsVU03b2UzMnFDNlBRRGErZTk1ck9pNU8rRkx0?=
 =?utf-8?B?cmovYVZVMmQwOWVhNTRiclpCei8xUzExbnBmOXZyR0VzZEVkUGV3RmNvZ3FK?=
 =?utf-8?B?SEVQak5ReFZadFYvMWtLOTVWMzRoNTdnZm1oYlhmangwbXdxLzJYVkd3YlNX?=
 =?utf-8?B?NW50cy9rMzVWcmFhaFVTeTNpOUZFYzZZUGwxUGtrQzRqeXpyQWFBNUt1emZS?=
 =?utf-8?B?NWg1UzRRSjN2RzV1RENpNldxN3MzTzNmUG82WWZtczVVaWlGajczaEgzYmx6?=
 =?utf-8?B?dUdXajZXMG1EZkVubjdpOFcrSGlqV28rTzR3UFpCWU53aFJsQzVDTlJpQlNm?=
 =?utf-8?B?S1haVjF5QkNYTjFtL2tmN0NudzI0eHFYSVZyQjdTTHdBaTU4bGlGaXJBdHFl?=
 =?utf-8?B?Z2pPQVoxOUJ3MGVFTkFPYTJ2bHk2Yjh5TnNKenVtTnlUcUZCLy8vcnJpTzNn?=
 =?utf-8?B?QTgvTEZybkp2aFJVM2RDK0l4M0Zrd2RHdFJBYzkrZk1iT21UUUFrMmQwVEJR?=
 =?utf-8?B?NFl6Ny80WXpNdUJGTmliUEEveGI5emFEdzZxeE1NT3BOMzk5eThyU1JPVzdE?=
 =?utf-8?B?TUZOMm53SkdZQVNkMEVEd2UzdWhMd0c2RjZNdW1HODRUVFNveW0yZHJLN0t2?=
 =?utf-8?B?cGRvTVJwRnMvL01pR0M5UUs1LzQ2Uy85Tm05YVR2VmY3KzFRZWR0TFBRVEla?=
 =?utf-8?B?WVZMRHg5T3ZEcjl4OE9SVks2OWFiUHI5c1gwRVpSVFZ1WUdLaThDQXkxK3g0?=
 =?utf-8?B?dFRSMXIvVkZtNW5PU1g3ZlJVeWRqWFJSR1dPU0RtaEtQNENHQXNQakExYno2?=
 =?utf-8?B?VFVHd2IrWnZ6ZFQ1d1d2VHhPWC9EL1cwaEdVcnBqZzZaeDR3OFk2Z3YrdGtV?=
 =?utf-8?B?R21BNHdKVEZkMkZ5c1NyYzdCbXpHZUFJMFgvdWNqQmt2eTJnNzdCN1FEdmQw?=
 =?utf-8?B?ejBPMEdobnZqY1hvSnluN1Bic0puV1ZDaGVvakQ0MWR2OHNFS1RpT2hicy94?=
 =?utf-8?B?RkVQakJ0aGd6MTFmMk5PZnpCWHo2UDhSMmVWM01JdnFDcS9WWkZnVDRFaGFr?=
 =?utf-8?B?Q0tTSzY1Y2hGN0FDRWxLVzJXVW13bzZiZmhURTMrVUNrUEdNTExxbmIxMXpm?=
 =?utf-8?B?TnZBSXFObUNqL21KTldnTUpDQlowakF3aVNNM0ZMMWZ3eXdyMEREejI0YzJ2?=
 =?utf-8?B?ck9rZk41dmNKSytSeTVPOWxIOG43YVpKS2FvbjdacFE3cXd6VFJzdFgzeW1I?=
 =?utf-8?B?NUxVVUJLckE0QTJXN1N6SEE0WDFPRGppN0xJaCs2eFo5T2R2cGdTS0NjV2g5?=
 =?utf-8?B?NzVrY2Q5MVlmQ1p0R0NUVTMycVo4TCtqdi9YREVrRThZL2JObldSVTd3UlBL?=
 =?utf-8?B?SEV6ZzNScWcySk5qUEpBTEVlYko1OGpFS1ZNWVV0NWZJMC8vQ2hvemFaRlEy?=
 =?utf-8?B?UnVwOVlIK1NVSnFkUWtxQ0szcktJaDZVTWRQVC9MRzltSXlLSmxEbG9zWGR2?=
 =?utf-8?B?QVR3UWZ2dE1vbGFZRndXR3p2aDRNOHdyaGx2RDlqQU1rZ0tueFlNUFdIL3lK?=
 =?utf-8?B?RHVuQnlWbnVFV3Ivd0hXcGkzcmptT3Nvc1NWZUcrNHpSNG1HcGZJMFJRVmpx?=
 =?utf-8?B?M1NscVkyOWFyN3U1ZWhLN0RzRmdoeDJVZU1sek9hZ2FxaXllZTJHYzMySUVL?=
 =?utf-8?Q?mhqjw1r54uTmkHVA6DCQe6iloqjgnDoAmEH2hfn?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4af4fc-e2e4-46fc-c9fd-08d925a63cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 09:10:16.4807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rYF/miG5Bnf66XZzqpiMyRakIUHDeTd1OBb2p6nxxJhVQbjIXc+q9SXr0QtPXlpVKYpD5lXY6faAO5XRMlhIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1357
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQ2hyaXMsDQoNCkFjdHVhbGx5LCBJIHRoaW5r
IGFib3V0IHN3aXRjaGluZyBremFsbG9jIHRvIGt2bWFsbG9jIGluIGFtZGdwdV9ib19jcmVhdGUu
DQpIb3dldmVyLCBJIG9ic2VydmUgYnAuZmxhZ3MgPSBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NP
TlRJR1VPVVMgaW4gYW1kZ3B1X3ZtX3B0X2NyZWF0ZS4NCg0KRG9lcyBpdCBtYXR0ZXIgd2Ugc3dp
dGNoIGt6YWxsb2MgdG8ga3ZtYWxsb2MgaWYgdGhlcmUgaXMgYSBwaHlzaWNhbCBjb250aW51b3Vz
IG1lbW9yeSByZXF1ZXN0IHdoZW4gY3JlYXRpbmcgYm8/IFN1Y2ggYXMgQU1ER1BVX0dFTV9DUkVB
VEVfVlJBTV9DT05USUdVT1VTPw0KDQpCUiwNCkNoYW5nZmVuZy4NCg0KDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMiwgMjAyMSA0OjU3IFBNDQpUbzogRGFz
LCBOaXJtb3kgPE5pcm1veS5EYXNAYW1kLmNvbT47IFpodSwgQ2hhbmdmZW5nIDxDaGFuZ2Zlbmcu
Wmh1QGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IGFtZC1nZnhAZnJl
ZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiB0YWtlIGJhY2sg
a3ZtYWxsb2NfYXJyYXkgZm9yIGVudHJpZXMgYWxsb2MgYmVjYXVzZSBvZiBremFsbG9jIG1lbW9y
eSBsaW1pdA0KDQoNCg0KQW0gMDIuMDYuMjEgdW0gMTA6NTQgc2NocmllYiBEYXMsIE5pcm1veToN
Cj4NCj4gT24gNi8yLzIwMjEgMTA6MzAgQU0sIENoYW5nZmVuZyB3cm90ZToNCj4+IEZyb206IGNo
YW5nemh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+DQo+Pg0KPj4gRnJvbTogQ2hhbmdmZW5nIDxD
aGFuZ2ZlbmcuWmh1QGFtZC5jb20+DQo+Pg0KPj4gSXQgd2lsbCBjYXVzZSBlcnJvciB3aGVuIGFs
bG9jIG1lbW9yeSBsYXJnZXIgdGhhbiAxMjhLQiBpbiANCj4+IGFtZGdwdV9ib19jcmVhdGUtPmt6
YWxsb2MuDQo+DQo+DQo+IEkgd29uZGVyIHdoeSBJIGRpZG4ndCBzZWUgdGhlIGVycm9yIG9uIG15
IG1hY2hpbmUuIElzIHRoZXJlIGFueSBjb25maWcgDQo+IEkgbWlnaHQgYmUgbWlzc2luZyA/DQoN
ClZNIHBhZ2UgdGFibGUgbGF5b3V0IGRlcGVuZHMgb24gaGFyZHdhcmUgZ2VuZXJhdGlvbiwgQVBV
IHZzIGRHUFUgYW5kIGtlcm5lbCBjb21tYW5kIGxpbmUgc2V0dGluZ3MuDQoNCkkgdGhpbmsgd2Ug
anVzdCBuZWVkIHRvIHN3aXRjaCBhbWRncHVfYm9fY3JlYXRlKCkgZnJvbSBremFsbG9jIHRvIGt2
bWFsbG9jIChhbmQga2ZyZWUgdG8ga3ZmcmVlIGluIGFtZGdwdV9ib19kZXN0cm95IG9mIGNvdXJz
ZSkuDQoNClNob3VsZG4ndCBiZSBtb3JlIHRoYW4gYSB0d28gbGluZSBwYXRjaC4NCg0KUmVnYXJk
cywNCkNocmlzdGlhbi4NCg0KPg0KPg0KPiBUaGFua3MsDQo+DQo+IE5pcm1veQ0KPg0KPj4gQ2Fs
bCBUcmFjZToNCj4+IMKgwqDCoCBhbGxvY19wYWdlc19jdXJyZW50KzB4NmEvMHhlMA0KPj4gwqDC
oMKgIGttYWxsb2Nfb3JkZXIrMHgzMi8weGIwDQo+PiDCoMKgwqAga21hbGxvY19vcmRlcl90cmFj
ZSsweDFlLzB4ODANCj4+IMKgwqDCoCBfX2ttYWxsb2MrMHgyNDkvMHgyZDANCj4+IMKgwqDCoCBh
bWRncHVfYm9fY3JlYXRlKzB4MTAyLzB4NTAwIFthbWRncHVdDQo+PiDCoMKgwqAgPyB4YXNfY3Jl
YXRlKzB4MjY0LzB4M2UwDQo+PiDCoMKgwqAgYW1kZ3B1X2JvX2NyZWF0ZV92bSsweDMyLzB4NjAg
W2FtZGdwdV0NCj4+IMKgwqDCoCBhbWRncHVfdm1fcHRfY3JlYXRlKzB4ZjUvMHgyNjAgW2FtZGdw
dV0NCj4+IMKgwqDCoCBhbWRncHVfdm1faW5pdCsweDFmZC8weDRkMCBbYW1kZ3B1XQ0KPj4NCj4+
IENoYW5nZS1JZDogSTI5ZTQ3OWRiNDVlYWQzN2MzOTQ0OWU4NTY1OTlmZDRmNmEwZTM0Y2UNCj4+
IFNpZ25lZC1vZmYtYnk6IENoYW5nZmVuZyA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPg0KPj4gLS0t
DQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDI3IA0KPj4g
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMNCj4+IGluZGV4IDE5MjNmMDM1NzEzYS4uNzE0ZDYxM2QwMjBiIDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+PiBAQCAtODk0
LDYgKzg5NCwxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9wdF9jcmVhdGUoc3RydWN0IA0KPj4g
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fZW50cmllcyA9
IDA7DQo+PiDCoCDCoMKgwqDCoMKgIGJwLmJvX3B0cl9zaXplID0gc3RydWN0X3NpemUoKCp2bWJv
KSwgZW50cmllcywgbnVtX2VudHJpZXMpOw0KPj4gK8KgwqDCoCBpZiAoYnAuYm9fcHRyX3NpemUg
PiAzMipBTURHUFVfR1BVX1BBR0VfU0laRSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIERSTV9JTkZP
KCJDYW4ndCBhbGxvYyBtZW1vcnkgbGFyZ2VyIHRoYW4gMTI4S0IgYnkgdXNpbmcNCj4+IGt6YWxs
b2MgaW4gYW1kZ3B1X2JvX2NyZWF0ZVxuIik7DQo+PiArwqDCoMKgwqDCoMKgwqAgYnAuYm9fcHRy
X3NpemUgPSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib192bSk7DQo+PiArwqDCoMKgIH0NCj4+IMKg
IMKgwqDCoMKgwqAgaWYgKHZtLT51c2VfY3B1X2Zvcl91cGRhdGUpDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgYnAuZmxhZ3MgfD0gQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRDsN
Cj4+IEBAIC05NjUsMTUgKzk2OSwxOSBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19wdHMo
c3RydWN0IA0KPj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+IMKgwqDCoMKgwqAgc3RydWN0IGFt
ZGdwdV9ib192bSAqcHQ7DQo+PiDCoMKgwqDCoMKgIGludCByOw0KPj4gwqAgLcKgwqDCoCBpZiAo
ZW50cnktPmJhc2UuYm8pIHsNCj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoY3Vyc29yLT5sZXZlbCA8
IEFNREdQVV9WTV9QVEIpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmll
cyA9DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRvX2FtZGdwdV9ib192bShl
bnRyeS0+YmFzZS5ibyktPmVudHJpZXM7DQo+PiAtwqDCoMKgwqDCoMKgwqAgZWxzZQ0KPj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPSBOVUxMOw0KPj4gLcKgwqDCoMKg
wqDCoMKgIHJldHVybiAwOw0KPj4gK8KgwqDCoCBpZiAoY3Vyc29yLT5sZXZlbCA8IEFNREdQVV9W
TV9QVEIgJiYgIWVudHJ5LT5lbnRyaWVzKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQg
bnVtX2VudHJpZXM7DQo+PiArwqDCoMKgwqDCoMKgwqAgbnVtX2VudHJpZXMgPSBhbWRncHVfdm1f
bnVtX2VudHJpZXMoYWRldiwgY3Vyc29yLT5sZXZlbCk7DQo+PiArwqDCoMKgwqDCoMKgwqAgZW50
cnktPmVudHJpZXMgPSBrdm1hbGxvY19hcnJheShudW1fZW50cmllcywNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZigqZW50cnktPmVudHJp
ZXMpLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
R0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghZW50cnkt
PmVudHJpZXMpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsNCj4+
IMKgwqDCoMKgwqAgfQ0KPj4gwqAgK8KgwqDCoCBpZiAoZW50cnktPmJhc2UuYm8pDQo+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiArDQo+PiDCoMKgwqDCoMKgIHIgPSBhbWRncHVfdm1f
cHRfY3JlYXRlKGFkZXYsIHZtLCBjdXJzb3ItPmxldmVsLCBpbW1lZGlhdGUsIA0KPj4gJnB0KTsN
Cj4+IMKgwqDCoMKgwqAgaWYgKHIpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7DQo+
PiBAQCAtOTg0LDEwICs5OTIsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19wdHMoc3Ry
dWN0IA0KPj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+IMKgwqDCoMKgwqAgcHRfYm8gPSAmcHQt
PmJvOw0KPj4gwqDCoMKgwqDCoCBwdF9iby0+cGFyZW50ID0gYW1kZ3B1X2JvX3JlZihjdXJzb3It
PnBhcmVudC0+YmFzZS5ibyk7DQo+PiDCoMKgwqDCoMKgIGFtZGdwdV92bV9ib19iYXNlX2luaXQo
JmVudHJ5LT5iYXNlLCB2bSwgcHRfYm8pOw0KPj4gLcKgwqDCoCBpZiAoY3Vyc29yLT5sZXZlbCA8
IEFNREdQVV9WTV9QVEIpDQo+PiAtwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPSBwdC0+
ZW50cmllczsNCj4+IC3CoMKgwqAgZWxzZQ0KPj4gLcKgwqDCoMKgwqDCoMKgIGVudHJ5LT5lbnRy
aWVzID0gTlVMTDsNCj4+IMKgIMKgwqDCoMKgwqAgciA9IGFtZGdwdV92bV9jbGVhcl9ibyhhZGV2
LCB2bSwgcHQsIGltbWVkaWF0ZSk7DQo+PiDCoMKgwqDCoMKgIGlmIChyKQ0KPj4gQEAgLTEwMTcs
NiArMTAyMSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxlKHN0cnVjdCANCj4+
IGFtZGdwdV92bV9wdCAqZW50cnkpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3Vu
cmVmKCZzaGFkb3cpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlZigmZW50
cnktPmJhc2UuYm8pOw0KPj4gwqDCoMKgwqDCoCB9DQo+PiArwqDCoMKgIGt2ZnJlZShlbnRyeS0+
ZW50cmllcyk7DQo+PiDCoMKgwqDCoMKgIGVudHJ5LT5lbnRyaWVzID0gTlVMTDsNCj4+IMKgIH0N
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
