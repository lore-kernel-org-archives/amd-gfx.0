Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5296F51401
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 06:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5165510E37A;
	Fri,  6 Mar 2026 06:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z3TS75H9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4B110E37A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 06:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxoiUtQN5ZG9rUfrwF8jCm/MDl0tboS8htJ+Rcd3aohi8CnKH6VmocXGZXNOK+cZgvZQEIIkx90cAKA7P78rKaRFZBIw3ckDx6XO1QWJPkm18wLweegFwmFv4+/IV39FHkKKk/KA5WFDzYad8HWdelWOrzFMcqpXyh3/eYQAsKyDUJmuHCGiUTg0kfo9bs0a64ZlxKSyq0vn7qPyHVqqEHAuB516JAizoMPya3iuLhu04dphhXn3h5qoESeEiT2Lo9ORdGpIo55O8HGz0q8VaNwn6MwBaHqUw5FGP0vLMqvW8LCdV0ZmAZ7TnPaZnKvFhjK+z63/sNsLzO8aYD42iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HAu/JN0uEEUd9fw4YAGYu5S702FB2Dc/1mA8/9Kzxw=;
 b=khf+17kWygYUMNbYOMaxRSTEK9UNuDdrHPU/pO8bbhRnq3vp5DbjZ/n88O5ACDBoNTsfkdWe4RpTuiJ39+w8UxKsdUYiI37dR2oC7Ml9EFAv/JIcny21V5AwfYaJ53sNtU8a5M8ECJW38UR5SIf667b3xvQlW3BmgxRkxmdGiaONfxCLrOygdoUyOKkcn9MmJ6qDqDuoZzYmv2/CWuiiPVQS6OAA/YU+ON7U2PVjCIPMSvViTLwLvuUvw5tNqW++VCDukaZcswhiKB2dkwuTLTrkucXIfoTz8gRX4srQdTXPQKK4MbFDBdlpUSyWYC9vJN0+lp4hqN4sWUVMUz2zAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HAu/JN0uEEUd9fw4YAGYu5S702FB2Dc/1mA8/9Kzxw=;
 b=z3TS75H91NdoyWNTk03OjIeYN4O8MtsuRSV981igsxEkadSeQDnQdtcnjYvdVf/PHlVMmG74P2z+YNFLGstlVmw03e83d2yxHTHgSxaePzcJ36JZBsHS4GnLHRUJoO2V94RKZRVizWZXge04BlcifA5M5FwOdQqxBPJqckrR/UI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 06:10:16 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 06:10:16 +0000
