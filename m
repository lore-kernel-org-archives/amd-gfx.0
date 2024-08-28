Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59E4C677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 20:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B8110E5C7;
	Wed, 28 Aug 2024 20:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oGbf3ET2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C688710E5C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 20:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfCeLYkGy/zBfssiODLNSswmsLrHk/XiiSEVNydKaV6gPMcDkChvsyAValyv9lc0sXqsXmvLV6DzrI2mvRvsxMd9o8DzBbWHfPxKPJmQoqgjgaL1Z12a9Pc7k/wEyyDfc3TFvUvUL+2AoyZKCvFgGCiLHtlLL59jzSJK1wWA0o1Y1k1AgXxfwdjYvmqWQqjy6qXTD7zMdAb4lClnnlCp5Kw9Kyqh9iECxN2VJDIEN//clWP0qR4EEluXdKA+MCud0Lxo2jkKvi/iMEvMnf/Fm+P2NQ6WaMIls/bEwmac704RA5+jh4RQJxrRFLQuB7lKCJt6zv+Rk5WlwqXUHsvQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tf3eExnwEP2Qu44ZIsuZAyqAfGsxV4ZXyDSeYBK2FzQ=;
 b=J6HPuVk5qyzkBzf4B68hXnmpfx8OJidsiklBobwJrWGLkrKk0ivq2JAuvXJeNDClCzS3/SGpoF/MIbHypqGyyGOfTP2CJySTByJB+r0kdfZMHyy6MaNxBMdpQA4L8xQ4sJU8oQnpuwfSEXengB3RYtaYtYIL89yd+JeR/KJ4zi4ZcsPlVZJBTBWqW4iowp+01XFfLtdyhiZr8mJ2ym5lemXCIhaMIRnu/a5CBibCdJFaPygtOtdwGAmnBCtzf78h8qnVo63otTO7DjpEiePHIgYX26t7IvyJcfbEvQNHaDUbiW9dAFZIhH/surfmA2Voo7URfijwngf2X+E/cOl0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf3eExnwEP2Qu44ZIsuZAyqAfGsxV4ZXyDSeYBK2FzQ=;
 b=oGbf3ET2MduGeo2kK3Bx/yCjXZZVMBYG+O5OgXH9Qs+xpP45x8RbublNSxn5I9BGOOnDCArmp9PPTSwkwprnK9hd9Wwy8XH5q3IPq+mKJJeluy/JqzUmonp0pxFwE9ACZuzuqY4+veF4Cj6Wo3CPCcRoqdLsfRlqhFFQ/98DVHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 20:00:54 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 20:00:54 +0000
Content-Type: multipart/alternative;
 boundary="------------CC0FzSHDri08AKkuhSF0U6IK"
Message-ID: <77342503-b366-4d8f-93f1-91e75c0682a8@amd.com>
Date: Wed, 28 Aug 2024 15:00:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module
 parameter
