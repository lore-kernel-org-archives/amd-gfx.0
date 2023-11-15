Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B928BC07548
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 07:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546E910E4F2;
	Wed, 15 Nov 2023 07:01:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87B010E4F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 07:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfrvANdc3bIuQ2KGcuE5IjJs9+nr7ZotRSUBL+Kx3tfwQW6gxrtb8lgzH56rcd8KHYQsipsxo34Rh96g2AEhXYuSvl9DLujfkacq/BpnRE5PgV1rP0OdLa8vuIBQ1XtCaBxw+f4Wzp3PYQTkSR6ZJ+xm2GFnVpiKqmktC++uW7K3yy92U+9BOwaz2mlIx0VXYgljqlF0Bz6VV8RsRfkRBquG/2yLXbBBAnR73j3Gre0oFFJbI9niobzOElk2rWmdamQ7w7bFLhq/F5sY10ZDwsUieea9OHtWgNwXOPX+86KAwZ/PlZaXjey0kehrZ9ym3U21Mse3aL+20viu1lIkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3ZOH2ZVrTQvOAu/htldVFQkoVNuULEAMo3X6yTylDI=;
 b=lOheaVfiZz35e02h7Dbkzt6uBzHvVlZ6OKysBokbyj6OyIJdB0s4IqsFdqTouN218bJmrCpMguOuMTYir1emVIg/Cy9516WAAwGZyP87xa1W5PBf+g9xTrIfXqWICze7+dyzsF1nO06TezadAx3RdP9yzkMxgoK18jaTdzPMFlTwXuMzfXTm+TceZUsrfHPu9zgROBS4iewFPmIacyt5iPdU3Hi7uXo6K5yqI7aJ1VwC84VyZS9QadmzAinH8ShQ6Fr/xYZCtN3M0II/x4ulLFva4L287vZWq5KKaO/qAfmQmr8+/+WJtq6KwvL8w4BNPCccgf3IKkbJQz5DPh876A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3ZOH2ZVrTQvOAu/htldVFQkoVNuULEAMo3X6yTylDI=;
 b=b7OEpEN/L4Ri5B7dMN6lXmwlnLLUqu2W07c8XcQz1YIhg7WrYHaQEW+y4CxJV2QG8NPSFh2TT8hYj9vwyNo6bgb3joc+o4iWV+tZ4p4TQGSg5wnGLDm+3VKHCzXHqlrIAgvD6RgwVc76B55gAtfVtdkp0WZjdJIBAFdqQJueFfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 07:01:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.6977.033; Wed, 15 Nov 2023
 07:01:18 +0000
Message-ID: <1726343b-b0ab-43be-91ff-8d0fa12f6944@amd.com>
Date: Wed, 15 Nov 2023 08:01:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add function parameter 'xcc_mask' not described in
 'amdgpu_vm_flush_compute_tlb'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20231112044534.1637245-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231112044534.1637245-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd3aa44-0bc6-4315-ebd4-08dbe5a8aaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBS7IiVLrwFlmUhCtAxBgyHLzKv0Cpirp4L4sEdq5coqrblZqBY76WHnN8h1PKCLM13zu7nN+FicRVRYlg9nki7ADxUcV4ciGh07FkR74xzmOc3YenFgIrzYHZn05mLb2vVwz2tjx8qfGForp+C8gEINvDcHMr+CIUt2ZtMGX0KtFpnD11j172UyofXNAPTQrxTZ3L+1gKCMVF3hx9sh6v/V7wslSpPy1YlbUaLk8qEzBh5N8gnA6mVfCl7lbXeN+rfX733TdHfwwZ4xfli4KgwmxapSal9OAatVRGoiOn5bXo9idS61TRCgD8AU0rUOphPl67N+WisOAsKMcKSyKlRmozIFbYfyBrvou1JcRMmINjeANOfNNgUvD4MKkadaYFRFMmodKOWQhxK81IQnUUHn63JNZh6D9Juxg6Ygck6os7K9ZA7AU20FqOlbwF0QM0VX6OJvNVpJnSwRJ0m7KoAfzCFYg6B0JfPDmn8GY4jeoQs70JMdXzsvNs9tp6mpaYY2N+wfNAW7x72TYcNifTsGkS8gwLVPcY7uNyxgSn/iwCtZTDwbonDht7z2qYUOSXY/Ew91YFHsyTfMUF2Jaiy/qRg/Q3gOeaoGWmpcvKIdOghVfEzhA3heaOxQce1gBxRxwwSZe/shooiMxf5Z/rPelnZ602pPkiRI/0YuLxJgcl8nE8M6PRPS1xuVPmuQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799009)(110136005)(41300700001)(31686004)(2906002)(6506007)(6666004)(5660300002)(8936002)(36756003)(8676002)(4326008)(31696002)(316002)(66946007)(6636002)(86362001)(6486002)(66476007)(2616005)(6512007)(26005)(66556008)(478600001)(66574015)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHFOMnpSbklmK2tBakRCd0R5U1A5QnZmN2llQlhQMUF4ejNGK25LY0lIL0ky?=
 =?utf-8?B?Z0kzWmU4YThXTWkxNzNBZHVneEdDUk51aU0rVmRxczhkcXFWbnhLOTd6Nko5?=
 =?utf-8?B?blN6a1Z1ekxXVVpxMFMyZkpnbzhJV0E5a0xzYlhuWjRNVUt2eDUrYVNlTXF5?=
 =?utf-8?B?eC8wdkprbWlTa3Z1MDNhK2hrUkVxR2N5TmVPUzZpNmpMWm42YS8wZ3ZWU1VD?=
 =?utf-8?B?LzZ1dWJOZE5ic0RleklvRmhsL045UXc3QWFtdDBUVURqQVNTYURCNG03NVYy?=
 =?utf-8?B?dlE2OVJDZ1VjaDVmNzRVQUxiSjRnVTRiRXBXL1ZZQm5JQ21pOXRHL3RNajly?=
 =?utf-8?B?clM0aG4xeVBmeVhMRXd5SU1OemtFa0ZyQVhNMUw5Wk1OeGhzcURzV1VUSSt6?=
 =?utf-8?B?cDZWdmYyQUxzaWhMSVZaaWlXL21WVDNYZWpkc0xjcElvaWY0ZGEwNVB1SWFH?=
 =?utf-8?B?M3RrcnhOcVh3VjNMZGlvUlV2aURpQjh4TU9GV05oUkVnekwrOVU5SGJjenZK?=
 =?utf-8?B?ZWwxL2kxRFlkUzNEOURxZko0dnpKV1FBb3BMcmphb0RNdS9UMzI1V2w4Zjlj?=
 =?utf-8?B?TzhOQzAwZGlhdnVERzdZLzZVam94M0htMkI0dHNvNlNkSUtvcitBSnVnY2hL?=
 =?utf-8?B?TklKUjkxTzVWVDBMa2RkdlZXUHJnQXAwekVORWVQMXIrT1p1R3gvSmNnZFZ1?=
 =?utf-8?B?S2tkQkN6WEszZjBpNnpYVXd5b1dsYUJseDRIR0JuV29oVnFqOE9TYjVneXI4?=
 =?utf-8?B?ZVVpdURhU1BwQXladGJ3QndTcW1aY2hZcHVaNTBHQVRwSThQaTJqN01zTnVR?=
 =?utf-8?B?ZHZFZjJQWk9nWS9LWWlFcWVPSDhGMGw2ZnpKYzlLOHBaekdBVjVyeTZRT1dr?=
 =?utf-8?B?cmRCZmhCTFJxSng3OFVCbVc5ZlhYMFF2SUxkUnZWeTMyUGV3RjIySkZaWDJ6?=
 =?utf-8?B?YTQ1YjVINWN2dDl1Qkd0Ykp5QlFSRkhXMkgxWnZIc0U5ekRkOUNXT0NKV3F5?=
 =?utf-8?B?dmVPRHlqVVMzdDdnYm9VbDJCMFdLeWNHNnBTNWJYTVBKUk56ZHQ2MGFJLzQ2?=
 =?utf-8?B?bHozNVJrZUNYVzlXV05rVnBWR3o4bnJvS3NzeUtsMFBqamJiK0VwN09EcXpx?=
 =?utf-8?B?RTgvNFRrNUxSWXJBVG9qaFJVbUlvWVNTcVBLSnE2SUNHMHorS1k0WWxvViti?=
 =?utf-8?B?RmpTeHBWdHpGdnBldlk3bVFScWRnNmVyaEpSRkZKSXFQTG1lQVJOM044cit5?=
 =?utf-8?B?MnhJWFRRaGNEektBODVEaG1sSUdJN2xTRWMxTXdTRit5dlFiYTZMZ3U2M0Q2?=
 =?utf-8?B?M0ZGRS9oMHY3eWE0dWlCdGdJRGxFbGh3SGlleFVjRjlwZk8rdmRFaGVWKyt2?=
 =?utf-8?B?S1hpeVFkNnhaUUNaZjJIRzRxMWZhalZjWVVKdjJJbERRYjZsVTNyMXFiMVBx?=
 =?utf-8?B?OHJOTytramd0VDMwcTdkUGJ5aHZhdnJuQ281NVNRMTFVVFlFZzg3c2RiMkY2?=
 =?utf-8?B?MWJaRnh6UkcwWnZtN0ZTWW9oaVlmZHlpNHhKUDZiTThNLzBhbXBmbzJSc1VO?=
 =?utf-8?B?Zy83aC82SUJvRVZLZ3JXQWRRemhiSm9oSEtLUFZLZ2tJeWdmV29tRlpuM3NX?=
 =?utf-8?B?c0QvYXNYOUlpNE5XTkhOV09uc2YyandZdVY3OTF0R3hnS0Y0SWNjeUliT2py?=
 =?utf-8?B?VHU4Zm5OcVc5S2ozc1B4WU1BbUZ5NW9jQStuc0w5VmdhSG5IRjVjQkc0U3lQ?=
 =?utf-8?B?eVpVT1QwRkhuQXRIczVCcEw0VWhlNFBubkMvVnRzOFJCWjZzQzdHaGRrZ2di?=
 =?utf-8?B?UkN0bHVIMWxGZnlQTzdobGVGai9kS2ViRDFrSzdjL2lKSkRRaExtaEpVYWZL?=
 =?utf-8?B?eksxYlRsZ3Y1ZW5SUXE0eVIwQS8rODVQeDRYMGQ3MWxPMmtUb2hDK0ZXSXlo?=
 =?utf-8?B?YlhXVTBKdU5RRlJRVnRZVEpkNm52bWxJVCsrdDF2bSt4c0VlYU55TUU3Zi8x?=
 =?utf-8?B?d1hlL0thTitQN0FtKzRhRG1hWG42bEsySjhIdGRKY3JOeVdra0kwM1JnbjIz?=
 =?utf-8?B?STNaUEt4emwyb3FIU2lwdWppTmphNWwxVVlhSlVMS0tOa0ZEdXl0RzBsV1dt?=
 =?utf-8?Q?yWLY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd3aa44-0bc6-4315-ebd4-08dbe5a8aaa1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 07:01:18.6580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZvv0AgGxn+w0skwNQpbOaxjZ5F80/tPNWVbBjM04lzg8GzZ9wGmYLqrKQ1JEkv6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Felix that looks a bit fishy to me, can you take a look?

Why are we giving the xcc_mask as parameter here? IIRC the partition a 
VM is used with is fixed because the page tables are created 
individually for each partition.

Thanks,
Christian.

Am 12.11.23 um 05:45 schrieb Srinivasan Shanmugam:
> Fixes the below:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1373: warning: Function parameter or member 'xcc_mask' not described in 'amdgpu_vm_flush_compute_tlb'
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index be084cbe7501..cd4970c2efc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1360,7 +1360,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>    * @adev: amdgpu_device pointer
>    * @vm: requested vm
>    * @flush_type: flush type
> - *
> + * @xcc_mask: mask of XCCs for the XCCs available on ASIC.
>    * Flush TLB if needed for a compute VM.
>    *
>    * Returns:

