Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C0EC4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8922222C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cV/ITz79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8922222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953B46E95B;
	Mon, 26 Oct 2020 15:29:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6290B6E95B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 15:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIz2MpveiSADjP3Mju9lVyxMpCgDVKpBBdnILQj9Sx54Yr3+qXTLzMnNgIny8UHGCx3zJm06jVD4KSkS4YglBVHQ0EtThu15LlH2mjDhxgQgwMnSNP4/k5ToeqIhRBaI9WoINb2tqCvJFi+jLLC1gD14oHgGh4rDTqpI3Sdcg7i2s+SRenZ4IkLAixZdc71+18z+uiyuIg0C8JQHX5Ieo6EreI0UUxPUTrOWuzTm1wyJnkcAg4YIp9DkszHA1LQE55TR5J9PllbLbqACvd2SmDgUX0WlO8Qw6WZZmbbZOkdI7VwkTGvW0OFfDaF23QYDnm2XZ3KZX7U/r5olRM4Ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaCZQdDRoIbqMBaulPa6reFATnZ66vcYuuRAlumken4=;
 b=GlryVILwyE0+iqf334YF8n3sAlpmNO0xB+2pZ6stIEQY5SZ55hqOvDvuBLZbnhOR0uK1kFI3ptb22CVTWRUl0RzcCHfs28u21NNvqyZSWlOv+67yrCpw5CGutLMyCR3NGBNCaYnYydY7d1yKlr7RT3Bl+v320hIvMJct2Y81J19Law8O+CZ0IWqkTvhWKDClrHsU+l+2UI/AoLLiZuAPmSD/yWdEYDgHwblNlxL92c4G9H1zXTBW4Qrz1AYaw/hOka+ojMqkmFOZ0QjGnmoK9jMhYYVQdDcUO5G3QqIgD+oVrsdpzddYOObynhsG2h1KhVktTWOOrsVIiYu/6srvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaCZQdDRoIbqMBaulPa6reFATnZ66vcYuuRAlumken4=;
 b=cV/ITz79KWY3XW/E5kmh6AFjp+jH1cyjkYtR70q8wu9BegbeQBgViA/9510rTxRG1gIklk32blS/bwjowUAak4yuue0p4Nc7WffUWmOgANUcstT/J9aqem9o1e/A7f7f0e4cmY3yN0is5vItObU8jUo21VQrz0Akr8s+Pjlj6Vs=
Authentication-Results: yahoo.ca; dkim=none (message not signed)
 header.d=none;yahoo.ca; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4935.namprd12.prod.outlook.com (2603:10b6:a03:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Mon, 26 Oct
 2020 15:29:44 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 15:29:43 +0000
Subject: Re: [PATCH] drm/amdgpu/display: use kvzalloc again in dc_create_state
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201026143040.887736-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <5fa7627d-619e-93c2-ded5-c5305b1498c9@amd.com>
Date: Mon, 26 Oct 2020 11:29:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201026143040.887736-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::43) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTXPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 15:29:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3e7fe13-ba53-47cf-cc2a-08d879c3f68a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB49354157A9DAE48324A82C75EC190@BY5PR12MB4935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+QUjvjaku393JtPoMF5aXLb3q46mnuOQ+72sK6g9WB3/clud1fnLTEd0nzfbjkUZ682hBQ0O4dWTerlUXSPGOSKdiEobxGq8RPkgUpUseXrey5K9AEUAEA5Z4yPlsAreEHIlAtYXD8GTui4LB3Zf50jHWEFXyGqLfuu9yhuJNmNaSwNOE9MvIBlrGUeSWehPhz8PSt1WI2lKDK1dyHeIbJVO5OZyiVR2O8Ms2eQIEmq/c1gR/DyG4OtOPIq4PlKxLXF1boEvkrLcMSuWzrks9XNjCymafwUTUUmEz2qwgIY7U6CpWST1eXMuxAdQff+aAjSgUKxhMc5+1FTQfQOdDfBO8Vj8E5excnyo7V3jcXSIOQi94gDTtFTPyQrsyWl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8676002)(956004)(54906003)(2616005)(478600001)(4001150100001)(83380400001)(36756003)(5660300002)(6666004)(31696002)(4326008)(53546011)(86362001)(66556008)(6486002)(186003)(52116002)(66476007)(16576012)(31686004)(316002)(8936002)(2906002)(16526019)(66946007)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BrHPkGSXL+XQ+OJ6a65yG8Fbzcmynl9w/pMgjRXaSddOkMjOsYh9xl7WJtw+o4ARCFIEisfFmrkhVD50jF1IZ1gRomHmjYtV+0Wc74rBn8Vu6kBnE5ry5TWldG2iAgemovJ9wqQdTjjE5AihrOOEUK88ywPNmMOWw+RaDhmeLmK48KuohNKXnkl5K2i+AlkrA9cFizxrQfWvXoE1LthwINSrOvwWWsw4V7hMr94vCyjJ6SBROFvsVExaHCWNTAuSVzC0mxYmF9MKnTS6LtSHxWl7VmUT0m5cAXESc8euUYUsZHPHFLV9+7mdmPmXpaqR4sS3eL43z4uTQtkaZ5St46MtvSKGG9ueKvhMYntm0FrCZSgCj3b376AKSg0tGNIBCMeG/UDWEwpu8XC9rASoCriinH+R5KAfH1TLzmQan+WEQQaI3rLrGwtLxeVROb1xB1vkhr53F4l6Cz0qnhwxiINDWrqGavvBNTPGg/W10XRJnujvHzQMCl7zXwnQHSLoklpskOSwmqB8dHLiuhxmNXewD1CnCTPWPg94I+k7USoLk6OwsVxA1S3WO01yxnsmJlY6cTXErn6I/m7Kl68TyBlLUf3oK1DQpPQwKNn8jg/NQumFFatL26JIKF6wUoxvFO0biNZlPcZUTFEGBLi4rg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e7fe13-ba53-47cf-cc2a-08d879c3f68a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 15:29:43.8877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQ1y8X70AVhtH5E77bJ+7FFNo4kdtACp+JhJqLHP/bf9026d6nTVhlxj+eoVFJLcoVTS7rXO+EXq78JsIPHPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Alex Xu <alex_y_xu@yahoo.ca>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-26 10:30 a.m., Alex Deucher wrote:
> It looks this was accidently lost in a follow up patch.
> dc context is large and we don't need contiguous pages.
> 
> Fixes: e4863f118a7d ("drm/amd/display: Multi display cause system lag on mode change")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Aric Cyr <aric.cyr@amd.com>
> Cc: Alex Xu <alex_y_xu@yahoo.ca>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 7ff029143722..64da60450fb0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1564,8 +1564,8 @@ static void init_state(struct dc *dc, struct dc_state *context)
>   
>   struct dc_state *dc_create_state(struct dc *dc)
>   {
> -	struct dc_state *context = kzalloc(sizeof(struct dc_state),
> -					   GFP_KERNEL);
> +	struct dc_state *context = kvzalloc(sizeof(struct dc_state),
> +					    GFP_KERNEL);
>   
>   	if (!context)
>   		return NULL;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
