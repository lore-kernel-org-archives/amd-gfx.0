Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FE4CF649D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 10:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C201A10E094;
	Mon, 30 Sep 2024 10:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iTrSFqUc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF10F10E094
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 10:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpKH1qB0FxUlL4CwPLqtKwHKm8skdJIunO5BNUG/RJw3H7w2uiMM/GAC/xTvXEp3KhAEPsgeUszWTKPhjwZwnX4Z9CdSiXOYruDwRqRab2VJq7KjJooF30Zjx0Pj7QQSxRinqPu5Nar6icyifiuABREs3+j/Sf2HEYc/+G6/Vn2gxuF6D8lB8M8dIJbOUo98zlUMssIOYGpeIck4hphnlsZlN1qDzCjOvsjzbfxUaRWZzWXsUCUR9ntkcGigG9z/PcfnUe5g0HlSfN4tNLyFOZkYQrZja+JQLkma+H3YxIupofQDF0OO0LIn1uOA5/3mWCra00QEQhF0n0n6dyTE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3Ur90GJebZn5uEn7JugFNkSio9egmHVx802NJoYDfA=;
 b=bM4H55aFKlVxHjn7jJtgAwIEE5vUCaipLvyRzmv7lBvIPG5gDjNzsuXsdg+vOLjQmoXmf+PqTNwgc+2h+CbtFad8y+vkDJfaIVXdXmnuxgV/Cn7oKIAwW4mwZ5g9K977YVMawe4iVSDRtSo5CQmoaRAi7iKEgO8+TgH7y6XD5Wtp4ZrtmE4M3inzXwthC1xfIPR1fMUgRs0MeFBvGjHimY1ljSvbMhnV3EHz0ir7ZmFW/nwC0XslSLoAvmmGPdbHLtxoJlXG3dHf/3p0tEjXhu0FpwcDmQZ5quyQx3UiETPl9a6KxXi38u7gC8h0QhxTmU9Uy0lJ5VlfIqoQQ610BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3Ur90GJebZn5uEn7JugFNkSio9egmHVx802NJoYDfA=;
 b=iTrSFqUcigaPdn+y+vwCk2UFluWQyTE4qYXoynBBf5hlB5V8GrhTXJZYp22bqAYtaalkgphOxmzumPgxj2PW91gs+nWcxwtFT9dbVLpdZazc+e0bdTnTWKtfrkh84+1VEZ3/9vacrN9Jwcl0fdMO5Ega4S6Mg7cBwVapqt2C6Ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 10:24:23 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 10:24:22 +0000
Subject: Re: [PATCH v2 1/5] drm/amdgpu: update the handle ptr in early_init
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240927150059.2232708-1-sunil.khatri@amd.com>
 <643c9ea6-e5e5-4399-a658-7b401946de5b@gmail.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <e9892b9c-795b-ab83-4b0d-bf4006a10a80@amd.com>
