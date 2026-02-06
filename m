Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5459BEE20AB
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 15:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E629010E031;
	Fri,  6 Feb 2026 15:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="11cpkp1p";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC02A10E031
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 15:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaS8gpAqXHwK9kALpxMQXsh2NA2uEge4nV7a5oraWhx07ZIYfxKZrydlo3e+dTBikKBoO0mlULEspHKnnGDVZebMddCGFmo3vTz8ANZXTuj7NRCvmJ54t/wc39iKeHcUkYmKEShykIl1M+5tsJaFM1g9qDhwmFybFchkpOeEkCtD+oQwHyvfgh1JhE2RaTP0P8YxCQ2OWxPOVdXFD2z054tEtX8ZFlE0IsoyHZ4MFVBTc1y7cJ+vRWJYLmqgrOvnAxScK1ECUAXvcgH5CDVHRT19uac/2P8pWhpQtadh9L88Umadkqye7BySnlU086BLaTPdJrAHXDQA9LrBwzshzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkrCQqVMwdl+ddJ18TnjBbjH3sx6qbSlSs9YOpCQDmw=;
 b=E86/diTjJ7wx8RVIyz9x9hrw5L5aa245VGNHalNDlON/LDwdo6rqaXEbyqdiTqFAT6xX3rof+JG0/OKlLps0ZWY6N7cj+Ikr4T4XiAWHDCYcAqZAK4T2aBIVtXqeoefKP/0NTIFkv4hfXiSufKemNVREPbLusPcm58KRm6PWTrsWfV069f4PUW0k7gGgX8Nyziett1b/DetLciUZstmmypFSyMW6l1eJ2YxAf7UKJJfSePMM7Kq+Jw8jRS7WWj9DF53ddQ5uTkg1xvhQFtnUfE0xQZkizc+eXzazdeuUZkV4j3seiHtd6QavkNc+ZF/mMgA/Rsh1XrsvZaQCuW7+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkrCQqVMwdl+ddJ18TnjBbjH3sx6qbSlSs9YOpCQDmw=;
 b=11cpkp1p09wK0lFs/Pa5bGA5rzytK22EOzJ1xSN5/Xk0GbIgLnS++NlkFC+691m+vSm697Rn4OzhuVSh3wC1cV+5Vjc5J5sJGUjVs/gsAlPxhMf+rQuz3O5KnpeCbTxG/MuBqsPWCmYSTBDvawpj+3BiMC1G8nDfxhVAwijt7Nk=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 15:27:04 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 15:27:04 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix watch_id bounds checking in debug address
 watch
Thread-Topic: [PATCH] drm/amdkfd: Fix watch_id bounds checking in debug
 address watch
