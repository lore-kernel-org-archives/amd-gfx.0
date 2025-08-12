Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539F9C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 09:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C8110E5D2;
	Tue, 12 Aug 2025 09:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XNT2l2c/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 823A810E5D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 09:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUdiZsP3985HmTez6XO/6FH1FK58q0lT4eGUnz8xuZJlqph2i9qMptooo0pyziwybQKut0ZFpVXdGNERfBLlWTbtilPI+mL7aTYCRe8U2wUqazAQOLzLKnCEfFFwHMr7XwHYrMhScXM/i1XqUaBU1tnWIar61L1V8oQty/61vYc2Z6/HCs5DuuaTj40tIh5rsZCDWQuhDGevWdTmUbfT3X7eXsZaymRufmduDyh0pxPJs2MjOy6/1fgmZt2X9XPU6hz4YL0qTzmGvcSdxq/n+SsC/TpkHX3cndOfYtQvErTks17FCkZuEL3d/8f0CN4i5hlbj/VxLvF7sGfxGsPfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTwoR6vektjpngiOTXPfbfd1pK0g2W5IdlTf2GWypxE=;
 b=OhSdY4sEr0v9a3xJ+L2wDtZFpi6is0vLG9uI0LUwvPVOtkLNofO3KLW0U4ccAosF0oD2pvgX+74tZ4aOGnQH/F55Vs4IE3pgMDBvWggiedOazqbud8P0cPV8fPmmLh/Xau6nR0IBcYR1HLL1Be7pkY6IxERR6TPf0ReNy6pD4C4APrGTt+W6I7y8Kr71jVfjvKcqQf6lqrbT6FPgxtcKunxQC8AS5gG19E4s2KikUTABVZN1IaE9Wj1y6jm3/opX1NJFUXRu88KoVU9xsRSXRolAIa6dpx1100zUOPgz6rqDJF3C8p3fk6Bx55isMr0k9Fu8JPiJ5IfaPK48O1aGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTwoR6vektjpngiOTXPfbfd1pK0g2W5IdlTf2GWypxE=;
 b=XNT2l2c/pX4LG3wMuTmjXecBii0MIFkV3yTbPrKnsQjjW+UTm8pgsiyya0KeNUHDcVcMCn0Rmz0xdTncxg8av3/FjJmjiMHawVnigU2t9ZtzhjkouSVq8B0f0D+H4dZdQcfqmWAuW5dlioXSSmkphIHpj0yneLCrwDqnFHmfWtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 09:25:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 09:25:58 +0000
