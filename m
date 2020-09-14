Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F29C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 16:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DDF206A4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="edt+P24w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DDF206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA596E4E3;
	Mon, 14 Sep 2020 16:23:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F216E4E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 16:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtlW1O0faH96TFs+kdcD6mATo4uOc3Jes0J6d6lMzTFR3cEhPTpB2cDfP+QVm5INU/plpkVxXZjnIWeRPs3EByGZQzeuHt252BAeJOL9Yr6NvNE7EcqdQohYHZXSXue88y6mCIYw3U479esYMCLI/OwOmYY33W46ZJ6sFfPxAjnmYaIihXvduK8iGn6O5Hakqz2BCCTvc1hBpAEU7CHTL2GJpsxiUB+DbPsWJHVmT5tX7cyXBDqL1NDJbhPdERdnnDTZQznH81ebIhjhjSU/iVFkl3H1imGmtP3rN1bFcYERQ7yYDBkSaUrxdQ4nS0aLseziy9cTqCXX30uASVmImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEnNi2Feb2cJ9H8PsEiWiNyzUiEyb4L/fy/XkhlX0dQ=;
 b=QD/6GbeVpOgteGARVYMLicCzcpK3Nf4NYtQjBr9RxikoYu0djmTpjDjJ+zG9JDyFH//kF0ckwNHltvD0By4lCtheUiL/FTAJHhtsP7J0n7u2PYAT1VvKi6yMGrL6VbPEFoiFl0+gYqjY3w6OAoxF5I1qmDLVg0yrZgauXNeQ6KHCVdRePxZOhSh1KsAYtiZNd5tacb9XuCpKEX+oWCtuZfp9OJR8wtY3vjsoBc/PyPL0vAfjFoNt5Ep1YJOcgLE6tc77emxeeOvNkIu7bPYgVCwDQH7BEj+HDTB5HZkPju8nBuN7fy6Xlh8eRGIVCRaoAC3zg6R1lKKVyrCUTGaLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEnNi2Feb2cJ9H8PsEiWiNyzUiEyb4L/fy/XkhlX0dQ=;
 b=edt+P24w3gG0ucubqSWMB7khuQPUPDWe7jCzztsd6Ae2u5tGODNEZBtiuoca9u57dtmDAYPQZ8DAlJ+JVtT/v1WbSPqJctS4vmdS6h7ao+4D1moCS8G22tZTNZ/a0NlsFq+HIMr7YTkgj/Ru0U0KlNGwXP/QXzPm+CnjnYbMCGE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 16:23:32 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 16:23:31 +0000
Subject: Re: [PATCH] drm/amdgpu/gmc9: remove mmhub client duplicated case
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200914154250.17345-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d2618eb7-055d-1e50-33fb-e6e20a815852@amd.com>
Date: Mon, 14 Sep 2020 12:23:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200914154250.17345-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 14 Sep 2020 16:23:31 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57fb678f-4625-46f8-72f3-08d858ca854c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB459207744541435617CF9E9C92230@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cts1elw3NOAc5hreBzI7VG2eaVsH9wLAWKxBundOs0hGlSrhmAPWg4+1RPQzlGPuR3qkU8q3QythvBWeGjIcx1NEDPrEBSlIqRcrFojBAzOjKbquHrAfKI1CXhbm5Gi3Sow89YOygnaT42MFpHByaRJSXF/jlTUWXZNFqHk+fIWgEvmMLUl6wygDkbxtfXkHf5PyxA+eBnAwJ7NUA4bMxZEWmk5RZi2/gDBGuRtfJfQ0b9Cmai/KaLRWh19Y/QLrMSCCy/B2D/JsOROB+iQBrJjBjja7RnpF5nyvmv6fr7/MRbCo6OjvlApf58q8H58y1BwCisjcfbFtvbtw7gqe1cz07swbzH2tZogxfBfV9LC/AK7trP3/q87SiLEtJWB2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(8936002)(52116002)(44832011)(478600001)(36756003)(2616005)(956004)(83380400001)(66476007)(4326008)(66556008)(54906003)(8676002)(31686004)(66946007)(31696002)(86362001)(316002)(5660300002)(26005)(186003)(4744005)(16526019)(2906002)(16576012)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: K5l3d41KEXNAbw0pQ5ZGXhTHCQ9o3jaywU8sO/obxizMMag1mq61THyIBj7E+yly/DIxMif0ofLvUNBsJjJABynWFo8W/wSxNhSKrHAZvdsiZhyeDXM7XuN499xELheNtvlBWS1rw/b1PX5IPdHluE8a/yYjNPAnVwru9oB22tHXtGOGxvRDxlMrrT+O9gFIgUi6ZtHmfwZ1CinGIV2GHi7ji9BJTNb5W/ZoUzwoItlTNhQA1XWp+n9sVS2tM1LpdZeVpq9k5xCxlPICMXtof8fT1rcdsgNWzvB7hGDKKZ9hoH1YRFOQ39fjg0/6q20G9+Z2bkuHS55lzReHIR7xZSrmKCBS+FV6YYcYgQLQAibXQqZD9CICGYWkczOGBAMPI6XmNYTdEx88PplCXzFJjPnKIB3aeKlh59xDXFhRvMfQULSEb8nhveBq3FWNEat9M+SljcQzIRZD4kMLnzaHzgs3HG060J0pumEiPzqTLCZkBkxdm2DjmhJIYdAEhbp4+24saMLMpasAWHN3b0TvyF4Io7MXIFuqBlTxQgeSvfGnlCyo2CkPDZr3BWVbOAWAcTkyE956kQ6ySY6GQMohDaGUzuRJCUGaniXpSMZbzXLco+76/73NnEEL9AiFclOhYF/RoyOrdTyun4ZUfPE38Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fb678f-4625-46f8-72f3-08d858ca854c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 16:23:31.8871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqsNNu/uQwLQzOSDDkX/WjsdOzhi2eekCurENH26I+cWSIEqDMz06uxv+3edYFrb0Sr9+2uU7rMA4Y5sFK7rHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-09-14 um 11:42 a.m. schrieb Alex Deucher:
> Copy paste typo.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index d0645ad3446e..2bdfc861028a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -269,7 +269,6 @@ static const char *mmhub_client_ids_arcturus[][2] = {
>  	[14][1] = "HDP",
>  	[15][1] = "SDMA0",
>  	[32+15][1] = "SDMA1",
> -	[32+15][1] = "SDMA1",
>  	[64+15][1] = "SDMA2",
>  	[96+15][1] = "SDMA3",
>  	[128+15][1] = "SDMA4",
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
