Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFB5E8FDBD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 22:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9A210E31E;
	Tue,  3 Oct 2023 22:02:28 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037D010E31E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 22:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK/ML1FZnx10y9GALSdazn1/8apJ84d4hv+vco0g91uDEJ1aROH6/k5JcL88nvi7A63+zd/C8oiLaG4o5cwvxdinl0Mi8y5whDfCHUi9UYHpamoy3q5qE/tPVWO41ISIVANqK8efHW9kSwYp4uHkp94Gu14OIH+kWD0TjGpiVFxElsLWZCY6pH3Hv9R67M8DTD2o0vLIH+FZyH4WUmE9GeaM3f4R0CEpYwCwiLN03cRivFFvMANvxzF1qzyx06zt7k/HW+NYRxeNYBzH2NwIGY8GTT6fNaEhcxMEeADm2KF+YgbjodHaD2fHGhm//h7/fZ5s6t4+GbugdwanoyW9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mkRA/TqTgbMVYMhqgob8F417UJRTfTj+tjEbwmZeYU=;
 b=Lwokf44VpB67lT0ipM4yeNXAvnTVJ9XTreSVqnz635Kl6hr6quFj33tRiiuQ57cB7sZGgZjlMOaCgwcHIRmj5geixcfExQq9lUYwkhtLIn2FRLh0FXxestOL5+l2dRhirBZ71dewtgms+GXUPOGPo0O+Hl/sTs8gSZb5SvRBdZv87jrrAETDzUzVcdJhYAyl8Iz7ISYOIcuSjRYbgnWfOLvGM0+c0KzAyjLEe75QW6Ktx4FriYxAb9TDSfqRi9iYffUygJL2t9lQRE3Cvk4ucuSyFjZ/CNqc3onrN/MPM5jLQiS6CKZbs32Dz2l9kXJjj8R69ZM6mE+PkC3XfBVOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mkRA/TqTgbMVYMhqgob8F417UJRTfTj+tjEbwmZeYU=;
 b=wNlPjnKkZMFglgaG6LQcLm7gCEgdeQdcBLccU0nJnzdkjXkKpFHe0QFQr5c2BsFcM7kz7M5ovdcsN5b6npJrKl//px9g6XA15zy2CQJPn+aMY40JFEAr2cp/tqPwbbUBWKFtnQsnKku2FlunN0X1cJF7M6qKdw1OlMB6lzuWSug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Tue, 3 Oct 2023 22:02:23 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%7]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 22:02:23 +0000
