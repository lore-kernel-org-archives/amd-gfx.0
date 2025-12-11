Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71B0D3E796
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 06:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2840010E08B;
	Thu, 11 Dec 2025 06:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HOrx/UU4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1AD10E08B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 06:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435169; x=1796971169;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ik59QmMDdKjRVbZ7chJcSB1YontjytN8OPq0Qh5QZuI=;
 b=HOrx/UU47+ZhKYmrqpGndWd2vF4FFyzstrVJV2xAlUbkMgrw9V3/Dya2
 PG4jBt3+kUlQc5PcxuzrqQCruk8Jajk4yt+UcBdgHxd4L7FJ1Nd4v/Fow
 2OjSH61N8JB3H+JufRlZgMo8kS48RV5d8LqfdxmLlwZEs7x0Mh9M0c38k
 BvMJUBljvHAAye4XMS2dAKMEMP/ZDFnTaIzbWiB4CV0qrG0d1Aau45QLJ
 Dy/enisj9vzKNZ+GxJf3aHR+LxGLpgnQi28m0FGZjuAsRYXC2v6nS9HJ7
 Ycq/ECvfX8qm2oFEyL+jA5vbh/GtS8OzyUqFJVWOUFjO35ywKjdxef27v g==;
X-CSE-ConnectionGUID: h10OuTMLSz2DH8m2VR6Pkg==
X-CSE-MsgGUID: hMU9d7tkRduq2srTLJPHMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67583627"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67583627"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:39:28 -0800
X-CSE-ConnectionGUID: pLlbOVDcSPCL0IofpxVi0g==
X-CSE-MsgGUID: CZzrsLDhT1GYuMACwTSKKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201814637"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:39:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 22:39:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 22:39:27 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 22:39:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKB7tSBqO3CvB/M7+emjp5cOh6yhcbmlmqAJ6ZQT8+ZJTjNiAvOnu1WD47++cvQprq+OZl2cfTvxVYJWCElqpGmnXFzM9ttu92ZYjiQ+ofDdUO+3PQ3MOl2V2SdiEDFGtsDRCuTZhomGKwtkBpOUahIjZS7gUJ0lOQ5SfuHICagTfopdg4Q9DqbWYG3yxdmYmae18oj2amL8oJ1w90jAYZElE4eP4zk5mQLLQigo1w+ThKyEC18A8LWLvMYRsaMnpa61/hp+4uyUyIgAa8Y6u9xqZIK5ULl5X48nSREbc7x2U+NJNA+vkILeWu8y5siJ51PFnDTKduJ6sM3iA4dKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVyCXuzsL19Qu9JjYrBW5DK+Yr5NPRUDqrzdpUdxhuQ=;
 b=oHe85ZHDJ/5M69A5rbDeFYa4rBa2IUSMo+Ri8OvgUQn85nCcXxFzbfZwvQyc8FMN01uNVLSwj3XIpsiPx/Ifubl98i4iBdEoxmJ3oyuNT4i0V1SBu7I+Hyif5qWp/QteYK5buBYdlDnuJ8LAqk8kvQXNQQGfk9RqfDTB/GlbxzD1szVx8Qm8rM14606Job68wDc42lhW/DfSEV/wl42DsEKHhJsNZM6+E2OpUwJFKCpDCeCDNudyzkttVXtCfHvdrDDMS7ErcX90dsVjcF4uqMZmOQneWgxDxKYeicLQMZPlAd97bTPBpwZoXYKQCEHgI7AWMWW5nHCCxSjt2VzfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 06:39:24 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:39:24 +0000
