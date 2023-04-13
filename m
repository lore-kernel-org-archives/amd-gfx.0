Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724BDC77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 18:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF3B10E160;
	Thu, 13 Apr 2023 18:10:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C63710E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 18:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi9aH5NAgd1pDlS+8OgC7mmlBH/wRbocS0xmp7qELZ9FR2EzneuRAS4bMnXXBhwx+qeec6398J2Lm8LQNTzrFeGw/n0iBypZ4+xngnvJZC89H/qOtqH2gAjFlBrsNthgIN6oq/Ub2x/xeJ5dfTlWz4qO0Iasogd567oQv8FyfFuLrKtwjG1+ZGbEg5Rd+Kw7UzRwhZbwbqMCn3OE8RNZcBWQCWcoieuZBEx+kzw0mXcE538+u8W61Y6ith40KCeGJ1OXLajsQxjGKRBv0kPmOHiP19ZFs3KnDeX8Qb+Kmgby3LFwkHX4lB8OW6rRUskDJCTiI1iNVSU700dxP0Gdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4t9TTzS9EqUc+yR9vH56mDCwZ8zm9TVtbYJF9JsnSw=;
 b=atLEFJscAadBDaNRpNSz+f0k49K3x7bn+r/FhUlOZucq2NOUgGnna/xCFfguJkn4iou6shFSrHfb07qpBcaHaS8eXSH9UXKMpbkrLf2gs38qogeY3jf1yHmxT//g6YQ6XwI+Z9u95Ld45djO47RCUw9JjM3ijQH/i4hPBxcKJ4m0Ysz7Wkzx9nMFJfvVKxUJGzofcF05TCUfW75h5rTSQUz1wwEJuIzOmyCRUclyZJxB5od25WEqYHJ6IS7rCi9NmWuzZwX/k0wfgxHNd8wmfckA93iUY0PGGcvfYNcwe+3/ji+dPeFQyf2I7DZX8eUOKb9xRJJkcS8GVEvYZpV41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4t9TTzS9EqUc+yR9vH56mDCwZ8zm9TVtbYJF9JsnSw=;
 b=cqQluSbOM9SgoUOHxjNsZryP3Lvhbl2zmO1icZ7OIz1ObCJbCgazjD79RwR+PzU+6alTURVv2i7lvnIKCVdKYMECrore0gL+y1JqhKOlu7ITNnhBeT4TeeJW1auQDeFwTgZP7WebVZABMnyw2F+DUD+Jfmd3C42YrT1Q+UsGqlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 18:10:42 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 18:10:41 +0000
