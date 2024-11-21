Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4BCD7877B
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 15:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A6010E9A8;
	Thu, 21 Nov 2024 15:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q5/05SJJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4FF10E993
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 15:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JinuK77OXmEJrX0vc5kZRzwGbqt4Ov6+LWmLNaMxPMGyLzOGXM8MRoIO2GksT1Ndn3hS64C+SEn8+dZNSTb2gaKq8+s3a0DAujQOzGbUUnDoQD3Thi8VPULC2RfOgXZIgJ8ioCtq6sFoQ5UfDrlm8JNrOslvNwwXQEJ9diZaSovKero4orzQHBG9CUlxQ4keNd6GImdQYumDACI0tJV5/ve1DvxtRPnVlvYACBvufSPOCQvjAUEdYN+tm2ZIruEMtgAFVbbg+gXAnUDv/A25YvsYqBZBSY1SxQGbcbwa+xsWEF37CKK1b83rkSvGHtnUbJK50727zquoQUfQTZYTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKjgm9ivKu+K02TcYH1tgXU50o3HipgtLMqD4gFPcfI=;
 b=yiYTLyjqzFA9ZVecpmhQlWUq7bH24lx8U0yhUsBrbU7//w4Pae/o9LEwSD9gXJ/9sQKgHmAGDgnVFsmVIYAICdx/A6jw9tZRdBDQBmV8fDpyBFPxwhCpzd+tjQWb15ohgVR2pSoEEb/984loZtaVLyjJig9pcrB0WhMM/8t1mhmNmtMSgkmL44+kJbpNucEtA105fgeZcw7hc8QG6/Mwc5Sn8IxLcGmhW1OGnzCC9yRaMcMuTEbuDBRi54VoJRBhacBjbD0Bu+ZuE1TlSHEJCeB+kV+uyAL76S95g8gKMdHz2RlrsrSBEvSTXYDCQ3PkYHhh0MQzh/KKwpUy6eve/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKjgm9ivKu+K02TcYH1tgXU50o3HipgtLMqD4gFPcfI=;
 b=Q5/05SJJ4GEgnkfaeqrkk4FfmblXkvQRUDwAYX4qd9U4vwB6vpCtSDHdoEOZky0QASUppFv+ANin8r6/Li9kFYSxXY1Qnr0mIG5T43AJfpyVMGNfb9Yoa/OgqBjRqUMZtQwr8PYMWRBBxgsjGOuV68bw5rkfcJlkciH7I6EzHeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 15:22:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 15:22:02 +0000
