Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA96C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 15:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9547B207DA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jXR8MMU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9547B207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A7E6EB79;
	Fri, 14 Aug 2020 15:21:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 734C96EB79
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 15:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J67Q+O34OZuCjNdesMNHp5XflxfpjQBp2KPsMtdDriI+S6qPC+0TYBHu8RxiSJOrC+4cZNKlL5FGoLIOBLlsvBYKTJL87ZGKZ2vEYCoeFJhGBSx7vsaqAbUYxafa1KkhOd6R9tqe/LG55z0hXgSvEg+wgx2nVYxUN1w6Mzjk90Q7f+0xBRvRUa+8pwJulkxOlxnDVqC4Ft4WnFyhBuCNTTj8m9Q89HkpRie0WE9Us2L15gGLVcAlFXNGqZM3F6tX8T9c36cvnqCSYqvcwdcR3Km8wrfUlJCsy4j0gIP0CQpApZri7DKKDCiXEqrsxK05j1TjiPoJJvacBlkP/As+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5Y+rXimSEhKb38JPppI+bv0McwR4FPESrcxs7/6reE=;
 b=G7T7Q9DJspUOfACsEqjQDe7vgsfYsCWjlU1ZljdPLy2eK9Jb/kt0P56jtLGqKAcaIN8NUw+VQsB3xlczp1yxeid3BbQlWsrMjaWmvWx4Un2T8PmqPtpWI7BOizHBzvUZQo4C+65xJLXbqly/OGgfM2nT0W7mOg3LhYTiKO+wVDwkyNZQ0ZE6di9Vqo9WG1Mt8g1lYPIOGQYos+kGiOMokpbqjA8qiL91m/DwGKP04DEw+edIdGLRFu+lf//BlYSlQezyqNUAi8l62mJ42dm06kJbKeQebuTqBars2ZfsnDurmz7ZE/xzOR7BFh/nZ//07SjDdkXFGxaYTGkCx7di8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5Y+rXimSEhKb38JPppI+bv0McwR4FPESrcxs7/6reE=;
 b=jXR8MMU3xalg+7dhAAPdmA19xzM2YJ9twzUXhxki5OcAJG7yudO+wW/Ho3JEWnCmeDA5R2p+JnL3Rc4ybtB3Wi4XYWZOnThh6CTu0Ws1zcZsZ7kQP+dyLja0j3aw/DJcQyYz+kYvNwKsjTyXLunVjolqCTs4K7GyUK2N0VqmWh4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 15:21:48 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.020; Fri, 14 Aug 2020
 15:21:48 +0000
Subject: Re: [PATCH] drm/amdgpu/jpeg: remove redundant check when it returns
To: Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200813194047.13162-1-leo.liu@amd.com>
 <20200814151447.12862-1-leo.liu@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <e9d57cac-d4f8-34c6-3a51-fff2d6761e9d@amd.com>
Date: Fri, 14 Aug 2020 17:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200814151447.12862-1-leo.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0019.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::29) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.108.42) by
 AM4PR0902CA0019.eurprd09.prod.outlook.com (2603:10a6:200:9b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Fri, 14 Aug 2020 15:21:47 +0000
X-Originating-IP: [217.86.108.42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6973405c-5743-4993-bcf4-08d84065c305
X-MS-TrafficTypeDiagnostic: DM6PR12MB4313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43138E2D6CF0855F0BC31A558B400@DM6PR12MB4313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/UAZ/Ibjl7qiujRZIfZg+QYjbIwtJ4qfuBqqU4qmE3orh4UXXvIUvg4tTfPqiQlyPRMg2drNdYir0rwF0IzDC5i3Zv82vw7uXwLKhnmuoE+TtbyRWHBGOhGsiRsDHAsyDt9J8dppztVXzVcFHKzUcA54V2ohfkj0C6H6ypOLJrsTpIERaJ5hjgOtTgpXpHjWLVVxFBOFs7MQIRNXyeKm/QzXZfhkBdYw1SV7it47WimDXLK3YYvp9HZOVyAbjhQ9RvmfqB4RvYDz4nPfxGCrZaxLPbLFm3C6Jvu/2Um7CSYh/qZItZ1hW/bOoKK2Lcz6u5iW9N5/kzJgAKWdDtj17dc8kcCKr68s5TBIQAXAOJt4zSurMff9nQoBvSAu2WZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(36756003)(6666004)(956004)(478600001)(2616005)(52116002)(66946007)(53546011)(6486002)(31696002)(316002)(66556008)(16576012)(8936002)(5660300002)(8676002)(4326008)(83380400001)(26005)(2906002)(16526019)(31686004)(66476007)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: f1pAnwncXZaEb5viPwSQqmlbu9AUFN5rKUNNlR5GNa9er548Km5JHM36Vk41q2FfntWZ9fgS4EU2A1DKdR4tkGz+KpGnup33X9T/ed96SM+18ajy6vV6Qnz6FYDn2KRtSXlL8MRjFHgKbhDgf5sFEHxvUCUXzCu/4S3BI5pThelgsnNfbQc22icTdwGjJ9Z064e3EYGJ0cjZxLpAkjENDWSUZnfWPvQ1plpfTI6NhQl1EISBvbtR06sKOSG0LOOzo79eeZhSSBUkBo2ArY1AhgXXMGhfv1LP2gLton2lgrT+sar1cD8oKSWrLj1ZLApsrcEiDCtxobgjvllfrW+WvNgBMI2UhVn7m2LUZDOckVptQCCtRvxoa86yw5C7HEqEc2itJ4+DrwPh3rnxpptETHi+PjaHB3PTODoVXv2E1d6nJ9HHjbADYrarL40yf9hZ5sP+RKXZkouBAvheI0HvT7+ORbwjjk2Fcea/qmz103UTx8IkdoHNs6YTZT1Yoz6UmyGpbJTsNfGZMbmDamNoLtAqk7ZUbakFRoJL7SNQEztP6pYSh3bou8uXrpsJ3CTCyezzGzXRvwYHw/DiLPi4HNSQFsNkYxDvwKN+aIOOUZUzI2Tg4TCJvc5N5HxrlfwB45GGtYHKvvSMR4HC+LeUMw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6973405c-5743-4993-bcf4-08d84065c305
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 15:21:48.3001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: din34SXzZLqxAruK8LSQsxj94zy1H1zTch8b5eEOCyHkq5VvVAwEpegcm7ziWR0FE3BnMVahU1MiMHjUZFlMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 8/14/20 5:14 PM, Leo Liu wrote:
> Fix warning from kernel test robot
> v2: remove the local variable as well
>
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index c41e5590a701..3a0dff53654d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -460,15 +460,10 @@ static bool jpeg_v3_0_is_idle(void *handle)
>   static int jpeg_v3_0_wait_for_idle(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int ret;
>   
> -	ret = SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
> +	return SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
>   		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>   		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
>   }
>   
>   static int jpeg_v3_0_set_clockgating_state(void *handle,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
