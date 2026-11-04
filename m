Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC116070406
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0k9YHaB5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEB710E8E7;
	Wed,  4 Nov 2026 20:20:53 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411F910E8E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 20:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J35RWtZeHudLG3kyhhuYteioidaEiSUEQqxCTcoDvUSGdiAZxJZo/7FayiUY81KuYmG+S7cuWmjmYuVb0mciLZZkf+UltDMdE3zwJBZeS2DecyAZillzVLlxTflxRAMsynyEJkFxazobgSIzzAIkzTjKm2w6jJpWOCSq4oqBiF/l8ffqq91pdLPWgfeZnquxeyyorEZ+Lm+UiYYWkLiaK8yphS2dY2G6334l6NLH/mavB9yEgaiZNRlB++2Fgt6vt2+Sg+hK4Seh6EzI64mzeP2+DOdaSpztSYlhAaoLcVaoiASTwH1pEeZViCmh18ok0QwDwrxKQmkbD8TbxbrQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ud52XW9sHSj3QTsWaZOCBmWfuspC3tKuJMMIXrdcHc=;
 b=AnP7P2zHNqRj1Yc16DRmS+odeQ0kBIL7cBXUGYqnqGUdVs6TaiCKNpTXZgY/+DbcBmHHMi/E7Xy3fiGIZUjdL3wlO/L0XTfsMTHn8SNA8qoM5crec4FHgP5In0qhVVsfbf7JEfAGgYAjHSPIJ/IXY2vMxlacqOr+s5ZJi0hByqtuL6iRjoYpnjbv0A8X8HmzdBWtLPxvNjVia2EUVlOVS+ntqGsDRENpjFPAlnToNY29JIRlnsC5vm5iFv+iQ5Vr1aXo7IliYZ8kHJUFQmP8SOtkjj4s2BD8GVVZAhk9NamVlBF80rIsHkB3Nu1bd8LNBTmntlwyFhCe19aoOoi5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ud52XW9sHSj3QTsWaZOCBmWfuspC3tKuJMMIXrdcHc=;
 b=0k9YHaB5DTlUqWaOnuPMCl5D/H5lWJq7dDjEJTS/C2q5GZSLl6HhuW6DAvWNVSneqjJPd97GbpkJLtbNsy7KbsY8MSMi5GiUpEWuJ5tPE1LWCuF9BHgvaH6vXPTn3G63fjJ6tf1feQV7g5KYt/O7fnWrTwMVtWwtxNAlT4hIlQo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by CH4PR12MB449035.namprd12.prod.outlook.com
 (2603:10b6:610:520::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 20:20:10 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 20:20:09 +0000
Message-ID: <c5317b23-66d0-49d2-a011-0c210cb3aa98@amd.com>
Date: Wed, 4 Nov 2026 15:20:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 5/8] drm/amdgpu: Set up UALink rings and metadata for
 loopback
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-6-mukul.joshi@amd.com>
 <01e74b6f-3eb4-4ddb-8288-fdabe4efd943@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <01e74b6f-3eb4-4ddb-8288-fdabe4efd943@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::12) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|CH4PR12MB449035:EE_
