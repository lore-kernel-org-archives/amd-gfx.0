Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C93C47073
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 17:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374A610E253;
	Mon,  8 Jan 2024 17:17:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E01710E253
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 17:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC4R+5Py3mlWOiIuog+x4T4yKiIIgRLS5PffIjlSAL9pKJqRZDlOsfsmoO+0LIX33n0q8ASuwnomr2fpRPXxi3VOlcZHnIQTcN5EH5S02SpZPR5Rf7NTofb5kbtftsyp+WJHiIHEtziNWk8Dfjwu87bc/5FRCxJ+1mOQuNdwvGMQtjna7uNPb+PFn0ybgYfeFTgljTvu7Y6Y0dZG7uxK0FVRlzh8FaczZpzSc4ivEA8gRbmetHZymkuSiFJyN6MVVKOt6GcTKvartK6o5ESwmgwAVsa7TYI1oz7qvrj6LkzGHLSANNyUknEmhyi8R4r9wSA1lxf1GKFNknLqe4Bw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Id9wCfltf8TXZwkSWfDikBHz+PH9igLbNHndHwuAEk=;
 b=iY9iXiEyCc+9Lip3lA7wkGtsWSkALP+A6BE0ESL0P++e/bTwKpyIW+ZAX0+4qPOXNuXZ9bxcF5vWzGeUPffvoz5DjuF54qGFN0a1JwXlf8JO8BVOomafyA6Lm/3xu8MsKZrh0Q3V6MFQPk1Aya/IQKm1tHAXgLMDYQrDEJKesYQWo0GifuozzCcC/D4mpzrm+AqiX+jRYAwaUJDUR8axBuuI3K9PalpTUKgdDVU90SiLD1LMqStFOdPlcgXEzuvbEpAY+RXnPdr+mpMmQLNgcA0CaEyxsfjd8WtSigKAxicnUReHYChwvl++LAFCbH6Klv+WIB7pQ04Tjxnhl90/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Id9wCfltf8TXZwkSWfDikBHz+PH9igLbNHndHwuAEk=;
 b=I30W238mAg4leOVdUyEFf7UazHRM0K+8b8FSP2iaFphZ8lHR/dxTZ5OWf1ltBUyNCXfK3zVW5tErwFv/+MDLKlbOn8J1sOnC/nrdjqXRnzlESi2L2Gq5obytJt23fSI0go0wmw7N+f2ahHOasrJpss7PSVW3xuRwUaGE9OhOlG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 17:17:05 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:17:05 +0000
