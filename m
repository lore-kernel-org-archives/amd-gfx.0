Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D765C54ED1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 14:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F16610E804;
	Fri, 23 May 2025 14:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LR9KbRVt";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9990510E7F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 14:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuKJBHXgpaUmQszC6d9ForV0M+OIY0CaOam5QGJcPXlB+fT7PXrwSdjL0iGOS06eITbFY5rfGpUHpjDQJWScMcsuEs4q691cu6VtLSaOCu3l1aW9MwZmIc64RB9mRJlvII5jKuHlcsL/6atlAof73MbGDdaVGeltq535JTYfvvZeb6qI2FDnZXTOM9b3bUmDfAG8sTTvxTIH/XOO/H50eyAIdnC09DUIkCSamWIRouoc850fdJqXEab9RBGtcqLqpJqoVS5F0Z9CMvTrJqd+oPmEuh5AuxqNF91CfKQ9NKOGmrr19OTRW/uLz6ryYTFXEHr1+JkIuIO7PcmxicjdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai45zGGMTLsG1akfquzwjBrQsrkzYpanlCW4kAZXwH8=;
 b=JcHc1X7XhS79+e3B8PC7kNR3POlAKPa0J2c0ZtBQrPmcdC77H3OFfmOAD7WHebydGViUaXW3Ri2j0f0KlFduGDkO1rKo7KrO3weYjjKNeC/nkfKb4cs25A1cRV6dnuvQUbq5I/rMc//E4Q3u2yjzt0LhB21b1RoXbDWCNZv8eIlUjms/GSGUyT3SKkqUFLdq6rLWnQjnt8GicWJOBHekBAaLFJ5WMX+hU+U2Hf05ZGhSr8Yl5mR4QvKAhZ6rjcOXTrspLGwnylNlaMy8bihZ0IXZdSeMPKJ/FP3jqZKkv8B0JBNu73xEenw9X6HlwmTugRXttGAROtFmngtfloAQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ai45zGGMTLsG1akfquzwjBrQsrkzYpanlCW4kAZXwH8=;
 b=LR9KbRVtl4Fjq/AL8awVeZ9XcXqC0K33q33QwvaajhjJcIq9SVCf7GaP1oz4Y8jW+a62GGQRPSbfzUXPOEAq2CRe4HGd6v+FgcC86mhEhgvUO9wIbQnVJo5CKMhD+rXiiTlYPfsWlop42RdM0B8TzXA++4lbca/WDu20yNhVPA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Fri, 23 May
 2025 14:03:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 14:03:28 +0000
