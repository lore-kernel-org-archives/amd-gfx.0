Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F971088E70
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 03:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2DB10E866;
	Thu, 19 Mar 2026 03:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6IQ0quJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9604B10E866
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 03:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+kc1FEQ+V7XHahiXkvSN5XI0w7FkZxSou1H1TY5FwmXPxnMtZgFZurcHlSNnGtz/AE2CtfmQkz7kEi6UnKkLcTc1MR3UlZaTC0M7x1Vv8MZ2GQyTzGkaNy0POQot/L+KgjJRSSUW3seofU3r1RungLE1HuFDh/kib3JDkyvjCUV98q6TP5DQRO7PGGZUuxlvo2tkU+03/MtGIwaA145oIOh2H4rQhY74Le+VdMnr/YnIsFScEmQbEdYypw9914ZOhQEMTs5vAPvUHJI4IWIgl+jsC5DLP/Uc9ZgEwBhK7Pr/hmDnp2KnJouLAJzc3wsBqf/hc1xKRM8tbrOVaC8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6lqsQobPkc9e6f+86kssKJZSQFsNF90XMHS/7CPFJs=;
 b=HsDWQ9mUl57UpTbj4dEgkfeXuHcO+jtdmgLJHzp6wsL8cyF0SFzMivKJ+G6iC9K4ZhHQ5jm3qtNOK/JsLVF1CI5BpodkW4DQo9T9rVJj3pTYZxAakNRE/Nr1iBGzpKIz6llImbBpt7LD8iv+08PhGE2dLa1qfmYTrPl4T9H/rAtaY1gyssunhinGPzGCtlOpqe57Z4VzMSOZ8cNqIrmtC8cjfzI/L+iRRRwmtIoQbsFp/tIsKXFsdzTAPaYG97lPc9V9qRWrIVOpga804HQGqdiBoxgcb2hVMhoW/ooCf7Zdt6ATMl8FyPHl6Zk+/9XOuCnSfPMv3MagARLEWego3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6lqsQobPkc9e6f+86kssKJZSQFsNF90XMHS/7CPFJs=;
 b=b6IQ0quJaJOjDgZWaUWJrYYs8iXutiAnxeuyHyO2DfLs+nWoeIbK/c9msj34lWGHKYHIXo6ojdsYi47pIGNEiYyd+Hh/bpVO1Tp843gU+2PRaBVY6USIHPs0gj4vIV5CNp7A1MWNcO1ouucK0y9u2KceM7Q+/oNFoRGWk3ypFGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:45:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 03:45:45 +0000
