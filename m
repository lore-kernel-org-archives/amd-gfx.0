Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CF7C0218D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 10:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5F910E276;
	Tue, 28 Jan 2025 10:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KBJaz5+1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0E810E276
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 10:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT/XPU/++gUUnoDvWIo/dvAACmU6OSjFEeRe5EuAdf3Nqw5XjD4J+w2f9oOYaQojwamHNPzA+GA7t30QNUa+lWGqm/OiaNdhAl5w5xXhxm3U5XHG9Px15zBxUmPyNOg+X36xwzVufLA6Jk7fEwMO1qZZHjs4TajDPwjuP5FvfV2jMOyDDrc9nkjNy7j8RF1Mwzho+glBwoOktb+TNGLPpzNiSLhtl0roVPugCyIQtyMRDhcvReIZfgXnPOhA298xbGSu6+cP5gDCbY4EuYGDBL4MbiwukXOh65UTTGoUEzcRmkdNVVPq0sV/U8wiRSay1LSU1hAzaXDOIoj8olthSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuYPZsaEVK+aU8ozWTDeIV5CRes8M+u6LrosFul0sCk=;
 b=W7+XP0W4rvXMMFugQZ/R4SnZdQXBaJcw+i+ZqkqLYoWQO5D/mw09b2SAPHuN51K09kXbAAG04x0/7IAES83nJuPbrluSxXZDWNixILHdUVMgzv+eEBLMLBH44g73tYiKY7Gn8oytBL4NsicLhJFyAIeuRO+tbYBJDGIDW8RpBGtv77zY0IBVa0Y+vyFpoJh/1a0khnvwGDhNz37kRdR9IsW41IiFVR7UY+etqxsFp+leXTeyhDgCeoUumyFqmQ2oWIE9vLCDOGotxsLRTYt8qg7eQVpXC3d72/KdUJR4VsL+1TC8+sOXrUdhHGu3vRHN/a9REMl5FtJ2EDcVtjjgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuYPZsaEVK+aU8ozWTDeIV5CRes8M+u6LrosFul0sCk=;
 b=KBJaz5+1P8DsYzoYDOfSxcn7zgpVtgErv97vFyiLWeyCXhQZywFbw+/jlFBpfPWxbfvYBBMYfvpweilYEurIdWk0ZQpL9XYUcUp/eSKmdSxduCl9t39RCRHnuAp75laxuA8uqR1nEorzjb0jKDsFKNvY4cLgVsUyVdpc3Ctu3y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) by
 LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 10:25:05 +0000
Received: from DM4PR12MB6304.namprd12.prod.outlook.com
 ([fe80::81da:b334:9e6:2b91]) by DM4PR12MB6304.namprd12.prod.outlook.com
 ([fe80::81da:b334:9e6:2b91%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 10:25:04 +0000
Message-ID: <ec3cb4ce-084b-4a78-a6d2-d973ec955008@amd.com>
Date: Tue, 28 Jan 2025 15:54:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu: Enable devcoredump for JPEG4_0_3
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
 <20250128090950.461291-4-sathishkumar.sundararaju@amd.com>
 <a4060452-f20f-4ca8-b0a2-cf64f06da597@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <a4060452-f20f-4ca8-b0a2-cf64f06da597@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To DM4PR12MB6304.namprd12.prod.outlook.com
 (2603:10b6:8:a2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6304:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ad3144-b248-4be0-5b16-08dd3f8607bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkQ2ZlVXRnFCakR0dlI3MHJtSk5FWnNsL3dUb2d1YjUzMlcrNmNxODhOUXgy?=
 =?utf-8?B?MUhqaDVNc2V5aXB4L2pGeE51YTNtRzNTNDdVdGdDd0RrdXU0cFRjbTFLODRZ?=
 =?utf-8?B?czIvYi9kVVdMdWUyRFRmSnJhWmJpcjdkYWVjTzZzZEFDUyt0MmJzTnBWMUJz?=
 =?utf-8?B?UWJmTFI1bnZ3QkRlSFc5TnhGaHkrZUJhV0lYNTlHamFSaWtxM0JiSWQ0N0hP?=
 =?utf-8?B?VFhma1hUb3hQUkVIQS9iVC83U2VYMkR6VzNlbytmQkZGa0NCbnUxSGwrb2xP?=
 =?utf-8?B?K3BUeTN4ZlJkMjQ5OWp0NmVnZFFJOEErTkVacFlzL1k2UFN5eGFtS3NSZ0JP?=
 =?utf-8?B?MDIyRE1hcEZndjU3R291alljSGZIU1dGS2pPNTRRM1liUjNzT3luT0ZDNnVo?=
 =?utf-8?B?NHR2K3ZxQjVyZ3ZSRGlmOGtOVDhEOUpYeG85ZWxscGdyM1ViREJBZGJ5ajF1?=
 =?utf-8?B?OUVjdWQyYUxGNmdXeWdubDFlaU00MUxGSWhMZzZ3MXd0REl2b0YwSVl2WUhj?=
 =?utf-8?B?ZmVEZ1Z5eTE2RGgwcmlsVlhrQkI3TmNOd2N6d2c3WjRHKzdwdXFJYnhLYURy?=
 =?utf-8?B?NzR4RVFNdWcrVnZ5MzA5ZFJzdkJUTlhTU2M0OXZ0cjVIM2M0V01STUUzQTFH?=
 =?utf-8?B?d3pMVGNBZ05XS3AwSm9neXMvK2d6NG9VV21BNWthelFWVU9tTndGZGJtOWND?=
 =?utf-8?B?Tkt6UytsTVU5cjg4akN0RGZVVWZ6TTFkSVNwSFVLN1FLemo0UkdkMkl5WVVk?=
 =?utf-8?B?ZHBYOWx5ZU1hcjNlb0lEZ2RMUVErdnFTa3k4RXBoUk84QnlPU3cxT1Y3cFRn?=
 =?utf-8?B?T0Y2cFlRWmRDWEhNVEVOaTVQWlI4U2E3OGdycGF1OEVLRXFwYURRL2JwRUJF?=
 =?utf-8?B?SGJzaE9welBGc29EVEQ1bThzSTZ3TkkrZjF0RUlJOVU0Rnk5TkQ5Nkowa1BI?=
 =?utf-8?B?L3RlaWw3dmpsTkJHcEFYWG1NWVdqS1kwSDJrSnREYndwVTJQMk0vTkpramJH?=
 =?utf-8?B?dWF4N1FibkN3MWt6UUo4ajMzV0NUbmxuTldyYkZMVG1ib0RMTG1PU0VzTVFl?=
 =?utf-8?B?aE5oT1k2cHJHOTl4enFraytFbU5qWEhsNlhYMm9NUVZ0bjZpSkJtMFQzK3Qz?=
 =?utf-8?B?R3RsSXVFTTdxN3VURUNKTWZPTExEbk1Hek9zUlE4akZIMHN0OFprNExacWZw?=
 =?utf-8?B?SzJFeTdsVUMvTkw4eHhmUWs1UitZWjF0L2NBanplQ0pJS0IwZHM4c0RXY0Y1?=
 =?utf-8?B?ZGxEUStNNzlSZ3BlbFdkdEhJTjBEc2IxVGluSlQ4Q1E5TFU2Uko0NllaZmVR?=
 =?utf-8?B?SEdWQmRGRGcySXFyZ0dQcjVWbWYwYnZ4dEY5WW9SRmp4Qmw0OEpVVzRaQlc4?=
 =?utf-8?B?Wm5UbklySGZXY0RUSUZQQXNicUlva1dOd3BiSEJFVVRWWmRSRVdEcXdCYTh6?=
 =?utf-8?B?R0lmamxmdHlXSXB2bjRWcEZqY1BwZlNTSDJSWi9uOVdlMmFFWXVmVUJnazZs?=
 =?utf-8?B?Y3d4YXNhcFkwZ3FtcFE0MjhGdkM2ZUx5bHpZTmd6K2FQQmJPVVZubUo3Uk9w?=
 =?utf-8?B?WEt0dzlURXRodjViaW9yV2Q3Uy9CNnBTdzZtZlFhb2xsSnFZVmVUcFpFa1dL?=
 =?utf-8?B?NExZYzh2MWdLL1VvY2FnTlJDSldoQVNsRDI1WEUrdHFyaUp3K0hGampjYmJX?=
 =?utf-8?B?TzZNVHFGMFdpd2xwOThoYW9DcTZQSGhTRmp1OWdjcmxBWks5MkJBaXR4YmQ1?=
 =?utf-8?B?NFdpb01hYTNhR1hvWXBYSnZIc3J5b1BWaHl5UnEvVkszcktINHFLaWZiOXVY?=
 =?utf-8?B?WXpxcTBmaS9qY3NwRmZkY2dHazF0L0pJZFNMOGpqa1g3RnZ3bEtTWkEvdXhE?=
 =?utf-8?Q?N7MJkf3nIGx5c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6304.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZhRldLT1RIMGUreTFJMzJRSnBNb3hmcDRSTVpNUFcvc05Qb0NjWW9ScmRQ?=
 =?utf-8?B?OHVMdVpVUFUvSlRydzlUNTJGS3BPdU5YZFNjbkVTQ2RVZjgzajVrNlpjMnI4?=
 =?utf-8?B?cTkvbTFQLzM2VjB1Vk9YL0RQZ0NGRWRWUTRsbFZGS0pYOFdnN1NuWFFJMHZY?=
 =?utf-8?B?MXlJRE5xVEVqQVZuM0dFMFFCN0xtK1EzWHkzd3ZYZFJtbHFpc2xJa3BzRnVy?=
 =?utf-8?B?V3hXZzk0YXppSEFpbCt5ZFM1Vkk2UmJuZUMwUkx4VDRKNG1GbWs0bU4rSWdT?=
 =?utf-8?B?dkZ0OW5pakVRcURsckxZcW5DRGtTOXhKN1dYMkt6R3JCQWkyTmpXRmdoWFZp?=
 =?utf-8?B?VDdRNGhvQ0xPTytFNFRLVDlnUHY1aTN5ektxellDU1I2SFdDUFhXZW9xTWp3?=
 =?utf-8?B?QXpVYnVzTm5PZTlIOVU2S2JkOVNKTXR4VDZ2R0JtODBkSEJFK2NhTEkwVy9M?=
 =?utf-8?B?bWs5SWcvNlE4eXpCQ2Q1RGgzYWlyOXRjd2Y5OEVDUmQ2Uk5xM2JJWHB2VnJu?=
 =?utf-8?B?YitnZHRLVFpXd2hpMkhvZS82Z1dpMGxFakdKcUJMYWFCZkNNWkEvZG1zdVZn?=
 =?utf-8?B?NjNySkxaQ2tCNGhndW1FVzUwcW43dngwZ1FRV2JlVVBwUS9UUFg0Kzg3WDl0?=
 =?utf-8?B?ckxaWDEydE12dUVwZDN2S3R4Z1lvVEE5ZVhBVGlYRys5dGFscjM3QkFUeE0z?=
 =?utf-8?B?WC9lWU0rZWZLYzI1dWt2ZE5xQXlYa2ZnSExXeGdFWTFsY0pseEdKVElZUmJz?=
 =?utf-8?B?Y2RlcDVhUlZGMmpvNVc5d0RoeU4vK0RFb2lSdlBEQnhHTHRNWkJWMk9kMzNt?=
 =?utf-8?B?V2g1UVYyVkk2K2t0NUpaaWxHZUlSY0NLSWtLdEJqU1VwZkUyZGJuVmZqN29p?=
 =?utf-8?B?U1k0Z25SajU2bUt6ODJMMHcwU1dZMTh5UWRpWUNlS1VFVFZwREJQcVhNTXFK?=
 =?utf-8?B?TDVwaGViWkNrbHpxeU4xUXNzZFZmd0NyTDBDc1RxVnNtWUJzRGNvUzF4RkRW?=
 =?utf-8?B?TnYybXdrd3YvTmtORGdaN3lWSGtzdmV0d0J1eDR0aVh5T1dCMHVRTnNONzVm?=
 =?utf-8?B?dkd1TFFVc21rcDZVTWM4VEx5MDd2b3hiUHJuMGlJR09GVU54WDhaZXNEeGg4?=
 =?utf-8?B?UStzcEZ6UFg5ZXlNdWlZSGR0TzF2VkNqZjZvaXBna1RIUjJIMDBrS2ErSlgx?=
 =?utf-8?B?WFlOUGdlOHZrcmJtalpjTzFsbmhaL2ZlcVFpV2VZdWpQMXJFcGdsSmhVUE1z?=
 =?utf-8?B?dUxTYzVOQlo2ZmJ2VlRCVHFmNEh2WkR2SWJGQ1FMR3Vsd25XemxJdTFtQTAz?=
 =?utf-8?B?b2dCZFZUbWNpMVgyWmltN05MS0Y5UnIyR1YwVVd3MWJ1YnNDcDZ6dFJtK1V4?=
 =?utf-8?B?WUVTb3ZaODRubHBsSUxlS0NlL3RXbzFrZ3A5a2FKMnd5eVg5ekREK0FtVlRr?=
 =?utf-8?B?VkVNVFV0Ui9vQmljdGVHRnhWUDFKU2xnSFVYaEpyMHo4eVpCZS9nKzNYMExQ?=
 =?utf-8?B?SnlpcWQ5dEx4WDRCMFFsUGdtR1J2T1ZHTmdicG5SM2hScFNCU0dNOXhCTVFh?=
 =?utf-8?B?Qmh6bEVUekhGelhQbDh2d2QrN09LdVMvMU82bVYyME9XeTYvdXd3RGlXU1RC?=
 =?utf-8?B?eWI5ZCtMaFhtSWdXcWt6a1hid0Fua2hKNHhvanFheFBDamNUemJVbVNnQmEr?=
 =?utf-8?B?U3ZKdzNZeHBTSXQ1UXpqd0IvNWd0Q2xra1ZFOFpRaVUvcnFlOFgyeVJ5Tm1X?=
 =?utf-8?B?d0VQT0dPN0poSjIzU3lUTmY4UG5nVkV6cmRmTmxoZlFVMmVZRU02UndUZ255?=
 =?utf-8?B?QXVrQisyZlp2QWpRczE5ZEdCZXIvNDFxcml0Nmp0d0p2ck5YZWFneWx2eFJq?=
 =?utf-8?B?UDVhVW91bkpXMUp1VkZ1Nk80Tll1ajc5U3RaMzI3U09NM1Y2K0FGdkZmc01a?=
 =?utf-8?B?ei82dHNFTERxS1VTYlVNRjFad2xLYzZEK2hGL29HdzJtcmZhS0RYZm9GcjQ2?=
 =?utf-8?B?cmtyYUdDcTZaeGxMbG9SYlJpVC9MSkI3aytCSS8zekdaSHdXdlZlZGJuTzYw?=
 =?utf-8?B?eTQ4a3dMaWUzSzA5bDRrMVFpNUxYdjNkUmN1RWNtTmtUSU9jL1VodXdGWG54?=
 =?utf-8?Q?JZYSo+GO587adl0E4aWPDrpW3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ad3144-b248-4be0-5b16-08dd3f8607bd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6304.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 10:25:04.6439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ka7NrnFxKxXTgxYXYg8FV/4Qx9wqEVJ62azmz7NY5RBzuohPxuLzxGdXf04+oJr6tJFLPIZCA37zy36bSNu7/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213
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


On 1/28/2025 3:16 PM, Lazar, Lijo wrote:
>
> On 1/28/2025 2:39 PM, Sathishkumar S wrote:
>> Add register list and enable devcoredump for JPEG4_0_3
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 58 ++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index bc21f12daea8..39fd678dd874 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -47,6 +47,8 @@ static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>   				enum amd_powergating_state state);
>>   static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
>>   static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring);
>> +static void jpeg_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block);
>> +static void jpeg_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
>>   
>>   static int amdgpu_ih_srcid_jpeg[] = {
>>   	VCN_4_0__SRCID__JPEG_DECODE,
>> @@ -59,6 +61,42 @@ static int amdgpu_ih_srcid_jpeg[] = {
>>   	VCN_4_0__SRCID__JPEG7_DECODE
>>   };
>>   
>> +static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0_3[] = {
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_POWER_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_INT_STAT),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_SYS_INT_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_ADDR_MODE),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_PITCH),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_UV_PITCH),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
>> +	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
>> +};
>> +
>>   static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
>>   {
>>   	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
>> @@ -164,6 +202,11 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>>   		}
>>   	}
>>   
>> +	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_4_0_3),
>> +				     sizeof(uint32_t), GFP_KERNEL);
> Probably, this can be simplified and kept under common logic
>
> amdgpu_jpeg_reg_dump {
>
> struct amdgpu_hwip_reg_entry *reg_list;
> int num_regs;
>
> };
>
> amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0_3,
> ARRAY_SIZE(jpeg_reg_list_4_0_3));
>
> amdgpu_jpeg_reg_dump_fini(adev);
okay, got it, will rework this.
>
>
> In that case, amdgpu_jpeg_dump_ip_state/amdgpu_jpeg_print_ip_state will
> be good enough instead of keeping jpeg_<ver>_dump/print_ip_state
Right, this can use the reg_list to dump/print and can get rid of 
version specific dump/print callbacks.
would prefer to maintain the *reg_list in adev->jpeg and have it 
initialized in amdgpu_jpeg_reg_dump_init() as suggested. But regarding 
the other suggestion, w.r.t to per instance dump/print, there are some 
limitations, which I will try to explain in the other patch. Brought it 
up here as there can be relevance here based on that decision. Regards, 
Sathish
>
> Thanks,
> Lijo
>
>
>> +	if (!adev->jpeg.ip_dump)
>> +		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
>> +
>>   	/* TODO: Add queue reset mask when FW fully supports it */
>>   	adev->jpeg.supported_reset =
>>   		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>> @@ -193,6 +236,8 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>>   	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>>   	r = amdgpu_jpeg_sw_fini(adev);
>>   
>> +	kfree(adev->jpeg.ip_dump);
>> +
>>   	return r;
>>   }
>>   
>> @@ -1053,6 +1098,17 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>   	return 0;
>>   }
>>   
>> +static void jpeg_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
>> +{
>> +	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_4_0_3, ARRAY_SIZE(jpeg_reg_list_4_0_3));
>> +}
>> +
>> +static void jpeg_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
>> +{
>> +	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_4_0_3,
>> +				   ARRAY_SIZE(jpeg_reg_list_4_0_3));
>> +}
>> +
>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>   	.name = "jpeg_v4_0_3",
>>   	.early_init = jpeg_v4_0_3_early_init,
>> @@ -1066,6 +1122,8 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>   	.wait_for_idle = jpeg_v4_0_3_wait_for_idle,
>>   	.set_clockgating_state = jpeg_v4_0_3_set_clockgating_state,
>>   	.set_powergating_state = jpeg_v4_0_3_set_powergating_state,
>> +	.dump_ip_state = jpeg_v4_0_3_dump_ip_state,
>> +	.print_ip_state = jpeg_v4_0_3_print_ip_state,
>>   };
>>   
>>   static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {

