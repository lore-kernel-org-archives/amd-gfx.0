Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C39BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 11:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C8261360
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 11:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65C8261360
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0062F6F511;
	Mon,  8 Nov 2021 11:14:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C5D6F511
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 11:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh52zGDysjX5K/QqfsFi0+8Po563kpmAz4P9jv3E2nupA3dSedPVSrvX+md0NP3u0k0I9E97bL3s2t2WdF1zFDG5ZK/K/SifJhXKA/VU54VhfTevC+bqEj8+fPuL6Gos8aX/pMRI4j9hjbiFxWqtx9DenSd5CovhCrmkJEuX9pQELZ2WsLamWIOeDC/Q4q4583+3D8bQoyrpEk5CWw7qU7SvhM75uAAOSrJJmp4GlssUfpRo/UpAX1C6aHeDQNVZ+m4IglMDfMHbmTgwPjUdnAMvvoWPJZxlNaTAxHLnJvLfaVjA7fJr5ZkrCM4Px0TBxaHKVRbsAfn+v6rMYgobKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLjs3WMZRVjCewn6Y6nCOaiMomdRcLrmJISmY9phEVw=;
 b=AAbD+UZdeIIKMEuO0lWDBmVzuKyu0J8LLIfLOnWMsCGJ10Lg3N8F3NWsECNPDzgv/kStQdgHgmpsJEgdgufl81FEXicPlrEH1qeaZdz2vYaC+2ROScmXmk/C76qolCP79eIo0DqivDq9CXFwZvQ5rNY/vWOQVcXE7q8Qzyc4+9IzHTv0VtFV7XPKD2bR6ptAUrdSluGtYpgMKjDDlNq5EiLnd9BBP2ps47PpfNlJkadC3NhypxDjF+U1sC1J5nDr4a3hJ1BXgQ9Jfqla2lGOpF5pRAZYHr+Tk6f27SWfloXKtfaevQ2+zoj8MrWvchyDvV+1cwIe1UmnL+95xsyxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLjs3WMZRVjCewn6Y6nCOaiMomdRcLrmJISmY9phEVw=;
 b=miv1/KgQkAREnsS+UnDrL5d8ZsobHuRnPO19na0LTac0ORAeP0TYckl7I+PFeXjnqmEEu3jbKH+0JVpCLxuTXjXdvUsnzjOnBFobKtwtpBdH0/ano1FrvA4OWkEsHc5Se9Vlw2maiRDVxotZauda2Ckqpv8tGW6Xjq3RB0vIjqE=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 11:14:23 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7144:b327:ded5:3f50]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7144:b327:ded5:3f50%12]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 11:14:06 +0000
Message-ID: <af95f11c-c70c-352b-da5a-3a185426d696@amd.com>
Date: Mon, 8 Nov 2021 16:43:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: log amdgpu_dm_atomic_check() failure
 cause
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Shirish S <shirish.s@amd.com>
References: <20211108084054.11162-1-shirish.s@amd.com>
 <d85871bd-72af-d02d-5c23-f3c13ccbfd52@molgen.mpg.de>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <d85871bd-72af-d02d-5c23-f3c13ccbfd52@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::8) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
