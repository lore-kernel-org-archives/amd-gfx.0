Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2767C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 08:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40CFE10F586;
	Thu, 25 Jan 2024 08:55:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A4A10F586
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 08:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5dr8hEf9yn9Scjf4QeYdsQfoHRYnipgsiGdKd790Yn/4+86psgmpyg+u+sXEbDz5e90FhFJbDAFTzuETApCikpZYz/AEKhq0GKMMWooPyA5bwjs6EYrstqWUfGGIQudkqXdNEaNxKQSvt0zkKMEXTU6aZixYnaFiXmwx4Sey5d4U98NPiDfh6U9tWT+AyTbbTgU3wpdUT/c6CVQhRgg22h3mFbx4FiIXJEVzIbdL96gNy42oarCao7WPGKQ9m4U6GyqVUjmmoEbfi30Nr8i0Z+q0TMLMQUgdvdTWVDuvimMLHO8yt/yVpLs+K16Y/myb6xrOJftzdSjpabd9QjwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bL4wL8xhQUFCqXTVmRyZOIyGRZE0mCCDMWxU56LVvY=;
 b=CGjCCrmxBMKHYq8Wyxc9z4DhYQFe+0ZF3ByxUEnZc7u4koge5Tcgq3vnLYefk5f+cDSZAJaM2a0M1XTQFn9CW9HpbdyPyRfWYQF4+KXAsI2RUEywv/iCrlQ1ZzGGOWo8pM4vOi5WXDZcM9EhMuxavfsrXPSnqc3uus4ftu2pzesYrEMUZQ+FKX92vQ18YFP5+sIPFxDRklf5EvhvqSSMqMBJ+L0OS+VVIr5ZU+egtu7a5b8bgxowKw4K5VqpAQCTGsItoFoHw5oEPadVPE2pYHub3DHrNjeMHC9++OT8QQ/9thLZ3kN/hob+rGK48wxuQ39+LzwRG4L7QB06DqVltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bL4wL8xhQUFCqXTVmRyZOIyGRZE0mCCDMWxU56LVvY=;
 b=kwbGfHPe6iZxkFPu5V3e9fM9jk8/5ExFVCYt5JBef4xYHaYIvnTeU1MYJEojNfbRTacBHwsZi/cjrO8aG1YkLFJW2Mr0ehM4JfzK9ttdWnEPWcDv28Lh/1W+Iz9D6eLnBKbqQTo5Vn5IxXlRaKyScwVWMk9rblnnwdnoxIvtOsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 08:55:27 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Thu, 25 Jan 2024
 08:55:27 +0000
