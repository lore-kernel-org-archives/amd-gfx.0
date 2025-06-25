Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3859CC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 02:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFCD10E04E;
	Wed, 25 Jun 2025 02:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aUgXC7zJ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AD210E04E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 02:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRt6T089got8LLZaI5zNNjklf++X/bAeWSJJwVmNFieObZwAnGpIF2M7g2rvu2OBTgpLbj69f6W+s2wg//dgLWz4B+4895uv0U5TAXWDZZc7khaPy5Qs+PDd+883xH1SaLZx17MsvmsTi1B1wpu/MJyCIpVnGTTCfIyDQrnT0jnDK/SXZIgM7Mkp1Ji604vTIJTnwg6yOs0UfDAa2FMzzeY9DZ9/mH5DAzMCgMiperwGmYHrmo7s5I/t5TVWKt4exD+j2TxoftRZ5JTSPrh9yUrEtBPiEiWkSkk1+R+4K8ibhml0eMN3iRrUbUlhdtgXJvXr1Amsl7GRWsIUOEoYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4e9Ul4eUAohCjuzF3KEPAueA54vB+jjw9DE0fCeqZU=;
 b=oXX8AGE2FyoxyPJIcaoJZ+lJQxmmMQCqzg6WS5dtnKQbtRZRb2AQKEdhmPzeHRQZKl+M7RQb8zLiEmI3oux+NW9o+rQ81YIvkrsUari1apCPVP3WafU7H8fyGOzdaWZIZCTnKjPkCcswzI9f6t/t/AZAZp5c7KTrY9Th4DK9EfE3/rFBKknXtbq9T6F/gtMXJzCIeTBh7QXAEYDBk2ZYQIu/wjhAILnC/xNIrr4HsDES/qT0NxqzpsprqY1cusXCpSfR/nixsJkUQNtFFA/VUlGw10xvUgT2u/4SUkTenade2Q/KNG1ZZeycNFpjuWIkITNDlPa+cYWvK3NO5h/D9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4e9Ul4eUAohCjuzF3KEPAueA54vB+jjw9DE0fCeqZU=;
 b=aUgXC7zJgY/1v4chg05GF4kCCrgqTRIRtbbmFblHOeGfBgLEO1QOY2/l0m7r/bAVnSEdSKDpASa1ap61+cByfEOVG4A/kfgYD9l5CPqxBj/1xjsiWv5HUctGL2ScwixUozoYIYdXAeATtXjD05K6XbD77y0EVhFB2FTYWTT8RO4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ5PPFE4FC9FAB3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 02:02:46 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8857.022; Wed, 25 Jun 2025
 02:02:46 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to
 userq bo
Thread-Topic: [PATCH v4 10/11] drm/amdgpu: only bound the eviction fence to
 userq bo
Thread-Index: AQHb5ORrfgBI0MLUM0OQwir1QlR+H7QSisOAgACVoKA=
Date: Wed, 25 Jun 2025 02:02:46 +0000
Message-ID: <DS7PR12MB6005424626E1F69B8739514BFB7BA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-10-Prike.Liang@amd.com>
 <CADnq5_ME8GNEjZdkfjGAEL69=PqOtLVui1jqao3JmwK1XMnHFQ@mail.gmail.com>
