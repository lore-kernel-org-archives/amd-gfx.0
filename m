Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A289BC0015E
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 10:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C60910E55C;
	Fri,  7 Jul 2023 10:52:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60AE010E55B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 10:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkSdRnuBJK8jepVWoAqawS+JDRaxsYzYQczcSXM648geodGqMZf/ib9tB6bgQoaH8g8ZgKvtaEkZirujGkItpoE+Q1NL1iRAHEPaI0nL1APULROUTUB7K96xkycqdK1ASOo/mJ+uSr6+bnzzvNemOH4iJo8p6J9tCrJUuI9QSlZRTgpNHUcCeuQSvKIFKchDX/vn7nzh9rQcizBomfWNMP6L+bX3Wee157I49pMfgnQi/6q4U4lO7Pr0C4lsFeggzTA6tvCorxqk6iSCw+s95VH9ijrqUInEV8veqylzqj7oT7F4pn/jLekLyiFkuaRJoK3XpSZ/UoohqkhhZx6B4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R94Nw9EsNWO8cE22K4ZUCF5ciAqXv8yGBL4cvwzDTLQ=;
 b=ApMQ9rwgG7/dFRbcvP1FVJXlkr3uG0FDV/xgWCvCconKlFv+PWd6yaLSI6iUcZRWRcN/6oOdwlX44ZJ6JXXdQTPyyOZ5agRQscPT7ORu96EVZJ6KencxyhR7OCJLbrdwpxcpM6D021FTij/kXhL+m5qRjLPo1aZwV6LtlIow+whqvpz9OZtvYpQHPk5tZoXPPK/zrbcZ4F9fAJtPV9HmMLIa86YKvUN/ee4+xxbR6EHbPY4arH6Hzl2iHoxs1skXtQ7NpzFFMvhP6dS4CqXWKsbCYey3MAOsulj8hMk69hyo/LSwLmmPCJ35PFPel+baLJnIK5iSXxdOnzWw2cbZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R94Nw9EsNWO8cE22K4ZUCF5ciAqXv8yGBL4cvwzDTLQ=;
 b=J9PL4xivzHylqG1sFAH51bVlFACcKhGxm5DfGCTeOMTl6j9S5O0qEJ++fIcyVM/dbASly/dzBO7tI3Yc4OGkuqHStZZkMr0oWqjmFaw+gMJLTzu1zCD7Wjy9v7sSuhHGgWdM5eQkj4hL8RT/9a8WHkmlGYx4wtuNKKJe5Ne8ulI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 10:51:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 10:51:58 +0000
