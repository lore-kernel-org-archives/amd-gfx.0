Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A699C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 11:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAC864E64
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 11:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAC864E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DBD89F9F;
	Mon, 15 Feb 2021 11:45:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B88389F9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 11:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOwjvbsBHszGEz/rRdkV0rYOTlWDoZkH4Pd35iAuNUapnGS2K5ebJXoXxmKllgfXDsKC5ely5UWyCj2n6jRwVOPZ/pNMwU3Uc5ztmYrEbVBtZO3+OQoISZ013HCaPTlf5MoCyGKQ/NTzA1pkEQz6IodtU9w5P1nTZCyx/mcSCin9ETkeWwOCPeH4LhNWPlcQZA5mjdazJzuyw3EJoO6iuaXuspQek1O6Ld/bMuGB8AhhpHZ75Uulll3iv+Ui2EYfr2T1ay31+zFue6PAmpQfGPl33iUy0gXxau/VEL10FITByqdjV9/YlumPfFfvcUXO2iM4PTb3DSJTGmcDYJtZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wev3+6tvOdFKD3wdGwTBiimYqx3gC5sGauP2Od7K5Os=;
 b=meA+dM5mHv5YOz9biLq0jG9RC1pPJX3jmsvXJKEzUZZOPqEpqKJjB1vNfOMKI7pvmxrXhwoZ/OXTjJovhN3Msx2Lr3ZHO8cpV4q7Fuea3eB9W7G3OG4jXjZDhYrQbKYVMViD3OiQSu2AnPUJOwF0af4T3Z/JmkZah1sRuIb8ehgOAfpa6eH9x5fDLTvEtqBPj8M1GSKaajqfkPWYlrm1g8/NEQhERqMAvIEvxvRxXkeZsIJZceQzFz9Viff1Sn5tC3fTGqsldpzTtHo4eExMAjXCarT1sexewxSXUsv7Zv93h7bq+BREIYBH4wZMJrPlApErPW2v6AH+Y/zLTtEI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wev3+6tvOdFKD3wdGwTBiimYqx3gC5sGauP2Od7K5Os=;
 b=ivk7fxEW/R5StX3eXCkCOyNAMb6agGl86MyAzCXf8knafgkIpUu+LcA+nui41/oSonBPCkhfuRcgojpMRjPk+hfLIMrjE3+c85SJ0/BiKTHP+Za/3MY0eWjGH/QDkWsadnjQWxpRogeBV0bG4GrqFjEgsuEubrdxEFB8P2zRnbI=
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB2982.namprd12.prod.outlook.com (2603:10b6:a03:a8::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Mon, 15 Feb
 2021 11:45:22 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::dd41:21fb:f94f:eb03%3]) with mapi id 15.20.3846.034; Mon, 15 Feb 2021
 11:45:22 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Set GTT_USWC flag to enable freesync v2
Thread-Topic: [PATCH] drm/amdgpu: Set GTT_USWC flag to enable freesync v2
Thread-Index: AQHXA4/OvkxYljVW+E6PlGu7w51m96pZGLiAgAAAGbA=
Date: Mon, 15 Feb 2021 11:45:21 +0000
Message-ID: <BYAPR12MB31269FDFFFA7511614C4B04CF2889@BYAPR12MB3126.namprd12.prod.outlook.com>
References: <20210215114336.89977-1-christian.koenig@amd.com>
 <0a679d74-6066-0ed8-26f8-2d02b6db5210@gmail.com>
