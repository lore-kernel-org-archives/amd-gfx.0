Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9955C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 15:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2404207DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 15:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sdHU0A6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2404207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C27789B68;
	Tue, 18 Aug 2020 15:15:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A7F589B68
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 15:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0Ym7VCy8HiGI2ZDTvEds5KRQSgd946xnZ+ohU4/QXDcjflBoXqBwatLT3La7K13f0cFoz1W4Xw3pPlnsEhrfdunqjLCaWjzPj7zQfzrj9hknqO1/Ivp1p/T5wpjVpQkBljCXeSqxdF4tK72QdfIicONY+G3Mklk7wpohgm22U6c5JBXSZzKDLV1rZZ+eupd6p1IOzsGj5/g86MLP6J9M92Ve29QdQy4PQmAAixxbqtq83P/uIplzk3CKrLWpn0vFk26hHjWZx6p8KzeD7IfTPE6W9hw46HByaJYADjmhSIhyeVorPlKBcs0fiEVVHUCUtEo8PKPUpV7Nj2JlbgH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCstb7DKsLOQo2lVjuUpePRVVcVyW1JBoVYSSKHQzIc=;
 b=bVtaoEyISUFOwq1SYP4nr0+dRelSm+udsFdgBzq8sGliGSeltgjz+KwSBrj9hzYPdgJncEVriwFsElmNFhT7680mPtRmKRPa9TyhVPoW+fqiqynVOpzFSDugi/lmkKm8qtLXinbSkHbXECpwQ+wVYHzxQMbumIT68Q5s9vqEqkvASZ0RZC8XFzU52JmBWaAgj5r58A9DIB9Ed/Rllq3/lRH4ubcGhVO1uD2AuZTHpo//k7YJwkqvKv7djSDPpqKQc/7IU/D1W4fJqmGiEjm9pFPCKUPhTUTADEZjnb2a7efKjZQ1QtTs8iJ3b1Rcgwe1/uyqWaNmVaEFmK7o8FnLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCstb7DKsLOQo2lVjuUpePRVVcVyW1JBoVYSSKHQzIc=;
 b=sdHU0A6Lhmyjrb4JRai8dmYoR4J3C1yRVSVsB3Hhr8nJaleztFm3oIl01G0JK66G7J3YDnHc9c9pj11zbt4x1dPvyGeFNohMyBdqVu73tP3jP4GEV5HRmmALqLXA5GghVAIs/QIoO7jf4YcOBun/tw6dSAJejHkemm5yLG8mKmw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 15:15:48 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3283.027; Tue, 18 Aug 2020
 15:15:48 +0000
Subject: Re: [PATCH v2 3/3] drm/amdkfd: remove iommu v2 for old apu series
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200818130932.180114-1-ray.huang@amd.com>
 <20200818130932.180114-3-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5b0f4e19-d4e5-4c67-d4fd-22602d663ab0@amd.com>
