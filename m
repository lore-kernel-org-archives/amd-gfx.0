Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4BFCCF2EE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 11:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C07410E3FF;
	Mon, 19 Jan 2026 11:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJjQNAJ+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517B310E3FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 11:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcsvjDtlIZgS7u5Etx0f+iWfu2P/M6gjocO3c9IHAaSTCRh/2UAefn2VrYiw64q+UXj/nni31T+fmwG60WcRREgGIRwSqJ+guQbfJquFDhTyOlYLtqrc8uzFe2ML015jNMdE16q5aRyhAWfFwXk2LS4dIdj3tWBU/7oznfecY+U5wt9iLbVoOCZSlkqgXPh3lecFqNyRMarxgAwnC6xrVg8Xvs76ZR39Xuf9lqfKeFFhsqyxDbELDplLqDK7kV/e6Bqo7cWinzBToyLzk9UjzifnYsgmBqCvk9EoEGaee/cdyrgV23fLlpmHna0PLx3sXQ9NgkeJsayE7lrkLofBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/OOHuaX4lGRffTd4ryWmHAEQKQn04xmgv360+Lr2OA=;
 b=iBWy6KakawNGOnwk5+oWLqTjobeHb62jwyYFcQDlWRBIk90K5d41NRrqLFzz1jEJZUc3R+Uc3MNcJYFl4geP9lRkb+EY0Jw1AoWGeHVjT6lD6EfYdoTKuBCL+NVvxZ/sIdnk6wnRX1pxJI8pcLpQyeRgZWqsaIJmuD4a3yR78OXMLHjWTuQulht/7uCSNpiaqKkMCzU/TMPKoc545JH8QGxq2ozyTKuQ1l7fCeQD41i2tAAyzsk8bZHASTl1kXaLp8L/dss9EraH95Dh+pehc7SgK7gL+/5XLT+yGPGnN8d0COkroWdmH2H5HHhCEk7xcQ3DFstTOrGIk9r0EzYWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/OOHuaX4lGRffTd4ryWmHAEQKQn04xmgv360+Lr2OA=;
 b=NJjQNAJ+gLboYRVdTayGa9BmwubfuuoLP7XXSL4KzO/tGNDndnkPPW6JTZ8RJHFd1waIgHOkIY+FdgXzGc7lZxh/TtzQ3rE1pOUgSPR2nZJ+smiUFdXgMCXlNL/dGqWaUbaiiN7+25uckLfVjn4mLvdapX2Zt1o79lOsmHKh8fE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 11:44:48 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 11:44:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Thread-Topic: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Thread-Index: AQHciHoQTQHvCiULiku9PJWO956CHLVYvGTAgAA6LFCAAFZ8AIAAE2rQ
Date: Mon, 19 Jan 2026 11:44:47 +0000
Message-ID: <DS7PR12MB60059B1E06C1F694C06A2DA9FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260118125746.40221-1-timur.kristof@gmail.com>
 <DS7PR12MB6005F0626EDB392DA9F554E3FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005D5AA955F34114114F779FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <c0b8da75-7f89-4fd1-8d98-79f47e2a2f6a@amd.com>
