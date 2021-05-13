Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747F3C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3394260FE6
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3394260FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10E66EDAC;
	Thu, 13 May 2021 17:18:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7130B6ED9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 17:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+fP7agYlmoLHXLCYLYyS87rk+N81Cn6iZiO2KUKVeemZhDxIdBOCskd36weSo5tsU+4lAlbEfwrtwqXcnojgf3s3Ja2UH6BnXoDUwMqRjrWTOyZsqKtSrAmKQOhXpr+q2rbTmQgkJirKW0ZHppdqh7QqaG7pyuLtrSWZEV8GwWb39jK1KGQvMw1sVJ+x6dhvCrnXisQV1pK4A265iCjUkW0Uq/+qKUI4Aku5wc/buEoDndKT09CRNdh/WQf1TVNbMhQJj3cuLwbV74gbyexQK5olJXkQnlgY+vShWz9d1Ec9LuUl3/lnJrb73lF3Y4iZgLcP6urq5UNOIOaoVl3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRKHl9Ynxqjo65islbDfKy+qGOqA97odnxypMI8g+QI=;
 b=JGk5WcDFAEeq7dr8NmVFuY1yVe16zR8yEGXMQReLre7oJJaObl8lwJq5fGii2zjTILjKjF9lC6brThTrgYXP2Q+WVBPzSeUhC/LrDcTHd+UODrplRh6JupzkezCdnDvq4uQOGUGkUMQsj9E04FjFW7oxDxPwP8roh3MLLQiAReLgUZo2xYXoZkZ9G2Y1zO4Vbc5fOxZPjlf7ug8wWoBTRwKFg813LuPfztXEogRZksNbDmyWtFg06b2WDw/W+AlB94z8bV0IK0/QL74plcp5+ipzDJFBaSHXjl4mJC48WF7M/HP/QC9cad4Q/e6C5T7QpVB7VlPHa941OztFZe28kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRKHl9Ynxqjo65islbDfKy+qGOqA97odnxypMI8g+QI=;
 b=5RSLIQN87S7tf96aKd4zMLJUP5SVVj7wd4CbLskjzHBhNu4Y198+UmdHvVmw4MPFyDzATxXeAD9aU98mFnIW3mWDue7ytGniFgO3Jk6ZmoQWBKI67DZU4MPdsXdCsTYRuwDxQArUIhRXaOAP101a0Qo+V6fJxOKae1uiIZ0qAPw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 13 May
 2021 17:18:28 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 17:18:28 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: heavy-weight flush TLB after unmap
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210513165855.16395-1-Philip.Yang@amd.com>
 <20210513165855.16395-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <73fbb397-e325-e912-f363-4ed82ae99c15@amd.com>
Date: Thu, 13 May 2021 13:18:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210513165855.16395-2-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Thu, 13 May 2021 17:18:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0962e6b8-6ec3-44dc-ccb7-08d916331f8f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5289D7B8DB13A564701D246292519@BN9PR12MB5289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyyShhv+NjP3af0ERICcfc/i/Ij5tcBh5dsz70nK6Z7G9dozgZQeXtpqGWUEN2Owp28mTCdqVnuv+fIMA3DMlZE8c+fkrJarfcALD++ynzl9xvxFoS6+aT6NHqhFDF4sJcu7aQncXZ1G8MvET5l6uzyJ/PmhgFT4Lu8wFDwzyDRmV7xfQeQ8EO5uVAmvBWOD6dzyE283Swfiq6l1KNO0WEYpPgOjwoF5iM3UuFgTiWUeFqYMp5p4mG6xC0OTfaOu2OQkiW/dO187Qp4gh1KbtaYq9j4yoSxVsziB3jHEithig1+xMeP2retL1I+LusA/lz8Ebf9NmiURxHnfVQdhq3RGAgKV/2lGw7lO1yTLDajRJEJz/b7Ay29qbQJbrGZDrX+ZoEYRqqCzjRTYKFOnVGq60FPw2pYzkBbWcMLdFmj9XFAcPaLFs/Z5rXbD4IlRjHViX1lsbdAaAqCZajXFV4GimHvkSniqBnZ+pirc50pI+/3vQXqUS5h9dvW3seGLMrkbfLnAvALdqdmF1iW+rqwgrxkr7o/002lTa9fxjXIhyn9Xi3FprJ1HGTEvNlWFULYXMY42GXjgVghT6buXYZUAdvDJf/DsNETK9DT0Gvv5yjSEE56VhpI6R0YF9nlSOLmaHH2RH8PTZZOSsNIPiwnWZPKreeGZPf3QxRuPh7G5Hei1AQFD4gN01C1KnyjV/0bhvbe7prBjQR5qm+ePs0nRo/bgznPyF7B7Ct+qB2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39830400003)(136003)(396003)(8936002)(86362001)(478600001)(6486002)(186003)(66946007)(38100700002)(16526019)(83380400001)(16576012)(5660300002)(66476007)(66556008)(8676002)(2906002)(36756003)(26005)(31686004)(316002)(956004)(31696002)(2616005)(44832011)(16393002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXdvK21kZnRpMnEwS0NKMlN6MXBpWjdScGRtRWk5WEd4SGhaMHhOMjJEVkl3?=
 =?utf-8?B?emFGNWlMaVdEbGNXV3BSeTFHTWI4TnlxUkllZFp2S2tXZGQ0a2dNakd3d001?=
 =?utf-8?B?OHl0ZmtoZ29id1NWckpEQ1VmZWFCd1ZKSmx3QzBaZUtwMEFzeXdkWXA2STBy?=
 =?utf-8?B?OHFOSFQ4eDJBdUxXbmJEYXY0TlBYcnc5elc4ckZLU3NmZHpIT0FKbDRmRmtO?=
 =?utf-8?B?UFhEVzgvTGVJRXVkakxXRUxkcnlXR3RUVVcvbWY5ek1lajdIVENiNkw1bjBS?=
 =?utf-8?B?STYveC9uVUpyZVovVzI5d3hSeWdlM3B6ektUU2xBRnJtRTd1VTMyQWxrckw2?=
 =?utf-8?B?YVdnWjA3OUk3TWVmd1hWbnozRXIvVFBnNzBYRE5RaWtmUFZtRVVnVWNuWVl5?=
 =?utf-8?B?eExORmJIN2FaWXpvU1BKUmlzclM1YTBYcGh6Q3JoK3VLSTFSaDlmSzAyakJR?=
 =?utf-8?B?R2U5MEYwNGlZWlg1R3VIK01lK3l3WE81TEV4OWV6WmM4SFhMVnBUcXF2a3ZB?=
 =?utf-8?B?eGU0MjE5Y29uMkRzUEFCZWhsNDZ5SzR5dTFWMHpSVUtOeUJ6MGVpK2wzVFFq?=
 =?utf-8?B?b1FXODJEUlE5SXMrRXBYSVgyYUdJcTZVYk1wWXdqdk1KcGlOVlJvSlFCREhF?=
 =?utf-8?B?dVJaV0JETHcvQUZDV0NQcElzdHdGVkQxbkZpdENKSzFpaG05R2ozem9jQ01U?=
 =?utf-8?B?eUJtUjJ2Z0pIWDZwam1xcGo2dkRFWXZicG1IK0VIK3Y0Tk9iNEgvZ2hCRm1t?=
 =?utf-8?B?RE1VS1lRcHMxN2tmbkdNQkZXMXpaQ014OWZvbkxEVTVxMjd1T25ZbVJCcEhB?=
 =?utf-8?B?WDlVdndOdXpYc2RVYkoybWswSFc4ZThEaUpFQnZKcEJBNmFndUFBdXl3N0lP?=
 =?utf-8?B?bnJpWGRSZ2tQUnlpOG51dXpVUFNmc21pRENwRTU4NVdEbTEva1NBZDdUSnNK?=
 =?utf-8?B?YkdUYjliY0lOUmNla2ViQzlMZ0NUY3ZWT3NBL21ZT01CcUY4bDdIc21uaThB?=
 =?utf-8?B?S0pPaUttYkdkWlhMMWY5N0Fya3dRQ2lCZ3hSaEJsVGZSR0cxT0pRa3hVUktD?=
 =?utf-8?B?Z3VwODk2ZHhmcm1pSWpnMkEzQUN0aFRDNVJScHRma0pwdjhhWUt2bVRGdUFi?=
 =?utf-8?B?amYxV095V0Irc1J3dEdaRUYxK0xLRmxQMkdaajJoNEQwa0FDd1NSVzV1Qy8w?=
 =?utf-8?B?YVQyNis2L3ExRjZaa0ExZzRXQ0dQN002Zlg4YnNqeldvamJ2K280eVFLNnRu?=
 =?utf-8?B?QnA5RXVqQVJabmdYekRDNWZhRmlwVlFSTnFMcklOMHhHNHV6Q044d1hVZHJB?=
 =?utf-8?B?bnFOMEJ6NXlCOVB6cFZvZmhTejh3aXI0MW12cDZsWjlXeEt3TkRQcGx3Q1hq?=
 =?utf-8?B?RzR6MTlORGRzLzVjMDJ3VktGY1lOU3pYdnNTQVlidnh5UXM0TkNEUnFPSFI2?=
 =?utf-8?B?ZUJlN0FJbm5qN050MXptbWpzckRkTC8vc1BWS21TVUY5QW11ZlBKQ21QZWs0?=
 =?utf-8?B?R3d4T1RKRTNFOHh5Q1NhOFc1Z2FDK3oyRlpTNlpXcWorSjJiMnluWk9VNHdQ?=
 =?utf-8?B?UEQwUU9yQVF5M0RCR1JGdmR1RTBqV1ZzV3R6UnplMDhqNHhzNDZWVmhEZVUy?=
 =?utf-8?B?T3JXT3p2RE9sT0N4VzBPSGlNb085OEw0RTUvQTluQktEdXdFYlRNMmxSRTFu?=
 =?utf-8?B?MEhUV3h5dzlKQitUSkZNYkJCanozZGxMd3BZZC9BWFB5SEdTalZObmhIeHVM?=
 =?utf-8?B?UkFZcHJZWmVwQndYbTNCbE1RTlkya05FYkxpSWRCZU5VamNEQ29jdXZZWW1Z?=
 =?utf-8?B?Z0orZXFTdnh6b2dHOStjdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0962e6b8-6ec3-44dc-ccb7-08d916331f8f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 17:18:28.0168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJrbzTWi+X4krGJ0Mp5+4KDGUvjSRlNs0DthBQpoX41LWRHpBfIrnQ/0VDq5rH+iJ3R1OpdfBvg3nRlgiknKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-05-13 um 12:58 p.m. schrieb Philip Yang:
> Need do a heavy-weight TLB flush to make sure we have no more dirty data
> in the cache for the unmapped pages.
>
> Add flush_type parameter to amdgpu_amdkfd_flush_gpu_tlb_pasid.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 5f6696a3c778..0be9a6695b2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -670,10 +670,10 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
>  	return 0;
>  }
>  
> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
> +int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
> +				      uint32_t flush_type)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -	const uint32_t flush_type = 0;
>  	bool all_hub = false;
>  
>  	if (adev->family == AMDGPU_FAMILY_AI)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 313ee49b9f17..e8ce851c6f29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -135,7 +135,8 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>  void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
>  bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
>  int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid);
> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid);
> +int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
> +				      uint32_t flush_type);
>  
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 9d4f527bda7c..1d8a593edd3f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1853,7 +1853,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
>  							pdd->qpd.vmid);
>  	} else {
>  		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
> -						pdd->process->pasid);
> +						pdd->process->pasid, 0);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 50da0d1fb9c1..e57a8e405efd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1125,7 +1125,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>  				break;
>  		}
>  		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
> -						  p->pasid);
> +						  p->pasid, 2);
>  	}
>  
>  	return r;
> @@ -1182,7 +1182,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  		p = container_of(prange->svms, struct kfd_process, svms);
>  		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
> -						  p->pasid);
> +						  p->pasid, 0);
>  	}
>  out:
>  	prange->mapping.bo_va = NULL;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
