Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E7DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 08:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A81C10FB94;
	Wed, 13 Apr 2022 08:15:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A214B10FB93
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 08:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H75c3mH8IA/aZXd7oaMAbBCLgWRUwe7ayVrUVRpwOdN/kx9gGgJHaU7NSCgqjC7SmyIgs67mt0V7TwwLJR1rZteis6Ii4OeaaaczdCV4DtElrETFFca52aTNLlNO2DCZsPJRh+ptOQ707RGyRtWbWpD+0M0sDDwwvkbf+QC56rYaKRQDj5bhhywNpxrLSdi6P8mre6R/IX+qPM8u4IkcW/cP/CUaAuwWARkkVq+0Y1f8vmco1axwgi/UeBwPlyIwYLDoflBnmCaPg/IVNnvUW9cfMgGq8UjmRgZ2A9eTfIaLdyXAZVTxZRkiXp20va4A9HGDiQVZcaf1HfkXzbow1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kstmul/LKOWDsLNPUKxWmtYZUJuhhd4nCNV61QxvAUg=;
 b=jcAZZGfLpx0PgtP574f6nfzSmFLDhNi9jBw5vhwOmiAQ2sSyPYB253tGtMq8bWEcRYpbAlSBnFNzzt3M7/sCr8M2Tb4FsxdQg05xPl5kXbZk33G2a9svj5bHhRKPrkf4/7wDwiEchCoVjq0u/UxjlCZB38g8hmW+DJI1BMbiwu73j6tbRCN/WSRsJ7o2hlilX4N1INbSy3+/pV0vi1PX3c0dlc78HHCyi51DIEndnXKhDuPHeGxKvBJB5j0EX84RPlweRn1CGSC6iCnzyspHjjAxeQXJJTxTbgbhyI2mwMufCMW6TXEn7YOFOumrbDkbvOdmO3NDKC7sKyWEMhdeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kstmul/LKOWDsLNPUKxWmtYZUJuhhd4nCNV61QxvAUg=;
 b=fAreCU3/xkZMRkBpEc64OHaRsYWznXi9jkBNw8GF1Q+k1A1beweFOlxzkRLCtfCCoPIF4CJWRlZq+ZI2mITWnBFcXw0rbKiup3TldhoT4G7qNrNb7HYfUgUP8RdKp0jpmk3jAIRLn2G2qSwhGQDW/dD6TFy1j/34Q/byhtEzHp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 08:15:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 08:15:00 +0000
Message-ID: <6e792fcb-76eb-9a85-1f8f-266249125f46@amd.com>
Date: Wed, 13 Apr 2022 10:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBNYWtlIHN1cmUg?=
 =?UTF-8?Q?ttm_delayed_work_finished?=
