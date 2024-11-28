Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5B4D6D24D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 00:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722F310E434;
	Thu, 28 Nov 2024 00:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zvxHY0If";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466F710E434
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 00:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FU1j/EcyiKM1d6DNJ0ZuxHC44m9OsaQd1zcMcoIaksSIZpvSJByYS6aOFyW5EH88jzCYWesxZEIXEC4aJVnnwY3tR/03V9HpcOilNu91VZaGQYCvuQgb4nHnSDVwYue+pXE2X4h05BIxGYlu3oPeYhhprUWGzwNiCk1KIzvrhckPQJ3CnlCcO+URurAXdhxSxzyjn6iHRwQMbutr0/LCURGfiSWzNK6Sj9Pv94eqxrRBWslrcK7dv5o1rzvfN3t/+icbupJCuSQTnOU2NgID+64crlubUm4yGC60msXU/pdrl1sfPwebBQOfD4zbOXLEda0twWbHahU7AxPV2ETQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hepAS/43uHgYPFMRB1/IBFBkKA4GDEdeoM0oYiQdqMk=;
 b=iHm5VdZ094dV8HT6gLQZwYgG6v2pPxCtvjQD8hlcMAqee9Lq00UG2qgrBxHypR6tOFgPTo06eTSTeLe4QKO0osssXcuKGTpi9EqkQ2pwQ29QN29LsFZzhAo0bhCcd/zh+XGJzNiIzFJOG8K3CFwD+VcQY9l4O0vYDRDVuMMgtBC/RIbSiSBNgFbwmvWxkkHv/el0uf6zJ3RHgFyFYOH1cPjwUWBlDXNtd1izXy63G9qJZdvDVbgLCY7a4WInkkO0O/vp/4Hg+r2C904REY/n/MbP5hzqlozLV+OsuCpdMYa05UYOnZdLSp1HdPXyZpm4YfxA5V7rZW9bH42hhL31RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hepAS/43uHgYPFMRB1/IBFBkKA4GDEdeoM0oYiQdqMk=;
 b=zvxHY0If65qtPV2PH3x/7zduSWBcgy7jKs63l80RReyGZ81d67TLnkl0iNSADRN0PDeooEdyJQDGJdkZ62oq+KLxbpiVvL9TcdTwXynZncttEWc6U3Zm8r+ljn3ejdGYTtLks9eia7HAzzAXuDIfFO6F9SXciak8SMKE7e2YspI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Thu, 28 Nov
 2024 00:13:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 00:13:48 +0000
