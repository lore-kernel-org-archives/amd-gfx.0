Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA60D3ABEF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 08:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B5F10E0EB;
	Mon,  8 Dec 2025 08:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rBrG0nGF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26AE10E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 08:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJsRu7IhcqMVo8QZ7dXW9Prvtd1njG4FS01zMF2R/4Sn8N0YdwWUN+NzWtQX3KHzHqBK3LuU5x8bC3g0wvpKZ1S/311GZoV0nrQELNsQuscf+idvhQx4N8uVITTExr/V7T4H5tDcRP4ZYnSPZ1EhMaOEHT45DbGH7PvjDKCk+RsVqMHvy5UPzXgNHTIeTaa9dgaBxFyTGMTyIBRaQPaak3P1S4fd4pD4pXSrqVz0IoNwNIuAbUDvWMgcFT8ppfccXR5i1epl6w/kuTSmGtvUoXjUWEsUQ/4Gus2G6Y0avVrsEdLBAOJJzJWentg4TFR81LDBzbKsGGiu9SrthqUzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wULz2L5db668jtcCKrRZwyV/l3DqeaBn1eqToCdLSpI=;
 b=Nzp/Y3jNuEWsakU2REfUwh1TjEs2UmcUUisnWAV76AhGV/JuxzDRpAxRpJcdjdIXB2hZIVJZ+Xyop/M8awtE9tqC1UwSGy6PN+33oUKr9oEmfIqBD5XU1rHSuUvRoeSuwJCqClJ5qNKUeDy1SHn+1koTl1n9zPQ80KBeC2hGfzW5zPJkRi8a0rrQ6g7BHt+CR5ENlIJl+eFaBEnsc91My7JIDOUXAqM62XnxfDNtzLuLASDUm3XHsnjyFdE+3SkGbSyF+1f0qgZgpzPADfYrE74Hr4o7SM4QbpdKfJYc9dA3xcBMMyM5RmfTFZgV33j777vLMCwk7S1hJhxe6WET4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wULz2L5db668jtcCKrRZwyV/l3DqeaBn1eqToCdLSpI=;
 b=rBrG0nGF7NMd25etURucuTicuUK5WihVwVeYjiYikkZc67u/A5IqH8Y+CCvfAWEHmB8/em4awW+VheM2+Ljw2PMPF8WgVEumwKYNL4U4XgKNkIU/d/P8viyUYbuM/lNe8/Ca8R7HyI/x9hiOB+E8iYXroAl/t8YpRluXDHoCHz0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 08:01:38 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 08:01:37 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Reduce stack usage in
 ras_umc_handle_bad_pages()
Thread-Topic: [PATCH] drm/amd/ras: Reduce stack usage in
 ras_umc_handle_bad_pages()
