Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE5CED24E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A6910E45C;
	Tue, 18 Nov 2025 09:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Km8eb4Nq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DC610E45C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu6HWHqIcXa9cIwGcye96mPweduMR1I/rHfE08NP/7AUCtxp/1QeGZVavBudi94ThzaEMjMroOP4eBL8s6ULvvniJ83zKpRgr6IAleXIYtFE8EU28Um6HA5CqXI2fScB5Cnq94nOk6L5eEVvhtf0ntC6xRLaH3i4ISCsdRpHR2Cno4jvipkFfh0pvJKh8QhpshNq4r+syYsa0PZu3ptYy5fvp/38PDLVRP1yIa/Wug6AEhmRglIcZHZpdum8j1XVFJicGk5duK4SUTuhSFKgH5wRjR1vY5n1rQVu+h3xFi0G/v1blA9+X8i0meuAsL072KgMhhzYcwc3gqN3D6HJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W54u3KL418lN7ME/WGuGNI/EDMcrV6TkwIPeb7aIFiw=;
 b=Gu4BAh0oEjsmBwBtfdEWqnbAHDi97jkIvFp9JhQpj4QeQzQIMyNdbcQXtwVkIWUXGmUSAqJiXCmkzX5sq01KS4kBRqQPYIqRqPKhmxET+1ihaf3tU7C/sT24kOGnKvTHz6KZ+6imNG2kE3tfE2slZ32p8twEcqNBQc4F0aUquqxlEqJ9Z1mVuzVryeN+dD8JvI4O9yAK4Usprc4vi2escV3W3Xp8nQpVaBuVo1L65ZRS1fUS7F4UOHveqx6xBySxGdz0WhUWoVahhDLtCn3GWM4HPpXNz1AomZmu/kfKZB+skg6LqVAn0SzvVxVOERC9AUNZV35zvpUNat+gCxxnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W54u3KL418lN7ME/WGuGNI/EDMcrV6TkwIPeb7aIFiw=;
 b=Km8eb4NqTKru/49zBOGULjpIhOFUW/m7+L6AreYoyfpytdykUcW3Rk1cnOj4/SzePlOGVkdY3/vHyt7jnPRHgt2bYShGvcUW1rTIwukXAIjsm0xuYgXpbdyYLVU75gRdTsISba0cl6pYgHdgJdjpjTVpaFX5916/ChHyEVDIQL4=
Received: from DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) by
 CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Tue, 18 Nov 2025 09:29:08 +0000
Received: from DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::ae90:ca3:5db2:1a78]) by DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::ae90:ca3:5db2:1a78%4]) with mapi id 15.20.9298.010; Tue, 18 Nov 2025
 09:29:08 +0000
From: "Li, Chong(Alan)" <Chong.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chen, Horace" <Horace.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
Thread-Topic: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
Thread-Index: AQHcV47vUkrpw2rZtE+NUSf+0yNb2LT4HO6AgAAG4lA=
Date: Tue, 18 Nov 2025 09:29:08 +0000
Message-ID: <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
References: <20251117065323.3435034-1-chongli2@amd.com>
 <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
