Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09448C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 13:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AEE210E180;
	Wed, 22 Dec 2021 13:57:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C3710E180
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 13:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CByqH8jOQKLSNiO2PaGdThyZ8O4NgIExNOnFwNW7uFnfrNSmODICdxl750Cr7IbL56v5U4MX8RYxQWeM4A/AaPC6yDPB/1WeUu3zXau3mQzHUA2r7mluGJit26GuETFlJvBvpCQOdyjjv19sJGSLbZWPhRChTQXxzsDWGCayrmSRO1QuMhJUD/4Waufnec9/qApiDtwgVgYFG36hBprVi69RsoMC3pUnPUqzNya3MYO09JKhX4ch9T9bgAVe+HuUZJH2nmuB8PI6C7iVI80Rznt0scPaNTyrA+GMurKcMdGe9CbM2DUKKv87oinDZoKgI3ahUK5xZuEmza1TPSB6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzuFkUPENUEx/yTi8p9JEcUW7aIBpAovrVD0RxqxJsg=;
 b=RnGew4yp7KEUE7lcBY1xi/lRuPpsNIVYcwwbl33te97fzvig18rGCMeGRS4vUezzzo336boJUiBF93UFtjRo2XYzUfNlC80j/9UHBCJKu3xqZxE++o03VxqDqxgcmt3LaJFlizdKHeDQZlTWVhjiQD7ubH3WqeOZ3H8Wi6YdTSb++9By4m4SgobVpP+D0kUTMbeLg567qGHNObFgsrjdNr+5QlTyVncgCcb3OTvaTkyp8Mmw7255XpUf7yCYrg0fcea3yzoDY8bVDxKFtVLTl7bJYk3DU6KNHeAT0fYqBnXm2rbSumIKPpzPLK76Z5WO9gc0tbGXxts+f6psAvXHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzuFkUPENUEx/yTi8p9JEcUW7aIBpAovrVD0RxqxJsg=;
 b=PsHlrgTfWHzLDqyGaJytDj2J7L8qucxfgnJKoJ4zPpctO3FkMphdZ1OR7BvvbdVXkaOnO8h2Kr/rGb8YyT1QmpssX8ftzwMXyEP1bjTrJYEhyHFPjThxUI3tFmwsFlH9TYJhv21HFWxe8GUBUOLB1sMUI6U4zxrjWtAeDU6AVVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 13:57:45 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 13:57:45 +0000
Message-ID: <c9c83b0e-3002-ac53-d1d6-b1f028b7a1c2@amd.com>
Date: Wed, 22 Dec 2021 19:27:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in
 SRIOV/ONEVF mode
