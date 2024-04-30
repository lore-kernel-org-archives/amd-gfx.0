Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A81C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 10:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11FF10E9BB;
	Tue, 30 Apr 2024 10:56:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nyKIaZCE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E52F10E9AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 10:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/eziNNpYwYX3lp/jJ5z4P2aVwiBHMYAfdpanxNZ+iidOZozbWU73BG05hKwzJjiHWrUrsLUK5AUCgqUx9neY/bhdFZB55dGo36rsU4ZhbsfIex2xNanSMZGV1mk3lCR1Kllv4d+RX/ZhfQGS0an0dmZBG/djD01WP9q0iLSNeK3btXSzd8/AzU1sM65+7xeVhzCeKqWLOFFCbntJLSdTq/R+HJO6SZB2mvW/sRDsF1QWAa6sj3Hk9CboBMWFd2e/T1VI1UmPcnQIgO1P0EfiBhImjfqU7S+30EQD12dFSbiZzNylZbMB9RzmTxkA0+OTC2KYY4t3f/orM8lDhqNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H29w992uVhHXcAKEAg6WIpczXFq7X0mMFVpa5t+RyY=;
 b=RChsaw3xX8JX3szw2xA53E+DYm+qyar1BHklZ+858FGIn+NGugKuX+O0Zck6XKyxEjDTzIkbliT/ckO9WvqeK+LUMbyIPgo4Z4hJ3xmfBCIYHmGwBn2ZT662dTu8yLMvhgDq6HybZxUGv6uGuKNVi7PpyMV5u6OZtKxYW6v3/AfHjuwLvwjPWLvsVxhFD2HjGua55+zPmZSPJF/Du3uZnbeIwT7mtR/necqmvbQbTsBzQlos2AONm7vWWbDzlCnirZP03lmAdfUuXoXEvI+GuWxcDILKHb/avdXHNcohtlygM0AxNqyp2lG4wR6c1vRFdf6O9jPxK4iPT/PrUhi8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H29w992uVhHXcAKEAg6WIpczXFq7X0mMFVpa5t+RyY=;
 b=nyKIaZCEW8i7t1J+2/eQl4Qk9HVLoZGiaTG3ivzkygEJkKWjnLYvHsrHm0hxkjEPsYXDH2sFMGtAhhT3a+JDEW+aeGXWHQu5kZBpjMRDMsKJnH1cFJaOc/mvgzTr+HMm0lSfcq+qgauKtVte5zEjOaauQN4hEc7Z3H3LZw1dIEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 10:56:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 10:56:00 +0000
