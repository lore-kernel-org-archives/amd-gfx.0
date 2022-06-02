Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F35C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEBC910F7DC;
	Thu,  2 Jun 2022 13:22:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166EC10F696
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7S9/dtorIsItWR8uVzaKxEY1WIzasiQA/20wtSrmaWpKOon8qJv5zOvUbyrlAXfvPvfJP6fFAld+dp5+nX0bzsouE+GpG4XWzGNW3+csS6Ij2gi9jdvhJQlANCNbwPuYetzh/1QBhhyNSF+gnQu63b1fmiIFU9f08OGu6LM8XHlVkBs0/ux9NNr3R6xXGqg7du8Q8ScytQOqaUS4o5bylRnyFZdQsXcgXvgwaKTB2IeID5o3AGtisFRq4nnp46WBy34LIanUQSEP85PUa+g/EsSONG3bk3EJxuF0zA2gVh5M12YnVWO8bC/LaXXRPqRmSauvY6Qc0oIDU1JT3u3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T17cAkIs9gGvdCISt6/SSs7H3StjQgZsAPJLCMWBdWA=;
 b=dwggL0mcl0lbJmT/M4Y1IiRJ3mc/ZzT0+g7YBdhAGN8v1aasTNfsvAa+HEwHq37tMN7GUTzrtvfe6YPGNV9YzH/zHv2/SgDzZ/dirAyqB6AkYPxC7mCW5+aAFa+3QelNYSMIkAI05cWSJ6YK3Ulxz7ur/g1tYT7xC2IYvsNPKNkgcRmaoS9lP8cEze6Kb0EMAft351/3LuW/wASKURpzgjtp3MekOYe7OPjGcyygqZVWePlHrfBYqC/S2vtHp9Cci57zt80moPXpqWYZJG8hFlnW04C0mxBcT0r66wgKETsAjd1skT/uRDv58BzJR20iUTvGCFZ8dxQMBA/yJywvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T17cAkIs9gGvdCISt6/SSs7H3StjQgZsAPJLCMWBdWA=;
 b=yMHmxfScktAbttsNyDcp9jyKgdoJr+9XgYGYHJN6vSrcHKIVTCnbijNzkO+q1eLhROB+rDc+GFXCoVZHMcvQUsFt9CnkUD+49EI/JrIiZoC+ST3/CM5WExq6uhxNkrzNE+PC+Z36j9dAhGxud+16da6EPf4vK1g/y+Uc5T+853Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3152.namprd12.prod.outlook.com (2603:10b6:208:ca::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 2 Jun
 2022 13:22:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 13:22:21 +0000
Message-ID: <322bc412-f32c-b80d-6656-c5d14ed0e941@amd.com>
Date: Thu, 2 Jun 2022 15:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220602132029.6225-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220602132029.6225-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR08CA0044.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::32) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7119dd5a-c171-41fe-b9cc-08da449aecb9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3152:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3152250A841FF40C33AE6F4A83DE9@MN2PR12MB3152.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KABSUXG3vu1IWkAu/yCPD74tjTQOFcFKWB36n9yZuRC7uy82xHELKO8t8XHhuODE+82/gwqnmYCRgTJw8n/tmzpmNb2d5WLIKLlDZmeFEaYT/T45pkgKnJpp9zgUwYUQFBe0OK3J4i5a7ttrDXTjaYckGlnBgmZUx92grEL47+WksjErfBZPHN6KLP6Y01a4s+NKCh27em0VShGoUH8LqlGStvp4xKSsjQno05E7uU2KwbAqbxY48jRS6mPOou+Nuh2DcYOq0CrUbthWz8qVZ+TrL4F0DNz3Gp2qWWN8CC7go5zfywRkvsTeyVjOjBDlqdNoPxUQ0/sq0n6nkxKate6qUJXRFY9IZaHne0aHEb1FNjkNtplRXpysJ/bk2tB+nFkRtJancrqUJ+M/sixcUgP5dwI4WOwUY6oT2GCuxT8nmmsg9AR/xFxiGxFtr0s1MhCS/n/RbpZuu3hy9a/p+x8NSiGxp3+xeattjqRT7kaLHMwjo9KkrNnPMZYdqE7hRDtUquwu2xKIB+JYUkDmMCiMpsKMa5lrI3uRw6XlrQhGgP34dQm9+5oCrOYH/vXJg2MP46vQPjCelhNnTmjsEFXaHw8+O4VBvgbHlXpWibX1bq+TYMY+01KoIF1Lz7vD4G7T4L6h47N79OpXu4Gn3sNwtqjDffVG5Sl/YH4/2tU9x1OcbrVysi2FhlVLAnrT7/FaAkBCGMJmbZFvv+BaTNq7iMsmL/7G8bcykD78tHSLfRJlr2KHgxP4dKbo+0hx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(26005)(83380400001)(508600001)(15650500001)(6486002)(66574015)(6512007)(6506007)(66476007)(316002)(86362001)(66946007)(66556008)(2906002)(31686004)(6666004)(36756003)(31696002)(38100700002)(5660300002)(2616005)(8936002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clc1UlVkQzVQNkxYTTdKSmdVbE15Q0UvMzB2R3RxK1dvSGM4NVdWZlVENEdj?=
 =?utf-8?B?dTFwN3hJQjJUMkF1V1NpYjVPQ3NLUTU2Uk1tZzNKVjZ3cjRZNW5oZGlCOGE5?=
 =?utf-8?B?SXJFQkJhK2lvcGJWbGovM2JqUlZ2Tmc4T2xKcmczYkp1WThLUndDSklTVkNz?=
 =?utf-8?B?eTVsd1VHclppenVWQU40RGgrbU96MitWM0V3QTJUS1BGVzVNTEpraVo5R0sv?=
 =?utf-8?B?VXRHNGJBYnc3c2hqRmFQWGUwMlFvaHd2WGl2RWl3VFFEdFNQZTdubllkNXQ4?=
 =?utf-8?B?MUs3UEhXY0VwMmhwaDAzOGMwVy82SCsvWVVSM05oZDhwVXJlTmpFTExRckt4?=
 =?utf-8?B?OWZNT0lIVTJuV0R1STB3MGdlbnkvMUtlTnl5NkFJNDB6R0VKSmdyZVpHWlc5?=
 =?utf-8?B?SUNLYmlmaWxpL0FYaTBvaG9Cb3R4alMxZkhJOHpDYzZwbkd3amlhWEpONGpn?=
 =?utf-8?B?UHkzTDBTRFpxNDQzOHlHdkJYU2xXaWNRUm1DOGdYMGdwYmQ0SDh3YU4zNXlK?=
 =?utf-8?B?YjZsdXVjV1RRbGUxTDB1UkpSZUtkVFY5YU9JaWF2ajVlZVdJUmkrQ0JyN2Ro?=
 =?utf-8?B?V1MwMTVMVVViKy9oTlM0dWZiR3dCSHRVa3diTUNiNHU4dUNHS1ordmdxK0x3?=
 =?utf-8?B?TnFkeXpXeXFXRFRMaS9sS2pxRnMyZEZrOTRjZE84ZnQ5dVdTbHE3TlRRalZz?=
 =?utf-8?B?WS9PaklkUGhzaHVyN1VZRTBFRnVRaVJkOUQ4dUdEWDhkSnB3bTNzcFlFWEFW?=
 =?utf-8?B?emhNc2RRTm8wT3ZXTjlMWndVdGZHWnloSUowMGp3KzRPOXZDZzJ2bVJZSHow?=
 =?utf-8?B?R01IMEttMWFpbFpwUzUyOUdvNW1kVUxBa0lWQndKd1NQek5MaTMwclVqd3VF?=
 =?utf-8?B?V01UK0w2elBsYmYvNzUybzZONmVTTkxVV081aE1aUHNTVUVCN0NxY25MM29r?=
 =?utf-8?B?bWVhYUpjTmk5YkJlWE4wRWRKa0ZucG9kS0w0OXlrTE00c05HbXlQUmdNbHhD?=
 =?utf-8?B?SDZZS2tBYVNmeERxN3dDUjlBTkM5clpudTl6dlhMMnpnQmJ2VjdkeEYxUTRx?=
 =?utf-8?B?UjltSzlkR0YwcjdLNGJQVThFWG43NVloOXRKTEY5dzdCRngyL1pRNEJDZmVs?=
 =?utf-8?B?WHd0emR2WndIUnNJNTlXdEhGTEo3MFZZWE5BVFo0c3NSaDJXMzdJVklnWlVI?=
 =?utf-8?B?dGJQWjJFNjNuekFTL3hGSC9BZzdxdCtBMzE2T2R4ZzRFRC9BZDlWank3V2gx?=
 =?utf-8?B?eXZKdE9TRE03RFZYcU43SGxBcThTOVlkdG9ncjA5VFZHblppaHdqbnNrVVA4?=
 =?utf-8?B?cm5MV3lIVWw0TWVqeVliZCtYUWVIODlNQTlnS3hHbWhHZm5LczJINHBaaElt?=
 =?utf-8?B?aUVvVjEya3d1QU1peG5ZSCs2ck95ejVlMUt6UW5uU0Ivd2pnR0NJQ1RGeHhi?=
 =?utf-8?B?bFBoeGtMQVQ2YXBseXlsK3owMWF5Q0VXc3M5OTZvNm1ZcnZFektibkVBNnpX?=
 =?utf-8?B?L3RVdFJpenN6RzE3MVZJVmdoUDhLNjJaaUN3KzhEcU5LNWdYUStQaENYeTNY?=
 =?utf-8?B?QnJzVGRuZWhDaDZHNVd5RkFLcTNQdFRIOW5WN3QrcHZJRUt1L2hTS0w0OHdH?=
 =?utf-8?B?bmgyWFZnblpiZ3ZHY2RlZUp3Zi8yMUNycThvVzhuYkdDWURkdUROMGNwZEZJ?=
 =?utf-8?B?UXFjTVRRT2F6OUJ6SVljYmYrWU54Ti9MWFFhY3d2L2ZyM0dDTE1wL1JDTDVw?=
 =?utf-8?B?VHFaQkNUZnhjajFQR3lOVmh4T05yYlczclNOdlAxbDFuRVpacjZNblBETmYz?=
 =?utf-8?B?a29MWCszTis1M21lWDI0K3hteWZRb0U2SUgzL1NYc3k3UUhrT20zdkljMlpW?=
 =?utf-8?B?SlNNcjV1cUJKcjRldmFTeVhFOEZrblpwVnVDb0xiQ2w4V1NYVzloOE1hZzRt?=
 =?utf-8?B?VjdXdGg4cGlWME1BM2VnY3RhWXVFQTF4R1JNdEdsOXBlVVZndzJURWtrOHRB?=
 =?utf-8?B?bFAxcnVleDZIdkhGQ0J2UHIzS0lJbXpSV1lyMVFFY0JqY1dobVpYbGlzVVpz?=
 =?utf-8?B?YjBxYWtrdG5sOGVGZlp2aUVOblMxUm1kMlYrUng3Q1FKUklPZVJwZHhSd0M2?=
 =?utf-8?B?V1RPRE1EWW1CcnNLbzY5V3ZMdnd6WEJmMXduc0tnUDYzWkE5dHUzM2lNNU5R?=
 =?utf-8?B?bkRjR0tpb2RuSi9JemVsdytkQzJpNGdJTDI5RFBQWjFCK0d6VWxqaHNNSFpt?=
 =?utf-8?B?ZnVGUzFRR1loUUhXdS8wanVONnFrT3puMWl2RjBEb0RmazJFUG5qa1dtRlFu?=
 =?utf-8?B?K3U4VlRFS0EwZFFrckhoYkRJalZSeW9EQlA0ZXhhbTAyYXcrK215Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7119dd5a-c171-41fe-b9cc-08da449aecb9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:22:21.6405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hB/2dQWePfR5TwsSetCZtMSf1BHpnxtjpf3QmyCHRG5FtP+GyxtMEESK5CisSgBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3152
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

Am 02.06.22 um 15:20 schrieb Philip Yang:
> Flush TLBs when existing PDEs are updated because a PTB or PDB moved,
> but avoids unnecessary TLB flushes when new PDBs or PTBs are added to
> the page table, which commonly happens when memory is mapped for the
> first time.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9596c22fded6..1ea204218903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -737,6 +737,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_vm_bo_base *entry;
> +	bool flush_tlb_needed = false;
>   	int r, idx;
>   
>   	if (list_empty(&vm->relocated))
> @@ -755,6 +756,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   		goto error;
>   
>   	list_for_each_entry(entry, &vm->relocated, vm_status) {
> +		/* vm_flush_needed after updating moved PDEs */
> +		flush_tlb_needed |= entry->moved;
> +
>   		r = amdgpu_vm_pde_update(&params, entry);
>   		if (r)
>   			goto error;
> @@ -764,8 +768,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	/* vm_flush_needed after updating PDEs */
> -	atomic64_inc(&vm->tlb_seq);
> +	if (flush_tlb_needed)
> +		atomic64_inc(&vm->tlb_seq);
>   
>   	while (!list_empty(&vm->relocated)) {
>   		entry = list_first_entry(&vm->relocated,

