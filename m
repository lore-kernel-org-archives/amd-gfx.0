Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F177BCD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 11:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4B710ED0F;
	Mon,  1 Apr 2024 11:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rgBH4G0/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C8310E54C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 11:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIprlaE9ixii9kCL/EcWd2xbac+Bl9SBhRAQjjhPBKq/HaZTkpeKGoChHztLvTuwZItJ+OzJRlT8ax83/xwTIqG3V6tGUgtbSulKOaAR4TVgJeo1d4hMwGC+GvVD/QsepsEOufRFhWLdangB5KmanJnWg4QbgLwLICsxODLNHhqSmCc37nl16nDhT2KVLwfEAgP2ryXWDAQX7Em0hFJ9kT0e/sXlZmydHnpAhzmJm0fH/2FnWWL50QC4Ru6Agq48pGvTWsvbY/0axk6FAXR8OGf5gmirvWQ9uq/zf4BCL074w8N3da2RZntX/sWHtATCIYNllktXIgKIMX5q0SlL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHajcxTTlMTx1vBQu3JaMCAP8mQr2UhMn6hbiXyBTGk=;
 b=R5wb/0FnsPouPEBOFwXvk3LB4NZ0BUOABxGQEyxweQA9KRemecgibyqVAmHRmTX80sumZgLDekzcEiA+Dl5PtUpRXkb2uOOSTF0ixoDP9OO0A4HHeyPeSBAl12P9CPaOdeOTPC3goqN7Ocatvl5Sy0DTfMRG8JGAXrXF7q/YNt2jsJUr2HBwrqeA9yPWR9kxx+K7+VxnJAOk0Y0Yvy2SLEZz8vLaS3ftMqkVMSIjiYRpFGwncJvvpJweJOJrI/7ML0Y50Pq9XVTYRNnMnmEFEpeLPH/fftkso+OGJKylUAOToFV4QgFG81TAat55uSE9rtjJF0IGBhdLXffqN1vZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHajcxTTlMTx1vBQu3JaMCAP8mQr2UhMn6hbiXyBTGk=;
 b=rgBH4G0/vjsGD8DN33v2sul5oOo6GCgYwj/pXx0kw0bSZ1IAsIHNWpt+6DgVY75uHbdozhjkYFo3eHtUcvRl0aWydJ6hMXtgiSoW+oN/Pr7wHwlkTqIoBqzXsUB5q6M4shGVCc+UFfzIZ8JNjuNWUCp+dEay2edivngApi+e8kw=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 11:20:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 11:20:51 +0000
