Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AABCAC58F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 10:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEEA910EA69;
	Thu, 11 Sep 2025 10:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2i0OK0eK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A37510EA69
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 10:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9h9MnCi+wO4CeK6CoWA6haD42b5JKQvKt41bZq3b4z0ygMFQHGriF+IclokwCWHsLUQHgqyzjMEbxSSUEsI0xYidEtZcPb27MP/SXqVhp6JEjqURgz191gAt91nmrV6zpUZRrlLjCyoEKLG5U1EU43TplKxWi7lvsJBsMvlds5yP+6oUJzSskAG1CFXtOTQjZHqpY34QC9p74yJxNCt/OoA2GD8Z8N1Rmx3zrJ4IlQi5WL8tXTP7+MZVhV51KoZX75AsqfRnwsRgHHePAS3U1YpV5kpAOpCDKrmD7o1LOpgv7vMj9DY3pFL7MuRzV1xIbIQaEpQEyNgXdYblOAHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SiRNduMhXB0KxJVGWTNvOTgulHIAynCnGip+OcTKNw=;
 b=Ms4F9MG2ngzeFCV/WFE12qEk+ySbCHWW5No0ZigHZFH+GfRpwgB8CDV54CoY72svKcllaSQAgURwAVecsbCPHcxPZqGjPbR9U+OWnFe0zkHL83DkS+IrZAxldMg/qirJUGst7YmVGa140lqV++1h5XvQqAYF5xgpH1MZKX3MuePZRryXwkS7ymjk3uEVfTl24HOiZyB3Z5iM8AXUX5Wdz9pWR3Nc7AB+idtge4pZKKhP8q7ms56bOullJuQm4q+XjYOO/xWXQPDstkv4twAFIrpDx40QzV1+jmdsor1TfifFAuTKbfMSA2pOLKtrIA7NfTtrRdmM//xoZXoXmr8VVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SiRNduMhXB0KxJVGWTNvOTgulHIAynCnGip+OcTKNw=;
 b=2i0OK0eKIRJ+QT+aJ0KMLSpZD46UUm7QDJCfi6s3qEWa2BD8s40/fs5JFVlOfFtPxvnH6NJezy2wTIN0IyV0gTI9sN7PyUN8O7CxP/ebiLZrl5FglyHikt2s/+zUpOYN6FANjDv9ewNiW5ccgvZhwfzXgk8YHp91xii0euFJvqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 10:08:29 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 10:08:27 +0000
