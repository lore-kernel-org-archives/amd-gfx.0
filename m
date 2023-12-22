Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54A7C41535
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 08:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F9910E751;
	Fri, 22 Dec 2023 08:51:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572F110E751
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 08:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG9mlFyZr28o2UxO1RwkXIqsvVTCwb4kTduoAkgrAFjnazasswhOX7dENHD1TuLDwNnnv59N8ceZykvPbLuE1M5zW7HMnljKIKaZoCoPJIPWLrrIFPEob/256yLcaMLIXM6j2vq8uCe525WcSRMKWO00QKIMYZrataBJx5b9r3BAVJbNNSo9/6L5bnqKwyqIVO5pCTWH/Og37e/fQVZP5F97g7/9sPO4+RO6QwwnHGaMxtbREINnMAB0yT0h34DdynFyaYRKRXfGtwb2W5i4AVYNGo9/3rwTTx5HDaTosJ+zZwU1eZ8xFY3dhsUDL9Hj0mpO2oKzdtp2/oLp+E9McA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ8e5IFQpBFlK/giIRuEKM/WsIENfDZpOZuBg9lOpQE=;
 b=IAZL8OV4uHd/7cIHYL2409P85FToU8sgVChS53gS0GNE2bdSDApOcp6djyt8hFxnIUVngjMFgjqUzVStv250fGKuHgeXJa1y61TwmNykllQBMEWCHoliMDGHvrYJPmaK1xAp4yxTgXIqrUnprDnuxyICgtKAkn4VLyLnlxP6IGNB1hxqTZanYMoyl12YMzOiGT73fxvJOwnP5XFCVkDZzco4NeCoqI/mt/K5gEb/ubGoFmyH4YPS22EKGacgP1f5HcnWyt84yrG/zw2ZDJ4UACCVhoesQnJGrS+d9om7Kd5kYstJx33hO7xWUFt5Qj+ak4Qfa17sJG1FgpcSxo2MGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ8e5IFQpBFlK/giIRuEKM/WsIENfDZpOZuBg9lOpQE=;
 b=Nw6Tt9F8rOBt1CnuMYnxpfdgN1ONyHdWemCWbVOs6sCuc961gM201+pkiv+uv1cTOHTJwJDayr890YWf3IPuKJ3RgRUTEgyzr7WjHLIQZE5IiuWz9tbLxVRZttgxODUPixnE+V2+8qIp5sEaMsJg6x/HCTc9xwiA31LIj0X8EWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 08:51:00 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 08:50:59 +0000
