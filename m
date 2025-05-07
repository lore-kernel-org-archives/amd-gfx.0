Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA864C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35BE410E844;
	Wed,  7 May 2025 15:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uBBPld/Z";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2578710E844
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGyL3IOq767gfpzJNcT4Dg5mUk9D4moY7VgXHPG+pkuPONrnomwC3uOXM4IY1r2o8Nd25Q0XTTDpGFvhEJ52BPIXY9RauMRn7SNICRib9QXl/QjuCWhyeyZSlTuSH1q07qcChA0VEkHRKJNbUo0ujegKw2cz8adazVQVg9slnrUasJRzM+eS5Ms4C4FoyjPnsc/RLnZIUytzUj7pqZMJWMYIUC1oNKDp3rybdciZpriAIQuNeckQbi2KST62a4vl4eb/4NkY+dyk8wqbvDDd7CV3r5OYkMhQDsTQqQUInUU23wCgz1NjNuDqcZkvA/mWaNpjUTh9Rx2MiYU9hiBiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyyidv5s7X1TBfsXaAnYtPsMVaz3Li2SJPZda3VNDS4=;
 b=yTsz/4Y0d8AifYkypVedKH/2qI5BC9PJVGD3lVGqWlOFPizAOMMUCCc+9qFy4kD2T4TdCByIDKfQadgBb9unsiPhJYs4ZorLBd1tkPI9dnEzOGdkrspiRywreyCeNAmXMflrupydT0hw8H5v0Dx3NVaGuc14mV79bVShMf4JziFE6TFM03hSNA7b8kVe4UhnlGxKzKhvAktvgTHf+B1vt5dHfJ1AD6JxARQd7DFcd2nRUPcQVp4+9HfNPb6z6aeABujnVPUaUdV4PttyOdrbCIBH1kdd0DZ2ZQqwUTHmLuqWNoWpD7bSalrHCOUcTYNhj/TQwBOF47lKzw1gaiuasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyyidv5s7X1TBfsXaAnYtPsMVaz3Li2SJPZda3VNDS4=;
 b=uBBPld/Z8rI+tli+1faVvAFZ6pQ0aGObMJpgOyx3rIcV19j+K4Y6cFuymE9G4Vbd+dC3yhnyg9n9jfNba61E6hKvHi1qmfVDduKyMwdCNeaTzkZpAXswMqdRnJIWYkqjjhzobh/qVwLusgK7/46Ln0GxccyjlMmeC8YENS2xK5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 15:27:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 15:27:42 +0000