Message-ID: <73aaf33f-40c0-46c2-99bc-584de7ef5176@amd.com>
Date: Mon, 1 Apr 2024 16:50:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
To: "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
 <20240328023544.820248-2-lijo.lazar@amd.com>
 <DS7PR12MB6071B627E5616FA8C073302B8E3F2@DS7PR12MB6071.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB6071B627E5616FA8C073302B8E3F2@DS7PR12MB6071.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7797:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5k3qAs0N5BlhgADPXAnn88KLSEA0rG0YvT4VRmSXjiTWUbqMpDMOYE6X9tqFoo4c/vwkPjxLzY4xVr9MLPH+QNgMdBlQugZgyDDsWl2D/r5A3ugpHTY1tU0PAuEPSH55fYjdTgJPhOoUx3QNlOSAfuBwhKyqpKLtI891XemX7SEgNUcRSjdtFFfBtBjuxu7nsz7ojpeyX3NHf2zgaAyjj28hX3dxusoC6XQsS9ZPqGPBQWuN85oUXcyKbD1HCjrXDUQvfB68V37nJCASJB+tsWKHMQJLTbRinZeOk2VdC3M/NO609VMQl+fCEVrvACNk1P+JC6Hg0+/v2o595Zq+DSy1/x2nYJuQwNmzNIGZgsWE/vlqrIDuqsmWfXyiFrJ6rIkyULnoVQlwEiw09M9axmHN9tk5GM9K7KS14zFEi9BA2Dw8lnx4n6AOi0F1gDd1zGp/t+xTo09MkdALmtaOxz0gyepESiwjf2bB5e1ctIUSsXLrQIfKRXSZ2ssVYeLPftm9MIa1Bfw9O74n545Kg609p4n5/fG82d3bT9/RAIUXNT1bFwt/SieymLLNzSJJSdhQI+v41ayVATwDcPP2YGPE4lE8uFIexrp+1uqF5y6I/qoxCYMLmE4/NrIh/OB82uZDcNx7u2Spj4NoEksdyNXUOr8jGJZ7GZzCCfOq548=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG1YUk5IYjRYZ0xLZk5EYjJmcm9HTDdCNFlFOHRVUTFYMFl5Ynl2K05EYW5Q?=
 =?utf-8?B?OXpmaVduLzlmVll2REFSVGdKSDZaMTh1dXZDN2c0cGNtQjQzODdJR3g1UXBM?=
 =?utf-8?B?UFFEc2F5QkdEV0JaS2Q0cUVMWVFGTEw2MGhqczV2cHpUS1FXUnJkMFpORGtn?=
 =?utf-8?B?a052SjdEY0RmMzNIQ0RqdHFUQ3ZsU2VjeHpLNk9MaXl1WlU4YmZFbmpwb2lt?=
 =?utf-8?B?WEZob2FrU25xZDNTVXFaaEQzSE1JbWlQVHRMQ281NUVrSGlpZ2JuSnloTlQr?=
 =?utf-8?B?K09KNGpkbk42YU43ejZ1SHpQQWFrVGJSMnFGWm90N0krNWg1R1pYU2huQWpB?=
 =?utf-8?B?d0FkUG1EbVAzSjFnUkl0SXdVZjR6UlpocDlmSDA1Y1FpZkM0bGhRWVp3N3Jz?=
 =?utf-8?B?T00xZmVZVXJGNmxSMDIxQmFZcTZQWE5QMWdhdFRkaWlJT0UvUFdXNE5CRW1n?=
 =?utf-8?B?eU5RQ20rb3JDcjNxUmtqWFI1UitwaTY1Vzl1OHRzK0hwTDNhMW0yTmQrWk5M?=
 =?utf-8?B?cktBREZibkFKeDh6b3ZyVG9nQmVpVnVZMnR0V0NUcWhqQzZhWjlwZ0NjME9L?=
 =?utf-8?B?SzE5YUdxaWNNL3ZCdEVQN1FiZ2FUZ2N3WFBOdXkrcDJxNjYxcFdVSHdpdWdw?=
 =?utf-8?B?M3dyVWo4bld4a2xONElHTllMVFNoc1VTd1Iwa0FJRDluU0xoMUo2RFcrMlh6?=
 =?utf-8?B?ZnBieGNzd1ZoOGx2aUxBNHZlQVdaZmF0cDBFRWpoR2hoQllQc09mSXpJRHVr?=
 =?utf-8?B?Rjh4dUh1anpBekVzeUFEa1diWFB0b3BjQ0JIUThlM2tHMW92N2x1bDdsSEhD?=
 =?utf-8?B?elV4SXJSOEZCTW9kVnRaWGhDckpoZEROM05BWENMdUQ0Y1ZyZllDeGxiM3pY?=
 =?utf-8?B?RE4xMlJhRVhnSy90NG1hZ24yVURwcVo2ckhQWDF0cmp1TFJVaXZ1VGJYVTF2?=
 =?utf-8?B?Nk8zeitBaGVaNmd5NXV6M0UvL0ZBYmQwN2ExendkUUhCd2tqVldFTVdCazBl?=
 =?utf-8?B?NnM0aDJNNFVhZmFkTDlVV2FCMmhob3lpZSsxcWFSYllqT3hTa2M2bG1WVzJK?=
 =?utf-8?B?WVZ0cjBYdzV2c1VOeW9YT0J0Ym5taS9MN3NML01CdnhuNGlvTllwNGNVNElE?=
 =?utf-8?B?dkRSM0VIaHNwVHF5Z1Z4RHJiWUV5L28zRG9vK3BDbWZDbU9KZmJnREZVS3Zw?=
 =?utf-8?B?RFJyWG9RL0NpY0FOVEwraHJqWmUyUzI2cFFQUzF1b0x3RWx4NkZkZ1Y0SXhw?=
 =?utf-8?B?Qyt0akwxV1B0VWJ6OHBXRzhyU3JNNjNsM0xRdkhYcXV4aWlWWGZ1Y1l6WXNC?=
 =?utf-8?B?b05taVdUMG9tVjM5RHFiUFQ2bndncFd4MXdBbmhwcGZtelR3TnZwTWpVczZp?=
 =?utf-8?B?c0Q5Zy9kSzRIcndOTGREbFBiYnlnZHJ5b3NhNWN3bTZPSW8zODJzWGdkLy9r?=
 =?utf-8?B?L0pIa2Q5NjFrcTZIKzc4aHB4M0tTME5VMVRZVFpER2Y1dloxQ3N2ZWZ4Vm5G?=
 =?utf-8?B?L2lVdHRVYnV0dHRaN09RdFZqNnYrZm9GU1gyVnpTc09vdWVqcVhjQVJvY0tX?=
 =?utf-8?B?Y01EUENHd2RIdWtveXZhT1E4QUh0MjByclh3Q2I3bG9ma2pibG95K0YwSDVZ?=
 =?utf-8?B?MG9NZGhHTGJDY3BOeXQzUWVsaVhtckM2bnQrQ1UvaHJjNE52Y2hobU1WRUxJ?=
 =?utf-8?B?MTRxWXEraDBHeXFLMkF2NSt4Qmo5Ri9PblBxUSttbm9BUkJ0eXczQTRIUWUr?=
 =?utf-8?B?UldTK0JEcHUvdUc5a2dZLy9OSjhTMVVhWVBLUVI4TlpkYkJwaTNMSmJWclND?=
 =?utf-8?B?S3ozZURHYURpM1pYMEw1RWVNdnN0OGJGZ2NhTnA1VWloK1dFV1dRS1JzUEtp?=
 =?utf-8?B?UStzNFo2MXVKMDRFUmVvQzc3bEFWNnRFOVBzTkNZUEhoWEJyWjdoUkRtZklp?=
 =?utf-8?B?YXBmYXJHMFJRbVVRNzkwTlZQVHNibksrcElxQWh2SmlyTHgzaWRoM1diZ0xn?=
 =?utf-8?B?NTk3V0h1Tm52L1NCeE5YZG00cG9GUU12VDgrTHphWFFCcXR2KzNFelI0MERn?=
 =?utf-8?B?U1F1dkxFY0JsMktiKzVONVBiZnlWRXVGZGRJb3FhMHpwMjV6YXd0bm9tcWZx?=
 =?utf-8?Q?ROSaIlKl1JOG3JZCe2pFbcZAD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f35820-a6f3-4c3d-762e-08dc523dc993
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 11:20:51.2066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlc30aFzzehnvMIzpSGNPAzUzn73ThUJSwGrTGGi5hm2EzCmsrC4Ugk6o8FXyl0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
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



