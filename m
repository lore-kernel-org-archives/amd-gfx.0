Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8B66082BF9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MJdlA+Kb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECC110FED9;
	Wed,  4 Nov 2026 20:31:29 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4391B10FED9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 20:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW+uFy5PxcTw0Bq84nDF8FmGszn1KQBI0UdrkfbKKlOSyAP6OsXFhhnED6x8iEuGXt6rS7QtVdN50raNVaz/EMEXnS6aiVbHjmInCHgO1dVe1NeHmyHX8IMELxU7gBdU/pEpgr1MGMaZsV70G0+0a2ZR19GiuF/bY56J+TjHO8v3vb/RB+t3LiNOCbYxnsfmWzxq34/H8JcSassXJNGEIcqvAKtDTZtVm6n3I9fCva2DM3D3WtyqjFX9hwdVpcf/HXuLysdp9WIuRJ+Z+3Z7kjEWlmuywHjqROH+TXw8ekXEfDGhVoCimaMrL7a6tLsVMRqpEXvxEgaXSJqHZA3LNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPsfKI42mc5AM0Px8pjCQzoRvyE0IafE0BZa9IIPSW8=;
 b=bsbrYo3gYPqqT+jJ7xIh/kRHmV3RoBRh8d9sPa3WfkAsOgXNA72h9bXD5HWhL6N0cSaLZh/liXkxil9oBLOymyDvPiKtW8AgB51LbRlQPZ2dG4e05MnQQTi1rKIVRDdzAZzh3jOpQJMXcMQA6bMywbVCDcJDSJaupSmWR0MgsoQ57iPf1PwcFvfzzBE2ROfLPH3Lf556Jb3cfmDq4nx7JP+FIVYVDrn0XW0hvEGlGchhxNo5RRm9SZD4GCc3FL2WsgpeMS3rmezTQnd650N9Qd/bR2+hora42sr2MTHG9e/dv3Z6e/MErJsE8o+l9m6SJ5oA1IcjHkZJ5ybXaVm5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPsfKI42mc5AM0Px8pjCQzoRvyE0IafE0BZa9IIPSW8=;
 b=MJdlA+Kbj40KGZgF3O+zD2YxAvYKQltHsqItChlcfXZRG+x+a8ppLec70f+FW6ba6EMEXst59LqmSQtODGSfl50tdInGkinAaovalDyfQZvvJPf8keB9Ili/4w42EkJbn2kgMve3hisOko0fT3uu4nLO/iREX2VJ1tKUL8iAeNM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:31:19 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 20:31:19 +0000
