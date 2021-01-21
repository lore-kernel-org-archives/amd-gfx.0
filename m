Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D712C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 18:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D78E23A57
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 18:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D78E23A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DA889E7B;
	Thu, 21 Jan 2021 18:16:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7C689E7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 18:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvgUoMv+aEx6cbvpqr5fQcNSjPsQpfIEZuCnNpyZ2QTwOiSM59dMvBuHrVBjLCgHJWsRpeLwmIVm7+nLl4RZLNwUxW2DOpjqgdeNBaFBmP+rD52Jx4DoJ7jHqoOjU7kOZ2weZC7tttTUAh8eCPFWLedOKvV352HI9/pBf31QszrqSW3ikoDK1c/6Ve39P2Xuv0CdxrfqWBMMXrC270HqRpL6y0BnBW8O5VMAEW1OEMOlFCL16MhiV5RRSQZgCGskURX/+h2Z+IghCy5qVaVLnlswEaIGjIDuYZOJq6sqIX0IPqQYjb+u5V5MM+O0UulUeSFl2UMyK1eCezeKN0JFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EZuXW4TU7bnf5xZlT0ruSa331pOWnJ+QztaZvuNSY4=;
 b=YE4POLA08IvmONqaGehujGUOnE0SbtOsLy6EjxHvGeWORGfdwPA/xbONjD2NLeFmOWR9URnm1cDos5ZSk5szoY9W1hvB8MR1a1WgG/ax9qrVAWDbhxktvUC51J//W7Fs2U2tBkeog5j3Jmr4nTZhR7JnY+2pJ7FSH2y6WedCcJHBR0Csc3aZX4MXOF4xlWf7sLpYgiRDyHM0S52eEqp0ZK/In1wXczGdhKH8tL7RFeNmtD0/t2Wa3FGF+UodFrpFHIwuNBpC15rTyZr/76/VangGqSyKHip0bfPfDF5CNvd00vT3gS1AkLSBLLiDOmPTqfs9Vx1lRDOuQrKXFmWJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EZuXW4TU7bnf5xZlT0ruSa331pOWnJ+QztaZvuNSY4=;
 b=NBoTj87G5ASf0YF0QYYmsDwQ4hhQ0HBCd1cXz4AB8F1jZoccdW19bJc7caIEaKfDu6hfzSLoa7rfMbsBAgc+QUrsUaejRMGz4SrOhfCTIxi0sMGsWJ6KQQAf1q6Kx0J/1xkcVN7qGple+xwOWd43B1F79mQnLq3AWv/F/mvDn5I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4615.namprd12.prod.outlook.com (2603:10b6:a03:96::21)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 18:16:20 +0000
Received: from BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::5cbd:c5a8:779:9672]) by BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::5cbd:c5a8:779:9672%7]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 18:16:20 +0000
Subject: Re: [PATCH] drm/amdgpu: race issue when jobs on 2 ring timeout
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210121102106.13257-1-horace.chen@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <b8f9f0f2-611b-451f-2421-daaa91235b7c@amd.com>
Date: Thu, 21 Jan 2021 13:16:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210121102106.13257-1-horace.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:c4a3:b5aa:4f37:1c9a]
X-ClientProxiedBy: YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::14) To BYAPR12MB4615.namprd12.prod.outlook.com
 (2603:10b6:a03:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c4a3:b5aa:4f37:1c9a]
 (2607:fea8:3edf:49b0:c4a3:b5aa:4f37:1c9a) by
 YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Thu, 21 Jan 2021 18:16:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfc035f7-c2a1-4164-d6bf-08d8be38a718
