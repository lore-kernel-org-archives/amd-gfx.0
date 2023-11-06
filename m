Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D41C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Nov 2023 21:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B7410E443;
	Mon,  6 Nov 2023 21:43:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F006610E443
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Nov 2023 21:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwW1xfW0g6vEUhmN2Zm/M4fkFWZbT1Thh/wJaZFCKJtoFanV6VkvRPVL1N6lMKTjBL6wlcdf8LQRtjzP7HstnD7/YiXP82uh6dx9R92RNVzgLJoJNY7s/reUqhNJHEmCWZEZeeXq2Nv4OBuKdStAP76jwkTLXhK+WM0JYVmWPiv6lywUCrvxwNMG/QKaBRc4BjaLHvVimtgX7gaqiZPgpvwfheFShIN+OC9JTQ5s8JC30YI5cwvIolTFjbDbvXnQTe30fhSYvyj+rsGAP48VvKTb9/XXBxYVBdTNEHCz0oY0AyaeDcxx9NAN8BQo+DpGoo5CxLVi0Urnoui2eYwhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJS0CCoEint6VG96VEJ+9WM+I7Jx1Z8GhrsdsbzDQmI=;
 b=crb6vLcxp7o/DBwKO4NInrfJq0GK28TJzjUIIccfa23nwp9WMVVwSANO6R3ICJx/LTQyVm61XPFCoZTvomH9kxWxJ+WSm2yd8G32tJqZ0l5glEUx8WME6xZxrrdw/IhQ8/xregE0yngcCU5FAmGQniF5HmhJC5HzLZVDDWsbGEX0N16A8hpsncK9nktiyEwVRSTo2BkbM7IzRf11DJpIWxbA3cwauAfJ3UbUabt22eiYLcbdDw9NJ2fwxu7Uh45pIl0jaRodbQIu7Xb8VpZm6gTJV45bQeGw6DPwMF9EpXoHqqgt3Ec4j/lI8+Ylk50EvQ1G7q3/xTql20ibARbmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJS0CCoEint6VG96VEJ+9WM+I7Jx1Z8GhrsdsbzDQmI=;
 b=TYy3exHX1Icwa6r4jguKkwDsE4TR5T691QuLd1BIiBpcbJOAFiRsuCYnPxGwJipv2EQnXKvAqo8NkHf1aj2PQSLAReREREgg4oGl000jv9QJNTXD3AalEMuoJ/zWo+H0ZNoXDKgXoryHeY3h8CLgZaL7+H7arNNpFhNXJ6akidg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 21:43:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 21:43:09 +0000
