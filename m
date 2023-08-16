Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5891C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 13:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305AD10E368;
	Wed, 16 Aug 2023 13:16:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5AD10E0B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 13:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqHOFWnZmO3AlBusUmQdJk53LSwYDRXVmObGQbTkfnDLWfxWYwUs7P4Yj066viidIJVimzexSt3MmNN9zJHv7k5tw1Hrt2ywQeH+XFCcjVxyWUL2MqEevaZNbKNpJt5kqQQASmiSqqYpdVZCDWGW6G/TC8K0mnUefYriVD8tKnX29ArD/uWVBGDadyiPEgNGrZpmPkIGZKEz+6XjNZqmvyANGcCISgojP+JieNLfp2mUbsXwlUFqquBjb34g9yjzwKS4PhHnheWzxpL8K0UN6+hb2xN30gB1fRV5tn8iksBY2yqnpuxF1OkRaSL/qGxmbZfOipaLzeajqEgL58e/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPCtOUYbGx8+cMzOpm+AoEXrsp8SwX29gPffe6MgrPc=;
 b=DbsZx5vHe0qUn9Eca4ussudMBoD/qtQ81pWqj9Ub+B1DfaJ/7Qr9Fz86hbBUnuunbfNahV0DJjImRqKh2vMeQglxmLRoB7EsZTQnpfseCBnrqVv7B+++Oe1LPlrwPYqd5/VGMCThO1lAx2ZkJ//a8wUXbRryU/by/2XoMvvuiV+hCmgC4PBYhsi1fjYnyL2O+mxZTjZtx7Rz1MjjxpLmvLoygXHypOxZhDK2vPJml1PAikMuUnJ1QKq3pkak3JR7w2uN64QbyioxbhAnBdu+TO6KL+KDHH3iKEgchoEVK3D/RoQTx2AFkYIQ6RCCuNOZgqbQ3KxEiJzS7Yte5EMfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPCtOUYbGx8+cMzOpm+AoEXrsp8SwX29gPffe6MgrPc=;
 b=msa7UxagfUNm5asaapGg23vBsmBSiSZ4GjyRqil9hgP5tcFK9DWHMzcNfhhgo2IzOjjChmGCnauBLj5239+e1jcgPoRUQwq4mLIsJfBsu8l0LWaEzEPIUirpR/APQcSEw6b2jg/NEZxcmiK/FWmK6cWbGQUCcpmItGrOmmMfbSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 13:16:00 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 13:16:00 +0000
