Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA83C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 19:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B547910E303;
	Tue, 18 Oct 2022 19:09:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D9110E303
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 19:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCPscAL/o1VQU7UH2cSqviIkS2XRaK6hOZT6WvHgQXDwN+am0ElHNXQf/DiHXc0OLvFzYyabrZcg53bwf+TLTGxAITeiAmpzQ6k8jVATNFRTreW0Aue8QLLfWchTYpdf4lzipsqNcCfX+ojZPAV93Nwsn0RjeOAbosoOav8Cf3q8g2pSXsAEuox7KlwCZlx57axrpcmUjX2lhnfujSDxpRxChBKlgbV7CGilEUPfC+85EWsm4y+VXnfLxI/htcYdL4JY/UjUfJY4ulaHOIt0qjhr+MSKhKCjEP81T1JkjZM+ZR92vaypsn4LXzbD84IkaDjLjMjehIbUwXBhfXS15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PfdKu4BelZK3sGYmL7o5kp6eawvOP3TgpARc3ZGvzg=;
 b=FfH5+XW8QJuCgftklBsFCTaEVSVyAhnvtDKj261mMG3gwYcw3I6MV9dgilu4HKaRpiseGgWnZ7HbdqsK3BaeImBD2iq8X9H4IA6K/jlsfFk+Jj+cEz+5vZtsF39slc8kmuNitE6zJuTpImu2AzuHiblWOaQGY0nE3XaeALqVZfqFwXSkhtI+7Ogeg9mlYZuk9/sfYYHiltMKpEDHda2k3iqby2yA3Diqh7u9PZJr8JeOiC46HN3sIrjQ0Qcc2hjBzi3I7GQCZWdftpje7CFOgfH1U4fAflL2522CiqOMUHyReOGkNmdbnF/ps3LWi+We3+8VujMLUHO/MNkNFXmG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PfdKu4BelZK3sGYmL7o5kp6eawvOP3TgpARc3ZGvzg=;
 b=e+8kJBM5Q5c528gTnPwWcfi4+AWms6gljht+NfYHTJZuzzd5ZMJmmd9yPmX7pklpp82PogpG3+iFD7I8Ez5BK7jvKvi9LhQwK7fy7bowv63V/u24fZxFeAHD6zWIsS4OWAmonjmrYcxsfoY8PTshS1fQh70wmVqI0GE8Zj6eWOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 19:09:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 19:09:15 +0000