Message-ID: <e34a587c-a215-4212-a452-70afaeb89cb3@amd.com>
Date: Thu, 21 Nov 2024 09:22:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, jonathan.kim@amd.com
References: <20241111193323.278768-1-xiaogang.chen@amd.com>
 <6013a2b2-7e49-49e4-af90-8ea156a9722e@amd.com>
 <d8884052-8b31-4928-adfe-1f5dd5b09cde@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <d8884052-8b31-4928-adfe-1f5dd5b09cde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f459ba-d910-4076-d9a8-08dd0a403fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVdNNm1xU3dmMFROQmRtdlI4VXFmRXJWZVRtMTdsRmR0SUkxNFRWS2ZRK1R6?=
 =?utf-8?B?Qm5XSlA5U001M2Y0bzlkS2NnUVoxY0NvbmdaaHNnb29IOXorVnk2N3NTcHFo?=
 =?utf-8?B?NlZacEovTVlvcWpDc254WXJJRXM0UWxCN3pjcmdPZGd6OUdrUWMzenNubS9D?=
 =?utf-8?B?V2ltUHlBMVpRR2JkZmVMMENQY1NPRU05R0tYMmVVUGhZWnZnSTZMRWJwR2lU?=
 =?utf-8?B?TDVaK2FOTlFuL3NmMVp3dlVCd2VNKzF6MUhFN25ZdmUxcmwxQVB0S2hNVVNI?=
 =?utf-8?B?U0tPL3QzeVA3T1p0Mmk1ODY5YldQZmlkTWVOM3IyMEZGaHVCbDU1TzNnU3ZN?=
 =?utf-8?B?Y3FMbGlNKzUxQU96SUlZQ1I3eDFuUVMvZkxkMVBuSWNxV2cyUVkvbGdrZDNj?=
 =?utf-8?B?cnNTL3B3YzBCaDNuQmpndkhtdURiYW1JbG9hbHZwUnMrNGRpd2E3MUtpbkVH?=
 =?utf-8?B?dXlaR09DNTN4ek5ZOTFDdDY2b01rTjRFWHFnQnkxY3BYUnVvL2I5QmJlSUl0?=
 =?utf-8?B?WlFsZU0xOHpFOXpvbWVtSXhZaW5ZTFl1TkxFbGcyR2VTSnVkaEFnVEdaeUlO?=
 =?utf-8?B?ZWlNMElQR05DUUZ3MHdjS01Tc3phQUlRREFleU8wZTdSY3hTUGNIb1JETnBI?=
 =?utf-8?B?TXFza0VKZitvOGcrNnVUaEYwUmpCMW95Wm1Jd2M2OXVIL0pKaE93UG44bDFL?=
 =?utf-8?B?bkdWTmhQd2FXb200dnBOaVlmbi9HV0svYU1LRHV4VUsydTdYdFVXbWxqSEcw?=
 =?utf-8?B?U1FHRXdXN3dBNVRubVhuVzBrMWdrdEpDa0IrZmVGNXhSTmcwblNPVmV0elI4?=
 =?utf-8?B?UzJybjBrVnhhSnJiQVcwSWRtVy91KzFDTnRkbitPQ2tiQWNqYUJJQmFkUGdk?=
 =?utf-8?B?a0pjekhhVkFRbHdSdnF3Z01UMG5CajhRSU9janU1aklRNmQ4UEJlVlBGT0c1?=
 =?utf-8?B?ak5NS285ZTZ6aUdBczhsUURJcHZ1WWtDeGJJelhFZWtqL3VZZmIxZ3F3WXQy?=
 =?utf-8?B?Wm9PQnVqSXRMT0hJa09wUXJ4cXo3b2FYbEpaaVhCaXplZU1MZkxNOEl4dlpG?=
 =?utf-8?B?TDdka29OTW10d2JuR3NNb0JZZHdzRkRSdktuMFJRbGlmZnM5dUIreVhLS09R?=
 =?utf-8?B?RUNXc1NUd2NUZXJqR0dyTmIxOFlRRUpFZ2kwRUdxUjlxYmZZTUdHN01UT1BL?=
 =?utf-8?B?M0VPMzhBZHlxVGliMDdLT1A3OWpIWkRCK0VHSFdyUlVtTUZad2RNM2hub2xU?=
 =?utf-8?B?ZTFoUmsyNFN4YmRQb3pjUlhZdnY0clB5VytzOVBVYmFaTmg2UDFSU3BOb3JI?=
 =?utf-8?B?R3p5R0s1UTBJSzRIVVVIZlhLRzdGeEMvUFV5VHdCSFRvNk0reWJWZ1hOYjRz?=
 =?utf-8?B?cFJ5ajY1aUtkL1hLMjVLVVE5cEZGMTQ3WmNza2U3Y0MzWWE5clBTbWlKMG52?=
 =?utf-8?B?eGRPTFVpb0c1c0xERnFkNXFZU1I4ZEVQNk9WWlY4V0VxVDNPRExWN3R2TTVz?=
 =?utf-8?B?WlI2cjRJaGdKVnhHYy90RTErc3hwODFiNkNzNEoxdmVPTHNuWktNNXoxZTJx?=
 =?utf-8?B?Q0orNS8yZ1JWRXgxdmx6Qm5CaysvNVJSL3ZidHlFZktpM01ib1lESkRFV1px?=
 =?utf-8?B?ZExUSHJ1ZkZqa3l6R05XR05ISk1SdnVxVnFIYldEY1BTM1FoSU1UNm9BVmdY?=
 =?utf-8?B?dk1NN0o2Y3N6RUs1UytDUXZ2NXkzUDh5aVkrSHAvYmpkcXdmejJtYlBBS2Nm?=
 =?utf-8?Q?O+LPILr/9auMaHmepyiK3/C+3iHvYWvynnzdTZ1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRRTi8xSUJZRXdHMUFKUCtOdWtqVDlJNkpDbUVQTG81elI3b2NzcHl1dFp5?=
 =?utf-8?B?c0hyUXRrU2NLTVo4MnFBeHNEd3ZJTVdncStQK1FTbmRkUGV5MHFmdmtMUkZN?=
 =?utf-8?B?TURQY1lwQkNiWlB5MTRaNVhFT0FVaXNuK1M4S2Z1THNxaW53OEx6SGVETWpT?=
 =?utf-8?B?R00xcGFaWGJuNVNCZytzZWoydDJPeWlkYk9DeUdHU0tPV2UxMWcwWG0wcm5Y?=
 =?utf-8?B?Nyt6NDZHTkRHWjY4WFAvRWJNVnA3N3hFSFgrN3V2Q1dYWk9NSSs5VUZiOUxD?=
 =?utf-8?B?Q1Y1SDZnYlJyNXpTQ3FCQmRvanZ5UGJ1Ny9VWXVIRUJGUTRXZU5kTm9yQmNh?=
 =?utf-8?B?YnYwQW0rYXpWM1hhWWk3dmplL1MzZE5yUVJ1SmFFYURxSDFuRW1vMXpNV1px?=
 =?utf-8?B?dzFLakJ1YUowT2tLRjlGSGlNVW5QbHB1RGxzMnlnNmFJZ3V3eTF4cDNmU3dj?=
 =?utf-8?B?aWQ3WlBySEJ2WVJqYVlpKzNiRURBSCt3MjVJc215ZjExQW5Bbk1nM01HVmtK?=
 =?utf-8?B?d0lqN281a1R0dHlvQTluelBORE5seE9kajJKSUFOTnBxZnZMcmFYWXBmc1k4?=
 =?utf-8?B?a3QvaGJUQTQreDFTdkZtVU9nejVKTXVqelBQRmNNcU5RZXZ6czhQQnlNdjdo?=
 =?utf-8?B?alMvbWNkd3YwcjdWeGFMb21DTVFDRENOdWJoaTQxY1RBVjdGU1UwUGN6QktP?=
 =?utf-8?B?b0RPbjllSWczUXJiVGNRaitxM1FZcUhLc2wzSGRZZXptSE1MTms5VzZhYzFX?=
 =?utf-8?B?VUlTNlBlS1hHMnJaVVNWNWxIN2lzN0xEdHZSaUV5alVMRHkvY2MyNXpZNTBT?=
 =?utf-8?B?UUtHZlNMdnNKem1DUWZHSFloa015bXRTT3loRmdURXkrei9iaUpsc0lZVVc3?=
 =?utf-8?B?TjBNK3pxRjU1ZU1NQitNTkh0djBGcVBwNUJpTHJQT05lUU5rYXdFZTVTTm5z?=
 =?utf-8?B?RnRaVWpXVDJ5RndrbmFYTzMxY3RMMlFSaGtWb3ROVnFwWUJxcVdPWERNeVJU?=
 =?utf-8?B?SXpsVFptc1Axdkg2aEN6dWhGSG9OeGh3NnA3d2gzVGhsYzFYTWNOU2VDRTgr?=
 =?utf-8?B?eEpnR3ZEcUZmTnZaWTI0czBsaEFGNlBXTno4MkI2MzlUeisvYU5Dcy8vVm00?=
 =?utf-8?B?Z0Z3VFdmVjlZaEtnV3A2ajFmTys0NExRbk1YV2dsSG9ncHJTakF6U0Q5a211?=
 =?utf-8?B?MlhNdlVScC83RWlBajgycUEyRWJXaEFUaG9WYitwYWkrNXVPUkM2eG5nSjgy?=
 =?utf-8?B?Y2NrbFIwT1d0MEFBT0tQbHA5clJPQXpQK1JmcUJXQzh6MmVhZUF0eStqa1gw?=
 =?utf-8?B?V3dTdW4xZzFMOGk2UGE1NmI1SnNHK1RwZUJyU0tCTW1XZ3VQOVNhbzVxSkZy?=
 =?utf-8?B?eWYvN0Qyb2tHRTQyNHFTcVFMWnZyTXlFZ0RSQzA0MkR3b3NlL2FmNzhtdFJL?=
 =?utf-8?B?YmdCUVBUdGQrYWlxTlIxekJFRFdZdVpJRGY2TGdLdkwzSkdnVzE3bk9sdStU?=
 =?utf-8?B?UFR5UGo0MDlpWHI3UG51cW9GMmJBSUFnL3lneE1jd0p1cm0rbWRLMjBXZ1Z0?=
 =?utf-8?B?bjdnRmFVRUNMM2doVFJLeXBRUU1qWDVKanhTbzk5K2ZDK3FjSDdBTjFSeGxI?=
 =?utf-8?B?VFJMYlZUNzhyK3NTQk9pWTllZ2lqZlZwVDFSYWI5dnBzOUxSOFo4Q3ZuTnVj?=
 =?utf-8?B?T0JDWTdRTDJ6ZmxjMWxYcG13M3NKSzZweDNZek5DL2xZZ0RwVzlLNWdZaElD?=
 =?utf-8?B?dGdpWThydDI2aUNwNkVwZUZMcDhqMnZzVDlHandaV1JFcG5Vdlp3Rzh0aUdS?=
 =?utf-8?B?QzErQjBHQ0MxTWprVWIxaHVpSUcwcjZhd1FYTVU2czZUTVFreXhFRklyemhy?=
 =?utf-8?B?emxpQWNBMzZWdHZIcHBEdUtvNFNScmlIU2M1ZjRYY0xBcFYrR09pcWtTcHZ4?=
 =?utf-8?B?ZnlLdmlQNDIrTVpKL2tOYW1zcnl6aTc4YkZ2ZVRPcjRULzJPM1VvU215VDhx?=
 =?utf-8?B?UzY4Zm9wbHdwMnVNNURIWWhGKzBFQ05nUnRUdlZ4NGVnZXkxM0VwMzhlYVRz?=
 =?utf-8?B?YjEzcGd3UHorSlBnOVIwSXlxTmxVb3FNeG51RXJ3OEcrY2RtQ0E3c1NDMTZE?=
 =?utf-8?Q?6DVIU7aBmE0DvPHFH86RxJh/S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f459ba-d910-4076-d9a8-08dd0a403fb0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:22:02.1453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVX6oESIoFqm4J2xA/+on+Selhom5lbqifx08BMEsgDz1nqdXvrglgwMmezq/7uf6g4X8R1mpNafBuDreCkK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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



