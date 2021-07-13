Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECD2C07E9A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 02:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFC361008
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 02:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFC361008
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C8CB89FDD;
	Tue, 13 Jul 2021 02:56:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8C389FDD
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 02:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icEtmy4OU6Fq2niXlRe8g+InyI3eC+rQkMhSD+aWJAH2kAdsnFhb1VpAN3Lb5YVDj8WhTGo8duIujCtVsqgeYQmSeBhPtQ+qDm52Cic9MgoX4Wn7sNlhane7mIqVtIC1dytWfQNQoweGg8zmpbRyWpG+oQ3Lz3EF4Ayj1VghzLvfUe6WhsPov8OBRVgbIFtDA9AmpLRbPQLNJxhb66Rs5w3AuVW0X+IKzSoIF5Quss2V5iti6Am7/TiLDeN9H30l2lhg92Y2BCFpoBMxw4NNzh2SsnEcntdReDY/l+eKJOj5/2yGczACWr0P3+sOEq69GQVf9s/JhFnegjqMgUUkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCGWIY42yu+yesxHn1nlqtkQvvS9UZ/p8yK0mutqA4g=;
 b=B5ugz7oO4QLPGQUr9KXRJP/9iprAqjAhfyjsjDNTFb778bZUHuUQ9RGs35QIPv+dcqNzCkQffmzKArmwYjGJ4WywKo8UVP8n4HCNEFCbXJcmnkveyl/5B7kFzgUAnfUqEeg54UagiIwLeohihqv1Xo4BMDvoNECVsqkXuldOl/wMXQKzDEELBCoQ6CJ8fHFdOdf6VK/5mKXpDqzy+6KSirAywu912tXHPVVsBRwhDwiajBjxRyXMWRk0mhWALoJcpG7in7Vt0TP7HVZ3W/iGXfsIbul/DyXQHTAV9zNwfCEcPwNCzOjAi/aqw7mbSoEFTn33q7hpUZnG5VkAvVWzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCGWIY42yu+yesxHn1nlqtkQvvS9UZ/p8yK0mutqA4g=;
 b=yoDZUCq4wNIsEC503LG1job/yaw4mDuA0KdFCmP5C3Jm1RPnh0k/MZ7tzC+j/63nh0Lj3fxaDa0NKlBrK4j1jRlIah7PlK6MV2pIiU5eGPi3QDqqPjcKCXzRDr+5nv3P+pj9KkAgR/mDUc98jCmxiP+SmMFdxLmhxyAk+v7REpE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Tue, 13 Jul
 2021 02:56:30 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 02:56:30 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210712153051.4029-1-luben.tuikov@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <9317e662-e6af-da2f-7451-df0e1a1da1d4@amd.com>
