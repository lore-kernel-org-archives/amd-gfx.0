Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748FDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 09:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29022610E7
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 09:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29022610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A1E6EE64;
	Mon, 18 Oct 2021 09:51:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96F66EE64
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 09:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgD9QtNYUZa8p8Og4gvkVw6Sp0kM2qwZf4cLMhFbjBXTMKriXPq6naP/VMmdfHoWmnJCVYmBcjJ99Nk4odekKMRAOEWYyLn45MpWOCEeJt3a4vxQ7TISlKSJvM5y4fthz574KWcAyhAjeT9HnOBlsSUgmHNrorkzoG2Il/K8Q3h1ePudEyv5ws+1YBoh15AdQ5JZ0kDLq2Pg2nhE5XJYZfq44EgSFTTRBXc3OFsyNSmCjq+reP3y39dsyU/lLvftr2uPxuzFF9K0PvLXxyYdMap54R6lfhvaZQOQJ7LZYqi7sw62R6ErjlhjU9oHryRu6qFKCAB2IbIZgz81Q7cXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt30mDmftyGYxyc479RefS5X1uMI8UTR+yqVhaL5UW0=;
 b=RlFXzajpHkPFZd6lcoUpRJpWV9GOLIFlvaBJYV/yc2iRZYIDFkoFhoptaeWYTu0ujDAvAvGtmQyifT5I9J05VPluWaPDPvV5Iz9Kuj0CLF5XMggzpZeyO0R0li2JiwG88JlICMAkg2VdRJOEmQIO9J03CqehfCCRrteZeY1wlGFOx5hF6SYwsO8Qe6H+G7N9HyvMkEW4WKsV3DTE51AJHmQqu+33I5Ns4FkZBqpkWtUUjSU42hvKOK7rEn+5JbjQPUHSo4FhChxjM7x9Q9tMGR9DSOU90jYUDRTtIp9Gwz6FBdB1n9o1t+5ECQowNvMyHijfswBC0CUpKQPt2NczGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt30mDmftyGYxyc479RefS5X1uMI8UTR+yqVhaL5UW0=;
 b=TGzRyCGiSGgDQz4lkyTZM3wyyFIL0AJmuAVYLsIl+pwbcI/9CETQdDy4yFmlGN8F2axTFoamszAQlnAjZYWvMKpSXDk/MYEviBAnKdobpLDF9VCENIOxIJo61JS1II/CXKNOINDy4Vz8Kv7ZvzOeBnKLRhATnfDh+fwxW69MEwY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 09:51:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 09:51:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "bp@alien8.de"
 <bp@alien8.de>
Subject: RE: [PATCH] drm/amdgpu: fix the hang observed on Carrizo due to UVD
 suspend failure
Thread-Topic: [PATCH] drm/amdgpu: fix the hang observed on Carrizo due to UVD
 suspend failure
Thread-Index: AQHXw/KptwZ8Klc65kmsh84HzYwfCavYY7qAgAAT4iA=
Date: Mon, 18 Oct 2021 09:51:16 +0000
Message-ID: <DM6PR12MB26195457A0FA18D65FA93DDDE4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211018073432.1525697-1-evan.quan@amd.com>
 <c995c339-1b9d-2a8d-930b-ae48ffe44b99@amd.com>
