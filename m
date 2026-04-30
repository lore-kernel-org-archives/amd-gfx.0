Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6026FF8875
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 10:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4D010E122;
	Thu, 30 Apr 2026 10:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Zaz/Kp1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B19010E122
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 10:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul0jTrPBSclxRNqPwd82JR9gFfube63K9eb1BWcQ3edg1mrsRVHdqQjVATVA8xJsFle5OEK2v/jZCQYecpQ3ZulCGBtWD6iWOJw6UYvkiDSQmjJUvj5OlTKDbqwnpHaW2gzT+UYXGcvhaprqSj9ZUkdY+muUy9Mn2lbfFwFsPT5Ef/vJ0fRP5MBQrbtFUIwmGzyw7/oE/2Maoi9VlpcEtM6N7v+V1pvRJ9mYD/2SrE3qsIQhg5ZklDE9ELqev4sVjPtPoaKwtZiXtzNhHsJE57gQ+uyX4KLWDyeqGd2Qr4SO+RIY/jNRB1CJCBLV5apLJx2JCpTAMtA6p7zByKZYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaZ2EGpbK3MR+JrPnv6YOAOIOmn+xHajD3yvq+M25nA=;
 b=x2gg4xgYyhwqk32jghGBKNKJ11FeQmcuVIVSKttrZkkwFIjzQqGVtq/3hTKb2klNQLZ5oC7aNnHNlYC6n/bDOA5iWccI8K38IkPCup0eulAgq/EYA25lP05+BpjILZ2lEBFVYZB0ZgfN2OMEYvVhPQn7VIdQtWXJ6URyEd2a1Xa10CTirllqsQjWIbJeM2GLIMzhzdPJKbKyyj3e9lZBrlLmJuzPVHfwlQ0uK0MX2QbxrlBMaToJwDxdH4T71kYie9PJTnNgWgIQs3iCtC9LSBAXWSlET+HEHTYRq577ilWPZfSKonfSp2oV56qCTsUaY41yeTh3aSAW7iIqQ7Y1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaZ2EGpbK3MR+JrPnv6YOAOIOmn+xHajD3yvq+M25nA=;
 b=5Zaz/Kp1/CupgUB6VW8d4k3TXwNoeNJgufYZOj50r2g5t9eq3ka3MUhXm2uoIK+JJvfODB+skE+8208U6Lzgo3k+AsWauIzDq6uUmSl1Y443vTw7k1EaT1G2b7l8JzYHrOihia7+RtdqgYuj1KkeSfekwqLOur408M1H+rRqgtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 10:22:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 10:22:39 +0000
