Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CDAE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 10:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CED89906;
	Tue, 14 Jan 2025 10:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TW5888iE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BC589906
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 10:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRKpGIUboDswnEM3kjjHOvDfCIo+KBbuaigqzNkqYL1QiICn+fsMQdrrEkDdxbuVh1FTxzcs/B/e21gfXZUcdSA4p8zMVrngRqSM4E1kC1HDS1ooXIAoP/xF/aiIYlmLmI20Wtv0aOPyz097HpMUW5pk47YhHldkbggM70LnD+ueHxu+H0Z8yR1eE+ApjxRNd8J7f4pm3IUi2r/gX6YWl3KUml3kcWwMaD5Pbg/G09atKAWXctm+SWBYjdTSblhSgkKNLZjddpSdsRyz7HY9V6U6CWilbz0C24SH/LeWThldp+3iQ7cRse6XRLo8dG2vxprFYcT6J0y4sxGWCFE1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHyrbCvO6HtLhuilI8eKAShsxnjYTLlt0b5A/D1T0hc=;
 b=SS7cc6hXQnT4FIOSbHFwKwUF1yXCxsf5QroHX9RYjgh0MJ0EMwHuChW78L6SaANWq7pRWoFtb2md3glbHM7AUmBMiRNkjLRQUduEDI82qDFPuSKwQ/pNI1Q8iTKOc/VNqu2sJfy+gRQp8JHc/9ANCUgZ7H6x073fCX1N2Uz0ViYGqVhBqWmGdlHajmYCZGUjLAB7EgYQQKBXi6vWI0G0+II53YNbmC/o16GEzERi3vOFFq140cHzhVMrpKGGILm2A0BEZcelfeI7q0ylQmRr3kUfwmRn5vrZuXbYoHiEUsG/7HbPwP+VmL1q2P3hCgvCZ2UBLsI3aUCCKa6bfqD7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHyrbCvO6HtLhuilI8eKAShsxnjYTLlt0b5A/D1T0hc=;
 b=TW5888iELLy2BDsHKBZdZb3WF/FMb0Nw+1pZntvLs9fqnihRkuu/P36/4hRokKs5tRWuSyIq+JAuiZGCZRqfgJ/XniHNaAedRXRdRYF8S5ZMje2sgpaFMTKTVNYYVAcI9WBIWPxIJPPK/7nqWDKrW4/aT5647GWDStIfwInk0QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 10:46:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 10:46:28 +0000
