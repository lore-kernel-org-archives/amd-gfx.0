Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837BAC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 14:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F60F1135BD;
	Wed, 17 Apr 2024 14:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yq/BxtA+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4551C1135BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 14:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc2Xz+WPw3m7iyKwhbvXsGeLZNo4/D1Vew3k4pYDcITVmJTOGK9tCP8cw2MKHlz9LiUpmXhRKcu/5+PVtP3pTGShk86dYviYjDFL8QNm8QHcUjKIRmXHlY0uTm3AT6eDFYYuJS2bz02W2s2StHjs03x7SIi11daVQ/9n8a2O3bzqQbF7XW0WDEPXoEwEyhulVtWx5vnUOa4IyJkBP+17R7GRTTpDqHVPHti6wBdux64JGKniiHWpBsV7BjwcUcLmPI6KKuaMtqA1nlVN5mjyTthFpSvK79ZLdz0za7nlFiC/gCRH6NB28m7v5/KG5NNNlWk+K8XeUZWfBtPjjGZN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXw6JceOn7rHi29Ls3GTnqLOxwBEEYiidtW0JUiy/yU=;
 b=AmnZlTHbbnElNzM8920KzvlxcnXi7VvqVRJU7WNU+aLOro9CD6KSRr40ybmEudGktw1CF+uIVa25ecDTDMysiSxuDyR72RrLZZ1pR5FUMHmcAi+sZAJvDb1CQ5CJjgKB/U8UJiCgk+wwMSNVAP9L2p+28VtBsrbaxZA/nW6v921wIwhuqJK9ynSNvGULXEe+H3y5Vl3+Xo3fB+AWuxryC2xVUSGFhzXHZqgW9IjD47wnvVzBx1eQlvizAZxt+9KlA4ba/YgWgJgbF22bLREqjuude+qnwOGQ9NmFw7l90/TVi/E3/yYvJzt0URfh42pC+6KFPGpqJnmEt1uQHWDxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXw6JceOn7rHi29Ls3GTnqLOxwBEEYiidtW0JUiy/yU=;
 b=yq/BxtA+rIu/QXIyyvfnrqdXuH3pRFCThC6Mr1YgzdCjZzjdvuKoFyFcSjm8Pm8saCViU54hr94QUVaYPVq7mwnFG1Bklfhu2Xpp2XlFWX3I28GMiSeHbk4BXZVgguLXJVuEwATNL56VoZIXVLIvne0eFlvxNZezQVEPHRUM5ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 14:38:45 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:38:45 +0000
