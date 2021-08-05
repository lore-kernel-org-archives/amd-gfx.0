Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0163AC4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 09:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4EB60230
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 09:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A4EB60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231576E44B;
	Thu,  5 Aug 2021 09:33:01 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D08A6E44B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 09:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUCqAyt4YpEKfO4/2X9PQXA/+iheWpu0BDSztuUR7IDbtgxleM1reqbqUGJLKbPcR1nkxaWVoU5HjiR9wcgAnvZhUYLVMl4NtwoVXnj+EVN90Bls9FRfwc2LgmPO23YjAnj/j1520teRmd7ifSQvCAVjakZGFrtlDw8NLtMr37tDJ+g0QDbVyNxm/tAAx1AsCeaaWy/fFTQBWNvQvKCWE99EUfoDvUs67M344hxzFqyAjax48zYA3bF3cXyaTnP1t0o7EUcgxILTV+ndVgxiDVJrMaHy8LPNZRf4tX3Ivpsch6YbLqOq3VLLjv3S017F1jH0h2XA9/EqyvMTAZeI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvb0ki0t3/BRPD7Rr5VXUjT2zkwdDdpZUDrvDnyjOV8=;
 b=m/FfXQFDxwEzLen4y1ifLgFBtTF/4K5+7bldxcDzM0glVHHhGlqIXnGccctoftZjv6qi7SV1AYzuHnBh5P3bfsWvIATuHPLXJIW3kDIfJcSI5JbotmlXfvGnIXOwyqgP3P9JmJ5JAid8WMx3CC+kjabVLvVVn51WVLtU8fRhOEGIxYpsk2+MtFPrFctaOa/9+pWJyIXeSJ7+EaO0cNI/wKnCQJhErv65j8AkgCElBz7cTHJpunecxAZr3lHRl8d86BrxPX7uzJi/KXaFcS9tttbmjv7tbEh1IxGbhzoiLTD31lKHRnjKn7Yfvm/sk9S8rMW46R+uJUDPmhkH8k4OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvb0ki0t3/BRPD7Rr5VXUjT2zkwdDdpZUDrvDnyjOV8=;
 b=02cmZvGz/pveK0CCZ8Cv2QjBLqa7vZTG/CAjt9btKFQM4usnfBs5QwrViTovdJ2aYD3N472uG88OyAvJRZ/xOkpBX6zqpGLyoe5XosqSGmLlm22t+c64Yi0rY4l+0xmpXLlqlTMwl1do/uHykWne+IpO+tkoYjJ2kz9AYa5A20A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 5 Aug
 2021 09:32:57 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2%6]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 09:32:57 +0000
Subject: Re: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Nieto, David M" <David.Nieto@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210804075024.9407-1-Jiawei.Gu@amd.com>
 <CH0PR12MB5156021023502CABB4EAE1F8F8F19@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CH0PR12MB51564DA6D0636BE10183A79AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
 <74fa9879-6f8c-d849-b9a4-a5ddd6fe3c04@amd.com>
 <CH0PR12MB51567C449C2DEFE9DC518A1AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <21ed18de-5c93-d9fe-5b9c-e8b10596baea@amd.com>