Thread-Index: AQHcl3MNviho4f4hqEWdjZ9rbfJWY7V1xwtw
Date: Fri, 6 Feb 2026 15:27:04 +0000
Message-ID: <CY8PR12MB74354414CF3E207B1103349B8566A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20260206141507.1475882-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260206141507.1475882-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-06T15:16:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MW3PR12MB4395:EE_
x-ms-office365-filtering-correlation-id: 427cfc69-4e3c-487f-6fb4-08de65942e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bG5RTkNQdWI2eEUvdThueC9uSW9ZczhVdENwZVZ1cUdOcmhITGFoNmh2OFFm?=
 =?utf-8?B?S3hBUzNiRGM1OXJIY0pWTjFMY1psaFFpT2ROVGlvR05wZWI3TFRvcUlZTWtG?=
 =?utf-8?B?aGo0aFJCcjhTc1NjQk9HRFZKQ0o4SzU0Ri9pR1BxZkdHdFprRkc2RmYrL1J6?=
 =?utf-8?B?Wm9USS9PR0owZUhRZTJvNU1BMUhnbjdtNmZMYVlIVGtHeFV0S3E2SXl2UFVN?=
 =?utf-8?B?S1BhSmxzeDNuMTNvSkw1UktuQUpVY2xnL1Bienh1SndnMEVPUXBNUVQ5L1M5?=
 =?utf-8?B?aWxLMFJsd1V4aXY3bHg2clhpcGF5Vy9DdmNjeW04ZHJGZlVXWXJNeTJSU1Y5?=
 =?utf-8?B?Zm0veUF5WERVMmYwMnphTjVwc3lCQzkyRTJMSWtvVXFlaU15NUlTZC8yTWtF?=
 =?utf-8?B?T2w1Wk5MeUVtUG04WHl3bmVMNjR5VHZpdWpJM3RKZ0ZxeG53NEU1MXF5ZkV3?=
 =?utf-8?B?c3VkUUJJYTFmWWpHc3NMditubzN4dW9TaFNyNGZDU3ZZYmx3SHVEUGlvU0dV?=
 =?utf-8?B?a29hTTJCZHd3TVF5dDh1ek43dDVYWVVwaWJISjRMdFQ0S1huVlNDelgxbTUy?=
 =?utf-8?B?d0p6MXV1cEtzWlBjYmdhR2NFczIwcFFxMzdkb0ZpcFlBcVkvdkpMSHBLZk9F?=
 =?utf-8?B?NnFZdkgzRmM4NWU3Y0FoSC93ck1rOU41ZEhMdEVoVFp1TGMvMS84YlRUclRN?=
 =?utf-8?B?ZkVJcDFVRlNuQTRiTm1PZGdtb0lvM0hCbjdtWFMxaTFNNzhlSWpRK0VOWkJ5?=
 =?utf-8?B?bmJqRWJwTUpncVl5QWZKN21qSVY0RWx6aUpEdEQ5b1RiTzNUcTRpUVViYmcr?=
 =?utf-8?B?OWlDRGU0Q0J1NVdVb2NaRTVDc1RQU2k4am1KdVZuSGlGMXN1ZjFuOHoyekpR?=
 =?utf-8?B?cnlLZ3ErY3JocUk1TG9Ha1c5dHU5eW5yblB0bkU4WXQ3SDZjbDByVjhpRFpy?=
 =?utf-8?B?aGRYVnZzNkNQOHNFZTBHL0dwT2tNKzN1ZUpUbzZTWEZQYnQwSkp1WjQvWmlC?=
 =?utf-8?B?ODVaUkJKZHIzOWtHdmRBSXU2cWFOTDRtUnUvKythd3ljdUQxdEtCWVRRazNY?=
 =?utf-8?B?MWlLWFowclpqSjZlU1ZSMll2M3JKQ0t6cVEyU3dORFZaNCtsWndNNFJJYmNo?=
 =?utf-8?B?WHI3TldFVzhPNHJVYisyai93RC9IbXVKVWVZWTdHZlVPMzV4UW1kd1BkVlcw?=
 =?utf-8?B?US8xanFWVURQczlCUUtWT2pNWlNnbmpTT1o0eEpuSmRNOU8wL3JsS2FKWHpr?=
 =?utf-8?B?cVlQbGR4MElWUlloWlk5dWMwUXlscFdBSW5mTjJxcHQzcHhNK0RDa0pwd2l6?=
 =?utf-8?B?M0NEeXFkZjVCN0txWHNISzc4bVNVN01MSDVEdy9BU1JobXZad0duTWRvSkdl?=
 =?utf-8?B?U01IQkpKdnFkMWV6V1VqekU4N2NadFhjenRRTHdMY0dxK3hmeXFLcnBqaWJC?=
 =?utf-8?B?V1hpbXp5eEJ0UG5uR0ZFTkJBNzh5MXpiTlZNSFFYalUyS2R3cFJndG5SelJ2?=
 =?utf-8?B?UjlNeHk3OWdUQ2REZXlVMjd5RTN0TXRhbXF2QXZHUEZmQVZUVzA0WXloaUs2?=
 =?utf-8?B?SzJvZ0pvQ0Q4V0VZaWl5U1JrQTRMMUdQNXczSjBKSklvVGtGV08xaGRRYy96?=
 =?utf-8?B?aXl3NWlSZnZVTWdoWURQZTMzTzRFUVY3SzJIdFpDamdHTGdLNDlsZklxS3Rv?=
 =?utf-8?B?KzVxM0FRdWtmdmdzYTZYd3BtU3RSZStVaCs0VnpIeERZMUFaOXRBcXJpT1VL?=
 =?utf-8?B?UmV3Q2N2bVZjczNyaHRBUnpteDIyQ2FSc2x6aTdaaFAxVlp6ZEl6Y1NOaWZh?=
 =?utf-8?B?T3FzNCs1SzJTSDZ6R01NbnJZa2RIUTZNTzhsY01qclpnRmVzcFRJY2dRV1F0?=
 =?utf-8?B?Q3BLY29Ba0g2dmFHMkZlVFB0QlQvK3pYbW9mdVhxYmpxalpBQWtuSzM3Z0J2?=
 =?utf-8?B?ZmdvUE1jTERaK3ZoVWdKUW95QVlyVUp2Ky9jcE50dHBiVjQ3QWFOa3hRU01R?=
 =?utf-8?B?NmFrZ2g2RDlEVkowMzgwRG1pU2FlQzBXNk9CSXY0TkxmN3p3WERHc1d5UHFT?=
 =?utf-8?B?QTRidU8rVEFLMGNmRkdMMmdOMldUckYrZy83dzVDVjFXbWdqSFdzVDJtK2hv?=
 =?utf-8?B?WnBML1cxVkp2ZG03dHdBZ2V2K2xsbnhRaFFPOHVKTnFockt4TVBtMzZUUzJV?=
 =?utf-8?Q?UN7cWdndjVKogU3/Ujso7qg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW9Zbkp6ZjBPTFBod3g3V2RHNXllTE54L0U0STNDdnlxVnhxTEJPRVJwY2d1?=
 =?utf-8?B?ZlIzd2RERjBnTVpzVmJmNU1pdXdyY3FCVWpmem1Vc2FPV0pzcW1iV3NrNkRD?=
 =?utf-8?B?SGgySEtzdUx1Uko0d2NsVXNiM3Q4c2xsL0FlekJIUXNBTVJKaHZQMytxc3l4?=
 =?utf-8?B?UTA1eXpWNjJMZnBoK3QxU09MMUMzemdrMmMyWW9ubUV1NEpPZi9SaGUyWGE4?=
 =?utf-8?B?ZUVpQTVsSStmdmlrMXl0eE1HNHRqN1ltdFpGZXdLOHhpRHpXZVVEd25keGp6?=
 =?utf-8?B?ckZxamlQaDIzYVIwZzIzZUdSNmFBbnc1TkpyYm1vbDIwL2JkR1JwS2Ftbld4?=
 =?utf-8?B?djRqWkN1WlNKMWFMOW91SWJkWVo0SXRjR3VZREg1R212SnY2bGMwQTV2QzVW?=
 =?utf-8?B?anVxN3lUVzAvY2IyY1oxSDNVLy9BMnlGdFRkRGhKa01UcVZpWGs3V255d1Rs?=
 =?utf-8?B?Ykc2OTNHdmJPcHM4eVIvbmpkVkNGUUk0TWRheS9uOHpJWmVuTVF5S3NQelEw?=
 =?utf-8?B?eGd5VDM0SWFrclg0YktZT3MzQ2x4aFJPbHJGMVBBV0FISyswdFNXaXNJOVVo?=
 =?utf-8?B?dk5OcTVQZ2NLSDZLM2xMcFVhL3BDRnV4Qk83YXhGZndMWkJzL0dRZndGb1Bs?=
 =?utf-8?B?T2xIanJmZjZSNVdEaU9nNCtzTDdJa2RORWMzTkJ3MjBOejdrZ0hkYVVjMXdW?=
 =?utf-8?B?aVRTaVpndVBpcUFJVGpsVE9Rc0xiRWZmUmVCUm10WDdZTjkyUFQ2aWVJWmpY?=
 =?utf-8?B?bGE0RTNOM3ZOaFhoQXlIZitFWUYwM2dsZ1BSTTJSU3hPUk9Ka241dERJRTV4?=
 =?utf-8?B?MzhuWUJSM080bjVrK3ZURlZqbGFpT3NQN3hOUTJXTGZ3TXBwWGhxMFpJMXVH?=
 =?utf-8?B?amRvUVBpaXpIWTRQeFVLa2FLQ3NwNkxxQSsvaFRVdXUvcWoyQ25ra1ZwMFVs?=
 =?utf-8?B?bGZZWmcwYStwWXNXdFRLYTUrNU4veUZBSU81ZC8zUGExSGJad205MmtKOGJj?=
 =?utf-8?B?WHhEeFJCYTVEYXphbXBTU01yeUx4Q2FxdnhLb3VxQnQxeWFIc0ZyMmtVQitr?=
 =?utf-8?B?N0lXSFdjcVd5cHRabXBRam5jOFFtS1YzbW10cE1VSzNmclhyY1o0ZlZnN3VE?=
 =?utf-8?B?QjJPRm9PY2YzQWlHWXpObjNjWW9PNVJBZUh5c1ByejhsekpnY2tTaFlDb3Vt?=
 =?utf-8?B?S2xWcGo2WDFTYXA5a3JxeFE4dFNleC9Cd0JFaStqUDNXRExHTS91ZGtZZURM?=
 =?utf-8?B?czROTUNsSnhzQVlrTktRb0JCWkZRYmVXZE5aN1NpVlhvNGkwR0hpQjgrdVJC?=
 =?utf-8?B?M01QTnV4QTUwSXZqZ05rbG1MV1NjZ2t6ZTdjdEFybXNKR2xKWjlxckdGUjB2?=
 =?utf-8?B?dmZxbGxNTzczRVZjQVJxNktyZTZVa1Q0SlJpNW54S0tVUUVweFdPTWtScHZq?=
 =?utf-8?B?dTJtUWQxQjlRMSt4ZnJDc3hOdFhQZ01NckZOTExaYitPa2ExQkFLNW9iZXV2?=
 =?utf-8?B?NElwY3hYclpDVitjeEJxR1IrT0I2ZEhUbjdmY09UUU4xR2RQZitGRmVvY2xR?=
 =?utf-8?B?T24rQlBrT1NmMENXWndPOXZ1azlKWEJiWXBLUnhOei9OSmdVUlBXNjFkRmtm?=
 =?utf-8?B?aW5xeGptQ2RtT1pFYldGNWdnYTBTY0NIWTdpd1VsMmpKeW9iZUREbk5QdTcy?=
 =?utf-8?B?Sm9wT0xUUmZCUmdKeUpjcUFMbG1uS1ZVc2drMU5YSE42Q1hrRUZKWDEwT3Nl?=
 =?utf-8?B?Ymtwb0tzVGhPT2M0dmpUUDJFMWZyRENMK3NQeGQ4a01qNzJyeUhhR1Q0VjFC?=
 =?utf-8?B?Q3VZcHFCVVFsbWtLbmtkcHRwaE05Z1VtK2tOWFN6Ti93djBFTXJyUkN6eVds?=
 =?utf-8?B?OFdkeHFlNU16bFlVbHNMSTI5VlNiYnpJZU1LQWg2eW9vTzNKODkwT0MvcHpj?=
 =?utf-8?B?V0oyWGhJMmpMM0YvWHczaFlXcmRzK2R0U3NmNzZybEFFMi93YkR0WXRpUURl?=
 =?utf-8?B?S1ZzZWJTcjhzNFM0cTlTYzExMFRvSGcybG5nVi9pOWxiRnhGblRwQkFSOGZQ?=
 =?utf-8?B?U29FSVVyT2ZLbnVpSmV5Z1VXeDVUaGFMaGlJU1NDcEM4cTZrZk9aVjA5Z3dt?=
 =?utf-8?B?c21aUlluSCtSTWVVUS9nV0dUc2FhL0RtenRmOGxwTndzTEc2ZndzSEQ1OS9l?=
 =?utf-8?B?Z0p5OEt2bU5salJQMkp5RlVyeUt2WXJIQUZvMFArVmJ1TURwWE1rNW9KRFhr?=
 =?utf-8?B?eENLZ2xyaXUyMjFLK3BHTE1Ya2ZZeElNVHk5dWNrdzI3dUhSd2dsalNiMnRF?=
 =?utf-8?Q?KgMw81NiOyTRpRRL/e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427cfc69-4e3c-487f-6fb4-08de65942e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 15:27:04.3373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbBJRNjd3fe7meYVBtVBphyqeaVnXceTv8p6CO8foHOWkyRtHKX7zdmTST26hvUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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

