Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AE1CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2AA10EAF2;
	Fri,  7 Nov 2025 15:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RW57SMGV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A4C10EAF2
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfdr3O1ROOUEVLnJP+IBQC7b6k2OVFjbiZ1xoeu/r2V9bOyWs9s4XleZrodusqVM+8bVDb4udLAKjPEuLWu336zNHNRutBMkG+XNwr403JxV8kIMfEJ9uOLcBWxrYROIeOeKamuTr9VmlZEOPEtwogyVZJ9QHh9C96fRTmlwgnDK0tjCHpSclryZV047AQsYm2OJR2sWI0CW18sz8WGWdWui72kjR3dxWwrKwob85/A82XvYVkAyybVtcS4iXcbBzcmGM1dlQM0lV6d68Hi0IdJXe/vfvosC/jGM9GKcpmfsI3EiG6QZ0XwZk9pmVmGm0VFDjFS/LaSNLed6OdmvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNCOWihnfZnoG0J7GLEZzfSB1q3a7UxpwcOzMjLh3Q0=;
 b=N5wB4T5ecknMd+YhSdRCeIdHwEIxH6n+PeuecJQnZdTbTsYy1Gn+guCrEDXO0zrrGg/HcOj1oQb8zMoVJHEOKg47VeQGQbH7cZvEKwgI7+SpimMl8+G5nYz5ATyLj5RQ9ctub9kcEPq9W3tz9E0v8OWqMZD/TubywFb2ZU6ulD4c/zRbqHaLs09DDYrzbm2lW57jHDwihtFyH4MUiMdC3qmMSmpDGapPbSlHRWpL4IE5zBVeQ1cFIK7N3zhRSKbomL4YMflbPEYCpv8wsd+U9qHECKqV6fIO5E+REUeML9tDGpDjt/9Bupki29ICayy2dqoRjzOX8gPyNy3Pm9cHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNCOWihnfZnoG0J7GLEZzfSB1q3a7UxpwcOzMjLh3Q0=;
 b=RW57SMGVTeHy0ktrbEU9HNlY+7QdMrjtGEykotmNXUtzNTHR8kC+TP1Z9Zio18BK78HWrMiumoGMn70f/H0STCnGfluc0a8sCnWY1+CwW1Ujx9pl2IWVo3DRzk/jEg4tY8cy9d6l31ab7TRj0q1VayPspZcZ+tysUz6RFLp8X2U=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 15:12:25 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%6]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 15:12:25 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Six, Lancelot"
 <Lancelot.Six@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: relax checks for over allocation of save area
Thread-Topic: [PATCH] drm/amdkfd: relax checks for over allocation of save area
Thread-Index: AQHcT1u/dQtsz1RrTEqbFOWXfMpeULTnSREAgAAG3eA=
Date: Fri, 7 Nov 2025 15:12:24 +0000
Message-ID: <CY8PR12MB7435CB5408C5EA5E1C5EA37585C3A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251106202709.3242005-1-jonathan.kim@amd.com>
 <CADnq5_Oa-WSYpQOJfoHPqacoyPKiK+DrkAr78jkUvT=mB4iN=Q@mail.gmail.com>