Message-ID: <2227b521-3f4e-41de-90ef-fe3d2d031c67@amd.com>
Date: Wed, 7 May 2025 11:27:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] Revert "drm/amdgpu: Use generic hdp flush function"
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
 <CADnq5_M3k7RmOowRW+GDh9Kn9MrTXNv7Vc4b=Pd0UG0w22Qr5A@mail.gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CADnq5_M3k7RmOowRW+GDh9Kn9MrTXNv7Vc4b=Pd0UG0w22Qr5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: bc140268-6696-41bd-eb27-08dd8d7bb583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWM0MkQ2MCtmc0t0OUVtbDZKcm9aZ1BjTUQ2ZFdoUUoxQUVyK1AvZk9TRlVH?=
 =?utf-8?B?ek1qRHFzNlE3YVJ4NGVQWXczVzJQR3NIeGNQTFJiMldZQk1YaXc4akdlUDAx?=
 =?utf-8?B?MDNDY3dvd29oMUdNL2kzLzY2N3pUNS9TZ0FVS3cwS0pqNDhpb0t0UXVDdERK?=
 =?utf-8?B?THZBMVFFY29WS3Fnd0NaWWxEZnVXR2FZRlNDU0JZdEFaRTJ2ZEgzZFlFdFYy?=
 =?utf-8?B?UGF1MHRwRHBUYld6cytFcnF1dzJyQlZLWkM1bXJtOTJVOHVKZ2RtZFF0bmNP?=
 =?utf-8?B?Q3JiK082cE1oenlhdnltdXlSYzhZNW1mZk5TOG9laFloVWtKOFRmMHdieisx?=
 =?utf-8?B?MGJDYmpXZUpJamIyRmNTcEFjdndpTlJVejlxNTBBZGpzWHRYM1J4OW1valNK?=
 =?utf-8?B?cFprZ3g4clNOT0dZMUFzdGhjOENvS2dNa3dvUGNJbHVMRmRod25WOGU4OG03?=
 =?utf-8?B?VkxOWld5T1F2NzVObnZOMlJBY29DejV2Y0dSdFBiSEF1dE1JSVBRR0JnOXlm?=
 =?utf-8?B?Y2pQSUxIT1Z1RElWaktEOHF1NHFJMjBQM1RTeStkbnZPRm0rOXFLZmJPTXRq?=
 =?utf-8?B?OFRFaHMxenpnZGRzQ2xSVENBekZvbmN0OVFHU1Q2QU53cHB4UXprbEE0ZHl5?=
 =?utf-8?B?d1dtKzIzVmw1KzFDN3U3U3JIVmx5ZHBnQ0RXTG0xNG13b1hDSG1nTlBtMnZa?=
 =?utf-8?B?VGV0c2FlakdrYmJEY0JZTHhKbC9mK1hCanMrVTBSdTVNejYrNmdqRGgxMjdX?=
 =?utf-8?B?bjgzOEFOZkttQURZcWJGNVJrVVBseG9YeG5zOWNJWkVmVXdmVGQvakRURkE3?=
 =?utf-8?B?amlGVnJYdFVSS1NGTVlUY1llcXF2Z3JEQXhLdEJVa1V1WUpnVmV5dTNZdlhJ?=
 =?utf-8?B?SUp3KzVHRFF5WnBvRGEyWHNmWUdNNnMyWGk3RnBxeVlLY3B6c1poMS9BN0VF?=
 =?utf-8?B?V01jRXlpOEZwdjI1cTl5OEErdCs0WkhhWkVlcmVKMldWVWVYcXU4T0p0dnpv?=
 =?utf-8?B?UzVidDdwcGNvRzE3UkFLbmt6K09YcUlqbzRYdjdBL2M2NENGdmlmQ3BsbEFL?=
 =?utf-8?B?ZDNpN1V2VXozT2V6VUNQSjdmYkJZbThVNDlQVWZ1aHI1WXBDRVdQNlFlOUVB?=
 =?utf-8?B?MmlPSGNRdURjNWlwUnFsQnhsV1M2ZGMySDNZZC9xalAvQ0xQK3ByL3JRWjRN?=
 =?utf-8?B?ZFcvZGZrbjRCcDlxZ3A2eS9vdG5aNFdCMFk4UHJUVG5CV1p6WTUzOGUrRlRR?=
 =?utf-8?B?ZWlMeE9pS0hBK0gvSy9FL2hSTTRYS3ZENVdPSkR3S3RtNjlPc2twRW1UWnZs?=
 =?utf-8?B?N3NZWHgyYUdWMDNiTzloV2ZNM1hmQS94ZzRvdVI1UFlhRHlTZmNRT3IvV0pC?=
 =?utf-8?B?UTc2aGJWTE1Va1lxTjBmSS9pdTVKYkJvSVJGSmg0MDY0Z2dYYThOZVkyb1FJ?=
 =?utf-8?B?di9yWHlsK1dsWWU1RDBlWVRucVFUaDVOaTgyaEsveHZqRkt5S2phd1lQcWFM?=
 =?utf-8?B?UVJXcTVhb1hIODNSY3l5bFU5MmJ2RWlId0E2ang3UG9teTVTZGRRcVVFMUJ6?=
 =?utf-8?B?UTFFc0FnZVU0Y2owY3ZneTVGcVNwdnYzbmlkc2pRM1BWTVhZdnd3bnBhTnc2?=
 =?utf-8?B?K3JXMnJ3b29vYjFQcjdOcHhlRXNEd1BJUitmK3FRWC9IWFlPRDY2NExET1Bk?=
 =?utf-8?B?T3MvSnZ5RUd2Z3RUbWRLeFQ5NUV0dHpWUFRGSXd3eEt2QnNuSXR5N25Ma2sz?=
 =?utf-8?B?SHEzd3ZhNm15bGs4QmpoVXN3Vml1MzRPK0FvRjlubUJuNzYxM29sOWVDaU05?=
 =?utf-8?B?bUFYWWlXNkZ3TklNR1Y2MnhUWGJQTEZ6NmhGTm5lQStUZmF1dVlxelh3aHVs?=
 =?utf-8?B?M0hnbkVGS296a251UUpUL0o5Z1VrWnVQNW1BR1ZaRFBoU0R1ZXRlUEUzbzR3?=
 =?utf-8?Q?IU3zgvlrTn0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdsODcvNU1xRXFPdkZMNXIrVVdnSjQzM3llUUtLemNpU1VBeFQ1ZnN2YTlP?=
 =?utf-8?B?V0ZmMjJPNHIxOFVEZGYrL2xQWjU5ek9Nc3YvNDVTVllHVERSeUNyK205K0pL?=
 =?utf-8?B?b2FlV3ZJSXN4TXRNbFlsamtXS2UrUW5VaEJOV3I4WmxNeW5aSlQ4K05xZDNn?=
 =?utf-8?B?anpRZU8vMWJpSHFVZWY2RlhEbGhqMHFJQ3U0RkpmbnhvcXh6QktyMHJyalp2?=
 =?utf-8?B?Y1l0c1Y0T0RidXpZUTh3cDBIU2Job0lrcStLRUo2aHVKUHZkbk9PWlJiSXdE?=
 =?utf-8?B?ZlFoeFdaU2xFNVIyVXp0WjRreXJCWFFlcUhrU25GVy9veDdpZkRwTi9KU0ZN?=
 =?utf-8?B?RFVocXluelRJR0F6aHZVYmtLR0Y0ZVZTUU5ZcldSWmFBcStEN1FoOEphSTJz?=
 =?utf-8?B?SnhEN1Jra0U1MVBWREhVRkhCT3NEcWF2a21KMkMvQ0RBT2wzdWpJZ1lXMEZx?=
 =?utf-8?B?NDgxWU9EeTFRRFJXZGVVbmpRdVUwQ1JjZFV0MUh2WjBwUUVmclU1VUFRMWhW?=
 =?utf-8?B?UVE4eTZoNFVUck9pbXdmWUM0WG95VmZ1NVVoWmRpck4xMlpUY29udFNFMGhm?=
 =?utf-8?B?bko5dlF3ellMV0E3NlEyWUcyTFJ0b05rNlAvNk5IbWFuSzMyVmRuUStiVXcx?=
 =?utf-8?B?UmRyb3BmWFhWQWJiRHIwVDh0ZUx1ZEwwRVk5RXkxeHQ0TTJUbnlsbHR3aldC?=
 =?utf-8?B?Vmd1d2tveFY0ZGZsVkFCYnR2dUxtUEZvTzRKUU1lTVFEYU5ka2dCaklOazg1?=
 =?utf-8?B?ZERhMW9lbjl1OWI0cTQ3K25YUjB4TkgvUzh3TXhWaEtraU50TmVJVS9aaDZZ?=
 =?utf-8?B?MnY3b1lKMkJLVDNSNy9aOFJqbDNqYzkxajlTcTVmSlBmdWdEMTZ0anBZQlIx?=
 =?utf-8?B?eVJGU0JYTmRweFMwSzNsVWZqYXpmajB3eklLZHBLUTRqU0hxK3dKcUFVMGNq?=
 =?utf-8?B?dWtKdGV2aWtOdXZZY3JFa2tYT3NPOXJ3U0R1NkVBUHRyanEyZlZYN0hnQTFZ?=
 =?utf-8?B?YWcvMUREMEJ5OXo4TE9HM1pwM2xYRnhzL0F0MlJUUzlHVy8wMVJySWgwRkdo?=
 =?utf-8?B?aTMzWThrRlgxRnMrTGlld21RNFRDcTNoN0FSZGptckZpTU1SdVVOUmM3SS9K?=
 =?utf-8?B?OUJScnVUTDdNZmp5RkdRSXVUQ0JZazN5ZXBRWVhCK0xMYkNPOVBmbEV2UmZT?=
 =?utf-8?B?KzJkT3lCeGNWZld3YWVhOWNzT1kvcmhpQVBsWFAzU0pCMHRqc09vMHF4RHk1?=
 =?utf-8?B?anp4b1hhSFM2SVBNbUNhbnM4S0hPaEtjWXFFUm50WFh4NFpGeWVkdGZyZTgw?=
 =?utf-8?B?bWRnSjJ2NGZ5ZXFySExVcmszZEdMRTRWYTJ1bW5xVkk2WHBTeUZWWmt2RFR3?=
 =?utf-8?B?a0pFYmxLa3k3NGgyM2gvaWg3aFN1ZTZ2aGNkNWJhYU5YSmdVTUlNK3pMMEVP?=
 =?utf-8?B?eUtNOGw4Q1U4elNkWXNrcnZ4bjZFWjVWRHpTbnE0aVdhS0FKUW5WeEtsQjZQ?=
 =?utf-8?B?TW1wdERoN1dmMjNSNDdudUlDUTNtYTdTR296OXpMaS93ay82b0RGTDI3UjFC?=
 =?utf-8?B?ZXRwZm01aWtPei8rWHFWbUhKbzRjaVRuKytJVEZpZDc5UzNWbGFEanFyaCsr?=
 =?utf-8?B?b0xGWk1CSVRJUnY0ZDNiayswbXFLSkxvRHpCUlBFdHhLV1l5N28yT1duek4z?=
 =?utf-8?B?VXFOQUFkN2tSNFdPQWxDbzJvOCtxc3Z3YWVxa21yR3NWWlFRMWxrejVxNnR1?=
 =?utf-8?B?REZOWG8xaUtrNnh2SGJLa0JCQ3prVGQzcHJhaGFRcUcvdXR6ZjBkMDhzTGw1?=
 =?utf-8?B?U2xoakx6bjZWUXBpRnBWWU9EZVExdzBXbklOVVhoWDdJTXp6MUc1SzZjSEZC?=
 =?utf-8?B?aXVjZmlzNTVwS0ZTVytJbTJCcno4VDR5bW9sUXNLNkhweXU0b2o2T0QrTDhX?=
 =?utf-8?B?WWtVcTZXdlZEOE9Qd2lHd213Z2dKTC9EdE93TEUwQVRybFhqYmh0alp1NDNj?=
 =?utf-8?B?bmM2TW5rZFZNdE9HNzJYbi9MQW4yeUJ0SStGUVFhUUpUVnVjWWE3aklpRnht?=
 =?utf-8?B?cmhMbDk0L01lbDl4aGNCd29MaWxocjNEa2FtbzRQclh2VnRLTmpWbjdHQXU5?=
 =?utf-8?Q?fRG0nz6ycvzvVgOR6LQFUbBSO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc140268-6696-41bd-eb27-08dd8d7bb583
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:27:42.4589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6Lhk4+y5JDRC9UYwRjkFLTu/4D7uy01KRWtnILuv3OrYymdyZ8igtSfC3AAYnKc441dv0/ktlteIgodNyiZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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

