Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735A4C3ABC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 01:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3411710E226;
	Wed, 14 May 2025 01:49:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZuM0MuJ3";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B471010E226
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 01:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuuK8wU2u4r6354SkaIzFNS57BilIyENjkM0wdx6CqNIREg3HQhLCPE+rTIkK0NEj5GbhYNeII5coUZFKF2QiGMMH+kNij35xddbkZ/Fr6l96U56/qM7L+1nu/6lNAyLMmW1/lIr/sxZzAdzRimReugWhAX6I7FJ2mzoVhkhjgJyYPal6qsvyeeWrxm441ih4OquS+hY7DRQn+BbNpewASqZC6PWmGeq4K9uEwSZ1kT9bHBd0jVW8cX8f4HWuotWl8iE5J9XB9QvH2Py6YvRbRl9cHNkVWMaIgJGS8qzphRa0zdat58vkiPhcjd0n74Wciatr+ZWmEtI6GtWHGt76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/5uZhW9IwmTtP7kNLkyfCYpBE92hgoYzEIdP8GlPUk=;
 b=LoMsYDO2IgzUfw5nrBuaXdARSbAYESRcm7LI0Y9aow3+ZflpP8635a/2VtUo+5XTVOyGgo2dh5nXjENB3Wsve7alkqt11Rg7LwIU384kgkMB0CthY+73egVaoQ8IyfFHVZ+mDgNQ3I2/cDiRL0cGsydbO+BD8B9P7HA5mMP9ywOZf22odZvxNonl//6Xe7g9bOEgSsfh6wX/P0NY9IFO2RQWZHeVVDoMnzvChpFlu7JZL/HpHr4HTDRkzHe1MxILqSenC1fms+dfFae94JP6iiMbhvYQZLh4pN5UINIv13rJx21sGvGLkja8JG6kIq/ztvmspL7ol8HJVn+PZn23vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/5uZhW9IwmTtP7kNLkyfCYpBE92hgoYzEIdP8GlPUk=;
 b=ZuM0MuJ3GpHZwx141m00B6lDH+KwhYMW83KSmBHtTEXAYPvsnyzXWe7GmQpAcC+jz8xLJ/8wMd9Mi6imGRKfkGAFs/r88aTmLzFJkvAtkBSUflxs8vEGL+nPCOR4nW0LRSQE89hgU+eTDOaeNpiDrT97Y8RHfnz6pJuUiZbPTlQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Wed, 14 May 2025 01:49:23 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 01:49:23 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: lock the eviction fence for wq signals it
