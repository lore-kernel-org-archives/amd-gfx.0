Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43496CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 12:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C316C10E039;
	Fri, 22 Aug 2025 12:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rFV9SkVq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F1810E039
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 12:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSI2H3yWRMTFS6lLdb9l4RZt4UWm9kdF7AIO+UwHH15Opz0bDA/24Pug1l2bcE0ZdDIg3fL5YbW99w34acaN/vzf0YZsFw3UMe1bGPf0SRXoFTYAHuo2NdtWQq8UlG5XXz0tisaTY7zkMmt/6e+JM/oHO3i25wALJhMkzgF1sfUPwsQE3R6M5dZXmE4wlfvsxcOri7zp+C7JJdNNw6D7G8vlye7jTSYWke5sqV9OPz6kI6JTjO3EBZmRsRC9da+/rEQ5P9R7C6vjOqTDf9cQ3cvQ7y8icYtjIEnhiM89tns9uTuWVUK/JM5/ZB7q2erd304LHPtCNnMD6u9fuUbfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDH5M1WTPqunhoJZAGIsEn/tk8pTDQHuBhnmcph26qE=;
 b=eEoB5YpIKSI8Mj9Jezn29/dIGZcy6MeqZAxx8DGfH0DBNEgx/VfF6arDeBA8EUdrf/o+0Bu/ZOa+WhQBugnq9e8RN8morMdSrRB+Y65s0GHWFrSUX6Qebdp4C3UWJ3kvUe6u9rM5WGHaMluW2mLPAaCdneHa1WQdLUD1guz16UFiP1jtEFsqavSB9BZi2wGuFn5Fo06NS9rkrTzfmFflREk64ZhbChtHQhoegm9SvJjxjmu7pf3dJfImZXDERfV9tkb940GvfCFufG4I5mGv54QjEANIqO31UdJJo8IFEfofmJ2MefWgYonwJ1X/pevUgM88tqcLLMX1kjRiAw5m9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDH5M1WTPqunhoJZAGIsEn/tk8pTDQHuBhnmcph26qE=;
 b=rFV9SkVqg6nycYXd5WESnQshNrTKfCXfqW2AUzd1eaE/cnVTGNheZ0s/9lbVXWAYWj5YCBZ9hDDnqp/IOXG8WCMGlTYexGrEXuIhheg8jHhgU1x6Z8I9HJvdCEGiLadihm6sneNh1+NvwI3mXfzx+EQFzYJzh8KHx+faIrCBKao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 12:35:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:35:36 +0000
