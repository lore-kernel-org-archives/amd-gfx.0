Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C81C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 14:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2079510E880;
	Wed, 18 Jun 2025 14:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ujKkdlPr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67DB10E1A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 14:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1aiNQ0ipj4jnwHgLww73C0ksTnMSbsXyKJwPlBDRQyGGPbyPuuQUxI9Ml4tZb05y5+QowN9XP+meDgi+AdZsj4hEgmcL6x8sW18kKotXwkHPlDEyECYzkgyqRbVPOmwVqCRzc7cNnSC0QEcIte847Q6bq+aoli/4zvb2UrUToAFoQGdVZB1UNUuGaq1TOJXyqo9lxQUHVOppx8bEYi1ib/+9fb1WueUds2G+SNJ8s4/Se9YteKs+r2xtcgBWL6LHAxUGB+MfOrfQ7S2pzBg++bsiXBKDbU1BKH95tepUNbcg6JhINLt05eO9L/6XoXjdLvLNgGGcs/7gC064Zda0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA+c94T5dYlSqPFHPOXCqa6D8LIpj4BMH7gGspljhRM=;
 b=N97eBwqIIFQBuBWHTQXOHIIOEwD7eA+2bb8WgqV6v9kd5YUg4AkTiqcta8bjmOEd1Hpsg/4Dx1yilCrfSO+QvMaqbuvyn6yv/L8ccUoYDzkcXPyLRlnYzgf3AZ4lSEkzv5pw7EJt3+aEY3bRSNvwCYTB8FOmVWMH+bZL7kYL7EinZmb4bFPFwQQnGEsjLY7W6xexaKHLNzXVb9lZKV48o9MCS9Jqtn1CDX3Sp+tAT0VQkYX5iRhx7aRAAJU0icbcNY+LW+7HH2rpT3LzE/2LawEHNbmkii2iHVUU/kwLsa+Rs29dc74JpkXPNOZG6gKm2BYGO3cFW7zDGNMIXuHC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA+c94T5dYlSqPFHPOXCqa6D8LIpj4BMH7gGspljhRM=;
 b=ujKkdlPr60CgnOT9csclraDXRB3A3yMoUeNf2G7sqAK/bpE8dyPjM++I3xxaMLxm9Zz1CZsnvl14EjLeQQVrGjhxSY/JMo9SKL3YCjiOQRrKwG4C8btzccZJ7C89wGGKLizQnz7v4wzpBKx6cQPfYdiB6eGjh5LTbyfztLkuc5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 14:53:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 18 Jun 2025
 14:53:08 +0000
