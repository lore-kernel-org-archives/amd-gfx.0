Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E7C433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EA464F11
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1EA464F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE6A6E11E;
	Thu,  4 Mar 2021 18:33:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561F36E11E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 18:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBA4y9YpTdEZJ713WaqtLoMci48egcZd1K11o4UCRhYhIiCWRe72QVZNYYIh+u91TfAxiGzEsTHwaOvANErgeQd5NQIim6VWLU4vIHarviX0j23LyGFKk6HQ22xyIclJ1HtX74ftdC9aplETaAORJW65kogE9/hOcZzqdEkm5LwyygZozBB4RR0WuiF08KGfhi0z1/Bl8RvYuTnthgYr6naZnrSZR6SZZVLzW34alyZ6dmyb/jkEwsRz9tEHz5vm6jw8eq9y1ZTaygve0LSc/kqmyMROu4Jkog3Fsh1GuYGYGcI/VibvTlhJ0qsK+lxnP+kHIuAqnYCWnDZYrTgy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBLQLSYyZc6ypP1vX3VQ/HQBib0M8WATK7lM1jaQs9Y=;
 b=cWgx30c4VeVe4FSj43YDP+YUCxqs+nyrTE1mkxwLCQ6Ck/DZGWtU7fEXJpD4woWzU7f0VB1wEV92IwxC98r5szetxTQVLU3OqSZUkObx5uiFxv9rLkKx1k64q4EQIY4woZLo5iC3oxrczPMbiPan7+mNP+KDriqnPyrOTKHmowjOsJf7Xa+FtqR+kvfHuNUmmr2k/+pfIIZxwe/GbUhx59jioCI9ve548qNC+OkX2pEH/1ugVlEqiXv0UYDjluEpb8EKmEk5edqLu9fmzJrqqsgWhbXT0VtvLxmfbpRbd+5CJcwawaO0PCRFQs+ItmcPdCjBZg3+VI7iFAjzN0t1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBLQLSYyZc6ypP1vX3VQ/HQBib0M8WATK7lM1jaQs9Y=;
 b=t8gV6wpIjRHHl8AY7fd+1zKPTtAHOp+iEmgjOGjG8uKi2PoXKb0VbIa8SWgyjbl71+oXwNgyXYQIg8qjrr9iA61PtH+sg62Ah5+bzzax0Zi9o7H595Hoq0peg7/8kEUZgjj8pi+R+LtLR09vnPyHE8sY8lsc0s6r577A76PhnY8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3063.namprd12.prod.outlook.com (2603:10b6:a03:d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24; Thu, 4 Mar
 2021 18:33:05 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::4d9b:6989:13f2:e4f8]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::4d9b:6989:13f2:e4f8%3]) with mapi id 15.20.3890.031; Thu, 4 Mar 2021
 18:33:05 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu/display: don't assert in set backlight
 function
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 tiwai@suse.de, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com
References: <20210304174103.202272-1-alexander.deucher@amd.com>
 <20210304174103.202272-3-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <eeb3b2e8-affe-ffa9-b538-d0da4a34c877@amd.com>
Date: Thu, 4 Mar 2021 13:33:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210304174103.202272-3-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::20) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.19.251] (165.204.54.211) by
 YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25 via Frontend Transport; Thu, 4 Mar 2021 18:33:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff46d7bc-ebd9-40d6-560b-08d8df3bf331
