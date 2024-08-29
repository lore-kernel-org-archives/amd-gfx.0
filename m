Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95DCCA0EC7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 22:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9610010E76F;
	Thu, 29 Aug 2024 22:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3zjlMH+g";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7330110E76F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 22:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIH+WqBP7dvm46Lv/izcvoNjHRkyqmQMqkjIPaGhkdoITa8UC9g2RG1MwswP04XonMLDaObzGCGzUmxpL4j8YUzgH831O1M5idNlYhej2Lt9eRjC2CNSFS8k6yUw/SjQ6ivXs4i5HdAX0E1junn4v4pthOlqnsdjUj2FbQLzbENyr/HenzQyOQODyd9gBAooq2143BEuNPiOnRzgMF/1c1qKBb8w5x3uyoLH/zOVD2u5eqAPlLkt89wbse6GXBGX6bAEy/FviUYWfMqyb+rjMb47yi/cWs5DbJsAzdax/mcL2uPYtr1XYlfw3HVZS/PfczNRONCkfjV6FFXDLpK7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZq2pLKgBBECfP+jB6orTL8IGn9hnjeNklpsVBSDGzU=;
 b=L3k+umcvO6DVvIkUlpl/puKNwQMLU6thugK5MfrwRuvMXo0gsdUS7MZBuHOK4A/8MFG7LAJo8PkJLvnPmGa/WP+NchUP+fxA6dLmyl7pvKXwjJ1PZsKT2B4lpY0BR92aKIwvBUl/+jdaB7StZKaGoF/m6aeD4hOMS51teXjxADkXQfiyF4wBozyDdDY6DoaH3E0roU1JB3MhVwC9q5Ll5V2uXiBV1Y4t6G7tSH9RGttppNzC6htFqZUuRhQ84lMrp2sXWqRsfedcuEXG2OsLNY8PEkVfqERnIxAMzq7AdR+xKxjtSOV0at3XTsDEV+i6G7zuZQyL+OiXoEfjxW4STA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZq2pLKgBBECfP+jB6orTL8IGn9hnjeNklpsVBSDGzU=;
 b=3zjlMH+glYiOGgSMzmu16PsMAb3JvBUvFJ19FQuzpmj4FpknXo/AitOBANewzF+uc4D+CdWZZFdnsMORCPt8eyqSE3uvMAggpHTQd2/VkhRhSA0woOU4jWU+GxJpqN1g8pDzNkU+W802Py5E8Ip5yJUy+gN+9xkz61rmD21jTdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 22:32:01 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 22:32:01 +0000
Message-ID: <78d992ce-9a81-480c-9acd-5a176d40ada3@amd.com>
Date: Thu, 29 Aug 2024 17:31:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/amdgpu: Surface svm_default_granularity, a RW
 module parameter
