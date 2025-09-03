Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB71BCA1012
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 20:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6127B10E21A;
	Wed,  3 Sep 2025 20:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gs8Xg3dq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B54E10E21A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 20:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSNF3Q3xHkcltasuorTv7MD0P9UcAPpcF26kTd1AnoPH7TfMqgGej7aksvHfAGYm2REegX6oqOSWLfTnNm8+Ps2Oay34hc/zh/VwQ2PM4VRKlHgYqA0vquYQQrsWqYEJ6J20VpbOSi30ApzX3gzuw+oYWOMlL3CuH0Fq8SXl3Rr+TCIc0HteNIC27Xa3d0+SkzB/h3MJNsnxOkvkERESgbKBFKDYWdtd6w6D/sLg9oS+dqrVK8vapwcf813M/MaQbfNmeu/7S0hXxYXOv7l2Z/lnWuMk4ySOcY75tiDMKXxBp142/+R/WXaDPP2A4PwoFSUUlW1NZMi9a8Xl0dnp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+IgAKToyPVr/NmEUguiNQYCx2rs//Sb1DG4DHNvqr4=;
 b=Zk17EYxbYS1RTdD7csAiW8tIW3ftaSGgP3ZxlFD1U9vh/cHXMDb3u57sw4YEizf+H0cu8djpTXEUW2ntovwr8cgCfiEeKZ9XtOMDcwwpvgfdA00k6k8uWQ8xhhNelCe+gVd6pl/f2oY3v8Sq++pXmGkdvAqhY9YuCiIfcDk4yr8h7s1DkW7dVH8Y0BD6KNfocEUcUor3mnExFSKm2tLwfuJhlnWaW/C5S8eDA90e9enbirjeLuIVdR+hbiAck6JxI2bIiLICVASIt3WQ0hKXSWaLjMQbwWJRd/QmkHgiaFnF/AUDFmc7KiCgSO4dWmRYUhzxqwnjyOkb8wpRGO0SCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+IgAKToyPVr/NmEUguiNQYCx2rs//Sb1DG4DHNvqr4=;
 b=gs8Xg3dqs1YyiFC78Ju3alNWERL600PlJzNpxihvVuWqoy9PMsZsn0pXFvHqW67pDl7abiJgE9ojA4JoxkLlYZ8QevkHuya3ckjFxCAr5Jp7u4+Um60o9UTEK3dtWkMw8LKqXWscgWlxz6wv+T8YJ2/+/TTCvvOBVKz6Do45vlg=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 20:39:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:39:41 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>, "Du, Bin"
 <Bin.Du@amd.com>, "Rosikopulos, Gjorgji" <Gjorgji.Rosikopulos@amd.com>, "Li,
 King" <King.Li@amd.com>, "Antony, Dominic" <Dominic.Antony@amd.com>, "Jawich, 
 Phil" <Phil.Jawich@amd.com>, "xglooom@gmail.com" <xglooom@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into
 isp_v4_1_x modules
Thread-Topic: [PATCH v2 1/2] drm/amd/amdgpu: Move isp firmware load into
 isp_v4_1_x modules
Thread-Index: AQHcHRJzTlmUBeP7vUSRYTpLa4KRfLSB65gA
Date: Wed, 3 Sep 2025 20:39:41 +0000
Message-ID: <2a0c1e16-8594-439f-95a2-763ca5e92ac4@amd.com>
References: <20250903203601.839525-1-pratap.nirujogi@amd.com>
 <20250903203601.839525-2-pratap.nirujogi@amd.com>
