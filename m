Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843C9C54F30
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 09:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD7410E418;
	Tue, 27 May 2025 09:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s3/tKtnp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E6010E3FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 09:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd366bA2QufqqMmYiUC7H6hlA7DI86KdeZAXR27/bt0bfGHfRnNtyd+UuJR4RTZ37AeaXiFYc7tfocZeDu9mUxQO7N4HucQTjeF8ZNAG8wd1HkHyLQayt3QRHkaczEAumb7FxtaE0ozefAh2kFInpjQ+0sRJhY4wfCdVs0wy6wBB6s2LjUxD4OxCAtkjBXV59F2hGNtG+8Dehm79oEJzPnUS+WxSfTzkYvFHHNKIvNxQ+VDvNzKyMs3nE+iwmfJnll5s+dzg/uVd+HpQSC9l5oHOGatQqi0IBdiN74kUPBONw7OuZ9VskjbEW3RejPNS6CLPHiUMQ+c4SsBzHW8Qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRhWxv7K2gargWthLEbmuwOWenPWP3QZANvc1eOXXQ8=;
 b=oh0dTAS3mIg+wFAhROOJsZhtIj/4t7pmf83CNuWW4Jp9I/agnCmlmblEyoo8TfwBZdU2oDTNE6ZAGG8OalwV+2vyvIA7Rd6QLyKa4hsxBojj3mUBn/qmz78EkwgIH3vmmsB9g/0l+UsNBkwSltmCGtAo+88LlskRzfm5ifRflHuC2u3ukXipVkxnegGdnOMc5jj/0TIC/OA/n5H9raQx/disfBD6q8szy9CJocAkz5i8qEmRvSIHEIA6UPipoxEIef7kgAXRvqnvGPzl9aN+KzT6z0Q5K0yKlLnL1on9M1etq2pd5K2XGoVvzC26bt+QI0HcPwhRk5GS8TzOiGIjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRhWxv7K2gargWthLEbmuwOWenPWP3QZANvc1eOXXQ8=;
 b=s3/tKtnpVHyOA8A/o9izaFOedSqmohssY7owE3j3CWC9faIhC6FQN/oHi8pXMHhOwQyK1/qUC5+dlkxCUPKHaz8KmXegLEcjhM4oIUd7+BxZ6XVuRSaNAphRFDsFbwQ9ZpNwCfkG3xGKJTYvcNft6xgSg68+qhT2MOrnPhEG9r8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Tue, 27 May
 2025 09:01:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 27 May 2025
 09:01:38 +0000