Message-ID: <7fb86a69-aa43-41fc-90e9-4750c84a3a89@amd.com>
Date: Wed, 27 Nov 2024 19:13:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Use the correct wptr size
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, mukul.joshi@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20241118053434.3382003-1-lijo.lazar@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241118053434.3382003-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 136c3f11-df03-463b-ee1e-08dd0f41881f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFN3NGdQR0lUc0taZVA4SFJ4QURqbGZ6RWdXWnRZQXlqaC9hckVucllvVm5a?=
 =?utf-8?B?VUZmQVBSUXhXdHkvQjlXZzBReG5PQTJRODUxT0sxR2NHNXowOWRGamVibitN?=
 =?utf-8?B?cit5dlpYNFBCNzJVeEd4eE5wM1FLR2cyMzVZakViQXV5SnNmSENIV3RSRkVo?=
 =?utf-8?B?T3U4TUFFTGZPVDVDTk5CUmN3TG1BUEtNOGZSTzlwY2FsRXhXOGEzUW9sREVN?=
 =?utf-8?B?cS9GYmxZbnZDdlFWZkVDUk5KcTZ4MVN2ZFNCZ0hMMlQvaFNUb2MyWVFuaWRh?=
 =?utf-8?B?dWNhNUs4VGxvK3BmeFFWa3dtbjdVeHJUT0kzQTEvRjE1YjBPbzFuNlBvWjVm?=
 =?utf-8?B?UXJUZTNrZ3VuRDNkYWlOL2JWeGVERy9RZllraFlTOTFRZTRSclVSSUFyNUdM?=
 =?utf-8?B?dlNOUmxhL1dmRjN0TjR5aHNFYWtaUDJieUcvTG52R3JJZk10TmxmK1huMENC?=
 =?utf-8?B?UHhrdnU4RGcwTDlYdmFGdm1aeEQvUmVMckwrY3gzVDRXNEtScXM1V0l1dlo0?=
 =?utf-8?B?SnY1eHdjaW1GK3F3RkVhb0xVbC9pUzA0NWljTnVuMXY0OEVXZUh6M1RDUERR?=
 =?utf-8?B?WkZPTk5pcDUrY1d2NFVxa1NmNU5ua1FnajFTb1ZjZ1JLeWNpMllCYVE1WGhq?=
 =?utf-8?B?dk5NRURqeEp3UTRvdXhWb0FDQXIrMCtnTmUvMXlkOXJlNVlzalNVVVpMR25F?=
 =?utf-8?B?VXRrcFozOGFkTDZSRXNMWEF6U1NEYk83VXBwcmJoeHRlVnVQUEo1dWNlbk9l?=
 =?utf-8?B?TGxQMWpPZmFQS2txdEhORHE5a2N3bURWeUJsNUFGc0lJUStoL0pvcUhUbXBK?=
 =?utf-8?B?dDZjUis2Szh6am95YXNVWVlNaWpyS3crYVNXc0tHRFpETjRYNUFaQkc2dGp1?=
 =?utf-8?B?ZEtzM3dTWVo1REdTSFpTdXc0Vy9oUGJmYklSbjIrTlFpMzVMeFJrNXQwWHFw?=
 =?utf-8?B?Z3BJSlVpVWYxQzlXUERUNWJhcjZ6MU5CY09XUThsVkJFbStSMks3dEtBZTA5?=
 =?utf-8?B?U0dzS3lwSm5TNEdoMDJ3MmtUcjB4bDhiODFvdi9pTWV4WEJsV1VLNjBMZEZ5?=
 =?utf-8?B?T09oTnBCMzdBWkk2WklUQmFQU0Y1Q24zU25CZUFsQThyZ3lqSjJuOGoyaEpM?=
 =?utf-8?B?VFp2UG4zSVQxRnREOFRwb0tXNGlHZTBSOVVjbWx1anlQK05tcHc3MEx0aUNW?=
 =?utf-8?B?ZnUwbktKLzhpbDNLTFRGUVM1bGtMZFJYTTBwRUxvNlVXWmY3ZmI4VER4MVRn?=
 =?utf-8?B?RVE2WHhXTFBnZ002MzdPcm5Hc1l1aUxha216YXFGN0dyWGtud1grbERibTg2?=
 =?utf-8?B?UXFna2U4ZnBKbWFFZDh2UktOYTdIMGpKbDUrSlFmdWZzS3lRQ0tyWjQ4akxO?=
 =?utf-8?B?d3orRDZ2ZFlYUnZLRmM1ZkNkTk9zSnRLb1pjbld6cy9FSXBxc3VwT3FRT2Fj?=
 =?utf-8?B?NElETFBvSjdGRG93OER2TVRISVpmUzZXclZtNjJqWkxJYTNQb0FEL1lVV3F3?=
 =?utf-8?B?bk1ma2FTOTlMbkJLYUFtMzVRdWF2QWhQckRxZmxNaHl2b3g3c01QVWdxakpU?=
 =?utf-8?B?Tno5R2tQOEZrU1FicmZoYXBXOStwVGMxb1FlUzdqZklTbzVRcnhodStUK3h2?=
 =?utf-8?B?WXRGem0xaWZkK3FtSGN4V2E1WEpXSHZHOFI5S2pXRDY3TGYvWlZyTmpvb0VV?=
 =?utf-8?B?SUVVWm84RGxZSjRzQkN2Nmd4aVp4WDRpdXdiTlNOWm9xM0ZLSTFONzJ3QXk0?=
 =?utf-8?B?eHhuQ3pUY2FGeDMrTC9sTk45ZENnTy9xOGFndFNTbDhMMm5FdkhIR0RMcWpi?=
 =?utf-8?B?RUpDcENSQjdsWXIrMDB5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlULzBhTW1mRk1kQ2tPOTlBR0hFNW5tWHRTTWxTZzBNalFDeG8xZmFFU3Ny?=
 =?utf-8?B?WWh4Y1hWS3FDZyt0eTl1TnBrU2FoNFV4YlhVdHV1ckVqVmMzZW9SNnZ4dGFM?=
 =?utf-8?B?TThiQkp0K0ZDaGpheFdoNGVrclFzQUpyS1k4V3c5NDkzUkhhVUI2a25acEQy?=
 =?utf-8?B?NWl1citRWnN2aEk1aXZIVy9NMkZ0RFFoUkxILzJlTloxL0ZTSXU1T1daMjVH?=
 =?utf-8?B?NWNvSmEySkRpY3d3Ujh6cmpTeFA2TTB3SXcyYnlxR1p0d1o0TkFhRk1vdXZm?=
 =?utf-8?B?ZTdyb0hta2N2bUErN2t6QWZ3SWEzcVlpMndpT1ZKMEFMVXM3ME1vYlZxbUpE?=
 =?utf-8?B?Z1JvYm8yQ2VvcmJKTCtUV2NVSk9JaWNMOUtvcEdaMVFiRlJ3THpRN1Riais0?=
 =?utf-8?B?eVI1a1ZaejBZVmJyanhkbVN2bm1sZHdPKzZkTGE2MlU5a1NaU1EvVE1tbTls?=
 =?utf-8?B?U1hISlZKQ1F1THluRUthSEl1OU9OUGx2T2ZiS09lREloZnp5cGIwd25mWjJv?=
 =?utf-8?B?QkJxMFVldmVkaXJuc2s3b3NOUENUMi8wcjRoSkh6TW15TEI0Nk5zMHFIaCt1?=
 =?utf-8?B?NHJrSkEvbnRBVjQ4UW5Hazd2ckgrdllZdFg2YkV6dEZIYkdnOFZSa0RIODFl?=
 =?utf-8?B?Ujg3d1NXcnJCTVdla09odENXME1xVVlNOXZMcVZDOWhFeXo4RlVVcFhLcDRS?=
 =?utf-8?B?dUFxSFZkNVFURGFVT0thUEdiaVRUMWJEbnJaU1gydFJuOUg3eENRa3JVUkEr?=
 =?utf-8?B?SUptV1FZc1B4Yk9JWVBVTDJsSlV2bFM4UStIczM5b2VWUEMza3duazgyNFgx?=
 =?utf-8?B?cGdqZ0V0N0xGb2RVK1JsSHRUeHQreElzNnUzdFRKNUVCVUk2dzhla2xMYkpx?=
 =?utf-8?B?Vm56VXpFWG5tY2RkMCt4Mk8vNE9vbDdwdXY5WERmeE1xZVBxckF3bUtlQ0J4?=
 =?utf-8?B?R2tqUjlSUXB1WUpJQmswaHhldnprN0JpVEhId2w3SVJPRUQ3MFY4T2VHclBp?=
 =?utf-8?B?aFFTZWRXMlA4Y0VJdTIzbnFGYzVFOE5aeTVtNGluSFVDb1pqQUxmMnBFSCtk?=
 =?utf-8?B?YnF0U2ZUb0JGNnBOekw3S1BLdXltU0d0V20zRUtrTldRSGxtekNpS0RITTF3?=
 =?utf-8?B?K293bHQwVkxjU3N3ajJDUVRlUFU5elVVbG1EVk95VWNTZ0QxMVBvNGVZeUhv?=
 =?utf-8?B?M2lNZnpOR1pETWpMTzhvRHp6UU9xQWxCT3pLcHVFSjEwYlVjVkFtc21LR0lS?=
 =?utf-8?B?cnlOamJBTnIyWWxVRWw2djdjTHZtTjRFYUtKZ2NBU2c1ZkpESVpKeXVxMzA0?=
 =?utf-8?B?OFNkMmNQZFhDWERtT2oyYTFqd1l1QzNQelpnY0RFWkFnN25pSnlRVk5nRkpJ?=
 =?utf-8?B?Wmc3NVR4bHhONU5KRnIvRFdEQk45OUZ2MjNMYzJYbGFCTE15cXhBWGo2VzFj?=
 =?utf-8?B?bzhvMXhsQjhjSkxCMHZDbGV1M0ZqSk4rMEUvcWgyRG1JVUpvVnlERkkwTTFQ?=
 =?utf-8?B?RlhWUEp6QXRFMXhwN0d3K21yTERkS2UxSzdxTjArYlpBRmgvWUEzbU5QRGo1?=
 =?utf-8?B?Q25UMDR0Y2dsM21UUUhUTjQzU1M2U3R6bDV2SWRMSUVSQTdPNVNidDU3L2Fz?=
 =?utf-8?B?MzJ4N0Zmc243WEE2bWFCWlFNTUpwUDdmeEhWU3VEQytNZVhwRkppd0FOcDE0?=
 =?utf-8?B?WERYV2FRRWdsUzNjT0l4WGpzVGRDZFhhZTY5MFJEYnBHWGlUNzNlendYNGU1?=
 =?utf-8?B?Nmx3bDc2RnkydG1JTGJTUURUWmVOM294R1lVbGFBbjMveEQyMW1wRGRzQlU0?=
 =?utf-8?B?bU1ldnZjbzI2RlZzUHhFR1BxTmlLTnFPVlplMGdKSFNqdUhyWTQyVVF0V1VY?=
 =?utf-8?B?czEzTlZZcDJ3MjFXblYyVitNa2tEQTlhR3g3U1lWUVVrOEE2SS8xNVRVK0sz?=
 =?utf-8?B?cUlYN2JFVy9DNDhJZEc2d1BFTFFEWlRWV3JHVEZuR3lkWHhjWEVEK2M2TjFY?=
 =?utf-8?B?K1J2ZUpvak8zSzljWFJIQnZ0UUYvb2lLNWU1QUtzQWdPU3AvSS9WZlZkNVVZ?=
 =?utf-8?B?b0VoZG81WkVLSGJTTndXWGdhZzAxb0xBYzh1SlNCYy8xR1Rma0pDbzJtaGxX?=
 =?utf-8?Q?lsCDsNd6QW9yAh3BNYgH78ZuA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136c3f11-df03-463b-ee1e-08dd0f41881f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 00:13:48.8993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFiYmelknt54agoPpA2bgyUGcyyHmOFWn2ti6Ya608nCND3GxMoGrAMWspmSSKwDCBDgj9VORnrOexACuaML2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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


On 2024-11-18 00:34, Lijo Lazar wrote:
> Write pointer could be 32-bit or 64-bit. Use the correct size during
> initialization.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 4843dcb9a5f7..d6037577c532 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -125,7 +125,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>   
>   	memset(kq->pq_kernel_addr, 0, queue_size);
>   	memset(kq->rptr_kernel, 0, sizeof(*kq->rptr_kernel));
> -	memset(kq->wptr_kernel, 0, sizeof(*kq->wptr_kernel));
> +	memset(kq->wptr_kernel, 0, dev->kfd->device_info.doorbell_size);

It would be safer and cleaner to just initialize kq->wptr64_kernel, 
which is always 64 bit and aliases kq->wptr_kernel.

Regards,
   Felix



>   
>   	prop.queue_size = queue_size;
>   	prop.is_interop = false;
