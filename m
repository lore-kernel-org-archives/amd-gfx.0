Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A390FC25B79
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 07:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103F710E229;
	Fri, 24 May 2024 07:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DMwNQ9Bd";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE5F10E229
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 07:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdHDdSz1xiI/hUkJC6F8OqJ+qipYzDNJkqUqF/+3iW1teTvSx7OlXHM0GqLvrUzhX2o2qb+o9zjUuVxU605Y4KTffky7nBb6+uR/b7rYHU6iZkpNopmx81PiUTRlTWLdmsW9qlRHmlt+ZamCHqhFQwIiE80kfz6V4ofDxUPRURIzcW3mqFNrSZin2Y0CGw1R0RSS1tWdGz8dAZCwAK/UQK0bhYMYNs4oabCJPyYhh4si3xNbK41nXWHkhs3mbsrHgS3jKtEZlCMoq6l214/T9bQ8OQQSmuMV4yU1ueUWCnr+9H4DUwvQ9PWQoQ3pC8h0tP8DQ30+uBCplyvQYV7JFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru0e9FB3zGxx1YdEgV+ru9ExO88+2gr1LuP1IcaOMw4=;
 b=HjnzycFU9+3q+hv0yVN1Wd3JRTQJfoCEpGDZjSgGePk60bVL2FewIFTP+mk+/O2otLQ5QcmhXWImKvqvwIcQjCcKjzukY6kMtyLrAC5KMrbyodwWWcMEep13bCYz5GO+CzmJ5UIuKit6CxTbQCllxJPzP/igrY+tTKqu6ES5oHnHviGRnxmKXAMBt3skgYHcn682vdwYqnhUqQ52R6T3/Ow0Lq9AIrzrlWXImuXUF8mrQyPvOpEKL9r+xSarHsVu0KW+RMNyW/3xdwYFE72GnS/82lnKk2tJpx5V+/uTW+9vkQBd3gXgoTyBfkNw/Q1slKgJsOCJ2ENyjyehAnLSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru0e9FB3zGxx1YdEgV+ru9ExO88+2gr1LuP1IcaOMw4=;
 b=DMwNQ9Bdri9/6RWChfTN7HjV800YOeH8oMDqzP2HbXB7LQZ0DMD2CFxNFTMDKCA0dI0qUeJqT0mht+JlKQN25xXywcwwbJ+0hrZ+S52NpAqplxcmHUTNdvrOmr9wbUkc9GdPehfZg+sldJ9WmZ4ZPSm4Cgy8KdKEer10TuP8bQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 07:49:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.037; Fri, 24 May 2024
 07:49:07 +0000
