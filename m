Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDF1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 11:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E576EA12;
	Wed,  1 Dec 2021 11:37:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E316EA12
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 11:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efdyt+M7/ho/OWIJnfANe8T6GiIUSwQhxlduZhWZRr3aFGAQZhOsX9CN6yfD1cL1i1HtEYtenGf6WDy0inT+A8VCmhWEf3KBSHvUV0NV3/Pv4cuoN/qedE72mnejQvrKIk4SYtnud8TA/wNnjfR1RKiVq8Jt5eNB73IO9OwHR69BL0QeETfQGXkKfojP59SNNvhWX1KWxcz0CyU4bahrLZzlpQn1lRWsZ29wZxOljRkH4Cfn/XyHYKsxjDgbyn3Pqj0fyuGD0qbY6BkixfN6Y6yEi1kyJZqKr8tv1NzZUks83D6bi+Zrh1X7nklzM+b38SYrdUe9ueB8O1BIBzuqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNZDkZ8wTHRYTetHsQLDqNboMRvzS/+kpCTbp3Wm2Fo=;
 b=G3DVc9Hg/NW/QYzWoIBJYF5a59JpotytmDzWMYqaJnueSf+7J6OiVYFCx2+mwCU/KmOfM+4VMAkHmmPqbpyfXpxqoG77xYZEIt7QheDwG4ZgnDbUE1iIKR6Ayvi0cooOWUXBzrpT0AC5O3fxY659T+0635kkcP+YjsKxJKN9AeCcAghhMjC7pfzHtQxpYJlWJVGF1jU/jAcuQrn3ON7DxQkmMYgB0W0hDYJk2wp6gVcHOVEBX27BGQ1j4C30yaZDC/SQS6xbeXnTaZM3WayW2SzNSDwVSNR7Jaffiqwd7OB48ozxv8geDeJbVg4rd6nb7emsAQazZhcpG7WixW016A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNZDkZ8wTHRYTetHsQLDqNboMRvzS/+kpCTbp3Wm2Fo=;
 b=0iQcEJFzjWbDk8TcDdPyZ81fVXkDrzkABkgPKuLNdWt393HyRCygM4S0DmRor2tW9KGls/8El58HR2l7CbAL+v/ZNkZLXiojzYr+fw5Gm4UVJf7x65DoJ5Ore1ww6fpgHqVYlXh8JRy4bWiGWXxuHRLgFmfRQqGBSenYE0juvEE=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Wed, 1 Dec 2021 11:37:25 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 11:37:25 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Topic: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Index: AQHX5pVcc3LghN55bkmOkF3w2Pkmd6wdXtgAgAATJuCAAALugIAABsDggAAEiwCAAAEbcA==
Date: Wed, 1 Dec 2021 11:37:24 +0000
Message-ID: <DM6PR12MB4250CB4C8DE2869BB8BD55D1FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
 <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
 <DM6PR12MB42505899AFB96290F516C21BFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <e3bdf34e-b18c-695b-fc58-73426760935b@amd.com>
