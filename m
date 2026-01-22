Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315E2C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EBC10E989;
	Thu, 22 Jan 2026 10:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1gEsC3oJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8970A10E984
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4DYYHCI9jcW/98zAtYorWHc2N8Ap/l1H0Y9AAiR4N6OcFXbKycL/aLlvRMC2LbFZ/tyyvePp88yWTU6/dGl+xl41viEnoDAMKcagiNuB/p4Vf0mtRHlYvAl0i+syhPD6/SuJDBtK2xqge04v/b3XxYpMzsPieAd4FLw8dr3rzEuodo8TcIgAHXM+H5hhKF3lkAMMmS6jLbcZYj+9kefEYEq4CoPIr4NGcoCupsya+ouE6OGZljb1dU+QtvHbLul4sLzCR/TEVcPLTZKTOu8M7/sFeVG32AcRbJbRUt1a2LSqtRJOGbu+Y0D1bRi0P2/Ail5qPpayiLUiiPdunZuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU7GM5X/JZzCcSpqPhFRbKTqTzdi9604oeEvpSfnNp0=;
 b=OrmxyAVBGwNG8MhtwTgWVORJmrU0cDKmYdqhRd3H+yPgZIV/4kjiEefBV/QUzWgzMhofiszwY5Fz2jWR1E6w6VW0MxSNv/LUXP9CRXNmvjDIIqPD8Irt4oWHofdiGoItddExMh3cCKwdJFNBadgBCY8dBXItBINI/sgL8SF84RxJ+aC9nXks0iOJZQVjkG3wXC8xFy3/SjZzuPUUilV7r2DSu6+km+Yd9fqhpJBCjbO5TFn2YV2zCt8AnG9Q46EtHBoWIL0m8CSBuXX5dBUWFHDPywtbCdcv79OG5fSUx/rD3gORI+h3ryEwd/1wv41XF7p3LXpOeri/JX87suX8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU7GM5X/JZzCcSpqPhFRbKTqTzdi9604oeEvpSfnNp0=;
 b=1gEsC3oJN7ljPq6mgtYdknLyx/Q7eiyeDFzinCMe851WqQOAaAOZ3L9XtEAP6s81yEDJpOoKaHRE/i//pfmJIkX86Jxu73zhJSdPTMfI1JwugkPmyqp2Ye1L6j8/7eqTovF9kZwJ+XZ3mKhtVVuxPMoWSPxlETZUoMVPR7ZrEFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 10:44:18 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:44:18 +0000
