Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173A3CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 22:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D66010E17C;
	Wed, 24 Sep 2025 22:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pp/OSsag";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36BA10E17C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 22:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/I5M7lK87K59w+JFM6YYSKkW8N+M0yvmfzIZITmn57kEHoYRckfIdAP6D+1JRinCWi6joypML5SoE64S62g7KKnBcM/Bct+eRaoIhaAWn6EM0Veifuvau49LhklK63XA8fVfDHUcdk7exGmtbeBTcX8afegmPUXn8ejYMaCZMTf/22+6elZEMemMrjoTZLqmQD1/yA2HkRi6trKm0ABn6xJttVbeWHlywva02V9diLgPBP4SiKEUmUzNCeEWmEtPYml0ymteLgpmB5QU3Opkfq3SnRjHumaRehh6DGM2Y3fRR9B4Eqn1P0Lhi3oYzguSIlwZB+iivIAoU0sgi6y8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m0rXg4fjcPd/xoT2czYZa39ktgrqhvmixWKF8T9Q5s=;
 b=DZyP2cZ+6dz1NGMIGEuF8oTzNA4G9Q5mWpU3UhYOcAnZlBDHPb9m1F0AeCUZGBFB2Y1rEmbopfgpNUyi6f73v6DI3qlFcmjcQlpbjQPvtMKICu28QXf+2iSl2P4bgCCpO5Snw+pcDvmY0TuoL1dfqDiDS1JEV9Vmpf9mrpwAvIo9PGp5ZeQFhGloYLgK41JfDdOLC4khnLhaGd8s/FcpQucX6/+vSpr9seagDyj6a5U40n8dM0IeCKUwV+C1AC5Dqx4HBV0D+rGKEdDwT3W9VxXHInQe88Z1AVCnP4ej1jNHZl4hBqS25FM3WN65qF/D30GRzHUCCMQd5Vqh1B1/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m0rXg4fjcPd/xoT2czYZa39ktgrqhvmixWKF8T9Q5s=;
 b=pp/OSsag9Dyl3ZhkLl5oiJOxC8yCSJzUSAstRkoOc9/p5U4JruwJrh5Cr4ooAZgJvIkFa9fX+Ix0Ou+6qS5D2yxJ+LpnCOgbQuBdaU4DTvTmx15PICpmHUjtjWPkvvdyFjMlw15K11bt7k9sBZnYhozRrYkP29JaPhPZB48+Cbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Wed, 24 Sep
 2025 22:48:35 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 22:48:35 +0000
