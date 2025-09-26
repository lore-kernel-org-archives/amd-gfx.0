Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664BFCAC5B9
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 10:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E724C10E34F;
	Fri, 26 Sep 2025 10:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xPtT9Y0E";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17BE10E34F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 10:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmhOFy0O5gqYzyG9Wo38gwlqueW83TzvbYCwadiccmRUYeckMxS0Wf4xLAUw0CLdg4JpnNu8v6WSK6IixYCUVoPuXouKa/WM6Ze8P5f7YUGH1TdRlv2euAy0QhNj8Ml1cmJ0wUvFpQzw3BbyYYfHYN3diQ1Fpk0U6Y8n0QhbUcN3Vbi6JVtMy/5Ywqxhceb24bvDThcP9M6p0roWDSrH4uQRqJdTXhj9sGK6vc+KauNvpSDDJ5BTIKRPTlXAxInT0HRCEWXlJ+ZOa7v5IfgdWz5prWInrlDttTBmvMFkkzb+/tgx6zmcMtcv7PI0tYbgBjpL7KGIQkMw1wsDnTGU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtB1snZfttyJ9Pgcc8D2bliY6fOGiBOkMN8aL6myYa8=;
 b=uU1KKzXR3gVLBvIwHwFXza6aiEukhWTC8JeBVoOkquJYG4a1UdkExqZ54XfKitNPe4BkiDpJTl5RE+xisUsDpjNdYpIBhdqviVhzSWTC1uIzHJ1YgHsO97WkR8ZXxhlE4UBMA3saubIwcLFT5UDUGNKvvApFSZzx04OEMImeGKB5dG1lqpOXGnMA5urZ5gth0N7ImMfJoRbbroMtpF2RhjJQAuYzfBn6jVU7jzPJlsRphWVWEd9knGugmDXN2c99on5g6ouwwUXdZrKmHSILwadCTvEaAJtI5IgU/1ziu6lrkjQX1id2K7or35Z+sEq9eUe9fATwoCP8y9R5TKjj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtB1snZfttyJ9Pgcc8D2bliY6fOGiBOkMN8aL6myYa8=;
 b=xPtT9Y0E3jvohKUtZAkRQOks2S7x375SOaPyzjIYs+IEz2futdhMwhI4Me/WxSREkoKUN3cVLygszL7UJTz2fw3+0C+x75vn4OuXQ7DOLRty1OXWL9DyLefBm6vUTlaZ8oXh9RrToUDrWTJH9hdSgBJ37wGJubnaQQJXr3lQklw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 10:53:16 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 10:53:15 +0000
