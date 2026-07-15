Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FB6C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 09:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1D988CFA;
	Wed, 15 Jul 2026 09:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FeUrkHYH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013058.outbound.protection.outlook.com
 [40.93.196.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8773688CFA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 09:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG4ZDt9Zo9gBD+bQHj/l+qUSAKQAaAk6CVhmiKbg4/ijOW5bbuqhaJQ04E1AiTA7OipG+n7YDni3hTtNXH36v/u8iBUz2EwyRz2ZbUbf2B3Za6l1ollOzJ4I3KOhKWZeEfV9++0SHkAxa4AwUGn9AWqdqOes3NGjPq6RACusjn5Yleyrxh5K4XPQ8AZOCZDOUrPLv3SwAe7bLyqaVBfKVFzSyKaz4ORHoNpcJ/eWbP8Y1cLyusBzmaWmF5XbBucMq1gGN7YSrFPxJAM4iP/c6fMKZC+6Zw/q6dHoYMDqbykb8qT7h0xMNgI8DV4DLz0Kp/oW6+DLHNaM8f7OIqN0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HV4aGer2CdaieIrr5ZYF4LyeMPr7HU6Ar9YUzIus5A=;
 b=W3/Cum1kcfv75v4HBdFgABP2u1GiAO5+WDoIzjpcNrYOK+VyvLxTCxFcmR2+TaqKT1Z0wvlfd+NXMrFkYTxLeUIkEFgWhC/d+d/mgSkRbHIxvblS3VlyVy6wevtDIig5ixNvZ5qWU0sL0Bb+nlkV/fV15xWSUPhspt36587RvRTKjmG0qjPBpVMO9Yy1gVrDNRdD4XBGsSPHD48v9CfbhO0B2JvBb1hXpHmI8RRSVL1tcc6UAaKE6HDMB8ksfGDIgHkJHypX8kELCZbzEuGtTTw/lpb9ZApioMySepOZLb4lBUJNkN9ILA3SHZBzKLGi2UwVcopp5wi62FnSL3WOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HV4aGer2CdaieIrr5ZYF4LyeMPr7HU6Ar9YUzIus5A=;
 b=FeUrkHYHVCxIOu67isOXApfc8iEaFqKEH3YnjrLbuR9M1QmZekXIJsywPhGciavESrApEJFa6xKzERxtRnuPthOElp85r5po+nQdal9ogTRdRFmCjMK7uK40In9BLrA/motFBmk6Cj3q1EGEQ2AOOLdR2ivIHb/YN6YwfnHBjbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Wed, 15 Jul
 2026 09:00:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:00:53 +0000
Message-ID: <70f3e844-002a-46b2-9341-47428abfd829@amd.com>
Date: Wed, 15 Jul 2026 11:00:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amdgpu: add an buffer funcs callback for TLB
 invalidation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
 <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
 <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
 <1e4cead4-73b7-461f-b4d4-a66e293d0d96@amd.com>
 <CADnq5_OnTfvMf+Bx3V36p0W_M4ARksHZ+emGSNb07Us9xPr2uw@mail.gmail.com>
 <c9e1526e-c2b6-465c-9f82-24299d8a0e23@amd.com>
 <CADnq5_P8dPWAJCd_=u13KKDPmJQecC9MqHJ6K9g4+4iQxYvi_Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_P8dPWAJCd_=u13KKDPmJQecC9MqHJ6K9g4+4iQxYvi_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a942d9-23d8-4aa7-3a8e-08dee24f935a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QVcpticoDhUGI4UqdvbhHu4AUJGUcLyZ0MHX7lZJldNClnsx9LFzRcFMltvdimA5Nib5IBwVxeUEqk23cRDLxpDZj8K+QYwAFsoGzXRlBuCrtNssZAcIaW/u0b5HLGZBNXQmsc/Km2EdqUis8Iw9nN/U3NZHS6pzPMSI/iqzmo9gQZgrTcSMAhQADv+NYenvO5g+oAfk5ayzBuYG/bHx5GIpnDxbin/sLqn5AeFLF8SjZIF3+TcR8ff0RlfpclmQZCjHpxz8C1MTilvPZmmAS2o2lfN7r6cUTPnmrvecpST8OIb/3qlbGQUSQsQPSLuwTvOC3RkWoplY3917o2zyDWkwaZwqgoE1g/lc5yZRFOCRdoBQM0njCXruC6zG4QIZpQMOS7Cv3eLSIJsDRt90qHgPdbJrrCAnq1B7t30ssOuTGqispd63WGge7QmyBnvrFm7PgWppX52u+oUmL2FcfCYUU0kgZtDMIGiFnLaaTtwWiHaD2KEgNJe0Uzwy6sgfLQ68YXqIyEOFVsr+lzjYde9HOuPJotzdi1Yt2AdcVzGCBvO5a1EulUdr18IwLkJ+hedf7J3BOHdiaJ8S0Z/EgdYlpdL+fMlSReLVGCSVCr0IV0N6+6hs5RnnWrxk1esIZ+6Ql5pr2Pi06ia7SLiwSpkgWCBXcibotWJR/8mgGUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzhEcjQwMHpERjBhOVk2V2hYS3lBZHhwRjh3ZlhabkJqeWg4Vms5Y2tTQ1U3?=
 =?utf-8?B?UDF5S2ZTeVJqOTkwclBtR0dUUU8yL1gwazMrZVd2ell0SFFLZ2k1U0FsZUdw?=
 =?utf-8?B?ZWJ3SG5oNE1FQzZTSjduWUY3OWdEeElwd0FEalFPaExQZHZOZEJXQVlwMXhl?=
 =?utf-8?B?SzFhNFVhRVFSRm00dFlCaWJaZFBuMStMbXRxOTlmSVZ0WGxSYVBBaHlzTUhD?=
 =?utf-8?B?UDZ3Z3ZPakJUUjZVUElUdHJ4QUROakR0SWxPMW9INU9RYkk0Y0dYU2xhRXc4?=
 =?utf-8?B?TktQdFVZd1NBYlBYT1FGNm14STZtakJKc2xtQi8rZElvRWhtOE9TRHJCUWhZ?=
 =?utf-8?B?MkJiQzV0b0xyNUxoWDd1bU5td01mcmJwVE5XMWVHdVh0ZkUrMTFJN1lsOUtt?=
 =?utf-8?B?ZUZ0TzhYN2dzV0E2aUdJWjM1YUdpUnQxRlorKzZXa05KM1JhQ2E2SHBabmlG?=
 =?utf-8?B?eE1DdnlPcW1QVVYrc2Vtd0hBMUNneUFJQWNSVUVETm0zQzU0REVSZjhyUDU3?=
 =?utf-8?B?OWdPam1VUkczMldaKzRLcHVLWGFUNEFHS0FaMXRhdS9hZW5iR05FbHJ6dllj?=
 =?utf-8?B?amV1K0dRYUVMaUNzdlJlQkJmN2F6bGdxY2luRFJMVEVUSG1pYStLazBvTGZ4?=
 =?utf-8?B?Y3hwVlEyK0Y0ckxXWCtKUElWN2tud2tvN1JkSkYzWkF0UmhCY2phcGRTMzdr?=
 =?utf-8?B?QUU5b0xtK1lzeXpoenBlWXZmYzh2MzFGZ3hlVCs4RUtXMEdneVRkdVQ2RXNY?=
 =?utf-8?B?R09SbFFyMEwrZ1IwS1B2VC9wNUhiQ1ZGb2dweUFrb2c5dzN3bUxJNlg3b2RL?=
 =?utf-8?B?SHJleHZDVDJwQjFPeDhoY20xZmNYamlCRnhjTDdIUUZzY3BXemlaVXNya282?=
 =?utf-8?B?bU5sbFBvZi8xZzBkQmJ6bUtoYVVESnFjR0JXN004Q1U1aWlEUG4rdkRJejhp?=
 =?utf-8?B?SEFNZms4TzlIdlJtYU5hWVNndVhSTjBZVDRiUWxTamRrYitJek0zZ2ppaEZV?=
 =?utf-8?B?cXgwenJlbExWaGxGYnE3dG45dXpVd0tLbURENjkzWnZRYkFTVjBQSlRHamJ3?=
 =?utf-8?B?SUhkZDdQcFE5NHZXcGZGQWJtNm9mNUZFTUlPak9RVFJBODA1b2s2NVhJR0xR?=
 =?utf-8?B?UkVoelorM2hKMVdQMTdPQ0ZOSHhvb3hoWEVpa1ZjeHJIZlEvUTRXYnplaXVE?=
 =?utf-8?B?UkhaT1lJeXJJZFBSSkdFTnBRYTNGZk1KcnBVZWRtWGwrZXkxbWxVbkJFRUFV?=
 =?utf-8?B?a080eFF3WlhieE5Ob0dUUHRuUWNlYnQyREFhZS9YeDA5UVlCUHozaW9zZ0FQ?=
 =?utf-8?B?WHRuMTcxZTFKMVdzZi9ZcmVldmJJNGY0ekVzZEtYWk9hZ3N0U25WM3dGSkJS?=
 =?utf-8?B?eWMzT0ZNK0lZaDZhZXo2V3dEV3Bid3JlUmdSVmJ6UEZlZXd5empFd1I0b2Mx?=
 =?utf-8?B?VVZIKzdQY3dBdUQyZTcxWXpBa0JtNWpCTnlEMTdHMDd5WTJLdU9kVXYva21r?=
 =?utf-8?B?ZU1NMkFwc3lYd1I1SlQwVjFsRmtabWhaT29OWjVIcmpxeWlJQUpYWFNxcmhu?=
 =?utf-8?B?dkdKVktiT0NUaW92NVVWT3Z6T2Q5a3dxRXdQcUt2UzFMbUI0WFR5MmZxYU9C?=
 =?utf-8?B?bWhZL1hVY2tibFZ0MXM4MUNzZGdtUVd5bVh1QmwvdjZ1dG10T1hzVFNnNHQ2?=
 =?utf-8?B?cjMzQkdwb201YVBaNDczYjN1L2hNOElTY3NOaGNFZEwzVWg0dytUZWx3d1Bp?=
 =?utf-8?B?ZG4wNVF6d2F5Z3gzdkhucUxBNjUrdVh0WStrbXJ4MXNOajJTTDR6TzFPbFRu?=
 =?utf-8?B?bDN0UzNNcXlCaUwzT3NSNCtZR1NMdHh2cUMxYnhLanBxeWVwbFhXK3dhSCs3?=
 =?utf-8?B?WWxaWXVzVzhnQmt1NEVNd2hNWEd5OTNqMndRQXlRcE5GaStxblJNYlRNaFU0?=
 =?utf-8?B?WmxQeEVnU1ZoblE4N0x6azZJTDNaZ3dIWUlwS2Q2SS9kVTJwcFFRY0lMRlFy?=
 =?utf-8?B?NXZKcGdMN2VDa2dRUUFaazVpZUZkK2gvS0ZST21aRFBzb3hNVWFUcGpjejBy?=
 =?utf-8?B?dytuZSt1cmRnY3RrMEMvUkY4aEJiQVhHYVpLanBpMDJidVNiKyt4NUFuMUVF?=
 =?utf-8?B?dUFORmdxYlNoRmp3K0g3K1EreVNUSngrN2hOakErbGRJMmZ4ME9FZ3diWU1h?=
 =?utf-8?B?VWFtTi9aOVprQko2dWdXUS90bWZXMW8rU1JJUWpjWXMxcEttZ0JNYXVNc0Q5?=
 =?utf-8?B?eFpuc295MmJGVW56SFMyazRhRG1pK1F2M0lqWENvdVdGMzFPUXJhdm5pNTVv?=
 =?utf-8?Q?vz6/KCFs6RJVgN5p3x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a942d9-23d8-4aa7-3a8e-08dee24f935a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:00:53.7314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eCTpWrDAGK7umOC/UYIMY7ew15ilhzKjJXy5Jgggnz7LEsbFdcYzpdFaC0A68Zf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489
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

On 7/14/26 17:19, Alex Deucher wrote:
>> Why are we using the MES for per VMID invalidation?
> 
> gfxoff.  We can't access the registers directly unless we disallow gfxoff.

Well there is a remark that VM_INVALIDATE_ENG*_ACK is always save to read, even when gfxoff is active.

And we explicitly acquire the semaphore to avoid that GFXOFF kicks in.

I also don't see how we use the MES here?

What we do is to use the KIQ on gfx9, but that is actually only as a workaround for some SRIOV problems.

Christian.

> 
> Alex
