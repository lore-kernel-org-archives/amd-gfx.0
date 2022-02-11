Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE61C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DE310E9F2;
	Fri, 11 Feb 2022 18:23:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639DD10E9F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd2EsEQgVUwbu8FGA/1e+meum+AygnJSpYYoIV2m/TOEo2I90l+3+PbGJUHB1Sx1ivnNllcy2JvDD7cVA3eGtJiY7AOSyH9WmII0pk9uVdx1csGn/BAV4vno6legMwt1A2Uam0zkSQGw1gvifi5UTd9kvZiuvEymU90woIHsb+da+hcZzX/7ExHPXVI8SMy8d2uCWTdlC1y88ZmFnsQaOEZSmij8kPXSbnr2d1hQdU5/NLZJqFtztvM9vwJm/sNPcRAMnwKd7d3Pa5HGPSC50AA7E8PvMIXdZ8YE15PpzR71eo9OPRx2BGnOanLiC4DvnYA2Wv+eMfzyNHIDrdHmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwFI+dp1NJ/JCoeWbADNBK4ahm2hBiV/pvymI4HN6ps=;
 b=YPr2S3OoJEF5UvseaRPwfJG7zXrV9F+LLmNf8xeXGw58TfgGfRKzVdjPBgFQS5NML97wd2lKx3ZjSixzexLBEHjbj6sq5YY32hCgAdX3zIKx4BRFuTlP+BR9sji1dU9fVD3fxMU+Vfckpf73KCk6zbgj/Ijek0CUJ7HqH1DNr2+66NPMBv2QgApZJKoO3I/3kBBzLYwPF094MElQIIa5hfsgazB3pj+0ZxvIotZ5Mhq+Bcm2dqwcUzdg+R0Z1Emo8VOFJ1Pe1BZXxfOkRY/coWCNwBZWglGuVpuUruaL8fz7IwA+5G2rDihWXuMf+qKaO3uBndGxq9JFovMfwZBC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwFI+dp1NJ/JCoeWbADNBK4ahm2hBiV/pvymI4HN6ps=;
 b=VptpsSDxdi4GA2OhewxOaiF+074KuUdt74Bt4f+vmo5MyCLuECyrHtNUu9R1EL2gu20LWcFYB3pXLW6gergzQ7yD/2nPS/IhozXOkG7Rd9ksCfGf8Za+z+tj7OiOwyixnNlK2k1DzSkVjWTCS2E46xYoSyAw9w750YGdUvpk9ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 18:23:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 18:23:09 +0000
Message-ID: <2a8502de-8502-c32e-8d0a-d8b8e43de2d8@amd.com>
Date: Fri, 11 Feb 2022 13:23:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220210025902.32514-1-alex.sierra@amd.com>
 <20220211161758.29610-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220211161758.29610-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52ca2ac6-cfdf-4fc7-a1c1-08d9ed8b8e0a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB021233790BF3DA54641C31A492309@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7p9qzXo25eZ5Z0066DNEyuo5uw6zCP9mgJRgv8l5dcoi4rRD47KI/97ROMz7H4btPpD5ncWXcOjNAEyLdKPjWylU7XpZBgwnYj8Og8L7mmTfy5fRuakO4LIyd13NEhCwdO3BeyTHGQ3mg5wKiVcUfIQpagNeqL2RPVGDXPJ4L3v3/6WOlmOQMnWeB2BIaGmrdK7QLJmX7M2nwvubBUJCvV9QfxNT/RTLjhgHjLRBAZkSAxqVODNUU9sr0bbPZ8KwB3khZUdJxauW4aLUtorZVo88FXZ0oV+NxisEmxcKJJipwKwAojzp0EzzT5sTn5xpbfZXoKxVeCdctEzBvSpHpkBRXRi757KXLdHDYD+8g2xyKx9I28MVt6c2hTqjI9NELGKWZwUfos40asELoeisMkRLcR0I3Joe+EcddDputOQdbBNa1ujLX9g/f6WTx9rEdyFhU4HqnsYe3W0U/eoYwbgZZ/vkPFnRDUOjJ5kkam7FSBLD2GckZaBENjbqqjjT7XKrTV8nsZtmeD6YDhHnGOAJfJ6uvEINueDCEzCfXX5IW4dYo+nt1fdGRpS+EuLoUzwOrTMe0JWtICht6feyEaMB3TLoRAFnDg1TvzBGpiuKSQkdtD/5v5u9h4Jcs41J2EI00f4LBUDFMhbVmC/jcuiRYmEn9Qh9fME5IJyLWY+UHWbONMOA6a2pDMptP0xxlCACkzws9UgmOUNqfygcV6e+YKKX72vHeVeoX3ThsLV1Jwr/REMG7aGnlvmkbU2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(31686004)(44832011)(36756003)(38100700002)(5660300002)(316002)(83380400001)(6506007)(8936002)(4326008)(66476007)(66556008)(186003)(86362001)(6666004)(26005)(8676002)(66946007)(2616005)(6512007)(31696002)(508600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjJKUGl6dG1URmlSeEIvNVprN2p1c1pCVFM4SzBPdTBXUmcvd3o3bXNqdTFB?=
 =?utf-8?B?TGFiS1lnVGE4L0VlbzV2ejNvYUlNa00yd1RHNndoYmpoVkFmankrTW5KcW9i?=
 =?utf-8?B?UFppYUg2VTdlaHdlVUorOGkycE1XQVBYU2RZb2wxbHdFNHQ4NGhhdDA0Ymt3?=
 =?utf-8?B?eFRDYmZQa1F1ak5ZN1dZSnYrcVkxeWxybU9wWDJIZ1VBWFQ3cUdIa1JnUWhC?=
 =?utf-8?B?SGZ1eXdyMjBINXVlVkNRZ0FkU01pMmdoNks1VERnNkJ3UTFIMkY4aFJ0ZXZn?=
 =?utf-8?B?N0V6RElaS2JhYTVvbmFjZzNTbzFMMFV2Y2VvQVhscXFHeDQ1TjNhWFRPYTRn?=
 =?utf-8?B?ZmphK281TzNKL3JiOTNuL0ZSRHFWWEx0UXNZbktZSktydU5ldE80cmZ4Z3k0?=
 =?utf-8?B?cm1MQ0hEY3BTSVRTU1RHQnh1cEhrZzRJdjRJaEp3NllPcmpWb1l5bCszWWJI?=
 =?utf-8?B?UEtLbzR1VkJMN0docUF0UmxsbkJJN0RiUnFDaTJ0YkVleGZtNW9EZ2hoZXN2?=
 =?utf-8?B?U0MzZ3FMQzFNMVRVTzI2a0ZiLzhCRXgxQjM5T1h3WDFGRE5qWUk0S3Z0dXZC?=
 =?utf-8?B?VTZqVnQ5d2pDaEprQmtPRXFaZDIxVFRIajhCOVBKT3drcFRLb2lzNzFMSnB1?=
 =?utf-8?B?TXVtYzJpb0ZUUU1lQzZ6bVZVY1UwcHBHQUdIQ1NqdWhwcVBFa3hodHduYU1O?=
 =?utf-8?B?VXJ1Q0ViQ0I4U25sd0RkWUpYSlNIZStBcVh1Z1lSRW9DME5YVFJYRWJKZkMv?=
 =?utf-8?B?WWRNL0hOSmh1OUt5M3lWQjgyMVlzNm96Y0w1VlZSNUV6cHhSNkx1VDZIdlZr?=
 =?utf-8?B?ZlhIb1BJSWxwdkpnSUhDMFV5ZjdMeWlYK05pQXdGSXlzb1BTRm9Mc2xtazBR?=
 =?utf-8?B?Ky9BS2pySjc4R2Z2aFJ6MlNiRUVYekFFZksvSHNoTmlyNmp5a05kUDRUdE8w?=
 =?utf-8?B?Kyt0VjhpSU9HT2Z6blBjV0tQZHB6ZlBSeXF0OHROUXVqZWxGTit6ZkM0U28w?=
 =?utf-8?B?N3lkOFVlMHpGM3BXYmZOQzhFcGlmckFJNU11RUc4bld4N3ZrQnQ5dlg3K1F6?=
 =?utf-8?B?eXk5akIrV2U5cGpIRzZBa1Z0RUZsYUZTZ0syVzlnd0JzQTFrYnc2eW9wcThN?=
 =?utf-8?B?RTJHdkZIdm1VdzlrNDIxN1NzTTNNQklqZUJnU3l4V2JuZkMvQUZGbjRuNmUw?=
 =?utf-8?B?UzM4aGdkK01JTVZCYzNhZU5JVlpkUm1rN2d4WFhmRHFVbmtWQnk5VWRFR0dt?=
 =?utf-8?B?dHAvc0IwVTgwVmJLdTNJK3ZBMkVGbFA2d0tSNVd6R3hJZU9xRGVoOVB0VWZx?=
 =?utf-8?B?bGo1MU8wRFpoWDRtdHBmd3c4RVVLczVSSkh4eFFsZlFtbWVMTWd6ZXhXY1Zm?=
 =?utf-8?B?SlptdzdxemxPT2krYkZrVGt4bytVNWVOVUtnVVZ2K0NHUkJWQ2NINllsODNK?=
 =?utf-8?B?SWNhcU5rWUF2TDVvWE56WElkNFVvSTZzWTFXcEU1VWU4bzhjU0tONWtZZFNR?=
 =?utf-8?B?VndlZzZsdkd5L3NGakY4OEpCYlcyNUZLWFdOdWp6SzRON0tNMHZnV0UxTWhJ?=
 =?utf-8?B?ZTQxS21WbDF5alBOVWREOTNmSURRaTVncTlhbXI2cTdjZmNoNWlFL2diREJV?=
 =?utf-8?B?d0c4SHBocUdKNDNnbmRnOW9CaUFqRm0ydGZBNm1LbTRBc2I5cXd4UnNaRURr?=
 =?utf-8?B?TlNRKzczWHdORkt2S2s4Y0dGbkJ4dTVWYURPOXQwdmEwTnZvZm1CRnFKZmRE?=
 =?utf-8?B?MjZ6VUFYUFpBUHJNQmQvdVdrcFdqbGJjeTFkLzQ3Z2FsWW9YNDlldVdwN2Q2?=
 =?utf-8?B?elpuT09aNTlPckJadEhaZUV2eWUzRFE0T2hvV0Y2S1RTdHhMNGl6NzEwR20y?=
 =?utf-8?B?dS9JTXJXak13Z0JJTVEyWGE2T1FKbmdoU0NQTURvVFBvbkhzMHZWVXFzazBJ?=
 =?utf-8?B?cjZzdytDY3ZvVU9MTk1pZGszUXl2SmdZQkxYVWppR0JLYVUrSUlnMEM2VGdY?=
 =?utf-8?B?RURVK3lCSnpnWUhPeEFMU2o0YldpOHhWalVaM08zWis5U2NNRmFJdUMybUc5?=
 =?utf-8?B?K040OGJNWDRQS2N6aDNSZWRPWlpDU3dzenExMlQ2TUhDR1JwZ2xITTlnTVZw?=
 =?utf-8?B?WFdOQ3RTT3lIY2xSaUpYTlRveEEwWDMrL2VSUGZWQUtHdVdjbWp5RWx2Wjcx?=
 =?utf-8?Q?uewfDjqP+5Ic18jaIsQ57gE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ca2ac6-cfdf-4fc7-a1c1-08d9ed8b8e0a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:23:09.1902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tvj7nrGjTN1EKhD4fpWbm/qMtuO733vSoYmblJiu9+F3LrweKC/mouATVwp89yHoprjq2SQ8myWK8HXzA78wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-02-11 um 11:17 schrieb Alex Sierra:
> Avoid spam the kernel log on application memory allocation failures.
> __func__ argument was also removed from dev_fmt macro due to
> parameter conflicts with dynamic_dev_dbg.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 88db82b3d443..befaadc0e854 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -36,7 +36,7 @@
>   #ifdef dev_fmt
>   #undef dev_fmt
>   #endif
> -#define dev_fmt(fmt) "kfd_migrate: %s: " fmt, __func__
> +#define dev_fmt(fmt) "kfd_migrate: " fmt
>   
>   static uint64_t
>   svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
> @@ -312,7 +312,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	r = svm_range_vram_node_new(adev, prange, true);
>   	if (r) {
> -		dev_err(adev->dev, "fail %d to alloc vram\n", r);
> +		dev_dbg(adev->dev, "fail %d dma_map_page\n", r);

There seems to be a mix-up with this message.


>   		goto out;
>   	}
>   
> @@ -332,7 +332,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   					      DMA_TO_DEVICE);
>   			r = dma_mapping_error(dev, src[i]);
>   			if (r) {
> -				dev_err(adev->dev, "fail %d dma_map_page\n", r);
> +				dev_err(adev->dev, "%s: fail %d dma_map_page\n",
> +					__func__, r);
>   				goto out_free_vram_pages;
>   			}
>   		} else {
> @@ -612,7 +613,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
>   		r = dma_mapping_error(dev, dst[i]);
>   		if (r) {
> -			dev_err(adev->dev, "fail %d dma_map_page\n", r);
> +			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
>   			goto out_oom;

You should also update the "vma setup fail %d range" messages in 
svm_migrate_vma_to_ram and svm_migrate_vma_to_vram that are otherwise 
ambiguous.

Regards,
   Felix


>   		}
>   
