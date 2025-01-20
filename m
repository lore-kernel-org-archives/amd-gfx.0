Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117B1C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 20:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BF310E48B;
	Mon, 20 Jan 2025 20:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="is8/Q6bJ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD2410E0AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 20:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDr7DymgQfMman/U3gP250bhQcyzj/24cTH8XyKY/MSe/S3k0nKXv7Qz85X9sG+l4CnbFyESKTHSBDRNSm/zYrWv/zg2iwN7EXqqAvvyJjgkZoN4hV6Z0S/EgOcGSojVECrmMTTaZY+N50ZsWdngF6oi4MMiNta7sXQO5ZRphDsB+Yu0L6zzgqNN1GhcjLUhXK4L6eYQv0NOmt8NuarZc3mINifq8cT14L5MIsdMtRMABfMU/Mqp+VtwResvbBQpG73AE/wfRumLNN0qRalCQrPy5Qg70Z19Iy9ekrrMTzFC+hOsMbNgEQBhsWF4h9Dl7FCY+xUrhusaZwo2anvG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfwA+rSKTf8sOYUYgcfPjrtE4b9W1Dd/DohjXRGubr4=;
 b=NIONGLnMGFL6C4X4CvnHhNfwvW/HcY/FtYbEyIJfdtVvG/IHbWksdU6eZ4ZNCsz/HeRO8dv04lJUbM2sZL85kM7KyNEkGDySTdLgZB87p5mdhgVCESozxtgrVVrbZryRLtlaIEnzPkjqwl2c+SLLjNpsmEeEoy2GP1/Sic9tOcLb3hLrAIT9Aj9yxagrXj/iXUyGU5HbGsBR1W1UJNoQvzPdtsEYlTlEjyHvyu1W+elkndynu4Zo+buL09+YlzjAgfQxXbsGEEX9rTsNBc0AU1Lb1eDgVZbtayvi5ryEx3cVRZ0qEFG3LT3SUx5gHVNzhpFhPe88zSCw4ncZn9vtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfwA+rSKTf8sOYUYgcfPjrtE4b9W1Dd/DohjXRGubr4=;
 b=is8/Q6bJ7mIjUfwmaMu4K6TM8adcIGNCtgaaPryj3adspodHOhn7tjQWp2JD51Wl/sqZn0ZeHbTU3WUVlzfdXzi1KfdpwWSrG/T7T1Qnobffwvs/pcwAA4ZVsRtqgLL/bQ3dlsvkYkxrg+lKiU5zmNnQ9bEhQfyzNRQAkO/G9jE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 20:50:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 20:50:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Pavel Nikulin <pavel@noa-labs.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
Thread-Topic: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no
 one cares.
Thread-Index: AQHbaOgEji4ufK1b6keM0XikT3ScGbMbAMYAgAMgawCAAF3PgIABqLWA
Date: Mon, 20 Jan 2025 20:50:37 +0000
Message-ID: <BL1PR12MB514453D8463E8CB1C2997464F7E72@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <CAG-pW8H7WOi7JiN5zHdCo2MX3w0c8yEuJ=SFGV+BPbFuBK0Spg@mail.gmail.com>
 <CADnq5_Pj0NLqwiooxyXULERo8YQTh1TN76FVnM9MZt3FCMFSwg@mail.gmail.com>
 <CAG-pW8GaL+JSGSmu-G3qbskPoHe=iU4usMP293RB7gr5VVbUQg@mail.gmail.com>
 <CAG-pW8Fe95BTyw2pVTrKJQJs0MnFshXGztWnLk9dqx8B1V6X1g@mail.gmail.com>
