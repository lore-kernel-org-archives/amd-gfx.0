Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0675CA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 12:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAFC10E882;
	Thu, 14 Aug 2025 12:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AdZzue5A";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBF610E882
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 12:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XumXCm+hbc/7b1lGZJ5FDtHDgQ4EpwDMh8/lcKpQ1iT7iZeZfL+v1X1Gn61lcLkH5VIgpW62mQ01Otx9TXWKZj2duJQnupQZGGKKGnEBDByvVIR91hTYNh9gpjSDxAEiEM/X+QtqNyjQelsdv3KF/fOIE8S+ihgt23N5n+yUoYYbJLNnviz7/6AkLIBRPq2BCNcNuFGtNRfeDVbaSMl7jvvlKdPw2SirRtOtrwU1c7/XKqkPm1lm6jVkU5TYp1irwlBVclCRfB8eJkdly6PYAWJUfVok0CzSXYkge7cq6+rCEH4kzLYL3ApuuR2iPhBzlNlm2q0DZiJLBTws1s0r5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SGJHExk0SVWjeraXNhK5QNNqt/YqUfT5uCQSva7KMU=;
 b=MnYr+UAISiW3D4PQqLHqbYGS9IArVwX1D31KHVD/g7E0nb6uUZ5DHQgdpdNdxEZkirLCTaGL/85QhTA0K4aMlB2LMdJjfMqr/riAVqztWdcSn/OMRLOTDhYivCCeCFp5uOXQ1unwkvWOqk0OkDIrIyX+W0+7Mpr63D53BNcxyaq2N5hcZLw2JTxXlwgG2tAfY50yF4d6BsUPiFiyKCvzu5a4QbfyOcyCI0bZoJjYxVu2ZOL6P5ifrXRisWI1k/UYTAmJWt1SYytK2uxbom0nQzK7ea7jp3+xesEWFZWHgXKsAJq9R1iESKIh8olPlNy1T+pbA8r8tOu5YC7pS4d3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SGJHExk0SVWjeraXNhK5QNNqt/YqUfT5uCQSva7KMU=;
 b=AdZzue5A98SrZlyZxoCsUcEXVVGO6EFbQZUrGtEqzczWMm00qEgEJL6dp6QpuwCrWShXwdTemHzAdhH+LFRd0j96lw0jSdU1AFrSRAidm60kSrYCG6ITD6shMncuwp5fzcyGp6tHugCQZFaXl1dGXBphnNw/1cKXp/TLiw1M9jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 12:48:31 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 12:48:29 +0000
