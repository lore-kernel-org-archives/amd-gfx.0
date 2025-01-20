Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25996C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 13:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFDAC10E407;
	Mon, 20 Jan 2025 13:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iv7qHsul";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE98F10E407
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 13:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKeYxuq+GPXg7+ez7xybex8G3KLj3iDiFWQPhva5ARpHouT0epIFr5Yyd5QhCWsgAzS+9xj9Qu47zfW/vNwFoKcC1MS4vhOuFwAFNT5B7PeWA410qHcpgEc3etKAQzKmbRRbuNA/WGR7WO6aV7viDuWXoY+utGNa3OsHmUo4y8v1x8Kr61HjoQtUITAdCdkmxRzriqV45QsbYmhWEEJwW5yYL29XS5vDe4wLldrBguLwg4LRuFEuNT8VXsFhMaR7LXArSncYMQKH0c3d9Ri/8m9OmpEHH4L1S3vMBrTbhOmSm9xCw2MrmnQQkMP9NBcqLa6J8qLy5R1geuRMsxG20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHqTnqT8VLDa1wW54SoLVL3f0yyhtZITXTgCNnMh0+M=;
 b=lNTVS2vQDcPJkJK6pXB09GI6rySMFxqJF6BPV+gJNYG13KESNEX//p2nRqzqRZTBQETSS2qdkzHRxEwfNVjrroPsTsarGl1oeOe2WE3FMlycpxcK5BB11TUoaTddmr+BJEpao5T+2l4z7D0rVVoJ1WruzwRC0aoS8HordfmJ09ntNYQ6JMgh7lFcXgzOwYvS/xHnRVj4/HTEyWH+RM7SzNpSM8Fa0LQg0p0ScdtGFr9Izd4wQpGNwUx7zdjINeKgU621mgGuPMabHiSO+EOReS5uS4ERVXyo4ftiI3bRpambLg+jw+gtSaimptCll7Uij5Pk80P9Bybp1bb20bbEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHqTnqT8VLDa1wW54SoLVL3f0yyhtZITXTgCNnMh0+M=;
 b=iv7qHsulpcWV72K+rHSGeMprkC1+DE5fqhhvHp/kP1CYGETkXIWYXNiqSsSBE7w2XLiHbjJ+hkvxZEIIIw+voy4pRHpJNZphCQlBzMzSr5vZssDEO0TF830t4Ao4tX2vHwO307NjQdEsihIhJTy/16Sds9vtib8N9dtKxk5M9gA=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 13:17:09 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 13:17:09 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: Prevent null pointer dereference in
 GPU bandwidth calculation
Thread-Topic: [PATCH v2] drm/amd/amdgpu: Prevent null pointer dereference in
 GPU bandwidth calculation
Thread-Index: AQHbazzgvqgpO3yUeUixuNeB4ehkobMfpKaw
Date: Mon, 20 Jan 2025 13:17:09 +0000
Message-ID: <IA0PR12MB82080218AD8A0CFD4BF06AC190E72@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20250120123206.188410-1-srinivasan.shanmugam@amd.com>
 <20250120131137.213765-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250120131137.213765-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=c72dacd9-b630-4aca-9467-53f7a1ec91c3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-20T13:17:05Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|DS0PR12MB8217:EE_
