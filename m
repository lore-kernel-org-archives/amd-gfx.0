Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81854CCF9FE
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 13:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1535710E3F7;
	Mon,  3 Nov 2025 13:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bWyJQkwE";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2878210E3F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 13:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeB8BTDhg60CHtowqrD54FGnjjsD//ED2VvSOhiHXSIzP3H+8cSu/lAX42iu2B9PciRZ1iFdKLgMPf+/7+0Cf2HGcjvZD4fB2FinJWKrg+iaAE3TFQGx8/Wl/NfXTpqoUYjZdIIM6D2fKFA+AKXHMxY/e2nGHoW+FxpR0AhVXPuGHL9i5fg8TTaeaFbXJULJSlFKLeDhMp8vLkQkxQgJ2dpErNU/PzHixPU7mil4O6iVJUfFYevn5SWSDWEG3qDLoWfz/8rIFeRvbjqRF0e7SAYN1cgoG4rIW9wyHWSVwhqDFqqGhrrDCJJcYiz0kto1yy7pWdHfi8ZlRvYfRdrkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHKZ6FgTreDTjcHKhMgHUEjYaIzO43HgyPDdz8YudQ8=;
 b=bRqbVgSTPIzCw3GpinpUHVNRTW+LGloG/bvN4qSY5lhdgFSgmhTjNBbqJrwejcq4ELOIAp3RwvtsmIPKSIyttxgLIbiXwrX0b1hrZ5xCbfU4EfOHuJmxB845subj3sqOYKAtPi+9tCHXutaFWt3Ru0lPVMlaEzUZDoTMLXBkWWr5qp6Y7ieyuloh1WWuxSzXdJdITGTH78oBluY2t2Khsst6lSEymeMJpPvfsHMRQEhB+g+f3JbCMwzfLMdsg8VuNibZ+4N22tbzxMNDOAzM29FzSxuseEgHaCzWwN9qJIwx0mhbknevIXqzsEhLcHMGkvf5IvSTlZTDeayNczmItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHKZ6FgTreDTjcHKhMgHUEjYaIzO43HgyPDdz8YudQ8=;
 b=bWyJQkwEbDy16icwqYy5jrFGjOfGL7UQMOM4Y8Uv/5JUXBfa2nWggjepKkfnNd1Cheb0rfNO27wF4fd3nDv1pWNz+TemfPOgNxseWGlsjMsFf4hgsZtEqQfc5qOWaWlM50XAFwsUcZJ/7IwxH3gj+2nxR3oTT74geMgw1plEOD4=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB999110.namprd12.prod.outlook.com (2603:10b6:806:4a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Mon, 3 Nov
 2025 13:59:38 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:59:38 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wu, Ray" <Ray.Wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>
Subject: RE: [PATCH 00/13] DC Patches November 3, 2025
Thread-Topic: [PATCH 00/13] DC Patches November 3, 2025
Thread-Index: AQHcSIGRLC43u499LEyzoK+a59EQIbThAu7w
Date: Mon, 3 Nov 2025 13:59:37 +0000
Message-ID: <DS0PR12MB6534991DE8D62918DDB676A59CC7A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-03T13:59:29.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB999110:EE_
x-ms-office365-filtering-correlation-id: ac42cfbd-b4ad-4532-3aff-08de1ae13a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K3Rmazd5SzVmMDI4WlhQM1hhSW82YmQ1djVSK2ZnYUZYRzRlaVBWcGlZbjNC?=
 =?utf-8?B?NElqeTAyQlduM2hMRVU1bXF2ZzdLem1ndWJJVHNoRFQzMFRIU1NKdTRUN0VL?=
 =?utf-8?B?M0ZZOEtVWjloekhOWFZJZDg2T2VsbE1tTkVWSFdjNGI3NzEwN0JVcklPV2lx?=
 =?utf-8?B?RlZKajFwQWpVS240eXUrZXZ1NTdlSVFVU1VMMHNibjRyWGF2Z3EvMjhIaUs3?=
 =?utf-8?B?VWJqRlR1eThUYmI5M2FVL0h6NDdEWmxnVTVHbU9wVFE2L0hsRmFSTVRKTElp?=
 =?utf-8?B?bHdVR01UUUNnblYzTnhWN2hIYjZhZy9haVZuSnFPU0Qxekp1VlFyWGM0eXFH?=
 =?utf-8?B?eEQwSVZFNVUxVnhSQzRCMmRRWUtvM2hZbGhPZnlWYVRBSjg4Qjd4WXhsbDJV?=
 =?utf-8?B?bGx4Z0piNGZ2MjlUcVRjdEVwUXVxV2kwUURXVW5EZXpsQVo4aXErMnZmTzdU?=
 =?utf-8?B?Qm9DZy8yOGMzSmJiMXNMTUlDeGFXQUxpd3V4WTVsaG9EaXdUNytHajE2NllX?=
 =?utf-8?B?NmR1VzFtQVFMdkU2cUlQc2l0ZUdna3ZuVkpXTWpjU1VkU05ucWo5dU9pb2dG?=
 =?utf-8?B?ekRYYzJzVjlHWWtWTGdOS2lVK3FvdDBnb3V1ZUxJdlZGQUFSNWtIS1BkY2FW?=
 =?utf-8?B?Q0VhQkxBSnp1dkIxWUhwTVViMnRqN0lSVE1XanQyY0NubFpoWWdvcjRDbkRj?=
 =?utf-8?B?a3dsQlg1cWpMVlgrZ2hSaHBqQXZpamFReHIzVUw4UGlveDIwY2l2bjBIVXgz?=
 =?utf-8?B?cmh5WmxVdEltbTJSSGE3Y1hUaUo4TGJDcGF1TFdFcDFSZzcrVWlhK2tkM0Fh?=
 =?utf-8?B?OXB1U0FCV2RwYVMrNnBZYWdWNmVwamdyT1JRZmNWaHQ2NmtzZzJuR3lkZXQ0?=
 =?utf-8?B?aXFhNTJCVmtlVlNnWTR6UnZ5dW1rMy9DNDFzQis5U0lLVmxzVUN0a2lnYjgy?=
 =?utf-8?B?MW1LZzZ0V0cycWRkZmNPMjkrT2w0SjBGRHpaWnZ0bkVKdE1YblR2ZFIyZjdq?=
 =?utf-8?B?YWVrWitic3gveWxiVXhndGdaQjRBU05FYkJoTmhEM0hYdkRKd1BlNTdqOFdT?=
 =?utf-8?B?WG10UFRSSHhVTlNnTHJoTG1sTkExMkVaZ2hQTm1OWmJQYVh3eWVscmxHdm04?=
 =?utf-8?B?ZG0wR01hQVQrYXk1S21pdFdBWU5PcHpTMnZkR2hTU3RyMlBHM29BblZVK2ph?=
 =?utf-8?B?OWlEWFBDSkRpUEo4amRUTGFTWHdHVTd5STd6TGpWL2JGU3ljUVZsYTdvVlU0?=
 =?utf-8?B?OGhpanJMa0poSnFUMXhPMStYbHBLYTdqTC84aVlFU1FsSnhmOTIzU1ZZbm1Y?=
 =?utf-8?B?R0g0OWhKUlpzVExITm1xZk1jellHQi9vZno1dUZKSXVPdnhWT0pSL0N1SXB3?=
 =?utf-8?B?TTJsWWJ2UVZ5QjdlZmRzVWVYZTFhZGxoM0VlWnh5b0lHVUlVWm85L2xDVzFD?=
 =?utf-8?B?SEludUZOYVlpZ2NNSlVRWnkwVXdKcS9Lbmp5ckdFUGswbXNJZ1FwSTJCeE5W?=
 =?utf-8?B?SUFycXdranhxYlZ4LzVDVXFITENWV291eUdaWWpJb24xb1ZuUzZoaVJGMUdZ?=
 =?utf-8?B?K3Rib25LOHIxRVpaTnhUVjRZdjl5dC8xa3V4bFkrcG5ucVNJaG0yYlBkam5t?=
 =?utf-8?B?NFBjallWR0dzN3pONjFxVHFTdGNYVjVZSFM4NnpxNG5GNnN2cmpqbEx3bnEy?=
 =?utf-8?B?MGF6cjJTallKaEhhS08zQUlSWm9SWW9DdEJIV2tRZVR5R0FBWlZkdXBZdERP?=
 =?utf-8?B?RHN0OEgzWnp4djFRbjBGUVgwV3cvMC80RVpJRjhYcEcrY0o2c1N6aXlkMi95?=
 =?utf-8?B?M0p0MnhtNjY0Q053STA0YUdPbGozeUwzV3h6cXI0MnVkYXF4MTV2Y0g3YkVJ?=
 =?utf-8?B?d1hwVC9GUE9zVHEvQnJKbEIrR25kYjZrK29pK3FKdHlwaHY0bGQ5OWhYdG4z?=
 =?utf-8?B?aHBBV3RTWXc4NnVJWStlWFRmUjF5dlo2QnI0cG1XMFBSUzAwSkkzTk16K3FJ?=
 =?utf-8?B?VzdiVUFFY0FqVlVObmNPNXRYNG9RYXFBL1V2bFl4UG1UYTY5bFVPRnJNNHlv?=
 =?utf-8?Q?xemPfV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzU0aGMza1lFYTBhWGFFZFUxa2RxWnlwcDdUOWgxRTBpZHJTQm4rME4rNGN2?=
 =?utf-8?B?NlQ0MEtZNkZ1K2FNc0xHbDUrTCtYb1R3blFOUE9mU24zanVrbjVTdXVWaTdC?=
 =?utf-8?B?ZTdRNTRmTTdlSEhXbUZpNzlkdURmYlNZanFIbFJMNmpHeVNwOCtiZk51NWZz?=
 =?utf-8?B?cDk1SjZkc3lCSE5KZ0dNV2JYNUFuUWJacmNNMWRJSm9nc3h5NmRGRjlubWN3?=
 =?utf-8?B?OEtwLzhONGxRcEYvNXNDb2dvVytSb3BneldtV3pTS2dWUlJjcWt0NDRqdlNy?=
 =?utf-8?B?aitlMDAycEd1cHY3Vi92QU9LM2h4K1BhNGpjc1BHOWdHa01RbnNtUmYwL094?=
 =?utf-8?B?cDF6SHMxWjU0eEw4cU4xdUVadFV6eWpOYlZYeWFUNHpGMUhUeTlsMHpyTGox?=
 =?utf-8?B?ZnRjZ2FxTUR2NVEvSE1aTzJlSHBQd2VVc1QxWkl5ajlXcERVWE5pVWg5RTJj?=
 =?utf-8?B?NVJ2cExpWTNPcHI5eVJicmR4MkVmR05VdHZVblgvL3ZIV3g1SzkvcFdEckhY?=
 =?utf-8?B?N2xLRGU1TEN1TkVhQWJlK2dCK3B4cXc1aUVHNmdYYXJGa2dqMzc2OEJSQnpJ?=
 =?utf-8?B?d09DRkp0RldIRWsxMGJVR1VWN1VFSkFhL2xxZVZ5M2Nka002MXRqM1RMZUJ5?=
 =?utf-8?B?ZEw5d3JydVRHdStrQWZyRzd3RVQwSXFpS3FaUGxQRWFMdk1mQTNjYjlMVjdF?=
 =?utf-8?B?SXByVVRsUW5kMy9wVjFZb2w0c1pqNGllUi9XYnNVQmNaZGdDODR4Q2VzcGlF?=
 =?utf-8?B?RUEySVdURnZmVFp2Ry9rbnFHeE8rc0I4TWpJczBIWDNTUWZnVTJtK2xQZHJC?=
 =?utf-8?B?aksvY2FZWk1WU09ZWTVUWEhqS2dSTnRRTGRyMjZuMFJMMW1pbUhqQVNNRzky?=
 =?utf-8?B?U09MVEQrc2NWMWxkc3hNalYrdlA4dWthQUd6TUs1dDllNWtaZU90L0wyc3RQ?=
 =?utf-8?B?R2R3TW9UTHFpcEtFQ01NWmNZdm4xUWtHYldDNUIyRytLanVtRjRNajhSa21o?=
 =?utf-8?B?UkFRNVp2QlNtQVZESWJJam9PMC9makxEaXNoR0w5UDYvSEQrWC9rd3NwVkkx?=
 =?utf-8?B?Vy9tMEs4KzQ1enN1bU5BbGZPa1hGaTE4ZjRjcXJRb1RRc2lReitjVWozcmNE?=
 =?utf-8?B?aTZncmFmZFVYbWhXSjVNWEVhMTFFWUx5WVZvM1p5MTJFM1c2c3lHRlMzUkVt?=
 =?utf-8?B?S2taSVJVT0F0dEtNTC80MkFjZ1hlMm1lV3N5cTJlbjhKUmh1dWFUS0Vkdkpz?=
 =?utf-8?B?RWp0ZUtlOGlQdG1tUnBGd0NueUlMN2oyQTVlcHF5bTRpY0JzTHVXVzVROHFR?=
 =?utf-8?B?cFdVOGxKRWY0KzlMUkJNRTVWRVpXTVY4cjBJVEIxSEtJRGZYRkZValpabkw2?=
 =?utf-8?B?UXRwWFpLU0YrQm1XaFNCNEtQYTJGYXdRdFViL2ZHV3Vxa215VTJGRW1PYlI3?=
 =?utf-8?B?M0dZNSsvTUpWV0p5SXo0VFRCMncvOGxVak1BZ3ZGdmxEbG5EV0NtcmN0YmJn?=
 =?utf-8?B?ZUs5SEQzd084T3dhbTNTNUpUQXhqVVIyV3QzczZDQ1EwN0FjaVJ1TmRPRk1a?=
 =?utf-8?B?dWovZDgyK2NRblNBNDh1ZmlGeklZSDhGMmFqWXNINFptbGxXeHdNVWk1WW9z?=
 =?utf-8?B?ZVVhNS9qVmQ3TjRVYXZFMjhoSCtnSU93eGNTVFdyUUFOZllTL1Y0WnNDZzZv?=
 =?utf-8?B?T0oxcVM4NVdGRjBhTm9TdE1ia1ZWaXkweGZQSlAybEJEMWZFdmJaRDNjR0V4?=
 =?utf-8?B?NDJuZXJhMFVLV3pTbW5zaVU4NCtUR0FkSkRweW5vWWI1RlRjcWdZNndGdVJU?=
 =?utf-8?B?V0lyd1BaR1gyVFM3YXRyUW1zemIxYzZlNm5mQklBTWpQT1JXVEhKaktuelV4?=
 =?utf-8?B?SUlWZE9HY3BENzUvczJaeVVQTHp4Q3pJSElOMHJoU3RNZWRnazFxZ2E3SHM0?=
 =?utf-8?B?UFp5cDQvaU9LWTNydkRWQnZPR29UQjNhY2RCK2tSREhWWi92bG5ramZQOEJr?=
 =?utf-8?B?TjlYRHJxdFp3SG1uRDEzQ00vSFkyT2V1QUJZbndRZnEvTXM2WmI4TEdkb2lC?=
 =?utf-8?B?WEdzQkI0OVUzYTh1VHlEUkpsR2QzcHllcHhhSElWdzNsNFNpNmpsZkpLdFZj?=
 =?utf-8?Q?sCMs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac42cfbd-b4ad-4532-3aff-08de1ae13a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 13:59:37.7754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfVxS84CGAavekS6qT29WhK4BOND/aZUHxjrCME0uWCn8aySWwKqukkrBek8JwUtjOKGr3JdlDIup4CZciOrUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999110
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

W1B1YmxpY10NCg0KSGkgYWxsLA0KDQpUaGlzIHdlZWsgdGhpcyBwYXRjaHNldCB3YXMgdGVzdGVk
IG9uIDQgc3lzdGVtcywgdHdvIGRHUFUgYW5kIHR3byBBUFUgYmFzZWQsIGFuZCB0ZXN0ZWQgYWNy
b3NzIG11bHRpcGxlIGRpc3BsYXkgYW5kIGNvbm5lY3Rpb24gdHlwZXMuDQoNCkFQVQ0KICAgICAg
ICDigKIgU2luZ2xlIERpc3BsYXkgZURQIC0+IDEwODBwIDYwaHosIDE5MjB4MTIwMCAxNjVoeiwg
Mzg0MHgyNDAwIDYwaHoNCiAgICAgICAg4oCiIFNpbmdsZSBEaXNwbGF5IERQIChTU1QgRFNDKSAt
PiA0azE0NGh6LCA0azI0MGh6DQogICAgICAgIOKAoiBNdWx0aSBkaXNwbGF5IC0+IGVEUCArIERQ
L0hETUkvVVNCLUMgLT4gMTA4MHAgNjBoeiBlRFAgKyA0ayAxNDRoeiwgNGsgMjQwaHogKEluY2x1
ZGVzIFVTQi1DIHRvIERQL0hETUkgYWRhcHRlcnMpDQogICAgICAgIOKAoiBUaHVuZGVyYm9sdCAt
PiBMRyBVbHRyYWZpbmUgNWsNCiAgICAgICAg4oCiIE1TVCBEU0MgLT4gQ2FibGUgTWF0dGVycyAx
MDEwNzUgKERQIHRvIDN4IERQKSB3aXRoIDN4IDRrNjBoeiBkaXNwbGF5cywgSFAgSG9vayBHMiB3
aXRoIDJ4IDRrNjBoeiBkaXNwbGF5cw0KICAgICAgICDigKIgVVNCIDQgLT4gSFAgSG9vayBHNCwg
TGVub3ZvIFRodW5kZXJib2x0IERvY2ssIGJvdGggd2l0aCAyeCA0azYwaHogRFAgYW5kIDF4IDRr
NjBoeiBIRE1JIGRpc3BsYXlzDQogICAgICAgIOKAoiBTU1QgUENPTiAtPiBDbHViM0QgQ0FDLTEw
ODUgKyAxeCA0ayAxNDRoeiwgRlJMMywgYXQgYSBtYXggcmVzb2x1dGlvbiBzdXBwb3J0ZWQgYnkg
dGhlIGRvbmdsZSBvZiA0ayAxMjBoeiBZVVY0MjAgMTJicGMuDQogICAgICAgIOKAoiBNU1QgUENP
TiAtPiAxeCA0ayAxNDRoeiwgRlJMMywgYXQgYSBtYXggcmVzb2x1dGlvbiBzdXBwb3J0ZWQgYnkg
dGhlIGFkYXB0ZXIgb2YgNGsgMTIwaHogUkdCIDhicGMuDQoNCkRHUFUNCiAgICAgICAg4oCiIFNp
bmdsZSBEaXNwbGF5IERQIChTU1QgRFNDKSAtPiA0azE0NGh6LCA0azI0MGh6DQogICAgICAgIOKA
oiBNdWx0aXBsZSBEaXNwbGF5IERQIC0+IDRrMjQwaHogKyA0azE0NGh6DQogICAgICAgIOKAoiBN
U1QgKFN0YXJ0ZWNoIE1TVDE0RFAxMjNEUCBbRFAgdG8gM3ggRFBdIGFuZCAyeCA0ayA2MGh6IGRp
c3BsYXlzKQ0KICAgICAgICDigKIgTVNUIERTQyAod2l0aCBDYWJsZSBNYXR0ZXJzIDEwMTA3NSBb
RFAgdG8gM3ggRFBdIHdpdGggM3ggNGs2MGh6IGRpc3BsYXlzKQ0KDQpUaGUgdGVzdGluZyBpcyBh
IG1peCBvZiBhdXRvbWF0ZWQgYW5kIG1hbnVhbCB0ZXN0cy4gTWFudWFsIHRlc3RpbmcgaW5jbHVk
ZXMgKGJ1dCBpcyBub3QgbGltaXRlZCB0bykNCiAgICAgICAg4oCiIENoYW5naW5nIGRpc3BsYXkg
Y29uZmlndXJhdGlvbnMgYW5kIHNldHRpbmdzDQogICAgICAgIOKAoiBWaWRlby9BdWRpbyBwbGF5
YmFjaw0KICAgICAgICDigKIgQmVuY2htYXJrIHRlc3RpbmcNCiAgICAgICAg4oCiIFN1c3BlbmQv
UmVzdW1lIHRlc3RpbmcNCiAgICAgICAg4oCiIEZlYXR1cmUgdGVzdGluZyAoRnJlZXN5bmMsIEhE
Q1AsIGV0Yy4pDQoNCkF1dG9tYXRlZCB0ZXN0aW5nIGluY2x1ZGVzIChidXQgaXMgbm90IGxpbWl0
ZWQgdG8pDQogICAgICAgIOKAoiBTY3JpcHQgdGVzdGluZyAoc2NyaXB0cyB0byBhdXRvbWF0ZSBz
b21lIG9mIHRoZSBtYW51YWwgY2hlY2tzKQ0KICAgICAgICDigKIgSUdUIHRlc3RpbmcNCg0KVGhl
IHRlc3RpbmcgaXMgbWFpbmx5IHRlc3RlZCBvbiB0aGUgZm9sbG93aW5nIGRpc3BsYXlzLCBidXQg
b2NjYXNpb25hbGx5IHRoZXJlIGFyZSB0ZXN0cyB3aXRoIG90aGVyIGRpc3BsYXlzDQogICAgICAg
IOKAoiBTYW1zdW5nIEc4IE5lbyA0azI0MGh6DQogICAgICAgIOKAoiBTYW1zdW5nIFFONTVRTjk1
QiA0ayAxMjBoeg0KICAgICAgICDigKIgQWNlciBYVjMyMlFLS1YgNGsxNDRoeg0KICAgICAgICDi
gKIgSFAgVTI3IDRrIFdpcmVsZXNzIDRrNjBoeg0KICAgICAgICDigKIgTEcgMjdVRDU4QiA0azYw
aHoNCiAgICAgICAg4oCiIExHIDMyVU42NTBXQSA0azYwaHoNCiAgICAgICAg4oCiIExHIFVsdHJh
ZmluZSA1ayA1azYwaHoNCiAgICAgICAg4oCiIEFVIE9wdHJvbmljcyBCMTQwSEFOMDEuMSAxMDgw
cCA2MGh6IGVEUA0KICAgICAgICDigKIgQVUgT3B0cm9uaWNzIEIxNjBVQU4wMS5KIDE5MjB4MTIw
MCAxNjVoeiBlRFANCiAgICAgICAg4oCiIFNhbXN1bmcgQVROQTYwWVYwMi0wIDM4NDB4MjQwMCA2
MEh6IE9MRUQgZURQDQoNCg0KVGhlIHBhdGNoc2V0IGNvbnNpc3RzIG9mIHRoZSBhbWQtc3RhZ2lu
Zy1kcm0tbmV4dCBicmFuY2ggKEhlYWQgY29tbWl0IC0gZDIzZjY4ZDg5ODUyOWU3NzkzZGE1NGQw
MzZlODhjNjdjNDYxM2NiMSAtPiBkcm0vYW1kZ3B1OiBVc2UgREMgYnkgZGVmYXVsdCBmb3IgQm9u
YWlyZSkgd2l0aCBuZXcgcGF0Y2hlcyBhZGRlZCBvbiB0b3Agb2YgaXQuDQoNClRlc3RlZCBvbiBV
YnVudHUgMjQuMDQuMywgb24gV2F5bGFuZCBhbmQgWDExLCB1c2luZyBHbm9tZS4NCg0KVGVzdGVk
LWJ5OiBEYW4gV2hlZWxlciA8ZGFuaWVsLndoZWVsZXJAYW1kLmNvbT4NCg0KDQpUaGFuayB5b3Us
DQoNCkRhbiBXaGVlbGVyDQpTci4gVGVjaG5vbG9naXN0IHwgQU1EDQpTVyBEaXNwbGF5DQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCjEg
Q29tbWVyY2UgVmFsbGV5IERyIEUsIFRob3JuaGlsbCwgT04gTDNUIDdYNg0KYW1kLmNvbQ0KDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSYXkgV3UgPHJheS53dUBhbWQuY29t
Pg0KU2VudDogVHVlc2RheSwgT2N0b2JlciAyOCwgMjAyNSAxMTowMyBQTQ0KVG86IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFu
ZEBhbWQuY29tPjsgTGksIFN1biBwZW5nIChMZW8pIDxTdW5wZW5nLkxpQGFtZC5jb20+OyBQaWxs
YWksIEF1cmFiaW5kbyA8QXVyYWJpbmRvLlBpbGxhaUBhbWQuY29tPjsgTGksIFJvbWFuIDxSb21h
bi5MaUBhbWQuY29tPjsgTGluLCBXYXluZSA8V2F5bmUuTGluQGFtZC5jb20+OyBDaHVuZywgQ2hp
YUhzdWFuIChUb20pIDxDaGlhSHN1YW4uQ2h1bmdAYW1kLmNvbT47IFp1bywgSmVycnkgPEplcnJ5
Llp1b0BhbWQuY29tPjsgV2hlZWxlciwgRGFuaWVsIDxEYW5pZWwuV2hlZWxlckBhbWQuY29tPjsg
V3UsIFJheSA8UmF5Lld1QGFtZC5jb20+OyBMSVBTS0ksIElWQU4gPElWQU4uTElQU0tJQGFtZC5j
b20+OyBIdW5nLCBBbGV4IDxBbGV4Lkh1bmdAYW1kLmNvbT47IFd1LCBSYXkgPFJheS5XdUBhbWQu
Y29tPg0KU3ViamVjdDogW1BBVENIIDAwLzEzXSBEQyBQYXRjaGVzIE5vdmVtYmVyIDMsIDIwMjUN
Cg0KVGhpcyBEQyBwYXRjaHNldCBicmluZ3MgaW1wcm92ZW1lbnRzIGluIG11bHRpcGxlIGFyZWFz
LiBJbiBzdW1tYXJ5LCB3ZSBoaWdobGlnaHQ6DQoNCi0gSERDUDIgRlcgbG9jYWxpdHkgY2hlY2sg
cmVmYWN0b3JzDQotIEZpeCBibGFjayBzY3JlZW4gaXNzdWUgd2l0aCBIRE1JIG91dHB1dA0KLSBJ
bmNyZWFzZSBJQiBtZW0gc2l6ZQ0KLSBSZXZlcnQgbWF4IGJ1ZmZlcmVkIGN1cnNvciBzaXplIHRv
IDY0DQotIEV4dGVuZCBpbmJveDAgbG9jayB0byBydW4gUmVwbGF5IC8gUFNSDQotIFJlZmFjdG9y
IFZBY3RpdmUgaW1wbGVtZW50YXRpb24NCi0gQWRkIFBzdGF0ZSB2aWV3cG9ydCByZWR1Y3Rpb24N
Ci0gUGVyc2lzdCBzdHJlYW0gcmVmY291bnQgdGhyb3VnaCByZXN0b3JlDQoNCkNjOiBEYW4gV2hl
ZWxlciA8ZGFuaWVsLndoZWVsZXJAYW1kLmNvbT4NCg0KQWxleCBIdW5nICgxKToNCiAgZHJtL2Ft
ZC9kaXNwbGF5OiBGaXggYmxhY2sgc2NyZWVuIHdpdGggSERNSSBvdXRwdXRzDQoNCkFsdmluIExl
ZSAoMSk6DQogIGRybS9hbWQvZGlzcGxheTogSW5jcmVhc2UgSUIgbWVtIHNpemUNCg0KQW5kcmV3
IE1hem91ciAoMSk6DQogIGRybS9hbWQvZGlzcGxheTogRXh0ZW5kIGluYm94MCBsb2NrIHRvIHJ1
biBSZXBsYXkvUFNSDQoNCkF1c3RpbiBaaGVuZyAoNSk6DQogIGRybS9hbWQvZGlzcGxheTogQWRk
IHB0ZV9idWZmZXJfbW9kZSBhbmQgZm9yY2Vfb25lX3Jvd19mb3JfZnJhbWUgaW4NCiAgICBkY2h1
YiByZWcNCiAgZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgb2xkIFBNTyBvcHRpb25zDQogIGRybS9h
bWQvZGlzcGxheTogVXBkYXRlIFAtc3RhdGUgbmFtaW5nIGZvciBjbGFyaXR5Lg0KICBkcm0vYW1k
L2Rpc3BsYXk6IFJlZmFjdG9yIFZBY3RpdmUgaW1wbGVtZW50YXRpb24NCiAgZHJtL2FtZC9kaXNw
bGF5OiBBZGQgUHN0YXRlIHZpZXdwb3J0IHJlZHVjdGlvbg0KDQpEaWxsb24gVmFyb25lICgxKToN
CiAgZHJtL2FtZC9kaXNwbGF5OiBSZXZlcnQgRENONCBtYXggYnVmZmVyZWQgY3Vyc29yIHNpemUg
dG8gNjQNCg0KSm9zaHVhIEFiZXJiYWNrICgxKToNCiAgZHJtL2FtZC9kaXNwbGF5OiBQZXJzaXN0
IHN0cmVhbSByZWZjb3VudCB0aHJvdWdoIHJlc3RvcmUNCg0KVGFpbXVyIEhhc3NhbiAoMik6DQog
IGRybS9hbWQvZGlzcGxheTogW0ZXIFByb21vdGlvbl0gUmVsZWFzZSAwLjEuMzQuMA0KICBkcm0v
YW1kL2Rpc3BsYXk6IFByb21vdGUgREMgdG8gMy4yLjM1Nw0KDQpXZW5qaW5nIExpdSAoMSk6DQog
IGRybS9hbWQvZGlzcGxheTogZncgbG9jYWxpdHkgY2hlY2sgcmVmYWN0b3JzDQoNCiAuLi4vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNwLmMgICAgfCAgMTggKy0NCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jICAgICAgfCAgIDQgKw0KIC4uLi9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19od19zZXF1ZW5jZXIuYyB8ICAgNSArLQ0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oICAgICAgICAgICB8ICAgMiArLQ0KIC4uLi9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlL2RtdWJfaHdfbG9ja19tZ3IuYyB8ICA1MiArKy0NCiAuLi4vZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZS9kbXViX2h3X2xvY2tfbWdyLmggfCAgIDIgKw0KIC4uLi9kbWwy
MS9pbmMvZG1sX3RvcF9kY2h1Yl9yZWdpc3RlcnMuaCAgICAgICB8ICAgMiArDQogLi4uL2RtbDIx
L2luYy9kbWxfdG9wX2Rpc3BsYXlfY2ZnX3R5cGVzLmggICAgIHwgIDE0ICstDQogLi4uL2RtbDIx
L2luYy9kbWxfdG9wX3NvY19wYXJhbWV0ZXJfdHlwZXMuaCAgIHwgICA2ICstDQogLi4uL2RjL2Rt
bDJfMC9kbWwyMS9pbmMvZG1sX3RvcF90eXBlcy5oICAgICAgIHwgIDEwICstDQogLi4uL3NyYy9k
bWwyX2NvcmUvZG1sMl9jb3JlX2RjbjRfY2FsY3MuYyAgICAgIHwgIDM5ICstDQogLi4uL3NyYy9k
bWwyX2NvcmUvZG1sMl9jb3JlX3NoYXJlZF90eXBlcy5oICAgIHwgIDM0ICstDQogLi4uL2RtbDIx
L3NyYy9kbWwyX2NvcmUvZG1sMl9jb3JlX3V0aWxzLmMgICAgIHwgICAyICsNCiAuLi4vZG1sMjEv
c3JjL2RtbDJfcG1vL2RtbDJfcG1vX2RjbjRfZmFtczIuYyAgfCAgMjAgKy0NCiAuLi4vc3JjL2lu
Yy9kbWwyX2ludGVybmFsX3NoYXJlZF90eXBlcy5oICAgICAgfCAgNDIgKy0NCiAuLi4vZHJtL2Ft
ZC9kaXNwbGF5L2RjL2xpbmsvbGlua19kZXRlY3Rpb24uYyAgfCAgIDUgKw0KIC4uLi9kYy9yZXNv
dXJjZS9kY24zMi9kY24zMl9yZXNvdXJjZS5jICAgICAgICB8ICAgMyArLQ0KIC4uLi9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfY21kLmggICB8IDQzOSArKysrKysrKysrKysrKysr
LS0NCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydi5jICAgfCAgIDIg
Ky0NCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcC5oICAgfCAgIDEg
Kw0KIC4uLi9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwMl9leGVjdXRpb24uYyAgICB8ICA2OCAr
LS0NCiAuLi4vZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcDJfdHJhbnNpdGlvbi5jICAgfCAgNjEg
Ky0tDQogLi4uL2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9kZGMuYyAgIHwgICAy
ICstDQogLi4uL2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcF9sb2cuYyAgIHwgMTIz
ICstLS0tDQogLi4uL2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2luYy9tb2RfaGRjcC5oICAgIHwg
MTM0ICsrKy0tLQ0KIDI1IGZpbGVzIGNoYW5nZWQsIDY4OCBpbnNlcnRpb25zKCspLCA0MDIgZGVs
ZXRpb25zKC0pDQoNCi0tDQoyLjQzLjANCg0K
