Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654C3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045B260FA0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 045B260FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729926E9FA;
	Fri, 10 Sep 2021 14:23:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48FE6E9FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 14:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoJbBjj1yyZj0XDOjs4OnoSTzV+RgJBYoyQNVtnLpf1wSToyGV3TXJ1Ukiv2gj3Arp8SPI3GMZu7/nk7HjjP1hhblx65IlgFCbgB9soyaCP0bq+5LHJtQD9GDEgLbajaADYz3q9b8F4bCd/KfloTRONvJtQDYwJs3bTXCi3ZZt6tgXvXpRRsqHGPd6lPJWHQ7GXkud3/Ad3JPslK2DpHP/ibrFGikgZgD2xYLH3h5Qdou028hZdzODeXio5FkUTwddS5G8ZzV0995BhU2BTjzUcE3uz+Bke9UqQy9x/F4ExTPgHBZJ51aWMIktfXUUjU5JmjzaT71Qr2qbTFGhEsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pULPSvws18xJHS3O5mQBd7pk0hD0R9k4phbRroO8xjc=;
 b=csn5wzFUkMn3k9yOakGmM2jI7ay+3oSkvMx0oemwU2/PUIQvAD/Aib873hcqQi5CnoFtQFYRnc9FZIcEXBumyYY2YN9UQrocUkc3vPH2Fv7g8zwto3Uc5dtkn1N9al+YwaCvJBRYYe5iRo44aiueQAmlLTb6xdD77BpcQMooQH8LwOpdjOqrCYn38VjfYpb1LNeW/ahkRCWZv6NECzu2a8/TdJv9oMpEJJANe8Rc9Zr9Ar3OjH9COLD+RRQLM5hr+rBdfPcgpuwZvtIfnSPKl5aF65qTIKYHqsIGx6gDTTK+xSUpZ0bGWkMC/3S1s29O/MD7feLj8TpMSasDKrqccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pULPSvws18xJHS3O5mQBd7pk0hD0R9k4phbRroO8xjc=;
 b=seZNS581nbH4mZZNZkhEc96BxBWqCzb6b8ytzJVvN+oOYlJUuAlIYkzNtpd/kpVpoS+VkUqlgCQBAtwlhEtaBfTjrAa4L4lAgd5Kn1I0dHGBK8ENuLqLNaLbQdGpzi946FdE3C88IDCS/IjqAI8CdQ3geMuRQBkQHkrIozjJxAQ=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Fri, 10 Sep 2021 14:23:51 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::9dd5:3098:565e:d3db]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::9dd5:3098:565e:d3db%9]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 14:23:51 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
Thread-Topic: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
Thread-Index: AQHXpk7RhRl8uK8X7k60nCZoxItzaqudUT0A
Date: Fri, 10 Sep 2021 14:23:51 +0000
Message-ID: <DM6PR12MB5534A1ECB857AB43476E4D8EF4D69@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210910140457.26887-1-shaoyun.liu@amd.com>
 <86031b43-4b0a-08bd-cbde-e072ff499bc8@amd.com>
In-Reply-To: <86031b43-4b0a-08bd-cbde-e072ff499bc8@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-10T14:23:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1ad6c526-a71e-4988-8326-1af955762eb6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9223ecb-6a47-4e7b-ed3e-08d974669c8d
x-ms-traffictypediagnostic: DM4PR12MB5101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5101985A8D1B2FCEC080A413F4D69@DM4PR12MB5101.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nQJ/FWwF0aj5FhAH1tynHEm5mrDinBJHU1HsrE53Y/W+SvGdZYG49Dnh05QsGtcKndHsN50ZN4AcGAEYWdoKBaEkaNsb9HsumM/G0RhN1WkroQsQtWwir/PvhsJhyIFpLkzMfurZWbAfWfquK8HCkKUvjjra2xtaNl4NhWpf19RkDa3d+3VrwFk6wtRm1uVJgTntrzZ3TJV3AravxzDFOGZ/pV7yQQYxyW3nDZdYQ+A8DsfWdszFcmaVGsXaSusxIiuvslVVvSCPz/mhEsaTcqxIEb3V284XWG7NjRkXBpaYJ5up5v4gghYmPvbUalP6WtbBNRzs4LiW2yx3T0+Pf2/ckoZj/6aTnlDjpOL44kUburAkdA/sIrC5OQgWoo8bQSqTxQcos7EqBM+gBDp/omOcWv7LVrSX7P3J7R/OIUK8AZ4NzhokXy3O9cSXTuSqqKFH1TUjMYpyNBqP3VT3pWl4uo6F5sQhk7Ptd9Y+kadk9JNnFBYFCn2LaniOPOxci1ZpSojifRguCyzXxUf1ayOwtu8ZtIpdD3oXFL40FUZbfvuOyM0O4GUpJ9dlAU1wLakZ4Ptwul0HsfEYw9yY8DsqTHKRgXW/Dq6ki0QS290Ga5FR0LEBxSPigbh7MWnncSjirXAkszuF6W+nzY8w3gV1bgUS6aNcGYjOdKZcXV8waWYRUTiWY3RVCAtmggDBPezAvVEDw2/JT3egVEIYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(8936002)(33656002)(7696005)(71200400001)(76116006)(110136005)(186003)(9686003)(83380400001)(478600001)(5660300002)(122000001)(86362001)(316002)(66446008)(66556008)(55016002)(52536014)(66476007)(64756008)(38100700002)(8676002)(38070700005)(26005)(6506007)(66946007)(2906002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU1tTG9HQWhjL0Z3OW1DKzVqMTgyQU5pK2JjRDdGM0JDUVh4Z2hFTGFIOUFN?=
 =?utf-8?B?SGVOdk5NdERKd1NPOWJRc2Uxalp2ZUVXa2VjNFN2ZUY4bVZYYzkvUUo1M2pv?=
 =?utf-8?B?UktPc0luNnNPWHdyajVnYmlsRmhSdnpRZUdGSWdxbDZQUnJ5bmpvRS9GWCtY?=
 =?utf-8?B?VkczYkVkOEpLTjJIRE50TGMrNVRlMHhKK3MwL3dJRXY5SUFnYVRDSVVxNGVN?=
 =?utf-8?B?VUloamtuZ25vZHIzWThwWmN6YW1YeXd5UmNOTHl6Y3JnK21zWHpZZGlheUd3?=
 =?utf-8?B?Q1JPbnVhaE4wU3BiVmVJLzQ5UGFhZDgxNWFFKzU2QUNtQ2NyUzV3UFhjRktC?=
 =?utf-8?B?RHhLSFNRYnhVOGFqZCs1VWZJTkN3SG1DMC9id0hMNDN0dno3dWJ0b0F3eVpC?=
 =?utf-8?B?cHNINXlZa2dUaWxtNGg2V1Q5RTk0OXlBbm5YU01seFRpNDc1S1I4a2xwZEx4?=
 =?utf-8?B?V0crTkpCbEwxbXRqblU4TS80V0ZrVnNlRmZtWVdGT2hMTzRaUWZ0WW9lT2lL?=
 =?utf-8?B?M3U1U3EvZDRUVFloR3dUNTVobG04ZGpMS0c4THcxMUM1U2RmdW93NjdsckFu?=
 =?utf-8?B?bTFwK2VBT3V2UEJKNjNTRUlnRTBwQVZLMThHUjNpcXg2R2lnOVF1MlI1RG9P?=
 =?utf-8?B?dnB2VXFQZW9BdStaallwNjBCQmlYMXp0MEdHb1pOQkhObUtvNmxIaVN5cyti?=
 =?utf-8?B?SVduNmpuK1M2ZHBZd2ZmOUtSRUZzcy9mNDVXdWJvUmNCRFAzdXVzelVCQ2tM?=
 =?utf-8?B?ek02UERhdmxraVFaRWpzUCtIeDVmVlQ2YjhhZ3ljenAvYVVHU2JMMEpUSVpW?=
 =?utf-8?B?b213U2RGK0hGNDdydmFtRmNZazI4bWkyOHVTaVVSalIxTWQ4Z1ZLRWZwcWhz?=
 =?utf-8?B?WkRzNkpmNGNsaVp1ek9aSDNRS0t1RlBlRmxLSm82MnhYUEYvTUs2NzJWRm9a?=
 =?utf-8?B?M1E4TXRleHRVSkRPVEw3RUVWWHhpUzZ4UEVqbVd3Z2lUNmZ1Yk81QW82WjVq?=
 =?utf-8?B?SXo5a2JzUGZONlUxZnlyb1FVcWREWHNDZ3d3MkliMURQbThadStNOFBDYTRq?=
 =?utf-8?B?cURRNG1sL01NS2JUWlEwck13R2ZCdmhDR21ONmZhSDh6WTBTbjVRSE9EZ2Jo?=
 =?utf-8?B?cXg2ajdzeVZyYk0wZmc4bG05MW1iUWRkNmtZd1pPbnJTQmppSGdZdXBIZ3hM?=
 =?utf-8?B?anJvOTNWdkVyV0xtSzZBZDJNbmR3UUEzMCt3UHhmZ0c0SzYzWEExQVJJd3Ay?=
 =?utf-8?B?M3ZrTVNvN0VzQU95VDFtYW1mb1o1ZnZjZ3B4MXl1aTZNOTZlL20xcDhiSXkz?=
 =?utf-8?B?UDZyc25uczhhcFNiLzkyTGYyaWxTZks2WXd4aHhJSFF2amk0NXdNaXBhMWVG?=
 =?utf-8?B?VnduOHV2Nm0wbjBOdzNkY25tRjMrZGtVR085YU8xSnBDQ1FUOGQvZitpWHhu?=
 =?utf-8?B?U0E5dGNRc0QrbHVzcnRpeE93UEp4L0VzMjJocG80cnB0dDZNd3hUSS95M1JF?=
 =?utf-8?B?ZTk4alEwSWRFSXRLd0F3bXNVUGgySEI5RE1GWlpqaUg3eXhBeU1iWm9YK1hY?=
 =?utf-8?B?cWhER09ldEU3OSt4N1ZxNzhFc0o0Qk9McTVtQnplTVlacG42Uy94dE90VC9B?=
 =?utf-8?B?WmpoczRvSVhSbzlQSFFzN2xOd09uS1JBamtmVHI0SXV0aWJJUFpjOXlCNmNV?=
 =?utf-8?B?bVhYbkt1bExKZ0ZmNmJwanZRSGk5OFdIdSt6RXJWTTA1WjJNNm4vaVQ2TjFu?=
 =?utf-8?Q?s0+Cr+KpE6UJi55bdLnBte23jd5WxrPJqA74tSK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9223ecb-6a47-4e7b-ed3e-08d974669c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 14:23:51.0464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ctFBpiWVY1gTZ9YY5BsqbEB9sUXvnANdJUyZOxHOjrcyITTTdN246034paFRCMChZiDWCfvCxFSRBgc9HKksnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KR29vZCBjYXRjaCAgLiBteSBlZGl0b3Igc2VlbXMg
aGFzIGF1dG8gY29tcGxldGUgZmVhdHVyZSBhbmQgIEkganVzdCBzZWxlY3QgdGhlIGZpcnN0IG9u
ZSAuICDimLkNCg0KVGhhbmtzIA0KU2hhb3l1bi5saXUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4gDQpT
ZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMCwgMjAyMSAxMDoxOSBBTQ0KVG86IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBHZXQgYXRvbWljT3BzIGluZm8gZnJvbSBI
b3N0IGZvciBzcmlvdiBzZXR1cA0KDQpBbSAyMDIxLTA5LTEwIHVtIDEwOjA0IGEubS4gc2Nocmll
YiBzaGFveXVubDoNCj4gVGhlIEF0b21pY09wIFJlcXVlc3RlciBFbmFibGUgYml0IGlzIHJlc2Vy
dmVkIGluIFZGcyBhbmQgdGhlIFBGIHZhbHVlIA0KPiBhcHBsaWVzIHRvIGFsbCBhc3NvY2lhdGVk
IFZGcy4gc28gZ3Vlc3QgZHJpdmVyIGNhbiBub3QgZGlyZWN0bHkgZW5hYmxlIA0KPiB0aGUgYXRv
bWljT3BzIGZvciBWRiwgaXQgZGVwZW5kcyBvbiBQRiB0byBlbmFibGUgaXQuIEluIGN1cnJlbnQg
DQo+IGRlc2lnbiwgYW1kZ3B1IGRyaXZlciAgd2lsbCBnZXQgdGhlIGVuYWJsZWQgYXRvbWljT3Bz
IGJpdHMgdGhyb3VnaCANCj4gcHJpdmF0ZSBwZjJ2ZiBkYXRhDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IHNoYW95dW5sIDxzaGFveXVuLmxpdUBhbWQuY29tPg0KPiBDaGFuZ2UtSWQ6IElmZGJjYjQzOTZk
NjRlM2YzY2JmNmJjYmY3YWI5YzdiMmNiMDYxMDUyDQoNClBsZWFzZSByZW1vdmUgdGhlIENoYW5n
ZS1JZC4NCg0KSW4gZ2VuZXJhbCwgdGhlIGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLiBPbmUgcXVl
c3Rpb24gYW5kIG9uZSBtb3JlIG5pdC1waWNrIGlubGluZSAuLi4NCg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICB8IDI1IA0KPiArKysrKysr
KysrKystLS0tLS0tLS0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGd2X3NyaW92bXNn
LmggfCAgDQo+IDQgKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkgIG1vZGUgY2hhbmdlIA0KPiAxMDA2NDQgPT4gMTAwNzU1IGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiAgbW9kZSBjaGFuZ2UgMTAwNjQ0
ID0+IDEwMDc1NSANCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3Zfc3Jpb3Ztc2cu
aA0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0K
PiBvbGQgbW9kZSAxMDA2NDQNCj4gbmV3IG1vZGUgMTAwNzU1DQo+IGluZGV4IDY1M2JkOGZkYWEz
My4uZmM2YTY0OTFjMWI2DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4gQEAgLTM1MjksMTcgKzM1MjksNiBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAgCURSTV9JTkZPKCJyZWdpc3RlciBtbWlvIGJh
c2U6IDB4JTA4WFxuIiwgKHVpbnQzMl90KWFkZXYtPnJtbWlvX2Jhc2UpOw0KPiAgCURSTV9JTkZP
KCJyZWdpc3RlciBtbWlvIHNpemU6ICV1XG4iLCAodW5zaWduZWQpYWRldi0+cm1taW9fc2l6ZSk7
DQo+ICANCj4gLQkvKiBlbmFibGUgUENJRSBhdG9taWMgb3BzICovDQo+IC0JciA9IHBjaV9lbmFi
bGVfYXRvbWljX29wc190b19yb290KGFkZXYtPnBkZXYsDQo+IC0JCQkJCSAgUENJX0VYUF9ERVZD
QVAyX0FUT01JQ19DT01QMzIgfA0KPiAtCQkJCQkgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09N
UDY0KTsNCj4gLQlpZiAocikgew0KPiAtCQlhZGV2LT5oYXZlX2F0b21pY3Nfc3VwcG9ydCA9IGZh
bHNlOw0KPiAtCQlEUk1fSU5GTygiUENJRSBhdG9taWMgb3BzIGlzIG5vdCBzdXBwb3J0ZWRcbiIp
Ow0KPiAtCX0gZWxzZSB7DQo+IC0JCWFkZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0ID0gdHJ1ZTsN
Cj4gLQl9DQo+IC0NCj4gIAlhbWRncHVfZGV2aWNlX2dldF9wY2llX2luZm8oYWRldik7DQo+ICAN
Cj4gIAlpZiAoYW1kZ3B1X21jYnApDQo+IEBAIC0zNTYyLDYgKzM1NTEsMjAgQEAgaW50IGFtZGdw
dV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gIAlpZiAocikNCj4g
IAkJcmV0dXJuIHI7DQo+ICANCj4gKwkvKiBlbmFibGUgUENJRSBhdG9taWMgb3BzICovDQo+ICsJ
aWYgKGFtZGdwdV9zcmlvdl9iaW9zKGFkZXYpKQ0KDQpJcyB0aGlzIHRoZSBjb3JyZWN0IGNvbmRp
dGlvbj8gSSB0aGluayB0aGlzIHdvdWxkIGJlIHRydWUgZm9yIHRoZSBQRiBhcyB3ZWxsLiBCdXQg
b24gdGhlIFBGIHdlIHN0aWxsIG5lZWQgdG8gY2FsbCBwY2lfZW5hYmxlX2F0b21pY19vcHNfdG9f
cm9vdC4NCkkgd291bGQgZXhwZWN0IGEgY29uZGl0aW9uIHRoYXQgb25seSBhcHBsaWVzIHRvIFZG
cy4NCg0KDQo+ICsJCWFkZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0ID0gKChzdHJ1Y3QgYW1kX3Ny
aW92X21zZ19wZjJ2Zl9pbmZvICopDQo+ICsJCQlhZGV2LT52aXJ0LmZ3X3Jlc2VydmUucF9wZjJ2
ZiktPnBjaWVfYXRvbWljX29wc19lbmFibGVkX2ZsYWdzID09DQo+ICsJCQkoUENJX0VYUF9ERVZD
QVAyX0FUT01JQ19DT01QMzIgfCBQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVA2NCk7DQo+ICsJ
ZWxzZQ0KPiArCQlhZGV2LT5oYXZlX2F0b21pY3Nfc3VwcG9ydCA9DQo+ICsJCQkhcGNpX2VuYWJs
ZV9hdG9taWNfb3BzX3RvX3Jvb3QoYWRldi0+cGRldiwNCj4gKwkJCQkJICBQQ0lfRVhQX0RFVkNB
UDJfQVRPTUlDX0NPTVAzMiB8DQo+ICsJCQkJCSAgUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01Q
NjQpOw0KPiArCWlmICghYWRldi0+aGF2ZV9hdG9taWNzX3N1cHBvcnQpDQo+ICsJCWRldl9pbmZv
KGFkZXYtPmRldiwgIlBDSUUgYXRvbWljIG9wcyBpcyBub3Qgc3VwcG9ydGVkXG4iKTsNCj4gKw0K
PiArDQoNCkRvdWJsZSBibGFuayBsaW5lcy4gT25lIGlzIGVub3VnaC4NCg0KUmVnYXJkcywNCsKg
IEZlbGl4DQoNCg0KPiAgCS8qIGRvb3JiZWxsIGJhciBtYXBwaW5nIGFuZCBkb29yYmVsbCBpbmRl
eCBpbml0Ki8NCj4gIAlhbWRncHVfZGV2aWNlX2Rvb3JiZWxsX2luaXQoYWRldik7DQo+ICANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGd2X3NyaW92bXNnLmgg
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3Zfc3Jpb3Ztc2cuaA0KPiBvbGQg
bW9kZSAxMDA2NDQNCj4gbmV3IG1vZGUgMTAwNzU1DQo+IGluZGV4IGE0MzRjNzFmZGU4ZS4uOTk1
ODk5MTkxMjg4DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGd2X3NyaW92
bXNnLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3Zfc3Jpb3Ztc2cu
aA0KPiBAQCAtMjA0LDggKzIwNCwxMCBAQCBzdHJ1Y3QgYW1kX3NyaW92X21zZ19wZjJ2Zl9pbmZv
IHsNCj4gIAl9IG1tX2J3X21hbmFnZW1lbnRbQU1EX1NSSU9WX01TR19SRVNFUlZFX1ZDTl9JTlNU
XTsNCj4gIAkvKiBVVUlEIGluZm8gKi8NCj4gIAlzdHJ1Y3QgYW1kX3NyaW92X21zZ191dWlkX2lu
Zm8gdXVpZF9pbmZvOw0KPiArCS8qIHBjaWUgYXRvbWljIE9wcyBpbmZvICovDQo+ICsJdWludDMy
X3QgcGNpZV9hdG9taWNfb3BzX2VuYWJsZWRfZmxhZ3M7DQo+ICAJLyogcmVzZXJ2ZWQgKi8NCj4g
LQl1aW50MzJfdCByZXNlcnZlZFsyNTYgLSA0N107DQo+ICsJdWludDMyX3QgcmVzZXJ2ZWRbMjU2
IC0gNDhdOw0KPiAgfTsNCj4gIA0KPiAgc3RydWN0IGFtZF9zcmlvdl9tc2dfdmYycGZfaW5mb19o
ZWFkZXIgew0K