Date: Tue, 18 Aug 2020 11:15:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200818130932.180114-3-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::44) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Tue, 18 Aug 2020 15:15:48 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de2a8e50-c6bc-4cfa-5c23-08d84389965d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB457323FAF6F6F34852CA83D4925C0@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez0C5lLFQvMiJD2uxhd/SLnRyUTsab2xextP9VoVmAI2/Oo1EB2VPoftNnPMFMQr+su8D98+roJNiB55+UJE3sCeBe2WHnRq5LsR4YTjX5GGZ8OKwhsu1TFjdmTa0n6iWIS08LkevFqsOHxkuZrPU/OwETCt1fmH1YeRhPI9JEgBoe69BuvY3mcR+1GHE6bO80xHAkIiZdKF/Jeo4awN+d6OZNQvXHvbdM64WXyd4NGyp0A4xyK5JO55u2xvdFwlBYT0GUrw+5OWORFRn67JB4oY8WmtPtjRYeupzaKOHbbdQMpAoVftqi+0LjFzTYHoXJnYYnIf+UkIW9ETU+wN+q2He0Rwh0KOsaQ0N0dYr+MhLL97oS+ilGh/Y+vdhYVx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(16576012)(66556008)(83380400001)(31696002)(66476007)(16526019)(8676002)(5660300002)(186003)(8936002)(36756003)(66946007)(52116002)(31686004)(26005)(86362001)(498600001)(2616005)(6486002)(44832011)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VHHuITq4XkbhP4ScwHRDu53eV6dAlcO8Ik3fBrQ4Mu8YgGVmgUJCiC2JJd45OSXMqPWP+7pQKoTOfkKrdx7ervmRzHy6mYBCDRJwfV+bLcq1Aw9yVDOGcifuRl2jQ6JayWEzUOwQkVWBjkoba6p6sAXtZxiLv5ppS4SFxswa6QLRO4tpPxlkBW+SnKf+2B16VEeI1lRVrvMMA8tAwtgprmyz3C8/Ck03mo9UTcMv8oxgUWr/q30DjE+LSzp9LldXGskWYdsCiG1VOFFq15CVqbcDBppfff9SPRfVftwmLCIx8gJlFCXMs3oRhzrD/dzsDnSpnZRBRDW3hwh3pnsNqrReOP3uZ8eTaCDwND4AVRyyq+zWz1eqEFq806DL2GhkU2nyyc9sdftQ8a4aewqNIC8SoI3PaAb9hdZO4dv+5Vj3oUs3FsjKlKoDEZB4Kwo0SrQ9cf4UG2RNs8bG7j/FaeucEr8W0ciW8Y35Be1wVuP7zLk9WPFgaqqzOrS7yjmiKr3C5whXLmBrrshbDv9r4OCTwe5VVvUFSYnDfaix5PjzXwfLzTClzD7X9j7Y7DFlYAZ+MyaVOH/G/+vTvAq/owXJ/HYQZH0yO37ENs3yhhPvpv8PasUJFe2Rz/hJcV+eGP0Vg96AC9FlXqW4Sw9Zxw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2a8e50-c6bc-4cfa-5c23-08d84389965d
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 15:15:48.6665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHcTm44AxuBYD8Ce6uoqAZfYXFdGpIghXkxWxote1w7IHud0WXhoNL3XBnZ/74fCpAkPHjn+vSyinL8uFTLwpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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

Interesting. Does this actually work on Carrizo or Kaveri? I'd like to
see any Thunk changes needed to support this before giving my R-b. For
now this patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


Am 2020-08-18 um 9:09 a.m. schrieb Huang Rui:
> We already support the fallback path, so it doesn't need IOMMU v2 flag
> anymore.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index dab44951c4d8..731f7fdfe9d2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -48,13 +48,11 @@ extern const struct kfd2kgd_calls arcturus_kfd2kgd;
>  extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
>  
>  static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
> -#ifdef KFD_SUPPORT_IOMMU_V2
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  	[CHIP_KAVERI] = &gfx_v7_kfd2kgd,
>  #endif
>  	[CHIP_CARRIZO] = &gfx_v8_kfd2kgd,
>  	[CHIP_RAVEN] = &gfx_v9_kfd2kgd,
> -#endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  	[CHIP_HAWAII] = &gfx_v7_kfd2kgd,
>  #endif
> @@ -74,7 +72,6 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
>  	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
>  };
>  
> -#ifdef KFD_SUPPORT_IOMMU_V2
>  static const struct kfd_device_info kaveri_device_info = {
>  	.asic_family = CHIP_KAVERI,
>  	.asic_name = "kaveri",
> @@ -112,7 +109,6 @@ static const struct kfd_device_info carrizo_device_info = {
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 2,
>  };
> -#endif
>  
>  static const struct kfd_device_info raven_device_info = {
>  	.asic_family = CHIP_RAVEN,
> @@ -460,11 +456,9 @@ static const struct kfd_device_info navi14_device_info = {
>  
>  /* For each entry, [0] is regular and [1] is virtualisation device. */
>  static const struct kfd_device_info *kfd_supported_devices[][2] = {
> -#ifdef KFD_SUPPORT_IOMMU_V2
>  	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
>  	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
>  	[CHIP_RAVEN] = {&raven_device_info, NULL},
> -#endif
>  	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
>  	[CHIP_TONGA] = {&tonga_device_info, NULL},
>  	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
