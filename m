Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E38AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 15:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8956F10E3F3;
	Tue,  1 Nov 2022 15:32:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F5C10E3F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 15:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rvg26jbz88hE6eZ+/WhQ6TcXIHTLi9p5JCslyNabCSj8N3bheiN7XDLJ9ixSlmk8wRsTnvdnwL9RCcja/6Iaz1g+SOgPGm1xAZk15vyJC3BXV2AU5jSeqv5ipBqJhaZ0/wGNI8SBP4v0DM/sDpSbocADAFJ+tVnx9H3sPKqOCEruMeEGOlGRbPgu+F4udk7stSC2DfHJs2nLlZDxyFo0jErd0CqBw+WPMoULJLERlsCa0m7jk+CD4CL1yx58HInhR7khXqtUDjbc2DVZnnyq7h8V5wQqT+soJQ8Vl5aW6TiptgZ33JxDGSmBPE6cZe8CkuoWu5G91bbKJykKC0Xk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryDID00cFy41bVLwN3zak9pZODnV1nh1YyZ8Ud3NxQ8=;
 b=Qc3WdkH468UzmvxGO4a8MWPniu5DNUB2y95NNerXYiMO141MwglmIB3cezMBfLUEdTDVzuf6fIryBt1PvLOBPbYWQvpafjXchX+iT6iphM1rS98hrAxNdgIq5YDnY6fOfGp+jWPRTuZKT8J1N4APhuGcZFIIgXdNqhCPFEYWV+zAqGQSvwFPdfvkTfLmA6tQTuFqydwR/CHTHIIhOip/bKMCWU6OApK4U1qxDtaGlL3FFGIkjs2Nl82YFgEMIjEetthhB5Ud8VCTljqrSqLkZt6fyuLUeMLGXKuztVwcDDz5BdMifbx1W59ybJ83+NxDS4JNewlKmWKldHQdASiQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryDID00cFy41bVLwN3zak9pZODnV1nh1YyZ8Ud3NxQ8=;
 b=yjWnxMV8ilb8gq33wEOx60/CaouPlzeQErWltOD3vtyG3GePjQBHxtI6/AkHUA26sW3zuNLiIC9/DTKCQdUBVGFjTeYRuYaDaakhpokCwXWjuwsVirIFv5zF47vCt4SkT5wvFlVxF4b87n5E7gt3i+GR18Rftqyz98dj0ZlKK5k=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 15:32:24 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%6]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 15:32:24 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery path
Thread-Topic: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery path
Thread-Index: AQHY7bEXefy5aQPwFEmX0bSlrGH91a4qDtSAgAAAj4CAAB+HEIAAAgEAgAAAQXA=
Date: Tue, 1 Nov 2022 15:32:24 +0000
Message-ID: <DM4PR12MB52784699652809AB51F018D79C369@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221101051450.1261693-1-Perry.Yuan@amd.com>
 <20221101051450.1261693-2-Perry.Yuan@amd.com>
 <CADnq5_M-Xa=4E5M8HdBrYnd4CT2cRabwJ=2kNrBTbFj81ETdag@mail.gmail.com>
 <CADnq5_MtoWMSy-YWp3mL805SOdpS0hJnbV0xo61YvtDFZ4RB_g@mail.gmail.com>
 <DM4PR12MB527832A011FA4DC91A6333109C369@DM4PR12MB5278.namprd12.prod.outlook.com>
 <CADnq5_PJwxwJ7NM4yRcKO1CJqjJCc6yPjZfM3QOE3ThNTC0Fgw@mail.gmail.com>
