Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75FBC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 19:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B83C10EA72;
	Thu,  6 Jun 2024 19:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zcwQdgBd";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C08910EA72
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 19:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkOzFvPPGYDcjIb54yBU/mTjVIonnbn52SWOazFdqM5VrhumE4c+mG/DY/iF9v6eN0BRxc8Yqq5/r9F/jp4CGLjgIHah9eMN0Z+KH6Jydm24io2WsiRNyIX08hWTCIaAG32H5HFyEdZTScT0vOBRbSvIn7CLYgzCcXJGFP9PZdB6F7/TBGD+cHDri/6QQdCZHEhZhDBaBI074Hr2S0PRUoLLK3QvlYysl3DGlWH0JHTlxMVapbr2u1sCo9lYII71LWFznIV9JYcd8Rw7277myr2GwTecP/XoGr8COefpmEpmrLZqLkvwg0IHh6/hICyN6VLcHuHpMSN48rd2LDfXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAM25VM0I+ULD6QOJOZt7jmx2O9wuRBopBfxO6aNXxk=;
 b=N0Yp8+hMnyKIgtSd74bCDc08l/Aow7gAWtwvCnZtNT2zibmDmh2DIJO/MdTjiIGP8TnSiZhXvOSxFT9DN8XsXTcPORiGHNzJKUAQztLkWC42zFrivOfC/spt0dS5RBsbyXqIfIsBNcktbPdfTvuoZzdvWK2GK+i3ECub8wy40deV0xruIg0+SzyKlCWGAwu9YmOhpLWcgyQe3TW2wjjSkJ7YCciO6LknTdk8Yh4Wv3is6yw0DWZoGDpeNB3ddrO8fBpE9HfDpaQYh6ZURHZDM6yNZoxLnmkAca2UG4GNulU++nwSnYMub1DsjKfqi7vKCluPxFvr3udefvmyvIQYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAM25VM0I+ULD6QOJOZt7jmx2O9wuRBopBfxO6aNXxk=;
 b=zcwQdgBdIxbM3JnhQZHZDMjFZjFqbwNOMOGuqVNC5gKpuJxwx4+Vlq8dBcunjWSwYwVDNLOcv64LiaVOuwTEPrwPnuQA3e/Rh6xiIG+Usb6i9TzmcmRBt7jI8+qLMQR7jov1p929ueTuHmw02/ujPbB9vO8ptFeKnt5Aw+2kT+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 19:01:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 19:01:49 +0000
