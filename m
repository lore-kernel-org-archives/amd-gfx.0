Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6998DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Dec 2021 16:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B024510E121;
	Thu, 30 Dec 2021 16:32:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CB810E121
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Dec 2021 16:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH8P7EfDEwSxT+0iWGWx67vGxk4UpW+7AwJVKoFGk97W6ZJXdLoU+pt9LGhrdH3fYLMZb4BZMLbOK3gchGvsYrZskjuLScksic65wMZCH4DUsGlJ+z40F6IDCtbMrzyspXZDEG34aPFBzwGZ/phb7dcd0mfd+my0SJF4ZNkzGaaTrTpJhfu+uG2SesJoTGuMglxGRSXOJl+Vqu9AYjhE2VYqz5csIo4t9NIoB4hkyHs/yYlk7dNNnN//2mz4Fsyren1djzKUl1XWTMacv4O83dYOCagnpWYR4tFcDnPe1taOBz9prrIICVwO01Hh0SeR+atgN7r6r56dmlDZMs0AyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiwGnCH7RUwCA9cmgm9tNy3At2C5+lAb3/VdipEoBEc=;
 b=UWAyhR56TKUa5rWKaSdODMWiiiY6Tzo53rtL6OfCGs9mpsMlrseHfcbyzzjPqUgVKPNj9q9ZNYF6Od+fxrQbRwmmP5CNogcR9xrpkcrv1rjo2P7hbhR61CuetK939SYFY5wr2mfl1m35utUgh47/3UXHUIuj8wu1kDvmuh+Xcpor4VvCDcUpFKHxNnTmwUEcfV13E+mNjuf6ZW/FbPPS8yLECE4s7QwRhwohzCQ1CL7w53x2HlS4sF0hS3kFFOSQj6J3SUFl8grlfA0ICZjOCjiQD0yYcuttRktB52sM/bMzW1lVyGLF3RpH4hCQpnCCzB3DxwoHR0HkJc8Cg3pY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiwGnCH7RUwCA9cmgm9tNy3At2C5+lAb3/VdipEoBEc=;
 b=mCzhsfYR9lGaFMqlq5NFyRV4LoEZN/jrUQ0kyb+b4V79iOOV5WWUdXXlrhIgKAYNSo7Sa/docy5vaX4ZqOzL9OnoxOEvf3FX/XrhCyBDUxlnpHli+5saTTEaLmUm+2mO/ash3EjS+y0SXI0BzejEoZ8Q5AOtCSxU99pOFGsyHUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 16:32:10 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::17b:556a:9bb2:60e7]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::17b:556a:9bb2:60e7%12]) with mapi id 15.20.4823.024; Thu, 30 Dec 2021
 16:32:10 +0000
Subject: Re: [PATCH] drm/radeon: use kernel is_power_of_2 rather than local
 version
To: Jonathan Gray <jsg@jsg.id.au>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com
References: <20211230050019.18402-1-jsg@jsg.id.au>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cb3ed5ea-4f20-2cec-2e66-1931f210342d@amd.com>
Date: Thu, 30 Dec 2021 17:32:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211230050019.18402-1-jsg@jsg.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6P195CA0047.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::24) To DM5PR1201MB0187.namprd12.prod.outlook.com
 (2603:10b6:4:5b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50e9e1ed-7c1e-4929-cedb-08d9cbb1ed58
X-MS-TrafficTypeDiagnostic: DM6PR12MB4910:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4910104B8CCCA052311BFFE583459@DM6PR12MB4910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6PF3Cns7sKdjbkh8yB1fmA+jp1iZYluBlSe4tyRCXqgRNAQmFYB1OzRLjDU4e3yt+EVfgiT99VDnQfBAGmOgQPjGGeJyOpli9nnggQahUKXBVtEJQQGNp7wkTjlAqCWGxQh/QZ3uto0WurD/ifZ6dtu6xoZ+LO5Gqv2MbXoNMkYbhLej0Nwr3b9tZUDJILxxjpRQ8IZVtxytWe6T4HZNwyCSwF71MaZAKNesfXSSF/ezqRLx6/Vmaazsr6WXbLLb5s68k+oSMfaDdj3bBTA4KwJEr7xoWlM9T1GBUmp9g8UhyhJ3VMip0fuzVlo2H+eT0MCvReg5clpHal7fjodq1SPqdCDilc+IAP0j1gBQV31cw4OD5bNQNBTyY+R63QSo/GBRDrI7v8U+F63o8VU723GKp9fU2lGNB6TM/Ig/GJ5F3iZ6n+55dDMah19JAEv7AIehWkuihFt3SAnRroqpHnShzU6n9ekVhgfh/czw4bqt8YSypUVkiQe1SHyI7opS/HjYHzvItKAKwG1ZjGEdDs6ADGF4oIt+xi84moHdW4HQrJP8RS+TPY3/f2rTbDKTfPdIHtqKtKdx553NrKzDLornaumgx/k9eMluzkuYo8c1XGGQtDJKKOf3cSeILF4wmMbmFXPRVzqcAHVrWxsrKD3YSQe/6UZomCQdVNKb1Glf5aXMd+CTa31gxnrGp1Yj6z5jHw7sA8E/AAOKg+FERuLtVZ+WGhUThWbbKGi8G8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66574015)(4326008)(6636002)(66946007)(31686004)(6666004)(6486002)(36756003)(31696002)(86362001)(8936002)(2616005)(6512007)(66476007)(66556008)(186003)(8676002)(508600001)(5660300002)(38100700002)(6506007)(2906002)(83380400001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXEvZXRRZHU1VFlMRmNrZ245T2JDdmhWNDVmNUNiTWJORGQwVHhVajVoSnhk?=
 =?utf-8?B?NVhIRGNISWdIdkxEMjNBVEcxNWdScWF4eWFnOVBoYVA0VkNqZE5VdnlLQVps?=
 =?utf-8?B?OHhzTlgzU1hHRkJRaXJBZGJKanh1VVorSzFLS2FJTGYyVEdkek5veHpQQkty?=
 =?utf-8?B?N0xDUldTVzB0cWVoNGJSTUtKdE8xaStPR2FzTjc0SEFOUndTSGRodnNyL2hm?=
 =?utf-8?B?UVdvQVlZWk1ha2J5MEJoRkJibStxL1JzWFMwTmQ4bmZaV1RSU1Yrdm1xREw2?=
 =?utf-8?B?V0I3L1VUaHNlaTN5RUExbDRPQzlVRndDYlI5bFhuWXVwRWZSV29vc0JzaFpT?=
 =?utf-8?B?ZldsN0ROL3JNWnU5blNKUFYrMGkxVnp0eEVYSWhIRFU5UGRDL2pkc1hrSFI4?=
 =?utf-8?B?Z3c4cjRIK3I4NXR1M3VoYkJzSmdHNjg1dmVlNXBzR0FBQkpSVU1iYnYwZ0VN?=
 =?utf-8?B?YURaYjBYZDBOTnRwZWc3YjlObXpMOE5YRjdhODJBaHJQaFMrTWRoMnhrNGE2?=
 =?utf-8?B?Z3E0Rzg0SzVqdys1aGVjMnFiVHFRR3YyWC9Fdi81RzRSQUJCbTFzN3FaNm5I?=
 =?utf-8?B?ZXArMld1Zi9YVjFIckgwYk0wVjI0ajdGeWRreE51Y1Z2Z3VxenZLUnNzb2Vq?=
 =?utf-8?B?dmRJeEp5S1k2OTBFdEcxVmJwQUdqd1BoNXBVN1FUNHdjM3lEWEpBNVRWRVpZ?=
 =?utf-8?B?NGdtVGNxOGplQTBFc1hHd29Qd0J3UGlGNml0WkVnVU1Za2xMejRtUkFwd3du?=
 =?utf-8?B?TmdPM3pMTThUczYyL0dwei9LaWltNFQ2cTZJNTZCcVgyREpqbkNIb1dMdDJi?=
 =?utf-8?B?cUY4RFlEYVBBS3BiRm4yMjhpZFZ2U2FmT1c1WW9zVFh6VkFPSjBlTmhpT1hk?=
 =?utf-8?B?V0hJSjNVZ1VkS0M4QXNxSVJ5TnNXU2piTGJ6em9zSFJ0Q2hnTzlMblVVWXZs?=
 =?utf-8?B?WGNRdFVLZnN3bkhSWGVaa0lTazFnZmpvVXd3akJWOUptRzh0eUdSb0pMWXkw?=
 =?utf-8?B?RWgwOXpVSTVyRUpoYlp6VWt0azBIYU12eTRRL25iSEJVYTlJSlAvZDg0R3gw?=
 =?utf-8?B?c3N1MzhoUzZ6cHhkZHl1RE45S294cjJxTnE0bSs1aUY1aTJxSk1hTXBZMEZm?=
 =?utf-8?B?TkFJN0JFTkw4SVJ3UGd3UkwxUVNTdUViVGJGdWxLSWszbzAvVjlLSnlNcTFI?=
 =?utf-8?B?T2I0YjVyenk4bldCM1dqVGxsVERqVGNIZHMxbjZUL3RSa1ZNa0QzRDIvUXg5?=
 =?utf-8?B?bFV6b0Y2RU1GUGlqVEZQMkFISnF3ZlFoZ3NldHEyS0hrbS9rMkxmT3JyWDlz?=
 =?utf-8?B?RVZVK2RSUUV6azZFeUlSTXQ0ZUlhN0tTSEJsUFhBbFE0N2VTaGhRTUFGT3hy?=
 =?utf-8?B?SWF6SS9nbWFOcFJ6eVE4K3JoNi81SURsR0xzUXJpblBZUC9nTnBkUUhzQk1W?=
 =?utf-8?B?bHVaODROcW9yUGhTZmZrMFZDT1hLaGNUb1FMbUJ1cjNzaWw1YXJ0bmJWSmRs?=
 =?utf-8?B?WjNBYk9jaWgraWZYNy9oREovaFVVU3dqbVpWbGJMTjJ5dkc5SUlzMXBKN3dL?=
 =?utf-8?B?bVNhUWpsaHgzTmdiZytPVWlTSGZ3MVFXQkFxN2NVMmM2VDlTZzNVSHAyMFd1?=
 =?utf-8?B?cnpDcEl1dmtXWGJIczB2VldPTG1LLzBVUlJRQlQyNTVheHpQbGI4OXUweHBi?=
 =?utf-8?B?Z3ZlVDZvcU84dE5rSTU1YndBNGpqcVFRTzNKL1FkLzljSnRPbEdFejJuUVBt?=
 =?utf-8?B?c2VGVlZQTFNDREgwR1lIbjJwTitmdUpONUxXbWtqaUNuMkp2dDljZVFkL2Q0?=
 =?utf-8?B?WndmdGxkYjFGdVZ6cmNWVUtXbnVyK2NkNmVJbUwxcjgzNSs2LzlUd0FDTTVY?=
 =?utf-8?B?bVlmRnNFQWFpVG5aTFJpeTRoYVFHNzdPS0dwemFVWWlCckxmODB0WFlnbkNP?=
 =?utf-8?B?anFEUXJsVEJkUzNGanF5U25FQlZjSHpETTZiOUx6alZVR2gxLzFnUUxMSm51?=
 =?utf-8?B?T1lub3BTQUViY1hlQ1d2UnpSZ3lwSU1lNXhNdmxUQ0o4eUZSQ0hMTGh4T0Rx?=
 =?utf-8?B?bEYxZlRoRTlCbHNkR09ON3ROTERrS29MUno3Q1ZUdmQ2VTZnSHpBNmtSNHdu?=
 =?utf-8?B?dUNmdzhYMk9yRVdReEdiU2ZOa1MvL0xlUSt4ZUVweEo2bVhkeW0wOFQ2QVZR?=
 =?utf-8?Q?wOrky5sT7pA/URRLcdtP1Hc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e9e1ed-7c1e-4929-cedb-08d9cbb1ed58
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 16:32:10.4587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REcOi3fjNk4wz+O6KgE4dYku/zlH5j5P2rNbskL48CEevC11hiOHQ4Vdydn+uo3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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
Cc: tbullock@comlore.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.12.21 um 06:00 schrieb Jonathan Gray:
> Follow the amdgpu change made in
> 7611750784664db46d0db95631e322aeb263dde7
> and replace local radeon function with is_power_of_2().
>
> Signed-off-by: Jonathan Gray <jsg@jsg.id.au>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/radeon_device.c | 19 +++----------------
>   1 file changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 4f0fbf667431..15692cb241fc 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1085,19 +1085,6 @@ static unsigned int radeon_vga_set_decode(struct pci_dev *pdev, bool state)
>   		return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
>   }
>   
> -/**
> - * radeon_check_pot_argument - check that argument is a power of two
> - *
> - * @arg: value to check
> - *
> - * Validates that a certain argument is a power of two (all asics).
> - * Returns true if argument is valid.
> - */
> -static bool radeon_check_pot_argument(int arg)
> -{
> -	return (arg & (arg - 1)) == 0;
> -}
> -
>   /**
>    * radeon_gart_size_auto - Determine a sensible default GART size
>    *                         according to ASIC family.
> @@ -1126,7 +1113,7 @@ static int radeon_gart_size_auto(enum radeon_family family)
>   static void radeon_check_arguments(struct radeon_device *rdev)
>   {
>   	/* vramlimit must be a power of two */
> -	if (!radeon_check_pot_argument(radeon_vram_limit)) {
> +	if (!is_power_of_2(radeon_vram_limit)) {
>   		dev_warn(rdev->dev, "vram limit (%d) must be a power of 2\n",
>   				radeon_vram_limit);
>   		radeon_vram_limit = 0;
> @@ -1140,7 +1127,7 @@ static void radeon_check_arguments(struct radeon_device *rdev)
>   		dev_warn(rdev->dev, "gart size (%d) too small\n",
>   				radeon_gart_size);
>   		radeon_gart_size = radeon_gart_size_auto(rdev->family);
> -	} else if (!radeon_check_pot_argument(radeon_gart_size)) {
> +	} else if (!is_power_of_2(radeon_gart_size)) {
>   		dev_warn(rdev->dev, "gart size (%d) must be a power of 2\n",
>   				radeon_gart_size);
>   		radeon_gart_size = radeon_gart_size_auto(rdev->family);
> @@ -1163,7 +1150,7 @@ static void radeon_check_arguments(struct radeon_device *rdev)
>   		break;
>   	}
>   
> -	if (!radeon_check_pot_argument(radeon_vm_size)) {
> +	if (!is_power_of_2(radeon_vm_size)) {
>   		dev_warn(rdev->dev, "VM size (%d) must be a power of 2\n",
>   			 radeon_vm_size);
>   		radeon_vm_size = 4;

