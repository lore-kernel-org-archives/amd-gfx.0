Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A8BC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 08:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1603F20732
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 08:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LiCO2Jqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1603F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1AA89ECD;
	Thu, 10 Sep 2020 08:16:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85E189EB4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 08:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDBpt8Z3xYFmHnl/0/XxO2NHlqg4ZCoQFeMNCSIiJ/HuCfAMsUaBmZjEMv4ZeoPHjiwsU279Reqj7p4S0xF4P+Dg7+ENZdf31iHc0xQJxgx6CRkxCje8RM56IZcXDb2fuHAdTHwRCmKnwxitvgNUXCOHF2i6PiTyEiV5T4NFf8qrbpkD4HdvUEwuvJk4tlpjMdOD+rgqBZTx07GgI0OzwPdZFewcd/IyaioyKu4bE/uVr4wZhQLUmmCibULFnvSDxF63ZG5lQ6LvYS48maC5pmQBoAkWtyYrtSLSdpX8fluC3NAm1s+la3+nv3Vv6ZBQ712ZtII/YTEITE07CWFWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu/+UIW0btJmdVLfSx+YG7uuuE41kuCfGLJeWreiCnw=;
 b=ZaMHtQ9tCBonRLirt8cZNNFkKtM9whDG4NVcgJbD5RdHbtKOdwD0kzk71cTyfCwnHAchY2C6aEYEDVufcmCeQTp9pK3oJ0Jq5SXcsm254OKbz3MWX2UNxtOx1Z7Z/GgUWcGwjNZkQCSAP4Q0SZq8x7uexWnD2cj6FuMtGBcHp1rUEtIpU/EcFMf5LvpTEcgDwyoe8fxdTwE49xqrHlyq8TyDiNBOOIpEk4f5mUxohCfQs4tIPzslcJ5n9PaDd/1eVkuJQqxihumzpQnMSoRI92VAzaGZ+ZO3TQivwttcQFpV6ae+SxWlAds30IxWk1oKy2qmPr+fGxfkMmfyqngnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iu/+UIW0btJmdVLfSx+YG7uuuE41kuCfGLJeWreiCnw=;
 b=LiCO2Jqiwrh8bn6zpNps0IFJtbDN3RPAd5O2ujK11Yw7dpOXgZgc3c1V16rcSx7Xw1oURNBE67WbT8haOoMZ5/8nFVT5ECZvzpmHDRFA/TA9yTh5uoPx+9v3V3pmkw23UY+iLjD1EAcoUEK6i1AGN0P1ljeBj4+pOsuMD/3T5HU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2454.namprd12.prod.outlook.com (2603:10b6:4:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 08:16:18 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 08:16:17 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: fix a typo
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200908155702.17314-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <bf70b0dc-01a1-9703-837b-8d64abde7409@amd.com>
Date: Thu, 10 Sep 2020 10:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200908155702.17314-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN3PR03CA0076.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::36) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.105] (165.204.84.11) by
 BN3PR03CA0076.namprd03.prod.outlook.com (2a01:111:e400:7a4d::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 08:16:16 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eac8ebc7-1213-4071-9771-08d85561ca96
X-MS-TrafficTypeDiagnostic: DM5PR12MB2454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24545A0F25ACEDD66E1326628B270@DM5PR12MB2454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRO2wrsvbXCND7bZJPQcPdEnA+KtnkKy4yRrA3W7jyBZ8g0VoL4MEV2g8+CnvNk4lM0KYoszaNPYvrWVfgn+X02swpqmS3Ey7Shp+MuYi68I5N/3jlTsiPsc3rDaqKszmaAKfB0b/YvPW8tmeMLP7EiT0hsPjzD5ajEMW1e+Roz9OTNsIP9oGLw+ugnFrRaR+epF0384fNePjLj2YaetjfivBwekyueJZz+UaBYQuhdDhDRnqLbA7DpmBj3kewO6YsDwlO5fRRcidn4zz63AIQl+Qmwr/vGCEC7MCB0NKWIQwWkeJVay86ugw7DbLrr2verOS4nxpxcVLtizrRjPKmzOfl6w4aZZj69ntoesVA2+lRIaShVm/2j3zT/zG+tH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(316002)(83380400001)(66946007)(4744005)(956004)(2906002)(6666004)(2616005)(31696002)(5660300002)(26005)(8676002)(66556008)(16526019)(66476007)(53546011)(52116002)(16576012)(478600001)(8936002)(36756003)(186003)(4326008)(31686004)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: b6rtIjESpR/jweg4lE+oKGpHO9Huf2Wd+O56Mpmwg37c+vdzt1y/A707r+h3KYbi1o6ylu4tMiRQxQlPrechqGbwvw7eCCtwWxQ1+FMGDugI55o/XbPPdNgyI7+rMzmugN2qkgVkmf3CrgVcjlslX6Y2bsJfTqhAsqHaGhkdRpGyXewnA64IelmTdsIhriCvsOB97zxVnXmpZA1RlinxDiNrvSOxYURw4EBCQebTYVq/JtS4Ok5+KkLLajBrARzq5tySGxDygj/39SxMpYcNbPjsJZGkyxR28pdugOwfq3/3+M908NiV3keogImfnEAuvG9VcpxisH9+O1Zp8mMTmGkhwg4MLQnii/k7wxokyUOZnIyo+yZBnREUW8VDX/m3QlN1vp8ahrtiH5z3dZf33CY+vq6GMMndgVosv/HKPYblvYIYJJYxLlGLagKwO+S7RF+1jJNfbbIis+hhIArySIr6dmLa/qdY5LeWslNAC1aYZY9S63L5F30FrvZG8LQHg8Ao9V/MmqGzp1V6byPskQdEa1PH20qgTyK1tkN6b8bg2tjiEvlhKMvLCkX+jbbXa9rtVYJaVHw6zAlaeJPj/FPSD67ELTOB93VXCvHB7EIJuZUJUoJhH0vVqaWmCCnnN6fXlffLs+FIAsyz8WDAxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac8ebc7-1213-4071-9771-08d85561ca96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 08:16:17.6937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNkd/OmTJHaLjlPGoZsj7sVc9P7qmQXjSxOU8JvZ6mRPOzI82q5LkAZ9qvxFEJwb4yN9GuFnTzT1VQCN7O9DRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2454
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
Cc: nicholas.kazlauskas@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping.

On 9/8/20 5:57 PM, Nirmoy Das wrote:
> Fixes: 9a0154630e958a2f (drm/amdgpu: Bring back support for non-upstream FreeSync)
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index b826f2d6efe1..d3dadf10b13d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1096,7 +1096,7 @@ struct drm_amdgpu_info_vce_clock_table {
>   
>   struct drm_amdgpu_freesync {
>   	__u32 op;			/* AMDGPU_FREESYNC_FULLSCREEN_ENTER or */
> -				        /* AMDGPU_FREESYNC_FULLSCREEN_ENTER */
> +					/* AMDGPU_FREESYNC_FULLSCREEN_EXIT */
>   	__u32 spare[7];
>   };
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
