Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F08EE77188
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 02:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 112F210E1D4;
	Tue,  7 Jan 2025 02:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wdux8HrZ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC0410E1D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 02:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNY1gY8fCn9xUJtsUeTvjXhJC230rRdBxgZOJJy0Mcs8fypcs0GbMexVrIVKxn6f63CtktepPMF8d7B4cbX/RO6GhBx/7T/wuKMDQhKgIM8wRa+rXFrsvOmQLeKxWNpxxo/C1q9qx2c4JBYARhSra408YN5UQsqwu3wjctPvjAp7QmAc2UTHp6YGQgYRqJf4g5CjTgeenE6rxuCfqIflu2h7/ph08mL/PW4X0eIbh+E9dS9Eceew3yhVF3jtAQwOcvwkILAU/1sRHsOlT4h46TNjruzxmQB8dJpiNoRifSzyG6vFru0jPTS2b3Ldack+BhD97bpxUvC+x2FEWodqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd0nBGZCPKu0qhru2y/Pg3chwGoLDHoY42pBNiGN1a0=;
 b=S1bL+28To50DvvwW+7/CxFBJ98iXD8NjskWYvFCoSZGSj6TkLMAoR2SLADmsXPI4KJaaHkW2JIEe79k5oeONV1hHQ5gM0Ah5SvGPXUwERO0ezwxa7FDXnvep1gJm8D1+A0NiGBqwtisI6d7RDfDrYM0Xy+N81dyXiLdHLItjHwtxvNz8U8ROwwyH1lDKbpmBdbkZV437Q2yrTMEK9Qu5WnaPzEXo5HD1okISg8YBCRmlUuBi5IM/mCOa6rImfOrJeGb4g8HAUxfNHq4Bes89wov/1U+Es2roq2H3xUcYZxvqPg3HKh0npmWB3Nfy/XkIXs8zN/REVAjKEYpWtgsjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd0nBGZCPKu0qhru2y/Pg3chwGoLDHoY42pBNiGN1a0=;
 b=Wdux8HrZsSZkBpZRmiln4Rthz4Du8LioDIaJ4i4BlVfAciNj5IiWbbLIwt5kWrRPnEn56JNPrIgcJ93mnjnKR/F/66t8/WeeZ8f0H+1xYAsgsx9dtlxOsY2fCEN1fltZMmW+5FIr5AXM8aLY/XqiiYRJYMUMJSO1GzWq7GlEjh4=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 02:10:35 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 02:10:35 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix partial migrate issue
Thread-Topic: [PATCH] drm/amdkfd: Fix partial migrate issue
Thread-Index: AQHbXXNmg3btm0VQfE6EJOJsqvbedLMFrkCAgANPGwCAAUHFgIAAVylg
Date: Tue, 7 Jan 2025 02:10:35 +0000
Message-ID: <PH0PR12MB541710CC0F24A33348528E718F112@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <4af83c37-0a9b-4b15-bfdd-6b8511b93a36@amd.com>
 <PH0PR12MB5417768A1EAFBB5BCFFC85BD8F102@PH0PR12MB5417.namprd12.prod.outlook.com>
 <3d7d3dd9-6c0b-4377-a131-75952d85a90f@amd.com>