Date: Wed, 10 Dec 2025 22:39:21 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
CC: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
Message-ID: <aTpnGZQjQUbuxcsq@lstrano-desk.jf.intel.com>
References: <20251210202347.63243-1-alexander.deucher@amd.com>
 <adf41aa5-3172-4e9e-9bfc-c8b853b7c0c0@amd.com>
 <IA0PR12MB820858B3F15710B5E2C6255B90A1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <14ea9e1c-0deb-4d2b-8bea-ef95300b753c@amd.com>
 <89b93863-b8ef-4629-979c-5a3d1e906594@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89b93863-b8ef-4629-979c-5a3d1e906594@amd.com>
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfffcd1-4892-4692-680e-08de38800608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mmg5TWl1QUJIeSsyNXdQWUl1Nmh3Y0F4Q3U5NHJRaktsUEV2cGZmSTR4SG1z?=
 =?utf-8?B?S3htdWo2cXhsSzlMakd5MlpXN3I4V1JEYi9QK0x3WDE1amxsdGdxR3Y2WmFF?=
 =?utf-8?B?K0p3Tk05eHpQYzZpUXBoSEFCeGY1azd0TTluSXlRNSs3bWtlR3AvOTYreUt1?=
 =?utf-8?B?dkswSTV1UjdoZW90UkF2S2FIQkV1clEvM1lteEptczVhSkk3cFBqQjQ2TE1Z?=
 =?utf-8?B?MDk3Y1pieUF0MnRTRFBoYkxuQWlQS0o5RjAzYkxSd1B1S3RVSjdLODI3VnZJ?=
 =?utf-8?B?TWUzUHhtUWRSNnU2NEQxMHVQeEhoM2k1eTNEZGV6YW82Yy9kNFVxV2llbEFs?=
 =?utf-8?B?OXdQZGFCU2k4OURtV1Z1WWQ0ZmdWMk1KeEtxaFU1MkJ1VmZtRm5ycUFnNTB0?=
 =?utf-8?B?UU13cFFHekQyS3dZS1FSWko3OTFIS09aQ3lrTXYrcnJPWWpuNXZoRFo4bmZC?=
 =?utf-8?B?SHdOM1I3dmZUWElEZzRCTTZFV1JNMnZCZnF6eHROS015Y25VSHVRL3NjMi9o?=
 =?utf-8?B?OUNQcksxenN3MWg1RlBtS3F6NUtZSDRUbE4veVRRMm5yUGRBbGZVYlVWbThk?=
 =?utf-8?B?QWFpUHV2bnpodVgvOUZvVFBNZzQzcHhMNElGN2JKaUJrblJvSTNMUWd3V2s2?=
 =?utf-8?B?OStxRk4xQW9lNG5FWmVJWitIZ0Fpa3BLbkYrSTZXQ2pMT3J2eExWYTR3aitL?=
 =?utf-8?B?Ri9jREovTGM3bE1JZXZVTGFBWXdpUEpORXdrend4NTB4ODNZZzdSVnFDQStv?=
 =?utf-8?B?Z0Z0djB5QXdyVmdRMHluYmFaaDUxRXhYRmtEZWFKUFZBbVlITmdKSWdLUFA4?=
 =?utf-8?B?cVQrU0VsbTRxSDJ4QnZNQnpKbk04UysvUm5DU1BlRk1xSEcyNndORTNLZ1po?=
 =?utf-8?B?ZmVoQ0VVZ0s3Y2lhZTNOMjBJVmFFV25mdUFZRGo5VjJYR1JRVGJKOHBCRkJD?=
 =?utf-8?B?ZGxEUzAwanJsc3JSMkpRdDdGSTRoVEdRLzVHbTBpRDc4TlU3MkR3bnhPenYz?=
 =?utf-8?B?MUFLcVo1cGNxN1RnK0dtWXVIMmpCTXhuRGttbGlNbVVIVFdxL2xWTlBtQnJC?=
 =?utf-8?B?MzZuWXNsTUdUazVtNzBNYW5kUFJ4TUJnSXd2QzlwMmpPTzlhMTErS3JpTUwy?=
 =?utf-8?B?RGZ4NXVqdVdmMWdnd3JDckRHWlRZRnZuMUFxRlp0aGxBWGhGd0tIQkR3QlR5?=
 =?utf-8?B?dFR6VnM3NE9mbnRDd3BkaC9Pc2ZCSzdCSmRYTWpPNlNPSExzVThxaXJpSGc2?=
 =?utf-8?B?c2dlcERXQjh3R081SjFHQWFNRW80YnhVN2tQQ2tuZmlsclVMd2JWL0l2aHdp?=
 =?utf-8?B?MEt0alI2dXd3SHVSNnN1ZjdmdEQ4WFBaaGE1aXl3RmVSUzNxdjY3Z3h5MDZv?=
 =?utf-8?B?VDVxdVh1YndqR3B2MHpla3g2Q3RsMzFaNjZGR09NYjhwY0ZkVHpiVkhYVy9W?=
 =?utf-8?B?eW04QUwyOEhLVmNoMnZYWUR4aDN1NVROM0pZWE1BSmluL3M0dnR0VG9FaFdX?=
 =?utf-8?B?VzlZVFRKMzZ6OUxOYkdHNEUxbGo4WU5HMWpqUFY3bHFMbTYrYU5QOXdZY0s3?=
 =?utf-8?B?VU9IYjkrcTVKd0hiU2JWMGxrSVpXa05ndmpKN3V3eGJLRXJWT3djNnpBMURn?=
 =?utf-8?B?UENHWm51V3RFck9KY0p1anF2QnJHS1lpOHVJRTlzS3E2a2xBdHRUYVZxamxw?=
 =?utf-8?B?MnBhWjZtU2dTQm94c0wvMno5LzhBNlhEVW1aMW9hQzJBTFhNa1FaNkNPS3kv?=
 =?utf-8?B?bVdRQW5WNDlrYTlYdlhySmg5a1ZvcTJJMksvd3FpYXVkVXYrejVwL25MeG5Y?=
 =?utf-8?B?Y3E5NG5uT29Tb2JPUnZCcWRPakxuNEsyaEdVU1RMNDlWeXZWeC9LRzJCMkQv?=
 =?utf-8?B?Mk1SVTVrV3JaaVp5VnpkYW4yczdkZnJ0YXNSUlFVL2VKTUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1NYTBsRTdsUzg1bjlrSTEyQ3BqSWxtY1hVKzh6T1RTZUhURkJJeVNRbktm?=
 =?utf-8?B?NGZBTkgzam5qUHFrdnFZQnlPaEZKaS9EUC9DR3dVQTlMUStYWGRleXFMTE1O?=
 =?utf-8?B?WXcralZqVUpreVdSYWlxa2N1RnB2bHkrc1Y3N3NGQ0tkeGpVVEFzY1p4QzRt?=
 =?utf-8?B?RER3Rkw4TkJnTThBelJ1OXVKdmRlWThoeVRFTTA5REdsL3ByVWpidDZjOFlB?=
 =?utf-8?B?NzcyWHlSbXlKOFFveGkwdDdLMDVaQ0g1cmw5TnFvS2hERW00WjJKWkQzM0do?=
 =?utf-8?B?azJhT2p2emNGUzhIdk1TaEdtazM1dlRRZXNWeDRXUlJNTXNlSnFiQ0J6ZUtr?=
 =?utf-8?B?Vy9MVHBOZm5sODFKMk5sNmpVN2pjSGgzYis1cGZPdEM3Smh1K1NEb3hPZHIz?=
 =?utf-8?B?WWdZWGRNWGViNXhxbklZWER0L2NDRnkvd2h4SlZST3FrSXBUN0F1OFNhbXJ4?=
 =?utf-8?B?VkdORXRQZEF3b2xrbEhVSTVYSWV0ZXNPT0lML3pLVy9QNGY3VEtJMFBSVlB1?=
 =?utf-8?B?WHJPN2lCUjN4eFJQUVRJWmh6SHRlOTRSWU9nK1VRVGwzZDFTNEVTd2FsUTRS?=
 =?utf-8?B?QWlEZ3I1emVQWGN5NHJnMUZkMC9ZUEtmUkxsRGRsWU9zd0luZ3ZKcWZteG1B?=
 =?utf-8?B?aSt3b282cy9NS2NUV2xudkpiZG5QOWl4M2I0QStjcXVMbG5kQzV0U2U0d1VE?=
 =?utf-8?B?TlMwWTZmd2hacjFKZkRReXRDK1hZUFFkRFBKTWVDWVJXUlFqaEtETUthSVJ6?=
 =?utf-8?B?aWw4dXdSc0lkOU41NWVCVVVaL29Gd2d1NjZ5RURNOEM5SFlNS3BDMzFKSWtE?=
 =?utf-8?B?citlS3NGdDRsQ2FhaHNuT2YwY1hPWnJ0clRXNDNlMzNMNzhwakZyMWdBZEZ0?=
 =?utf-8?B?TjJ6K3p1KzV5QUhvWkVweUdQbGlFKzU2bk4vRzJaZ3JFcEFYMFkrdTdKWThT?=
 =?utf-8?B?RGNWMVJZY3ZIemhuRTdoU0FqNlFBeGRIN2h2NHZIemZwc3RJK0F4NDYyL2ZL?=
 =?utf-8?B?Y1dYMndpVUR1RjJ0SllEUWtxZ21lQlRCNDdZL2Zrd2k5Z3V3cTg3TmcwVUE3?=
 =?utf-8?B?N3htM3A3S2xrSEdqMlVob1M3V3dTNlZrZDgrNy9TajJOZ2xqbHBrSzlOMkFo?=
 =?utf-8?B?UFdlaFBlcmdWTHpiOGFkenFYdHZWdzZiNXFXUFlSZ2VEcU9lUG1odm02Sy9I?=
 =?utf-8?B?SG9peWNCZzdoV0pvcGJKNjZRZEx6ZHlORjdKMDVxRXlCSUE1NExYU0p6Sllw?=
 =?utf-8?B?eVh2d2JmeFZWa0JZYlZtL0xhdCszVHFGUkJYQlJzZFdaVWlVOUxOb0FBMXFH?=
 =?utf-8?B?WTNTaUFDSVhKSDlsRTEvVk1odWQwS2JQSXVVWkNqekFnVHFrYmZMQ1U2VDJk?=
 =?utf-8?B?Q3R3MkRoamxwL0t4ZTZLbE9oVXQxTHpxSnBEUEllQ2tMRlpOMjBKWWdlLzBp?=
 =?utf-8?B?N0VrYzc0d09UR1I1U0NBbFcxbEwzSVRtWk9MbUNyb3dpTjhIMUNuTEZRSGd6?=
 =?utf-8?B?d3prb1N5NURqMXI4T0tSdlpyWkUrU2gvWkdBdklMMzQwUkZ3eUl2ZVFRbTNU?=
 =?utf-8?B?Z041ajR0Q1V2UG10aWlCVEV4SU8rYzNhaWtORFN4cnFrd3JmMEdtazJ1cGsv?=
 =?utf-8?B?TUJ6cDhuUzZBVDQ4R2lzeU9Id0Jwamc2aFJnQm5EWHAreDEzd21leFdxN3o0?=
 =?utf-8?B?SEs0NGRDeEFOc0c0ZHRDMEQ2NzdnbW1DUktHT3lSbnhBU1c0RG5aVlphdlRk?=
 =?utf-8?B?THhkR1JpWWp2WlZrbzQ4bFViNGRvMXFyelh1RUllYWdIT0RwbWtUTEw5QVNY?=
 =?utf-8?B?QURFWkdyekh5M0NRdnpQZy80OGZVaWNHUlN6QlpHNG5MTit6RFZXVnZyWHZZ?=
 =?utf-8?B?K1UxakFUdnYxck1WN3AvNGVaUm5Zdk1DOGlFcmZPVEtBYjhTUVVuTlprSjlv?=
 =?utf-8?B?b3F4MGpQbE0wZjNPOXUzVHdaL2g4endsR1NWWFdjUlZEY1lHMldaS0J2WEcv?=
 =?utf-8?B?bktNMVZvUWxGMzZIcDZPaHFrUXJPVlRFZVZscHh3S2Z2WjRBclN3Z0JxVlNM?=
 =?utf-8?B?YldwWW9mZ29LVDdVbDl4OVBqMzUvWGFaTS9QbW5MNW15MU45ZE9sSFFZSWda?=
 =?utf-8?B?SEhFWjNvMWpObCsxbVRSODEralZKUURlMTVOU09WeDY0Ujg5VVNxckRmTG5Y?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfffcd1-4892-4692-680e-08de38800608
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:39:24.3050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPvS4SATz55HpSsL9o3xrtWgTG7ICSnx8xGYYwosB5trLjwmqJ/Y2uElvfsRLwW5ZevGDtoEOP/WjvXwdx+YCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com
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

