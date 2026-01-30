Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFECD49C9E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 10:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24C810E9BE;
	Fri, 30 Jan 2026 10:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBwJjvJz";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9DA10E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 10:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpRrzY6nrFrNtRP7jWb7EsVSAPF0KXF1o8ILzWrAyaWlOtfS5wscYQ/ZrzpWjqFIotFrmLw/UrqPMH3mfLsI+xqT2GV3t9670DnVCipg0khTi/OyFLTZZYvg9/+NojftxK4moyyzSOhA+aAhg49QGhdodAapJGyz20ASTOXXj1NRwhFAbvrhku6bvWlsK9dzqzHlDnLGN3nF/56ALNmbhL6dfkaAlSaVqPV7ylQ5qCP1yB0axSeATzEgR66aSWU/9SVdyfT87UNQ5rQrol0zuUM59qv5xrlesuxxd3p0mWEjLzo8/+8ythBFwonctFtSP6JsjkwEyMybMGtLSd5JtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TGPk6GQekB4YPK+Dbmnnv3NeZc5ezuagtN0lzvkR6A=;
 b=jZM7SVijGtJ6ebJ1Jhkof/ld4vA1fLwLA2/gcNoP4Y3vEF2EXx4727iZWb3glpzSaUVbdPK7iVMnS8hHwZRviI8H28cHZp+RmJIhcZwXDkn6zdj9U4Q9AQE/PgIEOiXBDezXk2+J55dVREIWzNg2ZJA3z0B3NQx3eeqp8ZI5uZE4k88+vrtJW+z6XKMJ/X2ZjzTNFKe+0E7Iq1VrmLwEP0gKauOAkujNfxsajc5fLu0Ji7NgDulJ5OKhHWakuR4DN4D1sYRrAUQSXt0c8GgnCwNldG0zz+qr+YOSrpm/yAiyZ1m/9+tbUf/8ARYyN7Y4AHGNsdXAMo+4kNeEdTJsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TGPk6GQekB4YPK+Dbmnnv3NeZc5ezuagtN0lzvkR6A=;
 b=PBwJjvJzM75aiqcprf/vrhjfJ2xojErRzpwFAD7muvov7p12AgzfqF2piBM1+JuNlzFoJJlTVDl35s1hcIW3CUOanX8sKifIrqhXO9NGvCNHmbu4YF+KzbxMA+mRhU5KpCG9ypFHl7W7Hc2bYo+rlAv90i9daUUA3YiO+ptri+8=