Message-ID: <a5044ebf-d4e3-4363-a211-9b6144c37c29@amd.com>
Date: Thu, 19 Mar 2026 09:15:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to
 unify msg sending logic
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260319020910.2620721-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260319020910.2620721-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac77b0c-590d-4b97-19b7-08de856a0076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: R39FAK2JAy12VGSTSYhzvVZ5cUgiRGIa8yUrtS3zf6emXdzeo2hBAZLS0QO4g8Ihz4GyzDip94uBz17WCUUthKMFs3V8MGr2XtmAXro2zETCZqv2yfixQHV9pbjgDKRlpeJC2T4J2Ek5RsXIv5LbLgau1nHzZwydwvk/ZzrAG+cxlrzcdGXO5sLnnq4xi0haI+pvRoKO1l2exGTK+nnuOlA0wS+FoUoQtTRgClkIRd3ORhfseeUgAxCv22N4u/Zdnhlx4NqeiORLavGdF+gnNB7dhAeY0R0zsYN+0p1kKhppAkCGyHRvgu2dIa/UZXh4XNiYnOy+VYVpHyiuImkIje9X6bL5eFSVC3FKw2thoc6a4fZI1E5hx3Q+HjHGd/w0FTpiJ1hrVyN1ui8NhdKuG7SW1MGu7918ZiNUQVpEq2QSaxDaIenYNxWnOTkY5s+xfcU9zYFAEL+UIZ47EB+qvQA8oXLI6trxwwXXKLDeJN16+T1ydZzjK0cRmpdTPodh9lQ4iysl/EpZ9JREmawTfP+en9vVm7zJltt5WiKWJV6durfV/g6jIlrzFG1DnwKbZEjzYfR0cWVB59Yb///YZP6+uyW8WSqkhrew265qGVPk9ygfzSgq/misUtT/22sapCUPXnGMow5mcanuaCTFxe54ZZ8vtDUWNlbFayMTEP5+Ujt+n3sYEI6D9XoWGnmgJB5NV5xLsd4yK5rfYYCxNF8UKAELkuWUBC+fAmwqWLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S24rMnk5RUIzOFdUYThlOURTK041dWxyOEl1d05WejEyekcyYU5RaVIyT2FX?=
 =?utf-8?B?NXk5WFM3bTJjcnhsNHZhM3cwellxc2lyaGYzcTNLS0phVzVYQi9Xam91Y2F2?=
 =?utf-8?B?aS9ORWV3YnJnZkJqRG1FQzBjRVRnY0d1MW1IQ3BIOWlGcFZnT3NPY0dWM2hX?=
 =?utf-8?B?SDA5OWVrdGkvYmxya1ZIV0s2NGNnVGJtOUM3S2hMd0F1WnE3c3ErQVFuMXda?=
 =?utf-8?B?NlpkR1hiajgwUmtDcldVVHBnQ2dHM2lQVWV1T0FnL296bXRxR3p2djMwbmM2?=
 =?utf-8?B?djVEK1NocTFzU3NPMEJ3cXo1NXlTUEFDTm1la2FmZzJ1MmxZY3d4K2NaSldt?=
 =?utf-8?B?eWEyYUw5SUd2Y0NBa1VNZzZ5bS85bGFrK3ZHNUF4czQxQjVrQU1UUlZibTZy?=
 =?utf-8?B?TnNEaVFUajI5dlVEcG1lYWw4akpXUzNKNnpFU20wRlV2WkV5cWpWcyt6UmMw?=
 =?utf-8?B?NjBoamFqSnR5RFB5YUV2Zmpzb2lleTRZdE84QlpEMTVMck9rR2xzVk9QTnFQ?=
 =?utf-8?B?WUZSSGNZK3FMQlBHVVJDc3VJYUFINS96THVoNm12d3Z4NG5KRWZmVGhoRXBK?=
 =?utf-8?B?RHpVTzFFSlBLN2s3QlB1ckhlM0U4VWNSTTNDa0RrS3JGQWF2SXNEemRoWGMv?=
 =?utf-8?B?SmVsM0JTWG9YcTBLNWFpMjBpUG8zcFJ6eG9kaGNzRDdNWmVMZ1VMSHd4dFJI?=
 =?utf-8?B?K0R0OWxJNVBtRFpzYm9sUDN3MDJEdGNpK0luVzN2bzRRSGFOREhTYXdqbDl0?=
 =?utf-8?B?eitiYmpRbkdOTWhsZzREZ0gxUVd2TVp4QTdaOVVYRFcxcDIzUUJWSUpxNTk2?=
 =?utf-8?B?Tlo1VFBtTGxLcVp4WE1rc3g1Mnl3OEJIcjdiMDhEeDcxTVBXdG5UYUpRWHN3?=
 =?utf-8?B?MDBtS21zTjhqQXdVdHAxTVNpaGN2d1JtQVU1Mk12VzlzUnNjQll3eGZNTGNY?=
 =?utf-8?B?dHYxd3NsdEZnWDVZSE9SV0g5eFRVU2ZoTVJhRFlnYW8ydytVaHlQM1VEbG5h?=
 =?utf-8?B?VjRzTXB5bmJnNGxSSVFUSDdqUWQ2dzRCSzNqK1luZGp6dHJacSt4azJCRUE1?=
 =?utf-8?B?RXd3Tk9vOGt4N2twOWZBYTNuM0lIQklJT3ZiRU5CcnZndnRqczV0QjUwVDgz?=
 =?utf-8?B?dDN6NlFJNmFHR1VUbnk1cWFla0hvMytOZUlaUnVyRkxwOG5HQ2JxYUN6M296?=
 =?utf-8?B?eXk5TGoyWHVBUEUvMnd3TkhNV09yMXhPSWw0ZEM3UnRlOWNlOGZHem50aU9V?=
 =?utf-8?B?Y3AxNXhQYk5xUzdlR1FlbERRbzBMcnlpeE1WZDVXQmlmM0tQako0RGJVZU1y?=
 =?utf-8?B?bEJJZld4ZmF2ekhmRlh5bGIyYnFhL3l6ZHZFWG15bGxzVXBWVGlka0RtYWI3?=
 =?utf-8?B?d0NyZ0pWM2tGQXJOcDY0NXdrZkxVZEEzK3VsTS9NV2NzU05ZNFFxK2s4VHFi?=
 =?utf-8?B?Y0tTREhMdmx3OUZhUEdYVFhsMXVCK3AzR0tRNTN6MmFMZXhDZitqdUxxMmxz?=
 =?utf-8?B?SU9YMG5MbEJuY3dtMHVrZm9YaGlJNjd0dXpNVld4NUhJSG5sUnBkdk41dU1F?=
 =?utf-8?B?VEJLK21ac2ovbGhsY0VBVnZWUENrdEdycFpJZEVybTd6VW92NUJ1Z2xVTEVy?=
 =?utf-8?B?aGh4SG1EaFZDc1B5b2hrMDFhSFdwdTN2VGpUbm1lenNXQ005Z0t1QmtoWUVJ?=
 =?utf-8?B?THE2dCtmR1IrYXkzNmxwTnM4Q1I2WmpsbHNwMklPeUxRNjN5OXdMM2ZsTEh6?=
 =?utf-8?B?YW9GOUZ1MGsyMHRLd3NpMDBBN0tHWGZRTy8vN0NyRXJYTHRxKzRaby9SaGJl?=
 =?utf-8?B?Zyt1Smowd0dsTHJPY3htZXQxRUI1ZXhTcmxuT1grS3dxdmR0UzJvengzNnVR?=
 =?utf-8?B?d0ZCZ1FnZkY3U3RNcUY0aDlxOHFtRXBsRGROUUpsTldCVjhaUWJUTmZMaHNi?=
 =?utf-8?B?T3JiUDU2ZFJEVThiSWdEUGkvWlI1UnFjcmlqZDFDb00reGlrOXVHNXhmNnFu?=
 =?utf-8?B?N1dKNEdENWRUTEdpR25nbkc3Wk5lcmRvQmVNcGIzekx5MTF1Z1RGdmIzZzB4?=
 =?utf-8?B?ODVHR0xDbElhSUROaGFvS09kdDJvcTNCbmNnWjMvd0MwaFZPUzYyd0Q2YkVF?=
 =?utf-8?B?MmNvcThqVlBOeDU4ZXVhMkVCRmp1VmtSSjF3WHJIZkVoQzAwelJwRCt6b0Q4?=
 =?utf-8?B?RDlhQXJERkVTR29nbmJnUkZIbDdIWWcrdW04MzZxWmNsblRoRWtDM2syWmpH?=
 =?utf-8?B?ZjlBcW14WGJKSmFka0R1NERuWlRaMTFtRW9lRUQ4VS9jcXpyMVZxYmx3ZkR1?=
 =?utf-8?B?MEtrOFhkUnBDcTlvOERTVGhCSU85cGtsTTZPbWpLc1djWnJhMitnQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac77b0c-590d-4b97-19b7-08de856a0076
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:45:45.8227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hMK36F/PRLB59VISbBBfVH5zfhRKg2xNJtXIT6YL4Mxb9w3O6Z0K5CfcB/TJNIx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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