In-Reply-To: <CADnq5_Oa-WSYpQOJfoHPqacoyPKiK+DrkAr78jkUvT=mB4iN=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-07T15:11:24.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB7846:EE_
x-ms-office365-filtering-correlation-id: 31ddbd2d-f083-4727-2585-08de1e100e91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cDNrTysyZVhpQU5SZ3drMzN4Z3VGTXljVm53dW1ldFcvUS9EaUZMMExkc0c4?=
 =?utf-8?B?ZGFLdENmMnZkNmpxSE1KVVhuWDhyMTVyb2RvVmlVYS9peVlaOVFhN1UvK2dS?=
 =?utf-8?B?SFRzQVBJbDBhZFZ1K3dsR0wzUzNGMlVTd2R6TG1nM0U3UUsyK29PSml1bmRX?=
 =?utf-8?B?ZUh2amk2VzVEUWVtZ20ySnhtLzZoQS9wL1Jwc0E5VUsrcDZiZ3VTMmxyVHIy?=
 =?utf-8?B?S0lTTmQ1N1ZPaFVCUkNsNEN0dHRwQTEzbTR4Wis0TjVUQW1LaEduQjloMW11?=
 =?utf-8?B?bVBIby8yc1JiaERqNXNLcEdKNE5IdS9EWXFlSEp5dzYrMXV2MzlnYWczVkUr?=
 =?utf-8?B?bEJ0YkNzMUEvcE1xeEE1SXJaS1VmeTFCQTlXTklveUlFTEZrdzNySWtMVWMw?=
 =?utf-8?B?TTczVkc3QTY5NFNPcTR2NWtYQVBmeDRRWitlSWlZSVdNNHNaZC9RY09LTW15?=
 =?utf-8?B?L3Zsd0pWOEtpZ210djdhZGJPaW9yUjkvN1RUSDRCdFN5RS8yNHo1OHdUQ2Js?=
 =?utf-8?B?VWszVTJWeTdTZnNjUVkzd1QxZ3dZUmhRNGJocGZoeTlnT0FYNUl3aE1TRHo4?=
 =?utf-8?B?YnBBM1ZOYnJvaVQyQTVWK09pV0pzb2ZyYllxTHJjMzJ6cHJlZmFuMm5PYU50?=
 =?utf-8?B?N00rNkx6Smd6UUdQcVRwRFN0Wkp0SUFMNllqQWVkQVVNNmpIekh3TjhxbmxI?=
 =?utf-8?B?a3ZvbnhsRHRmTWJvWWoxNUQ0WUtUTHJLMzJLTDlHRVRaNFh1V1NGN1Y2RGJr?=
 =?utf-8?B?Nk5FSFh5V0pQU3VCWUJqY0RGUHNMK0lPZCtrM0FwZ1YxeS9vRjRFZjdadEkr?=
 =?utf-8?B?QmRPTkw0bFFIT3I1S0czeGxZNWpicXFVSzZVYzJiQ3VRZFUzaG0wZGZQUUZY?=
 =?utf-8?B?emI0UlhrYkIwVHBJMWw5WXFuNWRlS3NMM0pERFJTemJBZ2tWNzhMQTN5REUr?=
 =?utf-8?B?OVFGV1d6NnVVUmVRR2YxT3Nnci9paWIwZXRNK1o0ZDdCaFRBZk1CMENaTXpn?=
 =?utf-8?B?ZnhkNmNKK0crK1ZITTMyMHNZYTJaTUlGT2Y3bU9LSEsyZ05CeEFZbWdsMjFm?=
 =?utf-8?B?REpHbFB0NzV0MzJZTVNxaWZhNmNMSXZmSjNwU3BHc2dUalltbG8vYkRyMmw3?=
 =?utf-8?B?bWllNXVzYmJhbXJlL21JWm1GOVg5b1NWczd0Wjc4ayt5bEczUjJSV1VXbFE4?=
 =?utf-8?B?QTAxbk52aGhoeDVWbTI4UUcrd2ZFWDVkcEtNRTBzeDJuem1XdHM0NEY1WU1N?=
 =?utf-8?B?N1FFc1NxY2pSbTJWZ2x4M2NsdzV6a0Q4V0FaVmhoWDNtU2pKemt3RFVOTTk4?=
 =?utf-8?B?NlE2N3pta1ZFTkI5b2dSS29wcTJ5bUdhWTk2eVhWRmMrKzVNVExWaTc3Vyto?=
 =?utf-8?B?Y3J6bHRBNmxrNTJCTkZlQStvMFFtdlhWV0F0bU1YR01WbG9OcDJNZi9tdm1F?=
 =?utf-8?B?VHJZczBHK0drTElEMWJDS3Bmc01KdUI5ekQzdi9uSTAvQkNLb1VvQ0xrZXZ0?=
 =?utf-8?B?TDViOHZjN1dRaytmOWZRUjgySGhvVGM2Y1FjbElkZlpSdngxSzZ6U1Ntb3NQ?=
 =?utf-8?B?VnlsT1J2Yk5TSVplbDY2Qk1zU2IyWGJQTy9TMlFBOFErTEpMb3dvYXBUQk05?=
 =?utf-8?B?SThsVGV5NUZxaGR2WS9CZXlWMHhhQnlPN09uTVBRTE5nZmFsNVIwaEFUc1By?=
 =?utf-8?B?cy9TZm53M3FPdlVVZnhUSmkvSWRGYThSU1czTEt2WnFNU09FSVNMRWJ4YUl6?=
 =?utf-8?B?YVlYRDVvM1hQV01XNkozR1crVUpING8weTgwRVFRTnJFWmFJaVAwUndrZSt4?=
 =?utf-8?B?V0hkcTVFdTIwSHhBTzYzZGNCb05tYTEwdFY2c3FxTVZYckVpVFFjcmUzQkp3?=
 =?utf-8?B?cDN6cFcxd2xrWmVQVU9MeXN5a28zUC9FWWpxMFM5WmdXYTlsaUFwb3MvNmh5?=
 =?utf-8?B?OWdObzczT1piN1cvSVg3M1c4Vnh0WnBhK3ArZ0NUMnZ1d3A0ckJYRDNOVWVR?=
 =?utf-8?B?R0lNb3piNkk1UENTZmErb01YNEtzN1k2NkNjQm4wSmVFVUdjUUozRnRybFda?=
 =?utf-8?Q?5EoCD1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGhES3hDbGNkTnBtRC9BTkw1S1VhUnZiL2RKM2JwTk5SRzJHdHNlSGUvdHda?=
 =?utf-8?B?ck9vbW5yU3BDeXloOURPYXlSNEU2cGVJZ2ZteHhreDhJQU9xdzR6OWQwTkJ3?=
 =?utf-8?B?NXZSd0cyM2FtTVN1QnowK0ljaGN2RW4yMDlwMEpNN2dLQTFTQnRwazZSN2Yz?=
 =?utf-8?B?NktYMHArTzEyRjdlaDgwTWR4bFFwa3FWMVdXVnJuWWRjNFpiZVp6NWI1ekVy?=
 =?utf-8?B?ZC9FVUFXRXBDakpENklvTWx2T0JHNVZLb2EvalBnQXp3b2tER2dZWWY0TUQ4?=
 =?utf-8?B?SXZkeUJIVUVidlRLSVRNR3dkbks0NGdaNmFuSmEyb1Z3M3RSc1NsaXJzS3A1?=
 =?utf-8?B?RzFmOGNvS3Z6VGtFd24wbS9xRzRKQWJzZC9qK3pZQ28xaE1HdDRzVEhMb01u?=
 =?utf-8?B?VStQdVExOFVnMnVMU05oMkpsVi9NT0o3MzMzWFd1ZHlDWlZWRVdYRndJQk04?=
 =?utf-8?B?aGhhZ3FZZ0llYkdZVkM3NnlpUGg1eHNuemxPS0QwZVpBcE1TcjZsNEtIcVNI?=
 =?utf-8?B?RGl4RCtzSkg0eCswZnVLU3FybCtMekd0QnVaTTByS2hYYnhyQ0VhU2ROTSth?=
 =?utf-8?B?My9DKzVncWQxeVpyQmMwU214c1BBUDZ4dVp1eWo1bG5JUEM3SHBORWVyQzdK?=
 =?utf-8?B?cHNrano5Mis3UnEyUzFZbEFSekU4dnFoMWlWREpJQ3l6V1NPTHlNSVJlMm8y?=
 =?utf-8?B?c1ZzcnM0aXFGcHFlVTdTRlpMSEJJMUtwOCthd1kxUHFyR0ZhT3MwRXZvekla?=
 =?utf-8?B?VzJnenVzV0p0cWJIZ1pyVTFCcG9QTkp2bEYzYlovOFZhM3NGeGdVd1FKS2Y4?=
 =?utf-8?B?cEJCYlFZQ1lCeFl5UHprZStlNzhJZFBORnZHQXV2RWRuT2xyYXdRYW1wY29P?=
 =?utf-8?B?SlNNUCtZZ3g4c3FnU0pwTEJMMkpyRllQWlpkaFk3b0VoZmpabHJpRlVCVGdB?=
 =?utf-8?B?anUvUzdEWHFocDJnT3doclA2N1VBSll2NmZYZVgrUnplR2NWcWVtU0g3RU1m?=
 =?utf-8?B?RG53N1N2cWozK214UE5KU2dRMURLbnhoa0VrZUJiNDQ1bE1RTFovWkhpbEQ3?=
 =?utf-8?B?ZklyU29lUEp3SWx6NXNCbHVVZUF2MnhnS1RBWUE4bDJDblNwUTZtOUFNSWpX?=
 =?utf-8?B?cUJUclBxWTlNeG5pdERaK3hsVGlGWnJEb3F6Q1pJUVN5TUdXbHBaMTRlOXE5?=
 =?utf-8?B?Sjlzb2c4NC9wQ2lTSnZHRHFhbTdyWnJRcUNNaXp0eC9CdGtGV2I3dFhQSW1V?=
 =?utf-8?B?aTlTZmEzeHRuNXFGYUVFK09OTHFQbW95a1lRODljNlJPTlIraU4vVEtUMDNo?=
 =?utf-8?B?bFU2ZkZwYmxwb3FkNjJYY2g2RFM4R0hPTko1bitqdGZhcy9sYzJ2THYzTC9O?=
 =?utf-8?B?Mmw1RHpFdnlzWmMwK25kQWQrOUgrTlp3eEx1M2ZhdnBoU0FtcWpJdG02NnVs?=
 =?utf-8?B?dXpHRmQ4UDd3TUU2bUV3ZVVEb05XT2NVeUJJT3VCamE5bGVncUxUTEhrSEs3?=
 =?utf-8?B?blNKRnlHVk9hR1FQT01ycnUrdUwxTnQ4MFFvcENSMnJEc3lJNjJTWVZDdWkr?=
 =?utf-8?B?dTd3aEMweHQ1NVR4a3pvaEI0MU9DbFUveFNMM2l3VFRsNHZkMUtlVGpUZXI2?=
 =?utf-8?B?bnpyVElrUXdOeUt2ZXNjNzk3NmpMWFdJYldVdDdPTGdGVi84UjdMRFVwc2lz?=
 =?utf-8?B?MmphM1NLTEFsT0ttZkQ5M0FvclBUODV1bzJvbTVaeWRLVUcyOCtqc3dOdmRN?=
 =?utf-8?B?ckQ3S2R0aVRTQk1UVW5XTjd5eWhFSU5JQWpkVFUva2FKRTBBM2ZGRkRDV2di?=
 =?utf-8?B?bTdjY2J1aW01TTRCWVZlL0xmYWRXOVdmN1ZDdTQzLzlMUzZCa2srS3RPaTl2?=
 =?utf-8?B?THZzNFhmd1JhalhIMWdtc3E3bG1yNzhIMy9obTNDc2txNlJxOE1CemE3Mm9y?=
 =?utf-8?B?UlZwaCtad0xKc25mU241ZUcyMnVQaCtsYzRQK0xJVWhQeXRXZ2RUc1lIbXFP?=
 =?utf-8?B?YTh2WXpZcUxJdGNDdmNIZXEwT1pEdVlMTXFsOXpSQnByNk1nRHlUajZHODZD?=
 =?utf-8?B?VnNxZks0SC9vL1pyeFcyVGcxTTJJbFFzOUlKSVJFaGFrRWVORTZkcm1WSE9z?=
 =?utf-8?Q?Qoak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ddbd2d-f083-4727-2585-08de1e100e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 15:12:24.5694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qFg+Wizzhnw4w5YTv6zjRa1PNvAWe914GYqLkSJsBvkWdi0666LZRfPXKLMCRxH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciA3
