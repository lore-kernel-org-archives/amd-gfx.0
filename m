Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD561C25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 08:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A16D10E23F;
	Thu,  6 Jun 2024 08:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K5tQPGCI";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E246F10E23F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 08:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnF1i5D4TFkLb8HybEkxpbbF6c4Lq3+oTIhQlpxl/Bwsq9SoE8dU8SKnu82CdbJdR5Ys+daIAYfIvpi41nDqsNvF2xY2otbLpBT8A09nz4z51MfyPSaqdqHt0Ewj3rlvXZ3a27Ur8iQxWSP4Dwpnnb1MzCqH4uaiA9DJZHTORHeOLzBGzQ/Yx+Zgm/xRlRHAzlc+n6ObqW+QcU1Bq/I31fOU/uoInIwXfspdEO139sazJO3KU2NeIXwo1KENULJ/JAhw16EhcakQXfqSxwfO8X0GmqjKzYrUqjd3+9GN1dBMl2QjnfN77J9epLeHahpwr4FmM9AfnqeibIf+QGeOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrepoMhIaAk2xKMZyjqEh0RCpGAylm8UgaE3UJVhOk4=;
 b=mdqy0aFU1hD908aeLVp4jWDMk24bqfWqyUaXUy/lWpVm+RwrCH1spPiic4ZfldJwW/xfxiiB130SHdNsO7GrUSfxuQ5lDxwn+QHEA2Gc8YWEjXUXkMQGQ4Kg60lBAYHBwQ95ygOw19IThrYSdAZnWoOSbDSUx0PNeSrL+t8itwKIDG12a1vwzkhSKIgX1eypopEOEPsnaHRUw9f+sAEAS2cmN4NOiGNW5fxPcgobDS8dywDEbjC+2v0Elbu8EqmFYlEjZkae3bxywQCRzM/7Jf8JJaSz1PDodBeLLVnb+PmBeSSRtBYa7vQVNQ0UW0QRVFXjpieWaZ95Jbqkc9XH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrepoMhIaAk2xKMZyjqEh0RCpGAylm8UgaE3UJVhOk4=;
 b=K5tQPGCI4hRBZhA6wEsPXDWr8ECq30c3dui1XJE5Zy+GrMynDdvdTHS9H+X3jO9x4NuB1VcWR4yPXhmQXlwKnQgGkQN1eSa7AoDcKBHpyIMGW68JI32bXXud5FCZbZ7qGLWmWJX7+worPzogQSGdFyivqOM+Lz1/f8iVL52YAVU=
