Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEE5EDE9AB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 17:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58B910E8B8;
	Tue, 10 Sep 2024 17:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wqsQndQF";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2763B10E8B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 17:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo5kurpv4NADJjJYQCuxaMcqXI2Lt/q5Zz9crMbFmtz59fssBPztnzmArzPY5CSqIiimoXi+j7qknyUe2Sq6RoB5WvFX8nZD3t5iLzrvmtumCE0Wh8VlfGM48NgIhF/bAaU0HkwN8OLSYnA7DXqmJ7O+THtxS0m6xdGX/c1iSpy9+B9xNAQC0XrpqGepF6Z3i4aCjVV2GuvO6pAnX3gDaKtv6jLqmD8maNJUt8S849gDhubSd0ZhAKaZ78YgguVx2EG3q9wmNIU/hAdx+ntlJ06DdAg9LlOAkdXFAFjy6+H5Slw+oRHzpNsrxYpP7oKHMcJs/TK14Wd5TLktD+KvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC/qWgi8niTk6bGfxnJvCAHGfS2Wgy2stB67YT9SG0Q=;
 b=IAIUmG5upCVPiHSUUun+ncLlEpyIuh2Juo7NtGjM3fTvujIhU+zV2re+C/f+u2Ws3/6B+5XI2UCgAZBeH2Zsno3APiaavzq3uG/GFuBx7BBGqFZw9KlbMRYUJeobVBCYb7gUKYfwGFwmUCCER612juy7FNm2otdvf70PeI0HhvSMxH2aMfsu28MUSRh9GManKLxamwH3OXl2nUnocURYgysPDeygrrHf9DwV/PuytxSfiixAifKg9tJiY3vg4fdeYeS5pFJrcf/4KOJr6PqtUCOEtF/C5+3oQYvDmVQhrUvfYjdQgClLFzYohVop9tUUKa0Y6qt6yJ2VNJoMsEyC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC/qWgi8niTk6bGfxnJvCAHGfS2Wgy2stB67YT9SG0Q=;
 b=wqsQndQFM07Y/x4pDgQJbLqzg+tbmJksBojma3c3k4iYv8R63dsYPnfdTtjbRl1KceCzH5RRvtuTl9UHwwO3YF5gsNEtZ8zUuACVcdl+1gQUUsnzCGWmUEUe+6RYkHD5qDF+LcCaSmGNwxU7h/APC/JiSF+4LIgDmB6wBqoXUKM=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Tue, 10 Sep
 2024 17:40:30 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 17:40:30 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: track bo memory stats at runtime
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: track bo memory stats at runtime
Thread-Index: AQHaxkAAQRjxT8NSbEaJ/sQFDJ4CDbJRpOsAgAAed5A=
Date: Tue, 10 Sep 2024 17:40:30 +0000
Message-ID: <SA1PR12MB8599EF01801E282D63C16754ED9A2@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240624140815.18085-1-Yunxiang.Li@amd.com>
 <20240624140815.18085-2-Yunxiang.Li@amd.com>
 <59ffec90-f8c5-4759-8794-df03067a5128@amd.com>
