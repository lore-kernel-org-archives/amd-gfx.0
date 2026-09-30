Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B53CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 07:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3DF910E247;
	Wed, 30 Sep 2026 07:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EV6B+EQh";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FAB10E247
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 07:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrdJyeJliq59aW+DbwWEzS6utiRq82JicGrhf/hTY/IeBKpK83UMMP3J/QwiptLLPYmx2iWtlA3ip+ratjYiKXqKCQmIideCMSS8KmWOtJ2rhkU9nJrtOdzbQnWDC8nmP1v+cT9eWpHS6FS4tGE+A8Rq+DkXaBbn2CbwKjoKo53qmoTb8WjA8os0WgJNcMqUsN+CfQOs/6DNzx7AlXVbYqCilRGHXRVI12msHmDMwGAzSDcU0PPsMzJgng2tNNX16UHh5K1IQP4m8AADpy4Bv5xyTRwUFVvyv/QmzCh4dDhd8SjFEAhldW49zeDBLdGylmJ3HzDzyZ/g2DO77noExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPAgZwZFcsaK0sgEhSgUC/4ynNPGQygazjw1/G7HKzY=;
 b=rWkhfHwpesfmbkQcvjZhOFR/Xx7NosvBOrmkOUz0G1FFUoHMDKE5iSGkGQKv/81lGDBuSYuYBvPL4Vpzu8i5I1F9lDogdxY57GODq2SuBi386iE7d//YTaYMlfLYoNjs0e6NrMx45AKeFm7CEtf5RfJblHow3EKJVxQQAijGFOYwtqpQqSkHniOBeQe97kgkjSNZL7yFakFATJfTX6xgl/1/qklVcyg1Ij+cds8TK4uJefKzzOJ6cLwxedOE9rZe8NDUcpFr0WY+nd+bcuoPSqCj8pggrWHCWVxL4OIrbq0UqayFCO/xmxixgRPSk6btorKwhWr5M6Qqi6Yt8/btVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPAgZwZFcsaK0sgEhSgUC/4ynNPGQygazjw1/G7HKzY=;
 b=EV6B+EQhOONHl2iFFHw3flpuU4ooNBWZze5kE9CZO3hcc7yyY68iSQUh3kwaE7mmP3dZ2uj0dgcX6sL5N/NAfXqnGkb6mH0gzlDZqc4Mxc0wXaA7Wn7dN3yZNTL+KMYUAego+dWkqAlBzLDW2+lYx6O/BtiPAMKS6DpKKdKLaxc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 07:56:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 07:56:12 +0000
