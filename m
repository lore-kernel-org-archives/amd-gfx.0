Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E28CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 18:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0C110E05C;
	Wed, 13 Aug 2025 18:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k5YyT3y4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEEC110E05C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 18:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpY41BqEe20qpTVrVOM9RhYkPkCc687MugpvVgyifuGOQRTZiO7U2grfzdbDlq5mo6PSsOSX7ifnx6bQ/2r51L+OvMYvtXafLtEve0OOKC2Iz3sDphpmklOKyElmawPXTC18v7qNyp2GZW5tTW9ZeDe2YiDPnX8e9Y2IS6VyTzYKJqi6AmFAYHM9Hkcq/MuxOm/A3FvKE7wVspxE/0nb8bmOrG7b8+IuzDuUwgjDfh3TzXEPtsYGqjudqsJYM865ptUB1WHHzgSjA6j3SVcs5DRLHd3fVtLAXt9VsW7LFj7ZB9VTppyS3sIT1Ppwp22RGtM9+od387FWiAXBVyZxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w11WRt9EPrloTTXlXl4Wl+py0WavezdsNcuLpWByiUY=;
 b=T6W7WIqC3MH0uiLj2X6Rh4qvzX3M2EuD19uFLp9rBgfJ1FpH5wx4HhRTBPQ82zr/2dRooIOgjfZKvzjvOYtrMePW2UrMtR/qOL0IiGTW7M13eq/FBFg34FyOJz3k/K58F3E+VlvHMewAXf5+xmY4g8qx5b/8Gvgavc2oTNupCZ01DmIaTaC+akzZH/xWztwCMGk/ftjRwb+nf66+vW59HlzSEoFhtcYz3UK/Ay4oXgroMWgxnNufRPsS2AoPoGU92+HRSbbuiXiN+qVRXCC93PV/0KobHTkljWltjyZEf7hyycBF8plEpzVz20YuLPSm86ZNFbUZy78wkhw4XRVyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w11WRt9EPrloTTXlXl4Wl+py0WavezdsNcuLpWByiUY=;
 b=k5YyT3y4NQVZOB0iz/kVxlqFM65g+lQQxHK24bImHmDNaLqss2TM6l7fo/P6a1h0rifxeXwoc+pAJCK2ClafmEJxOKUYn2Q6tzi5J1oKcMd71rhC6C3IBlRZFlKm0mL+q6tfmLcanFL3kZ8S6/INJqd+UHZEviysovO6p6n+5Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 18:16:44 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 18:16:44 +0000
