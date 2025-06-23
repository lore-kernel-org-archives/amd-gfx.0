Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BCAC77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 15:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E2A10E3CE;
	Mon, 23 Jun 2025 15:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jR4iQiyH";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA1210E3CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 15:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As4tptdujmyFF5bUnEOYDcAuX38AVpnbU/Tu4k1BtAyLUoUjAOjJYhf25e2kCyI7k3kmagSCC+6lRxl7O0ipJ4yXbz7ojB/SbircC5v8wcaHX9mOIriIXmFdZfi5yRCZ4eo4218KoPUKY/C6r0BWTxMklM5U5U55fS1I6yce+Wx60BS2JWS61LIbz2PZCKHYXkl5jAUQwwb7qfJnRMjR+F6PcCYb07+nyRP3R4P3t4o95rjAG8W7u/pLkERGjNMGZGbjkoZitW4jh+LvbtBrBabPV8EDc2MZiu23rozDsW5iHnIAPVfoxOAhr7q6B9ZmL+7pvmXKyWA0JjxGcRNE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehDHDpCsK9Dgso/+03YdzN5KZnY1+BkeFdhhP5nrb/Y=;
 b=VHl4RH93GL4aMPslGXpbplP+pr2Lm7G5BzOxdcOZh1K9yBhluGO6a9n8ifPmfBg1oySSCjZS4Vc0iNgMQ+FirAYCaK+EI60jiuuyoWnZ+VQejC16xZyTkWLdWBNTjHS5f4zecTt8+3LQYqZj+8WXTlzsIPb31I+RPtw0sHbPMjbJQT4B33a+jZGzdQ1dwH3XWqAHsDI8xnKDeUADfoHbl+5ED0o0YltOo4lJVz66H2nnG/YiEsxA+6pswXlT2FPzVuAVQ4mULwXRwrWR00ZI2fPdgbbg0zWtYZVu+5BhZPr4qsmqc5VJN04szWNMMIY0aDvj0ul3FWD4f4/EW3Gfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehDHDpCsK9Dgso/+03YdzN5KZnY1+BkeFdhhP5nrb/Y=;
 b=jR4iQiyH/1ZuZTmw2pkfZIJzQA515SVBXof3hNjb1WJ3GwWVEepLxdNlw362H2AD4GCZO7hukmpqIgBAdisFu8Q9iloyr9+5pcuVmR9BurWMfIXggBcPoHlTrVTES/jmsKS1J29VmzsVfp9a+NtLj5XLekxwd02/6r5XzRchKYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 23 Jun
 2025 15:04:22 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e0e7:bd76:e99:43af%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 15:04:21 +0000
