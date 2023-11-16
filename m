Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEAFC47071
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 16:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B9C10E63C;
	Thu, 16 Nov 2023 16:42:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5FD10E63C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 16:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYM+RqfoaYMC5oNK+DTTdWU9SzrUd08ih2NYLwG2LjMoYSjzc4Bhj+vd9UjSSveCIwzSf8N3eZH5frq++LD320wS4QB9qgJ3hVbfoZJmqb8HAtVvsGl6TD7QtVWaJFWqgMC8VjYnpw2hBcRcCPfZfjodnODfS0tUWk38VflDW1og5Yge5AS9FQlC/T/RLlSy4iAGIP+qG1Xi2o0mjN78rPbK9qWgBFg5musvV8MVHNToScGV0fzKv0M7B5Lwlu/hOJQ9SkSPqKDP4PJ5ONLQPHw6MJYycNb6Ypkxjqpa9f4BCqCgysZ5sKpH2IDz7AT2qxMTWxN3B7NG0uefwQW8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLmG9znImKOev0DgPBdOQhH6zsA2sy2lF3Kqg6UQPJ4=;
 b=KnBbGxYd0IgoNiWYDSYEokj99Jm3o3im39TFd1yaPPqmMo94HVca6RLntqNaA/tL7yJ5C/shZ9jF/eHY4h1fQMpcvvl+lH2FbAqJyPPncdhau91b2Z70m/jiKXFLdnPjCB7+BqaKyLQKdUPPXQGYB6qpHV7E2EXMQxEGEr0Skyw8iGeMTI9q4ADGQjFPVpzSL4eDaQgqT0jwBFnt/zQGBActqLEj6kOkmbLzI7uAnapo1v/JrkaymG2KLKdWxLs2EJ/cuBkCdGA4HIAceFysDev4UfRoBxo2uCzyUj8NXMwFeWYfTAT8iPj2zVF+bcKT/O/Rjxl4AgF1fLn/2akfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLmG9znImKOev0DgPBdOQhH6zsA2sy2lF3Kqg6UQPJ4=;
 b=ZCjOUfBg2yRFGuUfP6I/0+y+pcRUlTNJ3JdxkHYk3wAEWxrBmuoqTN/1vhg7T/oqFvtCBdm2bTU3CUqqPfMgy+bZ0Usm6+mNBlyX398JooNXYhZHy1GcvI6rFWYAWw3QDrWvuKDJhRQtDmzGnkQ943QyCB/YDdzUj+c0xluOlfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Thu, 16 Nov 2023 16:42:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 16:42:06 +0000
