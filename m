Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA8BC47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 08:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A78B11252A;
	Mon, 29 Jan 2024 08:35:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BFD11252A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 08:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn4Kx4zD+hnzLrdkvpnRz9tKQGRp62iIUhF+BDTdyWHKnVFl+YZ4mKi3OIlnc/1Bv2rCc2ntd17M5Unl8xZ+p8jho3/disBXogSoJS99CMycMWCTWKOHeG9263Z0AvADkjUMPRHCBynseA++D3/lj2G6boUxctdA93SM+mpGlan7nw0bmh4myS7ztYDRYPQG8HxjWCGESmQt80xbJPTdXb5PcWjnPejdRbSnCC6EThXFmT1nvQ8NecXEf7L9ZnKHZH0AWnMNjvMQvOTWilY0YU/ija3AkQ1Sohb0lO8qMF+DArxXwa3KkfcDg2kPbXn/1zdDzMrVsNGdLBo8rbGbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZjxDseQC4NBTuImFt9/TPn5B+9cyRtL8veUDWeUw40=;
 b=gMoeZfmM47v4yXDRb6QoIBwcMKT8zOKrJfYUDFR8HtCFyDrT9Hrk8QDxN+QCX93rxcZF6IQPT831j1I01b8oL6SvSeMbB4pyzjP6ASR9EfgkVFyVlHd43qVh9CyLcK0TqXL30yo7CWM0qfr5AeqDCpqGm5SY2hAS/+5nfOe1IQc4/SBR5B9Y2yH8tdh2eSKBoLs7BZxIwlhR2KkbSuQg6CDHt+VVNSo01+TShDbb9XJSHkDzevFISuFutQTtRGOopHKU4czpDCQgEw8JHrolB51pGDVGYKrIFiYcVoVaiOvVoZlxnaeIoBeUgS77hbf7nxRTN7f9Fbscp38DBE5ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZjxDseQC4NBTuImFt9/TPn5B+9cyRtL8veUDWeUw40=;
 b=Yt25mdf7OWjXl1M7Dd3DG2ESYfNieY45FpmE1Byk/dLPfO6EJwE0UcNi+BaQJhhKHtnCorkUhJJGqwXh1AIS5AionJL2scS/pBR/RtkD0w+rI97EpQyd1TeprNipuBr3DGQ/RCAQnb6XLdW7JDlUhGfu+nAoaaxzv2oqd6IMsok=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Mon, 29 Jan 2024 08:35:02 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:35:02 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM
 abort case
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM
 abort case
Thread-Index: AQHaTpLvhtO6qUfupU2bLdsybleF97DpH1qAgACs9UCAANsWgIAAAHoAgACsJpCABSl2MA==
Date: Mon, 29 Jan 2024 08:35:01 +0000
Message-ID: <DS7PR12MB6005009D906D1E0FA821F23FFB7E2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240124065932.892944-1-Prike.Liang@amd.com>
 <CADnq5_PJyh50wpHQuU_UFYvpnnp8PsteAJ7ymazFHMWD92cyDw@mail.gmail.com>
 <DS7PR12MB6005078B67C8122627CAA45DFB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_P0NJ7Vd1LBbECxf-1X-s3BOdYb0Q4FjEQe9TptjX_j9A@mail.gmail.com>
 <CADnq5_PO-gnc72wRM+mUxtCnsmqE0ytFVbB=QkMQkEGkCQoQFg@mail.gmail.com>
 <DS7PR12MB6005C4B4C4ECE48DB61418FBFB792@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005C4B4C4ECE48DB61418FBFB792@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Tim.Huang@amd.com,Jesse.Zhang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=22c7e5a8-bc7b-466e-9577-c546cefb5665;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-26T01:40:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS7PR12MB5815:EE_