Message-ID: <795fc033-d254-4e19-9d43-c82b606bbb80@amd.com>
Date: Thu, 6 Jun 2024 15:01:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] drm/amdgpu: add lock in
 kfd_process_dequeue_from_device
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
 <20240605013318.11260-10-Yunxiang.Li@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240605013318.11260-10-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 612698df-c09a-4054-b79d-08dc865b1e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFJvVGFYWU9NbzFqQ0gzcjdWK29NakxmVkRpajBHUXcvZUtYNitUdzBubzRG?=
 =?utf-8?B?TkcwTlhFVHhLR3FibzZsQUhVeWpKczFwdjYrUXdhL2FDb3JyS1ZpNEhZeDFM?=
 =?utf-8?B?LzcvcTFwK3M2ZXRJVnl2VWtoWUV3N3pzZ2VkS1Rxc2Ntak9NdCtTUGZXdzJr?=
 =?utf-8?B?REx6SGFvbUZ1UHBUY2FMRzYwSGRqZHZrUHQ1OUZnVzlMRlFYaU5tUUFjVVhB?=
 =?utf-8?B?WHpMNkoyaWtGZGxqRTkvQlpvUENDckVEdGhaNWZjd0Zadm4xeENWLzFGQVhU?=
 =?utf-8?B?aHZZK0NnKzhJaDEzaFdIMUlLZ05nS0s0c1A4ejNod0RHQlY2dkk5TVIwOHFo?=
 =?utf-8?B?OTNXY2FSWk56WU03MUozODJER3p5WUY2aFA3U21rYnMweEduTWpTMFoyc25t?=
 =?utf-8?B?akV0NUpHeWJ5cHBDWkk5dzg5OXhHNUxqcW53VlFtQThWTXBTL0hMd3VNSity?=
 =?utf-8?B?QXVPZFhHMlpVK1RsL25zenYvc0pPRGhYcVFWNmFNNGQvemdwZm1yLzJleURC?=
 =?utf-8?B?YjRvV3g0MXNQRzk3cWllb2tJa3FXN2JJMDF6NE13Y21rdmt2YTNHekJsUGVB?=
 =?utf-8?B?Y21PeWVmQjA0QnFBR0dDZ25GRHFxcU9ZYVBwUE56ZDRUV3JYN3VVdU1RTmJa?=
 =?utf-8?B?dGd2Sjk2L0l2VjR3UkpXWHAxemFwN2ozS0srV25pMlhYdDlLZEhNSU5nOVlM?=
 =?utf-8?B?YW5MMlR2VnRDa0x4eE4zN01SYjcybXFCNmVLSFRUV1pHZXM0VGdhSWR1TU1R?=
 =?utf-8?B?eXoxTkl0NTFUMUV5NEw3TFFJUTRSS3owUUpoMnR6cWtNQTY1MDN3eUllcTd1?=
 =?utf-8?B?R1d3SnFReEt6Y1ByNWlRcis1L0IyYmtkSGxBaTFIQ0REbjRKN1ZqUS9PVEh5?=
 =?utf-8?B?WmVWcFh4MXQxaEFUaEVwOGE4c1BETk9mRDEyY2U5NW1leHJIbE9IMDZuRGpC?=
 =?utf-8?B?eXBzUzUreUNtRkJjMVhIZW9rMzdHMTc1WWpmdHNMa1JxdFY2QmNSQkloVG44?=
 =?utf-8?B?eDBWQzEvblk3bFhLbWE4VTErUVlPai9XZEV2Q2ZuNUtUbXZqZmlvY2xnckd6?=
 =?utf-8?B?Y0lwRG1Pb1UzeU1NTUNvT0lYcnA0cnV5MHRYbEF2dHdRT2VBb2dFTHV3NlZ6?=
 =?utf-8?B?WkJHc0REUkRNV2ZSV1NtZU9vSHdsa1ZTc29GS2srMExoalRBcUxrNnhhWW93?=
 =?utf-8?B?WFVZWWlud05kS3FiMytlRlBXVVBwUVo2UmRKS2hucTdEc3p0K3ZyMFI5Q2FB?=
 =?utf-8?B?T3dzejJJbEVUeU53TTN0T09tbk5HZE9HTGhXdUR2VEhPUDRwNU04V0JhZGdN?=
 =?utf-8?B?dWJVUXZZVGtQcitub0ZpYTJ2UlhYVDVubThsRXFKNENzNUNqeGQvZmFOVTlG?=
 =?utf-8?B?RlJRaFRiRFJqMllhQ2hYUUkyazc4L1ByNXkrZEJRWldOTVJoYWpESit3dStZ?=
 =?utf-8?B?cHBwK1ZPVGtQV21XRWNtd2xqYW50bzQ4OVI3SWdqdTRnQUltUjdOd3JPbGh2?=
 =?utf-8?B?a3BiRVJ5RFM0OWo1UXdYU3dYaWY5OHRtSVIwMzRKd0treFduR3J5U1loa1Z4?=
 =?utf-8?B?WndpbWRkZjBLNVN3eWtFcUlPakhaVnlmN2tvOEFtaWZpZ0J5dkRkb0RFQ21N?=
 =?utf-8?B?U1NRdjRRTXdLUHI5bWJ2YWxpQ2ZhOGdzN3ZCamxRZU9UUFY4THBCVzBSN0Rx?=
 =?utf-8?B?M0dVVXphcjAzM1FWRjZua1R6Wjh0emcxR0JDWUJ6V21XVG1UV2cvZmRGUWE3?=
 =?utf-8?Q?EdR3pr0v2CuYQAOFHN+IQlGUa/l67TaJWIgVOlL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWpkZGZITUtiSWZaT2syZ0xvMGxDcnVia01TNGdSdXUvQ1kxaGRIYkpQd2RG?=
 =?utf-8?B?VXR5MCsxTWtUaGtNR3pNbmpIMC9XSzNBU0l0V1Y2NldDc3hKUVlweU93dThD?=
 =?utf-8?B?WUVaaTZySVZEdVNZL2FoTGNBRUdSbG5vVFdNYVFoZ2dWSXI4Wjdva2R6Z1pp?=
 =?utf-8?B?Umt1VWROQ0svUWtDVEJYN3BoTitmQjRPL2NvVUFkQkY3L0NSaTZpamVxTElh?=
 =?utf-8?B?ejNmN2x3N3o0ZlI5azFQeW44VzZOU0NidlJQWTZpV2VtZDd6bjFOTEFDVGFr?=
 =?utf-8?B?eGVXa3Z1VzFaNmV3U2VTTlZUVzF5T2I5dDZwZHlyUlp2TDR2TTFpUURMQWt0?=
 =?utf-8?B?MDBRdmF4bGwvbktMN21JSUVPazlBZU4yRzJVUCt5LzZrcUE0amlEL0RFYXMw?=
 =?utf-8?B?SXZVZkxFYVByUDB2Vm1PcHV1Yno3c0hTR0lEc0sreUNKNXZONEoyTnVQV3Rs?=
 =?utf-8?B?SGNNc2taajBISzNzY1ZFeklxSktFSkloYTlIaVZrMytsNnBYVXY3bFR5aXJq?=
 =?utf-8?B?OVlhYlpMQS9vRjN2VkFkZXU3NzVvVVFtK2ZZcXFySkczOUZqTzdSN0dULzlw?=
 =?utf-8?B?bmlhUWxXWlA1ek92Y05RdjFWakJyaXlzTDFyTEdUZXdxY3NLMGxhOUNqVHd1?=
 =?utf-8?B?QUFSMWJVdC9oNmI1ekRYV1R1OGN6N1BMbUFPMUtjWnpYWVRreVlKRHc1TWVu?=
 =?utf-8?B?VWJHNGcxMXo5M2dYM2V2dXBsM000TUJZN2VVdDAvOVRYOWlTQk1VbjVkTnZk?=
 =?utf-8?B?bDg2emFaTGNad2RHTTNNZFpnMGt5VE9nM1dlT3hmQUdKc0sxZ1ptZkt4Y3ll?=
 =?utf-8?B?VTVmVWhPSTFaOHpmQUxsRUtmbzU4MkVVMWdLaDZGWFhJR2ZFNGMyaS9zSU1l?=
 =?utf-8?B?Q0NRVm53TDdVQ01Bc0VwMmdZVWZuQTl2M3EzUFZET1FtMytkTWdKYUJtK3JG?=
 =?utf-8?B?cDNtNXg2TjVIL1ZmTTNYaVF6Z0ZJclFxc3k1V3VSWlZCRUR3K2VJcmRNWm82?=
 =?utf-8?B?UGtjamNBSC9RSUxnYzBUUDQ3dHFxOFk4eCtxaUZTNVBJNHpsYmxDZlgvSE9y?=
 =?utf-8?B?WjhEdGpDbTJ0aDRUOExua3hEUUwyM1dRMFpEOXlIb3o3SHY1bWx2R2VJRDlM?=
 =?utf-8?B?SllFVTkxSHZVS1VOZmpPbDFkaTQyVjk2NXVrYzlZc0UwNHRTN0VYSHhSWXdV?=
 =?utf-8?B?a01xenlhTkpBd2JnSmRIRjFoaHpRZXltdXFqZWw3QlZGQlhsV2d4UTNheFVT?=
 =?utf-8?B?OEprWVBQWVBjc2FKSkJmbkN2OWhjM1lnNXFjUlRKbnBPb01IaERCeFlyWFdD?=
 =?utf-8?B?bmRoWVZlSzRDcUNmOHF4WExrV1gwdTFUdFhtK3p6d0lGQ1UvaVhjUTR3SEY4?=
 =?utf-8?B?aFNXb003YzROcjFENlg2N0FoNU5UNlRuRzFmbWNHcFRZYTM2STFaZlcwTFMv?=
 =?utf-8?B?c1BLWlltaDJNMFdYMVhJRkwwMm5pV0RpdUxNcDNzdzJGblpNbE9MYlpDaS9s?=
 =?utf-8?B?aWdpV3JtTmFuLzRyMmFNMEtQL1Mzb2RCb3BFcXI3UU5jeXY4VWxWK1RKNDBu?=
 =?utf-8?B?Rk9wMnl0NEtTdVdFRGtMOWVBVjVXdmFySm5vQXdHSVFpZis1aUpEWUdFTnBp?=
 =?utf-8?B?R1J1NDlLbkNVU1VWRFVsVkovTmZPdmxsRjNLWEZnTmFQNEh4V1N3QXE1S3Bi?=
 =?utf-8?B?YlFQZ0pCOTE4SVRKVGN3QWE4Y0lMMFRSS3EyNEF6N0d5cXdsbGo3cmlZVjRx?=
 =?utf-8?B?WUo5MFE1ajNBcmdTU3pqLzFNOEk0UW5ua09lWTZLektmcmk3RVZxMG0vWTZi?=
 =?utf-8?B?ckR4U2p5TVZtWjlYT0dMd294bmEwSG5TUjZqYy9xWnpuUzJ6MmR4VEZHS1F2?=
 =?utf-8?B?Z29sRFR5dG16bkk5dURHK0hSQ1graUsvaysxOFVkdTZLblFwaFMvaDVuVit4?=
 =?utf-8?B?dkJPVkl6RW1TYktsYStVZEI4alN6bUl2Y2lvYVpsQUsyd0Fud0NqTnQ5M29W?=
 =?utf-8?B?VVRZUFM1aTEwakgwWmtsMnJnM3EzZWdMVU53ckNEUENGWHI2OUFZVFNPZG42?=
 =?utf-8?B?ZDBxeTdkdms5NnozZ1pscGt3bkxWckxjeWhNMkl6ZUhWbFNxM1BRVk9zWHNz?=
 =?utf-8?Q?nEd0N3yFviwmDYaEdetEUg7O/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612698df-c09a-4054-b79d-08dc865b1e66
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 19:01:49.1308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7pHlTQjPZ5lVDPFkRvUqJTVHs7mIh+sLU4meHMaEQxAbPtAP7dZxzDfudWw2yl8oHmuy8LFF+TavUE1q/+Chw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
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


On 2024-06-04 21:33, Yunxiang Li wrote:
> We need to take the reset domain lock before talking to MES. While in
> this case we can take the lock inside the mes helper. We can't do so for
> most other mes helpers since they are used during reset. So for
> consistency sake we add the lock here.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 86ea610b16f3..21f5a1fb3bf8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -28,6 +28,7 @@
>   #include "kfd_priv.h"
>   #include "kfd_kernel_queue.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_reset.h"
>   
>   static inline struct process_queue_node *get_queue_by_qid(
>   			struct process_queue_manager *pqm, unsigned int qid)
> @@ -87,8 +88,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   		return;
>   
>   	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> -	if (dev->kfd->shared_resources.enable_mes)
> -		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
> +	if (dev->kfd->shared_resources.enable_mes &&
> +	    down_read_trylock(&dev->adev->reset_domain->sem)) {
> +		amdgpu_mes_flush_shader_debugger(dev->adev,
> +						 pdd->proc_ctx_gpu_addr);
> +		up_read(&dev->adev->reset_domain->sem);
> +	}
>   	pdd->already_dequeued = true;
>   }
>   
