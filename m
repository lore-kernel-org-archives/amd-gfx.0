Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEFC433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 14:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA13E2084C
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 14:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3s98yIwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA13E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC516E138;
	Fri, 16 Oct 2020 14:34:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA286EE15
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 14:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/sm+eRD4bc1lOeIzbgOcwD3A0FPfD3zNY06lJbtiEudfjtBDM7s88O+E+wH2+TqpffkiwHZfYEv4ycV0Al5Y+4P/cLwmxCZPjoUOYeRBlwT1SCY0GCbePStBdt3vWvnopYHJls1+L7ee8/R4ExtN1iEri96e1vqhdIv8aXfC7vkEIYCb/KlnIrJj1KJnIS4gXqTMCxlu070BvRB6V2fdtzzVkaqF4LStcGRjxNeKYDLCVvrmg/sYBlGvVnwwKJuZvV5bnx9WrTo8gH51qnO4khAHtRYFH3cGvbI6uXvHmglzScLqZJ8xFPOGkKLBSFbWZbmLaSBpt7mnhLWeNbJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTmSVtLyIK4NqK4Xp7DrLo3mFwspJYo+iN1q5hmK23I=;
 b=AEaQ096LwvPGf5CXrnGq03lN385tpGLEXVNyBeqggC0j4fn7AqZ0cidytW2cPcxNj0clfimUeEJPiJTou/axFFriRA0o60eKuAkU63afAw8Clvdq8ETX9CVh0q+1Rk7vgzTAzZYg173WvWmzSVavEv/Ts1P+ICrYrZo48QtdAReOb6+zBf2Gh2qldEGBgxLWCFTnNlUs/hq4S+oL8Ap0ijgTtKqGvUZpbjbecgbmWSzWTcdhAP3xYxlnHgbngkP+1w4FcoE8frCCXAmrP9BhpIwlqxvhsoDaKbZaOQDZh1m/DpWT3OPoXvRH+w9wY/J4t/i1IQQOTHtCtSEEwYTDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTmSVtLyIK4NqK4Xp7DrLo3mFwspJYo+iN1q5hmK23I=;
 b=3s98yIwmFhH5gbS/3uuDnIiHMdHegLmqaaOBEwlxvSSCAkAVqWnhcplmFYQY1Rn+cj8ROJRNQUf7ko2uhOF3qeqXiUW3xwV8uEt5QBBIq65awuy9PGcrRPU+h4cUpWcbrjSRrw4ANV117fJ/tsAxwStBcZ0/282Ddr3pAregzm4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Fri, 16 Oct
 2020 14:34:00 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3477.024; Fri, 16 Oct 2020
 14:34:00 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable only one compute queue for raven
To: Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>
References: <20201014135242.24619-1-nirmoy.das@amd.com>
 <20201014135242.24619-2-nirmoy.das@amd.com>
 <CADnq5_PaAf=+Y7=kJRcw-UijS2_6=693_QUNzuj_QoYM3WdG6Q@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <57a2f38b-616e-087e-cd08-540f79100ff1@amd.com>
