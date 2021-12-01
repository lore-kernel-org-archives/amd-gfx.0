Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED97C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 11:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FC76FA8B;
	Wed,  1 Dec 2021 11:20:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1736FA8B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 11:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo2aHFaH3zCFKrXppwiGBAKjpAkPPvyBhUjMuhcqBtADeRxLzGaXRn/qiw/CK6ybwxMKnZmfIfraRyxMlitFNa4gZ833snDlgBTCi8NXKrEO3zbf0Z2OwVXnd18Lz0TvYhC0/lXnLKVaSLgfGStVZ6YkcqO0JJ66k3QX7EcCCrrJnbY3JPT8qvD02wwpw7J2Hp9zXtE3Z4MtVJGMhXIYrhRkhkt5TNArJYSVWAyZ6cnlbv6oBZvLXBtvU95VLjPLFjwKHDuC6lUyHfE1YlTiSK+kWnDwvg1z41S/uB8iuwnegnfKgSoN42wRSAc7LOP7JByVXtrd06RYzT4GRFt4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV6R3EtAIGxYoW5+vYtENUhdmZELLxbBnC5pWXnCQd0=;
 b=j9HPRspjuWe/k8qRxKbtehGNEVym0S03qsJGXI2PL2KGn6sW98Nl1s1QzszScuvtX5E54Iv3f7qX2Uj435HQmRkuLzuSlZl8fxYbMqtVRfhC+qRXn4U3zVndIhtYqKTodcBVgv+rPZlqLwCnF7FVabOT9ihjFFZTu1UKvPNHYbUcGT2htxKxFk/FxAz62H0Nj0gdmeObwajFVFsAW4GP85FwixeooScCVvAYvTakA8XMW0VEFZ25WFn5j/uxs9Loi0dGgrcbDs/ui8ExM9d/tKJLlYk3QAW2V80GH4s1HSoT4PB5H6qPt4Jik0pjrgjoPH04MwKI35mTpW+9O4s26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV6R3EtAIGxYoW5+vYtENUhdmZELLxbBnC5pWXnCQd0=;
 b=uqZeXThRlAlE53REynxe8URZbIXTmH4Jeu75VWDc6FDU+0DwO0zaroeUV7YE6Dsb68Q5oRSgv1lVAZ17DRGbzQvGZdL6j1XPrr66p1ESkLlQtTefDeT0QVanhbSImFmBZgCiuTBIhRcnB4YF+CSSr2Ztcl96p2QmAGpiAp9Ic7U=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Wed, 1 Dec 2021 11:20:48 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 11:20:48 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Topic: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Index: AQHX5pVcc3LghN55bkmOkF3w2Pkmd6wdXtgAgAATJuCAAALugIAABsDg
Date: Wed, 1 Dec 2021 11:20:48 +0000
Message-ID: <DM6PR12MB42505899AFB96290F516C21BFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
 <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
