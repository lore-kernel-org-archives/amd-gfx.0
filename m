Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E1C6103D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 14:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34E1C6103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA5A6E9A2;
	Tue, 12 Oct 2021 14:39:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4686E9A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnUbjC60ppZn3+q1DpW33YD2ONAq65jfx6Ngwp6p04/jaIfG/ZKUFzhmfgSq/WSb3Jze9VMB99M71E/hibgdgax9jqL470QbzDAFAP+anfvClDR4rhknD0+uBs9BglWf1yp4GeEC8BooAjo5F+WLN9lMsTKnbcJ5cy6t77zsD8F3TqJv5oFSGbbH3i9bM5v8rV21rq+b450EA+Q4bFs7mD5KcoYloboiRFByh4r7PTYPJvMIDwvn6+ZGFPfxtOgmBR31ZPxvExpbun9qc6is/sP+AqYO/VtpaYIQqlBGF1P54/HKJ42+QEmvNkrSFSHtimLi+ejZMa6t/H+qkzByvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dukKNFmLeYAJvk+4QoHRtFrABMkF4Msq7cMq5aJo89M=;
 b=JPyLtg8rkMyqENgcgPLrHZW5/+t26DK1n2DC0vKVQLE+yu5TRMw936eLqmbqYnNHyFHPKiJJOB77+JA+sbuBzcPXkdwkdm6yZjYeACi8fBha7nkxBgxZ6srZ8dmCwIa/MUuOFV6//LgmU6g17KPrZoDpN7iDOGlIoBZrrqRCEzMEpbjSR7Xi3WuctZGcBVZbDhqocUD6YnY5hpKjCsluHthEuqqV+EnSSL8thCM9cZLjq2OofG+kEcrbdbfaKGb0uNyrB2/2p4Q6m0U/ijmk/AfRYXYayJCQgtmuNUUWZS+z7Sd5Y/9vO1kdWb9+4lJnMw1eSD2QF4UZjK7VMB2nLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dukKNFmLeYAJvk+4QoHRtFrABMkF4Msq7cMq5aJo89M=;
 b=ITUfassXhp62f6rO97MYnDFGCXjWOkfKVxBiTM9+qrAsY6+TqbYwID5LSKC+6ZVCEW7JpZxu5ixhfQUhz542BJOls1ZioYe2qMN1roMvQ7MFk+WYj6+PMgGeoCddr4pJKFYcZ0pvKeQV8c2/JB6YaK3PJ2yVbpPm+3WQ3CcMvwI=