Message-ID: <857929b3-9e67-4d20-8602-67e41b64c7bd@amd.com>
Date: Tue, 18 Oct 2022 15:09:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 12/12] drm/amd/display: Move dc_state copy in
 commit_tail after dc_commit_state
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
 <20221018122826.1790114-13-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221018122826.1790114-13-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BY5PR12MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bfbd1f-bfa4-4477-bcad-08dab13c3fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+mq+bxh+DLue+vF5KqkOZ9jS/svfIheheguX48lxYcUddVqcen/A8bbCzW+q9BTHfbShzo1/zanJeDJdFmMtWAXsaueWKqLXvTPCHWt8YQT6ER/7iHUcBUZ8pWt+fh40IgvuE89nS/47FOqmy+jrkaKluW18VNiXATClHHryWrhvjpGB8oXcbJczLiamFeEHfK31ZTK/IEbIo15Gg31QjMr5YaFmYLPU8FMPXsblDj/yMzj6UIJlKR1jRuB1MWsvAQOnfv76/5Ma3FxRh5JDlUKeCz1+N2V0oY83QhtGLBIc+pCUalxekUAf+lRBNmONj7EMMVEsEMqTvz3SqzvUjW79jhkesUr9ENLgtak4eSTlzgcMXjOvytala3yBnq4nofZExzvUCsT2d+fzzxnRlLIQj7Hj53Sz1EE2DvHhonT95tL9yG832pJ6e5mCQmjt+oQ+dQ3b01nEJnWOaQntK9QFIAqs8PADxB4MxMKMfFBBFK49VD4kifdxDpVDg2RUCRppE9kx+vMcZFiEi3qbIJ3Jg7DRcKIoVyl7gnLv52kqvTGtepHGFKl6jeYC/wAAkUnVKCF7phNbJ5kWhB32+KrEGmz72D7mQJ/q5iRYu2G7AyFelJJyYDD5EdfeuntyPnS+zXA9OilCT4lHoIePdAch2pG4YKc7Klmo0Fl8OV7p6k1lVX4Llc4kuQjk25jzMr1rXN+zJhMEc+97TJDBEAB5O4qkX1+ewbPhbjs31b5ouoI72bZD577qfGYY04IA0F2D7Ow0OQa+xnSlKxfA5q6vxP9J291ny9SiQAylKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(4326008)(66556008)(66946007)(66476007)(8676002)(54906003)(6666004)(2616005)(316002)(186003)(5660300002)(44832011)(4001150100001)(86362001)(2906002)(83380400001)(31696002)(26005)(41300700001)(6506007)(53546011)(36756003)(6512007)(8936002)(31686004)(478600001)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjJsblNjaVcvL0hBUit4QlZGNlJPWjVVMUxsZWxlQitNQ2Z0WktYeEVCL0Ru?=
 =?utf-8?B?S1liVGVOMlNnNGpmR0hGS1N0OUk1V0J0WnFEKytJSi84YllTaEVCUTdXL1dv?=
 =?utf-8?B?eXJZT0QvdjlVMzcxZkJHYTAwZ3lRZlBOcHlYMFRGZDE3V2c2ZHQ3allDcTNj?=
 =?utf-8?B?VmdhMTkxSitXcDBpTG85eVcxREtpdkNXdEFmNE1WQWxoelZ2TWhuU2paTmUy?=
 =?utf-8?B?YWlnSERXb1Z2TVEwM0hBVTR5RHlKaTBFVjF2K2g5V1A2cExnV2JjbDI5c1lZ?=
 =?utf-8?B?a2Y4QWpieHYyVEIxTy9kaGt3QjFXekZWaXNzSjM5MUx5bURZQStpbHpteTFz?=
 =?utf-8?B?RXEyZnhlaDBQNUVtc3JBeDRpRVlWa255UHNmUEtZb3R6T2lNbVBVd0M5ZUVz?=
 =?utf-8?B?RGNEbXR3alR3WnRNUDl1MHcrR2xsT3hSL1c5VThpYUZxMy8xSGk0SHJ1RzBZ?=
 =?utf-8?B?b0lNdFBienhVTCthY1QwOGRobTkyNGxmczhjcldrcmhWRjNLdkJUais2K1Vt?=
 =?utf-8?B?WUxuUzkzUUVXWFBmb1hpVlFLMFo2UzBiaXR0bUNkZ0hmdGFZMkFmVDlyQVFu?=
 =?utf-8?B?bHlZaDJVNW1ld21mOVcxM0wzUmlFUXBUcWFLczdXRGZpYmgzMWV5T0x1VWZv?=
 =?utf-8?B?a3pXdVljWlovRnQ2UXVTZ2M5b2J0YTJlNUNBVjRRK0o4WnFIUmJHVU5jMUk3?=
 =?utf-8?B?RG1ZanQ3MFlrc0d0T29DWnUvYlo2NEp2NlB1Z1JzeEVXTUZaWnJ1cFZ0clhQ?=
 =?utf-8?B?blZrRjhrd0ZNdHVtcE1HL21KWTUzT002UENhQkpaeXFlekdleEdTZHhxU1ZI?=
 =?utf-8?B?Ym1ubU9kVkw4a3dLdmFNVjI0cjJ0bU9ua2tMSU10eE1BOFR1dUVsVkNrN1F0?=
 =?utf-8?B?aHdlMlEzNUVteGR5OStLd2VaRDcxMVBCUWFYY3BJS2liNXYybWxPYUFjdFI2?=
 =?utf-8?B?VDdCdEFBblJxM2wwMGp4eGZ0T1ZRbmVRQ29YTjF1b3d1Qi9Mblg1NHRCNmx5?=
 =?utf-8?B?UkxzRk5aUDM4WERPTjJyeStGMnVrOE9iU0phMzdtUmVEMklBWW95bTNDdGU1?=
 =?utf-8?B?VmNRMHlBVnlGU1BpODdmcGJKTlhRQlNhT0NHQmppaWd6VjAxYjdkY0NCZGhJ?=
 =?utf-8?B?dDk1MXFwMEhpcXRXNnFTeTBEbll1K3Z4MjRzd0VCNHA0aWZuNVU0eHpvb3Ra?=
 =?utf-8?B?UWxCRGhDN09OdStjZXFYMFpqelN6UUFPUVB5TkxzZUl3VzJtZFRsQ1ZHY0ZB?=
 =?utf-8?B?YmVRV1JqRURkNi9YWW5RZStlVnZvclBETkxJYi9nMUM1NnBNVFpNNTVmUzZa?=
 =?utf-8?B?d29OaU1mYkw3UXUzY1JETnhYSzhENm5yLzJ4enZIMlhCeW9nVnpMMURSdmVG?=
 =?utf-8?B?Q2ZNWDQwSzBVZVAyNjVxc2FqaGYvYlh2RGdNL2l2TENQQU1FNUo0ZFJiOGdO?=
 =?utf-8?B?VzlrSWYrMjB3VWFsV3VsZ2xlR2gyb0dqTWpEdk56WFdwZ24zM01hUjFOci90?=
 =?utf-8?B?amJ4QVE4a1RUaDlIbC9pMVZwWGM1eDFEM0NsSGluNWZjVkpVOTBOVkl1T2RP?=
 =?utf-8?B?YVlCK1FNKzk1RFJKaTNkSXZON2RzU21ZcWVVOVVybFowbnFJeE1ZVS90OGhV?=
 =?utf-8?B?cjVVK0d2UzNTR3NyNmw5ek8vVmt1K0RHK0lFNExBRFBoQzJGMVhYUU9GSVEy?=
 =?utf-8?B?NWxzL3JmOXhacFkwejRXMmhiaTgwVVpCblFyYkZaSEdTWUptWFpFblZrQ0JO?=
 =?utf-8?B?c0U0VUdvb2JKV0RxbTNRNlVhNXdGSWRrbkVZT0tIaGttLzRQR05lZml5T0xa?=
 =?utf-8?B?bWFldmRoRjFLa3c3T3pCSTN6a2pxQ1NhTFFlRGs1WW5RaWJnSDFsQlhnOUhF?=
 =?utf-8?B?ZENGNm1XNGVTb1RQSlM0UkNnQnNaOHBJTEN3YmdsMXU4a1IxMFMvYlZVR1Nw?=
 =?utf-8?B?VFJKdk9zcjUydXJwZ0pBa2EzWTh2VTJWN2xuS3VxR0h6MkF2S0xFL3E0dEJR?=
 =?utf-8?B?c2YzTjgxeUtyTDIzRmVrYk81VFpxTjhZV3ZLVkt5a1EyaWpTbEFGVjdaaGhS?=
 =?utf-8?B?cnF4TEZ4QjBDRjJtLzVyeXhHcnVvU1dKSWtLaDFkZnRBakdQTGxMTFR4ODZy?=
 =?utf-8?Q?G2rxxsjvn2pD5ZGy/zpETJJJJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bfbd1f-bfa4-4477-bcad-08dab13c3fe3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 19:09:15.6889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F69xVlLIsw2KED4dQt/29pFl6O1bAyQV3BXLBJlAjlomA6BsD+FPk5jmLk+RHfas0PLmJPchlJvewRs8063+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
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
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-10-18 08:28, Rodrigo Siqueira wrote:
> From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> The SubVP feature introduces a new mechanism named phantom streams,
> which can be summed up as a fake stream used to calculate the required
> parameters for handing the cache request and cache reading for a small
> portion of the framebuffer used in the sub-viewport. With the new commit
> sequence, we do not want the state to be copied before the call to
> dc_commit_state() since this leaks the phantom streams into new state.
> To address this issue, this commit move the dc state copy right after
> the dc_commit_state() call.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 63f076a46260..17a9108f8186 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7999,15 +7999,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  	drm_atomic_helper_update_legacy_modeset_state(dev, state);
>  
>  	dm_state = dm_atomic_get_new_state(state);
> -	if (dm_state && dm_state->context) {
> +	if (dm_state && dm_state->context)
>  		dc_state = dm_state->context;
> -	} else {
> -		/* No state changes, retain current state. */
> -		dc_state_temp = dc_create_state(dm->dc);
> -		ASSERT(dc_state_temp);
> -		dc_state = dc_state_temp;
> -		dc_resource_state_copy_construct_current(dm->dc, dc_state);
> -	}
>  
>  	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
>  				       new_crtc_state, i) {
> @@ -8127,6 +8120,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		mutex_unlock(&dm->dc_lock);
>  	}
>  
> +	if (dc_state == NULL) {
> +		/* No state changes, retain current state. */
> +		dc_state_temp = dc_create_state(dm->dc);
> +		ASSERT(dc_state_temp);
> +		dc_state = dc_state_temp;
> +		dc_resource_state_copy_construct_current(dm->dc, dc_state);
> +	}

Should this simply be dropped with the new sequence since both
dc_commit_streams and update_planes_and_stream_state (on FULL update)
create a new state?

I wonder if moving this will impact the old sequence.

Harry

> +
>  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>  		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>  

