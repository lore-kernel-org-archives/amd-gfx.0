Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BC1CD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 09:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB7110EDA3;
	Thu, 11 Jun 2026 09:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dDJtb9oI";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9512510E740
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 09:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0ewWgiP8hU5Y31aysyJ1wa9Yjfvw7l0DQqrRDQt+Gjdqq1LmR4C7ztHDKQCJOKo0EcPWPIVw0qLBdjObq4G7NJ9BC2QTp59jk5Gz3qWSNYBQolaiwbb1RimlQLGu4MfLIuKxiRlUg9LdI7j4LBWcURGxKKjXVxRUEUEpzx+Ga2aa8oUGZ2pgq9OOxD5O5lItCFFC8Vjn4G28m44i+sCi07zs3dEZmAIFRgtml67p25Lk6lkOUWPUxY30OmJDMmOIBJplBI1j9PKzC6oA3y+ol+BZX+mcqIJ7aXhlD/gCk/riXPnvsuYmZXrAGeDBAUTq7RbzKMkkxLWFyUe5PmVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpkYErpN4kvu8sH9pctZJDJKHvMgkYYY39WI6/oIJpA=;
 b=RQPRvqoTyOD/LP6gquZYEueK1L2Ob1ENKxJDKf/kmOiJWfOXiGitXse7LnHbZptkt85XRluuaKmDDTjubLsshB5xpBfwO8E+8A3rQMdHoIefYMks+ZGfBruODE6enlFYixzkWxFCY77E0kTPX8ddGQ7a+mHXvYxpxcoxPrq7cSJXR0q3pRjN1sxvcnibGVMIf7gK1/zmYpYoaMxTJgZEM4WsaR3ngoEFdlGVqNsYjoYM0/vnFQDYnkekC+FCubQG7pRo3BmTRvGLW4BBbPEtUd5X0eJP40GmqX4yHL4YMcXf8P/Dw8/Fp9v0NJ/Gyuo+ipy56ThDRZVAauhLK2ONAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpkYErpN4kvu8sH9pctZJDJKHvMgkYYY39WI6/oIJpA=;
 b=dDJtb9oIKQHWpvPWtjgUSHdy6Wj2oDj//jYNTzzxBtMUJ0J7r+K127/kP05QjZectqjl0fjq5zDTv0XZI7BzpBF6gJVQwKV6juVMPuRHIvEX3hv0fq0joZiGLvhhzblMVkpkq9I9gT6V5qeHjRoWJiolU0JPoDkIIqIAPELgBMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 11 Jun
 2026 09:25:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 09:25:34 +0000