Date: Tue, 13 Jul 2021 08:26:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210712153051.4029-1-luben.tuikov@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.19 via Frontend Transport; Tue, 13 Jul 2021 02:56:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf76b29c-1211-463b-06a8-08d945a9d0b9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5091:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB509124D4BD6FAD87FB25C31A97149@CH0PR12MB5091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NC2PnHejAQzgq/W5U7B+Q6Q/iHU2pGmS0Ne0/5zGArN2hWdFJJ1YnalKzxLnYwLw7XtzOG0CpGKvaXp3thJbNrg4liF/EhcBOKb+7zNvWPeAfSWHdmQFj42v1CVdtemulaZfYAEuo5KCDe7xpv/7GTHU/Rp/B0+gkSxUizk2dVtgBjk7bD8o4ObKQG3WzDHBzkT0bKtmSlQuERsgyfHUdlwtyneXHrTSUu8Ei0UrPEX1lhP6qRGTK1Cjw0aS3lrpYoCJf0WtD81Rl175DPAboujTpa3dv5rSUFk3ndHYS3WofDSitpyyJQ8NF/yA/OrMb2okkDWrLoU59rn1UOYTP3KPBi5jk00n8FLZPTTaw8e1cEh5JTruXGDlsX7jlYGkkpah6H2PKirdwd7wrBCiSFH6+wY2iqciawLIxqswgdg/yMD7XhcwcxdN9LJmc3SL7U0bUIiZNixobjadaMiD4tXXOkEppdYBv5ZMNoyV8V5DUDuDqevXd/5h9uPu5KQg8qx1jHr/K1NR1uQIGZk4bRM4qo0ZjKFXYft6asDBcOztOT3IdUALeYTtocE69ldOYJsIBF28xAynWSFHrVEr+5CmFraJUyluqDkSp0VhYiKauvp/oWX7YmUA19tlZxmodKJkgi56ifDH3aMqZbYfB9dhKfJS4K+Ea8cG4LemuScsq3m0I3gLyeRqctLp8H2v1IjD/s+hc2gLBL74QOp9FHDe6mVbZISXBFHk7VR0CzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(30864003)(5660300002)(16576012)(6666004)(31686004)(36756003)(316002)(478600001)(956004)(83380400001)(86362001)(38100700002)(54906003)(4326008)(2616005)(8676002)(8936002)(2906002)(66476007)(66946007)(186003)(26005)(6486002)(66556008)(53546011)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5wNEQ5eHJDSnJZcCtGY0V5REl0ZncwcEd2V2dickpuUDlweDBLWnpMdEhG?=
 =?utf-8?B?Ry9JZVU4QzkyclJuMTF1bU1GY1g1OXNJVXV6NTVGdEFmeXR6YTNNRW5wNXpK?=
 =?utf-8?B?Q05rZkVVcXVOUzNtTzY0MFBRcmVsUk1GK0FHbmpjMU9DY2JpVzZWRkZsN1hu?=
 =?utf-8?B?bWR2Z1gvRVVYWWh0WDhLMXNhblRRRHU3eGw2ZDQ0aStJeUNzMzFndXVWMjBj?=
 =?utf-8?B?N1RWTW1GNkZXV3cvS3J4MjNVYzNwS0grcUJrVjA1ZjdUWmlGUUN2dTMvN3R0?=
 =?utf-8?B?SWszWU5wcjlmbzFlTGhITHBwak1RVWd4NDJscUp4VG1lNEkxMDI4RTVsVEtU?=
 =?utf-8?B?U0I5Vmhpbi9nYTJLZXB3SURiaFh4UzRZTWM0dWJwNUUxTEFhb0tUcWlURUNt?=
 =?utf-8?B?cWFyRVFYdGJxbXNwOWg2R3lkSUovRTA2WmxEMDZSaXd0cmlUcEVvRU1sZXhu?=
 =?utf-8?B?K2xKRitvdmx3UHlKcjUzKzdTditJdXFiNUxLdVdtZXpCN3Y2VjZ0RElPbGJn?=
 =?utf-8?B?Kzd5M3ZWSk5xQWZMUTVGMy9TZUpraVg1STJMMEVjQkl4dklxUjVhWStmUUNo?=
 =?utf-8?B?K3ZnMUhGSEx3ZUVtTDJsRXdXWHY3bDNvRnduRjNZUnJibjFjSkZpamNnLzBi?=
 =?utf-8?B?bXQvb0V3K2luSGpHb1ptamJhNnF3djN2WXJ0U2k0akdYekhCVFcvbnVCMEhx?=
 =?utf-8?B?QzFYNWsrVXNUaGlPYUhGNWFoemR2ciszeDhtUU1pVmZNOGY4bHoxZm82czlQ?=
 =?utf-8?B?SkJsRHlpVFlaWUZwVmRkKytZRm5IYWZPNlRqdFQ1UjZEMlJXTmxqMG9JNTkz?=
 =?utf-8?B?V1RDN2cyUnNpZXNhelZjV3dlb2NheklvaDN0Z01IelU2T1BBNlNXNHNVdmZs?=
 =?utf-8?B?YS95SnBjWkp4UjlQS1BhNW02UmJBU3FwVmp3dFVNS0trMk50Y29KL1p0dEdM?=
 =?utf-8?B?L2puYkxNc1RvQVBMSm9PeXFpdXlKaVRFcFNjclZJT0QwSndqTS9ZcU9mYW5W?=
 =?utf-8?B?WHRrOEN3L1FKMTFFZU4xcHpoNG9Rd1NpalhWeEpiKzFHSFZmN2M3dzE1VjA3?=
 =?utf-8?B?KzFDOHNqcXZzVnVlMU1sZ0wrQmlXMmJSbHhFNHFSZExvMnVXb1JBZ052eEVV?=
 =?utf-8?B?R001KzlqY0RzZnNPcU03REQ4Ly9oeVVrbGQvc25lN1dBaEtpVWsvTnVhQjhm?=
 =?utf-8?B?RDc3dURIN3QwV1ZyVk1rVVJBZWpJRWZ3Y2lvWkdCbldtUUNMdUdIM0JGMHZP?=
 =?utf-8?B?YWNGL3JoOGFidHhZY2FLYTdsTDcycUZaL3p6RjZ2WnJTR1BicTBsUzlkSlV0?=
 =?utf-8?B?N1ZuOUJ5TS9uSTNuRm9LNGRvV1IxQ1V4blNud094ZWliM0ZVcEtOUkFheEhN?=
 =?utf-8?B?R3MzUWVKalhuQTJXZnVCMWViMFBBMG1uQjZ4VzZFVW5VRFZRRVlpSmlJZFFP?=
 =?utf-8?B?ZndZeUxhOEkvT0tnMHFVNXRVcHZWZFZKUEJFcXZFT0ZGYklJMFZzbExsYUdO?=
 =?utf-8?B?MDVwdVljZjdCNEw4TWROMDFxU2tkdWVGd1JianVyTE05YTFoc3hnaUNlK1c4?=
 =?utf-8?B?NFBSOVcyNDI4alJZRXEvamJZaXJmaGM1Y2huT2Vkb3NDTlNXbndOZ3FaWUx0?=
 =?utf-8?B?Y1NFLzBIZFc3MzJCaEJpNit1dFhWc245SmJaVERnTzFJQ1hodllIcDNKSVZI?=
 =?utf-8?B?TEU5M1M5NnlOdzRkMHhHYnpsaTdnSndqbnRJUEhFcHVlMXdvQkZpS0cxWEo1?=
 =?utf-8?Q?VqEp4NNBCSd8/sa3Y4RfSHjB6tDB5N9tzadv3KC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf76b29c-1211-463b-06a8-08d945a9d0b9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 02:56:30.4755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2j9KmREKZY3snDae6aO7FbyMRn6wiadvo0gbe1/TP06dh4nEHW3/w3B8UBdnlhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/12/2021 9:00 PM, Luben Tuikov wrote:
> This fixes a bug which if we probe a non-existing
> I2C device, and the SMU returns 0xFF, from then on
> we can never communicate with the SMU, because the
> code before this patch reads and interprets 0xFF
> as a terminal error, and thus we never write 0
> into register 90 to clear the status (and
> subsequently send a new command to the SMU.)
> 
> It is not an error that the SMU returns status
> 0xFF. This means that the SMU executed the last
> command successfully (execution status), but the
> command result is an error of some sort (execution
> result), depending on what the command was.
> 
> When doing a status check of the SMU, before we
> send a new command, the only status which
> precludes us from sending a new command is 0--the
> SMU hasn't finished executing a previous command,
> and 0xFC--the SMU is busy.
> 
> This bug was seen as the following line in the
> kernel log,
> 
> amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
> 
> when subsequent SMU commands, not necessarily
> related to I2C, were sent to the SMU.
> 
> This patch fixes this bug.
> 
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 196 +++++++++++++++++++------
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>   2 files changed, 152 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index c902fdf322c1be..775eb50a2e49a6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -55,7 +55,7 @@
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	#type
> -static const char* __smu_message_names[] = {
> +static const char * const __smu_message_names[] = {
>   	SMU_MESSAGE_TYPES
>   };
>   
> @@ -76,46 +76,161 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>   	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>   }
>   
> -int smu_cmn_wait_for_response(struct smu_context *smu)
> +/**
> + * __smu_cmn_poll_stat -- poll for a status from the SMU
> + * smu: a pointer to SMU context
> + *
> + * Returns the status of the SMU, which could be,
> + * 0, the SMU is busy with your previous command;
> + * 1,    execution status: success, execution result: success;
> + * 0xFF, execution status: success, execution result: failure;
> + * 0xFE, unknown command;
> + * 0xFD, valid command, but bad (command) prerequisites;
> + * 0xFC, the command was rejected as the SMU is busy;
> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
> + */

