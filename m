Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1394EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 02:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2912710E052;
	Tue, 18 Jul 2023 02:16:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA6610E052
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 02:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxnhkECbRSL1eLRrh9dsY3Pvsw2pUQp9XCJU1VmzZy0Ku+SZ/79qk+fo4046nXFOcGyz9jchOHVNjcHY443d/GcqbAw7bfYIv/3UGIPzv1LTK668UXYipQJjEF7mCoM/n4Xyd3IyB5nMVo6Q7CTDWWLl16P80btmwKMcnYGx8Fvw8FEr+zlZ89zDxLhCKtt/k//U3n9IeZe6zBV+IzW27MawQH2AhV2aO3gZgg7abw3htqd9KP3rChEaaPQcK+S3sx+PJHvXk47dMfypA78wIL0MNMG700Af1ijATiv8rtMETnWWIvl8vLf5ONHWj430b5a+nNTRGJSDWCxH5GtYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvHdZWFThjMAgVmlY7UDqXNblxeisQH+wztTvN+jCSg=;
 b=WeE8SpTkFuMc5K+5vdEO5mc68i+XJh7eIsJG2QXDF1dKRlvN5+hoYUcfym1l3z3SM9UMCjFChUkibto/1yM6g9TtZ8eLMMIOrJyLwLZo6727bGtJaRnW//OG6QKW0S3P0qQHXmrFDLG2+ILnK1LvcdvUcO1ut5n5GYU2x5ApTidwqhFGPh63TP5o4EG7WCO7Q1agJHi2wucUMV/r4Qwd234GbeykplpPudl6KuO+7MDbwE73ijmXsbrYY9/Pw316UjtB5+W0lLVZNzwOVvsv0xwz2NsF2KhlIE/sjqU+9e+cmV2pf2CJKhjV97Bo8RxU3H/bGlprWkFGBOYQaOyDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvHdZWFThjMAgVmlY7UDqXNblxeisQH+wztTvN+jCSg=;
 b=Ip7lDY3e0r+2zQpumBhPBkxs/U8GOPoTsiylSYUZWudHzsxuGgOncYoeDBV/sHd4p+Bxe9RBREtpeVr93I06P695CA3KXPam0+cXO69OxtkPKTcF47GmwBJPOcnvpfdwhlWVDiOpAoKELzypN/s5+xgILaXxDgH+qhsf81TLT1E=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 02:16:12 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 02:16:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: use a macro to define no xcp partition
 case
Thread-Topic: [PATCH 4/4] drm/amdgpu: use a macro to define no xcp partition
 case
Thread-Index: AQHZuFYmmkkIiWsZek6zBhBZoqcQWa++DZmAgAC8sPA=
Date: Tue, 18 Jul 2023 02:16:12 +0000
Message-ID: <DM5PR12MB246900DA95D6365824B536A5F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230717022619.3833601-1-guchun.chen@amd.com>
 <20230717022619.3833601-4-guchun.chen@amd.com>
 <96a59b0d-89aa-7cea-e14c-9a9188c64020@amd.com>