Message-ID: <c8bad014-3b8b-4165-9ecd-ce7cb0d1bc60@amd.com>
Date: Tue, 12 Aug 2025 11:25:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] drm/amdgpu: Add mapping info option for GEM_OP
 ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, David.YatSin@amd.com, Chris.Freehill@amd.com,
 dcostantino@meta.com, sruffell@meta.com, mripard@kernel.org,
 tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250811150536.3394262-1-David.Francis@amd.com>
 <20250811150536.3394262-3-David.Francis@amd.com>
 <8c77c6e2-5c95-4c19-af28-4d3646a89215@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8c77c6e2-5c95-4c19-af28-4d3646a89215@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dde07e8-d0e3-4f28-8ab0-08ddd9823eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1dYdUdmS2VzeGRGeHZoME9PK3BKZjlQL0ZsUjRtUFVhM3ZLRzFubWhMZVdk?=
 =?utf-8?B?WHBxN1RBNXh3Y3lyLzFQNVc2bndYR29xd2ZsKzI2RGxlRTFhaFRRRkh3ckNu?=
 =?utf-8?B?eTh6SU42ZzdOVjUwNW1aYmtXakcrbTdGRThqREZHcHlhRjlJUXE3NUhtY2Nu?=
 =?utf-8?B?SmlBNEN1Y3BXcEJCSFNZT0hMaVUzZkFLb0NIQzRURnJSVVFpTUIzTTY3M2d3?=
 =?utf-8?B?QkdSOWJzWUtENkk3WjJYRFdRS3JpejlaQjB1MEwrVi9vNTZVYitKMWRCTEhi?=
 =?utf-8?B?NDRVYTMwVlFIQTQ0M0Y2OTk4ak9uTlA1ek11OTBZVGNsZ0EzUG83MlRuVGds?=
 =?utf-8?B?MGZ6TWE4V2NHankyZUNtSUV5RVdUT3NEUTNxT0VBZEhWYUxaTlY4MVpqbHJ5?=
 =?utf-8?B?WnVuazNqRmVuam5SUytqQWJxeHFDR0U3d1BPL2hUQXZybms1clpmN2xkMlFi?=
 =?utf-8?B?Wk85TGNIQjlMK1h5VWJKanBOeDdIR2JROUhlaEhaT3VmRXh4UFFJTnAxSDAr?=
 =?utf-8?B?WHk1K3BTNlBUMFpSM2tqeHhLTnN3T01PZjEwUWd3UUVZTDRTdHpiY0p6TGor?=
 =?utf-8?B?c3dpa0h0eHMyMURrSjdUYkJPakQxSFdiOVZPMThCQ0V6bGU3aHd0cFBZWVhn?=
 =?utf-8?B?a1pLYk1aMGcyeUl4b3JkelRIQWtmRks2SmdJc2JvNTc3OThTbGFhcHVJaGJN?=
 =?utf-8?B?UG9YTTZycTcwR3E3d1M4Ykk0dnVVTXZMUGw5VTlYKzFra20rbjZZQ2NDWGtI?=
 =?utf-8?B?L3JXR1ZFWEJNa3VLNkNxTnBCYnZSNUNteHo4cGhIc1hSUHF2dzN0VHRPMFVp?=
 =?utf-8?B?QWtBWkZPbHMrcDZFQkVzaDNjdU41eGJMSjBHN3VGVGJGaldzZGhKUVhEd2xK?=
 =?utf-8?B?OGViZ1l0RXh6ay9TeXBUa0hHUHlTRnd1ZUpjYkJ1QlplYWxER1VlTU44SUtn?=
 =?utf-8?B?KzVyYzFTVk1XMWZUa1c2NnFSbGYvUnd2Z1RuenZvSEhPMWd5MlpmUG5Vd2ZL?=
 =?utf-8?B?N09DQmdhVytSNk5XYWtpMlFFVmFxbDlaRDFRVWIvYjdUWW5NU3NYc0tKZGZP?=
 =?utf-8?B?VW9VWjgzUGhYUHRMYXhYWER0b2I2c2RUYjg1ZElyVmRZc04yaVI1QjlwbFIw?=
 =?utf-8?B?NllQTlBTaXdubTloUzRqTTlEcy9iOUhUb2Z6UVJITDRuM2RMNEQ5Q2xKV3gv?=
 =?utf-8?B?YSs2czZrM21sTFFPa0ZSOUIvSTlVRnpxZmVLNnBMRmxWR0poMTE4Zmk2Tk1z?=
 =?utf-8?B?RGJQUVlCaDJOckhHcE9WcWtzYndnRFpwRGlyQ0IrYTkvWnoxUExVMHJDWHQr?=
 =?utf-8?B?Y3VyTDRDdU5GQ1FvdisySUpUbE1tUktVL3U5UDRmZFBINmtuMVRNd0VtYVkw?=
 =?utf-8?B?cDN0ME9jRmpXQkpRNktlQUVMa1BxR0d2TUlyL0NXZm1TSlhLdnJTNGkwUjFj?=
 =?utf-8?B?cWlGRkc2S01KV0x3KzI4bUQ0eDJQNVorSW1RTml5SUNBRXB2NGFKY3h0bFYx?=
 =?utf-8?B?b3h6SmFKa0hkVFdMSzZ3ZGRlQ2w3c1pCQ2JmZFBNVVZPTWZkMDkxajduaVhE?=
 =?utf-8?B?ZFQvOUNPQ21Pb1V2dWVUMHRLeDZ4N0ZpbkZnUTNTM2o0aTRIeFREUnBjQkxz?=
 =?utf-8?B?ek9yWWx5S3Ntd1VKeXRtMzI3cUc4dVlXbXlZZWVFeDN3L0hKRmpJUjh2QTJr?=
 =?utf-8?B?dEgxNjFvcFVRa2F6THZkY1h6MWRCaWRBNDFiRmh6dmJYdjU3NDNGZWdyUEFH?=
 =?utf-8?B?aEZ2Ny9SZzBxQ0s0ZmNFaFI3SmpjaUY3azE4Mi9JVFNERDFVS05CUGNCOTdK?=
 =?utf-8?B?NDlFOWNBWXJiWk1EOUViWHNjVXN0a0hXQVQ1YWFXTGJhd1BWejY3YkNIQjVv?=
 =?utf-8?B?RjNVSjR4SUlPWnMyc0NnRW9JWGtJeVRwdThkVWJpdzBDa0lKRW1nUVhZUGIr?=
 =?utf-8?Q?wGiLwNO4MnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RTUG1TQ2tma2ozZ3FsdnFjbzdvOHhPVkNWVFkzMFpoRnpBR3pyS2xIbzFy?=
 =?utf-8?B?MlVLMnpiK21MQlRRT0pDYU8xemxWbHhSeTZTczZqL1drWDdYUXlsbi9QMVR6?=
 =?utf-8?B?UVc4OVpEdFhXR2J3VWg5SGZwSTRJUFpZV0U2Z2N6R0xJUHRvV3RDQmpudE5Y?=
 =?utf-8?B?L0dWWEthcEQ0NGN2M013eW9lRWtVRENsTkYxQURXUDV4UGJkWGZMMkVRaXJH?=
 =?utf-8?B?VHJHNHFFcU1vMy9OSytNWUxwcEh4MTA0L0NobEpTbjB1Z0FhRFIvODdyRFhW?=
 =?utf-8?B?a0JwcXg2ZytRMENpZEgwUzcyNnlVdnJkdTVtMis2ZnNrSUlyMWdhRjd4TjFu?=
 =?utf-8?B?Y0tWQW9kOU5jbmlvTm8yYkRzMzBXN0hxWkx5bGpxNG4yVlQxdmZEblZaWnNY?=
 =?utf-8?B?TW1ySXVtbW84T0ZiSU52SEhtUmxHS0h5RXIyaCtUSnlSYldwWU9xZ0EzdEht?=
 =?utf-8?B?dHhmSmR2S1k0L1kyRCtBVTU3RWxtZjRGdmtFWlhXSWtTbUZDZEtJWGwxSllR?=
 =?utf-8?B?dHByb0RiRUoxQUFKdDFmRzBVdVBRMmxsclQ3MFovUmtScS9lV0JnSzlJRlFV?=
 =?utf-8?B?TTgzTkE1UDc0Uld2WXNkdllSWUw1ZmMyTWxLV3hOaGlIekN6N2R0aUEySVFy?=
 =?utf-8?B?WDVQekxkNEloRnE2QUgvQ0JMaW1aWTlnZXdFNC9YWnNGV1VJWkxlZVVmSC9B?=
 =?utf-8?B?Z082a3hYN25lZXFMamdmeE5hWHBncFBENHM3THpxZmR1Qkk0eHB3cWg4VUIx?=
 =?utf-8?B?dmU5Y3Viend3WmZreVNBM0taS1ZyeGkxcno4eDRQNGFKM1U4em1rclVOMlFu?=
 =?utf-8?B?OFFNY1h5cXgxV1gveng0eE9BZkxVTXNYZXlNN0FldUtRZldJMVdLTjFHMkVE?=
 =?utf-8?B?d0RsdjFydXNEVDVFN0lXUUZLRWRtOHZnZ3hpTkFqN0FwbU52OHhDM0ppVmNw?=
 =?utf-8?B?elA1RXlmZ3pDRjZ5MUV6M1lCV0tNLzA0Lys0UWEzbEpmOUYrb09nSEdnSkts?=
 =?utf-8?B?a0xXV1pHYXNGSnJvanF3b2U3OGM3ZjZFWWlXUW9Gd0dKYW80bU16dGk5RC8y?=
 =?utf-8?B?R0FyNDNRWWRjdmR4MDNSTkNtN2FNSytwU0hNSk83R2QvSmFYMjNEZGkrUTNK?=
 =?utf-8?B?T0E3MTlyeVhORjh6SGtIMnRVeE5UUzNYaklqQlova0NXbk03VDhIcmNJemRw?=
 =?utf-8?B?S2d5NEhuNXMxcHhGeVVVcmFYaGdURzErRWdVejFIYy9zaVdZWkpGQWdRVDJK?=
 =?utf-8?B?SzN3UGxHT0J4ejVjUldPaGtBYjVRVEhaRDNVQmZuTEMzaVBHdFlJQVJCNHlx?=
 =?utf-8?B?K3dTMzVUWHJITjBJcnNURUdyYVpFV3dYdkpiY0g3QjdqQUZwTkIxR1E1clY2?=
 =?utf-8?B?a2syUDE1ZmpkdUdMZ0FOYWQ4d0ZLSmpxWFhJMTU1MDhWYm9UNWloMHQ2T0pY?=
 =?utf-8?B?YWhZczQyV1ZrSFpjWnhrek4yNEw1OGxLZzhseVVaYTdnRy8rVXB4YnI2UGZZ?=
 =?utf-8?B?STVzdy9YTTlEdGlEOEhKSGhsQ2ZPRG9tcW1wK1ozVyt6aW8vckliSkpzc1Y0?=
 =?utf-8?B?eEVUcXVVV1FBWEUweGdDK2tjaDI2UXl6czNmZEJiTHhNZUluVWx5cHV6N2pO?=
 =?utf-8?B?amlMRVZFbWdMZU5tZi90YzBVZ0Y3NGNBRXJrTitDWXZ6aXZKbkhrYUlqTUtG?=
 =?utf-8?B?Uk96U0lGczVhTy9ZU1pyL3pzWnZEYjREeVM1NU1WN0w4TlVWMWVxdHRrTVZn?=
 =?utf-8?B?eUY5V3NRT3AzYng4a3Rxd3huWHQ5WW5DMnJBTEtUalFyMEJ0RDR1K0s3ejNm?=
 =?utf-8?B?bEozQlFBcFE3d2NGVkwvalgwZWlhTW5SNnFEcUhGSjc0ekpKb01oVG1XWTZp?=
 =?utf-8?B?WXFFdnBWWXIwWWRZZUlNODNwRUJ6TzJDVExjOWJOZGkxVDN2NE12bFlkUXBn?=
 =?utf-8?B?MVZ3QkhtZ0VVeXlIRVdnZXhrT0lmZ1VlL0l3THQ1cDRaTWdIdGZLZ1duaWkz?=
 =?utf-8?B?V0xlbklYZ3A2YmVua0VvOWZHUTZ6R0RkMjhRZTRMQUpTbTBocUVjTytQUW00?=
 =?utf-8?B?MTZ4OVIzZ0FVOHZiN0hFbFVsWjNJQXlFVmIrdnlDTEM2NXhwTVdhc1Y4ODBt?=
 =?utf-8?Q?guVSzuOUDDYjPobO0OhsUpMYJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dde07e8-d0e3-4f28-8ab0-08ddd9823eee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:25:58.2798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3viGOImMSjLP1W/zSoZavlULokScw1f1rO8pu+M4ui+CS4sLEO2nOKv5F+ZpcQPE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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