Message-ID: <cb116d0d-71d1-4500-b73d-b94aea536157@amd.com>
Date: Mon, 23 Jun 2025 11:04:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20250619013206.123183-1-vitaly.prosyak@amd.com>
 <CADnq5_NKTTXcEuZANmsS=E6gcLeX11P5CMT5bQnF0p-5XaLqYw@mail.gmail.com>
 <4739df47-fb92-4e71-83e3-389ffc22edeb@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <4739df47-fb92-4e71-83e3-389ffc22edeb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SCWP298CA0003.CHLP298.PROD.OUTLOOK.COM
 (2603:10d6:300:14f::12) To PH7PR12MB6420.namprd12.prod.outlook.com
 (2603:10b6:510:1fc::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6420:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a73557-1196-410a-3185-08ddb2673bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk00LzUyMUU4RWJheUo2dHhsUXZENlBnUVUzMTBrK3p3dVVYY0hrV1BEdHJ1?=
 =?utf-8?B?SWhoLzlvWUMzUktvRFFXYU1tWTlBRDd2TlI2YkZ6TENjQkczVkg4U2FxYVNu?=
 =?utf-8?B?bEhUY0VVZVNjUnVibjhpYzNtN2JjUkhzdDlpblpqd2VseDVOZ0w1bG9NTXBj?=
 =?utf-8?B?NzFTdlA5MEJqYkZRaTJ0eFc1QXF5dlJpK0JaSVNIOEw1RGY0SnQ0WWhzMDZ2?=
 =?utf-8?B?ZG9iSFRDQ0NBRzlVejJ4a2NKbnVoQUxSOTZjSlIvUDdWZlQxYmpZSndJSG5u?=
 =?utf-8?B?YTkyRThlRE4yTmdVcng5bi9QUkRiYVVyM2Ztam16Q202a2xmYWdQK0M4Zk1n?=
 =?utf-8?B?c2FGTC9KYUNXM3VzcWFNSlR1ZlNYQ1lQcENYRVE4aFVJcWRsNWJseUZBbTd2?=
 =?utf-8?B?cGVMbXlyc0pnb2FITDBubUs2cTJZWFNhT0xVWkIwVzBRSXJiSWlEZmdGaDZp?=
 =?utf-8?B?dkdRcUs0ejNPcmU5aEg5dG1iZlRpUWlaMTg5M0dMYS83ZWYyV1VtUDQzcHJO?=
 =?utf-8?B?UlF0M2JlRW96alRteUFzMDREUCtsMWJreGRHVVN5dkFHaVpFa3Rkd2dlejl2?=
 =?utf-8?B?VFlOc1FYZUY3QlhwVFA0T0c5Y3F3VVUzWjk0eDB1RkhDUGUreDh5UU1sRTJy?=
 =?utf-8?B?ajYyUHJMNGR1RHVleGVBMEhQaXZsaVR3WnpUNnh3S1ZLZ3Yxb1gvMUF6dGpV?=
 =?utf-8?B?MEdsK2lEZWVncXFKNjBVTWJvVDhMUC9yazVzM3g4RjhsY3JKcjA5RUEwb0FV?=
 =?utf-8?B?R2pGcUhzWXRIblNUaGJiQU80N1JaZFZXMVJiR2xZRFFvWDJsOERxMFJFVlVw?=
 =?utf-8?B?N3dWbU9PN2JoelNTdmc0MVpIS2c0QkZ6Wk1VQ0hkWWREU1RmUGdCcWtCUVVX?=
 =?utf-8?B?SUp2Z1pzMmRBU2VtbS9hZFBiTDVZbE5NYkJJQ0ROVDN0Ukl3N0RjWjMrRXVW?=
 =?utf-8?B?WW54YWZjK3VjQjlMSk9LZUYwOTNjd01TQkZabk1WeWsyWkduaGwzR1F2Tjlq?=
 =?utf-8?B?MWhaV1hqalNORTliWkNRTzgwam9tK1IwNm1GdHRVcmYrV0hFMjVYays1T3Br?=
 =?utf-8?B?UEh2VFZFSXUzaGdCODFCZ1hRc3NQem5EWkRMOG5wMkE4R1IwbDNHb2NDOXF5?=
 =?utf-8?B?b25NRENkYTY0TVlsVnRMNlo3b05HdDRjMTZka0lWVGU3ZVRMR0Mvc2sxTzdY?=
 =?utf-8?B?UjhHaVUvd013Qnhkb1FsOGp5SmRERHRpc0dhR0hjVW1HdzNkMXNHdjlpVlFG?=
 =?utf-8?B?eU1WRnM4Q2d0cGhQalIyOE4rSG00anRFK21ZemVncDcxR2RobXVKaDdJeEFl?=
 =?utf-8?B?dEdoK085cVZSMk10SGNlazhxd3F4eXpJMExaa3FVb1VTd01lN0RhNDkvUGha?=
 =?utf-8?B?QWZGNVBhV1BRWUlSVm9GRWVjVjFEK0dZeGsrTzZhcnZYR2I2VWMyaEttdHBh?=
 =?utf-8?B?UVA1MGxoTGRGT3VvZmNhaHExYmQ5NnJhVEw4R3lDRWQ4dnQzUXhGMFY5ZnF2?=
 =?utf-8?B?bmd2NmIvVkRsY3FUWWR2Z2dFSGZaUmE3dFZHNE9TZ3FOeUVlMi9Yc1kwNTVK?=
 =?utf-8?B?Z2xsN1hNQXBYSEc0MitndHV2SkxzUmR5cmpsdW9QVWVKb3hmQkorL3BKNitB?=
 =?utf-8?B?NnVFNXJoZi9TdG1xSEtOOEs0c0NCZVV5SGZlQ1pKdXFUTm54ZVpvbzVCam5k?=
 =?utf-8?B?bG5lbTB1ejlwcEV5VXlyem1iMi9FWjQxWjlnY1VDSUg3N1dYTERlR3dBeWNh?=
 =?utf-8?B?L0xoV052MWNXY0dCWXpRa29udTJ0QWxnQVdqRUZ4N1F2V2lEWlU3OTRlT0pp?=
 =?utf-8?B?VGdVeklXR3VYYyszMUk0b0V5ZkYvQWllMzFQMUVyS1ZJa01uM1BxSWZZRm5Y?=
 =?utf-8?B?ZDdHZXZsT2pCNEt0RVdvVjU1bjU5TGUrQ1dSMHhyOG5IMlFnRW5oL2VFRzFq?=
 =?utf-8?Q?3y+N73Sbo8w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpWZi9yZUlkUGNMRjVMNjNVb2RIdDJ4YjJVdzNtbEprNXljTTNyak9HbXkz?=
 =?utf-8?B?Q1JjRFZtRXlKaHRyRFc1ODdqTWdtNUJHL2NKVEQxeThydmRkd2p2SHRDY2NR?=
 =?utf-8?B?OHhlTVR2M1hKM1lDdlExWFNvdVBHVEdiUkdiSmJZU2Z2cXc3dXk3QTB2UnV4?=
 =?utf-8?B?RlpNeEdPaTNnQmZiSnl4SkV0RFlueElIOFFQdFRRM3FGcEtWeGpTWTVHcnRx?=
 =?utf-8?B?cmxRM3Y1RStlQVlKbTd5cGswQ1Rkem0rSWFvd29hRjJtR3BERTd4SVUxSmZl?=
 =?utf-8?B?SGRuYnNMOUV6N09GS3ZDTWV2WG41UklCMzQwRThOblBxYmQ3VE5xUzJGV2RU?=
 =?utf-8?B?YWN2WkFIMkMzYzUwdDdxSkx5TVFGV3JJWjlEcGdGa2p0aWwwdCtxTmlacllX?=
 =?utf-8?B?U3M3Y3k4NG85TzJSR2lYZXBzRTdFcTYxU04wSVdyK00rUitqZnFlMlgzdnM3?=
 =?utf-8?B?a0s3bWN0QkpUZFYyMGdsQk9ldWdsN0pSNWVCanhoZllvOVR3Q3Rab3I0bWdU?=
 =?utf-8?B?L28wU1l3VThyeDE3V2NRcEtLNDMvYUI2RThPT3pBTjkrS084LzBYQm9yZmly?=
 =?utf-8?B?RUdkblVJVC9GeHVIWXJWQjZUVXZrTnJQZWdTcE5qQlVlWkpWSEJSemw0ZWJY?=
 =?utf-8?B?a2ltcXdaRW1DWWVNd3h4NzFvV0hGMmJaamlZeThzSWZBV01ubnZwSkVRdmc1?=
 =?utf-8?B?ZnkweG5NbW9odDhMR0R3NitaNFVRWkI1WmVrd1piYUs0SHZQa2FwaG9McGIy?=
 =?utf-8?B?TXB3WnZKSFBxTWFwdkovOG1WTHJYZDlsektrc0ZiazFsYWZ5NTU1ZjltVG05?=
 =?utf-8?B?Tm8rM21oSldKV2NBYXQ2TDlQNjVJNlBPNWxER1V0WldnUkZVMWR4V1NRenJu?=
 =?utf-8?B?UHdvQ1BMSlNwL2hQa1dlL0Nlc3dpVHZmNFpjVlpUUWxWb3JSZi9PTmFNbWpG?=
 =?utf-8?B?UW13KzJ0RlhwbXYxekFaQ1dYYVpNNHR6bFhzZFVUdDFzbDliWHRWODRaOXVj?=
 =?utf-8?B?WEhtZGVEMmNnTkZRYXJoNEFFN09OQ0VHY2FBK1BUNDBqbk5RQ3I4V2pCV1JM?=
 =?utf-8?B?WXNmclVhdy91NEZSV2xZL2xwUkFORGlDTGh4Vlh3QzFoV3FoZC9ydUlGdUtk?=
 =?utf-8?B?UEZVb2d4dkYvbzFnUkQwSzVOZmZ0UFIzT0lRU25OaWVoTGhoMVVJZVpEVktM?=
 =?utf-8?B?M3pZZ1k3Z212UlV6bEVOM2xuVzFVME85by9LbzFJS3orUVdVNVNLd1ZhaWJW?=
 =?utf-8?B?MUREVDJ6SEEzakM4VWlhdS9GYU9RZ3J2STlyU0JrVXl3OEtJem16VDZZZlFG?=
 =?utf-8?B?bGxNUXljMnQraC9RQVVLa0d4OTRmVTZoN1l1WndYZkxvUGgwQ2NLS2oyd1RE?=
 =?utf-8?B?QnlITHRIN0o2SVJMVWpMei9yQjhKeE12WWdlU3RPNWQrakVSaW5hOWZSU200?=
 =?utf-8?B?SGdYazFRN3VxZlFsVXpuQUt4d3c4MUROU3ptTVBUUGdyUGE1bWlqTERWY3hF?=
 =?utf-8?B?eEc0c05Oc3dGL3VKZTZzSjQrNDNJL2NpYkxmN3E1Zk5aNWYwN2ZYSFpBVEJt?=
 =?utf-8?B?eGRmeFdqVngwT0hvQXkxYTFDdW1DV2hvdHdySHRqMTA0TjVvNTlpaW9wK3hl?=
 =?utf-8?B?ZkZnZlRyVVN2Sk4wQjJ3NGJ0NEsrVit6VGlZdWVxQ3UrVkVORHljM2NNejRh?=
 =?utf-8?B?bkNGeU9TcXZPelYrOEtJUVA2L3RSaHhlZDRLdnJDdFQvQzR2QzJLS2NWR0FS?=
 =?utf-8?B?VXNKZjZwbC9JS2VOL0Q1c3NlZGFwdC8vYUZWVHhWTmxHUTNUeVEvY05LOVJP?=
 =?utf-8?B?SnRja2lEYTB3bmxqdE1sOWN6K2w4QUtjYzJsUVliNWlyMDJheFZ4MGo3ZmFh?=
 =?utf-8?B?SmlhRGJpRkJhM3MzN0F3cnhRZCtoYTljaGRCVnY0Vjl3WnJYbzhuWlJsZlNG?=
 =?utf-8?B?VnF6TGowVWEza2NLWVpXRld4WmwydXYxbktiRHErV0xaellOOXNveVFVWE1S?=
 =?utf-8?B?eDhpM2JRdHRPR3gzSmZjNHlxc1ZRZ1F1OTZhRkxtcVhwNE5acXhVVTQ5SXIv?=
 =?utf-8?B?blhVTUZwY3I5YTJSb0o0V1ZBblQ5Skp4OW0rNmwwck9UNlAwSm1IOGdoVFla?=
 =?utf-8?Q?WzWqA5STML2bpnkcslDSwjErj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a73557-1196-410a-3185-08ddb2673bd7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:04:21.6269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZjCex46IbFOGDI74szq0aYfFSN+iR8e5aainMF60IxwjWBm9zJtpG7Iygfkw4ByYnezq5PEP5ZKuAFCp2hKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
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


On 2025-06-23 10:34, Christian König wrote:
> On 19.06.25 04:26, Alex Deucher wrote:
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++---------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
>>>  2 files changed, 6 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 7fd233f160bf..204178d949e1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2914,16 +2914,10 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>>
>>>  static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>>>  {
>>> -       struct drm_file *file_priv = filp->private_data;
>>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>>> -
>>> -       if (fpriv) {
>>> -               fpriv->evf_mgr.fd_closing = true;
>>> -               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>> -               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>> -       }
>>> +       int r;
>>>
>>> -       return drm_release(inode, filp);
>>> +       r = drm_release(inode, filp);
>>> +       return r;
>>>  }
>> You can just drop amdgpu_drm_release() altogether and just assign
>> drm_release() as the callback directly.
> Stop, that change here is just broken.
>
> We need to call amdgpu_userq_mgr_fini() before drm_release() since the later will release all BOs and so eventually also the ring buffer of the user queues.
Yes, we observe that amdgpu_driver_postclose_kms is invoked before drm_release. Within amdgpu_driver_postclose_kms, we perform all the necessary cleanup steps, including:

    amdgpu_eviction_fence_destroy()

    amdgpu_userq_mgr_fini()

    amdgpu_ctx_mgr_fini()

    amdgpu_vm_fini()

These functions handle eviction fences, user queue management, context management, and VM cleanup respectively

Thanks, Vitaly

>
> Regards,
> Christian.
>
>> Alex
>>
>>>  long amdgpu_drm_ioctl(struct file *filp,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index d2ce7d86dbc8..195ed81d39ff 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1501,6 +1501,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>                 amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>>                 amdgpu_bo_unreserve(pd);
>>>         }
>>> +       fpriv->evf_mgr.fd_closing = true;
>>> +       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>>
>>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>>         amdgpu_vm_fini(adev, &fpriv->vm);
>>> --
>>> 2.34.1
>>>
