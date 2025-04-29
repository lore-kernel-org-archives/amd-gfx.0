Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25842C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C2E410E03A;
	Tue, 29 Apr 2025 19:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mbgaGRNJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8637810E03A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtVlZ5oaV90jB1VXaBYkU1Uzoanq4pQAAcoFBxeV/wQXlLeXiTQojm02uDkUMTYt7NWxEo96tHcq9XdqxYz9yaunKZ4vjxgFXnkNc+CMAaaYRQzfKwdiuc41TyWiAZ29Cp00/1h9oDlRcBcDbQX8D6f9NuG/ICyiYgAqByBa2s8jezMxNOy4kkiform6XzX3xtUpFgY/bJPG8CWlzV+hATtfurZ38ozhym6rVKl+WaESxLKJA/h6ikiPMD60leJ8hh8hbFmear8GvF1FHbsBTz1IAUfnJsXjyc2mp8iy+p4G0SGgB3RrM5x3QvcQGesHe+W1dngAWjFvsrBoExrIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39ejQznXhrCbl+je+EYDrqkVm3cW6Xdfl8+sb99fhD8=;
 b=sX63Bp40iCuhuBOCYdW6MTZZKnTD//pDmoGHbL4Vdm9whxiKuhl0AtXVLKclR48m46ksHNOtsQILFHAEsAxGSaDdeHWZiR677Xsu9wLltZ5saQnoqte/RfnL46Pon9q52XtozuWoG4lgdgzGK2BYg/A+6ChPCBBvx0I9fqNUIoGQ06q033f1h1WsNnHZdPTA43H6ypUk8Rqrc76kT+EKstZWCWS6UaK8FER82hYnqGjtQ/lC+IM0ZBxPycoezIQSlvPLiPdb0LLG7o3Zia0bYuP3Hagb7c/gA/rHC2QtBXa33LCZe3ltTgRTfyOBMcm3cXgD3Nx4qkfxY3wf/kGRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39ejQznXhrCbl+je+EYDrqkVm3cW6Xdfl8+sb99fhD8=;
 b=mbgaGRNJKHOAWvUoUPNX35JUlnqLJR3voi8SW1h4Uk07kmjD9Tcpwr0LZ+QgHVqdWnDxC08reu0pKHWYyKEWPQZhESkz+SON0lDhOIgxQeQ+ogBQiVnQgdDxmoYK6IQxrhcbtjojZGNDZ/N3e8VUIgv3uapWoIIQfKD0c8XK5Fk=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.28; Tue, 29 Apr 2025 19:16:11 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 19:16:11 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Chen, Michael" <Michael.Chen@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Thread-Topic: [PATCH 5/8] drm/amdgpu/mes12: add support for setting gang submit
Thread-Index: AQHbuIN/8vHW9/64KkWJ6JoSL6ig1rO682WAgAAHZwCAAAQigIAAA0cAgAABv3A=
Date: Tue, 29 Apr 2025 19:16:11 +0000
Message-ID: <CH0PR12MB5372FD59F67537B0496A9A19F4802@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
 <20250428212050.1098434-5-alexander.deucher@amd.com>
 <SJ1PR12MB626846D071EF8DD342E4900294802@SJ1PR12MB6268.namprd12.prod.outlook.com>
 <CADnq5_P+kCk0vDm4W5K4QUF8_AR9iBRL2+-EgDJJTQVduMiLSw@mail.gmail.com>
 <CH0PR12MB53724E7D012C8D79AB497A5AF4802@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_P+Nv+SUZO+f14-Yp+D=kybtGyuKT2tA1teijDdiqbOOw@mail.gmail.com>
