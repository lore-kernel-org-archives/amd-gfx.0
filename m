Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40530C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162562073E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t4QqsNdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162562073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C853D89BD4;
	Wed, 25 Mar 2020 15:41:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B41A89BD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjONOTU7pX+QlwRfvjDFdWmyV9Lv91wnV2nS+/cdaIhbrn9SOzIq128+n/lTLUzSn09AXKeWIVUlDfNHY9wNTiJaKF8lb6VoGzSEbL1zAZoACfZdR2k5DYmdfqZktq7iytWLP5JO+P01vJa7oT1HTr/8sl6lDMRmrPLlaV1Iwjb7atH9B860nJgf/hmc2xbyO8PkcWI0eeQlKsdCquXgVW7746icdC7Cp7mCILD2mT/r2FM/evTX42pWfuazKaTjxuTlvk6+oYqW7VroseyItlsc8rwNZbP5HKdUL3Efv/RhIqBqAgGxZUKVYBZZdLmUSAd6IWxzJkfitoOgtvnZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5Q4rf7o+raDyMH14XJSaHmkSwMzFKrk8b8ilrjaaz8=;
 b=dGq3FLr9XWjHY7xGrsnaJSsEJ99BbBi+EpI3nd45D5wWUCY0yPIJ/VJh7GBMbcBMYNB9QEEBnHp5BYnWChNxsWbW29BmzvvehH3QNjs591pGUBSI5tdZYe65iThxHCr7Rh2b1gFB3sGGXlwxJ7Q54vqBK0lTs6ImSUtfj+0kZh4WsdNf9Ftl767AoHv9+lixL5/4eLdG3KgD+g0WHYmfGPzgHn/Wq1rrhrepfFbveWSKed+zzsE935PomO4hpH3W4h9ZmpZC3S6C5QoHHcvjvZw5EevFVmx7HR/ZETSGXZmtWULIm5xwbmV6EOuT9tmuqE8vB2jBiNq/2ns0xxHrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5Q4rf7o+raDyMH14XJSaHmkSwMzFKrk8b8ilrjaaz8=;
 b=t4QqsNdIIuNRG6XPFj1WRNxoio3K6/GTnLbZvAJq9fK2r+yoEMJtxxBAmbpe2zv9QUnsl/DhuyiLpMcvzYmc0tTNztsB5V4vCCSrH634WsQpdzJ6JaUFjsHBWRvCKKQ42qNCBwEAQ9DzUBRMKg7/CwWVkfIdv/wCpHSmpTna3U4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 25 Mar
 2020 15:41:22 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 15:41:22 +0000
Subject: Re: [PATCH 4/4] SWDEV-226663 - Ignore the not supported error from psp
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
 <1585125181-14195-3-git-send-email-Emily.Deng@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <96bb94f5-dc6c-5580-f1a8-65f28ed697c8@amd.com>
Date: Wed, 25 Mar 2020 11:41:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1585125181-14195-3-git-send-email-Emily.Deng@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YT1PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Wed, 25 Mar 2020 15:41:21 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba91d5d6-8d1a-4224-5c95-08d7d0d2f859
X-MS-TrafficTypeDiagnostic: DM6PR12MB4188:|DM6PR12MB4188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4188A3BD54B718DE08E6967899CE0@DM6PR12MB4188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(316002)(2616005)(956004)(44832011)(6486002)(31696002)(86362001)(8676002)(8936002)(186003)(26005)(81156014)(6666004)(81166006)(16526019)(478600001)(66946007)(16576012)(2906002)(52116002)(53546011)(36756003)(31686004)(5660300002)(66556008)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4188;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piOoj3vqC92DOKVrYNuaOuKYZ6rfYYtFSXdA0sRhiK7URjlLRV0PXqNxQOYIqEugi9vzvbooF43nmEEDinuXmmzcwvUC7C+864F1JirARjPGmN7uEOZSd3JLbZb+6v6tvemsqXOOAvlJGzZO4znkop3vqg055oAniSTagf47sQeB7HVJaeC7sCJ/UN8cjAqcVmg8vXhoGfdjRxCj1zuBEQRw7Y/dakL6FihnhEphjK/u4jIHfRoNCsoC8zITDGLCaiICkwWBUN1zT9zvRyQSTk6wV3/A0zj4JhgRRObNW8RoluS2+SsD1Z7ylT9trYJaRdqXXadrq1S8emgDvAmDj+yyi9Kn5rkgEugm2BVW6sWSg4mwwa9WeE2LxG8TW+QEvZcKOErNARMdnkAAAvi0FPH01dIt71Zbcu8nZ/th3oucfn4F3QlyfZs6sIbACMu7
X-MS-Exchange-AntiSpam-MessageData: w+Iqdx0/dzYaebkYnxvI9XD3xePyyaSK7J1ByDF2uSU9fZEQ2mwfhyPzZZcnBXPQK6rzgpqIM97tf0ZHnM84uAoPZy1X/RdVkQOKK6eBEQ0KtOGFFU3Z4UnJt1cFlPNaKaqt3K7RAVMjXHiC+xfvGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba91d5d6-8d1a-4224-5c95-08d7d0d2f859
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 15:41:22.6049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kNNsfBAWGL3DC3LTlXB+ppq3xjt1FceBn0nSJsZg66LnDKmXp2em2Kf28tDJiYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-25 04:33, Emily Deng wrote:
> As the VCN firmware will not use
> vf vmr now. And new psp policy won't support set tmr
> now.
> For driver compatible issue, ignore the not support error.

The line wrap is a bit off here.

> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c2bf2d9..1a46050 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -205,6 +205,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>  	int index;
>  	int timeout = 2000;
>  	bool ras_intr = false;
> +	bool skip_unsupport = false;

I'd name this "skip_unsupported", or "skip_unsupp".

You shouldn't have to initialize "skip_unsupport" to a value.
Leave it uninitialized. You want the compiler to warn you
if you're using it uninitialized, and show you the path(s)
where this happens, so you can check the logic of the patch.

>  
>  	mutex_lock(&psp->mutex);
>  
> @@ -236,6 +237,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>  		amdgpu_asic_invalidate_hdp(psp->adev, NULL);
>  	}
>  
> +	/* We allow TEE_ERROR_NOT_SUPPORTED for VMR command in SRIOV */
> +	skip_unsupport = (psp->cmd_buf_mem->resp.status == 0xffff000a) && amdgpu_sriov_vf(psp->adev);
> +

It's unconditionally set here, so you don't need to initialize it when you define it.

Regards,
Luben

>  	/* In some cases, psp response status is not 0 even there is no
>  	 * problem while the command is submitted. Some version of PSP FW
>  	 * doesn't write 0 to that field.
> @@ -243,7 +247,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>  	 * during psp initialization to avoid breaking hw_init and it doesn't
>  	 * return -EINVAL.
>  	 */
> -	if ((psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
> +	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
>  		if (ucode)
>  			DRM_WARN("failed to load ucode id (%d) ",
>  				  ucode->ucode_id);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
