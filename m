Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420ECC47258
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 01:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B966910EBD4;
	Fri, 26 Jan 2024 01:43:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AC610EBD4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 01:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDWe31k5R3i/D0n7A6pmjCEBReJ9ybTUmeSI4/2heeFmlTzJhZMytg/cfQJOsfphx22vARadocfUY9Afe7+8TWfiI2ra/E1rlzBLUyXChQIv57YGVPA9GYhoaKCExNdXnJtSZT9i7o4mZHKAikhHjWd7OAol3uQkClpJA9GoeOMDVpuaWtM/xF3Je8Lib3kzYadbvPUmiCBY/fdUQFEHdGMmZjgwonMGsZZx7ykbeJodjsjCmFh2RP7fJ4kxco/KVvD6giB79gvani+el/7HueU5r4x4iNWgFnAXxMqy0Vf8JzLe31Srws+7JpawB1no5bb/Cdp368ZJZDVRUPIMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JkFjn9sQn4FwLfgBmX7m7HTqwXu46JD+MKmyDjxNkg=;
 b=iaKKrkrPSIkxwTCweioDVWuu0tZHRkMqZdpgv9GzD3NqzTD3b23m3kQsHN3Bu58eUgZw6ZpYSx4yIwUf3cc0B035NERrryZhEM1BaACvr5Bo8CF742WanZKiuAUbGzTBVvCb7Lw4jKQI0y6KnUOr+yCJx6EHBVSn+SFXQYjJb93dptmmxCbDtpbQPv3ZsxiLv4//sgTs7GdfHpt4nXFkpZzva4BdOOIn87vekiiH71Ycu+I3RGjpCLP3aWEmMqtlaSCO5Jy0Blhee82qWEyJZiJtkrKhQWMuvaFrrUhD6c6ENgxruLI0eejsGNY0dnd+uLFXzERBzwuJaeInSa4PAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JkFjn9sQn4FwLfgBmX7m7HTqwXu46JD+MKmyDjxNkg=;
 b=QvJdGZjiqTf0bX8/XQAIf8/vYLfDgnA0x7WfYTD9IMDrr7F7SBQ0Z5hObnPCdbt0eGsFEIuy8muGh60QF6ySeKhBUt+ehVr6J4uMyam5TyCyZy5unaGVlIoD01SxUPTfvN5eDPmg7Hh8BFqAc391TCgnNEWXwVLOcV7wWvFQfTw=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 01:43:20 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 01:43:20 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM
 abort case
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM
 abort case
Thread-Index: AQHaTpLvhtO6qUfupU2bLdsybleF97DpH1qAgACs9UCAANsWgIAAAHoAgACsJpA=
Date: Fri, 26 Jan 2024 01:43:20 +0000
Message-ID: <DS7PR12MB6005C4B4C4ECE48DB61418FBFB792@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240124065932.892944-1-Prike.Liang@amd.com>
 <CADnq5_PJyh50wpHQuU_UFYvpnnp8PsteAJ7ymazFHMWD92cyDw@mail.gmail.com>
 <DS7PR12MB6005078B67C8122627CAA45DFB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_P0NJ7Vd1LBbECxf-1X-s3BOdYb0Q4FjEQe9TptjX_j9A@mail.gmail.com>
 <CADnq5_PO-gnc72wRM+mUxtCnsmqE0ytFVbB=QkMQkEGkCQoQFg@mail.gmail.com>
