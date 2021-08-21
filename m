Return-Path: <SRS0=VaLP=NM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4239C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Aug 2021 02:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811FC61131
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Aug 2021 02:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 811FC61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD85F6EB3D;
	Sat, 21 Aug 2021 02:44:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 556C46EB3D
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Aug 2021 02:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2AbihwOj7pDAlGc8WZ88C0B5IGVZQgdGo5morP2v3lUWaZOUq1GtzZJff+gve2aTvIfZPfJkUc4xQvz+0SDVG/Gv9CQlp+ChZAbXlxPszWYcdWRgb73+0ACDlwtFJUzsAfbgFg11RhtdKEYgsT9iB7QKgpp+aIY55RLreowyAAjjloVNPdtCL1wpbIT1XX5+cKF6uUBPlzyknX74CyYx6NU+6ui7tD77Rj5LozAjOsJgK7pBTG5pnzmldUj3sWq5HZO3gXnVBjaLBorAngcizzgXaROfFyMOqIvvldRf0q79dmf9XlA4IrihJ8qp7YF4z9WcKLuGynfWG8whB+HfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFIMvWyRjKhJy8uPTVMCJWDv5u+fsW7uMzxDiH/Zd40=;
 b=R48b0a/t4RhrMjJNx+TNDQtD4V3g6w8f9mNcPpkQLnKy5KUBkrHZHYy1uoW1NjeemlxnzdKZaUSMuqzbOGTXJZeD74kkbA7lZ78geqdl9nlEyEC5rPy/vTw5RxYd3RuowrHbNMqvKOWf6rywqNf2KLVoghDLkHB+Y9pMFzD6mXagy/o37DPC2vghzpYS9gnI6Fbv3/Y2utVcmZvvAOw78JExVgQxQZwgeta2zpt4dgAGsqQ6j9Cv4ceoaevCXdgyH/DX8leBKJ3GBlQeDwJF5xlILV7m+4VHu6SDAnwqnVY8SkZnzQEluZ6sdPiwhIvrjNVykjD6cCW0Wnpaw6dIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFIMvWyRjKhJy8uPTVMCJWDv5u+fsW7uMzxDiH/Zd40=;
 b=ZTLvdBP3rgYhW+wbXPobhJWysFIanTVW0JmQG9rndMbqZaDCj+ON4czWdtLjXuTWPpZKjsWZjf20cHYu90i+hEWJcqrq1SA/+4BugoRD2kyeKh+YPdHoWh0FlbaVQZ8bTH0W0NDbuCsIyYPJzJXierrnXIxrW+35Xc5cRNvVxLk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.21; Sat, 21 Aug 2021 02:44:34 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d9c9:efd9:88e0:4b1e]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d9c9:efd9:88e0:4b1e%7]) with mapi id 15.20.4436.019; Sat, 21 Aug 2021
 02:44:34 +0000
