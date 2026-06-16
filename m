Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E62CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B56F10EAAD;
	Tue, 16 Jun 2026 11:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qkhrwD/S";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC0810EA5E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ3xwe+lFHI6S4+wLamcm1nYlg0eQImuu08FdyeoyyJivCwyi7tQL1Ggborhq4wbOe2dx0sU5QLtzNnm8wFdVQMQezV7eVMSwnCy1ktIpCOuUzdZ7GhylijuXG1D+DqDQuK2xoKtx+W5+4iP5hc7lSVyQzCK/C9W8Ag9t6L5b0Q82nTSySaRoQfyi7eE6c2SCXJRFrXz5VYV8JbAaYcE8DgwVKRUlAkhxx42JcWwtW3+VRxPSbQ9HPuV06PX68zQPMMqD7LBGhFpqI0rqACNhbb6OrJTUmhzD+RYOrxuTusicj510HOgD8Vuawosm1Nro4CaobuRiORqFCQcE+w3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVeFPi328v2Nz+SwGTwLvxmrzVfcJlFTmKKWGVXvI3Q=;
 b=a1ZIkFd2eqqY/bfFtryvfruen7/KzAgk/kBENijlVPkcvi4SCypu3u0SDoXURRtXWsC5Scj81C20//EVy3xOyZ5P9DrUhDvjYMdfqKCaNr/PdBIfKB1F6c9/73Rv9SU9Us2DUl8RZzfujiWsUQgy7/xFqZxJCuIOUywgKzOb3MX61nWfzxEl5YdG6Sa1ssFaZr53catJr7wmC5c2mBFpEgWo62SjgnouwdZk9MjNVJ/7Hs9qY1aXqnfbt0Z0U+vGKI2KFlTHObCPII9+8NChG9L0i/5hO/l8t0Pp7CmOGJo0pJCU7nhQziuKrJCWMZxnk1LXT8Kl3hnKrKgzB9Dzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVeFPi328v2Nz+SwGTwLvxmrzVfcJlFTmKKWGVXvI3Q=;
 b=qkhrwD/SQL1bzoMausX5b0Rwgfyum4Zs0007Lilbvtb7NRLx6dx/VNxvWQqqbCUjyk5MaTUbGGxpY5IUseTWs7ge1t1ugk1bmmXV14gHGE9aaRCv9pXzZU5laultruBf3k0ChOw9hr2GBArDiKYkWt4/bRoTTr9avB+va7Te0Go=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 11:30:01 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:30:01 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/5] drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
Thread-Topic: [PATCH 2/5] drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
Thread-Index: AQHc+i+7mFJbLS7prEunpK/q1VtU5rZA6CwAgAAqLYA=
Date: Tue, 16 Jun 2026 11:30:01 +0000
Message-ID: <IA0PR12MB82083E2008437898E247926790E52@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-3-srinivasan.shanmugam@amd.com>
 <205b3f8f-8381-4c7a-80b0-e13e56165c6b@amd.com>
