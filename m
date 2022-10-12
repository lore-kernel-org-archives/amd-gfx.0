Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52ECC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 01:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5AA10E16C;
	Wed, 12 Oct 2022 01:44:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12DB10E16C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 01:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL2lfFeNEaTOcflsfE774EYQYP3OE/UBw8AqXFhMHogGm+L1fJw6Mw6wJN0DK0TL6HFoWl/1t/u4k4PUXDdPflZA8ik7XKjGVMqiMgppAgVfzGgRUTvfkXbFvk76sUA2VoV3SRZiR/uo08BpXyROgNdM0zpjoS3wxLgen9xjVQ33XOblcM3i1eosFbYqyUp+l/qh6ekgB2ulr6lX5KjT7JNWdbFC163c2jDTIAfzh+2p4iFVrQC2l5zXRQiU40io4DwuvXPTM2AQYFTuWEpEA6trllnoj796+XquD3iWL1GHWg54MYe5hI6JMY2AZjp1aMlLJKhOVuezYZlk8pDRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlka6TK49n3HBJy8rLBeTFMnoLrPlUS3yd6rhzX6H20=;
 b=VqtVH5hEajuHTpGmu1mQOO6KRr7t/IQgAhSdG42EOxjtlISM9IxKYzwBH+9pLnoMzmIXfJaZN5xxzfkhlpKaaibioReZnt6um0qYoTogmRiypZoK6SGo9qQj4tmNWwBI9XO++m0JT1ZKpQfDwZEvPVzt5+BNjgI/H9m4LlX2U1TCNXun2P//gEqHrzmEEw2o+9SME4YV9jEwRAxUYX1WQjrOzli+UIwRCC8HegthubPLUoSBAQwFKFoZ2MBsKH0athnOgTcOcn/9L6ovdOxxeyXsfn0EX89p4v9JOBkdwxcFXkO/gsiRvBND5xetqR/ENrM+GfyFMUyBrdtc/P1y1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlka6TK49n3HBJy8rLBeTFMnoLrPlUS3yd6rhzX6H20=;
 b=akZa9UWSLxwYXZVRoSaNXgb2LbL29bp1TgUTfSA2/dZyREVzYxembnVpeP8sxwNtfh4IkdIN7b3O7VxsSwreI99yTqTz6BfErGL9sOxU9v/W20a9XueXcwUWX0dJB3f98OdwsmUzE8fw1mNyEcOQ7QJZVvxC/hEVp9Onw9Mu6Sc=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 01:43:59 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::e42b:46ed:ea09:e38a]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::e42b:46ed:ea09:e38a%6]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 01:43:59 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Fix SDMA engine resume issue under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Fix SDMA engine resume issue under SRIOV
Thread-Index: AQHY2a61w6K+Wat/zkO801OYZAwwV64Bqr4AgAAdSgCAAa7FgIAGjdWw
Date: Wed, 12 Oct 2022 01:43:59 +0000
Message-ID: <BL1PR12MB5269AA83CEC872AB0425A08C84229@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20221006180838.5132-1-Bokun.Zhang@amd.com>
 <MN2PR12MB2957F0AE3227749B07AAB7A4F45C9@MN2PR12MB2957.namprd12.prod.outlook.com>
 <CADnq5_OJN5cGu0Uaph2_A7XOSCUY9XgKNKyQTmRvY4+yy4sFTw@mail.gmail.com>
 <MN2PR12MB29576D21D9A925F7F075D42EF45F9@MN2PR12MB2957.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB29576D21D9A925F7F075D42EF45F9@MN2PR12MB2957.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-07T21:38:03Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3cc648ae-2be8-42b0-8885-cb51c362e1b9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-12T01:43:56Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 42f344f8-2995-4928-991a-03f88630da4d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|CY8PR12MB7289:EE_
