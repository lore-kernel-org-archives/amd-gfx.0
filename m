Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA0BFA3746
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 15:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223DE10E2E4;
	Mon, 31 Oct 2022 15:42:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A572610E2E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 15:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAvrbLZK+wLZcYIOF1zuPQx72NbpAyVl5ygHpMb/K6UGG8USIbtbPlIuNBP/G+449qQbbHrbmXWGnA7FEIemOFvDVsu7Mn6wcM2tfpUzzM/rdivdZJehf3M9xniclGkEvWNmxTMXaZ35y/Ol1l2yihYhGNapbMlPrKfg2JUX/2uC1hbpO400O5CbO85lebjhhVgsMYCTOsj6SkU5uwyqHrjwmjlJ80LYCp4j/PGQwc1FdUdmNCLlS5I0NhWBFYkQDOtoooItJlHKwZfSk+WKra9XNLihpRf6kbL1CRZI9UMAwD662eA+Lafa0+G1lwiB6wnTpHrJn0uROGvvFz3T7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t72GQ9X0ya4VgMBzYvBbpy22O8u9Nqxoy06V5WB0ok=;
 b=TsPoBf+XaZK91KhquR9YGKkULqIhYyepnw+01W14EU0paPQmYLKbAgke37s/tOWvaIylCByyGBnQFT0oRmZ9IpeDNPOtcNtAUrSDnG3R2fwd5PW71npNHMetnaIQe80/AszRxBulpnv73LycAL+XrtIHnBiLjzSdkYpp04YfWciQBYHTqZ1nDC4SAPsLGRyMN1n3dJZEeIwupWhEwMFNucag48oQ7svT3GlbfFRXRIWwytgKoxuY1+iZZVgtGh/MtFQZQOLjKDp4TOhv+4xFDxIKVz+eSYavVrciJSUzXijduHdej1/HZJ1xKOjNNxEhx9C6faqrsJ1jvZEMVkaTOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t72GQ9X0ya4VgMBzYvBbpy22O8u9Nqxoy06V5WB0ok=;
 b=SBjpWu531tcTK0E7/e0CmcRnkDBSEFWbhr6tzg5gWMYi2/ik7iXo1XUI5dMkPjgZ8Qm1DGywovyDjlhcn55/6YCnhnp8N+nAN7Q5D+abulzliQ6tKiXhBOQ8DJfB/nm9vtjBmWAcs7kAF2gMuxPrVXTNFXMrpj7DW09BU3/6aAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 15:42:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 15:42:24 +0000