Message-ID: <cd29ffad-6f13-4d88-a548-f432d4bf6fc5@amd.com>
Date: Thu, 25 Jan 2024 14:25:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240125085018.1119071-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240125085018.1119071-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::13) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: d9203ad3-5294-4a2c-cbc3-08dc1d835ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ExTKMA+QOvXVcNg81IhEKZZSOuNvrGB6W92ziTzpVRZf97GpfgCNR8AiLwVRj0QDXOn1wvEA164AHEQWzs/VhI1tYXuTAuxVFhyrP9n9mnJ1GLi5XdmC/RwlDn9lpq9SFGVhav6p306vWpyMilhaHJ75NJY4iTYvASe3F2AhrjraKUGEc2RhXvSoKdK3kkGsESMkpde5X96Vq5tXISJOh4bLRb0fP/egX/Kk2FxbVRln8TYt4bE53sHjjAjjV4BC7jk/LQGhyO4PYAYO9DB4H0YHx1j8F+hMMtQHZZ2QIfTLI8ZOLPhh55u9rP0liVdwcjxMIKXqKleXx9+MG/c7r6ZGe8p5ZMQGanLBeRxb8scdbdTN79PpUkj62EF3WtvDyOfJ6kgZzdtN/XlbdOeUVTtVg+3kGaluov6aeNbGCjLbEUPjIbV3nMqoalyrJlqn/Gn02UdAkOtWW6TDdEjgXbCvhVwoctNfjjY3g0Tzkh+WV2HNNczsnFM0V0il8JpKF5QrZsS6s6xd/t34Ux1a5MtBb2mScUsjh10zOk6ZrR6q+YR+DvNdL0c/he5VYFeb6oLLX29U97tcAajvXQiYMQgHNwCTjLdhkNXv9/j4M6pYyvHlcJNH6DOjTtgcI3/rJb5wboVET9qXKE88m+/yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(83380400001)(36756003)(31696002)(6666004)(86362001)(38100700002)(41300700001)(6512007)(2616005)(26005)(53546011)(6506007)(66556008)(2906002)(316002)(66946007)(4326008)(5660300002)(478600001)(66476007)(6486002)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGcwWDc5VHhEVC9XbUJveUQwZjlhMDF5Yml4T3dhaWw1Qjc1MHdlcGdhdkJa?=
 =?utf-8?B?K2lSVDRoZE1UVDgwVk8yYVNUR3VuT2hvdzFDb2h4QkNxRk1KY1h6RkpPcXdY?=
 =?utf-8?B?cjNlQm5XRDhmcHJuMGRzaDlXVSt6WFpPT0JVakx3VStXYmNqNTZtb0dVWTJm?=
 =?utf-8?B?Ym1JTGI0Z2prTVRTaTlQVWFPendKK1RnVFpLNm8vSXVHQWlyZyt5QlVmL1ZC?=
 =?utf-8?B?SXRUM3hrdXluVFFsZWlpd3FYbUhTOEpiQzkwSHpJdHovNHZaVGlvM2V6VW9p?=
 =?utf-8?B?OThBRUkyOVRZRVJvRjJBa2E2TnVZSGZKb21ncU1OY0l2SWVFNEM0cmxQeThk?=
 =?utf-8?B?dTBidUpkeW5VYUwzTGJGZzBJSjdOeDVNd0d6U3hDMjRGOG5EMEVaOWMybWZL?=
 =?utf-8?B?UElqdkMvWnYvazI4ZGJiQ3lvc3l2cGxOSnNPU2M3SnlQUXBYZHNvNDBXeGtr?=
 =?utf-8?B?dkV6dlptdzBRdXpKVUliUlM2L2NFUldJTFQrdUNyUlh6QjVGRUZqMFY1MGlt?=
 =?utf-8?B?ajVZanRoRHk4WVd3YXpUeGpQODUzSzQwZ2lNM0VPVC9acTJLZ1g1emI3Z2Qv?=
 =?utf-8?B?TXNsb05OTGVFdUY0WkNPMFRtMWlKTm9oOWxBekdRYzhtbzNOdk1RSjhYQUVN?=
 =?utf-8?B?d0V4UlgvUzNGaW9seEFtYWtCSmdOQTAzMHFpLzF4ai95aFFLb2RHd24zSWh1?=
 =?utf-8?B?QTlxQ1ZaLzFxQUJubDNZd1IrbGpndkpLd3lrSXJUTHRpNDNyeVZONnpuV05z?=
 =?utf-8?B?OVNpMVYyRXRXMENBa2tKcC9PK1hkb0NyR0V0SXdtVjZ5bUJZdTVEZTg0SnN5?=
 =?utf-8?B?SSthZU05YlpvWU13TWZYdm5VQjNiRUVTM2s5eTZXSHVhT1RvNmhaajRGazF4?=
 =?utf-8?B?V2hVclZReWM4YWRkVWxHclBrYkhidDQxeDc5c0l2RTBOL2tuazBJNVdLNHh6?=
 =?utf-8?B?YjJaVGtLU01ITVdTUGh4QnFaUXovT0EvbHQvSzRRbU5waFErZDRBREcyUjFy?=
 =?utf-8?B?M0t6TGV6Wnpkc0FoQTNoQTRQckVLT1oxSm01RlY2VHRXYUM1TUdvMHR4Qndp?=
 =?utf-8?B?SCtUSHBueE9pQ2ZGY21TRjVkT05TU3hFaFZpSkRmcWFDTVJOODQ5TmtXcHZI?=
 =?utf-8?B?ZEhQMHptaUovZ25UZGNGQUgzb0x4cGRUelZodHliRVYzdzh6a09kUHdlTzFu?=
 =?utf-8?B?L2l2bFoxWU1kaU9NNUZXeXViYlRMWGxzMDUrdEdWLzZabDA4TDBOU0FQQTkz?=
 =?utf-8?B?elBIdS9vVlo2ZG5DQVk1OGZSdU5QQ2FCaGJnVWh5OWFGWTFKb2cxSTNscEU4?=
 =?utf-8?B?NlM5RjR0ZVc0ajYrdWFKNUhwM1RjMzdSaXpLNmNjaW9BK1g5dFh3UGt6TDRJ?=
 =?utf-8?B?cGIrUzNxRHlUeEZ5RnFqSkN4RGthcExCVDRTUFU1RHVkQk9leE1MbDdEVWU5?=
 =?utf-8?B?QWdXSU1heTVFOWgwSXRodE5hNFo3Qmluc1NYelU3U1M0aFBCTEszUnlwS1BC?=
 =?utf-8?B?Tzc1a1F3emxxNGJnaWdCVjh2ck9qdkRLN3NvK0lIVXlhVkk2UjVMQU1US1dO?=
 =?utf-8?B?NXJ2RVk0aUVJajRLbEpLZ3RacWhpUFBUalZOc1dPd2hlQUJoRGU4ayt6ZGh3?=
 =?utf-8?B?MnJKc1R0Q2FYZUNWWElIQ3ZRZklNQlFBYkpFcmlTNk9iQXBoTDFadHA0Yzhl?=
 =?utf-8?B?dEFWNkErKzZZNnJPeHRnMGRoek4yTU9IREhCNmRldThmZW8vOWFRZ2F3UFFQ?=
 =?utf-8?B?ZlFZMVM4ZUpvMU9yWjdVbktObTdvR1B3c0IxT2tObTBJN2cvQXhhQXhGOU96?=
 =?utf-8?B?bHptdCtlcVRzdEloOTBjRktsL21hUEdDSDhKQ1NmUXMyY0hmQklSdERVc2pI?=
 =?utf-8?B?UmlTQVZQLzg2UHV5QXUyN2xEZ2xiektmQ2drdzA1b0FNd0JQNC9samVzYTBK?=
 =?utf-8?B?ajkyM0F4UytZY0trbXRTNzNjOUNZYVBIK0RBSkQvN1pDUGhYRlZGOE0vK1RN?=
 =?utf-8?B?LzVpT3dBMFFQNGJJR3N5emd3Nk1EY0xvYkNWbnZVVjFMem84SVB4RzNmMGJ3?=
 =?utf-8?B?YzFzempFOEttQkRsY3doZFB5V3B4c3owUGxSeGpPeERnY1dWVmp4MjJkVkgy?=
 =?utf-8?Q?i2OJiMIRXpTuKmalB1d2soYsP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9203ad3-5294-4a2c-cbc3-08dc1d835ffc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 08:55:27.1448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6XEAR7C8UdNJ1GMIKSLVHkGnxpISAgZDT9VSrL/RUIqqzwcJlGAGahWVRduPF5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/25/2024 2:20 PM, Ma Jun wrote:
> Replace the hard-coded numbers with macro definition
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v3:
> - Add new SMU_IH_INTERRUPT_* macros for smu, keeping the original
> macro definitions in sync with pmfw (kevin)
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 10 +++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 14 +++++++-------
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h         | 10 ++++++++++
>  4 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index fbeb31bf9e48..f6545093bfc1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>  		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>  		orderly_poweroff(true);
>  	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
> -		if (src_id == 0xfe) {
> +		if (src_id == SMU_IH_INTERRUPT_ID_TO_DRIVER) {
>  			/* ACK SMUToHost interrupt */
>  			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
>  			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>  			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
>  
>  			switch (ctxid) {
> -			case 0x3:
> +			case SMU_IH_INTERRUPT_CONTEXT_ID_AC:
>  				dev_dbg(adev->dev, "Switched to AC mode!\n");
>  				schedule_work(&smu->interrupt_work);
>  				adev->pm.ac_power = true;
>  				break;
> -			case 0x4:
> +			case SMU_IH_INTERRUPT_CONTEXT_ID_DC:
>  				dev_dbg(adev->dev, "Switched to DC mode!\n");
>  				schedule_work(&smu->interrupt_work);
>  				adev->pm.ac_power = false;
>  				break;
> -			case 0x7:
> +			case SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>  				/*
>  				 * Increment the throttle interrupt counter
>  				 */
> @@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
>  		return ret;
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				SMU_IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 1db74c0b5257..c13364830500 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>  		orderly_poweroff(true);
>  	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
> -		if (src_id == 0xfe) {
> +		if (src_id == SMU_IH_INTERRUPT_ID_TO_DRIVER) {
>  			/* ACK SMUToHost interrupt */
>  			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
>  			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>  			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
>  
>  			switch (ctxid) {
> -			case 0x3:
> +			case SMU_IH_INTERRUPT_CONTEXT_ID_AC:
>  				dev_dbg(adev->dev, "Switched to AC mode!\n");
>  				smu_v13_0_ack_ac_dc_interrupt(smu);
>  				adev->pm.ac_power = true;
>  				break;
> -			case 0x4:
> +			case SMU_IH_INTERRUPT_CONTEXT_ID_DC:
>  				dev_dbg(adev->dev, "Switched to DC mode!\n");
>  				smu_v13_0_ack_ac_dc_interrupt(smu);
>  				adev->pm.ac_power = false;
>  				break;
> -			case 0x7:
> +			case SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>  				/*
>  				 * Increment the throttle interrupt counter
>  				 */
> @@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  					schedule_work(&smu->throttling_logging_work);
>  
>  				break;
> -			case 0x8:
> +			case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
>  				high = smu->thermal_range.software_shutdown_temp +
>  					smu->thermal_range.software_shutdown_temp_offset;
>  				high = min_t(typeof(high),
> @@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
>  				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
>  				break;
> -			case 0x9:
> +			case SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
>  				high = min_t(typeof(high),
>  					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
>  					     smu->thermal_range.software_shutdown_temp);
> @@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
>  		return ret;
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				SMU_IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 4894f7ee737b..2aa7e9945a0b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
>  	// TODO: THM related
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				SMU_IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index cc590e27d88a..81bfce1406e5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -30,6 +30,16 @@
>  #define FDO_PWM_MODE_STATIC  1
>  #define FDO_PWM_MODE_STATIC_RPM 5
>  
> +#define SMU_IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> +#define SMU_IH_INTERRUPT_CONTEXT_ID_BACO                0x2
> +#define SMU_IH_INTERRUPT_CONTEXT_ID_AC                  0x3
> +#define SMU_IH_INTERRUPT_CONTEXT_ID_DC                  0x4
> +#define SMU_IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
> +#define SMU_IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
> +#define SMU_IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> +#define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
> +#define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
> +
>  extern const int link_speed[];
>  
>  /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
