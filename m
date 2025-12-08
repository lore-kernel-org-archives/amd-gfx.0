Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45294D3B7E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 13:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D2610E120;
	Mon,  8 Dec 2025 13:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ufar4ldZ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013065.outbound.protection.outlook.com
 [40.107.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3215A10E120
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 13:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b71WaTQgsaO/sK+4NVQY1Yp9tpWvEMW1nAPP09IGij6kwPFQTM2aOzt1GQpuPr80g/NsPZsh/CFRCm1hB+FVG2Bk1ExFhHej8TJDVXH+Qs2ov1YfOlN1jXtzgJi8hPvr/+61sbGSOm7IaZoHV9cwVcPVsQ/ZQg+HVyiPE5IUO7U2RQogZ5OHDNeHb8+3NCICVxAXBxyv/gKukL//U2in4+Po91wHEF9+KXyUtJl6vpm+Dbr3M059Y+aW/AJnVhinJX4pXYPdDeFZvUHgXITbYaiKcsJWY2cu1ZPlhqA6e8Jwyo4Juw8FhZx0BrzkNehv086GWkvKfsEPqGgMFwgyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjHOY6H/QLEPIZyTOOJRMacb3PCe8BUxw57Te7+6khY=;
 b=tFrXFdcsEHYFWlcgY5tkA9N+Py2TI8v5M45vbQ1pdathyCG3j8ooRvOegiSsZw0AeK6bDU2GuhNkMibqiugqCeivjrLOpwVLkU+Ep54vaQg/gSEWmRxABFlcZ/OZ5Rz+DK7qWmf4+KOY8t5/ZDbAT9dNYjuG4m3xSXzsSvfKirCcot59DACTh4lcjY/7g6Kali+KoDrn1vvh3DPbi6KTtqQ9hQq3sT2n2QfXV7dhGEPObDgiyD1aivEdCyeuABBCMpTr4HoHsvrwLW1+iLeLwQ4NIPir9sNJidVEI+EdBtjeUmq0uguqc9cxI4D0wJdJTB/ZEtpfPZvSkgZv9Ucm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjHOY6H/QLEPIZyTOOJRMacb3PCe8BUxw57Te7+6khY=;
 b=Ufar4ldZnaJoZXRF2D6/s1x8n+uoA0jmD6DF7sY9UqU9OJegiAL7q6dGQNAJhJI488boPJreCoUj8G+yvjvYGuBibRGKUzEo3mypt8s8+kjfYtqSc6SvCoxaqTDkRT5MXYghw0rrcKZY9gufEqga03Ys3ShrY/eVgo+BR+0909o=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 13:33:14 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%6]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 13:33:14 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Reduce stack usage in
 amdgpu_userq_wait_ioctl()
Thread-Topic: [PATCH] drm/amdgpu: Reduce stack usage in
 amdgpu_userq_wait_ioctl()
Thread-Index: AQHcZeC1ZAqdfoFcC0qf2f2BeTJcMbUTAnqAgASyOOA=
Date: Mon, 8 Dec 2025 13:33:14 +0000
Message-ID: <IA0PR12MB8208664A9332F0AB67C5A1CD90A2A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20251205121414.408466-1-srinivasan.shanmugam@amd.com>
 <245cd9a1-6a67-4970-a71f-ffc37563ac20@amd.com>