Message-ID: <52f00ec2-d913-4727-b215-1ef3af7c1b3b@amd.com>
Date: Mon, 6 Nov 2023 15:43:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Exclude dGPUs in eGPU enclosures from DPM quirks
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20231106193010.2093-1-mario.limonciello@amd.com>
 <CADnq5_P4bnESWVAs4LMmDoF-MJeJVQobFJ7aRU3R-Z9t1aDxxw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_P4bnESWVAs4LMmDoF-MJeJVQobFJ7aRU3R-Z9t1aDxxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0048.namprd06.prod.outlook.com
 (2603:10b6:5:54::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e592343-cf6e-4ecc-cbdb-08dbdf115e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHqC/AIhKWKoLAYXqGAS3caoP5Vb3UszRC2GQj5iIGBlkMFuTu2pSdDYVYShkeB/4FQMlOVn7v92hET3Am0f1jK2U/zrpEP6ifxz6hdjnLEsbbMtNO5EcZEUTNoOh0V73qesfor1TrMfSeHEjt6EWNqrmqRjwFXQoovbDG7+fdXx3vMrWZI40Zibd1FFmlIjsi6SG8tpU00S5GNc9uLcXckghoWEIuwvpjdpnPJciSYOjX+FUDLsHmy/XFnSZaLbY4XNd144FjlkcOvbwf0XWjVI8jDE+22wO+rU6WOhcwvfdTvpkBJZRO76Aj9hrQRmIJN62zpSI76Fczvu/gh/v1wNw9+n1ZzO2+Kh0F1uiSHCp6VQS0nIP3FqJNhSNjQ3aPK3ZVP/M76owmE9ZrciOvLLGgN/AL8rwtHpr0AyrC1L/ZNQwQgIOMCaracmMDKW20szBEoLW5FOyJMgYpJ1DJTUrJeu0Q+wKHGE9gJU21GaGK+5/i6Nx+3DK9gEflcuXag9hCcP1miL8BH0EUksEd67LZjWoHN9DyiJYe73ZSVuOPQy0XsuwulIE4LfpBtcyIkBTzz1KwxK7RlH9/2H/LBaGRuLs/hUgylpT0v+Au6aUiq/vOwCtudR4U4TLovQIV2AnqksyKpRF0niUvxz7E8ELbQZHHEBcU09G35QxIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799009)(64100799003)(186009)(2616005)(66946007)(83380400001)(26005)(6506007)(478600001)(66556008)(966005)(6486002)(53546011)(6512007)(2906002)(4326008)(6916009)(316002)(8676002)(8936002)(41300700001)(36756003)(38100700002)(5660300002)(31696002)(86362001)(44832011)(66476007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG4zZCtCMGhWY2IxeWZXcUlQQnZCckJHcDFpajVUWWdtb3ZQSlFQRUM0T3FS?=
 =?utf-8?B?aEZBSy9BU2FZQ2pXYTVvc0ttNExTSG41RGp3a0hPWkhqR1gwaXVuOGtrRmhi?=
 =?utf-8?B?dzdjQmFuVlovTTVwQW9ySXRUSlkvUTZ1TmY4Yk4rTW8xZzFadzBoSG43Y01Z?=
 =?utf-8?B?akg0eGJ1VnVFWTlHSTFiaTVhczZ1cG81dTU2Q3FRbXVZRldHcVpFVVhZZVZx?=
 =?utf-8?B?VjRvaVppWlF4U2NhUkhvaWVHUmttVld3eXZTckFyVGs1UkxyU3lIOTZGcHli?=
 =?utf-8?B?b2Y2NGRQL3VVQWQ3SkFMRzREVHVtd3pSYU5VZytwbitxTE5MQWk1R0RHSElE?=
 =?utf-8?B?R1dTd2oya01TWWlxS21WOUR1dkpyZkM1ZU94ZE5ra2VnNzBiU05hN2RLd29U?=
 =?utf-8?B?MkErMy9BdXZpdjFtTVhpczZxK3FUSW9XMzQyeDBQR2loSEZpMUpHTGYvaXFZ?=
 =?utf-8?B?M2dIZXk3Qmx2TXpqWFlsUDQxNGowY2pTUWl6TnUyY2tHN1o4eFR1UkJmaUxR?=
 =?utf-8?B?VnRLNmoxQjlvMmgxVWFWV3ovNmVhaVF3dTIyYnl4TTBiMVp0ZVZ4QWdzQXVo?=
 =?utf-8?B?SS80NzZiQUhxbEl4cVVDbGFCZ2kwVTMyNE5IZGdkUkNWNXFBQnZ3ODZVWTYx?=
 =?utf-8?B?b2Vvc2RXc1NlSEFKZTFmaEExSTJhZVNPc1BvVFd6MUtvM2h4N3BLQkxyT2Z0?=
 =?utf-8?B?Umk5YnM2TTdKRkYwRENmaGduWm1ncEFuaWk2bzc5czFwcVgrdVR2Y3NNZi9I?=
 =?utf-8?B?ZXlFcUc1SzlDMWZOREJ2MmFkRXFNN0UvcnR4Q2tIa2RqS3gvWEpZYkU0LzMx?=
 =?utf-8?B?NlU4VUtQMU5pRVJkK3hkTjV6c0dWRndqZndYU0w5bUhueWZaRXR4eXpiTG00?=
 =?utf-8?B?TERRNEVZeURsY1FZYnVJblFYYWlBU2NMTWtQNklFTDROOVhhdnB2bEpacG1B?=
 =?utf-8?B?dWk4U0R2WVhqU1hBcFUxTHBPUGJEanZldHdTUkxhejlQYUZjUjVibDBLZTVV?=
 =?utf-8?B?M3NIR3BBaEkzQ3ZwNUUrdWg5dGNpVEUwbXlSbWJuVjh2alh3amNJVjJ2bkVZ?=
 =?utf-8?B?WTdNTUpRd3d1SFNPL0x4MUhnQ2JPMTdTWTVRYUtuMEZVV0MwZVVBYW5wbXlQ?=
 =?utf-8?B?Q21ydUE3K0VQdUhVR3BQTW1tdlVrOGRhR1VwazVoSGx4QlpXQktMc0hEdjV3?=
 =?utf-8?B?aWNSZVpGVUFEbDRBUFFBOFJFUTBFSmhua2hVWUVsai9QUzZzc2E1ZlJCZ05E?=
 =?utf-8?B?YkJjRDZneDNURldrbXZHM2M0UDI0cDJrREUvcHVnNzV4RDRsL056d2ZqbFhi?=
 =?utf-8?B?Q1JRTnZZSUNYRzJsOVNneHpWS29wN3grVW5ZS3R2bmE3NXhncVhzYndEUUVr?=
 =?utf-8?B?cnltMzBJODg5cDNENk5LNHYyNGM2Tkp1eHNPc2xJZDJiUUlmRkkyc29SZkhv?=
 =?utf-8?B?L1VMZ09obHAyMXZ2S3lPZlE1MmJFTk1RL0JiZXJOUHEySUhYZnhTeVNxVGJ0?=
 =?utf-8?B?dGRQam9wNnNkanRQUGxIWFVLblY3a2VYL0RIQitCeXhPemhxWktSRi9aQ0Rt?=
 =?utf-8?B?NmNSUmQrTDJGU0FycnBJRHh3bTdPZ1dRakY2aWNRSnZlOUIwaU1Ka3QybjJk?=
 =?utf-8?B?cnZoTjViNUt4OGhBbDFHMmMzekRnMU5HM01KTHFyZTkzeDR4NVN0OXdkOW52?=
 =?utf-8?B?TGRMaVErZXBkS0R0RUdXd1drK3FBMVQ5aGh2VndvZDhxeTVVNms3V0MvV0Jk?=
 =?utf-8?B?TnAyUjFib3EyeWxrNUxEcFNlV2l3RmZid3h5VmU2TlBoSVEzNmdxWXZ6akdD?=
 =?utf-8?B?TEtIckVWUlpLdGY5NWdISHJocGFyQ2QrdnhwcDMwcHc0cmU5dGNNUlZldk9O?=
 =?utf-8?B?T0tQa1E1SFFiR3dyTi9hYWFCeW1Idm1tc1lxOGVFVWtJUjVuZXV2TjJxWWw2?=
 =?utf-8?B?WkM1WitWMXFoUWY1a2ZEd1orejhoVDFzS0lBY0ViSHlzVjhpM2Y4aEZ0SEpH?=
 =?utf-8?B?L1RmZGUvdjJrZVhHV3RmRFBqU1V1TmpPdldrK1c1dFN1K2x0NC85M1M0QUVB?=
 =?utf-8?B?SzI5NWxLWDVpeCtLSmFwcWx1dk43dFRxWStvajc1ekZZWnBJd2xkWmg3cGI0?=
 =?utf-8?Q?X3PhAHAD33RGM+sr/CwXdvufC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e592343-cf6e-4ecc-cbdb-08dbdf115e83
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 21:43:09.7578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avF52AHmljZRr+XK6jyvxWHZHJnZXM8+qZ6NVYVnspHKVypxSsnYmd0izAYH2a1zSRdQCpcc6iVocfGlryGmRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/6/2023 15:40, Alex Deucher wrote:
> On Mon, Nov 6, 2023 at 3:07 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> DPM should be enabled on dGPUs that are used in eGPU enclosures
>> regardless of the host support.
> 
> Are you sure?  Seems like this would be dependent on whether the eGPU
> bridge supports dynamic switching or not.

Right; but the bridge the eGPU is connected to is "outside" the host.

We shouldn't be blocking the bridge 100% of the time if it's connected 
to an Intel host.

I *believe* right now the way the code is put together if you take an 
otherwise identical OS image with amd-staging-drm-next and connect an 
eGPU to an Intel USB4 host you'll end up with DPM turned off and an AMD 
USB4 host will have it enabled.

> 
> Alex
> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e2199d8fd30e..29d5820e912b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1466,11 +1466,15 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
>>    * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
>>    * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
>>    */
>> -static bool amdgpu_device_pcie_dynamic_switching_supported(void)
>> +static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
>>   {
>>   #if IS_ENABLED(CONFIG_X86)
>>          struct cpuinfo_x86 *c = &cpu_data(0);
>>
>> +       /* don't worry about external dGPUs */
>> +       if (dev_is_removable(adev->dev))
>> +               return true;
>> +
>>          if (c->x86_vendor == X86_VENDOR_INTEL)
>>                  return false;
>>   #endif
>> @@ -2310,7 +2314,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>                  adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>>          if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
>>                  adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
>> -       if (!amdgpu_device_pcie_dynamic_switching_supported())
>> +       if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
>>                  adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
>>
>>          total = true;
>> --
>> 2.34.1
>>

