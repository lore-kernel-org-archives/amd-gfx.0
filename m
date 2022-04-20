Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71125C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 06:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BA610E398;
	Wed, 20 Apr 2022 06:48:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A010210E398
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 06:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0ePkd0cAITKt46JaorAncjcTYlHo2QmtGdnaBwIOyd8MBdd27arWlAi2VBWiAu+bi926IRPEqMlSD0Pd6zXoS9Bj0NcjKNmtoWXjBiQbeqnTuCDOC7VggdjcPb+laqknOo2QD+fpdDWnVDfUHdJsITDL0vZQ0S9odbrHR96qpG7kpA7BY2zrve4KgRur45ucFimHyso3KyspXI9fBIEzluHpRjcQrDF2a2pg8wMtZYwiGNbITxC6GBabQdsb0LBikNZkrATbsHHZmjd3KetoDywLl9420cNPCGWwjWIkk2poo6xETRIzZjaMEJt0HAQ+pVOkLwgrqxYLMhDobd0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd2qaOrHfbFjt6KexEDY2+VBLm1JMqlA86MHGL/TA/I=;
 b=kvxbPxvYYVsNE6U7ukfrx7F9cDhSp+H8xpH5At+jHiZ0HpXn2jyqNB793U8qkW3gwdRCMVkg3gZ7yt0Vkbu3B8Sk+q72n5dL+V7sYB93113k953x+r7CHZL+eqBksBzycFY6Mw5EnRMaGhL90kNc+BiIDgP0aruqZshujzq8fWedqANVJinfWCrndyyxrg5VxsTA23K7AE8Pw2LXB3Jw+473ZUKL4ZhYu4KGZ3QazDM2dJ0aWs2T+HiMiSOeygLL5h2qlae+k65Z7L3Dr0wkugK6pyQx9fHfqaZVgDXHeU4GtO42yE/nHCkdrzx8Of4n1MxHbeNFzOT3HsFcrspReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd2qaOrHfbFjt6KexEDY2+VBLm1JMqlA86MHGL/TA/I=;
 b=bnvCKDbFwn/fLJ7dCbyFPT6HNFqj9sCLXR+zQ4Ic3OYdFXLnOYoqY6abr2zYnXit5qkOWI+SRvZAu6KXc0nLjZBCEMQqRpLHkMAWROAdDsO74RazyoFmzgEABKjlebP+AGwV5iyb7MKTEBRLA2IpMQhx8ZXzg9FI/5dWdQyMbdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR12MB1398.namprd12.prod.outlook.com (2603:10b6:903:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 06:48:39 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 06:48:38 +0000
Message-ID: <f5d9b9d6-177c-6a8a-5f53-57196c0db36b@amd.com>
Date: Wed, 20 Apr 2022 12:18:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/3] drm/amdgpu: add RAS poison consumption handler
Content-Language: en-US
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
References: <20220420035317.4008-1-tao.zhou1@amd.com>
 <20220420035317.4008-2-tao.zhou1@amd.com>
 <5f79e645-316a-0afe-c91d-33e57fdf9ca7@amd.com>
 <DM5PR12MB1770502A0980D9DCA57FCC6AB0F59@DM5PR12MB1770.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB1770502A0980D9DCA57FCC6AB0F59@DM5PR12MB1770.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0da9807d-d0cf-47c6-ee2a-08da2299cc8a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1398:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13981DBBC502E8122F717D0A97F59@CY4PR12MB1398.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udbWqZNJt9KsKrGtWmt5JBCN2kqVep3DJLMrokWCSF/c01phSTRmqG2fU/iot1I7VlHu4XZVaaU/w1K48oHwnZnMhqlk5WbTdQjkdZgV2yIUtY62ih3IOOBA2zSs3yu6G7UxLCgyW0z3vBeROqBe8D7f7UsVJkDYwW8sMUVyu1mGPG/CMpBgaO5BBaW9foJxo2b0C6d7UmnfSmQZijysqt0J9Lbt3KR+F3Q7TZ8pg7r4sxprRV8ciYHb/4KRviv2SN+IDHe/URKFZILRmFCh5Bjyqz0DOt80eRpvP20Hq9WP1Smupxra/ZtkZPPsC8QmfCyQalywCqthjfz+LyiokVPv0J+1d/ORPwG/HHNb7hOtZxB4PkhkvPEx6c6gyWSSPRnjN/cqwsf48fFMW+AHsFjwR7jp1KA7Z1E8va+Yv+a10R6MEibZDjGvGhTe3ZOG5MFQZom7GSvh0h1BnKD7znWLqyaT8iCmLnuPBqsEt1v0oIlJpIwpT9QQvMn1LaNVaJWO8IiJ41pR2+fkM5QaL3+ycuH5MneFBeOzcCWrqFLNYn/Rd3aimYk498grvf2Jj4l63tPeT2jFwXCDTCUyCuSaKvgveEp3epyW+3VsrQ5vgcQat40vrLlhp2cXLt628Y1mrl+uYm9YysfhgSxYj/UvkNMXujZKnfTg8orKfjxnMDmq1l3pbWnqtjiSXfELvdLfaSOKlGHnMnyTMj2xIr/ab2aaKK8Y/6sOcnLBqUf4nV6MiM9P/zfNTnBbo9cK+reX81Add8wqCtHDXjxxPV8+IVNW4GE/Mv0WBRf8n70=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(6666004)(8936002)(86362001)(31696002)(31686004)(26005)(83380400001)(36756003)(45080400002)(8676002)(66946007)(66476007)(66556008)(316002)(53546011)(2616005)(186003)(38100700002)(6636002)(6486002)(508600001)(5660300002)(6512007)(2906002)(921005)(110136005)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNaenVTa2YzVEtnVVJJRmdpTWtJMEZ1clM3NVRSM3I2TzFRUGVibTRKRk9N?=
 =?utf-8?B?d0REN040d04za25GT2U1MWJsVTh2Q2dKaUwwUGE0TTBJVUE3Uk9oTDN5SUwv?=
 =?utf-8?B?Nk01b3VqK29HSWlFdlRWVG9CZmRBMlZkRGJrSjFYcVM1TkpJZzVIYmZPV3lD?=
 =?utf-8?B?WGpQU3JxUklpUjRMTStnYWw0M0dDSUxhdFFxQlhvVjY4QTRMenVpU3JtblNW?=
 =?utf-8?B?VXp3T3V5d1BpVVRkanFSZWJoR0pPaCtaSXltN3Naa3h0T0ZqeXg2VGZNUWlX?=
 =?utf-8?B?OVVmR3ArUWs1T0xYeGJVTG9leWlINzhJL05oeXZoc25CRkx5YnF3ZW55dXY4?=
 =?utf-8?B?aGdsTGpTSTIvbVI3bUsxTmZkVVIySU04T3hYUVBvcXl5Q2x3M1phVGw0cVI0?=
 =?utf-8?B?VUtkajJVVVpTSUc5SWQ1NDZLMnRHNEx1c3EyaG9wZ3poZkdUTjlVRzN6TjZZ?=
 =?utf-8?B?VUo2bzdtOG80dm02VVV3RStYZXlPWUo1Z1plU1Vib0hza3drUVpsRmV5cDhB?=
 =?utf-8?B?WlVDc0hYMGJLc3A0L1Ird0N5eUtxZS94Wi96bVFyOFV3RExMU2N2VEtHTk5N?=
 =?utf-8?B?a3Fzd0J5Rm9wZ2FVRWNEOUZDZVQxVkViV0gzK3E3SVhGaWZ5cG9FdFNMczh0?=
 =?utf-8?B?dkJaSVZ5UUhlWlNlakduNTlEMFFWTEw1TDY0ZWx2RUpsY3d5ejRVZTFlc05Y?=
 =?utf-8?B?ZHVLclVGYWRnd0dWWXM5eTlNa0Y2Y1JHbGdjUnJlQUtOVGU1Qk1RV1NRS1lv?=
 =?utf-8?B?TVVIeTF4MHhFVHo3RldBelRGS2FmQU45eXNhVFYreng5UHpZZlRHK3VsYWxC?=
 =?utf-8?B?c3NXQ2hUSE5jS1kxSEU3SUx1Q28xbHF3U0MrZTNRRFlMcHVHM0ducGd4K1c4?=
 =?utf-8?B?STdPYnB2UzdoeHpKY0lqU1J6OFdkY0JZRXB3MDBvOGNnWlkzRG94N3BPTFNX?=
 =?utf-8?B?cXEzVm52dWp4VjM3czhodFZDT0ZFMjBvZ25EdGdhOFM5emtqR214QTFaZkRu?=
 =?utf-8?B?N0tOa0RWUEc1ZXNJMHhYK1NMSjRLTUVrbmpUWTBrWWJTWGduUzZFaGVFTFhD?=
 =?utf-8?B?MTFGT0ZxTEd1ZnVvajdiUVhBdEtNMjIzSlNMeW9qNVM2cDJKNkdueThRMFFq?=
 =?utf-8?B?dnZRNzNPVXdacUFlczZaQldkbm82aUZTeFFzMjdhcFJnRG5ZR05lVFllZTNX?=
 =?utf-8?B?WlNSWW85QlZJN1lSVFNEYTUreUlraHJoOEJLd0FYNUZTZ3BiWnVlV2JNS0FS?=
 =?utf-8?B?RWNYcHJxS2p4T1JZUDIvc1VxZ3ozREVCcUZ1VWlSRC9sa05UTFZZSVhZK2Rv?=
 =?utf-8?B?NFBZemVraG9iMTNCcFV2bWFWeklNRmxqSEdqWTl2ZkNCU3J1SXNlYWlqbjcv?=
 =?utf-8?B?YkRDUW15Rm50WjRzMFFueHVab0hVYVVPbTFMWFpuZTEvYzFHTklHelZvdjUy?=
 =?utf-8?B?dHFFMFdGWjFYYzVhUHVGWS9lK0pEcURuQWZ1SXh5NFJyS0V6NHpEQk1jSTFM?=
 =?utf-8?B?Ynh3OFpzZDJ2S3c4NGVUUFk3b1YvTnR1TkdIcm9Bcm45UFYwTEhBaW0rZUJu?=
 =?utf-8?B?RlF3YVRwY2ZacXJpS0t1Rm0ybXBXRTdRK252eDFiWjZxUElhc0lGWml3TVRo?=
 =?utf-8?B?M2ZycXNiZ0ZpQlpTZkxxMjc1dThkeHJUNnpCb09paE9TcDZ6SFJFTHNSajNK?=
 =?utf-8?B?RjRpcHBTeGFacTkrMHFmemlYQXlaRC9UM3FVYVhFZmVqZGNWR0NWSG1QUU14?=
 =?utf-8?B?Zzd6QUlPcG5iTFRBSms2a1hwaVpBa0U0bjhBdGQrQnFYNm45TitJWkdhZ29S?=
 =?utf-8?B?ZXlyQy85c0VSVmdvY1BueFFNZ0RmVnNZNmgrODVCOWtlMXJsaGkrT2FEOFlC?=
 =?utf-8?B?VVh3SDAzQ2h4VU9mN1JZZmhFN09YZTA5YmR1eFYzQ1JwSFpuZFhSa2dHZlF4?=
 =?utf-8?B?MnpSUzRtU0tDOFRDc3ZNSGJvUFRJbURWWW9TM1lBc08vbnRqdnlBZThjOVdT?=
 =?utf-8?B?RjMvdWFDemszb3lrTnN4VGxEaHpEbE04YXQyZS85Q3IzakQ3VEJWMjdHL0tF?=
 =?utf-8?B?R0piZHRFUGF1RkRwcjFlc0k0K01YRStQR2kwYTBWa1dzczU3cC9TMEhoUEFN?=
 =?utf-8?B?cTNTWG5HQWpHUjkxck8vK2JicjczeDNUT1lIRld1SStweEVYU3RqbUF4K2Uy?=
 =?utf-8?B?ejVyRHYxTFJoTEQ1QzRVSVk1NmZma256aG0vUVdGeDJVMFdEaUtXNTJzR0No?=
 =?utf-8?B?MzVRTmg5aHQ2VXl4dlFsaTRRQWVtVVRRQmtxcENEeXRHcjBhMjYrSCthOHo0?=
 =?utf-8?B?L0RNWThwSERKSDlLYTE2bEpabnI5dmM0d1BhRE5sSlZ5S2hNRTAyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da9807d-d0cf-47c6-ee2a-08da2299cc8a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 06:48:38.6781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7iGgqW4ytiuR8BVJ2UBircskAcbnnRd7b9eetWmV+wkoPZtBokvyBXlacShHxZp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1398
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



