Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D955AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 16:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD4861406
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 16:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD4861406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6CC6E3EF;
	Thu, 22 Apr 2021 16:14:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0400F6E3EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 16:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJOS5d5KA6mqMHyuQQ4bffp20bxPhZgw71rrLlNGGYRdgCVW04Wxvct56QCXLzPiYSOf/JHjz+QOdUVm7NlzpdYYq8Cr9bF74e+88bzwIXP0dDyDV9oFiyiRy0EZYQXa3y+oA1TznEinvM74Zbq0e4D648/TCdNvjQGKWlzVWZnwOY89v9sJpfFISDgLBlWYaCmWXNBuyw0a+VLyPyNc092J9Cfh4uJSzFAOY5wrGC0mqv6qs31M9dlDQodxEajKeei1+5mI3MOECk6DczpLVOz2Bg98ji4TurfgDcKvQ786gPSs5uBQekraBFzXIfSsodwYLceXTIZ1Tb3kEASpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75CNeYPomsFzSoHAiEq4bAFlOjQl37zfZ2xrDaaxYSM=;
 b=GdpiNEcBeYqkihuPJZTaGB8EAWYk+4aTzAjtTUMV1Z7SduAtI4g1xgOmHAjPfLz5AJPClU2CQzQImnvCHpyIzYR8MBhj03+VfEAEKTNE78wBK9RElmY+nCSOp2qg4gDYU6duCCIkB8kJOPyk6y9V4IHA3f/RcwLYdw3AYVOt8nuMarih28hVMgUsJQH+6TOVCQTZaRorOZB74+WJFehG/PHP5lKYdVCDoAx62eYwAx5PW74FUWABbdiK9pCYfbIvL++KgQYiYxsQVH5xQIPGJ388XqgofjDYustPMxES0t7Dn5PewikRxJUrNxC4anhtfY/0/5JSoNXMIQScZxHV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75CNeYPomsFzSoHAiEq4bAFlOjQl37zfZ2xrDaaxYSM=;
 b=nIx5d480KULE72Gb/CbtkT1C8sA3NFjs3JmL3UAR4DzXKE86Y/cKLwrppn5uBIuggi4HN//tGPv4bwyDVlEviudmv/NXYImVrKef3OAWD+7I+sf2R5roDklQ2+tcRTmRxcHs7GwNoxf04VGaJZ8W0cWO2EAjcvvo1lykgTziW+E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 16:14:13 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 16:14:13 +0000
Subject: Re: [PATCH 3/6] drm/amdgpu: remove unused vm context flags
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210422154003.4048-1-nirmoy.das@amd.com>
 <20210422154003.4048-3-nirmoy.das@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <de09cf77-38fc-72ba-7e0c-bd01a49f7d56@amd.com>