X-MS-TrafficTypeDiagnostic: BYAPR12MB3063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3063129D403AA98E7C60E275EC979@BYAPR12MB3063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mjWJ6Lzd8I97z7HmNsd61YS87v23Aja2icJ/KtT+0KynL6AsTqv8vW6iHi0S7Z5gERQEImURGtTHbnhqEktIWyFp85N0AyLn/OdFWzOvrQ99bhimpR/61OW57DXIXPAqE4KHXhc3KDjJVxROMafKxp+JfvqDpQSh7WmM3PseWh6zEiGW4dttXybmThPSZRKcW0AZu7UipEYMBsNUgZHjJNIl8D4Hzg5wzdDZh7qQ6e2HfHqT1qKqISmozcPdxRBRb5YmvOBVryu2hn0JivGH/YyYf0CnlmW6xG1y1P06jVC6l8qXJ7J74iwDegsRA7t/17n0llMGkCEQMUjyMWhMCZRoL1QVD9nWxRR/92CbGtqjEYM6+l1Fc4I/+GdpXEyi0nO6IfKA7J9iGBoAd3TKHcgaVVhvhGMm8uVuF0JYYhAlXFJgzuu4Bj80jcbVWCLm7056uczZb7GqAVI6C3g+/Ql0WaLSJBjAz0xoo47cLRp7XCtjYNtUeZKQpQuBI1ixV6VvNFvzf2Cu2EEvrN3D91AfP40tWJuW12B04cslEmZ/K3DKgWP9emGKC4bJjkdH+flAV1YNsUt5VnHyLJpPawMm41DE3KWIcVNkGK55aI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(31686004)(6636002)(16526019)(2906002)(186003)(6666004)(5660300002)(478600001)(53546011)(52116002)(83380400001)(2616005)(956004)(86362001)(8936002)(6486002)(26005)(8676002)(66946007)(36756003)(16576012)(31696002)(66476007)(66556008)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHVYZjBpYnVSZy9lU09OWTFySmxKRHRzUFZ3MVBzVDVlb3RQVVVHV2QwSmh6?=
 =?utf-8?B?Z2dkYUF2OGRpcm10b2czbXhKcmwwYXRhQkkrMzIrRkkyR0tlZENXQVh6ZlQw?=
 =?utf-8?B?TSt3Z2lFTUI0SVVaSWRiSzBYNUZTTjJLcy9Ndjc4cWV6VHZDQUlkOEdidE8z?=
 =?utf-8?B?S0szdW9KUkY5MWNGRm84N0Y2NWpHVkprTTZuclE2MFNKWUNMUWhwU0VFWFl5?=
 =?utf-8?B?QjJDbnJZUEVNU09rcmZ1cUZBMURKRUk0ZkhpMjgwR3IrZERkSXBnbVNQMlA0?=
 =?utf-8?B?WjNhU1hmQUk0aWs3a210a1RkKzBRa1JyS0h6UTl2S25jYWRPcVhvazdWWXFY?=
 =?utf-8?B?OFBjbjZRZzJUWmtZSTltNjFmYjdKZEhoRmRTSEptUWtHcWdlemhsMDZocm8x?=
 =?utf-8?B?eFJIQm1ldDRNUjRMY1FqY0dWSmsyczZzT1JBeXBsWVRKN3QrYVEvSXV0aTVQ?=
 =?utf-8?B?Qlc4d0FsbzFZc2llN1E3OW8zb0ZrdDNyS2NtVlh6Tk1WUzVndHlKTXltOU1s?=
 =?utf-8?B?bzRYM0V4QnRMSGlLc0hlSHgzU0NkUUJzZ2JZdTdidlcxTExjeEd2TEVSd3hy?=
 =?utf-8?B?QWNCS28wMkhYMUxLWTBqTWlZc2ttVFRBSzI5c2JOOVJRaTBKdElWVUFlM0Zj?=
 =?utf-8?B?WEJCczR5bWlBSlgvTVU2QXZld3dDWGhVRWZpTGwxVVFlZ0UwRkZKbTNOb0VN?=
 =?utf-8?B?V2YxT1ZCODV2U2RjWXRIZEwwdjdxSGRORFdYekFQTTJVeEhxUTRIYXpMeEhi?=
 =?utf-8?B?Yi93a3pISkRmWk5pUjJpZFdwTHJJY0NPS2szbnhzMmQ5YUVJZEVyWmVwaGhC?=
 =?utf-8?B?WXBnM1EzZnJGai9QQ1hhZDh4VEgxTXFEV3VhVDJVcWtidnM4cFJ5VmZQeXRD?=
 =?utf-8?B?elJ5Zk9iQ2ZFbmhRNUVvM3BJcXFTV3M2b2ZxRFBpV1FUNUVDNWd1T1hIK2Mr?=
 =?utf-8?B?eHAxTW4weVIrKy9JMjE3ZHpjMkdCNkQrNit5eCt1bUp2M09TcVZWQWtSUkcz?=
 =?utf-8?B?TzhyNzRMNHVVY0NSMHpqWndNblRuVVZjVmEzVW8za3grOEZRaCtoVVNUQ0Fm?=
 =?utf-8?B?cjhGaHZJVTdxZE5UVzZ4dWJYT3lGMmlDNWU2SzVrMTQyOXVINlFVVG9CSVNn?=
 =?utf-8?B?ZFBLRk55YWYyTGx0aS91RVNVc2RITzY0NXgwWGszOStXNVExblR3dU5jdjhi?=
 =?utf-8?B?bXFyV09MYTNORTNwcDFmOWt1dkpCYW91akUxUFNzRHhNREczSTJiOG9HRzF3?=
 =?utf-8?B?RWdVWmRFUU1obURyOFNPT3ZmcmhwZFBNd1pXdnlnd0JrTzdldUNyM0ZXaCtt?=
 =?utf-8?B?bkFRR1pyMDA4QU5WeVJSaWdHb3BXMXU5c1BBNU1QbmI2MXduOGFzRzNOMWNj?=
 =?utf-8?B?SWdTQ1p2dW5rT3NzVVJVWTYvWllBSzFCNzk1TXpQUURLaVlvVVZ3Vmx0bEZL?=
 =?utf-8?B?L3YxbFZQN2YvSi83djlWdG5sYU1ad210U1JOZ2VNay83UlY5bk9TY2RtbExj?=
 =?utf-8?B?d1NsTjhqeDNncTVTODZjekk1MDh5Z2dWdDFINGhiMnJCU0dIekNWRWZLWnZj?=
 =?utf-8?B?ZjRYMnNOSmltdGJrMENGM0ZEMG5HbGk2VFBRQ20yT2x4NWVsU3NLc0VGZDV3?=
 =?utf-8?B?Qy9UQzdEMS9rVmhQQ2VwT0c3L0E5NEdaQUFxRDhqVDU1eUtZNkR0VzNXZ3dL?=
 =?utf-8?B?YThDMkxYa3p3U3VLRnBKQ0JrNDY0dXhMeWZkSkdGcHMzbTlyQysyZHdXV2k2?=
 =?utf-8?Q?lVo4C7ZcK88kG2FvqnYz7nFeKx3BD2UCoCMKVg4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff46d7bc-ebd9-40d6-560b-08d8df3bf331
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 18:33:05.2984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msOzaggjulTdcO/y4Bta1IVppAXdGRqtwo+KQ8H3TKMmUG3Fr2/fI7CxETuCYQN8u9x8hC8fMIZzYo4sEhquEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3063
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-04 12:41 p.m., Alex Deucher wrote:
> It just spams the logs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This series in general looks reasonable to me:
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index fa9a62dc174b..974b70f21837 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -2614,7 +2614,6 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
>   			if (pipe_ctx->plane_state == NULL)
>   				frame_ramp = 0;
>   		} else {
> -			ASSERT(false);

Just a comment on what's actually going on here with this warning:

Technically we can't apply the backlight level without a plane_state in 
the context but the panel is also off anyway.

I think there might be a bug here when the panel turns on and we're not 
applying values set when it was off but I don't think anyone's reported 
this as an issue.

I'm not entirely sure if the value gets cached and reapplied with the 
correct value later, but it's something to keep in mind.

Regards,
Nicholas Kazlauskas

>   			return false;
>   		}
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