Message-ID: <44098408-d25f-c7af-e691-0be22173522a@amd.com>
Date: Fri, 7 Jul 2023 16:21:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amdgpu: check whether smu is idle in sriov case
Content-Language: en-US
To: Danijel Slivka <danijel.slivka@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230707101729.2180508-1-danijel.slivka@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230707101729.2180508-1-danijel.slivka@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2b65a0-a5db-4992-cc10-08db7ed82fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuNC/JCmIRLmr8iXXKd8icY4SgR1J/FsUydrMhxgyo818w3AHzP6bvCwlo2QCoBkXn6fhvYN00g6o8plRzS8G+K3imObGJUNLOArTMen5n1KkXWT+xCpVuIh+BKo3A2UlszNpVWS/v5kRmuc+r4qCECoap6p70hwGXC90STEJED+SxQbpRRcOAsnEAUI/2dRo9b8jGPOBgrjnM5lDE/vTmhXu3rh2Io7/naLN4MJPC1nTEDsyNw4dnu5oJs8oy0KlSo+fs1d6rAqWAGAAkyCaiupW71D58en0Rvm57ksWpoQcrGTSVFVo8nbQNetcU2/sCBgmeqQhAhhawGQ8kA7GLM2noXoN43rP7mFCWOuBlq0PHaQ/pxlWXuLo9V9Z3tAtgf4bovsnZdNocXnaQCzuVHVz70jtYyv0LODiNu/JF7zrQ/M6zMRPldJ8YrTvaVzXdDhsD0BX1t46ht8y8gcVqghPRtIPcwBwn1peEbW20VzcaiZi7sLFFvrHUosKwKpLyjkCqpgh25n2W6IPjSb607wGGg8e5qBSQJc8gFWgpfquI0daG5uKm4JKFu4UmyFNQ1J0f0iSP/AF8saIA4R0DqqOgACRsHax75KKQLxw2aaYH9wy9dmJZvqCcbkY0TGNYBMbLd75oByIvOvi+IXKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(31686004)(6666004)(478600001)(6486002)(54906003)(83380400001)(2616005)(36756003)(31696002)(86362001)(66946007)(41300700001)(53546011)(6506007)(26005)(186003)(6512007)(38100700002)(2906002)(316002)(66556008)(66476007)(4326008)(8936002)(8676002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVJMDJwS2hZRDE2d21WYzVkL1dlenN2QzFTbmJqMW9pdkFyWTc0YmNEMFNw?=
 =?utf-8?B?c0p2ZEVjeUtJclZTcHNOdHBpYWNQODR0bnNuTHh4a3JjQnpHUGNaODhmbjNK?=
 =?utf-8?B?WmxONG9YdmYzZUpTM25nMTlEbTN5YXZDUzFvU1E3QTNQWkxvMFhiS3hmSWJE?=
 =?utf-8?B?eWdZQmRSUElMbVBVTXNSYkpZcktPcTlFbUREWmpGeWtERm02Tjh2OWgvTlhp?=
 =?utf-8?B?azJScG1POVV0QnNNRkU2Y3lEVHhOL1UzTkdXL0pPK1ZMUmFwN2N4dk5sYUpM?=
 =?utf-8?B?R0hhOXl1N0RCNllPU2d2R2Z4dGZxb082aVN1My93Mkk4QlpSSzA1RldBZlNS?=
 =?utf-8?B?TjFmN25aU3FGU29BeHNpaEJ1dkEzKy96eVh5TS83WUNPSHNCMkE2UlZ5NkpQ?=
 =?utf-8?B?T3JNUWlYUjB3bU9yTlJLa3RqSm1XeXlMRGx2K2RiQlFZSnU2R0xndFptUXpN?=
 =?utf-8?B?RzB0dnN6RmplRDZ1NWJnLzlKQjBBemZ0ajdjMWRDbVBLbVV0VE1EYm1PVzkv?=
 =?utf-8?B?cGZFRlpkZEx0NU9tdnNUUnd0UGdlV3NKcVAvbG9VYno1RVMwRTN0M0FJNkVG?=
 =?utf-8?B?NWNma0kzdGZha3FOaThOREZZME16SE4vcHFoVjhlb3Jqc2lWMk5lVllweFI4?=
 =?utf-8?B?NHBuMzBVOFhHQUl2N05OM3BNNVZZV3I4MVZOdjBwZmJ4d2s5WUhBbnFVNFRC?=
 =?utf-8?B?UDVEN0NYbXEvWmh6bDlrN2daMVBVY0tkTEI3VFRSYmpBTDZoS1kxaXNyZmxE?=
 =?utf-8?B?RVBmQm0rU3A4aVlZNW56S1lGQ0lXeXo0VXl0eEo4M2FWOENTY3BLSkNnS2NC?=
 =?utf-8?B?SEhqWUlXSUtrS3NsWGNoZGFVOGYrLzVnUFlBRnNmUW9KQU5MVDZsUTBJZm1y?=
 =?utf-8?B?eldDWE11a0NUT1Jyb2thK2dpYnJ2TVp6UEVPcG5aNXloNE1kdHgyZS9XaE9M?=
 =?utf-8?B?amxYbndjWm1lalR5OGk5UVJxN3h3UFYzK2ZqaFFXbnlOWE5iMGFtc01mS0gy?=
 =?utf-8?B?Zmw0N0xSUUVncktyUVpJdDEyNVd5c0Mva1dyVlN2eGo0Z1pvcUp2WUgxRm9G?=
 =?utf-8?B?dDNOVExLeS9RWlhUaVE3Tjkxc1ZJU1FjM1pHM09mckhFMEtnMElzaHAySzVI?=
 =?utf-8?B?UFdSVW8rY21peDdCZ3pneWlPL0FTRWN1MmE1WmxYeHNGeU0wZmh0d1dYRzRQ?=
 =?utf-8?B?cDdxT2JuOUdnY3RKdGxsZERtcDBDUFlqV2JPUTdreHRTYkJqK1Bac2JtL0VQ?=
 =?utf-8?B?c0ZBcC8veTE3YnUrbGxXQkJwM1VoM1JINGVFZGY0T2lzaSsya1MwWTl2bHdR?=
 =?utf-8?B?RlRXekt2bmJXelh5OTFoQ1RLK3ZFRjFXR21abEVjaXp4NXBOb3BsZFRid09o?=
 =?utf-8?B?VFd5Y2E5SEFHQS9HMURNbkpocmhIRm0zd29HcjRCY1FzZTBzZkZETitvZ3Yx?=
 =?utf-8?B?RkROdE9HZ213RmJ0ZVI3OVlxTll1aEcwMitxWkFqZkZERU9YRmkyVmIrQ0U5?=
 =?utf-8?B?TEQ0WE8wR2U4WEVLMStCQ1JCL3dQRXU5dkpiUHIwVzV2MHpsL0VwWWIwVmdS?=
 =?utf-8?B?Q20xa2UwWVNybFpzcW1YcnY2Qi9qYjc2UVpucSsrdkx0d3V2SXg4eEVYQmxU?=
 =?utf-8?B?WStsVVRmYndvc1FYcGljY1dZMjlvTWVFWmNSaDQwckRqODZmMXYzcTdQRll1?=
 =?utf-8?B?blk3NVB3dlAxS2NrU3dQb2Z6dG9NWk1lelphdFZtcTRmM3J6c2YzaFlnSnJp?=
 =?utf-8?B?Mkt6RmtYTVB2Y0J4VTBHU2RDV1NJandQOHFVWlVnY1E4R1VueWxMQTZLQ2lV?=
 =?utf-8?B?NWxLRjJJQktWcmJkUEJaVDFYOXYwL0hPTFRndWRGUDBwSG9FYjRMV2FsMFN1?=
 =?utf-8?B?L2J4K214Z2hwRFk5cGNucDdObFpXZUkwWGhaZDRBNUNVODZRZFl6aXBZd1BT?=
 =?utf-8?B?cWpFRkhOeEFuRmtxVDRBNHlBQ0JWdzdCK29CWnp3TnE3M1hZU1l2d2xKL2ZG?=
 =?utf-8?B?Vm1MZFRoakdxejBIU3d3eEZqL2NQanJtL1hwMWM2T3hCNmlUOUVJVnhkbEhM?=
 =?utf-8?B?WUlHK3NXSHU3VFJmRlpvSVBlNXRIcXh5SE1aNlg2RzllbzJENWUzaW54d05M?=
 =?utf-8?Q?mrI1PPGHtFQ2TSjWbKCkiwiGH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2b65a0-a5db-4992-cc10-08db7ed82fb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 10:51:58.5449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ul6E+VkBLK6x4xTkEaFm7AR5JMITL17ON4JNZtHPc1rCD6WKYgoJWQLC1qXJfSUe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, Nikola Prica <nikola.prica@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/7/2023 3:47 PM, Danijel Slivka wrote:
> Why:
> If the reg mmMP1_SMN_C2PMSG_90 is being programed to 0x0 before
> guest initialization, then modprobe amdgpu will fail at smu hw_init.
> (the default mmMP1_SMN_C2PMSG_90 at a clean guest environment is 0x1).
> 
A response to the FW  message doesn't mean SMU is idle. Probably, this 
is only a check that FW is ready.

Instead of introducing a new ppt function, move this implementation to 
check_fw_status(). For VF case, test message may be sent to ascertain 
that FW is ready.

Thanks,
Lijo

> How to fix:
> this patch is to check whether smu is idle by sending a test
> message to smu. If smu is idle, it will respond.
> 
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 ++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 40 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
>   5 files changed, 58 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ce41a8309582..63ea4cd32ece 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1443,6 +1443,14 @@ static int smu_start_smc_engine(struct smu_context *smu)
>   		}
>   	}
>   
> +	if (amdgpu_sriov_vf(adev) && smu->ppt_funcs->wait_smu_idle) {
> +		ret = smu->ppt_funcs->wait_smu_idle(smu);
> +		if (ret) {
> +			dev_err(adev->dev, "SMU is not idle\n");
> +			return ret;
> +		}
> +	}
> +
>   	/*
>   	 * Send msg GetDriverIfVersion to check if the return value is equal
>   	 * with DRIVER_IF_VERSION of smc header.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..1bf87ad30d93 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -926,6 +926,13 @@ struct pptable_funcs {
>   	 */
>   	int (*check_fw_status)(struct smu_context *smu);
>   
> +	/**
> +	 * @wait_smu_idle: wait for SMU idle status.
> +	 *
> +	 * Return: Zero if check passes, negative errno on failure.
> +	 */
> +	int (*wait_smu_idle)(struct smu_context *smu);
> +
>   	/**
>   	 * @set_mp1_state: put SMU into a correct state for comming
>   	 *                 resume from runpm or gpu reset.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index c94d825a871b..3745e4f96433 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -3503,6 +3503,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.init_power = smu_v11_0_init_power,
>   	.fini_power = smu_v11_0_fini_power,
>   	.check_fw_status = smu_v11_0_check_fw_status,
> +	.wait_smu_idle = smu_cmn_wait_smu_idle,
>   	.setup_pptable = navi10_setup_pptable,
>   	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
>   	.check_fw_version = smu_v11_0_check_fw_version,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 3ecb900e6ecd..e3c972984b2b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -313,6 +313,46 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
>   	return res;
>   }
>   
> +/**
> + * smu_cmn_wait_smu_idle -- wait for smu to become idle
> + * @smu: pointer to an SMU context
> + *
> + * Send SMU_MSG_TestMessage to check whether SMU is idle.
> + * If SMU is idle, it will respond.
> + * The returned parameter will be the param you pass + 1.
> + *
> + * Return 0 on success, -errno on error, indicating the execution
> + * status and result of the message being waited for. See
> + * __smu_cmn_reg2errno() for details of the -errno.
> + */
> +int smu_cmn_wait_smu_idle(struct smu_context *smu)
> +{
> +	u32 reg;
> +	u32 param = 0xff00011;
> +	uint32_t read_arg;
> +	int res, index;
> +
> +	index = smu_cmn_to_asic_specific_index(smu,
> +					       CMN2ASIC_MAPPING_MSG,
> +					       SMU_MSG_TestMessage);
> +
> +	__smu_cmn_send_msg(smu, index, param);
> +	reg = __smu_cmn_poll_stat(smu);
> +	res = __smu_cmn_reg2errno(smu, reg);
> +
> +	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
> +	    res && (res != -ETIME)) {
> +		amdgpu_device_halt(smu->adev);
> +		WARN_ON(1);
> +	}
> +
> +	smu_cmn_read_arg(smu, &read_arg);
> +	if (read_arg == param + 1)
> +		return 0;
> +	return res;
> +}
> +
> +
>   /**
>    * smu_cmn_send_smc_msg_with_param -- send a message with parameter
>    * @smu: pointer to an SMU context
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index d7cd358a53bd..65da886d6a8c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -50,6 +50,8 @@ int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
>   
>   int smu_cmn_wait_for_response(struct smu_context *smu);
>   
> +int smu_cmn_wait_smu_idle(struct smu_context *smu);
> +
>   int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>   				   enum smu_cmn2asic_mapping_type type,
>   				   uint32_t index);
