Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73744C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 13:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC2C10E4EF;
	Wed,  7 Jun 2023 13:23:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA6F10E4EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 13:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNcXmceMnvzTjrPc07PsYh5NWpAdnh5OiggP7LGj9850C2Faw8KQt5/VI9t0iMqTtzsHryCf6A3wU3OBd+2Y3m89T/RwQ0GK2ywStVtZFl83yGc5xHoGhk/9OKyL/gmUHpe67Wuc0WsSKRgeYCedM3v9TJCE8odTx9rrh6LUezkE2Lr2166J3usFWptmedH9C8qJZMhGQRrPVwy9AAXqybLekD31JcaoW1CUOatPeWMmsLGmlWU1k1LGZ7Z37U/q+nslIuOhgUD1MojYJrl0FFyy/qM/Xvnmk7SfrTwbJvJ4CbFuctLoYFvwav6d8D+rWlLX2DNGDUhZ51o8cbJLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT3dXiDKdzGWE00w5CTG/lLYpo343tfphp7DkxNfhS4=;
 b=VQyIDky9YoMU5HAhjDAuwgHUoOvi4RDXEHavFWZH6L2sdHO+0K0PR/VtZcmkQJDEnObCCDqL0gilw5IY6CLRNlHjmFOZQcXB8UNUbWKNdx6eEegn7FxiudZt6fQARutj+x7T5xc+NgX7dXNS/hpyovM0/jg0UZCozwWBL8Y7Fd0FX7oA3sorZfM9LZdzsdHmAJSoJo8Pj5TYnqM9FlWwcnLsf7PRujs6iDTvLK485eRTtSwhKL4/WpISqvXg80FU/exRzlWnvSSKao5QKPDlF7IFOVM/fGM+Nathl3hWfIfl+UYZZ4iQ5cvky18eqdZO0XVuZE6SQJOPlf9vA+/UGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT3dXiDKdzGWE00w5CTG/lLYpo343tfphp7DkxNfhS4=;
 b=xzcRYuzF++KKb6ciiiHBEwcveqFZDLWQjhld977x1umRSKgBmRSZHqviPYw0PKJZEF5lcyzEZJs+EQd+yBnUjGWXNJ1pZm40liS7E84W3LWHelIkbFB/78Aunbd3CA1SNKpbeTo7N5Vea/M6RkVZIfAku44Z8MdU+wXBlZgnQ+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 13:22:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 13:22:58 +0000
Message-ID: <1fecd6f8-fc2c-7584-0c6e-067fe9426b4c@amd.com>
Date: Wed, 7 Jun 2023 09:22:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Increase hmm range get pages timeout
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230606195717.32605-1-Philip.Yang@amd.com>
 <20230606225359.5378-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230606225359.5378-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0207.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da32859-c36f-4737-5aa9-08db675a4fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXMpxOK9BZNwZgpuKfWnJigfkjWaFS1Ro03M3EuD4kM/dY2xfkj4IJyW+2CipLso8+3Ll1MTsxg8irTEdKIhccYPq3xcGlqetMNMVo8DyOAceO2161ab7qbKVwVCpTD9elv0brZCWEp8yMXBgTh4jWoVbrZeZPdAJ1FTi87KFmVGad1OxVOZ/sEDqdPNxNcZxo9CDx74swcOBtlf+bCrl8X49CgmhC/p1+rGWN0I9lDAgTC2ilSmYziUMipVXSpTWI6zxy5lQcTZ8tI8zlR83py5IeItro1btsYewQuMhaGnO1nTyBVAyrx7k9MLDGFA55TDADnpSnlWhdACMGnHlKuutfPG8ma5QhsWsUgkiwx8TFwt9rL7SWF3jcJcdvtUYPbo5+FgZ0umlRC0om8UuKUOEYaYNT0BZdAzrx99jyU82dQItPhJY3z184n0we3cylDmEoZnZWlvEkfFvQs6+aCG5G9V9EANBqn8mTllaEM0DzbhM3IqsdgPQHvmWV6kERGBCQAOWrUETsmvGDHw8fX9mgSxFho5VIe00KPYXfdHbNnOKOAfwZNeqaN7lKXDdrombKnitpPL8aQZUPzUYhIYO6cb5+C/iuUmx/aCaq8yjvwFEE8UdbYVTG4nurN/Hxp76r3rE+gy2k5GbMEzDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(36756003)(26005)(41300700001)(186003)(6512007)(6506007)(5660300002)(83380400001)(2616005)(8676002)(8936002)(478600001)(66946007)(66556008)(66476007)(316002)(6486002)(38100700002)(2906002)(86362001)(31696002)(44832011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1IyaTNNUXFBY052UGVtRDQ0dVhZSmlERXZBdVV1N2I3eVJUc1h3ZncxaERu?=
 =?utf-8?B?ZGdnTU5YaFRwMWFmdlRjYXp0MFZOYzdvQ09FbHFySUVsMWQrZ1YvZzFkenFv?=
 =?utf-8?B?ZGxhUUV3Vkpham1WaVRxWmxrTGRKaHIza0wyNW9XTUV5bFluSGlPWEpZVGVa?=
 =?utf-8?B?SWtRVUpWZjgyS0RSV2N5VjN3a2V5cjhsUzUrdmtHWlVQYTYwWEtkbDVDemh4?=
 =?utf-8?B?S2Q4TXdqWTJlTmx4QVB3QXVnOTdURjVaWTdBV3RERkZrb1dUTFpKTFhCTVYv?=
 =?utf-8?B?WnhxMEN1NTVOc0NXVnFpS2lRRktkVDErUlNIa0VhSXBPUytCeHErZXFtSjhy?=
 =?utf-8?B?YkJ3b0hEano4N2xBZlRzZ0loWnNZWTBpcnVQYTB0ckdobXFHaUpCeFhmdUl2?=
 =?utf-8?B?WC9HS2g2aDZmZE1lUWNXd0hmRmg0eEc4U3lXN0FTOHVWbmlIRDQvb0NtSjJo?=
 =?utf-8?B?YXhKTk85UWtWUk92clFqYWN6bkNjWVF2LzBqQ21KRVBoM1J5R25kUWw0VjBt?=
 =?utf-8?B?MUh5V1ZCSk45OURPWEhmdElZRDNQejVTOHIvdC8wUE5NWU9URDFBMFlTaHdp?=
 =?utf-8?B?eUZHdk5sWEZkeUV2eVJDSEl5dGdTVjhvR2h5Y3MwajFYb3F1Rk1VRS9VNXJM?=
 =?utf-8?B?OHFseGVUL1VyMlF1U2hwSS80bWE0SHZpYkhEcDJ5bU41b2pKVURUL0Q0bENT?=
 =?utf-8?B?K05XakRXZTA1OHhEZTZYc1pTYmpNSFJvZkxqamZwL3JhTTRlK3FLSVZhbGhB?=
 =?utf-8?B?R3hUVUZ5Tlg3a09nUHp2RXJiWTI0UWxHVWNQQVNxcVFPK0tOcDQrWlczRHhw?=
 =?utf-8?B?TFd3VzhmVDFXa1B5NE42c3loREJEcjVHVHhPZWJwbndvMHgyZU40ZXBCejFI?=
 =?utf-8?B?bFVpdzdETjZmZzRtMHhXSVJLOFpQWlUwRDJsUnBPa01sZWRkZjluSnlPU3lK?=
 =?utf-8?B?TGNCVXVhOUxySFAzdGpMd09USStWQlhEUkVsdnoyNUdJMW9NanpkeGVDUnJl?=
 =?utf-8?B?NDhScHhWelpETklaMVBHd0dITm44Y0M3UnJoeXAwRGV2Mk52S25QVm1tY0Nj?=
 =?utf-8?B?ZVJScmhWSVlpbEc0U2NkL3k3a0xlM01MUXpBbmRKZ1R2aC9FTG02UlM0SzE5?=
 =?utf-8?B?NmhOOGFpWXQ3cEJ4Vm43cU5FazlnS2F5bVIwcXlUMWhobTg2Mi82QkdXc1Vr?=
 =?utf-8?B?L3Mzd21udzhaWFBVWlFpU29wdHlvb0R3ZmlWUUlGbW9VOVdlQmNQSmlRQy92?=
 =?utf-8?B?dzI2SG1ZRkJna2tzOEt2cU4wdm5ETkFyUURGdy9Jam9QKzVadDVQQmVrVXJx?=
 =?utf-8?B?dG1FME5CQ2d4ekJnSG5sTytFc21reHg1WTVuc2diV0docGNsV2ZVZ3p1bTJj?=
 =?utf-8?B?a2JPekNPM3g5cXc2NTNuRWhadXdlRDY0Sk5URFEraXMyQzA3V1g3U2NLbVF4?=
 =?utf-8?B?OXhEekQ5MTZ5RXF5bUdxdHVtSURUVHk1K091MWk5L2FOMk9zQnp3Ti9vODAw?=
 =?utf-8?B?dHI1RE1EWGRGdnFZMnp2NjN6Ni9BSWJMNWlhRk9yb2YyL3FuSm9vMDRUWEtU?=
 =?utf-8?B?QlBxLzZDQUMrZEN5WDZOV0JjR2RlTGZzUDNUWXJMbXArYjVDM1FPVXZvOFpo?=
 =?utf-8?B?aU1hMjBvbU1tcEFqdHg3U2FVbDFCZmVmVlFNUFNOU2Y5KzdlZ3JvREFwRUlB?=
 =?utf-8?B?QTFWVDNUc0JjWDAwTjh2NDZaUExHVFF0S0grazZ4MkdnakpXNjZLYmp0amFO?=
 =?utf-8?B?anlkK3drWGo5M0ZOYmRVQndkS0FEK1F4UWJwYVhrdG5KazdXQngwS3ROdldN?=
 =?utf-8?B?MU1EZERrcmZYTmUvQzFoSEVvMCtaSk1IZDJtOHdFek1lS1R2VnNYWVhTOGlC?=
 =?utf-8?B?bFpUbXIxa3h4WDVWYjRodGpQWmdnRkFqbytMNjBLY21VS2ozTzZSMUNLa0RK?=
 =?utf-8?B?ODlnWlhwa0JUc3U3LzlQTU83ZTBIeG92a2czZDk4K2pqdXpBVFlaWmJhbWlH?=
 =?utf-8?B?eHhHaXlZSWhqOSt5QitvemFuZnFHa2QvS0MvVTJvYkpmNzlkMXl3czdBc2lt?=
 =?utf-8?B?Y0V1ZmxQMG51OWI0b1dRQ0c3aUtIRGdLaDM2M1pEeFVXUm1ibERDT3NHSThW?=
 =?utf-8?Q?NdeFvs6FwWql5L/O8wBl5YHgH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da32859-c36f-4737-5aa9-08db675a4fcd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 13:22:58.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzbYyFNX2dG02/rxYGFsLEj4LHpNUwFb4XRLa1DhGeC5fGeYYgpkrHbP+z0rp4lvDSVmTEbgJJ01vovPx65iJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674
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


Am 2023-06-06 um 18:53 schrieb Philip Yang:
> If hmm_range_fault returns -EBUSY, we should call hmm_range_fault again
> to validate the remaining pages. On one system with NUMA auto balancing
> enabled, hmm_range_fault takes 6 seconds for 1GB range because CPU
> migrate the range one page at a time. To be safe, increase timeout value
> to 1 second for 128MB range.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 2dadcfe43d03..081267161d40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -190,8 +190,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>   			hmm_range->start, hmm_range->end);
>   
> -		/* Assuming 512MB takes maxmium 1 second to fault page address */
> -		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1UL);
> +		/* Assuming 128MB takes maximum 1 second to fault page address */
> +		timeout = max((hmm_range->end - hmm_range->start) >> 27, 1UL);
>   		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
>   		timeout = jiffies + msecs_to_jiffies(timeout);
>   
