Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24096C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 05:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7E960C51
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 05:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD7E960C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7D16EB35;
	Thu, 21 Oct 2021 05:24:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF036EB35
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 05:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DihXHCgma/g0+y0TpjB9WQGYwDk7pVFor2KZJQCRDTnjCh/keeqChrvbgMvIPJYi23M+uOTz6BgAcK/2UBrUYO88or73R5Rs/zbYxfooTnmX7IDjE/Lzo9A+ceIiT3WqTW6eOUOMs+CoOaHtx0/rVda+4xcTqRHl5q6XUhmm6XimbHlN/O6ZMl1TRlty6uaIok1P6l7t2Eq3rbvHM2eaIu1zSpuvjCJucPjz/5HQToDLP8C5U6AP8s+wHTp9Z7XNYS2hMphYCb9zNq4COK6eZ7b27jlJmv0BvBP8KmvVC7H+BhAgi/Ov2oOb6vz/SpaG4BLMDxeLYHLgtX5kda64sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/AkpqidhTDxM+XLR50oVKu+7axQb1clcM8jxjEKuG8=;
 b=BEjm3mGJ7rWQUqpme2id7CDchogiK1I784uKmOaBGUd9Zm8xFCNBmpMNJnJF2NKy+LdhVgm9rakWXAPLhzwdCX+W9EUaTO1QE8DT3J0TMcH3kWOsDB96+2QXawkqEPYHwjHHHsBa1PRF88W+0CXtv3S8zIfu7CK8Hx0vJCdC5vgHrIz/f2fKuxH+u1ixXwMKxfNc+0Avl0VBzzZxmIdaP3Zl1D7A0if+NQ7rIKaVWMsWu0iHptFuJYjragbAcRWSWvh+KxKmTCDvaqGQUXdwLO5ECIMfsrekg2/L/hTPKuaW428+XkK6oi86eOUlGwQmYl7yKE63xY4eo7kXEB1Yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/AkpqidhTDxM+XLR50oVKu+7axQb1clcM8jxjEKuG8=;
 b=jaIv1x0hfh3RV06TWPBPt/AUhm0gEZ/3TimE/2EiBHbiH4v8LjdFbjI+lslZfCj9omFjV64xpluazC01d88m4YYeAPwP3HU+pheWWxMQcAfODzQ3UGysYbxqC8DBLui4ejGCrvjCMIs9+RldK3ayyX9wyFf0y69rCjnGRBBleVA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 05:24:55 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 05:24:54 +0000
