Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF13CFD313
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 03:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36B1890D2;
	Mon, 24 Nov 2025 03:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sT4HFnYL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011018.outbound.protection.outlook.com
 [40.93.194.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CACD890D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 03:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2fHC+VBIGykt0ZsH7kFWJaLSrvEfgepsaxQt8peIudT1D5UIH4q2OFN9HOgLkn+OOcBFJ4p22HWegwB/xe3dqmKHLOAzn+AUO81VCUEa++Ygm1hdFX78/Gn3Z62+sZvdPCK1m5h5m1O/HfxIHb+w3u7BrN39vMCFZ9mV78/5eV1UZqb1MKHYR1Wva+aLn45PRjxbIqiAmJTBSDqq+kuo/t4VpphIurgxp2H+UGXYnlbemI2kbZWPceuEgylo6HhRdBd5NDpz5ZuDmVRate3EbcVbs2fB6Z3PJ8XK/OBKSnNiNQYfSYCGIY8NQiqTSmrNMdQ3C5DfLVqRpx633ITgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG/XTL+jL+huxF8OlZxghqPLXtH3K50S3jAwJ0ti7Vw=;
 b=rleBaocHd/5wApKwyfiCpo8dX0IChhf9o2vaNbSSGYk9ysFODQjWUoVRWLfrdOGbO+MOtKUDj3g7uyZ+tBFYykAJkR4DYCz3emFw8TQVbwG0ntUv/UilpuAlCcH3y2Ip8SdQQeHTR3Oi4+bG399qLyMCSaO/mxQ6nd223eSOBIbI/VfaMq54MYFlAcl/eTfQhQbqdqeZQFC4MJbk2WeRJvYP/thJFuFCFQX8eqNn5zpI1kTExhnWloplGsdYN343lSbvC17r/NaWxyUmFfMMkCaO9q1mVHmLdbh4bDLxAOqrd+ISO+PkyGaRAKtH5kgjeUufS8aD/niEMVQCJjHBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG/XTL+jL+huxF8OlZxghqPLXtH3K50S3jAwJ0ti7Vw=;
 b=sT4HFnYLXBxHXK8XvzJR4hA2W6uItD+wOALAVYtGrMxzBu7eqeo8rdS8Gyo9f1Cw3rOxRyDV/0EwI9o0LZk6iJpGABsf8OrEUVyO+qCFo/B3fvBQ9t0+1n/ivjvsgLOeZJh67Bypfuz5hzOifpz1KhMZUho4WL3X/+8kSFcQ/VU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Mon, 24 Nov
 2025 03:59:43 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 03:59:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Xiang(Dean)" <Xiang.Liu@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix CPER ring debugfs read buffer overflow
 risk
Thread-Topic: [PATCH] drm/amdgpu: Fix CPER ring debugfs read buffer overflow
 risk
Thread-Index: AQHcWtYQzYcrqtttNkqknPadKSSBArUBN80Q
Date: Mon, 24 Nov 2025 03:59:43 +0000
Message-ID: <PH7PR12MB8796E06FBE55B3E38BCADECDB0D0A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251121110005.167947-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251121110005.167947-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-24T03:59:31.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB7678:EE_
x-ms-office365-filtering-correlation-id: afebcc11-8640-4fed-c991-08de2b0de669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UERYeEF4Y3dpUkZMUzQ1a1kyTjZNVUtVdS90a2ZIMmlyTFZUbnorQWt5Wnpl?=
 =?utf-8?B?QTd3Skx5WCtOSjZJa3pDZW5pcnd5RGhnWHpWdzlpbUIrd2xkUnM2N1FGUGo4?=
 =?utf-8?B?d0FuZWlWdXRFaDFxcGFHKzJSOXJaL1dCTFlBNU9PQWhKaFNzTHBDM2pxVXh4?=
 =?utf-8?B?RlJHRTBLaWwzUXY5N3dJaGpXSGNhdTNja25ibU13Ny9wRlB0MnFYUGoxTkZu?=
 =?utf-8?B?K2ZjRWV5NWI5ZWdEQ1hQK09wZ1k2cjFqbUNaOWRya0NDRjdHa3FyVWlZT21u?=
 =?utf-8?B?NEZPUWJpRG41YzVCMDg4dnRtMFNnZTBWcklLeHdBai9yVENhRUxYanpNRnpr?=
 =?utf-8?B?VVk4SHF1OVA3MHJaeGV3Zlo3U0ZlT3FaNFZEeFlHNEZOa0g4K2VWNzJ0b1c3?=
 =?utf-8?B?VUpBaWs5NW43eU9yZTVZRmdoWG5VUjJ6NFY5LzgyZC9STTM2Vm55Mm1MdWNa?=
 =?utf-8?B?RXovSXRpUk4rc29tNUNvMWI2b01pSm4zelloZjYwNDVCZ1NsTTdnUWNLT2Zy?=
 =?utf-8?B?Q2pVRlJ2RkVmMzZSL3lOWWxjQjM3VFdhcVZkRkdmK3hVV0tPdlRwSjlJdDFr?=
 =?utf-8?B?V09ZODhzT2NaN29QWk9yQ0Rya3d4bFFIeFBydnNydkp1YzdPakFOSXR3MnRE?=
 =?utf-8?B?VFlQOFVjWFlNZ2Y1b242VGdrU0hNbG9sbWxtQmNqd25NWGwyUlhrYjBOekVY?=
 =?utf-8?B?VjhLeE94R1J1czgyWmtFaHNBYkJHSy81Y1JoOUhQUEFsQm1oNlBsdkpZZ25W?=
 =?utf-8?B?aVkxYTZTTzhJanJzVFh1MVFwRGFlakdoU1oyZGZVcFp5OUNjdzV3K2I5eXUr?=
 =?utf-8?B?L0hmVkVVbU93QmJFUTBENlhRczk3bkQrUlZrUHlxVmxtZ2c5MTVwOS8yUlYv?=
 =?utf-8?B?NDFvTktMWFc0QVgzRkEyMXB0ZU9WNnA3b2RPM0h5TE82cHRGdnhPcGNNbjVK?=
 =?utf-8?B?dmRlYUhWUnBVdGk3QzREd1p4TjJmandoaWpVdmVheEt4d3Y1dUwrUlRDaU5I?=
 =?utf-8?B?M1dwcndJNDloQzc5YWNhc3prbk0wdXl2MXdVd2N4OHpoQUFHUkRGbHFIaDFw?=
 =?utf-8?B?TTA4cFV3MWxUb2lBeUpmdzlNNGFHZ01jbXNzR2d1V0VFNGYxV1BNT3RzZnlU?=
 =?utf-8?B?b3FWekZsQm9EMzhBWUhmNnFYS3dsZTVUaVNWOHhIRVJSbzNOZ2IvV0hjT2cv?=
 =?utf-8?B?aGFqQTJMOWNLcmh2VVNsSXpyczhCMkc5am9BZ2EveGFEdzQ4b1UvMWRQb3hh?=
 =?utf-8?B?RFg2dHlwVXd3Uk5ZNFZXSkxhTGN1ZlM3R2RiaTA4TXQ1TEVjZk9hQXV5TFBD?=
 =?utf-8?B?ZW5HbkI3b1JCM3ovRHRyWmU5M3ZlK2c5bmViZEFibmlZQmRXSjBrTy95dGR1?=
 =?utf-8?B?ejF1WVdsMGQ3MGZYcjJCLzZBUDF5YUtJdWVGVFhteTdtdWMvTFZnc1B5Lzgy?=
 =?utf-8?B?R3hBdkFyRE45K2ZwM2gzV1I1L2RoQ05lYm1mR29WMW5pSVIyckdpNlFVV21v?=
 =?utf-8?B?Uk9VOTVNRlFuTUVKbDVGRE5WRnEwZWZRYXU2anlRQXVHWStNZWFKU0w5cTdR?=
 =?utf-8?B?QXp4SGNGbTZXWUptN0tDUmJuVktTQ0R4Z0tNRlpSZG1LdFVlYzdadGh1anhm?=
 =?utf-8?B?UnMxNlQvSnN2TG8vVytPakZkWVRCRGNLRWNSTWs3ZEZ1bENZdUxaZnVWYnMr?=
 =?utf-8?B?M2M3ZG5QaTBzdFBmK2tBRHdVelVLWFYwWEo4a2ovZUFUVmdlaWdLTkRkQlRL?=
 =?utf-8?B?ODJWVlZEUkxSUEFXRE1JWC9nUzJZc0Nqd21pcWR0TjVqRCtzeEszUVFoeHZ4?=
 =?utf-8?B?V1ptWFJoM3MxY1pJc0FNa3ZvMnI0dWYwZU5Ed3JQQ2Q1ejFNSlpVRlpjQm15?=
 =?utf-8?B?am1Pb1dQMkIrYjZIRWVoakFiVFgvc3JKZzc3RXRVUERJVUZ5OUhKV0k0Ujd6?=
 =?utf-8?B?aVZiUFF5RkZiN0tQcGNHTm43cXNYTmY4T1ZZYklXWWd0YzUrRm9mRjlDUDV3?=
 =?utf-8?B?aDVBb1NORVV3S3pTUVg3L1N0QkFWbGlBeU93ZTZ4bUVNVk1IbTdvb2IxOU4r?=
 =?utf-8?Q?6MLiK4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG9xSjZ3SGdNcHRORDl2QzlaS0c1VUV0N01sNVVQbTVSZms3NTZ5ZEJmbXJW?=
 =?utf-8?B?M01BUmhpcm9OR2lnT28xOVJxQXlBaWR4cFJnNTRPVEFMYUZkNElNR0c1OVZW?=
 =?utf-8?B?NTZoTy8xNW9LY1l2L0xuZkJOdXVMTzhZc1hBOUJ1U3czSWRPbmhpdTlHdmZE?=
 =?utf-8?B?WFJuRkoxNkV2Zjk0R29zREU3TXM5YUpEM1haZVk3ak9qaGI2K0JQc2IwZXgv?=
 =?utf-8?B?RFNSOFVvVyswVjNGZ2UzdkZCVlBtSkV1VUlhR2JvaU9XV0hMek83V2RvMSs1?=
 =?utf-8?B?V1d3bDkrd2hKdG5DY2VhY2R3Mm9ZV3JuOGZCQnZGeERTUWJKWmEyTExqZE9G?=
 =?utf-8?B?K1pxQXF1NnYyLytWU1pQRStyTnR3L3ZROVpDdEw1Y0RYbTJreTRmVi9EOEUr?=
 =?utf-8?B?SXdxUlBxTW4rUHEzbUYwKzhIMGd6SHRzYUdFMWpSbmZRaitQRkZIcGhoR3dQ?=
 =?utf-8?B?VHU4cXd6Y3g5YjRWUTZ4UWVUcEkrMlJDc2RGSXhqbDFGR0lhUmZLVnE0S3R5?=
 =?utf-8?B?bEZWZk5iTWxHbUNjQ0tURWFGN256b3krVENLUGk5T090MWFqaTVSL2g3RTEx?=
 =?utf-8?B?V3l5Y3BpK0JYeFNUcWoxUFZRY250Y3hxdDI0VlAxcWcrYUVDcXAyNW5Ud1Jq?=
 =?utf-8?B?SzFMWkRBNU92eVV5a0tLdGpVQWcvNzdmNVVubWZDbExxdWpqTjc3L2YzdWZn?=
 =?utf-8?B?NmwyTThsak0vUFBMcGJoTERNQVQ4WDZEZEo0dFNpRWs5VVdVOFZnN3BzeDh0?=
 =?utf-8?B?cklhakI1Mm1LdE1hc2I5NG1rZWpWY2I0TDFJQ2czdWJ2STFpWG1YbUtUMWF0?=
 =?utf-8?B?U09LWlZaVXFZdmxmMnBqTFYwbnJuSXNROWFIS0VTTDVFR21wU1hRdWR3OVlO?=
 =?utf-8?B?dGczVUhqNU5aR0FvS3FHWGlFZDRMeXpKVnZtSHExRnhMS3EvWWs5b1ZGQ1k0?=
 =?utf-8?B?b2l3Y3FONzBIM3hQYk96djhDTHdjL0dwWkVWbTJiVUd4Vk9sWWZSTWYwcW9v?=
 =?utf-8?B?djJmc2R0TWVjZ0FTcjl6dVNDSXNMUUQzQ1N5NGZndyt4c25lM2p0Si9JVmND?=
 =?utf-8?B?SE41c0ZydGNWQXFVNjkyS0phY3hiZ1pjWEdLNTdyc1RWZ1JQQW1BK2xwYVBs?=
 =?utf-8?B?ckZtRnFXTi8yK25LbGFGVVRUYkVGSVdkdi9pY280aW54aldmZ3Q3THoxWndh?=
 =?utf-8?B?Ykt5R3BtQ2ExYnhVK1VTdkhVc1BlbDZEa3ZVUXFFcVgvdE5UaTQrTWJiZUVV?=
 =?utf-8?B?YnpRVlhJVzlyQ2d0OWp5N1hoQ3lsQVpTZys2WUh5NmduZnJrb05EUDdleEd0?=
 =?utf-8?B?VVRadkFsTGR0WnprVElFbTZFZkRaRm5JSFpUUlBTTGZwcjM2M0F1bWswSjk3?=
 =?utf-8?B?S05YbHZ1MGkzc3Z3NmhKQUsrVWNIb2dVY0lnU1ptM1lmbTdDb3ZlV2RTajJ5?=
 =?utf-8?B?cm4xSndvZ0FVWGN3T0VKVjMwZkFJa05VRytSeitPaHFhOElidldTTzRqSDh6?=
 =?utf-8?B?UkwyWFFxWTVTT3poUGRHTEIwVUlDa3VwNjgycEZGbjZleDNhQlcxQ3ZROGt4?=
 =?utf-8?B?cko0Z2JUQ0IvRGdicC95WG1qR3NUOVlVNjVxZ3JnYUl6MzlwUlBuM0tnMmJJ?=
 =?utf-8?B?bWtjdmtNbUV6TG5nRjBKbjdjUkxJeGtlOEtvTk55dHlXeFlTU1ExZ1lOZ1J5?=
 =?utf-8?B?OHd5dUF6QVBFYXpPWTlFTWd4bmVnZW9yVmpPQXFMcFFicmZ5bThURmVGNktm?=
 =?utf-8?B?N2dWVEQ2bFEzTERpUm9aV3ZoU3RlNnRBaDlDMTQ1eEI2N0dMTVAxK3VkUEtx?=
 =?utf-8?B?UVRsV0M4YUYxa2h5aHpjT0R6d3pZS0NGUGJzSDEwb3pUVTY5YXRDc1VGMTF3?=
 =?utf-8?B?YklXNER6SzcxYnlFU0hneHhyc0xERElBTGVFMWFkenZuaEdHYm9IWXBwb0xl?=
 =?utf-8?B?SDFobW5leHdHcyt6eFZ5b2VXTkpZNmJjK013Vkt0N093Yng0NVp2MTV2MStp?=
 =?utf-8?B?aFZOMzRsRlhHQ1ZwK3M4ZmNQNlo4S1hrb2hwaDZvRHRBYnFYRUQzZ0N3VTM0?=
 =?utf-8?B?N0N1TkdTS0ZFcllyMEFvZ1h1TFpJTkcxVXBYdXh1cTM1VmlSR3hkeGJ4ZjB3?=
 =?utf-8?Q?mimk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afebcc11-8640-4fed-c991-08de2b0de669
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 03:59:43.2886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vu6XV7uQUDmrMXPtu/pZKqGoARHTFvcYdFFSBq/ZwUh76ZJeE20FLX3kal3fVIM0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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
VkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjEsIDIw
MjUgNzowMCBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFT
QU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBMaXUsIFhpYW5nKERlYW4pDQo+
IDxYaWFuZy5MaXVAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPjsgV2Fu
ZywNCj4gWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogRml4IENQRVIgcmluZyBkZWJ1Z2ZzIHJlYWQgYnVmZmVyIG92ZXJm
bG93DQo+IHJpc2sNCj4NCj4gVGhlIENQRVIgcmluZyBkZWJ1Z2ZzIHJlYWQgY29kZSBhbHdheXMg
d3JpdGVzIGEgMTItYnl0ZSBoZWFkZXIgd2hlbiB0aGUNCj4gZmlsZSBpcyByZWFkIGZvciB0aGUg
Zmlyc3QgdGltZSAoKm9mZnNldCA9PSAwKToNCj4NCj4gICAgIGNvcHlfdG9fdXNlcihidWYsIHJp
bmdfaGVhZGVyLCAxMik7DQo+DQo+IEJ1dCB0aGUgY29kZSBuZXZlciBjaGVja3Mgd2hldGhlciB0
aGUgdXNlciBidWZmZXIgKEBzaXplKSBpcyBhdCBsZWFzdA0KPiAxMiBieXRlcyBsb25nLiBBZnRl
ciB3cml0aW5nIHRoZSAxMi1ieXRlIGhlYWRlciwgdGhlIGNvZGUgdGhlbiBnaXZlcyB0aGUNCj4g
ICAgZnVsbCBvcmlnaW5hbCBAc2l6ZSB0byB0aGUgQ1BFUiBwYXlsb2FkIGhhbmRsZXI6DQo+DQo+
ICAgICByZWNvcmRfcmVxLT5idWZfc2l6ZSA9IHNpemU7DQo+DQo+IFRoaXMgbWVhbnMgdGhlIGZ1
bmN0aW9uIGNhbiB3cml0ZToNCj4NCj4gICAgIDEyIGJ5dGVzIChoZWFkZXIpICsgcGF5bG9hZCBi
eXRlcyAodXAgdG8gQHNpemUpDQo+DQo+IGludG8gYSBidWZmZXIgdGhhdCBpcyBvbmx5IEBzaXpl
IGJ5dGVzIGJpZy4gSW4gb3RoZXIgd29yZHMsIHRoZSBrZXJuZWwgbWF5IHdyaXRlDQo+IG1vcmUg
ZGF0YSB0aGFuIHRoZSB1c2VyIGFza2VkIGZvci4gVGhpcyBjYW4gb3ZlcmZsb3cgdGhlIHVzZXIg
YnVmZmVyLg0KPg0KPiBUaGUgZml4IGlzOg0KPg0KPiAgIC0gSWYgdGhlIHVzZXIgYnVmZmVyIGlz
IHNtYWxsZXIgdGhhbiAxMiBieXRlcyBvbiB0aGUgZmlyc3QgcmVhZCwNCj4gICAgIHJldHVybiAt
RUlOVkFMIGluc3RlYWQgb2YgY29weWluZyB0aGUgaGVhZGVyLg0KPiAgIC0gQWZ0ZXIgd3JpdGlu
ZyB0aGUgMTItYnl0ZSBoZWFkZXIsIHN1YnRyYWN0IDEyIGZyb20gQHNpemUgYW5kIHBhc3MNCj4g
ICAgIHRoZSByZWR1Y2VkIHNpemUgdG8gcmVjb3JkX3JlcS0+YnVmX3NpemUuIFRoaXMgZW5zdXJl
cyB0aGUgQ1BFUiBwYXlsb2FkDQo+IG9ubHkgdXNlcyB0aGUgcmVtYWluaW5nIGZyZWUgc3BhY2Ug
aW4gdGhlIGJ1ZmZlci4NCj4NCj4gUmVhZHMgYWZ0ZXIgdGhlIGZpcnN0IG9uZSAoKm9mZnNldCAh
PSAwKSBkbyBub3Qgd3JpdGUgdGhlIGhlYWRlciwgc28gdGhlaXINCj4gYmVoYXZpb3Igc3RheXMg
ZXhhY3RseSB0aGUgc2FtZS4gVGhlIG9ubHkgdXNlci12aXNpYmxlIGNoYW5nZSBpcyB0aGF0IHRp
bnkNCj4gYnVmZmVycyBub3cgZmFpbCBzYWZlbHkgaW5zdGVhZCBvZiByaXNraW5nIGFuIG92ZXJm
bG93Lg0KPg0KPiBGaXhlczoNCj4gICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yaW5nLmM6NTIzDQo+ICAgICBhbWRncHVfcmFzX2NwZXJfZGVidWdmc19yZWFkKCkNCj4gICAg
ICAgICB3YXJuOiB1c2VyYnVmIG92ZXJmbG93PyBpcyAncmluZ19oZWFkZXJfc2l6ZScgPD0gJ3Np
emUnDQo+DQo+IEZpeGVzOiA1YjhiZjIxZDFkMTQgKCJkcm0vYW1kL3JhczogQWRkIENQRVIgcmlu
ZyByZWFkIGZvciB1bmlyYXMiKQ0KPiBSZXBvcnRlZCBieTogRGFuIENhcnBlbnRlciA8ZGFuLmNh
cnBlbnRlckBsaW5hcm8ub3JnPg0KPiBDYzogWGlhbmcgTGl1IDx4aWFuZy5saXVAYW1kLmNvbT4N
Cj4gQ2M6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCj4gQ2M6IFlhbmcgV2FuZyA8a2V2
aW55YW5nLndhbmdAYW1kLmNvbT4NCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4u
c2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JpbmcuYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
aW5nLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+IGlu
ZGV4IDQzMzY4NjJjOWQ3MS4uMWFlZTIwN2IxMzUyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMNCj4gQEAgLTUyNSw5ICs1MjUsMTQgQEAgc3RhdGljIHNz
aXplX3QgYW1kZ3B1X3Jhc19jcGVyX2RlYnVnZnNfcmVhZChzdHJ1Y3QNCj4gZmlsZSAqZiwgY2hh
ciBfX3VzZXIgKmJ1ZiwNCj4gICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4NCj4gICAg
ICAgaWYgKCEoKm9mZnNldCkpIHsNCj4gKyAgICAgICAgICAgICAvKiBOZWVkIGF0IGxlYXN0IDEy
IGJ5dGVzIGZvciB0aGUgaGVhZGVyIG9uIHRoZSBmaXJzdCByZWFkICovDQo+ICsgICAgICAgICAg
ICAgaWYgKHNpemUgPCByaW5nX2hlYWRlcl9zaXplKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gICAgICAgICAgICAgICBpZiAoY29weV90b191c2VyKGJ1
ZiwgcmluZ19oZWFkZXIsIHJpbmdfaGVhZGVyX3NpemUpKQ0KPiAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FRkFVTFQ7DQo+ICAgICAgICAgICAgICAgYnVmICs9IHJpbmdfaGVhZGVyX3Np
emU7DQo+ICsgICAgICAgICAgICAgc2l6ZSAtPSByaW5nX2hlYWRlcl9zaXplOw0KPiAgICAgICB9
DQo+DQo+ICAgICAgIHIgPSBhbWRncHVfcmFzX21ncl9oYW5kbGVfcmFzX2NtZChyaW5nLT5hZGV2
LA0KPiAtLQ0KPiAyLjM0LjENCg0K
