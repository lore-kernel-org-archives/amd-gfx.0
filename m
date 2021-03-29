Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FAC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 15:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1D361968
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 15:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1D361968
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A0A6E46B;
	Mon, 29 Mar 2021 15:53:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E68416E48E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 15:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc3wIqTQuPLBC3+o7WXLx5BZiktKY8n9p9nUFqlx4XZ90nVGS3EHb3nGpsCU4ghbYJitOF8UTH9WBkHRaocpVedVU40eXzPmSfyaG2jYwagzzGwfUMe3rmrjaCtWiJcXFIMGVJCyCsvyNnO19SQ4o6E4rq8PWBuzIduEFCLhsivIIQH+5SnmavCklL8i8xLyky+RFia6favJbY2CMive+MbGT1+7UFle8q5DFTPxXwljUerbz+zyzRtsRYyJy2mGrC/FBzDAncaCbg+cNmYwJOQtJfXAmu46lfkfYYNkXr5DBRZfxqmCD3URskUVuXWxefOVjkaa/Dh26y1ll+VXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p6LrwTfVJd3fSKDIg3UD7pMe2fKTrIqiL1vvxWlg8A=;
 b=Xz/ms9X2E2bHH3n+LOurL5KzgqTKjtTXdbgdYT6WywnVOOpOcEXIX6JZCdgzMVntrd6Msj4w+SnqnBpBwd72R6kHlbp7Yy5/fwdae0OGughqhovzk1j/cKVHggmI/v9rDRuRCEzslt10FZeVolgklcgpbnUczavxhaZC9mCoTR9g4y7AWjk2yXzRPlXAAk8hKUrRYVNMdBK9u7Dm4s5WHhWsdYPZ9G4iFCxAC54IzZEeu6vKkT6YZyNTdGBRaf8r9IjAR47oWGm5w9oQxmQ+Ct32RBkJagpBEMBVkLT7Fm0TaERTYwVW/CTDhA9bYQhNdU5v6YOU8mTC03ROQVIaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p6LrwTfVJd3fSKDIg3UD7pMe2fKTrIqiL1vvxWlg8A=;
 b=mYerSDY6gvAiXx/0S2AwKYFIAnQWMfU28voY717eXH0SzRkzpcT3JEKdVL/FPlgcqPB8zHPRN6JzR/HUlotxpwb5WqEKywQjRbFxd7BJaDyIYYKEIOACt+WurGPBTCoDMM8p61G1gFKXTJumRZ0ehvB6PGtSKNQwnQXcYYuNWTo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 15:53:36 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 15:53:36 +0000
Subject: Re: [PATCH] drm/amdgpu: Add new PF2VF flags for VF register access
 method
To: Rohit Khaire <rohit.khaire@amd.com>, amd-gfx@lists.freedesktop.org,
 HaiJun Chang <HaiJun.Chang@amd.com>, Davis Ming <Davis.Ming@amd.com>,
 Monk Liu <Monk.Liu@amd.com>
