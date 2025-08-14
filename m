Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EBDCA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 17:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153F110E8CA;
	Thu, 14 Aug 2025 17:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGxaE9K4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFCB310E8C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 17:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEbcZXI6I/VTAIAkMKOg1soic5FvGHTq6Lzfkpb1YAXguyPwMwQ6UP7F3ujvw04EsxCPoQaP8GR+SgHbqRE0Ti/BvoHm4g2ecRLigLeggHIvxcSrc7uh5En3C/S73EebcP6v3Pvqd4Ekd/tuZlvJcVYvGH2yQpzzpHR7T0FRKVMYhZHZjh/khPYsHvmYVDVazXQtKVjmn7mAfFLchwRmNmvQPwfxpdw3wSmJX0M2EXtsJyUd9f74SOuDfvp1YB6u+lo6LrAg+N9OvrdXclnfw/RLHEGEy5on+zLCaxTFT7JWNv1oG8c7dOUsL4zFS6VNi9FCLRApD3V1rScGEEh4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euR/+O9ELmkmpt0Z73OT6p1QEIhED7TiscKlwcmXmlQ=;
 b=vWSvgszDDfPdQUMEGFUeEOdV+HKuk/nvmGFqtIKeITXR1elyYNYjfnDaeYXlpD+xlo0rJs5AQmnjSnGr5F0J9wjkSD7kM4agdJAp0Z6Sgjmwww6Ziyo6jWIB9v63WhEW3h3SwUwMqPC2Z2npRywhRj1VADdNwvOfce/cd2hqES8b9DjOWsxjw7DbwXpAEzIhq+FDAMrPWu5oP8IQOTTMoA3L/B74gUuUQRDzUuAzjaZsp01UGyjecovhWMqDCDW3VNB0Yg6HcGnStkNfu/VKrX2Cp+SgK/F/lumSi9atTmJO54/5d9myro1xSdfIIOeyCuWIjhCT1QrF/M5gEA9Unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euR/+O9ELmkmpt0Z73OT6p1QEIhED7TiscKlwcmXmlQ=;
 b=qGxaE9K4QXKbcqtM7pLicDbV536BQOBtwulwZtJyqcXIIGkJ0oZQSXy7oYIt7Qb5zYBNbxqDKl88zwgBYhqa3tkvq9QdDpb8f6iNkfXO78LhMQ+Bsy6IrXmcxEAYg+rW1tpY5APhZkvinaTHQGvg7iYvHkFLjjuU0O3UpIOFKSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 17:06:20 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 17:06:20 +0000
Message-ID: <5b0bcde5-bc93-d9cd-fb5e-29426e956ae4@amd.com>
Date: Thu, 14 Aug 2025 22:36:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Wu, David" <David.Wu3@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <376e6482-7319-426a-3d67-994b9581c678@amd.com>
 <CADnq5_NajJn+6hHVmQsxBQ=-j_Xhc50csXGVPDmRoDvAb3AZgg@mail.gmail.com>
 <422ce379-1a56-de36-c040-6da658dead63@amd.com>
 <DS0PR12MB780454748D8280FEAA9DF3339735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <dd993060-e357-ebe2-4786-cbff7f3eb60c@amd.com>
 <DS0PR12MB780432BEB1D74FE5685273F59735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS0PR12MB78045E926BE8E8D0B663CAEC9735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <6ecd4ff4-d427-6c62-0c9f-21b7c601de79@amd.com>
 <DS0PR12MB780439434F2D1BD589ABC9359735A@DS0PR12MB7804.namprd12.prod.outlook.com>
 <3e0fe19f-68af-5802-0a33-bb5b63132f9e@amd.com>
