Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82855E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 05:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1721210E3E0;
	Fri,  3 Jan 2025 05:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oIJ3Yznv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F9C310E3E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 05:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFJzMHZgBqp9h7D6mWGws1rmM1mKdiYv5Q2+WP+kKlGSQjELGYgcxWWOiFVq4kqmlQlT36Shz6PSuYwCVoFJYiUr+fbN6XajNtP2EwxZlgnntsfm+N7Xjinco7WuiP6I7ppfS61cuvjox1BndeLzXcUoXAj0072s0AANHkoZaiJDn/DBqvo4i9/MmtBJxL97fkzMwSmtRJuYoW3NBcmaiLtFfsWAXslWO3a3M0EiaBLlXoOGTlgCAMlkUekoHGbFemCBQuuG3c/UXIvFGF1luZtVFEhqGkJUbztFnkMoYu3GS6CTchiL9O9FmMknFsGFIRWQVPGAI6IqVoNyOASd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWLzdTNbsXhWjuWghrHr8g5PsF7xTtNtqC6H1ySZrdk=;
 b=FCl/iixClxtjdnrdv+iHUOCYnXKp03+3i6WG7/fvjH6Le3ECTMqik7Bw11PV4IZQQ2YE2TnzacHssn3/ZGOBm1LETO+wQGQ6x/r83fZmCdXv4Isx9niZejKfc5GQN1R7DsaTjfU0y1+9iwHXSrMaziP/YJ1Ok3/T7RmRdNwJz9Rtbk8BP2b9ofcN7YJ2BJt+6sVXHLcqUdBc+xcj4HCNuHiWtAVGok92qdYpX5qmfpqhC1JCYlLfgSYcmWPje5n4uT5VtpZ8rEU6o3w/bTcA+de+D3QHEr1VUUpN+UbvfX9pIygjw31O13y2shjBUjaKOrrORbPkXhe6LtTpJH/g/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWLzdTNbsXhWjuWghrHr8g5PsF7xTtNtqC6H1ySZrdk=;
 b=oIJ3Yznv5E/kX5e9hOBtNziO6H0LVBMBZAQYjOENR75nvWSzdPKPfkLAeS4bEJNaAo7VZAt2bwv4O8bqzdA5cX1fpvyY2ESHSIEktk/3SFFURzMLjTaiiwFw4CT8IJlwr3QyeWwKbWo59c1+FSdqOT8/LIrPzdXnRd5atPZ1RKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 05:20:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 05:20:54 +0000
