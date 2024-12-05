Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1019EE7716D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 04:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC0110E37C;
	Thu,  5 Dec 2024 04:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+5G3rsW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6BCE10E37C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 04:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlUNs/RYAcKfAHGWzugJmGzexzKKFA7OY/WOeADPDlIpue/XXZfpwzPYxf+LX9CUMa0ZYSNGa3/av4mGCzLRsekXg6xkGyNW72bHKONnqcntcMdC52o9pTzTgywim0w2M9X+hwbWEIDuP9obv/adutTjFPUVC1vkOw8VU7ZqoJopWpxJb8uQWOqeglpskxc/aZIJWiWIs7KpN+eXEiDhzBUHf2LqDZ0nIdvNHWvour6+PsUOMLMoSkz5HAVMaWCe4jhqPChORoOA5gYTXZ4TrArVfRF81V1J4aeWsEjds7mZcOADhnmy7INfKvxnFMN3n9k2NZfTkrzXdzCmOuAWAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXCRyReecUtBasRzwywhnkKwFS9vqRE5slH3Gi4Acno=;
 b=T0ttUzty8J8ZJi4N2sWzoaFUmrGMtDxTwNRjRbiAVIazk0LzDnGyDE/Zhm5IMBr0eCbpZHKjGGXEMB2heEuzcTo3Yly98xt5An0elJHy7CCS9cgZ4MEyOphKKSll3jTjBR+sWi5FAETvCRgbc8VW+CkOfRkXJ3nJO2aB+R9KRUOY2/q/TOv9T7dt90I7+epVPi+KMhfN1p+vqWlnyKDtvMJgKbHxDCRamPoNCodocDOZVIfH4OZy3vKuoXmqjiQV0tgyIi5nREZ/m7Zif318wZfqxEuycG4+uI5vgSh5dYdakvzEnVzpUqDMk+tNqbNQxJUMPFmkh0krYPgu9ViAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXCRyReecUtBasRzwywhnkKwFS9vqRE5slH3Gi4Acno=;
 b=i+5G3rsWRBfD5F6Kh8XwkWL0bKCUWN0Oi8S5xIU+64k2RfA/t3lFlK48B9kc/yWL3ufOWPt29ZpvlNHJvpU3yeNFp59hbnqu9emBANmiY5cV1+fAodWFBXz+dLPrhTSil5vtqeJjMZGlX7v25kjE5230x0J3WHoDC0mRrx8APDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 04:06:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 04:06:29 +0000
