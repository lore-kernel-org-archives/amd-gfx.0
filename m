Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F70CF6C1D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB2210E57F;
	Wed,  7 Jan 2026 09:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGqM6NnS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012069.outbound.protection.outlook.com
 [40.107.200.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5502210E57F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f25LQttXhA8aJy9/fZ7/H8xSJNr+mc1DX64HiAyIBuVhVX7bvHBzNfRIA1xgCxQGbKEsZqarpXnQQWF9dKRWv21zusFuTQNVMKW9bYl90koty0X8D3hDuMfgew04aCSGKhS/4HPZ/3015i+h0TvLNenWZQMYXdMMFJjGtQyNG02JSldwcNkMhN5gSnThSJlbN+Disxjn0uzPFjrkiGnKDLfTv2nzAT7doSfnSSZlXoApA6hSsTvFIwU2TiEnj57/orat46Pqy2coaVgKiahSOUZQHmO29LtiucxONaq9+8j5CJBy2aqIHNZlg6LBduAMM+0KzNorLMIWloV0w3iQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E90xh5QJFHLq6pSozT/aABtTtZVOgORCWTxscFuoKc=;
 b=V5tS+26FFLdiUFCckCtbISLLCPgXmmpbPeRGrv8huon2AswD+j5TT5U/dfb9bb9Evt4AndqvnTM8HejaZ4+Vk+X3ISoQceWA+zu5/8GDJAVL6VQwX4WhD4zWEKnPL0cG8mCdOWepi2299bhVjpL8+SLt65UlAf4pJAv2Pcq6CQo8rAtiM5ZmBk7S3jDxd0h0BQRmkmwNGkPLaW1+mUxOibQOHyWZdocYFqiv3qRRURobcIuYKosKdDLPhl9aFPgoud10GMFEz9RytXS6QouA1NT5zCMi/2phrtM8N0JkoSxGIHe4yridIMGg1bYSwpfdw+wUxuuS9CJAB0ZqkY/lcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E90xh5QJFHLq6pSozT/aABtTtZVOgORCWTxscFuoKc=;
 b=vGqM6NnS9XYwhSAQz4afZ/nclDwsr1xYWgu+zZxD+KycVonqNtcWxPOYY2FWxuvnQjx4ZwV0Z/VcYcg/sBrPG7q88JMTuaG0OpRJqgCB2sFqHMkimMgRf/0sKuRE9gqB0U/2QYsUyNvRWZcZLdFZvTrnpM5v/zjOHqrLrUHtfhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:45:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:45:40 +0000
Message-ID: <87b05f60-87f4-446c-9e78-7c81930fa15e@amd.com>
Date: Wed, 7 Jan 2026 10:45:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] drm/amdgpu: Convert context manager to xarray
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-13-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-13-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf55d8c-18f5-42f5-6df0-08de4dd184b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVhHYzE1elN2ZStPbUs1bVgrNGE4ejN0ZUQrVWxhd2x0bDFlNXlOc2lpNW1i?=
 =?utf-8?B?cmpkbXhFQ1ViOE5MbmRWWi82bmk1UUI5K2lJUmJ0VGwxT0dhWElNVFJVYVVU?=
 =?utf-8?B?OWlLaVNpMUE4RWFRM016RnVabmFCNE94Vm80K0VQQllDRmM5NjBSQlBpTm5E?=
 =?utf-8?B?QWxnUVo3Z3VxWncvTlBvM05wZHZoM0xUdlFFNlJKMEJnTjVtTU1hWSs3M004?=
 =?utf-8?B?U0EraU1XaVMyVXRuWGJYdmJoS01xZmRPYXNjTnpvdW1ESlRBaXZTS2pWOTd4?=
 =?utf-8?B?Z1RRYXNhU240Y2F3VkR2TElxeGQzMHF2NVdLdStwZzdsaEZaMEdFTGhDVHFD?=
 =?utf-8?B?S01RVC9kOWgyRjlHeG9pQUNjYTkvdXEvcWdrZjQxNXRNOFhZWWU1UzJNUjhv?=
 =?utf-8?B?NlUyRU9jVzhMWnpseG1LWGpQQlNLRnBqR2tTSm5UTkNNOUs4ZVVJSDZmY3ZW?=
 =?utf-8?B?ZGNXQllHSU54emorR0VkNkdoK3NERE5qKzNGb3Z1RERNTnJJV1FMQ2hGZXBE?=
 =?utf-8?B?RUdMbEhSbm5uR2dMZldvZWpURkg3WGR3UWU5emY1RmYzbENoU1VJakRYL1Nw?=
 =?utf-8?B?K0MwOXlZcDBhbEFZVktPbU1wczBmNmFMSTZzTmYxd1k1V2dvWU0xR1p0aHNQ?=
 =?utf-8?B?dEVMVEQ4K3E3cDRJSUdzWnZlN1E0WE9uSmNzVWNXMnVKWDc2Z1V3emRrVzRU?=
 =?utf-8?B?WWh0M1lRN21kZTJNSTROTHZzc29pb244WWFpRzYwMmNUbnRjNjFPR3FNcW9J?=
 =?utf-8?B?MmYwUHFycHc1MXBpVXN3ZkVEd2NQWHR5UWh6MElFR3JudGVBb01NcG1qNm9w?=
 =?utf-8?B?THVRUFVOTFJ5K2xGbkRhZDhOWVNjS0ZMNFN4akxkTFFaVlZtMVRJTllpb0hL?=
 =?utf-8?B?V0t4OXZTRGZBdDRKckNpS205VDlBRlBmU1orV3hHcVNCVTN2ZytteUViQ1pV?=
 =?utf-8?B?VVlWYnVlWDVwekg1anNJbUlTaFl3aTVWWEViM2lpOUNzcHpHQ2lrU2w1c083?=
 =?utf-8?B?YURpWEdpL1FKMnRxTFQ3MWdxOWMyakdTWlVUeW5VUXVmL0ZUUWtFaU5TZCtP?=
 =?utf-8?B?THlDZU01ZVdxVy9BY01ldWdWNjliSDArTW15M0NHUExpQ0J5a2pxY0w0dTBW?=
 =?utf-8?B?RkVEVEt4NmkvSDQvdVVmVjcvc3lVQkcyNzZOOTA1VDVjMm90OVRxZ1VwQmh2?=
 =?utf-8?B?RTg5UWxEdEZSNlB3dTRKcFRVZHJObzh5SzkySXJ2Z1NFZ2Fvenp2aTY2NkIv?=
 =?utf-8?B?ZnVOK2dCZ1FIWFJDWVZxSHdxT2JzWmJFMEg5QXVDYURDT2FlT3BudzZicUpW?=
 =?utf-8?B?eFJyNEx2elFDNE4vdnFoaUFLaUhsbmk1WVNoMVpGN1YrTVpqWjA1SkhaeWhi?=
 =?utf-8?B?QVZPZnZKZ1BhaHVDU0x0aXgxRG5iQks4Y2xjWWhZK3kzVUlNYXdlU3M3Vjha?=
 =?utf-8?B?Qk1wdEdvTDN0NHplekVEM010dy81cE8ySkNvd0x2MWU1aSs4d0dZUzJvcms1?=
 =?utf-8?B?YUkrOEVsMlBweU15a3JUelAyNGw4ZHhzWEJRU2EyMEhWS1dTZTM2VlFiMGxz?=
 =?utf-8?B?WEJpVDBoQmx5MTAyK3lmbm9yQTRmRXJEWlUxdUk0MFE3UGVCdnRQaW9TdW1X?=
 =?utf-8?B?VWxQVDFkZGFjcDAzZVJidFVDUXNTamo3b290Mnc4UG4xTUxYWGlWVGx6eXVZ?=
 =?utf-8?B?YlM5cyszVko2dHlOeThoeU1sT1A1eWhqVktkK0d6UHFxRGtBNW9wdEVsdWxx?=
 =?utf-8?B?bENCOGtYN0k0dnlablJoa0MydzdpZG84VElMZzlncUMrWEFYa0FXWmhia25h?=
 =?utf-8?B?ZkllbkZEMllIckFrSWJYTVpadFJrR0lQc1pBbzAyajlDeWlVSzFjVkdGbDFN?=
 =?utf-8?B?T2VxYnRpaFpuY3RDYVI2bEs4NUFiUTNrZ3d6K2hmZk9wUndkaE9WKzdRcDQ2?=
 =?utf-8?Q?c3dUM3B2dLU43PhstiafDyix7EXSKqKO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVnS2I0UzlGaHFTYVUvL09MZm4weERDcWxKbFVUTDV4cUovTldYS0k3Q05N?=
 =?utf-8?B?N3Jya3RMRG9yRkVxay8wZVRjUUFBRnd2RTg4MzluTm1OZWNSd1lRUDIzL0xr?=
 =?utf-8?B?R2F5b0VTcXplNUtiVUM2bFVrenNjajJDUGxiUmtReS9rK3BBdDNsR3BRbkp5?=
 =?utf-8?B?Ym9rcVM0RzVia1d4QmlNTVBXcTAzaDdMa0p2WG9NL2FIUGhJM3hIWXlKSnIw?=
 =?utf-8?B?Qlk1ZHBlME15dDdpaGtWRkJhUFptQ0JnZDlYb2RKV0NvTi9xQWp4ZHF6NE9k?=
 =?utf-8?B?SklVMUZLNmZNZE1xQXVTaUNudHFheEFERENUdjNtWWdnWm5GTUJYQ1NHSS9Z?=
 =?utf-8?B?NDhibHpma2ljWTFYb1EycW9QODIzSFpOOUlOYWlzZGdxWm5PblJNYVAyUC9k?=
 =?utf-8?B?ZEdEOUFXYTdoaHVST29ISU9Hd045UG1WOFBxVVJxTlpKRUI0ZUYySjBtaG9W?=
 =?utf-8?B?VHEwc3huenJvdVI4bjNkcVkyTUpyZ1FhYnpGdVplOVE5ajRET2xDd2V4cWR3?=
 =?utf-8?B?S2FNaVd5QS9YN0lveTZVKzZiVlExSGVzSTkzTEFKWmhpVUN5RDlRRnVHQXo3?=
 =?utf-8?B?SUw5dTBUd201ditiT1ZrU1JmazZpNldLYUN1QzdRMlZ5ODg4R0FJUDRNWjgx?=
 =?utf-8?B?akZQL2lIVHpIdW1yM1VFbzJJNndXM0NqRE9hRWQvbm0rTVNISDdUTndablkz?=
 =?utf-8?B?RmRzb2xBQ2dZTDRDWDRpbU1kQU1Ed2V1TW5YeVhFR3d1UUp6VzdDZ2VLYlIz?=
 =?utf-8?B?QXpPTkIrSm5KbDI4Y21sYzJ1L0Y4UUZUcWw4YWtReDhuVnhqc0ZicE50dXNO?=
 =?utf-8?B?OEcwZFpPRG1mN0FHRHFxaW1NcWJsN2Z0L0oyQUtnUjBaRCt2OXA3VTJ4L09T?=
 =?utf-8?B?c0E4Y2p2SWhWZTB2L1RpVFJQMVg3NkJQMXA2M0t1Z3JjZitJUTlpNW00VVl3?=
 =?utf-8?B?OTQvaVBjZGtpWm1sZDN4cThJeWxtYVFSZTdzMzNMaFdHd2N0ZEE5aGZScUdr?=
 =?utf-8?B?SXFRYXpnNC90cHFZU284cnFQZ05xZ090UlQrRng2WDk4NFJZSi80ckhJUVJU?=
 =?utf-8?B?N0dwK2prUjF2THRackc4MG1PN2F0akJhNXNTYkh3SWxrZmJZOW1tMjg0OUxS?=
 =?utf-8?B?U01nbGV1VGw0TVhYYy8rU3NadWluOG4xT3dwanhWTVBIMzhMd3lrYldEcE9P?=
 =?utf-8?B?VGpnRXVIbnlVNmRsMkhXcjYwbGRqUEdDVXJRT0tCNFBKWVZWdGgwcFlBVk85?=
 =?utf-8?B?OUhvbUhnckhRdkZXZTBreXV0bG41TmVNT09MYUVhRm5OaHhBbUdNZXZVa3hG?=
 =?utf-8?B?V1NhczcyQmhjaFhlSmJXTm45RmJMd0Y1cmM2Q3RnbkI3cjhpbzdwYS9NWk95?=
 =?utf-8?B?Z2c2YVh4ZFVPa0NFcjdmS3hnQmNzZzl6NzBIekJuQmVLU2NvcWY5NER4N2JG?=
 =?utf-8?B?cUFZeUNtZWFLWElmWXVLajNqU2FzdldSbEpobGNNOXRQRXVHdFhrS1lMUkVq?=
 =?utf-8?B?RVRZRk8raFpHbWZ4ZnY5MDE1dUdPWTdNOHd2enFwTEZqdVEzdmlwaU8rV0tH?=
 =?utf-8?B?ZzhDUHg1N3NxT01SSVRHYzRiR1Z1NDVMMUcxMTdYSWZNdHhFd0tJeGRpRHNa?=
 =?utf-8?B?bjhTMHRlajJhNjI5R3NHaURoUFByQXpGWXE1ZThRdDZoVXV3endGT0xXdEtJ?=
 =?utf-8?B?UzBOT2U2V21TMWdROVFTZGtxYVp6eDZBVlBtc0pPME44eXM0dG9YOTkxYUx5?=
 =?utf-8?B?N1p5d1djcUJJcmEwWDBQR0wxUlZuUUpSQTk4QzJSL29kSytqRVg2Q0xQenVF?=
 =?utf-8?B?U3duUG5DdDUvazVuWllTeVI1N3VJVTRaMk9zVEdEOEFGKzVFWVVaOXRDOUlp?=
 =?utf-8?B?RTNVS3l5L1dJYTAzNWp2N3JoWS9lcjdaQm1mK3pEeHhrRlJFa3R0OXRyYlQv?=
 =?utf-8?B?T2FmcUZkbzJuaVdzdDNKWi9mOGR4dVkrT2FDeHZrcWtabW5idEYxTmJZSFhN?=
 =?utf-8?B?SGsrSytGRFU3cGtjeUVKdkdmYnQwWXNwWkN4UHdxYXZnL214dzBkUG1QNUZi?=
 =?utf-8?B?TkphMms3SzJmbEZWVTRMU2tPUzlObmR4SFloTldzbk9YNS9zMzdNRXpwTWpL?=
 =?utf-8?B?bjJyOWovTEdpTDVtdTZSeGQ4MVNxc2R0Vjc1Zmp4SE9RVUJPclhrRHgvcmF5?=
 =?utf-8?B?RG1QWloyUzAwTUIwMTZFLytTcGtLR2ZOakhrcW5haGNtTGF6M3QxOUlEempi?=
 =?utf-8?B?d0tibHlIenhKNzVYN1lydEQyMWtIVVNHdEtUdldvN01NSGx0ZDVKZXdzdTdh?=
 =?utf-8?B?blQ2VWcwNFF1cXNld29Eb0dDa0xXenZzR0paV1NLNVVVSDRNRUU0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf55d8c-18f5-42f5-6df0-08de4dd184b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:45:40.5020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RTOIzHt/mOqsPkAEwZQoqlfpObgjSSFVgY1h6gTFOS93vdprKTa8dnyqIgSkNd0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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