Message-ID: <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
Date: Wed, 24 Sep 2025 18:48:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 Lijo.Lazar@amd.com
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250924152929.2234747-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0338.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e290d3-83ba-4258-0442-08ddfbbc7e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFJWazl4OWxqMFF0NnNTUnFCaDFTTytaL1pibWpGdExTYys0cUlkQWoyRUxI?=
 =?utf-8?B?NnZ3eStIVnl4ekdKbGJVVC9wcDlnNFhWY0x0NjBPMVl2cVdXYm45bG85ei9I?=
 =?utf-8?B?cFNGSllHNXBkU0NTS2s3WHpHQTBvYTNEb1lHRjJMVGxDMU9aZnNVMHVpMUpL?=
 =?utf-8?B?VEJraVgzVzltaHBqM2VoZUwvQjZ5dVBZNURtdTFUeEtadlU3dTJmbjY3VDBS?=
 =?utf-8?B?Z0R2L0c2Mm9hRTNlb3NqbERmWXBoeWF0MUNnNXBPQ1h1cWFLRnpCL3R2Uk9T?=
 =?utf-8?B?em1hUEJOUUYzejQ0WDRzMWswTUdFaTdNVFZwcTBrVzlWcTJRZmF4VkJXUlpD?=
 =?utf-8?B?T2JJZWlUTnFGUUV6cXd4K3BaWldxV05jT3I0RWk0dDFDZWh4RmQ3TnEreEZi?=
 =?utf-8?B?WFdHZzdmYkxmbktDbk5GVmxhS3ZUZGpKN2hLNVFFRE1LaE9ZYVpMM3VGa2dv?=
 =?utf-8?B?eW1Bbi9mYkZsamFvMXpyMWlndENyam9IUUtuM2pucGUwSWNPd2lITU8xWEE3?=
 =?utf-8?B?eWdyclVkSGdpbXhrV0NtT3ZXN2NpcWk4SkNwZS9KdlhVN0cvZExxQThJZzkx?=
 =?utf-8?B?OHltR2VhK2ZJTzBRbFQwNkdoamZwTFVqeUE4cGF6K0labHplQVlPU0tXMVRF?=
 =?utf-8?B?QXkxVXNTN3ZxM0F3WVUvYllpbitlMmtocTZaZkRNdWJrVzk5SHNQL3BoSW9E?=
 =?utf-8?B?K1VNS29uMmQwUGFGdnIrWURQa2FwZjZwRVJFeVEwNVBUMWhXK2pZcGRvdU91?=
 =?utf-8?B?QjkwNVRjK2lENVNnNXNENHBUZm9VYW44d0RvazZGelBoWTM2SjZWRlFucjJK?=
 =?utf-8?B?elFvWklJQXVHSStPaDdsclRPaHZCVUprSmJPVmlXb29NMkhEamllc1ZQS00z?=
 =?utf-8?B?Z2taSkRrMzgzMmZqM0RUZXZaTnNKSk81T0E4SnRTQVAybDR5R0RZWDB1eW5J?=
 =?utf-8?B?SWFyR3YvZ2RvRjVVUGZrUVdBSHpGVFNqSkg3VVI1VmEwQk5VcmJPOUxNQk9R?=
 =?utf-8?B?MlpKbHVoK2N4dUN0U1BDZ3l4UllKMUEyeWNHZGVlejc1TEdha1BxZk1nT3lR?=
 =?utf-8?B?d2FBTFZEbU9OSUFkRCtaZUVKemRpbFh2c3RJK0tNSkVPWFh0NmxNZU5BcnUy?=
 =?utf-8?B?Ujd1cXJmOVlTNHZtd0dBdUkvWGFnOHBlL0FVbTJVcGlKVGlyNWFGakVmOFp5?=
 =?utf-8?B?NzhKMnFmR3gyUm1DQisxZ011WEZEMWxUZ1Y3WGVVenlvYkVjSnVwdzkwNm9z?=
 =?utf-8?B?amEwb3ZlN2h3NFdMVjlqb1luSE5CRUxIMHVXMjVJVmovMTNrSEdhQ2k4NzI5?=
 =?utf-8?B?blZoT01JQTFZK2w4TWRETzVxcXEvWC9ZZDJWV3FtdXprZjh6cXQwMzdUZ2xP?=
 =?utf-8?B?VjZCMjJSVlF1ck1sbDArZ3FXdkJNRThKTTV6YVFkWEhsMGlKV3BxYUFOVEdi?=
 =?utf-8?B?eW9HQko3RFBhU0hDNnV3OGRDOHpQczY2R0k2VUxJTStqVnJOaUY2bTg4ZnlJ?=
 =?utf-8?B?MTV2MlR2dy9FZEJLbHpUVVRRQXdJNEpzU0FtOWJQQTREWE4vVVI4WFJUVXJW?=
 =?utf-8?B?MDFQSkdyZDdjTFNpQkVvQ0VVb1c5WG01NDc3aG5Xd21rWkQwMlBuZVhKVHNC?=
 =?utf-8?B?a0x0UHVITElxOGZhdXQvRzRoVUtKdG5SWmJtZXBhRGNtRGtqdHY0K2FGMUJv?=
 =?utf-8?B?MmhYQ2oxU0I3NGFzWGhQa3U4YVJSTUo1MTFOZkUwWk5ONzhlbTNsVDdQaDBq?=
 =?utf-8?B?U1lVSmV1Y3FZRlhVSmQ0WlQ5ZFVYZnpPQjF5aTUxRzQ0U2JwM2Z4SmVzcWIw?=
 =?utf-8?B?SXVQRkZjbXNDRXUvNFc4NDE5U3BjNXRXMnhrS2tVN0lwVVptQzMzUG9rZ3pN?=
 =?utf-8?B?VmR6S1JTWW91WmtXTWg0cGJDVFRycm9NVmRZN3k2VVhCY3EyclAzMXVnZ1ZQ?=
 =?utf-8?Q?xjgSnUp91gM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1WN3hoNUVPL1h2WUd1cE1ZYmJTaURTUC9sYXk5eFVBSUM4QWJwcHZpUjVL?=
 =?utf-8?B?dnIvbDU5NzNHN3UxUE1VS0FPMTByWjVoVWxQcUV1aXVTalBhVXNHKzVDU01Z?=
 =?utf-8?B?UU1Bb25DbUtLSjB0K2UzRWQ2VjNiOFFncmdpRkNMYkVMbUF5cUh6WHcwdW1K?=
 =?utf-8?B?ZWdTdUF1cW50UHN0MHFVY253dGhwQ0NIbkJrYnJBZnJxS1IraGNhWXUvOGNj?=
 =?utf-8?B?UHdBM2pqaW9mbVM2TkxrTXVjbGFicmtIOGw0azJqam94K0N3ekhqS0dPS2ds?=
 =?utf-8?B?bVJxMjhhWXFqSmw3SGw4L1o4WStQdG8rdVFFWVB5QkNlcjg3c2RsN1pkL0tG?=
 =?utf-8?B?Z1Vnc3FseG00Um0zS29Da0FSQy9mWGpMRFBsR2U0cXNDeFZydVlrNURESHhE?=
 =?utf-8?B?bWw4WUtnRDNjUXRTVXJRdHFWVFZ2d3FreE12RDk5WWVKWlVKajFZcHhnM2p1?=
 =?utf-8?B?UEU0YTRKeUsvZHVYUlppc2tpTHhpUW1kTmJiaTZJSHpVVzVSMXJRTG9XNFha?=
 =?utf-8?B?ejUxWUQ5L0dZeUJjMzc0a09ua1ZWS2ttWW1SZngxL3JxYis2TnNxS2pLRHpV?=
 =?utf-8?B?Y25HNnZDZ1ltSUdBaGYzeDVsU3JwWXN2NTBBVnM5YytLa0IxeXR1a0dZcTM0?=
 =?utf-8?B?aFVJcTFTUDlUNzRza2ptRFRhMnFrV0djWUhJc0VhUThhMS9Ub0xEQkVxd1Ns?=
 =?utf-8?B?YzJuRlV2VEVCMWM0dmI5dk01Yi94T2lnY1BEa1Z5WWo4TWMyS3BWK0xLb0sx?=
 =?utf-8?B?QnVhakxtOGduclZLVFE3N0ZQYkQxWjFWZFdxdTdFTUJNRWUraHVIenB2L0d0?=
 =?utf-8?B?RS9ENytsSHVCQjQrc0oxNk5tTkhURHpVTTRLN0JGNTRVNzczQVo5bU4xbkI3?=
 =?utf-8?B?TlFFcEN5TThTQUVvcHNhS00rYWJ2TFVXT3dmVE9lQlhKdFltVWcrMjRWck5K?=
 =?utf-8?B?eTFhc3E2c1NlZmxmN2M1T2JkZDlxNnI4bnhlK01YV1pWRlcvSUlvN1RKS0Vm?=
 =?utf-8?B?cDFMTlA5NlZrMS84RWt5N0tFYTdSd1N5MG82WVN1ekJCWDZYWEpPNk01bnNB?=
 =?utf-8?B?MUdKUmtneEEzTGFRdWJCWUhzTGc1L2JMaGlBb25pQmVud2NjdG1ZcmZCUjlV?=
 =?utf-8?B?Wnl6ZFpLU3BDRlBXdmp3cmRMdzUxL3l2WjRiV3RnWHRCRlYvU1E3OVFvQ0xZ?=
 =?utf-8?B?Y2NBdEoxbVFtRVdPYVJ2VVo3WmxIbDZ6V2VNbFFUY05sNmU0YTB5cVFzNjZI?=
 =?utf-8?B?SS9NT09mWkJYSTFYUFJGY0J0SGtiZzJzS3BqK0hVY1JGSTZlbHRieDFWeTJ3?=
 =?utf-8?B?YkZHNGdSNjRXY29aNTNaVDRxdFdpdUtBTWhaK2ZKeHRDb3R5ZElMQWd3cGdX?=
 =?utf-8?B?TTBET0pIYy85VzhWS3hZSmVramVDZkVXQXdNMFBTUSt1ejU5NGlHcDBCK0M4?=
 =?utf-8?B?TWxTcnpCNk5ONHhGeHRKUFlxcVdFazhiNzlZakl4WnFPS2NLZUlyM2Q4RDd1?=
 =?utf-8?B?S2dtemFYaGZhSGtncFh3bEt6T1dPUXNobi9kMHQrZkU1TkR4WFhKQjg4aFhp?=
 =?utf-8?B?MkVkQUhmRGIwMCtHSG1EaEc3Y210eVhZL0ZzYWVJc2FOL3lQSTBrVFVjK3Zq?=
 =?utf-8?B?OUR1TmJVb3JqZGtoNDMrRHc1SHN2N1FLeU1tK3QxOU8rbHpQSkxMTzkxMVlU?=
 =?utf-8?B?Z2FYVVNkakY3UVZnWG9ocXNVNmZkckh0RTJzeU9jZXNxTmpPWlFTemVSY1hG?=
 =?utf-8?B?K3ZleXZxTmZ0VVBZOWlIMnJGSUIxYWd5cTliaWpDYlJ5eXpuVG5MM2pMazdz?=
 =?utf-8?B?dFM5NXFVNkVHMCtqNnl3QUZJcUNldWhTNjRrUEVCY2FJeG9hNFNkejF1YjRs?=
 =?utf-8?B?K1FKME5OWmtwS1BjMFB5WlNUR0hKWEVyRzVPRXhJUEZHZ3pnNjU2UmlxSnNh?=
 =?utf-8?B?YmpPUml6cnU1bldnSzVlc3hwTlc3L29RZWVnTnJyb0plVHk2RlVucm1kZ0hE?=
 =?utf-8?B?QWJFdy9aRUNOQkw4NGpFbzlHMUVsYlBGNXFraTBCUE9FNDB0THhKTklhUVgz?=
 =?utf-8?B?Ymc3b1lDeC9BRmF1K1JHQnUyeTZTM2pXa08raG8vYzByTzlTVkNrYUlIeWhM?=
 =?utf-8?Q?c0Qw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e290d3-83ba-4258-0442-08ddfbbc7e93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 22:48:35.6132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd3QkZL44geRm5j047octkqTw4v0gPkmJ1FETFg2YlIYmSkCySiyOt11yEsofuyo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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