In-Reply-To: <e3bdf34e-b18c-695b-fc58-73426760935b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-01T11:37:21Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=eb5bb3f2-7db1-460a-adf7-1ca3a197f4bf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-01T11:37:21Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 39a4df44-a6f2-430b-ac9f-2a16b2bc3a1a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c30889-c1ef-4d5b-83d5-08d9b4bef259
x-ms-traffictypediagnostic: DM5PR12MB1884:
x-microsoft-antispam-prvs: <DM5PR12MB18845E41E45DC11BEF12AE5BFB689@DM5PR12MB1884.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRgjDo7VjtGD71T7m0pimfVmdPQkUrCQ5ECuaQGNYg2MCTRsFxVAvhraBWT45GFSYGaSo6Z/RciPsGobdMjgwBVXrjHmIZv8bD8FsNZna1E34idhmBvvQdXvwAdEO9VYgl5b/P9flfdor9mt2QL2D6omw1yNp9SAq5CTLAnzYOZ7v0mjXp8dhAfxQY7mOZjgh0kfqyYfrxZm85/owH66PCMBcfJaXCFfn5snQSjyivJHlAezQGrHEg+eILTXb5npils1W41MnH/hR0io/URPX4H3++14o94WQRwGm3r7MCFkOYFgotVy03SeYn/AfllS7AOKZQIUSm9G1B2yUNKD5TS/zl82r/S5LU5zwIRalqSc7kvphjQ7sEd8co/IyRFCgpOyU9LC5N7rxhBpD41dWgusDDrZaeSdo5g1ioMSbQdmYDBKOBcoah3P07yxzWFRlLoiNqn3e6C1OL/O0XDd7QF7lFLvtQP9jDW5w6FL1swm+fCp+Za6Tib+n/D+hqBRx/5HT42/x6Px6g5lHDcy1yd/83i5kYu6KXjPfvEC5bhRdYxZe9PlFZf0KxlLcpXxmZySIVpYELZPJgiiCpvBg9Pp4eLyA3B7Y7cteViD+lIyWzfmcRHCoBZZ3G0M8daPmHD/jtSEJFS80IuwzzWzAybiKccpJ5p5aO3TGtAEDfaP4voOEHxgQim/V68oMN7TSOh50R6Qewu8KYWc79xe2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(316002)(54906003)(2906002)(76116006)(26005)(7696005)(8936002)(53546011)(508600001)(52536014)(9686003)(66446008)(110136005)(55016003)(4326008)(186003)(71200400001)(83380400001)(66556008)(38100700002)(64756008)(5660300002)(86362001)(122000001)(66476007)(33656002)(66574015)(66946007)(8676002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTJHd0NEbE9tTkF6cjVXWjFycnJUVjBSWERlQjkyK2xRZEc1Wkg4YXRQaVl4?=
 =?utf-8?B?bTdGd3BnRWpiQis0VlVENkNHT05GMnNlM0RnWGtyaHF1M3VlSXNWOHRLMkMw?=
 =?utf-8?B?MHBHNXVqd0UrWnBva0NPays5eWNzak5VemR0RDB1OWVFYWVPQUo1eVEwbmtI?=
 =?utf-8?B?SmUwdHVTYngxT3lMeTVjWnNrZlV1NnFLaHNTZ3ZmelZ2bG04MVIrem1GcFM4?=
 =?utf-8?B?L0ZMVjBTRUtiQmtvNzRVMHMrQ3BrNS9uKzMyZ3MvTEVSUzV5QlNEN0tRSzV2?=
 =?utf-8?B?eGVwcXBMekY4Q0thTFlUbWgweExLMEgvbVduV3V1K0V3SVVONm1lTG0yVDR5?=
 =?utf-8?B?RHZTOVNjRjkra2RBdFdncFl0UGFEb2FKY2tZa0M1YWFqc1VRNS8wTVZyUk9H?=
 =?utf-8?B?SlNQNUFGeHlCanp4b09WbmFxVmhIU0hsUEFMTzZuNTYwSFBGbXVjMXUvQ2ZZ?=
 =?utf-8?B?bitOUjAwVWhIN1U1M0JnSmNRL3BEK3EwaXdseFRBWk5kb1QwTWlpOVB3blZ6?=
 =?utf-8?B?aHlpb1ZlVVdjVDRPcWFQVlVBbUl5ZnkxTDJQY09VdkVTL2xLU0YrckMrTXpy?=
 =?utf-8?B?ZDhxc053cHNrcHNJdU0vSHZUaW5zNUQwZnlxb1VlSUozUEE3TDV5czJtK3RJ?=
 =?utf-8?B?YUtTQVhNVFJldk1HSzNkMzFqRWM2UUQ4TzcreVFIS3dYZU5ZeW83QWhtUHA2?=
 =?utf-8?B?QktkcEpuTVVrUmZ0eXNBOGF0bkcyMzVjck5FcXZSSTcrT0h3UkkwTFpIeXlv?=
 =?utf-8?B?enh2T0o3cnAvczZMVjFIVWNFM0N0SUxqYitpRGhnQWlJZk1EU2tjRENKSUVa?=
 =?utf-8?B?U2pDMkVxc1UzZ0hzVUkvK1BwS2pseHovMEk2N2tXQXVKbnRERUxzRFA2VDc2?=
 =?utf-8?B?eE1hZjdJWkFMa0FHU2FUT05PY2pzWXFvSE1xS1FjVFRNYkJ1V1hReUVJWk9v?=
 =?utf-8?B?VE16SkdoNUswbHpwRXE2WWgycUM2NU16cmViYS9XRVNnS0FmNytLUTJ3TkFa?=
 =?utf-8?B?WTFMUmMyRGM3MGFIR0k5SWpIZDFRRlhvRTlmZy9RR1hjdkpGNXgxSUxOOWlU?=
 =?utf-8?B?azFyQXJLclo1Y1JNdDF5L284dHdTWVlHQmgyL3lPeVFsc2dFNzhsV2MzS0lI?=
 =?utf-8?B?cVFVVHVnbTduOWtnTkpLUE55eUZvaHdUV0xyNk5EL3JVcG9kVDlSWFcrekNl?=
 =?utf-8?B?MXIvR0locU50UEV4a2VrVDFXek1XMmJSUDJiQzdoNlBscDNlbHQ2aTVTOXlH?=
 =?utf-8?B?eVI3SGZWR0FvS3hnZy9ib1RXN25jUytyaWk1YjZIQnFidTUvOVBIcDJGVDJl?=
 =?utf-8?B?SFV3SER5SHRjMmowd0o4eVFCbmFoQW1HakVUSUdzZUxCTm1TRXlydEU0UXVZ?=
 =?utf-8?B?c2dmVHlKWThDdThHZW9zb0NLYTJ1R2tHQjFXRGFybE9wUWdpc29WT1ViZk9Q?=
 =?utf-8?B?ZVM2ZC9FWnRkdFhCaHFmVnhtVlVLZEZsSkpEaldwK2ovTThJZ0lKdXh1cDli?=
 =?utf-8?B?MFFRdE15T3lmem5JSTh6aXIxTGxtZXZDdmRKTnJzcjB0T1FEb0daOHdPVzFi?=
 =?utf-8?B?cVhiM2hEMjJLT3BIMGJzeUducVl5UlpOTDZXMVQ5NS9jQXdTN0o3M1QrckY5?=
 =?utf-8?B?K2N2WW1NcFpmSHdCOUk4R2tlQ3pYUzNsODdGeGdzL2ZFdkZQZTkrdlZHUTZP?=
 =?utf-8?B?Q1FkTFV4bzZLcjA1WW5wbWZVZE9FaVk1YkVraEt2TnZIRDhMZ2xYbHhCZ2dG?=
 =?utf-8?B?aEwzOW9jb1FmRWxyR1ltdWVwQWxYL3Z2ZVVIN2FmRjNKdlpjY1MwR1lScG4r?=
 =?utf-8?B?Tys5U24xUzR4OUdaanB1Ulo5ODBCb3F3MkZma1M3SGh4NFkxOTN0OWFIWURF?=
 =?utf-8?B?akptN1poa28wOE5ZYjhUYUt4YmMvelJyVURHVEVPdTh0dzI4L3JReXJuc2Ev?=
 =?utf-8?B?bERJeXB6QzkwWFIzQis3eUhmbXFBVGYvRFBNUlMvWktxeTNrUXFYQWs2Y0Vv?=
 =?utf-8?B?ZDYvTUJxejNSSEdaWm55ekJVN0NMMGxvcUZvcFZFb3JGaE05eUJGTUl4KzVa?=
 =?utf-8?B?QUtvU0dsV2JwVzdFbFp2NEtBeXdqVTdWRlZxTkhMaGhWaGdHbzJDc2MwQnQz?=
 =?utf-8?B?ekFqVWFzeHp6bHU3SUgybFNVcEp0SjhDSjQ5c05rUFFRUHQ2dU01TUtkYml2?=
 =?utf-8?Q?ICv4fnBe3PNDfA8ZyYm2kZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c30889-c1ef-4d5b-83d5-08d9b4bef259
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 11:37:25.0731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbFmFfkoofg64p2ps8rIeMWI5IRvSwSVjvg4honlPqunToLQ92o2orSf7856bd3VjTprhqtK7Ef0ZXKUcnwA4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
U2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxLCAyMDIxIDc6MjkgUE0NCj5UbzogWXUsIExhbmcg
PExhbmcuWXVAYW1kLmNvbT47IENocmlzdGlhbiBLw7ZuaWcNCj48Y2tvZW5pZy5sZWljaHR6dW1l
cmtlbkBnbWFpbC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMYXphciwgTGlqbw0K
PjxMaWpvLkxhemFyQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj5T
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgc3VwcG9ydCB0byBTTVUgZGVidWcg
b3B0aW9uDQo+DQo+QW0gMDEuMTIuMjEgdW0gMTI6MjAgc2NocmllYiBZdSwgTGFuZzoNCj4+IFtB
TUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb20+DQo+Pj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxLCAyMDIxIDY6NDkgUE0NCj4+
PiBUbzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+Pj4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+Pj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IExhemFyLCBMaWpvDQo+Pj4gPExpam8uTGF6YXJAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5I
dWFuZ0BhbWQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBz
dXBwb3J0IHRvIFNNVSBkZWJ1ZyBvcHRpb24NCj4+Pg0KPj4+IEFtIDAxLjEyLjIxIHVtIDExOjQ0
IHNjaHJpZWIgWXUsIExhbmc6DQo+Pj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+Pj4+DQo+
Pj4+DQo+Pj4+DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4gRnJvbTog
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4+Pj4+IFNlbnQ6
IFdlZG5lc2RheSwgRGVjZW1iZXIgMSwgMjAyMSA1OjMwIFBNDQo+Pj4+PiBUbzogWXUsIExhbmcg
PExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4+PiBD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGF6YXIs
IExpam8NCj4+Pj4+IDxMaWpvLkxhemFyQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdA
YW1kLmNvbT4NCj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBzdXBw
b3J0IHRvIFNNVSBkZWJ1ZyBvcHRpb24NCj4+Pj4+DQo+Pj4+PiBBbSAwMS4xMi4yMSB1bSAxMDoy
NCBzY2hyaWViIExhbmcgWXU6DQo+Pj4+Pj4gVG8gbWFpbnRhaW4gc3lzdGVtIGVycm9yIHN0YXRl
IHdoZW4gU01VIGVycm9ycyBvY2N1cnJlZCwgd2hpY2gNCj4+Pj4+PiB3aWxsIGFpZCBpbiBkZWJ1
Z2dpbmcgU01VIGZpcm13YXJlIGlzc3VlcywgYWRkIFNNVSBkZWJ1ZyBvcHRpb24gc3VwcG9ydC4N
Cj4+Pj4+Pg0KPj4+Pj4+IEl0IGNhbiBiZSBlbmFibGVkIG9yIGRpc2FibGVkIHZpYSBhbWRncHVf
c211X2RlYnVnIGRlYnVnZnMgZmlsZS4NCj4+Pj4+PiBXaGVuIGVuYWJsZWQsIGl0IG1ha2VzIFNN
VSBlcnJvcnMgZmF0YWwuDQo+Pj4+Pj4gSXQgaXMgZGlzYWJsZWQgYnkgZGVmYXVsdC4NCj4+Pj4+
Pg0KPj4+Pj4+ID09IENvbW1hbmQgR3VpZGUgPT0NCj4+Pj4+Pg0KPj4+Pj4+IDEsIGVuYWJsZSBT
TVUgZGVidWcgb3B0aW9uDQo+Pj4+Pj4NCj4+Pj4+PiAgICAgIyBlY2hvIDEgPiAvc3lzL2tlcm5l
bC9kZWJ1Zy9kcmkvMC9hbWRncHVfc211X2RlYnVnDQo+Pj4+Pj4NCj4+Pj4+PiAyLCBkaXNhYmxl
IFNNVSBkZWJ1ZyBvcHRpb24NCj4+Pj4+Pg0KPj4+Pj4+ICAgICAjIGVjaG8gMCA+IC9zeXMva2Vy
bmVsL2RlYnVnL2RyaS8wL2FtZGdwdV9zbXVfZGVidWcNCj4+Pj4+Pg0KPj4+Pj4+IHYzOg0KPj4+
Pj4+ICAgICAtIFVzZSBkZWJ1Z2ZzX2NyZWF0ZV9ib29sKCkuKENocmlzdGlhbikNCj4+Pj4+PiAg
ICAgLSBQdXQgdmFyaWFibGUgaW50byBzbXVfY29udGV4dCBzdHJ1Y3QuDQo+Pj4+Pj4gICAgIC0g
RG9uJ3QgcmVzZW5kIGNvbW1hbmQgd2hlbiB0aW1lb3V0Lg0KPj4+Pj4+DQo+Pj4+Pj4gdjI6DQo+
Pj4+Pj4gICAgIC0gUmVzZW5kIGNvbW1hbmQgd2hlbiB0aW1lb3V0LihMaWpvKQ0KPj4+Pj4+ICAg
ICAtIFVzZSBkZWJ1Z2ZzIGZpbGUgaW5zdGVhZCBvZiBtb2R1bGUgcGFyYW1ldGVyLg0KPj4+Pj4+
DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8bGFuZy55dUBhbWQuY29tPg0KPj4+Pj4g
V2VsbCB0aGUgZGVidWdmcyBwYXJ0IGxvb2tzIHJlYWxseSBuaWNlIGFuZCBjbGVhbiBub3csIGJ1
dCBvbmUgbW9yZQ0KPj4+Pj4gY29tbWVudCBiZWxvdy4NCj4+Pj4+DQo+Pj4+Pj4gLS0tDQo+Pj4+
Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgICAgICAg
IHwgMyArKysNCj4+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3Nt
dS5oICAgICAgICAgICAgfCA1ICsrKysrDQo+Pj4+Pj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jIHwgMiArKw0KPj4+Pj4+ICAgICBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYyAgICAgICAgICAgICB8IDggKysrKysrKy0N
Cj4+Pj4+PiAgICAgNCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RlYnVnZnMuYw0KPj4+Pj4+IGluZGV4IDE2NGQ2YTllOWZiYi4uODZjZDg4OGM3ODIy
IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZWJ1Z2ZzLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGVidWdmcy5jDQo+Pj4+Pj4gQEAgLTE2MTgsNiArMTYxOCw5IEBAIGludCBhbWRncHVfZGVidWdm
c19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+Pj4+PiAqYWRldikNCj4+Pj4+PiAgICAgCWlm
ICghZGVidWdmc19pbml0aWFsaXplZCgpKQ0KPj4+Pj4+ICAgICAJCXJldHVybiAwOw0KPj4+Pj4+
DQo+Pj4+Pj4gKwlkZWJ1Z2ZzX2NyZWF0ZV9ib29sKCJhbWRncHVfc211X2RlYnVnIiwgMDYwMCwg
cm9vdCwNCj4+Pj4+PiArCQkJCSAgJmFkZXYtPnNtdS5zbXVfZGVidWdfbW9kZSk7DQo+Pj4+Pj4g
Kw0KPj4+Pj4+ICAgICAJZW50ID0gZGVidWdmc19jcmVhdGVfZmlsZSgiYW1kZ3B1X3ByZWVtcHRf
aWIiLCAwNjAwLCByb290LA0KPmFkZXYsDQo+Pj4+Pj4gICAgIAkJCQkgICZmb3BzX2liX3ByZWVt
cHQpOw0KPj4+Pj4+ICAgICAJaWYgKElTX0VSUihlbnQpKSB7DQo+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUuaA0KPj4+Pj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5oDQo+Pj4+Pj4gaW5kZXggZjczOGY3ZGMy
MGM5Li41MGRiZjU1OTRhOWQgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9pbmMvYW1kZ3B1X3NtdS5oDQo+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9pbmMvYW1kZ3B1X3NtdS5oDQo+Pj4+Pj4gQEAgLTU2OSw2ICs1NjksMTEgQEAgc3RydWN0IHNt
dV9jb250ZXh0DQo+Pj4+Pj4gICAgIAlzdHJ1Y3Qgc211X3VzZXJfZHBtX3Byb2ZpbGUgdXNlcl9k
cG1fcHJvZmlsZTsNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAJc3RydWN0IHN0Yl9jb250ZXh0IHN0Yl9j
b250ZXh0Ow0KPj4+Pj4+ICsJLyoNCj4+Pj4+PiArCSAqIFdoZW4gZW5hYmxlZCwgaXQgbWFrZXMg
U01VIGVycm9ycyBmYXRhbC4NCj4+Pj4+PiArCSAqICgwID0gZGlzYWJsZWQgKGRlZmF1bHQpLCAx
ID0gZW5hYmxlZCkNCj4+Pj4+PiArCSAqLw0KPj4+Pj4+ICsJYm9vbCBzbXVfZGVidWdfbW9kZTsN
Cj4+Pj4+PiAgICAgfTsNCj4+Pj4+Pg0KPj4+Pj4+ICAgICBzdHJ1Y3QgaTJjX2FkYXB0ZXI7DQo+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxk
ZWJhcmFuX3BwdC5jDQo+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L2FsZGViYXJhbl9wcHQuYw0KPj4+Pj4+IGluZGV4IDZlNzgxY2VlOGJiNi4uZDM3OTdhMmQ2NDUx
IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMv
YWxkZWJhcmFuX3BwdC5jDQo+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4+Pj4+PiBAQCAtMTkxOSw2ICsxOTE5LDggQEAgc3Rh
dGljIGludCBhbGRlYmFyYW5fbW9kZTJfcmVzZXQoc3RydWN0DQo+Pj4+PiBzbXVfY29udGV4dCAq
c211KQ0KPj4+Pj4+ICAgICBvdXQ6DQo+Pj4+Pj4gICAgIAltdXRleF91bmxvY2soJnNtdS0+bWVz
c2FnZV9sb2NrKTsNCj4+Pj4+Pg0KPj4+Pj4+ICsJQlVHX09OKHVubGlrZWx5KHNtdS0+c211X2Rl
YnVnX21vZGUpICYmIHJldCk7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICAgICAJcmV0dXJuIHJldDsNCj4+
Pj4+PiAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+Pj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdV9jbW4uYw0KPj4+Pj4+IGluZGV4IDA0OGNhMTY3Mzg2My4uOWJlMDA1ZWI0MjQxIDEw
MDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5j
DQo+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4+
Pj4+PiBAQCAtMzQ5LDE1ICszNDksMjEgQEAgaW50DQo+c211X2Ntbl9zZW5kX3NtY19tc2dfd2l0
aF9wYXJhbShzdHJ1Y3QNCj4+Pj4+IHNtdV9jb250ZXh0ICpzbXUsDQo+Pj4+Pj4gICAgIAkJX19z
bXVfY21uX3JlZ19wcmludF9lcnJvcihzbXUsIHJlZywgaW5kZXgsIHBhcmFtLA0KPm1zZyk7DQo+
Pj4+Pj4gICAgIAkJZ290byBPdXQ7DQo+Pj4+Pj4gICAgIAl9DQo+Pj4+Pj4gKw0KPj4+Pj4+ICAg
ICAJX19zbXVfY21uX3NlbmRfbXNnKHNtdSwgKHVpbnQxNl90KSBpbmRleCwgcGFyYW0pOw0KPj4+
Pj4+ICAgICAJcmVnID0gX19zbXVfY21uX3BvbGxfc3RhdChzbXUpOw0KPj4+Pj4+ICAgICAJcmVz
ID0gX19zbXVfY21uX3JlZzJlcnJubyhzbXUsIHJlZyk7DQo+Pj4+Pj4gLQlpZiAocmVzICE9IDAp
DQo+Pj4+Pj4gKwlpZiAocmVzICE9IDApIHsNCj4+Pj4+PiAgICAgCQlfX3NtdV9jbW5fcmVnX3By
aW50X2Vycm9yKHNtdSwgcmVnLCBpbmRleCwgcGFyYW0sDQo+bXNnKTsNCj4+Pj4+PiArCQlnb3Rv
IE91dDsNCj4+Pj4+PiArCX0NCj4+Pj4+PiAgICAgCWlmIChyZWFkX2FyZykNCj4+Pj4+PiAgICAg
CQlzbXVfY21uX3JlYWRfYXJnKHNtdSwgcmVhZF9hcmcpOw0KPj4+Pj4+ICAgICBPdXQ6DQo+Pj4+
Pj4gICAgIAltdXRleF91bmxvY2soJnNtdS0+bWVzc2FnZV9sb2NrKTsNCj4+Pj4+PiArDQo+Pj4+
Pj4gKwlCVUdfT04odW5saWtlbHkoc211LT5zbXVfZGVidWdfbW9kZSkgJiYgcmVzKTsNCj4+Pj4+
IEJVR19PTigpIHJlYWxseSBjcmFzaGVzIHRoZSBrZXJuZWwgYW5kIGlzIG9ubHkgYWxsb3dlZCBp
ZiB3ZQ0KPj4+Pj4gcHJldmVudCBmdXJ0aGVyIGRhdGEgY29ycnVwdGlvbiB3aXRoIHRoYXQuDQo+
Pj4+Pg0KPj4+Pj4gTW9zdCBvZiB0aGUgdGltZSBXQVJOX09OKCkgaXMgbW9yZSBhcHByb3ByaWF0
ZSwgYnV0IEkgY2FuJ3QgZnVsbHkNCj4+Pj4+IGp1ZGdlIGhlcmUgc2luY2UgSSBkb24ndCBrbm93
IHRoZSBTTVUgY29kZSB3ZWxsIGVub3VnaC4NCj4+Pj4gVGhpcyBpcyB3aGF0IFNNVSBGVyBndXlz
IHdhbnQuIFRoZXkgd2FudCAidXNlci12aXNpYmxlIChwb3RlbnRpYWxseQ0KPj4+PiBmYXRhbCkN
Cj4+PiBlcnJvcnMiLCB0aGVuIGEgaGFuZy4NCj4+Pj4gVGhleSB3YW50IHRvIGtlZXAgc3lzdGVt
IHN0YXRlIHNpbmNlIHRoZSBlcnJvciBvY2N1cnJlZC4NCj4+PiBXZWxsIHRoYXQgaXMgcmF0aGVy
IHByb2JsZW1hdGljLg0KPj4+DQo+Pj4gRmlyc3Qgb2YgYWxsIHdlIG5lZWQgdG8gcmVhbGx5IGp1
c3RpZnkgdGhhdCwgY3Jhc2hpbmcgdGhlIGtlcm5lbCBpcw0KPj4+IG5vdCBzb21ldGhpbmcgZWFz
aWx5IGRvbmUuDQo+Pj4NCj4+PiBUaGVuIHRoaXMgaXNuJ3QgcmVhbGx5IGVmZmVjdGl2ZSBoZXJl
LiBXaGF0IGhhcHBlbnMgaXMgdGhhdCB5b3UgY3Jhc2gNCj4+PiB0aGUga2VybmVsIHRocmVhZCBv
ZiB0aGUgY3VycmVudGx5IGV4ZWN1dGluZyBwcm9jZXNzLCBidXQgaXQgaXMNCj4+PiBwZXJmZWN0
bHkgcG9zc2libGUgdGhhdCBhbm90aGVyIHRocmVhZCBzdGlsbCB0cmllcyB0byBzZW5kIG1lc3Nh
Z2VzDQo+Pj4gdG8gdGhlIFNNVS4gWW91IG5lZWQgdG8gaGF2ZSB0aGUgQlVHX09OKCkgYmVmb3Jl
IGRyb3BwaW5nIHRoZSBsb2NrIHRvDQo+Pj4gbWFrZSBzdXJlIHRoYXQgdGhpcyByZWFsbHkgZ2V0
cyB0aGUgZHJpdmVyIHN0dWNrIGluIHRoZSBjdXJyZW50IHN0YXRlLg0KPj4gVGhhbmtzLiBJIGdv
dCBpdC4gSSBqdXN0IHRob3VnaHQgaXQgaXMgYSBrZW5lbCBwYW5pYy4NCj4+IENvdWxkIHdlIHVz
ZSBhIHBhbmljKCkgaGVyZT8NCj4NCj5Qb3RlbnRpYWxseSwgYnV0IHRoYXQgbWlnaHQgcmVib290
IHRoZSBzeXN0ZW0gYXV0b21hdGljYWxseSB3aGljaCBpcyBwcm9iYWJseSBub3QNCj53aGF0IHlv
dSB3YW50IGVpdGhlci4NCj4NCj5Ib3cgZG9lcyB0aGUgU01VIGZpcm13YXJlIHRlYW0gZ2F0aGVy
IHRoZSBuZWNlc3NhcnkgaW5mb3JtYXRpb24gd2hlbiBhDQo+cHJvYmxlbSBvY2N1cnM/DQoNCkFz
IGZhciBhcyBJIGtub3csIHRoZXkgdXN1YWxseSB1c2UgYSBIRFQgdG8gY29sbGVjdCBpbmZvcm1h
dGlvbi4NCkFuZCB0aGV5IHJlcXVlc3QgYSBoYW5nIHdoZW4gZXJyb3Igb2NjdXJyZWQgaW4gdGlj
a2V0Lg0KIlN1Z2dlc3RlZCBlcnJvciByZXNwb25zZXMgaW5jbHVkZSBwb3AtdXAgd2luZG93cyAo
YnkgeDg2IGRyaXZlciwgaWYgdGhpcyBpcyBwb3NzaWJsZSkgb3Igc2ltcGx5IGhhbmdpbmcgYWZ0
ZXIgbG9nZ2luZyB0aGUgZXJyb3IuICINCg0KUmVnYXJkcywNCkxhbmcNCg0KPg0KPldoZW4gdGhl
eSBjb25uZWN0IGV4dGVybmFsIGhhcmR3YXJlIGEgQlVHX09OKCkgd2hpbGUgaG9sZGluZyB0aGUg
U01VIGxvY2sNCj5taWdodCB3b3JrLCBidXQgaWYgdGhleSB3YW50IHRvIFNTSCBpbnRvIHRoZSBz
eXN0ZW0geW91IHNob3VsZCBwcm9iYWJseSByYXRoZXINCj5zZXQgYSBmbGFnIHRoYXQgdGhlIGhh
cmR3YXJlIHNob3VsZG4ndCBiZSB0b3VjaGVkIGFueSBtb3JlIGJ5IHRoZSBkcml2ZXIgYW5kDQo+
Y29udGludWUuDQo+DQo+T3RoZXJ3aXNlIHRoZSBib3ggaXMgbW9zdCBsaWtlbHkgcmVhbGx5IHVu
c3RhYmxlIGFmdGVyIHRoaXMuDQo+DQo+UmVnYXJkcywNCj5DaHJpc3RpYW4uDQo+DQo+Pg0KPj4g
UmVnYXJkcywNCj4+IExhbmcNCj4+DQo+Pj4gUmVnYXJkcywNCj4+PiBDaHJpc3RpYW4uDQo+Pj4N
Cj4+Pj4gUmVnYXJkcywNCj4+Pj4gTGFuZw0KPj4+Pg0KPj4+Pj4gQ2hyaXN0aWFuLg0KPj4+Pj4N
Cj4+Pj4+PiArDQo+Pj4+Pj4gICAgIAlyZXR1cm4gcmVzOw0KPj4+Pj4+ICAgICB9DQo+Pj4+Pj4N
Cg==
