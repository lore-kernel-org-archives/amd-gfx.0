Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2DBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 04:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD956113A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 04:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FD956113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEA56E95B;
	Fri, 10 Sep 2021 04:42:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CC66E95B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 04:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUnn0K6ius4hd9B5npwUpby+3pSez1o5/k6vADVldHOxBUqommF+J1YMJpFVnyckxBuR5fBzW3gBZpHugw5D+MIzXI3xnOgy9FpOb7lF/tLoTOIU8O5gdoxEuRI46QKzZhuSBggHj/5PoHDiextGJGFFdB8sEocCGYjULK/h9vBiZY0vh2TmkPZhqbD6YuKT99TyInSd5s8Em4Wq967Xf8MXfqn6lyg7/SRLbkE3gyn/mYfTml/85tzUWLe8liAYW37AkFbO6Sp5CimC72zdNEWvK9gAxrR5+5d52wkqG6phz8DXWeZ0OpMtvBFSkn/oP5c8iIvbSL/fsmCLMXS2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=RF+u0UBJOBPEauNK3iZ+taa4rFPNBCpXgoBqrv9zRnw=;
 b=Af6dCMzbrJBvR0Dm02tCTu8rxRlqxb/ZkDX/jwc6jkzMH2xkTZ+Okhlxz+EkidsU6nNL/aEHSGV9uoZgoT2n9/vDGZLkZKzCLhzf4rOgA/Bi9AiqVL/IBGGK9hbZseGTzrJ9f8Ao99oBH0AF0tFiUO/WsBznSw5URAT0/yflBmBDyOGrA38Toux3qwcx7bWygUZlKvguja7k/La83leAC2mVUXZYhpOTSdZN6S6TiRdJZ8hN9+G7Y0ebpF4aNB0N+3Afx6lAp+5IvjQ/0OKtTaLl5+tGLLn8SF/wSulrvdVnQWZKhlSczHaDfJ/lvN3mRCd1jajQeq9mR9amAMBdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF+u0UBJOBPEauNK3iZ+taa4rFPNBCpXgoBqrv9zRnw=;
 b=d9gkRJcWZMi4ezbA/h6Mn7DHBlAeZ+ggxEMqslYWlpssN0As78xIZHib9c6mwd+RaSd92xEooWQpiLNv+X5H1DoCx124haZlgVFbRbAfXiSohF8SOcvfKCDOtJ5IImc3F18AWSrQtjSh10aMDAnc9rzHj8pUPdVlQxyIfGiz9PY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 04:42:23 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%9]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 04:42:23 +0000
