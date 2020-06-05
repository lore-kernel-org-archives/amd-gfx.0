Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55250C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F532070B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AnzcfbXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F532070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0BE6E112;
	Fri,  5 Jun 2020 11:46:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8F76E112
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 11:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQxUOQ59RgYHs2kk9KSGyydHm1m5Q3pLVMJoc7tYsLhClELNClhdny3hHGJoFZZelGP0jP6lCCjk4CAgTkMez7St1TM2AEN1Un3GX5hY7Gl0xgIqAhs9piZbInVz2dSJNBX/INGhSks7ptoWZuXpYldgNWhGAvhPgJ/IGiHs2KCXvDkg0RIMovT9DaW2wInO1RECa0cK/e44a+ef3BVr8PXt0UZNz8w3ahBVJ2K+lUWUS6nXnO4ZKHLDFMYl4q8TpPkJ4W8Rj/ZFvJgwIVbe4/fAXl936uFKvqZz/r+5kYRSBso8gCfF/h3s+YM4cJaQ5xctp4Dbvn7ctk5ChfpPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B67SSwGUNQObBrIM67G6hzHy5GPRLcFSz57MIyQnkgo=;
 b=KANwoOZ3eChMGLfydaGIcVzXEZSZ9Ac0teVt2ERXlK4aajiNRmdADTKBu4tesq+KtpDkwKXZyALo7aeYpvinFhT9apR2pnwZTUb08gO3BBwdHQakuS6svjHua6kHcNERdKnlturDfqdpQUuPjm0yvPwX3xGzW/Ti/FjROtfeVMvwkcVLJWG2iouLtK1Em7gSf5J1ENwloxuP6zLpN/pukamA84lH9lCz7kSSoGhd0IP5/217EXpwq//ft2mK6ZMoC9+9w48YBrrYK6phwsgjKe3vZMj87jrUvBmgmhuLtaBBemuEtE8z/dMAXrhWrS+hSVYVk69xIKcKs3iHj7BwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B67SSwGUNQObBrIM67G6hzHy5GPRLcFSz57MIyQnkgo=;
 b=AnzcfbXO6g9OwiJyCdRIGdG692b9fAdz9hkB7UEyexQGnfVi2HYglkVAuXKgbd9+5Uv68QU+86XSwJZyB3imnIIPd6sW3FUOiMqGYEd7tq3JHynpGD+Ge39qJYK7F5s3J7oZR1UkdLO2fBRBHQ9uP3Zqug00Ptd3hzx3BoufppU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3119.namprd12.prod.outlook.com (2603:10b6:208:ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 11:46:48 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3045.022; Fri, 5 Jun 2020
 11:46:48 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the nullptr issue as for PWR IP not
 existing in discovery table
To: amd-gfx@lists.freedesktop.org
References: <1591356897-26869-1-git-send-email-Prike.Liang@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <49782c13-e3ec-b431-25ce-bdce0c3ab8b1@amd.com>
Date: Fri, 5 Jun 2020 13:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591356897-26869-1-git-send-email-Prike.Liang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:208:14::47) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2003:c5:8f2b:1000:c281:bfdb:5843:3acd)
 by AM0PR03CA0034.eurprd03.prod.outlook.com (2603:10a6:208:14::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Fri, 5 Jun 2020 11:46:47 +0000
X-Originating-IP: [2003:c5:8f2b:1000:c281:bfdb:5843:3acd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 052bcc25-98e1-4a21-c3b4-08d8094620e6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3119:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31193AD28F2AE8F6953B14FE8B860@MN2PR12MB3119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d97cl/qEYExyykFfJvhrThOPUNxZ8xoJsDK4ld/MAnjgnCqYTR9hk8Kn098XgglHDHByyPhe8daOKc/r6Mrnipfka/DEHEu2VudMwSOlx4jjSPdqP2xagMp61n8Lda6EPE5hoIQ+3/wgKUujNGgMKVfCd0Zfhixrn8zTw8JzuEjVOdG4QzdWrrINx9n8QCDcS5jocEXlzDvUL7a3LGB412flkeocgn1Gf3TKsJj7LQ1RW+hpdksByz1gSQ01fzc4CiBkygk1hOjFzDSN2LxdainMEzIVmMNQJGSHREAOVmwcQpCaVGMjAww1p8XoUU4HjGeFD9VNn8TFv/sh9dEPsoA4n1/GnUz6T1YzRzAJ2C8DCECIfXuCgRjpCscLxbQc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(53546011)(186003)(52116002)(31696002)(31686004)(8676002)(6506007)(66946007)(66476007)(8936002)(6916009)(83380400001)(66556008)(2906002)(6486002)(316002)(16526019)(6512007)(6666004)(36756003)(5660300002)(2616005)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BeAmbvJKhH9QbH2gHhIkeVN8qrJR2F5L2VUwbAaPcKBVhqbxv4NW+ZXJV/CFEPW0Y4EmFEZfARQ+avgD/vB/wzSawkcX9x+q6hHnlXwnaZIQiJR3iQgg9Ne3Y+pA1QZ2eZWF05rsAMvA/DJcvlXIUYlQbw0kaLmB85HmUo7m6mhmQpfWgPjAoY24USF/fjcdG319ya/ah9YUhT8Hp5eXlk8kC6MR2WHd4C5iIalmpWcg/pmXvPRFNbE6/MyNkJzhe6YwVZ81no4jTFgeekd8rCA5IuLl6ZpyslW1a1OHlLRRTWjuoqOgeeIe7CFPIWw6wvW8pCFxqWl+7avrJ4ZWF6T3KKNYedUL4NljiOyPhBJPqoIP0soiBz0mTk0RVwU4ssUip+cSrSGhLTpJRBUtvP0rtfFgocQGUhlFNOiY/vkoUC8cHGc/bHIFhB5kFEt/2U78gPlbjNGdmTLgzg6uiSs5IpnSn/PDL2prWqpySZABbrKUiQK0yKH3jeyiBCLmCcm3Q51QL+48CuwyqBaVV2p44+fFI/dCAWj9lhPsxTI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052bcc25-98e1-4a21-c3b4-08d8094620e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 11:46:47.9698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzFmozQ0HnJVBF4ygEILIuNU0fbtVXK3E2glp2OmWLaQPwIi7+3Gh7M2aXa+ZXFr50kNVUztC5tRTScAb7V2yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3119
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


On 6/5/20 1:34 PM, Prike.Liang wrote:
> fix e467ab869f57 drm/amdgpu: use IP discovery table for renoir.
>
> This nullptr issue should be specific on the Renoir series during try access the PWR_MISC_CNTL_STATUS
> when PWR IP not been detected by discovery table. Moreover the PWR IP not existing in Renoir series is
> expected therefore just avoid access PWR register in Renoir series.
>
> Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 22943773..6b94587 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2856,8 +2856,8 @@ static void gfx_v9_0_init_gfx_power_gating(struct amdgpu_device *adev)
>   		/* program GRBM_REG_SAVE_GFX_IDLE_THRESHOLD to 0x55f0 */
>   		data |= (0x55f0 << RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD__SHIFT);
>   		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_AUTO_PG_CTRL), data);
> -
> -		pwr_10_0_gfxip_control_over_cgpg(adev, true);
> +		if (adev->asic_type != CHIP_RENOIR)


You should move that check inside pwr_10_0_gfxip_control_over_cgpg() for 
better understanding.

Otherwise Acked-by: Nirmoy Das <nirmoy.das@amd.com>


Nirmoy

> +			pwr_10_0_gfxip_control_over_cgpg(adev, true);
>   	}
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