x-ms-office365-filtering-correlation-id: af69962a-c03f-4075-a080-08dd3954be7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YnZpdy94M2V3T20zU0hpZWx1UVUvS1ZrV3VadnZMTjA3Slk1cGloSE9XbUc2?=
 =?utf-8?B?Wm9zMXlpdlVRVU56aE5nZlp3WWJBSE9IWTBHWEl4NUsvVjNyQ2pHQ2xPditx?=
 =?utf-8?B?ZENjaTBKTy9td084WlFPVE5VQWFFMHA4ZzVpTHAydmROQnlnRnN4OHhiajdK?=
 =?utf-8?B?MDk2UUtVQzVDeEpuclp3Z2tQYmlCWGkrSlNZZURUTlpPcWlNZStBQURNZGV5?=
 =?utf-8?B?c1RnbUpzb29KVXZkTmpIa1ZtODlnWWNTcUxMN0tjc0Y3bGtPTVVYVEE5UXFl?=
 =?utf-8?B?TCtCaTl0YVN0LzJJMVF6b001OGJMaWE5QnozY01hVnJRaU9ld2ZKb2R0V0cw?=
 =?utf-8?B?SHZ1Z2dVeEpRT1hjNXJIdkZlM1dERTJjODlPaWIwMU5TNm53WmlwOXA0MGFG?=
 =?utf-8?B?dk8vOFYxbjd5UzA4TVRYaVprVTMyTERCcWZjNlJxaE11OStDQkc1YnpUdnhm?=
 =?utf-8?B?TzM4aTVIcTFJTFVUZnFSU0EyVlkyaEdPR3lQSE01bjVmRkJkOWNCMUQydmxN?=
 =?utf-8?B?SDEyNE5zVTFUOW05Ny9ROHpRVHAzdC8vMWhGUUNVdEM4SzlpRWo0MEkyekJ3?=
 =?utf-8?B?MC95cFpRYXYxcTBuTkNMVGVOTmExT2h0bjlhcUtzNTFVWkJmTW9lTDAvNkRI?=
 =?utf-8?B?SVlWZDNKanBPekVBblozU3BPelB3S3BINld6MU9VSUJRcXFYZWc1ZHhZS3NO?=
 =?utf-8?B?enRnMC9qQTkxVndoaTIwUVp4bWRVZXhLOUVBZVc4dTN2NGdybnZNbm1OYWpz?=
 =?utf-8?B?ZjU4NVdLUzVCRGdKQlZKeXR3eHRtR0t1SzhCTWEvNTVTOW11NkJ4cU84MDZo?=
 =?utf-8?B?SUgzckpIUDVVSWRqb1dnK3JmZzVzTzRKV292UFBaTkltUjhQLzNId1ZJaWhS?=
 =?utf-8?B?QVFjL3Ywd0tSanMwTTR0YjhNZkJWU0d2QS9XQk92UjAwaDNldEx2Qlh1TFlG?=
 =?utf-8?B?ZWNncUE1ZkJFWkxtbkIxWEI1UXdSeVdXcFI4cWVOSFN4MjBleHgzZE5ZKzBE?=
 =?utf-8?B?TXhjcXNpRlFZM1hHUmYyS3NkNE1jSnVYZWdQK2QrY1B3dk10bjA0WHhvVWhU?=
 =?utf-8?B?R05KalQzNW1SVHJOT2tudk9ZTDB5TjdzLzNUeHhGQ2doelJNa1dJYS9BeWVW?=
 =?utf-8?B?S2ROUm1SdkFib0FPMkRGL1BPempkMTZrUi9FbnU5azFyY01jcFlOejcyYlRn?=
 =?utf-8?B?S2xEbDdUZXBUUHMrKy8xN2lKYmNNcEhYWG1hWGZlKzNXR3NnaEJvK2FDY2Uz?=
 =?utf-8?B?NTNjTkpEakJYUGZYNVRDU2Y5OTdJaE1YVlBjYVM1OUh2bmcwMnJSdXA1N1F6?=
 =?utf-8?B?elQxRUN3RXlVZ0pvak9MMXlFcWVrU3Y0b0ZoWXhUQy9SdmhycjR2WVppbTdZ?=
 =?utf-8?B?Ym52QW5IOUtieGp2MS9qcmQ4U0wvRzFDU2h5a2dVQmM1RFY5Mjh1SzZIUHlD?=
 =?utf-8?B?YmdBNDZGNUNXaXpiUGk3RDFCTUc5cDh4azlUUSs3ZG85ZlZNNmtzMEI5a051?=
 =?utf-8?B?QTM3aUJNRlA4TktDRkdQdnJwc3l5SzN3LzJEakdkcS93bGgxZDFzU0MzVlBi?=
 =?utf-8?B?b0V3UmtCekhST0pqdWZvK2lrQzYzOXpNTFhtc2xGL3FJdWloR0trUUtiVGF4?=
 =?utf-8?B?OWVIcERDREc3UXZUUk8zRXpydCtMRnk5SnpWTTlaMW1yT1hDbVFwaGJFek5V?=
 =?utf-8?B?RlZmL29ZYTNUcHVld05IV3hVdmY5TFUwdnhTVVIzS2ROaVorelJNZXhQR1oy?=
 =?utf-8?B?azJBUFBUSTJHQnlJb2pEV3pJb2JhQWIwbnF4VzFYMTZLY1psQ3Jmb2tYZlZO?=
 =?utf-8?B?SW5WWGJFYXhuVjNOWWRFbWtjZUhQazF6QkJVMnRialNHVW9pK2ZkVFJ1TlRv?=
 =?utf-8?B?SHl6dUZwSGFmMHFlbUJZRHZ0N2JoTnVPSkhPeVlhbGY4WThsSmNlaU5NRFZv?=
 =?utf-8?Q?zclIkC2gpI9bNSw2GO0nt3OvjsQSB/f5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OERVZU9XWjhockZQbFVWaWxxUlQ3UDFyYWFyRlBlMlR3c3liYzFOUGgwSkIv?=
 =?utf-8?B?TGFiTENWdzhJcENHL1FFMWQxUEV5Ykt3UWVZY1dERVZVVjVuNHUybEs4OEZV?=
 =?utf-8?B?NktoVTUzbXY3SU5rSW1lMWFWbU9NclQvUXlHR3RuRExSeks5UERBQ3RKNFN0?=
 =?utf-8?B?bVZ2VzBoSEZFcWtNc3h5WWJJYkU4V1JuRW9oK2pWMmdwS1JLUGtyYld3dEd1?=
 =?utf-8?B?UkZGVDdnU3IxTFh3bCtmWnhqWTB5WCtVdUpvbEJhUzVMZjJDTzZaUXk5ajk5?=
 =?utf-8?B?aFpjL0dZQnljTlU0UEF4VEJzRU1PcEV0UFp2YnpBQjd6aDE3ODRTbHlTTzRl?=
 =?utf-8?B?VmR5YlVZckpkRkNjaUlUOVYxZHIyV1hCV0F1ZW1uczJxWW05TnR0cjdaYzRE?=
 =?utf-8?B?cmtQL2VHaHVWRHZZRHdHcHEydnpwSWtjMTdhcFVlOUtPVXNieGtBU3hocm90?=
 =?utf-8?B?UEZyMC9Pbm4xN2R4TkJEY29BUHpOSnRrRlZKUWhNSWFNampTWjY4bTA1VjdP?=
 =?utf-8?B?aGp1ZHIwSWMvc2Nta00wWE9CdTFaVVNsTWVjMG1JdXNLc2djY0JwY0RUdWgw?=
 =?utf-8?B?TUZ0VzVpb0EwZUJNb3o4Y01reWs5Mlc2aWl5S1F4ZjlvOWx5RXp1WldVNUhY?=
 =?utf-8?B?dzRHc1cyc25pY09OakxFRXlzQ3FTdlExTzdXMkNBTlhiV041b0dXR0NielQ5?=
 =?utf-8?B?eDNYYWNXSGdSQS8yK3NiVHR0aGxNWmJRK3o4S1hNYzRRK1d0ZUxnVDh1QldT?=
 =?utf-8?B?bkxWbHAxb2xtQ2JsbGRkWlBMdzB0SVluMm9hRE9wdDFmc2drMWIyWVpLYldp?=
 =?utf-8?B?cERqTWZrR0xqODRjNkRVWERCYTJ3b2FBMGlpU3p6U2UvVTFYWEU3RHU3eDJT?=
 =?utf-8?B?dnd1SE42WG1ka0pCcDZudmdtdk5OajVBV3UybFdmenMwYjVaUlNDSmJWYTds?=
 =?utf-8?B?TUlDREZ3TlJoSGlOWklidTBDdEcycVl5NTkxdlJuaDVqYWhtQ2ZyZGJSVU9Z?=
 =?utf-8?B?cFJCZTdkczF4WTkxZmhycWN6TnRSSUdlVmpnRzVrcyswZElaL25tT0o5dWp5?=
 =?utf-8?B?K2ltT1QvTXNudkNQVjVLTXVXRjVpdkppelJjRmFycDgvRllxNkRTMWpMTk01?=
 =?utf-8?B?eXVaNTZrRnpIOEtqeEZPMllnZTAwcEtQdkxUcXNVVU5EZjFHVVdkK0lhNjJv?=
 =?utf-8?B?MzBwUVpHSVBwTW4yb0s4b3JTUm14QS9NVGdqRURCSmgvU3NBNUJsRFdtQWNH?=
 =?utf-8?B?TnUwTGc4bGlqSkxQdHJ4Tk1FTVNnSjR4SURWT2h0dEwyZlR3R2krVGdzSll6?=
 =?utf-8?B?SThlZXlVV3R3MFlUTXM4NUN2ay9SbUlEWnF3UVpUR29WWThwaTQzSXcxZ0Nu?=
 =?utf-8?B?WDlmS0tEM054RVY5VThKRm5mQmR3cEprRkMxcFFvcW5UdFF2dzZQYjhMOGFz?=
 =?utf-8?B?L0FBK2QrRmgrblMyTjhNT0o0aW9nRFFmMkRJdkUvRjhFMVZjODRrUUtLaUZX?=
 =?utf-8?B?QkZvakxCdDhCa1ptLzBvbFV4VXFtN2dnVSszRVFUUitGc0hDdDVmVi9TK1lu?=
 =?utf-8?B?ZDRIUzFqd1lVZ0RUT01XQTFrVlZNai9TeVl2bVI4enplYUhQQUgzT0lJSE1N?=
 =?utf-8?B?eUlDTkRuREpoeE5FLzVJeVFtNzZpQXF6dFBVdUtLTm0rRGcvZGplbitJNnZy?=
 =?utf-8?B?NVFYTmJ1ZXNDRFQzZGVlZHA4d2Evb21ncTd1RzUwd3ZzWTFjWE1UL29vNW1k?=
 =?utf-8?B?blJsMEM1YWdkKzNuamIyWmtXcWNVaGF2NXViNVVPYVYrV0VxTDRuYXlPcEVW?=
 =?utf-8?B?ejZmUUhKU240d2I1UVd4Z0VSbmFtaHd0L3lYTnVIa1NPTnFGQVRyUlJPaDJ6?=
 =?utf-8?B?L09sZ1hEUFJ0U2sxM1RiOVFHWVM3aXVjWmFYaHpkcFRWZjhGS0JCVFFoR0ZQ?=
 =?utf-8?B?SmJocTI4R2E3a24zNE5iUWxLVVdQY3lEeU05RWFXSk5Pbm9NR1RPclV1RTNV?=
 =?utf-8?B?cGhGSUd3R2E2VjY3OFRPMDBFekNwL0J6dm1LWGVvYXdxSS9QMDR1RnBqV1U3?=
 =?utf-8?B?Z2xGb2tGWXRJd3E1anRYb2lIeU1rczJaRi9PNzhHOHJvelN1MFR5VFpCYVQ4?=
 =?utf-8?Q?H7oU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af69962a-c03f-4075-a080-08dd3954be7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 13:17:09.2442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPgF0Bv7LE1s+yi+WZ2MbzI/sbFPttJ9h4hls18kZl0tH1fJl0lZcbdODGdCRpEzHNEoFAQjaiPLjxy9nJ4qxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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

