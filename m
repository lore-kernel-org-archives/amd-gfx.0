Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC67EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 06:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEAD10E1E2;
	Mon, 21 Aug 2023 06:36:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C670A10E1E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 06:36:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI0scWBvmWP/C2dCBu8yE9nUIegXcbAYGyptH3j4G5etPgrEjSDTe90lfKA+HYgHOYbWRjof0A6/0vit3+hmgseYy87/x0GFDDALAIq6K3NxbsNNdh9wZmbIrpyZj2UbdihQSOXwt0X8Sde1xZz+h62LXO1mqW/rInTMKdY2Y1Yg8wX2nBoO2NvbhTaq7LHmzHIbM/zUGHsTSZfzMag5/HNZl2E1YNLCabRFKOpn5FyvJ5aOqU4O8JjnKY5rCtDhSlNurSzmgX4mH5s6GtcP+TQ1gq0E06vMoBzRLfj4wfQqiHSxQdQYFnKU9hFJSvGntTwd5fiOu5RFeNAYNSxdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STM5BS8HwoQ6rYkeFec/Eaglzf+yfL2mmUHAdjdlXCY=;
 b=cgQfd9SC4DeQ05WduvNvr7AYsLtYmuk2EWFCiPQtezYXdJ41GrBQs+JXSaMUm4KoV5VSCfMMzeH6VgKTnMqobnD0205dY1mOb9ZP5JusdQD+czn2ojvBYyST32n2T2sPeOvcenJxaIvYeYs7+r1s8oLkJJIun4bHZMQIAF9tgEl8a2oOfQU+PWpzqVevV1ZOiWtQbQasKGD7hcYLWolRPUT652Aqeum+YHrFr9SFkXLlDy6HF0BzoTQgfpSciVyYEPCzKjDFJkCPwQCvoDdWvKHE0nT4lIK4P0CqbgG9pMyFpgP6TYipLBis0Q2/3JULAVvnpeJPBH3idj2vNUrQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STM5BS8HwoQ6rYkeFec/Eaglzf+yfL2mmUHAdjdlXCY=;
 b=dmkRE0Pn7EXhzFi0Lkjzu2/95VwNzco8HDHuCTYdcodgoZs8c3gT0x0Bj8oXDMxUv+x1tGWR0WX+c/k89qPePBRClEA79lMsQvJKJ13mK8swjt2T+vJT5OymnuIYuVX5SeXIOc6KobpMLDkIcEe+tHpgO+gpqjQgfdYzwdx8rsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 06:36:15 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 06:36:15 +0000
Message-ID: <4390e727-fd8f-40a6-aa46-1216e4ed02d0@amd.com>
Date: Mon, 21 Aug 2023 12:06:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fixes incorrect type in
 'amdgpu_hwmon_show_power_avg() & _input()'
Content-Language: en-GB
To: "Kamal, Asad" <Asad.Kamal@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
References: <20230821060556.937890-1-srinivasan.shanmugam@amd.com>
 <DS7PR12MB6071B741DB5AC800FEC35FCD8E1EA@DS7PR12MB6071.namprd12.prod.outlook.com>