In-Reply-To: <CAG-pW8Fe95BTyw2pVTrKJQJs0MnFshXGztWnLk9dqx8B1V6X1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=371a6ce4-ba06-4f38-a920-67fa65909290;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-20T20:50:31Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB8339:EE_
x-ms-office365-filtering-correlation-id: 3691af02-c958-4405-d6a8-08dd3994179c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aTZMQjR1SE1TVWtXMTdpbElPTG93SFcvOFBBVDJLVi9aLzgvYmVFU1NQa0tK?=
 =?utf-8?B?QW1lb292d1lXWlBrSTVHQW9xdVF1VHRibzJ3R0twQk9rNVh1dlZaVlRnQnov?=
 =?utf-8?B?dFNrcmpoU0RPTERrVzEwdWJicEZzYk0ycTZ3WFNkWWNKM2F2d0xObXNveVNH?=
 =?utf-8?B?Rnd0U3ZTb0txMWY2NTlxWE9WUkQzU2tWanRDdnphOGRKQW55SGFTc3pJUi90?=
 =?utf-8?B?QkFINm9LM2U3RFc4VlhpMHQ0WEllbXFNNWt6N1J4bENTbCtVWDBQcnNqNkJH?=
 =?utf-8?B?NmJhcTJWd3lmbUIxamJTWTdVODE4RlptT3QydFRiMUI0bkdzZEZnVEloTGNE?=
 =?utf-8?B?aDNCbm5Kd1hDVzhJU1JSQk9pR1NLRVA5SVJCK0ZIbUVtSkN0L0RCdm1jWjdz?=
 =?utf-8?B?aWVib0hLKzU2eW94MnFSVnE4TU9TMmdrakpDUmQ1RmMrR2gzOE1QZlRLV3Yy?=
 =?utf-8?B?QmVPZ2lyZXMxL0xvMXRaa2tYYUltdGpERXBLOVdwbk5ZTFl6cmhVdnZPR2VE?=
 =?utf-8?B?Z2tZaHRYemdxeG5KSzY0UCtWd0YzS1FuK3hOY3N0dUMwMWNDYzVLaHNTSWVq?=
 =?utf-8?B?c3psVTYzVHYwRVZlYlhRdnZkanBGa2dBYldsblpCSXR0ZSs2RGpZQ3VGRkQr?=
 =?utf-8?B?OFpnanYrRDNocXdqcW1qajlsY1E3RVM1KzkxODlNcUhuSXgzd1kyU3BWUnht?=
 =?utf-8?B?Y29OSlpVdVhVWDVXUWFJVFN0bUZUTWd3cE85TU9tZ2EzUk9IQisxanJYY3RH?=
 =?utf-8?B?Y1JwK2ZkUThKYTF1UzNSNHBWUSt4VGRGVE9rSmJ5djF0TzBtMHFtZitraW1w?=
 =?utf-8?B?MzRoaVBMemVkaEJmRjFSYnJYZ3pNOEYrOTVTb0Z2bFB2bVVzNmlRRFhoeUx3?=
 =?utf-8?B?eTZsZXFpY1ZoKytpM0c1dlhNeGJqVjRzUllVTnNiLy9FbUJ0Rm5SRzZ4TFUz?=
 =?utf-8?B?akthMldoMTJReTVuRGNmRkEvNkkvYVVaMmJWSVVkcUZELzljeGVXaDgzV1Va?=
 =?utf-8?B?U205V3NPbFhpTFlGOWI0NVB6WkJiaTJPb1RnVkdXMy85RVg5c3BzSmhtNVdu?=
 =?utf-8?B?M0FwWTVOTGpwWUVnK29wSThhQ00ramYxbkdoNHk0anNLK2luV2Z2VGxZSHBw?=
 =?utf-8?B?blJrZGxIek13OEd3bFlpWnFOdkthSlc4dW5xUC9BVVVIblZpYUZwM1RtdkJL?=
 =?utf-8?B?Tyswa2FrbS9RV3ZwNDlscnd4Mk83b3ZjZE9kMWxmdkhvWStkZmdCWCtxVHVx?=
 =?utf-8?B?WFJSNUdIbHhFVWtHU0pwQnFOMWRqODF4ZkFmcS9NazNRZHIvWXpYa2Mzajlr?=
 =?utf-8?B?V3BsZ3N2cTdXbmpKQlZ0NkNlTkkxYmM2eGRuUC83RDRaaDdzSVJjRVRxL1lH?=
 =?utf-8?B?YkxjNWVJUDM1RWhXNUJMSjNqM2hMOXVaV0JGMEFDMjdycEhzZ053dGlNSk5C?=
 =?utf-8?B?T1h5RmMzUytBTkNxaGRVQkhtaHNidXlWL3g1VktKZUdTSjE0LyszOE9NQldz?=
 =?utf-8?B?MkViTHBNZTA5VWRxVlVEc29qMnRxOWxGV2lhVXI1NE5zVTFqRGwzQTVyc3I3?=
 =?utf-8?B?WEJ0T1BmejlhcDllbXdjdE0rSDBzVExKWGVtdFpreENKeHgrSk05eHhPVThF?=
 =?utf-8?B?UHdqbmVjeE5LNEU0cGhxSnQramR3Q0w2aUlKZHZiUmh3bjhQeDExeDZkSWhG?=
 =?utf-8?B?VFBKVHpvcTJSSE5aS1BndE16MDNnZlBnUGd4ZUt0ZmkzaWNnbFR4eU5HaVEy?=
 =?utf-8?B?MnNkbCsvQ3B1SVlzei9Zakd4aGU5R1JIRDdNN3ZwOEpxR3dGMHJKRDBOWTQ5?=
 =?utf-8?B?M21WNktNSURiOVg3ckNyRWZaSFJ3WUQ3aHpybXhWSTBpdWlNbCt1dlhsOXdi?=
 =?utf-8?Q?i3oaDZ70oLhfz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3J1TkVHOTQwVllnQVRFYjhnMU4zYi9WMU0wUnJrWkk2WjlwOHU1WEpPSFFH?=
 =?utf-8?B?OGpPSXZWVkVSVHhpVEdPV1dVZnA5c0lsaXR6V21pUG5oelcrL3NCdWdZa1pN?=
 =?utf-8?B?ZnBLT3pOTldqNE5uWXJNdmF6eUpxNWUvYk14NS9Mb0JmeXJBUzJ6T3V1YUw1?=
 =?utf-8?B?ZWplNHhVRlpFVHRzeWZqcDVXb3NleFlLaWRjUEpCZmI5dkI1NFZUNmcxSEZV?=
 =?utf-8?B?S2tGY1Z6cXlkSHQ3NnFDRHRhUzdBMEFUeVVBaWFXb21paGdzOFk5WW5WL0Nh?=
 =?utf-8?B?OUpHWVhsSjNTRkpJRk04M1JETCtOZFRjWnY2eVFOZjJCSVNrM1RHVWt4Vjc3?=
 =?utf-8?B?Vmp0bDNDdS8xa28rMTY4d3N6eEF0b1ZmT2NPVWpodG1ZM1dFbGlydi9vckhG?=
 =?utf-8?B?NHhTSEtxOFcrY0YxbGh2UVBSSjlLbWp1cXV3SzNvMjdZamdaY2FRbmQyTDdx?=
 =?utf-8?B?MW1tSFpSZlJpVzJONExrRDlONWxHN1RlQzlSUHJIMlhXSzkra0wwamlYdTJl?=
 =?utf-8?B?Ujg3bVdKTW52QzI2TkZyL2pBYlp4YTV1UnQ3VEM2Um5kc2szQlgwVlNKcTRP?=
 =?utf-8?B?MklML3JLZVk3VHZuOUUwSTVMRktjMVd0V3FIVEc3WEY1dEtUMzJJSVBJMDRs?=
 =?utf-8?B?dmNTdTBaVitjQ2RTSkVkTG5ZUUJ5T0ZkUHEyWFZnMVVnSzAwcjRrdDNZOWtO?=
 =?utf-8?B?aEhadlpCMWc3cUdvQXRleHVsTlE1czZEQzFoajJTYUszV2VPYlZ0UWlKQ2da?=
 =?utf-8?B?K2RqbkNzZmhYV0ZZZFVnKzEzQjBJeFpzcFBIQW1HN21JSnJDK0RON251TG5D?=
 =?utf-8?B?dWIvSGtwT3pFb2lXYXQwMk8veEwxQm1NOHNWWVh0MlBQcU5QNXQvelZOYTVQ?=
 =?utf-8?B?YVd0ZnE1NUpRcXdiMGFIZVR0clR2dFAvaGVTbW9IZmlldmJCNkE2Z1l4THlO?=
 =?utf-8?B?cEExbEZYeGh6VTJicnhSbHpsN0oyZHJMSm1GdHc2U3lOM2ZjNThBUEp4RnJw?=
 =?utf-8?B?Ym4zVlRmSDlYbTZ5RTB4RXA5VTRSWEgxZENZVHJRV2FheTQxSEp3Mk5sY05s?=
 =?utf-8?B?dEtINUQ5T3FZNnhqN3E3cHdsb0lYT3RPbkkzaHlmaFYzVmpGd25FcGw1T3Qx?=
 =?utf-8?B?aGM1bDZnTWRJQkcrT044N0R6RGJPMEtMV2ZuOERmVVE0Vk9UVmdON25jZEpE?=
 =?utf-8?B?WFk2eTF1REh1a3VCRXZtZEhGQncxZ3MycFpUVFhYeExPQ0VEdEhIYzVvV2dw?=
 =?utf-8?B?bThsZDcrNEd4RnUxdnZtenUvYTBYODlBMzRIcGs3TUxyNHRRV01qalFwTWMx?=
 =?utf-8?B?VkFLUWcxNWxYS1BkMWtySVVkTThHY3BOSEdqWEtTT3NxVi9nZVo4ek1nZWl6?=
 =?utf-8?B?SlVudFU4bVNrVjF1SFdZMWR1K1Y2MnRYcTNjRHZmaDdiL3B3WHdXZEZuWVZO?=
 =?utf-8?B?ajl0UG8rTnVBUFhyaGNwWU5rWGsvUlBuR01UOVJJeEJUSGFSN0NMVllVWHlM?=
 =?utf-8?B?MGhvSWx0TW4vaHBXamN6TDdCUnRldVpBVWR3SUR2R2NDMUVWOXFmTmlLMzhR?=
 =?utf-8?B?RzE3ZWE3enR3akNZUTB4RWVneGdCVzJ6UjQ3WWhKOXkvZ0taWDZhZDdFTC93?=
 =?utf-8?B?SzV4V3I4U1N4b3pzNEZlTktWQ3dYaUkreEdVL1VkaEFINjF1VHBheGNLT3pn?=
 =?utf-8?B?dFdLa0tEZDBncElhZUU5N3ZPZHpWMkgrMHZHL1Qva09yZU1ZenJMaUFHekdm?=
 =?utf-8?B?dTdYN21BZ2R3b2tubE9UTHRzVE9saU9aV2w3ellHS2lxNFEwU3BNR0V6eWw3?=
 =?utf-8?B?SGVhOFhnT0hiTHJqd3dvYU9JTW5UNnU5OUZvak95eUVpK1Z0d2MvM0hoUTBK?=
 =?utf-8?B?TVI3Z3hKSTluUWFFUXA2QXBiYVhzT25nNEkzNlpnNUlqejVNVUhtKy9TMnl6?=
 =?utf-8?B?Mm1EUmRnM3ZDcWlHWFFzcjZDWjNqTEJGeEMrcGtISTZsRGF5VVdjOTJXbnI2?=
 =?utf-8?B?SjRMRFFyZGYzMFB6elBad3JJSFc3Z2dwTGd0REdIQVVkN0p3dUcyb3lmcXhw?=
 =?utf-8?B?NGJZUldaYXJEWVdETWR5NVYyUG5lVmtMTEVqWXZJVm1sTnNNRnRjSVlacGN1?=
 =?utf-8?Q?+nZ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3691af02-c958-4405-d6a8-08dd3994179c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 20:50:37.0417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3J7hIxV1KBeeNtGuffXHujp8oHWzAVzkQ2BW/dp0vvL1IUzCjASWrbe7l0VXgfffZ+1/jxv3sPvoVswRp7Yrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgUGF2
