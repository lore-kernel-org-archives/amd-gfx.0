Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2E410ED66F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C2E10EE46;
	Fri, 27 Mar 2026 12:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="OR03DaKq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazolkn19011003.outbound.protection.outlook.com [52.103.1.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AF310EAB0;
 Thu, 26 Mar 2026 23:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwVFkflvKxV3Bj2yIJ1s2abHFa7+MnAWZSa5Re5AKb0HuAOAjN71e3hbkF8vBSv6HuyU3+hIIv9JIFFN/lzEQrGs94UHbcoUvIe/AK5LuCaTxTp+q+IO1EnKcmkmyNCd4s4+JW+Ks89ZLEOpaOY2gO+1vLoZbKZ46pJV+aToLPaHEi8MMMK+xfln48bZz/MSsdQqqhe1YavgBxKr+Ky/Amr03mCcJr0KOW22ttqKdutF5XoYnNmEqb03IrlUnFnt8PbPupK4WUZpcWdopFPyWGaB05bp3cYW/63TqVqNVquJgoQ29o3FgMWTyBCeAwi9wKax968RCwS/D8NqAPWn+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeAV3zk37x8ippwxh/RWAhTmtWeZnWSWX6cCWqY3tVY=;
 b=HlXmzhwQ3UuRK92wtEgI+oJ0lO23SyJEnuojdw9XxctevVWJ4dsqK5BBQ2cO7rbnjGupWeS3HQ8WYRLZ5D/fKUDras9BGifjj0VTF4ZgSROs+in3KG8Wdtche4YoiFLuxLvTu56G9flN+nuDiEgrYm/WI6jywpRrv2TID812GoG1omsA61MNsJt/hr1GvyzBVG0Kig0L3KgLOas8riwqp9Hx2ijZ7RIpXOEc90rB1L5TAhXFOffyWKZUTlLRYVGNcCOLHZibsg9w/u2zi+RFj3L2LlKfk4qW58OVsZbljZ7w8+dUwcIWg0/1dbwRWqoKrx9pXpmmVdE/ZqqVsU4tNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeAV3zk37x8ippwxh/RWAhTmtWeZnWSWX6cCWqY3tVY=;
 b=OR03DaKq+uk5dMg2qwh6rp/ZMGlHFVwDLlNwtzjo0unvJCmyWSBJEQapt22LWtBYwXkuzYOx2PFDGJKPIy9Vg95cvCqV4ISJb7hy5v+YXsWzPSkncHpsQaENUewUxeDREfw9O9PLSzP5RlNc6bhrW7ANriqb86VQe6ODZayNvoXscLpxqJhLTPGGZZ0haIMpgVweiMW2FkxugLfPZO4fxfmeL87aIT44fCMlpxUylslrCHEWfPDEd+WigYOJskmaRGiV3bfNidMKkNjS0E7Ni76XdeAXYF+WDWtdLjfql3cOkM/qeLwz04nDyBpjC8F+oTGeaPStlKaHrzQGfbgviQ==
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com (2603:10d6:103:180::10)
 by CPUPR80MB7126.lamprd80.prod.outlook.com (2603:10d6:103:1fa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 23:38:10 +0000
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d]) by CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d%4]) with mapi id 15.20.9745.023; Thu, 26 Mar 2026
 23:38:10 +0000
