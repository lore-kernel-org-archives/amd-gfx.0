Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A972C54E41
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 19:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0059911398B;
	Fri,  8 Mar 2024 19:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aTd/xnkC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A61B510ED26
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 19:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBSZAlEJyb3De2X0SqknwMoZZviuEiv6TR4G7BgqkzNbzrUvJzA++t+/aCljQAMGCyJhUhEOWfnH5D2kvy11B7GlpI5v1F1zEJeUAtNk0ROLChPIRGL41dxA4mizn8AFSzytetFJ6nFi1sgOUm4bKTx5UQMNkul7F3KU7zCn1/I4b658JAbM7E9aLMcDpcQeAXjMenCMd1jZP0/x+FiU3BSI87WHTlqkeC/fSwKNRtP/HH2XJKG7vK2YrkUvvSPPXgzJ01Int4veaSW4G2jmuoAryItayNb/mVQf0VqqgQvXbPa+ulKFMoFD//GLgLY6PjoI5tyYVwsnptxnxSJIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWJea9/1Cw3Tma5MV8pOBIi71Jup7P2L4NaLsM+fM2c=;
 b=RJTJQFm2JfTuvgjk0eV+Rbvh0RjupDvi3RQ6QUQNp+cYijgNs1rfRt8Qi7KSUICXz97slcUktVe8LMD291+5KcxSXTiG+cqAjdcXKU946gmAEscpgWOFSE/MyAFnYa9bkzCb3yjh4UWdRSjOBGhgps4SjmSGgMAbg0X8fahAlSgVCu9nF7DFK4stegpmjsrugYUUsGNSRezG4hMkAfrFCh0mNkjZR9Ma/71zPLMc2vCjn87GzOdKY0DvJdrn7gH988Rrrg3CGSMNl3OQ+h/iEJg8ozGHVu2TCfTai2egINJf29sqx/kqZ5ps/gK2PagKNRSA6YMLiD5LMPhHl4VPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWJea9/1Cw3Tma5MV8pOBIi71Jup7P2L4NaLsM+fM2c=;
 b=aTd/xnkCaxSIIS91qSBdey5+uiZ1z9IgY0ElDNazucnMynMc1jMmZDuSMfyZAcOmK7lbV5rX0BozEmKLmZtXrkNHbXOzG/HYqlIEmZVFYszJ25xuKBkFu5PesuuhNFDmHuKPryHIDLItn+yS4L7RqxpNwxZGJ/L7m6890EBVs5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 19:47:59 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6c3b:75a3:6af2:8bf4]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6c3b:75a3:6af2:8bf4%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:47:59 +0000