In-Reply-To: <c0b8da75-7f89-4fd1-8d98-79f47e2a2f6a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-19T11:42:53.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN2PR12MB4048:EE_
x-ms-office365-filtering-correlation-id: 72be11d9-c90d-4cf8-4c0e-08de575025fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Uk9hK1R5cnM0enR3TWtmd2NRR1d3dUFpd1poYk5NMTZPVXdwNjFUaXpEK0Jr?=
 =?utf-8?B?YklZUndFZXBmVWZxM21TNUhsWW9xaG5mV2k0MEdaT2k1SEhnWG9ubVJJeTdp?=
 =?utf-8?B?M1VRWnRWZ2Rsb1hKejNJYnVGMmo5NWMyRVdOQUhkSnRlY1BIcE4wK2Vvb210?=
 =?utf-8?B?d3lYS2c5UnVGZzJvL2Y0Q3lSZ1phWGk0OEVWbXNhYlFndVM2WlRZVzRGZDRI?=
 =?utf-8?B?LzlFVnBYT2VOTTYwRjVRVTVQaUJWY2R2WjFNSGpVTHNmT2p2ajd4Q1pFb1Na?=
 =?utf-8?B?V3RGQ0FPMDEwTGpNK09iOU5GVDZzVGMrdWVJVHIwM3FhME11M3VvR05raXBi?=
 =?utf-8?B?eE8wbkxaK2h5Y0xxVlk5aTNNbkh3c3I2eGQ3bTFBWTBjdUxQdmlYcnBJdjJn?=
 =?utf-8?B?ZmFJVzBHdFBKK0V2N2hvZmZhYmVwcFVHanFCMUJjUEgyVjJTSXQyNzFvTENi?=
 =?utf-8?B?ZVJxYU1pOWhlZFR5VmJ0UG9YNE14SG93RytCRlJJRDJaWEtkUU5GQytmMEhG?=
 =?utf-8?B?YUNFR2VGcGlraitFNmFHOVdrck8vckxoemY4S2s0b3FiZ3dVVklpRWk3S3NI?=
 =?utf-8?B?QUtWVmE5Zm1tZ0MycjZkcnhTekp6MHkzcC8vNU9pQzAwZEVYVUdic2k2K1Z3?=
 =?utf-8?B?bjJzdWxma09Ja1dxTkV3RVRteml1ZGFHQVdsQUFERXI0dHVGbUc0cUh4YWtk?=
 =?utf-8?B?STUzeTQ5blBsOWphalkvZFFha0Y4STJJNlhFZDZlVklLSTJSM0JzRHloSTY3?=
 =?utf-8?B?UGFxanFZSVp0SS9jRlZRRm1FZlo1ZmZrSFU3NG5ZV3ZBMHdobXBBSjd2L3A2?=
 =?utf-8?B?SGU2aHFGdnNpN2szaTZ0R3BiaTV0dWJIM3BWaWdadU0rczhWZXI5RWg3VFUr?=
 =?utf-8?B?RFVGZGo4RGtac3B2VmZTUEpCU3A4UStHam1BSVlCUHZtL3Z5My81QnNkako5?=
 =?utf-8?B?MVZFYXUrWVVKNkRISEw4RTZYTGxFSjZOVG9GVFVxazNMbmkrVCtYWkFpMlc2?=
 =?utf-8?B?d3Axb1Vzd0xIRXZvUDRxVFNXdTQ5WUV4TzZMV0h6MnNkeGFrZVFhRnA2SDNB?=
 =?utf-8?B?aFl0Skk1c3ovekk0dVlwcmRKQ3l5UngyQ09Jcnc0WE1wMFp2MS8vVk01SVp0?=
 =?utf-8?B?dGxONzExcEJNZ1o2d3VDUEx2QVpMdFNBMngxdzRIaFIzRmJxUEhsNVVpd2tq?=
 =?utf-8?B?QVB6amJwWkpydTVFZjd0T2xvdlM4VzlmTGZlVGloTWZtaEV5SGlxeHZLMndW?=
 =?utf-8?B?ZDdsOXlVUDdEdjI4K2VLVFdxWFl5WGdYTnBEeWFqVnIvdU41TFJyT3NrVGlu?=
 =?utf-8?B?UUNRcWdLVmJ1OFVxejIvYndvY1FEWEhOUnplOWQrR24wSGk3S2pIQ1V4OVk2?=
 =?utf-8?B?MDRUbUx4MlZDU3g5bE1BL3BTTUc3MGZINkNVdWhKOHo4czI5MEVIN0ZKSVRK?=
 =?utf-8?B?UzZvV0xZSW5GYWtrNzVSbU1PYmd0ajhUUVFsc09LYWJMeXRGNHRWSU5BWmE0?=
 =?utf-8?B?U1AvYytpZVdwN0s3U2hsWmc3Unh5VC9xakpsODJialMzdisvSk11N0ozb1BU?=
 =?utf-8?B?SmNVeCt5U0d1RitHYVRmVHBJQnpzaUd1Vm5BZHN5ODgvemVyUGU0ZHhQbWdI?=
 =?utf-8?B?UDhSamU1YUt1bDlXYlFibERGdVRhZlc1YUNCVDZnRHhaT0t1Tm1zcTYyN0gx?=
 =?utf-8?B?WGUyOW5YcmM5b0IxaGZ4UU9GTWYvM2hJOU0yN29EZGIrRGJQYWVXNElGZmNL?=
 =?utf-8?B?S01NaVk1dUpSTWNkNTlxTjZNZ0Z6UmJQcktJelhZTWhyR1dOOUtaK2FTSHoz?=
 =?utf-8?B?aEVyVlJscGpFTzhkM2VmazhmQjY1WEN2aXZGaFpsOVVoSXdFdG9pNjhKMkZy?=
 =?utf-8?B?czY5TExzTW9NV3VVN2xrVVdiV1ZEZG9nRGZwWTNpblNZaDlxMWF5WVJnTTQv?=
 =?utf-8?B?Ylh6NVNzbWRidnhOVUdYT0RoU3BPR2pHSjhVYUJOWDcrZVYwM2tDTk5nNkt1?=
 =?utf-8?B?eTUzb2Q0bTVKYmNoSXNiV3dsK0pQNnpOUFNrQ2FSMU5sY25PKzBnQVFyc25T?=
 =?utf-8?B?UEFlTjBWd04rakFUbTJiM3VUSG01elg3ZjZaeU04WFo1L2FHdUJDajhPdUVR?=
 =?utf-8?B?QUpDeHY3b1V0eGF5NWh5dU45ZlNTMVUrV211VFNjR3JVVG5WUlM5RnJiaWZQ?=
 =?utf-8?Q?jMwHip9LL++jSjQ9Fo50PQE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZENOQ2YwUmNqbUp0d1pxWENhV3phamRZRDBSMFBzdUdBdGMwTjVjdEp1bWtI?=
 =?utf-8?B?ZDB1SE1lTU9FT3JoK0JBclpuSHRyaElOdjFNOWJtOEpiM3BNZEFFMGM5SUsv?=
 =?utf-8?B?YWNIR1hLazlEbHFkTmM0SGIxbEhNV1lQNUNuUG5NRnFoK1NhVUpodUloUUdW?=
 =?utf-8?B?WGphVktDeFZyS2U0aGpoMCtRbEgrTGVpaDVnVTRMQVg5VFpUZmlnMVNjRjBK?=
 =?utf-8?B?Wnc5L3QrTFZSbFJzaVZDWStWSDJBLzVCaHdhK3ZlaWNxRlg0TE9lNDRGZHlo?=
 =?utf-8?B?eUhveVpyeTc5d3R1MmlybGJLNDlLOFBGc0ZCcDUyRUVNNDMrU0s4dVh1RGtW?=
 =?utf-8?B?Q0dIMkE2VnFIQ2FKa3E2cVJVU1BGY0hFWUphaFUwRXZiREw3RUcyN2xOTHU3?=
 =?utf-8?B?MVZ4L05FaVZDajFUMGJiNnJMeWJKWFF0OUFscUUrOVpzcXJjWEFqLzN6eUF2?=
 =?utf-8?B?cHNPbm9yYTJoeCtNRXVPWldOWGQzU3JtS3hkSmY2WjdReXd2WFo2eWozYVFV?=
 =?utf-8?B?Z1NLWnordDFtYjkvSjBETmUra0toMVRoWnltd3JPZTIwQ1IrL2QxM3ZCWC9z?=
 =?utf-8?B?MlFGeHZId0QxUUNBYzVLOUFXa0lRLzlvQmVYaC9KODU0azNGQkRSNytTYXI3?=
 =?utf-8?B?Z0tKUXEzRno3a3lUZVE2dGJLYWJsVzd0d0NBM3JvL1JnSElaY2tRL3U3enhq?=
 =?utf-8?B?QkFkNzFJR01YeVFhanZYNy9OMHRmdVBwbWpabHpKTU5sd2hTY1pPdzB2cUV6?=
 =?utf-8?B?RVdnYStKajEyTmQvNEVqeFlWaVloODh3S2pzK0U5U1Bla0N0aDlqRHF6ZXlo?=
 =?utf-8?B?RFY5WElKVTlGN1NUcmU5SWlweng3MUVHcFcxZ04xMEw3UFFZajhlcnFZZlZl?=
 =?utf-8?B?TVRqMTlqN2pxOW1oa1FoNUlmMmV3WFk0Y2JGNUR6Z0N5V05XdEhiZ0Y1YmUv?=
 =?utf-8?B?eTVoSWxnZ3laTHE2Qnd3T2RXa0NKT2lnY2J4RFU1WU1lNWk4SUtsYUhIM1hQ?=
 =?utf-8?B?QTY4WW9JWEhtdGhEZTJ5ZmNNWEFhRG5OWlZSaUNjdGtidVlCOWJ0VVZaZmNR?=
 =?utf-8?B?VFhWOVZOVVZkQ0FBRllVRXM4c2VvTTBodURsWVZQYm9za2JtbHQ1Z0hTRjN3?=
 =?utf-8?B?V0I4Uys1b0ZrQ3BIdmJaazNZekdWbGRmSk5GSVQ2YU1aZCthMjZlVm9iOWtE?=
 =?utf-8?B?OXlkSFpkek16dTFJc21KamRDdExkcnV0TkFpc2QxSEZaQm41MFdXQ1hyREQr?=
 =?utf-8?B?UWI5K0cyWHd2NG9ndk9kWDgxRDRJZlVKaXBaLzByTEFSUTRDWnNFdmpxTFRL?=
 =?utf-8?B?ZlllbGRlODFadm8vd1hXVXdrd0UzbDF6MHpKZ2E5OGhENkduaEZURUFPRmVO?=
 =?utf-8?B?N2tXREsxSTdpMU00NWFaZ2tVK2htbURWVnk5ZHl3aEFycElDaXBNTlJFMGt2?=
 =?utf-8?B?QW1CRnJlald6em1WSnEzdll5RGFObGRDU1RjdkFVNjZkSkorSEl6Uy9vY0o2?=
 =?utf-8?B?WHZlMWtmeDZDZFhNSnhKMHBVNU1rSERqVlZkRnRMaUZCbWg3RE9jUWg5YVNV?=
 =?utf-8?B?NFA1NlFjOE1YUUhPOTlVSUFHMUpwb1NZV1k5UE5OZUJ5emNJcmpMZE1iNU9p?=
 =?utf-8?B?SnYzTm5qNHZCYW1LQ0RSWkVNOFRsMk96UC82dTVoVlRsZWRMYzYrL0VmbUY5?=
 =?utf-8?B?RXVlc2NHUytxSldIWWllc1RMVnZ6ZDNaZ3FmelhzTWs0QTNBSktkM2ZsSDgy?=
 =?utf-8?B?ekRnTDEwTUtuYTVXaFFwWlg5VFZiTHJKWEloVGoxYTU0b2w4VGFzMUgzK1Uv?=
 =?utf-8?B?eXhzOTN3SjZoUDdVcWhWRTlsUHdPam5UT3FEZGx5d1lGZUNXTlV5Y2tnRTcy?=
 =?utf-8?B?Z1pNNGJjSGxDYlhWQXpEYkFQQk9QemN0RWNZbTZlY3NKTFV0dS9EbGtHL0Vy?=
 =?utf-8?B?RVlNK3c3a20rdWdUQjNOeFpTQmRSWHVVdGtJR0NxQTA3L2oyQUQ1eVVBSmgz?=
 =?utf-8?B?TG42eG9YY3craG9QVk01T2VQL09NbzVBS3ljREllT1VsMk05RmdyZ0pDbkZw?=
 =?utf-8?B?WW5VQTd1SGE5V0xtam1kcmwzN2xzQTBkbnlIUHl2dmxpM2RlL002cGZLYWRm?=
 =?utf-8?B?a0JLR1ZmcW56c3czVGM4aTY0RUFKRGIxUDBNZ1FRU1MwYkY5U3YrVndTdTFZ?=
 =?utf-8?B?VVgyQk9UZmpXR3RQaU9SUlRmcHZiNCs3L0ZjWjcyQW1GenEyemN0dExPWHp0?=
 =?utf-8?B?djltVnVyOXpVdFI4d0FuQ0tOS3FZZlZ2QncxSFlId2FpcWtBREg1N01JN0Z6?=
 =?utf-8?Q?lolshDeO3RdTSePO/s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72be11d9-c90d-4cf8-4c0e-08de575025fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 11:44:47.9007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqufGV3z1RPktZVvmjbMCOKTbxsIyJYIzWkW4Ecw0v6yAy8UpFCss3vOsLo5yUXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE5LCAyMDI2IDY6MzMgUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5r