In-Reply-To: <3d7d3dd9-6c0b-4377-a131-75952d85a90f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=68326969-6106-42cd-98a3-f3fedaefae1c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-07T02:05:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|DM6PR12MB4356:EE_
x-ms-office365-filtering-correlation-id: ad935b1b-5913-477d-63bd-08dd2ec078e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M1pmTVN1ckNxNFg2SkxHU0dqSm9uRTluZElCY3MxMHJET3Z4SWVqcmdPMGlX?=
 =?utf-8?B?VHNaRUNtOHFWaFFyQUE3RGtQQVRMVXVOU1ovUkRNWlE3dDFmLzU5MVJXSGJR?=
 =?utf-8?B?enNyQkNTYXZnWk9VMmtUQXZNVUxranptb1hJczlxbmNQQnN2bXgvM0YyMzVS?=
 =?utf-8?B?OUV2TEZNSnViNW8zK1RuYkFoZUlTUG9MUnNoZS9ZdjNTKzcrclR3c2IvbVd2?=
 =?utf-8?B?QjRiNkc3M1BTc0ZOOXBYeURxR0drWmlWUnJxTXRveVVDTFlWRlE3WVNJK05L?=
 =?utf-8?B?c1VvVUtFZVF0Rll5T01tZ2E0eE12bXhxQjBwYnJPcmpRVzF4RVJLdzJXWHpW?=
 =?utf-8?B?eTBTSGFCSjN4QWh6eW1uVE4zRTNua1lTVGk1YjBTMGxNR0pBaEExU2NnZzFX?=
 =?utf-8?B?UncxWGJLcUR1ME16THNIMWE5ek9MZDFPYmRkZ3ZIVDVXOHlMSjdSeFhZdEpX?=
 =?utf-8?B?UVpCa3ZZdUJ3RmhaY0V1QitNNG0yV1RuajB6V3diOG5wTFdOMW9UWkZkWXRs?=
 =?utf-8?B?VmdTa2JlRzl4U212dklVWnM4Ri85R09CTWkrS0RZRlgrcnN1Q3ZQYTFFYlA3?=
 =?utf-8?B?aTFvWTVKQm13QThUaHByQTZxWXR2NlJMUzlTb0RETVJoK0pTbFNiZEdlc2RC?=
 =?utf-8?B?aDRudEtNZC9IaXE2L0hYL0FiK3Nvd2lJRlFmT29IOGdLdEJTOEp2dUhJRXBG?=
 =?utf-8?B?cWJBMTRVbXZKbjY3NUVNSHRseVpOanZENDAxb1d3T0VGcUZOZ1FlYjdEUjNY?=
 =?utf-8?B?TWNQRFNGN2c5VVFRUk5HcDIwdjVBdlE2dnpRcHpQR0VUUVJIWWNFY0VFR2M3?=
 =?utf-8?B?R2lMOVQ2aFcvY09QZDhsRnNSbFE5NjlubHJMWmpTOHgvUFR1K0l4WWdHa1hv?=
 =?utf-8?B?ZTl2SHVoUWYxNnBXcUpQMFdlMm1YV29yNXVnNXphSElVQUl5V0lhdHd5dDNZ?=
 =?utf-8?B?WlhNUnBoMmZ1a0xkN2QyVThJZzQ3UHdxQUJIT1lOSytmWUE0NFIxNVpWbXZZ?=
 =?utf-8?B?aEkwemtNMmFURXlDKy9sSnJSWXRjK2NDa0RsVnNPSEFhVmZEejcwcmdzYldo?=
 =?utf-8?B?QVNYa1ZTdUsxQ1M3QVlndys3WGQxRkM2QUp1aEhyRGRDWFlYc051UnZpQWtT?=
 =?utf-8?B?ZGZNZGY3dCswRWdTbzRnaVlnbXVoMzFrU1ppeTBvWUNYb2trWlpKT1lYdzVk?=
 =?utf-8?B?V1k0azVUMFFQazk0QXVhZFQwZFlHVXhnVWJwVC9KRit3QWd6TVBxaFJEczZv?=
 =?utf-8?B?T2x5UHpZSGVsSkd3N2kvNFlhc2N0RDJEUTlUZVpKWVhnU0VGb2RhRUlpNWxX?=
 =?utf-8?B?Ynd2OW9zbVdkOFhJNkRzc0RyclB3SHdycEpIZEN5SkY2ZlRqM04rV3JhR0Ju?=
 =?utf-8?B?OWczaytBUjExMFdmQk1LUkI3QXhkaGtRQUdqSExaMHBpRkVwMTVWSTIrTW50?=
 =?utf-8?B?U3poMGJFdVgzanpidVN3MmY2ZXlZc0VHajFPS1NOZDhDRXBRVTVzbnlkQkxw?=
 =?utf-8?B?UHl4bk1qVVRNdHJ1SER6dlZxd0k2QmtvQStJMWtZMWlZMjJPeWlsVVFkSXNG?=
 =?utf-8?B?ZWhiS2tacmpQeWNVQlNKeSs0RWl6QWFJUlkxZ1E4bW9IZnQwRHpGanAwRGUr?=
 =?utf-8?B?TkIzdng3Z3lJbFFoeW4rQ3lJSG5tclVtOURqRFgycGg3U0ZZVVd4YVJUS1B4?=
 =?utf-8?B?RkxFL2pPL2crRWhXeGZqNEZsaXUrYTZvMDA4UzRwUnhwdjFoTTAyb3J2U1hp?=
 =?utf-8?B?aWhHSTVkTVUrTGUvcGFITHc3cmtiS0crSjJLN1hNak1YWU9SRTdMV3BmRVpS?=
 =?utf-8?B?RENJSGIyUEJRaWFHV3NEYk43T2tvOVYxa2svRUlXc0FsU2NqanppQVd6TXJq?=
 =?utf-8?Q?/eMgW1vCxjIHG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alVKYnh1akpWRlBqWTN0YUJkZ2VGTlNtYWFxWXdmMU45VVRmRHZ0WHRrTFd4?=
 =?utf-8?B?dHYxSmszL1EvZmxuajhYRjk0TW9HQWM3RTNmU3dQcjZkYkhMUXJ5ck50QVNE?=
 =?utf-8?B?S3U1VHVBVlNWVkdlRG93cVVJVHdmeERxaU5hdCtLQXVuTW85WW1uZTRnQWpJ?=
 =?utf-8?B?WDJ4TEZUZlo3QmxmN0lwVEhocmZrL0JJdFRHY3p4MDRsbHRLZDhZbjhBWEQw?=
 =?utf-8?B?WXhERktRUWlaMmtlUDJVRDYyTVpzYVVwRSsxQnFMczhXKzlzYjlOTGExMUs2?=
 =?utf-8?B?cEJFeFdtTFVWWGtqQzlmZUgvSTBTNnVYVUtyQWxqN0hGaXNtN2JxMG9hSDdz?=
 =?utf-8?B?WFI1WEtXYmQ5TXhjWWFLKzEyVWxPWkthRVo1VHJzR0lnaDJET0hVK0hNUDhU?=
 =?utf-8?B?b1BqQWJRaGpISDhPeUlVZHVPWGhvblhTQmVCdGFRM3k1SjBwYUsrc2Z3R09R?=
 =?utf-8?B?Um5jRnN6OCtSVjBsRnJTdG8rYnhHMXVsQXJDTFlrUjZ1NVdGR2x5S1E4UGRj?=
 =?utf-8?B?TDJCME84c2x2NmZvMjhkdnFrM3ZaRWhYQUJpWXZseUgrTm8vSUFJZXlVU2tG?=
 =?utf-8?B?OWI4UHVwVisxL3lrYTlCUGVVakN3MmNwV3ViTHdncWJweEFLZ25PUUR3SlFv?=
 =?utf-8?B?OS93RDhsK2w3bFA1OUwxcUtLYXhhZEx1aFo0V252cUZ4emloaU8wN3AzRndG?=
 =?utf-8?B?QzdqSVBudHdwK2xRRnNQWVBWZlNudlgyaXVFVk0vT3d1VkxoUWYvZm00M09u?=
 =?utf-8?B?UmJ1U1dnQ014eXV2Q1pPWlByQk9UZE42Tk1tTzAyTFlQclZab1p4UVc0VitJ?=
 =?utf-8?B?R1dxOEhEeXFFb1lURTk1YTVPYTE0dWV1dStiWGNLQTZFZ2x1ZFVvaFd3VUZN?=
 =?utf-8?B?NEFoSnpydzhia0dZcUpUc0JUUThwckhZYUxaODBFR3J5aVNzY2xpYkx3UjhT?=
 =?utf-8?B?WThmeW16WUtRUmRhMUJLRjJOMVZabGxvRm1rMEJNMmNwM0lOcFJzVU51MzNn?=
 =?utf-8?B?ZlR1dG9KeHRNejIyVHFKMWdEMEVPd2UzYWFHdnR6T3hRVjhLZWwvaFZYS1kw?=
 =?utf-8?B?MUpWU1dIOHdmSFRMZEdpYjNzUFhrQXY3alhTSTVBb2EvT0EwV1dZQnlVcjE4?=
 =?utf-8?B?bWhxRTB2N1FOT0d5MTBYOEk2cERIQU1KWTVtRlNzSU1kT0FKRnV0RDVOSkcr?=
 =?utf-8?B?c3pTTWI4RDBZbFV1dkNzbkxab0VXVXlXeEJuUFluYytuVkEwelFxUmJVYXB3?=
 =?utf-8?B?eGlHVStTVU13TEpPclMyS1lvRURkcGJyQmVDM2R4WXpqWHRwQmFBd25zcUlI?=
 =?utf-8?B?dzk2VzJ3N0hnM1R3KzM2V2w2cmRPZlBZaTNxSlpLeHJNMXUxanRoWDlrN2oz?=
 =?utf-8?B?TGw1Mm16TTBtWVhrVzdmRVk1SytpYmhGaDlzdnlLMmNEVkFRZTIvTVZ6NHk0?=
 =?utf-8?B?NGZEMWlMK3pQOGJVMklqYXQ3cFlUeFAwVTEvMlJMNlpmN3pENWZuc3FXVm5S?=
 =?utf-8?B?bnRnVDMyWnI2ZFJacXRmekZqSjRQaGJmN0FSRDlHY1lpYnJRY3lYUlRBc2Vr?=
 =?utf-8?B?YlZTNXdENjVlZTRCQVVlcGJaOWdMdmZkODlYUnFpUTNIYUU4ckY5Wm9sd3dG?=
 =?utf-8?B?Ymp3RTFLODhQTTNHdHNIVVgrRVdCaWxoNnhLRU14VmtMQWtXOEVFb2dZMmJ2?=
 =?utf-8?B?OGxvRm1tUnQ1Y0RtRW12NnVqbHpveHRZVm9VNVkvK1czYXhhMUsxZllvMkh5?=
 =?utf-8?B?UU1CdzUwdHA2S09nVlVUVHA0cU42Q0JUUElFYnJ1ZDg2aDZFZ05YcWhBUkE3?=
 =?utf-8?B?OCtQWXZ6cFZlWHY4Y3hwMkZWOHZhWjRaVGNsRTFSdDliSVp5d3MzU0cxM2JZ?=
 =?utf-8?B?NzhpcGpPd3BBc2pkMkNTd1VYdUp0cC9jU0RsVFZoUnFIU2E3S3RqV1RKUGM1?=
 =?utf-8?B?NkVMVmhoQ3ZORU11YitKQVU1MFpOT3p1MzEvdzNkWVhjbEc1Z2N4OXZqd3Bl?=
 =?utf-8?B?a0RBVWE5eTFBKzBpSlBBdUcxVURFckFPUjBXYmhJSXB2K0pmOWRWOTdwb2o5?=
 =?utf-8?B?USt1eHp0ek5DVTU3U0ZlMXFWMXhEVURqOVlIVWZiZmRVRUZISVcwNlBkTDJX?=
 =?utf-8?Q?kKR4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad935b1b-5913-477d-63bd-08dd2ec078e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 02:10:35.2835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: le87oNAk2ko1IKBJ7urgekmK3OOlhEKLGvYcRFXOJtRZgGvvIBZE0Iqk+ESkcHDW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS3VlaGxpbmcsIEZlbGl4IDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgNywgMjAyNSA0
