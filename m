Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A293CEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 16:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312ED10E626;
	Thu,  3 Aug 2023 16:11:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2A510E626
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 16:11:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqykim6VNov/iIRECT2nocbydxRjZbnTjFYwtNRqzO28GGAMCKcW1FfFDrlfTueJ5P0LOCOMR2xAyCfBPjCWGR6444sfpWYJfw7A5THRQrLJnRcv2M/TKGZhTDQjdlj60/DM67bGE/HOkA/wsNetseFFFiB+XuAFRlO3z1wSHvcMTUjyC2olfZDt24B8GtuJno/aGDCGmo62A2tYNn4lF1kJq5P7lDj1iocZFqpoxhgw938GPT40UGvmJiW9fE9B7KKiOVkn4KrszOdDNpOvSyJ2AF9nSgvyO297/0lf+CLwnxraJ8pC9g0wlNIblnCiavZqLypz8nsOogowwZyzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDAeBZMZKC6RLRBYajJLfZLuNAuxDDiJ1byGvy+MhJs=;
 b=SdvhU/RoMquCzQ4Ylkq3AyDqwRMqDb5nFn9H5wuVsMX4o08ZBNCkvz/HKVt55NWXweDnyPlGUrzM+sLkq53Qas/kIhJNFciDlLjmlNvKBxar6a1/wCOXujmeA2g5LiChE4w4P4e470N/ntMdPrHBQKqRoDyJ4LZtzJZnbS800S+KveJ8/t3NaUxnXG/ZOELQ9lP132UU5nUD36cQgxHO5U2DW0qUk4FjTLGDag01UVfFcIazJf0MujEHcEcXlAf22Ey2cVOQq579FoVXqrPOxHUSPAUn01xYrjj8IceYzYu7y7ESLt4877PIW4cvV4z1pzUI1/Ltf2PQwLYX6UuBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDAeBZMZKC6RLRBYajJLfZLuNAuxDDiJ1byGvy+MhJs=;
 b=z/RU1iuPJVgIukQEka6++RZ+ZdJeO4Zoln+zwYem05gHGeWrQcKDDvmCF6fAT6g53GrC1/PDm4CLjoX7h0steH7Izls7VNi1GpPMuTtQ8dkaVhhQ2qfbodAILDsYCt3IEEe20xzt37ydk+Qd4yW+KzV4BeWxYCx23nSmXxw1eik=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20; Thu, 3 Aug 2023 16:11:38 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 16:11:38 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add support to create large TMR BO for APU
Thread-Topic: [PATCH] drm/amdgpu: add support to create large TMR BO for APU
Thread-Index: AQHZxEtBMA1g3ttLEkKRYh1urNE1Ya/YtYkCgAAJTgCAAAJXfg==
Date: Thu, 3 Aug 2023 16:11:38 +0000
Message-ID: <DM6PR12MB42506658E5921B5D8233CF67FB08A@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20230801073832.2133509-1-Lang.Yu@amd.com>
 <DM6PR12MB42503F416BD78E9163666A90FB08A@DM6PR12MB4250.namprd12.prod.outlook.com>
 <b1e37050-9165-df2e-c621-f6f3b368d98e@amd.com>