On 2025-09-24 11:29, Yifan Zhang wrote:
> There is race in amdgpu_amdkfd_device_fini_sw and interrupt.
> if amdgpu_amdkfd_device_fini_sw run in b/w kfd_cleanup_nodes and
>    kfree(kfd), and KGD interrupt generated.
>
> kernel panic log:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000098
> amdgpu 0000:c8:00.0: amdgpu: Requesting 4 partitions through PSP
>
> PGD d78c68067 P4D d78c68067
>
> kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>
> PUD 1465b8067 PMD @
>
> Oops: @002 [#1] SMP NOPTI
>
> kfd kfd: amdgpu: Total number of KFD nodes to be created: 4
> CPU: 115 PID: @ Comm: swapper/115 Kdump: loaded Tainted: G S W OE K
>
> RIP: 0010:_raw_spin_lock_irqsave+0x12/0x40
>
> Code: 89 e@ 41 5c c3 cc cc cc cc 66 66 2e Of 1f 84 00 00 00 00 00 OF 1f 40 00 Of 1f 44% 00 00 41 54 9c 41 5c fa 31 cO ba 01 00 00 00 <fO> OF b1 17 75 Ba 4c 89 e@ 41 Sc
>
> 89 c6 e8 07 38 5d
>
> RSP: 0018: ffffc90@1a6b0e28 EFLAGS: 00010046
>
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000018
> 0000000000000001 RSI: ffff8883bb623e00 RDI: 0000000000000098
> ffff8883bb000000 RO8: ffff888100055020 ROO: ffff888100055020
> 0000000000000000 R11: 0000000000000000 R12: 0900000000000002
> ffff888F2b97da0@ R14: @000000000000098 R15: ffff8883babdfo00
>
> CS: 010 DS: 0000 ES: 0000 CRO: 0000000080050033
>
> CR2: 0000000000000098 CR3: 0000000e7cae2006 CR4: 0000000002770ce0
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 0000000000000000 DR6: 00000000fffeO7FO DR7: 0000000000000400
>
> PKRU: 55555554
>
> Call Trace:
>
> <IRQ>
>
> kgd2kfd_interrupt+@x6b/0x1f@ [amdgpu]
>
> ? amdgpu_fence_process+0xa4/0x150 [amdgpu]
>
> kfd kfd: amdgpu: Node: 0, interrupt_bitmap: 3 YcpxFl Rant tErace
>
> amdgpu_irq_dispatch+0x165/0x210 [amdgpu]
>
> amdgpu_ih_process+0x80/0x100 [amdgpu]
>
> amdgpu: Virtual CRAT table created for GPU
>
> amdgpu_irq_handler+0x1f/@x60 [amdgpu]
>
> __handle_irq_event_percpu+0x3d/0x170
>
> amdgpu: Topology: Add dGPU node [0x74a2:0x1002]
>
> handle_irq_event+0x5a/@xcO
>
> handle_edge_irq+0x93/0x240
>
> kfd kfd: amdgpu: KFD node 1 partition @ size 49148M
>
> asm_call_irq_on_stack+0xf/@x20
>
> </IRQ>
>
> common_interrupt+0xb3/0x130
>
> asm_common_interrupt+0x1le/0x40
>
> 5.10.134-010.a1i5000.a18.x86_64 #1
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 349c351e242b..051a00152b08 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1133,7 +1133,15 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>   	}
>   
>   	for (i = 0; i < kfd->num_nodes; i++) {
> -		node = kfd->nodes[i];
> +		/* Race if another thread in b/w
> +		 * kfd_cleanup_nodes and kfree(kfd),
> +		 * when kfd->nodes[i] = NULL
> +		 */
> +		if (kfd->nodes[i])
> +			node = kfd->nodes[i];
> +		else
> +			return;
> +
>   		spin_lock_irqsave(&node->interrupt_lock, flags);
>   
>   		if (node->interrupts_active