Content-Language: en-US
To: "Nikolic, Marina" <Marina.Nikolic@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211220160834.8400-1-Marina.Nikolic@amd.com>
 <DM6PR12MB2858E316736722D6682BAAAA857B9@DM6PR12MB2858.namprd12.prod.outlook.com>
 <DM6PR12MB4300CCD940D7D651D07CBD2A8E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
 <DM6PR12MB4300DD7B8B8F194198F7D6E78E7C9@DM6PR12MB4300.namprd12.prod.outlook.com>
 <DM6PR12MB26190A8388C1E472837BC094E47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9@DM6PR12MB4300.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB43004E4DF34D166C06C9AB9A8E7D9@DM6PR12MB4300.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::29) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83926467-374d-472e-1641-08d9c55307bf
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01075A037BFDEC23CC1D2351977D9@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5wNgwsxgOwy1C5cBMvGMRUH3Q4RL9kX19q7lKrktwdYxVDoY0f0AKQvWushHTEuxkY+T4549D7vS5My9c4TdqwIIiw4QIgFG9Yv0kdB/+YyZ62/EJKXp2nA8/3x23Tsj3dm9n8jYS/WTIB3UDuZ60FJyhs0aUu9xLypS6TVGcvnJN1XWiWQOIy7rfBTK1HDG4tzlBKgvyiPPoW4+NovRQN5rFBezPSXKT1YQ+E+OAvZlm4HLozH8xdvRBG+9lXnrJj0v9GhXPqDslNApVoZxAevSraWPbX/4uwekga++BIZdsh44sLtPr+kNCn7w+AXEE3wMH9YGSxTWRAxDcn003U4Sjf7IxMZIR4l+52gnmS/4FLsFfidzkVlVAy1V7Sr7cwuQjYo/NaaWDhaKALf9ikNo4rEUQxkeNdKtpfuWwugA3ww2FbU09L5YiLB4zIPx6D0qeJuU4rDRwaMgyHMiqEy+56OMnMZKfEch6Zq5/UjeZACfpAcG2Mv/lQv/qVyrZsH4b/zzBleIrfNhFWhcj73NKzSQq3ofXINm7hCwfvHY4nQrjJjNYf6b3Qf9QEByGUslglXLKYk03QyNUApS8ApfDcQyjpVlxGTETawTD20gI8nmwS0gHnk/KuUswMOiyUug6ZkP17GyC8UxlgrKp/oKrT5hsw+XMRdAfvJ4girn8UyiDTeGqEVorMhJT1KTSiDeQglGtaf4JKfFOCXOaQ/I627MXvlJn2tLMXz94md+MPRGOO+WXXrcOGHkETt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(8936002)(86362001)(83380400001)(31696002)(36756003)(31686004)(6512007)(66946007)(508600001)(66556008)(2616005)(66476007)(6506007)(4326008)(186003)(6666004)(38100700002)(53546011)(26005)(5660300002)(316002)(110136005)(6486002)(2906002)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUlJZHFWcFZ6N3JsTVR4Z3FIRWxnT3oyZkFCd3A4ckJRVW8yczhpWjYxRGo1?=
 =?utf-8?B?QitQMUZVc21WSm9CM3hVNmduMlQ2UUFTRU9jM0FqRXovdmJlOThmbjVWSmJu?=
 =?utf-8?B?MTlIREttNUVkM2U5TnBZQVYrTHJTT090c1BGcGtubnVNNThEQkkwZWZSMjdw?=
 =?utf-8?B?TzA0dmFnVEdxSTlUVWs0N1RIcWMvR2xEZWNsa0ZvL2FmQ2ZMY0YranpJbmc4?=
 =?utf-8?B?czdVeWMrVVZ3dE9SV29jVnAzQjF0TldvenVycDJ6QVUzZFFiSEJFa1ZrenVJ?=
 =?utf-8?B?WTM2MXp1akV4amQrekxkU3hEVWhHMk5rZENwTVBSSStQTmJ6K0NtQ2JjYWpu?=
 =?utf-8?B?ZnVaejZOMnJzYmluN0RaTXlTRExUMTl0ZmgvcCtjNDBnNzRrWWNQckJubzBE?=
 =?utf-8?B?aW9rTEttRlB1NzFtZXhaUkxSUjlDajFqWW13czdqZ3hFdHJBVEZtM2VvU0Fh?=
 =?utf-8?B?MDdRMW5kYXdOcjNJdmVGRHQzcVFtcW1zMHVraENTZ2NCNzFBdTZ2REUvOEdu?=
 =?utf-8?B?eGYvY0JZeXhXeHVrVXR1R1VJN2VVbXp2dERwWnp0WVZZWWs1L1FuY0FFV05T?=
 =?utf-8?B?Ymw0THpKS2dZekhmUTltUFFsc0p5ZGx2WDdzQ0RoNUlNMzJyMUVBSEJpV2p0?=
 =?utf-8?B?K0w2ZElTK1VyYkpmdWRkRHBDUDVpNDdpc21Pdkg2ZTdyWDE3SHVVTEdPRURh?=
 =?utf-8?B?NGtMT081eEx2amt5YU9JQm9aY2I2RC9JVWlVd3V4anBIanZ4cUZTWk9EeHdz?=
 =?utf-8?B?Zzd1Z24wRFl0ZlEzM3oxYUQ5SStZVHptblFaNmlwdmROa2ZYT3dkbmNFTWk2?=
 =?utf-8?B?RlZlKzZCZGJBUjBhYjA2dHBKeU1GU25OaC9hTk1PS0dKSVA2djA2Q3d2elRv?=
 =?utf-8?B?Zzc1SGdPMEtXcVpQb2gyQXRHOEFsVG1KdEVrcHdqU3lvTGgydVJhL1RPdVg4?=
 =?utf-8?B?OXlvcE5vTWliWkhpUDZuNXEwWFZHQURabTZsbHEzMFJ6bzlTYUNJWFByV1JE?=
 =?utf-8?B?bm5tODBSdmRJeUFGeXhaMGRHUEVjYnltTUp0RlRtcWZIZTJ3RldKREphR29j?=
 =?utf-8?B?TXV5cHliV2VNZlhUUUlDcUR4TzFDOUlBb0Judk1Vd0t0ZE1qcEJmbzBrTnVR?=
 =?utf-8?B?amZOUFVsMDIyWTQxY0RrUHB1U0FJdlRoVE8yalBVTE1sMll5QjlCRm56ejVr?=
 =?utf-8?B?Z0NXSjlyNmNESGdlQ2ZvZWMwaEhVa0F3S1psTWp2VTB2RlRJRDlUWjJxbkJO?=
 =?utf-8?B?RzczQmZIRWlUMnE1TFVMSm9ENUt6RmZMUU52MGFrd3p0M2VZaStPUmFadER2?=
 =?utf-8?B?WFI1NTVXL0hXd1hUYTJXZFRMSzBnOE5KMnRiVVpWRTV6NUgxaHJDczZmaEUr?=
 =?utf-8?B?cDkwNkZaY29ZSXQvQjR0cmlnZ2dMamIweDFYaitpUmJONGxZZWY0Rnhvd3hk?=
 =?utf-8?B?OWsxbk9RZ0VJSHhoaUZ4TTlXMExFZDVyTTQ1bkNKOTJQT2VDb2tNaEJQNk9n?=
 =?utf-8?B?SGc2R21lN2xFa3lDYVU5UjFaeWVZMUp5bUxPdGFnMDh1ekk3eHZVU2VtalhE?=
 =?utf-8?B?eVhVTEtoc21OcUlpZkJISnRWZFJLd1NMb3hZZ1BzT3A5NlFFWTduaURjQnBz?=
 =?utf-8?B?WHhFdUw1bHVqeE92ekw2dkhPUERyZ2R4bk4xSk5rdnNoQVhNRFlWdlNUUTh1?=
 =?utf-8?B?MnRsaVZUODc5OXNWQWxVN3I4VE9MNlM1WkJRbmVNbExtMWlFMk80S3ozVVJq?=
 =?utf-8?B?YTUxbjNsNTBrbmduK1BkdmJZbEgvdElJZG5YWG1NZUNVbUJpZjI1cWNqZlRy?=
 =?utf-8?B?WVJmYUR2bTdOYko3RGk1SlZvajlJalBicUtCVTM5anpXRXN1Q3dYT1YzTjRy?=
 =?utf-8?B?N1VFRmRzU2RyQTlSOHh2QWZhN1hzVG1FRDF6cXBqbURMWjVBdFE5dzE4OW41?=
 =?utf-8?B?Ty8xeXJJZU5pT29HWVVPSkpaUlE0bEtNbVhPZmx0bDlmZml6NkFmU1pGdnBC?=
 =?utf-8?B?WkQ1dUlPaVBEOFN0c29KS1ZmWS9qeDIrWk94bHMrTmpwaTZKU3pVYnZXY05p?=
 =?utf-8?B?V1R0S0JKeU50ZTUyZmdwRVI0SUNNME9iNkVpSEdDZnY4RjlUNWFvQkpEOUow?=
 =?utf-8?Q?jOT0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83926467-374d-472e-1641-08d9c55307bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 13:57:45.6744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHwFu+DVm3WJIlpRs/lr5KrusDOmSoW38s8yI2teWBmxLi3dTc26YE8k8SFbADua
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
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
Cc: "Mitrovic, Milan" <Milan.Mitrovic@amd.com>, "Kitchen,
 Greg" <Greg.Kitchen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/22/2021 4:55 PM, Nikolic, Marina wrote:
