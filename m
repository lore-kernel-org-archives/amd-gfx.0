Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B2AC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 10:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E61D210E3C7;
	Tue,  9 Jan 2024 10:38:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2557B10E3C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 10:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfn2YBvUAjWB39O/Uai6rZ9U/+5BZWiFwQg5FLZfX1UIzcprkVFFEVeoDseRLkZmGYNrm7F7tXLR69DsZRS9pIxhi0bjYS1K0ngXA0+JiYKmcyF4mLyZ6OBcsgHDwAicYLj3FzMBRM9/vZVff/fpTUCUg1nHsKowi5TwpmBaojRpVzVwz3cFiAoJMu54jClGQLdEU27Ddk33JlktC3ILR6jVDlCdeLNbhzIm7f0R6dLI4kogXQlPg1JYfrisv0aNgCi0W8BYPGD5HYYqiRLXMk+kBoxRDj702QqnybVR5mhW+f3uCDELhsXNhR3OVKj/8V5krEpDsqWR+6Rx/h0/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huobH2tdDPu+OS6FvLHoGDg127c7ytKkbtAV8bPetHQ=;
 b=Ez4PV0YEiFTLnNZFM0rg0Nl78Z/t2nXzyKQBiafNhQ06tzeokNHCs3pP1zNNar/TUITpQt/tDHPsBB/T/rgjGLaTTcicPyR+pDT7zIDjN+Y/1Kwo7yt39gL8hENcQEMGP7XdkoruBcHs4Cnna8YUcauJnhwHoEzowhsvj6l0PJDJ9U//gvydPmOmIG0BmwZqqmJXQlNgHIMYIT9DABWMpcj9s3PtUnpnY6rvCuslc6J2FNaZC7rCI8K+v0EJHOB/CkV+tY3G0uMiY0pMmBKbrKPAi1Fed5fWWH2Gx5oMfYVd8IU+hnRMk9QtRiVxIq4PHWOdk4LCSYPIoETMf+hmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huobH2tdDPu+OS6FvLHoGDg127c7ytKkbtAV8bPetHQ=;
 b=lg6kp40cq/MHZ6A9EFUM6a27W+FC0vGbI/hTwM1l7N0+MX2Id27flYB+oDKginnpVlHgXECKZNKnwK60r6l0wcb8kA3FQ8zyVu8VxfKSEy1Ug3Lz4so0H3dvy+AjNUnG8EJiqSRShOeW1EJi8XyQutSLeTwluNB6vVFEspdKQP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 10:38:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 10:38:19 +0000
