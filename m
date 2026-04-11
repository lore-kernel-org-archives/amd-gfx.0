Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B35F45A1D
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2026 05:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4163310E146;
	Sat, 11 Apr 2026 05:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bPecxBFh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7899D10E146
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Apr 2026 05:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enFTAkaEq4ukQgixXVTaU6TOqLqmtJzaKFJ/ZUJM7sDKXXAsoy55wzdYYA5BEzN/yCy6dnd9zBHNz+A6aSL4N18+t8StWcVp1G3dFCUIQ4lacKHaM4hKJ/4vGRm67FAgOnG3FCceTJPYtRvK4S7RjSqkxQu/5UwKcVUic2tzDbUQqQjDyCr6/SiFoEfr7TNl6zXvCqn1CsaglUhgIY4C7o8FAV5u8Z/OccwKW7LKJ3FgvQuWo/rz079pIGp2hQVQi7pj8gjjDW9ZlgU1NTC+198pxY7vVz0gk2UiCPw/uPS6howkpFY8+dqLXUrLRFqxIwlrdq723EyeR7DsFedyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLaKAsR5veuZnQMlSeYdvJHOJb7/F7YszmD17dmo310=;
 b=PLQnAI7L/2gqHETkDYhaptTZsMFLGye1ud8kfHkMMPJRTte0SmvSk1DUNB3UJ4ENpaNfOuNcXCuLsjn2q40pQjG+8fy8LoiWy97YKhYCW9KPHW4g8hy5eOHt+aNVMVK2b69jvzytW6RX7TYoXphGfD3xJjt+4QP5S9G22y4UV1arRyTHs/iWlVjoIui1sV05p8dcbQOH7Elcg68tdVHDpK0ixKNjpdbNWi2wsF9c/wTgVF/S4FwK6h5C9ZxAgz+DRx7fC4V8djRIuTmFMWt1lv1RvGZ0SsBBmZZzsPPRM10Vof99QOx2fC09k6avPzGhwcWWF7ISLDMcf3wEEaFeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLaKAsR5veuZnQMlSeYdvJHOJb7/F7YszmD17dmo310=;
 b=bPecxBFh5rZNmUOoiDWhkg7HQ7AcEo0UQl3EHYMj6JUH1lNaQ0XGwP1Qup4ZxLwwGU5c3ekbaf+/k6fuH4XvK97cM7zd2Bwu5VcfITwwjx2RoQXeFMcoHU176y4DWeWjN0oxF1EOrPEz8l3SSnkePcq8vScT5qea4KLpazWSY/M=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.45; Sat, 11 Apr
 2026 05:30:50 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9769.018; Sat, 11 Apr 2026
 05:30:50 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Joshua Peisach <jpeisach@ubuntu.com>, Dan Carpenter <error27@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: RE: [bug report] drm/amdgpu/amdgpu_connectors: remove
 amdgpu_connector_free_edid
Thread-Topic: [bug report] drm/amdgpu/amdgpu_connectors: remove
 amdgpu_connector_free_edid
Thread-Index: AQHcyLxGxPMW8r5GfEKD4q7zhnBaS7XYMcCAgAEkxSA=
Date: Sat, 11 Apr 2026 05:30:50 +0000
Message-ID: <IA0PR12MB8208DAB29B0617E8F6D082C490262@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <adinpZORBkhVcw31@stanley.mountain>
 <DHPGIF5U4U8O.1R90J7IR4M80L@ubuntu.com>
