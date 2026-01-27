Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13369D25948
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 06:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E6310E4BD;
	Tue, 27 Jan 2026 06:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IsZWoW6d";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5EC310E4C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 06:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5QccRt1rA467LSD+ztJAsv4Fsy/smmKsGSaXO4GbDjEBxM3UVyaEpmzJhw6ggop+LLVxcqpVgyVOfQXPf9lTXJl7vCnH3CfmIdt0UpBtya5epX9ZFpI6U/By9WSgt7gzl0g/XirO7XRSi9+x1JHWy+6zHs8MrJcZ0v0rxMWih+P7RQVGs52IV3A4Aj0uXPuA551adfLhJac4ijSukAkYlLBUzgr6lxRvUsPlp6EPQyFkIWkcVTcmDicen/wTTUuhOGbAQQ6mRjyosNx/Z8mH/BWZVi0qAC2Ttg6c/Ku/BVzc9YRbbF6i51yS8lQ+WfFfITed74LbCAT8KS3ZQgcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuMuqIdlETfAcsxzHaVXuw8/A7q+j7Jy3SmEFxnGcnE=;
 b=l4PQXnJ4pYEB5Xx3HZ+gVgelfSMZhXhqpgn8cZ8tP8JJ3UtUaenluIkO2JAKhW+tSzrtipsf0Ryw+CcjuNGYZ1oJC2b2ykjHn0l1y/Ecr9LIAuHQ2Y7945IAiTY2AuH2YGNsFXwsS/1nsQKS7S7WQNppHG5lEqb4U8TND1C0NRwHDLrAUPhugRZXG5UbRZmDs2xfv+VmDBV4pyKpYZUh4wx4U4AJakS7T3zTSOtHv9z4SNSYaWZfYvyWGaCDOgxKFXsHKhusojfFJHgpwjbvGBGBIp6zeyf1jIBu+D/94Yd3lUxxeOkKuQiEPUIfhxy7Bt6yJTGSqyhVcvZww0oNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuMuqIdlETfAcsxzHaVXuw8/A7q+j7Jy3SmEFxnGcnE=;
 b=IsZWoW6dTNFjzZvin9S6bQmYsc23EftzP5D7LOMRtjVtyiRy7Xi4brehFn1qYXtHBMN1+0GB3ql5taCIoBQQs0Jjirpr1Qj47rtTqEk49/DyB6wvcD433Y+bScL0wkZoJVrd8fz/NE4+8H2P/TWKD7mVrSZrHV6hLx5TMYBVm7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 06:11:44 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 06:11:44 +0000
