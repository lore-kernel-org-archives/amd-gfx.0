Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97547C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 06:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5BA20784
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 06:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PFt63h2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5BA20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D08C6E9CC;
	Thu,  2 Apr 2020 06:04:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F2A6E9CC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 06:04:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyOkyKUaMuAjkwBzKIzd65pFc/4DxKcgjF2me/xjo16pLuLIRw5UbZzZeApeqgbiOCLXJkuPxrqFQ24avIm1I1mnuuo7u+9bH+jgb3wrB7UlUp4fZdyGP+rb/azrn4pqspZiJtVWQjujqE1CvZxWhDf0dXLoPQnW3NmV8FqakXOPu1Fwwg2AkelyEENkcQhHCv1dzvXFeIHFaeLyMq854ruYq2VEpF4a4fj9twuEMEX1IUGzOugsjlOhGDdhv5RPiosRrhaaZRmU/1nnBJWEktNFJxMVOtEsnYhV3wo6FlTdq/SEekXMxxHo9IOHd33nqN0jMpDIZ6jYVOqj37DWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDqTDvuWAljuVjXpojC1Ajaq1FF8Jk7iG8HieoSGGrw=;
 b=oIZmzFVKKCZyvc2Jsj4idSDw5/glmSCTei+qBcb6ZETyRqkxWflR2oRS+eoGuAex/wqzz2RwOPlOKXmj2ZDZSwLqZ6ryVn4SD05J2ufJGrR1MIOlHllb6pCzmGpSIgXqEYJldck8bT/d4uxc983Iph4W3fOVYMc05eEqIDuAlmR9HUbNfD/jtMNyhseaEtf0d/rsVSaVb6q5bhRBhYwaVyfeC0eI9UdZ5yUZI+EI/ZlPX674556bVL+0tvBxg/qTP9yhGu3BupdrB2FBXKJbwqShXTXYHYEyizXPt/zRM+Z5NzIg8b/kLKATL+a6PBytDfydklrt9kbxXdDsdZscbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDqTDvuWAljuVjXpojC1Ajaq1FF8Jk7iG8HieoSGGrw=;
 b=PFt63h2UsfxjRcw/4uNXBp/VWNkNmsDDHZZO9kV9vQ9x4miMV1aBQ0AHEhVz3Ybkw3AMXa+xGc8Wn47S9m+QMiAgRB2jDn1kZr/YKvCZcrhefvaKlS/vIiJn0D+0W2D2IswVQdmHPiF+dMQce4A6W3LU8kK8opdOfv1TV5J/lTA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 06:04:46 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 06:04:46 +0000
Date: Thu, 2 Apr 2020 14:04:37 +0800
From: Huang Rui <ray.huang@amd.com>
To: Yuxian Dai <Yuxian.Dai@amd.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set
 the MCLK
Message-ID: <20200402060436.GA4832@jenkins-Celadon-RN>
References: <20200401114112.8372-1-Yuxian.Dai@amd.com>
Content-Disposition: inline
In-Reply-To: <20200401114112.8372-1-Yuxian.Dai@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 06:04:44 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9602fb90-b110-4d9b-123b-08d7d6cbbe73
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:|MN2PR12MB2863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2863050DC3FEF8C93AA262DBECC60@MN2PR12MB2863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(55016002)(9686003)(4326008)(86362001)(6496006)(66476007)(52116002)(66946007)(2906002)(6862004)(66556008)(6636002)(81166006)(966005)(16526019)(45080400002)(5660300002)(316002)(1076003)(186003)(956004)(33656002)(81156014)(8936002)(33716001)(6666004)(478600001)(26005)(8676002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fo54tA5lL6Ar2RbjgSkWh36f1xTVJdR4NNLY7h5EVUWAasa3Yy851zDa8NKHjVmjXkjUPwzmKPK6mU4R0SZi2Txgr79mcwcj+fI6XeY0xgPnZkNY9lwyuC9U8LQ1OL37bbAp41nclx5vBOxeFzaOvC0k6eF1gTv/GuI/33BCHVoz37DwQgmUJC7BeyGHlHqP3b1aCPgPKLBIS+A4qdHMq0Z/gGqNhMDKM4QjmLkplPB3dAudA27Ug7reWnqbAiFIpPBv5+HKCIo6VB1aY2LfaKVMxVfd1lKpCgIJFi+L9KBKqZKerw3a49uGKUbd/z6zfXotHXvaFiJVqAyFI4xw/K0Dn+E0b/D7I33t5BNT+Cg1SLkvTJOJ5a8pBjxPDIuVNVsmXWMjuE13PClCxPYswjKbumZk5W8GBt8mZKJeowrI+fwagjMTX4uiFpw1Q+czcwRlme24003LGCF8yxE88qWO00Y12o6C60ukBtgCoUQ=
X-MS-Exchange-AntiSpam-MessageData: Q7J8ufn+hkHCDcZRPXuS4fLjORBBgwH4Th/+vo4lqJwGm5Vt49ibWgyR42e7xj6qx+OGNHnQ8HNuyu8kc8C505lUy53EvaHkTNrW5xSFkZfDRvIJrKOV3ILJr/bmgdD6Y/M5N7Y4944CJT2DUwvpzA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9602fb90-b110-4d9b-123b-08d7d6cbbe73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 06:04:46.1120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dSycjYAa8Mj+Xj97x45O65E/wIgOfb2dCQbosNbH5zz3Kj3Nq170m+hZGNVIIL7/vM5rnrn7tUExiNTEfKWHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 01, 2020 at 07:41:12PM +0800, Yuxian Dai wrote:
> 1.Using the FCLK DPM table to set the MCLK for DPM states consist of
> three entities:
>  FCLK
>  UCLK
>  MEMCLK
> All these three clk change together, MEMCLK from FCLK, so use the fclk
> frequency.
> 2.we should show the current working clock freqency from clock table metric
> 
> Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Kevin Wang <Kevin1.Wang@amd.com>
> ---

Next time, if you submit the V2 patch, you can generate it as below
command:

git format-patch --subject-prefix="PATCH v2"

And describe the changes from v1 -> v2 in the commit message. This will
help everyone to understand your change.

Reviewed-by: Huang Rui <ray.huang@amd.com>

>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 6 ++++++
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 7bf52ecba01d..c6b39a7026a8 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -239,6 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>  	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
>  	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
>  	SmuMetrics_t metrics;
> +	bool cur_value_match_level = false;
>  
>  	if (!clk_table || clk_type >= SMU_CLK_COUNT)
>  		return -EINVAL;
> @@ -297,8 +298,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>  		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
>  		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
>  				cur_value == value ? "*" : "");
> +		if (cur_value == value)
> +			cur_value_match_level = true;
>  	}
>  
> +	if (!cur_value_match_level)
> +		size += sprintf(buf + size, "   %uMhz *\n", cur_value);
> +
>  	return size;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> index 2a390ddd37dd..89cd6da118a3 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
> @@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
>  			freq = table->SocClocks[dpm_level].Freq;	\
>  			break;						\
>  		case SMU_MCLK:						\
> -			freq = table->MemClocks[dpm_level].Freq;	\
> +			freq = table->FClocks[dpm_level].Freq;	\
>  			break;						\
>  		case SMU_DCEFCLK:					\
>  			freq = table->DcfClocks[dpm_level].Freq;	\
> -- 
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7Cfa81baf94d2c409e4f0308d7d6319a8f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637213381443101089&amp;sdata=LF2pLZj%2Fq0CwiMSfvDiofXFKuGVfgje7o4Iti%2FtoNj0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