In-Reply-To: <20250903203601.839525-2-pratap.nirujogi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|LV3PR12MB9215:EE_
x-ms-office365-filtering-correlation-id: 7d1f59b7-296b-4ef7-9334-08ddeb2a0212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFpHRGdSV2tiV2J2N3QrWWt2S3NBTTIvWWpwSmdDeEJKdFd2ME0xb1p2UzV3?=
 =?utf-8?B?YVhLYmIwMW15TXUxQW02UEVqVjl4cWQvWkNZd1poWEFjNjhVa2EzbXVCUmVW?=
 =?utf-8?B?dVNFc1ZyVk1zYUJqYTlGSHFXYzlhVDQvdTd3UW5naUIwZlNFNEVUbTlNeU40?=
 =?utf-8?B?YXlYb3pOazFMUWFHcit3MWg0WmJRU1F3amswTjNvbE50SVdOZWI5K1I3cHE1?=
 =?utf-8?B?YnVONE9CcW50eUFCOVQ4UExJUWhIUStVbUh5WEE1anV5L25NRUNnUi9hdGV5?=
 =?utf-8?B?Mk9URzA4eFQ2eitja2pQTEczUGhyVUJPMlJYVm02NGxJVXlYNXRJaW9ac2Rj?=
 =?utf-8?B?dzJLOXN6dmhkaVZVRHdZa096Z1YwWlVOaHJXOUhBdkl6dzJCSFVkYXNXUXZZ?=
 =?utf-8?B?ZmJiNG16YVRHZzNQY1VuYlVaVDJUbEFzU251Q1BVVFhIYVJuSjdEdENSMHp5?=
 =?utf-8?B?RXQ3emVndUsrTzc2aDI5YVdscXFsZVJ6N1RmMVNDNmx6TSs4UnBOSStSUHFW?=
 =?utf-8?B?YTV5ajFLelA1cVBkRjJESHNldDlkY2J2MDU5NG9PRm96RVg0cTZCbWVFYW5F?=
 =?utf-8?B?bVkvTG4xQ3lJTENmTkdzaUk5RGNWRkJ5dndtM1RncG8rc3RRaEFhQkdHMTRH?=
 =?utf-8?B?T0oxR0VZYlVIbDd1RU8wcSs2Nk5uM2RNZ2dEUTJndWFOK0hlUVlWYml0QjVY?=
 =?utf-8?B?WUJ4akRtVVBYL3ZOYXlDR3VFQ0sxMTl6bHVsa29HS0dlTWg2ODJCNVNoNXhm?=
 =?utf-8?B?dU5DUW53SWRyN2JOQnRXaFZvMzBnS015WkJZVDBsV2wwWEd2SHZIYk9ULyti?=
 =?utf-8?B?bXpRS2I0WDBMSTR6VHRvNkFKNGtUL3FreUxmYVFjaUttL1QzWUR0a1JleFQ2?=
 =?utf-8?B?ckg2TCt5UVhuM0VMV2tDVkNJT2pyd0lTNkdybGJmWCtXeVhocFhCTWZNdlVW?=
 =?utf-8?B?SXorWlBMRmE2eVN4OGdmRDhlNDQrcGt4QzN1Vjl6WHRORXloWno3eXJtVEEx?=
 =?utf-8?B?elR3eHVEYkFMdXRxaDZIQnFLWjFXaDhaUEJsRnhZMm9iaS81eUl5S2JoK2RB?=
 =?utf-8?B?c2dURXZHbE1QNWplNndOb2ROWEhWanVYWFVYdmRoUWlFd1Mrb01UalFQTHl2?=
 =?utf-8?B?WXlUYU1VWFgyNUlWTU0yUFUzWDd5cUFwZG5nTHFQQjZldDF5RElQd3B6VWx2?=
 =?utf-8?B?b2x4Rk85eUw2NVJSaHgxYmdweUtQRkVOb01nRmFNeXNrZkxpVDFDMC9sVjRK?=
 =?utf-8?B?b0dvN1pJOEhuOEpMeGpXSnczUHlROGlOUWpRVi9SYWpZNDMwQks2TXpvTWJB?=
 =?utf-8?B?ZnpFMFM3SGJDQktMelNKVVF5MGVDbjNLdi9oOG1PMUowU3ZFMFUvQzFUc3VU?=
 =?utf-8?B?QlQ4V1JsekptRktYUDRrNzZyOEZrcGc4K3RSb1B1bjJhUi94Z3B5NUdJZmVF?=
 =?utf-8?B?akRYQlhtRDB1NHBqUDZEOHludDJNQjlGSUEwcHdQN0F6dkhVTzN0eEVZSGtM?=
 =?utf-8?B?eVJ2VHJsMjY4anJURjJDTjZvbk1pM1I3Umo1TS9BWTRMVjJOa2dvVENVWUpF?=
 =?utf-8?B?WTI3b2lLLzBGOFNiQzIzdnNkYmhCcERDYTJRMmhmSzFkTFh4TUZHR2lKNW9J?=
 =?utf-8?B?RVVEV0VxMmY3MWlXZHRhckJSZzBBYmNWSk1KVlB2bnVvbG1WYUhlV240WmdO?=
 =?utf-8?B?MUtMSUpuMCtCYlRmNXNkcEZOc3QvQUdyMEpjWjdNekZtM244dVEraU15WEk2?=
 =?utf-8?B?OVNJQlE1WUJjb3c5NzdoazNST1hhallIVEh1czNDM3RmOG5qYXQyQVU5NUYy?=
 =?utf-8?B?RGZwZGtnSE1FSEFUcm1oY2drL3hqZlJURkQyT3F3QjdaZWJ6V3ZST21wdGh2?=
 =?utf-8?B?NFJPOFlTQnRVUDhZMnVGTTFzcWNaTVdNZmp5eUlVQU5KTXVpcWlBR01zK3d4?=
 =?utf-8?B?ZDlqam42UjFnc0pxaktJclNGTkJISXNBZTVzdzNVOWFwNXZhbG1BcGh2WjJU?=
 =?utf-8?Q?e10W8QZ1GKb2iCrVMVtXI2PvPF2upk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmpxN2NXL3RKOE1sQTkvS2lpV0VCY1o5SDNJZkMwdUxGSHRxUDhaaXJNdFBw?=
 =?utf-8?B?S3h3WkIzekczMERwWExWM2lvdS9URVNsR2NNWUNZaDJidXplMFFxamVTRDdp?=
 =?utf-8?B?MGo2ZjhGclRhMnVETjdMbEtHY3lzeFoxekhPVXN6cUJKZTlEQ202S2RocXBF?=
 =?utf-8?B?dVJ4K1Y5VWticXlJT1RmTE8yN3JjUUprbTNSbUhJUCt6L1dBakpvV1VHNGor?=
 =?utf-8?B?T3VlY0ZKdzluendiTUZQT2xYb01EYmlray9NWWtteXdSNE1JTGk1THNLcUZm?=
 =?utf-8?B?OS9nTTRxV1JibUE4WHFOdXN6alB0VzNoUXQzVkh0OTFnTWMrWTZ3eE9kUjNJ?=
 =?utf-8?B?bk9WNWl5eExOa21OdzdYVTZ5V3RLbnR4aUpFdDJUSUQvSHYyQnJEWnJCZnRK?=
 =?utf-8?B?UElWblgycEd6VnlWN0U0b0pycHZPemplV2dTMnp2YzZXbXM5SGtTOE1QQ2k1?=
 =?utf-8?B?aDZLd1h6YWxjR2JCR0xFTGtDV0lndFBNMWlFSVZ0cHMvaUlCL21IQUk4NWRD?=
 =?utf-8?B?MzFEMEwxU1UybzI5WDhZSFpsTEZpaGdxbFQ2QmZvOGMwUVRIcmlISjluaGZT?=
 =?utf-8?B?TTByT1orcFIzNHVFSGxJN1dIMnVCbFQrbmVHd0FvREZXY3JGcDdQVFlPUWly?=
 =?utf-8?B?b2k1TXhhdmlMZHFic255ZWFBdXJYbHpoeUFxejBzKzVqTHh4MkNDcmNDcW5s?=
 =?utf-8?B?clJDOTdGRllMcnZURldQc095bWRSOGpxRm5PNmpKWFBnR1NJQVc5eC84ZEpK?=
 =?utf-8?B?MEpiMU9HWFdJTG1wWEExOEN6MnRhcjdVS2lBZ0FvZzczUjFDME9WZnlJbDdZ?=
 =?utf-8?B?OU03eDZmdTM4QnZ5aEs5dG9nRVBtWTNoY3dMVEd1dlY2dnN6QjRVQnlGNW51?=
 =?utf-8?B?dXpoK2FPeXBqenZlZ0MzT09YdlY0aWZsRXVFWTA5dFNUUHk1cCttSmRjZ3Yy?=
 =?utf-8?B?dG5HeDVrcGRvdTZjS2NRU094MW1xUnlEdWMrY0RiUTdEVUh4empOcVZHNFhQ?=
 =?utf-8?B?bExzOWtXK0JSSktlalVjKzVrZlNtd1VtZmthZVFHcWxlaWlOdnJQdmpzaEJ2?=
 =?utf-8?B?Wld6NXZsRmxUVkZMYnFlNFdJNDJidncxS2pFK3laU3ZuRm40ZUlpTXUvaHhC?=
 =?utf-8?B?TEZidDBVd3pnMEgra0VwdlNWTzBEYkxOdk41aEdGOUt0NlpBOVFlMzU1QzZy?=
 =?utf-8?B?aHc1TWNKRXRJU3ZTaWpxWktwRk5zQ1kyeHZkSzh2b0pRdWZVVHN5UzVZeTBF?=
 =?utf-8?B?aDVIVmhoTmFvMnlnT1FadTIwa3hnTFBKU2xCSzlPVld4cWdnUCtodXUybUlH?=
 =?utf-8?B?RnFsV3FGV3ZsMXpuQmZ0ajRGS3cyWGpkcnVrNWdpNGhpcWdzcVh0enhNMVda?=
 =?utf-8?B?OVJ5MSthTWxublJyc2lwRHN6NlAyNjRNMU5uV0gxT2N3VWNwb0NPcUp6Q1Bt?=
 =?utf-8?B?Vy8zOTRLK3NYTXZ5NkFLOHlwV3A3TmFvTUhkTzJaZkhDY2pLZHNyWEN2eFpY?=
 =?utf-8?B?Nkp0dFNNeGpXaDNHSU55ZHdhcndEYXZ2L2tHYXFhSzNNNTh2dWovYlhvZC8r?=
 =?utf-8?B?cFU3d01QcFFhWm9MK1pKNE83cW1sVk9nNk0zcWgrR1R0UzhaSG5Edi9CREN2?=
 =?utf-8?B?ZzB5T0ZnWm5VcUlDam1WN2NLTW9rU1N2RndaMW9MTVlIRjM0Z0w2elFHZmhF?=
 =?utf-8?B?WEZZUEFoRlpKUUxWM1NrdTZsMTcvZlhWRDNqV2Jmc3BDMy8yc3pNN0xGbTlj?=
 =?utf-8?B?MTk4L0NzV3dBL0pHZDRBUTVGdFR3a1dVMkFCOXlGMC90WnQ1dEhsMkd2Qlpy?=
 =?utf-8?B?WithRGtZa28vRUFoRzUySUd4K3RjelFqdHpHMkw4UVVXUkR5YlZHYUpCL1hW?=
 =?utf-8?B?OHovaVZqcnUyRk1KYXRaSHZGaFhhNE13UzR6S1hrK0hWdmc1ckRWKzFGcGxj?=
 =?utf-8?B?UEhwM3k5Y2dESldmendkTzMxQ3AvZHlWMUMrZnJIMEo5MEFaOWU1WTNUc2xz?=
 =?utf-8?B?THZtWEFJSjN3K0hRQlhRUDJzT0hQbUVZTE9YemJRRjF4czVOZ2xtRGpFNUVz?=
 =?utf-8?B?V0Y3ZG5yOVZCdXBsRWxkNCtGSTg5UGZLNnd1N1NRNVVWRGtyWVVqNUtKR2p5?=
 =?utf-8?Q?c1NM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E67B6FC8CFFBD41B09478E9D3CF521B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1f59b7-296b-4ef7-9334-08ddeb2a0212
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 20:39:41.1799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwz70X7w9gLNeAMRllomrvpnA8ylcDu1wa3IUAL9X3MdJX8fmNQRJijgpxSnrUiouKuQNefjzLg+J6GFlPbkag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
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