In-Reply-To: <CADnq5_ME8GNEjZdkfjGAEL69=PqOtLVui1jqao3JmwK1XMnHFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-25T02:01:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ5PPFE4FC9FAB3:EE_
x-ms-office365-filtering-correlation-id: b27e0b44-ce0e-4b67-4ade-08ddb38c615b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkNBSWpiQ0N2ZjhldTNvUEE4b3MzL2N6QWtaS1duMzhzUVdxM1FmS0JzODdr?=
 =?utf-8?B?L0lYaUN3SnRzM0VJWC8zVnNXd3dHdEEyYXlKOUw5RzRDb3hFSVd3OCtwMnEr?=
 =?utf-8?B?YkNOV01mL05NQk15ak8vWkNGUTdadld5WjNsSk00VnhYb09hUzc0dk5Db1lo?=
 =?utf-8?B?MmFiNDFIRjFxaUZ5OW9aMnJhTmRyRUZoSkxtMkE0Y0FVTVhFdEs4ZWJKeXlW?=
 =?utf-8?B?eHZmdXNhdnd1dG1TdjgyMjVyb001d2c5N2h5T1g3NlUyb0k5WGgrQllDd29I?=
 =?utf-8?B?RmFHTlk3SHo5ekJOTnovN1dyc2ZpZUJrNUI2NWEzRHhYNWFreitRb0hMU202?=
 =?utf-8?B?ck5ydU83U05TK3BWcUwyYlFtT1BXbDRJOEFsMnVyd1F3WnpJNVlXWlprd0dw?=
 =?utf-8?B?VmZVbStLaWJZV0xrU2djZXhCb1dueW1CVldGU1hnYkluL1liVUttQk5kU0V3?=
 =?utf-8?B?SEhwWW03elFvQ0kwbmM2WkY5K3AwV3Y3eFRyZXpKM3NtMjZDV0o1TTlrbWlr?=
 =?utf-8?B?Zi9RVEl3NWwrTDFhcGZISnRQQ1hoY0tXckhZcTNGZmhiSUpIN3lUdUUxcUt2?=
 =?utf-8?B?OWQ5UHFMMkd3Y1BsZHZLSlFDd0YyZ08zbllPQzZ1aXN0VWFFakZwaURrOXN0?=
 =?utf-8?B?T3ZocUgxWS9kS3ZDU1hSd1hWTFEwL2tkajd6WVJPWnppaGlGaEIyT0tpVk1a?=
 =?utf-8?B?Vit1NmwzNmhWemlNRWlZaWl5UTVxZVEzWXdEMmtRZ2VOb2IxRnV6SkxFdFJo?=
 =?utf-8?B?Q3VXR2NWWHVYK0kxRnBVRWtRWnRYRFRTNHlxQzdjajk1VGNtYk9PMkNOSjB0?=
 =?utf-8?B?OU1ZWHUzQ2hOdjk3MGErT1NveDd0UEh6U25zQU1oME1ZeVhrUDY0akZhUkVL?=
 =?utf-8?B?Zko0dWpScjhNbEhvckVISkg0TUd4bml5UVhHUGdLZjc5OTBiRHZwQTE0S2dW?=
 =?utf-8?B?R1hLcDFTYXNUSkRrakxXZDg0ejcvSkNCaU15eDYzSWdtbEg3TEY1a2VYTU1q?=
 =?utf-8?B?YjNjTmhXTUQybm5YVWdYaG9lUVByRHQ1bGlJUHB3ZXhvdWVpT1cxTDNXRnZp?=
 =?utf-8?B?TzFQWmdUOHI5eS94d0FTSzVhc1IxWi9ITGhaYzJFMHRVdmNPZktzdzZZcnc0?=
 =?utf-8?B?dVpWU21nZDc5LzVBb2dXbzIyem9lYTlPR1dUUUwrc3JrZVBCejVxU3FZSEdM?=
 =?utf-8?B?NjdCOVBxVWVYNHNiS0dJMG5jdmhORjFFOVBMYXBpVEIwSllUSU1BUTk0VTdq?=
 =?utf-8?B?aDVqcTFCRnhsSWJhSklKdC85RWYzTmlVS3VaV29IeGhVaEdtMDVZaGN5aDZx?=
 =?utf-8?B?Vlg2ZDdGbEZCajFtUE9nRHBWb0JJNmdwY2E0SGh0Y0QxSGNmcEM5OVJiRDkx?=
 =?utf-8?B?M3pOTGdNclkveHVxQ3dMMHl4NjNENHpjNC94Tkt6TXl3UlVpYThFM1Fyby96?=
 =?utf-8?B?alNHUDExM2dGOEN5d2NRNzhwblRuVDg5a3M1ZGFhV0FIcm9ZWEZ1UmkrYUcz?=
 =?utf-8?B?dk4xRmo4Q21KbWdHZFB1cmxPVXR5S2VURitoTEMrNVZSSlIvQk1jUzlzTGVV?=
 =?utf-8?B?U1JoL0swc1FiN21qR0FvQmFxTUxOSGxBd3FqNVBzRFpTc3VlMXlqNlFRdmNW?=
 =?utf-8?B?V0o4U0RoR3pWMlpsQUVNazBISy85cDd3bXEwbkpDeEpmR0hBSm9XdCtKRXZV?=
 =?utf-8?B?ZnpTS1A1T1EwQU1JNzlKdTNpS0g3eCtRNDU2M3dFVGs1ZncxOEVqaTFHaWNN?=
 =?utf-8?B?aHFHdEVGS3VIVmR2ZFowMUhMUkVIQzNaTjVzdnlTZEZpWUtydUI3OVdCYzlv?=
 =?utf-8?B?cG84VmNKV1VrT2RocXBwKzk3T08wc3kxZXNYdVFkbzhCYm9RM041VWtqRDY0?=
 =?utf-8?B?MzZqajNoL2ZqZ2pPZXlTTWFkTXIzaU1WUWNmZ3E1YlAwRlJTWjRQZlA1R2dR?=
 =?utf-8?B?cjJhSUZLZE5Jc2lPUURibVlFdUY0eCtURFZWVG4zby9yeGpobTBBbE4zNnd4?=
 =?utf-8?Q?DvUCW18jK+gQHb+WmK6/ACEIbC7nkI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVhIdVRpNGNxNTJoRzZHOGhHWU81WUdqcUtWbWRGSzB2QnI1ZDNIK3FHTkRP?=
 =?utf-8?B?YVFWaE11K21veFBIekNabUhoeHBERWpBTDhyWXFjSHBxKzdYbEhhUTRlTDhY?=
 =?utf-8?B?VGZiVmFhbUErUkF1a0hVS0Q5b2VybGNTYjNWV2RZZFczYnZUbFl4dWVQdVdr?=
 =?utf-8?B?Y0J2ZnBIbHlrcjJuSlFlYjdJWnpFZnZ2YlNna2pXV1VMNWRadXU0MW5RSVl5?=
 =?utf-8?B?NUd2aFR0Y0V4UWZBN20za3JEVXd4OXVSZFJ3TGorQ2hWbjIrN0w2V0lDU3pY?=
 =?utf-8?B?MW8xb05oUWp5TGVtMzZKNURXd25QRkI4OU5yNzFoa2ZneVluSW10Y3F5ZFVG?=
 =?utf-8?B?ZTN0Ym83dlV0WVdWNGFaTzUzeGUwZnN1eTVQMWdvcWdRVVJNS2FGODIxR1ZF?=
 =?utf-8?B?MndnYk5zR2pQTmxST3BZbDIxdUU1citxL25oOXdFQ1psdHhSUm1wLzk3Z1c3?=
 =?utf-8?B?c3hwTzJwNmVxRmd4bG5PK3dsNHlWTUwvd3VOb0NGRWpNVnhGZ29OY2xSVTVS?=
 =?utf-8?B?alRrc0h1cmE0YmZwK21WMnV4Tm1keHM1SlhpOXFCNnlHVld1S3BiSjJnd0Vv?=
 =?utf-8?B?V2hBbmVlcEM1Qk1oeEpEUHdBaVdPUXNFVWpEM0x0Wk9XSnR6VkVDOFdEaDc1?=
 =?utf-8?B?SjVLNm13aysxWnFkQWI3cU1LM1c5RGRBTUdkMDljaGJvKzdzZ1dmQk44WHZn?=
 =?utf-8?B?c0xXVkg5cU5PTGQwWDI5ZUk2SVViTGpISVBaUFNZR0VtcmlGNlRTbXJ0L0FR?=
 =?utf-8?B?ejVUeGJnWDRIcjZiMk5SbDNqcmNRc2RINVRUR29Ua0NOeFV1dExQZUJLdDF0?=
 =?utf-8?B?dWQ1TEMvd2VmTlJtT252UWl4WklYU3FqZ0xCd21uN2l6VCs3VnBCa010MUhi?=
 =?utf-8?B?Zms0Zmh5c2RGQ2xwZWUxakdTVTUwdm8rbmhhdk1uOEhVY1ZMRm5KMFRmbjhq?=
 =?utf-8?B?dFFwcSsvTkZ1MmZXWmF1QUxKWWpXWDdRbkhvcVduK3V1Z2o4TnhoT0hSUUFD?=
 =?utf-8?B?RVpyQi9tMkpuS1JjZU8yWTA0OGhuQU9FWGZhWm8xTllUUDdWajBkcUJFQkY1?=
 =?utf-8?B?Mkx0TllPeEJtWW51VjhGaVIrRXl1NUQrYm05UC9vUWhDWjFwbmZBQVRYYVBz?=
 =?utf-8?B?Z2NNREk1bkhDdXpheEFFcXR2RE12eG9Xd0RNMUpsTkprQ2J6a3orYmhRaDJE?=
 =?utf-8?B?aTI0T3BYSWJ2cm01YW83WjJpNk1Jem1rNFNzeGNDMW8vQ2QxRWY1K2s0Z0lB?=
 =?utf-8?B?Njd2cEY4dmZjZU16cnNXZEJjZlBocGExMmN0VlZ2elhzQzZUVEJKUTBkZUVZ?=
 =?utf-8?B?dDI1UXlLK3RzdHdvSWtnTkQvd0pLdlpZcXhsOFJVUkRQb1htZmVha3YvUTdq?=
 =?utf-8?B?YjQ1UVZwVnRBOEJTeitBK1QrYzRtVG1Gb1hYUzV0aVhpUWNYZ3o0WjZDcDlZ?=
 =?utf-8?B?bUJtR0ttNG1Xc2tqQXpTSy9HaFF5YU1NUjFidW1oY2ZsL2dra1BNR1VmR3VV?=
 =?utf-8?B?Qi8zOWtjZUExbnB3ai81a0dlZ0xwdHcrS0NickZCM2g1L1ArUnYxdVFEQUMr?=
 =?utf-8?B?cndKbFJiWmJ5V0JuVDE0VlArcmcrUWcrREpXMkFjdHNxZmRTUC81NlV0Rjdy?=
 =?utf-8?B?Z0ZnZ2pQTDRyWDdVVis3WXJvRmtNK2J6cXYwNGJXUDBRYy80dVc2RTJZaGxI?=
 =?utf-8?B?Ryt6WVhPUGpIOGRzN3d1bmtzSFRTY1UxdGRtOElGcnRPMCtScGE0REdURHNp?=
 =?utf-8?B?MjVwWGkxa1d0bUtvVytBQmgrSm5CeW1Rb1oyZDNSOUFEdnhPbExBUDgybERk?=
 =?utf-8?B?dUNWbXBNZlA0OUJ5RG5sU3V1UFg1SjVRRE16UXRZa3lVQzRoUTZhaVpwRmht?=
 =?utf-8?B?WUFqRnVOWkRCeEdjdmtnMGFYYUFPNU1CZ1FLS081MlZqOW45QjVJZmZaQmdm?=
 =?utf-8?B?VXg3RGROSFRBa2huS3dPYnh5MFNRODM4WmFUdkNrZ2s5NlE5K0U4OFcrY3J4?=
 =?utf-8?B?amVsZ3F1QnlKNHFjVEs2U2s1YkhYN2MyMVZKQm1YTjNVWUlLdy9Fcytqcjl6?=
 =?utf-8?B?ZHlRN2VQejAwSDVxVlgvTXZsUlF4djVIeFEzZHZ0eGlQOGV4RUtmMElla3ZH?=
 =?utf-8?Q?3iLo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27e0b44-ce0e-4b67-4ade-08ddb38c615b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 02:02:46.6587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nh/7WS8WTnwReRRLYkj1wUikrTjfNpl7j3hz8eF3LgfZmoFu3Txp2RsDOKajcnR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE4FC9FAB3
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

