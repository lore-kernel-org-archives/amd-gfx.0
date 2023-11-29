Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72366C07CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 06:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0760510E335;
	Wed, 29 Nov 2023 06:51:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7FC10E0C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 06:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXC6WtqTvF4iD2UVCq1yEfjDnBNVFF0FlZ/iWXSs/STqqRtmLfxp69WkcaePsQI6R9J+2WTcz19f1rp8/IQBpyFwI5rm0f1SIgJmkPSqSOb5Xg5vBSBXVLVzieejwlOQAzwckQs/xDQdoFSEdYaT3pTG0dxpSjszwPWj/lCSHJg7dVtBeU6d1MsmquIW0/YkaNIJuFeIYFZKGL3fu1l6gziPdBa+AQrba/fiFD7ZWpxy900lSar2hCtCg3Y9zkrG5/onSo96a7odARicLx54NQ/EZtlQE4JoSQfxK+qFQRQZVFaAjPQn9PBnGXucjXYXazxq1oZ4UgctgHJS9cuInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re0AN0LKHgUQveobU2RW7zwGV1TShjXtTjW0wId21vc=;
 b=n+8WfXY7EW3axpNbPvRX5D5yWL7OjzJOgBfIeyPIUzDuM6yxegUPspIhRTfSNct2W2g3zr2IQMXSB54woGYrxIvX35WhgmP3A0IO0tUWc876KliDytlU9+OV/ZLeMG0Jby5wEYDzs2Ngd5d8G3CgBijZruc+0yd2nGtv3xi4T0fRSo+LL4oSJBTC3/2XGqjibE103dLSpLMC0zREZka75uxM4tW/eMyvSUbp8pUMHeV91p5GH8vU9MFBs11LIHZB/Hhtz73aTpp5Glghyta97Vlu1wupmJV9/sZeFhxyn/vSUOU2E8Z8+b7HE9I9nevMaEwmSrZymV07F9bJuUR2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re0AN0LKHgUQveobU2RW7zwGV1TShjXtTjW0wId21vc=;
 b=efb0cbup/hJPxJ0htTs8WJqLmpBNc90GBVJqFzXBXQozB13112VrgpzZS+YC4xLtDNmIvSLVIcbYfbyHpjNbNzkNYMcrciqmfH7FWXA7W5+yJ0hvdFW3oeuFRRqInuGeiLWMqS72mj3jJr6SiiEq1xLTvECYaAGVWjuL/txtCRQ=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 06:51:50 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::5f7a:93d6:c60:431e]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::5f7a:93d6:c60:431e%4]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 06:51:50 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zha,
 YiFan(Even)" <Yifan.Zha@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip access gfx11 golden registers under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Skip access gfx11 golden registers under
 SRIOV
Thread-Index: AQHaHespoRiQ57S0eEiFQ+PA8zrdrLCNeuqAgANouQA=
Date: Wed, 29 Nov 2023 06:51:50 +0000
Message-ID: <DM4PR12MB5072B3371E70697243FE691BE183A@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20231123085714.254103-1-zhenguo.yin@amd.com>
 <3a94bd18-bd1c-9608-9b14-413a13e854ae@amd.com>