Message-ID: <97812dcf-482c-559e-21da-e033fc1e79d3@amd.com>
Date: Mon, 31 Oct 2022 11:42:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdkfd: Remove skiping userptr buffer mapping when
 mmu notifier marks it as invalid
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221029002632.729783-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221029002632.729783-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f02be45-9002-496c-aec8-08dabb56815c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2rGmWLAiv7baD944UqdndS25+nqKBLwASNLNoMI2VBF0TKoEblJI60RQlbMZInyKCsZ9mJxyN76NNABMXN5592G1izsx5gFI9/ukBaHO+XwRKhk63RCJHrQ2L1yU/FQmVs4rw5J570ItKwoywuy2Q0RN7qL1QKQW/QH9HeSLZDNNmA6JsjJ3V6INdpRiVFHEbYqf7YtpQ1Xz1YYblWdLcJl6/k0cVXP5Sb5fdECpN0dHZejl0IBCKEvMHkRX/QF14oe9A3Z0YnYajfsemLsGAiIuryyODE+cAQbB5n9DsMitgPS9Aon9y9tHjWLLm71MzhR+YCK4sLgjsVzhzuWTZDWbDE1eNcKYTgx1goFb6ETqVyC2ECzPwLW400eSOqVufXE2BlnFP7Yim4tmJiYHqod9H/AIe/iLD6vI9+2swS6C29fZIeapzR8q6D/v/pukIp+2ipXWVw4sflblzmi4P1AEydUYEmQNs09fzieb23EtdDl+ehAjwMbc2Jg8+UvmIt3ZgA2mLTE8rYkBrAf4IZz6uJBTa7tZSG2BYaOjAnOkE2cVqu//cb0Otv66ietgCGEZqv+EMFID05/lvKsPIN+ZWzm0FcVP+orczWYmevj4sID/F85uPFKP0gTDQtvPYhUXRdJCge3GQtgxPNDwVlsYZanVlqGgdFwmzkxhoOQVO1LGiznO23EQX8HeITVLaeM3nuPFXe648K10D4gkDIOys/4xdMWyFrPla7SpLo5RnYco50u9tDGnGUdJRXDSJWb2jd3KISAVE9MU09kZ5If6dpYh9ioDVAl8x6tp8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199015)(36756003)(31696002)(86362001)(38100700002)(4001150100001)(2906002)(6486002)(44832011)(6666004)(478600001)(6506007)(8676002)(316002)(66556008)(66946007)(66476007)(5660300002)(8936002)(41300700001)(6512007)(2616005)(186003)(26005)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTFXMG1sdEZBUmJiaitzakRKSnFJckp0TGNHWWJtMHdjTDlXbU9EVFpKTmRT?=
 =?utf-8?B?aGVpOE11RE9YeW83VTNxckx0alBISUNtQXdEVXV6OXA2RnlzZFNBNWd4aTF4?=
 =?utf-8?B?cU41TVkyRjhpVGkwTmxXWHd4MEtVQk95OWlPTE1MZXJVaEFkWi8zeTd0dEVF?=
 =?utf-8?B?T2JVMWNXdExuNHlVR2tTQktFMEtJaHh0dWg4eklmTUQwZXRGTEF0RUVnRWxq?=
 =?utf-8?B?YWdDeEovelFrRmVzVzZpR1E3YnFiTE9XcEtIeDdkYzlFamc3WW1YR2ZoNGlT?=
 =?utf-8?B?a1lBL3Z3RHovQUNwaXBTU01vVm1PTzdYSlgwa1lVRkVoRVp5OWpOTG1hZGs3?=
 =?utf-8?B?Qk5pNGoxbmlSNndrTjRCbUxFYWdZaGhjamFSYUZsNWViSmcxc1FuWDJybWky?=
 =?utf-8?B?d0I0M3FUQUhqcDdab2ZrR2JVM25lcmFrZy9yOUI3QjVrcEIydTVtdHlxcTA0?=
 =?utf-8?B?Z3pFRGJ5elZuSkVXSFVEb0Y1TDdxTE9QYmRsS1RYay9Ceml5V3BxVDIyaDhP?=
 =?utf-8?B?akc2TGRWcUlQS0x4NThOVm5YMVp1aWphN0RMVjNCTU50OXVyNWY3OFRsUFQz?=
 =?utf-8?B?Y2lJS21FM3F1TDVSREhlM1BldlRxb01YN0wrN3NOSWpZMkJGMkN3NGpCRnpD?=
 =?utf-8?B?SDd5Sk04SER4Sm5YRm5sOVRaM2crbkdmZWNqaFBSUDlDODdvb3ZQcDFxVFJt?=
 =?utf-8?B?cng1bkJoWmF1RkJnMzVNb1ZzMjc1TnpxV1lFRHhtZ2xlVWNUcmhWRGlDNFUz?=
 =?utf-8?B?T2QrWGhrY1pVbXRuaHcvZkxGNFU0U1FpdEZDRW91aXBiNWZ5d2dNbHZFU0FH?=
 =?utf-8?B?VWRKeEd6STJORXQ5ZTJYM2FFZWMwVEtYZGxkbGFlOE1PMDN2NWZuZ3pUTW5Y?=
 =?utf-8?B?bldSSFRjY0xZMEtCTjJ6bytETS9FS25OblVzS3Z3OXRCQmY2aXFVR0F3aWFU?=
 =?utf-8?B?ckZ0bk84S3VjT1hyZzZSaVZWZG1jd1VQQ2ZIakdzQmlNbm9nR0NXYzdLeEM5?=
 =?utf-8?B?Qm9XNWMyTzNpeityeGMwdnMvTVh5Zk9pQUlmc29nTXJ2NzZkcmVFcTdYWDNr?=
 =?utf-8?B?UzV5OFZHRnF0cnUwejQ1MVI3eHAyL0w2QncwV2lMcDFzZWJxQTB4RzJkZnFE?=
 =?utf-8?B?UURDRytCNm1vQTJ2VUo2bVVPR2VzVFg2ZzJ3U3VUVVNJTkYyc2dVbS9LMVJO?=
 =?utf-8?B?ZkZMcnRtZGlQdVFXSGdHbEd4OXNTU2xxVkxIQzNJeStENW1JOVR2dWFLM0Jr?=
 =?utf-8?B?bU9UbEdpZC9LZmEyZ1RTdmRxNFoyaDZlbnZhQUFBSmFQdjJxNGwxa0JwTzhU?=
 =?utf-8?B?U052L3BiYnlaRHNkM3M1RzZmbEFqMmFMT0s5eHRxOUMvSXFLdnZpODFCYzg2?=
 =?utf-8?B?MTFNcTZ2cUNSUThOSWdKU2kxL29SNXVGU21wSFBEZW14cTR5TTdKSldXTDJN?=
 =?utf-8?B?ekJUdTBMbW1sUGRQQWZpMjdvU1laUmt0cGM5OG8yMUI1ODFmRTlMdWdnZE91?=
 =?utf-8?B?ZkVsMGJ6N2JBU3JXSERMT0RFSzNOR0oxT2FpenhCVWpnV0lvY0MrZGtmay9r?=
 =?utf-8?B?SGh0Tm8wdDc1UGNEVEhCczY4NC8vMXpBWVRrS0dKOW85Z3k2b1hQSTFMcS9R?=
 =?utf-8?B?bFN6WUxyYkl5dmowWitsZDJmclV4Rll2VFRudTFNTVNFMGoyajRxeU9PZjAz?=
 =?utf-8?B?RXdBWGxOdFI2K0lzMjFQVE9zV0V0UDdEZnFhaE5vMUYwNk1ieTg4Vmpjcm05?=
 =?utf-8?B?MXVmczVvOXFiajFMYmxSdElZNHBDT3NNN2xZODhra1VTWFpqUWdiM3dOYTJv?=
 =?utf-8?B?cDQ4aVQ1YUNNZGxRaThSYUFNd3Fwa0UxTjc1Y2RlZDB6MUR3SW1ncXBMcnRB?=
 =?utf-8?B?OEVLNVRWdmNRMU1hcW15bWNxL09pRnNVUkRzaUNJZnBocUZaYURpZVNSamxw?=
 =?utf-8?B?ZDF4NHFvSnRwN0doMkI0VDFMZnA1dlQ2UDcvN0s3bkNQNEs3Q3d5Y3JtbDY2?=
 =?utf-8?B?MS95NFg5MDRSckFmS2hqRTBBdk1nK0tNZURjOExtaHhMNy9HUjhGb3hPbFVZ?=
 =?utf-8?B?bHU4ejIxOG5ZMDRiem1pSS9OcHI3MVZBTTVNRDRHVkxEaGpDQ3dqZFlPNzFl?=
 =?utf-8?Q?k3cVs3wP10dLr26XRxdjtPdFN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f02be45-9002-496c-aec8-08dabb56815c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 15:42:23.9356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTgJ0RHcMdIHL+a01rPb2245fQCRQAy/Bqua39iWVRfJiCzK2XlYSl3FrwQGhQa5YqnmpOSPLLxt1KyfqjoR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
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

Am 2022-10-28 um 20:26 schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> mmu notifier does not always hold mm->sem during call back. That causes a race condition
> between kfd userprt buffer mapping and mmu notifier which leds to gpu shadder or SDMA access
> userptr buffer before it has been mapped to gpu VM. Always map userptr buffer to avoid that
> though it may make some userprt buffers mapped two times.
>
> Suggested-by:  Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index da9d475d7ef2..ba72a910d0d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1907,16 +1907,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	 */
>   	mutex_lock(&mem->process_info->lock);
>   
> -	/* Lock mmap-sem. If we find an invalid userptr BO, we can be
> -	 * sure that the MMU notifier is no longer running
> -	 * concurrently and the queues are actually stopped
> -	 */
> -	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
> -		mmap_write_lock(current->mm);
> -		is_invalid_userptr = atomic_read(&mem->invalid);
> -		mmap_write_unlock(current->mm);
> -	}
> -
>   	mutex_lock(&mem->lock);
>   
>   	domain = mem->domain;