Message-ID: <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
Date: Wed, 13 Aug 2025 14:16:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::39)
 To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1d0072-94f8-425c-83a5-08ddda958f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXV5bVZpTFdxTmdCZ3hYZW1UMnFsQVkyVHoyRXpCeDRIR245UWZPTFlDNUgz?=
 =?utf-8?B?Vzc5Sk56bzVVRndWVWxZWERad1hyZjdHL1NHTmwyR2hqamlaSEhOT20ydXJK?=
 =?utf-8?B?WVRNeWFUczRNNkVQY04yTjh0eG9TYjhmQTdUVXA2RlhhdTROWHVhSW8wS2pH?=
 =?utf-8?B?MVJyQ0NQUEM1NWhOenJOVTcxYkt3elNsWmV0MWU2OHdNSWRTalZtMWNFVlVR?=
 =?utf-8?B?UVh0V29MQXUwVkxZMlRQdVdkQkgzcEJ0aGZkYWlRaXFoNmxDVW9JM0NOOWI2?=
 =?utf-8?B?VTNUYlU3NzBBTkZYNnJEN3ZrSC9JOWwwU0NFalFvdVBhVUtUdGJXSTJEZ2JV?=
 =?utf-8?B?dzJQbjFLazlpdWxNRjFzNDJjaGlrVENxSG9ueTR5enJuY0MwZmcrcjdaemNx?=
 =?utf-8?B?bVNUWjNCeVc0bElkekdCL01PV3lXSEp2WmVxUDl5NTBzZittekxxMi9zRTNn?=
 =?utf-8?B?OEdzRVhvTVI2SVdOalRBYzNZMlN1dlV6aHVWWnFqMHlXbExiQkpZVjJjMjIv?=
 =?utf-8?B?S2pLbFJXSHNWNCthd1UyUHljRU5iMEhXZk1DUjRoSmJUdGRtYjY3YjNZTlBy?=
 =?utf-8?B?czlFVXQ2V1N6M2Zhc0FKZUN0Z0ZvT0diTWN3d29sNHhvdkFHa1BuMlE3NW1p?=
 =?utf-8?B?Njc3MnM5Y3M0am4xdW5YVGJEcUE5Z0Exb0tnL1M1Q0xham41ZURaUGJIRFh0?=
 =?utf-8?B?MmhTdmNnTGM0ZUlsT3hvSWV2TjM3Nm9KOVN5UEg2T3hqelBweVg0V1RzN1da?=
 =?utf-8?B?YVM3L2laTTl3MXN3SmtrdEFvOVJvSXIrMzJLYndMVHJsb0JTSEF6RU42ZTVa?=
 =?utf-8?B?N3ZFYW11SThZQUdBdjMyeGJ1TUY3amF2eWhrdGx1ejcyeENjTS9aY3BJUmRh?=
 =?utf-8?B?YnNzRXZwRXVLQW9VOUtwNVAxbDFWQ1o5S29adHZpMU8vK2lGWmVNVnFoSTNN?=
 =?utf-8?B?ZkUyeXNOUmxpVzJrTWpJd1J0czk0bXJVbTM3cFRWUFZvNE9hSUgxNmpsL1NS?=
 =?utf-8?B?OFdoZlMrbC8vNjdkeWlNR0YrL2xBcFBKVlFMUmhXd05rSzlaamozZnRjckti?=
 =?utf-8?B?b0pZTE9ZS3piOFZxZXVtd2NsWGE1WGRNTFg1UXRSQ25IOVFhb3dueTZ3Qkkx?=
 =?utf-8?B?RGFtQ015aVlQVVptOFBaeGhBRW5JSDZBelJuMVR0YVFBam9yY284VkVaSEMv?=
 =?utf-8?B?VElCRklYdVFKa1ZqR2cyTjhzRkZSOTR4TW00alcrSU8raURyQzNxTVZIUldG?=
 =?utf-8?B?N3F6SmZZTy94a1pJaHd1eW1xWjIzWm1wU1R6VjVGeW9JOEtCWW42QzVQTDZV?=
 =?utf-8?B?RGxxejBaWE56cktiMHQ2dWZoZjArZHF1eTV5ZnRTU1dTMzlyNWViMnNiZUdk?=
 =?utf-8?B?VTFtY2tSSkF4V0tVS1R2eTlOWlBDU2FBM1lBOXB0elV4aWhUOGt1a0p2SWZi?=
 =?utf-8?B?VmlXTEozVnFSd3ZXUnE4Qy9QV293VkR6dEU0L3p5Y1A3cExMZDlHaVFPWGRL?=
 =?utf-8?B?KzFXOExXOGZBR3VPSXZyUHB0ckNPdmQrS3RZNFFDNE5Cak94THN5cXhNZjRy?=
 =?utf-8?B?Z2UvbmpDLytuZUdNUlZPaVNOeGtaREVybGRiQlU5M3p2OUYrZFRYRGNiMFUz?=
 =?utf-8?B?NDFSa1dMTkpsL0I1WnJudUdVcVQvRTB6RkFYUmpFT20xRDMyLzJtTTJzT04y?=
 =?utf-8?B?aXRrVW9mRGNhSTB3ZnNBcXJmRk43YWQrcHJFajBRNjdkVC9TRVQyRlpjRTFa?=
 =?utf-8?B?Snp0eEl3d1ZsMEdnM2ViUm01bUNSa3c5OUtySHNLOHI5YXFmWUlkRTJQYjVG?=
 =?utf-8?B?KzdCSzc2NmQvT3NlTEx3V21HcGtmd0VmcFgxenMxc2hObUN5am9lYkU1RkFJ?=
 =?utf-8?B?RjFQYWJDTFp1Q1JBYzY2T09aNFZ5ZU8vb1ptTWN2WGU4TVh2MFdSZUVIb1d6?=
 =?utf-8?Q?3JCQDqF+tSQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU5jVDlpOGFDSUpkcTJ2dEF0SlRLMmNCNGNuUy9EZ1BodE4xQ1lOQzBlQ2NK?=
 =?utf-8?B?Nlh0eXQzMVlCaENTOGdWZ0c0Uzg5TWh0Yi9HcG9pRGdnVXdFSDlScU9XbDA4?=
 =?utf-8?B?RWpjM0dmZWtRVkZnVnZHODhvQjBSTGxOcVpoN0czekVKWHZQZGRCdUpFeTYx?=
 =?utf-8?B?aFhtRmtzYW1YbjFaS1F0WnhPa2FET1RXUisyWXVXRWRCTGQrM1JJM3d6dWRB?=
 =?utf-8?B?QkNOMzhwQVN5bEJycFJwRjYrbFEya3BtWXJ3TlpjTnhaR2pBMnJNTnBwUUNG?=
 =?utf-8?B?VG5uUFk4WktMczlseUFKV3NQUzlSKzhHQzVLcjd5L01JQnRYaG8zeXhCdU95?=
 =?utf-8?B?SWxxMlFqQ0x6N0tsMG05RnVTSWlmd1NVZTJFcWRiMWtIc0RDUFE0eHcwdk9q?=
 =?utf-8?B?ek0rZHRSZGNjYnhYbXN2aXBHSjdWaHNsQXViTG5hd2d5bkI0bjY0ZnUyT01S?=
 =?utf-8?B?d3NZeXhFdkV4VHhjRUdJQ3lxVTNJVmtlMW1sNjZldTFQSFB3WHdkN1NMVEY3?=
 =?utf-8?B?L3h0QVhGdHhpazhzNEhYcFY4SlJOdlc1RFRGTmJvWGl2WnJoV01RbVY4NUw0?=
 =?utf-8?B?NWNpQjhFNHdDNHJ0cWo0d21BQXZWOWRqRHNTNktyd0FvMEZlQVZoQktQZkJw?=
 =?utf-8?B?bllZTTBBdVlLbTZXb2hmUExlWkxWMUVvMVB6UXlrZFZBOC9kWC9mbmRNUlVM?=
 =?utf-8?B?QnBTN3ZFRWh4VkhmSGM0TDRlMlNhS29lR1R1bDl1M2haUlcvZHpOUDBGU0F5?=
 =?utf-8?B?QXdBUzRMRjhsRFZzR0VDdVRNeDBUTXhUcm0vWlNFd1hVTlJPQ09mRHFUSTRN?=
 =?utf-8?B?bTZrMGZ0cnQyVmFBclA4Mm5WRllhS0FSK3NGL3VIZU8rR21JV3UvR2JhOHE2?=
 =?utf-8?B?U2h4d3BMRUkyeSsxV1J5d2pZcVpBUXcxcGNZZytWNmhsY285eW9XM1lqRm9w?=
 =?utf-8?B?eFA2bGh4QnIrOFVoc0pmSkFsM0c4TURHOWhMMXp4SlZPbTErRFVJd0Z0NSth?=
 =?utf-8?B?cy9JMUNDOXBzUW02NERFV3hrUzVYamg0b2RTcHpFVVAyWUc5NzJWd2dkL2VZ?=
 =?utf-8?B?Mzk0MklqTjQzZmY5VGNreVR3QXJnOEFrUzhaS3ptV1JDODQxT1dnSXFzT1dO?=
 =?utf-8?B?YzdjN3ZPZnJOckIySjA2MkNSbkVCU0tqYzIrVUMvd3JYblNib3U3L2RUSGRi?=
 =?utf-8?B?aW5TREZ1M0dHVC9SUTYzdzZDT3hSaEx6MWUwcHVDNGxaS1Jid0Jyb2NxVTAr?=
 =?utf-8?B?TTJXc1kwb3NzWVJicWpIWVBVaUxHWXo3eEhUKzJsUGErNWlqa0NCbjBsVUln?=
 =?utf-8?B?dVZtVVhCaGhuWHhpVjlCNDdZeFh3WE5HSkxIZ3hJRVJjS1M0UlJOSU5lM2x0?=
 =?utf-8?B?L3V6cm96UXh6cGd5cDdOT2loaVJWRlhlT213ZWMyOUI4QjhyTTk5RWkrSzZP?=
 =?utf-8?B?Zkg2VXZHcjVzOTN1STNtQ3BOMndNK290akc2OWhCM0ZPNE8vNDlvNTgwM3pT?=
 =?utf-8?B?VjNRdFJPaTZzc3pMMzB5SGo3Q000Mk45NHhRbG5LQVE4cUUyeUxSR1VPUGRw?=
 =?utf-8?B?TlJuTXBzYUsrbGJtWWFLb3BNVWVLV0taWTRBTE1WRURQRXpnNUJSazhKOGg3?=
 =?utf-8?B?VWpxb1BPMHBKY3Jna3RLN3Y1QVNWNHF2KzJYcGRiNWR6dmUwaFdYNUxWWUFH?=
 =?utf-8?B?MUZNWlpPcUF5ejNHbVJwY2lVUEVweURSWkdubG5wemgwNHpqb1EvcmhLbU9u?=
 =?utf-8?B?OXJJakwrd1NxTlBYMU9SVmU3MWJKcnl6ck9idmV2L0g3K3BlcjJDSXM1YTF1?=
 =?utf-8?B?ZzVTdk82K21KVno1Y2c2dTJ4aGd1Y2dqRmxwVzVkMVd5SFRVZDVVMG1haEVY?=
 =?utf-8?B?MWZFelhsa0FOUDQ1YnBmeEFVa1ZmdkVnckM5emVCT2ZTbFZ0UkQ0SEwydG1v?=
 =?utf-8?B?OWRMMFhoL2t5K3BxZlR0TElYTXJiczZ1Yk1UZmRudlBUSzdQZHkvYzJyT2hi?=
 =?utf-8?B?YTc1KzZCUWlEYXMzUkwxRU1iWFlaUkJFQWYzVGZKaTZvMi9xeDY3KzVidnQv?=
 =?utf-8?B?cGQxcnBLYnkvQ0FLSzQ2MmtBdEFySWh0T2t2QXlRYVN1bTJUdTVPVGJRZkhZ?=
 =?utf-8?Q?HWLPyjlMk0OY9VNadLF2Wl78B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1d0072-94f8-425c-83a5-08ddda958f14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:16:44.4786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjW21NJBcpP4mVjFgQt70rs+gxITFFfVa7KOBALCPRWPP/aOMdhsljsle31QKrA+j7HV15ZmV0D1hv98dD8K/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
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

