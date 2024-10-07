Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C96DCFB43F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 13:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E651E10E399;
	Mon,  7 Oct 2024 13:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OXk3DORP";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5038B10E399
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 13:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwZ+6xttIa/Q1F9Dh34+HrIFiQuSSJulwVDP2OCfUhQoGxz6B1p7QTG1lqrA4paoGtZ0OYU8mLwPEJdpNtT5OfLOb/KfZtYDILNd208tjPPzgENv1qHcbFzP77VmPxAcOzId6teN07XC/bRCM3v3xdjeAL6TEin8RC7aYnm2/DPTs32XdZ3KYSAwJ6b/0bAJOkImYzOxDXmrLky30xEcWRHCJDu1oO0FkYwzuxO7Oqu06lrr39cJbJXm4zUo0ZrwK7Rjhs1LFAmt+LFDIilXlqTLjVTcox+xA/oQyWFA0wWLFcxqz8XUN+deqUJRemO/3etzhnCXsHP4MDbU9N+K3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAqw2KKJfRbn3KgvqSqERWpqInIkEHEU5FS3f/XCdqw=;
 b=KapQbrw9CncnO/8rBfR56FF4nMclJMmXc2oaf7vdCxt/L4FPnGdg2KhEcy56pfNIzyFHU4e6zCsgYwH3c8fLam6tjlyAV0KvBE1a0XirmdPHueljkv8FyE72vHsvCw6Fa7u1doJzy54A1qYVVdCpF3qW2PM17nsa9d9W+Jw6arkQ31nOYIbdqYN8PB6bVR/01KedW++ted5zJkMFljl50aed+g+Jir4gIVOfgfpzRVqAZcfIDMIgwD/ugaUsw4PRlOlGhCbmORvFLpAXO/JO7u2Nf9WNWlB2jAGgjxTzn3vaOxMR83bB/f4B2ipUfw281puSy19tUWKmfIk+tvfcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAqw2KKJfRbn3KgvqSqERWpqInIkEHEU5FS3f/XCdqw=;
 b=OXk3DORPwiUSZGihvl4ymRzNylm0auzM8X3uZPvvJmPeWF/qGCguE+WbWxkXosZO/01LSkcEF1AgmCFdnwXO4DX5I+OQ2MDcrT8913UrZagF9B0KwEYZyteW2jqdPiO9GWQ3NEPBdy+rdR6TzRmbBMEhZ4yoiWCEMC15ZEPfaAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:46:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:46:44 +0000