In-Reply-To: <3e0fe19f-68af-5802-0a33-bb5b63132f9e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a89a8c-3b03-4bbb-eef4-08dddb54e3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zys1Mm1GbXpVTFVLb1JST0l5L0ZpUFp1c05QTWxXU1Zjd1RmQXFtaVBFLzVm?=
 =?utf-8?B?MUxUSTdFUWUzNm5EZ2VvWjNIQWZIaE1SdlNKOTUwaUk1My9DbnkxaTROM2F3?=
 =?utf-8?B?c1RXUUh4UEc0aldnV1hoMzYrdmtXeVRwbi90TXRVckljenpRV1NncGRiU1Yz?=
 =?utf-8?B?YWFRWjBoK0FrYWFPUmtUS1FRNWo2eUxwbjhzd1IyWWRnNFRaUCt2Zm85bE1B?=
 =?utf-8?B?SVNwTkl6MzAyODNBN2k2cGx4YStRTUdrTk9IVWl0Z0Z0Wld1NS95em90TXg3?=
 =?utf-8?B?eE9CenpuSW1rOUpqSnlraldtcHF5VGxvQTBxZStQRTUvVUhNMEFEYVh1QjVQ?=
 =?utf-8?B?V0VwZmRJL2VRU3dxRG9yeHVqckc4ZU5Ea2xjNzBlRHkzSXBoODFaa2VGcy93?=
 =?utf-8?B?aTAxRngxZmF3OVM1d1lQbkxPTXVIdzBSWFcvLy85ZXo5VHdWNk5XeHJlUlBp?=
 =?utf-8?B?Ui9maVFiZVdUaTloWFo4dDdRZ2ZpM2o0T1ZJWHB0OEhGd3NmSW5SeEUvK3NH?=
 =?utf-8?B?RjJVMm84aEM3ZkNRWHl2Z0lMWUdvYmRuaU1wZk13bVc1NDJrSndRYlBUWjI2?=
 =?utf-8?B?YURheTU3MUlVcE9oUXpWcVJWYXZUZEo0WThXQ0VIZzV5Qmt6TXRrUHljYjZk?=
 =?utf-8?B?TjRTeFFzcFRXdGdyQWxPVmZDL0xGaWFHN1l3dmFKM21hL1hMZUFRWWplM0Fy?=
 =?utf-8?B?YjZFbUd0c3JZQjRuQlpqRXBHam14M1B6Z0kzVmJaUEdYWVpieU9TVEI4c25R?=
 =?utf-8?B?ZW5CNkN2UUF2NVNObStrYVl4NlFpT2ErZU5NK0FuUzRoZTQyWkJrU3F1RzNG?=
 =?utf-8?B?cG1GRkZQRUhMdURaMHd6bmhIMytYaFB2dXF3N0U0bnM2dmJuay9NSXJGSFhL?=
 =?utf-8?B?R2hoYWxUT3FUcWtnd0JtclFpd0Y3bXRHV2FZZllGc1k2dW1xNmdyMkJ2NFcr?=
 =?utf-8?B?bjdaYjQ5MmNkRjNOYnI0Rm84UnFzUnNTYkFCU290czRTMDdLZm96KzllM0tC?=
 =?utf-8?B?MnltWmd5bEhLMU1QbDZuTmpPMzNYd0ROWHQvNE9IQlFWQ2cvRDBEU0I2MGRJ?=
 =?utf-8?B?akgxQy90MkRPUU9ubGptRUhyQ25WYVV3WWs3a1RUa2JabjhIek5wYkE0T2JB?=
 =?utf-8?B?a2wvdTU0U0UzRGFUaGgyS0tOMFBQdlluekpEYWVML2VJQWRlTFVqWXg3c0d3?=
 =?utf-8?B?d2xQV1BoRnJTUXdSSXU2ZGZ0YzU5YkJUM2JjSGdKRkFtK2ppb1lzdGRYeFdq?=
 =?utf-8?B?NVJDVzE1bVJLY2hhbWJLSm10TXlxRk9lcDRKQ3dMSWlVN3ppeGNKdVNDdlhL?=
 =?utf-8?B?NWxIdDdKVTk1eDJyZDZzb3I1VnJmdEJ2TytENENFQUlLNlVDRzlZN2E5aWE3?=
 =?utf-8?B?d2lrRVpiZm5HWGRMVXU0UXlUTFo0WDBDanpaRmIraTRxSnFFci9JR0pFazVX?=
 =?utf-8?B?NHE3dkd0TGM2K2VHQTBHMHFKZ3ZBWFFwLzB0U05OakdBT240Y2xnaUJzRS9v?=
 =?utf-8?B?eHVNaHVpWmM1T3dPZmdxYW1wZ2h2U1BmbzJxeEEwbjRKU1lLdG94ZllScUtJ?=
 =?utf-8?B?VFBEVWh4N1BnRG1yZHFrUzdBeVJmUW1kL3FWQS8wOHRVdmdPcWh6T3BSQnVx?=
 =?utf-8?B?RGI1Y3VLeWxGQURxVEZIa1BCeW5pZFQ5bTVzRFdxYlV2K1R1R2hna3NpK2VZ?=
 =?utf-8?B?Z0wyYmdNcVMxeFh4VnhjRHZWZzQwSmZzak45QjZXNE5sTUNwQzBadm9BR2lu?=
 =?utf-8?B?Vlh6YkFRTVBrT0RSb2xhZUVBNmNrS2M1bFpFT3BmM2dhQTgwVGlucTV3Vm04?=
 =?utf-8?B?R2JPc25NS3M0YzRPWHZNYkZuU24wZkZ5aWRqSGpUYnZNZGw3ajg3aGlSQ3cx?=
 =?utf-8?B?Sm1NemVVUWJPRHY3cHIvRytzZ3FFTWV5N0JqZENRT1RJYmJvZjZzNWR1YVk3?=
 =?utf-8?Q?K54s6WJBWfg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZYaEhvSHpKWmpZWGNYQXBNb2ZoSGJSOFFlSXhqN1o5ditPQlNPUk53QWQz?=
 =?utf-8?B?Y2huNm9FWmd6UUd0a2pzWnVZK3ZYYjJVV1M1Q2FkaWhqcUpOVTdtM0Y0cGoz?=
 =?utf-8?B?T1oxRkN0eUlrYSs1THQ3TEtKODREeWt6T00zS1FwNnkweTdnWWpOQzZPY2tk?=
 =?utf-8?B?L2VHTzhIdG5mQXpZOXVjakkyREl3RGs3L3lVdVM5eTRCeFkzL0gxREhyZENS?=
 =?utf-8?B?Y0lLOEN6MEZsYkN1akEyNjlxb0Z0bzdVajBQdXowVmMvUml1RXl5dDV5c05o?=
 =?utf-8?B?bW5uVVJyNVQxQlgvR0tMcFVXSGFlY0QxdnBHdlZPV2t1SGQzNUNFTTQ2aWNF?=
 =?utf-8?B?QldJdEVxcXJ2SWxZMU5uOFJxeXIwbHhENHVPRDY5bmZsRDBadm02b0V1SVZH?=
 =?utf-8?B?Rk9ScVB0RWJvaGNhdDVicnBQc28zUi8wQzlxZHY4UisvcjlVMGExclpMUFFU?=
 =?utf-8?B?WmRPaEdmY3pmQTFmMnIwaXpjMGRlT1R6NHJKcytNUUNnZ1JnN25EQW1GUjEv?=
 =?utf-8?B?bHpNbWhFaFdzdG5ZblltbXhIMlZncUc3K2pGRmU2ejJKQ25hZmo3d1gxUTdy?=
 =?utf-8?B?N2xlbHRYR3czS3lRektrRmVUYmcwdmdUdVdyRnozTENEQ2hUbkZ6T0pXbTNr?=
 =?utf-8?B?ZmxZdWxLUzhHTzZYUHZOWkIwZ3NOcWFpemVxb2hwSjBIZWlXY1hDVzdSSkxs?=
 =?utf-8?B?a3lQU0EvbE5hemxPQnQ5SENkMzhRQnFkMTZpbEVKanMxRmxKdDlQMy9qRFZC?=
 =?utf-8?B?T1dVc3JnMkpjTUcwRmQ1K243b3ZNMEhuQ1NHb3JJT3B0bm5LQUx2c1ZLZmR2?=
 =?utf-8?B?U2ZlUys4RmVjbG1jY0tPVTA3eEt0K2FXdWI3MXNTaGM0ZmR2cHFiVEd6SHBv?=
 =?utf-8?B?R09vV1paU1JrZlBPVVhSZERrcVNqd0Y4dmVqQThtdWYxY3owWWhSblhBbXlW?=
 =?utf-8?B?N0t3MFpXdDVlNGpWdlBqTlgrTUxkT0l5ckFhWS9xVTZyakl2WmwvRGltNHJH?=
 =?utf-8?B?TzMwZStXK28xbXQyS25yWXhnMmg0MUxLTk5aTDlrNkhlNUdWNjlCNUllNytR?=
 =?utf-8?B?cituR01mMFJxamloTTF4d1lJR1dUOUFEOGFRajBDMjRNeGhXM3Bwd3dnWGhx?=
 =?utf-8?B?eTZjeVoydzhBNXd0aG5rUkVROUtTcW1MVGE5QTBnZ0kyZmE2R1V0cEtJdHIv?=
 =?utf-8?B?M0JRcWhzVjZqSHdzenM1WkRrbUp2WWUzL21ETHZsckw2WVlFQ1Ruc1ZMdWg5?=
 =?utf-8?B?aVRIQXo3aUVtQm1rb21pMXZock5pUFRURUd0WFdsby9CTFI3OStlZ1ZadUha?=
 =?utf-8?B?UFJZRmFLY1BCa1pGTFZrbVBUSGNPNEZUa0czTU9NN1I5eFlCS3FTRkx2N0dx?=
 =?utf-8?B?OFQ4Ny9KZ0orUTV1WkdQajhZMVQ4ZWJYZTlMM2RNVWtINVFiekN0aW9FL3FO?=
 =?utf-8?B?QlM0c0hrTC9yUlY5MmtZQlpHb0N3R2IvOUZCVzQ5bzduVmpNaHFFazNkaFBW?=
 =?utf-8?B?dk56ak11RHlKcXdrSGd1OWpiSUhZN3pTcm91azB4V1ZRWmlpZE11ZFlpbHp6?=
 =?utf-8?B?ZUlyZGxnYVRXUUlSOVRabmxjNzBLNWc0amQ5aU4xcHEyaTcvNzFoSDVYU04v?=
 =?utf-8?B?bjJyelJBellKSzF0ZGl0bG5ib3FDNGQxUTMvWVNvLzEvQmFmeXdzVTV6TlJt?=
 =?utf-8?B?Uy9aRWlnTWdId25xVk5wajc4U2UxTmlncUJmWjl2MUMvVXhXbVo4TUk4RGo0?=
 =?utf-8?B?SVY2KzNJVmVuaHJ4WG13eGNIbDUrei9xT2p6NGxxRUdtVUZmUFMyV3EyN3pU?=
 =?utf-8?B?QzJkZGNWQ0wrT0ZuVDlSSHUxeHVlQlFCSjdpaEdqY0dTZ3pPYy9TdEg4RUJO?=
 =?utf-8?B?WFpSRE9iYVNyam5lNkYwU0g0LzYrM1puTGhWRFpyZGtSRWxkRTRqOXRXYUtS?=
 =?utf-8?B?YzlCSC9sWUpXQndnaTlUOVllbkpOa2N5a2N5V3NSQUpKMkNlSmdvTlh5eWND?=
 =?utf-8?B?bG1QVFRJMUJxUS9Ka1hIZ2hQVXo3SlMyNktyRUpaamJqRGhyYWtuNW1CL1c1?=
 =?utf-8?B?YzdXdFNOb1Q1VjNHUmZMcWI2TzlRN2Jtb25xWlZnZ1FZOVpwdURudkYwTlFo?=
 =?utf-8?Q?7ig72vfXiY4mYdt7vvuOTti8/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a89a8c-3b03-4bbb-eef4-08dddb54e3a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 17:06:20.2606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsQquf0EHMariJ2/ZmmDfQh4hyJ73v8MpjZNE4ijE5yy2rDZnQe5Tz+OyYtmEqJ9UIiCL+7VFNyvUEzXpy9i1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
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

