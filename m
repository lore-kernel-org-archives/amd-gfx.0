Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E62C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 11:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2A561350
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 11:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA2A561350
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967AF6F4C6;
	Mon,  8 Nov 2021 11:11:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C5D6EE35
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 11:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLjq7yy52yqW8ig62+kZZQGWNtWGQWuN33M0iuXVXjKGLLaZCi6HklHL3XHdlH/V2C8vxhhKa8LJkspJ5ZuJZ13Br1IGX0mJA9EaR9wfdzoMkhHBELSizVZid+BAZvVR4KjQFg3IKhiB/UMDIGNbCo70xH76KVGYfDJZWQR5pLTlfZbMkM7OshPUGseCxXvoq2/4UijfERjP656TCD4KRTa/FdQlQobgTjB9gbbjvW1wkP30K93ZrTgOaxjLSBQaae7VgCVK68QY/FXG9jzxkF0ceozjTRVs7P1O++IICCdp6/OYueS31HQkomCYTy1JvsQeVzDy0gqH6L89FeylwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGm3M98AUKgbd5aL9xkuHC99CkzIyGfXMER+7sfmS5g=;
 b=l+ie674VGF0Miq1T6tqmW/WFO3Cm4OSES9ez1u8YnXIAs80X7V7IsmSw18lAPlr9G+M4qkDxmG8BmI3Agof0yL14NvqM22/K8bNzh3irrv0KDNMXSQf1DX49ke0dGkTz2NnibD4dYNi3LxE39qmoSDMKYttSncKQcfjG4Qp5vW2VqU6tKdQx/d6fdJh+zD0NcwTzLjI8HVhua4jg3dsgAGS967tegOKQJRKY9GQ1IqqM7xmOuLq0BavHg5wB634voirRZ7kW6/GgjLzuQBtQcO++ofTw++bEFaqmx6wZE5viZuCoNG2wTt/wfBAn6Qv3ZrQNkFCUJ2MW5xf1LGpX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGm3M98AUKgbd5aL9xkuHC99CkzIyGfXMER+7sfmS5g=;
 b=M3pbYcl95a2Led5eHE45W4JKn6mCEYcA+Ol0d4KewHaRmZ6YnZC5Z+Nj29e2z/DQeVLSoDmOwvz60DFwkzKKNyZyNds67X256nuxmKKrI6mQFXA5HG8w2JwhiMu9uYEPGOIlxpjtuy9XglYngOSL7Ac1JRtzVs31qBsmNGRQktI=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 11:11:54 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7144:b327:ded5:3f50]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7144:b327:ded5:3f50%12]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 11:11:54 +0000
Message-ID: <33c6efa7-3c7e-be2c-6513-f9ec82e63faf@amd.com>
Date: Mon, 8 Nov 2021 16:41:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: reject both non-zero src_x and src_y
 only for DCN1x
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Shirish S <shirish.s@amd.com>
References: <20211108081514.9925-1-shirish.s@amd.com>
 <94d54215-6500-e5df-1069-71706431e059@molgen.mpg.de>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <94d54215-6500-e5df-1069-71706431e059@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::21) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
Received: from [10.252.87.231] (165.204.159.242) by
 PN3PR01CA0093.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 11:11:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab4c7128-c455-4d8d-485a-08d9a2a8924d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Antispam-PRVS: <MWHPR12MB172582633FCAB6F0EFA15871F2919@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aon870B2PBrXIxXViyVW3KgBs8j/zYt3h0NKztDGXMceI6Cu9sxyqlETG+bOMR4XQhm/796MIM4y1r/wGeIhQDk8+WkSiySxMU8NhigUWWHYNB4PLL82CtkMcNN/THN4o/EWS5B0nEL4Kr4A3PiqZuvApLY/RZOY9oUFHc5BQ3x4ujAduHUzUkz59I9EKC8DeL8O1/hcN0t1FEj0hJnUI+EWtA3KWvsRiPis7D+u7qGnp/vaJ02y1TUTAvvescQfa1T9FecUk1i6qZmedJLqc5ZpYqEgn8i5qzNmA7IgZYk4OFtqdh7r6VRxKyZKAhAkijQ0R4DmfIfr3QQFppPTx5biKjoK7GEl6Mbr0gjnL0P33Qvc+/UfdOwB0yVkCdHxXvgBe4aDcrDwH6utUxKQP72E1K5a7BiOG94iBFPdMf5m8ykppKUkeCQqtZuu1z3meB26kOjHQPit4Ve4uLHMBb0diwbCzvI401DaUSAKyymjwdykozI21LJFh3uFuGTisQvseE4F5aotGiDhNvkbym1FCMNBSye7+RJJtpR04BUPQxsQKKkVynll9KekLKK2pjRVPwRb4RvhJhGp920P/54dPyD12eMHw5fbawE2cDNZPvgF/JiUrKdSzdawU730FyxBFTKQrcd1ni0muAd9oQVgvHPJM5d3zX+DQ6N7W8YF55AESWpuVDpMr0A7nxxmcTZnPluJbcmiAbIETwpX/P3RX/akcSTT3FCcztBQ3EXldMmrmh6cnkfr86WrLG5g8VWaaF9ueyNSTqQHc4yjoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(4326008)(31696002)(16576012)(186003)(316002)(2906002)(8676002)(26005)(6666004)(6486002)(53546011)(508600001)(66946007)(31686004)(8936002)(956004)(6636002)(2616005)(66556008)(66476007)(38100700002)(83380400001)(36756003)(110136005)(54906003)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFlYMGo0L1oxL1pNbUpqZzI3Ri9ISXhBazlaM1ZHWkFxWWRwaXRubWp0M2ZR?=
 =?utf-8?B?a2g0ajEyVG1ocDFwelVhbmhZdmhVSjhpaFhLTEs5TTNXeFNIQ0syakt0VWF1?=
 =?utf-8?B?ZEwxMHRaSit5QU5obnJCaXY3RG5iQ3FRYytwWG43LzZ0VDcxVmloS3FIa2l2?=
 =?utf-8?B?SU5KM1p2S1pSZ3k3RHYrOGVmc1ZwNlpiTTVWNEd6U1FmUjd1QWdyN3hhdlAy?=
 =?utf-8?B?b0tPcGpTcnV0NUhPNWhjbDRqZzRmVmdoTnpZdmlQNzEvc01vZUh1blM2RDNq?=
 =?utf-8?B?V04rVmJnUmR1aVQxNGcxMzJOVU83ZVk1dEdYMzZxSWEyWlJ0SDMzRUg1MFJI?=
 =?utf-8?B?a3NqNURSU1BhT0o0a0RwMnZLV1NzQ0FlRUhKazF4TjhUOEp4QnhKY294d1Fq?=
 =?utf-8?B?RGdRaEFqUzBtaHFSYU5yTk90aWYrTHBJVW9BTnd2ZEt3T3NoYjg0RUFhRmp1?=
 =?utf-8?B?alB4eVNpZVA5aUdzcnNiY2ZadDFCTWs0Q2ozUDdGTFBWMDFrZk9SNE9hRTR0?=
 =?utf-8?B?allSczZFeFFwZW1lTGN3Ry9UcmtUeDVybW8wZkY1V1lPYmRIKzRUKzRhQlNy?=
 =?utf-8?B?blp2V0w5Z2NLcWFjUUVWWGl4NElGTUh3MGlSU1NPeEpqYiticE5TTm1xc09l?=
 =?utf-8?B?KzNBMlE4OEtUM2RHZWRCeFVMTFFQQ1pNTi9JempCL0hoTlhOVjlOWHpGdXVi?=
 =?utf-8?B?YzNZZHhhcmYwb0QxWW1BSXBTMkNyUnlNb0o4anF6NmZrSWoxRXNxRUZjaVhi?=
 =?utf-8?B?WWVrTHhQaStheDhaRnI2bnNDdlBCS3dzSkRuejI3aXg3c2tBWXZzZGh1RVVV?=
 =?utf-8?B?OThYalFleFVPdHZxVVpBODBpeDM2b25sRTJ0dnZRT2RIbzBUKzZPMWRRcndH?=
 =?utf-8?B?QUpNS0hOU01IZnJnQkd6bm1kcVJYSmVpQ3VMSUpLRkhyeVF2Vyt0SFdWTFZs?=
 =?utf-8?B?QVphZWRKNGxBQlpIV0JMaUJLQWVHK1E0YVRMN0w2OFk0anVQRHFNa1g5Z2VQ?=
 =?utf-8?B?SENZNTdXaGZ6S3VpQ0VGWHVRTlNmZ29QVGV4M1pLZENsMXpVVnIxYi84bVE5?=
 =?utf-8?B?K3E2QnF3eVd4SWczeTZad0pWWjZTY0MxZXNjQk9lbVMzaXlrczloUWl2dUVC?=
 =?utf-8?B?eVJPT0sya2IySUFnUXM4OU0zNCtCVDV2V05ZejRWNDNwcFVSblo1YkRsZ3A4?=
 =?utf-8?B?N2xZakpCNUhkM3cvbmJlelo1R1g2SmljTitwZkFXai9HMXVydVg4U09PdDcz?=
 =?utf-8?B?N1MzOGdFMUlRVHY4ejlzQ3lySE8vMzNjb1JPRTQrZzZtK094ZmZNZHZDcDVK?=
 =?utf-8?B?QXVscG93VXNlcjFWdEJQbWwycWFvSnNhVmtnWWQ3TEMxYTFtNlBMYTRtQ1ph?=
 =?utf-8?B?eGJ3VnJpUHNzVlJtb3B6Uk9VTDJINlVLd25CU0lDSHBpUWhMNW5OU0QzTzZJ?=
 =?utf-8?B?Wm9ZZGxIV3ZkcFIyU05XckJEa1F3TE5RRmJHQm4vVjVKcHJYZjY1QjhhY1dM?=
 =?utf-8?B?Wm94UlJjNWVSWit6S3VWMDcvdVRwbUFkRlRlQUpENC9paEc2KzlaNDBnYU9V?=
 =?utf-8?B?ZktvYSttT1pXOEExaXVQUHBNRGFCR21EMUJVRXptQUE5N0MwTFFVZDBTV0FY?=
 =?utf-8?B?SlI2b0hPek1LRVdoOVpqK3FsN3dZK1RnNm9iRzVLZDJPYlU3akxBTmg2bXlO?=
 =?utf-8?B?ckxWVDNrY3FBSVpnSFlZdWxIeGdFemVDTENWZDdPKzc3MXIrSXE5S2ZyUUFL?=
 =?utf-8?B?Z1Evb0FDUHBTQzh1akNYWHMybnhaZ1RtdE1OSlpYNmo3VDYwdnYvYUxUTm51?=
 =?utf-8?B?WmQxaU93YncxeXB6SGQvSDU3YW9Udkp5WmpPeTFlclhJSnFQTHRVTFlaWVhK?=
 =?utf-8?B?akJXdGNrYTVYSlNHSHZ0VGpodEo3ZEhzM0laN3hVWVFkcjBra3piaWE3TTFl?=
 =?utf-8?B?M0duR1ZiRWpjNTVFZElnV1ZINHJjdCtzZVBuUHBnM3JMTUdhdGhLc2Iydmh2?=
 =?utf-8?B?VTc1d2tCdTNHZUFmWXRtVk91S0xZV29laFArdHdud29lbWcrSzJZdXdydmRm?=
 =?utf-8?B?QUtLMElRYm9JU3FndjhNcmd1US9iYnN0OHJBRTRXKzkzSTFoMWpWWU1ZaUdG?=
 =?utf-8?B?MW5KZGdKV2YyL3NHNFBVQXJodDhkSHcrcmpTajFJYWtkRGdESUZmc2VHMzFM?=
 =?utf-8?Q?xSTuf76uKveTM5Xfwq6Uqv0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4c7128-c455-4d8d-485a-08d9a2a8924d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 11:11:54.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArblKV9cTcIN7TGFQ+WeonSAPUaWLAl2FZXsbX0esRyA0CgitNYVsfBu2fjo3abs3e5egCyGdTeAkGQTV4voZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Paul,

