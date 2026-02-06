Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F08EE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 15:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04E810E821;
	Fri,  6 Feb 2026 15:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VFr0fozV";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC0A10E82D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 15:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRtRpt+GF/N5bqPdbdtBRuLqePCRW3XHToCcG9opLVehfd6uB0O+LVpE+qeQ+WQPsUxyyWzJ3MJb1nuv0t750woeqttjUPTeN9MIX4gpEzGOs/32BpHayFtPkf13vEdlO9qJ4In0YElgkcQpuV/Vepr+U4IIGMOPk6Pi6hJbqAKoMw+IYa3jWRxhQ8r8RQj9Z5TOJ7tjzainvrJcqCVk7m232CEYbdl3I4EQKLgwDc9azkgfmA5X4FWgSX3JcZw9IcpGASS+3oW1l4aCM6GFzaODw9Y+TYlO0DiL1cGmHOt/5nmz8cLYhzRdSz2J1IWvYSLIs/riVyXpO1co7GJwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfbCDppT+1bb5DvpY+8pJ7FtT02WcmYo4OV/THF2LqQ=;
 b=TnU7JmV/jZZRvaq11AbQ6bT1p1uqHLIrLxsAGXboMF8dqQXNe5lvjrSpzKFoCShDHP8++cbQyQm4ikl4w2BCJPCrWuu+kmKklKiMA+u2Q7X6pidCTpK3A6VGH+BwrZeZtibjl8cpcptZJsOcR+drkwsknhalElKRTItZL9JxIC9s7GDMyRFeH2bpE9T4wvybzwVmkIbY/SdYXCfxNnE2b2Vo6ZEuq9BPP/x3Hf5T7lzMfqB1AVtGoY+zXFdF8jIsWC4YfQjTowPJsmJiTILwMZlUauTIVRh7u6/qMmkH4CVKOtDj4owDSl0zbl+jRcMYiJzWQGYDxH/t9fAyN96Dsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfbCDppT+1bb5DvpY+8pJ7FtT02WcmYo4OV/THF2LqQ=;
 b=VFr0fozVZsD6v7mWD4KCoxlE4rqgznK3lMHf/jLF+q/HMDAWzzYxozmsWk3xfUF3w8tSnsvrjc7nCMmSwPH79qxuAzG43TRLBBapEUfj4JSh8LtYwg2P08Ntn6eJj7OpIvxVbxBxNVOg1IAdvog1BDOq6XW7bPl3c7ohb2HcRUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 15:32:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 15:32:53 +0000