X-MS-Office365-Filtering-Correlation-Id: 82721ee8-125e-49cf-38a8-08df3ab105f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006|261026121527099003|261022105027099003|261028144727099003|261026140227099003|261102130727099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 42gWhvxBoZ6/WlBDnpqZBWxb3jVO91UJY5zsbmVPn+PHDcw7Lr/403+VkV7K1VUZo9QguddZyVIkYA6j8uE7fqANrmVQERZUrBWBCXgPr7rqHp5hCF8eS/a6u45H8NBkeKWa4BpX2vyOUtavwMdIw/t9bjjIHPJ27mNS/uuLW8x1SU1SqOlVVE8LQLB7i+DYAP1J87YBjSInuIg8m6z9QVhxMcyJI5rMHF1lSFC15hpkopfPBQoFmZzMah+YoiUzOd3eSVQo6xC1HHHnwNHLEvA7HN6kwRQFOcqAq+xhmec/Mdk3HgrQBcMos6rjT407nIILhxLVDMfF2HgmBAdvtqVUVHMc0gwKKtWTcTaLRx7gM7iS93OsXdO1WZh63zrLzrrsi/DK+Cyk/1t4KPFFMVAyptrHwSFu7mM1HJoX1ArHWdYPrv8bQkzuVPiy1PMBO86Ct8Dbc2Nx+uwTGY1AQkiRIn70ONwvTJ4ENSuVOiosG82mftB3A8olQb31Tx+bKgr0IDfDggWLP5LZIfzgl6qid2iqDbUoWzkSooRQ9WIt0di2dEkgwmdCCEqBRYUdllwODG1b4qrUNwi1G0vP8v4PvBdkKOsxnjVpIpYIUhsZZVqixNgv8YPbescSGoe2XzMPMSkV0eSdVSlB9pEssIW829tBjwT8lIEHIwMz4JM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006)(261026121527099003)(261022105027099003)(261028144727099003)(261026140227099003)(261102130727099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZrVmpibkIrYnJad29GOFc4MzMxN2VrT3ozWGNIbUt6TzM3T3RQNktoTEVK?=
 =?utf-8?B?ZU8rcmFtNERGSFhTMGY1MmZkL21LQWhvSVhQZ0FLVUExODhRSE5HZExRN3Fv?=
 =?utf-8?B?OEtndW4wdGhhcU9panhXK2RoQVNneUNGcHEvNG1zMmtraWM1S0F3QzhPNHVO?=
 =?utf-8?B?OXk1KzFnUE5UWnhRYVBJR09KcTZOcWVDOE5GZVd4MUNjUmRSemFGRXFTdnRN?=
 =?utf-8?B?RUtqWWs5U3B3djl2eldMZkJXNGpsc1dScmwzSFRhYUJkSkM4dmVBYWRXMUp2?=
 =?utf-8?B?S3FEMDZ4L1RScUdnUks3TXhmcUFQYzlOeU15a0ttK3ZsQXIvQ0ZMRGZYazJC?=
 =?utf-8?B?S1dJOCt4NjZoYXZIVTVCeXJKc05YaFBWdGhMbmljSk5MejUreHNFZWwwVXVN?=
 =?utf-8?B?SFptOVZuWXJiV1VRSmFGQWY2amtMZDlPNVJ1bnFFNXk3ZGRqMzVyWXdKdXlG?=
 =?utf-8?B?WEF3aDY2eko0YlFVZXUwaTlFTkI5eGd2ellZTFVwM2l3eEd0aTdraHlsU1N3?=
 =?utf-8?B?V1kraEU2d0Fodjl0aTZCOGFDTzdMaitRU2REL1I3SVBSNEIwNDJYVDFWVEo5?=
 =?utf-8?B?UWtxSzhDMlFrN2UxRlVFZzFBN3lsdnJiZ2J6NlJBcEVDM3NydEI2SmFZelFV?=
 =?utf-8?B?T2pFTlI5S3FxOXVaQ01Ob2JSangyY2tMR0NyUlExUG03SGU2R3RHdkNaUTgy?=
 =?utf-8?B?emY1YnZiYWRsMFJPelRSVmkxOHdmc0R2Q1dOSFVTWVkzaVdQRzR4L1Y4QzJ1?=
 =?utf-8?B?QU13OWRXVE1vbmsyVDlOL2QvZFpub1BWQk82R05uaDUrb1puZVZVSHNoNUdt?=
 =?utf-8?B?N09pVmU5K3ZqNTRUdUd4Mm9iM0lvTUdKN2hHOUZoaWFyNGg2QjVNZWJBNE02?=
 =?utf-8?B?TUZJSXo5cmpFbWwxREJkM3dxOC8yTC84VFRBSm5Fd3ZqUlZwTzlkS2NRaFZh?=
 =?utf-8?B?eUlocHl5dy9mRnEwZWhzOVpUSXZnVEZyY2I0K3prbzdwU1VsbldsVWlFalBr?=
 =?utf-8?B?dmNKQytqUlY5bVNqUE9mQk9YTmUxdlpRYjFrdzMreDlQQzlnMU56OWF5MVll?=
 =?utf-8?B?b29YUXVzU0Rqckw1ZWJ1bHVDUnVYOG9qQVJrRUhpSmZLaWwyRkZmOVg1Y0s4?=
 =?utf-8?B?aDJnbWh3eE5aVU81a3ptN0xTVEpXRlhsem5hc2VHYjVGOVBDODBjcndmL2x3?=
 =?utf-8?B?bDhYTzYySkgyczg3VUVKK2JWQ0VnbC95R1BJWjNBR0dFaW1wUDZ2ZFUvM09q?=
 =?utf-8?B?WVcvMm81S0hGQ0EwdVRHajlMaGtkOERHQzZmRU1JL25QUmFreUxXYkEzMkor?=
 =?utf-8?B?VUxWTWo5ZmdyOGlabG1OOWx5YVVmb1dxTFdoMmtoQlRsUzlUR2F5TzhGZm5K?=
 =?utf-8?B?UFBlanBjaTJnOUdQM3l2YmNEcW1teEZ5NjA4RW93NWV5ZVcxeGkwSGIwclpC?=
 =?utf-8?B?TTAyTTF2MVdkK0tvY0RoVE9Qb25OVlZvaGp4R2FmenhnT25EbGNaNVhxZk9z?=
 =?utf-8?B?ZXAxM0hTNE44bjJwbGlhQlVuSkVlVHdiNCtsenFiY01HamhLd08wSlVEUUwr?=
 =?utf-8?B?enRYRVlXcWJhaCsxZFhmV0FTSUQyVmRpU0ZsOEU2V3NWK1gxWEtxODlER1Qz?=
 =?utf-8?B?N1lXVEFCcWljTGZQbmt1OVdiTm5GT0Y4dElGU25QNGZxTVlJS0I0TVhkT2s5?=
 =?utf-8?B?OE81cXNZZUFWRlkrcVlESGVWSTRmR3BxVnZQZjh2Y3hMTlQ3WFRBaStpdk9O?=
 =?utf-8?B?aXhhQjZkQnFDbmlkRVowekRTMGcySUFENEloZkI3T1pZYi9PRjBkOHdKQkJ5?=
 =?utf-8?B?Sjk1SGRiL09PZkd5NzhUbE9FT0RweVJiQ3B2dkRHdHI0bCsvSlBneFJYK1gv?=
 =?utf-8?B?cEVGeStsa0xHdy9pQ2hrSUJJeVEyWXlPVEZhVXFEbkNOU3YxL0x1ZEExNnZJ?=
 =?utf-8?B?VkEzU29kS1ZPUWhOb2UvaTFud1F5amc0bGpzOGpIOE80UjlCcmV6WHgxbmds?=
 =?utf-8?B?R0xmajJKM2psdVNTckVTYjBOTm1LcktJWDdtdU9hMXlYL1dFNmdDMnVIelJE?=
 =?utf-8?B?S2tTUHdnTHZzSFd4SUVjaTVhZUFTY0VJc0ZkNU1tb0xnbzdyL1BvWTFjamI2?=
 =?utf-8?B?N2s3ZWRQTituOWhzejVIZENUR1AzK01DNjQvKzh1NUlHdFQyN3FzZDhDejM0?=
 =?utf-8?B?ZGVYOW5acjU4d3hHOTZaTFIwL0ZGdkM4RUhiVnZTZ25CTWVNaTdqamdFU2lw?=
 =?utf-8?B?VVFmbXVMd29NV3FkOXZhRDBsaXoyVW91ZDlMbWtNZTQwQlkvRjg3eFpkWVZG?=
 =?utf-8?B?SWluU0FDT3kxZE5sNUlNcHIxSHNVL0thTWdWRFFmV2dqQldIRWxuZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82721ee8-125e-49cf-38a8-08df3ab105f9
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:20:09.4855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9CIExI88YFeTgsI36OJkNteHLReBlZJuRd/2/QefZWYBSL1JmjLNxKA9tpxe/IdDHs1Ea6nOh7kL3JI6gAE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB449035
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


On 11/3/2026 6:15 PM, Felix Kuehling wrote:
> On 2026-11-02 10:47, Mukul Joshi wrote:
>> In UALink loopback mode a single GPU acts as both the exporter and the
>> importer, and the only path the HW serves is importer -> exporter.
>> Adjust the per-peer setup accordingly:
>>
>> - The importer's doorbell reaches the MP nHT stamped with the GPU ID of
>>   the exporter, and the FW looks up the metadata entry by that ID. So
>>   publish the importer's rings and tail pointers in metadata[exporter].
>>
>> - Skip the ring pointer resync. Both ends of every ring are on this
>>   GPU, so there is no remote peer that can reboot and leave the
>>   pointers stale.
>>
>> - Do not take the local dma-buf shortcut on import. It would bypass
>>   the NPA path that loopback is meant to exercise.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>> v2->v3:
>> - Move updating src_accel_id in peer_remote_init and fini to patch 1.
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 54 ++++++++++++++++------
>>  1 file changed, 41 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index 8558dc1a9e84..74bc8a907f5b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -3976,7 +3976,13 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
>>  		return -EINVAL;
>>  	}
>>  
>> -	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
>> +	/* In loopback mode the exporter and importer are the same GPU, but the
>> +	 * import must still go through the full cross-domain NPA path (the
>> +	 * dma_buf shortcut in amdgpu_ualink_local_import() bypasses NPA). Only
>> +	 * take the local shortcut for genuine same-pod local accelerators.
>> +	 */
>> +	if (!adev->ualink.loopback.enabled &&
>> +	    amdgpu_ualink_is_local_accel(adev, remote_acc_id))
>>  		return amdgpu_ualink_local_import(adev, remote_acc_id,
>>  						  &handle, fd_out);
>>  
>> @@ -5452,11 +5458,28 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>  		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
>>  
>>  	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
>> +		struct amdgpu_ualink_metadata *md;
>> +
>>  		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>>  
>>  		if (accel_id == ualink_exp_accel_id(adev))
>>  			continue;
>
> I think you could drop the condition just below if you change this to
>
> 		if (accel_id == ualink_imp_accel_id(adev))
> 			continue;
>
> It makes no difference if loopback is disabled. And with loopback
> enabled it's the more obvious way to only initialize the ring for the
> exporter ID. Then all the other changes in this function are unnecessary.
>
Unfortunately, this won't work.