Message-ID: <dc9c0303-6b20-e563-f451-ee2587905a6f@amd.com>
Date: Thu, 13 Apr 2023 14:10:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] drm/amd/display: Improvise error handling for DP sink
 power states
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
References: <20230413180230.2303096-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230413180230.2303096-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::31) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a85be7-4eb0-4978-3688-08db3c4a6491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2ShBss2P9AK5KN8nEsEKuRBRYzQMCU/WCi96XURBNjULkPv9HKGCI6VUL63JV2e+/5Co4HEZ6Nx4qCCY8SEKiWPwz6LP8HZt1PABI28nHmZwI1JPJbnWAJ/sOHnfVnD0GWgKKaZUdMNngdyLsXK7V4FsANwv3ow83rlGyAUWaLZ/cmCouZ7llapiNhI2sj7mlm6ZemiciVAtbaZe1GrfYAXSI+gKfOLCurjhUbC+M8+MrSwhzLyFNrR0isJI7flRnC43istnDBA/MBF32w++m+VnOAcAxYk0AJrXGCD8ml/i5WUVD9nnMQ4zXViqNaPUglK0Hg0RaRyHvTTVP6sj6Kt/Yv4qqwaQqTV5ufF0ZFYGjR+MSReX7Y/k9/WVBYDjukNazpx+BX011MclJSyF06pR8WO+XUPIT/s1bd1TMSs11SKMAlYUZQdhvJPfGDcliWJp4DHI4Ex0upN58uKp2yLptxyrGsIS67bzBGHa1MgNqimZsqc2uCdRU3DV6aZ+qEeDthxl6CzBan3ofRim6301Zfa154D2hVC2zJkmYLIIUUNT+T73K9WMYJonWK6BvVNhSXc4t2KM/uAnu0mn3T77XKNXW9Ni3rSAcOjL+JvO/8QWi9rRI67gCLhqcTy3kdmpblvXbluKrEz0KxHog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(26005)(6636002)(2616005)(186003)(6486002)(478600001)(110136005)(6512007)(53546011)(6506007)(44832011)(2906002)(38100700002)(36756003)(4326008)(66476007)(66946007)(41300700001)(66556008)(316002)(8676002)(86362001)(8936002)(5660300002)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlOK0c4bjl6T0VyUDdsRHYvMFJVTlN5SEJQYko0aG9ZQmVVTWNBUE4vb3Fv?=
 =?utf-8?B?d1hwVUtiK1Bld0xIQkZoc21ZMzlmZFZhQXNyR2RGU0xVM0E2L2NwVnMwdkZV?=
 =?utf-8?B?RUdBNTd1elYvREpBTGNTMVluYmJJM2pEd0Iwb2RycmdscForSWVEQVZySXpq?=
 =?utf-8?B?aVdLNGlNQjJPK2dCVFprQTlLeUtIbzhvQ0FsMjFyNS9HTWhZcXQ4RE1seUNj?=
 =?utf-8?B?VDZmdzVxNGs0blRNUVpFREdjT3RRbUNxSTZVQ05ocHIwRDNyQUg0WmhseUp2?=
 =?utf-8?B?UzJHaUVBcmh4MDB0VGNxZ05jYktkaGszUm9XNVVROGZiemNUYlB5czdyb1Q1?=
 =?utf-8?B?YjJEbkR5akRwZ0NaK2RNSi9VeXQwNm9XTlF1c3pvZ1g1bjJKTnlRY0dpMWQv?=
 =?utf-8?B?d0xQUFpPVHpvMDA2SGU3cjNhODF3cEhrQ3hXb2xhbXYyT21WVGt5ZlYyRkZ1?=
 =?utf-8?B?NHRLNUVaTmk1eW10WTZuRTcvR0JvRnRWb0pUZENNZG85NmZIOWlDcmlrWFFZ?=
 =?utf-8?B?NEo4K2srSG45cGg1ZVo4TysrM3Nic002UGpEREp5RVptYkRqNTZUa3NwUU9D?=
 =?utf-8?B?Z2hUZXZLY0F5a29oY002VXV2NndUd2x3WkZPeUlMeWF4M0VNUWxKZFhNaEhC?=
 =?utf-8?B?T2R1T1hVYkZOdXE3ZTFDMlh5em9UUlUzL1p0ZlNBQW5WTHF0N29kYnlJMDVs?=
 =?utf-8?B?U1JZSndIWHZBY1M0ZG5SdnRIbUVvbG81OHNXMnZ5VVcvY1RKM2hQSGF3Z25Z?=
 =?utf-8?B?ek1EdEFzQ2l0NFQ1Ym91VTNOcCtobTVhMFRMdllGbURsZitoU3dJTTdURUxO?=
 =?utf-8?B?M2VUUmhSaGIvNkpheHJ1VkpRVFRRNVdnRGFKbHFXZSt2MlhYQjdjZXpWTmQy?=
 =?utf-8?B?K0U4U2s0NFFkcG13clU3Tk5GYmtqeFlRY2dpNWFtT0JrTXVJdjZQcVMyQ0pD?=
 =?utf-8?B?M3Q4UkJsN043SnJ6ZTBqZEZidXJIWDk4TnNoVTRBRkVRSS9LdFRrdmZVYkRu?=
 =?utf-8?B?bTB2UnN4TjQrSVhuVzBXMWRkNGxJcFRPWTk5U0FhVXJwMmU4SmVTZkNNcWJu?=
 =?utf-8?B?Um0yTkpOazFnV01lR0Y0V2ZRUU1ndXhSK09GaWRYRE12YzlSZWR3Z2h4RjdV?=
 =?utf-8?B?cDNtSFhTVmE5ckNXWjY4ZFV6dkNwNDZJUW9wM0ZOamFyc1FlSDFsWVVFQmJQ?=
 =?utf-8?B?RWRYdjZ5Z09rRG1pT3crcGlCT0hhOXR2Wm1zRy9EcnhPQWEyMzNzWjYveFkr?=
 =?utf-8?B?bEtweUhHWjBWdHpjaUtFcGlYZFBaZ2RXYkhVRUVYVVBPbU9LSUdCUEh6c2JF?=
 =?utf-8?B?a3NCazB2NTBXY09VOFJVcm9QWnBkdTNyTTdkYWFlWDNqaWdZa3R6Q3ZMcUwz?=
 =?utf-8?B?SURhSmNGQW5hTGI1cGZ0a1dNZWZvOEFJTTBtVFR4dHdqdlRlNFdnMG5tbzM2?=
 =?utf-8?B?amlmRWVUVm5nMy9mNlVNcjZBNGp2alpQV1VpZWFDMlBSUDBJdWtVOGxPU09M?=
 =?utf-8?B?cTdGL0t0WWxFY1VVNEtKcUtmd3Y1VnVKT1htRmJhOEZ5UTd0ZXVIOUUxZEZX?=
 =?utf-8?B?b0ViMGxZc004USt3cHAyK0Fvc0RLVmozdnc1M0F5eVNNRHRubkRTQzEwU0sv?=
 =?utf-8?B?RHJTUWRSYWlQQUZGVzh2MGdISVM4U0hyVzJOZ0ZJU1BpRGErVlVTeEJFb2Rn?=
 =?utf-8?B?MnBIeVVXVGpHZDVTMGcvMm05ZVQrMk9BaERBMW9vRENhK2pwT3N3QldRZUg4?=
 =?utf-8?B?OHczZWlOYm1XWHo1MWk2MGJzL1dnTTl6R1gxRDVIdlo5UU04SzBtczdUcm00?=
 =?utf-8?B?UE5tTzBEUWxTS01YM0RrRmVObmpvRFhpZzc2MmdRZnIydWRua0hNeFNNTXNp?=
 =?utf-8?B?TlptVkNIN0N1OGFzMlh5NWZMaTJTRi9ybHdyQVl3Q3FoQjdndnN5WjFYZEFl?=
 =?utf-8?B?dUllME55TVFTNmcrd1hiQVhiUEdHZ2NVWVd5VGlWaE1Xb2gvbTIvd0V6bVdR?=
 =?utf-8?B?Z3JJcFpaTHZVaTUwNmlOZkJlbjBxeGRGOU1JdmlVQVlGOXh2MzkvM2JnU2NI?=
 =?utf-8?B?YUVGNlNMUk9rNUdPSG1uMzUrdTFKdnJzUU4wbkgzQS9KR0dwRTJVa3BwaU0v?=
 =?utf-8?Q?rqtVssWdd3mzwod5SIeoD55bi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a85be7-4eb0-4978-3688-08db3c4a6491
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 18:10:41.7377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfUDJxl5OxXdXZkRQPvuOrFo/+4sC2PqO+aaoxkyIxZGfTf0mIC1V70kaPYZsC/5WicfDTaZj4A6dkEscu/MOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 4/13/23 14:02, Srinivasan Shanmugam wrote:
> Log if we fail to setup sink power states.
> 
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> 
> v2:
> 
> - Change DC_LOG_HW_LINK_TRAINING to DC_LOG_DC, as link training related
>    code moved to drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c (Aurabindo)
> 
> 
>   .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index c840ef17802e..ba98013fecd0 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1043,6 +1043,9 @@ static enum dc_status wake_up_aux_channel(struct dc_link *link)
>   				DP_SET_POWER,
>   				&dpcd_power_state,
>   				sizeof(dpcd_power_state));
> +		if (status < 0)
> +			DC_LOG_DC("%s: Failed to power up sink: %s\n", __func__,
> +				  dpcd_power_state == DP_SET_POWER_D0 ? "D0" : "D3");
>   		return DC_ERROR_UNEXPECTED;
>   	}
>   