On Thu, Dec 11, 2025 at 11:37:58AM +0530, Lazar, Lijo wrote:
> 
> 
> On 12/11/2025 11:14 AM, Lazar, Lijo wrote:
> > 
> > 
> > On 12/11/2025 10:52 AM, SHANMUGAM, SRINIVASAN wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > 
> > > > -----Original Message-----
> > > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > > Sent: Thursday, December 11, 2025 10:34 AM
> > > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > > > gfx@lists.freedesktop.org
> > > > Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> > > > Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>; Matthew Brost <matthew.brost@intel.com>
> > > > Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
> > > > recovery
> > > > 
> > > > 
> > > > 
> > > > On 12/11/2025 1:53 AM, Alex Deucher wrote:
> > > > > Avoid a possible UAF in GPU recovery due to a race between the sched
> > > > > timeout callback and the tdr work queue.
> > > > > 
> > > > > The gpu recovery function calls drm_sched_stop() and later
> > > > > drm_sched_start().  drm_sched_start() restarts the tdr queue which
> > > > > will eventually free the job.  If the tdr queue frees the job before
> > > > > time out callback completes, the job will be freed and we'll get a UAF
> > > > > when accessing the pasid.  Cache it early to avoid the UAF.
> > > > > 
> > > > > Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
> > > > > Cc: SRINIVASAN.SHANMUGAM@amd.com
> > > > > Cc: vitaly.prosyak@amd.com
> > > > > Cc: christian.koenig@amd.com
> > > > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > ---
> > > > > 
> > > > > v2: Check the pasid rather than job (Lijo)
> > > > >       Add fixes tag (Christian)
> > > > > 
> > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
> > > > >    1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > index 8a851d7548c00..c6b1dd95c401d 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > @@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct
> > > > amdgpu_device *adev,
> > > > >      struct amdgpu_hive_info *hive = NULL;
> > > > >      int r = 0;
> > > > >      bool need_emergency_restart = false;
> > > > > +   /* save the pasid here as the job may be freed before
> > > > > the end of the reset */
> > > > > +   int pasid = job ? job->pasid : -EINVAL;
> > > > > 
> > > > >      /*
> > > > >       * If it reaches here because of hang/timeout and a RAS
> > > > > error is @@
> > > > > -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> > > > *adev,
> > > > >      if (!r) {
> > > > >              struct amdgpu_task_info *ti = NULL;
> > > > > 
> > > > > -           if (job)
> > > > > -                   ti = amdgpu_vm_get_task_info_pasid(adev,
> > > > > job- >pasid);
> > > > > +           /*
> > > > > +            * The job may already be freed at this point
> > > > > via the sched tdr
> > > > workqueue so
> > > > > +            * use the cached pasid.
> > > > > +            */
> > > > 
> > > > amdgpu_device_gpu_recover() is run in tdr workqueue.
> > > > 
> > > > Now if this is the case, someone has to explain the logic  -
> > > > 
> > > > Timeout is triggered here -
> > > > https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/
> > > > scheduler/sched_main
> > > > .c#L559
> > > > 
> > > > This calls amdgpu_job_timedout() -> amdgpu_device_gpu_recover()
> > > > 
> > > > After that, there is this access to the job -
> > > > 
> > > > https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/
> > > > scheduler/sched_main
> > > > .c#L566

Yes, the DRM scheduler is broken. Luckily, if free_guilty is set, the
job isn’t in the pending list, so it won’t disappear. It is actually
safe to touch this in the above code example.

Complete nonsense, yes. Is it safe, barely.

I feel like there is concept in Linux which solves this whole thing.

> > > > 
> > > > At least, in some condition, job is not expected to be freed.
> > > > Then I'm not sure if this
> > > > is the right fix.

It isn’t. Fixing DRM scheduler is. But until then, I’m fairly certain
your driver won’t explode with this patch.

Matt

> > > 
> > > What is that "someone", "some condition" you feel like? Its better
> > > to bring proper justification, and take up this as separate
> > > refactoring task
> > > 
> > 
> > Basically, if scheduler code itself is not expecting job to be not freed
> > after timedout callback, then why callback handler needs to assume the
> > same?
> > 
> 
> Taking out double 'not', following is what I meant -
> 
> 'if scheduler code itself is expecting job to be not freed'
> 
> Thanks,
> Lijo
> 
> > Now if callback handler does something else which in turn frees the job,
> > the fix needs to be there instead of having this kind of fix.
> > 
> > Thanks,
> > Lijo
> > 
> > 
> > > Best,
> > > Srini
> > 
> 