On 2024-11-20 22:58, Chen, Xiaogang wrote:
>>>   @@ -1822,15 +1804,20 @@ struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
>>>   {
>>>       struct kfd_process *p, *ret_p = NULL;
>>>       unsigned int temp;
>>> +    int i;
>>>         int idx = srcu_read_lock(&kfd_processes_srcu);
>>>         hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>> -        if (p->pasid == pasid) {
>>> -            kref_get(&p->ref);
>>> -            ret_p = p;
>>> -            break;
>>> +        for (i = 0; i < p->n_pdds; i++) {
>>> +            if (p->pdds[i]->pasid == pasid) {
>>> +                kref_get(&p->ref);
>>> +                ret_p = p;
>>> +                break;
>>> +            }
>> I think this won't work correctly. The same PASID can be used for different processes on different GPUs because each adev manages its own PASID->amdgpu_vm lookup table. So kfd_lookup_process_by_pasid needs a new parameter that identifies the GPU adev, and you should only compare pasids, if the adev matches.
> 
> I think it is the main concern here: the pasid used here is global in driver by amdgpu_pasid_alloc(16) at amdgpu_driver_open_kms.  Each time a render node(partition) got opened, a new pasid value is generated. Its lifetime is until render node got closed. A pdd just uses this pasid.  And each adev has its own xarray which saves pasids for this adev.

I think I had a misunderstanding here. I saw the xarray in adev and assumed that each adev allocated PASIDs independently. But there is also a global amdgpu_pasid_ida that I missed. If the PASID allocation is global in the amdgpu_pasid_ida, then each PASID uniquely identifies a VM your code should be fine.

@Christian, we discussed the number of PASIDs consumed on systems with many GPUs and partitions. If the PASIDs are managed globally, then running out of PASIDs is a concern. Do you think we should change this?

Regards,
  Felix

> 
> Regards
> 
> Xiaogang