In-Reply-To: <3a94bd18-bd1c-9608-9b14-413a13e854ae@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8b9b16b7-3fad-4209-be49-6a86555b4d7c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-29T06:46:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|CY5PR12MB6455:EE_
x-ms-office365-filtering-correlation-id: 2064632e-3542-4e68-5c81-08dbf0a7aa1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42VIvHHJuFn4QU0AKkCKckf1lgba8FcEJl7uI2hOI1ivfkYwDthAv2EgNpUXcTjXmCyFShHD5dfBlLDTr6O58pohNWt9+CbsSR5d2Ax+9tphTR7VrJuFa8Iz/UgDRiOZv6x2/9kixt7ppFXbl2uEoWVL47y1XdzmCe9t2eGWLEPNzS6JFJG4Pnxl1fas4M9OkDaPOTyyN5M0j1BEnwBeAMIU2lIwniWnGjU+EhK/sJdieiY5dIsJOSSTAn7dR1iaUEXmiko/wOdH56+9wjNVqLscxqsPMMsRWlyj1114qWNImUKYDnUF8mBNH9+Q2KsLn59qSRwT0YfWHNtdIsVzhowJla9lHhwpVw5k17F5nhZ89Tm08Su75vFzLWJTQaKya/Yve79szjOtaUPXcEQMDAi9JRu8eUz9n2sHCEEvHIDOWzPsVR5oyd5OzWA0eE/C7Gjbqi87ORQ1jwzBzYUNMX6H4h1hrP6oEarZnFyFu+gzXSY0n5dzE2deASthTe1IXayXHghhK1BL8w0mM1qX6hs2xiuSGthUpGVCYhddKB0Rol9fC5ShG3pXzY/fCRkc88yp2Sx5uAjr3svtLyLmIOArqRmshhItk7iT6Gk8FNrl7JwRqqGe50ck43xMmCqt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(52536014)(2906002)(5660300002)(8936002)(8676002)(41300700001)(55016003)(316002)(110136005)(64756008)(6636002)(66446008)(66556008)(66476007)(66946007)(76116006)(478600001)(9686003)(6506007)(7696005)(86362001)(71200400001)(53546011)(26005)(83380400001)(33656002)(122000001)(38070700009)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ty9mcER4dDcxYWJDVXRFQVp2UjlJSTBjTWpXa1cwV1VGTmd2dW9RZkpEcUo2?=
 =?utf-8?B?cGpDUHRRTE1FUWdMKzl6NFljYmYyUjNYaEFSSzBEbWorcGEwSlJpcnNMYUx2?=
 =?utf-8?B?d1FoM21UL1liZE42MGpneHZzM09PcE14QnN0c0RTNk5QeXU3NVc3K3Vid2Ex?=
 =?utf-8?B?ZmVqaG1iNEJvajErOEwwcm03c2lQYldBRkpRbWh3RUV0d1p1dVlDTGFqOS8x?=
 =?utf-8?B?a0ZVejI3YkdzcUlrZDEvNzN1RmNsNnNaeEVFY1Z5LzRQYU5weDE5Zi9xSlRL?=
 =?utf-8?B?Ny9WanoyQVNmOEhQK0ZENC9oRW5LTW5yL2h3VTk2N2xIL3p2SWFqYXc2UW1q?=
 =?utf-8?B?R2pIaGxkWENKc3FLVnBDZWdLZTdJMHcxVnJ5ZWhqa3A3aWNSaU16T1hpa3ov?=
 =?utf-8?B?WTAyYm1BaGNvanVEblBLMWZyS2VraEgxdExya0JtSlp4THl1RFdzWmIzc0pN?=
 =?utf-8?B?RGR0OEVzVEEwQy9sZXplY2prSm5pRnhCdE5FcWMxR3dyeno2eVEzYW8zY0tt?=
 =?utf-8?B?dkZjdHB6WTNUeWxldTRKSEREcStsamhaaWE4Yjk3SDhvR0FOVWxVUURhOVdo?=
 =?utf-8?B?WEc2NGpuQ2JKemdMbVdMRFp5YW5BTXQ3bGY0bFk0bUhmN3hRMTl2bXRoZURZ?=
 =?utf-8?B?WnMyT3NrZDJrcjhNOEJLMHNDL0c1enR6eFMyaysweVZ1djlRNzhTT2tyMGhS?=
 =?utf-8?B?K2hLdDA0clIvYWFCTmRMWjJVNnplTlRTWHJkSm5zNGp3YUtlNzc3dlhzZUxQ?=
 =?utf-8?B?cHNPdmU0OEd0eGU1d2Z2Y1YzK1A2SmNaUTNYTzA5NE9XUVc5OHkycDNIeDJR?=
 =?utf-8?B?aWI1MzJuUW5GMTk1aDJTVVpkS0sxeE5WZ0JVZDZmcGxIZk5jOVYxWXJXbjM5?=
 =?utf-8?B?SDZjTnRMRUtJbEJQam91VWJvVzhIY0pqeHBWNGNvYmR6eFl2c0NBeE5Dazlz?=
 =?utf-8?B?ckF1R0VvT1BKbzRzNWU2R2s3TDdGSVZwMXdrNE8vcTQ0bDRGYUNsZXFmS1pq?=
 =?utf-8?B?OTdEM0I3R05hejBLREhHYmhaYUswM050Q3VQY3dNbjRQUzNKVTlLand0dkk2?=
 =?utf-8?B?Q21PUXk1c1h1dkNISlZwS1MrcXhlaWRPT2ord0I4Q2ZCVDZla0JMYXNZQUsw?=
 =?utf-8?B?eW9uelkzR2RjejlXUXRWUk9KdlNmcU01Y282MUpJUnZyVEpVV2VZckM4N21r?=
 =?utf-8?B?Y045SW1Yc1hpa1FERUVpcFg2VkdNYk9iZS94QSszSTh3N1IwSVdpSlhZUXYw?=
 =?utf-8?B?aDYrMVpKVTU3TzI2Z01RYWxxb210b045d0ZuWEl6cFhEanNZN0V5MXVGM3Rh?=
 =?utf-8?B?b0NpbkVzT0YyRUNEVGFyZTY1S2VRZEVGeTBQd05USzgwY0tiR2p2MTBaWEVE?=
 =?utf-8?B?aUFGeUppTTE0SWxZK3g0NDkwSSt2bVJjS1FRWUlLU0VuWjAyd01zUlRTOTRS?=
 =?utf-8?B?SHBXMnoxVk81WU1SdWs3cFlnbmpMNWZjaTVxT2FlYUpOZGFDMTBJNHdINTY3?=
 =?utf-8?B?aXNXWEsrNlpZcDRwUk8yeTYzaWlHQW5GVTdpS3NrSzRkbkFocG1EYVoxQU9Z?=
 =?utf-8?B?Q1NqUUZaZHFFZ2lONFptTVFzNCtWejNwdFFjV09DSEFZTmY5WXNKZi9kZ3Rt?=
 =?utf-8?B?TFBKbmpnSk9sUnJ0ODFLVEJvUzJpTHkxWWFjcUQ5WjNrZldtSklDbU9UcmVZ?=
 =?utf-8?B?T3l1TkRVVUsvMmc2TjBFRWx5azljSjk4c3FWVjdsUjlrQjVqWGg5Z2RPb01v?=
 =?utf-8?B?b1dQOVVSRTM3WncwQkJYVEEvUkthUlU5WGNUNlNOaWRvT0V4NWdRc2EwYjY2?=
 =?utf-8?B?OEl2YXB5ejR4V1JET1BtbDFoR0FUUUhWWGhITlRkWEZvTU9LaUIzTzN1RzZl?=
 =?utf-8?B?MTlCd0l2cXgzMy9DR3pQOG1qMTg5SWhIaExKemZtU1g3cm1sdEwrZXV1cDB5?=
 =?utf-8?B?ZmU3blpPM1FqQ01XU3pTTnMzUlROZlIyd1NCaHdsWXA1bENPRE94WlZNWU1V?=
 =?utf-8?B?SS83UnRmWU5SNkI5b282bzgvaHFKZ084VHlkcVhBSm41SlpTSndSNXpZa3Ez?=
 =?utf-8?B?ZFpvVUJVY2xSVFNKM210bUthWkVCMW9GMkMvSmwySHNlK09iRVJSVUNxZlhZ?=
 =?utf-8?Q?ZEy8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2064632e-3542-4e68-5c81-08dbf0a7aa1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 06:51:50.6842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfVXEvAw2RVWSsdLp1trmKTdkL2g6ADWLSc5nJ8FEiu/4Q9BdU/o0QMjz7mWMg18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLUJ5OiBIb3JhY2Ug