In-Reply-To: <CADnq5_PO-gnc72wRM+mUxtCnsmqE0ytFVbB=QkMQkEGkCQoQFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
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
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SN7PR12MB8148:EE_
x-ms-office365-filtering-correlation-id: bf6119d0-f604-4802-bb26-08dc1e102cf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tw+8QDDu1EBtyUTu+Hoi7koGOLCm3SjXibivQXF1Dgz04voSsOpXBNaV1+8L0R9TkHHmlHRH10e84+dQIavlVhA8uuGVuRKu6PUZ/cwI7BRlgGmNTtx27r69Dmytvo5gYpmtRQn+ZBKn8oN+jM8iU4SqksqWEYSYPzPKOUAxpINu5cSc+o2mmqo7iNvXpXDLWBk5+CUMeNTeCJKh+aPwXCmguR0R+RlrjRLpz12ycDmii8FMgX1LRQmFAExoQiXRmGxdRpnPMk07ePeIGJF6D9Zssk2quBB9PKgBi+DiiVgSYxHgIYPqSkP9pTT6ZTpx7w0w9bcyIdxA129FU4TO5cyEC2o+JghV51wCUUK1zJlabaMx5XurTo+IbqU7acPCCYAI6gyMysrIN6nM3wOYyBlqG6wFR0k6AMA6lSBfDz/DQtTzjJ/mNan/WRmpJWkm7uG+epoAVG7C9c7rcinUM+5cQ5R1AGfbPZ47oWeIH8TLseQ4Pb0npINChN45i96BHN9DKruWoqFuKRxXiKm64YyP0a4/hs70GE1hr1EsuLNJf564AhVKO76m3ur3Cr+TzBi0BYQ57iPB7E8f3/inKPuEg5O2tOkukyq4VLNzZ9HwMTt/EFGyCSUUDZCzYs2j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(9686003)(52536014)(4326008)(8936002)(8676002)(53546011)(6506007)(7696005)(2906002)(33656002)(83380400001)(5660300002)(26005)(41300700001)(478600001)(86362001)(38070700009)(76116006)(66556008)(71200400001)(64756008)(6916009)(54906003)(66946007)(66476007)(66446008)(316002)(122000001)(55016003)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUdrTGhtSXJtSmI4eGRKNHcvTmRzWTVOVkwrZ0dURWZ3ZTY0SUxva1paMHdz?=
 =?utf-8?B?UzY1RXdUbFIyL29aUStLMys1YmVzWGJZT1EyQlMwR24yTzF5bjVoYndRUlc2?=
 =?utf-8?B?dndDSlordVQzcHdMNlRuUVZmS3h5Vi9FQWJYdmxGQU91NU9HckxIOVdvSXRZ?=
 =?utf-8?B?NTdJdkRDOFg3VUltZExaN1ZBanp4SldRalJ0djNqaXVVRzE2bWhEZHd2S2dP?=
 =?utf-8?B?OVZHdE81VkpqazU1bHJVUm5qdDgvdytQNG9SWWpldlVHbG9HK1pZcGxVcnZW?=
 =?utf-8?B?Vzh5anVFdGpPQWxyVzhFdDV0aXpzbTlhZ25kNi8yRDVxaWZMUENxT3hYRm53?=
 =?utf-8?B?U0tOaVlGZSt3UWJtZC9yVjRaQ1REc0xzZ21hdkROeitZTXNVVG1LUGJGMndO?=
 =?utf-8?B?eVBQbm1RME5JaEIzU3FjTmtmcno3Z0JXUEVDT1dJTy9KZkhTdHMvM2Q1TFVw?=
 =?utf-8?B?b0pzbHFzbWxUOVg1QUJCVEVrbDRuNG03aXh0WThkcFZFU0w5VmM1UUJndGJu?=
 =?utf-8?B?OVZMeE5kdjdoTDN4SDNOUDZFL1p2TG5HTEoxbkpBUFl1M1k2bU81UEJxKzY5?=
 =?utf-8?B?MEFJOVBqajYwUGpsdjVyTnhaM0gvUnVRelFZbnZBRnRhSnJBREtxa25XbEFY?=
 =?utf-8?B?QTM3ZjFDMFI0aklEdSt2Y2ZXMmxxSk1CSU5jeE5iZ2VzL3dGQ1dwMUNvMXo4?=
 =?utf-8?B?MThRamVEdHFQSDBBWTl6YmpTeEh1Z20zUUM3aFVYUmc0bTJCaUNGdW9DRDZ0?=
 =?utf-8?B?ejVyeG1PT2pRYzJkZWloTmtsd2pqbUl4SUJEWTg4c01VSXZQNytBcStOaGxJ?=
 =?utf-8?B?Vm5OdXpXZmpGUzd0Y3Z5RWZFU2pRRHhHdTR0YkVIVFRnUkppYWNYYTNIbHJQ?=
 =?utf-8?B?Q25lZStOelJYZWNLUEdDQUxJRTVNcmIvL2hDc29Wby9hNC92RkF3RTBLMys4?=
 =?utf-8?B?TmlzWlBMOWZIcFlsdStoS2pnNUpKSWJ1aVcrc2RSNm5JTHZBY1lnaCtSQ3JW?=
 =?utf-8?B?eHVlZlNWYVFVTnJyZVAvQ3JuSVRGbnhvMUtZYjdRaHNWMlRaN0NmamJqQ3BK?=
 =?utf-8?B?TEVGaURjMjQ1VDExYitLZC9IblBOQ1Fwc01qckVWdEtXdE5VVEFTa1F1NVdF?=
 =?utf-8?B?TUoyS3IyYkQ0cy93eDByU0UvUi9Qd0x2ck9xWC9zNTVNVG8xSElaMGpOM1lq?=
 =?utf-8?B?M1RqRGhNdEd2aytlcnlPUDVMOWg1Wms3eisyeHRrcldoMmdwTXA4cTZQUEdv?=
 =?utf-8?B?SGVycHArL01VVHo4MkVHODdPYk11UEVEYnp5Sk5wSmFSbURFTG9xVmFtV2dl?=
 =?utf-8?B?NThBS1dYZnBIelh0eThDMDhwdjVCR0s5em1zMWltc2tSbVR2aDdGaTl1bjI5?=
 =?utf-8?B?SmlPcGJZRGRMZkQ2eXZCUHVJMkV5R3BCTkxPNDlDZVVzaVV5UUcwYzN0cDlH?=
 =?utf-8?B?N1ZoTkNjL3AyQk1SWHFwQlg1VUxXZlgxWE9rZkQ0eThMNjIwMjhuUDIxU2d4?=
 =?utf-8?B?eG5ZelBDb2JJc0I1VFI2bk9yUUVnenphSFBpZXJmSHdpL211RlBRUE82ZG5E?=
 =?utf-8?B?SU9veVc3OHFWeGpzVHVVQXNEWXZsV2x4Nnd5VFRDejBrYm50d0dHdXVaVE5s?=
 =?utf-8?B?UERiWHBsRkdDbzdSMXJ1Q2xwZnNrVWhrMjkydmdYSi9wb0NRdWhCMHcwVkhZ?=
 =?utf-8?B?R3ZHcnlLSkF3Vlc0c28wQ21aYzBvU3ZHc3RoMnVUdTRwSEZBNGNhTnJQdHZp?=
 =?utf-8?B?clpPTWl1V0lUamtad3MzSDEwM25ibUV2WEovTGVJRGVqWjA2M05ZQjI2N21B?=
 =?utf-8?B?UERnbEF1ZWlWbmJITDBCeHg3dFFCWFh4aHFrbDBpTFJTd1p2eVhNWlJ4bTA5?=
 =?utf-8?B?Sk50MDdENmJOeVB0cXlLaVFheXVWaVVqZG81aVNZNnZPRDJyb3hrMkZGZHdF?=
 =?utf-8?B?Um1hZEpXd0pMa01adndhdzYzL0dmRXduR0JBeTgzL2cxQ3VwNnVBeE1hV2RQ?=
 =?utf-8?B?Umh0SGxzUnZFcHZDb0Q3V1pRMTlBQ0M5TWRnaXo4OGVwV3B3eitWOTFaMVBQ?=
 =?utf-8?B?c3poTlFOUGh2NG5Wc1dhczI4WHRJb2s4NXFIekhHazBVTHNyOVVIVjNCNFpo?=
 =?utf-8?Q?1+Kc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6119d0-f604-4802-bb26-08dc1e102cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 01:43:20.2415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs7k8TO37svf9dWoNyj+xQaUZ9MrU5S9U0X5XKS6UjqYs4jLE1+ZSJSeWX9nd+Wj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gRnJvbTogQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI1LCAy
