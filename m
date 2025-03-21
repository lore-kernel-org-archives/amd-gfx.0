Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32978C36001
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 23:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB73310E04B;
	Fri, 21 Mar 2025 23:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HAxEXzQz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99EFA10E04B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 23:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBa9JTwuqp/2pDUHhbMT1NzRuOorc4Qgbt3beBYihysmsLV3F16oVUT6xn6RewBDOtwzfbllO+jzELZlD8ZoN5vPUxVvQcapFJMp0FlND1KeJ9FZm3JVL9f6m/FWl/VQrC5AMoVxLwRpd4gayOv86lael6Ydkynkma18fNW0/iF2XImYVu4sAuEmJZQCEsj8/MVhhPMjo5GNnFYxxt4sdO+CB+F2byILvTJqVHmZvDutWOBfdz3cAJzeyUML7ff+6GpMzp76WB45EoYTYXXyJiL76S7EfTeRs339MZSKf1m0qtsFIouwcqi4N8JMuQ+TsnBfC+96EZs2+/UErBhAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6oojivk8ZW8Q41l0GEMfZ5dD41HEAt1ipo06eKTWJw=;
 b=hD0c0eSnEYVLVCRtkMqwAHDIJ5df4DkZkkz83rLgeKNqvc4TkdSqUFmn5nrzHkT2/hz+IeAksZ0NwqgoJUqFnQRty9Ng2iWdx7pi8WSWhmCYTcfcmMCvfgHn8/vQ8atqsBe1izHBqI5L6Pl7w2setZNheGKChxJMSb3IBXTBcV/un5+EKmjnFdKZHpNKhbG5HoSGJM+icNRVrAAhudyh5tPOX3IDsb1F0V1T+oSAOv++WNBwcDhbQSDGZCC/w8bjkfy3sFf9qrWyLI2AFP3zX19QZAYTZ8UggvTECPZgABq0oPZgjnGXNOCHv61Hd9WQUcvaYnatCzpC/6sALsBg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6oojivk8ZW8Q41l0GEMfZ5dD41HEAt1ipo06eKTWJw=;
 b=HAxEXzQzCnjRFZBBY05WsD5zGk8DS2xLSt5l+VL67mFpjnw1cWAbZl5qLJnWu7mztFwT1L53b2e5hp9mD5XyV+PvMMWx9B9Nf5RHyabuiDsPN2qHnqU4m5lJ1VFBFElr4sqN26o++sLW8o8F+8794jGdiRPEkCvKbT+qHQVw+5E=
Received: from CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) by
 SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Fri, 21 Mar 2025 23:35:19 +0000
Received: from CO6PR12MB5411.namprd12.prod.outlook.com
 ([fe80::fa8f:8242:338b:869f]) by CO6PR12MB5411.namprd12.prod.outlook.com
 ([fe80::fa8f:8242:338b:869f%6]) with mapi id 15.20.8511.026; Fri, 21 Mar 2025
 23:35:18 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix some kfd related recover issues
Thread-Topic: [PATCH] drm/amdkfd: Fix some kfd related recover issues
Thread-Index: AQHbmk9LKZ3VKLnh/kqVU9s8AA1LwbN9bd0AgADO7mA=
Date: Fri, 21 Mar 2025 23:35:18 +0000
Message-ID: <CO6PR12MB54115099731812C703C96DA28FDB2@CO6PR12MB5411.namprd12.prod.outlook.com>
References: <20250321105200.1661803-1-Emily.Deng@amd.com>
 <b27f2a75-1d42-44df-bb62-7070d93848bc@amd.com>