In-Reply-To: <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T08:58:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5768:EE_|CH2PR12MB4215:EE_
x-ms-office365-filtering-correlation-id: b322810f-5740-4329-e712-08de2684ece4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?TW5nbHpEV3E1MThFeHM3WU0rYTI5WUlFV1BMbFpSYXlGd1gvNmJLTndodVhQ?=
 =?utf-8?B?ZkUwYmJiT2JDL01aVmVacHAyOXZzcVlzZ1Bha0Z4U0kxZ2c0OXV5YlhJQmlh?=
 =?utf-8?B?N280WTZxcGZNZ2hnQjRxWG5jamFIS2E0dTN0bUkxb3VFTHk4b3pGN0wrYUhS?=
 =?utf-8?B?b3B5NUlPSEdocVc3REZ0UmhiWkpVQW9ObFlSOWtWWWNlUHpTZWlNajVCVWxY?=
 =?utf-8?B?ZW8rcFhBdW9RNzJMTmV0ZWt5bCtXRlBUYWVLVXdDVktQYVBpUy82dFRtZ3FW?=
 =?utf-8?B?M2I0THFCYVY0MG5vQ0VtWFpzd0NPclhHaTdjVUhCZzd4NGg5VkVXMk5NdGlB?=
 =?utf-8?B?cUU0Mzk2dVI0WWE3Mm5qYUl5bEI1TkJINWR0RHltZmVTREh6bmZib2RYMGlT?=
 =?utf-8?B?NVp2VzN0NTZEejJrQzFuVEFmYi9hRVEvOUFENnJsWkxjN3RmOGI3MHZjTlVl?=
 =?utf-8?B?cXg3Q1ZBK0NDQUtiSW1qOWRhdG5lVGNwcy96MjRkN2l6cFVsQmxqam4xOGlF?=
 =?utf-8?B?R0p2ampkYlBrNmFSM09iUGY0dkdqMUpBYkhvMFU3aUo1VldyYUg5b0ZIOHMy?=
 =?utf-8?B?VGFGc2RwQklBTDkvNlQ1KzZPRFZrMXdtd1Y1Ymkzd2VVcGZnUnFnSnV0ajFD?=
 =?utf-8?B?MWNMaldleVI0U2J2NWVleU9Zd3ZHdkw4T2JDMlhOaTVlNiswWHRMTWxUMEQ4?=
 =?utf-8?B?VlI1V2tBMmFVOUJnZklKbmlHT2xFSWxYUlUyTGxjZ1BRTDdTOVBSckpMZzJY?=
 =?utf-8?B?ZGJIdlBPMTNSRTJTc3Brc2pMaUhlOXRZYkJhUE9PREx3ajJOL1BnZWdFU3J2?=
 =?utf-8?B?MlFES1VraVJtVCtMaXJLbzVFSTZYdnNEVHNvYkovRVJ2bzBJbjBRa2tyWWxC?=
 =?utf-8?B?YXBlbmNyZU5tQ3lXVGI1STRlcmxtZFA2Z09NYkZSVVFWWlhyNEF6VVpJZkhC?=
 =?utf-8?B?dC96UEhKcGxvek1qZzNOM2JZZnlERk5URTdWNjFSaTFrY1ZGQm9wNm1PdkJo?=
 =?utf-8?B?MlJlQzMvUWxpcXJIRXVpZ1A1QzVZd1ZoZThUOVEvMXI4aWtrS0xDQ016cVhL?=
 =?utf-8?B?SXk4OElaVktGTDFndUYrc05CZVIxdGZ5TGVOQ2ZoUFNvUURzV3QvWWlxRnJB?=
 =?utf-8?B?REswcEI2YUpDS2Rtc2EzSFJ2RysvVUlxcGQ2S2VaNENsS0JGbEROWjhmNXJn?=
 =?utf-8?B?VjV3WWhCdXVTQ1VuZjZMWUtkOWtmR2xYWFFMV096NnFkcDFlZk1uSisvMTZ3?=
 =?utf-8?B?cm1vdWxveE9ETkJBdDJtYmpmZU9pbVZWN2s5blFhK1VMbEwrZVJrZTFqTlZP?=
 =?utf-8?B?WXV6UllOTEYyNVUydXprTmxiMjQ5dkpMOGl0a1N4QVNja2ZvY0JCSG1lbzVk?=
 =?utf-8?B?UlhheExXcEtsZnVYblhsOUphUzRKRHgydHR0RURQRDNxZzQzY3V5ME9OdWxx?=
 =?utf-8?B?a2JGSEJvZ2hvc1FzNno3Y2s4eDZQaGE5RUNRem1NQkxoSkNScTNHVjJuZU1t?=
 =?utf-8?B?Wllwc2dLWDlYWXRaejl2NGttMmRrR3FlMEFtYXppUGRwbHNUSUZCdVFSd0hm?=
 =?utf-8?B?UXlhTEZ2Qm9GendycGM0T3p3M3NXNUdTRTdTUzRBOWFZT3oyc2pjcUE3Ritr?=
 =?utf-8?B?SjQ4dS9PUW9NcWMyUmxtdm9MelhBSmN2RGtNUVl4RTBFdDFBRTd0V2M0SElT?=
 =?utf-8?B?cml0bVQ5eWJ3N2VYU1lGY0tVQTlMRlY5cjRnU0Ixem5BaDRMUmxlYXJHMnVw?=
 =?utf-8?B?NXAvMHd1YTBYZHd4OXI5ajZpa0Zwb285N09UUm4veHY1dlk1VHNqNXRKcWth?=
 =?utf-8?B?Y3luSnNaWGFQMUxnRkJKU3RPZVl4RDN6TzJPbEpBN1diWWpHK2ZHeWhlR0Fx?=
 =?utf-8?B?dnF3NDFJU2NtcmVpQkwxb2R0ZitjTGVRNGVSaEhtRFBtcFhpaGY1NzdBZHRy?=
 =?utf-8?B?UHlJQmU2aUNXS2Q0SXpPMW5sVzc3bGI0SDBlUUI1dW5vNjY3UXBpcGtJWUZm?=
 =?utf-8?B?akxRYythbGNNYW5KelNocXZBTXJtMEVwUzdrWUY3Vmx6N09KdmFBRW1FdVdL?=
 =?utf-8?Q?ZVitBi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5768.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vzh3U0VuVC9DU3dhZTZQYmxQd1J2YjhSUDBiazNjSzd4ZTdBcUpJSDVTNDlv?=
 =?utf-8?B?dzVvMHBzTTYrUVQ3c1UzU1oyaGlKVVo5aDVGTW5CMENNQkZydEZHS05wRkNF?=
 =?utf-8?B?U2pFV0JzTmMwbmdubWlhZ1R1bHpDTmorcU9vYkxBMXRvS2NGdXplczIycVg4?=
 =?utf-8?B?dFF3VnErOG9ObXExMVRGVklhbllaRjZTNmVPQzRTZlBtb1JCR2xzd1NaYjE2?=
 =?utf-8?B?ZU9SZzR1UmwzNGk2Z0xobXRYNGpYbFFXMTRJQzNUVTZxM3V6c0hBYitsTFFG?=
 =?utf-8?B?ZXFURE13MVhQRTF2MCsvRS84ODVjTmI5bHZBL3Z3VElCQ0dYREdZUTdTY0dn?=
 =?utf-8?B?ejJWMDBrdzdGTWU5bTRBMmsvODYvWFUxVUgvb21QZzBSWlVMcTlSSmJ1Yks0?=
 =?utf-8?B?SlM4NUpDUThJUE5qOCs3MEhKdjVTSFdyYU9iZU0yV093Z2d5VER0Y3hzamhN?=
 =?utf-8?B?ZWJRQmpZdEFrMDFtczJhWDlTSjk3MzZpNTdNclpUMlpHVDRVQXJOd1F4bWxv?=
 =?utf-8?B?OGxwS0FLQmVtR1o0cjZ6WXIrUTVZcGw4TlpKOXhld2dyS25sUmNWejZFVzdE?=
 =?utf-8?B?MUhtTXFrd0N3RldURWlRaW9JMlNUV3ZYRnE3UVFVOUNJaVVISk9nTDdGczhl?=
 =?utf-8?B?Rkh2TnpZbzRoNk9mR29BTkpxL2twU3VVenZMd05McDhLaDJuNmxBNGRhbnd0?=
 =?utf-8?B?UEd0d3VsSTVPWkk3VnlmR21CVGVTUWRXcXBnSDRwaDRLUGVCMkl6em5ER0Nq?=
 =?utf-8?B?bHlIZFlxSjNtWlVyVnJuK0QxL2pCZUJZeXVqZS9xUE5TZ3piWEUvSjFjdzZC?=
 =?utf-8?B?NjBuYW5hcXY2c0hjd3pPMURtTmJEZU9GNXByOUJ3NU03bjF6N3owdkZlSGVC?=
 =?utf-8?B?czZuM2RQR3FwdnhQVERnMUVLS3V0d2VtdWw1UTRCaUV3WWhueGpLbXpSKzN1?=
 =?utf-8?B?UEwwR09MdFhoYkZIdTJnQTZSUzlCaDdNYnFpNE1zdmM3dHdvdjFmaVExYW44?=
 =?utf-8?B?emN2dG4xL214dUdCNnRRVEJPaElXa3FROTdNQk9ibWFqM0N5VXpTVk1SK21U?=
 =?utf-8?B?N1ZzbXhDMFdTdTZaYzBPNkkxQzFWa1BIaEYxaUpsb29lTHZrMjhxRlRzdDVw?=
 =?utf-8?B?dFM3T21FcEpabHpZRVBYMG54dm92RmpZWEdRL3JBUEdTTStxNTJYL1BKVGl5?=
 =?utf-8?B?Smd4Nk5vZXMrSzQ3MFU1L2JKSXVISGdmbUNCNGxPOExsTUh5Vi9jWkJ1U0Fh?=
 =?utf-8?B?RW5iWDFJbUgwOHpjbzJqOXh3QUhDbFlaejFEbTJqc0FWR2o4U2NTbURuZ3p4?=
 =?utf-8?B?ODdwMDA3MVdoUGljMnNtdFhjNmpoVlJodjVXVVpweTlLVXlDZW5yNDBsdENz?=
 =?utf-8?B?YjRMR0U2K1VPT2lTVTdiMllicE1MSUR1b29IalJFQjBPRGtJb0RuM0E1RDc1?=
 =?utf-8?B?OTRxaWdlS2NtV2t0MnRJTEp1N3dsQ0FnREtiM0R2aHZXN3crU2dnR002UnBM?=
 =?utf-8?B?QU5KY3RRYjc4blJsT2Y0VTRLSFBVQjhXS0QraEh1UVRvMzRZNUJPV3pNdVhi?=
 =?utf-8?B?V0N5WWhvbmlvVWZRTVZSeDhlcVMyM240bktIZmo3YUFqY1FkRnVFYlpEMTgx?=
 =?utf-8?B?M0tEZ3dwSDJiamxlYTE5bXQ1alBWUHdtTTkvT3JsT1V5LzVOUjNKUnNhTnJC?=
 =?utf-8?B?QktUZGIyZ2p1a3ZEczlmVWtBdVdzSWVyRlJuREs4SmpXWFFwU3pveUVUWXd1?=
 =?utf-8?B?dEVMN2FjdlpIaEp4MXRVbkYvWldXakY4VlpTN3Ryei9Ja0VGMzhnc2xWZlhM?=
 =?utf-8?B?WFI0L3BvSTNaVjRYTHNFbmhoaWV2MC9FR25YOVNUVEFBdUMza2paZi9DQm1P?=
 =?utf-8?B?UkE3d2FMQnFZTXFuQTZlK3h0bGVNZkRCOFdRODArOVVVaVNHRGsrY29HSFdz?=
 =?utf-8?B?WlFkTW1VWmlJYkVySnFCeHVYVmtrYWR3dmdEYUZ1Nlk0N2lpT3p4eVdPTldP?=
 =?utf-8?B?VUEwWGhiSnFLOWcwbkN5bWZmZnp3SUJ3SmgxdUpiS2VackpBN3ZsRkJQeElR?=
 =?utf-8?B?aHhiakVPcmtuVTdBcmJNZDJRd2srYll0cDZxdThBRVRMZzdSQWgzREs3eEtR?=
 =?utf-8?Q?EoHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5768.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b322810f-5740-4329-e712-08de2684ece4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 09:29:08.4528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2i/BbyVUIs8ztASFxr9zN/byWd3m5q7/XqDTjnm4H5tV6Fbjia513Fs9aygPxeERkvq1Dyz2vnFVp7+2vCecg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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