Content-Language: en-CA
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240826193420.126272-1-Ramesh.Errabolu@amd.com>
 <773d3d99-4e97-45cf-a457-51989ba3081c@amd.com>
 <DS7PR12MB8321124485D5DF7E4A0CC67CE3952@DS7PR12MB8321.namprd12.prod.outlook.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <DS7PR12MB8321124485D5DF7E4A0CC67CE3952@DS7PR12MB8321.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:806:23::18) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: e117f603-3d88-4cde-f283-08dcc79c1f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OCtjanZIaFljMmhCeGRKN1AzZGp4NzNMSXozOEdzV3kyRVFFV21WWTVtUzJa?=
 =?utf-8?B?SUxnNXh6WlZ2Z0VHOXN6L0d2V0dzUmxrSUdHQ01BRHp6VmYrVjV2S0VmeDB5?=
 =?utf-8?B?T20yUXJ2VWIyWldOejlnSFl5S083OW1ZVlYxZXR1b1VRUy9uU0ZMTllRMzJi?=
 =?utf-8?B?QW80Wi8vaVJ1aWZaci9HYkhjdGtsMlRwZHBpKzJOaFVvWSsrWGhudkhCUTNx?=
 =?utf-8?B?aGVQVjArWC9VMU85cjdWdkt1aUN0SEl2NzQxai9XSzhVL3Z2TXh6Zy9pT3h5?=
 =?utf-8?B?Z2hVQ1d2SVo1UFJxcUhsOU5Nb29Yc0NLcVBYVERvOWJjdXg3QkNDZS9zWlk5?=
 =?utf-8?B?dE9NMC9Qbk56Qm5mOUYyNW1EZXNQaFZXaGFFcVF2ZEdZY3FnaURVZnVXVmg5?=
 =?utf-8?B?cm4rQjFQVlhyeVdGQVpLN1NpbW5RK01IWUR5SFhxRURHbmF1ZGJ5T2d6MDQ5?=
 =?utf-8?B?dE5vMXF6MTBpR1FLYkdudG9UZUZjWmlSUEhGZXNHa0l4SzkwT1JhYWE0c3Jl?=
 =?utf-8?B?Y2JEREpGbmxTcGhRdHJMSENzOVZpajdVVmlOOWJWL1FYWUpDSEFtMDQ0YmM5?=
 =?utf-8?B?Y29zcWQ1bk1oS1dFVXJNZmR5bEZvay9RVExNQ0Y5c2NqUi9TMk8xbjIxZ09w?=
 =?utf-8?B?MkhKamZ0RXRzeG5PSFBTSlZWVDd4VTBveTVoenBJQXAxcnBqN2xGeFlSQjB0?=
 =?utf-8?B?TEtXa2k4ZXd0VERMc0dXSSs4U1QvaEl3MHh3bTB4Z1o2eCtOL1ZqTnBibTZm?=
 =?utf-8?B?Q3JIQnZ5NEF4RldiYkJZYmdYLzIwc2FDL3JRc1RnTTVmVlFDRm1FTnFWYTgw?=
 =?utf-8?B?T3VzQXBGRHpUdjFsT1h4QlllVWJ3WU1yTjFvbGh6NExseXFCZFBiUVNYRFRE?=
 =?utf-8?B?ajVVZEVuTGVOL3YxOEdZd25BaVVQT1YyOVRmeWx6TFZGMmNOaE1QT3gzTS80?=
 =?utf-8?B?czRTRkpaVjZjbXh2RVlmaWp3cjkzUWs0NmM5VnpZRHZZMHNSdXhVYUlMVnVK?=
 =?utf-8?B?Ky9GTUFRTWZPQmdvajR5UlVGU3dhS1VKVkNsZGc2Nm9zd2tabVNGWFVad00x?=
 =?utf-8?B?Ulh2K0phZjhDWjFyTVg5K1FNaFNoTWJFSVJmamRlQ3Ftc3BZNUFpa3FobGt6?=
 =?utf-8?B?T3dmV2ZIaWpmdzAyajhKU0pBT1FlaG1oV3pNb3FoUVY0WHBrWFVabmtON1ow?=
 =?utf-8?B?a1JqQ2hsa09oRTkyYUhxVjNCWEd4NGhlNFQxYjdQTFJ6RmZZVzMzVXlDRjNK?=
 =?utf-8?B?TmlnWUtReDhaeWFsTFQrdTRmVTVrelhza3JxS1J1Ylc4SVJFdHNiSit3SFJa?=
 =?utf-8?B?VUt0VFljL2d2UngwYnF2cXFHb0lUR3ZVUEFaSFN5bk9PL3luak1xZHhBamtw?=
 =?utf-8?B?MklQR0FMbHNvSlJEbXR1UXpDTm9veTFtK1R3K2c4b0NXRjhMLzZqd3kyODl3?=
 =?utf-8?B?U2NrcEZrc1cwUFpNU01JbWN1bGtFNW1pcHdZWmtGYnozVjI3NzFDUUZqK2tV?=
 =?utf-8?B?bk9ta2FLTXBDRFVZS2hCNUh0MXp3K2tDRUFNeGw4RFJocDdrNi9XNnlCMnVh?=
 =?utf-8?B?M0gzZG1pY2JDMUdObFZGeWpUTHUyRWNLMGJaVk9LNkUrZ0VEMWhRd05kcUk4?=
 =?utf-8?B?TEJ3cjZHWkFzK3pFYVBXMWJvUm9vN0FFNGZtdFVqY2c4ZTBMVGhLdXFJU00z?=
 =?utf-8?B?eFA2bGdjVW8zdUh2eUl2aVZBY29sdmFjV3JZTmFFSndYZG4wSHRjNXgxKzJH?=
 =?utf-8?B?eXY2VTVBelFabllHU1VHdkVLcUVWTTdzcWFJOFlTOGNpVVh4SE1TTnpsNFN0?=
 =?utf-8?B?cXNtTlJzQnhoQTNnOGhRQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9UcXF6WmV1OWJXL3hTNlJtMHJNR3dtWE0vT0I5WGZTVXNrZXpVenpvbmtn?=
 =?utf-8?B?ZUNTWHFvUmQ3aUpCUzB5ZVF3Yml5MGFVUW9ZcS9XbGxubWlKWGtpUzV1SDRV?=
 =?utf-8?B?Uy83eXdOVHg4OUEvb2Y5dmNyYUFobmQya1o0TW8zVjYwdUFVRUtGMkw1Wm5o?=
 =?utf-8?B?andRV29WdUNqZDhLNU5tZXdaUFlaWVdaL0Roc0cwbzhzWklpTUF5ek1kVkVL?=
 =?utf-8?B?SGk4NVdXYmxHMGttUjhkMUZLbGgxZS91Sjd4bDlTb3VNaGhpZEZtbXVWNGVa?=
 =?utf-8?B?c2J6L0NwSHBYWlRwNHVHQXFCTGVUTGpvK2MrdlU0bStFN2hIQzhjaloyNHNm?=
 =?utf-8?B?M3pUbmU4SFZ2TUxUdm5kM1FjNjB0Qm85UHpRc21zT1RTSTE1RTM1WWNBdjRH?=
 =?utf-8?B?MWgvZmYzdXVmMkJxdExxSVpjWmJ6OWRadm9lUUJxUjdocjlETlgrK0Q2SjRq?=
 =?utf-8?B?TlZsYlBidjgxclQrc1dkVVRqajN6Ukx1dmlybGpkZzM4UktOVXRVb0RrQ21S?=
 =?utf-8?B?NG4zaFFrWUJEQklLYnNmb0FHdE9yM3ZFUDc1WkRSYkkvUGFkaTdGSCt2WDE3?=
 =?utf-8?B?S0FmUW9PNlk1MlVYS1ZvRC9CT1pBTHRNMlM4SkR1eldhVFN6cFE2Z0U1SjBR?=
 =?utf-8?B?YnNJUU1uT2x3eVAzaVNXOW55OGtPR3FnaTZ4S1g4VXBSQ1FEa25lRU9UZkdU?=
 =?utf-8?B?YWtOWHVvbWtOSFA2Ryt5ZnRlU2xlbXJlUUZma1BYbFpKZStBWFdrOTY4M3ZQ?=
 =?utf-8?B?UllCRzhZcWkyMC9HQklaTWJBMjlkOGNraytMQ01vUmptZ05ja0dSbzVzam4z?=
 =?utf-8?B?T0lCSkJlMlBFMVVXNXlPeS84blh4N1ByWWNnZ2M2YUdieHpSWXFWZEVOekxR?=
 =?utf-8?B?Tjd1WWJHSFZEL3kxVHBnZE1hNVo5eUtiR1BHWlEwMkJjTFoyTTcwaDN0ZlBw?=
 =?utf-8?B?aEdqSUlhc1JSdlo3eXRKNnNxRmNaSThvVEdZM3JGVHVlYlRrYjVwblp5T2Rw?=
 =?utf-8?B?QUpxTitoTDVvd0JlMnRUZXgzQjQ1ZnA4QnNZY1NYdWNQVDQ5YStYN1JuSkpv?=
 =?utf-8?B?R2xDTys3cXpBQUZ5dVVEYkRQMVdqRml3TjFZZ2V1YmU0WUZycnBlN1ZzUjk2?=
 =?utf-8?B?RmxKTi9NQytVRkJkeWsyVUZVdWZoQVZkaVJobnZIVHVhc1JCR01VeUsyVHNi?=
 =?utf-8?B?ak1EeHh3UktvOFY2eXBtbUVMMklsMTZyZjJydGdyT1A1TjROUGJqM2I4ZzRn?=
 =?utf-8?B?dzV4aFNmcFVJU01vcHpIa2szeUtmRW5ER3IwdVhZQVhkTVI1MHErWk1WeFpY?=
 =?utf-8?B?VCtOYUg1Wlhacm44cEo0ZzJnaXdZRkdHTXhpNGpyNWNiWmdFTlFRN0x0SUxi?=
 =?utf-8?B?OTJ2Z3ZNLzRtdlNlaEttSFRXRXNuZDNJYTN2cGVERXYxdC9OWnlEMW4yVWV6?=
 =?utf-8?B?Y0d2cFE2bnhLYlRDbWpxdUJXVjg0MEowTmVSS2wrTEo5clJzdHE3YnhvKzZ1?=
 =?utf-8?B?UjU1a1RxekhXR1g3SzZsZHVDS25GR085QW80VTlORkRpZ3VmWDh3RHc5dnUw?=
 =?utf-8?B?VUNSTHJudkdZbTN6QS80NG5nQkRYeG4zUTNmV09Zd2ZuVFdWZE5LU3RuRW9W?=
 =?utf-8?B?L0FRSTFtUEpmOXRCSHdEbTNKaklBT3Q5NjFpdUErOEtueW5Qa3Z1dis0V3A2?=
 =?utf-8?B?bFVoYTNrMVNQajJ0ZDJUOFZOTzZ5VGNINVczTmdGaW9CRVM2QmI2VnV5aEhr?=
 =?utf-8?B?Q0c1bVIrRHhpbXlieWlvemxJV2MxWVNsVFFvNHExTEFJMmQxY0hKcllpQ2I5?=
 =?utf-8?B?Q3ZvdzV3dDZ5elZaUDN3dzh5TjBlWUsxTXZYeHh3c1ZUdXhtTWhNdVlhUExD?=
 =?utf-8?B?QjhtWDZ1MUJvZU1vcWtHQ1QzTCtZYzJkR2x6UnZjWTFGV3dZaCtpNUp1d3E1?=
 =?utf-8?B?SEZyaUVGT0VXdGZZdVNCNFExdHRoWGRZK2t2WmNjcWl6Q2sxeU1Od3YyQlRU?=
 =?utf-8?B?Nk8wbmtQdTJwOHZwYXZYMTdxQ1BrNmYvQXRGSHV3YnkyTlBJcyt6MkJMY0NU?=
 =?utf-8?B?NHdxMkl5U29KM0JCMlBJazUzUGtQN3E4NHRjSHdxelFpUDZSMDlzZDVPWUo3?=
 =?utf-8?Q?P7sw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e117f603-3d88-4cde-f283-08dcc79c1f98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:00:54.0334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmaSPGjtqh0EsUozUe6vdP3OKjmGSloMNesxT3UBpOQKwG8dtgXZSaQgK9PahZlF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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