On 4/1/2024 4:45 PM, Kamal, Asad wrote:
> [AMD Official Use Only - General]
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Thursday, March 28, 2024 8:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
> 
> Add flags to categorize messages and PMFW capabilities.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 3 ++-  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  | 7 +++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 2 +-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index a870bdd49a4e..aa835df7ba1a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -458,7 +458,7 @@ struct smu_umd_pstate_table {  struct cmn2asic_msg_mapping {
>         int     valid_mapping;
>         int     map_to;
> -       int     valid_in_vf;
> +       uint32_t flags;
>  };
> 
> [Kamal, Asad] Do we need to change the following macro , to have flags rather than valid_in_vf
> #define MSG_MAP(msg, index, valid_in_vf) \
>         [SMU_MSG_##msg] = {1, (index), (valid_in_vf)}
> 

Yes, will rename this to flags before submitting.

Thanks,
Lijo

> Thanks & Regards
> Asad
> 
>  struct cmn2asic_mapping {
> @@ -538,6 +538,7 @@ struct smu_context {
>         uint32_t smc_driver_if_version;
>         uint32_t smc_fw_if_version;
>         uint32_t smc_fw_version;
> +       uint32_t smc_fw_caps;
> 
>         bool uploading_custom_pp_table;
>         bool dc_controlled_by_gpio;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index af427cc7dbb8..c48214e3dc8e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -445,4 +445,11 @@ enum smu_feature_mask {
>         SMU_FEATURE_COUNT,
>  };
> 
> +/* Message category flags */
> +#define SMU_MSG_VF_FLAG                        (1U << 0)
> +#define SMU_MSG_RAS_PRI                        (1U << 1)
> +
> +/* Firmware capability flags */
> +#define SMU_FW_CAP_RAS_PRI             (1U << 0)
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b8dbd4e25348..3227e514e8ae 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -437,7 +437,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>                         return -EINVAL;
> 
>                 if (amdgpu_sriov_vf(smu->adev) &&
> -                   !msg_mapping.valid_in_vf)
> +                   !(msg_mapping.flags & SMU_MSG_VF_FLAG))
>                         return -EACCES;
> 
>                 return msg_mapping.map_to;
> --
> 2.25.1
> 