Message-ID: <46f008f8-6e88-4475-9510-6072f990c377@amd.com>
Date: Tue, 14 Jan 2025 11:46:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/2] Enable resume with different AMD SRIOV vGPUs
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736847835.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cover.1736847835.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: adcafb0a-cc29-4fa7-6190-08dd3488b2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVNjalBSSnZJVFNmVVorNUljeVF5RVd3ZEVBNDVkRzZkNVpjMW4zTW56cEN5?=
 =?utf-8?B?YVpGRWV2OVVqUWhlNVBwUGlPU3VKdzhaYTdSNG9VUll3eFVlZGtWbXBCT0d4?=
 =?utf-8?B?M1pKS3VMQXdHaFRxUTJ4N0JMOHdoNGtPOHJ0eGFmRFdNc1BQWjN0R05mSEhG?=
 =?utf-8?B?bEIvZ1F1MTAvVWdpeFBVUnBzQjM1eGlqVjdDRUZRcW4wcHduKy85eXNXWUN0?=
 =?utf-8?B?ODg3Zk9VSnR2R2k3VUFOVnh3SWE1b2oxQVN0NDZIdXcrSmI3NGoxMkszWHor?=
 =?utf-8?B?dHdhcllQQ3pWbGJSTTNaQkhXMkw0ZHhaSjdWUWpIWVpWYVdiWE5pYWQ2bEp6?=
 =?utf-8?B?TDBUMGRscUdRSTBJVUhZV3dWLzRpOExMMjBaNW1YeStTNE5VbVExd2llQk9U?=
 =?utf-8?B?REZJTUEvYzUvay9pWWJsVTRzU0hTN2dxdHBvNkh2QnVzQ3lxZStyOXNxTEtL?=
 =?utf-8?B?bnZMNHRFQWYzMWMwYlEvNy9rZ2VSZTlIb2dLdllGakVlTVlFNjFaTlRoSTBL?=
 =?utf-8?B?c0tnUjlpVVR2RmVaNVZjZkc5aWk2WDVvdldDYmJjZnpGV3R6OWFiRnBVY0Ft?=
 =?utf-8?B?MmZRLzZKK3RJbWZFYUJSVkFzU2Q5NnZSeG1peXovaUlVVlgxbUtra1dzSWtq?=
 =?utf-8?B?elRQQUdJSFplRnhFc2VrL0x2VzFxM2NuTHB6Mk5LYzlmR0ZtM2hzM3FqYkRr?=
 =?utf-8?B?UC9kMk5hOS9iK2Yzei96MUpteEpQZVQ3SllEb0NKM0JHeHJXWG8zTG1ZbWdi?=
 =?utf-8?B?eHY5dGwzWEtJb1l1ZTNZR3NaYVdVSWVENjVFNkJiZzZsSVBZd254a0dlbnNE?=
 =?utf-8?B?aUNCSW9QZndUcFJVdHFIM1VSV2d1UzdNQnNQcWtlc2kzdDJDTVFSZHU1N3N0?=
 =?utf-8?B?Wm5sMXBKRUg4SVNNbjEybWFjUTJHT2VWUitpRnE1ZVhUZ3pTb3QyK2VNSlZC?=
 =?utf-8?B?andiTVJmODhKVGNGNkd0dDlualRoZGxhc2dhdmluMjkyYys1S0pDNG9OcU1j?=
 =?utf-8?B?dHB0bElhZUxZMDArUzBqcHAxSGJIaXB4TlJqZ1NhemRMZU9DK1hFcGdRTzd1?=
 =?utf-8?B?VU9wSkN3aFFBUkF0QVRPQWNTWGNtOWFiaXcrYUN2MUszWkVFVWxuUU9sQzFk?=
 =?utf-8?B?MXFPaDI5RmhrdDNDOVIxcStydXo3T2VyN3hWYTZzMCthV1pLNmgxdDY2TzNX?=
 =?utf-8?B?U3ZQZGRJdGt6OVc5S29BUDhNUHVCcDZqeW5TUUo2bE50SGtKQmk5Wk5lcWVj?=
 =?utf-8?B?bklDbmcreEQyOUpZUXNDRVNJZU9JMzFWOE9HU2VRNTMrSkhjNFpFSGdZZTR6?=
 =?utf-8?B?V09kR1lUeHhuNDNRWThIN0MvV1NHbm8yY1NBMEpVOVpEYkQ4c1dJRlBIbXRS?=
 =?utf-8?B?b2ZnbHFrZnZpc2NtazQ2amh0WjFrMnY4bmdRRmZ5N1EyZlNzQzVSUlovYWp4?=
 =?utf-8?B?UVk3Rjk2c1Y2K0UyUWlpUit6RXdhKzNRcHkzaW1xcVEwN2llOE4vVUZMNFo3?=
 =?utf-8?B?dVFzTzBIcVRNalhVby9MOXdsOXduU09VWjZCL1RVMVo3cFBld2Fta0ZRNUl0?=
 =?utf-8?B?b0dWc0JkcllFOG50MmQrZVR2TldXT2JpZDIyWXg0bzRSbDNJOXNsKzBxQUk1?=
 =?utf-8?B?aHNqMEpUODRtYUFkbVloaFBpYXcwVUhDaStZMDJhZXNLeHFZYVltdDJvVldG?=
 =?utf-8?B?ZjlIaEdQdzFvblRaVHdvR2VVQ0dvV1pFRFdTMEE5K0RtSVVuS1Z6K0gxeWhS?=
 =?utf-8?B?U3NTOUovaU8za01iOTQ1TmEyWmtDMEkwVy8rVW5sSDFrdXpSajRwZjk2dS9u?=
 =?utf-8?B?ZFVrbjVNWEh4bWJHY285bW9VNUw0QlY4QWFWOE53V3RWTGdteFNLWS9ONFFV?=
 =?utf-8?B?aTNBeEgwVTQ0WGxXNFBLMEpRRTJ2WVRSTHVyb1B6cE16MFNCU1ZLMDZxNUpZ?=
 =?utf-8?Q?zp5SY7xN9bU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzRLY3BGTVhhQjNxRVkvTWI5ZnNYYkZ5Y2ZGTjYyYzdoemV0QUZaS0J2SjA3?=
 =?utf-8?B?bGdzL2xLdEtHME96Zmt5eUxMU3RwZmxLQVN3M1Bua1lqVEdxUG92Q3djZ1ZR?=
 =?utf-8?B?SjFkVEFUNnpaVWo3cmEwZDNsYUxUc00vQmtMbjBQOS9vV3V3OUNhSWlzY2pQ?=
 =?utf-8?B?RWdQOUZVbjNuMk9OZVhYcE95and0UXVjL0lKYXNSYjJBelMyQ1RTL085aW1K?=
 =?utf-8?B?MTYyaWFhRXU4K0tNR2JxM3dmeW43TEQrUGQ3RVV0ZXJYRzhjcXY2THRaQ0F0?=
 =?utf-8?B?NzBNdW44TjFRdkp6cWFWbDVuTHErRCtkanFGaldsY3RRQkloSmF4MUZkeWlL?=
 =?utf-8?B?QUI5OHBXZTUvNGxCVTE1elZTY2xtbzN0Sjc5Y2hBY1JMY2NncFhMWFowS3p4?=
 =?utf-8?B?N3JkL0lRcWVHS05VTmVXVTI1WXpTWVJ0SWNvVFdpaXFyMnlrakhsZ1VYeU8r?=
 =?utf-8?B?K090YTNQZmhhYWw3dnVTMEM0RFZOUXVXZGhPemJzR3FOZEtBbHNRUEVJOW9I?=
 =?utf-8?B?aWVxUWdydVVCQ0k0QmZSQ1A1alZiZ3lSRTI3ZWFseXRvdE9nMU9uU0pTYjBI?=
 =?utf-8?B?bXNVRHd1RlRjUkJzREh4V3loNUZRbDIrZ1d2UkxTMC91cFB5RlpHakJ1OUVM?=
 =?utf-8?B?SE96WUMxRlZSK05FUCtuRkJ4SlZweG5TbG5rNzJTbjkwOWZ4RlE4OExjNW5z?=
 =?utf-8?B?eWhNeFRDWFdlenpjQU8vem9lS1htUmh2clVueFZtaVZHcUpPampQaDdiZ2lY?=
 =?utf-8?B?alhrTitiNEIxanNVa0F3MzlXeXJyU1JTQ20vZWovQWxzVU9HdG9pUjBaMG4r?=
 =?utf-8?B?VmgwMXZTYlRwVzZ2QUd2K3R1bU9Zd0dyMEI3L2paUHBpQVQ5WGNHd3lRa0xx?=
 =?utf-8?B?MEY2WmczeFV1M3h0Y3BGSmYwK1VqelYrNXFwZzBKOHd0WElkNldoOExIY0Vr?=
 =?utf-8?B?VXpValJoZWJtTW5TVXBNSEdMdjQwb2VqdGNFRVhZZEd1RUMxZlVGWnpVUGNN?=
 =?utf-8?B?RGZxdXFZb2FkV1pjcDZHTHFLU1hqRzZUZ3dZdHVmNmRibEtMS0lVVVJwYnla?=
 =?utf-8?B?SnVsZUUzS1dQWlkxWXlHa25FcWhid2toRlgwYlJuMWs0KytQM1E3M2UxOUtY?=
 =?utf-8?B?djUvdnNNN3lhdW1MSTZVdzlsVDVJUDZBWTFMU3lkMXJnUVFHMkJWQXk5aWZy?=
 =?utf-8?B?ZjhwY055SVh2NGNGcm1iOXlHM1BYYVd3ZUZXb1dYZytsSVNPK1p5UGhCRWlu?=
 =?utf-8?B?V2pOQURqSThneER5cXF6R1FaNmV1ME9FNVpuT2dZTFc4L2w0ek41VTBIS2Q3?=
 =?utf-8?B?UWJNTVRvcVhTdEorVmxxWlZkRFlYVWhXUnhJVGRQRDRHWEtqZ1hUVVdHNE9a?=
 =?utf-8?B?aC9kcDFWRHdic29vNjc0SUE0TWtjVFo3clFpcjVqcFJ6ZVg2bjdIOWNReXI5?=
 =?utf-8?B?ZEQyaEY3T0ZZUkp6TVdzRFN4MXdKVHVjU3ZXRlZWUi80eVcwUTAxT1U0bVBX?=
 =?utf-8?B?d1BERFRJMS9hMnExV3F6OXp3djEzUU1od2VTVmJQa2J5b0hYbDhUUDUzT3NR?=
 =?utf-8?B?ekpXNThtM090RnFWYytldFhFM1ptTXVYaTErS052Y082amxZMy9qOFA3THlz?=
 =?utf-8?B?R0NnZm5oUENHZmkzTDVXdzNMcjZQenJqK3dSQm9QNzlmaldDN1pPSTZuWFJx?=
 =?utf-8?B?NmJzVFVwNmRucGhtRmN3YlIrT0hDWWlDaWFhZGVmRUNjTG1NVk1Hd3AvSTJL?=
 =?utf-8?B?MUdDbFUzN1o1RDR6T1F4VVRRUzZvOEFPbFR5Zzd0Rk9INEJFT3N1Q25FQzFh?=
 =?utf-8?B?dDFMamlBWC8wajl2a3BWSnpHT1AxczJFWElUbUpaOWFxdE54bzJGY2ZmSllx?=
 =?utf-8?B?RXdac1BuZ1dmTG5FSklpU3RBWlE5eENoZ3dCZWcwU2dIRjVNVm5vK1dJNzMz?=
 =?utf-8?B?cEc5TkMwTGhwdXhrdlpXWUI2dkdjTm41dWoyMG9wR1dCYloyY0xMRVYzRmMz?=
 =?utf-8?B?MnN1WXdId0I0d245bE0zVWprcWJmZmpQTTdLUDNQdUFsRUpwU1NuNHRZK2FY?=
 =?utf-8?B?aVNGTTA1d3N3VmpweW91MDY3dU9pSVVjZS9lNXg2amd1UVJITUJ6K0dscUor?=
 =?utf-8?Q?e25ydhgt/9J6HoIxrCIw/HB8f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcafb0a-cc29-4fa7-6190-08dd3488b2cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 10:46:27.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jdhj614NZRauPMqcfy8LThXwx9b53jRb5vN6S6nzIR1qUz/DTPGa3wogAIiKEeYS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

