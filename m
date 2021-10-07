Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB9BC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA68161074
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA68161074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3C16F49F;
	Thu,  7 Oct 2021 14:28:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4F86F49F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 14:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay0k6/GGCe4NgGs9DKYCGWR+1kw9QNNjL9gPVS/MYyNQe9243cxUn7tRZOW1d8JxcDCsbbP+x/wfKxgNvVAM7Qf9ekAzm26iO5QPLXCEP+dqxhHRF44LpbVxVE6ZROf1Wl+JeU1kX1+wPBDGwrsgOBXagk7leMlC3PT0W1AuH4HBkvTlJqAyWWRSdMjA82QMQyHruW6fVpf2eQ6sK7QI/vYuXnkWetxg/CL7QMfjQvuQC2vfuVlV+/pLibmzXIHwJ3Uylz2HCoBIWMwjWaK4eDhXlO4o87lU2RZPIUQ0thlwj0ayA1QHzkNupR7j+d5jVWZtQwZWOeQG7vIycJWGWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKXRauLD23EE1AUIbow1xazlFsa20pTp5FpO8zuLvJs=;
 b=c0bvows1QMg2zbRpq2LwgSjg5uDhGGfqiDuVvpBa2Gc9xuCN8YXM97o4kLDufDr3SIthY/uXg2Sr6SUnjGOGw9Dj84DuU1SYhM/ctVv780IymJKbJiYSyIJfFj4dsRhW5JpaTn9ZCWeaC/m2VDD9wmNbBkeO1EAiTP+G2mKnXnD4sKL1ZeIxLVyPrWN1rxjssprePpfC3E09vDZ/zWbXGd8afB/GuhDmN/DgpJLAnK0OhWdZcBYWaP7y8XdFQz6icULxZeR27V/CV5iHLvI5lIvXzBrZ8RuajYcox4BfO0wYGldtmRi2aEi9fS2N42g0NFoFviwO//iDPY6mslHdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKXRauLD23EE1AUIbow1xazlFsa20pTp5FpO8zuLvJs=;
 b=zhD8s4wSSzyM68i7dNoT8MOSrBMr79h3RCi+cWwI3R/93nhGyjWeKGP1WuvOLtsDLh+PlfxQtHZHItBWhzMMFu6z8cuhfr3IERUx1XBX8EtTKUgwRp9H3AmN0gQnSWpD+DeJpYZ1vEVIKdk28T5TVphAu5oZwXQWAN4TeF2QFqI=
Authentication-Results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 14:28:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 14:28:05 +0000
Message-ID: <a0999a42-1e0a-0d6c-af89-f8d52d9c445e@amd.com>
Date: Thu, 7 Oct 2021 10:28:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH v4 2/2] amd/display: only require overlay plane to cover
 whole CRTC on ChromeOS
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sean Paul <seanpaul@chromium.org>
References: <20211006140558.254349-1-contact@emersion.fr>
 <20211006140558.254349-2-contact@emersion.fr>
