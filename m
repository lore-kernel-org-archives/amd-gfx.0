Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D48D172DA
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 06:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA5510E27F;
	Mon,  2 Feb 2026 06:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xnra21sR";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0192E10E267
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 06:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5jFdtqJ1BmD/oP64e6QoUj9pX/OMK81sv6n0TjeetD+oHQuMWTiZkB4HZkr3IEcpCAanR29VL8rnlkslxWKaJQmbqNjZLzl0v+HeiXsvQv6o4t/jdEn2PSSCOyXeqxB5rXL32DYj4hO8tO2vqBKbpSSiCGG0oB94Hzm7HLZDyr7xW0RkbeWs+IdpTCxZriSVQs0uV110zXpYFTR1VdvWXgL0rKpsZAHM8nkWukk+nO6f1eOKkcZPuhqNsm8Dpg8kf+8HkQklaHtQTDjqHGWzb1/B61jFVQ9TGc7k40q28blcWW3sn8NG/9rBOHaY0uRcWAV3NnPJsUotMscHdOS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLruLzP5TklxAOFoDIvH0rHryLaZrdaDRfkDVcNOGrI=;
 b=dV5/lGdPoNhYvzWmcWCAcRG5lHiEM3/HYd2Lqddlqu/0631c6U0dZNnjJ0Fn6MZHt/flP5PVvruiXLvahAmrsznaajA34IL6P7e4z5YoTF8JZd8tvUSGV9bPQadtzcaThF2pcHNflO2o7yas4NhsXobF0h6znRzeWZdfM8+T398EQ5qvkHplELU7kp6nW49X5G0UGHylO30CJQpZ2EjRr21Rs/mT8wMTJfKCbFmfZTJ1Pxi+hyZSlKsMLrFofYI/ug3SJC7JhSnaifhHgoRoAPmUXYsesLdlXewsHAQz91gAMI+qUlR0Fkez2GZCL3J8DrhxfP/gClIseuJM0LO0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLruLzP5TklxAOFoDIvH0rHryLaZrdaDRfkDVcNOGrI=;
 b=Xnra21sR8loMDGpaSf3MVvq621ho1OKbAsTZaKBKaHTfoQ2otKIQi4hzurQdzMTcQsW5zHg/V6e0KrXRm17tWlJFG8FpJDnw40CfNSJsnzmEBu/7Unps3Yt29on133ZEh2cxnqmYD1sjxkOmgLub8QaPW865fy2vJOUsemrzDQA=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:33:01 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%4]) with mapi id 15.20.9564.010; Mon, 2 Feb 2026
 06:33:01 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 01/12] drm/amdgpu/gfx9: handle gfxoff in interrupt set
 functions
Thread-Topic: [PATCH 01/12] drm/amdgpu/gfx9: handle gfxoff in interrupt set
 functions
Thread-Index: AQHcjv986aqJ+MDZxES6NBYvPeQ49rVlc3KAgAVdrwCAAASHAIAADFiAgADvC4CAAyoS4A==
Date: Mon, 2 Feb 2026 06:33:01 +0000
Message-ID: <CY5PR12MB63691FD706BEB5110099F0B6C19AA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
 <b977ab80-748b-4eb7-b05c-5856db02acb0@amd.com>
 <CADnq5_NU4Swq_n12A6HXD+YRRcXahFMYxa4pLHT2-WX33tfgzg@mail.gmail.com>
 <42191bbf-6f92-4883-8aa9-9e808fae3e8d@amd.com>
 <CADnq5_M-CoUDrWs9nOUSUF5yM+Jq2+RY1WS6mYGbWVYmtxgA8w@mail.gmail.com>
 <cc77cc03-b9b8-46a7-bdf1-237a9c239ba8@amd.com>