W1B1YmxpY10NCg0KUGxzIGlnbm9yZSB2MiwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNv
bT4NClNlbnQ6IE1vbmRheSwgSmFudWFyeSAyMCwgMjAyNSA2OjQyIFBNDQpUbzogS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
PjsgRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPjsgTGF6YXIsIExpam8g
PExpam8uTGF6YXJAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2FtZC9hbWRncHU6
IFByZXZlbnQgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIEdQVSBiYW5kd2lkdGggY2FsY3Vs
YXRpb24NCg0KSWYgdGhlIHBhcmVudCBpcyBOVUxMLCBhZGV2LT5wZGV2IGlzIHVzZWQgdG8gcmV0
cmlldmUgdGhlIFBDSWUgc3BlZWQgYW5kIHdpZHRoLCBlbnN1cmluZyB0aGF0IHRoZSBmdW5jdGlv
biBjYW4gc3RpbGwgZGV0ZXJtaW5lIHRoZXNlIGNhcGFiaWxpdGllcyBmcm9tIHRoZSBkZXZpY2Ug
aXRzZWxmLg0KDQpGaXhlcyB0aGUgYmVsb3c6DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmM6NjE5MyBhbWRncHVfZGV2aWNlX2dwdV9iYW5kd2lkdGgoKQ0KICAgICAg
ICBlcnJvcjogd2UgcHJldmlvdXNseSBhc3N1bWVkICdwYXJlbnQnIGNvdWxkIGJlIG51bGwgKHNl
ZSBsaW5lIDYxODApDQoNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Yw0KICAgIDYxNzAgc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV9ncHVfYmFuZHdpZHRoKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LA0KICAgIDYxNzEgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVudW0gcGNpX2J1c19zcGVlZCAqc3BlZWQsDQogICAgNjE3MiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBwY2llX2xpbmtfd2lkdGgg
KndpZHRoKQ0KICAgIDYxNzMgew0KICAgIDYxNzQgICAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGFy
ZW50ID0gYWRldi0+cGRldjsNCiAgICA2MTc1DQogICAgNjE3NiAgICAgICAgIGlmICghc3BlZWQg
fHwgIXdpZHRoKQ0KICAgIDYxNzcgICAgICAgICAgICAgICAgIHJldHVybjsNCiAgICA2MTc4DQog
ICAgNjE3OSAgICAgICAgIHBhcmVudCA9IHBjaV91cHN0cmVhbV9icmlkZ2UocGFyZW50KTsNCiAg
ICA2MTgwICAgICAgICAgaWYgKHBhcmVudCAmJiBwYXJlbnQtPnZlbmRvciA9PSBQQ0lfVkVORE9S
X0lEX0FUSSkgew0KICAgICAgICAgICAgICAgICAgICAgXl5eXl5eDQpJZiBwYXJlbnQgaXMgTlVM
TA0KDQogICAgNjE4MSAgICAgICAgICAgICAgICAgLyogdXNlIHRoZSB1cHN0cmVhbS9kb3duc3Ry
ZWFtIHN3aXRjaGVzIGludGVybmFsIHRvIGRHUFUgKi8NCiAgICA2MTgyICAgICAgICAgICAgICAg
ICAqc3BlZWQgPSBwY2llX2dldF9zcGVlZF9jYXAocGFyZW50KTsNCiAgICA2MTgzICAgICAgICAg
ICAgICAgICAqd2lkdGggPSBwY2llX2dldF93aWR0aF9jYXAocGFyZW50KTsNCiAgICA2MTg0ICAg
ICAgICAgICAgICAgICB3aGlsZSAoKHBhcmVudCA9IHBjaV91cHN0cmVhbV9icmlkZ2UocGFyZW50
KSkpIHsNCiAgICA2MTg1ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChwYXJlbnQtPnZlbmRv
ciA9PSBQQ0lfVkVORE9SX0lEX0FUSSkgew0KICAgIDYxODYgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAvKiB1c2UgdGhlIHVwc3RyZWFtL2Rvd25zdHJlYW0gc3dpdGNoZXMgaW50ZXJu
YWwgdG8gZEdQVSAqLw0KICAgIDYxODcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
c3BlZWQgPSBwY2llX2dldF9zcGVlZF9jYXAocGFyZW50KTsNCiAgICA2MTg4ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKndpZHRoID0gcGNpZV9nZXRfd2lkdGhfY2FwKHBhcmVudCk7
DQogICAgNjE4OSAgICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgNjE5MCAgICAgICAgICAg
ICAgICAgfQ0KICAgIDYxOTEgICAgICAgICB9IGVsc2Ugew0KICAgIDYxOTIgICAgICAgICAgICAg
ICAgIC8qIHVzZSB0aGUgZGV2aWNlIGl0c2VsZiAqLw0KLS0+IDYxOTMgICAgICAgICAgICAgICAg
ICpzcGVlZCA9IHBjaWVfZ2V0X3NwZWVkX2NhcChwYXJlbnQpOw0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl4gVGhlbiB3ZSBhcmUgdG9h
c3RlZCBoZXJlLg0KDQogICAgNjE5NCAgICAgICAgICAgICAgICAgKndpZHRoID0gcGNpZV9nZXRf
d2lkdGhfY2FwKHBhcmVudCk7DQogICAgNjE5NSAgICAgICAgIH0NCiAgICA2MTk2IH0NCg0KRml4
ZXM6IDllNDI0YTVkOTA4NyAoImRybS9hbWRncHU6IGNhY2hlIGdwdSBwY2llIGxpbmsgd2lkdGgi
KQ0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCkNjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpSZXBvcnRlZC1ieTogRGFu
IENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KU2lnbmVkLW9mZi1ieTogU3Jp
bml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQpTdWdnZXN0
ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCi0tLQ0KdjI6IFVzZSB0aGUg
ZGV2aWNlIGl0c2VsZiBpZiBubyB1cHN0cmVhbSBicmlkZ2UgaXMgZm91bmQgKExpam8pDQoNCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA3ICsrKysrKy0NCiAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCmluZGV4IDQ2YWYwN2ZhZjhjOC4u
M2RmNTI0N2IxMjIxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCkBAIC02MTczLDggKzYxNzMsMTMgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RldmljZV9n
cHVfYmFuZHdpZHRoKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KICAgICAgICBpZiAoIXNw
ZWVkIHx8ICF3aWR0aCkNCiAgICAgICAgICAgICAgICByZXR1cm47DQoNCisgICAgICAgaWYgKCFw
YXJlbnQpIHsNCisgICAgICAgICAgICAgICAvKiBVc2UgdGhlIGRldmljZSBpdHNlbGYgaWYgbm8g
dXBzdHJlYW0gYnJpZGdlIGlzIGZvdW5kICovDQorICAgICAgICAgICAgICAgcGFyZW50ID0gYWRl
di0+cGRldjsNCisgICAgICAgfQ0KKw0KICAgICAgICBwYXJlbnQgPSBwY2lfdXBzdHJlYW1fYnJp
ZGdlKHBhcmVudCk7DQotICAgICAgIGlmIChwYXJlbnQgJiYgcGFyZW50LT52ZW5kb3IgPT0gUENJ
X1ZFTkRPUl9JRF9BVEkpIHsNCisgICAgICAgaWYgKHBhcmVudC0+dmVuZG9yID09IFBDSV9WRU5E
T1JfSURfQVRJKSB7DQogICAgICAgICAgICAgICAgLyogdXNlIHRoZSB1cHN0cmVhbS9kb3duc3Ry
ZWFtIHN3aXRjaGVzIGludGVybmFsIHRvIGRHUFUgKi8NCiAgICAgICAgICAgICAgICAqc3BlZWQg
PSBwY2llX2dldF9zcGVlZF9jYXAocGFyZW50KTsNCiAgICAgICAgICAgICAgICAqd2lkdGggPSBw
Y2llX2dldF93aWR0aF9jYXAocGFyZW50KTsNCi0tDQoyLjM0LjENCg0K