On 4/20/2022 11:51 AM, Zhou1, Tao wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, April 20, 2022 12:33 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
>> Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
>> <Stanley.Yang@amd.com>; Ziya, Mohammad zafar
>> <Mohammadzafar.Ziya@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
>> Subject: Re: [PATCH 2/3] drm/amdgpu: add RAS poison consumption handler
>>
>>
>>
>> On 4/20/2022 9:23 AM, Tao Zhou wrote:
>>> Add support for general RAS poison consumption handler.
>>>
>>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43
>> ++++++++++++++++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
>>>    2 files changed, 43 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> index 2d066cff70ea..4bd3c25be809 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -1515,6 +1515,44 @@ static int amdgpu_ras_fs_fini(struct
>> amdgpu_device *adev)
>>>    /* ras fs end */
>>>
>>>    /* ih begin */
>>> +static void ras_interrupt_poison_consumption_handler(struct ras_manager
>> *obj,
>>> +				struct amdgpu_iv_entry *entry)
>>> +{
>>> +	bool poison_stat = true, need_reset = true;
>>> +	struct amdgpu_device *adev = obj->adev;
>>> +	struct ras_err_data err_data = {0, 0, 0, NULL};
>>> +	struct ras_ih_data *data = &obj->ih_data;
>>> +	struct amdgpu_ras_block_object *block_obj =
>>> +		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
>>> +
>>> +	if (!adev->gmc.xgmi.connected_to_cpu)
>>> +		amdgpu_umc_poison_handler(adev, &err_data, false);
>>> +
>>> +	/* Two ways for RAS block's poison consumption implementation:
>>> +	 * 1. define IH callback, or
>>> +	 * 2. implement query and consumption interfaces.
>>> +	 */
>>
>> This doesn't look appropriate. Better to have one standard way. What if an IP
>> has call back implemented to handle errors in non-poison mode?
> 
> [Tao] approach 2 is standard way, but some RAS blocks may have different requirements for RAS consumption handler in the future, a callback function is more convenient for this situation.
> 

Since it's a future outlook, why can't we enforce 2? i.e., any IP will 
need to implement consumption handler for poison consumption interrupts.

Thanks,
Lijo

>>
>>> +	if (data->cb) {
>>> +		need_reset = !!data->cb(obj->adev, &err_data, entry);
>>> +	} else if (block_obj && block_obj->hw_ops) {
>>> +		if (block_obj->hw_ops->query_poison_status) {
>>> +			poison_stat = block_obj->hw_ops-
>>> query_poison_status(adev);
>>> +			if (!poison_stat)
>>> +				dev_info(adev->dev, "No RAS poison status
>> in %s poison IH.\n",
>>> +						block_obj->ras_comm.name);
>>> +		}
>>> +
>>> +		if (poison_stat && block_obj->hw_ops-
>>> handle_poison_consumption) {
>>> +			poison_stat = block_obj->hw_ops-
>>> handle_poison_consumption(adev);
>>> +			need_reset = poison_stat;
>>> +		}
>>> +	}
>>> +
>>> +	/* gpu reset is fallback for all failed cases */
>>> +	if (need_reset)
>>> +		amdgpu_ras_reset_gpu(adev);
>>> +}
>>> +
>>>    static void ras_interrupt_poison_creation_handler(struct ras_manager *obj,
>>>    				struct amdgpu_iv_entry *entry)
>>>    {
>>> @@ -1563,7 +1601,10 @@ static void amdgpu_ras_interrupt_handler(struct
>> ras_manager *obj)
>>>    		data->rptr = (data->aligned_element_size +
>>>    				data->rptr) % data->ring_size;
>>>
>>> -		ras_interrupt_poison_creation_handler(obj, &entry);
>>> +		if (obj->head.block == AMDGPU_RAS_BLOCK__UMC)
>>> +			ras_interrupt_poison_creation_handler(obj, &entry);
>>> +		else
>>> +			ras_interrupt_poison_consumption_handler(obj,
>> &entry);
>>
>> Same problem - poison mode is implicitly assumed. Poison consumption is
>> relevant only in poison mode.
> 
> [Tao] will fix it.
> 
>>
>> Thanks,
>> Lijo
>>
>>>    	}
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> index 606df8869b89..c4b61785ab5c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> @@ -509,6 +509,7 @@ struct amdgpu_ras_block_hw_ops {
>>>    	void (*reset_ras_error_count)(struct amdgpu_device *adev);
>>>    	void (*reset_ras_error_status)(struct amdgpu_device *adev);
>>>    	bool (*query_poison_status)(struct amdgpu_device *adev);
>>> +	bool (*handle_poison_consumption)(struct amdgpu_device *adev);
>>>    };
>>>
>>>    /* work flow
>>>