In-Reply-To: <CADnq5_PJwxwJ7NM4yRcKO1CJqjJCc6yPjZfM3QOE3ThNTC0Fgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-01T15:26:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7964faf9-85d1-405b-b7c0-c2ab333f5171;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-01T15:32:20Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7112cb83-b7f8-4852-8a31-5af4e885122d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH0PR12MB5091:EE_
x-ms-office365-filtering-correlation-id: 79c2a0cb-a382-4a28-3018-08dabc1e4656
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IyaAt0/JGcNeHyhQGCRPlHisaFwVVXaUL3rQty70gAIsWKKutOkhKXOXQFibA7Pkf7PReD1ndao4JuwJnefqJnKj778nlOR7xbo9tGANrdqEfud4RRkF8J4xukhWCK3bKjDfO3OMO5SMBo3vk9PhA96p12ivLK43J+NSwyaZR5lTKNYCZEuBIcDSUh0Pkewuyb0rEEvsx2r4SYLFdYqeVl8g/pDQl8sDEOMHcu8qlAGb4KubIfGZwe/XBTp+IXCSvzk++MCcZ3idyOoEyD0udoMB9bbnFIIr5UgGqPROtL334A2JrwEx9F7/iTLxERS4J3ejjP3m//CA9o0KbKPRGl2oCvXpa+jV/r8zb/kvpqhJyPim351dHVDBXLtGMdnFJ9Fo0b/ToqzAYHyUu3wdA+1WbsrXcNxka2IKwHnPyiODlSNAK3NqZSPuA5XOm+E7Ik4yOnu1cc6vY21jJjRRyCmx3f+LUjBJf782LLF+qusXa5spDtONxJyxNVWHA2yautz0BMryjUAekwnVunrHSR2K4FUe/F3AY6zXuKftVqxVivNteBvTjXrlMAUY+kHvSeq0f8G8xTda+TCjd6lSiltckx7FYT/GjgbzJlrxQv1khD7nNRIvlmIYfRD/i108NYzBtg9w52KQ2JmQSiGRJ7sZc/Srp+wgPlWEnulsCJXmZczJrhHlbuseo4Nb3gPcVVBbo35AK//+9rgoTDZ4TK6igh2ge5ZjRhn06e86I7MBl0GPp/vNw0NTyvxt/9hBIC6eRck9NMtLPt6Uw/aGCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5278.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(6506007)(7696005)(52536014)(38070700005)(8936002)(53546011)(33656002)(2906002)(5660300002)(41300700001)(26005)(9686003)(86362001)(478600001)(66556008)(38100700002)(64756008)(76116006)(66946007)(66476007)(6916009)(66446008)(4326008)(8676002)(186003)(122000001)(54906003)(71200400001)(55016003)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmEyQy9wZ3JzMEVlbk9tdFRaM1VKNnBkV0Y3S2hXem5nWEk0ZUgwaU9yU0Ru?=
 =?utf-8?B?WElOckd3KzZhSHZKQW5TT3VsOGFPaEttSzRFcUNveS9zNWdzY1FIcWp5UTVT?=
 =?utf-8?B?RW01ZzhrWURaV2RxRTQ5QzY2L3N0RnZTSWEwdUFLTTR6a09hZitDaGo1Ykc4?=
 =?utf-8?B?MzBqU0RjZjNGcmJKVmQ2RmFJbTBMSUN6QytDd0hFSDFlOGMrZ09qQlpibDFy?=
 =?utf-8?B?L0dYK05YbWM1ZndieXo4bGcyVVdYTU5jMVo3SmVEakNBRVhKRnJhem1rdm9s?=
 =?utf-8?B?ZnNwZDdiRVdWS0VZMWFVR3hyaDhrcEdCRTlqTXlheWdDYmpJdUlQeXVnRTBt?=
 =?utf-8?B?V1VZZ3A5S1FlQ2lWcUdiR29xV0Evc2dWb0FWaE1qbFA2MVdBQmxPMFJvamZt?=
 =?utf-8?B?c2xiOFdiUGdlQUZ0Vkh4R1dCQWt4SHVJa1BWdFJtNHN1V0gyY0luMjIrYTVl?=
 =?utf-8?B?UTVMaStUaHRJekdyYVpVQnljTjNkWXBtSHNpRVJ4cmZObDFKejhvT3JiTnAv?=
 =?utf-8?B?ejFPN1hlbW1nKzBNeVRDQXhycm1hUGo3RHdNZy9TWjN4dENOS3ZXSURvODBC?=
 =?utf-8?B?cTE0SGE2aVJyV0ExUDBRRzZib0xCeWN2Wkp3UXBFc2tPaDRRSmtPSXRwUE84?=
 =?utf-8?B?ZUZ3RnBPTTJyVmJJYU4wcnhZZnYxVEpaQTdZWmRIWG5IVndLTVdUb3ZXSlNk?=
 =?utf-8?B?SFJsNTZzaHdWLzN0ZGp1Zy9GWmFlNVRBTnhQcGsrcWRidjBuS1ZaUnFvMHdX?=
 =?utf-8?B?bStiZmRCNEwydElnUkgvY2tqQnJudXJTWnZ5UThTK3QzeE93UzA2UXk5d3A3?=
 =?utf-8?B?WWNLYVRaWVVkS2M1cU9kUWNNLzEvd01ITGhFRm5pczB0emJDZG1BaDhKQlpk?=
 =?utf-8?B?QVprZHcwV1BHaTgrNkhnSFlHcmNPTnMzeFlXUkJmQlU0SkJFNHpMWklBN0Vv?=
 =?utf-8?B?ZEliVmNITUFYZWRVcWZKU1RIbmdYb2dYWVlKZXMvTTh6ZnV1RmhqZ00wcDM4?=
 =?utf-8?B?NDJJbE9vdDdLNE1ObWtwemw3K28wNlB5ai92UDhkdXY1KzJiWlVqT0RHeG9u?=
 =?utf-8?B?TVlqc3ZNVWFlVGtzbjNEbldzYksyY0dtcWtSNlpRcVhpaHlxOTJUbVArcEZm?=
 =?utf-8?B?c0NlSDljV1JiWjMzaEJqNlA3WXFROVlzZnFQcFAwZGVyVkZwTXJKdkVQVFpm?=
 =?utf-8?B?NWErZmxuWXF1K1gvYXFBU1hDYytWMzcrR00vRjlnbTNpamJ1Y3ZpWTBHT2Zw?=
 =?utf-8?B?R05xbjl2TDVOUDJSRWdKTVdaQ2lYQ0VYRlBvUVpUMjRaWU5ZN1pLUE5FY05G?=
 =?utf-8?B?SGlKOE1neTI0T2JzYkFCNGhYaVJRdHk2dm9HckNLQ2dZUTUvT2xzYW52cFQv?=
 =?utf-8?B?L0ZsYlN0YmVOcHFhaWVTeFVsTGxIc05BZ0NJV1p3YWRUeURqOVVsajhLS3BV?=
 =?utf-8?B?MkRldk1oV1VrejUxaUFzS0NkWUFYa3pJdTNzcjhNaWV3MG9NKzlnbDdIeHpE?=
 =?utf-8?B?TG43WE8za1R5ekNJc2tOa3ViR1lXVTdicGR2TnRVTGZjOFZ6T3F3WENrRnJl?=
 =?utf-8?B?NEN3UVZld2IrS0tLbFI1TmYrN0FBQjE5OHlsNXlOWTIwSzQwMUdtQmd3N2VH?=
 =?utf-8?B?QjlFTHNXNS9SNU5KZUFkZko2V1J6LzhhQzlkZUp2YzNoU3pIWldCTXpsbUoz?=
 =?utf-8?B?U1JhZ2ZLTklLRkhUMnBkbklNWHZLTXg1K2Uza3VTN24veEwycnUrSDBHQWMr?=
 =?utf-8?B?OXhYTEdOQzVMM2JCMnA0Ti9PVkZXU2wvejc3eWdycnpraVJyYWFFV09SSXk4?=
 =?utf-8?B?MkNESHQycm5RMnM5OFJHc2xVSWNRdm9FM2JQSEFXSFo4V0JXbUpPRmZXTDZO?=
 =?utf-8?B?anVnUWxkV1lCQ3BOdkN6Yys4RnBsTkxHQmU1SFczZXdnSTRBdHpwM3F6YTRM?=
 =?utf-8?B?ZHcrM0FsTnJYWTZLUkwzNklXbFhMaktnSkZ4NVNLNVNSanhnYXhLdm9aVXp2?=
 =?utf-8?B?MnJ5QUlrQU14dHFMbWIrODdpS3piMkx4OTBNV2Zjc0VCN3NKRllCd1VHaCty?=
 =?utf-8?B?aUtWd01Ecm5XUll3QXJxVk5pclVucHNGT3RIYmtCLzdZZjY3VUhTWUE0N0lz?=
 =?utf-8?Q?zL9xJJroLRoKsvAwqw/0iVzyR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c2a0cb-a382-4a28-3018-08dabc1e4656
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 15:32:24.1034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kir05B3XRAcRs/axhhblvhR/7keo9CK5H2X/12M9bUCpzuWPaoa2TCVGH4H1HZW4BpZNZNgPWxuTnIZc4DujZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Shimmer" <Shimmer.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXguIA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxLCAyMDIyIDExOjI1IFBNDQo+
IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFJheQ0KPiA8UmF5Lkh1
YW5nQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lciA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsNCj4g
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IGRybS9hbWRncHU6IGFkZCBWYW5nb2doIEFQVSBmbGFnIHRvIElQIGRpc2NvdmVyeQ0KPiBwYXRo
DQo+IA0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFs
IFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywg
Y2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+IA0KPiANCj4gT24gVHVlLCBOb3YgMSwg
MjAyMiBhdCAxMToxOSBBTSBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBHZW5lcmFsXQ0KPiA+DQo+ID4gSGkg
QWxleA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mDQo+ID4gPiBBbGV4IERldWNoZXINCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEs
IDIwMjIgOToyNSBQTQ0KPiA+ID4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+
DQo+ID4gPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgSHVhbmcsIFJheQ0KPiA+ID4gPFJheS5IdWFuZ0BhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXIg
PFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47DQo+ID4gPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IGFkZCBWYW5n
b2doIEFQVSBmbGFnIHRvIElQDQo+ID4gPiBkaXNjb3ZlcnkgcGF0aA0KPiA+ID4NCj4gPiA+IENh
dXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBV
c2UgcHJvcGVyDQo+ID4gPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tp
bmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+ID4gPg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgTm92
IDEsIDIwMjIgYXQgOToyMyBBTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUdWUsIE5vdiAxLCAyMDIyIGF0IDE6
MTYgQU0gUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiB3cm90ZToNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEFkZCB0aGUgbWlzc2luZyBhcHUgZmxhZyBmb3IgVmFuZ29naCB3aGVuIHVz
aW5nIElQIGRpc2NvdmVyeQ0KPiA+ID4gPiA+IGNvZGUgcGF0aCB0byBpbml0aWFsaXplIElQcw0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVh
bkBhbWQuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBTd2FwIHRoZSBvcmRlciBvZiB0aGUgcGF0Y2hl
cy4gIFdpdGggdGhhdCwgdGhlIHNlcmllcyBpczoNCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiA+DQo+ID4gPiBBY3R1YWxs
eSwgeW91IGFsc28gbmVlZCB0byBmaXggdXAgY2hlY2tfc2VhbWxlc3NfYm9vdF9jYXBhYmlsaXR5
KCkNCj4gPiA+IGluIGFtZGdwdV9kbS5jLiAgU3dpdGNoIHRoYXQgdG8gYW4gSVAgdmVyc2lvbiBj
aGVjay4NCj4gPiA+DQo+ID4gPiBBbGV4DQo+ID4NCj4gPiBJIGFtIG5vdCBzdXJlIGlmIHRoZSBJ
UCB2ZXJzaW9ucyBvbmx5IGNvcnJlY3RseSBtYXRjaCB0aGUgR1BVcy4NCj4gDQo+IEl0IHNob3Vs
ZCBtYXRjaCBnZnggSVBfVkVSU0lPTigxMCwgMywgMSkuICBZb3UgYXJlIHVzaW5nIHRoYXQgdG8g
c2V0IHRoZSBBUFUNCj4gZmxhZyBpbiB0aGlzIHBhdGNoLiAgVGhlIERDTiB2ZXJzaW9uICgzLjAu
MSkgaXMgYWxzbyB1bmlxdWUgdG8gdGhpcyBjaGlwIGFuZCB0aGF0DQo+IHdvdWxkIGJldHRlciBt
YXRjaCB0aGUgZmFjdCB0aGF0IHRoaXMgaXMgYSBEQ04gcmVsYXRlZCBmdW5jdGlvbi4NCj4gDQo+
IEFsZXgNCg0KR3JlYXQsIHRoaXMgd2lsbCBiZSBiZXR0ZXIgdG8gbWF0Y2gsIEkgd2lsbCBtYWtl
IHRoZSBjaGFuZ2UgaW4gVjIuIA0KDQo+IA0KPiA+DQo+ID4gSG93IGFib3V0IHVzaW5nIHRoZSBh
cHUgZmxhZ3MgIGxpa2UgdGhpcyA/DQo+ID4NCj4gPiBib29sIGNoZWNrX3NlYW1sZXNzX2Jvb3Rf
Y2FwYWJpbGl0eShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgew0KPiA+ICAgICAgICAgaWYg
KGFkZXYtPmFwdV9mbGFncyAmIEFNRF9BUFVfSVNfVkFOR09HSCkgew0KPiA+ICAgICAgICAgICAg
ICAgICBpZiAoIWFkZXYtPm1tYW4ua2VlcF9zdG9sZW5fdmdhX21lbW9yeSkNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+IH0NCj4gPg0KPiA+IFBlcnJ5Lg0KPiA+DQo+ID4gPg0K
PiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIHwgMSArDQo+ID4gPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiA+ID4gPiA+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4gPiA+
ID4gaW5kZXggMzk5M2U2MTM0OTE0Li41MmE5MmFkZDEyZWEgMTAwNjQ0DQo+ID4gPiA+ID4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4gPiA+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+
ID4gPiA+ID4gQEAgLTIxNjEsNiArMjE2MSw3IEBAIGludCBhbWRncHVfZGlzY292ZXJ5X3NldF9p
cF9ibG9ja3Moc3RydWN0DQo+ID4gPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4gPiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigx
MCwgMywgMSk6DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIGFkZXYtPmZhbWlseSA9IEFNREdQ
VV9GQU1JTFlfVkdIOw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBhZGV2LT5hcHVfZmxhZ3Mg
fD0gQU1EX0FQVV9JU19WQU5HT0dIOw0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gPiA+ID4gPiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMywgMyk6DQo+ID4gPiA+ID4g
ICAgICAgICAgICAgICAgIGFkZXYtPmZhbWlseSA9IEFNREdQVV9GQU1JTFlfWUM7DQo+ID4gPiA+
ID4gLS0NCj4gPiA+ID4gPiAyLjM0LjENCj4gPiA+ID4gPg0K
