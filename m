Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7F4EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 14:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B5E10E207;
	Mon, 26 Jun 2023 14:08:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E86710E207
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 14:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEk6Wt40/LUvzsfCe4MqwdSgoQd5iuXfZFmKXn7tr62A3gUQb3c9AqHFq9tlnvDmIjZdvhVDEOhFKCoGRl+Wbv2IGSUxlXDwLx9OTmZh8bP2Cp3W+W0w0ylEUR3dJrhb8b9055ZxEaktpsjBuv3jm/lIYy5lvr9HWOXnGu+vvUlwLInHrfhj68TA6M+OWPhY0R3/ZKe2LLLG1LD1T5JPSdJtgEbAWdavWjTkWA5CmxRwIPKPr4d0E05tSFmsAvESpcQJ24DDAHVO7E2w8UGruHy63puK5X2Pd40/LCKL2CzuZ+ZLJQZMqp8rCzfjJk/b4M4V3WD13xgFtT+0T2wZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vypERftTwOZ/wD7zDnQhNT3ucLqdn/UDSFVE1jZ8pN4=;
 b=EeXYhC2iu0f/C5aMqih1K3tPKSZxZ8tIjiLSqUna2aPzSyJuCGngMMcNPUMTGskClXclYM1DfBXd0k6rA27xpn1RjHlVowgoGCnbmYjMI5lppRUQscQRGtpD89L7wVeRK1zydDYYD7SFkppTcySm4mZzklUJSdKNwN1sRlQJRQGlkEXkTr27tlt5qxaC1zpbeyjZTicmwVyGlxtYheFSNNz0zLN65BfOgcEKbTMXibm8cKw72HXUfotOtXuSRNm2AcXILzgFpvrN54XD35CEkgTx8PPzGWrw7tN3trl7TrnuvAAQ4pThx+tZ6XO1tPnNK20UZH2ae0Hdg/ADYBxfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vypERftTwOZ/wD7zDnQhNT3ucLqdn/UDSFVE1jZ8pN4=;
 b=jX3xIaOXPdPOhR69O++P6bs3yyl9CwoqZu1OvtOLQ9oRtEm6XAwD6SSvMIIrBjmWnUhvUIatXGgWKtYgPgsreoi0reiioYvwAQOQg3WXiGh24eR/4glgxlxOXE3VQTR5p0KyvA26ITPbVyYcF1tvNHPyE9YIndmP6m/tlQYcTYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 14:07:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c%7]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 14:07:56 +0000