On 12/19/25 14:42, Tvrtko Ursulin wrote:
> IDR is deprecated so let's convert the context manager to xarray.
> 
> In doing so we remove the context manager mutex and switch call sites
> which required the guarantee context cannot go away while they walk the
> list of context, or otherwise operate on them, to use reference counting.
> 
> This allows us to use the built in xarray spinlock for all operations and
> just temporarily drop it when we need to call sleeping functions.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2:
>  * No need for kref_get_unless_zero when locked.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 119 ++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |   8 +-
>  3 files changed, 48 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index b69dd3061e2c..af0375bc11f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -482,34 +482,26 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	mutex_lock(&mgr->lock);
> -	*id = 1;
> -	r = idr_alloc_u32(&mgr->ctx_handles, ctx, id, UINT_MAX, GFP_KERNEL);
> -	if (r) {
> -		mutex_unlock(&mgr->lock);
> -		kfree(ctx);
> -		return r;
> -	}
> -
>  	r = amdgpu_ctx_init(mgr, priority, filp, ctx);
>  	if (r) {
> -		idr_remove(&mgr->ctx_handles, *id);
> -		*id = 0;
>  		kfree(ctx);
> +		return r;
>  	}
> -	mutex_unlock(&mgr->lock);
> +
> +	r = xa_alloc(&mgr->ctx_handles, id, ctx, xa_limit_32b, GFP_KERNEL);
> +	if (r)
> +		amdgpu_ctx_put(ctx);
> +
>  	return r;
>  }
>  
>  static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  {
> -	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>  	struct amdgpu_ctx *ctx;
>  
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_remove(&mgr->ctx_handles, id);
> +	ctx = xa_erase(&fpriv->ctx_mgr.ctx_handles, id);
>  	amdgpu_ctx_put(ctx);
> -	mutex_unlock(&mgr->lock);
> +
>  	return ctx ? 0 : -EINVAL;
>  }
>  
> @@ -518,20 +510,12 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>  			    union drm_amdgpu_ctx_out *out)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct amdgpu_ctx_mgr *mgr;
>  	unsigned reset_counter;
>  
> -	if (!fpriv)
> +	ctx = amdgpu_ctx_get(fpriv, id);
> +	if (!ctx)
>  		return -EINVAL;
>  
> -	mgr = &fpriv->ctx_mgr;
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_find(&mgr->ctx_handles, id);
> -	if (!ctx) {
> -		mutex_unlock(&mgr->lock);
> -		return -EINVAL;
> -	}
> -
>  	/* TODO: these two are always zero */
>  	out->state.flags = 0x0;
>  	out->state.hangs = 0x0;
> @@ -545,7 +529,8 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
>  		out->state.reset_status = AMDGPU_CTX_UNKNOWN_RESET;
>  	ctx->reset_counter_query = reset_counter;
>  
> -	mutex_unlock(&mgr->lock);
> +	amdgpu_ctx_put(ctx);
> +
>  	return 0;
>  }
>  
> @@ -557,19 +542,11 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  	struct amdgpu_ctx *ctx;
> -	struct amdgpu_ctx_mgr *mgr;
>  
> -	if (!fpriv)
> +	ctx = amdgpu_ctx_get(fpriv, id);
> +	if (!ctx)
>  		return -EINVAL;
>  
> -	mgr = &fpriv->ctx_mgr;
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_find(&mgr->ctx_handles, id);
> -	if (!ctx) {
> -		mutex_unlock(&mgr->lock);
> -		return -EINVAL;
> -	}
> -
>  	out->state.flags = 0x0;
>  	out->state.hangs = 0x0;
>  
> @@ -609,7 +586,8 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>  				      msecs_to_jiffies(AMDGPU_RAS_COUNTE_DELAY_MS));
>  	}
>  
> -	mutex_unlock(&mgr->lock);
> +	amdgpu_ctx_put(ctx);
> +
>  	return 0;
>  }
>  
> @@ -618,26 +596,18 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
>  				    bool set, u32 *stable_pstate)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct amdgpu_ctx_mgr *mgr;
>  	int r;
>  
> -	if (!fpriv)
> +	ctx = amdgpu_ctx_get(fpriv, id);
> +	if (!ctx)
>  		return -EINVAL;
>  
> -	mgr = &fpriv->ctx_mgr;
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_find(&mgr->ctx_handles, id);
> -	if (!ctx) {
> -		mutex_unlock(&mgr->lock);
> -		return -EINVAL;
> -	}
> -
>  	if (set)
>  		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
>  	else
>  		r = amdgpu_ctx_get_stable_pstate(ctx, stable_pstate);
>  
> -	mutex_unlock(&mgr->lock);
> +	amdgpu_ctx_put(ctx);
>  	return r;
>  }
>  
> @@ -716,11 +686,11 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>  
>  	mgr = &fpriv->ctx_mgr;
>  
> -	mutex_lock(&mgr->lock);
> -	ctx = idr_find(&mgr->ctx_handles, id);
> +	xa_lock(&mgr->ctx_handles);
> +	ctx = xa_load(&mgr->ctx_handles, id);
>  	if (ctx)
>  		kref_get(&ctx->refcount);
> -	mutex_unlock(&mgr->lock);
> +	xa_unlock(&mgr->ctx_handles);
>  	return ctx;
>  }
>  
> @@ -856,8 +826,7 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>  	unsigned int i;
>  
>  	mgr->adev = adev;
> -	mutex_init(&mgr->lock);
> -	idr_init_base(&mgr->ctx_handles, 1);
> +	xa_init_flags(&mgr->ctx_handles, XA_FLAGS_ALLOC1);
>  
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
>  		atomic64_set(&mgr->time_spend[i], 0);
> @@ -866,13 +835,13 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
>  long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct idr *idp;
> -	uint32_t id, i, j;
> +	unsigned long id;
> +	int i, j;
>  
> -	idp = &mgr->ctx_handles;
> -
> -	mutex_lock(&mgr->lock);
> -	idr_for_each_entry(idp, ctx, id) {
> +	xa_lock(&mgr->ctx_handles);
> +	xa_for_each(&mgr->ctx_handles, id, ctx) {
> +		kref_get(&ctx->refcount);
> +		xa_unlock(&mgr->ctx_handles);
>  		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>  			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>  				struct drm_sched_entity *entity;
> @@ -884,25 +853,21 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  				timeout = drm_sched_entity_flush(entity, timeout);
>  			}
>  		}
> +		amdgpu_ctx_put(ctx);
> +		xa_lock(&mgr->ctx_handles);
>  	}
> -	mutex_unlock(&mgr->lock);
> +	xa_unlock(&mgr->ctx_handles);
>  	return timeout;
>  }
>  
> -static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
> -{
> -	struct amdgpu_ctx *ctx;
> -	uint32_t id;
> -
> -	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
> -		amdgpu_ctx_put(ctx);
> -}
> -
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>  {
> -	amdgpu_ctx_mgr_entity_fini(mgr);
> -	idr_destroy(&mgr->ctx_handles);
> -	mutex_destroy(&mgr->lock);
> +	struct amdgpu_ctx *ctx;
> +	unsigned long id;
> +
> +	xa_for_each(&mgr->ctx_handles, id, ctx)
> +		amdgpu_ctx_put(ctx);
> +	xa_destroy(&mgr->ctx_handles);
>  }
>  
>  void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
> @@ -910,21 +875,21 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>  {
>  	struct amdgpu_ctx *ctx;
>  	unsigned int hw_ip, i;
> -	uint32_t id;
> +	unsigned long id;
>  
>  	/*
>  	 * This is a little bit racy because it can be that a ctx or a fence are
>  	 * destroyed just in the moment we try to account them. But that is ok
>  	 * since exactly that case is explicitely allowed by the interface.
>  	 */
> -	mutex_lock(&mgr->lock);
>  	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>  		uint64_t ns = atomic64_read(&mgr->time_spend[hw_ip]);
>  
>  		usage[hw_ip] = ns_to_ktime(ns);
>  	}
>  
> -	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
> +	xa_lock(&mgr->ctx_handles);
> +	xa_for_each(&mgr->ctx_handles, id, ctx) {
>  		for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>  			for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
>  				struct amdgpu_ctx_entity *centity;
> @@ -938,5 +903,5 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
>  			}
>  		}
>  	}
> -	mutex_unlock(&mgr->lock);
> +	xa_unlock(&mgr->ctx_handles);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index b1fa7fe74569..8427a7d18cf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -25,6 +25,7 @@
>  
>  #include <linux/ktime.h>
>  #include <linux/types.h>
> +#include <linux/xarray.h>
>  
>  #include "amdgpu_ring.h"
>  
> @@ -61,9 +62,7 @@ struct amdgpu_ctx {
>  
>  struct amdgpu_ctx_mgr {
>  	struct amdgpu_device	*adev;
> -	struct mutex		lock;
> -	/* protected by lock */
> -	struct idr		ctx_handles;
> +	struct xarray		ctx_handles;
>  	atomic64_t		time_spend[AMDGPU_HW_IP_NUM];
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index 341beec59537..471d27b2db01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -39,7 +39,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>  	struct amdgpu_fpriv *fpriv;
>  	struct amdgpu_ctx_mgr *mgr;
>  	struct amdgpu_ctx *ctx;
> -	uint32_t id;
> +	unsigned long id;
>  	int r;
>  
>  	if (fd_empty(f))
> @@ -50,10 +50,10 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>  		return r;
>  
>  	mgr = &fpriv->ctx_mgr;
> -	mutex_lock(&mgr->lock);
> -	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
> +	xa_lock(&mgr->ctx_handles);
> +	xa_for_each(&mgr->ctx_handles, id, ctx)
>  		amdgpu_ctx_priority_override(ctx, priority);
> -	mutex_unlock(&mgr->lock);
> +	xa_unlock(&mgr->ctx_handles);
>  
>  	return 0;
>  }