Message-ID: <30e4ffd7-7d59-4db0-a0a1-f70c7d436d36@amd.com>
Date: Tue, 30 Apr 2024 12:55:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/14] drm/amdgpu: add new IOCTL for usermode queue
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-4-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240426134810.1250-4-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4413eb-032b-4c34-38fd-08dc69041f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1lRdUNFLzU4b0Jxb1lBejdNSGFQcENYV09Rak5mWXc2YVIxLy9Sb1cxSkR1?=
 =?utf-8?B?bUZMZ3R2T3IrSkNZY1Q1SWlLOW4yb1ZUMEhhYUtnL3lPYjUrYkNPMTcwUkhJ?=
 =?utf-8?B?WU9ZMS9FaFdSUjZNT3o5alhMWWdjQmg3Y1kwempiVlA0ZXoyRFIvS2FkOVM5?=
 =?utf-8?B?ZHhmYWltcW1tYWtqSmJiQnJnMHA3OE9GODl5b25PSUt2UWE0dzMyZXRKL3VS?=
 =?utf-8?B?blBXVWZkVFpUb0kwWUVCTHVIc21zdWU2TEd5K0o4dWRSYXJLZUhZRktNTzZE?=
 =?utf-8?B?ZFoyM0toSkVid2hLUlBmLzJ0K1J4Tm5XZlFxU2VEaDNwUGZrYi8zc2kwODdH?=
 =?utf-8?B?eU5EK1pxK3JtRUdBbzNUT1Zsd1RTYW5tOUFOQU5sV2J1bkRmaS9CWDg2MC9w?=
 =?utf-8?B?NUd2OGEvY0N6ejBScHNBZnhXOFc0QllRNVQyNkI4MFpzd2ZWZDZLNld0a09j?=
 =?utf-8?B?azNTSVJTRVhRRDBVTXhyeTJVM1Y2L1ZGckx4SGtqM1ZpQm1YWVBVdzVmTDV6?=
 =?utf-8?B?VTJvNWN3MnJZTmp6Wm5OYitOVURJMWhPK2hhMnAzT1VhM1BQTnBzcFFKMjN4?=
 =?utf-8?B?MWhaa1plWDF5R05sZjJyeFNlRTZMYmdCbElTWEZVanpSREIreU14U0dtQTBO?=
 =?utf-8?B?MnQ1WERJenU0MHVsRXd3ODB2TENpN29aVmY2YlZwa2lDajhsT09NckZCS0FJ?=
 =?utf-8?B?RUwyWE9xS0ZKdWlxN3paYmVOMEljVTA4NndGWjRielE3QWNLMDlVbkE2VG9G?=
 =?utf-8?B?M2s5cEs5dEpXRERpOU4zdEViNkFOajdmcjZjYnY4VGh6a0tsNTlPVEpDUGw0?=
 =?utf-8?B?dW5MSy9RTEN4S2R5ZXFMOXhrZHFUVGZsNG9PK2xGWmlmOVBwcS9GNE9BK3hG?=
 =?utf-8?B?eTl2eU8yUmVvWlJWcDU2TGFLMFpudWFKNkk1bVI1azdoeFVVMkQyMDNuTk5N?=
 =?utf-8?B?ZTRXOTJGdWZ2enFpcVowYUpCa0RVZVJ6emxzVVpKNzBuejF1OGVWOWptRmZQ?=
 =?utf-8?B?NTh2bElubzJXQVhVSnlERTVKaUlwb1BTdTRqMDExWGZRSXAwR3NsWU9vK29P?=
 =?utf-8?B?TnY5RlVzeXNBV0hPdmJ3V0lPNm5uNDlUcTk0YUZYenZZOFQvb24rb1MzK2Ju?=
 =?utf-8?B?bFFKVkNWam85MWdrTGM1S3BvQ3p6U2FiVXVOaGFoTHJid2h0T04vQ0xwZ2tw?=
 =?utf-8?B?eUNpbWoxOURUWFVZcGxvREVFQW45SHZWN0YrY3p0cStPTGdhdjBWTGtET2tR?=
 =?utf-8?B?MnhtNGQyakhsU0l0UHo2SmtKSUZSVnR1clNxTUk4VGdKYTRLUTN6NjNvOGhQ?=
 =?utf-8?B?czhQTGs5bkJjc0s2azdwMS9Ta2k1QUY2UjVYVGhGUEVJdWhiVWovaGMxNFlX?=
 =?utf-8?B?MU5nS01BUkZ0d2I4UnpmRjV3THpoZ0xtdVJzK09aQlZQR3JxL0tqYjVvVFd0?=
 =?utf-8?B?eU1JckI2Y1dhQThGTGlnQUIrUVJ4Z2J0Ny9nK3AzNWR2d0NHNkVTY0FOQ1BN?=
 =?utf-8?B?ZXBFbXhabWpycCtqeFR2bnFZakNySzB3VGltMFg5eFRRVnhJSzBzRUo0Nno1?=
 =?utf-8?B?eWtrMC9IeXpZTGZhaHlHbEQzemRoclRlcGpFaUxwL3RVQnFTd2VmVk5DOW5o?=
 =?utf-8?B?Qk9kbFpYSTRJK08wVVJnRHp4U3JYTFFTZ29tcW5saUYxc0sxbVQwZFV0WjFs?=
 =?utf-8?B?amdQS2o2MEk2YlIxOFRnOC9LR3o3TE5UVDI5V040U20yYkRQTFZKSnFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmE3VVFWUXIyTDVKc2xVYlNaZ1hGRGc3RC9oTzlQcUwrblJBcDBndllta2lD?=
 =?utf-8?B?V2IrbkU5VU1hTkkzZmxHUVNCVmsxQ2pxRkdNMUlZVUYza0pjcENKNG1OOVdz?=
 =?utf-8?B?UVdYdDZRM0Z3eEE3VzgvWU5TaldmbHpCY2JIUC9kS2F0YlAwOElHcy81VzlR?=
 =?utf-8?B?VFNCU1JGRy9RTkM4MFZ0aVBJYmxmd2dJUHpjTy8xWDBTVEQ2Z2h5by93dGpC?=
 =?utf-8?B?dlVTa0FocFo1WERPWGszVFp3ODlwSFBhU2ZETHFMZTNLb3ZXM1dWQm9SM0tD?=
 =?utf-8?B?SktTR2ZoQ1pHUTdVVG1odncxS1ZNYVFuQlJwcnFhSGJkTG5nUWt6QjlWTjJZ?=
 =?utf-8?B?VGcwWFJMaDhMdUw3S3Z2eXdwYUFpS0dCdVNBZEh1MU0xSlYxMWhlYmRZNktn?=
 =?utf-8?B?Mno3TGxCeWNrWXJKVExWeXBacktxbXREemp0akpWQ2N5b0lvQW5FWW8zbE5h?=
 =?utf-8?B?U05iL1dVOU5URkkzSnZmVXc5eEo5bjVxNzNJTllVa0w4YVhoK2FwOXh1OFBk?=
 =?utf-8?B?L2phaWVURXR1SmFJU2dOSFczamxVb04rdUUwOEdQRlVSelFoRXVWWHZHdDB5?=
 =?utf-8?B?bWpKT1RQZnRReVhOcmZmd0pwSk55RCtCOE8zQ0ttQS9oRkhvZTF0VFIvZG5v?=
 =?utf-8?B?RzlQbmVoSG1uTkJNeTFpWFlqc2NxV3lVenNaWFFHRC83ZXowRFdoaUFDM0t3?=
 =?utf-8?B?OW5zeDlod2xMSExRMkdSV3pxSWtveTczSG9rTW9HaGt0VG8zdHRVdTE4ZGNY?=
 =?utf-8?B?dEpPbi9wNSthZGEzblNZZlJRVGQrUUozTUtoVk1uQVlpSVF0SmtacmxGVzdz?=
 =?utf-8?B?QVB5VER4Q2R3OUlTTWpTSEFvMlRSOW51alZUSlYxOVg4WGREN0dwQnhWZU04?=
 =?utf-8?B?QytEejgvcVA0YjRoTHBOelFKYnUvV1V4bGJSa3BETDJOcjI0SEx3dDlVRk01?=
 =?utf-8?B?ZWFXS2ZqVEpzb1ppNHNZL083MERpUDRFalhtN3lQMFhFdWl0RjIxTUh0dG1z?=
 =?utf-8?B?a28zRG5HaFFITXlUMEhEdGc3OCthd0pPOGNLbUp3UUFZZENvYk5tQ2FsSUEy?=
 =?utf-8?B?S3lXR1hIQ0ZMUU5PbnFMZHlyMUVBcWpwL2U5clhnSUs4WUNPT0dQWUw0aVF6?=
 =?utf-8?B?WVhIdUpsS0t3RHdHaEloYlBkMmYxYnR3YWJBNU1LMWs2dVZlRmE2SFVZMVZx?=
 =?utf-8?B?OTZLYTB3MTFpdnJvdHJYL2MvV1lmWHc5QlZMV1pSZ2hjNm5BQzlLNmJhYng4?=
 =?utf-8?B?N3Z4SGZBcXJ3L011NzVjRmZ5SW52a1FSb2EyZHNpUnFVSk9Vbk9NKzd6a0pq?=
 =?utf-8?B?eXRDVTc5VHVBZU9EZUl3eGhMYmd2OThIai9hczdpejA1NW93NDlmZDlkdmw1?=
 =?utf-8?B?SGc3QmVRa2FIU0o4YzE0djZZaWNTbGJ2UVRVbUxqanoyZERzZVpwQVpTamZq?=
 =?utf-8?B?N1Npd29hWnB0cGQrZEI3b25jYStQRjRsWUw4Snp3M3MyR0tMeW9oRFNoOUpy?=
 =?utf-8?B?WkI3ejJJM3ZBMjhmNEpwcittVVM0NmVsdTQ3K3NjSG5UMzllb0ZkVGF0WkVL?=
 =?utf-8?B?WlRKMzRLKzVnUXRRNS9OR3hOMnZuSDJ5OXVxVFE1OFQwbmhQdThJbHQzVi9w?=
 =?utf-8?B?NndKRzdncW9nOGc5Q2F4ZnpYS1Foczg3TGgyL0lETlpQWUhNUklTOUtrbVNV?=
 =?utf-8?B?UGdRMlQ4djlWOVVKMXdsZmNZNHV6bU5BeHpjV2E1Kzh6SFl0aStzOE1IL2h3?=
 =?utf-8?B?Y1R5cXh2MU5MYjhIZEVlMzZ4dUtoei9XYXN4TGV1OTV5ZDdab3N2ZW1TTit5?=
 =?utf-8?B?WXEyK1Vod3FVd2NLZFpxRCtCUlBDV1QyRFI4dk9Wc0x4a1BhVWVxZzdrSnhu?=
 =?utf-8?B?cnlaWTRGRlBFV0tuN2ZzVS9MZlNPRkFGNFBJanUrVmJZaTlCWklmZ1ozcmpR?=
 =?utf-8?B?Ym9RandvTVFZTGdxZFU3VWZpK296MjBaVDJGcXRneWh1dnlZYzdWWjdpZ1gv?=
 =?utf-8?B?Tm5pOFMrT1JPOVlla1JYd05qQnhyMjBmUk5KTmlVOGk5eFhJUUVQTVNEaXpk?=
 =?utf-8?B?bzVFUnZLc3Q1OG5wTlZGcll2QTcyZCtnUEdWYnM2emw2NUJmb3cvc3VScEtD?=
 =?utf-8?Q?uS3CIxpkifCkNjl7nD3jRYq2i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4413eb-032b-4c34-38fd-08dc69041f3b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 10:56:00.7353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEaYVWK7iaLvGfkrX5bA5e42G8yUCS2Vd8FZRN/gQZqN5D1N1149/Kj7NIZsRFnK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749
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

