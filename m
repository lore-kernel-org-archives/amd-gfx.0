Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AE606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 23:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HwgYT7b/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B7A10F8D0;
	Tue,  3 Nov 2026 23:21:41 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DDE610F939
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 23:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGWV4OnwWDKNzPSIC9i6VlNvBJeWSHPkcCj6DjOeBDqecqvOBX/cM7+LFX3VRiJjsiUyeSZn6wmt/Y9uNIOGr/eXAtXMEtjHCRJb11rlhoi3+QFxg/jnEJaAt65IVKQj+OKJRnfSuoOIgVgjhszrGOnHVRkf5Ay+X9gZMK933cYOo+t+bW84U+2ALexhpjbQK6L8/68ClQzOcTcL/5Z1aRFiSTXg524XzcGlEQZRYej71VdEM/9rnD/IVQm5K88URpoEb1weIPrk8NmmYWTriGScpG/r6k9WNuToNYE2sCIv3IXUtmmhy+FOlxoOymtm70syj75EGhTf57M/E6tAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g6555PoiAw7o5TAulWXZza1qprlgZh4nbonljtrMTs=;
 b=t35wrpS+8x/s7PQxsMjr5+E0aH/i6aOIILt2hRXmMg0oCUFBUt086NjpYJuCHtzWrmohTsCfmmUj1/IAPXh/ojEgd3y/sSkKt/t2uzemWSlzow1owjzMUbIzmg2KdvyOuK44XGJfpRZd/jTL1heEW3vN2GIqkCSiyqrWSM2J2T+bboHy/eANA0kBuFYBJsI8IWlzbH9H3qV10cic5be2FtioEbJPjoyfRPdDYrxJI8SwBpT/FDB7FW2hTSTGPVhkRh9qsZ1D3EXynFL3cV4FoJVdH1UYnS/LQoX8aJzkYlz4gQmtYC+T8dvxjjilQmY2yGVBr/gCL+wxgMH7CzAPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g6555PoiAw7o5TAulWXZza1qprlgZh4nbonljtrMTs=;
 b=HwgYT7b/xVHMUOFkcgRJs/jpYQNy0eTC7AO2mEcJ2GBwABfh91cOVVovWqunmCF74kGAR0LxqGLJmjuIa60cdkF/9oMPKCusRA8EgaY1euaf9IHV66KUDNucm4ADYZbU31hYpdERDVCv3+kN2ssWbR+IuSgXKCPENE8J0pV2aew=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LY0PR12MB943461.namprd12.prod.outlook.com
 (2603:10b6:404:231::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 23:21:25 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 23:21:25 +0000
Message-ID: <d5466d39-244b-4c93-b3dc-cc679fb3300b@amd.com>
Date: Tue, 3 Nov 2026 18:21:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/8] drm/amdgpu: Emulate exporter->importer UALink
 messages in loopback
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-4-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261102160125.2743750-4-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LY0PR12MB943461:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c45c92-3dd7-42a4-c87c-08df3a012de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|10067099003|18002099003|261102123227099003|261009223027099003|261021123027099003|4143699003|261021121427099003|261026121527099003|11063799006|261028144727099003|56012099006|261022105027099003|261102130727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: wlP71vHUQW6nGgBkAA9Pefx7BedcoKja30r5ma6R2W6haT51eIeyjQEpcjFmPPq8azeQpjJ05QV+TDNvp47EkIjBjnhX2IPmXjzJh6V4KfCKd6Wt/A38bP3ZkSmiQ7e6gy8+S30zZeEyxFL5OTUKeIWQeqJ2kVEyCs4bRPDw35ivcar9SmG8+xWG2ZY6czH46zioOL8CMrKCELv4nhtN+8EaElc4jExFyfhKdiBAykiXMGDxa6geVqLobUWAos2orUm+AWqAVllGftb5t8rFLVtXf5XOxC7PZK25GlHAOmrXVZ642I/yHOdh9u38DkoB64LUdZufvHaAAA/MSjv/mrYyqXD16YQ8h3NhEsvUjvISLvS/QlpkG0+4AY4ltLPwt5mklqmovTJaBoD8rj+S4F2SJU808cofADbQaHuypgEgrhB/JJx3tiPcVuxduYuHxnm7cDrJr2L95MEHg5pWoBvUaqzwRN+thgfHBpPUkzp+L4t4gGqrnYxLaKgA1Q3KO6h/uBT30fTVwydTfcHmtA7dJXJN+vKftrWz7IxsNAXvwdl97MU6GIPhq082uOXYKyvFc2GynSzXuOO2ASMHFf1IbZPCQ+7F4ErHCMVvsHnZmntUCoUIX6Qd+PAsbfF6G6y1w8Lbivgw3lVOtqE/GAf8TTtw4r+ZSlq/8WOWACI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(10067099003)(18002099003)(261102123227099003)(261009223027099003)(261021123027099003)(4143699003)(261021121427099003)(261026121527099003)(11063799006)(261028144727099003)(56012099006)(261022105027099003)(261102130727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGhzOTA2QTlDRDhNNys2SzBGUXhGSmdFVFhTNFo2aWpZdlkzWFBpYWM2QW5H?=
 =?utf-8?B?TlFLeFVRRzBZd0VEU3VKUnFkYlZmcDU3dkhYNWlnQjdUcjVrTUhMbnhZZG1Y?=
 =?utf-8?B?ZVphM1hHckt1RWJkeXAybHJvWlJzM3M2dHVueXp0U3pYNGJTNFpsdnZUYytp?=
 =?utf-8?B?b2tySzZJcm9hZjRoeFNwOHkyNjQyZzRXWW0xQVpIK1NUVHFQQlMxSE9LcjhF?=
 =?utf-8?B?dDgyTVdJc3k4SURoQ2d2Rmh3M3BWRGZnQ0V1WjRSQytZUDZNMmlWc0lMUFk3?=
 =?utf-8?B?ZEVzL3NHamtqaUoxZEJrb0JETEFHWFc2RDBpU1BNb010T3RQOWtpcEp0eE9y?=
 =?utf-8?B?L0NRWGVjc3JIYlhJUlBvQzJLek84SDRCdnR1dUx6dDZ3emxlV2J0ZW5XVHNw?=
 =?utf-8?B?ZmJ2RmI1TUZSZmo3c0lBdjJSWStuSU53TllSVTYwaXlBSUN4SCtURGJUa2Ru?=
 =?utf-8?B?anlYcjlqVzBRWDlTY3R1SGhVeUxtYlpIN0Z5alRodE1MeFMwNzBjL3l5ZVcv?=
 =?utf-8?B?T0FoOTBmYVQzbHUvaWQxSXdNNmdvWWc5MFhlQVhjZ0JiRVVvNkR6TFF3RUFE?=
 =?utf-8?B?azVVeGM4NlRMa2EwYVVDcWhIRDBGQ0tFa3ZuamhxMzVGQ1RwRkEyREhIZGQ3?=
 =?utf-8?B?dUV3RUZ3TFhXUkJNTkJ0VCtsRng4emIvbHpNQTdDaWFoWk5vTVZ3SmdTaHVH?=
 =?utf-8?B?TWFxNG5VQlFIYTBvY2prMHhoZERmU21mRFljQ0tkWTRBZzFERWpDU0ZhNjFV?=
 =?utf-8?B?THBPMmJOdzlQUHNNYmZLcFV6dkhsTnUyMmNmMkpBTTZDamdkMndicy9HU0VN?=
 =?utf-8?B?ekg1L2V0cTlHL2dvd2h5bkZHeU9IbEtBRlBuS2ljaG9CejBpSi9kR1FxVUJS?=
 =?utf-8?B?eXEyOE5ZUlk1VEdoV2hJZ0RaWVhWSU03cy9LZVdJZ2tVTWMvTG00RzRMTXhG?=
 =?utf-8?B?emlFcHJVeGk2ZVlEUTd4MTVjdTZzeGRyazF5R3oyVkNheHozcEwvTzBWZ3Iv?=
 =?utf-8?B?dm5pN2wxVVY4Uk5kZVc2U3ZHUjhITFFPWGVlWEltMGI2dVFMVE1NZDJ3eUs1?=
 =?utf-8?B?enNTVjNGY0drVWl3TVdpbE9YVTV1eERGWS90S0QwdmI3WlY2bkdGOUlWaVlL?=
 =?utf-8?B?a09HS3drMHFrV29XRU95ZUhKM0NyZ1R6ckFqekZHOEVzTGJtY1NSSXhVTTRt?=
 =?utf-8?B?WlE3RzJGaGlYWjdvb2JzMDVnNEFpakJqZXBrSDZHRURYYlNIUlA5Wmg2ZVJj?=
 =?utf-8?B?QXQ5bno2SFd1dGlac1VrUytMNFk0bDkweXA1b01QV1dsSGxFd3N3SXBmRWJs?=
 =?utf-8?B?UW1IckZWWHBZYUZBNStCQlFrUGxKdDlIck1QaStxYXBMVitqTmVGNVd5V0FW?=
 =?utf-8?B?RkJTS1ZscGxCcHBOcm9Nck4zeURISXYyOVovdmVpek9IaE5GM2ZCMDZaY3oz?=
 =?utf-8?B?cmRiQ3ZRRm0vRURUYjFtbDhpN293WFdnRXBYLzA2TTRZeDh0UERBVmx0S0NF?=
 =?utf-8?B?bzY2WXI4Ky83Ni93OTh4Z0ZNeUorUkF5RTQzdjBsVEM4R0lTSVYzd2RFZ2hW?=
 =?utf-8?B?MWQyb0RSWFhYU2RnV0dnWWFHa2txd3hibFB3bXZDSkJudXlvQ3FrM0VZUDk2?=
 =?utf-8?B?eEhrUG5EVEZqZHZXUDlETHlkbWZNNmVWQnU5QnBqcld0bmM2d3lOZDdJVHpO?=
 =?utf-8?B?ajdjWUFUaWo2L2hMSG5qWTVXTlBDYXRsZzBZNFFiK3E0bC8wMzZEN3kzVUs3?=
 =?utf-8?B?enZCejNxZXRLU2JLcVVDNFFzZkt2cVdBR0hHM2w1K09TSXdCYUVGWjJWSHJB?=
 =?utf-8?B?V1FraXYxcmFZK2NVZEppNzVVVlVDMHp3czZaMXBlR1JyVU9VTnN0NHF2elBs?=
 =?utf-8?B?eG5JTENtakVWVmhvc051bml6bXhlRGp4ZkNCYnRMT2REYjd3SGdHWXliNUdj?=
 =?utf-8?B?akRKeTdJSEF2TGZ2eE5kcHV1MnhQSWp3QnJXU3dhWUZEVlVXQjJlUkdyRTY0?=
 =?utf-8?B?bEpOb3d2ZVR3S29PcDVlWGczT2J0OWgyRTFHeDlEdHV2aEtxL2dUTU5ESTBC?=
 =?utf-8?B?T1V1UUZvV1M2ZmZLbUc1QmdKQW4wSHJnajJpUk1MV3NKdnBVUWllck5iZ2hP?=
 =?utf-8?B?Tkg1TUYrZGZOTkdBam45Z0lXQ3VtUEZPYVZadzdnbVdzRlJGbmRMdUp6VStH?=
 =?utf-8?B?ZkVmWXEzRitkUzMrZXRXakJNVU9UNmRRYWdLeDVVNDRFRmJMZHpRdUt1TnJs?=
 =?utf-8?B?cFhabW5wY0FUOVlkT0JGUk1iVUdPbnV3a3h3TlAraDU1UzBkNDlBc1lEc0lI?=
 =?utf-8?B?OVBtWk4rSEtVcGRXVG9zNE1mZmt5dlJQdEhOTVI4YmpLak83bkdVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c45c92-3dd7-42a4-c87c-08df3a012de3
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:21:25.0998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NjOFvlxb+4Ynrp0/gzb1qTOrv7Qp6VH0+beMSs1YjzuLj45u7b2Rm7Uy+fSdbZWcdEuUMe9NDFocpgEa3URwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB943461
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-02 10:47, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer. The exporter is the one physical station, so the only path
> the HW serves is importer -> exporter. A message the exporter sends to
> the importer cannot be delivered by the MP nHT.
>
> Emulate that direction in SW: when loopback is enabled and a remote
> interrupt is addressed to the importer, queue it on the loopback
> ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
> as if the exporter had sent it. The ordered workqueue keeps successive
> messages in order and runs the (possibly sleeping) handlers outside
> the sender's context.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 29a787979af2..ef133c60bb9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -60,6 +60,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>   					   u32 remote_accel_id);
>   static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   					  u32 remote_accel_id);
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3);
>   
>   #define STRIP_NPA(addr)						\
>   	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
> @@ -6220,6 +6223,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>   	struct amdgpu_ualink_ring *ring;
>   	int r;
>   
> +	/* UALink loopback: the single MP nHT can only deliver messages addressed
> +	 * to the exporter accelerator. Messages addressed to the importer
> +	 * (exporter->importer direction) cannot be delivered by HW, so emulate
> +	 * them by feeding the message back into our own IRQ handler.
> +	 */
> +	if (adev->ualink.loopback.enabled &&
> +	    remote_accel_id == ualink_imp_accel_id(adev))
> +		return amdgpu_ualink_loopback_self_interrupt(adev,
> +				ualink_exp_accel_id(adev),
> +				dw0, dw1, dw2, dw3);
> +
>   	peer = &remote->peer[remote_accel_id];
>   	ring = &peer->interrupt;
>   
> @@ -6649,6 +6663,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
>   	return handled;
>   }
>   
> +/* Work item used to emulate an exporter->importer UALink interrupt in
> + * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
> + */
> +struct amdgpu_ualink_self_irq_work {
> +	struct work_struct work;
> +	struct amdgpu_device *adev;
> +	u32 sender_accel_id;
> +	u32 dw[4];
> +};
> +
> +static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
> +{
> +	struct amdgpu_ualink_self_irq_work *job =
> +		container_of(w, struct amdgpu_ualink_self_irq_work, work);
> +	struct amdgpu_device *adev = job->adev;
> +	struct amdgpu_iv_entry entry = { };
> +
> +	/* Build an IH entry as if the message had been delivered by the MP nHT
> +	 * from the exporter accelerator. amdgpu_ualink_process_irq() consumes
> +	 * the sender accel_id from entry->pasid and the four context dwords
> +	 * from entry->src_data[]. entry->ih must differ from adev->irq.ih so
> +	 * the message is processed here instead of being delegated to the
> +	 * UALink soft ring.
> +	 */
> +	entry.ih = NULL;
> +	entry.pasid = job->sender_accel_id;
> +	entry.src_data[0] = job->dw[0];
> +	entry.src_data[1] = job->dw[1];
> +	entry.src_data[2] = job->dw[2];
> +	entry.src_data[3] = job->dw[3];
> +
> +	amdgpu_ualink_process_irq(adev, &adev->ualink.irq, &entry);
> +	kfree(job);
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message to ourselves
> + *
> + * Used in loopback mode for the exporter->importer direction, where there is
> + * no HW path. The message is processed asynchronously on an ordered workqueue
> + * so ordering between successive messages is preserved and the (potentially
> + * sleeping) message handlers do not run from the caller's context.
> + */
> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
> +						 u32 sender_accel_id, u32 dw0,
> +						 u32 dw1, u32 dw2, u32 dw3)
> +{
> +	struct amdgpu_ualink_self_irq_work *job;
> +
> +	if (!adev->ualink.loopback.wq)
> +		return -ENODEV;
> +
> +	job = kzalloc(sizeof(*job), GFP_KERNEL);
> +	if (!job)
> +		return -ENOMEM;
> +
> +	job->adev = adev;
> +	job->sender_accel_id = sender_accel_id;
> +	job->dw[0] = dw0;
> +	job->dw[1] = dw1;
> +	job->dw[2] = dw2;
> +	job->dw[3] = dw3;
> +	INIT_WORK(&job->work, amdgpu_ualink_self_irq_worker);
> +	queue_work(adev->ualink.loopback.wq, &job->work);
> +
> +	return 0;
> +}
> +
>   static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
>   					struct amdgpu_irq_src *source,
>   					u32 type,