Message-ID: <187d1a35-956b-f90d-75cb-727f03565b59@amd.com>
Date: Mon, 26 Jun 2023 10:07:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: Clean up warnings in amdgpu_dm
 _mst_types, _plane, _psr.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20230624034950.1231279-1-srinivasan.shanmugam@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230624034950.1231279-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0261.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 30abc943-c4d2-4abe-d51f-08db764ebd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvE96ffSZUaX2w2Di7yHGrPhKwqSXOntZgJ4d669sNMu50vNhPYjOEm5siLOfT3Ckwaep/LMEd4uGx6BsVsaHC6Xe+h2erZZqh2XMzFzqka8Gs1JBQD5zwwUwwEguqDl+cF4vadSuv2kw12LWsw/Y+I6O0ai1Uzu+U7nEeT+JDndvHTTclk+kNti2QWlLfmfTYTFt+suuXa8JfncGqK2gW4RnVdGVxWgwRYZxP3Ds7CtDInGsuDsyiCWo5Dxz/krzmxG0IlQfaiBr0zngTSWD+lE3rsfqV7cH4e7iOTugJDrPV4IFCZzgeSiwwMsX0MoXRQaRDAfjWekITNJs0kWX+G8I821GCYG4wxSnCJiXeNRmZCvA9nY2zS11g/GQDq6GWPqLmAHV/WQbwfJEG7W+0C1FpdrRvfQO6AqrhnsYyM3Z9+E03KHBVfgUWG3r0GG7rZCVDIJsJry5vFB3b0+SNNUr4sTUDsCR1UDejomTokm77CZNQfqb1ogvPtwbdlZXZdEcDFeulUB39Jt0VHyrrq/75ajjXUAj+h+kCGoXXnGMoVyrhCLOsgEAMLd+otRz8eQn/Ad5dsVkVJ13QgpIYKLmMp7qhrAzpf8eKWMjQBYSgYck/SEDlgpuaL0RX0Que2qjTKMDw1KL89qzOABCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(110136005)(38100700002)(66476007)(86362001)(41300700001)(8936002)(8676002)(44832011)(316002)(4326008)(66946007)(6636002)(66556008)(5660300002)(6486002)(6666004)(36756003)(31696002)(478600001)(2906002)(186003)(31686004)(6512007)(26005)(53546011)(83380400001)(2616005)(6506007)(66899021)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uys0d3lMN01mbkdDZGI0ang0OEMvaGIxN0lyTXFNV0tjMGhYKzFVV010VDdG?=
 =?utf-8?B?QzlsbXRXVTMrSHBIN05CbDB6TnExbldSVTRkT2FpajhGUWxUTEd0RXErLzVE?=
 =?utf-8?B?WjZjQ1F3T2FXeHoxejM2RzdIRUVyNGl2bE5MU3JsZ2Q1RzVPWGljc3Y2TWlP?=
 =?utf-8?B?enpkSm1aS1hQeU1yeTltNjYyVURGNVJZMC9xekdHZnBtak11N3c0cDhHS2hj?=
 =?utf-8?B?aUNOa2lOc2lkYUhkME5Kc0RoMkhKN1RLWmpHR0FkWUhmNmFqNTl6ZnVuYmdQ?=
 =?utf-8?B?cFlLZG9SV3hmNTBLdjkxSk5mWWJIcUcrMk14YVZCRTFBSFcyRDNxYkNlNW95?=
 =?utf-8?B?Sjc1ZDZ1RHlsU1VteVpza1dkb2NyeDBLYjNIak5odEN2WldrdzZnSWEzQ2tk?=
 =?utf-8?B?YkxSQWRpajZOWk5NaDJZRlk0WW5QWWFteFRISjBjaEtoTTJkeWxJRjlHUDdy?=
 =?utf-8?B?Y1hqZk9wL0FiTCttZXpqelJVYlVya1F4ZDZ1blpsMWV3b3BCZ1dNbXUzd2d5?=
 =?utf-8?B?V1gvVndrMm5JQ21VeXdqYnZtekZSZEF2bDNWNnV4Yy9yczRab2dJYUc0ZTUz?=
 =?utf-8?B?M1gzalB4MkZ6Y1BWQ0dNa0lZd253UVpzd01wMGV3OE5WZ0tia3duTmtCVlky?=
 =?utf-8?B?cUZTZTRTNHY0TTROb1U2Qi9NSENoc1p1b0tXZHJ6MVNDVmV1a21odHBTcjJw?=
 =?utf-8?B?WENpMHgwWElDS2NMYmFid2w5L1NhSDdmTEVJU2wwTnRBN2lIVGw1emI3aVVP?=
 =?utf-8?B?MnkvUWt4WWxPcm0zcTU1b1dWd2o2NU5RN2oxRVFXekdJWUxEWUduazhpeE1w?=
 =?utf-8?B?Wkpva2RxUFhJYmltZGZFMEFRWjVJWjFsblcra0d4bHN0Y0p1QnQ0cVdhOUVx?=
 =?utf-8?B?OEROWmhNY3RTeHZHQlRMYjBDYjMrTklUbW1BVytPeEF3bFRxN2RlVkk1eGQr?=
 =?utf-8?B?VXMxQzVKNnhXdldoTVFoNk83QWZRQzE1dm1KUXYwQW9hUkpvQ3FwOVYwTnMy?=
 =?utf-8?B?U05wRGtVTE5oTUxCdVJCV1NmUHhQbWdTc2xQTkFLWEpzSmdqbTZKNEtoc2dS?=
 =?utf-8?B?N3ZBVEs2dnBwWXZQMDQ5RVhRY1dhTmlCSWlqanV4YWtLRHNYTFZoMGZ0ZHlR?=
 =?utf-8?B?NVNrTUF5NWF5RHFCdy9vY3MxZXVQV1NVeVZqTmlta1VnU1dHemtDMURGR09D?=
 =?utf-8?B?bEU0bXN6aXhyU0RUeSthRERBY0dabmU2aTJuQ0xBajNxeURDM3k5V011VjBw?=
 =?utf-8?B?ODV1ZVo2TS9GOTRUNy9JWmxmZ09KbUN3SWZ5am9ScGpqcEszWmhnU1VNbkZQ?=
 =?utf-8?B?TktOVEloejU3ZDRLTTZWMVNrVTdxN1ZjZ0hFa3A0YTl5aXBKTnU5aE1LOTVX?=
 =?utf-8?B?bVVRNEhveEE0Rnp2TDU1MzRUeXBCWDVaZTRjNXpBK2dKSHFBd0VjbVJQcmlv?=
 =?utf-8?B?R2tNbkdURXh6SzR5UEhoN1hzTFk1MGtQMGhKdU9CZ1FsVjJESG1ER1FZVWg0?=
 =?utf-8?B?eUZDejU3cGI5ZnJZWDdzZWZnc2p2QmtkSlZlZWUyNFhPUGYxNWtwdHdLdlV2?=
 =?utf-8?B?M2MvTXdYaEx2ZDVyY1MwbDNVQ0N6RXY3WXRuTWVqR2JaTXZ1VTgzNFpRTDVj?=
 =?utf-8?B?aDFaM3dNVGtSNUhxZUtTcXJmVE8ybDhvTjNFdVVTODZIQWJtcHd6WXhabmpC?=
 =?utf-8?B?TFJraDE0cE50TEJZSk5FZWEvNVZzc0VQRzZzUUdiQ085MVZZRUNLQkNGZUx2?=
 =?utf-8?B?MGhGQjIyODBpeHdiLzZKMGFpOGtwdWVObmZSeXpvLzNFS3pUWmJGcTRZbkRE?=
 =?utf-8?B?MkRueFZuejUxZXA5azQ1UEFjL2VLaTE4RnllWUZQZFVYamtPUVpXSllNbWV4?=
 =?utf-8?B?SnZFOUY2NGlmMlNiQ09OekpsRThoQXhtQ20yRENWbXpYaVFiTklHSUkzSXpr?=
 =?utf-8?B?K0FtQUMvK0xYSlpGSS9vNTRMc2Z4TUVOUDNZcUZNY2pIT1ovV3hlZWpmNGhD?=
 =?utf-8?B?QkNobHNXLzhZOUYzZmpsL2FxU3NGTmt4WTRnTXFmQXVjemV4cnRpdUgvdkFQ?=
 =?utf-8?B?WkFaVS9CRGVIREFmWmlMd2EyQVhOUHhYSDNpVTRyVUplYUJXS3JGemtPVFVo?=
 =?utf-8?Q?kel0/ZIubZstV/x8Jb5jGQFzc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30abc943-c4d2-4abe-d51f-08db764ebd67
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:07:56.1891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6b1oDgCOBrizdoKEEUubu7pPf57iidvE4gdiETYAPulBPbWCN7LzwGs/lDeUNZTBv6gmEQrkcGnHLG2APrT0Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/23/23 23:49, Srinivasan Shanmugam wrote:
> Fix the following warnings reported by checkpatch:
> 
> WARNING: Missing a blank line after declarations
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Hi Srini,

