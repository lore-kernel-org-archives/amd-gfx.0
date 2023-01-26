Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20557C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 09:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D6910E1CC;
	Thu, 26 Jan 2023 09:20:32 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 371F310E1CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 09:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anVmijB585THIyWOwgaNu+NzivDPP5p4cnavuDBPNW8QcDzhnziICHXN596BJHYdCqUMbHrgtVi+8voqfCX4AZbYR+cS6Rm11mCPGG1bepEcoLr+ReQ4R8Cqhno7kFplcFqkq9LZLW1WDCE1dO/rxj86RV7V77arQSNOrj7ru5SZDIEcYqtBmx/slFNBORo9cVZ53ejEL0I+d4xC4nXDSpHGW+/l6uNOl8Ug07yiL9HSNbslK96eqLUUipLqtU98TS6qSzPyY7R/7EfH154v1VfWtQapy6FrquAPc6en+21OXA/wsteqWXsGMpYWMcfG0Efz4gAMsjV1SttvZa7D1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25CSd272vV578n3RQpAcBDK8iAU36Vm1kule1uc75us=;
 b=iWUkXXK6Z/Yg4cEzhiXdEj0ygVzjp4IGvnwC0qWiT1DqDshveVXmsRUbCQvzCMVZN1lqu00eAe+9DDJ99b4IkB+XnrVhkdg+bL6hmv4xNBTNrukUOi8cal1qTPHkLnWxVSZGHZDmXTJROds+LD7sOkFpGhjMFJgi9UPLERusnw4BF9idpOK/su5EQZzqdHfNIbR0Ak0lriMgBaG1YAt8rFJbAFu+MCkk+tKtxe4XfbKBChkjFXNJzJ/hgogTP0zX0dB/21bHwCIawfek3IJj7ZGBuYaj/F8EWmS0oMNpLbnfO5G7meIXvtXzBt+EsRxRYEJenn9tEUmzVh4Nj0aqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25CSd272vV578n3RQpAcBDK8iAU36Vm1kule1uc75us=;
 b=a2GLmzW3tB6kLyvDHLtgD9OGnvYnqN0ZoVc4U14iZ2WivSLa4jGnYUvpSeTB9/xYHb1QetC3rOD0re6/n7PMnUSrn7ZXmuNeT2/EBnxd3URY4hsV5EkqJBlkLVWF8RpEs+IrwfGwjrj2nE5LMxa3DI5dDF9zCjRVtxVbCK2BWsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 09:20:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6043.017; Thu, 26 Jan 2023
 09:20:22 +0000
Message-ID: <967c2b94-8985-e25e-787e-1f959b13b71f@amd.com>
Date: Thu, 26 Jan 2023 10:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] drm/amdgpu: use pci_dev_is_disconnected
Content-Language: en-US
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, yipeng.chai@amd.com
References: <20230125171630.112605-1-vitaly.prosyak@amd.com>
 <20230125171630.112605-3-vitaly.prosyak@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230125171630.112605-3-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0b4ae3-c560-414f-79ef-08daff7e8cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktsV3J604ns57PZnsCcjtNg1aG1qhTkwhkMtXaL6WjjLhe3S3Mg0h7eJsgTmdwcqhZBtMyUqgJ24cuKN8GxQg7j1W72zcY0GxloldcTGqHTeRcopFxDhcmWO7ILS0/HhyMUEBb/b/kGq5ZTnBPJFrYRY53CdHzbzPItGUw6uoVC/rKe7EzIaw5sUzb2lBHQovQqSzzI9c2WgnpIgoF9ZC2/wHuprBDbIb1nwha33XXmMQidCroGVACpw/0oJtppxI3AIUhOWQ2ZCSi1R1LG3HTFQnaJDZ5cZ/R9f6iiHgtejdWr2N76ExWrIFynP8pOt4ua5+DOtGU03waxrm0vI8+uE6vk5WejbIhNu4HReEe2xR5bePS/1tJjOKGBs6nfXWLDdxNM8DLU122PDvBe92GmFhLOKfMYG0S4SSatgpq9+Q0+JOI7lub2jT+Of9AUf1bcNtsq0qgZ5lxJ+V0yn1zfaDIPLR+mRL75ndnkhvJXECRdpTSnkHkz8Le3DLu+q8OmUvZAthX56Bat8WsvgjYM9PAWKMCrkWBBlfmL06TIxuN4803w/RX+3+T+IjsVNdwZSOFHCfkBboyawD+nX/zaYl8qlrWt8Zc+IFb7hCaFck+8ZVpbgbLF19d26B8qVaDbJK6JcWS5hRRc0uuP/mXnC49BgyRu/t/CCgLZqCPrdzDraVSM2eEyAEuJKliVKDYcSPgLaDkYowTzQwr/7MrWfWtBw33zGsMW09sbN6E4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(2906002)(38100700002)(2616005)(6666004)(6506007)(6512007)(186003)(26005)(31696002)(86362001)(83380400001)(66556008)(66476007)(66946007)(8676002)(5660300002)(36756003)(41300700001)(8936002)(6486002)(478600001)(6636002)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTB0YlkybDFndVNoVjl4RzhmMTM4UlFsZjZpSlpKV0x3WUJFOXpxL2lIZmlU?=
 =?utf-8?B?MXR4V1RPTlFXZ0toRkVkSTR5RU5ZWmJiaWhLem1BTDB3TUREMGJKelo3U0Ja?=
 =?utf-8?B?RWtTTVVzZHVoYTZncjAxMGhIMWl3d3JDV2laU0hnUEp6Yll0dVl0U2kxMHBR?=
 =?utf-8?B?aUtZaldIeEZYQzFpU0dFV0o3NXBsaHBkMklPTUdqc0lORjZkZlNSUHBVZEpZ?=
 =?utf-8?B?LzI4YXFaWHppVGcwL2JtZkpPdThMcjNNc1F2OW12TzJmYUYvSzdaNUhHUUx1?=
 =?utf-8?B?YVF3TzFCQmF5dHlLblVnVklHTk9ST3BjSHAwd21OQ0lBY2xJWGtnZ2JFV0Zi?=
 =?utf-8?B?M1RaYXBmWU9BTC9zQTVaWk03TWIrb1hqVXh2bWorR2VjNERSbEFweTlzRFE2?=
 =?utf-8?B?K0hOWVR4T1BCckt6S28rckZRR1U0Z1c1Mk1qUS9sdk9OOUVDQTZ0VEVYOVZ3?=
 =?utf-8?B?cDNlRUowdkI3bkpFaHFYbDRvTHgyc0I4ZkJtNlFnWUJkSURvVEZkQ2xvMzZj?=
 =?utf-8?B?ckpTOTlDREcxNlM5NWpxc0NtR0U0Qy8rWGQzZThzbjRYNU1IeEllYitTdjZQ?=
 =?utf-8?B?VlFpTkpEUVJ5Ni9Hd2ZRVy95dnRzSUtPUkRHY2xadjZSMzYzYVlTUGdzUkd4?=
 =?utf-8?B?dXZVWVNnRDRHa3dqckJxYmMveTRZYnhwdzJDQzQwMGRXSUVEMWZDTDN2LzJL?=
 =?utf-8?B?b0FTUmpqOUhMR1huYkhvS2Y3NytxMWhOTW9NRlZPL091MnlucjIyVzF5MXdX?=
 =?utf-8?B?NHoraWZhTU91MlpqYlVjdmdaaXYxUFNyb09WWGIyQjVDWUV2dVk4eElrNUF4?=
 =?utf-8?B?TFJIUFR5RjFqR0xGQTYrQXlxOU5hMzRvWGp3OVJwWUNFT2p5UEwvTmdFL1FE?=
 =?utf-8?B?cERnMElFTG1TVnNOZndNVndDM1k3eEZVUm9oajRmUDRWMlYrNEJzTmt2YVIy?=
 =?utf-8?B?RkZodW1sWXYrbDlBZzlFeDFzYyt5SGJwc1doK0JjbkNITnNHYXQzTmNVRDRj?=
 =?utf-8?B?NzlSeTZuTGtaRC9IZERXYTMzSXJsakljSVpucmd6YjdYN1gxVUg4aVJXMFU2?=
 =?utf-8?B?a2hzMWxhN0tpY3Fmblgva3ZwQVVwdzBQVlNvTXBFSjJVUm1yUkQrYkRHaGg0?=
 =?utf-8?B?UHJRc1B3Z2oxMTJtaERYU2tZUk5LVFlFNnNvcENVaUs1NG9mMjVSc1V5U0dn?=
 =?utf-8?B?K1Y4NjZFUThJSy9OQlJqN2hBREx3M25qWThvOStTSEY2RFdrOVFUTnpSSFpT?=
 =?utf-8?B?K25BTXpNVkxqTXIzU2FPaUtVYks2b01RdGdxWlA2RkZhWEdneERrN0RUdmMw?=
 =?utf-8?B?RlBrRzJSckNnaEtDQUxkTU00VElKb1A2Zm5URFFKR1hJRjJ0N1FLazAwZEhL?=
 =?utf-8?B?TVJLUDh0cVVSQWxKTWxnYzh5TW5sd3U3b2ZleFFVRERjbmloU0p6Vno1R3hK?=
 =?utf-8?B?Vm53WmpTOVdpM3prWnVCcWV2N003MGdpZ2ZDWWd4cnpqbWErc3RkWTkvNWEw?=
 =?utf-8?B?ZTA2ZUYvQUJmS0RmR3lnMGo0ai9YR09lVlNzWVVMSmU2aXFTeElNMUg5QlJr?=
 =?utf-8?B?YjExVkJPcVdwblRhZ2lmTzdEOFRiVkdmeTV1Y0NZMnhpeHl3RytuU0c5Undi?=
 =?utf-8?B?SDMwdGtUVjNnTXFCVElhZG9IdHJvMEM0Z3NIYVgxVmc4ZDhlRzNMaDk0c0sv?=
 =?utf-8?B?YjMvS0htTk5VT3h3NDhQMnJxdmtkbTZkQWtDbzZ1U2szMHVMdnhLeWdUc3VS?=
 =?utf-8?B?eDRsL1JROXJ2L3JuL0hiKzA0KzRNSjNmdzF6WUdmR1dmc3ZRaU5hWXJsQ3pk?=
 =?utf-8?B?TUdEM2thWWpQUExOU1hlTzY4V2ExaC85K01YTnRHTUlMdkNBc0xQbUNPMDZw?=
 =?utf-8?B?Y2RvN29VcW1UakZKZ0xjZEtpUXNrbzJ6SWJQVlY4bzhQalBZYVJ6TGN4SVVE?=
 =?utf-8?B?aGcycElZamxDWDI1Ry95SWV3bHBsYmRPQ1J1RmNTTXlGcTlMcGhtbVhlTi9W?=
 =?utf-8?B?RjkvaVRlRXRuQkxtQURHNU84ZGJFeEhLeHo0U091ckVzT2UxdkhsQW9mei94?=
 =?utf-8?B?OHZDYjNBb3NXZzhDUGI0TUlmc1hhUGovR1FuQzEra2M4M0l4WDV4N1JUb1NZ?=
 =?utf-8?Q?cHyD0BkqgbG8Mn2Vq5DZNmOOk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0b4ae3-c560-414f-79ef-08daff7e8cd2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 09:20:22.2568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93gQxZA4OY7WFhp/9LFEbY/3JL5+Zo9xOftTeoGSEsHMEnbl8n5VvUx9itYLrCAu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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

Am 25.01.23 um 18:16 schrieb vitaly.prosyak@amd.com:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Added condition for pci_dev_is_disconnected and keeps
> drm_dev_is_unplugged to check whether we should unmap MMIO.
> Suggested by Alex regarding pci_dev_is_disconnected.
> Suggested by Christian keeping drm_dev_is_unplugged.
>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Reviewed-by Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by Christian Koenig <christian.coenig@amd.com>

Did I gave my rb with this include path below???

> Change-Id: I618c471cd398437d4ed6dec6d22be78e12683ae6
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a10b627c8357..d3568e1ded23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -78,6 +78,8 @@
>   
>   #include <drm/drm_drv.h>
>   
> +#include "../../../../pci/pci.h"

That include path looks more than suspicious.

If we want to use pci_dev_is_disconnected() outside of the pci subsystem 
we should probably move it to include/linux/pci.h

Regards,
Christian.

> +
>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
> @@ -4031,7 +4033,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   
>   	amdgpu_gart_dummy_page_fini(adev);
>   
> -	if (drm_dev_is_unplugged(adev_to_drm(adev)))
> +	if (pci_dev_is_disconnected(adev->pdev) &&
> +		drm_dev_is_unplugged(adev_to_drm(adev)))
>   		amdgpu_device_unmap_mmio(adev);
>   
>   }

