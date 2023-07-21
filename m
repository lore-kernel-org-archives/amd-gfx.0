Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4952EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 12:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D977D10E66B;
	Fri, 21 Jul 2023 12:18:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F66E10E66B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 12:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/cmYnEBw81dtSiVq1/xF+ydyzFImm2zVrV+oEwijxi2Nwcf4hhblJW28F7tQCm1OlE++4X3WSjtYBqDeEFKVouNc9Y8Ym0booI44hjxPDCso2yVvJIO84/PfQtPUNzmjq2vuv4oP+4YvjbRyJHSoS0T9jzHmcJHIUBXxWIvGiyOz9ROS2pH5Q/X1qGIYSQHyg7udolzHhQ9YlqlVr9HS5CrQzAD3LcG6sENOEMmuO1jZB/Vq46BzFi5k/0AMs9QurrgFpH/5EDbPlhh0s9IwgdV2/v6u5kCTD+IdNTnTClvY+OjZKT897nBtyNAuywD+4Uy6KNpNryUp98YOwkTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFQxDr5WFBQ2J80n0Ar1Uhe71tq9vqaFq/4Al5ZbPMM=;
 b=g9PX/yYLgiKRFWp8Xx/2HQJFVqydPKaOPkMvIgB7XHnJx5GnaByHgzL8W6Q0By7g0P3OpmiOsIw9baW1rFMH9y0dpM7YVMAujojPpxJ3AKWOl2SYKBx0VLGD2pfhl9nZ9oq86zEqMc0o1nZM1oUcnrRyw2kv1elg6dBbpWWjZujcAdhwCYb/S/gLtNtZ/LPNH2r4kdaoqkqbzJr+jiD2WcFrSkmql45IBKLTWYdyt197WsDIwNtRb9x0vvFmqfJ1WYypdmyR10iWwDycjfy4ddREXJ64+vElxvQ8McDFC9yrZgGqL4MAdq46I1VVfRhnmQtFygiQCUVr7/VPj/Mspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFQxDr5WFBQ2J80n0Ar1Uhe71tq9vqaFq/4Al5ZbPMM=;
 b=RiKBZORP8KSRUBA+XYv1xBdoyoclFewd9QCnHhp7crbMvpyhLc7Nyu0ZMAV6D3cvvWgIyv1jDHCNZYGElikaf9m/WoHh0yHDlAbmboRFaEV1s0NPYWWspDkSOrhUlFMFfb2CxhXGbXBLbp+TLmt3YcTcEQf3SvaYQYpcvfDeqyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 12:18:31 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 12:18:31 +0000
Message-ID: <8a87f1a7-b8b6-205d-65c2-05183c409010@amd.com>
Date: Fri, 21 Jul 2023 17:48:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH Review 1/1] drm/amdgpu: Fix out of range
Content-Language: en-US
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, YiPeng.Chai@amd.com,
 Candice.Li@amd.com
