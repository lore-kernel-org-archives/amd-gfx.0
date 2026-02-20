Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2609C55AB9
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 13:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8765610E17F;
	Fri, 20 Feb 2026 13:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3ktE7Pb";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C8710E17F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 13:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7AhtxAudiE7MdDpICdfOFQui+CbBL1EoZlYaGl3jzlTFHkzlyZG78OggE/5f/o0re3lx5sLJ3/OBTpcdjF0nbb4DEDA8XIjOoUSfFA4ePyAcMSc37qIPnZri7UaPltxGMTDRyoAL+dwPsB+d3Xhxz09AQMBSGR/Mfwb/ebPmZCzYYK6E9T2C7t9OJTOF+kRsGFZhN4vBZ0wIoL4EAwt0+fml4uqZA4a//nRLKyvDOE2pWCrXPSDDJKgwHL1rfj6T3AKWJ1TAMkV7dNWABkIquZgE3PEte2tA2NwWHsPQgK5Mp8h3ecSMdNiLTmj3mzagG/DNLtFmOr4Cl/QUireKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJFwjhTltIiskZWF5mMiYqGVTQKKDsdC+2gMe6LWTY4=;
 b=Zsftm5Kjrrwjivek6RBK+kUYz6/JaCZOnS62auRIe6uPGQXfyK5sOvTkTIgSfe+GzZUpKGmVyViogxpKqbaZnN67RTD0rZ8EIiQKwN4K17x16EzmlpErn+Ez7OqCknyBhtrpizT0dMgpAlKjGzdI3Z7pT1fvi3a/7Yqo0FmKyHHbkzIukvmK/gdZb1s1FlyBogdxNmCYQZ5y/8vkascSWnGlA2poDZK1t4+uYCrCqdE+J/ZGTwi4cOgeIuMj16f9q9otnYS3/IuzzNRqqwFRVGLXftjZRWZewC/J4L3o88qo+Ir6ygv5Zg9v2f7rNcvxuQYw0ePylpehi3DASQLw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJFwjhTltIiskZWF5mMiYqGVTQKKDsdC+2gMe6LWTY4=;
 b=K3ktE7Pbodg7pH2CUP1ondzPSCe6XTZxaqaSoeyzLwZxkRPv3wgyNi+pbsmiN8RRtYck3oEFDcKdqGTZRdnUx9cOVudoIimjAD+gZ24EtZu6mPQV6pycNoLuNy2cpag40uvfvB3QJYh3l3SH4JdwIRyUGO77VOw/ZEUttQTFCkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 13:21:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 13:21:24 +0000
Message-ID: <c6759efc-8c96-48a2-bbdb-ffbe4398471b@amd.com>
Date: Fri, 20 Feb 2026 14:21:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update memdup_user with
 memdup_array_user
