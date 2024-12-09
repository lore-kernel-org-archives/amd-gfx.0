Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D13E7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 21:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3A510E577;
	Mon,  9 Dec 2024 21:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nb2UVGTM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF66010E575
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 21:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLUXe0M6W0lGQNbDwx8k1erzw0pSokFMJJQqqZlDjlnA1GGTmwbooNnrfzrz4qPcMy+cx/0njVQqm6fZSecybz50PitM4CAgklhVylXuYkUEjntvnQKoa11JzV2TT5A5hQfPbD7XSy2MlagqhqX27TpObafpOz5BKNCy7DFVzEwcKBgbmWwoX9l956rGSaTA4KSuhltboXZTO/0msAopAIYb6iKCg0hAXkY8x/whyVBvruV1mZO+q1v7YV0ZUwzYEsMSDu+KI92sadwEHjqKRPDfCQUOq2+e1hGCfwBLhlfaIhCFytq/BTyjl6ht+qroAj9ln+xaA6CpLrq+LYviZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7U2Q/2f7tjnv2REUS8cCBqA+RPvsfY8KM+7CiLsQWk=;
 b=bXqa7w7Ye8Ssmwn/52dZRo+ItuWR6ZTrHMVKUvGelpIOFwgM8SwgWFK1ZigRbdnoSzdovQvzPGRw9XZIZvIqPyq11BjPSTQPg2yFxZfmdQyz8QaUv/8Z/L+89JtulpxwZEGNdxM0c5Uta9q9yXiconI0dumvNd5U5npdTC3ZiRu2Cyz+7d8K+sNfAcqAsRnQPeVpCoUb5RKH/YC61LcrOdu1wdlDlO7EnjaN8nyVW/Kn406t0fDl+xLDtndDcuxtU0iy15bDRJpUkmYGvpiqbgJlxrTptp8tBiU/69akghCjNHaJKQHMEXs3iAbEzbKemhTlEQ9axzhwk779jGNGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7U2Q/2f7tjnv2REUS8cCBqA+RPvsfY8KM+7CiLsQWk=;
 b=nb2UVGTMovCy9PJpqr0Xbd5F0BguIQ3eXTfcBhFd9GgPIJJcXi8Xcw9I/1oZ92J9QoBmwFTgsr7z3JdscB+qsKJyx1pJFpjujjN0kCeyPnNLgmkxgucRmqx+KeFfT2QoTUNTde5Nom1J61xxu9eAHF2+BOGSjaIwXh10xju/dX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 21:51:19 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 21:51:19 +0000