These are the response codes defined in header (0xFB is somehow missing)
// SMU Response Codes:
#define PPSMC_Result_OK                    0x1
#define PPSMC_Result_Failed                0xFF
#define PPSMC_Result_UnknownCmd            0xFE
#define PPSMC_Result_CmdRejectedPrereq     0xFD
#define PPSMC_Result_CmdRejectedBusy       0xFC

It's better to use #defines for these, usually we follow a convention 
like SMU_

Ex:
	#define SMU_RESP_RESULT_OK 0x1
	

> +static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	uint32_t cur_value, i, timeout = adev->usec_timeout * 20;
> +	int timeout = adev->usec_timeout * 20;
> +	u32 reg;
>   
> -	for (i = 0; i < timeout; i++) {
> -		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> -		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> -			return cur_value;
> +	for ( ; timeout > 0; timeout--) {
> +		reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
> +			break;
>   
>   		udelay(1);
>   	}
>   
> -	/* timeout means wrong logic */
> -	if (i == timeout)
> -		return -ETIME;
> -
> -	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +	return reg;
>   }
>   
> -int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> -				     uint16_t msg, uint32_t param)
> +static void __smu_cmn_reg_print_error(struct smu_context *smu,
> +				      u32 reg_c2pmsg_90,

Instead of using reg/regname in function, it would be better to name it 
as smu_cmn_resp/smu_resp or similar to make it clear that we are 
decoding smu response.

> +				      int msg_index,
> +				      u32 param,
> +				      enum smu_message_type msg)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> -	int ret;
> +	const char *message = smu_get_message_name(smu, msg);
>   
> -	ret = smu_cmn_wait_for_response(smu);
> -	if (ret != 0x1) {
> -		dev_err(adev->dev, "Msg issuing pre-check failed(0x%x) and "
> -		       "SMU may be not in the right state!\n", ret);
> -		if (ret != -ETIME)
> -			ret = -EIO;
> -		return ret;
> +	switch (reg_c2pmsg_90) {
> +	case 0:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: I'm not done with your previous command!");
> +		break;
> +	case 1:
> +		/* The SMU executed the command. It completed with a
> +		 * successful result.
> +		 */
> +		break;
> +	case 0xFF:
> +		/* The SMU executed the command. It completed with a
> +		 * unsuccessful result.
> +		 */
> +		break;
> +	case 0xFE:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: unknown command: index:%d param:0x%08X message:%s",
> +				    msg_index, param, message);
> +		break;
> +	case 0xFD:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
> +				    msg_index, param, message);
> +		break;
> +	case 0xFC:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
> +				    msg_index, param, message);
> +		break;
> +	case 0xFB:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: I'm debugging!");
> +		break;
> +	default:
> +		dev_err_ratelimited(adev->dev,
> +				    "SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
> +				    reg_c2pmsg_90, msg_index, param, message);
> +		break;
> +	}
> +}
> +
> +static int __smu_cmn_reg2errno(struct smu_context *smu, u32 reg_c2pmsg_90)