W1B1YmxpY10NCg0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4N
Cj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI1LCAyMDI1IDE6MDYgQU0NCj4gVG86IExpYW5nLCBQ
cmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY0IDEwLzExXSBkcm0vYW1kZ3B1OiBvbmx5IGJvdW5kIHRoZSBldmljdGlv
biBmZW5jZSB0byB1c2VycQ0KPiBibw0KPg0KPiBPbiBUdWUsIEp1biAyNCwgMjAyNSBhdCA0OjQ2
4oCvQU0gUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
SXQgZG9lc24ndCBuZWVkIHRvIGF0dGFjaCB0aGUgaW52YWxpZCBldmljdGlvbiBmZW5jZSB0byBu
b24tdXNlcnEncw0KPiA+IEJPcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5n
IDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2VtLmMgfCAxNiArKysrKysrKystLS0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gPiBpbmRleCAyYzY4MTE4ZmU5
ZmQuLjUwMzU2YWEyM2E5OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ2VtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2VtLmMNCj4gPiBAQCAtMjk0LDEyICsyOTQsMTQgQEAgc3RhdGljIGludCBhbWRncHVf
Z2VtX29iamVjdF9vcGVuKHN0cnVjdA0KPiBkcm1fZ2VtX29iamVjdCAqb2JqLA0KPiA+ICAgICAg
ICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICArK2JvX3ZhLT5yZWZfY291bnQ7DQo+ID4NCj4g
PiAtICAgICAgIC8qIGF0dGFjaCBnZnggZXZpY3Rpb24gZmVuY2UgKi8NCj4gPiAtICAgICAgIHIg
PSBhbWRncHVfZXZpY3Rpb25fZmVuY2VfYXR0YWNoKCZmcHJpdi0+ZXZmX21nciwgYWJvKTsNCj4g
PiAtICAgICAgIGlmIChyKSB7DQo+ID4gLSAgICAgICAgICAgICAgIERSTV9ERUJVR19EUklWRVIo
IkZhaWxlZCB0byBhdHRhY2ggZXZpY3Rpb24gZmVuY2UgdG8gQk9cbiIpOw0KPiA+IC0gICAgICAg
ICAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKGFibyk7DQo+ID4gLSAgICAgICAgICAgICAgIHJl
dHVybiByOw0KPiA+ICsgICAgICAgLyogYXR0YWNoIGdmeCBldmljdGlvbiBmZW5jZSB3aGVuIHVz
ZXJxIGNyZWF0ZWQqLw0KPiA+ICsgICAgICAgaWYgKHZtLT5pc191c2VycV9jb250ZXh0KSB7DQo+
ID4gKyAgICAgICAgICAgICAgIHIgPSBhbWRncHVfZXZpY3Rpb25fZmVuY2VfYXR0YWNoKCZmcHJp
di0+ZXZmX21nciwgYWJvKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHIpIHsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUdfRFJJVkVSKCJGYWlsZWQgdG8gYXR0YWNoIGV2
aWN0aW9uIGZlbmNlIHRvIEJPXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBhbWRn
cHVfYm9fdW5yZXNlcnZlKGFibyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IHI7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAg
ICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShhYm8pOw0KPiA+IEBAIC0zNjUsNyArMzY3LDcgQEAgc3Rh
dGljIHZvaWQgYW1kZ3B1X2dlbV9vYmplY3RfY2xvc2Uoc3RydWN0DQo+IGRybV9nZW1fb2JqZWN0
ICpvYmosDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfdW5sb2NrOw0KPiA+
ICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICBpZiAoIWFtZGdwdV92bV9pc19ib19hbHdheXNf
dmFsaWQodm0sIGJvKSkNCj4gPiArICAgICAgIGlmICghYW1kZ3B1X3ZtX2lzX2JvX2Fsd2F5c192
YWxpZCh2bSwgYm8pICYmDQo+ID4gKyB2bS0+aXNfY29tcHV0ZV9jb250ZXh0KQ0KPg0KPiBEaWQg
eW91IG1lYW4gdm0tPmlzX3VzZXJxX2NvbnRleHQgaGVyZT8NClllcywgaXQncyBhIHR5cG8gYW5k
IHdpbGwgY29ycmVjdCBpdCBpbiB0aGUgbGF0ZXIgcGF0Y2guDQo+DQo+IEFsZXgNCj4NCj4gPiAg
ICAgICAgICAgICAgICAgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2RldGFjaCgmZnByaXYtPmV2Zl9t
Z3IsIGJvKTsNCj4gPg0KPiA+ICAgICAgICAgYm9fdmEgPSBhbWRncHVfdm1fYm9fZmluZCh2bSwg
Ym8pOw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
