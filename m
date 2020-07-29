Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94ABC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 14:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0E22070B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 14:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O6+W0OLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0E22070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341326E530;
	Wed, 29 Jul 2020 14:18:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653A76E530
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 14:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO5d9kfZNl2h/+Kzx5xcSN82PyQ50a8/ApWHe5x50CQTTvJQ2UwXdq4Pz74Kha1pFqqR++kaOijbFpTpeWXs8jFyTvCabduqCIbW4IvLyNYLmg4r29fRO5pOBj+BNEW0xxSnWOVGf6jVB/Ak1uZ9s8pmnPnzyznEfvOKoIw19kO/y3w6gUKflEKTMbKLpSo/A1QKoN+ZrMvWIZu5285beTJqAG7BBE2FTf794/c7Wd11TXOOuw+V+7JvdeoU4yVRST4TUbn+09E5NxVGFBtALcjVnmB81O2OXzNC9bwXwMV915p9i8skSffzh87qU/w6ern2dP1zAbjAFirCWPUCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95i/1jra/G5cuIOyAZ6QwklKMAy6YWgIdB0MRadIWBg=;
 b=QBDYdQ0GIP9s5ZrtrYR6WWHRibbApo1jj2g6lUu9g4e1s06G++IJe4AXEds0LCjv9szUSCsXZv9xNXi4T5mtM40YeVGhBxLfc9UiJPygAD6K3pesdv2eDFQnkxoMi7pfBWLPlaIVyOPdbkpHjtMDGu6/hZfjgbSTOTtRwm963A5Z5N8DBXsP1LLuXiGOM7zbFhy11kRyVgdodiOW7LOjdWA0O47EHn4c4lZjVBT6h+Xexvg32UnRpmHJM9M6/G2T/9kFSxZZQA9mkBEZ01NUsllsNMzmZq/CwtWoxezCu5l93f5LwMEEjg52fuqhkDwAqEfu6/Vu86qtLMI5RAH2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95i/1jra/G5cuIOyAZ6QwklKMAy6YWgIdB0MRadIWBg=;
 b=O6+W0OLiVAhfhf73knCnkshtyniyMgpPDV6sbD2qqwxxCV2FtNl1kYjE9MVV1FspVXcw6BGuLnRXf0aAovvQ9KJZfrvY+m5aOy4ZlX0Qz18s/YW4qDc6D6LKeyoY+iNj39aNcAnZ93Egmktfh5a0ydORsXxwIf1JZjXwHNlEbyU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN8PR12MB3059.namprd12.prod.outlook.com (2603:10b6:408:42::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 14:18:25 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 14:18:25 +0000
Subject: Re: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200729085003.1133792-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <ca0848e9-22bf-1811-5fe4-f3728db1d202@amd.com>
Date: Wed, 29 Jul 2020 10:18:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200729085003.1133792-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 14:18:23 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed3c215d-3300-4bd8-2287-08d833ca4163
X-MS-TrafficTypeDiagnostic: BN8PR12MB3059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB30593DBCE4C6B2BF029B94FD99700@BN8PR12MB3059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTKtvjbPTDeTJIjTIQ+pvPEOd2ZyOgr3f45iN9hTP21611EUEZH1MxIqDZbCafOc0NrzhtB0OgLtfUllOiENDi7HfrdBUha6irhY9UNDMHFVYRFkl1ePkixIJTlr82hYm/2DaefuDe3z0PCnk8Ig77TTQx28bP0O034wnonB0ZtunxfTQtVbZBlI7xBzFIQAR6VWTVJ/FwnkFKgfirPfPMsyO6Epfwb/znOcliNSBYZmJvcB/u4g8h65FdIehkuu+pX/1TId7qKs7BBDn+sLJ7EUVzTdCZ3EQE604r7x9MLZbaUOtsDgKN0H9CtEhG6fQW1hxqMl4AUakdHbinXHLgxqXkRwXDeWHm44DiOU7jbPFWHwLj2y81Vzxytk2Rjh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(6486002)(5660300002)(186003)(316002)(956004)(31696002)(2616005)(86362001)(2906002)(83380400001)(53546011)(52116002)(66556008)(44832011)(478600001)(66946007)(66476007)(26005)(36756003)(16526019)(8936002)(31686004)(16576012)(4326008)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XkoBrPN43GX7R40RLu6tFWGBx6akjWJnNjfN6f+DQTomfyVetOz5KUaf19zeCVKFEuBhvrrDp0AjSAeS6IZPGmjR1TSmtyTdz5Aa1fCWoCppvpTQpvrlJtcfdXZ9EkhPqpKmpwDQ4c8TaLYuH8HDLfJ10ygpt3Zz2QI47+f97YLaVvq/boZ7UPaRr53x4fXg9W2C3rInPCDDq+2Yk8UUBNOCmezbhvoAlIfu8QfRC+UcM7bchqmwzH+4q44b2r0Q9isqhudvNIvb01b1urRl7FcKApnY1FUGoll0TP3nvHKzMk7EOu2pjn108CNSAN5YluWlvpKh5YTfFpJjTRn3XnMVhwdIs/58NJqdw0QU4/JTizIKbFqfYpNMWmj8D/AcpojqEyccOZR6pHEdsQx7KrDU5sPuLkhdqvfSiboicTy+VPfeyNMq6kVcd318zJ8e7LI8KfdnA7WmHR7E+YxnUikHvKgF6OvTqdq16Ozo5aGofZ7ypBmhv2sdq1mAtJKo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3c215d-3300-4bd8-2287-08d833ca4163
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 14:18:24.9289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IeLOOPOmtMqLixAks0gM/iZIjU7i6CP64Jf97rarEYEtjWXMOKqoBjjApKSjA3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3059
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
Cc: Deucher Alexander <Alexander.Deucher@amd.m>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2020-07-29 04:50, Liu ChengZhe wrote:
> Assigning false to block->status.hw overwrites PSP's previous
> hardware status, which causes the PSP to Resume operation after
> hardware init.
> 
> Remove this assignment and let the PSP execute Resume operation
> when it is told to.
> 
> v2: Remove the braces.
> v3: Modify the description.
> 
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 62ecac97fbd2..5d9affa1d35a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2574,6 +2574,9 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  		AMD_IP_BLOCK_TYPE_IH,
>  	};
>  
> +	for (i = 0; i < adev->num_ip_blocks; i++)
> +		adev->ip_blocks[i].status.hw = false;
> +
>  	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>  		int j;
>  		struct amdgpu_ip_block *block;
> @@ -2581,7 +2584,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>  		for (j = 0; j < adev->num_ip_blocks; j++) {
>  			block = &adev->ip_blocks[j];
>  
> -			block->status.hw = false;
>  			if (block->version->type != ip_order[i] ||
>  				!block->status.valid)
>  				continue;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
