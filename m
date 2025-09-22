Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BD7CAC5A8
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 13:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE2310E4A2;
	Mon, 22 Sep 2025 13:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEIHIcho";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF18010E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 13:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euFDXGmQvVk9omYpRNXArKy+ZY3MYuDw47iV3buDAWS/E6/7enKdcNus3ceKx/aIP8lONFjdFKLvZwU0c7gejnQ0wTvbOh021oN53AMcFz0YXInBo+j01eZvu6mMbAhhkjWY0SlWZ9vVlJ5whetaUAQIVasdEnq4r9TPkItArVPdthqqaarui3GiI/Db90htuXFnmiabCcbqHjEUMEKMWGN1dfmrT8F9EJnBngvmuU9BBk2nfmBgRzkaCpxNVa5KVO5EHuTQZEi8i6At99Mh7peUJKjCJ6Xk/8kpypGy1GW14a1yHFdBG6ugVLXw++EMMGo3DoyTp7V7jhI6z4cbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVCoJ91c4kKDexaCmAj6eTCxRcbj9jJlXZlWhFuhEwg=;
 b=K0yvWNk50cr8yruYFVWE03+s/CRFWT7snE2FwUQkc+3bvVgjBrLa5gVjADfUmgk/SUlCf6M4/LOAoqsHU1KN7g+5PX3Xc1yPJqi9S9l0JdIb7QD3STsFfCpVny4ekwIqpyJ+XWlbpyG1f4Sr2oerHAPgvK6o/df3hgf8Mw5QK//W+g+zJNErXpHNge6BnxqYFJDQbDRGztifABTpqDMz6z7Xl9f+SNUgQ+QjHXyncjMQCACkex0yY96tTU8VBIYbx/FECdfM3O/7Il2aeWtIJAwc4x6jvQHfK6lxgcm38rWXy/O0HdCHQBDfOlY6+3dZseAM1w5ZVPCHvXbKPdzA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVCoJ91c4kKDexaCmAj6eTCxRcbj9jJlXZlWhFuhEwg=;
 b=AEIHIchoNFe4tB/ndTHdZ9adWmQ2m+OmjccCVfNFBEHrhXCRDET3gwWZ2ESjjwkW5Kd8wh2Rz8kr8kxfF/v5ix8lJ2kQ6Srqu2BUbsn3vOtWVPI5AxWnlkXJpcZSptZQr8L6wg83AHnIZXMwFX3AeMrmifv80GFziVuoZ3lG6tA=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 13:26:32 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%7]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:26:31 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: Enable MES lr_compute_wa by default
Thread-Topic: [PATCH v3] drm/amdgpu: Enable MES lr_compute_wa by default
Thread-Index: AQHcKP8V8INcd3n8qUaMU6JngDBzabSaetMAgAS6GRA=
Date: Mon, 22 Sep 2025 13:26:31 +0000
Message-ID: <CH0PR12MB53728200A63CD69043942BFAF412A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250919004800.125555-1-superm1@kernel.org>
 <CADnq5_Ocy21YobXERacyDYwpqfR_K6o+EUxc3_z+414FrOn7rw@mail.gmail.com>
