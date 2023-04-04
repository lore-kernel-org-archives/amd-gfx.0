Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940CFC6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 14:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE40010E6CF;
	Tue,  4 Apr 2023 14:46:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C6410E6CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 14:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNQMI0ji+w3WCG1os/j+BiCit63nfmu7bHMYsrcqXlBg0VKCIVXwjaZbbvFJHcp2xWCYjZRWwJDj+IcUBnjlTDEMIKrlZ/fsG2lhqEd6AS48eQwXLySm+/Es2LfL/94PRQ5hTbqH4LhW6mn4zK6HPjBqnjMwcA5AgRokChgamUNKM0r+46gPXMu57lWuD4lwtsL+YufqqncO8DNTRxJuYamDvbhFGc17ZvnsMgbf0youdbqI8uAQx2y5sepb24/I1MBL6M8xHiThGykLyfn0XUrsWdvMRov5KUL+ia0PiFHlfLUJOilklJeirce3nAInwmbaBv/KZXuLKPSc82j+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNbQvhuX2OMt6fy3OSEVM1X6rBMSJsr+Y5grYbaluio=;
 b=YGNU2YLgleLSa0qhqhUN5nuRjmF0451t3616wRMVDGdFU8p02IzlNaZC3PMkF61K82BQKw4tHH4PKtzZgABlD/nhLsIp5977AM62X8wwXCzfavF26Km0DvDduunKVDL8PLFCD6wgqYaTruUbqPRkT9MuUKnCv0Q/Y7U5PV1mJMitBivk9qTYJ+HyLtWNe657x6IQ0Wq4eRqUST+s4c+E2yQkim8/wissE18aTQ0JC49i1D1Mp+l3yXCzuU7UfhQfANv3uOaGOAT4hMNFHQvsrTRzU9md/gYKlmUnJcC3c5KGg4P5LLZNmp91stlLGXSXxxLh2qW4rvxLvIsxebyYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNbQvhuX2OMt6fy3OSEVM1X6rBMSJsr+Y5grYbaluio=;
 b=JJzxnsqOycx+66x7ahvEwvHE2BnCI2aShVR/Ey2/eBA1wZFEcKzbUQF937pdFOP+mOHOv1/EfVIZCiHZ7swTW25fXXZZBGTno33tBKpyEqvF0xY5JE05xv6BJ8CWaafQJzq1EtEOJ+TBj3iP+V63T+GD6BuAu53jHCrg50DO6tY=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 14:46:39 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::6b6e:7238:b357:8185]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::6b6e:7238:b357:8185%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:46:39 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: DROP redundant
 drm_prime_sg_to_dma_addr_array
Thread-Topic: [PATCH 3/3] drm/amdgpu: DROP redundant
 drm_prime_sg_to_dma_addr_array
Thread-Index: AQHZZtvd7IRA0nro/k+QlhBhRD8R+68bLZqAgAAM2wA=
Date: Tue, 4 Apr 2023 14:46:39 +0000
Message-ID: <DM4PR12MB52618FBB7C299AA3EF20406E9D939@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <20230404095640.3277840-3-shane.xiao@amd.com>
 <73dfa0fe-4ea1-26bf-cf49-57b4f873a765@amd.com>