Message-ID: <5899d56f-44ee-4ed0-af91-55889296e249@amd.com>
Date: Fri, 23 May 2025 16:03:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/10] Reset improvements for GC10+
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <CADnq5_MYYR4c8_QW0jo=Gd7w3dnkCFXpgDZAxnSEuhmRpwqZyw@mail.gmail.com>
 <c859107d-c09c-404c-8021-75ad3df7d54f@amd.com>
 <CADnq5_OWWUjaKXnwugo1-mpYOp9pdpk0pjgD8_sb5QNJOCMZSA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OWWUjaKXnwugo1-mpYOp9pdpk0pjgD8_sb5QNJOCMZSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: b42b9694-bf40-4995-4cff-08dd9a0297a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TllDTXRxQ3VwS1B3ZVB5VUdFdHlYWlppNEY5aVdVb25aV1RlRDFudU5OeC85?=
 =?utf-8?B?MC9ucTluMjFuMnBiUnJOQW5oeEdMMnhsZ3VyTnc3QVNBenV1VXVKMXUrdnNy?=
 =?utf-8?B?UXI5aXNaM2cxeGhoMTBZZ3NJejhQck5EUVgyUjkyaWNWRitlVjI1Zzh4LzFn?=
 =?utf-8?B?VTczY0syVUh4WExKbGtOM0RKanBxZnpkNVR0ZU9SSHBsMldxSDJ5cTVnUldD?=
 =?utf-8?B?a29HRVZOZkxtYTdSYmZiU3JHaURvUGdhREhaQWFNNy9LUm5QV3ROSEcvWVBD?=
 =?utf-8?B?MnNadXR2aXZIVGd6cDNCQ2drYlVlMDBQdmlXWGxkWEJocHNBaFpWb1VTM0Jq?=
 =?utf-8?B?MGhhZlVLdG1CNWxDeGxmOUlJTVdOTytlejZ6WUV4MEllaEhCanFyVjZ2NVRt?=
 =?utf-8?B?VnFkaGJXVno1UUJrUGNEcVZrbmx6TzlCQVhKWFlEcnpZSUZld0pGSU41aTRW?=
 =?utf-8?B?cGIxVnRpZFJWYzNzYlh5VjVWZzRoRENWMTNyZDlGSWN0RExSYkk2eGNGWXo4?=
 =?utf-8?B?MXBVem1IdjZYMmZCWm16bWlZWXFnSXJrdi9oSjlZZG1TTW9yMVc0OGE1QUNx?=
 =?utf-8?B?RUYzdmQ2dTZGVzRsS2Y5Uk5nTkU5VWpmWEFpbG1mZ2dGWC9QSmh5MU52Um5n?=
 =?utf-8?B?VkcyQlp0MG1BZENncnNLOXRJWnZxRTBIcllVQ2xrc2l5ZHhJbUhxdTBxc2NW?=
 =?utf-8?B?R2ZRWXNvUTE2M2lTYkFKM1VRQVJ0emRSN0xMZm5vVytsRnlDSUYwUGdCZGh2?=
 =?utf-8?B?TWs4Nm4xeW5zV0lzS2FCU2Z1dGxQZXQxKzNsb3VhOW13aWoxdUZnTHNoTnRN?=
 =?utf-8?B?QmR2c2lKMkNTWTFQS1F6dFFuanhNd1p4NTd1OEhOWnE1ZFU0UFl0VWg3TlFP?=
 =?utf-8?B?UURpbTJGM2VmQSs5WW9RcDYvWVg3OGM3Z2tpS0JHdXpqU2Y4ZGZMQU5ndWZs?=
 =?utf-8?B?akdiNlVyb0wvU0NlT2ZKRGJncjM3K2xlVU41VW9zdS9UaXprQW1sVFUreE4y?=
 =?utf-8?B?c29uM1VNTTN3Tlp6YXJaM0lLZGljNncvL1F2TzlzVk5rbWVFTGVrbE9waG03?=
 =?utf-8?B?dU9aNWtCanE0ekhaYkFYZTgyZ3YvV1lONFd2SnJRRThXVVZwYUlEcVIwMWlT?=
 =?utf-8?B?K2lpaXpaVjFNOHJuYnBYbnZ6RzJrM09ZVVVUc0NpZHBUeVN3eFM3Q09Xdk5m?=
 =?utf-8?B?UVRvVzI0MGcyRkNOYzFMdzEvdVFrODRRLzVLSWhNMFEyaWNyUkJSQWcya1Zy?=
 =?utf-8?B?Vm1oRWVXcUxlYWM5OElaaVl3WHJYSXZNOFBudXVJMlMyV0pCNEgyWWJJNEdM?=
 =?utf-8?B?VG9uTC9rVTZRNWNodGpNZi9sODVWOC82QitVQzFyVkdRZXJnK1RPN21VaWdq?=
 =?utf-8?B?UjVsSC81WVhmR1dqR2dPV1BlUEN5VnJ4MFI2VEJIRUx3Yms3TlNoRS9jUlM4?=
 =?utf-8?B?d3RRcy91djMyWm0wNlhxa3Z2bnpnM1dCR0Vjb2d3eDRyNW1Zd3EvWllQQVR1?=
 =?utf-8?B?Tnh3ZDZiaWJLb1RjcC9lN21IQWhUS0RCUjNjNWpJa3FiYnd5andaWkZBY0Ns?=
 =?utf-8?B?RWs4TjhKTEtWeU1zYUNDUCszMHVUTDBlOTUwS0Q4cy9raFFuWVg0ZFkvRm55?=
 =?utf-8?B?dnBadUtqdkc4L2d2QUY5ZlpQZDFEL2lnREdHU0xUOHBXYzVFR21Jd3dEdjNx?=
 =?utf-8?B?TVg0NHJQTnpBQjc0dzdSRjRndjk4ZHJ1Z0x2QmZ2aWs5bTArY3JsZ3B3RDVT?=
 =?utf-8?B?ZHgvQWQzVEppWkpHdnJZL0dJYk5JSXZ5Z0FxdlN4RmF6N3owTm5qaU1uVUpW?=
 =?utf-8?B?aFJLVmhWUmphdzRwdFkxZVAyYmtZRWRPSGljOEFUczlTTVorMzJHOWdETDZn?=
 =?utf-8?B?UU1uYlgyd1ZEY21pUXkwZGRtcGhlUzhwVGdhVGQ1eFVEaFBpQzRJZUFVaTJS?=
 =?utf-8?Q?j0dn4rafyRg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWdXZ3lVcFQyWGFZbHFWb09Bc25takMyMTBObkhBN2pUKytaWGhaMVR1em5q?=
 =?utf-8?B?TmFnRGZYeGNFSmExODZVQzRhVmRPcDI5T1QxVHpPNHV6enFlM2FpVjUzNFNN?=
 =?utf-8?B?MnFoamtTYzNkeHl6VHFMdmcwNU5XRHIveklnWDVadEVNMGNzK2doek41b1FS?=
 =?utf-8?B?bXVzSHVid3J6Z3V0NnZqYmNBVnNjRmF0NnNmamR6SUZadVpUUHdMZlAxVi9K?=
 =?utf-8?B?cTlKN0ZZMTU5clFXYVVSd1pMWjN2QzBTNXlyRlhuSlJFb3VzbldKQ05ZVEhy?=
 =?utf-8?B?VVhvZFVkbnp1TGVoNlhNNFQrcXl1elBMbmxhdjlWS2U5VEVNQWdVSVdFVjEr?=
 =?utf-8?B?NjV1WEYxaDYxTFNIOXpqcElwSzZ2anVOeTE1Nll2TXVFVnMxK1p5Uk9xdkZL?=
 =?utf-8?B?OURQUTRzemErQlFySGpQOEhKNEZucmhKS0kyZ1NMNk1oNEM4VkxSbG93SmlK?=
 =?utf-8?B?a1Q4bG1oY1grS2JacTFiQ3JzbThtTWpwRm1jekVMQmxzTk0vTElDU1hSZFB1?=
 =?utf-8?B?SDhpUHhWZURXS1oyOE5BT3I3TFJwdkVUa3F5dm5ZUGc0UERkVk5jYURuck91?=
 =?utf-8?B?eXlFSXdHcW8yTGhyVjQ2TlRIWDFhY0p2SzFFMmZiSDZpY1E5L2I5a25vNXNQ?=
 =?utf-8?B?QnV5ZWxlanFhSURvd0RxeERUODg1TmRQa0h2bzh6S0JOSDVPS2I2YmlIMXp3?=
 =?utf-8?B?WGFIczV3aHRhVGZMNWFYS0d4bGc1b3pqeTlSNVA4S0hDaW9zaVQwN3VCQ283?=
 =?utf-8?B?Ykc5UHRDY0tLRVhYYlAyeFp1NmV0Wk5EcWV0K3Z6bS9wZ1dFQ21vQmRhdkRD?=
 =?utf-8?B?L2JHd1BtbDVXY0tSRWxBcW9NNHFFWWd0eWhEVU9EM2RlMjk4c01SKzdnVEJW?=
 =?utf-8?B?RUgwUjN1M3BQMEppeGcwbXNkUmkzeGhKMUxTZXM1RDBQYXpKblNTU0FaV1lJ?=
 =?utf-8?B?am1SWStIbmcwMFlxai9TSy84bkM0ajcwOUc2bS9XNlpsbXNia3k4OGZzcCts?=
 =?utf-8?B?bXZwaUMzdlVLcVdjVEJMMW81NHVPMURKYUtrYS8xYVlPOUlMRkpDeUV2Zy92?=
 =?utf-8?B?N2dQOHRSeHU0aHBvWXU1NWVjVjlyWTI2QTBiMmZHdlpwOTRBUEdncGVuTXVq?=
 =?utf-8?B?Rk1tbUFxV0NlQjB6ellhYldNM3FmeUJWejF6UnZvY2hLcHgrQTFWbUxvb1hI?=
 =?utf-8?B?ajEvdVZwakhpcHVDWVlSR05BZi9JLzh2WlROQ2RxYTkxZ1NmN3VXWEZKdWE5?=
 =?utf-8?B?ZmFCb0hsTnJBNjVvS21YY0YxazdVM0JybWJCaHNMbUp0TkpCNTJ0OWVhVmpu?=
 =?utf-8?B?c2tkQ25sWnJaU0FVV1BjK3E1TU9BS2gwZlQyN0IvZW9YbThIcHVPc1Vza05w?=
 =?utf-8?B?VDk0VnJhemxPUTlHUVVvNUpsSXYvQXNjNTJRUGgwK0lld1NuYWh2MHdKOC9G?=
 =?utf-8?B?LytDd0MzbzEyM0Z1N08zamEvVXA3dEtPY2k5Tk1jV3NiQjV5MlJRVk1tUnFT?=
 =?utf-8?B?MHNGdTEvWit2MDFTbUJIV2tnODkyUUg2QTI2c2w3MjI0b2RnampYNVloUUhp?=
 =?utf-8?B?aDhkby9OSnljRGgzL3RNazJXVFY2cDdaRmNlcGdOVkdNOUxTOHlLSEZJVkV6?=
 =?utf-8?B?TFBBWlZXMldRMjlyajQyb2p5OFgyVUxpbHVpQTVVMTBOS1p2THhCTll5d3pN?=
 =?utf-8?B?Y0RETjZTcDkzUm1PZlBJbFZJSEsyNGtZekVVMFpvTEpzTlQraDJUNlhNVkg5?=
 =?utf-8?B?aHpaam9YNldaT21XV0xJNzBvNWRvUDFuT3VtS0E1Mk1waGxsby9YMiswbHFK?=
 =?utf-8?B?Q2cybEppSDVPTmFFSnVXcVgyd25Cc2ZLNlorTFlXT09GWTUzbmRTY1FDNkUy?=
 =?utf-8?B?WllobUpQS3VhazhXSDJ6ZHNHM01nZXZtK1VYSnRoeExlUVFTRGxlblgxUXVH?=
 =?utf-8?B?UXdQVXZXbWRseVVwMzJtUXdja2swZW1oTkR1Q0p1L3NhUmtSbzdabUc4TTY3?=
 =?utf-8?B?QUNScEZFQUxzTFBqdW1DdmovTDQ2Y0MxQVl5TmZQLzlWV0daWklTOEQ3UlhN?=
 =?utf-8?B?TStkaGVMVFFsSUR2MytKSDFtTlNoUG5LZnh4dEFlSnRjWHNrVWdoWUEvUHZX?=
 =?utf-8?Q?1/Do=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42b9694-bf40-4995-4cff-08dd9a0297a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 14:03:28.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R5Lzz8BNcpRFUlnJAEtVvqHHZYXWXTiPXyWQ4fygHuAgCYfZzGVTS+skqdMTzbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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

On 5/23/25 15:58, Alex Deucher wrote:
> I think that's probably the best option.  I was thinking we could
> mirror the ring frames for each gang and after a reset, we submit the
> unprocessed frames again.  That way we can still do a ring test to
> make sure the ring is functional after the reset and then submit the
> unprocessed work.

Keep in mind that we can't allocate any memory during submission or in a reset.

I think we should just tell the newly mapped kernel ring to start to from the known good RPTR and process to whatever the current WPTR is. Only after that an IB test should be inserted.

We could also modify the conditional code used for MCBP to skip processing for a specific VMID by applying a mask instead of always checking for 0 and 1.

Christian.