To: "Khatri, Sunil" <sukhatri@amd.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
 <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0608.namprd03.prod.outlook.com
 (2603:10b6:408:106::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6e1a3d-f6d0-452d-38ea-08de7082f203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW1BNnNzUEk1ckVva292SnNDZmR0M0krSkxlZlE0ci9yblBDQkc1bHVrdlRz?=
 =?utf-8?B?ajErZm5rUTY2Vk9mMmU1LzdqVDFhempiYkdiNU9lMjgyeWhKQWZSRDBSY0pC?=
 =?utf-8?B?V0MwanRaUnNGbWM0RFNLZEM0eW81a2tiUkFMdTBuMURzdUZDL2piWFU5bFRQ?=
 =?utf-8?B?eGpIa3k4cjRXSDZvZ01SUWFQRXZ2cUNna0R0S2pDMFVKNDdPVDZyY1laWDdP?=
 =?utf-8?B?Qk5DcHh5S1Npd2RlWXgzMzhYRjAxbmVDM0xqS053SkZmek5zYmVtdVBVRnNV?=
 =?utf-8?B?cWQrelNVSVpRUlhtS2ZidklZZjN3SDV5KzZpZ3o2VzNvcmxEZStJWVowdWk2?=
 =?utf-8?B?TjN0S2VWUWxpSnprYkxZczgveFUyWVg4VXZwWkJvNnVSWjVoNmIzM0JnV3NP?=
 =?utf-8?B?N25kYWo1QmtDa1hsa2M1elFJSVZqMHVkNjBuMW1uRkJlYVhDNzFmaG04UEk2?=
 =?utf-8?B?Wjd5UDVNYnN2SjlkYnJHZWlGMVppVzl4cldhWUR6eDNGbHZ0TStZRzE2SGRJ?=
 =?utf-8?B?UHdtdjUwUmFBQXM5SS9nQmFxK2VPK2JvQSt0UWR0NmY4Zmw5MEtMdGlrN3pr?=
 =?utf-8?B?RU1UZ3NLZjE3akZKZVdpeG9jZUR0QlJuaEkzemNnZ09Mc0ZhQ3ljbmZZUHJS?=
 =?utf-8?B?MVBQdkdVL0RLcFRoNFY2Q3FWTTh1QlREQXZyTjg5MGlXcmsvdWVxZDBrcDJY?=
 =?utf-8?B?cDRoWVU2L2FOSUlDZ0xLbHpqdUVtNTFSbFNlUm5iSGhCTWQ2RWkzYTRHVXE4?=
 =?utf-8?B?RmFqbXFKS05sZlo5U1RBNEJISUhzZ1QxdGowUU9MWC9OdDlpbXhEdElHR0JO?=
 =?utf-8?B?bUc3WTNzaStZdWhldmprTFAxeHNuQTJmN1VHZjlPUisvZEp0R3NmcXpUM3Rn?=
 =?utf-8?B?b3F5RG5KTGJJVS9LZlVmSTU2cXlYa1dMV3F3ZWFjL0FKcWhWN3MzSmVUbEJy?=
 =?utf-8?B?Q1phOFN4azlpTHBDSGdncXRwUmdiNVNuVjlUbjVucy9sTktkdjNBZWxRMnVs?=
 =?utf-8?B?cWE3dWZobVhGczdGeHhMenNKUmYwNDJEVnhsUmJncThRVkk3aFl1QkpuTVdO?=
 =?utf-8?B?L0FwRktKWVIrN1lLT1RPQ1JUNzRuUHZ0Y0ljbmdMV2N5REM5NC96MmdBUUNS?=
 =?utf-8?B?aGplSk95dE10dFhGeDA3TXVteEFQUmhVZXBlVVVRUXFEMmFJdFlzckZpWVlk?=
 =?utf-8?B?dnphOER5RjFtam8wQmx3Y3hSWmZFK1ZlekF5TGkvL0grNDRiaUdyVkZCL09h?=
 =?utf-8?B?OTMxZ2dRTFpSMGdtTngwSkpEcXRMRHhKcnhaODJlN29uVXd5bUcvb0g5ejNB?=
 =?utf-8?B?MDJ5ZUhVbEdPM2pMSUNhUEF1cXlvZXordmUzUUtjMlhmSW8zekMxbFN3dkhP?=
 =?utf-8?B?S2RqUzhuRkc0SlczbFZ5TW96dGVZT2lBbEpLT2RJTlNNa2JwT1M0V3VmZ1dJ?=
 =?utf-8?B?aFMxTklxc1JQWmFMSkZFS05aUERIUWM1TXJsSXBwNkVMWFJ3SElZM0d0aUc4?=
 =?utf-8?B?S29pKzdvV0dMWHhNaTFtVUxOWVdtQUpqY1c4TnJvdFQ0ajQ1NDhhSWlvaHFR?=
 =?utf-8?B?aWZiRFNRQURxL1phZDBPNk5QbVhhVWR4bVIvOFVMV3ZoWUg2MUZ4RHY4TTBE?=
 =?utf-8?B?UVVwVWNkZloxS0xHb0FObTAxU3J1OStZZFdEVzd1OVlCRkZBeEpIRGFCYzg3?=
 =?utf-8?B?V3Y1ellZcE1VVnY3TFFORFN6eFc0UHNXM1RqeENSS2plZXB0OXFyaGRJUHhE?=
 =?utf-8?B?Y3ZBUzZxSDJ5S0tqaEVqSlFTUElFRk4yUmp3UXMwb0JaQmRkMG8yeVN5Zm4r?=
 =?utf-8?B?dHpOcGdRdkR4SHRDMXRYY2dpak1ZWmRXa3NvL2NoUndXQStpaEt2UEViK21x?=
 =?utf-8?B?UU5YY1lPOTA2c2NoUHpuZmJBRUxaZzhJOUZ0WDVBVTVLT25HRmZMQXdLMDNj?=
 =?utf-8?B?VXJUQnVBREZhbGsxeHZvWUNaK3VMRnJHdEI3NVRqNitvTGlML3RERnM2VWJu?=
 =?utf-8?B?S0VGZ2JvakEvaWM1cjZDbmc4QjlwQmp5bnZ1NWJkQTJiS3IxZXNsMm9OdDF0?=
 =?utf-8?B?N3MvRnYxTDVrL3dPNnl6Y2ZWU2p1MUppcFFKNDlCUGZsZDNsaHFUK1k4Zy9m?=
 =?utf-8?Q?8Rqi9kJdQXyk6bdELqyRVmiXs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2I0WDNwYlpGRktRMXpqT2t1V1FzUkZTNmh2M2hWUjVtYUd6clNoSnhuYStZ?=
 =?utf-8?B?REpCakZNM1BVSytvMDR1bW42NktEbFFjcXFBOS9pU3NsL3JLMmhveTh4RWlz?=
 =?utf-8?B?MjJpUCtSaGt1eWlJMjNvajB4NVRFdlVJWjVlVjYxRW1jNEtNTmROeUJ3RW14?=
 =?utf-8?B?eWtxYmNrRmh1Z1dCckp0VGFLeDlMUmpsMkhKRlFuVlR3L0I1WnVBMXpXVUlu?=
 =?utf-8?B?bktHeklRZFFmYW9MNzdhTmJYa1lpZkRnUTJBYVZIM2FqaG8xRHVjQmpqQU1s?=
 =?utf-8?B?YnB3dysxNHUvcTcyYzY4SEUxYzNLZGpLUWxiVGJsaWtERmROalB3NTl0RnZo?=
 =?utf-8?B?R255SFNCTlJCWU1aZEY4SGRiQklOKy95OTVSak1pM2doYW50bXJxc05FcVU2?=
 =?utf-8?B?SjVqUzRTWEd5MlI5YmtFSTZHNEQ0RDlhaGF3c2l3ZWJ3Q1daZDVSQkRxQVlp?=
 =?utf-8?B?MlZ4N2FJT1BkMEdPc0E4eER0aVg1ajczVmtOOGNSbHNYWWFlNEZqOHA5NStR?=
 =?utf-8?B?YytJSjJPaUNMV2Y2anJJVng1S0ZnbGRDWWJaT2dXYml0U1VxK0ZmeWRldlps?=
 =?utf-8?B?TmZtSnlsR3RqcjE2RDBNdnRCYnZxaHpPcnBaa0hPU2dMa0Q0eTlCUFNOSXND?=
 =?utf-8?B?aVluS2FWdE91SmpCaGZHWmJrQjNOZ2o2WFJibDJYMUlYMkpkUlYwdEQ5YytB?=
 =?utf-8?B?S2xaM0hPRURIblZDM3FOSDlXL2ViL1lrcllGUlpjNzEwdUNxMjBmVGNYM1F2?=
 =?utf-8?B?Qnc5Q29oRkEzRGJXUlBKUWdaVkxyV3c3NExpQUMzYVpraTduaTVMU1JkbWM2?=
 =?utf-8?B?K0U0YndRdVJwaElXZ3dxQ24rejVOT1ZHc3puYXBaeVEvTE9Xd0hiNzVVZjFi?=
 =?utf-8?B?ditiQzlsQk9lMkp1UVZzRi8zTzhhaG9CU0pRdDZJRHphNkQ1TklXL2Rkemow?=
 =?utf-8?B?WXlwRFdPYVQ5Z0V2Q0ljckNPWGFhdTYxQW9sYkMrem1zcU11Z1BnNHIwQzN2?=
 =?utf-8?B?akV1UUo4Wi9yTEFPY0duYjNjL2dYOFN4eUdDeGQxMVc3RGlIWDlFN2dOZm5a?=
 =?utf-8?B?WlVTM29rT0VPNDBzN1Jkcml5REVlcHdnU2pPcTFRUENYSVE1MEY1SmJvZjBD?=
 =?utf-8?B?bTR2SUFzTlV5cDdFRWlxK0dRR080SlNYdzR6ZGdxQ3J3QWg3OVlXbVZwWGx0?=
 =?utf-8?B?M09IUWNUalZvZStLcWNmRnpZelhadGNYeVhoN0JGMDVVS2FiUUpaV3hDVGUv?=
 =?utf-8?B?czFVYXhyV3Nmc1I4a0Q2aTNXUS9PWHpra28zT2RBNS9nSGxiM1B0V1g0M3J0?=
 =?utf-8?B?UERYZGJxeVJ5S1gyMGNqc1VNYkVuSzg5UVVheEZlMEo2bWVVMW1udGJNR2tZ?=
 =?utf-8?B?Zml0UThHM3pXQzcyczBlcWRxMTB1em8wOGZFamNqN08yN1JZaTZTNytCQWgz?=
 =?utf-8?B?eTlDZXFudnhPNkU3S3d3Mm4wYktxTWRxeUQ1dnBzekJJb3c0QmM5TTRjYVFl?=
 =?utf-8?B?dlFleHBPb2ZCZ0JPOVZhbkZHSmtzQVlNUmsxTWZzbnZBcXliamJDVTdjZlly?=
 =?utf-8?B?elRlV2ZKSUEzVndXMURVdGYxbnIxTkt3dnJuUm1oMFQxelNyem9tQXR1NG5P?=
 =?utf-8?B?MlNHS2orMHNrZzF1TjNWMlNuZ0k3ODRQUjNsem0yTTZHVXZyeFZSM0RPY1ls?=
 =?utf-8?B?ZThvMHFLS0RvUjJhT3JLRDltZXdGaHBiMm9rMW1iMjNyMndjNnRteW1oZHVk?=
 =?utf-8?B?WFdQNnBoTlFYa0NVYUtqTTBsQnQzQW8yS2I3akxyMmdDNFkvYjFEQUlyKzNm?=
 =?utf-8?B?Y0J2MWRDejdYMm5hZExKM0E1ODNOaEtnV0FJQ3VSREdUU1BZZ0FHVVRHdE12?=
 =?utf-8?B?NEM4b1BMcHZ4R05wUitKNTRPdnZJdmlqUmJyTm1KaEN2SDViTStSdmZLWWp2?=
 =?utf-8?B?L0dPMU9lRW5KOExJMjd1dno0K3JNcXd2MVY1MHBHcWV1TllYY253dmJRTFAr?=
 =?utf-8?B?cSt0Ky9lSU94T2prSzVVUHo1eVNDNUdsK0kzNUc3UkZtRWMwaXRNVm5FaFd3?=
 =?utf-8?B?YUZHQ1RFVllPK2ZPUmdQRHJvb2hLdGs3ZmdXMitYeXRJNzA0Vm1pbTllQ3oz?=
 =?utf-8?B?RGlxakZuT3F0eFNKTVA3TWpVWkxyS2lieDRzWFhzQWpqUjgyNVRXd1pFd1B2?=
 =?utf-8?B?Sm9oUVE5elRDZHAxY0Zma1k0cXN2dGRtMzZ3bWNrN3cxZE9MWWJLNWo5Y0o0?=
 =?utf-8?B?a2lJNlVydXBTK0ExeUxzVGR5WlVOZ1JuU0FzWXdXMU1XUUswVUJCcXdDSkpO?=
 =?utf-8?Q?UpoeM62k8QZaaENYM5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6e1a3d-f6d0-452d-38ea-08de7082f203
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:21:24.3198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H54qozhOsZUrQ2gbA2EAPegBjP0ELLVMCysCmNIQPmtk3AmkEMpGVFlSIoTZZbQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
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

On 2/20/26 14:19, Khatri, Sunil wrote:
> 
> On 20-02-2026 04:54 pm, Tvrtko Ursulin wrote:
>>
>> On 20/02/2026 08:28, Sunil Khatri wrote:
>>> memdup_user could return invalid memory allocation if
>>> there is an integer overflow. Using memdup_array_user
>>> make sure we validate the size requirements upfront
>>> and return with an error.
>>
>> FYI:
>>
>> https://lore.kernel.org/amd-gfx/20251205134035.91551-1-tvrtko.ursulin@igalia.com/
> Are you awaiting for anything to merge the changes Tvrtko or they are merged in drm upstream already? Since issue is reported now so we need to fix this.

I simply couldn't find time to review those patches and then they felt under the table.

If Tvrtko came up with the same patch earlier than us then just take that one, review it and push to amd-staging-drm-next.

Thanks,
Christian.

> 
>>
>> And later:
>>
>> https://lore.kernel.org/amd-gfx/20260202125149.2067-7-christian.koenig@amd.com/.
> Yeah i am aware of these Christian changes and we decided we will fix the issues first and reorganize the code later as needed along with Christian changes. So we are going to push the changes
> 
> on the existing code base first.
> 
> regards
> Sunil khatri
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 +++++++++----------
>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 212056d4ddf0..a6eb703b62c4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>           return -ENOTSUPP;
>>>         num_syncobj_handles = args->num_syncobj_handles;
>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
>>> -                      size_mul(sizeof(u32), num_syncobj_handles));
>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>>> +                        num_syncobj_handles, sizeof(u32));
>>>       if (IS_ERR(syncobj_handles))
>>>           return PTR_ERR(syncobj_handles);
>>>   @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>       }
>>>         num_read_bo_handles = args->num_bo_read_handles;
>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_read_handles),
>>> -                      sizeof(u32) * num_read_bo_handles);
>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
>>> +                        num_read_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_read)) {
>>>           r = PTR_ERR(bo_handles_read);
>>>           goto free_syncobj;
>>> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>       }
>>>         num_write_bo_handles = args->num_bo_write_handles;
>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_write_handles),
>>> -                       sizeof(u32) * num_write_bo_handles);
>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
>>> +                         num_write_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_write)) {
>>>           r = PTR_ERR(bo_handles_write);
>>>           goto put_gobj_read;
>>> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>           return -ENOTSUPP;
>>>         num_read_bo_handles = wait_info->num_bo_read_handles;
>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
>>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
>>> +                        num_read_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_read))
>>>           return PTR_ERR(bo_handles_read);
>>>         num_write_bo_handles = wait_info->num_bo_write_handles;
>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
>>> -                       size_mul(sizeof(u32), num_write_bo_handles));
>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
>>> +                         num_write_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_write)) {
>>>           r = PTR_ERR(bo_handles_write);
>>>           goto free_bo_handles_read;
>>>       }
>>>         num_syncobj = wait_info->num_syncobj_handles;
>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>> -                      size_mul(sizeof(u32), num_syncobj));
>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>> +                        num_syncobj, sizeof(u32));
>>>       if (IS_ERR(syncobj_handles)) {
>>>           r = PTR_ERR(syncobj_handles);
>>>           goto free_bo_handles_write;
>>>       }
>>>         num_points = wait_info->num_syncobj_timeline_handles;
>>> -    timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>>> -                       sizeof(u32) * num_points);
>>> +    timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>>> +                         num_points, sizeof(u32));
>>>       if (IS_ERR(timeline_handles)) {
>>>           r = PTR_ERR(timeline_handles);
>>>           goto free_syncobj_handles;
>>>       }
>>>   -    timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>>> -                      sizeof(u32) * num_points);
>>> +    timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>>> +                        num_points, sizeof(u32));
>>>       if (IS_ERR(timeline_points)) {
>>>           r = PTR_ERR(timeline_points);
>>>           goto free_timeline_handles;
>>

