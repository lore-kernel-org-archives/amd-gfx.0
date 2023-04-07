Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C8FC761A6
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 02:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E84D10E142;
	Fri,  7 Apr 2023 02:47:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE1410E142
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 02:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVMsd0M1cL7lT+xozW6uRsaNHlXJrW5sdVd4zubhcPUTnfVCxgb4s7wjM+pwRJb6NAnK3FcX2hCW8tDkH79NHm8Eh7RRqmmPl9otXzYv5ZgyfKyZA0BAVHPm8ORtRdHbg8zxRjJzez7RWdTWg+HRCoIYYYDP7yUeW862WGaEYfB8S8gI/9qeNo5TL+vTAQj0Tv5IY1XO3JQcJsX7sXpLyyf/I6s64lLs68clKo/UxJe7IwReClTi1T7Vn65QLeXTXr9lcegzP7Q35oKOsZo0RLnzClNC79HJkv995j4fu8Jol2DiopUg6dHe7HJTrsjYYPFhBuzZJ88mzgp4VyDHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UDNFEVkRbQ+GhyA277k3bcYa/Vuxed4Lv++UOP3p8w=;
 b=SAc1BwNmB2JK911qOHVKYKGHZCfiJTDjZzguTXT6CQPaA8xZ6PMzfVRYkp7oTceFgrB9/CkVQJ+CQui6svs6mkNNIOVFznI60X/cp8Q8q1cz+wxckLbBlyercfuTr/1UfolCUMBlXq9krstq+Qo3gSfP+6eliZPayjjeX1+JOLKE+74bzp3/ZQ1TO2bWmag9eQ9JDu+gFfwO3XfEiAtb7aklPmjlZfjS5txqK8n8B6BbJp74oA65ST383nyEoDxpxiIZen1nlQZGcKNSPHAmE2vuw3/Ya9x1j+/Df3OJN9yWeUuVjxH//GQyy4ybervdQX0I9nf2NhhCTyxptE9AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UDNFEVkRbQ+GhyA277k3bcYa/Vuxed4Lv++UOP3p8w=;
 b=CyjWakGOQ/CRyoH3Lo5nwa+VpS/GiOOkLQnCpvjwFKSLU1xoyCuz8cvKKu/BnktnvtUvoFS7udg2W7QhDxZR7JF12aURw9XQ8IxX9uYSOFNKxdnetYms/bBPRLKm2bn6E1UDyquds/D0I5Y1YxeTrydYi3a6G6VnpNEyLYbU0sw=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28; Fri, 7 Apr 2023 02:47:09 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::3e72:eac:4e50:d003]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::3e72:eac:4e50:d003%4]) with mapi id 15.20.6277.030; Fri, 7 Apr 2023
 02:47:08 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH v5 2/2] drm/amd/pm/vangogh: Send SMT enable message to PMFW
Thread-Topic: [PATCH v5 2/2] drm/amd/pm/vangogh: Send SMT enable message to
 PMFW
Thread-Index: AQHZaIWvdWC1JaO4X0qOTSc/pw8Xi68eUKMAgADSgOA=
Date: Fri, 7 Apr 2023 02:47:08 +0000
Message-ID: <DM6PR12MB35314D15A337BB8CCA81DDEDFD969@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230406124514.2906870-1-WenYou.Yang@amd.com>
 <20230406124514.2906870-3-WenYou.Yang@amd.com>
 <3b45e949-e55c-46d0-a439-2f86b7073a0f@amd.com>