--------------CC0FzSHDri08AKkuhSF0U6IK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/28/2024 2:52 PM, Errabolu, Ramesh wrote:
> Response inline
>
> Regards,
> Ramesh
>   
> -----Original Message-----
> From: Chen, Xiaogang<Xiaogang.Chen@amd.com>  
> Sent: Wednesday, August 28, 2024 2:43 PM
> To: Errabolu, Ramesh<Ramesh.Errabolu@amd.com>;amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module parameter
>
>
> Why need this driver parameter? kfd has KFD_IOCTL_SVM_ATTR_GRANULARITY api that allows user space to set migration granularity per prange. If both got set which will take precedence?
>
> Ramesh: Use of Kfd Ioctl is available to users of registered memory. It allows users to control GOBM per buffer level, including overwriting default value. For ranges that do not specify GOBM, the default value will be found.

If user space use KFD_IOCTL_SVM_ATTR_GRANULARITY it will overwrite this 
parameter value for a prange, then how to know which granularity take 
effect? That is decided when user set this parameter and when the api 
got used.

Regards

Xiaogang

>
> Regards
>
> Xiaogang
>
> On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> Enables users to update the default size of buffer used in migration
>> either from Sysmem to VRAM or vice versa.
>> The param GOBM refers to granularity of buffer migration, and is
>> specified in terms of log(numPages(buffer)). It facilitates users of
>> unregistered memory to control GOBM, albeit at a coarse level
>>
>> Signed-off-by: Ramesh Errabolu<Ramesh.Errabolu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++
>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 ++++++++++++++++---------
>>    4 files changed, 51 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index e8c284aea1f2..73dd816b01f2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -237,6 +237,7 @@ extern int sched_policy;
>>    extern bool debug_evictions;
>>    extern bool no_system_mem_limit;
>>    extern int halt_if_hws_hang;
>> +extern uint amdgpu_svm_attr_gobm;
>>    #else
>>    static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
>>    static const bool __maybe_unused debug_evictions; /* = false */ @@
>> -313,6 +314,9 @@ extern int amdgpu_wbrf;
>>    /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
>>    #define AMDGPU_SWCTF_EXTRA_DELAY               50
>>
>> +/* Default size of buffer to use in migrating buffer */
>> +#define AMDGPU_SVM_ATTR_GOBM       9
>> +
>>    struct amdgpu_xcp_mgr;
>>    struct amdgpu_device;
>>    struct amdgpu_irq_src;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b9529948f2b2..09c501753a3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
>>    char *amdgpu_disable_cu;
>>    char *amdgpu_virtual_display;
>>    bool enforce_isolation;
>> +
>> +/* Specifies the default size of buffer to use in
>> + * migrating buffer from Sysmem to VRAM and vice
>> + * versa
>> + *
>> + * GOBM - Granularity of Buffer Migration
>> + *
>> + * Defined as log2(sizeof(buffer)/PAGE_SIZE)  */ uint
>> +amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
>> +
>>    /*
>>     * OverDrive(bit 14) disabled by default
>>     * GFX DCS(bit 19) disabled by default @@ -320,6 +331,13 @@
>> module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
>>    MODULE_PARM_DESC(msi, "MSI support (1 = enable, 0 = disable, -1 = auto)");
>>    module_param_named(msi, amdgpu_msi, int, 0444);
>>
>> +/**
>> + * DOC: svm_attr_gobm (uint)
>> + * Size of buffer to use in migrating buffer from Sysmem to VRAM and
>> +vice versa  */ MODULE_PARM_DESC(svm_attr_gobm, "Defined as
>> +log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB");
>> +module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);
>> +
>>    /**
>>     * DOC: lockup_timeout (string)
>>     * Set GPU scheduler timeout value in ms.
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 9ae9abc6eb43..c2e54b18c167 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -868,6 +868,18 @@ struct svm_range_list {
>>           struct task_struct              *faulting_task;
>>           /* check point ts decides if page fault recovery need be dropped */
>>           uint64_t                        checkpoint_ts[MAX_GPU_INSTANCE];
>> +
>> +       /* Indicates the default size to use in migrating
>> +        * buffers of a process from Sysmem to VRAM and vice
>> +        * versa. The max legal value cannot be greater than
>> +        * 0x3F
>> +        *
>> +        * @note: A side effect of this symbol being part of
>> +        * struct svm_range_list is that it forces all buffers
>> +        * of the process of unregistered kind to use the same
>> +        * size in buffer migration
>> +        */
>> +       uint8_t attr_gobm;
>>    };
>>
>>    /* Process data */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index b44dec90969f..78c78baddb1f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>>    }
>>
>>    static void
>> -svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
>> -                                uint8_t *granularity, uint32_t *flags)
>> +svm_range_set_default_attributes(int32_t *location,
>> +                       int32_t *prefetch_loc, uint32_t *flags)
>>    {
>>           *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>>           *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
>> -       *granularity = 9;
>>           *flags =
>>                   KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
>>    }
>> @@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>>                   bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>                               MAX_GPU_INSTANCE);
>>
>> +       prange->granularity = svms->attr_gobm;
>>           svm_range_set_default_attributes(&prange->preferred_loc,
>> -                                        &prange->prefetch_loc,
>> -                                        &prange->granularity, &prange->flags);
>> +                               &prange->prefetch_loc,
>> + &prange->flags);
>>
>>           pr_debug("svms 0x%p [0x%llx 0x%llx]\n", svms, start, last);
>>
>> @@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct
>> kfd_process *p, int64_t addr,
>>
>>           *is_heap_stack = vma_is_initial_heap(vma) ||
>> vma_is_initial_stack(vma);
>>
>> +       /* Determine the starting and ending page of prange */
>>           start_limit = max(vma->vm_start >> PAGE_SHIFT,
>> -                     (unsigned long)ALIGN_DOWN(addr, 2UL << 8));
>> +                     (unsigned long)ALIGN_DOWN(addr, 1 <<
>> + p->svms.attr_gobm));
>>           end_limit = min(vma->vm_end >> PAGE_SHIFT,
>> -                   (unsigned long)ALIGN(addr + 1, 2UL << 8));
>> +                   (unsigned long)ALIGN(addr + 1, 1 <<
>> + p->svms.attr_gobm));
>> +
>>           /* First range that starts after the fault address */
>>           node = interval_tree_iter_first(&p->svms.objects, addr + 1, ULONG_MAX);
>>           if (node) {
>> @@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)
>>                   if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
>>                           bitmap_set(svms->bitmap_supported, i, 1);
>>
>> +       /* Bind granularity of buffer migration, either
>> +        * the default size or one specified by the user
>> +        */
>> +       svms->attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);
>> +       pr_debug("Granularity Of Buffer Migration: %d\n",
>> + svms->attr_gobm);
>> +
>>           return 0;
>>    }
>>
>> @@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
>>           node = interval_tree_iter_first(&svms->objects, start, last);
>>           if (!node) {
>>                   pr_debug("range attrs not found return default values\n");
>> -               svm_range_set_default_attributes(&location, &prefetch_loc,
>> -                                                &granularity, &flags_and);
>> +               granularity = svms->attr_gobm;
>> +               svm_range_set_default_attributes(&location,
>> +                                       &prefetch_loc, &flags_and);
>>                   flags_or = flags_and;
>>                   if (p->xnack_enabled)
>>                           bitmap_copy(bitmap_access,
>> svms->bitmap_supported,
>> --
>> 2.34.1
>>
--------------CC0FzSHDri08AKkuhSF0U6IK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/28/2024 2:52 PM, Errabolu, Ramesh
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DS7PR12MB8321124485D5DF7E4A0CC67CE3952@DS7PR12MB8321.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">Response inline

Regards,
Ramesh
&nbsp;
-----Original Message-----
From: Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a> 
Sent: Wednesday, August 28, 2024 2:43 PM
To: Errabolu, Ramesh <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Subject: Re: [PATCH v2] drm/amdgpu: Surface svm_attr_gobm, a RW module parameter


Why need this driver parameter? kfd has KFD_IOCTL_SVM_ATTR_GRANULARITY api that allows user space to set migration granularity per prange. If both got set which will take precedence?

Ramesh: Use of Kfd Ioctl is available to users of registered memory. It allows users to control GOBM per buffer level, including overwriting default value. For ranges that do not specify GOBM, the default value will be found. </pre>
    </blockquote>
    <p>If user space use <span style="white-space: pre-wrap">KFD_IOCTL_SVM_ATTR_GRANULARITY</span>
      it will overwrite this parameter value for a prange, then how to
      know which granularity take effect? That is decided when user set
      this parameter and when the api got used.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:DS7PR12MB8321124485D5DF7E4A0CC67CE3952@DS7PR12MB8321.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

Regards

Xiaogang

On 8/26/2024 2:34 PM, Ramesh Errabolu wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.


Enables users to update the default size of buffer used in migration 
either from Sysmem to VRAM or vice versa.
The param GOBM refers to granularity of buffer migration, and is 
specified in terms of log(numPages(buffer)). It facilitates users of 
unregistered memory to control GOBM, albeit at a coarse level

Signed-off-by: Ramesh Errabolu <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 +++++++++++++++++
  drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 12 ++++++++++++
  drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 26 ++++++++++++++++---------
  4 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e8c284aea1f2..73dd816b01f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -237,6 +237,7 @@ extern int sched_policy;
  extern bool debug_evictions;
  extern bool no_system_mem_limit;
  extern int halt_if_hws_hang;
+extern uint amdgpu_svm_attr_gobm;
  #else
  static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
  static const bool __maybe_unused debug_evictions; /* = false */ @@ 
-313,6 +314,9 @@ extern int amdgpu_wbrf;
  /* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
  #define AMDGPU_SWCTF_EXTRA_DELAY               50

+/* Default size of buffer to use in migrating buffer */
+#define AMDGPU_SVM_ATTR_GOBM       9
+
  struct amdgpu_xcp_mgr;
  struct amdgpu_device;
  struct amdgpu_irq_src;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b2..09c501753a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -169,6 +169,17 @@ uint amdgpu_sdma_phase_quantum = 32;
  char *amdgpu_disable_cu;
  char *amdgpu_virtual_display;
  bool enforce_isolation;
+
+/* Specifies the default size of buffer to use in
+ * migrating buffer from Sysmem to VRAM and vice
+ * versa
+ *
+ * GOBM - Granularity of Buffer Migration
+ *
+ * Defined as log2(sizeof(buffer)/PAGE_SIZE)  */ uint 
+amdgpu_svm_attr_gobm = AMDGPU_SVM_ATTR_GOBM;
+
  /*
   * OverDrive(bit 14) disabled by default
   * GFX DCS(bit 19) disabled by default @@ -320,6 +331,13 @@ 
module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
  MODULE_PARM_DESC(msi, &quot;MSI support (1 = enable, 0 = disable, -1 = auto)&quot;);
  module_param_named(msi, amdgpu_msi, int, 0444);

+/**
+ * DOC: svm_attr_gobm (uint)
+ * Size of buffer to use in migrating buffer from Sysmem to VRAM and 
+vice versa  */ MODULE_PARM_DESC(svm_attr_gobm, &quot;Defined as 
+log2(sizeof(buffer)/PAGE_SIZE), e.g. 9 for 2 MiB&quot;); 
+module_param_named(svm_attr_gobm, amdgpu_svm_attr_gobm, uint, 0644);
+
  /**
   * DOC: lockup_timeout (string)
   * Set GPU scheduler timeout value in ms.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9ae9abc6eb43..c2e54b18c167 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -868,6 +868,18 @@ struct svm_range_list {
         struct task_struct              *faulting_task;
         /* check point ts decides if page fault recovery need be dropped */
         uint64_t                        checkpoint_ts[MAX_GPU_INSTANCE];
+
+       /* Indicates the default size to use in migrating
+        * buffers of a process from Sysmem to VRAM and vice
+        * versa. The max legal value cannot be greater than
+        * 0x3F
+        *
+        * @note: A side effect of this symbol being part of
+        * struct svm_range_list is that it forces all buffers
+        * of the process of unregistered kind to use the same
+        * size in buffer migration
+        */
+       uint8_t attr_gobm;
  };

  /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b44dec90969f..78c78baddb1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,12 +309,11 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
  }

  static void