In-Reply-To: <CADnq5_P+Nv+SUZO+f14-Yp+D=kybtGyuKT2tA1teijDdiqbOOw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d6c1c801-1dc7-4aa2-8eae-17a5170885bd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T19:11:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS7PR12MB6118:EE_
x-ms-office365-filtering-correlation-id: 1a1f71eb-e16b-425d-f9dc-08dd87524d60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1ozbUF3RVg3dzRycjJWVldCTW4xcFN2S2NHS1BQU2FONnNKNWMwZWd1TTJz?=
 =?utf-8?B?cWpkb3ZIc29YbmZOQU1qaDhFK0Rub2VBTlQ2eGd4TllkY05heXJjVElHT09M?=
 =?utf-8?B?UXdvQ2F3NjlueGhma2J4QlF4eHJZWWdQVytjaXdKUktnZnlnSFgvN3hqazBW?=
 =?utf-8?B?ZnVPamx4cVNrNjlGY3d2OHdrd0E4NHJmbGMzMVo5aUhHRXZkTmhwL1Q1TWhq?=
 =?utf-8?B?dEQ5Y3RmektRUlAwYmF1N29TRXhNKytaV0tuTlkyMDVKQ2RhYXFEaHhDYlJ2?=
 =?utf-8?B?VEZPZ2V6bld0RWlSRmJkbWV1WDgzckxXSFU2N1ZGaVBTMzB3VkVRMVByYjRH?=
 =?utf-8?B?b2lLTnBwYmpVdGhaeGd1SDlOL2xNVUwvNXQ3TGhmWkZmUFprVW4yaGlmQXNV?=
 =?utf-8?B?cjNwL3VKNW1KdVptbjJBaWgyUk9taStiendxeUNDSjZzZGVLRHFuazF1MHlD?=
 =?utf-8?B?QzdSTHArS0FUeXRQRFArYU9aTml2VmN1ajZVN0UxNzhhVVh3bHNDVXVpSTFh?=
 =?utf-8?B?b3JFQ200cHZvM1o4VVd5RCswdXIzVEcrWUhzTnlxOTdCWmdKRStIKzdJb3Ix?=
 =?utf-8?B?aC9Ib0dIT2VZdFNzOStFRTVmMnpjdVVGekJFRHVBcGp3Z2dteGttendSUjRS?=
 =?utf-8?B?enB3UGVSYkR1aUlwWk5XcE5GR1hLVVcvQkIySzN0M09rd0htbUZvaWVRVDNx?=
 =?utf-8?B?THY2ZzdpU1dmdjhmR28xVlpiOVIzOHFFVlR4RWJVWENOQy95RldNRVJaV25q?=
 =?utf-8?B?bkdQdFpBeURBZ0F0MEJmcXJzNzNnSGtvdSsvWVN5alRkeFZkZkFQMHZTT09l?=
 =?utf-8?B?WmJ0b3VsTzk1WjFqK1cvQkwyOTBvZWdPSEVzSWFGeGdQb0V5TFpmRHp0V3ZG?=
 =?utf-8?B?czY5U1BpVUNqQWRrTWJhUDNLR0JRRjJjZVZZZGVjYVU4UWhxK0RMQ3VpcnFq?=
 =?utf-8?B?K3VOY3dFNGZTTjU5S1h2MUV6d2ZhZWk4ZzEvc1JwajZGdXd4M21TQnJpVW03?=
 =?utf-8?B?SmY1R0p6c1V0czhMVldGQ0tuOEJrRnVlS1J6K2MrQnN0dDZieVNvZWR2Z0Zl?=
 =?utf-8?B?S0Jsb0k0VUNaTlI5bWh4UzZSUzVLcVFmS3YyR3cyeGpiVEZVZHYwM0hXNDFn?=
 =?utf-8?B?QkMwcGJxSFdxdWdNTmFXOGF4cFJtVVhQT0QwOTh4MEJJUjEvWEhXRW9VZmVN?=
 =?utf-8?B?MUcxTzNOaCtQSVBVRjF2Zk5jTnRzR0tSK3JvaGJqSzRoTWd4MUk3SVRGbjVQ?=
 =?utf-8?B?Qk1lMzJ2VkQyWDJIZlpWcHhsVU9IdHlzQWl1R2x2MC9sanJhNlAyT2hWdnpV?=
 =?utf-8?B?NkczQlliWU1yMkZLZjgxTmsyZGRhbWZqNGtUN2VuMTZUVlQyYTZQZnF2UDhX?=
 =?utf-8?B?dmxaeUZyZ212bEFRTVRuU0QzUHVoSDFWWGZPaXoxejB3M1lnNzBSOGdBVnc3?=
 =?utf-8?B?MW9vV1VjSU1DakhLa3F4Wm0yREQ3TVhGUWcxdnFYcTFSL3ZSTW9SQWxUSzFG?=
 =?utf-8?B?L1ByM0lYcjU3Wnh1dWVUK2NKa2pnYzhiM3RXWGE1b1h5by9SbThsSHlqWnZo?=
 =?utf-8?B?QWRmK1kwZmRrdS9vMGhNVnYvWjVLNFVuU2c0QVVOR1JyL0k5bVBmQlk4ZGhV?=
 =?utf-8?B?M3EvMGs1UkFHNlg2WXhNYllCZHBCVVZQQU96KzlvdmdlSjN1WkMvU25yWitO?=
 =?utf-8?B?MzR3SWMwRFNtYTFjOXl3bE9JcEc3ZXZzVEV4U3dhSFFnSkJjd0ZHcllzMFdw?=
 =?utf-8?B?WUp1OHBFNXdsYTFGL29SUXdidFAwMkJIUWRPTWwvOUZIYVJSVC9Kc1ozS1Js?=
 =?utf-8?B?dTlVb0RQMnllM2hPNGR4RVlFZUNJWUZUdlFnZVFGQkZoQnd4QUxuQ0RBUldK?=
 =?utf-8?B?M0IxdEg4NlQvczAxdUVMSW44RDRvblpOUlM5TTFIUkVqaFlLTHpLZTk1Q2M0?=
 =?utf-8?B?MDlZa095TGV0WlQ2OG1lV0pjWGhXQnVabVdlelYzTHJ5ZmJEOE5hRTFwUUho?=
 =?utf-8?Q?3DCJP+Pj87+sj6j1LeUmfZEC+X6LHY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG5uOGZIODJMZWorYkM2QmtWVTNJM3JpT0ZuSWUwcjIwd3B2VCtUNG1KZnN2?=
 =?utf-8?B?am1QRlpLQlZMU3BYLzBydG1jRFJxRWdBa3FwTkRER0c2bDNiNUh4eHJaVjZQ?=
 =?utf-8?B?UjNYVk85aGYyU1FOaFlyckd0Z1ZBRkR2UjIxd3M1N1Q2MTVkZ3loaE42VHBw?=
 =?utf-8?B?WDQwWG9SSnpIVTBjTXYxVVZBRFg5aU85VG51WUxGVVZQSzFJWFcycUJPcDRi?=
 =?utf-8?B?Y3h0VFRNTDZzUjhucnV4RUdDN0ZsOC9tT2w0eUpJWEV2ajNWdUpDVUpTK1Z6?=
 =?utf-8?B?Yi92M1hqRkYrYmxqTmQ4d0ZZeWxGb3REeThTY2tPTEVteVhiUDJQRWtMdGxp?=
 =?utf-8?B?M2J5WDBwUmtYcHVJV2VQcjFaWlovdFJhdFZjeE1FY1lnOTZVdnpwT3B4cFpH?=
 =?utf-8?B?aTZUdFR6bFFCY2o0dVBXbG5GRXBMWUJ1UzV4bEpMY2szWVlUT0x2VUUxUndS?=
 =?utf-8?B?RDlNSnFpa0NTbUFObzNBRzJYQTBtT0xMUFhBWHJQdzRCelZTNDJzY3k2VEt1?=
 =?utf-8?B?VStUcnFiV0NEeU5tb3ZCbzMxbHE2Si9yUHpQS24zMFduY2VMZU42QStJemdY?=
 =?utf-8?B?eXZGSStOeTJZem9MK0JYWnJ2UUFtYml3SzhlWS9tQmNsTnZRS0ZVQTN1cW92?=
 =?utf-8?B?WTM1eWJTRGZuamo5dUhMeG5UQ0EwVzBIVVdBOVpvSWpQeWR4RDE4OEo4cjhW?=
 =?utf-8?B?dzlFa1YySkRoTkRTT0RWZHlYOHI2ZWV3OFhqejd4UmwvSG5ZWmxFR1hiZmNY?=
 =?utf-8?B?K0sxRGpiL2pqaVVvdzFJMXd3WmZnTUd6ODVIRDZHOHZxNTdaYjg0MC90Z0JS?=
 =?utf-8?B?VXhYSUVheXJ0SEFrN2NPZzlCQlZnajhZYU9LZ2lHUHdMVHFVbGp0VFJ3MnFm?=
 =?utf-8?B?ZGt2akJJbi81cndWNmNtbUxvOW1NWEdEd0t4Y253SytHVjArZkgvK3ViTjZQ?=
 =?utf-8?B?YllpdTdZeWs0cjFPc2hYZHd4UlpYK2RjWXlTWU1obUlXQ3dRRlZXV3BWQTNN?=
 =?utf-8?B?cDRtR2hrVUxFaU1IWTdqWGJrSSt4ZEdaeWNzYU1FcnN2V2l1UE9IMGVZWkR6?=
 =?utf-8?B?NVFmZFlQZkROT0tZWCt3dnNQK1ZFc3pHNW0yTGgvZTIvbEh0c2lPZm0xeDdE?=
 =?utf-8?B?YmF6MThBZkx4SmpnSlpSMU40YUk2elBUVjZ5amF6VHNQWXNRakdTeUJwOG1m?=
 =?utf-8?B?QTRFTUtaNjlLRHlJMDc1Q3pCTUlhU00vVWFTNnNjRkxMV3RGdExRR2NPR0pl?=
 =?utf-8?B?VGR3ZXZYTGNqWnIzcUxsWk90d3hyb0Q4Vm5VN2VBSEtHdUlWN1BMVDNnVi9E?=
 =?utf-8?B?dDJmc1d2ZGFIQStaRmJZc3VPeUxISG1IcXgyckhqV3FMelNmTFdIU0RBd0dI?=
 =?utf-8?B?eERaL3lKVkV6cW16MVdwRlNLZzA4UDFBRGZrcEdsblQ4NEd5Z3VaOTl2S0JX?=
 =?utf-8?B?bmFPdkV3MEdPelZ4bXU3OHBaU290cmhDYUR3QlpoRUVmSlJYUFFpVENpNTRy?=
 =?utf-8?B?TGNzM090NTNsaDByWVNPUXpzSDRHdENHUnFOcHZUcmk5VWpLUzI5T2VxZWwz?=
 =?utf-8?B?ODB1YzhlbS94dWM3MCtWVERYRzRvc28ySmdCOFZhT01INm53Qnh3MlhrcTh4?=
 =?utf-8?B?WjJlMHpZYlh0MEtIcWYzcEh5Sm5xTGxvR3hYN1FCcGIzQjVpd1dVZVM4Tmxm?=
 =?utf-8?B?alZrcWZoQklUUU44RmJMMkQ4bUJ2YTBVc0xHVmc1Z0VENmRKakNoZG5reCtl?=
 =?utf-8?B?RlRieWpoUXU1YWdFNjR5eERSU2dzb3NEaCtReUx6d2ZYakRSdzhVU1Q1YU1j?=
 =?utf-8?B?eTVqK3JGY0VTczV6YU9tUlMxS05oWXVvVktmZkhrUDRrQktoSngwZUovazI3?=
 =?utf-8?B?NTVFNWhWT1ZsajFibWV1Z2dldmI4VkRENlB0OXUyN1IreDZaR3hnTGlOajdi?=
 =?utf-8?B?UmFEVitFdHYyNk0yNm9zWEIrYTAyMExVK3UvRHVubmYxRXY4QUR6QWtWa2R5?=
 =?utf-8?B?bndtbXJNalAyQlQ3Vzl4Y2toTEl0SGROVFRPQ3pOclZzeExBWkdCdHZxUUJn?=
 =?utf-8?B?RU82TFNzZ0NuRGZ6akNKSGJTMXNTNE8wbjVTV280MGhxMDBuR2grUHNHdzFV?=
 =?utf-8?Q?dSpk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1f71eb-e16b-425d-f9dc-08dd87524d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 19:16:11.1601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVZTkSXIljp60U6kjAeGIb3imx0yU8JTuSE7FhUS7qvYtA8zawrg1b+6luWGTs1reCobZhcxYG2CQgWPM0GeAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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
