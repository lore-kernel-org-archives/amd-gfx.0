Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534A2CCD184
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07EB10E259;
	Wed, 15 Oct 2025 02:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X4JjkBj7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013039.outbound.protection.outlook.com
 [40.107.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E09E10E259
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+67HMWPMUgXndVws6G3V50gdBdPRB2+vc+MtKiZ1UYvSplnsfyJJW0H2O1X7Fx9HPD0QWXRsgUAl/83rvXcP+M7/VEKf8ZEDe/gQt6ifZ9tmstEOmLYMhV55oXoeSgMS+P6ATXKP8Mxlf4tYWF3hkjUkou844l1xdApMpBK8QHl6GrgXwQes32lxFUdEVnswz8KPihY4ab2dKsdqHrm7Elzz9mW1u6T3twbL10dbuJtRkk/FKkOOlB7b31eO7XQ16HKhhAHWk/XZqK8AguvntZ58qD2huLiVvyxrgpbs+1aBE2k8Qcy+OYjZnqmmIEiJ00ikTiVyAqRb4PeoNdYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCaQXlYRl7BHFQ7v4neSSV27Du79ZiPQKPYbEtuTTZU=;
 b=Tpcp6NN7kInI5JcqJUZy6sBumMpi6ozDTfECz6qiHBNKBbavfsDaZj5G2GyX6TBAFECCcIWXWJt9rQTo+IE1vTmTjJN7XftFhh40J5yVjccI3ES4+E/uuDmwCpPj4e0bkSF1D75F2WsuNzpuLgZAJirYgTJRMZ6evKkW06KqMDSA61VcsSqKgxTzUa6OtTHSxgy0LfD0dqIgKvhuEBdomeT0mPXejookoNOuzAQ52ykd6iYZQZjGZ4TdvhXFCLkvhLLkg/Vuegm+Zo60MeXogr/IvFTbNdI/dVgyT89vwtcGPmknC69nXqtTlouTxuFrVzDIszdNwQjRCvjhuiyAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCaQXlYRl7BHFQ7v4neSSV27Du79ZiPQKPYbEtuTTZU=;
 b=X4JjkBj7xkhH/H8NwhW25GrxDdjjECYDAGRWTYW547IwtJp9xxA30/+dXJeAcXQ13dp8oyBi4JJg0KX9bUosC2kLCD8RZqprrafMd6Mp2OA21BInwY4KT2XquXPl6zUL/bgJfRuwSHs1dZYdwgC8PaP0iEe73xKMSJJ4ajECR2Q=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 02:26:35 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 02:26:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, "Gallo, Luca" <Luca.Gallo@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, amd-gfx mailing list
 <amd-gfx@lists.freedesktop.org>, "Olsak, Marek" <Marek.Olsak@amd.com>, "Mohan
 Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Subject: RE: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
Thread-Topic: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
Thread-Index: AQHcOisPMXDdFlg2wU2Chk8Ev6rOWrS/yPAwgABRsACAAAlEIIAAAjwAgAESpYCAAHvjAIAAEHcAgAAYPACAABnkAIAACwkAgAB9pOA=
Date: Wed, 15 Oct 2025 02:26:34 +0000
Message-ID: <DS7PR12MB60059E36FE1D33E61F320709FBE8A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
 <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
 <CAAxE2A4vJtdP=L8qn5mBo+yNTuzwA__XRZZ7+ftSVe443V7Qiw@mail.gmail.com>
 <CADnq5_OTK_sVzANY0-aRzxXpiU77Q6Hrpo5i_h1k1S6yK9eXSw@mail.gmail.com>
 <CAAxE2A7oQfw79nUgAFo9r=6q28-9RPUJa3Lr2OA2VXWcAKG8wA@mail.gmail.com>
 <CADnq5_PAEcKdCTiBz4aOAD7492KSCC+GcKgj_ZbsAC2yrs0LJw@mail.gmail.com>
 <CAAxE2A6G2uB=S8FQ7-cEO0vYc+bppa=fjEG0BHyzHivEG8FCBA@mail.gmail.com>
 <CADnq5_Nmq7E7UaPV6o=i0vhy-WmfgE1EG+NDs=Fstyi1sRDT=Q@mail.gmail.com>
In-Reply-To: <CADnq5_Nmq7E7UaPV6o=i0vhy-WmfgE1EG+NDs=Fstyi1sRDT=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Luca.Gallo@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-15T02:19:38.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA3PR12MB9227:EE_
x-ms-office365-filtering-correlation-id: bdddde0c-5f9d-4e78-272f-08de0b924301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L2Q0ZFMzY0ljK08rVk9DS2dFWHpOLy96d2lqc3AwajU0UzUzb0pTNTl4Rnox?=
 =?utf-8?B?bXNNM1ZCVWdrc0VEQ2g0QnJOU25hdS81a3pwMC9QdlVpTjVIZTIxR2dnV2dB?=
 =?utf-8?B?VnpFVlo2VzJFeVFzNTE3ODYybnBqLzFDaFhlNUlKNjVvR3hjaXpBS0ZxUDN0?=
 =?utf-8?B?Tk0xZnd4ZmhhSnlRYkZuRnp5MkJ3WGNXOWU2YTJReGRsZWkyVFJLV2gxR2JP?=
 =?utf-8?B?eC8yY0NMcUx0ZWIrUk83VDNSK3hzek1lcXRmU3QxMmVHa0lpOWJEUEthQzkz?=
 =?utf-8?B?ek16SkM3YTFmaDlaNGFYaEdDSGJtLzlsK2FGWnUyLy9mUDdOS1k5dHVPOEVO?=
 =?utf-8?B?d29EWUV2UWVLWU5UVExHb3I2SFdUd0FVUHQyVmZySUErb0dJUzB2N2JFY3JK?=
 =?utf-8?B?cUhYdDVDd2puZENjcHNiWDhTMzNwWXJGRXdiYjJjWUxtZ1dCNktJekc3WlZG?=
 =?utf-8?B?YVk0SndKNE9hSVRHM2ZobFJGeXlQeElhclRuUTIzVVVEdldHb1NHcHF3RzN1?=
 =?utf-8?B?VlFrRHhSL2NIRWYrNHkyTVZ2bXF2SSt3ZTJoOWdLS3JrVzFnZk1DdGF4YlFI?=
 =?utf-8?B?L2s2WFBwZDAyQ0hNZmc2NHExY2tvVlF5bFMwQ0V0YURXRzVZNVhwZlQ0dVlh?=
 =?utf-8?B?NHh5YkJGM3BZcXc5dG9GcXpLc0dldGcwQUJOZG0yalZRWjNxaWxFQTVLVWg2?=
 =?utf-8?B?VTlyZUdUTkpCdjBjN1RkVSs1RllVRlFZYTR2Mk5Nc2dnL09IS1NIcm8xRzgw?=
 =?utf-8?B?Q3k1dkN6TTJGU1ZRK0NVbFhxUCtWZVVVYWRQUjlpVU53VlNMenVkaC8wMng1?=
 =?utf-8?B?TnBwaXZwUVVZMkRZeUZyVjlMZElMdVNocHB6NFpGMTRCRmMreEx3ZkJ1S1Qv?=
 =?utf-8?B?aDZnRU5VNjNJQklYZTBPL0RIb3JzVVk2MUJvNGhRNHIwa0MvSy9scHJPT2dV?=
 =?utf-8?B?Tk8ySXEvdUFUemVyRGdBdFFvdnVaQ292MU9rdzdCK2IwUUs2NGh5c3pDV1l5?=
 =?utf-8?B?RTJHNnlEaTZZZGpsaS9BZGoyR1F5M1FJbGVod3UyWmN1MGk2SGRzYTFLWFli?=
 =?utf-8?B?SUdKWGd4WmFiMFhLWEFOdklvR1Mrdlg4MkpuSjFmcFZldEFLK1NvSnBpcVZL?=
 =?utf-8?B?bWsvc1dFbGszbFBQQ0VjZVZydkZNOG0rNE8wY0FiMis4Q1QwVXM1bEw1bE1z?=
 =?utf-8?B?WDdvUk9nc1Z3NDBmdXQ1cStCemQzTnU0Mkt0Q0FKdjE0ZWk1NFhKSk9GMzZE?=
 =?utf-8?B?M2IydmJkL1hSZVRNb0pPTlFTSkJBRE5iTUhMLzd5WFlVRXJUZ1dpSXZ5dUh4?=
 =?utf-8?B?d1g0Q2h6aFQ0eEdSQ3VTTzlwTDY3MlVKUHdkM1FtaVNpUVRGMDZ3bWdsSzlZ?=
 =?utf-8?B?R1R3OGprQUZLOEhGSEVjNjZqVW9NcE9YejVCSm9PYXAxWVYrajN0dkFQZEM0?=
 =?utf-8?B?V3QzMm1aZVlyaThTU0lMb0QvamZhYmdSZlUxeDFmR3Q3L1cweU9hVDFOTS9I?=
 =?utf-8?B?czdxYm9lNWsvcWtwSVRXMmQrY1kvVzVrN2k5Q3ZoTE01NGo1TmlWb3VHcDZo?=
 =?utf-8?B?VWkwRWdPSk45TEtUSWlKcFhGWTFXcnZiaGxSbkhJK2xPeFJuMmE5aGUxNzVS?=
 =?utf-8?B?SEMrUFMzR3cxWE14V01DNy9hWlVvb1JjNUswcHZWUGo0SHlaYUFMQmViSEsv?=
 =?utf-8?B?M0h1Z3Vja01DK3c1d1kvK1hJSnlSdHk1bHAzaXRiU1Z1VVhqYWZvRWQxdDBt?=
 =?utf-8?B?L04rYlNydnFzeUNiWUhvK3E1b3EzYVZxdm9yR3VBMzNDNVlpc2hFMHZDRTRn?=
 =?utf-8?B?dG1ncFFmR2VrNEJZcHdSWmkwWDJicjdpNHpBamxWdGgzR2hIbTNzRTc2c3lE?=
 =?utf-8?B?TDY5akU1OVpydlZqYzIzOHpFc2w0dTJwSDFUUzdLaGNYN0FqN0pCOUx4VVps?=
 =?utf-8?B?YmlZeDZHRThxWHNMb24xWUlia3NGbU1VM3Q5RXRaMi9Ub0ZMT3hrc1UwQ28z?=
 =?utf-8?B?THZvYy9jd0NYKzdLeCtRWmVnY3dJUmlnWWhBd1MxYzZVWnFrVkVTc2U4UlJT?=
 =?utf-8?Q?lcLyto?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGVZbTlsS002M1RERnlCdlVTUXAzL2crWFhSNi9tMFAvWC92QndmRXZkWnAz?=
 =?utf-8?B?cjdqam15dGJFNFUxdmw1ak9iK1lzUkNoT0lSNmxmU01SV0VzV3ZYaHNTZVVj?=
 =?utf-8?B?by85RTZ1VUI1SldOeGNyYVV6RnN2a1YwSm10bDVqZ2VQZENYZSt6b3Z0Q1ZC?=
 =?utf-8?B?bnZ4RWFaZ2lyd09Sam40clRzV0Fpbk9Sa2tJSGJPc2xhR0dIY1RBQm1HZHZq?=
 =?utf-8?B?NmdEaWZDYnJGUHFDWXR3eDIweFlWcTZaM00xa1VUaHBwSmErbW5XRmtuZVph?=
 =?utf-8?B?U1krMlB5Q0F1Yng5WE9vVUc2WFRaWEVnNjBnbmVSMlZFeEpua3p5dGJoZTYx?=
 =?utf-8?B?eGRuWDViUE9McnhMWmFZTHZNbktPejZkQllPbDBSb0hSRjNtbnhaSlpyN3Ux?=
 =?utf-8?B?QWZJNGcwVzBWRWJDSlVlN2Uzb0hZem9iUXV4Vld0RGp3WlgyMEtnYi9EKytr?=
 =?utf-8?B?ODRuUmtCUEVOZEQzcnlSRzJDSzNLb2ZITFlGRmFvSjBqTUdQK2FJTDlZS2Qz?=
 =?utf-8?B?ZVYrRzNpMy9IVHZaczBpcmFhM1lTL1lDdnliVzZDWENSSFlIWW1ZaHE2bzVv?=
 =?utf-8?B?S3FxMnVlaVhndkZCeXhtS05KS1VkdUt1ZUF1djl0cnROVGtaajdsaDYwSU9n?=
 =?utf-8?B?anpDMFhUejVRbUpBOTRpME11WmxBRDJaaDhZNzhGRmlGdlZlQWpGYURVbTho?=
 =?utf-8?B?YlU4cnNSNjQrRXI4VDdnckxUZFJyeWJhcElzUXQ5SFhrSk0zWVpSV0x2akNU?=
 =?utf-8?B?WlpvV0xySDE3TEMwcEtGSFJueHN3dGtxREVqVGZTMzFQaXZTOXQ2VUhkbXlK?=
 =?utf-8?B?RERjNWQ0dHNGS05SaUplSXhYUTFiaTErOW1XSEJQNDBWU0FVYjJaQ3c3T1g1?=
 =?utf-8?B?eFlWNWYzQktsYllGTTM4NUdLNkFodnlkTXRGOWZZMkdQNmVMRWszWmhFdisw?=
 =?utf-8?B?SVhkRUZySjI4Q1ZqRUVCYlVuUXprZVluelVXZW5vSTAzNkYycGNQbnBXSXlq?=
 =?utf-8?B?L3VtdG1VNGY1V1FJbVVxUld5V0tmb2p3VW1yOG5zMXBqSHNXZWVOY3FVZ0d0?=
 =?utf-8?B?Rml2dFBCNnpvK2xOS3hPd2REVGl3azVhdU5BRS9sNlFBdU00ck1GM08wRHdw?=
 =?utf-8?B?SEhlK1VsaHZ6YktIaFlUN3I5MktlVWhNR3hOZ0lXZFdjZy9UaU1URXZNVzlj?=
 =?utf-8?B?cFBGVmNhNU5Pbk1ua2NERWZvbGNHNVpveEZTYW9YY2tZNWhmOUh3VGdFZUxU?=
 =?utf-8?B?SWNnblhRZDlmelhBQmsyRlR5UmZpWDJRZC9QTnpOakdzcGhwN0YvZXFsbDVE?=
 =?utf-8?B?aURHMFAyZmczVGlKN083T1Y3TnRId1k0eGhDWHBHNHFCUGI2YlE1dS9IQ3lB?=
 =?utf-8?B?UFRKYnJUQVkzT0RqV3JwT1RFRjNQZ1BlMkZvalA5NnZUVkcxZjhHajE5UDFE?=
 =?utf-8?B?Z2JoeWVmZExKeVk5T1laTm9KaGdDK0o0Ynp6bnh3Ykh3ZytUWklsKzZyYkZi?=
 =?utf-8?B?cHBUQmE4TllZVEFNYVNWL1QxR2RhSGM4YzcwM0VWOVNEWUZ1UFdqaFpmUXRW?=
 =?utf-8?B?NlRyTFR6elBGRXVjamRKT0Z0NHJJSXg1WnFjOWo5dWkybHBETDZiRitPc21D?=
 =?utf-8?B?UXBkREdwTWJEWHhya2Y3bEdjWkxkSnI5UkpucTRoUjJVejhvWFRaZXVIYmdm?=
 =?utf-8?B?VUpqakNybVFCQnlNOTZpZlRMeVV2T1ZDNC91ZWNEN1pNT3lOYlRHaHQ5N2pj?=
 =?utf-8?B?bW9udFhkTnJGYzlDc2toaGw3M1VxZ2djRjhSWWFjRzNmR3NZVFV3MnYvc0Q2?=
 =?utf-8?B?bmo2Y1dkc2JGbE1wcTBXY2FZNmw0TDdrV0ZKT3BFUlh4NjdyMzN5V1JnWHdQ?=
 =?utf-8?B?ZWJhOGNFSUZ1VEFGb0pQbFVpUlhKSEUxc1AzajgvL0VTQnF0aVR0WGd6UWRw?=
 =?utf-8?B?d1V0a2RkV1JpOFE5dERkeUp3enprakJTWDdxcUlRMHVjWndqd1FQSHlwREFm?=
 =?utf-8?B?WW1TaGxjdmdGaXYrU2FWbHM3YW5uTkd2cUZOQVdYaVF1SXNCbnU1cXBnWlMy?=
 =?utf-8?B?aE9NeTJmZVV5SnlnK2JjUGp1OGJNejkwRG9rSjBSZ2hOWFVxS0lOTUVmNDVo?=
 =?utf-8?Q?AnwQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdddde0c-5f9d-4e78-272f-08de0b924301
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 02:26:35.0156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: de8c+LuLHdsWyPnZh95WskO/wrTwdkQTGA5t66HL+aUqMV9UpXbKSVq9U+MEXwo+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBXZWRuZXNkYXks
IE9jdG9iZXIgMTUsIDIwMjUgMjo1MCBBTQ0KPiBUbzogTWFyZWsgT2zFocOhayA8bWFyYWVvQGdt
YWlsLmNvbT4NCj4gQ2M6IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC1nZnggbWFp
bGluZyBsaXN0IDxhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBPbHNhaywgTWFy
ZWsgPE1hcmVrLk9sc2FrQGFtZC5jb20+OyBNb2hhbg0KPiBNYXJpbXV0aHUsIFlvZ2VzaCA8WW9n
ZXNoLk1vaGFubWFyaW11dGh1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy83XSBk
cm0vYW1kZ3B1L2dmeDogYWRkIGVvcCBzaXplIGFuZCBhbGlnbm1lbnQgdG8gc2hhZG93DQo+IGlu
Zm8NCj4NCj4gT24gVHVlLCBPY3QgMTQsIDIwMjUgYXQgMjoxMOKAr1BNIE1hcmVrIE9sxaHDoWsg
PG1hcmFlb0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBPY3QgMTQsIDIwMjUs
IDEyOjM3IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4gPj4N
Cj4gPj4gT24gVHVlLCBPY3QgMTQsIDIwMjUgYXQgMTE6MTHigK9BTSBNYXJlayBPbMWhw6FrIDxt
YXJhZW9AZ21haWwuY29tPiB3cm90ZToNCj4gPj4gPg0KPiA+PiA+IE9uIFR1ZSwgT2N0IDE0LCAy
MDI1IGF0IDEwOjEy4oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IHdyb3RlOg0KPiA+PiA+Pg0KPiA+PiA+PiBPbiBUdWUsIE9jdCAxNCwgMjAyNSBhdCAyOjQ54oCv
QU0gTWFyZWsgT2zFocOhayA8bWFyYWVvQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+ID4+ID4NCj4g
Pj4gPj4gPiBPbiBNb24sIE9jdCAxMywgMjAyNSBhdCAzOjEx4oCvUE0gQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+PiA+PiA+Pg0KPiA+PiA+PiA+PiBP
biBNb24sIE9jdCAxMywgMjAyNSBhdCAxMDoyMeKAr0FNIExpYW5nLCBQcmlrZSA8UHJpa2UuTGlh
bmdAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4+ID4+ID4+ID4NCj4gPj4gPj4gPj4gPiBbUHVibGlj
XQ0KPiA+PiA+PiA+PiA+DQo+ID4+ID4+ID4+ID4gUmVnYXJkcywNCj4gPj4gPj4gPj4gPiAgICAg
ICBQcmlrZQ0KPiA+PiA+PiA+PiA+DQo+ID4+ID4+ID4+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+PiA+PiA+PiA+ID4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+DQo+ID4+ID4+ID4+ID4gPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTMsIDIwMjUg
OTo0NCBQTQ0KPiA+PiA+PiA+PiA+ID4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1k
LmNvbT4NCj4gPj4gPj4gPj4gPiA+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+ID4+ID4+ID4+ID4gPiBnZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+ID4+ID4+ID4+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvN10gZHJtL2FtZGdw
dS9nZng6IGFkZCBlb3Agc2l6ZSBhbmQNCj4gPj4gPj4gPj4gPiA+IGFsaWdubWVudCB0byBzaGFk
b3cgaW5mbw0KPiA+PiA+PiA+PiA+ID4NCj4gPj4gPj4gPj4gPiA+IE9uIE1vbiwgT2N0IDEzLCAy
MDI1IGF0IDQ6NTTigK9BTSBMaWFuZywgUHJpa2UNCj4gPFByaWtlLkxpYW5nQGFtZC5jb20+IHdy
b3RlOg0KPiA+PiA+PiA+PiA+ID4gPg0KPiA+PiA+PiA+PiA+ID4gPiBbUHVibGljXQ0KPiA+PiA+
PiA+PiA+ID4gPg0KPiA+PiA+PiA+PiA+ID4gPiBXZSBtYXkgbmVlZCB0byB1cGRhdGUgdGhlIHVz
ZXJzcGFjZSBFT1AgYnVmZmVyIHJlcXVlc3Q7DQo+ID4+ID4+ID4+ID4gPiA+IG90aGVyd2lzZSwg
dGhlIEVPUA0KPiA+PiA+PiA+PiA+ID4gYnVmZmVyIHZhbGlkYXRpb24gbWF5IGZhaWwuDQo+ID4+
ID4+ID4+ID4gPg0KPiA+PiA+PiA+PiA+ID4gRXhpc3RpbmcgdXNlcnNwYWNlIHNob3VsZCBiZSBv
ay4gIEl0IGN1cnJlbnRseSB1c2VzDQo+ID4+ID4+ID4+ID4gPiBQQUdFX1NJWkUgd2hpY2ggaXMg
bGFyZ2VyIHRoYW4gMjA0OC4NCj4gPj4gPj4gPj4gPiBUaGUgbWVzYSB1c2VzIHRoZSBFT1Agc2l6
ZSBhcyBtYXhfdCh1MzIsIFBBR0VfU0laRSwNCj4gQU1ER1BVX0dQVV9QQUdFX1NJWkUpIHdoaWNo
IGlzIHNlZXMgbGFyZ2VyIHRoYW4gMjA0OCwgc28gdGhlIGtlcm5lbA0KPiB2YWxpZGF0ZXMgdGhl
IGVvcCBidWZmZXIgY2FuIGJlIHN1Y2Nlc3NmdWwgYXQgdGhpcyBwb2ludC4NCj4gPj4gPj4gPj4g
Pg0KPiA+PiA+PiA+PiA+IEJ1dCB0aGUgbWVzYSBtYXkgbmVlZCB0byB1c2UgdGhlIHNoYWRvd19p
bmZvLT5lb3Bfc2l6ZSBhcyB3ZWxsIGluIHRoZQ0KPiBmdXR1cmU/DQo+ID4+ID4+ID4+DQo+ID4+
ID4+ID4+IElkZWFsbHkgbWVzYSB3b3VsZCBxdWVyeSB0aGUga2VybmVsIHRvIGdldCB0aGUgcHJv
cGVyIG1pbmltdW0gc2l6ZS4NCj4gPj4gPj4gPj4gWW9nZXNoIHdpbGwgYmUgbG9va2luZyBhdCB0
aGlzLg0KPiA+PiA+PiA+Pg0KPiA+PiA+PiA+PiBBbGV4DQo+ID4+ID4+ID4NCj4gPj4gPj4gPg0K
PiA+PiA+PiA+IERvZXMgdGhlIEVPUCBidWZmZXIgc3RvcmUgcHJpdmlsZWdlZCBpbmZvcm1hdGlv
bj8gV2hhdCBpcyBpdHMgY29udGVudD8NCj4gPj4gPj4NCj4gPj4gPj4gSXQgc3RvcmVzIGVuZCBv
ZiBwaXBlIGV2ZW50cyBmb3IgdGhlIGNvbXB1dGUgcXVldWUgZ2VuZXJhdGVkIGZyb20NCj4gPj4g
Pj4gdGhpbmdzIGxpa2UgUkVMRUFTRV9NRU0gb3IgQVFMIHBhY2tldHMuICBUaGV5IGFyZSBzcGVj
aWZpYyB0byBlYWNoDQo+ID4+ID4+IHVzZXIgcXVldWUuICBJbiB0aGVvcnkgY29ycnVwdGluZyBv
ciBtZXNzaW5nIHdpdGggdGhlIGRhdGEgaW4gdGhlDQo+ID4+ID4+IGJ1ZmZlciBzaG91bGQgb25s
eSBhZmZlY3QgdGhhdCBxdWV1ZS4NCj4gPj4gPg0KPiA+PiA+DQo+ID4+ID4gUkVMRUFTRV9NRU0g
aGFzIGEgaGlkZGVuIGltcGxpY2l0IFZNSUQgcGFyYW1ldGVyLiBUaGF0J3Mgd2h5IGl0J3MNCj4g
aW1wb3J0YW50IHRvIGtub3cgd2hldGhlciBpdCdzIHN0b3JlZCBpbiB0aGUgRU9QIGJ1ZmZlciB0
aGF0IGNhbiBiZSBvdmVyd3JpdHRlbiBieQ0KPiB1c2Vyc3BhY2UuDQo+ID4+DQo+ID4+IE15IHVu
ZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGF0IGlzIG9ubHkgcmVsZXZhbnQgZm9yIGtlcm5lbCBxdWV1
ZXMNCj4gPj4gd2hlcmUgdGhlIHZtaWQgY29tZXMgZnJvbSB0aGUgSUIgZm9yIGVhY2ggam9iLiAg
Rm9yIHVzZXIgcXVldWVzLCB0aGUNCj4gPj4gdm1pZCBpcyBkZXRlcm1pbmVkIGJ5IHRoZSBIUUQg
c28gdGhhdCBpcyB1bnVzZWQgaW4gdGhlIHVzZXIgcXVldWUgY2FzZS4NCj4gPg0KPiA+DQo+ID4g
VGhpcyBpcyBOQUsnZCB1bnRpbCBhIHByb29mIGlzIGdpdmVuIHRoYXQgdGhlIEVPUCBidWZmZXIg
Y2FuJ3QgYmUgdXNlZCB0byBjaGFuZ2UgdGhlDQo+IFZNSUQgb2YgRU9QIGZlbmNlIHdyaXRlcy4N
Cj4NCj4gVGhlIEVPUCBidWZmZXIgYWxsb2NhdGlvbiBpcyBhbHJlYWR5IGluIHVzZS4gIEl0J3Mg
dXNlZCBmb3IgY29tcHV0ZSB1c2VyIHF1ZXVlcyBmb3INCj4gYm90aCBST0NtIGFuZCBLR0QuICBB
bGwgdGhpcyBwYXRjaCBkb2VzIGlzIGFsbG93IHVzZXJzcGFjZSB0byBxdWVyeSB3aGF0IHRoZSBz
aXplDQo+IHJlcXVpcmVtZW50cyBhcmUuICBJZiB3ZSBmaW5kIGEgcHJvYmxlbSBpbiB0aGUgRU9Q
IGhhbmRsaW5nIGluIGZpcm13YXJlIHdlIHNob3VsZCBmaXgNCj4gaXQgaW4gZmlybXdhcmUsIGJ1
dCB0aGUgc29mdHdhcmUgc2lkZSBpcyBhbHJlYWR5IGluIHVzZS4NCkZyb20gbXkgdW5kZXJzdGFu
ZGluZywgdGhlIE1FQyBmaXJtd2FyZSBnZW5lcmF0ZXMgYW5kIHBvcHVsYXRlcyB0aGUgRU9QIGJ1
ZmZlciByYXcgZGF0YSwNCnNvIHRoZSBkcml2ZXIgaGFzIG5vIGRpcmVjdCBjb250cm9sIG92ZXIg
aXRzIGNvbnRlbnRzLiBAR2FsbG8sIEx1Y2EsIGNvdWxkIHlvdSBoZWxwIHByb3ZpZGluZyBtb3Jl
IGRldGFpbHM/DQo+IEFsZXgNCg==
