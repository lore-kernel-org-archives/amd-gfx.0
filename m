Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F84C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649C710E689;
	Mon, 28 Mar 2022 13:14:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D0810E689
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNvnZzUMFLoSbsQnOoW+xMYSgNQcteLj5u86Yu80kSlwI99IfimcLJUBQ7avUDEXbc8g4s7+CTg5L8HA4XoaZV26QQ8pChOgmbJOtzv7r43cGPISIzCTHXgatZtR7g8olu3ZLl8WDgjZawJXnvwLzBXpohVItYBbVhoAlttab6W8Esz3r/nNeKNk9bb1SCDTcCA5f3DEaP8MkA6MAiVPXXW0LLXromAxsSXlnCNfcq1sGBNN64W2SNKIykkcY39Y3zs4ZM+G5G4Q98mTD7avn1Y6hN+GqOq+DOy5sriSrDBwJVzp9TNyAKg/0VHDEP6+Hu2X2RbufJEea5tMrncscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uOW392SYWFAVJJN8+RJM1NrGFY3/4q4YBNsb+AmqOU=;
 b=ZUagOkrgly4IBo/zHw6aDY9DCvBizZMrSa8M1iAAFQ6eesgh2Km3Bq7qJPgOJtmwCyBsnwmZMCpEIsPLbMseTpU5S6h/h50fnHLjK1AtIXSZ8cbep4C3AH62uzfynrfmIO8gG22EcCCw0gEvBU2EBsDPuom+Zc3zjkvZpt/Sfee7EVQP3kcEXnMBtM9jpwAUwd2oqJphjUMi7RqmigvIKOFLtGReUp0bNaTfev9QPpHMDs+wn9WIX7wd5GmwBd43ilFbTsr95Az667KY6RhiBc3vx7O7C5afgTCS6G3VFr0mhM5Qs0TuwTIXu1iDX1wA0LF4tFy6bRrwLTMpkapqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uOW392SYWFAVJJN8+RJM1NrGFY3/4q4YBNsb+AmqOU=;
 b=MHJJGjkDbz4hh/6MdzBBx5mEXPW0aKs1smJ6RpeK0mStZQpYWHk3wGER7xwuXMRvZPw2lCzSETaE7FIJ0ub/3sgfr0hGc6d7vFpSJjazvZ6tgDWNutwAeLyovtZkZ4/05AGIeDyB3iKvVFQEPCeFkjZWTyz5sn2mW2T7u4KaUNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 13:14:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:14:51 +0000