ZWwNCj4gTmlrdWxpbg0KPiBTZW50OiBTdW5kYXksIEphbnVhcnkgMTksIDIwMjUgMjoyOSBQTQ0K
PiBUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogZHJtL2FtZGdwdTogQU1ER1BV
IHVudXNhYmxlIHNpbmNlIDYuMTIuMSBhbmQgaXQgbG9va3MgbGlrZSBubyBvbmUNCj4gY2FyZXMu
DQo+DQo+IE9uIFN1biwgSmFuIDE5LCAyMDI1IGF0IDU6NTPigK9QTSBQYXZlbCBOaWt1bGluIDxw
YXZlbEBub2EtbGFicy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJpLCBKYW4gMTcsIDIwMjUg
YXQgNjowOOKAr1BNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToN
Cj4gPiA+DQo+ID4gPiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCA3OjI34oCvQU0gUGF2ZWwgTmlr
dWxpbiA8cGF2ZWxAbm9hLWxhYnMuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGlu
ayBpdCBwZXJzaXN0cyBhcyBvZiA2LjEyLjkgYW5kIHRvZGF5J3MgZmlybXdhcmUgdmVyc2lvbiBm
cm9tIGdpdC4NCj4gPiA+ID4NCj4gPiA+ID4gSGFyZHdhcmUgQXN1cyB1bTU2MC42DQo+ID4gPiA+
DQo+ID4gPiA+IEl0IG9ubHkgaGFwcGVucyB3aGVuIHRoZSBBQyBhZGFwdG9yIGlzIGRpc2Nvbm5l
Y3RlZCwgYW5kIHRoZQ0KPiA+ID4gPiBzY3JlZW4gcmVmcmVzaCBmcmVxdWVuY3kgaXMgc2V0IHRv
IDEyMGh6LiBJdCBkb2VzIG5vdCBoYXBwZW4gb24NCj4gPiA+ID4gYW55IG90aGVyIHJlZnJlc2gg
ZnJlcXVlbmN5LCBvciB3aGVuIHRoZSBjaGFyZ2VyIGlzIGNvbm5lY3RlZC4NCj4gPiA+ID4NCj4g
PiA+ID4gSXQgbWlnaHQgYmUgaGFwcGVuaW5nIGluIFdpbmRvd3MsIGJ1dCBhdCBtdWNoIGxvd2Vy
IHJhdGUsIGxpa2UNCj4gPiA+ID4gb25jZSBpbiBhIG1vbnRoLiBUaGUgd2luZG93cyB2ZXJzaW9u
IG1pZ2h0IGJlIGFwcGx5aW5nIHNvbWUgbWl0aWdhdGlvbnMuDQo+ID4gPiA+DQo+ID4gPiA+IFRy
eWluZyB0byBjYXRjaCB3aGF0IG1heSBiZSBhIHByZWx1ZGUgdG8gaGFuZyBuZXZlciB3b3JrZWQu
IEl0J3MNCj4gPiA+ID4ganVzdCBpbnN0YWhhbmcsIHdpdGhvdXQgcGFuaWMsIG9yIGFueXRoaW5n
LiBJIGNhbm5vdCBkZWJ1ZyBpdA0KPiA+ID4gPiB3aXRob3V0IEpUQUdpbmcgdGhlIENQVSwgZm9y
IHdoaWNoIEkgaGF2ZSBubyBlcXVpcG1lbnQsIG5vciBhbSBJDQo+ID4gPiA+IHN1cmUgaWYgdGhl
cmUgYXJlIGV2ZW4gSlRBRyBoZWFkZXJzIGV4cG9zZWQgb24gdGhlIGxhcHRvcCBtb3RoZXJib2Fy
ZC4NCj4gPiA+DQo+ID4gPiBQbGVhc2UgZmlsZSBhIGJ1ZyByZXBvcnQgYW5kIGF0dGFjaCB5b3Vy
IGRtZXNnIG91dHB1dC4NCj4gPiA+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0v
YW1kLy0vaXNzdWVzDQo+ID4gPg0KPiA+ID4gQWxleA0KPiA+DQo+ID4gVW5mb3J0dW5hdGVseSwg
d2hhdCBJIHdvdWxkIGhhdmUgd291bGQgYmUgdGhlIHNhbWUgZG1lc2cgYXMgYW55b25lDQo+ID4g
ZWxzZSwgaG93ZXZlciBJIGhhdmUgbWFkZSBmb2xsb3dpbmcgb2JzZXJ2YXRpb25zOg0KPiA+DQo+
ID4gRGlzYWJsaW5nIFBTUiB3aXRoIGRlYnVnIG1hc2sgbWFrZXMgaXQgc3RhYmxlLg0KPiA+DQo+
ID4gSWYgSSBzZXQgdGhlIHJlZnJlc2ggZnJlcXVlbmN5IHRvIDYwSHosIHRoZSBscGRkciBtZW1v
cnkgY2xvY2tzIHdpZ2dsZQ0KPiA+IGFyb3VuZCA2MDBtSHosIGFuZCBrZWVwIGdvaW5nIGJhY2sg
YW5kIGZvcnRoIChzcHJlYWQgc3BlY3RydW0NCj4gPiB3b3JraW5nLikNCj4gPg0KPiA+IElmIEkg
c3dpdGNoIHRvIGFueSBvdGhlciBmcmVxdWVuY3ksIHRoZXkgc3RheSBzdGFibHkgYXQgOTM3bWh6
IChzcHJlYWQNCj4gPiBzcGVjdHJ1bSBzdG9wcyB3b3JraW5nLCkgYW5kIGhhbmdzIGhhcHBlbi4N
Cj4gPg0KPiA+IElmIEkgZGlzY29ubmVjdCBhbnRlbm5hcyBmcm9tIHRoZSBNVDc5MjUgV2lGaSBt
b2R1bGUsIHRoZSBpc3N1ZXMgYXJlDQo+ID4gZ29uZSAoYXMgd2VsbCBhcyB0aGUgd2lmaSBjb25u
ZWN0aXZpdHkuKQ0KPiA+DQo+ID4gSWYgSSBSRktJTEwgdGhlIG10NzkyNSwgYm90aCB3aWZpLCBh
bmQgYmx1ZXRvb3RoLCBpdCBtYXkgc3RpbGwgaGFuZy4NCj4gPg0KPiA+IElmIEkgbmV2ZXJ0aGVs
ZXNzIHRyeSB0byBjb25uZWN0IGJ5IHB1dHRpbmcgdGhlIG9wZW4gbGFwdG9wIHJpZ2h0IG5leHQN
Cj4gPiB0byB0aGUgYWNjZXNzIHBvaW50LCB0aGUgbGFwdG9wIHdpbGwgaGFuZy4NCj4gPg0KPiA+
IEJ1dCBpZiBJIG9ubHkgdHJ5IHRvIGRvIHRoZSBzYW1lIHdpdGggMi40R0h6IGJsdWV0b290aCBt
b3VzZSwgaXQgd2lsbA0KPiA+IGNvbnRpbnVlIHRvIHdvcmsuIElmIEkgY29ubmVjdCB0byAyLjRH
SHogd2lmaSwgaXQgd2lsbCBzdGlsbCBoYW5nDQo+ID4gYWZ0ZXIgYSBmZXcgbWludXRlcy4NCj4g
Pg0KPiA+IElmIEkgdXNlIHRoZSBSVEw4MTU2QkcgYmFzZWQgdHlwZS1DIHVzYiBkb25nbGUsIGFu
ZCBkaXNjb25uZWN0IHRoZQ0KPiA+IHBvd2VyLiBJdCB3b3JrcyBzdGFibGUuIElmIEkga2VlcCB0
aGUgY29ubmVjdGlvbiBnb2luZyBvbiB0eXBlLUMNCj4gPiBkb25nbGUsIGJ1dCBzd2l0Y2ggb24g
d2lmaSwgYW5kIHNldCBpdCBhcyBhIGRlZmF1bHQgcm91dGUsIGV2ZXJ5dGhpbmcNCj4gPiB3b3Jr
cyBzdGFibGUsIHJlZ2FyZGxlc3MgaWYgSSBjb25uZWN0IHRvIDVHSHogb3IgMi40R0h6IHdpZmku
DQo+ID4NCj4gPiBJZiBJIHRyeSB0byBwdXQgZ3JvdW5kaW5nIHRhcGUgYXJvdW5kIERQIGNhYmxl
cywgYW5kIGFyb3VuZCB0aGUgd2lmaQ0KPiA+IG1vZHVsZSwgaXQgZGlkIG5vdCBkbyBhbnl0aGlu
ZyBjb25jbHVzaXZlbHkuDQo+ID4NCj4gPiBJZiBJIHRyeSB0byBtYW51YWxseSBzZXQgdGhlIEdQ
VSBwZXJmb3JtYW5jZSB0byBoaWdoLCBpdCBtYXJnaW5hbGx5DQo+ID4gaW1wcm92ZXMgdGhlIGhh
bmdpbmcgcmF0ZS4NCj4gPg0KPiA+IERQIDIuMCwgYW5kIDIuMSB3b3JrcyBvbiA2MDBNSHosIDEu
NCBvbiAzMDBNSHosIDEuMiBvbiAxNTBNSHoNCj4gPiBkZXBlbmRpbmcgb24gbGluayBzcGVlZCwg
d2hpY2ggSSBjYW4ndCBtZWFzdXJlDQo+ID4NCj4gPiBTbywgaGVyZSBpcyB3aGF0IHRoaW5rIG1h
eSBoYXZlIGhhcHBlbmVkIGR1cmluZyB0aGUgdHJhbnNpdGlvbiBmcm9tDQo+ID4gNi4xMSB0byA2
LjEyDQo+ID4NCj4gPiAtIFNvbWV0aGluZyBQQ0lFIHJlbGF0ZWQgKEFTUE0sIG90aGVyIFBDSUUg
ZnJlcXVlbmN5L3Bvd2VyIHNldHRpbmdzKQ0KPiA+IC0gU29tZXRoaW5nIFBTUiByZWxhdGVkIChQ
U1IgcmFpc2VzIG1lbW9yeSBjbG9jayByYXRlLCBkaXNhYmxlcyBzcHJlYWQNCj4gPiBzcGVjdHJ1
bSkNCj4gPiAtIFNvbWV0aGluZyBwb3dlciByZWxhdGVkICh1bmRlcnZvbHRhZ2UgaGFwcGVucyB3
aGVuIHR5cGUtQyBwb3J0LCBvcg0KPiA+IHBvd2VyIGlzIG5vdCBwbHVnZ2VkIGluKQ0KPiA+IC0g
U29tZXRoaW5nIFJGIHJlbGF0ZWQgKHJlbmRlcmVkIGxlc3MgbGlrZWx5IGJ5IGl0IGtlZXBpbmcg
d29ya2luZw0KPiA+IHdpdGggdHlwZS1DIGV0aGVybmV0IGRvbmdsZSBwbHVnZ2VkIGluLCBidXQg
bm90IGFjdGl2ZSkNCj4gPg0KPiA+IE15IGd1ZXNzIGl0J3MgYW4gaW50ZXJwbGF5IGluIGJldHdl
ZW4gUENJRSwgYW5kIFBTUiBzZXR0aW5nLiBMZXNzDQo+ID4gbGlrZWx5LCBhIGhhcmR3YXJlIHBy
b2JsZW0uDQo+ID4NCj4gPiBJIGRvIHJlbWVtYmVyLCBzb21lb25lIHdpdGggYSBzaW1pbGFyIGJ1
ZyBkaWQgZGlzc2VjdCB0aGUgYnJlYWthZ2UgdG8NCj4gPiBhIFBDSUUgcmVsYXRlZCBjb21taXQu
DQo+ID4NCj4gPiBEbyB5b3Ugd2FudCBtZSB0byBzdGlsbCBwdXQgYWxsIG9mIHRoZSBhYm92ZSBp
bnRvIGEgYnVnIHRpY2tldCBvbiBnaXRsYWI/DQo+DQo+IFdoYXQgaXMgc3RhYmlsaXNpbmcgdGhl
IHN5c3RlbToNCj4NCj4gRm9sbG93aW5nIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVyczoN
Cj4gcGNpZV9hc3BtPW9mZg0KPiBhbWRncHVfZGVidWdtYXNrPTB4MjAwDQo+IGFtZGdwdV9kZWJ1
Z21hc2s9MHgxMA0KDQpUaGVyZSB3ZXJlIGEgYnVuY2ggb2YgUFNSIHJlbGF0ZWQgZml4ZXMgdGhh
dCB3ZW50IGludG8gNi4xMyAoYW5kIGNjJ2VkIHN0YWJsZSwgc28gc2hvdWxkIGV2ZW50dWFsbHkg
bWFrZSB0aGVpciB3YXkgdG8gNi4xMikgbGFzdCB3ZWVrLiAgQ2FuIHlvdSB0cnkgYW4gdXBkYXRl
ZCA2LjEzIGtlcm5lbCB3aXRob3V0IHRob3NlIGRlYnVnIG9wdGlvbnM/DQoNCkFsZXgNCg0K
