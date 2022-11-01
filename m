Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6A0C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 15:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7375610E040;
	Tue,  1 Nov 2022 15:19:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626AB10E040
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 15:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip7W+oINkmTEfxQaA8arypcpuR8x6+LvfdE2fmv4KEuTlvQkfm0NdGREI+4sySV7S6M++eoTxrpYQaSnt1qtlcFE/4BuI1ov8kYaElbtsKovq/3PTSyf6Ha8iXJlBiQLhHz4PKUOwscWkeIwsnPvIQn4SAZGUa74ZYkrHFAmCacPxYeMUCKK2CAO4um4jHA+4ULSYqzMdEzWbEbModJBdGN4C2vmiy5ExJ5RViLcUhvUZvnT+FDSciPnI0hI8MMU1nsvZNmKZC3tJYrP+7xja+ByHzumTLXm7Zc1c9IXaYL51L5X/BC6xVIaLbQ+NspnwOsLwxxfxoO4a9mnXxxCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2+uw2EiSpNPsWJx0gqa6XZBITFoIG2uXywOlsqWlcM=;
 b=Cvj6vaAf5NPcPJm6atV4BeFc2KdeO9/AzIjwNrvE4ysOaSJRx0UFRXSVqrndRJsn0Y9mnoL1eUtw9ryUNOQUnDL8MwbwZ8cbZeRun6NlcZOTFVWeCwO/B+O2JDdclk4TIgWXfZ2nYupwf65suhMPcOGVz6ADfXtGM2oMdxDQNTJ/f85TxEtDOc/fh/vfuG9I3GeHR0Ta4sv+F2UF/7OO8GYSLnO4VKDtj8JtoAcvSHnDxOf1IMjTebDXdyIg3NJZ45MOqDQU+iWyYsAIn1pQEMxqa7Tfgy3DprP8YPp/SideZpFtDQRgwavLu8Uga9d43Bnun/V3FbO+58in/Ydhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2+uw2EiSpNPsWJx0gqa6XZBITFoIG2uXywOlsqWlcM=;
 b=FTEEUfUS+Xz7sRjDhq8wIAGVzQDErG/3or9LuRTpmIjQdziyP6luGLtlTO2SrCH44JQj2H4YnH7SgFFf2j066nxk7AITPNHVJDn8ZNNWjU0PqxMFb7CTUI4/7vvwNR2a9axRHhPD024xr/SKYCE0ayqhd7U+dkv9Zpsz6P3bxC8=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 15:19:44 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%6]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 15:19:44 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery path
Thread-Topic: [PATCH 2/2] drm/amdgpu: add Vangogh APU flag to IP discovery path
Thread-Index: AQHY7bEXefy5aQPwFEmX0bSlrGH91a4qDtSAgAAAj4CAAB+HEA==
Date: Tue, 1 Nov 2022 15:19:44 +0000
Message-ID: <DM4PR12MB527832A011FA4DC91A6333109C369@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221101051450.1261693-1-Perry.Yuan@amd.com>
 <20221101051450.1261693-2-Perry.Yuan@amd.com>
 <CADnq5_M-Xa=4E5M8HdBrYnd4CT2cRabwJ=2kNrBTbFj81ETdag@mail.gmail.com>
 <CADnq5_MtoWMSy-YWp3mL805SOdpS0hJnbV0xo61YvtDFZ4RB_g@mail.gmail.com>