From: Danilo Machado <danilomachado2002@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexdeucher@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Subject: [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
 suspend/resume
Thread-Topic: [REGRESSION][bisected] amdgpu/tonga: HDMI no signal after
 suspend/resume
Thread-Index: AQHcvXfXaVbkOs1qKka2GtG54ymSpA==
Date: Thu, 26 Mar 2026 23:38:10 +0000
Message-ID: <CPUPR80MB65830B1F010759315C57CA8BA356A@CPUPR80MB6583.lamprd80.prod.outlook.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPUPR80MB6583:EE_|CPUPR80MB7126:EE_
x-ms-office365-filtering-correlation-id: be4ddf13-7623-44e7-76d0-08de8b90bd89
x-ms-exchange-slblob-mailprops: WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/JxoXSMRUJtzZmeVvcnYsjMq6HzxCZyPL/ek+CqO+JO4b8LQ8TmeG7ippOS/rKzT8ExqvQLUcBUaPku6eV2QLzMJr4xRAu9RE7Aeyz+VdZZK9hVMIVtJqku5+3wdMbSz3CSKCC51E78yyMXTZtLUXdKjChPsC7iZ2aHImx5P8+OKj8Tboi5Hm+oE/wqbjaSjeyi/hUgwqyjm6FRYhr1oKXVbTyFZxYoDgpTUSRZ6FaDwauGIEZ8T09S664cJ5wvpenEXWeRpAawpFk8YLHxjVuH7+zgpBL6wXlyvYwLNcepfe994vAmuBa7Xf0vjX7fVmDKNFP9qm4yjZDMfkt5DP3Sfo4gADCxD3sBeV43aq5RSzdm6REUH7kG5cNSkTuNGT9TsJm59frrwvjxWrVSooOg3Ygs9c21E6Hqgas8dvZotclTdF8mRPgzWBfQg3snTnltEf/XzUhj3sTz3iWtmyjuOxFnhJLCOWYqeCecsfLFPaDCRJzIzB43IUHB+CCzikDzAF/OWhcEc7OY0QFiV+AWtKZTuFSSsl/vpMpeJJrET92A/Kc6IGXB4kT/JqO5SblNB8yuLtKA7OGDUYBuc4Elk0MyjhXYX4JTHS3cuiD82SNFt/mtYnmpFVU3qF/ihKdPVmuVpCgpQWQXc8XUlRDg3pwLwkTQwmzhL5XEVg3vR7s/PIgu2ghQlzb7ldkbgMqTOTZYDWacjBACmrpvQ8hUONGqJBPXBaOrk5ndHFl2Q=
x-microsoft-antispam: BCL:0;
 ARA:14566002|31061999003|19110799012|51005399006|41001999006|461199028|8062599012|8060799015|25031999004|24121999003|22091999003|15030799006|15080799012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info: =?big5?B?R3ZzV3ZKVlpZU2lNOHNISTV5YlpncEM5TVNkM2dDbUZzREx0TDdCdXM2cnFRZFpu?=
 =?big5?B?ZURlbS80Wk8wQzlySUw5UEJUN0xBekQvTkNUbS95eVRNZmh2Nm9nMTh1cHRHN3JR?=
 =?big5?B?YW00cEJzMWlqbTNjUVJ3QTYxN1ZQRElFNko2N1BWMUtlbEVmNGQzQkZYSFN6bGJX?=
 =?big5?B?RjRDRTVVOWMwRUpYc0NYa0o4SmVFeGFCWXZKR28yMWVQZGhXY1FOektsc09pdUJK?=
 =?big5?B?UW9ic1VPUHMzNWRVNWZlV3laRVFsek9aYkR4SWlrdElGV1JGdmZDR0lPL09lVDM0?=
 =?big5?B?akJTbmkrTFFGMFdtVHZ1NG5McnJCTXp1clZVd0NZV0dnUDdwTllyL0o0SGZGOE5U?=
 =?big5?B?QzNRRjZpVDVVMWtJeFRaT1Z2ZFltUFpWN24rRWJnN0xEZkc2WGlKRUp1dWpDOTdR?=
 =?big5?B?UkpQUDViTXhNTWZrVVk5eXQwSFVSK3dLVmpTczAzK1Izb2laeVAzbm5QdmxZUnlm?=
 =?big5?B?VlB1SWhreGdmSTl3bkV1dDdlNzZLTzNGSit1bVRwblZoUVRLUVFGVlEvS2NnS3ox?=
 =?big5?B?QUxNNzh5cXQ4cVh1MDJWVWJwK2lVTnQyNEV5ekpuN0FDQ2taTjlQM1ExRjJQRWJE?=
 =?big5?B?R0FBRmNVN1hGdlg4N21zQ3NyalBDM1pkU05vTmdYNUVBT0M3bU5NSjdPdEZPWFFi?=
 =?big5?B?TUc3MzNnOCs2T0VpVW9lN3pnUkNuYndWSkJaazNMRm80VWVnd1Bia1huWUFxUDVT?=
 =?big5?B?MlFtNkZrUmwxcElYY0xKTVpTUnVCb0piZzRGYVdWMERsbkJORVd0RFBWaHM3RHIx?=
 =?big5?B?WmhBUHY0eUxTa05TSDFvUEtGSUpHdnkyWm1qakg3bUZkWFF2TFZwa211aENVdCt2?=
 =?big5?B?VFFGd3plc1N4dGNOZjYwNDJORG5hSTNBUWlVeC9ja1E3QXN5M291NDFSeGhiMVpL?=
 =?big5?B?MklNVDVSem9hdmYxRlBpUmV6VU1BUTVBQ1UzalEzM0t6bjhvSVVNVThzTVZzSFM1?=
 =?big5?B?d0FoVHdXM1lnRlRabWo5MU5xcWdWd2RQb09CZkZCK0xSYUVjLzRnMkVFTVZsWXZV?=
 =?big5?B?dHJFNFhNOHYyNUtZUmc5ekxadno5WEdvVkNaOFNycHNrVGZRQmN4SmppZnpOMDJL?=
 =?big5?B?Vjk4cVMyRHhsakZSRFNjSHRnYTBqKzVYZmlpTzZtd0NRalkrY3FvMHlOaHdkK05h?=
 =?big5?B?WG9EMmhDdGNKaGpZTTZoZEJQS1FrLysxa2kyQlo5aHo1cDFpaVI3VTBVYXM1dmlT?=
 =?big5?B?WkJIY2ZmVzdCQkJ0WkFjOEJaSWNHOHNuc1dwMEhtYzBhdndYcldWK1FTUUpsUkor?=
 =?big5?B?bWZDQmtzSDVGRU9WRDhFRUtxejlYbmdja2xnbDdoR2x3RXZtVnhNQUdxQy9qUnFW?=
 =?big5?Q?C0/SOf9P6oi4fQoffPGY0yGWemHngeZX?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?d1hDaDNEdGc4OG96NmRhWFJFS2h6NTduTGh3WEhaRDdVZUpSdmVJY2dTRGM3ZEhJ?=
 =?big5?B?Q2FQcjNGM0hKZWFQdXJ4VHdLUjg1V25GUjZiQ2dHdXhrZ293cENUTXNIa1RCU0VU?=
 =?big5?B?UmcxWjRMUm5RNEQ0SlhTT201cEJRdWxZSVBBMGVWdHVLQi9CZSt5R3lGM2tpTElJ?=
 =?big5?B?VE1JVHp1QXY2MXJ2eFJrMTk0VWN0Q1JvSW1jb09GNEp2dlFqNnBxaU1uaXJTS1Ja?=
 =?big5?B?a1FYTTAvb3JoU1ZkaWQ4U2R2dXJoYmQ1N1BYUFo0Y3hvYnZ3WVRoaldlZlVXOWZW?=
 =?big5?B?M2hjZmlJVk1OM0orSHJMbG8xQ3lCNFJSaG1lY0NIUjQ4QUlOM3Fjay9rUmF0aXBY?=
 =?big5?B?VjJMbkRMQ0ZHUnR4WmJrNEJjTzNBelZIZEh0Y0xnUys5R2ZSSTBtVkdxYWtickZs?=
 =?big5?B?bGdtdHNPSHExRDhuSmVLaW8rRDZFdUlCeEZMOFJsNS9mUCtVU2lFTm5RTDNIUDIr?=
 =?big5?B?SEU3dWdpWnRZQzREc1ZsK3NJZFhjNWVadk1Bb09zTEQ4ZEpGdGN2UVMzSVNuRWRB?=
 =?big5?B?ZTM1RjhHa05HaXNoSUtNUHVwb1doMnkyRXhLT2FjK0ZWUkNuVkt3VURYK2RrM01i?=
 =?big5?B?VUJQWDFjSzFFdUxKSVBDTXZhdU9SNzl4MnpycVA2eHRKRm5YSFhId0szbDNVR3Fq?=
 =?big5?B?WVIzeG5rVGNwYmwrUFV6MnpYTlZNaHdXVkxQcW1Ta0JQL2h4aTFHQklHV1p5VktJ?=
 =?big5?B?Y2xKUVlUalhyVUVwWnVxcUJvWkdyKzRUVkJyaDhXNTViTWZnK3NjY3NXQW1LcDVR?=
 =?big5?B?enF0YmZmNUFIQjhWN3FEY0M5YjZuQUc1QnZHWm10Y0RhbUV5NlRyM0pOTDJvRGVk?=
 =?big5?B?MmdTWllSaWRnQS9YWXhRVzFOOWs4Q0JlWmNDWk1PN1M1RllDNXdyNkZnWkp6M1Zr?=
 =?big5?B?UGNzbXc5eFdNcEFoTVFJVVR1WURSVFRqeGI2RW5Md1Q4S1p5ODVpMEg2L0hWT3dR?=
 =?big5?B?a0xEUmkxNTFyMm5xUkROanVXZHJyN3JoODRSdVFSMkswRlBpc1ZCNHVWeER6czN6?=
 =?big5?B?dmNzLzMvWm8wSnhhK25zN001VkVYUnBqRlJ4ejZFZGVuUFZQSm14SGVsbTE5b29O?=
 =?big5?B?TTdvK0pDWW9MVkZ5ZXQ4ZFNiY3MwMi9QSk9uTk5VZ0tPendocGxiMWhkbVZxOUdL?=
 =?big5?B?SXV3NjQxVEF0cXo2WGRZeG5Yd2oyZTNWVmFMZTNRWVpldzg0R3VVQjlGSzZIWFlR?=
 =?big5?B?eEJLbnMvMFI0QkdFYkgxS3VpeVk4YnhlbHp0b0xnWWZGS2c2M1E3YlVXL05Sblh1?=
 =?big5?B?QnZ1MEExMWt1aDhkbDRONFJ0UHZTb0hJNXgzRHBENWtjeG5QWi9TVWVySlByWTV4?=
 =?big5?B?bzhIWUlaQ1MwbXZJWHpZTUl3a1dzQXdLWjIremN4RFkraWJMbUFpQUg4VEx1dG5R?=
 =?big5?B?YjlRUVBhdzF4a0xTOWpyUlZGd2N4Nk5rcFV1emplVk1UNE9xaUs2TWdCVyswbXNU?=
 =?big5?B?bk1hUStwaGZiT0FSYTAzNm9hRENvUWJHT3lhZWM0UlcwZmViNFppYUttd1F6RHNF?=
 =?big5?B?c1ZTSGhGejRWSHBrakNER0VNNTN4OWtFSWdCMDk4dWROVkd3blBxM1ppRlp4QU56?=
 =?big5?B?MTUzdWszSjI4SWtaNCtidVNuOWErUGhpOXZJVDRPbHFGUkpwR1A5TE5ZK1FIZEpk?=
 =?big5?B?cFlrZFZuamNnYkYyNm1kZ2hxZHJBM2VFUWdNcHNiODFFQ0w1Yi91SGNDbjdEZHo5?=
 =?big5?B?eE9SYUVaTGdQYlo1YTQrYkVkOERvT3YybytrWXJYWHRPWXRaaXZWRjhzMUIyZWV5?=
 =?big5?B?dUVxZ2JCRm1VdVgydFBzWm1vcTA5UmhzMXVkWHEwRFRyTVZTZnBhaWxFOGUraXBN?=
 =?big5?B?YVMzRUF5YjlWQkhxM01Tb0RibGFUVXZZdFZsT05qTm1LdkxxTWlGMUs5aHRkMjYx?=
 =?big5?B?ay9lQlpnPT0=?=
Content-Type: multipart/alternative;
 boundary="_000_CPUPR80MB65830B1F010759315C57CA8BA356ACPUPR80MB6583lamp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-665fe.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPUPR80MB6583.lamprd80.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: be4ddf13-7623-44e7-76d0-08de8b90bd89
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 23:38:10.4166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPUPR80MB7126
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

--_000_CPUPR80MB65830B1F010759315C57CA8BA356ACPUPR80MB6583lamp_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpUaGFua3MgYWdhaW4gZm9yIHlvdXIgZmVlZGJhY2suDQoNCkkgdG9vayBhIGNs
b3NlciBsb29rIGF0IHRoZSBiaXNlY3QgcmVzdWx0cyBhbmQgc3lzdGVtIGJlaGF2aW9yLCBhbmQg
SaGmZCBsaWtlIHRvIHByb3ZpZGUgYSBtb3JlIGNvbXBsZXRlIGFuZCBjb25zb2xpZGF0ZWQgcmVw
b3J0Lg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpIYXJkd2FyZToNCg0K
ICAqICAgR1BVOiBBTUQgUmFkZW9uIFI5IDM4MCAoVG9uZ2EsIEdDTiAzKQ0KDQogICogICBDUFU6
IEFNRCBSeXplbiA1IDU1MDANCg0KICAqICAgUkFNOiAxNiBHQg0KDQogICogICBEaXNwbGF5OiBI
RE1JDQoNClNvZnR3YXJlOg0KDQogICogICBEcml2ZXI6IGFtZGdwdQ0KDQogICogICBLZXJuZWwg
cmFuZ2UgdGVzdGVkOiA2LjMgKGdvb2QpIKH3IDYuNCAoYmFkKQ0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KDQpTdW1tYXJ5Og0KDQpUaGlzIGlzIGEgcmVwcm9kdWNpYmxlIHN1
c3BlbmQvcmVzdW1lIHJlZ3Jlc3Npb24gYWZmZWN0aW5nIEhETUkgb3V0cHV0Lg0KDQogICogICBM
aW51eCA2LjMgofcgd29ya2luZyBjb3JyZWN0bHkNCg0KICAqICAgTGludXggNi40KyCh9yByZWdy
ZXNzaW9uIHByZXNlbnQNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KQmVo
YXZpb3I6DQoNCkFmdGVyIHN1c3BlbmQvcmVzdW1lOg0KDQogICogICBIRE1JIG91dHB1dCBkb2Vz
IG5vdCByZWNvdmVyICgibm8gc2lnbmFsIikNCg0KICAqICAgU3lzdGVtIG1heSBmcmVlemUgdW5k
ZXIgWDExDQoNCiAgKiAgIFdheWxhbmQgZG9lcyBub3Qgc2hvdyB0aGUgc2FtZSBoYXJkIGZhaWx1
cmUNCg0KQWRkaXRpb25hbGx5Og0KDQogICogICBVc2luZyAiZGVlcCIgc2xlZXA6DQoNCiAgICAg
KiAgIGZ1bGwgc3lzdGVtIGxvY2t1cCBhZnRlciByZXN1bWUNCg0KICAqICAgVXNpbmcgInMyaWRs
ZSI6DQoNCiAgICAgKiAgIHN5c3RlbSByZXN1bWVzIHdpdGhvdXQgaGFyZCBsb2NrDQoNCiAgICAg
KiAgIGhvd2V2ZXIsIGdyYXBoaWNhbCBzZXNzaW9uIG1heSByZXR1cm4gaW4gYSBwYXJ0aWFsbHkg
YnJva2VuIHN0YXRlDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCkJpc2Vj
dCByZXN1bHQ6DQoNCkEgZnVsbCBnaXQgYmlzZWN0IHdhcyBwZXJmb3JtZWQgYmV0d2VlbiBMaW51
eCA2LjMgYW5kIDYuNC4NCg0KRmlyc3QgYmFkIGNvbW1pdDoNCmIzYzk4MDUyZDQ2OTQ4YThkNjVk
Mjc3OGM3ZjMwNmZmMzgzNjZhYWMNCigiTWVyZ2UgdGFnICdrdm0teDg2LXZteC02LjQnIikNCg0K
QWxsIGludGVybWVkaWF0ZSBjb21taXRzIGluIHRoYXQgcmFuZ2Ugd2VyZSBjb25zaXN0ZW50bHkg
dGVzdGVkIGFzIEdPT0QuDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCkFu
YWx5c2lzOg0KDQpBbHRob3VnaCB0aGUgYmlzZWN0ZWQgY29tbWl0IGlzIGluIEtWTSBhbmQgdW5s
aWtlbHkgdG8gZGlyZWN0bHkgYWZmZWN0IEFNREdQVSwgdGhlIHRyYW5zaXRpb24gcG9pbnQgaXMg
Y29uc2lzdGVudCBhbmQgcmVwcm9kdWNpYmxlLg0KDQpUaGlzIHN1Z2dlc3RzIHRoZSByZWdyZXNz
aW9uIG1heSBiZSBpbmRpcmVjdGx5IHRyaWdnZXJlZCAoZS5nLiB0aW1pbmcgb3Igb3JkZXJpbmcg
Y2hhbmdlcyBkdXJpbmcgcmVzdW1lKSwgcmF0aGVyIHRoYW4gY2F1c2VkIGRpcmVjdGx5IGJ5IHRo
YXQgbWVyZ2UuDQoNCkJhc2VkIG9uIG9ic2VydmVkIGJlaGF2aW9yLCB0aGlzIGFwcGVhcnMgcmVs
YXRlZCB0byB0aGUgZGlzcGxheSByZXN1bWUgcGF0aCwgcG9zc2libHkgaW52b2x2aW5nOg0KDQog
ICogICBEQyBzdGF0ZSByZXN0b3JlIGFmdGVyIHJlc3VtZQ0KDQogICogICBIRE1JIGxpbmsgdHJh
aW5pbmcNCg0KICAqICAgRURJRCByZS1yZWFkDQoNCiAgKiAgIGF0b21pYyBtb2Rlc2V0IHN0YXRl
IHJlY29uc3RydWN0aW9uDQoNClRoZSBkaWZmZXJlbmNlIGJldHdlZW4gImRlZXAiIGFuZCAiczJp
ZGxlIiBhbHNvIHN1Z2dlc3RzIGEgZmFpbHVyZSBkdXJpbmcgZnVsbCBHUFUvZGlzcGxheSByZWlu
aXRpYWxpemF0aW9uLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpDb25j
bHVzaW9uOg0KDQpUaGlzIGFwcGVhcnMgdG8gYmUgYSBsYXRlbnQgaXNzdWUgZXhwb3NlZCBieSBj
aGFuZ2VzIGludHJvZHVjZWQgZHVyaW5nIHRoZSA2LjQgbWVyZ2Ugd2luZG93LCByYXRoZXIgdGhh
biBhIGRpcmVjdCByZWdyZXNzaW9uIGluIHRoZSBiaXNlY3RlZCBjb21taXQgaXRzZWxmLg0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpJZiBoZWxwZnVsLCBJIGNhbiBhc3Np
c3QgZnVydGhlciBieToNCg0KICAqICAgcHJvdmlkaW5nIGZ1bGwgYmlzZWN0IGxvZ3MNCg0KICAq
ICAgY2FwdHVyaW5nIGRldGFpbGVkIGRtZXNnL2pvdXJuYWxjdGwgYmVmb3JlIGFuZCBhZnRlciBy
ZXN1bWUNCg0KICAqICAgdGVzdGluZyBwYXRjaGVzIG9yIGRlYnVnIG9wdGlvbnMNCg0KICAqICAg
bmFycm93aW5nIHRoZSByYW5nZSBmdXJ0aGVyIGlmIG5lZWRlZA0KDQpJIHJlYWxseSBhcHByZWNp
YXRlIHRoZSB3b3JrIG9uIEFNREdQVSBhbmQgd291bGQgYmUgZ2xhZCB0byBoZWxwIHdpdGhpbiBt
eSBsaW1pdHMgdG8gaW52ZXN0aWdhdGUgdGhpcyBmdXJ0aGVyLg0KDQpUaGFua3MgYWdhaW4gZm9y
IHlvdXIgdGltZS4NCg0KQmVzdCByZWdhcmRzLA0KRGFuaWxvDQoNCk5vdGU6IEkgaGFkIHNvbWUg
ZW1haWwgY2xpZW50IGNvbmZpZ3VyYXRpb24gaXNzdWVzIGVhcmxpZXIsIHdoaWNoIG1heSBoYXZl
IGNhdXNlZCBkdXBsaWNhdGUgbWVzc2FnZXMgb3IgZm9ybWF0dGluZyBwcm9ibGVtcy4gVGhlc2Ug
aGF2ZSBub3cgYmVlbiByZXNvbHZlZCChWCBhcG9sb2dpZXMgZm9yIGFueSBpbmNvbnZlbmllbmNl
Lg0K

--_000_CPUPR80MB65830B1F010759315C57CA8BA356ACPUPR80MB6583lamp_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Hi all,</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Thanks again for your feedb=
ack.</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">I took a closer look at the=
 bisect results and system behavior, and I=A1=A6d like to provide
 a more complete and consolidated report.</span></p>
<hr>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Hardware:</span></p>
<ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
GPU: AMD Radeon R9 380 (Tonga, GCN 3)</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
CPU: AMD Ryzen 5 5500</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
RAM: 16 GB</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
Display: HDMI</p>
</li></ul>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Software:</span></p>
<ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
Driver: amdgpu</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
Kernel range tested: 6.3 (good) =A1=F7 6.4 (bad)</p>
</li></ul>
<hr>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Summary:</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">This is a reproducible susp=
end/resume regression affecting HDMI output.</span></p>
<ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
Linux 6.3 =A1=F7 working correctly</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
Linux 6.4+ =A1=F7 regression present</p>
</li></ul>
<hr>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Behavior:</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">After suspend/resume:</span=
></p>
<ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
HDMI output does not recover (&quot;no signal&quot;)</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
System may freeze under X11</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
Wayland does not show the same hard failure</p>
</li></ul>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Additionally:</span></p>
<ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
Using &quot;deep&quot; sleep:</p>
</li><ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
full system lockup after resume</p>
</li></ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
Using &quot;s2idle&quot;:</p>
</li><ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
system resumes without hard lock</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
however, graphical session may return in a partially broken state</p>
</li></ul>
</ul>
<hr>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Bisect result:</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">A full git bisect was perfo=
rmed between Linux 6.3 and 6.4.</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">First bad commit:<br>
b3c98052d46948a8d65d2778c7f306ff38366aac<br>
(&quot;Merge tag 'kvm-x86-vmx-6.4'&quot;)</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">All intermediate commits in=
 that range were consistently tested as GOOD.</span></p>
<hr>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Analysis:</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Although the bisected commi=
t is in KVM and unlikely to directly affect AMDGPU, the transition
 point is consistent and reproducible.</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">This suggests the regressio=
n may be indirectly triggered (e.g. timing or ordering changes
 during resume), rather than caused directly by that merge.</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Based on observed behavior,=
 this appears related to the display resume path, possibly
 involving:</span></p>
<ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
DC state restore after resume</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
HDMI link training</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
EDID re-read</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
atomic modeset state reconstruction</p>
</li></ul>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">The difference between &quo=
t;deep&quot; and &quot;s2idle&quot; also suggests a failure during full GPU=
/display
 reinitialization.</span></p>
<hr>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Conclusion:</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">This appears to be a latent=
 issue exposed by changes introduced during the 6.4 merge
 window, rather than a direct regression in the bisected commit itself.</sp=
an></p>
<hr>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">If helpful, I can assist fu=
rther by:</span></p>
<ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
providing full bisect logs</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
capturing detailed dmesg/journalctl before and after resume</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
testing patches or debug options</p>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof" =
role=3D"presentation">
narrowing the range further if needed</p>
</li></ul>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">I really appreciate the wor=
k on AMDGPU and would be glad to help within my limits to
 investigate this further.</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Thanks again for your time.=
</span></p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof">=
<span style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">Best regards,<br>
Danilo</span></p>
<div class=3D"elementToProof" style=3D"font-family: &quot;Calibri&quot;, &q=
uot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Note: I had some email client configuration issues earlier, which may have =
caused duplicate messages or formatting problems. These have now been resol=
ved =A1X apologies for any inconvenience.</div>
</body>
</html>

--_000_CPUPR80MB65830B1F010759315C57CA8BA356ACPUPR80MB6583lamp_--