Message-ID: <9aeda530-7363-464c-8017-8ede9210fc3e@amd.com>
Date: Thu, 11 Jun 2026 11:25:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdgpu: add userq create and destroy
 tracepoints
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260611083311.191012-1-Prike.Liang@amd.com>
 <20260611083311.191012-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611083311.191012-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:208:2be::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa743f2-02dc-42da-1995-08dec79b63a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y4Nn7YVfXxwulw/MlETilYy/44pF9cU8CCtfpS2um4LHyeb7D0NCVz5NlkMpo1xNAO/WL+S46UIpD0/e58Mzm2eOY/BNG3MAAAbO3278LUEF7uhdhnQtoI0QwYrGUoYur+MZz3D5OCG9VIApfxF0VbIe95bHMbvP6Bf41JyvACzpk1S4I0Y9QJDgvOwncQ2L7HjzHRoV8lini9qrfvor4FuI6c4ES4+8gFNVaItUCXNNj3b+zTWIpPwaMarnZ0RPwDzXsqrqgHAomP28rRYtHo3i58bWC85O0llHM30r1GRKtnGJnggzigKMFe4wqhhTl0Z7lHWaQOdrtKxk1kUQimOzZdC/JNK00zrGg4PM7hRw+UIqa87h0XqHIeIyNxBaG1ks7lTchLovO1gLpQo04u+0eHEI6lGnaFl6nwmzG7+Ok+wYY4ryJFWQ/OYJrhbpjrkK69hQkx9wfpHacAtA7MfteUNYC2gSRV7sxFq5Ni2TD3hgnV0Uf0PpCheaXIounEL1yiyA1LDKqU/4eQGksTNrXLgTEpkA8BUUzSMbknK8XuPMKZcfdOR33z+SrZ5Ckff1fpPz/Tqvrx4Yp8nk3L2UruvMRgeYoj1eXt8Vrvd1yNOMMPt5Flx9J4jsa3AbCdWFTkXczt2+uSX7vHoY6SK1mjY1io80RtqmZkOaQnMmBu3SpgsHnz+xCQX3IBV6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNueVl2azdBdEJvenFsM2dxVGNMdGVlUVgwdnFhRWthSEFEcGlNL2VnR1lh?=
 =?utf-8?B?MzNGdE1BZkJYSkRjNXVucXJIK1FzMEk5VGgyZ1pDUW1lUlZITHhDY2ZIVktJ?=
 =?utf-8?B?ZlNQTFFBUUZlMUt2N3lyblRmcnl5M0lyZDlPVldMbmpxTnhqMndKK2JrYWZt?=
 =?utf-8?B?NFMybFp5cnh5T1daUkZqeVhDU01HUmw5K2YzSkZMQnpLVmtOaXlkWUExVmtG?=
 =?utf-8?B?MTdidXFLb0dwQy9JL05RcmQrTGlGQTNIU2Z2Rkl4WERuSnQwSmxyUTVYRzBG?=
 =?utf-8?B?dnAvV3lDV3ZOaHdjVktOQi8zQUE3OHJQenVmWEk1SGxRYmhjeUtSS21jK3ZI?=
 =?utf-8?B?WkJPMUgwbCtKVEE2djJ6YnQvaHBkWlFqT1FudTFLNmQzNmdSNFFqemMrdHdu?=
 =?utf-8?B?RTBsWjh6SU15UjREVmZjbHRObk1tZXd5a0JWMkdVaW1rY0VEMjZnQ1E4NmJ1?=
 =?utf-8?B?OHRSOXlHT0lGc2Rhck5naEpMamY0Vm96QWJ4Ni81cldmQkwrdnJrdDhSdVNv?=
 =?utf-8?B?SGVtYUxrbExvdnBLd0FZL0gzQ01YbU51Rmt6TlFyTCtCUk05UE5Cdkl3bTNZ?=
 =?utf-8?B?R2gwUFJXRCtCZ1hPazlIRFlWbXlEWU5tSm4veFdJK1FvajFWS1JqNTZkcWVv?=
 =?utf-8?B?Ykd1T2F0THppM3hSVU9RWVFxS2s2ck9jcHdtdHpZYmJKdXRkRUhzVktmMWt6?=
 =?utf-8?B?QTlTaFplQ0ZLV2FYWUtsSFFRTTdYVjlNbXRWeDZTUUw4cjdPcmo4dlEraXNt?=
 =?utf-8?B?QS9KYW93MnN4UUhUL2lZaUt0UHdWS3ZOOWVjeXlHa2E3T2FkeE12dTZaVWNI?=
 =?utf-8?B?eTMvUzBmMjVSRWZBMHFmdWNISXl2U0IrYis5MmRQdUNLdFZqSmVEYTZSSkpG?=
 =?utf-8?B?ejN2aTc5cEZ5ZEpyRGVvVVZ2eXVjbDdoRU5BNnVTbEUxMVh1NVptbk9nS1FT?=
 =?utf-8?B?WEdCOTkvbHJpMlk4WC91aWthUCt4OFVscGdRSExtMEdFYUdIYjdEMWNsUHZQ?=
 =?utf-8?B?TVJpdm1ZUUFIK05hRlRhSWRITy9xd1pNcFRHcEU5eDRwcHU5ZHNkUW8wQ0hB?=
 =?utf-8?B?MUxwU2lzUFNhMWlRVUpPQUp2MlgwcVNIMkRUQVBhbHhHNW04NXFFbFZBOVFI?=
 =?utf-8?B?cGtLNTBUTEdCSFNYS1VCcTJFZmRUQnZGWFlUaTlYbmw0QjNsMm5sSC80NnVw?=
 =?utf-8?B?RUMyVnA4UU5sMmwxNWlpQlRxdWExUXU2cHdSL1hFQXlVV3lLMkprR1hlN0sy?=
 =?utf-8?B?eUZNYlowR2lKMnRDYlBRWStleStIZ0pFSkhpbDZYcHZFV2dUYlpUVHQ4UURU?=
 =?utf-8?B?eWJSWnNxQ0hVRWdqaVYyV0lONkhLMUpBMjlwaGhrSGVOeHFlMk5ySkV0aEtE?=
 =?utf-8?B?TlNFNXQxNGV5aUJCSVFOWENleUp1cmNyTmI1MnRSemdMWXRLSGZSK3pIZVhp?=
 =?utf-8?B?a21ta2ZOTWcyKy80RklucVo1QzAvdmpQTFZSQ3hWSm0wUmpTZ2FpeTRWb3p6?=
 =?utf-8?B?aUdIelAyZHFiZmJBZUdpN0FGN0lSV2tURWNkMW1vSkp5T0g2N2hRb2t4ZjRW?=
 =?utf-8?B?Yzh1azlMWmNha280OFJiSnBkNUViWndsWCt2OW1QTnlOUVp4UytqZThEZWVI?=
 =?utf-8?B?ZDAxNGxrOS9uNmhUL3dTc3NnUEVKQUxXRmxhS2lUc0NCSGdxUEt0ZHZyc0pt?=
 =?utf-8?B?dFFFdzFCZWJEcWlhczhFK1Q4VHU2SzdkdHFRYXMrVnF6RDlCd1pycWhWaDV6?=
 =?utf-8?B?MTRYSmQvK2FJNTJQbFhER1UyTjN4Q3l1dnVOWmtocitEUWFqeTI3RDlkQ3p4?=
 =?utf-8?B?OHNSQ2M5dmtPU3JkL1RVOE1lem9KWUwrNC9MTXJvRUlVdldQY01hdnF3K1dr?=
 =?utf-8?B?QVdaL0M3VitiWWtsdHRDa3VqSWxGSEZSVTJ2elpBL2NJYmY2b28zTWJmbGZx?=
 =?utf-8?B?NVZCZFZCNTYrNXM4ZE4za3JCd2VtaUxqMm5hMWpXakJDeTZHOFpzaWI5Wnlh?=
 =?utf-8?B?WldGdEdYTXpnQ2Z5VGxiS0tMcitKejhZeWFBdTFTWCsrQTNvUjRJOGowMzJq?=
 =?utf-8?B?bTRMY0svRktsNnlwZ0xjaE00Sm5nRkhrUm5FK3NGaVk3Sk0vSVR0a3FickdN?=
 =?utf-8?B?RWFzUFFkRmFxSi9oNkozNXZZVWpUampGNU8yNGQwaU1wS2c1amVmalU0OHND?=
 =?utf-8?B?b1dwVWJubFhjV3pkbTlGMUFRS2NoZlBiMitmd2ZNT0FtRk1JWEVNQVdkODE1?=
 =?utf-8?B?L3I4OWRpQko5dTBSbC8rajRXQlB4eGxJUEpMZXlBbWJQaWNCRER0WDRxWXAv?=
 =?utf-8?Q?K+cC3oJ+wUkZ03nBru?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa743f2-02dc-42da-1995-08dec79b63a8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:25:34.0349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWZLcBEoVSQpLNzHzlls7aYqh6+6m633ScqIPVYnDa1/WCzvmip+IGvoEyEra2XO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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