Message-ID: <6316cfc5-5b63-4a0b-b290-087c19f68790@amd.com>
Date: Tue, 27 May 2025 11:01:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: promote the implicit sync to the
 dependent read fences"
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250527085814.3853953-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250527085814.3853953-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd5f901-2230-48e2-754b-08dd9cfd16fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THNwOVduVE1POFp6bUtQVUplcXZNU243MEtvNU5xTVRBaW9SSWZKNy9qZ09h?=
 =?utf-8?B?SWMraHRSQ0R6YXJEQlhEMVhXOG45UDBvbjdsM05BTXRGVzZrZk9GQXJJWmJl?=
 =?utf-8?B?WjYwSzNwQ1lQNE5YbkdjNTRXallhSExhWnFSdzYxSlIrK1pINVpTeG1DL1BW?=
 =?utf-8?B?dlVEM3Nma2dRTzZrZFNXbFBkZEloNkQzVmJOVXhxMnpsUTBQc3pvK3BOa0dI?=
 =?utf-8?B?dUkwaXhNMUlsUmlyUW05UUtmUWlQblYrdUFlYXR4NkpSN0tLTWJCNzE3aHNm?=
 =?utf-8?B?WlRyN2V4NGVUUC8yQzB3NHRiL1FVYjBwbWg4ZmxKVWJ0MlczclE0dHp5N0RV?=
 =?utf-8?B?cXpRdGpQV3Z4L0lwcHlNS2s3c2pqTk9WOThsZ2crNUE3ek01U2M4Z3pQUHQ4?=
 =?utf-8?B?K1A4L1VPK2I2a2x1aS9pUHJLcW5WT2hLQ3ZaZlY0YlpVeU5JTDdYcXlURnhZ?=
 =?utf-8?B?Q0s1YzMvQjQyWGNEaWRjVVFjOXNZWStvTVFyZnBobDlJUkZyQVBBb3UycFBH?=
 =?utf-8?B?SGYrNk53c09KUytYeHFVS0EyRmJWWEhiZktUYzJWL3UvcTBIRElNQk8zRTg0?=
 =?utf-8?B?bkdZQjZNSTVKT2N0ZUhURjhnRGxyVXZ2UVg1VEljSDZnR0Y5RHhQb1dXSWVv?=
 =?utf-8?B?ZmhzRU5lVVJ1cldkYXZNcWdMcGJPZnYzZXI0S09vYnJpZFROb2ZhZHZuN1gz?=
 =?utf-8?B?aWNFOEduckwxWFh0Z0oyVGI1SXdnZ3Y4VkpETWZVbFJVUXl6YTlKNDlPcVhs?=
 =?utf-8?B?d0pjV2RzRjZMMXhqMy9uWXZjeTg3dEFnQ3JXYVB1eE9aNVE0UG5FVklPMlNs?=
 =?utf-8?B?QysvWmRYcWxEWGF3blIvSm5SdjJxenlUK01ibnpUNk1LNTFNTUVja3d0bTNx?=
 =?utf-8?B?eUNtR1ZCWFoyc3FIOFZGNVZxVlZUS0dhVzdpQTBLbHpQVzU3RmdibW52VWtx?=
 =?utf-8?B?a1NmbEJ0bUpvYWdVcG9pUTVYQmFlemczQmpLVXhwUEhKMWd2UXhteVRZNTY3?=
 =?utf-8?B?R25yZWlHampoWGZQZzkzSHp1Z0FVNjVMWVM0dko2Q3ZsOUJnOUVTOEN0OHQv?=
 =?utf-8?B?NlF6VE92VFE1WGVWSzJoeWUva1hBKzZReW1PTHlkbFQxV0xqek94bUpvdzBk?=
 =?utf-8?B?cVZSbGM1UHZ2NjhoTW5HKzM2VElVUmVLc2MyTURvSTZoaHNMelJ1azRJUDZE?=
 =?utf-8?B?REtRekNDcnBZbHl5UnBIK2w1bzB6MjZ5Umd0TzcybnVqWnB6YkpzTzZmRVBq?=
 =?utf-8?B?a0FHU0R5WktDcmhwVkF1a2xGOVZHWFF2K1dYL1lzSHdHcFJ2M3BjWEJ4OE9p?=
 =?utf-8?B?c2pMUHFScXhrSUNsTGh1WGZDeVEwY0NkcUJVMUJhVDF1S2dadW5Sb1JTWlFF?=
 =?utf-8?B?cWI3c3ZNUWxZaGNkU3NWU2NuVE1rZ0ZJcnkzSXlrVTFlcHZISXd4WERNQ1pI?=
 =?utf-8?B?Q3cxQW5lNGtzdytrSlJyWnNEak02R0UyVHNoT2d6allDdnBOZ0wySkJFRlBm?=
 =?utf-8?B?S1o1R1ZUekM2eFEwY0ltTmdWNlNEK1ZTR1pnc1I3R05lNmhEMHpzT3pBMC9O?=
 =?utf-8?B?K2Q1eE9NZGdMZU1RQzFuK3B2V0UyaU1LTUwxNUJ1MFFJT1JsNmdUK1RIejNS?=
 =?utf-8?B?b291MXdwOWVWbDF6S1l3M3Z6SHNxaGhsSkdkaUhUdUJ4QVNZWnA4QXF4Rkgy?=
 =?utf-8?B?c3M3czkzMG5LS3dkQmMxVmI2cDc5YkY0aW9jZHd3aVFjME9GK2o3QkRmMlRm?=
 =?utf-8?B?Rm9ucXBIU3pOMTI3NmlvZVk1WkJBR0o5bjVOanQ4aUJuZW5QZUFWKzVHbWF6?=
 =?utf-8?B?QWsxWWQ3emFSZGx3U1k5VFJrUUdXQURwK3RkaEVqamZrZldFdG1XOUFXampp?=
 =?utf-8?B?dkVRNitmWWV1Um5WYzh5UUZ6SnQzcDdNZ05lOGdGS2NWZW5jQ1BGdHlsN1ly?=
 =?utf-8?Q?y9uEzLpOTbk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRNRk9ndmJiRTdVSXpUdkx6aWZPQzhTbU1kRHFna2ZIL3h6NkE1S3FadHNx?=
 =?utf-8?B?VU5MOVpzQXR6czJ2eDhUbkFaRjhJam1mUkViNXdUMnRqUzJUVENVZkcvZXNM?=
 =?utf-8?B?bTVkL0VmZWlkRVdWcHc4ZUpxd01kckp6TENpcDU4akpYWkZYZzZTOURhNlhP?=
 =?utf-8?B?ZThlWGl1RzJvSkl5b0dteGNaLzZrbVpvdXlWYittQVBNd1AyRU55Q0JkaUNO?=
 =?utf-8?B?U0IyV1ZPbkd6ZEZ0SVc1ZmdHeTgwVEtwb0RJVWZJWVYrSUZPU0RnMVU3cDNz?=
 =?utf-8?B?WmhSUzF2TlNwZGRBZFJCcGJ5VGU3ZGVuNGFjMk1CQ3hrMVJOME10bE9BUlp6?=
 =?utf-8?B?TzlVR2RFTU0rTTN0M0VFdlF4TlRaMGk2cmZ0TEgzVHhsZG0veUxXYWs3YXk4?=
 =?utf-8?B?d09XY0ZwdWFZSFg3b295dzZsWW02Q1hDYStiNUNFRmh6dXc3QThBZWVyeTZV?=
 =?utf-8?B?aVdGTGxFTTY0eloyUUoxUjdVc3NwbUlSZnZlK1JZVzRYbE4yWmgrWHNVSnRC?=
 =?utf-8?B?R3NTRTJSbzZGaC9EUzFVaXlsVXBKOXdUakhPVDlCOG1vYXNGV0MzQWZIa1Mv?=
 =?utf-8?B?NDhhajRQeG9teDlOd1pZNTMvdDkrV3RLWERYY0U4Ymo3SFdYc3pMdCtHZ0Yx?=
 =?utf-8?B?OXA0ekpldHNjcFNiU2wrb3VyLy9uM3ErSzBPUHdsZEN4dlRzeFZTbjhXY3gr?=
 =?utf-8?B?M1VpamVMUmdWV1h2UituV2U3em8xNG5Kdnd0aWdqTVFwc3MyQ3FCRy9uS3ZQ?=
 =?utf-8?B?U2lXS1dURldma1RkRW1hWFZ5UENnK1MrNE42YmNIamRTS2FnQlJibS9ib0tE?=
 =?utf-8?B?TytaUVlTR3lPeUJ1NVcvV1ZESTQ1KzdJL2xiZWVMWjNESWxMbTVVWjY5MHlP?=
 =?utf-8?B?cXZDbUIzWmw5OEpVNUFKcHpHNGIvZk8yNDZMeUYrOHpFZlAzQnd4ZC84bVNt?=
 =?utf-8?B?WG9OOVFucVdoN1lqTTVNT3dZZTQ2bi9xSytBMEtkeTdjbThyZmhmNVVsc2N2?=
 =?utf-8?B?ZkhWVEF2b09OamtRUTc3ckh3N0NSQkJ5bTZxbWtVeTBYL0dnL1RQUG9yTjl2?=
 =?utf-8?B?VFBLWnk2clEvaUpkd05qdDFxajQvNFg3MVZ2emF6dmttaHJNV1liODA2OEp2?=
 =?utf-8?B?ZHkxOFZtcjhTYm5tajBiMm9sdGRPRDh6NEsybURSeXFYaXp0enVlQzRHN0pF?=
 =?utf-8?B?L09pYTF0RS95UC9HR2NUTFI2ZTQ3RnFrUFFPdkNrNGhvNDNJM1AyZXQrc1hr?=
 =?utf-8?B?ZnByRGl4THVDaUFCWGdXV1JQQkJtQWlHbW5zdmlwWDRaQWQxZ21mSXAwRzNC?=
 =?utf-8?B?TnlCQTdGUExkeVhWaTI3SWF1MmoyRDVZSldHU0JIVnZJbTlySkZIRzlEOVFu?=
 =?utf-8?B?KzZZRnZYczFlVUZPYVpZSTBUQkoxU0RoWHZCZ1NHNGNqM2VHeElVWHlkSERH?=
 =?utf-8?B?aUN5aWJqZFZ2MVpVeDgrV3FLdmlyQm12RWtNNXFucFJEdkV2MHhCWkZGaDJO?=
 =?utf-8?B?QUtzdGdoRXFDVE1CSmFKQy8xaDh6Ylk2MW5wYllQTjhmVkQrZFBPNFo5V1E1?=
 =?utf-8?B?N0RKa01FYUpNK1NXVWF6VzZuc0N6VzV5MEVRWU1zTTYwYWJ2VEZ3T3h3cW55?=
 =?utf-8?B?Wi9aNmtLMXdTc2I2RWVlcytGam5MdmwrQ083eDZ6ZVlDSWMrVGxteDEzck5k?=
 =?utf-8?B?VmQ1UlJiTDFGVjEzeUxaWUt3VUJNNnNEUElUMjlZR1h0aG8yNTA0U1ZQek5y?=
 =?utf-8?B?ZnZhczhvZnFUYkw0NmFTT3ZBOWxXM2w4WmJqM0FyZk1KdVFubkJtdDk3czFU?=
 =?utf-8?B?eWhxZDNvYXNpalQzMTUzK0tLUUtIV0lyaUUwWHBsUHM2WDZVTzhUQTcrUWR5?=
 =?utf-8?B?NzFGK1ZhcEFuN3pFb2FTWjZpd3YyZmxET1Bzb1RiVHFldnRhRW1CalZuRUhr?=
 =?utf-8?B?Ti9JSmZ1UDNvSEVuU2dHbkhFMVozY2NOaHdSdngwbnpWNVRvejBKeXluaGM5?=
 =?utf-8?B?NGJMMGEzZVNKM2dkNEluVTl6bHFvWU9mMUJ6NXRVb1lML0lyOWlBZW5wTWxD?=
 =?utf-8?B?Y2xTL0E3V0J1UmRBQVhiMTZqRGoxa3Q1a2kxVVRHa1lPZUJ6MlpFeDlNRmtu?=
 =?utf-8?Q?dYQxQdSs2yk3NZPTGF42CId39?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd5f901-2230-48e2-754b-08dd9cfd16fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 09:01:38.5354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AeH9nhw7fIygfC2GlmBQrQdQbHvdhFYcb9moraqxQEdTGN7ftqqEBoTL3YeScqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

On 5/27/25 10:58, Sunil Khatri wrote:
> This reverts commit 714bbbf20a7266e48632fab466563e695af9acb5.
> bisected to this change which is causing the flikering issue in the UI
> for various apps like glxgears and unigen heaven.

Is that flickering also there when using kernel queues?

If not then without an explanation where that flickering is coming from for user queues I have to reject that.

It seems to be the right thing TODO and we are still in the process of hammering out all the bugs for user queues.

Regards,
Christian.

> Also when we set user_queue=1, which enable both user and kernel submissions
> the userqueue tests in IGT also fail.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index d6ae9974c952..5576ed0b508f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -249,8 +249,9 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>  
>  	if (resv == NULL)
>  		return -EINVAL;
> -	/* Implicitly sync only to KERNEL, WRITE and READ */
> -	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
> +
> +	/* TODO: Use DMA_RESV_USAGE_READ here */
> +	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
>  		dma_fence_chain_for_each(f, f) {
>  			struct dma_fence *tmp = dma_fence_chain_contained(f);
>  

