Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A045C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 18:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28AD6121F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 18:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C28AD6121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FBB6ECE9;
	Thu, 21 Oct 2021 18:01:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A556ECEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 18:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGzJ0AFN9h8u43t3mcq8K8eoAIwTwuaenIshhBaOr5P3KVGCXAqTAm/lfDey+V1x+GzAcToeUOxy1/2R7cnJh74eFvs4fxVuWuv/XNBBDal64aNov8W5YlFNfqVTmi0ZFe3hPYGR/fggedbjito7zyKCymUJ+n7CdR1BIO3TPTXIyqCs8d3Qh1iOhI5hci4sYv2Q/oatbJggJ+EAvcsetAxLB4oBTG2QckNsZLMtvPpxHjd9OxspxgZs8rGVCDjK7e9nuBPML/Ng312v7mcdwUPDNgwapm2ibXL5Cg3txIKC2iRJuID1ZJHW4xGO9GSDU0QFA+z9o4fnytifwwmAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0CF1t6lEsiTBhDWOG7Noblin2Cc3zI2S/FN7rCFMyE=;
 b=mxkWHpApmj1Oi+vQa9+cGQ98crp8hZw2kW7VrQCorEyI30THwIlzj77x7Jj3bpU1AMc1mXN0zt3xNy8W47Z4orP2/E9eT0MlnAM3vFBut+BvkpeNeFVWbfqFqwlSw94FAX6Is408xWemwxoq48hg+BXUlrAO5xgXguM7+/sHi9VH2tuhzTKyYvTpX4UyWLinUgPJGaIxPSOfRM+dg38w0SEvYE9a3wj9auf26qK1AUfDFSHcoA9Afqi1G02haXemVmuXEd6m5phMe0cG8ZJIgW0y+9r+00FqiBMYN9kDXBw2d10Q/gcElbIfsvafmN5xYZBqLojmLAkVDwizh+1w2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0CF1t6lEsiTBhDWOG7Noblin2Cc3zI2S/FN7rCFMyE=;
 b=AZTnESbxJfoDilKVCt3lbpTIEBUEs5y+PjxLT620YD1TFUodIn27vggoERmnliPfj/wREgAe9fameCPfuOrZwoIpN+MfKfwd639HZpBGirikpOyLedMB9sm+mF1BxCvtEj0BF89BHCTWzxyobgOqOs0kM1MYtDM3brcP0jUK6jg=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 18:01:25 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510%5]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 18:01:24 +0000
Subject: Re: [PATCH v5] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
 Mark Yacoub <markyacoub@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sean Paul <seanpaul@chromium.org>