Am 26.04.24 um 15:47 schrieb Shashank Sharma:
> This patch adds:
> - A new IOCTL function to create and destroy
> - A new structure to keep all the user queue data in one place.
> - A function to generate unique index for the queue.
>
> V1: Worked on review comments from RFC patch series:
>    - Alex: Keep a list of queues, instead of single queue per process.
>    - Christian: Use the queue manager instead of global ptrs,
>             Don't keep the queue structure in amdgpu_ctx
>
> V2: Worked on review comments:
>   - Christian:
>     - Formatting of text
>     - There is no need for queuing of userqueues, with idr in place
>   - Alex:
>     - Remove use_doorbell, its unnecessary
>     - Reuse amdgpu_mqd_props for saving mqd fields
>
>   - Code formatting and re-arrangement
>
> V3:
>   - Integration with doorbell manager
>
> V4:
>   - Accommodate MQD union related changes in UAPI (Alex)
>   - Do not set the queue size twice (Bas)
>
> V5:
>   - Remove wrapper functions for queue indexing (Christian)
>   - Do not save the queue id/idr in queue itself (Christian)
>   - Move the idr allocation in the IP independent generic space
>    (Christian)
>
> V6:
>   - Check the validity of input IP type (Christian)
>
> V7:
>   - Move uq_func from uq_mgr to adev (Alex)
>   - Add missing free(queue) for error cases (Yifan)
>
> V9:
>   - Rebase
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 121 ++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>   3 files changed, 124 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 374970984a61..acee1c279abb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2916,6 +2916,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index effc0c7c02cf..df97b856f891 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -23,6 +23,127 @@
>    */
>   
>   #include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_userqueue.h"
> +
> +static struct amdgpu_usermode_queue *
> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +{
> +	return idr_find(&uq_mgr->userq_idr, qid);
> +}
> +
> +static int
> +amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *uq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +
> +	queue = amdgpu_userqueue_find(uq_mgr, queue_id);
> +	if (!queue) {
> +		DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return -EINVAL;
> +	}
> +
> +	uq_funcs = adev->userq_funcs[queue->queue_type];
> +	uq_funcs->mqd_destroy(uq_mgr, queue);
> +	idr_remove(&uq_mgr->userq_idr, queue_id);
> +	kfree(queue);
> +
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return 0;
> +}
> +
> +static int
> +amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *uq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	int qid, r = 0;
> +
> +	/* Usermode queues are only supported for GFX/SDMA engines as of now */
> +	if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
> +		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&uq_mgr->userq_mutex);
> +
> +	uq_funcs = adev->userq_funcs[args->in.ip_type];
> +	if (!uq_funcs) {
> +		DRM_ERROR("Usermode queue is not supported for this IP (%u)\n", args->in.ip_type);
> +		r = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +	if (!queue) {
> +		DRM_ERROR("Failed to allocate memory for queue\n");
> +		r = -ENOMEM;
> +		goto unlock;
> +	}
> +	queue->doorbell_handle = args->in.doorbell_handle;
> +	queue->doorbell_index = args->in.doorbell_offset;
> +	queue->queue_type = args->in.ip_type;
> +	queue->flags = args->in.flags;
> +	queue->vm = &fpriv->vm;
> +
> +	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
> +	if (r) {
> +		DRM_ERROR("Failed to create Queue\n");
> +		kfree(queue);
> +		goto unlock;
> +	}
> +
> +	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
> +	if (qid < 0) {
> +		DRM_ERROR("Failed to allocate a queue id\n");
> +		uq_funcs->mqd_destroy(uq_mgr, queue);
> +		kfree(queue);
> +		r = -ENOMEM;
> +		goto unlock;
> +	}
> +	args->out.queue_id = qid;
> +
> +unlock:
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +	return r;
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +		       struct drm_file *filp)
> +{
> +	union drm_amdgpu_userq *args = data;
> +	int r = 0;

Don't initialize local variables if it isn't necessary.

We now have automated checkers complaining about that. If some older 
compiler complains then rather change the code below to have a goto 
error or something like that.

> +
> +	switch (args->in.op) {
> +	case AMDGPU_USERQ_OP_CREATE:
> +		r = amdgpu_userqueue_create(filp, args);
> +		if (r)
> +			DRM_ERROR("Failed to create usermode queue\n");
> +		break;
> +
> +	case AMDGPU_USERQ_OP_FREE:
> +		r = amdgpu_userqueue_destroy(filp, args->in.queue_id);
> +		if (r)
> +			DRM_ERROR("Failed to destroy usermode queue\n");
> +		break;
> +
> +	default:
> +		DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);

That could spam the logs if we ever decide to extend the IOCTL, rather 
make the message debug severity.

With those two handled the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Regards,
Christian.

> +		return -EINVAL;
> +	}
> +
> +	return r;
> +}
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 93ebe4b61682..b739274c72e1 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -54,6 +54,8 @@ struct amdgpu_userq_mgr {
>   	struct amdgpu_device		*adev;
>   };
>   
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>   
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);