Date: Thu, 5 Aug 2021 15:02:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CH0PR12MB51567C449C2DEFE9DC518A1AF8F29@CH0PR12MB5156.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::22) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 09:32:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de415d80-0d62-4c83-d0c9-08d957f4025a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5147E652261FF8EFBE9739FB97F29@BN9PR12MB5147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICvANnfKzHrGb8v9tmeFlwrdq3qDvNZM5z2GoJg4OBZ6YEkF5RVV1hYiGEnnDLKCYLki7bnvipjZ8I3b7y7qXEiPqt2yf4wTQ2E3fXUqxF1Ldr/K4pYto5S+InO8Xh8Dnsm5II2CjYpqSBINbFzk6As69mz0lQ4wRXGel9cItQyV82eDbLGq7ehwc/13Y6SRVCoVXHKa2qscXmSHeZ1IlAYDsikW6D+xMIXXIGSJlmsQ9UpCBKl5yRKp8arY31UcjkBu2zjQIjiRY7GKUNWwzvEQ4howlVR+hatGZfQYPoobHEOtKOBeqTeViOPtwKkwfg6sUPUxAlF0ZJOUVAfigDRINkZVIJKWClL25dshqOYnUG+p5SA/W2mCYHP2qneaD/STP87syvsvxPIYgHM04HPW0kCbYMDE6bYO66LetVMU+wd770Vx57QnR6rx/4D/ju6HaqJM4DRwOMpAHL7xflH563FYTKqmxCPCtu7bTNP3eWhfLS1dmBrBXaJzPZi6FJahYHA++GxP6M41aePkD7R04f2wIjxB3lvYIjftt9weN28ysnsctRp+4lI1FVIzyHGmbcGXBq/S3jRG8fL6cRJbkXUwReKXoMGumq3lRshsKkhqgB1UZH8O3Fex+Su16GAuDUgh06vVtV9C79uKcjGJtxJsbMt/xxxQR7qQkCnk8xbnkaVYpuvCW86IluMvY1/+kih5WQfl/TfkAuypm7srF7G3AOgf2smCIKIknA0YGfAP/JxQcGa430TmzMdE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(4326008)(316002)(26005)(86362001)(8936002)(53546011)(31686004)(5660300002)(66946007)(36756003)(83380400001)(186003)(66476007)(66556008)(16576012)(8676002)(6666004)(2616005)(956004)(6486002)(2906002)(31696002)(54906003)(110136005)(478600001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGNMblNjeWZ1RGRiakduNnJDZmZocWlDY0dOSFFYSVIwcmdxUzgybnA4WWpZ?=
 =?utf-8?B?akFRTmNEaTNxYW04R0xQTmFPTXFCN2tlUmhKamlZY3ljdEdaTjg3UWQvNE9T?=
 =?utf-8?B?UVlyM2ptd3h0ZiswNW9iMVJmNmJ0UThQRWUwanJBd0RENXBhUnpLNk5PMm0v?=
 =?utf-8?B?T3VZQVdCd2xpMkZhTmxEVUNYTzA5TEdIVXRlbThKa28yMHcrUDNXaS9oVVJ2?=
 =?utf-8?B?bS8rdXNuTTZreEU0bWlmRjRmbmtQUDNqVXQ5WkpGMVd4YmJLNWVWdThWWE0y?=
 =?utf-8?B?aVRQWEF4UG5YWWpOSllRMlVObFB1Z3JCRy9KcUdKaTZKZHU1dmppK1B4TCtL?=
 =?utf-8?B?L3FlQUFZNExWanJJZ0JsZnpEMkk1c21VMGhWeGhDa2VUL3NrS2hrLzVielJJ?=
 =?utf-8?B?NlhLT0gxY2lkVXJXc3Y1YXpwR294SnZvR2VYdGhSbXBjSFdobURLZmJKYzcy?=
 =?utf-8?B?aDJtTFhGWnk1VlN2MWRIcjZBVnhZcy9aUXN1anRRTmNROThYd3hoL1VPdGwv?=
 =?utf-8?B?MDloKzNVVG4xQWV2VUYyZlNqMG9qRjUzR1o4TmtyVEUwaGgvdEFMbE1yK0ZX?=
 =?utf-8?B?N3p1SzU1SWxzR3YySjdQZ2FaTy96Z1Q5cUx4b3RyMTBpQmFyaCtnL1pCckdY?=
 =?utf-8?B?SzFmV3pxd2ZMajV2Yml3WkdUeUFEcjdycDBoY3lMMit1QjdXT01nSjVnRjQy?=
 =?utf-8?B?QTQxZUVpMDA4RWtjQkl0Y3hkbmdINCtubTVJdXhTS0VwN2lJeXVnRnEzN20z?=
 =?utf-8?B?QlBQdVl5OWJQRmtCK2EwVXdMUWxFdlZOS0dYTGphL294UVVVUnc1dE4wOXla?=
 =?utf-8?B?SjRURmE3T3Rzd1dHcWhYYjhEZFh0SlJVbk9UM1I1ZGcranROR1RNaUlacDR5?=
 =?utf-8?B?bnN3SGhWZVh1eVRLbWRST3NqOERMeVZvMzI1bHZiR29LTHFuNUlDRjB4Yk44?=
 =?utf-8?B?UVR6SHdGMXhwL29ibXBYVS9na3g1QWxTTy9UbzlKUER6TWJOb3VyOVYwSzJt?=
 =?utf-8?B?MGVINU50MzY2Z2ptQ3J4dXNJSWpqaXpacStVUEFJNmFOTXQrTVNXUE95NTJr?=
 =?utf-8?B?YUU2emZ1NjFOa0F3L3d5eHBqMWt6TlZhdy9VWGdKekdkbFh0TXBLaUJCbEU0?=
 =?utf-8?B?eEdTQW4zZ3JMNSs0eHR3OWtNSmZFY3lZcWIzUUtkYkFGVHV5YXd5QVpVWU15?=
 =?utf-8?B?K2pEdGtqUHhTZnRxeit0c1ViRXM0ZWZTQlZjZFNLWTVtdG1XNWFSZHhQdGlH?=
 =?utf-8?B?ckVyVzc2V28vUGRkUkhOTE5DRWI4dW1FMW9UbVc0YjlKTnUrWTI2YWZRTXdY?=
 =?utf-8?B?OWlLYlN6eDdPQ2hoWFpoYkgrbTFZSlJ6RGU1OHJGaTF2V29WRW9zQ05NKzhQ?=
 =?utf-8?B?S0RoVThkTVVEUy9kdHlGZlR2M1NTN0xnL2txelhac09WQzk4dnJaMFh5VWlm?=
 =?utf-8?B?QTAzVXFlaVpRRVNLdGhKdnRjMHQyUkkrdjFiMWlSazFwZkhnMiszWExHNjdx?=
 =?utf-8?B?TWsvbzNPQVc4WlFheGl6SUVRTkxkYlVJRnNwbmUwZXBiTVB2WlhoaXBrTjA2?=
 =?utf-8?B?R1JxMGkvWDZJSHptdmhLajVvR0I3RVdFVzFxRFBEY21xYzA4Sm5ud0FpUDYv?=
 =?utf-8?B?TDExN0VZTzVKVXh1b3VHUmlnN2R1ejhXQWxlTis1enpTZFhnZ3hVL0pIZksz?=
 =?utf-8?B?aThvbVFIaGo0WjRzelRLcnJCQndWVDdrVkFqcGk3dUV4RTNIL00rMjd1VmZR?=
 =?utf-8?Q?SgStPFEhIMb/h8kDflv1TUboxqoZGl86BRqvquR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de415d80-0d62-4c83-d0c9-08d957f4025a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 09:32:57.5725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb9oDQySRA/2CY3fj1AL6j/V99n+PoFmnWk1SdsugERSKT229IN5cxgd1splSTuQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
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

Navi12 is swsmu based. Suggest you to check the implementation of below 
sys nodes and decide what you want to do. Not able to figure out how it 
worked for you, did you really try this on any 1VF system?

+	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),

