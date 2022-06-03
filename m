Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B62EC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 13:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0273A10E8AA;
	Fri,  3 Jun 2022 13:44:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5112110E8AA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 13:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaC8EGdmuKH5Qo+3ejjXcdqqmBu/bgFJd9SQwN86lONm1aWZwhF36C1sQdPTC6YkS+pvoujBOnhk6TEs5/OOprk7ngACD2GhwgsmlLmZ8gCFl7LKKWryHo1oKgVnmTN7geUgpMZvxx0l9RCkEGtYrSX54/GT+lGmc+tzE3B4/oAallnyEZgM6pw8YOB2TX0VuI9VTOi5n18IyRj7vTXiI7WD8y+UBhApuCzCHl7wOZEIZdbKo2LEdyR2j2kso1EIQCZOa2Do//tTRFUjYRMgCV5Ah6qOaFElbF64YfxjJwBr4A6bsKkh/wR9/ZruzXoGDE35IyzPv6JRB5oMysTdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXgcA1RgmcV7Mkuz3+9R5vSN9HQGd2/DPQSjKPTuqhg=;
 b=OIrCoDhu06xYluWwa/MiqZCcq2PCake0Jd+OALlOmCcjxAyiFxwT/NDVTKhRI/39G7yv1fJBxWhnUUNIp7A1nOb51xkBESTiRo7WKir9uMXjCNreXjHZt56tDc81wp9dSWpR32FSeZacQw6wmuLbHZHaVQhUEufmdUrvpJca1SgVCJ8/8LNH4x+YtGJW2o0FlzvjGTT4gsDx1PibURVjtbLP4t5cer7tpUi6e5Yrtc3ugOtDKnCSwcXYN+fmOZrMu+H0KBdIYZRB0/TOxEg8TvHPo3X/bsu6gQaT2sfH1xE773lniNk8+XvTBzcirsWyeVv14bqZa7neGqTPjUMnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXgcA1RgmcV7Mkuz3+9R5vSN9HQGd2/DPQSjKPTuqhg=;
 b=p/2tlWL2dUvGZAOQL/W7RYNThSFeoQ//VXb3jqweu7hNshq1s7vE7gbLANQ47vCMBQsw9A7/oHpixiGmC5lPtffA9f1WkdtyupmORMwZqzAWH4rB/oIAr2vhfzqi4HOm9nMIusCKHF4l2stZyj8ejxViKXw6WKEFQrwF9ChYp0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) by
 DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 13:44:28 +0000
Received: from DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::5cb8:16ce:7d18:5705]) by DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::5cb8:16ce:7d18:5705%7]) with mapi id 15.20.5314.015; Fri, 3 Jun 2022
 13:44:28 +0000
Subject: Re: [PATCH] drm/amdgpu: always flush the TLB on gfx8
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Arunpravin.PaneerSelvam@amd.com, amd-gfx@lists.freedesktop.org
References: <20220603130504.81147-1-christian.koenig@amd.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <602a9d44-4978-d876-7b7b-8072039b6a8e@amd.com>
Date: Fri, 3 Jun 2022 15:44:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220603130504.81147-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:203:91::15) To DM8PR12MB5431.namprd12.prod.outlook.com
 (2603:10b6:8:34::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c9f4474-218a-4ff3-1772-08da45672e16
X-MS-TrafficTypeDiagnostic: DS7PR12MB5718:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5718F02CD2AB10E9F5D2FA058DA19@DS7PR12MB5718.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYuKl+7C203LPfxcTcIcJFEIki/JhYHlhbEY/LXKAhfFg4uc5niK5sS/G9y5dej/dXTUNWzGXA7Yk7NadHmkzvE4UbLYNw6prwETSPOUivgBrDaVSLb3geN2E1XCEZJuo2TGwfD3PE8Iyb21C7zOpg2O6lwWxYQPxav9IBm2eYMdIm9WKh3ln4OZb7f82lPXhvlRV0zlR+cWu0MDKL4mBqll9V2+ZLoj0G9qugdSc/kGuxL4c5IE09OlOZUVWvjDgVx0cZuwaLw2Ai3WRECglfyzftsCmKx+7iM31NyeTDqoHUgRxKMxAh1hoVQRltJwiDyWPl0oqQ86xRxcxwSuh6NKWFCjrHVX0cokpdOlpsfixFwJuSSYwOf4eIbm4bM+oQXZcjmfI8Vq+uSXkXlBlTbRajopnyRu1fkNRKppkT2ulGqvcAAD7ND0te2Sr/vVQykVMax0S7fR4kHdSF7BA8EqVf1rjBTTCtk5ip5tX5u/H1EmU6yyycd6cDzhCZmN5SPwgp1JOvoJB110kuKUhaI8/05nlYBkEYmU6tCqmpGz40x4uUnIZhrABYPAWomJm/dE0tzXKYaxMN7zp9DVMITghYPbH8UXW40JEzKOB0zz6DUnkIm9tFm1Al4eVDRS1Y6XPWPg4LcKlpkKtywPIwTb1SBX90soXn42Zlg5M683kBarPhgGheyjg8YaBh5ViCCPvH6GG/Z16ROJgHuma9ayoxYkzhkzb+uAioTwlno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5431.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(38100700002)(6486002)(8936002)(36756003)(508600001)(2906002)(8676002)(2616005)(316002)(66574015)(186003)(83380400001)(6666004)(5660300002)(26005)(6512007)(6506007)(66556008)(66476007)(66946007)(31686004)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JqSFFOVGNhRFllMm9jalEydVJNZVNqYXpMdGN1Z2pGVVlCc2VoTENtWG1j?=
 =?utf-8?B?MWJ0SUROM2R4bWxOVnJ3alpCdERZN3g4dys3cW5uLytyRHZrNXNzblg5dDRV?=
 =?utf-8?B?K3dsK1I0dkRJbnBIRGM3ZktwRnY5NStYNzRtZkY1akoxZ2FSWWZCbHg2RW9G?=
 =?utf-8?B?VTI3QVJTOXptQWZIV0hTZXpjUHlCYjdMak45Yko4UjYwZVVFd1JuUzZXQm5q?=
 =?utf-8?B?UCtEbzJsb3AyTjFTWi8wSmFocVJ4Q09nSXU3U2ROdGYwWGhmVXZNd2IxcWdI?=
 =?utf-8?B?WGxpaUVSMEppY3p5TFBpNFM5UlF3cytXWld5dVhRUnZjc0xmL3hncWVnRS9X?=
 =?utf-8?B?bjdzRm11U2l5SU93WlhMQlptanFvdCtyM1AvN0UrMmpXOEdOMTJET3VkSitW?=
 =?utf-8?B?cUx5bkw2bU5mb0hLSjRPOVRERC9oQlJKTXR6TDZNbGh2bXQ2VzNXL011VG5T?=
 =?utf-8?B?Q3UxRmFQK014cHFHWUJXZVpBdGxzcEpKY3NhdmwrQWFpL0Q4QkNzSTVjSVNR?=
 =?utf-8?B?TmQ0WUJvU0UrKzMzblo5emVoOFdSK25PTG1OZDE5WG9ydGQ3U3BCdTRES09z?=
 =?utf-8?B?WjRaTWpsejM1UVAxWDBoYnRIdTFGZlkwQ0NxaFB3MkNvQ3AwZ3RFV0plbW10?=
 =?utf-8?B?SXorRnhScmFzOXNWVTNVV0V1NzVNeWkyWWw3eXVDdlFSV0VEQk5tUXljNitm?=
 =?utf-8?B?T2VFR2FTTHJRZGF5ZzJMbU9XOHJCN1JoNHlCNmwyL2pnVERrcGZZNTdJeW9F?=
 =?utf-8?B?ODArL1hkS1gvTnE2aW9mcW9ZNlhGQlhNWE9WZVZkZG5EckdQbHp0MWJJREdQ?=
 =?utf-8?B?SDMrdy8vVjlNcnErNnBvMkhaVjVDamtmUXdFNmxJNkpqTXdodUdZS2s4Mi9l?=
 =?utf-8?B?aGNiZlNCQzM0WUxyMWtra0FVUEhMbzV1R0tGc3RyVG5FS0tBNHRaSm8zZ1Fu?=
 =?utf-8?B?UTlEOWtOcjBJMmptR0FCTHYrWElBbHpGd0RSeVZJNk9SOVE4OXVDVWJ4NTUr?=
 =?utf-8?B?akw5MXl6elNRS3B1QUcrYWhrK1VrNndlemtSTUFRVytjL2ljM1dBekRtRVFl?=
 =?utf-8?B?RGd2UVBQdTdabm9VeVJPMmd2dTFidmZjQWpmYy8yN04yTm1LWWd2TFFCaGNT?=
 =?utf-8?B?ZjNkK1kxSGRCZDBhZG1lMzZMdGV0Qks0NTQzNVF0R0hsWEZKUDFuRUQwV0U5?=
 =?utf-8?B?OENlZGU5VUFkNUdqOGd5R0RjOGZaVlZURUF1cXlDSFRXZU5mYllQMU55RWNL?=
 =?utf-8?B?WGN3dk1ENUNKU2s1ZWxJZ1FuclFKTmo0OXhNajNzNFpqWlZzRit3TTBHREVk?=
 =?utf-8?B?ZFJWUzlGMGFQa2w0ekwxb1NHN00rbWxWN1JKUm1ZaUhwTHVyazlTR25Qd2VB?=
 =?utf-8?B?dGpSMlZrMG50bjllSzhWYVA4YzJGRG81KzdCRzFtQkJMNHVCRCtjbXBiNElE?=
 =?utf-8?B?MGR3V0pzREFuSlZMYkVteHVqOGVxb21LYlh3RENodkcxL1FBdDJrZkx0SVRQ?=
 =?utf-8?B?NDY1NmpDL05sMjlJMFMvK0dlTGFtem9LRi9hazNoQWlGRzZ0WndjMVJQZWJt?=
 =?utf-8?B?Nklmck04NVhMVmxHR3pUN05uRUhpUkV2U1dJcmdtQkpjelhrYWNTN1FCbFZL?=
 =?utf-8?B?U2VjZ1E4eXN1RlU2aGRqQUtsUUVZNTNhdHR5Q0U3eEJVb3NDZEZYUFlueEc4?=
 =?utf-8?B?c3hlWUpDOXNjV1kzdU44ZmhGcEZBVTVqMFA3WXRjbFdwNjRIVlN2eXNyOGdB?=
 =?utf-8?B?VWRXajN5RWVOWjZoTlpMWlBhTkhDQkRLYXZLYXVqcHJvL3JRdjYzNFFPNGNi?=
 =?utf-8?B?SGtXNy9hM3RaU25BNU9jeC9KdzlnVWJLdjQvU0lxaFJxOGczbGlyNkQ2VXZq?=
 =?utf-8?B?clhSVklvNXZZaGZpM0xWUWwxUk1iWkgyaFpkcDk5dHkvaGVPbDNraDh5dVJu?=
 =?utf-8?B?V1RtS1VYVmFkTTNwSmt5VWN4MnU4dE5oaExmN3V5SFM4L0dyRGU5Z3ZQcVRr?=
 =?utf-8?B?ajBnOG9UUFd1Z2hrb1VmTTQra3dSMW5Ibkw0dmI2c2c4eVYrNnZZNmpJMHBP?=
 =?utf-8?B?V0toNlpWVUd0OUovZXhIVkl2M1BEaE5saVZlcHBaNm9QYlBhcXd1MHlqYVZn?=
 =?utf-8?B?SUpxd25uMUxhVXFrNTdtd2NWOURNRmFmS0JUOUZhVXJpTytoc3BnMXJRajlF?=
 =?utf-8?B?Tm9oL3ZQNDhjWUJaUzhhN2JCQmR1bkVxdUhqV1pGMll4bk5obkxQUjFaOThH?=
 =?utf-8?B?NzlLMmZWc1UzZjNaVE9MMEtGU3EvTjBJQ0FEa3UxQ2lIbHAyYjBjSUFIUXY2?=
 =?utf-8?B?OU1pMUlDVmt5MHYzWC9qOStmTjB5TmsxcmJ6MmFCd1piQmQ2czNqUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9f4474-218a-4ff3-1772-08da45672e16
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 13:44:28.5212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdnyucmdyoC9TWtSDj6FnxGfwUSF8cM4DMY3FGgs3B8DR8vTWMWuo8eVgWC3MjHpwvDIulkJgSo1YM9GAsFRpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
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

Hi Christian,

This patch fixes almost all GPU faults on polaris caused by 86fd5edfbdae "drm/amdgpu: rework TLB flushing".

I still get occasional faults though, about 1 every 3 runs of a subset of piglit tests.

Thanks,
Pierre-Eric



On 03/06/2022 15:05, Christian König wrote:
> The TLB on GFX8 stores each block of 8 PTEs where any of the valid bits
> are set.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9596c22fded6..b747488c28ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -847,6 +847,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	flush_tlb |= adev->gmc.xgmi.num_physical_nodes &&
>  		     adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0);
>  
> +	/*
> +	 * On GFX8 and older any 8 PTE block with a valid bit set enters the TLB
> +	 */
> +	flush_tlb |= adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 0);
> +
>  	memset(&params, 0, sizeof(params));
>  	params.adev = adev;
>  	params.vm = vm;
> 
