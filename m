Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B65BC678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 06:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB2410E03E;
	Tue,  7 Mar 2023 06:52:24 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05D610E03E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 06:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+BE2SYI4ADPQDwR3bppO+pEFwPnFifT1t8EF9fO1S8iNOMxt26bqmV+lWXLoIPJe/bYLnhJW9pwaIKddcK+e0nSe/1CIct61jw0vXqCHYtfEZ8ZdUYpmayRo2w4eIOUyKrJrax2nCqk6FGwM/vMEY0Gbt0YbDoUe7k4z+uQ63qooKNsYdFr47gv/cpKDPZnpKDba/utSNFBkbjKJD4CnrYej7ELsmBSk8fQwdLvX18k45S0NCNwWU+oCTIWXQUoXDE9lRN1ZdUqodjAqARXyJ3GJXBorOZv3xmMlK2yewPvwSlbt3HyL7U/MLiHn/X21FqbeIOPVeUjmYFmBbta6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmWUo84sEieOZILBtBUOIfpp5IH1FpQfSzuBXITdtZ8=;
 b=Yp8Vsjjr5X75l+6967E3CRePs8qMvt0c1fkfHBkCw4cJVRn2TyAqSiLaSJ8GftRl18jM+Nj3DPDZri4oWxfSyX1b8QdPnWb+Tfjor3z59uIMzLia4jzVCe9k3E2QA+i2kvfAsGUgpru+SXZC1QcCk0umAfEqQzfmGG7TtztLGiiP848qM5NMzbg0oWBbrbOQoGR41PobF3WDCyRRYcx6CRdU7tnzsHfI2T3VRQjfddsvFN8K1GAHk2QYxhwreW5mtF2+u5cjd8xC1IJbIqjeNS7/DehDD5FPiKMzecYw11oVHMkfF5nrl19uXKuPIs3B5JcOPdwG56r/kOzWdGLesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmWUo84sEieOZILBtBUOIfpp5IH1FpQfSzuBXITdtZ8=;
 b=GDieMZErEMm+5mSzSInhkjoMCcc8b/GZWY7iIov9dgebpd0+NMaL+QZt80XDgUfDSAJgmgy+zesOJEI8hoC5xSzaBE6fzL0LJz3TlknXdV/Ww26AR5loD0MlSuW9q2GojwG/zWKmxJy7XldVbzHWWiPuF6Dp74ku3W1rdoP/MC4=
Received: from CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 06:52:18 +0000
Received: from CH0PR12MB5251.namprd12.prod.outlook.com
 ([fe80::baa0:21cc:2e5f:4a77]) by CH0PR12MB5251.namprd12.prod.outlook.com
 ([fe80::baa0:21cc:2e5f:4a77%6]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 06:52:17 +0000
From: "Li, Lyndon" <Lyndon.Li@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the warning info when removing amdgpu
 device
Thread-Topic: [PATCH] drm/amdgpu: Fix the warning info when removing amdgpu
 device
Thread-Index: AQHZUJpDN40DiKY6j0+ULyzfum2wzq7ulm6AgABCsgCAAAdY8A==
Date: Tue, 7 Mar 2023 06:52:17 +0000
Message-ID: <CH0PR12MB5251F35E7F71B045506FBC29E8B79@CH0PR12MB5251.namprd12.prod.outlook.com>
References: <20230307021221.45890-1-Lyndon.Li@amd.com>
 <DM5PR12MB24698E2A9E22CB2F80FA8249F1B79@DM5PR12MB2469.namprd12.prod.outlook.com>
 <1ce9cf14-2d1b-29f8-57df-8e600b353f66@gmail.com>
In-Reply-To: <1ce9cf14-2d1b-29f8-57df-8e600b353f66@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-07T06:52:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=243224ea-0fed-45df-a88b-460d2eb25edb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-07T06:52:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8f42127a-f6f4-4c8b-a386-d1d31bb8fb55
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5251:EE_|BY5PR12MB4244:EE_
x-ms-office365-filtering-correlation-id: 1e0a1db9-e21f-4d42-191c-08db1ed87dd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jce9Uu1urLAebm8qZ19OdSuMyF3bxA4N8gnD3zNOcWpVv5IkqGmvU6vr9WbroLOudDSm7g86lcJWMXoFv4Y7KlE+z9A4X//Kyscv96qsMKTNjmkUfyW1Ri1FbD3u76Iow/SAjo/M/v4HoL0yHplQp7vuNatVyU+3esrCUdGW8bAi0igVvc37tpemfj/ORjZuSoBcw5d/bVG1J9vMnqIzNJX1ZNlDgsMJxLRsO2kXVfgTFja+gwAfwJ8Wvo8eoa5iUX9ljmwkKwPmGrcLaUrn+fbuW6aXeHgGN4Y6A10qAQNbcmWbezSEP/qgP322vokI0SqW4hZpL1DmKYeZCmkZ82BW+FcSgEGdnHjJmcogwDdB1ZZVdt0Y1S0U0TWbvH0EHJ+ii5qcwYcLb01jq7pJPlv7XBfnpuKI/gh74FAcpwUffU9yFy+CQLtBa6vmudGaDDFWKMAUAy/JHgyJG7zSYIv2Km9fWIMO4dEm+jhQLWWOK6R37uoh8bd0oEdsNV/nuU/eWXoryiYGTETmeCt9zqDEsO8pwEFNEtDd++X+SH/mTHPxprao4t8j16QVZgmyDz6yuIMS3UIonW4xlhqCh0fGQMyEhUiJUOB6kLTWlh3XwHLmYMqORO1FoG8qlOXK079gHxd0g9uxGdJaw4paAzhl1zxeaRsG0voNk2XZpFtuYKOz9dU4dXGoUOP/UgwVOj8/q9Di3LLK1ZmI07d/dA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5251.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199018)(2906002)(38100700002)(52536014)(122000001)(9686003)(186003)(6506007)(53546011)(38070700005)(7696005)(66446008)(64756008)(66556008)(66476007)(478600001)(76116006)(66946007)(8936002)(5660300002)(41300700001)(71200400001)(66574015)(110136005)(54906003)(316002)(33656002)(55016003)(8676002)(4326008)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjVqZ2tjb3EvRHFmd2phY3RuOHJWczFxdVRYQ0UwdzRJSzljc3VEL2prdzNk?=
 =?utf-8?B?K3RSWnV4TlVhS3BWTGs2eVEyVDYxbmRPaGhxMHdWbnFIMm1qWWw1L2lHNGNs?=
 =?utf-8?B?djJ3NXkwR3VwQS9YQUZxZ1ZGamJvUDJxQ0h3c2orKzRXWUNtU09ZN0pBT3ha?=
 =?utf-8?B?UXV3TDkyQjVLWWZ1c0xvYXZ4bWszLzdCYnlYTmFaUUNCSHhEb253bjcxQmM5?=
 =?utf-8?B?Vm1lT3lCSElhRXpKUG5ZUzhOL09Sc2pEUEhBT3g5c3I2eFZIajRXWndSa3Uz?=
 =?utf-8?B?TCtETFh6RXozWHErMVRGdlBSS3BrK0RWY1c2czBidk93REcyWHd5UndUTkVX?=
 =?utf-8?B?QytIYm5CUlJkczI5RDBiWUhUZ1hPdDZuZ0dXaUhOWkIzVnpzVGxsajJ0Nzl2?=
 =?utf-8?B?b2hBUkpqa1NzVCtxWVB3dCtNQTJJRTUxd1JBaVQzNW9VZHBQYXU3SHhkb3No?=
 =?utf-8?B?ZzQ4c3Y0MkEzZkZrcXpBWjJub0hHQXVLeW13eG8zVytSSTJZSVhlQzB3VmQ4?=
 =?utf-8?B?WXRLdW9qWmxiZXdwZExObEZkRVltQVdjWDBpQ3BzYzdEN3FoczZTSVNQR01k?=
 =?utf-8?B?dk1RSjFDbk1SWWRqaGRLR0lqSUpIRzFRN1ErZm0xRVhJL3R1WkpOcElHU2Er?=
 =?utf-8?B?WU9PVUpLSThVazZvYllxelF4ek11QVRyY2dtQzFnK01uZk9YY2dVNytqTW1O?=
 =?utf-8?B?QitLYkZEOVFWM0NkZEwySWdleGhzZU9xV2s3MTNkKzhpVTJsNkZvVkNwRWNu?=
 =?utf-8?B?bDlnKzhWSVFjSGdTeHMxMUJlazVDaWJrNVk2U255TCtvYk9mT1V1SzB2a0Mx?=
 =?utf-8?B?bmRLQW9WRUxmeThBTTZMa2psaTFzSWtWeEFDaXNvY3RjdUZLS3BEY1lRSXQ4?=
 =?utf-8?B?Z1pWNnZBSEVkWlRiMGVCR0dPSXRRWXVvV3hYQytJTUgwVnBpT1gyTDVlb25x?=
 =?utf-8?B?bHFKbXhqMm1NMzA3SkcyTVVHNThqTXd2YjNQd1hnOXR4ZG9PZHNtVytobWhQ?=
 =?utf-8?B?WWp1L3pVUkdIT2tndE5OR25VQ3k4c041d1ZCWGdycEdFOEFHNmc2ZEtEVUZy?=
 =?utf-8?B?eXdWajdjK2F3RjhxcGEvZFFVQlBnZU1HYWFLaFlVbFh1aDJnREl1M2w5Vlhv?=
 =?utf-8?B?MGRLRFhkSjZPa2JEaXJCMG9jdlZlQStFY21kWWRaUTVBeXdzUzdhQVFGVVpa?=
 =?utf-8?B?d3pEbTdadzdTMEM2ZGRHQXJKc2tmNGxZNkRXSDlMeWJ2ZjN5MitFSVlGMlM3?=
 =?utf-8?B?d2FSWEYwQzFpQVRTMERjVndqekN3eDFPM1pvaDRQQ0lpVjlQcHYwR3BFQnd0?=
 =?utf-8?B?WU1WZWxqL3FOd2ZQdmliZWhERitOWEw5SStVRzhqWHc0NGdsMkN0WjZ6V2xO?=
 =?utf-8?B?ZEpuN0lhNk1sZ01kTTIxeGhXaHMraHAweDFCWmh6Y2xLTTV4d3pvVTF6SkQ5?=
 =?utf-8?B?V3lQTVRFZ1FBYXd3b0RMejBDZTZiOHZUMkt0TEZ1SzFmL0U0eFpJWmhvd0dR?=
 =?utf-8?B?bTJXeGVHb1BIc054ZWt3QkFEMnA0NEVhK1Y3a1FVTjNkY2xuR3lteU1Mdkox?=
 =?utf-8?B?WTYvc1JVQ3dEc1Rod25vZklVNlBkY3dOVUFtaEtBYkxFWHdESUNuR3g5OC9j?=
 =?utf-8?B?V3h3c1kzeXBaY1VrSkw1aVdVL2I1VFRxMmFGRnUwYVc1U0x1M2k2SFg5NjBY?=
 =?utf-8?B?bXNTbmI3RWZWVWJUalluNUF2V0dTNmhUOTJrT3NCdmhudWYxMlBGTjZnNmth?=
 =?utf-8?B?MXBmUUtDamhYR2E2Y1RlMDBIWE84ZXhzb1FSRGRkZjJEVmhITnQ1UXQzVFhN?=
 =?utf-8?B?bGtRKzhIMHhjYWlTRUZnZW1tMlg1MnZ0VVptZldyc3g4eGJDV0dqWC9TSGlt?=
 =?utf-8?B?eXAxeWozUHk4MGFCd09mdXNKSjFOQ3k2dURSY2Rra0ZYa3UyZml4T3UxVlNM?=
 =?utf-8?B?OG1nM1h3M0NzQWgxcmxZQWdsRVhPWHRpdkE0cENwZFNNVlkvMkhUUkNuWlZt?=
 =?utf-8?B?Y2oxRGdKUlpxWGNlZlhFVWh6TGRnZGFFYmZDdlFIMXNBdkExMzV4UXQvL0pC?=
 =?utf-8?B?WElPak1qY3VESGV2R1A4alZINy91b01QbVJiQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5251.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0a1db9-e21f-4d42-191c-08db1ed87dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 06:52:17.5344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kxm/K/gRsbxg8Bk4TGFI44Dcs2vw8FJSS3aZkHofyvcYKme/vFvzxfjXqfxHTX8EKFlpYoexid47nN2t1aGHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcywgd2lsbCB1cGRhdGUg
aXQuDQoNClJlZ2FyZHMsDQpMeW5kb24NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNv
bT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggNywgMjAyMyAyOjIyIFBNDQo+IFRvOiBDaGVuLCBH
dWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBMaSwgTHluZG9uDQo+IDxMeW5kb24uTGlAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBYdSwgRmVpZmVpIDxG
ZWlmZWkuWHVAYW1kLmNvbT47IE1hLCBKdW4gPEp1bi5NYTJAYW1kLmNvbT47DQo+IFByb3N5YWss
IFZpdGFseSA8Vml0YWx5LlByb3N5YWtAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZp
eCB0aGUgd2FybmluZyBpbmZvIHdoZW4gcmVtb3ZpbmcNCj4gYW1kZ3B1IGRldmljZQ0KPiANCj4g
VGhlIGNvbW1pdCBtZXNzYWdlIHJlYWRzIGEgYml0IGJ1bXB5LiBHZW5lcmFsbHkgYmVzdCBwcmFj
dGljZSBhcmU6DQo+IA0KPiBTaG9ydCAoNzIgY2hhcnMgb3IgbGVzcykgc3VtbWFyeQ0KPiANCj4g
TW9yZSBkZXRhaWxlZCBleHBsYW5hdG9yeSB0ZXh0LiBXcmFwIGl0IHRvIDcyIGNoYXJhY3RlcnMu
IFRoZSBibGFuayBsaW5lDQo+IHNlcGFyYXRpbmcgdGhlIHN1bW1hcnkgZnJvbSB0aGUgYm9keSBp
cyBjcml0aWNhbCAodW5sZXNzIHlvdSBvbWl0IHRoZSBib2R5DQo+IGVudGlyZWx5KS4NCj4gDQo+
IFdyaXRlIHlvdXIgY29tbWl0IG1lc3NhZ2UgaW4gdGhlIGltcGVyYXRpdmU6ICJGaXggYnVnIiBh
bmQgbm90ICJGaXhlZCBidWciDQo+IG9yICJGaXhlcyBidWcuIiBUaGlzIGNvbnZlbnRpb24gbWF0
Y2hlcyB1cCB3aXRoIGNvbW1pdCBtZXNzYWdlcw0KPiBnZW5lcmF0ZWQgYnkgY29tbWFuZHMgbGlr
ZSBnaXQgbWVyZ2UgYW5kIGdpdCByZXZlcnQuDQo+IA0KPiBGdXJ0aGVyIHBhcmFncmFwaHMgY29t
ZSBhZnRlciBibGFuayBsaW5lcy4NCj4gDQo+IC0gQnVsbGV0IHBvaW50cyBhcmUgb2theSwgdG9v
Lg0KPiAtIFR5cGljYWxseSBhIGh5cGhlbiBvciBhc3RlcmlzayBpcyB1c2VkIGZvciB0aGUgYnVs
bGV0LCBmb2xsb3dlZCBieSBhDQo+ICDCoCBzaW5nbGUgc3BhY2UuIFVzZSBhIGhhbmdpbmcgaW5k
ZW50Lg0KPiANCj4gQXBhcnQgZnJvbSB0aGF0IHRoZSBwYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZw0KPiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiANCj4gUmVnYXJkcywN
Cj4gQ2hyaXN0aWFuLg0KPiANCj4gQW0gMDcuMDMuMjMgdW0gMDM6MjMgc2NocmllYiBDaGVuLCBH
dWNodW46DQo+ID4gUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBHdWNodW4NCj4gPg0KPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogbHluZG9ubGkgPEx5bmRvbi5MaUBhbWQuY29tPg0KPiA+
IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDcsIDIwMjMgMTA6MTIgQU0NCj4gPiBUbzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBDYzogUHJvc3lhaywgVml0YWx5IDxWaXRhbHkuUHJv
c3lha0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBDaGVuLCBHdWNodW4NCj4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBYdSwNCj4gPiBGZWlm
ZWkgPEZlaWZlaS5YdUBhbWQuY29tPjsgTWEsIEp1biA8SnVuLk1hMkBhbWQuY29tPjsgTGksIEx5
bmRvbg0KPiA+IDxMeW5kb24uTGlAYW1kLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IEZpeCB0aGUgd2FybmluZyBpbmZvIHdoZW4gcmVtb3ZpbmcNCj4gYW1kZ3B1DQo+ID4g
ZGV2aWNlDQo+ID4NCj4gPiBBY3R1YWxseSwgdGhlIGRybV9kZXZfZW50ZXIgaW4gcHNwX2NtZF9z
dWJtaXRfYnVmIGRvZXMgbm90IHByb3RlY3QNCj4gYW55dGhpbmcuDQo+ID4gQW5kIGl0IGlzIG5v
dCB1c2VkIHRvIHByZXZlbnQgY29uY3VycmVudCBhY2Nlc3MuDQo+ID4gSWYgRFJNIGRldmljZSBp
cyB1bnBsdWdnZWQsIGl0IHdpbGwgYWx3YXlzIGNoZWNrIHRoZSBjb25kaXRpb24gaW4gV0FSTl9P
Ti4NCj4gPiBXZSdkIGJldHRlciBub3Qga2VlcCBhZGRpbmcgY29tbWFuZHMgdG8gdGhlIGxpc3Qu
DQo+ID4gU2ltcGx5IG1vdmluZyB0aGUgZHJtX2Rldl9lbnRlci9kcm1fZGV2X2V4aXQgaGlnaGVy
IGxldmVsIHdpbGwgbm90DQo+IHNvbHZlIHRoZSBpc3N1ZS4NCj4gPiBCZWNhdXNlIHBzcF9jbWRf
c3VibWl0X2J1ZiBpcyBjYWxsZWQgaW4gbWFueSBwbGFjZXMsIHN1Y2ggYXMNCj4gcHNwX2h3X2lu
aXQtLT5wc3BfbG9hZF9mdywgcHNwX3N1c3BlbmQtLT5wc3BfeGdtaV90ZXJtaW5hdGUsDQo+IGFt
ZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXItLT5hbWRncHVfcmFzX3N1c3BlbmQuDQo+ID4gU28gZHJv
cCBkcm1fZGV2X2VudGVyL2RybV9kZXZfZXhpdCBpbiBwc3BfY21kX3N1Ym1pdF9idWYuDQo+ID4N
Cj4gPiBXaGVuIHJlbW92aW5nIGFtZGdwdSwgdGhlIGNhbGxpbmcgb3JkZXIgYXMgZm9sbG93czoN
Cj4gPiBhbWRncHVfcGNpX3JlbW92ZQ0KPiA+IAlkcm1fZGV2X3VucGx1Zw0KPiA+IAlhbWRncHVf
ZHJpdmVyX3VubG9hZF9rbXMNCj4gPiAJCWFtZGdwdV9kZXZpY2VfZmluaV9odw0KPiA+IAkJCWFt
ZGdwdV9kZXZpY2VfaXBfZmluaV9lYXJseQ0KPiA+IAkJCQlwc3BfaHdfZmluaQ0KPiA+IAkJCQkJ
cHNwX3Jhc190ZXJtaW5hdGUNCj4gPiAJCQkJCQlwc3BfdGFfdW5sb2FkeWUNCj4gPg0KPiAJcHNw
X2NtZF9zdWJtaXRfYnVmDQo+ID4NCj4gPiBbIDQ1MDcuNzQwMzg4XSBDYWxsIFRyYWNlOg0KPiA+
IFsgNDUwNy43NDAzODldICA8VEFTSz4NCj4gPiBbIDQ1MDcuNzQwMzkxXSAgcHNwX3RhX3VubG9h
ZCsweDQ0LzB4NzAgW2FtZGdwdV0gWyA0NTA3Ljc0MDQ4NV0NCj4gPiBwc3BfcmFzX3Rlcm1pbmF0
ZSsweDRkLzB4NzAgW2FtZGdwdV0gWyA0NTA3Ljc0MDU3NV0NCj4gPiBwc3BfaHdfZmluaSsweDI4
LzB4YTAgW2FtZGdwdV0gWyA0NTA3Ljc0MDY2Ml0NCj4gPiBhbWRncHVfZGV2aWNlX2ZpbmlfaHcr
MHgzMjgvMHg0NDIgW2FtZGdwdV0gWyA0NTA3Ljc0MDc5MV0NCj4gPiBhbWRncHVfZHJpdmVyX3Vu
bG9hZF9rbXMrMHg1MS8weDYwIFthbWRncHVdIFsgNDUwNy43NDA4NzVdDQo+ID4gYW1kZ3B1X3Bj
aV9yZW1vdmUrMHg1YS8weDE0MCBbYW1kZ3B1XSBbIDQ1MDcuNzQwOTYyXSAgPw0KPiA+IF9yYXdf
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSsweDI3LzB4NDMNCj4gPiBbIDQ1MDcuNzQwOTY1XSAgPyBf
X3BtX3J1bnRpbWVfcmVzdW1lKzB4NjAvMHg5MCBbIDQ1MDcuNzQwOTY4XQ0KPiA+IHBjaV9kZXZp
Y2VfcmVtb3ZlKzB4MzkvMHhiMCBbIDQ1MDcuNzQwOTcxXSAgZGV2aWNlX3JlbW92ZSsweDQ2LzB4
NzANCj4gWw0KPiA+IDQ1MDcuNzQwOTcyXSAgZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVybmFs
KzB4ZDEvMHgxNjANCj4gPiBbIDQ1MDcuNzQwOTc0XSAgZHJpdmVyX2RldGFjaCsweDRhLzB4OTAg
WyA0NTA3Ljc0MDk3NV0NCj4gPiBidXNfcmVtb3ZlX2RyaXZlcisweDZjLzB4ZjAgWyA0NTA3Ljc0
MDk3Nl0NCj4gPiBkcml2ZXJfdW5yZWdpc3RlcisweDMxLzB4NTAgWyA0NTA3Ljc0MDk3N10NCj4g
PiBwY2lfdW5yZWdpc3Rlcl9kcml2ZXIrMHg0MC8weDkwIFsgNDUwNy43NDA5NzhdICBhbWRncHVf
ZXhpdCsweDE1LzB4MTIwDQo+ID4gW2FtZGdwdV0NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGx5
bmRvbmxpIDxMeW5kb24uTGlAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDE3ICstLS0tLS0tLS0tLS0tLS0tDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiA+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gaW5kZXggNGM2
MTdmYWFhN2M5Li4wMmY5NDhhZGFlNzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gQEAgLTYwMywyNyArNjAzLDE0IEBAIHBzcF9jbWRfc3Vi
bWl0X2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwNCj4gPiAgIAkJICAgc3RydWN0IHBzcF9n
ZnhfY21kX3Jlc3AgKmNtZCwgdWludDY0X3QgZmVuY2VfbWNfYWRkcikNCj4gew0KPiA+ICAgCWlu
dCByZXQ7DQo+ID4gLQlpbnQgaW5kZXgsIGlkeDsNCj4gPiArCWludCBpbmRleDsNCj4gPiAgIAlp
bnQgdGltZW91dCA9IDIwMDAwOw0KPiA+ICAgCWJvb2wgcmFzX2ludHIgPSBmYWxzZTsNCj4gPiAg
IAlib29sIHNraXBfdW5zdXBwb3J0ID0gZmFsc2U7DQo+ID4gLQlib29sIGRldl9lbnRlcmVkOw0K
PiA+DQo+ID4gICAJaWYgKHBzcC0+YWRldi0+bm9faHdfYWNjZXNzKQ0KPiA+ICAgCQlyZXR1cm4g
MDsNCj4gPg0KPiA+IC0JZGV2X2VudGVyZWQgPSBkcm1fZGV2X2VudGVyKGFkZXZfdG9fZHJtKHBz
cC0+YWRldiksICZpZHgpOw0KPiA+IC0JLyoNCj4gPiAtCSAqIFdlIGFsbG93IHNlbmRpbmcgUFNQ
IG1lc3NhZ2VzIExPQURfQVNEIGFuZCBVTkxPQURfVEENCj4gd2l0aG91dCBhY3F1aXJpbmcNCj4g
PiAtCSAqIGEgbG9jayBpbiBkcm1fZGV2X2VudGVyIGR1cmluZyBkcml2ZXIgdW5sb2FkIGJlY2F1
c2Ugd2UgbXVzdCBjYWxsDQo+ID4gLQkgKiBkcm1fZGV2X3VucGx1ZyBhcyB0aGUgYmVnaW5uaW5n
ICBvZiB1bmxvYWQgZHJpdmVyIHNlcXVlbmNlIC4gSXQgaXMNCj4gdmVyeQ0KPiA+IC0JICogY3J1
Y2lhbCB0aGF0IHVzZXJzcGFjZSBjYW4ndCBhY2Nlc3MgZGV2aWNlIGluc3RhbmNlcyBhbnltb3Jl
Lg0KPiA+IC0JICovDQo+ID4gLQlpZiAoIWRldl9lbnRlcmVkKQ0KPiA+IC0JCVdBUk5fT04ocHNw
LT5jbWRfYnVmX21lbS0+Y21kX2lkICE9DQo+IEdGWF9DTURfSURfTE9BRF9BU0QgJiYNCj4gPiAt
CQkJcHNwLT5jbWRfYnVmX21lbS0+Y21kX2lkICE9DQo+IEdGWF9DTURfSURfVU5MT0FEX1RBICYm
DQo+ID4gLQkJCXBzcC0+Y21kX2J1Zl9tZW0tPmNtZF9pZCAhPQ0KPiBHRlhfQ01EX0lEX0lOVk9L
RV9DTUQpOw0KPiA+IC0NCj4gPiAgIAltZW1zZXQocHNwLT5jbWRfYnVmX21lbSwgMCwgUFNQX0NN
RF9CVUZGRVJfU0laRSk7DQo+ID4NCj4gPiAgIAltZW1jcHkocHNwLT5jbWRfYnVmX21lbSwgY21k
LCBzaXplb2Yoc3RydWN0DQo+IHBzcF9nZnhfY21kX3Jlc3ApKTsgQEAgLTY4Nyw4ICs2NzQsNiBA
QCBwc3BfY21kX3N1Ym1pdF9idWYoc3RydWN0DQo+IHBzcF9jb250ZXh0ICpwc3AsDQo+ID4gICAJ
fQ0KPiA+DQo+ID4gICBleGl0Og0KPiA+IC0JaWYgKGRldl9lbnRlcmVkKQ0KPiA+IC0JCWRybV9k
ZXZfZXhpdChpZHgpOw0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICB9DQo+ID4NCj4gPiAtLQ0K
PiA+IDIuMzQuMQ0KPiA+DQo=