From: "SHANMUGAM, SRINIVASAN" <srishanm@amd.com>
In-Reply-To: <DS7PR12MB6071B741DB5AC800FEC35FCD8E1EA@DS7PR12MB6071.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::10) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 47215a80-4340-4096-79d7-08dba210eadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzAHemzA9igWLZRTnCYXOeDfcYNTGGv6OsLHW2jHBu9dsisVGWqPTJLWS4tO+mqvRK9UZrYhUoVrCEzcyx7OYyfE/NZyU5AnPzVd4MGtaPvJfj3wS+McI3x70TQ5oGo7DfEUKavJVb8vSFuWwEuPOTyVLm4J8CQ1hsp10CX7XqHv+vKL9g+Jiga+4YZ5f1SZRf/ZBrpG2NreA0cBmOy+4x5JWRGC13h8UOIy/fZ61YPr4gnje5Mt/o3DttKWoP5D8E6R73OyVgsORLG9ClDAIwYjiz7yZG3dm49JPoqueInKLSsbrscZIEUCQAyDGit4i4W/xeJFK6INBGH3ROIrCcjxxo9oWuW09GCfQq/SN3aONATE4Qz9t+qddy5+tX//UhL/wnDzscOrhwtQmj9i8p7oe5NAuFoOpfYrJfnO5tIz/yJ0W9ywU4cxsdUXyCk2qpIWw4N7f5orYJzGYPH4JaN8G6UwX8wrmAg/MDpebR8AHcu+oVBFNftFM/dnDcr1B6s5JVrKbH6x+tUJIdaCuUVBM1gCljvTTfqVeHgxNvGinBmcgp7I4rpZzOYr8dv/iEqPzjL7EWDpYLnHhoy0fQaehbV4v3lhlu1l2C4ZpghldYGysar/4LDaZCR2NJOzy8a1I8pse6yOK2P3AFYc6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(54906003)(6636002)(66476007)(66556008)(66946007)(6512007)(316002)(110136005)(8676002)(2616005)(8936002)(4326008)(36756003)(41300700001)(921005)(478600001)(966005)(6666004)(38100700002)(55236004)(53546011)(6506007)(6486002)(66574015)(2906002)(83380400001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJLRE1mNUljcXAzYXhOakwvWExpeEZPaTBOM3FYNXBKZE1CdlQrSU1kajBT?=
 =?utf-8?B?ekNuRGtQdWtBYXkwb2VBd1l6b3RVWFB0dVh3VFNONTA1eG9tSy85cHFDQTBz?=
 =?utf-8?B?Z0daVmUwYkQzSmgwdkZhM0sxNFJYbTN4M0dDcXZjbHlYMlFsLzVZdEc3blFw?=
 =?utf-8?B?dHVDclZuVHVjQVFZdUhCQ1hHVUZKWE84VjZCaVIvVTRzdlpqUk92WEVWUW56?=
 =?utf-8?B?dVNsbkJQYlExOERVTjR0Wk4xRHFBVTVUWTRMU2RnblRWditqQmJYam5XMnM0?=
 =?utf-8?B?NHB4aVEya21DbDFzWmhPNUFVMDVNSnkrMlJ3VDltQTZoV1lVS3ovcXBzcHBn?=
 =?utf-8?B?R1doMFlUcS85RzNNeDF5c2RzMHN0aG01RkthYlNQTW80L0l3MmFhb0VQWitm?=
 =?utf-8?B?dnRVOUxXUkpUY2RncEpsRDNvMmIyT0ovYTJaUk5LdEJBTW5SUGJiK1dVUzZV?=
 =?utf-8?B?Ly90Sm05RkxaSW1tNDZPaSszSCtGU1phSG9DSWJUTDFNaTlyYXZWQjZML3Vq?=
 =?utf-8?B?Z1gya05rVENGMElrWjR2N3Nwa2Y0Wit0cDRaSkloS0M3QzVZdGNhY00zY1dI?=
 =?utf-8?B?U0JpQmNlL25uY2R5ZjFpLzQ2N0o3K3NHOXRTQ09yVWtZd3g1MklBb2lvMTgy?=
 =?utf-8?B?TEY1VkU4dDJVbEVPTGd5Q2R1UW0wRGFFZHBuMEVSQ3VaTlVQYWxTcFUxUzlZ?=
 =?utf-8?B?TjVQQWI5dFRHYy82L2xQS2VydWt2c0xvRE10T0gzdHh6WTRTN3FTQ0NIem5C?=
 =?utf-8?B?R1B1TlVDUVRGYWFuUXV3d3VJZ1VlaTdQS215eW5zM3c3WFREcTgxRERGMjA0?=
 =?utf-8?B?QTJoR3BhSXB3eUMvQUptaCtBVDQxb1dOMVl0QUdaR0dMbWtVc2pGTHRLY21i?=
 =?utf-8?B?d3JCUmY1aXZLSmZhczV0MVdqTGplQnZrV254K01wa1JBOTllRDk1S3M5c1BX?=
 =?utf-8?B?YW5uOVpXUFp0T0xNMGJlc25ja1dxSXVaR1FaTXhzMGFZZDhVOGI1MXVJQjgw?=
 =?utf-8?B?STNnc3I2NVk2bVNtVmpyNHJGeHBrK0VGQ0hxaEVYOGJEWHlLcHZIQWpOM3ZE?=
 =?utf-8?B?SjVYM2dsWGE1QWRaek1MU3pBSlpKdDBjeXBzZFhVL2JvN3BZTUpwcHJuUjc4?=
 =?utf-8?B?dmZEWVB3Ukg1TlljOVZlZTJjVzQvc2FKUlptWFZhN09rMGp3d3BsLzdLRFI4?=
 =?utf-8?B?T1UxNXV6TjFPTWREd3QzNHpTSWVHbk1zNkxuYU5wbDRrcnlyb2lIN3pMdzA0?=
 =?utf-8?B?L2h0a2FhcFViLy90YitteEdzTUxubTVTbnZEeWtna1dSNXRKUU84U1lQSkJn?=
 =?utf-8?B?VEZ2c1NOREN4QWN4ZSsrcjVDdDNKdHpTeFJYNlM2VHd5Z1Z6L1Ruby9LV3pC?=
 =?utf-8?B?YUFBNzBkTmV0dTlMWVRGYTF3NDJPdXk3TC9ObXJNY2l5Z2pITkE0RWpNc0NP?=
 =?utf-8?B?ZDhNOWJBMzdlMXpmcGF3MC9rOGRYV3RKdHFpcWJxSEYxa2VRem5mM2pXNXg1?=
 =?utf-8?B?dHZKSVNoYkRkblQzQi9ZTUNSUVFnUW5HNXVkTkZSSGxxeVRTOHhkQm0xSitl?=
 =?utf-8?B?ZWdJNnl1VFFuYXR1RmkvbHl5TEcxeE1Xdks4SlpBOFh2cW5yK0I1eFgrWldl?=
 =?utf-8?B?MHh3UzN4ZUloNDhUbDNXMnhxc085cWZGcHNnOHcwYksvRi95NW9Pd1N6WENh?=
 =?utf-8?B?YXBKSENsZDE4WDFPeElYTmxNam9acEIybjYxdEtVclJLYjVuQUUvcHU2UjZV?=
 =?utf-8?B?Wk4vb2d1L2lUOFhKV0RsUDFDZGp2aWNub0ltaVZXZU42S2ttZU90QWRFa2tP?=
 =?utf-8?B?U3NFV0x1cFpHdllnb0tNZzRJK3k2eGlab1V1V2kySEVoamVkM0RDNEkyN0Zz?=
 =?utf-8?B?Z2Noc3FEdzVFaTVpL05LajJxQVE5YVE0dzdvYWhSSUIvV3daamVQUThSbDd2?=
 =?utf-8?B?T2F3S3lBRS9CeWFtS0hBUk90bGpjQjhsaWhSbFA3c1B4UUJJVGJ6TmNMSXJn?=
 =?utf-8?B?ZXNNUlFQUUVDVmdpbWZIUzNURXFFYitEQWlMQU1LR3JjVnN3Z3dvZEpUZFA4?=
 =?utf-8?B?b0pmM3BmeGVGcmJ5eGJ6VngweUFtSG1vemdHYm1lV1FEYVB1Tm1wZGxXMUU5?=
 =?utf-8?Q?9QIC0MnhV6v4surgK/8Cx+ok7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47215a80-4340-4096-79d7-08dba210eadc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 06:36:15.0350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvKE31wxew0JkVjcT5oqDb4zOn1YF6IWjWKgt1qzTU2t43s4QvzY6WfihjKopX07uc+qZ6Mi/LuHeeowSNauhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/21/2023 11:59 AM, Kamal, Asad wrote:
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Srinivasan Shanmugam
> Sent: Monday, August 21, 2023 11:36 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Cc: Pan, Xinhui <Xinhui.Pan@amd.com>; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amd/pm: Fixes incorrect type in 'amdgpu_hwmon_show_power_avg() & _input()'
>
> The val is defined as unsigned int type, if(val<0) is invalid, hence modified its type to ssize_t
>
> Fixes the below:
>
> drivers/gpu/drm/amd/pm/amdgpu_pm.c:2800:5-8: WARNING: Unsigned expression compared with zero: val < 0
> drivers/gpu/drm/amd/pm/amdgpu_pm.c:2813:5-8: WARNING: Unsigned expression compared with zero: val < 0
>
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index f03647fa3df6..cdc28e4da0c9 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2794,26 +2794,26 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
>                                             struct device_attribute *attr,
>                                             char *buf)
>   {
> -       unsigned int val;
> +       ssize_t val;
>
>          val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_AVG_POWER);
>
> [Kamal, Asad] amdgpu_hwmon_get_power -> This is returning unsigned int value, Shall we not change return type for amdgpu_hwmon_get_power?
Thanks!, looks like there is already a fix posted here 
https://patchwork.freedesktop.org/patch/553433/?series=122640&rev=1 for 
'amdgpu_hwmon_get_power'
> if (val < 0)
>                  return val;
>
> -       return sysfs_emit(buf, "%u\n", val);
> +       return sysfs_emit(buf, "%zd\n", val);
>   }
>
>   static ssize_t amdgpu_hwmon_show_power_input(struct device *dev,
>                                               struct device_attribute *attr,
>                                               char *buf)
>   {
> -       unsigned int val;
> +       ssize_t val;
>
>          val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER);
>          if (val < 0)
>                  return val;
>
> -       return sysfs_emit(buf, "%u\n", val);
> +       return sysfs_emit(buf, "%zd\n", val);
>   }
>
>   static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
> --
> 2.25.1
>
