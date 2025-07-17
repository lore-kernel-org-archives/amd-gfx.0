Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1004C83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 07:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E19210E73C;
	Thu, 17 Jul 2025 07:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yp9/RnxM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED2E10E73C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 07:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TinO3jvQ0V2ZC1MeDs1Qpaj4Oe+uZOXm8qKEeDfujmRCpWyck3wr9P2P48S1PTcxuy6E6rijqkE3JiSTE0nsV1Li4orRFryo11eL2aeEnnbovRLDxGpFuyirZIiMAmx6ysDLW+BOeaU3IGSSm6PY0PAys9P/Ef1AtW452a2ip/Sofd/0KLexRRu7K6gWqMMKXGnbKBDj8078ElCw3776ze3RjIl+fGLkHf3wjEzxFGMMJTJxNmRTVm5i3V1p8QxKc9L5DEeypbHolyYZ62ojFYAuQ6bstJ07lL9xXhX7ladN78VtEvOMZNcgVcOt11ldojEw7a+2eKX6wfU6J9wE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRahupRP9YtQWi6m+LOc8tL4sQWa36nignbxRhOWtBw=;
 b=DMO2jSMjlnu2Ud1zINdHp4eIbTfIfYSSvCYhYELvm/k+mXs+yf+y19a5ASp09/6wW+vBZj6vd8u8UgLVr9OKbN0tWVcDtTbr14EWOzH+oXfT+197aSYM6W0IhmwJ5BN0cjBbgUKV33dPrMT7idB4amz45fGFY1oa3qYjM9lG7L1AK617ogd8b68o6h8szJoNT3m6buHYE/RanMl7T5xf51obmAidO4bB2uTjswch8yGK02qvrsnyHMLNgo85aYTnOZH0AtX4U1vX00UZJ30dqWDB8eZFbA7e8O58E+ZKiiLY+L7pIeElyMIE9G1rvkuSEpygXuy9QAquRTyV12u8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRahupRP9YtQWi6m+LOc8tL4sQWa36nignbxRhOWtBw=;
 b=yp9/RnxM5QgfLf7rFNifvh/t1jByoKPbkDngdOW+YrO3U20gt8k+k2+M8rrizTJg+n97Rbo0fL8BqSqZ2oDQD2atweCA44tCpRpr0LJoaoTxfMhcx9NjYg/lge+2W0TgTdnkSzymHr3CEjGM+ZJF8pz0ovG4zeLLieNAAPLIubo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 17 Jul
 2025 07:41:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 07:41:34 +0000