Cg0KSGksIENocmlzdGlhbi4NCg0KSW4gbXVsdGlwbGUgdmYgbW9kZSggaW4gb3VyIENJIGVudmly
b25tZW50IHRoZSB2ZiBudW1iZXIgaXMgNCksIHRoZSB0aW1lb3V0IHZhbHVlIGlzIHNoYXJlZCBh
Y3Jvc3MgYWxsIHZmcy4NCkFmdGVyIHRpbWVvdXQgdmFsdWUgY2hhbmdlIHRvIDJzLCBlYWNoIHZm
IG9ubHkgZ2V0IDAuNXMsIGNhdXNlIHNkbWEgcmluZyB0aW1lb3V0IGFuZCB0cmlnZ2VyIGdwdSBy
ZXNldC4NCg0KDQpUaGFua3MsDQpDaG9uZy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50
OiBUdWVzZGF5LCBOb3ZlbWJlciAxOCwgMjAyNSA0OjM0IFBNDQpUbzogTGksIENob25nKEFsYW4p
IDxDaG9uZy5MaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGluIHNyaW92IG11bHRpcGxlIHZmIG1vZGUsIDIg
c2Vjb25kcyB0aW1lb3V0IGlzIG5vdCBlbm91Z2ggZm9yIHNkbWEgam9iDQoNCkNsZWFyIE5BSyB0
byB0aGlzIHBhdGNoLg0KDQpJdCBpcyBleHBsaWNpdGVseSByZXF1ZXN0ZWQgYnkgY3VzdG9tZXJz
IHRoYXQgd2Ugb25seSBoYXZlIGEgMiBzZWNvbmQgdGltZW91dC4NCg0KU28geW91IG5lZWQgYSB2
ZXJ5IGdvb2QgZXhwbGFuYXRpb24gdG8gaGF2ZSB0aGF0IGNoYW5nZWQgZm9yIFNSSU9WLg0KDQpS
ZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQpPbiAxMS8xNy8yNSAwNzo1MywgY2hvbmcgbGkgd3JvdGU6
DQo+IFNpZ25lZC1vZmYtYnk6IGNob25nIGxpIDxjaG9uZ2xpMkBhbWQuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDkgKysrKysrKy0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgICAgfCA0ICsrLS0N
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IDY5
YzI5ZjQ3MjEyZC4uNGFiNzU1ZWI1ZWMxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC00MzQxLDEwICs0MzQxLDE1IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2RldmljZV9nZXRfam9iX3RpbWVvdXRfc2V0dGluZ3Moc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpDQo+ICAgICAgIGludCBpbmRleCA9IDA7DQo+ICAgICAgIGxvbmcgdGltZW91
dDsNCj4gICAgICAgaW50IHJldCA9IDA7DQo+ICsgICAgIGxvbmcgdGltZW91dF9kZWZhdWx0Ow0K
Pg0KPiAtICAgICAvKiBCeSBkZWZhdWx0IHRpbWVvdXQgZm9yIGFsbCBxdWV1ZXMgaXMgMiBzZWMg
Ki8NCj4gKyAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gKyAgICAgICAgICAgICB0
aW1lb3V0X2RlZmF1bHQgPSBtc2Vjc190b19qaWZmaWVzKDEwMDAwKTsNCj4gKyAgICAgZWxzZQ0K
PiArICAgICAgICAgICAgIHRpbWVvdXRfZGVmYXVsdCA9IG1zZWNzX3RvX2ppZmZpZXMoMjAwMCk7
DQo+ICsgICAgIC8qIEJ5IGRlZmF1bHQgdGltZW91dCBmb3IgYWxsIHF1ZXVlcyBpcyAxMCBzZWMg
aW4gc3Jpb3YsIDIgc2VjIG5vdCBpbiBzcmlvdiovDQo+ICAgICAgIGFkZXYtPmdmeF90aW1lb3V0
ID0gYWRldi0+Y29tcHV0ZV90aW1lb3V0ID0gYWRldi0+c2RtYV90aW1lb3V0ID0NCj4gLSAgICAg
ICAgICAgICBhZGV2LT52aWRlb190aW1lb3V0ID0gbXNlY3NfdG9famlmZmllcygyMDAwKTsNCj4g
KyAgICAgICAgICAgICBhZGV2LT52aWRlb190aW1lb3V0ID0gdGltZW91dF9kZWZhdWx0Ow0KPg0K
PiAgICAgICBpZiAoIXN0cm5sZW4oaW5wdXQsIEFNREdQVV9NQVhfVElNRU9VVF9QQVJBTV9MRU5H
VEgpKQ0KPiAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jDQo+IGluZGV4IGY1MDhjMWE5ZmEyYy4uNDNiZGQ2YzFiZWMyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+IEBAIC0zNTgsMTAg
KzM1OCwxMCBAQCBtb2R1bGVfcGFyYW1fbmFtZWQoc3ZtX2RlZmF1bHRfZ3JhbnVsYXJpdHksIGFt
ZGdwdV9zdm1fZGVmYXVsdF9ncmFudWxhcml0eSwgdWludA0KPiAgICogW0dGWCxDb21wdXRlLFNE
TUEsVmlkZW9dIHRvIHNldCBpbmRpdmlkdWFsIHRpbWVvdXRzLg0KPiAgICogTmVnYXRpdmUgdmFs
dWVzIG1lYW4gaW5maW5pdHkuDQo+ICAgKg0KPiAtICogQnkgZGVmYXVsdCh3aXRoIG5vIGxvY2t1
cF90aW1lb3V0IHNldHRpbmdzKSwgdGhlIHRpbWVvdXQgZm9yIGFsbCBxdWV1ZXMgaXMgMjAwMC4N
Cj4gKyAqIEJ5IGRlZmF1bHQod2l0aCBubyBsb2NrdXBfdGltZW91dCBzZXR0aW5ncyksIHRoZSB0
aW1lb3V0IGZvciBhbGwgcXVldWVzIGlzIDEwMDAwIGluIHNyaW92LCAyMDAwIG5vdCBpbiBzcmlv
di4NCj4gICAqLw0KPiAgTU9EVUxFX1BBUk1fREVTQyhsb2NrdXBfdGltZW91dCwNCj4gLSAgICAg
ICAgICAgICAgIkdQVSBsb2NrdXAgdGltZW91dCBpbiBtcyAoZGVmYXVsdDogMjAwMC4gMDoga2Vl
cCBkZWZhdWx0IHZhbHVlLiBuZWdhdGl2ZTogaW5maW5pdHkgdGltZW91dCksIGZvcm1hdDogW3Np
bmdsZSB2YWx1ZSBmb3IgYWxsXSBvciBbR0ZYLENvbXB1dGUsU0RNQSxWaWRlb10uIik7DQo+ICsg
ICAgICAgICAgICAgICJHUFUgbG9ja3VwIHRpbWVvdXQgaW4gbXMgKGRlZmF1bHQ6IDEwMDAwIGlu
IHNyaW92LCAyMDAwIG5vdCBpbiBzcmlvdi4gMDoga2VlcCBkZWZhdWx0IHZhbHVlLiBuZWdhdGl2
ZTogaW5maW5pdHkgdGltZW91dCksIGZvcm1hdDogW3NpbmdsZSB2YWx1ZSBmb3IgYWxsXSBvciBb
R0ZYLENvbXB1dGUsU0RNQSxWaWRlb10uIik7DQo+ICBtb2R1bGVfcGFyYW1fc3RyaW5nKGxvY2t1
cF90aW1lb3V0LCBhbWRncHVfbG9ja3VwX3RpbWVvdXQsDQo+ICAgICAgICAgICAgICAgICAgIHNp
emVvZihhbWRncHVfbG9ja3VwX3RpbWVvdXQpLCAwNDQ0KTsNCj4NCg0K