Message-ID: <662c2254-dcfc-46d7-b11c-51111c26f23e@amd.com>
Date: Fri, 26 Sep 2025 16:23:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250924100156.3746229-1-sunil.khatri@amd.com>
 <c5b52ba0-efe1-497e-9d35-a752a2b35267@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <c5b52ba0-efe1-497e-9d35-a752a2b35267@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0083.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fe0eb9-5e94-4781-ce6a-08ddfceae52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzc5RlNFd1gxb3ZINlVYSjBRajdwK1BKb2xNYUZJWEtsZUhOdUIzajcxSHNq?=
 =?utf-8?B?NllWWVg0VXhNanh0UGxQb1RsY0s1cng4SEg0aGFLbzk5dDRhYnNVYmhLR2gw?=
 =?utf-8?B?T25BTFM5MXpHQXpOeHAzSXVBdCtPaDBWNmU1eW5JWWFrQjljaG9IaFpuOERq?=
 =?utf-8?B?eTVQc1p2TVY1Z3BUMENva3RQblJIYWw5NW41RE5FWWppUDk2RzBUZVEra1Rm?=
 =?utf-8?B?cHZ2YXdJa2Ztd3JQdGpldlgveFpYVTVNeGlqT1czS2cydHNyNDBwMUFSTG9w?=
 =?utf-8?B?cEk1RWlSN0tybkVndnlvd3RZQ3R0VTVvbDVNVDRxcHA3b2VlVzE1TWxFYmhV?=
 =?utf-8?B?S3BrMkpZK2hUYkY1MkNVeG5FUnE0RWllcnRZSUNTNHVNdStxSjhGa014Zmw1?=
 =?utf-8?B?cU9uUVdrdlNJeHpzbmN0WHNMYlpjY3BBcm1yL1NDTmhWdnlxRnhNbVBKRyt3?=
 =?utf-8?B?WDBQUld1UnMyR09ZYVZvS0FBQURWOWhmTXdUajdHeFhFMTFJYjU3UmQzYndm?=
 =?utf-8?B?dG1PbGU2aVhIYVRudmY5VEhXVURpaTNNK1ZIS25iMWpUUDRFM1NOcVBQeFdJ?=
 =?utf-8?B?Tk5Pcm5lTHNVN1hMYVM4NjB5L0d6U2xxeDJSa3Q2WWw2RkhZVUJnWlRNczRN?=
 =?utf-8?B?RDVESGR4Wk5LdkQxUlhiWGtuelQwbGwrVkFWRG9LUVpUREk4NitueHZNK0dP?=
 =?utf-8?B?SXJLMWJkRXFmWEhIaHJJYklES0ZMTk94cnJDalBnaFFJMzhObkFHOVZkbmdJ?=
 =?utf-8?B?Z3JxakJOeTFkRXhiTWlBNDlYWmhuYkFrNEdHOFZsVS92cTlReUp4a05Vc0Nn?=
 =?utf-8?B?Rll6TWRvN3V0aGFPZFZzYWkrNnNjSnRIL21KclFkSW1CU3cxUk52Wmd3YWw3?=
 =?utf-8?B?cE9XZDBDeTIrN3cySGdBa1d3NGlDWUw2MFY5TXBlU2NqY0YzTzhDQzdPUWhF?=
 =?utf-8?B?NW1HY2hUT21vUUpJTUExWFVJemNtcE1LaERQcmw0YnVkQ1NBV0ZwakRFam5a?=
 =?utf-8?B?cXdJZWQxNXJDR0d0VFh2SUlDKy9TbmJjOXZ6SVQ1K2hqUXdYbnRLeVhHRGFu?=
 =?utf-8?B?QWhYdEd1MkcwZEx6U0liUE42TWhjR2I2N1lmUnNLOUhvRFZ0eVdrS2U5WTFV?=
 =?utf-8?B?K3JGRHhieGdiMXZMazFaM3RUa21nVXlzcXdCQzl3dHU5cW9La0U3Q012K2ZP?=
 =?utf-8?B?WXY4Y0xHRXBwMVZVSGdBQ2ovK1ZIKzhVZjRXQnVOMEdDdDdsakdZODYrYzI0?=
 =?utf-8?B?dlYvcDlDYTNaYmhDYVBZSGJKRmFFeGxBMHhxWVA3WEJ1MGRISVV6cXlYNlFI?=
 =?utf-8?B?b1Y1N2FEUkhjY2ZwTW9UZkJ0bEoyenJmMUF0YXdOcUdlcVlWQk9sQVFVQUk0?=
 =?utf-8?B?Y2htaUZHcFFRblpmd0pHNkl6V0o2OWs2QWc4VFlPL052c3hwc3FoTmZrY1Fq?=
 =?utf-8?B?dUFhNG1jeTFvdXZKU25PbTlXMXdRVlVjZHNlbTZUN2xzVHYrK2ZSckRxVW9V?=
 =?utf-8?B?a2RQUzRFVXJIbkx6Y2tnN3NNc2loKzhNSlhFaHI1eVVSY0VhNVFrUEdRT09P?=
 =?utf-8?B?Zk4wL0VoUGxkOFZveTA2WVByblhXTmhvRmJvWllWZkEyeUIyRWVyYkQzaXIx?=
 =?utf-8?B?Q3MvRlJjK3NqZGJrR00wSUFIV0Y0RnZYcHRXU1pFc2pOcFNFbDB1WVVXcVhX?=
 =?utf-8?B?V0lwb0gzdkxpMHJZQjBzMHdLODBTOHNjQVZIRFd5dEZXUlpLVW1oQWVzM1d0?=
 =?utf-8?B?aXRWdWlHODFBZGwxdVpKK0Q2VERhQU5DVUNtUnFqM2NyNGQyWGdHTUdiRXRO?=
 =?utf-8?B?dGRpalFIbEovMkpmdHlnL0thc2lwSXZra3MrZEZ5bVFGeCs5bkNmNjFnYWtk?=
 =?utf-8?B?YUJjNmdNa3VQT1VWcXA2K3BvVW9PQ0drUGFWK3N4VmJJdDBxYkRoQk5OaW9J?=
 =?utf-8?Q?k8htOLhO9r8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFrc1V2VmZxYzRrV3hXa1NFRmh3dVpkeEVNS2NXL2x3Ynl3UHRwK3ZrRDFr?=
 =?utf-8?B?NmxrODNZa3VOMmxsRWNVUVlYcDE3RlZFZFZxdjNWTUJ1ZkFlZnhXOTRZTlJp?=
 =?utf-8?B?K1FnbDM0T1NNVFVqZGdra09OT3FjMkxCU2hOd0szM0JFc2k5V2hsME9yYVdi?=
 =?utf-8?B?ZkJtTWZsSStsZFl1NnhxZExFYVVlUVBBUitYZHBDdXBYZVlsRWNIc0hUaXUz?=
 =?utf-8?B?MVJNcksraDZaL2ZNV3NVUzhhajBBZXlPWjZJODYxSUUzMkdtbS9ZbkErN1NH?=
 =?utf-8?B?RnFoSzFuOHNYV0ZZN2d5S2VEYnVXbEdWcWVySkhUNGZNdmdQQ0IwUW5kMGJs?=
 =?utf-8?B?U3hWeW50VUFkQXJUQzUxMlpjQi9ic2FwdVorZWlVeUJBWHozMUlZbG1YZFNp?=
 =?utf-8?B?dlNNbG1IYzM3WjhPaEZ5a0RzTTlua2VabjEzSnhUM0dWb2tVLzhxWStSRmlC?=
 =?utf-8?B?OHcxc2xuL1VPQWFYeE9yVG1jK0hqUG4xY1M1TEQwZmxNRHZZbGNlWFNNMkNx?=
 =?utf-8?B?YTl6OUFaNExHN1hpMjRFdTl1dGRpbmJxZitEcjM5ZmpROWtpYTFsK0xabk9y?=
 =?utf-8?B?d0lvZ0VKMkFPbVl6NjQyeWt0b0paRTBWdWxNRGYzdHcxV0ZJeWFrbEVkUk1E?=
 =?utf-8?B?bnBaOTJpZXhBNHpYTWM2RE9VUStwc201STlhOW9OZjVvajNNcEdxYmk3aEMx?=
 =?utf-8?B?amtldUJ1ZW9RQUZkZXE4dU9aeGZsME5TeXBvcnUrVzZsVlhSQmhVMHE2TlN5?=
 =?utf-8?B?QklrUk80RE8rcWFDQ2Vha25iSnhlQ0ZRNjBqazBBTEVGRENGT0xuMGJTWHps?=
 =?utf-8?B?c2VVZFFTOHduYWFWbElRamp2QXlodXpEK3lCTDNla2FoSy9CVjJhUGFLZUhN?=
 =?utf-8?B?ZXpIcGlpUVRObWlRdGFVSmFhdi9yUjlRUUdwZmZuU2U5eG44WDRUakVrdngv?=
 =?utf-8?B?Ukt0SFI3bExHRXJGbXdFRTN6TVhYSGZNTjhUd2J6N1NjSmQ0VC8yRStucTdU?=
 =?utf-8?B?b3pvOFZtVXpMZUtxZ3JBRlFaQ0M4ZlRZTWFjcVdocEk1NHZKNTFyODJiMUdq?=
 =?utf-8?B?bUZRcTlnVVpyUUx3TTRUUnBpd0NVd1VIVnNPNmpwN1FHb2tFaTI4K0JaQkY0?=
 =?utf-8?B?VnF1T2ZyTVRheEdNakVxQnozd05MOFNZUHRFYWk0UHNMM1N5SDU4ampsWEFr?=
 =?utf-8?B?ODFCYytOcjAwalBESUN6c1dmczcxLzFWWWFlalVBQVMzdTRxdjBLUVRobUlu?=
 =?utf-8?B?YjBid0cwT2MvaHBzVWhCa0FKTVpHZC9wVzdYdXFEcnM1cVJ3eDU3TnVWWjQ5?=
 =?utf-8?B?dDRPOUwyZGUxWnIxVEJjUWF1UGYyZnRrYlIyOTgxY29YSFY1NjZQbytHSUJJ?=
 =?utf-8?B?ZU5NVVJqR29OL1phQXU1akYrYlV3UVB6aDJvYnl6VzN6ZXhwbFVSeG05Witq?=
 =?utf-8?B?Mng4YzhzYVVmMU1lMWR1UXoyTHU5OTliUTVSUmNWZ3lGaHdvNmJmdDFFS3hi?=
 =?utf-8?B?UktZWUpGOEl3VXhEMWJaR3BFNUVydDRiMG9zWWZJV0lyM25hK0lueU00QWtF?=
 =?utf-8?B?ZzBhZXVOVERTRklhUXhJa1RJVmV2TXBKNVZmYkIxd3RvN3k5NEgwMnhpaVZC?=
 =?utf-8?B?VnQ0NXcvY0l6Y21pc0M3QjZSaVZ0cm1TMkNldVRWZ3pnTVlCY0xrY0NXQ2pC?=
 =?utf-8?B?RmlqOG5sUkpQejFNOW9LR3RuVmJjOTF5UkJaL2tGSXZsVEd2Q3R2MUZwckVQ?=
 =?utf-8?B?c1FxR28rTmthWUZTd25VdGhENkVXTS83TVhqc1k3MGxmcTJUY2F4RGljclV6?=
 =?utf-8?B?a3BzTFV2VkVYTmJObm5Zd3F1UTlRSVhNQzl5OGEyRGtxRkovV3VMdWVjTmhY?=
 =?utf-8?B?VnA3TXIrOU94bUpDWkRPdlRybVRFWjlvRXpSMUF3VWZJSDRPSUFYWHVUSkZB?=
 =?utf-8?B?bCtKWnI0ejl1NTBsMVFCZUsvc2ZPMmI3WC9NTjFVRkc4SFBZU0t1b0UyS2dq?=
 =?utf-8?B?K0RTWTdGV0Fqa1ZtM0JmaGtBb3UyNnBFakNXYlM5M2FCMjZpUWo4OGpWVDdu?=
 =?utf-8?B?Y01YZmJ3bnZjZVJXMzkrSVBQbUxxYS8zVmx0L1NxWWRMUzJTdWJLczdXdGRn?=
 =?utf-8?Q?vD85T3lQIHhYWewzYep5Thvxd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fe0eb9-5e94-4781-ce6a-08ddfceae52e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 10:53:15.8262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtCK7nxK9R6W2EWOFtYr4rxUVWktV1CxUI2kmizNcDBOvNPgPAItwU/RINrUwI3RO8K6H8DRN5ctvsUBQsg3IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
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