On 2025-05-06 11:17, Alex Deucher wrote:
> Ping on this series?  This fixes a regression.
>
> Alex
>
> On Mon, May 5, 2025 at 9:05 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>> This reverts commit 18a878fd8aef0ec21648a3782f55a79790cd4073.
>>
>> Revert this temporarily to make it easier to fix a regression
>> in the HDP handling.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 ---------------------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 --
>>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 13 ++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 13 ++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 13 ++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 13 ++++++++++++-
>>  6 files changed, 48 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
>> index 7fd8f09c28e66..b6cf801939aa5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
>> @@ -22,7 +22,6 @@
>>   */
>>  #include "amdgpu.h"
>>  #include "amdgpu_ras.h"
>> -#include <uapi/linux/kfd_ioctl.h>
>>
>>  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
>>  {
>> @@ -47,23 +46,3 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
>>         /* hdp ras follows amdgpu_ras_block_late_init_default for late init */
>>         return 0;
>>  }
>> -
>> -void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
>> -                             struct amdgpu_ring *ring)
>> -{
>> -       if (!ring || !ring->funcs->emit_wreg) {
>> -               WREG32((adev->rmmio_remap.reg_offset +
>> -                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
>> -                              2,
>> -                      0);
>> -               RREG32((adev->rmmio_remap.reg_offset +
>> -                       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
>> -                      2);
>> -       } else {
>> -               amdgpu_ring_emit_wreg(ring,
>> -                                     (adev->rmmio_remap.reg_offset +
>> -                                      KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
>> -                                             2,
>> -                                     0);
>> -       }
>> -}
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
>> index 4cfd932b7e91e..7b8a6152dc8d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
>> @@ -44,6 +44,4 @@ struct amdgpu_hdp {
>>  };
>>
>>  int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
>> -void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
>> -                             struct amdgpu_ring *ring);
>>  #endif /* __AMDGPU_HDP_H__ */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
>> index e6c0d86d34865..f1dc13b3ab38e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
>> @@ -36,6 +36,17 @@
>>  #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
>>  #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
>>
>> +static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
>> +                               struct amdgpu_ring *ring)
>> +{
>> +       if (!ring || !ring->funcs->emit_wreg) {
>> +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
>> +       } else {
>> +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +       }
>> +}
>> +
>>  static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
>>                                     struct amdgpu_ring *ring)
>>  {
>> @@ -169,7 +180,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
>>  };
>>
>>  const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
>> -       .flush_hdp = amdgpu_hdp_generic_flush,
>> +       .flush_hdp = hdp_v4_0_flush_hdp,
>>         .invalidate_hdp = hdp_v4_0_invalidate_hdp,
>>         .update_clock_gating = hdp_v4_0_update_clock_gating,
>>         .get_clock_gating_state = hdp_v4_0_get_clockgating_state,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
>> index 8bc001dc9f631..43195c0797480 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
>> @@ -27,6 +27,17 @@
>>  #include "hdp/hdp_5_0_0_sh_mask.h"
>>  #include <uapi/linux/kfd_ioctl.h>
>>
>> +static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
>> +                               struct amdgpu_ring *ring)
>> +{
>> +       if (!ring || !ring->funcs->emit_wreg) {
>> +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
>> +       } else {
>> +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +       }
>> +}
>> +
>>  static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
>>                                     struct amdgpu_ring *ring)
>>  {
>> @@ -206,7 +217,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_device *adev)
>>  }
>>
>>  const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
>> -       .flush_hdp = amdgpu_hdp_generic_flush,
>> +       .flush_hdp = hdp_v5_0_flush_hdp,
>>         .invalidate_hdp = hdp_v5_0_invalidate_hdp,
>>         .update_clock_gating = hdp_v5_0_update_clock_gating,
>>         .get_clock_gating_state = hdp_v5_0_get_clockgating_state,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
>> index ec20daf4272c5..a88d25a06c29b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
>> @@ -30,6 +30,17 @@
>>  #define regHDP_CLK_CNTL_V6_1   0xd5
>>  #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
>>
>> +static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
>> +                               struct amdgpu_ring *ring)
>> +{
>> +       if (!ring || !ring->funcs->emit_wreg) {
>> +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
>> +       } else {
>> +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +       }
>> +}
>> +
>>  static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
>>                                          bool enable)
>>  {
>> @@ -138,7 +149,7 @@ static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
>>  }
>>
>>  const struct amdgpu_hdp_funcs hdp_v6_0_funcs = {
>> -       .flush_hdp = amdgpu_hdp_generic_flush,
>> +       .flush_hdp = hdp_v6_0_flush_hdp,
>>         .update_clock_gating = hdp_v6_0_update_clock_gating,
>>         .get_clock_gating_state = hdp_v6_0_get_clockgating_state,
>>  };
>> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
>> index ed1debc035073..49f7eb4fbd117 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
>> @@ -27,6 +27,17 @@
>>  #include "hdp/hdp_7_0_0_sh_mask.h"
>>  #include <uapi/linux/kfd_ioctl.h>
>>
>> +static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
>> +                               struct amdgpu_ring *ring)
>> +{
>> +       if (!ring || !ring->funcs->emit_wreg) {
>> +               WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
>> +       } else {
>> +               amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>> +       }
>> +}
>> +
>>  static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
>>                                          bool enable)
>>  {
>> @@ -126,7 +137,7 @@ static void hdp_v7_0_get_clockgating_state(struct amdgpu_device *adev,
>>  }
>>
>>  const struct amdgpu_hdp_funcs hdp_v7_0_funcs = {
>> -       .flush_hdp = amdgpu_hdp_generic_flush,
>> +       .flush_hdp = hdp_v7_0_flush_hdp,
>>         .update_clock_gating = hdp_v7_0_update_clock_gating,
>>         .get_clock_gating_state = hdp_v7_0_get_clockgating_state,
>>  };
>> --
>> 2.49.0
>>