Message-ID: <a959ad03-e5bb-404b-1aba-2d7c88b6a1d6@amd.com>
Date: Wed, 16 Aug 2023 18:45:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/3] Fixup some coccicheck warnings
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: f80bde7a-e7b4-496e-6d75-08db9e5aef12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1LyAouXnIrrobDB303RCSB7nUxI7YuWxAs872W9MR8Jw8qgvtEyjA3k8Yca8XYDm0y1J2QHg3yNb+VSH6k9EqJWqDvR/q8ZReA2I+C35N43oMVkyMsz1DDYa3vcJbO+TZAHPhVmP4BCUT7KcRXJjN8lAPYbk+KGnWzUdeSZPTbOpqUVnNQIwfcAU96N2yRHo0pw0XGKarmuHlQEi4OC/gYNCqATwl20trnYjpZu+4ACGOEM4lTg9wmgaouHM2NzMtzUN69EaOJwNrM13Mk+QUO2d+QaCKOZxjVF8NRm6MBsXOm3kbAjZwFARMqNi1m/hkCAydpXRlwQh39TAUyJi6+/yUjpBpzHO3kousR5K8nahq3H4MlC5YFzWyIrljUJLR8bJD6ThY2dcW7R6UoQPlkNDHHVZANXs5KuOhLYCgq6BtuJrnZmBVgV1n5dWWnC0VTF3RCcOhwdXmIDHBxOfVpDrkYs7eY7pIIzaA/YMFgAMRI3RR5sQJrym+76T0fUoCc1zhFAaC6KtmSA6rBiYDZxwrhINV3NMGizu36WEM1ZiVni0wKcHosDlDuW8X8qBNsE1sOJGtHA/S3GxJLWMyDbDc231aWylBTb1e6gf2xRwaXtbKostSTTU/7mHrBRI5AjuhB+W6U0u+YGR7X4Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6636002)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3U0ZDhmMTVKTGUwbytJTlVkVm5IUi94TEdjU0c5VEl6WmVKa0paT0FOWVZ3?=
 =?utf-8?B?T2x0RzBvZDA3Y3dGVzNpSTNOckcrcEl2dGZUaGdHYkhBZ2E3REY0QkFSOEVu?=
 =?utf-8?B?Vmd5bEZoVFBTek1KUk9UK05BaFhDWFlMYnh6VDFsaTZrbjBYQkRPVmlkdWh0?=
 =?utf-8?B?S3VFc2Z5K0JJemxzTE1NK04xZlpNOHU1SEU3SEdwcnhQRTZRTHhiMEdZeTNZ?=
 =?utf-8?B?a2xVYWpxQnNsZzVBdlVGUGtScXZhMWtENTE3QVpLN2ZRdGtxdGFiMkRQTmV0?=
 =?utf-8?B?cTJxUWFQKzJoUFdjNjRCYjl0dkpZWGtmQUZaVXlvS1BzZzVSUDBucGpCRk1X?=
 =?utf-8?B?a0hEL01RRU9XYmlBNDR5MC9VYXBBMjhGNDhCdUpMRWQ3WHdjN1hrdHB0elZ4?=
 =?utf-8?B?cGpQVlVpYW9NSnBXWlh2SmFkdmhpYmtYbElrK1IyU3FVRkRreGl1cWxNdDk5?=
 =?utf-8?B?OGxiejdLWVhzOTQ2Qjl5QzZwdkdKcDFWY0NBKzRMTFl2ZFowcUZyaDRHRG1t?=
 =?utf-8?B?elVWMVUrWUt3cUwzZ1o2a3BDT2JORWVOc2hvUk1CR0RVTHpVb1ZYQzR3Q09X?=
 =?utf-8?B?Vmc2bkhua3NoeDVUQzVrZ21JQnpiUG9uUUNIelNtd1BxOEJBV2pZSjdXazYr?=
 =?utf-8?B?QURSYStJaGo1SDQ0WDg2RVlXai9aNHFaV2d3elVhcjU5NFdmcXRZdm1YMFpM?=
 =?utf-8?B?bkQwUkFzUnZrZUtIZ2NHYy9VMjQrRFZGSFdJMGNtTFU1MUNNVjdpSFBEa0ZT?=
 =?utf-8?B?Q2wyaWhnaXZ0Q1RveVhzSmE1eU1jcCtuc29QdlhhS1dSRlNiWCtpc2ZBdXFm?=
 =?utf-8?B?UGk4TlRZWFRNWnRWWnVvaklQQzlBUDhDdlNRVHoxOFhhSUxBb2NSSG9iTmxk?=
 =?utf-8?B?N3V0TnA1QVNnbnRYMGNtaTc0Z2xPR3N5Znl6QVVzSzFkRzlYV1ZVckMvcWlL?=
 =?utf-8?B?cG9WeFh4aHl5MWNFZnpueVA3QWhab1hXRDlpRXVESlcvZGNnczJLWVlCQ3pp?=
 =?utf-8?B?bG5DeDlVT3d2a0g4ZHd6cmdlRUthY2JwZFlZSkdFMWdHTlA1SVVRWFYzSXBp?=
 =?utf-8?B?Q0libElOZnVFNjN4MXdUemtTakNsRXp6UzNSR2ZyVkx4RmZVNnM4M2pFVjJj?=
 =?utf-8?B?a2NYTHlhMERJRHpBYVBYNGdjNDhUaGhaeE9QVE10a1A2R2JMQ3l4aU5KTzho?=
 =?utf-8?B?RGNmd1VWU3dpMFpJLzRsaGgraG9SSU1lRU9xS1hKTmRyZDZJRmJNUE1YZVFD?=
 =?utf-8?B?aDVYREY5eWFXMXNpdDlzLzNFUXVacHprTzdUb0hBa3BNR3IyNmlLWGJYVnVX?=
 =?utf-8?B?N1d1UXBvS3BiVTRLbG9OdVlTU1FKZ0hmQ3grVGZpWVgxaGxQWHVDczBTcGgw?=
 =?utf-8?B?ZE1UY042eHlwanV1aGhSWE5YVlRZZmFsUmJ5bDU0eVRneVRwVk9LbE9XaHJO?=
 =?utf-8?B?dzBDSkxVdHNMWWRTNWNnUHNDY1krOGZibUpiWllSRThSQ2FCR2c5T2pMREFR?=
 =?utf-8?B?ZXZSZFV0WXlxc1R5NWFVL1RPYXZTSkhBQXEyM0dBUWJoTmtuSWlTcStzWENy?=
 =?utf-8?B?NklOd0VEQnhWakNLZjViUnZxL1UwY2lvWXFPdG9ZS1VmV1pWdGpZaTBxaEY1?=
 =?utf-8?B?YmVhbXBOTDR6VHJuR3pNbXBJT3QxZFR2UFBzNGVkejhRa0dxeU5SZ0tDYVcz?=
 =?utf-8?B?aFhxZUlkQllXZlVVVjRvbGc5V3JoZnM0VHpGTFd5WUU4N1luRzFVZkFBVDlX?=
 =?utf-8?B?UWJUbW1DNjl3MkZWSTYxc3YrOVd6SHVQckdGNW9HSklHeU1aMHdRVjJqdmt1?=
 =?utf-8?B?RDE4aUZJdHRWWVdlbUpyTXhPRVZJMkJuRE4zRndnak1WVWhHQVVNVHZDdzNq?=
 =?utf-8?B?UWt3K1JNZ29VYkdrVGNTMmpoYVhMbXdhV0xMSmw3VXNhaHcxcFI2TStCaFYz?=
 =?utf-8?B?K0VWVzJOQmozR0FiSTYvMmZZc0lHV3F3REJkUzFUeU1UUHRPeDlzU2hDaFRJ?=
 =?utf-8?B?b05LSUQ5dC9aSlIzZGxoZ0lrZCtJdGF3cmg3QkdubUpYNVN4VG93WnZHWkdZ?=
 =?utf-8?B?aHU1NmQ5LzFYNGtINWJDRy9zY2txQ1V3d2FGYTdzcTU2N1JPa1NNZHdsVXhQ?=
 =?utf-8?Q?FOL1dSHuR7Z21vXf5sTlsmhEY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80bde7a-e7b4-496e-6d75-08db9e5aef12
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:16:00.2303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A8LP69DCSTaWlY62nLBcXgoIpMJ/ID4rerbk+qDpBT1p3DKgg1Q+h3d5YHOCSFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series decreases the readability of the code. Is it really a rule 
to fix such warnings or is it only a generic pointer to double check 
(not to be followed every time)?

Thanks,
Lijo

On 8/16/2023 5:02 PM, Srinivasan Shanmugam wrote:
> v2:
> 
> Updated to max_t/min_t along with commit title message
> 
> Srinivasan Shanmugam (3):
>    drm/amd/display: Update ternary operator with min_t() in
>      'do_aquire_global_lock'
>    drm/amdgpu: Update ternary operator with max_t() in
>      'amdgpu_fence_wait_polling'
>    drm/amdgpu: Update ternary operator with min_t() in
>      'amdgpu_ras_eeprom_init'
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c         | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 2 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
