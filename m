Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 17:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B91615A3
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 17:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31B91615A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CC36EC16;
	Tue,  5 Oct 2021 17:45:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B386EC16
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 17:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLtK7EcrqrOaUjrlvvPPFWKK4OK8SaQJPw9AZhcLAsrY8/eWachH7/PtkV8xU8XqLqjcu3g73n04aD9TDGdmuXH9I0y9vpRxjLjgU8fcErW01rBn/tyhbZp2ojfLKjz6txMeQ9OvMy9uzcaqbJVEI2w9nWjzqofDeXkg3Ybd7vEp1Rt3/eDeCQbJQXsHqJZJiBLAugSXb0nmoT7pYdkOMtPyJHdKzog0OgeMir0eHw+2LYRkrA8xGE8807kXI5SEXUKJtHIf7ya0z5J+F+TVAm6BrxjNpTQRMay+85owNulJhnjoFCTL9oMh8aTKHVNw83uVokFkCLh6vCvekJAoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U282kINwK86sEypXgun+jNMNfCVT98jZWkEgJODtmXI=;
 b=BeVwwsumhvjYg8CT3Ah6t1zxGgha1K5lOX6FRzku0mFwoBjpif65Rwykc/9hjLwjcwy6KRBsy6y5496dxXWnzbQsgoZF8ou06OoYqRUYbSSvIp3MZZja0lN2JMPWWZPKkcD4QhGSpqvGeRihVZZJc7M5A163mTZ2yEExOUZpXrnpg5QpiC+XCOO2EeXCKZ4K4r1hYIeqGkDRM1Um2iXVM1Jb8qlkYprp4aCNEpjjfe5rEfGN6V8m7jlZp9JCEVbd8dZZbOPX9f4Y538luvuo/rjYIIpABgrmUyzJh8wv55TQ9nWAE5c7l8xxGEXAuL1Lin9sCOTgac23T+v4B74IXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U282kINwK86sEypXgun+jNMNfCVT98jZWkEgJODtmXI=;
 b=wq2entLTWUX0rST2L0p3QDnMVCA5PrSW6QbrdXA7NgudfuXu3qx2CzcujzFdhmYZNRQZ75PhBldXmBS1Y9TZ/kVCydlwiV8SUwZK3jI2DR19u/2XR86F0CGiXwv6EyIah/H1Bmtj9KyKV6t67vj6AzZUkSWFdtnEqwIBipYI7uk=
Authentication-Results: emersion.fr; dkim=none (message not signed)
 header.d=none;emersion.fr; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 17:45:53 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 17:45:53 +0000
Message-ID: <99c5a214-de4d-bd5a-f4ed-8805a49b4435@amd.com>
Date: Tue, 5 Oct 2021 13:45:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 1/2] amd/display: check cursor plane matches underlying
 plane