Subject: Re: [PATCH] drm/amdkfd: CWSR with sw scheduler on Aldebaran and
 Arcturus
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210820191147.18644-1-mukul.joshi@amd.com>
From: Amber Lin <Amber.Lin@amd.com>
Message-ID: <c5192a0d-660c-1336-a0dd-93dfcbaaa47f@amd.com>
Date: Fri, 20 Aug 2021 22:44:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210820191147.18644-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.144.224] (165.204.55.211) by
 YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Sat, 21 Aug 2021 02:44:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c2c2ca-ee7d-40e2-d052-08d9644d9bea
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2988C17F01C58A0DEC60509AE1C29@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4tY59CSr4RhDcxFcMo0QjRI81wGiI4FwbTQHUhTtEtzgUyKrXlZ67ygqOoWPiEHmh+KkJ1d23NvAnzicQZsr40rQAloZnt36aqvkIfxEL2LrKZLVQAmoiztihoDb15npSUS31UF3IWXK6wCSGC3BcAiwP9TutMo1kmuK8nTqKM6v4p9FbRTFUABVyyK8B3FV/H3cGyrtpLgRBHf8e6U+MkGyIkW4j1SBddrabH4uI53VyfFm+1pHdbgSkYlMSCEOKdAxNd7gjkZkvz2RuKjCkoUUYGb5jtypu88cyEPNVJlLymTiUY1ohCFbuDXrZaUwe9LMyDx2097xgcE9hzYVyfsjf5uNVWe//Z+P9pO9xmLw3yutzO1lMOlfOnBhpYtdSa07MYM4AJEVKgjq0+b0IQSP/dgfCH/oJDbaAVTQ5LXrpNXwXkUrA0ABt9AAntk8+lq8Ey0lNJr57RJnSXVLjcPbG37nTgfbVXCeJgX33WuHH4BkAyRZij02P2rZ66c/a6i7jArD0dh97SslfLvM20T5DZjIkPhJVNKiXX93vdYk41DuFkWSOeitH7fFhmIncm7aj6osEKv9rh56IXb4ZlxMs64fPmjSKlY5P2lBzqezs8Ix7HlDM3O/8WkC2/KGhlfYZm0B2kyFc3DHerFsX38zfRFTQKBCs/RP85VmiGUR2jyJGRi9d0nMiMatdrP9gjM7doMO0Tgg7Hhkx8TL1EakpgCIHwz2E1bm7jjwazdFV+/yDxtiqzJHwB/j1C86zrDD+qCTz6gaKKvMXnTeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(5660300002)(186003)(53546011)(86362001)(31696002)(2906002)(478600001)(36756003)(26005)(83380400001)(52116002)(16576012)(6486002)(316002)(31686004)(66556008)(66476007)(66946007)(2616005)(956004)(8936002)(38350700002)(8676002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWNLTGp1VVJyck8rZW95MUFwaFRvWnZyQmJsSEhEQ296WlpSQUJ1Z0VuYUV6?=
 =?utf-8?B?TlBQblo1R3QxeUdPeG5vdE15VldMQVdaTUtZTjlQc2h3c2l4d3JMaS9lYmdJ?=
 =?utf-8?B?akJKSzZ6WnJUcVA2amI4T1kzV21Sa1M4UTdSWG8yOFJNTi9WSSs4ZVQ5b2pJ?=
 =?utf-8?B?clNteUhoMzZQMldoVFNwb3ArUU5hMGYyMk9hb3dKb0kzL1lKalo5WFpVN25I?=
 =?utf-8?B?V3dya3hraTFzdXNSN1FpNjU4NWxZWFhQUWhkSmVmY0puUVBzOFhubm5ZR1M0?=
 =?utf-8?B?Q3R0WElYWnZiUzdOdFA0TDk1RWlDN1U5eWwzZGJwOHlFS0RIMFJpaVdMUVpz?=
 =?utf-8?B?aUFSeG9JaGdPZUprcElvU0dKaWw2QWV4V1NCYk5nMUtWY2t1VHVmQmsyMXEw?=
 =?utf-8?B?WmJVS3hxODIvSE1IWUNXdmVBS0VsL3ZSVXVmeXlxMnc3RkpwY05BSTNIUXI4?=
 =?utf-8?B?R2s2QzUrblRrVS96T1E0UEZsNDhiTm1kU2FIcVA1SVRSd21hOTRZVXZWMitE?=
 =?utf-8?B?dVQvZGR2NzRWNWszZlBqQjB2cndhQWwzdE5ER0E1UnNFSEo3NExsdHhVTHJE?=
 =?utf-8?B?TlJuZ0lEeUJkT3c3QTVkR0I1ajNESjdXaWlXWkt0VndIV2tjWWs0WUhNVzhW?=
 =?utf-8?B?RjVTb09walZQT1JSc0FUUDdNTVpsYUtqVWZDd2cxSUJYUHdHcVljZGR3LzJs?=
 =?utf-8?B?aUpDMUNGUHZGMUFCZkdZcEVXT1JFOStzV3hZNTRMOW5CZjVoM2RNRVM4VUFv?=
 =?utf-8?B?N2NqVDFjR3dkemZNT3NxQ1RDMFlUQ01XOStIdFlGRVRmekVBWlQ4ZnVwVmNS?=
 =?utf-8?B?TVVqbTJjbnp3SkxsVVpYUXVhVTZ2Qm1DTGxzcDVlSDN3TXFKNG5jMWNES1dy?=
 =?utf-8?B?SmZIUHR0ZW9UMnFmb3ZwYnorWmV0TGhBT2lybWMrTS9wY3ltcUFGV2E1M3l4?=
 =?utf-8?B?SjY2T0hEeXRTMjMzVVpaZmxmVUJLbTBsbGQ0ckhydTZuQm9kY2ZqNHJSaU5O?=
 =?utf-8?B?d1JMSW93ZVU2TkNXUWtaSHc0c3ZIKzNzWFBHV2sxNmtIc2RzOStIS3dNRktu?=
 =?utf-8?B?Y3BaOTlBK3E1VGxNQUNRVis2aWhBeDZQVGxCZnlYQmhxZ0pEZzNXTGlHY3Q1?=
 =?utf-8?B?Q3hoSjBQZkdZYzZ1OG95TUFOOCtQU0hQajlxSE50WVJYcXdueDUzV3pVR3Nk?=
 =?utf-8?B?ZDZ4aHJFMDZVbllTL1JMcGp4d2Mra29yL2E5SFVOaWtKMDBXSUV4YXlvTHNx?=
 =?utf-8?B?QXN0RHYvQjByQ1Fnd09yNm5mcGlXeWZOc29DWkJTWHZGQTZQUVB3NGZpQ3N3?=
 =?utf-8?B?K0tjd3FZN2FkaHFmeW1CTmtCc2RDdU1BeVh2VE1aSjVRZXo1TTdIVHptYnEw?=
 =?utf-8?B?eGdQTHhtQU5jZ0JEbGd6cVcxOTVibkdlUTh5QnlKZ2tTTkY5TzkvczJkaVpV?=
 =?utf-8?B?Nm15MkJJaWVCNGNCRWJ6N1JzWFdML1FBODl5SVJ0Q0xOR0ZSZnE2SkFMRTVF?=
 =?utf-8?B?S3gyMHMxcCthRnBIRCs2RUVGYTdJcUkrTld3RmF2TlM4aVhEdEFyYkFQYWhL?=
 =?utf-8?B?MDBZWmNkWkpKcTlMd0ZQMGNLdFRaTytCLzVJWkkxUDU5aUJiazdGbVZ4eFQv?=
 =?utf-8?B?dGVBcCtWVHN4UzNNQ0hTeEdBdmVkbGU5M1RNekUwMWVkZVJLYkV4L1FwcXlV?=
 =?utf-8?B?UGJJeWdzcUJtb3FIaFhqK1h0ZENKUDhYWVBCbTVxMjhWZDdKNXUxa3Y3SHp6?=
 =?utf-8?Q?gCv/5GJyXkdW+no0o4astit9bgqr9cq1w74QJFy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c2c2ca-ee7d-40e2-d052-08d9644d9bea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2021 02:44:34.2771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYjThl+9F5y/g8FGoYKKgbAks1im1Tsjzr/207G58MJoeYmt2mbvc0fZFcSHGg0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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

Reviewed-by: Amber Lin <Amber.Lin@amd.com>


On 8/20/21 3:11 PM, Mukul Joshi wrote:
> Program trap handler settings to enable CWSR with software scheduler
> on Aldebaran and Arcturus.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c  | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h    | 2 ++
>   4 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index a5434b713856..46cd4ee6bafb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -44,4 +44,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.get_atc_vmid_pasid_mapping_info =
>   				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
> +	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 6409d6b1b2df..5a7f680bcb3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -305,5 +305,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
>   				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>   	.set_vm_context_page_table_base =
>   				kgd_gfx_v9_set_vm_context_page_table_base,
> -	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy
> +	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
> +	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 154244916727..bcc1cbeb8799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -882,7 +882,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
>   				adev->gfx.cu_info.max_waves_per_simd;
>   }
>   
> -static void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
> +void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
>                           uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
>   {
>   	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index e64deba8900f..c63591106879 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -65,3 +65,5 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
>   			uint32_t vmid, uint64_t page_table_base);
>   void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
>   		int *pasid_wave_cnt, int *max_waves_per_cu);
> +void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
> +		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