On 11/8/2021 2:25 PM, Paul Menzel wrote:
> Dear Shirish,
>
>
> Am 08.11.21 um 09:15 schrieb Shirish S:
>> limit the MPO rejection only for DCN1x as its not required on later
>
> it’s
>
>> versions.
>
> Where is it documented, that it’s not required for later versions?

This is a workaround to avoid system hang & I've verified its not 
required DCN2.0.

We generally don't have documentation for WA's.

Regards,

Shirish S

>
> Shortly describing the implementation is also useful. Something like: 
> Require `fill_dc_scaling_info()` to receive the device to be able to 
> check the version.
>
>> Fixes: d89f6048bdcb ("drm/amd/display: Reject non-zero src_y and 
>> src_x for video planes")
>>
>
> I’d remove the blank line.
>
>> Signed-off-by: Shirish S <shirish.s@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 1e26d9be8993..26b29d561919 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4572,7 +4572,8 @@ static void get_min_max_dc_plane_scaling(struct 
>> drm_device *dev,
>>   }
>>     -static int fill_dc_scaling_info(const struct drm_plane_state 
>> *state,
>> +static int fill_dc_scaling_info(struct amdgpu_device *adev,
>> +                const struct drm_plane_state *state,
>>                   struct dc_scaling_info *scaling_info)
>>   {
>>       int scale_w, scale_h, min_downscale, max_upscale;
>> @@ -4586,7 +4587,8 @@ static int fill_dc_scaling_info(const struct 
>> drm_plane_state *state,
>>       /*
>>        * For reasons we don't (yet) fully understand a non-zero
>>        * src_y coordinate into an NV12 buffer can cause a
>> -     * system hang. To avoid hangs (and maybe be overly cautious)
>> +     * system hang on DCN1x.
>> +     * To avoid hangs (and maybe be overly cautious)
>
> I’d remove the added line break.
>
>>        * let's reject both non-zero src_x and src_y.
>>        *
>>        * We currently know of only one use-case to reproduce a
>> @@ -4594,10 +4596,10 @@ static int fill_dc_scaling_info(const struct 
>> drm_plane_state *state,
>>        * is to gesture the YouTube Android app into full screen
>>        * on ChromeOS.
>>        */
>> -    if (state->fb &&
>> -        state->fb->format->format == DRM_FORMAT_NV12 &&
>> -        (scaling_info->src_rect.x != 0 ||
>> -         scaling_info->src_rect.y != 0))
>> +    if (((adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 0)) ||
>> +        (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 1))) &&
>> +        (state->fb && state->fb->format->format == DRM_FORMAT_NV12 &&
>> +        (scaling_info->src_rect.x != 0 || scaling_info->src_rect.y 
>> != 0)))
>>           return -EINVAL;
>>         scaling_info->src_rect.width = state->src_w >> 16;
>> @@ -5503,7 +5505,7 @@ static int fill_dc_plane_attributes(struct 
>> amdgpu_device *adev,
>>       int ret;
>>       bool force_disable_dcc = false;
>>   -    ret = fill_dc_scaling_info(plane_state, &scaling_info);
>> +    ret = fill_dc_scaling_info(adev, plane_state, &scaling_info);
>>       if (ret)
>>           return ret;
>>   @@ -7566,7 +7568,7 @@ static int dm_plane_atomic_check(struct 
>> drm_plane *plane,
>>       if (ret)
>>           return ret;
>>   -    ret = fill_dc_scaling_info(new_plane_state, &scaling_info);
>> +    ret = fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
>>       if (ret)
>>           return ret;
>>   @@ -9014,7 +9016,7 @@ static void amdgpu_dm_commit_planes(struct 
>> drm_atomic_state *state,
>> bundle->surface_updates[planes_count].gamut_remap_matrix = 
>> &dc_plane->gamut_remap_matrix;
>>           }
>>   -        fill_dc_scaling_info(new_plane_state,
>> +        fill_dc_scaling_info(dm->adev, new_plane_state,
>> &bundle->scaling_infos[planes_count]);
>> bundle->surface_updates[planes_count].scaling_info =
>>
