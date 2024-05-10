Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5A6C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 01:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4D810E238;
	Fri, 10 May 2024 01:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l6tBA4BL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E5010E12A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 01:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkM/uO5TFsUIaUER8u1XF7bMzvlpadO7zT3zS5GbWB1POXsDqT1rKANeVfeGZgecEAYKYg3+upwSu0BoifRH4ghVAxX2vkJFnO8LSaOmLmUQVNz3AAC+jNjPIh7IW5ElwTBquo8HeDDjQ0RwA4g8qrk8adWZTMxNgWH2id/lutiwYiYNqSFJdSHU+AsV38aYx9NWpLRl2g9UJYgIdMOPrTwO849voDSNN3xw1/MzPlPxOMmvEbqSzVXqglO+k+1Bz7l8+MLTDPAzxb9oVww/IeIoH/Aa40Q9KmMpATgnwlRwQDQ+miEmD3fX1fZ5jGFpfBqb1fVKwV3nLM3gYL7zrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1MpoL4zlO6TtKl5hQQslr4+JZdwbWAQfEd48V6QXSE=;
 b=Z1ILC/hTjdtCe9hACdTXPV4acI9OaXuzej7zIO8Kizpj8Z+e+mvFiDmJQqs7M/PfIhZKAZwBtgQZ0NiCewCqZaH2uTmcupnudJ4UViNaLSNvf7+c7oMXurgMOV6hnDbHriXRPTAjrmgBWHHtUgnOA1Osgg8FrWWcx5Q3cug6z1v2s/62deGwSYoib4yxiCVxH5q55AZF/Z/FuYaqvkxPVhtgs7pKxIzlmxH9684Y50vTnJyfEHAPPSTHztJ/IVSgNX4y7CzBS/A4u0lFo5HN3CgnkeYpDGZ8eVY90KDkanKo7BF4yd2UsI2SawGN5SufmmI6c1TsKh35Ut0rC8m+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1MpoL4zlO6TtKl5hQQslr4+JZdwbWAQfEd48V6QXSE=;
 b=l6tBA4BLH2/DJX/GFf3UdnWxXf6Po81sjlmW6TQ0r+tD8CoF5U324IKlQPqKaNEitMb5vtKioqOG7giiFmxcg3LeE3TBORYiLrN9hHzU6u1oZUdxQIknaqe26O3TYmWr8tMX9kQ2RAdKGu1wp6gf+vKAqh5iYCNFdYdFU3TTspk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 01:41:34 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 01:41:34 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile
 setting on smu13 and smu14
Thread-Topic: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile
 setting on smu13 and smu14
Thread-Index: AQHaofSBcv0LtUmTjE+zeFUCqjXDg7GO3UAwgADJqwCAAAqGUA==
Date: Fri, 10 May 2024 01:41:34 +0000
Message-ID: <PH7PR12MB5997A8B37D969667A64A197782E72@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240509093705.414124-1-Jun.Ma2@amd.com>
 <PH7PR12MB5997A8C067197492C30A64AC82E62@PH7PR12MB5997.namprd12.prod.outlook.com>
 <37128b62-3b01-435a-8607-28c67c119927@amd.com>