Message-ID: <21bf90ae-f877-4194-9186-d01b3216287d@amd.com>
Date: Fri, 3 Jan 2025 10:50:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 kent.russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::33) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: c37fb05a-5bd2-46e8-81cc-08dd2bb66591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2xJdzVaUjlPV0RSSmVSdFpoYmhiRzJvVitybUxDelZGR2JTR1dzTzlQRGh3?=
 =?utf-8?B?cUE1YTI2dC8rUmRJTXp2U0VjS1RDMHFGSkpiWVhuVHVLWnZuVVoxU0VCSEdU?=
 =?utf-8?B?SDdlQ2V3a0UreUJTV1VQNWwrWkRuY3kxZ2VqUUdXVzlvS0hKblV4VnVValhJ?=
 =?utf-8?B?SVpxSHZOckM3bGpwY0FDSkdhOFRGK2lKSDBRamdhQVZFVkRlVVcvNHExUGRK?=
 =?utf-8?B?bHNReTdsZUtoTGlya0NPWTI5cFJOTzhQVTJFeFMveTJPdk9BZ29tTW0yTFFa?=
 =?utf-8?B?UGlwQ05ta094K0p3ZnVOb0d4aFVVOGFYSTN0aEdaYWZvbHo3TlZVUWJpT2Za?=
 =?utf-8?B?dUF1K0dDdE1NOHdlRHVKL0cxQXpBd2czSXBjTHJpUkdrMnQ0aVlPamU2aThz?=
 =?utf-8?B?a09ORDYyb2JqdHgvdlZhWmpsZW9yYlh4S2pYM1VNc1F2bXFHRzBMbFVVR1k4?=
 =?utf-8?B?R1lDY0ZBU3pmYVM4ajFGazBNUTZDajlpSFRQdVBIamhWeDVOODJydXdtRzlj?=
 =?utf-8?B?M24vRkVQQ3pFMEpzcm92emNPVmhoU1Y4dGVzRVIwbGFRQlBDUjRrNy9LbHFZ?=
 =?utf-8?B?UG5obWhCUG0yc29Gd1RaYnRiMmxiRERnT0MzeEpVQXN0eVBDQ2dWaGljK0Qr?=
 =?utf-8?B?UlY4QlVYd2grdi80MlBabkYrTUIrTERtVldWTEFvc3NKSVoycTJMWTBGV1Vj?=
 =?utf-8?B?eXpEQTJDcnFMZWtFVUU0K0VEdTQ0UE0vTU1SVkt5eGI2bTBNdjBRMkUvNk5Y?=
 =?utf-8?B?Y0dTY0FIMDI1YnEyY3Q3ZEVralFtejdJMDE4TW9Nb3pIM1dRVFEvUUo2aTdC?=
 =?utf-8?B?QlhhOUJZUWpQeUQ3S0NEUUFXSk5XWU5IZ3JSM1E5NWRLZnVvTEpuR2Z4OUFU?=
 =?utf-8?B?RTgrTWkrR2txcXd6Mk1LakMveXhoeVZLcjlVQlJLVzV6MnBtVHBvQ0NrSGhD?=
 =?utf-8?B?VzJhNVJORWpWSlc1T2d1NnJveThPZ1pFVDR5alo1RG11K0Y1UTJuL1RJZ2pj?=
 =?utf-8?B?cUd1ckVEa3RzRG1VMDh5Nm5ldThkbC9WaW94MGFvRFVtb0NqR1NqOTArcm41?=
 =?utf-8?B?RVJVQjlESi8yQmt3bjkybGdLOXBjRllUZTRjeGxpNTlOUWIwK2Iyb1ZUUnpo?=
 =?utf-8?B?aHdFK05kUEJEVStFTmpIREpsa1JHejI3cHVKRGswQ2JVZjJ4VXl0VGhZMkV3?=
 =?utf-8?B?NnNxYjFoZXgvR1Y3SVNPRVZDZW5iYzFkVkRrT3A2Wk1DL2ZmMXcvb24rOVFZ?=
 =?utf-8?B?MWl4ZHRRL2lzc2hBc1RZbHQvYkVxejlKZzlvRkVaTW5ZY1RNVTZLbHJHbDk2?=
 =?utf-8?B?OWZHVzhyNTU0ZUV6QVBCc3cxQW5zc1FqVG9QMXgvVkZOVHBDMnhmYXpSd2gy?=
 =?utf-8?B?OWo1a0huYytWY09LSkl1NWdMZjNxYnpPRE9kekx2Z0ZZR1RKQzI5NU1kSWQ1?=
 =?utf-8?B?bHZ6cEV2R1JVM2lVb3NRNnVNOEliRTdXTDJ5dU8rMkZrRXZxVDdoNGk1S3V4?=
 =?utf-8?B?cG14YXN1MzBUdTJFd1pFS1dvNUtVVk90b2EvUnBXOFRheEF4MHZKbkt5bXhl?=
 =?utf-8?B?YXJvT2pmNmczcGw5d2tuMkdteS9wOHpMMmtRNXpINk8wYTdXSEpYRTRZZktr?=
 =?utf-8?B?S0tGV05xVFQxMjZ5VHRFNlRQUU5kSXhZajlOZ3lxdmhzK2NoTmRGdkEvNGQ2?=
 =?utf-8?B?bFdJSVNhKzkrNC8vYkdJU1BjSWVRTXVzbHdGdWd1SHZPa2dtQkFvcnB6OTVn?=
 =?utf-8?B?MFlIMjc2SVV1ZVNkdHF5YjM3MVpVTWdGS2hGRmRLQ3VhdkY0OVFXTTFpR2Fn?=
 =?utf-8?B?WnhURXluSGJyZmNQZmg4R2MvdUdwUmdKdUFvbko3Qlgxc2JPT251QktHUjdV?=
 =?utf-8?Q?Z+PwbY4iUNdjR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFaY3RrUXZNNVE5UURQZGw2cUFadWFpenlJV0J4YW1VRlROZnU0TTJGL3ZL?=
 =?utf-8?B?Z1NwYS8rM3QwTm9wc092NjZUL2xzWDZHMHladWVyaFYrbzMwVDB4WVBBNTVw?=
 =?utf-8?B?RzR6Ylh6Yjc5cXZML3drTWtpNWFYVGpUTUhsenJaTzZTMEpISERkRExlcjE5?=
 =?utf-8?B?SUdKaUlKRkFFQVZXK3BCUXhqQi9DZmZ2cGMyYTF0RVhOYW5XVTM4RjhNU2pO?=
 =?utf-8?B?cjJBOE9NOStKNGFnTjRxb2hrdURUTWZrT09iVG10YTA2Rlk2Z1BIRlhGd0dS?=
 =?utf-8?B?Mm1MUjFoWnR3azFIZlE3VTlWNVcyYlM0NitPakozeDZ4czBlZGg1eVRxWkRu?=
 =?utf-8?B?S2txT1JtblcxYkFaWStqQ0tRSytsd3RKd1pDUUhwZk5xNk40U0tVMlVnN2gr?=
 =?utf-8?B?RDJpOVJFeWJFZkkxcmFDbkdJaktyV3pMbzhzbTI1TlZabFhpWXNtV2s1VTUr?=
 =?utf-8?B?ODhmc0kyMzRKQ3RtWlJFZ21rSWJuSHNEcmoxbGdJWjF0TGJ1bysvMHd3YXJU?=
 =?utf-8?B?UmZpTFltdWUxaEtGS2FtbFl3Um5VUGhhRnpUaEsyZ3drMTFuZ2ZacU1YaUxD?=
 =?utf-8?B?ZlpKQ0NMeXJZK0dsUHI0ZkFXU0dtR3pQRUdHWUFKdzBpcWRuZEpick92L3VW?=
 =?utf-8?B?dXJOcE9EOTJ1SkZ6RFFQd3Zlb1YvUGpIVnpRV1Ireko2dHloTlFBOFRVY3Nt?=
 =?utf-8?B?WkpFQ2kwazVUbC80UFFWY2hqQldpcWNCa051Y1Y5ZkQ0NmhZbEdLSUUwemVi?=
 =?utf-8?B?dE0wNDZNNHdSeExsa0lnQjg5KzJsRGptNG5ZY1NJdjcvZFFuZ2pZeHg1TGVs?=
 =?utf-8?B?dmhEZUVOSStDTnZsM0xyTElLNkNwMGhveGJRN0hPYVEyTW5rVEpMekZKS0V5?=
 =?utf-8?B?SWVsQlhJWjhSZm00RlZaVU1EQkJaQWN2MnlvamM2aGQzbE13UXl2QmRzNGQz?=
 =?utf-8?B?Z3o0K3V0WmsreEplL0VwUUtoVlV4VlZqbGJHeE1TMjBhMDlGc3BXNThYZElG?=
 =?utf-8?B?NzV2dDU3bnRGcFpweEdZcjkvUjh0aEticTdWUVExcVNNRk9QZlAvL2JVMTNy?=
 =?utf-8?B?R1ZCZ1VvTEVUR0lyRUliU3lmcExSdDFsWXFWclBvZGliSUxGMXlnT1lMbXQ0?=
 =?utf-8?B?aTFnZ04zWlZNaVJpSDB6Qjg2bDZ5Nk5RRGdxTU9QQzgwbHhJaUY5aXVwVEJp?=
 =?utf-8?B?VVlUSVFtVkxLQ1RpRVZPSU5PdDVJMXNzMXJSQTczUlA0TWI3TTNRQzV1bmE3?=
 =?utf-8?B?WGtLWGczQjQ1YWpnTEVjWFpRSXpPc3ZLNEF6a2hTY00yYjR1dkM4K1N5Wko1?=
 =?utf-8?B?SVM5aFFBWTQ3QVVUZFp5UWFPcC9BSUhEN1JhZzVGR242M2dYeWpGV0VhWUFa?=
 =?utf-8?B?VjlsbGtoVFRXZFdiNFQxbWcxVnRia2x1L3I3VEJDQmp4dDhnWWJWelJuazc1?=
 =?utf-8?B?dmdpbDgxQjVHUDczVEU2dnY2K20xQkx2V3ZpS3hMK0Z2dXFjdzJ6QkVkSDln?=
 =?utf-8?B?ZU5nWk9wUk8xd0lPOVNCTmd4amViZHNyM0g3d1RWb1dGbkprUHh6N2xYK09L?=
 =?utf-8?B?Q3p6SlpCVzFOVUhkaGw3YzZxejVqVC9hNVpDNzdOd1NwQTNTdFd0TWRhelF6?=
 =?utf-8?B?UURJT3RvQUdqQmxyZWF0aVNwdEcrcU1iQ1c1T3dMM2VTejMxcXdKeVh4eUxB?=
 =?utf-8?B?YjZZenREY1pXNllMUzFoQzZoWnJSc09DZldyWGlLaVFrUkZyZ3ZLOUlXV1Jo?=
 =?utf-8?B?aERTR0thWWJ4cHkvcTQ0aGIrMWp6U25uR1hMcGxpTitGTGlRZ2NETkRrQ2pN?=
 =?utf-8?B?MWEyREZtWVBmeERjcXdRanZKQWNES2ZQN2lrbnBXakVjamNnZURscVIwZTZN?=
 =?utf-8?B?eDVrVkFyTW16MUFYNGpqZjVKVUFLVFpkcUtqYkp5YmFxaThhYng3Z3YwUzN6?=
 =?utf-8?B?VVk3YURHL3Y4YkN2cytVczR0ZzJoeFl2czYyNHRseHFtdFlPUkVZNG0ybTVs?=
 =?utf-8?B?WndLbmczSDl0cjBMZ01JK0JLZmtJVEZzYXl3OUpkSUNiY2lmWEt0SjhSMi9R?=
 =?utf-8?B?ZC90ekRMSW9qQzFZTEQvM1ZQRThSaHJ0WDhWZmdlbEV0eHJ1TUdKUFlmaTZF?=
 =?utf-8?Q?Cbyxb6nAP18cpu8iccaKwP/HD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37fb05a-5bd2-46e8-81cc-08dd2bb66591
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 05:20:54.8290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miuL0pNu1ue9qyfKoOzyEtnfD+Xen8d/nyT+z3sEJDJo6TIU8GFBvDS8lv8hBAUe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813
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



On 1/2/2025 11:06 AM, Jiang Liu wrote:
> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
> after free bug related to amdgpu_driver_release_kms() as:
> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
> 2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
> 2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
> 2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
> 2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> 2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
> 2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
> 2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
> 2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
> 43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
> 2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
> 2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
> 2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
> 2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
> 2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> 2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
> 2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
> 2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
> 2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> e024se+0x3c/0x90 [amdxcp]
> 2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
> 2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
> 2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
> 
> Fix it by unplugging xcp drm devices when failed to probe GPU devices.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 5ffe1dad9622..e7f35e3a6d2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -164,8 +164,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>  		DRM_WARN("smart shift update failed\n");
>  
>  out:
> -	if (r)
> +	if (r) {
> +		amdgpu_xcp_dev_unplug(adev);
>  		amdgpu_driver_unload_kms(dev);
> +	}
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index a6d456ec6aeb..ef4eaacf67f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -382,6 +382,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>  		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>  		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
>  		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +		adev->xcp_mgr->xcp[i].ddev = NULL;
>  	}
>  }
>  