On 9/24/2025 10:27 PM, Kuehling, Felix wrote:
> On 2025-09-24 06:01, Sunil Khatri wrote:
>> update the amdgpu_ttm_tt_get_user_pages and all dependent function
>> along with it callers to use a user allocated hmm_range buffer instead
>> hmm layer allocates the buffer.
>>
>> This is a need to get hmm_range pointers easily accessible
>> without accessing the bo and that is a requirement for the
>> userqueue to lock the userptrs effectively.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>
> What's the reason for this change? In the current code, the hmm_range 
> is allocated by amdgpu_hmm_range_get_pages and freed by 
> amdgpu_hmm_range_get_pages_done. Your change is breaking that symmetry.
Sorry i missed your comment. For userqueues locking the userptr bos and 
making sure we have valid userptrs at the time of validation seems too 
complicated, so along with christian we decided to use hmm_range list 
instead and have reference to userptr bo and via hmm_range private field 
to be set to bo.

Also i did made sure that wherever we are doing get pages and allocating 
range the freeing part is taken care of. Specially for freeing the 
memory is still done by amdgpu_hmm_range_get_pages_done only. Please 
share if anywhere i missed something. Also Christian brought out the 
point to have separate alloc/free for hmm_range which i am working on 
and will share soon.

Regards
Sunil Khatri