Content-Language: en-US
In-Reply-To: <20211006140558.254349-2-contact@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:408:e1::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.47.177] (165.204.84.11) by
 BN1PR12CA0009.namprd12.prod.outlook.com (2603:10b6:408:e1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22 via Frontend Transport; Thu, 7 Oct 2021 14:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76261e8b-7774-4753-48cf-08d9899ead3a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5459499877A783F75148C7A08CB19@CO6PR12MB5459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luvQ3NGcomHvXc+BsznSJfcXOm3HJtP7iHaWsK1Z64B2nUVwJCzA5TauGabBFpQ4/Gj2nL/8m//cqFLh3oyarKCzLS+YNgVPAiHFbnzzt0BMCNkLNGTVyAw6py39Zv5qo5MVw26B05LU2fO2aSxIFZANRlOs/REuG+46lVEgL0gLM6R0/5fq+jrGmdQFKgKoKOoNWlb/EglJ8q6Lx8b29YIzUdRM5Rue9zooX37y/qhNyGXm7u/nINifnGY9qhVaDSbCLNFBLWyv6c9QXhmbp5rceC5RJtnfdmLwccZTM3XPG+rM4XgBhUBaiCcjPwnCefvlmFUymUl9VEzNWR9x05qjK6IDm5eXMmYOkXZfWQzS3RbwJzQpaSJMgbv1itC0+VlUMtPUi51G/qgi7iVpSF5YftCLMBaUZAzAuJuhmqhYlW7IhHihufA3ejD5RZN7WqnOsfxy0sYwF8F3X4xVp++XNdFbyY/qXuDfUiwUI1aqUg+PVDB/W+kp/n12x+/9J8gTj1qC5cghZpCUnNdroslA3LYSjgur1NafNOVkGxh2WH01S+SVazEUN1duSkZe3ryakSZx9vnxAS7VsbKuZnhHpvdhHbY513+mX0a6apiAOA1aNl20eKateiJ8q54ZZZR9SXl8fHQcN4Z3QFBkap96u3VrATovbuZfpVaATCEORMHmwvQ/ZAYko3SVD+uUM23n1SQkpiiTRQquFLXe66RSulzwEorn952T+Fr+EHbJcAavnT+uuQuD2lObeCOlUA5p5TP0dB/Fz96EqcPEGdrTRX2s28107Uk6ng9u56KYhCp7o9QsNttIdYXhc1s0xP//Axm8GN51IWc8MQrb5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(6486002)(86362001)(31686004)(8936002)(966005)(26005)(83380400001)(8676002)(508600001)(316002)(16576012)(5660300002)(54906003)(44832011)(31696002)(2616005)(956004)(53546011)(186003)(66556008)(2906002)(36756003)(66476007)(38100700002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3lwR3RzNWt0TlNpYzN5SDEvNzdrYnlnQWw4UkJvWU9mZzRrK2k4UW9ScXRU?=
 =?utf-8?B?Y2lXZEk0cHE0Rml1cklvNVJ2cU5tcklmb2x2OVcyRjZkbzZiR09OeC83TDdC?=
 =?utf-8?B?YlFOdFpNbFZoZ2tvYzBTWktaaVROYmUydzk4TWVCalVJQkk0TEZlQ1JmMko1?=
 =?utf-8?B?NjFRODVrdVl0V3FvS2ZidnllVGsxdHY4M2JEb2kybkZlVjZoM29SVTUzdm90?=
 =?utf-8?B?TVI2TXFialJ3ZC9GWHorSUpjekp1c3I4UnB6dk56VlRFV3d2UGdxbkg1WXNM?=
 =?utf-8?B?MGpIcmF0Ulo4SmUwRnlmTDhrTGxzemtmamVEQlIxR0NOYk1BR2hOT2NocFdp?=
 =?utf-8?B?d25GalFBZFhkZ1hOZjRFZndMVlhmaFlUNWZTTEdvR0FOVkxUdUdZcE1xS0tl?=
 =?utf-8?B?UldxbDlHUHVZWjJJdWZKeXN6OFRoMjlTK1h4cTNKVTdNQ2hnTG1CMDRYYXJQ?=
 =?utf-8?B?WUtzWSt6cG0yYmlnSHIwNFBmNDhrUXJJVm0xbElTZERxb3dIOWxLZDAveUl5?=
 =?utf-8?B?YzYxak5IcXpqcW11UnhtaUQ2VTVkVE9EenE1ZHJqd0RTRW80YlVscVphQkJ4?=
 =?utf-8?B?aUw5amJ5VzlMWU1iNmovU1FPMkRYaEd4U0w1Tklhd2ZIaHNid1JPYVFkRkI2?=
 =?utf-8?B?UDV0dmRhRGVFOFdOQzhnVU9tbEQ2U21wd28yMDhSL3RINk1vaVBXYzgvMmVQ?=
 =?utf-8?B?T25iaUlpZFJMcHRkbDNmUzFZbHplYTg4aGpCNm9ERHNJT0RpcmdzSXdHZHgx?=
 =?utf-8?B?MDMzMzQ2ZFJYck9XeHRYcG01Q3lCZ09FNkI3SmRYYkVLOXlHQnovUE11cG03?=
 =?utf-8?B?d2VYSCtQTDVvcTR1Mk1QTWtuN2FITGtLN2k0VzVvL2I3ZVpaNHVPKzQ3Skpy?=
 =?utf-8?B?cGNvRmpodFBKK2ltYTJQL0txSHpBUFB2d1N2YUtJRlZzTW9PNEd1ZEMwYUVF?=
 =?utf-8?B?RkM4NmRwaXlkV1M2VW9HYUVQRFo2ZEFLZG5DdzNxRWQvblA0K3JFODV0cDdF?=
 =?utf-8?B?QVVob2pYbXcydk5aYVIrKzVjS3d6YzdvcVpLb0UvUHlkaXI5WXFWdUs2U0VY?=
 =?utf-8?B?VmRxWk14TFJHeEdtRGtXelVZM3VUSFA0SVVKOFhJT2dFeEMwbzVGSklYdkF5?=
 =?utf-8?B?eFQ2VThCNGNkOHArWmZQZW44TGhwWnY0Zi9Mcmc1UUFIUHEzQmpyakNnanI0?=
 =?utf-8?B?YUVZKzFJZStOQ2NzOFpUN3NaTkJSTlVzbGY5b3RYMVFIZWxZVWx1ZDBrZ25j?=
 =?utf-8?B?M3JmMVB0YWprL1RDYlBpZmtVYUs4Q0JqeFRldjhUdEJGc2RmcGFRamxWa3hn?=
 =?utf-8?B?SzF5U2FYWUh3RGJNZmVJTW56MDdjRTZ1Q2VzREhxS1dCMWpDMERUczI3K0VN?=
 =?utf-8?B?b05nZ3EzczkzNXVROWRpUVc5VFJid3dhRXZlVVZsaFpyK3RPTUVwS2liUkVR?=
 =?utf-8?B?eUQrVDlzZ0hKT1J3cDFtOXgvY2FnN21xY3BDaUtoTGNwTlhSbHQ5SEg1blVu?=
 =?utf-8?B?RU1YVlJMUUtRMkdzQWpUYmVFcHdabDZEblVLNmkwWGkyVGtlWVhlRmd1Y3hP?=
 =?utf-8?B?Z0FiWjB1T0h3T2xWL0g4d0diUFp5M2k4UW1rZDlmeDVibWlUNVZzbWF4a2pl?=
 =?utf-8?B?WlQ5VzNZRjBFR0ZKc2RSTXNHUFpveldlcTdwL3ZxenhGZ296bzQrWmVHcGRz?=
 =?utf-8?B?NGFldEdQNnVsbENMM0dYbFl3Qng1aFg5UFcvZ1VJZmpmVnJaSHhETXpadjFq?=
 =?utf-8?Q?m5IJrE2Keqyr7QgXI3Db10nEq3M5oG+Tqq2l9Du?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76261e8b-7774-4753-48cf-08d9899ead3a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 14:28:05.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbU1Q7c5G9AQ+lP634c4vRwAzRu301bKqP1nob1taPnFqdi9qCU/DzmHTwUMtxZ1pe0bjAoAiHRdLj04Us3AdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
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



On 2021-10-06 10:06, Simon Ser wrote:
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

Just checked on my Chromebook. This will work.

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

and merged.

Harry

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
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5746980454e5..0b80f779e706 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10595,6 +10595,26 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
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
> +	exe_file = get_mm_exe_file(mm);
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
> @@ -10602,6 +10622,10 @@ static int validate_overlay(struct drm_atomic_state *state)
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