Message-ID: <7fba3ccc-b702-425f-b621-9c953c5961a8@amd.com>
Date: Tue, 3 Oct 2023 18:02:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: Refactor dm_get_plane_scale helper
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>
References: <20231002141649.17943-1-michel@daenzer.net>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20231002141649.17943-1-michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::6) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|BN9PR12MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: ed03eba7-d969-4be4-1418-08dbc45c6c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 130U3uc0onSMwwGbgoH6s6uE7jWS+9g0eocusFVfHxRW6D9jh6mouHItkIVvL+2v2d/B1dYXR97cfbsnwenvHRt0uSmq0KIDd9quWMn5v5I6TNu2TAJgAMuXgI0+ynurIHcbiIk0ITl4ogiAa9bfmPnwywcbUoLVKwO+uhboIQJ1BLWirLQ8ZaE4iU1bht6SH7mdi8+Nw4mnq+3FwsVKrtfliaWYg5uyH3wpBpdChO3s6N2yWG5ruspAk966bqVG58gslZV0zWBJvXUQoQ/1RNT93/Mciqi0nAWwD9C0u6WNFeq+zqedJlWywVRgPdAeBoVagb4kxlP65kb6cpJ3oGPIs0hTIhBzai9WiitQBZ8UnBU6Np5DXGxJZGcS95Wav/fNhLwGR1/V2r9ZjfFYseJ82WWkz2rFAI2pgXiA1Ahp2EbcG6b0/0vA7VKWEp2CARyhh7FyddledZr+swJOUd2yPRlOK9iwyTD5sCThx4bNB5/pFr6T0fpFeD15MUmzurS6LF4+OSRfAmFHz781FBd2xlKZBYHJ47CW/h5G1w5Vv5lJnl2aAe6XC5MGgOx/xQX2kvjqVUpy3KtsNh6cPB6s2sMJ6uJ/8mnREUBOSwX+G67D1unQmbTJiT6RVhgi1EDamxqJULLpLa02GWDQUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38100700002)(83380400001)(478600001)(6506007)(6666004)(53546011)(26005)(2616005)(6512007)(6486002)(31686004)(66476007)(66556008)(66946007)(316002)(54906003)(110136005)(8936002)(8676002)(4326008)(2906002)(41300700001)(31696002)(86362001)(5660300002)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZJU2w2aFFlV1gwMlpjSDNySDBybThPTkdYOXNiQ0t0VzlHWFhwVUVPTll4?=
 =?utf-8?B?WFFLQ0dVZmNHQTF0Rnc2c1o2Ukx6bit4cng3djJ6QUl1bk80aVJuWWtRL1Yy?=
 =?utf-8?B?Z2QrWEV1Z256UkRuSGJPNk94ekdDS1owMHdYakUzbzkxSDNTc1ZKUGxEU3B3?=
 =?utf-8?B?SDFnTkVvcmhCckJoQlRjdlhNRkNpK1lMUThCaytHOGdyRzBrVGsweFA2SEE5?=
 =?utf-8?B?UTNmalhUbDVyOHp3NDN0eCs5M0dhY3lTRHFWclFHUjRtTzJaQWpkbWJjQUR2?=
 =?utf-8?B?UGR2KzhoY3N3V1RtdVExZFcwVlFjN0Ewd3ZSNUJmc05xMkZESDEvdUpHaytJ?=
 =?utf-8?B?S0F2MDVVZTlaa283Q0lwSDEyRlBPWG15V0VVcktnL2dubndRWFY0NjNsOG8r?=
 =?utf-8?B?OVZsZlg1bEVGYlh6QytpVEpURHVrTzE4eE92clVNdU03QzdndUJNZ3NSSndJ?=
 =?utf-8?B?enRyMUhCS1FLSUE4bDYzYmRnTEQ3SytYMWxqWjZvNFFSVHZOZFZDYmUydnRX?=
 =?utf-8?B?cDFSczRobDdVQnpzK0lTaS9rSkxPTlUrbW5hSUJUdlI0NnQxd1Bidmxhcm9N?=
 =?utf-8?B?TmhHeDc2NUZCQ0Y4MW5JSDEyWjhaTi9ERHpWUVBSTXJvNUc5ZHN2OFVBZFlo?=
 =?utf-8?B?VFhhdVBnMENwMWVmaStJaS9uY1NNcHZLNWlTN25LVUdSSi9kMVB3V1BtU04z?=
 =?utf-8?B?Yml1ZEJVYlRGOHJHV005djJUUWRjMmRqWWZTTkRvVzlKV2ZNQ092MysrS3ln?=
 =?utf-8?B?Z0MrRzlTVlMwY3Y4Q1dPMk1ZMGN0ZlJ0WFBveU5BYVE1ekhFbXVMdXd6Qitw?=
 =?utf-8?B?YkZteWVpa2NxZzIzQ3ZkWjZlMElFQmY1eEpMSjlab0MzNnFlQ0RXS3Nxb2xM?=
 =?utf-8?B?NnM0eGVFM0ozT0ZndTRLTWpNd2VmZTRmMjY0bFl4K2FpZ0J3MnhBODlWT3px?=
 =?utf-8?B?NzFrZVNXYUs2dEdIU1dhdUJWTk5SOXRPMmRmbGRvUkxyL0JPbFo1cTQxNEcy?=
 =?utf-8?B?bWNENWhiSUc5NHYzN3NtRkRxaXd2S29QT3FLNXowRDZyWWEyVWdSNVNobWtn?=
 =?utf-8?B?eExISUtkdWdlcFRFRHRiQlFxdmd1UG15Qi84YjlxYnNFT1V0L2hwQWdObHhV?=
 =?utf-8?B?aGgralR0SlpmUDhwM255dDNHWnZGVVZmZkd5NXliMHBaK3cxRlo2T1c2bEo0?=
 =?utf-8?B?VVJZOThBT21ReUdEUVQ5ZnladlIrcUowZDZWbkxFaDdnZmNqeWVzbEovR1ll?=
 =?utf-8?B?WlpPWVA3SitUWkpiKzVIbUJDQ3cxYjczeU5KVWpQUmdIRnU1VU9jdzgxSDVi?=
 =?utf-8?B?UnhDRUp0c2VxMm5HcE9DQmxWejVuajE4RVpwV0ZUWi9talhpTTBpb1Y4cHhM?=
 =?utf-8?B?elFFUFRtYlVHWWlQQ0UyZzdwcjZBaVBIa05RcFBoN1dVbHgwVUZyTUxtN3hp?=
 =?utf-8?B?M0pnUElMS1F2d1JtNnlWZXNDaW0raFByeUZJTjVvdlcyTnYrR0FmMUMzeFdU?=
 =?utf-8?B?R2d4L1puYm1kODN2V3h0dHZOTDNHc25vd1dRa0NUMzQreFRiM3Z0dWpobDNL?=
 =?utf-8?B?NTFrYXhEUEFYejEyYVl0dFBEczdyY3FFTWNXbXo5REcvT3RFODB4c3E5K1Vh?=
 =?utf-8?B?dmN6MFVPZHhvRE1FZWt3dkdqL0Yxb0NIRGZSbGx0c29IMXQ2bklHS041aDEr?=
 =?utf-8?B?Q0Q4MjhpczRFVTVRYTc4dXpIcDd1NXYxeXFTanhmN0JHblFGMHI0cEVFWkhY?=
 =?utf-8?B?ajJkNVFpWWNtMHJaWVlLZUlTdThwU1FCVmRrVWZHaDc5Mlc1SVA3eXdhclk5?=
 =?utf-8?B?U1pldi9IcHZSNmR6UndWSDdzZ0JoNXdLbUc1UE5ZUnloMENOZW12c1ExbE5B?=
 =?utf-8?B?bnJnaFZoOGYwbnkvRTVmeFl0bnd0aWhvakRpQWZkYVZZaFNrNmZ2clRuTWFl?=
 =?utf-8?B?TGJOaHZSUlRzZ05Kc2wyUkJuUWpvaXIwalJacVpjV210cWZyaktSVFBUeWVz?=
 =?utf-8?B?U2w3K1U1bjRQMWQ4MmJ5eWo0QTJlOWV3Y2dUVjVQN3dZQW9nS3lVOWhuNUVl?=
 =?utf-8?B?eWxWSGluc0ZIWG1xNGNhVDFvcFZuZm15M2NMbmg5TitoSkx5MzRlb0d2TTNY?=
 =?utf-8?Q?xMxOidy0CGEi2orI22PMn0ENL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed03eba7-d969-4be4-1418-08dbc45c6c01
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 22:02:23.2668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJTFX10ZdHF33TYWfNO97DFfQwtrn8cBoIN2nwFVzmBwzRmqR6domTTYpX1lNZ+D0LcMG1JxKvYqNcXD9FignA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/2/23 10:16, Michel Dänzer wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> Cleanup, no functional change intended.
> 
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>