In-Reply-To: <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-01T11:20:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2dbaa297-bd01-4795-a14f-776bdc0047f1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-01T11:20:45Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 283a3ac1-1b83-4972-b1b6-b6aaa3e6b4ce
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca557f8e-5f99-4060-f30a-08d9b4bca031
x-ms-traffictypediagnostic: DM5PR12MB1338:
x-microsoft-antispam-prvs: <DM5PR12MB133873C8DB3EDD794AC57408FB689@DM5PR12MB1338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKNx/mAkUQ3bwkhnFw1E64CwAz70oV8PQQGtGxXOrqTvr6sUgKbgLsGO2ZdqCrndwyt9W8ke8g/bCF4henqpV+nyHvmvdybGbRzzL6YO7ucS8JXjHz7h8MuhEJSVk8gAqPLkKSxM+kvibddYcOLaxKupdqZF3AFhbvOgy6WHNXni7/CgRKAL4rZUp1too06Q1FNi5Z+doS6hQDMEcsAHQIKyc9qWkpeRCztHGyWUQf2r4nBqVO7j4D28igfbytSGwufn2Tdwwu7mVcb7sQGaKBsJNhzbNPH2HooSrvUvETAadtQayBGioZVAT8+lDts3I8LHOUvmvSIB7Z8q2S4Xv2jULoGBooRoDRY/rx//VcV/q/xiYJjhtNfgBmGBh30m7/ZWM7dWuwYm8Up6i8oQzHGnHUwl/90YwnIKsloBQHPuU5njG3bweCT1nCM9YSGeSEKiTN/SeW4OOyD0Zuxs1PyfPes+cYnByUAFK7puVson0HDyt+yNEdDcRrFmr+0CFZfjdnoeDtJ79QrDtWpCJISmNxHT6KAKzBXxQ5gwMwZYIVrWDaYCATtf8JAnY5NmetEnnzgk2Eb5gpriPrImqf6kw6Mm2nfYmXt55SJiGB84W919SrWiiwS1ji5SRxcxJvbMnUkUK4k3f8orxZlVrcfiWFAE3RoeF4vu1D9eBUafbavO0KhwslPhP8KkyGFLSh8AwBAjCEaORTy2oR9xvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(38100700002)(7696005)(86362001)(5660300002)(53546011)(508600001)(8936002)(66446008)(64756008)(316002)(71200400001)(76116006)(4326008)(66946007)(33656002)(122000001)(66574015)(8676002)(66476007)(66556008)(52536014)(54906003)(83380400001)(55016003)(38070700005)(9686003)(110136005)(2906002)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnFMcFZEUEt6bmtLbi8yVE5EOGRJQ285TGVQMURQVUpWNCtmTXZ0ODB0ZDR2?=
 =?utf-8?B?UytkS2pOVXp0WkZNNkdDTTlaTUwvYllpM25BanVTck5JMnJYSnI4N3A3UnJq?=
 =?utf-8?B?alAyS3duM0krUEZaMjVpdDVtUkhKVlozSDFlOE1IWXdBd3dwYzgxMkZ6RnFL?=
 =?utf-8?B?eWtZa2E3R3UxSTNIRVpsZ1N6enNvdUVJbmYxL1ZCVEJ4Wk02OGM1Nm4xbnYw?=
 =?utf-8?B?UldpekIySFZBWnBTQ3NjVUdNaWxqUU9hQVRhYzlYL3p4VWc0QTBYM1RZc3Nl?=
 =?utf-8?B?RXIyeHFQdmFTbFB1cEczNjdjb3R5UUp3YVBNaWt6UWhnNFc2WkdwSUwwemQ3?=
 =?utf-8?B?Q2dzejJPcmlweHpCdlpadnl2cXQ2elNHSW16YXExRW9vdUFYZzNucmI4enJ0?=
 =?utf-8?B?cEVDc3hXUHk0TklrWEg5amJLWm9FeGJtRWxmRVFjalBzeU8yMGpjNWl0UzNZ?=
 =?utf-8?B?amZnVTZQZWNoNFdHTitVSGZhclBqQmFqaC92VHJUYjR3QTFHMUdOdmtRRXhB?=
 =?utf-8?B?YTcvU2R1QWU1NEl2SzhxeFExQnBMbmxLV3J4bjViZWtMSUhHZ21ONmpTVU96?=
 =?utf-8?B?MmVUNmpYNGZhaVpKVWhhSzRTeTJybnBoWVNSMUxhRDBGWVlCMDE2N2hCN0R1?=
 =?utf-8?B?VG9yUTVTSmdxbXRrQUE2UlBJZFV5M3YrQVIyUDM2TWo2bTZpTTRGb0lRWGR6?=
 =?utf-8?B?ZlZNSnU5MnczWGhqMDMvZmNRSVFWb25Ja25pZXhNNWhXM0tMOGdiVkFzNkFz?=
 =?utf-8?B?S3ZvcWlieTBPSS9Nd1VDSGJhWjRldHVyRUhBUXQzSDI1SkVwYWFhekRLdkt0?=
 =?utf-8?B?Tk4yU0ZCYUpKcTZ5T0c5bFFwK3VsbkVYb2tHZHZ4azEyaTdSd1BZaHZDUExX?=
 =?utf-8?B?OHFaR2ZtazVEYU11bjlwM3A4T0hSM2FTbzhkZjU5UjIrY2t0c3JncGt1L2hO?=
 =?utf-8?B?Qi9WSEFiaUtTL09EbDlQTTRDUiswclhid0c5VkI4MGxWMyswWkdxOHNnRFNu?=
 =?utf-8?B?bVNBdHAvaE55RXU1VVhXSVpNMUMxbDBBUlBtQUNiUzhNVmxvVTRibVFZYjRY?=
 =?utf-8?B?VzdzU0xVNmdXSTZjM1R4OEtMRzlPNWVER0VMTWtyYVJjQVc2OU9CWTVpTmVM?=
 =?utf-8?B?ZE5pSk03UGxLTlhUUEpyalViM0dkUlRPQXkzbGllSTgwK2Z4TEpBSEYvQUZT?=
 =?utf-8?B?emFmZjdKV1ExcG9NWVh4NkIwZnpXR1A5TEhLSFc2SzZxajR6QnJ5WER2RkJB?=
 =?utf-8?B?emFFZjh3RVZCS21lcE0vQ2pxUGhnd0xuMjlOY0xhNkw1RG1TMWU5VUVHaW42?=
 =?utf-8?B?Wnc3SHVOMnQwOEZET09wRmdmMCtMK2lGY2xKZllvSFpVL0tOaTl3dnhZeUhN?=
 =?utf-8?B?K3ZTK3B5RVF2S1VwR3lhdGY2SVllMnpUaTdyY3B2aTl1cytOcWJIVUovbW9i?=
 =?utf-8?B?VjRveUxKVFB3QWhobGkwK0VyTzB4K0k0d0kyWnkrVjBDUzBpM0ZROHlvYnFV?=
 =?utf-8?B?WjR5QlFtczNVM25PcXZhYkhESXV6S3IyNWFwMENlK0xoa3R1NWM0WDJSSVh0?=
 =?utf-8?B?ZEtNV0xEZWZ1UUNRTWI3SHlxekl3Nmp5Vng0NTFwQUZuayt6bU9rbHR3U2h4?=
 =?utf-8?B?VzF2ZTlualdmb21DWGY5TWQycFBaWjZxWFNtZHI3SW8ramMvNDRSZjdpNmZv?=
 =?utf-8?B?RHdQKzNaZ2JGd1E2SkNSL2JQS3FtZTFqZk9NY0U0QTZJM3Y1TkViRkt1QVA0?=
 =?utf-8?B?RmpEREdKVlVsajk4SkRKd3hPa1RTelJiRjE3SDMvckdFTUtYTmNBREIzUU1C?=
 =?utf-8?B?emtjeENQSVNxUTJTY054WUNaZEFHSkwvQjdaWENONE0zZHRtZm5objg4Ty9M?=
 =?utf-8?B?dEtZNmpMSmg4VU9OZUdiV0JlZkFxZWlzY2x5VzU1YUJRTFhXRmhrWGtzVzd2?=
 =?utf-8?B?dnQwYjdoblJPMUpTSFR3U2dXVXdKZWFqaGRQTUl0Smg3M1FpOTJ4NTZGUU9I?=
 =?utf-8?B?M2R2enYvck96S21lNEhzbjdSSnZVV0JFRVpkVlVkRFc5cW51RU1iWXJWZGtj?=
 =?utf-8?B?bUN6MFlpYTVFdHVmaVNZQTV0dmoraFkrdG01RUxPbGRLQ0xHenM4WWN4SDdS?=
 =?utf-8?B?MXNGV1NuMS9SQjRwQm9kbFFYZVFjWlRvWUxSa3lQNzNZci9wR1BoVjh3cWhn?=
 =?utf-8?Q?mlqoI5612XZSxmRmixZhVHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca557f8e-5f99-4060-f30a-08d9b4bca031
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 11:20:48.2781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxRLqdRQFCDcViEb8BnRTghRTGY1j3x7Pvyccgg9z2ikqQigx0NFpqh9svqk2OOPDdgGx5r5AP9k6WmUsvzr4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
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
LQ0KPkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwu
Y29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMSwgMjAyMSA2OjQ5IFBNDQo+VG86IFl1
LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPjxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMYXphciwgTGlqbw0K
PjxMaWpvLkxhemFyQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj5T
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgc3VwcG9ydCB0byBTTVUgZGVidWcg
b3B0aW9uDQo+DQo+QW0gMDEuMTIuMjEgdW0gMTE6NDQgc2NocmllYiBZdSwgTGFuZzoNCj4+IFtB
TUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+Pg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPj4+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMSwgMjAyMSA1OjMwIFBNDQo+
Pj4gVG86IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPj4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBMYXphciwgTGlqbw0KPj4+IDxMaWpvLkxhemFyQGFtZC5jb20+OyBIdWFuZywgUmF5
IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBhZGQgc3VwcG9ydCB0byBTTVUgZGVidWcgb3B0aW9uDQo+Pj4NCj4+PiBBbSAwMS4xMi4yMSB1
bSAxMDoyNCBzY2hyaWViIExhbmcgWXU6DQo+Pj4+IFRvIG1haW50YWluIHN5c3RlbSBlcnJvciBz
dGF0ZSB3aGVuIFNNVSBlcnJvcnMgb2NjdXJyZWQsIHdoaWNoIHdpbGwNCj4+Pj4gYWlkIGluIGRl
YnVnZ2luZyBTTVUgZmlybXdhcmUgaXNzdWVzLCBhZGQgU01VIGRlYnVnIG9wdGlvbiBzdXBwb3J0
Lg0KPj4+Pg0KPj4+PiBJdCBjYW4gYmUgZW5hYmxlZCBvciBkaXNhYmxlZCB2aWEgYW1kZ3B1X3Nt
dV9kZWJ1ZyBkZWJ1Z2ZzIGZpbGUuDQo+Pj4+IFdoZW4gZW5hYmxlZCwgaXQgbWFrZXMgU01VIGVy
cm9ycyBmYXRhbC4NCj4+Pj4gSXQgaXMgZGlzYWJsZWQgYnkgZGVmYXVsdC4NCj4+Pj4NCj4+Pj4g
PT0gQ29tbWFuZCBHdWlkZSA9PQ0KPj4+Pg0KPj4+PiAxLCBlbmFibGUgU01VIGRlYnVnIG9wdGlv
bg0KPj4+Pg0KPj4+PiAgICAjIGVjaG8gMSA+IC9zeXMva2VybmVsL2RlYnVnL2RyaS8wL2FtZGdw
dV9zbXVfZGVidWcNCj4+Pj4NCj4+Pj4gMiwgZGlzYWJsZSBTTVUgZGVidWcgb3B0aW9uDQo+Pj4+
DQo+Pj4+ICAgICMgZWNobyAwID4gL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvYW1kZ3B1X3NtdV9k
ZWJ1Zw0KPj4+Pg0KPj4+PiB2MzoNCj4+Pj4gICAgLSBVc2UgZGVidWdmc19jcmVhdGVfYm9vbCgp
LihDaHJpc3RpYW4pDQo+Pj4+ICAgIC0gUHV0IHZhcmlhYmxlIGludG8gc211X2NvbnRleHQgc3Ry
dWN0Lg0KPj4+PiAgICAtIERvbid0IHJlc2VuZCBjb21tYW5kIHdoZW4gdGltZW91dC4NCj4+Pj4N
Cj4+Pj4gdjI6DQo+Pj4+ICAgIC0gUmVzZW5kIGNvbW1hbmQgd2hlbiB0aW1lb3V0LihMaWpvKQ0K
Pj4+PiAgICAtIFVzZSBkZWJ1Z2ZzIGZpbGUgaW5zdGVhZCBvZiBtb2R1bGUgcGFyYW1ldGVyLg0K
Pj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxsYW5nLnl1QGFtZC5jb20+DQo+Pj4g
V2VsbCB0aGUgZGVidWdmcyBwYXJ0IGxvb2tzIHJlYWxseSBuaWNlIGFuZCBjbGVhbiBub3csIGJ1
dCBvbmUgbW9yZQ0KPj4+IGNvbW1lbnQgYmVsb3cuDQo+Pj4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgICAgICAgIHwgMyArKysN
Cj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5oICAgICAgICAg
ICAgfCA1ICsrKysrDQo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMv
YWxkZWJhcmFuX3BwdC5jIHwgMiArKw0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdV9jbW4uYyAgICAgICAgICAgICB8IDggKysrKysrKy0NCj4+Pj4gICAgNCBmaWxlcyBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+DQo+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+Pj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4+PiBpbmRl
eCAxNjRkNmE5ZTlmYmIuLjg2Y2Q4ODhjNzgyMiAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPj4+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+Pj4+IEBAIC0xNjE4LDYgKzE2MTgs
OSBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPj4+ICph
ZGV2KQ0KPj4+PiAgICAJaWYgKCFkZWJ1Z2ZzX2luaXRpYWxpemVkKCkpDQo+Pj4+ICAgIAkJcmV0
dXJuIDA7DQo+Pj4+DQo+Pj4+ICsJZGVidWdmc19jcmVhdGVfYm9vbCgiYW1kZ3B1X3NtdV9kZWJ1
ZyIsIDA2MDAsIHJvb3QsDQo+Pj4+ICsJCQkJICAmYWRldi0+c211LnNtdV9kZWJ1Z19tb2RlKTsN
Cj4+Pj4gKw0KPj4+PiAgICAJZW50ID0gZGVidWdmc19jcmVhdGVfZmlsZSgiYW1kZ3B1X3ByZWVt
cHRfaWIiLCAwNjAwLCByb290LCBhZGV2LA0KPj4+PiAgICAJCQkJICAmZm9wc19pYl9wcmVlbXB0
KTsNCj4+Pj4gICAgCWlmIChJU19FUlIoZW50KSkgew0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5oDQo+Pj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9pbmMvYW1kZ3B1X3NtdS5oDQo+Pj4+IGluZGV4IGY3MzhmN2RjMjBjOS4uNTBkYmY1
NTk0YTlkIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRn
cHVfc211LmgNCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvYW1kZ3B1X3Nt
dS5oDQo+Pj4+IEBAIC01NjksNiArNTY5LDExIEBAIHN0cnVjdCBzbXVfY29udGV4dA0KPj4+PiAg
ICAJc3RydWN0IHNtdV91c2VyX2RwbV9wcm9maWxlIHVzZXJfZHBtX3Byb2ZpbGU7DQo+Pj4+DQo+
Pj4+ICAgIAlzdHJ1Y3Qgc3RiX2NvbnRleHQgc3RiX2NvbnRleHQ7DQo+Pj4+ICsJLyoNCj4+Pj4g
KwkgKiBXaGVuIGVuYWJsZWQsIGl0IG1ha2VzIFNNVSBlcnJvcnMgZmF0YWwuDQo+Pj4+ICsJICog
KDAgPSBkaXNhYmxlZCAoZGVmYXVsdCksIDEgPSBlbmFibGVkKQ0KPj4+PiArCSAqLw0KPj4+PiAr
CWJvb2wgc211X2RlYnVnX21vZGU7DQo+Pj4+ICAgIH07DQo+Pj4+DQo+Pj4+ICAgIHN0cnVjdCBp
MmNfYWRhcHRlcjsNCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTMvYWxkZWJhcmFuX3BwdC5jDQo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4+Pj4gaW5kZXggNmU3ODFjZWU4YmI2Li5kMzc5
N2EyZDY0NTEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvYWxkZWJhcmFuX3BwdC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211MTMvYWxkZWJhcmFuX3BwdC5jDQo+Pj4+IEBAIC0xOTE5LDYgKzE5MTksOCBAQCBz
dGF0aWMgaW50IGFsZGViYXJhbl9tb2RlMl9yZXNldChzdHJ1Y3QNCj4+PiBzbXVfY29udGV4dCAq
c211KQ0KPj4+PiAgICBvdXQ6DQo+Pj4+ICAgIAltdXRleF91bmxvY2soJnNtdS0+bWVzc2FnZV9s
b2NrKTsNCj4+Pj4NCj4+Pj4gKwlCVUdfT04odW5saWtlbHkoc211LT5zbXVfZGVidWdfbW9kZSkg
JiYgcmV0KTsNCj4+Pj4gKw0KPj4+PiAgICAJcmV0dXJuIHJldDsNCj4+Pj4gICAgfQ0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMN
Cj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0KPj4+PiBpbmRl
eCAwNDhjYTE2NzM4NjMuLjliZTAwNWViNDI0MSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4+Pj4gQEAgLTM0OSwxNSArMzQ5LDIxIEBAIGludCBz
bXVfY21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHN0cnVjdA0KPj4+IHNtdV9jb250ZXh0ICpz
bXUsDQo+Pj4+ICAgIAkJX19zbXVfY21uX3JlZ19wcmludF9lcnJvcihzbXUsIHJlZywgaW5kZXgs
IHBhcmFtLCBtc2cpOw0KPj4+PiAgICAJCWdvdG8gT3V0Ow0KPj4+PiAgICAJfQ0KPj4+PiArDQo+
Pj4+ICAgIAlfX3NtdV9jbW5fc2VuZF9tc2coc211LCAodWludDE2X3QpIGluZGV4LCBwYXJhbSk7
DQo+Pj4+ICAgIAlyZWcgPSBfX3NtdV9jbW5fcG9sbF9zdGF0KHNtdSk7DQo+Pj4+ICAgIAlyZXMg
PSBfX3NtdV9jbW5fcmVnMmVycm5vKHNtdSwgcmVnKTsNCj4+Pj4gLQlpZiAocmVzICE9IDApDQo+
Pj4+ICsJaWYgKHJlcyAhPSAwKSB7DQo+Pj4+ICAgIAkJX19zbXVfY21uX3JlZ19wcmludF9lcnJv
cihzbXUsIHJlZywgaW5kZXgsIHBhcmFtLCBtc2cpOw0KPj4+PiArCQlnb3RvIE91dDsNCj4+Pj4g
Kwl9DQo+Pj4+ICAgIAlpZiAocmVhZF9hcmcpDQo+Pj4+ICAgIAkJc211X2Ntbl9yZWFkX2FyZyhz
bXUsIHJlYWRfYXJnKTsNCj4+Pj4gICAgT3V0Og0KPj4+PiAgICAJbXV0ZXhfdW5sb2NrKCZzbXUt
Pm1lc3NhZ2VfbG9jayk7DQo+Pj4+ICsNCj4+Pj4gKwlCVUdfT04odW5saWtlbHkoc211LT5zbXVf
ZGVidWdfbW9kZSkgJiYgcmVzKTsNCj4+PiBCVUdfT04oKSByZWFsbHkgY3Jhc2hlcyB0aGUga2Vy
bmVsIGFuZCBpcyBvbmx5IGFsbG93ZWQgaWYgd2UgcHJldmVudA0KPj4+IGZ1cnRoZXIgZGF0YSBj
b3JydXB0aW9uIHdpdGggdGhhdC4NCj4+Pg0KPj4+IE1vc3Qgb2YgdGhlIHRpbWUgV0FSTl9PTigp
IGlzIG1vcmUgYXBwcm9wcmlhdGUsIGJ1dCBJIGNhbid0IGZ1bGx5DQo+Pj4ganVkZ2UgaGVyZSBz
aW5jZSBJIGRvbid0IGtub3cgdGhlIFNNVSBjb2RlIHdlbGwgZW5vdWdoLg0KPj4gVGhpcyBpcyB3
aGF0IFNNVSBGVyBndXlzIHdhbnQuIFRoZXkgd2FudCAidXNlci12aXNpYmxlIChwb3RlbnRpYWxs
eSBmYXRhbCkNCj5lcnJvcnMiLCB0aGVuIGEgaGFuZy4NCj4+IFRoZXkgd2FudCB0byBrZWVwIHN5
c3RlbSBzdGF0ZSBzaW5jZSB0aGUgZXJyb3Igb2NjdXJyZWQuDQo+DQo+V2VsbCB0aGF0IGlzIHJh
dGhlciBwcm9ibGVtYXRpYy4NCj4NCj5GaXJzdCBvZiBhbGwgd2UgbmVlZCB0byByZWFsbHkganVz
dGlmeSB0aGF0LCBjcmFzaGluZyB0aGUga2VybmVsIGlzIG5vdCBzb21ldGhpbmcNCj5lYXNpbHkg
ZG9uZS4NCj4NCj5UaGVuIHRoaXMgaXNuJ3QgcmVhbGx5IGVmZmVjdGl2ZSBoZXJlLiBXaGF0IGhh
cHBlbnMgaXMgdGhhdCB5b3UgY3Jhc2ggdGhlIGtlcm5lbA0KPnRocmVhZCBvZiB0aGUgY3VycmVu
dGx5IGV4ZWN1dGluZyBwcm9jZXNzLCBidXQgaXQgaXMgcGVyZmVjdGx5IHBvc3NpYmxlIHRoYXQg
YW5vdGhlcg0KPnRocmVhZCBzdGlsbCB0cmllcyB0byBzZW5kIG1lc3NhZ2VzIHRvIHRoZSBTTVUu
IFlvdSBuZWVkIHRvIGhhdmUgdGhlIEJVR19PTigpDQo+YmVmb3JlIGRyb3BwaW5nIHRoZSBsb2Nr
IHRvIG1ha2Ugc3VyZSB0aGF0IHRoaXMgcmVhbGx5IGdldHMgdGhlIGRyaXZlciBzdHVjayBpbiB0
aGUNCj5jdXJyZW50IHN0YXRlLg0KDQpUaGFua3MuIEkgZ290IGl0LiBJIGp1c3QgdGhvdWdodCBp
dCBpcyBhIGtlbmVsIHBhbmljLg0KQ291bGQgd2UgdXNlIGEgcGFuaWMoKSBoZXJlPyANCg0KUmVn
YXJkcywNCkxhbmcNCg0KPlJlZ2FyZHMsDQo+Q2hyaXN0aWFuLg0KPg0KPj4NCj4+IFJlZ2FyZHMs
DQo+PiBMYW5nDQo+Pg0KPj4+IENocmlzdGlhbi4NCj4+Pg0KPj4+PiArDQo+Pj4+ICAgIAlyZXR1
cm4gcmVzOw0KPj4+PiAgICB9DQo+Pj4+DQo=