Message-ID: <1608dc23-cbea-48eb-9dd2-dc1bd9e5804f@amd.com>
Date: Fri, 6 Feb 2026 16:32:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule()
 error path
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20260206142445.1476609-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260206142445.1476609-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:408:f7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 480f0917-7300-46e8-b658-08de6594fe54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RU8zbUc3bG9oZGJmdnI4NUZCaW5NV3llQ3V4elR1UjZ0eWQyYVAramdhckNC?=
 =?utf-8?B?cWpTTXR4MW5jcW1keG5ONmlKMlFGMzJ5RGxobkVNR01MWFRHYTdobHdjQmxS?=
 =?utf-8?B?eE95dkt5YkE2M2Z0K2NvY080OGFKYTlnK2dFbXlxUmxLSWJKN3czRGNIUWtk?=
 =?utf-8?B?eTJ3cExIWEpxRDFOOXhCQXpYRUoxV3VhZmZZVjlTc01LM29nazJCdEpNKzJN?=
 =?utf-8?B?cTJjUnZLWnFmVGc0dlhxMFRSL0RkS0J2RnVuc3VxSmxHTHF2VlpEYXh4eVJ4?=
 =?utf-8?B?QTZRN3lxL0hTdHFVZHFabHRwcFRkYW9VNk05TGlNK1Fyb25mNHhyc3o5M05L?=
 =?utf-8?B?bmVxczJtWUNIcnR6SVo4c2ZVejJlajI0YkdaV3A3bDNVcTV5WWFjR0JkR2dZ?=
 =?utf-8?B?ZW5TUm4zZkhVWDdzSUJiR3pFK1RPZGplMFp2cmZCOUphNW0wNS93M0hEQTdP?=
 =?utf-8?B?eUlSUFRXMlNoM0Z3bGExNU45VW43WkRMckdBRGFXSVcxYU5EaG95enEwaU43?=
 =?utf-8?B?TUt3alBqblJDT2VyWld0MnByNW9pWEVydHV5RFI2SnpYNmEvOGZ0S29wWWlv?=
 =?utf-8?B?dTJveG9OVzFFL200bkd1N2dJZjY3SE1ISzZzQkFnVWZLUnd2U0ZuQUl5VGVI?=
 =?utf-8?B?aTlqNXFncWFzcm1BMG1SN25BNUk3a0ZHNTk5TndsNHVjZXBHaUdqcmpHZ1ht?=
 =?utf-8?B?NGlMMG5rZEFuVFZlQTJXWnVNVjQzME1DTEhtTkNwUG5RbVpKRUN2YVQyUmdt?=
 =?utf-8?B?Ni9LOGpRbVkyUzBFY0xpYU12aEdCZjNmM1BlZ2Q0L1JwalpHWnI4QW1NT1pl?=
 =?utf-8?B?Znh4WDQ5UUlKVFc3dzcrOVBwVTd0VGh2WnJjOUNKWHhhVGFOUzRDNldYQkIr?=
 =?utf-8?B?R2lIT0hJb0NvMVgrTTYxSC9UZWY1dENBUXRFM2pQeDdOK2JkRjVZZFFMdGQ5?=
 =?utf-8?B?TFE1ckEycENSd3NlclJZOFBtQnVKRWc2cVlhaC85bUVPVVpleEtFOElNdzZZ?=
 =?utf-8?B?RWUzSkthZ3l0bzRDRzNvQlQ2alphRWc5MXJvenNObFMrV1AyWEh6cWNZK3dq?=
 =?utf-8?B?dHoyYk9HUVRJTFVtY2hQdkZPS0x6UDhMSFZTOTYvSzhPeFVET3l3SVZEc3gw?=
 =?utf-8?B?N1YycHpqdXA5Q3g0V0dlV1B1N1dTVVNTWjQyTE5sMnFZd3lMSFZXejRFSkcy?=
 =?utf-8?B?enhFM0Ixci9ZK2l1ODJKUy9sVWwzSVZFRTUvS3RxZmtyWE15R2ZLOVhlS2No?=
 =?utf-8?B?NFBLbWtyTFZmS1dPeElxcFM0cWxmUEdxaVNCcTlraUdWaVd2c0dIODNoT25E?=
 =?utf-8?B?YlZGV3dIWFl1Y1RsSzN2YWFRMmo0NUg0RURqbWpWK3N4UFVNK1pKakZIRzRz?=
 =?utf-8?B?dVB2dldWb1hoWVh4dkRmMWhOWk5IeDNkVlhsbU5oWXZBcm44Q01udlBHZUpz?=
 =?utf-8?B?SG9nRUNhMVpWZzF4MFZDek1uT2lQSmFJNnZUeXVuWUJjZFhaeEh2Q2ZpNC9r?=
 =?utf-8?B?TjdWUWNhU2xTS2Yxb1dyMmYvVFVMWTFPTGQ1NFhNbFNBQW1zWFlZUXFWZG40?=
 =?utf-8?B?eEZldWdaRFBHaCtOSzdaRFlnV0JZQWhuZTVFT0ZYK1ZUNUxmWWVvaHBmRE9w?=
 =?utf-8?B?N0xLRTB3SDR6QXhIbDRPeWM4QWlHS0JDeVZhK2YxVFhBZ2ZONUxwc3kyVUM0?=
 =?utf-8?B?TUk1OXpvdTAwdmN2WWliWjZpTUhsRDgwd0lSdHdURVAyKzRBV1Exc25BcklQ?=
 =?utf-8?B?L3lBUFdKWDFoblNyVnhEUE5sYXdVa21MRENzTjJ6YWlaNVVDS0UxR3VPSkwy?=
 =?utf-8?B?OXJwY2Rta20rOW41YVV5QkZQZmlSVU4xMnlzRm5ucHJ4MnRYNnNrUmdoRUFN?=
 =?utf-8?B?OUo3Zm12bFVFdTI2ZU5tY1lxK0o2aHZjbTBiOE9RcTFjeHZQclJBM21aSHQ2?=
 =?utf-8?B?RFpkZWs3Tjk1VVBtTmtuZW9EWXZqWjkzR05Fa3JaRjdmVHZJRk96dmU0UnM1?=
 =?utf-8?B?am1OdzdyRit5bU0yWnVFTnN3aUN4ajc0a3BMSmYwbVQxZmQwMmI4MnQ2Q1RY?=
 =?utf-8?B?WHpZQW50bTNVaStLb2JyaDBUK2lkY2NNb1M5THpBdy9tbUFQZFc3c2hPN2ta?=
 =?utf-8?Q?2ti4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajcxRzZBVTh3Vkd1QzN2ZzNab2k4VVE5MENPTEFzZkk0VUZNM29LM2EvcEV0?=
 =?utf-8?B?QzlhNUNyNWZTN2tCaEtyK1FtekZWTklCUFR2SkVMc20rVDlta2RPMTJ2bEpE?=
 =?utf-8?B?MU0vZ2MwTmdsYW93bElTclFtb3Y4alR6ODcrbjZJRmMxWmNnRDBsSTV3MVFT?=
 =?utf-8?B?M0kvMXNQQU9taC9WNkZTWjZ1eDV6cElBRWUxUTJCSjVVNXhkUVJ5eThKdW1N?=
 =?utf-8?B?NWpBbDlGMkpsajBaQXd2R2I1WlBvMXBMaXYzT0pObVJrMnNiSVhtVGRhODBI?=
 =?utf-8?B?UzBRR2xFMGxndklqUDZ6MUh5cUFRd0RBTnZiZUVWVnM2QXVKby9yU3dKd2pF?=
 =?utf-8?B?R2NPNU5QZWs1bytIUEIvbTkrbFVOZWhEdHo1dnp5UXBuY1Y1MlRzVlA2ZVow?=
 =?utf-8?B?WmtoSko3OE12VHdhRlR0ZzhHelpDYXNZTk9DcWxjRDNvYStKK2NrbkFVTEhP?=
 =?utf-8?B?N0hOSDFlbyt1OVN6SE81NXRLaHNyVjhidVdBbFg4MEZnQ0dKa2tTbDBYbC93?=
 =?utf-8?B?MElyRHR0Z3BXNmZUcFZZT2UrZ3RKWG5oUElyNFlCcWgrb2FKMnhLbXNMRGNz?=
 =?utf-8?B?Wk1rY1BJaWJtTm4zQ2ptZnJ6NVhUdzZEYW9INjBNL0ZLdWNhb1JjK3pzaE5U?=
 =?utf-8?B?S0cvT3JnRkxDN2RMNWlCblZldk5JZzFUeENNc0JiWFVITGlFNDdDUkk0WFR4?=
 =?utf-8?B?ckRjNUVOY2NvTnlyd0hlb3htOEhZNnZ0c1RYTkVieE01TUJwT0Voc3NGUzdy?=
 =?utf-8?B?SDR3ZWhZOGRodFlMUEhlaGlmL3MrdEZUcFlXVmI3aTVsTTZHUHVMb0VWQzJp?=
 =?utf-8?B?bTVHYUhNSkJlMmhlYi9OdFlrR3hYeWp5bThueFlkeDZCSzhNd3dzME9tVEll?=
 =?utf-8?B?RFppS0hVZFlLd3hEVjgybXhUSk8vWmFheFl0QTlCSVpMQTNUeHdJTlhZd3l3?=
 =?utf-8?B?UDhVNjk4cWpTYUNHbU10L24vbVd5UkdnN2FVaEhZcnhqQjhxTnI5RG56N1Fs?=
 =?utf-8?B?clBzdVQwUjFkWDYzcjZSTWRxcWJMb1pFcFVucUZ0MFNhRndLeVFwZGlUUGRX?=
 =?utf-8?B?MUx3eGdzUFcweFpSSll4c1FxdnpjZVh3M1V3SWpKa0djejIvdXpTMit1SWR0?=
 =?utf-8?B?bWlqWU5Jd0g0Vlp5VDgzR21LVzBreTZZVDFhcWVuY2NNc0tnWnBxUTBETnA0?=
 =?utf-8?B?R285Q2I1dFNGWm9zOTdXNW43NVQ4MVJPMW8vNnEybi9YM2VTYlI2UGxmMnh0?=
 =?utf-8?B?dm1RSjJDdXZ3OVhVVGdVdjhEK0VGQ2xOYnlCZUpKN3M5S0R4L2tWcU5ObFp3?=
 =?utf-8?B?T0tWVTdwQTlPZmR1N0UzK0dYUE9GTEVwc1d6YmZDK2xLVjdVZmRFZEFRQ2pi?=
 =?utf-8?B?cTNwU0NTdmc5emlYL1FscU5Kd1dYaXNVOFdiKzcwMDl0dkw0Zk5LTWJvR0FX?=
 =?utf-8?B?WVhlSE1SYXUxVFpLSjFaZ3l2dG8zZ0JKRDFBVnorU3pteWxzOU9wek1OY0FL?=
 =?utf-8?B?YWlLMlgzUGNTdkFXVy9LT2hYbVRraWlMQS9HYStqbjF3YllFeWtDVHRrc3ZK?=
 =?utf-8?B?b1FFYzRhRUlUdWFyMDVvaWQ2dFFVYUVlNTVSS1NVSEtmallpUnJDSE50ZlZR?=
 =?utf-8?B?WE9RbW0ydXR4UTBPMHlnYmx1MktqaDJ4NkhHMmorZGhjbzIxdFE5M2w5WU9S?=
 =?utf-8?B?RThhbjRpUkVENzVDeE9XTEplaHhyWnVnQ2JTVXgzQjM5OURLeDZwUjVZZ2s1?=
 =?utf-8?B?K05kS0RLRUJGYllvaXRnVzN3dHVML25QeHBPSU1zcHRqbmdLdCtFRmFLMnMw?=
 =?utf-8?B?V0pNMUg4NmlXdFZiOVdoYWxCZkZYMmpJaWFSMjZUNjA4T29SdEdRQ2lnUE1s?=
 =?utf-8?B?VVlWc3YvV3Bvcm9aQ01mQlRKWUVDSUx1dExDV0tZbC9XcHNmNWdidE00N1Qv?=
 =?utf-8?B?dVJiVXcwMU8vMEFPUFA4dUNWK09mU2xHOXVLNmExNVE2c0RoQ3E4R0xsMHBH?=
 =?utf-8?B?NDMray8vM0VTK2VXdll4QWlRY2EvdE9LNTBhWWVDYURqTFFkRFFFQVFiS3ZM?=
 =?utf-8?B?aWNrQlpRclMvK01PbEtScFpqMnZ1RXNjYXNGZVVseFhuMUVoa0lsMEk5SHpy?=
 =?utf-8?B?RG81aUhzaHhkMXYrdTJPMjN4YnVuaW5hTUFzejhXMXY4bVloSWlvLzVUK2Ni?=
 =?utf-8?B?MkxwZ2FLSS9aN2J1cmVQMk1Nd3d5U0xEK09yWDhoRmJtTWtzeU5pVXh1c1No?=
 =?utf-8?B?N2tVZkdITnVKYXF0Y29jU1orMGdlZFNiQXFORUVMZ3B0QUQrWWFQY1VLVHRr?=
 =?utf-8?Q?xyKwUIMTj+KtT21YWP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480f0917-7300-46e8-b658-08de6594fe54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 15:32:53.1203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zm5RoAPriIOoVYVQOwJG0a1Ki9ndbDgYDjZxEKQWIfMG/SmLg+EZ4vHxLWaJMGT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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