In-Reply-To: <b1e37050-9165-df2e-c621-f6f3b368d98e@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-03T16:10:45.7613079Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4250:EE_|CH0PR12MB5266:EE_
x-ms-office365-filtering-correlation-id: fa58748e-9e9f-46e5-886e-08db943c515a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yxV5M1In8jF6sLikwgaWViaIvoK6xDNbqecWBxEIesTDovTpBW4e+Hg+sFZz+DW6YNvZUU9iBvoxjIQorrsrDFkvlu91GG0rXfS5r/0hxh+eeJYOvkf9S7ifytqtP3G8xX+W9++4L1jBCdsflnEJUInmac5WgQukZ9aQQroFzfTTW1VzxWaGSsZ2Er6hStkLXJmZ9m7Ae5/tS3xurSFMz1LKNik3zo+hgllMJnXGUB2aiRhIi7Jrp01LDMp1DDK8muGRfL12ROFM3+4aL7Nj/K034/UofvdP1tufi6LD6UIobPNnCZMOJr4eaIg6XpXat2RdMLapdS2/7OWr6uTMZRHMMDXU26HOdfEaOp7keJO8syEINPTR8Wet7KmvPdlttjhuhoFRxGs+51nTNwZEHscYBkGr4YkFV3G/A3scNQOMqS+nDoHeHbzWGOKxE2HY1LGjWx+kpVfWG9mG1qsQdLYY68/Oamx8IL6n4wsB5tr1yjEo03QtsUi7dNtP/MvBGdfI76FExp/41rjEGDrJiQh7IGxmmPaShcT492SjaMphT2o6jWoCv1Ib8grVLhzin86V54F6x02eXCzCe50Zvwf7z/eKS2/TLODeHoyvd84NUmzLWf7YTxTs6JPVYX+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(53546011)(6506007)(83380400001)(186003)(26005)(8676002)(76116006)(316002)(66556008)(2906002)(4326008)(64756008)(66946007)(5660300002)(66446008)(66476007)(41300700001)(8936002)(9686003)(7696005)(71200400001)(52536014)(54906003)(110136005)(478600001)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?V1lOcCtDL0tUcEdUdU9zMnVTK3lIU1ZQUkRSSlV5NjhNbkdRbTZGTjBsNjRJ?=
 =?gb2312?B?NmNLcDdOQjJXZkN1cWxSZnhCZnZPR2dzTmdxZ3hqcEFnOERVQk5BM2V6Tm1j?=
 =?gb2312?B?SE9lbTNTbHFMQVhFT05zamdwQ0tLZTR1eXV3eHRuTFdNZ1NuSzBpWklyQ2xx?=
 =?gb2312?B?cU1tdTFLcDk5enprQU1abW00LzJLY01vaW5QMHZQdHY2LzVuRkR6ZnBJcEJS?=
 =?gb2312?B?UHBQSFlrYWpNdDZBSkE0NGNDbnJoemZWMWVLU3p0aERBRHlJdFFIUFBXYnFF?=
 =?gb2312?B?ejJ1eVZNMVRkN1RlZ2NmaCt5SHpPdEM5d0kvOUtsRUFjRjZuYm54S1lKYlkv?=
 =?gb2312?B?dnFsT2lhZno4OXpaREJyNy9nYXZ4N1hSSndiZEJMZkowbGtzdy9WVHliWm5p?=
 =?gb2312?B?dVZ1RlErR1ZGaVN2dmdqRGwzOVBsUXRndzV4aHdPeWxKbmFMOCtQdGZBbm1w?=
 =?gb2312?B?ZUp1MXZjcHh2M2d2MXdnZWRsQURiK2Zwa0QxdFRBQWpoT3dOK0t4Y25iM0Q1?=
 =?gb2312?B?UTEzVW1Ucm9GaTVDaVhhdWt4blIvbTVIRms1S2JoZnk4cFBQL1VJSUFROGFJ?=
 =?gb2312?B?SFpoTG1DK2N4bHlhWVJzU3l1Z0NDcUoyQTRLMTd3TE1RQzZ3T01QcUtsK1Rw?=
 =?gb2312?B?QjUzSWJMeVJrVDBQNFlKR3hBaFBjakdkY1liT3I2eEZIQ1p2UWM1REh1MkVm?=
 =?gb2312?B?UnRjZTNNZHljQzAvSXg1VjBJaThHYzZDU2QyVks5TFhSeVc5U1BIWmNXQklr?=
 =?gb2312?B?WWVyVTcrRmJEMXFYOGVVQTZJZ094eUpjaFBPd2grS3l4S2I5ZG1hSDJMMFNI?=
 =?gb2312?B?dFRmeVI2Y3cxOU1jOHBIclUwVCtEanF2QjVuMzdTMkJjUXNyb2l0U3luZVpD?=
 =?gb2312?B?eE42anBPVkVjL0ZZb0U0bm1sSk1xQk5maXN1SFk5Vm9kOURSUHFYTW9NNytv?=
 =?gb2312?B?TGtFdHJpMUtrZHJUUUljb2NsZEhtL09jelY1NWdEVFlNaWw5Qkk1c2E5czFn?=
 =?gb2312?B?UGY2NEdCYWlsY0Q0emorWFZSYW1oZzhidmN1aHAxcmxIQVZmT1hDZWxnaHJy?=
 =?gb2312?B?OGwreURaeHVUcHJxTDB0VzY0aTAyWVp3aU1EcUhWZUlHdDZDeWV3SUt5TGpI?=
 =?gb2312?B?M3RaQzYrSTNOTkVBbTFncmVIelhWREcybHQvejZzM2pyQThlYXA4b2UzYzBS?=
 =?gb2312?B?UEplQ3cxcERvZ1drRTVLaDJBODFLN2o1RFdqZjIramJMc00ycEd5Y0lva2I1?=
 =?gb2312?B?MDV2Tk1YRU5YY2dBV05wTWl6b05jL040WDBXRlJmZFp2ekNiaTBvWGVSWEtk?=
 =?gb2312?B?eS9OU2tMM2NKM2pjcjFueHQ2VlhKak51NWlDMlFVL2ttMTJkZXhnLzhnS0xV?=
 =?gb2312?B?aC9NbDJxR1hEUEp4dGxZaUxsVEx1Mys3UENabm5ITkROSVJNSHNkdHZlMTdu?=
 =?gb2312?B?QzRDM0JFaGxSeG9lTGpFVlZaK042bktCTEs3eEVMK3l1Z3NUMnFLYnF6VTRz?=
 =?gb2312?B?MjRaQ2FaYjlsbVFrQm1TbStrUDhubk4zbk1Nd2FwMHJ6eUhEc2xMaDBaaHM0?=
 =?gb2312?B?aWk2K3RvOVpwbVREUU5RY0QwVGhpTHMxSnpUYXg3dUhKSVd5VlVqRUVXVlhD?=
 =?gb2312?B?SHNkT3VYK25YcHZjRFNLdTRiaWkxaUhwb1RjNlUrT1RjUG4xWkkwYjlQR2pK?=
 =?gb2312?B?YWpBdDhhZXVKVk9MK0JvTDBnT25PaGEzRDV0YU45azA4LzdacTdBckx1blJS?=
 =?gb2312?B?SDNmeG9wQ0hRWEVma2JhTmp5d3JJUVJwS1RmWWRXcjEvcGxWeXN5dnFPLzdD?=
 =?gb2312?B?Q3U0T3pMN0VtTkxNVzgxRmxKS21iMjE5eGVJZlpNUHdtT1M1UEJOVk5yNjE4?=
 =?gb2312?B?V1pPdnZkem5UNHAvWUFSL2lsTjQycXh0NlpCYnZRaVEwNDlvRTBEcnR4UUs0?=
 =?gb2312?B?L252enBZcFBwZWZBZGVyUEMzZlY2bHpzRlBpbzhhZGh3amV0d0VXQnA3M2Yr?=
 =?gb2312?B?dnFBL0lrc1o0dnZ0b0pMOHdqaHpLTERCbjQ0cWlmTHhaTXdsWksyKzRRUzdH?=
 =?gb2312?B?RlM1N1FlT1hvYUVncTVMRFp4Q1dtZjE1WUpFbG5jQTBENFM1RUJjbXVRcVdH?=
 =?gb2312?Q?2eH7tFjwK5lKO1lJJMuU1JgPg?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB42506658E5921B5D8233CF67FB08ADM6PR12MB4250namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa58748e-9e9f-46e5-886e-08db943c515a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 16:11:38.6476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RbD2gMSHEw6V2qKcfOtNHXq/XgHqoZ5fnp+1nJdiQHZ0BWZn70MmzWiwHocKVJbPuHSgUAO1QEJLQ18PTQ3Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB42506658E5921B5D8233CF67FB08ADM6PR12MB4250namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KR29vZC4gWW91IGNhbiBqdXN0IHNlbmQgdGhhdCB0byBhbWQgZ2Z4IGxpc3Qg