In-Reply-To: <b27f2a75-1d42-44df-bb62-7070d93848bc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ceea2a74-0ca8-4326-8880-bc976ce7f382;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-21T23:26:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5411:EE_|SA1PR12MB6869:EE_
x-ms-office365-filtering-correlation-id: 0a5f7442-8198-422a-3fe7-08dd68d10a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?VXRsWFAwbG44Q08vakVYcEJjcDFkMGpkQjJ0ZXdyazBQSTdlRHd5d3RpU1J3?=
 =?utf-8?B?NGZiWUpNQVgwZFg1TC9sUlB2cFBzTlVXZ24xQ3o2Rm52TWZNandicktXVXgr?=
 =?utf-8?B?ZmtZVTNiSHNCM3hPbk1nQVZIUzB0QmJIUFhFVGpwQjVqak1tRG1TUENCUUtD?=
 =?utf-8?B?dkJMVzBQN0kxVGlVaGRqaVJQdWgxUmw4SGdiRkg0V2YvTkFyTy9jTXl0cEJt?=
 =?utf-8?B?S0p2QSt2Q3hrSXoxWDg0VzdYWVVoM0luYVpwOXQ2Mk9oVjBMVjBiNmlFMHNV?=
 =?utf-8?B?WmVMbi9GcGRCbmNHOUNaQzNSdXFtR0NsZFdtVnJrNlIvMFJTQ1hmVGcvSTRa?=
 =?utf-8?B?RXZCeXMrSlAzVHMySTBWMDB5TVUwS2YzYUQrK1oveDM3UWc2ZVk5cTBNNEpi?=
 =?utf-8?B?S3puL29xNE5NaXRlaHVnaWpMbjhveC9HQmZPNlpFd2RnMnVLYzlFYUpuOWFY?=
 =?utf-8?B?RVNOTTBVNkxiQzlVMmNCY1BSZDdyVnpTMWJHaU9URE85SDFTeDZBTHBtSWFL?=
 =?utf-8?B?cHlodEx3b2VPc1RZcXFXdUlZRjFROVNVNU9jS25NNW5wY2dnTiszck5iNUNz?=
 =?utf-8?B?NHFuQ3ZuRm45cDMxYTh0Y3Nock5OS1FYT3RqLzNoV1dydlV6cDR4QjRRenR5?=
 =?utf-8?B?MXM0UEZtZUswSWk1Y3YzTStaTFBMRnZ1aXVmaGVPZVBlVkhmSitMNVBoYlo5?=
 =?utf-8?B?bkRPL2xqbktUdFVYbVBBZk8vVEk3bjRsRDJkZFNkRjFxYlRSKzBmNWJKdUhC?=
 =?utf-8?B?bE85dzJ3aTFoZmRkUU5HS0ZwdlBDWkM2ejYyRDRWZW4rOXpKSHJjZGplMWJl?=
 =?utf-8?B?clJidlh2Tmk3Vk56a1lJK1IrdkRSamhRRWpVYVNudHJDSzJ0UzdjbHBheVhP?=
 =?utf-8?B?SmticjJsN1ExeTExOWQwMXlweDFXRXhTOGFtSTJCVkV0MjVxcFVrb1hodU5n?=
 =?utf-8?B?MnY2MVp1QWVRaytQUmJ3RUw3YVBLMmNDY3dDa0Y5UGxnZHBIaTcyNFF4eWlV?=
 =?utf-8?B?V3dwTFlDNzZHaVVWb2JKSlpnMjU0bDZCYi8rRFJ2U0pINlczTUo4N1NjZys0?=
 =?utf-8?B?M2NYQW1PNkluNGVJbWI3NDdXd0tjMm9HdktuM1Byc3VaRlZsRVpUbTVyR0Np?=
 =?utf-8?B?M2hQWGptU0FuWGVmdG90Y015bEhONmFWM3VJM0ZicnZsU1ROK3ZaZlZkY0NZ?=
 =?utf-8?B?QUxkOEVVeFBhN3BuS2p5ck1heGhXNDlNMWRiOG1JWGZWTVZTWFNRVWFseW45?=
 =?utf-8?B?RE5LNzU4TzFhUUNYRk9kdHlFUnFFeE4zVXZGbVRkNDM4NDFqVXppeE9ZMUlU?=
 =?utf-8?B?YTNoNnJHTVhXbk1aMXBua0ZLRDZ6STFOeFRIWHJQQm13UEMyT0x4NisyZ1l4?=
 =?utf-8?B?eU1uVm1KTkMxMXJ1VFYrTjBBYlhxUWl1MmFWSkh5ZzZBenJIQWFXaExBTm9Z?=
 =?utf-8?B?RHZIbWlzWklqdmxuYWhhQ2JLd3h1V2s4Z0F6ZEpJaG5nUjRmUkRiakVneDl5?=
 =?utf-8?B?bUJxdkVzRUsyWktvWVZ1ZHV1cnl5YXdSMHExT2kwdWZ0KzVFbUMxL3JzOXJZ?=
 =?utf-8?B?bkJ3c1RlcEsyZmhLdlRwa0EyclRXNzhaSVdOY1NKZ09na1dWWTNFZWZMTmZD?=
 =?utf-8?B?QWJvRnlrNDFmOVB5QUZyMkg0L2R0d3BlL3JQbEs4Slc3WWw4SWUvUVdiVjBx?=
 =?utf-8?B?M1RHZXA0OHJ0NWdyUkNlRWRIWUtlZUcrTkhSSnZJS0lFSnBqTnIzMlY5Sm9W?=
 =?utf-8?B?bk02aTc2Y1M0bjlaSG42ODBzT3gwZS82RlVaeW01K3B2NnErN2JuNnJjcFVi?=
 =?utf-8?B?dHlMZlBCRXdMNTJuL2krdEtTc1NUbFFKeXl3MzNMdnE2YVNoa2JxenVjL0or?=
 =?utf-8?B?Q3lsZUJPWEdTTW05QWRtMVFQNkR3c0gyT1g3WVVYQmMydzBTR0ZEOTFQak1T?=
 =?utf-8?Q?98D5NSRDP8Q70mKf+g7aMpzyAn2+M+a5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlpLdk5IczdPLytYNGdxejJoQ2xIT2JiUSt5S0tvRjRqY1I2YzBOeDdMVm9k?=
 =?utf-8?B?N1BpOWJzYUhuTXR6emJSbXVoWHY3Rk1Vb2JwY2JyaTJLRXBpWExFVEl1SmVw?=
 =?utf-8?B?VTQ5cy80TW5mcU1Ic0xtQ3hvOWlqK0c3Qm5GK2UyNnRsMStJenVlN0s4bU9B?=
 =?utf-8?B?MlZ1L2Fvc25xdUh4R1NweWc3ZDJIR09tS2w2K2wxaXdBNkVZTmpvUDZjZFlQ?=
 =?utf-8?B?ZzBpSDQzZ3luRjhSU0RHektQSHlvMXpjSUEzZk9RaVVuZ1RadDlFOG5JY3lU?=
 =?utf-8?B?Z1EydWtLZVczYWI0RFM1ZThTNmdLeXBHeEg3N2VpZHRhQWlMUVZKUVVIR1JZ?=
 =?utf-8?B?UzVJNE5CTE42OFB5QUpqRmNJeWN6R2R5ODBkNXR1OW9DRzFjaTI4YVUwa0V0?=
 =?utf-8?B?bnJWc2o4S01nVFFBQVRNVHlQZ0xFdmpmNnk3NkV6Yy9LNlR2MWlGVEFtSXBJ?=
 =?utf-8?B?WlJIZHlXK3dtNzZWaG44VGlGeG9lbjdqY0luUGtad3BKRGZPVElneCt3M1BG?=
 =?utf-8?B?NTRhaWRPS1VBWmUwUTg2SVJ6L3kxQysvcmd6Y25JZVBDVTFhZE11ZTN3TlZE?=
 =?utf-8?B?SjJOOUVkbEUzNC8zSVFPSk1MYklzRmkycDlrZks4REpDb0tIYXZ0UUlPdndr?=
 =?utf-8?B?OUh5Nm1NZHUzQzl0Wnh6dEpaM3RoWEVGdWxPSFZDTE5sUTBoU3ZGalJCVVRr?=
 =?utf-8?B?YkpOeUJQNHZ4OUEzTU9Yd0NsWlRLK1ZsUzltZUV0SW9kWHJGMUtBUWlpcmpB?=
 =?utf-8?B?Zjk3REZMN2t5bEd1bEppWkRwRE9sNzFiZG50NEpkRDNlcmpPTDJ6clc5eDRn?=
 =?utf-8?B?ZEFQTTE1L0xqVWhDWWFCL2tFUkxiZ2FQQXpKQTRsbm1yS2lONUtwcnAwMnBt?=
 =?utf-8?B?eVNERVpFaGNiUkEwNEJtbFpUeVB4QkZldmtkMGxIZkt6UnN2UDMyU1JEWmU1?=
 =?utf-8?B?YjRmMDAxRWdSUW16VzdQZkNRbENxbEJJQWthdHZKNW0zR04wRkVBR2JlK0M5?=
 =?utf-8?B?dmpwZkd2TmY4U004NWhoelRFamdWdVlqcEtLN0ZyUE1rQWtCYUx4MWNxcCtE?=
 =?utf-8?B?ZDR2clNSTG9RZWNpcDBLWkFsQkw1alhicGc0OEdRRHkxTU10VTgyWGhSQ2k0?=
 =?utf-8?B?d3dlcmk5V0pLTy8rWFR0dEdEaFhZN21xb012TUJkMFhpYzl1WmRiVGZUKzVR?=
 =?utf-8?B?UUV2S200cE1qTERZMk9BVDRqdFliNi85SHRPZ0dyTStwY2JMbTRWQTlER1BF?=
 =?utf-8?B?MFBBVTlVTU96MGtlSmRSYXRGSkVyV2Myc0dOaTNybS9mR0NubnZBOGt2K3VD?=
 =?utf-8?B?cVMzSDJGbnVtMzU4LzJZdzBGZGN2akYyWVQ2UUtJekRvdVFjaFlKc2I4R2VI?=
 =?utf-8?B?SmFuSGhKbEg3eE5weW5ITVFhWnl5MU1RdmxNaGFXTXV4N0VWcVRLdXMyMUVP?=
 =?utf-8?B?Z1lzTTU0NUtHalhBcjB5eFBYaDFNVVV4NjBUelJuazdZOGdMVTRhdDVKVzlj?=
 =?utf-8?B?eFBKVXptaXFHc0l2YnV1bzJRSHkxdlZ4NzNxeEZCaEZsSHluSGYra2dyY1Rj?=
 =?utf-8?B?VjE0dzZmZFFxWDhCRHAzRUlZbWFvWm5YSmZQbDkvdk5rVno3WnNyT3NNRHNN?=
 =?utf-8?B?Y2FLUW5tNmIrOVZCVFlqTU13NDVHRFJWZWZFeVlIbDVwdGNWWGlrQ1RoN3Iv?=
 =?utf-8?B?MmpBRUdjSHRPWUp4blBJWmtmR2JaeTBodUdsV2VoZzZQQUxURlpYQ0hpKzFH?=
 =?utf-8?B?a256UFBTRWZMdkswQnpzck4vRnpNdnA1TzNNRnFSZHdFWkFzYVRnQk5Zd1JP?=
 =?utf-8?B?cElkY3hUUlEwWjlIYVFGS1l5OEUwWWdrWVVMd1EzekVHbHhKeHBrV20zQVpY?=
 =?utf-8?B?VHBTVHY2UVlKenA3V01CdDI2WXZYZlpIcXpYWnFDMHlTUE45V1h5K3hwMTlz?=
 =?utf-8?B?N3hBREo5WWxwYnozd3Fka043c3ZPY2dCR1kyckhpUGZSc3RpMnRYTEV6cXBQ?=
 =?utf-8?B?MWhubGZGTm5vMGVGN0RHWTFqT1FPN0RJWDY1blpacEIwVlYzK1FaVjFyL1pn?=
 =?utf-8?B?NkozcnQrcC9KZm04Wk45dlNaY3dhMVptek45MldTVER4UGttc2tQbWdxQmZV?=
 =?utf-8?Q?AqGI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5f7442-8198-422a-3fe7-08dd68d10a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 23:35:18.7118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8hzQp8K0D71k05uiQwX8LdAURA6dvBYhq/PApofWjE17k8wQnNm5A8btXnQ9mta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
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
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF6YXIsIExpam8gPExpam8u
TGF6YXJAYW1kLmNvbT4NCj5TZW50OiBGcmlkYXksIE1hcmNoIDIxLCAyMDI1IDc6MDYgUE0NCj5U
bzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogRml4IHNvbWUga2Zk
IHJlbGF0ZWQgcmVjb3ZlciBpc3N1ZXMNCj4NCj4NCj4NCj5PbiAzLzIxLzIwMjUgNDoyMiBQTSwg
RW1pbHkgRGVuZyB3cm90ZToNCj4+IEl0IG5lZWQgdG8gY2hlY2sgd2hldGhlciBrcSBoYXMgYmVl
biBpbml0aWFsaXplZCBjb3JyZWN0bHkgaW4NCj5rcV9hY3F1aXJlX3BhY2tldF9idWZmZXIuDQo+
PiBPciBpdCB3aWxsIGhpdCBtZW1vcnkgY29ycnVwdGlvbiBkdXJpbmcgcmVjb3ZlciwgYXMgZm9y
IHJlY292ZXIsIGl0DQo+PiB3aWxsIHVuaW5pdGlhbGl6ZSBrcSBmaXJzdC4NCj4+DQo+PiBOZWVk
IHRvIGZsdXNoIHRsYiBhZnRlciByZWNvdmVyIHN1Y2Nlc3N1bGx5LCBhcyBpdCBtYXliZSBoYXMg
Y3JlYXRlIGJvDQo+PiBhbmQgbWFwIGJvIGR1cmluZyByZWNvdmVyLg0KPg0KPklzIHRoaXMgcmVs
YXRlZCB0byBhbnkgc3BlY2lmaWMgdHlwZSBvZiAncmVzZXQnPyBGb3IgbW9kZS0yL21vZGUtMSB0
eXBlIG9mIHJlc2V0cywNCj5leHBlY3RhdGlvbiBpcyBHQyBhcyB3aG9sZSBpcyByZXNldCB3aGlj
aCBpbmNsdWRlcyBHUFUgVk0gYmxvY2suDQo+DQo+VGhhbmtzLA0KPkxpam8NClRoaXMgaXMgYW4g
RkxSIChGdW5jdGlvbiBMZXZlbCBSZXNldCkgZm9yIFNSLUlPVi4gQnV0IGZvciBib3RoIG1vZGUt
MSBhbmQgbW9kZS0yIHJlc2V0cywgdGhlIEdQVSBWTSBibG9jayBpcyByZXNldCBhcyB3ZWxsLiBJ
biB0aGUgY2FzZSBwcmlvciB0byB0aGUgcmVzZXQsIHRoZXJlIHdhcyBhIG1hcHBlZCBLRkQgdXNl
ciBtb2RlIGJ1ZmZlciBvYmplY3QgKEJPKS4gQWZ0ZXIgdGhlIHJlc2V0LCB0aGUgcGFnZSB0YWJs
ZSBjYWNoZSBhbHNvIG5lZWRzIHRvIGJlIGludmFsaWRhdGVkIGZvciB0aGUgY29ycmVzcG9uZGlu
ZyBQQVNJRC4NCg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdA
YW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZp
Y2UuYyAgICAgICB8ICAxICsNCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2Vy
bmVsX3F1ZXVlLmMgfCAgNCArKysrDQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3ByaXYuaCAgICAgICAgIHwgIDIgKy0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfcHJvY2Vzcy5jICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrDQo+PiAgNCBmaWxlcyBj
aGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYw0KPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMNCj4+IGluZGV4IGI5YzgyYmU2Y2UxMy4u
ZWIyZGY1ODQyNjE4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2RldmljZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2
aWNlLmMNCj4+IEBAIC0xMDAwLDYgKzEwMDAsNyBAQCBpbnQga2dkMmtmZF9wb3N0X3Jlc2V0KHN0
cnVjdCBrZmRfZGV2ICprZmQpDQo+PiAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+Pg0KPj4gICAg
ICBmb3IgKGkgPSAwOyBpIDwga2ZkLT5udW1fbm9kZXM7IGkrKykgew0KPj4gKyAgICAgICAgICAg
IGtmZF9mbHVzaF9hbGxfcHJvY2Vzc2VzKGtmZC0+bm9kZXNbaV0pOw0KPj4gICAgICAgICAgICAg
IHJldCA9IGtmZF9yZXN1bWUoa2ZkLT5ub2Rlc1tpXSk7DQo+PiAgICAgICAgICAgICAgaWYgKHJl
dCkNCj4+ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jDQo+PiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYw0KPj4gaW5kZXggMmIwYTgz
MGY1YjI5Li41ZTRhZTk2OTgxOGUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYw0KPj4gQEAgLTIzOCw2ICsyMzgsMTAgQEAgaW50IGtx
X2FjcXVpcmVfcGFja2V0X2J1ZmZlcihzdHJ1Y3Qga2VybmVsX3F1ZXVlICprcSwNCj4+ICAgICAg
dWludDY0X3Qgd3B0cjY0Ow0KPj4gICAgICB1bnNpZ25lZCBpbnQgKnF1ZXVlX2FkZHJlc3M7DQo+
Pg0KPj4gKyAgICBpZiAoIWtxKSB7DQo+PiArICAgICAgICAgICAgcHJfZGVidWcoImtxIGhhcyBu
b3QgYmVlbiBpbml0aWFsaXplZFxuIik7DQo+PiArICAgICAgICAgICAgZ290byBlcnJfbm9fc3Bh
Y2U7DQo+PiArICAgIH0NCj4+ICAgICAgLyogV2hlbiBycHRyID09IHdwdHIsIHRoZSBidWZmZXIg
aXMgZW1wdHkuDQo+PiAgICAgICAqIFdoZW4gcnB0ciA9PSB3cHRyICsgMSwgdGhlIGJ1ZmZlciBp
cyBmdWxsLg0KPj4gICAgICAgKiBJdCBpcyBhbHdheXMgcnB0ciB0aGF0IGFkdmFuY2VzIHRvIHRo
ZSBwb3NpdGlvbiBvZiB3cHRyLCByYXRoZXINCj4+IHRoYW4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3ByaXYuaA0KPj4gaW5kZXggZjZhZWRmNjljNjQ0Li42YzA3M2VhZDJiMDYgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+PiBAQCAtMTA1OSw3
ICsxMDU5LDcgQEAgaW50IGtmZF9wcm9jZXNzX2V2aWN0X3F1ZXVlcyhzdHJ1Y3Qga2ZkX3Byb2Nl
c3MNCj4+ICpwLCB1aW50MzJfdCB0cmlnZ2VyKTsgIGludCBrZmRfcHJvY2Vzc19yZXN0b3JlX3F1
ZXVlcyhzdHJ1Y3QNCj4+IGtmZF9wcm9jZXNzICpwKTsgIHZvaWQga2ZkX3N1c3BlbmRfYWxsX3By
b2Nlc3Nlcyh2b2lkKTsgIGludA0KPj4ga2ZkX3Jlc3VtZV9hbGxfcHJvY2Vzc2VzKHZvaWQpOw0K
Pj4gLQ0KPj4gK3ZvaWQga2ZkX2ZsdXNoX2FsbF9wcm9jZXNzZXMoc3RydWN0IGtmZF9ub2RlICpu
b2RlKTsNCj4+ICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICprZmRfcHJvY2Vzc19kZXZpY2Vf
ZGF0YV9ieV9pZChzdHJ1Y3Qga2ZkX3Byb2Nlc3MNCj4qcHJvY2VzcywNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGdwdV9p
ZCk7DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
cm9jZXNzLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0K
Pj4gaW5kZXggN2MwYzI0NzMyNDgxLi40ZWQwMzM1OTAyMGIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+PiBAQCAtMjExMCw2ICsyMTEwLDI4IEBA
IGludCBrZmRfcmVzdW1lX2FsbF9wcm9jZXNzZXModm9pZCkNCj4+ICAgICAgcmV0dXJuIHJldDsN
Cj4+ICB9DQo+Pg0KPj4gK3ZvaWQga2ZkX2ZsdXNoX2FsbF9wcm9jZXNzZXMoc3RydWN0IGtmZF9u
b2RlICpub2RlKSB7DQo+PiArICAgIHN0cnVjdCBrZmRfcHJvY2VzcyAqcDsNCj4+ICsgICAgc3Ry
dWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkOw0KPj4gKyAgICB1bnNpZ25lZCBpbnQgdGVtcDsN
Cj4+ICsgICAgaW50IGlkeCA9IHNyY3VfcmVhZF9sb2NrKCZrZmRfcHJvY2Vzc2VzX3NyY3UpOw0K
Pj4gKyAgICBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bTsNCj4+ICsNCj4+ICsgICAgaGFzaF9mb3JfZWFj
aF9yY3Uoa2ZkX3Byb2Nlc3Nlc190YWJsZSwgdGVtcCwgcCwga2ZkX3Byb2Nlc3Nlcykgew0KPj4g
KyAgICAgICAgICAgIHBkZCA9IGtmZF9nZXRfcHJvY2Vzc19kZXZpY2VfZGF0YShub2RlLCBwKTsN
Cj4+ICsgICAgICAgICAgICBpZiAoIXBkZCkNCj4+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRp
bnVlOw0KPj4gKyAgICAgICAgICAgIHZtID0gZHJtX3ByaXZfdG9fdm0ocGRkLT5kcm1fcHJpdik7
DQo+PiArICAgICAgICAgICAgaWYgKCF2bSkNCj4+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRp
bnVlOw0KPj4gKyAgICAgICAgICAgIGF0b21pYzY0X2luYygmdm0tPnRsYl9zZXEpOw0KPj4gKyAg
ICAgICAgICAgIGtmZF9mbHVzaF90bGIocGRkLCBUTEJfRkxVU0hfTEVHQUNZKTsNCj4+ICsgICAg
fQ0KPj4gKyAgICBzcmN1X3JlYWRfdW5sb2NrKCZrZmRfcHJvY2Vzc2VzX3NyY3UsIGlkeCk7DQo+
PiArDQo+PiArfQ0KPj4gKw0KPj4gIGludCBrZmRfcmVzZXJ2ZWRfbWVtX21tYXAoc3RydWN0IGtm
ZF9ub2RlICpkZXYsIHN0cnVjdCBrZmRfcHJvY2VzcyAqcHJvY2VzcywNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+PiAgew0KDQo=