On 2/6/26 15:24, Srinivasan Shanmugam wrote:
> If amdgpu_vm_flush() fails, amdgpu_ib_schedule() returns early after
> calling amdgpu_ring_undo().  This skips the common free_fence cleanup
> path.  Other error paths were already changed to use goto free_fence,
> but this one was missed.

In general good catch, but amdgpu_vm_flush() never fails :)

I wanted to remove the return code after Alex has cleaned this up but haven't got the time for it yet.

Maybe you can give that a try. It originates in amdgpu_fence_emit().

Thanks,
Christian.

> 
> Change the early return to goto free_fence so all error paths clean up
> the same way.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c:232 amdgpu_ib_schedule()
> warn: missing unwind goto?
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>     124 int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>     125                        struct amdgpu_ib *ibs, struct amdgpu_job *job,
>     126                        struct dma_fence **f)
>     127 {
> 
>     ...
> 
>     224
>     225         if (ring->funcs->insert_start)
>     226                 ring->funcs->insert_start(ring);
>     227
>     228         if (job) {
>     229                 r = amdgpu_vm_flush(ring, job, need_pipe_sync);
>     230                 if (r) {
>     231                         amdgpu_ring_undo(ring);
> --> 232                         return r;
> 
> The patch changed the other error paths to goto free_fence but this one
> was accidentally skipped.
> 
>     233                 }
>     234         }
>     235
>     236         amdgpu_ring_ib_begin(ring);
> 
>     ...
> 
>     338
>     339 free_fence:
>     340         if (!job)
>     341                 kfree(af);
>     342         return r;
>     343 }
> 
> Fixes: f903b85ed0f1 ("drm/amdgpu: fix possible fence leaks from job structure")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 44f230d67da2..bfa64cd7a62d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -229,7 +229,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
>  		if (r) {
>  			amdgpu_ring_undo(ring);
> -			return r;
> +			goto free_fence;
>  		}
>  	}
>  