ZGlyZWN0bHkuDQoNClJlZ2FyZHMsDQpMYW5nDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQq3orz+yMs6IFBhbmVlciBTZWx2YW0sIEFydW5wcmF2aW4gPEFydW5wcmF2aW4uUGFu
ZWVyU2VsdmFtQGFtZC5jb20+DQq3osvNyrG85DogRnJpZGF5LCBBdWd1c3QgNCwgMjAyMyAxMjow
MTowOCBBTQ0KytW8/sjLOiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0Ks63LzTog
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFpoYW5nLCBZaWZh
biA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQrW98ziOiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBh
ZGQgc3VwcG9ydCB0byBjcmVhdGUgbGFyZ2UgVE1SIEJPIGZvciBBUFUNCg0KSGkgTGFuZywNClRo
aXMgaXMgbm90IHRoZSByaWdodCBtZXRob2QgdG8gYWxsb2NhdGUgbWVtb3J5IGlmIHlvdSBkb250
IGhhdmUgYSBzcGVjaWZpYyBvZmZzZXQgZm9yIFRNUi4gSSB3aWxsIHNlbmQgYSBwYXRjaCBmb3Ig
eW91ciB0ZXN0aW5nIGluIGRybSBidWRkeQ0Kd2hpY2ggY291bGQgZml4IHRoaXMgcHJvYmxlbS4N
Cg0KUmVnYXJkcywNCkFydW4uDQoNCk9uIDgvMy8yMDIzIDg6NTggUE0sIFl1LCBMYW5nIHdyb3Rl
Og0KDQpbUHVibGljXQ0KDQpQaW5nDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
t6K8/sjLOiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjxtYWlsdG86TGFuZy5ZdUBhbWQuY29t
Pg0Kt6LLzcqxvOQ6IFR1ZXNkYXksIEF1Z3VzdCAxLCAyMDIzIDM6Mzg6MzIgUE0NCsrVvP7Iyzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+PG1haWx0bzphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCrOty806IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+PG1haWx0bzpDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBQYW5l
ZXIgU2VsdmFtLCBBcnVucHJhdmluIDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPjxt
YWlsdG86QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlm
YW4xLlpoYW5nQGFtZC5jb20+PG1haWx0bzpZaWZhbjEuWmhhbmdAYW1kLmNvbT47IFl1LCBMYW5n
IDxMYW5nLll1QGFtZC5jb20+PG1haWx0bzpMYW5nLll1QGFtZC5jb20+DQrW98ziOiBbUEFUQ0hd
IGRybS9hbWRncHU6IGFkZCBzdXBwb3J0IHRvIGNyZWF0ZSBsYXJnZSBUTVIgQk8gZm9yIEFQVQ0K
DQpUTVIgcmVxdWlyZXMgcGh5c2ljYWwgY29udGlndW91cyBtZW1vcnksIGFtZGdwdV9ib19jcmVh
dGVfa2VybmVsKCkNCmNhbid0IHNhdGlzZnkgbGFyZ2UoPjEyOE1CKSBwaHlzaWNhbCBjb250aWd1
b3VzIG1lbW9yeSBhbGxvY2F0aW9uDQpyZXF1ZXN0IHdpdGggZGVmYXVsdCA1MTJNQiBWUkFNIG9u
IEFQVS4NCg0KV2hlbiByZXF1ZXN0ZWQgVE1SIHNpemUgPiAxMjhNQiwgdXNlIGFtZGdwdV9ib19j
cmVhdGVfa2VybmVsX2F0KCkNCnRvIGNyZWF0ZSB0aGUgQk8gYXQgb2Zmc2V0IDMyTUIgd2l0aCBh
IHN0ZXAgMU1CIGluIHRoZSBWUkFNIHJhbmdlLg0KDQpTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxM
YW5nLll1QGFtZC5jb20+PG1haWx0bzpMYW5nLll1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCmluZGV4IDE1MjE3ZTMzYjUx
ZC4uM2ZhZGZhYTYzYjJlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMNCkBAIC03ODMsNiArNzgzLDM0IEBAIHN0YXRpYyBib29sIHBzcF9ib290dGltZV90bXIoc3Ry
dWN0IHBzcF9jb250ZXh0ICpwc3ApDQogICAgICAgICB9DQogfQ0KDQorc3RhdGljIGludCBwc3Bf
Y3JlYXRlX2xhcmdlX3Rtcl9ib19mb3JfYXB1KHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCB0bXJfc2l6ZSwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICoqY3B1X2FkZHIp
DQorew0KKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZyYW1fbWdyICptZ3IgPSAmcHNwLT5hZGV2LT5t
bWFuLnZyYW1fbWdyOw0KKyAgICAgICB1aW50MzJfdCByb3VuZGVkX3NpemUgPSByb3VuZF91cCh0
bXJfc2l6ZSwgMHgxMDAwMDApOw0KKyAgICAgICB1aW50MzJfdCBzdGFydCA9IDB4MjAwMDAwMDsN
CisgICAgICAgdWludDMyX3Qgc3RlcCA9IDB4MTAwMDAwOw0KKyAgICAgICBpbnQgcmV0ID0gLUVO
T01FTTsNCisNCisgICAgICAgZm9yICg7IHN0YXJ0ICsgcm91bmRlZF9zaXplIDw9IG1nci0+bWFu
YWdlci5zaXplICYmDQorICAgICAgICAgICAgc3RhcnQgKyBzdGVwIDw9IG1nci0+bWFuYWdlci5z
aXplOyBzdGFydCArPSBzdGVwKSB7DQorDQorICAgICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X2Jv
X2NyZWF0ZV9rZXJuZWxfYXQocHNwLT5hZGV2LCBzdGFydCwgdG1yX3NpemUsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBzcC0+dG1yX2JvLCBjcHVf
YWRkcik7DQorICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtRU5PTUVNKQ0KKyAgICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7DQorICAgICAgICAgICAgICAgaWYgKHJldCkNCisgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQorDQorICAgICAgICAgICAgICAgcHNwLT50bXJf
bWNfYWRkciA9IGFtZGdwdV9ib19ncHVfb2Zmc2V0KHBzcC0+dG1yX2JvKTsNCisNCisgICAgICAg
ICAgICAgICBicmVhazsNCisgICAgICAgfQ0KKw0KKyAgICAgICByZXR1cm4gcmV0Ow0KK30NCisN
CiAvKiBTZXQgdXAgVHJ1c3RlZCBNZW1vcnkgUmVnaW9uICovDQogc3RhdGljIGludCBwc3BfdG1y
X2luaXQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQogew0KQEAgLTgxMyw4ICs4NDEsMTMgQEAg
c3RhdGljIGludCBwc3BfdG1yX2luaXQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQogICAgICAg
ICAgICAgICAgIH0NCiAgICAgICAgIH0NCg0KLSAgICAgICBpZiAoIXBzcC0+dG1yX2JvKSB7DQot
ICAgICAgICAgICAgICAgcHB0ciA9IGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpID8gJnRtcl9i
dWYgOiBOVUxMOw0KKyAgICAgICBpZiAocHNwLT50bXJfYm8pDQorICAgICAgICAgICAgICAgcmV0
dXJuIDA7DQorDQorICAgICAgIHBwdHIgPSBhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSA/ICZ0
bXJfYnVmIDogTlVMTDsNCisgICAgICAgaWYgKHBzcC0+YWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBV
ICYmIHRtcl9zaXplID4gMHg4MDAwMDAwKQ0KKyAgICAgICAgICAgICAgIHJldCA9IHBzcF9jcmVh
dGVfbGFyZ2VfdG1yX2JvX2Zvcl9hcHUocHNwLCB0bXJfc2l6ZSwgcHB0cik7DQorICAgICAgIGVs
c2UNCiAgICAgICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwocHNwLT5h
ZGV2LCB0bXJfc2l6ZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUFNQX1RNUl9BTElHTk1FTlQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEFNREdQVV9IQVNfVlJBTShwc3AtPmFkZXYpID8NCkBAIC04MjIsNyAr
ODU1LDYgQEAgc3RhdGljIGludCBwc3BfdG1yX2luaXQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3Ap
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9H
RU1fRE9NQUlOX0dUVCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJnBzcC0+dG1yX2JvLCAmcHNwLT50bXJfbWNfYWRkciwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHB0cik7DQotICAgICAgIH0NCg0KICAgICAg
ICAgcmV0dXJuIHJldDsNCiB9DQotLQ0KMi4yNS4xDQoNCg0K