In-Reply-To: <73dfa0fe-4ea1-26bf-cf49-57b4f873a765@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-04T14:46:36Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b1deaaa9-a85a-4209-83ab-c49fbe7c7973;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-04T14:46:36Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bb1e83c5-28c8-4997-b160-d2bbe055d05f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|SJ2PR12MB8157:EE_
x-ms-office365-filtering-correlation-id: 18ccd93f-63e4-424b-d1a8-08db351b660a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oosxkXPdLOR1BpS3J2o29YBrjuQCyrK6Yv0rhOCDS7dCMj+/lEgX0fP8Bj6na/p5KRmMfymjptpwhZ7DJTqU2vPV/c0KuQUnmSPWogOpks8IztVcThZRTrlmRUTwnvco7BehgrlXaKnFBzmIJDXhz52FHvwLSHfuSf/w+wcUnGQJBbzprddf/kWt9qQMuHDCWCr7nPKbja4L6LLD/J4ZkBfX3N3kECBIRZUORQ5aNbBou5WzfqtawcS1QjvTrZKM2cFUTktJfGmE+W+QJD5lz+siiYJiAobPa4upGpni+gqmN7QBM4AJc9CZu/B3VRjCsI+/LXN5U3mlTKrpw4nNtxdivuVTRiwxSG+Z6cMM1AviSQULLbphiWO5WhdqDoC5ya1BeMBtTHd2OsvS19txxSr77aGAfVeMj4h1gVCJwp8vhyh4Jz609fbh6olji1xp8r0EzcZ5eTVVqjziRAZMfRDIgTKoZZOrNCONDMAa5otzwoHnTq8fGRDugV9qys3+D3flFp/ia0veCH7aeteUqcbnAIAvAKdyIydQxrKfFyJ4nXawJNMpOJ/zBUCLlTJXAobPJXlAyL8KCXqy5e83jbwb97B4U0SU1qLtOetj7Kg78A49waW1NeI1Q/9g2/TD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(38070700005)(9686003)(6506007)(26005)(33656002)(86362001)(53546011)(122000001)(83380400001)(55016003)(38100700002)(186003)(66446008)(66556008)(66476007)(66946007)(64756008)(478600001)(76116006)(4326008)(52536014)(5660300002)(316002)(8676002)(2906002)(110136005)(41300700001)(8936002)(71200400001)(7696005)(6636002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWpTRzNDdVlWM2lrQ2VROWR4R3NaZnZxOFAxUEdNa1F1MjNhelZRVGl5eUds?=
 =?utf-8?B?WFVPV0xlSGE2WENXQVNUNktueVNESDRuZ2lQdTgwWThhYk5VWWsveDBXTGRL?=
 =?utf-8?B?SThNR2RIQndLZFk5TXQ4R0tmU1JXd1Z4M3hwVmZmUEFDUDdxYzFXZmpkbCtN?=
 =?utf-8?B?d0RhQmVJeVd1Z3RtRWJET2dRcmkvMzZuVkNyY2tiV25vaWhEdDRsSTlGWTB6?=
 =?utf-8?B?U2Q2M29LMVNpcUFWdUF1dStEdDAxeklOaGJwWXhHbk1MWUZXOXM2ajNIdUJa?=
 =?utf-8?B?dGdHNHdnOU4yNFllV3dWMnkrUk1uZkI3MjdocVl1bVNyTndkSm1KWUhZYU9u?=
 =?utf-8?B?NGFyN1FzdFNKUCsxeDM1cUNYU0dMRkZhbmlreWRxL0Y0OWFqQWJoem0xZXFW?=
 =?utf-8?B?NGQxZVZSZ1Jzc05ybUwzSWdrL3UxUm1XdGhaWFRyd1hOTFVNanJ6djExdFhP?=
 =?utf-8?B?NFpwMW5YZjEremZFUTRFYXNtZEU0VmU0MmQ4bWd3UXdhb0pEek85Qmlxa3or?=
 =?utf-8?B?Y054NlV3bk1uZkFrK3BrVGVpMTB0TnExNVM0emhRdk0vd2RDS2IxazRiSVNF?=
 =?utf-8?B?YmdsaGthaVhSeGNwZUtUcnJMdkg1NEpaTFUrSjZCbnNzTHlQTGg2MEVDbU5j?=
 =?utf-8?B?YVlQTi9sRnBWTnVaTktaNldzV0JxNW4vSzRwWW1uWE5rY1dUWlhzTk1EODlF?=
 =?utf-8?B?V1EzSXBCclZTUmExYXFnRzVKSWdyV1ZPUTM2NzR3WUozdnE0eUtFZk81bHRJ?=
 =?utf-8?B?OXR2YUMyZDJBajZVSDhpK0JXOCsrL0ZHUjdNeEo3VzMzeGJUL0dtditkOEhs?=
 =?utf-8?B?WjE1RjdadlFpdTNySlJzOXo1ZFFnVmZrQXN3K1ZzR1FSTkhJOXk4RjROK1lo?=
 =?utf-8?B?M3U1WXFsK2ZjQy9TVER5NGxEbnJtYWY4c25zV3dHc2NkUmpHZUdGTGYweDM2?=
 =?utf-8?B?YzdjWjNTQUI2bXJtNHNmUWV3UjNHemM3UUV3aVd3ZUp6dlRnZWpsMW56Nklk?=
 =?utf-8?B?aVdFRzRLZ1kzVU41NENPMDVjOVNURVpCSmxFTHkzUWhxcDdVcmV0L1lDNWxE?=
 =?utf-8?B?RDRmVFFLeEdVMnNTcVY1WWVNL0RvOTI1eHNQWUNITXdtSEh0YW5PZXp2eG1N?=
 =?utf-8?B?b0ZtS1R1ajdBcmQzTm9KUi94RlF3ZmF5Tm9qNlZwakNYMUllSlZPMnppUzRx?=
 =?utf-8?B?K0dFSG1ha2JTNWcrMzJPKzNLcmFKUjlWRVo2YWw1UW5VZzk0R1ltc1VJRVB1?=
 =?utf-8?B?SExDNGxSVlFmOVNxaVZiNWlwczRtZTlOd2ZPQVJXWnUxV2pBODZPWnRqOS8z?=
 =?utf-8?B?MStqMTBaOVlLbEMwa09tM29YUllrcldmZFVyd3JsOHFQZ2tOdEwxU1loVFRz?=
 =?utf-8?B?eUV0b2xPdUlTY0VkNXZhM2E5eUducHk2QmpFRFdoRFNqdUJzZ285YWtMcklE?=
 =?utf-8?B?Y0lNcm1TL012YWp4WUNoRWdkakxvRWJ2VWdWSGc0dTBBV0Z0dWthS2pwd09H?=
 =?utf-8?B?Z1A4cno5UElVaXVldUNrYnhVSVI1WS9SL01DTEYzdE9MdG40aC9DeWs3aVJM?=
 =?utf-8?B?TGNlamhBRVBNdnlnV3RlQnJCcmxzNWZDRVdEczNDcU9BU01ONm8wYWVOeHlK?=
 =?utf-8?B?TndUd1d6RVRvS1Z0a2czK1NvUm41aUw0R1htZnI4Q2FCNlo3ZS9HcHQ2S2JG?=
 =?utf-8?B?Vlp5T1dKQlYrNkNvTW16dmZVVFRzdGJjaUJWZ0NwNlpNWWtUNlFtSm1PZzlD?=
 =?utf-8?B?U08wV3NsVjZURmhkU0hHNG5LT1IxQUFNZjdzaTZrQzkrbEh4K3ViaElvandw?=
 =?utf-8?B?UDlKV3dNcm5hUE5iN2FLRFdncTQySGFDbko5S3c3clhKdnF5TmYvY09QNENJ?=
 =?utf-8?B?KytQNDlTSlZtUFNMbXd5U3FKT1NuRzdxNGpqaEVJS2lmaTVoRS90cHJMMFhS?=
 =?utf-8?B?cEtpMDk4eDhlWjdvd3dsYmZ1NHorZkduOE9Kd3lNUmwvSnV0SE5BRHRhRG1S?=
 =?utf-8?B?UWMrbGJSZFMwVzJnOWZ5L0dNT1ZSUXM1MzQwVFF4OFVDZ3NDamtQZUZJZXFS?=
 =?utf-8?B?Nm15RXR1M3hUYzEzczRpVk81NVRNdVZtK3U4cDR4U29icyt5SGFrV0tmM0ds?=
 =?utf-8?Q?0O3E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ccd93f-63e4-424b-d1a8-08db351b660a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 14:46:39.5223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eoMUGvQyABD8/8fVzNrfG2L/0dzC88uL7zsig1DwdEh9EsG0nPbk43VotG95918tMp4rfo0b8wbDcj7n8/tzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
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
Cc: "Liu, Aaron" <Aaron.Liu@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgNCwgMjAyMyA5OjU5IFBNDQo+IFRvOiBYaWFv
LCBTaGFuZSA8c2hhbmUueGlhb0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IENj
OiBMaXUsIEFhcm9uIDxBYXJvbi5MaXVAYW1kLmNvbT47IEd1bywgU2hpa2FpIDxTaGlrYWkuR3Vv
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBkcm0vYW1kZ3B1OiBEUk9QIHJl
ZHVuZGFudA0KPiBkcm1fcHJpbWVfc2dfdG9fZG1hX2FkZHJfYXJyYXkNCj4gDQo+IEFtIDIwMjMt
MDQtMDQgdW0gMDU6NTYgc2NocmllYiBTaGFuZSBYaWFvOg0KPiA+IEZvciBETUEtTUFQIHVzZXJw
dHIgb24gb3RoZXIgR1BVcywgdGhlIGRtYSBhZGRyZXNzIGFycmF5IGhhcyBiZWVuDQo+ID4gcG9w
dWxhdGVkIGluIGFtZGdwdV90dG1fYmFja2VuZF9iaW5kLg0KPiANCj4gT0suIEkgdGhpbmsgImhh
cyBiZWVuIHBvcHVsYXRlZCIgc2hvdWxkIGJlICJ3aWxsIGJlIHBvcHVsYXRlZCIsIGJlY2F1c2UN
Cj4gYW1kZ3B1X3R0bV9iYWNrZW5kX2JpbmQgaGFwcGVucyBhcyBhIGNhbGxiYWNrIGZyb20gdGhl
IHR0bV9ib192YWxpZGF0ZQ0KPiBjYWxsIGJlbG93LiBXaXRoIHRoYXQgZml4ZWQgaW4gdGhlIHBh
dGNoIGRlc2NyaXB0aW9uLCB0aGUgcGF0Y2ggaXMNCg0KWWVzLCBJIHdpbGwgZml4IHRoZSBjb21t
ZW50Lg0KDQpCZXN0IFJlZ2FyZHMsDQpTaGFuZQ0KDQo+IA0KPiBSZXZpZXdlZC1ieTogRmVsaXgg
S3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IA0KPiANCj4gPg0KPiA+IFJlbW92
ZSB0aGUgcmVkdW5kYW50IGNhbGwgZnJvbSB0aGUgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU2hhbmUgWGlhbyA8c2hhbmUueGlhb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgMyAtLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gaW5k
ZXggYmNiMGE3YjMyNzAzLi45NGVlOGY2MzhjMTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gQEAgLTQ4OCw5
ICs0ODgsNiBAQCBrZmRfbWVtX2RtYW1hcF91c2VycHRyKHN0cnVjdCBrZ2RfbWVtICptZW0sDQo+
ID4gICAJaWYgKHVubGlrZWx5KHJldCkpDQo+ID4gICAJCWdvdG8gcmVsZWFzZV9zZzsNCj4gPg0K
PiA+IC0JZHJtX3ByaW1lX3NnX3RvX2RtYV9hZGRyX2FycmF5KHR0bS0+c2csIHR0bS0+ZG1hX2Fk
ZHJlc3MsDQo+ID4gLQkJCQkgICAgICAgdHRtLT5udW1fcGFnZXMpOw0KPiA+IC0NCj4gPiAgIAlh
bWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLA0KPiBBTURHUFVfR0VNX0RPTUFJTl9H
VFQpOw0KPiA+ICAgCXJldCA9IHR0bV9ib192YWxpZGF0ZSgmYm8tPnRibywgJmJvLT5wbGFjZW1l
bnQsICZjdHgpOw0KPiA+ICAgCWlmIChyZXQpDQo=