Content-Language: en-US
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20210929190603.48890-1-contact@emersion.fr>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210929190603.48890-1-contact@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0417.namprd03.prod.outlook.com
 (2603:10b6:408:111::32) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN9PR03CA0417.namprd03.prod.outlook.com (2603:10b6:408:111::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 17:45:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e41b51-dd67-44d7-d4fd-08d98827f9e8
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54436DD47AECC0EB48FC4F6F8CAF9@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXlW9eC1m64HTnr8+/XzznvVsJOA3FoJODvdaQPwDe1ZwuWB0FLBtmspl0qkD/iY4Kha+J3R7P9tqYDp8eP5TSP7bwmcnZVJ2v3WTB1AGYIJExco41hqHHOJgeFz0W8jyxywvbRsAb0mo3SQvZ0tWt/mFieZIZfoqhAXPasnzMGAs3H6fVNbp7GNlCil//ecRzq6QpxINSB54nxDlpPS5itdbWQQhQTMSBhrWv1snctDytxch4RIzybu/O8PzoFUIj3Zs2TeVxHrTCUUixP5mTxClSmYauPwIOoIMkAu7i5bWjNBgcrEFaXZXSq3R9qlv/VBOGwJWPli2idf+/DowxOncXTKVbWqWmKV+fzVZC/1rjcJOx39LIq74zV3tbhR17RdD3/7sWEt/hKKrujicK6HMXDGou8cFaCHfFetWujgt1EuDrOmxNIA4GTmZnSgXIjhPXg4flc+WPAWTC20sPUHB3GLuB6F2yTE0tFDaWMJ0a0VzOMp1bkzRlgF14TSfVB1ISWVcRHi9WTzqsymUF4JZW7Ai8TbfUkkw6+ZBIs06ooRMpu0AXcMEzq368pp2o2xVWSxJt/e+3HS2JadndA1ett22IQ3PLnuxLZwmj2+mj0MiJkbxk9/7xoQ0Gk5Tgn4wyc4Ae/ey2BnnN/1mbmQ6fwDZGHOsQRZjVqYoyWJyDrhVad3sPC1m/5io2s9hCiRxQ4jsEJLtUwDqbySquh2+8q+e/7nPbpNdrIYsAqyjRkW7FAR21+q8bugUnK/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(36756003)(5660300002)(53546011)(44832011)(31696002)(66946007)(86362001)(38100700002)(54906003)(316002)(16576012)(31686004)(66556008)(66476007)(8676002)(8936002)(2616005)(186003)(6666004)(26005)(508600001)(6486002)(956004)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1d0T05keWk0bWNqYVJTZTFWNnVnMFlzOGZuVThBYmY3ZmVPTFg5L3laVFAr?=
 =?utf-8?B?WjNnanBjd2VjQmM2dTdwQ0NSYW9hTGxJOG1aSEVnSXU5azlpVUh1MDM2TFE5?=
 =?utf-8?B?aS91ZEc2Q2ZtZDNRV3lyTGNFOVE4K0Iyc3dOcWlYTjlvN0cybTNoV2NZRkZH?=
 =?utf-8?B?aXQ0Ui9MK2tRZzZMUnJiK3gzTUZPUU44dC8vTFhCdlZtcUdqUDVaekVFU2V4?=
 =?utf-8?B?VUkybWJpdFRGZFFmYURQZmhTVmVGSEQ1UklxYThGRXBLNlBQa1NENTFlSUlX?=
 =?utf-8?B?T3NPazdlSWNUdjkrN29kUU05T1BWTEp3bENVSjFuODdoYy94dCtpRUxjWGx4?=
 =?utf-8?B?dFQ4SWxQMXZuZFgra2VaZGdOSVliRytydTFJRUJRaFlsRUs2Z0d0MWNJYjhz?=
 =?utf-8?B?VmdhVW0wZjU4N3pHcHBsakxzQnNiY0E4cjZRZENyR2xxaUJNOEV5MGdNbS9i?=
 =?utf-8?B?SjN5ZnE2Q2NsY1h0WjlDM0xDU0NjVHphT3Ntd1JkQnRKcEh3VGdacVJaeTFv?=
 =?utf-8?B?Y20rVk5ueHFjb2dLZVVzSWV4L1h6dmQ0SEcrUTA3bEpvWjd4dW1RbFlQUnR0?=
 =?utf-8?B?ZlN3aWxZbnFqdldCWWNJT0lZYUI3c0JOYmM4bm9oeEd4UkZJUE5jbTBvVHho?=
 =?utf-8?B?Qkp4SFJqcXgyY3l5WUJvNTZ3ZjlPdUs2QitZWDJRM1l6K1NMVGFGZHh3TU9H?=
 =?utf-8?B?RzZ5bXhvdGY4Q3NpTFhFZzFMRWlRSnFYd2tySm9KU0gvd1ptMDlFNGtFdWsy?=
 =?utf-8?B?ajc0akptd3lHTjZKQWVuR1k5U29KZmpTYzZTN2tPK241dlNUdGVldDZaYkRj?=
 =?utf-8?B?RWtJa1NpNWpUWjF6MTJyVHFkSTRib0pPMUk4S2svekNrcVhzUXB5eUZJUHN5?=
 =?utf-8?B?anN5bW83RzZuckJtZ3p6U2d1Zlp0ajNya20yZk9hZW1UeTc2N0poS2ZQUDd6?=
 =?utf-8?B?RlkyWCtUYXU3M2lLaEZZeCtDandqTHFhNm03Qmk4N1FWMmw1cE1kak5FY1k5?=
 =?utf-8?B?dlRjRUFzV1Bhbld4cXpqSFYvNDRRajJOZDArVWlVQXdsUjh1M1NWYlI0UFdT?=
 =?utf-8?B?cTQ0N0h2YXB3RVVLakM0bDV1TDhvaW9XUUw2SU00MGpwckkzREZhTGFSY3pS?=
 =?utf-8?B?TngxeFJkRjhzSzFkSGVSU2NxbTVUaUhwc05jckI0bjJLb3RLM1ZhVGpXaWJy?=
 =?utf-8?B?WEN1T1gvTTJKTWxmK3J0S0llck9qUHhYYUhSMHZWV1cvM3NQMWtITXB1dmlY?=
 =?utf-8?B?Q1BtcDRCc29DcVJzeUhkcDF1am9DMEpFVDRnbEl1RlJSYWprcmVZdDlSV1ll?=
 =?utf-8?B?MGo3NVNFazRSQjVYZ1Y2K3Y3cnpnR2VvTmhVWG9OVGV6RGY3NkREbGpYM2lj?=
 =?utf-8?B?QWwvd252S2Fyckw5SnJobUF6bHdzTFBiTTUzeXRsektPVjBkdnE0TnZyaXo0?=
 =?utf-8?B?azJkTnFhUEVWYktjcDAvZUQxSlhKVEc0ekFTalg4MUVxK0lPZUZkVDlEKzBT?=
 =?utf-8?B?R1ZiT1k3eUt0bElwTEdaR3h2SmxaL2p1Z1Z5ck1jajNIcEpKSHBScDFlazVv?=
 =?utf-8?B?eDZ6THRqZkgzSnBCVk8xWGl3dis3cmtRbVNqdnFXN2hsQXNhTWRkTTF0RWlO?=
 =?utf-8?B?RzcyMkNnWkVGZW9yKzcreW1OczhHR2dUQk5rOW9aSThrV3dUN1NxV2xyT0cw?=
 =?utf-8?B?Q3BJa2lsVE9qWXFwK1dsQm5XbVRna1BkbUduK1lOZnNPMXdqaThnTXB3SGdu?=
 =?utf-8?Q?pUtyB+8+72pmnDw9k0p2l9+wmA5R1s0I4oHZ3O2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e41b51-dd67-44d7-d4fd-08d98827f9e8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 17:45:52.9644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwXoiu1p1w0MHrsAUOvv9j7yFy07GqFSkoAH/eXvQ+01076l9aExxQteTQbEBYwnS2zlB1h+TDYMW15QLd5Olg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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



On 2021-09-29 15:06, Simon Ser wrote:
> The current logic checks whether the cursor plane blending
> properties match the primary plane's. However that's wrong,
> because the cursor is painted on all planes underneath. If
> the cursor is over the primary plane and the cursor plane,

Do you mean "and the underlay plane" here, instead of "and
the cursor plane"?

Harry

> it's painted on both pipes.
> 
> Iterate over the CRTC planes and check their scaling match
> the cursor's.
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 49 +++++++++++++------
>  1 file changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3c7a8f869b40..6472c0032b54 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10505,18 +10505,18 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>  				struct drm_crtc *crtc,
>  				struct drm_crtc_state *new_crtc_state)
>  {
> -	struct drm_plane_state *new_cursor_state, *new_primary_state;
> -	int cursor_scale_w, cursor_scale_h, primary_scale_w, primary_scale_h;
> +	struct drm_plane *cursor = crtc->cursor, *underlying;
> +	struct drm_plane_state *new_cursor_state, *new_underlying_state;
> +	int i;
> +	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
>  
>  	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
>  	 * cursor per pipe but it's going to inherit the scaling and
>  	 * positioning from the underlying pipe. Check the cursor plane's
> -	 * blending properties match the primary plane's. */
> +	 * blending properties match the underlying planes'. */
>  
> -	new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
> -	new_primary_state = drm_atomic_get_new_plane_state(state, crtc->primary);
> -	if (!new_cursor_state || !new_primary_state ||
> -	    !new_cursor_state->fb || !new_primary_state->fb) {
> +	new_cursor_state = drm_atomic_get_new_plane_state(state, cursor);
> +	if (!new_cursor_state || !new_cursor_state->fb) {
>  		return 0;
>  	}
>  
> @@ -10525,15 +10525,34 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>  	cursor_scale_h = new_cursor_state->crtc_h * 1000 /
>  			 (new_cursor_state->src_h >> 16);
>  
> -	primary_scale_w = new_primary_state->crtc_w * 1000 /
> -			 (new_primary_state->src_w >> 16);
> -	primary_scale_h = new_primary_state->crtc_h * 1000 /
> -			 (new_primary_state->src_h >> 16);
> +	for_each_new_plane_in_state_reverse(state, underlying, new_underlying_state, i) {
> +		/* Narrow down to non-cursor planes on the same CRTC as the cursor */
> +		if (new_underlying_state->crtc != crtc || underlying == crtc->cursor)
> +			continue;
>  
> -	if (cursor_scale_w != primary_scale_w ||
> -	    cursor_scale_h != primary_scale_h) {
> -		drm_dbg_atomic(crtc->dev, "Cursor plane scaling doesn't match primary plane\n");
> -		return -EINVAL;
> +		/* Ignore disabled planes */
> +		if (!new_underlying_state->fb)
> +			continue;
> +
> +		underlying_scale_w = new_underlying_state->crtc_w * 1000 /
> +				     (new_underlying_state->src_w >> 16);
> +		underlying_scale_h = new_underlying_state->crtc_h * 1000 /
> +				     (new_underlying_state->src_h >> 16);
> +
> +		if (cursor_scale_w != underlying_scale_w ||
> +		    cursor_scale_h != underlying_scale_h) {
> +			drm_dbg_atomic(crtc->dev,
> +				       "Cursor [PLANE:%d:%s] scaling doesn't match underlying [PLANE:%d:%s]\n",
> +				       cursor->base.id, cursor->name, underlying->base.id, underlying->name);
> +			return -EINVAL;
> +		}
> +
> +		/* If this plane covers the whole CRTC, no need to check planes underneath */
> +		if (new_underlying_state->crtc_x <= 0 &&
> +		    new_underlying_state->crtc_y <= 0 &&
> +		    new_underlying_state->crtc_x + new_underlying_state->crtc_w >= new_crtc_state->mode.hdisplay &&
> +		    new_underlying_state->crtc_y + new_underlying_state->crtc_h >= new_crtc_state->mode.vdisplay)
> +			break;
>  	}
>  
>  	return 0;
> 