Message-ID: <ae1b1b61-9cf2-4fbd-a48a-a1171981c249@amd.com>
Date: Mon, 7 Oct 2024 15:46:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: no need to log error in multi ring write
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241003081306.235253-1-sunil.khatri@amd.com>
 <20241003081306.235253-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241003081306.235253-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faf58ff-d104-40ca-a03f-08dce6d67b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUY4MkNxM2Y1emZyMzlkSzZPejdkOWViM3pMVmRmcnJKYXJidTlIWS9mbDRK?=
 =?utf-8?B?Yi9WbElydUxRY3c0K2owUURRMW9kYVNkZVc5RzZDa1BRTGRpRkJMVEMxMDVn?=
 =?utf-8?B?cUx3dFlzTDZtdFVKRkxyOU8rVzRLOHRhcDRWalUxT1pYdS9qMUU4UEsza2pN?=
 =?utf-8?B?b3RKNk41WEU0c3BSdlJkZVlOVEVtRTh0YmI1VUQwUzdsQVAxa29MRTM1M2Zu?=
 =?utf-8?B?bkN0dlY3SkdPWjByL1pSWlRpRElacWJCbGNhUG14VUthTEpsYnNsc0IrbUFL?=
 =?utf-8?B?TVVPOWRvWVBrSko0djRlU1ZlTHZMQlNxUzdmcnZpeWlCLzlZdGJHUmhMTDZi?=
 =?utf-8?B?K25pdERVRXZMRTg5emxCNHU3SWdDejZNc0VIRlJwQWtsdVRJNlNnRHVGQk1N?=
 =?utf-8?B?Z3V3ZGVyR3hrRDhPTnh6WDdadjdSK1U2ZU5FeTQrU3ZqdWtoRW45Y3ZTcUpT?=
 =?utf-8?B?VUQvb0ErWENndzB2dElpNnl6V1dLOEVsOVZuNmxYMEhmUlN3a21hbmtHR2p4?=
 =?utf-8?B?dVlRUzVncG9NT0c0V1BtanVSenlWaXUrMlFUOGhRRUxXNGFEV2hhTmlXS0lT?=
 =?utf-8?B?ZUJuOTB3LzB1SHhFZm56aE12SGNxRldPQXRQaWNTVzdVVHdVL3pnUWNVUFoz?=
 =?utf-8?B?c1IydDdzZlZBK20rU2tFWCtJcXlQZ0s3TDZIdk1WL3Z0RzZGV2hmQUVTWkhE?=
 =?utf-8?B?b3ZocGZ0OFNmbENGWm1oSUpWWmVaU3FCYmk5KzVLV2RlekJ4b20rZFJJMHRu?=
 =?utf-8?B?bGk4am5RWWdndHdoL3ZtYlk2U2JHVE9sVEJydXBNQm45ci9TVGZlbldieXdv?=
 =?utf-8?B?N0tORmkwRmx1c013N3BsWXhycUpkd0wvZlEyanNmUkZJdkNXZVFtclpNQk9v?=
 =?utf-8?B?OGpEUEhkLzczUjJiNnBxSWlJV0M0Zll0UitaZUMrSHRmWHpCSFBOK21xSHRS?=
 =?utf-8?B?b3U5dUtCdm5qOVV1c05iMS9LTTFES1IrOTRNUGlUQ24yb3BmV0xDYVRnUkJ5?=
 =?utf-8?B?Tms0eUpzU3I1NFYvZWhzWlk2YkN6REN0cFhodWFqMWovTmFoUVVRTHNKc0Fh?=
 =?utf-8?B?NnhZVFhmMXJFK1NwUnBJbTUrSXpwdW5VaU1nU3NaVkpIcmRNT0Q1MUp0SEZT?=
 =?utf-8?B?OWdpL1BNREF6dWx3UXNleUEyNXlMaTJvTXlUUVJibXo3azZHelZSemhtYXBZ?=
 =?utf-8?B?RmJudERncDRtaGovRjJvMTdQdXlSa1AyNTJRUjF5WlBlREs5ZWE5S1kvK2Nl?=
 =?utf-8?B?VjYwbXB0TXpzL2VqbE1QUTNJZDFkZ05GeEpkTVF2VnF6eitIOHlqU1NWYnI0?=
 =?utf-8?B?UEVzMnpJSzFUdzdxK09BYUVhMU9ja1V4czMzRCsxbmhqZ25rcHNiMGVHYVZY?=
 =?utf-8?B?SkE3MVQ3bGNiRDJ6N3pheGhhUXkzYlYzODN5Qll1QzhFSkUxcUdFWHZKVEVM?=
 =?utf-8?B?MDdlUkF5c1d4L3BjZUVBOEhVVmRBTXNQS0JOdHhob3NScTZjeS90T0o0dVNT?=
 =?utf-8?B?eXByQW11c3I3VUMwOU9BRENaVy9VUlVPSjNKUXdEZXFNenFIazI1SVEyMVNF?=
 =?utf-8?B?dWtBTUp2SDVaOU9seUhQc2ZjUjJGT0l6QmZJdUsrVmdXVFBPRXNuOU1ZbzRz?=
 =?utf-8?B?eE9RSVV5aVVPbTNJT0VHMG9nV3RwL2RMSTVwSFYzSHlHZXkxenpad0pydzZC?=
 =?utf-8?B?YlREbVk1U1prUXZHT2ZiamRXbzNCWGtacHZFTFBVU2I2NWdIdHNnNE5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzBoTzhwemJ1WmFQczIzY1grRElkWmszQ1lxaHB6V214Y3B5MnlDKzQrTk5D?=
 =?utf-8?B?QllyMEZvdFJ5b0VOdHFJUjNCQWFWZnhzc2NVL1laaVBvdHV0eWs0VHd5QzZJ?=
 =?utf-8?B?MGNCdy9JMlpZWGN1N3VxVkc1ZUg3bUtpYTdMNk1LYVZDamVBVEFubW0zOWpH?=
 =?utf-8?B?WHBibGJtS3hjUVZwWVdWTVVtVFdtdFU1S3ZmQXFXdmJYS2FidU9Ndll1Wnhv?=
 =?utf-8?B?UGVzcTduY3Z4cXo2VGg0YndydjJacGtnTFFlQ3pIaTZZL2pPVXZrOWdIb1Ax?=
 =?utf-8?B?UGd2N29XdGcrVXlsTlZKdW80OW94SkZ2ajlEYXVNS3l4U3VxMHBZTVkyK0JX?=
 =?utf-8?B?NjFSMm9PR1FGa2F6VVJPQm52V3F2T2lPeGtTZGlobzJFYXZ0Yk1qS0RrVG1N?=
 =?utf-8?B?UjJiNXJ3R1IwTkR1azlvV2N6R3dYOWNreXNRYm5Vb3BjV2NMYUtsUTF1cGdV?=
 =?utf-8?B?NzlNR0RyVUtNWVN5VDN6UVR6OVNiWTJGemJQUXBybTRITDRLYnNSQ0xLNzhv?=
 =?utf-8?B?K2VtWUpvZVZ2QTJKa0N0d3MxMW9SQmNXNTd3TW5RNEZBcFpERi9OUXg5UE9W?=
 =?utf-8?B?amNqelNJbTcrRmNKTVlhcCtGQTlhMm03VW9DajMydVJPZmZpU1I0cHZDSXpI?=
 =?utf-8?B?VkZrNFBudndQNmNXNWhJdlVJYkJabjhlU3E4TUIzWlJxSml6ViswWUd2UCtG?=
 =?utf-8?B?N1pTRGdFOTFSemNBcnN2VWVVMHRUN042SUdjeEV5d1Q5bmQrb2VkQWhUSnZj?=
 =?utf-8?B?WFROWW9NWndnWEhPWDVpVlVUN3JDQVZHS09xY3lxWXhSN3QvZVE0MDZrUTBr?=
 =?utf-8?B?T1FhcVd5ekVEZ2tZNWxIT0ZueVlWQzQrRi9xc3VJcmNGSVlkWFZRcTJJV3Mv?=
 =?utf-8?B?Y3ZienROZHlaRWZkaStJRXNBeVhSTUsvZE5SWmJMeXA4ZUptMU5RSFpsdGk4?=
 =?utf-8?B?NUJrb2NQRlJ2VmpHMkR6RytJUy9wUjhSTzFXSnRjc0M1TEorc2FIVXpYRjBU?=
 =?utf-8?B?dkpOdWFUc2VTM2Y1amN4NUpXRWMyUGZZU2x5UHlsMDB3QlYvOTJBeit2NWdP?=
 =?utf-8?B?OWozK0dLc0cvRDdKdG0xa2dZc0FVcGNmNHZOMTFyOFZsTk1POUJNNmUySUhQ?=
 =?utf-8?B?d3ZuMG9pK1B4MmRIdGs1OEp4WHBSVnZpdVpublRiTEtvWVEzOEhMZ1B0VFdK?=
 =?utf-8?B?S0VCZkNLQ2Y4SGcyRDBhbmFFbkpjNnorUFVCL0hnckNwck1XOHJJQlhBZnA0?=
 =?utf-8?B?ajVGYVJ5MjFkVXhPOXdVRkNuWWNpM2M2MXpoL2hFUVNkRlFkMGN2TG5pZlJa?=
 =?utf-8?B?WjZmMlZPZnloV1JXN0E1SzFOYjhLTkZoQUFWV2c4cXhPODFVcFp4U3FOUmxq?=
 =?utf-8?B?bkh6MSt0Nng2MVd5TjlmZGd0dFB2SFJodDliQkxycUpZMlZRRDhhc3VYRkhB?=
 =?utf-8?B?UU1HSmF3S1VJMis0MG5ZRDNEcGNLc2FLbG53OXNqV3Z6aHRLa1hiYkNXQW82?=
 =?utf-8?B?TkFaOWEzclVqbFZVZ0hVc0UybFR3NFNiTjZtZmFieUZGWDZzOTdPdUhOSlBM?=
 =?utf-8?B?WWtwaW9SczFWYUpadVF4VjRqdkhOcEN0MHVqUXBCcEd3cXRNS0hJNkREWW1q?=
 =?utf-8?B?Ly9VM3JqZDB4TEZpdmZBUkM2aXpLalFXVDRKVUVjK1o2b29TUUt6Z2VOc2pE?=
 =?utf-8?B?RTJrWS9wMVVDOGNmVWhWcy91SGtPSDZYSmJYT09kL2lrcjQ0WFJxTW1wZlJ1?=
 =?utf-8?B?RXU2R2srOGQ3TFZTTkFnblBSYmhpeFQ1MGdXTG5ValpuTkJKQWxDR3dJSVI4?=
 =?utf-8?B?V1p1UmdmNXN0YnA5b2cxQS9MNnNMM1hyM3Uxc2IrUFkranBiMDkwNXdrSFp3?=
 =?utf-8?B?WXUzMUZCa29sbEVtdGNNZW9mc01QbktFeXhLdnpVUk9sK1hqS0VxR0ZUTGI5?=
 =?utf-8?B?aVd2M2M3REwzZEdlcUlvbEM5M1RpWDZBWmx4UDBwT2hKT05NZENrbmtJWGhG?=
 =?utf-8?B?RkZZTDZkNlpFNFQ5VE1nUWNOZFQ2U1pud0o1blg3ekd4anNqN1I1T0lDdGh6?=
 =?utf-8?B?KzVHdGZ2N3dPMDNWalNWZnorT3h5Q0syY1FZRXpUZjBzT1h3TEU0WDd2VVBt?=
 =?utf-8?Q?TgpszQzuCNKJgoGEECjVjQEig?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faf58ff-d104-40ca-a03f-08dce6d67b31
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:46:44.6775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0TB8S1NC/Q+kdiizqV6rbFZULZgW60koaquYE2J+ONEatYfhmCJ6IoUqzXCpthg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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

Am 03.10.24 um 10:13 schrieb Sunil Khatri:
> No need to log error in multi ring write as its taken
> care during ring commit.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index af8824e8da49..574336d6714a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -388,9 +388,6 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>   	unsigned occupied, chunk1, chunk2;
>   	void *dst;
>   
> -	if (unlikely(ring->count_dw < count_dw))
> -		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
> -
>   	occupied = ring->wptr & ring->buf_mask;
>   	dst = (void *)&ring->ring[occupied];
>   	chunk1 = ring->buf_mask + 1 - occupied;