Date: Mon, 30 Sep 2024 15:54:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <643c9ea6-e5e5-4399-a658-7b401946de5b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: da888d0f-7e69-4bf9-caf0-08dce13a0d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qk94TFZtT3ljSHFQR3dLaTAxTFJHdDNjaFdzL0xuTjM2dVVpOTRTWWNPd0xo?=
 =?utf-8?B?dFpaaTdUbW5rWmhWU0xRT3g4NDR4cFVQMENOYi9yQWhVRnNZRUNaN2tLdUhq?=
 =?utf-8?B?NEhHNXdyMFY2dXliTnVtN1lhMGd5cnhGR3IwWGhkZVd6YjlxbEhWWUdDdnd0?=
 =?utf-8?B?dFZ5c0tsRXk5MENzU0pSZC9YM2NHRXRwNkZPSlh1ZklZK3JKZTdVNUhVTG0v?=
 =?utf-8?B?VUlKcEhxWFBkOWs4c0Q2TmxvalR2WDJyWUNnUjlBeUN2M1U2WWpRSzNSMUY0?=
 =?utf-8?B?NHVabDRzZ1FicmcrOXQraHhNbXhtMm1TVE5hOElMcFJQNmFLM2cvKzdCYVUy?=
 =?utf-8?B?QW5pcVZ0WC9FWG5uQXFaOWlmUlArRW05eEI5Y1NaNXU2ZHZrZ1ZPM1FvZ2Fl?=
 =?utf-8?B?c1NpVjlpTEU3alZraDVpSzJjVkFWNURISklSbHhqcE96ZVZ4aDN3STExZ3Rs?=
 =?utf-8?B?MERNaXhNdVI0REt3YjNoRWxVczhzcDhwNFRHNUdsQXhYUmJmNVZoRW1Xdm44?=
 =?utf-8?B?cGxvdFQ4L1N0ajQwWGdXVnlKK2lPcHB6eGVyOXhiYkY0Q2d2cTdDc1pka1Ns?=
 =?utf-8?B?VzFHeE5sc3M5WVA3UVBuRVpSdmlDZU5DK2huamlSbUFiUC9adzVrUFg2Wkxp?=
 =?utf-8?B?Z3JsNU9DaW1LL3ltcU4rWW5yY2JjWlNoa2R6OUE1YUpWMytaQ3g4WXNWbEJM?=
 =?utf-8?B?Mjg0S0ZJcGtZSjZVTHFWQm91MnFaYlh0ekExVHhJdVpYalhXU2FtRGVydmZq?=
 =?utf-8?B?Y0d6aUgrUHgzSUVOUE1jc3BYQWRDRW1aWlVFNDFKb3RRSHE5V1J4U0tsR1NB?=
 =?utf-8?B?YmhjRGoyTjY1V2dEdzVkbEVLUldWdzNVZDN5TitNa0VMTElxZ3B2RFp5cm1O?=
 =?utf-8?B?TTVBdEY2MzEyZkl6Q2pYSUNMZnhBZ3FLTi9jOEgrcGFCM1I0Zi9aVXRYQ2Qy?=
 =?utf-8?B?VXZzcXFXTkduQ1dyZ2RpSGMvelBpWnAvZHgybnhWL1FqR0hoOThtc0JPbWJO?=
 =?utf-8?B?d2JWSklMTlpDNnVSNmV4cnduQkkwaS9SODhXYkdTUGxUWVZFeDRpME5mZVF6?=
 =?utf-8?B?RWV3N3BoS1k3bERmNXhYZ3RaTzlNZWNFYk5KYy9kbXo1VDBNQ2ZmUytoaU5P?=
 =?utf-8?B?aEUybllOSXdxL1VrbTcyN0ZmQ2lsQUx4U0ZwSmFzOHE0OERlUWg3Q3ZmVFFX?=
 =?utf-8?B?dTBqVzlOc0VOdHNKcm1ML1QwZkZrdGtlSnhWVjRXYVJlcGJndEI0NlNwV3l6?=
 =?utf-8?B?aDE3aGFwWU1SbUVpQjg0MUt4ZHdFRkRSd1pYNXRnUHlwblEzR3N4blhGUXQw?=
 =?utf-8?B?WWlMUC9lQjhHdTV3VWt2N3lCMVdIeXhvZU0zc0xTdVpBcWlVOERNT1RjT2p5?=
 =?utf-8?B?K3NjMW9KQmIzd244VFhmT2dGN0RVbGoxRVg2c0RBS0lYSURIMkpCT1Z3N3FV?=
 =?utf-8?B?cFhYVDFtRzdITVFweW91aWl6TlkrUGxwT2w1enQyMDF5bTltc1VOTUpjVWhm?=
 =?utf-8?B?NnRxZmlBUE55ZFdNYkkxNytRWCtDb2JtbmhhUkEzQ2dpNnMwMUNkbVJVUkhL?=
 =?utf-8?B?MlhsM2FmY1RNaWxFMTR0aEJvKzRRbUJlTDNIZmd6NVc0TjhuL2x6cXVLd0xF?=
 =?utf-8?B?ZWVMbnFxNGVVODhzTzFDS0lmSFdwRTNTbllmRG5xdnllRk1ELzAzaXZsZUxh?=
 =?utf-8?B?bU5ZMGRGWUtJUVgyZGMvWFJmSDNJT0xJTHR5M0ZiOERBVDRCaVh4aXpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhBR2dJU2d0SmlTcUxTd005R2xvd2x2bXFac3d6V2k5VXpacDcvNnZ3dk9a?=
 =?utf-8?B?WWpBdWFSWUx2T3hhNFh5QW1MUXVpYkI5SmRCaWhQbTVqR1N6MWY0REduck1W?=
 =?utf-8?B?bUh5YzRnbnpiWTR3b09Eem1lMmdMdklkU1FZR0E1ZDlOc2RyZTFRdno3QTFB?=
 =?utf-8?B?TXFMK0RKOVprVWxNUWJXWWxIN1dEeXJGd01wRis5Y0JjcDh2VFdDQlRDRnp0?=
 =?utf-8?B?WjNyYWVOSHNzYncxNE5iV2xZYVBFK2MrM0hmLzRzTktTM3VERmFqS1FMaElP?=
 =?utf-8?B?aTFQTVdWOGdnNlBtMkxBRUQwdmVjclJnTC9tWnNkMEN6SUdPUXE2eUVXZFlB?=
 =?utf-8?B?d0hqaGw0M1RCRE5YdzdvVlZPS2JBRHhGY282RGtOSjZtT2RjQUpRUnVKVFdm?=
 =?utf-8?B?WnNPbU5FUXkxL2NNbFo4STNMbm5Lb3FBVlM4dHhQQU4zZElXdHNZNGhlT2xF?=
 =?utf-8?B?UEV3QjhsWDl0ZUJRZk1LeTJZR0ZHcmhuWForOWM4bEVHaU9MakV3alkvaURz?=
 =?utf-8?B?R1pmR0t1VzVSQkFreGNNY2RUajhsc00xZXRZdW9tc2ZhTFBFQlBnQ0dOM2gv?=
 =?utf-8?B?Tk9ZRDRBUDZWV2x2TjN6RnJGbDVYUEFMeE5KVytQV0UvQjhNYjVNR2tUWU81?=
 =?utf-8?B?UTcvdGl5U3NrQ0NnamlzeDJMTHpTZ2FzZXE0YThIKytiK0dXaXRCKy9EVGFn?=
 =?utf-8?B?QWN6WVBwb2ZMZ3FqN3AwTldnUXQxWU5sTlRTdzJBMHNWSngrbmVpYXp6a3c2?=
 =?utf-8?B?a1h6Wks0ejB4dXFRL3c2SC9ZdlJtNnZWdUJ1QlVndWh4OUpqaEltbEdISXFl?=
 =?utf-8?B?emh5cU9oRkFSaWt4ZXV3Vkc4MDdoNFIvaWQ2THZZUzVhQlJlU0N0MVNIREtP?=
 =?utf-8?B?RkRENGx5YllqYkRBbTU3eFZLOUVjRndBNmhQR0ZBZWVITFo5M1FpaHhLNVRl?=
 =?utf-8?B?NTM3eitrYTMxb3JrWjdSZ0kvQjRZNU9PZ3RlTm9td1FPVjdqTjcxRm84ZDFj?=
 =?utf-8?B?QWlWV0hLclNSN3hKWTRCMFVUaTRaVVdSMW5pVWRHOWVuQmdWVHJXNnJaY0V4?=
 =?utf-8?B?L2VKNC84ZHpEb1NONHhMWFNTU1kwNjhQYWR5aFMremVjSnBxLzFKQ2VxTS9B?=
 =?utf-8?B?QTBsK280WGMzMTNYSmJBSlN3UkxjUUxwMGlIY1p2RWpQeGNkb2QwNFZqTE1G?=
 =?utf-8?B?L0laTjNWNy9wdStJeTcrQ3E5dTZma3ExLzFhcksxeXVHelJnUVdxZllyYWFm?=
 =?utf-8?B?UWdtTDRPak1KVmdPMElZNFRRZXBsQjg3ZUh5aHlnaEVMeithRXF0czl4SUtG?=
 =?utf-8?B?YXU2bHM0Y0pLclZ3cTBYMzRtbkNhbXJTVmhNRURSbHFqOXpZTElpV0RxK3ln?=
 =?utf-8?B?NFRCM2d6MlZ1ODR5WW5IRk5sRFE1R0NXNTE5NlBUS0VFdXhOeWgrcjZoQ2Ri?=
 =?utf-8?B?UVE0ay85ZTcraktoRTBRTEhjV21sTG9LeGIrMWdKV1M0cXVmckVhTnRSdjVu?=
 =?utf-8?B?bGQzY2xrUmFnTUhHY1h1SkdudUlJMm91RU1HbDBVMzluVGY5bCtGZ3ZtUFBB?=
 =?utf-8?B?ZGpMQUVIdXc1eXltTmI5T2dHVnZ3WkUwVEU2bnpEZmgzcitFODVVNFNxWVcy?=
 =?utf-8?B?enZGcFBLQVVDUUZjL3plMm50UWZQUnlzZzc5WTlHa2R6RHg3ejI3WXEycWYw?=
 =?utf-8?B?WE92S3RLdTJrL2FpZzBwN0I4VlhwZldpaGNOdVNZb0FNYlZNMXJSYnV0M1h0?=
 =?utf-8?B?dC9jWjJ5cUpIMjhJTGM2QXUyeXVvZm5iWW5sVzRIWUZJclFsbWwxdXNkY0pw?=
 =?utf-8?B?enFXczFROXp3VU9Ic3FYQVprdHF5c3BHSmpIc2FjMlFjaUEyd0VleEdYLytE?=
 =?utf-8?B?L3M4NCt2Z1U2dkZxZUthOVdwVkM3c29mREN2K1FnK01IanVzV1FjQ3RhbTEz?=
 =?utf-8?B?VzRTM0h0M1d3NFg4MUtEM3J6NHdySUx6OTNZQ1JPZG1keG91YmNBa2dabnZZ?=
 =?utf-8?B?V1Nheit1NHFNcjgxbWxrTERrMmtUZkJkWFRJcTlFTlczU1lpRDBDZ3QzVWNl?=
 =?utf-8?B?MDdndXArOHlDMkVvZk9mTWk4dnhnN3J2WlZzdFJlSW90UkU5ekF1M00xbHJa?=
 =?utf-8?Q?aCLmnqT57OLB0zHhRp0fQZ3PT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da888d0f-7e69-4bf9-caf0-08dce13a0d0d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 10:24:22.8098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f04z0Dx9AobaXbkYADQhoySawYGZby19OhgnxSHDxsZizDxIUDMDxca3AAcwvcTPSnMnsD7njEFWK6Fo+P7q1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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

Sure Christian.

Changes related to dummy functions i was planning to remove in a 
separate patch as there are many empty functions.
Also related to using the local variable ip_block also i am planning to 
take in one separate commit as it impacts all the functions where these 
changes are being done.

On 9/30/2024 3:49 PM, Christian König wrote:
> Reviewed-by: Christian König <christian.koenig@amd.com>