x-ms-office365-filtering-correlation-id: 8d600686-a752-411c-546a-08dc20a52f9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mVB3ojFrGhnOOjm4Bs1L+qdlyC09lW11GSTCeI4zzt4f0dhigFpCNFaCksTdbyMRezLVg76XcFhotuuwYvA32Y4pjW8lxVojJOSr9cfxOSdWK0zko2vxUczy44AOqu/mrWLAqFbbQuQ07fMmH/yOpWPG7JZ61CiZDBDxhPm7JT9GH/6uR0jrsgpgu3/UVg7966OKCA7NvU/DZoya6uNkKs+44mMAZjdYVFnYk/pmXPLYBr/QvFBetz3iaDLsMKgKA+3028pk9BkZ7zwk5fhRhaVA5+3iBM6DWKXIMEMADZfOzMZP/5s0s3VEmGHqzQ2qyVpWzJ8C5NaRfkPAHl7surqVgPaqkiGIfQ9pIx94I2DwjqGYaoRwVAUlaOYmbXJC8OSZye2vmYMlJ3A/rGE7WPxKDLuw0uJ0ZouovCh31zOtMU00Oh6kx4WE5GhcUfb9Rja9z1mQgAzJ+VLl1+U7TPMYc2r2SPLAavluU1dXCO04I3UWJW66BSzyn6jmD+PPpvhnD1xTj9fXvYNSgIA0rF0m62afglwq0cZCTOt5LVOrHZD0Ygnlotou/mdBjZlDR1ItRxair6rUWEQN1fnfDMVQ/kYE7YGLV5W0QTGBQS8jm1DccmdhGL03cdTu9K0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(83380400001)(33656002)(86362001)(38070700009)(122000001)(38100700002)(26005)(9686003)(53546011)(7696005)(6506007)(2906002)(478600001)(41300700001)(110136005)(76116006)(6636002)(316002)(71200400001)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(5660300002)(8936002)(4326008)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXJDNStMbVBQOHAxMVNDeUpJUmhRK3ViWjFBeFAvWTk5djlhaFRpaUJ1NVJU?=
 =?utf-8?B?RkxoM1FGUEVwZU4vMW1LZmRMUWhwWmxxU05kbXByTTVZckhEdDNsTk9GWGVD?=
 =?utf-8?B?S0dyYWI2RE9yUlUyeUFkZXVhM3VEcUFUSnhoZ0RYTjRDYit4TDJmbGhDSU9v?=
 =?utf-8?B?bHllbW4zbnAxZGdkbi9OTUh3RDFyVzBsSXlWSEVFMit0ZkU1UU84MjREZE5L?=
 =?utf-8?B?M3pZNXJZUmtIeWs5eHd0NkM5Y01sZzI1dTlOeUdjQnVzY2I5N25ZbGhkMjdH?=
 =?utf-8?B?RzBtU0RKSGpsaWNzV3dkUGVHa2w2TGFrTWtSVk02WlhoOW9EZmR3U3VrVjVs?=
 =?utf-8?B?Vk5WUk56SHRoMUhNeXJRRnBhOVpyYTNLU3drWE9pdVRkSHMvcm1PakpwSDBx?=
 =?utf-8?B?aUNKZFlwM3Q0SEI2ajhadzJRakpvYmVNYXd0ei8rY2pHamx4SThVR3kxdmNL?=
 =?utf-8?B?YXRaZDZCOC91Q04xN3lNTTlFVmtTOXROZVRONG1ON1BqWHRUbU5id2ZTMmIy?=
 =?utf-8?B?M2M2NytETU5Bem05Y0tzaDNPcThzNEhFZTFqRU9EamJWUkZYbU54N3NVUFdM?=
 =?utf-8?B?SWh1bm1oVEdkK2pFYTBMUk9KZTAwd3FmKzIzSHJaOUU4ZURQQ1oybzZJUS9q?=
 =?utf-8?B?UVB4K0RKNm9YdWVtK1pHRTVBRzkrSTlxWS85M1NJdzc0aHJHYTdjTk10clFM?=
 =?utf-8?B?TmxHTlRLSWtQNjc5WU1FcXU5L3N4ZjMzb1loaUc1NFllTVA1a1JKZXJWYVVk?=
 =?utf-8?B?WkMrS2dvY1kzVDF6U1BQYkwyUWlJaDE0R09HZEZNSmYydEM3QXNOZjZKd2hi?=
 =?utf-8?B?S0R5V3JYdkl6dEIwajlyOWQyZWdGOExHYzFNN3FSK2tkYkx2ME9EWVRCMDd6?=
 =?utf-8?B?RnJZRkpDaUdBWXZnNUwrVmxXdlpSZERSMWl5cmU1OS9KS0UyWFFVOFY5RFBx?=
 =?utf-8?B?WG14ZGNvZHdqdUplY1IwSmd5TDlnWkROekNJajZjVDh3T2xQRktLdnRPKzNp?=
 =?utf-8?B?SWk4emEvaDB4WTdMeUhPYllIcWdUZCtYTEtsYi9OZWtLQktiQ0hFTGI1SVFn?=
 =?utf-8?B?Rk00dGllcGdNTENrN0NsZk9QQ05PTHdvNHNRL2hFdjVWK1l3MktGdVJmc2g1?=
 =?utf-8?B?bXpyUThHL2JVWUlYVE4wY3ZFTWpOelF3VUZ2aDkrRkorOWZnN1RrMlhpdjVr?=
 =?utf-8?B?Y2Vqa3h4c0w1dEZNQUxRSGFBTmxsU3NqZm1lUmdqWXpGbk02VzBIMVJpbjla?=
 =?utf-8?B?M2JoWVJGWUlPZ1YyN2tzNHlzK0YwTldLdUFXTFh4MjJJTW5TY2xwVlh1bkR5?=
 =?utf-8?B?U0NxZUVrWWlMZ0ZFQXlEWmVUcE5xME1LdDdQQit4OEtNUTlheGZncXpYUVcr?=
 =?utf-8?B?ZFcxNE91OEhQUGJDdjVRdXJ6QjRIUDNHTkdud3hLMjdBUzBYWVZtcm1aN21J?=
 =?utf-8?B?c3pkWFQyY05JZlZQeVUwOEpDUUNyQU9jSzdIR21WRmVFRFduVTFvTFpKZkxS?=
 =?utf-8?B?SHQ5aWdMVW1tVWZRMVZLT3QxVGYyOUhWMC9nYlF1SERxeXBZRUs3cmVxSTkr?=
 =?utf-8?B?bW9TZDdCMmVIRndCQUNIUTRRa3gyZExoTXR1bTdNeStzT2xLTlAzRzltUVVl?=
 =?utf-8?B?dXdaMVA2Z3hHNngrWmxkVldQcG5LVVBKQnhMUFdKSk9DMGtyM1ZsYXFGOU1M?=
 =?utf-8?B?dEo3aXUyOHRHZGE0amx2aE5ZSCt2Z2k0VjhkMTBCOWlXSmR6L1dBU3RrcTRl?=
 =?utf-8?B?K0RJOGIzY0FmZDBEbncyVUhHcEFXZzN5bnBkQlVXUldkZnJHZmlMaXEwdlVZ?=
 =?utf-8?B?aW9KR0pTSndxSFRlUE5wV2ZhbEYwTHJmZVh3NW5tV1UvRHVIdENObWlBUGEw?=
 =?utf-8?B?cjMxNlVtY2poYzRtazg5SjZZaUVyMVVsNUZNN3RQWTJ2S2hhcDBwZXdrZjR5?=
 =?utf-8?B?ZGR4eWp4VUxWMWhtQjJGMkdvYzRDcVVId2NONDl6U0U3WWQ2Wkl5YS9pdVZW?=
 =?utf-8?B?RTNXOUViR09OQ21xa05CUjA2ZDBrZjBxdFhNamVpN1JVQVlTSllJOXcxM0d3?=
 =?utf-8?B?UW9WNnB4WHZMM21EYnd1VWlQbnFiV05BZXE2R29qK2JVaE9VUEM5V3FzcGZ1?=
 =?utf-8?Q?uibQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d600686-a752-411c-546a-08dc20a52f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:35:01.9981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWi0jKD4Q7TjTkghUxBydx+JyDCHj7MO+odhw4s9rYWlyVruuhQ46WHLcehc4uX9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Deepak" <Deepak.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gU2VudDogRnJpZGF5LCBKYW51
