Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B897EC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3E810E430;
	Mon, 23 Jun 2025 16:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rviGScZQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B25810E430
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6BYOpPZWGttGHakOd4tZARV8tsAqSOsg/C0B9ZFA7NRTJ1wG99hKwtEKR3eHVgFNIMuTwNCo8acGIuf4PvmGcz7nZC+CIpmVc0wFxlhfCqXyW5iKVCaxgIltZTnm3Pha2QFKtlXoQTWo6Q6nzZJB61T4zAsExK9ECGFKnW0cPo14zH+plE+LXTamMB+EKpw5w0hraSbxIBbq/L0fnmtG/aBnY0LXmrtkmw5NCopvfC0yGDGpNM2X3yqLT+tzHJA+HAyJpXuHd85DX+vUT96Uu3BUwcKByWLNhXN1dJ2fhEYsBhpkFD9wv2GkaX1iY3cjvy2nQj9ZU8UYrwPZDeKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rasm30XV5sCYVJra+mADmGGue8hEXuuESKeqFULLsYw=;
 b=h5rOE5fNrAbokXKrvFRZVUg0XUojs7y1KuTjW5ZeL8soMEsaXPAUQ8k5e5wSpmyqQ3i3lPzxtoC0S7GXjpCa36BlNkfaiVXLqThiac6R0CfD8UCIWg55Jre5yE4jq7aNCNMXFXdJHN9EJH8VtOV59epFSpoeoLt9bX0pfTT2ThcUqm8xAuDCmAWq6/cuar1CmkiNkEYF49/SLSIXdT0+Mgpz1gjAvYdJBeW9OwH/mWlOZjDWGXwHIHvsmF14LVb/SgM2mq6CoRAYHMAEQCguYdyNm6jFN2W4G9E0USP9YYoUY3hV3WjXSdsDr/GczZuDiasJH1QZOXl/rXxLR9dd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rasm30XV5sCYVJra+mADmGGue8hEXuuESKeqFULLsYw=;
 b=rviGScZQ2YKU6jXWmH5UHIDvwKXZfFMhRltKVxCEOOZcdwsRin9Ul/GucLt8u4HSRdDQAMAZ1m2mVMqOgUkgBagkZfAjac/fNe/NxnTkPlj8Y+o/KjPya9F/9+q+COP4nOjzfSYCARCr4whwaXUBw6CNc1Y+hv6eUsZju+cidTw=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:53:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 16:53:54 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Marcus Seyfarth <m.seyfarth@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value