In-Reply-To: <245cd9a1-6a67-4970-a71f-ffc37563ac20@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-08T12:43:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|CYYPR12MB8924:EE_
x-ms-office365-filtering-correlation-id: bb3b237f-c68d-4f89-6261-08de365e569e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dDJxZ0l5MnZQNzdVM1A0QWRaWFRYS3BhUFdvb3BENmYvT1hld1g2d2ZKbFZC?=
 =?utf-8?B?Z1oxT3BNMHhPcjYzRXAvNFNJYnRrUmtDbHB1eDI5VmtQMVRqQUNCaGxtUDJL?=
 =?utf-8?B?azJpVGZWb1d3dkVTZGNWT3RiMXoxbm9UQnNOeEFibEZ2M1Jwb2hobFJzelZY?=
 =?utf-8?B?WUNpd0czSnR1WlZVK3V0RzlhR3I4azMxbTl4bk1oSUo5Y1dPNVBEbENESjkr?=
 =?utf-8?B?L0ZRU3lsUWtsdURQU0trMWZ5VzRnVnhxZWFsK2o4MEtTT05GcEtleXovVGg0?=
 =?utf-8?B?bFcyZ1hVSVpNTEpIRklqdFNRaTNQVXZXWmF3WTZFUHVCUlRlRExzc3pkT2J1?=
 =?utf-8?B?VFp3WndwSXZpQ2ZUcTlWUk52TlM0Y0I3VHhjd3dwdWF0TWhyNmRtSXcwNVRn?=
 =?utf-8?B?N3dGWUgzWjVlK24razM0VDh3N09pR01EQTJndm1Ka3NyRXRyMDBuRTB2b0dL?=
 =?utf-8?B?U21GbVhIc1lqQksrQmlidWpUSGozMUVPWkw1NUsxcjgxSzdNNlBhK3R0Mm03?=
 =?utf-8?B?QTVCWUd6bi9RSW9aT2IzZTdnRDB0T3ZVMHY3YUtpWmpicDgxbTUyNlJHZlFB?=
 =?utf-8?B?YjV1ZjR4REd3aTV1Um9MMnY4cStzUWpnaGRJbVBwSFBSeUR6RVp5ZDJCaUxY?=
 =?utf-8?B?RzB1RjIyMzhnRUhza0hqZXdVbWgzdVY2bnI5WFdRN3ZPd3pWMUNEUjdxTGVw?=
 =?utf-8?B?bHNVQ0NhSldsaDd6YzdQOTkrbUhhRi85WW1iNEp4MTJRTlcvdmdUYnB0NjJB?=
 =?utf-8?B?bkdRU2RGa09aa09WbHRIUW1rSFE1MXNVcFNEUmUvSFBFVFNUcXljcmRzdS9p?=
 =?utf-8?B?TkZqSVZHditYNVpiNmtUR3p5RTBHUkhYOUVncVp0MHJmZUFBZnpZcDBzSlNB?=
 =?utf-8?B?Sm5qQUFNK2tkZjBsTnJUMUlDTytXbGpSR1Rsdkp4VjRiQWJVbWdLdVJtMW1w?=
 =?utf-8?B?aXRTc2R0OFpqTUpFKzNZaTRkVEJXYXE5b0FmbWlsMTBBeTRKT01IN1luRzUw?=
 =?utf-8?B?aE92NW5CQW5rYU94eHp3Ymw3cmdvdE9GVTZVemFxaU5rTDZrOVhoUHp0K2F3?=
 =?utf-8?B?V1FwQ0ZWOUhOY3RIazZkdU5XN1czam5LU0JYMG02Ri84cXNsZmlaTlZJeXM3?=
 =?utf-8?B?b3dnTkFJeUFjdGh4T0didmhEQnNQd3JVd0VsdU9QSmJEaVB1LzRLNk9vdDZm?=
 =?utf-8?B?YXhaMFRjSUMxdytPTStuU2JWekxySGxYQzdFOVd4ZTA4Nm9DNGYzVUNBY0RN?=
 =?utf-8?B?M2M3aTZZTTNtR0RLZlNvN2M5eXlqUnlGM2Y1NWJJaFFHREdoSnhmN3Bra293?=
 =?utf-8?B?N1hNZ2lRT3pSR01qcWxXeUd6REg5Ulo1WTRBYzEvNmZGcXU3MGJybmhkNXN1?=
 =?utf-8?B?SDFuR2wySG1UblpIcDNZV0E0Qmlpd2VxcVNwdnFHZFBvR3BLVVU1ZmQzdHBk?=
 =?utf-8?B?MHRKNzJGOFFGWGhLaitnK0U0T1N4dzFWMTkxeWMrdm84bUZLTTJkTVJpU2NQ?=
 =?utf-8?B?SzBNck9VQW9Lc2xwRlppUitPQUdmMjRXTktBS3BGTGNoNW9YQnFNNmovRDh4?=
 =?utf-8?B?Q0lIWXJkcmFXREYzSUk0OGEybnFnS0F1QlEvTnU0clpaalNPK1BTcWdrY1hi?=
 =?utf-8?B?NXRNbnhJTjlURGk5eVY4elBrRnRHbTZOSFRGNHB5M0tFcDBaYndpUjRTMnd5?=
 =?utf-8?B?bnNEYVU5eEJiL0RHOHNSa1NQTm91eWJ0TC9DN1R2QWZLUWhaaEJ4WWJpYTJ2?=
 =?utf-8?B?YU9IUUIyY2RWR2RkcFlYdlFscXJhV2loYmg4VmhMdWFSajdyMnZSQ2Z0Nndl?=
 =?utf-8?B?NmR2d1lCRGwyV1UvZng2NFc1QllMeTBiYkRPb2tmTHpJSGN0WXZKT0poTTQ4?=
 =?utf-8?B?cXQvdzZwK3VUV3lCWSsxcnB6WmdGU2QyOFB1TmNDb1BML2NHRWlhdWdIeFdV?=
 =?utf-8?B?Lzg2S1NzK05OcTNXQWhPS3dUVWI2REwxeUxZSnorc0JvOVNac1pZS0w4Y25h?=
 =?utf-8?B?bVZ6UUxabG9mQXNMY0hEamVUUHJIZzlFcVhmK25TeVptcmJNY2R0NXNiaXVm?=
 =?utf-8?Q?G3db1p?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG1lWXJhNjYxUnVUcTZtSUtBc2d6Yng5dXNKZnM4WkxZeHl4OCs3R0o3RHN0?=
 =?utf-8?B?ZlNkQ1hkYkc4ZVdiZk9LZ2FIZTNEbFNtS1ltdjdNZTl1R1h4K1BLNzVjRkFz?=
 =?utf-8?B?azNlV0pjc0NJS1ZOQ0t1Rk0rcTEzYzdxaG0yZXdPWkJPNE5Ucm5ZM0NBUStR?=
 =?utf-8?B?SWl3TzdhRk44cDZDLzQvYWE5NE5neTVGUVlHQld3UlRUNzBXZGJ2TUQrcWhr?=
 =?utf-8?B?Q1hXNG5CcTg2aEMzTDVIcHB4WEEzUzM5YVo0bWZucHNPZ2wwSEZpNFFManZI?=
 =?utf-8?B?ZWJhSkxqZlpwRExzcUV3a3Qwc25SdElQZzBHVzU2bUJvS25SeUFlOG4waXZr?=
 =?utf-8?B?WG56aHBoMTJ2WldacWRPUUVQVXRxWU1sNCt5Q3E3ZnpaNUxwSTNKMHBPL0Fy?=
 =?utf-8?B?K1hIcDhPT3ZFNDg4eitNYU5kbW1JQ0MzT2tJZmZXTVNqZzZZcWNjS3YvU0Nl?=
 =?utf-8?B?emZtNnZEWFNUKzR5Nk5hN3FTUHM5clpYU21tVjRmVVZmMnhZL1VyVTdmb1Nu?=
 =?utf-8?B?aVlvZlpyUDlndWVJTEkwZ1QrejUvcWV3TUk5azNIQ2JEMmI2SUNUdUg0a0Nr?=
 =?utf-8?B?OW1Qb0VCMEdyUkx3MzhxVEMrYzhsd01Ma3h1blpyQWl3SncyaExtci9wdk5Z?=
 =?utf-8?B?aDkwdXFCdk43cCtWeE0vbzMyVnN1YjAvK1YzVWF0MkhoMXhLNWl2MDRxak1C?=
 =?utf-8?B?RU1iLy9sRHdsS01GTEhkYnU1ZDFnM0FndDBKa1RPN25wdFh3QnJoMkdGRTc4?=
 =?utf-8?B?N2cwbVh0dW8rVm91NEpJMi9sbFRSU1psamwwNy82VjU4NU1VMHBodFQ3a1g0?=
 =?utf-8?B?Y1JUbDdFKzY2UGM0eTZOMklhZnQweklzcWxVWDJ1Rm9RVmFMV29LaE51QVFn?=
 =?utf-8?B?QmlMMUtNL1ZwOGZ1RFU0dFlSVXAybS8rT0VzL0dsbGtLc1o0UXRZZUNzc2dI?=
 =?utf-8?B?bHRYZ0JYMmtWWW5yNzBCNEowNEpDZ0wweDZ6cmJGa3Zqb0RTUEUxemlNUjJu?=
 =?utf-8?B?d2N5UjVaWGtSbVNCN20vZFNSa0s0MmZLajJxem12M1c2RDBNVUhEMWdQcE14?=
 =?utf-8?B?SmNJMFpHdi9Oa2Jabzc3WHVtTG9vamwydnp2RW9iOUptYVNCRjdKaFpZMnpF?=
 =?utf-8?B?WnlyYXJLKzhlVDk2VlBleUZ3YTFseTNzRTBVOHg1MEg4QmZucnpqcHhtVXg0?=
 =?utf-8?B?YVlJUUtSZFY2RUZadTV6aSs0b2tlM0drZ3RORk1XYTJDU2p3ODQyblNXWS8z?=
 =?utf-8?B?bU4wNWo2Zmtka2JNY1hHZmxQY3VwRUQ4R25aVXB3QjY0Y1JPKzA3cmZxQ0Nl?=
 =?utf-8?B?bWszdmErNFdwU3B0L2FJcWxJMUN4WUMvRThlNHI3cktFRmpEMjc5TzVKazFO?=
 =?utf-8?B?UlhyeFdHeE1GQW1SSmV3N0tPTjEyQW5hY3BpWjFsNGpnNnlSM1hZOVlrazgy?=
 =?utf-8?B?QkdnSnhRQTlpaTZUQUNHTEtkQWhZd0x0cWhYNGo3Y2MzT1NNSnNMTEpHZFR5?=
 =?utf-8?B?QzFUNWNlVjFWb2U0ZmlKM1dGSm9BWlNtejR1dmNlNlhUaWdUT25Gc25IYWV4?=
 =?utf-8?B?KzdndU1FT1lLaWcyaXRENnlsRHBOSkpQZkdPbXZDdGRyQkV4aXJmYnpEU3VY?=
 =?utf-8?B?QVQrdys4RXA4N1dHOUhZc0JJa2NPVXRNSXRjZmR3dk9mNU40UWlzOTMrZWtJ?=
 =?utf-8?B?R21XWHR1SFJSMnRVV0RPdHQ1NWhHa3FCcDVpU1R0Q0tWN3pPdEhJQTNBcmZj?=
 =?utf-8?B?NkhTMGxLbThQeUpCSnFkZlg5Ty93WmZldDNlRjF4ZXQvMEhIOVg2L0dXYWlo?=
 =?utf-8?B?UTNYRTVGUjYweDNVNlprZVdzQ0krTUEvVXNIVWtVYTVSZlhxYUE2Zzl5bjVF?=
 =?utf-8?B?djFrYmpIUnpONzU3eWMvem1QNmgwU09tMkIxczEzWnZVcUxBZjVwbHNLU1ZU?=
 =?utf-8?B?cUFCcnhON0YwRGI3RUxnY0Nzb0VMOUlDQUxnNzJyZW9Nd1AxQ2pZMlhzckh3?=
 =?utf-8?B?aHh0b0RXSHpkZXdYQ043azNHOG1maUxzMXVlYWtkaDNJdXhUSStHNnJZaUJB?=
 =?utf-8?B?YXAzTGFVQ3Q2NTNMenR1TjhzZ3IxaDhhcVNWZG1OdEdzeUZwV2lyeDNhVjVI?=
 =?utf-8?Q?uoJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3b237f-c68d-4f89-6261-08de365e569e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 13:33:14.1074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKjGEtG3/Mw8DEXrAojLatLyEnr+eTTZyvvE1cWhQwjS4kQ3xHWjBqX/LRHp2WjKKZgHenfSIOUHcmnrdQW37g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDUs
IDIwMjUgNjozMCBQTQ0KPiBUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNI
QU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogUmVkdWNlIHN0YWNrIHVzYWdlIGluDQo+IGFtZGdw
dV91c2VycV93YWl0X2lvY3RsKCkNCj4NCj4gT24gMTIvNS8yNSAxMzoxNCwgU3Jpbml2YXNhbiBT
aGFubXVnYW0gd3JvdGU6DQo+ID4gQ2hlY2tlZCBhbGwgdGhlIGxvY2FsIHZhcmlhYmxlcyBpbiB0
aGUgZnVuY3Rpb24uIE1vc3Qgb2YgdGhlbSBhcmUNCj4gPiBzbWFsbCBudW1iZXJzIG9yIHBvaW50
ZXJzIGFuZCB1c2UgdmVyeSBsaXR0bGUgc3RhY2sgc3BhY2UuIFRoZSBvbmx5DQo+ID4gbGFyZ2Ug
aXRlbSBzdG9yZWQgb24gdGhlIHN0YWNrIGlzIHN0cnVjdCBkcm1fZXhlYywgYW5kIHRoaXMgaXMg
d2hhdA0KPiA+IHB1c2hlcyB0aGUgc3RhY2sgc2l6ZSBvdmVyIHRoZSBsaW1pdC4NCj4gPg0KPiA+
IFRvIGZpeCB0aGlzLCBzdHJ1Y3QgZHJtX2V4ZWMgaXMgbm93IGFsbG9jYXRlZCB3aXRoIGttYWxs
b2MoKSBpbnN0ZWFkDQo+ID4gb2YgYmVpbmcgcGxhY2VkIG9uIHRoZSBzdGFjay4gQWxsIGNhbGwg
c2l0ZXMgd2VyZSB1cGRhdGVkIHRvIHVzZSBhDQo+ID4gcG9pbnRlciwgYW5kIGFsbCBjbGVhbnVw
IHBhdGhzIG5vdyBjYWxsIGRybV9leGVjX2ZpbmkoKSBhbmQga2ZyZWUoKSB0bw0KPiA+IHJlbGVh
c2UgdGhlIG1lbW9yeSBzYWZlbHkuDQo+ID4NCj4gPiBUaGlzIHJlZHVjZXMgc3RhY2sgdXNhZ2Us
IGZpeGVzIHRoZSBiZWxvdzoNCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnFfZmVuY2UuYzo2NDI6NTogd2FybmluZzogc3RhY2sNCj4gPiBmcmFtZSBzaXplICgxMTc2
KSBleGNlZWRzIGxpbWl0ICgxMDI0KSBpbiAnYW1kZ3B1X3VzZXJxX3dhaXRfaW9jdGwnDQo+ID4g
Wy1XZnJhbWUtbGFyZ2VyLXRoYW5dDQo+DQo+IE1obSwgSSdtIHJlYWxseSB3b25kZXJpbmcgaG93
IHRoYXQgaGFwcGVucz8gVGhlIGRybV9leGVjIG9iamVjdCBpcyBpbnRlbnRpb25hbGx5DQo+IHNv
IHNtYWxsIHRoYXQgaXQgY2FuIGJlIGFsbG9jYXRlZCBvbiB0aGUgc3RhY2suDQo+DQo+IFdoYXQn
cyBnb2luZyBvbiBoZXJlPw0KDQpIaSBDaHJpc3RpYW4sDQoNCkl0IGxvb2tzIGxpa2UgaXQgb25s
eSBncm93cyB0aGF0IGxhcmdlIHdpdGggc2FuaXRpemVycyBlbmFibGVkIOKAlCBLQVNBTi9VQlNB
TiBpbmZsYXRlIHRoZSBmcmFtZSwgbm90IGRybV9leGVjIGl0c2VsZi4NCg0KVGhhbmtzIQ0KU3Jp
bmkNCg==