YXJ5IDI2LCAyMDI0IDk6NDMgQU0NCj4gVG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPg0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgU2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5TaGFybWFAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8yXSBkcm0vYW1k
Z3B1OiBza2lwIHRvIHByb2dyYW0gR0ZYREVDIHJlZ2lzdGVycyBmb3INCj4gUE0gYWJvcnQgY2Fz
ZQ0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4NCj4gW0FNRCBPZmZp
Y2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+ID4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMjUsIDIwMjQg
MTE6MjQgUE0NCj4gPiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+
IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+
ID4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTaGFybWEsIERlZXBhaw0KPiA8RGVlcGFr
LlNoYXJtYUBhbWQuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1
OiBza2lwIHRvIHByb2dyYW0gR0ZYREVDIHJlZ2lzdGVycw0KPiA+IGZvciBQTSBhYm9ydCBjYXNl
DQo+ID4NCj4gPiBPbiBUaHUsIEphbiAyNSwgMjAyNCBhdCAxMDoyMuKAr0FNIEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFdl
ZCwgSmFuIDI0LCAyMDI0IGF0IDk6MznigK9QTSBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFt
ZC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBHZW5lcmFsXQ0KPiA+ID4gPg0KPiA+ID4gPiBIaSwgQWxleA0KPiA+ID4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDI0
LCAyMDI0IDExOjU5IFBNDQo+ID4gPiA+ID4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdA
YW1kLmNvbT4NCj4gPiA+ID4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA+ID4gPiA+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
U2hhcm1hLCBEZWVwYWsNCj4gPiA+ID4gPiA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPg0KPiA+ID4g
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBza2lwIHRvIHByb2dyYW0g
R0ZYREVDDQo+ID4gPiA+ID4gcmVnaXN0ZXJzIGZvciBQTSBhYm9ydCBjYXNlDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBPbiBXZWQsIEphbiAyNCwgMjAyNCBhdCAyOjEy4oCvQU0gUHJpa2UgTGlhbmcN
Cj4gPiA+ID4gPiA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBJbiB0aGUgUE0gYWJvcnQgY2FzZXMsIHRoZSBnZnggcG93ZXIgcmFpbCBk
b2Vzbid0IHR1cm4gb2ZmIHNvDQo+ID4gPiA+ID4gPiBzb21lIEdGWERFQyByZWdpc3RlcnMvQ1NC
IGNhbid0IHJlc2V0IHRvIGRlZmF1bHQgdmF1bGUuIEluDQo+ID4gPiA+ID4gPiBvcmRlciB0byBh
dm9pZCB1bmV4cGVjdGVkIHByb2JsZW0gbm93IG5lZWQgc2tpcCB0byBwcm9ncmFtDQo+ID4gPiA+
ID4gPiBHRlhERUMgcmVnaXN0ZXJzIGFuZCBieXBhc3MgaXNzdWUgQ1NCIHBhY2tldCBmb3IgUE0g
YWJvcnQgY2FzZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlr
ZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICB8IDEgKw0KPiA+ID4g
PiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDEgKw0KPiA+
ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICB8IDQgKysr
Kw0KPiA+ID4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oDQo+ID4gPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oDQo+ID4gPiA+ID4gPiBpbmRleCBjNWYzODU5ZmQ2ODIuLjI2ZDk4M2ViODMxYiAxMDA2NDQN
Cj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+
ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+
ID4gPiA+ID4gQEAgLTEwNzksNiArMTA3OSw3IEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsNCj4g
PiA+ID4gPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbl9zMzsN
Cj4gPiA+ID4gPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbl9z
NDsNCj4gPiA+ID4gPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bl9zMGl4Ow0KPiA+ID4gPiA+ID4gKyAgICAgICBib29sICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBtX2NvbXBsZXRlOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgICAgZW51bSBw
cF9tcDFfc3RhdGUgICAgICAgICAgICAgICBtcDFfc3RhdGU7DQo+ID4gPiA+ID4gPiAgICAgICAg
IHN0cnVjdCBhbWRncHVfZG9vcmJlbGxfaW5kZXggZG9vcmJlbGxfaW5kZXg7IGRpZmYNCj4gPiA+
ID4gPiA+IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+
ID4gPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+
ID4gPiA+ID4gaW5kZXggNDc1YmQ1OWM5YWMyLi5hMDFmOWIwYzJmMzAgMTAwNjQ0DQo+ID4gPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiA+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+
ID4gPiA+ID4gQEAgLTI0ODYsNiArMjQ4Niw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gPiA+IGFt
ZGdwdV9wbW9wc19zdXNwZW5kX25vaXJxKHN0cnVjdA0KPiA+ID4gPiA+IGRldmljZSAqZGV2KQ0K
PiA+ID4gPiA+ID4gICAgICAgICBzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2RldiA9IGRldl9nZXRf
ZHJ2ZGF0YShkZXYpOw0KPiA+ID4gPiA+ID4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IGRybV90b19hZGV2KGRybV9kZXYpOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICsg
ICAgICAgYWRldi0+cG1fY29tcGxldGUgPSB0cnVlOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhp
cyBuZWVkcyB0byBiZSBjbGVhcmVkIHNvbWV3aGVyZSBvbiByZXN1bWUuDQo+ID4gPiA+IFtMaWFu
ZywgUHJpa2VdICBUaGlzIGZsYWcgaXMgZGVzaWduZWQgdG8gaW5kaWNhdGUgdGhlIGFtZGdwdQ0K
PiA+ID4gPiBkZXZpY2UNCj4gPiBzdXNwZW5zaW9uIHByb2Nlc3Mgc3RhdHVzIGFuZCB3aWxsIHVw
ZGF0ZSB0aGUgcGF0Y2ggYW5kIGNsZWFyIGl0IGF0DQo+ID4gdGhlIGFtZGdwdSBzdXNwZW5zaW9u
IGJlZ2lubmluZyBwb2ludC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICBpZiAoYW1k
Z3B1X2FjcGlfc2hvdWxkX2dwdV9yZXNldChhZGV2KSkNCj4gPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICByZXR1cm4gYW1kZ3B1X2FzaWNfcmVzZXQoYWRldik7DQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMN
Cj4gPiA+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiA+
ID4gPiA+ID4gaW5kZXggNTc4MDhiZTZlM2VjLi4zYmY1MWYxOGUxM2MgMTAwNjQ0DQo+ID4gPiA+
ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4gPiA+
ID4gPiBAQCAtMzAzNCw2ICszMDM0LDEwIEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfY3BfZ2Z4X3N0
YXJ0KHN0cnVjdA0KPiA+ID4gPiA+ID4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiAgICAgICAgIGdmeF92OV8wX2NwX2dmeF9lbmFibGUoYWRldiwgdHJ1ZSk7
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gKyAgICAgICBpZiAoYWRldi0+aW5fc3VzcGVuZCAm
JiAhYWRldi0+cG1fY29tcGxldGUpIHsNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBEUk1f
SU5GTygiIHdpbGwgc2tpcCB0aGUgY3NiIHJpbmcgd3JpdGVcbiIpOw0KPiA+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBXZSBwcm9iYWJseSB3YW50IGEgc2ltaWxhciBmaXggZm9yIG90aGVyIGdmeCBn
ZW5lcmF0aW9ucyBhcyB3ZWxsLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxleA0KPiA+ID4gPiA+
DQo+ID4gPiA+IFtMaWFuZywgUHJpa2VdIElJUkMsIHRoZXJlJ3Mgbm8gaXNzdWUgb24gdGhlIE1l
bmRvY2lubyBzaWRlIGV2ZW4NCj4gPiA+ID4gd2l0aG91dA0KPiA+IHRoZSBmaXguIEhvdyBhYm91
dCBrZWVwIHRoZSBvdGhlciBnZnggZ2VuZXJhdGlvbnMgdW5jaGFuZ2VkIGZpcnN0bHkNCj4gPiBh
bmQgYWZ0ZXIgc29ydCBvdXQgdGhlIGZhaWxlZCBjYXNlIHdpbGwgYWRkIHRoZSBxdWlyayBmb3Ig
ZWFjaCBzcGVjaWZpYyBnZngNCj4gcmVzcGVjdGl2ZWx5Pw0KPiA+ID4NCj4gPiA+IE1lbmRvY2lu
byBvbmx5IHN1cHBvcnRzIFMwaTMgc28gd2UgZG9uJ3QgdG91Y2ggZ2Z4IG9uIHN1c3BlbmQvcmVz
dW1lLg0KPiA+ID4gVGhpcyB3b3VsZCBvbmx5IGhhcHBlbiBvbiBwbGF0Zm9ybXMgdGhhdCBzdXBw
b3J0IFMzLg0KPiA+DQo+ID4gRS5nLiwgdHJ5IGFuIGFib3J0ZWQgc3VzcGVuZCBvbiBSYXBoYWVs
IG9yIFBIWDIuDQo+ID4NCj4gPiBBbGV4DQo+ID4NCj4gW0xpYW5nLCBQcmlrZV0gIFRoYW5rcyBm
b3IgdGhlIHJlbWluZGVyLCBidXQgdGhlIE1lbmRvY2lubyBhbHNvIHdhcyB2ZXJpZmllZA0KPiBv
biB0aGUgc3lzdGVtIHdpdGggUzMgZW5hYmxlZCBmcm9tIEJJT1MuIEkgd2lsbCBkb3VibGUgY29u
ZmlybSBpZiB0aGVyZSBuZWVkDQo+IHRoZSBxdWlyayBvbiB0aGUgUlBMIG9yIFBIWDIuDQo+DQpb
UHJpa2VdICBBY2NvcmRpbmcgdG8gQFpoYW5nLCBKZXNzZShKaWUpIGFuZCBASHVhbmcsIFRpbSBm
dXJ0aGVyIGNvbmZpcm0gdGhlcmUncyBubyBzdWNoIHByb2JsZW0gb24gdGhlIFJQTCBhbmQgUEhY
LCBzbyB3ZSBtYXkgb25seSBuZWVkIGFwcGx5IHRoaXMgcXVpcmsgb24gc29tZSBzcGVjaWZpYyBn
Zng5IHNlcmllcy4NCj4gPiA+DQo+ID4gPiBBbGV4DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+
ID4gICAgICAgICByID0gYW1kZ3B1X3JpbmdfYWxsb2MocmluZywgZ2Z4X3Y5XzBfZ2V0X2NzYl9z
aXplKGFkZXYpICsgNCArDQo+IDMpOw0KPiA+ID4gPiA+ID4gICAgICAgICBpZiAocikgew0KPiA+
ID4gPiA+ID4gICAgICAgICAgICAgICAgIERSTV9FUlJPUigiYW1kZ3B1OiBjcCBmYWlsZWQgdG8g
bG9jayByaW5nDQo+ID4gPiA+ID4gPiAoJWQpLlxuIiwgcik7DQo+ID4gPiA+ID4gPiAtLQ0KPiA+
ID4gPiA+ID4gMi4zNC4xDQo+ID4gPiA+ID4gPg0K