Content-Language: en-CA
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240829221334.313701-1-Ramesh.Errabolu@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240829221334.313701-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::12) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: e652c4eb-23b3-4ea6-d805-08dcc87a6671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG03QUFtU2tQMlhXdkdCNm84L2YyTVFoNFhUSitkYUJ5SCtrOUo3MU9YcDdL?=
 =?utf-8?B?eW9qTkdQQ1NCYk1JS3h6UHFIc29hTWxoYlJwc2l5M08xYWY2K3ZMVkNXWXJR?=
 =?utf-8?B?QWN2bjdWWFEyYytLUmcyZmdaSHgwMGUrTlBydUFhbmduanVkQ1Nya2dDK3Jv?=
 =?utf-8?B?Y0VQZWF2TnFtMWoyL2J3K3F3eDNmc2w0RlJGTUhuRjdBMmxDNUw0Q1BTR2Fw?=
 =?utf-8?B?SzBhb1VrT0E4WE1LSkZPMjN2TTk0M2NMWnNqV2JvbTFsNUZ1ajhHQ0thQUU3?=
 =?utf-8?B?YytWWkRNekNreEdVL1lXamxlcFlVd1lUcEdNeWV2OHZqWmgzTHRSbVVnVzRV?=
 =?utf-8?B?RytkZTBzWS9PVHVCNExXMk5pOFBaeEU1citkc1Q2TW8vM21JUTRYbGZVQnhU?=
 =?utf-8?B?VXkySzNVb3g1VUppL2R5NWszWnJ5NTVoeW13azBJRmk4SlFlRW1jZHFYL0ts?=
 =?utf-8?B?bDVIWGpYN0tBTnUrN3QxTm55dDBlWk9EZGZFZ2dJa2VpbVVKUEJwaFBFWlFR?=
 =?utf-8?B?RXUwZ3lZSk1SNlZiTjhhdi8rV0lPMkZoL3VIOWhnRnFoR1dzamxBaE84SFVi?=
 =?utf-8?B?aWRHQVJCNTVqVjlTbStQSVFvNmxhNDBORXh0M3JveURqOEhWWm1YR25DalBG?=
 =?utf-8?B?WVZ4cWNOVFA5SVYzZlg4UHVmU1hnR2w0anN1aFBIZGsvYUVDeWFyVVNGUW8z?=
 =?utf-8?B?YjI3M3Y4SXpIekpKa2xNczFBOHEyM1RHYjBJUzU5WUlCcGNldG1KZHRGblhD?=
 =?utf-8?B?ajAwRWNRbHZla1lnTmMrTmswS2NwVGlaV2lXTm80emRJNVM5WnpuSnFGVUhJ?=
 =?utf-8?B?VmxiSUJ1OHFlR1ZKYzVUQTZrWWdyNzM4WE1TMms4VXhNNnZGb3hhZFZUVU5C?=
 =?utf-8?B?M0FPQmRIS2phazJFKzBiRENxTkEwTDIwMGxFRGlEeHB1NEd6Z3pjNnhNSGZt?=
 =?utf-8?B?TjRuakpldU1jUG50Y3JTS043WDRsZ1hLV0pYd05MdE5JM0k4aVI1QmJEWmUr?=
 =?utf-8?B?TXNXckJVSEZ6ZU4xa0t3R0FDakpoQkJ6Z3VPL3QvQzJ4c0dyRmV4ZkZsc0p2?=
 =?utf-8?B?U1E0Z0xWWUo0V3dlMUNpUnJZZDB5c0dmcmswd0YvV2hxT1VzaXA5UkQxWWNj?=
 =?utf-8?B?NVVHWkNTMWRNUWw3eFBJTFdsaUIwTHF4ZDJxY0hackowWHpyMEh5VUE2Ukgw?=
 =?utf-8?B?NDlaOWltM1hLbXRnWEU2dnYydzZzOXc0Mlk2REtkbEZNY09jVHAyRjA0bGFq?=
 =?utf-8?B?MVdWbEFMdWVDT01BTDlub3VDQUd2MCsxTm1vd3hSay9ma3NWYkxSanVzQUlC?=
 =?utf-8?B?U2crcGt1YnFmajlpTFVpR05wSzdMUXdHaDV4Nnp1aWx4cHQ1MGsvQ2RSVGND?=
 =?utf-8?B?Y1gxQVhsVTJYRjAzRlk2WktQQkFyNXlsbjd6STRKV3N1aVpidVlqYlAxSkU1?=
 =?utf-8?B?MGVoSE4vMnBHS1R5VXNlK29uL0o5Rzhwd1lmMmp0Zy92cG5Vd2N0RDhwSU9S?=
 =?utf-8?B?Z0ZJejBtcGhDVVZLOS9YRG83R2gwZHlJakg4SjJYQWwxZXloOU04S2VpYWk0?=
 =?utf-8?B?K1FITEdpMWtYVjBhcFlHTlJuSFdKL21FRWpucHRtY0IvYzhqQkNqL3RKUDdm?=
 =?utf-8?B?QlBUMzBNRk9leHJHSTU5ZkdRSFR2ODR3Ukw2dWlwdHdwN1prSTZxeUZkNjlL?=
 =?utf-8?B?ZHBXZ0VYU2VSN3RucmNRM3ExbytCS3JtNUVaa1dEY1RMZEVBUGxBOTI4NWZq?=
 =?utf-8?B?ZXlZOEJORWxJeEh3ZGNzMHIvNCs0eUsrVlZmcTNUU01QdVhIR0NaTVBEZVZs?=
 =?utf-8?B?T0E4ek9teVFVeTN6SG12UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFUva2lWTG5UUWJKbWloTDYxaThndTRudEg3eFp5SGFmSUlkTkZLU2hISVEy?=
 =?utf-8?B?bC9mR3dQTTVLMW93akw0N3hwRGFDS1NvTVBSVHdGbFdXS21wNTJ4V1NRazdi?=
 =?utf-8?B?UEM4b2VwV0ErVkcwVm84R1duVWpQUm0rY1ZOSHZWR1N0bWxlZ3ZKQmF6YnNt?=
 =?utf-8?B?Rjk4ZlN0OFRhWkVlZ05LY0xWek9PYVJlVnhRTUdmQi9MQ3BpdkNNcEczckdK?=
 =?utf-8?B?Y01Hc2pFamZZRHFXclJsTDFnSzRkajV2a01sUjBibkNKVlJFWkVtTTV6aXRJ?=
 =?utf-8?B?K1M2bHJRSk44Vzd3STB6UndvUVU4YnpCdU0vTWRNdEsyMUhkSzF0QkN6VTg4?=
 =?utf-8?B?LzNZZ3l1Wm9PelYxM3dMSi9hQlZwUlRVRGlZYmMrb0VvQjJOKzhKbDFGMWJL?=
 =?utf-8?B?U25lNkJsUHlmMVpQdCtZeFR5M0lNV1Vma0tzT2ltSyt6RGJEa01ielVHZHlB?=
 =?utf-8?B?MGNnMjNRaXV3cUJraXdDUmk5T0V0US9Cc3BiOG9JeCtsczFGZklHa0Fpalo1?=
 =?utf-8?B?MXBRS3A1SHVZWTM0TXZhbzdGeGZ0YkJsdjlrbGlDY3Z5OVBxUTdnRkF1OE52?=
 =?utf-8?B?UldYR01WUDZibWhYUDNHcVZpKzV2RkF4aTRLeFdIMUtKMHRCTjVXbnJSdGFR?=
 =?utf-8?B?QTJxZmJ0Q2lpNVVoRkFIWUxEK1RzZGhFR3JTSFViRUpQeVUyMFd5YUFRL0p0?=
 =?utf-8?B?Tk1mZVEzeVpPOEUxSXIvOHNuN09IejB0ZFNRZHJQQkRRRExxOWFVNHhxd01T?=
 =?utf-8?B?QVRYMmNQZVEvZ1dCVHpGWGxGaUdVVUN0REUxOXZ1OHp0bkhMMG9xVTRBSjdp?=
 =?utf-8?B?VURTRnVMVmMweHBuOTBhWm5zSE8xSS9xMGxCN0lOUFlMK1lYMGcxRXVObVUz?=
 =?utf-8?B?aEV4bnNHdldoZXV0QmsrM1BRenBGa25sM1kzS1diZTgwZjNHenVJN3pkUE91?=
 =?utf-8?B?TDcxRC9ZUGszcVFsODlsbU1ZTVlGTXU1bEdHS2tyamxKa1ZVN3FmWGJOeTht?=
 =?utf-8?B?VGxDSXkvMU40Z3lZQ29qajZ3dDJHN29EdmZxMnZRUWNJNHRoT0RnNWV2ZlNj?=
 =?utf-8?B?R3YzZVdvZlZoaTdkRXFYZ005WVpjQ2RYdlFVRDZOYkZETzROUml6TitHWjVG?=
 =?utf-8?B?VjhsdHh5a0FCejBvcmUrUmFhdkxBYmprM0hvaGF4YTE2STJPamtLMEY4aTRX?=
 =?utf-8?B?RkZwRkNCMkJmZzhLWmtRVHRIaUlaYkNDTUphK1BUZ0MreCtZUUpYd0dFcVNa?=
 =?utf-8?B?M3hUanp4Nk1uMnoycnZNbitUZHZ2QlpyTUJkdnF0TS9pQTdVTFZPNWJZb3BC?=
 =?utf-8?B?bFZVRHdxUlhtNkZNMnlMa3dtSEFFQUpuZ3pQMUNSM1ZnOStCM2hCaUhmS0dk?=
 =?utf-8?B?UXIySGpTREt6SSt1L1ZxNjVCVjJzUXpQRHpGNDdGOUFjMWgwVEJVMVZFQzMy?=
 =?utf-8?B?cy9ISksyUmp2SWFhd1hpUVNGNFl6Y2hrczNaYmpVSFNjZFRCL05Jd2lBWVp5?=
 =?utf-8?B?UVUwVkdYY0xSZTUxblZ2OFBzOXVjYmlmNnVvdHNCYUljc3k4T25NVmJaVEVn?=
 =?utf-8?B?TmMwWHlZdzlVUm51RnA4MHRLOG5sNncrS1VOOHI5OEVhZGxzZGFjOHVld2Ev?=
 =?utf-8?B?S0pDUllKRnk4RmJHeWhmdzlzM2VGOUVNUStTa21pdlNWUG12M1Q0MTBqU3ZY?=
 =?utf-8?B?akV5T2gxQTRKbThydjFtTURHNXJ6WUV1TEd2VG82cUdjNFZFVUJXbXBZQzk3?=
 =?utf-8?B?bWtQNVRYODByWWFWcG9JU2xTeURsdWNmenpGT0NHZHNwdm9COUFWcGRJNVpG?=
 =?utf-8?B?QU1tNnVlNFdRRmZnS1hlWnF1djh1UUx4YUh3UEl1NmdUbmZEcnFxejlLd2cv?=
 =?utf-8?B?SlVQaTBRY3NXcS9LNk8vWWFEVUpzM1VScWE4VUROY0J3c25LYVl1RG40bUZO?=
 =?utf-8?B?OU1FcmtUcVErMmViRk5Pa2RlYWp0QWxtQUN1NVJORXAraDFERC9RNXZtRHJQ?=
 =?utf-8?B?bHNmN2xYWjJZd1l4QzlqN1ZTU3VWT1lYbStVZ0RXaWlhMTdVS1Z3YkZqaFFh?=
 =?utf-8?B?SkROL2Rnb0hvMUo3NHBsckRvUndTbldmWnJlTENpM3hYOGVZQStBMTBPTHZZ?=
 =?utf-8?Q?IbaM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e652c4eb-23b3-4ea6-d805-08dcc87a6671
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:32:01.1090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpQSy6IP+ra5cA1HtZNdpLKAY1JeVGufMziKgxqPN5/E+EBtaRUfKPSbctMi8W38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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



