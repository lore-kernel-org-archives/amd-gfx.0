Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0C7C83000
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 12:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AD0206D6
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 12:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yr766mGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AD0206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DEF66E394;
	Tue, 28 Apr 2020 12:57:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F46F6E394
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 12:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnaMkn6eJC5aAP7oHoxASPpMnEZTHVgxIm7smr5zyxOPZC9gvZFRCflJvrg2pFJmce8X7XuSa+zyrAd9mbrikN4kD3h8v2qkdWbPxDCgJw/IaX4BFMc3uJ3KuYFhMtNFp+YHwJXWEq6zWFq+JZubA1j/LDaP4pZdVEgI59hjKdHTYXzUkq18Nr8oEiIOTALovpN8hU6DCnHjeM9VvHjoevTmb2vddygJrqUVs7Ev7vFqbwr2F+1GLEMS7m+kXncM3ywJhQtR5vwOdYdVEZjCVyHmHh2QWB1rWF3THkEUOJ7uLeVRjxPRhmznOBm22sf94jhus0POGpx1DP79+JGupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y79wAOZr4P5pvSNVHyWYKqDuubOeLsxM+mmueNAFbc=;
 b=FxePfktG9D6ugfwOHzIxBA7Iq+i902H256vDj1tJ/41oKrkKVvueStuykSed5z9v9Y6/rMy6cuFCjoXPpdbty/bGB42Ws7/N5DcsxkK8Vxe8E/rOQF6pVnpgsc+eylfQ8W2oRzS4o88j7jlEL1sqGVQe3h+etuP4fP8fVwAprDeneTiyjZYuCKtW9KobUOsHE7xK1umwcrR7NEWDAkrjb7GaJm+ivuKWQ0D7oR6lPZgMopns2DHI6w/1OvwAvBdaLyWkoi1dYmHwXnYheB99QyfZ3IXEHwZpHXBz75COrhgW5AYHJ2rtcCXPaxcoXTtePwPKdbtQ4H+D2tjL+a9d/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y79wAOZr4P5pvSNVHyWYKqDuubOeLsxM+mmueNAFbc=;
 b=Yr766mGwIxM6ocdMYQSzgpaKeElRGucr+fP9dlYjFs42UZifl54Du60D0pBAMmdoTq/ZD82oNe2w5JtP5EuZQiJo2sam74Pc7Vtm7nrt2LeVf168L+SShsrqtAkl89gPqtYKt1fo9ALKK5VuPpojG64XFTnE22G2nIdwqjYQc3Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1579.namprd12.prod.outlook.com (2603:10b6:4:c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Tue, 28 Apr 2020 12:57:52 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2937.026; Tue, 28 Apr 2020
 12:57:52 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn2.5: wait for tiles off after unpause
To: amd-gfx@lists.freedesktop.org
References: <1588017957-6910-1-git-send-email-James.Zhu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <f9de4e16-1ab1-a7cf-fc02-27c2b0b63bad@amd.com>
Date: Tue, 28 Apr 2020 08:57:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <1588017957-6910-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 28 Apr 2020 12:57:51 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7625d0a0-631a-4438-ec14-08d7eb73c2f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1579:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15796244ADBB75E8662E3377E4AC0@DM5PR12MB1579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(6916009)(2616005)(66946007)(956004)(66476007)(16526019)(66556008)(8676002)(2906002)(31696002)(31686004)(8936002)(81156014)(26005)(53546011)(478600001)(186003)(6486002)(52116002)(5660300002)(316002)(36916002)(16576012)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAGo7FZvHa52r1LInt/K1YQb1I+zxyT5/rrFIkTQgbCkQifC89voz6Vbb4DPkYoAyKf+uS7qrQWy6dHvgRzechK8FDuNKpG+zCmFfoL/vqlI+RMcOvwj6UDVmlMViIdBOCk4fBECQIjjrowgf46y4e818/OIYXr0hpWHs2WbXObQthoqXAAafsLq/Ug12OZJmM//WYXKUb6XFqk3Kal6n2PAaJXJMM3CsE1cFwPRg7q7sfidEoSN0r1bZmAUzOe2z8cGsz9+yU63d20AeJAIf+cUe+P/sFNnubuUP9Vh6tsJyRTGSaYRTvB68OQnmhcuCj40ynBLHkYVFpZG/pZvdep1NsvfsF89x96OezdikWfVmhV0R6SVDxHJ1pUe3m77PTeh4zUw7Usc1MZEqQiMzWP6cTnlOLVhTmBRt44tqSBvfWAjoKhjOG6NB+2irq6/
X-MS-Exchange-AntiSpam-MessageData: AMZNK4z1jJpVp+MNhdAF5cL7u4AGmxaqZwmnp1KaYWPjgvDm37ZAGTMQzI3oTWn7AF1Rkpqf/o25PwBhgFoOoOsRnMIqFnTwa6p3qOhlbh1txh05wIHxpUtuEQa1uRBbeA25imslWiQIUgrpr9Gp7BYVaj6MKiJHgSnOwHu1wK1wFoKNu6SA0mOuHsNMgOFwoumj++DwnlK/7CxN125I3t9ubAkfIQ2BsEs9J8xh5sPvEr0EuLz2pXmlunuz0nEz2SG6MISXXQa+3ofuYxmx27OJOIaBUW7P/hi50E6uEAQ1bsKPaKWywr51IW6OHd3OlyMIIj5YJ0T76EMqCw4/o/L9RGQap73mwtrB858U97n1oB/Wn2tE06eMg8QUzExzPayQdFY6xLc4Arqk6+dTfpcMAriV2UI4rk7MSAnPYXJIEu2qHs5muALHHD/Wn/BUnQfsQL8kdT+NSKy7HTrd/MHuiSMhxLHWLVd6oi2IDJ7sU9ccUzTzoTdSrkZUqAPDcZbp3bY8zDJ/d3aiy6WDfh9ingyMs36t3g5nsIZWcl5UH0Z/xIxUhh21+jRI/J/JCI0lDECZ5LkfairVkkynv78tEUueR/Xf4VxltLwaExyKKDN+bfBZ/lsRnKDan1l6Kqu5AQmlH4xJ1cf1bKTP9bS5RJt6BbU+u3IdcDzJTdHGcheV7jnsBOZzkADE4SxRuEkYeJcMZnbJhheinCeS/MBw8rKiy667enEmxfYX9ANyDs17vilelQ0TDYRL1iyIQEm3CGf6UIxbZRy5vQwPVZs3Lg1uFOgNtwRXGkATS7U=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7625d0a0-631a-4438-ec14-08d7eb73c2f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 12:57:52.5172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8frPQOkYOca8rA/iIxbX7q6KX55Jksl3PJYtKbq4PskRBZBN6GvqbJxxprK9Km/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1579
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

ping

On 2020-04-27 4:05 p.m., James Zhu wrote:
> Wait for tiles off after unpause to fix transcode timeout issue.
> It is a work around.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 0fa1c5c..38ca4a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1404,7 +1404,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ring *ring;
>   	uint32_t reg_data = 0;
> -	int ret_code;
> +	int ret_code = 0;
>   
>   	/* pause/unpause if state is changed */
>   	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
> @@ -1414,7 +1414,6 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
>   
>   		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
> -			ret_code = 0;
>   			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
>   				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
>   
> @@ -1469,9 +1468,10 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
>   			}
>   		} else {
> -			/* unpause dpg, no need to wait */
>   			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
>   			WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
> +			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
> +				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
>   		}
>   		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
>   	}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