-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
-                                uint8_t *granularity, uint32_t *flags)
+svm_range_set_default_attributes(int32_t *location,
+                       int32_t *prefetch_loc, uint32_t *flags)
  {
         *location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
         *prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-       *granularity = 9;
         *flags =
                 KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
  }
@@ -358,9 +357,9 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
                 bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
                             MAX_GPU_INSTANCE);

+       prange-&gt;granularity = svms-&gt;attr_gobm;
         svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
-                                        &amp;prange-&gt;prefetch_loc,
-                                        &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
+                               &amp;prange-&gt;prefetch_loc, 
+ &amp;prange-&gt;flags);

         pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start, last);

@@ -2693,10 +2692,12 @@ svm_range_get_range_boundaries(struct 
kfd_process *p, int64_t addr,

         *is_heap_stack = vma_is_initial_heap(vma) || 
vma_is_initial_stack(vma);

+       /* Determine the starting and ending page of prange */
         start_limit = max(vma-&gt;vm_start &gt;&gt; PAGE_SHIFT,
-                     (unsigned long)ALIGN_DOWN(addr, 2UL &lt;&lt; 8));
+                     (unsigned long)ALIGN_DOWN(addr, 1 &lt;&lt; 
+ p-&gt;svms.attr_gobm));
         end_limit = min(vma-&gt;vm_end &gt;&gt; PAGE_SHIFT,
-                   (unsigned long)ALIGN(addr + 1, 2UL &lt;&lt; 8));
+                   (unsigned long)ALIGN(addr + 1, 1 &lt;&lt; 
+ p-&gt;svms.attr_gobm));
+
         /* First range that starts after the fault address */
         node = interval_tree_iter_first(&amp;p-&gt;svms.objects, addr + 1, ULONG_MAX);
         if (node) {
@@ -3240,6 +3241,12 @@ int svm_range_list_init(struct kfd_process *p)
                 if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
                         bitmap_set(svms-&gt;bitmap_supported, i, 1);

+       /* Bind granularity of buffer migration, either
+        * the default size or one specified by the user
+        */
+       svms-&gt;attr_gobm = min_t(u8, amdgpu_svm_attr_gobm, 0x3F);
+       pr_debug(&quot;Granularity Of Buffer Migration: %d\n&quot;, 
+ svms-&gt;attr_gobm);
+
         return 0;
  }

@@ -3767,8 +3774,9 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
         node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
         if (!node) {
                 pr_debug(&quot;range attrs not found return default values\n&quot;);
-               svm_range_set_default_attributes(&amp;location, &amp;prefetch_loc,
-                                                &amp;granularity, &amp;flags_and);
+               granularity = svms-&gt;attr_gobm;
+               svm_range_set_default_attributes(&amp;location,
+                                       &amp;prefetch_loc, &amp;flags_and);
                 flags_or = flags_and;
                 if (p-&gt;xnack_enabled)
                         bitmap_copy(bitmap_access, 
svms-&gt;bitmap_supported,
--
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------CC0FzSHDri08AKkuhSF0U6IK--
