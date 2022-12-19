Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8938C10F1B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Dec 2022 15:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8533610E2AD;
	Mon, 19 Dec 2022 15:21:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A8910E2AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Dec 2022 15:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+NKElFpROTyFWmVcNZiDxOK6XXRoNmYYKmfs9oF4GZT5Pv4vRrgztvgBQfrdybRWhx2AM5agDJQXS1qSm6rzq8MR/FuTVW3rvufvde3KkU4Ej0tf4nkZGznd0WcIMe2ELMzNLoMWgo9Jf6qZxgzzjlSL3XaVSmZoHXUmffH7LtC5Yd4Lxxc3lf13X7w4bQ2sW/bCBD1pLEgf7YyjhzAv/gi06zo0Nf33I59Zqb2mmm//+WVRAMq39IsARz+A5duMTE/418EDswTEvXa+JsI+ifzH8eIIrInLB4Tk5a5ZGAIm32N7GokMa3k0NBwY/5q9oDFdl2qKwCcdRCx7fEFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xba6TJgCq0P2XTdjT8Rr1pTj2Eeih/YLfLBYKIPOs/E=;
 b=NpPQ9dVe6wlGb/DSzlxc2Y2CNFENyXqBWTCuxN/XEv6URn8e51+Wga3y9yfiY7KOSNipJy/XxBXORPm+Hrmf+TSRaqgJVjDk5JPpHLTqgemRrD8q4tCEbtFHEzFqcUlY8dJPflqI9VJj9kJxKeKCmRqbQmBauNR+9LSI9QGmvzLpi6FTO1K/sex+iicczsIailshxg3tf9sohT+sKhor3QDCKMTY4zKrOcrB+83h2d+CRaoSJYpiRD1piZ4uR4o6PbE6WMe7kKDZ56PFNYbVaStehRZqQPiO/sGxjK1pAzLVfhQZ182hPOz65smeaovXHturOjuBIa2F/lpM8qn9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xba6TJgCq0P2XTdjT8Rr1pTj2Eeih/YLfLBYKIPOs/E=;
 b=yKWN4curn53ANu/iPCzeUWXszzK5mYsk8UYAK4RL+N6UipMxJAYd1xXvJI62tZuiaVamRm/Lkp3OEXtIh36g+MRoL5AnWvgygqQkJfhzD1UKiPrclH2nbPM4WiHpwVQBY6bL6bWp8HXegE0UTatdh853O1AX2GDiyEEoAeq7whs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 15:21:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 15:21:36 +0000
