Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB61FC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 17:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523F310E410;
	Wed,  7 Dec 2022 17:48:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E0110E410
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 17:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njstJmQYjUdWCwciU6YoQnN90oEp5ET0ym0ByfhOdjgTNpe7mGm3iOPUI6kLYqXdRruQCiFdHk3lmLe1pd+qEbeh6J24bYC67ecQ7iSOwWENo6v5ItRC7q2xr/9oFscOtvWjjMWPJ+ynREBJh4VSmwS3q6YOcBXV8EDm6tAEbI+P74+W2WVbUPLlmRtrrDrJ/W8kPrK0MqQwuKxQB4TDOXBezUYJJFCpl5L7eJg1Y1/RXuhPCqIltwQcfFjZzD9kPmMht6F+3i0vPYPVcbTl0ngZPJ6kpZ4My6V3OaCy3GsbuE+NQuD8WoMjM7Rs3LoPuBMwlNYefnn67wVdY2AfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W61bXSFgr96t+ELWF6rIpWoGV3wVTCzOcEwWl0l5cdA=;
 b=NPtsL5VJslbHB+1wML74E6Q2d6a9AvYWUcqCy3PS5mJiZlVt4dg53mOZVQUUfRevfgpD8aqsxNwxmL/+d5Ibmz4bnZqO+clwiaPudDOR/SNiNbk9w51coDtdXq2XyVEji7HtUTEw//ukpV+7Vq0hVBxZtUgVwH6lSDXiLDSTLXavDmGjirJf5Howy+jla5gzrUXMzbNvmpXLn0mAZ5EpAj2N9SVka+tnYV2NE8fHWt6VaJDXJ0DbgZE60aUMvP1MweSK/uBoztcIPxRv7RmQtLVzBGrKYVBEB3n1LoLsEedNOAr9PKV3oGPbRPni8n0fmHLiDRX/jj6KBTJfGTbORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W61bXSFgr96t+ELWF6rIpWoGV3wVTCzOcEwWl0l5cdA=;
 b=U7tJ7gmBckesMvXn5JpptWyBcaKZwEZEd2+J1Isx4OBe2EUtA+cLDi+ld4ShKCA5Pt7himpIThid0EvLFKWZhroXrYKuYxKNinKANkM1zwkleW6dTz+zLIefvW2RKR8dETX42AjjICRY2K6MJSoq3NTgvoV0GZgV4kabyvuh+3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 17:48:45 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:48:45 +0000