--_000_DM6PR12MB42506658E5921B5D8233CF67FB08ADM6PR12MB4250namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Good. You can just send that to amd gfx list directly.</di=
v>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards,</div>
<div dir=3D"ltr">Lang<span id=3D"ms-outlook-ios-cursor"></span></div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr">
<div dir=3D"ltr"><br>
</div>
</div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Paneer =
Selvam, Arunpravin &lt;Arunpravin.PaneerSelvam@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Friday, August 4, 2023 12:01:08 AM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Zh=
ang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH] drm/amdgpu: add support to create large TM=
R BO for APU</font>
<div>&nbsp;</div>
</div>
<div>Hi Lang,<br>
This is not the right method to allocate memory if you dont have a specific=
 offset for TMR. I will send a patch for your testing in drm buddy<br>
which could fix this problem.<br>
<br>
Regards,<br>
Arun.<br>
<br>
<div class=3D"x_moz-cite-prefix">On 8/3/2023 8:58 PM, Yu, Lang wrote:<br>
</div>
<blockquote type=3D"cite">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#008000=
; margin:15pt; font-style:normal; font-weight:normal; text-decoration:none"=
>
[Public]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div>
<div>
<div dir=3D"ltr">Ping</div>
</div>
</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Yu, L=
ang
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Lang.Yu@amd.com">&lt;La=
ng.Yu@amd.com&gt;</a><br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Tuesday, August 1, 2023 3:38:32 PM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> <a class=3D"x_moz-txt-link-abbreviated" href=3D"=
mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>=B3=AD=CB=CD:</b> Koenig, Christian <a class=3D"x_moz-txt-link-rfc2396E"=
 href=3D"mailto:Christian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a>; Paneer Selvam, Arunpravin <a class=3D=