Message-ID: <6ea99875-ef47-4731-b472-dbe8d2a0ec16@amd.com>
Date: Thu, 11 Sep 2025 15:38:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: fix userq VM validation v4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil.Khatri@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Prike.Liang@amd.com
References: <20250905112701.2443-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250905112701.2443-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0bcc4d-eb95-4384-99c7-08ddf11b26ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFhRUlA0eEFyZGpURmJJTytyYTY2bktsdFJqclV4VTl2amVLSE5jZGE4cUxE?=
 =?utf-8?B?bTlDaVpnKzUxWkZmOS84ZHlOMEhKMXhhaWF5V1A0QmJlejNjRHhiQmh4RVJm?=
 =?utf-8?B?d1NEeGZaQ1RBaFkrN2l4RzFXY280YittQjVtdzUvU1krVkh6akpJcWxuQUw0?=
 =?utf-8?B?bERQK1BpdjJzRkY3UG9qay9OcENIK29QNXRCWStNd3djd1dQcjc5TDluMkZR?=
 =?utf-8?B?bXZaSHpRZkxyNE9mV3JDQzVXb2gxNjlEQkZEaTNxeXA2TDE4N01XMU82eFRF?=
 =?utf-8?B?ZTI2ZDB4ODMwVVBjZ2JIN3E0MXdEL2MvTlN5aUZzQlhVMk5jaVlSMlhLV0w1?=
 =?utf-8?B?cFFDU0lJNmVOS3E3blJTelpKTHZBcTloRVUxVmxUSjQrTWlCMzE0Skxacm9y?=
 =?utf-8?B?UEh3MlV0eTlZcS9SREFqZlR0cTc1UzFlWHd1YVpZNGFROG8velJOc2xrS1U4?=
 =?utf-8?B?MmhXRXlTalFFL1Y4MzJFdzlSZ2ZYeEZHS0tPTHk5dVdCbkdoWEU3WWNzVUto?=
 =?utf-8?B?ZWdqdHd0VWgxNTZNQm1pSGR5M2k4YzVVcWtGSlgyTTN6ZzhqSmlDRFp0ZklK?=
 =?utf-8?B?WW1oWUl0ZUl3dEhNaXVBM0MzaVJKeWltenhaVFBwRjExZDVvZ0JSL3RQQi9Z?=
 =?utf-8?B?Ynp1Y2R6S01NbkxidXZ2WmhZdmNjaU03TGZHaWRLU2t3ODhsWW5hRjk5Y0Zi?=
 =?utf-8?B?VzAyUk91MW9SRksvbkZyVEV3U2ErY0xJbXkvYnpDVnZZNTY3UmdkcDR3RjRq?=
 =?utf-8?B?VjF1cnprYkpYWDdsa2VOTVQ3eitpOUhzZHljRjVZOWtZQ0p4MTFXYndHeUlK?=
 =?utf-8?B?M3EyQWtEQnFvYlJia2lpMW16dzJiUWdyVWdHNUU5YkNnVXQvMk41R0dCOWpY?=
 =?utf-8?B?QURuVjBUc2FTL1Rlei8rS1N5b1pOcFR3THpocUQ0R3N6am1MNHh5K0tlWENs?=
 =?utf-8?B?Q0tJQjlOeXYxOFozeTZSQmV4QURNVDhBRnpwLy8vV3c2VExtUkF2T1IzZWxD?=
 =?utf-8?B?NHM1dUlXSzB2R2VvYzFYRklTTUxkdTQvVEs5eGJFRFRpdTlmZU5vdmFQdzl6?=
 =?utf-8?B?UW1xbDVLcWJUQU5XY3N0c08yLzgxWGlvMXlwTVRFaklTZm85MXhOcEhleEcx?=
 =?utf-8?B?TzVJV0pvM2o1RGhRMGllWmFIUklXbm9BRjU4L1dZUVlsWlFGSkhHOGZrQ2Fs?=
 =?utf-8?B?eWhEU1oyL1Q4WDc1ZmlPaGQ3VEg0RkxpQXVBLzRPY3NBWVZvenNReDA3amwx?=
 =?utf-8?B?OGpMKzM3OUQ5SXFjL1ptK3RhRWkzRjVtbkNsZXNDbDdtaHhSOUcyaXBOYjNI?=
 =?utf-8?B?U0NSZHJhYzQwNW5QZEZhcDhabml3WGNCdS9rQjRPbkVvZUZQT1VUZDZxSEdE?=
 =?utf-8?B?ek5pR1RscEFYcWpWbEtRa0FCU1BhZVFnKzBlbzN0WFdITzA3blFkczg0d2xF?=
 =?utf-8?B?cVczaHBHelpUeGtNVEVUMTBLNDZacVMwcWVFTFRNWVRPUFpMRCtyTllLeVZW?=
 =?utf-8?B?d1BFUWl5dUJRRjVzUnJJcjRycm43OW51aVR0ekxsK0dvaC80R0h4TzBDeU5v?=
 =?utf-8?B?NVdiTVc1TjNlRjI2c3pRRHBIUFRZeFVRNW1jUXI0RzZOR080cmJXdVdQUDNr?=
 =?utf-8?B?dVNmOFF3eC9mUDZtTHNiNHpmbFgxSWlhZUJ3TUpwZHlVYUY1d20wc0RzZHRk?=
 =?utf-8?B?RFdzZlBadU9JUWwvM2Y5WU5QKzZmeVdpVnQxTVNtZVFnK1ZuYTFBbVJQSHBW?=
 =?utf-8?B?aFVyZlY0UUtEZ0tPcnBnOTJqdmJkc0hpR2RIbDl0YWRDdWR6U21VWlF3N0JU?=
 =?utf-8?B?cEhIM0EwMlBIbVlJWEoxQkduUVo1STdCMGtTOEEyZVRSeU42VGh3cmR5ajFr?=
 =?utf-8?B?aHYrd3lCMU1mUUNBUmczaysrc3lFRU45Y0NlWjFMdURmd0M3SEZNUlhsUnR3?=
 =?utf-8?Q?l3AvkPmJS28=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxySm1qcWJrdzlBNUtISWtiQWtsMmZuTlErYkIzbUZlY3RuajNKSTNnYUR6?=
 =?utf-8?B?cWVMSUFhODcvcjVuYm51N0FlN2t3aUtKclkyL3o0Q1NNNnJOeG03SlRia2t3?=
 =?utf-8?B?cVM0WXRvTmhHdm5vMXp5dWhUQjQ1b2MyeEV2SndUUG5pU3ZsNmE5cXRyVGds?=
 =?utf-8?B?Zlc5ZFIrbXcyTnZETEZLeks2eWZIb1k0QmppcjRxNTJwbGpMWVJ5MExnZnVR?=
 =?utf-8?B?TndZQmhzcW9HRW5pTlR5U3pDc3Z0NmVhTlRHMWNESU5xV21rNjZITUg5YnJp?=
 =?utf-8?B?ZHd5Ri9kaVk0YWZ1UGdsRkg5bXVxdjlzSW1FRVovOGkxMnZ2cElrZkhnKzFi?=
 =?utf-8?B?ZFhxYjhSV2tHZ3ExSmVRMXEzTVJCbGpzN3FjYlpKOUhkVHZqMTMrYUhzd3px?=
 =?utf-8?B?dUJCSVZHOG9DZHZ6cEs4Q3RLYkkxVGM1cWFYWGdCRDh5VitlRHdWZkwvRFpE?=
 =?utf-8?B?bzJCZkMrTmVxR295RXBNNWNBQzRaY3BuLzdOYklPSWJVMlRDT1RwbmRFbmVh?=
 =?utf-8?B?VDY5QzdjQ001WXFaSzl2MmF3SFBKOUt5NWFDZnp6a1ZGc0VoRlY1bE0rSWJJ?=
 =?utf-8?B?LzZvSThvS0dITnkzMG5PK05QSmswV3Z3ZWwwajNTa09ZNTFyZFZwNWI4b1cz?=
 =?utf-8?B?UEgyYzRMVnRNNVhlOHQ4S2J2aGEraUVEaEJXTXl5VTMwRmYyMlhMRmdIZHZv?=
 =?utf-8?B?RFJ2aFVqaVlub1hkUnlBakVGclZzVlpZdGZpS2JhWlpFRlhkTjh4cUZxcCsr?=
 =?utf-8?B?VHhNeHV3amhxdnVXTVZXY0ZwTWNwY1kvdGlmc0czSExwWnB5TXlxb3p3OGVD?=
 =?utf-8?B?RmtQdkNJdHlTMTI4OWp0Wk1rWFFMcVlGVWRjVVNBYkJtUUY4dnU4djUzWVdo?=
 =?utf-8?B?WlRESFdBbGNCMWdhc1JwUVlqaGtHMEkyeUlkWHJoS3NlRTZvRE1rK3ZUTXNU?=
 =?utf-8?B?VGlyTXFocE4zTTJYbW5qQStzTHZlZjYvSWpObDVaMGptWTNyMURVMXBQaEJH?=
 =?utf-8?B?ZEtHNVBkdzZ1Q3gxNUlZTW1SR3hqa2gvMncwMkRCQmx3QUdUOWY3LzdtMlR6?=
 =?utf-8?B?OTgwSHJLMHVSRjJnKytEKzZiM1diZlp5VURkditFeHRBa1VwR3JneHZJOE1B?=
 =?utf-8?B?R0pUMVM3czFSdUsxeDdLa2dIQmgvZWVOdm4wc3lMS1JzVytwekoxZ2VjUmF5?=
 =?utf-8?B?MGpITEZzT3FmbXE3ellaRkRQbjhtM1Njc3BhR2g3TUp3OUQ2YmxnMnpXZVFZ?=
 =?utf-8?B?d3FNRHVNTUkzaVVRYWxDZEN1UmlIY3o2eHlzb3ErQzFNWlBaWlFQNCtlbTVF?=
 =?utf-8?B?UjMxTWMwVzdhUHkvR0tnVUQ1aGtoV09sNThZOUR6bmk5R1I4cGI0UzBrUmVS?=
 =?utf-8?B?UlBKcjY1amtrU3dPcG5pRmc1QWlzRXVWb3BkcFdmek83b2QySmcxeWo4ZTkv?=
 =?utf-8?B?bTA5aUl4SjhsUHJvWjJRMUp4a2grTm1Yb3QzZ1Fmb1c4TXQ5UUx6U0NYN0NY?=
 =?utf-8?B?OGkyQ2EzaTN4bno1RVRnUWJQRFZYeGlVeDNmaGx1L1hON2dKYjZ3OEMrWU5h?=
 =?utf-8?B?R0dsRXZkb24wOXhyVGJQaDhPbHdVK0pPTUF4cmRpZ3dFSHpEUzB1TEZGRmFw?=
 =?utf-8?B?NXVkYldRK3hncUtURXBGQ0FEVEZwb0xUZk1JQm1IWVgzL3NwVStKVDkrbkg0?=
 =?utf-8?B?MTRETjBzUFREb1c4UVFPMDRQUncvMElXSWZ5UllpemZaQzRMd1pHZVdUMGpT?=
 =?utf-8?B?Wm8rQjV2a0RrdDcybkZGbUw0ZlNQWjNUc1pUdCs5SWdJTkxEQS9NdS9lVFNX?=
 =?utf-8?B?VG9TUHJOZXVPQVYzdnNIdkRKSFptYnpHSC9HaXIwUW91SFB6MnJEcnFmOWJT?=
 =?utf-8?B?b0pNYXBPNzVSMHhQT1VYOTRFeHJBWlByUVdiQllpbVkzck9jT2twODdOQ2lt?=
 =?utf-8?B?aThqWlBtSHJRdVlvZzFKblY2U0JPVTZ2b1k2bkRJenVuU3BjNmdNQ3QxaGZK?=
 =?utf-8?B?QnpVdDdXNG5oQUxoeFhsWk56T2dCV2Q0c3hLSThCV3R2YWFkOU43RnErelUz?=
 =?utf-8?B?cmM1dmVqd3g1TU55eWdmOFNZNldxOEJ5M3ZHSmRRcGFKOS83TStCSEdsdXVF?=
 =?utf-8?Q?sOrgalWBCBeiKvbNei9G7boRc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0bcc4d-eb95-4384-99c7-08ddf11b26ad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:08:27.3753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mrll+3cB/CvJ9IxvbcrS+VQHxaHZBkdMLvUN3iVyCiuqqSaz7+E2CkzZAB1py/n+gmH4jg8QPWM30/jXePqgrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
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