Same comment on naming - resp2errno?
> +{
> +	int res;
> +
> +	switch (reg_c2pmsg_90) {
> +	case 0:
> +		res = -ETIME;
> +		break;
> +	case 1:
> +		res = 0;
> +		break;
> +	case 0xFF:
> +		res = -EIO;
> +		break;
> +	case 0xFE:
> +		res = -EOPNOTSUPP;
> +		break;
> +	case 0xFD:
> +		res = -EIO;
> +		break;
> +	case 0xFC:
> +		res = -EBUSY;
> +		break;
> +	case 0xFB:
> +		res = -EIO;
> +		break;
> +	default:
> +		res = -EIO;
> +		break;
>   	}
>   
> +	return res;
> +}
> +
> +static void __smu_cmn_send_msg(struct smu_context *smu,
> +			       u16 msg,
> +			       u32 param)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +
>   	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
>   	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
>   	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
> +}
>   
> -	return 0;
> +int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> +				     uint16_t msg_index,
> +				     uint32_t param)
> +{
> +	u32 reg;
> +	int res;
> +
> +	if (smu->adev->in_pci_err_recovery)
> +		return 0;
> +
> +	mutex_lock(&smu->message_lock);
> +	reg = __smu_cmn_poll_stat(smu);
> +	if (reg == 0 || reg == 0xFC) {

The problem with 0xFC check is it could be the response of a previous 
message. It could mean that FW was busy when the prev message was sent, 
not now.

There is a default case (value not in any of the predefined error 
codes), that should be considered here also. That happens sometimes and 
usually that means FW is in undefined state.


> +		res = __smu_cmn_reg2errno(smu, reg);
> +		goto Out;

Label naming style, lower case?.

> +	}
> +	__smu_cmn_send_msg(smu, msg_index, param);
> +	res = 0;
> +Out:
> +	mutex_unlock(&smu->message_lock);
> +	return res;
> +}
> +
> +int smu_cmn_wait_for_response(struct smu_context *smu)
> +{
> +	u32 reg;
> +
> +	reg = __smu_cmn_poll_stat(smu);
> +	return __smu_cmn_reg2errno(smu, reg);
>   }
>   
>   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> @@ -123,8 +238,8 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   				    uint32_t param,
>   				    uint32_t *read_arg)
>   {
> -	struct amdgpu_device *adev = smu->adev;
> -	int ret = 0, index = 0;
> +	int res, index;
> +	u32 reg;
>   
>   	if (smu->adev->in_pci_err_recovery)
>   		return 0;
> @@ -136,31 +251,20 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   		return index == -EACCES ? 0 : index;
>   
>   	mutex_lock(&smu->message_lock);
> -	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
> -	if (ret)
> -		goto out;
> -
> -	ret = smu_cmn_wait_for_response(smu);
> -	if (ret != 0x1) {
> -		if (ret == -ETIME) {
> -			dev_err(adev->dev, "message: %15s (%d) \tparam: 0x%08x is timeout (no response)\n",
> -				smu_get_message_name(smu, msg), index, param);
> -		} else {
> -			dev_err(adev->dev, "failed send message: %15s (%d) \tparam: 0x%08x response %#x\n",
> -				smu_get_message_name(smu, msg), index, param,
> -				ret);
> -			ret = -EIO;
> -		}
> -		goto out;
> +	reg = __smu_cmn_poll_stat(smu);
> +	if (reg == 0 || reg == 0xFC) {

Same comments as for without_waiting case.

> +		res = __smu_cmn_reg2errno(smu, reg);
> +		__smu_cmn_reg_print_error(smu, reg, index, param, msg);

This precheck fail print is missing in without_waiting message.

> +		goto Out; >   	}
> -
> +	__smu_cmn_send_msg(smu, (uint16_t) index, param);
> +	reg = __smu_cmn_poll_stat(smu);
> +	res = __smu_cmn_reg2errno(smu, reg);

Using smu_cmn_wait_for_response instead of these two makes the intent 
clearer - that we are waiting for the response.

We need a print here as well if the message has failed.

Thanks,
Lijo

>   	if (read_arg)
>   		smu_cmn_read_arg(smu, read_arg);
> -
> -	ret = 0; /* 0 as driver return value */
> -out:
> +Out:
>   	mutex_unlock(&smu->message_lock);
> -	return ret;
> +	return res;
>   }
>   
>   int smu_cmn_send_smc_msg(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 9add5f16ff562a..16993daa2ae042 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -27,7 +27,8 @@
>   
>   #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
>   int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> -				     uint16_t msg, uint32_t param);
> +				     uint16_t msg_index,
> +				     uint32_t param);
>   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   				    enum smu_message_type msg,
>   				    uint32_t param,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