"x_moz-txt-link-rfc2396E" href=3D"mailto:Arunpravin.PaneerSelvam@amd.com">
&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>; Zhang, Yifan <a class=3D"x_moz=
-txt-link-rfc2396E" href=3D"mailto:Yifan1.Zhang@amd.com">
&lt;Yifan1.Zhang@amd.com&gt;</a>; Yu, Lang <a class=3D"x_moz-txt-link-rfc23=
96E" href=3D"mailto:Lang.Yu@amd.com">
&lt;Lang.Yu@amd.com&gt;</a><br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amdgpu: add support to create large TMR BO=
 for APU</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">TMR requires physical contiguous memory, amdgpu_=
bo_create_kernel()<br>
can't satisfy large(&gt;128MB) physical contiguous memory allocation<br>
request with default 512MB VRAM on APU.<br>
<br>
When requested TMR size &gt; 128MB, use amdgpu_bo_create_kernel_at()<br>
to create the BO at offset 32MB with a step 1MB in the VRAM range.<br>
<br>
Signed-off-by: Lang Yu <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:=
Lang.Yu@amd.com">
&lt;Lang.Yu@amd.com&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 38 +++++++++++++++++++++++-=
-<br>
&nbsp;1 file changed, 35 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 15217e33b51d..3fadfaa63b2e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -783,6 +783,34 @@ static bool psp_boottime_tmr(struct psp_context *psp)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+static int psp_create_large_tmr_bo_for_apu(struct psp_context *psp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; int tmr_size,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; void **cpu_addr)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_mgr *mgr =3D &amp;=
psp-&gt;adev-&gt;mman.vram_mgr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rounded_size =3D round_up(tm=
r_size, 0x100000);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start =3D 0x2000000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t step =3D 0x100000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; start + rounded_size &lt;=3D m=
gr-&gt;manager.size &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start +=
 step &lt;=3D mgr-&gt;manager.size; start +=3D step) {<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_bo_create_kernel_at(psp-&gt;adev, start, tmr_size=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;tmr=
_bo, cpu_addr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret =3D=3D -ENOMEM)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;tmr_mc_addr =3D amdgpu_bo_gpu_offset(psp-&gt;tmr_bo);<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;/* Set up Trusted Memory Region */<br>
&nbsp;static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;{<br>
@@ -813,8 +841,13 @@ static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;tmr_bo) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev) ? &amp;tmr_buf : NULL;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;tmr_bo)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr =3D amdgpu_sriov_vf(psp-&gt;adev=
) ? &amp;tmr_buf : NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;flags &amp; AMD_=
IS_APU &amp;&amp; tmr_size &gt; 0x8000000)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_create_large_tmr_bo_for_apu(psp, tmr_size, pptr);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&gt;adev, tmr_siz=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_TMR_ALIGNMENT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_HAS_VRAM(psp-&gt=
;adev) ?<br>
@@ -822,7 +855,6 @@ static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;tmr_bo, &a=
mp;psp-&gt;tmr_mc_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB42506658E5921B5D8233CF67FB08ADM6PR12MB4250namp_--