Message-ID: <d7f45afa-5c79-4b98-824e-9ca0adbb60f5@amd.com>
Date: Thu, 22 Jan 2026 16:14:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Refactor smu feature bit implementation
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 kevinyang.wang@amd.com
References: <20260120061402.1287680-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260120061402.1287680-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ea0e96-ab5a-4173-5cc9-08de59a3318d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzJKRW5pbGpMakVZL0U3ZGJ0UURVMW0yTlJ1MFJyOU83cHovUTNMUlJYNFhD?=
 =?utf-8?B?Umt2aGlIOTE1eXpXRlBPaEQ0eWtoK0RNdkRFRGJrRFoyOVByVTdrTFRtMjN0?=
 =?utf-8?B?YWRYZ1hiSXloMjVGRVBaTVZyT3VhenNwVW43SjJSTFBRL3hHSGdZckpEV3hN?=
 =?utf-8?B?cnpKQmx6R0lNQmJhdndOVDlNNDlFNnFUMGxuNGdNamIvZGZkOUNGd290SlZv?=
 =?utf-8?B?V1ZCZHNDVjhKVWswM0NVTHhYdHRSRnFkbzZGTmYrZU8wb3JIZmdJWWNKSVc1?=
 =?utf-8?B?bTlmT2hsOVhuSkZHaU11R1V6WHpvUEJxTGpsSUhiWDNWamFTbXN3M09CTENn?=
 =?utf-8?B?UTBmNG5TTnYwei9VN2luTHQ1SVg3K0ZFRkNwdmIvVzFoNFhneWUzN3RVY2sr?=
 =?utf-8?B?NUVBbitRUG9YWE5BSG9uRkFIVDR4RS85UTBJbFRjOU9yUjFHSGtRS2RMelho?=
 =?utf-8?B?RzlkUXhlRjRpaG9oY2dKTFFTZ3VuTmFXWGwrQ3RmejRMeE5sYnhCMFcrS1Jl?=
 =?utf-8?B?cnBsRFltTkhxVGtWNVozSTlVM3NUSTBWUGpXdmp1R1p5OWdvbDlTa2VJK0dF?=
 =?utf-8?B?VUlzb0xVUlc5WWJoZmU5VXRWZnMrRkRHK21lMjNhQU5YV2prTS8walRvQjY4?=
 =?utf-8?B?R1htSmFxOHo3RnUxYllYTkNjUWhyeDIzNGFsNlJLb2xTcTIxdzRtaEVsdzkv?=
 =?utf-8?B?QzZNV1E4NXMwU1RScXh4RlhBMVNsSzZPdy8xMFdkeUR0TjUvQXRiUDVvWW9z?=
 =?utf-8?B?R2pqOEUrRFlSVzg2WmNhV2Nna1RnSE00VGNJTjZPeGo0c1o2Unk5Zk84U3Bx?=
 =?utf-8?B?SzJ1WXZxakpUREpHR0pUbk81RE1IVUp6a1Z3QlYvR2NFWjlvRVJPNFlMQkxM?=
 =?utf-8?B?VCsvT1NzanhJODlYNk9xcWNCQ2VDOFY1RklKbmptVytZby9ERVVqWWZkZFda?=
 =?utf-8?B?emxWbWMyMjV5ek1wNTBBUGZraHJvSlJEQVpSQzNLNzFzOHF4ajRlMDJGbnZ5?=
 =?utf-8?B?eU9nK3RrMElRSW5ja2x4aHErbzFKUVRxcDVCNVN1czVkcTJ6L1BFL0VWUVRo?=
 =?utf-8?B?Q0VVa0Y2ckFLbVUyaW9laHd4WG5jWmRTZTZjS1ExaE9qSTIyVnFlSElFV1Nz?=
 =?utf-8?B?Ylg0czBBNVh5OFRNaTE4MWdWbjV0bytjbTBuQlJrMUlJMkdTWVZzR2kvNnNW?=
 =?utf-8?B?K1o3SHFJSVNHUVM4NHRhaUpLeTJqaVE0L0cxQVU1K3pMblJyRGRpcFVESjVB?=
 =?utf-8?B?REg0T1Q2NGdURXNMcnNtdUx0cmg4Qm1wRHZ5Q0pIMjBIV0NHQ0xMYlFiS1JJ?=
 =?utf-8?B?MEhvNHhkbnluc3RNRXA1N1VJdXVXT3NXZjVLNUcwaThESDVhT1BOaFpVSXh4?=
 =?utf-8?B?SmVGVjFHMWFEL0lLeEw1K245NWlJcEhKK3IxWU1wVEVyVUlpanpFVTI4VHZn?=
 =?utf-8?B?VXpqenlYYmZCRDdjWFBuMzFLQXhsWlBUWHRQSm05ZXcvVi85bTY2MVo1K1Jy?=
 =?utf-8?B?MVZWM1Z2U3RxaTlFMlY5bjRROE8rRkFrc1U0a2ZER0d5SGJ0dkFOQ0NJYTls?=
 =?utf-8?B?cm1uNUdnbTNHK1NOMmVTNGhhVzQ4Vi8wUTg2dHlYOTBLbnUvK0ZkdUw1UmVq?=
 =?utf-8?B?UldFTWJNVlkycmtLQUVuaFJuMlQrcDh6V2dNalcrTmlOMmZOYTNrTVFEL003?=
 =?utf-8?B?OGx5b3dkMk04WHpFcDVYeFlPSnJYeThEamVVMmZWVkY2RVhkaDVBMFhTOEVB?=
 =?utf-8?B?QnBja1ZlWTVnTFF1OGRvZ0JEdlNDTDRXa0dhUWpkcjZWWWlHR1FydjlDbEVp?=
 =?utf-8?B?WU9TTnpybngzdjFnY2hvdzEyNWVLb3dybGExai9na2FxK2ROMkk0QlFvR2x1?=
 =?utf-8?B?OVVtdzlDYUVmU2F1TFY1UjFTNy8rSE9mY2hkek9oZzQwaG5TQm1RdG4xbWI1?=
 =?utf-8?B?Z2toeGFUT0d6S1RqckhpZXRwNFoyZEZxcTBvNWlBdGNUWlBRQXNiWTlEVWpt?=
 =?utf-8?B?cE12aTZMQ3czN2xHS1hWa0Vmakx1NGk1eVp5WnVrUzdPOTQxcmpsR29CdCtD?=
 =?utf-8?B?U1FjSHRqalJRd3JFZ3V2Wld4ZEtTZmdBNWRydGU0VUJXa3JJcjVkUmpOVnI4?=
 =?utf-8?Q?djjI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1lTC80a3BmUTgrd0Q1SVkvb1lMYTdsWHFNdklrVTRqRjVlNGFCQjNqRE8v?=
 =?utf-8?B?enhsczZQUVZZT0xNUHpIQVdUa2JDM2wvUDBuSEw3Nm43QTJzaWdTSGttRW1U?=
 =?utf-8?B?dTBNM3YrSytwYXlINUlxTTVLdUFhc3kybC82SjhLaEJ3OEg5UGdCSVFFcmdN?=
 =?utf-8?B?WlY4TDY5bFRIem14QzV3NUdCa2ttc2t4UGVPY1BVQWJtU3JtVnh0UnlOZjNW?=
 =?utf-8?B?T091Mjh0b3B1Ym9JTHI4ZXZ2ZUVFYjhHNVZkVXJCQjFpVjhFWkE3aE5PR0Ja?=
 =?utf-8?B?YXYveXZlbVdvci83RW1tbHZ2eHI5cUFuUDNRRWRIZTJ3RXpkVGx1SjF4b3dw?=
 =?utf-8?B?WlVCMjM5eDRoYlJjK1F6OTZBWjdUaDRtRmtOVjVlOEd4REJEeUYraENIOTl6?=
 =?utf-8?B?Q3lJVEZ5NHlVMC9LbVozbDJqRG9NdkFpcHdDb1BIVTBRQ1FEaFVsUlB2SUFC?=
 =?utf-8?B?Uzd0R01qNE5pRU41cGhYaWZFU3V6WW1CazBIaVpjOER6R2FJZzVuSkFmSERq?=
 =?utf-8?B?WVZsZ3l4cHRoREtOV1p5R3pFdk1iQUVrVUN2SjEvS0RjZXFTVGJuYm5XTjRi?=
 =?utf-8?B?SGZsOENKZmpFejNoN2dBM21UcFdhOGlkVzY3RUJMdkZpc3N1NlA5SjNZWmN4?=
 =?utf-8?B?OGRYOXlmWXBpemJrL0RGM1hac0JGaklFTUd0MGNDSnFCYUg2TWg2RTdnVTZD?=
 =?utf-8?B?dkFKNVRiajNQeDZLV3g1cGVDYWw0SXdrTmU5bndjRHZhQWtyUloxWWFVYVhJ?=
 =?utf-8?B?ZnMyT0JETjFnSGFBb0NvTGlzazFpWUl3bnYzdUVJQnhJV3ZkZjR5b0xpeDBX?=
 =?utf-8?B?ODRSbXoyZFpxZUtKSE04clk5dUJRSkxzbFZmWVQ3ZzZYVmxJTmlhUVJLUWkr?=
 =?utf-8?B?YzRVNXBHMGhOTG12a0NzZ2V6ZFZvNlowZWJCdHZ6NkhRYnZBTEVCUjhZT2VB?=
 =?utf-8?B?NVlsS3pRWS8yOXRMYUVpRWhJRU9JUGpsNVpuYVdXR0VqdERlZkZUVlVIam9h?=
 =?utf-8?B?QjNpOGtEODV3OWhsbi9jMDZFQjJrZFRXb0tRUmNoKyt6S3Y3ZWQ3NGlEMlVt?=
 =?utf-8?B?WlpEYTZiczQ3NDc5aGZ6ZlZRRFFiaVZ1dDUwaVFpVVhRTFVkb3ZBSE00UFVQ?=
 =?utf-8?B?bDdwSVl3TCtwcmFwdC9RQnVzZUNwc05HUjR5bTNZV1BUb0Z4T2dicjhqMGE5?=
 =?utf-8?B?cjM5bDNKWGRGWE0vMkxmaTZCUERmaVYzam5ENEhTMjJUUDk3elVncUtYQnVC?=
 =?utf-8?B?MzVmVWEwUzA0SjdPWmJvZW9FL1VheFlDcEQ0NTBESkJzaWFybFJxYU9zZXky?=
 =?utf-8?B?UjBhVlNkM3BLOWRySEM4WEN1WWpKd1JlN0JjaEd1T1IwODBxSzZSL3YzTkdP?=
 =?utf-8?B?cWdZZzZ3MjlmNWF1S1pQcit3ZDhveEcyOGlTNjlLS25adHBNbU1CSzNFV0Fh?=
 =?utf-8?B?aFBFNlZubGFnbmFvVjlBNjA4a1B4L2hWRE9BY1NYY1FyZUVmK3d6bENYeStt?=
 =?utf-8?B?OWhRZUZNY0VIY3FqVXQ4WXRZc2J2c3VvZFozc3VSZXpWTHBUR1hUVnJYRVh4?=
 =?utf-8?B?MWZxWHVYR0FZc1hhWi9FcHg4VW9JeGthdEdjNmlqRkovSmN0MDNmTDZBK2tl?=
 =?utf-8?B?aERCY0dDSFFhRWpuelZvQnBxcHhSaklMQ0VEak9HMk5ZOXA0aXZNRFhLN2Vu?=
 =?utf-8?B?NnZodW5YVmZLK3JlSW1yVG50ZkhWbUdURzRUTmdnUmpBcEJ6RnVrWGlicFRC?=
 =?utf-8?B?WlFNMmlrOFN6U29GdmxYQkd5aVBsY2JMcDdiaWcyNVhsbVg3MHJLUzBXbGM0?=
 =?utf-8?B?YjFjWE9QQlRoVjM5aG9SRlBBZENUWUFmdUU0NHJ0T0t3cWErQ2pQSFUvRXJi?=
 =?utf-8?B?QmR4d0dLUFVHVGtWVFpHbFp1ZGk4Z1M1MjRleTIwbnk4ZFcvVUFxZnZVeHh5?=
 =?utf-8?B?U3hhU2J2T05ydWY5UEU0c3lobGRkeFdGY0V1cmFXTW93WFhhWUZyMWV6Tm9F?=
 =?utf-8?B?eTU2bkhnc2dQay9yNGZVakhzbDl3LzVBaHdFZGc5UlRLYWhXbEV2a3lBYTVz?=
 =?utf-8?B?dWl0RTJESitoY1FWbGVEbWxYN3pwWUtnUGJ1b2UxcXFoNGIySVNxMmx0SUtD?=
 =?utf-8?B?WTk0VTJFUUJpTVRoeG03VGczTnJoY0NEWWNydnFwRXd5TS9EU1U3YnZmNENi?=
 =?utf-8?B?VmlvMlRQWUlsZWZ3L01rejFpbVhhQkpCS2JYR2dTZjZHZTc3UzFBUWZZZjRs?=
 =?utf-8?B?R3lXUCsvb2M3V0Y5MGJRTldpQW1TZkt6ZkFaVGFoeTFKWmhnYWovemhmVWtM?=
 =?utf-8?B?QWxmM0RBeVB5cWJLWkNBYk8wSVhaa3B0RHRFajZ0RnY0akIzRlM2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ea0e96-ab5a-4173-5cc9-08de59a3318d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:44:18.2881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27Grw4ujjcw1VgMv1lrftlOP/RE8a/f1xK8baDcE7afikztE55iETxHgoSZwa1/l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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

