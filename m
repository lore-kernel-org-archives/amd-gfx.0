Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C2EC46CA2
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 07:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3BF10E41B;
	Tue, 19 Dec 2023 07:59:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756F310E41B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 07:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arzsPtJWcOtPXFBC18bvPoxhzqKL3/w8/SIQxdXFuyeu+P+aHUBRKsiQnlUkwxlpvsTT/qmxtxQc5R1Ec1vU0zu4uj8PGqQG1XDs03FjBnuL+a5pLV6I0CecB2YQQ1761y8StQQCPA0M052GR5/+fcw8I2RGUjdzhD8HsmAlbyGXrsNdhyvDK5UQe2WttEx2tpD1JOzlHAGjF0OzERAG72A4aAdqbHLRLbi47AvUlSXg1iM2TEuYlPSCkviPSBwiKc//tZp/JI8hfKQ8LvBa8G4zg1a8CfDUdPO4QVfcLAZxvoDtPJCT7Uqiv4aVaigxXzer3xPjBSzx+uakN/gs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fBi5DMYOXbeYBQIetScMIhjWXhie+m3exX/ybIydC8=;
 b=ZQENRqct+xPaQybow6BIPAVS1y6qVhtNHjqlfzIVpIJfSNvVIWF41ZxAgmZvN8ikMmZKs434qPGYabYXligFSvcygkNlCb2FS31ZxnaEI9cXMElEOB9Ukkc4X5g7nzRdgXArRNcKnC50dc09v2jpZ/BT27X9VQ4cUXCN2zNLN9DTkGc5FsVRD2N53HzPgTVwyAjZY7JWaLgzujDEzbCTdLDT5WJaTXkRH9UhXT8U4rjUrtYXlNnrlar2ma6HWIYM5JVBncNoB0Wgt6QOndQQHlXKb+qQtwj4CO1XLyLgtkJ+3EfFUw85FnAsCF4J+vO8R2eomDlqpZDGL1vU8kcggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fBi5DMYOXbeYBQIetScMIhjWXhie+m3exX/ybIydC8=;
 b=iV5NC0Dnbbcp3+OF4cU+b0BEUIpzSHGQAdGVLGbd77ebAAYfSRzLKVuPYdl/yIZ/O+utllinqejslURm9Dkas0rdABZhOkO+fSEHgxzKpMnDbZJ7jn0CZoqT+VHRp8toQfF/vzGqTpirDtn20Lo1VyPR0a6arH5RsVtG4MqvsUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 07:59:35 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 07:59:35 +0000
Message-ID: <6f40d87e-ff6d-45a1-b569-5dab9a7b01fe@amd.com>
Date: Tue, 19 Dec 2023 08:59:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: re-create idle bo's PTE during VM state
 machine reset