Received: from SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 08:10:54 +0000
Received: from SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166]) by SA1PR12MB5659.namprd12.prod.outlook.com
 ([fe80::e783:dfa3:88e4:d166%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 08:10:54 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: tolerate allocating GTT bo with dcc flag
Thread-Topic: [PATCH] drm/amdgpu: tolerate allocating GTT bo with dcc flag
Thread-Index: AQHat+LWp1GlEx4xbkeTo7v7gt0MibG6YiZg
Date: Thu, 6 Jun 2024 08:10:54 +0000
Message-ID: <SA1PR12MB5659CC018E8890569BA55923E9FA2@SA1PR12MB5659.namprd12.prod.outlook.com>
References: <20240606072419.208126-1-Frank.Min@amd.com>
In-Reply-To: <20240606072419.208126-1-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f5443746-f819-43bc-9f83-f6cf56878486;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-06T08:10:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB5659:EE_|PH7PR12MB9065:EE_
x-ms-office365-filtering-correlation-id: f1053e13-30df-4680-7c54-08dc86003048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?R1dDTWVZQmVMRk1aMTRyQmVxNEFCZG5NcTkzeTJWa2V4VEZ6eDJwek1rVmFB?=
 =?utf-8?B?OVRNdWQyYWFLcHBCYjBIV0toZ01pTFh2MVJ3RkVTTWJmeklJUHU2aFdZaGF5?=
 =?utf-8?B?ZjBWd0RucEdxOTd2VEJJL3ZBK1hEcCtybkdXd244MUJEb2M2cnNGdzRGWGRv?=
 =?utf-8?B?MzdGeWRwUzFpVnYrMiswb0tJaGJubk1BMTRiRjdwOFk4WHhxSnhocXhndTJI?=
 =?utf-8?B?T2NMK0xPakRQQ3BSa0ZJc29ubEJLUXQ3TnBpY0NGQTZZWGxCcm1md2dPWlVx?=
 =?utf-8?B?aCs1QVplaldJSEc1MTViWmQ2SSs0NXlKVHUvbjJPR3BiczJ1ZW5NcHhNcXFP?=
 =?utf-8?B?cmlRempvRGtPN01JbG5XTjZ3WVU0bG5aeWlWc1AvY0ZPTHVCZE1lQzA2bkdE?=
 =?utf-8?B?clZaa01Fam1kZGgwWTU1ZWwzVXVpUnZ3cmFZdFNIc1RaTlRVU0pNZWt6SlU3?=
 =?utf-8?B?bHdaQ2RIZmZIakp6ZEdpUmU2RHp6UlhnOGN0eGN1K2tIejJnWnI0WGROQVp4?=
 =?utf-8?B?NGlvcFBUdy9FSmRDM3NIcHBIQ3p3clZpaTVySjl5OHpoWVVBSDhQZXNiNFlY?=
 =?utf-8?B?ejhsOHQycURhNml4d3gwTVY3Mk9RRjZJbm5OOFlsTDdSdEpiS2hUTk0xbGNC?=
 =?utf-8?B?MXRIK21wUFYwZXAxNjVubEFxVVBKTUphTG9WNktMYUovcmNhdkF1c1hFNncy?=
 =?utf-8?B?d1BOdHd3SW9oaHIvNk0zM21LNTRyZGdvQ1ZIeTh6ZFJ2Qk1qRU1SNXFCanpt?=
 =?utf-8?B?Zzd2N3JhTW9qQUJ0OFlEdGpRWTdob3FsRjJrWVlLUnhYMS9pTUJmc0ZwdWsr?=
 =?utf-8?B?SjJ2QmQwMU81UW5jSkFFdXZkcjVZQnNTeVB4ZEFtMGFWUTU2VllUUTR3cFZx?=
 =?utf-8?B?M3FjdnBpZEhzSmQxbjJtTC9kVERFK1Z4cFlvb1F2cDJBUndvTnVKYzNSb010?=
 =?utf-8?B?ZWljd09PSG9PL1R3a01DSHdrU0hYeGJVYWVXeVo3QW5aeXRwcVB4V2MrclVa?=
 =?utf-8?B?eHBWWnlUeCtFTUxUcDNZYWgyZ1FBeGdvZTlrbUw5QmJqekJIdDFWVW1FN0xs?=
 =?utf-8?B?dm9rYmpkVWFHcS9aK0FaSkxlQlZZMkc0L2tMOG9KQWJ1VHVKbGk0VXlMZFli?=
 =?utf-8?B?SWE5QU5HTm9ZcytBUWF6azQwQkJTZ3VzbGg3R3RhRkwzS1AxREVTY2k1T1F6?=
 =?utf-8?B?TjZBcDhnVnRLN0wzQ1pLbnBFdXd2YSt4WVJ1VjVjQ1NXY3R3RzlyV0oyZWk1?=
 =?utf-8?B?U3NrWXdWSzNkWUZQR1NVVzU4K1FwYTNIaERodU1ubHd0cHBvRlBmT0dxMnJo?=
 =?utf-8?B?K1RKN2dzOVhXYU9pZi9tYVdvSk9pamJvdUZ0NTBzczRrelNVeFZmdVNkWFMx?=
 =?utf-8?B?QzcyeFh4V1hkRVllZlVNYTBVdklQTTdZVGVhN24yTUR2a3BkU0pXSlpDbHc0?=
 =?utf-8?B?cGRnZjBGTDM1eTZiSGhFOENEVFQzWUEvVkJ0Y2tzZUZNd0pFSFgrdUVtOG1K?=
 =?utf-8?B?cVc3QzRJR3MwTjZBZzhzd3dRNGdTMVlWazk1Zm9sSHY4bEUySDAxdE5UMlRi?=
 =?utf-8?B?ZTNWbVdLeHlNSVhQN3VOZVRWc2NBcTV2T2U1YmhLazR6c29sVmhmUDdYRWhP?=
 =?utf-8?B?ZWRQTWRIdkgzZUlOayswdlZzMU5DKzF1Vm45c1BhQUpYeWc2M3dtZUVmYjYr?=
 =?utf-8?B?aVU5SFBQS0w5d2o1TlhMZDVESVJDSWpCRXNJVjFNZ1BoeGxPWjZiZDBweVJx?=
 =?utf-8?B?WVBLWFNGTGM0UVlFQmVjSmdKamRMb3J6bytFTjN6UHZWNEhYeWFsdVA4TG9u?=
 =?utf-8?Q?8GcDu23WsLXBmXg6zvWOgwAXNhf9iMGE7IgI4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRKUXZzK0JTNkMyZEFBWXZvL0NiL2c5ZjR5VERDMVZtUHVDa0VuRC9NNlUz?=
 =?utf-8?B?TytzVHMxQmZRNXprSW45WG1hTjBJZ1ZWc2xxOVpMWE1GUWQ5UXo5M3FsNlVz?=
 =?utf-8?B?ajVLcmlscDJUVkx5OGVhNUlEbk41V21PK0o0UXl4MHVFMkhrWThSS3pKSUNV?=
 =?utf-8?B?bVRQTjFGTUdjOTB2MmNKVVdiMDZDdWkxM1hZTmNnaFpWQm8yL3dmOCt6TFNQ?=
 =?utf-8?B?aWVvbWdMUjNFVXVTUnNVa01kMWVTVWxnSnRoWS9jdkVIemZzVDNZUEhJeEt5?=
 =?utf-8?B?VjNvc2VZeGRmenVNc210UXRuVG90bUM3dll0bTRBdmhTVTdMa0hpZE03aHFi?=
 =?utf-8?B?SUhvOEhjN0pIK0o0L1BORTdXYlo3MUVlZzF4cjJHY2tEMmFJaFZocSt5QWcv?=
 =?utf-8?B?SDhZNTkybStKYzl1Q3VocVBzbUc0YTliRTZ5WFYrbDU4SW1qRzVEcCt6blB0?=
 =?utf-8?B?cFJNNzhtSHJiNDR6T0lCakdlQ1QxZXZRMlJ3c1RUZVRWVFppZHZUdm1zQjYz?=
 =?utf-8?B?M0xzSVp0aHJxZE1XeWlJUkhkaFRjR0VkSHRTNnhNVldHR0Z4anBvaXdhZU43?=
 =?utf-8?B?MEdZNUkyN3RnMS9jYm5sYU9tQ3gwQ0ZaOURDMXArM05OWUFicnU5NkVVYjhY?=
 =?utf-8?B?eXJTVnFiQWJOVTltTkFOZ1F2akx3NzVqZndaVlRSR2YrTytMTFNNbjEwcFF2?=
 =?utf-8?B?elVGMnhMbVBmTWN4bStLTHdLU0Y5bGJ3YXh5bzNrVU1LQXBEZjFZZFU5Q0JZ?=
 =?utf-8?B?UE5LR3RuZE1VQ25IcHU1eFM3R24xbTQ3dEF1L0hrcTVmSXhBcDB5YnR6eUpM?=
 =?utf-8?B?ZHpDRGtVWlF4ZE1oL3BDSGtoanVQS3kzU01jd2EzRDU0OVIzLzJEZHllMnho?=
 =?utf-8?B?VVVKYjR3OG12ZXlmYk5mMDFOanh1ZVk3MzlUamdudWg2QWpFODZVeDJLOU01?=
 =?utf-8?B?eFZhWG5GZjdlRDkrU1liQzE5bmdwbkN4MXdQNjlRcDhmRWZGTStDZWZTVnNN?=
 =?utf-8?B?c1QxT0FETGRXdmlLcnhzZGFkN3huUjIrUzVDZ3ZEZjlhQlFQSnd2c3hiTzUz?=
 =?utf-8?B?OU9DL3gwakxSanJkTy9JU09obXJFTUFNYkY1QVFaZVZOWkI4czNYbnBSUDd5?=
 =?utf-8?B?bUc5cENpcURKa1AxSDdxbjA5aG5iQ1d6MVc2Z1FDV0dBVm5sNnZUL3VjNldi?=
 =?utf-8?B?ZE1tSXQzdm1PWXMyVE1FZUFaQmw4dWpMcjhpWWhSdWF6UXBjS3A2NE1IWjFZ?=
 =?utf-8?B?UnBKY0tEaE92anNsR2xCRytwdURTY1RuNCs2bWFCcCtXa1ZUS2Nsd0NSZVM1?=
 =?utf-8?B?cXdUNVJaRk5ZYU9xQmhxQklGOFQrTFVCMnVZcHNUZXBINU5wMmhYL0MwM2Yx?=
 =?utf-8?B?Qnl2L2pzNktkM3dDUEEwRXpWWlEwbXhrUGoySjVMMW9ocUxSWXlBeWhUKy9Z?=
 =?utf-8?B?YlhReTRxOFJyZnl6Tm9uNEhYZGdrN1FtRGpmOUl2bHJpd0FUQlV6TUdENzVH?=
 =?utf-8?B?N2REWHBucDBQRnRxSU9UbXZVOGI1WXg1bTZTa0pxUEpESmRSUTlnVHQvcWUz?=
 =?utf-8?B?dEp2ZWwzQmNaM3hUNDZ6L0FvcGUwVllWK3pmVFpIOXV2QVF3Y1NteHZ2S29L?=
 =?utf-8?B?K1BQQnBTdjVMdVl0bzJaaERJVC9UVzBmZ2gyUVhMbXFtMk5ycG5aS2Qybkdt?=
 =?utf-8?B?V0RSSC9LaDd1QnJXYlEvaEpPeGFIWUFFMzBMSElDYTdMZzY5V3FDcUgyWkl1?=
 =?utf-8?B?eFBQZllYVTcwSWNFMWNvZ1kveVB5QmU1am11dkJOTGw5TUExN3YrK0FWbk5S?=
 =?utf-8?B?cVNnMDd5UXVQTWxnVlhZUmpNOUttTWJUVzNuRm02eVRFNFowekdRYkoxbkhi?=
 =?utf-8?B?bjFYZWV6ZGYrVnZKZGxjTjhnVEE5Q0tFU0dwdFJCeW1OSGRUWUFNcE5QUEFn?=
 =?utf-8?B?bHB4RmViQnBCUkRPZ1NCREtBYkMxNW5GUDVRRGpzOENDUllkVFVvSXZLTnVR?=
 =?utf-8?B?R01GdDNsdm56SVRUdTRJbXZVL0laNzY2OWl0ZHBGWHBxc01aUUdneVB0RGp2?=
 =?utf-8?B?Y3hXc1pOempmUVpjeVQzb2krMFNvNFBNK01uR0JETmsxa0JnMVQzMGtDVFJF?=
 =?utf-8?Q?WiuQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1053e13-30df-4680-7c54-08dc86003048
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 08:10:54.7523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLI0ToOGuyCGoRYyMM4l8Be1aikFACMW2y66dqAu3Cz0ew57xuAXu//g1hfKqbrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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
Cg0KRnJvbTogRnJhbmsgTWluIDxGcmFuay5NaW5AYW1kLmNvbT4NCg0KRG8gbm90IHJldHVybiBm
YWlsdXJlIGZvciBhbGxvY2F0aW5nIEdUVCBibyB3aXRoIGRjYyBmbGFnIG9uIGdmeDEyLiBUaGlz
IHdpbGwgaW1wcm92ZSBjb21wYXRpYmlsaXR5IGZvciBVTUQuDQoNClNpZ25lZC1vZmYtYnk6IEZy
YW5rIE1pbiA8RnJhbmsuTWluQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jIHwgNSAtLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQppbmRleCA5MDQx
YzYzY2FiYjAuLjU4MTg2ZGU2MTQwMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZW0uYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jDQpAQCAtNDA5LDExICs0MDksNiBAQCBpbnQgYW1kZ3B1X2dlbV9jcmVhdGVfaW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwNCiAgICAgICAgaWYgKGFyZ3Mt
PmluLmRvbWFpbnMgJiB+QU1ER1BVX0dFTV9ET01BSU5fTUFTSykNCiAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCg0KLSAgICAgICBpZiAoKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVf
R0ZYMTJfRENDKSAmJg0KLSAgICAgICAgICAgKChhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBHQ19I
V0lQLCAwKSA8IElQX1ZFUlNJT04oMTIsIDAsIDApKSB8fA0KLSAgICAgICAgICAgICEoYXJncy0+
aW4uZG9tYWlucyAmIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0pKSkNCi0gICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCi0NCiAgICAgICAgaWYgKCFhbWRncHVfaXNfdG16KGFkZXYpICYmIChm
bGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRCkpIHsNCiAgICAgICAgICAgICAgICBE
Uk1fTk9URV9PTkNFKCJDYW5ub3QgYWxsb2NhdGUgc2VjdXJlIGJ1ZmZlciBzaW5jZSBUTVogaXMg
ZGlzYWJsZWRcbiIpOw0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KLS0NCjIuMzQu
MQ0KDQo=