x-ms-office365-filtering-correlation-id: 8a2f9e9d-1c74-4bab-27da-08daabf33b99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bL7TghLbfSGyCRBBxlM1IO0QF6HmAbknKjRvtaWE5+oQDvVlSR//+WvKsIm52egjkv4X4xzHOuXy5v+0WZ9PUxlepjV70T8/WVd+pjwxiUv3gBBvNFdBeN/fdN8oH+RzoZS1JXk/zG2j6xytkka58nZuVqy5rQGz1f16DZUwjn35bv/8oURDTByXtH+INLATd7RjwM3Ua4WcKRQ8dx29bIn/Fs8Tu5n8vWPuJ42QiR4N/d2zLQ0SRBhTJv2mWvh/3lEJPnQO+7cPN0NZQcOaBuHsdwfOTfap8pv1mGjQ/OMKflQx7MTQYJZ0192hmdFtW2OCnYk8lNIHSeZjCuzRGeOzG4N6UoF8HcYNWXDX/60hEaG9dPDexTJDP2h4sbF7xpXsbuEs5t8uC4kah1haINJh4cdnl63FZx76nOKlrZ1rnBRvlLnP+zpyU0wjqbWQsVEjuiI0I2PN5vqMI7Pw0h/IxiDWgCY8Ml05O8ickqRh7U0K51MWqx0PLC/+zrZlxP40RwLYYexIFNzmZkaZN10tChAbA/SWW4MHX2thH8MRU8e/AS+foG8JNjBEAx8kuigiLVV4AEEkreDkfYmiE/NMHS3QQPRpzZOVObLeEMzzjQ/xlI9sXnOeGAuNCWCTh++Vpi43i0nLCnTHVNdpmBHNHadC4hJx97oxttoPqG3Zw52X8NzUKdzqpkkvQcnuaT7zrKFgcLaCGYhxFHpHD8nynnmSEKu29tiygd9RQSHcN/EwlKMKoH1b5I/pG0W4o+Eyoe3aM6+6CL4iHEaTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(86362001)(122000001)(33656002)(38070700005)(316002)(66946007)(38100700002)(8676002)(4326008)(71200400001)(64756008)(66446008)(76116006)(66556008)(66476007)(52536014)(110136005)(2906002)(55016003)(8936002)(54906003)(5660300002)(41300700001)(186003)(83380400001)(9686003)(478600001)(6506007)(26005)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlNnUHQ1c3BkZXBDYW94VmtVNVplTTRwSDBDMXNUWm5jMnBzSEt6UDY3bE1n?=
 =?utf-8?B?VWMzQ2FLNzd5c2JvdmR2aVZ4RGRkVjBiMlFOSHNkaGNCbWlXVTVTeklseGJO?=
 =?utf-8?B?OXlzQ2lOTWV4a1hUREhOM1pqVEpvTGdXcVljMm13R2NXSjIzNnlGdGtBOWJO?=
 =?utf-8?B?OEhuSUNya2xMTTZMcjROTENtWXo5WUxlMzZwdzhNRjJsdGxBMWJzYzdBTCtG?=
 =?utf-8?B?TC85dE1VVHlZQ3NoR2hvcDkxVjhzMXcxam0wSXF0YU5aSXhPZjduVVBVZWhQ?=
 =?utf-8?B?TFlPaEUzSEI3dDhvWmZPaTZFbVpLNzl6dWMvMWVUdzh5S2ZWZzcrVG4yUDlu?=
 =?utf-8?B?alR5TjR6azlsZWxtWWhzNGNpdDNuOXhWSGtFZTZ2Q3NQZXhuSVUwK0JRZG1K?=
 =?utf-8?B?bEsxQ0wrOE1kNWh0YlRmOTVnN2daM1FDdnhsRTNkTDF6a1lKUHc5U2RMOFdy?=
 =?utf-8?B?cnZKdFBiMDVpaVFmM1lSZjlTY0J1UmVhNURmUkVsOG85Tnc0MVZLTUZrOWdF?=
 =?utf-8?B?ODNQTlYzNThYSE54UmdpRnp0KzJVNEFNOEFwZzlIeFF6RnhkdkU2VGZ6QUkr?=
 =?utf-8?B?RVkweUdLbVRacG0zMUUzejlGWlBjVW80Qm1vNmQxV0hsYjdaTUFUWmZSK0s1?=
 =?utf-8?B?L3hFbnVsdmRPc0RlZ1ExajQ4bHlLZlF2ZXc1ZldLR0czTzdpOHd6TnRoSnVh?=
 =?utf-8?B?OHNOUzg0UGo5d2hhYnBEa2ZDZFQySXF3SWtySlFyaDhYQmtISFdDVEcyeU9W?=
 =?utf-8?B?dUdRbnlMV0xRb255N0lGOUhSMHhabFdUOEEvMWJzeUxqRzVpZzdGcnd2eWV2?=
 =?utf-8?B?RzhsSURWZTVOMU1HZlBQc21nRlhoaHdKcldiWHRISFVjVmltS3kwbkpaSHov?=
 =?utf-8?B?eU04TUVHZUQrRGdlaXZNRHRpa0JIby84aTR0MmhrbXdtYkxqbllEZ3ZTcmQ5?=
 =?utf-8?B?cWJkYWR2MWtYL0d3NXNya0l3czBQR0RRbWFqbGhlNnBBVjVXckxibGRNOG83?=
 =?utf-8?B?VFE4THh3bHNrUXFNYlVmZ25YbjNWNXdIREcvcGhWdlJsYWFqTWpqSHBuaUw3?=
 =?utf-8?B?d2pyc0J1Wk43WjFraGhXakhjaWU1Mm1MSmV2a0ZQR04xWVhFS3FjazR6blNO?=
 =?utf-8?B?RlFWSW96KzJ1V0lQSHJ4TkVJdXhFRmlSMll6S2RhMzI5Q1lDdnV0dGd4TVFX?=
 =?utf-8?B?NFJFc3I2blp6NytpcUpuRndaWjBibkcwR0wwczk1SXQwWnhzQlFLYlpUUjdH?=
 =?utf-8?B?V09nZFF0b21zWTVxc29MdVQyNXFRbEtnVlhTTEw0ZWljbEEwdHFmK3Zjb3NI?=
 =?utf-8?B?OURBQWoxWVdSVVl3bWpNbjZQZDBhZXA2YXZLT2hyTDhIK2VQRjM4ZVUxLzhv?=
 =?utf-8?B?cXowZ1FWK2w0Y0g5QjZhY3dVaG1ld01WTTRxMlpTdTN2YmdTUXZQYTdESVUw?=
 =?utf-8?B?ajdja1FyWUJaWnp6SVZlOERJamFJc2FUT01zdnVSVWh4dVMxRERTUTdpYjlu?=
 =?utf-8?B?YVR4ZkdLY1pISkR5RnUvZFY1ZEo2eDViZGpRTU1kd0grRGIwQjZ3TGl1S015?=
 =?utf-8?B?UCtYcXlEMERsMlA1YVFQcmpIdWhSRU4zbFVZM3JoZUZ1WTV0cS95Q3E0SEht?=
 =?utf-8?B?clZlSDhpZHA1dVkwWFBGNnFYWHNLUmdPQjlzVzRPNGFJMXJPY2UvMWRobElV?=
 =?utf-8?B?dkZqUTd4a1FuUVhMdHVtSHQvRFZlaHR1MnM0RmJMUmJmZUNBMmVRZ21OTmJ2?=
 =?utf-8?B?OTNRVDBhSmVFUEpGcVpYUmpQN3BhTk1KOWlIY3ZhZlNhMlNUOGZYa1p2R1ho?=
 =?utf-8?B?Z3pZT1BuejgwRm5FVnd6Yy9scjB3aUlsWXZ6S2lDbXNSbVhqTzMvNHI0akh0?=
 =?utf-8?B?WldEeGFvQzJhMGYzdStRRHYxd0M3VzIzSlFONWQ2OW5IWllOVW9nd3VsN0Vi?=
 =?utf-8?B?dTFpbHppYnphQmhoNUFYRXNlMTNtTEczazhNNTIvYzVMREpuSXVIcGN5ckJ5?=
 =?utf-8?B?cklOYUFmVDZqbUNldjFnWGNHODhIR3lNdmxKNDA3QWZFaUFkTmFMcWxXMjhi?=
 =?utf-8?B?aEFjbEh3eVNyenlNNFNuNVRNSFJpZDBNcmMyank0K05kcGhJbTlSc0tPcUM2?=
 =?utf-8?Q?8fD4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2f9e9d-1c74-4bab-27da-08daabf33b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 01:43:59.1172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5u/ZRMwiukutv3ZILwuncfbNalSSn7TwYZWFwDQqU+hRA0jVJLC7cJbOZW8Kj0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Jiang, 
 Jerry \(SW\)" <Jerry.Jiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEJva3VuDQoNCkNhbiB5b3Ug