In-Reply-To: <0a679d74-6066-0ed8-26f8-2d02b6db5210@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-15T11:45:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=294f8bd9-d814-4573-82a8-763d9731c935;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e9f2e82-a14a-46a2-a1ae-08d8d1a72d28
x-ms-traffictypediagnostic: BYAPR12MB2982:
x-microsoft-antispam-prvs: <BYAPR12MB2982AF099119992F44BA7A04F2889@BYAPR12MB2982.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OW4iyg3c/RGxOemP6c6Q33DSV4zzfxPDoniQLinnbx5m3IqPTzZ+6Eqh0cYxE8kFEwFsfERFrsw1tTGwq/Q09eXdV3O+9Hzm8M+gxYTGjh6qWucDdMgVp6HRNIrF+PHTFNIzW/j/aD6XUIFpJ/LZ1Rumt37JvgaRO/LnZkz+Q+LisSNhcy2TMa3v0oMU9m/XTPlgy0I9f19xylMRhvzJoLB0KSwS0I8JQyeYncLTWt7JTkLwao8EyUzdvVjc6WN5BdSaUdPZ3PXDjuUOomN5zcDlFW3VW2asyda6Z078JFGwITE1TnOkLw8D1hTdM4qbpPpxx+5lr80Qsd9WeiRxL9/GRIfbALjeBKjWm0p1NbH9aRVjNwh0KTLaoSwKiMW9yVHeKobOyiw6ISrQuNchGlhCETLX2bjEPh79piPAh/QgAqVgSweIJUcL56of5rehF+V1w23aeK/ec3s4HiXt+FStUvzyYmw5lvQ/K4wVfB5+FlAn+NJDFjVa4QPk1Nv/znTsGQ0/+u4xOaA2gGIKRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(478600001)(86362001)(53546011)(33656002)(7696005)(8936002)(71200400001)(26005)(6506007)(5660300002)(83380400001)(110136005)(8676002)(76116006)(55016002)(66556008)(9686003)(66446008)(64756008)(66946007)(186003)(66476007)(316002)(52536014)(66574015)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TTA0K0ZyNjRNZVd3SjVicjhpRWlxb1JyZmVFTG9wSnlZMDVTQXJxblNnTndK?=
 =?utf-8?B?d29kNlIyTUVmLzBXZXhpa0h4REtqaDhxRk5QN1hSQXhuei8zb1VkeWdlY0pr?=
 =?utf-8?B?MXlkZXVyd3hKdnN5SFJWa3UweWMxaFZTeThxdzlkdE5NTStuTDJvV0tIUW05?=
 =?utf-8?B?cS9xQ0FkL0FJL1RoUUp5TzZSWHV6WHRJcDFZZmZFM1dZZUQ0N3hjeEZLNVpJ?=
 =?utf-8?B?RHBTNkRxOGxKQ2RDckx1RytEa3NGajFsM01NcUlPT085Vkh0NEk3VTNuc2hR?=
 =?utf-8?B?dE5xYmM5QlFyUk90WjJyZjl2ZTRXVnk0UmNSVDV6MXllS3BXNVRPMVdPNTBh?=
 =?utf-8?B?enBZZXFRWlA3YkFGZ3ZSSVJUSm80RW5tSk9mSVRQd0c0dXBHMGVsWHhoSHRM?=
 =?utf-8?B?NWMycW95NGI0TWFqcW9ZWHVrYjRyU2U0bE5JTS91c1JqdzZ2SmRjbVNLWDRN?=
 =?utf-8?B?NmdlY2o5ckdnNm02cnA4WUJ4bUR6cXQ5ZXMyUGpDaEwvRjdLOWx1ZzQ1Z3dI?=
 =?utf-8?B?RkNLc1dJZGhrUjZrZktjd1Y1Y28rS0o5MisvVnF4cGtDd05EaGpONFJwa1A0?=
 =?utf-8?B?M0U3VHFDMCs3OHNtQm9La3R3UVdnMWk4L09YczZmLzNXN0JMYmFZa01WSTlx?=
 =?utf-8?B?NlJRcTdiUnlUV2dEUDJBNjFkeCs1Z2krTnllRFVjYlQ1RmJDQ2oydXBudXc0?=
 =?utf-8?B?Y29hUjcyVFMwbkQ3cVpodlBBTDEyQmhkbWZma2xNaUhJK3NWdFAweGJObDJo?=
 =?utf-8?B?UFdRL2hseGNkM2dNbUg1aC9WMVU1c2VWa3M4OU9zRWVJenlWNGcyYityU3JH?=
 =?utf-8?B?RE9jdmo0TGlyQXJaeWZzK0kxSUNwcVRYT0pGN0h3NVBkdjhSY29zK29tcW5z?=
 =?utf-8?B?eVFRUUE5aCs5RmxXelhVRUlFYVRsVXJFUVRETnJNYi96K2lxZEh2QWpkemJE?=
 =?utf-8?B?NFJnS1lpcWRZOUFmQmpKSThqaHFScXR4R01sMmppY1FhRElOYlhYTEl3ejdR?=
 =?utf-8?B?MWo1M0dEbTVpVVh0TmJVbSt6Q2ZKYUltVUdZOFk1amZSN1kzcUtzMjFWZ1FY?=
 =?utf-8?B?K3g1QTQyN3RkUEVHYWFXdFJGcVp4UFp0VTNGbzl6VjRIbGZOQk1FY2hHS3JE?=
 =?utf-8?B?MWM1c2dFKzdLZTBiZm9rVXpUQ1NGMnUzcTFrZEJVY2ZCVms2K0YvdkxNekdU?=
 =?utf-8?B?YnRVaUFlN3JDY3JRZnQxUS9waE1VblFNWjRzZVc3ajNQVEVyZ0kzQWY5a0Fq?=
 =?utf-8?B?dTBScnh6RmxSQ2oxUmZGUE1hL0xFUHJSTDJ2aE1Ed3R3WVdqZ0VnYk9QUVFm?=
 =?utf-8?B?Ymp4c0tQdy9MeFVvQ1E4YXZobHlVU1NES09Ld3Q3TEVUMVFYSE5rYW1sRlRX?=
 =?utf-8?B?MTB5UEp6d0czTGp5OXlQTEw0TDdzS0gvMVJqZkhKVmw1MXpkZ2ZQdGNkaVkv?=
 =?utf-8?B?elliTDBzNWJ5eDdnK3NMMWNOc2ZIWmZRQXIvaHk5dEZmc3A5MENBRk9jVDJH?=
 =?utf-8?B?TDVqZWhOM3ZTYWR3WUVBV2RNb09wVlFpdWljSWFSSllOa2x3aVRjNGFoSm82?=
 =?utf-8?B?NW5EcjBRNSs0eXU2UGkybzJ5aWZNUEpzRU5xYk9laFVhZkNHL0dnYWZobS9v?=
 =?utf-8?B?L29Lb0VpV3RRNTNveGcvaGdxWWp1NkFZYzNZRFE5a3FHUXhwSXZyc3poNnBq?=
 =?utf-8?B?MThxQUswV3BWY0JrcUZzVkZPL0F0QTNtYkY3dTZnVi9EM0RGQm9Zc0J4Q3Z5?=
 =?utf-8?Q?sTUZ5bwGbpPXHIY8Sby4Q6pZg0jF+cykg8Q+snw?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9f2e82-a14a-46a2-a1ae-08d8d1a72d28
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 11:45:21.9296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jO09lLr6SbgytF0O2CI28tPgDEKg1Hjqa1povxaCCjUMZTQp+Xv95SrBrPke4GTLRFlokHdgYMg5dRJbfrRWqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2982
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpT
dXJlLCBsZXQgbWUgdHJ5IHRoaXMgb3V0LCANCg0KUmVnYXJkcw0KU2hhc2hhbmsNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNo
dHp1bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDE1LCAyMDIxIDU6
MTUgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU2hhcm1hLCBTaGFzaGFu
ayA8U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1OiBTZXQgR1RUX1VTV0MgZmxhZyB0byBlbmFibGUgZnJlZXN5bmMgdjINCg0KSGkgU2hhc2hh
bmssDQoNCmNhbiB5b3UgZ2l2ZSB0aGlzIHBhdGNoIGEgdGVzdCByb3VuZD8gSW4gdGhlb3J5IGl0
IHNob3VsZCB3b3JrLCBidXQgSSdtIG5vdCAxMDAlIHN1cmUuDQoNClRoYW5rcywNCkNocmlzdGlh
bi4NCg0KQW0gMTUuMDIuMjEgdW0gMTI6NDMgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOg0KPiBG
cm9tOiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPg0KPg0KPiBUaGlz
IHBhdGNoIHNldHMgJ0FNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQycgYXMgaW5wdXQgcGFy
YW1ldGVyIA0KPiBmbGFnLCBkdXJpbmcgb2JqZWN0IGNyZWF0aW9uIG9mIGFuIGltcG9ydGVkIERN
QSBidWZmZXIuDQo+DQo+IEluIGFic2VuY2Ugb2YgdGhpcyBmbGFnOg0KPiAxLiBGdW5jdGlvbiBh
bWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucygpIGRvZXNuJ3QgYWRkDQo+ICAgICBBTURH
UFVfR0VNX0RPTUFJTl9HVFQgYXMgc3VwcG9ydGVkIGRvbWFpbi4NCj4gMi4gRHVlIHRvIHdoaWNo
LCBGdW5jdGlvbiBhbWRncHVfZGlzcGxheV91c2VyX2ZyYW1lYnVmZmVyX2NyZWF0ZSgpDQo+ICAg
ICByZWZ1c2VzIHRvIGNyZWF0ZSBmcmFtZWJ1ZmZlciBmb3IgaW1wb3J0ZWQgRE1BIGJ1ZmZlcnMu
DQo+IDMuIER1ZSB0byB3aGljaCwgQWRkRkIoKSBJT0NUTCBmYWlscy4NCj4gNC4gRHVlIHRvIHdo
aWNoLCBhbWRncHVfcHJlc2VudF9jaGVja19mbGlwKCkgY2hlY2sgZmFpbHMgaW4gRERYIDUuIER1
ZSANCj4gdG8gd2hpY2ggRERYIGRyaXZlciBkb2Vzbid0IGFsbG93IGZsaXBzIChnb2VzIHRvIGJs
aXR0aW5nKSA2LiBEdWUgdG8gDQo+IHdoaWNoIHNldHRpbmcgRnJlZXN5bmMvVlJSIHByb3BlcnR5
IGZhaWxzIGZvciBQUklNRSBidWZmZXJzLg0KPg0KPiBTbywgdGhpcyBwYXRjaCBmaW5hbGx5IGVu
YWJsZXMgRnJlZXN5bmMgd2l0aCBQUklNRSBidWZmZXIgb2ZmbG9hZGluZy4NCj4NCj4gdjIgKGNo
ayk6IGluc3RlYWQgb2YganVzdCBjaGVja2luZyB0aGUgZmxhZyB3ZSBjb3B5IGl0IG92ZXIgaWYg
dGhlDQo+ICAgICAgICAgICAgZXhwb3J0ZXIgaXMgYW4gYW1kZ3B1IGRldmljZSBhcyB3ZWxsLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
bWFfYnVmLmMgfCAxNCArKysrKysrKysrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jDQo+IGluZGV4IGQzNzI3ZjNhYjI3Ny4uYTU0YTg3MGYw
MDZjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1h
X2J1Zi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVm
LmMNCj4gQEAgLTQyMiwxNCArNDIyLDIyIEBAIGFtZGdwdV9kbWFfYnVmX2NyZWF0ZV9vYmooc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0IGRtYV9idWYgKmRtYV9idWYpDQo+ICAgew0KPiAg
IAlzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3YgPSBkbWFfYnVmLT5yZXN2Ow0KPiAgIAlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IGRybV90b19hZGV2KGRldik7DQo+IC0Jc3RydWN0IGFtZGdwdV9i
byAqYm87DQo+ICAgCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ29iajsNCj4gKwlzdHJ1Y3QgYW1k
Z3B1X2JvICpibzsNCj4gKwl1aW50NjRfdCBmbGFncyA9IDA7DQo+ICAgCWludCByZXQ7DQo+ICAg
DQo+ICAgCWRtYV9yZXN2X2xvY2socmVzdiwgTlVMTCk7DQo+ICsNCj4gKwlpZiAoZG1hX2J1Zi0+
b3BzID09ICZhbWRncHVfZG1hYnVmX29wcykgew0KPiArCQlzdHJ1Y3QgYW1kZ3B1X2JvICpvdGhl
ciA9IGdlbV90b19hbWRncHVfYm8oZG1hX2J1Zi0+cHJpdik7DQo+ICsNCj4gKwkJZmxhZ3MgfD0g
b3RoZXItPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDOw0KPiArCX0NCj4g
Kw0KPiAgIAlyZXQgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUoYWRldiwgZG1hX2J1Zi0+c2l6
ZSwgUEFHRV9TSVpFLA0KPiAtCQkJQU1ER1BVX0dFTV9ET01BSU5fQ1BVLA0KPiAtCQkJMCwgdHRt
X2JvX3R5cGVfc2csIHJlc3YsICZnb2JqKTsNCj4gKwkJCQkgICAgICAgQU1ER1BVX0dFTV9ET01B
SU5fQ1BVLCBmbGFncywNCj4gKwkJCQkgICAgICAgdHRtX2JvX3R5cGVfc2csIHJlc3YsICZnb2Jq
KTsNCj4gICAJaWYgKHJldCkNCj4gICAJCWdvdG8gZXJyb3I7DQo+ICAgDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