Content-Language: en-US
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220413030854.31724-1-xinhui.pan@amd.com>
 <BN8PR12MB3587639A4BC2C1B392DD2DFE83EC9@BN8PR12MB3587.namprd12.prod.outlook.com>
 <DM4PR12MB51650F2F831EF872FACA22E487EC9@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB51650F2F831EF872FACA22E487EC9@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P191CA0108.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::49) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97307373-6589-4489-7c3d-08da1d25b43e
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB23823723E4D5FD2470E28F4A83EC9@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uyn5gY3RM3f7sSq4SEjJKdUHinB5pIdJVZ8clQGirhJqCOfedERCQVuYWsr0N9iExUZQbq8NYSd9G4QIEoDW7xtU+CHESZIt3O4uuz697gnALTbTsVYR2sk7cr7fw5frN+IP5LhvLRlxhE4ZArzDDiCoMkl236TeNqQUaATFHqtEx5GQ9oqkljtPJ+T4de9lrOmL6gWO5frFbXLU8pNhAHld7Y07TaYrGIMug864ev6MngedJq4F7l5sO2afS/NwijJydhg3bFfV+Z96tQ1vFpTsIqhwj1QWzb2+X4ma7a19NNxrjpKstsR9cmzkZdD0lWhOeBFu+e+j+TSN98n/VgPRiupKpNHkKXRilqcNtLZmEsQ1JY822aOTBrSXpF8bv0crtJOEuQNqVQMxH9zHPpq0wceGw0P2475bypLWIXPdSxAJ5g3dABu/SLZVWGeTvjgbFDkwkpWQG3JMPp9yCr8OA2qogW2zOVQi/tZoREWZzMNjpJqcwDaT4FaZGkC9KVyOKyggXU+lDVcXGE6lUPcfzzifhSFFUcU9jNiFSIoNF66g/hZW/qxub8xdWQDeW3HDpX9gstwUuntADXb3wSuq5OL3wJ5+2tdgJMu9JXIojClx7fhDcauHwH7s7/s9sGag+xgN2HBN2owZumejxQ2KjDvwLZCuGxDqP9++17UzEPojeO9p/Rudf1m28UjgR/nt7+SA4r5KL6IqJnmw6q/oDWaW+di/bEWv1Ig0mkIM9XxKmoVUZ2GSCGbh/tps
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(5660300002)(31686004)(83380400001)(26005)(2906002)(2616005)(186003)(224303003)(4326008)(66556008)(86362001)(66476007)(6486002)(31696002)(6666004)(8936002)(110136005)(316002)(6512007)(6506007)(508600001)(38100700002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJXRit5azNMaE9ITCtLeWVyZVplclBjN2xSdy82ZmZHNzdzc2NRTVlKdnlB?=
 =?utf-8?B?U1FWNG5RZ3gxN00vWDgvRmQyenF5a1FqclNWbWtFYm5IQnh4SUtZU3lXWmdP?=
 =?utf-8?B?c1p5dktjWko5eHdWSzBpUHlCNEtmOTZnQ29nWjUwTWhjREQrcm8vNHp4TUVu?=
 =?utf-8?B?TXF6K3NVMEt1UlZxQkpmQzY3L0YrdmlOV0ZraVVZRHY3UnNzbjgxZWwvTThJ?=
 =?utf-8?B?K055TFV3LytyMG5mbkNEdERxT2pZYzlWVGd1czB3cGpGRU92a2RtNE5BVUdw?=
 =?utf-8?B?LzVMMDlnQ1ZiMlhPVmlYTWUvekJhZmY1dGdJU0NMTjlwaHlpSDIrTHZkYnNz?=
 =?utf-8?B?eFRqQlJYMEhXOURxTG5RNWxaZlFnM3oySUtSQ0lGNmxiZlowWjR4WWs1akNl?=
 =?utf-8?B?R0NJS2pGbjBMaUNXZ1ZCMGE1MW8wcTF6T2pRK25FWjhwUVI4bS9SUWduZm95?=
 =?utf-8?B?VW5LRmpWRXNvQ0tkMXJnazJvdCtXWVlZbVEzaDhqdDRXcmdqQU81ZGZPMjE5?=
 =?utf-8?B?NjVaekk4Z25SWHpsK3pXQlo1eGx1RHNMa2NPbGtoRnZIeFd0dWwxdzFoZ1dY?=
 =?utf-8?B?Y0ExYm5IaFN6QzJ3bmpiS1YrTTlKTU9wb0x0ekVNNTl6QTAwSDdnMTE4eDkr?=
 =?utf-8?B?RjRtS3gweUtLNVhKWVdRMmZJUEp3Slg1cy9qaGVhbkcrbTcyMkpiaEJpVkll?=
 =?utf-8?B?WW1iNXpuU0lOWCtqQ2ZYaVIyLzhGTVdQclNJckpPamtWRjkzWGY4VHZqQWN1?=
 =?utf-8?B?d2dDMVZVMkh2c1lGWGkweVIwMDZMdC9zZTEzUG5mWVRhTHFnSkR5SERRa01l?=
 =?utf-8?B?ZTBtb1RYYU1pUEFiVkpXMThMUUhzUk5tdFJ1ekU0V0diZW12Tm9TelMvNmls?=
 =?utf-8?B?V3pSbGsxSGF2S0JRMi9oTDl6bitRMVRORTg2SHlxNWkzcDRRdjNiR0FiMUEr?=
 =?utf-8?B?ekFiTkR0NGtGMzlucmcydno3TzZEN1dsRWJiYURYRnlZNDRlRGdHbHByOEpq?=
 =?utf-8?B?WC8zaXRHdEo0enR0Qm1LT3RSV1ZZY25ybXZscy8wL3M2R1d0cFRiRit3VDFT?=
 =?utf-8?B?dnZCcXJBamZEMEYxdndKM3MrRGoyVmJCcEZPYS9LR3BOZ09oelZNNEhnd3h3?=
 =?utf-8?B?RTRZWnQyZ24rV09MYm9Ec3J0WCtZTytxcWpubDdRU0h6OWdvQk81UlMvZ3RW?=
 =?utf-8?B?TUdVSmNvT1dycHZXRXMrMFhVYXN4cElVWmNBSDFDNTFTVzRhcXpXOTFGRlpX?=
 =?utf-8?B?aGt6a3g2S1l5V0oycWU2cFpBYUxGTmVLL1pXWVlsOEs2NHZ1a1REYzcrMlVt?=
 =?utf-8?B?QTc3VGpIMDNyM0NyQitDTm4xVnEvNm9HSzV1c0s0OHhYdmNjMU5ZY0d6dXZP?=
 =?utf-8?B?MlNiRm0xdXJaVUE1cWpjODI2ZDN5RjNyYURXVDI2UWFaeHphVmRUaGVJZ2o2?=
 =?utf-8?B?TlZnMjFrb0hOMU5iUVo0WkdzMHN3NW5wSDRoeFMzS0QrQjhlNGErZTNBcXl2?=
 =?utf-8?B?SUJ4UDNjQktVb0ZOTGY5eThkZU9wOWRNSGpYc0JBOHluV29PdHcxclhFbDZ4?=
 =?utf-8?B?bnh2UnA3czBLQUIxQStqazE5MTlHdFN3dHk3TnRXRlZ3TEVHVnRGZ1VLb2w2?=
 =?utf-8?B?M003enRWWGJ3cXgrSXNUVWpTZzAyVXpIK2oyTGdNcy92REhWckFWS3E2SHVh?=
 =?utf-8?B?UUV1M3JiNy9oQ3ZlWGJjZVhlaTBGVEJidDRRcGVCcXFNL3dhZ0VmYmcwdk9m?=
 =?utf-8?B?NzZsWTUvUFB4ZGFVODI3QktCUi9DMzVnb0VLQU9BMnhlUTN6ZUNSZnUrSjl2?=
 =?utf-8?B?UHAxcGhDdFVtMHRYUzRSTmo0RHBKK1I0a2FsTW1WR3NrNzR3ZFh0T3N4UkxY?=
 =?utf-8?B?SlBUZjMzUGtMTFdjUkY4b2hBY3Y0TzE2L3NJa3JsZGpqVzVEWUo2UzRNMy83?=
 =?utf-8?B?SWN4RlNGRnd4cWJxVzJJem1VNGlKYnBPOUFTVFJjanpCbGNMQUxCMGpvRGRC?=
 =?utf-8?B?WHRrcDFqUHlscFY4S2g5c3pFZkhvVHV5V3B0VjRETjMrSVdXQ1dlSnJNQTBn?=
 =?utf-8?B?dGw2UnFXQzhXUTZvcGQ1VjRBZWNocStBM3p3cW9qS1M5a05TUXdDa25SZVlJ?=
 =?utf-8?B?Y3ZZOFVNbnp2QW5wQTRUb1R4QU5zK2UzSU9JT05RRmpwU25HT0prSkxxOHFi?=
 =?utf-8?B?YVFOaW5WNzVIcUMwMGQ2b1B1c2tCbVRpcTQwc1Z6K005ZFRUS0tuTE5rZGpv?=
 =?utf-8?B?MFNCb0w2aDJzbGhsa2MyV3I5K2x6T3VkYkxKaW9CTVUvYXZ4MytjOEVxQ0dH?=
 =?utf-8?B?cjZCV3o2ZTlqbTlkb0FnYzJucGNtNkpFWDBLemtPa3NmTFQvSWc2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97307373-6589-4489-7c3d-08da1d25b43e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 08:15:00.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqyBzTJ9r66fdSMpn2Bu9HiW8wLnqB8vWBY6eL6i8ovvX6skFlBrv/lG48uIBWyj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That warning is a bit more than a little annoying.

Before we stop the delayed delete worker we *must* absolutely make sure 
that there is nothing going on the hardware any more. Otherwise we could 
easily run into use after free issues.

There should somewhere be a amdgpu_fence_wait_empty() before the 
flush_delayed_work() call. If that isn't there we do have a problem 
elsewhere.

Thanks for investigating this,
Christian.

Am 13.04.22 um 09:47 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> The log from tester says it is the drm framebuffer BO being busy.
>
> I just feel there is lack of time for its fence to be signaled.
> As a delay works too in my test.
> But the warning is a little annoying.
>
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2022年4月13日 15:30
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: AW: [PATCH] drm/amdgpu: Make sure ttm delayed work finished
>
> We don't need that.
>
> TTM only reschedules when the BOs are still busy.
>
> And if the BOs are still busy when you unload the driver we have much bigger problems that this TTM worker :)
>
> Regards,
> Christian
>
> ________________________________
> Von: Pan, Xinhui <Xinhui.Pan@amd.com>
> Gesendet: Mittwoch, 13. April 2022 05:08
> An: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Betreff: [PATCH] drm/amdgpu: Make sure ttm delayed work finished
>
> ttm_device_delayed_workqueue would reschedule itself if there is pending
> BO to be destroyed. So just one flush + cancel_sync is not enough. We
> still see lru_list not empty warnging.
>
> Fix it by waiting all BO to be destroyed.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6f47726f1765..e249923eb9a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3957,11 +3957,17 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>    */
>   void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   {
> +       int pending = 1;
> +
>           dev_info(adev->dev, "amdgpu: finishing device.\n");
>           flush_delayed_work(&adev->delayed_init_work);
> -       if (adev->mman.initialized) {
> +       while (adev->mman.initialized && pending) {
>                   flush_delayed_work(&adev->mman.bdev.wq);
> -               ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +               pending = ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
> +               if (pending) {
> +                       ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, true);
> +                       msleep((HZ / 100) < 1) ? 1 : HZ / 100);
> +               }
>           }
>           adev->shutdown = true;
>
> --
> 2.25.1
>

