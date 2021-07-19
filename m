Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94FBC12002
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 08:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E8D611CE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 08:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E8D611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE5289D5E;
	Mon, 19 Jul 2021 08:24:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D51A389D89
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 08:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YU4FYzI3BoWkVBVFhfm5C3SjkbzGvmA2Q82wX/nb8XJLPiF99tIdZ2vAo6KMSgnOxq667eoEEX+W6VbtBXuUWZG3B3DJ32FIcBO4W2MOq0nJCwNi01Lz7SITiAVYWEN4kCiyT6C+CnCDMqIkFWg24zQtbu8dtGZq492kD89hUZTrph2M6hTDxPWKO4rIWuTAnr3gFhTs94dElut2rGaPAKkLAB6c8D0isgLPKoBjkh70rOfGwkbrZJmUB09R4WQVaM57A2sVt0GdXO+L8yAO9luf6oTbGJTJRUxyhsSRIRu8QMjkG3a5L6mO1j1VMy1QgLSFq/xYq5GsGdws6lLlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsfMzhmOX+3FWXjkxjXV3ShFQztqAPNu3SDyOOkMZ9w=;
 b=l95l1abLBCordLFI8YxzUea37wOqCrAr/HAmj2IL5zIqrw5nU08cWq9Ixp/FKIx5KKzdewn8GfCaR44YyBxXnw/4jKCFZTcT/tGuyA8El6nZLXdmCXpUQwkeeqfMiLKP7yPTFU/nYOlc5uSMmnfuPPHtA+jJ9rqJ/GqcTSR2R/pJ89QOe3RfNBRnJRds/2Nw+FRk0p3WF+XwOjaSFzxMAdU2QEF8oVx+h07C0s4hk9ao5R3Qu3fkrcZIArJ2EjTdGWOL9q81A/1++RS8x2yqAAZtNe0PFtzOKxIm3FkqxdjoqwLLNHEj5Ob/9O18YChcXLssh3ChIIxEYAA9VEVtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsfMzhmOX+3FWXjkxjXV3ShFQztqAPNu3SDyOOkMZ9w=;
 b=18Pn+KkPWSMGyilBrm25ZPlmSMNPkwBGJLuQeeWAzWwZsIB3C57earU8ODzzCt9mZJ+nYpGpkQErgWiWn35OMQtTPpGrGiWYk42fusZSD+cL01yZ/P86EMc18IaP424ellkOZpv6oE+o19iu666K3IanOietd00hm2rpFTRDyug=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 08:24:39 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 08:24:39 +0000