Message-ID: <3e0fe19f-68af-5802-0a33-bb5b63132f9e@amd.com>
Date: Thu, 14 Aug 2025 18:18:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Wu, David" <David.Wu3@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
 <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
 <422ce379-1a56-de36-c040-6da658dead63@amd.com>
 <DS0PR12MB780454748D8280FEAA9DF3339735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <dd993060-e357-ebe2-4786-cbff7f3eb60c@amd.com>
 <DS0PR12MB780432BEB1D74FE5685273F59735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS0PR12MB78045E926BE8E8D0B663CAEC9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <6ecd4ff4-d427-6c62-0c9f-21b7c601de79@amd.com>
 <DS0PR12MB780439434F2D1BD589ABC9359735A@DS0PR12MB7804.namprd12.prod.outlook.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <DS0PR12MB780439434F2D1BD589ABC9359735A@DS0PR12MB7804.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0057.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::11) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d71dd5d-3db2-4246-8b82-08dddb30de10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmRaKzJRMUhRaWZVY3NSNWd6VXR3aHBoTVJKZVEyblJvZFNkVkVURmZ6bkJM?=
 =?utf-8?B?Nks3bjNYL0ZHbVA5MUQrYUkxMU16N0o0QTFVVi9mSzNWc3R4YnBicnlBLzln?=
 =?utf-8?B?R3cvdjVKR3U3dWFMTXRBNCt2RjhxbnpxZEZwbmhvb1JWZGJMZjk5cnZMVFh1?=
 =?utf-8?B?NC9scDhFcEhjcHN1MmNQaHBkcDVUNHI5Z3ptK05IakU3aHhHUUk3eTRUOWtr?=
 =?utf-8?B?VHpYVk9vOWFjajJGOXJLYVNjMjJnNWgxR21PeWJQVy9mbjJORERKcWg4bmI2?=
 =?utf-8?B?bFJhQjVwSHNaTHQzcHp1aExxMDQ5R3kvbTJLdW9SWUZ1VCtPYm5ydlZmV3Fj?=
 =?utf-8?B?WlNZcjR2UW9yekd0YSs1TWtSeE5vV2wydTkzdHJTWUtHOVpJa0Q5dW1Kdzc3?=
 =?utf-8?B?dnc0UDlkNzdXUFdEeEprVXVjZlBPaTY0YlZjamd4OGlnNGNiR0I5YmhxVGRU?=
 =?utf-8?B?ZHQzZ29JWStRaDBselFpWUtyenQxQjZhR1ZPbjBlVHljanNxbkh2NW1FakpG?=
 =?utf-8?B?dnl4enhWc09DQWVMR2g2MzVnSmdSclh6TWN4NmZpbnp5MGl1Ylk1cWtHbjdH?=
 =?utf-8?B?U3JnbDZ4cS9wb1drWDRTSmNSWnBIQjVhQk1DQ0FKN2xiTzh2YUliK2h1WmZi?=
 =?utf-8?B?aWY1emFGdGUwT2dKWTJDSHNnSytpMFVRalFpTTI4K0laZEsvUjc4NDcwbFVh?=
 =?utf-8?B?UXcyUDNmNGVQejJ0STNqZFB6Mm1DNFkyN0ZjVEFldENDbFp6MEVjVnVITUxv?=
 =?utf-8?B?WG9IaUVnOURWN2RId2I0eUJkSHUySkxDSUZNZEMyeVM2M1g4UVFzRFlKKzlR?=
 =?utf-8?B?YkRWQWVSWDM5dTBuWklvdVRSTHd6UmlaaDFVU2FTNDRLd3VNczZIdUsxZ3Ax?=
 =?utf-8?B?TXQvTDRkTHJKTldueE95SzdNUngxeWM2UmJ4T0lQK2dTTnlLK1hTM0EwcGpz?=
 =?utf-8?B?alFZejREcjhoSzJ3bm5wd0dFTCtuOUxHTDhiWWo5SnBIc3NFaWhyYmFpbGF1?=
 =?utf-8?B?dEl1QWI1c3J5dS9mUWQ3QThqQWhpT0FmdW55ZmxqbFVtWVo3M3ZZWjBEVU1v?=
 =?utf-8?B?M0xscWdnV251L2hNSHd6Wm1meHdnSFcrVFhNTWUzN0liRWdyMlkzcFR4bHc3?=
 =?utf-8?B?eGczL0RpdWw2Y1h4US9hNjROeUJxVkhpeVVGcmRFbHRvRitlZkhGSFNBRTlM?=
 =?utf-8?B?MGpESEhuTWFNM1BHb05ZK0JrMThJNGNFbFlYdTdDbVVLVGx3elhhd3phRmJx?=
 =?utf-8?B?M1FhS2hwbFRqYnZESU5ydFh6eFFhTHZVeHczYWlkaHVvZ3AxQ05yTHZTVURl?=
 =?utf-8?B?RTlpUHBBMC8wdzZjamVHZTZFMTBkR3BSc2lpUWNkdFZxYkwzVnREbHFFMG9N?=
 =?utf-8?B?UFpKWHd5UEtlQW9iY290eUozU09CNlBlUlcyOGpOZ21TNVNrU2UyM21haXl1?=
 =?utf-8?B?aFVpcDRTa0dxQlYzTElWZWhuWkQ1TFllRE84RUNaUGViYXRhQk90SEtaaXZL?=
 =?utf-8?B?K2pRaTZjY1p3VytyVUh6WVcvYXJtUHJVY0hNL1JQeUJ4a1lSOXJFZUN1MC9R?=
 =?utf-8?B?U1VUOXlzcm5JdnJIRzBtNisralpsbUFidnpUbjRVL3o5bnhORXRMMjlhK3RI?=
 =?utf-8?B?ZmNaS09RRTRJU0Q0eWZ1QzJMRzRWaFFac0tweExKSkM0QVA4a0x3RU84VGZJ?=
 =?utf-8?B?MUJTUWdOaDJ1b2dTVFF1OWc4R3JBcnFkZnVtQkIxOTI5M3lKaXZYaVAyUEVo?=
 =?utf-8?B?MlhkYkxyUHpvR0JyUWRxS3NGOVYybHVicFJldWtOd0tBdUtud3pmYVZTVFFP?=
 =?utf-8?B?QTJDZHVGaDVSa21veWhadVlGUm5ScXdUS2k0UnV5VE5oZUFiNTZRTUZtSGhC?=
 =?utf-8?B?dmhEckozMFZNSUZUUHVMQ1M2UGx5YmdGcnFwY3RDWnQ0OFVYcFVrTnlFd0Zj?=
 =?utf-8?Q?mTm3Kzei+/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRzZ1l5NE5FMVJsb2JOby9oNThtYVdQY3dWRlEwN1k1VHkrNExUMXBCS3Jp?=
 =?utf-8?B?bktiWHZYK0NHbGNQbmw0TUxxY0IxZDMya2hsQytyZC9GaklFSFo2K1k0OWx3?=
 =?utf-8?B?MXEzVGxqZWcrckI4S0FnY1ZTL00zU2E1cFNJUS8reE1mRHl5ZnpCZmVnT2Rj?=
 =?utf-8?B?aFJ2TGEvam5vOWhxTmdQOFpjRGdFLzQ0VjZkZVJNdzFQdVhoVTRteGN3a1dR?=
 =?utf-8?B?MkxVNittaS9QRHJWMjNsb1A2UEVML085aGIvT1QvalVHQ2VZZjVpMWxJQndi?=
 =?utf-8?B?K0VjTzZSelVUUnZQRzlodlk3WVNqcjZhRlVKOHdPZG8yT0JrWUhxUFJnbVZq?=
 =?utf-8?B?cklIemx5V3Rna21YVm1LNlhkS3Z4eWNua1E4MUJlTUcrWFNYanFscEZpQkpt?=
 =?utf-8?B?blNCdmVMVW5OTzlxTFJneTh0S1pFTW0yV1h0VERxWHIwQmorTmRSWjYycGFP?=
 =?utf-8?B?KzlKRTNNNG9aTE12Z28zYVZxSEhJMjVHOTducmdZajBtUlNkVkdsNjlvalBl?=
 =?utf-8?B?NnVtME1Kck0rMGo2cUk1R0JDaWJHVHBWQ1BEcGtLQWZJRC9rRGgraWlCZURJ?=
 =?utf-8?B?d0U3Wk9Ud0IwS0E5OHpDT2plb2lHRmNucnplbXpza0FmZXM1NlIyeVNpbG5P?=
 =?utf-8?B?WXpjb1g1ajBjUzMvcXBEWE9VdnRWSGxmdXFIWlIvWE43Mkx4UFpOZUdmT21C?=
 =?utf-8?B?YWpNUWNoNU0zN0Q5VkptclB6RFRUR09XWStvQUs0TkNUOXViWi92UGpFcTN5?=
 =?utf-8?B?cGZ5WmtWNTNlSFErTTF4TGlpK2EwR3ltQ2dXWHU3YnFVQndxS3Y1NzdYLzBJ?=
 =?utf-8?B?djJNanhXTlhIV2FzZGJGYU81c0JUZisycE41a3ByajhYWjFaRVdYdlgxeVdX?=
 =?utf-8?B?WFpIRG5XWjREa3pwdElsVFJHeFNWbSsrODluVUthTnZMWlRGcGRoSXpBSk83?=
 =?utf-8?B?TkhrMnVXaDRmSnM1WDJZOE9kY2czWGFUa3JMS3JyeWEzN20rRmdSMGkrc0l1?=
 =?utf-8?B?aU0xVkQ3WnFQeXNwMlBhc0ZhUlpkRkdiSkoyVGg2c2Nqb1N1NXR2OFVnMWV5?=
 =?utf-8?B?SEJCalRKU3lFdHV3TFcwcmZNbzZRZG1CNXd1NGVlaWl1SlQ1RTdWSS9xVXVK?=
 =?utf-8?B?Qng3TkpxQW1WZlQvT3owZHJaVjFVVTVDZFJpTXNOSnFNdlU3L3RWUERYUHJ5?=
 =?utf-8?B?SzRCU1duZnVnMGJqMUhzWmhlckdNZWVMVnZ0UVlYeXZzVThjRTdQdU9JeE1v?=
 =?utf-8?B?a3NjTXBEVUJ3YmxIbkZqU3VGZlFHdEpnRnRmanRpM0pEK2VvbHJhR1ZZNWU5?=
 =?utf-8?B?TEYvSmNwdWFxQSt6TWhNcWk3WkJxL0VEbUFvdG9RaFlvSDh1aTJiME5taFpj?=
 =?utf-8?B?bG95c0tyM2UxWk9QK2tzN1ova2FscnJpSDIxSkhvTWppMHpCQUpLM2hTMklU?=
 =?utf-8?B?LzRES1JNTi9jNEkwQ3hFcTdhYTdiNUZjTm4rb3R4Q0loREVoZGlnT0t6ek1r?=
 =?utf-8?B?Mzltck1uUDNWU0JoeGpoQk42UzdXa3NBbWVIQXgzdXYwWFcyY2E0Wng0OStM?=
 =?utf-8?B?Um5FUUFVSnRPRklaZ08wc1oraVFhejAzaTF1VTZwTU1MdFlETkpzV0o3WTM1?=
 =?utf-8?B?Y2VWbWNNdUg1YUlMbm1kdDI0b2UwQ1ZEeVZzMFZEZXROMXdDc1NOQUdqaW1u?=
 =?utf-8?B?cm1CS1RQWEJGK010alEyTGozOG95dFB1ZE40eWg1RFhvcnFFeG9iT08zTUo3?=
 =?utf-8?B?ZHNjZk84MW9KOHc4bEhYSDdHTTRLMG1YdDVQalVUTi95YXB1Q05lSnY4WUwr?=
 =?utf-8?B?a041VnI2OFRzTXo1Rk1Mb1RLZWZNeVliRmV1bDRsRnhCZFZ5V3ZHUzkxNUJ4?=
 =?utf-8?B?Y2MvTFIySGV0TjByWDJuRTdPNVFKc0c5ZW83Q0MxajRnYlhLSGsvbXJmdmps?=
 =?utf-8?B?bituQnh4dTNqbTg0cmJaVnZRQmlZVCtsY1BCMFErQkEweWdVb3plaVJoYVkv?=
 =?utf-8?B?VlA5YVdOclNMSjMxS3BBZC9icVhuMTV4eVdMaG10MUVlY0NJUlBrbHJmbnZB?=
 =?utf-8?B?REphb2ZWMjIydFFRelRpdUVMdFh4NE1LejlSa3V0bjB4VnRZSG1XeUdYYlh2?=
 =?utf-8?Q?2M0Rr81re7+VUUNRUT8ryzuj9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d71dd5d-3db2-4246-8b82-08dddb30de10
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:48:28.9321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mqYemwwo06SEqWsJzNwRcH2e381XZe9uDzIrWikcD0JFLqbn6fE3pL6BDrh/u/yUp19Tzj6Uj5qd41WpAXtOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
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