Date: Fri, 16 Oct 2020 16:33:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <CADnq5_PaAf=+Y7=kJRcw-UijS2_6=693_QUNzuj_QoYM3WdG6Q@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:404:13f::22) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.17] (165.204.84.11) by
 BN6PR14CA0036.namprd14.prod.outlook.com (2603:10b6:404:13f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Fri, 16 Oct 2020 14:33:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2513fcbc-4b09-45b8-b465-08d871e0854a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4236:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4236DD29919A0872EBF17AF88B030@DM6PR12MB4236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpNu4LKSTss2WVsuOQ6u+2UwFENISJePfBmROPKSzEF4TF79SRpKbb1dypgXxLkKqR2LCGXyHhwKM0sIToXowJ5PERB3y2thmvCHTj6RYiS++lObTrNkU/sAtQvzWGK3zJMsYybmXYNhWTlh4SF9c+qhEFlMPcVXEWe5VgB1yUhyGMOLPVNPDk3i0hWJr+4QEvZA1/mU0VdMkCBsvVuWfpQOPCLBVq3Mcf1oJDsNbxibhPD44jw/dFjdsCFh3cw50CyCERxS3GRvBPesDlYbceduHagr6OCMybYBhuzNP3mtw+lXCXrxg8W7cZMGef1soPT7aS+9TLq4lO07fjRsnKkjgnrdUw7dYaHoXYqqs7ICPT2AcqUNuW/15oYyE4YeW6kjzQIH4kGVpE4hrlZM2RfAeoCZ3hr5cs0zHwtSYhraIwkiTruDdHXY04Vfb8HnrULPRjum5w3tcaeqGDF/DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(186003)(31686004)(26005)(52116002)(53546011)(6486002)(966005)(45080400002)(83380400001)(36756003)(956004)(2616005)(34490700002)(16576012)(110136005)(316002)(54906003)(4326008)(31696002)(6666004)(66946007)(66476007)(66556008)(8676002)(5660300002)(6636002)(478600001)(8936002)(16526019)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nCRyZDwSdQxKHSX4UQ0Po18R5yL8rpwsvIzIdY/xT04GpvJmq3AxwZshtCSvq9JWvRqMtYaDFQ0WRPR/kNoZ+O8nd713CZe0gYLSiawpC+YMe9OiHNP0ySEFyOf0nWtHOYDjys1YafqFgFVnlPuX9IbltkS5PlvjQPaif46p2yMg1b8WhE/qcugRLW+lbhfykmhZn9zmGL1PDi+dyOys7Uov1e1GSINWAtKbCBo6LhOtoMaCxJzK+Zq4e/wqK0nK8BRbdqyLmucBAV3D5+A7cKrIM8GptlMXe6WEoDuKmsez62bHhGqD7VVBNFscY97MSOXrSaaK0+6L5UL5Bf7B7vhHfV10xA+dAF3VLOCKyYmmVNCvUA+A3hWc8eXLqcJy9VH48NSkd02fqaoS9PkiBrgniY3lElBAMciz/d4ShPTFBzLh+53ULGn4qS1fQOoxtVoMeJVKTMobGyscQTUqKPMSde8bAH50ZZF23s/poBanYoi3DGPlo9Az7jnwfNNrJSkQEMNaITL5opZiLpiJWbGpuJHIKqxFPW+HihpECz/ekOLxLwcTHVtpDCBL/EWJtkjA7kLvR21Km32K6n2LFor/Zlkwg9zGh0eIgd1m1py3ckxfsh8OyOdkUPnct6Gm8c1iADZc7bYZWvIaPClEJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2513fcbc-4b09-45b8-b465-08d871e0854a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 14:33:59.7962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXewihd0KqZG9z6ZLXz8ApPRgafTUlzfNmfGrfHje4WqvwkjIQNYmfrjB3S8clR2OV/3+czbY24JqW8xilM+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Aaron Liu <Aaron.Liu@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/16/20 3:56 PM, Alex Deucher wrote:
> On Wed, Oct 14, 2020 at 9:53 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>> Because of firmware bug, Raven asics can't handle jobs
>> scheduled to multiple compute queues. So enable only one
>> compute queue till we have a firmware fix.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  4 ++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 11 ++++++++++-
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 8c9bacfdbc30..ca2ac985b300 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -195,6 +195,10 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
>>   bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>>                                                 int queue)
>>   {
>> +       /* We only enable one compute queue for Raven */
>> +       if (adev->asic_type == CHIP_RAVEN)
>> +               return false;
>> +
>>          /* Policy: make queue 0 of each pipe as high priority compute queue */
>>          return (queue == 0);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 0d8e203b10ef..f3fc9ad8bc20 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -4633,7 +4633,16 @@ static int gfx_v9_0_early_init(void *handle)
>>                  adev->gfx.num_gfx_rings = 0;
>>          else
>>                  adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
>> -       adev->gfx.num_compute_rings = amdgpu_num_kcq;
>> +
>> +       /* raven firmware currently can not load balance jobs
>> +        * among multiple compute queues. Enable only one
>> +        * compute queue till we have a firmware fix.
>> +        */
>> +       if (adev->asic_type == CHIP_RAVEN)
>> +               adev->gfx.num_compute_rings = 1;
>> +       else
>> +               adev->gfx.num_compute_rings = amdgpu_num_kcq;
>> +
> I would suggest something like this instead so we can override easily
> for testing:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index abddcd9dab3d..a2954b41e59d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1376,6 +1376,12 @@ static int amdgpu_device_check_arguments(struct
> amdgpu_device *adev)
>
>          if (amdgpu_num_kcq == -1) {
>                  amdgpu_num_kcq = 8;
> +               /* raven firmware currently can not load balance jobs
> +                * among multiple compute queues. Enable only one
> +                * compute queue till we have a firmware fix.
> +                */
> +               if (adev->asic_type == CHIP_RAVEN)
> +                       amdgpu_num_kcq = 1;
>          } else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
>                  amdgpu_num_kcq = 8;
>                  dev_warn(adev->dev, "set kernel compute queue number
> to 8 due to invalid parameter provided by user\n");
>

Thanks, this looks much better,


I will update.


Nirmoy


> Alex
>
>>          gfx_v9_0_set_kiq_pm4_funcs(adev);
>>          gfx_v9_0_set_ring_funcs(adev);
>>          gfx_v9_0_set_irq_funcs(adev);
>> --
>> 2.28.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cc3012ca19bf149cb880608d871db5494%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637384534119165172%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Rcd6aMUMxxvDcwi695IYNvvhHfpKAq74KAOT9Vpzvmo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