Hi Lijo,

On 8/14/2025 6:18 PM, Sundararaju, Sathishkumar wrote:
>
> On 8/14/2025 5:33 PM, Lazar, Lijo wrote:
>> [Public]
>>
>> There is no need for nested lock. It only needs to follow the order
>>          set instance power_state
>>          set profile (this takes a global lock and hence instance 
>> power state will be visible to whichever thread that gets the work 
>> profile lock).
>>
>> You are seeing nested lock just because I added the code just after 
>> power state setting.
>
> Pasting your code from the file for ref :
>
> @@ -464,32 +509,14 @@ void amdgpu_vcn_ring_begin_use(struct 
> amdgpu_ring *ring)
>
> -pg_lock:
>
>      mutex_lock(&vcn_inst->vcn_pg_lock);
>      vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>
> +   amdgpu_vcn_get_profile(adev);
>
> vcn_pg_lock isn't  released here yet right ? And in-case you intend to 
> only order the locks, then still there is an un-necessary OFF followed 
> by ON, but yes that is acceptable,
>
> May be you want to move that vcn_pg_lock after amdgpu_vcn_get_profile 
> to protect concurrent dpg_state access in begin_use.
>
> The concern is, this patch access power_state that is protected by 
> some other mutex lock hoping it reflects right values also when 
> holding powerprofile_lock.