In-Reply-To: <cc77cc03-b9b8-46a7-bdf1-237a9c239ba8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-02T06:25:07.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH3PR12MB8971:EE_
x-ms-office365-filtering-correlation-id: fd521dfe-26b4-4709-f03d-08de6224e9bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YUdJREI4Q1VzUDl4My9zZE83NjhUbkNFUktNeGh4UVlsYytDZ3ltUTdLS0JW?=
 =?utf-8?B?alIzUGpxTElBWE8veFFPQUh4RENSVER0UFg1ZWJVSlJjdk53bHRPdmQ0dGZl?=
 =?utf-8?B?VkZOdVdsNHpzVTVwZFhCUzBIanY3cENockk0Rk1oQy84VU5nWFJ0L3FVQ1Bi?=
 =?utf-8?B?Wi9oa0RubGRsaXVoZDVOem5iZ2ltbEYyMVQrMGRLazlWSmRNcHZHdE1Yc1dC?=
 =?utf-8?B?Q0NtRHh5cmtKd1ljSGVRWFVYbi91bDNyL3lsSDJQMi92U2hyNmcvcGRnTzhk?=
 =?utf-8?B?MDB1TUE4d25GOFZXS043NjNKWTd5bHdGNjJYZlFUZ0x6bElWMUdvZU03R3JN?=
 =?utf-8?B?TmRwSDQ1d280Q29rZEJ4ZEFIbjRTN2t6azFDRzN4M29WaUFlY3F5UndwcWlC?=
 =?utf-8?B?M3daV0xwY0llWWVyNTU5dEVzd29GaGFPZXN5ZWhnZHRtbGduUUs1WUM3S0Z0?=
 =?utf-8?B?bjkrUFZNVDdGQmpCTFVSZm5JZ0p2ZVZ5dG9PU1A0YXQ4Z2dpZVRNRHVlWmRQ?=
 =?utf-8?B?b0JOb0pkbC9WTjB1eXpENVNmZXB5UDNBOC9nZ0dZWFNCRlRZdkhONERPRVJH?=
 =?utf-8?B?MFczZWt1OGpXOFdBUTJSZkhOdjZTaHdIM1VsS2U3em04QUJ0dkhpejBjekgy?=
 =?utf-8?B?akNhODJnUXpSdUtLM0lPOHdUMnZ5YlJqSHQxc0tqY2xTKzF6MmVCTHRTQytM?=
 =?utf-8?B?NFZPSytBZURUNDg4aDQrWDZqa3RPZkMxR2VHTWFRRDBSaHdYdmtkOG0vNU5o?=
 =?utf-8?B?UWFwamxCVk9tdFdsc2p4TDNISHdUZzlKSFdzVG9EQTUwNXRDMXVkSlBDRSti?=
 =?utf-8?B?MUY5VEQ0bDJ6WmZBZDc5d1JYOXRacHhWSVY3NXMzSHFmRWxTT2VMdlRPWjBP?=
 =?utf-8?B?WndVOGpIc1g0RW5nWkpSekNSK2laWW5xNkNQSWJMLzhsWXNvTjF1ekxtV1hM?=
 =?utf-8?B?MGNSTklNWGpGTVdVcTZRQWxmQitib2EwalpWUGMyNklJMlZ0YUU2Z0VmeDdl?=
 =?utf-8?B?eWdmT2lDWFFnRFpINkxITUVuTVliZFVNZjVsalVRVVd1T2xiWGdObHZDU2d1?=
 =?utf-8?B?TmpJUG8vTUUwaHJ4RjJlZmkyZUZaR1ZNSndmZG9KRXdOaUZ2OFgxYjgyc0Fr?=
 =?utf-8?B?R1J1V0p4VHBDRGhIYnJNYVlMUEFJeUoyOHZ2TzQvdDFXdlRmYVdjL1ZZUUhH?=
 =?utf-8?B?L1hZaHExcTkyUk5ibDQ3VUc4S2dsWlVuaWFYczRzbWxzNi82cjE5bWhtYXhV?=
 =?utf-8?B?ZlB2SkdaUWN3NU5IVk9rWkdUOVdESUdYdkhVWUxNem1rRGZaN0VxT2NOTGhW?=
 =?utf-8?B?cDhjR2FtdFd2TGJWdEkxa0R1S202RWFnSW5aVXl0cmNSQkR5Y3U4Tk9rZnhp?=
 =?utf-8?B?eXFpQUZleWY1ZVpvNUdwSGxKeHl3V2JzOStZaE42QjgzdlJOZVVkbzhVL2Ny?=
 =?utf-8?B?MWo4OFQ3M1NkNnB0bzlEQTVVWnE3TUs3bVVQdDVWYnNnaVF1eGZ1WFdMTU1j?=
 =?utf-8?B?RW9GVndBYnpIMXA2c3N6MGdxNGYydUoxdXpIcFhXNHUwY2FoR0IyZjliQ00x?=
 =?utf-8?B?WHF2WXh2NkRmVVRLNitHTDNSVnV4L29sbG40UllRSDltRkVMVmRhbG5PM2pj?=
 =?utf-8?B?NzRiYXBuMm1BTG5STkMvcDZmazBEbXdwQUZKcTZNalUyZTNGMlRlYzQzNHQz?=
 =?utf-8?B?d0JYQ2QxRnZvVER1WlVTRHhPcDduUjVoY2MwL0hZZFV4RFBvZzVZb1p0c3lu?=
 =?utf-8?B?TWwwMHU2NGk4ZUM2eVpYR09jbEFzb1Z0bTlsaUFwaFdKaUljallCYzJQUXFK?=
 =?utf-8?B?dmpMcGlSeG8rZWptcXRQSzZ1YiszM016MzVkQXBJQXplNVRsV2lsTmtneXEv?=
 =?utf-8?B?QTFnQVRMbnRXVHA0S3p5OVk5bXV0eWJzblZUeHVQS09PTmxYV3VEQU5oTlJW?=
 =?utf-8?B?N0NoZldydnQ4YkQvZ2FuRVlxN0xuQnpGT0ZkWi9nWEtuS2NZMWlwRDlNNzAv?=
 =?utf-8?B?Q3BRMlpUbnBOWFpQNlFxWWVkaWNtakltUnl0UTZGNFJOL1RMYnF4TDJpS0tn?=
 =?utf-8?B?Smdyemd2VFZoUTJYZ0VIUDJRRW95RjlRWGdHcmdxZE44YXljWEt0R0dMb25P?=
 =?utf-8?B?V0E3WGRCTy9pbjIxTklnSVM5MGNiS21CRXV3Ry9qTEovVFY0UWp4UENYOXN0?=
 =?utf-8?Q?MbHdY3VI2SrlweVv6u/ODRw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3YyK0dha2JTYm5sb2prRWZDOEh2ZVBqMDNtWG5iMDlrU2hmV1p2cmxkeHhO?=
 =?utf-8?B?UXJTaGw5U0EwOFhrNmN6QldlVS80cVdpTkthS3dwK0t2d3ZrM2hBN045bzk5?=
 =?utf-8?B?Ny9aSmRwNmY5NEZPMC9NU0dwU3RMS0Z2SVVUTEVpRzFxc3g1RnBWSGQvamVx?=
 =?utf-8?B?Z014aEVHMkk0WHFsMjdmWDBZb2MzNTh1VnZjeTREeGNUYVhRb0VnSjhjM0hj?=
 =?utf-8?B?bDgydVlhTFk2cVlySW1yVGxCRWRFTzFrOEJzQVZLeHlJY3laSXNwK0d0Ulh4?=
 =?utf-8?B?b2gycnlIZ1IyRmNWcEFvbjZaZlBZK2sreTVjODJSa0djZ29LZVVwNnpPcEZM?=
 =?utf-8?B?QjdtRFR1ZXZvYTlodGphTlQ2RmlnQWUrSDJxdHFHNlBUek1TcHRrNW9GYlU4?=
 =?utf-8?B?Rk1NRG1mV2dEdDdPRkRXSHNjdVpxTkEzbzlBY3ZkS3J2RjNVSUNsZTh1N3V0?=
 =?utf-8?B?Y0hoZ1hwRDZiV1dCaGZ3MWhPcVQxMVZUcjI3dzhNNDlxV0NZUWp1M21YK0g0?=
 =?utf-8?B?V2JlZDU2M2U3VUJHSXRnbVN2Z0l6QTdjd3F5YnUvdGxsdkIrSzc2QWZRaG45?=
 =?utf-8?B?dEhwNEd6LzUwOEZMSXJ4V1FsZUdRYVpIVHF1Nm1wOTVJVkdhZ0xlcy8xMlps?=
 =?utf-8?B?YWZYQ1pQZFUwTTVWazJsYk1oMEVkMDBRVG4yMzdUc2VPVkJTWmF2ck9KMmtC?=
 =?utf-8?B?bndQZ1FVZHhvY1JUUkhMOEs4Ry9aVjJqUXo5dFl4dlhmQWJQZmh6R1FaU0Q5?=
 =?utf-8?B?a3FSclJVb01tNTJlemNXazlHb2NPUk5aUm5BdGw4WDFLWjBKaFJ3TEVwdnpv?=
 =?utf-8?B?MVA4aTJRKzVoK2tNNmtjOTNKVHUvSDhFaFRTK09XdUpMTzVaZTNkN2lxbmp5?=
 =?utf-8?B?a29vUEx6aExNbE9VclJpWUswVHYzSFljczZraThnbm9TYkdDeW45dTdTTllQ?=
 =?utf-8?B?bXVoZG9Vem5Geno0bVBwYkpWMGJVbEtTYjZDRWpETTBOZnJuS3JEdHpvQzgy?=
 =?utf-8?B?aktmU3lsV3JFV1VOeGk4Ui8vLzJRODlWNmphMTRCYmhkcjZvTURkV3k4N2tN?=
 =?utf-8?B?MUFqY0hYUTRMQ0lHUzZWcVI1Slh5TlZBSW1jZmtTSHBCQWJSQklBcVRETEdK?=
 =?utf-8?B?dEwvdUxNQktJbGJEWGlkMjIxVTdNZWxqK3l4K05YdCt1SVdFNmkxNVA0UmlU?=
 =?utf-8?B?QjRRZnh5cVN2cEpVZEIzU1FCanFGaUV6alFyTlI1b0JwN3pGVXNiMEtORWJ5?=
 =?utf-8?B?VDBPSUlZMXpBMUlFQkRLd2w0OTJrVXVsaFoybktGenY2RitiOVBhS205cUZO?=
 =?utf-8?B?dWoyVURrbzZHa2RrWmRvU1dra3lMbnlTUFFZWFpBT3U5TGNhM2dHN1ZueHc1?=
 =?utf-8?B?dWdOSzVHc0htRDBudUJIaS9OUmpoTkFXbHl6RzVjcDRJUGhxS1owOUdNZllN?=
 =?utf-8?B?YkJMcGlONHlOU3c3Q243ZVZhd0R6R1lkd2k1M2Z5dmlWT2VBMFEwQkttNW5n?=
 =?utf-8?B?QWUrS1F4Tm90aTVMS056UEFNaTdYc2xtMVNBVDdPQWFxLy9ubEt5VEgxYyta?=
 =?utf-8?B?bmtJbFZYSkVnbGJJMWNVRnlHVVhwcjdTQW1hNFB3SDVWMzNnL1BUZDU5WUI2?=
 =?utf-8?B?cWJ2VXRIdzdSc2tYWjNoczRZQTZrNGg1NkQyWHVZME1wMU5zUHBKOXlyZjZa?=
 =?utf-8?B?WUhwdGNtTG9IRWhSazFydlBRT0gvWjNQSFBqODRCL3V6anhWcXloUjFRYk1u?=
 =?utf-8?B?VE5yKy9PbnFWUk5DUkVCREJlSnlOWkhVOXM5aG04QjkxdkhsQzNNOHFMT0Zi?=
 =?utf-8?B?KzcycStEa3A3SSs0YmE5YnJjbjhLZFpROEJNVGJpTjdMdE90SXlZcjFoZjRn?=
 =?utf-8?B?bm5jODhkNU1EWTFVZEczdmFROU1SUElWRFdsUXpEWUx4eHUwUXVZYnZGUWl2?=
 =?utf-8?B?QWljc0d3MXVjLzBCaFBoUnRtK1ZPRExPRktoamNUVjhKK0VITmZjNFpEcEwy?=
 =?utf-8?B?MjRneVduTXpWZFU0QkJlbTVqRmFORm1iY2F3YVFHWldGMTRlT0p6YWtGcUQ2?=
 =?utf-8?B?TExnUkx4ZHRRK2tqYUVRZGNCSUZrR0Q2STJwSkpuMlAveElXUGFYbmZ1Vlcv?=
 =?utf-8?B?VHZ0UERiaU8yZWkyM1Z0VUtKMnRTcjNMSDhYSSttZ3MrK0xhdjJqM0tYejlU?=
 =?utf-8?B?WXdLKzJGNFBLNDJaRXZLVTJRZWk4ckEzU25vTkdTc0ZyZnVYaUlqczBLN05h?=
 =?utf-8?B?VmNLR3NUendjMnMwbFR1RGRVZFR0RW5HaTNSbjhqbE5TWjBSb3BVY3YzaFoy?=
 =?utf-8?Q?yT0V6ZNrRqVXeeTH2C?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd521dfe-26b4-4709-f03d-08de6224e9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:33:01.2590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1UMvjUbB7LpTDfc/9cI6eGo54eztC6Ppl3FEwV4yZXdylomLmZjGjiKHtBvVpT5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971
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

