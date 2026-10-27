Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A8606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eto8D8JD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB88010E45B;
	Tue, 27 Oct 2026 18:54:21 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B320910E45B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 18:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwmB+BE0IdOKHWICXquxWj5zt4eQGm/iM5LmDgixmRfkxkk6fMGVAl7HfFSmmrUbDCF+BEskyNWQmrCp8ALmaCG84O1/e4BA+71AJ6p6fGb5LrHSu7U1iITF+EyQmbxcnhJ/VdZfBpep/fd38Fg0TD7TjCPtD7WdYuuF4TJrbMSFhSRAF7dR89l2pXgf77fmBdhiZ/XR19X8LXvNBTePFgAp+iFOo7nJaa6SQznBPnSTFkdRfHevASXlPDWXrq4H4O2UXihmDZvOmtIKW4qXolKymusXaMB52BDEv5nXgbc82gBgocEL90eqBeH8awxFYChNdao1jhJTTZM4XYNkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCfDmwaorQ30J8yDUVKkLMvk8IeqaehBtujWe5+z5Ag=;
 b=fK8WN0gL1n+cR1bNHoMeQgpdrR38MsWOhw7kJR3WltsEWKtsZCg3P/r235C18lDNKmGcHN/ymY/kyvkcGzSRDCe3p2g8IhXYm7JicNqCM2hmdj07FRTSZIH7JVtBSZxjFa/Ux0EIu8ossLvyd1uehPSjniqzlfpaOO+MfQojWpxOLYxERN86uTskIV1e200zUckj5iku4e8vDZ8Io+FsZrkna/yeW6QIcuIFmoIeCzBCl91QrURLIP/Fm1btn4yX4IOUpZ2w88DzFABA9EBSx+HSCi1HTZv+8Mz4Gt6qFR0gOmXjTXJrAeRKPhRj93qrvhYBhOKaBJJdXXOg4F4eOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCfDmwaorQ30J8yDUVKkLMvk8IeqaehBtujWe5+z5Ag=;
 b=eto8D8JDMm7t5uyafySdGzUpjGZVaa7ddkdHHc9E0O5IXnyMHVVgeGau/lvcllYqxgNGxH0rDphhKKeE5x503UGQDbhZp9tlxdMfjPVyJ7/Z05mVK9T9soaeLw0NRyMabD0vzQad2ZcCvwM1mVG2gXaZDgvaswLdvDMJqbfPiKA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by CH3PR12MB9395.namprd12.prod.outlook.com
 (2603:10b6:610:1ce::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 18:54:11 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 18:54:10 +0000
Message-ID: <47ac2cb0-abc3-4123-bf67-c95dd5324a52@amd.com>
Date: Tue, 27 Oct 2026 14:54:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/amdgpu: Attribute UALink loopback messages to the
 correct sender
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
 <20261026230248.1597606-5-mukul.joshi@amd.com>
 <0c2a9ad2-5c64-4bbe-9dc9-cd692a6ec7da@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <0c2a9ad2-5c64-4bbe-9dc9-cd692a6ec7da@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::7) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccbd657-0a28-440b-4c75-08df345bafed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261021123027099003|261009223027099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: BGTjzCgbTAmaW7XfCl0tY0Ti/dm01hLMXgbhNkHcD63hszPeOPV6gHfrVTuKlm8mGdlHvLTnCrCc6bP3OTRy6uXSh6Eh8XRE7lhBjjWW8N65yvmlBlJFSSIS1RKJeHjaWaWvtQjDr/6MxFNDuruoNM/EhAZHfu817ehAvZlfQd37Xg05X1wj2YD5VdwepSkN9PYB6lr10hotEQDKYVMzG7P0dygZMGjpqjznohfVL0hIS9pPf1LImmpDOepZeLdLbKohDHGYQtY9Kh2FFgI4vwzml0m4a8fBNXA7WJuZBaCWkMoRBklmowvn2Hk9+a7yMrvSixkYkJQTruiwHq6HWuVMJGonCKMVeCSI5/2Y6Qy1+jZrN0cX3S4HyIqlBZ/WLBiRTqhLcm+ayaUiYERrQkvIKUg/GYU6SwoPbrDItBPEkwVGH7eWSO3/bQG1JVabYTp5Btcsc46dWT6mMMvwzAp3cVzRLKMu0WWgYzSfio+qDTfyRc6YFkrdzZwdy662BExDiCysvJ5XoGfhcJdpkAdc47c9GUqKEvVW++15RQ2M+NB64zCRWzQoqMKpGbIH18rzbANi00KJjtbtm1RKfXHuT0r2xYXMN1TCYzZWP74vnV0VeGy2no5X5ZYAj4GW3stGW+uwFnjEXGq1gGKZ9BlktohOy9BfPwdJCCmPpTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjA0YVNhODl5dWFNazRKMjhRMkR6c3lPazBRdGxqM2FRZEk2QjdmUCtlUk9H?=
 =?utf-8?B?WEpiMDlhaHhWMkhaU05jZ0pzSEcwUWZIV016WDhKM1NlRFJwNTFoWGZKV2Nn?=
 =?utf-8?B?OHBKNmhwQnJ2WDdSa0ZTQnp1ekF1WlllT1pEd3ZhZUc0MVZQNmlCR1pFc0pJ?=
 =?utf-8?B?ZURPemtGcUp0NWRDT1E2dHFWcFc1d1JTUHBpR0VFMDlIbE1PYjRSSlZIQ0w5?=
 =?utf-8?B?eWdhNU1iMUpaTVZmd2oyQlJCL0hFTXJ4a3ludFNSZWY5SGZqRHJ2cE94Z2Nv?=
 =?utf-8?B?UXl1YU8ySTM5N0R4RTRwZ1ZaamxkcGt3T2RxeXhsRi91REtWaFJDMjc2YzZo?=
 =?utf-8?B?cFN3QURWeWx3ZE1jeUlscDcxeDZNRjdDYUVRbVZkOUY4NEFwNVcybE1TMDR5?=
 =?utf-8?B?N3FoanV0Zm00bU45UkRra1FqbVhsMTJydUlBZDRHaXJ4OUVzV3dtL3JDWWdm?=
 =?utf-8?B?dXNUaWRmU3U1eHQ2SERYVVhuVFNkUmFEZDZTa1BrZHVnNytLcEdOT1owMjVa?=
 =?utf-8?B?akI0bkRGOWtzMHJLRDRsMjNTTzkvYjJNbUlkL0NSNkRENlpPU2RKQXlCTHdi?=
 =?utf-8?B?bVNhYnR1dXJoVkJyc3NYUzdTT3FlM1cvNUZMQ040QmxUa2I5aEFyZzZpVHdQ?=
 =?utf-8?B?V3lTcTRUb1NJdTlCb1FHc09RU3dwOUZ5Z2IrcEwwM0pGb0N5MlpUQndVa29t?=
 =?utf-8?B?aTRDbWZ6MHpyTHpzVW1UeG9lQkdLdzRsRVZZdzExQ1dPcXR6V3MzZ3RzYWQx?=
 =?utf-8?B?YjBHeHNrQnp5Q0RDWWNXZWE0ZE05M2kzYlBtZlNkblBXRXJRMWlpaGo4SDg2?=
 =?utf-8?B?b1JtcnBFcWl6VHR3dCtvc013VW5XaGdzQ1AyTGE2R1BUbXQ3a0FRMjVIUEUv?=
 =?utf-8?B?aDZvc0E2d3FzbFp3QmFGdEphUUJCUTQwbXV6cGQvdUtXZGNMOUtwQ0J1a2NP?=
 =?utf-8?B?Y0g2Q0Y1Nkh6MksvRUtNU0MxUktUWGVtVy8weTJMQ2FEblJPazdKOXhBeFo3?=
 =?utf-8?B?ZEgwd3hGUXVhVTlBVm9OODNjVkFkd2VtT2R6WHJON0srY1RIdmdFS1pZMkZm?=
 =?utf-8?B?bkl5YXdYNGc5bmhPRFBhTTk1cXlqdnZXaUVjckJqVW5hUFR3bkN1ZnFJaWx3?=
 =?utf-8?B?anR4NDRJbG5JYWJRUm9TdlRkVncvN2tyQ0Z2anFFZjN4RDJRS3VsbHpaRkpF?=
 =?utf-8?B?WVNqUmh0MVZVUURWUitMSFZVcEJEQmQyc3N1VDlQQ2tXc0NmSkhMMVgvMWM2?=
 =?utf-8?B?SVdGR0EwK1BJS1ZpNnZYVmRqYSs4Z2R1Z2o4MTVUcHhwWEFic1M0djFIZnRI?=
 =?utf-8?B?Vm5IWVFzMTd4ZERXV3gwalZNWGhGNVlIdnNmNGlXTUc2Z1RIZEo2K284R0dM?=
 =?utf-8?B?WXJacXBpcC9JemloWEFYOXRvcS9ROEV4NytOaHBhSkYycGZuY29NL2cvUnM3?=
 =?utf-8?B?S280Y3YyMjZnNWNyYk5iazFIS3JCenNvRnN0SEFnY2RrOEl1OXRDRTdIQzgr?=
 =?utf-8?B?T0JwbEdFV1RoRld3RW01SExrdFlGcU1YVk1RQkVoeXU0M3Z2c1NGcGI1emZR?=
 =?utf-8?B?QzRhUUQ5dXB0WUNMa2F4L3Q3cjZPbnNKS013anlvWjlpSDhEcDk1ZXJHVUpo?=
 =?utf-8?B?QVNTUzVBOTkvVGR1ZEdMRWpBTTh3a2NYN2JyNWFCdkU4YmJGbEdvNDlrWWRa?=
 =?utf-8?B?M0dCLzd0aTBPZE82bDZvZ2RwS1UwdkZ1Uk56N1E2bFcyNnRGQ3RTdjFHaE90?=
 =?utf-8?B?YjZVNmhLU2hxL3hrTHorZVU2Y3pHNmpZSjJZWUxERS9mWFQ1bmQ1czJWUGRx?=
 =?utf-8?B?VnZVQU9XS2h3eExLckJmRnEvalNLK1hMU3c1Y0JudzRnY29GWnJxS3ZKU3F0?=
 =?utf-8?B?cC9kcGpyWG96dDRLTzl2M08wL0szRHlJQ1JyNkx3S3Z1ejhTNHNBSzJScDZE?=
 =?utf-8?B?TzRMN1c0Tm9GOFlKVi9hc250SG5abXd0YzFwQ3hWcnRWUVVOQmhET05BVm4x?=
 =?utf-8?B?Tm13MURBOEFRaENlemJjN2lrQkxSdGRqZnNnbVdPZDNoeVo3ZkF3dStva05o?=
 =?utf-8?B?M3pZZnZ1TGdlQllCVnl1THdmbGVuTzVySDhiT2RCcVpBakxoM2xoNlhsZUNS?=
 =?utf-8?B?N0NtYVM2U1ZWd0FaRHRlRFZQZUcxM0xVSCtMRVJ0RU1sUGFad0pCSUVEUm9u?=
 =?utf-8?B?WjVhL1BjQlk0VUZlcnBmOXM5SkNDMUlDRGhQd2FjaVFCVzNyRUFORGFwR3Ni?=
 =?utf-8?B?bVZsRXp0aXBkdlZJOUJQVnlJRjA0enYra2Y1L2hiZUFHVzBTNFJtV3NTWk0z?=
 =?utf-8?B?algvK3drUmxXWjFiQi9uMEdDOHBYTHliR1FhT3dvcUVMcytMVDBidz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccbd657-0a28-440b-4c75-08df345bafed
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 18:54:10.9394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tml8D6RfaBmEBF3N+Fs+Uxr+D95BeeZe0aIVvVDWWyC1N4I3VVOA9ckc8J7WBlkQT6PXfdmDYHOh8lJKTy5qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/27/2026 2:33 AM, Lazar, Lijo wrote:
>
>
> On 27-Oct-26 4:29 AM, Mukul Joshi wrote:
>> In UALink loopback mode a single GPU acts as both the exporter and the
>> importer, so the sender accel ID of a message depends on its direction.
>>
>> - Send HELLO as the opposite role of the destination: a message to the
>>    exporter is sent as the importer and vice versa. Outside loopback
>>    this is still the GPU's own accel ID.
>>
>> - The MPNHT FW stamps the IH cookie of every HW-delivered message with
>>    the GPU ID of the single physical station, the exporter. The only HW
>>    path is importer -> exporter, so attribute these messages to the
>>    importer. SW-emulated exporter -> importer messages carry no IH ring
>>    and already name the exporter as the sender.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index e40433bd79df..233ca804c4cf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -1133,6 +1133,23 @@ static inline u32 ualink_imp_accel_id(struct
>> amdgpu_device *adev)
>>       return adev->ualink.info->ppod.accel_id;
>>   }
>>   +/*
>> + * amdgpu_ualink_local_sender_accel_id - sender accel_id for an
>> outgoing message
>> + *
>> + * Normally a GPU sends messages as its own (single) accelerator. In
>> loopback
>> + * mode the same GPU plays both roles, so the sender identity
>> depends on the
>> + * destination: a message to the exporter is sent as the importer
>> and vice
>> + * versa. Outside loopback both roles collapse to the GPU's own
>> accel_id.
>> + */
>> +static u32 amdgpu_ualink_local_sender_accel_id(struct amdgpu_device
>> *adev,
>> +                           u32 remote_acc_id)
>> +{
>> +    if (remote_acc_id == ualink_exp_accel_id(adev))
>
> Better keep additional check of loopback mode enabled.
>
>> +        return ualink_imp_accel_id(adev);
>> +
>> +    return ualink_exp_accel_id(adev);
>> +}
>> +
>>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>>                        u32 accel_id)
>>   {
>> @@ -2250,7 +2267,10 @@ static int amdgpu_ualink_send_hello_msg(struct
>> amdgpu_device *adev,
>>         dw0 = AMDGPU_UALINK_HELLO_MSG;
>>       dw0 |= (remote_acc_id <<
>> AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
>> -    dw0 |= (adev->ualink.info->ppod.accel_id <<
>> +    /* In loopback the sender is the opposite role of the
>> destination, so
>> +     * the exporter side tracks the connection under the importer
>> accel_id.
>> +     */
>> +    dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
>>           AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
>>         dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote
>> AccId:%u\n",
>> @@ -6557,6 +6577,16 @@ static int amdgpu_ualink_process_irq(struct
>> amdgpu_device *adev,
>>           return handled;
>>       }
>>   +    /* UALink loopback: the MP nHT stamps every HW-delivered
>> message with
>> +     * the GPU ID of the single physical station, the exporter. The
>> only
>> +     * HW path is importer -> exporter, so the real sender is the
>> importer.
>> +     * SW-emulated exporter -> importer messages carry no IH ring and
>> +     * already name the exporter as sender.
>> +     */
>> +    if (adev->ualink.loopback.enabled && entry->ih &&
>> +        src_acc_id == adev->ualink.loopback.exporter_accel_id)
>> +        src_acc_id = adev->ualink.loopback.importer_accel_id;
>
> Consider using the ualink_exp_accel_id/ualink_imp_accel_id wrappers.
>
ACK. Updated in the next revision.

Thanks,

Mukul

> Thanks,
> Lijo
>> +
>>       msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
>>       local_acc_id = adev->ualink.info->ppod.accel_id;
>>       dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
>