W1B1YmxpY10NCg0KVGhhbmsgeW91IGZvciB0aGUgcmVwb3J0IGFuZCBmaXguDQpTb21lIG5pdHBp
Y2sgc3VnZ2VzdGlvbnMgYnV0IHdpdGggdGhvc2UgYWRkcmVzc2VkLCB0aGlzIGxvb2tzIGdvb2Qg
dG8gbWUgYW5kIGlzDQpSZXZpZXdlZC1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1k
LmNvbT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVHQU0s
IFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgRmVicnVhcnkgNiwgMjAyNiA5OjE1IEFNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNI
QU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IERh
biBDYXJwZW50ZXINCj4gPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz47IEtpbSwgSm9uYXRoYW4g
PEpvbmF0aGFuLktpbUBhbWQuY29tPjsNCj4gS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRrZmQ6IEZpeCB3YXRjaF9pZCBi
b3VuZHMgY2hlY2tpbmcgaW4gZGVidWcgYWRkcmVzcw0KPiB3YXRjaA0KPg0KPiBUaGUgYWRkcmVz
cyB3YXRjaCBjbGVhciBjb2RlIHJlY2VpdmVzIHdhdGNoX2lkIGFzIGFuIHVuc2lnbmVkIHZhbHVl
DQo+ICh1MzIpLCBidXQgc29tZSBoZWxwZXIgZnVuY3Rpb25zIHdlcmUgdXNpbmcgYSBzaWduZWQg
aW50IGFuZCBjaGVja2VkDQo+IGJpdHMgYnkgc2hpZnRpbmcgd2l0aCB3YXRjaF9pZC4NCj4NCj4g
SWYgYSB2ZXJ5IGxhcmdlIHdhdGNoX2lkIGlzIHBhc3NlZCBmcm9tIHVzZXJzcGFjZSwgaXQgY2Fu
IGJlIGNvbnZlcnRlZA0KPiB0byBhIG5lZ2F0aXZlIHZhbHVlLiAgVGhpcyBjYW4gY2F1c2UgaW52
YWxpZCBzaGlmdHMgYW5kIG1heSBhY2Nlc3MNCj4gbWVtb3J5IG91dHNpZGUgdGhlIHdhdGNoX3Bv
aW50cyBhcnJheS4NCj4NCj4gRml4IHRoaXMgYnkgY2hlY2tpbmcgdGhhdCB3YXRjaF9pZCBpcyB3
aXRoaW4gTUFYX1dBVENIX0FERFJFU1NFUyBiZWZvcmUNCj4gdXNpbmcgaXQuICBBbHNvIHVzZSBC
SVQod2F0Y2hfaWQpIHRvIHRlc3QgYW5kIGNsZWFyIGJpdHMgc2FmZWx5Lg0KPg0KPiBUaGlzIGtl
ZXBzIHRoZSBiZWhhdmlvciB1bmNoYW5nZWQgZm9yIHZhbGlkIHdhdGNoIElEcyBhbmQgYXZvaWRz
DQo+IHVuZGVmaW5lZCBiZWhhdmlvciBmb3IgaW52YWxpZCBvbmVzLg0KPg0KPiBGaXhlcyB0aGUg
YmVsb3c6DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfZGVidWcu
Yzo0NDgNCj4ga2ZkX2RiZ190cmFwX2NsZWFyX2Rldl9hZGRyZXNzX3dhdGNoKCkgZXJyb3I6IGJ1
ZmZlciBvdmVyZmxvdw0KPiAncGRkLT53YXRjaF9wb2ludHMnIDQgPD0gdTMybWF4IHVzZXJfcmw9
JzAtMywyMTQ3NDgzNjQ4LXUzMm1heCcgdW5jYXBwZWQNCj4NCj4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vYW1ka2ZkL2tmZF9kZWJ1Zy5jDQo+ICAgICA0MzMgaW50IGtmZF9kYmdfdHJh
cF9jbGVhcl9kZXZfYWRkcmVzc193YXRjaChzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlDQo+ICpw
ZGQsDQo+ICAgICA0MzQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQzMl90IHdhdGNoX2lkKQ0KPiAgICAgNDM1IHsNCj4gICAgIDQzNiAgICAgICAgIGludCByOw0K
PiAgICAgNDM3DQo+ICAgICA0MzggICAgICAgICBpZiAoIWtmZF9kYmdfb3duc19kZXZfd2F0Y2hf
aWQocGRkLCB3YXRjaF9pZCkpDQo+DQo+IGtmZF9kYmdfb3duc19kZXZfd2F0Y2hfaWQoKSBkb2Vz
bid0IGNoZWNrIGZvciBuZWdhdGl2ZSB2YWx1ZXMgc28gaWYNCj4gd2F0Y2hfaWQgaXMgbGFyZ2Vy
IHRoYW4gSU5UX01BWCBpdCBsZWFkcyB0byBhIGJ1ZmZlciBvdmVyZmxvdy4NCj4gKE5lZ2F0aXZl
IHNoaWZ0cyBhcmUgdW5kZWZpbmVkKS4NCj4NCj4gICAgIDQzOSAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ICAgICA0NDANCj4gICAgIDQ0MSAgICAgICAgIGlmICghcGRkLT5kZXYt
PmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFibGVfbWVzKSB7DQo+ICAgICA0NDIgICAgICAgICAg
ICAgICAgIHIgPSBkZWJ1Z19sb2NrX2FuZF91bm1hcChwZGQtPmRldi0+ZHFtKTsNCj4gICAgIDQ0
MyAgICAgICAgICAgICAgICAgaWYgKHIpDQo+ICAgICA0NDQgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHI7DQo+ICAgICA0NDUgICAgICAgICB9DQo+ICAgICA0NDYNCj4gICAgIDQ0NyAg
ICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwocGRkLT5kZXYtPmFkZXYsIGZhbHNlKTsNCj4gLS0+
IDQ0OCAgICAgICAgIHBkZC0+d2F0Y2hfcG9pbnRzW3dhdGNoX2lkXSA9IHBkZC0+ZGV2LT5rZmQy
a2dkLQ0KPiA+Y2xlYXJfYWRkcmVzc193YXRjaCgNCj4gICAgIDQ0OSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBkZC0+ZGV2LT5hZGV2LA0K
PiAgICAgNDUwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgd2F0Y2hfaWQpOw0KPg0KPiBGaXhlczogZTBmODVmNDY5MGQwICgiZHJtL2FtZGtm
ZDogYWRkIGRlYnVnIHNldCBhbmQgY2xlYXIgYWRkcmVzcyB3YXRjaCBwb2ludHMNCj4gb3BlcmF0
aW9uIikNCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJv
Lm9yZz4NCj4gQ2M6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQo+IENjOiBG
ZWxpeCBLdWVobGluZyA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFu
bXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RlYnVnLmMgfCAyMSArKysrKysrKysrLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZWJ1Zy5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RlYnVnLmMNCj4gaW5kZXggMWRhZTMx
Nzg1OGU5Li45MWVkZTU2ODkwZDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZWJ1Zy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZWJ1Zy5jDQo+IEBAIC00MDQsMjcgKzQwNCwyNCBAQCBzdGF0aWMgaW50IGtmZF9kYmdfZ2V0
X2Rldl93YXRjaF9pZChzdHJ1Y3QNCj4ga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQsIGludCAqd2F0
Y2hfaQ0KPiAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gIH0NCj4NCj4gLXN0YXRpYyB2b2lkIGtm
ZF9kYmdfY2xlYXJfZGV2X3dhdGNoX2lkKHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCwg
aW50DQo+IHdhdGNoX2lkKQ0KPiArc3RhdGljIHZvaWQga2ZkX2RiZ19jbGVhcl9kZXZfd2F0Y2hf
aWQoc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkLCB1MzINCj4gd2F0Y2hfaWQpDQo+ICB7
DQo+ICAgICAgIHNwaW5fbG9jaygmcGRkLT5kZXYtPndhdGNoX3BvaW50c19sb2NrKTsNCj4gLQ0K
PiAtICAgICAvKiBwcm9jZXNzIG93bnMgZGV2aWNlIHdhdGNoIHBvaW50IHNvIHNhZmUgdG8gY2xl
YXIgKi8NCj4gLSAgICAgaWYgKChwZGQtPmFsbG9jX3dhdGNoX2lkcyA+PiB3YXRjaF9pZCkgJiAw
eDEpIHsNCj4gLSAgICAgICAgICAgICBwZGQtPmFsbG9jX3dhdGNoX2lkcyAmPSB+KDB4MSA8PCB3
YXRjaF9pZCk7DQo+IC0gICAgICAgICAgICAgcGRkLT5kZXYtPmFsbG9jX3dhdGNoX2lkcyAmPSB+
KDB4MSA8PCB3YXRjaF9pZCk7DQo+ICsgICAgIGlmICh3YXRjaF9pZCA8IE1BWF9XQVRDSF9BRERS
RVNTRVMgJiYNCg0KTWF5YmUgRUlOVkFMIGVhcmx5IHRlc3QgaW4ga2ZkX2RiZ190cmFwX2NsZWFy
X3NldF9hZGRyZXNzX3dhdGNoIGFnYWluc3QgTUFYX1dBVENIX0FERFJFU1Mgc2ltaWxhciB0byB5
b3VyIHByb3Bvc2VkIHRlc3QgaW4ga2ZkX2RiZ190cmFwX2NsZWFyX2Rldl9hZGRyZXNzX3dhdGNo
Pw0KVGhhdCB3YXkgeW91IGRvbid0IGhhdmUgdG8gZG8gdGhlIHRlc3QgaW4gYSBzcGlubG9jayBm
b3IgYW55IHdhdGNoIHBvaW50IHN0YXRpYyBjYWxscyBhbmQgdGhlIHR3byB3YXRjaCBwb2ludCBl
bnRyeSBjYWxscyB3aWxsIGJlIHN5bW1ldHJpY2FsIGluIHRlcm1zIG9mIHRoZWlyIGNvbmRpdGlv
biBjaGVja3MuDQoNCj4gKyAgICAgICAgIChwZGQtPmFsbG9jX3dhdGNoX2lkcyAmIEJJVCh3YXRj
aF9pZCkpKSB7DQo+ICsgICAgICAgICAgICAgcGRkLT5hbGxvY193YXRjaF9pZHMgJj0gfkJJVCh3
YXRjaF9pZCk7DQo+ICsgICAgICAgICAgICAgcGRkLT5kZXYtPmFsbG9jX3dhdGNoX2lkcyAmPSB+
QklUKHdhdGNoX2lkKTsNCj4gICAgICAgfQ0KPiAtDQo+ICAgICAgIHNwaW5fdW5sb2NrKCZwZGQt
PmRldi0+d2F0Y2hfcG9pbnRzX2xvY2spOw0KPiAgfQ0KPg0KPiAtc3RhdGljIGJvb2wga2ZkX2Ri
Z19vd25zX2Rldl93YXRjaF9pZChzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQsIGludA0K
PiB3YXRjaF9pZCkNCj4gK3N0YXRpYyBib29sIGtmZF9kYmdfb3duc19kZXZfd2F0Y2hfaWQoc3Ry
dWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkLCB1MzINCj4gd2F0Y2hfaWQpDQo+ICB7DQo+ICAg
ICAgIGJvb2wgb3duc193YXRjaF9pZCA9IGZhbHNlOw0KPg0KPiAgICAgICBzcGluX2xvY2soJnBk
ZC0+ZGV2LT53YXRjaF9wb2ludHNfbG9jayk7DQo+IC0gICAgIG93bnNfd2F0Y2hfaWQgPSB3YXRj
aF9pZCA8IE1BWF9XQVRDSF9BRERSRVNTRVMgJiYNCj4gLSAgICAgICAgICAgICAgICAgICAgICgo
cGRkLT5hbGxvY193YXRjaF9pZHMgPj4gd2F0Y2hfaWQpICYgMHgxKTsNCj4gLQ0KPiArICAgICBp
ZiAod2F0Y2hfaWQgPCBNQVhfV0FUQ0hfQUREUkVTU0VTKQ0KSSB0aGluayB5b3UgaGF2ZSBhbHJl
YWR5IHRlc3RlZCB0aGlzIHdpdGggeW91ciBwcm9wb3NlZCB0ZXN0IGJlbG93IHNpbmNlIGtmZF9k
YmdfdHJhcF9jbGVhcl9kZXZfYWRkcmVzc193YXRjaCBpcyB0aGUgb25seSBjYWxsZXIgZm9yIHRo
aXMgc3RhdGljIGZ1bmN0aW9uLg0KU28geW91IGNhbiBwcm9iYWJseSByZW1vdmUgdGhlIHdhdGNo
X2lkIDwgTUFYX1dBVENIX0FERFJFU1MgY29uZGl0aW9uIGNoZWNrIGhlcmUuDQoNCkpvbg0KDQo+
ICsgICAgICAgICAgICAgb3duc193YXRjaF9pZCA9IHBkZC0+YWxsb2Nfd2F0Y2hfaWRzICYgQklU
KHdhdGNoX2lkKTsNCj4gICAgICAgc3Bpbl91bmxvY2soJnBkZC0+ZGV2LT53YXRjaF9wb2ludHNf
bG9jayk7DQo+DQo+ICAgICAgIHJldHVybiBvd25zX3dhdGNoX2lkOw0KPiBAQCAtNDM1LDYgKzQz
Miw4IEBAIGludCBrZmRfZGJnX3RyYXBfY2xlYXJfZGV2X2FkZHJlc3Nfd2F0Y2goc3RydWN0DQo+
IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkLA0KPiAgew0KPiAgICAgICBpbnQgcjsNCj4NCj4gKyAg
ICAgaWYgKHdhdGNoX2lkID49IE1BWF9XQVRDSF9BRERSRVNTRVMpDQo+ICsgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+ICAgICAgIGlmICgha2ZkX2RiZ19vd25zX2Rldl93YXRjaF9pZChw
ZGQsIHdhdGNoX2lkKSkNCj4gICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4NCj4gLS0N
Cj4gMi4zNC4xDQoNCg==