> [AMD Official Use Only]
> 
> 
> [AMD Official Use Only]
> 
> 
>  From a6512c0897aa58ccac9e5483d31193d83fb590b2 Mon Sep 17 00:00:00 2001
> From: Marina Nikolic <Marina.Nikolic@amd.com>
> Date: Tue, 14 Dec 2021 20:57:53 +0800
> Subject: [PATCH] amdgpu/pm: Modify sysfs to have only read permission in
>   SRIOV/ONEVF mode
> 
Maybe change subject as "Make sysfs pm attributes as read-only for VFs"

and description like as "Setting values of pm attributes through sysfs..."

Only cosmetic changes, no need to post another one for review again.

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> == Description ==
> Setting through sysfs should not be allowed in SRIOV mode.
> These calls will not be processed by FW anyway,
> but error handling on sysfs level should be improved.
> 
> == Changes ==
> This patch prohibits performing of all set commands
> in SRIOV mode on sysfs level.
> It offers better error handling as calls that are
> not allowed will not be propagated further.
> 
> == Test ==
> Writing to any sysfs file in passthrough mode will succeed.
> Writing to any sysfs file in ONEVF mode will yield error:
> "calling process does not have sufficient permission to execute a command".
> 
> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 082539c70fd4..c43818cd02aa 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct 
> amdgpu_device *adev, struct amdgpu_device_
>                  }
>          }
> 
> +       /* setting should not be allowed from VF */
> +       if (amdgpu_sriov_vf(adev)) {
> +               dev_attr->attr.mode &= ~S_IWUGO;
> +               dev_attr->store = NULL;
> +       }
> +
>   #undef DEVICE_ATTR_IS
> 
>          return 0;
> --
> 2.20.1
> 
> 
> ------------------------------------------------------------------------
> *From:* Quan, Evan <Evan.Quan@amd.com>
> *Sent:* Wednesday, December 22, 2021 4:19 AM
> *To:* Nikolic, Marina <Marina.Nikolic@amd.com>; Russell, Kent 
> <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *Cc:* Mitrovic, Milan <Milan.Mitrovic@amd.com>; Kitchen, Greg 
> <Greg.Kitchen@amd.com>
> *Subject:* RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only 
> read premission in ONEVF mode
> 
> [AMD Official Use Only]
> 
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of * 
> Nikolic, Marina
> *Sent:* Tuesday, December 21, 2021 10:36 PM
> *To:* Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Mitrovic, Milan <Milan.Mitrovic@amd.com>; Kitchen, Greg 
> <Greg.Kitchen@amd.com>
> *Subject:* Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only 
> read premission in ONEVF mode
> 
> [AMD Official Use Only]
> 
> [AMD Official Use Only]
> 
>  From 06359f3be0c0b889519d6dd954fb11f31e9a15e0 Mon Sep 17 00:00:00 2001
> 
> From: Marina Nikolic <Marina.Nikolic@amd.com 
> <mailto:Marina.Nikolic@amd.com>>
> 
> Date: Tue, 14 Dec 2021 20:57:53 +0800
> 
> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
> 
>   permission in ONEVF mode
> 
> */[Quan, Evan] With the subject updated(remove the description about 
> pp_dpm_sclk), the patch is acked-by: Evan Quan <evan.quan@amd.com>/*
> 
> BR
> 
> Evan*//*
> 
> == Description ==
> 
> Setting through sysfs should not be allowed in SRIOV mode.
> 
> These calls will not be processed by FW anyway,
> 
> but error handling on sysfs level should be improved.
> 
> == Changes ==
> 
> This patch prohibits performing of all set commands
> 
> in SRIOV mode on sysfs level.
> 
> It offers better error handling as calls that are
> 
> not allowed will not be propagated further.
> 
> == Test ==
> 
> Writing to any sysfs file in passthrough mode will succeed.
> 
> Writing to any sysfs file in ONEVF mode will yield error:
> 
> "calling process does not have sufficient permission to execute a command".
> 
> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com 
> <mailto:Marina.Nikolic@amd.com>>
> 
> ---
> 
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
> 
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> 
> index 082539c70fd4..c43818cd02aa 100644
> 
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> 
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> 
> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct 
> amdgpu_device *adev, struct amdgpu_device_
> 
>                  }
> 
>          }
> 
> +       /* setting should not be allowed from VF */
> 
> +       if (amdgpu_sriov_vf(adev)) {
> 
> +               dev_attr->attr.mode &= ~S_IWUGO;
> 
> +               dev_attr->store = NULL;
> 
> +       }
> 
> +
> 
>   #undef DEVICE_ATTR_IS
> 
>          return 0;
> 
> --
> 
> 2.20.1
> 
> ------------------------------------------------------------------------
> 
> *From:*Nikolic, Marina <Marina.Nikolic@amd.com 
> <mailto:Marina.Nikolic@amd.com>>
> *Sent:* Tuesday, December 21, 2021 3:15 PM
> *To:* Russell, Kent <Kent.Russell@amd.com 
> <mailto:Kent.Russell@amd.com>>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Mitrovic, Milan <Milan.Mitrovic@amd.com 
> <mailto:Milan.Mitrovic@amd.com>>; Kitchen, Greg <Greg.Kitchen@amd.com 
> <mailto:Greg.Kitchen@amd.com>>
> *Subject:* Re: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only 
> read premission in ONEVF mode
> 
> Hi Kent,
> 
> Thank you for the review. Yes, I can confirm I am trying to set this for 
> every single file for SRIOV mode.
> 
> @Kitchen, Greg <mailto:Greg.Kitchen@amd.com> required this for ROCM-SMI 
> 5.0 release. In case you need it, he can provide more details.
> 
> I'm going to clarify commit message more and send a new patch.
> 
> BR,
> Marina
> 
> ------------------------------------------------------------------------
> 
> *From:*Russell, Kent <Kent.Russell@amd.com <mailto:Kent.Russell@amd.com>>
> *Sent:* Monday, December 20, 2021 8:01 PM
> *To:* Nikolic, Marina <Marina.Nikolic@amd.com 
> <mailto:Marina.Nikolic@amd.com>>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Mitrovic, Milan <Milan.Mitrovic@amd.com 
> <mailto:Milan.Mitrovic@amd.com>>; Nikolic, Marina 
> <Marina.Nikolic@amd.com <mailto:Marina.Nikolic@amd.com>>; Kitchen, Greg 
> <Greg.Kitchen@amd.com <mailto:Greg.Kitchen@amd.com>>
> *Subject:* RE: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only 
> read premission in ONEVF mode
> 
> [AMD Official Use Only]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org 
> <mailto:amd-gfx-bounces@lists.freedesktop.org>> On Behalf Of Marina Nikolic
>> Sent: Monday, December 20, 2021 11:09 AM
>> To: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Cc: Mitrovic, Milan <Milan.Mitrovic@amd.com <mailto:Milan.Mitrovic@amd.com>>; Nikolic, Marina
>> <Marina.Nikolic@amd.com <mailto:Marina.Nikolic@amd.com>>; Kitchen, Greg 
> <Greg.Kitchen@amd.com <mailto:Greg.Kitchen@amd.com>>
>> Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read premission in
>> ONEVF mode
>>
>> == Description ==
>> Due to security reasons setting through sysfs
>> should only be allowed in passthrough mode.
>> Options that are not mapped as SMU messages
>> do not have any mechanizm to distinguish between
>> passthorugh, onevf and mutivf usecase.
>> A unified approach is needed.
>>
>> == Changes ==
>> This patch introduces a new mechanizm to distinguish
>> ONEVF and PASSTHROUGH use case on sysfs level
>> and prohibit setting (writting to sysfs).
>> It also applies the new mechanizm on pp_dpm_sclk sysfs file.
>>
>> == Test ==
>> Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
>> Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
>> "calling process does not have sufficient permission to execute a command".
>> Sysfs pp_dpm_sclk will not be created in MULTIVF mode.
>>
>> Signed-off-by: Marina Nikolic <Marina.Nikolic@amd.com <mailto:Marina.Nikolic@amd.com>>
>> ---
>>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 082539c70fd4..d2b168babc7d 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -2133,6 +2133,12 @@ static int default_attr_update(struct amdgpu_device *adev,
>> struct amdgpu_device_
>>               }
>>       }
>>
>> +     /* security: setting should not be allowed from VF */
>> +     if (amdgpu_sriov_vf(adev)) {
> 
> You should be checking for pp_dpm_sclk here, for example:
>                  if (DEVICE_ATTR_IS(pp_dpm_sclk) {
> 
> Otherwise I am pretty sure you're setting this for every single file. 
> And is it only sclk? Or does it also need to affect mclk/fclk/etc? If 
> it's only sclk, the line above should help. If it's for more, then the 
> commit should try to clarify that as it's not 100% clear.
> 
>   Kent
> 
>> +             dev_attr->attr.mode &= ~S_IWUGO;
>> +             dev_attr->store = NULL;
>> +     }
>> +
>>  #undef DEVICE_ATTR_IS
>>
>>       return 0;
>> --
>> 2.20.1
> 
