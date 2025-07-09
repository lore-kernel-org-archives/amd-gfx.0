Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D0AC83F03
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 18:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6624810E09B;
	Wed,  9 Jul 2025 18:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SqyxNfek";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F0C10E09B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 18:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLabP1CNCHVIRk7y6NQxwWfH3zoMYHC/n3sJIsStOU7TIGbUgjg2dw1hCFdm1V8/qEMddtoJS7XQy54934IdCXCyoCnbxnve4uJLV3XFcDBVE5Ncv6YLGuwlbW/yDqwM8GazhNbnxwsFUgHq9cFxAghce0wwdTkMtxfZNnDNQd4Jvq6RW4NBQJz0Z2l/1GCirXbBvz8UgmC9OYWJqGUXvv/Ad59lmJzMz21mKrnNCJCtUHd3pEzEK/uhUdOY3/QcSw81Ccm/UCejO4rufKk2HtpNKAzjEbrrrxGINcaWWsehlOQbzft2UcI2ix8Mqb9fYexPgPDC5JatjW8CvkXosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/PUsY+W26xZKlXGJHWytnrxgXolj6E1tTncLzHUlEQ=;
 b=fXz0f27R5uiDYMbWyQPeVAeWyyJUhXBML7KzUHzx+sv2DpYCvadJD41cYtM8vCVbafgc6WJoFuAOcCxofd0DcDdK+otpYI33GXpdPjDglVcdK4fJNtkrF0LfwUYQA9cz1Nry72nU4h0I15SEmtwo25L7HEzq1LEPTtzZQ0e+NgmQgq2ACQywa7FprpFf7oX1uuTVI+R+Tctuz3KQxQ0IDWUUQVhyS3jnE8Kpcektphhiq0UeOYTlYoPrsGaEVm7Lss7RXu+IC3GbaL+Wm0KCN3nxO9dTOQc6RpqZX5BFuAmDnnCJltMsLwe2O0OXAI/uoGWTrQPw4Q/bUz40a79mYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/PUsY+W26xZKlXGJHWytnrxgXolj6E1tTncLzHUlEQ=;
 b=SqyxNfekPj9Uwv0XWVf5YYjVVExOPomtbwsz0qn+zvKRxsOsex14zn9NPuLwamUIjVsBb4YIZwLYsHQsTHoAQWYA0mfx5qUqmUaT7YYqQmj0jW5eBNu/jsKgjwOEjAXCVbb88AAScEte5wSZScNGd9GVg1h93EzVhDvjmua/Y9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 18:52:26 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 18:52:25 +0000