Message-ID: <5e4b57b0-441c-4207-96c6-63d54ee62f29@amd.com>
Date: Fri, 24 May 2024 09:49:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
 <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
 <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
 <SA1PR12MB8599A25B022AE47DFD501021EDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB8599A25B022AE47DFD501021EDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d7cdde-ff14-4e68-61a2-08dc7bc5fd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1c4WjV6enFmckkxWW10a1FYWi8zWFU1NHQwTmNQYmRvWVV3UTBkVkVhenNo?=
 =?utf-8?B?dEhOWm15RUwzWXYvKzRjMXdxYTRZWmFmL0d1K0ZiTWpDdm1SRnJYR3RCdVlq?=
 =?utf-8?B?bUlVb21YL3hveUdLZkt1ZUZyN0p3U2tFMm5GWjVGa0JocmFxREJseERRRlRU?=
 =?utf-8?B?M2JtNkU0a21tUXBKU3NxZ2JoSmVlZi9QL1JGSjVEcDQzbWZMaXEySXdDZ0ti?=
 =?utf-8?B?anpJS3hpMzMrb0p5azlma2FoYUVUYzZDelRTcm8zR3JCN1RNcklZSkxhb1hn?=
 =?utf-8?B?ellyWU1kMExaQzVCbHZHN1JRM0hJN3VJZUxPOXlPR2NyTXJkRXQ5QjBpRXhR?=
 =?utf-8?B?bnFQMFFxWlp1Nkp2WEo4dTRBR2d4cE5PRVI3a2l0MXJrYURVZWZQSmNxTzlS?=
 =?utf-8?B?WldCNWJJaUo5UkIvd3dLQW1CYU1Ha2RqdFliUU5QMkZFNE1VWTVQR3lTR1V5?=
 =?utf-8?B?VFhCNk9OdU4wdldIbXpteDNJMkV1Szlna29IanZKTnE0Q1l1RUdnTWVnamJ5?=
 =?utf-8?B?MStXQ2dGdDU3S1pCNGpsanRYQkF2LzNKL2NlYWRiTTJrVnFuZXF4Si9ab2RM?=
 =?utf-8?B?VVdoL1V5OG0rTVFmVlJkL0Y2WlJaYlN3NHJJeVVZa0VKSUFSYlZhK0Z3Tzky?=
 =?utf-8?B?a1N3M3BIS1A4SmRjOVRvU3c2c0E5N2hLKzdCeHlaM1VjV0pYaTN6cW4vN3Aw?=
 =?utf-8?B?QmlVTGVySDdFWm1WZDN2d3NRTzVWQzhrL2FLOTFkd014NHl1b0ZuMzl4ckY1?=
 =?utf-8?B?WkovUjBheDhURFpuTFhrRDFjNXZyUlRRK01IVmZJRjdFNWx6WEE4TDBzcTh6?=
 =?utf-8?B?ZTFGYU5rSytmNDh5YmlrMG00TzQrMEl4MFNpUTIzVjdaK0p5ZkpyZk5RcE5E?=
 =?utf-8?B?R3RhZVR0S2duRm54aDB1U0dGWUY0UktvOWRWcGg4aTEyNnRIcVZmMmNucHRN?=
 =?utf-8?B?dFc2dEVzQkRXVm5CRVpWWGdBc0ozY0ZRbk05dVJLMnRtM0gwNzg0eHRYb2s5?=
 =?utf-8?B?cW9KVDFaYWFHZFJYSWxBTit1aVgzMGNuTEZ6Q2l0YjlVdnF3NmZvUCt2OUYz?=
 =?utf-8?B?YXVXVEVkUHp5dTk5c240dXJzLzM2U290WXl6OHZ0ZHVpSjgwcVJSTHp0TUlH?=
 =?utf-8?B?ZXBoY0pBVUwrLzVaaEpiSFRWSVBvb0plWitMUTk0bG42MUlHRUlxSDkyTm9w?=
 =?utf-8?B?MXROVlVZeGt2dFliTENiYTVuUXdHMFdreW1CNUlkcjc4NWVRR0xrT1pITmZr?=
 =?utf-8?B?UG5SS3hpV294Mm5ZQTBhZG5JM2lJTnZtZlJvdGVKM1Rkd1pBc3NpeFdlS2FD?=
 =?utf-8?B?VUVJNVdENTYrVW53by9pL3B2SC9VdDdyVUpZdlJoTk1aUlpIb1RaaFlPSDAw?=
 =?utf-8?B?TlRJREhwZ1dPLzg4NGpsR0VBK1l4NHIwYWU0VTBReTB1TFV0Nk1Ib3NsNkVr?=
 =?utf-8?B?VHpaSElHOXlabXU3Q1gzUFd4Sy9UMkEvRTdpcUozK2ppRDd5QjI4VThoTXFG?=
 =?utf-8?B?OHVJblVUWEdrRDFSZk01SGtnTWsvelN4R0VKY3dTdzhnQmdqUjZsMi9hL3d2?=
 =?utf-8?B?cTRsU09Fb1VuWTBBQWhuNFB4K0JhOUNPVjhlM2pwWi93SjNKVHVuR2hxRGJi?=
 =?utf-8?B?K29OUGJNQ3JhcTJxT2tJRTlQYTdaYXI2UDdYMXllNUtxRmRPbHNmcmJtWTBQ?=
 =?utf-8?B?OWYySExDM0J4UDVYVW0zTWd2N0lGMFZwcXgvQk11Yk5JcmtXcStLaUNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hUdjljMFEwWGltN01HOFl3ekdJczFXVFFDaXp1dnNDRHphT01mUVVWQXpK?=
 =?utf-8?B?RHV2RDZGVTFrMEdDUGtheGk2ODVWQUk3Wi9pWGlWVnM5VDJGOXVoVG5taFRY?=
 =?utf-8?B?cXhBanU5YXhlOU5maWJGQ1ljUDRWREdsNnNuWTBlNTllYk1OL3NhYVdCbEdU?=
 =?utf-8?B?bXlFTEduajNBcHNnZDU1aGNMMVpMVHVHUUhoa1BjcHZFU09mSEczZHRWNG1n?=
 =?utf-8?B?UjBWZEp0dno4czZXVzltajJxODNhVkZyaUY4UFp2V211TGxIME1SMElFUHND?=
 =?utf-8?B?U3BqRWhXZUcxdnhVYmhJZVFxazNiY0xQWmxKZXlJa1YrZzA2QWtoZmtaeThi?=
 =?utf-8?B?THdhUFBGU3l6UlFQODNiVDFab3V0VlJKUU5QNlJPbHAxc3dvNW5tZGVteWtH?=
 =?utf-8?B?aExzdjBGdmc3ZHo2UFdPVmNGTVgxcUYwWWpDVjFGNEhQNWg2WnVlUkVtM0Yx?=
 =?utf-8?B?WDd2M2diNHJ4aTFDWVR4bTJXcDZzTmVDR0hiek8vYkhwalZCSU5udVZkOGRP?=
 =?utf-8?B?cE84V1hHMmNERVpGdVpWNGYrZ0pMMmRUNnJmR1A2dE0rZzNjbW03aFUvWENM?=
 =?utf-8?B?Z1ZLVDFWYnA1aFZIZXVKWEtpc3ZGZWhyVG84a3NzcG1JNE5sRGVtczVOcmEz?=
 =?utf-8?B?cmFhYmNtMzlXYS9LajFRajRmWXhiWmVFZUQ4bkMyREdNS2RSZHBSZVU0TVoy?=
 =?utf-8?B?dzZTay8wRThlSHBHMk85UXhqWk5JamlSdGJVdnVVNkVXZHJjOVhSUGRJcnpZ?=
 =?utf-8?B?QXFKOTdkUXRQQzhTSmZXTWF6NjJoSjJoRVBTcSttV0xxRG92OUhWVll4OW93?=
 =?utf-8?B?R1M0cENTZTRUdUlpSEJLRGxtKzlGdVJqSHY1NWZvOUVwaVlCR29nWkRKS0dV?=
 =?utf-8?B?ZEUwVkM0OUVPaTNNZ0MvZ01aMmRhYmRsUTV5bUMrb2x4L3JrTW85a1BhTFRq?=
 =?utf-8?B?b1Nla1ZaTXFONDRPYThpR1hYMzRwcVFhdmZxNHpOM2VKODBxY1JON1ByN0dl?=
 =?utf-8?B?ekxsL1hMeGtCeWxIQXQxNGh5U2x6ODBDZC9oWTRwZ2hFUDY1NjYwMllBaXFW?=
 =?utf-8?B?RVd1cldBbVUvb0tXaFRVTFh3T3RHVGlmS1crcTg4Snc4dHptWWRzVEtTbXNM?=
 =?utf-8?B?NmR3TkNTeXlhTFpvanp2Z3M0VHB3OXg5SGZvV2JDb01wbGtCbnhiQ1FPZlRB?=
 =?utf-8?B?N0lSMjZNUG51RnEvc2hXUmltS0ptL2J6eERnTUpYMzAwY2pZQ2pqMnUzQ2tD?=
 =?utf-8?B?VDhGUFJPVEF5WE9UaTJaMURYNGJMcXFDVDhBZmxrNzJId1JrSDJObDdRZENT?=
 =?utf-8?B?L0RWRDJQVUkyY2FJcDJUV0g4bXBSNGVFYm5ZdnpER2wxYksxeEgzeHd2SUky?=
 =?utf-8?B?NmNjSmJacjRjTFpTdGNIcXdoRS9oaTJUcm9PZ0ZldTh3S3JRM0w5ZE9xdXdK?=
 =?utf-8?B?L054d3JqRzVoYlVndEpsbFR4Ly9wYjFKVmZxVlIxZ0NpYUVZTFNkdDRuODE0?=
 =?utf-8?B?UWRKZTAzdytnbmFDZ0xCbHJtVFdyUXc4dGwxdDBrQXFkMzAzWmVaWVhHS1RH?=
 =?utf-8?B?YnlWMllaSy9EQ0RHR2E5NlNwZldGMWk0WmdtKzVFUUdpQWxuUmZtaVdld3Jt?=
 =?utf-8?B?SEp6ZGY5TWxqdlVBQWE0Sk5sSjFFZ0FzSWNROHlDNWhSUDZqcERCTk1LK3A4?=
 =?utf-8?B?bjBaVUZZQUl3MHJyNG0rL2U3RkZaL2ttbForV1hUZ29rY3M0OTdqMjh4Njl3?=
 =?utf-8?B?eW1FMDRtYWpZd1kzelFCODNVVDM2ZFg2cGMzQVloWUxDN05kUW5VNGRxQ2NU?=
 =?utf-8?B?Tkh2YmpPeTBQYVdrYTYwM0pYWW9waGZYWTNrbUJ5cUYxckQ4bGpIWjk5TlNI?=
 =?utf-8?B?RmdQZVlSejVlR3N0TlRQZlQyWkRDS1RwWkFsdmFIT2dMd0grN0xXeUNrNDRK?=
 =?utf-8?B?TXFGSHl6S2dUTjlqOG55M3IwVHpjQ3l0WHVyNFYxS0FlTVJkRTVGRmE2c05u?=
 =?utf-8?B?SW9TYTM4WlhOUHVhbTlMNnN5MEpTUmVUZ2JjaFlMbkFRTHVCdyttRWR0bmxT?=
 =?utf-8?B?NFhUSVN1VmVCcVQ3THJudDYvTHRHbEU2bmJ0SllFa1l1ZnY0M3F2OXlWZFh4?=
 =?utf-8?Q?aU/k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d7cdde-ff14-4e68-61a2-08dc7bc5fd5a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 07:49:07.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9SSo1j8S0lMp7WidLcFfLNU9YIz0GH1/IsJ5s7GHcLM4AN+/fkpSHhBsGnACt/F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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