Thread-Topic: [PATCH] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value
Thread-Index: AQHb5F7M6j9WB+iNd0ePBGC4sVyD/LQQ9hAA
Date: Mon, 23 Jun 2025 16:53:54 +0000
Message-ID: <78d13b5c-86ff-4580-b76e-235f0d0a69da@amd.com>
References: <CA+FbhJO5rzT0T8uWM+mtVqAVx4qiY3G3nfaHmSL-jb01GmwEuQ@mail.gmail.com>
In-Reply-To: <CA+FbhJO5rzT0T8uWM+mtVqAVx4qiY3G3nfaHmSL-jb01GmwEuQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH8PR12MB7183:EE_
x-ms-office365-filtering-correlation-id: e1bfc57a-bfeb-4786-f218-08ddb2768a07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVh3TTM5M1ExYmhrSTdCOHhXYmJGeXVQNEZjYkhXTE5MSG85NjFnZTB0eFZJ?=
 =?utf-8?B?Tmx0YmFDd1l6SmU3SUVaWnU5VG1xdjgvZk1OcWJORmE5cklsaFVBVXhTVll5?=
 =?utf-8?B?eko1Q0pMeTR1ckc1ZS85RStyUzZDcFFaU0dRazQvb2g4OEpWbnBZNWd0ZC9a?=
 =?utf-8?B?SFJJdHBvRTZHOVZNcUhIUXd6ckhNVmVSaHgyVUxXNkQ5cDZMUmNockNLTlNk?=
 =?utf-8?B?c29zREZwVU5yTk5ZL202b2tJMnFYbER1SGlkQ0UxK2Z5bFViRnZaaWhRcDYx?=
 =?utf-8?B?Wnh4cGhsZ0lNTGtPV0MxZzBIQjVtYWdreWsvL2RUMnFyK1VIL3VpUjJUcnVX?=
 =?utf-8?B?ZkVNL0pha1dmRUhnbTAwQUdxaS9sMFVveDhhUkp0Ymh0b2hyODFxcmk3dEgx?=
 =?utf-8?B?OTV2ejRmQlNXUnlNZHNOUUd3dUFSYm1iRzJFbjg3T3BKMmdQdUFKRXk5Tk1r?=
 =?utf-8?B?Q2NZSWhPMXRVSmdMNG1OVTZjV20vcWJIQkRuTVNEK1hsOWNsTG5XVU9wQmhM?=
 =?utf-8?B?STVKTVlyQkU2YURhenRUMC84WmZKdE4yY2N4Nk56MHgvaXNTcmJsc2VEY24w?=
 =?utf-8?B?VlBPYWZsa0R2Wk1QbDUzcnRlVEp1OTBuU2FlOFNJdktDa0ZNWVY5MDB4ZFBr?=
 =?utf-8?B?T3ZhbVNOZm41TTllRCsxclkwTjFNMjNJVG1lSFhQTEZvLys5QlFwZm1pOFo3?=
 =?utf-8?B?c1ZCR0lPY2FwcFloVC9uVVAra3pYNWRLWjN1SWZveUpTNFhIUCtLYjhxSlN1?=
 =?utf-8?B?a0FHd3Q1bng5b3FGRVRJSUpyTXdmb3NacHVMNUg0SnRHNEIyeFJsNEdsTkFn?=
 =?utf-8?B?b0Q2T0VZOW9tYVNJZ0xPeEZTbkRSRUdwcktqcjFhTTNobWxhY2RBVlhXYy9s?=
 =?utf-8?B?TVZNRzZHcXBCRHZxbHhxQlJvK0dxR1dhZlBTeGhwUDRnbXU1MXpweVdZdDZ1?=
 =?utf-8?B?eHpiblllNlBSNXF6WUc1VEFsYTVRalZ2dThLeEtKR29yUTIzTStqcFpCSUpU?=
 =?utf-8?B?M0M3ZEw1WEZ4MVhzSlh3VW5IK01ZTGo0bGNaaHMyNDBLTVArc0ZpbnZQRDBs?=
 =?utf-8?B?NFpXSWF6UDlXNXlpenR6SG9FZ1FXMGxhbGFLQXJWMnlXc3B4dW1LS2h4Y2lK?=
 =?utf-8?B?N0UrNFl1RzBYa3g4eUdUU3JCMXlBaHpxeVZwWXQzclBKSHlta0xvbTJ6dnZ4?=
 =?utf-8?B?azVwU2t2QWlmaVpuRFhnNWFSSElYNTBWb0FQRlpMcjdzdEptOUUwcnFDWDd6?=
 =?utf-8?B?SWNRSDV0Nm9XYldvTFlId08xWHQ4eDJZVjkzc0thQzV5TEJKbUlZZk5USElz?=
 =?utf-8?B?bFgxTWMzZ1VMNEVNSnhxU1RqWmhSK2tOS004aEF4MkhJK2J3M296QTArZmNo?=
 =?utf-8?B?NFpiSXUxOVp5YktEK0NZUWFMTjhDYzRndDlzY0JxdWZYRTFla0VuVjhTanRW?=
 =?utf-8?B?VHZqelZuVGdSY1gyM3hDR3ZMaEZtQ2IzVmNQNUdEK3loS09zeXRMK1ZiOGdz?=
 =?utf-8?B?a1NsVndSNEh2aS8xQXl1SnNsLzNxZ0xFZnNLQ2ZIYXRCelZoc3RMQi95SDB4?=
 =?utf-8?B?V0FuZGYrMEh0cFowR0FUdDhha1liaTZjN0dtb2ZqWjdCT2NJRWtOSFJxNFF0?=
 =?utf-8?B?NUs4TkJTd3BzbWRWNXdNdFo4ODBoVmpUSzB0VUxBZmllTWF5SmEzWTI0dlg2?=
 =?utf-8?B?MEJXUWNxUzI5TWVnTkZwTld5U0l1dE05T0xPejUrMEZBODN1TS92bC9qWG9O?=
 =?utf-8?B?SElNek5NY0V3d3BIMXZ1a1JoaU8vZERBQXVUcVVyMm4yQ3o2d05mT0tmMXVm?=
 =?utf-8?B?TytvTkZ2UWtqZkl5TU5HVTdCT3JvWFRVeDRObnJaRi9tSXVZc1VNY3E5MGdl?=
 =?utf-8?B?TGdoMU1vS05DaXhBeE5LTGlzam5aQmpjWkVVN01QZys1TVpyZEptZTVEUHJD?=
 =?utf-8?B?VUEwOFUrSm9SSSs1L1owZUF4eTNxcWc3ODZsS3lZZ1BrTHdmZmZYVHdnT3Qv?=
 =?utf-8?B?RDcvREJMYzJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yi82VDl6cEF1dm5Wc0x3TXJlUTZ0OWplM0Y5eTRyd0tLcHdsRnMyVDIza0pC?=
 =?utf-8?B?NzdsRS9yeXNzeUVoSXNjQ1JWL0tIa0M1RGhNbElEM2Y3WnFkbUVRbVJEVVBm?=
 =?utf-8?B?K004SmpDcHc3VnNDVmdDMkgwU29aNGR0RlREMHRXeW9XakpCd0w5UDVEZkxV?=
 =?utf-8?B?QVU3ekpVTG43MzNjdTBKV2tTTGh3emRpSTkrSUwyQmNvS0dKU1dYQWdKMGxY?=
 =?utf-8?B?N0FVTjJ2dmhqcS9SZmYrSGVvbXpoeVhoZzZtQlptem90Wjc0cVRQU1RmMVFG?=
 =?utf-8?B?TjdHWFJqOVBuSjE0U0ZWYllud3hnNGpFNkFKcVBWZ09TUnY5NWgxY3c2RG4z?=
 =?utf-8?B?elV3Vml3b1hwb2dKUDZaUU9GbkljSUlTYXl6Qjg0cjlHSjJiRUtCWGJCQ0I5?=
 =?utf-8?B?MTFiY3RzaC9OeEhDeVUrOTlpWVdzQnNraWtGV1VSdDR0cm5QV0s3eElWVWRj?=
 =?utf-8?B?ckF1OHl0ZmhPbkZiQmlMTVNqSnVuZXc0dCtEaWg0V0R4QWtNVHhRZG1ENWF3?=
 =?utf-8?B?S3BkSzhjNzY3ZTM3VFErUmNaOGkzWWNSMXN6cVRWODZ2K2lrcGNnMGh2NWlz?=
 =?utf-8?B?L250KzB0L0UzbEZVQVpYTWV4c3lMMlNuMkg1Nnk1NEdkdnE5Sy9mbmZ0VE1W?=
 =?utf-8?B?bFd5Z1IyazA0d1dacnIrSmhGZUJNQks0bDJ3NUNzNnpiSXpnek96NG5tSG5V?=
 =?utf-8?B?MFdPRUJVbERpZUgyOWJxSlNoOG96ZW5qYzBaTG45Zytna21MN0ZoQWorRGU4?=
 =?utf-8?B?QTZ1b2V5VjNVcEZvakFhMStmbEp4M1JzcGt3bjBaYzUzeW1PNkcrQ2pkdzlY?=
 =?utf-8?B?ZEFsM3lhcHBieXNYOFRBZitteXc0bW1mVlhlSmJiRHNZQlNVYkdSY2FuZWlM?=
 =?utf-8?B?VEJYc0RBY09LajZkZUR3aGFtWGM5VjM0bjdMRzJNdlZTUHZyRUpHZU10NllO?=
 =?utf-8?B?YnRtaHpxaVJ2TUNKdUNiUGVOV2d6TXdDU0c0dEl3ak5vVkwwNDJZaEExejVE?=
 =?utf-8?B?ZWdwb3NWWDh0RkMwTUFyZTBwYm54c1pMWnhrK01SdHc5MkJtV2NJL2lYQ2RO?=
 =?utf-8?B?UTNCbk82dmIzdzl1eUlWbitUcFpiQ05QcXN6djhwemlFeUoxUFBhYkQzSis1?=
 =?utf-8?B?Tm12NE1LNmtkQ3VzNnBzd29HZEJPN2pld2RHSzNmM1hJSmJFNUpsVmowc1Iv?=
 =?utf-8?B?bFc2UGJMTldwdlVpYVFuN0dPU096VmF4VkdCczJIN1g4UVJ1N0ZGUHZRK1Qz?=
 =?utf-8?B?K3UyOHR4eUdkV0xOWXlLTDBrYzFqZW9XajZKclVIMDZLZFY2eSt0YjVYUVRM?=
 =?utf-8?B?OGJkOE5TVWZLUEdzQWEzNTFzN2VIWkQrREhOcEFTdDZrWlVxVENUWEtwWWQ4?=
 =?utf-8?B?V0JKTmg3QUtDa2NjRzI2NVd6eWZONWkxaHlLSHBoYWkyVXh2dDRDMUR1amRa?=
 =?utf-8?B?YUNBeEVTMFV4b2tva2JwSDYzbWRUK1pudVhjdmdQUXZ3L2JjSnRZTThZVHVC?=
 =?utf-8?B?RWl4SUhaVU56MEZZRHVlUlArQTdEZk5QTXRTSEhKQnNmeE9zQndrL0Z3S2ND?=
 =?utf-8?B?ZnhFUnVaYnBCWEIrQ3JLYmlTNWZBU2UrWUZjZkwrd1pCd2RXeUhyQlA0dFp2?=
 =?utf-8?B?cXhkZFdBTy9PNlpPVkhSY2ZHbjAxWDM3ZGxOTWJrYW9VYW1MRVJPQmlJbDJB?=
 =?utf-8?B?MHlWVEh5dmhHem1iUWh5bVBjSm93WStiYTl2MzV0QzJIQSsvTlkxYyt6Snkz?=
 =?utf-8?B?aG0yaVI4NEZvUml2M2did0llLzBPUmh5elNzRndtT0w5UkJ3Q0IvVFpaY0xX?=
 =?utf-8?B?U2xTZ3BSNHl4dXpCT2RmQVAzSkNITVhpcTZTV2dkckxjWXhUUFI4cW5LeGta?=
 =?utf-8?B?bFRPUllnSnRHTTdkZkVDb3piTGtIVjVaRndmV25zcHkxSTg0NjRFVFNzaG5Z?=
 =?utf-8?B?YXdMdXNqNytVUjdabVBURXdiQ1pYMXVHeThoT0FmaWZlbm40enk3WW9zbjVM?=
 =?utf-8?B?YXBFMEZkdWJQRklFTmtuR01UQmhnTXA4NG51Q3VUMGlFU1M3ZmYxSzhlUFBC?=
 =?utf-8?B?bStLME5lY1hyT2Vkd1hEcENZOUtlbjR1ejBGK0ZnU2dDQ3QzVFlzYk9EOWFu?=
 =?utf-8?Q?L1x4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B914978F01654C4EA0BFF5F1CF98A9BD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bfc57a-bfeb-4786-f218-08ddb2768a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 16:53:54.8016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dU/vN32vmz1jEfJ3xsbt1vrq9bT/m8jJnwn/gsdAbE4i2Zn2h9Z2bGwjB2UImE7ClwFfPft22APKHnloN8adYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
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

