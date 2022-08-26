Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E53CC0502A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 21:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE3410E68E;
	Fri, 26 Aug 2022 21:49:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD8110E68E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 21:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beYuF6KA+osjT2+z8IdNceQSVeg4H90bfg7E9nPNW02KN4RiyWRAYu+xxxZNHitbWJLnBUuLYgv3fSOfefCeQeAdE0eqBMboNjfziTO+iKZPK3Fi3DjnU4jzVPillyKX+7eM8QjjA3/uIWd9KgrWoHHE0EVEVfTKWrUeWf8iyHyarC+ce6xWH8o89tICpgO+AsjlfPDqNPOr+aUI+LYiXhrjd1tU252XE4w5ItJHS4uee5vYAUVxqUF3J5HaLCPDj7VY9WZ85+ldF6zS+qNohwEvA7G6yIj2lzAllHUufUFwUlmCWVYxa7e1zdpBZTS+fy5z2EqPBkREa2wjbqM6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z65ZKORjQpkSU+mpTKzHPd6bRtOJye77fI+gIcV/Mgs=;
 b=awHpKmPPKxvEBraFkcNxt0FBC3cTn+wkrihtnpG7WJRTa9DQvQgXUjdbpkByk2lKddGCceUo1Y7nRMGW+UMZ8IqN+V7DDteUtdSZYm4ho93Bqz0BwDVbmo0VehGyZW71Sg7sPF2XvZ8OOdM6+IZDwHlNXtiA84yjlNnbYN8imwJgU2sKmw72HJUx/2Cnh2VAAGtkfndOLqCo/Tm/U9h52+W1gHRseNVBWR6AdNw0ot5eNGN3St5fyhJh4eAF8YrLfa3uvtvvx0WpK9nLf+LzLysewpGYQ7Xzd5XgmR1SetuaLUizN2Ix5NgdkTJHMETm+iLYO4D0DA2xlrQaBSjABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z65ZKORjQpkSU+mpTKzHPd6bRtOJye77fI+gIcV/Mgs=;
 b=bdcb0zpM+u88FiFA+CehAnBY4rRA1ZRigau0AmpFlkK9Hg/ZRARp5ZUeE3NS7E9dFYtsT+Oect2rbpJkNsT/pI60sdRXLODNgPSRBMwg3ImHtK00NHrP2x/9vb481MjirroQ4tcC1zsT3WdesaA4nUQaoehp9Vxi8r8Bg+l2JqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM5PR1201MB0266.namprd12.prod.outlook.com (2603:10b6:4:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 21:49:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 21:49:16 +0000
Message-ID: <ca7c6e23-2a1a-2bed-7ae8-6a5092cb083d@amd.com>
Date: Fri, 26 Aug 2022 17:49:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: ensure no PCIe peer access for CPU XGMI
 iolinks
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220826154752.10984-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220826154752.10984-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:208:a8::42) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fc2b610-5c1f-4432-1f4a-08da87acd278
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0266:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rt+wA3SFMzCcA9+0s9eSlD+Ol3c8oSBfcdGkqJrHOVl9/V9BDKjq4Qfr24VhdWW1Kl7OejdIwLF1lOjSq0yzdjeMVePS942kGWMiLKW5u6BMs0jQxlAyaNxUBHFqjxX5HFsZ90y3mTfUAtac68fD4IBJlk6t/lSXC1tFcquXCZkfZDg3knZbO2yTpbkc6Nk7KdDF+UDRKAb+kYM3D3FT5VddpLL8JBNyhbpbfB0KRsgKcVw7OmJ4IMNEe0XteL5SdCYPVYA3c78ZsKSvEubs0GU37JUXSiYFwUCSyrQvFK0ylUjKWKW6O/GrPeeha6mhbWCBZZfzh4zyU28Gk6v7TxPWFmWL7/6NHlKHLYBddU5SQ0fAFx3BcQcCTMOf6bijef7zztsyXwvpPYYLj/PTh601T3KnmB4Xb3b6/tYQ5aywHr/xUiGOe8H8eIp8q+U2C1WJS2NJ80+t+FB7CH4a7HwWFFUW4pHELDuRA/7a3yIQwV0rjLRegH7bFI0GISrhzgWAafed0uQ264455qVKm19Uccle0s1mqVepzqVYpFdAG3LlM0pVEUqAkOskfuHJ/uryrjoolqgirQLhPk0bMaF17pAgFT/Eipe7t5bUFAKiK5O5EQwWZKSMq4x5rnA3YixCZ1B7Kz9kACAAMOizktyQy8YGQN80bikeNKmLTMdMktHuzx1VXD0IiB5qFNdbn8DLLWWlnlZkQKtMouVQ92gxJ+69PWMzY683yR3s7RDvgcxZGI8EKlTCgo4swEv1hskJcJdv/t82nF6z+LpHIGawiUxxhyyzUjAB7jQ9gkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(6506007)(38100700002)(2906002)(478600001)(186003)(2616005)(6486002)(36916002)(36756003)(44832011)(31686004)(53546011)(41300700001)(5660300002)(8936002)(31696002)(86362001)(6512007)(8676002)(26005)(83380400001)(66476007)(316002)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NpbVFjR1NPcjZiYTF6NXRqV1d6S0dmVyt1azViZWxQZ0h0WFJISGlwcTRJ?=
 =?utf-8?B?SmxQckJXNWdISzhjbkMrcEVhSFhreFN0azRQSHpOd0w3L1pmTWVzZ1FLdEpB?=
 =?utf-8?B?UHZHR2dFOC96RDlFb3Q2c1NOQ040ZlozTXV0ck5JNzVYRUpVSGpGdXJscCtF?=
 =?utf-8?B?Ymw4MUJyS2M5NGJmRit0NEJBU1phUGhiZW9la2pTd1A1anE5YkY3b1NwTEt6?=
 =?utf-8?B?cXlYeDMzR1ZmRkNJK0VraUFqOVA0RlZmS2ZiV2RkNjBJS2R2d2VTRHZpUWRm?=
 =?utf-8?B?ZnhVRFRPRC9sUnBaSXY4TFgwdDFpU01kOHFxM1NrbFd3VUxWWDUydThRUHdS?=
 =?utf-8?B?RWRJdEU5SjNsUWNOZVphTzRxdHprNVc5NTFqTzB4aFc2b3NyUkd5QmtMTERQ?=
 =?utf-8?B?Q1hLQVF0d2FFUDhOYzFYRXRVNHMwZmhDMGR3eWF0OTlhelN3REVQVCsrSGk2?=
 =?utf-8?B?WFQ5RjJsY1U2UUZHN0dpb0dRM2dhNmw3OHBlR2JBbmxUcWxJeVB0S256VnFk?=
 =?utf-8?B?b2xoeURBbU5PWFVCZDVibkVKdllORlNXNmVXbjIyY2ZGakNvMmdCWUJUQ09Q?=
 =?utf-8?B?OVlvc0U0MW5BRzd0MW1xU2wvUzcwSE5sdVA5RjFUQmdOTGU5M0pZS2VuNnQy?=
 =?utf-8?B?ZHZBMEJLaDhjR1RyTU5pZFI0dnVDT0pQbEZ0K1RFU3F2SW9SWGxkRVdPdUJ1?=
 =?utf-8?B?ZzFLYmREZ2ZRM2ZwNmFFakZVcjhRRk5wU1JIQk5FK1R1c0VVa1NabG9hZ0l6?=
 =?utf-8?B?V1djTUg1UzFvVmNFZFBiTDBSR3JBWk9zZjluMkFsZi8yc2tTdE5FTUlaaW5y?=
 =?utf-8?B?R3p5b1BWc3pVS1F4RG5NZG9qY3FoTmVEZTBucjduZXh3RmRNeXJ3VlJzeFFT?=
 =?utf-8?B?QWJCSlJPajY1bE1Wb0x1Vkl3MFF3eUFKNS95UjduVWdlTXVmelNqL25lZ2Y5?=
 =?utf-8?B?QmxCa0dqSkhjaFFUdEJoTGZ4T1NSTTU5VmE4RS9JanVHSUwvbUdnRzRvZTZS?=
 =?utf-8?B?NmdlUU9LQ0prcjNkczJRdnJZOVhwK2hXTHZNRHhnTi9LWStUWWt2WEdDSmxl?=
 =?utf-8?B?SWQ2L2pGcnJIa2k5bmI2ejVQN2VYVEp1M3IyTDZQNXNJN2ZuNzRIRXYzU1FQ?=
 =?utf-8?B?bUUydEJpendVS2VVc05rVFdMZ1U3TkpkNTlRM2RGMk9yTHZTb29DYndtMVpa?=
 =?utf-8?B?VFJrZE54Q1dpdnhUeTlWdE9HdjF0V3lWZERZbkt3Uk5OS1RNMEY2SFFKa3Ur?=
 =?utf-8?B?ZkJQZEJyY2wzVHRvZmJvK3VDWGxmeDAxR085MkQ2VkFBUE1TbG8zU2M5Tll0?=
 =?utf-8?B?a3B3OEVtb1M3RStHV1hEamU5T2NHV2dnRm1JTUJTOWkwK3lsM0FSVGhEaHlC?=
 =?utf-8?B?U1ZoS3RuK3RleUFrZHdJYTNrbjBieGh5OUhrNVdZNmx3UDA0TGpBOG5jdVpM?=
 =?utf-8?B?S1oyRTFlcjI5MEhVZXVXRHhQWUs4T3ZEWHl4M0ZBTGFDaWpkWlVzeVVtWUNM?=
 =?utf-8?B?YTNqekF4RVhyNGs5TWxmc001aHV5ZjZiNC9uaXBoNU5talBraWhPWG1SNWly?=
 =?utf-8?B?akhHTWZwT3l1dXpMR1BLa21CMkIwenh5dVdiZTZVcHdNUjhEeFFXeDE1THBt?=
 =?utf-8?B?WnBIV0E4Tk1xSDBJcjlyVk5sQUFGTHVtaWNaZERoZFhtdDRLUCt4UXRuWTMv?=
 =?utf-8?B?YnpCcjVrV25uVzZ1d0hiRzRRL1lHU29STFN4OGVuV2lHRXQrU0ZjSjh0Y1Bt?=
 =?utf-8?B?ZDRRWGdmbXkzMTlRK1BFRkt2V0VEN1FHTVpiTGN1K0pUVFJHVEJhRUEzbmts?=
 =?utf-8?B?VWRaRGEwUkxORm9mbzFIM1ZJYXFMZHhUcHRLSnhkOTFCZTd4bEdwSnhXSTJL?=
 =?utf-8?B?SmxnbitOWGdDc3JlRmhoaE1nQ0F0Nzg3cFoxKzFjNVp0SzBZcHAzblhNVmd4?=
 =?utf-8?B?WHdFbzhObjFLdWpXZ1U2TGdlUTdrVW9ZZ0hpM1NsNzZSQjVzUktWR2trenZp?=
 =?utf-8?B?MDYrOU9mNERZaXY3YTVPV1VrSThZUFVDNWIzN0szWDJ5aWpaUnR2TytNNFZB?=
 =?utf-8?B?c3UzSVU1ejY3QjJMNkJLSWQweS9vaENUZGwrNi9HRFZnWi92N1NJOTRzRXc5?=
 =?utf-8?Q?2eHqyVmA6KucNSZGr8Z2kB5X7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc2b610-5c1f-4432-1f4a-08da87acd278
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 21:49:16.2652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyaILD5IuEq674Qq9JFLpj3+zcYn3K70NovVugWR+O3jsPmS8t6qJrOIYmSbZESdoGHFKNTRrKIKGFOJ22LwCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0266
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

On 2022-08-26 11:47, Alex Sierra wrote:
> [Why] Devices with CPU XGMI iolink do not support PCIe peer access.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ce7d117efdb5..1ff66718639d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5538,7 +5538,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>   		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
>   		!(adev->gmc.aper_base & address_mask ||
> -		  aper_limit & address_mask));
> +		  aper_limit & address_mask) &&
> +		!adev->gmc.xgmi.connected_to_cpu);

Maybe it would be more readable if you added this to the initialization 
of p2p_access. In that case you can also save yourself the call to 
pci_p2pdma_distance_many and all the aperture checks. Like this:

	bool p2p_access = !adev->gmc.xgmi.connected_to_cpu &&
		!(pci_p2pdma_distance_many(adev->pdev, &peer_adev->dev, 1, true) < 0);

Regards,
   Felix


>   #else
>   	return false;
>   #endif