Message-ID: <0bd65f63-5c1e-4eb6-b8d3-046a19221c19@amd.com>
Date: Fri, 22 Dec 2023 14:20:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Confirm list is non-empty before utilizing
 list_first_entry in kfd_topology.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20231222041453.1568945-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231222041453.1568945-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: a27745de-0539-4294-9c05-08dc02cb1e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 364855CqWgWoTyXmLV4Kt0eERVKjr3Ds+O8ITLvahC8qazxtBVCxpftgtkV498IlcWTASVOboWpDMMwkeLzYc9chleqJKJRNpLuMsIn48wcLbqBBqCxjaxLGoIK6V4I9UHIshZ12ftYb8sBZb8uN8Tpu8iMRzB3NN/u+slL/7znDv4fmpB+gJSIitO3wcsCKt5PycKMVyEOZ3aLGMLYyZtdsMKVp+L94O15hT3YmK0pJe+jWnGJOTQAGLWvlMaJ8QHHBM6lsdJdJy4U3s6DfB8rTIJ14RiN4Hk6w6dpBxcJ9sgQ5MSrXkQ8+RlRQ6QBFblO+Vd/MgQo84ZmFjLIDfYzJiHs67wjLW3Q+inCfLoNmSXNexW4YczgaAUMg6BsiDq5iqhBiU+xCLBp0y2s9hUERZ1LvruqYDbz2o90d0hyfqDhcGtrVTPAz8J5roR8npQnBUF7DTzyL8AQxVdW1mfugZ7hpw+440jjb/ZSR0lxu+B7Q7KTrHsrNTn1CucBpqeKyL5OXrjyWsDMp37VNVLimnLNMucV+C4raMn/NCNnphlaZU+mPut/bgBKtnq4+5q4+dWCxTjMFslj/trqUvqBFWcw5aAGCzuq1RRCmusnBXNr5boigxNa5CFLMQH7r5KuzZ+CLXAkiLyDZVa2LnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(8676002)(4326008)(66556008)(66946007)(66476007)(6636002)(110136005)(316002)(2906002)(41300700001)(86362001)(31696002)(36756003)(38100700002)(5660300002)(6666004)(478600001)(6506007)(6512007)(53546011)(26005)(83380400001)(2616005)(31686004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFJYSnZYT1NENER0V1JrZEh5Vy9Gck9rZk94bEhTaW9lZmluVDZxNXNOekpP?=
 =?utf-8?B?Ylp4b2QreENRUzR6YkFiV01ncy9JVXd0RXhpbklaa01JUWxQdnBiWjFDYjFy?=
 =?utf-8?B?V0s2QWF4WXNxWXFacmhJcmZVMmhsdi94L3JkM292V3VGQjlqdEJyeHhxTStL?=
 =?utf-8?B?cWozbVdDNWVSM3pRaDdZWUlBMmNQZ2pRL0pHaS9wcHpiLy9yUDU5ZFZhZ2wv?=
 =?utf-8?B?aFdQN3o2UGtzRGszcTlFdkdobmwyeENLRFpMWkNvdE1HNjdQeHdJa25ZZnpm?=
 =?utf-8?B?WTgxOGNWUkM4Mno5UGUzRzJNOVNDc0prbDdHdUlSSFVKZ2VZZ1NqOEc0OGJS?=
 =?utf-8?B?WGF5UzRJbEpnNkU3WHo5WlVNWEhHcHk5MXFoVHVvRmpEc1lxSG10T3lhTExr?=
 =?utf-8?B?NEY5NURzN01oaEZnbFF6Z3EvYXBIT3JYUUtBNFBTZmh0M2UrR1hJQWNVeERK?=
 =?utf-8?B?TVd5TlNkNFNzd3NhbW5KQ3ZkaExRbDkyRjhLWGg0cDQwdnlCUm0xdU8yT1R4?=
 =?utf-8?B?Mit3VlRucnRPR0N6Ny9lTDhwMFh5SGpqcDVRVlkxSUEyN29uaXFTK0RFOVZB?=
 =?utf-8?B?K0xOeGtkcVNkYTZTaDNzS25vR0lVQjQzOGdCQjN1QStDTTJIMVNuTW1PTmE4?=
 =?utf-8?B?cVVTOWtZZUUvM3VaTVpYOUtGNzQ3UlUwalJlNkh4RFViUUZGSlZqZldQNTE5?=
 =?utf-8?B?RENyQ3ZBUnRBZ3dUNXhzaXlHZG41b3NnOWZtRDBMMG9vbVQ2VDFYYngrVlR6?=
 =?utf-8?B?U2pXeG9sMld3QXdod01meXo1MEdJcFlxYVRqY1ZYMHpBZDh3SzNHdC94ckRS?=
 =?utf-8?B?TlMxSEk5ZStSNFVCNnVKYnN1SUUyZnNWK21Hb1ErWk43OUIwa0NsQ3EyS3JR?=
 =?utf-8?B?MHk4enhob3RZRTlONytycW5UdUZXQTl1OUIyRDlPaGVwSmMwUlEzYUYxc2VL?=
 =?utf-8?B?bTRZVk9oR0tSc0trQWJSSCsyTkNMUy9qR3ErY2JDT0g5d2VUMVRLSnd6Qi80?=
 =?utf-8?B?VXVQdGUreEljZVlQOGI1TjZ2RTRqTVNkY1JLUXdibjk3VGREaFlBcWp1NFFE?=
 =?utf-8?B?ZnVrRmtKMUlzSXN4UVJJRi9Ca3RFSm8xZUY5V20reXNENjAvREE0N3JDWVVQ?=
 =?utf-8?B?QisxV3ExL1Foa21IcXVVcmgydGs4Vmw1UGNaMndqUWlKUlJMMlhmMTJuakJU?=
 =?utf-8?B?MXp4N21aNlRDb0JrMU8wTXNBditrRStkOW5tSC9UbDg0OW5nWlB2ckFtakNh?=
 =?utf-8?B?NDhqTVRLLzJLZWFTUE5vSmZsVXBZQng3WlJBcDlvTjZjMitzU1pQdDJLYW9n?=
 =?utf-8?B?UG1RRWJoajFjb0x2UjB0TWcwRndFSFE3SGlHV1JRYlV3L2N0QWlpSWhYaU1M?=
 =?utf-8?B?dE1yTE5aUGlicUFWb3RTOXNhcEVwRytrWXBISm0rZDM0aFhVS21yNUkrNldX?=
 =?utf-8?B?blpJbEdrdGJHOVBIZGdoYTcrd3Z5K0NGNUFBZ1BFS1NneWIvRHZMVmdyTFVD?=
 =?utf-8?B?TVhLWHRZMWpvZEhpUHRQcThDdkdYcS9JQ2dqczBEVWFyemZaNGUwOWZqQmNL?=
 =?utf-8?B?Z0NsM1dxTlN1NkJ4NFY0N0xSUFQwVytBcmRoWWdvRDYyelBpM2prU2NFRkM0?=
 =?utf-8?B?V0NiWWx0S04wVUxmQzEzSGhZdjZzUjJDT1VtaE5JSEVZZUp4MDBSUVU3TEp2?=
 =?utf-8?B?R2VjZTg4aHZhZStSVTgvcWhibjA0VFRkRjFpaHQyKzZyRjZVM1orVEh2clA4?=
 =?utf-8?B?NkFmVDJxKzdnWU43QTFheDlJU3RrV3FDS0M2aW94VFpGKzFHOStOeGhRcXRL?=
 =?utf-8?B?Q3V5TTBSa3ZHTml4RXF1Mlh3OXZTQ3pFRzNkd2EyRTVWZEo3YnB5eGt6TFQ2?=
 =?utf-8?B?ZjJZaWFJdDZFMHpEN3FxWDkrVUFCS2V6REhUUENFT2N3Y1I1SGMxNWtBSnNP?=
 =?utf-8?B?cG9qRU42V2F1THhtT3ZBUGpyOFEyUFJmd3M0TGQ0RFYwWFVXVGd4L1k3QTJi?=
 =?utf-8?B?Z1krMUI2NGNCajhkSVJIbXErNE9tNVpzbVpLZTdDNDI4RDl4ODRqVVhwMUJj?=
 =?utf-8?B?ZkJ3SWpoRzdveXRlY3ByNmh4aTE5QmhHdzIvYTZLUlNsODVJOEJ0N1JnSXRD?=
 =?utf-8?Q?wDi3TmKdTT/RQVW+nA+y+Z4mE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27745de-0539-4294-9c05-08dc02cb1e71
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 08:50:59.6147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sfow3NXrd81x1w9uMbMCh76n8ZISQquV+zgh2xvQIkbqC9p5wA9O09zVs5hflMdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/22/2023 9:44 AM, Srinivasan Shanmugam wrote:
> Before using list_first_entry, make sure to check that list is not
> empty.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1347 kfd_create_indirect_link_prop() warn: can 'gpu_link' even be NULL?
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_add_peer_prop() warn: can 'iolink1' even be NULL?
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1433 kfd_add_peer_prop() warn: can 'iolink2' even be NULL?
> 
> 'Fixes: 0f28cca87e9a ("drm/amdkfd: Extend KFD device topology to surface
> peer-to-peer links")'
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index dc7c8312e8c7..a4cc88f08df2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1342,10 +1342,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>   		num_cpu++;
>   	}
>   
> -	gpu_link = list_first_entry(&kdev->io_link_props,
> -					struct kfd_iolink_properties, list);
> -	if (!gpu_link)
> -		return -ENOMEM;
> +	if (!list_empty(&kdev->io_link_props))

