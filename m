Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3B6D49C6F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6B210E919;
	Fri, 30 Jan 2026 08:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gyw/XsaD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B6C10E919
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctAIDtDHOzIpKPeSYRyIHJoD0hrRTDLX6fMg1IGF+Q5SA85F2qN8jPfSCyJO0tG9OsuJVFmCWMgMXPHx3hMiwmnLeBB/ECDGXrO+N9264nMIzgsEeC3iMIdZLcbJLRwJMMmiKU8yko/6zQGJ3hEprSNgJTFhEW4mw46LBV7D9hf5jS225u9USZix65xjKJ/AkQVYlCJq1cW7jubGWXgse8J4nBYsnqys4/CBaBUhtN4iLAwYM6NIPkLLkI0gJRms+wkYn9P8zwA25WRojRQDFbKJe7KFalR0EpTUY+yUnFCu0zNafgEuZqE3uu5QGBd02tv+SOIdPUyxAKNqnslqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItvPHHOb4G8Ixg2qenEaJH0F+d1R88OCJ8gYGPOEaR8=;
 b=LDVxND7Rx+4sjm3aICHmKqnbgOTm8qg9d/C+r/IYJ1xQmXzGv+jMKdvmmc8M9dcPJ3aH7ZzCSYVo8WGYJN3TtKxA3hM3Hx+rLdnwhsQJvFh5U+ISqlD8EebCtZeLFnqqjeeZS8tkknAey8dlaw56rLCq4e7UVBHU/sqCGxOTIKmeAeDMMRGrwNckWZd0/KcfwpDeOVppY4zmVibd1mSTz5grB17OmnQSUCYWf7TyY5U4Ok6vuRvHi5eb2m/iWIJt7j5ijAjX50egAxYsu6HIwPDJwPMXyB8VkOecxd2mrvdPFIdnT5ky+j1xfX9170ufgme4EfHAaTIOWUl1hq9SCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItvPHHOb4G8Ixg2qenEaJH0F+d1R88OCJ8gYGPOEaR8=;
 b=gyw/XsaD3BGeuNgYy4hZgXlRIKUPjd5zGj00WVUpDsjIBsZRav1aqHWyWLLhJVAMPcbA0cFxJy1lNqcd0i1TtD7yF3IkXO7yruAR64ps+NjstydR91kAji9se3hFpGCvH5XtQuM8cZOogfveehj5T7vvcxTAMP/ctPteLZtgS+I=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:14:11 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6%5]) with mapi id 15.20.9564.007; Fri, 30 Jan 2026
 08:14:11 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 06/14] drm/amd/ras: Add table reset func for pmfw eeprom
Thread-Topic: [PATCH 06/14] drm/amd/ras: Add table reset func for pmfw eeprom
Thread-Index: AQHckZBx8ua2gmL0JEeXdWIItJtzcbVqNQoAgAAnEmA=
Date: Fri, 30 Jan 2026 08:14:11 +0000
Message-ID: <MW5PR12MB5684777AE81EA70924FC63D8E59FA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-6-ganglxie@amd.com>
 <60ffa101-d99e-45b1-b40d-f89d2e937345@amd.com>
