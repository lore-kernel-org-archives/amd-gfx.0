Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89719C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 21:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C548206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 21:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Virk4MVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C548206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36A06E204;
	Tue,  2 Jun 2020 21:19:01 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680065.outbound.protection.outlook.com [40.107.68.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7476E204
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 21:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD/j1PfU20bdz5sKyVcgV28nkIQdQeVb1UBYmkCl2MgqpxgAdN5Hhk6XD/vl3PM8taFbzceC/7vFeKlZLGJsSMObQPVGP7sEf/y6/2LNUWxkbKyEQj6nOeaILfkhzXc0vLLlMnCdNo2x7DI/wpYhSByH+erM+JDQDx0gMzdgMO96eG9kIZf1/jRg1/NOL+/VNYoBjBH3oHQ15HnkTTcAs5uw5oXfQhJ/V5DtD33miYeqdc9EvC1rqWY3f3jitDw2RxIxRqd5h2sLZ5Dm6M+UMNCU9oNUsiwkIa+4f7r493vmyxunuiPjN1KFPcD0yFvswKSJ1F3MuUUs1DDzOQJrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+hT9e6RSs1DpN7HyWnJ3J3ejbQPizIqRG/7q383QRw=;
 b=OWLY5vX2hO4Wij2PXkxJFQMylxKEu42clTbTmzM8VigzGcdRCx+ywbtYncdsTKRtApTeY1d5+9fttj3p5WA7X0Im/eSRPh00TFADmp5LK6elSA2grehrVLp3n8HIqU0Qd0Q8kxF2FDf3NaPZoiBnB4TyCu7sNFpxuMMtTTg4Eh0feQr08r++NhyUX8eE1H6rW9vuLBCkoaflfsFbWWhh8IJ65pXsYM2Q+Aif39VKGiC9PdrxEE6e7Sdu6FobRw470/NJ9rJ5adWPjA3FRmhQJSkVz+fJVcWly/faqFYNZ0sra9ZPBcpbjV7t5jOG2ICSN1ULaWRKwPWHHHYubURlvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+hT9e6RSs1DpN7HyWnJ3J3ejbQPizIqRG/7q383QRw=;
 b=Virk4MVtp/71R1Ls5obWfZzzdcAKPbSsHboqwxBtC3Djh91ItmbqQxcsnfx+zZQBdu2wzARVjpyb4J+puOW9fGWfiPOTePP3lzvfAQ/NuoJqJ6c3SVGdrQ3u8NR6iDtWjbbo3xLJEzjWhpTKdxUC8BTstVwXc8zg3htqaj16DV8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3722.namprd12.prod.outlook.com (2603:10b6:5:1c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 21:18:58 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 21:18:58 +0000
Subject: Re: [PATCH 8/9] drm/amd/powerplay: drop unnecessary dynamic buffer
 allocation
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-8-evan.quan@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <ec92357c-8777-c777-faad-579935e5dfc9@amd.com>
Date: Tue, 2 Jun 2020 17:18:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200601073003.13044-8-evan.quan@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: BN6PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:405:1::30) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR10CA0020.namprd10.prod.outlook.com (2603:10b6:405:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 21:18:57 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c592c083-5bc2-4517-693e-08d8073a9035
X-MS-TrafficTypeDiagnostic: DM6PR12MB3722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3722370081675E4E89F48D94998B0@DM6PR12MB3722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jsgRsPEXjd7siomKzWT7Z0JEdvmiUa25MbPTxBk7BRnQCS1xObWoeuxe9qEADIqUEpzTdKjuurMXHZ8rDz/Jdgw2QcLHsW2+vT13AtXILbIRLw9UbXEOXwxppnYNv7/2J/BzC7M1Lju2PiV12fOtNnH2G20FKsbr02LuGWemiZGZPZtMCNmXex75ipQvwJDOhpTYkFRzvp8L7ODnrjslvEXvl41ND1Tzx7kqBZHnAhQYUyDB3rzG7yQJX7s1XGoIcnf2yx8tyqWwH8GODOV2vW0+fn2wxvTeKJ+HuY4VOOG67V6dKk7naE8H1upVtiWXNimbJrJRSyCjamb4+ZymBNs7YGFrCPoVLGm+uns3C9Hr/heiwAUXldCCNpWEmH/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(86362001)(6486002)(31696002)(5660300002)(956004)(8676002)(8936002)(6512007)(16526019)(4326008)(44832011)(186003)(6506007)(53546011)(26005)(2616005)(478600001)(52116002)(2906002)(83380400001)(66556008)(36756003)(66946007)(66476007)(316002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +KCI6Kd4p4T+LNarwFAxh4kV8fgYH3+1ZAgKzMQqvpxJs4AsVDD2MP01N44P8m9rI7P/8TaNaN0ghVovelDx8GV/JrumW/Ttq0veASw/vkO6o5wclp3G5JeGCxqfkUsQXDRDH/p2ITO0AIlDABtpfrkgsRvFG5u9SNPOczlFb+aynLSj9DWW1iF5azMiESAavgrFnpxHfkAZrgD1CRGtG5x0GxZj4IR8sVLafPLrqruD8hUCzdaW3ncs1c5iqioL+zl/Jhif3kTFAoav40mlo6v+f0a/Rgyia2KwOsRhA7JrZa8M65aZNgCS99KHzhmX4nfm0lqIyWs2AAcLME6LO1isk5t1Rt7fLD+SsfbdcEHhgYB3vkqE/cRAUVQCvt7I5xJe3OB0pNiqc+vLYuYKfLvLEJyqLcLG0/Ty9/7yjOV+/q9jXSzfsYTvKIN8TTc+N8A7wr1syLRffI6qLhGpFeiLnjRO8K6slHBeX1lNyqk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c592c083-5bc2-4517-693e-08d8073a9035
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 21:18:58.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18ZKokvDZ/FQsVo7B+bh6ZNlOE/CL//lLm6/nE9rwxGY7iV0YbgCp4cWDP912epu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3722
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
Cc: alexander.deucher@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-06-01 3:30 a.m., Evan Quan wrote:
> Since the structure comes with only several bytes.
> 

This is not a good commit message as it doesn't describe
what is being done. It evokes the "Yes? Then what?" questions
from a reader.

Perhaps a better one would be:

	Allocate the struct amdgpu_irq_src on the stack,
	since it is only several bytes in size.

Regards,
Luben


> Change-Id: Ie9df0db543fdd4cf5b963a286ef40dee03c436bf
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  3 ---
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 15 +++------------
>  3 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index e55c6458b212..b353ac1b0f07 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1121,9 +1121,6 @@ static int smu_sw_fini(void *handle)
>  	struct smu_context *smu = &adev->smu;
>  	int ret;
>  
> -	kfree(smu->irq_source);
> -	smu->irq_source = NULL;
> -
>  	ret = smu_smc_table_sw_fini(smu);
>  	if (ret) {
>  		pr_err("Failed to sw fini smc table!\n");
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 4aa63dc79124..7fed2556213f 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -356,7 +356,7 @@ struct smu_baco_context
>  struct smu_context
>  {
>  	struct amdgpu_device            *adev;
> -	struct amdgpu_irq_src		*irq_source;
> +	struct amdgpu_irq_src		irq_source;
>  
>  	const struct pptable_funcs	*ppt_funcs;
>  	struct mutex			mutex;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 891781a5c0d4..e2b1c619151f 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1167,7 +1167,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>  		if (ret)
>  			return ret;
>  
> -		ret = amdgpu_irq_get(adev, smu->irq_source, 0);
> +		ret = amdgpu_irq_get(adev, &smu->irq_source, 0);
>  		if (ret)
>  			return ret;
>  
> @@ -1191,7 +1191,7 @@ int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
>  
>  int smu_v11_0_disable_thermal_alert(struct smu_context *smu)
>  {
> -	return amdgpu_irq_put(smu->adev, smu->irq_source, 0);
> +	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
>  }
>  
>  static uint16_t convert_to_vddc(uint8_t vid)
> @@ -1607,18 +1607,9 @@ static const struct amdgpu_irq_src_funcs smu_v11_0_irq_funcs =
>  int smu_v11_0_register_irq_handler(struct smu_context *smu)
>  {
>  	struct amdgpu_device *adev = smu->adev;
> -	struct amdgpu_irq_src *irq_src = smu->irq_source;
> +	struct amdgpu_irq_src *irq_src = &smu->irq_source;
>  	int ret = 0;
>  
> -	/* already register */
> -	if (irq_src)
> -		return 0;
> -
> -	irq_src = kzalloc(sizeof(struct amdgpu_irq_src), GFP_KERNEL);
> -	if (!irq_src)
> -		return -ENOMEM;
> -	smu->irq_source = irq_src;
> -
>  	irq_src->num_types = 1;
>  	irq_src->funcs = &smu_v11_0_irq_funcs;
>  
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
