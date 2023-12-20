Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED8EC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 14:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F5A10E583;
	Wed, 20 Dec 2023 14:13:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDB810E583
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 14:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGrVDkYa1xxhDzYlvmMM5ptdRqN6QuX4kkXtisGNCPyqh4kXDfB8hI0bYR+i4srdJXxJGQu8vBPOHuoFDOQRi7mUCnCES61TxmNmbbXOv5scU+le4COXuWBAhKGxf3tP5+SSNlGy5u4+TjiS1e9TDSm4dDVA4bnNXLCexF6ZE1wQwPVJCJI6J1sRc+Aounk7ORzAjhsFywXqWZDwnUJdzi0OQgZIXPu1Rtf7poNrdhvXhYewfOapjA3r8hUZTEtMMDJAPbc1Alg8mpdy/WRgjTRqeAVLLJbqtybCdLAHlDOCTxefSGaGsTbQINajEr+/ri/Q8umqPkO+zG+V3Mq0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwoLE53LSKqWuBiacw4eE906tg2DSZS3VZPoWqnBPG0=;
 b=S7vzo496VYSE8kJYMCtYTyZvmujOY9vmsvfgAJviRia6Tzt3UM0Ln17J4ASxZm7Vz//07Lj+4jGPzOBAqIrNxKMjFOC7sdMeTp5hZwgf3bHj50eW7lwZHAVJAT2aVFVN4cTrvzxclwLH5czU6tBxjyzojqRBciupAhYPiieyV/SAN5JE7PiLqpl3bf1KqwGjl6PJMmgXHiNMvnPuMxbLxiHrer/ugCciiJUcBVVdU0icxdUZZLxft5OUrTHhQAoCBDIRkCv44k28OglBLR9vYsFOKaNz5T5GO5So5ShsryssMHBs9QbjgX5KdRcFGCW1amhIrRG9+oWOVPENnofc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwoLE53LSKqWuBiacw4eE906tg2DSZS3VZPoWqnBPG0=;
 b=3AiiSH4ottzpLqxv4lDOTdEbyRYngUq8Lbv1TJKqyCaaq7+8KTDM6ky1M7pP5yAJ4UwPevnQDl8wZadxaEhwaUaLeFq8CqIM6JljR+EPuWpVkW2stsgAvkAL5MHBO1k2hh+7aI1IWzx/zrvClNVdj+EjtPpVPnZhcBxMO5/jx5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 14:13:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:13:02 +0000