Received: from [10.252.87.231] (165.204.159.242) by
 PN2PR01CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 11:14:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5db1d68f-0e53-4410-70a2-08d9a2a8e0b6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1725C2CE28C906EF4EB2571DF2919@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7om0OuoQ9Q7HWaXfGbP4y+6cTIMBkeb2D8wi7uTMKYgudu6g8smq0wMbRG/qlQz1KTbY/Y06gPpKjn24R89E2Kp8jctUZqxGYJGasF/2tJtebCmBzbeNsamp3paueeg6N3v1jU8OaSJsgLfP/NBhC3r019LwG+OuPxHdot63oqnBYmyzgy/X4GW9EYCqv6yBS5jPgDZLEnGN0UemhL9V99lEcDuJ9p+3YhbntcRsLItBruCYfZ2dWIrk3bH8l4+TSkHLxiT95x/j3ZAJlrFpUELM+uguKh0X7Gg7/1e+XG1X2atr+nZGaKDaGlmf33cfqar1tEpCqvSdhy/1FrMZHoeAJiu4Xef6fGRoc7tD+uCr+dA8NZWDDrHU49Ft30L1mSXbtNJqmxlJ3kxWnkGd7O1GvevWii8XVkJmTzrE5sIaZKIohHKQ+KQIvPHB3luOWLyT0EyeoccU2lYfNR3IhcWAmn9Lne6CTshnuUdbZArrPuGeQXZackfiwgNQkrUGHMze8JUKNfQ45M44fVRKJgaouD1n+jAYMTipOU27gzc+uhbJ5L5VaTqjeh36QJwAb0e+5oFqtfiHffdhqoCWqR9/TKofRdMSoUDD9FY6eh+q9+U/s4anobGvzTKhWOmNGVrGlQ99Am+3pD3Nrr1H7GP0NnGBcCtx61AoOwFvFTOyZBUZLE5I9pUDHgpLFfhA+vTBgeT7YqUfk+AO3VAlLfs7IIJDjaZuj64OnVdx6DHBrbqr4cC7ShIOWlAw9Khz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(4326008)(31696002)(16576012)(186003)(316002)(2906002)(8676002)(26005)(6666004)(6486002)(53546011)(508600001)(66946007)(31686004)(8936002)(956004)(6636002)(2616005)(66556008)(66476007)(38100700002)(83380400001)(36756003)(110136005)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJ3Q2F0RTIxY2tVNldKRWE4Yk1zZmlYMnNpTzUrRlJrajdKdjhmY1NpSWdX?=
 =?utf-8?B?Z2daZk5ienphR2tsYjdIZnhMUlAzVlphZ3YwdWlZWHhpTmNaTmxYZVZiRFdL?=
 =?utf-8?B?RnRGU3VjVWdqSm1OenJCRC95NzloSWNwYjQzT3RWL3MvRXdla09SK2hJVi81?=
 =?utf-8?B?MHdKRWdnVFhIOC9MMEFuV1VUN0VLZ0RQa2RMbW1hdmlOUkIwNVM4K3lFbUhM?=
 =?utf-8?B?d3k2V1R0SFhhM3JYdFEwcEtkcmRleG5odmxFVWFzVnNMcllaalpjOU9FNlVW?=
 =?utf-8?B?bDVKTDUyRXRUSFlsNG9wSUNmM1ZFL1llU2xnOVRYeW5xbEcwN2ZFSTlIY0xR?=
 =?utf-8?B?VmRyWlNseXhZRGR6cnFseFIvc1RYY1JTZDdzYU5TZk1NSHlQNTN0V2g0NVIz?=
 =?utf-8?B?NzNid29CRXpzL3JXdThnOUZ1aHM3bDVudWV1SWdJR3RidUxzcjFKcVBQV2tK?=
 =?utf-8?B?NkUzZG12djFKVnh2UTNBOFhFelU3ZWN3NEgvanZWdDdpNWtHVjR2VUM3dHF2?=
 =?utf-8?B?Ukc0YnpqREk5MjZ3QVBHVlVzSmhJMXZERnV1Wnp2L3pYaXZEbTB1dnhmOEQ1?=
 =?utf-8?B?ZjBYbS9UaWlUVldUNUxkRi91Qmk3M1dudk9FcU56alpDTzlCazJaTnV4UnV2?=
 =?utf-8?B?blAyUFdreXBVVi9tUE0rSDlNSDdFaENoZWhLdTQ0MmV2Nm92aVlVVFdKeEFx?=
 =?utf-8?B?VG9IMjN5NkxxUkt6YTd3TUh3UkM2OGNoMTl1am1yU01DYzQ5L0w0ZVJBMVhn?=
 =?utf-8?B?NVV0eXJyWHZKVks5WUNDbHdZeVp4NTg3WXgyMkJoazRIaW4vdTJqbnBGNis0?=
 =?utf-8?B?V2k2Rk5VY2cxMFIyeDdhUFNzWHlkMHZsYnVHdnFJVllML1dTbzNBUzNRTExB?=
 =?utf-8?B?clMyaXZRQjVpUzcyell3RnlvY0Y2WnJXT1gyK3FHSzh5QmFRb3pQLzF0NHly?=
 =?utf-8?B?UkppRHV3OGh6dnpzTEJCQlMxeC9wZkZDWGNOQ3BqTnhJaituTEY5czBRbnVM?=
 =?utf-8?B?TExWdWtEWTFvZHVIdWxobjNBdW9PUnZmUGZWNXFvb0N5dHBHbzdwUlRCZ1c1?=
 =?utf-8?B?RnFCQmdFbHVJdDRZMG9NVHJUYS83Uk00MjdPNVpCSFN1ZWQybmVsT2kyRE5D?=
 =?utf-8?B?eXl1aCs2aVhyRHBpelM0ZDJ3TmFIYVFkbFJRLzhMTmJlL2NBdVZvZmpJVXRB?=
 =?utf-8?B?bkljUVNJMi9VRVZGOFkwVUJzMzA2VFN6M2hWM3FHRkVDa2h3NGFCN0FuWGZX?=
 =?utf-8?B?a0dsbDFQZ0tuSXI2SWZ1ZzQwZW1seEJmOGVUM2QwVGtHZUJPaVlobTc4OWh0?=
 =?utf-8?B?TUFxSzNXbnZXaUJ2ZGd6Ym5tLzRtYU5BRjVHTGlCMEMwUmozMnNpZ1QvTXE2?=
 =?utf-8?B?K2U2S21MSENsendyZEMvajJVTkEyUUgrbEFLNXhXZFVtWTdRc2NKMGJEQWpG?=
 =?utf-8?B?aEhsNWFoSDV6NDEzNWhHbjVPUEJqaW5YUVoxeGFsQlNOb0ZBdmt2blIxbmdV?=
 =?utf-8?B?UC9KUFd4ekpTQnRkV0xMZjBYVmJXSnkrbkhTRk9IUDNjNTNjSHdQVTFueUhx?=
 =?utf-8?B?WnBFQVo3NmV0VEMwZmQzd3JiTlIyWkFHUXloMG1jVkoraVExd05oZG4xaHM3?=
 =?utf-8?B?VkVQYVRkK09BaTVDMUJSV2FXdTBBVndpYWdVcC84TjhDMTI3RWo2V0dydng4?=
 =?utf-8?B?anpWYVhEeHZzWnZrL3huRFREUENHNUFLbU82Umx2SHpUOWxzd1lnSUNma1dQ?=
 =?utf-8?B?dHdib2R3NDZMRDROT0E4QStpYUNWQnI1bklna3dyK2RaeitQamZJMCtHdWRX?=
 =?utf-8?B?R0ZkQzdTL1Q3TEV4ZEJWSDIzVkR3ZVNObGlRTXZZYTg1ZWgxbWlBdDRzZXJP?=
 =?utf-8?B?T0lRMk4vSi92bm5Kc1BmYWRETnA4enFETWZBRG5oU1MvYVIzbVNSK0FmRStN?=
 =?utf-8?B?bXlVT3VaclRvVXlQc2JMUnBCdXk0QWhaRFdUZ05KYXRTRVNwVU9qUW1DVFRV?=
 =?utf-8?B?Wkg5WDcwVFNNUkdRYk54Zldoa1FCUGNQU0Z1U1J2UHE1bVg0b3FUNkJDbEV5?=
 =?utf-8?B?dm04bmZWdWlSblNSYVQ3bllkSElyNHJ3NWVObG1DUW5kSnhyajIzd3JPb05q?=
 =?utf-8?B?Z0RuSUlEbTQyZFBXYkFBSEFZdlJSaXFmUnFyZVZOU3pjaDJzWWNoMzJsaGhC?=
 =?utf-8?Q?giqfViLfqIsJPYLfZEaWWfQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db1d68f-0e53-4410-70a2-08d9a2a8e0b6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 11:14:06.1102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrbJqYMhsxFjX0BM12nkE77X2+H+5EORZw+DfBMRVYWsBf1aVQ0yg2KoC4x2ROFRmRKpzyeWpbFNwEwtMcw97A==
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