Am 23.05.24 um 17:35 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>>> Here is taking a different lock than the reset_domain->sem. It is a seperate reset_domain->gpu_sem that is only locked when we will actuall do reset, it is not taken in the skip_hw_reset path.
>> Exactly that is what you should *not* do. Please don't add any new lock to the code. This is already complicated enough.
>>
>> If you think that adding wrappers for reset lock makes sense then we can probably do that, bot don't add any lock for hw access.
> The two lock protects very different things though. The first case is we need to block two resets running in parallel,

No, that's not correct. Two parallel resets are prevent by using a 
worker queue for the resets.

The reset lock is here exactly to provide external thread the 
opportunity to make their operation mutual exclusive with the reset.

>   this does not only cover GPU reset itself but also any teardown that happens before GPU reset. The second case is we need to ensure exclusive access to the GPU between GPU reset and GPU init, concurrent access is fine before GPU is reset.

If that is true you could in theory lower the locked area of the 
existing lock, but adding a new one is strict no-go from my side.

Regards,
Christian.

>
> Theoretically, the second case happens within the first case, so locking the first case would protect against both. But with the current implementation this is infeasible, all the generic functions called between amdgpu_device_lock/unlock_reset_domain would need to be swapped out for special versions so the reset thread does not dead lock itself. It is much simpler to have a second, much narrower lock that only covers GPU reset<->GPU init because all the accesses there are very low level anyway.
>
> Teddy

