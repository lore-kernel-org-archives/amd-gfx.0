Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241EC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 05:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0930210E04E;
	Tue, 15 Jul 2025 05:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zZoDIMIT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B9610E04E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 05:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxXmK0JM6/awKHT74ifUBbmLgsCcCPmzkUddOh+8L7u/5crMz0YWW61o9FKnrXX+MQRhytq92ozi0cKvG5q3LYE8geo7cQ97HIlQcXyg1cUmHVUlXDbg0s3i54uYZHZmm5EYD2FzJrYcBUFPQl5WeU+H6neYXMSvcgQ3wxmEp0BlYUbHJnlp6zh+QMOSOndgcOk7oA+0eKoDqXEzcWP00MdV1pihvFfuoQkO+orqPEVa8zPOC6pO2ItHAGmosE/3/5YkBN9cOyUKhlpf8vlqKZhFgAVIrwiwNv3fj0LkrxiwGee2ewNz4z5Um+d54U0d4p2238vIGKjcchGDzmJuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYlWBBTt9bK8Lyxh3w2kmPG2s+COSdSacnCgS4cCXHk=;
 b=K7n8tSKXqVgFITubGyvdIMttKTGhbvABATqyh0ziJpULgM4P4lU0NSBXBlkLf0d2xgk3Klf9OnOoIUkg91fcnvV24rp+Lb4EEa95twktj3+DiJiK9upbtGuxP/Tol5avXd/CnuEIM3qUjbdtbTkjS6RdY/k4K2H8umLz9gVlvvoDOSRuH+T5dHUxa5bKzWXsvs8dAzyhkl073PgcEw8pJtPM0muYO/Oj49yxCHlx23CBHHvuWDgM8k/TzHI4JEw4OiYM5TniqkmQ0dhJctM6w53IljxQuv7mQxLdGOnAH9nw2kCq5H1VetybBQdMyHzJiGCjrknQndJoRc1WE3fHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYlWBBTt9bK8Lyxh3w2kmPG2s+COSdSacnCgS4cCXHk=;
 b=zZoDIMITkB0LWiZtOFiCR0d5KlVRKQGxnhMtp9J3mAnjeWlNu3sMzjR6QNU7Ev06AW5hVpZ2//eTFYTGk6raKdP8WitQTeq2egxapLBnHlQKuvTF06L+3BtAlo/FqfkBTmbD/0QWIVN5Hgv19D6y+pQ3JgW3dfKezDaeTdrPVTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 05:56:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Tue, 15 Jul 2025
 05:56:58 +0000