Thanks for taking time to explain this personally to me , I get it now, 
your patch should work fine. This above is a wrong hypothetical issue I 
imagined.

amdgpu_vcn_get_profile() and amdgpu_vcn_put_profile can be void return 
type.

And please remove the typo to avoid nested locking.

With above changes, your patch is  :-

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

And there is other thread which also has Alex's (v3) fix for this issue, 
leave it to Alex/yourself and other review participants to decide for 
the best approach, I am inclined with your approach, as it is centered 
around pg_state.


Regards,

Sathish

>
> Or
>
> Have shared a patch with global workload_profile_mutex that simplifies 
> this handling, and renamed pg_lock -> dpg_lock  and used
>
> that only for dpg_state changes per instance.
>
> Regards,
>
> Sathish
>
>>
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>> Sent: Thursday, August 14, 2025 5:23 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher 
>> <alexdeucher@gmail.com>
>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition 
>> (v3)
>>
>>
>> On 8/14/2025 3:16 PM, Lazar, Lijo wrote:
>>> [Public]
>>>
>>> I see your point now. Attached should work, I guess. Is the concern 
>>> more about having to take the lock for every begin?
>> This is closer,  but the thing is, IMO we shouldn't have to use 2 
>> locks and go into nested locking, we can do with just one global lock.
>>
>> Power_state of each instance, and global workload_profile_active are 
>> inter-related, they need to be guarded together,
>>
>> nested could work , but why nested if single lock is enough ? nested 
>> complicates it.
>>
>> Regards,
>>
>> Sathish
>>
>>> Thanks,
>>> Lijo
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Lazar, Lijo
>>> Sent: Thursday, August 14, 2025 2:55 PM
>>> To: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>; Alex
>>> Deucher <alexdeucher@gmail.com>
>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>>> (v3)
>>>
>>> [Public]
>>>
>>> That is not required I think. The power profile is set by an 
>>> instance *after* setting itself to power on. Also, it's switched 
>>> back after changing its power state to off.  If idle worker is run 
>>> by another instance, it won't be seeing the inst0 as power gated and 
>>> won't change power profile.
>>>
>>> Thanks,
>>> Lijo
>>> -----Original Message-----
>>> From: Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
>>> Sent: Thursday, August 14, 2025 2:41 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>>> <alexdeucher@gmail.com>
>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>>> (v3)
>>>
>>> Hi Lijo,
>>>
>>> On 8/14/2025 2:11 PM, Lazar, Lijo wrote:
>>>> [Public]
>>>>
>>>> We already have a per instance power state that can be tracked. 
>>>> What about something like attached?
>>> This also has concurrent access of the power state ,
>>> vcn.inst[i].cur_state is not protected by workload_profile_mutex
>>>
>>> every where, it can still change while you are holding 
>>> workload_profile_mutex and checking it.
>>>
>>> Regards,
>>>
>>> Sathish
>>>
>>>> Thanks,
>>>> Lijo
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Sundararaju, Sathishkumar
>>>> Sent: Thursday, August 14, 2025 4:43 AM
>>>> To: Alex Deucher <alexdeucher@gmail.com>
>>>> Cc: Wu, David <David.Wu3@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition
>>>> (v3)
>>>>
>>>>
>>>> On 8/14/2025 3:38 AM, Alex Deucher wrote:
>>>>> On Wed, Aug 13, 2025 at 5:1 PM Sundararaju, Sathishkumar
>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>> On 8/14/2025 2:33 AM, Alex Deucher wrote:
>>>>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>>>> Hi Alex, Hi David,
>>>>>>>>>>
>>>>>>>>>> I see David's concern but his suggestion yet wont solve the
>>>>>>>>>> problem, neither the current form , reason :-
>>>>>>>>>>
>>>>>>>>>> The emitted fence count and total submission count are fast
>>>>>>>>>> transients which frequently become 0 in between video decodes
>>>>>>>>>> (between jobs) even with the atomics and locks there can be a
>>>>>>>>>> switch of video power profile, in the current form of patch
>>>>>>>>>> that window is minimized, but still can happen if stress
>>>>>>>>>> tested. But power state of any instance becoming zero
>>>>>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>>>>>> Consider this situation, inst0 and inst1 actively decoding, inst0
>>>>>>>> decode completes, delayed idle work starts.
>>>>>>>> inst0 idle handler can read 0 total fences and 0 total submission
>>>>>>>> count, even if inst1 is actively decoding, that's between the 
>>>>>>>> jobs,
>>>>>>>>        - as begin_use increaments vcn.total_submission_cnt and
>>>>>>>> end_use decreaments vcn.total_submission_cnt that can be 0.
>>>>>>>>        - if outstanding fences are cleared and no new emitted
>>>>>>>> fence, between jobs , can be 0.
>>>>>>>>        - both of the above conditions do not mean video decode is
>>>>>>>> complete on inst1, it is actively decoding.
>>>>>>> How can there be active decoding without an outstanding fence?  In
>>>>>>> that case, total_fences (fences from both instances) would be 
>>>>>>> non-0.
>>>>>> I mean on inst1 the job scheduled is already complete, so 0
>>>>>> outstanding fences, newer job is yet to be scheduled
>>>>>>
>>>>>> and commited to ring (inst1) , this doesn't mean decode has stopped
>>>>>> on
>>>>>> inst1 right (I am saying if timing of inst0 idle work coincides
>>>>>> with this),
>>>>>>
>>>>>> Or am I wrong in assuming this ? Can't this ever happen ? Please
>>>>>> correct my understanding here.
>>>>> The flow looks like:
>>>>>
>>>>> begin_use(inst)
>>>>> emit_fence(inst)
>>>>> end_use(inst)
>>>>>
>>>>> ...later
>>>>> fence signals
>>>>> ...later
>>>>> work handler
>>>>>
>>>>> In begin_use we increment the global and per instance submission.
>>>>> This protects the power gating and profile until end_use. In end
>>>>> use we decrement the submissions because we don't need to protect
>>>>> anything any more as we have the fence that was submitted via the
>>>>> ring.  That fence won't signal until the job is complete.
>>>> Is a next begin_use always guaranteed to be run before current job 
>>>> fence signals ?
>>>>
>>>> if not then both total submission and total fence are zero , example
>>>> delayed job/packet submissions
>>>>
>>>> from user space, or next job schedule happens after current job 
>>>> fence signals.
>>>>
>>>> if this is never possible then (v3) is perfect.
>>>>
>>>> Regards,
>>>>
>>>> Sathish
>>>>
>>>>> For power gating, we
>>>>> only care about the submission count and fences for that instance,
>>>>> for the profile, we care about submission count and fences all 
>>>>> instances.
>>>>> Once the fences have signalled, the outstanding fences will be 0 and
>>>>> there won't be any active work.
>>>>>
>>>>> Alex
>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Sathish
>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>> Whereas if instances are powered off we are sure idle time is
>>>>>>>> past and it is powered off, no possible way of active video
>>>>>>>> decode, when all instances are off we can safely assume no active
>>>>>>>> decode and global lock protects it against new begin_use on any 
>>>>>>>> instance.
>>>>>>>> But the only distant concern is global common locks w.r.t perf,
>>>>>>>> but we are already having a global workprofile mutex , so there
>>>>>>>> shouldn't be any drop in perf, with just one single global lock
>>>>>>>> for all instances.
>>>>>>>>
>>>>>>>> Just sending out a patch with this fix, will leave it to you to
>>>>>>>> decide the right method. If you think outstanding total fences
>>>>>>>> can never be 0 during decode, then your previous version (v3)
>>>>>>>> itself is good, there is no real benefit of splitting the 
>>>>>>>> handlers as such.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Sathish
>>>>>>>>> If it is possible, maybe it would be easier to just split the
>>>>>>>>> profile and powergating into separate handlers. The profile one
>>>>>>>>> would be global and the powergating one would be per instance.
>>>>>>>>> See the attached patches.
>>>>>>>>>
>>>>>>>>> Alex
>>>>>>>>>
>>>>>>>>>> can be a sure shot indication of break in a video decode, the
>>>>>>>>>> mistake in my patch was using per instance mutex, I should have
>>>>>>>>>> used a common global mutex, then that covers the situation 
>>>>>>>>>> David is trying to bring out.
>>>>>>>>>>
>>>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using
>>>>>>>>>> flags to track power state could help us totally avoid this 
>>>>>>>>>> situation.
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>>
>>>>>>>>>> Sathish
>>>>>>>>>>
>>>>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David 
>>>>>>>>>>>> <davidwu2@amd.com> wrote:
>>>>>>>>>>>>> Hi Alex,
>>>>>>>>>>>>>
>>>>>>>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>>>>>>>> it is unlikely to have a context switch right after the 
>>>>>>>>>>>>> begin_use().
>>>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer
>>>>>>>>>>>>> in case someone adds more before the lock and not reviewed
>>>>>>>>>>>>> thoroughly)
>>>>>>>>>>>>>          - up to you to decide.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> David
>>>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>>>>>> If there are multiple instances of the VCN running, we may
>>>>>>>>>>>>>> end up switching the video profile while another instance
>>>>>>>>>>>>>> is active because we only take into account the current
>>>>>>>>>>>>>> instance's submissions.  Look at all outstanding fences for
>>>>>>>>>>>>>> the video profile.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload
>>>>>>>>>>>>>> profile
>>>>>>>>>>>>>> handling")
>>>>>>>>>>>>>> Reviewed-by: Sathishkumar S
>>>>>>>>>>>>>> <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>>>>>          2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>>>>              struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>>>>>                      container_of(work, struct
>>>>>>>>>>>>>> amdgpu_vcn_inst, idle_work.work);
>>>>>>>>>>>>>>              struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>>>>>> -     unsigned int fences = 0, 
>>>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>>>>>              int r = 0;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>>>>>>>                      return;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>>>>>> -             fence[i] +=
>>>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>>>>>> +             struct amdgpu_vcn_inst *v =
>>>>>>>>>>>>>> + &adev->vcn.inst[i];
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>>>>>> +             fence[i] += 
>>>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>>>>>> +     }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>              /* Only set DPG pause for VCN3 or below, VCN4
>>>>>>>>>>>>>> and above will be handled by FW */
>>>>>>>>>>>>>>              if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>>>>>> - !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>>>>>> + !vcn_inst->using_unified_queue) {
>>>>>>>>>>>>>>                      struct dpg_pause_state new_state;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>                      if (fence[i] || @@ -436,18 +442,18 @@
>>>>>>>>>>>>>> static void amdgpu_vcn_idle_work_handler(struct work_struct
>>>>>>>>>>>>>> *work)
>>>>>>>>>>>>>>                      else
>>>>>>>>>>>>>> new_state.fw_based =
>>>>>>>>>>>>>> VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> - adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>>>> + vcn_inst->pause_dpg_mode(vcn_inst,
>>>>>>>>>>>>>> + &new_state);
>>>>>>>>>>>>>>              }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     fence[i] += 
>>>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>> -     if (!fences && 
>>>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>>>>> mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>> vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>>>>> mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>>>>>> +             /* This is global and depends on all VCN 
>>>>>>>>>>>>>> instances */
>>>>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>>>>>> !total_fences &&
>>>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>>>>>                              r =
>>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, false);
>>>>>>>>>>>>>>                              if (r) @@ -467,16 +473,10 @@
>>>>>>>>>>>>>> void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>>>>>>>>>              int r = 0;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>>>>>> + atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -     /* We can safely return early here because we've 
>>>>>>>>>>>>>> cancelled the
>>>>>>>>>>>>>> -      * the delayed work so there is no one else to set 
>>>>>>>>>>>>>> it to false
>>>>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>>>>>> -      */
>>>>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>>>>>> -
>>>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>> move to here:
>>>>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>>>> I think this should work for multiple instances.
>>>>>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>>>>>> David
>>>>>>>>>>>> Alex
>>>>>>>>>>>>
>>>>>>>>>>>>> David
>>>>>>>>>>>>>>              if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>>>>>                      r =
>>>>>>>>>>>>>> amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO, @@ -487,7 +487,6 @@ void
>>>>>>>>>>>>>> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>>>>>>>>>              }
>>>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -pg_lock:
>>>>>>>>>>>>>> mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>>> vcn_inst->set_pg_state(vcn_inst,
>>>>>>>>>>>>>> AMD_PG_STATE_UNGATE);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct
>>>>>>>>>>>>>> amdgpu_ring
>>>>>>>>>>>>>> *ring)
>>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submissi
>>>>>>>>>>>>>> o
>>>>>>>>>>>>>> n
>>>>>>>>>>>>>> _cnt);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission
>>>>>>>>>>>>>> _
>>>>>>>>>>>>>> c
>>>>>>>>>>>>>> nt);
>>>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work, 
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> VCN_IDLE_TIMEOUT); diff
>>>>>>>>>>>>>> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>              uint16_t inst_mask;
>>>>>>>>>>>>>>              uint8_t num_inst_per_aid;
>>>>>>>>>>>>>> +     atomic_t total_submission_cnt;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>              /* IP reg dump */
>>>>>>>>>>>>>>              uint32_t *ip_dump;