Message-ID: <42d2a3f0-f9db-4de5-97e1-e1dd937a3ec4@amd.com>
Date: Mon, 8 Jan 2024 12:17:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: make a correction on comment
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240102205653.909619-1-James.Zhu@amd.com>
 <101cb9a1-f867-4ef5-9d03-d9419f0cd105@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <101cb9a1-f867-4ef5-9d03-d9419f0cd105@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::18) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: e97c46d4-c373-4bc0-d2c1-08dc106da2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WyBrRP3EvQvwnkL4c+A7HjkDDvnHr2pZhJ+oy9lMuRqh5r3/x23FmFzXua9+8I62UUGBUnOhsqvqXt5mLk8Z70fl1b9CtzGok4DqvwEU5yJnKsp6mQCokmrV2AIJidF2TeLODMzJCJF5VWJafT4vFmyDQ4Xq/RnIsMXxvgvy0S92Ynua6FcNehwceKN1sbd9BppsSfJhDZEwZiLLA7ur2yklSsx6ipXTrHFsdQ0QjH8FZ3U0RUmETKEarUOUFGhQYpypyMS+xo0jiOTAN+A49G7uN4huLX3Ybx7ul+cN7RBUMXzk9j4BLIG4LIasqzkBkx2mu7MWxJWfnJ5LVVf2+wz62XT/jR+mcMvuwBpFSGJtGyBL9FlQRt1lCne76N/TyA/3UyIjOy7zw8y58st0ag/qbr1284gHDVqe4Hz0UXIZ74SBpaoZ8PsJGxLKhb3BcapMuK9slaJ9M0vnf8LaUXqUoYaWWXOMJ+xD/8IeN7gGa4AggYABa9y05EaqG6EUEQydtsdBsEBExhK5N+CXDK29OabjEutY5lRXsTlHkUhrocjxMn/DSN7KkKkdhuCtPJgcYsU6eLD2jaz1r92eVzmKvkIo7GSmImTL3YxSBaTp3zfc1026RTDvh740JlbZl/3Bfndde31LDlUFIC6DmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(6666004)(478600001)(38100700002)(83380400001)(6512007)(6506007)(26005)(53546011)(2616005)(36916002)(8676002)(8936002)(110136005)(316002)(5660300002)(2906002)(31696002)(36756003)(66556008)(66476007)(66946007)(66574015)(41300700001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2pFVm5ZQVJUKzl5a04wVVNvdXhsdjlqaEVESjV4U2xtN09NaEhQWG9OcjFh?=
 =?utf-8?B?SUVtMjRGanNielhuNm1sdlBLMnRobnpvaXN1a3dNNzN6MUt2dkowSTVaUitm?=
 =?utf-8?B?RDVVbUVQL29aU2lVZ1dtRVRlTjN0Q0pLRCtPcTNvK3BWZlhxU3NqcEFkWWVk?=
 =?utf-8?B?N2J2MGhZVEJPTEpUT1JoeG5ScmpwdzNVU2U1c2RqRjVKZWhoV1ZBdkVuMEFO?=
 =?utf-8?B?Y3liUjk0dEI4WnJadTJONFJUVDBUYVlxT05PYTYxZVlPaFhObVV6YVgyYzZV?=
 =?utf-8?B?SWlsZndlRGExVEFaQmx5c3VGcDJGRkorSkorbVFlUzRzd0NRVzVSQTJNVzQ1?=
 =?utf-8?B?c2NyaGV2WTkxQmJGYUN6ZXF6UjVyWS9sdUgrcTlnSmROSDRDRFRvUjFCMjUv?=
 =?utf-8?B?TGxBR0NOYnZOemVjbXFSVUdxdTM0blZldTNibFl3SW9yMDloVUFIRXYyRXg1?=
 =?utf-8?B?ZkZyK2Q1U3N0RHFJTW0zZmtkUFhVaGJYUnNIK3dkaVNxNDZSclREblRzWFhv?=
 =?utf-8?B?U01SMi9ERXd6V3kvaUplSnNhLzJONk9LUHRGN1R2ZHErZ0txVlV3K2ozWkU3?=
 =?utf-8?B?RVlOdGM0Z1MzSTBYclVYb0JpUmF5UVpaTFp1eHYrY2JqMGxZbG9PeFJ6cDAv?=
 =?utf-8?B?eUVZU2tSZUZ2YzlXd3BRWHpuRFM3c0xleHM0TTVXUkJkV0QzMHJhalJueUNa?=
 =?utf-8?B?ZDJDbU5rUjJEZ0ZjR0NHWXJLaU9oVUMzbGxKWFZJV2hCQllHL21JYTZXR01U?=
 =?utf-8?B?WXEzeVNPUWxSRnhHZVdMMXZVSGRyMDBPTG0vaVZHeFRLY0pBT2lGZDY2TmlK?=
 =?utf-8?B?cFZkK3pUdW42SVJFZTF6ZlZXbjdtcjRXMG4rN3ZWaVh6M3FyQ20vRmFlalcy?=
 =?utf-8?B?alcvWU1BVHljbktraEpqbVppYjAvY1RWaGhGRzNQSlhIRjFrdS9oWEdXUEJ4?=
 =?utf-8?B?SGtaUzdweHBQelByaktMU09ZZVhoRTJtT3BBSkdjZU1QQUFCQU5VWmRqVGZP?=
 =?utf-8?B?L3o4RkpOQ09lTVhqMWFEcVg4VXd2Uy8va25kSmhTaFlRd3NNelArZkduSU05?=
 =?utf-8?B?VWFKeUl3bTJ4UlZ2SVZXN1RCUi80aE9UMjdFNWxQc3g1aSs3M1Zac1cwNEx2?=
 =?utf-8?B?SElmUlp5dVUycnN5UWUvU2VBMEdKcXJHejlObFdBc3hzdnV1Wi9OeXFaWVY2?=
 =?utf-8?B?eklPSWtrc2FPL0pDbTFIdGkrUmNFellIcmI2RzZ4S0hBampPVEs3TG1yZHpX?=
 =?utf-8?B?dmFVaDZzSVZkVDVJcVp2bWIwQU5yYlFnenhTUDlzN0tHemlBTXFPTnN4UVZ0?=
 =?utf-8?B?dEZ6RGd2Tk1WeHlFQ0NWQkFaWS9laWRGVjg4OUVEdWdsdS9DaW9yb1Z6dmF3?=
 =?utf-8?B?YkdiR1N4QWlkV0gydmpZaUtZOW40MTJnUFcxYXpYWUt5SDdjS0hMVTkxeFc1?=
 =?utf-8?B?STI5Zm8zWHM2TnBsenpiRGhoSzdpNEpsY3VGZlBjYmhoNW91MWRNOEJtMFNV?=
 =?utf-8?B?LzJqYXZ0ZCtxY3BselBKWHg5RE1KWXJFMXRMczRnK2tpdHN2Zlg0TGs3b2sy?=
 =?utf-8?B?bmRwQUVOTXlJcndWS1d4R3F5amMwS3FtUGxjQ1k5eDM4bFR5K0RGM2VmNjI2?=
 =?utf-8?B?alZTa3YzYkpkdzBPYm9YV2Q4K3BXcGQ4emxUNjFYVkh0SnN2QlJXbURTT1dn?=
 =?utf-8?B?QkJjWEgxY3BLZlIydWZ0R2pnOTlNVytyb2xXOGt6Mk5Bc2swMGVQTzZ1UG5H?=
 =?utf-8?B?R0dvdWIxVUU3NXFJZ2oyWDN1TndKb0JVYVNzMUVMbnNrYnk1VC9qalBNM3gy?=
 =?utf-8?B?NmlJS1NtWFlBb013b3dMSWRJc3hKYVUxb2ZkOWIrVVpPb3BZaTc4bEw2cUpR?=
 =?utf-8?B?RDBDb0lDQ3BkbXRrNUdHbWYwcmd3TlZtWW9nazlwbnA1Vy91ZnMwdjdDbFli?=
 =?utf-8?B?WTF1MDhFSitKbWxwZGcxQzUxbnZTbWtOWFJFVFZBcTVyL2xnSG5KUktjYllI?=
 =?utf-8?B?QkIzWmZYcXJ4SStoR2NQd0oxWGpnZlNlWXlPRTlTb0pYMUk5aS9tdUpRQmtC?=
 =?utf-8?B?N2k5cnZ1ZWlpQWdyb29yblgrRzhTYUQvOVBGYXlGdFRKY3ZUcGczekxtUURQ?=
 =?utf-8?Q?cwJM09Sa2VV+WlYZ9+bLFnG7+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97c46d4-c373-4bc0-d2c1-08dc106da2d5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:17:05.1188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgWrCUZBNzt9e97dqzjVmmXTL6xSsO+7FV7nvEfEHNaNfmF9hAhlyhQTWm6PwbjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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


On 2024-01-08 03:12, Christian König wrote:
> Am 02.01.24 um 21:56 schrieb James Zhu:
>> Current AMDGPU_VM_RESERVED_VRAM is updated to 8M.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>
> Maybe remove the value completely from the comment, just something 
> like "How much memory be reserved for page tables".
[JZ] This will work better. Thanks!
>
> Either way Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index b6cd565562ad..b788067b9158 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -116,7 +116,7 @@ struct amdgpu_mem_stats;
>>   #define AMDGPU_VM_FAULT_STOP_FIRST    1
>>   #define AMDGPU_VM_FAULT_STOP_ALWAYS    2
>>   -/* Reserve 4MB VRAM for page tables */
>> +/* Reserve 8MB VRAM for page tables */
>>   #define AMDGPU_VM_RESERVED_VRAM        (8ULL << 20)
>>     /*
>