References: <20211011151609.452132-1-contact@emersion.fr>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <d947ab66-21ad-8cfb-cb58-cebca362f0f2@amd.com>
Date: Thu, 21 Oct 2021 14:01:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211011151609.452132-1-contact@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:404:11::15) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:56e0:6d60:7ecf:81fd:5f02:a76f]
 (2607:fea8:56e0:6d60:7ecf:81fd:5f02:a76f) by
 BN6PR13CA0053.namprd13.prod.outlook.com (2603:10b6:404:11::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.11 via Frontend Transport; Thu, 21 Oct 2021 18:01:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6d6c19-98fd-4644-298b-08d994bccc0b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5282:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5282F601768BA8F4E62F9DC198BF9@CH0PR12MB5282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0zAAsR8X+UxTnU4LChdLKvYP85MaTnmpT+UL2WYyZnG2efm2UjlHrlrFnkm2FY2sexBBxFtU56OVzc7fdSCXZG2s8uS/PNqL0wW2rM0VI9yferPnFQT0o4E2mxUmwWTR7W4jrnWijfbLD+WMoAkqsY2/7vl3wrJYG4Wb4/moBqwzmXgAKOFPZrt9W0TtAIw9njNPW+bPiovQw7aVncTTQNjiXTrqENDnmUDTgFMA2DR4D7qPTMadXReL9QpQKd/tcDU76ig7YcHtoYPIZEIX/UdI1iPJISoyBJAkVzYFV598K6RUPJJrMUpD58OqEAPxeWzwl1Eu4Hq0BmJIUWFRgkcy3Ju+oqB1KFJ3qmZ7sgDTCeaw/QLTa90K715L0sFO0p3s0fIqjacAhkyjAFT+gCg9wZPiKaEtXIAYMtAm4rG8Y1Tnj0oewwZ3sgHqmVtCchVNONq4pLrSD6OEyCuZiOhUPj0OaHnNbpq79zKD2ZMYO63a0Isv4IDc1I+R+Q40/sMFVFcBX3UAY6dPaAj8VfRjZn7Pi8l9xk26CTzeXvYfVdSLcVl2BplO6DzIu7e6GcnMR8MEa5vXm3ZBlb/dbRo4PT96y2buCIHKOR2gY/ApC1f8CgtF/wMvsepgPAKDK5pax8iWs/5eNsFx98wp6CR97figJrR7irbRTL7RaI1UqlcRvJvkQ3YQU58BxNyHwTV4UBW3W6X0nUHFh8Dy1iuCmIcQj2HiYt/VcwS4B4EpcJE1AUXFF+ZIRVc6uGJcC5UgeVHw7p4ZXKCREwYuNNeJLhFyRPoJrMKvBHkKviJWiWG5Mpko35pk9IS6GlSnPuraXN57UMN0gxuzvQM9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(508600001)(8936002)(54906003)(66946007)(66476007)(966005)(31686004)(110136005)(66556008)(8676002)(4001150100001)(31696002)(2906002)(6486002)(2616005)(4326008)(38100700002)(36756003)(53546011)(186003)(5660300002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3IwM2tOL01YREVmc0d1Yy9UR3Y3TEh4cGRVSGZWMjN1bkk3bU15azUydXlI?=
 =?utf-8?B?SWNIR1VORHgrRC9jSlNCL3laa3hoak10cTgzYVlyRGREUWdWbzMyamFaV0FF?=
 =?utf-8?B?SXpabGpWYjdyU21MQld6N2l5SkMrMUJZaHl4T1h3aTNCbHVKVVAzejErQkJ6?=
 =?utf-8?B?VHFPM2FzdzhnNWVTdTBFbHJTL1dEY1kveUV5cThHZDNwRjZnZVB1RUt5eDV5?=
 =?utf-8?B?MThHNjM4REp4NVFNcTVMUGFVanY2QW01WjdqUUs4YjYvcGFWeEpqcHNQbGdr?=
 =?utf-8?B?NFo0UU9KMDdYTHZ2ZXBrZ1JXQVIxVm5vZjBlZ2ZNWWIwK2Y2YWcxVmdMS2hr?=
 =?utf-8?B?WWhRbmloczE0MkJ0ZXI1amZaYmhaTXBaU2JCejVxQ1c0SlBLUjhiMk9Qd2tw?=
 =?utf-8?B?Y1BnSkZaKzNLKzNGSnA1dmx3cTRGSzgyZ3kvL1F2MGFVMnV5eDhxSmxzdHpp?=
 =?utf-8?B?Z0UyWFJPS1lqRlFaRVVSaTZOczdLTlVKWVZWUFR0Rjlva3NKR090NFE0WGMv?=
 =?utf-8?B?WHZoNFUvdHVrYU1yRGh4ZldUYVdCZjE2WllpSVhOVHh2anFNOFh4SE84d2l2?=
 =?utf-8?B?NmhPdmMyUVZ4eUF1RWZ5NWpqQlJ1ZmhvV2ozREdaaWxXYzlNTElFalAzckJq?=
 =?utf-8?B?bnllTHNWdDdBdjZuQXQzRzBtc3dhVHp2VjBnOHhNK1Nzc2M1dzhXbWdkZ1I5?=
 =?utf-8?B?dUlpMk1jdkN2RzBNaHN2a3JQcmVOWlU3L1MwVTBEOFNCdGNNT21EVXpOb0JR?=
 =?utf-8?B?UGlWbG5lQVJDR1hldm1PUnZpQjMvcHdWTU4zaVRXRkNKOUJ2SkJoNDdEZGJM?=
 =?utf-8?B?eTFDMVkxVVBXdXd3MWVIZFB4bFBObVYwc0tTZnJYaSsvbGtSSXByWEtHVzM4?=
 =?utf-8?B?OTVJMjh3MmYwTmRHeGVyRjZpK0tzeEhGdG5MT0ZVUW82a2czcWJLUS90bjQw?=
 =?utf-8?B?TkdpK1NCUzR1eW4xWlNqZURoNDVkckdWalJ0WnVyUmgwanQvOXJHRzJ0TWVq?=
 =?utf-8?B?ZGdoWnRCeEFXZkZMZGxoV0NXYzlneG9qd2ZqOEZ3Z3pQdTM4RnEvUXJCaGhq?=
 =?utf-8?B?dG1pRVpERWtEd3p6aGdkQnVIK1V5UmNxWGhyVWpmUndRSllDL1YxTWM5by94?=
 =?utf-8?B?dElDeksxck14VmVLTFlrekNhZyt4aTdjV0U1WHY3V21UbzU2SkY4KzVsS05s?=
 =?utf-8?B?eXZGSzJQU1BzSzZZdHhObFZKcFhocGg5cmticDVyaWhCSkZiMjdUNlR4aGhG?=
 =?utf-8?B?T3JFQ3dtS0N3anNNbFFpRitnVU9RREVVVWpRR3NEY1F4R0pGd0ZNa1ZwalE3?=
 =?utf-8?B?cERQcW0yb2gvSDNGdkFRM3pidUQ5Y2dpbjRkc0o1YnVrTTloQUlrWW41WjFZ?=
 =?utf-8?B?RWdYaDJOVFRUYUxSeEdSeFlEVDdCYmI0M3ptR3JpbVgzcUpDVHFRSjkxbnhV?=
 =?utf-8?B?VWUvVVROenFDN0U2dklZcGhveFRmeGNKUzVYSWV3NVlScTlNWFFRRExzWVBZ?=
 =?utf-8?B?WElDa2kxT1UwVHBKNGN6dzBrRWE4ZFhZRVQ3TXRiOUFlYlBwY0FZTi80aUpE?=
 =?utf-8?B?M0JWV05Ob3Y5dnFkYktTSmtGc2tpRXE5cklnbmtjajM4aEFMMlQwd1cvWENH?=
 =?utf-8?B?YU5DWFpqTDRLellSRi9xNktVZzF2WW93YWg5dHFHQlVCcVZKRktBdlJNSEFH?=
 =?utf-8?B?WkxVNUVqVUd3clRPUk0yZXpFMWVxbC9aLzFjNHNnMXBLc3p6RnE1MVAzRTRp?=
 =?utf-8?B?a3Z0TFFjN0hpTWdXQmNySmRXb3oxV3BneTM2R0N0cXlDK0FuTFZSUnErSnVN?=
 =?utf-8?B?QmxQV2hNZ3h5MGwzN0U4UC9rOFJCMnprQmpaVWdzY2w4SmN6MDNtWkZYQkZy?=
 =?utf-8?B?NFNLbXVmZzF4b0xOSnBBYVUyb3lUVytKeXV3U3RURmVFZk12aEZqVVJyRmZv?=
 =?utf-8?B?ZFg2ZFZ5VzMrL3BiT1doZEd6UURsZWxCZm5ycVk4cExWS3VuRThxU2tOTnZj?=
 =?utf-8?Q?BofBibt+T5/CjQV1Sdz4Cr1Xmu9vvE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6d6c19-98fd-4644-298b-08d994bccc0b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 18:01:24.9016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjordrigo@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
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


On 2021-10-11 11:16 a.m., Simon Ser wrote:
> Commit ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when
> using overlay") changed the atomic validation code to forbid the
> overlay plane from being used if it doesn't cover the whole CRTC. The
> motivation is that ChromeOS uses the atomic API for everything except
> the cursor plane (which uses the legacy API). Thus amdgpu must always
> be prepared to enable/disable/move the cursor plane at any time without
> failing (or else ChromeOS will trip over).
> 
> As discussed in [1], there's no reason why the ChromeOS limitation
> should prevent other fully atomic users from taking advantage of the
> overlay plane. Let's limit the check to ChromeOS.
> 
> v4: fix ChromeOS detection (Harry)
> 
> v5: fix conflict with linux-next
> 
> [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=@emersion.fr/>> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overlay")
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f35561b5a465..2eeda1fec506 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10594,6 +10594,31 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>   }
>   #endif
>   
> +static bool is_chromeos(void)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct file *exe_file;
> +	bool ret;
> +
> +	/* ChromeOS renames its thread to DrmThread. Also check the executable
> +	 * name. */
> +	if (strcmp(current->comm, "DrmThread") != 0 || !mm)
> +		return false;
> +
> +	rcu_read_lock();
> +	exe_file = rcu_dereference(mm->exe_file);
> +	if (exe_file && !get_file_rcu(exe_file))
> +		exe_file = NULL;
> +	rcu_read_unlock();
> +
> +	if (!exe_file)
> +		return false;
> +	ret = strcmp(exe_file->f_path.dentry->d_name.name, "chrome") == 0;
> +	fput(exe_file);
> +
> +	return ret;
> +}
> +
>   static int validate_overlay(struct drm_atomic_state *state)
>   {
>   	int i;
> @@ -10601,6 +10626,10 @@ static int validate_overlay(struct drm_atomic_state *state)
>   	struct drm_plane_state *new_plane_state;
>   	struct drm_plane_state *primary_state, *overlay_state = NULL;
>   
> +	/* This is a workaround for ChromeOS only */
> +	if (!is_chromeos())
> +		return 0;
> +
>   	/* Check if primary plane is contained inside overlay */
>   	for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
>   		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> 

Hi Mark,

I tested this patch on ChromeOS, and this can be helpful in two ways:

1. When ChromeOS GUI is running, the workaround for fixing the two 
cursor issues works as expected.
2. When we turn off ChromeOS GUI, this patch also works by making some 
of the overlay tests pass.

I think we should cherry-pick this patch to the ChromeOS tree. Is it ok 
for you?

Thanks
Siqueira

