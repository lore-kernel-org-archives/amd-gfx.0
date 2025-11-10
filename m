Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4A9CCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 05:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A8610E079;
	Mon, 10 Nov 2025 05:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oIcb8muO";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013004.outbound.protection.outlook.com
 [40.107.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F9410E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 05:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miEU7XrdQ5ATjT/x8tKmEm44oz80dI4Zqxhatot+3qLMj7BLgpt4KVjfMg/5PWHf4P3afo/pYfAgQBmkSQ8QiFAynUGnvvP1mG26jInZI1oCf6jQJqLJbeTZ0fzPO6MKogguiwX6OUwQ989FS+B6uwSL+wpiG6l7Er0v7JyCk0fty2UdkSMp+O7GlRu9KFwCMkt0wqew08zCM3mLfPll9GXFoKLhagDjuQ8CwVSEiF2J6vLjEkAN18kdBPTWFVEUbvAXDt8PwnasbcbY3N06DQgxrGxS9Yrob3Z4+w6gyTRMsOe7a+m5oNzAlQfcQUfNIStCAmXBrNt05Ao8DWu27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn3T810vLopE9E+8dbPx5a2CnpZ2E6hJT+12R6H5Sy0=;
 b=ACC+OUyouUZfZCbGlciyyZQx9KLSo/cnSROZ74ICIUWdzvFzXkCqLqZlXcxjG2sPapuQGO/ptupet9CZUjRF4vxwU7xVeDl4Vi6H1NIqGtg5MnuifBLFv2ePKmt9UQFqVYc05udjZuEK/iw6V12QTNmVg3/33thUWfCtmxk4z/tmS6B+BG22JDLYmUXL7o5Lx6E5d/xfTSvWTq4DH9v+pLlK/uLoFrUPKqNF5/p7pQaeONQcwe0UEgQJyBwKrMVBKzgTmLlRzP10VFhkicC9piRgDpGrUWX1qhF89P2R77bkmKK6HrxHgWX4CoXmcnjsWY1roodJSt6y+Ek/ZL1TAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn3T810vLopE9E+8dbPx5a2CnpZ2E6hJT+12R6H5Sy0=;
 b=oIcb8muOHEDb2hNm6XcNSxoosdzzsXbiLCBZgi9TCDxt/QdAoEVOQSTN5V11FubdtonowX5jVEF3fFLphJYSdgbKsiEVulI8d7/WKWWQDItmbYqewKCr9RUjIi/2yC88DXryhmdGRMi3pb2cNB2qpqvlzYMc0geaOqRu0gH141s=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 05:37:56 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 05:37:55 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: resume MES scheduling after user queue hang
 detection and recovery
Thread-Topic: [PATCH] drm/amdgpu: resume MES scheduling after user queue hang
 detection and recovery
Thread-Index: AQHcT9l180eAKQXH906kOj5/2zK1ybTnQAGAgAPorwCAAD964A==
Date: Mon, 10 Nov 2025 05:37:55 +0000
Message-ID: <DM4PR12MB5152AD32901F715486DD54FCE3CEA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251107112704.4080134-1-Jesse.Zhang@amd.com>
 <CADnq5_MtwYtWN-63DAyeRHnLNKG=4qH5PMXdqfBAtXeoe7aFVw@mail.gmail.com>
 <DS7PR12MB60051224A2E188939C4F100EFBCEA@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60051224A2E188939C4F100EFBCEA@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-10T01:44:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH3PR12MB9395:EE_
x-ms-office365-filtering-correlation-id: 74701abe-d5fd-4e7d-9ce2-08de201b4cca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UDBLbDVGUk45WUFIRHZXcjdBK2hTV2xwd3RPV3MreXhEYmY0ZHYzNXEvc2JV?=
 =?utf-8?B?ZWdUemEybzMrSUlKM29aaVFiREpCOUprcFF4b1VYanBJd09sYlFwZnQ0MHJu?=
 =?utf-8?B?NEdjdEZXYTl3Q2FCck5IYzE5UlRjOTA5ZnJCL1hJZDJBT2RUUjczLzJlN1ZE?=
 =?utf-8?B?aEFiU2lTNTllUDdLaldURWRDanpLamQ0VmVaWUVQc09kbVgvd1dLdHg4WEtZ?=
 =?utf-8?B?ZFVXaDZGWVhZYWxkNlA4L3FJZmErbTZ6czZ3V2MvQktZYU96WGNVV3M4cFRx?=
 =?utf-8?B?cDVlc0VscVN0MlIvckxESFEyWVI1WFREa3U2d0lsNlNpUlZwKzFYQTd1cXJa?=
 =?utf-8?B?aTRQdkQ0eVl3RWRzM2g1ZXNBaW1QQWNOWjhFS3lXVE1rb1RxVERtRTdoTXNQ?=
 =?utf-8?B?NjdWY0R3ckk3bHdPYVgzWjRWbENQdmpsT1BGZFIwdkhoSm9ZbnF4MDVyWnUz?=
 =?utf-8?B?b0JPMjQ5OHdTMU01YU0rVkZPQUg4VUY5N3YwckRWVUcvWlVPYkdpWWFtZ0hv?=
 =?utf-8?B?enk4RVlVZDFkaE9Rb3N4VjN3UzBldlZlMEppcHNWUnFoVEdvQ1IzbFdLMzV6?=
 =?utf-8?B?LzJxYXNsWURqMFlMY2k2VWpkY00zUkNSWmlrbEpDV3U3MVpCMVBJRldZQXlO?=
 =?utf-8?B?cCtYOUF5Z3dBUEd6dzBPWTZzdkk3bzAxdFNucDFLQ016UnI1NCtwRldRaHVP?=
 =?utf-8?B?TnNyNWRHZWIxRE02NS9keVRFZmZPbDVyM0RpbitLNy9BRndLdnRyVEdYS1Vs?=
 =?utf-8?B?Z0dVbG1XN0x2bW5kU1A0MmEweDd4ZmYzdzdiMnNzM05TdEdtMDYza21oVGJ4?=
 =?utf-8?B?NDY2Q0sxaXRsdzgrQ0Nmc1htT2ZqbVp4N0lLbkxobjJNek84bCs5Ym1oZllW?=
 =?utf-8?B?QlcwSkhXaGx5aGJlaSthWlRTSGdhb29va00zeUhyUytHalFIaThPTkxYQndn?=
 =?utf-8?B?dEJDbU5lNGlXbnhqeERhTEl4VzBzWVlZUFFnVXFtZFlIYmtzdzAwVGJJV2Ja?=
 =?utf-8?B?dndqZ2xEQzRYNHkrUjRqejM5SmQ3cmg3TjJ4YUc4QXhzcHpqRTJ5ZG1QMVhz?=
 =?utf-8?B?Z01PeXBydlNXTDBBWFZ0K0V6MkZ4Mlg4ZG9aT3N4VEhuK28rRXBJdk9Pb1NV?=
 =?utf-8?B?SHBJQ2RSMTM3WkJtRkdGWGdGR2lTc1VXcUZPdEF1MGs3MFF6aUJONmU2RU43?=
 =?utf-8?B?OHdOVlNxVzRRcHFScnZHd2M0aHZJb0x2SDlhZUloZ1I3SktpSkpmZlhIVlY4?=
 =?utf-8?B?d05ZRXpHdlFpTHYrY0xHVmdlNnhBSU1OTnBPQ1poYllzQ2xCOFphKy85Sm5F?=
 =?utf-8?B?SVcreUQvVDcvUEs3eHJmbWpnTWQvdk9qc1hHYzhmVXk5RlpGd1grM2E5M2xm?=
 =?utf-8?B?YVh3d3NuNWFxRGVqaFFrc1dKbk91SVVhT0pKRjZkUjJTOHg2bDYxUytaZk1S?=
 =?utf-8?B?dlh5cGhvL01pN2tXWGdvOGlIT3FzT3FwVThTLzlmQ2FjVk5ZbW8vMXJXbURC?=
 =?utf-8?B?SnR2WTFNdy8waFBPa1BsM2lvbnowc3VraHU0dFkrUG1uMjNnYVhnR3pmcTZR?=
 =?utf-8?B?eDN2dXYxbzVmZGdvemxhcjV2RFpzcCtHRU9pRHZjQ2lMaWxkRHY2Qy9wbjV6?=
 =?utf-8?B?WVpkUUgydFh1YWhxWnowb0FZcTFwSEtxNE1NTVBkRWZUN0lMNjFRUUl5ekxT?=
 =?utf-8?B?K1lHcUJEVUFBeUNHckUxb3FXK212OVVCaEkxVTYvcDdLbEhtdU9OMk1Pbm1V?=
 =?utf-8?B?OTdQRXR2N0lWZEdDdlFYVW9IZHFLUXRweUIxTGQycGw4bU9hblRSY3lZRmFV?=
 =?utf-8?B?MGhCQzNCc2JzMmV2aWViRnBYRWtTTDc3VVpFSFhybmUySjR6S3hGT2hHeDB5?=
 =?utf-8?B?dzJDVEtZdnphdlhjNXJmT3dyUW1GM1lrSzl3UjM3MEh3TWIxY1NXVXVtVnhi?=
 =?utf-8?B?NEx1dWdXQ3NiS0p6WXN2WVoyb0FTMWJUK3kzUlo1WXcxQzJIUWJ0dXBnYzJN?=
 =?utf-8?B?b2ZkZ1NBWmVic2tneTRKTEpaZ2VnM3E3eWN0RGdDVWFMQ3VBNHlqZE5vWmhY?=
 =?utf-8?Q?/QtpJw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWZlb2hnMEh1eENmaWRrN3RPTy92MDM0ak5jdkc5bXhwNWtQeEZZbmNXTGd5?=
 =?utf-8?B?bmxEc0J3aGpBODdrNCtRRUEyWTJYVkNudGxkdVFUNnRoYnlJakwvenUrb1Ar?=
 =?utf-8?B?cTV4UFZkUnhFQ2dUL1dnLzhZaTlCQnAxL3ZielhDbjRSRThoLzlxN253Ty9a?=
 =?utf-8?B?QTRRdUMxVCsxRkdTdEYxeGpPZGN3R3hGT0U1WTFoeVBwYmwranRET2RFMjdP?=
 =?utf-8?B?UGZDeG8xRlEraUVNTnhsVlN0bjJBV0dJd09VMFIyQUNGR3BiTWlQbWYxbFhJ?=
 =?utf-8?B?QVJyMVFaSVZnMnhOVnA5VmlUV1h1K2c2V2tGYXpzVnA5OTcvaUlMV0dwTUty?=
 =?utf-8?B?T2krWDN0bUhIV1ZUY2ozQkFkUld0WjBoQlprRGJVQmVyNEUxWEdVK2VGejVi?=
 =?utf-8?B?SFFwVkR5cTVnb2JwUDF6ZURZQXA0cUlFRnhkVkMxaG1OL1VlREttbTE5eEVS?=
 =?utf-8?B?Y3J4Wmt1eGZ1aWZPUC9qKzRYQXFMaUhoMzJDMHd1cG9mOHQ5UzZCK0pZT0c5?=
 =?utf-8?B?SzVkamZXUUJieTJ3NEk2c1hDQlhnQjVKcVZpY2g0RVl5a2V4WWF4ZHlkMTlN?=
 =?utf-8?B?Y3ZJVXZrTEN1b3NBZlFPSFZJVDBhYnZSdFRFK040RzNheFlnZFY0cHFUTGw2?=
 =?utf-8?B?RExUMzFNdGhTWVU1aThlZ2VDcW5RZHRQSEU5VU9RcUdDejhsR21vR2hVaVV1?=
 =?utf-8?B?TmN4ZEMyMFp5Y0FFbTdXMHdFZzh3NnhDRUFuY0FRTUczWWtDdC8rQWVja2N0?=
 =?utf-8?B?ZjFaYXpKaHZ6YnhHRW9iTVUveFV6UVRYVzV4c2Vjdis3T1JYN3hURDM0R0Y1?=
 =?utf-8?B?bEowR25tY0RHbnR2L2RHN3NlNU1sYmxTUkp1NFNvQU1VMEtoYkhuNjJhYmM3?=
 =?utf-8?B?a2ZHaW1oWnp4L3VaQnZBZWJISDZEVkxmYnFKWStTeEZMTUhZS3NyQmJqSSt4?=
 =?utf-8?B?bmlDdC9WTHViRnh5czJVekkrYXFlR1V3Q3lMSVhSeFBJWWhqMi9Hbk81ekFE?=
 =?utf-8?B?ZCt1ajZ5NUg3TVQ2UlYwMTVKbVhlL1lFSEErbUs0VktCaHhoeEtENTkwQ21v?=
 =?utf-8?B?OWYvWkpvODdYVHByRlF1azVuUXlRN3dRdmFJTGxvYTZYNStkeUZuSjV6SnVZ?=
 =?utf-8?B?UWtFMEd5a3BWeVE3c1FibXJMekZUYjRva1RIcEQrbytaRXkvK25ic1NGaW4z?=
 =?utf-8?B?ckYwd2ZIYy96RVBqb2ZLRzRQY2c2OTZKd29Lak1WZUhUU1QwRlV5SjJ4aHBI?=
 =?utf-8?B?cjcrSkNpTWduVzAzNW1QRER1cy8xdEh2UEFQZDBLWVVJVDhQc3NFL2dtSURm?=
 =?utf-8?B?UFk4WUJoMnUyZmZaMi9CT3ZMeGRpdjNyOUQrdHV2Rk9pVXVGaGVqeWc2dEhm?=
 =?utf-8?B?ZzVld2thTWQ2azJydTlSNzlyWUJFTzlYajVObVQ0NGdsUk1JQzNHbEdhTE5H?=
 =?utf-8?B?TVlOZ0pkcUQvSFRRYW51TUw3STBhOEpCM0VqU215YVgwaVZzS0NWRVR1QVU5?=
 =?utf-8?B?RkhGckE2Tk1ZbG03UnVxZzZZYWZtM0Zab1ZqWk0wZkZuRzBmRzVucmkwWnMr?=
 =?utf-8?B?WjlRVTF1WlRSODEvSjM4UStzaEdPejFVeFNob0tFOWNhY2cyME1pOWhmVzdp?=
 =?utf-8?B?RnloMXhkMzFsS243REk2ZERVU2xNa2VNMzVvY2w2c2preVk2UUsyQkFCOEI3?=
 =?utf-8?B?VHhsUENQS3h4OGJScktHNmlJT3Q2WEhvT3NJYVhzcDdIRzJvWWx4dFRVQitS?=
 =?utf-8?B?VHZZTU5WcVhGckZTek5ZdG5iZDVERHdIR1hSdlpFRldrUy9OdzB6ZTE5RkJW?=
 =?utf-8?B?T2hOUDkrK3gwWlRGdWFubXhHMlVTVDRnN3VOM3c2Zit4VFM2WmVGTkhqbXRp?=
 =?utf-8?B?emUwaWxsZkFSODlKWlNreTRQZ0R4b2UzK0lNVlE5b1lMLzdNWUphaExKREIy?=
 =?utf-8?B?ZjRLYWZVRnZQd0IwY2tSWE5BK2tzSzhGVFBoZVhzV0RlNDhIQWhXdnlQb0wz?=
 =?utf-8?B?RDN1dTZocHIyWnRhU2xwaDdSVUR0U3lpeTN6SG9EK3ZtWEEvcGpGUnlvRTA4?=
 =?utf-8?B?TG1MQnRXenN3dnNPZC9icGdpc0ZmSDBzcnJUbVVoK1B3N2x3SkZkMDVnamZZ?=
 =?utf-8?Q?548o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74701abe-d5fd-4e7d-9ce2-08de201b4cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 05:37:55.7275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frx/u7KQeEsQ9aBXrPGZfLLqrCgxDB7JyjmaaudA2DwOqRbtg+CL/JFtKOq87k35KgjwbhlLgHYtBeQzftp5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaWFuZywg
UHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTAs
IDIwMjUgOTo0OSBBTQ0KPiBUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
OyBaaGFuZywgSmVzc2UoSmllKQ0KPiA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiByZXN1bWUgTUVTIHNj
aGVkdWxpbmcgYWZ0ZXIgdXNlciBxdWV1ZSBoYW5nDQo+IGRldGVjdGlvbiBhbmQgcmVjb3ZlcnkN
Cj4NCj4gW1B1YmxpY10NCj4NCj4gT0ssIHNvIHRoYXQgbG9va3MgdGhlIHF1ZXVlIGlzIG5vdCB0
aGUgZnVuY3Rpb25hbCBzdGF0dXMgYXMgSSBwb2ludGVkIG91dCBpbiB0aGUgbGFzdA0KPiBtZWV0
aW5nLg0KPiBXZSBtaWdodCB0byBjaGVjayB0aGUgcXVldWUgd2hldGhlciBpcyByZW1hcHBlZCBv
ciBhY3RpdmUgYmVmb3JlIHBlcmZvcm1pbmcgdGhlDQo+IHF1ZXVlIHJlc3VtZS4NCltaaGFuZywg
SmVzc2UoSmllKV0gIFRoZSBNRVMgZmlybXdhcmUgd2lsbCBjaGVjayB0aGUgcmVnaXN0ZXJzIHJl
Z0NQX0dGWF9IUURfQUNUSVZFL3JlZ0NQX0hRRF9BQ1RJVkVfQUNUSVZFIGFmdGVyIGEgcmVzZXQu
DQoNClRoYW5rcw0KSmVzc2UNCj4NCj4NCj4gUmVnYXJkcywNCj4gICAgICAgUHJpa2UNCj4NCj4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiA+IEFsZXggRGV1
Y2hlcg0KPiA+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgNywgMjAyNSAxMDowNyBQTQ0KPiA+IFRv
OiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gPiBDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA+IDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHJlc3Vt
ZSBNRVMgc2NoZWR1bGluZyBhZnRlciB1c2VyDQo+ID4gcXVldWUgaGFuZyBkZXRlY3Rpb24gYW5k
IHJlY292ZXJ5DQo+ID4NCj4gPiBPbiBGcmksIE5vdiA3LCAyMDI1IGF0IDY6MjfigK9BTSBKZXNz
ZS5aaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gVGhpcyBw
YXRjaCBlbnN1cmVzIHRoZSBNRVMgaXMgcHJvcGVybHkgcmVzdW1lZCBhZnRlciBkZXRlY3Rpbmcg
YW5kDQo+ID4gPiByZWNvdmVyaW5nIGZyb20gYSB1c2VyIHF1ZXVlIGhhbmcgY29uZGl0aW9uLg0K
PiA+ID4NCj4gPiA+IEtleSBjaGFuZ2VzOg0KPiA+ID4gMS4gVHJhY2sgd2hlbiBhIGh1bmcgdXNl
ciBxdWV1ZSBpcyBkZXRlY3RlZCB1c2luZyBmb3VuZF9odW5nX3F1ZXVlDQo+ID4gPiBmbGFnIDIu
IENhbGwgYW1kZ3B1X21lc19yZXN1bWUoKSB0byByZXN0YXJ0IE1FUyBzY2hlZHVsaW5nIGFmdGVy
IGNvbXBsZXRpbmcNCj4gPiA+ICAgIHRoZSBoYW5nIHJlY292ZXJ5IHByb2Nlc3MNCj4gPiA+IDMu
IFRoaXMgY29tcGxlbWVudHMgdGhlIGV4aXN0aW5nIHJlY292ZXJ5IHN0ZXBzIChmZW5jZSBmb3Jj
ZSBjb21wbGV0aW9uDQo+ID4gPiAgICBhbmQgZGV2aWNlIHdlZGdpbmcpIGJ5IGVuc3VyaW5nIHRo
ZSBzY2hlZHVsZXIgY2FuIHByb2Nlc3MgbmV3DQo+ID4gPiB3b3JrDQo+ID4gPg0KPiA+ID4gV2l0
aG91dCB0aGlzIHJlc3VtZSBjYWxsLCB0aGUgTUVTIHNjaGVkdWxlciBtYXkgcmVtYWluIGluIGEg
cGF1c2VkDQo+ID4gPiBzdGF0ZSBldmVuIGFmdGVyIHRoZSBodW5nIHF1ZXVlIGhhcyBiZWVuIGhh
bmRsZWQsIHByZXZlbnRpbmcgbmV3bHkNCj4gPiA+IHN1Ym1pdHRlZCB3b3JrIGZyb20gYmVpbmcg
cHJvY2Vzc2VkIGFuZCBsZWFkaW5nIHRvIHN5c3RlbSBzdGFsbHMuDQo+ID4gPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+ID4NCj4gPiBB
Y2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+DQo+
ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVl
LmMgfCA3ICsrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191
c2VycXVldWUuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1
ZXVlLmMNCj4gPiA+IGluZGV4IGIxZWU5NDczZDYyOC4uNmQxYWY3MjkxNmE1IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+ID4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPiA+
IEBAIC0yMDgsNiArMjA4LDcgQEAgc3RhdGljIGludCBtZXNfdXNlcnFfZGV0ZWN0X2FuZF9yZXNl
dChzdHJ1Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+ID4gICAgICAgICB1bnNpZ25l
ZCBpbnQgaHVuZ19kYl9udW0gPSAwOw0KPiA+ID4gICAgICAgICB1bnNpZ25lZCBsb25nIHF1ZXVl
X2lkOw0KPiA+ID4gICAgICAgICB1MzIgZGJfYXJyYXlbOF07DQo+ID4gPiArICAgICAgIGJvb2wg
Zm91bmRfaHVuZ19xdWV1ZSA9ZmFsc2U7DQo+ID4gPiAgICAgICAgIGludCByLCBpOw0KPiA+ID4N
Cj4gPiA+ICAgICAgICAgaWYgKGRiX2FycmF5X3NpemUgPiA4KSB7DQo+ID4gPiBAQCAtMjMyLDYg
KzIzMyw3IEBAIHN0YXRpYyBpbnQgbWVzX3VzZXJxX2RldGVjdF9hbmRfcmVzZXQoc3RydWN0DQo+
ID4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZm9yIChpID0gMDsgaSA8IGh1bmdfZGJfbnVtOyBpKyspIHsNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocXVldWUtPmRvb3JiZWxsX2luZGV4
ID09IGRiX2FycmF5W2ldKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBxdWV1ZS0+c3RhdGUgPQ0KPiA+ID4gQU1ER1BVX1VTRVJRX1NUQVRF
X0hVTkc7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBmb3VuZF9odW5nX3F1ZXVlID0NCj4gPiA+ICsgdHJ1ZTsNCj4gPiA+DQo+ID4gPiBhdG9t
aWNfaW5jKCZhZGV2LT5ncHVfcmVzZXRfY291bnRlcik7DQo+ID4gPg0KPiA+IGFtZGdwdV91c2Vy
cV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihxdWV1ZSk7DQo+ID4gPg0KPiA+ID4gZHJt
X2Rldl93ZWRnZWRfZXZlbnQoYWRldl90b19kcm0oYWRldiksDQo+ID4gRFJNX1dFREdFX1JFQ09W
RVJZX05PTkUsIE5VTEwpOyBAQCAtMjQxLDYgKzI0MywxMSBAQCBzdGF0aWMgaW50DQo+ID4gbWVz
X3VzZXJxX2RldGVjdF9hbmRfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4g
PiAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gICAgICAgICB9DQo+ID4gPg0KPiA+ID4gKyAgICAg
ICBpZiAoZm91bmRfaHVuZ19xdWV1ZSkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIC8qIFJlc3Vt
ZSBzY2hlZHVsaW5nIGFmdGVyIGhhbmcgcmVjb3ZlcnkgKi8NCj4gPiA+ICsgICAgICAgICAgICAg
ICByID0gYW1kZ3B1X21lc19yZXN1bWUoYWRldik7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+ICsN
Cj4gPiA+ICAgICAgICAgcmV0dXJuIHI7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IC0tDQo+ID4g
PiAyLjQ5LjANCj4gPiA+DQoNCg==