Message-ID: <b9a7bd1b-2bea-b9a4-ff80-86872c47c599@amd.com>
Date: Mon, 19 Dec 2022 09:21:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: drm/amdgpu: skip mes self test after s0i3 resume for MES IP v11.0
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221219121252.2567663-1-tim.huang@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219121252.2567663-1-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a49f1fd-1f66-453f-e764-08dae1d4b83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaclMpQqvRp+ha+N7lb0szwLH3DXPNLaC0Y2MT9zWBqCPaW512ErJYkv16hY6Cf8wzasEXD1m8//QLAieomABI8FapYAhi2c4wNSZKExW+uXuFuPy/NKYomXBgH5IZ09ja2oMwX2Oj8mwqoehz3UpjU6HUDKFEOITrZOTMm/ZBCGS7vnNtGXi3kwwLMsECzfaM7E/+xvDU5/2oTf4DwewLG4iH3yyH58TvjiSmHTk4q8ACd0VQHQ2bPsP4vjach3bK6918ssDjUKD9Nk9YGUO4ciZ1+G384ijaAnW+vVrBtQImITqo2+pgz9o8AIcaKIGQoUfXnoozPCkqxGPtPNx4dQ7/o2FX8+Q8aoTz35g/IFDCJsPab5m/PvS59xUKZPaJBXNQXABlLGCDshSG9ns2w+wIbE8rhgtZZ2B4oQTNkeKRTttjwN/jICsCahhbkv+4yr1l72FkG/xnRWlrr5XRFI5A01x1YSjXvdlnAW+TDfVqbhaZizF++5h1Z/Wve3mU3lAdCkg5+XximZLG3W6yftQ9cjqdZKbvyMb/MVy4Pcv7ZK4ds6R4k0Rn6WJNb+S9jtbE8Y9/8XggRLyQyVfd1ITkZUbKwxUs/Qglu9hJTTQizhd3zPEY2r97i6Ea+1KGQaGkuDxqTNzyVrYxBGgwa3LCDPZ2N+nm5y4AM210W7s6ueSnL22ou1QpCj0iZB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(478600001)(966005)(6486002)(31686004)(6506007)(66476007)(6512007)(66556008)(186003)(66946007)(31696002)(86362001)(316002)(2616005)(36756003)(41300700001)(4326008)(8936002)(8676002)(2906002)(5660300002)(53546011)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEI0SHNFMmNWTUE0WGVDaHU2d3ltaTRtbnJBNERpcy9lMWNGZk5penUzV1Vq?=
 =?utf-8?B?Q1UvZFRtUFFreU51dlMyYy9GMld2MW5EUDNnZTJlTUpNR25CY3NGb0J6clBQ?=
 =?utf-8?B?ZS9Pdk1HcUdEa25MK2NPQ2k3THBtb0dtQ28xRFp5UTJrbzhzWEV5eEJPSS9O?=
 =?utf-8?B?dFY2QUhianpkRnFBR1NENkhQODh5U2p2Y0sra0NkWUFwcTdHMzVPYUxHOFF6?=
 =?utf-8?B?WlFEdW50SEZSc0NzNmY0enpNaDFmODU0VWI2ZHBDM1hjYVBkU3dRNTEzUjJn?=
 =?utf-8?B?Wk82RHF6anpqa1kvR2cxNnFKUnBFMUc1OElIRlpNbTRaYUdEeU42cU81NSt4?=
 =?utf-8?B?SGZ4akFhOHlRRXdxQ0gwMmQxNVgyTzhYQ3pINVp5ZmZWVG5lSnNydUVBdnk1?=
 =?utf-8?B?dDBnbEJhQ3JRSVNtbTArQXVJdE51dHllWHJFdVFHSTBNMkx2bldmZmltc20y?=
 =?utf-8?B?MzIzMW1KaWczRXBFbmt1UmtHd2g5ZDFlWlYvTDd5c0NHNkY2NFQvejhidUts?=
 =?utf-8?B?Rk9YUi9IcHFUYVFCZDEwTHZXMWloSlZsUkRzeVNtaWdGelUvL3VrbkxIQW80?=
 =?utf-8?B?SC9oc0hQLytYNTF2SFhKdU1RSzFXejFPWVAvMnRic3BIWEZHaENUYjk5Q2tK?=
 =?utf-8?B?NUNqWkIrZ3VxdFJvWjNhK20vSmNYRkhUd05aQkFpTjJ5RjNwUnhHKzFBbUlR?=
 =?utf-8?B?Q0N6QkhxR0xtVXBpWW1SaWxzY1ZvNkpsOUNtV1FYZ0tqQWNucU15SHJLVVlR?=
 =?utf-8?B?M2tQbmpacjJMOVMzZGNScms0bktQWks3MnJ5NWc4YmZ3Z1NSR2Y3NGFJN3da?=
 =?utf-8?B?THlkaUZLa3FveW9rU1UvZXpHTWtBRldlVUt3Ulo5WWNjWlYxWk9CU3N6RzJV?=
 =?utf-8?B?aXlkTTNGeDdPYVpmSXlKQ2xFY0ZjMVYvTCtJc1ZDQ3Bsc3hzbUNZMS9la2lJ?=
 =?utf-8?B?OW9aSnFKQ2xSUklpWFI3L3RUdklZL0cxMEdFTzc2WFRHaGdhenlQMm5pUnBT?=
 =?utf-8?B?WGlYTDhuSEp4d1NrbnpDZXpHdWNRVFQzWlVXTk1sT3Z3K01MUzVpSVgvYlRB?=
 =?utf-8?B?M05aR2E5eVZPaWdnbWloTUpOVDRlZnE5bVVXWWtzK1RNaThnQ3NFWkVka1FT?=
 =?utf-8?B?djNFZHgzNmdOcTQ4c2tMbVFFNUJMT1BkcEd4azdFWlIvd29hdTNBSkxUQklv?=
 =?utf-8?B?VStoS0NSQi9vZzVlc1hRZktmTXBHVHVQcTJzc2NLdVlucVJoTlFBMXg2b1NI?=
 =?utf-8?B?ckc3QUdIQmMrQkozZUtPcUtkcm0zWG5jT2lTT2lCYkNkQm81cWRqcG1Uc1Zh?=
 =?utf-8?B?Z2h1N0MzbzYrbjd1aERhcmUzaGRnT0l2amRUUVkvVTVLZ2lvc2hhbEhyMmxu?=
 =?utf-8?B?R1BVcFBndms4c3F6UENVU2dwaUZ3aGxkVWg1eTVqenRCSW9iRGlQdlhpUm1m?=
 =?utf-8?B?TXhiVzFZeGx0Q2ZqcURXMDFGOVVidzF5RDZEbmJ0RmJ0eTBtZnZWTk1wTm1y?=
 =?utf-8?B?c1VEWUZLcDRoVnQ5OEJrV3JjS2ZsdGJvVWlPVXVGcXU2am5id3VHTnF2Y1F5?=
 =?utf-8?B?TFN5SjFkeVRMdjVhYlFmL1NDQVQ1ZExzUUgrbGlZeTMvc2s0eVdOa295dlYw?=
 =?utf-8?B?UWRKM1ZXQ2lhWitjY01JazlVTTc5TDRzL3phWUtIUjRKbHVMS29oUnVwK1gz?=
 =?utf-8?B?eU40L3VuejV3L2JoRlYzY0FkS3lhOG9mS0RvTmtnZGVuSGtvc280S25SV3Zy?=
 =?utf-8?B?L2poWnV2cjR0R3FkWjFRN0p0bmdPcjI3T1pveFphdTBodzQ0WC9EMEo0dno4?=
 =?utf-8?B?eW42bW5OWlJQYkErYmdVZ01SbU45UjRhc2JRWmU3VW43TmtVQ3VXK05RQlhl?=
 =?utf-8?B?M25JOGJxZUUwbHNBTjVXWmkxWUovRU9DTWFNNWV1UVJ2U3ZJYTc2MkVpMTk4?=
 =?utf-8?B?OHRTemM4SjQyUGkvR0pVdlhKeHM3RWNaT2RwRk4xam9kWFY4Y2t1SVYvZnhz?=
 =?utf-8?B?Qlo4SG00dlBlNWZrQTFjNGN4WU9TNXBEWDJiN2VNNzZLYnlScWpLdWQwRDRk?=
 =?utf-8?B?d1M5Vllydk9wd01lTWFnUU55aHhnc3plMldueXRNVjNYcXZjN09kZTZJNmd2?=
 =?utf-8?B?RHhkMURoaTR2S0JpMG1oQUFVRGFEWHd6enRaTGczWEc2UEJUK0ZObVlIamV1?=
 =?utf-8?Q?GEi3T26Ff7h6nMcwLGUwhJgGKRGXxJsvmc3oxKUus1Bm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a49f1fd-1f66-453f-e764-08dae1d4b83e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 15:21:36.8681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXoFLkxapFqMvw8VxuLa+TsM8waOvkG6E4I/NL/DBxBu5rYjDTm0HUoNJxkU+2hoZWadZZch/seV0rf/j4owYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/19/2022 06:12, Tim Huang wrote:
> MES is part of gfxoff for S0i3 and does not require self-test after S0i3.
> Besides, self-test will free the BO that triggers a wraning while in
> the suspend state.
> 
> [   81.656085] WARNING: CPU: 2 PID: 1550 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:425 amdgpu_bo_free_kernel+0xfc/0x110 [amdgpu]
> [   81.679435] Call Trace:
> [   81.679726]  <TASK>
> [   81.679981]  amdgpu_mes_remove_hw_queue+0x17a/0x230 [amdgpu]
> [   81.680857]  amdgpu_mes_self_test+0x390/0x430 [amdgpu]
> [   81.681665]  mes_v11_0_late_init+0x37/0x50 [amdgpu]
> [   81.682423]  amdgpu_device_ip_late_init+0x53/0x280 [amdgpu]
> [   81.683257]  amdgpu_device_resume+0xae/0x2a0 [amdgpu]
> [   81.684043]  amdgpu_pmops_resume+0x37/0x70 [amdgpu]
> [   81.684818]  pci_pm_resume+0x5c/0xa0
> [   81.685247]  ? pci_pm_thaw+0x90/0x90
> [   81.685658]  dpm_run_callback+0x4e/0x160
> [   81.686110]  device_resume+0xad/0x210
> [   81.686529]  async_resume+0x1e/0x40
> [   81.686931]  async_run_entry_fn+0x33/0x120
> [   81.687405]  process_one_work+0x21d/0x3f0
> [   81.687869]  worker_thread+0x4a/0x3c0
> [   81.688293]  ? process_one_work+0x3f0/0x3f0
> [   81.688777]  kthread+0xff/0x130
> [   81.689157]  ? kthread_complete_and_exit+0x20/0x20
> [   81.689707]  ret_from_fork+0x22/0x30
> [   81.690118]  </TASK>
> [   81.690380] ---[ end trace 0000000000000000 ]---

Is this still needed with https://patchwork.freedesktop.org/patch/515278/ ?

> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 5459366f49ff..80e8cf826e71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1342,7 +1342,7 @@ static int mes_v11_0_late_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	if (!amdgpu_in_reset(adev) &&
> +	if (!amdgpu_in_reset(adev) && !adev->in_suspend &&

I think in this case you should be using adev->in_s0ix instead.

>   	    (adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3)))
>   		amdgpu_mes_self_test(adev);
>   