In-Reply-To: <59ffec90-f8c5-4759-8794-df03067a5128@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5bebba25-56d6-4b13-ac55-b1ce8f479dcc;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-10T17:36:30Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|CH3PR12MB9432:EE_
x-ms-office365-filtering-correlation-id: 59494775-afb6-478b-f732-08dcd1bfaa1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dnVnc0E4M2FtSGlCdmxPa2F5M0JiVUNkbTg5N2NjRFRTQkVyMmtVNG8vZm9L?=
 =?utf-8?B?SkttREFuYzAvd0ZFR0NYQTY4Tm5zOVdmNkV5elZIdzh4VEMyRDZGRFVLOFk2?=
 =?utf-8?B?NjdzZXZZL2JaRmIrcGxFeHNxUDRENFc4UEtxY3Y3R2MxQ3ZkUGJ3Yk43ZlJr?=
 =?utf-8?B?MXBoY1lEcDFmYjd0UGxRaXdBbHhGRWxnWUZDQ0FmNFNndW9uK1dseWlPY1lZ?=
 =?utf-8?B?YnFydkRwa2E1M2l4aTVoSkQ0azd2MHVLQURhZVgvR0RTUmNzOXRxYjN5V2pG?=
 =?utf-8?B?TlAzTFhpbnFOMUlmbzNNR0JjeVN2bkh5ZmI5VUpjbTdJTUg1Z3JUSEdqTFNx?=
 =?utf-8?B?Z2k5emFObFFlRUs5ZmMxakdKeEhYTW00ek11NDRrYk1DeE90TjVuUDlMbGcw?=
 =?utf-8?B?VUQxeEt3YTBSYmlsWlQrWWRLekt2SkYxakJkKzV6TTVKd0xQOTVzcE9vdW13?=
 =?utf-8?B?SFFkenV5c0hiTHVOdDVmSG16eG9janpqMTBpMk5WNlgrMWIyNE9mS2FVeGpS?=
 =?utf-8?B?dmNrUjNpeTdDa3Q2SVhTZnNGKzltazAyS3dITHNmOU5zUkhTeGxhTktrWXYy?=
 =?utf-8?B?SEUvK1RETlIxSXVhZWE4WHp1akVmejcxU3pOUjkrVVo4VzZteUlrNEFvZW1T?=
 =?utf-8?B?ZVJmVk1lbHpCWEttWWl5RU42RlFBeHQvemNaVjc5SHA3ODgvNWRma2RKSlJI?=
 =?utf-8?B?Uk1qVkNRSlB2Ujc4UGZJV3NIRzlkNzI1Q0RzcFpETnhKR0psRzloeDAvcVJ0?=
 =?utf-8?B?Y3lrRDNtQUVZV0tBTVk5S0pPOEJRUTN4UXpCUXN4endwSlg1b2hTdStEQm5M?=
 =?utf-8?B?OWp5bXJIejI1Rk92OE03K2d4STR3TmcwNUgyMExWMmU2ZFo1ZWVLdGtvZGcy?=
 =?utf-8?B?ZlB2TTd6NUVFNkNUSEhMN1VzY3diSzhMa1BORk1NcXdUZFlPMGM0QjhSQU41?=
 =?utf-8?B?WVlnb043ZXA5WlUxTDROaDk0TTJZSUxGVTFFQ3lqN3NGMklQMEpROVhHTkw5?=
 =?utf-8?B?NDJpK3ZmZTFwSkl1ZEhFSjEzOGxJTGQ1K0x2ajh1V05qdVdnbmNuSWRxRzhY?=
 =?utf-8?B?M0d4b211eWlWc2x4b0dMalhuako1SXIzc240bUs1WjM5dFJ0UVZXUUlpZ1F0?=
 =?utf-8?B?WXJIZkZuZUpSWDhlR1dCYVpoYUowVUkrOXFOQ005cjM0WGdzT3hqeEEzeGhZ?=
 =?utf-8?B?RlVKTVQrMkZRT0RtSVpObTg5NkhsQ1NrRlJ2U2JkUmhXT1VwRkJKdW8xRk5G?=
 =?utf-8?B?TzNrdzc5dFZqdHFGTnQzNmVDM010bFZzQWRKekRqZEhVU3BQWkNKakZLcGtW?=
 =?utf-8?B?VjZtUVljbVNkMExpWHg4RGdsdDkrRGwzdjVxTCtSdGpVdGJ0aGEvS1VqTkpT?=
 =?utf-8?B?NHZMaWtEYzVnQk93QS91aEJhY1lqT3hXS2g4MzZlcXZUaTgreGdQa055Wk0z?=
 =?utf-8?B?KzhEam81N0V3cTdIZ3M4cXIxOXFSV0c2UTRvRERteS91TGkvbElZdlZYcWpN?=
 =?utf-8?B?RnZBV3Y3ZDBaN2ovWXBZMWg0TEN6aktMc09mRkltV2U0NVlXRUVHdlJjL3p4?=
 =?utf-8?B?d2JtMzZpK3NyNjlIcjUyaEptRW9ObGJvendmcm1aRjhld3d0bXNKTzhMRWpH?=
 =?utf-8?B?MnpEdzRWRVErRWJOZGlydUVaVEpxb1BnWDNGMEFCOSs5SHlsbEgxK3dZNmlh?=
 =?utf-8?B?bkdJR3FKekVJdDZqNEN2a0l1cWk2QXFINVJZRVh5UjVmdlpQRnlwcndmdlVO?=
 =?utf-8?B?R3RnZldqd3ljaE1UQ0RGblh0UXQyZ3lOOEYyS1VmbU1TQWlhaXRpejFCUzJ0?=
 =?utf-8?B?TzQwc3lMQUdRSHczTENiL2J2MEZXeXJ0NExhRVRNcGp2andIY3IyR010cU5I?=
 =?utf-8?B?VDNkMXgrU0hzTStOcm9VV1V3TER5V1pUa2dxak9DbkF0ZGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDFrTFg1c25rL3JJUlVINCt0NEd3SjBYWkFxK3pTMDg2Yzc0Z3V6Q2tJYjdl?=
 =?utf-8?B?OFk2dmNqV003b05kY2NMZDE1ZnE5YW54UEhxdi9NSWltRUMvbm1peE9WT0Zq?=
 =?utf-8?B?bjJUYVV5MEpSalNGd0d0djJXK011eFlYOFpRa21kQy9mc2FxQWYvem94S1Nl?=
 =?utf-8?B?YUdjNW1PZ3ZFUDFNODlQY25KN1d1SmNOWXE1Q1ZFQmFGZnREZmdyRlJkWE9U?=
 =?utf-8?B?eGFKRmpIZThFUUJEV2lmWThieHdNdnUvMUlIeXFBZ1Z5K2N2QTVNSUNTYlA3?=
 =?utf-8?B?TUxvanNteFhBMDZRa3JlMkxIbCtZNWQxcUt2WUllbVpVSHBkZDNSRktyTjQx?=
 =?utf-8?B?dUNqVUNhODhjdmtlcVI2Q0xqRXFCUUNaWmc4SWZJUlZ0b0l5OXdmaVFjK29y?=
 =?utf-8?B?dnE1NGdXYm5YS2pwT3pkZzZROEMwakNIcGVkMVhjRHRFRkhEZkVWeTIxMWF4?=
 =?utf-8?B?RXRqUVBFQlk3OVdBdTRlay91RUc0VFFkdVRoWHQ4UDFlWmhDSEdZUEg1Snd0?=
 =?utf-8?B?QThPVUJ6QktzdmQ0czhFc2RyT2FtQVk5bUFoR3c1WDlGY0Z6NU5YUVhNdERT?=
 =?utf-8?B?STJMaC82TlVVamtieU9VYkFZNDJWclg1Y1Z5aHlmeUFLY2ttbnc1NGpMV0hR?=
 =?utf-8?B?NkJ1bms1VmRHSnRrTDl4cjMyQUxYVFBLQzNuZW52ZWhIKzZMU1RiWDBjT2tK?=
 =?utf-8?B?UjNaVmx6T29vMGc0QndZMk85R0tKc3pDNUFXbGRWaUlFeEp3SW9hSThHMFNN?=
 =?utf-8?B?Rk0rMENxZG9aaXU2SGRzeGsvUjE2b29FU0dIc2NlZFVUdUZocWJBK3ZGZ1Y4?=
 =?utf-8?B?ZHpLRW1Mc3BLYUlQOThYU0VlVVcrMlFRME5xSnBkUXFFRVNmazRFT1MrelhK?=
 =?utf-8?B?VzdGMUhzZmJiRGNLTWRQY0tkK0E3aEJNRzA2YVZBMERhaS81N1E5Mkx2K1dz?=
 =?utf-8?B?KzNrUG1uQlFDNkRxTGlJTFEzQXhLM2ljZFhUN0hoaDVLUnRUdVVIMlNkc2Np?=
 =?utf-8?B?clVZVmpLWEYrN2ZTZjc4OStTM3FnMU9RZ1dHK1lXcXVMUmc2NWQ1Tzg2ZFl4?=
 =?utf-8?B?WWFSYnRKL2s0RWJBcW9xWWgxbDB0dlY0T2l1NU1TSlRDQllWTmFiQU5rZzN0?=
 =?utf-8?B?bVpWUUg2bG5wRHh4ZEZOL3JQZS9zZFR0K1FveTJXZmU1b1RzajdvTHhERzFm?=
 =?utf-8?B?b0g3SENXSkNHa1VIZDFXZG9xOVFydERWSVVlSTB0STdLaDV4RHBGYlZSWG52?=
 =?utf-8?B?SVVpK3dYVTJZa1hITWVnTDRvTjdYOWxURUdzT0N2TXRldGcxbGFzcHRaRGxa?=
 =?utf-8?B?SEtMczI0YVU4czdCUFFQTzRQVXppNDhweHY2cldua3ptUitYSGd6YzByamJh?=
 =?utf-8?B?Z1J4UW0yc1oyMjZ4SWNTNlFIU01yVm1ybWlrQVhzM0M3a2hmS2JNME5PMzI4?=
 =?utf-8?B?bnhYaGdaR0RCRjB5QmhyNHdsSnRsVGJqSDlUbTVmNG05alB4UVFpenRoN0lj?=
 =?utf-8?B?dDJodTJSSVNVUElOVllUelE2b21xUmdsSEZqY1dTRjNlNHNEK0QvTTZIa2c5?=
 =?utf-8?B?UUhEenorNFhySXJidVhENUdtMzdETVcyc1c1YkI0djNqVm5xVWt3WUM4dVVo?=
 =?utf-8?B?ampvRmpOMi9XcXhjbC9XQU0zZllRbVhwV2RIaGVleHUzdDF1QU91TXRhdC9t?=
 =?utf-8?B?NEJaS2haRVlYOEI0SDJ3dXYwMnViT05jMWozTFh5OFZZanJ5SStub2xMZ1VC?=
 =?utf-8?B?SDJMMHNDS0VtaGUzZjZ1eml0RTI5dmt5d2xCNlRCQlUxblhVNCs1SFZEM3NO?=
 =?utf-8?B?amxDTWdTUG5hd2FTZkhqVFZoV3lhVzBzcFByUHFpRHE3Vk5SZ3lva3lPV2xu?=
 =?utf-8?B?K1JDS0pzaVAvSkVOenV4SFV0SXNxWTU5eEdsUm1rQmNJZHZVRk5QcjhZeE85?=
 =?utf-8?B?VURoTUwzVDA4OWNheHhFM3RJRjZUbXpqMkVseDZuaXFUTS94SFdpVmpRMWtt?=
 =?utf-8?B?Y05rY0JnZ3lxc0huMW95V3oxY0Jid1VJeGFwaUNvU2NaelkzMWZXM010bHh5?=
 =?utf-8?B?Sm40RTZBbUUzb1d4L3BQVERGSFBPUXpwVEpKWllGUTFEbllsUlcza0c3aTJ2?=
 =?utf-8?Q?kIeg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59494775-afb6-478b-f732-08dcd1bfaa1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 17:40:30.2508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+IUNAI/RQnqfCb+gJw0J4pnWU8/XCMMlAtWbGLsT1/rGl5eua8fUksryezL9K8jdvYWysC1bCB/G4lMpYWn7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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