Message-ID: <d1c9a785-6c63-4bd6-bf80-a34e4ed54b18@amd.com>
Date: Tue, 15 Jul 2025 11:26:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Remove unnecessary variable
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kernel test robot <lkp@intel.com>
References: <20250715054502.302107-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250715054502.302107-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 6552abd7-9474-458e-d377-08ddc36468cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWFyenYzOEdETU8zRXE2Wk4ybGJHQkpubkpmeW40YTZlaHNZT0Z5alBmV21Y?=
 =?utf-8?B?MmFiSGRhSzV2dTZ5UzMvc1BRc0NBZ0lmMHhOdmJ0UVRSNEhYejVDbnlyRkR5?=
 =?utf-8?B?eW5Lb1FoTU5aSFhVWHJYZnpRSDVwT2sxakNqUkZhTk1ZVExML1A4MVVJaTVv?=
 =?utf-8?B?dC9ZYmxlWmxzaVpMajVWSldhY3NBQU1JUG1sUkQ4eGM3S2duV2NEdFpUWHpr?=
 =?utf-8?B?UW1RTjhseXVsZXhZRHdmQ1FqZllkRXgzYWFRNzVVOGd2UEN1UDVFYlhMcFMx?=
 =?utf-8?B?Z1V1VFJWMVA3ZmxkZE16ckRYdjdjT0FQV3YwcGNPY3Erb3EwUllXV0JWNHZv?=
 =?utf-8?B?WnFlK3o4aWtDWDJhMU13dXd0Y1FJVG5TOUJxZEZVdURpM3kyZzB1YytqNFBj?=
 =?utf-8?B?VHpDRFAyTUQ4TUZXMmxXSTJabWs2aDJjeURtNVRycFdJVkJpcnFRSjVJZ0tB?=
 =?utf-8?B?OU9JaUtjRjQ0WDRTRU02K2FkcGp4WWdIbk00NUt5a1RYcDZEbE5XLzFqeXhr?=
 =?utf-8?B?Q3FzN29EdGRuTjljSWtLZFNvY0ROZ1ZsMnpCNHhod0VXTG1IRHdKMngwRGhF?=
 =?utf-8?B?SytQNXFpRG40TUlQTVhIczRxMXlpZnlURm5POGZjWkYySnMwQmROU2lPcy9N?=
 =?utf-8?B?NjVGT08vQW1QOVd5SFo5OC9obEFoYVM4aEU3cWJKNk9Qb3NLYnJXTS9meTg5?=
 =?utf-8?B?eFR0TUZzUmIvZEpZQ3hhcEdPeEVMSnFCWm1tSjFaR3ZpNUZDV21oQkl5cGoz?=
 =?utf-8?B?eSsvdDVsaGhPWVdWbFhWUXlKZm51eEdXalpUTHlIb3R5ejRueERGR0xZVFR4?=
 =?utf-8?B?M0dGQ0lXOTMvejBJZDVzcWo1VWF0QjBtUFA1TWlJUXc2VlRXNzZUdU9mMXhj?=
 =?utf-8?B?UlBnMlJMM1Zwc3k5Sy80bzE2aTFwQ2VzYmkzKzFjNGNUZFVzMzdVMjNzM3dW?=
 =?utf-8?B?UkpqclhTSGhsdVhuQ05XeWJNOWZoZGc5UU1WaXluNUpRUzkrSHZDS0hwdDVL?=
 =?utf-8?B?YjAweE9peVZZZytMVGhZNFFpRGVsRjFXZ09HWGJYWWQvQVhtdlZpaG5oelBQ?=
 =?utf-8?B?b2l1WVJzaW9IQnF4bHRhaTA4b3dkQVoycndVRkRiM1U2Z25MWVRSdEpOdFVU?=
 =?utf-8?B?U1pOMkU4Umt4VnEvNUJaQTM5YythcVNzZzhqZlRDdEhYdlRkaGRscHMySkgw?=
 =?utf-8?B?cjB3UVRMbXFnVjVnajZSc05OSWRibjF0Yi9pS2wrV1VrOUlJZ0hrbHRVWDJO?=
 =?utf-8?B?ZHZsZDAxT2FKK1pZRHc2NE5uOGtFelVZU29mOWQxL0R1SHdpMmZ3U09tbE16?=
 =?utf-8?B?YndKc2F5OGtSMVpIMlFGR3BiMXgzUk5OZlh4WHFrNXJFVmkrSVgvV3RhOXJo?=
 =?utf-8?B?MmVUVkN4UU5SZko5N0grUnp6TGxLbXJYa2EyaXF1Uld6YTl5SGNXa2Fha2Ix?=
 =?utf-8?B?S3ZLbHNid2Z6cHJSQXFYYUc5RlY0NWM5TXRHdFcxMGtJWVZNRXZwaFdZNmNP?=
 =?utf-8?B?S09SaUJJV2xlMUtKbFMxdXVMTkloOEI1NTdOaW5kOUFFRndiNEwyNUtiRm1K?=
 =?utf-8?B?UEF1UHM4Y2VtWHNkQ3d1L1A1YmMyU1k2R2Q5aEEzdW8vcDBsNWJ0VFJMdHBY?=
 =?utf-8?B?N3UxdytreWQ0aGZkSmgzcjVWSW4vaFVlQXZldjBjbll4d2RJT2plbkVsaTc0?=
 =?utf-8?B?S0xqVnduS1NGQ1JxeDdkUHE1ZG90N2RlQ2hMU2Zwa25rd0pDTHFTL28vT2Fq?=
 =?utf-8?B?WDlYNWJ0ZEdKaWtQSXlCYWd6WDdvK0E5M0l6U1dSMjZUeXF6blc2VHlyS01P?=
 =?utf-8?B?elJ1ZnY2eEQ1ZlhYMFJSeDN3ZXVOd1BYK3o1RVh6ZkFqeDNlQW5wMURTbVUz?=
 =?utf-8?B?OTdVR0xWdlFJNDF5bm9ma1k3UmdtbHh3S2ZSY2JZOGtMMG1JNDlDNUpTYUNz?=
 =?utf-8?Q?MKQGf+ZJcc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNqb0RXZUZtalljQndWVWEvUEUwSWlhNzBWelZ0K3dwNU11WjF1Y1FSUnBu?=
 =?utf-8?B?aE11ZElGZ0dTYmJ0WWY3YWlDbmlRclRQWEt5NE1oSGZKUUx6UEtTb3pBZUFZ?=
 =?utf-8?B?L2RQeWNXeDZIZUlTdDk0ejZ4cFA1aUo1MlVmNEdqNFlEY25vcGNYTS8rc0gw?=
 =?utf-8?B?dUt1aVJ5c1NMcGNMUHh1azZ2SGI5YlIwd1dHazlKcGk4Zm9tY1BDVkVsd0JN?=
 =?utf-8?B?Z2NOUWM5R3BLaTBEWVYvZzUzZDh2VTF1cjZhdlRrdWRhQUk5a3k3NjkrODJi?=
 =?utf-8?B?TkFHd1k1MThremxOZ1FBVGcybTFWUzFKdzdXVkRMeUlOU2ZvTlRZS2hmWWhE?=
 =?utf-8?B?L3VzWUEvVzdRdHJPVVIybXU1Q0ZTcitIZkVTUDBwSXBaRGNXdC9OeG5rRWFT?=
 =?utf-8?B?Rlp4a0ZQeVpWM1VkQzRXUmxhOVI4b1EzY3hURHp0S2U4bjBnNDdBZXQwaWdV?=
 =?utf-8?B?aHl0Q3dsL2FiWS9WcW9mRDhiUEljalVYZm5YcEY2RXlrMzd3aWtVQUNsRWJw?=
 =?utf-8?B?Vkc4TVpXTGVCODRxeFVBdVR1eWcyUGxVTW43NytVK013M1kwVmR0RitDTmhB?=
 =?utf-8?B?M05PWWRSbFZlRlNocVFLVDM2WU9kdnlLODdiakxuLzBUU2gra3pGUjgvREpQ?=
 =?utf-8?B?RWsrMVhPUnhEbEJLOWVKdElJRFVYMy9zY25hcWdGdG01OWJCZXViS2pmQUVT?=
 =?utf-8?B?amFNK3AvQUtmbFFBVUNnY0dJbXhHRU1lVG1mNTllR1hqVDkyU3hMRXpmRTFG?=
 =?utf-8?B?T2NuQVlCcllKUW02MjZYRHhCenJGcmpJdUdiK09ROVhUTjg0UEdNNlN4bG9F?=
 =?utf-8?B?NkcwL2VNVmdocEhndHpJaHpUTTNQTk5JYjhLYWhMWnRMZi9RUEt4MU0vN1Bt?=
 =?utf-8?B?WmJVdm1hVTQwS2M3cXJ4L1IxeHZlM3ZsbGRyMStReGw3TENMVWxwMVlKaWpk?=
 =?utf-8?B?L3NlanlpbEhrOVdxWWtRNC9scDRzS3ZvdlhRWjNkaks0OWVCTXRTTitTZ3dy?=
 =?utf-8?B?MHlYaU9oMGp0QVFZZGI4VlJRVXNhcUNaVGQzZ25RUXd1ZHpTMTFsNmV6YUFS?=
 =?utf-8?B?N0FVY1NwWnczWHdwRHkxelN6aFZ0QWVJRFMzWU94RWZMMmYxUXJjTkMrSUxV?=
 =?utf-8?B?ZTVPTUZLT0pySFl5aW0weXJ5Mkl2TEoySDkyRXVMNHlnN3g2K0JORUhTSUNq?=
 =?utf-8?B?RURFQlFaa1F6eWViaGpOcytzQmhqOXc1Z05KclZKRmdlZUN5dDdDWDJJYWVM?=
 =?utf-8?B?YmxEejhhMmFQYm9aL1kyMGlCS3hRTGJHSHhOZjBVem1XckFUWm1oYnlNWmJN?=
 =?utf-8?B?SXIrZzV5N09HaGRGWllSeS8wVmFCd29OL0lFbEJKdUM3cEtjRXVRL2JYQXFz?=
 =?utf-8?B?RTF6YjMwRy9jVlVWbmNLU0pzcjlJaE03L3lxem5jaHdyOGxQZURNWXMvWE16?=
 =?utf-8?B?RTAxM1VDVHhzdUZpREJ2ZUtzRnFTY1BlMUdkdHNWRFY3UzdYWDZNLzBEYVZS?=
 =?utf-8?B?TGR0MndReFNYSHByS1puN0l1K2pvVTIxR2Q5dllva08rM2F2QXBRZFgzalc2?=
 =?utf-8?B?ekU1N1YwQ2RadEh0cDgzWDhtWlp6ZjNaSTRFNDExc0pxd1RxQzk0dTVzcGlG?=
 =?utf-8?B?a01FeGFNbVBNallTd0k4ek1Sdk8waFlRUkFxWlV2QWRtUDlWMHZ1elVtWFJJ?=
 =?utf-8?B?cWRLcFZMd2xRS21qUVNBN0R0azM3S1E4VnRoVVVJOGpQR1A1bE1XMWFXeklC?=
 =?utf-8?B?Wm5HQ2FEVzVCemRZYVoyWEt3aHBsS1RwSG1OeGFubThXUWFFN0NZeVFjOVly?=
 =?utf-8?B?TlZUVmtBbVFlRFVheGx5SnZSbnpmbXBEcXV1eTNTOXE1M093elpUTW03NStt?=
 =?utf-8?B?bm5DSFVqQkIyMzhaZndKa0ZiWC9UTnZBR09nYW5kR0d2YWlTV1hYSUx5ci9K?=
 =?utf-8?B?cEpudHF2d2thb21Qa3U4M0pRVnNTRHkwbGdEVkpWTnNUVmVaUjBTOU1YaVAy?=
 =?utf-8?B?RkFSVm04T1NsQ0ZuTkNobTkvS1FNYVJrQlJGVGNtRlFQWnRYblI4eWNUSGF4?=
 =?utf-8?B?bUR5M3VXYTRkMFdodDYvVlNzV09PV2hxNXhTd3A5K3B5VThBSW16TDh6c0t3?=
 =?utf-8?Q?sJj/GPXzK3XzAufhX/piuFCBy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6552abd7-9474-458e-d377-08ddc36468cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:56:58.3320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuDbLBXqBIuRvge3nAiwuaOd8AgdDLw4syY07gXIXm4OOpITGnYHAkxtJSrb0T1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
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



On 7/15/2025 11:15 AM, Asad Kamal wrote:
> Remove unnecessary variable ret from smu_v13_0_12_get_smu_metrics_data
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507150618.WOfvWsQF-lkp@intel.com
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index b3adeb6e43a8..02a455a31c25 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -301,7 +301,6 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
>  	struct smu_table_context *smu_table = &smu->smu_table;
>  	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
>  	struct amdgpu_device *adev = smu->adev;
> -	int ret = 0;
>  	int xcc_id;
>  
>  	/* For clocks with multiple instances, only report the first one */
> @@ -357,7 +356,7 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
>  		break;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)

