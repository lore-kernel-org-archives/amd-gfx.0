Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF8AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 15:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE8610FA11;
	Tue, 10 May 2022 15:07:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B61310FA11
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdNXHIUE5ZaokhB73yPjVd9rq87uvmt8f7HZxyx8yAmNhNwpI+99CxfHwTiTOR0b45V/p03UGMUnO1cnv/2JIVYc+SzfcyrYi39VwqO3GG9RDrqR5CGZ3sZL2mj+l3DeFS+YH2Gp0mK+8qGB1xS5XE3ys4hUK9F71WAekVI3dTYQiUzg6Lx5rz53g/kvgrI9AYGCrUEysBjcCiZJWfEgvAKO8E3IYwJdckR52WK0Qfz3EX5DHiOKbUNY8eWGcitEFTBDNdQwHJTRDSeW20vK7b5+5I0k3czSSzX+Uu/S67j1Rh21GPU9leA9zzSJ7mrzAjOXbhHGaK/FTSSL1HnWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdEiMI4OtIBrqaPHjPbBgrtCzDpcQS+RobMjKEhCLpc=;
 b=c7sk/5WMYFiYvfc9PQ4Up2xcX6KQL4bE1YNpEEJRYZTXEk0vIYdWRmH5NiwJMgU7ZfQwczfvWueUjzEWCKOdnmaksjIiQ8Dhg68qOFBnWZ5vcHGp3CxXfrn369RtwfHhV9FYcqZtWzBN/fNYlnr0pRxaqRoBe53k/wUm2G/ajvbeCY4cAG2E80BNLc2q9S1UgGJeqxc2uUKuVvMLiclPDLyTBwztWLs91WFU0yEWn6NlrLNz9UqibZOp7R0HxDRhN3Cd31nfVqcND7XWm2RV5QxbaYHxvKr6LHlgRCahPnUlvNceqIaEcdKOp4SimQ8u0+fxmdY8eIAIYwebo8SEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdEiMI4OtIBrqaPHjPbBgrtCzDpcQS+RobMjKEhCLpc=;
 b=CgZmioO/Z8MRJ7NJ7Zi1fCq//3HJfoZUECAi+uD7PDDJkl2CPYhvJSj68ic2hjkQZZUU0VeGTpLTGtKyW5MT4S/6VMEtsvvJ7z62wa0XPc6bku5TafbbXtzIZs4sodbCWgWU3VScPG894rI4pqN2lxOalcyHky1jyLYrsPA6cjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Tue, 10 May
 2022 15:07:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:07:36 +0000
Message-ID: <3d4a4cbd-4696-182a-0cf5-074374c9e3d1@amd.com>
Date: Tue, 10 May 2022 17:07:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: vm flush needed after updating PDEs
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220510143606.22282-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220510143606.22282-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef440edf-62a8-4f6d-1e99-08da3296d0fa
X-MS-TrafficTypeDiagnostic: PH7PR12MB5618:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5618803A7371A1F4ACDD612483C99@PH7PR12MB5618.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCdinw3Cs5VzCffoQftvLfR8+qEgDKk38eXk9Vs+Aybt/505qQ0rhRE5qkd1qwG4IvRxXtTrVOtjrI9flmY5k6s7Mkbd2JOUPXRg3GLJkfq/tIbhWxzmmLmBfmelrNJHwTK69H5g6twQFEy4fyys9dkAbwJHhssa79Oph0qFm0Y6PUtXXQTz5MIY6+0aMYIls74WhP9yfi8MIINaGtuzP3FuDPYRcIu77evrVpjuwhixjjsBmgDBQDpdV7DSva8CaoIs/XjG2PrG7ioxIM8jpfZY8//ubx+sVWxL+LICvIlPbyg+wUTziTFMAHYtJhbJZ7QPoKz1DMqV23sLMFl35AcgcL5k6JPLsWlot6bUCrQRB9P0Hhb1laAEdnBOUhOYvntpCOIKYg2aYOFJKPYDBVtaAbzrP5/NPHhMClknlaiT2QiHYmlRAA/jdbGkloBKUsM5ksoMS2b6pbFrdfCyCXeNtkvizdh+SN4uTUyPs6P3DSUe3JEjz3FwjtUAevNTofpHD0f2QpK9/OixF8hjPkUi7xFfUK7ErYuXpCqacBl42+2qyG19Z0YiDFwerkVFUMAuu1snjGS1e478+ohLlUlkM3J6J5zVXcPH1+VJj0I04ZWdeuBzoS8olEcLBR0OHFNOQMbXZmMsvUyVcpZdtKCta6d5413q2KDHOO8bjsMpDt8uGn4Foz4i2YryDdD+r/U5pBaW4Rp6uiw+qfJdcnr3aTiIJ4oLCUPZZerI8kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(316002)(36756003)(5660300002)(31686004)(83380400001)(31696002)(6486002)(6506007)(86362001)(6512007)(6666004)(38100700002)(66556008)(4744005)(2616005)(66476007)(508600001)(66946007)(8676002)(186003)(2906002)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5tVnJVOGN2RG9qQnNkTkpDWncreE03VFdVNVc3RWhtcnVLbmtlaFRaTktJ?=
 =?utf-8?B?d2QzVHdjb3NHQU9UUmtLNzlxam9GUUEvUjZKbDlkOVdYVzhDbGMwVUkza2xo?=
 =?utf-8?B?SmZld3ZGTUlMZGZBNm5wZlEwekxxOVRITkVoWTFaVmdxSGVIZkhnYW83Rmw3?=
 =?utf-8?B?L2tZREFvR0EvRVB6bitOTnA2NW5IYzBvL3A0QmhNMUdWTndBYmRMeUw3NGVI?=
 =?utf-8?B?Q09CU2d2QW9OU2JUUWF4YUt0YlV6UVV4dFA4Wi9XM1RxMlIwMysrSUhiVnpx?=
 =?utf-8?B?YTF6Zk5ZTlJHM2lmYWJCb0tUWkczTEg3VWxhRWdJY2tZRDlONXJ0V0RJejBn?=
 =?utf-8?B?aWErdjdabUdVSHYxQU5XSUtQcWR0RXJlczFvOEZYelNVcjNRSG8xOG85T0tR?=
 =?utf-8?B?RFU2aGk2RVhWZ1JSakwwS1ByWWhucUcxTnM1cVBPanFqTEFjVlRXcUJmZGxB?=
 =?utf-8?B?K2hhcjJ4bnVnNkJzRVZMbTFXZUc1QlpiZDIxTWtNenRqNHpJN1RjNVpkVnZR?=
 =?utf-8?B?YnFyU3JjM2ZIbFlOUkduc0FpVW1MSVFNTnZ0QytINGZtM1pLSXJSdW1CVkJ4?=
 =?utf-8?B?YmJyT2VzUkVhVXExY3J4bVNOQkpXaHJ2SjlxK2crM1U1V2pBNVJJL29YWUtG?=
 =?utf-8?B?WnN5N0pPU0hvdGtITmxVdDNTOEtjQndBZTQ1Vml5Mk1aYXd3emxjWHd6eEU2?=
 =?utf-8?B?andxK21TckVVb3QyUGdZWXZDQXc5TThRK1V3dkZ2MndpeE1sWU12M3JSUi9I?=
 =?utf-8?B?Wmo5Vm5kZ21oVDVYanpzY3MvMGhJeExkQ2VkMVVOYzkvUlFxdFU4UDVnZ0t4?=
 =?utf-8?B?RkFnNk5ac1FVSER3YUZXUUFZd1FlM1p0cUhQRXVmVDNvVDFKQmtONUI2S1Q0?=
 =?utf-8?B?V2Z6T3NsYzFoRnpKWHVTQzJRUHFMZXhJV0k5UllRMmk3dGlqQWVQZ21wNEVo?=
 =?utf-8?B?NmpUVm4xSDRwSkp4UHBxMVJmekpJQU1CeWhXRTVzMStRNHdhRGlDWG5TNG1p?=
 =?utf-8?B?WU40Wk1nZXo5R2s0cy9aWjNxdFZZWUlEb09vdUsvOUVOQ09Xd013Y2lmZVBP?=
 =?utf-8?B?Y0l6cmZsMi9xSnJSbis5Q0lQRlhEdTBHTUJmSCtDVHRXUEZ0Y3BIZElCc1pG?=
 =?utf-8?B?ZUg3OWFqYmlQUi96U1Ryd1dJcGVIQ3JwdTJ6a0x5djZiS2N4MExnOXEvOEFl?=
 =?utf-8?B?dUh0QlA1SGNsY3JlWk4yTW4zdHdwYkMrU0tVNmgrQ1kwR2NTSnd4UWJMaWNZ?=
 =?utf-8?B?TExIZW9BUmNrOGVlQVNjS0NDTnNXN2N1MEcxTFUyS2ROUndmMDNRaS81a1dF?=
 =?utf-8?B?anBSWlNMVmZjY2lPY3Voem94TENaSGFZdkpnUHJVdytDakkwUVcybWgrZC81?=
 =?utf-8?B?R3ZXZEpjMmVMZ2NqM2JMVTlkWmhpV0hBTnA4VkRkYmxxcE1XK2FqazdGWWZC?=
 =?utf-8?B?U1JrT2ZxNDlqZ2NyWFpEcFFtMUdRMDhBeElLU3d5UEdRaEszRHcycy9zRU9n?=
 =?utf-8?B?RnZLb0dlS01aVFo3V1lYazVKVW1oUnorUktyUVUrYzdHN1J1V1Y0SmRmdUZ3?=
 =?utf-8?B?TFZMTm9LSEJXeHI1eUR3My9hMVcwa0JPdlRFODdDV1FueXdUbCtUbC9wM0dS?=
 =?utf-8?B?TklTVUFVeng2aGZiZWgvWkNpTVowcVhzWXRXVHhMckliOXpTRnUxWnluVDUw?=
 =?utf-8?B?cUlIZkFXWC93cDFsTCtFRU1EcHJDdEtwYTB2OGc3M0JMMzJhQVRvYUM4SHFj?=
 =?utf-8?B?K0tLeFE4L280amNjaDVkeFRpUkpDVUtyL1REYTVOQkdFSjBLckl1bWxlRUdW?=
 =?utf-8?B?dlpRalVDQ1BjblJPNlFIcFNmWFpzWDl2R1hXbEJhY01qUGFGM3JTNWIyVEdB?=
 =?utf-8?B?NmVzSG5UdUJPWWlJMWhWU3ZNbzNUVWQrd3dVTWxxdU12ZmlLVG44TGJkZXVM?=
 =?utf-8?B?ZUpINEp3Nm42aDNQUGJkUTJ5bFRxUi92SDVId0pKWk9lb1BsRzdxQVN6enhP?=
 =?utf-8?B?R2g0VWRaMWhMajBqNWY0OXlNZys2MlFyR0VRbTJ4bDNWQjhxMkUra2VGdmdQ?=
 =?utf-8?B?WnJTWlk1SHBkcWJKM0F1eVhFSmUyUGtUbU1YVm1PbE55czZTYkgxeVNOUmZD?=
 =?utf-8?B?UGtMTmFSejh6NUNOZE51elZyNmtvYWl4S2M5b0ZZUlVrMzlEeVRrcmJnYmVL?=
 =?utf-8?B?ZXVKTm01T0Q4bWdPVG1LN25KYWVaeUJ2d2g2ZkhMWjA3WCtrSk02NTg4ZjJv?=
 =?utf-8?B?dWNkaTVPb2ZPcGkxZjRPblV6dFBmY3BWalkwTTRMNHdVMDEzaWZBKzRRNUE4?=
 =?utf-8?B?VnMyeXUrdjUvWlgzbjVueEpYbVhBY0pJSk9lNTJhRWdveWNlQjdBUEtCazZq?=
 =?utf-8?Q?mfRnFNF+dQABSlBeQbaHjrtPA8XfVOFLiwp8SDbk7F13Y?=
X-MS-Exchange-AntiSpam-MessageData-1: h+qotUcrMsCI6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef440edf-62a8-4f6d-1e99-08da3296d0fa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:07:36.1538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PjCRoZgffw6sRyrtxR1CtIrteLkVp9b0FQ0mR6I0v15LqGhfHvwhC6r/YuWF11B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
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

Am 10.05.22 um 16:36 schrieb Philip Yang:
> If page table PDEs is evicted and restored, after updating PDEs, need
> increase vm->tlb_seq, then amdgpu_vm_flush will flush TLB before command
> submission.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7276b03ef970..9596c22fded6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -764,6 +764,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> +	/* vm_flush_needed after updating PDEs */
> +	atomic64_inc(&vm->tlb_seq);
> +
>   	while (!list_empty(&vm->relocated)) {
>   		entry = list_first_entry(&vm->relocated,
>   					 struct amdgpu_vm_bo_base,