Thread-Topic: [PATCH v2] drm/amdgpu: lock the eviction fence for wq signals it
Thread-Index: AQHbwuR6pUNd5HXkl0KcMj6C5aFNOrPRXrng
Date: Wed, 14 May 2025 01:49:22 +0000
Message-ID: <DS7PR12MB6005D850AC0C0AD98078C755FB91A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250512022016.395502-1-Prike.Liang@amd.com>
In-Reply-To: <20250512022016.395502-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=725f51b0-bc71-4a99-81c1-162cefa01a76;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-14T01:48:28Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH2PR12MB9459:EE_
x-ms-office365-filtering-correlation-id: 4bd13fea-f9a1-42c4-c937-08dd92898d06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?aC9ab2t2eVJ1ejh3SW1SRHlERGxobEc4ZVhGaVl3NkRzS2lkSGttdDlIRzdp?=
 =?utf-8?B?NTNjcEpVc1FnSzdiNGpBNW9NZkNxNVIwTjloVzNreGNRNUl3SU1vQk1od0ZH?=
 =?utf-8?B?N0VJclN5TVpTZ1BIZldkMFZvWTQ3cnhDWFpkaWxnbVJ5Q3hlSlI3V3lQR2Fm?=
 =?utf-8?B?RndPdE1SbStySG9vTXFNSzVaM0pnenkwWEJZdnlOYkg4Uit3MHpWd3k1Nng0?=
 =?utf-8?B?dGVFZGp3bEpzNVhmN0RLQmZTSlJrejZxSVd5Q1R0aTF4TzVHN0prS3ppVjZC?=
 =?utf-8?B?dm93Zm1LQlBsZDZNN3Vad3FvZXh5WHBIY290OFlqcFZ3aFFuaHdmc203UjVN?=
 =?utf-8?B?YVpYT2VocEtTSXdzK0FzeG5XN284OGd1MnA4VlBHMHRFZG1mM2FObmZpOGtu?=
 =?utf-8?B?ZE1QMi9QQ2xSV0hnaWhYVE4reHJJZElrVDNLYlEyaCtCb050US92cVJhYk1Y?=
 =?utf-8?B?RFhoeTNoS1AxdTdoVGpMcXFNOFYzcFh2L3lFQVBVdEFmSEVsTmJ4QXk0V3Y2?=
 =?utf-8?B?UWF4bGRVOCtWSDdtdEMrVDI1UjM0dGt4d2MwWDFhTGd6VkxXRjdLbG12YmVv?=
 =?utf-8?B?eCtIU2tnWERaL3ZIOFMrNjd5WkQwdE9tK1YvVUI3bHhBYWVnNGVSRFV4dDR0?=
 =?utf-8?B?aUFoOWJJcU5zWDJXVnFsUmJ2Tnp4NXR6T20zMDVRVkZMeXBIKzQvMnRXM1Ri?=
 =?utf-8?B?clp1YWFTVEY5VTdDZlRhSXhpZHErMGNiYVBRVjUvVFU5THE5SHhIRHpVb251?=
 =?utf-8?B?d0hwYjYrV3BCMS90aFhRNEdiMXU0a2tHODVKS2tDVE1MSXJZMWM5ZW9TZ2xt?=
 =?utf-8?B?MFFnVTlVQ1lEMzBDQ0pVNkV1NTJKWXY5aHo5ZlZmSUxkR3lQMjRCT1VjRkdz?=
 =?utf-8?B?Qnh6NEtlMy9LY2NLR1dWVkRJRElsUjczZEF5MnVLeUE2YWd1NEhqRWxZR0N3?=
 =?utf-8?B?aTV1ZjJkVGdxWlYraFZJaTJiVXgzdEFNbGxrZG5GZGVYZnJZazliOVRTQjFp?=
 =?utf-8?B?MElLa1ZnZVV2b0NiemZUQU1QWnB1dEsxc2hERFYydzlZVURWeVlGcmFRRUI0?=
 =?utf-8?B?RDJjWGVBLzk5OFYzVXh2aWJFRHVOMGFCOVJJSFd2czlGdENhaVMxMS85K05R?=
 =?utf-8?B?ZVZaSG9zT2dhaStKTXNFdHVKdVBSSVF1ZXhzeVBQY1N4ZGkwbVhhZndsU2lV?=
 =?utf-8?B?cjRkaVhZU2tBZUxacWthYlh5aUF0VllQQmQ0a1AwZDhIQlpmZ0RvYUdtS3FW?=
 =?utf-8?B?ZVpiNHhCT29JVlhyYjZxcGFrUDd5K3hvYjBDc2lNWW0yZEx1eDI5dGQ2c2RH?=
 =?utf-8?B?SlpVU0lyWG9zSDY5UFBrb21GVnhWaG5QWFdsTHFUdGF0YzNsTGlaVEhySDZK?=
 =?utf-8?B?TUN2VGFtK2pSMDVpYXo3TGY3bzFqd2hMR01NWVBuNmVCeFNjVkM1Ukd2ZjVN?=
 =?utf-8?B?cm9ibE9NMXpuNEFpKzVqbGVnalp1Y0hlZzVRVHgveWJhQmg2MXZYZkQ0eG01?=
 =?utf-8?B?amw5djc2ZDczUkVaRnNBY1lnaTh2alFOQjQ5QjNGQ1lVMW5aVHFFSC9iUlM5?=
 =?utf-8?B?d3NOZnVCVjliOGN3UzVZbUVZS2wrRUh6cCsxZU8xZ3Q0YVhGbGU0VU5sdGpC?=
 =?utf-8?B?MmNNRU5mRVJ6aHlDc3N6TTFvTXUxd09UVEJUQXBac1JTRW55YVlwRUVwOG1G?=
 =?utf-8?B?TTB6eFBPR3E5aU1TMjFadnE0NFZoNjVXS2QyTzJDblZiUkJJRENheW52VEpx?=
 =?utf-8?B?aG96VlhlVm45a3MxYWNBSDRPTXllWHFPVXhrVktmeVFUSkxlWVN0RUxVKzM0?=
 =?utf-8?B?Q1R2dXUrcjJldjZPU2x0QlpkczZUYVduWE1xYXo0WDFpcUJuMDFPQXdnY3Zy?=
 =?utf-8?B?U2dDV2xtdmp1cSsvTGUwRUlrR2ljUHhtWmtXNU9UZ2RnckpLTUwxRkF2Sjhm?=
 =?utf-8?B?T0o2Yjh3UWMzTHdlYTlKMnJlaEZPRVp0VUlqNjBEKzlhMk9zeHo4TGNCZUo4?=
 =?utf-8?B?Q2owdU1DSnRnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmhyVlFDODU1U1ZBbUZIYTl5SGdrZXQ5WjBRMEIvWVpKTlZoTUdRMndoeEg2?=
 =?utf-8?B?OEVYRlhpNnR1U2xmbjVMNzI1L0EvR0IzRW85SzZOMEdNT3ZsYVcyTUpYbFJM?=
 =?utf-8?B?cnZzUVVhMU1TcEdYSnJsV2xGSVZwNzFySklQNGdGd09MYlR3WVZobVlSbUdi?=
 =?utf-8?B?TnRsbGJGcEJjRXdBVlliUEROOGw4R3IvcVpCMGF4aE8rSTBtU1BTbXlmK29v?=
 =?utf-8?B?NElJK0Jvb0xNZjcrT1o4Y0t3aHUrUlVpV1IzQmJ0amlUM2lOUkU0WitVbDh1?=
 =?utf-8?B?bEdpOFVWa1Y1aG1kbmwxVk1uNGgyMTRIaTEvTzZWWDFuc1FaazMwc2RuTFph?=
 =?utf-8?B?QmRkNW9xYmJkakdjU1hOTy9KK1p6TnpEMnVXLzdTYjI2SDJ2bzcxempaNndS?=
 =?utf-8?B?SVV1YjlaT3pLb2haK0VRaE5ENS9DN1hqUEptNEZqamZXQ1Vhc0p1bmR1N3BY?=
 =?utf-8?B?eFR3ZDJSODFRanh0U055OGVWODRUdHFTSVRnQjJCWGszSEFwTmRKMFZOZERH?=
 =?utf-8?B?YndydlVERlpZTHVxVzFaVXJITnZZK0t4ZzBvME41R3F5bXlJRmVRUHVjcnNs?=
 =?utf-8?B?eGRuL2Q4L3FTZG9mTVY5SXIwN3VQbXlEVW5QZG9YekgzQnNzNytNMXpJMGNQ?=
 =?utf-8?B?Y1BmTzIxQVJhZWFRMjFwMHhmaThuc29WOEJrNVEyU3NOa0E0QUg4L1I0YjZD?=
 =?utf-8?B?cFJjRFkzVlp4TG1CalgreTd1cU9KZGk5alVkejdabVc1QTNoSjRQamxTTFRr?=
 =?utf-8?B?b2xhVGRMWDFsZkNPWjhKeThJNUVYdXpjaFlYZGxLMVkrWnZlcXNaZ2V2bktT?=
 =?utf-8?B?WlU1eDA2V3duaFFsLzcrZms2VDVaQktDUVpKWWgrbm45cVBUUlpUUUt6QWVY?=
 =?utf-8?B?RElCMmRuT3ZjRUpOSnZ0U2tkTDgwUlNhc24wZmkzVjRiY3U3dDAybEc4Z3hE?=
 =?utf-8?B?Q3pIYVMwMFVJK0ZUMnFoWW1ISGhOSlpWcG9PSjNPRXJ6emtaU2hLUzQwUTMz?=
 =?utf-8?B?SzdmTzRNc0tUNERMRTBHTG4wN2MvUUN3bVdaWjNkRUJaU1hVejRwNHBLZWdG?=
 =?utf-8?B?bTB3ZGw1aXBUM210bXU3LytLS1NGU21NZG1lTjljR1ppUzZtTStoTVdPbUI3?=
 =?utf-8?B?d3FlSkVxbW83VzhWSEhHZXpNTXBIRTN0eE5YNFlBZlg3c1ZJNkpzQVYzYzNh?=
 =?utf-8?B?bEorWlVZT1hCVFlzbG96L1FJSTJkd0VvRzdjWEFUZlRMbURQKzFBa3QrcW45?=
 =?utf-8?B?cGhqeERxZzBCckhwOFZITlhXd0g1cDBTbGpNaDduNnJKL25LUUZMOVRzMzFw?=
 =?utf-8?B?OUNsMnRiL3AxbGZLbmw0ckwrUE4yaVd5UHlaYTNSZVlQYnRYSUlFTzdDOXU3?=
 =?utf-8?B?NUdVdlFIWGh2MzhtdmtLUlkyUXBPWERVV0l0cWNYMXp3Z21nVjdHcFUrYVoz?=
 =?utf-8?B?NEM5VHpZNUpxUDlIRGpuQ3FRNnZVRE1pMWxVQ0xkSW5BaHBrOXhjTFpPd09s?=
 =?utf-8?B?dXdsL0gyU2tLdVY5NlRBTkt5NGl5cFl3TzB4R21pcnZ2V3BiSHJ6MEdiL1Vz?=
 =?utf-8?B?b3QyOVYxU0FiRk1mVFdpSTg5MGwxeHM5NjJEVG9TTGdlZmtDMnNxaHJEaXFh?=
 =?utf-8?B?RFpmTXpmUUl2QUl3YWoxUkZZazBUemxJMUxUbDFFVjA2T20yTkJYNFZNY3Rm?=
 =?utf-8?B?Sy9jcTkvUnh2RVpwaDVRNlJJOXRGMjlWbGlHOEphczd3d3BrbTV4SjV4WE9T?=
 =?utf-8?B?K1Y2SHdLUXh0cStkNVRSemY5b2FGL1MvSmhFNkdobVB6Mlk0NGdtaVBYdzZ4?=
 =?utf-8?B?WHdsOE5FSTNiZExjY2w0WHlMNkppRCs3N3o0bDU0THhtVmE2dmFxTU5UQ3Y2?=
 =?utf-8?B?a2pvUHdBOWNwRkpDYjBURW5aSTFtVWN0OC9mWkt0WjJnK1FYTWhRWCs1Y3pO?=
 =?utf-8?B?MDZHL0FaK0JHZ1RCL0VTWUowREZnRXBjNVB2U3lyUUxxMVg2M3Aya3RVVHJY?=
 =?utf-8?B?cVhzdEJVdDVuWjJ2MXk3UVZTQ0VzcUtPV0REbzZVQmFFVFFnNHphNVI5emRv?=
 =?utf-8?B?NVpwQWdZeTRCZ2FxZDhuUG5Ock9xam9ycVFBNnUrWFV4aTVYZ2srTVVrUG1m?=
 =?utf-8?Q?nUfQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd13fea-f9a1-42c4-c937-08dd92898d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 01:49:23.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZUeAPwFkt23vcfmzfCFh5TAXZ7/5HEFMmQdmYpx3gYKPpn/jvotZE2gkiNQzZ4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
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