Message-ID: <edd26c75-6cac-7d5d-97b8-4fc085a76417@amd.com>
Date: Thu, 21 Oct 2021 10:54:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Luben Tuikov <luben.tuikov@amd.com>, Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <20211020163520.1167214-3-kent.russell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211020163520.1167214-3-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 05:24:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78ce9a8c-ec5e-4f92-d7bd-08d994531d3f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3019E9A6B27918E99C1422C597BF9@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+s9LMlpNIhUgZoPgsspJD73EULj/+gy9km70IJUyCosEypszYgVreO6Cy/E26FdVskk/Sc3IHvs/xB3TFyC6A5rFeLeseQ36WuHEdLO3QJnszVKjj5Tg4+/pBllaNdaLiH++FiYF+vOyHywQtzsRKhCpCLpd5ZCPpAVk9/49AMkBmDlDKme1bqCgVAQCU22TXp3Izw0WOMzVYUprrtRD4U+oe3KMyxjLmMkwYEqJyp9WrX7YRnYVLuAXw41rmBfWkVnA5VvzRZR4Xf/Nm9QsbhSMJEHfWxyaBnnHh1tBRKBX5RNEoO8gzLC6ovRBn6zCJaXo3oF1qJQeCyqaiQxqC1i+IAM4xoL26z+pC/1bDr8l8WiSNuwPla75VcNvg8RxXDlA+LGE1ctzyrLqNs0OBHYCyifyQUd+it7AXUyLo/qCilS5OUIDCrh9m8h7S2wkk7Mx3S+XlNEXlkT2P3Uj/qu3gS59xh1HjzbHqNdGybaMYsqPC71QhIaezwBbLJjNrBZDWzr2DY6RaKTJc4sDh5eZyZBPTLudDJl72X7WIZw+fHfOggoKIiwa36reDsarREVirenEHXXie8y1KXFhbSI+wvc+ZMDPPYkPD0264zFv5nrAdiusNLFrxX0lxdKFl6cFsR34vRLcIxelPFTOEqTmuaS1eA5NQMO73knXI2WJ20LfI1wjNOknjkSEf5KlClpLO55PJgXqMJ+k3ZLQzBX7SqcPyaRNwh7/Rs3vHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(2906002)(36756003)(6666004)(66476007)(54906003)(316002)(8936002)(8676002)(16576012)(6486002)(31686004)(956004)(38100700002)(86362001)(2616005)(66556008)(5660300002)(83380400001)(66946007)(508600001)(31696002)(53546011)(186003)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnNDRTNKaEZMeGVpbXhGeXVndTNtS2ZDeWFVVlpjUk1td281dTh0OXpkUUxG?=
 =?utf-8?B?dk1xUzNXL3h6N3NmZXVFY0duSGx2eW9wWmJsanRSOFpMWGQ4RUtTMlBXUUxh?=
 =?utf-8?B?Zit4aGlQVkcxMUNsWjd0MVJocllKekR2UkhVa0xjZm1aTk5iMUt1UCswU20x?=
 =?utf-8?B?dFlqeTIzNngycEhpQXJHcFdKWnFpTDAxUkxRK1dqYll3bkxsV0cyUnFlaDQr?=
 =?utf-8?B?ZFF4RDZWMDBsUzhZRVMwQXlEcXIxdEhrWFUzeG5oS3ZsZjM2bkIwTFNZU2hE?=
 =?utf-8?B?Q0h3SXBwVkMyN2xGTzg3M0NBZGREV28veHhsTDVLZlNpYndJVFBtWFAxRlR0?=
 =?utf-8?B?dUVhVXJXMTBabXJnMGhLcmkwT2FTMlFyT3dWaGZKb3pGRW1ZK1RHOVpLL2pP?=
 =?utf-8?B?VkUvYjIrVFplVEdiWGdVdjBGd2RtRk84eVFaUnJZcmUveEdwVUZXa2ptdS9L?=
 =?utf-8?B?WnhmLzlHV2wzcXl0bVdIN0dFL3RvS1NtazJGZXhrbHRSMTIxVTNiWlo5TUpS?=
 =?utf-8?B?TXFRYk4yQUpNT2tNSXhKOEM5OXN6WTZjNHVUa2NoaWt1dU9yYTVPMHFRYk5p?=
 =?utf-8?B?ZWFSNExnVDltYXZzM1Y5TXd3L1A0Vit4NUhidTMrWk1udXVqSEczVzdnUnhB?=
 =?utf-8?B?dDdObjBzNTRqTCt6cXNMS2hSUzhUL1pWdmRKbE9xNitpVysweHBsbE1nWUMz?=
 =?utf-8?B?aU04elptTzNKNnBBQUsvVWtrdXFnN1luUldITHpDU0dWTlROVlVvOU9jVEJh?=
 =?utf-8?B?MmhyWmZ0T3pNbWlSa1lJQU5MQmZ2aHozenRncnNodEYvaStQck9DS09vc0ZM?=
 =?utf-8?B?S284RG8rbVo0YWpvVUJRa3FXRE5Vay84elNYb1NOOHRIWktOZ2tpUmdncUVP?=
 =?utf-8?B?d3pxSG10V2RKK3pNR1k4WW8zVklRdlMrTnZ4UWlBbmIrbVgxcThJSU5Hc3RZ?=
 =?utf-8?B?ay82NDkxN1RUK3FEbWtUM1hQNm5GSG9RZ0MxK3U1OXVrRTg4WGl3ZzF2R0lH?=
 =?utf-8?B?R1B5a3FIR2dBbVpkb1pOOGo5a1hWd0hFT0R4dTI3bGJzSFhmWGt3WjJnS09w?=
 =?utf-8?B?WnZJVlFNSXdDSUZ4aUVUNTVNSVMrcUVoSWMrRmNiclRrSExWMlNTMnFQN2dB?=
 =?utf-8?B?VU4rYVBET0txOG52STBTM0hFOXB2UUFUUWhRT2Z6a0hTQ0Y1SXFIaUo4WnVy?=
 =?utf-8?B?ZTNSVjFSYzJ1NFZJUFBhd2hDd2hic2RiOGhQQzhneE81WHIyckpSMGI3eFlj?=
 =?utf-8?B?WU1PejFLRkFzQ2dYYkVaTjZ1UjA0UWVEYWE1MXFtdEUrQVVZQ2NJMVEzcWty?=
 =?utf-8?B?WHk3bXBtZm90Wms0eHNLTUZ5Mml4OVh5Y2NkYURoUWh4UUFuUUxEUnlQeDJw?=
 =?utf-8?B?T0FrTDhwSTBsaFZUcnV3aW8zQkVDbndhUGt3a3NwQWRuditqSTFNNDA0cHNK?=
 =?utf-8?B?bjlQWXJremRZUG0zcWMralFpaXUyQk50WUlVdUNWbzNWL2R5YW9nb1ZodTNF?=
 =?utf-8?B?c1FHV1RmQXZSd1pCNmJwTnF2TmRkeHcvd1BTQWJDUUt2dW9tVkk0R0VscTU4?=
 =?utf-8?B?dGdXRE1hKzkxWDYxdW5lSEVURWhNMW4zZkZVT05pYUlhd2VaZExzUk9GTEp0?=
 =?utf-8?B?aDRTdmI0WlB4YmZrYVhncUdnUW5BUWRuSjhnNzBrUTU0clRhKzU4ckpKeWtQ?=
 =?utf-8?B?WW9LMnBZUkIwdmlDaGdPTEJvd3Y4TGlZVFF6UGJPZjhCYWQ1bzMydnRaMEY3?=
 =?utf-8?Q?5x1ODgd/hT0qLPUlpMEeEmnFh0kTbSotrxwe/a7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ce9a8c-ec5e-4f92-d7bd-08d994531d3f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 05:24:54.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
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



