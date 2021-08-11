Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5DC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793A360FD9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 793A360FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5A06E107;
	Wed, 11 Aug 2021 09:46:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D0CB6E110
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 09:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPgTKaJCrIy2KTPVeOZki8jpvcRV9mC8mtT9jqMWm7gukJ31begdTn+xX3hLGtcU4pWDCzoWbBQ1lQhmc68aKSu0a63adUvvLlBvFxJ7BmzkTVon+rsFJLrSh8LxOiuL6uc6iVEpgZFs5KIuEooKY/ku5d3QprtSjHoRtwYFzguZgHhj2OBMoAh794W9CfHWRIdLxLDtHsRnByXn+lLukRWd+nP0ceewUmHcor+AkdxSCHCDUw4EGXthaLpw2OpEGdodKSffryTirZc1/RWB7CVBRgjKKM+4Dy5yUy4KyzCI6b5YKFyrULDJoF4S1t6vrAABoN6aJfyWdFlF6weN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo+9nacuhiEd0+hTANAIEUnQxGjjBzhVMllPzRTL87Y=;
 b=bXLCxQ9IAdnz3cwKyLIl4gaKO7a+zh2LyTQZCdNRZUQn871ln8xy7tpx7vH7iHHq2OC6DBeFjbA8m9JjSOC30+XrXzq12cf5SGyoj+V8daO82YkRSDnqPBTtzZrEt2FrKIBXMg836XhZ/CHpJyAX5M3x3/HvBox3+7gQ7BPXQMqj3gfHKjDRymcI/2Gb5T8aQIULfHPbctLWMpykz4y/f0lDhVCMN+qKC0WF6DrtB4CNmdlQeNhvj7CePK9HetfiQcvDIrGQ817/rKAQYH4MaJGFAvMF1tWuxBeRBQTjucRAdibyQL5wYkpYpKjhQKqkOMtnMbGWD6l+gmUM6FzIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo+9nacuhiEd0+hTANAIEUnQxGjjBzhVMllPzRTL87Y=;
 b=n1OsaXhpZ5sVGt7cMihPlS6xCkyNVH5TM5XnM0qc1lGK7TKUoQ6XzDuIH2F3CDgJ1CIFixenS8Cu1+w+/MHinSlhhDC4TuL6j202u3/1HNa6j3v8ni2quM3lxDRngsJnhk4RMTpXc+ytJ9Oy99x25LyyqApIbz6cBUDrrllgeZk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Wed, 11 Aug
 2021 09:46:44 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 09:46:44 +0000