In-Reply-To: <205b3f8f-8381-4c7a-80b0-e13e56165c6b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T11:29:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|LV0PR12MB999091:EE_
x-ms-office365-filtering-correlation-id: 52276898-a750-47aa-aa36-08decb9a9a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|4143699003|3023799007|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: s/ZjqN4MruqDA7UiywR3fqI0uGP3o2M2GnYAmbLeYFSTassTdDhg/rMlQucygIeOHvgcraHe/N0thQxySHCyvZK988+CFs8FqgTsxP6LOh317ObPO8jKMoyWPNyhQm47lHm+Oe2EcnOlNEVKMJEV7FDiOb/pFcdZas+7ae+GXCDAJbaR0nmEE0EBWHpCUo9UKCIkcZUw4w4THc3FkGjuHu60XuLSfnE8AL9SEFLQrKWeRiSkhmMB8fZb2JPZR6qu1JhNDKnuSs/UlB3iWGMeChySdeOJFyiBW52a3CsQLjFhetmxKcgi9opv9+eSRk/BVqohXe9vxtBdpoHSENsgGTwOZjgKlvtPYdcOKCSGJUjqjCGqeUs/sIAyb3RXZX8W3v+om7r/j/2sd4HHnULQWrKVRvNNVmAK2QPUAbH6a8PKGhUGcpd6xcJiUZmXjiYb2t1Ecq8M9JpuObalbd+aRkrSvM227YIrtvdvfcPYAkNX3uWzabNZg/1O47HXK+lbj9r7DfLyxUrcZe9XKfHRFHxL7LX8tcy3QA2byoJB8/NTFBUrTT0/zYR+y0XprgPfs3E4AOnHbZ+sLq/ZukbbkDY/JX5hvMw/LUlqnWbcI0m1/2S0RdiAoGWxZJ4w32BaHPjzn8qVHWGWqjKGTjrysR300RL0GRqKIRxn71JSGN28M9TtHaugpPjB1JDSEtB1//who1s8asI4v9z89X95wTgKOTOiwZnasEFPpaobWyHAZp2T+Q9rfVn1VBaXuyEf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(4143699003)(3023799007)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWdYRjloL3FGY3BvWEtwZUErVWtHaFQ1bEtyNnpYMnVXeUhzZXBzaTNRdngv?=
 =?utf-8?B?SlNKRUJwS3l6S3cydDR6Q0xnZlV0eVdrZVN0Q3RFaEhQMDFvQ0pMNFpLYzZa?=
 =?utf-8?B?S0hFWll5SG5Xa0RSWE1MMU1FeE5WV2pGSU1OSzZUVWpjMjBxaHVDNnh1VWg3?=
 =?utf-8?B?YU01M0RuMzIwVWRtZ1BVTjlrQXo3anRzdzNhb3NyWEFTSldRNmxkWE9JSHlY?=
 =?utf-8?B?dmFsVWg5RnJ2RUgwMVZHdkp5ODd2Z0JzNy9VMmQyZU1WWlU3cnR5d05XVExr?=
 =?utf-8?B?K29GeTZiTXNPN2lMdUVzVERIaFp2Zm1vK0drV1NXanlhSlNtcUdDc1ZoUWZN?=
 =?utf-8?B?ZU9STDNHdGhLQllLdWxiSGQ1dnoyVG5IMmx2WG4wWmRUNU9ZSWZnMEIzN0Rq?=
 =?utf-8?B?Q1JQZVZSNmpsNDVkcDJ5blZtZzluNlpNd1UxSmUzclZvcnUraGhvamwrY2gw?=
 =?utf-8?B?QTVkLzFPbkFwM2JxTFNWd3hkNDZWRXArRmZiZmVMQkFXemIxU0NvVkpmY0pv?=
 =?utf-8?B?dDR4b1NBdXNzNWc0dnRLT3B4ME5TTXRMS1FmZkpDcEI3Qmd2aE92M1k5Szlj?=
 =?utf-8?B?b1A3bHgxMVNJWE9KeUQ3SnY1VEpSSWRUdDJ1c1JwTWx1K0czcWdrOHBwL3ho?=
 =?utf-8?B?emtnSkppUWxIV3lPWWluSkdtWHBvbHkrRW1SYUZvSUt5RUduVjRNc2ZhVjRa?=
 =?utf-8?B?WTZqQnc2cEVmV0xXQ1JRbkVWemZncXg2YXQxbkt3eVlXMTB5Z3N6Z1psT0Np?=
 =?utf-8?B?OUk2Yk5pV2ZiRmw2Y2xDbnc2ZmtRSHlKYnNKTHNtZmJqb1pZb3RBNnVqQlBN?=
 =?utf-8?B?U1cyYnhxWXliUHlJN1ZxVXlqWVZ5KzR0a2dUd0JPQlhCc0g4ZFFVclgveEQw?=
 =?utf-8?B?aUhRUzFHZzlnYzNONEY5TFRuOXVIWVNwZ1MyektYcUtRTFV4NnVwZzF6Kzls?=
 =?utf-8?B?UXMzZWVjNW80OGQvMExyUlRXNW1tdWpNaUVxZnovdVpNYXJNa216eVBmbkRP?=
 =?utf-8?B?K1JvRDVPMGZ1OGJmRERVT2NZTEEzZGhNOFpPdEczY2NUcHlTODhKRFVPWDF4?=
 =?utf-8?B?bG00d2ZQRWVpS3E3K0E0WWtrV2RlODdweHpLVHBoL0hxK1JtY0tBOXViK3FX?=
 =?utf-8?B?VnNTQnB2SVZ0b0JyRHIxYmtONlN3N3VnNUhiRFpmd2picTRGcHZIdit5Z3BJ?=
 =?utf-8?B?OUlibnhIeVZ5dnQyVDk5Snp5ZjRwK3BFYjYzWnlwcGVlUGdFeW9obUcwRGZE?=
 =?utf-8?B?YjV6L3pPcGNTTThHdkMxR25XcHZNcTF4Z3VOSCtyWUV6disrVlVBQW5GckRL?=
 =?utf-8?B?T29ZUXlJeWlWV3ZKQ0NPbmxKOFljakFuQ0dqNVh5TEJYbTd5Mk5zTW9Nc2pt?=
 =?utf-8?B?UlVIME5FaENJbkllZDFyZ2VuZG5qR2NHdFNDb2U3NCtvSlZIcit4WWZxbTFv?=
 =?utf-8?B?MmJMbklZa3UxZzAwZHI4K0x6UlVJdUlHRDRoNzNaZG5nbGpycEhmUmZvRUxX?=
 =?utf-8?B?dmdlL1VIQ1hOVytMcmxoSTBVeFJ4SUNud2FrbC94WU4wQmhiZU15QUF1VTcr?=
 =?utf-8?B?bkZId3JXcFoyTjJyWUhJaFIyTlQ4MjBUaEUyVFdSM2QyTHlrT2NueGd0L0cx?=
 =?utf-8?B?SCtLYW9WMFJ1d1RkK3M0aVZXS2NidTB3VFRReDNZWXlWdUFWTDdYa0pMWXky?=
 =?utf-8?B?a2xxd0V3OUhiR2s2ajZDWDFNd2VocGxaSDRRNUZLNEZTT3kwL3ZRVGpPKzEx?=
 =?utf-8?B?UEhHQkdzVVVBMlVYYU8rUWhPeEJKRFJuaEJVZ08wa3JMclRlMTdCbTJYa2o2?=
 =?utf-8?B?ZEx6VnI3d2l5K1A2aWltRG83MHFoK2ZaRWx5WFBENS9Xd2dmb3l0cGJQbk9t?=
 =?utf-8?B?WE5nL01xY2hxYW9JNmlpTE8xcjkzekkvOWZSUEFrVDBOZWkrVnI5NHc4anlp?=
 =?utf-8?B?VkpSeStMc1czTTcrN0hDcnk5RGpqZVFRcVEzZWp2Vjg1TVpCZTg0eWwyTmhs?=
 =?utf-8?B?Q3hmbGUrdUxQbzZZU0x4VDFGZVp2U1dtWnpNeGI1VE11aVo1WXBwSXR3TmJZ?=
 =?utf-8?B?aDlranZhbDZXTEZQU3ltMnBkTmJ4bWpTQWdsZUVjRU9nUlBjVjU2WUhPSitQ?=
 =?utf-8?B?Qy9KV2tNdkQrL2xKQlRxSTRDdG9kaTA2Q2s4eEUrU0tFTG9JTlJabzF1dmdS?=
 =?utf-8?B?N1JGSEM3bERVYnVGSnNSMk9ORnZ1VnplR3FKYlh1a3o1VC8zVnB0YjE1YkJt?=
 =?utf-8?B?RW8wNEVsUTVvVzJGMGw2dE9QY0gvK1lIc0VZSW5sd3lWZ3ZYUjI5UzJnQ2Ni?=
 =?utf-8?Q?kjK4SIPGCfKJPXrK6j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52276898-a750-47aa-aa36-08decb9a9a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 11:30:01.2238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uApXxnqEe9Bi9gf6qhJ4rid+eDvUM0KM5oWNh+gC2eauVjY7PRBVuofjunnHXWIqvn4H6nndnFiVk/8T8UC/lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091
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