On 12.08.25 11:20, Tvrtko Ursulin wrote:
> 
> On 11/08/2025 16:05, David Francis wrote:
>> Add new GEM_OP_IOCTL option GET_MAPPING_INFO, which
>> returns a list of mappings associated with a given bo, along with
>> their positions and offsets.
>>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 86 ++++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
>>   include/uapi/drm/amdgpu_drm.h           | 18 ++++++
>>   3 files changed, 108 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 3873d2c19b4b..1632460623b2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -885,7 +885,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>                   goto error;
>>           }
>>   -        r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
>> +        r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
> 
> Why is this new hunk related? Is it becase I asked what are the two reserved slots in amdgpu_gem_list_mappings() for? But that one remained so it is all unclear to me.

Yeah that looks like a bug to me. The change was most likely applied to the wrong code.



> 
>>           drm_exec_retry_on_contention(&exec);
>>           if (unlikely(r))
>>               goto error;
>> @@ -956,6 +956,86 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>       return r;
>>   }
>>   +/**
>> + * amdgpu_gem_list_mappings - get information about a buffer's mappings
>> + *
>> + * @gobj: gem object
>> + * @args: gem_op arguments
>> + * @fpriv: drm file pointer
>> + *
>> + * num_entries is set as an input to the size of the user-allocated array of
>> + * drm_amdgpu_gem_vm_bucket stored at args->value.
>> + * num_entries is sent back as output as the number of mappings the bo has.
>> + * If that number is larger than the size of the array, the ioctl must
>> + * be retried.
>> + *
>> + * Returns:
>> + * 0 for success, -errno for errors.
>> + */
>> +static int amdgpu_gem_list_mappings(struct drm_gem_object *gobj, struct amdgpu_fpriv *fpriv,
>> +                      struct drm_amdgpu_gem_op *args)
>> +{
>> +    struct amdgpu_vm *avm = &fpriv->vm;
>> +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
>> +    struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(avm, bo);
>> +    struct drm_amdgpu_gem_vm_bucket *vm_buckets;
>> +    struct amdgpu_bo_va_mapping *mapping;
>> +    struct drm_exec exec;
>> +    int num_mappings = 0;
>> +    int ret;
>> +
>> +    vm_buckets = kvcalloc(args->num_entries, sizeof(*vm_buckets), GFP_KERNEL);
>> +    if (!vm_buckets)
>> +        return -ENOMEM;
>> +
>> +    drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
>> +              DRM_EXEC_IGNORE_DUPLICATES, 0);
>> +    drm_exec_until_all_locked(&exec) {
>> +        if (gobj) {
>> +            ret = drm_exec_lock_obj(&exec, gobj);
>> +            drm_exec_retry_on_contention(&exec);
>> +            if (ret)
>> +                goto unlock_exec;
>> +        }
>> +
>> +        ret = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (ret)
>> +            goto unlock_exec;
>> +    }
>> +
>> +    amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
>> +        if (num_mappings < args->num_entries) {
>> +            vm_buckets[num_mappings].start = mapping->start;
>> +            vm_buckets[num_mappings].last = mapping->last;
>> +            vm_buckets[num_mappings].offset = mapping->offset;
>> +            vm_buckets[num_mappings].flags = mapping->flags;
>> +        }
>> +        num_mappings += 1;
>> +    }
>> +
>> +    amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
>> +        if (num_mappings < args->num_entries) {
>> +            vm_buckets[num_mappings].start = mapping->start;
>> +            vm_buckets[num_mappings].last = mapping->last;
>> +            vm_buckets[num_mappings].offset = mapping->offset;
>> +            vm_buckets[num_mappings].flags = mapping->flags;
>> +        }
>> +        num_mappings += 1;
>> +    }
>> +
>> +    if (num_mappings > 0 && num_mappings <= args->num_entries)
>> +        ret = copy_to_user(u64_to_user_ptr(args->value), vm_buckets, num_mappings * sizeof(*vm_buckets));
>> +
>> +    args->num_entries = num_mappings;
>> +
>> +unlock_exec:
>> +    drm_exec_fini(&exec);
>> +    kvfree(vm_buckets);
>> +
>> +    return ret;
>> +}
>> +
>>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>>               struct drm_file *filp)
>>   {
>> @@ -1022,6 +1102,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>>             amdgpu_bo_unreserve(robj);
>>           break;
>> +    case AMDGPU_GEM_OP_GET_MAPPING_INFO:
>> +        amdgpu_bo_unreserve(robj);
>> +        r = amdgpu_gem_list_mappings(gobj, filp->driver_priv, args);
>> +        break;
>>       default:
>>           amdgpu_bo_unreserve(robj);
>>           r = -EINVAL;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index f9549f6b3d1f..5a63ae490b0e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -668,4 +668,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>>                    struct amdgpu_vm *vm,
>>                    struct dma_fence **fence);
>>   +#define amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) \
>> +        list_for_each_entry(mapping, &bo_va->valids, list)
>> +#define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
>> +        list_for_each_entry(mapping, &bo_va->invalids, list)
>> +
>>   #endif
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 59b423883e91..7072959103e6 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
>>     #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO    0
>>   #define AMDGPU_GEM_OP_SET_PLACEMENT        1
>> +#define AMDGPU_GEM_OP_GET_MAPPING_INFO        2
>> +
>> +struct drm_amdgpu_gem_vm_bucket {
>> +    /* Start of mapping (in number of pages) */
>> +    __u64 start;
>> +
>> +    /* End of mapping (in number of pages) */
>> +    __u64 last;
>> +
>> +    /* Mapping offset */
>> +    __u64 offset;
>> +
>> +    /* flags needed to recreate mapping */
>> +    __u64 flags;
>> +};
>>     /* Sets or returns a value associated with a buffer. */
>>   struct drm_amdgpu_gem_op {
>> @@ -811,6 +826,9 @@ struct drm_amdgpu_gem_op {
>>       __u32    op;
>>       /** Input or return value */
>>       __u64    value;
>> +    /** For MAPPING_INFO op: number of mappings (in/out) */
>> +    __u32    num_entries;
>> +    __u32    padding;
> 
> I suppose uapi kerneldoc should explain the value field is also used for AMDGPU_GEM_OP_GET_MAPPING_INFO and for what.
> 
> Alternatively union could be used to self document it but not sure if that is acceptable for amdgpu_drm.h? Like:
> 
> struct drm_amdgpu_gem_op {
>     /** GEM object handle */
>     __u32    handle;
>     /** AMDGPU_GEM_OP_* */
>     __u32    op;
>     union {
>         /** Input or return value */
>         __u64    value;
> 
>         /** AMDGPU_GEM_OP_GET_MAPPING_INFO */
>         struct {
>             __u64 entries; /** Pointer to struct drm_amdgpu_gem_vm_bucket array (out) */
>             __u64 num_entries; /** Number of mappings (in/out) */
>         };
>     };
> };
> 
> Just a thought.

Na, that looks quite ugly I think.

Extending the structure at the end is perfectly supported, but with the union you need to be really careful not to mess things up.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>>   };
>>     #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT    (1 << 0)
> 

