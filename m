Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0680C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 15:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0EE10E4C2;
	Wed, 10 May 2023 15:00:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9370410E4C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 15:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1CQ0eJHZU8wFyCiaB2KiM5Fyt42Bk0rukd0GxyQ4SykdMy8HOvsutTR1Tj5IQ8DJNkWNCdRhDv0YYhJwQOWvWB3AExrD06YdfiO4tKK6D2/cuWtE7CBL3RPz1pDgyvLjwc/j2aiv23OST2WhYjXyDwohHgWWIucAhjtuIouJJSCLlkmA5e0NNAdNrh9ERVBo1SNecyozJ8CGii3jNdW1SU6em2hFDY9QLRIWHsViJT9Bo1dQjUydrApHH5ezAihHVDKfxx91N7g4DlnB5bvZim9c0zOVC/8Wi/FbrF4zdniDYgSHStcC1KeVFtUULutOfrod+eSgkARDzyn/IZmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dkCZsguE45xI0U8AGdNxAnoB95Vq+/vXDRry0uLIQo=;
 b=W0lsMxasuysd6FZjYInr8VKE6ZJycdDKiPgnOFNqotAxWeQIIWmMy6xl7G1q3VHVfXYCG0G1nI96n6DDunhZQ07DoK92X3EnWvFOcl1WsUpsgdfNHhbwGa5AePs5ed2uS9oOUArH5rOCDV/nIdZdOuZbS6VMg1iFpRlpkdCTRoEK8m/roEY6t4TxcvwGknCQHBsIqR40kQtpjV0hm+Ci5OxfzeJc4QB90JtEclQWSp/DjhWfpqMb0ScBL+NEXZWo0k44s0HTHWDf1xaMyFxe0c3GPiy22og3DqlZlU2NwW6k4KOPomXTQpcUCQiITUjh+wedg6PopKZlGnfI+R+oMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dkCZsguE45xI0U8AGdNxAnoB95Vq+/vXDRry0uLIQo=;
 b=0psefxahpGskUqewSVxY2rJ3ILtuKB2tjZ5RXyRQGZY1rHv5yHZ5yoXcGDR9qLCmqXae/pLNIursXH30Zi2hcLCCZXuN0qE+K8F85QLYMTKn5drqzT/Kpke7vFwOFFiVM+aG2gMPfdZlZXq6xOYrg+VdDfyuK+da3Pgs+BYB9Nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 15:00:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 15:00:27 +0000