cmlzdG9mQGdtYWlsLmNvbT47DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVj
aGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNpZWxs
bywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBEYW4gQ2FycGVudGVyIDxk
YW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHU6IEZpeCB2YWxpZGF0aW5nIGZsdXNoX2dwdV90bGJfcGFzaWQoKQ0KPg0KPiBPbiAxLzE5LzI2
IDA2OjI3LCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+IEluIG9y
ZGVyIHRvIGF2b2lkIGJlaW5nIGJsb2NrZWQgYnkgdGhlIGxvY2sgaXNzdWUgb24gc29tZSBvbGRl
ciBHRlgsIEkgd2lsbCBwdXNoDQo+IHRoZSBwYXRjaCB0byBhbWQtc3RhZ2luZy1kcm0tbmV4dC4N
Cj4gPiBJZiB5b3UgaGF2ZSBhbnkgY29uY2VybnMsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4NCj4g
SSBvbmx5IGhhZCBhIGNvZGluZyBzdHlsZSBjb21tZW50IG9uIHRoZSBwYXRjaCBhbmQgYWxzbyBn
YXZlIG15IHJiIHdpdGggdGhhdCBhcw0KPiB3ZWxsLg0KPg0KPiBTbyBpZiB5b3UgaGF2ZW4ndCBw
dXNoZWQgaXQgeWV0IHBsZWFzZSBmaXggd2hhdCBJJ3ZlIHBvaW50ZWQgb3V0LiBPdGhlcndpc2Ug
aXQgaXMgbm90DQo+IG11Y2ggb2YgYW4gaXNzdWUuDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlh
bi4NClRoZSBwYXRjaCBpcyBzdGlsbCBydW5uaW5nIGluIHRoZSBDSSBwaXBlbGluZS4gSeKAmWxs
IHJldmlzZSBpdCB0byBpbXByb3ZlIHRoZSBwYXRjaCBzdHlsZS4NCj4gPg0KPiA+IFJlZ2FyZHMs
DQo+ID4gICAgICAgUHJpa2UNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PiBPbiBCZWhhbGYgT2YNCj4gPj4gTGlhbmcsIFByaWtlDQo+ID4+IFNlbnQ6IE1vbmRheSwgSmFu
dWFyeSAxOSwgMjAyNiA5OjU4IEFNDQo+ID4+IFRvOiBUaW11ciBLcmlzdMOzZiA8dGltdXIua3Jp
c3RvZkBnbWFpbC5jb20+Ow0KPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1
Y2hlciwgQWxleGFuZGVyDQo+ID4+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmln
LCBDaHJpc3RpYW4NCj4gPj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExpbW9uY2llbGxv
LCBNYXJpbw0KPiA+PiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IERhbiBDYXJwZW50ZXIg
PGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gPj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogRml4IHZhbGlkYXRpbmcgZmx1c2hfZ3B1X3RsYl9wYXNpZCgpDQo+ID4+DQo+ID4+
IFtQdWJsaWNdDQo+ID4+DQo+ID4+IFRoYW5rIHlvdSBmb3IgdGhlIGZpeC4gQ291bGQgeW91IHBs
ZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0aGUgdGFncz8NCj4gPj4NCj4gPj4gfCBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4+IHwgUmVwb3J0ZWQtYnk6
IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gPj4gfCBDbG9zZXM6
DQo+ID4+IHwgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDExOTAxMjEuejlDMHVtbDUt
bGtwQGludGVsLmNvbS8NCj4gPj4NCj4gPj4gUmV2aWV3ZWQtYnk6IFByaWtlIExpYW5nIDxQcmlr
ZS5MaWFuZ0BhbWQuY29tPg0KPiA+Pg0KPiA+PiBSZWdhcmRzLA0KPiA+PiAgICAgICBQcmlrZQ0K
PiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206IFRpbXVy
IEtyaXN0w7NmIDx0aW11ci5rcmlzdG9mQGdtYWlsLmNvbT4NCj4gPj4+IFNlbnQ6IFN1bmRheSwg
SmFudWFyeSAxOCwgMjAyNiA4OjU4IFBNDQo+ID4+PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA+Pj4gPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA+Pj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT47IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47DQo+ID4+PiBMaW1vbmNpZWxs
bywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4+PiBDYzogVGltdXIgS3Jp
c3TDs2YgPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPg0KPiA+Pj4gU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBGaXggdmFsaWRhdGluZyBmbHVzaF9ncHVfdGxiX3Bhc2lkKCkNCj4gPj4+DQo+
ID4+PiBXaGVuIGEgZnVuY3Rpb24gaG9sZHMgYSBsb2NrIGFuZCB3ZSByZXR1cm4gd2l0aG91dCB1
bmxvY2tpbmcgaXQsIGl0DQo+ID4+PiBkZWFkbG9ja3MgdGhlIGtlcm5lbC4gV2Ugc2hvdWxkIGFs
d2F5cyB1bmxvY2sgYmVmb3JlIHJldHVybmluZy4NCj4gPj4+DQo+ID4+PiBUaGlzIGNvbW1pdCBm
aXhlcyBzdXNwZW5kL3Jlc3VtZSBvbiBTSS4NCj4gPj4+IFRlc3RlZCBvbiB0d28gVGFoaXRpIEdQ
VXM6IEZpcmVQcm8gVzkwMDAgYW5kIFI5IDI4MFguDQo+ID4+Pg0KPiA+Pj4gRml4ZXM6IGJjMmRl
YTMwMDM4YSAoImRybS9hbWRncHU6IHZhbGlkYXRlIHRoZQ0KPiA+Pj4gZmx1c2hfZ3B1X3RsYl9w
YXNpZCgpIikNCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFRpbXVyIEtyaXN0w7NmIDx0aW11ci5rcmlz
dG9mQGdtYWlsLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYyB8IDUgKystLS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQo+ID4+PiBpbmRleCAwZTY3ZmE0MzM4ZmYuLjRm
YTI0YmUxYmY0NSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nbWMuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5jDQo+ID4+PiBAQCAtNzY5LDcgKzc2OSw3IEBAIGludCBhbWRncHVfZ21jX2ZsdXNo
X2dwdV90bGJfcGFzaWQoc3RydWN0DQo+ID4+PiBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MTZf
dCBwYXNpZCwNCj4gPj4+ICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICZhZGV2LT5n
Zngua2lxW2luc3RdLnJpbmc7DQo+ID4+PiAgICAgICBzdHJ1Y3QgYW1kZ3B1X2tpcSAqa2lxID0g
JmFkZXYtPmdmeC5raXFbaW5zdF07DQo+ID4+PiAgICAgICB1bnNpZ25lZCBpbnQgbmR3Ow0KPiA+
Pj4gLSAgICAgaW50IHIsIGNudCA9IDA7DQo+ID4+PiArICAgICBpbnQgciA9IDAsIGNudCA9IDA7
DQo+ID4+PiAgICAgICB1aW50MzJfdCBzZXE7DQo+ID4+Pg0KPiA+Pj4gICAgICAgLyoNCj4gPj4+
IEBAIC03ODIsNyArNzgyLDcgQEAgaW50IGFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYl9wYXNpZChz
dHJ1Y3QNCj4gPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90IHBhc2lkLA0KPiA+Pj4g
ICAgICAgaWYgKCFhZGV2LT5nbWMuZmx1c2hfcGFzaWRfdXNlc19raXEgfHwgIXJpbmctPnNjaGVk
LnJlYWR5KSB7DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgICBpZiAoIWFkZXYtPmdtYy5nbWNf
ZnVuY3MtPmZsdXNoX2dwdV90bGJfcGFzaWQpDQo+ID4+PiAtICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJvcl91bmxvY2tf
cmVzZXQ7DQo+ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgICBpZiAoYWRldi0+Z21jLmZsdXNoX3Rs
Yl9uZWVkc19leHRyYV90eXBlXzIpDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+
Z21jLmdtY19mdW5jcy0+Zmx1c2hfZ3B1X3RsYl9wYXNpZChhZGV2LA0KPiA+Pj4gcGFzaWQsIEBA
IC03OTcsNyArNzk3LDYgQEAgaW50IGFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1
Y3QNCj4gPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90IHBhc2lkLA0KPiA+Pj4gICAg
ICAgICAgICAgICBhZGV2LT5nbWMuZ21jX2Z1bmNzLT5mbHVzaF9ncHVfdGxiX3Bhc2lkKGFkZXYs
IHBhc2lkLA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGZsdXNoX3R5cGUsIGFsbF9odWIsDQo+ID4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5zdCk7DQo+ID4+PiAtICAg
ICAgICAgICAgIHIgPSAwOw0KPiA+Pj4gICAgICAgfSBlbHNlIHsNCj4gPj4+ICAgICAgICAgICAg
ICAgLyogMiBkd29yZHMgZmx1c2ggKyA4IGR3b3JkcyBmZW5jZSAqLw0KPiA+Pj4gICAgICAgICAg
ICAgICBuZHcgPSBraXEtPnBtZi0+aW52YWxpZGF0ZV90bGJzX3NpemUgKyA4Ow0KPiA+Pj4gLS0N
Cj4gPj4+IDIuNTIuMA0KPiA+DQoNCg==
