Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17874F436B8
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 15:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A653B10EA61;
	Fri, 17 Apr 2026 15:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v3O4j7A/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C08D10EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 15:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+vF6yD8RZ43qONFI3VpCHIUVyMzd0ODFuplI2IqQDXySjWhvtdhoZ1nB7WVBEWBZuq70Q501gN3OMsWvJMrvGEibcSKQfn8p4yDYxduTSTyE2iSGKwgxKGMYX6ynSsuFU7JqMRz/431lS0R2HdfNof+pSv9A6t+ggfTac5CZuGfmPyYTW1k3Qk/tYzj+D0ggMcYZSq55HgJl0bTXEmmwEohcF4WoG1K/4InjQyI43Pb0e3Zk6RlJDskmr0fDyHEj3Mlt821iGMjLiumZh+sDj7tgfuAVHDEW6fmTJ2J8sftnlJX7YUY//5xIexNdCUJ57hzOHVH5zaWn6va/kdjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwb/+5EkCdm+cVVJv46K936+0yBKq024DesvR2F+NMg=;
 b=Cx82KKXw+OwVmsZ7ntP0Yk/5Wn6QDBeQp9Sd/Gv96/Sy5/oGa975KBNMI1WFuiyoIxHfZN/2HW9kNOrWbSwCeafAFguK2BNSRk7k4GlKYdMNv7KqrQwesVH+Z8iyO3JP0h2WP3mFWlIbErwjswPrYdfu9AdzmL7r5N4t5Ca6PpA6GqbH7KACOlZlC27ks8YcH2JxeAf1xnsCkQgXukEpAp2iuJ9o1AbYIh5YLSTgVkuIYzwIE81K+plfrb/JiP6NTXJ99toTnKaZ9yOe8YpURQH3L5QPCA5+VdfDnmYLe9+iw+HJkZUxCxEKkaDZ8EXDoDUH094aXfy5VXswk/mzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwb/+5EkCdm+cVVJv46K936+0yBKq024DesvR2F+NMg=;
 b=v3O4j7A//fs5LENB+dQmjJu8dia0Ga1gFKm0/RM2O4nbylUGGmJGqIqin9DIRWn6iTA1aAAFzbQK5vKO1NgnLSzrOX4ZyMS4uQ992tWgalHYuU7rLito0NANk00wW04ZTyi1p8V2/VZOsbdONACUF+bWhKQ6aYr4w9g/welvLpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 15:22:30 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 15:22:30 +0000
Content-Type: multipart/alternative;
 boundary="------------2Ub3wR1yhyiAOW8TtMeEUs8Q"
Message-ID: <3a365ca3-b2aa-418e-9eb6-9ac2a326a554@amd.com>
Date: Fri, 17 Apr 2026 11:22:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] user queue support for VCN 4.0.5
From: "Wu, David" <davidwu2@amd.com>
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com
Cc: leo.liu@amd.com, Boyuan.Zhang@amd.com
References: <20260210214729.80964-1-David.Wu3@amd.com>
 <5427cf30-9c9d-4904-8058-3a6c9785e696@amd.com>
Content-Language: en-US
In-Reply-To: <5427cf30-9c9d-4904-8058-3a6c9785e696@amd.com>
X-ClientProxiedBy: YT4PR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::24) To CY8PR12MB7195.namprd12.prod.outlook.com
 (2603:10b6:930:59::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7195:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c58146-4002-4250-bb79-08de9c95241a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: 6RNZ3kGToGCUe2vrpLnC/bO9GzPXazyJVAPKiFPfsy9xRoKPJucjt1TXR4NF4sQOZyUESN9Q76GQHFRMKKiHWJVLC63YavuocWCRy6fvgbEUS2lu7UJ1Ywgtul6j5IYjuS/CQr32QUKmohA+JfjL4UG6/9DlqupA1F1syLQgEm94SPDzCSuz0AGZsSIppVTj5ukDP7mNbthFBwx9pN5c3+iuQjjRac7Zn6LC9J9omRdgkxfkqcTgs4FT2dLg5cWk6JV8MgUhm1qjdD4x/SFl2/TjBWueWk2a/RudcLU7NjrrDjCYfqz/SgFbVaqclbkr4u7bYWXDS+5flanpfexBvq+5ws39weyvSwnnPYIyJx5E/9bm7aO4iRTLLUdWcJSRiM94HbT2W1bHZwjFxtI0sRj3WRM7pE+5X416Ob9pg5yfYJEOB4i0cZ5x+x1j0WgW879g/8vS1gpTH9qi7+kro00exPpXseGXYZgeqNZHbLFfVzMS/vuVj4DLp0TPzWYSj0l1ejVhX1+xSIamdjIGdD0gsxsxSIocQ2WAa9YSyfETnwyluBWBfdmcvWUEMTqrDKTcuUJGfvoGESnQ5Z18uZQNYgm0Ww1f6+YxFHfqazpaWlvuZxaWeSf0DwXcwOF2MNiEEO9THdryyS3aZLAw4nZOaHqRH0eqWZ6Kr5qo6Easq9GtWnfh5Ekr4Cj0vzfG66A90VSWgH7OTetMsl5FbzHZemHrKxGg0O9Edv5K8DI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7195.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0szRFdVMGhRMFRTdFRuT0NxT1QwME9ETittRkdOZkx3N01Wd3pYT0hYdTdT?=
 =?utf-8?B?V09RRTNFano0eHRoSHZtOWZLSHlJanJ5UHpvZXVSNGtCVHlYSmRzVDM4Nmhz?=
 =?utf-8?B?YmdweWhOb3RqdEVTSGpUa1B1WVZqV3NlNXVwU2FsQzQ2bGNIL0RnQzQ2M0hF?=
 =?utf-8?B?SzBsTTZYWVA4QmZ0cTUrN0hIYURST2NmbllxcVRod3g4WmZJc3IrZ1lBekpm?=
 =?utf-8?B?V1BuTkdOZjF4LzJ4UEgwTG4zSGIvNHZ2OVAybGtKbVB5MVJiTCtrQ2NKY0Y3?=
 =?utf-8?B?bFFXbXovZjZNNGNFT3hsZCtXdXRUb0F1K00xUENEbFAyN0k2R3VRUWlHZmhY?=
 =?utf-8?B?SllMNlZrdUJvdTRwM3FsZ0hQdWkxRGpvNEE4VFlmR0o1cTBIR3RBOXViZTJa?=
 =?utf-8?B?YnNVNzUwWU1hWjk5SjhvU0E2ZG1MdldHZXN3TVh6RmdLdnhEaW1oTDk3VGxE?=
 =?utf-8?B?LzFWUEJpNFpqNDQ2UHFJSWlZU2hLVzFzSnBpNS9XWmJPQmRPY2R0dXlyK3g4?=
 =?utf-8?B?ZFBJS2U5bnFXaVVmSkdtaFM4eUlNRFVOQTdWaTNOU0RYSGpDZ1llM040Y2FJ?=
 =?utf-8?B?R2xWWmhCZjJaMXFrUTA5U2RqcTJmcWlGS1FxVFNUVW9Da0hGMk1rUU1JV0tQ?=
 =?utf-8?B?TGFUdTFhK0hBYUszblRKNndmSkdSZkhNNFhWd212TklwNU5xeVFsNCtRNW1S?=
 =?utf-8?B?SnBvcGQwa1oydVpWZExheW1xdGg5eGtqSDlrRFdFRGtNdGxUa0pzSzFxcDVM?=
 =?utf-8?B?RGs3OEdWL2ZKZmdjR0lKWmFpSzFCVXJrNUNSTmRVeDdBZ1ZtRittQWdzOGE0?=
 =?utf-8?B?c2RCK3pQcmZldS9GY3R3M3JnNFhIRkY2Qm1MTHhBbHpNTGxNUXhlM213Wm9k?=
 =?utf-8?B?MjRick5PNW5wcUYzRXcwU1FNSHJ2NFBZeGxKcXU1dnVIT0RObFk5d1IwTHNm?=
 =?utf-8?B?TGZJblV2NHh2Ym5DR25WMTBLYld5OTlZbWZWYXhvTUpTNnlwS3F5ZnlqeDJH?=
 =?utf-8?B?SWhPMFRNQ0dlcFY1cVBta01OWlZaZUxoMlFQNCt0K3Y0cENnU3IybVZqTGNS?=
 =?utf-8?B?THZhWjloazFTN0VrM1lPcnY4K1pGNFdPSm5KUEJVZzc0OFcyK2FTMHVpdGxG?=
 =?utf-8?B?T0hWMnZCZktIQnF5NmYreWg0eDBIbmRjbXY4MmY0bDhrdG1xVk5GMURlWjJ6?=
 =?utf-8?B?dmhOMTBUNlkrUWdHays1UWpNNlhmVGpMbzJJOFdFUFEvN1VlSkVLK2Rmamdk?=
 =?utf-8?B?dmxxSXMxTjArTFNmK1FoWXF2MEtvM29yTkt2YWk1Y0FjUFl1ZWppd3hxQVFx?=
 =?utf-8?B?VHJoMnhDd3JORUVFS081dUx4QmFJUDdJNHNrYWZvMFZwSkpLNGJ2Qkp0aXh6?=
 =?utf-8?B?SFpVUmdlYmUzaHk4d2djOU14YjNjYk1nSWhSckFkckkrNWtnTU5jYWtEM094?=
 =?utf-8?B?cTMyZ3doQUNiSVVJaVJrL3VsdjIyOWlEczdIc3NLZ1p5eUpHMjFJcEZrSytr?=
 =?utf-8?B?Z050YklrOWxuZTJEbm83VDcyejVUSm5Rczc3T0p4b2tDZU1NRmhQTHZFQTN4?=
 =?utf-8?B?eWZnbG1PVmlJVmZOQ24wbnA1c1FGc0I4WjFPbGUyYmZzNUdnOW5KUTNMZkdT?=
 =?utf-8?B?NEdFeW5Yb1p1YWhYNTl6VmRvTHJEb0oxL3lINTVnd0ZCOHo4d1JlNkR6UXF6?=
 =?utf-8?B?M0JIb1VQNDZBQUJaeXE1RXpBbjNQYTZmSVZsL0p1VlJ6TmFlMm45dDEwSzZS?=
 =?utf-8?B?OTVQUGdJVE41SlYzK25CeWFyZGJVa0RXSUhYOWtXMjZldFRiUW1LK3VBRys1?=
 =?utf-8?B?SjFyTVdRaEZLZWxVdjF4eU44NWJHbC9IdEZsQXpzZU1Ub1YxWHRvbFRmdmZW?=
 =?utf-8?B?Z1ExbzNkQzNEMEZjNFZBWDE2UkVpNy9oK3dYNWtoWS9nSTNTRndqenB4R1ZX?=
 =?utf-8?B?L3VoaldsNW5HYnJ2UjRoSFdLSUw5SGFBS2FGZ2RDVGRQdFRkNjIxekEwMUlO?=
 =?utf-8?B?WExZcXV1blNGQVBKR1NoeCtmSVFQLzJGUDN1c3BJNVJISXFwV3JLRHplZkhh?=
 =?utf-8?B?YXJoSVJxdXJ6TTNOTmRDd3l4MjhUVHZFNkRWa2lZU1JlaEw5SnJrV3BESm9p?=
 =?utf-8?B?MmZQK3d1WFhmTTQ0NkZlZHQ4d3Y1WnpUYnB0bk9yd2I5OEFwV1liSitILzRE?=
 =?utf-8?B?bkRzSkxSWHcwT0tOWTE4NUdkejR6RXJjTkxncDJGMExsdkVObzh0dVRueUxZ?=
 =?utf-8?B?ZjUyMWhFRVRCQjIxSEtLaGxqaDAwT0szR3doV2JuSUxXazBDSXExZEliNGFi?=
 =?utf-8?B?dUVLTEVBemdWd0lCVVo3bzZ1T2hRV01ZOUVFV1dNS010SXRkRks5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c58146-4002-4250-bb79-08de9c95241a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:22:30.6333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJvGu2LbotwEWeKOcSyC2ciOvoNHDH2OPtpDGc6eoa5n0t4FAF4oi66CpalUqKWip3aoQTKywVPv2IR65vn44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
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

--------------2Ub3wR1yhyiAOW8TtMeEUs8Q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

ping...

On 2/19/2026 1:00 PM, David Wu wrote:
> ping...
>
> On 2026-02-10 16:47, David (Ming Qiang) Wu wrote:
>> add user queue support for VCN 4.0.5
>>
>> David (Ming Qiang) Wu (10):
>>    amdgpu: add global aggregated doorbell bo
>>    drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL
>>    drm/amdgpu/userq: add doorbell size for VCN and VPE
>>    drm/amdgpu: use amdgpu_user_queue instead of amdgpu_umsch_mm
>>    amdgpu/umsch: Add VCN IP init to umsch driver
>>    drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to be common
>>    drm/amdgpu/userq: rework on amdgpu_userq_create_wptr_mapping
>>    drm/amdgpu/umsch: user queue support for vcn
>>    drm/amdgpu: add AMDGPU_INFO_DOORBELL
>>    drm/amdgpu/umsch: userq suspend and resume context
>>
>> Saleemkhan Jamadar (4):
>>    amdgpu/umsch: Update UMSCH interface and mqd structure
>>    drm/amdgpu/vcn: changes when kernel queue is disabled
>>    drm/amdgpu/vcn: handle interrupt received from fw
>>    drm/amdgpu/vcn: handle the suspend context interrupt
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   2 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  16 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 300 +++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h  |  43 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  69 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   4 +
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  90 +-----
>>   drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    |  75 ++++-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 122 +++++--
>>   .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h |  10 +
>>   .../drm/amd/include/umsch_mm_4_0_api_def.h    |  12 +-
>>   include/uapi/drm/amdgpu_drm.h                 |  14 +
>>   18 files changed, 646 insertions(+), 151 deletions(-)
>>

--------------2Ub3wR1yhyiAOW8TtMeEUs8Q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <font face="Helvetica, Arial, sans-serif">ping...</font><br>
    <br>
    <div class="moz-cite-prefix">On 2/19/2026 1:00 PM, David Wu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5427cf30-9c9d-4904-8058-3a6c9785e696@amd.com">ping...
      <br>
      <br>
      On 2026-02-10 16:47, David (Ming Qiang) Wu wrote:
      <br>
      <blockquote type="cite">add user queue support for VCN 4.0.5
        <br>
        <br>
        David (Ming Qiang) Wu (10):
        <br>
        &nbsp;&nbsp; amdgpu: add global aggregated doorbell bo
        <br>
        &nbsp;&nbsp; drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL
        <br>
        &nbsp;&nbsp; drm/amdgpu/userq: add doorbell size for VCN and VPE
        <br>
        &nbsp;&nbsp; drm/amdgpu: use amdgpu_user_queue instead of amdgpu_umsch_mm
        <br>
        &nbsp;&nbsp; amdgpu/umsch: Add VCN IP init to umsch driver
        <br>
        &nbsp;&nbsp; drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to
        be common
        <br>
        &nbsp;&nbsp; drm/amdgpu/userq: rework on amdgpu_userq_create_wptr_mapping
        <br>
        &nbsp;&nbsp; drm/amdgpu/umsch: user queue support for vcn
        <br>
        &nbsp;&nbsp; drm/amdgpu: add AMDGPU_INFO_DOORBELL
        <br>
        &nbsp;&nbsp; drm/amdgpu/umsch: userq suspend and resume context
        <br>
        <br>
        Saleemkhan Jamadar (4):
        <br>
        &nbsp;&nbsp; amdgpu/umsch: Update UMSCH interface and mqd structure
        <br>
        &nbsp;&nbsp; drm/amdgpu/vcn: changes when kernel queue is disabled
        <br>
        &nbsp;&nbsp; drm/amdgpu/vcn: handle interrupt received from fw
        <br>
        &nbsp;&nbsp; drm/amdgpu/vcn: handle the suspend context interrupt
        <br>
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |&nbsp;&nbsp; 2 +-
        <br>
        &nbsp; .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c&nbsp; |&nbsp; 16 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 10 -
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 18 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c&nbsp; | 300
        +++++++++++++++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h&nbsp; |&nbsp; 43 ++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 69 +++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/mes_userqueue.c&nbsp;&nbsp;&nbsp; |&nbsp; 90 +-----
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 75 ++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 122 +++++--
        <br>
        &nbsp; .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h |&nbsp; 10 +
        <br>
        &nbsp; .../drm/amd/include/umsch_mm_4_0_api_def.h&nbsp;&nbsp;&nbsp; |&nbsp; 12 +-
        <br>
        &nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 14 +
        <br>
        &nbsp; 18 files changed, 646 insertions(+), 151 deletions(-)
        <br>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------2Ub3wR1yhyiAOW8TtMeEUs8Q--