Message-ID: <d6475a52-c420-f6dd-81a2-30c9e047cddf@amd.com>
Date: Wed, 10 May 2023 11:00:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdkfd: Remove skiping userptr buffer mapping when
 mmu notifier marks it as invalid
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230509221738.477282-1-alexander.deucher@amd.com>
 <20230509221738.477282-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230509221738.477282-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9f3465-a5a6-4b7b-fd6a-08db51674a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oF7V9PaQRbQX1ZurXld5+/NhQyJIMDo1MBEevi6VShMBkNSXpPLYB6IT9UG4s/p+C8NlKvSQchC7imCs6LkSU4Co5vNnVP1LQy22Q0H/DxRVyJRWiXtdh3X9ut0Fau2pqCzPC9iid9+MYrIc+4cjpmpTzoFUPA94EWJvBgsj1KFOFa+CGKmJx2OZUA09o0PpyV7EwATScteHPMBX0dWZV5kdYb053EhA9pwxDI7WjFO+CRJtYtu8gpY6J5v/hylcHl5Y5DFOUklUT4CKbqvmoLbdYWavQArsA96hNW44c5Md9xI9uI5GgTi6xyTLlxaMlIr89uG5y7hv4XbCP5YkZkeEuZb7RDA/VUm9s8HgZOMhmrDHzMfWDSjNZO964n5FQK7p/MNy8ASsSowXyIIEOLsZY0ELpO8Mn+ZvztpAfEjql+M5cm8+A5qh0VzUtCZrYifdjjRMy5lDYgtULCr18sOzIDIDoSP/RzmI8hiGVNQ7L6jPUp/RZOECPPB/qgzzvhMQpthaZVRZ0nJfHiyB5kPLmDpkN9/fEaH+spmfwJfQ5lQyg6CzrqnR3hzBbSJ4AyrBA6BkDzwntaYsbdadNazFgsAXqEuRBSiKAsKDTyAXX7+BlpXVsnoIRNLcFv68zJPQPotW17bSdQQyPDtHx1eVng6YXO1Wt2QNyXpBuVmQ1THrSlsHjgbPzvAdmRo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(36756003)(2616005)(6666004)(478600001)(6486002)(6506007)(26005)(6512007)(186003)(2906002)(38100700002)(66476007)(83380400001)(66556008)(4326008)(66946007)(31696002)(44832011)(41300700001)(5660300002)(316002)(8676002)(8936002)(86362001)(31686004)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3F2dTJYWVQwd3JXS0k1N2Nic0k5SXF0WTMzZWs0YVZPdHI5L2dDb0l6djVo?=
 =?utf-8?B?d3lkc1A0Zjk0T2tnZ3BNUjIyZDBNbURKbUdlUkZieWRZa2tlcmVnRFVnMjZK?=
 =?utf-8?B?YzN2UzJQak4xNG1JSC9wSXZEK3B1NTRlR0pONlpZbVBrOHByNlFlZkpKVmY2?=
 =?utf-8?B?dFJYNEJTcDNyVU9UakN3VXhHbTdkWURkRkdCVmY1RE9XUTJ4RnB5OHpOVnZT?=
 =?utf-8?B?c2RmUWRWSTNlUzkvTk5tRXRlMVZENnBhMi95SHoxd0t6OTZhK0NpOU5PSC9L?=
 =?utf-8?B?SzFNRXkxa09pNjF3VFF1aGFJNlpwS2JwblB0TmFCMSt4MkhrNHBnYU5OYXpY?=
 =?utf-8?B?VDBXOHdXNEpLVkZMakt1dTVDZldhOWdmNnpxQ21WendUU2paUlBvSGhaZS9E?=
 =?utf-8?B?YS8zVEFYRzU1Z3NwRzdYc29OekFTdjJPQktpMlhXZmRlYUVsQ1BzWmJNR0dW?=
 =?utf-8?B?UWJ5NU0vYjZISUZxLzBvZ1BickNYWFpreXlZYWdySHVRY2hEOFR1TG5BRUEy?=
 =?utf-8?B?ZloyNDlVWlE0OUNkYTZGbXZJNDRhVVJUSjR0U0pkRXVLbGlQSW1MaE1lSDBk?=
 =?utf-8?B?S1YycFY0eUM3OXFxZVN0UTlPOFBSZWZ6MVdyT0ZnQ2tZQW9jR2FTQ3VDNzNJ?=
 =?utf-8?B?NzZGYjBWZXBZMFJ3emgrUDBQWFVabVRCc0pBTVhLVS9yb0lHOTdPdUJ4ZG5U?=
 =?utf-8?B?dmlTRW1kUVppV2hkUVlzR0N5YUFIdDgxTmtNWlpsQVpMK1VIaHY2KzhDNHdJ?=
 =?utf-8?B?RmZYTGwzZXVSOFZKZWw0aHRuYS9NbGZ2aWhCV1kzZnhEN3JKQ1FFS3FvdHlH?=
 =?utf-8?B?TVJzSnV2ZFBQM095cEZsYW00aVBwOHNlYWZ1TEFSc1pWeUxKQUkwd2FpeWRz?=
 =?utf-8?B?YmhYM0JldUhkQXkrSm16RlZQUW5DTUN2TXpHdktYU3NRTFRtblBKUXE1NWNC?=
 =?utf-8?B?eWZ1bjkrbmU4Y0FrcjRER1RkR2Y5b3BaOXNnOGhhc3g3dHFnWVMyNU5TSWtq?=
 =?utf-8?B?RzU5R2M3UkxNNWJhb0plbTFWMnpsN1RhRFZKM1RIN2FKaG5Cc0ZkR3Y5RGhP?=
 =?utf-8?B?aitSRWU1d2FBVEhXSEt0VzdhU1dRdmFkekt3NWlDTTIrTlpsclhoRmt5ZWlT?=
 =?utf-8?B?aWQ2MlN1ZXhZeDN3eDg5blFqRkZHVW5yRU8rOXlLZjl1ZnFnM1BzNDBENTRZ?=
 =?utf-8?B?dE5hWUc3b20yZTFtYU9OMVZTWmlMNTR6ejJSWFVVbG5PS2VrK28rc0JUMmdt?=
 =?utf-8?B?aEltZjBibEkwR3k1U0taeUFwY0ZHa3RMZmFXb2xXajk4bVphOERnMWNBT3NN?=
 =?utf-8?B?SENkVEtWTmJzMjBjU0E2R1FzRUsxSFBBSmMxK1JZUjdOK28raGFFVUNjTFl2?=
 =?utf-8?B?NnRrdmVqTC9OcTA5QXFreDZ4WHB2SnA3aDZkcHM2dzlmNzJaSUUxbktrQTdm?=
 =?utf-8?B?YjJNOHE3bVAvTTNTWDgzZ0dJVWZQUWc0V2RZMURaejQ0UWhtczAvcHo2NTNw?=
 =?utf-8?B?MmZ3TVU5bmhRN1RnYjBnR21TdFd3NENYZW5ia0pydXZXTncxaUVCc1Bnclh2?=
 =?utf-8?B?L1plM3VPbmRCVDVDSDV0S3Nibjh5M3ExZm9JVlQ3OHJJL1pVd3AzeGRMTmtr?=
 =?utf-8?B?QXF1M1JHVnNGb1JscTc3eUtudmpON29Xb2d2OFlVT2dmblZuVEk3c1oxNXJ5?=
 =?utf-8?B?WkxjYnNEQ2cvSk1PTUF2bG96cTk4VHJxZFNkUmlGSzdVV3dtazhwSi9ZVmpZ?=
 =?utf-8?B?N2pSeklxTC9CUDRqL2dhdkt6ZUJhWU5LNTNBVnJOdWtTaVlUTDc5MFVqUVY5?=
 =?utf-8?B?OVh4Znhjc3VjZndXdldBZm5YczE5eUhITEM3UlhIdm82M0VhMllOOGVQc2FM?=
 =?utf-8?B?K0pNc1JKMU4rY3ZVSDFVYkJxSS9iUWZsakE0K2UyZnlzSnhvQll2NEVoVDF5?=
 =?utf-8?B?aU1jL3hKTWxJcEY0dWhqNlR5d2YwZFB2Znc3OE9WdFVabVlnMnAvNmc2OWEw?=
 =?utf-8?B?bjEvQ1VBOVpnK0lYZlBKZ0hKd2lhbXB6NWhQLzlDZVVmTExwUG9JZU1EUm9x?=
 =?utf-8?B?ZXJ1OXFkT0RGQVlzam9xMUFvdVdwOFJtcVpKTUlJc1JuTEJIUFZVQjM0c1ZR?=
 =?utf-8?Q?D+++J0wNtMIJM3kQ9Xo4MD5Ne?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9f3465-a5a6-4b7b-fd6a-08db51674a19
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 15:00:27.1736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ9u7bwoSCyiRVeRskOtvNVfE8opdumAKbVgI6+HEsubd1TyMShRdrGw2i+u+dx7v6w6ve2AfchITVQ45G0Kaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-05-09 um 18:17 schrieb Alex Deucher:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> mmu notifier does not always hold mm->sem during call back. That causes
> a race condition between kfd userprt buffer mapping and mmu notifier
> which leds to gpu shadder or SDMA access userptr buffer before it has been
> mapped to gpu VM. Always map userptr buffer to avoid that though it may make
> some userprt buffers mapped two times.
>
> Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This patch is no longer needed and should not be applied. It was 
originally applied to amd-staging-drm-next as patch 
fcf00f8d29f2fc6bf00531a1447be28b99073cc3 in November 2022. This fixed a 
race condition due to incorrect assumptions about the mmap lock and MMU 
notifiers. This hunk was added back by my later patch f95f51a4c335 
("drm/amdgpu: Add notifier lock for KFD userptrs") in December, using 
our own notifier lock that doesn't suffer from those races.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 58a774647573..40078c0a5585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1942,16 +1942,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   	 */
>   	mutex_lock(&mem->process_info->lock);
>   
> -	/* Lock notifier lock. If we find an invalid userptr BO, we can be
> -	 * sure that the MMU notifier is no longer running
> -	 * concurrently and the queues are actually stopped
> -	 */
> -	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
> -		mutex_lock(&mem->process_info->notifier_lock);
> -		is_invalid_userptr = !!mem->invalid;
> -		mutex_unlock(&mem->process_info->notifier_lock);
> -	}
> -
>   	mutex_lock(&mem->lock);
>   
>   	domain = mem->domain;
