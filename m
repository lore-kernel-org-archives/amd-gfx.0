Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5667CEBF9A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 02:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9BD10E04E;
	Tue, 18 Nov 2025 02:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kd2vxQRh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8297010E04E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 02:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5JjjSSVAl+6m9Sp+YPP+31ve3ToaxzhBBhV0ZJqlBL/LjaahV+NNwE+C4xrSjC+63Y2Zr/mg3K+SLN25A9lygjrCgWg5Qp95DmGEvvuLfChFw+XHAwXxLWYN20xG/+7EKfi0df5BOzM+zANFqvjQZH2hXZ575LSCjiMe5C6wTWQL2HeYOxDeHKOxOH+3YVQ07ECyus++vAH5u83tSleNevnb8M6JRnlLSzoIIlAa4Es3mwjJ7ycRW1wkdpHISFO1wOkI/Kdcecte39T3/voV5wPbnbySiE+nx16O/KNFmcCc8MzrmU4IO/Raih76Oj1lFA6TG3Bl8ZC9v6mzNtQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZJSZD5JWXFAxn8dT/X0O7ZLXc04OrimXnxYVHoD7FY=;
 b=FuGou5kteLHKJVe9nsxL5kmZmlTDFalZy8rlffXd55Vl7zMaVSl0enQKAeW96P+qtuRV2uS4umNZWTrFjjt/HjCNLN/UDMFOyhwClR7nrgYoWIAMHkcn2FMIdtWSVnwm2fDHWJbf0OXh+M0vYWrsgUTuoqF65ak0pHphMdzZf3YXSFygCFn2LH8ctrnhXzOBImOmMDvDiaiVK0ej8Rgk9SYyTvrocH92Xp5g0QTUZZNTPuW1m8wd84cKspdNK8Phns9bmk0S7Sntj2mYdq5Q02yyRZPHLat9rlI8zZ2HlWi/2JcQaE78oywRZjEWHKCTQ5x3d/FuXr2kkxF3Cp3sTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZJSZD5JWXFAxn8dT/X0O7ZLXc04OrimXnxYVHoD7FY=;
 b=Kd2vxQRhfNPVlQZKPXtaALrrnIbcbhwZTWWlbpyGyogwsDV+aYcbp9w2qHMwqIv4A04tj4Ujg5vYqJ+9cRJj0MyJTBe/Lx5z+UcenuwBczFxU7m1SrZ2FCQJSH2UZ7rp1I4F+zLfRfYevbNCVlnalEAtB8TD1rcrWhUSa+GtFyc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 02:53:34 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 02:53:34 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/ttm: Fix crash when handling MMIO_REMAP in PDE
 flags
Thread-Topic: [PATCH] drm/amdgpu/ttm: Fix crash when handling MMIO_REMAP in
 PDE flags
Thread-Index: AQHcV8Z0ITDu0CUU1EuArNB2BEnfgLT3vFyA
Date: Tue, 18 Nov 2025 02:53:33 +0000
Message-ID: <DM4PR12MB51527574A2766466AF6706DDE3D6A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251117133049.102851-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251117133049.102851-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T02:49:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS7PR12MB6006:EE_
x-ms-office365-filtering-correlation-id: 0195ae09-1806-4bb5-4c71-08de264daa17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?S2x5b1VUbHRsUDVBWEVxcW1xak1kM1poY2J4OGdIVWU0TjVFMDN1M0Z2VHk4?=
 =?utf-8?B?RWFkWnRWRERLeFN5bENnQnZvZ3ErY242SlJ5Zm5CN1pwS3lQOEdpTHFjRiti?=
 =?utf-8?B?Z2gwMXEzQ2pDWlJpbytDWmJBSUtJdTY1Z2xIQkVQWnI5ZzhGK2poNHZWY1lX?=
 =?utf-8?B?d2VGeXdKVlhkRklZN0QvaXVyZDFGTHNMS2IrYXhvdldvc0xHMXNxVWNqWmRR?=
 =?utf-8?B?R05aZjZrTXhMV3IzVnlna0pacDBSYTdUb1JDbW56WjFiemlINVBoS0lCd0hz?=
 =?utf-8?B?RkVodUtNa2J0RHlnVmtQeHlBV3lZQ2xZVmY5Rkd0Y1REbDZmUnVrRkpHbkRP?=
 =?utf-8?B?Tk81alIvTkVpcXpSVk9ub2NHN3duaWFweDQ1MHRQbjlxL21hV21ZWkZ5REdC?=
 =?utf-8?B?QTZBU2VTdUh5dDgybDBvTmVSVWZCZmJObHMyRzFxWnF3OW50cmtjRTRtbWJN?=
 =?utf-8?B?L3l2dkpleHNPSUZoanNXdHpRZ3FIdVVDMTRqSlVObFM2SEFEckJ6MUVZLzdz?=
 =?utf-8?B?bzczSzdRUHJFaG9Ic09SRWE2RFJReGpaRWdKUHhPVWpPNGFUZlhmUGxCclY4?=
 =?utf-8?B?bTlFRlJtdk4rUEdQTVVERGdPT3Rac3czMlRmNy81dk0xakhtM1cydXhLcW5F?=
 =?utf-8?B?dzVFSi8vdUhEczM4bDVnMkRWeUVua1Mza2gwVVhSMExDZmtrMjh1OFFTNHJv?=
 =?utf-8?B?Q3JGVlFlVzBFZ080KzBIS3FXQmJtYXNCRGVKQnRTS0pXVXYwV1ZPeWNwTTNY?=
 =?utf-8?B?RmMwOW1qU3plcXNWZ09BZDZraXRSUzRnN2lHUUVpNU0zTXhMTlFRUTd1V05D?=
 =?utf-8?B?SkxQRWh4L2ZRQzVPdkc0VUE2T2NHWjFaQVI2TmdqSit3eVhDdUN1eFZNZGR5?=
 =?utf-8?B?OEtVZ2xrU29ndnJKNXFLK0I3U0FTb2lDdWNoS2JiOGFYQXYzY1Y2RVUzaGRQ?=
 =?utf-8?B?TGgxZGdJa0VYNTZ2clNNT2dKWG5PSis5MzZlcndrZmU2ZzZFUk9NZS94ZUwx?=
 =?utf-8?B?UDNzajg5ZHdyWExocDZzdUt2eVJLZFVJdVorbjhXY1o0UzRtVFFGRldNYW1h?=
 =?utf-8?B?WlR4bExNQTlmMkFka0kvOHlpTVpHN1QyOHZWeS9oNG01NW1aMTRUL2EvWVFp?=
 =?utf-8?B?NmdLSG9JbmFqbDJybGNEZDZlYkEyd0s4ZDZzemlKRFVINUMzalVISTFHNGNJ?=
 =?utf-8?B?NmhCSFZrSXlhL3diTXRBM2VnQWpwcmZVZmtGV2FuYnBJdnVPeEVFOTlYSU42?=
 =?utf-8?B?ZUVmTUpUQXY3V1hUTTlHaFp5R0UyRTZsa04rYkFBcHdHSEI4aGUrcDB1THdC?=
 =?utf-8?B?QVlNSmdKaWZUL2pLQ1l2Yi9DdXJiNmNqM21YRzY4MlNuRXhTQnQxNjYyRkVP?=
 =?utf-8?B?d2dmK3NjVGw1d3VCU09XOWJIeW42SGlDKzBtK1BFNzZkN2Y0ZHlZZjY1Zmt2?=
 =?utf-8?B?R3g2WFo1QjFQdk43aDNhYnROc2NiR1QvbWtkZWZNYW1vb2lZdnFOMnVING9w?=
 =?utf-8?B?UXN4ekRBM29tekFPbkY3cXhaUFA5eHh0SUMwUjlVWkFwaERhYlRNaWNKWDlK?=
 =?utf-8?B?SnNqYlZzM2krZkpyOXFnbFRxUVI1TEg0bzh2RXpLdC9ZSUFETmJFVEVET09v?=
 =?utf-8?B?c0R5ZFNpck13SmFjWURNZldFeHZxL3ovVnREVEMwbHhWVldhd1h5TnRsaXhG?=
 =?utf-8?B?U0RvUnNMSmZIRUNEbTlRbk1aKzBQbzBVeDN3Nm1IOENGYnJ5Nks3ZXNtVEFM?=
 =?utf-8?B?aVUvSTVWM2Q5aTVVVDNweU80OVYxdVYySXNQQ1k4WUVVUmtRTXRoaFBHTnJw?=
 =?utf-8?B?TWNnL3JwMndJbzJCcjdCMGJoL0VXbkc5RWxKbXViNnU5cWs4bWsvSVJGOUts?=
 =?utf-8?B?L1VJN1ZHRVNSQk5ueTJYeFRoRkxYVmxESVEwWHZMSDR3R0N5RzE5eVkxWjZP?=
 =?utf-8?B?VEZ3Ull2bXdaM3JnZEpVMmM1NmFsS1hWQ0N5SnE1ejdoMnF0K2p6cVU3OFhO?=
 =?utf-8?B?V3VHZGNqYkxBdlFoSjVGOG9BcWZxL0J0L2k1MDhkOFN2czdrNjN3U1ZVM21r?=
 =?utf-8?Q?5Z1Lfv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3B2dWVzR0FwTXliYStiNWhlTFpmOWxrVUpqcWc0R2xwV2duYmhUS2RrU3hQ?=
 =?utf-8?B?R29PVWQ1SG9JN2psQ2x0Rk00K0lnOUdFaC9oL2tlbVEzZ2RQUjdWWTZ6RXlp?=
 =?utf-8?B?N2w2NFBReStaZngzY3NuZUtsVUJsenFlVXVtK2JVYWcxcWVzRnJkU0FnV1pT?=
 =?utf-8?B?RkJFV01lWkJyU0plOW1PcEpOOGFmZXA4NTJyOXlRb2hGOXlIb0RwUXpFQkwx?=
 =?utf-8?B?c3VjTWFvOERmYW9obkpLaWlZYnhSUkJERHpiYlplaWNUNG01aFhySDMvU2Rn?=
 =?utf-8?B?YzBDVDJGQmF5UnF4ZTVOZ256cGtuaVhHM1N6Sm55STFzOElXWUVidXdDQjNK?=
 =?utf-8?B?ZlZzYzZQZWIxUW83RzB5b1VFeFhkeVUyekQ4cWdocGplVjFUTVh4SG1FTHFS?=
 =?utf-8?B?blhQQnNnaDdzUVY4ZHFUc1ZDNXhhTk5NMXFYM1V4Mnp6YW01RkFiSGY0bUQx?=
 =?utf-8?B?QlNReHB5QlRRNkNKTVFaa0NmTWYxT2FZdUkwV0dBNm0za1g2bm9GeWk3cng0?=
 =?utf-8?B?ZDVqTnplUTBpVDlKYVMvYnREa1dETUZNM0pZUVVubkwwTUdrWWlRVDlsVkJU?=
 =?utf-8?B?Qzh2WGc3Mm9YTlprNjlTZDNMR29TZUkyd3dlU3o0Q2tVUmRaUk42QW9sbDZs?=
 =?utf-8?B?YndJaHp0QlFwZFdvRGNqOUp4S0YxaGQvWW53a2xVTDc0dHBUT1BqZTJjcWV5?=
 =?utf-8?B?SDdaTkJJUUFHemlHM1VvcVZaT0gxV25GYnFBZ3NPZlU1Q01IdVBOTUN5RTA3?=
 =?utf-8?B?WHJsTjZpTWJ2NXRLWXUvL2tzbmVSN2x5MzdlbVRoMUdINEh3MVZaN1o0cTlF?=
 =?utf-8?B?Zy9hTjgyOHJ4c2UzZHFvSVZXeWxNVVozS0VpVkZibFpqMjVXT0ZCM3FNWG8v?=
 =?utf-8?B?bjh6WVYxU2FISytXYlFqUHM2eGpjUmNxOHAvNDlKYms2ZkJOVVFVNVpNVGsr?=
 =?utf-8?B?Uy9rYm9PbWdwa2h1eWM3ZEw1YWt1c3RqSitIV21DVDlJUGtFNnFyQStBOTkv?=
 =?utf-8?B?NXpoZnV1N2VGTXdSenNzR0RmSDFLckNEeld0VDczbEFjNmhFRG1oM2Q5YW5y?=
 =?utf-8?B?elU2eWhVOEp3RlkyalN1NXZqKzZ4Q2doVGk4UXFGaWNpMXdhMEp3dUFEWFhJ?=
 =?utf-8?B?aTNVRkRUaE5XNERSeDBzSlFLcjZydnRuOU5XWTJKNGc1WDN1cVZrQm5abGZl?=
 =?utf-8?B?UEY1VWpkSFFOeUVLNGw5eW1VYi9xeU5oVllFb0svMEgyV3RoNUs3bkNvM0d3?=
 =?utf-8?B?T1lFaVIvME50dGxrYXg2UHpDSU9paUlGK2p6YnhDZTU3aWdjM1B1emlXS1p2?=
 =?utf-8?B?T1o5eDVaS00yc1dpNlQyVUI3STgzN2VpRm95SVoyTytvZlJPQnlpWmtNckpM?=
 =?utf-8?B?YmtHdUVuYW56eGV1NldPVzZMSDJ6b1ZUQzRTbnp6MGVsVy8rZmF6cEMrT0R1?=
 =?utf-8?B?WFdlUUhONkFpSzFQU29TeVhzN1F6NE0rTVJ3OFU2OTdNUlJaVTYwVktDSGhM?=
 =?utf-8?B?cFkxbExuV1BPVzc4MjVJa3FHdVphK1RILzN1Z0RxdmFKUEhyWHhzTTJSM0Vt?=
 =?utf-8?B?eGNSdHUyWGhmUUlFTkEwUXpvU2s2NkthNXFaYVpYWU85aytHZ2xPV0hqakY5?=
 =?utf-8?B?aFkvanhkVmo0WE1YVHkxd0VXTHR3WUtQM1NkUXN5RGdGb1V1YXNCcjR0YlJq?=
 =?utf-8?B?dWlJOFNTcXVEMlkyejA2aFdHMjdoNEc5czFXOWRRQUpyNVdWbkpuSHgrM1FU?=
 =?utf-8?B?R281aWoxcnpHdVdyMzg3Y2NNMkJ2NTlNQWN2ZERHNWsyZHovZVZsdDhMbUY4?=
 =?utf-8?B?WlQ0bkcrU3JHN09oK1B4ZFdRTkd4SmEzNDRoK1EzS29WYk1lUzlEM3lzeEx6?=
 =?utf-8?B?RXFzOWZoaFlTZWNQRlpQWjRYK0paN1V3WSs0Y3FwZmU1aDdLbkQwOHMrdzlx?=
 =?utf-8?B?SzZsZ0VjUlVLNkUrczl0bTlHTHluOU1TQ3FmMzFiS1dFT0N2YUVlOEg1VW9u?=
 =?utf-8?B?ckROUVJNcG5TTStsclNjNXMvUFdyRlViUzFuTi8xcVg3MWNQRTR5WWQ1eGZm?=
 =?utf-8?B?RHA2WkZ5WEVxa2Fodk9yOWZFaFZSWW8yRS9zYjc2VTdvdHRiaVFPS01TNGox?=
 =?utf-8?Q?y0Zg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0195ae09-1806-4bb5-4c71-08de264daa17
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 02:53:34.1148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfguyOhnzXxXlABxlSpGtWs1xL4A9WvKh64x1D7NPJfPqax39n5MLuTEzMTt8uQ/o5sAjwblSfBF1QD2oKkRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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
Cg0KVGhhbmtzIFNyaW5pLCBXaXRoIHRoaXMgcGF0Y2gsIGl0IGNhbiBmaXggdGhlIHJhc2guICBB
bHRlcm5hdGl2ZWx5LCB3ZSBjYW4gc2ltcGxpZnkgdGhpcyBwYXRjaCBsaWtlIHRoaXM6DQoNClBs
ZWFzZSBmZWVsIGZyZWUgdG8gYWRkIHRlc3QtYnk6ICJKZXNzZS56aGFuZ0BhbWQuY29tIiAgYW5k
IFJldmlld2VkLWJ5ICJKZXNzZS56aGFuZ0BhbWQuY29tIg0KDQotLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jDQpAQCAtMTMzNiw3ICsxMzM2LDcgQEAgdWludDY0X3QgYW1kZ3B1X3R0
bV90dF9wZGVfZmxhZ3Moc3RydWN0IHR0bV90dCAqdHRtLCBzdHJ1Y3QgdHRtX3Jlc291cmNlICpt
ZW0pDQogICAgICAgICAgICAgICAgICAgIG1lbS0+bWVtX3R5cGUgPT0gQU1ER1BVX1BMX01NSU9f
UkVNQVApKSB7DQogICAgICAgICAgICAgICAgZmxhZ3MgfD0gQU1ER1BVX1BURV9TWVNURU07DQoN
Ci0gICAgICAgICAgICAgICBpZiAodHRtLT5jYWNoaW5nID09IHR0bV9jYWNoZWQpDQorICAgICAg
ICAgICAgICAgaWYgKHR0bSAmJiB0dG0tPmNhY2hpbmcgPT0gdHRtX2NhY2hlZCkNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGZsYWdzIHw9IEFNREdQVV9QVEVfU05PT1BFRDsNCiAgICAgICAgfQ0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNIQU5NVUdBTSwgU1JJTklW
QVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3Zl
bWJlciAxNywgMjAyNSA5OjMxIFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdB
TSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IFpoYW5nLCBK
ZXNzZShKaWUpDQo+IDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHUvdHRtOiBGaXggY3Jhc2ggd2hlbiBoYW5kbGluZyBNTUlPX1JFTUFQIGluDQo+IFBE
RSBmbGFncw0KPg0KPiBNTUlPX1JFTUFQIGlzIGEgc3BlY2lhbCBJTyBwYWdlIGJhY2tlZCBieSB0
aGUgZGV2aWNlJ3MgcmVtYXAgQkFSDQo+IChhZGV2LT5ybW1pb19yZW1hcC5idXNfYWRkcikgcmF0
aGVyIHRoYW4gcmVndWxhciBUVC1iYWNrZWQgc3lzdGVtIG1lbW9yeS4NCj4gVGhlcmUgaXMgbm8g
bWVhbmluZ2Z1bCB0dG1fdHQvc2cgYmVoaW5kIHRoZSBNTUlPX1JFTUFQIHNpbmdsZXRvbiBCTy4N
Cj4NCj4gYW1kZ3B1X3R0bV90dF9wZGVfZmxhZ3MoKSB3YXMgdHJlYXRpbmcgQU1ER1BVX1BMX01N
SU9fUkVNQVAgbGlrZQ0KPiBUVC9kb29yYmVsbC8gcHJlZW1wdCBtZW1vcnkgYW5kIHdvdWxkIGV2
ZW50dWFsbHkgcmVseSBvbiB0dG0vdHRtLT5zZyBiZWluZyB2YWxpZC4NCj4gRm9yIHRoZSBNTUlP
X1JFTUFQIEJPIHRoaXMgYXNzdW1wdGlvbiBkb2VzIG5vdCBob2xkIGFuZCBjYW4gbGVhZCB0byBh
IE5VTEwNCj4gcG9pbnRlciBkZXJlZmVyZW5jZSB3aGVuIGNvbXB1dGluZyBQREUgZmxhZ3MgZm9y
IHRoYXQgcGxhY2VtZW50Lg0KPg0KPiBGb3IgQU1ER1BVX1BMX01NSU9fUkVNQVAgd2Ugbm93IHNl
dCBib3RoIEFNREdQVV9QVEVfVkFMSUQgYW5kDQo+IEFNREdQVV9QVEVfU1lTVEVNIGFuZCByZXR1
cm4gZWFybHkuIFBURV9WQUxJRCBpcyBuZWVkZWQgc28gdGhlIEdQVQ0KPiB0cmVhdHMgdGhlIHJl
bWFwIHBhZ2UgYXMgYSByZWFsLCB1c2FibGUgbWFwcGluZywgYW5kIFBURV9TWVNURU0gbWFya3Mg
aXQgYXMNCj4gc3lzdGVtL0lPIG1lbW9yeSBpbnN0ZWFkIG9mIFZSQU0uIFJldHVybmluZyBlYXJs
eSBtYWtlcyBzdXJlIHdlIGRvIG5vdCB0b3VjaA0KPiB0dG0gb3IgdHRtLT5zZywgd2hpY2ggYXJl
IG5vdCB2YWxpZCBmb3IgdGhpcyBzcGVjaWFsIEJPIGFuZCBwcmV2aW91c2x5IGNhdXNlZCBhDQo+
IE5VTEwgcG9pbnRlciBjcmFzaC4NCj4NCj4gRml4ZXM6IGQ3MTZiM2EyZGYxYiAoImRybS9hbWRn
cHU6IEltcGxlbWVudCBUVE0gaGFuZGxpbmcgZm9yIE1NSU9fUkVNQVANCj4gcGxhY2VtZW50IikN
Cj4gQ2M6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiBDYzogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNo
YW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAxNCArKysrKysrKysrKystLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gaW5kZXggODRmOWQ1YTU3
ZDAzLi4wZTdhNjMxYTkwODEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMNCj4gQEAgLTEzMTksMTMgKzEzMTksMjMgQEAgdWludDY0X3QgYW1kZ3B1X3R0bV90
dF9wZGVfZmxhZ3Moc3RydWN0IHR0bV90dCAqdHRtLA0KPiBzdHJ1Y3QgdHRtX3Jlc291cmNlICpt
ZW0pICB7DQo+ICAgICAgIHVpbnQ2NF90IGZsYWdzID0gMDsNCj4NCj4gKyAgICAgLyoNCj4gKyAg
ICAgICogTU1JT19SRU1BUCBpcyBhIHNwZWNpYWwgSU8gcGFnZSBiYWNrZWQgYnkgdGhlIGRldmlj
ZSdzIHJlbWFwIEJBUg0KPiArICAgICAgKiAoYWRldi0+cm1taW9fcmVtYXAuYnVzX2FkZHIpLiBU
aGVyZSBpcyBubyBtZWFuaW5nZnVsIHR0bV90dC9zZw0KPiArICAgICAgKiBiZWhpbmQgaXQsIHNv
IGRvIE5PVCB0b3VjaCB0dG0tPnNnIGhlcmUuIEp1c3QgdHJlYXQgaXQgYXMNCj4gKyAgICAgICog
U1lTVEVNIC8gSU8gbWVtb3J5IGFuZCBiYWlsIG91dC4NCj4gKyAgICAgICovDQo+ICsgICAgIGlm
IChtZW0gJiYgbWVtLT5tZW1fdHlwZSA9PSBBTURHUFVfUExfTU1JT19SRU1BUCkgew0KPiArICAg
ICAgICAgICAgIGZsYWdzIHw9IEFNREdQVV9QVEVfVkFMSUQgfCBBTURHUFVfUFRFX1NZU1RFTTsN
Cj4gKyAgICAgICAgICAgICByZXR1cm4gZmxhZ3M7DQo+ICsgICAgIH0NCj4gKw0KPiAgICAgICBp
ZiAobWVtICYmIG1lbS0+bWVtX3R5cGUgIT0gVFRNX1BMX1NZU1RFTSkNCj4gICAgICAgICAgICAg
ICBmbGFncyB8PSBBTURHUFVfUFRFX1ZBTElEOw0KPg0KPiAgICAgICBpZiAobWVtICYmIChtZW0t
Pm1lbV90eXBlID09IFRUTV9QTF9UVCB8fA0KPiAgICAgICAgICAgICAgICAgICBtZW0tPm1lbV90
eXBlID09IEFNREdQVV9QTF9ET09SQkVMTCB8fA0KPiAtICAgICAgICAgICAgICAgICBtZW0tPm1l
bV90eXBlID09IEFNREdQVV9QTF9QUkVFTVBUIHx8DQo+IC0gICAgICAgICAgICAgICAgIG1lbS0+
bWVtX3R5cGUgPT0gQU1ER1BVX1BMX01NSU9fUkVNQVApKSB7DQo+ICsgICAgICAgICAgICAgICAg
IG1lbS0+bWVtX3R5cGUgPT0gQU1ER1BVX1BMX1BSRUVNUFQpKSB7DQo+ICAgICAgICAgICAgICAg
ZmxhZ3MgfD0gQU1ER1BVX1BURV9TWVNURU07DQo+DQo+ICAgICAgICAgICAgICAgaWYgKHR0bS0+
Y2FjaGluZyA9PSB0dG1fY2FjaGVkKQ0KPiAtLQ0KPiAyLjM0LjENCg0K