Message-ID: <0ff79e3e-9400-4d80-a400-7ee21d2e76bd@amd.com>
Date: Thu, 16 Nov 2023 11:42:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add function parameter 'xcc_mask' not described in
 'amdgpu_vm_flush_compute_tlb'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231112044534.1637245-1-srinivasan.shanmugam@amd.com>
 <20231115161540.72584-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231115161540.72584-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 1186842a-06fc-4575-1401-08dbe6c2f7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCLihVK0tqM1ZhJVu2fwET9+rA/vWfwt1LYrCna3KKenXn7g9fJ4ErCaE30xNQRdUPi2Lr7Tf8jp39WGU8EWsRYkhFWq+cKS16kwWV1DlaxOAJrGIb84/C2HLrQqni5H2ebIpmMu4dWQKuZJixenIyX1PtlN3IlkjMuX+0tPJjMei6qN7AwJ3SQoHVcdtoyufCX+FyIppEoYXdPqIY9PmUz+qrXcY9LIT9vnonkafg+Ot6UGDNF0iIDrYMyKMX92tgvCaDcXQAWqf2DPQpuohAxIY3o6nwP8djTada1TxwTMhL8l245bIIlEYdd4vefvvcX72clsw35f2kUHUcBqkk/UmN4yBd+Kh/mHV1f0W2oIzwSIcqlsFuRB0KiCeJesGBkbi01vMEp2SpbJkVhhVbKMZShaEa3hp3Av7791EzvA2jmG+7POdzI1dp69j/DV370RmEPFh/id9lXUIxmKrScdmE7qSepDTsq9654odzFi/AtJDWr/+CIH0r1rbY6fxxc0IUZTYMhZ+wuuUugVau/jddX+w+QuVWE7r/kkB/pQJ+/3syNAb35yI7NjffyKcLG/DI9B8KNhUttCERrrjGgTXkXdy1DiTC7udn0FaqXssWCHg20iRB4dFbBxpog7orOWDQubrCIw9zvFxlTARR65nyC0kZhsOG5aTHFrlR/CZ0p+fITacOM48VFDZoMI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(451199024)(64100799003)(186009)(6666004)(83380400001)(31686004)(38100700002)(66574015)(6512007)(6506007)(53546011)(2616005)(41300700001)(5660300002)(4326008)(2906002)(4001150100001)(86362001)(31696002)(8936002)(6636002)(8676002)(44832011)(66946007)(66556008)(66476007)(316002)(110136005)(36756003)(26005)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di82VXdkZXhIOVN6ajdqWi9RZFRUTkIwMW9DY2xxTUxWTklpaWxvOXpFWFZR?=
 =?utf-8?B?bmxWRC85WXQ1ZFJSMDZpQ0VqbHB2M21vYmpEcXNmNG8xWHdtQ2JvV0EyUURS?=
 =?utf-8?B?UTFPK0dlbWlRTEZ3L1cyY1N0TUswVWJlZEJtN1lyRitFd3FqUmE5ZkQrRnlH?=
 =?utf-8?B?elJYSUJmSjhaMHFURDlRZlJ4aGxld2M4Y0Zac0pjRXZpdGMyYmxISENXTVFj?=
 =?utf-8?B?WFREV3NqV3ZYRVlGRTJUTlptVkZycnBxSlRnaEF3RXdDM25lcWZxUFBBWXox?=
 =?utf-8?B?Mk9TQ3lSTEh1QlBnenFHV0l6U3JUclpMRUl6SXhYeUpOSHB5UE5ML0lRU1N4?=
 =?utf-8?B?UzFXdXkzQlIzUnVmVXNtdFdvN0pNOUxQZ3JkLzJtdkg2c2hHRlA5K0kvcE0r?=
 =?utf-8?B?ek9sMWZuUC9XcW9vS1NhQ3l4R2ZkbUtOdk90NDNmOGdyd2wwaW9XdWNVMFR4?=
 =?utf-8?B?VWJPb0R2d3p5QVhJU1NZVE1IVEZMOURvSmFVYVJzSzN0MXdOTU9aS0NaL1hx?=
 =?utf-8?B?b2VwV1RQRkxDSEVwRCtjTWl4WUhaYnNpMjNNTk1tZDJNVm5SbmZHUG1uZTI4?=
 =?utf-8?B?NDdtNG41Y0dmM21BWm5GS0p0ajBiUkp1aXIxWFFhNEdKR21yRWs2TDk3Z09I?=
 =?utf-8?B?S2pDU2FiOEV2M3k1dlNybzllL2pBaDhoNGU2MVNKb1B5NSsyeU1kd0lFcVIx?=
 =?utf-8?B?ZnpMUXVvTVhsYjZUZnRKdWt0UVVKVU9jQnFGUzlDVkhMMWpSRWVrVW5mUjZl?=
 =?utf-8?B?WGkyYW1kVDNzTHEvREw4ZmV6dmN5VEQzb29rc281bDlCcXhlWFpBd0VaZEVt?=
 =?utf-8?B?NUNqQ3lrdGN6OWkva2JnazBrWnQyVHowQ2YzYmVGU0VMb2c1Mm9hWTQyOFNF?=
 =?utf-8?B?WTVVZEpSdFhYR1RoS296VkFBb1ZTcEdFMDlxTUlTeE1BQlFZbzU3TGlOWjRP?=
 =?utf-8?B?cS9RTGdZVXdFdXN2djNQUWw4WVFBcm1WNklPa0ZFMVZmbVBMcENGWGk4SGpn?=
 =?utf-8?B?bmltMXFRcEZlV3lwY1ZnYTl0UWVLcHByaCtKTXUrOUxMUmUzdWNzR1dDY0Jx?=
 =?utf-8?B?V1V1MmtHUU1PVUJXUG1lYlNTQzNBSHg2NEJZUVlNRFE0QUtCSUlSd3pwWHBD?=
 =?utf-8?B?dm5zb2gzOVZlWk14elpWM1RvcVkyMlFpbG5YUitYVHRyQW1aVlJzb2VoVTN5?=
 =?utf-8?B?allLbFFsYm93SDJ4ZFJEK1RCZlhKTGFyZlVXNHJkamkvSUZsYjVHUXpYRXBQ?=
 =?utf-8?B?YkgxOWZGUnpxVi9TalM5MVFyRnhtQmpIaFpvNmc2NExDNktMeHBkaTE1NHR6?=
 =?utf-8?B?eWNmQXlxem1uNG10VVhYVzB0YVNUN3c2ZWJQdkNyMlpVZjU3KzZEQmNEWi9x?=
 =?utf-8?B?L3IvZlJVZDRNbzVLdmJsSmZZOTdER3RxOXQ4eXcrTDZ5ODRGSVFUUTB0Vks0?=
 =?utf-8?B?OWdOY1BKMTEwc1V0VFlGWnYyajNWcHh4N3NjaFZScG5wRDd2cXJyTWZwVUxl?=
 =?utf-8?B?Nkd5ek5TSkVDaWdBVmZWSS9ZamFPRnVFT24rcXIvMGsxUGxtWi83Zi9iYUVG?=
 =?utf-8?B?cUJuWnFIdk5PeVl3UnkwNndUUldTUW1ZcXFYSVFPcGEzZUh1VzR3NVlHRk84?=
 =?utf-8?B?MTNHSVVBQzJSYjcxK1dXZTRBVkdnMllBWnZNbTluTHNONGRiTXF4OUFOa2dt?=
 =?utf-8?B?MXJCNDk1RXRSclByYWRwTHRtcEVyMTRSYzRJdDhXMDhmMHVIZSsvRTFnU3Mz?=
 =?utf-8?B?NnFkbzBhejBWVVpGOXhzMGpkZUZlOFg1RTVXandSVEFLN240dWlrVVRZS1Vx?=
 =?utf-8?B?Rm0zUWg3MjdaSFJ4TmM1ZmFubnVWY3lUZG02enVOVC9QNXdUZUlqeWVzVlhZ?=
 =?utf-8?B?VXZYTkh3aDVGYkd4OVoyVkRQS0hzR2Y1Qm5MVCsrNVhtTVRLYlFlZmo5VTFl?=
 =?utf-8?B?Zm1HVFJLcy8rNlhWcFlrbWdrKzZSMmZxeURmUlJIbVlYcWY3VU51NlNHVUx3?=
 =?utf-8?B?KzBKWjk4LzJjcE5IREVLUGdBUmVXUzJrVTQxYzdDTlJDZGRmUFpDZHY0bUFT?=
 =?utf-8?B?NjFETSsxWXo1Q1RqRUFhamJxY0VQMC9ZUlN0UGMyMGU0TG1tWkxhMjBtNm1E?=
 =?utf-8?Q?2mMJRPZL6xrRahwLA4Yc3CXUB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1186842a-06fc-4575-1401-08dbe6c2f7de
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 16:42:06.1075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47klwF4LJpFlDqeq3kR1pC68eihHv6TQGoOE6eWkupDezDxof3wYC+oZC3LSbQBSiBvoVYQpKAOja8jtQYlGsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-15 11:15, Srinivasan Shanmugam wrote:
> Fixes the below:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1373: warning: Function parameter or member 'xcc_mask' not described in 'amdgpu_vm_flush_compute_tlb'
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>
> v2:
>   - Updated xcc_mask description "mask of
> XCCs that belong to the compute partition in need of a TLB flush"
> (Felix)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index be084cbe7501..9cd2595f6c22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1360,6 +1360,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>    * @adev: amdgpu_device pointer
>    * @vm: requested vm
>    * @flush_type: flush type
> + * @xcc_mask: mask of XCCs that belong to the compute partition in need of a TLB flush.
>    *
>    * Flush TLB if needed for a compute VM.
>    *