In the normal (non-loopback) case, when AccId 0 sends a message to AccId
1, it writes the message to the ring buffer and wptr NPA addresses that
AccId 1 set up for source AccId 0, and then rings the doorbell. 

The remote interrupt the MPNHT on AccId 1 receives carries AccId 0 as
the source, and the MPNHT FW uses that to look up metadata[0], which
holds the ring buffer and wptr addresses for AccId 0.

With loopback it's slightly different. AccId 0 (the importer) still
writes to the ring buffer and wptr NPA addresses for source AccId 0 and
rings the doorbell.

However, the interrupt the MPNHT gets reports the source as AccId 1 (the
exporter).

So the MPNHT FW looks up metadata[1], and for it to find the right
buffers we have to program the importer's (AccId 0) ring buffer and wptr
addresses at index 1.

If we skipped the importer and ran the loop for the exporter instead,
metadata[1] would be filled with AccId 1's own ring buffer and wptr
addresses, which the importer never writes to.

That's why the patch builds the entry from the importer's addresses but
stores it at the exporter's index.


Regards,

Mukul

> Regards,
>   Felix
>
>
>>  
>> +		/* In loopback the single MP nHT services the exporter half:
>> +		 * the only messages delivered over HW are importer -> exporter
>> +		 * (source = importer accel_id), while the exporter -> importer
>> +		 * direction is emulated in SW and never reaches the MP nHT.
>> +		 *
>> +		 * The importer's doorbell reaches the MP nHT stamped with the
>> +		 * GPU ID of the single physical station, the exporter, so the
>> +		 * FW looks up metadata[exporter]. Publish the importer's rings
>> +		 * and tail pointers in that entry.
>> +		 */
>> +		if (adev->ualink.loopback.enabled)
>> +			md = &metadata[ualink_exp_accel_id(adev)];
>> +		else
>> +			md = &metadata[accel_id];
>> +
>>  		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>>  
>>  		if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
>> @@ -5464,27 +5487,26 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>  			wptr_gpu_addr += wptr_size * accel_id;
>>  		}
>>  
>> -		metadata[accel_id].header = AMDGPU_UALINK_METADATA_HEADER;
>> -		metadata[accel_id].rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
>> +		md->header = AMDGPU_UALINK_METADATA_HEADER;
>> +		md->rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
>>  
>>  		/*
>>  		 * remote shootdown type is 0, remote command type is 1
>>  		 * with 2MB ring buffer mapping, remote shootdown ring NPA is before interrupt
>>  		 */
>> -		metadata[accel_id].ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
>> -		metadata[accel_id].tlb_inv_rb = rb_gpu_addr;
>> +		md->ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
>> +		md->tlb_inv_rb = rb_gpu_addr;
>>  
>> -		metadata[accel_id].tailptr_ri = wptr_gpu_addr +
>> -						ualink_wptr_offset(adev, accel_id);
>> -		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
>> -						     ualink_tlb_wptr_offset(adev, accel_id);
>> +		md->tailptr_ri = wptr_gpu_addr + ualink_wptr_offset(adev, accel_id);
>> +		md->tailptr_tlb_inv = wptr_gpu_addr +
>> +				      ualink_tlb_wptr_offset(adev, accel_id);
>>  
>> -		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
>> -			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
>> +		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, metadata entry %td, rb_size 0x%x\n",
>> +			accel_id, ualink_exp_accel_id(adev), md - metadata, md->rb_size);
>>  		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>> -			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>> +			md->ri_rb, md->tlb_inv_rb);
>>  		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
>> -			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
>> +			md->tailptr_ri, md->tailptr_tlb_inv);
>>  	}
>>  
>>  	r = adev->ualink.msg_ctl->send_metadata(adev,
>> @@ -6069,6 +6091,12 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>  	u64 int_wptr, tlb_wptr;
>>  	int r;
>>  
>> +	/* UALink loopback: both ends of every ring live on this GPU, so there
>> +	 * is no remote peer that can reboot and leave the pointers stale.
>> +	 */
>> +	if (adev->ualink.loopback.enabled)
>> +		return 0;
>> +
>>  	/* ring->wptr and ring->rptr are owned by the send path. */
>>  	guard(mutex)(&peer->lock);
>>  