Message-ID: <5fefe7e0-656c-464f-9e94-3868fcb6b6f1@amd.com>
Date: Wed, 18 Jun 2025 16:53:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/36] drm/amdgpu: track ring state associated with a job
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-14-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250617030815.5785-14-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:208:32f::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca81def-32db-4fb7-9edc-08ddae77d685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDRtR2ZIWU5MN3FHL3EyY1pvNGVzeUJQa1NuenA2OGJIWWtkd1lIVkJ4ZCtP?=
 =?utf-8?B?dnJueVFQcjNveXFNUTJWNVJ0R0RvdU1xNE1TZGhkZ3dtRHdTeUpuL3MrMklD?=
 =?utf-8?B?Y2ZsZ2FnNHVUUURSbG5vakRwQm1YS0M2aE95OEpMdkcwcXptTnhON1M1eW4z?=
 =?utf-8?B?cEtTWW12RmF5WDlPd0NXVFVoV2RUL01XeWZ1enRBU0F0cVFtZ3pRd2dmeUZu?=
 =?utf-8?B?ZTlleFA3NnpmbHZjamdTa0Y5WGt2UGd4Y3IvM3hwdy9GSmtQLzFvbU5Bb1RJ?=
 =?utf-8?B?UGVLaWtEVUVkejZjUTVvWUdReVRnOVd4T3IyKzhRaHlSQ3AyQTRRbU0rMU9I?=
 =?utf-8?B?eTYycitlSjY1VzlpRW9OQkVMZ0JacUMvZWNWdzA5ait1a3FWSGNLdjhNWm93?=
 =?utf-8?B?bFhFZ29temJvaXpIZVdhWkdORkNzYytFRjR3RC9pZlh5L2hJMTR6MEQ4OVpU?=
 =?utf-8?B?RUpRMGdmSmE1a3RRblpqNFBnNUw4cVA5UlRYdGE5aG5sa2lxWmczRUJteDZu?=
 =?utf-8?B?S2lXSFFNTXc2R3h4Y0VjMGgxcHF6NFo5UHN5MHphT2hFZEJ3YkxnVCtxa0VX?=
 =?utf-8?B?V3hmVDhkS3I1bHVjVDlHNDRYdGhLV29Td0JzOHA3R29TcTdOVDMzS0ZrektV?=
 =?utf-8?B?RmdSSXpLVE5jckZ2SWdsV0hSOFErSlUydVB1Y2hHa1BGOUJEbjh0NE4xK3Mv?=
 =?utf-8?B?ZS9tRCtVdGlZbHZLcnVtQjJSR3J0NlZwcnBNZmJ0cThwYTZzRjNnbUFHWndG?=
 =?utf-8?B?MmI1RlprZWVZaEpNK0dOTGZJZ1Y3eHVCcFRXSzFPZnJjT2RqTVlreHVFK2oz?=
 =?utf-8?B?bWVDUU5ndE02bElRV1NpbGlsR1A4RFd6STBTSTJjTHd0Uk12U0NMYkZHcVdx?=
 =?utf-8?B?d0ZvN0hWY3JoMVFkZURBenN6WFY2dW9scEUvaU83enZFM1hSM2JJMEw0REpl?=
 =?utf-8?B?ZnFBcWpDT1p0ZlZQZkM3c2d3SCt0RjQ1YW5EZDkxa2ltN05CNVJpeE43cFh3?=
 =?utf-8?B?ZU9pc2FwQk9XNTY5eW9uSkF1MXVxZlhTbWEzM2NwaHlPOEtrN0RWYWZvdFlG?=
 =?utf-8?B?dXh6dmtiVE4wUFZ0RmVJaGdpVEJuWkRoZlMvU0FVbzdNQ2hKNFVmbnpSa3A3?=
 =?utf-8?B?dkJTY0REL0ZXSllTZnBZRHAyS2JpS2p6eHBFRXQ2dzZBTVpCdXNLQU5mQXo0?=
 =?utf-8?B?SGRFbnk4K09RWHE1QkNpR2pzLzluTFcvRE12cUZXSFRrUE15bGpab3F2cCtI?=
 =?utf-8?B?QU5tc3JucHdKNCs2aUt5eEd1RDhjRXBpd3B4ZEFHYnlBNzdUenkvTzkwbmxh?=
 =?utf-8?B?YXZ0eFVkTEJBbFJWQzRYTkxPQy9iZThjRmtjK3ptVTl0dDFITXhYTDEweHJr?=
 =?utf-8?B?QmsxS2lJdFF3U1k5bnJIOEYrYU9nSjdQQjg5N2d6WHZKU0xoekRtbGZNY001?=
 =?utf-8?B?WVhLQkRBRWJ2dWFRcGhFcXdtUDUrYTJtb1dYSDNFbFVhbWpPd0lpVmMrMkRo?=
 =?utf-8?B?MTZyVlo0NW5xelVSSE0wWG0rRi80emw3SDZvMitmdksxM1Yxa2tPNSsvSHc5?=
 =?utf-8?B?M0V6RU8zMys3WXJZVUEyM1g0L0RtSzVLREFQYVpHcm4zWElsTmtkRDA4ajhZ?=
 =?utf-8?B?RW03cGJkM0hxdFVBZVloM0tzN1RGYWN4T0I0Q21HY1l2b3lvWXFXSVVBTk5N?=
 =?utf-8?B?UUl3bUF4Y0NTV2diYkJkVU1PTmU1djNUSEJEV1BqU1E1OVVZeWJKZ2pralRU?=
 =?utf-8?B?ZkVKWHdTaVJvckNNeEd4ZWpPYldSQThmOTJZdzZlMzJNdWJERmViUTd6QnBB?=
 =?utf-8?B?MWhQYzVwV0xhUGpROVlUNUFxdFdMdDZoNGwyM1ZuaWZrcW1UR3pucCtSVDgz?=
 =?utf-8?B?NStJMnhvRVplUmg3ZXNxakZOUVNoY2xpRnl6bXo5K0t3dUxSYkZ2MGVYbm9N?=
 =?utf-8?Q?atBrcsLRt1c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJPK1gvbExjbzdtVnRyaTV1a1ZkYW1TSDdrY2pqUmxJeVpyTnZ1SXNTVUtI?=
 =?utf-8?B?NTVGVnpVVzJ3WFdpMlZNWXVaYWl0bFkxZDMwMWcweERmMDM2RUQvaVVETWhs?=
 =?utf-8?B?c05PcHNwbzFDUjBIbnV6THU0RHU0dTVobnQ3d2JRYis2MWxodHlSZU5RZlBu?=
 =?utf-8?B?Y3VuU1kyRnQwbFRCcEhOOTVwTlpaOFJiYnJBb21vVGdDMzhiUjc0TG1aYU5n?=
 =?utf-8?B?MFZ1WUEvQ2R4SzNGNUFpRitJMDcza0ZjYThhcVlzWk5Ja3Q5UDVnRi9nTnE3?=
 =?utf-8?B?dTFwUVJxZy9mTlQvZ1R1VWRsODVsckxzQVlqa1pCTGJLY2xhZkFIZk5LSTE5?=
 =?utf-8?B?alZ5OXhIekYzNlY2M2lQUmwvNjhiYXNlKysvSXNvS0x2NlJ4VFdKeGE5MUFC?=
 =?utf-8?B?UWUvcWpXVVd1bThuUHVCR1VRVWtPb3AvQWwrK1RoRUdoOTVTODBEVTJ4NTlD?=
 =?utf-8?B?QzNVeE1kZXhiWWZJMktIMHlITUtvNW0wYzBzK1ZnNS9TWlVuNFJkN29sbzQx?=
 =?utf-8?B?NDF5UEJPY3JNRXZ1eDJyR2RFZFp2RXBoRmdYMzltQXI0Mjc2cmsvTk8yWGI2?=
 =?utf-8?B?bjJEcjZud3cxWnUwdU5CYVFPWUpYUmFLMGVlTnpqT1RRTW5pQzFXVFRYYjFo?=
 =?utf-8?B?NjVIK01ySWNOUTkzM0cyd1g1eGdtdGxsKy9EMEZBUmpZY0t0S280QThxOW5F?=
 =?utf-8?B?RlJZN2tLSCtaUG0yazJ6aUoxYjB1d3EycllEeTE1SitaS25kdG5RT0Y3N3Jt?=
 =?utf-8?B?UFFSTjRmV3k0RnNBNHlndlk2K2VrWXhXTzBkcUZBZHcyNUV3REYwOW41Ymxa?=
 =?utf-8?B?cU8yclVTTmlKL2NlSGYwaWpSUnhYbXc2blJFVkNIKzc3UlppelBiYW5TRFhB?=
 =?utf-8?B?VVY3NlhRejE5L3diTlM0ZnpGSWE4NzlHdmJjZWFRTVJITnNGZGRjYTlxS25l?=
 =?utf-8?B?RmFxNXRpVkVIOWFDcCtETFNtQURlOHBTK3NQekpacFUyR2tsb3kvSnBJQkwy?=
 =?utf-8?B?ZzdacklwR01ZNzJxcVBQUDE2aWtseCt2QTM1NUpBeFZTSDRoZWthY2Q1enAy?=
 =?utf-8?B?bmI1KzFkb2s2TnA0L1I3Rncyd0p2ejZiSTVjQ1NVSXhpQklaQndOWWx5alhZ?=
 =?utf-8?B?YWRGYWJBcE5odlFuSVdTQkgxRnRpczNWWXJudkpGZDdBVVY0RnhrOG5PTXF1?=
 =?utf-8?B?NHFxY0JaSmtLeHh1aWJNUWsxS2IwRnhVS3NudFBsa2Y5NHJ3QnlxaEV4R0N1?=
 =?utf-8?B?SDBhTW53TXp0RjY2ZlZCK25FVjdpQmhxMnZnR2dTcXdRczg5c2JQWHkyV1Nk?=
 =?utf-8?B?bmRjcXhVbDhFdUJBdngyMWN0Vk1GbGNxRHEvdkdjY095OCtINjd4VjF4SXl3?=
 =?utf-8?B?OUgvbDlnOHl0dUlyMzZxaW8rSVJ1YjViK2ZTVktWaHZ5NkdVbkFTL0RhZERw?=
 =?utf-8?B?SHBtem9oVklZOCtWWmxLbTZOVWFRRDc4RTJseHJqRDVIeU1sN2d3YkNFUDNO?=
 =?utf-8?B?OHhESXN0YStoVUFIc2VqczJnOXJZT1VNeWc1amp1R3JORWR1SXlUV0dRaTVp?=
 =?utf-8?B?VVR6OTNBTlFsSld4K09mY0FqVnBaTkIvNkFML1pWajlDNjAvZnRYb3BjMnlr?=
 =?utf-8?B?WkZ1aFlIQmpmZU1SLzN3Q09jdXNiaGhYZ096Qmk1Q2JDRU9SZDNISnRSeERv?=
 =?utf-8?B?WEZyNlN4Si9TdVdWQy9mU1hZaEpTMEVQcEFDVXluVmZIZ2pBYm11UE9SUkRF?=
 =?utf-8?B?Qmx6RmhGZVdZT05Nd2dGdUdndWhWYmhRN0NJVEwvdHIrMVh2TTU2eksySDgv?=
 =?utf-8?B?WVIzTU9qb0MycG8vYXROdmh4YWZ6NFZtUHNTUUxGbmlJRnNZdEVBYnVFcGpZ?=
 =?utf-8?B?dEFqdkorY29mQk8wZ2NjTVk2bmd2ME15VXZ0Y1dVekZ6TjQybXJrN2xhY0RP?=
 =?utf-8?B?b29oK2ZUNUlIN1lsSWNNUWVBVUhHK2l6QnZITGl5TVRoYjBwQzZlMUxsNm43?=
 =?utf-8?B?SkdPcDI3eEpidHVFcU0vRDFuUVZsa0twWGRjTUw4ME5UUDc5bWZ5Y3lzRHhz?=
 =?utf-8?B?bVE5OEFSSG11ZVAxR0NXRU9peDFYTSs1dFczNi80dThWdjVXZUlibG1kN1h3?=
 =?utf-8?Q?7i/B1O1w8DQATykDpiI6WkF1P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca81def-32db-4fb7-9edc-08ddae77d685
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:53:08.1945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl6JbdjP4PfzblzXmQeYizaAkQWKKyQc2VPqAlS2/Bkc/obHRWodIhHzpO4S1cnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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