On 8/14/2025 5:33 PM, Lazar, Lijo wrote:
> [Public]
>
> There is no need for nested lock. It only needs to follow the order
>          set instance power_state
>          set profile (this takes a global lock and hence instance power state will be visible to whichever thread that gets the work profile lock).
>
> You are seeing nested lock just because I added the code just after power state setting.

Pasting your code from the file for ref :

@@ -464,32 +509,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring 
*ring)

-pg_lock:

      mutex_lock(&vcn_inst->vcn_pg_lock);
      vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);

+   amdgpu_vcn_get_profile(adev);

vcn_pg_lock isn't  released here yet right ? And in-case you intend to 
only order the locks, then still there is an un-necessary OFF followed 
by ON, but yes that is acceptable,

May be you want to move that vcn_pg_lock after amdgpu_vcn_get_profile to 
protect concurrent dpg_state access in begin_use.

The concern is, this patch access power_state that is protected by some 
other mutex lock hoping it reflects right values also when holding 
powerprofile_lock.

Or

Have shared a patch with global workload_profile_mutex that simplifies 
this handling, and renamed pg_lock -> dpg_lock  and used

that only for dpg_state changes per instance.

Regards,

Sathish

>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Sent: Thursday, August 14, 2025 5:23 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
>
>
> On 8/14/2025 3:16 PM, Lazar, Lijo wrote:
>> [Public]
>>
>> I see your point now. Attached should work, I guess. Is the concern more about having to take the lock for every begin?
> This is closer,  but the thing is, IMO we shouldn't have to use 2 locks and go into nested locking, we can do with just one global lock.
>
> Power_state of each instance, and global workload_profile_active are inter-related, they need to be guarded together,
>
> nested could work , but why nested if single lock is enough ? nested complicates it.
>
> Regards,
>
> Sathish
>
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Lazar, Lijo
>> Sent: Thursday, August 14, 2025 2:55 PM
>> To: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>; Alex
>> Deucher <alexdeucher@gmail.com>
>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>> (v3)
>>
>> [Public]
>>
>> That is not required I think. The power profile is set by an instance *after* setting itself to power on. Also, it's switched back after changing its power state to off.  If idle worker is run by another instance, it won't be seeing the inst0 as power gated and won't change power profile.
>>
>> Thanks,
>> Lijo
>> -----Original Message-----
>> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>> Sent: Thursday, August 14, 2025 2:41 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>> <alexdeucher@gmail.com>
>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>> (v3)
>>
>> Hi Lijo,
>>
>> On 8/14/2025 2:11 PM, Lazar, Lijo wrote:
>>> [Public]
>>>
>>> We already have a per instance power state that can be tracked. What about something like attached?
>> This also has concurrent access of the power state ,
>> vcn.inst[i].cur_state is not protected by workload_profile_mutex
>>
>> every where, it can still change while you are holding workload_profile_mutex and checking it.
>>
>> Regards,
>>
>> Sathish
>>
>>> Thanks,
>>> Lijo
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Sundararaju, Sathishkumar
>>> Sent: Thursday, August 14, 2025 4:43 AM
>>> To: Alex Deucher <alexdeucher@gmail.com>
>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>>> (v3)
>>>
>>>
>>> On 8/14/2025 3:38 AM, Alex Deucher wrote:
>>>> On Wed, Aug 13, 2025 at 5:1 PM Sundararaju, Sathishkumar
>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>> On 8/14/2025 2:33 AM, Alex Deucher wrote:
>>>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>>> Hi Alex, Hi David,
>>>>>>>>>
>>>>>>>>> I see David's concern but his suggestion yet wont solve the
>>>>>>>>> problem, neither the current form , reason :-
>>>>>>>>>
>>>>>>>>> The emitted fence count and total submission count are fast
>>>>>>>>> transients which frequently become 0 in between video decodes
>>>>>>>>> (between jobs) even with the atomics and locks there can be a
>>>>>>>>> switch of video power profile, in the current form of patch
>>>>>>>>> that window is minimized, but still can happen if stress
>>>>>>>>> tested. But power state of any instance becoming zero
>>>>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>>>>> Consider this situation, inst0 and inst1 actively decoding, inst0
>>>>>>> decode completes, delayed idle work starts.
>>>>>>> inst0 idle handler can read 0 total fences and 0 total submission
>>>>>>> count, even if inst1 is actively decoding, that's between the jobs,
>>>>>>>        - as begin_use increaments vcn.total_submission_cnt and
>>>>>>> end_use decreaments vcn.total_submission_cnt that can be 0.
>>>>>>>        - if outstanding fences are cleared and no new emitted
>>>>>>> fence, between jobs , can be 0.
>>>>>>>        - both of the above conditions do not mean video decode is
>>>>>>> complete on inst1, it is actively decoding.
>>>>>> How can there be active decoding without an outstanding fence?  In
>>>>>> that case, total_fences (fences from both instances) would be non-0.
>>>>> I mean on inst1 the job scheduled is already complete, so 0
>>>>> outstanding fences, newer job is yet to be scheduled
>>>>>
>>>>> and commited to ring (inst1) , this doesn't mean decode has stopped
>>>>> on
>>>>> inst1 right (I am saying if timing of inst0 idle work coincides
>>>>> with this),
>>>>>
>>>>> Or am I wrong in assuming this ? Can't this ever happen ? Please
>>>>> correct my understanding here.
>>>> The flow looks like:
>>>>
>>>> begin_use(inst)
>>>> emit_fence(inst)
>>>> end_use(inst)
>>>>
>>>> ...later
>>>> fence signals
>>>> ...later
>>>> work handler
>>>>
>>>> In begin_use we increment the global and per instance submission.
>>>> This protects the power gating and profile until end_use.  In end
>>>> use we decrement the submissions because we don't need to protect
>>>> anything any more as we have the fence that was submitted via the
>>>> ring.  That fence won't signal until the job is complete.
>>> Is a next begin_use always guaranteed to be run before current job fence signals ?
>>>
>>> if not then both total submission and total fence are zero , example
>>> delayed job/packet submissions
>>>
>>> from user space, or next job schedule happens after current job fence signals.
>>>
>>> if this is never possible then (v3) is perfect.
>>>
>>> Regards,
>>>
>>> Sathish
>>>
>>>> For power gating, we
>>>> only care about the submission count and fences for that instance,
>>>> for the profile, we care about submission count and fences all instances.
>>>> Once the fences have signalled, the outstanding fences will be 0 and
>>>> there won't be any active work.
>>>>
>>>> Alex
>>>>
>>>>> Regards,
>>>>>
>>>>> Sathish
>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> Whereas if instances are powered off we are sure idle time is
>>>>>>> past and it is powered off, no possible way of active video
>>>>>>> decode, when all instances are off we can safely assume no active
>>>>>>> decode and global lock protects it against new begin_use on any instance.
>>>>>>> But the only distant concern is global common locks w.r.t perf,
>>>>>>> but we are already having a global workprofile mutex , so there
>>>>>>> shouldn't be any drop in perf, with just one single global lock
>>>>>>> for all instances.
>>>>>>>
>>>>>>> Just sending out a patch with this fix, will leave it to you to
>>>>>>> decide the right method. If you think outstanding total fences
>>>>>>> can never be 0 during decode, then your previous version (v3)
>>>>>>> itself is good, there is no real benefit of splitting the handlers as such.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Sathish
>>>>>>>> If it is possible, maybe it would be easier to just split the
>>>>>>>> profile and powergating into separate handlers.  The profile one
>>>>>>>> would be global and the powergating one would be per instance.
>>>>>>>> See the attached patches.
>>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>> can be a sure shot indication of break in a video decode, the
>>>>>>>>> mistake in my patch was using per instance mutex, I should have
>>>>>>>>> used a common global mutex, then that covers the situation David is trying to bring out.
>>>>>>>>>
>>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using
>>>>>>>>> flags to track power state could help us totally avoid this situation.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>
>>>>>>>>> Sathish
>>>>>>>>>
>>>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>>>>>>> Hi Alex,
>>>>>>>>>>>>
>>>>>>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer
>>>>>>>>>>>> in case someone adds more before the lock and not reviewed
>>>>>>>>>>>> thoroughly)
>>>>>>>>>>>>          - up to you to decide.
>>>>>>>>>>>>
>>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> David
>>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>>>>> If there are multiple instances of the VCN running, we may
>>>>>>>>>>>>> end up switching the video profile while another instance
>>>>>>>>>>>>> is active because we only take into account the current
>>>>>>>>>>>>> instance's submissions.  Look at all outstanding fences for
>>>>>>>>>>>>> the video profile.
>>>>>>>>>>>>>
>>>>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>>>>
>>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload
>>>>>>>>>>>>> profile
>>>>>>>>>>>>> handling")
>>>>>>>>>>>>> Reviewed-by: Sathishkumar S
>>>>>>>>>>>>> <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>          drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>>>>          drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>>>>          2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>>>              struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>>>>                      container_of(work, struct
>>>>>>>>>>>>> amdgpu_vcn_inst, idle_work.work);
>>>>>>>>>>>>>              struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>>>>              int r = 0;
>>>>>>>>>>>>>
>>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>>>>>>                      return;
>>>>>>>>>>>>>
>>>>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>>>>> -             fence[i] +=
>>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>>>>> +             struct amdgpu_vcn_inst *v =
>>>>>>>>>>>>> + &adev->vcn.inst[i];
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>>>>> +     }
>>>>>>>>>>>>>
>>>>>>>>>>>>>              /* Only set DPG pause for VCN3 or below, VCN4
>>>>>>>>>>>>> and above will be handled by FW */
>>>>>>>>>>>>>              if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>>>>>>                      struct dpg_pause_state new_state;
>>>>>>>>>>>>>
>>>>>>>>>>>>>                      if (fence[i] || @@ -436,18 +442,18 @@
>>>>>>>>>>>>> static void amdgpu_vcn_idle_work_handler(struct work_struct
>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>                      else
>>>>>>>>>>>>>                              new_state.fw_based =
>>>>>>>>>>>>> VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>>>>
>>>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst,
>>>>>>>>>>>>> + &new_state);
>>>>>>>>>>>>>              }
>>>>>>>>>>>>>
>>>>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>>>>                      mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>                      vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>>>>                      mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>>>>> !total_fences &&
>>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>>>>                              r =
>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, false);
>>>>>>>>>>>>>                              if (r) @@ -467,16 +473,10 @@
>>>>>>>>>>>>> void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>>>>>>>>              int r = 0;
>>>>>>>>>>>>>
>>>>>>>>>>>>>              atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>>>>
>>>>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>>>>> -      */
>>>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>>>>> -
>>>>>>>>>>>>>              mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>> move to here:
>>>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>>> I think this should work for multiple instances.
>>>>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>>>>> David
>>>>>>>>>>> Alex
>>>>>>>>>>>
>>>>>>>>>>>> David
>>>>>>>>>>>>>              if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>>>>                      r =
>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, @@ -487,7 +487,6 @@ void
>>>>>>>>>>>>> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>>>>>>>>              }
>>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>>
>>>>>>>>>>>>> -pg_lock:
>>>>>>>>>>>>>              mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>              vcn_inst->set_pg_state(vcn_inst,
>>>>>>>>>>>>> AMD_PG_STATE_UNGATE);
>>>>>>>>>>>>>
>>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct
>>>>>>>>>>>>> amdgpu_ring
>>>>>>>>>>>>> *ring)
>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submissi
>>>>>>>>>>>>> o
>>>>>>>>>>>>> n
>>>>>>>>>>>>> _cnt);
>>>>>>>>>>>>>
>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission
>>>>>>>>>>>>> _
>>>>>>>>>>>>> c
>>>>>>>>>>>>> nt);
>>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>>>>
>>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>>>>>>                                    VCN_IDLE_TIMEOUT); diff
>>>>>>>>>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>>>>
>>>>>>>>>>>>>              uint16_t inst_mask;
>>>>>>>>>>>>>              uint8_t num_inst_per_aid;
>>>>>>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>>>>>>
>>>>>>>>>>>>>              /* IP reg dump */
>>>>>>>>>>>>>              uint32_t                *ip_dump;