Message-ID: <d79c6f0b-ef99-46b7-ba67-666463071d89@amd.com>
Date: Wed, 17 Apr 2024 10:38:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Set color_mgmt_changed to true on
 unsuspend
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
References: <20231102042200.2070333-1-joshua@froggi.es>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231102042200.2070333-1-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0234.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 5022571c-e839-49be-2943-08dc5eec15df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQblMOosCzq6+cc6Uq0uk6M4WhuY0FewQLRdcvyvyq0OhSVpBacuV9+Mb/yx+FW9OQrAbic9HWIRaKBH404CH5QpDRAB94lFiDIsmcdtOVXQKlmDKVt2nLeEHNjjROAMOnvOS7kM3k4+NtbDfbL7393xGO+ZOvZoK7U0hweGVVPZt4oUA0EdOFOwxOH6Yc/d8IEq7ZaqVJnKL2k5MxyVylnDNtXpUwTlesOwOKSFmGNTDj9KwdeQjVHLyQVBx3A31RSspr+uFz59a8WdHGBu/G6vv8Bp0O3dvBXpplinfvnyp0Vm2sW+ItXp/gHcdauXNXVdLM/KewhFQUw6OoN2D13bjlqzwYVRDPtSrn3mwbGd7IJzSlc8jLfw5QC9vCfWmdDW+yNhBhn/kMK7lcFz8JzZfasuGfey9l3VExjlql44oqBWF2um5BapNRnDGbVHu+ueVKACJ6yb0LeHJZtsCRhD+ffayK67o+gU5oEjy+ED0Uwn9sX+vAs4I5SX1OX0Ex905ZUk889HxIv1/Xj3vo9hpCS4yw+9P/W5Omm9VQCYJ8EU57sFuxPyOsK3QupwYlhLeL/r9dhhNrGlk2g9iqHYji2tml8Gnsd/4geOJDtbt/i1SrLCnWVo1+fgkiNiBlyF53WuGUTT9jFMlwKPQidQTlWsLp/7o0HFvHmLbaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNuenQxOS9hZ3hUOWdRSHg4blZhdkhnc0ZTZWJLQ0syTjlQS0M1dDZsSVlW?=
 =?utf-8?B?cWZyWFV6Y0UzUTNySTd4Y1FGdlRoNlNONUlnUHVXdHRIbW9scHd6WWN3RUFG?=
 =?utf-8?B?WGJhTDM2OWZiUFdDbDYvRWc5WTVyRDcxcE9HeVkrb2h4YmZFblIydXk3V1ND?=
 =?utf-8?B?b1VaUW56ZENuVjR2RzdHWWMxNURoKzhQNzAvNHNRUHZ3UXA5MFJ5VUFyWU0x?=
 =?utf-8?B?UHVCcTZrQmNwb2U5QVIzOVVlT2wrKzErMmYzL0xDZzhpNldlc04zZGhKcWll?=
 =?utf-8?B?cG9xbmJPVW40T0VFdU9sT3BEbzJ1V2Fna3RCN29STTlJVlZhQVRWejh0Wjlw?=
 =?utf-8?B?QXpLbUlhcTM3L3JoZ1pwUHVPZlVaU2ZZOUlBU2FqdFFJblJEM0FsaG1LV0U0?=
 =?utf-8?B?cHVXQjRpbkJQU1RpSmh2MVpRVndUYzdtVEd6RFZ3c1BKUk16MTVDVktuU3Va?=
 =?utf-8?B?RzhVRjhhNHhyYjN3YlYycklHbUlMSzd5anBzdVY0MW0rVFZxcGpEeFg0ajgy?=
 =?utf-8?B?RncrdEVUaFN5RGxBZEY5aVdlMzgvdnVGR2JMeDFOeW5wcjV3dkRNTkpyODB3?=
 =?utf-8?B?Wjk1Q212N2N4eVhuNGZIbmREV2pFSk50RWYvSVNqRXprOWZ0QWo3UjlOZTVr?=
 =?utf-8?B?KzZSZnVhUXBwZ1ZTVWZxa0Z3UzhVVjV6RTljTDdRUXg0UFozWWdod3JCbHNn?=
 =?utf-8?B?RGJ5TlVaYVVWbTlrRVYzTm1Za3B3MmJrN0hJZi9sT3dQYnMvY21TNFoxZlpr?=
 =?utf-8?B?Tlp4RFZVdEtqL21UWnFSbzcrcEh4b0RKeVdOWlJPK1c3ZVhLdDR3TFV6VzFj?=
 =?utf-8?B?ZFViZkhSdFBsck5UWWxvN0w3RkdjeUlQeHJucE5Fc1F1QU1BL09CYWRuM2F6?=
 =?utf-8?B?NDB5NFdiYlk5cVBoQkU2WTVFN2lmQVVpQm02WEZFNmN0eVBRTkFGNGVvb2Jq?=
 =?utf-8?B?Vmk4OW1OVndoeDQ0Y1diS1JPQktxN2tRaUl0V05SeEdTcDczVXVOa2JmMGYz?=
 =?utf-8?B?Y3ZTNGdUVHI4ZmxzNmNEMnVST2paelZlc1R3d2VPLzl1VFJFUE1rQ0toUGEr?=
 =?utf-8?B?TXM1N21aZ2tYT3ZIK09HWjNkZkFzOXFpaXRjZURMdnFZWHU5VUNwWHJtcTd5?=
 =?utf-8?B?KzRoTGVSdzlrUGc2elBHZklEbUxNNDRtS2hITmtuNUxGb2oxYW9wQiszQlgr?=
 =?utf-8?B?dnp1b2wxQkRzTVZXaXdYdXFCV21oZEV5bkV3Q2U5eDR0VmQvS1J1SGVuSkFP?=
 =?utf-8?B?M1l5Y2hYZE56S3IxUTRKbU55OTI1Z0xSVVZGcjRTK2Q3RU4wK05tbUxndU5r?=
 =?utf-8?B?eXQ2UEwyVHBBeVJ0OUFyMnA3WHV5UkdhQXNESDk3aUR1N2h3RE9obytsSmls?=
 =?utf-8?B?ZGJFL3JJU1RyZm44ejErckt2YUswTDlFQ0tyWnBCR2Q3YWNHSWM2VVBRSmY5?=
 =?utf-8?B?eVp5eXFaQldkNUZnemJBc096TjJ3WTY3bW9mUjAwUmZTclI1cndnbFcrRnlv?=
 =?utf-8?B?RVhQb3FMQklqaHgvOUQvWlQ3YXdaMTdsV0VGMzNOaWxWKzZGdzJDOHdkVHo5?=
 =?utf-8?B?MDZIRVFFNjQybHljT0NLZmlJM1E1Z2tLNGJMYjRFQjVTcFlqbWRlQWVCb0Y4?=
 =?utf-8?B?eDg3djh4VGt1UHRhZGdBQnRuZVpVZzlnYml1MFlaZDQxeExrdTRFU0piV2hC?=
 =?utf-8?B?ZHM4eDlraVlQVTZJdHZGNDI5WGwvWFdQY04rMG4xQ1lxeS9CSXRTU29RWW1l?=
 =?utf-8?B?eGo3T05KS0JwTGZLeE9UbndBMlp6eDFOMzZUTWg2L1BaNTlZQVM1Z2Zadnhs?=
 =?utf-8?B?UmNWTmRTV2FwQkZGK1I3VlJ5R0FBT2ZpN3hhMHNXOHdkVkdUNy9mVVpyMzBw?=
 =?utf-8?B?NWR6UlJBYWo3SThJRm5teEpaL05BNlh5Z1dBYXAzUFA4MEJ5TW5Qc2Uvd0lG?=
 =?utf-8?B?Ritwa3lSZzFUYXNXK3U0eTYwc1NWSEVUNkpaTHlIdE02MzdMZWltSHZyQnJl?=
 =?utf-8?B?M2tqNms5RlJ1VHpVdFhURHppdk51ZXp6T2k1OFp4blMxMWl1UHpNSmIyQUZB?=
 =?utf-8?B?Y3hNcEcvY09oZGwvYU1hNWl6UjFzSmt3MGs0aTVRZW9yOW5sb3lkQzBoY1pr?=
 =?utf-8?Q?7rwAu6CYud1nrVb0Ss9ZWAmlB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5022571c-e839-49be-2943-08dc5eec15df
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:38:45.5143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMBuW7ogy2d2tSe3joCrStT2HDzCnfiR+dmPM6XBX3ARfjrnf7fU4MXep88Sw8+FAFoJcDazBFgFn2okL+1DMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
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

On 2023-11-02 00:21, Joshua Ashton wrote:
> Otherwise we can end up with a frame on unsuspend where color management
> is not applied when userspace has not committed themselves.
> 
> Fixes re-applying color management on Steam Deck/Gamescope on S3 resume.
> 
> Signed-off-by: Joshua Ashton <joshua@froggi.es>

Going through old emails and found this.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Pulling it into amd-staging-drm-next.

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index adbeb2c897b5..ae650707f234 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2967,6 +2967,7 @@ static int dm_resume(void *handle)
>  			dc_stream_release(dm_new_crtc_state->stream);
>  			dm_new_crtc_state->stream = NULL;
>  		}
> +		dm_new_crtc_state->base.color_mgmt_changed = true;
>  	}
>  
>  	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {

