Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC260C00528
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A1710E5E4;
	Thu, 27 Jul 2023 18:14:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC61E10E5E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ius6TZ8X3k90y2VWDpGQG1J6c48Rgz/72a8SGqNsseSR/MU+A/FzLaGJGkV76FD1UVhrsZmjQlCA4oYqVXiAlq4pwi+mX2sJNN9nGJZSGYU2vEVzN3sHa3+PMgR7bN56fAPm6/kG5qbnlNT8ieOByCJ3aLsEa89bd3RlCVsxlR81nrpXF8xCKJAbCaxUMNl8fFRLRnGuYTccogoV7UWdSmsytMRkDhQAV/E4a85c4ZnydKc/W3PlQCyPI12knU8gdQA/xV69oxaP/ow6djogVb6ZVzttU5sZH2E+G3BjpRRsYJIEUzogf1nJmuQwg+9dPwuL7JLIjRx6LAzk++ip2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hz3owdtENPAZGxx5IB7ga+ChNMqDTyFSjDMmjv9DXWk=;
 b=T9Z+i04NV1B/Es7mCb7YkPATEHv5haJD7WM7Wmwib0cbirm/loSXO7dT0OmEpCwRb8qxZO1Ql+mLYYP4oGvzpNUNdbzesY2zQNWwaZrpThJUIxhUugJy1UPRDA+DxZhaHUSIY9WddfyQ1CYYHjE9wEGfO8qurjIlSxiSy1E1IJCgiiMNmm/VDprpdmfMFfVsYGN6aWMN9UCdckPbVpTVFm35jbIGz4yA72ouMyP6ep1P5JU3OuhP5W+U1vW9oY3Q+qcGGaGq9FUUXDfWPBWBaK8/hUXnLwxcZfJDSXUsVjTT0SieSywiTREvGMAenYfPiIwO49cQ9VMBRZwhOH4DpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz3owdtENPAZGxx5IB7ga+ChNMqDTyFSjDMmjv9DXWk=;
 b=D8PJhvKqaNCIDlVGGPvy1/n4P6eoRMcXM+2THedXv/cZW9QaR7g8Re0BhIoagvH43ITVboWR2BRiEQtFdbQeXx9IqxSR97w1HhDNUvzZ08ZiMUgRldGWxrhGcWrffsZ9m/2kbXVes2PvI7+/wozv+eEB8jlaLGdPkol52LE54Oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 18:14:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 18:14:12 +0000
Message-ID: <2d79bf17-925b-e19e-8cff-d37f8e736360@amd.com>
Date: Thu, 27 Jul 2023 13:14:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amd: Disable S/G for APUs when 64GB or more host
 memory
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230727172857.12780-1-mario.limonciello@amd.com>
 <CADnq5_OJ86xy3LOJo44tCWGWsGGAPc87epc3gSpkpbQefYKi5A@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_OJ86xy3LOJo44tCWGWsGGAPc87epc3gSpkpbQefYKi5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:806:d2::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 144486b6-c15a-4cae-b633-08db8ecd478b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXWLkYOaT3zzBQhTzd8dMDnS49HkQIqR0HnAdaEebb9dDcU3HWZ/tqMwpkC5SuDv2VR1OQO5uZi2gZKjVXrgxeJcFRaNuSHjd8j2er1Ude7YxEN/qLRg9zkPJgpuw2unYtGAcKuwROTxSbuJMmOOZLoUr3tb99YCpPHy8POLKUlwHkbba8+VNdZouvWzqRUV8aP1z9zsMfmSXatYfKtmLjZeMbbQ8Br0v8frdy6/bRqgPpCdpr2s3BHMMJjhBKUshC7TDsxXIha5TeLPae4o6TACK3Mx29HC5Et4NFRPGvkK7+t9STjcjiAQjjcVuuqRqKwZ1TRrbFBFTa43DtVhBvEuu55lvqec9T16PvkCz/lOdrGTc1oJfKU8zvwTUHUASPVqJiSGL41aa1Bn1GlsjrGldFuAtOJfPdpLAXRqcQcK3DjEs6lcH6u7bDhpBsrMBlj0QrGXhSAwd6aYTTX7P5flqVqzsYTnjyzjJj7kNeaH+XAoh94uUrBw+WZAM0jlZB0MwjAXzYGvNp2+pxJTHDoFMBniiBXokQsC5PnMqk87nXiwxFKkVUJU2VeI5gih83Y+CotUHDB8ZLKYDgSgGKF+Sx72Rbe9+6i9ANYEBDye9i0Gheho5waMxYYjVf/5EjBghD6QC/Z5Iq4aG0KjqkQLPFTKwboSyhfbM6gkQG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(66476007)(83380400001)(66946007)(66556008)(36756003)(2616005)(31696002)(86362001)(38100700002)(966005)(478600001)(26005)(186003)(6486002)(53546011)(6506007)(6512007)(31686004)(41300700001)(6916009)(2906002)(5660300002)(4326008)(316002)(44832011)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JLaEZxUHpmSVA4bitXSWVOU1QrVlFlY05IR3MwU0ZvRVBvNkZWRWhVODUy?=
 =?utf-8?B?N1RRNGpha2RVbG9uYWlxZ21sNHNmRGd0dU9aUHJQWGk5ZGxZTHUvZFBBV2p2?=
 =?utf-8?B?NksrTk5zZStqT0VGdmNZSW5BL3VWNHIxTE84dWNJaE90VlF1cmtUeVU3QXNB?=
 =?utf-8?B?S0VxS1BNc0hGUXhITU5BZUl4QTltb2Q1aGJzczhaemlCaHBGVFRxdEtnRmZ6?=
 =?utf-8?B?RlUzaGdhazZKZ0dTUHJQRmtFeC9JcmxYampJVUtBVTUvUU9vbzdlYmZyd0Yw?=
 =?utf-8?B?NXJNaHFWLzFTNnc4UVEwNjl4cUJoaUpwaDcxNFM5U21mYTMvODF4QTBZdDM2?=
 =?utf-8?B?UFJQM1EvMEpMellCcFcvVUljSGtQVnBCSXBPYURMTER1aWdiUkYvY3Y5WHZr?=
 =?utf-8?B?ZFUvTEdZMysxSklZNlM2UVExRWI4cGNHaDlnNXpaRExWa0xldFhWaERyUXVY?=
 =?utf-8?B?bXJkN09pR05QWHZ3QlgxRDR2dEFoeld4UTg2Sm95NkZEVmJJaUZEODFQcGM5?=
 =?utf-8?B?WFpBRUtUTVBvRG1sdXcvYXpGSlh2bU5RTFVWRDJKdTFyYVZIMWJRR2hnY0R1?=
 =?utf-8?B?a2VYcTRPMGhIU091bEN6NStNRDRkZWwxWElUN3VvZzQvdHJLamRqNlRweDQx?=
 =?utf-8?B?amU5Z3Z1THpEdi9SNXpTYXlORnNSMDMyaEtBWC9PRVVoQW1mTWdoUlJ5Qmdu?=
 =?utf-8?B?RjlEbE9RNFFqU0IxeHd2ZTJ2aFgwU2R2QXFKVlFjNlBuYmtKNHNEcGVtOUhl?=
 =?utf-8?B?dXJGQzVYekhwVzNrQW9JeS9SN3ArSEdUUnZSeXgrVDNkVzBWMVlJU2YrMFF2?=
 =?utf-8?B?QnZ5N1BwVGZyck5tbVhlYlk4RTBrb2NYR1JLRmtKTVN6dzYwUmUwQXRGVzlG?=
 =?utf-8?B?WWw1MXdlVHdUVXVkaVh2WFY5amQzVE1uSEJxeVBZa2tySVZBV1NlZU0zcU85?=
 =?utf-8?B?bUdETXZsQ1JMSjdXVUNYUVhHTExIQVYrblZVSmRaUTQ3YmJRVFVyQUpLWTZY?=
 =?utf-8?B?d0NoaGRHelZKOGx3NlZpU1d4QVVwWlhhOXVUa0w5dUd4R2lNcXNNeG1BU0wr?=
 =?utf-8?B?bXpFQzFWYlA5UEJmUUlRd3JheUtVS3dkZjFsT0dsbGhVcksxeEE3RkFkYktn?=
 =?utf-8?B?cG5qM1o1OVdjUnNoc1paMXZnSHdvV1kzVnpsaldrUFRWMlpwTVAxQnUzR2Er?=
 =?utf-8?B?SDkzOUliWkVSaXpzOU9FdzhPY3hKdno3di84ZmFKaWtzRWZUWWZKNXhmblNF?=
 =?utf-8?B?Y01jLzUwUHUzS3kvYXhya1FUU0IyTGJFam10QTArQWM0MmtNRWxTRzF1OTJK?=
 =?utf-8?B?azI2bGhpN2t3ZDJXWEFEbStCSlFRZ2JVZ2NnYmp4N1EwYXAvOWV4enlZbW1F?=
 =?utf-8?B?bHNvajlzcHJob24vNG45MDhYUWhxVk1VRTYvTy9DclZhakhLbXAwODhJR1NH?=
 =?utf-8?B?NnVRaWc2dDBPbitlVC9mVHV1LzA4VWtHaSs5YThCSGluR0R0bjBCQ1FobGtP?=
 =?utf-8?B?amxLWjJXMEJJUzNCczlhZ1BxeU54aUpoYmV1Q3BtNTZjVG9xNGszSTNwL3NV?=
 =?utf-8?B?VFMycnBCZ29YYzhzblc1OUhKOGMvSFBNdDhuRy8zdlhMeFNrREVSQ2ZpYXB1?=
 =?utf-8?B?OEc3UGtLUFpiMTl5empQaG51YkNLL0NkcUdqR1kwUk5zYzU1ZzkzVmpQM29X?=
 =?utf-8?B?bnBoejNjc29TejNhc2kzZ2tSOEZoV3BCWDN6MnhsTEREM1RCUmJ0ZWV6dnll?=
 =?utf-8?B?YkhBcjJnVjJiMGZEVWZQcnMvdFg3bWlqK0dkaGx5VkNhYWUzY01jS3U0MFVy?=
 =?utf-8?B?OWJoL1ZJQ2lYanhuQjhNMVJvenVVMVl3TmtmZ1NLYmN5NUhPMHJSQXRCK0JR?=
 =?utf-8?B?dzhBVXBxU1hlNTVTTkEvTGVFTUFVUjdCd3BnSDhMNDhBbUdybnhKY0J0RVZB?=
 =?utf-8?B?dmtDZlZ3SEdaMDAxVktnYllpb3lEdkNnZFFTTzhiVUE3OCs0QkJvdnArU2FC?=
 =?utf-8?B?aWV5V2s4R1hHcksxWHlkK3ZUMVhhZmtGN0d4ekFIbnRDdDNXMzhtZ1REQmlp?=
 =?utf-8?B?ZzlQcHpjOGpzdDF6VURhQnVQbExwdHBOb1QwdEVnYzBxYzY0aVp2Um9sWEFp?=
 =?utf-8?Q?zVmQVrVYhWZon0Z2xdbCHchQV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144486b6-c15a-4cae-b633-08db8ecd478b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:14:12.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qGVG4gwqhzIlSorhYXXi5yKw3OYuKjtIZuYODl5b8BvO57Y/m3mfJMTC1KQJqp+5aS5A7CJQdPbcGXAlxc3vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
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
Cc: roman.li@amd.com, amd-gfx@lists.freedesktop.org, Hamza.Mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/27/2023 13:02, Alex Deucher wrote:
> On Thu, Jul 27, 2023 at 1:29 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Users report a white flickering screen on multiple systems that
>> is tied to having 64GB or more memory.  When S/G is enabled pages
>> will get pinned to both VRAM carve out and system RAM leading to
>> this.
>>
>> Until it can be fixed properly, disable S/G when 64GB of memory or
>> more is detected.  This will force pages to be pinned into VRAM.
>> This should fix white screen flickers but if VRAM pressure is
>> encountered may lead to black screens.  It's a trade-off for now.
>>
>> Fixes: 81d0bcf990093 ("drm/amdgpu: make display pinning more flexible (v2)")
>> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
>> Cc: Roman Li <roman.li@amd.com>
>> Cc: <stable@vger.kernel.org> # 6.1.y: bf0207e172703 ("drm/amdgpu: add S/G display parameter")
>> Cc: <stable@vger.kernel.org> # 6.4.y
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2735
>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Fix updating mode_info as well
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +++++++++++++++++++
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++--
>>   3 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 93d0f4c7b560e..2e3c7c15cb8e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1313,6 +1313,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>   void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
>>   int amdgpu_device_pci_reset(struct amdgpu_device *adev);
>>   bool amdgpu_device_need_post(struct amdgpu_device *adev);
>> +bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
>>   bool amdgpu_device_pcie_dynamic_switching_supported(void);
>>   bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
>>   bool amdgpu_device_aspm_support_quirk(void);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index dc0e5227119b1..a4e36b178d86c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1296,6 +1296,31 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>>          return true;
>>   }
>>
>> +/*
>> + * On APUs with >= 64GB white flickering has been observed w/ SG enabled.
>> + * Disable S/G on such systems until we have a proper fix.
>> + * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
>> + * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
>> + */
>> +bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
>> +{
>> +       switch (amdgpu_sg_display) {
>> +       case -1:
>> +               break;
>> +       case 0:
>> +               return false;
>> +       case 1:
>> +               return true;
>> +       default:
>> +               return false;
>> +       }
>> +       if (totalram_pages() << (PAGE_SHIFT - 10) >= 64000000) {
> 
> Does totalram_pages() return the amount of physical ram or the amount
> of usable ram (i.e., minus carveout, firmware reservations, etc.)?

It's a good question.  I don't have a system w/ 64GB in front of me so I 
just double checked on a Phoenix system that has 16GB soldered down.

It returns 15520248, so it's missing the VRAM carveout.  amdgpu does 
know this already via adev->gmc.real_vram_size.
So I think the logic should be:

if ((totalram_pages() << (PAGE_SHIFT - 10)) + (adev->gmc.real_vram_size 
/ 1024) >= 64000000)

That should bring it to ~16GB.

> Assuming it does the right thing here:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> 
>> +               DRM_WARN("Disabling S/G due to >=64GB RAM\n");
>> +               return false;
>> +       }
>> +       return true;
>> +}
>> +
>>   /*
>>    * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
>>    * speed switching. Until we have confirmation from Intel that a specific host
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 77d970a2ee693..26c3eb7a9f882 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1639,9 +1639,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>                  }
>>                  break;
>>          }
>> -       if (init_data.flags.gpu_vm_support &&
>> -           (amdgpu_sg_display == 0))
>> -               init_data.flags.gpu_vm_support = false;
>> +       if (init_data.flags.gpu_vm_support)
>> +               init_data.flags.gpu_vm_support = amdgpu_sg_display_supported(adev);
>>
>>          if (init_data.flags.gpu_vm_support)
>>                  adev->mode_info.gpu_vm_support = true;
>> --
>> 2.25.1
>>