Message-ID: <508504f8-f483-416c-af52-dea1560cea02@amd.com>
Date: Wed, 20 Dec 2023 15:12:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove unreachable code in
 amdgpu_xgmi_set_pstate()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231220135602.933841-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231220135602.933841-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 0660e7e4-d20c-48d2-da31-08dc0165c70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxM9FKfpD39yYQZ/p60KCmlK1FCC+t0r00/lU6C75INekJepxgroDOTy3zeoC+U9cHHlcPzlkEabnKBy2iNT1HWIPoPO74yhUejqWdn08gE6AAr+WYMMIIfsFm6Kfc4ajHH0hgJ8YJstabuuhItDtrFj9jvee8BMCeqQV6Dqk5usqrlz07xLApaH/Nc7MDfw/cx8ohfPS45g9RkGea1Zw6l92BgkMUurIbLp82xsI7jocaxgFYJtgJezlDkddhDDvbqb6H7t620A0h8noS4d3wnUH09U1mbj9ywnPD9OeZggjvMN345zuB+RUxhuIRlKrk54jHAOZIo/3NnfR4S9GxJK+JvcdyK8Drby7UH1GKnMOo20x/AZFX9JTd/OaXamWKAeuQL9/kig1+IV2hlDsWZ7bPhQNrp3M3f8Nki88WKmASiWEYbhb+a64z7pmbSmcbCroJ2mojeRBvMnPLAUKcrnzo3rgPMHMvT/0mdKklnsuJvVYXZRIEnD1Cqhny4HgUd2KIw0JsbJ68x1qOIv+1+tNzG5CLDNvgu+oEJhyoIKuq5aT2Tc4nbvNyPgE9HvzLN/0ufnu3LWBMQxxBu0iGjCdDQVLR+X5PEqycvQKEIHRn/WewZKfbJ4N9OQMkspLqS79hZqinZU5RA1mmHCA//Pu89uCWIJAmRRESO7Y7qoZwMEFtGVb3UDh42R4DNO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(6666004)(6506007)(6512007)(6486002)(478600001)(26005)(2616005)(66574015)(83380400001)(2906002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(8676002)(4326008)(8936002)(110136005)(316002)(36756003)(54906003)(6636002)(31696002)(86362001)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWJabVBpS1ZWem1GMGZWbCs4T2RqdVdIT3NKcEkvS2N3QW5lQVZvMVRyeWU3?=
 =?utf-8?B?YWIzaW4yZVRRSlVxQm4xNVBIRVhWUDRQQ2hDYkZkVVBNcnozTFRkYXVERHJv?=
 =?utf-8?B?VWRaMlZaUlJWeC8xRXRHa0ZDWmxySGlwMldyUHhGM1liaDNxS2Y2L296eW41?=
 =?utf-8?B?cmpnYzAyMCtRb2lQSHJ3cWNuSHM1S0QxRU1OOG5TRTNCcHR1VnF6QklDZ3VD?=
 =?utf-8?B?ZWMrbVdXSG5HZ0xaNm1mYVd4d01xcW04TkR2TW1PaWx2dnlZVjN5K0I5dUlQ?=
 =?utf-8?B?cGxuREgwMklCSVNWS0xOdXExaGdHR2FVUG5HRXhDM1EvWTRzb1RBZnVuTFNS?=
 =?utf-8?B?a2FCYTVIUnhISWlhY3UySFNsOHdNcndMUkJ6OWZLcUoySUEyUWNkYVc0Lzg1?=
 =?utf-8?B?ZjBSRGcrd0FKakxmK3ZwbHFIY0ZUUGlGcTlPemJwVUNBc2JTUkg5N2RvRmFw?=
 =?utf-8?B?OWJucE9YYzI4SGRXQ2RJc1BzdEZ6cW14WDZROU94YUJsYVpVZndLOWxuOE4v?=
 =?utf-8?B?NUF4eDhFMUk3RlFaYSs4bDBEdFNHNzFNK2l5SHRvQUJlUEora09BMnd3aVdI?=
 =?utf-8?B?Y3AvS1R5SC9CSEZCbWZXTytvMWN2K01KanJZbDRpRW9XTHEwcDN6SXFpNmJI?=
 =?utf-8?B?T3dyQmI4SnJaM01ub2w5dG5yUk9RZ1RnYUorSW01a1ZVUlIvdXZGc3pBSWRK?=
 =?utf-8?B?eEpwTVV1eUk2QkVvZnFjcE5vMHNDc2hUMnFNTGJsYnJxZnVLSEgyNVMzVXdq?=
 =?utf-8?B?TGRzUW1QU3dZTHQ4ZmhtWEtGL1RQank0QmthTEZJNkNUS2xyY3h5SERWMEEx?=
 =?utf-8?B?MEVnRnNCYStLYWNsbDBTd2VXR3MzdWtiWlEyeUI2SVBEYnVzVFlMKzNTcmVH?=
 =?utf-8?B?Q3A0USs5TkZSc0xPU29IMFVsRXNxYTk4MDFmWnExU011dEZNdzJObFY5QllM?=
 =?utf-8?B?SVc0NUZjSGd4UmhGZTU1L3l1eE5CVUZUdEQzazNYUEQ1Tm1zSmtBUGhkVnlz?=
 =?utf-8?B?MDdPazBtUXJaQzlQNHJRWHFhUURCSzJhbHRqV2JVdzlCeFM3cWlMcWNUTXVO?=
 =?utf-8?B?VlVnMHlJaXAxVzNhQk41QnQ2SjhkZERXT0VBYjl2TzlKYzFFdm9TWWhFSjk1?=
 =?utf-8?B?ZTRSYVZBZllaTi9KdGQyVjFIQzNYdncxUlZzcjJKQ1ZVblVkTVQ3ZjJBM0E3?=
 =?utf-8?B?WENtNUpPTVNwMU9yaTdYWDhWN3lCellXSmxyZ0FVQXRaSWcxTTFHVlRPV1dF?=
 =?utf-8?B?VE5ZaG5zOURrRFlJcGhvQUlZYmNPR0d0Y1BnVXVZVlZtYnFMZE5XZXVPYS9K?=
 =?utf-8?B?T3FubXJXL0NSeFVJby9SQjJwNTZMeFcwd0dWODRuL1F3NmRQLzFIVU1VeEFv?=
 =?utf-8?B?RW9jTGw1VnZKSUlMMHhWemFkcGt5VE9tbmt6aE9ocHF6Y1JoMTNacXdMcUx1?=
 =?utf-8?B?cHc3b3pyM3hPUjRlaGdmeitlVmR4OVkrVWtnbmhqUUJEekxBUkwvUndUREZp?=
 =?utf-8?B?TEdobEdyVDFubXRETURhbGRPTDM3YU1TV1BUY3RUTXBjNDhnbTJLOWxsVHN6?=
 =?utf-8?B?UmFsOXlaaFBYWmFRYmRJRlJORGwzQ29KRjlNekUvb3B3K3h3cjMrc0kyV05Y?=
 =?utf-8?B?eXdIdGYwd0ZQMWdSdkVUcnBUUmsvQTBMZG5aK2pmRUxSdXNvbXcyQkFGQkdY?=
 =?utf-8?B?YkNVRVBUK0hWMVNFaWNSOUovVUkwaUcrZ0U0bnZlRy81Mit3emJueEgvcTgx?=
 =?utf-8?B?dlRHZ3l1Y2htV21meWhoTUVubER4MjZUR1hkVmhoY21seDFOVXJYdUNJbVFz?=
 =?utf-8?B?NjQ1dWRicnVLTjduek80QnV5UDVlaTJySDF2V3hkZ3Z6N3RQQ1ZWSkFlZkNv?=
 =?utf-8?B?UHIrOFdyaUdhT1pqTExVL1Y5UTgwUDJOaEYxa0NBZGIydWNWZ1g2UzVxNUVG?=
 =?utf-8?B?VTFnMUM3Y0NSUkFFRTdyK0lUcU9xNGFFT1lQV3YxamRjVlRLS2FjZHhDdjlO?=
 =?utf-8?B?SVE3MFVVWlpmMEtFWWsxRGp5MzdlaHY5aExhL2RKYVFrK252SHJmakZMOTYr?=
 =?utf-8?B?d2drMTFBZEo1Z0hhNWVXMnErQ0pVRVQ5MGpGOEZKcktWRGl6cmVYM2laYXlC?=
 =?utf-8?Q?iRv0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0660e7e4-d20c-48d2-da31-08dc0165c70a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:13:02.5351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRKeyspTYuWn9qN9MixXDJJzlzAhTOnEe/iXV3fqlu+2B3X+166+cxGvPKRkdtJe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.12.23 um 14:56 schrieb Srinivasan Shanmugam:
> Fixes the below:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:706 amdgpu_xgmi_set_pstate() warn: ignoring unreachable code.
>
> Cc: Jonathan Kim <Jonathan.Kim@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index a6c88f2fe6e5..4b756f280c38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -703,9 +703,6 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
>   	/* fw bug so temporarily disable pstate switching */
>   	return 0;
>   
> -	if (!hive || adev->asic_type != CHIP_VEGA20)
> -		return 0;
> -

Well this isn't really fixing this. The problem is the "return 0;" above.

When this isn't working because of a fw bug then we should probably 
completely remove the code to avoid warning like this.

Regards,
Christian.

>   	mutex_lock(&hive->hive_lock);
>   
>   	if (is_hi_req)