Message-ID: <39fc4143-9649-4c47-8359-95c831e8439b@amd.com>
Date: Mon, 9 Dec 2024 16:51:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/6] Add panic support for all DCE/DCN
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, yaolu@kylinos.cn, jfalempe@redhat.com
References: <20241112213716.49355-1-alexander.deucher@amd.com>
 <CADnq5_OLnCs6snWFiTwuHwHJL44WC8NjVxz7WSA1wu8CRiOLjA@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_OLnCs6snWFiTwuHwHJL44WC8NjVxz7WSA1wu8CRiOLjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 0935439d-f8fd-4b63-e338-08dd189b9d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTcvL0NLT2Q1M0E3VzI3YXpKRFE5ZHdIczIzc2Z5UjZ5UmhPQldXYnRPTmFj?=
 =?utf-8?B?Q2hUVWVDazN0UnJQT2ovRlBoeGJIVWk1VVNCbTdWeVBzck5saEVmVXhUeFdD?=
 =?utf-8?B?RGRFUXBhd095TGVhTG10WmZKZVl6alFEdnFVdmV3VWVOYXZ3ZzFGeDQwcmFQ?=
 =?utf-8?B?Yjg2cUw2MEtHbEZRUHZxamNaWTBVU2Q5YkFTbGVWL25Vc09FZ3FTd0FNSk5H?=
 =?utf-8?B?MEVsT2pJZUUvejlNYVh4U3Fqb29KcllxVThPYkR2TUt4RHhMd2E0bWwwdVNo?=
 =?utf-8?B?OHBlcmdUMWVpNWdYSkpHbXBHZDIya1AyVEhpaG1pUENEajJFYmtoYnZqcURE?=
 =?utf-8?B?QkhXM1VNQkJ4ODVBL2hGenlYSC9UN1I3R1NHUlp0Z0RIQ0VpNHpRcEd4bHpL?=
 =?utf-8?B?bzNrWk96MFBlTUExaU91MWdMUzUxTUJobXQzYytPdTRINkJBa0MwWldKTnRt?=
 =?utf-8?B?Z2h2OENuRXl2MEpDK2M2bjNkUHQ3MWs0aEhXNlZFbnRwVFpQQnpCOHF4SjV1?=
 =?utf-8?B?ZCtWZEJKMHZFbWtjaXdNZ2VtcENmYlhiSnoxMG1lYmQ3OFF0ZnZ0SFVPSEVj?=
 =?utf-8?B?aUo0Uys5N3NITGozNDZnZmJmT1hqcUlFUGorTkZlRDU4N2NQaWhUb3dtd1Z2?=
 =?utf-8?B?aWNITm1CZHpaR1V4aEc0VUExVW90VGNwSmNubzg0QW8zT0k1eXdqTWtjUC9r?=
 =?utf-8?B?QUMyelJWVGR2YnVyMC9Hc2k1ZXBHQzQzdU9kbm1GY3paYXJ5Q2NPbDZZY1da?=
 =?utf-8?B?RTA2OGVPOGZ6RXE1MWZmU3Rhak8yVTExaGZVWmlTRlFKelZjZk9LSFViOGNZ?=
 =?utf-8?B?QVRnQTFYcERCeHUvYjV2VEEvbXVQcy9sTTlQMEtNM0dGc0I2dzNOdGRXb1E3?=
 =?utf-8?B?dEtMLzRpOGE3M2R4cUZ4Z1RSVkE2T1JjcTRwRkNFdklOMEZUSm1RK3NVMU9J?=
 =?utf-8?B?RkVYdXBvS1V2eEE4WnNoSzVqZHY3QjRKRVZ5d3NTcEZWNlhyR3hkUUsxaFV4?=
 =?utf-8?B?N2NlOWRPNDhtY252cjVKRWp5S1YzUlhvdE15UmJZRmJJdGhnR2E0T2Q1QkxB?=
 =?utf-8?B?MXAybHNRRFlUdUhiM0tSM3YwY2hPWFRJMnhWS21heVFrSDU4TzlRYllETmNK?=
 =?utf-8?B?ZkJHQUt5dVRtZmFQdnM2YzNyeGhUNnhZNmlIMnJDeU9DR1lmYXJDbk9VTWJm?=
 =?utf-8?B?T1pXSW5tNTVXTCtjQ2hrYm9OSXVNSW9KR2ZLZGM2czVoaHRDWnFhYm9ocEVJ?=
 =?utf-8?B?bDh6akk0SDdKNjJFQ25GeDExSXgvKzhtcmZkQ1pHM2JYa1lnRnhhSys0bzRv?=
 =?utf-8?B?VEF5STNySWQzNkRCWkJheWltdEl6UWV6MVR4ajBwMTVrV0wyTFduWXFaSmZM?=
 =?utf-8?B?cENGMVhuR1d3S0tEV0d2YTVBRUxHaEhseUYraTBiOFVEbDVlZG4vdmVEY3kw?=
 =?utf-8?B?NFNla3F5TlVZQjR6QjVNeVlDRU4xYVMyYjFqQXZZTGhoMjN3ZG41aGJLUEVj?=
 =?utf-8?B?Vm9LcUVpVDlRaVlieGl1dXRmSEhsd0p2UEJqKy9DeWpDWlFjQnVHY2N3WXJZ?=
 =?utf-8?B?c25mYllXRUNEaFdBTlE0Q0lwZjlacWY3RndaNVdkUFdWZFp5Zjd6elBCZ2Vo?=
 =?utf-8?B?ZGFWMkY1QmFVZkNsbWFCNVJoLzZZL3pxMmlkS3JUVThvM0Yvd0NoQzBrTmVj?=
 =?utf-8?B?NUVkUmF1N0Q4WnkxZ2V1N0dXN1pEbjBwTm4yUVRBSTdSOFluUkxIZ2FhbHQz?=
 =?utf-8?B?NnFtcFpwT0QvNGJHWjRJM2FTa3NEWTBJcFNRZUFOc0dWY2ZCenl4QzJVL0N5?=
 =?utf-8?B?VmQyZk5GQU1zOFpqOGVEQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdEdGJKaEpIWkZ6RjR4eXM4NktiaC8wRTBHV1hhSWRvWVBZMmMvUW5OSzZE?=
 =?utf-8?B?SThyMDErakszb2lqaS9JUXFnczk1RWxLUE9ESXU4ditJSkc0d1NDOUNUMFFJ?=
 =?utf-8?B?dUVLeXR1QVhadndlNWhsK3dtMktkRzJtTEhIODE3WElmRU5Jb2xWaFBMQTc1?=
 =?utf-8?B?SFVvTEhOZmNCb3A3c3FlSklGRkFWc0QwUzhnMnc1VTQ3aG1URmdCQ1l4bUtX?=
 =?utf-8?B?K09WUm1YcDljbjk4V1ZmaUhPQ25IK1JXQVdnbWZFRDhldEd4T2g2eEtaV0Fy?=
 =?utf-8?B?SnN6Q29zNkl6UXk2OFBucFJMTmEvRTRHK3l1VStKcDBaQTgzSzBTZCtzV1dB?=
 =?utf-8?B?SnVWN2hRNWhwK2R4OS96K1ZSTExMZVhrczIwa2VyTXQ4QVdUVXVFb1pjd040?=
 =?utf-8?B?M2J0TjRKbXJ3UVBlbk93ZFZDNEhlTVhVVEpFa0NFY0lSWXhuUTk3VnpCTVMx?=
 =?utf-8?B?YU1LT3pQVFA2MzNndjRXaWdJQ0Z4WWtuQ1VxMWNmeEhGS2tnQkhVUXdlalF0?=
 =?utf-8?B?YUY3M3k1SmdubWs1Y0FicGZxRHNEbk1wSkp3UDVEUHFpc2tzMjBrSEdQaWdt?=
 =?utf-8?B?b3NDYkloS3F3VFlWbCsxVDhES1A2L08yNEdUSmozZ1duWHFEcWtyeDBJTHRT?=
 =?utf-8?B?Z1NnZFF2ZzkzTzZiMmtRazU1VmQzMzNadGNJWFA1c0VreXRleXQxbmtmNDVt?=
 =?utf-8?B?TEhBMXY3clVpWEM4UnRVeFhsamdFUENBK3k4bjhlZit6MVZqWUx5SFhEQzU5?=
 =?utf-8?B?bzNKaWJjZmcxL211K01paTZSdUVlY2tTbURaKzkvZnprcmdUQUREZ0VPT01w?=
 =?utf-8?B?R0xDSllvSVNHRWtyN3dZemFybndtNVdVdG5CZHhBT2Fnb3hsN1dKeG53N1Nk?=
 =?utf-8?B?RWF4U2Z1VGkxaDBKaE81TDNIK3UvRnladlBSeDMzeVdvdHpuK2ovYmU0Sk54?=
 =?utf-8?B?R2Z3cDVlNWJBbG1IcEdaRjJRc3FCNFJKNXBMeENmeG5aQWU4UUVHNnMxc1o3?=
 =?utf-8?B?WDBGZlRKZitDUlMzZFFGS0dmaGcvNjZIdnFSWklyVFp3TE9LVEtzeng1S1ZJ?=
 =?utf-8?B?WXlocFlaekpUbkxydHBBRHh5QjRlZUF6aXZkOGtCUjRxRU9Ld3BHeUk3OCs0?=
 =?utf-8?B?NjMyamlLNXZQUENHMDVnay9DSG8vL090dzFKd1p1SFBRWGE4RVQ2NkR1UVk4?=
 =?utf-8?B?RFJwS1Z2SXgyK0xTdGhydVZWbkpLT1hjd3R4dk5iRjYrenlJMlIzU20wazZY?=
 =?utf-8?B?OVpoejB3VGlOUDc2OTVYYXVkRFhMSjFCaStHSlVxdTM2OUhWNWUvamRHeEoy?=
 =?utf-8?B?M0ZiWnl0Qlg3U1kvbDNySERvZHZzcUJLZFZFd05JRG9MRWovZ045cm44aG10?=
 =?utf-8?B?eVdJVzByN2lDOWJXMzd4TFBQVGQzSWRiT2NCMjZ0Yi9aTzZWdzB4WnplT0lO?=
 =?utf-8?B?M0QrUWh6eStmaGlCVlgvZmZ6QURzSmFTYWw3bWVhQy9EdXlYMlRsR0hxdmZ6?=
 =?utf-8?B?aE5DdjZuc1ZnTE4rdU5WcFovVGlFTjVDSmJoK3U3Z0sxQVB2ZXBFTVNmZjI2?=
 =?utf-8?B?Q3RnajU0RytDYlAyM0hwNGtML1NORllneWxYMURSaTI1L2pYTnFDM3E2T1Y0?=
 =?utf-8?B?WkhCTWpzSDIvdnAxN3l5WGt0Y3Z3SXd5NmIwUU1zMkUrYlZMQi9MMGpHVG9O?=
 =?utf-8?B?RkxjVmFzVGthbUFTYWVUQUF1eFp2SG4vN21XL0lVdjdIbHhGa3NuVEErVzZi?=
 =?utf-8?B?a1BrUktnc3FZVW5nSkxNVkF5T1liU3dvcUNxTWd2TGNMNUVqaVlYNW9MNU52?=
 =?utf-8?B?dm9Pc2hoY3o2cmU2dXhzNDNMYmN4eXAwTitVbUZzYm1WS3Y2MHVla0k2Q3RZ?=
 =?utf-8?B?eUVNV3VpTU9hNVVYYzlCbEZvM0w4YXVnQWZpbitNTWl2SFRYVVlRU2tkTDdr?=
 =?utf-8?B?aUVhcWVFUDIvclkyM0ZCTDRnNk9aNURMaFpUYy81MHo0YXhXeGhqVktOUmwv?=
 =?utf-8?B?U0RTS094VUh1KzFldlJaNEFxNVhJZG80dUZZY0dBS0NRSkthQWN0dEpxR3Rt?=
 =?utf-8?B?bmZGV2I2enVSMjFrNmdYd2dqUngzOUJwaHJneitpL0R3cWFqcjdXK1ZQcVlE?=
 =?utf-8?Q?/U97UDihZ6q/asOl8fJghXzhN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0935439d-f8fd-4b63-e338-08dd189b9d52
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:51:19.6263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hhOKCCcVjWu4RHvs1s/009C1WdK2ZbUAzrRXoRmxYhKmK4Cgx2RKf0VehAdxZ7judfn4FuHQPfZ6288zwXyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

Looks good now.

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Haven't followed the whole panic support closely. Is there a
way to trigger a panic for testing, or is there any other
recommended way to test this?

Harry

On 2024-12-09 12:00, Alex Deucher wrote:
> + Harry
> 
> Ping on this series.
> 
> On Tue, Nov 12, 2024 at 4:37 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> This builds on the patches from Lu and Jocelyn to fill in
>> panic support for all DCE/DCN variants and code pathes.
>>
>> v2: refactor to provide cleaner history and share more
>> code to provide a more consistent experience across
>> DC and non-DC.
>>
>> v3: resend with the missing first patch
>>
>> v4: move hubp and mi code into a dc helper function
>>
>> Alex Deucher (5):
>>   drm/amdgpu: add generic display panic helper code
>>   drm/amd/display: add clear_tiling hubp callbacks
>>   drm/amd/display: add clear_tiling mi callbacks
>>   drm/amd/display/dc: add helper for panic updates
>>   drm/amd/display: add non-DC drm_panic support
>>
>> Jocelyn Falempe (1):
>>   drm/amd/display: add DC drm_panic support
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 80 +++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |  5 ++
>>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 27 +++++++
>>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 27 +++++++
>>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 27 +++++++
>>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 26 ++++++
>>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 ++++++-
>>  .../gpu/drm/amd/display/dc/core/dc_surface.c  | 46 +++++++++++
>>  drivers/gpu/drm/amd/display/dc/dc_plane.h     |  3 +
>>  .../drm/amd/display/dc/dce/dce_mem_input.c    | 34 ++++++--
>>  .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 15 ++++
>>  .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  2 +
>>  .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 15 ++++
>>  .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  2 +
>>  .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |  1 +
>>  .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |  1 +
>>  .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 17 ++++
>>  .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |  2 +
>>  .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |  1 +
>>  .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  3 +-
>>  .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  1 +
>>  .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 15 +++-
>>  .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  2 +
>>  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
>>  .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  2 +
>>  25 files changed, 377 insertions(+), 8 deletions(-)
>>
>> --
>> 2.47.0
>>