Thread-Index: AQHcZeDsyx2MXz5eOkOKGSVZQzccEbUXZeOg
Date: Mon, 8 Dec 2025 08:01:37 +0000
Message-ID: <PH7PR12MB8796BE135963DCEE24A7A7B4B0A2A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251205121549.408575-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251205121549.408575-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-08T08:01:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB8426:EE_
x-ms-office365-filtering-correlation-id: 591b74d4-5b09-4df9-421b-08de3630038a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?a3FiTEhYc05QalYwOHpZMS80Y20ydFBvWW50REN6TG1xUUdyTSt2VzlZUFBo?=
 =?utf-8?B?ODJJandBVzBkOXlub013QU50c2dLVC8rNG9MLzlYS0R4OWF6ZS84T3h6eVgw?=
 =?utf-8?B?YllqNmxieDRtM0ZiOVBKQzlmd1RCUEMyekt0WHlUMUpDRlhTQVV2Y2Y5Q2JJ?=
 =?utf-8?B?bkxvUDlvT1FNMTZTRWJrQ1ZJNjlwTVdkTExoU3pGYmhKcTM2dnF5TzNhLzBt?=
 =?utf-8?B?UGtjbzUrbWVVdEo0eE9XaEd2L2pHWTJDZG1hSUdHellDUVRzcXRVNGdraTJJ?=
 =?utf-8?B?bXFVKzFlOHFiL0k0RGtWWTlwNTNHMTJDV0ovR3NObTZYTFZBYjFCNjZZYjJD?=
 =?utf-8?B?amFCMW4vajVjVU12VWFUUXJ4b1RGM0tzNHlmTHZ2bTRZeHNpUjhRSHdBNmtW?=
 =?utf-8?B?UVg3RFNwRUoySzVDZ2o3VlJnSlRGcWJjNnVCamRZNUhTSG5ZMUs5THM4WHRE?=
 =?utf-8?B?VDYzQnFIdFY4L0J2TStnK29CbFB1V1M1YVV5eWN5cTFCTXZ2VkVjR21nNVI0?=
 =?utf-8?B?OVQ4anBDWldmZXFNYTNyMU9IWUk1VktOcmxlRFBuR2FIS1Fkb1hqOXdZcDll?=
 =?utf-8?B?OVpKdHJEVnhacVJqKzNYS0VJeUFDVC81RER5ciswblhMaUJYakYyaGxrcThL?=
 =?utf-8?B?cUpOUkhsV0NVY0ZFTWJzaEYrZ0M4cEdlRHd4eFRCMm55a3I4QnU5SHZxdi9p?=
 =?utf-8?B?MjBiWCtTV3p5QWxJamRMb2JPelhIbnJMWTg2c1pwNW1yMDZrU1pBMXhHYWNH?=
 =?utf-8?B?K0tjejBuMkV1MnRibUlUMnNHdUY4d0ZMQUNPKzM5YXNQT1Z6MmJRY0NOU0M5?=
 =?utf-8?B?R1hZcGNpc2hVQVNCSW16MGVhRzRTOHVRNjJUdU1WWlRwVkpDcTYyN2ltRkdV?=
 =?utf-8?B?MDh3Y01LeW5kbmRWOW5pUEdJWEEyTi9kZlYxTS9RalJaWmhTbUNXWFVCSGVw?=
 =?utf-8?B?WklPS3RUNTNHNGVIZElxbU1uMFdYbnpDTUdLYVQwWGdZVThrYVBRUlFKVEts?=
 =?utf-8?B?c0krREViMXhMK2ZLaUljeno1MEdpWTdCV0crbGxnSE5GblR1cWNzYmJqWDVz?=
 =?utf-8?B?WWFxcjE1aVpnaGtUTWE1UjhlOHFaY2pVSTFYLzBjMXRNL0FacFNDS0R5czUw?=
 =?utf-8?B?ejcxRkhWVDJaWi93akMxZVl3QjdhRVpVUGJGQkFzTnJSZm8xODQ5UFhrYnBl?=
 =?utf-8?B?aGxDbHJ0b0tqaTB0OEpnQi9XZzdhZnlmN1hjSjk4RDNxNzZza1Z0dU0vaFZ0?=
 =?utf-8?B?MG43NFpja3dBYkErNXhPRjhzZU1FYTkvcU1ReGkveW5KMTEzb0pjVllGYVhs?=
 =?utf-8?B?RVZwWTNzeHZ1NWFIN1kzRERpNE9PZDFZUHJZc3FaZU1DSmQwbVluWlhQeldm?=
 =?utf-8?B?NzJnSFkxMmkrNVNkUEdibElZK0JoTjc2NTcrYkJFRHFSbDJiR0o3dllPR2hm?=
 =?utf-8?B?VEpvYmlNVllJUmxzN0ZlcDMyTHNCc1Y0TnBLM0FGYjNZbjQzZi9iazJxT1pm?=
 =?utf-8?B?aUlDcitMaG5RczlzaWhMSUs2cjQrMk5CSXhVaFRjNlViSVIySFVIUkpkdWFt?=
 =?utf-8?B?T3NaMEZ2WGlBS08vWmZ3Q3lUNXgzT3M3S2JTazZHZzVrM1d1MDJQK0FrQ0p0?=
 =?utf-8?B?ZGFyUWg2V3dXeTU1RmRDcnJwcDE2UGRoNHA1eHB6TTN5VjNlVmgwaVlGZjhU?=
 =?utf-8?B?T0FzOVVVTkNpbmdTeFBjemx4bC9uZlVVeDlpNFVGc3J4VUpNak03L2pHbkdx?=
 =?utf-8?B?SHlMNkt2ZUg0U0ZmalZzdHRkM2xRVHVDQ1lVV0xNY3BCV1B0K2RnY3hvRHdM?=
 =?utf-8?B?bHFXVHhLYTFrWWpxdk11a1ExNzc2TDhyVTQzYVNaS1JiWWx1Ky9tWk82YnBO?=
 =?utf-8?B?MnZvVzE0REdhZ1lqZ0t3ajZ2TVl1bXFCOStUNFNWWksyZ1FGTWI3VTluNUoy?=
 =?utf-8?B?em5mekM0ZjQvSWdDM25WMG16SFJYNllNU0IrZ0gyQnN5dGFCc1JyV3hQYnF0?=
 =?utf-8?B?ampPcVdSVlBPQTF6bXpvalZSYUphcTY2cDh5RUNwalV6TnlxSnd4Mk4zOGNU?=
 =?utf-8?Q?b9Um/6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkpGNm1DSDNmbmswQWdCV0ExVFh5TlVTL0tKcjNlSWEzRDZCOTd0dlY4SThH?=
 =?utf-8?B?THpIRXlIYjRNNHlRUUgwVXo5K0VJYkNrdzNKYyt3SHBQWVQwQnl3andFNHpP?=
 =?utf-8?B?SGtVSjhySG1kN2Y1clNoK3I3eHk2VW11SXllWVN4ZEtvdlhTaFFzdEpFSlNv?=
 =?utf-8?B?eE9mc3JvbU5YZmVwTlZQK1p1Q01BQUNld29mME9pL1NIOVBWbmtDS1lBSXpZ?=
 =?utf-8?B?OUtJSnhzQXJxT0VkVFdwR0hDd09YdUJMd2JSL3lobjJSbmpzWjdLQ3psU0Np?=
 =?utf-8?B?c1dLMjRKMWRBUHN5YlZKQjNNT2lqd0ZhZTZ4dFcrUWkza1VneW5aR0Z3bFhC?=
 =?utf-8?B?QUtFMGp4LzdZOXJSemF0SDliaHlVMFBJeG9QZ3VHZVBnNUgzb0Q0WnFFT0hX?=
 =?utf-8?B?d1hGNjBzaVU3ZlVUV0UwQVRrMGVhZjhPWHFpZjdmUlFjOFNVaVBoYi9USkZJ?=
 =?utf-8?B?a0hZSzh1YkxVMnhjKzhQaCt3SHZwbWRGNHFScXg2cXQ3RHdSK0loZ0V1cmps?=
 =?utf-8?B?MUxKVHU0Z1J4TVp2L1BqTFIwR2hqRjczd2c5R2RocUhEeS9zSzJ1MitDVXZv?=
 =?utf-8?B?S1N2MUIrdGZYYmlNOWVET3JWOHdPTEJYTmhscDVzcDMzc1FOSUtDcGZYbFA3?=
 =?utf-8?B?QTR6ZHA3NjFXNUhqRUExU0lXYy9NeWlsR3RtQjF2bm5kQ0hxaFNBS0d6WEJF?=
 =?utf-8?B?cnIzOXprb05JQ1FYaXpyakNVajJ2SGxyUldkSmY0QU5qZW54Nng0WHZGVTM0?=
 =?utf-8?B?cXo3ZTdmOFl4K0dsOUZENm9PdVF0amdjZnd5dU5YMDNQcEVoUWJLaU8vajFJ?=
 =?utf-8?B?Rkh2MmFrLzRkRzNEYXkzT2NROVZMVmdqMGVLWHl1R3pUV1RuUk0zUzlwTVp3?=
 =?utf-8?B?WStLWmtCZyt2OEwxUmdCc3ZVa0loUk43WDlLMTF4VzlmRWNSa3N6T3hiMW5G?=
 =?utf-8?B?ZnJaN2liVmI5MHZEdStuYy9OSXhqdXF1aEQ0MkdBM1I2Q3NvNlpZQkNXeWVW?=
 =?utf-8?B?Rk1oS1VlQVowNUZQYysra0hLb2RSL2VIT2Z3eXkrNGRra2Z0Y0FrNkdPOThU?=
 =?utf-8?B?aGUvNmFoZXJvU1o1NlNoZHFTZTNiT0UvZnZWNW1xMitueFdLYXdDKy9IaDhF?=
 =?utf-8?B?NUhiZlZEVlN1emFvUlR5QlI2NXY4WE1uYzQwMDNuSzNrN2NDWGt1cDFxSmdH?=
 =?utf-8?B?Nm81U29LRGNlUzM4NFc0ZXhWWEgzUkMxdjlMVm9HRzlpNVZkU0ZCOWxSOFRN?=
 =?utf-8?B?aEJMUHRnRS9oNStmRzRKbFAyZk91M0FzQkpza25uSmdHMjFHa2h2bEd5Y0ky?=
 =?utf-8?B?aVFLcWZ4Z205aHJWWVpwVndQU0Q2NG5WODlNZmpsWTJiVGgwVStaWDF5NG1l?=
 =?utf-8?B?TzNGejBrSXZFeHhqV0xXZFFydXhFU1hSMEFUdndjd3VPVi9XVVJqREVhbmlN?=
 =?utf-8?B?d1lsb2tIZ3NtS0lVSTBrVWtmbEM3WHFZU1NVRVZkOEVPY1hTbmdLQzVkcnlr?=
 =?utf-8?B?aUl4REVHRTdPR2NnSm1xZytkU0QrMG1kN2VYYng2a05kKzFIY2kzeis4R2ZN?=
 =?utf-8?B?dzIyZEIxNFNCa1NuSDIramdoazJkajJiSnRaN3ArMlAzaHIxdTRlUzhFUUtZ?=
 =?utf-8?B?Ti9Nd1kxdDYxdkNMb1A4N0tpZzVUcDZTSU1DS3ZPbXQvaE9GTXk1UFJ3Ly9D?=
 =?utf-8?B?Z2pwdzc4RzczNGIza3k3ekRYcmk1dGNSQlFkWmVyRnZyNU5JK05tYjRrWS9s?=
 =?utf-8?B?NU5jd3c3cUhFZzFhUXQ5NDNXL3RBR2gzamVpR25la3hBa0lFNkp0TXRmU3Bx?=
 =?utf-8?B?cFFJVGxESGhSOFdiaGtRRUcyc3Z4YkI4ZHIwVW1meCtpNStiYTUrK3BoMG5X?=
 =?utf-8?B?MXdiK1VSeFJLTzVHbkp0QTdsNU55bmRHd3g3MzBZc1ZwRWQ5ekNuS2gzMjc5?=
 =?utf-8?B?NkYxK0tZYUV1SVdKRWVkbUZOcWhIa3Z2cnl0THBWc1BFbUVsWGVzWHR4Y3N6?=
 =?utf-8?B?WlJhenUzNkt4djBCSHAyUmpjalFnUnRJMzRQbDU2bkRxWkZRTDd0V1lHQTF5?=
 =?utf-8?B?R0ZWbDY2a1VLSnV3eWpaYVptNllPdE5uemw2ejZOc3RQNDhJREZBSjVtRjU1?=
 =?utf-8?Q?X2Vk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591b74d4-5b09-4df9-421b-08de3630038a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 08:01:37.8287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyntcDK63gRdP0dlvqsnpAealCSh6UXV4GdEams/NdHw/QvQrGnIF5qnfLUCTQp9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
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
Cg0KUmV2aWV3ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5J
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgNSwgMjAy
NSA4OjE2IFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0K
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNB
Tg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IFpob3UxLCBUYW8NCj4gPFRhby5a
aG91MUBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3JhczogUmVkdWNlIHN0YWNrIHVzYWdlIGluDQo+IHJh
c191bWNfaGFuZGxlX2JhZF9wYWdlcygpDQo+DQo+IHJhc191bWNfaGFuZGxlX2JhZF9wYWdlcygp
IGZ1bmN0aW9uIHVzZWQgYSBsYXJnZSBsb2NhbCBhcnJheToNCj4gICBzdHJ1Y3QgZWVwcm9tX3Vt
Y19yZWNvcmQgcmVjb3Jkc1tNQVhfRUNDX05VTV9QRVJfUkVUSVJFTUVOVF07DQo+DQo+IE1vdmUg
dGhpcyBhcnJheSBvZmYgdGhlIHN0YWNrIGJ5IGFsbG9jYXRpbmcgaXQgd2l0aCBrY2FsbG9jKCkg
YW5kIGZyZWVpbmcgaXQgYmVmb3JlDQo+IHJldHVybi4NCj4NCj4gVGhpcyByZWR1Y2VzIHRoZSBz
dGFjayBmcmFtZSBzaXplIG9mIHJhc191bWNfaGFuZGxlX2JhZF9wYWdlcygpIGFuZCBhdm9pZHMN
Cj4gdGhlIGZyYW1lIHNpemUgd2FybmluZy4NCj4NCj4gRml4ZXMgdGhlIGJlbG93Og0KPiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9yYXMvcmFzY29yZS9yYXNfdW1jLmM6NDk4OjU6IHdh
cm5pbmc6DQo+IHN0YWNrIGZyYW1lIHNpemUgKDEyMDgpIGV4Y2VlZHMgbGltaXQgKDEwMjQpIGlu
ICdyYXNfdW1jX2hhbmRsZV9iYWRfcGFnZXMnDQo+IFstV2ZyYW1lLWxhcmdlci10aGFuXQ0KPg0K
PiBDYzogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiBDYzogSGF3a2luZyBaaGFuZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNh
bi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9y
YXNjb3JlL3Jhc191bWMuYyB8IDMxICsrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzX3VtYy5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfdW1jLmMNCj4gaW5kZXggNGRhZTY0YzQyNGEy
Li42MDYxNzc2Yjg5NGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jh
c2NvcmUvcmFzX3VtYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUv
cmFzX3VtYy5jDQo+IEBAIC00OTcsMjcgKzQ5Nyw0NCBAQCBzdGF0aWMgaW50IHJhc191bWNfc2F2
ZV9iYWRfcGFnZXMoc3RydWN0DQo+IHJhc19jb3JlX2NvbnRleHQgKnJhc19jb3JlKQ0KPg0KPiAg
aW50IHJhc191bWNfaGFuZGxlX2JhZF9wYWdlcyhzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFz
X2NvcmUsIHZvaWQNCj4gKmRhdGEpICB7DQo+IC0gICAgIHN0cnVjdCBlZXByb21fdW1jX3JlY29y
ZA0KPiByZWNvcmRzW01BWF9FQ0NfTlVNX1BFUl9SRVRJUkVNRU5UXTsNCj4gKyAgICAgc3RydWN0
IGVlcHJvbV91bWNfcmVjb3JkICpyZWNvcmRzOw0KPiAgICAgICBpbnQgY291bnQsIHJldDsNCj4N
Cj4gKyAgICAgcmVjb3JkcyA9IGtjYWxsb2MoTUFYX0VDQ19OVU1fUEVSX1JFVElSRU1FTlQsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZigqcmVjb3JkcyksIEdGUF9LRVJORUwpOw0K
PiArICAgICBpZiAoIXJlY29yZHMpDQo+ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
ICsNCj4gKyAgICAgY291bnQgPSByYXNfdW1jX2dldF9uZXdfcmVjb3JkcyhyYXNfY29yZSwgcmVj
b3JkcywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNQVhfRUNDX05V
TV9QRVJfUkVUSVJFTUVOVCk7DQo+ICsNCj4gICAgICAgbWVtc2V0KHJlY29yZHMsIDAsIHNpemVv
ZihyZWNvcmRzKSk7DQo+IC0gICAgIGNvdW50ID0gcmFzX3VtY19nZXRfbmV3X3JlY29yZHMocmFz
X2NvcmUsIHJlY29yZHMsDQo+IEFSUkFZX1NJWkUocmVjb3JkcykpOw0KPiAtICAgICBpZiAoY291
bnQgPD0gMCkNCj4gLSAgICAgICAgICAgICByZXR1cm4gLUVOT0RBVEE7DQo+ICsgICAgIGNvdW50
ID0gcmFzX3VtY19nZXRfbmV3X3JlY29yZHMocmFzX2NvcmUsIHJlY29yZHMsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFYX0VDQ19OVU1fUEVSX1JFVElSRU1FTlQp
Ow0KPiArICAgICBpZiAoY291bnQgPD0gMCkgew0KPiArICAgICAgICAgICAgIHJldCA9IC1FTk9E
QVRBOw0KPiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgICB9DQo+DQo+ICAgICAgIHJl
dCA9IHJhc191bWNfYWRkX2JhZF9wYWdlcyhyYXNfY29yZSwgcmVjb3JkcywgY291bnQsIGZhbHNl
KTsNCj4gICAgICAgaWYgKHJldCkgew0KPiAgICAgICAgICAgICAgIFJBU19ERVZfRVJSKHJhc19j
b3JlLT5kZXYsICJGYWlsZWQgdG8gYWRkIHJhcyBiYWQNCj4gcGFnZSFcbiIpOw0KPiAtICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+
ICsgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICAgICAgIH0NCj4NCj4gICAgICAgcmV0ID0gcmFz
X3VtY19zYXZlX2JhZF9wYWdlcyhyYXNfY29yZSk7DQo+ICAgICAgIGlmIChyZXQpIHsNCj4gICAg
ICAgICAgICAgICBSQVNfREVWX0VSUihyYXNfY29yZS0+ZGV2LCAiRmFpbGVkIHRvIHNhdmUgcmFz
IGJhZA0KPiBwYWdlXG4iKTsNCj4gLSAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKyAg
ICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiAg
ICAgICB9DQo+DQo+IC0gICAgIHJldHVybiAwOw0KPiArICAgICByZXQgPSAwOw0KPiArDQo+ICtv
dXQ6DQo+ICsgICAgIGtmcmVlKHJlY29yZHMpOw0KPiArICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0K
Pg0KPiAgaW50IHJhc191bWNfc3dfaW5pdChzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2Nv
cmUpDQo+IC0tDQo+IDIuMzQuMQ0KDQo=