Message-ID: <b0044123-7f6d-47d0-84a5-f305d4ae1193@amd.com>
Date: Wed, 30 Sep 2026 09:56:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Wang, Kevin" <Kevin.Wang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <6b086b84-deed-47ec-ab7f-8cc016ab519d@amd.com>
 <CY5PR12MB63696540D11FBBD268D9B7ECC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <a2f8757d-1566-4b8e-a606-e363221db6a1@amd.com>
 <CY5PR12MB63693EB274BB3A16097332AAC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <fa59606b-0860-4aaa-b6ce-ac037f73eab4@amd.com>
 <BN9PR12MB5211C24FDF238C2A748378DC938B2@BN9PR12MB5211.namprd12.prod.outlook.com>
 <CY5PR12MB63693C7F0614B19DC5CD525FC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <CY5PR12MB63692E6BAC9D9589354ED1B5C18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <0b83688d-d517-457e-b9f1-c62baa5d9087@amd.com>
 <CY5PR12MB6369078C22B4C31FD24EE9E1C18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY5PR12MB6369078C22B4C31FD24EE9E1C18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9f1a54-60f3-4f47-be0a-08df1ec84bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q0QhFsOF44rNKp8ypMWqsDV3MFzntytCrI30t98njTi0qoXK4nuKXiKZmgfHvziga4oF8TjEbOfT8tODIeRU2RWvyPJwNATTIvQMzEHZGL8frlZzF0RI3vM7cUlJ/xfZDmpPMqUvX6LdqtkSwZ2OZbeRi2Tuhc3hFF3Dhnlo9fmrhUkWt5K53GSLFrkpqaSySg+/D/kFy0ASrEX3kE+jODY/mlHGD9qciaxn7BOjfiF0PNjVnGLDO3eN5ih9F4BuMMMRR0vnF3bDKmz6TOBJWu/fMXEUn4y96mFGC5KPEYSxF4YotqaSHasnL8DKxH6nqSfEB4++XSO3Q5B73bxMpNW3Y5y5K+FvgcsbHAso6Ws2RO/DN+MIDG2Z8DkxQtkDp+l444mqalA9nXnTZKSoHLByFcVtCC5GZDNUZxlYHgwvT1r/b0TgyYWVHnpcDhA55RD5Q2HzRZWehxJCATt/ej1+uTb/xgkjf+AWhKAo0wUyf636JNvgiePBvho+nmHq05Db4ML5+yDkTCieyByFI1R5P/9zjEl9jPlPBdSpej3UdbrL74HUvnTI/JkvaM2As49QAHWk2yVuadBuxQGvMz3CLW91+fK2QgCnLMMaxX0ROK9VO1kLOT6geJlXVMrzF2tQNEK2+jxQBjMT17kX54Fyrujv+5TzjY4RC2kUu5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEVjMDl3SUg1MDV2OUYxRkgxZk9GakhxaGgyVWJYc05uRS9TcW52ME5wUS9E?=
 =?utf-8?B?RWxoQWRrNlFqbGNUUDNzbmNMbGg1U1loUnFEN282eGlIOEZLcjlTWU9DcFMr?=
 =?utf-8?B?T0loUXRjU2JrUUtoYjdKUEdUYU5jc21IVWV5NUpzVnJBU1BYR2dIZG5ZQWFl?=
 =?utf-8?B?TVNUOXUvRDlWMnc4Vmt5dzVoaktQVjdiMXY5QzI5eU51UnU0anUrVE40c29G?=
 =?utf-8?B?cWNuajJLVTJ5K2R1cUhGSTlyemlVcU96NTFobERIcmdaVUtxT2J2T2tyMkQ0?=
 =?utf-8?B?bXpqTWNIQnFrQnBQVjFyeVBHcktTS2plN1pqaUQ1Z0RQdWFsSWJ2NkJrQkxy?=
 =?utf-8?B?RFVuQmpNN21yUWVjRTJGN21PTnhsL2cxaXJEWEpWZU9HZmpmSGhmM1FaeHRx?=
 =?utf-8?B?SDZycVphenBqOVFlOGkxNS9uL1l3VkVjV1ZRSzhVcC9YVXdsVm5jV01US2xR?=
 =?utf-8?B?SERxWnNmQndHcDNmb2pFMDVEMXdBTDVORUE3YlZHdHduUEI4dzREMDVaS0Vh?=
 =?utf-8?B?Q2V4dWVHQUE0ZFpqK21LRmxpVmRQanFOSW9KVGQzcVQ4MGdURXNHdjBuVkF4?=
 =?utf-8?B?Uk81RXoyS2hXOGx1V3A5c3hEeEwvd0w1bU5vcnNNODhlTjlSZkxOdjdxUnY2?=
 =?utf-8?B?b2U1TWs3a0dvRGd1amJFWnpsZytsdUNlZ01qdUsrS0xUTVk1OFNHa0hVdy9Z?=
 =?utf-8?B?dHViOHp4aDBNZlpvQWdPd0lyMlR0RUdXL0pwV1M2TEpOZmxLSE9SemtDK3lX?=
 =?utf-8?B?WitORW9pUnFyRE5yV05HVUdwVHJiWXZKUEVieURmRFpVKzlTYjZ2M3gxQW5T?=
 =?utf-8?B?YnJhK0QyaU1OWmN0TVExMStTYkVsWEJsLzVGaUY5QXBTOWUyL0V1TnFSWVI0?=
 =?utf-8?B?TTVhNUsrRVI0UllqQjlsM3ZIakJKemxmM0RqSWdWdkZQb1NVdFlPTmNIV1ZW?=
 =?utf-8?B?RlRoSlUwSHFzZGdvd3R2b1hzK3BrRFJxUVMrd3hydTRReUNTUUwvN0owYm5D?=
 =?utf-8?B?dUJiV2NWZUZxbEN1OUwwNDc0TmlQeW9DMFFTMjYvT3BWNXNGbUxNM3NmVEdi?=
 =?utf-8?B?dXlkbnFNUUQ0dWRCWEY5Z3VuaEtTRFpXYUFUMGQxWVAzQTlUZUxZL2l6dzd4?=
 =?utf-8?B?V1FLOWZnQS9JRm96WDFUSVRJL3ZTSTdtTCtmN3BudDFpczNVekhpVnNrcU1U?=
 =?utf-8?B?eXoyaTRsY0w1cDJpekpKMzQvREJubHhKdlJDaDVEeG8wdEdNT0NrL0s2aDdW?=
 =?utf-8?B?K2Fac3IzSXp3TmlvTkUyYklxWEVHM1c1ckN4V2V4Rm5OMHRISTQ1ckEwOGJZ?=
 =?utf-8?B?K01uRUE5ajN1Q3FyaVg0cDc3SzJ6NjEzdVlmUjNBQUtObGZESHdtNW5OTmJ2?=
 =?utf-8?B?OGc2Q05zZFJsWTh5eEhPd2NmWlBtVDhSL2pyOW1Td1ROaWtkK3RmZWp3N1dQ?=
 =?utf-8?B?ZWozeW1kUnEzekdFUnRVZ25TdWpQMjk3NnpSSWtUd2V4b2Fqcm5QOGNZRE1h?=
 =?utf-8?B?ZEo4cS9NeEwxTnFrL05VTGtuRGU2SThTUDdxUk9ZcDVRekVnTU8xdUc3UjZC?=
 =?utf-8?B?OHVFbmczSFRFL0JBTHJpRG9janFUUjNtU0VwcFUwUlRUSnVsTVNPalVmQlYr?=
 =?utf-8?B?U016bEZCelF4NlhYTS9TZ2JoS2ZtMVBuK1pyWlYrY1ZFem1SYkJmczI2cnU1?=
 =?utf-8?B?NnphWWREMndtZjhneDNQVVRNTCtzYWJtRlJOU3kxUURVQU9WckZmbzV3cWEx?=
 =?utf-8?B?MG95aTh6REYzQnpUUUdwemVrRG5BNVp1dktJKzR1YVVQeDZFWFd6amM5UkJR?=
 =?utf-8?B?cWlIZVlVdXB0TlVWQ2lKVk1YU2JlUU9FcENoRjg5cUwraGxCeDhOd1R1c1FM?=
 =?utf-8?B?OUNYajRhVytsa0NWcmVyVnhFemRVUlRZOUpZaER1a1lvc2ZVcUF5c1ZEZklZ?=
 =?utf-8?B?aFBWajJnSVBEeVFkU0pIeEs0N1lyeWU5QmJ1VXFCNEpYa291SlVsVE5Db2lo?=
 =?utf-8?B?Sks3Uk5qR0dmNlV1cWdKcVU0WEpKRGQxdUU3c1ZQbC9RL2pRRTErSFNDZHJE?=
 =?utf-8?B?ODlXNjZtQW1mZWhybnl5TzlFayt6aTAwTDhKc2JIZENrejFRYVNQVGtJODAr?=
 =?utf-8?B?dSt2U1JDSnZsUWhqVUt0dWh2V0tZS1QvbkdHditFMXlVUS9sK3FTQy9HUTUx?=
 =?utf-8?B?akZnaGJ1dnNMRnN3VnRxTUVLQ1NOdlJQV0lwVXBzOVRTUmo3K3V5bHZRMlE2?=
 =?utf-8?B?bGJZQXNHdks4SGRGNkFxN2toaUlSRDZEbmJxTXdUVmVmV1hxUUpHaEJqSjNa?=
 =?utf-8?Q?ZgQ8M9uiE3yyaHEFh1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9f1a54-60f3-4f47-be0a-08df1ec84bf4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:56:12.8956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJ7aUIZ9jryA+1qRXHvyPKW5KyvYMT/ZuSKUceayUcDncKZ47FFqUnlSCFJWO/jM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008
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