W1B1YmxpY10NCg0KPiBPayB0aGF0IGxvb2tzIGV4dHJlbWVseSB1Z2x5LiBQbGVhc2UganVzdCBh
ZGQgYSBzZXBhcmF0ZSBmdW5jdGlvbiBhbmQgY2FsbCB0aGF0DQo+IGZyb20gdGhlIFRUTSBtb3Zl
IGZ1bmN0aW9uLg0KDQpTaG91bGQgSSBzdGlsbCByZW1vdmUgdGhlIGFkZXYgYXJndW1lbnQ/IEl0
IGlzIG5ldmVyIHVzZWQgYW5kIGNhdXNlcyBhIGZldyBjYWxsIHNpdGVzIGhhdmluZyB0byBmaW5k
IGFuIGFkZXYgdW5uZWNlc3NhcmlseS4NCg0KPiBQbGVhc2UgZWl0aGVyIGRyb3AgdGhhdCBvciBj
b21wYXJlIGVhY2ggbWVtb3J5IHN0YXQgdmFyaWFibGUgc2VwYXJhdGVseS4NCj4gQnl0ZSBieSBi
eXRlIGNvbXBhcmVzIGFyZSByZWFsbHkgZnJvd25lZCB1cG9uLg0KDQpJIHRoaW5rIGl0J3MgcHJv
YmFibHkgYSBnb29kIGlkZWEgdG8gY2hlY2sgZm9yIHplcm8gaGVyZSwgb3RoZXJ3aXNlIHRoZXJl
J3Mgbm8gd2F5IGZvciB1cyB0byBrbm93IGlmIGFjY291bnRpbmcgaGF2ZSBzb21lIGJ1ZyBpbiBp
dC4gSSdsbCBjaGFuZ2UgaXQgdG8gY2hlY2sgZWFjaCBmaWVsZCBzZXBhcmF0ZWx5IChtYXliZSBi
cmVhayBpdCBvdXQgaW50byBhIHNtYWxsIGhlbHBlciBzbyBpdCdzIG91dCBvZiB0aGUgd2F5PykN
Cg0KVGVkZHkNCg==