T24gOS8zLzI1IDM6MzUgUE0sIE5pcnVqb2dpLCBQcmF0YXAgd3JvdGU6DQo+IE1vdmUgaXNwIGZp
cm13YXJlIGxvYWQgZnJvbSBnZW5lcmljIGFtZGdwdV9pc3AgZHJpdmVyIHRvIGlzcA0KPiB2ZXJz
aW9uIHNwZWNpZmljIGRyaXZlciBtb2R1bGVzIGlzcF92NF8xXzAgYW5kIGlzcF92NF8xXzEuDQoN
CkkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgd2h5IHRvIGRvIHRoaXMgY2hhbmdlLiAgSXNuJ3Qg
aXQganVzdCBtb3JlIA0KY29kZSBkdXBsaWNhdGlvbiB3aXRoIHRoaXMgcGF0Y2g/DQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFByYXRhcCBOaXJ1am9naSA8cHJhdGFwLm5pcnVqb2dpQGFtZC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuYyB8IDIy
ICsrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaXNwLmggfCAgMiArKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92
NF8xXzAuYyB8IDEyICsrKysrKysrKysrLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2lzcF92NF8xXzAuaCB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNw
X3Y0XzFfMS5jIHwgMTIgKysrKysrKysrKystDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvaXNwX3Y0XzFfMS5oIHwgIDIgKy0NCj4gICA2IGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlv
bnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9pc3AuYw0KPiBpbmRleCA5Y2RkYmY1MDQ0MmEuLjkwYWYzNWVlOGY2ZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lzcC5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuYw0KPiBAQCAtNjgsNyArNjgsNyBA
QCBzdGF0aWMgaW50IGlzcF9od19maW5pKHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2Nr
KQ0KPiAgIAlyZXR1cm4gLUVOT0RFVjsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW50IGlzcF9s
b2FkX2Z3X2J5X3BzcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gK2ludCBpc3BfbG9h
ZF9md19ieV9wc3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgew0KPiAgIAljb25z
dCBzdHJ1Y3QgY29tbW9uX2Zpcm13YXJlX2hlYWRlciAqaGRyOw0KPiAgIAljaGFyIHVjb2RlX3By
ZWZpeFsxMF07DQo+IEBAIC04MCw3ICs4MCw3IEBAIHN0YXRpYyBpbnQgaXNwX2xvYWRfZndfYnlf
cHNwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIA0KPiAgIAkvKiByZWFkIGlzcCBm
dyAqLw0KPiAgIAlyID0gYW1kZ3B1X3Vjb2RlX3JlcXVlc3QoYWRldiwgJmFkZXYtPmlzcC5mdywg
QU1ER1BVX1VDT0RFX09QVElPTkFMLA0KPiAtCQkJCSJhbWRncHUvJXMuYmluIiwgdWNvZGVfcHJl
Zml4KTsNCj4gKwkJCQkgImFtZGdwdS8lcy5iaW4iLCB1Y29kZV9wcmVmaXgpOw0KPiAgIAlpZiAo
cikgew0KPiAgIAkJYW1kZ3B1X3Vjb2RlX3JlbGVhc2UoJmFkZXYtPmlzcC5mdyk7DQo+ICAgCQly
ZXR1cm4gcjsNCj4gQEAgLTEwMywyNyArMTAzLDIzIEBAIHN0YXRpYyBpbnQgaXNwX2Vhcmx5X2lu
aXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+ICAgDQo+ICAgCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gaXBfYmxvY2stPmFkZXY7DQo+ICAgCXN0cnVjdCBhbWRncHVf
aXNwICppc3AgPSAmYWRldi0+aXNwOw0KPiArCWludCByOw0KPiArDQo+ICsJaXNwLT5hZGV2ID0g
YWRldjsNCj4gKwlpc3AtPnBhcmVudCA9IGFkZXYtPmRldjsNCj4gICANCj4gICAJc3dpdGNoIChh
bWRncHVfaXBfdmVyc2lvbihhZGV2LCBJU1BfSFdJUCwgMCkpIHsNCj4gICAJY2FzZSBJUF9WRVJT
SU9OKDQsIDEsIDApOg0KPiAtCQlpc3BfdjRfMV8wX3NldF9pc3BfZnVuY3MoaXNwKTsNCj4gKwkJ
ciA9IGlzcF92NF8xXzBfc2V0X2lzcF9mdW5jcyhpc3ApOw0KPiAgIAkJYnJlYWs7DQo+ICAgCWNh
c2UgSVBfVkVSU0lPTig0LCAxLCAxKToNCj4gLQkJaXNwX3Y0XzFfMV9zZXRfaXNwX2Z1bmNzKGlz
cCk7DQo+ICsJCXIgPSBpc3BfdjRfMV8xX3NldF9pc3BfZnVuY3MoaXNwKTsNCj4gICAJCWJyZWFr
Ow0KPiAgIAlkZWZhdWx0Og0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCX0NCj4gICANCj4g
LQlpc3AtPmFkZXYgPSBhZGV2Ow0KPiAtCWlzcC0+cGFyZW50ID0gYWRldi0+ZGV2Ow0KPiAtDQo+
IC0JaWYgKGlzcF9sb2FkX2Z3X2J5X3BzcChhZGV2KSkgew0KPiAtCQlEUk1fREVCVUdfRFJJVkVS
KCIlczogaXNwIGZ3IGxvYWQgZmFpbGVkXG4iLCBfX2Z1bmNfXyk7DQo+IC0JCXJldHVybiAtRU5P
RU5UOw0KPiAtCX0NCj4gLQ0KPiAtCXJldHVybiAwOw0KPiArCXJldHVybiByOw0KPiAgIH0NCj4g
ICANCj4gICBzdGF0aWMgYm9vbCBpc3BfaXNfaWRsZShzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICpp
cF9ibG9jaykNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9pc3AuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuaA0KPiBpbmRl
eCBkNmY0ZmZhNGM5N2MuLjM2NzUwMTIzZWQ0NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lzcC5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pc3AuaA0KPiBAQCAtNTcsNCArNTcsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2lz
cCB7DQo+ICAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBpc3Bf
djRfMV8wX2lwX2Jsb2NrOw0KPiAgIGV4dGVybiBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2Nr
X3ZlcnNpb24gaXNwX3Y0XzFfMV9pcF9ibG9jazsNCj4gICANCj4gK2ludCBpc3BfbG9hZF9md19i
eV9wc3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOw0KPiArDQo+ICAgI2VuZGlmIC8qIF9f
QU1ER1BVX0lTUF9IX18gKi8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2lzcF92NF8xXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzAu
Yw0KPiBpbmRleCAwMDI3YTYzOWM3ZTYuLjkyNjk0N2E2MTJhNCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzAuYw0KPiBAQCAtMTg1LDcgKzE4NSwxNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGlzcF9mdW5jcyBpc3BfdjRfMV8wX2Z1bmNzID0gew0KPiAgIAkuaHdf
ZmluaSA9IGlzcF92NF8xXzBfaHdfZmluaSwNCj4gICB9Ow0KPiAgIA0KPiAtdm9pZCBpc3BfdjRf
MV8wX3NldF9pc3BfZnVuY3Moc3RydWN0IGFtZGdwdV9pc3AgKmlzcCkNCj4gK2ludCBpc3BfdjRf
MV8wX3NldF9pc3BfZnVuY3Moc3RydWN0IGFtZGdwdV9pc3AgKmlzcCkNCj4gICB7DQo+ICsJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpc3AtPmFkZXY7DQo+ICsNCj4gICAJaXNwLT5mdW5j
cyA9ICZpc3BfdjRfMV8wX2Z1bmNzOw0KPiArDQo+ICsJLyogbG9hZCBpc3AgZmlybXdhcmUgKi8N
Cj4gKwlpZiAoaXNwX2xvYWRfZndfYnlfcHNwKGFkZXYpKSB7DQo+ICsJCWRybV9lcnIoJmFkZXYt
PmRkZXYsICJpc3AgZncgbG9hZCBmYWlsZWRcbiIpOw0KPiArCQlyZXR1cm4gLUVOT0VOVDsNCj4g
Kwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8wLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9pc3BfdjRfMV8wLmgNCj4gaW5kZXggNGQyMzkxOThlZGQwLi41ZTQzYmEwNjQ3MDggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzAuaA0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8wLmgNCj4gQEAgLTQ1LDYgKzQ1
LDYgQEANCj4gICAjZGVmaW5lIElTUDQxMF9HUElPX1NFTlNPUl9PRkZTRVQgMHg2NjEzQw0KPiAg
ICNkZWZpbmUgSVNQNDEwX0dQSU9fU0VOU09SX1NJWkUgMHg1NA0KPiAgIA0KPiAtdm9pZCBpc3Bf
djRfMV8wX3NldF9pc3BfZnVuY3Moc3RydWN0IGFtZGdwdV9pc3AgKmlzcCk7DQo+ICtpbnQgaXNw
X3Y0XzFfMF9zZXRfaXNwX2Z1bmNzKHN0cnVjdCBhbWRncHVfaXNwICppc3ApOw0KPiAgIA0KPiAg
ICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0
XzFfMS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMS5jDQo+IGluZGV4
IGE4ODdkZjUyMDQxNC4uOTc2NmM2MDU2ZGM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvaXNwX3Y0XzFfMS5jDQo+IEBAIC0zNjksNyArMzY5LDE3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgaXNwX2Z1bmNzIGlzcF92NF8xXzFfZnVuY3MgPSB7DQo+ICAgCS5od19maW5pID0gaXNw
X3Y0XzFfMV9od19maW5pLA0KPiAgIH07DQo+ICAgDQo+IC12b2lkIGlzcF92NF8xXzFfc2V0X2lz
cF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwKQ0KPiAraW50IGlzcF92NF8xXzFfc2V0X2lz
cF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwKQ0KPiAgIHsNCj4gKwlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGlzcC0+YWRldjsNCj4gKw0KPiAgIAlpc3AtPmZ1bmNzID0gJmlzcF92
NF8xXzFfZnVuY3M7DQo+ICsNCj4gKwkvKiBsb2FkIGlzcCBmaXJtd2FyZSAqLw0KPiArCWlmIChp
c3BfbG9hZF9md19ieV9wc3AoYWRldikpIHsNCj4gKwkJZHJtX2VycigmYWRldi0+ZGRldiwgImlz
cCBmdyBsb2FkIGZhaWxlZFxuIik7DQo+ICsJCXJldHVybiAtRU5PRU5UOw0KPiArCX0NCj4gKw0K
PiArCXJldHVybiAwOw0KPiAgIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2lzcF92NF8xXzEuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8x
XzEuaA0KPiBpbmRleCBmZTQ1ZDcwZDg3ZjEuLmIyMjFkOGI4MTk4MyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMS5oDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzEuaA0KPiBAQCAtNDQsNiArNDQsNiBAQA0KPiAg
ICNkZWZpbmUgSVNQNDExX0dQSU9fU0VOU09SX09GRlNFVCAweDY2MTNDDQo+ICAgI2RlZmluZSBJ
U1A0MTFfR1BJT19TRU5TT1JfU0laRSAweDU0DQo+ICAgDQo+IC12b2lkIGlzcF92NF8xXzFfc2V0
X2lzcF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwKTsNCj4gK2ludCBpc3BfdjRfMV8xX3Nl
dF9pc3BfZnVuY3Moc3RydWN0IGFtZGdwdV9pc3AgKmlzcCk7DQo+ICAgDQo+ICAgI2VuZGlmDQoN
Cg==