On 8/29/2024 5:13 PM, Ramesh Errabolu wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Enables users to update SVM's default granularity, used in
> buffer migration and handling of recoverable page faults.
> Param value is set in terms of log(numPages(buffer)),
> e.g. 9 for a 2 MIB buffer

Forgot asking if this parameter is request from customer or used for 
debug/experiment purpose? If it is later, how about put it at debug fs? 
There are already many driver parameters.

Regards

Xiaogang

> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  6 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 25 +++++++++++++++----------
>   4 files changed, 39 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e8c284aea1f2..8eb934af02f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -237,6 +237,7 @@ extern int sched_policy;
>   extern bool debug_evictions;
>   extern bool no_system_mem_limit;
>   extern int halt_if_hws_hang;
> +extern uint amdgpu_svm_default_granularity;
>   #else
>   static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>   static const bool __maybe_unused debug_evictions; /* = false */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b9529948f2b2..442039436cb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -169,6 +169,16 @@ uint amdgpu_sdma_phase_quantum = 32;
>   char *amdgpu_disable_cu;
>   char *amdgpu_virtual_display;
>   bool enforce_isolation;
> +
> +/* Specifies the default granularity for SVM, used in buffer
> + * migration and restoration of backing memory when handling
> + * recoverable page faults.
> + *
> + * The value is given as log(numPages(buffer)); for a 2 MiB
> + * buffer it computes to be 9
> + */
> +uint amdgpu_svm_default_granularity = 9;
> +
>   /*
>    * OverDrive(bit 14) disabled by default
>    * GFX DCS(bit 19) disabled by default
> @@ -320,6 +330,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
>   MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(msi, amdgpu_msi, int, 0444);
>
> +/**
> + * DOC: svm_default_granularity (uint)
> + * Used in buffer migration and handling of recoverable page faults
> + */
> +MODULE_PARM_DESC(svm_default_granularity, "SVM's default granularity in log(2^Pages), default 9 = 2^9 = 2 MiB");
> +module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint, 0644);
> +
>   /**
>    * DOC: lockup_timeout (string)
>    * Set GPU scheduler timeout value in ms.
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9ae9abc6eb43..d6530febabad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -868,6 +868,12 @@ struct svm_range_list {
>          struct task_struct              *faulting_task;
>          /* check point ts decides if page fault recovery need be dropped */
>          uint64_t                        checkpoint_ts[MAX_GPU_INSTANCE];
> +
> +       /* Default granularity to use in buffer migration
> +        * and restoration of backing memory while handling
> +        * recoverable page faults
> +        */
> +       uint8_t default_granularity;
>   };
>
>   /* Process data */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index b44dec90969f..624bfe317c9c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -309,12 +309,13 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   }
>
>   static void
> -svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
> -                                uint8_t *granularity, uint32_t *flags)
> +svm_range_set_default_attributes(struct svm_range_list *svms,
> +                       int32_t *location, uint8_t *granularity,
> +                       int32_t *prefetch_loc, uint32_t *flags)
>   {
>          *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>          *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
> -       *granularity = 9;
> +       *granularity = svms->default_granularity;
>          *flags =
>                  KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
>   }
> @@ -358,9 +359,8 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>                  bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>                              MAX_GPU_INSTANCE);
>
> -       svm_range_set_default_attributes(&prange->preferred_loc,
> -                                        &prange->prefetch_loc,
> -                                        &prange->granularity, &prange->flags);
> +       svm_range_set_default_attributes(svms, &prange->preferred_loc,
> +               &prange->granularity, &prange->prefetch_loc, &prange->flags);
>
>          pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>
> @@ -2694,9 +2694,10 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>          *is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
>
>          start_limit = max(vma->vm_start >> PAGE_SHIFT,
> -                     (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
> +                     (unsigned long)ALIGN_DOWN(addr, 1UL << p->svms.default_granularity));
>          end_limit = min(vma->vm_end >> PAGE_SHIFT,
> -                   (unsigned long)ALIGN(addr + 1, 2UL << 8));
> +                   (unsigned long)ALIGN(addr + 1, 1UL << p->svms.default_granularity));
> +
>          /* First range that starts after the fault address */
>          node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
>          if (node) {
> @@ -3240,6 +3241,10 @@ int svm_range_list_init(struct kfd_process *p)
>                  if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>                          bitmap_set(svms->bitmap_supported, i, 1);
>
> +       /* Update default granularity to one bound by user/driver */
> +       svms->default_granularity = min_t(u8, amdgpu_svm_default_granularity, 0x1B);
> +       pr_debug("Default SVM Granularity to use: %d\n", svms->default_granularity);
> +
>          return 0;
>   }
>
> @@ -3767,8 +3772,8 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
>          node = interval_tree_iter_first(&svms->objects, start, last);
>          if (!node) {
>                  pr_debug("range attrs not found return default values\n");
> -               svm_range_set_default_attributes(&location, &prefetch_loc,
> -                                                &granularity, &flags_and);
> +               svm_range_set_default_attributes(svms, &location,
> +                               &granularity, &prefetch_loc, &flags_and);
>                  flags_or = flags_and;
>                  if (p->xnack_enabled)
>                          bitmap_copy(bitmap_access, svms->bitmap_supported,
> --
> 2.34.1
>