In-Reply-To: <60ffa101-d99e-45b1-b40d-f89d2e937345@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-30T08:08:29.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|CH0PR12MB8577:EE_
x-ms-office365-filtering-correlation-id: 0ad0db45-818e-426c-fc79-08de5fd78ccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?eFVGZTNGbU9JZEVITTJyRG9NdDFSUUtmVnkvYzVSUTk3dXFGVHZFeTd1UXlp?=
 =?utf-8?B?bmJ3RHZFUGZjZWtRSUswdWtFVnVKZmMxamJqNVhBdXNVZTZUK21rRlRJR3Nj?=
 =?utf-8?B?eVJ5TmtqMXZ1eDdKUlQvWHlPbXJoSGZud1V1WUlZZ2ZpQUZoTk8vSFhzU2xx?=
 =?utf-8?B?Y0Zvem5VOEhEbW8wckJETG1RdDh3eWd2ekZ4T0tjMkxMT2Y1elpjbi9Ca1BR?=
 =?utf-8?B?WHFDejlhWWtQQ3BMOXVJSHF1dmQwb1lsLzJ4ekFNYTBQV1oyWk1YVldIMC8z?=
 =?utf-8?B?RjVQK3VBeFBGRWo0cUE5VDJlVzJyaGxLTE95eGJkRWNqZUFiNXRMNVlVL0Vp?=
 =?utf-8?B?a0ZrLzRZYzZpRnhxTEZnZUpCdkZJdTRjTmhuWGhIZ2UrcEZaSCtqbElKZ1Nt?=
 =?utf-8?B?VWo2bWNXcXhXY2MrRVA4RStvM1FieDMvZVJ4K0UzdVdHMkhkdjRSYVhqNEY2?=
 =?utf-8?B?WFdjWk1uRTluYVk3WTNlNnNkNm9JRzZaYURjZVpVeEtqWTdIZ3F6UFNHa3NK?=
 =?utf-8?B?djFqUXQxL3RrYXNZR0ZoYksxNk9LVzVia2RjVUNLblhBZmZUU2VKdzBiTGYx?=
 =?utf-8?B?eUhIK2QzVWRiMENvOTBIYm1lV0hiNmpSZFRPTWthOGFxMU05dHRLc1Nuclk1?=
 =?utf-8?B?MEwxcHhKajB4WUJvZXhUY2xBbjFvYWNZZ2srZU8xK0laQkhBYjZtMHM1R2Zu?=
 =?utf-8?B?b2VPV2RMcG0zcnhQVU9KRmpYWEtHQTVJSFUrT1paaDBFK3BxZDZLSFJGdEo3?=
 =?utf-8?B?eklZbi9ndDluZ3BBQm8yaCt4ZXRyeDd0bG1rVE0wM1VCM0pXcWE2NjZ5S28w?=
 =?utf-8?B?RHBadkRBaUZNWDJsc3NUelpkNndCVkpSV3JWd3I0R1RaclhYRkYxNHdKL0pM?=
 =?utf-8?B?dnRyWmx3bDNEUmsyaDNLZEx3OEd3bFgwWmxTbDhHbXByTDYvdXVMUW1mTlhF?=
 =?utf-8?B?a0tLT3ZDaHpkSkJiU2Q4eDRGL1BiUmV0Q2k3cndLN2NuYVdvck9GZDVTRmdy?=
 =?utf-8?B?Ym9HTnJyM3J3QkFWMXpzN1RrMEZQU1o2cWJTM0ZuQ1BlQU04c3ZkUkZYSE1j?=
 =?utf-8?B?bE5uVFdWK09WRkFxaXJaaVJucEEzV0tDN3ZUQy9MbTJrZHJBK25YZmNTTU1a?=
 =?utf-8?B?NnJLQjVaSWxXYUo2eUhvT253ampNcU43Vm1HSVRyczRpbi8wRHZ0bXdwanJl?=
 =?utf-8?B?SURtMEkvb0l4dEFUSFc2L3plSHdaL2NvbEF0SDBYK3BEQ3d3dFVNUzBGd1NW?=
 =?utf-8?B?NDRFOExYRHRJZHlyZDdtOUlRak9MdTlhZmt5RUFEeUduWWdkekF6MVg4ZW9x?=
 =?utf-8?B?S09iWEU4VkVTdHJQL2xJZmxKcDFpZ2dkcVdaOFBGS0UxYXdzU2MxQ2xZK1hV?=
 =?utf-8?B?bGtvK285clEzdk1WQ3NwMW9xUFBGcGZHT1lMekl2UWdlRm5YZXZDTkJGQzBq?=
 =?utf-8?B?ZEJBdllYUElHTkFCYTRzY3ZKdTNXeWNnaGlZdTBpaFNwM2FIUVVwM2Z6eHMy?=
 =?utf-8?B?Z3gvekVkSnFxUFBpemM2bXFCMnpwT3Z1bmtjNEVPUVFhOXZFU1dlQXcvMTdR?=
 =?utf-8?B?OWh1cjc5S0hkNjZkcmUwTWs4VkVpYVFwTzZmcTlDcFFMU2xucVZYUVJHbVBm?=
 =?utf-8?B?WmJDZkVhcnNwZkQwcGpxaENWcHdwZFpaRGFhRm5QOVNGOEpYZjQxd2dyQXZW?=
 =?utf-8?B?VVcxZ0Y3b0I0bk82SUUwMS90QllIaVJoblpoQmVuS1ZydnpLczVVM0MvQmpM?=
 =?utf-8?B?ZVQvZEwzU3pMSjFMdmZMN0dVYUphc1F5Q1N5M2FMZXpaZ0piN09DRnowMmU4?=
 =?utf-8?B?dzdRbzN5eGNlRnhaTEx4R01yU2RNVmREZjhVN2ZLeFlsblIxK0ppZExtTzNa?=
 =?utf-8?B?Sjd5YVhxUmhscTBQNENSdWUxUGhXYmhHUHd5cDVEWnRyVHVHbTJhOFM2cW9F?=
 =?utf-8?B?N1g5QjVwZ2RoNkZ2ZTNIRG1iMFcxay9MRnhHbHpTaUFlclBvWC9RQnlvRjFV?=
 =?utf-8?B?YkZsdFVLYWR6ZFd5YU93Q1d2eHpxcDBjcVZlYUpaYnY2enJFLzdZMEFmOGQ4?=
 =?utf-8?B?UWFscEJFVitZdUhVK0taWDBqdldlOE9JbTRiSXBhcUhpdEFnTEFtZXZDOVl0?=
 =?utf-8?B?d0xpcU1nYSt5d0x3UkhoNG4weWRxTW1vaU12STJnT2svTWhleEtRWmFjQ2hY?=
 =?utf-8?Q?PQxOcwOPq2D90tHgQUTSaJI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZWbFdQblJpb1JoL1llWTY5Wjh1NFFtTXJQYWNnQVlnUmpmaWd4V1daMnpa?=
 =?utf-8?B?SUZWNU52WmJ3RTZYNEo3WTFRRHdCRzFkMC9IRXo1TUFTZ1JpZDliTTJiLzYz?=
 =?utf-8?B?TzNsWEpqVGM2OFJ2NFRDaEludHZ3RE16QXhVUWNVZkwrZnFuYTZuRW0zYXFy?=
 =?utf-8?B?YTV3ZTBFR1Z4aitJcHBjZzNXcUp1UUpxaHlmVzNCajhhZU9nY2plZzhDVmJL?=
 =?utf-8?B?YmpxZDdPUXUwWmJzdFVCbjA1ZTNQTkxTbWVDM3NpelUwSkNIU3pKRXJmWlJS?=
 =?utf-8?B?UGh3eVFDNGJ6VDVZSEdDcmk0NFVJckI0NWhOY2d3VTJQV0pNbDFDMHMxSWRr?=
 =?utf-8?B?TWxBTDhDaTQ5eU5MVVhWQTIzNWo2THdGU3dNNERNbm9TN1E4OVh0QndrbHdq?=
 =?utf-8?B?MzRXQ05EUzJBRC9Jc3pUcDY4QnFpRkNxTUlNcVhSbnVvRi9MQkFaMjA1YzJC?=
 =?utf-8?B?eklJVU5LSW1uRUVJT3ROSDRkYy9xQnBhYU05NjVUc1FHQmRTd0p5U3B4b1J0?=
 =?utf-8?B?U3FFSTlSVXB2TjRVbFRMc1dDK2pzSjJEZkMvc28zYXc3akFyRmxjV3cwTTJH?=
 =?utf-8?B?U3RRZncvMVBQTXVKMkxweXVNMWF1SjVOMGxNMi9OZHVuUmVIdHpVMlZaOFhS?=
 =?utf-8?B?ZkVNcmVHRkYyanlGOGdKdFBqWDVwRVhCakx5bC9wMWUxbGVHTU1od1dVNVh5?=
 =?utf-8?B?Mk52S1RzZ3NOWGo5ZXBubGhTVTZaR3hhWFc1T29JNXFBYjJLdk9pUHEwRjlX?=
 =?utf-8?B?SUpjVkhOVUtXL01yUW9PMGNBejEyZldoMUJ5SkdEeHBOYnY4enRSZ2E5N0dr?=
 =?utf-8?B?c3I1K25ibjBYMDJERUJJRUhhSUt2VmlYbndXWVZUMVd2OGNTVE5VL3dRN0Y3?=
 =?utf-8?B?c3FjeU16OExNeTNBVUNZbUtsZSsxa0x2WmJvTTFsUHVDUjlPL0ZGVytKK20x?=
 =?utf-8?B?MG0zY3lwNDlDVUczM0NzVTRXemlaY0hUYithMmxpV1M4TzFZK1d5ZkFLS1VV?=
 =?utf-8?B?bnIrWDZVaXYvNlJYWUN4SlpXVVVsQjZqemNrbXViSi82N3QyMGtIVFlwNHV3?=
 =?utf-8?B?SlZrU0dGWXVqSTRBakdBY01nUTJQaDVSbUV2bmloazkzTDhNams5cEc3M1Zk?=
 =?utf-8?B?ZXpsZ2RlZnJBdjlqUDNkcitJcEl0OXZmU3ZlUUdhTmpBNkljdVhBU2VtUk0r?=
 =?utf-8?B?eUNuak5iNUl0ZTBPVzJvbUkvaUV4L2NTS0FvNnVwSHhtbmpqaTNMMUdJWjhZ?=
 =?utf-8?B?RW10dDhNM0pudnNaUG5UV1V4dHJuY0FBK3FlY0h6cWFIV3VqZkxaU1h1RzF4?=
 =?utf-8?B?enFGVGVJUjZCc0pTSk1QdHRpbmdrVjlyQnpma2FuR08rZ0RYc1JOZU9nVktS?=
 =?utf-8?B?bmVQZUFLRkxVbzlQSFh2eG1TWGFweGM2T2I2NmQzbDdVNTBJejR2eTRrQXE5?=
 =?utf-8?B?YndrQ28yQktQUmdqNHVKNlllKzBqUCtXdXNwdFlHNzIzeG1NcTBkQXJBZEZC?=
 =?utf-8?B?cHd3VFBWTDF5cGhzaGJNNHN0SjEwTGdabjVPS2tJUm5waXNOeWxBZURwNGgy?=
 =?utf-8?B?VDAyTitETm16OWhWZ3BCQlhYQ2N6WCtIK3pxS3ZoTXQyei9VcnA0bzZySDNM?=
 =?utf-8?B?UisxSUpEaGwra0xkUWt2V3I2NHR4Y1B4SG5UQmtpNy9INUZPTUxBRml0bklB?=
 =?utf-8?B?OEdUMFUxUU8xanFubXh4SmNZZlF6bW8wUWZld2JEbGFWbHgreEFlODhJWWsz?=
 =?utf-8?B?cDNNenZsRW16bVR6QmJEMzZZWEZFeWxrZ0p5cnVib0FHcVl2TWljTmoyUXBF?=
 =?utf-8?B?dVdHQ2kxaFo4YXNhNlJPeFhPQThxQTNDZDRtdkFSV0lYQURQRkIrazdxaXZw?=
 =?utf-8?B?S1pxNVJZR0xLL2lxSU4yWktOZlc1WUZVTGRJUnpjaGtrcHA4V2VFNFB4T1Y3?=
 =?utf-8?B?bXNqWUs4TUtlTHlyWHNEc0lia1ZiMWVPbUV6WTRvT2xEWXB0QVloVjJ5b3Nu?=
 =?utf-8?B?czhHODBYY2dWOWlkN0FqdHFBam9FS1ZadWcyS1FocXlWRktzK2M3L1UxRzF2?=
 =?utf-8?B?MFluSTlEakhnUTQyZTBTUi9wTitqeTdEL1RTckkwOWE3Y0VYaEgzYUkzMVpJ?=
 =?utf-8?B?NzFNdUFlSitVQXBWZkNKVVRpaUNiV3ZtOWpUSU1mOVZxRzlCMjI0SEQvazRP?=
 =?utf-8?B?a2tKNFpTV25mNlFXVGt4cVc0K0s0RGI5OXkrMkl6ZTN0aXErMzZJZHhQV2RV?=
 =?utf-8?B?MHZUcGRVQ0YyR29CY0hLTVFzY1ByTTkvaTEwWEJnM2N0aFJBQzd2RDdMNTBq?=
 =?utf-8?Q?TRDwdv7DTrq/6bitKy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad0db45-818e-426c-fc79-08de5fd78ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 08:14:11.8012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+sQz+Gnv7a4bPLqDm11U2UQ7UHUJwqclhMzvjKNA7GNT8Ha310Uj8mPPPcpzVOqKQL9WqOc54NO+FpLW8QfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
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
Cg0KSGksIExpam8NCiAgICAgICAgQ3VycmVudGx5IHRoZSBmZWF0dXJlIGlzIGJlaW5nIGRldmVs
b3BlZCwgdG8gYXZvaWQgYWZmZWN0aW5nIGZ1bmN0aW9ucyBhbHJlYWR5IGluIGRyaXZlciwgd2Ug
c2VwYXJhdGUgaXQgZnJvbSB0aGUgb3RoZXIgY29kZSwgYW5kIGl0IGlzIGRpc2FibGVkIGJ5IGRl
ZmF1bHQsIHdpbGwgcmVwbGFjZSB0aGUgb3JpZ2luYWwgY29kZSB3aGVuIGl0IGlzIHJlYWR5LiBU
aGFuayB5b3UuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlq
byA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBKYW51YXJ5IDMwLCAyMDI2IDE6
NDkgUE0NClRvOiBYaWUsIFBhdHJpY2sgPEdhbmdsaWFuZy5YaWVAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+
OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8
S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMDYvMTRdIGRybS9h
bWQvcmFzOiBBZGQgdGFibGUgcmVzZXQgZnVuYyBmb3IgcG1mdyBlZXByb20NCg0KDQoNCk9uIDMw
LUphbi0yNiA3OjU5IEFNLCBHYW5nbGlhbmcgWGllIHdyb3RlOg0KPiBhZGQgdGFibGUgcmVzZXQg
ZnVuYyBmb3IgcG1mdyBlZXByb20sIGFkZCBzbXUgZWVwcm9tIGNvbnRyb2wgc3RydWN0dXJlDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IEdhbmdsaWFuZyBYaWUgPGdhbmdseGllQGFtZC5jb20+DQo+IC0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzLmggICAgICAgICB8ICAx
ICsNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc19jbWQuYyAgICAgfCAg
OSArKysrLS0NCj4gICAuLi4vZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzX2VlcHJvbV9mdy5j
ICAgfCAyOSArKysrKysrKysrKysrKysrKysrDQo+ICAgLi4uL2dwdS9kcm0vYW1kL3Jhcy9yYXNj
b3JlL3Jhc19lZXByb21fZncuaCAgIHwgMjYgKysrKysrKysrKysrKysrKysNCj4gICA0IGZpbGVz
IGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhcy5oDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXMuaA0KPiBpbmRleCA2ZTIyM2VmZjUyMmMuLmFlMTBk
ODUzYzU2NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9y
YXMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhcy5oDQo+IEBA
IC0zMTMsNiArMzEzLDcgQEAgc3RydWN0IHJhc19jb3JlX2NvbnRleHQgew0KPg0KPiAgICAgICBi
b29sIHJhc19lZXByb21fc3VwcG9ydGVkOw0KPiAgICAgICBzdHJ1Y3QgcmFzX2VlcHJvbV9jb250
cm9sIHJhc19lZXByb207DQo+ICsgICAgIHN0cnVjdCByYXNfZndfZWVwcm9tX2NvbnRyb2wgcmFz
X2Z3X2VlcHJvbTsNCj4NCj4gICAgICAgc3RydWN0IHJhc19wc3AgcmFzX3BzcDsNCj4gICAgICAg
c3RydWN0IHJhc191bWMgcmFzX3VtYzsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcmFzL3Jhc2NvcmUvcmFzX2NtZC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFz
Y29yZS9yYXNfY21kLmMNCj4gaW5kZXggOTRlNmQ3NDIwZDk0Li40Zjg5ODEwZDg1YTEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzX2NtZC5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzX2NtZC5jDQo+IEBAIC0xNDYs
OCArMTQ2LDEzIEBAIHN0YXRpYyBpbnQgcmFzX2NtZF9jbGVhcl9iYWRfcGFnZV9pbmZvKHN0cnVj
dCByYXNfY29yZV9jb250ZXh0ICpyYXNfY29yZSwNCj4gICAgICAgaWYgKGNtZC0+aW5wdXRfc2l6
ZSAhPSBzaXplb2Yoc3RydWN0IHJhc19jbWRfZGV2X2hhbmRsZSkpDQo+ICAgICAgICAgICAgICAg
cmV0dXJuIFJBU19DTURfX0VSUk9SX0lOVkFMSURfSU5QVVRfU0laRTsNCj4NCj4gLSAgICAgaWYg
KHJhc19lZXByb21fcmVzZXRfdGFibGUocmFzX2NvcmUpKQ0KPiAtICAgICAgICAgICAgIHJldHVy
biBSQVNfQ01EX19FUlJPUl9HRU5FUklDOw0KPiArICAgICBpZiAocmFzX2Z3X2VlcHJvbV9zdXBw
b3J0ZWQocmFzX2NvcmUpKSB7DQo+ICsgICAgICAgICAgICAgaWYgKHJhc19md19lZXByb21fcmVz
ZXRfdGFibGUocmFzX2NvcmUpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFJBU19D
TURfX0VSUk9SX0dFTkVSSUM7DQo+ICsgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgaWYg
KHJhc19lZXByb21fcmVzZXRfdGFibGUocmFzX2NvcmUpKQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIFJBU19DTURfX0VSUk9SX0dFTkVSSUM7DQo+ICsgICAgIH0NCj4NCj4gICAgICAg
aWYgKHJhc191bWNfY2xlYW5fYmFkcGFnZV9kYXRhKHJhc19jb3JlKSkNCj4gICAgICAgICAgICAg
ICByZXR1cm4gUkFTX0NNRF9fRVJST1JfR0VORVJJQzsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcmFzL3Jhc2NvcmUvcmFzX2VlcHJvbV9mdy5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfZWVwcm9tX2Z3LmMNCj4gaW5kZXggZjg4MGZjNDk0Nzdk
Li5hZTYzZTczOTQ4MjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jh
c2NvcmUvcmFzX2VlcHJvbV9mdy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcmFzL3Jh
c2NvcmUvcmFzX2VlcHJvbV9mdy5jDQo+IEBAIC0xNjEsMyArMTYxLDMyIEBAIGludCByYXNfZndf
ZXJhc2VfcmFzX3RhYmxlKHN0cnVjdCByYXNfY29yZV9jb250ZXh0ICpyYXNfY29yZSwNCj4gICAg
ICAgcmV0dXJuIHN5c19mdW5jLT5tcDFfc2VuZF9lZXByb21fbXNnKHJhc19jb3JlLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgUkFTX1NNVV9FcmFzZVJhc1RhYmxlLCAwLCByZXN1bHQpOw0KPiAg
IH0NCj4gKw0KPiAraW50IHJhc19md19lZXByb21fcmVzZXRfdGFibGUoc3RydWN0IHJhc19jb3Jl
X2NvbnRleHQgKnJhc19jb3JlKSB7DQo+ICsgICAgIHN0cnVjdCByYXNfZndfZWVwcm9tX2NvbnRy
b2wgKmNvbnRyb2wgPSAmcmFzX2NvcmUtPnJhc19md19lZXByb207DQo+ICsgICAgIHUzMiBlcmFz
ZV9yZXMgPSAwOw0KPiArICAgICBpbnQgcmVzOw0KPiArDQo+ICsgICAgIG11dGV4X2xvY2soJmNv
bnRyb2wtPnJhc190YmxfbXV0ZXgpOw0KPiArDQo+ICsgICAgIHJlcyA9IHJhc19md19lcmFzZV9y
YXNfdGFibGUocmFzX2NvcmUsICZlcmFzZV9yZXMpOw0KDQpFeGNlcHQgdGhpcyBjYWxsLCBldmVy
eXRoaW5nIGVsc2UgbG9va3MgbGlrZSBhIGNvbW1vbiBsb2dpYy4gRm9yIGV4Og0KbnVtX3JlY3Ms
IGJpdG1hcCBldGMuIGxvb2tzIGxpa2UgY29tbW9uIGZvciBlZXByb20gYXMgYSB3aG9sZSBhbmQg
bm90IHNwZWNpZmljIHRvIGZ3IGVlcHJvbS4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+ICsgICAgIGlm
IChyZXMgfHwgZXJhc2VfcmVzKSB7DQo+ICsgICAgICAgICAgICAgUkFTX0RFVl9XQVJOKHJhc19j
b3JlLT5kZXYsICJSQVMgRUVQUk9NIHJlc2V0IGZhaWxlZCwgcmVzOiVkIHJlc3VsdDolZCIsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXMsIGVyYXNlX3Jlcyk7DQo+ICsgICAgICAgICAgICAgaWYgKCFyZXMp
DQo+ICsgICAgICAgICAgICAgICAgICAgICByZXMgPSAtRUlPOw0KPiArICAgICB9DQo+ICsNCj4g
KyAgICAgY29udHJvbC0+cmFzX251bV9yZWNzID0gMDsNCj4gKyAgICAgY29udHJvbC0+YmFkX2No
YW5uZWxfYml0bWFwID0gMDsNCj4gKyAgICAgcmFzX2NvcmVfZXZlbnRfbm90aWZ5KHJhc19jb3Jl
LCBSQVNfRVZFTlRfSURfX1VQREFURV9CQURfUEFHRV9OVU0sDQo+ICsgICAgICAgICAgICAgJmNv
bnRyb2wtPnJhc19udW1fcmVjcyk7DQo+ICsgICAgIHJhc19jb3JlX2V2ZW50X25vdGlmeShyYXNf
Y29yZSwgUkFTX0VWRU5UX0lEX19VUERBVEVfQkFEX0NIQU5ORUxfQklUTUFQLA0KPiArICAgICAg
ICAgICAgICZjb250cm9sLT5iYWRfY2hhbm5lbF9iaXRtYXApOw0KPiArICAgICBjb250cm9sLT51
cGRhdGVfY2hhbm5lbF9mbGFnID0gZmFsc2U7DQo+ICsNCj4gKyAgICAgbXV0ZXhfdW5sb2NrKCZj
b250cm9sLT5yYXNfdGJsX211dGV4KTsNCj4gKw0KPiArICAgICByZXR1cm4gcmVzOw0KPiArfQ0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfZWVwcm9t
X2Z3LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Jhcy9yYXNjb3JlL3Jhc19lZXByb21fZncu
aA0KPiBpbmRleCA0NmY0NWU4MmEzZjMuLmExMDAzZGIzYzMzYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfZWVwcm9tX2Z3LmgNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9yYXMvcmFzY29yZS9yYXNfZWVwcm9tX2Z3LmgNCj4gQEAgLTI0LDYg
KzI0LDMxIEBADQo+ICAgI2lmbmRlZiBfX1JBU19FRVBST01fRldfSF9fDQo+ICAgI2RlZmluZSBf
X1JBU19FRVBST01fRldfSF9fDQo+DQo+ICtzdHJ1Y3QgcmFzX2Z3X2VlcHJvbV9jb250cm9sIHsN
Cj4gKyAgICAgdWludDMyX3QgdmVyc2lvbjsNCj4gKyAgICAgLyogcmVjb3JkIHRocmVzaG9sZCAq
Lw0KPiArICAgICBpbnQgcmVjb3JkX3RocmVzaG9sZF9jb25maWc7DQo+ICsgICAgIHVpbnQzMl90
IHJlY29yZF90aHJlc2hvbGRfY291bnQ7DQo+ICsgICAgIGJvb2wgdXBkYXRlX2NoYW5uZWxfZmxh
ZzsNCj4gKw0KPiArICAgICAvKiBOdW1iZXIgb2YgcmVjb3JkcyBpbiB0aGUgdGFibGUuDQo+ICsg
ICAgICAqLw0KPiArICAgICB1MzIgcmFzX251bV9yZWNzOw0KPiArDQo+ICsgICAgIC8qIE1heGlt
dW0gcG9zc2libGUgbnVtYmVyIG9mIHJlY29yZHMNCj4gKyAgICAgICogd2UgY291bGQgc3RvcmUs
IGkuZS4gdGhlIG1heGltdW0gY2FwYWNpdHkNCj4gKyAgICAgICogb2YgdGhlIHRhYmxlLg0KPiAr
ICAgICAgKi8NCj4gKyAgICAgdTMyIHJhc19tYXhfcmVjb3JkX2NvdW50Ow0KPiArDQo+ICsgICAg
IC8qIFByb3RlY3QgdGFibGUgYWNjZXNzIHZpYSB0aGlzIG11dGV4Lg0KPiArICAgICAgKi8NCj4g
KyAgICAgc3RydWN0IG11dGV4IHJhc190YmxfbXV0ZXg7DQo+ICsNCj4gKyAgICAgLyogUmVjb3Jk
IGNoYW5uZWwgaW5mbyB3aGljaCBvY2N1cnJlZCBiYWQgcGFnZXMNCj4gKyAgICAgICovDQo+ICsg
ICAgIHUzMiBiYWRfY2hhbm5lbF9iaXRtYXA7DQo+ICt9Ow0KPg0KPiAgIHZvaWQgcmFzX2Z3X2lu
aXRfZmVhdHVyZV9mbGFncyhzdHJ1Y3QgcmFzX2NvcmVfY29udGV4dCAqcmFzX2NvcmUpOw0KPiAg
IGJvb2wgcmFzX2Z3X2VlcHJvbV9zdXBwb3J0ZWQoc3RydWN0IHJhc19jb3JlX2NvbnRleHQgKnJh
c19jb3JlKTsgQEANCj4gLTQxLDUgKzY2LDYgQEAgaW50IHJhc19md19nZXRfYmFkcGFnZV9pcGlk
KHN0cnVjdCByYXNfY29yZV9jb250ZXh0ICpyYXNfY29yZSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQxNl90IGluZGV4LCB1aW50NjRfdCAqaXBpZCk7DQo+ICAgaW50
IHJhc19md19lcmFzZV9yYXNfdGFibGUoc3RydWN0IHJhc19jb3JlX2NvbnRleHQgKnJhc19jb3Jl
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqcmVzdWx0KTsN
Cj4gK2ludCByYXNfZndfZWVwcm9tX3Jlc2V0X3RhYmxlKHN0cnVjdCByYXNfY29yZV9jb250ZXh0
ICpyYXNfY29yZSk7DQo+DQo+ICAgI2VuZGlmDQoNCg==