T24gNi8yMy8yNSAxMTo0OSBBTSwgTWFyY3VzIFNleWZhcnRoIHdyb3RlOg0KPiBKdXN0IEZZSSwg
dXNpbmcgQ2xhbmctMjFnaXQsIEkgc2VlIHRoaXMgbmV3IHdhcm5pbmcgd2l0aCB0aGUgY3VycmVu
dCBwYXRjaDoNCj4gDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b21iaW9zX2VuY29k
ZXJzLmM6MTMxOjExOiB3YXJuaW5nOg0KPiBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20gJ2ludCcg
dG8gJ3U4JyAoYWthICd1bnNpZ25lZCBjaGFyJykgY2hhbmdlcw0KPiB2YWx1ZSBmcm9tIDY1NTM1
IHRvIDI1NSBbLVdjb25zdGFudC1jb252ZXJzaW9uXQ0KPiAgIDEzMSB8ICAgICAgICAgICAgICAg
ICBsZXZlbCA9IEFNREdQVV9NQVhfQkxfTEVWRUw7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgIH4gXn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfbW9kZS5oOjQzODoyOTogbm90ZTogZXhwYW5kZWQgZnJvbQ0KPiBtYWNybyAnQU1E
R1BVX01BWF9CTF9MRVZFTCcNCj4gICA0MzggfCAjZGVmaW5lIEFNREdQVV9NQVhfQkxfTEVWRUwg
MHhGRkZGDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fg0KPiAx
IHdhcm5pbmcgZ2VuZXJhdGVkLg0KDQpUaGFua3MuICBJJ20gZ29pbmcgdG8gc3BpbiBpdCB0byBt
YWtlIGFtZGdwdV9kbSBhbmQgYXRvbWJpb3MgdXNlIA0KZGlmZmVyZW50IHZhbHVlcy4gIEknbGwg
ZHJvcCBhbiB1cGRhdGVkIHBhdGNoIGxhdGVyIHRvZGF5Lg0K