Subject: Re: [PATCH 1/5] drm/amd/pm: correct DPM_XGMI/VCN_DPM feature name
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, frank.min@amd.com, hawking.zhang@amd.com
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <90420e89-350b-ab10-30ba-bd79d03538b2@amd.com>
Date: Wed, 11 Aug 2021 15:16:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210811083323.1084225-1-kevin1.wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17 via Frontend Transport; Wed, 11 Aug 2021 09:46:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a05659a0-8522-4542-2c0f-08d95caced85
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52070A7145B197691E3B8E8B97F89@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bji0vWcHcs1AWP6CO4hXyJAXi4GaP/fG7fcHirEm0O2tRc2g7S4Ra/6EfV837I6Pp64FgVh6G0mJAqoieHDj32Ium0pQHwVE5zqdV+G4vW9BZApfGlaGXRycOunh0UtNL8jrJBkhxCU9VKgbrnwQHzm5ih0aQUYlXigzfrpKjLE+yp54LQzWYa3BERzp0amwxtw7VBOnkuO5cTNXogely/P8sjABEPezU6Ta3X3rnyx7WEGiyZJEsuVIvN//WDw53q+cZgvIWtkoywDuyFH3DmyrXqrczkVnEncEooSEYqLHGQblhj1M8BN0xEvm3CfaYBFW85MN6CXXOj8/tVdUOqV8GcCPo3b5YJ3wLJ1Jw2Xv2VtS4VGZ9Px7IN8ytUR9EN4zS+PwPpsT04ndiztsYgwFasOqhtsRrlcf3Xh7zA/3S+JoW2vgDrMgQvN6n4L8Z48c5L2enJp8bPn8jKKPJ6dwjRcN1BUBEnbF2jCirkbvhHxZOY0x0p1xUmszAfnEmisHfd4AnWLxrMV3S62i8Vs+Xs85y8SNfCcY4GwruS5cLeDMcSL/CzXA8L1HLE53mJ01iIYuoDp6RIZG/3FqOE6SYDY5dAcvHz1eCfwFrlhItcPuyS0/5WvZGjcqkENTrrYgOnpCIVAG84nTbsMb/2XmoXX79HsGBVmbJZkREHPsasNaBzX/zETuprdHwgpQhIOwmtEukpcPxZPsTHdpNgRHyp6d6IcPWXIx8PmGkbYolJAbwm2PNhl2XGpkR5K+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(8936002)(6486002)(53546011)(316002)(5660300002)(478600001)(31696002)(16576012)(6666004)(8676002)(83380400001)(186003)(4326008)(66476007)(66946007)(26005)(31686004)(86362001)(956004)(2616005)(36756003)(66556008)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXlmWVM3SkoxazRoWWhQRTNCeURWVkZNOHl1czcrUHdlY2krV1ZpODN2aXg0?=
 =?utf-8?B?VVVoNVl2SWNnSTgvZlRuOXhoNWxmMlliVW82bGc1ZnhlY0NHV3lacUVCL0Vp?=
 =?utf-8?B?RWd6ZFkrRHFERVpWdmkrS0JrdlFSV2xVT3hOK2JYMWxmTXphU0lMYkQxNEZz?=
 =?utf-8?B?eVJBWXU1SWVaTENJZHJJL2xkb3paaXJWVWhUZXFySllTYWVVRmdNWmUwS3pX?=
 =?utf-8?B?NjdaOUFtZlVoSjJZbkRSY3NuUnV6MllOQXNrL3lKeUNNTEYzUWh1YXdFNzFq?=
 =?utf-8?B?YjRBSlkxQmpWYk5pMis4ZTllV1pCc1E0djdkMFdzNUVHdDhKd0pkbW5kL2xX?=
 =?utf-8?B?RndXK29vOUQ3d0toU213UHV6b1lPV3FMNWNuL00vNVBsSWhEVUJsRit0dTRj?=
 =?utf-8?B?N1NHdHBWdFlKU3hLMU1ScjJFaEQwYUpONlYySHhVUld5SE54a0gwbDdSUVpY?=
 =?utf-8?B?V0JuODJMVzMwVjQ5aXd1ZWVhZVRXcERlcCtpTXVjZEtCVWxaNmVWa216Z2Nq?=
 =?utf-8?B?b0RKb3FwQ3MvY0VsbFppWnA1ZzlDN29tdWlaRmh2N3BTWW5xczlhSkVZRnRC?=
 =?utf-8?B?cE5ITVQ3TjBHaHl0cURycStVT1ExM1lDdG8wUm9OWUdWM3oySEY1cHRNUkY5?=
 =?utf-8?B?SkVrakh0ZkxyejFFSkoyTEZkak5kYkJHYng4YnQwMmxMbnZTUEwvU0tkUmNL?=
 =?utf-8?B?T2Q4R0FxanRFVFI5ZFZ2QmQ5QzBiNVZJN0JDVURQb091WWtJNzJubzBwTTBU?=
 =?utf-8?B?Uk82blJzdFZteWRYOUVtOHlPc0pJdjlSellZYllKOXVOaG5VMTdQbXF4eUlJ?=
 =?utf-8?B?RUhOSzFEMytpSWo4Z2R0OTZRZUZrRFlPWkN1WnJkYTVHeXA4V24zL0xIYXp1?=
 =?utf-8?B?Y2tONjF2cmJsZHlTN3FqSm1YOFNtQytTWlV5UlJiVTVYRTJpMkdMWnkvWTFF?=
 =?utf-8?B?VXlGOHB3aVR3Yjd6NStNbEd3Q3ppc3AzK3U0SVFleDVFZXBqNEtKQ3dsUEpy?=
 =?utf-8?B?Q3ZnRG85L05pTWtud1djS2NwRWxTOXU2MUVRRDJuekwrN3BvaHcxSk15WWJq?=
 =?utf-8?B?cGEyZG51MWs1M25MdW1DaHg3bFBlSGhkdHV1NXpGSHVnWjduRC9XL3Ywd0NW?=
 =?utf-8?B?djJoRG5Qc3U1UmU5SGtSazRDTTh3alhiNHhpV1NYM252anltT0NPcmxsMzRl?=
 =?utf-8?B?T2p1bldTbkpHdmkyK21BT2NOeGhaTWY2d1lZUWdmSCtXT0hQUFZRRWtkK3lZ?=
 =?utf-8?B?TFQrVE9ZeXBHWUh5Yms3S24xbmo2enBCTTk1SmhiWjV1VlZMcG1SRmwrdjBr?=
 =?utf-8?B?WWZSWXlOdzcyWHROL25UZDlUWVFmTE5WbVhFQkR0bk1kcUlCSTg0QVJkRitP?=
 =?utf-8?B?Nml0Rk13QXN0MU05Ukl1c2tzT3RwelFMdktEZFdmRCtVc0JEUGlpenVUZWlD?=
 =?utf-8?B?RDVuVHZZVmQ5UjFDYWlnQWx1YitxYjZrbDZ2emY3M0p3TFpzU2p2SWZqWmtk?=
 =?utf-8?B?dytmQVVudXkvdml3OFpRMjNWVm8weFltdUpHejFQQkhGaDVKSG1saHNXL215?=
 =?utf-8?B?NEtlSG1lc1hpRyt0dnRqMWI0UmgxdDZwMlVUSVZYbHJXRjhNc3hQYXNBbW04?=
 =?utf-8?B?TFp3cGpCb01QeDVxeUNKdXE1eVBFa1Y5RmEvSHBISTFCMDFLaDJWMkhSNFZp?=
 =?utf-8?B?SGdFVnlSM0ErYnJleUUyK0dySFh6MU9vNUdJWGZ3blBLQWE0cDk3NEdQZkRl?=
 =?utf-8?Q?GqAocZlDH3vS29/ZPgOpidt+U2TJtyAOoKjcJiX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05659a0-8522-4542-2c0f-08d95caced85
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 09:46:43.9988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/S+KD77o9II+Mfe4LIzDCGjTGZlI2qEYwMVxr/tKSci5kJtj/9Sy2+k1PsjvaBE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 8/11/2021 2:03 PM, Kevin Wang wrote:
> the following feature is wrong, it will cause sysnode of pp_features show error:
> 1. DPM_XGMI
> 2. VCN_DPM
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/smu_types.h           |  1 -
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 16 ++++++++--------
>   .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   |  4 ++--
>   3 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> index 1d3765b873df..3fdee6cf01ed 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> @@ -297,7 +297,6 @@ enum smu_clk_type {
>          __SMU_DUMMY_MAP(DS_FCLK),                       	\
>          __SMU_DUMMY_MAP(DS_MP1CLK),                     	\
>          __SMU_DUMMY_MAP(DS_MP0CLK),                     	\
> -       __SMU_DUMMY_MAP(XGMI),                          	\
>          __SMU_DUMMY_MAP(XGMI_PER_LINK_PWR_DWN),          \
>          __SMU_DUMMY_MAP(DPM_GFX_PACE),                  	\
>          __SMU_DUMMY_MAP(MEM_VDDCI_SCALING),             	\
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 6ec8492f71f5..b4d98465bb36 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -163,14 +163,14 @@ static const struct cmn2asic_mapping arcturus_feature_mask_map[SMU_FEATURE_COUNT
>   	FEA_MAP(DPM_SOCCLK),
>   	FEA_MAP(DPM_FCLK),
>   	FEA_MAP(DPM_MP0CLK),
> -	ARCTURUS_FEA_MAP(SMU_FEATURE_XGMI_BIT, FEATURE_DPM_XGMI_BIT),
> +	FEA_MAP(DPM_XGMI),
>   	FEA_MAP(DS_GFXCLK),
>   	FEA_MAP(DS_SOCCLK),
>   	FEA_MAP(DS_LCLK),
>   	FEA_MAP(DS_FCLK),
>   	FEA_MAP(DS_UCLK),
>   	FEA_MAP(GFX_ULV),
> -	ARCTURUS_FEA_MAP(SMU_FEATURE_VCN_PG_BIT, FEATURE_DPM_VCN_BIT),
> +	ARCTURUS_FEA_MAP(SMU_FEATURE_VCN_DPM_BIT, FEATURE_DPM_VCN_BIT),
>   	FEA_MAP(RSMU_SMN_CG),
>   	FEA_MAP(WAFL_CG),
>   	FEA_MAP(PPT),
> @@ -721,13 +721,13 @@ static int arcturus_get_current_clk_freq_by_table(struct smu_context *smu,
>   			member_type = METRICS_AVERAGE_SOCCLK;
>   		break;
>   	case PPCLK_VCLK:
> -		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
> +		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_DPM_BIT))
>   			member_type = METRICS_CURR_VCLK;
>   		else
>   			member_type = METRICS_AVERAGE_VCLK;
>   		break;
>   	case PPCLK_DCLK:
> -		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT))
> +		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_DPM_BIT))
>   			member_type = METRICS_CURR_DCLK;
>   		else
>   			member_type = METRICS_AVERAGE_DCLK;
> @@ -1916,16 +1916,16 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
>   	int ret = 0;
>   
>   	if (enable) {
> -		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
> -			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 1);
> +		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_DPM_BIT)) {
> +			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_DPM_BIT, 1);
>   			if (ret) {
>   				dev_err(smu->adev->dev, "[EnableVCNDPM] failed!\n");
>   				return ret;
>   			}
>   		}
>   	} else {
> -		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
> -			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, 0);
> +		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_DPM_BIT)) {
> +			ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_VCN_DPM_BIT, 0);
>   			if (ret) {
>   				dev_err(smu->adev->dev, "[DisableVCNDPM] failed!\n");
>   				return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 856eeaf293b8..97cc6fb9b22b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -156,14 +156,14 @@ static const struct cmn2asic_mapping aldebaran_feature_mask_map[SMU_FEATURE_COUN
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_SOCCLK_BIT, 			FEATURE_DPM_SOCCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_FCLK_BIT, 			FEATURE_DPM_FCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_LCLK_BIT, 			FEATURE_DPM_LCLK_BIT),
> -	ALDEBARAN_FEA_MAP(SMU_FEATURE_XGMI_BIT, 				FEATURE_DPM_XGMI_BIT),
> +	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_XGMI_BIT, 				FEATURE_DPM_XGMI_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_GFXCLK_BIT, 			FEATURE_DS_GFXCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_SOCCLK_BIT, 			FEATURE_DS_SOCCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_LCLK_BIT, 				FEATURE_DS_LCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_FCLK_BIT, 				FEATURE_DS_FCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DS_UCLK_BIT,				FEATURE_DS_UCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_GFX_SS_BIT, 				FEATURE_GFX_SS_BIT),
> -	ALDEBARAN_FEA_MAP(SMU_FEATURE_VCN_PG_BIT, 				FEATURE_DPM_VCN_BIT),
> +	ALDEBARAN_FEA_MAP(SMU_FEATURE_VCN_DPM_BIT, 				FEATURE_DPM_VCN_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_RSMU_SMN_CG_BIT, 			FEATURE_RSMU_SMN_CG_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_WAFL_CG_BIT, 				FEATURE_WAFL_CG_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_PPT_BIT, 					FEATURE_PPT_BIT),
> 