Message-ID: <0cee5aae-2488-4274-896f-b4eaab170c79@amd.com>
Date: Wed, 4 Nov 2026 15:31:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 3/8] drm/amdgpu: Emulate exporter->importer UALink
 messages in loopback
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-4-mukul.joshi@amd.com>
 <8cfbb96b-4e87-4744-a56c-3007679e2bc7@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <8cfbb96b-4e87-4744-a56c-3007679e2bc7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::29) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ca7615-17e7-4a64-fdd9-08df3ab2953e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|261022105027099003|11063799006|4143699003|5023799004|56012099006|261021121427099003|261009223027099003|261021123027099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261102130727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FdMf0cg1f2yaVfNx8CbLXhpBBu0r00eNCgDrZxa77d7G/pL/rrPy3nGrEnc5ICY3hA9BHmAkI0irXYa4MMFvs2GMdwT/InwfHe6iszOVacSoWI3kepBylycHVrfna/u2rdspykrw5YaQ8b8KxeEnJYoDeS2tmhwCklSylsVh2ypoH/YQB0v78hOf5BtHHaaq1brpq+ZcOp+9CFaKRr0ASd0jnK6YrjrPcfjTt6+6cvC27dYjm62dVuwqb+How0CA/WgZRzM9NMHphTAQe7tTsSgToOZYcpggNeuUrGEyOiLRzagWNv8FXyU2GR/iVrlNlSItC2/taZqHShhhCH6Xdrn7IZB3crNQ06xe/l30WF9gKP8Zwg9/xg5wboYfN5ZF+xQEHoSrHj38Do+B5R6sZM9SzjxYych+xJI0gptsx7iRZDbKDQZ9g1+phkSn1AMRpf5Enq+7yw60cQJG6IibFaub3GfN07SddQCN5VFMIAPxpxlP5IW6QogsetcMtxAbPtQZ14uYL2nietEuAN0if+1WOQ0s3CIGBe6mj0E5JAUJkQpSrozp7oQ09u4s87Nikgh/wb8EvnOdjIt7lkl2rD2oq/7HvlqsIiPN5G2DZ0OehPfAr23joBKxif6IsQZc6Gnate5mkax2CQuVv+rn0JFHAJHLN5i9RCMKlrpOyGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261022105027099003)(11063799006)(4143699003)(5023799004)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261102130727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWNYNDVFSW94a2N0ZzJOMVBwQXJOU3hobVFWWlVHaUdjOG10WU1XekYwUE5X?=
 =?utf-8?B?Qnh6bGNjeTRnTld0TStBK1gyZHFiLzlINWszdEFuaytvc3l4Zi9lMkVKN3lw?=
 =?utf-8?B?RHE4WmYwa1RVeEFSWHpVZ0s1Q1RDQWNFWTlibVBpMEZ2cnY1VjlzcUtKNzVi?=
 =?utf-8?B?R0gwTHRKRzJKOHdvN0ltL1NkUWU0SXpqQ0o2MHRPZTZLYWM2S0lka3UwODdv?=
 =?utf-8?B?NStNL2tFSFVJV0JnN1JUWEFBd254KzJ5Rk0wNjBHcmVQemE0Ym5FODV5b1gz?=
 =?utf-8?B?RnluZXpyWmtHK1pYa25TdVQwRHFzOUgzNUdvc3NRNHVNSVlnVjAvQmt6R1cr?=
 =?utf-8?B?NzJzZ0RFSjl5d3RhWTNaNkd3TG9SUHdkTnVqYmVFWkxVbnN2ejRiL1JRamhn?=
 =?utf-8?B?R25ZcjRGM3VoeXNJd0NOc013Qm1PRmFsajQySTYxM1ZGakhGTzVaU2FlTG5z?=
 =?utf-8?B?MU1aL0h2NHdrKzVTSTRkVmxoc28zekZzSEhHMENiMXdzbitiSVZZMUhtVnZK?=
 =?utf-8?B?L0FQRkJ6ZndHRzBNWHQxSUtzUkU1L1J3QlcvT1hQVFcvdm9PbkNoMlpvVHEv?=
 =?utf-8?B?eFRQcnhoTkV4YStCQ2tFM2dBMG12dHFteTFOMW9TQ3EybkhuWEx1UU52MkR4?=
 =?utf-8?B?VHNIbXE2OCtuNTNobG9jSlF4VFc5QTB4R1dlQVE1R0s1dkdESWkyREpMVHZQ?=
 =?utf-8?B?U05EbVZ3ZFRXZmFabGo4V3pMM1ZVUlFnamZJSkZ2RjVGTUJvVEFJMDN4NFdJ?=
 =?utf-8?B?Sys4cWJFd2V0dmY1MlNaYkdTWU9LeUZEOFhueDJuVVFyejNpQnR6QWV5a2hE?=
 =?utf-8?B?MGUxbTRxYmJlT0o1cmdQR1hGenJ0MmgraVdlVnEzQ1ZpVEgxSU45WCtmUUpx?=
 =?utf-8?B?RXI5cUNOVEVZanRGV1VEd0NUd2Q0NzVUYmhlRlE0ZEY3OXJFNFZpbE1RNklQ?=
 =?utf-8?B?YWpObm1teDhMVDJNaUpIQ205Ukpieml4N3E1dGQvOE1DcHFnYWcyczZMeUJ0?=
 =?utf-8?B?K09WZlZKSHlHZHRIUk9Kc3hXV3RJbHJKd3EwSTcweGFRZDlMN3BpdzU2TXl5?=
 =?utf-8?B?TmY3ZEhJUFFPUUJNd0NaaHpkMVBLb2tPZTcyRW5ZNE9vSFR3bVRVQU5jMk5U?=
 =?utf-8?B?RkdWNzQvT2RSbVlVMG9VV2JIL0ZhOTB5d2tDSUFZOHFITytlTDZrOUlHRWkv?=
 =?utf-8?B?S1hBM2psN0tXNGcxSU0vL0RnWVNsVi9pR3Bpaks0TlhMOGJBQ0ViYzA3Y09M?=
 =?utf-8?B?TnY2eWtUZkN6YW9CZ0l2SzcvbzUzTDlXbGZsajhtRjNpQjYyRUNaaW1pbzJ4?=
 =?utf-8?B?SDlFU2RHQTB2dXVPMUUzcURyWDVReUtRQ1N6aEVGUDUxdWpJOXAybmtPOVhR?=
 =?utf-8?B?cG5nQUdKVUl1OTV5YzRoVm1DckF5c0hxN1ZQakFUSlBlM09DeVlkdDFCZXhY?=
 =?utf-8?B?NWthc3hqOVAvQVhBSG9LYSswRUFYUHFVUnJLVFJQWVhrTDZqUFU0aWYwREtG?=
 =?utf-8?B?b29DQTNHdjBDMlVBU1Y3enJveWxFbkxGVW00MWFBRzBiN1p6N08wYitIcFRh?=
 =?utf-8?B?RVg2emlwaVRzb2JjaFJ1TzdmU2dEZVZFRkxEN240WEF5SDl3d1Q5UUhrUXQ2?=
 =?utf-8?B?dU44NDhQV1V4cVJ4RlROUDJhbHRJWVp2MSt1WXMrak5yOUtnVzkxQ3Y2Sm4y?=
 =?utf-8?B?aXBhOTlnZnRKc1Q3UERNdExYOURzRXU1RE5kcWY0SkYycmdZaEdNM0dEWkFK?=
 =?utf-8?B?WlBubjVtMGphRTZvOUJUQVVOWUZCbVVKRHIrVyt5WVNVVW92d0lzZTU0VGdS?=
 =?utf-8?B?cXNaQ0Z0SHAvRGF0T2c4cDUzUms1RHFla0lkek1KYkVNOW1YN1VQSnNRMnVs?=
 =?utf-8?B?bUVuU3o3Zi9zUVFmVUpXTG9UdXlKY3d6NE5KdFM3dzVlMnArbkppQ1c2T2Z5?=
 =?utf-8?B?dkhmZ3pUWUpZTzh0K05zclFEZmlabVlsTmE2S1VGYWN6RjJjbi90djNPdURC?=
 =?utf-8?B?RlN3U0tFUzR3cERjS05aditjN3NXVWVDVkhwSVN2OWxyeXg5d0JyVGlpelVF?=
 =?utf-8?B?aUtpTXZrNXFkdXp0RGMzMzd6WXBjSXRpaHhGSEZ5c3hQR2FkTWcyR0ZtS1Nq?=
 =?utf-8?B?RTBYRE9iL0FmbVplK3dPT2JEUWFFdFhEeVcyVS9OcWt1bTFnblE4czJxUXdv?=
 =?utf-8?B?SWlNNzlQZHJNNEtIZzNFZVBScmcxbUhUMkVHbS82RHZZekVQL3NUUTUveDRF?=
 =?utf-8?B?MmJoK1AwZGNDVGFid2dHcXNsd3RtTUd1Q0oyS0IxQUNGMTRxMWgvdlFRanZZ?=
 =?utf-8?B?NXFsaks5S0Y5WEU1bFkrSVFQVWdwMlRJK1dJdFk4OEJlZks0bzdrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ca7615-17e7-4a64-fdd9-08df3ab2953e
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:31:19.3111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45ErjLDRX86VXjAzG0+7RUxIh9fj6T7WkSxsb2VX0lLfYtC7NLt+w/HJagejDAdqHya4idUqTXqsTIfmD9IBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/4/2026 11:10 AM, Philip Yang wrote:
>
>
> On 2026-11-02 10:47, Mukul Joshi wrote:
>> In UALink loopback mode a single GPU acts as both the exporter and the
>> importer. The exporter is the one physical station, so the only path
>> the HW serves is importer -> exporter. A message the exporter sends to
>> the importer cannot be delivered by the MP nHT.
>>
>> Emulate that direction in SW: when loopback is enabled and a remote
>> interrupt is addressed to the importer, queue it on the loopback
>> ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
>> as if the exporter had sent it. The ordered workqueue keeps successive
>> messages in order and runs the (possibly sleeping) handlers outside
>> the sender's context.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index 29a787979af2..ef133c60bb9a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -60,6 +60,9 @@ static void amdgpu_ualink_reset_peer_rings(struct amdgpu_device *adev,
>>  					   u32 remote_accel_id);
>>  static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>  					  u32 remote_accel_id);
>> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
>> +						 u32 sender_accel_id, u32 dw0,
>> +						 u32 dw1, u32 dw2, u32 dw3);
>>  
>>  #define STRIP_NPA(addr)						\
>>  	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
>> @@ -6220,6 +6223,17 @@ static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>  	struct amdgpu_ualink_ring *ring;
>>  	int r;
>>  
>> +	/* UALink loopback: the single MP nHT can only deliver messages addressed
>> +	 * to the exporter accelerator. Messages addressed to the importer
>> +	 * (exporter->importer direction) cannot be delivered by HW, so emulate
>> +	 * them by feeding the message back into our own IRQ handler.
>> +	 */
>> +	if (adev->ualink.loopback.enabled &&
>> +	    remote_accel_id == ualink_imp_accel_id(adev))
>> +		return amdgpu_ualink_loopback_self_interrupt(adev,
>> +				ualink_exp_accel_id(adev),
>> +				dw0, dw1, dw2, dw3);
>> +
>>  	peer = &remote->peer[remote_accel_id];
>>  	ring = &peer->interrupt;
>>  
>> @@ -6649,6 +6663,74 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
>>  	return handled;
>>  }
>>  
>> +/* Work item used to emulate an exporter->importer UALink interrupt in
>> + * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
>> + */
>> +struct amdgpu_ualink_self_irq_work {
>> +	struct work_struct work;
>> +	struct amdgpu_device *adev;
>> +	u32 sender_accel_id;
>> +	u32 dw[4];
>> +};
>> +
>> +static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
>> +{
>> +	struct amdgpu_ualink_self_irq_work *job =
>> +		container_of(w, struct amdgpu_ualink_self_irq_work, work);
>> +	struct amdgpu_device *adev = job->adev;
>> +	struct amdgpu_iv_entry entry = { };
>> +
>> +	/* Build an IH entry as if the message had been delivered by the MP nHT
>> +	 * from the exporter accelerator. amdgpu_ualink_process_irq() consumes
>> +	 * the sender accel_id from entry->pasid and the four context dwords
>> +	 * from entry->src_data[]. entry->ih must differ from adev->irq.ih so
>> +	 * the message is processed here instead of being delegated to the
>> +	 * UALink soft ring.
>> +	 */
>> +	entry.ih = NULL;
> Looking at this again, it seems we could use adev->irq.ih here to
> simulate the message arriving from the real hardware interrupt ring.
> It would then be delegated to the UALink soft ring and handled in the
> interrupt worker, which would let us drop the job structure and
> amdgpu_ualink_self_irq_worker entirely.
>
> The current approach works fine, but that would be simpler and avoid
> introducing another job and work item.
>
We discussed that approach with Felix before and found we need to
introduce locking to prevent concurrent access and it can lead to
deadlock if we are expecting a remote interrupt while processing another
interrupt.

Also we need to create the complete IV entry because the delegate call
will traverse the entire IH/IRQ code path in the driver.

As discussed offline, we are OK with the current approach.

Regards,

Mukul

> Regards,
> Philip
>> +	entry.pasid = job->sender_accel_id;
>> +	entry.src_data[0] = job->dw[0];
>> +	entry.src_data[1] = job->dw[1];
>> +	entry.src_data[2] = job->dw[2];
>> +	entry.src_data[3] = job->dw[3];
>> +
>> +	amdgpu_ualink_process_irq(adev, &adev->ualink.irq, &entry);
>> +	kfree(job);
>> +}
>> +
>> +/*
>> + * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message to ourselves
>> + *
>> + * Used in loopback mode for the exporter->importer direction, where there is
>> + * no HW path. The message is processed asynchronously on an ordered workqueue
>> + * so ordering between successive messages is preserved and the (potentially
>> + * sleeping) message handlers do not run from the caller's context.
>> + */
>> +static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
>> +						 u32 sender_accel_id, u32 dw0,
>> +						 u32 dw1, u32 dw2, u32 dw3)
>> +{
>> +	struct amdgpu_ualink_self_irq_work *job;
>> +
>> +	if (!adev->ualink.loopback.wq)
>> +		return -ENODEV;
>> +
>> +	job = kzalloc(sizeof(*job), GFP_KERNEL);
>> +	if (!job)
>> +		return -ENOMEM;
>> +
>> +	job->adev = adev;
>> +	job->sender_accel_id = sender_accel_id;
>> +	job->dw[0] = dw0;
>> +	job->dw[1] = dw1;
>> +	job->dw[2] = dw2;
>> +	job->dw[3] = dw3;
>> +	INIT_WORK(&job->work, amdgpu_ualink_self_irq_worker);
>> +	queue_work(adev->ualink.loopback.wq, &job->work);
>> +
>> +	return 0;
>> +}
>> +
>>  static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
>>  					struct amdgpu_irq_src *source,
>>  					u32 type,
>