In-Reply-To: <3b45e949-e55c-46d0-a439-2f86b7073a0f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-07T02:47:04Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9ae7a5b0-fc8a-4464-862c-5f3a052ecac7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|DM4PR12MB6062:EE_
x-ms-office365-filtering-correlation-id: e39110c0-ea1d-4db1-5400-08db3712614b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNaHCjs2w3hAB59PE6pIlj4E82obQ4+yIzavP1liTTMulVqQoj5Kencunl6O7x5sd9S/VK0ERtoQ5MQDagNcb4kGU0xZ5HBWqNXZ/G8wcB6yJdZ3fPyjtfbptGP0/4qWgvEbi8KvIvtZPefSzFUYcAzELjlOTVTv6buhZAuXBoXo2zAXDumFVJV4oZgo+d0F5lkVdluWwSzddBnIGWw105x/mE1ebprC/iqLivIcAwsVF30PXWDrHMV7Kapn+HRZz81AJAuvq+zwjz3vOViWfISIp12284aQgD68vE6fX1qnf5Og46CUIx6hnlurkGSryFXZRBans7yrAnFdxnPUOo5iKsR9R9IBgR0t8IEbygR2TrWUm5GruM84PDCTu5jAkehgvs1BT/S+QTrRP6Avm4YrK/gZ3qaQeQiwzp0qIPlX9oaI3icAH9yNyj4pw97tRwjgRhh0blgybRcX8Q3NQU14sjsPLplGGVfwdyYfGOBah4H1scDSJhGFwJYVE+7mXAJA/WABn/paUgMNrKpVHCMA6mZfQr8X/t9HwlrXe6hR9nmKemp3a2/I01GArwM/YwuBprYbCmSlEbtg9mvzuM6gAv+rri+FdmtTOIN1r6h18EhDtAkOeMuFO/SLMVVogb0BqhejtSWgsUc7NvaO/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(83380400001)(921005)(55016003)(122000001)(66556008)(38100700002)(66476007)(66446008)(41300700001)(64756008)(66946007)(316002)(5660300002)(54906003)(4326008)(8676002)(52536014)(110136005)(8936002)(6636002)(71200400001)(186003)(7696005)(6506007)(76116006)(9686003)(26005)(53546011)(478600001)(33656002)(2906002)(15650500001)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1Z3bkpkeFBlY0pjdGZLdGxNU252QWl2Mnk4SEZJb1ErSVFLdnpmUFFRWWNq?=
 =?utf-8?B?YlZRRHBYcDdudTUwVHBUUXdGekMrYlpTUW9yNlo4ZHdTR0Z6Mmh3b2w4Vkk3?=
 =?utf-8?B?RVVRcjBNNnNjR2tyRmt4VU9udklnQnlkVDl6bnR3UVcxd2dNb1BVb0dURXdO?=
 =?utf-8?B?RFNkNmp5QjNMOEhBd3djaDBIYm9pVjhMZTZYVTJ3UGVnajB6bkZ3LytYbTlT?=
 =?utf-8?B?RVpVeXFIVnlVaG5JMEFtcjkvY3MrT3RoMzJiU2VhN0p0VFI2NkJVODRsT3NX?=
 =?utf-8?B?Z2ZQVjFtcnJKeWJFNXFGVTZiQkw3bHkwa3NBOEZ0dmNMcUhTR04zWlhUTzNZ?=
 =?utf-8?B?c1J2YWpPN2U5N0FHZXpMTHIvaFhXb2ZkK0lxYjd5UzFSbGd6OUxOeFpFZW5N?=
 =?utf-8?B?eENVWE5SRGxJK2ljbEV0L1A4WTFYaUZSb2FmdjNWRklJaFRTdWNDMEt1ODVE?=
 =?utf-8?B?THdHS2hnL3dVR0Z3dVN4ZFBjeTRpL3IwZkpOMitCcXhOQ0M3UE5nY2cxK3Vm?=
 =?utf-8?B?L2FSY3lSTk45WkthcEYvYmJFTHhZREUrWC9xVE13RWgxMTh1S0FxSFNPOWxU?=
 =?utf-8?B?aHAwRmZkYmZ3MXFNZzhYdDlzZTJZMXBBOTdzVCtnMkpKNE1EaFFFbzZCbFZ0?=
 =?utf-8?B?bGRVYys2Z2VCaDFnMXJwek9Mb1MwTkY4UGRyOW9yem15MjBKdHhCalBhRjNq?=
 =?utf-8?B?UmVzZHRGeWNYYmY1Vmh4cFYrd0pRT1Y4NzhURmY1a0R4azhRaVpDemxPcUNo?=
 =?utf-8?B?ZGVJSlhRbks1VjlHMk9GTU5uUzZ6TVBHRmNBUTBva0JNakVIQjdJU1Q2ZUxW?=
 =?utf-8?B?THhiYWR5YzRpRHFRUkZ1UWR0M2Qvd2tvdWt2UnAyZXlhNjNPQjVyL2NpU1RH?=
 =?utf-8?B?Q3JseEwwTVdINVlpRFFLbW41ODh0NnI3em1zUjRiQTB0Y2ZNL0xKUzlhTjJZ?=
 =?utf-8?B?MEJlVEJIdU9peFlrOFBUMWMyQzIvYWFRWXcxWXY3Y1VwZWIraWdMY0loWGZY?=
 =?utf-8?B?TVBlVXVZUTEyN2xYbU9WTlY5MDdWbnJGb3lYdjlzME5Qa0ZJNUxvaTlhUjhT?=
 =?utf-8?B?eTRNSjJSRjdqUnJRc2pMM3V1Z0JvbFJrb1dRbHFTSDZRQWFLUzZrZ2FFdWNF?=
 =?utf-8?B?UWdjbHQwaTNVeUs0bkNIQnFqa0ZJT0ZlYkFBRXVic3didHVFSFBGNjYyL3FS?=
 =?utf-8?B?ZC9hRmErYVpTcEN5b014K3pUa1A1T3NUZVlWRzZ4ckd4S2ZkWEsrRVJjUGFo?=
 =?utf-8?B?TEYzSVFaQ0N6ZHlHTXkxMlF3d2lNTHRSY2VCbi9rREhaQnFLNDBFYk91bEx5?=
 =?utf-8?B?bmlLSWZZM0JWNy82UFUvVWN6U1JGVmlnOTdaN2FuRkljZ0RPUHhlMVlBcExs?=
 =?utf-8?B?UHRoODVIczdwY2JPLzh6UTFlMWhNOGVNRndIWkkwZXNQUzZhQUdkWTRsaWdE?=
 =?utf-8?B?U0RIdERaLzhtUngxQWtUZ0RpWTEwSkVtdTFCcHlCR2FzcFc2ZFRzQWpweU5S?=
 =?utf-8?B?M1VHUXRObHVpaXJodkJNWFgzNC91cWpvdGpNaWpxSnZ4cVdaK0VOV1dlZk1x?=
 =?utf-8?B?VWFucW00aU12NGlBTVlPNlN1bGpZTkUzeE5ENkFzWlR0TnNDVE4za3BOYTVK?=
 =?utf-8?B?a0tFcUx1M1lPaVpCTysya1E0Z1cvNTBlUEZuN3oyQlgycFJSME5EMVU2ODJY?=
 =?utf-8?B?NlRZdThpZ05BVFV1bGppQUF4cUIyV2ZuZUl4UWNMTW5pdFFYQ2hjRm5jT1U5?=
 =?utf-8?B?RHM4b0IzQWFqbm4vRWkyemY1ZWorMEFUdHZVdlJXMHJUNGZoOWQ2bktOWFkz?=
 =?utf-8?B?SjNwanc3dndtd25yZmdSL1BwbnlZVmVFZEJ6NzM1ZDJYdEtUdlZ4MVZlL3JR?=
 =?utf-8?B?VjM4WlZrN2RvMEUrMEE5cHhJaHozMU9NUlF0bUFzRmRHbkM4cVA0K0JtaFJi?=
 =?utf-8?B?Q0FmK3VSN1NqcEhQQTlkelFBalpNd0pBSjU2R2d3OXVVcFhoZHJqWHdidjRH?=
 =?utf-8?B?bDdPVlkzbGNnTkhESkw2UnVWakZTZ1hNTnFFdWRsZW9KcnVNRm5QbXR3NVBx?=
 =?utf-8?B?V3lWUFJLZm0wWW1uOVpjN2lFTnkrL1lRdUlycWhzOUd3NWNGUEFLU3dReFJr?=
 =?utf-8?Q?Jd98=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39110c0-ea1d-4db1-5400-08db3712614b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 02:47:08.4116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4M5bPET8dR5ONH7dJqQBUIi6vkya+gU4/TNHT/Ikq0J94TZr46SNefnsSskookGoLGWQ7gGSc8cEcTDbz8IWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ying" <YING.LI@amd.com>, "Liang, Richard qi" <Richardqi.Liang@amd.com>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLA0KDQpUaGFuayB5