Received: from CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 10:53:00 +0000
Received: from CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::376a:310a:9d11:ec97]) by CY8PR12MB8339.namprd12.prod.outlook.com
 ([fe80::376a:310a:9d11:ec97%3]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 10:53:00 +0000
From: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip vcn poison irq release on VF
Thread-Topic: [PATCH] drm/amdgpu: Skip vcn poison irq release on VF
Thread-Index: AQHci2wuW6L/M5dZckmtw+lTZM/dcrVqkr0AgAADARA=
Date: Fri, 30 Jan 2026 10:53:00 +0000
Message-ID: <CY8PR12MB8339432928363ED7F8E07D2AFD9FA@CY8PR12MB8339.namprd12.prod.outlook.com>
References: <20260122065538.1595301-1-lijo.lazar@amd.com>
 <208c51d0-7ba3-4d1f-be3c-822ea1a49685@amd.com>
In-Reply-To: <208c51d0-7ba3-4d1f-be3c-822ea1a49685@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-30T10:50:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8339:EE_|IA0PR12MB8906:EE_
x-ms-office365-filtering-correlation-id: 3742aa0e-6dc0-46c9-0642-08de5fedbc3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?S2N2WHhRSDlTTVRtYko3UFhpRWk4WlV3UHpNSHE2TGxRV3BRM3AwMDBBS05v?=
 =?utf-8?B?YVlPb2Y1VG0yS2huSVZEeVY0cklNSTFIRWFHMVR0NHYydG9Sc3BsQ0VJS08v?=
 =?utf-8?B?Rm1TU0p0SzJmTE5TRng3NmJCNHBoL2VCZ09GQms0OUpIdkNWUEsycXNyciti?=
 =?utf-8?B?Vk9ZcG4rOU1vMEgrNk9JK2NPdzJmS2ZVeHJjTDJhTEFHRzNJQnpLR3FETDIw?=
 =?utf-8?B?NTYwWkxLYTNWeVpVeUJLRXMzQjg1eHYwM0d2emxsSEZraDU0bW9lY1lOTnpQ?=
 =?utf-8?B?NnI1Q1lpZjdjN2dBQUltbFhsRFNVaUJZR2NTWDFCK0p5clI0M1ZtL1lxY2Qv?=
 =?utf-8?B?RHBtcFN3eVNmZ2NNbGlBcStuRGo5MmRZQmJPS0RUTTgzclNYamV5WGVPMk50?=
 =?utf-8?B?ZHFBbW44SHBjb3F3TjhkaTRrQ2VNZEdTc0xCd2tPd0gwbFk5NFFraXRTWk5o?=
 =?utf-8?B?V2JLbHU5RzFtQ3lZd1hkclhFYk9jRUZtTnJpTGxwbHhEQ0xxVGpLNWpsUTZD?=
 =?utf-8?B?Q0JUUGVvSlhrY0NrQU9oZ2Zrclh5RTFYSkE0QkYwV2dzR29VS2ZxOStaelds?=
 =?utf-8?B?TW9PU2V6Ry9hbVFDc0FtQ2lxYXllWG95bGJqcHQxV3VNN1FmWWVseWRUd2pi?=
 =?utf-8?B?cHk0cEVnZDlZRWFmcTNGY3o4TllTUEYxbnhMLzk2aGEvYk5uekIxajJZUTJq?=
 =?utf-8?B?dDZzVFdtUkVDMlVTZmIxOWV4WWlKZDhFNXZodEYzY3JXOGxPamdPSC95d25J?=
 =?utf-8?B?MjdpcWtKV2x5VnBITW1NUThhdDk0NHF6K2I1bTV0cjNNdnJhYzZQN0c4QWVi?=
 =?utf-8?B?eW82bEhqZmdRS05tSnZTb1RQeWpNNUQ0VUVNSkJ2dlNaS29sT3JMaXZrZUxk?=
 =?utf-8?B?NEhvazNpU0h6bEkrQWQrb1ZnQVdmMnRVSzA4eUt0bmRvTXYxZFliWnRTbUNG?=
 =?utf-8?B?ZjN5R0JWSXRGR3RpRlVRTGRZaTRXZzVBWC9kZDB1WE1WTHFvZDRrVXJwcTRi?=
 =?utf-8?B?dVlwTW8rOWxjSWxzWHF1eWhuZ2JKTEgrQXRVUm5VQWFqWHFCYVVqRXZsdUxa?=
 =?utf-8?B?dG5UVC8zdXg2aFVEaVpRdWhFOTZOTk9qSlREUWtCMU5HSGFmQ0xFTlRwb1RI?=
 =?utf-8?B?MzZrbmlxWVkvQXk4bDZYSjM5Z0JNaERmL0UySmhhcnVtKzZVUE52b0VYRjR5?=
 =?utf-8?B?NjhVSTlmT1d3UllBNWNsclppbWttQ3RDS0t5OVM2OTVNOFVjWExiUUIxT1Vl?=
 =?utf-8?B?aWV0ZU80Y1o0R016L0RWMU9JcU9INndnZGJ3UXhZcEN0S3k1c09EQ1VzVGJR?=
 =?utf-8?B?blRCSm9RbUt6SmdXczE4RXU5NkV2bDNHdkR0RWloaXVUV292bkJmZzBKNnZk?=
 =?utf-8?B?Y29NME8yVVhyL0xZTktMMVNydXROVzlJUWF4dDZiVDhhaGZGYmJQNlN1WlFJ?=
 =?utf-8?B?Z1ZrNXlkRTZRbGhhK2Fna1ptajl4SHVOQStDaGxHLzhVRnlaa3p6WTIxYzdp?=
 =?utf-8?B?RjcrZlJEbXZNS09VQXRQYkRxcVNFTzJMYlRhZXpwNCsxUEdpeUs1VEZKakpH?=
 =?utf-8?B?Wko1aUJBMWR0aGdWMmUzTkw5RlAwOStPNUFLdE5BNjRzaTBjMk9kcGZIRlp5?=
 =?utf-8?B?ODdyNlhGMmdZMGQ5K0t6NW1rZTRseXFIZXdJaVNFazJlMFdEOEJDNkVZUkd2?=
 =?utf-8?B?cC8zUXpOd2pVdzJKN3dJSVBQc1cwM3BHK2JDOWcxRkxkcCtTWnNkdG1DV0Nx?=
 =?utf-8?B?Nk9UamFLR1RXR1ZXbS9TcytjQitCTXZTbXNxVnBIRWYxWHZFRWs4VC9vMDRP?=
 =?utf-8?B?TmoxeUpNZVJsUTdGbFJrLzV3RTk2MTM4aDM2LzJQSGZaOE9pNmVnaytVV0lD?=
 =?utf-8?B?MWxJYktPQy9Hd3FBR2dXdTA2dStUaXpqZlVQc2JoU3RxVVBEaW9GZEtTK3pW?=
 =?utf-8?B?TEN1TnNOMmFBT1Q2dUNGM1pZb3A3MG5qOS9POVNrNWN5RElFbkxVS3lXclBF?=
 =?utf-8?B?UlQxNjlCNWJJeFFRU3hiRDVrMkJWeDdpQU5SRFJCZjZnaFhVdUNXU0tFcUVT?=
 =?utf-8?B?b0p4aU50d1BPa1hnSEJIbENONm1ycXlYNGdUM09BbnpFWUQxQUR1a0RUWFpM?=
 =?utf-8?B?Ulg4RVJLUW1qNzNFU2ljMk1OeU5UWWxnb0I2dXZzMHN3TmRicUdUMm10YWc4?=
 =?utf-8?Q?C6b2NqW4yD1vLnvQ7vSkmjg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8339.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmtlVkZZekkyeEs0dzh3TVR1WGo5TXF5TURqUHU1MlFlSmtCaVFKNXBKUUI5?=
 =?utf-8?B?MTdtbGlkNnJhNW41MHFSZjRKY0pEY1Z4aFpIQVplbk9zUjlvcks3Zi9xNFgv?=
 =?utf-8?B?UG1HaE1YMGk2NzVCQ1pVT0RpOHM4bmxXOFJoTkVuVFNnU2pxQTFjT2VDVjZR?=
 =?utf-8?B?cngxYnB3YnZVZDB5UUl6VFJxMS82TXV0a01MQW41Z1NSc2FMK1VmWVlMUzVY?=
 =?utf-8?B?RVF6bXE4NGpQTllBclo2SkM1UTlkUVlCUjVZeXVwS0UyaTRTTVhFb0hIcWt2?=
 =?utf-8?B?Y0cxSHpERTMzdjFSV3lBYk1PQ0Ztd2VXMVFHZ0lWVnE2MThYajRBdlQ4V0NW?=
 =?utf-8?B?QnByYSsvQ1I3cE13QVNkSjczTjlkNDlDRVpXRjF2YTN5OVRvcGhtWmUvc2du?=
 =?utf-8?B?UXVpUU1wcXJVb0NKaDM1eGFQcm9kWlBJU0FvOVUwbW9TQXZ1MXQ4YjBNUHFF?=
 =?utf-8?B?d3BCYUNHTWFZUjQ5aWJySUd6ckJkV3JIYXk1ZHV3UExFUnZ6N0JPRUlaaDI3?=
 =?utf-8?B?OStRM1l1bVp3ZTV1cVh4ZFFoaFM2VGY4Y1pqM2tYaksrcWZRa1l2aVI3OTlh?=
 =?utf-8?B?LzJUS1hVbW5NenhQNmN2NU00N0hLcDBDUXhnL20xazlJS05Yd01CZE5vUmVp?=
 =?utf-8?B?V3UzMk5WbmN5bzVLUVBlc1ZYWVExekpCVmNWRVYvQlo5blpYc3Z1T0ZEbkc0?=
 =?utf-8?B?SzlvcGNhcWVKeTZZVjdZNENEOWUxZkRrWkNUY014dW9yUC9RVFhZaEVvQlRv?=
 =?utf-8?B?TG5wQjk3MVBNS2N5UHl0WTA0b3JrL1JXclpwc2Q5bHVSMnhWYmlCanMrSzc0?=
 =?utf-8?B?MzFFb1lpbHhaUWpCcWZ4dGZPeE5SSTNlWSs5YTJMRThwQUdyREg1WHpBVDVG?=
 =?utf-8?B?OFcwMEMvZXBSZVRXMis3U0xYa2c4a3RXYStSeXgrZGtDLzZGQUxjQTAxYk9F?=
 =?utf-8?B?dTAyd2dYSlozaTU5ZE5VdUltT3QrWElJdEhzaWdtSEo5SGpjbS9wZWFZZHg4?=
 =?utf-8?B?aE1iYTJqVE1PREFZQWlmdzU3SDRSM0FyUnpSOG1DRGZuR3NxSktsQlkvSnBh?=
 =?utf-8?B?clJqdEx4NytHdHl2MjNxdTRNUHZUZThDa3dqTE84RGRPUy9aaGdVaDhPK1VC?=
 =?utf-8?B?aHZiR2d6eDlzakpIT1Z2MitDUnhsWFRwSEozL2lkMGtXYVEwQmlmUVFFVXo4?=
 =?utf-8?B?aWZ3VFcvMGQ1OG4waEJtTkZ6bHQvU0c0Zm5OanJxK1E3aXZvV21yK3NNbzl5?=
 =?utf-8?B?K2hSZGVsSlJ3VEI0bzQxTk95bUFPZkVjY2FoeUs2aVNxeGs3aUpMZWZTTVNr?=
 =?utf-8?B?SmZLd3pEREJhb0pScU41UUVJb2NjZW5oWUlLUFRrS2MzS0tzREFxSDJ4M3Bq?=
 =?utf-8?B?SXZ4VFEwaWozV3ZKZS82N2hodWphWkp6c2NvbElnMHVwZEt4bWkxS1U5N1V4?=
 =?utf-8?B?VXJKcmZrUlhNWDBzbHEyNDZhOHNSdFBPSjVHYmgrZVZnUk5UWlNVYkhMaUtO?=
 =?utf-8?B?Uk5MbEI4eHRqeTh2WWJhUTNlejJ5WitDQkFjUTBGSmx5NEdGNDdtc1NrOFBP?=
 =?utf-8?B?VnZUejFMYURXdzBCcTZpN0cyVEdoQkszSTBVWS9QYTJ4YW5mbFFiWnNQeHhX?=
 =?utf-8?B?VEtaQXdtK3VrSnlHaTJuWGtPQjA4N1E0b0JHUGZabHpaSUZDVEtqQ2ZhRDMw?=
 =?utf-8?B?UTg3NXIxWFRTWVJmaGhqelRvQUV3eitBR3k2azlaa29VTHcxTnZGSno4N24w?=
 =?utf-8?B?bEh6c1FLQ3lZTmxpdUVsZ0UyMWZzcjhkUjArQXRWRExyREJScXF4QXNOeE1M?=
 =?utf-8?B?YkdDK0x4Q1dHdFFCcmxkWDFJZkYwWWFteFhaTktQQWx2dEt6Y3U5K2ppVlZ6?=
 =?utf-8?B?RmNKbW5iQnNqOWZLaWpNTTJ5TEphNzNLNkpETzRaa1lacVZoZGhrcWtDZW4y?=
 =?utf-8?B?NFNNVHNORlBkd2p3Q0xEaVVaMHZPQXlWWFdQbjVLbmo1RUNybXJGZXArYk40?=
 =?utf-8?B?bDgyYWw1ai9sTDR4OGw5Yk1LZTZxd0tvbmJGZ3Fsa1Y1MFBzLzJhMTZzcDk4?=
 =?utf-8?B?azh1ZEVuTlRxejBqZnhyTXRYM2t2ZFAxM00wemZGR0JaNGo1M2xGNGF0c1pu?=
 =?utf-8?B?bk92ak5PamE3NWd3QzR5dVRIME9ydW1EdkJtVFB6VGUrc0R0R1BYWWUwQ2t5?=
 =?utf-8?B?c1c1cUMwM3dKbmYyYWl0WWw4K2hHYk5ZSnBwUWlMTGF5RURRNXdoQkZxenQ3?=
 =?utf-8?B?aTMzd2p6Ujh1WkljQ01GY3dzQkhPZzlodE5WT3o4YTFacCs3T2V0RXRvYita?=
 =?utf-8?Q?XGf8/XmtILoaQckaiP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3742aa0e-6dc0-46c9-0642-08de5fedbc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 10:53:00.2495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBYJoRRLqFFqCWgKSucihtN/uxO+jfYgOlFZIhXwu8h5s9ixNmqVj2Ky7jsaCy1tNB/pNiCXTFibdGrxuOA3eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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
Cg0KUmV2aWV3ZWQtYnk6IE1hbmdlc2ggR2FkcmUgPE1hbmdlc2guR2FkcmVAYW1kLmNvbT4NCg0K
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT4NCj5TZW50OiBGcmlkYXksIEphbnVhcnkgMzAsIDIwMjYgNDoxMCBQTQ0KPlRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+PEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBHYWRyZSwgTWFuZ2VzaCA8TWFuZ2VzaC5HYWRyZUBhbWQuY29tPjsNCj5Z
YW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBTa2lwIHZjbiBwb2lzb24gaXJxIHJlbGVhc2Ugb24gVkYNCj4NCj48cGlu
Zz4NCj4NCj5PbiAyMi1KYW4tMjYgMTI6MjUgUE0sIExpam8gTGF6YXIgd3JvdGU6DQo+PiBWRiBk
b2Vzbid0IGVuYWJsZSBWQ04gcG9pc29uIGlycSBpbiBWQ052Mi41LiBTa2lwIHJlbGVhc2luZyBp
dCBhbmQNCj4+IGF2b2lkIGNhbGwgdHJhY2UgZHVyaW5nIGRlaW5pdGlhbGl6YXRpb24uDQo+Pg0K
Pj4gWyAgIDcxLjkxMzYwMV0gW2RybV0gY2xlYW4gdXAgdGhlIHZmMnBmIHdvcmsgaXRlbQ0KPj4g
WyAgIDcxLjkxNTA4OF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+PiBb
ICAgNzEuOTE1MDkyXSBXQVJOSU5HOiBDUFU6IDMgUElEOiAxMDc5IGF0DQo+L3RtcC9hbWQuYUZr
RnZTUWwvYW1kL2FtZGdwdS9hbWRncHVfaXJxLmM6NjQxIGFtZGdwdV9pcnFfcHV0KzB4YzYvMHhl
MA0KPlthbWRncHVdDQo+PiBbICAgNzEuOTE1MzU1XSBNb2R1bGVzIGxpbmtlZCBpbjogYW1kZ3B1
KE9FLSkgYW1kZHJtX3R0bV9oZWxwZXIoT0UpDQo+YW1kdHRtKE9FKSBhbWRkcm1fYnVkZHkoT0Up
IGFtZHhjcChPRSkgYW1kZHJtX2V4ZWMoT0UpIGFtZF9zY2hlZChPRSkNCj5hbWRrY2woT0UpIGRy
bV9zdWJhbGxvY19oZWxwZXIgZHJtX2Rpc3BsYXlfaGVscGVyIGNlYyByY19jb3JlIGkyY19hbGdv
X2JpdA0KPnZpZGVvIHdtaSBiaW5mbXRfbWlzYyBubHNfaXNvODg1OV8xIGludGVsX3JhcGxfbXNy
IGludGVsX3JhcGxfY29tbW9uIGlucHV0X2xlZHMNCj5qb3lkZXYgc2VyaW9fcmF3IG1hY19oaWQg
cWVtdV9md19jZmcgc2NoX2ZxX2NvZGVsIGRtX211bHRpcGF0aCBzY3NpX2RoX3JkYWMNCj5zY3Np
X2RoX2VtYyBzY3NpX2RoX2FsdWEgZWZpX3BzdG9yZSBpcF90YWJsZXMgeF90YWJsZXMgYXV0b2Zz
NCBidHJmcw0KPmJsYWtlMmJfZ2VuZXJpYyByYWlkMTAgcmFpZDQ1NiBhc3luY19yYWlkNl9yZWNv
diBhc3luY19tZW1jcHkgYXN5bmNfcHENCj5hc3luY194b3IgYXN5bmNfdHggeG9yIHJhaWQ2X3Bx
IGxpYmNyYzMyYyByYWlkMSByYWlkMCBoaWRfZ2VuZXJpYyBjcmN0MTBkaWZfcGNsbXVsDQo+Y3Jj
MzJfcGNsbXVsIHBvbHl2YWxfY2xtdWxuaSBwb2x5dmFsX2dlbmVyaWMgZ2hhc2hfY2xtdWxuaV9p
bnRlbCB1c2JoaWQgODEzOXRvbw0KPnNoYTI1Nl9zc3NlMyBzaGExX3Nzc2UzIGhpZCBwc21vdXNl
IGJvY2hzIGkyY19pODAxIGFoY2kgZHJtX3ZyYW1faGVscGVyDQo+bGliYWhjaSBpMmNfc21idXMg
bHBjX2ljaCBkcm1fdHRtX2hlbHBlciA4MTM5Y3AgbWlpIHR0bSBhZXNuaV9pbnRlbCBjcnlwdG9f
c2ltZA0KPmNyeXB0ZA0KPj4gWyAgIDcxLjkxNTQ4NF0gQ1BVOiAzIFBJRDogMTA3OSBDb21tOiBy
bW1vZCBUYWludGVkOiBHICAgICAgICAgICBPRSAgICAgIDYuOC4wLTg3LQ0KPmdlbmVyaWMgIzg4
fjIyLjA0LjEtVWJ1bnR1DQo+PiBbICAgNzEuOTE1NDg5XSBIYXJkd2FyZSBuYW1lOiBSZWQgSGF0
IEtWTS9SSEVMLCBCSU9TIDEuMTYuMy0yLmVsOV81LjENCj4wNC8wMS8yMDE0DQo+PiBbICAgNzEu
OTE1NDkyXSBSSVA6IDAwMTA6YW1kZ3B1X2lycV9wdXQrMHhjNi8weGUwIFthbWRncHVdDQo+PiBb
ICAgNzEuOTE1NzY4XSBDb2RlOiA3NSA4NCBiOCBlYSBmZiBmZiBmZiBlYiBkNCA0NCA4OSBlYSA0
OCA4OSBkZSA0YyA4OSBlNyBlOCBmZCBmYyBmZg0KPmZmIDViIDQxIDVjIDQxIDVkIDQxIDVlIDVk
IDMxIGQyIDMxIGY2IDMxIGZmIGU5IDU1IDMwIDNiIGM3IDwwZj4gMGIgZWIgZDQgYjggZmUgZmYg
ZmYgZmYNCj5lYiBhOCBlOSBiNyAzYiA4YSAwMCA2NiAyZSAwZiAxZiA4NCAwMA0KPj4gWyAgIDcx
LjkxNTc3MV0gUlNQOiAwMDE4OmZmZmZjZjA4MDBlYWZhMzAgRUZMQUdTOiAwMDAxMDI0Ng0KPj4g
WyAgIDcxLjkxNTc3NV0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjg5MWJkYTRiMDY2
OCBSQ1g6DQo+MDAwMDAwMDAwMDAwMDAwMA0KPj4gWyAgIDcxLjkxNTc3N10gUkRYOiAwMDAwMDAw
MDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6DQo+MDAwMDAwMDAwMDAwMDAwMA0K
Pj4gWyAgIDcxLjkxNTc3OV0gUkJQOiBmZmZmY2YwODAwZWFmYTUwIFIwODogMDAwMDAwMDAwMDAw
MDAwMCBSMDk6DQo+MDAwMDAwMDAwMDAwMDAwMA0KPj4gWyAgIDcxLjkxNTc4MV0gUjEwOiAwMDAw
MDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6DQo+ZmZmZjg5MWJkYTQ4MDAw
MA0KPj4gWyAgIDcxLjkxNTc4Ml0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogMDAwMDAwMDAw
MDAwMDAwMSBSMTU6DQo+MDAwMDAwMDAwMDAwMDAwMA0KPj4gWyAgIDcxLjkxNTc5Ml0gRlM6ICAw
MDAwNzBjZmY4N2M0YzQwKDAwMDApIEdTOmZmZmY4OTNhYmZiODAwMDAoMDAwMCkNCj5rbmxHUzow
MDAwMDAwMDAwMDAwMDAwDQo+PiBbICAgNzEuOTE1Nzk1XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+PiBbICAgNzEuOTE1Nzk3XSBDUjI6IDAwMDA1
ZmExMzA3M2U0NzggQ1IzOiAwMDAwMDAwMTBkNjM0MDA2IENSNDoNCj4wMDAwMDAwMDAwNzcwZWYw
DQo+PiBbICAgNzEuOTE1ODAwXSBQS1JVOiA1NTU1NTU1NA0KPj4gWyAgIDcxLjkxNTgwMl0gQ2Fs
bCBUcmFjZToNCj4+IFsgICA3MS45MTU4MDVdICA8VEFTSz4NCj4+IFsgICA3MS45MTU4MDldICB2
Y25fdjJfNV9od19maW5pKzB4MTllLzB4MWUwIFthbWRncHVdDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMgfCA0ICsrKy0NCj4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMNCj4+IGluZGV4IGNlYmVlNDUzODcxYy4uMDA2YTE1NDUx
MTk3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUu
Yw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYw0KPj4gQEAg
LTUyMSw3ICs1MjEsOSBAQCBzdGF0aWMgaW50IHZjbl92Ml81X2h3X2Zpbmkoc3RydWN0IGFtZGdw
dV9pcF9ibG9jaw0KPippcF9ibG9jaykNCj4+ICAgICAgICAgICAgICAgICAgIFJSRUczMl9TT0Mx
NShWQ04sIGksIG1tVVZEX1NUQVRVUykpKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgdmluc3Qt
PnNldF9wZ19zdGF0ZSh2aW5zdCwgQU1EX1BHX1NUQVRFX0dBVEUpOw0KPj4NCj4+IC0gICAgICAg
ICAgICBpZiAoYW1kZ3B1X3Jhc19pc19zdXBwb3J0ZWQoYWRldiwgQU1ER1BVX1JBU19CTE9DS19f
VkNOKSkNCj4+ICsgICAgICAgICAgICAvKiBWRiBkb2Vzbid0IGVuYWJsZSBpbnRlcnJ1cHQgb3Bl
cmF0aW9ucyBmb3IgUkFTICovDQo+PiArICAgICAgICAgICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYo
YWRldikgJiYNCj4+ICsgICAgICAgICAgICAgICAgYW1kZ3B1X3Jhc19pc19zdXBwb3J0ZWQoYWRl
diwgQU1ER1BVX1JBU19CTE9DS19fVkNOKSkNCj4+ICAgICAgICAgICAgICAgICAgICAgIGFtZGdw
dV9pcnFfcHV0KGFkZXYsICZ2aW5zdC0+cmFzX3BvaXNvbl9pcnEsIDApOw0KPj4gICAgICB9DQo+
Pg0KDQo=