If the SMU debug mail box register is the start of the mode 1 reset procedure and if that procedure requires that we stop VRAM and doorbell accesses then we need to do that *before* we do the SMU debug mail box write.

Everything else is racy and not something we can do upstream.

Regards,
Christian.

On 9/30/26 09:51, Zhang, Yifan wrote:
> AMD General
> 
> SMU debug mail box registers are accessed prior to disabling PCI_COMMAND_MEMORY, and PSP bootloader status are accessed after enabling PCI_COMMAND_MEMORY. There is no MMIO BAR access in b/w.
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, September 30, 2026 3:12 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Kevin <Kevin.Wang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yuan, Perry <Perry.Yuan@amd.com>
> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on gfx12
> 
> Well it doesn't matter who gets the request and what do we pool.
> 
> The real question is if that goes over the MMIO BAR or the PCIe config space.
> 
> If the SMU debug mailbox registers or PSP bootloader status is accessed over the MMIO BAR space then I agree with Lijo that the approach of disabling all MMIO BAR accesses won't work.
> 
> Regards,
> Christian.
> 
> On 9/30/26 08:35, Zhang, Yifan wrote:
>> AMD General
>>
>>
>> On Navi3x/Navi4x, the driver doesn't poll for a response. It sends the mode1 reset request through the SMU debug mailbox and waits a fixed interval (SMU13_MODE1_RESET_WAIT_TIME_IN_MS) for the reset to proceed. After that, it polls the PSP bootloader status and the memsize register to confirm the ASIC is out of reset. On ASICs where the regular SMU message path is used, the polled response only acknowledges the message; it doesn't indicate that the reset has completed.
>>
>>
>>
>> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
>> *Sent:* Wednesday, September 30, 2026 2:28 PM
>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; Wang, Kevin
>> <Kevin.Wang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com>
>> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> mode1 reset on gfx12
>>
>>
>>
>> AMD General
>>
>>
>>
>> The actual reset sequence is run by the FW while you are polling for the response. This patch doesn't make any sense in that way.
>>
>>
>>
>> Thanks,
>>
>> Lijo
>>
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------------------------------------------------------------------
>> ----------
>>
>> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
>> <mailto:Yifan1.Zhang@amd.com>>
>> *Sent:* Wednesday, 30 September 2026 11:47:46
>> *To:* Wang, Kevin <Kevin.Wang@amd.com <mailto:Kevin.Wang@amd.com>>;
>> Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; Deucher,
>> Alexander <Alexander.Deucher@amd.com
>> <mailto:Alexander.Deucher@amd.com>>; Koenig, Christian
>> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>;
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> mode1 reset on gfx12
>>
>>
>>
>> AMD General
>>
>> Yes. In addition, the polling happens inside smu_cmn_send_smc_msg(), which runs before PCI_COMMAND_MEMORY is cleared. During the mode1 reset process there should be no traffic to the PCIe BARs; otherwise, the PCI bus may hang.
>>
>> Also, every PCI config write in the patch targets only the GPU device itself (pci_write_config_dword is per device), so no other PCI devices are affected.
>>
>> -----Original Message-----
>> From: Wang, Kevin <Kevin.Wang@amd.com <mailto:Kevin.Wang@amd.com>>
>> Sent: Wednesday, September 30, 2026 2:09 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>;
>> Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>;
>> Deucher, Alexander <Alexander.Deucher@amd.com
>> <mailto:Alexander.Deucher@amd.com>>; Koenig, Christian
>> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>;
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
>> reset on gfx12
>>
>> AMD General
>>
>>> On a second look, the patch doesn't seem right. Reset sequence is
>>> supposed to be complete by the time FW responds back to the mode-1 reset message.
>>> During reset sequence, we need Mem space to be enabled to poll
>>> success status of the message and that's most volatile window during
>>> the whole sequence.
>>
>> That is not right. When the OS driver polls and sees the response register become "1", it does **NOT** mean the mode1 sequence is completed.
>> The PMFW will continue forward the message to PSP and wait for PMFW ucode reload to finish at a 2nd-half stage.
>>
>> Best Regards,
>> Kevin
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>>> <mailto:amd-gfx-bounces@lists.freedesktop.org>> On Behalf Of Lazar,
>>> Lijo
>>> Sent: Wednesday, September 30, 2026 1:41 PM
>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
>>> <mailto:Yifan1.Zhang@amd.com>>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>;
>>> Koenig, Christian <Christian.Koenig@amd.com
>>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>>> <mailto:amd-gfx@lists.freedesktop.org>
>>> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
>>> reset on gfx12
>>>
>>> On a second look, the patch doesn't seem right. Reset sequence is
>>> supposed to be complete by the time FW responds back to the mode-1 reset message.
>>> During reset sequence, we need Mem space to be enabled to poll
>>> success status of the message and that's most volatile window during
>>> the whole sequence.
>>>
>>> Disabling the memory space after reset sequence is complete looks to
>>> be the wrong diagnosis of the issue. Access during reinit sequence
>>> after reset is safe and shouldn't cause any issue in general.
>>>
>>> That said, we should try to resolve the issue without touching any
>>> PCI config settings. PCI config space is open for others as well.
>>>
>>> Thanks,
>>> Lijo
>>>
>>> On 30-Sep-26 10:57 AM, Zhang, Yifan wrote:
>>>> AMD General
>>>>
>>>> How about disable UE during mode1 reset ? E.g.
>>>>
>>>> Before:
>>>>          pcie_capability_read_word(pdev, PCI_EXP_DEVCTL,
>>>> &saved_devctl);
>>>>          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
>>>>                                     saved_devctl &
>>>> ~PCI_EXP_DEVCTL_URRE);
>>>>          pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>>>>                                        &saved_uemsk);
>>>>          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>>>>                                         saved_uemsk |
>>>> PCI_ERR_UNC_UNSUP);
>>>>
>>>>
>>>> After:
>>>>          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>>>>                                         saved_uemsk);
>>>>          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
>>>> saved_devctl);
>>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>>>> Sent: Wednesday, September 30, 2026 11:37 AM
>>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
>>>> <mailto:Yifan1.Zhang@amd.com>>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>;
>>>> Koenig, Christian <Christian.Koenig@amd.com
>>>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>>>> <mailto:amd-gfx@lists.freedesktop.org>
>>>> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>>>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>>>> mode1 reset on gfx12
>>>>
>>>>
>>>> This is the behaviour of this bit -
>>>>
>>>>          Memory Space Enable - Controls a Function's response to
>>>> Memory  Space accesses. When this bit is Clear, all received Memory
>>>> Space
>>> accesses are caused to be handled as "Unsupported Requests"
>>>>
>>>> On AER enabled systems, depending on how the platform is configured
>>>> to
>>> classify the severity of UR errors, that could result in System error.
>>>>
>>>> On other hand, if you are sure that there is no such access during
>>>> mode-1 reset, we don't need this patch in the first place.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>
>>>> On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:
>>>>> AMD General
>>>>>
>>>>> Hi Lijo,
>>>>>
>>>>> Why does clearing PCI_COMMAND_MEMORY cause AER errors on data
>>> center GPUs? Are their PCIe BARs still being accessed during a mode1 reset?
>>>>>
>>>>> Best Regards,
>>>>> Yifan
>>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>>>>> Sent: Wednesday, September 30, 2026 11:06 AM
>>>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
>>>>> <mailto:Yifan1.Zhang@amd.com>>; Deucher, Alexander
>>>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>;
>>>>> Koenig, Christian <Christian.Koenig@amd.com
>>>>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>>>>> <mailto:amd-gfx@lists.freedesktop.org>
>>>>> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>>>>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>>>>> mode1 reset on gfx12
>>>>>
>>>>> This doesn't work for all (at least on some datacenter GPUs). With
>>>>> AER
>>> enabled, this will result in AER errors. Depending on the platform
>>> config, some may classify this access as fatal.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>> On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:
>>>>>> Public
>>>>>>
>>>>>>
>>>>>> Hi Alex,
>>>>>>
>>>>>> I think it is reasonable to apply the patch to all ASICs. I will
>>>>>> sync with the hardware team about this change; so far we have
>>>>>> only tested it on Navi31.
>>>>>>
>>>>>> How about adding a common helper and calling it from
>>>>>> ASIC-specific code, starting with Navi31? For example:
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_device.c
>>>>>>
>>>>>> index b690a07e31ab..075de681ab86 100644
>>>>>>
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>
>>>>>> @@ -4931,6 +4931,28 @@ bool
>>> amdgpu_device_should_recover_gpu(struct
>>>>>> amdgpu_device *adev)
>>>>>>
>>>>>>                    return false;
>>>>>>
>>>>>> }
>>>>>>
>>>>>> +void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
>>>>>>
>>>>>> +                                   unsigned int delay_ms)
>>>>>>
>>>>>> +{
>>>>>>
>>>>>> +       u16 saved_cmd, cmd;
>>>>>>
>>>>>> +
>>>>>>
>>>>>> +       pci_read_config_word(adev->pdev, PCI_COMMAND,
>>>>>> +&saved_cmd);
>>>>>>
>>>>>> +       cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
>>>>>>
>>>>>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>>>>>>
>>>>>> +
>>>>>>
>>>>>> +       msleep(delay_ms);
>>>>>>
>>>>>> +
>>>>>>
>>>>>> +       pci_write_config_word(adev->pdev, PCI_COMMAND,
>>>>>> +saved_cmd);
>>>>>>
>>>>>> +}
>>>>>>
>>>>>> +
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>>> b/drivers/ gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>>>
>>>>>> index b250c5e41e45..356e09b7eef9 100644
>>>>>>
>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>>>
>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>>>
>>>>>> @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct
>>> smu_context
>>>>>> *smu)
>>>>>>
>>>>>>            ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset,
>>>>>> NULL);
>>>>>>
>>>>>>            if (!ret)
>>>>>>
>>>>>> -               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>>>>>>
>>>>>> +               amdgpu_device_mode1_reset_wait(smu->adev,
>>>>>>
>>>>>> +
>>>>>> SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>>>>>>
>>>>>>            return ret;
>>>>>>
>>>>>> }
>>>>>>
>>>>>> Best Regards,
>>>>>>
>>>>>> Yifan
>>>>>>
>>>>>> *From:*Deucher, Alexander <Alexander.Deucher@amd.com
>>>>>> <mailto:Alexander.Deucher@amd.com>>
>>>>>> *Sent:* Wednesday, September 30, 2026 2:59 AM
>>>>>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com
>>>>>> <mailto:Yifan1.Zhang@amd.com>>; Koenig, Christian
>>>>>> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>;
>>>>>> amd-gfx@lists.freedesktop.org
>>>>>> <mailto:amd-gfx@lists.freedesktop.org>
>>>>>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com
>>>>>> <mailto:Perry.Yuan@amd.com>>
>>>>>> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>>>>>> mode1 reset on gfx12
>>>>>>
>>>>>> Public
>>>>>>
>>>>>> I think this should be asic agnostic.  Any asic doing mode1 reset
>>>>>> should do this?
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>> -----------------------------------------------------------------
>>>>>> -
>>>>>> --
>>>>>> -
>>>>>> -
>>>>>> --
>>>>>>
>>>>>> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
>> <mailto:Yifan1.Zhang@amd.com%0b>> >>> <mailto:Yifan1.Zhang@amd.com
>> <mailto:Yifan1.Zhang@amd.com>>>
>>>>>> *Sent:* Tuesday, September 29, 2026 5:36 AM
>>>>>> *To:* Koenig, Christian <Christian.Koenig@amd.com
>> <mailto:Christian.Koenig@amd.com%0b>> >>>
>> <mailto:Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>>;
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>>>>>> <mailto:amd-gfx@lists.freedesktop.org
>>>>>> <mailto:amd-gfx@lists.freedesktop.org>>
>>>>>> <amd-gfx@lists.freedesktop.org
>> <mailto:amd-gfx@lists.freedesktop.org%0b>> >>>
>> <mailto:amd-gfx@lists.freedesktop.org
>> <mailto:amd-gfx@lists.freedesktop.org>>>
>>>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
>> <mailto:Alexander.Deucher@amd.com%0b>> >>>
>> <mailto:Alexander.Deucher@amd.com
>> <mailto:Alexander.Deucher@amd.com>>>; Yuan, Perry
>>> <Perry.Yuan@amd.com
>> <mailto:Perry.Yuan@amd.com%0b>> >>> <mailto:Perry.Yuan@amd.com
>> <mailto:Perry.Yuan@amd.com>>>
>>>>>> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
>>>>>> mode1 reset on gfx12
>>>>>>
>>>>>> Public
>>>>>>
>>>>>> Hi Christian,
>>>>>>
>>>>>> The no_hw_access flag was first set in commit
>>>>>> 0de604d0357d0d22cbf03af1077d174b641707b6. This was intended to
>>>>>> fix the Mode 1 reset hang, but it proved insufficient.
>>>>>> I think the flag was set in the SMU code so that it would apply
>>>>>> only to
>>>>>> SMU13/14 ASICs, without affecting the Mode 1 reset process on
>>>>>> other
>>> ASICs.
>>>>>> I'm not sure whether we can drop the no_hw_access flag after
>>>>>> disabling PCI_COMMAND_MEMORY. The PCI hang occurs intermittently,
>>> so
>>>>>> we may need another round of stress testing to confirm that the
>>>>>> flag is no longer needed. Should we remove no_hw_access in a
>>>>>> separate
>>> patch?
>>>>>>
>>>>>> Best Regards,
>>>>>> Yifan
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com
>> <mailto:Christian.Koenig@amd.com%0b>> >>>
>> <mailto:Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>>
>>>>>> Sent: Tuesday, September 29, 2026 5:06 PM
>>>>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
>> <mailto:Yifan1.Zhang@amd.com%0b>> >>> <mailto:Yifan1.Zhang@amd.com
>> <mailto:Yifan1.Zhang@amd.com>>>; amd-gfx@lists.freedesktop.org
>> <mailto:amd-gfx@lists.freedesktop.org>
>>>>>> <mailto:amd-gfx@lists.freedesktop.org
>>>>>> <mailto:amd-gfx@lists.freedesktop.org>>
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com
>> <mailto:Alexander.Deucher@amd.com%0b>> >>>
>> <mailto:Alexander.Deucher@amd.com
>> <mailto:Alexander.Deucher@amd.com>>>; Yuan, Perry
>>> <Perry.Yuan@amd.com
>> <mailto:Perry.Yuan@amd.com%0b>> >>> <mailto:Perry.Yuan@amd.com
>> <mailto:Perry.Yuan@amd.com>>>
>>>>>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>>>>>> mode1 reset on gfx12
>>>>>>
>>>>>> On 9/29/26 04:25, Yifan Zhang wrote:
>>>>>>> block GPU PCI bar access during mode1 reset on gfx12, to resolve
>>>>>>> the random mode1 reset hang issue.
>>>>>>
>>>>>> Interesting idea, that is much simpler than trying to mess with
>>>>>> CPU page tables in the GPU reset path.
>>>>>>
>>>>>> The only downside I can see is that we now drop VRAM and doorbell
>>>>>> writes, but I think that won't matter since VRAM is lost by a
>>>>>> mode1 reset anyway.
>>>>>>
>>>>>> MMIO writes are dropped as well which means that we can also drop
>>>>>> the no_hw_access flag.
>>>>>>
>>>>>> And BTW the SMU code should absolutely *NOT* touch that
>>> no_hw_access
>>>>>> flag in any way. Who added that there?
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
>> <mailto:yifan1.zhang@amd.com%0b>> >>>> <mailto:yifan1.zhang@amd.com
>> <mailto:yifan1.zhang@amd.com>>>
>>>>>>> ---
>>>>>>>    .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
>>>>>>> ++++++++++++-------
>>>>>>>    1 file changed, 19 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>>>>>> index 072d9c4e202d..25b9085ead71 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>>>>>> @@ -2078,21 +2078,30 @@ static int
>>>>>>> smu_v14_0_2_set_df_cstate(struct smu_context *smu,
>>>>>>>
>>>>>>>    static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
>>>>>>> {
>>>>>>> +     struct amdgpu_device *adev = smu->adev;
>>>>>>> +     u16 saved_cmd, cmd;
>>>>>>>         int ret = 0;
>>>>>>>
>>>>>>>         ret = smu_cmn_send_debug_smc_msg(smu,
>>> DEBUGSMC_MSG_Mode1Reset);
>>>>>>> -     if (!ret) {
>>>>>>> -             if (amdgpu_emu_mode == 1) {
>>>>>>> -                     msleep(50000);
>>>>>>> -             } else {
>>>>>>> -                     /* disable mmio access while doing mode 1
>>>>>>> reset*/
>>>>>>> -                     smu->adev->no_hw_access = true;
>>>>>>> -                     /* ensure no_hw_access is globally visible
>>>>>>> before any MMIO */
>>>>>>> -                     smp_mb();
>>>>>>> -                     msleep(1000);
>>>>>>> -             }
>>>>>>> +     if (ret)
>>>>>>> +             return ret;
>>>>>>> +
>>>>>>> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
>>>>>>> +     cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
>>>>>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>>>>>>> +
>>>>>>> +     if (amdgpu_emu_mode == 1) {
>>>>>>> +             msleep(50000);
>>>>>>> +     } else {
>>>>>>> +             /* disable mmio access while doing mode 1 reset*/
>>>>>>> +             smu->adev->no_hw_access = true;
>>>>>>> +             /* ensure no_hw_access is globally visible before
>>>>>>> +any MMIO */
>>>>>>> +             smp_mb();
>>>>>>> +             msleep(1000);
>>>>>>>         }
>>>>>>>
>>>>>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
>>>>>>> +
>>>>>>>         return ret;
>>>>>>>    }
>>>>>>>
>>>>>>
>>>>>
>>>>
>>
> 