On 19-Mar-26 7:39 AM, Yang Wang wrote:
> add variant func smu_cmn_send_msg() to unify smu message sending logic,
> and enabling support for newer ASIC interfaces such as SMU v15 and upcoming devices.
> (support multi-param/multi-response, standardize code across all smu code layers)
> 
> The smu_cmn_send_msg() API will expand to the following prototypes based on the number of input parameters.
> e.g:
> 1. r = smu_cmn_send_msg(smu, msg_id);
> 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg);
> 3. r = smu_cmn_send_msg(smu, msg_id, param, &read_arg);
> 4. r = smu_cmn_send_msg(smu, msg_id,
> 			num_param, [param0, param1, ...],
> 			num_response, [arg0, arg1, ...]
> 

The intent behind message control is to make the message protocol 
transparent to IP versions and specific IP versions to have more control 
over them - if they need to override a message mechanisms, add specific 
timeouts to particular messages etc. Overall, they are expected to move 
away from using 'cmn' and directly use message control operations. That 
also avoids redundant memory copies of in/out arguments.

Thanks,
Lijo

> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++
>   2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a644579903f4..bc2ac5ae6a48 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
>   					       read_arg);
>   }
>   
> +static inline int smu_cmn_send_msg_internal(struct smu_context *smu, enum smu_message_type msg,
> +					    int num_in_args, u32 *in_args,
> +					    int num_out_args, u32 *out_args)
> +{
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +	struct smu_msg_args args = { 0 };
> +	int ret;
> +
> +	if (msg >= SMU_MSG_MAX_COUNT)
> +		return -EINVAL;
> +
> +	if ((num_in_args >= ARRAY_SIZE(args.args) || num_in_args < 0) ||
> +	    (num_out_args >= ARRAY_SIZE(args.out_args) || num_out_args < 0))
> +		return -EINVAL;
> +
> +	if ((num_in_args > 0 && !in_args) || (num_out_args > 0 && !out_args))
> +		return -EINVAL;
> +
> +	if (!ctl->ops || !ctl->ops->send_msg)
> +		return -EOPNOTSUPP;
> +
> +	args.msg = msg;
> +	args.num_args = num_in_args;
> +	args.num_out_args = num_out_args;
> +	args.flags = 0;
> +	args.timeout = 0;
> +
> +	if (num_in_args)
> +		memcpy(&args.args[0], in_args, num_in_args * sizeof(u32));
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +	if (ret)
> +		return ret;
> +
> +	if (num_out_args)
> +		memcpy(out_args, &args.out_args[0], num_out_args * sizeof(u32));
> +
> +	return ret;
> +}
> +
> +/*
> + * NOTE: To ensure compatibility with the behavioral logic of the legacy API,
> + * it is required to explicitly set the parameter "param" to 0 when invoking
> + * the msg_0 and msg_1 functions.
> + * */
> +
> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum smu_message_type msg)
> +{
> +	return __smu_cmn_send_msg_2(smu, msg, 0, NULL);
> +}
> +
> +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type msg,
> +			 u32 *read_arg)
> +{
> +	return __smu_cmn_send_msg_2(smu, msg, 0, read_arg);
> +}
> +
> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type msg,
> +			 u32 param, u32 *read_arg)
> +{
> +	int ret;
> +
> +	if (read_arg)
> +		ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 1, read_arg);
> +	else
> +		ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 0, NULL);
> +
> +	return ret;
> +}
> +
> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type msg,
> +			 int num_in_args, u32 *in_args,
> +			 int num_out_args, u32 *out_args)
> +{
> +	return smu_cmn_send_msg_internal(smu, msg,
> +					 num_in_args, in_args,
> +					 num_out_args, out_args);
> +}
> +
>   int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
>   			 uint32_t msg)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index e4d282d8bcae..f48356c22dbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -209,6 +209,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
>   int smu_cmn_dpm_pcie_width_idx(int width);
>   int smu_cmn_check_fw_version(struct smu_context *smu);
>   
> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum smu_message_type msg);
> +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type msg,
> +			 u32 *read_arg);
> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type msg,
> +			 u32 param, u32 *read_arg);
> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type msg,
> +			 int num_in_args, u32 *in_args,
> +			 int num_out_args, u32 *out_args);
> +
> +/*
> +* The smu_cmn_send_msg() API will expand to the following prototypes based on the number of input parameters.
> +* e.g:
> +* 1. r = smu_cmn_send_msg(smu, msg_id);
> +* 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg);
> +* 3. r = smu_cmn_send_msg(smu, msg_id, param, &read_arg);
> +* 4. r = smu_cmn_send_msg(smu, msg_id,
> +*			  num_param, [param0, param1, ...],
> +*			  num_response, [arg0, arg1, ...]
> +*/
> +#define smu_cmn_send_msg(smu, msg, ...) \
> +	CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(__VA_ARGS__))(smu, msg, ##__VA_ARGS__)
> +
>   /*SMU gpu metrics */
>   
>   /* Attribute ID mapping */