In-Reply-To: <37128b62-3b01-435a-8607-28c67c119927@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=00829a1c-56b4-47fd-9094-86450117f472;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T01:37:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL3PR12MB6547:EE_
x-ms-office365-filtering-correlation-id: 38a58c13-c617-4627-a1d8-08dc70925353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QXdBdVg1Y0lDSUxhazdRd0IxS1U0N3BEYkFlQzVOQ2RqRHhSRDZuV2laRWZ0?=
 =?utf-8?B?NW44WW00YVFtdFAvalJCcE16OFVnYTZHc1VObjFjT1ZQRXhnejNxelF2dnhp?=
 =?utf-8?B?c09pSDJJeDhicUkrY2FtRkJMZHFZNlU3MTVYY2djL29tL25PbDhxRjBkK1JN?=
 =?utf-8?B?SFk2ZUIzY2dlaTFzSHhGT2hycHNnYmRpZ1NhOXhSM3JlcFkvTWV5cnh1cGc1?=
 =?utf-8?B?V3N4SlBaTVdpYU1hWG4vVlhFUVRmb1RWKzhuMllnQk1hL05zUzhvTHdBbmlR?=
 =?utf-8?B?UzRKczZ1THFJdC9LZHIzQkFjckJyTlJaSnUxNnM4YkRTTm5jd1FqK2VpSlp4?=
 =?utf-8?B?QlZVQnFuZFNrUCtLTUVnaktBdDFzN1hSSmJSbG5ZV0pvbVRseldxUDZWcThB?=
 =?utf-8?B?TjJzR0FjcjVxdkF1UmFOTkhxemZMLzJhN3poRzIxcnFoaVZMOUV5NmRFVnN2?=
 =?utf-8?B?OTgvT2RXcTFnRzg0bjdubmJOa2pkNENwVm95Q1dLRlRYcUtDdktyb2I3WmU3?=
 =?utf-8?B?aTNWRG5VcWtma2VmSThFUDdmdkE2Q01PTDJCWFFQbDhNK1NpQm96dzRjaHlx?=
 =?utf-8?B?Zko2WmdWSjA1VUk4VXlPdDFMakhRcVk2OVhiVFNRSXlxYklNNWFqN1FKSDM5?=
 =?utf-8?B?L1dpTWdXUk1xMnZoQTB2dGVyUlNHR1M5VmhEOXNBc3VtK3JndUgxSlNWQW5E?=
 =?utf-8?B?azVrd2s5algvVUJ0MHcrVjdscFdOVjhHUDlDM0ZTSWdvNXpTYW5HM3J5NE5y?=
 =?utf-8?B?K0w3ZVphUzVMN3hhS0RUUlVNTWJRd2lJM0ZYZHdtS3NTdnI2VVU0TGFlQS9V?=
 =?utf-8?B?eWlJWE5raWYrRnRNOS9JdTlyY0hRT2lpeDgwMWhuRTBiSmZFZUhaSlh0S3gz?=
 =?utf-8?B?UW5wOFpuZ3hlMkZKMWRQWFpza3dlckNOT05tQmhXVythQldUUTl0cVl1U2V5?=
 =?utf-8?B?TmY4MndiTDNyOEZmM3FqY252eG4zZTFaRFJhRmtXL0xZQ2Y5eG5xVXdTRXMy?=
 =?utf-8?B?QitOQ2o1TnRvbU1kQ2c4TWxNcXZPZVBhNUZuV3I2OS9NcXlLc3dHSUc2NVNV?=
 =?utf-8?B?eTRoaHNvellka1RybXN6eUUzdUsreHlIVTY2SFZZS1dnYk4zWlhWM28wMFBq?=
 =?utf-8?B?OUp2ekk5OGhxR3ZlcFJoS3hKZVlXdHBYK2dEOEJVQ2xCNTVqVkUzZDNXZDhO?=
 =?utf-8?B?VHZnVFczb2xtcXY2eUp3eldBRURFTkl1dTNQdyszeE93TzNXNlRFR2Y5VnhG?=
 =?utf-8?B?c1ZLK21CY05yWkp4bXRQc3gzVHJBbm5sZ0hnbWFVaGJUU2FZQzZ0SFJnK2NN?=
 =?utf-8?B?ejhjSVk2OFE0a0FLK2VQamFkYXdvUXRYRyt4dSttT1ArRnp1alQrL1hKWDlu?=
 =?utf-8?B?NGM0K3ZONVdCZ2x4NlVzd1p6bThRNGtuK1M4WW1zRCtuZnlMSlZKQzkxUEU2?=
 =?utf-8?B?dnd2T0szVzl0Y21QNlg5bURuRjhFdXBtaytGbXVMVDkxT2xOZUFPTi96MXhR?=
 =?utf-8?B?VHdhb1p0bVh0NWRpQVJsUi9JQmYvaUgxeUl1YS9NNTZKcWl5RjE0YTN2NThp?=
 =?utf-8?B?dDdrSTlUbmdpUUh6cmNEbllSNGxoaXdOWFEzUG1wd3Q4STc0c1JXa05WZUhN?=
 =?utf-8?B?R3Y3eG14VkQ5QytCakEwV3dHc0FXeXp1aEJsSzRFbkUyL2o1eE9pNHJpdmxt?=
 =?utf-8?B?OWdZdStVYysyS3NRUEFkRnluZnFlelk1azFqZ3FDSEY0eXFRZGc1NHlHdU4v?=
 =?utf-8?B?NlhWYXdKOFpieHdTd2laZjJ4L3MzRjNHdU5JdEREbURpdEZOR3hCVEtWMkMv?=
 =?utf-8?B?czhLaTNYTWkxUGNqMm9LUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0VkbDhWaklnVWo4RUhPQlhCd3M1Q3UzbWdoR1owYVdDVUxvYlQzNVVsNTZW?=
 =?utf-8?B?clhGWVZUQVFiNlBrYkluc2ZyQkhYQVNYNWVVdkZxRXBrQXpURDB4ZTV1TjVL?=
 =?utf-8?B?NTFOYk8vb0NldUpxSjBYeXEzVGZLb3NYU1lFSHpEVzlzQVc3S1VqL0hQV0ZM?=
 =?utf-8?B?eEFLOTVJQUh2bElOaU5qa3huZVpPdzNmUkNwVVYxWlhwbnJ0R3p2ZHVsemds?=
 =?utf-8?B?VlZXY1hiYmJmOHdJdWZJSk5ISzBTeS82amZlcXJJRmt5REJOVjBXdHJMb1Jl?=
 =?utf-8?B?ZENhS2pPTWlzU1VPUEV4UXBqcDVQSEZoT2V3SmtyYWlENXJ1OEN0OEJlbEpN?=
 =?utf-8?B?clpYSFd1U2crTlFnU0hRYUh6czdhaEdBTE5BZHVjOE9CMGNhdFNGZlR2UUl5?=
 =?utf-8?B?UXc5TnJ3VUNPZDVqdzNlaHAyamRuYnUwTDhrTThrNzJMVUlreEpYUFl4ZTYw?=
 =?utf-8?B?cEZ2VHdPWmpwV2pXWVVzSzU4VE1HUzB3UUw4NG8vcDljcGI0NEI1ZDhnT2dq?=
 =?utf-8?B?Q0dsWGd3Rlp2S0dJcDQ3dHIreDdaVFUvenRYcGFSeGRaaEZFVW5la0R5aDds?=
 =?utf-8?B?cHBzZ0UxNGtVY2xWTmRld1VUVUxmd1VBOHVFcGZIU0tvZzg4MFVFN0EyN3BV?=
 =?utf-8?B?M0VmOFY5RDh1Y0Q5dnVicXpEZ1d1c1Q1cnh5bzZzQ0xvMndxUHVvUnhmR2Ir?=
 =?utf-8?B?b2dFWGVWd2wwSGVrRHduOEp6UHp6Z3hkdmcyMkYzMHhBRnpXT2RWZEVQODJt?=
 =?utf-8?B?U1QzYW9CV0NzOUFOcGRRM0hTRHhiWGpnaktyNnpyc2VPWnJHYlJBbFNpQVR3?=
 =?utf-8?B?STVDNGcwZXkwZVdGQnFNQVFIQktBa204YS9tamNHOW50cjRXSWJXYmJLNUE3?=
 =?utf-8?B?ZnZ3MzNqTXJRaDJPamdoYUtKNGJHdnhkWjZrK0pvVHR6T0lTY0wrYjhWVnJJ?=
 =?utf-8?B?VndZMXZsdDJOcXNtdkd5MFJjSmtZT3BJbjUrUnY3bXBQMHZoaGlxM3MyUEtp?=
 =?utf-8?B?VkJWK01JUUtZQXdBbkllenVqTHJEM2p0WlVMdTVsTGJEQ292OTk2ZDZreFk4?=
 =?utf-8?B?bkl3MWZ6bHJTaDcrNHVkNGovaHd4Sk9uQTEvb2RxdnQ4NU9yL0hyVFpPZzNS?=
 =?utf-8?B?Tmw2WHZnRVhHOWpsZzNSR3l3VVdGZmxpTmp3WnQvaVRCRVVqN0l5a3NpM0Nl?=
 =?utf-8?B?QldzdjlaMzl0SzhuWkRUVHhYamxLRUErT01oTWcrRjhzR1VaWU9WbnExK3hU?=
 =?utf-8?B?TlE2bGd3TnNHL1Z5d3ZBdkNDdDhWWTZMSGxBbGtzQ21KSmtMNXQ3UWlrc2Nr?=
 =?utf-8?B?Zlcxcms3TlY2ZWQ3cWRTeVJFY25BOGF0ZSt3TzhhaDdhRmgwbkQxTnN5ZnJN?=
 =?utf-8?B?eGJjY3pTVytNZ2gzdVQyVjBQM0xoQTd4N1YwWlVBSzBGZS9ENTlZNENnNHdS?=
 =?utf-8?B?ZnhkRDhSVVJDb3kxdjgvNno5OS9IUUxhanBicGMvbXFzVEVQaHRiUEFRUThI?=
 =?utf-8?B?M2UyeDh6eWltWVl4Y1NraHJiM2NRa2FIUjhMdU5wM3pMY21KUU1oSmRjSjBs?=
 =?utf-8?B?ZzM3S25OSCs0cEIwbmlPa1dreWdTTDRFYVdIajFEYmdHZlNIY1FmSSs5SG1I?=
 =?utf-8?B?bDNzRUtzRXdqWkl3cUYwRmRidXFuQVhVR2JaUzc5eUpPRDNXQkhYck9JQ042?=
 =?utf-8?B?Q2NORnE1bTdWQzFQZFBPVVdzWUZXVHd2QkY0K3NBUDgxTmR6VXdMcE9KOXNt?=
 =?utf-8?B?YlVQbnFoSFhvZGd4L3JGTTZBcGFLOHZ0OGwybTA4bm1tcUZibGJBWm53YTll?=
 =?utf-8?B?cEtDZklpaVJheHQ2RGNBRFJ4UHBGcmVWbmpxWmhCeHFMbzNWbytySVgrZVJ3?=
 =?utf-8?B?cjFPbC9FYjZ0c3hqZVE3S0F6ZEd6YVZXd3picjBaZ2RET1ljZXluUGtoNEVE?=
 =?utf-8?B?ZFB4NFhYdXZKK2wrR3RWNFpiUnNzb3NHWFhDZzg0UENFelMxMXRoL09sbGZM?=
 =?utf-8?B?YWFTd1RYYXNJeTRGcW9BY0pxV0Q5ejZuMHdTZXE3TTZJaUtTdjMrWnZpMWVF?=
 =?utf-8?B?SldjWGQra1BZMlRSYTZ6eG1WU2xOTHhZOHRVaE5xOHhiL00yOWIrUGE1Qnc5?=
 =?utf-8?Q?/KmM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a58c13-c617-4627-a1d8-08dc70925353
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 01:41:34.4961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGtIohzeIohk5onGrUNqKYsPUO/w2VSM6iWvvigOiNrnlIXL0H+awZM6OH/LSHAE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk9rLCBJIG1pc3MgdGhpcyBwYXRj
aCAjMi4NCg0KQW5kIHBsZWFzZSBtZXJnZSBzd3NtdSBwYXJ0cyBpbiBwYXRjaCMxIHRvIHBhdGNo
IzIuIChwYXRjaCAjMSA6IHBvd2VycGxheSwgcGF0Y2ggIzI6IHN3c211KQ0KDQpSZXZpZXdlZC1i
eTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpL
ZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWEsIEp1biA8SnVuLk1h
MkBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBNYXkgMTAsIDIwMjQgOTowMCBBTQ0KVG86IFdhbmcs
IFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgTWEsIEp1biA8SnVuLk1hMkBh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBNYSwgSnVuIDxKdW4u
TWEyQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0g
ZHJtL2FtZGdwdS9wbTogQ2hlY2sgaW5wdXQgdmFsdWUgZm9yIHBvd2VyIHByb2ZpbGUgc2V0dGlu
ZyBvbiBzbXUxMyBhbmQgc211MTQNCg0KDQoNCk9uIDUvOS8yMDI0IDk6MDEgUE0sIFdhbmcsIFlh
bmcoS2V2aW4pIHdyb3RlOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4N
Cj4gcGxlYXNlIGZpeCBzaW1pbGFyIGlzc3VlcyBpbiBvdGhlciB4eHhfcHB0LmMgZmlsZSB0b2dl
dGhlcj8gZS4gZzoNCj4gbmF2aTEwX3BwdC5jLCBldGMNCj4NCg0KRml4IGNvZGVzIGZvciBuYXZp
MTAsdmVnYTIwLCBldGMuIGFyZSBpbiB0aGUgcGF0Y2ggMiBvZiB0aGlzIHNlcmlhbC4NCg0KUmVn
YXJkcywNCk1hIEp1bg0KDQo+IEJlc3QgUmVnYXJkcywNCj4gS2V2aW4NCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWEsIEp1biA8SnVuLk1hMkBhbWQuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgTWF5IDksIDIwMjQgNTozNyBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gQ2M6IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPjsg
RGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgV2FuZywg
WWFuZyhLZXZpbikNCj4gPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlh
bg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTWEsIEp1biA8SnVuLk1hMkBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1L3BtOiBDaGVjayBpbnB1dCB2YWx1
ZSBmb3IgcG93ZXINCj4gcHJvZmlsZSBzZXR0aW5nIG9uIHNtdTEzIGFuZCBzbXUxNA0KPg0KPiBD
aGVjayB0aGUgaW5wdXQgdmFsdWUgZm9yIENVU1RPTSBwcm9maWxlIG1vZGUgc2V0dGluZyBvbiBz
bXUxMyBhbmQgc211MTQuIE90aGVyd2lzZSBpdCBtYXkgY2F1c2Ugb3V0LW9mLWJvdWRzIHJlYWQg
ZXJyb3IuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hIEp1biA8SnVuLk1hMkBhbWQuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzBfcHB0
LmMgfCA1ICsrKysrDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3Yx
M18wXzdfcHB0LmMgfCA0ICsrKysNCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
NC9zbXVfdjE0XzBfMl9wcHQuYyB8IDUgKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTMvc211X3YxM18wXzBfcHB0LmMNCj4gaW5kZXggZThiMDE2NjJlMTY0Li42YzI0ZTIz
MDYzODMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMv
c211X3YxM18wXzBfcHB0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiBAQCAtMjQ5NSw2ICsyNDk1LDkgQEAgc3RhdGljIGlu
dCBzbXVfdjEzXzBfMF9zZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVjdCBzbXVfY29udGV4dCAq
c211LA0KPiAgICAgICAgIH0NCj4NCj4gICAgICAgICBpZiAoc211LT5wb3dlcl9wcm9maWxlX21v
ZGUgPT0gUFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NKSB7DQo+ICsgICAgICAgICAgICAgICBp
ZiAoc2l6ZSAhPSA5KQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4gKw0KPiAgICAgICAgICAgICAgICAgcmV0ID0gc211X2Ntbl91cGRhdGVfdGFibGUoc211LA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU01VX1RBQkxFX0FD
VElWSVRZX01PTklUT1JfQ09FRkYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBXT1JLTE9BRF9QUExJQl9DVVNUT01fQklULA0KPiBAQCAtMjUyNiw2ICsyNTI5
LDggQEAgc3RhdGljIGludCBzbXVfdjEzXzBfMF9zZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBhY3Rpdml0eV9t
b25pdG9yLT5GY2xrX1BEX0RhdGFfZXJyb3JfY29lZmYgPSBpbnB1dFs3XTsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgYWN0aXZpdHlfbW9uaXRvci0+RmNsa19QRF9EYXRhX2Vycm9yX3JhdGVf
Y29lZmYgPSBpbnB1dFs4XTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsg
ICAgICAgICAgICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gICAgICAgICAgICAgICAgIH0NCj4NCj4gICAgICAgICAgICAgICAgIHJldCA9
IHNtdV9jbW5fdXBkYXRlX3RhYmxlKHNtdSwgZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jDQo+IGluZGV4IGU5OTZhMGE0
ZDMzZS4uNGY5ODg2OWUwMjg0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCj4gQEAgLTI0NTAsNiArMjQ1MCw4
IEBAIHN0YXRpYyBpbnQgc211X3YxM18wXzdfc2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3Qg
c211X2NvbnRleHQgKnNtdSwgbG9uZyAqaW5wDQo+ICAgICAgICAgfQ0KPg0KPiAgICAgICAgIGlm
IChzbXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSA9PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9DVVNUT00p
IHsNCj4gKyAgICAgICAgICAgICAgIGlmIChzaXplICE9IDgpDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPg0KPiAgICAgICAgICAgICAgICAgcmV0ID0gc211X2Nt
bl91cGRhdGVfdGFibGUoc211LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBTTVVfVEFCTEVfQUNUSVZJVFlfTU9OSVRPUl9DT0VGRiwgV09SS0xPQURfUFBMSUJfQ1VT
VE9NX0JJVCwgQEAgLTI0NzgsNiArMjQ4MCw4IEBAIHN0YXRpYyBpbnQgc211X3YxM18wXzdfc2V0
X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgbG9uZyAqaW5wDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGFjdGl2aXR5X21vbml0b3ItPkZjbGtfTWluQWN0aXZl
RnJlcSA9IGlucHV0WzZdOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBhY3Rpdml0eV9tb25p
dG9yLT5GY2xrX0Jvb3N0ZXJGcmVxID0gaW5wdXRbN107DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiArICAgICAgICAgICAgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAgICB9DQo+DQo+ICAgICAg
ICAgICAgICAgICByZXQgPSBzbXVfY21uX3VwZGF0ZV90YWJsZShzbXUsIGRpZmYgLS1naXQNCj4g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYw0K
PiBpbmRleCAwZDVhZDUzMWM3NjQuLjNmMDQwYTRkMzc0ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jDQo+IEBA
IC0xNDE4LDYgKzE0MTgsOSBAQCBzdGF0aWMgaW50IHNtdV92MTRfMF8yX3NldF9wb3dlcl9wcm9m
aWxlX21vZGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAgICAgfQ0KPg0KPiAgICAg
ICAgIGlmIChzbXUtPnBvd2VyX3Byb2ZpbGVfbW9kZSA9PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9D
VVNUT00pIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChzaXplICE9IDkpDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+ICAgICAgICAgICAgICAgICByZXQg
PSBzbXVfY21uX3VwZGF0ZV90YWJsZShzbXUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBTTVVfVEFCTEVfQUNUSVZJVFlfTU9OSVRPUl9DT0VGRiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFdPUktMT0FEX1BQTElCX0NV
U1RPTV9CSVQsDQo+IEBAIC0xNDQ5LDYgKzE0NTIsOCBAQCBzdGF0aWMgaW50IHNtdV92MTRfMF8y
X3NldF9wb3dlcl9wcm9maWxlX21vZGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGFjdGl2aXR5X21vbml0b3ItPkZjbGtfUERfRGF0YV9lcnJvcl9j
b2VmZiA9IGlucHV0WzddOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBhY3Rpdml0eV9tb25p
dG9yLT5GY2xrX1BEX0RhdGFfZXJyb3JfcmF0ZV9jb2VmZiA9IGlucHV0WzhdOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgICAgIGRlZmF1bHQ6DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICAgICAgICAgICAg
fQ0KPg0KPiAgICAgICAgICAgICAgICAgcmV0ID0gc211X2Ntbl91cGRhdGVfdGFibGUoc211LA0K
PiAtLQ0KPiAyLjM0LjENCj4NCg==