Cg0KIGtpcSBzdGlsbCBiZSAgdXNlZCBmb3Iga2VybmVsIHF1ZXVlcyBtYXAvdW5tYXAgaW5jbHVk
aW5nIHRoZSAgc2NoZWR1bGVyIHF1ZXVlIGl0c2VsZiAuIEkgdGhpbmsgd2UgY2FuIGtlZXAgdGhp
cyBkZXNpZ24uICAgVGhlICBnYW5nIHJlbGF0ZWQgd2lsbCBnbyB0aHJvdWdoICBTQ0hFRC4NCg0K
UmVnYXJkcw0KU2hhb3l1bi5saXUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogVHVlc2RheSwgQXBy
aWwgMjksIDIwMjUgMzowNSBQTQ0KVG86IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNv
bT4NCkNjOiBDaGVuLCBNaWNoYWVsIDxNaWNoYWVsLkNoZW5AYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT47IExpYW5nLCBQ
cmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNS84XSBkcm0v
YW1kZ3B1L21lczEyOiBhZGQgc3VwcG9ydCBmb3Igc2V0dGluZyBnYW5nIHN1Ym1pdA0KDQpPbiBU
dWUsIEFwciAyOSwgMjAyNSBhdCAyOjU24oCvUE0gTGl1LCBTaGFveXVuIDxTaGFveXVuLkxpdUBh
bWQuY29tPiB3cm90ZToNCj4NCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5h
bCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gQ29ycmVjdGx5ICwgdGhlIGdhbmcgc3VibWlzc2lv
biByZWxhdGVkIHN0dWZmIG9ubHkgdXNlZCBmb3Igc2NoZWR1bGVyIHBpcGUgLCBraXEgaXMgZm9y
IHVzZWQgZm9yIGtlcm5lbCBkcml2ZXIgb25seSBhbmQgIHNob3VsZCBub3QgZXhwb3NlIHRvIHRo
ZSAgdXNlciBxdWV1ZS4NCg0KV2hhdCBhYm91dCBrZXJuZWwgcXVldWVzIG1hcHBlZCB0aHJvdWdo
IE1FUz8gIERvIHRob3NlIG5lZWQgdG8gZ28gdGhyb3VnaCBLSVEgb3IgaXMgU0NIRUQgb2s/ICBU
aGV5IHNlZW0gdG8gZ28gdGhyb3VnaCBLSVEgdG9kYXkuICBJcyBnb2luZyB0aHJvdWdoIFNDSEVE
IG9rPw0KDQpBbGV4DQoNCg0KPg0KPiBSZWdhcmRzDQo+IFNoYW95dW4ubGl1DQo+DQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBBbGV4IERldWNoZXINCj4gU2Vu
dDogVHVlc2RheSwgQXByaWwgMjksIDIwMjUgMjozOSBQTQ0KPiBUbzogQ2hlbiwgTWljaGFlbCA8
TWljaGFlbC5DaGVuQGFtZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS2hh
dHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+Ow0KPiBMaWFuZywgUHJpa2UgPFByaWtl
LkxpYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS84XSBkcm0vYW1kZ3B1L21l
czEyOiBhZGQgc3VwcG9ydCBmb3Igc2V0dGluZw0KPiBnYW5nIHN1Ym1pdA0KPg0KPiBPbiBUdWUs
IEFwciAyOSwgMjAyNSBhdCAyOjIz4oCvUE0gQ2hlbiwgTWljaGFlbCA8TWljaGFlbC5DaGVuQGFt
ZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gRnJvbTogYW1kLWdmeCA8YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gb24gYmVoYWxmIG9mDQo+ID4gQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwg
QXByaWwgMjgsIDIwMjUgNToyMCBQTQ0KPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQo+ID4gQ2M6IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwNCj4gPiA8
U3VuaWwuS2hhdHJpQGFtZC5jb20+OyBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+
DQo+ID4gU3ViamVjdDogW1BBVENIIDUvOF0gZHJtL2FtZGdwdS9tZXMxMjogYWRkIHN1cHBvcnQg
Zm9yIHNldHRpbmcgZ2FuZw0KPiA+IHN1Ym1pdA0KPiA+DQo+ID4gRW5hYmxlIGEgcHJpbWFyeSBh
bmQgc2Vjb25kYXJ5IHF1ZXVlIHRoYXQgc2NoZWR1bGUgdG9nZXRoZXIuDQo+ID4NCj4gPiB2Mjog
Zml4IG9mZnNldCBvZiBhcGlfc3RhdHVzIChQcmlrZSkNCj4gPg0KPiA+IEFja2VkLWJ5OiBTdW5p
bCBLaGF0cmkgPHN1bmlsLmtoYXRyaUBhbWQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBQcmlrZSBM
aWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jIHwgMjgNCj4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0KPiA+IGluZGV4IGY5ZjJm
YmMwYTcxNjYuLjU3ZDhiNzgyMTBmOWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tZXNfdjEyXzAuYw0KPiA+IEBAIC04NzksNiArODc5LDMzIEBAIHN0YXRpYyBpbnQgbWVz
X3YxMl8wX3Jlc2V0X2h3X3F1ZXVlKHN0cnVjdCBhbWRncHVfbWVzICptZXMsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgIG9mZnNldG9mKHVuaW9uIE1FU0FQSV9fUkVTRVQsIGFwaV9zdGF0
dXMpKTsNCj4gPiB9DQo+ID4NCj4gPiArc3RhdGljIGludCBtZXNfdjEyXzBfc2V0X2dhbmdfc3Vi
bWl0KHN0cnVjdCBhbWRncHVfbWVzICptZXMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdA0KPiA+ICttZXNfc2V0X2dhbmdfc3VibWl0X2lucHV0DQo+ID4g
KyppbnB1dCkgew0KPiA+ICsgICAgICAgdW5pb24gTUVTQVBJX19TRVRfR0FOR19TVUJNSVQgbWVz
X2dhbmdfc3VibWl0X3BrdDsNCj4gPiArICAgICAgIGludCBwaXBlOw0KPiA+ICsNCj4gPiArICAg
ICAgIG1lbXNldCgmbWVzX2dhbmdfc3VibWl0X3BrdCwgMCwNCj4gPiArIHNpemVvZihtZXNfZ2Fu
Z19zdWJtaXRfcGt0KSk7DQo+ID4gKw0KPiA+ICsgICAgICAgbWVzX2dhbmdfc3VibWl0X3BrdC5o
ZWFkZXIudHlwZSA9IE1FU19BUElfVFlQRV9TQ0hFRFVMRVI7DQo+ID4gKyAgICAgICBtZXNfZ2Fu
Z19zdWJtaXRfcGt0LmhlYWRlci5vcGNvZGUgPSBNRVNfU0NIX0FQSV9TRVRfR0FOR19TVUJNSVQ7
DQo+ID4gKyAgICAgICBtZXNfZ2FuZ19zdWJtaXRfcGt0LmhlYWRlci5kd3NpemUgPQ0KPiA+ICsg
QVBJX0ZSQU1FX1NJWkVfSU5fRFdPUkRTOw0KPiA+ICsNCj4gPiArICAgICAgIG1lc19nYW5nX3N1
Ym1pdF9wa3Quc2V0X2dhbmdfc3VibWl0LmdhbmdfY29udGV4dF9hZGRyID0NCj4gPiArICAgICAg
ICAgICAgICAgaW5wdXQtPnByaW1hcnlfZ2FuZ19jb250ZXh0X2FkZHI7DQo+ID4gKyAgICAgICBt
ZXNfZ2FuZ19zdWJtaXRfcGt0LnNldF9nYW5nX3N1Ym1pdC5zbGF2ZV9nYW5nX2NvbnRleHRfYWRk
ciA9DQo+ID4gKyAgICAgICAgICAgICAgIGlucHV0LT5zZWNvbmRhcnlfZ2FuZ19jb250ZXh0X2Fk
ZHI7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKG1lcy0+YWRldi0+ZW5hYmxlX3VuaV9tZXMpDQo+
ID4gKyAgICAgICAgICAgICAgIHBpcGUgPSBBTURHUFVfTUVTX0tJUV9QSVBFOw0KPiA+ICsgICAg
ICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBwaXBlID0gQU1ER1BVX01FU19TQ0hFRF9QSVBF
Ow0KPiA+DQo+ID4gSSB0aGluayB0aGlzIHBhY2tldCBzaG91bGQgYmUgYWx3YXlzIHN1Ym1pdHRl
ZCB0bw0KPiA+IEFNREdQVV9NRVNfU0NIRURfUElQRSwgc2FtZSBwaXBlIGFzIGluIG1lc192MTJf
MF9hZGRfaHdfcXVldWUgd2hlcmUgdGhlIHF1ZXVlIGlzIGNyZWF0ZWQuDQo+ID4gVGhpcyBpcyBi
ZWNhdXNlIEhXUyBvbiBBTURHUFVfTUVTX0tJUV9QSVBFIGRvZXMgbm90IGhhdmUgdGhlIHF1ZXVl
IGluZm9ybWF0aW9uLg0KPg0KPiBTb3VuZHMgbGlrZSB0aGUgcmVzZXQgcXVldWUgZnVuY3Rpb24g
YW5kIHRoZSBtYXAgYW5kIHVubWFwIGxlZ2FjeSBxdWV1ZXMgc2hvdWxkIGFsc28gYmUgY2hhbmdl
ZD8NCj4NCj4gQWxleA0KPg0KPiA+DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIG1lc192MTJf
MF9zdWJtaXRfcGt0X2FuZF9wb2xsX2NvbXBsZXRpb24obWVzLCBwaXBlLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICZtZXNfZ2FuZ19zdWJtaXRfcGt0LCBzaXplb2YobWVzX2dhbmdfc3Vi
bWl0X3BrdCksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2YodW5pb24gTUVT
QVBJX19TRVRfR0FOR19TVUJNSVQsDQo+ID4gK2FwaV9zdGF0dXMpKTsgfQ0KPiA+ICsNCj4gPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfbWVzX2Z1bmNzIG1lc192MTJfMF9mdW5jcyA9IHsN
Cj4gPiAgICAgICAgICAuYWRkX2h3X3F1ZXVlID0gbWVzX3YxMl8wX2FkZF9od19xdWV1ZSwNCj4g
PiAgICAgICAgICAucmVtb3ZlX2h3X3F1ZXVlID0gbWVzX3YxMl8wX3JlbW92ZV9od19xdWV1ZSwg
QEAgLTg4OCw2DQo+ID4gKzkxNSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X21lc19m
dW5jcyBtZXNfdjEyXzBfZnVuY3MgPSB7DQo+ID4gICAgICAgICAgLnJlc3VtZV9nYW5nID0gbWVz
X3YxMl8wX3Jlc3VtZV9nYW5nLA0KPiA+ICAgICAgICAgIC5taXNjX29wID0gbWVzX3YxMl8wX21p
c2Nfb3AsDQo+ID4gICAgICAgICAgLnJlc2V0X2h3X3F1ZXVlID0gbWVzX3YxMl8wX3Jlc2V0X2h3
X3F1ZXVlLA0KPiA+ICsgICAgICAgLnNldF9nYW5nX3N1Ym1pdCA9IG1lc192MTJfMF9zZXRfZ2Fu
Z19zdWJtaXQsDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCBtZXNfdjEyXzBfYWxsb2Nh
dGVfdWNvZGVfYnVmZmVyKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ID4gKmFkZXYsDQo+ID4gLS0N
Cj4gPiAyLjQ5LjANCj4gPg0K