Message-ID: <d7ee5795-3e6e-489b-b540-15ad4b369216@amd.com>
Date: Thu, 17 Jul 2025 09:41:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Avoid extra evict-restore process.
To: Gang Ba <Gang.Ba@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20250716175753.703955-1-Gang.Ba@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250716175753.703955-1-Gang.Ba@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6508e8a3-3c6f-4216-d63c-08ddc5055a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlYxR1FML3JuNDFtTEo1N2hFWHMrNkZNYUt4ejV5VUd5b1FGV3cyNWpETVA4?=
 =?utf-8?B?RlYxSURFbVB3VGVDUlk2Tk5MSmFRUXBlczBqSEpFZTZtSU1hUzk1aFdMb3RG?=
 =?utf-8?B?UDRra1hoa3dRUjlPRDBaVXRoSmRtQWZvY0F1UFJad2RQa01vYnFQeDJzbE1J?=
 =?utf-8?B?bk1ISUxQS1ZjKzR2b3duZ3NPMGpPaXFBMHRDelN3SFpxaTJ3YjhPQlFNMXds?=
 =?utf-8?B?RW0xVUFzcXI2YksrUUxmU0xIb1plL1NxbVcyVjF1UUhXeGtlblVuSmpOMnNa?=
 =?utf-8?B?ZVNsMk5OTTlndGh5RWdvSGt6cEIvMVdPTHFmTXpITi9zbGtNVmN6Nm9mbVV2?=
 =?utf-8?B?ZE5JcFRLZEhWRGJET3VNVWFRckIya0VVRWlCOEJjZkdSSWc0Nk02a1haOGg2?=
 =?utf-8?B?aWdDOFBDZXI0V0doY1Fxc2Z4ZEhXOHptWXRxUWVNZis3RkxmT0xEM3V5Q0Zt?=
 =?utf-8?B?bnZrR0tLUnRUTStHWTRvQjdnQmtLbXRmMU9LczVLR3VBTEFpVWVuY2ErQlI3?=
 =?utf-8?B?RGt2OUptM0Uxa08xNi9tSzlxRWI2UjU4eFZCZHM1QmQraVIwdzJaaXk1b3Uw?=
 =?utf-8?B?em9TckNpSVhnVjVqYTlOQnVZUmJ3ekdpN2p0MHcxSnRkazQvNUx4d1JzVnlM?=
 =?utf-8?B?SG1rRlRQcHNCL2RqNmZuM25mc1ZqdVdxbGU4OWpvZVhCMHU2MG5QeExIL1JQ?=
 =?utf-8?B?R2Ivempvc2ZjSmVlemdDTDBWaXV6YkcveC9jQVZ2dUI3dlZ4aTFBTktkTTUw?=
 =?utf-8?B?U0p1b0o2NDEvdlhJQ1hIR0wzeGkwYmNkTTM4SnB1RGpieWVaS3p5L2tOL2Fz?=
 =?utf-8?B?aWYrUTJaWFR2ODNJNk5ZYUM3aGFWZUg3SUVSV2ZUWXVYUHdFMVgrUEwrUEpv?=
 =?utf-8?B?STdVVXBRVVZYdkdLb0oxMGREbWxWQzRKUkxTUE5zeWdFblRpbW1JQ3pZMm1Y?=
 =?utf-8?B?TU56aFVKeWpTSEZZVUU4L21SVmpHM083cVZROTh3ekZxaEFuRnNnWmlYbXB5?=
 =?utf-8?B?anpDK2NnSjJvcW1idnJUTUVtOGRoQ05MTmtyVXd0cTM4Y3FzRERPRWhVNzZ4?=
 =?utf-8?B?aENkY25aaFZMU1RXaXFGRFZlQnUyNmNJV3hSODlITUhpM3RnbVB1K1BENUhv?=
 =?utf-8?B?VXhWeDBrdWdZTFprU1hZTUNyM2wvUTZldm9Ea0NuUm0vUFBielZseFl4ZnRE?=
 =?utf-8?B?RHRkWVozRytsdlRnYUZRdnBKdGlXL09vNzBiUkxIeUg1MlM5MmFvQWkxd3cy?=
 =?utf-8?B?K2F4bGZQSC9aK1dxTFpqZUVXTlJnVnVmYUF1Y1hMQkdVZ0xVbHhnL01NZ2t1?=
 =?utf-8?B?K2VncmF2NTdEd211NS9OZDFjOEVIV1BwYndKMUtIeXRMalNLS3ZrQXVzYmdz?=
 =?utf-8?B?a2FkaGhrblN3dWlYOURIRFN5OXNLUGZRUDFCV1diNmtyN1orSlVIWk1ac0NM?=
 =?utf-8?B?R2Q4cFQxRjBieWI2UjlwWmNRazNxMm1yQmNwdmtodGR1VmdDc3BYVnVRczRu?=
 =?utf-8?B?WVI3K054UGduMjY0NUVPZFJQam5qQnFpZGVkQVZJVzdDNmxXSkl6dzVnWnFv?=
 =?utf-8?B?NGtsUktvREdrN01XSjF5dUJDOFBKY0ZMWFZUWDA3VHc4Y1BJU04yYmEzSDJr?=
 =?utf-8?B?RVR2dnZUdmp3UE9wOVJWKy93UjUwcDlHaW40OWV5Rjc0TVdDcGZvenBDWGtN?=
 =?utf-8?B?SVlLSGgrc2hiMVZlY014cFRwajg3S2NxN2FJdnZ6NWt4eVEvVU9FY291SUUx?=
 =?utf-8?B?RVgxbXhzWEo1ZXRLZ3p6Wms1VlB0YnVXeXYyUHJvVHdqOUo2MFZYQ2l6SUN5?=
 =?utf-8?B?a0RTYnZSRTZFUXFrTnVRMy9kM2hCTStaQnBCM0JVVGV6czlVMUxqam1aek9D?=
 =?utf-8?B?WjFjQXpDaElnK0lidmNWR0JKQ1NKcVBVN2hYRm4wb0lCSURtK0dqemVQZmlP?=
 =?utf-8?Q?DieSosooLrU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEMrTmJzZjdNQXlLZGlhUkd4WnlTY3lSUklPNUk2T3BpWW9IdGs3Wm5xamUz?=
 =?utf-8?B?aG9acVd6T2s3SFNEdXA5emZxRHVGM2toSURKQ2k4NVpWbmh3VEZNSmlmZ3JX?=
 =?utf-8?B?cFdqQU91T05kSW1OcUNsd0tEd0tXcldMVnZtSi82VGp2dzRHTzJIRWtYZGx6?=
 =?utf-8?B?VWJjQ2R5aElZN3ZEZEdhMGJGM01iK2NpaXJHYXliL1MrYXB2dDdzZmJhNDZi?=
 =?utf-8?B?MnFvelBwWUM1a2N2ZEZ6WmVNYzQvaDk3M1JFdmdlUkhrdXhtaFFJOGxzV0to?=
 =?utf-8?B?Y0ZXdGt4L1VHc1RhQU5QdG5XQnB6ZlVzM2dQK2NUb2d2dGdrSGs5elk2Zml6?=
 =?utf-8?B?Q3ZTZWxBcGNnTXRJUlVUditCL0NxSUFLRk1EVlhVZVNWQVdFUysvZ3B5SWRK?=
 =?utf-8?B?OGFRSTd2KzV1eFZ5L243Vmg4aTVNbEZyelZrOFE4L1pPT2IvWXZmUSszWnIw?=
 =?utf-8?B?TTBuU0JTNFhPTUhxTXBhaHNzWlJOREFhajJ2T2VOaHh5NkI0VUJBMVhYTTlW?=
 =?utf-8?B?bWxDc2kwRWp6ZjJwaVJRekN2WmJrVjc3SUtPQTFqai9iVVp0bE5LMWZQbUF5?=
 =?utf-8?B?Tk9WNGY2OGhIS0R5VVhUOEVKYnVzTlVZcy9aQURoODFld0h2aC9rckZsUm5Y?=
 =?utf-8?B?bS9yb3plRi9BMFVNWEdqOFdZV0RmUmFkbjByZUxpTXhHZC92N29Yc3NwNHBs?=
 =?utf-8?B?VTlhdWFaVms0Y2lDclZNcHNYMGxXVjdDbS9uMjVmWXhteEdpdnRVRkNWcVV3?=
 =?utf-8?B?VEMwZitOOGVZQkl4Y1FFT0V6U25FUHR6ZzNlWVI0cDBLUGZhamhod2FHSGcz?=
 =?utf-8?B?NWxFbzZTWkEvYmJXeWFuczh3VUE3S1NzWDQ4eWk1dE5rS2preko5T3loUEIv?=
 =?utf-8?B?ckZkS3h4T2Rob2JSSGpzZ25qYVlwTFhWSWY1V093MCswcU5VSzRiTlVvaHpw?=
 =?utf-8?B?aWVxWW5zdVVmVDBBdUh6blg4N2QrWlppOHJTU3hlc1h6bnVwcXdHRC9aL1o5?=
 =?utf-8?B?Y2tRaFdZaTdCWGhWaFZxOTBkcE4rNEhYdDcyV2FCV3ltTWx2WFFGNVBNOEh5?=
 =?utf-8?B?b3hHVXZ6eVhRbEhaa0xuYkUyeFFRY3VEdFJhWjlCUitaeXBzazA5TjVVVlcr?=
 =?utf-8?B?U3F2Yi81STJLejhjMHBFTTk3WGt2K3dBKzZUTmIxQUJJMUQ3LzM1RlBLOTBL?=
 =?utf-8?B?WnI0UnZHZHd1N3JNN2ZZVXBONWQ4MHZzd3QvUm1kWVdaR1pYN2tSUGpkdy96?=
 =?utf-8?B?eENab2lVNDh0ejhpcWJZdzVEU0JZY1l5QjZXVDdOSXFNeUN5ZlFJZVZlTEFX?=
 =?utf-8?B?UUJYQUpxU2NLRzIzQ3FUOWdqMzBMbU1MdE1yNUtxVk1JOVZqZXpwYkVzejg5?=
 =?utf-8?B?QUwwd2JHeTVvRHBWSkljazZRSmVDek5rS0ZKdUdjelRjb3FkYjROckRScEpY?=
 =?utf-8?B?d2orT0RhRkt0cnZINUp2eHFFbHZZbzZnSmZpelF1d0htb2FYODB5aFVieCtT?=
 =?utf-8?B?cFdWd3F4a0hLZjBrT0FsNEhVR1lWQVV1b250UFpMYVJvbHk0STZzLzV2OFpN?=
 =?utf-8?B?bTJTUjhGeXpERVJ0UHpyNDdFUExkN05HREJGalAwaDZPbEFLVDNTM1FtcEox?=
 =?utf-8?B?dmh3Y0l1WjQ1bG5aQWlKS3o2TzkyTXloSURZVU82SnZ0emp1NEo3ek9ZTmZC?=
 =?utf-8?B?RHh3Y1BnRU55MDdCd2V4YTlDTjR5QVNWR0xrTjFCUlMzazZyNjhkdEpxazRY?=
 =?utf-8?B?NldkdDRYNUc3ME1HMDl3UjE2eTBDYmZuWDZtLzNDa25ZTWF0M0VyYzQxUEhF?=
 =?utf-8?B?Qi91RkxsM1pSa0JaUExyU1ZFQkh2Z200Q1B3RlhxOUF6dmJpSlJYZlJnUVhK?=
 =?utf-8?B?UmNVTjBGamkwY2tWKzZabCtubU8raVVFYjhvSkpXU1hScHdidWhsUFJYTnlk?=
 =?utf-8?B?bVlaZXYzTkN3TG9QT0c1bnBxZ0RDeHFqazdjS3NHY0JnOG9ISlhrQnQ4aElz?=
 =?utf-8?B?L3RTMUh4ek90MHVIOFdsRU1OREFIaytkYVY4aStkcXFmVmlvRzZwM3NscnNV?=
 =?utf-8?B?b3FQcXE3WFNZVTkrN2JSdzFKdUUxT3I2WjRZbnE0dW54TzVLNmszSVRKR2pT?=
 =?utf-8?Q?E67fVM8rNDTsSH9EKiohDIzIN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6508e8a3-3c6f-4216-d63c-08ddc5055a3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 07:41:33.8982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ONw0IGI1Nge0rlr2hhYqFliuOiGgt6gCKQPxGfEDJVT2vrR6l04zHqVL+INCjsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