MDI0IDExOjI0IFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+
IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU2hhcm1hLCBEZWVwYWsNCj4gPERlZXBhay5T
aGFybWFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHNr
aXAgdG8gcHJvZ3JhbSBHRlhERUMgcmVnaXN0ZXJzIGZvcg0KPiBQTSBhYm9ydCBjYXNlDQo+DQo+
IE9uIFRodSwgSmFuIDI1LCAyMDI0IGF0IDEwOjIy4oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBKYW4gMjQsIDIwMjQg
YXQgOTozOeKAr1BNIExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gd3JvdGU6
DQo+ID4gPg0KPiA+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+ID4gPg0K
PiA+ID4gSGksIEFsZXgNCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
ID4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gPiA+IFNl
bnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyNCwgMjAyNCAxMTo1OSBQTQ0KPiA+ID4gPiBUbzogTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+ID4gPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA+ID4gPiA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IFNoYXJtYSwgRGVlcGFrDQo+ID4gPiA+IDxEZWVwYWsuU2hhcm1h
QGFtZC5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBz
a2lwIHRvIHByb2dyYW0gR0ZYREVDDQo+ID4gPiA+IHJlZ2lzdGVycyBmb3IgUE0gYWJvcnQgY2Fz
ZQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiBXZWQsIEphbiAyNCwgMjAyNCBhdCAyOjEy4oCvQU0gUHJp
a2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gSW4gdGhlIFBNIGFib3J0IGNhc2VzLCB0aGUgZ2Z4IHBvd2VyIHJhaWwgZG9lc24ndCB0
dXJuIG9mZiBzbw0KPiA+ID4gPiA+IHNvbWUgR0ZYREVDIHJlZ2lzdGVycy9DU0IgY2FuJ3QgcmVz
ZXQgdG8gZGVmYXVsdCB2YXVsZS4gSW4gb3JkZXINCj4gPiA+ID4gPiB0byBhdm9pZCB1bmV4cGVj
dGVkIHByb2JsZW0gbm93IG5lZWQgc2tpcCB0byBwcm9ncmFtIEdGWERFQw0KPiA+ID4gPiA+IHJl
Z2lzdGVycyBhbmQgYnlwYXNzIGlzc3VlIENTQiBwYWNrZXQgZm9yIFBNIGFib3J0IGNhc2UuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlh
bmdAYW1kLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmggICAgIHwgMSArDQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDEgKw0KPiA+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jICAgfCA0ICsrKysNCj4gPiA+ID4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+ID4gPiA+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiA+ID4gPiBpbmRleCBjNWYzODU5ZmQ2ODIu
LjI2ZDk4M2ViODMxYiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHUuaA0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oDQo+ID4gPiA+ID4gQEAgLTEwNzksNiArMTA3OSw3IEBAIHN0cnVjdCBhbWRn
cHVfZGV2aWNlIHsNCj4gPiA+ID4gPiAgICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW5fczM7DQo+ID4gPiA+ID4gICAgICAgICBib29sICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGluX3M0Ow0KPiA+ID4gPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbl9zMGl4Ow0KPiA+ID4gPiA+ICsgICAgICAgYm9vbCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwbV9jb21wbGV0ZTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAgICAgZW51
bSBwcF9tcDFfc3RhdGUgICAgICAgICAgICAgICBtcDFfc3RhdGU7DQo+ID4gPiA+ID4gICAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X2Rvb3JiZWxsX2luZGV4IGRvb3JiZWxsX2luZGV4OyBkaWZmIC0tZ2l0
DQo+ID4gPiA+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4g
PiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4g
PiA+IGluZGV4IDQ3NWJkNTljOWFjMi4uYTAxZjliMGMyZjMwIDEwMDY0NA0KPiA+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4gPiA+IEBA
IC0yNDg2LDYgKzI0ODYsNyBAQCBzdGF0aWMgaW50DQo+ID4gPiA+ID4gYW1kZ3B1X3Btb3BzX3N1
c3BlbmRfbm9pcnEoc3RydWN0DQo+ID4gPiA+IGRldmljZSAqZGV2KQ0KPiA+ID4gPiA+ICAgICAg
ICAgc3RydWN0IGRybV9kZXZpY2UgKmRybV9kZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
PiA+ID4gPiAgICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJtX3RvX2FkZXYo
ZHJtX2Rldik7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArICAgICAgIGFkZXYtPnBtX2NvbXBsZXRl
ID0gdHJ1ZTsNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBuZWVkcyB0byBiZSBjbGVhcmVkIHNvbWV3
aGVyZSBvbiByZXN1bWUuDQo+ID4gPiBbTGlhbmcsIFByaWtlXSAgVGhpcyBmbGFnIGlzIGRlc2ln
bmVkIHRvIGluZGljYXRlIHRoZSBhbWRncHUgZGV2aWNlDQo+IHN1c3BlbnNpb24gcHJvY2VzcyBz
dGF0dXMgYW5kIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBhbmQgY2xlYXIgaXQgYXQgdGhlDQo+IGFt
ZGdwdSBzdXNwZW5zaW9uIGJlZ2lubmluZyBwb2ludC4NCj4gPiA+ID4NCj4gPiA+ID4gPiAgICAg
ICAgIGlmIChhbWRncHVfYWNwaV9zaG91bGRfZ3B1X3Jlc2V0KGFkZXYpKQ0KPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm4gYW1kZ3B1X2FzaWNfcmVzZXQoYWRldik7DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYw0KPiA+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0K
PiA+ID4gPiA+IGluZGV4IDU3ODA4YmU2ZTNlYy4uM2JmNTFmMThlMTNjIDEwMDY0NA0KPiA+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gPiA+ID4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4gPiA+ID4g
QEAgLTMwMzQsNiArMzAzNCwxMCBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2NwX2dmeF9zdGFydChz
dHJ1Y3QNCj4gPiA+ID4gPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gICAgICAgICBnZnhfdjlfMF9jcF9nZnhfZW5hYmxlKGFkZXYsIHRydWUpOw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gKyAgICAgICBpZiAoYWRldi0+aW5fc3VzcGVuZCAmJiAhYWRldi0+cG1fY29t
cGxldGUpIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgRFJNX0lORk8oIiB3aWxsIHNraXAg
dGhlIGNzYiByaW5nIHdyaXRlXG4iKTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQo+ID4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+IFdlIHByb2JhYmx5IHdh
bnQgYSBzaW1pbGFyIGZpeCBmb3Igb3RoZXIgZ2Z4IGdlbmVyYXRpb25zIGFzIHdlbGwuDQo+ID4g
PiA+DQo+ID4gPiA+IEFsZXgNCj4gPiA+ID4NCj4gPiA+IFtMaWFuZywgUHJpa2VdIElJUkMsIHRo
ZXJlJ3Mgbm8gaXNzdWUgb24gdGhlIE1lbmRvY2lubyBzaWRlIGV2ZW4gd2l0aG91dA0KPiB0aGUg
Zml4LiBIb3cgYWJvdXQga2VlcCB0aGUgb3RoZXIgZ2Z4IGdlbmVyYXRpb25zIHVuY2hhbmdlZCBm
aXJzdGx5IGFuZCBhZnRlcg0KPiBzb3J0IG91dCB0aGUgZmFpbGVkIGNhc2Ugd2lsbCBhZGQgdGhl
IHF1aXJrIGZvciBlYWNoIHNwZWNpZmljIGdmeCByZXNwZWN0aXZlbHk/DQo+ID4NCj4gPiBNZW5k
b2Npbm8gb25seSBzdXBwb3J0cyBTMGkzIHNvIHdlIGRvbid0IHRvdWNoIGdmeCBvbiBzdXNwZW5k
L3Jlc3VtZS4NCj4gPiBUaGlzIHdvdWxkIG9ubHkgaGFwcGVuIG9uIHBsYXRmb3JtcyB0aGF0IHN1
cHBvcnQgUzMuDQo+DQo+IEUuZy4sIHRyeSBhbiBhYm9ydGVkIHN1c3BlbmQgb24gUmFwaGFlbCBv
ciBQSFgyLg0KPg0KPiBBbGV4DQo+DQpbTGlhbmcsIFByaWtlXSAgVGhhbmtzIGZvciB0aGUgcmVt
aW5kZXIsIGJ1dCB0aGUgTWVuZG9jaW5vIGFsc28gd2FzIHZlcmlmaWVkIG9uIHRoZSBzeXN0ZW0g
d2l0aCBTMyBlbmFibGVkIGZyb20gQklPUy4gSSB3aWxsIGRvdWJsZSBjb25maXJtIGlmIHRoZXJl
IG5lZWQgdGhlIHF1aXJrIG9uIHRoZSBSUEwgb3IgUEhYMi4NCg0KPiA+DQo+ID4gQWxleA0KPiA+
DQo+ID4gPg0KPiA+ID4gPiA+ICAgICAgICAgciA9IGFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIGdm
eF92OV8wX2dldF9jc2Jfc2l6ZShhZGV2KSArIDQgKyAzKTsNCj4gPiA+ID4gPiAgICAgICAgIGlm
IChyKSB7DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIERSTV9FUlJPUigiYW1kZ3B1OiBjcCBm
YWlsZWQgdG8gbG9jayByaW5nDQo+ID4gPiA+ID4gKCVkKS5cbiIsIHIpOw0KPiA+ID4gPiA+IC0t
DQo+ID4gPiA+ID4gMi4zNC4xDQo+ID4gPiA+ID4NCg==