On 8/13/2025 12:51 PM, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>> Hi Alex,
>>
>> The addition of  total_submission_cnt should work - in that
>> it is unlikely to have a context switch right after the begin_use().
>> The suggestion of moving it inside the lock (which I prefer in case someone
>> adds more before the lock and not reviewed thoroughly)
>>    - up to you to decide.
>>
>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>
>> Thanks,
>> David
>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>> If there are multiple instances of the VCN running,
>>> we may end up switching the video profile while another
>>> instance is active because we only take into account
>>> the current instance's submissions.  Look at all
>>> outstanding fences for the video profile.
>>>
>>> v2: drop early exit in begin_use()
>>> v3: handle possible race between begin_use() work handler
>>>
>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40 ++++++++++++-------------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>    2 files changed, 21 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>        struct amdgpu_vcn_inst *vcn_inst =
>>>                container_of(work, struct amdgpu_vcn_inst, idle_work.work);
>>>        struct amdgpu_device *adev = vcn_inst->adev;
>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>> -     unsigned int i = vcn_inst->inst, j;
>>> +     unsigned int total_fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>> +     unsigned int i, j;
>>>        int r = 0;
>>>
>>> -     if (adev->vcn.harvest_config & (1 << i))
>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>                return;
>>>
>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>> -             fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>> +
>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>> +                     fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>> +             total_fences += fence[i];
>>> +     }
>>>
>>>        /* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>>>        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>> +         !vcn_inst->using_unified_queue) {
>>>                struct dpg_pause_state new_state;
>>>
>>>                if (fence[i] ||
>>> @@ -436,18 +442,18 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>                else
>>>                        new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>
>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>        }
>>>
>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>> -     fences += fence[i];
>>> -
>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>> +     if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>> +             /* This is specific to this instance */
>>>                mutex_lock(&vcn_inst->vcn_pg_lock);
>>>                vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>                mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>                mutex_lock(&adev->vcn.workload_profile_mutex);
>>> -             if (adev->vcn.workload_profile_active) {
>>> +             /* This is global and depends on all VCN instances */
>>> +             if (adev->vcn.workload_profile_active && !total_fences &&
>>> +                 !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>                        r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>>                                                            false);
>>>                        if (r)
>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>        int r = 0;
>>>
>>>        atomic_inc(&vcn_inst->total_submission_cnt);
>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>> move this addition down inside the mutex lock
>>>        cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>
>>> -     /* We can safely return early here because we've cancelled the
>>> -      * the delayed work so there is no one else to set it to false
>>> -      * and we don't care if someone else sets it to true.
>>> -      */
>>> -     if (adev->vcn.workload_profile_active)
>>> -             goto pg_lock;
>>> -
>>>        mutex_lock(&adev->vcn.workload_profile_mutex);
>> move to here:
>>                  atomic_inc(&adev->vcn.total_submission_cnt);
>> I think this should work for multiple instances.
> Why does this need to be protected by the mutex?
hmm.. OK - no need and it is actually better before the mutex.
David
> Alex
>
>> David
>>>        if (!adev->vcn.workload_profile_active) {
>>>                r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>        }
>>>        mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>
>>> -pg_lock:
>>>        mutex_lock(&vcn_inst->vcn_pg_lock);
>>>        vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>
>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>>>                atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>
>>>        atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>> +     atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>
>>>        schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>                              VCN_IDLE_TIMEOUT);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>
>>>        uint16_t inst_mask;
>>>        uint8_t num_inst_per_aid;
>>> +     atomic_t                total_submission_cnt;
>>>
>>>        /* IP reg dump */
>>>        uint32_t                *ip_dump;