Message-ID: <46657fa4-630e-47a5-a339-242ecd5ba2de@amd.com>
Date: Fri, 8 Mar 2024 14:47:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Use freesync when
 `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240308194057.23494-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240308194057.23494-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 862c485b-12d9-4b43-9f5c-08dc3fa8a8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvgWqFQ6Of1otBm4kOOxfRsO/xJB8k44BSzEpOsIp76fNNV6WfKPeQQ/SgGsnzoddSdIDnOah5+C990+XQtfszcOCsjHMmTqlQE7BP1wQWNoCsb+S3vOOOgtAdctxiZCHIWdCdEheHD7RtRa6ecYhWcvRZq8C/9Ufmgpp+D2P4XKB8iZmjephnRvsqBNSTL/TZZrpOp1pqTMnmma9Wt0K9Qt7X8cwTkavoyPPor3HlObDPYmOFk4Dh2a1fjtPtOSkOoA3IO2xYFkQNTUVZkkF0MwDiGJWllDXcu1H2eQK2Ck2nRQqL5ufj60dDockt84v+SzaunRqnv1bVdrK2Ib2mcg3kxRqeZ7Jn3u3sye7OrFGE3KBT0cS+ZjKhl/OaOHHzrOd+89BbuSHUexEvx8hdiizgBGqQE7tTHL4kx5BGy8KBXiAzqtoXTPEDvizwfMDfpB7cpnAXQ59nnHbsvepGekII0wGZ+Baab46rLYHgA8gh2bRuFa1A/m5UqpUJIPam7PPPN89e9cN8D5mlfD4mNpDd3IY8Le+Ea2jCS2K3JZpVPztG/1TjN4MC5DOcb6kVIKpFCF1t6LwcYq3xdg7m8MbP5dpdH+X8iT/OMbEtAHVPR3uZWXfCWpmXUy5HJW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RXSVg3YTJVU1UxdDFsSloyL1k1emlQWXl6Mm5aSTlGMTFOVkgzZjB1OHVj?=
 =?utf-8?B?WEpWaTZvU2lSNUZjYmNXWkZka3NOS0VPQmdzZ3AwWG1KWStvdGRDRjh6dk5r?=
 =?utf-8?B?LzV1QlhNZlN1Qm5oMW9aWm9SMXFYeGxtbGFXV1FBOWVISjJ5VzNmZFYrM3VG?=
 =?utf-8?B?dDdUSE5QRjBpS2FHUXJ0ZjNaTjFjbHM0enVDRTlDSzlaSWljQlg0NEppTVZG?=
 =?utf-8?B?S0ZuNWV3cTQ2L1N4K09kemU2NkR3VUNNdkU2cjV6aVZTQ1RkT0pCWnhzY2dX?=
 =?utf-8?B?d3M3SnFkVHBMWnc1NDJlN1F6Z3FHWEFRWFpxdmptbzAzbVRhT21ERis0Uytj?=
 =?utf-8?B?UTJZSlpFVklNNEl1NVpyOUJGVXhOWmc3d0VhbGdSMlhIdWR5NmEwb3RwMmRB?=
 =?utf-8?B?L0JRYm1SaXpzbXBOcGJCZnZNckg4N01BVlBTZXFGTDRGTTU3Z1VxNXM3dFZL?=
 =?utf-8?B?a0VJZHZFU2VTTlpubDB1SjNZeXB3a2xkZ1hMYm8zOVZFOXAvRWZPMVdwYlRO?=
 =?utf-8?B?V2IxSUNJUWUzQnhTK3VNYWFwSnNRYzkvZTYyWXFDaFVKVjBScngxR1JRejNz?=
 =?utf-8?B?d2gxYXFsUlRSQ2d2VHdOaERwbGllczRJZUVaVllHMkRHa3E1aDJ3Q0hEOHlk?=
 =?utf-8?B?VTZ4YWx6eGZta0xEMlZHMzdTZUs0U2pjK1ExeGtJVEp5WkVwSTd5Q2hvU1VE?=
 =?utf-8?B?RmQ3bFU0TUhhODdhdVlvZFUxallYZlYrV0tlcWZQemxibTRFSHFLWHdqcGV2?=
 =?utf-8?B?VGR0MmQ5STdHM0dhS3VKWnlqcnNmeElBL3RqczlGSW5xYUtiN05sZEhCcDMv?=
 =?utf-8?B?a1FKdERWaFowVnVTNGRFUFZqWmZVaWRoSHVMU0t2S2owU1BWb3BCdXF6Ymxo?=
 =?utf-8?B?dDBDeTZNTEttV0lwcmNhWTFQa2hYL1NXMVBjZU1rRGs0Z1FGZDgwK1BOcVZB?=
 =?utf-8?B?ZHpXNWgrU0xEZW43anBlOEtDZkVkdTdmcjBHZWtOVjRZU3VwamRZM2FrL0Qw?=
 =?utf-8?B?SlRkS1ZrV1FOdDRtWFVJQ2FSaGcvcHRsQWZJVXVUWHc2N2x5dTQ4R2QzUUVj?=
 =?utf-8?B?T0NORm5PMjFrVHZwVFZ0TzFYTndld3F4MjV5RGo3WmlmMTcza2M0WjJMNzlr?=
 =?utf-8?B?UzRaZjdQY1pyQy9ZRENnNm1EVDRkVGNaUS93MlRRTjZ3V1V0N1V4ZHg1OGsr?=
 =?utf-8?B?bFRnU3dTSXJ4UFExbUtkRndXOWpBcHRiY3pRNFowc1VUS00wT2pnWmdpOC9k?=
 =?utf-8?B?RVFMU2hmNHQxUGZUckx1UEpFak1hUTFVaUs3WjV4ZUFzU2FXTEVNWG1jaVd0?=
 =?utf-8?B?RDNpaC85emdJQkZKWGxKSmlQUXZQQjkxM2d2MzJMQksrU2xtQnV2TktyanYz?=
 =?utf-8?B?WmRySEluZFU0czRsSlRuQ1NheUhiY1dwc242dHVsVUdJSDRJY25WWHhDaEta?=
 =?utf-8?B?T0daSU03eWwwbzNLZHlUcW9jN2kyTjdQMVNBRlpiNzl6d1ZRRHlYL2YzN3Ra?=
 =?utf-8?B?RURFRTQyV1FHNUpNN09IU3VuQTFUL05KTTljUzBSd050NXJCMFIxL0k1ZjN2?=
 =?utf-8?B?M3IvNnp1bWhFNVF5SGxFcE1sL0o4TGpRaTZVVCtjNEZRMTFjYkZ2bnZHbUNP?=
 =?utf-8?B?TUR1S1FGTmNzMWdBUC9qMkVWS2VXUEVyNmJyMDZIK1IwUDdJbVFYelRzZjhW?=
 =?utf-8?B?UEdtMGI2clhNZ0hTSlVabVFoMWxsZTIwQ2V5NFhXM1BiSnNTOUFPTnJCb1RT?=
 =?utf-8?B?S2llcFIycDRNa0tCQU1vcVhQYU8vb1ZKQVFLR3NvTmg2VlMzOGRxL0ZjQ0U5?=
 =?utf-8?B?b0huWUNiWnFBNFJOVEdySXdRUTdBMnZZYzRHNlhPQlh5aUtkaXhHaS9TSmY5?=
 =?utf-8?B?R2djblVGQ0R4RTFqRHBXRW5YKzhmMjNDcmNhbmoyYnQ4eUI2YlVTb1NqZ25U?=
 =?utf-8?B?VGFScFh2NW9kNkNTYUd2UVFaeHdYUXMrazJhVlpSTlRYZ0VNcVZlNjFXZTB5?=
 =?utf-8?B?ZVRITmtIS1czRnhRUmJtdlNRNmFiWWRaamhtWlpZMmZjZXFpVVpVR1MwRTlW?=
 =?utf-8?B?NHRwOGFyck53YndNN0dWMWpYdTFLRG5ZU0RmVnNqZjdZTGZuRzR1WWQyTEtk?=
 =?utf-8?Q?0RX6fWiY6Vd34uyijAJ5sBswW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862c485b-12d9-4b43-9f5c-08dc3fa8a8a3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:47:59.8007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yATcgYfZARKWrhJEbkacUuGu8YoHmGKvFgb773fuz+X/88wgvH1koghr4ULIYQ1QyM7wQYyuBPXImaoF5ybNQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

On 2024-03-08 14:40, Mario Limonciello wrote:
> The monitor shipped with the Framework 16 supports VRR [1], but it's not
> being advertised.
> 
> This is because the detailed timing block doesn't contain
> `EDID_DETAIL_MONITOR_RANGE` which amdgpu looks for to find min and max
> frequencies.  This check however is superfluous for this case because
> update_display_info() calls drm_get_monitor_range() to get these ranges
> already.
> 
> So if the `DRM_EDID_FEATURE_CONTINUOUS_FREQ` EDID feature is found then
> turn on freesync without extra checks.
> 
> Closes: https://www.reddit.com/r/framework/comments/1b4y2i5/no_variable_refresh_rate_on_the_framework_16_on/
> Closes: https://www.reddit.com/r/framework/comments/1b6vzcy/framework_16_variable_refresh_rate/
> Closes: https://community.frame.work/t/resolved-no-vrr-freesync-with-amd-version/42338
> Link: https://gist.github.com/superm1/e8fbacfa4d0f53150231d3a3e0a13faf
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> v1->v2:
>   * Use is_dp_capable_without_timing_msa() as well for new case
>   * Move edid checks up a level
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5b7293da5453..4e1633a18f2c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11233,18 +11233,21 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>   	if (!adev->dm.freesync_module)
>   		goto update;
>   
> -	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
> -		|| sink->sink_signal == SIGNAL_TYPE_EDP) {
> +	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
> +		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
>   		bool edid_check_required = false;
>   
> -		if (edid) {
> -			edid_check_required = is_dp_capable_without_timing_msa(
> -						adev->dm.dc,
> -						amdgpu_dm_connector);
> +		if (is_dp_capable_without_timing_msa(adev->dm.dc,
> +						     amdgpu_dm_connector)) {
> +			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ)
> +				freesync_capable = true;
> +			else
> +				edid_check_required = edid->version > 1 ||
> +						      (edid->version == 1 &&
> +						       edid->revision > 1);
>   		}
>   
> -		if (edid_check_required == true && (edid->version > 1 ||
> -		   (edid->version == 1 && edid->revision > 1))) {
> +		if (edid_check_required) {
>   			for (i = 0; i < 4; i++) {
>   
>   				timing	= &edid->detailed_timings[i];