On 10/20/2021 10:05 PM, Kent Russell wrote:
> If the bad_page_threshold kernel parameter is set to -2,
> continue to post the GPU. Print a warning to dmesg that this action has
> been done, and that page retirement will obviously not work for said GPU
> 
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 1ede0f0d6f55..31852330c1db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1115,11 +1115,16 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>   			res = amdgpu_ras_eeprom_correct_header_tag(control,
>   								   RAS_TABLE_HDR_VAL);
>   		} else {
> -			*exceed_err_limit = true;
> -			dev_err(adev->dev,
> -				"RAS records:%d exceed threshold:%d, "
> -				"GPU will not be initialized. Replace this GPU or increase the threshold",
> +			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
>   				control->ras_num_recs, ras->bad_page_cnt_threshold);
> +			if (amdgpu_bad_page_threshold == -2) {
> +				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -2.");
> +				dev_warn(adev->dev, "Page retirement will not work for this GPU in this state.");

Now, this looks as good as booting with 0 = disable bad page retirement. 
I thought page retirement will work as long as EEPROM has space, but it 
won't bother about the threshold. If the intent is to ignore bad page 
retirement, then 0 is good enough and -2 is not required.

Also, when user passes threshold=-2, what is the threshold being 
compared against to say *exceed_err_limit = true?

Thanks,
Lijo

> +				res = 0;
> +			} else {
> +				*exceed_err_limit = true;
> +				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
> +			}
>   		}
>   	} else {
>   		DRM_INFO("Creating a new EEPROM table");
> 