Message-ID: <331dfb1a-bab8-4ff9-b386-c62d55dbc89e@amd.com>
Date: Tue, 9 Jan 2024 11:38:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Check extended configuration space
 register when system uses large bar
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240109103104.645692-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240109103104.645692-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fcddfc-84b0-4599-846d-08dc10ff18b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aDIbiKfqXKfBZUo9UR+N2AKjvdtmJPs36V1003gAerWsSsnlyDMlaFi63cwlixE0R7oVgNyG6+NYam8Iaww731krS+F6bwak8FEYfkB+mbIR07l8bcnQ0ZFWUWmVq1abd6Eiv/cg/pw4Jnmy46J6wRz2tFrJcAVvKtCcB3P/Q26mUR7b7eL1AZMl9/+791GLadZ1MABdpqxAvpPzpnj2s0UYb4TTHG8xtll01SAw589njLgWds1om9UNzMDgmKEv6+xpWa0G5ddn7SlBrfZ7PtC+qbxY28oNoPqJDSuIbfB7B4jK6TFEWvfIOiSzvH7nBOXXqxXTzsc+A6Kep+fuDXweZ7LfkMpYD1L+MYV8l2SdzVj3CxBQsCVJYu6FAbcrv3wcQyibXynJP/kq4Y2MryVN3yrIjwgM6CFwx/mYT1gXYyaIg7rQFeoiCEfhGAuRwiZAcDPNUdjhVz8R6+N4uv+fbtPQpNOCJwXiPb6TizaeMIpfKtwl+cTgbTYEc2F7oACRTVmU4Ea3sMzdbKjdeSKiTqFiFGrozBWlB+f0HR9Wtk+VFVnC3WnTAUs2vQ4G8JNbNG2aO9dSiZjyOiskUo/Y3LfuVkqFBz9yRvss5dU8QXyxFhCbBePOyO2Jkj9ZGIB3OWnsti4JCCJNV+OfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6666004)(2616005)(26005)(6512007)(478600001)(6506007)(6486002)(83380400001)(2906002)(41300700001)(5660300002)(6636002)(66556008)(66476007)(8936002)(8676002)(316002)(66946007)(38100700002)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHVrUjF1M3lKa205MVQwYURVRlBVL2FLT3NrMWJ6RTJRWWRGdHBQQ0FENUph?=
 =?utf-8?B?a09zY3dIcEhpYVFJbXhLR0ZCQXBmUGRsS053N0lYanRUNDBFWmFvdloxWWo5?=
 =?utf-8?B?ZHhUOXhEOWJka1N2aDd1cFBta0FWRlFKRnUrcGV1YVQ2cENDZXMzZjFDYUdT?=
 =?utf-8?B?TnNndklVbkFEYnJCVzRuQzNieGMvNHJ2bllzWHUxTUlhd29jSStESzF1d3l3?=
 =?utf-8?B?UWMrWHRoc2wyN2RtNDdtUCtOTEVRaklROXp3QUcyNzJ2emtNMzhVK3NSTTg0?=
 =?utf-8?B?L2hXbVpNS0E4N2dmVU13bVFjbGFrb0FJbFpRTUlQbkZxZFlWMEJuVERNM2c1?=
 =?utf-8?B?WWpyV2I0QVprbi92UDNudy9PRzNJcHAvNEd0bXRIUit1TDR4dno1dGpFQ0Z0?=
 =?utf-8?B?ZG5MVEdMZjJvMGE2ZnRucjZSY2gvNHRnTk1YazlWM3FITkVKZy82T2xhTC9K?=
 =?utf-8?B?b0JUTWtnZFplTlk2YkIxcUEzeHpRVWFnZUNHa1k0cVpxMDh1VzVHSE1oS1cw?=
 =?utf-8?B?WWhZQVFiWkdyQnlXMDl1bytqa2lPRW1CT055R0lneXNPNE1DU3ptVmF2a3lX?=
 =?utf-8?B?eGRCWlJlU1pCTFRITGhvV2NWV0FSbjlsRkxGaDNNR3RuUW02TGdGNVRuU3dx?=
 =?utf-8?B?OTlQQVdFaCsvckRZMkR4S3BsS1h4SVc0UlJDcHI5VE16ZTFIOTlpbnhpMDhF?=
 =?utf-8?B?QlBneGJuQzlpSGdNOHoybW9URzcyWXMzWDZsZzY0cU5qMG85b2hYQlRobGZa?=
 =?utf-8?B?TG1ySEhGbmY5QWtrUXppS21YeC9nbm5LcUNVSGwyemdLZ3FaZXlueVd1OEI4?=
 =?utf-8?B?VHdCN09ycFM2NUdjSUE3Y1dqSmlBTUJld01PK0hQK1o5MThEVnQ4eXNzNHV2?=
 =?utf-8?B?Tkw3NmpVQWtlR05RTEpKQkR1RFIvZlMybG5kc1V6R2IzK25tampLTzNoNzVs?=
 =?utf-8?B?Z1V1ZU85eXF0TjNrWlAraGkzWGw4bXpOUFNRdGpQUFVZd05mWCtzcjdNcSs3?=
 =?utf-8?B?QUJMZlVTSjdpTDlzK3RnTktOaHViV1RKVHJNZVBvRkVQYVBYMkpHQ0R3bjNx?=
 =?utf-8?B?Mk5vcWNFSjlHWjR2aGY4cTlOdVlnbHhhK0tqZEVFemluR3BsZUxWY3J1VWFs?=
 =?utf-8?B?Snh4ZElCS0QzdlRtSDByQW9zMUJid25FaDBiQVl6cmplSlAyMzl4SDB0ci9P?=
 =?utf-8?B?ZDlOTVI3cVpmSFpOdVU1MkdPTnJDUTNFUnAyakZwdnFZZ0E2enpNYWlsRTNq?=
 =?utf-8?B?cWthMVhteldqSVRPRWc3MVlBZXV6V2UwWWp2Rk5vZit6ZWtSMUlnbFQvWC8r?=
 =?utf-8?B?a1VVYXM0djR0dHRLT1JFUlRNUnI4SlBLTEdCY1lxdituU2NaZzlyZVQ5K0Yx?=
 =?utf-8?B?OTRGelpnamhUcFZPUXVQbDh0S1NkUk95Q24wMHJnQkpzbHpTZGN4YnFCRnMr?=
 =?utf-8?B?YU9oMjVCdWt1M25IR09aSmZQMXZ2TjkzcUIwODk3YkxQRHFXV24vUU80bjZX?=
 =?utf-8?B?cWNkRUV4dUYwN2VMRWZlcFJRLzhHS21pcHhrVkk3bk1YSVBZejVYUlhmRkx2?=
 =?utf-8?B?ZnJwSm1VWXkySnNFenNuQUtZVGJYWnhvOFBRcEdFKzZmMkQxQk9EMnp4QlR6?=
 =?utf-8?B?Z1FKM2w4a1ZJQjl2dHpqOVVFNWdwWUV2MnlvS0JLUDBCdFdNbXhJZWpTR3pK?=
 =?utf-8?B?UzhOdmJoK3ZrdTBpTW5qT1hIQ2drVzQwMDUzYnNLSFp4VzkxSWdjaHRjTFg5?=
 =?utf-8?B?cVRJUHEzTzBRUjlmaFFsODZTNjB4RGpUZ21SR1cvNkJhYnBVZ3Y4STlxc0t4?=
 =?utf-8?B?V29HbGp5cUFXWUpxMWU0UEJIcnM5TVcxdXhxQ2ppWXJ5SzdOU0NIVjF5RHp0?=
 =?utf-8?B?MlY3L1dkYkVUYTEreWhLd2tHTHRaUmpxVTRzUWRlNzVUakZLRDIxUzdNYzJF?=
 =?utf-8?B?NXRLK0xyMm5zSWpmN2MzS3N3YUZVbkgrMkhsMUgyS0k1RFQzUWlRTGRmSmpr?=
 =?utf-8?B?bzZrb1hMVHA4aU1SZ2FaR1V2N0JzZEFyKzNzTWRkUUhvaVJNME0ycEdldTFZ?=
 =?utf-8?B?S0NZZ0dxK1d1bGxHUUtaeXJvOWZTdjkreGpUV3JTTmV5eGNsUmJTQS9IRHFG?=
 =?utf-8?Q?n7pSrsMx7ZugQfuPQdFVlX4+4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fcddfc-84b0-4599-846d-08dc10ff18b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:38:19.8931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEcR5u7x1/AtpVV7iEouVMnhZeSOI0JVX10DIVcaWcCXzgcAu49xWbhYKcLaf3bO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