Message-ID: <81a32b69-6adc-4c3f-ab5e-226ec3ee720c@amd.com>
Date: Wed, 9 Jul 2025 14:52:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Avoid extra evict-restore process.
Content-Language: en-US
To: Gang Ba <Gang.Ba@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20250708201454.1061462-1-Gang.Ba@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250708201454.1061462-1-Gang.Ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0462.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f29c70e-9311-421c-5f1a-08ddbf19be7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlBzOVdDYlcxd1FxVmkxWUNpNGtqbTRURHJSQS9kWm13RU9QcFdsTXpmbE1V?=
 =?utf-8?B?emlaK1A0ZHdBc0ZEcHlwaDNXR0UyaUJLY045bEdVUjM4T08xUlFwdThxQ1Ux?=
 =?utf-8?B?eG9sb1ZNYitDb1VoMTFtUkxOOW1zbXdCNFVwSFJ5M3k5T2xMT21udHhOeGZW?=
 =?utf-8?B?WjRMVEVvdE05ZEwxM2hWc2xuMERHWjVhNEQrMXZjRzVMeE1keXdURFYzOTRR?=
 =?utf-8?B?TkYydmF2WWZ0UnRCaUxlcXZnQjVoMXBtazFvRjRrNWFRM1NPa1BzYzNUY1RB?=
 =?utf-8?B?M2FoSWNVMWNKNW9wWWJzWHRzVjh6MDg0MW13VjlHMEIzZStnb29FU3BzNTMv?=
 =?utf-8?B?aW9BeFpIM1JMRDEzZVFHZFc5M0sya3p5MjdDdnlHbmQ4S2NsUWIvT1ZxaGtH?=
 =?utf-8?B?ampCTnI5ZERpV21hMENHMWJFTk02eXlmakM4ak5TT3dJNjcwbDVjZmRZQ3dW?=
 =?utf-8?B?SDBVQWdGNVRBNWp6MEJwRXNLejZoVVh5YnpLczZwdTBvd0o2QVdybFhERDB0?=
 =?utf-8?B?NUdnZnVMN0ZscHlrZkVCbmI2bTJlUGlheXNEOEtvNDhKcmd5YTdHNGRteG84?=
 =?utf-8?B?NXIvK0lyeHg3dkh0bkpVTy9uZTlOczVtZDJMYUNWZVdpdXc0RmhRajFJbmZ3?=
 =?utf-8?B?emdicjJ5ZXdHZXlvWHV3NlpYbzVSdHNGS1ltMlE0SFdodWFjUHM5c2NMTC9X?=
 =?utf-8?B?SWt4MmN0eEhhcGQvM0t4bStMTDNvWVh0R1owTjd2aExlcCtoRUpJTU8zdG1H?=
 =?utf-8?B?Smk4NTZVTERoNnlPQ013R2drK3dlcHBaM1pJZGpsR0RMZGFnZDhYNk1GYjNz?=
 =?utf-8?B?UWE1RUtPQXJHTkhvYkY1VGJmb0xmQmU3eGNWd1FVUXJhY3NEVmZNUE5rRUhB?=
 =?utf-8?B?VVFvalFnVlNrcGY4cnpTSnNocUViWUdmNlpndEltclBKbEgzQkxBVitaNjZZ?=
 =?utf-8?B?TzJEWFM2UlZmMDRVK1FMY0VwZWpYajFEbnJMYXp1ZmovdE9MQWdVN1lTWUhu?=
 =?utf-8?B?MG1SMnh3TGY5U0VmLzdBRWVSNUpBS3hjREEvWDF5aFYyNkVTVUdkUFJDVUEr?=
 =?utf-8?B?dnk3eDZEaElwVzM1a0ZoLzA4c1V5d05XZUlpV0pjOGlLTUdNd3VDOTkwK1ov?=
 =?utf-8?B?cUY2SVh1dUdtQzl4djVodFJhbjRQQzJnL3QyL0FWaGlxU3dRZUF3Y1lRL25Q?=
 =?utf-8?B?ZksvN0RLcjVRTkh1UUpuU2NYVGlkenVTZ0lDQjBRVGlib21udWpVT2taQ2x4?=
 =?utf-8?B?Ym1ldFNBeDd3MzZ1eVZoaGxQNnc3OTExVXh3R3dIMi9EY3NLRUZLbWhMUW91?=
 =?utf-8?B?OGp5MEFNd0M5OVZLbWhtaEdVTkIxdXROY3IrMW9JWjNCNlFUTnZYRGZSWFdm?=
 =?utf-8?B?UGFZMzNPRkVWVC8yRTM2RytmV1NxZ24xYUN1U2RiWDQ3ZGpUUHhIb1ZUSlRP?=
 =?utf-8?B?cVRqK0d3WjUxdWNvblUwNkNWZjRLekJvUnpoY3Fqcm01NEhvWEFDTi9HLzJi?=
 =?utf-8?B?QkR1T0s1SkxZY0ZYV2wyYkVHYUNXK1ZZSWxFdlZJMys2UWo0N2tEQUtPWG1Y?=
 =?utf-8?B?VVkvK0RKd2JweGZaWTJ5S3V6cU9kcEhwVUZiZklHSWJzRzczK0EvdGZzcHVt?=
 =?utf-8?B?Tk92T2FabmdXL2ZzM00wSDUzNUJSMGNHU0p3ejdQUVNvNUU5S1pzVmFGeFdj?=
 =?utf-8?B?cXJlWXBiK2prc2tSYTJrT0RqQWlwVC91SWJlc3VZaXVqQ0FMbFpsOFZKQlhv?=
 =?utf-8?B?Mk1yazhsaTZvRi9YRjhDUDZ6ODBIUVplTVV3YVpCMkFCYzlnVHNSYjBhbmtX?=
 =?utf-8?B?MndGc2hlUDE1S0tLaVhiTms3RCtTclFVdFN4aWtLUllBSTkzM0ZwbFZlamha?=
 =?utf-8?B?Z1o3dGhkMzJVL3BnRzF5aFpXbzdkYkloU0psTVB5LzQ1V3FLby9TeTJyRERx?=
 =?utf-8?Q?zgdIY7InYzQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlOM2IyeG4wcmRUVzR4TkswSGwzc3lvdmdmNmF4TmFoakhNSlI4M0gxRkJh?=
 =?utf-8?B?UHZ3VHpvVm9rVEovUDlYdlF6a3JpaVFSdUZDN3dkM3RlRGRoRW50WXR6U0Zs?=
 =?utf-8?B?ZUR0Ujl6QmY0ZDVaYzZWNEZYL1FiTXdzdFVTTndxaVFvTkJrUFRHUjF4Rkd2?=
 =?utf-8?B?SVJ3UzlFVmk0N3M3cE9jSEhXOVJ1K1VHb2ZCcW40ekVTMTdNcGpRU2diM05V?=
 =?utf-8?B?RW9JYTdlM0pFWlhtanhvWUdJOGM0aTEwbjFDSXd0Q0hncXVCRjdqRkQ4T00w?=
 =?utf-8?B?azF2WU5Mb2Noem1pc2J5Sm44bzlvT0ZCOEVpL243K2VhMk9vWVdjeEJMclFt?=
 =?utf-8?B?cjRRZVc1anEvVDhsOW9IQmNQTGIwbUZISzdjcmFadlJXTUhWZ3FYTXJtNXh6?=
 =?utf-8?B?dXBJa2sraVkvMFNtMC8zbktGMDFibWp6TlBTamlUVWhnRVBLcTk0L3BMelU0?=
 =?utf-8?B?NnpBZHNXV2lTKzdTbUxYNDV4cDNsVDJ1eUhSQzM5ZVhJUlMxTndHeFp5bmcz?=
 =?utf-8?B?dlR0YVpJcCtiZzdxbERoYU11TkJZRDltTVE4ekdWdkdyU2dJK0tRMWtKbTR5?=
 =?utf-8?B?bVp5dlB2S2h6SzBJeVVyVkxGWUFaRjNON2lTN1g1UWpTWjdzdkp0S2x5VEFU?=
 =?utf-8?B?c2hiSzJpaktSZ3hCK1BvMG5CV0x1U3NJSjZOR2dJR2pORkdHcG52YmF4bWpM?=
 =?utf-8?B?a3dJNWpUMkxyZ3o4U3pPV2NYdnFYd1hLR2NCKzRTVVRmUUR6bVhXc05iVEVp?=
 =?utf-8?B?L0c3K0liUzhiY2taeit3YU1yOE4yNHJUbURtNEpjbkRNZ2tEbSt0NzZQcVFW?=
 =?utf-8?B?eXhaMm1vbzN1Z0k1UkZLRFdTZFpOY0I0TnpuUXJMRHdPa1d0MmsyK0lGbkVE?=
 =?utf-8?B?RmhvVERUaHMybXc5UkFwdjlnUEo4Q1FkMVp2OURwWi9XZDFSdWtNbmVoRDcr?=
 =?utf-8?B?QlMwbTMzY1pmenNJeFYxTlVTVlIrdkd3SktrTEMyMTBta1V1ajhMb1dlTjlz?=
 =?utf-8?B?QThZdmVESTMxK3JsYzVhOWh0S3Bwd0x0VlgwSWdlV0JsV1M1eGMrVTh5Z0Iz?=
 =?utf-8?B?WU55TFoybE5mOThXd3FJcUxXYTJhWlMwNjRLb0JCQlB2ekNwdDJ2RUl5NXZ1?=
 =?utf-8?B?UEY3WlVLcXZlYlBoNGNaYldaZ0VKTkJabUFzVVYzSWZVOVdLMGJkenI3YTJq?=
 =?utf-8?B?ckxJRi82YlNWcjNja052eURxRTRicUdmdithK0YzRENTa3VrKytIQ0ZOcndH?=
 =?utf-8?B?QmFXZkVwSkI1RXBaNkxaM0dkekNETFg0Mys3bk8vZjBleGVqMlNFMWxZeDhR?=
 =?utf-8?B?VlBrem9sOThIb1RpcEdFMVJNckRCdWgwTXZYMmMyS3hLaWpQa0NRY3lGSmFT?=
 =?utf-8?B?OGdHTERDL1lWRFU4dnhzWUdQZ3RzRzB6MHJmazBBdGRYOWY4SDgwVHMvN25q?=
 =?utf-8?B?RENoVnhzK0lRV0x0SEhiZkFod1R5eDlnenZlVDUrRUFvZ1pTcEx2anhLK20w?=
 =?utf-8?B?QTl3NFdEWm12RWZsZitIZisxZFU1N014L3Z2SktoV3hyUWM3QlFVSG1Xc1pk?=
 =?utf-8?B?cGZiTlhicWxCbXpBUWk2MDJzME40ZkpKYXc3Qmxwa3lXMEsrL3p0ZFBEWldR?=
 =?utf-8?B?L21tTmYxTDYvZEdjd1FzTk5uNHNzUTFZZlloMGl4N2krZ00ralJQQ0h2VDlU?=
 =?utf-8?B?dkc2UFlKUjQ4c1RXRUR4b0ZxY2Z3WHR5bC9JY090WGV5R2VkUnc5dVUrY21k?=
 =?utf-8?B?LzVnNHdpKzh2eDBhTmtJN2dSVnk4YThiWDFEOW1yYzRodDVaM2Y1MVVXTFZ1?=
 =?utf-8?B?dWJOVSt5WUxnaFg4S25OUDV4OFY0RkYxYzh2N2JlOXBIMXhNUUg1UVIzTEk0?=
 =?utf-8?B?YTk4b3lrUzRyN2pYOW1FZ00zYXgvL2FEcyt0TDdiaktGRU94eHZBVmZFTGQ1?=
 =?utf-8?B?SlMxWnRjZzZKSGZrKzl5Zk9CcFhmblQwd0VXdVZLRzFCVkpFOFNqZUNKWUN1?=
 =?utf-8?B?b0hLQitzNmtSMTZ5Yk5vaGEyQ2dLeG1WWXU2Vzh5V1pwQTNKUmdiTlluU3p2?=
 =?utf-8?B?bW5OUGVRNDRZemZtb2NrZnhWT20wMGpIbUE3MFVxRTdmTDYrNGZDUTVEb0w0?=
 =?utf-8?Q?hf4I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f29c70e-9311-421c-5f1a-08ddbf19be7f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 18:52:25.7625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9stduWaJU1C3OtMBuy6ExIgE/6Z37aM7NBm0wP47Hcm10KsbpDmoQiJ3Q/02zHc/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
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


On 2025-07-08 16:14, Gang Ba wrote:
> If vm belongs to another process, this is fclose after fork,
> wait may enable signaling KFD eviction fence and cause parent process queue evicted.
>
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f042372d9f2e..8ee1b7e62dee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2410,6 +2410,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>    */
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>   {
> +	/* If vm belongs to another process, this is fclose after fork,
> +	 * wait may enable signaling KFD eviction fence and cause parent process queue evicted.
> +	 */
> +	if (vm->task_info->tgid &&
> +	    vm->task_info->tgid != current->group_leader->pid)
> +	      return 0;
> +

Only check this for KFD vm, in case this may cause gfx test regression.

     if (vm->is_compute_context && vm->task_info->tgid != 
current->group_leader->pid)

           return 0;


Regards,

Philip

>   	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
>   					DMA_RESV_USAGE_BOOKKEEP,
>   					true, timeout);