W1B1YmxpY10NCg0KSGkgQWxleCBhbmQgTGlqbywNCg0KUmV2aXNlZCB0aGUgcGF0Y2ggYmFzZWQg
b24geW91ciAgY29tbWVudHMuIFBsZWFzZSByZXZpZXcgW1BBVENIXSBkcm0vYW1kZ3B1OiBQdXQg
R1BVIENHL1BHIHVuZ2F0ZSBpbiBkZXZpY2VfZmluaV9odyBhbmQgZGV2aWNlX2hhbHQNCg0KQmVz
dCBSZWdhcmRzLA0KWWlmYW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExh
emFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBTYXR1cmRheSwgSmFudWFyeSAz
MSwgMjAyNiAyOjA1IFBNDQpUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
DQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFt
ZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDAxLzEyXSBkcm0vYW1kZ3B1L2dmeDk6IGhhbmRs
ZSBnZnhvZmYgaW4gaW50ZXJydXB0IHNldCBmdW5jdGlvbnMNCg0KDQoNCk9uIDMwLUphbi0yNiA5
OjE5IFBNLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IE9uIEZyaSwgSmFuIDMwLCAyMDI2IGF0IDEw
OjA14oCvQU0gTGF6YXIsIExpam8gPGxpam8ubGF6YXJAYW1kLmNvbT4gd3JvdGU6DQo+Pg0KPj4N
Cj4+DQo+PiBPbiAzMC1KYW4tMjYgODoxOCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPj4+IE9u
IFR1ZSwgSmFuIDI3LCAyMDI2IGF0IDEyOjAy4oCvQU0gTGF6YXIsIExpam8gPGxpam8ubGF6YXJA
YW1kLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDI3LUphbi0yNiAxOjM3
IEFNLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+Pj4+PiBOZWVkIHRvIG1ha2Ugc3VyZSBnZnhvZmYg
aXMgZGlzYWxsb3dlZCB3aGVuIHdlIHRvdWNoIEdDIHJlZ2lzdGVycw0KPj4+Pj4gb3ZlciBNTUlP
Lg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSSB0aGluayBpbnRlcnJ1cHQgZW5hYmxlL2Rpc2FibGUgc2Vx
dWVuY2UgaXMgb25seSBzdXBwb3NlZCB0byBiZQ0KPj4+PiBkb25lIHVuZGVyIGlwIHBvd2VyL2Ns
b2NrIHVuZ2F0ZSBzZXF1ZW5jZSBsaWtlIGluIGh3DQo+Pj4+IGluaXQvcmVzdW1lL3N1c3BlbmQg
c2VxdWVuY2VzLiBUaGUgZml4IHByb2JhYmx5IHNob3VsZCBiZSBpbiB0aGUNCj4+Pj4gaGlnaGVy
IGxldmVsIHNlcXVlbmNlIHdoaWNoIGRvZXNuJ3QgdGFrZSBjYXJlIG9mIHRoYXQuDQo+Pj4NCj4+
PiBJbiB0aGF0IGNhc2UsIFlpZmFuJ3Mgb3JpZ2luYWwgcGF0Y2ggaXMgcHJvYmFibHkgZmluZSBh
cyBpcy4NCj4+PiBTb21lb25lIHNob3VsZCBzdGlsbCBkb3VibGUgY2hlY2sgYWxsIG9mIHRoZSBj
YWxsIHBhdGhzIHRob3VnaC4NCj4+Pg0KPj4NCj4+IE9yaWdpbmFsIG9uZSBpcyBhbHNvIG5vdCBj
b3JyZWN0LiBGb3IgZXhhbXBsZSwgaWYgdGhpcyBpcyBoYXBwZW5pbmcNCj4+IGFmdGVyIHJlc2V0
IHJlIGluaXRpYWxpemF0aW9uLCBvbmx5IHRoYXQgc2VxdWVuY2UgbmVlZHMgdG8gYmUNCj4+IG1v
ZGlmaWVkIHRvIGtlZXAgdGhlIGFmZmVjdGVkIElQcyB1bmdhdGVkIGR1cmluZyByZWluaXQuDQo+
DQo+IEl0IGFsc28gZ2V0cyBjYWxsZWQgaW4gYW1kZ3B1X2RldmljZV9maW5pX2h3KCkuDQo+DQoN
CkNoZWNrZWQgbm93LiBXaGF0IEkgbWVhbnQgaXMgLSB3ZSBzaG91bGQgY2FsbCBpcCBjZy9wZyB1
bmdhdGUgaW5zaWQNCmFtZGdwdV9kZXZpY2VfZmluaV9odygpIHRvIHByb3RlY3QgYWxsIG90aGVy
IGFjY2Vzc2VzIHdpdGhpbiB0aGF0IHNlcXVlbmNlIGFuZCBub3QgcmVzdHJpY3RlZCB0byBpcnFf
ZGlzYWJsZS9lbmFibGUgYWxsLiBOb3cgdGhhdCBoYXBwZW5zIGEgd2hpbGUgbGF0ZXIgaW4gYW1k
Z3B1X2RldmljZV9pcF9maW5pX2Vhcmx5Lg0KDQpCYXNpY2FsbHksIHRoZSBoaWdoIGxldmVsIHNl
cXVlbmNlIG5lZWRzIElQIHBnIHVuZ2F0ZSBwcm90ZWN0aW9uLg0KDQpUaGFua3MsDQpMaWpvDQoN
Cj4gQWxleA0KPg0KPj4NCj4+IFRoYW5rcywNCj4+IExpam8NCj4+DQo+Pj4gQWxleA0KPj4+DQo+
Pj4+DQo+Pj4+IFRoYW5rcywNCj4+Pj4gTGlqbw0KPj4+Pg0KPj4+Pj4gQ2M6IFlpZmFuIFpoYW5n
IDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gICAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxMCArKysrKysrKysrDQo+Pj4+PiAg
ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4+Pj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+Pj4+PiBpbmRleCAzNmYwMzAwYTIx
YmZhLi4wNTE3OGVlOGUwZTNhIDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYw0KPj4+Pj4gQEAgLTYwNTYsNiArNjA1Niw3IEBAIHN0YXRpYyBpbnQgZ2Z4
X3Y5XzBfc2V0X3ByaXZfcmVnX2ZhdWx0X3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KPj4+Pj4gICAgICAgICB1MzIgY3BfaW50X2NudGxfcmVnLCBjcF9pbnRfY250bDsNCj4+Pj4+
ICAgICAgICAgaW50IGksIGo7DQo+Pj4+Pg0KPj4+Pj4gKyAgICAgYW1kZ3B1X2dmeF9vZmZfY3Ry
bChhZGV2LCBmYWxzZSk7DQo+Pj4+PiAgICAgICAgIHN3aXRjaCAoc3RhdGUpIHsNCj4+Pj4+ICAg
ICAgICAgY2FzZSBBTURHUFVfSVJRX1NUQVRFX0RJU0FCTEU6DQo+Pj4+PiAgICAgICAgIGNhc2Ug
QU1ER1BVX0lSUV9TVEFURV9FTkFCTEU6DQo+Pj4+PiBAQCAtNjA4MCw2ICs2MDgxLDcgQEAgc3Rh
dGljIGludCBnZnhfdjlfMF9zZXRfcHJpdl9yZWdfZmF1bHRfc3RhdGUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsDQo+Pj4+PiAgICAgICAgIGRlZmF1bHQ6DQo+Pj4+PiAgICAgICAgICAgICAg
ICAgYnJlYWs7DQo+Pj4+PiAgICAgICAgIH0NCj4+Pj4+ICsgICAgIGFtZGdwdV9nZnhfb2ZmX2N0
cmwoYWRldiwgdHJ1ZSk7DQo+Pj4+Pg0KPj4+Pj4gICAgICAgICByZXR1cm4gMDsNCj4+Pj4+ICAg
ICB9DQo+Pj4+PiBAQCAtNjA5Miw2ICs2MDk0LDcgQEAgc3RhdGljIGludCBnZnhfdjlfMF9zZXRf
YmFkX29wX2ZhdWx0X3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4+Pj4gICAg
ICAgICB1MzIgY3BfaW50X2NudGxfcmVnLCBjcF9pbnRfY250bDsNCj4+Pj4+ICAgICAgICAgaW50
IGksIGo7DQo+Pj4+Pg0KPj4+Pj4gKyAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxz
ZSk7DQo+Pj4+PiAgICAgICAgIHN3aXRjaCAoc3RhdGUpIHsNCj4+Pj4+ICAgICAgICAgY2FzZSBB
TURHUFVfSVJRX1NUQVRFX0RJU0FCTEU6DQo+Pj4+PiAgICAgICAgIGNhc2UgQU1ER1BVX0lSUV9T
VEFURV9FTkFCTEU6DQo+Pj4+PiBAQCAtNjExNiw2ICs2MTE5LDcgQEAgc3RhdGljIGludCBnZnhf
djlfMF9zZXRfYmFkX29wX2ZhdWx0X3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0K
Pj4+Pj4gICAgICAgICBkZWZhdWx0Og0KPj4+Pj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4+
Pj4gICAgICAgICB9DQo+Pj4+PiArICAgICBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIHRydWUp
Ow0KPj4+Pj4NCj4+Pj4+ICAgICAgICAgcmV0dXJuIDA7DQo+Pj4+PiAgICAgfQ0KPj4+Pj4gQEAg
LTYxMjUsNiArNjEyOSw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfc2V0X3ByaXZfaW5zdF9mYXVs
dF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCB0eXBlLA0KPj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gYW1kZ3B1X2lu
dGVycnVwdF9zdGF0ZSBzdGF0ZSkNCj4+Pj4+ICAgICB7DQo+Pj4+PiArICAgICBhbWRncHVfZ2Z4
X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsNCj4+Pj4+ICAgICAgICAgc3dpdGNoIChzdGF0ZSkgew0K
Pj4+Pj4gICAgICAgICBjYXNlIEFNREdQVV9JUlFfU1RBVEVfRElTQUJMRToNCj4+Pj4+ICAgICAg
ICAgY2FzZSBBTURHUFVfSVJRX1NUQVRFX0VOQUJMRToNCj4+Pj4+IEBAIC02MTM1LDYgKzYxNDAs
NyBAQCBzdGF0aWMgaW50IGdmeF92OV8wX3NldF9wcml2X2luc3RfZmF1bHRfc3RhdGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+Pj4+PiAgICAgICAgIGRlZmF1bHQ6DQo+Pj4+PiAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+Pj4+PiAgICAgICAgIH0NCj4+Pj4+ICsgICAgIGFtZGdwdV9n
Znhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7DQo+Pj4+Pg0KPj4+Pj4gICAgICAgICByZXR1cm4gMDsN
Cj4+Pj4+ICAgICB9DQo+Pj4+PiBAQCAtNjE1Miw2ICs2MTU4LDcgQEAgc3RhdGljIGludCBnZnhf
djlfMF9zZXRfY3BfZWNjX2Vycm9yX3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0K
Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIHR5cGUsDQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZW51bSBhbWRncHVfaW50ZXJydXB0X3N0YXRlIHN0YXRlKQ0KPj4+Pj4gICAgIHsNCj4+
Pj4+ICsgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOw0KPj4+Pj4gICAgICAg
ICBzd2l0Y2ggKHN0YXRlKSB7DQo+Pj4+PiAgICAgICAgIGNhc2UgQU1ER1BVX0lSUV9TVEFURV9E
SVNBQkxFOg0KPj4+Pj4gICAgICAgICAgICAgICAgIFdSRUczMl9GSUVMRDE1KEdDLCAwLCBDUF9J
TlRfQ05UTF9SSU5HMCwgQEANCj4+Pj4+IC02MTczLDYgKzYxODAsNyBAQCBzdGF0aWMgaW50IGdm
eF92OV8wX3NldF9jcF9lY2NfZXJyb3Jfc3RhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
DQo+Pj4+PiAgICAgICAgIGRlZmF1bHQ6DQo+Pj4+PiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
Pj4+PiAgICAgICAgIH0NCj4+Pj4+ICsgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1
ZSk7DQo+Pj4+Pg0KPj4+Pj4gICAgICAgICByZXR1cm4gMDsNCj4+Pj4+ICAgICB9DQo+Pj4+PiBA
QCAtNjE4Myw2ICs2MTkxLDcgQEAgc3RhdGljIGludCBnZnhfdjlfMF9zZXRfZW9wX2ludGVycnVw
dF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgdHlwZSwNCj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBhbWRncHVfaW50ZXJy
dXB0X3N0YXRlIHN0YXRlKQ0KPj4+Pj4gICAgIHsNCj4+Pj4+ICsgICAgIGFtZGdwdV9nZnhfb2Zm
X2N0cmwoYWRldiwgZmFsc2UpOw0KPj4+Pj4gICAgICAgICBzd2l0Y2ggKHR5cGUpIHsNCj4+Pj4+
ICAgICAgICAgY2FzZSBBTURHUFVfQ1BfSVJRX0dGWF9NRTBfUElQRTBfRU9QOg0KPj4+Pj4gICAg
ICAgICAgICAgICAgIGdmeF92OV8wX3NldF9nZnhfZW9wX2ludGVycnVwdF9zdGF0ZShhZGV2LCBz
dGF0ZSk7DQo+Pj4+PiBAQCAtNjIxNCw2ICs2MjIzLDcgQEAgc3RhdGljIGludCBnZnhfdjlfMF9z
ZXRfZW9wX2ludGVycnVwdF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+Pj4+
ICAgICAgICAgZGVmYXVsdDoNCj4+Pj4+ICAgICAgICAgICAgICAgICBicmVhazsNCj4+Pj4+ICAg
ICAgICAgfQ0KPj4+Pj4gKyAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsNCj4+
Pj4+ICAgICAgICAgcmV0dXJuIDA7DQo+Pj4+PiAgICAgfQ0KPj4+Pj4NCj4+Pj4NCj4+DQoNCg==