Seems like this series does indeed fix the issue, so I have applied it
instead of the revert.

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++--------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 19aeb1aa1276..0173828e1f61 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9892,6 +9892,17 @@ static void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
>   	}
>   }
>   
> +static void
> +dm_get_plane_scale(struct drm_plane_state *plane_state,
> +		   int *out_plane_scale_w, int *out_plane_scale_h)
> +{
> +	int plane_src_w, plane_src_h;
> +
> +	dm_get_oriented_plane_size(plane_state, &plane_src_w, &plane_src_h);
> +	*out_plane_scale_w = plane_state->crtc_w * 1000 / plane_src_w;
> +	*out_plane_scale_h = plane_state->crtc_h * 1000 / plane_src_h;
> +}
> +
>   static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   				struct drm_crtc *crtc,
>   				struct drm_crtc_state *new_crtc_state)
> @@ -9900,8 +9911,6 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   	struct drm_plane_state *new_cursor_state, *new_underlying_state;
>   	int i;
>   	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
> -	int cursor_src_w, cursor_src_h;
> -	int underlying_src_w, underlying_src_h;
>   
>   	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
>   	 * cursor per pipe but it's going to inherit the scaling and
> @@ -9916,9 +9925,7 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   	if (!new_cursor_state->fb)
>   		return 0;
>   
> -	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
> -	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
> -	cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
> +	dm_get_plane_scale(new_cursor_state, &cursor_scale_w, &cursor_scale_h);
>   
>   	/* Need to check all enabled planes, even if this commit doesn't change
>   	 * their state
> @@ -9936,10 +9943,8 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   		if (!new_underlying_state->fb)
>   			continue;
>   
> -		dm_get_oriented_plane_size(new_underlying_state,
> -					   &underlying_src_w, &underlying_src_h);
> -		underlying_scale_w = new_underlying_state->crtc_w * 1000 / underlying_src_w;
> -		underlying_scale_h = new_underlying_state->crtc_h * 1000 / underlying_src_h;
> +		dm_get_plane_scale(new_underlying_state,
> +				   &underlying_scale_w, &underlying_scale_h);
>   
>   		if (cursor_scale_w != underlying_scale_w ||
>   		    cursor_scale_h != underlying_scale_h) {
-- 
Hamza