<ping>

On 20-Jan-26 11:42 AM, Lijo Lazar wrote:
> Presently a 64-bit bitmask is used to represent the PM features enabled/supported by SOC. The
> number of features has grown to nearly 64 and could extend beyond that. Instead of using a 64-bit
> mask, implement a data structure around bitmap and move the implementation to use the datastructure
> instead of directly operating on 64-bit bitmask.
> 
> v2:
>   Use to_arr32 instead of direct assignment
> 
> Lijo Lazar (7):
>    drm/amd/pm: Add smu feature bits data struct
>    drm/amd/pm: Add smu feature interface functions
>    drm/amd/pm: Remove unused logic in SMUv14.0.2
>    drm/amd/pm: Initialize allowed feature list
>    drm/amd/pm: Use feature bits data structure
>    drm/amd/pm: Change get_enabled_mask signature
>    drm/amd/pm: Add default feature number definition
> 
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  48 ++---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 204 +++++++++++++++++-
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  33 ++-
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  24 ++-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 119 +++++-----
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 116 +++++-----
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   5 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  29 +--
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |   4 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  37 ++--
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   6 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  58 +++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  20 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  34 +--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  29 +--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  39 ++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 103 +++++----
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  29 +--
>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   6 +-
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  33 +--
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  69 ++----
>   .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |   6 +-
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  33 +--
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  82 +++----
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   2 +-
>   26 files changed, 662 insertions(+), 508 deletions(-)
> 