X-MS-TrafficTypeDiagnostic: BY5PR12MB4066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB406667042705A83ABC18F693EAA19@BY5PR12MB4066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +isLF7xb+zoqEWsICj2GmRZqQvmCB55JCHtoUeq/DW3d3hButUYE96gb7Q0zwPJ6P8k0QRBhj0jP7duePr4lAGq0wQ/ffkpI7cFfiTytWyT10ijKNZxkcvn5WhP+OAApmaOkEpLGN0n+H+K21gt7HXM/ECZyhaKEk42SBRs15SaeZnMFdl3PRH19SvnftXwxfUl+jJc6d0863yCM6PrMqMcFwKbol8/vM2tj3MFNl6cZysjYJT9HIs8lr8WpPkTLEHH/itwGDWEsAKIjqG5w43Chsm4xvqT2pvKClj86I6WZScPrsoBmVvD/aaiOEHnj+jj2eixeznaxMfjQmwZLwppe3c/Hv3kjmqIQnS9SdyDr5YR1KHCMciJY5+sOYgGvQrjo4p/46pSMrqoqeorRfIbiWD8vYrPJHG5cddC5J3CE7o5vH9yEM+te5Bpks4AiacLzBSr6clm41HGHcgSUcOk4SbwsQhJIMQUcxLjvEIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(31696002)(6486002)(2906002)(52116002)(316002)(5660300002)(478600001)(54906003)(4326008)(31686004)(8676002)(66946007)(66556008)(66476007)(8936002)(86362001)(16526019)(36756003)(83380400001)(186003)(2616005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGFXUnM5UEZaRWhBMzEvYkUvajNabVEwOEhXL2E0S2ZtdkZJbHZ5aUFSYjdT?=
 =?utf-8?B?VXRPcDd4eHkwOGJYdDg0RTlLUnRJN2FzOWt6b2U0QlB4cVlWZ3g3Z3cwelB1?=
 =?utf-8?B?clkrcEN4aWRrTkMvVlZIVldNQjltdGtMaU1MVC9nNHRqRDdWNWRNek5CQ2tC?=
 =?utf-8?B?ZTJxZzIySWkvUFRteXlDenNtekd1U2p3UzJ6bk1RSEVZSUl5VHErQWlNMGJP?=
 =?utf-8?B?RElMUFpNZ2RZdURVd0RGeXlVa2FYOG9yS1RtWHZuM09kVzdOY0xxRGRBYmFt?=
 =?utf-8?B?M2J3TTBOUkhqY2JvNUQvaHpocUU2bzRrYmg1aFp6dnhmeFNXQW5ET0FaTGVE?=
 =?utf-8?B?WGdST2ljd3M4OERLV2dqeVU0ZWZkUUlhbUlUTnNQdW9Ld0d5NFZlQ0ZZV00z?=
 =?utf-8?B?TnNKZkpQSm5COEhpSWZYSGNCMWdLV0tpM05HdWp3THltdnRKREVzNDVsOHJG?=
 =?utf-8?B?UWNzMDgwM2hrcWs1NHdEMnZxVzJBSk0yOUh4aW1Wb0tOQkIzRVpSZkpQUzA5?=
 =?utf-8?B?d0VHZnJBcUtKQTRUVm9mYThNY2NuQW5Da2FaanVSRkJQd3EvZ2FXKys1UGV3?=
 =?utf-8?B?eVdtMmlVUGNLOHplcU1IYlJUVnhXcm54K045ZUZZWG5QUklyZzJmbHdvZG9V?=
 =?utf-8?B?RXp5V3pJeU4rZHBEaGhYN3VZbnVSaTdSQ3lWRHl5MTJyWE9YQkJaT2VBVVZj?=
 =?utf-8?B?WnQyaWJYOGMwdGJ1MGhnY1pscERqdHNQRzJDbWtUSzcyVlRTWHJlRHlkL3Rt?=
 =?utf-8?B?MFdhb1RvbFdkMjZhZkNvWE5RU2NCQ0JPNGlaRGZwMW1ndkxyOVRxazUycVBo?=
 =?utf-8?B?dkNuOG9oWkhHempzSFFvbE1qM1lFdkVhOGN6S25leFRQZ0k3eDhiaUluUlQ1?=
 =?utf-8?B?ZTdRUVZlZ3Q5bUwwZlhNVUlKTmtOSkFCNDhjTVBiMmxUVlJ5UGRCeEJ2VHlW?=
 =?utf-8?B?STY0aUZNenpKYzM2d0thU3lGcEp3blgrS21ZWWE2dU01dWh2dldyK29ZcEpC?=
 =?utf-8?B?YTI3UVczaVFkRkVaeW9SYmxxL240TUNIMXNYTHFNci9jQ1NpT21Vd3RHYTlj?=
 =?utf-8?B?TDZXU0U2NW11R1Y1djdBdEVxdWlXc3NRYml3SmlsNWxlK3VheElDRnBMckVW?=
 =?utf-8?B?S2JaeFA2NUtCMFRVOXhDdlZtN0c3VjFTR0VDM0xad3lvMHZhRnpkamllQmUx?=
 =?utf-8?B?ZWh1d3FmY3ZHZStDQzlXODBydkVRS3BrN09TMGNYMHk4aXJLeEFFTUV6WGJi?=
 =?utf-8?B?Qk1ockNjMkJVanZJdUdJWmlmdHg5cWtwYzBSWE44R3FXbWxvL2dSWHZITVlY?=
 =?utf-8?B?MnRxem9vS0pzZTNHZFJpRnB4b04wamlVRW1ETVd2U1NZNXhockVBcThEbmVt?=
 =?utf-8?B?L0pSQklFTDExRlh1V1AxTHBkdTh6MW40azBya1ppNExxbmQxMjRkeDNBY2pz?=
 =?utf-8?Q?bwr99ZA8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc035f7-c2a1-4164-d6bf-08d8be38a718
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 18:16:20.6342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GB3eWTfCLj5pO2TgcbPCQK/+wo+OZyjWlqzh37Fs7JldWxcQT8b0cVb80Ck6JbY2UGa1VA9HJA6bHHva82zJdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good to me

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 1/21/21 5:21 AM, Horace Chen wrote:
> Fix a racing issue when jobs on 2 rings timeout simultaneously.
>
> If 2 rings timed out at the same time, the
> amdgpu_device_gpu_recover will be reentered. Then the
> adev->gmc.xgmi.head will be grabbed by 2 local linked list,
> which may cause wild pointer issue in iterating.
>
> lock the device earily to prevent the node be added to 2
> different lists.
>
> also increase karma for the skipped job since the job is also
> timed out and should be guilty.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++++++++++----
>   1 file changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 82fc392e4296..702e577be5e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4459,6 +4459,46 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>   	up_write(&adev->reset_sem);
>   }
>   
> +/*
> + * to lockup a list of amdgpu devices in a hive safely, if not a hive
> + * with multiple nodes, it will be similar as amdgpu_device_lock_adev.
> + *
> + * unlock won't require roll back.
> + */
> +static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> +		if (!hive) {
> +			dev_err(adev->dev, "Hive is NULL while device has multiple xgmi nodes");
> +			return -ENODEV;
> +		}
> +		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> +			if (!amdgpu_device_lock_adev(tmp_adev, hive))
> +				goto roll_back;
> +		}
> +	} else if (!amdgpu_device_lock_adev(adev, hive))
> +		return -EAGAIN;
> +
> +	return 0;
> +roll_back:
> +	if (!list_is_first(&tmp_adev->gmc.xgmi.head, &hive->device_list)) {
> +		/*
> +		 * if the lockup iteration break in the middle of a hive,
> +		 * it may means there may has a race issue,
> +		 * or a hive device locked up independently.
> +		 * we may be in trouble and may not, so will try to roll back
> +		 * the lock and give out a warnning.
> +		 */
> +		dev_warn(tmp_adev->dev, "Hive lock iteration broke in the middle. Rolling back to unlock");
> +		list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> +			amdgpu_device_unlock_adev(tmp_adev);
> +		}
> +	}
> +	return -EAGAIN;
> +}
> +
>   static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
>   {
>   	struct pci_dev *p = NULL;
> @@ -4572,11 +4612,29 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
>   				job ? job->base.id : -1, hive->hive_id);
>   			amdgpu_put_xgmi_hive(hive);
> +			if (job)
> +				drm_sched_increase_karma(&job->base);
>   			return 0;
>   		}
>   		mutex_lock(&hive->hive_lock);
>   	}
>   
> +	/*
> +	 * lock the device before we try to operate the linked list
> +	 * if didn't get the device lock, don't touch the linked list since
> +	 * others may iterating it.
> +	 */
> +	r = amdgpu_device_lock_hive_adev(adev, hive);
> +	if (r) {
> +		dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> +					job ? job->base.id : -1);
> +
> +		/* even we skipped this reset, still need to set the job to guilty */
> +		if (job)
> +			drm_sched_increase_karma(&job->base);
> +		goto skip_recovery;
> +	}
> +
>   	/*
>   	 * Build list of devices to reset.
>   	 * In case we are in XGMI hive mode, resort the device list
> @@ -4584,8 +4642,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 */
>   	INIT_LIST_HEAD(&device_list);
>   	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> -		if (!hive)
> -			return -ENODEV;
>   		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
>   			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
>   		device_list_handle = &hive->device_list;
> @@ -4596,13 +4652,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   	/* block all schedulers and reset given job's ring */
>   	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
> -		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
> -			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
> -				  job ? job->base.id : -1);
> -			r = 0;
> -			goto skip_recovery;
> -		}
> -
>   		/*
>   		 * Try to put the audio codec into suspend state
>   		 * before gpu reset started.
> @@ -4740,7 +4789,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		amdgpu_put_xgmi_hive(hive);
>   	}
>   
> -	if (r)
> +	if (r && r != -EAGAIN)
>   		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
>   	return r;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
