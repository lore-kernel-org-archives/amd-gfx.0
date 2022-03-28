Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA48C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1495510EB69;
	Mon, 28 Mar 2022 13:37:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1FD10EB69
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:37:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFf707yLZxMbomFA8x3nPC6v1QUHmEsFgugGKfaha471rtGC5Of++7a+g/U2laQyP50EX6tzbT++AIynaubjvWWcQK9YgZdWoA46V5nJDIkjH2Bnyf0jyWU6N/BsjUJZGttH4oogi4fCtSdK49LwA7m/S0GQ56mX9O+bRkOcX7YF03X2hKGmT/OtfiokSxfHJAFtFuSFSXPwz09UtQ26HNxFE2w733nYCwCXKGfsNNg9pLos3JC6OLYrsw49xwLJYFTyPS1Cq7jdtUS4TcldS1O7CXqAM7HVtC1uaKHEaVfCwmsoHc0F5jmAxuHC87C5Hexw8O+p2TnYaNIVhG2uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c+oSswuxansY8XkgsIpGkqk9++mgfEAjVUYVtoJN3I=;
 b=a5IvsOl65isn7uiW/UWe6smxsRLwE5oC0hR2sY2VYxASgtvjDAD89oXz1q6UCdnJ+x3KeV1pCXQqIdAKv8n7HlmMFndv3iMNqLpaUquV0mGNFglK1X7hqJ2WLrIs7KhMulAxyLpRleGxdc7GVsORk+FRvjScXhc/M1uCzDarl65tj0QCw2Evamn5FWIn6jNCGwrDbki2npDclkcY8ozTNlvqqoykQAdXBS+RxBbrhdvkK9KN1JCimKHDzdeCRkn7XUI0aPBG+Zo9mMtiK1oQZS8D78k2BT4ExehOBZ5+1Z+VRtyA57NO2Iwn5xrTSdPW80PdMcvGna7bXEnwI/bN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c+oSswuxansY8XkgsIpGkqk9++mgfEAjVUYVtoJN3I=;
 b=qOxljbBESPRkPce/qcEzFqw4SIwiI1odgMFBhXZ62tMME7PghSuhNAk6AsfQm/HdF+dbhcT2ORn352BHD6iukGRwjUxUzSGnJn99kf22+3I71piH322WTshEhuQwypogEtoXanDmGBkSUyUyJseYRVTZN4KuIp+tBOWSAZ81y0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3888.namprd12.prod.outlook.com (2603:10b6:208:162::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 13:37:20 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:37:20 +0000
Message-ID: <067df409-be88-193d-6dc9-dcfaea75fe9c@amd.com>
Date: Mon, 28 Mar 2022 15:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Correct unlocked update fence handling
Content-Language: en-US
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220328130700.29642-1-Philip.Yang@amd.com>
 <9d0cc505-0e31-12b9-6d3e-4cd1d4c54646@amd.com>
 <ff4bd255-1c0e-0a88-d23c-8d372f7a3e78@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <ff4bd255-1c0e-0a88-d23c-8d372f7a3e78@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR08CA0029.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f550537c-2bc6-4289-70f6-08da10c014fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3888:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB388854446E2E7F637BD9BC58831D9@MN2PR12MB3888.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMOM+M2FUkwTGOjDZrAGUo6fc6fjF2Tri5BweOo6JsiecgKY7tgl9/G24uDr/mmQWQft4He5gcLnersDU1zZVcPBWetyY/pXGmYumXAbRbU6eZcLoagkLHtMHpeQAupTYkqln0UAtDUd05/HgQ0h0YsVBMDRAmXyoKianfbfYs2xh35dYNCOl2Hs0aiHJiHTmr2nbw95HVzxWsLRAP02UWQz9TqHS2kpiJ2Szk7xO6PLfxtLYoT+FZwSIsB0Dn+WggJSqk6//YqdSbZQoA8pQNwR60AiJ/6g3g09ZTMp6XCEwFjRLVjxaGeHZDrH1TpkBYYs7e7q06rlgQLvnYJ3k/HZVXqbsVffiLg1X6BZUNIrYOJbGOypZb0FYV9spTgUlX/+aPuPAweGApdSpw/HgJcTgjMLiPlEUByQ13mYL4zWRSH2nRT6lotFbkxBgnsCPunn08T/5mlMu70nObfeb4Laa20Z4nQHdNyZFNYima1LQr0zFB7WcWIeYhT4Q3h4Ss+qpCsDNVrA3CDikLqB3dQDHWFZgFL5FtNpal2r4mfkEOEGp8dlr5x63iGQ88ViEJ1SrsNOcf9Hxgy9Is1MvDYSScZLZ584Nm9/a/Hs2TuxCYR6vjwMnF44txUVXB6uJphBK93RVEDKcha+k+Nq5t3jHOoR65LfgBMuXRhWrIlBQISnery9nIk5huK3+OzqKQ9UvtBGtNjWKJyKDodza19Jux5grbItJ7lTyEcjNlSkOq9Q6zfSDJAfbtTTc7vS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(6506007)(2906002)(8936002)(5660300002)(508600001)(31696002)(316002)(53546011)(6486002)(66946007)(66556008)(66476007)(110136005)(8676002)(4326008)(186003)(15650500001)(83380400001)(6666004)(2616005)(31686004)(66574015)(6512007)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVCMG5hdVQwQXUrN0ZzS3hXVEoxQkNnbTVVS2dCS0grR0pvRW1BUUtjSTZ5?=
 =?utf-8?B?ay9XcDFtNE5UdnN2Z0dlWGNNb08rTm5HbStvNmFJd3krUXJ4Y1lkclZkdHYz?=
 =?utf-8?B?RDg0dVRjWlRlMTlUbUxlTjFpa0h5L3ZsOXlja1R0S1NBcU8yR016NkJxK2ZX?=
 =?utf-8?B?eUtqV3QyWXo1cGltWXUyVmRJYm9pdUxpVmVMN3hDVDZGb0NMYVdacGFKenFJ?=
 =?utf-8?B?cDZWWURzUHZLRkdnZFUrVTBIT3dEZUp3bWYvNmErUmdNZzlmSnR3UHJycFkv?=
 =?utf-8?B?ajZtdTBkZzNrNDN3Nk9EQncrYWlRY2lLekN3YTFpMzluOEJ3QVdDSzdXdFlj?=
 =?utf-8?B?SWh0czhjVG9aODRrNmZZcWk3NVhGRDc2WFBqRXdkVEtNTHU4eGVFaVRjM2c5?=
 =?utf-8?B?N3dxaFZlaVh5V05XRkVoSmhUcWEwRzgraGE0MkY1a3VqTlROZzU0ZEg4RHI0?=
 =?utf-8?B?U1lMenNRV1VHbURFYk5SZnhUUDc4QXB4UGkxRlhlYjBHTDJnTHp0WmlrYnA2?=
 =?utf-8?B?c3N6OUxMWXYraXBEVE9Ocy9qQS9XazZGN3k4QTRzVlowaWM1Q25Vek9pM00z?=
 =?utf-8?B?aFNCYm5VS1FkeGwvQ0NWRzFQS0drei8rQkwyL3AvT3ZCWXBkS3RUNkdJd084?=
 =?utf-8?B?ODliUU1PM3FpK0tqM2labXQ5WGZnSUNaT1d6TjF0Mmw3RGhxWXUzNlpYWXlv?=
 =?utf-8?B?VHkvMkhEWmJ6TWkrWDF1Mk1JdWdzV2N3NE80Q1pXQWN2SmE5S04vakM4VVdT?=
 =?utf-8?B?dTF1ZUpuZUxHZndxY0hwcDJaUmtlS2gzUDVmRE9ZNGlZUElTU01ERVgvNmVJ?=
 =?utf-8?B?aU81dm5Ub3ZiaHN6UHo0VEJzMTNwbkY2Nm1UV2NwZjdwcFkzUmMxYUlLOFFJ?=
 =?utf-8?B?WjNrczdJREtmODhMOW9BclcrMFBPR0R6TnBQUVVZdFRnN0VobFhHM1I0MnIw?=
 =?utf-8?B?WVR2aHhsY1pKNUQzelFmM243K3dZc0JPbEpob0gxVC9ISjlib0U1RjZ6OUVm?=
 =?utf-8?B?aFViRURxZHhSZ1BKV3Z1WlVlRUlONEVrdGcvWTN3SDVDSnJ5NzMydXRXaStl?=
 =?utf-8?B?MWp5QTJxd2tkMG45T285YlZpaWpiQXpyOExXeE1PQVFNTDZaUFpIY3F3aFlZ?=
 =?utf-8?B?ZlVPcURmR2lPSFlOR0d0Qm5mL3lOeHFISTJmQ2ZYczVXcjl0dUNQcnhPU2hW?=
 =?utf-8?B?bW1TV3Z0ZjdyKzdoZjJyWTdiNWwyM2hvR0JIRy9oeDdLSVYveGtJT3lxN3FN?=
 =?utf-8?B?T3QvN0lySlVVQmhTWmRsaXVCVzZtZVRWZk5pNnJZWXVRaklIQzBRK0ZNMHNo?=
 =?utf-8?B?dG5KK3VabVo4aDZRYlBCVmRmTWdzTkRsU3pXOTNjMUFxcGZUL0l6Z3Q5dkJl?=
 =?utf-8?B?OFNLODBRZ1UzbXdBanczWXY0cm9JSVR2aWhXT0tia0pwOVJFTHpIcER4VkJk?=
 =?utf-8?B?cTNHdmk1N1U4bmVWR3JCK3U2U28wUFE2ak1zTlpIR3Z5MTVSTDBkeGlaRE9u?=
 =?utf-8?B?UmtyWFpueEdTSGQ1MkxyOWZxcmQ2SjFwbjJXZ2UwTXhnR1R4R3JLYVpwOGlE?=
 =?utf-8?B?VFgxTm5HMUtDNkx0WjhLd2V0bVB5aitwNUMwaWd5NGoydGlHbmFuOTd3ZHBz?=
 =?utf-8?B?dTQxdE1FSno3TUNFOEhLQWR1WWFvQ0IwWi9QZ3hVWHBVZGJiTURRKzc5UzR6?=
 =?utf-8?B?L3pXZ1d0MVQ2Qlk4WVFpVmF3Y1lJaVQxWlRhem1IMTNJeFN1RzZYejVsdXlz?=
 =?utf-8?B?QlFnWlBxTVpSWVJhS2xtMnp6Znk4c2ZMV0lBTE55Sk1NcGVwdUdycmJ2SHVn?=
 =?utf-8?B?OUZSYzVkUVlKMTNFT0x1akF1azRxTWRvUWdZaUdOZUhoZWs2S09rS0tuRFZh?=
 =?utf-8?B?SDVBOFNHeHVhL1BESXZsd1JidnpWMmloRTlMV254aGZSRkxnMFMwSjhybkFB?=
 =?utf-8?B?UUtwMHFGY1NOcW9PSjY2UmJEL0NuekgwK0plazVYeWVmS1FESmh4aTZ0Zktv?=
 =?utf-8?B?YmRqT3pyMGd5RTJSeW9oWXJ6cUdVK0tvWUNYQ1p1TmIweU8vMUxCbGEreUs1?=
 =?utf-8?B?RXpLTDQ3ZWg0R08xSmhTcVlQTHlxSytUSE8zQzZoRis5SUxCMjAxMVFLaUtw?=
 =?utf-8?B?UFAvNC9nTWhsYWd3UnF5UktnVTAza1g1b1ByTmdiRTFOSzdORyt2eVZUdHIv?=
 =?utf-8?B?bWRLUUw5Q0U3dXh0Z0VOcHNTcUVRSldRUTdRNzJXSStnSUZLd3JsR2FqUVNJ?=
 =?utf-8?B?UGw2KzFRRGRRT2RGbnFmNXdrdHl4MnJzazh0c0F4Tm1QMFlVVHJuaFh4blRq?=
 =?utf-8?B?MWY2NTh2cFlFK05JQVZ0Zi9IVlB4Q0FtaFYrK2xWeEdHSXpaa09tTTRuaFo5?=
 =?utf-8?Q?8HLEQOW111Zt2pgjiU6TXx9XzePonvZBoJsPmrPjLn94s?=
X-MS-Exchange-AntiSpam-MessageData-1: KAgtal4ZloC3Jw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f550537c-2bc6-4289-70f6-08da10c014fd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:37:20.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vziv4jI076NGOtXYZqAnMvMzNExlTPZSmAGXuo0xEZFAe4ON7YMCRpuEdngNY80k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3888
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.03.22 um 15:35 schrieb philip yang:
>
>
> On 2022-03-28 9:14 a.m., Christian König wrote:
>> Am 28.03.22 um 15:06 schrieb Philip Yang:
>>> To fix two issues with unlocked update fence:
>>>
>>> 1. vm->last_unlocked store the latest fence without taking refcount.
>>> 2. amdgpu_vm_bo_update_mapping returns old fence, not the latest fence.
>>
>> NAK, that code here is perfectly correct.
>>
>> vm->last_unlocked gets a reference to the last unlocked operation.
>>
>> Otherwise the last locked operation is added directly to the root 
>> resv object.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> index dbb551762805..69fba68ff88e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> @@ -109,7 +109,7 @@ static int amdgpu_vm_sdma_commit(struct 
>>> amdgpu_vm_update_params *p,
>>>       if (p->unlocked) {
>>>           struct dma_fence *tmp = dma_fence_get(f);
>>>   -        swap(p->vm->last_unlocked, f);
>>> +        swap(p->vm->last_unlocked, tmp);
>
>           dma_fence_put(tmp);
>
> tmp is the new unlock fence, so this drop the new fence refcount, fix 
> is to move the old fence to tmp, drop the old fence refcount, take the 
> new fence reference.
>
> f is return fence, because f swap to old fence, so old fence is 
> returned, not new fence, fix will not change f.
>

No, swap() will exchange the parameters a and b.

So tmp is pointing to the old fence when dma_fence_put() is called on it.

That reference counting is correct as far as I can see.

Regards,
Christian.

> Regards,
>
> Philip
>
>>>       } else {
>>>           amdgpu_bo_fence(p->vm->root.bo, f, true);
>>

