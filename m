Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B180CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 21:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5A710E7F9;
	Wed, 24 Sep 2025 21:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVknQ83E";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012032.outbound.protection.outlook.com
 [40.93.195.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52DB010E7F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 21:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4CADCWcFd402Zp0JSBhyKUlxRWa0DQ49PB00yNSRBPjM68+WVnry3PqmJB52ZZP2tsMJQQv1U1VQ8PRMi6ik35vElM3l7x2avqLmjgIk9AFN4vDTyT8oFL0ocVF0xwWJ5SvHyisR0hC2ygkNwP8ksqw7ke7zh+JjZndbRUQnr1iRs7KG/3zXR/0BSHsn+AxQ89Qy3mr1BIUt5q657IwoWKbYR8WTBp8ESGKrBDEwvjqGnlDTED441WwIC1n+o4wjgdxVYccZgWzdpZdHjqOmWe+AqUdPwuLA0Lr4AIimrzzcWiv+RwU0eNRdOuATzVdR83lnL1RIzBeM5yU4BYMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnKCSpTlScuKzX8Ia/sC3WYDAQblUT7Rw6aRXympynw=;
 b=xvkDDmk8p0sXncOxknOM8I0OQfXl9FNzTFVanehejOJtLIY5EFa430h0NO9DeiuEEv0xch/k9PFCjGDddY8tk3ETesMtanF7WnJ0CgpY7sHApYp4nbh/fvGPnF6jVgyCnm1QlVTzF3WFOybC4BUfVYVv4zTpaLO2EwiH2doGSXP9GQ8XaPswm2uaCU4c68KooVallER56osMvjz8ZbTpVge8Zc6tIOI/YX6aVrjUR/mBmDH39oUNBTykF8qLPYMf9FnNRtnDSaLJHZsC/uH2bG8pjjVVLpvmEkCqIT+ONpQK06FXDEPDUyjv6llGTkWjRU7mefv1JYqo0OjsMJJFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnKCSpTlScuKzX8Ia/sC3WYDAQblUT7Rw6aRXympynw=;
 b=zVknQ83EcPse+Dk89ve290tQ+D4zQ00fBYnVstMJKOx6Ex6TNQVOcaOWSOPUmBjDaLuQJPpW9mJoMovNQNxr5gfb9LTS7cZ8K4yiKd17w5Zsdz/5kmyvrRIZHHMjgQ1DvYbMJg585z6ZKXl7GCqTUVkeDGDPPJP/xUANz4a5mSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 21:41:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 21:41:55 +0000
Message-ID: <4df8a39f-b899-4502-a223-3afe52c4059e@amd.com>
Date: Wed, 24 Sep 2025 17:41:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/18] amdkfd: remove DIQ support
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-11-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20250923072608.252345-11-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 167f641d-dfe3-4ffe-eb91-08ddfbb32e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVVqOGcySWd3NDRQMUNpSkxWd1A2UUsrOU42bjRTbWxzeWdYaVl5SDZWU3dL?=
 =?utf-8?B?a2JTR0hpbGhQUEVtSnlaWXJzT1lwWHhQUkp4ZTgrLy9SRFQvU3huWW1VWUh3?=
 =?utf-8?B?am4wZkU1Q2s5RFFZZEcyVEd5NzZ2MVVsWHg4MEJCUGVoeHM0TGZFOWZxeVd5?=
 =?utf-8?B?ejFNNnJTL2VZc1JkM1hSNWxGTmJNei9pWVp5TEFhK0F1M1dkOFVzWElxMUo3?=
 =?utf-8?B?cDVxbElYQjB2eXRNNDJydkZKWGxPQ0k2a3FkNWZSTUtOZmo4NWZyT2kvSVlq?=
 =?utf-8?B?c0xzcnFFYWxyZCsyVFNDVUFhQVdiTmR6cHNMSWs2eG5PTERzSDJKb2libG1j?=
 =?utf-8?B?bFEvMUlUNGo0NFM2Nnd3U3FqeHNuMkR6ajloRHpzMlNyeEFkOW5KSjVjcUp4?=
 =?utf-8?B?Mno0cG41SE1VOVZKemcyZzZXb0ZxUklZTXQ1bGRTMzE5RUgwYVNhWlJZNmRy?=
 =?utf-8?B?TFBmek92czhvc1E0RzdTYVBULzhodmcrRytVZE10VlpQOUVDa2plWnA4eExv?=
 =?utf-8?B?OHhKNG1xWE4vanhKdEdUZGh0Q09MbzFIT2d6RGpDdDhyU214aStBSXdVWmVK?=
 =?utf-8?B?RFJ5MndOVjZ5eWEwcFlnMGpVb3pPRzRVV2kxVG5BMTE0UENGQjZDbjRkeDFm?=
 =?utf-8?B?clczaUg3N1VrWW5aR0lvUThYUUdBS2pXQ002QmxRRjJBellJNGFhVEtSdVd1?=
 =?utf-8?B?OVZiRkJQWmh3aWdpWkFINWNiMnVXN2N6QnVXWHJNcjBaYUY4dDA3cmN1M09M?=
 =?utf-8?B?ZFdLUVJ2aFMwaWQvRG5LOEFNVndiTEM4N1Z6KzdCeDR4OGhaTGxMTVZ1UHpK?=
 =?utf-8?B?b25JUEZWR2RBQnlqbndnZHRqdWE3cVFra25NOE9xdVNEZWl6YjU5b0ZISUZz?=
 =?utf-8?B?c1JaZGxyMGVmTWVVMEdYQWViZk9QWlZZUXZQT2JDYVA4M2dmeC9MRGZJbUJF?=
 =?utf-8?B?eHNrWWNwcjZ0QlpXYThBcEhlNDBWbFcrOHpZUkJrUWZDOWM2Z1U4elNwK2tX?=
 =?utf-8?B?NFQ2Q2hlMEJRbzhSRWxsZWRKQ0U2TVRZSy92N2FKL2lDSWVNNW03NUxHVGtl?=
 =?utf-8?B?a0Q4VXlmRk5qbnI5NitmbVFNUjYxTTF2SzhmVHNZRlZQMUI4VWtpSWpTdzdF?=
 =?utf-8?B?bS9LME1sY0c4RS9ydlRmd2JBc2JPWFVpdGtSRWU4Nm9YNkZaK0ppbnJXdnVh?=
 =?utf-8?B?dWRXNXpDMk5acGZFb21pMDBLcGY5d0JRd0puU3I3bE1CL3U1eGxwLytYNlFy?=
 =?utf-8?B?RXkyYjN6RVlTTm9Ya3JERnhTOE42TVdCNit0dUQxT2dWWmFVU0h6RTloVnly?=
 =?utf-8?B?Yy9ac0lES1doM3pycmFmTEUybmdFWTcxcFVTK2dLNVZIMWMwdlNYUTB2RUhz?=
 =?utf-8?B?Rk5rOWhURlI4dzN5WjYxeWlJU01GNmcxaTNQSGVwL2xoUnM3SmtzOUFjUVdy?=
 =?utf-8?B?RjBMRUx1b2JNcTFhQkVCc2pwNFkvSUV3cUo0d2lTQzgvY1Z4K2NwWm1LTmNp?=
 =?utf-8?B?Mk5qSXdBdVN0aE5WM2VQdGRRb1d4Vm93NG9RVm52OG5GL051d0JqTEloblRL?=
 =?utf-8?B?SWtwcUxLRUh3elMyVVFMYXBwYmxqUHIxZC80dGhXVlRoL0c0dHBMcURMUDFC?=
 =?utf-8?B?NmVZTlFudkRIVjBaTnk0bkw4VHdhN3h0aVYzM3ozMXF3S0RwVm14aDhqblA2?=
 =?utf-8?B?N0JlRjRkMGxTaTNOZVBBV3N4Z1JIcFIva1ZMYnBxNkRFWnZ3aUJFZDBxTFZi?=
 =?utf-8?B?Zy9TbjVmcnlXRnFXdkc2MHpleVhtSVZNMUxMSC90RzUzNjJKd2ZFUkxpa2RD?=
 =?utf-8?B?a2FBdVJSdjQvQXZWMnJvbHdBV3BCS1BqYUIrVWFXUUZXRVhIV0NObVlxbHJS?=
 =?utf-8?B?N1J4RDRzQndnczBwWU05NHowUUJienduMVdjRlNFVk1ZaHNwbDc0a3hVUjll?=
 =?utf-8?Q?JBDySecOiCE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhENjZzVHJ6UTc0bDRmWjkyK0tnTjBjTmhMQi8wa1dZUDFLOVhZSWI5emhL?=
 =?utf-8?B?TVU2eUFUN09YOFMxeFljck5Qc2VUU3RiRjFidndaSy9ZY3NQS0ZBWGNzeHdy?=
 =?utf-8?B?YkdIdWhOZDNSbjFFQXg3V01peG8zcVBlRVMzeTlVRU1sWUlXT2k3dTNLWW1Y?=
 =?utf-8?B?N0dEM2h6clRiM2VRWW5pZklKRkpXMWVmOGdFWTZ6SHJNa1dhdWFDREs2YURD?=
 =?utf-8?B?RTFKTW5NMGtoV2N5OXphVllza1NQeGwyalVtWVI3U1ZQa0Z3Q3g4eThMcHRs?=
 =?utf-8?B?QmNta3hucS9yMi9rL056Q1BsSG1wa2s3c29ZcnZGeU43TjA0Qzg1TTJkMk41?=
 =?utf-8?B?MVZvUnBraDBzWGpidmkrVTAxbExrT2lwRDNOK2hHMXR2T0I3b3RqSU96RkpC?=
 =?utf-8?B?bzFNazYwU2ZvSklNUEhzWjQrcndNWXlwY1hkemgvVHhtb3pUanNyZlJtWUgw?=
 =?utf-8?B?cU5BYnBBeFVQRW9seDVnSXBCak9Db3E1UDUzMmovbmRMQ2oyTHNZRElFQnd6?=
 =?utf-8?B?ZVNpUm5CWGpzYzV3SVpaUFlqTVIvSERMRGV6L25JWDJoaTJGT2ZvSVVoang1?=
 =?utf-8?B?Z2UxZU1VODJyU3FGd2lpUEJhRkJTSS9xT3JORTZqNS9EaHdUTkRSTnpDeHJN?=
 =?utf-8?B?MFIzaks1cEdXYWd0cDUvdVN6MUtUSElycHdSNzJ4RGxzb0JZcEZoTk5Ja2Fv?=
 =?utf-8?B?bWlCVGFxWkZyZlU5K084ZmN3STJnNjEvZnlGdzUxL3pSdjZLbVh0TkllU1do?=
 =?utf-8?B?SU1GSXl4a0F0dDk3QTN2T0dYcmREVzdEeGlkOGRmdHo1UlNqV0R3SlRlT2VW?=
 =?utf-8?B?SzFaemw4VW1NbWNKU28ybDY3ODJRV2xPQk5pR2puK2VpbWVkWkFwZ0NFTW9N?=
 =?utf-8?B?RURaczlOajl5aVFOalB1eE5hTEVIb3ZRbHAxbWJEY0wrUHBuTWd5MHByaHJS?=
 =?utf-8?B?WkNTRDhzOVFLWk5hbEF5eXVSaG5rZXFTUUpoL0VtWGxGU2VOVUtIaU1GR1pT?=
 =?utf-8?B?eXN5S3IyTnZ4TXNnQWhVdDdEM0t4UGpCRHR5dFowMVVkRHpTQUt4U3RqOUQ1?=
 =?utf-8?B?Q2x3b2QvOTJYZ0RiR3drTzJUSWxaelVrOW9QMlFnZ253N1l0aVZpL1dCbXdP?=
 =?utf-8?B?bi9EbFgrL1Z6LzdKVkw3ZndiUzg0ZnF5eXZXVUxzdk9ybUNpWTdKekJST3B1?=
 =?utf-8?B?Q21Da0dYeTQwOGt1NTI5S2VvdThzK0pxQkw5aWtKNjZMdEhzdGg2dHhDMGxp?=
 =?utf-8?B?UktLN1Yvc0h3RG80dTI1UU5mMzhFcWlPWUhyblpRRklFYnBGRWd1eXZUZlow?=
 =?utf-8?B?aFJ2WWNWMW1jNHNvN0Znc25uY1M4Tnk1TkdXU05GN2pGbW1NdWlQTVg5ZEJL?=
 =?utf-8?B?NExDeklUMFZTNFVORFpPTUtFaHBiZkIvR1p1OEREbktzbnBpcnJJR0NrS0l6?=
 =?utf-8?B?Z0xvTVVkei9lNzlmcmtzMjNvaFVFUG5xWWYxd1dhR29XRHg1dGEwZUY5K1Js?=
 =?utf-8?B?eXJ4OCsvOXZISm1MaFBMcHB5WWZwRVBQVExKTXQ2bTZRclpRWFprck5UT3ZJ?=
 =?utf-8?B?eEZoWmduZ21pMjE5dXk3TU9vb2pXaDBUVTZyQ0dlMTZQdjVlRHdnWFFDRkEr?=
 =?utf-8?B?c3lLVXhkdjhNTGZJb1E1ZkZEcVg2SE9lWXFuUm1GVVd1dVI4MVB1bzFuRHFE?=
 =?utf-8?B?UC9wYms1NmRaZnMzaTBlSDMyeWxua2paTWYza1phaGVRdDRwZFlHeGUwMFBu?=
 =?utf-8?B?UWNpVDVoa2VyOGthdGFlbUFtNTZMQktMVXE4ZHBrbjByaHRwSS9ybDhwZjFB?=
 =?utf-8?B?WEh6K3RsZS9OVTJmVkpDMjQydGdycHd5QzVJWUtUZXg3SlNoeExTWjNWZDVy?=
 =?utf-8?B?NDUxNm84UHZqNmRSa1hxeVBVQXVQQ0h0NnNsNmJVeW1VM0xValFvUko2VXBO?=
 =?utf-8?B?amFnd2s5SnY3clRUMnI1aWVlb3RTNHlITi9HakFCTmZ5OWV5OTN2UGNQUVBl?=
 =?utf-8?B?K2FXTWlFR0tYQ3RUbU5ueCs5R1R2dE1majRFNVp4NmFYNXdCS21yQUdKYnBK?=
 =?utf-8?B?Q0FxR1JDdTRqbGsxeWRsN25XSSt3aitZTkxNTmRoT2l4ZE54ekFoVDFMNmtk?=
 =?utf-8?Q?Jepzfnk5vaxbLwhnAT/NMHz84?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167f641d-dfe3-4ffe-eb91-08ddfbb32e97
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 21:41:55.7636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFNONICVNzksNNCQ42A5rZGa4Wud7XKEdZ2FH1YQdJ5T6s0SNoxWeZFfQoQ2beYE4xbwEjl6PTyiC3Ga6vZBJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
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