On 6/11/26 10:33, Prike Liang wrote:
> Add ftrace events around user queue creation and destruction to profile
> queue setup and teardown latency.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  9 ++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d13e64a69e25..df98be22f1f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
>  		      __entry->value)
>  );
>  
> +DECLARE_EVENT_CLASS(amdgpu_userq_queue,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	    TP_ARGS(queue),
> +	    TP_STRUCT__entry(
> +			     __field(void *, queue)
> +			     __field(u64, doorbell_index)
> +			     __field(int, queue_type)
> +			     __field(int, state)
> +			     __field(u32, xcp_id)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->queue = queue;
> +			   __entry->doorbell_index = queue->doorbell_index;
> +			   __entry->queue_type = queue->queue_type;
> +			   __entry->state = queue->state;
> +			   __entry->xcp_id = queue->xcp_id;
> +			   ),
> +	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u",
> +		      __entry->queue, __entry->doorbell_index,
> +		      __entry->queue_type, __entry->state, __entry->xcp_id)
> +);
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_create_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_destroy_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DECLARE_EVENT_CLASS(amdgpu_userq_queue_result,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	    TP_ARGS(queue, result),
> +	    TP_STRUCT__entry(
> +			     __field(void *, queue)
> +			     __field(u64, doorbell_index)
> +			     __field(int, queue_type)
> +			     __field(int, state)
> +			     __field(u32, xcp_id)
> +			     __field(int, result)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->queue = queue;
> +			   __entry->doorbell_index = queue->doorbell_index;
> +			   __entry->queue_type = queue->queue_type;
> +			   __entry->state = queue->state;
> +			   __entry->xcp_id = queue->xcp_id;
> +			   __entry->result = result;
> +			   ),
> +	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u, result=%d",
> +		      __entry->queue, __entry->doorbell_index,
> +		      __entry->queue_type, __entry->state,
> +		      __entry->xcp_id, __entry->result)
> +);
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_create_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c1175cb6d242..64b9127ef931 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_trace.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -507,6 +508,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>  	int r = 0;
>  
> +	trace_amdgpu_userq_destroy_start(queue);
> +
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>  
>  	/* Cancel any pending hang detection work and cleanup */
> @@ -532,6 +535,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_bo_unreserve(queue->db_obj.obj);
>  	amdgpu_bo_unref(&queue->db_obj.obj);
>  
> +	trace_amdgpu_userq_destroy_end(queue, r);
>  	kfree(queue);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -683,6 +687,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	}
>  
>  	queue->doorbell_index = index;
> +	trace_amdgpu_userq_create_start(queue);
>  	r = uq_funcs->mqd_create(queue, &args->in);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> @@ -706,6 +711,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> +			trace_amdgpu_userq_create_end(queue, r);
>  			mutex_unlock(&uq_mgr->userq_mutex);
>  			goto erase_doorbell;
>  		}
> @@ -722,11 +728,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		 * This drops the last reference which should take care of
>  		 * all cleanup.
>  		 */
> +		trace_amdgpu_userq_create_end(queue, r);
>  		amdgpu_userq_put(queue);
>  		return r;
>  	}
>  
>  	amdgpu_debugfs_userq_init(filp, queue, qid);
> +	trace_amdgpu_userq_create_end(queue, 0);
>  	args->out.queue_id = qid;
>  	return 0;
>  
> @@ -742,6 +750,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  free_fence_drv:
>  	amdgpu_userq_fence_driver_free(queue);
>  free_queue:
> +	trace_amdgpu_userq_create_end(queue, r);
>  	kfree(queue);
>  err_pm_runtime:
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