W1B1YmxpY10NCg0KU29mdCBwaW5nLg0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5n
QGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDEyLCAyMDI1IDEwOjIwIEFNDQo+IFRvOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGlhbmcsIFByaWtlDQo+IDxQcmlrZS5MaWFuZ0Bh
bWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBsb2NrIHRoZSBldmljdGlvbiBmZW5jZSBm
b3Igd3Egc2lnbmFscyBpdA0KPg0KPiBMb2NrIGFuZCByZWZlciB0byB0aGUgZXZpY3Rpb24gZmVu
Y2UgYmVmb3JlIHRoZSBldmljdGlvbiBmZW5jZSBzY2hlZHVsZXMgd29yaw0KPiBxdWV1ZSB0cmll
cyB0byBzaWduYWwgaXQuDQo+DQo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJp
a2UuTGlhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZXZpY3Rpb25fZmVuY2UuYyB8IDggKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gaW5kZXggMWE3NDY5
NTQzZGI1Li5kNWYxNzZmZWYzNTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+IEBAIC0xMDgsMTIgKzEwOCwxOCBA
QCBhbWRncHVfZXZpY3Rpb25fZmVuY2Vfc3VzcGVuZF93b3JrZXIoc3RydWN0DQo+IHdvcmtfc3Ry
dWN0ICp3b3JrKQ0KPiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlICpldl9mZW5j
ZTsNCj4NCj4gICAgICAgbXV0ZXhfbG9jaygmdXFfbWdyLT51c2VycV9tdXRleCk7DQo+ICsgICAg
IHNwaW5fbG9jaygmZXZmX21nci0+ZXZfZmVuY2VfbG9jayk7DQo+ICAgICAgIGV2X2ZlbmNlID0g
ZXZmX21nci0+ZXZfZmVuY2U7DQo+IC0gICAgIGlmICghZXZfZmVuY2UpDQo+ICsgICAgIHNwaW5f
dW5sb2NrKCZldmZfbWdyLT5ldl9mZW5jZV9sb2NrKTsNCj4gKw0KPiArICAgICBpZiAoZXZfZmVu
Y2UpDQo+ICsgICAgICAgICAgICAgZG1hX2ZlbmNlX2dldCgmZXZfZmVuY2UtPmJhc2UpOw0KPiAr
ICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgZ290byB1bmxvY2s7DQo+DQo+ICAgICAgIGFtZGdw
dV91c2VycV9ldmljdCh1cV9tZ3IsIGV2X2ZlbmNlKTsNCj4NCj4gKyAgICAgZG1hX2ZlbmNlX3B1
dCgmZXZfZmVuY2UtPmJhc2UpOw0KPiAgdW5sb2NrOg0KPiAgICAgICBtdXRleF91bmxvY2soJnVx
X21nci0+dXNlcnFfbXV0ZXgpOw0KPiAgfQ0KPiAtLQ0KPiAyLjM0LjENCg0K