Message-ID: <258967f4-a3bc-484d-9b4d-0f18ab3876c2@amd.com>
Date: Mon, 28 Mar 2022 15:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Add tlb_cb for unlocked update
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328130700.29642-1-Philip.Yang@amd.com>
 <20220328130700.29642-2-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220328130700.29642-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0351.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e75ed87b-9dc2-4376-156f-08da10bcf172
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4502A4E4AB58DCB55AAE4CEA831D9@MN2PR12MB4502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8xCwRZPDkrLx6Ucp3wvq4pofK080WUakNlDRWhpWh0SQcow1oD2DBlJg4kdl7gAWefEE6+kI7/OBagVaRQAiSev1V/PLzbC8RsX7FyyA5Mk3lqAHvpnV+Q+5EduM4vO70fOyC4T5USnZaXwaoFOMSao0PzDM75HqU5ZKd9+aYqWjYcKiu2kD+PU3DLEFrq2IA45UMF0QDAEKAyr67R5FshZ02P4tkw45m6t42snbCG6ngtw4BVDivacLyL8ocGyxbjgEFhwbgWPiMr5KyZiwok8nGhygVXFky1Sd+THaoLqv9oz+7ZW7dEvj8/CcT1XcPPYvTK51JJcLdEylMr8IheIFT8e/DVapI7a99k0t9t3mjRRh6mGEbvN0/Md9LJpQEI12TfiDWQ6mc8OswOwP47miOCFz8aXbmUHwbaFwVIn9zrwxkRJ4go6ezokosn8dHhvPWAwxnl1q2u6R7pmFWB5P1iezsAEs2SfjUFinMUJXUZqpw5+hWPsWvfwsj/HR2EP8sdpKPiQNhNBn3SRhKZN5V/jDLjX4OfS+TlwJFwRRmqbunX4vPrTUa4A7vGyNRxKronEFdgA2+XE6dPAQAK55rcHp8FS3MZr59BKIkhHigUwc+xYGjx3BtNTO19tSBHh3whAyZlHWboxKU8BuHymnCe+0ydDz+uhWFUB+LCAxL5GVFt3GhQK+1+zd2veYRHQiMIlr3zYXaNtiVFtVeSneMGWUKX4PQqaSPrNdxDf+pqo7PYczwMoHDNnnWKq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(4326008)(8676002)(66946007)(316002)(5660300002)(2906002)(15650500001)(8936002)(66556008)(36756003)(31696002)(6512007)(38100700002)(86362001)(6666004)(508600001)(2616005)(6486002)(66574015)(6506007)(31686004)(186003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2RVa2JuTkJXRGluOVlJbU5UZGdQWVFPTGxacXlSc0d3TVQ2UXdrbE0xN3Jw?=
 =?utf-8?B?QWVUZkpMZG9EUnNiQS9kVU83bEsrNWxpVWxZWW9pd0VqTlU4cDI5Q3Z6NGpu?=
 =?utf-8?B?Y1dsd0l6VmdRb1h1SnRta2JUVXd4TXF3cVp2dWx3SmRtQnhvWk1EVWdmVzFY?=
 =?utf-8?B?eHhWNHAwYUVEK0lPdS9wbUVIejc0WkYwQ3FNenhWbFpOMXEzWks0TFJ0aWls?=
 =?utf-8?B?RHpRVzJVaVV4Mit0STdrbXpBZzQzRE1hWlQvQmwrMGtBbk1NUDh2OTdNaDZX?=
 =?utf-8?B?dnJ5VFhLSUdxTVpNWldjcWxXeXEySVp3ODZmaVdkb2JsRjdWZ21QNWJHQlZt?=
 =?utf-8?B?ZFhkSDJTbklpc1FnL1NXYTIvMlNWcWMzUXA4L1Bmc1hnc0FzcFRkb29pdHpB?=
 =?utf-8?B?QWdkMFhjRC9oRkdWeWJSRVNscUVkcUF4NjVvaCtVSE5oenB1cXNLdUlBVkRS?=
 =?utf-8?B?REtMTG9vMCtmTVgvcjhORTc4TWEranRNcXJ6VlE0WlMzc2FRdUQrcEpIQkQ1?=
 =?utf-8?B?c1Y5eVh0NVUvNHRnTTVFVXVkV21sTHI0K0swZTExVlA3Yjl6OEx0VHFaVmF4?=
 =?utf-8?B?Kyt5aWVWNE8zWW1Xd1F0OGZwQkN0YUV2ckJNaEY0TVVVbkJqWFhVTVdMVno5?=
 =?utf-8?B?Vlh5M2o3eHhIRVd6WmZlQWs4ekMwWXFoeVFQZERqL2hZSC9wWmYzc01UcllZ?=
 =?utf-8?B?RE9xaHJFa2Uxa1czeSt3bHFWTG1IajVoaHBXemppdFRVdmgzUmEyWTJwTzI2?=
 =?utf-8?B?RjU5MlI0MHJNK0EzaFd3Q0t6YWdGaERMK3A1RmpRMkl2WlNyQTRPV2k3cVU0?=
 =?utf-8?B?WHdjUFBYVkJvOGNsd2t3M2ZieEhoWHowanZLMFJ4T29NMmNMNUNidHluMHdE?=
 =?utf-8?B?Mmg3WFo1aFRkYVlrU3F1dExkWmIycFNBMVQxQmJNOFFGcGRZY3lvQ3RvWFd4?=
 =?utf-8?B?WVdMWm45Qk4zcFd0QWczeTFyclNqZ1RUbmRGclB0SFZpeWJ3YjFsQ1RNbWcx?=
 =?utf-8?B?bnU1V29oZ24vQy9Ed1QzWCs0ekFZeXZJUWQyVXZtQTl6dzQ1RWlHYzB0Sldm?=
 =?utf-8?B?Tmg1aEltTVUwMUlwM0gyWmRFY2hjVWUzWGJPMFZhQXI5U3l4akd6Vnp0V1Ji?=
 =?utf-8?B?Mk92cTc5eVFkTkIwR1g2dzM0UjhLTmNMSENRWnFrMmsybjFxZElGVnd3M3lw?=
 =?utf-8?B?cnVjcHR6TVlBQ3BmODArbkhXdG9xZi9hSFk2TUljTmxwcEtKbjY1T0VhWDFw?=
 =?utf-8?B?RlhsVk1hSkdIUVErUlRlLzdhY3p4WmJhOFpNZkZvYTFnWTdqa2JuMlhGNWts?=
 =?utf-8?B?QWU1YnRDZGJ5Vm9ja2JjanArM0IwcHdveVJ6eHRsdmFpZmxyM1BkSzJScVVC?=
 =?utf-8?B?SWg4REo5VSt5SENESGMxcTNEdFlwcFo3aXFHNjdHcWNDYVpTcmNLWWl4VUQv?=
 =?utf-8?B?YW1iRmFxYkd6a1lOVzJIdFVGVC9pMlJ3M3YzMlA4YzBHY1BkS0xLSjdKaEVR?=
 =?utf-8?B?bUJ1V0ZlcEVKTCtrSVVOeVYyWkpjbFFvenFIdUFlTmFlR1lRSE80SEhPWlY2?=
 =?utf-8?B?cUNtNUhWK2NsYXhubmJ2OHZxQVI4czlvV3VDUXNGYzhmdEY4SGRibzA1NUF3?=
 =?utf-8?B?dWhwZC83WDRxbitFMEp4RWU3MFRSWEpmTm54Z1A2NmVjK0JrMnM1Y0FSSHkz?=
 =?utf-8?B?VFVKMkJkSDE0VDBaVnZMclZlYjUyT3dBUGRVOUlQekxOMUlUdExVZTRSK3Ev?=
 =?utf-8?B?aDBxc3k4WlRrcEIzU0JDeFpvaG8zeENnVi9mVVRMTnhMN0hMZkZnWnFaNjdX?=
 =?utf-8?B?dUpJaVgzVHdPY3hFZHdVVU5WdkdJSnl5c1Z0SDFtQUFmaHRJeEk3Yi8xZWls?=
 =?utf-8?B?b1FrNnBhTjdnSGZsdUd2WkdVNEMwNURjWmR6WkJBaGI2WVNhcTVXTUdXOFor?=
 =?utf-8?B?VUVHSWxqWUdKN3ZrS0VtWStSbG1Qb0ZxelFaVmV1UHZpQ2dzUlJCUlVYcjI1?=
 =?utf-8?B?ekJEbC9McDI0OVhMU2doS2dCZmVEaGFBS21sYjBnd3BRUFZ6T21nMDhZVHp6?=
 =?utf-8?B?YXprZm80WjZvMXk0aytoT1ZzZGtjbk5hazNhTWtNVE5FUzBkclNTTjdndExV?=
 =?utf-8?B?dVpibmd5RDNoUDZXNmlTK1RMTklHSHVnTDRqMUpET2NTSHJhRFMza0NpclZU?=
 =?utf-8?B?WTNPV3FaM1pUYzBqSGFxSTErMngwV1RwV3pVbG9qOEtCRzBIUUFqTkJPYTVq?=
 =?utf-8?B?VXlPbm9XUGpSRlVGR1R5RTZjT2xFVXNISkkxTFN1c25ZWFdicDlUQU9xSW5t?=
 =?utf-8?B?alo1MXRmbmNkcXYwd3B4ZzVMNncxUUpyNnFrY245aWV1bnhiTVJpT09idm1t?=
 =?utf-8?Q?BwASofdLOl7g/TPxl6p221/cTQU3Ly+UZaiGUIhtIvngG?=
X-MS-Exchange-AntiSpam-MessageData-1: BJtS2zp8CQkdSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75ed87b-9dc2-4376-156f-08da10bcf172
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:14:51.8903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPwsFWoebnEUwOhPf/yHrU1WHY2giaVQb18g7SsKAlA2ktIpmlxw8QvDBsUvFNkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.03.22 um 15:06 schrieb Philip Yang:
> Flush TLB needs wait for GPU update fence done. MMU notify callback to
> unmap range from GPUs uses unlocked GPU page table update, so add tlb_cb
> to unlocked update fence to increase vm->tlb_seq.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 48f326609976..683b08f756ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -927,7 +927,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   
>   	r = vm->update_funcs->commit(&params, fence);
>   
> -	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
> +	if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {
>   		tlb_cb->vm = vm;
>   		if (!fence || !*fence ||
>   		    dma_fence_add_callback(*fence, &tlb_cb->cb,