Subject: Re: [PATCH] drm/amd/pm: Fix a bug communicating with the SMU (v3)
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210714175817.20473-1-luben.tuikov@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <448dfc1d-b0a4-d8c9-112b-b383f8d6748f@amd.com>
Date: Mon, 19 Jul 2021 13:54:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210714175817.20473-1-luben.tuikov@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 08:24:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fded47bd-a8f6-4f34-da4e-08d94a8ea69a
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5554DF80A72C701AD56BF2C897E19@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfREMOG/ogAneXbvZNZMSCS2snoEaSPyvdJTr++edPgrXk7UhNPd8i12bGbg3Nt//Er+H03DhSbrdwRybaICukASo70JTUD2gy2KkVZPNW80IJ6o3MXmBQbrueDsfz9d4YfTzzQzK3vtDQ0GWZO6n4HFtNAS2rxxnRCI9JYc2XtZS/04SuTl0C0TfRrRDXybM3Obr6dDScuG9oASnp9M0PKsH8dumzAhHqI2t7FIzalLkFz7H2SWM1URuiYvu9b7Fd0Sz9LwXhWnbWvhYc4D4tXE7DaBFriBwNpO8z24xn+/8Hn5GsHBhfhZKAcAv9XpAexSNTY056keQz6D4ooIqWek0IBuMkz1QwFOUJS85soZyitMuMHfteTg9Z3Y4IfxEV3+lQ9IviCIROBWpItlGP7JfbH6V5UfjdRPeEPuYKbeGsMtao3zeb14kW3NZp1hIrKiblVTXFbU8Qw7aT45s2fy6wQUDSIfsEWXsr4h9S3HJBfLJpzjq/6ld7GZms2HwbMZlSe7BV11Z8IuudATGIuBUH/uKDKkwEbA+3ue8TUl5f6fb5TrYemTCzm8wv+GkclF4fVetp+TYhZUNBEHJTavDWlK0hTJFzETBhEsivJOuNyWI5GwJtjK9aR1hFQQ/yf8cN0IaYeTG3oqJqc8Ji8RRF/Q5e+um0XFKKOlTi9bneaJj/M7o/9Sa1FAgiRoz6QVTDikD1k6rIJ9O0zjxBR/4dzODTnj1tra34fUpxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(86362001)(8676002)(508600001)(186003)(26005)(6486002)(16576012)(8936002)(2906002)(31686004)(36756003)(30864003)(5660300002)(2616005)(66556008)(31696002)(66946007)(66476007)(6666004)(316002)(4326008)(956004)(83380400001)(54906003)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZRbENoWGRDcU90V0lOTXJtam12OXlNYmJLMWhOSjNROUQ1MTAwVzE2MitD?=
 =?utf-8?B?RGl3cEYzS1FxckRJNDhaWXNkRnZCNm9TeFBDSGxuRzZrU09ZS1FJWitkbTgz?=
 =?utf-8?B?OHliQkVzOXJ0MXgvcHMrN3QxN09FdDBOeENWTitEbTJ1a21xS2RzMmo5WFBV?=
 =?utf-8?B?Y0ZzQ3NmeFlSMURFLzRacGNmN2Z0WExPb2JmSVdZMzIremg3ZWlocm9YYWEx?=
 =?utf-8?B?Qm1MTGlZNmFTNDZtbzg1cjFvMks2czNCeVN2S21ZVXo0WnY1dVkxQTc5KzNT?=
 =?utf-8?B?dnFWZjRTYU1nN1dlQzJNNThPejA2K2tOSTNzWW9vcG5xM0FUb1o4bU5PajU0?=
 =?utf-8?B?aC9WQUtsR3JkVkcySmhNSS92VTRweGZibnJnOFNJVEFBc1BXUEtZL0ZTRE56?=
 =?utf-8?B?SWhvMVRKRWxNanpDNGs4Tk9LN3cvdFlRajlSYTlSRUZxeDMwb2tyNEJXbXI2?=
 =?utf-8?B?clE2cWM5Zm81Tk02ZFZ6cm0zamhIVXMrRjlEdjNncFNVWTJxVjVmQ2pQcXRi?=
 =?utf-8?B?R0JDaTJBa3VIMUxuNFh4MXpxdlZRSzFvRi9memFIVFdBUXB1b0xpYS9Ibm4r?=
 =?utf-8?B?RXErMERJbVFmOTJneUxuNmF3TUNtTCtZMmVnWWpMK3U3RlJFVmdCa2JHODJr?=
 =?utf-8?B?WitMVWV1Q29vNXI0S1lNWHhYWEcxV2phVDNFOC9MUHpmanNxRE80dzRKYnBh?=
 =?utf-8?B?a0gvaXhCZnd2K0JqR3Mva0pRc2pzS2IyQUtNenpBTzl2N0I0VkF3QWZTZG9Z?=
 =?utf-8?B?bzM4U3hKdTYrTnhReW1xem10R2hSd0hYcGVEelA1R0FrYjBWYm1yRWFOQVV4?=
 =?utf-8?B?UWlEWWlDWGhYdGZaTE1PQ2NJcHlpcVVDSWg1ZnR3N3NnSGppaVRQT09tM3kz?=
 =?utf-8?B?TlprUlE1ejRmOC85cFFadTZXejljb0ZYOERoaytNdkV6b1JTdkVtY2lZNzRC?=
 =?utf-8?B?VU9qZzRTTDljdzYzckNnQnBBWXJ3ZVZoSHkwNThqamVmdXpubHZDWkxkN0Ir?=
 =?utf-8?B?aG1hNElCZnMyWUUyMEM0SitYeVBKazBZSlFhYnpkQk91YnA4TzYya3IzSTR2?=
 =?utf-8?B?OTZTRDl1NkFYeFd3WFN0b1V1MmUxcHhwczVyc3REUS84NTJoanJ4MlVxSXFo?=
 =?utf-8?B?aVA0NjgySDJyckJmSXdxQUdBVCtSQUk1a1drYk0yK3BIOGFmaG9Rak5UTExh?=
 =?utf-8?B?VzUzc3dHaGM0aUVzL1BQKzVQQW9NenprUWJvRTFhL3dDeGZ3TlU2SG9CKzBW?=
 =?utf-8?B?dzcwT0NMNDl4a29mcS9rK0pzTzdBSHRhWVJwS2lXcXFOSTAwM0tRd2UwUnMx?=
 =?utf-8?B?NktYa2gzL2ZmdkNzaDBXeTRTUk9ZZWovWTQ1eFVJcTFrMjBOR2NXTzZIRE9s?=
 =?utf-8?B?VmFqdlJMek9rVzBiK0VrOHNOMjhSTzVOYWxlVTMwck1vWEtkWmIybDgzYk4z?=
 =?utf-8?B?V1NKMTlDWUFIenZ1QTFXb29xclFMZThvaStGYytFdndReGdqOXAxa0tma1lR?=
 =?utf-8?B?K1NvRUczMWUzVWhDQkkvbHdQd1I2eG52S0JDWTBySHV1cmUzM1k1ci84STBL?=
 =?utf-8?B?RzhxNy9mWjFSeGFjbkNUOFdIbU0wTDB3Z3Z3NFNqcldkZG9rUC8zeFF3RG1L?=
 =?utf-8?B?eXNicmtKRzE3bWVWeFBOWVFnK3BUeUdiVG5RcUk2QU5EQXEwUXh4VXhuSitP?=
 =?utf-8?B?d05nMmoyalBsbVgxL2tiVnl2b3ZiUmo1OVdRZG0wd2pKaVpHOUxhVFdsaEpJ?=
 =?utf-8?Q?bsvXDl8df3+bF5eLtyXEFBqqCGJyfeamjXnbULG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fded47bd-a8f6-4f34-da4e-08d94a8ea69a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 08:24:39.5004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz29gKnmmVb3hwhSNp2HyRWiBlU0kRzorzk/6n8XeJJXXFigQu8vapNY2WyPx3Zt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
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