Q2hlbiA8aG9yYWNlLmNoZW5AYW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFlpbiwgWmhlbkd1byAoQ2hyaXMpIDxaaGVuR3VvLllpbkBhbWQuY29tPg0KU2VudDog
TW9uZGF5LCBOb3ZlbWJlciAyNywgMjAyMyAxMDo0MyBBTQ0KVG86IFlpbiwgWmhlbkd1byAoQ2hy
aXMpIDxaaGVuR3VvLllpbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IFpoYSwgWWlGYW4oRXZlbikgPFlpZmFuLlpoYUBhbWQuY29tPjsgQ2hlbiwgSG9yYWNlIDxIb3Jh
Y2UuQ2hlbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogU2tpcCBh
Y2Nlc3MgZ2Z4MTEgZ29sZGVuIHJlZ2lzdGVycyB1bmRlciBTUklPVg0KDQpBZGQgcG90ZW50aWFs
IHJldmlld2Vycy4NCg0KT24gMTEvMjMvMjAyMyA0OjU3IFBNLCBaaGVuR3VvIFlpbiB3cm90ZToN
Cj4gW1doeV0NCj4gR29sZGVuIHJlZ2lzdGVycyBhcmUgUEYtb25seSByZWdpc3RlcnMgb24gZ2Z4
MTEuDQo+IFJMQ0cgaW50ZXJmYWNlIHdpbGwgcmV0dXJuICJvdXQtb2YtcmFuZ2UiIHVuZGVyIFNS
SU9WIFZGLg0KPg0KPiBbSG93XQ0KPiBTa2lwIGFjY2VzcyBnZngxMSBnb2xkZW4gcmVnaXN0ZXJz
IHVuZGVyIFNSSU9WLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuR3VvIFlpbiA8emhlbmd1by55
aW5AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
MV8wLmMgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4NCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gaW5kZXggOGVkNGE2ZmIxNDdh
Li4yODhlOTI2ZTVjZDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFf
MC5jDQo+IEBAIC0yOTMsNiArMjkzLDkgQEAgc3RhdGljIHZvaWQgZ2Z4X3YxMV8wX3NldF9raXFf
cG00X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPg0KPiAgIHN0YXRpYyB2b2lk
IGdmeF92MTFfMF9pbml0X2dvbGRlbl9yZWdpc3RlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQo+ICAgew0KPiArICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KPiArICAgICAg
ICAgICAgIHJldHVybjsNCj4gKw0KPiAgICAgICBzd2l0Y2ggKGFtZGdwdV9pcF92ZXJzaW9uKGFk
ZXYsIEdDX0hXSVAsIDApKSB7DQo+ICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgMSk6DQo+
ICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgNCk6DQo=