Message-ID: <87d5b981-51ac-4e4f-8b68-2bcdd808aa4f@amd.com>
Date: Thu, 30 Apr 2026 15:52:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Relax manual min/max clock check
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260430102057.4186555-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260430102057.4186555-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: f18b467c-b176-41f2-9c97-08dea6a26803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 85qQ94pLQi7taq50pIp3Dkho/WqTr6UIvI8MssQuXHI36loDd9zZ9r5wt2F6nh8rpJtMfTSJ0IB5wIWUI8M+5gQIFnpJT+Oum7Fe/Lsup8JIfyEiGGigApQJ3v5/Z51W/AHz2wS3Ho5iFKiBhJW9V2q5TyxLAQVN7wz6i7X3gbx+tnGfyRZPZ1HdjaLsKQcYevpq1PZWTyXeCzoYm+QyoQBuACod/Vdawx2k3Ju7IO9sGrRmSjzdt40IJXqnX0YSx32XvoBbZsUdspkxoo0hxTtc7H/EqJedgJ+n6yTDe/sSAmSunhbl3dIG3FIL6S3UcEZ5tG+3m93+7JmUs26xXWGqD4VO6vT2Ay8zYpnPnLyF2vtTYo8VgKA2x0hJwLWbygFMUcljpGNXnqQEpT5wG/79zhKr6ttoLq0sz39JIKGoAnXYhOJEybf9lvS7ArXYtf+cX7eWUovLXVsrVH1mVwo/BZKOwpz9tzU+hZ6v4VB1dewUsRtxwbrv+2bU7uAx57eaHoQSwgjzlR1+ye0q3N96lSW9Th06Klwv/XsuaNa1Cp8LF+wq+iVa8RBYyU1gki3YgovQcedZy4JKYtvmD0qWcjWdnTSHBTYpgLtJ8J2lyDb47xRjpew8q2JPFZVN+zMT5dSiLtUOVC4ik0MnG/RDvoaZt99G16coWk0tat7e5VWIt67Z4xpKePVbuF8bA4N3oqMmUMWdCuTRKXisy932RLR3/04g2meC7wQ6hHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eURJdVRMQzBNS3lLVzhBSHE3bjhkSFFsTzhhMDNIVWRtdGFkSnV6UWhlYmVU?=
 =?utf-8?B?dXhvdExDWmVpZklKUVBwSUhHWFhUTVkwS0xQUWJCMDM1K2xPZ25oVG92Z2FE?=
 =?utf-8?B?NnJzSkxtY0l2ZHFLZEFkZXZoeVE0dkt3Q2lpOStOYkgydFZUck1MOHhXV3l2?=
 =?utf-8?B?Z0NFZzFwS2RKUXprMXZpUksyakRBSjBRdS9Fb3JNeUtuOWphcW1xRUZuWnNK?=
 =?utf-8?B?TjBKam52bzFWTHJBK2lNLzBYdFZ4SjhNTlBmbzlxYU55MG84V29XR0NJODhk?=
 =?utf-8?B?dGlYUzUwK2pzYWlqT0pzcU5OM2NDYmYxaG5jWS9VWEZXalNubFVSQUljeW5i?=
 =?utf-8?B?dVVDN2NKQi9yL3NCa1luY1ZhclFhUEh4cmhxK2xHMURwKzZCTnJFb3A5NDVJ?=
 =?utf-8?B?Ry9MVkJPeUV5RmVXUlpOcjZZenV4SlNuT0JWTVROMkZJZGlMaUIyeWhrL2h2?=
 =?utf-8?B?OG5XeUlwc3ovM2JOUVZIcDlTYkU1SHFlZ0dqcmR2WCszSU8zZWpUN3dpeEI5?=
 =?utf-8?B?TXZabEppOFRKWEVBRlNDYStYbitKRWVaVFNUQWZsVHArZkw4blRYR2g3eTFy?=
 =?utf-8?B?Tm50ZG01Y0Y0MEZxSEM1Uy8wUDdITVFnbmtSTjh2ME92WTFRMytBUlFZTHRs?=
 =?utf-8?B?YWVRZW9acW12ek5CMDFFeG5QU1ZwV0xCbE9KeGt0dlpLNHZlaVBnUU5BcDBF?=
 =?utf-8?B?Z0EvNEU2NmM2Q1Y5aHk0QkY1Z2dIWEF3d3BZdW9ONkM2Mm1xTDNRRTlici9R?=
 =?utf-8?B?bllpQk5pcXExbUNIUlhvWUNueEZQTTRaVEVnSGpCY1V6L3hERU5oMWFsZ0JK?=
 =?utf-8?B?R1dOT2xmK2luaU9XUVYxd0dQU1lSMndqL2M1V2hKV1p1Z0c1WWZ6NkxBM1ND?=
 =?utf-8?B?dlNJbmE4Um4xTURCcFZTai93NHpGR1hvVjVSUUlneENjeldocndBb1ByQzRr?=
 =?utf-8?B?Q1lBeVl1Zkgra1ZmWndpeWNyZkVQVWlIUlg5Z2ZLbnNVQWxhaTIrRGgvdEFx?=
 =?utf-8?B?SFJCcURFeU1ZTU12WGo1RWxaazJzV01xTW1oL3JpSDlzUjNSdnE4QWZOQlkr?=
 =?utf-8?B?cDZXNHRtY0dyQ1RYOXFMRXl5WFpOZmxHVml2bGRDVFNaRUdaN2szd05xVURH?=
 =?utf-8?B?N2V3WGYvTDkyMmxVUVlibXRXUm1uODYrdkY4ZVRneXpVdFN5QUJXandQOTNy?=
 =?utf-8?B?d1BuUEcvNDJMMVhoWlRZRzdMcW1MNTNCRFpOM0svQ1ZXVUpENkZuMk9WSm9x?=
 =?utf-8?B?YmJBRG5TSzhITDd6ZWlpVGZhaFUyUU9rdTc2aTlqSy9NeHc3WThnQklEMGxs?=
 =?utf-8?B?NFlZKzJQdURRWDFrZmo0Z1BhM1FlNVNOM1ZWdWE1cTh1Q2VZWVhTa01hd2Vq?=
 =?utf-8?B?QVVBQ3lEc1BRT2pHMXBYckpyTkRicUMvRm50QlNmQ3pPOFBKWFJ6Z2pnTHdW?=
 =?utf-8?B?ZWw4TmNqbUQwNCsxMTdXTVd4c0VBWmo2Q3lpZUNHUTI4Wkt4SGs2S1lyUnN5?=
 =?utf-8?B?cWI0YVZoMklRcXpqa05jNndWdWFTdjRQSC80WEwzVU9NU25wY3dTdlR2SEZ2?=
 =?utf-8?B?anFNd3JtcTlEVFcrb3psOStLTjdnc0ZjTTR3TEphMWhuOUZHUDZ0VEx1K2tx?=
 =?utf-8?B?d0V3U25OYVdMSlJ2MnZTdENvakJjdnU2MG5wWmUyVW1VOS9FcDNnSXFkZkEy?=
 =?utf-8?B?NS83bVQvWlQxRk5Ub2I1MTlBNXdVbzFFV1pYa2JQekZJNk5RTnpUQS9oUWtJ?=
 =?utf-8?B?NzJMQnM5Mk1oMDVOREVCVHQzNnp3MzRzSTZMUWdWVGFVV3VEU2xkL0h1ZzJq?=
 =?utf-8?B?Ukt3WmJ6NFFkd2xDWXBCZGk1dkw5UVlONWwzVURVSHBrOUhjOC9yc1BFR2k3?=
 =?utf-8?B?SXdLclZubEFDZUxCUlI0aW1CeW9qaUx6L0ExOXJzaEhZYS9kNDlTYURaUGlS?=
 =?utf-8?B?bUhYWUxPYzVocEhaM2k3N3VIY1V1M3l2WWlYdjhBOWxPUFRMb28zandHT1BQ?=
 =?utf-8?B?T3JVTTh6d0pYcmE1eFV3UlpKZnRVM1Z1OTF0aHFZaTh0bk1EZkl3Tjd3NXpr?=
 =?utf-8?B?KzJvc0lpbEc2T1A0TDJwcTNGY0VWYkY4RWc5Rk1oelJzcTJveFNLYWdINGZx?=
 =?utf-8?B?cWFkMzRRQ0FjZUY5RFdYNE1yWFA3UHl0RFZnS3B3clNCbjNuTUU5OXBuNVNo?=
 =?utf-8?B?UWkzU3psWXZodnJHSlJEeXROOFI0T2IwWDB0TW5ac3hWWmFEcC9LMnNvQk9Y?=
 =?utf-8?B?U1RvYVdmOHc3aFlHOUdzOEI0K2JEOHFwZVUwOG1YK25GN0MvMWNpejZIZEVo?=
 =?utf-8?B?WEVQZUtvZW4ydFNsRFNSWEU2cjVwbVErU21EQ2ZRcUdIVUZrbEFGQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18b467c-b176-41f2-9c97-08dea6a26803
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 10:22:39.7012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tXAOi2WrjoxgrU+QDVjoMPhK/NgI04/6/12ZZCIEXLuuJgHBre8/ZUYmEi/EfYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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



On 30-Apr-26 3:50 PM, Asad Kamal wrote:
> Allow min == max for the soft frequency limit when
> AMD_DPM_FORCED_LEVEL_MANUAL is used on SMU v13.0.6
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 8d04f6e73fd7..ce520f43ab94 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2075,9 +2075,9 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
>   		return -EINVAL;
>   
>   	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> -		if (min >= max) {
> +		if (min > max) {
>   			dev_err(smu->adev->dev,
> -				"Minimum clk should be less than the maximum allowed clock\n");
> +				"Minimum clk should be less/equal to the maximum allowed clock\n");
>   			return -EINVAL;
>   		}
>   

