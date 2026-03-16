Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFD8EFCBB6
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 06:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 684C310E31E;
	Mon, 16 Mar 2026 06:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GFHBwmnE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC9810E2C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 06:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jC6xYE6LccQuKvM9UhGN8YfRM/e9LGxjwAJP94FUyM1010tJxRKKLY4f+po3rmD88n7RTwAZya8fjjabmRw1P4kTNzP8Bs3vd1qsRhrHtxXMYGD5Uom9ehaQeXyzcJZTTwJGLyi29Fuxv8of04ywNnpgWGTdRxPc5c4xtAS/1fqIs83jzk+ckgdEmKPVfFxcjH3WJllYr0z3QZjl8ZZzvdQl956xNNZ0gh1+/64AYvy1msuS1zu3krGA6Wb4U/RcKLiZPCe8df28+go8qtvErBd/XIGZUWs/bFm6i2Ur47VC0FM+qchcwKRjirGIqj86nJEFoBJa+LCBglwQA6verA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ+WiQH5hPy0RwxLw8a6UaLMPwhA3xfEacPQXt0Fyi8=;
 b=Adwzg3Gh9sRi5B41emXtMCBe9wbzhObjS4OsJ8eDjhcTZLS2Onwt6UQG2OgvnztIPR4rQk6PZMBRIX/45JZfAZ5vPbWt9sXG+0m5CPUx3ztwoVJTRmLndZTeSfKNkdtU9xQ8j2a306/a1q4QqR/adWJwYE/KOUMVkYOtEdDYAlfs4krnEikToT3Cmcyx1aV7z5FrZymzVw4+lus7HUIlMB9e09yR0YSw0YUCAhxG1SRyycqU5CqrBTxGLAEe2b0Zgnt8fmdY/EFJwl7/yig6C338yfQI1DfDGQzc+TRG5W4aQPro1esXvkdKdk2ocBvCigipTN41OnRwVcbi+yskJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ+WiQH5hPy0RwxLw8a6UaLMPwhA3xfEacPQXt0Fyi8=;
 b=GFHBwmnEFmCCmOgFjIOYhAIZL6LFOBH12mGystyG6SUfQGZP3r1VsUgEq+TsVU/qmRmShL7iKRvSSRk4NxCzSCKiUCFF5cGpRePTTB50fLyUcO+cgYNFY9TagdtFERH+hjttBCf1TZe4UqtKi+LP3VReigCoQtJTJ8U32E43xf4=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by BN7PPF683A477A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 16 Mar
 2026 06:55:08 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 06:55:08 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Fix NULL deref in
 ras_core_get_utc_second_timestamp()
Thread-Topic: [PATCH] drm/amd/ras: Fix NULL deref in
 ras_core_get_utc_second_timestamp()
