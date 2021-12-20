Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763D9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 13:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11F010EC2C;
	Mon, 20 Dec 2021 13:11:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0320F10EC7F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 13:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeTO1LvPaYW2RZndb2ldcOZPvjb8IC26UQGU7qf0sdSOA39jEjUx5ky/aDgfySaM6jREB5+WS+sqCtDMJjDS/CFTmoWREPEbhL8K2Kh7L9Ul3h3t+2st5EIZj5WviyMdlLn6BNzD7De4QxAwBQagvaFDxu1Q0SO82DJtLhNNrfkXHjENyJgZ8/gvDX4hhVyI+nekzxYvvJ+9m8iNHGbLELWTvvmWRTVY5pzDjyvNLFcBRuzlySs20vrAHGHV/62F7eCnp+Gj/1MrmKugukcHejYvcpPr4GqfJgVPSX/VXQ4ZAmA4GjPiuGzjkcEEGWPfmw1qdqeFUebfJcndbsMZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAaOwB3qlBM2v2VQyU8JPM+EUjzqn4t9sWkRZrihqKs=;
 b=nQQX2nvBty+xGB48sVWfq6jBL6FTNz9G4cRcBk8UFckt7rN+JCwALCWf2tlXwv5HL+cmbdxi98HszwshNnStIx5PtKOLEZlHMIzAnhsbBdSq0mHvOqUBMkwe3mSVPusLFBOJhFmScQ6mSjDgoscXNOhZYu9uKlL+/Grn2e1mD2Bw3Jp4SRsL2tt55tYXBfeVfxZnn4hiTxwLJiRxK6z+vMfiDW5XrbRwHuRYROhdljwn3trnzial709tO3OLN8plyHwzLImIyGCqLFDp1C4YcdxM4UqBNNmw0KK75k/qLRrZOb9J+nd/ZHaiHQ95fFpw1oOWMsgOKEcD9tzVzh9eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAaOwB3qlBM2v2VQyU8JPM+EUjzqn4t9sWkRZrihqKs=;
 b=fpl59hQLRO+1W3856N3+ICuYSPmByUNN3YNDSoS2m9jM5WmAOz2TkHlGhGUiR5ChXS7sJUHGIm0/PdRli50Cldo1AO4ubup4+thyVdVEba2qvrrRNboN5fcr875fnj+6CFShbAVLrbh/yst2SFwqDCZ2l4LwJiv5fRg1ZGiTTgA=