In-Reply-To: <CADnq5_Ocy21YobXERacyDYwpqfR_K6o+EUxc3_z+414FrOn7rw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-22T13:19:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|IA1PR12MB6603:EE_
x-ms-office365-filtering-correlation-id: 0b7fa79e-be52-486e-58a7-08ddf9dba4e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?R1RVYU5HNTBKVmpaM1dNZnVzcERwV0t0VXdoZVV6TVhrS05mSGhNN29UQTNC?=
 =?utf-8?B?TXZBbEdqanUzN3ZYM2E0UVhDNkw1VXRNTytrTzdrN1BZUjNPb1lRQzE4Zlc3?=
 =?utf-8?B?cjJaUkpyQVR0UitBWUlYVGcxVDBhZFVheEFwNmFEclNlSlJLbkJ5VE5oYlhZ?=
 =?utf-8?B?MnU3T3V2bU9kUys4cE5hTmNLNEdFblcwMFJtMFdqVkVkYXEzWTBOSmttU0x5?=
 =?utf-8?B?ZUwxbWlwbHhkR0M1b2UwU3E0ZmJhODJSTHhQZ2RPUjlLY3BUN1VSVjA2cDc0?=
 =?utf-8?B?eE1EUFdnaTVLdGR5TjVZdWtxT0V5NENzTDJmNXBoM00yVk83NjhvWTlTMi9z?=
 =?utf-8?B?d2E0OU1sd2lFdElCUGQ2YzZpT2NTNUVQOTZnRFlVSTI2clNDVmJJUy9KVWRZ?=
 =?utf-8?B?NlpRWkpOdVJiL3lVVVhxOUZKSjJPa0t0cW1uRUNMTmV5Slc0ZXl2cFB3SHdS?=
 =?utf-8?B?Q25jNjh4aWJ1WWl3dFdsNlV0RkwraUNUT1VWdUNISnZxbEJBYVFkOUtjVnN6?=
 =?utf-8?B?NGovYW9Nc2hHTThBQ1FLd201NlFldVJSK3RRTHp2NWJtRlZZQXdLVFYvU0dN?=
 =?utf-8?B?bHYzcHE2SVpsZkx2MjZQdGNkZ2VQQnBlMGNtNXI1SEZSeG80cHNNV0U5OVZX?=
 =?utf-8?B?YkFGeldtUXdJYTlHQUp2T1ZnbmpreFlSdXNGZ0pFY0V4RUxic29MUXNJOWpG?=
 =?utf-8?B?LzlZRmRESkdacjdzOGx5ZEdOcVprUUJmektsVkFqZVUyd2lyWG52VnJuMGJL?=
 =?utf-8?B?YlNOS2dtTUpiZ0JENm52N1ZOb1JoN0xFVmVnNUw0ZSttOEJMUjFZR0thY2xq?=
 =?utf-8?B?SDdwa1FWV3pJa2srcVdJV2RsV1lTclhNanYzRHNBQWRacDRtSU9kamVPWGkw?=
 =?utf-8?B?V2NmeE53dkRDRnU1YnpnVTQxdm9MMHQxSzZnd0FuQWtzSEM4a05iVWtadHdJ?=
 =?utf-8?B?cXprWFhjbmE5VjRPSjNpYk12OWZrUHNaaVlFTjhycWFtRWtzTDErbFkrNmdU?=
 =?utf-8?B?clRiUERKSzIzQk1qTHVtZXZwMVp6LzdGWDVDRVVSSnl4TE9qYjk2Q2o2Ny9w?=
 =?utf-8?B?QkhaVlFmNjQ1RjZKYVBrMjhVaTE5eEZrb295MWNES0VsdFdDY25Gd0JsSlVw?=
 =?utf-8?B?TWZYbWk1QVhOV3o1ektJWTlqZHdxUm1IQ001cTFjYm1YcjE0eTQrajF4a3k0?=
 =?utf-8?B?SzcwNTBrRWpaVGNDR0dJbWVNK3M5dzFIU28vTFBzNllJR0s4cHB1U3MySjkv?=
 =?utf-8?B?U2N3c05LZXcwc1c5UlNkckp4RzgxUm9rZE4zakRxM3A3elg3c0hUZGNrdkI3?=
 =?utf-8?B?VUk1TGVwOTlJYWRtNDZlQVZROHN2MEgrZkFaK1NKM09SdVNWa0wwVjZFZzg2?=
 =?utf-8?B?VWRLV0ttYU91YmVNd21rRkV4RGFIaHZnY3BuemF6ZndkTGg2cUFvVHd2TEcx?=
 =?utf-8?B?WU41WklZRU5yOWV5WXYwUzlxWlJ2eXgzdjZrUUtwNFpSczgrUFo2ZHBVdmlM?=
 =?utf-8?B?cHVkWkE2QXlqWEdvTkJFZUVETkg4MmZZZ0JCR3dmd3RNZE9PL3VUNUU2cUkr?=
 =?utf-8?B?WEJLa2Q0aEFjM2dqQXpHSEMwbjF1eUVESUUyUFoxZHBUUkpOY0RZMGNnSW8w?=
 =?utf-8?B?WTJpWVdld2xKdzJQTEhoUzhLVlNjTUVmUUxhYnJJK1EyYnEydVlWcHJQMzZw?=
 =?utf-8?B?ZXRYZG9UY3pjUEhaZnA3eWFuaXRmWngwaktxQ0N1SzAzampkc00wbEVXZStW?=
 =?utf-8?B?T3cvTjUxRTRPd25leWg0b3JQenpCUUV6WGFoTjNTS2drcmhQYTN4aEk1eEVk?=
 =?utf-8?B?c1luWlVxS01raU5neU1DRyt5bitQQzlQM2MwTUpjT291eWwzZ281QUh2ZXVa?=
 =?utf-8?B?dGFYOFNFUVNkZkp2eno1K2FCV0Z3cjNJdzhOYkxoS2paTUV4L094TFRPbWhD?=
 =?utf-8?B?TXRFT0I5a0dsdzVKUDBycUpNcXFaUnV1dVhYdWRSdDN5WlNUeUJaZTczMndD?=
 =?utf-8?Q?51MatRW1uHH4Rs27LCEIxWlBM66/uU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm8vRGRNREJUVEJ1dDlha0tIK2V6ZkZzTW51SWlMeUxzS05IL3VvdTdnc0d3?=
 =?utf-8?B?eTdOcUw4T3VvbXgvcGlyUGYzZW44QnUrUU1ScVNkVFZLUHp1K0xmTTNPV1VB?=
 =?utf-8?B?NlNPWXVnWXBaU25LZDFQcTE1dmVpK1ZXWndpUEY0azdNU2h4Qk5BZmlISEpS?=
 =?utf-8?B?b1dHRnVqZkY3VVQxclp5UFZNYnQrM3FGdGREYkVyakI0RDRnSmF1aXhxd3ZQ?=
 =?utf-8?B?RXhIem9KdmxLUFFCSzdZYWV6Q093dDRBWHJKV1AyME5FZEVmNTFkTUU1d0dJ?=
 =?utf-8?B?cm51YWR5T1h2N1FMcjlRUjQxRHZuVm8zaFRBRDA4N0N6elhrZlZiQ2pEbmpq?=
 =?utf-8?B?QTcrbUZoeUk4dWxqbDRaT3p1dkZlQ1NncWVHaWtTRkxIU0UvcFZQN3RZclVR?=
 =?utf-8?B?MFo1aG03NUozRXFxVkdQUG1Idld2czRkd0ZTZ0VTNCt3Mm0rTUExbjR5cWtQ?=
 =?utf-8?B?eEQ5bll3dnJiTDVqNm8rSlhqdnZPbi9QNnVvOXNhanhHUW5iaUpZRkRuRml0?=
 =?utf-8?B?bitoQW1KRkRleVM3NHBjQzI1SlIyYUJ0TWlqNi9zOHpINERENlZTNTB1ZlpW?=
 =?utf-8?B?RnBRZFdMaERxVk5OVzNxMHVnMUZZbkp0eGt0ajNWZitlOFhiWDRUME9SOGp0?=
 =?utf-8?B?eGlNL2laNXhWUnpJc2xMKzd4aHNCaFdiQjlGMVpxa09zS29odXlXSldHZ2xy?=
 =?utf-8?B?Umcvc2JxRndNeFFoSExwWkhDazNYUjFzQTgvWUVzRUVNMitXN0k0QnAzQTMz?=
 =?utf-8?B?Lyt5NE5ZRG83VXJFT2d3cDFPZ0phajQ5empTbFBMUENzdEd4Vmc1MmJwRkZI?=
 =?utf-8?B?UDBqSHNGS0IrNGRmdGJCU0o1Q2tkN2VsMFJadHN5K25mZG95V0RBeWJMN1kv?=
 =?utf-8?B?MkVlOU1SbjNwelNoTndYYWxtMXhrdm41c0t3ZThQRGRuR0FaOVdVYmFkeGR0?=
 =?utf-8?B?MEdMRmF5ODdXT2dYa20vZURNS0NTZzNxMHUyZ1lCME5RL0FiNUVHQ2htMFhR?=
 =?utf-8?B?RkRrTWs0T09TTFd3SUVUcUxIakdYRDdNV2VMQlU0WUF0T0NCYzI5ekFKRjA4?=
 =?utf-8?B?MWtsRTliZUdLY1NRbktvYmxMWXFFUitUUFF2S2JqeEdhOFo4MFRPZlE5TDBF?=
 =?utf-8?B?aUdURkZVVC9JVVBaMmxHeHRQU2U3YjA2MldrOExxcjduM1YweHJPMENOK2NO?=
 =?utf-8?B?VkxKajNiVXlsMWNBSFFWOWZqaHp6ZHEySlFTa29taGEwNEYwVkQvamQ4VXBE?=
 =?utf-8?B?TVZLcWkxM2d2TGpTUUZMTVlSMTczSmp2MEU0aDVxL2N4bW5aNGtvMEUzTjl4?=
 =?utf-8?B?WTdNTFpEVHdUWlk3TWwxaWRkcHM4Qm1ZbVFHMGpqMWZmZXBTRDVFSkljbmxU?=
 =?utf-8?B?Tkh1ZyttTm1BdjZXKzlpNnF5bzVvUS9vMzUvVGdKZExJK2RnUHlncHo1SXZt?=
 =?utf-8?B?N3N3eDJXOGQrSFJDL2tJSVBBNVpBYzFxakNNTkdidmlhRUFRUjlXWVFVTFlD?=
 =?utf-8?B?OVA1b1Bpa2w4NGhJTzEvQkUzSFFGdVl2S3d3dFVwRWJvS0krZ1RUNVVCZ0Fa?=
 =?utf-8?B?VmhGUkx2czZiUEZtbCt6U2cyUS9ldTZ5Q3Q2MTZqa2ZRM0szOU92Tzd2aFcw?=
 =?utf-8?B?Q2ZSZFV5OXlDZ2svUHg0YWErU0lMUnJ4WHYyaTRKaVFoaERuOENyNTkvek5j?=
 =?utf-8?B?OElVOGM3RkozcUxRRVBtZTdkWGdRZHdKZmZ3L1p2WStqbzJ2dkd4UENnVVRt?=
 =?utf-8?B?R3NJL2svWGNEYzhSbTdEZlRicStsc2JZZkYray9vVzZlK25kVyszQVhWZWVS?=
 =?utf-8?B?TUNyemd1aVdnVmlkZk8xMmdGOHdta3VWNmV1TjdabDExZTlVSUlVaWsreWRa?=
 =?utf-8?B?bG1TVytKRkNwVzA3QXVnMWZtMWFIdkRnZGI1aUM5OCtVUEszMDlwVlI2c0Jn?=
 =?utf-8?B?WmRyaHdTNDVCQ3VsVHh2c0h2RkdFNFZKSWZnbU1TNUcvU0M5L0lVK2JqU2px?=
 =?utf-8?B?UVBMRVo5cmN0TnJVeUFhaHp1d25GbjhGSEdGOFVZQ3VxU2FTZ21zRGFpUHhZ?=
 =?utf-8?B?anBtditWVHYyWHppdFJDUGpoSmZQL2hQS2l2SU15QUQ1ckxpWWNvYzU3WVZY?=
 =?utf-8?Q?yOAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7fa79e-be52-486e-58a7-08ddf9dba4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 13:26:31.5667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ty+JkeLhn6sao8SH9UaAJYj58e6jHabUX9GiFm9MqsOw8leBvwQqP4FOUHu8nF2oudXHjVMQ1jXCqh49KkaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
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
Cg0KUmV2aWV3ZWQtYnkgOiBTaGFveXVuIGxpdSA8c2dhb3l1bi5saXVAYW1kLmNvbT4NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IEZy
aWRheSwgU2VwdGVtYmVyIDE5LCAyMDI1IDk6MDggQU0NClRvOiBNYXJpbyBMaW1vbmNpZWxsbyAo
QU1EKSA8c3VwZXJtMUBrZXJuZWwub3JnPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBaaGFu
ZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2M10g
ZHJtL2FtZGdwdTogRW5hYmxlIE1FUyBscl9jb21wdXRlX3dhIGJ5IGRlZmF1bHQNCg0KT24gVGh1
LCBTZXAgMTgsIDIwMjUgYXQgOTowNOKAr1BNIE1hcmlvIExpbW9uY2llbGxvIChBTUQpIDxzdXBl
cm0xQGtlcm5lbC5vcmc+IHdyb3RlOg0KPg0KPiBGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFy
aW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4NCj4gVGhlIE1FUyBzZXQgcmVzb3VyY2VzIHBhY2tl
dCBoYXMgYW4gb3B0aW9uYWwgYml0ICdscl9jb21wdXRlX3dhJw0KPiB3aGljaCBjYW4gYmUgdXNl
ZCBmb3IgcHJldmVudGluZyBNRVMgaGFuZ3Mgb24gbG9uZyBjb21wdXRlIGpvYnMuDQo+DQo+IFNl
dCB0aGlzIGJpdCBieSBkZWZhdWx0Lg0KPg0KPiBDby1kZXZlbG9wZWQtYnk6IFlpZmFuIFpoYW5n
IDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWWlmYW4gWmhhbmcgPHlp
ZmFuMS56aGFuZ0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8
bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCg0KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiAtLS0NCj4gdjM6DQo+ICAqIGdhdGUgb24gZncg
dmVyc2lvbg0KPiB2MjoNCj4gICogZHJvcCBtb2R1bGUgcGFyYW1ldGVyDQo+ICAqIGFkZCBtb3Jl
IGRlc2NyaXB0aW9uIHRvIGNvbW1pdCB0ZXh0DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbWVzX3YxMV8wLmMgICAgICAgIHwgNiArKysrKysNCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21lc192MTJfMC5jICAgICAgICB8IDUgKysrKysNCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYuaCB8IDMgKystDQo+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9tZXNfdjEyX2FwaV9kZWYuaCB8IDMgKystDQo+ICA0IGZpbGVzIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQo+IGluZGV4IDNiOTFlYTYwMWFkZDQuLmU4MjE4
ODQzMWY3OTYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192
MTFfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQo+
IEBAIC03MTMsNiArNzEzLDEyIEBAIHN0YXRpYyBpbnQgbWVzX3YxMV8wX3NldF9od19yZXNvdXJj
ZXMoc3RydWN0IGFtZGdwdV9tZXMgKm1lcykNCj4gICAgICAgICBtZXNfc2V0X2h3X3Jlc19wa3Qu
ZW5hYmxlX3JlZ19hY3RpdmVfcG9sbCA9IDE7DQo+ICAgICAgICAgbWVzX3NldF9od19yZXNfcGt0
LmVuYWJsZV9sZXZlbF9wcm9jZXNzX3F1YW50dW1fY2hlY2sgPSAxOw0KPiAgICAgICAgIG1lc19z
ZXRfaHdfcmVzX3BrdC5vdmVyc3Vic2NyaXB0aW9uX3RpbWVyID0gNTA7DQo+ICsgICAgICAgaWYg
KChtZXMtPmFkZXYtPm1lcy5zY2hlZF92ZXJzaW9uICYgQU1ER1BVX01FU19WRVJTSU9OX01BU0sp
ID49IDB4N2YpDQo+ICsgICAgICAgICAgICAgICBtZXNfc2V0X2h3X3Jlc19wa3QuZW5hYmxlX2xy
X2NvbXB1dGVfd2EgPSAxOw0KPiArICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIGRldl9p
bmZvX29uY2UobWVzLT5hZGV2LT5kZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJNRVMgRlcgdmVyc2lvbiBtdXN0IGJlID49IDB4N2YgdG8NCj4gKyBlbmFibGUgTFIgY29tcHV0
ZSB3b3JrYXJvdW5kLlxuIik7DQo+ICsNCj4gICAgICAgICBpZiAoYW1kZ3B1X21lc19sb2dfZW5h
YmxlKSB7DQo+ICAgICAgICAgICAgICAgICBtZXNfc2V0X2h3X3Jlc19wa3QuZW5hYmxlX21lc19l
dmVudF9pbnRfbG9nZ2luZyA9IDE7DQo+ICAgICAgICAgICAgICAgICBtZXNfc2V0X2h3X3Jlc19w
a3QuZXZlbnRfaW50cl9oaXN0b3J5X2dwdV9tY19wdHIgPQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tZXNfdjEyXzAuYw0KPiBpbmRleCA5OTg4OTNkZmYwOGU5Li5hZmYwNmYwNmFlZWVj
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0KPiBAQCAtNzY5
LDYgKzc2OSwxMSBAQCBzdGF0aWMgaW50IG1lc192MTJfMF9zZXRfaHdfcmVzb3VyY2VzKHN0cnVj
dCBhbWRncHVfbWVzICptZXMsIGludCBwaXBlKQ0KPiAgICAgICAgIG1lc19zZXRfaHdfcmVzX3Br
dC51c2VfZGlmZmVyZW50X3ZtaWRfY29tcHV0ZSA9IDE7DQo+ICAgICAgICAgbWVzX3NldF9od19y
ZXNfcGt0LmVuYWJsZV9yZWdfYWN0aXZlX3BvbGwgPSAxOw0KPiAgICAgICAgIG1lc19zZXRfaHdf
cmVzX3BrdC5lbmFibGVfbGV2ZWxfcHJvY2Vzc19xdWFudHVtX2NoZWNrID0gMTsNCj4gKyAgICAg
ICBpZiAoKG1lcy0+YWRldi0+bWVzLnNjaGVkX3ZlcnNpb24gJiBBTURHUFVfTUVTX1ZFUlNJT05f
TUFTSykgPj0gMHg4MikNCj4gKyAgICAgICAgICAgICAgIG1lc19zZXRfaHdfcmVzX3BrdC5lbmFi
bGVfbHJfY29tcHV0ZV93YSA9IDE7DQo+ICsgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAg
ZGV2X2luZm9fb25jZShhZGV2LT5kZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJNRVMgRlcgdmVyc2lvbiBtdXN0IGJlID49IDB4ODIgdG8NCj4gKyBlbmFibGUgTFIgY29tcHV0
ZSB3b3JrYXJvdW5kLlxuIik7DQo+DQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBLZWVwIG92
ZXJzdWJzY3JpYmUgdGltZXIgZm9yIHNkbWEgLiBXaGVuIHdlIGhhdmUgdW5tYXBwZWQNCj4gZG9v
cmJlbGwgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2Fw
aV9kZWYuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9tZXNfdjExX2FwaV9kZWYu
aA0KPiBpbmRleCAxNTY4MGMzZjQ5NzA0Li5hYjFjZmM5MmRiZWIxIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMV9hcGlfZGVmLmgNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL21lc192MTFfYXBpX2RlZi5oDQo+IEBAIC0yMzgsNyAr
MjM4LDggQEAgdW5pb24gTUVTQVBJX1NFVF9IV19SRVNPVVJDRVMgew0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGVuYWJsZV9tZXNfc2NoX3N0Yl9sb2cgOiAxOw0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGxpbWl0X3NpbmdsZV9w
cm9jZXNzIDogMTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBp
c19zdHJpeF90bXpfd2FfZW5hYmxlZCAgOjE7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgcmVzZXJ2ZWQgOiAxMzsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50MzJfdCBlbmFibGVfbHJfY29tcHV0ZV93YSA6IDE7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcmVzZXJ2ZWQgOiAxMjsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgfTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgICAg
ICAgIHVpbnQzMl90X2FsbDsNCj4gICAgICAgICAgICAgICAgIH07DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMl9hcGlfZGVmLmgNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvbWVzX3YxMl9hcGlfZGVmLmgNCj4gaW5kZXggYzA0YmQzNTFi
MjUwNS4uNjk2MTFjN2UzMGUzNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL21lc192MTJfYXBpX2RlZi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5j
bHVkZS9tZXNfdjEyX2FwaV9kZWYuaA0KPiBAQCAtMjg3LDcgKzI4Nyw4IEBAIHVuaW9uIE1FU0FQ
SV9TRVRfSFdfUkVTT1VSQ0VTIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCBsaW1pdF9zaW5nbGVfcHJvY2VzcyA6IDE7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdWludDMyX3QgdW5tYXBwZWRfZG9vcmJlbGxfaGFuZGxpbmc6IDI7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgZW5hYmxlX21lc19mZW5jZV9p
bnQ6IDE7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcmVzZXJ2
ZWQgOiAxMDsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBlbmFi
bGVfbHJfY29tcHV0ZV93YSA6IDE7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDMyX3QgcmVzZXJ2ZWQgOiA5Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCB1aW50MzJfYWxsOw0KPiAgICAgICAgICAg
ICAgICAgfTsNCj4gLS0NCj4gMi40My4wDQo+DQo=
