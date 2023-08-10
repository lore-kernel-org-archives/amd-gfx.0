Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7534CC001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 21:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1518010E5EF;
	Thu, 10 Aug 2023 21:02:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA3C10E5EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 21:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX9dSyGxhqZu5KETM24fZiQ5aoa45o1LWcLy7o6w7Iax2eKc1hy7DHdagmg3UwxfKhn4YRlclkZqqTFqJnWiaCdj1AjDUlOD6vjSp7yeo3L/L8JyUv6IqhjEfdrOTqa9j8Wa2b5sRbh9VqIFJVitFDBSrSOke2osaJf1fKzVv/2UmyzorVTR6+nokhNfZSYtwNbeMquyRVhNkb7WZpuhlXQyqnoP+MNG1kva/HsAEcWYc1ZFjVMMj64nQ823dN+yt67OdbYCVuE3iqGZFmTXxbZCPeD73kYC1Uzx+puhvkdqz+bMj2lnwlSOiBbq1KIzV/JPb6I1A0botp/wOo1ZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV/1Py3fhNNILZxEpenZQ1uFbaTEPx+Hfnjgs+T29Hc=;
 b=fvcm1iEn/Lzo74go3qy5lVxK/vM09zsw1eVIjJZR7u0CIIeJmyWOE4Rpm1x9iXJh8bHNmUmtMC6OgMZJuVmTT/JkIo6uBAq6aIUJyVXNV4ja/WrV+D6Snd9K6+jvZIay0hRyrdtJc+ncVhKLzNVwB3oe9Qarwo64zx91G8KrFf6n3aTUEYiMLou9UqcknFMzEtbx1Et7/JRbQb33FR3i0Dcfyhg/YjOlqAcI7gnLUDVK1j3zZFQFLSMyjfemili7m93j2oYTIxSaVXGmrgVTDN5VBDhuGqQpfqEIw6tr1YhhIaKwzwj+80bVPO+3JLNB4qXUKIRKErKXuo8sVYK0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV/1Py3fhNNILZxEpenZQ1uFbaTEPx+Hfnjgs+T29Hc=;
 b=2XhvgbaF3HGx7WKdkh2l9N86njjV8AvGf2lSnSSDbeWZUo6Y1SgPbLtLqiNh/q9iMwNY++2DfNuMfD1lZrHA48AMREd95mmhH7UPSt6DguD1SJFKSpyzWRT70wQ17j/IVKjr1cBRG8vhozCKzif2kBlmMmB5NNTHGw46q9h4WCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 21:02:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 21:02:46 +0000