Received: from DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 13:11:42 +0000
Received: from DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::a589:5d7a:f504:aa69]) by DM6PR12MB2858.namprd12.prod.outlook.com
 ([fe80::a589:5d7a:f504:aa69%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 13:11:41 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
Thread-Topic: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
Thread-Index: AQHX81sy6wxIE47pU0qg7hacSLe94qw4UpCAgAMM7WA=
Date: Mon, 20 Dec 2021 13:11:41 +0000
Message-ID: <DM6PR12MB285832FF561C742528C4A05B857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
References: <20211217153131.321226-1-kent.russell@amd.com>
 <850d619c-046b-de2b-0f5c-722a2ddcd5c3@gmail.com>
In-Reply-To: <850d619c-046b-de2b-0f5c-722a2ddcd5c3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f52f834d-a59f-43cd-b2d1-e1543c9f2af4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-20T13:11:29Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d917aa65-9fe3-4d2c-7b6e-08d9c3ba43d2
x-ms-traffictypediagnostic: DM6PR12MB4268:EE_
x-microsoft-antispam-prvs: <DM6PR12MB42688F481BD33E5BEA94627F857B9@DM6PR12MB4268.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mk6AfXCG8U+VfAPjJpg8H5MU2xLEpcPqG6BPmIdpK1Zx0iCzaiySJpCqGPlWcwqZVqzbuWmrwAIPZ59QJ8vCrUth0sU/OM39UzqW4PH7zrU73+iNgUTnZxZGcbHwSueCn5beEI1T3Riz/aHpWY4jnDJYn3X4wfaP+0RnRw0vexH4j+jNLLvNzl3ZQBYvIJQyW5sE351wqViPyE8ch35tpjOfU1iOy6Jw287BI4p8O22T5u8Mz7a6puJQOXruDeOUCCQlt9Nm4SYFBqqbnr3glWRgve6WwLv/i55gN4bP5nJcygfhLpTh0XU89NgmgAUgINa8Mq6QkU13fDpA4HXBXyuJfa6josCnHMbGheABJPwZWeeLz4Ynb6ZVhG36nIDfHaUGkhRhjHO2Ida48HnuJWch2Qfarh/waOXRzRSKKRzOosoMivUE5wyUWre5hPm2jNGNLppBfoTyw0ytP5TMLtpC6NtYPcttrcK+hYDiZxjfdMPwqyaalPbRZAj+xUOHJmQpFkukcYpH+B6J7HwWao0u9MjyVsgFYjqPwKqxNlxNqFK1qElcetqpKBMivDe8eyRCYH9RUXLKHs+BIe/0zjfqY8VbQ3fVlI0Hd7gh+oMP2DsCWkxhGU5UMUCwPpRUNjXaCwrL+fCSYK2hiwBGHUmUcelK/WhRxq/zMc5wqbj0q8sk+YC0AhXf2yvduYjS7Ua4UOBYSLEf8S4IsVuZbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66446008)(64756008)(71200400001)(66476007)(52536014)(122000001)(66946007)(38100700002)(76116006)(7696005)(38070700005)(5660300002)(9686003)(33656002)(83380400001)(8676002)(8936002)(110136005)(55016003)(86362001)(316002)(2906002)(26005)(66574015)(186003)(6506007)(53546011)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTVkaUpJUjdvaENTUWFvbyt6bzJ0UEMxSGdkNDROd3VKUmQrbTNNUDBOUDB0?=
 =?utf-8?B?WStHZWZ5RVlObGtEeU1ieksrWFBVUmNoZStaL0crVy9GanRMejhQR0NqWk5v?=
 =?utf-8?B?Uyt0Vm1HSDhoZXBaN29aWnRnanhFeXllZGNzUEc0VkZSa2RpUHZOeTZyL3Ax?=
 =?utf-8?B?aVBUd2VJUUUzdm5nTHpESUMxVTRnTTl5cFlGS0w3ZnNPOGM3QjhkK0QvVmlz?=
 =?utf-8?B?Mk5ob2pLYlppWHB4Z1hNdm1jMGJ6czR4V0R3TGl2VGpSdmFSaHFBRGNqVFVq?=
 =?utf-8?B?d0tnOUg0ZEZJRmVnRHB5cmpyZWdtZis2VWxnQmg2TEdqQ2E2OHRSd1RyYXIz?=
 =?utf-8?B?SUhKRkFCeTNEQnRXWjd3VFdBeFdRVWVCM3g3MU5UL00zYWJOVU9tOU9OZXgv?=
 =?utf-8?B?amMxajEra3VmOVpxaGNkYkpmbFgzcVVlaFA4VFJpc2Q4WGVRbkdlbEQzM0lq?=
 =?utf-8?B?ZHdZblZjVkllZXFyOVF1Ym0rKzBERWNuZXMya3F5SVJjNW8xYkpZdnR6eDVJ?=
 =?utf-8?B?Yk90Qy8zdSsxZzNRbzVvazF2K0V0bC9sZjRaSWNRSWtBbkxqNDFWRjhWVHpy?=
 =?utf-8?B?eGFBbktiNk9lVlVrdDBaeUNCa2NHdkhOYll2Z0g0WjhGTDdNM21kTU9ndDVp?=
 =?utf-8?B?YkQ2MkJNcDc1dFZ2d1FjRFBxeU5rSG9LWnlDVERlTEFaYS9OTmZCcHJRMlIx?=
 =?utf-8?B?VDlFMmltS0lHS0lobzlrdUVKNW55Y0svV28wanAzRGpyeC8rVHF5ZncvSEYx?=
 =?utf-8?B?TmRXdHpWQ0JHZDgzMWpISFFYdlM4WGFBNlF0RXQ2bVhtUjJyMlZxVDJVR3ZG?=
 =?utf-8?B?QWk5eVg4YkRzNUdmTDB5Q0lnZy9RUUNrS2ovTGxacDI3cTUwQUJMSzR4Zmlk?=
 =?utf-8?B?VDV5NzcwandnSVFrVFkxMUU1ejRxNk5GUmN2NGVmY2hUVUdIRURUdDc3YXkv?=
 =?utf-8?B?MkxBZ285QVRvWkUyR2NENFdiTHFoS1RwZ0NaK2FjSHJOdm5xbjNETE12QWpi?=
 =?utf-8?B?SExmT0tEV21Sem5rZ1lBdWlJWXFpVGxpRk1qUk82djNzV1RyNzRFYUNLVWJJ?=
 =?utf-8?B?UDdocnk4aHlZTjc0SCtvZDk3Q2hHT1ZzMXlRQVBIcVRleW5aM0dSNHFyWVNO?=
 =?utf-8?B?ZGFDTDFGamhFMFEzdTIzK0FHdnBpL2RyZllVeDlaU2hWazRrNTR0RmdNdlFW?=
 =?utf-8?B?Q1lRMkk1VWdFK0d3TmtKb2ZPbVBuSDJZK0lNZ0kzbDIxSnhDazlrbTRxREs2?=
 =?utf-8?B?Y200OFdLWmxzYVNPZTRwNEhVRi9TQm9oeitWZlpKbUZvL2Y4SmJINXlxRE14?=
 =?utf-8?B?ZkgraXNMY0Z0cWtxTHlaa2dEQVIyWk9JN3pEL2tBSlBFbllPNkRVWGR4TWpN?=
 =?utf-8?B?S1N6eGNCdEVqQjIyeVh1SE93NjNERTUzZzZ6Y0FWejdVMTdyUHpGRlFPdkls?=
 =?utf-8?B?WWFLeW1UcTk2d2lHSmhKanRmTXpxampxL1E4K3lxbjBVOXBLYjNnRkUxNFhm?=
 =?utf-8?B?Y2NiKzlrODBxZjdZSWFEOVg1UTExTi9URTIrcnZZM0Z2K2ZFdXgvVzVOVHpw?=
 =?utf-8?B?SlI1RVovS0x1QTNUZkhEWHp4cFBBUEdFOC8wSndpK1NVdXcrM1ZVdFlHQm1R?=
 =?utf-8?B?cGdoTzlCc1UxNWdzYVk5L2gzQnA5UkJYZmxxdDY2OTNCNlFYdDM0UHFrVTJn?=
 =?utf-8?B?SWt5RlNmRjR6MnVTalJSUkMwWVBqcXNBQlhwK1dYMmhkb1RLMy9JaVEzdWRk?=
 =?utf-8?B?UUlUL2ZCYVd0S09ZOTdoOWIzelJ6R2I4NUIydlhJSUw4VkdOTW9jVHlRbUd1?=
 =?utf-8?B?ZnN1YXAxRE9BY0xKWEJUd29TdnhadHpzSGpoUEtudjFjdG5ReGRWMWpYbVFF?=
 =?utf-8?B?RkxVaVRiaHJDRFVjd3BMcExaU2VqeVhmVmU4aDZIUWtWUmJzSzl6WGgvdVF1?=
 =?utf-8?B?TldqeDJ0c1dicncvYTJnMERKMGpjeXBtanF0N2oycjVOVStocVVYSHZvek5s?=
 =?utf-8?B?UktoWmVxeno1citGMFlLZlJYNnNoeTVqZ0dxRWVRNi9Fck9sQzRFVWpaOUR6?=
 =?utf-8?B?bjhndFRneUxRSTBjNGlWWU5xVUJUY0NRbG9vZmE0YWM0eDh3NC8zNEk5OHNX?=
 =?utf-8?B?bEs1bDRNc1pORlpFUTd5a0dRT3ZDZU5Hd1dydFB0ZE5aYTBsRzJoa0lCTGg2?=
 =?utf-8?Q?F9n/L5LPod76Dq5OtTUM6Zc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d917aa65-9fe3-4d2c-7b6e-08d9c3ba43d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 13:11:41.7743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8f9+VLqWS5RYj/WZix8tLDMd7IZJ/U5xFtfaM6UkNs4ZjvcA+NuY8rRiL0q2Cw+EA8tqoAchN1q3HUUSWeHmMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KV2lsbCBkby4gVGhhbmtzIQ0KDQogS2VudA0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNr
b2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1i
ZXIgMTgsIDIwMjEgOTozNiBBTQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDEvNF0gZHJtL2FtZGdwdTogSW5jcmVhc2UgcG90ZW50aWFsIHByb2R1Y3RfbmFtZSB0byA2
NCBjaGFyYWN0ZXJzDQo+DQo+DQo+DQo+IEFtIDE3LjEyLjIxIHVtIDE2OjMxIHNjaHJpZWIgS2Vu
dCBSdXNzZWxsOg0KPiA+IEhhdmluZyBzZWVuIGF0IGxlYXN0IDEgNDItY2hhcmFjdGVyIHByb2R1
Y3RfbmFtZSwgYnVtcCB0aGUgbnVtYmVyIHVwIHRvDQo+ID4gNjQsIGFuZCBwdXQgdGhhdCBkZWZp
bml0aW9uIGludG8gYW1kZ3B1LmggdG8gbWFrZSBmdXR1cmUgYWRqdXN0bWVudHMNCj4gPiBzaW1w
bGVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxA
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oICAgICAgICAgICAgfCAgMyArKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mcnVfZWVwcm9tLmMgfCAxMiArKysrKy0tLS0tLS0NCj4gPiAgIDIgZmlsZXMgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiBpbmRleCBlNzAxZGVkY2UzNDQuLjRlNjczN2U0
YzM2YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUu
aA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gQEAg
LTgxMyw2ICs4MTMsNyBAQCBzdHJ1Y3QgYW1kX3Bvd2VycGxheSB7DQo+ID4NCj4gPiAgICNkZWZp
bmUgQU1ER1BVX1JFU0VUX01BR0lDX05VTSA2NA0KPiA+ICAgI2RlZmluZSBBTURHUFVfTUFYX0RG
X1BFUkZNT05TIDQNCj4gPiArI2RlZmluZSBQUk9EVUNUX05BTUVfTEVOIDY0DQo+DQo+IFBsZWFz
ZSBwcmVmaXggYWxsIGRlZmluZXMgd2l0aCBBTURHUFVfLCBhcGFydCBmcm9tIHRoYXQgbG9va3Mg
Z29vZCB0byBtZS4NCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+ICAgc3RydWN0
IGFtZGdwdV9kZXZpY2Ugew0KPiA+ICAgICBzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAgICAgICAg
ICpkZXY7DQo+ID4gICAgIHN0cnVjdCBwY2lfZGV2ICAgICAgICAgICAgICAgICAgKnBkZXY7DQo+
ID4gQEAgLTEwODMsNyArMTA4NCw3IEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsNCj4gPg0KPiA+
ICAgICAvKiBDaGlwIHByb2R1Y3QgaW5mb3JtYXRpb24gKi8NCj4gPiAgICAgY2hhciAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwcm9kdWN0X251bWJlclsxNl07DQo+ID4gLSAgIGNoYXIgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcHJvZHVjdF9uYW1lWzMyXTsNCj4gPiArICAgY2hhciAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwcm9kdWN0X25hbWVbUFJPRFVDVF9OQU1FX0xFTl07
DQo+ID4gICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VyaWFsWzIwXTsNCj4g
Pg0KPiA+ICAgICBhdG9taWNfdCAgICAgICAgICAgICAgICAgICAgICAgIHRocm90dGxpbmdfbG9n
Z2luZ19lbmFibGVkOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZnJ1X2VlcHJvbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZydV9lZXByb20uYw0KPiA+IGluZGV4IDc3MDljYWViMjMzZC4uNWVkMjQ3MDFmOWNmIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVw
cm9tLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2Vl
cHJvbS5jDQo+ID4gQEAgLTg4LDcgKzg4LDcgQEAgc3RhdGljIGludCBhbWRncHVfZnJ1X3JlYWRf
ZWVwcm9tKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiB1aW50MzJfdCBhZGRycHRyLA0K
PiA+DQo+ID4gICBpbnQgYW1kZ3B1X2ZydV9nZXRfcHJvZHVjdF9pbmZvKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KPiA+ICAgew0KPiA+IC0gICB1bnNpZ25lZCBjaGFyIGJ1ZmZbMzRdOw0K
PiA+ICsgICB1bnNpZ25lZCBjaGFyIGJ1ZmZbUFJPRFVDVF9OQU1FX0xFTisyXTsNCj4gPiAgICAg
dTMyIGFkZHJwdHI7DQo+ID4gICAgIGludCBzaXplLCBsZW47DQo+ID4NCj4gPiBAQCAtMTMxLDEy
ICsxMzEsMTAgQEAgaW50IGFtZGdwdV9mcnVfZ2V0X3Byb2R1Y3RfaW5mbyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZQ0KPiAqYWRldikNCj4gPiAgICAgfQ0KPiA+DQo+ID4gICAgIGxlbiA9IHNpemU7DQo+
ID4gLSAgIC8qIFByb2R1Y3QgbmFtZSBzaG91bGQgb25seSBiZSAzMiBjaGFyYWN0ZXJzLiBBbnkg
bW9yZSwNCj4gPiAtICAgICogYW5kIHNvbWV0aGluZyBjb3VsZCBiZSB3cm9uZy4gQ2FwIGl0IGF0
IDMyIHRvIGJlIHNhZmUNCj4gPiAtICAgICovDQo+ID4gLSAgIGlmIChsZW4gPj0gc2l6ZW9mKGFk
ZXYtPnByb2R1Y3RfbmFtZSkpIHsNCj4gPiAtICAgICAgICAgICBEUk1fV0FSTigiRlJVIFByb2R1
Y3QgTnVtYmVyIGlzIGxhcmdlciB0aGFuIDMyIGNoYXJhY3RlcnMuIFRoaXMgaXMgbGlrZWx5DQo+
IGEgbWlzdGFrZSIpOw0KPiA+IC0gICAgICAgICAgIGxlbiA9IHNpemVvZihhZGV2LT5wcm9kdWN0
X25hbWUpIC0gMTsNCj4gPiArICAgaWYgKGxlbiA+PSBQUk9EVUNUX05BTUVfTEVOKSB7DQo+ID4g
KyAgICAgICAgICAgRFJNX1dBUk4oIkZSVSBQcm9kdWN0IE5hbWUgaXMgbGFyZ2VyIHRoYW4gJWQg
Y2hhcmFjdGVycy4gVGhpcyBpcyBsaWtlbHkgYQ0KPiBtaXN0YWtlIiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgUFJPRFVDVF9OQU1FX0xFTik7DQo+ID4gKyAgICAgICAgICAgbGVu
ID0gUFJPRFVDVF9OQU1FX0xFTiAtIDE7DQo+ID4gICAgIH0NCj4gPiAgICAgLyogU3RhcnQgYXQg
MiBkdWUgdG8gYnVmZiB1c2luZyBmaWVsZHMgMCBhbmQgMSBmb3IgdGhlIGFkZHJlc3MgKi8NCj4g
PiAgICAgbWVtY3B5KGFkZXYtPnByb2R1Y3RfbmFtZSwgJmJ1ZmZbMl0sIGxlbik7DQoNCg==