LCAyMDI1IDk6MzYgQU0NCj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29t
Pg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEt1ZWhsaW5nLCBGZWxpeCA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47DQo+IFNpeCwgTGFuY2Vsb3QgPExhbmNlbG90LlNpeEBh
bWQuY29tPjsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1ka2ZkOiByZWxheCBjaGVja3MgZm9yIG92ZXIgYWxsb2NhdGlvbiBv
ZiBzYXZlIGFyZWENCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBh
biBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0
YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBUaHUs
IE5vdiA2LCAyMDI1IGF0IDM6NDbigK9QTSBKb25hdGhhbiBLaW0gPGpvbmF0aGFuLmtpbUBhbWQu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IE92ZXIgYWxsb2NhdGlvbiBvZiBzYXZlIGFyZWEgaXMgbm90
IGZhdGFsLCBvbmx5IHVuZGVyIGFsbG9jYXRpb24gaXMuDQo+ID4gUk9DbSBoYXMgdmFyaW91cyBj
b21wb25lbnRzIHRoYXQgaW5kZXBlbmRlbnRseSBjbGFpbSBhdXRob3JpdHkgb3ZlciBzYXZlDQo+
ID4gYXJlYSBzaXplLg0KPiA+DQo+ID4gVW5sZXNzIEtGRCBkZWNpZGVzIHRvIGNsYWltIHNpbmds
ZSBhdXRob3JpdHksIHJlbGF4IHNpemUgY2hlY2tzIHdpdGggYQ0KPiA+IHdhcm5pbmcgb24gb3Zl
ciBhbGxvY2F0aW9uLg0KPg0KPiBEbyB3ZSB3YW50IGFueSBzb3J0IG9mIHVwcGVyIGxpbWl0Pw0K
DQpNbW0uICBJJ2QgZXhwZWN0IGVhcmx5IGZhaWx1cmUgb24gdW5yZWFzb25hYmxlIHVzZXIgcmVx
dWVzdCBmb3Igb3ZlciBhbGxvY2F0aW9uIGF0IHRoZSBhbGxvY2F0aW9uIHN0YWdlIHByaW9yIHRv
IGFjcXVpcmUgb24gcXVldWUgY3JlYXRlIHN0YWdlIGFuZCBhY3F1aXJlIHNob3VsZCBiZSBib3Vu
ZCB0byB3aGF0IHdhcyByZWdpc3RlcmVkL2FsbG9jYXRlZC4NClNvIEknbSBub3Qgc3VyZSB3aGF0
IGFuIHVwcGVyIGJvdW5kIGFjcXVpcmUgbGltaXQgY2hlY2sgY291bGQgc2VydmUuDQoNCj4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9xdWV1ZS5jIHwg
MTcgKysrKysrKysrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3F1ZXVlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfcXVldWUuYw0KPiA+IGluZGV4IGE2NWM2N2NmNTZmZi4uNDQ4MDQzYmMyOTM3IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9xdWV1ZS5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3F1ZXVlLmMNCj4gPiBAQCAtMjk3LDE2
ICsyOTcsMjEgQEAgaW50IGtmZF9xdWV1ZV9hY3F1aXJlX2J1ZmZlcnMoc3RydWN0DQo+IGtmZF9w
cm9jZXNzX2RldmljZSAqcGRkLCBzdHJ1Y3QgcXVldWVfcHJvcGUNCj4gPiAgICAgICAgICAgICAg
ICAgZ290byBvdXRfZXJyX3VucmVzZXJ2ZTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAg
ICAgaWYgKHByb3BlcnRpZXMtPmN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9zaXplICE9IHRvcG9fZGV2
LQ0KPiA+bm9kZV9wcm9wcy5jd3NyX3NpemUpIHsNCj4gPiAtICAgICAgICAgICAgICAgcHJfZGVi
dWcoInF1ZXVlIGN3c3Igc2l6ZSAweCV4IG5vdCBlcXVhbCB0byBub2RlIGN3c3Igc2l6ZSAweCV4
XG4iLA0KPiA+ICsgICAgICAgaWYgKHByb3BlcnRpZXMtPmN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9z
aXplIDwgdG9wb19kZXYtDQo+ID5ub2RlX3Byb3BzLmN3c3Jfc2l6ZSkgew0KPiA+ICsgICAgICAg
ICAgICAgICBwcl9kZWJ1ZygicXVldWUgY3dzciBzaXplIDB4JXggbm90IHN1ZmZpY2llbnQgZm9y
IG5vZGUgY3dzciBzaXplDQo+IDB4JXhcbiIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
cHJvcGVydGllcy0+Y3R4X3NhdmVfcmVzdG9yZV9hcmVhX3NpemUsDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgdG9wb19kZXYtPm5vZGVfcHJvcHMuY3dzcl9zaXplKTsNCj4gPiAgICAgICAg
ICAgICAgICAgZXJyID0gLUVJTlZBTDsNCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXRfZXJy
X3VucmVzZXJ2ZTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgdG90YWxfY3dzcl9z
aXplID0gKHRvcG9fZGV2LT5ub2RlX3Byb3BzLmN3c3Jfc2l6ZSArIHRvcG9fZGV2LQ0KPiA+bm9k
ZV9wcm9wcy5kZWJ1Z19tZW1vcnlfc2l6ZSkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICogTlVNX1hDQyhwZGQtPmRldi0+eGNjX21hc2spOw0KPiA+ICsgICAgICAgaWYgKHByb3BlcnRp
ZXMtPmN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9zaXplID4gdG9wb19kZXYtDQo+ID5ub2RlX3Byb3Bz
LmN3c3Jfc2l6ZSkNCj4gPiArICAgICAgICAgICAgICAgcHJfd2Fybl9yYXRlbGltaXRlZCgicXVl
dWUgY3dzciBzaXplIDB4JXggZXhjZWVkcyByZWNvbW1lbmRlZA0KPiBub2RlIGN3c3Igc2l6ZSAw
eCV4XG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByb3BlcnRp
ZXMtPmN0eF9zYXZlX3Jlc3RvcmVfYXJlYV9zaXplLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHRvcG9fZGV2LT5ub2RlX3Byb3BzLmN3c3Jfc2l6ZSk7DQo+DQo+IFdl
IGNhbiBwcm9iYWJseSBkcm9wIHRoZSB3YXJuaW5nIGhlcmUuDQoNCkFja2VkLg0KDQpUaGFua3Mu
DQoNCkpvbg0KDQo+DQo+IEFsZXgNCj4NCj4gPiArDQo+ID4gKyAgICAgICB0b3RhbF9jd3NyX3Np
emUgPSAocHJvcGVydGllcy0+Y3R4X3NhdmVfcmVzdG9yZV9hcmVhX3NpemUgKw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgIHRvcG9fZGV2LT5ub2RlX3Byb3BzLmRlYnVnX21lbW9yeV9z
aXplKSAqIE5VTV9YQ0MocGRkLQ0KPiA+ZGV2LT54Y2NfbWFzayk7DQo+ID4gICAgICAgICB0b3Rh
bF9jd3NyX3NpemUgPSBBTElHTih0b3RhbF9jd3NyX3NpemUsIFBBR0VfU0laRSk7DQo+ID4NCj4g
PiAgICAgICAgIGVyciA9IGtmZF9xdWV1ZV9idWZmZXJfZ2V0KHZtLCAodm9pZCAqKXByb3BlcnRp
ZXMtDQo+ID5jdHhfc2F2ZV9yZXN0b3JlX2FyZWFfYWRkcmVzcywNCj4gPiBAQCAtMzUyLDggKzM1
Nyw4IEBAIGludCBrZmRfcXVldWVfcmVsZWFzZV9idWZmZXJzKHN0cnVjdA0KPiBrZmRfcHJvY2Vz
c19kZXZpY2UgKnBkZCwgc3RydWN0IHF1ZXVlX3Byb3BlDQo+ID4gICAgICAgICB0b3BvX2RldiA9
IGtmZF90b3BvbG9neV9kZXZpY2VfYnlfaWQocGRkLT5kZXYtPmlkKTsNCj4gPiAgICAgICAgIGlm
ICghdG9wb19kZXYpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IC0g
ICAgICAgdG90YWxfY3dzcl9zaXplID0gKHRvcG9fZGV2LT5ub2RlX3Byb3BzLmN3c3Jfc2l6ZSAr
IHRvcG9fZGV2LQ0KPiA+bm9kZV9wcm9wcy5kZWJ1Z19tZW1vcnlfc2l6ZSkNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICogTlVNX1hDQyhwZGQtPmRldi0+eGNjX21hc2spOw0KPiA+ICsg
ICAgICAgdG90YWxfY3dzcl9zaXplID0gKHByb3BlcnRpZXMtPmN0eF9zYXZlX3Jlc3RvcmVfYXJl
YV9zaXplICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICB0b3BvX2Rldi0+bm9kZV9w
cm9wcy5kZWJ1Z19tZW1vcnlfc2l6ZSkgKiBOVU1fWENDKHBkZC0NCj4gPmRldi0+eGNjX21hc2sp
Ow0KPiA+ICAgICAgICAgdG90YWxfY3dzcl9zaXplID0gQUxJR04odG90YWxfY3dzcl9zaXplLCBQ
QUdFX1NJWkUpOw0KPiA+DQo+ID4gICAgICAgICBrZmRfcXVldWVfYnVmZmVyX3N2bV9wdXQocGRk
LCBwcm9wZXJ0aWVzLQ0KPiA+Y3R4X3NhdmVfcmVzdG9yZV9hcmVhX2FkZHJlc3MsIHRvdGFsX2N3
c3Jfc2l6ZSk7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