Am 09.01.24 um 11:31 schrieb Ma Jun:
> Some customer platforms do not enable mmconfig for various reasons,
> such as bios bug, and therefore cannot access the GPU extend configuration
> space through mmio.
>
> When the system enters the d3cold state and resumes, the amdgpu driver
> fails to resume because the extend configuration space registers of
> GPU can't be restored. At this point, Usually we only see some failure
> dmesg log printed by amdgpu driver, it is difficult to find the root
> cause.
>
> Therefor print a warnning message if the system can't access the
> extended configuration space register when using large bar.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
> v2:
> - Check the register at 0x100 but not resize bar register(Christian)
> - Modify the commit message
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4b694696930e..0d7d55f13b8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1417,6 +1417,13 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>   		__clear_bit(wb, adev->wb.used);
>   }
>   
> +static inline void amdgpu_device_check_extended_capability(struct amdgpu_device *adev)

Please don't use inline when it's not necessary, see the coding style 
guide as well.

> +{
> +	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
> +		DRM_WARN("System can't access extended configuration space,please check!!\n");
> +}
> +
>   /**
>    * amdgpu_device_resize_fb_bar - try to resize FB BAR
>    *
> @@ -1444,8 +1451,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   	/* skip if the bios has already enabled large BAR */
>   	if (adev->gmc.real_vram_size &&
> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
> +		amdgpu_device_check_extended_capability(adev);

We should probably check this case independent of the BAR size since we 
will most likely run into trouble with error reporting as well.

Christian.

>   		return 0;
> +	}
>   
>   	/* Check if the root BUS has 64bit memory resources */
>   	root = adev->pdev->bus;