References: <20210323204414.11341-1-rohit.khaire@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <b93076c5-13f8-34e8-549b-bef07af17419@amd.com>
Date: Mon, 29 Mar 2021 11:53:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210323204414.11341-1-rohit.khaire@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30 via Frontend Transport; Mon, 29 Mar 2021 15:53:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cf3f723-f25e-47a2-df35-08d8f2cad03a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892AE9D733393F6E6907B74997E9@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGRBPZfZxjit9NC17aHhkdBuxUj/t2eyDRcHl/5lmlJbZMJnNA4V6r6llYKnimsuFMPe3YFlOllaA01fsI2UBfYqNfB5CMKDb2OfjiPytku8xsqtL9GbAFAhAVwHyM9cPJmxek6K7zEDQppLUWbbP+aQycMZMif1nWZ7brpGM7Xa24zO06ikBztNO15cMYuArjROhC46EZdtSbDsHg4VUFmntkO8D6hO+VeRfVE0DKZE38e3eDATebtUy/G6xkYgJXkkX1PMrmkhqawPE8ysPgVhba8m7yh2v/HRaMA3RbvV0seP1Ds0T/LOUrYDqtmOMBZQ2b6dwLmhK9cO5SkAfJkg2JpCk344Ow2jCn6qlRt+fTHj50rGKCmK/NxGOkkm70OhbVBS95hV2Z3wpsmor51v+JgZGk/Mt9sO94M0q2ua1GoD8v1uROmQTfR+EtBgaCZfaG03UYL05xs76FxJoq9coIQfZl/zYg9cnPjkobTqM1bfEfW1+I9qhmUU3Cyuhi6BDGUU8JZTfT1GHXWKc7o1GxDFQ0ygS8J2PPKv0ag1E1HOvqu9+mQ9sdh90dbyKcoTGdD2hNb1RBPiEWKfkyglMm0uLcNo4/qhjf+DVP6L3gCu6mNc5gVHT4D7OH1IxhgBrxsI4By7CfwvgfXDN8/E0PvzJQ5wzBnB9P6K2agjEPxDimpxJNrAtGPAXcuYABCDXjJEXdpI8KzjZYqeIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(54906003)(83380400001)(316002)(110136005)(8676002)(2906002)(8936002)(66476007)(26005)(5660300002)(66946007)(478600001)(66556008)(31686004)(6486002)(31696002)(6666004)(6512007)(86362001)(6506007)(44832011)(53546011)(956004)(2616005)(6636002)(16526019)(4326008)(36756003)(186003)(38100700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ak5MaGVIZ1pLSnZjbnA4bStRMWtIZTdZYnpxbUtGZUx6a0J5SWFqeGs3U1c4?=
 =?utf-8?B?L1VEMm1QUGRMdnZtai9oeHhPZXZYOHRIeVhxTTE5QzRFQ0Zhek94dTdPdm5S?=
 =?utf-8?B?dzdTbUlSaitTWWNDZFZsRmV2dDlvZ3lJak8vK3c3V2FiTTdGMXlKSFN1bEk4?=
 =?utf-8?B?aHhtVzgxclk4VGRMY2laVTl5dXFyK04vTVVKUHV5b0VmMVdDcFRwT2VMZjhi?=
 =?utf-8?B?bTFEMFhvdnRKVkpJS3hxdEFkOGZ6UDVkeFNLM29xTUE0Q01yQXVLcEh0RHFi?=
 =?utf-8?B?ZXdGNHozd21aWmlqSkhoNU1qMEo3VElKajJ4MXVsd2hyclhHWjdjbnpXeWlE?=
 =?utf-8?B?NnBMV1N1dkw5Y1BhMUR5Qm9YTzZkcnh6R25qN01tbVRtZ3VETjJhbnM4YVBK?=
 =?utf-8?B?cVJjbFJsVDVRZmphUVdNVUlOaG5GZC9weFpLTG9KU1BPdy9ZcVIvQkErYm0v?=
 =?utf-8?B?UUIwcFRkbUUrYlNUYWJUWjVBNlQxdkJybThUM1F6VTY3QmE4R2pKNEMraXNs?=
 =?utf-8?B?dmkxS1hyUVB2dnFtTWdxdWd4UE5SSDg5NWhwUWtDSFhjOVVRM0VvaVlEcEUx?=
 =?utf-8?B?V0dVamVsbHNNaUFZcGFFQ1NLK3N0SllpRXZJVmZ3QnFFK2ZuSHlGK2xJdi9x?=
 =?utf-8?B?TXltTHpUMzVHbUZjTEJQRnBhYS9vVCt3RndsUG5TWDBmUWRXSXBVWks0Wms3?=
 =?utf-8?B?RlRwc01qS0U3NUZBaWoxZ1ZLRkVhWnNJdFNSZ2FrdG5QSCtuVVoxNlRIMXo5?=
 =?utf-8?B?RDhEOHV4dDhiczcyT2prVUF2K0xDU3RQWE1CR0xxSW5yS3BqYmh5SEdwL2Jt?=
 =?utf-8?B?T215dnNERWQveHlMNHBPeUNsMDNjQmxrdmFDQVVLUUZQYi9UTjdvWDZlTHVo?=
 =?utf-8?B?MHQvbXNBMnhFdjV6QnF1ZERISmo0QVlITkNZTHNYblY1dXI5YktzU0xJWXdD?=
 =?utf-8?B?SDVLMzdTUnBrdEN3NlpuYVRDUUNpeTI4U0FQR2FPc09QMGlxLzVvM1J6ZWtD?=
 =?utf-8?B?NFRuTzdMMzhYMWZTMlZRTCt4UTE5YzhLblpFNytpWDJPWlB1Szc4S2gvNFh6?=
 =?utf-8?B?aEFudkJhOG16aHlnOHFCdUt0RkgzZjEzREg4V3Vhb2dBWk5PS2lBSEF4ZlpN?=
 =?utf-8?B?dHkxcFdZdzZ2T1VRZGc0Y1p4dXZ2M2lkcWwxc3N4U01uaDBUdkMyYlZmQkx0?=
 =?utf-8?B?b21NL2o2djYxU0dGeVkwZmF1K29aWjNiTWIwUlVrSC92M2ZEMDVNQVBxTG5B?=
 =?utf-8?B?SGRxZ3dvcjFZcUF4NE9BeDVYTFVsTk9ZRWljOWdYNnlReEFaK0xyK0dZblhR?=
 =?utf-8?B?MitzRWowSU5keUtxclV0czA1QnZ5RFNJN3R5a0dxYXJJWmtMSXdUMnRSZU9U?=
 =?utf-8?B?ZzZMeWM4Z0lLeTd4SmZadjNvVGNZdjRqUHJBTEJodHBScTdyNFhnZGhvamNS?=
 =?utf-8?B?WENCNi9HOFZJMnFSUkNXZHpZYnFyNFN0TnF4dnhqcmFUOUFER1BaVEJIblo4?=
 =?utf-8?B?MkY4VWhydlVUaDFsSFVUYXhic3NUMGV5eXB4LzV3cThOVzZWcUs3K09vbU9r?=
 =?utf-8?B?eEh2NlNhK2o2eXgwbk9rejhCUUszVzcrR1kzWEVxaEZJek9JaFFHbEUvWHRp?=
 =?utf-8?B?cSt5TzNETDhCNjBpOTVNNFE0MDJiU1FEbmpteEZhMEVYcCt6NHhUQVZ0cndj?=
 =?utf-8?B?RjVkNzBkNFFqdGVZaVdYZ3hqRHEvK1pIRkhYMm43UGRiOEt6cDJ0dEowdGFZ?=
 =?utf-8?Q?TBE7H34RpGNMVngeX8ja0Pc2dvQqzQcuMsCAUkl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf3f723-f25e-47a2-df35-08d8f2cad03a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 15:53:36.6118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG40ghsZgcmd6fIQkLcUCxzBoPjvf03fhSYCw01hHZnmPXG/N9Qj0qs85+wxq2E9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-23 4:44 p.m., Rohit Khaire wrote:
> Add 3 sub flags to notify guest for indirect access of gc, mmhub and ih
> 
> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 17 +++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 8dd624c20f89..0224f352d060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -104,6 +104,17 @@ enum AMDGIM_FEATURE_FLAG {
>  	AMDGIM_FEATURE_GIM_MM_BW_MGR = 0x8,
>  	/* PP ONE VF MODE in GIM */
>  	AMDGIM_FEATURE_PP_ONE_VF = (1 << 4),
> +	/* Indirect Reg Access enabled */
> +	AMDGIM_FETURE_INDIRECT_REG_ACCESS = (1 << 5),

Spelling: FETURE --> FEATURE

> +};
> +
> +enum AMDGIM_REG_ACCESS_FLAG {
> +	/* Use PSP to program IH_RB_CNTL */
> +	AMDGIM_FEATURE_IH_REG_PSP_EN = (1 << 0),
> +	/* Use RLC to program MMHUB regs */
> +	AMDGIM_FEATURE_RLC_MMHUB_EN  = (1 << 1),
> +	/* Use RLC to program GC regs */
> +	AMDGIM_FEATURE_RLC_GC_EN     = (1 << 2),
>  };
>  
>  struct amdgim_pf2vf_info_v1 {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 5355827ed0ae..7fed6377d931 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -90,11 +90,22 @@ union amd_sriov_msg_feature_flags {
>  		uint32_t  host_flr_vramlost  : 1;
>  		uint32_t  mm_bw_management   : 1;
>  		uint32_t  pp_one_vf_mode     : 1;
> -		uint32_t  reserved           : 27;
> +		uint32_t  reg_indirect_acc   : 1;
> +		uint32_t  reserved           : 26;
>  	} flags;
>  	uint32_t      all;
>  };
>  
> +union amd_sriov_reg_access_flags {
> +	struct {
> +		uint32_t vf_reg_access_ih    : 1;
> +		uint32_t vf_reg_access_mmhub : 1;
> +		uint32_t vf_reg_access_gc    : 1;
> +		uint32_t reserved            : 29;
> +	} flags;
> +	uint32_t all;
> +};
> +
>  union amd_sriov_msg_os_info {
>  	struct {
>  		uint32_t  windows            : 1;
> @@ -149,8 +160,10 @@ struct amd_sriov_msg_pf2vf_info {
>  	/* identification in ROCm SMI */
>  	uint64_t uuid;
>  	uint32_t fcn_idx;
> +	/* flags to indicate which register access method VF should use */
> +	union amd_sriov_reg_access_flags reg_access_flags;

"to" --> "which" to become

/* flags which indicate the register access method VF should use */

With these fixed, and Alex's comments addressed, this patch is:

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

>  	/* reserved */
> -	uint32_t reserved[256-26];
> +	uint32_t reserved[256-27];
>  };
>  
>  struct amd_sriov_msg_vf2pf_info_header {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