Thread-Index: AQHctESjSupRsfPQRkqC04CgmDFwLbWwuxPA
Date: Mon, 16 Mar 2026 06:55:08 +0000
Message-ID: <BN9PR12MB5306F3B12220607922F1FDAFFC40A@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260315062559.1931470-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260315062559.1931470-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-16T06:54:59.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|BN7PPF683A477A9:EE_
x-ms-office365-filtering-correlation-id: d8db1954-3da5-460b-db47-08de8328f637
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|7053199007|38070700021;
x-microsoft-antispam-message-info: P6fTFLlPpa/LlIyDNCGwlaD6l/IpWgS8+XeYPPczfge5KlrNxk8tGUYHN87hnqDMgvzEPF6/Xi527/oW7bgCHhGGjL7Etqi6LNuTVIbEX41QomTWC4naE4bCToP7CFVFMJ8NBtjRczX6fpUFz4AdgPidRWMMyAVZiWU+EE2cyVK1OvAd9t7XzBp1l5aOY7oCHDEfmF8z1K/UoFhCVBiNkuwuVnlqAuuyD8Wgw5Li3OJy1M0CvzAYHQUtWtwzPqH4VVWO41i8ire59LCFI1pmbbKJRWT6knOsnnN/glRCwEudDyODvymN+B3dnT1LP7DoIkcOnQK1Xz9z0m6/tMzodt5l2NjZuGK5ZSwnCV1YIpyHumV8fusEhj+4mqDP1cFf7yCRWB7befR4HdnPzmIuoxSZXXe+PRJLuLbDodwctni4nILA69ry969jQyHhaIddvzWGJyOd1nxbO0U4kxEHkBrM0xOy+enjH6fvinAz/yuwWy4Ay9uPCljUvwGk+9K5b5zbziXdBGAsP3VgHJ6xNCHSra4OGZMRxXjkIRf8XsLJsgSu8VF19jUe9LxKE9D5OcBMfCQaNPSva+6lBYp2/BObbxcUGoWx+55PuyyBnm8Dv4XYM+c1iZT6PFqANR+Zi2JwRP+hgG/XWJm6PaRKmLcOgw//y9CQXA+as6ETQF8q/dP3LfdmNHCTtDYzpM9dkS6EQZU+Lg/d6CnC4707G4+D1xufrsouRk3RB1cxfES9o2hCVF/d4SzViwVscb2Ww4qPSJ3nfK4DPT6MA70PeFQhZc2syp4PeOmP+6rwPDg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1BZWTBYWFpsWHFBZ0ZZK3FMVFRBL1Nxc3o1a2F4KzFXTVEzYy9OSnBYT1lH?=
 =?utf-8?B?Q0tNeG5mNWtCYmZ0VjhIK1NsZVM5ZWZyeG1pNER6UkZHN3VJUEVIL0JHY0tT?=
 =?utf-8?B?NXZJVU9haklTMGNxbDhvNDNyRFdKbUcxa2paYlJyeWFvRm55S2FQSVRiaklF?=
 =?utf-8?B?VzZCanJiS09XMVJwQWRPQUlwK01YdlliZmpkdXJnK1QwN050c2tldFU1ZjZ1?=
 =?utf-8?B?RHY1V1M2aWJyNlU5K01UMVRETXBkVTFyUlJUQ0ZZYXNrek1qMmlVQmxNcWJX?=
 =?utf-8?B?T0lNaUVNdnE2Q0thZXgvSW9idTd1aGlJOHJTUDdMbWRpemRDQjh6V2tjbzdT?=
 =?utf-8?B?NWw0Z1o1dVhMYVd6dVo1cnk1ejViMXBrbW1FRHRYc3ZDMzlGa0ZHamZ3a3dy?=
 =?utf-8?B?TzlzSzdFWHdnZTB3c3pVT2V6S0p4cE9iQWRPLzVzeUg2VCtXK3QrOTRFNGxO?=
 =?utf-8?B?b25YMWZiTjcxZHUwQUM0MTk5N2EyOTMvaHBzdWt5UGtkY29oeVJwUys3cWdN?=
 =?utf-8?B?dE0yNGRJVklOVS9EajNGQkZ0VXNzMzNRMFVKTDJpSEN3ajd2dVgxQ0dyakNI?=
 =?utf-8?B?MzFUZ2ZtZmZVb3hIL0IyUzg0SXNwMEdDaDlrSlZsNW43TEVFcnVtNDAzV3ox?=
 =?utf-8?B?RWxuQTNnVGZmdmR2dmM0S0FPQ29MV1AzZU5WNUh1ZXE5aDdtOFg4RjdjUEZr?=
 =?utf-8?B?V09QUHNGUTIrSlJ3cU9tbHRuVmhzYlUzaVkxdFVlcnFBNzJlNFo4cW9OcWF3?=
 =?utf-8?B?czlkYlpxaDB3KzAvb1RJY0VoUERsa1RPQ2JsMjl3MTY4SWozNVkreHppRDZT?=
 =?utf-8?B?NlpPS2lJbHYxWEZTUVgxVVp2UHFhNG1tSXd1T056Z0M0ejZtK1dOUkRRdmF4?=
 =?utf-8?B?WTgzVjhwS2VSWnlIVFhhNjRSR3FkbnJyZVhQRjFudFFFK1FRaFgxd2NvQWdt?=
 =?utf-8?B?dFgwMlAydlhwcUxQSzQ2TXkzZmtUdEx4R1Vza2srMzNPM25ndEovUEswMWJq?=
 =?utf-8?B?V0JHbUg1S0RjNnNwM0YwYnlaR1pONjQ0ZGZsLzNlakNSOTlHdXg0dG1UOWFH?=
 =?utf-8?B?ZGxWU1ZyT0w5aGVCbGl3UHl2T2N0QS8wYW52L1RMck1BbTFFOEpsS3lNNGxS?=
 =?utf-8?B?azV6dFhKSjdxNVpGRUN6SjFqdnljTlZYU3hLWU5XRS93TXFDRkVEMDR1QldW?=
 =?utf-8?B?cDVzQmg4RW1IRkNWR3NUYzFFMW1jdHp1djBnTEFycnZWOVFNYS9EQ1pKeXla?=
 =?utf-8?B?RVB6bWcvREp0aGJ1SGpLRWY0a3UxQTlteS9hSERzTkZpdlRpSnJYSU5MaW9L?=
 =?utf-8?B?Tjd0cGxxQ0FkQ2pHYmVIOG1YdzYzQlNUR1p4ZmVqZUcveUVRclN6c3RKTlJx?=
 =?utf-8?B?R0ZRN3NsVzgweUdGY0Z6NnpMbmc2Q251WHlSaDBLK2plak1GcnBrZjd4dUpH?=
 =?utf-8?B?Ujk2VlhFN2RVVEdLc3VlblNTVUJ2Q0ViQ3A5U3RnR0pqQkEwcWJNUFkxQUwr?=
 =?utf-8?B?OXc3MmgxT08zQk1rblBKM3VjeFFPNWZBUkkvMnliUkJ5VHQ2ZU9MMHRlMnQr?=
 =?utf-8?B?U2ZYb05uUENQbzhUT0cwc2ppS1lBbmpkWmVBTjFZN1NaQWJvcllaR3d1Undp?=
 =?utf-8?B?WERuaWFGYnpYOFVmdlg4KzR6NW1pR1BrSTZLMGJMQ2Q1anZ0WmlRM3p5SWtl?=
 =?utf-8?B?N1BTaTEwNGRVNEQwTW10c2s5c0NTVDdSS3dkRCtRUHpRbmkwOGRXckZBcHU4?=
 =?utf-8?B?VGNNSGljc1hvc0cyWjIzV2hZU1ZjdWZNY2ErekFmY1E1MmtHNVVDZlg2dGdz?=
 =?utf-8?B?UDdBWHh1UW41cWlLVWtKUHJWSU5RZjFyaEpMMStnL3JwVHRyMWRyOUdHVUhV?=
 =?utf-8?B?K2FlbFVoSEdBaFJZYVVRR1pOb09adjVvY002cUZZenlyWFNvUVYzUTZnUGFM?=
 =?utf-8?B?WmpuMVVXSytkK1NvanRhVHJ1QjNFRWdzR1BDQkcxU3JEWUg3eTgyeWpXanFk?=
 =?utf-8?B?blFBMm1jc0hTekpTekx4MzlZYnk2RyswMlhnbXBuSU91M3BxTnhMNzcxYnhT?=
 =?utf-8?B?M3Y4elF3K3pucHBjZFZDekQyTWRRWEloc1lIWGhnWFgrcktrWCs5SkVTN1Rq?=
 =?utf-8?B?SEtzUGZOOWhVK2J3SWNhdFgvVHFWTThWRnduR0xoZ0R4UGgwbDExN3dRQkJa?=
 =?utf-8?B?UE9XMU5Xclpyb1BEOFFFY2Uyc3FoOGNJblZQVDJweC9UL3V5bFFONVhDd3Zt?=
 =?utf-8?B?YTRJS3J0OWJuTUJIM1J1RGJFaWdhQkNIcEMwSjcwSnloTFRGdUY0QWhja3Nn?=
 =?utf-8?Q?XhxCxFjnj+K3BPRcBj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8db1954-3da5-460b-db47-08de8328f637
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 06:55:08.5549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDWoOzUqoqUxOZl2crRI3YRefw+5qzdk8xvsN2vYH5qxloklr2Fk4xEH7yuOxn6Makj5tA5Y8OH3hK5pZ9r1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IFlpUGVuZyBDaGFpIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KDQpCZXN0
IFJlZ2FyZHMsDQpUaG9tYXMNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBT
dW5kYXksIE1hcmNoIDE1LCAyMDI2IDI6MjYgUE0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBDaGFpLCBUaG9t
YXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+OyBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxp
bmFyby5vcmc+OyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcmFzOiBG
aXggTlVMTCBkZXJlZiBpbiByYXNfY29yZV9nZXRfdXRjX3NlY29uZF90aW1lc3RhbXAoKQ0KDQpy
YXNfY29yZV9nZXRfdXRjX3NlY29uZF90aW1lc3RhbXAoKSByZXRyaWV2ZXMgdGhlIGN1cnJlbnQg
VVRDIHRpbWVzdGFtcCAoaW4gc2Vjb25kcyBzaW5jZSB0aGUgVW5peCBlcG9jaCkgdGhyb3VnaCBh
IHBsYXRmb3JtLXNwZWNpZmljIFJBUyBzeXN0ZW0gY2FsbGJhY2sgYW5kIGlzIHVzZWQgZm9yIHRp
bWVzdGFtcGluZyBSQVMgZXJyb3IgZXZlbnRzLg0KDQpUaGUgZnVuY3Rpb24gY2hlY2tzIHJhc19j
b3JlIGluIHRoZSBjb25kaXRpb25hbCBzdGF0ZW1lbnQgYmVmb3JlIGNhbGxpbmcgdGhlIHN5c19m
biBjYWxsYmFjay4gSG93ZXZlciwgd2hlbiB0aGUgY29uZGl0aW9uIGZhaWxzLCB0aGUgZnVuY3Rp
b24gcHJpbnRzIGFuIGVycm9yIG1lc3NhZ2UgdXNpbmcgcmFzX2NvcmUtPmRldi4NCg0KSWYgcmFz
X2NvcmUgaXMgTlVMTCwgdGhpcyBjYW4gbGVhZCB0byBhIHBvdGVudGlhbCBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2Ugd2hlbiBhY2Nlc3NpbmcgcmFzX2NvcmUtPmRldi4NCg0KQWRkIGFuIGVhcmx5
IE5VTEwgY2hlY2sgZm9yIHJhc19jb3JlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGZ1bmN0aW9u
IGFuZCByZXR1cm4gMCB3aGVuIHRoZSBwb2ludGVyIGlzIG5vdCB2YWxpZC4gVGhpcyBwcmV2ZW50
cyB0aGUgZGVyZWZlcmVuY2UgYW5kIG1ha2VzIHRoZSBjb250cm9sIGZsb3cgY2xlYXJlci4NCg0K
Rml4ZXM6IDEzYzkxYjViNDM3OCAoImRybS9hbWQvcmFzOiBBZGQgcmFzY29yZSB1bmlmaWVkIGlu
dGVyZmFjZSBmdW5jdGlvbiIpDQpDYzogWWlQZW5nIENoYWkgPFlpUGVuZy5DaGFpQGFtZC5jb20+
DQpDYzogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KQ2M6IFRhbyBa
aG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pg0KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29t
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfY29yZS5jIHwgMyAr
KysNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc19jb3JlLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Jhcy9yYXNjb3JlL3Jhc19jb3JlLmMNCmluZGV4IDEwY2QzOThkNGFlMi4uODQ0NzIwZTRh
Mjc1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfY29y
ZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc19jb3JlLmMNCkBA
IC01MjcsNiArNTI3LDkgQEAgYm9vbCByYXNfY29yZV9pc19lbmFibGVkKHN0cnVjdCByYXNfY29y
ZV9jb250ZXh0ICpyYXNfY29yZSkNCg0KIHVpbnQ2NF90IHJhc19jb3JlX2dldF91dGNfc2Vjb25k
X3RpbWVzdGFtcChzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUpICB7DQorICAgICAg
IGlmICghcmFzX2NvcmUpDQorICAgICAgICAgICAgICAgcmV0dXJuIDA7DQorDQogICAgICAgIGlm
IChyYXNfY29yZSAmJiByYXNfY29yZS0+c3lzX2ZuICYmDQogICAgICAgICAgICAgICAgcmFzX2Nv
cmUtPnN5c19mbi0+Z2V0X3V0Y19zZWNvbmRfdGltZXN0YW1wKQ0KICAgICAgICAgICAgICAgIHJl
dHVybiByYXNfY29yZS0+c3lzX2ZuLT5nZXRfdXRjX3NlY29uZF90aW1lc3RhbXAocmFzX2NvcmUp
Ow0KLS0NCjIuMzQuMQ0KDQo=