Content-Language: en-US
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231219070010.1568585-1-zhenguo.yin@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231219070010.1568585-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f530b8-6474-4289-7260-08dc006870e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cu0Uu8Ew7NMMvehIy104K9hoPkVooNNACBC+AfkLchx6Ev+Si1q3nzqIsUOHyzPXMd33s6yHaQY06dfZITrpzmXORpxMhU2dD5e1OoL9JDBmQ5NsP8xwEIdWo0gc6aKA8EoE38SriXfqriXzpml8enlpTstfe4gSmuvb0UM2jseVnmqiA22XWk5CrvtWE5yNmuOqfZ0Y46lgt66V/r4fjx7LMBLRSs4KK343t/StAO9u9EH1il5sfrzns8D2V9Dyytg1rk9dk29iqsb46bK/MY6SCh95m5+4gxPcx7BOZZ1C/MtIYdDS8MhniSMlD9AtE9Cj2GMsFP3yJYF2GVzf8TBHZMGpAxNidQ0Oqtd71AvYh29ZNcVj+Bwq9/fHMepdHt+HOvtFMfgfHWoIrqlgbgCHAiVc3wjc4BSLn9Z+VeibepG++UVDt8PgdW0RBTE8Bjn+8zupbPYHyW1Rwtq+yfiz9PGXvpOWCGuPzTR8JEkv+A72phroJpVfFHzlloCtzIRzZnzX/3BG9Eiz7mTB4KQvejPHRKa15r5GZUb53svWf4dNQTVkqw1847JSwj5rRZPJLAoZaXO9jifgE0Qjgsgf8Ni83VcuZkrCTFA3VrRhmXjlmsoF8XiqZV4K6ZfmMzUUVTlsSFNG8Xx3PmnPoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(316002)(83380400001)(66946007)(66476007)(66556008)(2906002)(38100700002)(8936002)(8676002)(4326008)(5660300002)(6666004)(6512007)(6506007)(31686004)(478600001)(6486002)(26005)(86362001)(2616005)(31696002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlLa1gyN0NOb1VFVjRpQnNYYURibUFFK0Z1bUUvSmZPNDZpTURBeUFCOHFS?=
 =?utf-8?B?SU1SR0RLYXVPWGpNbXFqV0pxUlh3dXpRVi82UHpjczROYXhKRzRDak9RUk0v?=
 =?utf-8?B?VVdvSm1tMHBXY0xqU0dBKzBGQUZHZHlZNmd4djYzeXI4cDViR3BZUFRROWs5?=
 =?utf-8?B?bHE4OXJwZW52QkRuYU96eG9NRWd4MlhmWGE0eDVhWURUay9zRXJ3L1BMN00r?=
 =?utf-8?B?OUpuYTg0aldxTkZoNmFtZXczeXQ5YldpVU5RWmdvdnFtVmM0a2ZLd0ZuaUUy?=
 =?utf-8?B?bWpQZE0zcnhxNk4vUlBXZlVoTFJiRm5JUHc4RXJ3T0l4Wk56MXFBbU9TUWhM?=
 =?utf-8?B?elFqOEduL01icU9Xa3doK0I3cElUWmhSSWJ5V3daM25vNEJYejViMWZsazR0?=
 =?utf-8?B?MWRFcEFIT1hyNTlGaUdyVG9nMXYvK29qZWZoZmEzRTNlN3NGQzFvZDFrSE41?=
 =?utf-8?B?ajZNZ3hXUlU3eW9yUEtYeVY5VDZSZVRUZ2VvUFNKcGNrbTIxYTFPa256WlZW?=
 =?utf-8?B?UnNqQVpBdUg2UHF5ZjlvMlViV0drUHFvcDBuK1UxbTFwNStVU2Uwa2hLTXRn?=
 =?utf-8?B?YlBGb3h2R1Q1em1WK0txZ00vSmR4QlNuZURVMEhSTWt5QW9SNVhRbno2Szh6?=
 =?utf-8?B?WVlKbTRaQlFvSDNEcEoyaWdwbzQ1TE1HUXdNbXRSMVh0Y3JkMkVWS1ZKSTZ2?=
 =?utf-8?B?QVBObzhHZ09McUlGWlQwNzJCZ3dxbk9VTlBRdEhNQVlCOWFLeDNiVTYwL3Rj?=
 =?utf-8?B?QWZyYTRRL2RMM3R4djJaMDgzcWdEZ3IvanA2ekd6cXQxVDdsTWF5UllyVHNp?=
 =?utf-8?B?MHdlRTRoejJaV0FUUi9kTHJ4djhYaElXRjR2Wm9sN2lrbmlYQzQyVDNybTcx?=
 =?utf-8?B?NW5Ndlh2blBGZkNKcmtWbytabXRPN1ZPSXFuSFRna2g5UTgrTmxXVGxMbjlV?=
 =?utf-8?B?Qlg4ZDVubzN3UkxjbVhJNTEzZCtmT29mbjAyVjhocUc0a1R3S3FLM0NjUkhP?=
 =?utf-8?B?Y3IyZkJYa3BYVm02Q3JweVNyZkRUeklleGU5NkZVRGh5VWlpUkhiRmd4YW9S?=
 =?utf-8?B?R2NDMThLT2k3alNBbytBUWVIWmgwdDhWSFNQNW1IS1hnOGw3aVFvMDVpbDI1?=
 =?utf-8?B?QW1McElCSnJyS2dkVWN1UWVKb0E0MkxJNjAwTDVkaElIYTB0M05xQzJTQk9n?=
 =?utf-8?B?OHorbzZ0cXZweWdhRHFaMXNvNHl0S0RkQ05yRnBMeFJ4aGJHbWRqMG1tdFpN?=
 =?utf-8?B?T1Ntam9JQUxvdTN2dHRNYzN4bHFaTVhYSWFmTXh1MFRqVEo0VE5tdDU3VW1t?=
 =?utf-8?B?NUxhWkFpT3pKZnd6T1NJOGhpQ3AxTk5GWWVpNmlCbW9mUldyckNzUjh6MWR0?=
 =?utf-8?B?SzZKb2l4S2xybVVFUDlrVUdCQXVWVG5PRmRFdmdXdXV6cG1JeGNSb3YwTVor?=
 =?utf-8?B?Z29hVGUrVXpFM09Ha0ZxVUViT3VpMXBNL2tGQVc4ZEQ4MVl0eTA0SmJYc2Zx?=
 =?utf-8?B?anNKZjAwcnQrb0w0am9UT0w4RkxCcXpoczMwaEpkdkYwcTZsL0N6YXZ6STZO?=
 =?utf-8?B?MThKeTJoRWhiNGJYWVNIejBlU3ZyRGJOWVk2bndXc3ExeVFodmJKdjVldWg3?=
 =?utf-8?B?ZElvUFRjQ3NBcFZFMHlERFFuRVo4T0RlWDNVcEFUakswYjJqTGNrZEZlNHc0?=
 =?utf-8?B?U1Nnc3YzQWtsYkRwYVIrQjdXSEpzdFdEU0JlNXNPa0pyQ2g3ajQvdlY1UnRQ?=
 =?utf-8?B?ejlRMU1jd2tCaEM4cytIRGVoaTVYdmJIUUVRR0s1cWZOcGEwYzhNemRGd2dQ?=
 =?utf-8?B?NVFLWERIMVlrQ2h6ZmRyeDNqMW9EVWo2dVBCdHF2RjVkd2ZpZGZrNDg5cE4x?=
 =?utf-8?B?QnQwdzVCcXFLeGVtMnNSZkRvSnBsdkxFaWRabzQxbGdzd0tuN3NIWjZaYmNY?=
 =?utf-8?B?cTFmNFAvNnAyVFVQbHdTN0ppcGV6Y3NoSURFQ1l4d1NSVFBUREUrS0pzRURw?=
 =?utf-8?B?T2tYcVZHSWcybVNNeVlpcUNNODRtaThMWU14bUdzS01ZdHVUdjVWaHd4aVU1?=
 =?utf-8?B?NVdIcTVpdkNQazBoSlprSG0wdnliWEpPV09ub1BBQVhSaGZFeVNNMFJPZkJ6?=
 =?utf-8?Q?VXxlE104T+9pGFc0baXWNC53o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f530b8-6474-4289-7260-08dc006870e6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 07:59:35.2612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBsDw/nGtAk0YnoWdjFF4oo8+ytEc4SaMV2bbAue977UcD/PGhz2DkFtMBvmza14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.12.23 um 08:00 schrieb ZhenGuo Yin:
> Idle bo's PTE needs to be re-created when resetting VM state machine.
> Set idle bo's vm_bo as moved to mark it as invalid.
>
> Fixes: 55bf196f60df ("drm/amdgpu: reset VM when an error is detected")
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7da71b6a9dc6..b8fcb6c55698 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -285,6 +285,7 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>   		struct amdgpu_bo *bo = vm_bo->bo;
>   
> +		vm_bo->moved = true;
>   		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
>   			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
>   		else if (bo->parent)