On 6/17/25 05:07, Alex Deucher wrote:
> We need to know the wptr and sequence number associated
> with a job so that we can re-emit the unprocessed state

I suggest to replace job with fence here and in the subject line.

> after a ring reset.  Pre-allocate storage space for
> the ring buffer contents and add helpers to save off
> and re-emit the unprocessed state so that it can be
> re-emitted after the queue is reset.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 90 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 14 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 59 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 17 +++++
>  5 files changed, 181 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 5555f3ae08c60..b8d51ee60adcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -120,11 +120,13 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>  		am_fence = kmalloc(sizeof(*am_fence), GFP_KERNEL);
>  		if (!am_fence)
>  			return -ENOMEM;
> +		am_fence->context = 0;
>  	} else {
>  		am_fence = af;
>  	}
>  	fence = &am_fence->base;
>  	am_fence->ring = ring;
> +	am_fence->wptr = 0;
>  
>  	seq = ++ring->fence_drv.sync_seq;
>  	if (af) {
> @@ -253,6 +255,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  
>  	do {
>  		struct dma_fence *fence, **ptr;
> +		struct amdgpu_fence *am_fence;
>  
>  		++last_seq;
>  		last_seq &= drv->num_fences_mask;
> @@ -265,6 +268,9 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  		if (!fence)
>  			continue;
>  
> +		am_fence = container_of(fence, struct amdgpu_fence, base);
> +		if (am_fence->wptr)
> +			drv->last_wptr = am_fence->wptr;
>  		dma_fence_signal(fence);
>  		dma_fence_put(fence);
>  		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -725,6 +731,90 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>  	amdgpu_fence_process(ring);
>  }
>  
> +/**
> + * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
> + *
> + * @fence: fence of the ring to signal
> + *
> + */
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
> +{
> +	dma_fence_set_error(&fence->base, -ETIME);
> +	amdgpu_fence_write(fence->ring, fence->base.seqno);
> +	amdgpu_fence_process(fence->ring);
> +}
> +
> +void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +{
> +	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
> +
> +	am_fence->wptr = am_fence->ring->wptr;
> +}
> +
> +static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
> +						   unsigned int idx,
> +						   u64 start_wptr, u32 end_wptr)
> +{
> +	unsigned int first_idx = start_wptr & ring->buf_mask;
> +	unsigned int last_idx = end_wptr & ring->buf_mask;
> +	unsigned int i, j, entries_to_copy;
> +
> +	if (last_idx < first_idx) {
> +		entries_to_copy = ring->buf_mask + 1 - first_idx;
> +		for (i = 0; i < entries_to_copy; i++)
> +			ring->ring_backup[idx + i] = ring->ring[first_idx + i];
> +		ring->ring_backup_entries_to_copy += entries_to_copy;
> +		entries_to_copy = last_idx;
> +		for (j = 0; j < entries_to_copy; j++)
> +			ring->ring_backup[idx + i + j] = ring->ring[j];
> +		ring->ring_backup_entries_to_copy += entries_to_copy;
> +	} else {
> +		entries_to_copy = last_idx - first_idx;
> +		for (i = 0; i < entries_to_copy; i++)
> +			ring->ring_backup[idx + i] = ring->ring[first_idx + i];
> +		ring->ring_backup_entries_to_copy += entries_to_copy;
> +	}

That took me a moment to understand. Why not simplyfy it to something like this:

unsigned int i, count;

for (i = first_idx, count = 0; i != last_idx; ++i, i &= ring->buf_mask, ++count)
	ring->ring_backup_entries[idx++] = ring->ring[i];

ring->ring_backup_entries_to_copy += count;

I need to take a closer look at all the details, and we should probably throw in some documentation here and there.

Regards,
Christian.
	

> +}
> +
> +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> +					     struct amdgpu_fence *guilty_fence)
> +{
> +	struct amdgpu_fence *fence;
> +	struct dma_fence *unprocessed, **ptr;
> +	u64 wptr, i, seqno;
> +
> +	if (guilty_fence) {
> +		seqno = guilty_fence->base.seqno;
> +		wptr = guilty_fence->wptr;
> +	} else {
> +		seqno = amdgpu_fence_read(ring);
> +		wptr = ring->fence_drv.last_wptr;
> +	}
> +	ring->ring_backup_entries_to_copy = 0;
> +	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
> +		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
> +		rcu_read_lock();
> +		unprocessed = rcu_dereference(*ptr);
> +
> +		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
> +			fence = container_of(unprocessed, struct amdgpu_fence, base);
> +
> +			/* save everything if the ring is not guilty, otherwise
> +			 * just save the content from other contexts.
> +			 */
> +			if (fence->wptr &&
> +			    (!guilty_fence || (fence->context != guilty_fence->context))) {
> +				amdgpu_ring_backup_unprocessed_command(ring,
> +								       ring->ring_backup_entries_to_copy,
> +								       wptr,
> +								       fence->wptr);
> +				wptr = fence->wptr;
> +			}
> +		}
> +		rcu_read_unlock();
> +	}
> +}
> +
>  /*
>   * Common fence implementation
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 206b70acb29a0..4e6a598043df8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -139,7 +139,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	int vmid = AMDGPU_JOB_GET_VMID(job);
>  	bool need_pipe_sync = false;
>  	unsigned int cond_exec;
> -
>  	unsigned int i;
>  	int r = 0;
>  
> @@ -156,6 +155,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		gds_va = job->gds_va;
>  		init_shadow = job->init_shadow;
>  		af = &job->hw_fence;
> +		if (job->base.s_fence) {
> +			struct dma_fence *finished = &job->base.s_fence->finished;
> +			af->context = finished->context;
> +		} else {
> +			af->context = 0;
> +		}
>  	} else {
>  		vm = NULL;
>  		fence_ctx = 0;
> @@ -309,6 +314,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  
>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
> +
> +	/* This must be last for resets to work properly
> +	 * as we need to save the wptr associated with this
> +	 * fence.
> +	 */
> +	amdgpu_fence_save_wptr(*f);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index f0b7080dccb8d..45febdc2f3493 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -89,8 +89,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  {
>  	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>  	struct amdgpu_job *job = to_amdgpu_job(s_job);
> -	struct amdgpu_task_info *ti;
>  	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_task_info *ti;
>  	int idx, r;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> @@ -135,7 +135,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
> -		r = amdgpu_ring_reset(ring, job->vmid, NULL);
> +		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
>  		if (!r) {
>  			atomic_inc(&ring->adev->gpu_reset_counter);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 426834806fbf2..0985eba010e17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	/*  Initialize cached_rptr to 0 */
>  	ring->cached_rptr = 0;
>  
> +	if (!ring->ring_backup) {
> +		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
> +		if (!ring->ring_backup)
> +			return -ENOMEM;
> +	}
> +
>  	/* Allocate ring buffer */
>  	if (ring->ring_obj == NULL) {
>  		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
> @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  					    (void **)&ring->ring);
>  		if (r) {
>  			dev_err(adev->dev, "(%d) ring create failed\n", r);
> +			kvfree(ring->ring_backup);
>  			return r;
>  		}
>  		amdgpu_ring_clear_ring(ring);
> @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  	amdgpu_bo_free_kernel(&ring->ring_obj,
>  			      &ring->gpu_addr,
>  			      (void **)&ring->ring);
> +	kvfree(ring->ring_backup);
> +	ring->ring_backup = NULL;
>  
>  	dma_fence_put(ring->vmid_wait);
>  	ring->vmid_wait = NULL;
> @@ -753,3 +762,53 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>  
>  	return true;
>  }
> +
> +static int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring *ring)
> +{
> +	unsigned int i;
> +	int r;
> +
> +	/* re-emit the unprocessed ring contents */
> +	if (ring->ring_backup_entries_to_copy) {
> +		r = amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
> +		if (r)
> +			return r;
> +		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
> +			amdgpu_ring_write(ring, ring->ring_backup[i]);
> +		amdgpu_ring_commit(ring);
> +	}
> +
> +	return 0;
> +}
> +
> +void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> +				    struct amdgpu_fence *guilty_fence)
> +{
> +	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
> +	drm_sched_wqueue_stop(&ring->sched);
> +	/* back up the non-guilty commands */
> +	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
> +}
> +
> +int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> +				 struct amdgpu_fence *guilty_fence)
> +{
> +	int r;
> +
> +	/* verify that the ring is functional */
> +	r = amdgpu_ring_test_ring(ring);
> +	if (r)
> +		return r;
> +
> +	/* signal the fence of the bad job */
> +	if (guilty_fence)
> +		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
> +	/* Re-emit the non-guilty commands */
> +	r = amdgpu_ring_reemit_unprocessed_commands(ring);
> +	if (r)
> +		/* if we fail to reemit, force complete all fences */
> +		amdgpu_fence_driver_force_completion(ring);
> +	/* Start the scheduler again */
> +	drm_sched_wqueue_start(&ring->sched);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 6aaa9d0c1f25c..dcf20adda2f36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
>  	/* sync_seq is protected by ring emission lock */
>  	uint32_t			sync_seq;
>  	atomic_t			last_seq;
> +	u64				last_wptr;
>  	bool				initialized;
>  	struct amdgpu_irq_src		*irq_src;
>  	unsigned			irq_type;
> @@ -141,6 +142,11 @@ struct amdgpu_fence {
>  	/* RB, DMA, etc. */
>  	struct amdgpu_ring		*ring;
>  	ktime_t				start_timestamp;
> +
> +	/* wptr for the fence for resets */
> +	u64				wptr;
> +	/* fence context for resets */
> +	u64				context;
>  };
>  
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> @@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
> +void amdgpu_fence_save_wptr(struct dma_fence *fence);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -284,6 +292,9 @@ struct amdgpu_ring {
>  
>  	struct amdgpu_bo	*ring_obj;
>  	uint32_t		*ring;
> +	/* backups for resets */
> +	uint32_t		*ring_backup;
> +	unsigned int		ring_backup_entries_to_copy;
>  	unsigned		rptr_offs;
>  	u64			rptr_gpu_addr;
>  	volatile u32		*rptr_cpu_addr;
> @@ -550,4 +561,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
> +void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> +					     struct amdgpu_fence *guilty_fence);
> +void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
> +				    struct amdgpu_fence *guilty_fence);
> +int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
> +				 struct amdgpu_fence *guilty_fence);
>  #endif