Thanks,
Lijo

On 8/5/2021 2:48 PM, Gu, JiaWei (Will) wrote:
> [AMD Official Use Only]
> 
> Hi Lijo,
> 
> It's for Navi12 asic as far as I know.
> 
> Best regards,
> Jiawei
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, August 5, 2021 5:08 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
> 
> 
> 
> On 8/5/2021 12:01 PM, Gu, JiaWei (Will) wrote:
>> [AMD Official Use Only]
>>
>> Ping.
>>
>> -----Original Message-----
>> From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>> Sent: Wednesday, August 4, 2021 4:08 PM
>> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily
>> <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF
>> mode
>>
>> [AMD Official Use Only]
>>
>> Add Alex.
>>
>> -----Original Message-----
>> From: Jiawei Gu <Jiawei.Gu@amd.com>
>> Sent: Wednesday, August 4, 2021 3:50 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Nieto, David M <David.Nieto@amd.com>; Deng, Emily
>> <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
>> Subject: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF
>> mode
>>
>> Enable pp_num_states, pp_cur_state, pp_force_state, pp_table sysfs under SRIOV 1-VF scenario.
>>
>> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 769f58d5ae1a..04c7d82f8b89 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -2005,10 +2005,10 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_  static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>>    	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>>    	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>> -	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
>> -	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
>> -	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
>> -	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
> 
>> +	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>> +	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>> +	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> 
> Which ASIC is this for? As far as I see from the current implementation, power state is not supported in swsmu projects.
> 
> Thanks,
> Lijo
> 
>> +	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF) >   	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,			
> ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>>    	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>>    	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>> --
>> 2.17.1
>>
