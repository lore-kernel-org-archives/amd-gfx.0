Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD48CCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 03:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E06010E350;
	Thu, 23 Oct 2025 03:58:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ZGRSeDr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E16A410E350
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 03:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYuI9WFRfFR0bTMhg/i31ZyQr0TYcMRdHIDU/WRT2RSA6fRURMQvZA3qlUCq3Yu+T1qjVuiSkymRxE7RY6uvPjQOh6xb2/otlCXgZfcoa6hZyECyxQfEAnZugCas9ZXEXndC//OHS/Ib96tqun85fEFGuOiV+KJSVR8jWcncIrSBrG5c4FD19YCgqizQ+BLRkkhAHxMIdz2VltZl8hF2fSQntXjVV48r38vKQ+IuqdxGhw3GiR7LC0G+RuC3FZb4Hz7bmRQQoqXv7vrSsaZSAg4mIjzJz3UYvY8+yGpvGWp/C4Lq9w9fPP8jI6LcCPhNHLgN67ntx/SfieZejC6AvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uIxKB1j9Azca0KYQ+CC6zX3RTvymldpMYAANdzlpp4=;
 b=lQ+hC99Igw0e9D8Elzy2e/FyJ0TNiV5UgFChIpvlkqYCEM+9d2UcUn+xyLkKh8fAhp7GIUvj2xWuTu3U6SdRm9CbP7nWBNAJODLvzs1BTtU+RVDh34Y2yjRNdzjb4+maayIPRqXFkgmATP0r6khAI50Aui+RRfNVtc5ZAxokx7FUor7DhEp3pCvIE4GrvnkzW3Y0JQjSRkz859bgUImJYMbNkMI5NKUTrxNrA2lmkYMEDb7kzXSxUcBobOVNANyfC7Wm9OQBfy8uj0UAAxOZvFfwhU0C+giS7V/ANSVGFKiv80HDCF+IV+Rg8U7U/pGW6S9N+a8sIWyNdIyJUYVO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uIxKB1j9Azca0KYQ+CC6zX3RTvymldpMYAANdzlpp4=;
 b=0ZGRSeDr2FyxWqHfjwdUxF2bTZ114Don4m9ZiIgupZY4UwPEhYjf9lE6mttVaTHsrAho2HHpsfPKpXcbE7ZX9004yOZKzhvX8650nZUp23BfKpAyC3dmKP0/Ma2DylcVjeWO4C/1DmnjoL++GL/GfY11Z3BysYDKu/0Txg+aArQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 03:58:50 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 03:58:50 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Fix NULL deref in
 ras_core_ras_interrupt_detected()
Thread-Topic: [PATCH] drm/amd/ras: Fix NULL deref in
 ras_core_ras_interrupt_detected()