Message-ID: <1decb90d-1b7a-450e-b846-d3dbabfd81f2@amd.com>
Date: Fri, 6 Mar 2026 00:10:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd: Fix more cases of NULL pointer deref at fini
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260305220540.1354776-1-mario.limonciello@amd.com>
 <7305e3af-1960-4612-9dc5-fbf718b7fb7d@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7305e3af-1960-4612-9dc5-fbf718b7fb7d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::6) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc0c58d-1f6c-4911-8cd9-08de7b470923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: bsk067KyNlmsnBv2IMnsy0y+O4B1ashfYtF9d29dK//63jPqOEP/Ud6tagvlRYsmTr5baeX2H2W5mlbS2WyPvR4rZWvFuWx1WibozD0oaQ3K3bW5RhP/80Ae5BkURx6x6raLESlvdWGMvyrHYdweJybHq1/U60fL9iuZhNlVzq+ICYdGBrSlw6YTFEsOdrPdi/KNHWkhQtIWSdiRHBq0ZhnSrPk14//pg4TOOQe5ez4G+0VXBheQF+XSr2/hBI2Oh1FJMDeoBscoAD0svFm0N2TFihA3DYSoe+ZT3RIhsSTif0Zmm6Y+uCLYakcSAkhZ5cQlZfRblT2/A4IpUIHa1CICn7lCxDV3oWHZBe+hjpdp/sNcorQeNqXTfo25W5JHt4pcnjlo9fpU5SYlGUwAk3hIbcLQKhYV2XMYcvRR+VCAu0iWLPvXppI29igAV06FnHXyMnZpT/K6iSzkqFcqWw2Jd808bdk1bkoKVBs4v7WaEHbHSJ6OTFGc0lLh8Po3hEUfOqe/DHU1jQ2nXhL5PuU+wAC540OlsYNfVYqB7r1/k7k5VFiflZeT7bcNZLREY2PkpLPOkjDieGXV/m065EY2heYBgzmGD93KUTS2a9JlrePKGZfMQlUTFhigoeY/O3Xfe9i3efPwhRA2iCVoWDP+FHkE2AkRHNC9DY1oYVceFjrDWX845a/aZw9/7ksaLLUu1zz0YKvkB6tHJl4FSlB1oPQYNxE4pD6T2PoZPxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU9Iakk2eGdTdnJqQ3FHVzUxeWI4WG1sZ2o1WHpSeXF5MDVGa1pCbWdqTTAw?=
 =?utf-8?B?c042TWFuSFVWbElyL0ZEVU5xY040Y0JtVGJiOEJMbGZBSU5uTTR5OENQS2U5?=
 =?utf-8?B?RktYMkl1Yll1NUlNWUgrcEFXcFNid2JrTWluV3RXTklMcEswUlN3ekQvTUV6?=
 =?utf-8?B?bjRtcjJsVGpsazA0dk13WFB6alhCQXFmanh6akd1b1ZoREVKNkZ3OExHNXZj?=
 =?utf-8?B?VVkzUXR3alh3UmN0RjE0dENXM0t3WSs3UXlkVnIva1RXQzlyR3BHL3R5RTdR?=
 =?utf-8?B?bGVrNFdoWkZFUGRLNkowck54OEdGN3N4VzdmOXdLZzhOU3ZtWUVCaktFMnBh?=
 =?utf-8?B?Ukt5d3lTNTRVM3dscDNRcmp4RU1NQkdnbDB2S3l0YVVad3Q3K21ZZERDcEJB?=
 =?utf-8?B?a2tRNjljcklRNEN1Tnl2SUU2TTQwZGpDSHlXSzdDMHpoYjRqUFE3WndpSlN3?=
 =?utf-8?B?UlFTMm15U3ZlTnlNWlBTRnVGclIvUjBnRGNzN3hpb05xN2lOTFgwT3daelBz?=
 =?utf-8?B?ektJNTdMZTVsY1VKL2NlWkc1NDA0YUhaYkhjSHQwVkdubnpIVUlHREtqME5v?=
 =?utf-8?B?enRGNU5QSkxKSWZDR2NJYnp3a3g0SzhnbzE0ZVpxdXVsMnhaTmx6cldSSXJm?=
 =?utf-8?B?S3RhSHpJS3FYNVNYWGkwcUppa1ZXL2Z5aWpjSzFJSFpPWXVGTGdxdEtRbnd0?=
 =?utf-8?B?OFB6cXF1NFJqRDFTWFZxUGdyTXJNVHNFdHE5a1JyTnRVbnFuZkJmbmlraitD?=
 =?utf-8?B?TGs1QjZyK2pwN0RlTHlIazVGblUxMDlQZ21Xa041QzlyRGNiWno1eW9vLzhX?=
 =?utf-8?B?cGlPL3F3VGVXaWxsOXlrVm5FSjhJVUNuWWR4UEFFREFEZWJRWTdFcnc2OW5l?=
 =?utf-8?B?Q0RsWUtHVUNOWVlaN0loQTVXU2RrVUtEei9sZXRad1BsN0tscERsSE9KbG4y?=
 =?utf-8?B?Ymk1cUV6aHJ5MGJ5NGNBMTRyRTZBVml1L05vRE9RV0VrbVllbGRZS2t3UW5v?=
 =?utf-8?B?Q0ZLWUFzN2kydjROblhYYnp1RHNaNEFqOXFFeGFNOHJ3bnB2LzE3enFoTldL?=
 =?utf-8?B?cnoxU2pIVUttL2svK0NBK0tEaDloK2QvcmhDVFFMdFo2Q3ljeWEwWi9aaUo2?=
 =?utf-8?B?aVRnUTF3U0d0TVFDd3VSMndHMkVTL252VnM1bkV0UUg5eFpNUHhyc3orT0hU?=
 =?utf-8?B?K2lhNkoyNWl2LzFVd25EWUI1TGthM3pkS3RnRk9XQTJvVllVNkhkYkt5dzRW?=
 =?utf-8?B?S1BjYzdTa3ZjUHRxL2UzNHYxblVnQW9PYWMrY0tNRXJUcndScVJMWi8xZmRI?=
 =?utf-8?B?VlUrbHNXem1FNmJKMVUxS0xGa1Z0c0EzYkRoR1l4d211cVg5ZjRWS1RDUndI?=
 =?utf-8?B?NG80eWJjUWViUFYrS0tpVWRIZGNnUnk1Z2RXUWZENkpERmFkYkV1dVRHakUx?=
 =?utf-8?B?K3VYOEh0MHRFMzZvdFdUSzJrNG9QNUV3YjdsKzZCNm1wWWVNKzNuK0xzTE9z?=
 =?utf-8?B?a3kyKzd4ZURkc3BuVTdLZWgvUmJ5d0phUG01OTUxMUd3NFd1aGZmb0JuV240?=
 =?utf-8?B?ZnMrQWpucDJnTk9QcXpPeWRxcDRWcFhCenBwNFQ3NWN4a0pTQUJXNTI4aUxB?=
 =?utf-8?B?Rnd6NmRFUVpNREVqdzVQSmg0Tkk2RkQyQUR3emx4WWVieHFlZzZ3WGVHMnlX?=
 =?utf-8?B?NmdyU0pYMCt6eERqNitpcUV0Vk0rY2NGOHFNbTlvQ0hzVXBYRVB4WGRZVkVM?=
 =?utf-8?B?S3JILzhOTHp1dkVWNTVsdy9WZk5SYXdmWUdSRnZldEFZUS9FS0x5TWRVRng5?=
 =?utf-8?B?Vi80VFY4RHNxYkg4dUozaGkvdWVpeXpQTmhGOTVpQm80dUtaSzM1dzdaRk15?=
 =?utf-8?B?Nys0dXZHV0UydHVpUFlLelJjYkg4QnlVNk54eGJXczE4dEVjTE94Q0xXdlJ2?=
 =?utf-8?B?Uk5YayswR3A2MVI5QlhURjF6MmhCK0kxclJOdWFSZWYwZGYyejhCb0o3Mmdi?=
 =?utf-8?B?TkNwSmpzN3RrcFBGWGE3bGNXU3ROS1BsMHNvcEozWGk2azlmaWF3VkYzbjQ2?=
 =?utf-8?B?cjZ0dnRsMm9wT1c2ODIveWZVZjFXdWRoYnU4UWF4bG9OTjhUUUxlMnlOZ3l3?=
 =?utf-8?B?Z2RHempsamRoQnZZaHhycS9VL1hvVHA0RzRJRjlMUGlDTmU3YUlEaHYwZG9l?=
 =?utf-8?B?U29sVERVSGJBQ3JPTHNna3BNMDNaRGRhWkRNNEQ2VFZ2YzQvYzE1TCtndEdO?=
 =?utf-8?B?VXE5dWpPZXA5ZmIxZlFxOFhqUkRNbmlGcmNrOUlUWTFWRWlzajVLUU9lWGtq?=
 =?utf-8?B?dE53RlB3ekRiUjFhT2FxdU9FS2VTZUlQRHZRdzR3ZXB2aEFCVzZaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc0c58d-1f6c-4911-8cd9-08de7b470923
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 06:10:16.0599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/dESTHMi4ChcRhClh0xUjqPzhmGeilUIrYMc55KLXjhN55mssC2lSlt2wo7NTPGEsw8LcBjx/mSv5+c7QLr+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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



