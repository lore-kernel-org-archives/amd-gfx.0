Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF89C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 16:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B49C2073E
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 16:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VqVeTgC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B49C2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E61706E9EC;
	Tue, 23 Jun 2020 16:03:20 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9866C6E9EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 16:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI0o0BfsZXn354TiMDTwgQr6G8Uk3puRM2x/rZkLHFT97MIkarUBhz4MARESZRXL6IpsJnvsvtISUSG57orXI9PcpPEolXpQwkdq9jSF1DnTgYNqWdD0urEBRmlEVjidyuXG2k13+92r7yr0+Ny5jjPk3o8p6JYh1xOOcNBPeAs8y9kLy47H9rvc5qk/fKO3ySZFcfte7+AfL4azF+Nqbo2w2gl7lYTqRPVlnDZgr4VEOIHCld6vlWuvtg5VSXHwXVcW2aE/fgqJCduZQp0HDE2DhZdTAjmsy+O42ycIVdfEXR4n6jrCVAPAeNzqLKkUx1Cp5Ne9YFVhgIt63sCqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7a0vNc+NOf6QN9qwZulWevHutVwiSlxl5OCfNSlHEI=;
 b=EuXEIK7tIhRI8uhzMNr/knb7BxOSETSC0zpE4JFJgRMFlFtHeS2f29aAWsCYyxFrJVXpvQsu4iWHJVzw2ImCgQ47r8wUQSBg4trNftOeZkSJ1pXr5XA3dkdFDz7D8REUKhfI80CAbc/0yW69M6yjh8A0MNmJYufRbF/6N3p/B5VS3xFyuf7nG4xsK7GWfv2gfBXtQA0maCkJIFdLjzwVYGitGzn3Uyc7JmwShUud8TYHQ3qtly3ZMy01biQ6jr9EtJXjm76Ara/tJgHzz55C6+D9taSzIVcsVcq8fELS++Zkc5Mq4ZmswXDO3ZdanzA460bs2/lRznYQhxwEx904bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7a0vNc+NOf6QN9qwZulWevHutVwiSlxl5OCfNSlHEI=;
 b=VqVeTgC4XLFVi2JxYlDitnqjEc0Lrb2Zc3xRQLqLT/mXZZ66opfpEJwfEZhKxLQtJ3ShsjaxzSLI4iliBns99nPuEY9qECrOPXm2yDA0LvJSfBf7MFNSNdYLMtZWEaXSTpVwkrwPKMY5tnpyJ6LrP2YSvYOVxQpWPR6zbx3Rauw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3911.namprd12.prod.outlook.com (2603:10b6:610:2f::12)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 16:03:18 +0000
Received: from CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::21f9:7c89:5b2c:39aa]) by CH2PR12MB3911.namprd12.prod.outlook.com
 ([fe80::21f9:7c89:5b2c:39aa%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 16:03:18 +0000
Subject: Re: [PATCH 1/1] drm/amd/powerplay: Fix DCEFCLK related compilation
 error for arcturus
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200623155929.2547-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <7cec44d8-4780-4a2b-7ea4-8fdbae634e49@amd.com>
Date: Tue, 23 Jun 2020 18:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200623155929.2547-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0026.eurprd03.prod.outlook.com
 (2603:10a6:208:14::39) To CH2PR12MB3911.namprd12.prod.outlook.com
 (2603:10b6:610:2f::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.120.26) by
 AM0PR03CA0026.eurprd03.prod.outlook.com (2603:10a6:208:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 16:03:16 +0000
X-Originating-IP: [217.86.120.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0895d882-b0a2-41ed-3d92-08d8178ef16f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4167BA5FD6B6D34CA12ADE5F8B940@CH2PR12MB4167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XX+vxAykuksg/3LjkXXPpli5EkHaVULwi8EyjwFycJ2S2gKbkNjkiy2uJByf0sYQ7/+NcZTDOd4qmjMxgnTKmBaSXnMHYhhwpb3VvN+MDaAl+KJ+4aBuh0MeHNBJrLuXwOz8qt2if9xUok5rmxJbLW0QvUyQGZZQCgQbB2hd7qatru+Y2KTQcoG7sNzE0l1NTRgb2Q4jPHtU+olm/GX1Iw/ZhNQg3acz7FEmxfsiVyOwZZh6yqhe4jJDLMKzbtTZd6ccCBbDlArwte+nhk549ldQYo/v2WqS7s3R11vR49/lpDNmn4+pRClvytb0F4w85aGr71IHJQlZo3p15sdBZEpeen2AdWn615GF/iQNSDMMYO8eUS7OmdGXHrlPhZVs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3911.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(8936002)(6486002)(956004)(8676002)(52116002)(36756003)(2616005)(26005)(16576012)(4326008)(31696002)(53546011)(186003)(16526019)(316002)(31686004)(478600001)(5660300002)(66476007)(66946007)(2906002)(83380400001)(6666004)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IFiUj6P/oq8K2p0cP3OHzLXtnsjXX6IwHwpwZ/uHyXIy7N+Z8X+Nq+a4JKYTwIh4WFcgOJSjQNQYmVIzk207w3iNxTgjQ7cQ4ai5yAvuDql5468FUSj7kud74P9D1ULfQyvBzengx9hmiB3O0n9kzbl3m8Nh6YKdRZ8w8IuKKsAVyQcleRbyMxIZmgGDA1HBGBJOwhih9ybOWMl1E9D3JXEIfwr/9cH5L0uL/SfWuCcNJo52arXTyqPYD46VSmIH0nJI1Yq3a1MLCcSFxGQR15sdDKKLnBS3g8/8ZZc7LGCAH29gw1obPxARlqGb9cwDiAjPgXRsBS7q9qKqNj7LKHDjB9Bc4JWekk6ziLK4POQ2lfW97P6GbS3VKSTTh+XKWEc+lJa7p+GVEejhIE6KY5600t7ZkG+Mhk16TaPfDoVD+gKQtJapMfnrAyDqTjY0xlClaaeQp7xaoOZbQf7hrqDS0Fw/r6W2y8rSa40Fnqs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0895d882-b0a2-41ed-3d92-08d8178ef16f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 16:03:17.8318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86N82+edllSeTPCyYnP1gMmnZDyVOT+DZ1nV7SmTyzFsoXuQMfZDJzf4+Prp2/kiDo+x81uczzNSeVtAvUptzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
Cc: Alexander.Deucher@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 6/23/20 5:59 PM, Nirmoy Das wrote:
> arcturus doesn't support DCEFCLK
>
> Fixes: c67c791cd87d (drm/amd/powerplay: return current DCEFCLK on sysfs read)


Hi Alex,


Can you please squash this with c67c791cd87d (drm/amd/powerplay: return 
current DCEFCLK on sysfs read)

I was bit too confident that arcturus changes would just work.


Regards,

Nirmoy


>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index daeae14fd380..d93f8a43a96f 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -962,9 +962,6 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
>   	case METRICS_CURR_FCLK:
>   		*value = metrics->CurrClock[PPCLK_FCLK];
>   		break;
> -	case METRICS_CURR_DCEFCLK:
> -		*value = metrics->CurrClock[PPCLK_DCEFCLK];
> -		break;
>   	case METRICS_AVERAGE_GFXCLK:
>   		*value = metrics->AverageGfxclkFrequency;
>   		break;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