Message-ID: <9258f22b-bddc-0518-1400-d0ac6035adbe@amd.com>
Date: Wed, 7 Dec 2022 12:48:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] drm/amdgpu: handle polaris10/11 overlap asics (v2)
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221207170629.3291883-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221207170629.3291883-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CO6PR12MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f6bcd1-513b-4abc-a652-08dad87b494d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyc6shERNKOfz6wbWjW/+BJbXGOoOjM/biyey1/epCt42EYsyVD4+eKXwsUZTId04750HwB8woP3chnUon+xEtBEmuCEkSPtm0zpgow7CWGfL+R1DF1eVMDEtgNarn43SnZOW9TTPyFjKFLlG8wW3S8q8gQFjF5p9+7BwxVlWcQ0CGSnCqn4FXHsNH7/wqPXgy/WaLZISqeXP1OVFjOQ+oxVcss9UnsMPKLzIlaZJGIR1SkEgEr0V+adjgFN1jje9DIRb/BC8Wou05+c2JosWGaAPqWppvaAg1z05Q9I7jfPLIXyWzdACo061HSSiuBYSgdU/6zeNJeBEs3eutFu3IIZMFoGeh/WC/eIDpwtoVteHaeEP+pCLXXHiktAj5vJll7Fb0p2Reu1/9cT8Fjse09nMK800uJEe8S7HqwoHg3GE114tlsvDLfrtq/kn+4Kix8gs+yIA/NiSA47GiKfFKxiwZhMabhmMd5C/3KS8+NZSIqwcoehg0OG900Ee/EBd/a3ajnjpzGLvpRFUaD/ux1pMJ7BzawQeA4X5S8oQDwCCwUbbS6Sduzp4FIQhir7nkfrIHuMhgBBRjWTmoH635ABdp0tvQFBw4wr2p/uGSQ4SGLEP+wSrlMHYrRi1NOWWB9nLskFT3xqN3r2B94vJqW04HuapLP/mansFjEk9LM5vdwbjvIKvmYzApio4fdadKRyMj0bMtksfenybfWwoJ9XLxOPC/IFOGe0YSYwUxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(38100700002)(36756003)(31686004)(6486002)(31696002)(316002)(478600001)(6666004)(41300700001)(66476007)(66556008)(66946007)(8676002)(44832011)(53546011)(6506007)(8936002)(5660300002)(26005)(6512007)(86362001)(2616005)(186003)(2906002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVlRTEwL0R6cWxZcUNvVkFMYXBqM3JjNDBxNmI5WEdtdGNyVG44SkcvQW96?=
 =?utf-8?B?QnVwWlpZTUM1VDNyYjlHSzZ1cGhwc3dMRFZLNEQrNStyR3VsWWRTOXlrUlV5?=
 =?utf-8?B?citPd1YrcFE2dUV3NkVCd291bmdPdUFMWktCSDBweU5LWkRBS0IyOTNsS1JG?=
 =?utf-8?B?SFVQdC9YMDY3blQxTThON2M1RXk4VFZYUGtmaHlWZitjR21walhMQVZKdHIy?=
 =?utf-8?B?ekNmZjIyc2prWktLY3hlRS9YREttUkFNc3pITzJxMG1Mbk9rbGRRTDJ5N1dq?=
 =?utf-8?B?ZEIyMnN0c3pTTUtWSERIWUJRcW1uWlI5cXg3MTlnWHAyQ2tRZVFFSytNYnIy?=
 =?utf-8?B?K3dJUDRsa0d5WTVzc1FMU2tRQ0RIdkprMGlnUzF0TFkrU2lZWXpYZVVndzJ5?=
 =?utf-8?B?alpTYVhPU3RCdUVyeGJ3T09qNXUzYUZoN1MxaEFKdllyL1NzQzZYc24xa3Rs?=
 =?utf-8?B?MXRQeXBleXR5Y1JMWTJLTWlvNFpRQXBSckhVUUUrcHA3S3JMcnBJQ3VWR1cv?=
 =?utf-8?B?QVorQXUyYmZCOU9KZW5uTjBtU3l6VklERnNNbW5qZDZBMjA1Ulh3NmltUkcv?=
 =?utf-8?B?aTBsRDBjTGV0QWpwRVlhdnI3SmhqK0tqdXJPdlBjR3RNem5kek9PVFU4T0Jh?=
 =?utf-8?B?a0hPQ2Z4aEptck9Eb0JJV2hZK1Nlb1pFbTBMZTl1TDFxUWpEOFlpOFZ3ckdP?=
 =?utf-8?B?SEY2WTdwaFhsa1AyNm9PSjI4b3l0UzUwcUxSS2o0SzBQRXN2ekhHOWxLdURk?=
 =?utf-8?B?MlI2dUU1SkFuT3RPc0RreVMxMnM1NmxuaWJlSDhWVlFjNGRXblRDVk9kcThZ?=
 =?utf-8?B?bkI1azBUMFlOb3plc1lWTG9QaUUySWJZb0VWUFpwUFNwbG5OajNXTWdQUS8v?=
 =?utf-8?B?bU5rSnovL0RFMGgrbEpDbjJZKzg0bzBma1pxZHJLYkN6Y0k3KzNleGZKMURv?=
 =?utf-8?B?L1lQeXZzWDNPd2dURzN6OEMxSWVXUjdVYU5XcGN5WVUwOWJtU2pRK2UyTlZz?=
 =?utf-8?B?eENPdnFWSVFvTXlSNkhla3ptWFhianFkb3JRblg1ejN4UFlGWmNScFdnbXpw?=
 =?utf-8?B?OGhrekEyRWh6NE95VUIxT1FnSUIxN1dvWEx0M0d1TGh3RGJwaktvOUkyaDNV?=
 =?utf-8?B?YlpxT2lWWG5vQ090dkFRNnZYOUNnWmJxaHBSQ1pkaDh5Z3JjZ3ZFdStZc043?=
 =?utf-8?B?ZTdLMndJTzZVVXZwZ3laajZQSlQvcnR0NXorMFZyVTM1YmhiRFdRQjBXakZJ?=
 =?utf-8?B?S2JXZmhiaDZpaEUzaERTMlZrTk9TalhVLzJDczg1blFWYmxsNkRTZ1I4Z0RH?=
 =?utf-8?B?MDhYb1ZDS0tZM0htNVhvNVZlQ3ViZzM4U0lHaWlMUjdZczgxZTdKMVRUOGg2?=
 =?utf-8?B?ajFmZXpFZEhJbytOT0QwYmZINXhFSzlQc2VicGRTMHBiaGRnRndJQmJaeEsv?=
 =?utf-8?B?VjFnZkVYUW4vb0xGa3ZoYnpjc1NZTGVYRVNnY09DR3hHZEpnQmtKR01mS05y?=
 =?utf-8?B?aG1tVDEvT0ZVUHIva0RkSUlxWkJNUzl3aUtFNkpnVEhBRGVScVExZVFrYXNH?=
 =?utf-8?B?aUpSZVk2TDJqaWVubE55K256YzBXQjNnRk8yM0RYWCt5RFQ0RmtJamRPNWpL?=
 =?utf-8?B?ZUU4bElyQVVKMDJtbUlGSmkwRmdrTWdiSGxSNlFUbDhtbjljRURrWDE4Mk4x?=
 =?utf-8?B?M1dHdXZ1RXBwSjB4VGZRU2FjRm9FR2tYVkR5ZHl0OXFnbWhEamwycGFkbjNN?=
 =?utf-8?B?Y0RNdDlzeVZqU1AyR3hzdXpoODB3dzRJVGUvaTBTUkU2M2V5UjdVTExFcjVK?=
 =?utf-8?B?akxxMzZPSU80dXBxTUJvbEhuUXluTUZ2MzZwczg4NWx4UjJIMS9YSUZaQ1NQ?=
 =?utf-8?B?U2JnUVBZdHoxU0VXVnVKR3NIbWk1TDdaSW5VYWl2c0I5bStZaXJkemEwWm4z?=
 =?utf-8?B?bExEYW5MeWcvSDJkQnFtdTZ4ZWZzTXNnbEpVR1V3S1l6c1ppcnYzRUJ2RWRX?=
 =?utf-8?B?RHlYTnpTVDRHSVFGN1NveEZ5aEpZRXdyNVR0cUs1RDd0L250UG9HTXRJN3Qr?=
 =?utf-8?B?SUowSWprcndtYVQ4UGpLZmdnbHptbHdmLytDSjZ5RnYrcVFCc1BxeWxJNFNL?=
 =?utf-8?Q?LlqrRX7IY4NfBn8+losjSYq3I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f6bcd1-513b-4abc-a652-08dad87b494d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:48:44.9686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvQK4bNPvnBxzl/Gz7rgD6z5BrLVulroh9d+7yMSDjlOX9XvNul2zNB+DltRl955
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-12-07 12:06, Alex Deucher wrote:
> Some special polaris 10 chips overlap with the polaris11
> DID range.  Handle this properly in the driver.
> 
> v2: use local flags for other function calls.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7383272c6a3a..b4f2d61ea0d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2039,6 +2039,15 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			 "See modparam exp_hw_support\n");
>  		return -ENODEV;
>  	}
> +	/* differentiate between P10 and P11 asics with the same DID */
> +	if (pdev->device == 0x67FF &&
> +	    (pdev->revision == 0xE3 ||
> +	     pdev->revision == 0xE7 ||
> +	     pdev->revision == 0xF3 ||
> +	     pdev->revision == 0xF7)) {
> +		flags &= ~AMD_ASIC_MASK;
> +		flags |= CHIP_POLARIS10;
> +	}
>  
>  	/* Due to hardware bugs, S/G Display on raven requires a 1:1 IOMMU mapping,
>  	 * however, SME requires an indirect IOMMU mapping because the encryption
> @@ -2108,12 +2117,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  
>  	pci_set_drvdata(pdev, ddev);
>  
> -	ret = amdgpu_driver_load_kms(adev, ent->driver_data);
> +	ret = amdgpu_driver_load_kms(adev, flags);
>  	if (ret)
>  		goto err_pci;
>  
>  retry_init:
> -	ret = drm_dev_register(ddev, ent->driver_data);
> +	ret = drm_dev_register(ddev, flags);
>  	if (ret == -EAGAIN && ++retry <= 3) {
>  		DRM_INFO("retry init %d\n", retry);
>  		/* Don't request EX mode too frequently which is attacking */