On 3/5/2026 11:07 PM, Lazar, Lijo wrote:
> 
> 
> On 06-Mar-26 3:35 AM, Mario Limonciello wrote:
>> I found more case that a NULL version causes problems.
>> Add NULL checks as applicable.
>>
>> Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in 
>> powergated state in some paths")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_device.c
>> index bc6f714e8763a..74cbe58484fe2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3463,6 +3463,9 @@ static void amdgpu_ip_block_hw_fini(struct 
>> amdgpu_ip_block *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>       int r;
>> +    if (!ip_block->version)
>> +        return;
>> +
> 
> ip block versions are set during discovery phase itself. This is a very 
> early init failure 

Yes; this case is NPI system that not all blocks are in discovery yet. 
System panics at bootup with NULL ptr deref in multiple places instead 
of a clean recovery and keep fbdev.  This patch series sorts it out.

> and ideally the fix should be not to call any fini 
> for such an early failure.

As an alternative to this series?

> 
> Thanks,
> Lijo
> 
>>       if (!ip_block->version->funcs->hw_fini) {
>>           dev_err(adev->dev, "hw_fini of IP block <%s> not defined\n",
>>               ip_block->version->funcs->name);
>> @@ -3496,6 +3499,8 @@ static void amdgpu_device_smu_fini_early(struct 
>> amdgpu_device *adev)
>>       for (i = 0; i < adev->num_ip_blocks; i++) {
>>           if (!adev->ip_blocks[i].status.hw)
>>               continue;
>> +        if (!adev->ip_blocks[i].version)
>> +            continue;
>>           if (adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_SMC) {
>>               amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
>>               break;
> 