In-Reply-To: <DHPGIF5U4U8O.1R90J7IR4M80L@ubuntu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-11T05:30:42.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DM3PR12MB9414:EE_
x-ms-office365-filtering-correlation-id: 84106ed2-98b9-45bb-ae17-08de978b7e1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: J06sFk/kw3IS4F5HWsVjlJivsbl9Q1piEULiHHI5ttoc4X7V9gx0h3tfll1AQEavdiAWPLbMAcCrlc/L1ulOfUIhCWAMFbv8dXUZogPWB+RrfhXAWsbp6kwghmkn1eima9XvqoiNQ860K5nd2zlp4mVp6xssfrCw6QsHUsnhaliZJlKgFLcKAgXGKlESMSXSDi74vXxhnTQiUXSzHLkSxvL6k0Z/PZ0xHwK5utCmK5I4ihmXQ+HjeAxYRWswN48Zi3sp0h/mD7RPuOc2UODzodjT3CmdZhe9FnmeqXwRmQ2hKQWb0C0A5TAERhz5IoAfvz6csNBpdLkHpM7XEfn1/99MseaCZWwDALYb1RIWtAqXb8zvZCpvDkGMdcZLiccJz4zaJ9nnmNeOoYNBplr82oC4LyWvBB0pJ2wOcc6PuKaXz3W6AhRtquOHpGK+e7ZIR1ZJDq3sKCEtjwOe+7dWMRMtCu1v0JdmD9UjWFkyMeVgHie8CBxk/7SeeTcE0u/B1nGv51pEYtyos+2hJM2Qt9D/U6CLMfy/w+XRg+Cpads/0KzOO7rCdAIRtnMesCHENybnGmr1EY1GPiH2Eijediz9QPYOroypN/7RNa3L0nFXVGCNVQDw3Pj0Tr5nBwET8UX8tBJdpGsp9XIhwVPp5Dlj3nRi07wG5Kg4EBCeuqhzdgQH+QYfE8ABD0JxlTkpCkmh9nGA4lv+4V6hrZ/fza+a0B68+ZfTnOgEQ0p73FoFgGjyaVwWoTqODedKD99ATnBfMgVXsLPLYPG/+oovoiWWi1kow/eUxzdPmmz9N0o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2VXOWNIdmV2cU12dFA2MEJ3czJDZ0dIdWpCWDlQOTdXUW10NUs3cXNYb0Mz?=
 =?utf-8?B?aGM4MEZINEFzVW5UMjhhMk41SmVOY0xzVlFSb0FOMFgyRUZwWldqSUpuZ3lo?=
 =?utf-8?B?dkg1MU9iT1VJS2VFS3h0SkRtRWQyOE5idFhtblZXZUFXS2V3T0VZQ2pma2RO?=
 =?utf-8?B?VW1LTkZYa2JGTnNIZnFTOStJUjNsZW4vOXV6OFE0YmQwaU5RN0xJK0dIalBn?=
 =?utf-8?B?em1pYmNhaG02MzBzcHJNVVFRNHpwbzF6RUptMC9ZRzlXSUM2SHpxUTBIVFph?=
 =?utf-8?B?TzFMMVhqd2VRR0VDdUxOZmNkZFVYbGkzemNScEsvUmtCZUpXSUdpYXBMRmt3?=
 =?utf-8?B?dE1kZ205N3pBTEt6VmVpMkN1T2Njdy9rbWdmMmZKSE1IYUxvSjhNNWxlRStQ?=
 =?utf-8?B?SGVaRC9XZ2xlYzhHUW56enNwQklrdVkyRVpkK3BvaFFEOGcyd3NKdktOcVFi?=
 =?utf-8?B?clVFQkpuekhLVVd2N2svaEptcEJ5c3RHNDIrazg3TWlEZ3pmcXZOWFp1ZE03?=
 =?utf-8?B?SDJMeWdKQ3dJdlcvc0UybXd2NFMrbWl2L2h5VjdVSTVPa0MrVE1VOFJnWUNp?=
 =?utf-8?B?dEk2VDgzSmpYbHNIcHhpTXptTnZjUDNwMzZMZnFwWmI1cDZpbmtYbG10WjlJ?=
 =?utf-8?B?dEh1Y3RaQzd5cHkzWnZ6cjl2NEJmdnduUUdQMG1sQXR5dDFMMExFNElLSHF2?=
 =?utf-8?B?Nm5HRGJBdEZlY3pwYmEwNnk0V2xUOExlVW1iVHlyNitQaEFaK3ZCVzJVby91?=
 =?utf-8?B?bXdxenh0QnM4UjNMdE5qYitGdG5HUE85WFhmODRiV0hHbHZ6dXdheStCb0RU?=
 =?utf-8?B?V0RNVDJZaEZqYkZpWEVpSlFCdXBFRG5KMkZ3WWwvaHVxNkh1T1dsVDR6Nk0y?=
 =?utf-8?B?ZmxyTmk4eGM1V0gwblQ5REdnbjhFWllObnlGaWVmK0hlZzJRTXB4SjlqdmRh?=
 =?utf-8?B?K3pMT0wxQXorM0ptejQ2WFpXekh1R0toR2NyNmZZM2FzV2JXN0lrY0tXdjBi?=
 =?utf-8?B?dDl0aXhmSEJucGx1S2pBaFFZcCt0VTJWNHlDS3hZTDg1MDlvTUNnTG9OYlhK?=
 =?utf-8?B?NE81MUdqR3lPNGRMN1VwYXROWkFMbTFPbElSN1MxS3hLOHMxZ280UndNVTc1?=
 =?utf-8?B?ZWR6QTZnR1h0QTV4Vk10LzBidkNMbDQvRWJTSVdzbTRSb0wxajZ2UHFNZDBm?=
 =?utf-8?B?QzB0MHgwT0tpNGRxOEpYNEIrN20vcjQ3Q2N2NEJDZ2c5c01wR2w4L0c5RFRz?=
 =?utf-8?B?K1hJRzZQT1VmRUM4S2ZvUlFjdEJudE02M0tUdVJwejFEY1hWNGdRcE1RU1lN?=
 =?utf-8?B?d0Q3OW52SktjNmdtelBiUnV5ZWl1aHJmelEwczMrVFhOaHUrZDJ0MjV1NGFs?=
 =?utf-8?B?NEU4bzFVd0FBWjZqYVhuVTlHeW9PanJ3MWx6WGFwbkV1V2F0cXBwQzRPYXhn?=
 =?utf-8?B?alBhaEdOOVpsTFBWUHY4UmV5dlExMlNJb0pXcXZjN3JMaG9EOFlBWHJlN3lM?=
 =?utf-8?B?Q21VN3crWjRaaUsyUmQwSGRWSmdMYThqN3E3Z1h4QzkxQ2JjV2NRaVE0VHR6?=
 =?utf-8?B?ekVNdlo2YlJxVlk5TEJOMWdYZVVYb0F1eG9QVURGOFZuRnhCYmdSdXVXeksv?=
 =?utf-8?B?K0ZvM1YxNmlxMk5obnBIOXZRNXFLTlVGZGd3dWF4YThUOXFqbTRXaDcwMFl2?=
 =?utf-8?B?citrRFZ1ajRzSndSWi9SWkgvdnRheUdFMzRWS3BXUkJ5MnIzbzVMdnhQNEo1?=
 =?utf-8?B?UkQ0UUMyVDBXNkRkWFRKNUk2NzlWa3daT0xTVFozRnhTM2p0TlFrSThmVVlX?=
 =?utf-8?B?eU5vbXh0SDR0NGw0UnI2VzZGNTYxT1FPN0FTL0FFaENwOGFLcUVkWFpvYmk0?=
 =?utf-8?B?eHBteG5iWnEvVXhXR01sWkZhaWxoeU1VVnB1amVKTmZ2N1BUdDNZTDg0Zk1L?=
 =?utf-8?B?SEFRenFTQUZFWDIxR2JXMkVPZC8vandCWkhhcndkLzZ6bjc4VVVFa2NSUmJp?=
 =?utf-8?B?S3RTaXlRZ2h3L1lkdTFXb3JTdm5WZXA2WFhXaGNaamVSdFUyMzZ5TXZiWGtW?=
 =?utf-8?B?UVFLQWpkcU1tNGdnU0M4NFlsV0ZyTHhubGFETndvOG05WkVIRjlrb1Jzb2cv?=
 =?utf-8?B?TFlQZVZTTGp2VEJaMjhzdk4yVkM0YUJaNk9ob1hXWUljTFJvd1YyeU9CbUZ2?=
 =?utf-8?B?WW14Q014RHpTc2NleXhtT2dPd3VTeGM5SE1pSUhwc3ZobUtWS0lXQUo5V0p1?=
 =?utf-8?B?Q1lNemVjYnZ0OXlETjJ5MzBES3Y3UlpscWx5WUJYaTBKQUZkdVA5RTVPZkd4?=
 =?utf-8?Q?6jlzWTrSC7zaRrcIq5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84106ed2-98b9-45bb-ae17-08de978b7e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 05:30:50.4642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzq/a7Hxc8kaRwpctBcSK9F1HsC0vPtZSQEBuDCXq7b/srxKo/TK7//zoa7k3uHDwvEKzKIIy5dEt2zpBWU0UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NodWEg