OjUzIEFNDQo+VG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IEZp
eCBwYXJ0aWFsIG1pZ3JhdGUgaXNzdWUNCj4NCj4NCj5PbiAyMDI1LTAxLTA1IDIwOjQ1LCBEZW5n
LCBFbWlseSB3cm90ZToNCj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwg
RGlzdHJpYnV0aW9uIE9ubHldDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
Pj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPj4+IFNl
bnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDQsIDIwMjUgNzoxMCBBTQ0KPj4+IFRvOiBEZW5nLCBFbWls
eSA8RW1pbHkuRGVuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBGaXggcGFydGlhbCBtaWdyYXRlIGlz
c3VlDQo+Pj4NCj4+Pg0KPj4+IE9uIDIwMjUtMDEtMDIgMTk6MDYsIEVtaWx5IERlbmcgd3JvdGU6
DQo+Pj4+IEZvciBwYXJ0aWFsIG1pZ3JhdGUgZnJvbSByYW0gdG8gdnJhbSwgdGhlIG1pZ3JhdGUt
PmNwYWdlcyBpcyBub3QNCj4+Pj4gZXF1YWwgdG8gbWlncmF0ZS0+bnBhZ2VzLCBzaG91bGQgdXNl
IG1pZ3JhdGUtPm5wYWdlcyB0byBjaGVjayBhbGwNCj4+Pj4gbmVlZGVkIG1pZ3JhdGUgcGFnZXMg
d2hpY2ggY291bGQgYmUgY29waWVkIG9yIG5vdC4NCj4+Pj4NCj4+Pj4gQW5kIG9ubHkgbmVlZCB0
byBzZXQgdGhvc2UgcGFnZXMgY291bGQgYmUgbWlncmF0ZWQgdG8NCj4+Pj4gbWlncmF0ZS0+ZHN0
W2ldLCBvciB0aGUgbWlncmF0ZV92bWFfcGFnZXMgd2lsbCBtaWdyYXRlIHRoZSB3cm9uZw0KPj4+
PiBwYWdlcyBiYXNlZCBvbiB0aGUgbWlncmF0ZS0gZHN0W2ldLg0KPj4+Pg0KPj4+PiBTaWduZWQt
b2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+DQo+Pj4gR29vZCBjYXRjaC4g
QnV0IEkgdGhpbmsgaXQncyBzdGlsbCBub3QgcXVpdGUgcmlnaHQuIFNlZSBpbmxpbmUuDQo+Pj4N
Cj4+Pg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21p
Z3JhdGUuYyB8IDggKysrKy0tLS0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMNCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfbWlncmF0ZS5jDQo+Pj4+IGluZGV4IDRiMjc1OTM3ZDA1ZS4uNWM5NmMyZDQy
NWUzIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWln
cmF0ZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRl
LmMNCj4+Pj4gQEAgLTI3OCw3ICsyNzgsNyBAQCBzdm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0oc3Ry
dWN0IGtmZF9ub2RlICpub2RlLA0KPj4+PiBzdHJ1Y3QNCj4+PiBzdm1fcmFuZ2UgKnByYW5nZSwN
Cj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbWlncmF0ZV92bWEgKm1pZ3JhdGUs
IHN0cnVjdCBkbWFfZmVuY2UgKiptZmVuY2UsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ZG1hX2FkZHJfdCAqc2NyYXRjaCwgdWludDY0X3QgdHRtX3Jlc19vZmZzZXQpDQo+Pj4+ICAgIHsN
Cj4+Pj4gLSAgICB1aW50NjRfdCBucGFnZXMgPSBtaWdyYXRlLT5jcGFnZXM7DQo+Pj4+ICsgICAg
dWludDY0X3QgbnBhZ2VzID0gbWlncmF0ZS0+bnBhZ2VzOw0KPj4+PiAgICAgICBzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IG5vZGUtPmFkZXY7DQo+Pj4+ICAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldiA9IGFkZXYtPmRldjsNCj4+Pj4gICAgICAgc3RydWN0IGFtZGdwdV9yZXNfY3Vyc29yIGN1
cnNvcjsgQEAgLTI5OSw5ICsyOTksNiBAQA0KPj4+PiBzdm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0o
c3RydWN0IGtmZF9ub2RlICpub2RlLCBzdHJ1Y3QNCj4+PiBzdm1fcmFuZ2UgKnByYW5nZSwNCj4+
Pj4gICAgICAgICAgICAgICBzdHJ1Y3QgcGFnZSAqc3BhZ2U7DQo+Pj4+DQo+Pj4+ICAgICAgICAg
ICAgICAgZHN0W2ldID0gY3Vyc29yLnN0YXJ0ICsgKGogPDwgUEFHRV9TSElGVCk7DQo+Pj4+IC0g
ICAgICAgICAgICBtaWdyYXRlLT5kc3RbaV0gPSBzdm1fbWlncmF0ZV9hZGRyX3RvX3BmbihhZGV2
LCBkc3RbaV0pOw0KPj4+PiAtICAgICAgICAgICAgc3ZtX21pZ3JhdGVfZ2V0X3ZyYW1fcGFnZShw
cmFuZ2UsIG1pZ3JhdGUtPmRzdFtpXSk7DQo+Pj4+IC0gICAgICAgICAgICBtaWdyYXRlLT5kc3Rb
aV0gPSBtaWdyYXRlX3BmbihtaWdyYXRlLT5kc3RbaV0pOw0KPj4+Pg0KPj4+PiAgICAgICAgICAg
ICAgIHNwYWdlID0gbWlncmF0ZV9wZm5fdG9fcGFnZShtaWdyYXRlLT5zcmNbaV0pOw0KPj4+PiAg
ICAgICAgICAgICAgIGlmIChzcGFnZSAmJiAhaXNfem9uZV9kZXZpY2VfcGFnZShzcGFnZSkpIHsN
Cj4+PiBXZSBzaG91bGQgYWxzbyBjaGVjayAobWlncmF0ZS0+c3JjW2ldICYgTUlHUkFURV9QRk5f
TUlHUkFURSkgdG8gY2F0Y2gNCj4+PiBvbmx5IHRoZSBwYWdlcyB0aGF0IGFyZSByZWFkeSB0byBt
aWdyYXRlIChpLmUuIG5vdCBhbHJlYWR5IGluIGRldmljZQ0KPj4+IG1lbW9yeSBhbmQgbm90IHBp
bm5lZCBieSBzb21lb25lIGVsc2UpLg0KPj4+DQo+Pj4gUmVnYXJkcywNCj4+PiAgICBGZWxpeA0K
Pj4+IFRoZSBjb2RlICIgaWYgKHNwYWdlICYmICFpc196b25lX2RldmljZV9wYWdlKHNwYWdlKSkg
eyIgaXMgYWxyZWFkeSBjaGVja2VkDQo+d2hldGhlciB0aGUgcGFnZSBjb3VsZCBiZSBtaWdyYXRl
ZCBvciBub3QuIEJlY2F1c2UgYWZ0ZXIgY2FsbGVkIG1pZ3JhdGVfdm1hX3NldHVwLA0KPmZvciB0
aG9zZSBwYWdlcyBjb3VsZG4ndCBiZSBtaWdyYXRlZCBpdCB3aWxsIGJlIHNldCB0byBOVUxMLg0K
Pg0KPlRoZSBwYWdlIG1heSBiZSBub24tTlVMTC4gSWYgdGhlIE1JR1JBVEVfUEZOX01JR1JBVEUg
aXMgbm90IHNldCwgdGhlIHBhZ2UNCj5jb3VsZCBub3QgYmUgY29sbGVjdGVkIGZvciBtaWdyYXRp
b24gYnkgbWlncmF0ZV92bWFfc2V0dXAgYW5kIGl0IHNob3VsZCBub3QgYmUNCj5taWdyYXRlZC4g
U2VlDQo+aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTIuNi9zb3VyY2UvbW0v
bWlncmF0ZV9kZXZpY2UuYyNMNDcwDQo+DQo+UmVnYXJkcywNCj4gICBGZWxpeA0KU29ycnksIGRv
bid0IHVuZGVyc3RhbmQgY2xlYXJseS4gSWYgYSBwYWdlIGNvdWxkbid0IGJlIG1pZ3JhdGVkLCB0
aGUgc3JjIHNob3VsZCBiZSBzZXQgTlVMTCwgaWYgbm90LCBJIHRoaW5rIGl0IGlzIHRoZSBtaWdy
YXRlX3ZtYV9jb2xsZWN0J3MgYnVnLiBTbyBjb3VsZCB5b3UgcG9pbnQgd2hpY2ggY29kZSBwYXRo
DQppdCB3aWxsIG5vdCBiZSBOVUxMLg0KPg0KPj4gRW1pbHkgRGVuZw0KPj4gQmVzdCBXaXNoZXMN
Cj4+DQo+Pg0KPj4+PiBAQCAtMzQ1LDYgKzM0Miw5IEBAIHN2bV9taWdyYXRlX2NvcHlfdG9fdnJh
bShzdHJ1Y3Qga2ZkX25vZGUgKm5vZGUsDQo+Pj4+IHN0cnVjdA0KPj4+IHN2bV9yYW5nZSAqcHJh
bmdlLA0KPj4+PiAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICBqKys7DQo+Pj4+ICAgICAgICAgICAgICAgfQ0KPj4+PiArICAgICAgICAgICAgbWlncmF0
ZS0+ZHN0W2ldID0gc3ZtX21pZ3JhdGVfYWRkcl90b19wZm4oYWRldiwgZHN0W2ldKTsNCj4+Pj4g
KyAgICAgICAgICAgIHN2bV9taWdyYXRlX2dldF92cmFtX3BhZ2UocHJhbmdlLCBtaWdyYXRlLT5k
c3RbaV0pOw0KPj4+PiArICAgICAgICAgICAgbWlncmF0ZS0+ZHN0W2ldID0gbWlncmF0ZV9wZm4o
bWlncmF0ZS0+ZHN0W2ldKTsNCj4+Pj4gICAgICAgfQ0KPj4+Pg0KPj4+PiAgICAgICByID0gc3Zt
X21pZ3JhdGVfY29weV9tZW1vcnlfZ2FydChhZGV2LCBzcmMgKyBpIC0gaiwgZHN0ICsgaSAtDQo+
Pj4+IGosIGosDQo=