Message-ID: <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
Date: Thu, 10 Aug 2023 17:02:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Content-Language: en-US
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230810204744.195416-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1884b8d9-f57a-46e6-5ca8-08db99e525bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omVZ2xPgyy/5t6nD4sSZfEynatbyOSVe3gEueuZ2gzM/G6gL2MALIGiqBeAcatuoDMK6AXpML5O2XYQLT+AV9CfMG7033BdXbieaxmH2RSkF0JxpA5d+YNd7v/uRLvup6VVUBssrewaD30goSnbX0PL2c3kvEAzi3qvy5QkbbVNQpGMmzdQ60N43lo7F1aBJixbgB4Hnl9lFDGW6+8ldaZeSm2aCjbUJzDwdJeJeAp8tLUoK40damwuryxoO5c/bwPU41a3vc4rQtmWpjwzswEs+R2Wk7CmZHKbqb2eo/I3hL1Gyfg5jKa6ocPR3r5yEQLhyy3xMAH/dDyFzFMeuKF9dnT4V7kP6w9Cdzus7Dfe1wLrPu2QFxOd7KIjIzjeNP7r7d8TRyq+m6VQL2JFJrUTu4XmBXtVXo0pRuHdTjPU49LUcQhJRzveOwwJlLxhHlHXluoHm5AHXdqk+51qdMvy02foskR6rqAVzg34qsduUhWUwbLk2vVdlstN5xOdPdN3tsaqjWdaKI9nxcx2moD2V8WZwP8j+6yxjUUG3uo+hgGdtsqFwtCtUlgKZFpMDgHrof7bdnUTredzDlM8MVsfYETpvXKLWfjnajTTrzO/2rFGAXC1EWADuGeFgT+Ra4rIl0cyN1Be9jr2SsM4aZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(1800799006)(186006)(44832011)(31686004)(66476007)(5660300002)(38100700002)(4326008)(66556008)(66946007)(31696002)(83380400001)(478600001)(86362001)(41300700001)(8676002)(8936002)(316002)(2906002)(6486002)(2616005)(36916002)(6512007)(36756003)(53546011)(26005)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdHK3d4Y0hDeUMwRmMrc1RXRTdoUXFiY21jSmhCanpEbmx5SFAvNmF6d016?=
 =?utf-8?B?WEx5STNnRzMxaWVVdXdUR0lzaHp3KzhRSzNOZDUvbWFmcittZVY2anJvS3Bu?=
 =?utf-8?B?b3RvMlloR1VZYVFKVW9TcWUwWmdDZGR6M3o3YUJIQUFLS00ydE5WaERTT0ZR?=
 =?utf-8?B?d2cwVmo1WCs1L2MwYTZrUVNIK1p0SmRoTUxPa2E3VnRvdFQ1QkliV1ZvdnRD?=
 =?utf-8?B?aHU4cFhzcjNoejVzMldlM1RsOXNyVWNRMzlpWEZNR3dNN1NGZDkrMElxUUhS?=
 =?utf-8?B?QU1oSVFJSVNhRCtXQmxHVm1aeG9keUxqWkQvUnlFcEs2aWdZVXBuWW83aVdn?=
 =?utf-8?B?dldHM3JLNko0dTMrQmdCdkUrd1cxQllKZ0U4SzMrZ05lRkg2QWk5NzNaNDRj?=
 =?utf-8?B?UkJuaGlyTnRic09xRml4SHEvM0E3NWhNMFJQcDZZQXBpc0V0K0s1aDlMQnRp?=
 =?utf-8?B?TU1JSHhMWjlZakszQUowYlFrbzBENlMxamlQcGVCUHpwRENteEFvbXlJTUEy?=
 =?utf-8?B?N2FQa25qdWlma0dyMDcwcHRxTXFLRnRLY1pkeW92MEd5cEhNY2hZbDNucG4r?=
 =?utf-8?B?U0Z1aXJ2azZaby9rU0Zsem53eEVNQm51NWMrK1dhOFJMSUNCc01DODNTdGdE?=
 =?utf-8?B?L1A4KzdZSmRYNk9mZDFvT2dRUjc2SHR5K1lkZzE1c25TcWYvTStsUnV6cTNi?=
 =?utf-8?B?eDF4VmlMTVNINEd2QmsyK2hOOXNCYkdiTklwbWJtV25RTmdQRkFHQUJqTmdF?=
 =?utf-8?B?ZHc2OCtsT2pUVFFhS0RzU2RRTDZ0aGl6ckpJMmNZeVBWLzJOckc4Ym1nQTRo?=
 =?utf-8?B?ZkVBc09WQ0hZRHI1WFJ4RjQyQzl5bWI5WmhRUGM3OTE4ZTJrMWY3Zno0NDQ1?=
 =?utf-8?B?ajdXVE9YM01NREZKc3BaU013NS90c0VLSTBxVkk3Z2ZtczVWN0d2MC9VZlAx?=
 =?utf-8?B?Z2piLzB1OXFNUFJnc1dkTzdma0VTZ2ZBbG0vT20zUUhaM2oyL2NsaHJ0YlVp?=
 =?utf-8?B?TnZ5cEt2RitZQ3RZcmtvYkZRS1o4TlBQY0V5V095U2FXcjRTR0p3YjExcHlp?=
 =?utf-8?B?eDJDRmpqdzhWYlloQTNYMTA1eldCSytKSkZHWm9lOXRmRVdkWU8xalBWYWhn?=
 =?utf-8?B?Nm1SQkR5c1dGcHdwakpHM0s4aktkNG5jWW1GaWFSbmpnNG8zMlBPc3VyYi9m?=
 =?utf-8?B?S2I3ekpmVjQyR0dRUThGVG1KVGlPalZ3QzlxemdhaE9jK0hyMFJGSi9NUDZl?=
 =?utf-8?B?L3hrdCtjNjVFRTR6NXNuQ1ZReXNKUTBERlN3Q2FBSUF6WllhMmt4MDdJNnUy?=
 =?utf-8?B?MmNGdDRWemp6MXY2aVZieDlqRWZwdEdEdE1vSFpEZjRNVFlpYUVIZVFzUyth?=
 =?utf-8?B?dWtHRWE2eDIwbGxPZ1hRVHBVcjl0amVVS05FcGt4OERUM0lIeXRUU2RzVXNC?=
 =?utf-8?B?dU1uSkJldFQzOWJ6SWs4N0ZWM1p4Q1IxaUJpZEpJR0hVWW96NDQzbGx5d2Jp?=
 =?utf-8?B?ZFRmUVdCNHo2NUdHVURWa1FuUlo5SzFkK3E3SkFSQUYvUkZTaGdYWFRwdXY4?=
 =?utf-8?B?T01jMTN5Vjg0R1N5ZVFCSXc2Z0ZqQnZVTkRjVGkvR1ZKN1VlaUpITnhJMmZT?=
 =?utf-8?B?TzBBd0lkWFNkdjM4WHIxN3l4Y1dZZ0xTMlhETm8xZDgrWm9WVkdoSTNyeEl3?=
 =?utf-8?B?QTJhSy9xNHdGTElISWl6MTB1UzFDSXR5dm82Wk54VzFRYmgwTmxSVjFyYUZl?=
 =?utf-8?B?MUlUZTNnK3Z1cDhSY1lYZVlJSDJ0dGRBNXRMalY1V3VJcjBMeVNpT2pLKzZp?=
 =?utf-8?B?dHdqSTQwWlpyZkQwdEpaRTlrZm43L2htYTZJdVhzTnJhYmVsWkp4eXpONWJ6?=
 =?utf-8?B?SE9rTk5xQ3FNOG5SaSt0Yjg2dWc5UGJCUlNuajFSSUx4NHRkbFQ5YXoxdHlC?=
 =?utf-8?B?MnhBRnFHN2Z2WkI0S25uY1JQRnhMdExxZ1VQZE1jUzNzMmtxVUFnczZwQ1R3?=
 =?utf-8?B?bDZWSWRvNFFTaVFyaFdrMURzd3k0Mk1BSWdxVUdlZkRTMVVrb0JKWDdMQk45?=
 =?utf-8?B?Z1BUZXUyU3lPSDFUTFcwSTBNV05aVUtYL2ZnRXI3WDRJd0Q0VGUxWFB3VnBF?=
 =?utf-8?Q?MVaSatg4FTjnkT6b+JkID2yjK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1884b8d9-f57a-46e6-5ca8-08db99e525bc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 21:02:46.3890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iti9liGJgUAMDb3VWCb7itR8KPeb/4w3FtFrJRXCrEICsbqc7ZbugLUPmxpvNRInDdtE1fzPWdROdTBjvPtyBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164
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
Cc: Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think amdgpu_amdkfd_gc_9_4_3.c needs a similar fix. But maybe a bit 
different because it needs to support multiple XCCs.

That said, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


On 2023-08-10 16:47, Eric Huang wrote:
> KFD currently relies on MEC FW to clear tcp watch control
> register by sending MAP_PROCESS packet with 0 of field
> tcp_watch_cntl to HWS, but if the queue is suspended, the
> packet will not be sent and the previous value will be
> left on the register, that will affect the following apps.
> So the solution is to clear the register as gfx v9 in KFD.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index e2fed6edbdd0..aff08321e976 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -163,12 +163,6 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
>   	return watch_address_cntl;
>   }
>   
> -static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
> -						      uint32_t watch_id)
> -{
> -	return 0;
> -}
> -
>   const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.set_wave_launch_trap_override = kgd_aldebaran_set_wave_launch_trap_override,
>   	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
>   	.set_address_watch = kgd_gfx_aldebaran_set_address_watch,
> -	.clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
> +	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
>   	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
>   	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