References: <20230721120627.608176-1-Stanley.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230721120627.608176-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: fc83274e-958e-4ef3-4520-08db89e49879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RO8DthbjVyULZl08oL54w70zcC4Gckt7CKHshYYAXwX2WsG/KnDPKn/it+dCfxjqU5M7JR0ayZEkk1fklW7+Gk9IkERA3+6L0lnsrcbbhEQDKvOJYT665jVpLyb8eFjxl0/IurClqKayPwx9b0tzAnaL5Ih3ycRsO6LASHz6C0RUv/QMvaRGGv2frQIyneCE86SGAkuvBn7te6RX1ZCAUFc8fKnJFZv/U2EnZP5nKlq8luzuZmBsShi1oH0wjzu91HhzAcUFKhPNKuO648rW73DEWyRCWJISPD5uQ1FaFwcpiT6T++beas56xbWVLdL/iqLW+BIKQzM0ANQ6rQXPEzIHmZ+8/qjqAqaUCn75+Le0Hluz3xvCSHsYNp1R7o1BSc/czhNZ8qXbomB92C9qGpK22u+Ba0uk0U+cLtyovZZ1jtURrBbE/dKh+k2e3NjStRyXucnCeFe02x64HqGQrApeiFgjp3XNOgH+BBF+TKo4akxtTGpDiL+Zus9t6RJfYRasVOaJk6U+/25BOhWefO5PkFhxq2bdsV/n5RNEkZ5Fqdp7A7wHjqjICQMQBfa9yavCibVwyIftUXUdfDRh3wV+9Cd2QngCxdm/Sc70mziuf0ZhSjGL7Nh+YJ4CHSpDsmJ02PTnrQrhIGRmCydi6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(2616005)(83380400001)(2906002)(66946007)(66476007)(6636002)(66556008)(31686004)(6666004)(4326008)(6512007)(6486002)(31696002)(36756003)(86362001)(478600001)(316002)(8936002)(8676002)(54906003)(38100700002)(186003)(26005)(6506007)(41300700001)(53546011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVqSmZnVXk1RldjeUlrQ0ZZc1FkZmJGbmxjOGt3TTJxUHI4YytxdUhBbXlN?=
 =?utf-8?B?dXhuamYvbTYzbnZxdTRlUDFjQmt4R3QxanVZRU1lN0QxNE9SWlMvV2d5cVJG?=
 =?utf-8?B?YmJqMzVRZy92VEtPd1RaaXNwekxUOGZaUS9xZGJkeC9sa1FSUzgrdmFaOVFx?=
 =?utf-8?B?ZE0wMlF5SVgxTlMvK2xOV1FGdzJGNjNXZ292dEliZ1dMcWZhYnh1MzhXbFlV?=
 =?utf-8?B?YThTYkI5S0x1WWFsQ0J2VmtaK21jVWxUS2RhUHU2N3J1bTFtMGV1TzVvZnp4?=
 =?utf-8?B?V0FYb29PVDJpZG5DK0FSZXJrYnNyVEZNYjRUbWpTYzZWckQ4Z2hWNGNOdEVx?=
 =?utf-8?B?Z3FNQ010TXhOWnFObnFpWXdQc1RhMkdSTWlCWThOSis0dEIwTDN5ME1iMlpu?=
 =?utf-8?B?WkZZQ05NblVvZlhVYkd0QXFYeXlRcjVqQ1ZuUk83c3pPWWJOMjVQWGJYMS9k?=
 =?utf-8?B?VEtXcENxbHRjRVdPSGNTVDRWcTkzL1dtdXgxN29kRTFZZkxFQzFmV3c0UlY0?=
 =?utf-8?B?ekVRc1luMDM2SnV6UlZxRFlZSDV5Qk1ONmRUbDNtUzduZCs2S2hCek10NWVo?=
 =?utf-8?B?U2FvT1BjVVR2WDBJSE4wd0VXclBtMjNVTytpTkhWN3VZa3JncWFBNVREVHRH?=
 =?utf-8?B?djI2SjZLWjZhamgwRTNFSXRSRWVaTmFBS3cyZk1QZGUwZm9EVWxwV0wyZU12?=
 =?utf-8?B?V2VtZTF5K3FIUWcvM1JwZDZVOHlJVWxsZEt4dndVZDRFWXlEQi82VlJNR1dp?=
 =?utf-8?B?cUJJVlN4eTM1UDVFZDdJR1lXUkcybW5qWW5xbTByLzlETWVySXZpZ0g4d3Zt?=
 =?utf-8?B?eUNMcWJHWFJJbDIya2xUblZZUVVHSjNPWVFPNXpMYWdLRTg4U3lLY0drSkRv?=
 =?utf-8?B?eEpHUkVSdUU3STlGd0ZXVllScUJ1THdyLzBzeW81aTNRTkxiTGJCTzdRN2Ev?=
 =?utf-8?B?OHY4NkUrV2hkU1ZDcFEyUXprU3hqSWgzRlo4T1FYRDJ4R3VZZXBSbldlSXFJ?=
 =?utf-8?B?VHhjTVF4WGxTNkNYdkUycFYzUC9PZFZSc3lhRk4yVDFVU1gvMWVFVU0rVlJR?=
 =?utf-8?B?azdtajYxeTV1ZWNyVE51OWpObEtvMXNXVUh4emxKa1kvQi9OL0hubGQybjF4?=
 =?utf-8?B?OURVUjBhc1FuRE4wMjhwaXNQWCtCZCtPZnBBS2JJYTlKTnY4QXp6WWU2Rmlu?=
 =?utf-8?B?bDl3L05JLzI5ZVBKNHliKytENHlxU2EyS0xBNHo0K3ZhMm5MRmdYYTNiTUFF?=
 =?utf-8?B?aXJ3VWxRU21iZ0JtTHpwMFNOUmJuVy95Q3EyRU81UjFZSGZwem0yVXpJYXB0?=
 =?utf-8?B?dTNiTXdzVzBWVStyclBoTzVWOC8zRWtKdWtzUzBNdlNtZVhyQ1dxWU0xSjFV?=
 =?utf-8?B?SmFiQ05mSDREMHJxTDJ6bjVmem4xUkVKVGlFZjZwQ2NYaTdtQnBGVk1RYVQy?=
 =?utf-8?B?eEo2QURZOG9jVzluZVZxU2x4VUkycWRUc1ZLWU5IWDJ5MllRU0E1WWszYTMv?=
 =?utf-8?B?UnY4Vld3MnJHUjcxSm1UalRtcm9rb1VoQWZOcmtMcUxCNHZmbkxQcFBPU1VU?=
 =?utf-8?B?YzJFUXBNcTA5M3hCTTJodkVlVVJvblhteDVNK0dJRWFLL0o4TDVRTmV5bFlj?=
 =?utf-8?B?dURjNXJCQ3ZxMGJyV2w5T2VaaUJNWTh3NWZaRk84V1ZvZFFMZmFKS2hXTngr?=
 =?utf-8?B?cEplSHVpS1E5REY1Q1hiMklQSjh6OG1zUTlhUjZwSHpWd0UwMTNSR01rQllr?=
 =?utf-8?B?SHl1TXR3bzRwYitMZWxXUDVEaEN2UW9sQnZwUnpkL25BM1FWRTZZM1NBOFQ5?=
 =?utf-8?B?MW1kSExCa1FWd3kvMFZ6MG1VQTlrSm5wQllmd1M1aGZsdHRRR3V2d0VwM0ZP?=
 =?utf-8?B?NVN6SmdycG9CMmJkdzQ0SDA5cm5IVndaeUFHSTI0UURnSlh3cnA1OVhpNEZQ?=
 =?utf-8?B?UTA1dXJvZWpoK1dscUpuVUk5NnNqalRTMTJYc3M1QlJBOWtNSFVHcWJiOURI?=
 =?utf-8?B?NlhVcGxMVnIrSlh2VG9ZSGwyeE5MQ0FyODVJcFFpTzIvd084Q0ZPOGN6WXBI?=
 =?utf-8?B?MTcwWTVHdWora2JaRWp2NCtoZlhvYmNJczRqYnQ3aFdHbFAzUVB4OXZsVDJD?=
 =?utf-8?Q?ztBELJFcSY80p2JBOYdFoamou?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc83274e-958e-4ef3-4520-08db89e49879
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 12:18:31.1109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0SgfgWoBiwwmpSSQTpqQuR364nThlrvPQ+HmRtA8admHnS7IMmAE8QZ+tDMtuNm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
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
Cc: Le Ma <le.ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cc: Morris/Le

On 7/21/2023 5:36 PM, Stanley.Yang wrote:
> The xcc index should be refer to xcc_mask, convert xcc_mask
> to counts then calculate device instance.
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 9053435488c5..cd833cd3ebd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1076,19 +1076,21 @@ static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev,
>   static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
>   {
>   	int xcc_id;
> +	int num_xcc, dev_inst;
>   	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
>   
> -	for (xcc_id = 0; xcc_id < AMDGPU_MAX_RLC_INSTANCES; xcc_id++) {
> -		if (((1 << xcc_id) & adev->gfx.xcc_mask) == 0)
> -			continue;
> -		reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[GET_INST(GC, xcc_id)];
> -		reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG0);
> -		reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG1);
> -		reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG2);
> -		reg_access_ctrl->scratch_reg3 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG3);
> -		reg_access_ctrl->grbm_cntl = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_CNTL);
> -		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
> -		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
> +	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		dev_inst = GET_INST(GC, xcc_id);
> +
> +		reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[dev_inst];
> +		reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, dev_inst, regSCRATCH_REG0);
> +		reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, dev_inst, regSCRATCH_REG1);
> +		reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, dev_inst, regSCRATCH_REG2);
> +		reg_access_ctrl->scratch_reg3 = SOC15_REG_OFFSET(GC, dev_inst, regSCRATCH_REG3);
> +		reg_access_ctrl->grbm_cntl = SOC15_REG_OFFSET(GC, dev_inst, regGRBM_GFX_CNTL);
> +		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, dev_inst, regGRBM_GFX_INDEX);
> +		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, dev_inst, regRLC_SPARE_INT);
>   	}
>   }
>   
