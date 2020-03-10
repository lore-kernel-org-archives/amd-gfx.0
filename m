Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39EFC10DCE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 20:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECFB215A4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 20:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MzOi7p9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECFB215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B20F6E39C;
	Tue, 10 Mar 2020 20:03:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257246E39C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 20:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM8+2gPdA/J/HAXASrGJNT4GRVk0fNwtixVeRXu0ioM8upu93tLK4Rvbb1A9o5RTptd4vefMRZ0rHOm1rCZg6GRkHr5PkDG26sKzgq/yNn6coQRtC6PuUBJKzFTcyowdHT3PqgBdWHTuUkR11EjxCsP7R6Fd3vdemywzPOmYxRA+e2XfEirbBvCV++tF/m/urwmMaWDUTbI388seyh22Ivz2do62CAT7eWJU2DY4EgxoCFXF6Ytgm4gBCHVIVs/L8MmWNPCXQS2nJTtj5+mSScqDTbzJw8evs0jZQXhbHMKaWL1m6r4vstNczuaw2uVFzD/VAYZj5+nNs/xxl/lA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF0tSQxfZwhPph0laSm1CfkpDKVPPfJSVAg+bHu3m8o=;
 b=do9tAVEGvdpOfLWW7H1am3T3kxQgYDyKOv2uv7QRUT2j0v781NDpoI2AhjH3Wh8ERai610EhXW9uuy04rLqozK+rYqqUB0xEicZTrlPAsFdOLiVgfXdCtZTS5taYHhvy2uQ9AcE9JKmKq0jv/dYBqtDHCD08/4HoJU7/DWNs5JyfFyYVDfO7BQtZhjiDNSl2CYbLT+6j4XwbCKx2NQWmBok/5yqRPUFuMQ5ar8vHCdpehxwsuLwwACUDGqEpxkK8PBkN+PLxNjZmfg9g5T4WKL8XGPkN33M8teETQInyP4H7ZT7z+qsz0AzFI+pulVEwDOcOPy6k7plswfIzLo4kPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF0tSQxfZwhPph0laSm1CfkpDKVPPfJSVAg+bHu3m8o=;
 b=MzOi7p9l16P8RZWRbO6HXyqWSZzmZQils8qt81EMIawcWTXjEqCSv3T/9QK2z+ylrzSVTynDfjNn6p9UDCsUuUIWqyAUsh1wen1WdJwE705iiUy+ZOUL7qeMdupkzbCwRHq/b/N5FDp40eGfYXpmwb0K4Nl8OugNO807+ShapqI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Tue, 10 Mar
 2020 20:03:42 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:03:42 +0000
Subject: Re: [PATCH v2 4/4] drm/amdgpu/vcn2.5: add sync when WPTR/RPTR reset
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583259391-21834-4-git-send-email-James.Zhu@amd.com>
 <1583870280-13102-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <3a0435e5-b8f0-66c5-0437-81cf82415ab1@amd.com>
Date: Tue, 10 Mar 2020 16:03:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1583870280-13102-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::27) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.228.95] (165.204.55.251) by
 YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14 via Frontend Transport; Tue, 10 Mar 2020 20:03:42 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73e8c5ed-12e7-427a-1424-08d7c52e21d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:|DM6PR12MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27800BF8F4ED3D17DBACC9D5E5FF0@DM6PR12MB2780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(26005)(16526019)(31696002)(66556008)(66476007)(86362001)(2906002)(81166006)(5660300002)(8676002)(186003)(4326008)(81156014)(66946007)(36916002)(52116002)(316002)(6486002)(956004)(2616005)(31686004)(478600001)(36756003)(53546011)(44832011)(16576012)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2780;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +E9U1MzoaR4ye5C/Q5t7SgPBevzkDX29t4hg0C0bwd/1vQqrh72FXzKozY3el4NJ4kTHALNSvlPo3fw5Tdofg7fGRN1AJjq+wwrqTfKnHOe8MgMGb0aPWR3S1zwNyGHbW8X+jRVO6ZOH1fpcyD7rLaf2Pl1iIK1cI0/hSirlpPo9iuQi6P6JTzAasuzsPcHafQkAenehavQVKAXDaDghRScRCiaC4mphoJWUVnIPoy/EnzpqhVe18rYi5yHao6dZXoF4sFTw/7yl83KbqS4/VQW0G/v8ZU8pINRe+84LaHa1IuLIlJICqJs7klmuBdiip5xaqR6X6La7lxMn6YnZ6rfT8TrLbpILJ7jEfZZfxUiKMsEe++Pm2H4P/fh3e9zkE5c9gR8ShRzUC1alfQy/2PBrB+znhGyVfsimgGXK4ZsyZ+s93HbWbadO3mnfvnIq
X-MS-Exchange-AntiSpam-MessageData: 7i9Be2ssYoPQo4rzpvRPu5sYnFEn0174PzObZg1RDfZJ4Pg7QPdGJetWwVyDxrRGl6yesyBho4oHRr8MdhUZSkkVS9E/QftjK9DF0EnO12o/Tdc1BRwtujxrP8H7jyg3SjHbeQ+inNYmDnktHK+gmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e8c5ed-12e7-427a-1424-08d7c52e21d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 20:03:42.4222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8RDS0Wuo7xOksbZ6H3B8bA4nXOV3j5s8+NEM/GyQj48rVMonVxnYKd0Xlng63WR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-03-10 3:58 p.m., James Zhu wrote:
> Add vcn harware and firmware synchronization to fix race condition
> issue among vcn driver, hardware and firmware
>
> v2: WA: Add scratch 3 to sync with vcn firmware during W/R pointer reset
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 2d64ba1..9480039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1034,6 +1034,9 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
>   		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>   		WREG32_SOC15(UVD, i, mmUVD_RBC_RB_CNTL, tmp);
>   
> +		/* Set scratch3 to start dec/enc registers reset */
> +		WREG32_SOC15(UVD, i, mmUVD_SCRATCH3, 1);
> +
>   		/* programm the RB_BASE for ring buffer */
>   		WREG32_SOC15(UVD, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>   			lower_32_bits(ring->gpu_addr));
> @@ -1059,6 +1062,9 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
>   		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>   		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>   		WREG32_SOC15(UVD, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +
> +		/* Clear scratch3 to finish dec/enc registers reset */
> +		WREG32_SOC15(UVD, i, mmUVD_SCRATCH3, 0);
>   	}
>   
>   	return 0;
> @@ -1388,8 +1394,11 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
>   					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
>   
> +				/* Stall DPG before WPTR/RPTR reset */
> +				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS), UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);

You can wrap up the line shorter? With that fixed, this patch is

Reviewed-by: Leo Liu <leo.liu@amd.com>


Leo


>   				/* Restore */
>   				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
> +				ring->wptr = 0;
>   				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
>   				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
>   				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
> @@ -1397,6 +1406,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>   
>   				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
> +				ring->wptr = 0;
>   				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>   				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>   				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
> @@ -1405,6 +1415,8 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   
>   				WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
>   					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
> +				/* Unstall DPG */
> +				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS), 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
>   
>   				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
>   					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