Date: Thu, 22 Apr 2021 12:14:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210422154003.4048-3-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::14) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Thu, 22 Apr 2021 16:14:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 523d84d5-0b6b-4e00-c65b-08d905a9ab49
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4360CC97A6EBE6932109A3F392469@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31kARU1gUMn6vLJe93uFhDCS/+miZYZkOr7VCm+soF8/32I6105ejwXuBZ++/flNXUWf5Y2CLRTsFgu3wcPAPjU4uxFJ4jcOPyNzpqZAjiUYMooNOb+4eLxoOLw7Hj86hJdhTbjfAwoRSi2Zn4UUwde8Gf2LwYbVQTH83nUW+4R9QY0lAHyX+/qhnxGWj9/pwaVvwJlHhS0PJbb9ZOGKEl6ndoFVqs/Vo9RQN/0Xn/kpA2RswP+4Ey7QYAjW1zjq3zIo3AbGWDvmqCv+DivecBGgR+IdyDku6Fj6m+SvYkqtB1w1+qx34Xvbb9nXOJbnBlNdNZPYycGgDUqBfrUHlCexOMau7K7MU1KBMfzToguQcZMCCZY6LuNbB2I8T4c40P9d7KcNdKw8S525wqN1EF6F00xYo+rgQiiVDmRBcK/XD8CaFuw0JFWHKTUSVSP+8zeQDF+lRmYZzkHPqAYoFOtNZiM6xPE/9y9jCuE08MQJ9ML07hYlqKUiCApD8vfPxGe63fFfDw/wngDWzQVdHY2eQJKgo5q/ZNr3FeGPW0k3LRrE929mOr/SAbVsT9hox8QScwnWm4DuQZw+REwUHJz345IO24O0aIhqEZijOhPhFFc7kxbm5LQPOO+MdUhSb691FsEV5khoZdZsw0DCLlJaFcAq9BjhAlKLBpy2UfV4+xaX0Q5BO8Xlbcezxvke
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(8676002)(5660300002)(4744005)(38100700002)(6486002)(186003)(31686004)(83380400001)(16576012)(2616005)(66556008)(6636002)(31696002)(66476007)(4326008)(956004)(86362001)(66946007)(16526019)(8936002)(316002)(26005)(44832011)(36756003)(478600001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OTZET3NhelJ3ZHlOcURVOHpEWUdDWDVmdlRTSlNqd0hjVTRxblN5NkhhMitx?=
 =?utf-8?B?aFNzQmltZzY3bjl0K1Z1d1lOU2lTODErMTZRb1EzZGdUOUplVVBiZlRCNzIy?=
 =?utf-8?B?SWsramZ5ZFg4a2xvZEU0RlM3dUhzVzZjczVRSWFoZDVhcUpqQ2hLKzg2RWxz?=
 =?utf-8?B?Tk1RNFNuaGhOLzkvNEdPS2diZDl3ckNuQU8zeEtwdlVoVk9uOE9WdXd4TUtH?=
 =?utf-8?B?R3VUaUpSaENka081VnFRcE5SM0oxd1Bwc1Awem05UE8wdi9vNW80dkpnQ0hQ?=
 =?utf-8?B?cTR5Y3l3eWR1Zk5tamZDQjdmWkVEbGxvVVh6aWt0cG1kaHdKWENoTU93VWlh?=
 =?utf-8?B?ZEtCQkt1TktLQUM2RktYTVhNZHltcDdVL1ZVdDlpODNzTjJ5YytzWVl5cTFm?=
 =?utf-8?B?ZVVkQ0c1Mm03c0dQOGlUUk82ZjNlNi9yZkxwTXI0K2drM3EvNDNjQnYvdGxE?=
 =?utf-8?B?SlE0aGpYUVlMenNLNFFubTZxaXhYWEJjUXFKZTZuclFycUZLRjBxeXlSREFQ?=
 =?utf-8?B?dDZqSWozeUVvRzV4Vlg5M0paRVozUkpPWXlsQ2RuV2lkWU80K044c3VPcUI0?=
 =?utf-8?B?Mk1HeENGYjU2WHJPVzRPUDV4SVkxSzJVUVlqN2dHdjBhdEZPak5yazZtalZE?=
 =?utf-8?B?U1NTV1lha3BvcDE4cGVYTFQ4VzdqeVk0ME5WSi9ybW0rZk1oSk9PSDduaElI?=
 =?utf-8?B?ZzAvRWg3eVZOcXhTMmFIcmd0WGsvM2RZM2cvNHR1U2tyUmpxaXNjUE1PbHA4?=
 =?utf-8?B?ZC80M3lmaGNCVmUrOGdHbTRpaElyTFNzS1hjeWs0alI0T2l4NlBiUlgvVFI2?=
 =?utf-8?B?NUZlaEVSYUZZN1RETFJiUDFwMFpibml0V3doaGpITDczQm1DdDBYNkt6U3lL?=
 =?utf-8?B?MFRVODFRSnErc3pJUmt1eFpVc2xCaUo0dFJ1a2xtRmV3SHNKYTRGNzNRL2Vr?=
 =?utf-8?B?VnlUVVFzNTdOUzlqN0hERG9mbUN6eXEycUdqSGRnODFMZE0zUytmY3VWaGlY?=
 =?utf-8?B?TDVOd0N6bUpxd0F4bUZsYzNXZmtLODVZNXFSRHZSeHhVcGN1b1daZmdnRTVr?=
 =?utf-8?B?ZWJDS1lIQ0o2eGZPVk1TbUZvZFBFd1I3cmE1T2VUTHJJQk9aUUtCMHdXU3lV?=
 =?utf-8?B?M1piT1ZheUpPemJYMkVVOTJZWHl6MFI2eHBGckE5R29ING5yeHdvK24wcUJy?=
 =?utf-8?B?emRCdlM5c2JSaGJPWGpPaFdPVjVrck5qOVRzUmdnZEppTjYyYzVNZHBQd3F3?=
 =?utf-8?B?T3BFbVJRTHljbGdlNHRQWUlnaVY3aSttck93TGRmUjg2Wm9GYVlHbzdvYlMz?=
 =?utf-8?B?cWxHRCtzWEtZdHNQUXhZR0YzN1dXdms1TlVRYUZZeDEvcFRnUzEvdWtkME00?=
 =?utf-8?B?MzM0cXJtSTZleHdGSHpjU05XcjNQcms2V0hTSmJraTNyM1E3cjBvUkhvV1g4?=
 =?utf-8?B?K0Ryc3AyRDR5c21CT09BR0RIWVBnWDhoclBrU3dLMGVOdlY0M3ZLL2F4Zjhp?=
 =?utf-8?B?amZINWZMaHhXa29FdUhpeXROYVF1elRjalU0cURHMUQ3bDI4T3VjSElmcGVy?=
 =?utf-8?B?TGpyVEFkemZmT3dUdHQ4bFZLSzZhNjk4dTZwTGpJMURUcC9HYUk2d3oyckJW?=
 =?utf-8?B?dUlYa0tUMTlXNStyQ2YzNFZ3dys3VHNNV0lxYU8wdTRKVU82R3hjbzFZZXdh?=
 =?utf-8?B?VDhFVFhVbjlvOTdxSTZwaDlVNnFBbEJvcHlyaVFTM1h2ek0xa0JCM0lJRVky?=
 =?utf-8?Q?EeAqhrQeUoQ8OfWnjiWSzR5L6ndDBNchfsXYTzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523d84d5-0b6b-4e00-c65b-08d905a9ab49
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 16:14:13.3097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IrEHaPxr0gCKHydw3tWVYabydECd8VUbo7nDTrQYW0v8XdheHIwdye0aqVRQkz2SrgsImEPDjDQkhu3aO90sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-04-22 um 11:40 a.m. schrieb Nirmoy Das:
> Remove unused AMDGPU_VM_CONTEXT_GFX and AMDGPU_VM_CONTEXT_COMPUTE
> flags.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

I saw this too late. Ignore my comment on the previous patch. Both
patches 2 and 3 are

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 7f07acae447b..6a9dcedfcf89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -121,9 +121,6 @@ struct amdgpu_bo_list_entry;
>  /* max vmids dedicated for process */
>  #define AMDGPU_VM_MAX_RESERVED_VMID	1
>  
> -#define AMDGPU_VM_CONTEXT_GFX 0
> -#define AMDGPU_VM_CONTEXT_COMPUTE 1
> -
>  /* See vm_update_mode */
>  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
>  #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