Subject: Re: [PATCH] drm/amd/pm: fix runpm hang when amdgpu loaded prior to
 sound driver
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20210910031758.724964-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <25071593-c942-7ea0-b6d5-b2b12ba0a12e@amd.com>
Date: Fri, 10 Sep 2021 10:12:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910031758.724964-1-evan.quan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::26) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 04:42:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c729d08-c29a-43d5-ef80-08d97415617e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5138:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51387A57CDBD8389E04E57C897D69@CH0PR12MB5138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzYEp0U8MWnRYHZkUBUxI2NsXkb1Q5RTIRE+unNqpHnbr4w8+J3vFt5PBwi1llXW3GhtZxuu7Yv8kkCPl+FCSKYFlR+TdUWlFDv4dlY1gZo5Qa/m2Ms+0ShLKpCHU47KszTEVRMYBObgeoGkKjYqMs71rBOfc9iFBTSoTkoRB4dEpQZO4MyqJtIgGshdiPYbBCw3mRNClcOMVBXcq0oEWR92SrotjUTMMo0V7mnKoSJ73M/Bhc8bPLxf5y+TyfEne2x1mveYOYSOJz95YHelekYWwkq6IvLj1M81UNNbHBXyReykqKRXMvDLv4BnY4p1kHCRPiq6WruyGl8+O5t9npKaiNymuhYsVEwBkue6tzpwIMad/N8CZDc5cnkPDgdRQ7E3B2VGOCertj70pzAq+PJtg2R3Z9gnRnmCFjw0LFafObJYrUaCqPJHmesDufmMLxm9K0M8zn9slSvK9Pb3ukn6UYT6XND783yV8NFDTw5fABl/of/Y+r715MZJt79HkNcQRrKz7aKHXDRXBu41zuJtb8s9zh461pA3qPsF+AjgelgnNbKmRjjzbhSWDCocmUOB7Tl2ShQ4Ve1KdZs62N+XSYe5t9VEQbWluJL1pxG1t0zIX/VWohaeXodLGCaRAsoAia5hpEymMF24g6FbTjz3T97iHfWzPJleuZDrg3ZZbmO6ug9L9xeFq/ZyandsIEVcL2bwJ5SedXQ1OP8Cx+hZNiSYoHrXD3XEaQmyI1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(956004)(186003)(66556008)(26005)(4326008)(2616005)(53546011)(478600001)(36756003)(8676002)(16576012)(66476007)(83380400001)(86362001)(2906002)(31696002)(316002)(31686004)(6666004)(8936002)(5660300002)(38100700002)(6486002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUpSdXVIR2w2cmlJV0o1RVcrczVxdkFFcFhYUFpvOEJoNHUyZDdTNEZyQWtn?=
 =?utf-8?B?Q2o2OXlXWis0NWpydW1id0pxYlppRmdaZGwyU2FsVDFFckNlc2VlR012eEty?=
 =?utf-8?B?U2VJZGlNMmMzMVAxRzM0WDQ0bXd5MzZZbWFIdFRmMnVvVk8yL0pzYkpOZUxR?=
 =?utf-8?B?SG9Yb09PclBTcTFtTzJ3RlBEWDBhZ21DcVBzWmp5dWNDNGVITlJ0SGI2MDla?=
 =?utf-8?B?S29xNjk3dzdMeUhMYzdTUHVOQnNmcjhQT09KcndPSVJtSGkrdzVnV0RsSG1r?=
 =?utf-8?B?OUM4T0twVzVyblVFbFJGckIxRjNST1RyblhzRExhNFM3eDg0dWIyYnFhcFpi?=
 =?utf-8?B?Q3pNT2Radnl2QTFTdTZ5UllhemhaQ2tVRjlTeXd3d0MzSTdTRXJnczAva2R2?=
 =?utf-8?B?aHA5M0h1SExkZmNjOURrdWYxaUU0eEtnbGRLSHFFRFZnZjhVcG8yK05DRmN0?=
 =?utf-8?B?VW5zU3czbm82TVdmSkJ2Tk5JYW1mOUlzenI2ZU9KU2U3UmM0YTdraFFmWXNU?=
 =?utf-8?B?ZVF0Y1VwSnVCOFpVb2Q4UkxOSmtaWVRJcDczNjFhaDJDeTBDTVdaVGk5Tmtu?=
 =?utf-8?B?ZFp4Yk1lSWlkT2xkdnFQOHF3MXZYR3VyREdsNm56ZTIyN1ZBdnp0cUpRRzgz?=
 =?utf-8?B?NFlIdTcvZHR2ekRvQmxuZ0VRbk5oRVd4bmVMUjBYNm0zbi83N0pkaDdCdjI5?=
 =?utf-8?B?SzcrTnpjWElQSkZsazRrNGFvMFprM0xQcENEMXA4dzNhZ1E2Mk5YR2djU2dV?=
 =?utf-8?B?VUJ2MXNMOXJLamtmY2o0bzdJT1pFTHhYL2ZCK2xmb2l1VFNuYjdjNitZRng0?=
 =?utf-8?B?Y1VvQTI0cndESVRjbGFmRy9RekR5RDRBS0gxMGFyTlVidnBVYnRBZGRyTTdt?=
 =?utf-8?B?cWErWDBvU1psWU1LeHlFSTkzcFkyaE9CTlc5SlgrMFNncUJJdnZ3bWFiQXBF?=
 =?utf-8?B?QVg0WWtTVWxMeTZOUkxpVW1BUldrTzZGd0RER1NJLzYybE5XMXBEY3o3Y09Y?=
 =?utf-8?B?Q2JpNFFTMEZMSXlJMXpPTWxYb0ZZUDlRY09XK3ZRU1JPWUVYNnZuRjNyT08r?=
 =?utf-8?B?Z1dsUDlkNGxud1V2OXNEM1BRcDhFSUFrWGdjLzIvMENwTEs4YmpvblRmQmdh?=
 =?utf-8?B?cFhMYXF3SmZJbFcwMW9FVWpXeVFYNG9EOTFsZUlMeU4yWmFnMEpIQ0dlRkFm?=
 =?utf-8?B?dWduUmNPdmdDeHE1WEZSU2VoVExOeDdYdzc3L21Oek9CMmRTUHprajF2YWlI?=
 =?utf-8?B?a1FDSjU1dlR6V2NjVTVrRDBiMFpZRHRVSGhkMHozTHpBVVdINi9ldElwMTZ6?=
 =?utf-8?B?emFGKzFURmZtRTZtWGxTOUxjMEJidVArYzJPTmhGSSsrendPam4veW1xMC9L?=
 =?utf-8?B?eGUzMmtmamNKL0hlK1I1YWlORWg2OElVQWxMRDdYZmJGSU52cVY3WjFwNE5F?=
 =?utf-8?B?SjQrMXNDcG4rS3pMdEZHM08rQTF6RkRqaFVjSU9heUNoQkRJdi92aER0VzBJ?=
 =?utf-8?B?RDlQSlVYbmNNdVlaMjZjNmtxYUwrS0d3VEljaHBWaXNneEtJMTIwZitubnFz?=
 =?utf-8?B?ZnFlekxLc0Y3UkdFbUxlWnEvWS9OOTZaUzBmQmpEaDZmUEI4MlFldlk4c1A3?=
 =?utf-8?B?MVI4WkhXZERleU5GekQxZjlWUUtrZmxld0RTMWpzNElnbmczN0VscG9odWVk?=
 =?utf-8?B?b0g1N1FSc1JWb0pBa1IvbURmajJwTmkrSFBIVks1ak4yWXpEeXluaWdzck1C?=
 =?utf-8?Q?zptuyXF7+b+Ky9w2r5rvT/zsMnYsxxHQYqKvtR+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c729d08-c29a-43d5-ef80-08d97415617e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 04:42:23.0262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWrhqeKZ3uRx2v8DTsImMwSqgKQd+iTPtAnPL/mkTXgLl+GdjHpPld0cWcXpXBQx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
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



On 9/10/2021 8:47 AM, Evan Quan wrote:
> Current RUNPM mechanism relies on PMFW to master the timing for BACO
> in/exit. And that needs cooperation from sound driver for dstate
> change notification for function 1(audio). Otherwise(on sound driver
> missing), BACO cannot be kicked in correctly and hang will be observed
> on RUNPM exit.
> 
> By switching back to legacy message way on sound driver missing,
> we are able to fix the runpm hang observed for the scenario below:
> amdgpu driver loaded -> runpm suspend kicked -> sound driver loaded
> 
> Change-Id: I0e44fef11349b5e45e6102913eb46c8c7d279c65
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 24 +++++++++++++++++--
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 ++--
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 21 ++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
>   4 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 7bc90f841a11..bcafccf7f07a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2272,7 +2272,27 @@ static int navi10_baco_enter(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	if (adev->in_runpm)
> +	/*
> +	 * This aims the case below:
> +	 *   amdgpu driver loaded -> runpm suspend kicked -> sound driver loaded
> +	 *
> +	 * For NAVI10 and later ASICs, we rely on PMFW to handle the runpm. To
> +	 * make that possible, PMFW needs to acknowledge the dstate transition
> +	 * process for both gfx(function 0) and audio(function 1) function of
> +	 * the ASIC.
> +	 *
> +	 * The PCI device's initial runpm status is RUNPM_SUSPENDED. So as the
> +	 * device representing the audio function of the ASIC. And that means
> +	 * even if the sound driver(snd_hda_intel) was not loaded yet, it's still
> +	 * possible runpm suspend kicked on the ASIC. However without the dstate
> +	 * transition notification from audio function, pmfw cannot handle the
> +	 * BACO in/exit correctly. And that will cause driver hang on runpm
> +	 * resuming.
> +	 *
> +	 * To address this, we revert to legacy message way(driver masters the
> +	 * timing for BACO in/exit) on sound driver missing.
> +	 */
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
>   		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
>   	else
>   		return smu_v11_0_baco_enter(smu);
> @@ -2282,7 +2302,7 @@ static int navi10_baco_exit(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	if (adev->in_runpm) {
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
>   		/* Wait for PMFW handling for the Dstate change */
>   		msleep(10);
>   		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 43c7580a4ea6..f9b730c5ba9e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2361,7 +2361,7 @@ static int sienna_cichlid_baco_enter(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	if (adev->in_runpm)
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
>   		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
>   	else
>   		return smu_v11_0_baco_enter(smu);
> @@ -2371,7 +2371,7 @@ static int sienna_cichlid_baco_exit(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	if (adev->in_runpm) {
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
>   		/* Wait for PMFW handling for the Dstate change */
>   		msleep(10);
>   		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 69da9a7b665f..d61403e917df 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1055,3 +1055,24 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
>   
>   	return ret;
>   }
> +
> +bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
> +{
> +	struct pci_dev *p = NULL;
> +	bool snd_driver_loaded;
> +
> +	/*
> +	 * If the ASIC comes with no audio function, we always assume
> +	 * it is "enabled".
> +	 */
> +	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +			adev->pdev->bus->number, 1);
> +	if (!p)
> +		return true;
> +
> +	snd_driver_loaded = pci_is_enabled(p) ? true : false;
> +
> +	pci_dev_put(p);
> +
> +	return snd_driver_loaded;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 16993daa2ae0..b1d41360a389 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -110,5 +110,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
>   int smu_cmn_set_mp1_state(struct smu_context *smu,
>   			  enum pp_mp1_state mp1_state);
>   
> +bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
> +
>   #endif
>   #endif
> 