Functionally now looks good to me but adding more comments for the 
changes as Alex pointed would be good to accommodate.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 9/5/2025 4:56 PM, Christian König wrote:
> That was actually complete nonsense and not validating the BOs
> at all. The code just cleared all VM areas were it couldn't grab the
> lock for a BO.
>
> Try to fix this. Only compile tested at the moment.
>
> v2: fix fence slot reservation as well as pointed out by Sunil.
>      also validate PDs, PTs, per VM BOs and update PDEs
> v3: grab the status_lock while working with the done list.
> v4: rename functions, add some comments, fix waiting for updates to
>      complete.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 146 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  35 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |   2 +
>   3 files changed, 108 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e228c1e6800d..cb3432b12221 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -601,108 +601,104 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>   	return ret;
>   }
>   
> +static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
> +{
> +	struct ttm_operation_ctx ctx = { false, false };
> +
> +	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +}
> +
> +/* Handle all BOs on the invalidated list, validate them and update the PTs */
>   static int
> -amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
> +amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
> +			 struct amdgpu_vm *vm)
>   {
>   	struct ttm_operation_ctx ctx = { false, false };
> +	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +	spin_lock(&vm->status_lock);
> +	while (!list_empty(&vm->invalidated)) {
> +		bo_va = list_first_entry(&vm->invalidated,
> +					 struct amdgpu_bo_va,
> +					 base.vm_status);
> +		spin_unlock(&vm->status_lock);
>   
> -	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -	if (ret)
> -		DRM_ERROR("Fail to validate\n");
> +		bo = bo_va->base.bo;
> +		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> +		if (unlikely(ret))
> +			return ret;
>   
> -	return ret;
> +		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +		if (ret)
> +			return ret;
> +
> +		/* This moves the bo_va to the done list */
> +		ret = amdgpu_vm_bo_update(adev, bo_va, false);
> +		if (ret)
> +			return ret;
> +
> +		spin_lock(&vm->status_lock);
> +	}
> +	spin_unlock(&vm->status_lock);
> +
> +	return 0;
>   }
>   
> +/* Make sure the whole VM is ready to be used */
>   static int
> -amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   {
>   	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> -	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_va *bo_va;
> -	struct ww_acquire_ctx *ticket;
>   	struct drm_exec exec;
> -	struct amdgpu_bo *bo;
> -	struct dma_resv *resv;
> -	bool clear, unlock;
> -	int ret = 0;
> +	int ret;
>   
>   	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>   	drm_exec_until_all_locked(&exec) {
> -		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
> +		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
>   		drm_exec_retry_on_contention(&exec);
> -		if (unlikely(ret)) {
> -			drm_file_err(uq_mgr->file, "Failed to lock PD\n");
> +		if (unlikely(ret))
>   			goto unlock_all;
> -		}
> -
> -		/* Lock the done list */
> -		list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> -			bo = bo_va->base.bo;
> -			if (!bo)
> -				continue;
>   
> -			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
> -			drm_exec_retry_on_contention(&exec);
> -			if (unlikely(ret))
> -				goto unlock_all;
> -		}
> -	}
> -
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->moved)) {
> -		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
> -					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> -		/* Per VM BOs never need to bo cleared in the page tables */
> -		ret = amdgpu_vm_bo_update(adev, bo_va, false);
> -		if (ret)
> +		ret = amdgpu_vm_lock_done(vm, &exec, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
>   			goto unlock_all;
> -		spin_lock(&vm->status_lock);
> -	}
> -
> -	ticket = &exec.ticket;
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
> -					 base.vm_status);
> -		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->status_lock);
>   
> -		bo = bo_va->base.bo;
> -		ret = amdgpu_userq_validate_vm_bo(NULL, bo);
> -		if (ret) {
> -			drm_file_err(uq_mgr->file, "Failed to validate BO\n");
> +		ret = amdgpu_vm_validate(adev, vm, NULL,
> +					 amdgpu_userq_validate_vm,
> +					 NULL);
> +		if (unlikely(ret))
>   			goto unlock_all;
> -		}
>   
> -		/* Try to reserve the BO to avoid clearing its ptes */
> -		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> -			clear = false;
> -			unlock = true;
> -		/* The caller is already holding the reservation lock */
> -		} else if (dma_resv_locking_ctx(resv) == ticket) {
> -			clear = false;
> -			unlock = false;
> -		/* Somebody else is using the BO right now */
> -		} else {
> -			clear = true;
> -			unlock = false;
> -		}
> +		ret = amdgpu_userq_bo_validate(adev, &exec, vm);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto unlock_all;
> +	}
>   
> -		ret = amdgpu_vm_bo_update(adev, bo_va, clear);
> +	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
> +	if (ret)
> +		goto unlock_all;
>   
> -		if (unlock)
> -			dma_resv_unlock(resv);
> -		if (ret)
> -			goto unlock_all;
> +	ret = amdgpu_vm_update_pdes(adev, vm, false);
> +	if (ret)
> +		goto unlock_all;
>   
> -		spin_lock(&vm->status_lock);
> -	}
> -	spin_unlock(&vm->status_lock);
> +	/*
> +	 * We need to wait for all VM updates to finish before restarting the
> +	 * queues. Using the done list like that is now ok since everything is
> +	 * locked in place.
> +	 */
> +	list_for_each_entry(bo_va, &vm->done, base.vm_status)
> +		dma_fence_wait(bo_va->last_pt_update, false);
> +	dma_fence_wait(vm->last_update, false);
>   
>   	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
>   	if (ret)
> @@ -723,7 +719,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
>   
> -	ret = amdgpu_userq_validate_bos(uq_mgr);
> +	ret = amdgpu_userq_vm_validate(uq_mgr);
>   	if (ret) {
>   		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
>   		goto unlock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index bd12d8ff15a4..ec29fec1739e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -484,6 +484,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   				    2 + num_fences);
>   }
>   
> +/**
> + * amdgpu_vm_lock_done - lock all BOs on the done list
> + * @exec: drm execution context
> + * @num_fences: number of extra fences to reserve
> + *
> + * Lock the BOs on the done list in the DRM execution context.
> + */
> +int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
> +			unsigned int num_fences)
> +{
> +	struct list_head *prev = &vm->done;
> +	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo *bo;
> +	int ret;
> +
> +	/* We can only trust prev->next while holding the lock */
> +	spin_lock(&vm->status_lock);
> +	while (!list_is_head(prev->next, &vm->done)) {
> +		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
> +		spin_unlock(&vm->status_lock);
> +
> +		bo = bo_va->base.bo;
> +		if (bo) {
> +			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
> +			if (unlikely(ret))
> +				return ret;
> +		}
> +		spin_lock(&vm->status_lock);
> +		prev = prev->next;
> +	}
> +	spin_unlock(&vm->status_lock);
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_vm_move_to_lru_tail - move all BOs to the end of LRU
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index e045c1590d78..f86b1a6afb0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -491,6 +491,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   		      unsigned int num_fences);
> +int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
> +			unsigned int num_fences);
>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
