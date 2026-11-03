Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4CC606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CKQYgowT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AED10E3C2;
	Tue,  3 Nov 2026 22:32:56 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A20610E3C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 22:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6H5nQLt2VnAdWhWCx1wtQF+PWFdJG/e1S0PqGS2CD/vEN6PPhgWXZsFKCkxVJs2JGu7FG+181wgc9epaTbBmiDAJa6e5vL37HK1jfKLDGh3XmUxmRkLzcqAeYpO3d76NJWCFrdja6wuxgdt7Q0yupYbKVyKws5k4b0ESmRCPlEzkUCwwa/Zs7LkMY7Scj30dLozyXbLHf2avHIT9kG0LzOjgMfhe5/U6H/WELbvvwnft3zawJR+XUlt8Nff/DifhMWF9KAmjLERRzpJ1N1p3JPeXZxRoPbX+0WnDC+qtjNNPU7BOH11ckGHNchlp+DYL0OsP76ArkylGMJkz3tXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFH4xwCJ00hxwFp2IDx3l5oGLNzs96Oj5WXPDc7ax0I=;
 b=zICCM9ywzJCNWjqPVD7r1yl65F2uwSGbN/TuIYjLL5sY+o/Z9VfqcCyLnmc63LwvatqMyMn1tk/plaEbhtt35Z0zWXlXI/mIbVsFlzRax8aAE5HF5eRT4bJSW0maMNLw+6EDqQ/MJtXnTQ0cgF36Fybl8pa8cnyghuK3Ty5NK6F3HdvorrLtF1WnjKjcPOkZK4h+7ofiE7IkPOa67ML+7x9KHV294zcFC81ysCGaPemZtEk3ID3PMN6XNtEJYGJqyDV+0e0Se9alkt3hfY9wpAkrGQ83/I3q+3ijOMUlcSFGILTgNPmjn558SR8yN1rpI6Jm6KYC7fNCfb4wjaiVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFH4xwCJ00hxwFp2IDx3l5oGLNzs96Oj5WXPDc7ax0I=;
 b=CKQYgowTWbFFOM6HmgRqAGUHvWX6nEQaZgpfA8CWm0kYzMEz9bYdjtri2e1Q+v6tpevvONckcdTzdEknqXaz4WJNmMeNGcz/wE1mCNCi1QkVROleGjNfWYQr/8W05pcl2qmVDd2Ci3b9JlGKGuUg1ZFS1vVPtGUCsk1J0kDjWg0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB7725.namprd12.prod.outlook.com
 (2603:10b6:8:136::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 22:32:45 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 22:32:44 +0000
Content-Type: multipart/alternative;
 boundary="------------Hu9UIGw0tEOoBrQ20tTCb15H"
Message-ID: <ee723639-0783-42d3-812d-9df2987fe5f1@amd.com>
Date: Tue, 3 Nov 2026 17:32:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: Philip Yang <yangp@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-2-mukul.joshi@amd.com>
 <619d73b1-6dc9-4945-b711-db8c34f379f8@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <619d73b1-6dc9-4945-b711-db8c34f379f8@amd.com>
X-ClientProxiedBy: YT4PR01CA0338.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::9) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3d6934-10a7-4322-5ea3-08df39fa60cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|261102123227099003|3023799007|261102130727099003|8096899003|56012099006|5023799004|4143699003|261026121527099003|11063799006|261022105027099003|261021121427099003|261009223027099003|261028144727099003|261022075727099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: GTm8Co2TCuOttkag4dDrf19jRw+rtD10x+GC+YAxK89z/PyqhBEYf7TtICj8EWyx0hr5K1R+KQot/ZboohW+ZuFFo21/4ud+rxkaKlHDNPIIwUo5bwubnBZGzPEO1dhT+NbI6n1Eyc0PS8n4omtpMMuI4u4dyeSvlNfDw9QjvLTzDZvQLuKpSIcRv6R6NHolaFgHadAdIf8iCy9KaMLU3B6y4kfK2SL1FBJdLtHmk4vpt+koW117c9ok/6VavED+TlvpsSj5o3Ds4THcbbUmCJLGNZ6BTGOH8yhQ0S8Ostz/Om8p/lRDD8lvNa+xBWSH/mf44HoznuD1hQv9ui15kbXa0TtmCKgEFJjtbjn33gSnDO1zxkhxHTmz8xZ1WaCiMyDx3dlx9TGXr7uK5SoVPhK8NNTWWBE7l7UgAiNUguNI7lPcBb7UIbsYRJLUhJiAcLROBeLwhzM1v0HGA7r5/oK8FEBhgSighFFJU9w/8RORSpsQbPqwwIpg/6UfvAgF80c70kSP/n9yrw0W8uFxBTL0iieM+GziB/t9HLzCwQt3mzF1lmFg02ZFcr20qf4hModDfH6vCxN4dFiCN6zhWG/EcgrEDDTP1hoyaM/uppI6gYCKZC3erbuqghwEhi1uAfwEEe+hXYFBOrIghqhODkWvT7w6JsnRP9lMiwjvqD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(3023799007)(261102130727099003)(8096899003)(56012099006)(5023799004)(4143699003)(261026121527099003)(11063799006)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261022075727099003)(261021123027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE8wU3NhZWN1cHB1RzNxRDNDY3h6VXJtV0R1eGVha3V1dXFJNFVXcmJya05m?=
 =?utf-8?B?ejlzQ214YURybmIzd3Z1MEdQUjcyK3YxSm1CeDlUMTVsanU3N2Y3N0VKNCsx?=
 =?utf-8?B?MzRFMXVETlRxUWNqN3dFMzVnc0xOK0NyQjloeVlKZmJ6WTVZTW1rQklZdXFC?=
 =?utf-8?B?UGY2VVlkQVFUUWhJR1EyNkExQ3gxeHpwSE0yRmYzSzQ3Rzk2VjgyQ0daUEtx?=
 =?utf-8?B?d3V3UVZPRXJ4MldpTE1DUU5odEMzbU5ZVjI1WVpFZHc0YU1IaEV2TXZXOE5w?=
 =?utf-8?B?UjVzRXRHL0RvMmxSOCtMb1V4T3F6UnNreVJ4cUcyRWtHMFN0TnRGUWEveXY3?=
 =?utf-8?B?UzNkVEs2Q1dGc3ZhWkV5ZlRwMHVDQU9UUVlrcXZUeTVydHpFR1RtZjdLR3lW?=
 =?utf-8?B?bWtWV0xONytRLzUzV0tXRCszTnUwWStmWCs0dXZJVFlBSXFkVjdoR0JVeDRO?=
 =?utf-8?B?VThvSnEza1RTcDhxNFV5VGdtR3hVOFo1NEJXNytOWFJTUjR5bGVlN0s4cWNX?=
 =?utf-8?B?d2VhREZRdXpLRDZrRVQrM0VuSWJuNTh4QVJtN2F5bExXNHNEdmNIa2poOTNx?=
 =?utf-8?B?Skp6NmVtN0lKc1lJL0FMY0ltM2xEY2g4TUZqNFBNZFhITVhIV2owQkRmdkhK?=
 =?utf-8?B?eVJHTHFIVzE0c0Exa2M5RDRVazNVT1M2V1BQWDRBSkgveGR6cFB0ZXM5aTNO?=
 =?utf-8?B?V0UrQWozSWRaaHRGSUo5TDBNcGw5SlVLdTdaMXZZR244aUJUb2JodHhJTytB?=
 =?utf-8?B?QTZTZC9PTVdjcFI0bXBqbzRIeGt6TlZrL3JaME5rYjdaZUFGZk9uRVhIWm82?=
 =?utf-8?B?blR3RC9jWnhJRXZGOGhzUDBZVjRqZnhCRU1KeFlFQlUrb0tuWEcyV2RUZWdl?=
 =?utf-8?B?a29ZSDZQV0tKVUx1c3VsMUpQSXdtcmFyZTBtVUFOT1daYlJuNi80SlVrUWpJ?=
 =?utf-8?B?eHlka1R3UUxtaElGUUdHUmEwMkxxand0RVZDQVQ2OFoxSkp0SURRVGsrRWxB?=
 =?utf-8?B?U3JaamE3MjEvTHhSbzBnSktQaVEwcjh4L2lmZVMxNFIvWmhoTU9aemQxdlFr?=
 =?utf-8?B?ZmswWkExczRJeW9MR0E1ekRRWWZZTlBXeDc3U2NHQmtNZ24wa08rYnJmbmVE?=
 =?utf-8?B?Vit3ZHpsd0JvTWt0bTZ2c1pnSktGRUp3QUpRR2JUbTh0NmcybDV5RUxLUDZa?=
 =?utf-8?B?UTgySERHNjdqKzVhLzlSaGlKWWg0MUt0dmdkb0pmcGhzMmdWZHlNVDlGSVBi?=
 =?utf-8?B?VVR6bHZNN0dSVkpwM25hUlZycTQwVVRFS3VCQWh6S0drU2tYL2RFSWd4SWh5?=
 =?utf-8?B?bzBHYjBhSjNVR2VhbTc1bWRnWUczaXlLREtxV0lDSFN2c09kNlY3RGVQQ3NU?=
 =?utf-8?B?MkRBSEJaVjZGcnJSajlKVk9TdmtHYlArdDhpSE52eVcxanZ3Y3lPMkxlN2J0?=
 =?utf-8?B?U2s3RkQrYmJ0V3RYc1NEWlQ5MVBVSHdsTG9qQThacHRCRzVyVmkwc0N2ZUhZ?=
 =?utf-8?B?SktyY2d1V1RaYk11NXFMVm03UlE3QisrYWNUK2JIUzFjSGF4VmpUQXJ1c1FC?=
 =?utf-8?B?akpSN09ycmJOTmtidWtZRmRpcmY4UFBUc3RKV0UrTXRYUTh4UU5IRG9xeWkz?=
 =?utf-8?B?OW9KYk5EK0tvVVluSVV5MW1ybUNjYzduc0R5THpDK3FJcmx5YkZEWlNhYWRZ?=
 =?utf-8?B?Z0V6ZkszV2wxdzBsVUNiUVZ1c0tBdXRqK1d4ZHBOMFJIeVg0dVpNT2JhVDhn?=
 =?utf-8?B?RHdwcWFyZSs3SENHeng2TGJLQnNyWDZiUlkyUlBFRFpBMXJETG53ZVpia1p3?=
 =?utf-8?B?aHNPZVk1M2c5ajVVVjNkV2xDWWlOMDVjcHRPY2crV0U0bDVsRzU3RTFzNi9u?=
 =?utf-8?B?dE1LTnZwOFBwNGIxK213K3NoY0tTNW9Lem9WdWVIMWROVEsvbGJwbkx4ZHVT?=
 =?utf-8?B?QjJQR3NsdnZLd1RHa3B0ZUVrejJkK1diY3MxYUlpcjBQdmlZZUhIQkJLZFN0?=
 =?utf-8?B?MXl1dkdXWFQyOHlDdWd4UzRFNmNBbXdaZzdHMS9qTURtdHdoTVIzclFlcnRz?=
 =?utf-8?B?SHdJTkgrWm5NbnB5ajl5SWYvaXUyTWgxQURPUVlKSDlFZ2VsMFYzZmZmMUlt?=
 =?utf-8?B?L2xhR0RueVA5ZDlmM2EvdVNhVFRBQlVVZDV2LzczaW9NaFhHanYxSnR1TlNJ?=
 =?utf-8?B?ck0zcklPVjdUWUU4OW4wVmk3NUZmczVwdCtWMEZZV25IUGMyVXYxaFY4aHdv?=
 =?utf-8?B?UlFTSDFPL3FJV01IdXBONnllRUxXK1RhVCtyRHJVVFBDa2pRZUpzMVZlS3Qz?=
 =?utf-8?B?UHZ2b3BEK2pCWDNYR0thS3d6bTlUYzB2T015WGVWWmhqaTYyd0lVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3d6934-10a7-4322-5ea3-08df39fa60cb
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:32:44.0668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuWY4iXwrEzyTT8QWz37Rg9j5lqcxPKRN2SLGkFeDe+wi0hiXPtJvyeRwir/k+9XgX+wjtxvmq6WAfAgeIBSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------Hu9UIGw0tEOoBrQ20tTCb15H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-03 13:17, Philip Yang wrote:
>
>
> On 2026-11-02 10:47, Mukul Joshi wrote:
>> Add the infrastructure for UALink loopback mode, where a single GPU
>> plays both the exporter and the importer role under two fixed
>> accelerator IDs:
>>
>> - Add struct amdgpu_ualink_loopback to track the loopback state, along
>>    with the fixed exporter and importer accel IDs.
>>
>> - Replace ualink_accel_id() with ualink_exp_accel_id() and
>>    ualink_imp_accel_id(), which return the exporter and importer accel
>>    ID in loopback mode.
>>
>> - Add amdgpu_ualink_loopback_sw_init(), which allocates the ordered
>>    workqueue used to emulate exporter->importer messages from
>>    ualink_ip_sw_init(), and amdgpu_ualink_loopback_fini(), which
>>    destroys it from ualink_ip_sw_fini().
>>
>> Loopback is not enabled yet, and outside loopback both helpers return
>> ppod.accel_id, so there is no functional change.
>>
>> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
>> ---
>> v1->v2:
>> - Drop the change in find_peer_adev() as its not needed.
>>
>> v2->v3:
>> - Update src_accel_id to the correct value in amdgpu_ualink_peer_remote_init()
>>    and amdgpu_ualink_peer_remote_fini().
>> - Add the loopback teardown in amdgpu_ualink_loopback_fini() and call it
>>    through ualink_ip_sw_fini().
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 +++++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
>>   2 files changed, 133 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index ca6432610f71..a98d5bbf0622 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -89,6 +89,41 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * amdgpu_ualink_loopback_sw_init - allocate UALink loopback resources
>> + *
>> + * Allocates the ordered workqueue used to emulate exporter->importer
>> + * interrupts in SW. Does nothing unless loopback mode is enabled.
>> + */
>> +static int amdgpu_ualink_loopback_sw_init(struct amdgpu_device *adev)
>> +{
>> +	if (!adev->ualink.loopback.enabled)
>> +		return 0;
>> +
>> +	adev->ualink.loopback.wq =
>> +		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
>> +	if (!adev->ualink.loopback.wq)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * amdgpu_ualink_loopback_fini - tear down UALink loopback mode
>> + *
>> + * Destroys the workqueue allocated in amdgpu_ualink_loopback_sw_init().
>> + * destroy_workqueue() drains any pending self-interrupt work first.
>> + */
>> +static void amdgpu_ualink_loopback_fini(struct amdgpu_device *adev)
>> +{
>> +	if (!adev->ualink.loopback.wq)
>> +		return;
>> +
>> +	destroy_workqueue(adev->ualink.loopback.wq);
>> +	adev->ualink.loopback.wq = NULL;
>> +	adev->ualink.loopback.enabled = false;
>> +}
>> +
>>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>>   {
>>   	if (!adev->ualink.info)
>> @@ -1028,6 +1063,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
>>   	return NULL;
>>   }
>>   
>> +/*
>> + * Physical accelerator roles.
>> + *
>> + * Outside loopback a GPU owns a single accelerator, so both helpers return its
>> + * ppod.accel_id and the exporter/importer distinction collapses. In loopback
>> + * the one physical GPU plays both roles: the exporter owns the MP nHT and
>> + * receives all HW traffic, while the importer is the (virtual) HW sender for
>> + * the importer -> exporter path.
>> + */
>> +static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
>> +{
>> +	if (adev->ualink.loopback.enabled)
>> +		return adev->ualink.loopback.exporter_accel_id;
>> +
>> +	return adev->ualink.info->ppod.accel_id;
>> +}
>> +
> Replacing ualink_accel_id with ualink_exp_accel_id is misleading for 
> the non-loopback case, since each device is both an exporter and an 
> importer at the same time. I'd prefer to add the loopback-enabled 
> check inside ualink_accel_id() instead.

It's true that the same GPU acts as both exporter and importer. But in 
any particular code path it acts in only one of those roles. It needs to 
choose the correct accelerator ID depending on its role. I asked for 
making that explicit in the function name. That way at any call site 
it's easy to see which role a GPU plays in the particular context. This 
replaces lots of very similar open-coded conditions that were 
obfuscating the meaning. It also keeps loopback-specific conditions in 
fewer places in the code, making it easier to read and maintain going 
forward.

Regards,
   Felix


>
> It also looks like ualink_imp_accel_id is only used by 
> amdgpu_ualink_process_irq and amdgpu_ualink_remote_interrupt under the 
> loopback-enabled condition, so it could be removed as well. That would 
> simplify the patch and drop all the ualink_accel_id renames.
>
>> +static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
>> +{
>> +	if (adev->ualink.loopback.enabled)
>> +		return adev->ualink.loopback.importer_accel_id;
>> +
>> +	return adev->ualink.info->ppod.accel_id;
>> +}
>> +
>>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>>   					 u32 accel_id)
>>   {
>> @@ -1533,19 +1593,21 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
>>   	struct amdgpu_ualink_ppod_setup *ppod_setup;
>>   	struct amdgpu_device *adev = ip_block->adev;
>>   	struct amdgpu_ualink_info *info;
>> +	int r;
>>   
>>   	info = kzalloc(sizeof(*info), GFP_KERNEL);
>>   	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
>>   	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
>>   	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
>>   	if (!info || !ppod_setup || !vpod_config || !stations) {
>> -		kfree(info);
>> -		kfree(ppod_setup);
>> -		kfree(vpod_config);
>> -		kfree(stations);
>> -		return -ENOMEM;
>> +		r = -ENOMEM;
>> +		goto err_free;
>>   	}
>>   
>> +	r = amdgpu_ualink_loopback_sw_init(adev);
>> +	if (r)
>> +		goto err_free;
>> +
>>   	info->ppod.accel_id = 0xffffffff;
>>   	info->ppod.bandwidth = 0xffffffff;
>>   	info->ppod.latency = 0xffffffff;
>> @@ -1568,10 +1630,18 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
>>   	adev->ualink.stations = stations;
>>   
>>   	return 0;
>> +
>> +err_free:
>> +	kfree(info);
>> +	kfree(ppod_setup);
>> +	kfree(vpod_config);
>> +	kfree(stations);
>> +	return r;
>>   }
>>   
>>   int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
>>   {
>> +	amdgpu_ualink_loopback_fini(ip_block->adev);
>>   	amdgpu_ualink_object_fini(ip_block->adev);
>>   	return 0;
>>   }
>> @@ -4487,11 +4557,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
>>   			     AMDGPU_UALINK_ACCEL_MAX);
>>   }
>>   
>> -static inline u32 ualink_accel_id(struct amdgpu_device *adev)
>> -{
>> -	return adev->ualink.info->ppod.accel_id;
>> -}
>> -
>>   static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
>>   {
>>   	return adev->ualink.info->vpod.addr_mode;
>> @@ -4837,7 +4902,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>   {
>>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>>   	u64 timeout = msecs_to_jiffies(2000);
>> -	u32 dst_accel_id = ualink_accel_id(adev);
>> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>>   	struct amdgpu_bo *bos[2];
>>   	u32 n_bos;
>>   	struct dma_fence *fence;
>> @@ -4956,7 +5021,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>   static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
>>   {
>>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -	u32 dst_accel_id = ualink_accel_id(adev);
>> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>>   	u64 timeout = msecs_to_jiffies(2000);
>>   	struct amdgpu_bo *bos[2];
>>   	u32 n_bos;
>> @@ -5241,7 +5306,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
>>   {
>>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>>   
>> -	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
>> +	dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>>   	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>>   				      &remote->rptr_cpu_addr);
>>   	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
>> @@ -5288,7 +5353,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>   	}
>>   
>>   	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
>> -		ualink_accel_id(adev), ualink_addr_mode(adev), status);
>> +		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>>   
>>   	/* Alloc metadata structure for all GPUs */
>>   	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
>> @@ -5361,12 +5426,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>   	}
>>   
>>   	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
>> -		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_accel_id(adev);
>> +		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
>>   
>>   	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
>>   		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>>   
>> -		if (accel_id == ualink_accel_id(adev))
>> +		if (accel_id == ualink_exp_accel_id(adev))
>>   			continue;
>>   
>>   		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>> @@ -5392,7 +5457,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>   						     ualink_tlb_wptr_offset(adev, accel_id);
>>   
>>   		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
>> -			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
>> +			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
>>   		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>>   			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>>   		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
>> @@ -5806,7 +5871,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>>   				      u64 *wb_npa, u32 type)
>>   {
>>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -	u32 accel_id = ualink_accel_id(adev);
>> +	/* The GPUID encoded in the write-back NPA address is the routing target
>> +	 * the remote writes the rptr back to, i.e. THIS GPU. It must be the
>> +	 * physically-owned accel_id: outside loopback that is our own accel_id,
>> +	 * and in loopback it is the exporter (the only id the single GPU owns
>> +	 * and can receive on). The importer is only a logical source id for the
>> +	 * forward path and must never appear as an NPA GPUID.
>> +	 */
> Maybe move this into the patch comment.
>
> Regards,
> Philip
>> +	u32 accel_id = ualink_exp_accel_id(adev);
>>   	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>   	uintptr_t wb;
>>   	u64 npa;
>> @@ -5981,19 +6053,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>   						   &peer->shootdown, &tlb_wptr);
>>   	if (r) {
>>   		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
>> -			ualink_accel_id(adev), remote_accel_id, r);
>> +			ualink_exp_accel_id(adev), remote_accel_id, r);
>>   		return r;
>>   	}
>>   
>>   	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
>>   		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
>> -			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
>> +			ualink_exp_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
>>   		return 0;
>>   	}
>>   
>>   	dev_dbg(adev->dev,
>>   		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
>> -		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>> +		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>>   		remote_accel_id, int_wptr, tlb_wptr);
>>   
>>   	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>> @@ -6164,7 +6236,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>>   	struct amdgpu_ualink_peer *peer;
>>   	struct amdgpu_ualink_ring *interrupt;
>>   	struct amdgpu_ualink_ring *shootdown;
>> -	u32 src_accel_id = ualink_accel_id(adev);
>> +	/* This sets up the send rings (local sender -> each remote dst). In
>> +	 * loopback the HW-served direction is importer -> exporter, so the
>> +	 * local sender is the importer; the skip below then skips the importer
>> +	 * and sets up the peer[exporter] ring that the HW path needs.
>> +	 */
>> +	u32 src_accel_id = ualink_imp_accel_id(adev);
>     if (adev->ualink.loopback.enabled)
> src_accel_id= adev->ualink.loopback.importer_accel_id;
>>   	u32 dst_accel_id;
>>   	u64 npa, flags;
>>   	int r = 0;
>> @@ -6287,7 +6364,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>>   {
>>   	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>> -	u32 src_accel_id = ualink_accel_id(adev);
>> +	/* Mirror peer_remote_init: in loopback the local sender is the
>> +	 * importer, so unmap the peer[exporter] send ring that was set up.
>> +	 */
>> +	u32 src_accel_id = ualink_imp_accel_id(adev);
>>   	u32 dst_accel_id;
>>   	struct amdgpu_ualink_peer *peer;
>>   	struct amdgpu_ualink_ring *ring;
>> @@ -6374,7 +6454,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
>>    */
>>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>>   {
>> -	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
>> +	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_exp_accel_id(adev),
>>   		ualink_addr_mode(adev));
>>   
>>   	adev->ualink.msg_ctl->send_halt(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> index 85c9a9634a4b..0b1e8dd38666 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>> @@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
>>   #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN		0x1
>>   #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN		0x2
>>   
>> +/* UALink loopback support.
>> + *
>> + * In loopback mode a single GPU loops UALink requests back to itself for
>> + * manufacturing testing. The GPU exposes two fixed accelerator IDs: it acts
>> + * as the exporter on one and the importer on the other. Loopback is enabled
>> + * with the amdgpu.ualink_loopback module parameter.
>> + */
>> +/* Fixed accelerator IDs used by a loopback GPU. */
>> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID		1
>> +#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID		0
>> +
>>   enum amdgpu_ualink_conn_state {
>>   	AMDGPU_UALINK_CONN_NOT_READY			= 0,
>>   	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
>> @@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
>>   	int (*send_halt)(struct amdgpu_device *adev);
>>   };
>>   
>> +/* UALink loopback mode state.
>> + *
>> + * When @enabled is true this single GPU acts as both exporter
>> + * (@exporter_accel_id) and importer (@importer_accel_id). There is no second
>> + * physical GPU, so exporter->importer messages cannot be delivered by the
>> + * (single) MP nHT and are instead emulated in SW by feeding them back into
>> + * our own IRQ handler via @wq.
>> + */
>> +struct amdgpu_ualink_loopback {
>> +	bool enabled;
>> +	u32 exporter_accel_id;
>> +	u32 importer_accel_id;
>> +	struct workqueue_struct *wq;
>> +};
>> +
>>   struct amdgpu_ualink_mgr {
>>   	u64 npa_size;
>>   	u32 psp_if_ver;
>> @@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
>>   	/* For remote interrupt and shootdown */
>>   	struct amdgpu_ualink_remote *remote;
>>   
>> +	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
>> +	struct amdgpu_ualink_loopback loopback;
>> +
>>   	/* handle irq from ualink client of remote GPUs */
>>   	struct amdgpu_irq_src irq;
>>   
>
--------------Hu9UIGw0tEOoBrQ20tTCb15H
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-11-03 13:17, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:619d73b1-6dc9-4945-b711-db8c34f379f8@amd.com">
      
      <br>
      <br>
      <div class="moz-cite-prefix">On 2026-11-02 10:47, Mukul Joshi
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20261102160125.2743750-2-mukul.joshi@amd.com">
        <pre wrap="" class="moz-quote-pre">Add the infrastructure for UALink loopback mode, where a single GPU
plays both the exporter and the importer role under two fixed
accelerator IDs:

- Add struct amdgpu_ualink_loopback to track the loopback state, along
  with the fixed exporter and importer accel IDs.

- Replace ualink_accel_id() with ualink_exp_accel_id() and
  ualink_imp_accel_id(), which return the exporter and importer accel
  ID in loopback mode.

- Add amdgpu_ualink_loopback_sw_init(), which allocates the ordered
  workqueue used to emulate exporter-&gt;importer messages from
  ualink_ip_sw_init(), and amdgpu_ualink_loopback_fini(), which
  destroys it from ualink_ip_sw_fini().

Loopback is not enabled yet, and outside loopback both helpers return
ppod.accel_id, so there is no functional change.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com" moz-do-not-send="true">&lt;mukul.joshi@amd.com&gt;</a>
---
v1-&gt;v2:
- Drop the change in find_peer_adev() as its not needed.

v2-&gt;v3:
- Update src_accel_id to the correct value in amdgpu_ualink_peer_remote_init()
  and amdgpu_ualink_peer_remote_fini().
- Add the loopback teardown in amdgpu_ualink_loopback_fini() and call it
  through ualink_ip_sw_fini().

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
 2 files changed, 133 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ca6432610f71..a98d5bbf0622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -89,6 +89,41 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 	return 0;
 }
 
+/*
+ * amdgpu_ualink_loopback_sw_init - allocate UALink loopback resources
+ *
+ * Allocates the ordered workqueue used to emulate exporter-&gt;importer
+ * interrupts in SW. Does nothing unless loopback mode is enabled.
+ */
+static int amdgpu_ualink_loopback_sw_init(struct amdgpu_device *adev)
+{
+	if (!adev-&gt;ualink.loopback.enabled)
+		return 0;
+
+	adev-&gt;ualink.loopback.wq =
+		alloc_ordered_workqueue(&quot;amdgpu_ualink_loopback&quot;, 0);
+	if (!adev-&gt;ualink.loopback.wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * amdgpu_ualink_loopback_fini - tear down UALink loopback mode
+ *
+ * Destroys the workqueue allocated in amdgpu_ualink_loopback_sw_init().
+ * destroy_workqueue() drains any pending self-interrupt work first.
+ */
+static void amdgpu_ualink_loopback_fini(struct amdgpu_device *adev)
+{
+	if (!adev-&gt;ualink.loopback.wq)
+		return;
+
+	destroy_workqueue(adev-&gt;ualink.loopback.wq);
+	adev-&gt;ualink.loopback.wq = NULL;
+	adev-&gt;ualink.loopback.enabled = false;
+}
+
 static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
 {
 	if (!adev-&gt;ualink.info)
@@ -1028,6 +1063,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
 	return NULL;
 }
 
+/*
+ * Physical accelerator roles.
+ *
+ * Outside loopback a GPU owns a single accelerator, so both helpers return its
+ * ppod.accel_id and the exporter/importer distinction collapses. In loopback
+ * the one physical GPU plays both roles: the exporter owns the MP nHT and
+ * receives all HW traffic, while the importer is the (virtual) HW sender for
+ * the importer -&gt; exporter path.
+ */
+static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
+{
+	if (adev-&gt;ualink.loopback.enabled)
+		return adev-&gt;ualink.loopback.exporter_accel_id;
+
+	return adev-&gt;ualink.info-&gt;ppod.accel_id;
+}
+</pre>
      </blockquote>
      Replacing ualink_accel_id with ualink_exp_accel_id is misleading
      for the non-loopback case, since each device is both an exporter
      and an importer at the same time. I'd prefer to add the
      loopback-enabled check inside ualink_accel_id() instead.<br>
    </blockquote>
    <p>It's true that the same GPU acts as both exporter and importer.
      But in any particular code path it acts in only one of those
      roles. It needs to choose the correct accelerator ID depending on
      its role. I asked for making that explicit in the function name.
      That way at any call site it's easy to see which role a GPU plays
      in the particular context. This replaces lots of very similar
      open-coded conditions that were obfuscating the meaning. It also
      keeps loopback-specific conditions in fewer places in the code,
      making it easier to read and maintain going forward.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:619d73b1-6dc9-4945-b711-db8c34f379f8@amd.com"><br>
      It also looks like ualink_imp_accel_id is only used by
      amdgpu_ualink_process_irq and amdgpu_ualink_remote_interrupt under
      the loopback-enabled condition, so it could be removed as well.
      That would simplify the patch and drop all the ualink_accel_id
      renames.<br>
      <br>
      <blockquote type="cite" cite="mid:20261102160125.2743750-2-mukul.joshi@amd.com">
        <pre wrap="" class="moz-quote-pre">+static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
+{
+	if (adev-&gt;ualink.loopback.enabled)
+		return adev-&gt;ualink.loopback.importer_accel_id;
+
+	return adev-&gt;ualink.info-&gt;ppod.accel_id;
+}
+
 static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
 					 u32 accel_id)
 {
@@ -1533,19 +1593,21 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ualink_ppod_setup *ppod_setup;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	struct amdgpu_ualink_info *info;
+	int r;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
 	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
 	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
 	if (!info || !ppod_setup || !vpod_config || !stations) {
-		kfree(info);
-		kfree(ppod_setup);
-		kfree(vpod_config);
-		kfree(stations);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto err_free;
 	}
 
+	r = amdgpu_ualink_loopback_sw_init(adev);
+	if (r)
+		goto err_free;
+
 	info-&gt;ppod.accel_id = 0xffffffff;
 	info-&gt;ppod.bandwidth = 0xffffffff;
 	info-&gt;ppod.latency = 0xffffffff;
@@ -1568,10 +1630,18 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	adev-&gt;ualink.stations = stations;
 
 	return 0;
+
+err_free:
+	kfree(info);
+	kfree(ppod_setup);
+	kfree(vpod_config);
+	kfree(stations);
+	return r;
 }
 
 int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
 {
+	amdgpu_ualink_loopback_fini(ip_block-&gt;adev);
 	amdgpu_ualink_object_fini(ip_block-&gt;adev);
 	return 0;
 }
@@ -4487,11 +4557,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
 			     AMDGPU_UALINK_ACCEL_MAX);
 }
 
-static inline u32 ualink_accel_id(struct amdgpu_device *adev)
-{
-	return adev-&gt;ualink.info-&gt;ppod.accel_id;
-}
-
 static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
 {
 	return adev-&gt;ualink.info-&gt;vpod.addr_mode;
@@ -4837,7 +4902,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	u64 timeout = msecs_to_jiffies(2000);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
 	struct dma_fence *fence;
@@ -4956,7 +5021,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	u64 timeout = msecs_to_jiffies(2000);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
@@ -5241,7 +5306,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 
-	dev_dbg(adev-&gt;dev, &quot;accel_id %u\n&quot;, ualink_accel_id(adev));
+	dev_dbg(adev-&gt;dev, &quot;accel_id %u\n&quot;, ualink_exp_accel_id(adev));
 	amdgpu_bo_free_kernel(&amp;remote-&gt;rptr_bo, &amp;remote-&gt;rptr_gpu_addr,
 				      &amp;remote-&gt;rptr_cpu_addr);
 	amdgpu_bo_free_kernel(&amp;remote-&gt;ring_bo, &amp;remote-&gt;rb_gpu_addr,
@@ -5288,7 +5353,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	}
 
 	dev_dbg(adev-&gt;dev, &quot;accel_id %u addr_mode %d fw status 0x%x\n&quot;,
-		ualink_accel_id(adev), ualink_addr_mode(adev), status);
+		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
 
 	/* Alloc metadata structure for all GPUs */
 	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
@@ -5361,12 +5426,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	}
 
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
-		wptr_gpu_addr = remote-&gt;rb_gpu_addr + rb_size * ualink_accel_id(adev);
+		wptr_gpu_addr = remote-&gt;rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
 
 	for_each_set_bit(accel_id, remote-&gt;active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
 		dev_dbg(adev-&gt;dev, &quot;init for accel_id %u\n&quot;, accel_id);
 
-		if (accel_id == ualink_accel_id(adev))
+		if (accel_id == ualink_exp_accel_id(adev))
 			continue;
 
 		rb_gpu_addr = remote-&gt;rb_gpu_addr + rb_size * accel_id;
@@ -5392,7 +5457,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 						     ualink_tlb_wptr_offset(adev, accel_id);
 
 		dev_dbg(adev-&gt;dev, &quot;init from accel_id %u to accel_id %u, rb_size 0x%x\n&quot;,
-			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
+			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
 		dev_dbg(adev-&gt;dev, &quot;rb 0x%llx tlb rb 0x%llx\n&quot;,
 			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
 		dev_dbg(adev-&gt;dev, &quot;rb wptr at 0x%llx tlb wptr at 0x%llx\n&quot;,
@@ -5806,7 +5871,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 				      u64 *wb_npa, u32 type)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 accel_id = ualink_accel_id(adev);
+	/* The GPUID encoded in the write-back NPA address is the routing target
+	 * the remote writes the rptr back to, i.e. THIS GPU. It must be the
+	 * physically-owned accel_id: outside loopback that is our own accel_id,
+	 * and in loopback it is the exporter (the only id the single GPU owns
+	 * and can receive on). The importer is only a logical source id for the
+	 * forward path and must never appear as an NPA GPUID.
+	 */</pre>
      </blockquote>
      Maybe move this into the patch comment.<br>
      <br>
      Regards,<br>
      Philip
      <blockquote type="cite" cite="mid:20261102160125.2743750-2-mukul.joshi@amd.com">
        <pre wrap="" class="moz-quote-pre">+	u32 accel_id = ualink_exp_accel_id(adev);
 	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
 	uintptr_t wb;
 	u64 npa;
@@ -5981,19 +6053,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 						   &amp;peer-&gt;shootdown, &amp;tlb_wptr);
 	if (r) {
 		dev_dbg(adev-&gt;dev, &quot;accel_id %u read remote %u wptr failed %d\n&quot;,
-			ualink_accel_id(adev), remote_accel_id, r);
+			ualink_exp_accel_id(adev), remote_accel_id, r);
 		return r;
 	}
 
 	if (peer-&gt;interrupt.wptr == int_wptr &amp;&amp; peer-&gt;shootdown.wptr == tlb_wptr) {
 		dev_dbg(adev-&gt;dev, &quot;accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n&quot;,
-			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
+			ualink_exp_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
 		return 0;
 	}
 
 	dev_dbg(adev-&gt;dev,
 		&quot;accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n&quot;,
-		ualink_accel_id(adev), peer-&gt;interrupt.wptr, peer-&gt;shootdown.wptr,
+		ualink_exp_accel_id(adev), peer-&gt;interrupt.wptr, peer-&gt;shootdown.wptr,
 		remote_accel_id, int_wptr, tlb_wptr);
 
 	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &amp;int_wb, NULL,
@@ -6164,7 +6236,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *interrupt;
 	struct amdgpu_ualink_ring *shootdown;
-	u32 src_accel_id = ualink_accel_id(adev);
+	/* This sets up the send rings (local sender -&gt; each remote dst). In
+	 * loopback the HW-served direction is importer -&gt; exporter, so the
+	 * local sender is the importer; the skip below then skips the importer
+	 * and sets up the peer[exporter] ring that the HW path needs.
+	 */
+	u32 src_accel_id = ualink_imp_accel_id(adev);</pre>
      </blockquote>
      &nbsp; &nbsp; if (adev-&gt;ualink.loopback.enabled)&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="white-space: pre-wrap">src_accel_id</span>=
      adev-&gt;ualink.loopback.importer_accel_id;
      <blockquote type="cite" cite="mid:20261102160125.2743750-2-mukul.joshi@amd.com">
        <pre wrap="" class="moz-quote-pre"> 	u32 dst_accel_id;
 	u64 npa, flags;
 	int r = 0;
@@ -6287,7 +6364,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
 {
 	u32 rb_pages = AMDGPU_UALINK_RB_SIZE &gt;&gt; AMDGPU_GPU_PAGE_SHIFT;
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 src_accel_id = ualink_accel_id(adev);
+	/* Mirror peer_remote_init: in loopback the local sender is the
+	 * importer, so unmap the peer[exporter] send ring that was set up.
+	 */
+	u32 src_accel_id = ualink_imp_accel_id(adev);
 	u32 dst_accel_id;
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
@@ -6374,7 +6454,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
  */
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 {
-	dev_dbg(adev-&gt;dev, &quot;halt accel_id %u addr_mode %d\n&quot;, ualink_accel_id(adev),
+	dev_dbg(adev-&gt;dev, &quot;halt accel_id %u addr_mode %d\n&quot;, ualink_exp_accel_id(adev),
 		ualink_addr_mode(adev));
 
 	adev-&gt;ualink.msg_ctl-&gt;send_halt(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..0b1e8dd38666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
 #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN		0x1
 #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN		0x2
 
+/* UALink loopback support.
+ *
+ * In loopback mode a single GPU loops UALink requests back to itself for
+ * manufacturing testing. The GPU exposes two fixed accelerator IDs: it acts
+ * as the exporter on one and the importer on the other. Loopback is enabled
+ * with the amdgpu.ualink_loopback module parameter.
+ */
+/* Fixed accelerator IDs used by a loopback GPU. */
+#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID		1
+#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID		0
+
 enum amdgpu_ualink_conn_state {
 	AMDGPU_UALINK_CONN_NOT_READY			= 0,
 	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
@@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
 	int (*send_halt)(struct amdgpu_device *adev);
 };
 
+/* UALink loopback mode state.
+ *
+ * When @enabled is true this single GPU acts as both exporter
+ * (@exporter_accel_id) and importer (@importer_accel_id). There is no second
+ * physical GPU, so exporter-&gt;importer messages cannot be delivered by the
+ * (single) MP nHT and are instead emulated in SW by feeding them back into
+ * our own IRQ handler via @wq.
+ */
+struct amdgpu_ualink_loopback {
+	bool enabled;
+	u32 exporter_accel_id;
+	u32 importer_accel_id;
+	struct workqueue_struct *wq;
+};
+
 struct amdgpu_ualink_mgr {
 	u64 npa_size;
 	u32 psp_if_ver;
@@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
+	struct amdgpu_ualink_loopback loopback;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
</pre>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------Hu9UIGw0tEOoBrQ20tTCb15H--