UGVpc2FjaCA8anBlaXNhY2hAdWJ1bnR1LmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxMCwg
MjAyNiA1OjMwIFBNDQo+IFRvOiBEYW4gQ2FycGVudGVyIDxlcnJvcjI3QGdtYWlsLmNvbT47IEpv
c2h1YSBQZWlzYWNoDQo+IDxqcGVpc2FjaEB1YnVudHUuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1A
YW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtidWcgcmVwb3J0XSBkcm0vYW1kZ3B1L2FtZGdwdV9j
b25uZWN0b3JzOiByZW1vdmUNCj4gYW1kZ3B1X2Nvbm5lY3Rvcl9mcmVlX2VkaWQNCj4NCj4gT24g
RnJpIEFwciAxMCwgMjAyNiBhdCAzOjMyIEFNIEVEVCwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4g
Pg0KPiA+ICAgICAxMDU3ICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9jb25uZWN0b3It
PnVzZV9kaWdpdGFsID0NCj4gPiAtLT4gMTA1OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRybV9lZGlkX2lzX2RpZ2l0YWwoYW1kZ3B1X2Nvbm5lY3Rvci0+ZWRpZCk7DQo+ID4NCj4g
PiBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eIFVzZSBhZnRlciBmcmVlLg0KPiA+DQo+DQo+IExvdmVs
eS4gSSB3YXMgd29uZGVyaW5nIGlmIHRoYXQgQ2xhdWRlIHJldmlld1sxXSB3YXMgYWNjdXJhdGUu
IEkgYWxzbyBhc2tlZCBpbiBJUkMgaWYNCj4gaXQgd2FzIHNvbWV0aGluZyB0byBiZSBjb25zaWRl
cmVkIGFib3V0IGJ1dCBJIGRpZG4ndCBnZXQgYSByZXNwb25zZVsyXS4gSSdsbCBiZSBtb3JlDQo+
IHByZXNzaW5nIG5leHQgdGltZSwgc29ycnkuDQo+DQo+IFRoaXMgbW9ybmluZyBJJ20gdW5hYmxl
IHRvIHRlc3QsIGJ1dCBJIHRoaW5rIHJldmVydGluZyB0aGUgY29tbWl0IHRoYXQgcmVtb3ZlZA0K
PiBhbWRncHVfY29ubmVjdG9yX2ZyZWVfZWRpZFszXSBzaG91bGQgZml4IGl0Lg0KPg0KPiBXaGF0
IGRvIHlvdSB0aGluaz8NCg0KSSB3ZW50IHRocm91Z2ggdGhlIGNvZGUgcGF0aCwgYW5kIHRoZSB3
YXJuaW5nIGxvb2tzIHZhbGlkOg0KDQpJbiBhbWRncHVfY29ubmVjdG9yX2R2aV9kZXRlY3QoKSwg
d2UgZG86DQpkcm1fZWRpZF9mcmVlKGFtZGdwdV9jb25uZWN0b3ItPmVkaWQpOw0KQWZ0ZXIgdGhh
dCwgd2UgY2FsbDoNCmFtZGdwdV9jb25uZWN0b3JfZ2V0X2VkaWQoY29ubmVjdG9yKTsNCkJ1dCBp
bnNpZGUgYW1kZ3B1X2Nvbm5lY3Rvcl9nZXRfZWRpZCgpOg0KSXQgaW1tZWRpYXRlbHkgcmV0dXJu
cyBpZiBhbWRncHVfY29ubmVjdG9yLT5lZGlkIGlzIG5vbi1OVUxMDQpTaW5jZSB3ZSBkaWQgbm90
IHNldCBhbWRncHVfY29ubmVjdG9yLT5lZGlkID0gTlVMTCBhZnRlciBmcmVlaW5nOg0KVGhlIHBv
aW50ZXIgaXMgc3RpbGwgbm9uLU5VTEwgKGJ1dCBhbHJlYWR5IGZyZWVkKQ0KU28gYW1kZ3B1X2Nv
bm5lY3Rvcl9nZXRfZWRpZCgpIGJlY29tZXMgYSBuby1vcA0KTm8gbmV3IEVESUQgaXMgcmVhZA0K
VGhlbiBsYXRlciB3ZSBkbzoNCmRybV9lZGlkX2lzX2RpZ2l0YWwoYW1kZ3B1X2Nvbm5lY3Rvci0+
ZWRpZCk7DQpBdCB0aGlzIHBvaW50Og0KYW1kZ3B1X2Nvbm5lY3Rvci0+ZWRpZCBzdGlsbCBwb2lu
dHMgdG8gZnJlZWQgbWVtb3J5DQpTbyB0aGlzIGJlY29tZXMgYSByZWFsIHVzZS1hZnRlci1mcmVl
DQoNClNvIHRoZSBpc3N1ZSBpcyBub3QganVzdCB0aGUgcmVtb3ZhbCBvZiBhbWRncHVfY29ubmVj
dG9yX2ZyZWVfZWRpZCgpLA0KYnV0IHRoYXQgd2UgbG9zdCB0aGUgYmVoYXZpb3Igb2YgY2xlYXJp
bmcgdGhlIGNhY2hlZCBFRElEIHBvaW50ZXIgYWZ0ZXIgZnJlZS4NCg0KQmVjYXVzZSBvZiB0aGlz
LCB0aGUgRURJRCBjYWNoZSBsb2dpYyBicmVha3MuDQoNCkFib3V0IHJldmVydGluZzoNCg0KUmV2
ZXJ0aW5nIHRoZSBjb21taXQgd291bGQgZml4IGl0IGluZGlyZWN0bHkNCkJ1dCBJIHRoaW5rIGEg
bWluaW1hbCBmaXggaXMgYmV0dGVyOg0KU2V0IGFtZGdwdV9jb25uZWN0b3ItPmVkaWQgPSBOVUxM
IGFmdGVyIGRybV9lZGlkX2ZyZWUoKQ0KDQpUaGlzIGtlZXBzIHRoZSBjdXJyZW50IGRlc2lnbiBp
bnRhY3QgYW5kIGZpeGVzIHRoZSBidWcgY2xlYW5seS4NCg0KQWxzbywgSSBub3RpY2VkIHNpbWls
YXIgcGF0dGVybnMgaW4gVkdBIGFuZCBzaGFyZWQgRERDIHBhdGhzLA0Kc28gd2UgbWF5IHdhbnQg
dG8gZml4IHRob3NlIGFzIHdlbGwgZm9yIGNvbnNpc3RlbmN5Lg0KDQpJIGFsc28gY2hlY2tlZCBh
bWRncHVfY29ubmVjdG9yX3ZnYV9kZXRlY3QoKSBhbmQgYW1kZ3B1X2Nvbm5lY3Rvcl9zaGFyZWRf
ZGRjKCkuIFRoZXkgc2hvdyB0aGUgc2FtZSBzdGFsZSBjYWNoZWQgRURJRCBwYXR0ZXJuOiBhbWRn
cHVfY29ubmVjdG9yLT5lZGlkIGlzIGZyZWVkIHdpdGhvdXQgYmVpbmcgY2xlYXJlZC4gSW4gdmdh
X2RldGVjdCgpLCB0aGlzIGlzIHRoZSBzYW1lIGZ1bmN0aW9uYWwgYnVnIGFzIERWSSBiZWNhdXNl
IHRoZSBjb2RlIHRoZW4gY2FsbHMgYW1kZ3B1X2Nvbm5lY3Rvcl9nZXRfZWRpZCgpIGFuZCBsYXRl
ciB1c2VzIGFtZGdwdV9jb25uZWN0b3ItPmVkaWQuIEluIHNoYXJlZF9kZGMoKSwgaXQgbWF5IG5v
dCB0cmlnZ2VyIGFuIGltbWVkaWF0ZSB1c2UtYWZ0ZXItZnJlZSBpbiB0aGF0IGZ1bmN0aW9uLCBi
dXQgbGVhdmluZyB0aGUgZnJlZWQgRURJRCBjYWNoZWQgaXMgc3RpbGwgdW5zYWZlIGFuZCBzaG91
bGQgYmUgZml4ZWQgZm9yIGNvbnNpc3RlbmN5Lg0KDQpEb2VzIHRoaXMgYXBwcm9hY2ggbG9vayBn
b29kPw0KDQpIYXBweSB0byBoZWFyIHRob3VnaHRzIGZyb20gb3RoZXJzDQoNCkkgY2FuIHNlbmQg
YSBwYXRjaCBpZiB0aGlzIG1ha2VzIHNlbnNlLg0KDQpUaGFua3MhDQpTcmluaQ0KDQo=