On 16.07.25 19:57, Gang Ba wrote:
> If vm belongs to another process, this is fclose after fork,
> wait may enable signaling KFD eviction fence and cause parent process queue evicted.
> 
> [677852.634569]  amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
> [677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
> [677852.634820]  dma_fence_wait_timeout+0x3a/0x140
> [677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
> [677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
> [677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
> [677852.635208]  filp_flush+0x38/0x90
> [677852.635213]  filp_close+0x14/0x30
> [677852.635216]  do_close_on_exec+0xdd/0x130
> [677852.635221]  begin_new_exec+0x1da/0x490
> [677852.635225]  load_elf_binary+0x307/0xea0
> [677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
> [677852.635235]  ? ima_bprm_check+0xa2/0xd0
> [677852.635240]  search_binary_handler+0xda/0x260
> [677852.635245]  exec_binprm+0x58/0x1a0
> [677852.635249]  bprm_execve.part.0+0x16f/0x210
> [677852.635254]  bprm_execve+0x45/0x80
> [677852.635257]  do_execveat_common.isra.0+0x190/0x200
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ea9b0f050f79..2f75f967f95f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2414,13 +2414,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   */
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>  {
> -	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
> -					DMA_RESV_USAGE_BOOKKEEP,
> -					true, timeout);
> +	guard(mutex)(&vm->eviction_lock);

I've suggested this code, but thinking more about it we don't need the guard here.

drm_sched_entity_flush() should be capable of doing multiple flushes in parallel or otherwise we will run into problems anyway.

Regards,
Christian.

> +
> +	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
>  	if (timeout <= 0)
>  		return timeout;
>  
> -	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
> +	return drm_sched_entity_flush(&vm->delayed, timeout);
>  }
>  
>  static void amdgpu_vm_destroy_task_info(struct kref *kref)

