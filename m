Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB773CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D8A10E1D8;
	Wed, 18 Oct 2023 17:53:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DEB10E1D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:53:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGz1xr5ni+UsBwy70TPYkzrRdWoogQsfkqhgZU+/8exnoOq1+eGOw3yKwCvebBGzqROaIPWyMrwyDwg1eZ0jKfOnaiRJEv5BaWmIdv3EOMEMMmxNuBVRuQEb6Z+oa2NhoO3GP0jPvo2zZVa7vIvkIuOxFlkaWG3nS0Mge8HjULzevfF6rimoYjMgFt/IkzUVmV91Rr/hZVQucy3ZBhGyQtzWAx+DvIusfnWzlASGdXgr8w+veKAdnEUQP4hSXbYcVczvPq/yuhfOAKvrgXncM6CNdPOtvaX/uDCLRLlZKn6mRiOB8qNLHhvWxUsd3vUllt3vwJYgSjN7bDvSoTMfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+NacAQRKFNF+WPPZJaBN0P2s+OS4GjN7GDLLoLlMxI=;
 b=i0LwwwFlVjMO4QwgzNNA1H+TKW0JZff6SlQ7ovKGwG1cy2N+RbWwDWdLwSWTjW77xdUP83AOuCxp019iyeofkcprnP6w4gzsdtfNiJPQho7NgwIZtI6VQsI1Gl0eplEyP1DqEA2p0kUS5enztPhzOopfCAog/2BMng+VucUgktd5ZA7l5S9KzpHY+4hWrVNFrMnmj40Pz6Xg7xGBGWgnL5T95dyENlF8Qbgt0wSFZMBApXyr6v8qzicclWOctDmCq4QK/udZ926kKyTxsP6Lwl5IuiHpn/WQJVcdAfGoW/SwyVedSyvARJHJ95k8hnsvl5BZwBKjHShNoDjvsX9OIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+NacAQRKFNF+WPPZJaBN0P2s+OS4GjN7GDLLoLlMxI=;
 b=0xTq0ndjSmrsQgweHWBB0Rd5x/6PefESmgL8TZ52ACpgirrmFL2jkajwIJDI9boqhWFeHhEm9NNffxvMnJgMeb5j6Gndp5Szfj262a8gR53XFfSianUQyTybdBt25Vo5P7NRgd5BzZexfqSKVVPFndUyUozLf5Prd2W5jLw1N8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Wed, 18 Oct 2023 17:53:43 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:53:43 +0000