Message-ID: <2c920279-0245-4b66-9604-7333b00b9983@amd.com>
Date: Tue, 27 Jan 2026 11:41:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] drm/amdgpu: Add user save area params validation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com,
 Lancelot.Six@amd.com, "Yat Sin, David" <David.YatSin@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-5-lijo.lazar@amd.com>
 <CADnq5_N4SwVA_RXjPqQVV2ERsnOjCzGKXGfS-2xaHShNxee8=A@mail.gmail.com>
 <d7e73dbe-fa0d-42ed-8b16-fee352e8b662@amd.com>
 <CADnq5_P243kbtXDgv0JqgjmB9taA+2uMUbYtR90aVzPU4APXUw@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_P243kbtXDgv0JqgjmB9taA+2uMUbYtR90aVzPU4APXUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::23) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6ad36c-5110-4e79-c8f1-08de5d6af1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0VxenRUdTVrSmpLeWZDYlpHdWtEWTBOV1ZjMnhzbEpHVTF6TlhiWUlLa0lN?=
 =?utf-8?B?WHl6R0ZFcUNIZGw3YVFsM0I4SkFqemthYkh4eXVoR0Z5WURiL2M1Uk1IazBx?=
 =?utf-8?B?VTRUZ3BqVjRYa0dQWWhvMGVNZ1laRWdsU21pYXlvVGF6RnM0NmIrODViVUFM?=
 =?utf-8?B?ZC9IZEVwdjZ4MGhqdHI1eXpFU2pPUlpESThINUx6MVA2c0ZadjE4Skw4SDcx?=
 =?utf-8?B?UkpsakVSd1NYdSt3blJlOXg5U0dmOG5ybDJhMkw0WXYzVTFNWkpoR2tTZUF4?=
 =?utf-8?B?K3ZWSTFsZGRodG13WEE1VHpGdzVOZlpXSWIwcE4rKzQ0cUxVQk1sM2dCcGFM?=
 =?utf-8?B?T2krdlZPemdVSmpZNyt5Zjl2SFRyektiOWsreHVVU05EbzNHYVh5aGtiUitn?=
 =?utf-8?B?SkthaGVRdEZ1d2ZSLzFsb2Z5dEVsVlJpUWhzYzFRNkZhRVFtNHEvK0duNFhX?=
 =?utf-8?B?bVFsVFdUNElsWTRISDc0VXhaU2FvU0F3SjFuZ0kwZmRvbW9yMXdqODRma2xH?=
 =?utf-8?B?QkRtSnFWeTNZUTJCMlRxSVpXNnN1N0pTOFQxSVplQ0tEQmF5TnNZaWMrS2RD?=
 =?utf-8?B?WUNJT1VZaFphV0I4MnJKMGRQclBXQzNLYTVRNk01RUNrTnY5VlBJUDlqbUlZ?=
 =?utf-8?B?ZmIxaFgyNExUTGZtSlcvU1kySFVLamlwb1lrb0p5em5nRjhCYzV1M2wyNTNp?=
 =?utf-8?B?K0trUkZYdDRpUm5rY21VaTdmNnZSMkc0ZTFGQnFscVRNUzJJTVl6Vi9wRjN3?=
 =?utf-8?B?VSttREdSNVdGMmVBVUI0eGZhbnFRaEE4a2UzeXNHaHNhb2FZYi9UbDh5Mnkv?=
 =?utf-8?B?NUJTSytYWEs2MHZTRzNFU1lta1ZsVTJMei93YjdXSkFqdDF1aCt5OWpuaWcw?=
 =?utf-8?B?bEhoYW56bTdPUTVmbnlKQlpZQTNJMVovQUMwQ1VpUFljdGxzSDY0YUZBSEZR?=
 =?utf-8?B?WStydTk5NzFuZUN0ajVUMlNNbU1ZWUYwRUU4ZkpYWkRTNHVQZDdnaXY5Um5N?=
 =?utf-8?B?YVJ3d2tJRHd5ekNtdHpZc09hdVZGK2NhVTFwWHpDdGc5ZVZMTWtDYmJPWTBx?=
 =?utf-8?B?SXY1TlY4WGJGTFUxdDBLbDg3OVlPWjVNRmxocWhIOXUwOEZoejdFS0hTSFBZ?=
 =?utf-8?B?L2R2QkwxOVhtK3pJQWdiRjRlMGoycEQ1VjZZUW1FRGRJT0VQQ0owNURvSStp?=
 =?utf-8?B?WkJQd29OamhuOG1jaWhGWm9TekpTMWo5MStJY1I0Q25RcGltRVNSU2p3cjNo?=
 =?utf-8?B?Z0psS1ltc253VDhJNWthL1J2b0tJVm5samNheVczaDlxQ3lLM3R1OXdqUWFp?=
 =?utf-8?B?MmMvU1FBWGFVSnpLM3d4OWFKQnU0am5rU2FkSDVCbmU1UEtTTURDZVBwZVl1?=
 =?utf-8?B?aXUreXFuK3hhejRCWDljeFVvWXhwQTBSaGVoR3A1RWJ5S0F0UFR0UjhQZEpH?=
 =?utf-8?B?b2RiTXZLYUVwZ2Z3Mi84cFpwQ0ZEeVI4MHc5T3dmVlFkUXpDcjNESGI4V2JM?=
 =?utf-8?B?RHdMR3QvUFFBN3JKYXJCNjBwUXFMWWlGREk2SGltWm1hdUxGaktqakNQd0hs?=
 =?utf-8?B?TE9jT2dYUmtEV2c3YkVZZ3VXQlJnbm14M2NXMHRDRGpoSW90OTVyanhZWGR0?=
 =?utf-8?B?c1p5RTNPVzBZRGFySXFSWllJcTRGWi9YZnJIVDFVMk50aFZ2a2wwNm9ZNU1k?=
 =?utf-8?B?UzR1NUVHUkszV1VOditGWDFoRFZiZ0J1RjZNc05VZ1JWeUp6dXEvblRpdTQ2?=
 =?utf-8?B?bU1JNnd2NzFpUzZRZVI4cmZueklQdnIyNVFEVXAvNGFyTFZaMjNUKzc2Qnhr?=
 =?utf-8?B?cXh3cm1kY3pIRFN3V1J3Y2FheE9ScnJZR1B1MERmOUgrQXN3NFA3L1dRbFV0?=
 =?utf-8?B?Rko0c2NWZ1dDWk5SSVJteTZOaXYzNkZQL2FWeFAzakUyTFQ3NWFmcG5vWFg0?=
 =?utf-8?B?NTJlb1FKVmRsNDNCSUZsZXhnM1VBc3pIQmhxN0I1UU1vMDJXQi9ycGRjSzBX?=
 =?utf-8?B?UFBaNkxHU3M3am5uR04yZUREbkRzVS92UGVKVVQraGNZbVBCV2lqV1B0WDNM?=
 =?utf-8?B?QnhwbjgzYytHd3g0NlZXZDNhUFNMVGNtbXpnTHpFbGxnZzBKTm9FUnZnNXdy?=
 =?utf-8?Q?7vgs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnVySVNweDBWZnRaUjZLOGF6alBkblQzelRzbkQ4a0ZETjU2VUpDbklLN3Bv?=
 =?utf-8?B?dDRIbW0rY1pqRVU1cm00Y2gxZVc2MHNhN2NRWWQrSmk4NjBINm5aRDRjc2NJ?=
 =?utf-8?B?YkRKNFlEOVhTTnQ2WVFpd2Z4RjFBTy9KcHo5cUdEOWtreHdXbTlvdHpOakE2?=
 =?utf-8?B?ek5EdlVSK2sxdlNyVjFhaUZZT3E0aHkxY2szYVhEOFZZV3dQUHkwWE9YaGxI?=
 =?utf-8?B?OS9oY21COGJ5VUdwR3Y5SWZ4T1pRYXppQmRDbFV2dENWWEh3Wi9tWHU5MElB?=
 =?utf-8?B?aENncGNnVXlsZldUV0liUGs4V1c5RnhmRWc2YkJLS1kza1Nkb1E2QXFSMHNL?=
 =?utf-8?B?c1B1UHpLYlVZZ1VhQ2gzMUt0T2VOMTZ6WFdUQnBMRjVCdGE1cDN6L0tOQk9R?=
 =?utf-8?B?S0NtbHdGRHRBaHBYcnhNM05IU2NhWHRxNzlaVGcvckJYeWVqUUJMaEl5Sjlz?=
 =?utf-8?B?eFFTb3BNcjNPYjhBNmpBOWppNUlmeFVadnk0M0d2UUtpN1JRbDFKb1ZhaVBR?=
 =?utf-8?B?QitUbk53MDVCQVpzYlpVT05PSDFaV3RLMTU5N0ZRejNsYUVXNFhkWmZMU0dL?=
 =?utf-8?B?cVY0Sjh4S1ZZNmUwdUdwNzZqSmx0MUhxeUtaYzdqWXhhUUpVc3RZQjZLTDZa?=
 =?utf-8?B?eGhIaTNMTVRSbmxaTXB2M2xWamh1TE1QNFpGZ1FDWXhvbnROWFk2Myt4Z1Ns?=
 =?utf-8?B?ZWlyei9KRk80cmxSN1owNTFkRXFzdjNFdi9nenRrZUFrNXh4cDRROXovRzF2?=
 =?utf-8?B?N2hTMk93Y3dYQjJ0ZjZuWWZORlhaR0VrUnU1b0FZWVp2dXkxbGJ4OTl5NVNI?=
 =?utf-8?B?THlKRHRNUUxnbUxXZEI1eDB0Tm5wRGFFY2w3UG51aXQwdndsWXJzaGtvOXZi?=
 =?utf-8?B?T1dsNmMrRE1zTGFzaUtwWUVVMXBNUG1mOEIwOHRMSS9DRzR0dC9TNDZvcDZR?=
 =?utf-8?B?Z2duZWpMeHFoWmxZbEoyd2RkMXg4VWRkZzJaVlo2b05kTXI3TnRCWkZTajNP?=
 =?utf-8?B?VzZPaUYwRngwRDNOR25nb2QvNHdXREdaSG5hSXV2eW95Z1BTYndEVEtlbysx?=
 =?utf-8?B?NTl0MzJhd2NVNjk1Q09Hc2p4K2M3UHJhZ2Vmb0F2Um1neVlGR3VLeWRDV2Fx?=
 =?utf-8?B?QjdMWE0wbENTQkZ4OTVLV2FWU2RLZlB1eEp1KzFmM284ZE1adkxNVVVKRkFD?=
 =?utf-8?B?L2lNRnVQb09IUWl1dStlRzd6dGZBNklXVXFBMWUzbGJuRVJWODhGSTJEeHlw?=
 =?utf-8?B?RjVZUjlqMFlvcFlvN2ZlVEtXSSt2VXBmQnZhdXVjb041cytnZm95SmNNN014?=
 =?utf-8?B?dFVsSld6RGZRZjVNWWF4NzY0Wk53b0k4U1ZyZmtkZXR5YUlvZGI0RWJXOGRi?=
 =?utf-8?B?czVlWWZ1RnNQdXljQmtVWGJKRmVjT2xmWlo4UVR1M0pQOVFmSVFVZDNwZ1Jv?=
 =?utf-8?B?MTluMnNKb0F4aGpVT29xQ1RJZS9lT1JJU0FLNWVUc1R2eGxOSEZmMkVoRTdo?=
 =?utf-8?B?REIxRTB5NkxtUUZNOGpidmhXM1FURFI0VHQxNFhBMm1ieVRaYWI1UWY4bGRY?=
 =?utf-8?B?UFZnNnI1ajhpUWVYZWRrT2ozMC93U2Vyb2tUdG85bmY0YU9rU2xYWGI0Q2c0?=
 =?utf-8?B?MTF6M1RkTW1BWGtvVmhwWGY1NWxhUHBVbFU3VU1aVkFsRkw5TGhJTlRYdTI5?=
 =?utf-8?B?TTd0MFE4bWZGWW5RK1VnSitqYWpoVnBwYjZXbUIxL092REd1SUErbEJ5ZXUv?=
 =?utf-8?B?QU1wRERmSkpDb3R3K0pOK2tuR3hHeU1Yd2pSVm5sTkZoSmViNFNHK0RkNHBT?=
 =?utf-8?B?MFVkcjFxUTF1aUlSUCswMXBmMGdhYlE5eWVndndFbFhsSG1nUlp5bU1qckdP?=
 =?utf-8?B?K3pDNVdiRUM5T0ZPNFM0cDRqeW1pNEZLWTZlYVcyU1lUaHozTG9iMkpFa2hQ?=
 =?utf-8?B?b0JZYmVJTnRYeitVY0Q3U0djU0p2Qm53OWhNakxhR1hlbTFCdjR2NTRqWmR6?=
 =?utf-8?B?YW1vUm96RExmVUlqMnQ5ajZPRzQ5UHpLTTlLTmR5bWtwU0NIbWdZS1V4QjBY?=
 =?utf-8?B?MFFGV3NGcHVuemlxNUlmeWx6ZTNta3BIamVNcjN4RXNxcHpJYVJuYVdIVllv?=
 =?utf-8?B?NzBmbDc2djlLS0JseC9QQWQ2bGpVNTNHYXV1TklFcjErS0Y3LzlnMWE0L3Ni?=
 =?utf-8?B?eUl3K051bEV1NXJ6MWM2RVlaYUh5eUVOenUxbGV5Y2Z5STFSRDJ5VlNaMkVx?=
 =?utf-8?B?VFlrZ0V5QldzSXR0Q2NiY2xNd091cjRFQlE2Z0JzaWJtMTZ2OTh2di9zamVy?=
 =?utf-8?B?VEhoZmFlZGtGZEx0eWFpQXcvSzV2eEZqdlRtNG5QQ3NJZkZjL1NrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6ad36c-5110-4e79-c8f1-08de5d6af1d3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 06:11:44.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aJvQSAtOf9iOw59P9xukRIMnrKW8sFiY/8sW61BDtlGM/A2TGEaeJvDjSee9yBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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



On 27-Jan-26 11:25 AM, Alex Deucher wrote:
> On Tue, Jan 27, 2026 at 12:35 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 24-Jan-26 2:14 AM, Alex Deucher wrote:
>>> On Thu, Jan 22, 2026 at 5:52 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>>>
>>>> Add an interface to validate user provided save area parameters. Address
>>>> validation is not done and expected to be done outside.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 44 ++++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h | 11 ++++++
>>>>    2 files changed, 55 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>>>> index 80020fd33ce6..32d9398cd1d1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>>>> @@ -64,6 +64,15 @@ static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
>>>>           return true;
>>>>    }
>>>>
>>>> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc)
>>>> +{
>>>> +       if (!amdgpu_cwsr_is_enabled(adev))
>>>> +               return 0;
>>>> +
>>>> +       return num_xcc *
>>>> +              (adev->cwsr_info->xcc_cwsr_sz + adev->cwsr_info->xcc_dbg_mem_sz);
>>>
>>> These could overflow if userspace passes in especially large values.
>>>
>>
>> Sorry, I didn't get that. cwsr_info contains driver calculated values.
>> This function returns the size required.
> 
> Sorry, I mixed this up.  See below.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>> +}
>>>> +
>>>>    static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
>>>>                                            struct amdgpu_cwsr_info *cwsr_info)
>>>>    {
>>>> @@ -425,6 +434,41 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>           return r;
>>>>    }
>>>>
>>>> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>>>> +                               struct amdgpu_cwsr_params *cwsr_params,
>>>> +                               int num_xcc)
>>>> +{
>>>> +       struct amdgpu_cwsr_info *cwsr_info = adev->cwsr_info;
>>>> +
>>>> +       if (!amdgpu_cwsr_is_enabled(adev))
>>>> +               return -EOPNOTSUPP;
>>>> +
>>>> +       if (!cwsr_params)
>>>> +               return -EINVAL;
>>>> +
>>>> +       /*
>>>> +        * Only control stack and save area size details checked. Address validation needs to be
>>>> +        * carried out separately.
>>>> +        */
>>>> +       if (cwsr_params->ctl_stack_sz !=
>>>> +           (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {
>>>> +               dev_dbg(adev->dev,
>>>> +                       "queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n",
>>>> +                       cwsr_params->ctl_stack_sz,
>>>> +                       num_xcc * cwsr_info->xcc_ctl_stack_sz);
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       if (cwsr_params->cwsr_sz < (cwsr_info->xcc_cwsr_sz * num_xcc)) {
>>>> +               dev_dbg(adev->dev,
>>>> +                       "queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
>>>> +                       cwsr_params->cwsr_sz, num_xcc * cwsr_info->xcc_cwsr_sz);
>>>> +               return -EINVAL;
>>>> +       }
> 
> cwsr_params->cwsr_sz has no upper bound check.  Can this cause an
> overflow elsewhere?
> 

We could restrict to a max limit of 2 * cwsr size required. Adding 
David/Lancelot as well.

Thanks,
Lijo

> Alex
> 
> 
> Alex
> 
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>    void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>                         struct amdgpu_cwsr_trap_obj **trap_obj)
>>>>    {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>>>> index 3c80d057bbed..96b03a8ed99b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>>>> @@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
>>>>           uint32_t xcc_cwsr_sz;
>>>>    };
>>>>
>>>> +struct amdgpu_cwsr_params {
>>>> +       uint64_t ctx_save_area_address;
>>>> +       /* cwsr size info */
>>>> +       uint32_t ctl_stack_sz;
>>>> +       uint32_t cwsr_sz;
>>>> +};
>>>> +
>>>>    int amdgpu_cwsr_init(struct amdgpu_device *adev);
>>>>    void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>>>>
>>>> @@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
>>>>           return adev->cwsr_info != NULL;
>>>>    }
>>>>
>>>> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
>>>> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>>>> +                               struct amdgpu_cwsr_params *cwsr_params,
>>>> +                               int num_xcc);
>>>>    #endif
>>>> --
>>>> 2.49.0
>>>>
>>