QU1EIEdlbmVyYWwNCg0KSGkgQ2hyaXN0aWFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTYsIDIwMjYgMjoyOCBQTQ0KPiBUbzogU0hBTk1VR0FN
LCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzVdIGRybS9hbWRncHU6
IFNpZ25hbCBRVUVVRV9SRVNFVCBFVkVOVEZEDQo+IG5vdGlmaWNhdGlvbnMNCj4NCj4NCj4NCj4g
T24gNi8xMi8yNiAwNzo1MiwgU3Jpbml2YXNhbiBTaGFubXVnYW0gd3JvdGU6DQo+ID4gU2lnbmFs
IFFVRVVFX1JFU0VUIEVWRU5URkQgc3Vic2NyaXB0aW9ucyB3aGVuIGh1bmcgdXNlciBxdWV1ZXMg
YXJlDQo+ID4gZGV0ZWN0ZWQuDQo+ID4NCj4gPiBUaGUgcXVldWUgcmVzZXQgcGF0aCBhbHJlYWR5
IGlkZW50aWZpZXMgdGhlIGFmZmVjdGVkIHVzZXIgcXVldWVzLiBVc2UNCj4gPiB0aG9zZSBxdWV1
ZSBvYmplY3RzIHRvIHdha2UgdXAgdGhlIG1hdGNoaW5nIEVWRU5URkQgc3Vic2NyaWJlcnMuDQo+
ID4NCj4gPiBFVkVOVEZEIHJlbWFpbnMgbm90aWZpY2F0aW9uLW9ubHkuDQo+ID4NCj4gPiBDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+IENjOiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
U3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYyB8IDkg
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IGlu
ZGV4IGU5MTg5ZjA3YzZkYy4uZWU4ZGJkNzBlMWM4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+IEBAIC0yMzgsNyArMjM4LDE2IEBA
IHN0YXRpYyBpbnQgbWVzX3VzZXJxX2RldGVjdF9hbmRfcmVzZXQoc3RydWN0DQo+IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICBpZiAocXVldWUtPnF1ZXVlX3R5
cGUgPT0gcXVldWVfdHlwZSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgaHVuZ19kYl9udW07IGkrKykgew0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChxdWV1ZS0+ZG9vcmJlbGxfaW5kZXggPT0gZGJfYXJyYXlbaV0p
IHsNCj4NCj4gVGhhdCBjb2RlIGlzIGV4dHJlbWVseSBxdWVzdGlvbmFibGUgdG8gYmVnaW4gd2l0
aC4NCj4NCj4gTXkgc3VnZ2VzdGlvbiBpcyB0byBjbGVhbiB0aGF0IHVwIGZpcnN0IGFuZCBhZGQg
YSBmdW5jdGlvbiBpbiBhbWRncHVfdXNlcnEuYyB3aGljaA0KPiBnZXRzIHRoZSBkb29yYmVsbCBp
bmRleCBhbmQgZG9lcyB0aGUgbmVjZXNzYXJ5IGhhbmRsaW5nLg0KPg0KPiBFLmcuIGFjdHVhbGx5
IGxvY2sgdGhlIGRvb3JiZWxsIFhBLCBsb29rdXAgdGhlIHF1ZXVlIGFuZCB0aGVuIGRvIHRoZSBy
aWdodCBoYW5kbGluZy4NCg0KSnVzdCBvbmUgY2xhcmlmaWNhdGlvbiBwbHMgcmVnYXJkaW5nIHRo
ZSBRVUVVRV9SRVNFVCBmZWVkYmFjay4NCg0KV291bGQgeW91IHByZWZlciB0aGUgbmV3IGhlbHBl
ciBpbiBhbWRncHVfdXNlcnEuYyB0byBvbmx5IHBlcmZvcm0gdGhlIGRvb3JiZWxsX2luZGV4IC0+
IHF1ZXVlIGxvb2t1cCBhbmQgcmV0dXJuIHRoZSBxdWV1ZSwgd2l0aCB0aGUgY2FsbGVyIGhhbmRs
aW5nIHRoZSByZXNldC9ldmVudGZkIGxvZ2ljPw0KDQpPciBzaG91bGQgdGhlIGhlbHBlciBlbmNh
cHN1bGF0ZSB0aGUgZnVsbCBoYW5kbGluZyBmb3IgYSBodW5nIGRvb3JiZWxsIChxdWV1ZSBzdGF0
ZSB1cGRhdGVzLCBmb3JjZSBjb21wbGV0aW9uLCBFVkVOVEZEIHNpZ25hbGluZywgZXRjLik/DQoN
ClRoYW5rcywNClNyaW5pDQoNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KDQo=