On 7/14/2021 11:28 PM, Luben Tuikov wrote:
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
> v2: Add a comment to the description of
> __smu_cmn_poll_stat() to explain why we're NOT
> defining the SMU FW return codes as macros, but
> are instead hard-coding them. Such a change, can
> be followed up by a subsequent patch.
> 
> v3: The changes are,
> a) Add comments to break labels in
>     __smu_cmn_reg2errno().
> 
> b) When an unknown/unspecified/undefined result is
>     returned back from the SMU, map that to
>     -EREMOTEIO, to distinguish failure at the SMU
>     FW.
> 
> c) Add kernel-doc to
>     smu_cmn_send_msg_without_waiting(),
>     smu_cmn_wait_for_response(),
>     smu_cmn_send_smc_msg_with_param().
> 
> d) In smu_cmn_send_smc_msg_with_param(), since we
>     wait for completion of the command, if the
>     result of the completion is
>     undefined/unknown/unspecified, we print that to
>     the kernel log.
> 
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> Fixes: fcb1fe9c9e0031 ("drm/amd/powerplay: pre-check the SMU state before issuing message")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 274 ++++++++++++++++++++-----
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +-
>   2 files changed, 230 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index c902fdf322c1be..dde10c51daa106 100644
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
> @@ -76,55 +76,246 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>   	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
>   }
>   
> -int smu_cmn_wait_for_response(struct smu_context *smu)
> +/**
> + * __smu_cmn_poll_stat -- poll for a status from the SMU
> + * smu: a pointer to SMU context
> + *
> + * Returns the status of the SMU, which could be,
> + *    0, the SMU is busy with your previous command;
> + *    1, execution status: success, execution result: success;
> + * 0xFF, execution status: success, execution result: failure;
> + * 0xFE, unknown command;
> + * 0xFD, valid command, but bad (command) prerequisites;
> + * 0xFC, the command was rejected as the SMU is busy;
> + * 0xFB, "SMC_Result_DebugDataDumpEnd".
> + *
> + * The values here are not defined by macros, because I'd rather we
> + * include a single header file which defines them, which is
> + * maintained by the SMU FW team, so that we're impervious to firmware
> + * changes. At the moment those values are defined in various header
> + * files, one for each ASIC, yet here we're a single ASIC-agnostic
> + * interface. Such a change can be followed-up by a subsequent patch.
> + */
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
> +{
> +	int res;
> +
> +	switch (reg_c2pmsg_90) {
> +	case 0:
> +		/* The SMU is busy--still executing your command.
> +		 */
> +		res = -ETIME;
> +		break;
> +	case 1:
> +		res = 0;
> +		break;
> +	case 0xFF:
> +		/* Command completed successfully, but the command
> +		 * status was failure.
> +		 */
> +		res = -EIO;
> +		break;
> +	case 0xFE:
> +		/* Unknown command--ignored by the SMU.
> +		 */
> +		res = -EOPNOTSUPP;
> +		break;
> +	case 0xFD:
> +		/* Valid command--bad prerequisites.
> +		 */
> +		res = -EIO;
> +		break;
> +	case 0xFC:
> +		/* The SMU is busy with other commands. The client
> +		 * should retry in 10 us.
> +		 */
> +		res = -EBUSY;
> +		break;
> +	case 0xFB:
> +		/* Debug message.
> +		 */
> +		res = -EIO;
> +		break;
> +	default:
> +		/* Unknown result from the SMU.
> +		 */
> +		res = -EREMOTEIO;
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
> +/**
> + * smu_cmn_send_msg_without_waiting -- send the message; don't wait for status
> + * @smu: pointer to an SMU context
> + * @msg_index: message index
> + * @param: message parameter to send to the SMU
> + *
> + * Send a message to the SMU with the parameter passed. Do not wait
> + * for status/result of the message, thus the "without_waiting".
> + *
> + * Return 0 on success, -errno on error if we weren't able to _send_
> + * the message for some reason. See __smu_cmn_reg2errno() for details
> + * of the -errno.
> + */
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

The FW spec for the protocol calls this response register, let me use 
the same term here. Except for the initial value and while caller 
initiates a message, this always contains the response code given by FW 
to a previously sent message. FW doesn't use it as a status register to 
update its busy status, the only chance this could change further is if 
FW updates it again with the response of a pending message. So I would 
like to confirm the check on 0xFC (FW being busy now) again with FW team.

The other aspect which we discussed is - what if this register contains 
a response code which is not one of the defined error codes. In the 
past, we have seen such cases which indicate a possible FW hang. 
Proceeding to send message when FW shows undefined behavior is undefined 
software behavior as far as I see it. This similar to a case when 
software detects a hang or undefined behavior with any other component 
and, instead of poking the component further, does error handling. Since 
the FW has not defined any such method to handle this case yet, prefer 
to do an exit here.

> +		res = __smu_cmn_reg2errno(smu, reg);
> +		goto Out;
> +	}
> +	__smu_cmn_send_msg(smu, msg_index, param);
> +	res = 0;
> +Out:
> +	mutex_unlock(&smu->message_lock);
> +	return res;
>   }
>   
> +/**
> + * smu_cmn_wait_for_response -- wait for response from the SMU
> + * @smu: pointer to an SMU context
> + *
> + * Wait for status from the SMU.
> + *
> + * Return 0 on success, -errno on error, indicating the execution
> + * status and result of the message being waited for. See
> + * __smu_cmn_reg2errno() for details of the -errno.
> + */
> +int smu_cmn_wait_for_response(struct smu_context *smu)
> +{
> +	u32 reg;
> +
> +	reg = __smu_cmn_poll_stat(smu);
> +	return __smu_cmn_reg2errno(smu, reg);
> +}
> +
> +/**
> + * smu_cmn_send_smc_msg_with_param -- send a message with parameter
> + * @smu: pointer to an SMU context
> + * @msg: message to send
> + * @param: parameter to send to the SMU
> + * @read_arg: pointer to u32 to return a value from the SMU back
> + *            to the caller
> + *
> + * Send the message @msg with parameter @param to the SMU, wait for
> + * completion of the command, and return back a value from the SMU in
> + * @read_arg pointer.
> + *
> + * Return 0 on success, -errno on error, if we weren't able to send
> + * the message or if the message completed with some kind of
> + * error. See __smu_cmn_reg2errno() for details of the -errno.
> + *
> + * If we weren't able to send the message to the SMU, we also print
> + * the error to the standard log.
> + *
> + * Command completion status is printed only if the -errno is
> + * -EREMOTEIO, indicating that the SMU returned back an
> + * undefined/unknown/unspecified result. All other cases are
> + * well-defined, not printed, but instead given back to the client to
> + * decide what further to do.
> + *
> + * The return value, @read_arg is read back regardless, to give back
> + * more information to the client, which on error would most likely be
> + * @param, but we can't assume that. This also eliminates more
> + * conditionals.
> + */
>   int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   				    enum smu_message_type msg,
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
> @@ -136,31 +327,22 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
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
> +		res = __smu_cmn_reg2errno(smu, reg);
> +		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +		goto Out;
>   	}
> -
> +	__smu_cmn_send_msg(smu, (uint16_t) index, param);
> +	reg = __smu_cmn_poll_stat(smu);
> +	res = __smu_cmn_reg2errno(smu, reg);
> +	if (res == -EREMOTEIO)
> +		__smu_cmn_reg_print_error(smu, reg, index, param, msg);

This provides a centralized place for handling message error responses. 
We have been using this as a much useful log for finding the FW response 
code whenever a message fails (not just with undefined error code). We 
need to keep the same behavior for all the legacy code we already have. 
The side effect could be a number of such error logs whenever an I2C 
tool probes the bus, probably that is something we have to live with (or 
should be addressed differently).

The other thing is if we want caller to handle error appropriately, this 
really doesn't let the caller know exactly what happened. For ex: it 
uses EIO for a failed message and also when prerequisite is not met 
whereas FW defines two distinct error codes. Another such case is ETIME 
could be returned

1) While waiting for the FW to process the message without even sending 
the message
2) The same error could also be returned when the FW didn't give the 
response to the currently sent message.

Instead of making the caller to split into without_waiting/response 
sequence for every such message, it's easier for the caller to handle if 
we distinguish the error codes for both cases separately.

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