In-Reply-To: <96a59b0d-89aa-7cea-e14c-9a9188c64020@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9fb11c31-bbad-4d93-9c63-b280543fa442;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-18T02:15:30Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM4PR12MB5232:EE_
x-ms-office365-filtering-correlation-id: b600a3ff-0c00-4dcc-44c3-08db8734f53e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZqv1yCNcvrzo09AAlBvEtfsShdQAnfasr3LS8FyHDMqFxdH73sNdo2qMo9+xp8AUD7SiY5IIni9s4jwwKuuCvlejzHi5YSy/u2MQ/HbCZtvd/6lfq2ZbI6m1q8ccMpwg8tkxROjlCvkxQVqxV2E3DvCqVv+4FI5nzmzKOwAXlKRd9mZ/NMAux6cdzZEGD2VK4QnhsKLJygMGZfOOe9qhEuGBnvF5TksPLyIFWqj44gdIRBqEyWM3ktnuTpbDDuw7cnW320XWjXBGOsi98FAiI41Oea7nuxEVRqpz0ZAD8A6gthHyhny5vXB48we/G6KLUac2MLg20ylndK3LTyyZjhljEC9LayD1cJPQtXRT1nY4E0DO6GCYurwOcPVfzaedBtb0RP9jp4TK/GCPODbOKpiLNrkDZtWQK0NvRf7vqM6pApBEADJKUS7bcCObphkhe2ww5M8s/3O9xhykctYkb+fPxV6rjB29BuxYaA5IezvDvuestnkJyGmqICVrCGl1VRzQg/r9ASbiXVK5HezT+hwomdJDVhGMw64n6R8rE4ZJ2Bn0HeREdk4GE2b0w2aqj+BqhIykf9P/jqV9+0Oee6LcBNfJyTak28uS26Z53vLTRv7D2QU8bpr6eAtIevz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(2906002)(5660300002)(7696005)(110136005)(478600001)(71200400001)(6636002)(8676002)(41300700001)(316002)(76116006)(66446008)(66946007)(64756008)(66556008)(66476007)(83380400001)(66574015)(122000001)(921005)(8936002)(9686003)(38100700002)(55016003)(33656002)(86362001)(53546011)(26005)(186003)(52536014)(38070700005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWprenZLUk1NMFUxK29FYlN3RXVnbkpaUWNZT09uMFg1MjB6a2RDWDkrMU41?=
 =?utf-8?B?VExUT2pNQXNaMnZLVTZMREhOY3FFNE9kOUVJUHlMaEFZeFNid2R6ekhIQ25R?=
 =?utf-8?B?d2FUK1BuWFBlR3dKZGxPVXEyQ3BKYzR5SHVlc2RoTEZyWDB5TjRVVTlUSnBM?=
 =?utf-8?B?U1BxcDFLNzNOeFlWMmxCaVBDeFcvL1NuWXZjZldlU0VVbmo0cisrV21EWTAv?=
 =?utf-8?B?aTFNNW1yOEg1ZFZjemRwRFlWRVh2ckR6dVB2QUNuM3huZjVrTWdOTE5VaW9x?=
 =?utf-8?B?Nlh2MXpJQ2I1ZnVrOWlPajNRMGp2QTFEcm9hWHMxQ05TbWtDeVFpWThybUw4?=
 =?utf-8?B?TVI5cXEyRkhaQ2pMV2F6em5vbzFEWmJodHJsODRxcXFwdlVrc0FnTTFZZTJR?=
 =?utf-8?B?RThDTXIwUU85WTZwVGFkbUtvUmtPNC9iVU4xRVhlckhxd3pqczZYaVBvRCsv?=
 =?utf-8?B?aUNIeStLSW1oazQxZ3M2OU5kcmxodUtuU1VqNzgvMVpWN0cralZjME9ZTXhP?=
 =?utf-8?B?ZzAwT1B5ZmVjVjVtcmlYeExrZkREazhSRFoxV0JEc005NldYT3NNTng1anhq?=
 =?utf-8?B?Vm5MbjFWdkRrNWppU0Q4bGdBSkQyb25JcWkwY0pVb0pkYmNlaFZVWVE2RXNo?=
 =?utf-8?B?UFBrVVpyOUN2MkwxZWhHWGxxU1ozNzBUZ2czNWN5R2t5U0pRTzk1a2w1V1NQ?=
 =?utf-8?B?WGQ2OWpQWFVFRjJJUVdsUzQxay9IZXBIZFpkRHZpN3JjQ3ZiblJocTZPVUFJ?=
 =?utf-8?B?UEtWcGZ4RGtTL3ZVOTVDSnVIUUlVNGdBMVdvNG53bHZHUWlkY0xOODk4bDlS?=
 =?utf-8?B?UURNaXdZbWtyd1FYdGdKZnRRdnQzMGF5S0dhSVk2ZDFuaU9FWjZPa3ZwRDJt?=
 =?utf-8?B?ZHRmWTBDOFBtUjBCcFJrc0FuN0trclV4SUhZd0JLdFZpZVJhRkswa0V2aWt0?=
 =?utf-8?B?Y2tlY2hXQXF3UU11Qk5sMjdCbExhNXRQWjBIb0NVaC9KbEdHYXhhQVRDb3Jv?=
 =?utf-8?B?bnNHcFpkcnlxQmlhcjdVWmtZTUo5YXd6ZXJ0QktXbkRWMjhtOWgzVGNLRm40?=
 =?utf-8?B?SUwrams4REVJOGNOQ0RNTUlJa2luWkZLOGI2RVBDcWZSNnJKcmZLWUdHdWQ3?=
 =?utf-8?B?Z3ozOUJqd1VDaU40OFJDMTByd2JOVHVPVVUrUUcwbjY4WTN1RWd5MG9lSkkr?=
 =?utf-8?B?Y2t0bDF5YVRuVDllV3VYU1YvSm5sNERSamR5Y2ZjYTE4bG8vZk5vVk5lUmFY?=
 =?utf-8?B?VlZ6a2ZEZWkvalo3RFFORENoQlRHdy90Nkh6VVlJSzBockVEd2JaL216ZTRi?=
 =?utf-8?B?WUw3RmtFTGZ5Mjh3K1NaT0owTHdMWmRTbmlrRGVLVU16RW9NOTZWa29oQWJT?=
 =?utf-8?B?d2I3cStXc2NpOURuNXFZTXVBbUJ2bG1YVG9CaUZ1WWtNV2FweTB3UXdLOVZt?=
 =?utf-8?B?S29TWmQwK0JvU25IWnNXTFRrNzNoRWozM0wwend2a2ZYUlRBOGdWcXlvZW14?=
 =?utf-8?B?elpoOWFNM1Bod0VranNhck9icUN3c0hPaXY1MytrQTRtaG5uY3l1S1RZNFkw?=
 =?utf-8?B?U1RGY2pxaW5GWVpzeFhoR2RqUnZJdHFMMnk2Qm9JR2pGbDBLYitYdmRJZWVD?=
 =?utf-8?B?b1oxTVFHQ0tnQ3Z4NC95ZEtLakVqMEtFWHpxQlVRTkRxbitiMTRMQ1dhN0lk?=
 =?utf-8?B?cVpjb21KNHBsZWRxaW5xRGtMRUZUMmQ4K2U2eDF3S296MDhlaGJkWVhyU0FI?=
 =?utf-8?B?OXdxWW10emJheWNjZTVYaXFDMWZaNFVXY2wwbm5qRk5xMXYydWhWS09LME03?=
 =?utf-8?B?cVVuZEpndksvUjFxam5LaDVSckREYTFVejZZZGNmTmsyeDUrUG1UdXM1QlFD?=
 =?utf-8?B?aXNubngwSDQ2eVIxRDNMc205aVJpRG0wbTJSWHBuNDBoeHpFZEEzMXh3TWYz?=
 =?utf-8?B?WnNhaWNKTFVHc0xuVVNhMlUxUERyMkxOTmFPd3RMcEdoZ2dlNlVNKzhYcS9U?=
 =?utf-8?B?NzZ2ZEMxUnR2RGJMb05Pb2xsUExFNkROaWdJRVRWN25ibzFqZlA5SWM2dDR3?=
 =?utf-8?B?SXJiZitKbTl4djVYbWpZYThKZEZPN2NObVFmOENNNlBmOFVFOGcxZWIxUExy?=
 =?utf-8?Q?B+Gc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b600a3ff-0c00-4dcc-44c3-08db8734f53e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 02:16:12.5155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqS5sQf04RSNxbl23njUq0QoFHxVgJnMCKg6znI/ctHLqq+he1oteTZbyMCzBZ6C72CjR69C0YN1vokVq1WP+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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

W1B1YmxpY10NCg0KVGhhbmsgeW91IGZvciByZXZpZXcsIEZlbGl4Lg0KDQpIaSBDaHJpc3RpYW4s
DQoNCkkgZm9yZ290IHRvIGFkZCB5b3VyIFJCIGluIHBhdGNoIDIvcGF0Y2gzIHdoZW4gcG9zdGlu
ZyB0aGlzIHNlcmllcyBmb3IgcmV2aWV3LiBJIHdpbGwgYWRkIGl0IGJhY2sgd2hlbiBwdXNoaW5n
LiBIb3BlIGl0J3MgZmluZSB0byB5b3UuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAxNywgMjAyMyAxMDo1OCBQTQ0KPiBU
bzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBaaGFuZywgSGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgS29l
bmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFlhbmcsIFBoaWxp
cCA8UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzRdIGRybS9h
bWRncHU6IHVzZSBhIG1hY3JvIHRvIGRlZmluZSBubyB4Y3ANCj4gcGFydGl0aW9uIGNhc2UNCj4N
Cj4gT24gMjAyMy0wNy0xNiAyMjoyNiwgR3VjaHVuIENoZW4gd3JvdGU6DQo+ID4gfjAgYXMgbm8g
eGNwIHBhcnRpdGlvbiBpcyB1c2VkIGluIHNldmVyYWwgcGxhY2VzLCBzbyBpbXByb3ZlIGl0cw0K
PiA+IGRlZmluaXRpb24gYnkgYSBtYWNybyBmb3IgY29kZSBjb25zaXN0ZW5jeS4NCj4gPg0KPiA+
IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0K
Pg0KPiBUaGUgc2VyaWVzIGlzDQo+DQo+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4NCj4NCj4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDMgKystDQo+ID4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGNwLmMgICAgICAgICAgfCA0ICsrLS0NCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Y3AuaCAgICAgICAgICB8IDIgKysN
Cj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FxdWFfdmFuamFyYW0uYyAgICAgICB8
IDQgKystLQ0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPiBpbmRleCBhN2YzMTRkZGQxNzMuLmQzNGMzZWY4ZjNl
ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dwdXZtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2dwdXZtLmMNCj4gPiBAQCAtMTcwOSw3ICsxNzA5LDggQEAgaW50DQo+IGFtZGdwdV9h
bWRrZmRfZ3B1dm1fYWxsb2NfbWVtb3J5X29mX2dwdSgNCj4gPiAgICAgICAgICAgICAgICAgICAg
IGFsbG9jX2ZsYWdzIHw9IChmbGFncyAmDQo+IEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX1BVQkxJ
QykgPw0KPiA+ICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VT
U19SRVFVSVJFRCA6IDA7DQo+ID4gICAgICAgICAgICAgfQ0KPiA+IC0gICAgICAgICAgIHhjcF9p
ZCA9IGZwcml2LT54Y3BfaWQgPT0gfjAgPyAwIDogZnByaXYtPnhjcF9pZDsNCj4gPiArICAgICAg
ICAgICB4Y3BfaWQgPSBmcHJpdi0+eGNwX2lkID09IEFNREdQVV9YQ1BfTk9fUEFSVElUSU9OID8N
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwIDogZnByaXYtPnhjcF9p
ZDsNCj4gPiAgICAgfSBlbHNlIGlmIChmbGFncyAmIEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX0dU
VCkgew0KPiA+ICAgICAgICAgICAgIGRvbWFpbiA9IGFsbG9jX2RvbWFpbiA9IEFNREdQVV9HRU1f
RE9NQUlOX0dUVDsNCj4gPiAgICAgICAgICAgICBhbGxvY19mbGFncyA9IDA7DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Y3AuYw0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hjcC5jDQo+ID4gaW5kZXggZDE3NWU4NjJm
MjIyLi45YzljY2ExMjk0OTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3hjcC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3hjcC5jDQo+ID4gQEAgLTM2Myw3ICszNjMsNyBAQCBpbnQgYW1kZ3B1X3hjcF9vcGVu
X2RldmljZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgaWYgKCFhZGV2
LT54Y3BfbWdyKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+DQo+ID4gLSAgIGZwcml2
LT54Y3BfaWQgPSB+MDsNCj4gPiArICAgZnByaXYtPnhjcF9pZCA9IEFNREdQVV9YQ1BfTk9fUEFS
VElUSU9OOw0KPiA+ICAgICBmb3IgKGkgPSAwOyBpIDwgTUFYX1hDUDsgKytpKSB7DQo+ID4gICAg
ICAgICAgICAgaWYgKCFhZGV2LT54Y3BfbWdyLT54Y3BbaV0uZGRldikNCj4gPiAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiA+IEBAIC0zODEsNyArMzgxLDcgQEAgaW50IGFtZGdwdV94Y3Bf
b3Blbl9kZXZpY2Uoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAg
ICAgfQ0KPiA+ICAgICB9DQo+ID4NCj4gPiAtICAgZnByaXYtPnZtLm1lbV9pZCA9IGZwcml2LT54
Y3BfaWQgPT0gfjAgPyAtMSA6DQo+ID4gKyAgIGZwcml2LT52bS5tZW1faWQgPSBmcHJpdi0+eGNw
X2lkID09IEFNREdQVV9YQ1BfTk9fUEFSVElUSU9OID8NCj4gLTEgOg0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhZGV2LT54Y3BfbWdyLT54Y3BbZnByaXYtPnhjcF9pZF0ubWVtX2lk
Ow0KPiA+ICAgICByZXR1cm4gMDsNCj4gPiAgIH0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hjcC5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfeGNwLmgNCj4gPiBpbmRleCAwZjgwMjZkNjRlYTUuLjlhMTAzNmFlZWMy
YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGNw
LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGNwLmgNCj4g
PiBAQCAtMzcsNiArMzcsOCBAQA0KPiA+ICAgI2RlZmluZSBBTURHUFVfWENQX0ZMX05PTkUgMA0K
PiA+ICAgI2RlZmluZSBBTURHUFVfWENQX0ZMX0xPQ0tFRCAoMSA8PCAwKQ0KPiA+DQo+ID4gKyNk
ZWZpbmUgQU1ER1BVX1hDUF9OT19QQVJUSVRJT04gKH4wKQ0KPiA+ICsNCj4gPiAgIHN0cnVjdCBh
bWRncHVfZnByaXY7DQo+ID4NCj4gPiAgIGVudW0gQU1ER1BVX1hDUF9JUF9CTE9DSyB7DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FxdWFfdmFuamFyYW0uYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXF1YV92YW5qYXJhbS5jDQo+ID4gaW5k
ZXggMTY0NzFiODFhMWY1Li43MmI2MjlhNzhjNjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYXF1YV92YW5qYXJhbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYXF1YV92YW5qYXJhbS5jDQo+ID4gQEAgLTY4LDcgKzY4LDcgQEAgc3Rh
dGljIHZvaWQgYXF1YV92YW5qYXJhbV9zZXRfeGNwX2lkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPiA+ICAgICBlbnVtIEFNREdQVV9YQ1BfSVBfQkxPQ0sgaXBfYmxrOw0KPiA+ICAg
ICB1aW50MzJfdCBpbnN0X21hc2s7DQo+ID4NCj4gPiAtICAgcmluZy0+eGNwX2lkID0gfjA7DQo+
ID4gKyAgIHJpbmctPnhjcF9pZCA9IEFNREdQVV9YQ1BfTk9fUEFSVElUSU9OOw0KPiA+ICAgICBp
ZiAoYWRldi0+eGNwX21nci0+bW9kZSA9PSBBTURHUFVfWENQX01PREVfTk9ORSkNCj4gPiAgICAg
ICAgICAgICByZXR1cm47DQo+ID4NCj4gPiBAQCAtMTc3LDcgKzE3Nyw3IEBAIHN0YXRpYyBpbnQg
YXF1YV92YW5qYXJhbV9zZWxlY3Rfc2NoZWRzKA0KPiA+ICAgICB1MzIgc2VsX3hjcF9pZDsNCj4g
PiAgICAgaW50IGk7DQo+ID4NCj4gPiAtICAgaWYgKGZwcml2LT54Y3BfaWQgPT0gfjApIHsNCj4g
PiArICAgaWYgKGZwcml2LT54Y3BfaWQgPT0gQU1ER1BVX1hDUF9OT19QQVJUSVRJT04pIHsNCj4g
PiAgICAgICAgICAgICB1MzIgbGVhc3RfcmVmX2NudCA9IH4wOw0KPiA+DQo+ID4gICAgICAgICAg
ICAgZnByaXYtPnhjcF9pZCA9IDA7DQo=