In-Reply-To: <c995c339-1b9d-2a8d-930b-ae48ffe44b99@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-18T09:51:12Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=080af4ac-13fa-41ae-a8ec-71bbbc8aa325;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cba97ff-4811-4b93-d891-08d9921cd43b
x-ms-traffictypediagnostic: DM6PR12MB3083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30831A9FC1A66D3D6264EAE5E4BC9@DM6PR12MB3083.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXiDHgugOvJTo3hC1npqpIc8MnUCUb8PiwV5/Rzy9lsyPeJBHtf+ClNZLDlgJj/HOyU+JHUMKXtj5zEHW5cgBiTMGz5vvtZgedocHNTm2QLe8JFx6SrGhXGKayu/Km6UMpxXq9gInQlT5iukIFzoUiD/hQB97hWT25Anf453VeGq4Z7S4+kanfziHv3oaWt3pWAMp8JDBUHl1vhvLShux2xY3aVWo8AomZ1PQHIsLsqO65axnn6JtxnSzVyZLqg5XdrSWz/MY4egLbLUt/2A54lFC83sUPbtEAGjTRCDtRNxU4LU3/ljE/2ba8ucBJbqX50MyveX2we/I9WNu8LP87nQuEKA7RkxumBBFqIkS+mHuXspWtPhEsnxsLdXySr8prSFpKCkRaS5yth+G4ANDdjO7/3z08VQOppaY3BdLNMEH/eK0YrN/ZTS86OQ4T76frequNMrEjncTE5/cDIxrH/IaIQnOyPge8MHL5pSaW5eaPkuvc27wLZ/9nbAw8RQgVFvLHtqmpLjUM0IJEHmHKXoWzAspuZf7+xgpSxpSXWM02rcjxpRGq5FkpeEp/Z88htY5GmPr1yU4SYJkjNxIu9qSwRZISz/Rx4O+066H46gQwTjtcBT/bbFNShO0xuSSvnxg31PqQfM+3b3tynPd1/8JNVExEi34v2pWBqEGoBI5QwT1ClBdUhbb+W2PSZaTp9jTi5roVbLOAgxaqBHyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(52536014)(71200400001)(55016002)(7696005)(15650500001)(66476007)(8676002)(76116006)(66446008)(64756008)(9686003)(83380400001)(8936002)(38100700002)(66556008)(186003)(122000001)(33656002)(54906003)(2906002)(53546011)(316002)(110136005)(86362001)(26005)(66946007)(5660300002)(4326008)(6506007)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3hCcXlnY29keXM2alh5QlltUWdJQy83UElsMy90RmlJUU50R202MFJhUXpw?=
 =?utf-8?B?K2RNSWt2RVlYV0MydHZQeHdkcHZvb1VPYXYrZDh3bzRtc2R4NXlvc3lzRWFL?=
 =?utf-8?B?UkQ0aGQyeEYrSlNpOVVkdWFHN3g3MVUvWTFIbXpLWnJmODFORWI2bkc5c2Jt?=
 =?utf-8?B?bFpFcjRSYVdpYjFVUzdXZ0d5cm9MWnp4ZkZ3d2RNcGttb1lxMUdnUVVuc2lZ?=
 =?utf-8?B?YXAxWVcrSHZZQStidWVPRnNidXBrK0FvZFdxcGNiTGdxdVBOa2pkVkxsRTcz?=
 =?utf-8?B?Wm1mWThkeTdyZGpKeWJqUEt1WTFmOWxzb09jaFBORlF5YzdadHNkL29JTC80?=
 =?utf-8?B?UURHUU1VTjRyVmsyVlhmWDNHWlBEREVBbnpxbWFZei93Qmg3cUJmUVJpSlRj?=
 =?utf-8?B?KzhjVXl6U2hFQ3pvRFhjWHdob2lSeXl4VE54ZHdNK1NKQmIxWjZPTFZjZm1S?=
 =?utf-8?B?NmFXNUEwZnpENFdWSTg5dEtzNVF0ZG9IYTVPR3NGaU9JWktacDA2RkI2Ymtv?=
 =?utf-8?B?SHNBQ3VsRGZvMmdob0tFck9lZGU4anN2WUxJU2hhRXluUmYzeDdnVDU3V0ht?=
 =?utf-8?B?YXJUblh1YlhxbXFkRGdGV1VXeGxmZ28rODZDWGhJTVh1cFNNRUNBVjhjUm5B?=
 =?utf-8?B?Mms5R3Y5aWRkTVQrdkY1OHB4Z1pxRGI3L2hpelZFL1NpZ011emxLMlphb2ta?=
 =?utf-8?B?a2svZnFlZnc1WWtFQlAxRTRvb1lvcU9TNkpWamJRcWlxcm0xKzAyVFNYazNN?=
 =?utf-8?B?WEFsYVNqbGRDbzBRQzR6TzNwU20vQThnM21PWDIvNDVwV2FXaHc1aHNIWjdK?=
 =?utf-8?B?N2xWS0V1M2I1NjdMNkV6RUpCdHFVRENoV2twamJqdkIxcmJaTlVXUWliUmJD?=
 =?utf-8?B?cTNlTk16WjQvVHBBcFBYcEtKT3YzRGZxWGJFdHY5OU1XejF0SExRMndVZEZO?=
 =?utf-8?B?MTgzNUhGRVhDa2FRRU8xOG0wclM5V0xwdDFiREhvcmNaRnA4S2IvcFFnTlhE?=
 =?utf-8?B?a01ib3haNGhRcWlHUzFvVXJ4K0FERlhrcDJYaDlWMG5NMWN2djVPdEFUc21w?=
 =?utf-8?B?S3BMdUpoM05sQjVOaEpsTzNjQlhmelliZE9yTkNoRCt3TE9rcEZTOTVwVVYv?=
 =?utf-8?B?SWJGNDNyaDZEL3NqZEhySUVXZVlEY3FBYzY2OUQwalpHTWNFaUVlVXRGSThG?=
 =?utf-8?B?S3B2TEYvZTRiMFVPSklZbEl6VzAyb285OEtsT3VyWDROclk5RC9jeEpqWTZl?=
 =?utf-8?B?QjNweUF1YnVwUXR1cUNNNkJQYjVYbUI1SFhuekZxWVl0WFRXYTFUUGNrclVz?=
 =?utf-8?B?WEtJS0FwRmszV3M5b2R5ZG1WbkpkVis2SU1IR0VYY0xacm9DalMvcEN1WjZm?=
 =?utf-8?B?S0x5M0dRSGVyaUFJNkZabStBWFJnYktrT1Q4TjZ2V1hKUjU0V3pxMzI1dkNj?=
 =?utf-8?B?b1hQNmNMeSs0TmkxZ0pPMHBCUnI0ZU9scVdTTk5vakpvQnY4Q0RkT3lGYUtR?=
 =?utf-8?B?SVlJTzRheWN0TWk0RnJ0Q0lEemZjRVhWbWEyKzZrWm9DR2NJQ1NlLzl4cWdD?=
 =?utf-8?B?VGtMa0k2bUZUU0FIeGhGRXVmMVZNWXdkeHlBMFJ2dnlUSkRtcXg3ckhmOVlT?=
 =?utf-8?B?OHRaUXpYZjJ2UFNIbWFpTmh5aGNJUlNrUVhyMUVnem9wTDVYL2tXSlp6NU5r?=
 =?utf-8?B?eCt2Z012cmhLZFlwU0djeTJmYUFHemJTbHJXOFo2dExsb3hTVDg3TVQ0aWp2?=
 =?utf-8?Q?bxr+5KE5558sYlbXaN4+j5CJD9/F/cTiblQWF53?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cba97ff-4811-4b93-d891-08d9921cd43b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 09:51:16.5558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8rOB/WW55ejnmP0Do1y+qhyA48VdUv8DACZNCDG8JNDADUmfNDk30VJuQjLjBJO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDE4LCAyMDIxIDM6NTggUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVh
bkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGJwQGFsaWVuOC5kZQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggdGhlIGhhbmcgb2JzZXJ2ZWQgb24g
Q2Fycml6byBkdWUgdG8NCj4gVVZEIHN1c3BlbmQgZmFpbHVyZQ0KPiANCj4gDQo+IA0KPiBPbiAx
MC8xOC8yMDIxIDE6MDQgUE0sIEV2YW4gUXVhbiB3cm90ZToNCj4gPiBJdCdzIGNvbmZpcm1lZCB0
aGF0IG9uIHNvbWUgQVBVcyB0aGUgaW50ZXJhY3Rpb24gd2l0aCBTTVUoYWJvdXQgRFBNDQo+ID4g
ZGlzYWJsZW1lbnQpIHdpbGwgcG93ZXIgb2ZmIHRoZSBVVkQuIFRoYXQgd2lsbCBtYWtlIHRoZSBz
dWNjZWVkaW5nDQo+ID4gaW50ZXJhY3Rpb25zIHdpdGggVVZEIG9uIHRoZSBzdXNwZW5kIHBhdGgg
aW1wb3NzaWJsZS4gQW5kIHRoZSBzeXN0ZW0NCj4gPiB3aWxsIGhhbmcgZHVlIHRvIHRoYXQuIFRv
IHdvcmthcm91bmQgdGhlIGlzc3VlLCB3ZSB3aWxsIHNraXAgdGhlDQo+ID4gVVZEKG9yIFZDRSkg
cG93ZXIgb2ZmIGR1cmluZyBpbnRlcmFjdGlvbiB3aXRoIFNNVSBmb3Igc3VzcGVuZCBzY2VuYXJp
by4NCj4gPg0KPiANCj4gVGhlIG9yaWdpbmFsIGlzc3VlIHJlcG9ydGVkIGJ5IEJvcmlzIGlzIHJl
bGF0ZWQgdG8gc3l0ZW0gcmVib290IGFuZCBod19maW5pDQo+IGNhbGxzIChTTVUgaXMgaHdfZmlu
aSBiZWZvcmUgVVZEL1ZDRSkuIEJvcmlzIGFsc28gbWVudGlvbmVkIHRoYXQgaXQgZ290DQo+IHNv
bHZlZCBieSByZXZlcnRpbmcgdGhlIGRpc2FibGUgRFBNIGNhbGxzIGR1cmluZyBod19maW5pLiBT
bywgSSdtIHN0aWxsIG5vdCBzdXJlDQo+IGhvdyB0aGlzIGlzIHJlbGF0ZWQgdG8gc3VzcGVuZCBw
YXRoLg0KW1F1YW4sIEV2YW5dIGh3X2ZpbmkoKSB3YXMgbm90IG9uIHRoZSBwYXRoIG9mIHN5c3Rl
bSByZWJvb3QgYXMgSSBjb25maXJtZWQuIEl0J3MgZGlmZmVyZW50IGZyb20gdGhlIGlzc3VlIEFu
ZHJleSBmb3VuZChkdXJpbmcgZHJpdmVyIHVubG9hZCkuDQpUaGUgY2FsbCBmbG93IGZvciBzeXN0
ZW0gcmVib290IGlzOiBhbWRncHVfcGNpX3NodXRkb3duKCkgLT4gYW1kZ3B1X2RldmljZV9pcF9z
dXNwZW5kKCkgLT4gLi4uDQoNCkJSDQpFdmFuDQo+IA0KPiBUaGFua3MsDQo+IExpam8NCj4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCj4gPiBDaGFu
Z2UtSWQ6IEk3ODA0ZDM4MzVhYWRiYzdjZjRiNjg2ZGE0OTk0ZTgzMzMzNDYxNzQ4DQo+ID4gLS0t
DQo+ID4gICAuLi4vcG93ZXJwbGF5L2h3bWdyL3NtdTdfY2xvY2twb3dlcmdhdGluZy5jICAgfCAy
MA0KPiArKysrKysrKysrKysrKysrKy0tDQo+ID4gICAuLi4vZHJtL2FtZC9wbS9wb3dlcnBsYXkv
aHdtZ3Ivc211OF9od21nci5jICAgfCAxNg0KPiArKysrKysrKysrKysrLS0NCj4gPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2t2X2RwbS5jICAgICB8ICA0ICsrLS0NCj4gPiAg
IDMgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3
bWdyL3NtdTdfY2xvY2twb3dlcmdhdGluZy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3Bvd2VycGxheS9od21nci9zbXU3X2Nsb2NrcG93ZXJnYXRpbmcuYw0KPiA+IGluZGV4IGYyYmRh
M2JjYmJkZS4uZDJjNmZlOGZlNDczIDEwMDY0NA0KPiA+IC0tLQ0KPiBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTdfY2xvY2twb3dlcmdhdGluZy5jDQo+ID4gKysr
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211N19jbG9ja3Bv
d2VyZ2F0aW5nLmMNCj4gPiBAQCAtNTcsNyArNTcsMTcgQEAgc3RhdGljIGludCBzbXU3X3VwZGF0
ZV92Y2VfZHBtKHN0cnVjdCBwcF9od21ncg0KPiA+ICpod21nciwgYm9vbCBiZ2F0ZSkNCj4gPg0K
PiA+ICAgaW50IHNtdTdfcG93ZXJkb3duX3V2ZChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQ0KPiA+
ICAgew0KPiA+IC0JaWYgKHBobV9jZl93YW50X3V2ZF9wb3dlcl9nYXRpbmcoaHdtZ3IpKQ0KPiA+
ICsJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilo
d21nci0NCj4gPmFkZXY7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIEZ1cnRoZXIgaW5hY3Rp
b25zIHdpdGggVVZEIGFyZSBzdGlsbCBuZWVkZWQgb24gdGhlIHN1c3BlbmQgcGF0aC4NCj4gVGh1
cw0KPiA+ICsJICogdGhlIHBvd2VyIG9mZiBmb3IgVVZEIGhlcmUgc2hvdWxkIGJlIGF2b2lkZWQu
DQo+ID4gKwkgKg0KPiA+ICsJICogVE9ETzogYSBiZXR0ZXIgc29sdXRpb24gaXMgdG8gcmVvcmcg
dGhlIGFjdGlvbiBjaGFpbnMgcGVyZm9ybWVkIG9uDQo+IHN1c3BlbmQNCj4gPiArCSAqIGFuZCBt
YWtlIHRoZSBhY3Rpb24gaGVyZSB0aGUgbGFzdCBvbmUuIEJ1dCB0aGF0IHdpbGwgaW52b2x2ZSBh
IGxvdA0KPiBhbmQgbmVlZHMNCj4gPiArCSAqIE1NIHRlYW0ncyBoZWxwLg0KPiA+ICsJICovDQo+
ID4gKwlpZiAocGhtX2NmX3dhbnRfdXZkX3Bvd2VyX2dhdGluZyhod21ncikgJiYgIWFkZXYtDQo+
ID5pbl9zdXNwZW5kKQ0KPiA+ICAgCQlyZXR1cm4gc211bV9zZW5kX21zZ190b19zbWMoaHdtZ3Is
DQo+ID4gICAJCQkJUFBTTUNfTVNHX1VWRFBvd2VyT0ZGLA0KPiA+ICAgCQkJCU5VTEwpOw0KPiA+
IEBAIC04Miw3ICs5MiwxMyBAQCBzdGF0aWMgaW50IHNtdTdfcG93ZXJ1cF91dmQoc3RydWN0IHBw
X2h3bWdyDQo+ICpod21ncikNCj4gPg0KPiA+ICAgc3RhdGljIGludCBzbXU3X3Bvd2VyZG93bl92
Y2Uoc3RydWN0IHBwX2h3bWdyICpod21ncikNCj4gPiAgIHsNCj4gPiAtCWlmIChwaG1fY2Zfd2Fu
dF92Y2VfcG93ZXJfZ2F0aW5nKGh3bWdyKSkNCj4gPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaHdtZ3ItDQo+ID5hZGV2Ow0KPiA+ICsNCj4g
PiArCS8qDQo+ID4gKwkgKiBGdXJ0aGVyIGluYWN0aW9ucyB3aXRoIFZDRSBhcmUgc3RpbGwgbmVl
ZGVkIG9uIHRoZSBzdXNwZW5kIHBhdGguDQo+IFRodXMNCj4gPiArCSAqIHRoZSBwb3dlciBvZmYg
Zm9yIFZDRSBoZXJlIHNob3VsZCBiZSBhdm9pZGVkLg0KPiA+ICsJICovDQo+ID4gKwlpZiAocGht
X2NmX3dhbnRfdmNlX3Bvd2VyX2dhdGluZyhod21ncikgJiYgIWFkZXYtPmluX3N1c3BlbmQpDQo+
ID4gICAJCXJldHVybiBzbXVtX3NlbmRfbXNnX3RvX3NtYyhod21nciwNCj4gPiAgIAkJCQlQUFNN
Q19NU0dfVkNFUG93ZXJPRkYsDQo+ID4gICAJCQkJTlVMTCk7DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211OF9od21nci5jDQo+ID4g
aW5kZXggYjk0YTc3ZTRlNzE0Li4wOWU3NTU5ODBjNDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211OF9od21nci5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211OF9od21nci5jDQo+ID4g
QEAgLTEyNDcsNyArMTI0NywxMyBAQCBzdGF0aWMgaW50IHNtdThfZHBtX2ZvcmNlX2RwbV9sZXZl
bChzdHJ1Y3QNCj4gPiBwcF9od21nciAqaHdtZ3IsDQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgc211
OF9kcG1fcG93ZXJkb3duX3V2ZChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQ0KPiA+ICAgew0KPiA+
IC0JaWYgKFBQX0NBUChQSE1fUGxhdGZvcm1DYXBzX1VWRFBvd2VyR2F0aW5nKSkNCj4gPiArCXN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaHdtZ3It
DQo+ID5hZGV2Ow0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBGdXJ0aGVyIGluYWN0aW9ucyB3
aXRoIFVWRCBhcmUgc3RpbGwgbmVlZGVkIG9uIHRoZSBzdXNwZW5kIHBhdGguDQo+IFRodXMNCj4g
PiArCSAqIHRoZSBwb3dlciBvZmYgZm9yIFVWRCBoZXJlIHNob3VsZCBiZSBhdm9pZGVkLg0KPiA+
ICsJICovDQo+ID4gKwlpZiAoUFBfQ0FQKFBITV9QbGF0Zm9ybUNhcHNfVVZEUG93ZXJHYXRpbmcp
ICYmICFhZGV2LQ0KPiA+aW5fc3VzcGVuZCkNCj4gPiAgIAkJcmV0dXJuIHNtdW1fc2VuZF9tc2df
dG9fc21jKGh3bWdyLA0KPiBQUFNNQ19NU0dfVVZEUG93ZXJPRkYsIE5VTEwpOw0KPiA+ICAgCXJl
dHVybiAwOw0KPiA+ICAgfQ0KPiA+IEBAIC0xMzAxLDcgKzEzMDcsMTMgQEAgc3RhdGljIGludCAg
c211OF9kcG1fdXBkYXRlX3ZjZV9kcG0oc3RydWN0DQo+ID4gcHBfaHdtZ3IgKmh3bWdyKQ0KPiA+
DQo+ID4gICBzdGF0aWMgaW50IHNtdThfZHBtX3Bvd2VyZG93bl92Y2Uoc3RydWN0IHBwX2h3bWdy
ICpod21ncikNCj4gPiAgIHsNCj4gPiAtCWlmIChQUF9DQVAoUEhNX1BsYXRmb3JtQ2Fwc19WQ0VQ
b3dlckdhdGluZykpDQo+ID4gKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqKWh3bWdyLQ0KPiA+YWRldjsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJ
ICogRnVydGhlciBpbmFjdGlvbnMgd2l0aCBWQ0UgYXJlIHN0aWxsIG5lZWRlZCBvbiB0aGUgc3Vz
cGVuZCBwYXRoLg0KPiBUaHVzDQo+ID4gKwkgKiB0aGUgcG93ZXIgb2ZmIGZvciBWQ0UgaGVyZSBz
aG91bGQgYmUgYXZvaWRlZC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKFBQX0NBUChQSE1fUGxhdGZv
cm1DYXBzX1ZDRVBvd2VyR2F0aW5nKSAmJiAhYWRldi0NCj4gPmluX3N1c3BlbmQpDQo+ID4gICAJ
CXJldHVybiBzbXVtX3NlbmRfbXNnX3RvX3NtYyhod21nciwNCj4gPiAgIAkJCQkJICAgIFBQU01D
X01TR19WQ0VQb3dlck9GRiwNCj4gPiAgIAkJCQkJICAgIE5VTEwpOw0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9rdl9kcG0uYw0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkva3ZfZHBtLmMNCj4gPiBpbmRleCBiY2FlNDJjZWYz
NzQuLjRlOWM5ZGEyNTVhNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3Bvd2VycGxheS9rdl9kcG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93
ZXJwbGF5L2t2X2RwbS5jDQo+ID4gQEAgLTE2ODMsNyArMTY4Myw3IEBAIHN0YXRpYyB2b2lkIGt2
X2RwbV9wb3dlcmdhdGVfdXZkKHZvaWQgKmhhbmRsZSwNCj4gYm9vbCBnYXRlKQ0KPiA+ICAgCQlh
bWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LA0KPiBBTURfSVBfQkxP
Q0tfVFlQRV9VVkQsDQo+ID4gICAJCQkJCQkgICAgICAgQU1EX1BHX1NUQVRFX0dBVEUpOw0KPiA+
ICAgCQlrdl91cGRhdGVfdXZkX2RwbShhZGV2LCBnYXRlKTsNCj4gPiAtCQlpZiAocGktPmNhcHNf
dXZkX3BnKQ0KPiA+ICsJCWlmIChwaS0+Y2Fwc191dmRfcGcgJiYgIWFkZXYtPmluX3N1c3BlbmQp
DQo+ID4gICAJCQkvKiBwb3dlciBvZmYgdGhlIFVWRCBibG9jayAqLw0KPiA+ICAgCQkJYW1kZ3B1
X2t2X25vdGlmeV9tZXNzYWdlX3RvX3NtdShhZGV2LA0KPiBQUFNNQ19NU0dfVVZEUG93ZXJPRkYp
Ow0KPiA+ICAgCX0gZWxzZSB7DQo+ID4gQEAgLTE3MTAsNyArMTcxMCw3IEBAIHN0YXRpYyB2b2lk
IGt2X2RwbV9wb3dlcmdhdGVfdmNlKHZvaWQgKmhhbmRsZSwNCj4gYm9vbCBnYXRlKQ0KPiA+ICAg
CQlhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LA0KPiBBTURfSVBf
QkxPQ0tfVFlQRV9WQ0UsDQo+ID4gICAJCQkJCQkgICAgICAgQU1EX1BHX1NUQVRFX0dBVEUpOw0K
PiA+ICAgCQlrdl9lbmFibGVfdmNlX2RwbShhZGV2LCBmYWxzZSk7DQo+ID4gLQkJaWYgKHBpLT5j
YXBzX3ZjZV9wZykgLyogcG93ZXIgb2ZmIHRoZSBWQ0UgYmxvY2sgKi8NCj4gPiArCQlpZiAocGkt
PmNhcHNfdmNlX3BnICYmICFhZGV2LT5pbl9zdXNwZW5kKSAvKiBwb3dlciBvZmYgdGhlDQo+IFZD
RQ0KPiA+ICtibG9jayAqLw0KPiA+ICAgCQkJYW1kZ3B1X2t2X25vdGlmeV9tZXNzYWdlX3RvX3Nt
dShhZGV2LA0KPiBQUFNNQ19NU0dfVkNFUG93ZXJPRkYpOw0KPiA+ICAgCX0gZWxzZSB7DQo+ID4g
ICAJCWlmIChwaS0+Y2Fwc192Y2VfcGcpIC8qIHBvd2VyIG9uIHRoZSBWQ0UgYmxvY2sgKi8NCj4g
Pg0K