Thread-Index: AQHcQ1IUNdO3XJTk2E6GzHSHPUBobbTPHANQ
Date: Thu, 23 Oct 2025 03:58:50 +0000
Message-ID: <PH7PR12MB87961DB2D523C64ED5583FA1B0F0A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251022124651.237996-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251022124651.237996-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-23T03:58:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA0PR12MB4415:EE_
x-ms-office365-filtering-correlation-id: 6fb8b462-415f-42f7-61d0-08de11e87981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dG9kV0NEVEZtU2ZLZ2trT2NORmVOWGE0UitWNmVqaHlvTlFacXdhcFBzTEdh?=
 =?utf-8?B?czlCek11ZWdwUllzQzJqdE81RUxOejhTV3RJVHJBd0doWlh2eVBjaG1xZ1o0?=
 =?utf-8?B?VWFiaDdxRjJoem1wY2J1WnBGNUhKbFFGYWtYcit1UDFkY2ZHMThoRjlCQjcy?=
 =?utf-8?B?R2szWm9zdEY2UWxMdXQ4MU9QeWl0a3Fnc0V2OHA3Q3NsMmxPaXp1YmtCbHZC?=
 =?utf-8?B?Q1Vld2orRWRoUDJmd2sycDFPS0l0UnlSdzd6T1BIMmlBZHFvNzhmeDljWXE2?=
 =?utf-8?B?OWN3RVBCQTBoS1NMRDNXcXJrOEJDNHVJeDFRUDdieEVla2hjUjNCMlo1YTJU?=
 =?utf-8?B?OHVpZFRuNmxTbUtJcXI3K0N4Y2dVYWJENjA4bzRjeTdzT3ZUVzNvQ1RYc1VG?=
 =?utf-8?B?Y0lJcnc3NEJNMGFqKzRxWVE1ZEd3KzVGNVNwWFNlWHpZQTE1dEI1RmtHbzNR?=
 =?utf-8?B?bWJvZ2VsYWFPZXdyYWU5VnFETWpkMk1BQlBmaDl3M1laYWxtL1RXLytITVVM?=
 =?utf-8?B?cytvdndvZ1krL0t1OW4vUzR3MTB3T3VjWmlWK00veElFN2NhZ3RUTmdIQWw4?=
 =?utf-8?B?REI3OElSb1lld3BjdnZvcXFqMnNpdkVLenRyK2hScCtDNlErcVdObXpxMkdQ?=
 =?utf-8?B?a1hyOHByS043bjQxeDVlS3NjMzUxMWVQU1NZVmJQaGpBY3pQN2owN25laGdX?=
 =?utf-8?B?SzRQZ0VncUNzUGUxZU8wYkhJMTRPNndtclIvajFMcVQ3VnBqOTFOMU1GQlpu?=
 =?utf-8?B?S0lUVllLcXA3VmtZMldyT2J2bGU1a0xNV0tIRTZNNzNZZHVvT2xxWEVOSHJC?=
 =?utf-8?B?TmErbzVmc1piWkRSaGF4UlhUZFp2MFdRV0ZCZ3lOTjVhWm81c0lhZGk3N3l6?=
 =?utf-8?B?ZzhYVEFhWXRtck9wUSs0dHBtT0NYRU5VT1RUd0JYSjNSc1NEVUFqUGZKanJ1?=
 =?utf-8?B?VjV4bXRRN2ZrNGtRK0w2U2h4bWNnSzFqV0lkZmZDWktQQm13QjdOZTMwWUFH?=
 =?utf-8?B?SkVFb0QrakwwSWdFd1ZGMTdJVmZ3VDBSa0I1bmphZ1BMU2hQR3lpVXlwdm9Q?=
 =?utf-8?B?ZVR6MnFYT2tJOWNPa04xSFNIbmVGd2lUSWNRQUhGL1pTYWpjNzVreE5DdlQ3?=
 =?utf-8?B?TDZheEltKzlWeHgrOUdXN1JYeUlUS3Z4V0krUkt1ZE5aRHFIK3RSVHhqNGxG?=
 =?utf-8?B?YVN0SVRySzRzNDM5dTRlRFhwWFBQdzdyUnVGYnhGT29xSFFLekdUaFZ2Q3hY?=
 =?utf-8?B?dm03ZlpqWExoKzh4c0JiYzFWWjVDZVpVc2JIUkVpNjZUa3ZSR2h1QnRXSllp?=
 =?utf-8?B?L0VGUVpMQXBjRENJNzErdUx3SzBVRTQ3Z2UrUDRUVGE3cGUrZndHZ1p4U0lk?=
 =?utf-8?B?RUMwWUdKaHFvRGp1cFJ6TUllWnhoY0VRMk1IckcvaXJ1TkxXNG9JdHFJdGZJ?=
 =?utf-8?B?YnRBdVhwY29VRjV6ekNuT3BTQm1WdjdqWkZ6TWdaN1hLZ3JzbmdlWnQ0K01V?=
 =?utf-8?B?UG9kNjNLUFJzalVzS2d3WkU1OHY3VzBBSEVWM1NaQUM3MENLNVdab1ZqWERt?=
 =?utf-8?B?eEdid0pPQ2NJMndONXhBeHBxN0F3OTB5eE1XKzNhUlJ6TmxJT1lac2FJZStD?=
 =?utf-8?B?VUdtNm1DNTh5SUxpZCt0RjAzcDYzVWkwM2hTMTVFR1d3WHAyZHpreWNGdE9u?=
 =?utf-8?B?YkNDSHN6TUx5RGpLb3pKRTh6Wi8wTHZhaEV1QVJxRFpPSm9FMmsrWG43WS84?=
 =?utf-8?B?NzRpRjNFSjNyM0Q1MW5FNm1QV3BxMS92dWFlZXdWTEdXbzZDYXVBdVlOcncr?=
 =?utf-8?B?bTFHeTdFQ3QvZi9WNXp1ZmtDc1VqVFdQZzFvY2dTcUc5M2NsKy9YbGVUaEZW?=
 =?utf-8?B?RC94WFBIRis1Vk5nRFIweHNLOVk5L1VlL3Y5UWFhNkdTUlEwQWQzbGUwK3U3?=
 =?utf-8?B?bW5xTUUyOUN1UlFMcDd5OS82TWJybi9LTXJtS0pucGdHaHpnWEFQZ0wzWDJL?=
 =?utf-8?B?Sk5lOHpQVzlOcktPTmJ5OXFubEFBNTZHVlQ5ODRHN0dGaWFqbW00MmdsQ0h5?=
 =?utf-8?Q?Yc2mSO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkNhQXBBVWk2MDkrNVJISkNnRkU1UDJaZ0hpQVFpa2VCRm9Hdm1QUXByVXUz?=
 =?utf-8?B?QlREMjJiMDB0Y0E0eEkvd24xVTYrRTZzeUJNSGJFRU5wZDI4Z1cydmNENTJH?=
 =?utf-8?B?ZUlZZjBlSFIwVHd4N0hLMnpRa244ZW1qdXhpWXNkT0pIa1NlNlZYRkZYV2VR?=
 =?utf-8?B?ZmhjMUt4ejhnREdOOHhmUHd2ZEx4U0tjdFo5Z09hQ1duUEk1YldTdmVYYUpv?=
 =?utf-8?B?b0l0a1JvYVBIaHNBaENmMjIwdUpXbVFqNi9UU0JadUFRUmg5dE9neElYNm15?=
 =?utf-8?B?WlUvMkE2TXRVdjZwcTdWMjUwazR2K0tCcHV0ekR5RkhUNnlNdjJlbWhUSFFK?=
 =?utf-8?B?Uk9qOExyYlRqbXBlTkswLzVOc1VPYXdJQWEwcWk0a0F6bFB1WkJKQ1l2YWFM?=
 =?utf-8?B?SmJjS3NyN21HS3RtVFlZYVliMkVvTEpkS1dqMk0rTHZEd2lHZjFUL3REMEZ6?=
 =?utf-8?B?UHF2b096aFl6SWcyYmhrUCtqazB1M3RYVWJHUHpCT2tIUGMxd21BeEluSzgx?=
 =?utf-8?B?b0dNY1hYMWVmWURuTmRheGVnRVRJRTkrQkNiVnRZajlIQk9LMUc5bjlEM25Y?=
 =?utf-8?B?SzhqQytwQWsyeHdhRFVhcFptVG9TektBZm1OLzJuQmF6NGRGZ2oxRTJUR2Zq?=
 =?utf-8?B?ZkgvV1plK1pMbjM0UE1MYTkrMHB3ZGFGeXY1QU5aeUI0WEFKbGRoRS9lY1ZO?=
 =?utf-8?B?Vzl5N1F6K2FUVHY1ZS9Bb1F1MURQc2VZK3JIa051YTkzY0lSaFJ4RjNSaHZk?=
 =?utf-8?B?RXhSMXlqL2hVcTN6c1VZdFpxc3ZlNkxpYnFRcmEzWndrWXRlazZPOFlTSHRI?=
 =?utf-8?B?WC8yc1Rac09WT3cvaGt0VjhseUFWNzlOVkk1MGU4ZFpOWVROUFpKRitqNWR1?=
 =?utf-8?B?KzFmdm5LbU1adXZoaGdVbU91VUs2QTFLdEhYZW8zZ2lJT1dqVnIzbFRqMzQ5?=
 =?utf-8?B?dkxmWW56ZzlqT3ZOMGV0cGphUzRlYTMzZXh6SXE2YUN6NGpmSlJJKzBVd2dy?=
 =?utf-8?B?bXBsZ21oMjIrN3g1WG9YTDNjQklGNUFydHgvaHZKQjJzMUNEbms2TU9SS2Ey?=
 =?utf-8?B?RFRwR3VPYWE0R3pEUG9wd3pKeURyRW8vUVVIZjg5VlZzYTQrRkI2bmM0TGcr?=
 =?utf-8?B?REkzZ1lTbW1Qak1pYWQ0b3JzbFdXOURSTFFtZVR5cllmUUZYV2UxNjZUd09y?=
 =?utf-8?B?YTlLdUZ6V3hjZyt6VDBDMElGMjNNMW11R1RZQm1HdUh1TlVyczlHTUJBb3lp?=
 =?utf-8?B?YU9WNVFaaVBPdmtVSWsyaFdXVEZ1Qk52N045MFI2dDUwZ3hWTGxOY0kvK0ov?=
 =?utf-8?B?ekpDMEpoSU9ncml0TEhwNVpjY2Nlc0VNenNaQ3FHU1pxdWZVR0VSTGRHT1Q2?=
 =?utf-8?B?QTN0NFNSUGh4U0gxYVdhTHZaZjFYT0p6MHFrQ0hVTXltd2FTS0VLYTBTenY4?=
 =?utf-8?B?N3BidWNOaU50Y3NEU253N1dDejRVM2x1ck1KYnl2c0s4cFlESVJYT1duMC8y?=
 =?utf-8?B?M1gyMzU2bFlnbmpRNXpSTXNhWkhDYUczM2o4a0JNU2hTSEdBVVJYSU52QjFZ?=
 =?utf-8?B?QUw5VDZsbmNKRGFaRitkd2VyZkUxT3V3UFF5ZDNjTE5TOERwU3NkaVhaVWRI?=
 =?utf-8?B?YWRobkN5aVVEZFZjc05KRUVDcUs4SHN4dmRUTWpZZGZPZXpkNUV0Zk43eGVF?=
 =?utf-8?B?aE5PdlFFUDA5Wk5Dd3ZVRmJVZlN5RGNMMms5bUpEQjBiVy90Z3FmNjJwSHJu?=
 =?utf-8?B?RE5XL05JTnZjNkpLM25yVzRaWlBqUXQ4KytLNzIwZXhxd3E2ZEdxdDIxTjgr?=
 =?utf-8?B?azhkYWlpcUZ4cVJ5cWhndGhrQzVIUEhLcTExSEx0TVFSdm5rVDg0cjc3ajhH?=
 =?utf-8?B?TDhLb0ZJVmxTb1l4T0ZSblBHbmQ3ZDcydEJKWVhoL011L2FWRXdvTGNTSGQy?=
 =?utf-8?B?YnhPM1ZaTmVwbmVJUWFIMlkrS3grcVF2K3Z5dVhkVFVYSDVUeXowb0k4ZGRi?=
 =?utf-8?B?ZEEyYlF0VnY4aWh3MG5QdFhqbTJybWNSYU15ZUgrQ0ttTlRKUFQvLytURjd0?=
 =?utf-8?B?V3JRVk5XMWYrdzNJYnFRVzNaZWpaVm9aZWxTdmxOaHZYek5lYzdXMlFVNXJt?=
 =?utf-8?Q?D43o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb8b462-415f-42f7-61d0-08de11e87981
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 03:58:50.1668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKC4NWQXPlw98+VglWEM1c9acUvHhFL79XfHAbWukt3LXr7+d57wlZ0/nCKYgehq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
Cg0KUmV2aWV3ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5J
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyMiwg
MjAyNSA4OjQ3IFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklW
QVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IENoYWksIFRob21hcw0KPiA8
WWlQZW5nLkNoYWlAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgWmhh
bmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kL3JhczogRml4IE5VTEwgZGVyZWYgaW4gcmFzX2NvcmVfcmFzX2ludGVycnVwdF9k
ZXRlY3RlZCgpDQo+DQo+IEZpeGVzIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHdoZW4gcmFz
X2NvcmUgaXMgTlVMTCBhbmQgcmFzX2NvcmUtPmRldiBpcw0KPiBhY2Nlc3NlZCBpbiB0aGUgZXJy
b3IgcGF0aC4NCj4NCj4gRml4ZXM6IDJlYmNmNzg0NDdjYSAoImRybS9hbWQvcmFzOiBBZGQgcmFz
Y29yZSB1bmlmaWVkIGludGVyZmFjZSBmdW5jdGlvbiIpDQo+IFJlcG9ydGVkIGJ5OiBEYW4gQ2Fy
cGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+IENjOiBZaVBlbmcgQ2hhaSA8WWlQ
ZW5nLkNoYWlAYW1kLmNvbT4NCj4gQ2M6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCj4g
Q2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gQ2M6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBT
aGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfY29yZS5jIHwgNCArKystDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc19jb3JlLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc19jb3JlLmMNCj4gaW5kZXggMDExMjJiNTVjOThh
Li41ZGEzNTVlOWEzYjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jh
c2NvcmUvcmFzX2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3Jl
L3Jhc19jb3JlLmMNCj4gQEAgLTUyOCw3ICs1MjgsOSBAQCBib29sIHJhc19jb3JlX3Jhc19pbnRl
cnJ1cHRfZGV0ZWN0ZWQoc3RydWN0DQo+IHJhc19jb3JlX2NvbnRleHQgKnJhc19jb3JlKQ0KPiAg
ICAgICAgICAgICAgIHJhc19jb3JlLT5zeXNfZm4tPmRldGVjdF9yYXNfaW50ZXJydXB0KQ0KPiAg
ICAgICAgICAgICAgIHJldHVybiByYXNfY29yZS0+c3lzX2ZuLT5kZXRlY3RfcmFzX2ludGVycnVw
dChyYXNfY29yZSk7DQo+DQo+IC0gICAgIFJBU19ERVZfRVJSKHJhc19jb3JlLT5kZXYsICJGYWls
ZWQgdG8gZGV0ZWN0IHJhcyBpbnRlcnJ1cHQhXG4iKTsNCj4gKyAgICAgaWYgKHJhc19jb3JlICYm
IHJhc19jb3JlLT5kZXYpDQo+ICsgICAgICAgICAgICAgUkFTX0RFVl9FUlIocmFzX2NvcmUtPmRl
diwgIkZhaWxlZCB0byBkZXRlY3QgcmFzIGludGVycnVwdCFcbiIpOw0KPiArDQo+ICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gIH0NCj4NCj4gLS0NCj4gMi4zNC4xDQoNCg==