On 11/8/2021 2:27 PM, Paul Menzel wrote:
> Dear Shrish,
>
>
> Am 08.11.21 um 09:40 schrieb Shirish S:
>> update user with next level of info about which condition led to
>> atomic check failure.
>>
>> Signed-off-by: Shirish S <shirish.s@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 70 ++++++++++++++-----
>>   1 file changed, 52 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 1e26d9be8993..37ea8a76fa09 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -10746,8 +10746,10 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>       trace_amdgpu_dm_atomic_check_begin(state);
>>         ret = drm_atomic_helper_check_modeset(dev, state);
>> -    if (ret)
>> +    if (ret) {
>> +        DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_modeset() 
>> failed\n");
>
> Does the Linux kernel provide means (for example ftrace) to trace such 
> things, so the (generic) debug lines don’t have to be added? Or is it 
> to better debug user bug reports?
>
ftrace requires additional tooling, am trying to avoid it and make the 
error reporting more trivial to the developers, in case there is a 
failure in atomic_check.

Regards,

Shirish S

>
> Kind regards,
>
> Paul
>
>
>>           goto fail;
>> +    }
>>         /* Check connector changes */
>>       for_each_oldnew_connector_in_state(state, connector, 
>> old_con_state, new_con_state, i) {
>> @@ -10763,6 +10765,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>             new_crtc_state = drm_atomic_get_crtc_state(state, 
>> new_con_state->crtc);
>>           if (IS_ERR(new_crtc_state)) {
>> +            DRM_DEV_ERROR(adev->dev, "drm_atomic_get_crtc_state() 
>> failed\n");
>>               ret = PTR_ERR(new_crtc_state);
>>               goto fail;
>>           }
>> @@ -10777,8 +10780,10 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>           for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, 
>> new_crtc_state, i) {
>>               if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>>                   ret = add_affected_mst_dsc_crtcs(state, crtc);
>> -                if (ret)
>> +                if (ret) {
>> +                    DRM_DEV_ERROR(adev->dev, 
>> "add_affected_mst_dsc_crtcs() failed\n");
>>                       goto fail;
>> +                }
>>               }
>>           }
>>       }
>> @@ -10793,19 +10798,25 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>               continue;
>>             ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "amdgpu_dm_verify_lut_sizes() 
>> failed\n");
>>               goto fail;
>> +        }
>>             if (!new_crtc_state->enable)
>>               continue;
>>             ret = drm_atomic_add_affected_connectors(state, crtc);
>> -        if (ret)
>> -            return ret;
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, 
>> "drm_atomic_add_affected_connectors() failed\n");
>> +            goto fail;
>> +        }
>>             ret = drm_atomic_add_affected_planes(state, crtc);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, 
>> "drm_atomic_add_affected_planes() failed\n");
>>               goto fail;
>> +        }
>>             if (dm_old_crtc_state->dsc_force_changed)
>>               new_crtc_state->mode_changed = true;
>> @@ -10842,6 +10853,7 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                 if (IS_ERR(new_plane_state)) {
>>                   ret = PTR_ERR(new_plane_state);
>> +                DRM_DEV_ERROR(adev->dev, "new_plane_state is BAD\n");
>>                   goto fail;
>>               }
>>           }
>> @@ -10854,8 +10866,10 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                           new_plane_state,
>>                           false,
>>                           &lock_and_validation_needed);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() 
>> failed\n");
>>               goto fail;
>> +        }
>>       }
>>         /* Disable all crtcs which require disable */
>> @@ -10865,8 +10879,10 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                          new_crtc_state,
>>                          false,
>>                          &lock_and_validation_needed);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "DISABLE: 
>> dm_update_crtc_state() failed\n");
>>               goto fail;
>> +        }
>>       }
>>         /* Enable all crtcs which require enable */
>> @@ -10876,8 +10892,10 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                          new_crtc_state,
>>                          true,
>>                          &lock_and_validation_needed);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "ENABLE: dm_update_crtc_state() 
>> failed\n");
>>               goto fail;
>> +        }
>>       }
>>         /* Add new/modified planes */
>> @@ -10887,20 +10905,26 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>                           new_plane_state,
>>                           true,
>>                           &lock_and_validation_needed);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() 
>> failed\n");
>>               goto fail;
>> +        }
>>       }
>>         /* Run this here since we want to validate the streams we 
>> created */
>>       ret = drm_atomic_helper_check_planes(dev, state);
>> -    if (ret)
>> +    if (ret) {
>> +        DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_planes() 
>> failed\n");
>>           goto fail;
>> +    }
>>         /* Check cursor planes scaling */
>>       for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>>           ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "dm_check_crtc_cursor() 
>> failed\n");
>>               goto fail;
>> +        }
>>       }
>>         if (state->legacy_cursor_update) {
>> @@ -10987,20 +11011,28 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>        */
>>       if (lock_and_validation_needed) {
>>           ret = dm_atomic_get_state(state, &dm_state);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "dm_atomic_get_state() failed\n");
>>               goto fail;
>> +        }
>>             ret = do_aquire_global_lock(dev, state);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "do_aquire_global_lock() 
>> failed\n");
>>               goto fail;
>> +        }
>>     #if defined(CONFIG_DRM_AMD_DC_DCN)
>> -        if (!compute_mst_dsc_configs_for_state(state, 
>> dm_state->context, vars))
>> +        if (!compute_mst_dsc_configs_for_state(state, 
>> dm_state->context, vars)) {
>> +            DRM_DEV_ERROR(adev->dev, 
>> "compute_mst_dsc_configs_for_state() failed\n");
>>               goto fail;
>> +        }
>>             ret = dm_update_mst_vcpi_slots_for_dsc(state, 
>> dm_state->context, vars);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, 
>> "dm_update_mst_vcpi_slots_for_dsc() failed\n");
>>               goto fail;
>> +        }
>>   #endif
>>             /*
>> @@ -11010,11 +11042,13 @@ static int amdgpu_dm_atomic_check(struct 
>> drm_device *dev,
>>            * to get stuck in an infinite loop and hang eventually.
>>            */
>>           ret = drm_dp_mst_atomic_check(state);
>> -        if (ret)
>> +        if (ret) {
>> +            DRM_DEV_ERROR(adev->dev, "drm_dp_mst_atomic_check() 
>> failed\n");
>>               goto fail;
>> +        }
>>           status = dc_validate_global_state(dc, dm_state->context, 
>> false);
>>           if (status != DC_OK) {
>> -            drm_dbg_atomic(dev,
>> +            DRM_DEV_ERROR(adev->dev,
>>                          "DC global validation failure: %s (%d)",
>>                          dc_status_to_str(status), status);
>>               ret = -EINVAL;
>>