> Regards,
>   Felix
>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  8 +++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
>>   8 files changed, 38 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 7c54fe6b0f5d..4babd37712fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem 
>> *mem, uint64_t user_addr,
>>           return 0;
>>       }
>>   -    ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
>> +    range = kzalloc(sizeof(*range), GFP_KERNEL);
>> +    if (unlikely(!range)) {
>> +        ret = -ENOMEM;
>> +        goto unregister_out;
>> +    }
>> +
>> +    ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>>       if (ret) {
>> +        kfree(range);
>>           if (ret == -EAGAIN)
>>               pr_debug("Failed to get user pages, try again\n");
>>           else
>> @@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct 
>> amdkfd_process_info *process_info,
>>               }
>>           }
>>   +        mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
>> +        if (unlikely(!mem->range))
>> +            return -ENOMEM;
>>           /* Get updated user pages */
>> -        ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
>> +        ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>>           if (ret) {
>> +            kfree(mem->range);
>> +            mem->range = NULL;
>>               pr_debug("Failed %d to get user pages\n", ret);
>>                 /* Return -EFAULT bad address error as success. It will
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 744e6ff69814..31eea1c7dac3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>       amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>           bool userpage_invalidated = false;
>>           struct amdgpu_bo *bo = e->bo;
>> +        e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
>> +        if (unlikely(!e->range))
>> +            return -ENOMEM;
>> +
>>           int i;
>>   -        r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
>> +        r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>>           if (r)
>>               goto out_free_user_pages;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 8524aa55e057..12f0597a3659 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device 
>> *dev, void *data,
>>           goto release_object;
>>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>> -        r = amdgpu_ttm_tt_get_user_pages(bo, &range);
>> -        if (r)
>> +        range = kzalloc(sizeof(*range), GFP_KERNEL);
>> +        if (unlikely(!range))
>> +            return -ENOMEM;
>> +        r = amdgpu_ttm_tt_get_user_pages(bo, range);
>> +        if (r) {
>> +            kfree(range);
>>               goto release_object;
>> -
>> +        }
>>           r = amdgpu_bo_reserve(bo, true);
>>           if (r)
>>               goto user_pages_done;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index 2c6a6b858112..53d405a92a14 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>                      uint64_t start, uint64_t npages, bool readonly,
>>                      void *owner,
>> -                   struct hmm_range **phmm_range)
>> +                   struct hmm_range *hmm_range)
>>   {
>> -    struct hmm_range *hmm_range;
>>       unsigned long end;
>>       unsigned long timeout;
>>       unsigned long *pfns;
>>       int r = 0;
>>   -    hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>> -    if (unlikely(!hmm_range))
>> -        return -ENOMEM;
>> -
>>       pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>>       if (unlikely(!pfns)) {
>>           r = -ENOMEM;
>> @@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>       hmm_range->start = start;
>>       hmm_range->hmm_pfns = pfns;
>>   -    *phmm_range = hmm_range;
>> -
>>       return 0;
>>     out_free_pfns:
>>       kvfree(pfns);
>>   out_free_range:
>> -    kfree(hmm_range);
>> -
>>       if (r == -EBUSY)
>>           r = -EAGAIN;
>>       return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>> index 953e1d06de20..c54e3c64251a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>> @@ -34,7 +34,7 @@
>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>                      uint64_t start, uint64_t npages, bool readonly,
>>                      void *owner,
>> -                   struct hmm_range **phmm_range);
>> +                   struct hmm_range *hmm_range);
>>   bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>>     #if defined(CONFIG_HMM_MIRROR)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 901e0c39a594..046ff2346dab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
>>    * memory and start HMM tracking CPU page table update
>>    *
>>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() 
>> once and only
>> - * once afterwards to stop HMM tracking
>> + * once afterwards to stop HMM tracking. Its the caller 
>> responsibility to ensure
>> + * that range is a valid memory and it is freed too.
>>    */
>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>> -                 struct hmm_range **range)
>> +                 struct hmm_range *range)
>>   {
>>       struct ttm_tt *ttm = bo->tbo.ttm;
>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>> @@ -718,9 +719,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo 
>> *bo,
>>       bool readonly;
>>       int r = 0;
>>   -    /* Make sure get_user_pages_done() can cleanup gracefully */
>> -    *range = NULL;
>> -
>>       mm = bo->notifier.mm;
>>       if (unlikely(!mm)) {
>>           DRM_DEBUG_DRIVER("BO is not registered?\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 6ac94469ed40..a8379b925878 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct 
>> amdgpu_device *adev, uint32_t type);
>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>> -                 struct hmm_range **range);
>> +                 struct hmm_range *range);
>>   void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>>                         struct hmm_range *range);
>>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>>                          struct hmm_range *range);
>>   #else
>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>> -                           struct hmm_range **range)
>> +                           struct hmm_range *range)
>>   {
>>       return -EPERM;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 273f42e3afdd..9f0f14ea93e5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1737,12 +1737,15 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>               }
>>                 WRITE_ONCE(p->svms.faulting_task, current);
>> +            hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, 
>> npages,
>>                                  readonly, owner,
>> -                               &hmm_range);
>> +                               hmm_range);
>>               WRITE_ONCE(p->svms.faulting_task, NULL);
>> -            if (r)
>> +            if (r) {
>> +                kfree(hmm_range);
>>                   pr_debug("failed %d to get svm range pages\n", r);
>> +            }
>>           } else {
>>               r = -EFAULT;
>>           }