ZWxhYm9yYXRlIG1vcmUgb24gdGhpcyByZWVuYWJsaW5nIFNETUEgZW5naW5lIGR1cmluZyBzdXNw
ZW5kID8NCldoeSBWRiBuZWVkIHRoZSBTRE1BIGVuZ2luZSBhbGl2ZSB0aGVyZSA/DQoNCj4gLQ0K
PiArICAgICAgIC8qDQo+ICsgICAgICAgICogVW5kZXIgU1JJT1YsIHRoZSBWRiBjYW5ub3Qgc2lu
Z2xlLW1pbmRlZGx5IHN0b3AgU0RNQSBlbmdpbmUNCj4gKyAgICAgICAgKiBIb3dldmVyLCB3ZSBz
dGlsbCBuZWVkIHRvIGNsZWFuIHVwIHRoZSBEUk0gZW50aXR5DQo+ICsgICAgICAgICogVGhlcmVm
b3JlLCB3ZSB3aWxsIHJlLWVuYWJsZSBTRE1BIGFmdGVyd2FyZHMuDQo+ICsgICAgICAgICovDQoN
ClRoYW5rcyANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCk1vbmsgTGl1IHwgQ2xvdWQgR1BVICYgVmlydHVhbGl6YXRp
b24gU29sdXRpb24gfCBBTUQNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCndlIGFyZSBoaXJpbmcgc29mdHdhcmUgbWFu
YWdlciBmb3IgQ1ZTIGNvcmUgdGVhbQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogWmhhbmcsIEJva3VuIDxCb2t1bi5aaGFuZ0BhbWQuY29tPiANClNlbnQ6
IDIwMjLlubQxMOaciDjml6UgNTozOA0KVG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPg0KQ2M6IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IERlbmcsIEVtaWx5IDxFbWlseS5EZW5n
QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEppYW5nLCBKZXJyeSAoU1cpIDxKZXJyeS5K
aWFuZ0BhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IFNETUEg
ZW5naW5lIHJlc3VtZSBpc3N1ZSB1bmRlciBTUklPVg0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5
IC0gR2VuZXJhbF0NCg0KVGVzdGVkLWJ5OiBCb2t1biwgWmhhbmcgPEJva3VuLlpoYW5nQGFtZC5j
b20+DQoNClRoaXMgcGF0Y2ggaXMgYmV0dGVyIHNpbmNlIGl0IGV4dHJhY3RlZCB0aGUgdW5zZXQg
Y29kZSBhbmQgb25seSBleGVjdXRlIGl0IGluIHRoZSBTUklPViByb3V0aW5lLg0KSSBoYXZlIHRl
c3RlZCBpdCB3aXRoIG11bHRpLVZGLg0KDQpUaGFua3MhDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiANClNl
bnQ6IFRodXJzZGF5LCBPY3RvYmVyIDYsIDIwMjIgMzo1NiBQTQ0KVG86IFpoYW5nLCBCb2t1biA8
Qm9rdW4uWmhhbmdAYW1kLmNvbT4NCkNjOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBEZW5nLCBFbWls
eSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggU0RNQSBlbmdpbmUgcmVzdW1lIGlzc3VlIHVuZGVyIFNS
SU9WDQoNCk9uIFRodSwgT2N0IDYsIDIwMjIgYXQgMjoxMSBQTSBaaGFuZywgQm9rdW4gPEJva3Vu
LlpoYW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2Vu
ZXJhbF0NCj4NCj4gSGV5IGd1eXMsDQo+ICAgICBQbGVhc2UgaGVscCByZXZpZXcgdGhpcyBwYXRj
aCBmb3IgdGhlIHN1c3BlbmQgYW5kIHJlc3VtZSBpc3N1ZS4NCj4gICAgIEkgaGF2ZSB0ZXN0ZWQg
aXQgd2l0aCBtdWx0aS1WRiBlbnZpcm9ubWVudCwgSSB0aGluayBpdCBpcyBvay4NCg0KU2VlbXMg
YSBsaXR0bGUgaGFja3ksIGJ1dCBJIHRoaW5rIHRoYXQncyB0aGUgbGVhc3QgaW50cnVzaXZlIGZv
ciBzdGFibGUuICBIb3cgYWJvdXQgdGhlIGF0dGFjaGVkIHBhdGNoZXM/DQoNCkFsZXgNCg0KDQo+
DQo+IFRoYW5rcyENCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9r
dW4gWmhhbmcgPEJva3VuLlpoYW5nQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVy
IDYsIDIwMjIgMjowOSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IFpoYW5nLCBCb2t1biA8Qm9rdW4uWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBGaXggU0RNQSBlbmdpbmUgcmVzdW1lIGlzc3VlIHVuZGVyIFNSSU9WDQo+
DQo+IC0gVW5kZXIgU1JJT1YsIFNETUEgZW5naW5lIGlzIHNoYXJlZCBiZXR3ZWVuIFZGcy4gVGhl
cmVmb3JlLA0KPiAgIHdlIHdpbGwgbm90IHN0b3AgU0RNQSBkdXJpbmcgaHdfZmluaS4gVGhpcyBp
cyBub3QgYW4gaXNzdWUNCj4gICB3aXRoIG5vcm1hbCBkaXJ2ZXIgbG9hZGluZyBhbmQgdW5sb2Fk
aW5nLg0KPg0KPiAtIEhvd2V2ZXIsIHdoZW4gd2UgcHV0IHRoZSBTRE1BIGVuZ2luZSB0byBzdXNw
ZW5kIHN0YXRlIGFuZCByZXN1bWUNCj4gICBpdCwgdGhlIGlzc3VlIHN0YXJ0cyB0byBzaG93IHVw
LiBTb21ldGhpbmcgY291bGQgYXR0ZW1wdCB0byB1c2UNCj4gICB0aGF0IFNETUEgZW5naW5lIHRv
IGNsZWFyIG9yIG1vdmUgbWVtb3J5IGJlZm9yZSB0aGUgZW5naW5lIGlzDQo+ICAgaW5pdGlhbGl6
ZWQgc2luY2UgdGhlIERSTSBlbnRpdHkgaXMgc3RpbGwgdGhlcmUuDQo+DQo+IC0gVGhlcmVmb3Jl
LCB3ZSB3aWxsIGNhbGwgc2RtYV92NV8yX2VuYWJsZShmYWxzZSkgZHVyaW5nIGh3X2ZpbmksDQo+
ICAgYW5kIGlmIHdlIGFyZSB1bmRlciBTUklPViwgd2Ugd2lsbCBjYWxsIHNkbWFfdjVfMl9lbmFi
bGUodHJ1ZSkNCj4gICBhZnRlcndhcmRzIHRvIGFsbG93IG90aGVyIFZGcyB0byB1c2UgU0RNQS4g
VGhpcyB3YXksIHRoZSBEUk0NCj4gICBlbnRpdHkgb2YgU0RNQSBlbmdpbmUgaXMgZW1wdGllZCBh
bmQgaXQgd2lsbCBmb2xsb3cgdGhlIGZsb3cNCj4gICBvZiByZXN1bWUgY29kZSBwYXRoLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBCb2t1biBaaGFuZyA8Qm9rdW4uWmhhbmdAYW1kLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYyB8IDEzICsrKysrKysr
KystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8y
LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMNCj4gaW5kZXgg
ZjEzNmZlYzdiNGY0Li4zZWFmMWE1NzNlNzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NkbWFfdjVfMi5jDQo+IEBAIC0xMzU3LDEyICsxMzU3LDE5IEBAIHN0YXRpYyBpbnQgc2Rt
YV92NV8yX2h3X2Zpbmkodm9pZCAqaGFuZGxlKSAgew0KPiAgICAgICAgIHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0KPg0KPiAtICAg
ICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+IC0gICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4gLQ0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogVW5kZXIgU1JJT1YsIHRoZSBWRiBj
YW5ub3Qgc2luZ2xlLW1pbmRlZGx5IHN0b3AgU0RNQSBlbmdpbmUNCj4gKyAgICAgICAgKiBIb3dl
dmVyLCB3ZSBzdGlsbCBuZWVkIHRvIGNsZWFuIHVwIHRoZSBEUk0gZW50aXR5DQo+ICsgICAgICAg
ICogVGhlcmVmb3JlLCB3ZSB3aWxsIHJlLWVuYWJsZSBTRE1BIGFmdGVyd2FyZHMuDQo+ICsgICAg
ICAgICovDQo+ICAgICAgICAgc2RtYV92NV8yX2N0eF9zd2l0Y2hfZW5hYmxlKGFkZXYsIGZhbHNl
KTsNCj4gICAgICAgICBzZG1hX3Y1XzJfZW5hYmxlKGFkZXYsIGZhbHNlKTsNCj4NCj4gKyAgICAg
ICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+ICsgICAgICAgICAgICAgICBzZG1hX3Y1
XzJfZW5hYmxlKGFkZXYsIHRydWUpOw0KPiArICAgICAgICAgICAgICAgc2RtYV92NV8yX2N0eF9z
d2l0Y2hfZW5hYmxlKGFkZXYsIHRydWUpOw0KPiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgIHJl
dHVybiAwOw0KPiAgfQ0KPg0KPiAtLQ0KPiAyLjM0LjENCg==