On 2025-09-23 03:26, Zhu Lingshan wrote:
> This commit remove DIQ support because it has been
> marked as DEPRECATED since 2022 in commit 5bdd3eb2
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 29 +-------------
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 39 +------------------
>   6 files changed, 6 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6c5c7c1bf5ed..ac6052d7a4cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
>   				  struct queue *q)
>   {
>   	dqm->active_queue_count++;
> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>   		dqm->active_cp_queue_count++;
>   
>   	if (q->properties.is_gws) {
> @@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
>   				  struct queue *q)
>   {
>   	dqm->active_queue_count--;
> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>   		dqm->active_cp_queue_count--;
>   
>   	if (q->properties.is_gws) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 2b0a830f5b29..4c7ab7a711be 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>   	int retval;
>   	union PM4_MES_TYPE_3_HEADER nop;
>   
> -	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
> +	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
>   		return false;
>   
>   	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
> @@ -61,17 +61,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>   
>   	kq->dev = dev;
>   	kq->nop_packet = nop.u32all;
> -	switch (type) {
> -	case KFD_QUEUE_TYPE_DIQ:
> -		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_DIQ];
> -		break;
> -	case KFD_QUEUE_TYPE_HIQ:
> -		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
> -		break;
> -	default:
> -		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
> -		return false;
> -	}
> +	kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>   
>   	if (!kq->mqd_mgr)
>   		return false;
> @@ -162,24 +152,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>   		kq->mqd_mgr->load_mqd(kq->mqd_mgr, kq->queue->mqd,
>   				kq->queue->pipe, kq->queue->queue,
>   				&kq->queue->properties, NULL);
> -	} else {
> -		/* allocate fence for DIQ */
> -
> -		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
> -						&kq->fence_mem_obj);
> -
> -		if (retval != 0)
> -			goto err_alloc_fence;
> -
> -		kq->fence_kernel_address = kq->fence_mem_obj->cpu_ptr;
> -		kq->fence_gpu_addr = kq->fence_mem_obj->gpu_addr;
>   	}
>   
>   	print_queue(kq->queue);
>   
>   	return true;
> -err_alloc_fence:
> -	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd, kq->queue->mqd_mem_obj);
>   err_allocate_mqd:
>   	uninit_queue(kq->queue);
>   err_init_queue:
> @@ -209,8 +186,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
>   					kq->queue->queue);
>   		up_read(&kq->dev->adev->reset_domain->sem);
>   	}
> -	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
> -		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
>   
>   	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd,
>   				kq->queue->mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 505036968a77..3d2375817c3e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   			packet->bitfields2.queue_type =
>   		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>   		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		packet->bitfields2.queue_type =
> -			queue_type__mes_map_queues__debug_interface_queue_vi;
> -		break;
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
>   		if (q->properties.sdma_engine_id < 2 &&
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index a1de5d7e173a..60086e7cc258 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>   			packet->bitfields2.queue_type =
>   		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>   		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		packet->bitfields2.queue_type =
> -			queue_type__mes_map_queues__debug_interface_queue_vi;
> -		break;
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
>   		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d140463e221b..a2f8b1c24fc3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -425,7 +425,6 @@ enum kfd_queue_type  {
>   	KFD_QUEUE_TYPE_COMPUTE,
>   	KFD_QUEUE_TYPE_SDMA,
>   	KFD_QUEUE_TYPE_HIQ,
> -	KFD_QUEUE_TYPE_DIQ,
>   	KFD_QUEUE_TYPE_SDMA_XGMI,
>   	KFD_QUEUE_TYPE_SDMA_BY_ENG_ID
>   };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 7fbb5c274ccc..8ddc33abf230 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   	 * If we are just about to create DIQ, the is_debug flag is not set yet
>   	 * Hence we also check the type as well
>   	 */
> -	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
> +	if ((pdd->qpd.is_debug))
>   		max_queues = dev->kfd->device_info.max_no_of_hqd/2;
>   
>   	if (pdd->qpd.queue_count >= max_queues)
> @@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   						    restore_mqd, restore_ctl_stack);
>   		print_queue(q);
>   		break;
> -	case KFD_QUEUE_TYPE_DIQ:
> -		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
> -		if (!kq) {
> -			retval = -ENOMEM;
> -			goto err_create_queue;
> -		}
> -		kq->queue->properties.queue_id = *qid;
> -		pqn->kq = kq;
> -		pqn->q = NULL;
> -		retval = kfd_process_drain_interrupts(pdd);
> -		if (retval)
> -			break;
> -
> -		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
> -							kq, &pdd->qpd);
> -		break;
>   	default:
>   		WARN(1, "Invalid queue type %d", type);
>   		retval = -EINVAL;
> @@ -1131,32 +1115,13 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
>   				break;
>   			default:
>   				seq_printf(m,
> -				"  Bad user queue type %d on device %x\n",
> +				"  Qeueu node with bad user queue type %d on device %x\n",
>   					   q->properties.type, q->device->id);
>   				continue;
>   			}
>   			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
>   			size = mqd_mgr->mqd_stride(mqd_mgr,
>   							&q->properties);
> -		} else if (pqn->kq) {
> -			q = pqn->kq->queue;
> -			mqd_mgr = pqn->kq->mqd_mgr;
> -			switch (q->properties.type) {
> -			case KFD_QUEUE_TYPE_DIQ:
> -				seq_printf(m, "  DIQ on device %x\n",
> -					   pqn->kq->dev->id);
> -				break;
> -			default:
> -				seq_printf(m,
> -				"  Bad kernel queue type %d on device %x\n",
> -					   q->properties.type,
> -					   pqn->kq->dev->id);
> -				continue;
> -			}
> -		} else {
> -			seq_printf(m,
> -		"  Weird: Queue node with neither kernel nor user queue\n");
> -			continue;
>   		}
>   
>   		for (xcc = 0; xcc < num_xccs; xcc++) {