b3UgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIEFwcmlsIDYsIDIwMjMgMTA6MDUgUE0NCj4gVG86IFlhbmcsIFdlbllvdSA8
V2VuWW91LllhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsgUXVhbiwgRXZhbg0KPiA8
RXZhbi5RdWFuQGFtZC5jb20+DQo+IENjOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29t
PjsgTGlhbmcsIFJpY2hhcmQgcWkNCj4gPFJpY2hhcmRxaS5MaWFuZ0BhbWQuY29tPjsgTGksIFlp
bmcgPFlJTkcuTElAYW1kLmNvbT47IExpdSwgS3VuDQo+IDxLdW4uTGl1MkBhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAyLzJd
IGRybS9hbWQvcG0vdmFuZ29naDogU2VuZCBTTVQgZW5hYmxlIG1lc3NhZ2UNCj4gdG8gUE1GVw0K
PiANCj4gT24gNC82LzIwMjMgMDc6NDUsIFdlbnlvdSBZYW5nIHdyb3RlOg0KPiA+IFdoZW4gdGhl
IFNNVCBzdGF0ZSBpcyBjaGFuZ2VkIG9uIHRoZSBmbHksIHNlbnQgdGhlIFNNVCBlbmFibGUgbWVz
c2FnZQ0KPiA+IHRvIHRoZSBQTUZXIHRvIG5vdGlmeSBpdCB0aGF0IHRoZSBTTVQgc3RhdGUgY2hh
bmdlZC4NCj4gPg0KPiA+IEFkZCB0aGUgc3VwcG9ydCB0byBzZW5kIFBQU01DX01TR19TZXRDQ2xr
U01URW5hYmxlKDB4NTgpIG1lc3NhZ2UgdG8NCj4gPiB0aGUgUE1GVyBmb3IgVmFuZ29naC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbnlvdSBZYW5nIDxXZW5Zb3UuWWFuZ0BhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICAgLi4uL3BtL3N3c211L2luYy9wbWZ3X2lmL3NtdV92MTFfNV9wcHNtYy5o
ICAgIHwgIDMgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3NtdV90
eXBlcy5oICB8ICAzICstDQo+ID4gICAuLi4vZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvdmFu
Z29naF9wcHQuYyAgfCAzMg0KPiArKysrKysrKysrKysrKysrKystDQo+ID4gICAzIGZpbGVzIGNo
YW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9wbWZ3X2lmL3NtdV92
MTFfNV9wcHNtYy5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9wbWZ3
X2lmL3NtdV92MTFfNV9wcHNtYy5oDQo+ID4gaW5kZXggNzQ3MWUyZGYyODI4Li5hNmJmYTE5MTJj
NDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1m
d19pZi9zbXVfdjExXzVfcHBzbWMuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvaW5jL3BtZndfaWYvc211X3YxMV81X3Bwc21jLmgNCj4gPiBAQCAtMTExLDcgKzExMSw4
IEBADQo+ID4gICAjZGVmaW5lIFBQU01DX01TR19HZXRHZnhPZmZTdGF0dXMJCSAgICAgICAweDUw
DQo+ID4gICAjZGVmaW5lIFBQU01DX01TR19HZXRHZnhPZmZFbnRyeUNvdW50CQkgICAgICAgMHg1
MQ0KPiA+ICAgI2RlZmluZSBQUFNNQ19NU0dfTG9nR2Z4T2ZmUmVzaWRlbmN5CQkgICAgICAgMHg1
Mg0KPiA+IC0jZGVmaW5lIFBQU01DX01lc3NhZ2VfQ291bnQgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMHg1Mw0KPiA+ICsjZGVmaW5lIFBQU01DX01TR19TZXRDQ2xrU01URW5hYmxlCQkgICAg
ICAgMHg1OA0KPiA+ICsjZGVmaW5lIFBQU01DX01lc3NhZ2VfQ291bnQgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMHg1OQ0KPiA+DQo+ID4gICAvL0FyZ3VtZW50IGZvciBQUFNNQ19NU0dfR2Z4
RGV2aWNlRHJpdmVyUmVzZXQNCj4gPiAgIGVudW0gew0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9zbXVfdHlwZXMuaA0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9pbmMvc211X3R5cGVzLmgNCj4gPiBpbmRleCAyOTdiNzBiOTM4OGYu
LjgyMDgxMmQ5MTBiZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L2luYy9zbXVfdHlwZXMuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvaW5jL3NtdV90eXBlcy5oDQo+ID4gQEAgLTI0NSw3ICsyNDUsOCBAQA0KPiA+ICAgCV9fU01V
X0RVTU1ZX01BUChBbGxvd0dwbyksCVwNCj4gPiAgIAlfX1NNVV9EVU1NWV9NQVAoTW9kZTJSZXNl
dCksCVwNCj4gPiAgIAlfX1NNVV9EVU1NWV9NQVAoUmVxdWVzdEkyY1RyYW5zYWN0aW9uKSwgXA0K
PiA+IC0JX19TTVVfRFVNTVlfTUFQKEdldE1ldHJpY3NUYWJsZSksDQo+ID4gKwlfX1NNVV9EVU1N
WV9NQVAoR2V0TWV0cmljc1RhYmxlKSwgXA0KPiA+ICsJX19TTVVfRFVNTVlfTUFQKFNldENDbGtT
TVRFbmFibGUpLA0KPiA+DQo+ID4gICAjdW5kZWYgX19TTVVfRFVNTVlfTUFQDQo+ID4gICAjZGVm
aW5lIF9fU01VX0RVTU1ZX01BUCh0eXBlKQlTTVVfTVNHXyMjdHlwZQ0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmMNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvdmFuZ29naF9wcHQuYw0KPiA+IGlu
ZGV4IDc0MzNkY2FhMTZlMC4uY2ExZmY5N2YzMzUzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvdmFuZ29naF9wcHQuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvdmFuZ29naF9wcHQuYw0KPiA+IEBAIC0xNDEs
NiArMTQxLDcgQEAgc3RhdGljIHN0cnVjdCBjbW4yYXNpY19tc2dfbWFwcGluZw0KPiB2YW5nb2do
X21lc3NhZ2VfbWFwW1NNVV9NU0dfTUFYX0NPVU5UXSA9IHsNCj4gPiAgIAlNU0dfTUFQKEdldEdm
eE9mZlN0YXR1cywNCj4gUFBTTUNfTVNHX0dldEdmeE9mZlN0YXR1cywJCQkJCQkwKSwNCj4gPiAg
IAlNU0dfTUFQKEdldEdmeE9mZkVudHJ5Q291bnQsDQo+IFBQU01DX01TR19HZXRHZnhPZmZFbnRy
eUNvdW50LAkJCQkJMCksDQo+ID4gICAJTVNHX01BUChMb2dHZnhPZmZSZXNpZGVuY3ksDQo+IFBQ
U01DX01TR19Mb2dHZnhPZmZSZXNpZGVuY3ksCQkJCQkwKSwNCj4gPiArCU1TR19NQVAoU2V0Q0Ns
a1NNVEVuYWJsZSwNCj4gUFBTTUNfTVNHX1NldENDbGtTTVRFbmFibGUsDQo+IAkwKSwNCj4gPiAg
IH07DQo+ID4NCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgY21uMmFzaWNfbWFwcGluZw0KPiA+IHZhbmdv
Z2hfZmVhdHVyZV9tYXNrX21hcFtTTVVfRkVBVFVSRV9DT1VOVF0gPSB7IEBAIC00NjAsNiArNDYx
LDcNCj4gQEANCj4gPiBzdGF0aWMgaW50IHZhbmdvZ2hfYWxsb2NhdGVfZHBtX2NvbnRleHQoc3Ry
dWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgdmFuZ29naF9pbml0
X3NtY190YWJsZXMoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+ID4gICB7DQo+ID4gKwl1aW50
MzJfdCBzbXVfdmVyc2lvbjsNCj4gPiAgIAlpbnQgcmV0ID0gMDsNCj4gPg0KPiA+ICAgCXJldCA9
IHZhbmdvZ2hfdGFibGVzX2luaXQoc211KTsNCj4gPiBAQCAtNDc3LDkgKzQ3OSwyNCBAQCBzdGF0
aWMgaW50IHZhbmdvZ2hfaW5pdF9zbWNfdGFibGVzKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211
KQ0KPiA+ICAgCXNtdS0+Y3B1X2NvcmVfbnVtID0gNDsNCj4gPiAgICNlbmRpZg0KPiA+DQo+ID4g
KwlyZXQgPSBzbXVfY21uX2dldF9zbWNfdmVyc2lvbihzbXUsIE5VTEwsICZzbXVfdmVyc2lvbik7
DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJaWYgKHNt
dV92ZXJzaW9uID49IDB4MDYzRjA2MDApDQo+IA0KPiBBRkFJQ1QgdGhlIHZhbHVlIGhhcyBhbHJl
YWR5IGJlZW4gbG9va2VkIHVwIGFuZCB5b3UgY2FuIGluc3RlYWQgdXNlOg0KPiANCj4gc211LT5h
ZGV2LT5wbS5md192ZXJzaW9uID49IDB4MDYzRjA2MDANCg0Kc211LT5hZGV2LT5wbS5md192ZXJz
aW9uIGlzIGFzc2lnbmVkIGluIHNtdV92MTFfMF9pbml0X21pY3JvY29kZSgpLA0KDQpWYW5nb2do
IGRvZXNuJ3QgaW5pdGlhbGl6ZSAuaW5pdF9taWNyb2NvZGUgaW50ZXJmYWNlLg0KDQpTbywgc211
LT5hZGV2LT5wbS5md192ZXJzaW9uIHZhbHVlIGlzIDAuDQoNCj4gDQo+ID4gKwkJc211X3NtdF90
aW1lcl9pbml0KHNtdSk7DQo+ID4gKw0KPiA+ICAgCXJldHVybiBzbXVfdjExXzBfaW5pdF9zbWNf
dGFibGVzKHNtdSk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCB2YW5nb2doX2Zpbmlf
c21jX3RhYmxlcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkgew0KPiA+ICsJc211X3NtdF90aW1l
cl9maW5pKHNtdSk7DQo+IA0KPiBTaG91bGRuJ3QgdGhpcyB0aW1lciBvbmx5IGJlIGRlbGV0ZWQg
aWYNCj4gDQo+IHNtdS0+YWRldi0+cG0uZndfdmVyc2lvbiA+PSAweDA2M0YwNjAwDQo+IA0KDQpZ
ZXMsIHdpbGwgYWRkIHZlcnNpb24gY2hlY2sgYmVmb3JlIGRlbGV0ZSB0aGUgdGltZXIuDQoNCk5l
ZWQgdG8gY2FsbCB0aGUgc211X2Ntbl9nZXRfc21jX3ZlcnNpb24oKSBhZ2Fpbiwgbm90IGdvb2Qu
IA0KTG9vayBmb3J3YXJkIHRvIHlvdXIgb3BpbmlvbnMuDQoNCj4gPiArCXNtdV92MTFfMF9maW5p
X3NtY190YWJsZXMoc211KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiAgIHN0YXRpYyBpbnQgdmFuZ29naF9kcG1fc2V0X3Zjbl9lbmFibGUoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsIGJvb2wNCj4gZW5hYmxlKQ0KPiA+ICAgew0KPiA+ICAgCWludCByZXQgPSAw
Ow0KPiA+IEBAIC0yNDI4LDEyICsyNDQ1LDI0IEBAIHN0YXRpYyB1MzIgdmFuZ29naF9nZXRfZ2Z4
b2ZmX2VudHJ5Y291bnQoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUsIHVpbnQ2NF90ICplbnRy
DQo+ID4gICAJcmV0dXJuIHJldDsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IHZhbmdv
Z2hfc2V0X2NwdV9zbXRfZW5hYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sDQo+ID4g
K2VuYWJsZSkgew0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBzbXVfY21uX3Nl
bmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gU01VX01TR19TZXRDQ2xrU01URW5hYmxlLA0K
PiA+ICsJCQkJCSAgICAgIGVuYWJsZSA/IDEgOiAwLCBOVUxMKTsNCj4gPiArCWlmIChyZXQpDQo+
ID4gKwkJZGV2X2VycihzbXUtPmFkZXYtPmRldiwgIlNldCBDUFUgU01UIHN0YXRlIGZhaWxlZCFc
biIpOw0KPiANCj4gR2l2ZW4gdGhpcyBpcyBnb2lnbiB0byBiZSB0cmlnZ2VyZWQgYnkgYSB0aW1l
ciwgdGhpcyBtaWdodCBiZSBiZXN0IHRvIGJlIGEgcmF0ZQ0KPiBsaW1pdGVkIG1lc3NhZ2UgdG8g
YXZvaWQgZmxvb2RpbmcgdGhlIGxvZ3MuDQoNClllcywgd2lsbCBhZGQsIGJlZm9yZSBjYWxsIGRl
dl9lcnIoLi4uKQ0KDQoJaWYgKHByaW50a19yYXRlbGltaXQoKSkNCg0KQmVzdCBSZWdhcmRzLA0K
V2VueW91DQo+IA0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4g
ICBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFibGVfZnVuY3MgdmFuZ29naF9wcHRfZnVuY3MgPSB7
DQo+ID4NCj4gPiAgIAkuY2hlY2tfZndfc3RhdHVzID0gc211X3YxMV8wX2NoZWNrX2Z3X3N0YXR1
cywNCj4gPiAgIAkuY2hlY2tfZndfdmVyc2lvbiA9IHNtdV92MTFfMF9jaGVja19md192ZXJzaW9u
LA0KPiA+ICAgCS5pbml0X3NtY190YWJsZXMgPSB2YW5nb2doX2luaXRfc21jX3RhYmxlcywNCj4g
PiAtCS5maW5pX3NtY190YWJsZXMgPSBzbXVfdjExXzBfZmluaV9zbWNfdGFibGVzLA0KPiA+ICsJ
LmZpbmlfc21jX3RhYmxlcyA9IHZhbmdvZ2hfZmluaV9zbWNfdGFibGVzLA0KPiA+ICAgCS5pbml0
X3Bvd2VyID0gc211X3YxMV8wX2luaXRfcG93ZXIsDQo+ID4gICAJLmZpbmlfcG93ZXIgPSBzbXVf
djExXzBfZmluaV9wb3dlciwNCj4gPiAgIAkucmVnaXN0ZXJfaXJxX2hhbmRsZXIgPSBzbXVfdjEx
XzBfcmVnaXN0ZXJfaXJxX2hhbmRsZXIsIEBAIC0yNDc0LDYNCj4gPiArMjUwMyw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyB2YW5nb2doX3BwdF9mdW5jcyA9IHsNCj4gPiAg
IAkuZ2V0X3Bvd2VyX2xpbWl0ID0gdmFuZ29naF9nZXRfcG93ZXJfbGltaXQsDQo+ID4gICAJLnNl
dF9wb3dlcl9saW1pdCA9IHZhbmdvZ2hfc2V0X3Bvd2VyX2xpbWl0LA0KPiA+ICAgCS5nZXRfdmJp
b3NfYm9vdHVwX3ZhbHVlcyA9IHNtdV92MTFfMF9nZXRfdmJpb3NfYm9vdHVwX3ZhbHVlcywNCj4g
PiArCS5zZXRfY3B1X3NtdF9lbmFibGUgPSB2YW5nb2doX3NldF9jcHVfc210X2VuYWJsZSwNCj4g
PiAgIH07DQo+ID4NCj4gPiAgIHZvaWQgdmFuZ29naF9zZXRfcHB0X2Z1bmNzKHN0cnVjdCBzbXVf
Y29udGV4dCAqc211KQ0K