Message-ID: <9d952068-72ec-4832-8e05-7b5508d48157@amd.com>
Date: Fri, 22 Aug 2025 14:35:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/4] drm/amdgpu: Allow more flags to be set on gem
 create.
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250813184953.3666821-1-David.Francis@amd.com>
 <20250813184953.3666821-2-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250813184953.3666821-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0060.namprd20.prod.outlook.com
 (2603:10b6:208:235::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 87885d12-1cbb-4d6a-c871-08dde17864ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFdZWmlOVWtOUkw4VmJiZzA5RHhKTTZSVW9JeEhwWGtjWmpBUmFCclZ6NmpC?=
 =?utf-8?B?cTI0b0MvbldTZzJqbkRURWVCaWM5QmM4MUVNTkJkMXhQc1ZFQWQ3L0VDU1o5?=
 =?utf-8?B?QlVoRXpWNWs3cmlVZzNjQzhlK28xZlVEZTU0bi9uemovTVVGU0MxUExwbkVq?=
 =?utf-8?B?QktsU2xmV21VeTFXaVd0Uy9vVzQ5QTFlWEdGSmhBblg2a3BiUnB0RjNQZVVk?=
 =?utf-8?B?aVdMN2FQWTRpYk8yYTN3NXBzMCtEZmcwSW9hSk9uZmhQaTF2TmNNcHVSRk92?=
 =?utf-8?B?ZzlMQmlvM1dBdnFCR0daWHVPZDlBeWY5TG9oS1RnZWlPa3NYN1pOTHFFOUF5?=
 =?utf-8?B?bWJ5Yk5SaHd0TjRhbjZKdUdJdVdlK2lrRTNaMnVBV0xJRHJveElUb2xORW1N?=
 =?utf-8?B?YXdyMUtFd2ZDRVFZbjlnRVRQbXhLV0RuaWpCV2lQc3JheVhHS1phOUxuQW1P?=
 =?utf-8?B?N0NlWkN4bW54YklLWSthQVptcmRGM3k0dWovTGtnWS9kbUUzM3ZIWW91aG5J?=
 =?utf-8?B?RlVHTHphMkcxd3Z3M25JTjVKUVl6dmorbFJXQ3lBWUJMdFF3OWFPa2liamhH?=
 =?utf-8?B?bUordnFvTnB4Y3FmTU1aSjZOVS9iZGkzdkJwVEd0RFcxSnd2dGc3VUh2Q0lP?=
 =?utf-8?B?Y2krbXY0WmpFWkFwRlVUaTFDdTVOZmZTSmd0RjFZZTlyTmVtUlZOaDRHakJr?=
 =?utf-8?B?VHFJS3M1UU56MWFjNHk1Q3N4MGtwWGNZdGI2UU5KUk56a0c2T2VnSzdqYlB1?=
 =?utf-8?B?ajAzV3phcTNNUkhQQXlDWEltbVVTdFJOYzNFSlNqajJhbUl1MVROTy9XRFVX?=
 =?utf-8?B?NXMrZlEzNjIzZ0VlaTlvRjkwaEZ3QXRoMkVaOVdaaE5PNnQyemRIOWxsN0h6?=
 =?utf-8?B?Ui9SSVdTeHE2TzIwOXhhcWJBMEVrbWRQaTBrVmlxbmg5b2VFdUNpbmNWNldN?=
 =?utf-8?B?SFZtdGhWS3NMdkpma3pvblp4Ri9rcTc1WVVYOFhxS3ZrNHRiWXZpSEZzYjRB?=
 =?utf-8?B?azBmZVlMcDJKN3U5a1RWMHpkeEMxNExVY0RtUU9Na0ZNY3MzQzB2TUYxRWNp?=
 =?utf-8?B?TG1paUFGbDdVZFpIQnpxOUsxVS83UjhJNENzdTBxeXhzUVFFR2dZT0pKVk5r?=
 =?utf-8?B?ZXllSGprTGxkMGl1RlQzN1VYNzJNN2dwNkd0b3JnbDRNQzQrNnRSRnVPR1hx?=
 =?utf-8?B?ZEg0UG5aK1c2OFBFM29xRXRacXd2aExHQW52UUZPc2hMbC9NRHUrY2tnUGdF?=
 =?utf-8?B?bTJoQis2U2FiYS9vTXV4T1NlTXZuSFRUbjFZNTM4TGp0Q2ErKys0SVRLcFF5?=
 =?utf-8?B?ZU1OQ2RpeHE5Tll4ZmdGaXlzOWpqaGRab1BKOHZIdElKTmllT3ExQzdSV3d3?=
 =?utf-8?B?U2dJMEs5Rk0xUklqRGUyNFV2d3B3RUh1L050cDBkeXU3Y0pNUU9sYmNOUmQx?=
 =?utf-8?B?di9NdmVqN1AwY2RtWUVUVkNwQy9GOG5YNFlXeU5pMzNhWnFKcFZPYVBNTTRr?=
 =?utf-8?B?TUdEdTMycGt1dnRwc3BGVlU0dHRLL1NqTzNJSzN5VjY3ZXNEWjc3NW5MNWNC?=
 =?utf-8?B?R3daTW9tV296S1MzQjBDRk5paWxFakNCRXBGTHNKcEd1QXdiRERjdDRCTVMx?=
 =?utf-8?B?QXFaRGh5WXI4MEN5WW9jTXVLajBsMi9FSEErdnZ6cWVweGg2NlJOMmtPdGxQ?=
 =?utf-8?B?ZXZQTEczWHhvN0RmMkpabHRHcG9SWklZNFBMRndyNkhLb3hIeUx6azFWQUp3?=
 =?utf-8?B?eUxQZG9QL25XQXpYNWNWcmcrL1BEWEh3MTdBME1qN3NjREFGdU0rUjhoWXAx?=
 =?utf-8?B?U2c5QlkrbGQrT0dxRmlTVmZmMVUvY1ltQXlKTkxrQ0RHNDZQa3N2dlFlYldV?=
 =?utf-8?B?YUdIMzBBTVJkMm9FTmJmS0FXNUpaZlVJUGRUMEEyU0dQYytJOUI0NFRLYnVz?=
 =?utf-8?Q?ixm6+ipGeNM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZoSzRWYkZudDBDaGZjajFOS1hHT0NaajNXemJRbnFFMFlKVlJwK2MrajF0?=
 =?utf-8?B?MUJtelZvZVRhUnl6anRYMXh1dDhrVGJ1TmJ0Q01zV1JqVUd1a21SeXR6NEZr?=
 =?utf-8?B?dXZFclE4bFphbXc5SVJocVVpK0ZOQTh4SEFYeWVpQTBpUXhDMkFXdDFObXdi?=
 =?utf-8?B?aHc3Q2FhTFN6YW5Oc0I2WlYyUGNzOXdzeGQvN1BFbk9Cby9oYzU2TGZpcmtH?=
 =?utf-8?B?Z3IvV2RnbEpGaU5JUDRGOHIwSmltbW5hUC9KdzZSUzhHL2FWd043eXJFY2p2?=
 =?utf-8?B?WGY3WFVSUDZnUTlEamZtU2ZFUy9EcXJKdzZpbnJMRUZGOVpBSkNKMWVpbkRs?=
 =?utf-8?B?dDNoVXlZRXZzSkRPdHVScmZ1UlBZTFU2YVg4Vk8zTlcvMW9LSDFIOWNDY0FC?=
 =?utf-8?B?dTFJSkNxZmJUZm41QSs0YThIRFd3OEkyNlFDQ3RFYVFOUVQwaDF6YzZyM21I?=
 =?utf-8?B?NDFsTmZWNHFRWnFRa0YyU283cjMxaFFaQzVHaktDRzlBbTJQTkFGMWpVYjcr?=
 =?utf-8?B?N0dvSmlHeGZMUC93aTZ5YXRCRDNKWUczdFZlOHJQSmh4OFpURWhlQUVOZlhT?=
 =?utf-8?B?WldIbFh0M25SbFVQdEpTdWt5WlV2ckJOd1NNUDFldkZGY3Ird2pnTmVSblc4?=
 =?utf-8?B?b1RocVZJRnJ6aVVxSmgvbjB0R0xZVVVNZmhJa05GaHBvK3JwUDNoVmVlcmMr?=
 =?utf-8?B?bmJUSnNsdUJiQUNvaWN0TmErVHpSOXdvUDdXWDdQNlBtVmsrb2RmdlM4M3lw?=
 =?utf-8?B?eEJoNnIvV2UyTXNSSUJPV3liSFppN3FhSklMVkJ5WEpOVWRUanN1NEFkZTJt?=
 =?utf-8?B?ZmYxMm1wbDByS2c5aW9qQnA3Y2l2SE1qQnVFSmc5OWhGUTczYTR4aXNITElI?=
 =?utf-8?B?SSsrdG9iZHRzb29OaXhaWXVFRktjS3RUUXY3dGkxMEFOQzdmSXdLZ29CT1Ra?=
 =?utf-8?B?VWgvNDd3QVZ6RW10OEZKRnY5b0toQnJEc2pTamxzcDdZN0pnNExDWFk5SHZW?=
 =?utf-8?B?TWE3M2NZRFg2N3BiL2RSWVo0Rk9kUGtNUmVPTXprVjAzWnA5RHA3ZGFnZVc0?=
 =?utf-8?B?dGlYdUNzWWlaU2FEUEJtcUdjdjNMMXhWcWdicTR0VVVremhGdVMwZWYzUVps?=
 =?utf-8?B?dzcwalhzSVVMUHh4UWRqbHBaMEcveXljTmxUL2FIbTVvbGhvMVpLQTk2UkE3?=
 =?utf-8?B?OUt6VHRrWGZhZEpCVlRyS3h0NFp5SlNWTFFDZTVoT09HQjZQcng3UzIvak10?=
 =?utf-8?B?SnZ1c3piZEJsU0FwWDVEaGVuRFo1cEtMLzl5eTlKOXR1Q2cweFNaSkRYdkZ0?=
 =?utf-8?B?NnFPN252VlBodWtVc3EyL1pEdEhPNS8wMmNOUzBvVzRqY0JIS3UxSVNiWG91?=
 =?utf-8?B?S1UyQmVjM05teHAxc3hUZk9JUGt1eS9nYnQxNEtuN2FUQ2xtQ2JHeHBCNkV5?=
 =?utf-8?B?c042VkdCczJkL1UyWmlhYjlUTDZYVjVPVSsvQU02Wm5saWMxcTh0YW5VSVZE?=
 =?utf-8?B?VWlyQzY5NzQrRTRBOVB2YzlhUzhOT2ZqN1ZFeWZxM2NWcU1jYzNiNkc0Ri9Z?=
 =?utf-8?B?M1JVdDA2T0VCbWY5Q2ZYQVovcDgvSWRoYUpxdmNJN0M3SElMUTFVRzg4LzRC?=
 =?utf-8?B?SHNPTEUwckFSVDBZWk0zMEx5WjJuV0hHT1dYeHJta3NOQktCM1o1QzZKazVi?=
 =?utf-8?B?b2l0UnZOYzRmUHJzVmE4ZGJqd21wUHhFc0ZOQUFmQ0dpN2x2b2lxZkFibFBU?=
 =?utf-8?B?YnlpUE5RQWN3QkZYRlZMbFZqV05obGt5NkhVU2J4ZmRGSXdkMjhJU0txay9z?=
 =?utf-8?B?bk8va3phUCtQeVNhVjRrK3dXUjJjdnQ3dGR0WkF1R0ZCVTRUQXU4RFJGUWdW?=
 =?utf-8?B?RENuWFdyQzVrRnFRS280Y2t0YTJURm5wUFpIMEt2WHo4bTlrTHBLNXBSUjQ2?=
 =?utf-8?B?Z0Q1a2daeTVNRndneWxWQTdGYkJQMUlhTkJqbTJydG92cENUa1lvdEhaajhC?=
 =?utf-8?B?VkdtTVBOVlUyWFNEMENESzhjT0o0alVBRmxmcWs3VTcwbllRWkNpbDVCZlRS?=
 =?utf-8?B?N3Rza0pyMk9WNUpMTEt3SE5qNTVQSGVJbUx0MUh0MXpjTFh2dEtxZFRGRW9x?=
 =?utf-8?Q?EqckqH04jmY9BOuhLI9VAEJg0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87885d12-1cbb-4d6a-c871-08dde17864ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:35:36.4459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXl/Qc+y4LB8p1J6qEWyuZZNV1UpCrfJE+mCGGfjqY0r894hDkXwF3Po+XkGBSA1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
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

On 13.08.25 20:49, David Francis wrote:
> AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE is a flag that
> specifies that gem memory contains sensitive information and
> should be cleared to prevent snooping.
> 
> The COHERENT and UNCACHED gem create flags enable memory
> features related to sharing memory across devices.
> 
> These should be settable in GEM_CREATE_IOCTL but weren't.
> 
> Make a new define AMDGPU_GEM_CREATE_SETTABLE_MASK to
> track which gem flags can be used with gem create, and add
> these flags to it.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>


Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 +---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e3f65977eeee..aefae3a9e6f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -442,15 +442,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	int r;
>  
>  	/* reject invalid gem flags */
> -	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
> -		      AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> -		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
> -		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
> -		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> -		      AMDGPU_GEM_CREATE_ENCRYPTED |
> -		      AMDGPU_GEM_CREATE_GFX12_DCC |
> -		      AMDGPU_GEM_CREATE_DISCARDABLE))
> +	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
>  		return -EINVAL;
>  
>  	/* reject invalid gem domains */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b51e8f95ee86..b3047d73fe07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -71,4 +71,18 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
>  
> +#define AMDGPU_GEM_CREATE_SETTABLE_MASK	(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED | \
> +	AMDGPU_GEM_CREATE_NO_CPU_ACCESS | \
> +	AMDGPU_GEM_CREATE_CPU_GTT_USWC | \
> +	AMDGPU_GEM_CREATE_VRAM_CLEARED | \
> +	AMDGPU_GEM_CREATE_VM_ALWAYS_VALID | \
> +	AMDGPU_GEM_CREATE_EXPLICIT_SYNC | \
> +	AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE | \
> +	AMDGPU_GEM_CREATE_ENCRYPTED | \
> +	AMDGPU_GEM_CREATE_GFX12_DCC | \
> +	AMDGPU_GEM_CREATE_DISCARDABLE | \
> +	AMDGPU_GEM_CREATE_COHERENT | \
> +	AMDGPU_GEM_CREATE_UNCACHED | \
> +	AMDGPU_GEM_CREATE_EXT_COHERENT)
> +
>  #endif

