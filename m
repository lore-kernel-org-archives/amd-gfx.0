Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D302EC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 10:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA892067C
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 10:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RBoUGcWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA892067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D5389C6A;
	Mon, 17 Aug 2020 10:06:33 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5270A89C6A
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 10:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF4BbX4OjpG5pvPBLU/QDyMcOpzwdnHiSL3e+6QsaWMuVlAzmCnO0qaxr8MNIK2L8rKN5bBurQuVbzKn1J3NIHurFf2749HhJazP8QzfhQuRIFxgp2LBX2FvFCY3Kc+IdpcZlNuTgDVJrN7q2gTNmoQUTmqynvkPyr41ihm5WY751vy6L2ivRux++ALvMULr2t6ZKq9nifGO9WdXymOsW9iKSHsZQi8Hz4Q5zyI/zPzsrZSA7vAawVrkMeRrfT6tC/tvA7nvd9UnxDs5EeTPoXgOm3gYZa3wLzZcDGXVGpCEpxiQFXkap/E7SOjOLHIZ3bQAgc3XJhuMGZVWG+UIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GluPUxC4KmvnuhsneFto6e/82ngEToSsRsDckPhW0Q4=;
 b=aNxxwpZwRiYwYRcItBDA5YUvx86FYLpQv1aKJ13pB0emFDEn4wbf1dNkeJxJWkDRkdS2LxUS5FpnxHWyd7N87kwKa2y6ZWREltX2boYx+ULDeXlFI5EyyMFRqKsgvnWZxn0Xgx93/3qw/wlu7phnGESMcLM2NpxKmIK2LkxMfdyQuZdcAW2Wqg4rkn7fENADnjJQS9Hhq1Sjh+rrSujoiD6P2/2bfMO92l8NX7IfQQyAgsIy/zsM0D/UAZBM+g3Bd4ESbQ86ycMHbHGpXpruDVHKv0mx0yiS4oWkyN8sp/ki9Lsz9txdlf2RdEQpE2iPg0bnWSG79i3TTPUfxyXkDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GluPUxC4KmvnuhsneFto6e/82ngEToSsRsDckPhW0Q4=;
 b=RBoUGcWtt1e/+TRBw+2x306kqHtvKjzpxy+4FoNB3orYo3j6gLdgGiY0WxzWwoY358Djo7MkdDAi3k8N9u5wyQVMcpE5xV+ejMY46pkLC2yLKzkFKjhsl93DyctrBtbklcpx699lj1kxlr10z+5X0fWtahrI8sbLI/AdMqKaByU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 10:06:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 10:06:30 +0000
Subject: Re: [PATCH] drm/amdgpu: add condition check for trace_amdgpu_cs()
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200817090445.26479-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5f3f62d9-e507-6579-b7b3-8ca05028532d@amd.com>
Date: Mon, 17 Aug 2020 12:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817090445.26479-1-kevin1.wang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:205::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 10:06:29 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 868e0e5f-f4ee-491f-78fe-08d842953608
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43185B54C2EB9462CCD0DFB5835F0@MN2PR12MB4318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8/PDbHcleOTbNx07Z8Jy7dOO+scJnCfR7xyGnXOkorJaImeG7zaq8sj5vwVrBAEauK4HGqRmCqQGl0qjKOQ/Hwr1KX5qDseyeLUrOXW79Wa27s2ZADjKV9KQ94SHXpISsfcmw8OFEUaODTVGCQAG/VKvJslCGYRsdpe43UHNmkWnFZepc2YaHbQnreFqdKhCSba9NLjIVc59VWjQZRA20jXfia3xN1Ie2bZ9nWG/KNE7zxVqEARyhLBK8LX9yQTBTMOQEIjUESBYK8PWJr4HDoKUdYMW096UPeSVxzYMq3c57HOVdX1kSdAlABKloI0b5CWJZ6Q/gKHzc8N9tJmJc3QheJJe5s3EXOWn+x8gpvnFLbjjtV9HGx1TAfhW6uR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(2906002)(6486002)(36756003)(83380400001)(66946007)(66556008)(8676002)(66476007)(86362001)(31696002)(16526019)(2616005)(478600001)(52116002)(31686004)(316002)(6666004)(186003)(8936002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: X4iY2Mh+A4gGNBSWi2bu6R+WafkcqKA1GSzYHN/2CR8Q8VlS1GvLHvmNrEhmojm0CsZgYlVT7vpP1FPLPx6ahhFHefvNgR1AQNuR6xgv07HDA8e8s4UnpF6Vbpo6IWPf1+VAXCUKhv1MIGQ1J91HA+64yGt7SviQQNm4/vrV4hKxAhvIEMQ8W0pUaVv2404k5h6BGlDSmsU0HTA/W1aOPbopkkbOr5IBCmHpFErBHu0Z0T+S3DrMxuG7nO+ecmygKuX/rwp++hVRkHgUf73eLWbamHNOlA/rxsM7IykbEnyovrxCdMJ+WTrF+7R95qN/xSYnUR0QUaezRJBise+saEnHHZUjbw9g1p5IbDn+9J3h1036ZSTqGKZr4BElsslKppo5FENWppLgo6swo5FT/bZIvRJB+HKeVU7jghpoxL4Pk6fKWhJCXkcJAQR1HAJ7lQ2hjDXsnFDVb3oVTw7nuTcn0lLrJrSnXCyIVrzbn8ufaj96VYr5MY4Ezz8lOQVgpEEHquKNZIe/XscJqnngITc4PAfOT2oY0460gRYQcmeE66piX6ZBsJTE/iQKvv0t+nekqnC0752+gTRUyMZkkw4CBMlXJYl/2AXFiUSnpkZ0m9r3E0shdeYSQyFmD07yWn8WUpOUDiIASPoTlOmpfxrmIQe+CmRflpwm3NqKtZt9eOfTUSdX0QJ5kUMH+3Km993VSoCh5VNJvKhf2fRXFA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868e0e5f-f4ee-491f-78fe-08d842953608
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 10:06:30.0798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1giDd/lCU6wQ8OGiJo7oBht3FEuZ6yylOrEy/EcoilAnvS4UXgwunlzp5pzPbope
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.08.20 um 11:04 schrieb Kevin Wang:
> add trace event enabled check to avoid nop loop when submit multi ibs
> in amdgpu_cs_ioctl() function.

Maybe we should change the trace point instead to trace all IBs with 
just a single call.

>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index ffbcaf4bfb8b..409694f074ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1319,8 +1319,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   
>   	reserved_buffers = true;
>   
> -	for (i = 0; i < parser.job->num_ibs; i++)
> -		trace_amdgpu_cs(&parser, i);
> +	if (trace_amdgpu_cs_enabled())
> +		for (i = 0; i < parser.job->num_ibs; i++)
> +			trace_amdgpu_cs(&parser, i);
>   
>   	r = amdgpu_cs_vm_handling(&parser);
>   	if (r)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
