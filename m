Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EC9C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 14:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B555C10E6F3;
	Thu, 13 Jul 2023 14:58:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E30010E6F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 14:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eExZ5Lm/vlkdfh+wAYqq3ik0ULfckR6q522heH3SLb6JCdEkP2ntDXEqkHnihmRtlBUBODmRb65SpirzXcngmDiaYS2YIltKXxYKt7+sgFDTIpSP7otmyfRWKMhOgzYz9c6ji2MmugGC1g6HA0u87C+ZF8uYPGNs4klgNXa8OwJlPGmjpWs/EJwklf+kCvam+57Se+2GmlTpLjBKlhRwxNsfTMoRJyXWcv/w/47B+C9u1jBo5psx4glCU7nNpRzeCjn6vMUhukwLuc2Z0W237siaVuV+Mb/TLKu7N0/Q0k/NOEFZshAdeuVMqwAfwfIJovt3fLNyrA0VdHT1b2ee7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKWfT4z8iC7R5K1SjICYkJiRrqQVZcleRszzCjL/Y5g=;
 b=UCxzWPj3YeHcI2UhgMSKV6J4CjQC0ky70X/6H8UcjD5hyK8KtIGkooKhjJr3pPP19sDmX/6CyWzCm+fMm5b0N0YdMiTyCTAZ8GawBFEQtQR9/ltRkYTGfiVjcNDImEmIsCiJYacH1G+wR1/W5tUA1VC7GaBr2iwAV12IsVrm46ETuciVrVHz9lbqB+ujbA+4S1N1tYCvhSpvArSwntWo/SzGgRemDMmm8mFbbXA5n/WDuKE4UdkBFBruYTBqNRG1/wsercPVFGKk0th63VN3AvKJFJLVs9AzPTDdk5JoJqUswO+Y3gz8QcFA8+zav2l+7cd4bQ2WaaRlIKLc5LDILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKWfT4z8iC7R5K1SjICYkJiRrqQVZcleRszzCjL/Y5g=;
 b=lWvdQv12b5JexgEO9NmNLHSzLaiKYkEo5PYXn/EeO757mckE7yOu5lSm0E8XfW4tuzA5TEwxzpeeU4ndjwrVOChc/b+wsUz4VIFmGWD+JzhaglmQuQC58aXkBu1eaGMXvcN++8fiM1jWRrXcDBCxF7lo/L26rcjfk8PsV/I783E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 14:58:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 14:58:20 +0000
Message-ID: <88161914-05f3-fb72-227b-3758e59208fa@amd.com>
Date: Thu, 13 Jul 2023 10:58:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH Review V2 2/2] drm/amdgpu: Disable RAS by default on APU
 flatform
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, YiPeng.Chai@amd.com,
 Candice.Li@amd.com
References: <20230713145056.54876-1-Stanley.Yang@amd.com>
 <20230713145056.54876-2-Stanley.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230713145056.54876-2-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f05b55e-1f41-48a5-4f02-08db83b19905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNhHUqLUIUE7j7xA/eERT5szeNLOvHlCgs9WRU7iD4H83dXxgo/Afcc/mArJPHfHnshTUxpGwNcIbhR6LLpP7OnEaku+I5PPpARiZ6pH0iCjlVgJmbrN2qq/LGaR0Us/Bb+BZvArUj9VM29swphXE7eKzlLaEEfU05TEpVDuv/pPQQnzPV6iMQV1IGHNRng4r8MeuMViEFhMRuzk+/Tf3jDL34aX/3O2/mju34IQpfJvI+v+RVzORlQhtA3X8cNqtbtRm1yeEY0Ca+T2vVB5OMJU+rgF5vBad+s3bLFpFeyUrFLWRrH3n9vcGLVWO4bPfhIWq5ngxyFYOaScHchpEnu5heNza8ht/RN6yHHN/8v/6mubhoIkzY5LZfjHpswtU6aGKA3T0D0tk8XTBnFMabwux88jeRCn+8qYM9H3t1TKPGx4Hdteccbh+9OLOQBRnMJswedME5+jS3wKTrkW4Er/jT6PhFDEI3BCDRdWCRYvwSYjqtWimEamas0kfPKC7L8lPmn46tJwoznGWYEYZPq+HXXg/siwDY9nIVuGkK+oewRAD1QLQJP3hKyRocdbSKZO5af4gRM5zGKOAA7lyCRe+6mpGHrMP3Pnx6ssAv1nkhlZ0BiPdtH4Nb4Sbwt6Dv1QPXv/yan2u7DEP/lm4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(66946007)(66556008)(6636002)(66476007)(478600001)(86362001)(6506007)(26005)(31696002)(53546011)(186003)(36756003)(6512007)(36916002)(6486002)(83380400001)(2616005)(38100700002)(41300700001)(44832011)(8676002)(8936002)(31686004)(5660300002)(316002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZReHFFRVl0ZmYxYTFkWTl0Mzh5R2RZUnBHOXVNZDFkYTBkS0lHN1NiaHdK?=
 =?utf-8?B?dy94blJGNnVPTkFHVnBibFN2UWNoOWtmNzY2aDluTVZyOWtUZE1lSUkzT0ww?=
 =?utf-8?B?UDdiTDk2WmVlNk9QYkZyeVZxeUd0cllhM0FHWk1xWDUyVlBhQ1ZwMmxTaUZF?=
 =?utf-8?B?aUFvU1ZwQU5oWjVHTi9HRmFGU0RmZXd2NFhRNEh3YXovR0sxcW1OTHJqWVB3?=
 =?utf-8?B?WUdBNGJoN05EZ1ZZaTJCVGxuTmlVdXpMK2dscm5EeDMvRUY2T3BzVXRXTWho?=
 =?utf-8?B?ZUM1b0VjdTlVdmN6Z2RISVc3NnhDelpjenpGa1JuS2dVbTZVeDkxQithRTNa?=
 =?utf-8?B?Zk9jY3JEOG5HZmphRDZHcHBxM2tuQWxTQVlsalY1OUdFTkpXdEtTaXJueXo4?=
 =?utf-8?B?cENsSDdCZTVYR0tnNDNVRkdMZk4zS2h0UkJSeHdiS2lVejdnRmZVbGhQRGxs?=
 =?utf-8?B?SmljQ2ZnNitteE9PYXV0WGxwQnNDVVpTS29JM05rUkFycGNxdEt3ZXJia3RO?=
 =?utf-8?B?NDA4bGNud0JiUjNDOXNacW9hbjZ4STd1TGxLMEtwMGR2RTVKTng2TG1VUFZz?=
 =?utf-8?B?UEhzb1BxOUtUZk04dTN3S1dzMEdOcVI4aE5CcHB6ZUFFODcyVTBsdExiMkYz?=
 =?utf-8?B?YmRCYVpRMWdCOFFCTTFEVnYxSStRUHVyckM1V09lZGxWLzRmaHoxanNSUFZ1?=
 =?utf-8?B?WndpV0RrOTVEbG91VG9GVW0yNmdtTWpjU1dzbEVwYlU4V0NobHV1RExOS1VO?=
 =?utf-8?B?SW4xNklobnNGdFZZU2pUZjVMYVNBbCtEZmdZajFVQnZFVXQ2SExVYTE3TDZU?=
 =?utf-8?B?OHFhcSsxSUhnY0Y2aE1zL1c3eUs3N1drY1lXR2NDNWFsdU1nNG4xQldqMGl1?=
 =?utf-8?B?UGFkbmpLR2xpb3RzSk9xTUs4YmUxNE8yYXNPUEk1ejNONGJwcGYwV3pZbE5v?=
 =?utf-8?B?MkxVZlJBNGNZbE1pcnRaYjBBekxyanR6enFleU80alc0bG1MMzVnU2VHNHZo?=
 =?utf-8?B?c3o0VlVlMi9HRk1lNlRaMEU5TmdUNjdaVVBJL0lPYk1NbFkvc1gvMmRkNXhW?=
 =?utf-8?B?b0dXSkx3bC9XL0svdVIwYUwwWk92c0w4OERRQ3YrSGZ0ZG1XUGdoeVRnRit5?=
 =?utf-8?B?cUZscWJmSG1VQ2cxWG0yVk1ZcVVQWUo5QTdYaC9jWitQcnVta3ZCVGcyN0Nk?=
 =?utf-8?B?cnduYUl2TndYd3JlcWtndnprdTc5Y2F2SE1pKzZYVXB2ejlkRllHWXc4WGxa?=
 =?utf-8?B?SWRPQTJyTThsMkFUcWFtZ2dqSk4wVFp5cFZUeXZNSkpPbDJkL3NTeWFjekZP?=
 =?utf-8?B?c1lncW1oOTduKyt5emxFVEhaKzc3OFpoekZBUjNpSjk5bFZQcHRLTk5nZ3BP?=
 =?utf-8?B?OTJaM0tlL081NVYwQjBPZFFzZHlyM2dNaEkrM0NNRjNsWnQwQlFyeTV3ODVs?=
 =?utf-8?B?cmJJUFZtNjFDYVhaRmxlZysvOW1ZUFYyMHhGQ09wNnZSaFdDQWd3cENYbmd2?=
 =?utf-8?B?NTFHU2NUUkQ1aS9jSnU4NldDUUJhYUluRnV4OTlOVENJQU90UDVzdStod0Y5?=
 =?utf-8?B?NG9BdzBrVnZDVVBrYnh3QUdMTjJ3YXhTdTVXbStPSUlIbHRIaCtHYmJiRGRI?=
 =?utf-8?B?SUhCUzFuSzJwc293M1dUUzZDajZ4UEF3UHlhZDlJaDVwWUt4ZU9MenVXRWhY?=
 =?utf-8?B?MU5hcklYckpza3BqMXFqc0dRWndSMkViYU1DdkxlODJFNzRQUDBrYS9PS2Iy?=
 =?utf-8?B?emRKN1FzRnFXRWR3cS9QSHZINk5pRHdkOUU5VGE1MThuMHY1ZHpIYWphWDB4?=
 =?utf-8?B?Qms2L1pKSWdvNVQwMXdXcDMrZnpicGVNL0NvOWk0Wm9SYWg5Mlp1TGpHbjhD?=
 =?utf-8?B?ZFhnUWh1cFp2eE9sL3Nhekg3MkJqNUVGd2NTMXZueFRrdXh5MlRLc0MrRnBN?=
 =?utf-8?B?RU8zdU8vQ0Q0bXV0ZHc5NkVWM1RlT0x4SWQ3REJxMkZPK2lxY2NPMkpacHdi?=
 =?utf-8?B?d01wNU5QY2FhdUo1bzlKUDEzdW1SZGFnK0lDUVVwcDRXa0Y2aW9hODZmQkNm?=
 =?utf-8?B?RzBTOUdickcyYnRzV0RxajYzUjk4K243Q0VhWDcxRUlLbkt0VkF6RkRjaUZj?=
 =?utf-8?Q?H/ZluepRJEYklsCBPtpBNAogn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f05b55e-1f41-48a5-4f02-08db83b19905
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:58:20.4440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aextciYEx9VzEqNmjfclggJ4Oj+ioiY2L8eyakkTNGEjz0h+TUrOF7p1hrUbQt+mQBogP54FyI1UAQ6gmw6meg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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


On 2023-07-13 10:50, Stanley.Yang wrote:
> Disable RAS feature by default for aqua vanjaram on APU platform.
>
> Changed from V1:
> 	Splite Disable RAS by default on APU platform into a
> 	separated patch.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8673d9790bb0..ec5f60b64346 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2517,6 +2517,15 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
>   		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX |
>   					   1 << AMDGPU_RAS_BLOCK__SDMA |
>   					   1 << AMDGPU_RAS_BLOCK__MMHUB);
> +
> +		if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6)) {
> +			/*
> +			 * Disable ras feature for aqua vanjaram
> +			 * by default on apu platform.
> +			 */
> +			if (-1 == amdgpu_ras_enable)
> +				amdgpu_ras_enable = 0;
Changing a global variable here is probably not appropriate. The 
condition above looks like this should affect a device-specific variable 
only.

Regards,
   Felix


> +		}
>   	}
>   
>   	amdgpu_ras_get_quirks(adev);