To match the original code logic, I think it needs to be something like

	if (list_empty(&kdev->io_link_props))
		return -ENOMEM;
(though the choice of this error code is a matter of another patch).

Otherwise, this will end up in accessing uninitialized gpu_link 
variable.  Same is the case for other modifications also.

Thanks,
Lijo

> +		gpu_link = list_first_entry(&kdev->io_link_props,
> +					    struct kfd_iolink_properties, list);
>   
>   	for (i = 0; i < num_cpu; i++) {
>   		/* CPU <--> GPU */
> @@ -1423,15 +1422,13 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>   				peer->gpu->adev))
>   		return ret;
>   
> -	iolink1 = list_first_entry(&kdev->io_link_props,
> -							struct kfd_iolink_properties, list);
> -	if (!iolink1)
> -		return -ENOMEM;
> +	if (!list_empty(&kdev->io_link_props))
> +		iolink1 = list_first_entry(&kdev->io_link_props,
> +					   struct kfd_iolink_properties, list);
>   
> -	iolink2 = list_first_entry(&peer->io_link_props,
> -							struct kfd_iolink_properties, list);
> -	if (!iolink2)
> -		return -ENOMEM;
> +	if (!list_empty(&peer->io_link_props))
> +		iolink2 = list_first_entry(&peer->io_link_props,
> +					   struct kfd_iolink_properties, list);
>   
>   	props = kfd_alloc_struct(props);
>   	if (!props)