Message-ID: <f932d060-4b17-4197-a79c-d6e66380769f@amd.com>
Date: Wed, 18 Oct 2023 13:53:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/26] drm/amd/display: fix compilation warning in dml2
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
References: <20231018174133.1613439-1-Roman.Li@amd.com>
 <20231018174133.1613439-26-Roman.Li@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20231018174133.1613439-26-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::19) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6e81dd-eeb5-45f8-b69d-08dbd0032b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwp6B3Tl/tjw8q7vrfAvVWjM8tj6cwrc1jtOLvMZZndMTXOoqeD0MyNnmy7F7u1q6C1KCqHguWutV2JdteaoEL3Rcz1Q2mPLuhjIbP26/b8DXSwH7WzLlSv0thm1A6/JRSwLbgSiNxmTaeeJtFebunaP21bMqEgKBXzsDT9L6gHPJDfR+PxdpQyDuKbJpjfiBM439DnwVETo9OM0ZE2LwtJcaqA4qBNOSpHlJMUW6cF0vIW0BWqq3txKl3FNkdvyv3qkAvPulAlGhgSkFApfKH1Y2VN93Xg+q3O1/H9EEy8MYtQxcaSTtEHxrKy0TptUV3G/1vJuPWm0Gy6QhgUvXBFvGry/mjcTvZ5cdtsBZMz+yzm9ISTykBVjFzwySKwNUqHQKOIpEaPZK+sE4tCcPDTltbLz9UuVXhHksfYuWIdAM51RBPtJ9HD69DjlPsT+PdQZ1ELz+U6/DREKPY5dfBgg+pqTvxwz+ap6Usk1bzQ2RDtWSeCEyZTGtulw3Feltvds2wQJX4uh8T7g+latl4LLCy5u2AUEDREvE3KCJ5jFl1U2n01pz6aTlhfG0ermNcDyxSraFJCvZOf7xBaDeAngfwFGvPFaOXew/MIMsxgW+nbRGjRhaRSIBGo84fhdSpLpayWklw1Rp6E3Ico/rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66556008)(54906003)(66946007)(66476007)(6486002)(478600001)(53546011)(2616005)(36756003)(26005)(6506007)(6512007)(5660300002)(2906002)(8676002)(8936002)(4326008)(44832011)(86362001)(41300700001)(316002)(31696002)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2EyYzVJUmhMYTRCVHZFL3hMbTFDSThUTkc4SmdqUFpMUCtiUnBMbkQ3a0JE?=
 =?utf-8?B?SmxKdCtnMm5aYVpJRGl4aXJxa3NZYjlFd3dIa2FWYmZ5NE5sd0dmUVEwWHBZ?=
 =?utf-8?B?Y2pNd0FuTEUyUitrU2Z4dmxtM29ZVkxvbjgvUSsyRDk2ZVNmU1pKMVNiSW91?=
 =?utf-8?B?ODNDOTBtQkxJMU1ibE1pQ292My82OTF3VUV6NytkWXhwckU4Rjcva0NGN1hr?=
 =?utf-8?B?SkJleGJpV212QVNXVHlhdzlNODVHbUlRNVFyYU1KNlR0bjZra2xZMHYxbFFl?=
 =?utf-8?B?NTM5T3lSRkVnT2Y2bGpGYmpjaFNxaDNtLzFmRlNGb2xhdlJlK0xENkRURjFj?=
 =?utf-8?B?WlNoVUdvY0xJRE95c3RZS1JPWkpEKytsYXg5WDQvejRnVS9DV3R6WkFNU0ha?=
 =?utf-8?B?clZxcGtpUVdrSWlUci9tMVRUTWttaTlGS0hZb1dNOGUyMFB5QmM0QXN6MGJE?=
 =?utf-8?B?Y0R3cGFsSkJPNkRFbjJiSm45ZFpJd2k0S1V2MVVXbTdhMjhwSEUvbi8zSmho?=
 =?utf-8?B?WUIxRWpjY0F1bUxMZUlQSzhwTHU1aTh5N2U1amY4RXoyMnhnK1dmWGlEVnRu?=
 =?utf-8?B?QnkxblNZVCtBZ05KbDI3SExLN1E2WjRNOW1heWlndmJhY3I5SGhUMGNQZ29D?=
 =?utf-8?B?SHVjd1VXV3ptVmlJOC9CVStEYXFWbUVna21kRmNsdXRJL0ZmcDRCSXh0NEx2?=
 =?utf-8?B?aG5HNXIzVkhJMkxrU2htWHRyUnUySmdrbFF0WHgxSWp1UExNeE9NWGRtTnl2?=
 =?utf-8?B?aTFWYnVIRHlJcHI5VkR0SGhaVVVZU0RtL0ttZkFCcmZkODJsa2ZaTjUwQ21q?=
 =?utf-8?B?S0FPWUdDcXZLS3NhWlIvVUc2ZmpqWFg0SjA3UVJlYm9iS0RrWE1GdHVrSTA2?=
 =?utf-8?B?eWZ6VnVQZWp6ZklQQXVzUkM3bHFrcjNnak1UcmpQaksvV0pRZEk5dWRVdVRt?=
 =?utf-8?B?Y1lSTnRJMzZHVmdaZDZySkdldlNEQUYyYm9RcS9PcU9ZcDZqb2lLU1dMQTJ4?=
 =?utf-8?B?dm9EOGx0cTRjaTExYjUrSnRvOEV1TURVVWQ5R3RRYlhHdFpJOHRxaysvaUJJ?=
 =?utf-8?B?UmdrdmtjWjdvendiL3h0Y3VUTWd3SDY3WVRPcTlvMkJNNDFERis2YTRDYXdO?=
 =?utf-8?B?S3VBYU5TSjdnenRjNWJHVEhacmw5cGg3bFhQSmw5cHd4SDQ4ZXdNdlNITm1B?=
 =?utf-8?B?WXlZRzNsVWk3WEZ1QXlIK0haM0o5NzNtanJPYlRWalZCa0ZGMTBNMjNXSXJs?=
 =?utf-8?B?SHJMc1NLYXBpVGZXV3lpNXhlWkdSbjhaNTNsRXpxNEtYcGM3aG1KR3lQTjVU?=
 =?utf-8?B?amF1ZHprR1VrZTFBRWc2U0lIT3k1c2tHL0NhOTJvZWJ0bWF5bDVKOFBUa1Fv?=
 =?utf-8?B?bnUyendXT2ZBay9nNFRuSElTWWVncUFESnhacnB6Um9OaWYzalFqTURObjhV?=
 =?utf-8?B?TitLQzc5Q25LRmd2ZDNxdWRpdWZjdjErWkc0WmthUS9ZS3RpS2JvbWpSV2du?=
 =?utf-8?B?cHFvWE1pKytCL1ZQRldQVHprTFBramlVOXUvdVBUVGJXZXQ4NGMzOXJSd3ZU?=
 =?utf-8?B?YWV3c1dPUDdNM1ZMc3pRNkdzdmYrWWwyQmlNcXZhZklSRGp6RER0dTJLVUpC?=
 =?utf-8?B?dkh1M1daYUpscmNsZnk2RnFMWDRZbk9yRXFNanhtTHJoZXVFQk5kY0wwVUVU?=
 =?utf-8?B?Z0h5ZG5IR2dJdkcxWndGNk1FbHpvN29BR1VCUjFmU2s4M29NZTVmSkU1ZHJM?=
 =?utf-8?B?SHpUVnNuZzh4TFc0d3k4c0VjY0E1RkpaVHpGZGd4Wk9OSW0wZkIxU0ZqVUNk?=
 =?utf-8?B?b3NsWUp1clRhN0sySExBd3Iza21YM0F6Z1dNa01PTCtrK3lwSlVIZzN2S3hQ?=
 =?utf-8?B?WXhtaklabmdZREc0WGw4RXF2N2NFbDJBaUVGVWNDQ2ZESFFlK3FZeTFqUkJR?=
 =?utf-8?B?eVUwVVFyeDJjZlkyeGQ4cnFpWmZabW5HV0VML2pta1B5QU8vUVBCdUk5cE9M?=
 =?utf-8?B?NUIxVUdZMVJhUkJjZ1FpVzdkMmIzQm4wM0NmSzhEMm1sK3U3NXh0VGl1Z3F0?=
 =?utf-8?B?SFFuZllaT2wzclpHb1ZjSHZZSStRUENBbzBwZDduRXJveUJiWXdaUHU3Z3hQ?=
 =?utf-8?Q?iGF4pofk88aQWrpeM+jhOahq/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6e81dd-eeb5-45f8-b69d-08dbd0032b53
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:53:43.4809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plOIPRzMzI3P2XeL+taHaGqqxlspQXru+BefrM0toWndOXiAgIn57GIFQGXB7Ce+fGnBuZi9SuKbpMTbJw5cqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/18/23 13:41, Roman.Li@amd.com wrote:
> From: Qingqing Zhuo <qingqing.zhuo@amd.com>
> 
> [Why]
> dml2_dc_resource_mgmt.c:792:3: error:
> enumeration value ‘dml_odm_mode_split_1to2’ not
> handled in switch [-Werror=switch]
>    792 |   switch (disp_cfg->hw.ODMMode[cfg_idx]) {
>        |   ^~~~~~
> 
> [How]
> Add default case for switch.
> 
> Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Reviewed-by: Jun Lei <jun.lei@amd.com>
> Acked-by: Roman Li <roman.li@amd.com>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>

If this was introduced by this series, you should squash
this patch into the problematic patch.

> ---
>   drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> index 71fce58da44d..fc266c6e1398 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
> @@ -791,6 +791,8 @@ static unsigned int get_odm_factor(
>   			return 2;
>   		case dml_odm_mode_combine_4to1:
>   			return 4;
> +		default:
> +			break;
>   		}
>   	ASSERT(false);
>   	return 1;
-- 
Hamza