In-Reply-To: <CADnq5_MtoWMSy-YWp3mL805SOdpS0hJnbV0xo61YvtDFZ4RB_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-01T15:19:42Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8b218bf4-966d-4e34-9ae7-623aac37f352;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-01T15:19:42Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a3255558-5253-47d0-a86e-535b5dc8e636
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY8PR12MB7416:EE_
x-ms-office365-filtering-correlation-id: a4709a14-ced1-4c72-97e7-08dabc1c8181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzObnJivSWiRKQjs6L4N6gcHdJzR20biKgazu3AxzmCZ1VEXBxSbTndlsl5nMTFDXWqt3SFkHPTKhtbk17RAkVP72NCJo0sReVpbiImKHRj6f1UaYMtxlFbikceW79CdLkO35KistIkWsPfq1u+pbEtGWBmSc+vvREIFDYvn8Q47dho03I8E3Uqbg2tooNnXlhYWSwMfVbA7Dc+39FZ+PB0GI/ipuVpvSMEPosQ9K8CSW3b8/zmxbdeS0bFFOnlNS4lSjQEQdzMcG+fCibMVoNJ2TWGtfRbo0PKjVxsy0SoL2u3fgFNNGNT9jgOiFlYxRY1TPzVgtJIF5/wJOCfS64STfHz61MqOaI06WrDLER4Xl0AK3amGYG9ujpoTT2hpW6hzWt+8YcrjAi3vE+onLtTnvzy/ErD4gI1sXuAVRmlN38lPKWxOizLSTYydaYhYea/sB6Ox8sq7XXptXiKJYagziCI/aNqPxKdWTcl/jUk6vThWF1Ium+A7IBj1p1+e/Cg2H6ME/E01KV8JXP3KRMlts/SjBY2raQNgmgA7ZMbWpyoZ/KzZCzRWVmkUEGL1lphCz+ieCoJwP0s2cA9ar/SxglMwqTqAvhkVC+eiYivNoveNaz4Xykuq5gkScWmrca22aLshl1R2K3lgykTIBYTnvJnIbQCYk6vKjWQozqrQXOxfpynLEjoj7MB0AppAzMPQvtxf+ADVIjp51VNvUGdKnblebqaqNn9s1or0LtYBwE0ySl3oWZzwWS+v6gQRL9po8cpedmVKvHjuogXBrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5278.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(71200400001)(55016003)(478600001)(83380400001)(33656002)(186003)(76116006)(41300700001)(8936002)(4326008)(52536014)(66946007)(8676002)(122000001)(38070700005)(66556008)(38100700002)(66446008)(64756008)(86362001)(316002)(6916009)(54906003)(66476007)(2906002)(5660300002)(7696005)(6506007)(53546011)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nnd4THhxaTRVcnUyemtkOUVMTTkrQllrd1lNbmRhSFVHOHpzdlRWazNONTFE?=
 =?utf-8?B?MW5pWG5jRmN6bU5TRm1oVnl4Z2RZa1liYnpKSGVPSVRIUHhZR0EydHltUUZs?=
 =?utf-8?B?RTlReWNVZVEydlFsSVpLS0N0VkJ0ckRHaWU5bkhDNCtjRkxwU3hIZTVmYWRu?=
 =?utf-8?B?VGpHUk5md05ZZWw5TFZGUmRHMElxTGZpdExpbGFHSFY4cnZmWkhjclR3Tmlu?=
 =?utf-8?B?empBVW85ZXBCRUxxRE5LYTR0NllhZDgrL05rTk1qQ1lGcTQ2QlZtRWpOaFpO?=
 =?utf-8?B?bDcwbUtiV3Y5QTlXYzRzSEFUZ3NhM054S2pEWUhWSE56bE1kckw5RE0vUTdD?=
 =?utf-8?B?S0lGa280eFduS1Y3VE1EUUE0WlJidGRCbmpEeW9HVVY4TUptdTh6SHVZQ1Vx?=
 =?utf-8?B?Z2JxYXZmZGF6WkJoRnhMSW9kbFdOQXVPWXdPSHpEdUwwK3NyRUFlOE1MSFg4?=
 =?utf-8?B?ampJWFI1VjJ4cWxVQWlNUlJxY1VPWEMwZ1gzMVRrMVQxZFR6QVo2MUxnWURB?=
 =?utf-8?B?Y0pvTnd2VkNLRXI5dUpYVzJEUmpBeEtpaU12WHlBVmxValZLcjdCVTJNQndZ?=
 =?utf-8?B?K2F2dm9iWW12OHBqckJOeVdlVXZmRmZUNTRUSlNMaGo4TFRYRm9GN3JINlNC?=
 =?utf-8?B?VHZ5UHVyNkxxbHVyYzMwam4vU2x5ZUc1V2czcnVpb3BCNWxvdTlVQWUyRTZG?=
 =?utf-8?B?cmJlelR2U29IOGJqcHJDVVFZQ3AxdUFpclNKRE1uSHZZZzlUVGROMWl5NXRF?=
 =?utf-8?B?eUJPdWd1bnl6RHhBdnduTlg1Z2YyRlpZVmJkUHg1YUpiRkQ3RmlMdC9QQnhW?=
 =?utf-8?B?NUJYbllHOUgxWjl3V2FuS2lIYTJSZExCQVVHQ0txNEdsYUVzS05YN3hGQWU1?=
 =?utf-8?B?a0l2aUluWE5vS1laRDRtVXc0aE9JSWdUdCtIK0ZNZG9JeVRzWCtzQUJXQWNi?=
 =?utf-8?B?dUZXUUJIMFQ1QU9DaUx4SXVYZjRuaUtPUUozMWg3L3dNUWQ3OTRxWUVvUVZB?=
 =?utf-8?B?b055ek02ZmtsS1V6U3VjVGpZRWI4SVpLa1p4ZEZ6QWd4eGJYZFhDSXpIenBV?=
 =?utf-8?B?Y3NqYXlrN2kxTDRyblJsM1d3dWJ1cDFTcFI0aWprS0xrN0ovWXRWc2pzemtx?=
 =?utf-8?B?WGZ1TWJCYWdUYVRjNHFTUUtPeSsvTDVUV3NFaHpCSUNFTTE2Z3NsaGhLOUht?=
 =?utf-8?B?aFZsMEtDU3NmR3ptbmo3aW1SS2crbE95cGJlWXUxcTRuRURHN2dqQytDRHpl?=
 =?utf-8?B?Ym9BWTh6a1RYOUVZVFRudDNTZlRsZ3JEdHRRTVlIaXlLUkRsQjlpUXFGSGIx?=
 =?utf-8?B?QkNlaG1Ea3djRm5WTzVhMjhPbmxQRHY2M1pqTi9DRWJ1UkthOEdObENQbGV3?=
 =?utf-8?B?ZEZiNVNDR2VJSUtLcXhhc0MyN3R1ZUFXbE5ySUlWNkI1MmY4M2dWUHJTakhL?=
 =?utf-8?B?Q1RLakRrLzZ2RlNibHBTMlhadGZseXE4cDlZTUlUL21zUGdJMkdRRHM3ZkVN?=
 =?utf-8?B?VDhFMWtaODh2aEJPU050blBQVjV0U2JoNVVtQklPdk5SNHg0aTNkRjA0cmNX?=
 =?utf-8?B?ZmVNVFNSbkhJSDQ3aUZyTk1oZHBVSlNaeVR0V3ZFZC96cXFhV1c2V2VuQjlJ?=
 =?utf-8?B?ODVMdnRPSjQ0T2VTYWJ3eEtBUHMwWGs0RG0zVU5Md29xUnkzUGd1R0FOb0lz?=
 =?utf-8?B?UDJOOE1BU0d0eXNSMXZkMThnSVUwbDhnczU1T2JOVDlWTGo2UUxuVlh2Zy94?=
 =?utf-8?B?NktCeTBzUnlWaVhSVXJmeVI4cEtkOUo4MG1NRUp5eHVubG9Vd1Q3dkVsSzNN?=
 =?utf-8?B?akU4eDloSzZwYis4RkhLN3QrMkdoWXpoTHZndmFnU2RyWXo1a1JNWkM4OFBZ?=
 =?utf-8?B?RytQdjRONUV6Vm0rRmpHOW95S0xyYmlKTnQ0cHlRQng2QThzaVFMcjYyMjhN?=
 =?utf-8?B?ektUcU9kV09DYVllTmdESTlnVGkwcEErU2Y3MndiNHFyTXl2V0pqU3MybGpk?=
 =?utf-8?B?dXFqSGc5eGgvU2w5THZuUkFuWmFaTEJtL0h3K2E0T04vb0xRR0RTaElOeWxx?=
 =?utf-8?B?bmRrSmVqamRoYXdmOEE1ZFNwS0E5N1dGa1pVT3NneXUrTWk0NWVHRGp1c3I3?=
 =?utf-8?Q?qKxp4h2mlOsgT0DX2B7eQf2PZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4709a14-ced1-4c72-97e7-08dabc1c8181
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 15:19:44.4050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBcato2bUQBWNEeF5TnKzHOxjzMPeTAtTclearHc6HM5jQlSrorTosEcS07oMGwTAoCTGBZ+CEHYwsPXv/1Z4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXgNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0KPiBEZXVjaGVyDQo+IFNlbnQ6
IFR1ZXNkYXksIE5vdmVtYmVyIDEsIDIwMjIgOToyNSBQTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBl
cnJ5Lll1YW5AYW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgSHVhbmcs
IFNoaW1tZXIgPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBhZGQgVmFu
Z29naCBBUFUgZmxhZyB0byBJUCBkaXNjb3ZlcnkNCj4gcGF0aA0KPiANCj4gQ2F1dGlvbjogVGhp
cyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIN
Cj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciBy
ZXNwb25kaW5nLg0KPiANCj4gDQo+IE9uIFR1ZSwgTm92IDEsIDIwMjIgYXQgOToyMyBBTSBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBU
dWUsIE5vdiAxLCAyMDIyIGF0IDE6MTYgQU0gUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29t
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiBBZGQgdGhlIG1pc3NpbmcgYXB1IGZsYWcgZm9yIFZhbmdv
Z2ggd2hlbiB1c2luZyBJUCBkaXNjb3ZlcnkgY29kZQ0KPiA+ID4gcGF0aCB0byBpbml0aWFsaXpl
IElQcw0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5A
YW1kLmNvbT4NCj4gPg0KPiA+IFN3YXAgdGhlIG9yZGVyIG9mIHRoZSBwYXRjaGVzLiAgV2l0aCB0
aGF0LCB0aGUgc2VyaWVzIGlzOg0KPiA+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IA0KPiBBY3R1YWxseSwgeW91IGFsc28gbmVlZCB0byBm
aXggdXAgY2hlY2tfc2VhbWxlc3NfYm9vdF9jYXBhYmlsaXR5KCkgaW4NCj4gYW1kZ3B1X2RtLmMu
ICBTd2l0Y2ggdGhhdCB0byBhbiBJUCB2ZXJzaW9uIGNoZWNrLg0KPiANCj4gQWxleA0KDQpJIGFt
IG5vdCBzdXJlIGlmIHRoZSBJUCB2ZXJzaW9ucyBvbmx5IGNvcnJlY3RseSBtYXRjaCB0aGUgR1BV
cy4NCg0KSG93IGFib3V0IHVzaW5nIHRoZSBhcHUgZmxhZ3MgIGxpa2UgdGhpcyA/DQoNCmJvb2wg
Y2hlY2tfc2VhbWxlc3NfYm9vdF9jYXBhYmlsaXR5KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQ0Kew0KCWlmIChhZGV2LT5hcHVfZmxhZ3MgJiBBTURfQVBVX0lTX1ZBTkdPR0gpIHsNCgkJaWYg
KCFhZGV2LT5tbWFuLmtlZXBfc3RvbGVuX3ZnYV9tZW1vcnkpDQoJCQlyZXR1cm4gdHJ1ZTsNCgl9
DQoNCglyZXR1cm4gZmFsc2U7DQp9DQoNClBlcnJ5LiANCg0KPiANCj4gDQo+ID4NCj4gPiA+IC0t
LQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyB8
IDEgKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5
LmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5j
DQo+ID4gPiBpbmRleCAzOTkzZTYxMzQ5MTQuLjUyYTkyYWRkMTJlYSAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4g
PiBAQCAtMjE2MSw2ICsyMTYxLDcgQEAgaW50IGFtZGdwdV9kaXNjb3Zlcnlfc2V0X2lwX2Jsb2Nr
cyhzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiA+ICAgICAgICAgICAgICAgICBi
cmVhazsNCj4gPiA+ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDEwLCAzLCAxKToNCj4gPiA+ICAg
ICAgICAgICAgICAgICBhZGV2LT5mYW1pbHkgPSBBTURHUFVfRkFNSUxZX1ZHSDsNCj4gPiA+ICsg
ICAgICAgICAgICAgICBhZGV2LT5hcHVfZmxhZ3MgfD0gQU1EX0FQVV9JU19WQU5HT0dIOw0KPiA+
ID4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gICAgICAgICBjYXNlIElQX1ZFUlNJT04o
MTAsIDMsIDMpOg0KPiA+ID4gICAgICAgICAgICAgICAgIGFkZXYtPmZhbWlseSA9IEFNREdQVV9G
QU1JTFlfWUM7DQo+ID4gPiAtLQ0KPiA+ID4gMi4zNC4xDQo+ID4gPg0K