Hi Jiang,

Some of the firmware, especially the multimedia ones, keep FW pointers 
to buffers in the suspend/resume state.

In other words the firmware needs to be in the exact same location 
before and after resume. That's why we don't unpin the firmware BOs, but 
rather save their content and restore it. See function 
amdgpu_vcn_save_vcpu_bo() for reference.

Additional to that the serial numbers, IDs etc are used for things like 
TMZ. So anything which uses HW encryption won't work any more.

Then even two identical boards can have different harvest and memory 
channel configurations. Could be that we might be able to abstract that 
with SR-IOV but I won't rely on that.

To summarize that looks like a completely futile effort which most 
likely won't work reliable in a production environment.

Regards,
Christian.

Am 14.01.25 um 10:54 schrieb Jiang Liu:
> For virtual machines with AMD SR-IOV vGPUs, following work flow may be
> used to support virtual machine hibernation(suspend):
> 1) suspends a virtual machine with AMD vGPU A.
> 2) hypervisor dumps guest RAM content to a disk image.
> 3) hypervisor loads the guest system image from disk.
> 4) resumes the guest OS with a different AMD vGPU B.
>
> The step 4 above is special because we are resuming with a different
> AMD vGPU device and the amdgpu driver may observe changed device
> properties. To support above work flow, we need to fix those changed
> device properties cached by the amdgpu drivers.
>
> With information from the amdgpu driver source code (haven't read
> corresponding hardware specs yet), we have identified following changed
> device properties:
> 1) PCI MMIO address. This can be fixed by hypervisor.
> 2) serial_number, unique_id, xgmi_device_id, fru_id in sysfs. Seems
>     they are information only.
> 3) xgmi_physical_id if xgmi is enabled, which affects VRAM MC address.
> 4) mc_fb_offset, which affects VRAM physical address.
>
> We will focus on the VRAM address related changes here, because it's
> sensitive to the GPU functionalities. The original data sources include
> .get_mc_fb_offset(), .get_fb_location() and xgmi hardware registers.
> The main data cached by amdgpu driver are adev->gmc.vram_start and
> adev->vm_manager.vram_base_offset. And the major consumers of the
> cached information are ip_block.hw_init() and GMU page table builder.
>
> After code analysis, we found that most consumers of dev->gmc.vram_start
> and adev->vm_manager.vram_base_offset directly read value from these
> two variables on demand instead of caching them. So if we fix these
> two cached fields on resume, everything should work as expected.
>
> But there's an exception, and an very import exception, that callers
> of amdgpu_bo_create_kernel()/amdgpu_bo_create_reserved() may cache
> VRAM addresses. With further analysis, the callers of these interface
> have three different patterns:
> 1) This pattern is safe.
>     - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>     - call amdgpu_bo_free_kernel() in ip_block.suspend()
>     - call amdgpu_bo_create_reserved() in ip_block.resume()
> 2) This pattern works with current implementaiton of amdgpu_bo_create_reserved()
>     but bo.pin_count gets incorrect.
>     - call amdgpu_bo_create_reserved() in ip_block.hw_init()
>     - call amdgpu_bo_create_reserved() in ip_block.resume()
> 3) This pattern needs to be enhanced.
>     - call amdgpu_bo_create_reserved() in ip_block.sw_init()
>
> So my question is which pattern should we use here? Personally I prefer
> pattern 2 with enhancement to fix the bo.pin_count.
>
> Currently there're still bugs in SRIOV suspend/resume, so we can't test
> our hypothesis. And we are not sure whether there are still other
> blocking to enable resume with different AMD SR-IOV vGPUs.
>
> Help is needed to identify more task items to enable resume with
> different AMD SR-IOV vGPUs:)
>
> Jiang Liu (2):
>    drm/amdgpu: update cached vram base addresses on resume
>    drm/amdgpu: introduce helper amdgpu_bo_get_pinned_gpu_addr()
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h   |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c |  9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        |  6 ++++++
>   7 files changed, 51 insertions(+), 2 deletions(-)
>