I've seen a lot of these minor fixes from you. It's great. But please
put them in a patchset when sending so (sensible) email clients can
organize them. Ideally with a cover letter that describes overall what
the patch set is trying to accomplish:

git format-patch --cover-letter <start>..<end>

Thanks,
Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c     | 4 ++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c       | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 46d0a8f57e55..95eefa6b4f2f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -296,6 +296,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
>  
>  	if (!aconnector->edid) {
>  		struct edid *edid;
> +
>  		edid = drm_dp_mst_get_edid(connector, &aconnector->mst_root->mst_mgr, aconnector->mst_output_port);
>  
>  		if (!edid) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 322668973747..de1c7026ffcd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -164,7 +164,7 @@ static bool modifier_has_dcc(uint64_t modifier)
>  	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
>  }
>  
> -static unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
> +static unsigned int modifier_gfx9_swizzle_mode(uint64_t modifier)
>  {
>  	if (modifier == DRM_FORMAT_MOD_LINEAR)
>  		return 0;
> @@ -581,7 +581,7 @@ static void add_gfx11_modifiers(struct amdgpu_device *adev,
>  	int pkrs = 0;
>  	u32 gb_addr_config;
>  	u8 i = 0;
> -	unsigned swizzle_r_x;
> +	unsigned int swizzle_r_x;
>  	uint64_t modifier_r_x;
>  	uint64_t modifier_dcc_best;
>  	uint64_t modifier_dcc_4k;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index d647f68fd563..be63d34400d4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -165,6 +165,7 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
>  	 */
>  	if (vsync_rate_hz != 0) {
>  		unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
> +
>  		num_frames_static = (30000 / frame_time_microsec) + 1;
>  	}
>  