Authentication-Results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 14:39:41 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 14:39:41 +0000
Message-ID: <44154452-aa21-3f08-ffe8-e68fb8036271@amd.com>
Date: Tue, 12 Oct 2021 10:39:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v5] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
Content-Language: en-US
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sean Paul <seanpaul@chromium.org>
References: <20211011151609.452132-1-contact@emersion.fr>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211011151609.452132-1-contact@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0206.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0206.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:67::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 14:39:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63302098-763b-4051-60b3-08d98d8e1ff8
X-MS-TrafficTypeDiagnostic: CO6PR12MB5396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5396B5CACA1E78804A726CE88CB69@CO6PR12MB5396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXZfa2oYrdh1d45RBFNMDonZNzOTuMFBoTacA/rCtcQ+jQrtjuRaa6x9j1DglMI0vJt1ywJMoh7/kJPfCGvfaGXYsUTOx9cBR0kLH1DEG0hFdun9ZQ5V5HHVFpj9G56a2xdI6Fli2ESgRy9yk6vCTKekernD+dIaH21x+VUL73A+YsdbTsVK8Ms6vJ9beNZLGaOAx6IEI2E59S5dmjXUO/OoAjHISVUipWJvzFh/Gnsg4GuQh2RNAY2IiY5LQIHNsIsEQyWEVcbbxy1ko4bWSdSQAQmCuZyDBHVv8s11z6AAJeZvETyvOTXgDh3tUenzwPY7oj0k+9i229g4clGRldwpz58QKoHSNINIMuvvakMny2yODKBFCQtb3NTqn1l5ut40T6ZB1bvH395Ni18oZC8pb1o8KabeHiT/KvdfH91/qHWrxipotS2bH6YVyQ5ESnwiakbJ2yMlEcfoHZomq4gHeeyPb02x3g1rYsvDN5vSfMlIeQGy6cppnPRjVEWL+u8Exs5HYFssVxjcr3tVSjYirCrMQsZu1GptwY24xpwliRx7ksqWzqdLHURFJ8zhEuSXLTn+NKjsrq5pmrjIC1TbdA8WpCINuZ0k4aOukRNlay08/adErs4nXew/XGkWsf+t9JcSNM39c1oB1steGeS6yIMEwUdpvBktbOZXIEOT8mJxNBpKGRexVoj2NrV29fcgGMuGRobGzvRN41CIizEpgDt+57h1Cbr5fNBJD1B7UbJX8Xm4/BQZWsjn3vMBs+9y9kKZjD5DrORqCUBKAxz6pwYgzkc3sYZdLIIg6w6TNi5iTQmzzd4TYOhbdwFPbR3039b6SD2OIZNij4xveg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(86362001)(54906003)(966005)(38100700002)(316002)(508600001)(5660300002)(26005)(4326008)(53546011)(6486002)(4001150100001)(44832011)(2906002)(8936002)(66556008)(66946007)(83380400001)(6666004)(66476007)(2616005)(31686004)(186003)(956004)(31696002)(8676002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU14VDR4S2dOa2lpU1ZnUktzQUg4OEtlaDBmbzVqQ1YvcHlTZS9LT1N1UjZ4?=
 =?utf-8?B?aXNjRklWWnBhdC9aM0tBSWJ0NXdpTElNSm9reDdFcTNoeFBKYTZsdnRWTU81?=
 =?utf-8?B?WERGbVJpZXJESi9RaXNFWUk5aVRJSFNNSDUrRkZVOEVKK0tQQTRPeEp3TUpT?=
 =?utf-8?B?K3RTRHBSa2tQNDAzUVRVVmhabmFjMU8zbldlcDhrK0ZJNUxCOXc4eEE4SjRu?=
 =?utf-8?B?emJIakF3eTlzdVhjYnBldnJ4THZtditSQlJEVy9WOGFObnhoOEJRTjlLSWJ1?=
 =?utf-8?B?S0pORVFKa3dDQ1YvSXdpdlBWNGhOSC9EQnhyc0tKMVVMZ2hnSW9UMWFxZ29Y?=
 =?utf-8?B?YXhPNFdIU0tsaEVud3JlamV0aDg0dDkrcDVtOEd1UCtMaEtSZHMxQ1ZxTXVZ?=
 =?utf-8?B?WWdsTldSNFZCc2dybkhZVGlzRHgyb3UwcG1KSjMrVEt0Nmd3ZVlucUV1OS9Y?=
 =?utf-8?B?WWtZNDh6ZWxIOXlUVXJETm4zdkZYbU9OemhjZXk0dThrMzV5NHZPdlh2enZi?=
 =?utf-8?B?V216V2JpRjVoSFpSQ2R2Z2VKa2VKZnRsVG1ncGVYaTNGL2M4WGxkNXBGRkhP?=
 =?utf-8?B?UVl1Q2c2RmJwQUQ5MU1BS3Nqd1BGVnMyRkhGbHdEVmFXOTlvdUc5bUZieTRK?=
 =?utf-8?B?dFdhbHNNNGtxSUxmV3ZUb052VVlYdERNcjd0UG16RTJaZGhqWDRGbUZqSjZD?=
 =?utf-8?B?UE1pZmpTMWVJR1RFb1lOMzJrc1lhb0tNZHNMaTNKSDRrR1RTMDRJTXNRbkJS?=
 =?utf-8?B?MXYxYXZhaUx6aThkSWVHYlI1SGxsUkozdGxWdC9pZ0JvdUdHZXllWW9yZjQw?=
 =?utf-8?B?RmlOR28zTi9reHRkOG5la1lyeXFWQkxVREFiUnJoN000QjVPQXZIWnRZNyt0?=
 =?utf-8?B?QXA4bGFOZlNYeldlQVJvUHorN2J0cFdPNHdZVEkreHByOS9LbnhiSmpvUWJC?=
 =?utf-8?B?ZVRSMGRjdGdtSG4zaUtnMmV2bldMYXFwdmdXYWZaeS94NkxQRGU2aGxHOHIy?=
 =?utf-8?B?SVhweER6YnZnS0xUNHNkWVlibUJqMXBUVC85cmNtdXgrQmQ2dHhpYjBNRU45?=
 =?utf-8?B?MWI1SnBDUlVScUROM1A3bXVDNkhXZHRrYzlaYm9MZUpvRWpDdHZPQ1dXTTdB?=
 =?utf-8?B?dkpzMUVHMFpmY2hZQmpaTG9WYWtzUGpLRVVwOWNBQWN3TXpPbGhZUkMvaVdq?=
 =?utf-8?B?YklsaGdNVHVPSjhoYk5IQnBESHQ5ZTB1VjFOODl1aWJidGc2d1NsNStVR1g2?=
 =?utf-8?B?ZFd3ZlNBSXBqYUdNVEJDRHVPS1QxNUVWKzhiT3FBSk9tVHZ5YkVBS01wd1RF?=
 =?utf-8?B?ZUczeEoyOEpuUEN3dGUyNkpSV1lyTkZJQUhpSXN3RElISTMyeEZoVEpGZEVm?=
 =?utf-8?B?V3RTbmMwb2V5WG1GU0JqWUJOcmhycUVLRmIycFlFQWVFZWNOdEpRbzZJdnc4?=
 =?utf-8?B?UFhNWFUvSi9yYTZKdEtZb0MxdDlzZ1NKK3A1K3NqMGxjY2dkcXUzZ3Zkbktk?=
 =?utf-8?B?RjJNcjdacHJiV3BnNmdUZlhYWjhlb09FZWlqUUVJR3dEazJhTHg4R0xuUjZG?=
 =?utf-8?B?QXRNT0dvc2Juckk0L0dKU2dHb1RQWVNCS1VnSlZXVzBjYmJ3L2VSU29SRW41?=
 =?utf-8?B?YXI4enllTnJhS05xVm45MWE4L1h4bUZVQnRXWlpYTGFGRUtlUGFTbFpSSlZR?=
 =?utf-8?B?VHZOZWkrQllvTVp4cC92bjgyOTczYktVNUU5ODcxeW5UOWQ3YzJ2MDNNSkhP?=
 =?utf-8?Q?Vu8pkdQiCeJcScmDKyWFXmH67C4bE6qYSFi/NcD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63302098-763b-4051-60b3-08d98d8e1ff8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 14:39:41.3209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dLG/+3EI9A/1A4lLnJ9+kQ0pDwwNXBhUb+2tQjZQxkCkC2X1nVc0MvznGKtCflSgAGkYs5Sykp11ZulrOddHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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

On 2021-10-11 11:16, Simon Ser wrote:
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

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f35561b5a465..2eeda1fec506 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10594,6 +10594,31 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>  }
>  #endif
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
>  static int validate_overlay(struct drm_atomic_state *state)
>  {
>  	int i;
> @@ -10601,6 +10626,10 @@ static int validate_overlay(struct drm_atomic_state *state)
>  	struct drm_plane_state *new_plane_state;
>  	struct drm_plane_state *primary_state, *overlay_state = NULL;
>  
> +	/* This is a workaround for ChromeOS only */
> +	if (!is_chromeos())
> +		return 0;
> +
>  	/* Check if primary plane is contained inside overlay */
>  	for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
>  		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> 