Message-ID: <84b8f486-5afb-495c-81df-05c852212507@amd.com>
Date: Wed, 4 Dec 2024 22:06:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
 <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
 <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
 <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
 <9f85de41-5574-4e83-b5ed-1640e45e90e9@amd.com>
 <CADnq5_PvErRnCQp-oTR1Qw46H6vo9BuWzH76ERqQ5XDzA1dkoQ@mail.gmail.com>
 <176abc17-3f0e-4b9d-8043-0674a9cb6f7a@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <176abc17-3f0e-4b9d-8043-0674a9cb6f7a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: d2138fb4-edfa-4710-9a72-08dd14e2322f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3lSQmY5YTdrTkpMa2lHU0xrK3pwZXdDQjU0UGtramYxRjVzeWtmcnFybVEw?=
 =?utf-8?B?cDNOL0c0cXVaenRyZ2o0SmFBeUQ4aVlYZlpJWlVkdEIwVncyOXNwa0JwanZL?=
 =?utf-8?B?UURaSXFibVZuQUNjdzQ2TUtxbDNjS2FrVjBRSG5XckRvZ1lmSnlWNWRKRUMv?=
 =?utf-8?B?OFhpVlBUWDI5UVNZdXo0TklOdkZoTUxudGwvQmxPQklzZzc2aUFacElVMFZM?=
 =?utf-8?B?QXNUWGgvRzRYd2lpdUFWbGFQdm0ybEFBTjRrcVFTTXczV2plMVpSQW45TEFV?=
 =?utf-8?B?S2hlWGhqcU1kWTNzMm9PL251N1JwVGZjRE1jcmVhSXB1TktQdWtNUDVTTzdR?=
 =?utf-8?B?TGJxd05xc0ZybkNqSEg1Y3hhUFVRaDBSU2p0NnI2NzFYNTJZbFJtSmphMi8z?=
 =?utf-8?B?NmhHV2tnVXZmS3ByRzNJM1N1aCs2Z1VWV0sxcW4wSXJsbDJ4NjB2cUx1ZTBa?=
 =?utf-8?B?Z25PWmZUUkY2ZHZad3krMWtMTUZKYjRzRzZ0Ynh3WlJTeVh6dVdCN3l0dWlS?=
 =?utf-8?B?bjBRU0dDWnZDVXlPVUl3Ri9uOEdIWWc4Wmx3bFZtMjVBcVZicFFiTlo0Mkw1?=
 =?utf-8?B?U1FXa3FRU3IrdWFFbDk0WW9NbXVNZVV1MzM0dnhOSCt6NHd0NWlKYTNOaDhS?=
 =?utf-8?B?UmFWTjh5L3d4V3dwRkhLb2xOazVRV1NhVS9rSXB6eExocm5SL3FsdlFCU1Rm?=
 =?utf-8?B?TFUvZjhRUldlYXU5QzdkMWIyV3l5bFJuYmJPVzBLcUxJL3JUSnRiRlp3bllR?=
 =?utf-8?B?RHF6eE5lTDQweksyL0QxL3dLQzh4QmtMaDdWbE0wclpEVmhxdTFDSDk5Sjky?=
 =?utf-8?B?aWV2STJEOHRHWEtLY3U2YTRKbDdlYkxmWjVuRzVQcUE2Ukx5L25PMC9pWUIy?=
 =?utf-8?B?ZHRPMnREUk5hY0I3cW1NSmJtUEM5bnZoaUdjSGk4MERVMFJjR2pIRDhmcDBq?=
 =?utf-8?B?K1pQNkdyUGtVTkxzUmREazl1TWdaZUJtdVRWK3RLTXdTZmhrQlNsWXV2dDNk?=
 =?utf-8?B?KzR0Yzh4S0JzS29EbVZHWHd2RkRUVDlQN1J5dnlWNElxWWlRVXpTcnJaQzRW?=
 =?utf-8?B?a1dQMW5EaDl4SkFJenVubVc5cWtKRGkwTXlVV2dlRlZ3S2tGWXVUcmNBMURh?=
 =?utf-8?B?TDUrUkd3TzdnYWtWNDFuempRT2ZyYjBvcnZmTmFJSmtKSFNZQ2FweVNYSjdx?=
 =?utf-8?B?VGhaYnVnNDc2MkVJRm9MS0pwSlA0VVQ2YW54TjFIeDUvVEc1eFY4QUdlUlJw?=
 =?utf-8?B?M2ppU1RsVG5yaWoyNVR3Uk5xOURyM3BTTlNCWDJhQlljWndUMlBVbmV3SHY3?=
 =?utf-8?B?WGk0WlMzNkI3T3kxSER6RTZKc29BRGNDR0JORCtvMDhDeXRLOC82L1huNklB?=
 =?utf-8?B?QVdVTmtrZUhNK1prM0szYnpvSy94cFZwK09EUmYxSVA3TGFkdTRJOEpRaDFm?=
 =?utf-8?B?Lzd2c2pPbVlxbGJmbDdLOER1YVJtR3VycThwRDJxUDUvTXpGWlNadUlldnNH?=
 =?utf-8?B?L0ZKbkZiNEM1UnZ3NjIvUzd6TUxvc2VUa1pQbHVZYnNjejFQbVMveEtRNCtN?=
 =?utf-8?B?ZC9iaVNGL2wxc2dycE12N05hRHdpcldtZ0VibmQzWXUwUUpCK2VncE5YMG9P?=
 =?utf-8?B?c0psY0NOQjhpMUtreVBIaWQ5U29kMlFyWVRmaXU5cS9VUGkwdTdwUWFDV1FJ?=
 =?utf-8?B?aUNtZ3RQZWQ2SHExRHpZTHFWbk4xUFRmZVFjazlWZk03L200T0o4bjU0Uysx?=
 =?utf-8?B?OTdNTkFIb3RuL09NWWxMc0pWS3Q0V29WWm9VNlBDaER5Z3pkZlJvNEZFN0k5?=
 =?utf-8?Q?nF53CZ1SMLG4uMLV/F0LtJGhKy1LyvJ9kQASI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENOVlZ6c2I4ekFaL09zbHNSVWNNVU1DYmVhVllxcWNKdWtuT0VXazlyWndE?=
 =?utf-8?B?b2l5QWt2OTFwc3JkZDVETlhzMTRuYnc5Q25MYkxnc3Vka294MTZITU9FTmNJ?=
 =?utf-8?B?UUFBNFlKQlVwNExObnJaUVJyNnRMNWU3R2RUQ1FmaU9NdmRFbENiTmdTdk1w?=
 =?utf-8?B?OFZJL3hsdEQ3YzA4TFRQbldRYjh5cVU1SlVjZHZmb0Z0VEw5ZlFwN1lxM0Vu?=
 =?utf-8?B?dnh4ZzB0d2hSSkpMOGh2RXJmM29GZ1N6Ymk5MDJ1MlhCRzF4UGZBZGZpTVVS?=
 =?utf-8?B?VEl6ajRyK2tSbFpnTDdSOU1LV05sSVpGWGVsVTVFMGY0NVVKZzgrbEV5dHVo?=
 =?utf-8?B?N2wzY281SXdLcnlOVFp6R3Y0RHFESGhnR29XZnVrTHZlcFFOaVVLQXNzd3pr?=
 =?utf-8?B?TU9OM2dVN3JXQUNocC8rOEJ6cEh3dXJmdE5YMXhhdHVQT0ZHbDRBVEpHbnRj?=
 =?utf-8?B?ZDhTUWhTdGswVHJwYmtEbTh0cE81Skl3TG9IUG1RcndGd2ErR09oa1UvRTk1?=
 =?utf-8?B?NmZDSDJGMnhoN1NPa0VqSWV1YkpGNTJTZG95UHVMYnNaODcrRlpSYXRaYUZP?=
 =?utf-8?B?blVWYlJLNE9ZR3djUGVZczVQRGFDcXRHbUVUU09zNGJYT3BMc3VPUHRyMUVy?=
 =?utf-8?B?NTFuT0psL2VLejMzVktIOHJVdFlrTDA0bnJtWUxPRmZ4MWI0QUY4N1BvTlRx?=
 =?utf-8?B?MFZhNGt1WlFvMkZXUVBaK044ck5qc3lXTDNySDNIaVVNbVZVU2xibUJBb2RB?=
 =?utf-8?B?VngrZlptcHpZVUZkUzVWQklNVUVoeTZPcUk3TGZMWk1vUG05Vmk0VHM0TUxz?=
 =?utf-8?B?WkJXRFUrZEx6Y1dYRGt3TXBzRTBDRkRVWENxNmZCRTR2WmNRNHBBd09hdzdk?=
 =?utf-8?B?L0trWHNaVzJMQW9mQVYzTXUwdlJKSklsUmNEb3liLzI4eVZEbEJNRTZMdzlH?=
 =?utf-8?B?eStaK3FzcjdFOWJoa1BXdURnRGJ3Y1Y0THR6YVVGaWJuS3BHUkF3dGFRTUth?=
 =?utf-8?B?bTdlcklSckZpN3kxTnE3OUlUN1dFMUFXbVRjdFl5andEY1pUZkRpNDJjV0hN?=
 =?utf-8?B?c2ZYSm0wdHVHbWtrQTA3aElmY0NIZDU2RUNkWEdqandIcHIvcmRoTmphOXpI?=
 =?utf-8?B?RW82Vi82U0xKUmc5QnNoSytTUE1nakF3azhGMzQrRnRQd1FMZE9yZHRnYndu?=
 =?utf-8?B?eTU5SHlYSDhKeHlNZC9kQTVhUFVjN1VCcXd4MGYyY1ZjVW1ZQ0NIK2N0YUxM?=
 =?utf-8?B?cThENDhXVWMxbTNRNWhJRWpqYnBkaEVlOUNDV3dEYnQ1Q2RtNUtia21NVENv?=
 =?utf-8?B?emdlVlVvdm94aEM1Vmx3bGNoaEV3U3Vva3NuL3VKSG5FbkQrL3ZqS0Y1ZFdQ?=
 =?utf-8?B?TjZaK09HcXUyZ1RRZG1wdUM0eEVXUW1GR2lSSGhkNjFtK3JtcHZZdGlyMUJ3?=
 =?utf-8?B?aXZ4K3h1aEY2bnlFaUpJQ1JYTWZXN1N6WHRZR2E4aEtOREEza0JCaGR1NXdQ?=
 =?utf-8?B?MmZoY25hdCtqUkRYd2N1bVhFckQrbUQxU2ZoMmxFbnRFOW9mQzI1Y1FSZlQ4?=
 =?utf-8?B?TzNLYVU5RlRXVTRySUF1cHNLanYzZk8yODJKaHNjSHV1eSt5Rit0TFA4c293?=
 =?utf-8?B?WW1HYVp2M0dYU1FhNmp3R2NTelQ1UU9OeGhIV1hCWGkrbm1HSWxqWkZHUXNJ?=
 =?utf-8?B?b1ZDT3dUWTZKUDBjNnoxbm55U3FsNFdPZ1kzWWduVUtEeElPODF1TnRJY2do?=
 =?utf-8?B?VFNHVDhrd0RjWGNMUk9YTitGS1VKWGdLckZFTnh6S3pUZDd3N202cFRjeXhX?=
 =?utf-8?B?VlJpUktWN0kyQkZUSXRkeUsxR1Y5Vm9RYVFZSEUyRGtnc3QrRWJsMnI0MktO?=
 =?utf-8?B?UGlUcmMrbjFycEZlc094bHllNjA3WjJrQklqeVNLSUN1MWlLRGlSZlAzLzh4?=
 =?utf-8?B?TmRkU2xBblBQWnp1clUwdlVLb1dkQno3ai83eDVtUFF2bnJ0UnA2ZEYzM1Vn?=
 =?utf-8?B?dTUrTG15Rlh2b1ordjZqcmt4NngzL2hLb1RwRkgyVFFSZWxWcjJqc3ZlN0dj?=
 =?utf-8?B?YkhrTFhTUTNZTi9kZDFiSGltempJY3hVT283eXpUVkozcTJoR0k4VFlJNS96?=
 =?utf-8?Q?DOmAletbL4CtoQwFLiSQkiv14?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2138fb4-edfa-4710-9a72-08dd14e2322f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:06:29.4837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpVC2WDKblYSaLWyc4Xq2vUqNudAcqLdoqzTwRN6/cxY2g9R5dupFwAorBbfgndmI5EWGtYyRp5YezteyVBfcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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

On 12/4/2024 21:59, Lazar, Lijo wrote:
> 
> 
> On 12/4/2024 10:15 PM, Alex Deucher wrote:
>> On Wed, Dec 4, 2024 at 11:18 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>
>>>
>>>
>>> On 12/4/2024 9:30 PM, Alex Deucher wrote:
>>>> On Wed, Dec 4, 2024 at 10:56 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 12/4/2024 7:51 PM, Alex Deucher wrote:
>>>>>> On Wed, Dec 4, 2024 at 12:47 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
>>>>>>>>
>>>>>>>>>> +enum amdgpu_ucode_required {
>>>>>>>>>> +    AMDGPU_UCODE_NOT_REQUIRED,
>>>>>>>>>> +    AMDGPU_UCODE_REQUIRED,
>>>>>>>>>
>>>>>>>>> Couldn't this be handled in another API instead of having to flag every
>>>>>>>>> load? By default, every ucode is required and if optional may be skipped
>>>>>>>>> with amdgpu_ucode_request_optional() API?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I guess this would be a smaller patch, but 6 eggs one hand, half dozen
>>>>>>>> in the other?
>>>>>>>>
>>>>>>>
>>>>>>> I thought only ISP and gpu_info (no longer there for newer SOCs) fall
>>>>>>> into the optional ones so far. The usage is rare, similar to the
>>>>>>> nowarn() API usage.
>>>>>>>
>>>>>>> Also, as far as I know, the cap microcode is a must whenever used. That
>>>>>>> is not optional.
>>>>>>>
>>>>>>
>>>>>> The cap firmware is definitely optional.  Some customers use it, some don't.
>>>>>>
>>>>>
>>>>> I thought optional is something that can be ignored even if FW is not
>>>>> found and then driver load proceeds.
>>>>>
>>>>> What is the expected driver action if we classify cap firmware as
>>>>> optional and then it fails on a customer system that expects it?
>>>>
>>>> I guess if the customer expects it, they can make sure it's there.
>>>
>>> I don't think customer really can do that without any diagnostic message
>>> from the driver. Driver has to show the right message. If it passes that
>>> silently and fails at some other point, it could be a totally different
>>> signature.
>>
>> yeah, I haven't seen any bug reports about the cap firmware so the
>> current behavior seems to be fine.
>>
> 
> In this case, need to have a info level message when a firmware
> classified as optional is not found. As it is only during driver load, I
> don't think that message will be an annoyance. On the other hand, it
> gives useful info if it runs into trouble at a later point during load.

This series stemmed from concerns being raised about the WARN level 
message from the core but there is no way to message to the user from 
the core it's optional.

Do you think something like:

drm_info(adev->dev, "Optional firmware %s not found\n", name);

In the failure path for the optional is fine?

> 
> Thanks,
> Lijo
> 
>> Alex
>>
>>>
>>>> I'm not sure how you can have both without it being optional.  For
>>>> customers that don't use it, requiring it would break them if it
>>>> wasn't present.
>>>>
>>>
>>> It's working so far. Having all is better as long as loading that is
>>> harmless.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Alex
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>
>>>>>> Alex
>>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>> Alex - what's your take?
>>>>>>>
>>>>>
>>>
> 

