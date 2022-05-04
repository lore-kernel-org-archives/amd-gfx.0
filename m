Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D97C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 06:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D272610F8E8;
	Wed,  4 May 2022 06:28:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0726610F8E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 06:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na7LJN+ewSsayZD7MKNFs7QQS1DMBNqh9PpB0szWdc3N0HDUIqDxYG/1XDQMC1ycd28jGGoWvu6tsCL1TDf91Jp+hjSglWYSvK9CAKhHJjtSL1AqL3RhCHENn1UP4Orb7BC3VMGk98aH/unX5KrpcshiE4C7bdPEGEQwEPH7Di3qL35b9hmknvBhUpLk2GoL4IW8W3cXpM1hS2EpAWxcevWkklVOdPvac8I++4TbQ2YL6rkT2c0HRm6lDzYJ7ENaLWiR94J6zs4s6OlHaGbTjlAji9WUAFhRR2ULrM5qzdtStVUDWg6wH/+jvGNXGaYrnI8b1v18AAUqfa9gyhfTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbC/hvXpX2iea4h6hFqztD8D1QcEUI/DSqRkG36zlzU=;
 b=FzfW91TmS+BSrUnRa3GjY/NzvU41zA3RNMV2+qJ1QwI171OJMlc5eZRFPdp3Yosl+rojcQiVxQoea/bbSrDHfsn16YZ+yMyjY9c/lTqc6+D5HD8OUPe6myVYfKkH1ZwTe41AYVADCxrebkARCTWNV2jqaIM+2SObD6WhyPI1OTjTcOIhbMpdk5HdvpDQTGZtVt5D3gL2XokpNduw/jqXUJzUQwYAvU8f0l4T92nHUdzZGbzlxZQDai+LO3AZPwIDPmh6OWq1XXPx6V2XHRJ0RmGmbhGCOj4Ex4ymuO9JCLXH58n76GqhMUJQl74hSkPfGLCv+cwE1ntl1OmUfaNWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbC/hvXpX2iea4h6hFqztD8D1QcEUI/DSqRkG36zlzU=;
 b=LA2MT8BAV1f95sgjc3f/+7We+PkYuZrk44qVA4W2dYf1I3h/e+Qg2S6VbmhqSkamiajsUUux/jXJiTELoYCeOqwQHr8SNgrpFtVFWLYql4Q/bjZJV/vhVXS9lrqONH/8ZvbVfFU/nMun9ZQHNCm4+i8+0G8cuTCfIBF0XKw85oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR12MB1430.namprd12.prod.outlook.com (2603:10b6:903:3e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 06:28:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 06:28:03 +0000
Message-ID: <fb2286ca-1162-93e0-daf0-6c76f2426efc@amd.com>
Date: Wed, 4 May 2022 08:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdgpu: handle asics with 1 SDMA instance
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220503203834.1230487-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220503203834.1230487-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:20b:531::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ce89370-221c-4c41-2b76-08da2d973dda
X-MS-TrafficTypeDiagnostic: CY4PR12MB1430:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14304514DA4555912618DEA083C39@CY4PR12MB1430.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB3TITEgbqjST/Un6CnH1unekxBbQrC3K3DLJk7eqe2Zj3J4FABb/NYkNkLShktciYW1nFeD1LxMqNsV2RRbh6VvCHE1B5Qu9OGlFJGLXUzRjhvKTmSJ/0T1cs+b10Xn86lxjazD6VpPbxUbOvfGJH4YhPQObNrjeLDG1299Xf9iV42nic+7qZY92zZIBvM+do1e9qQSosXQe4wDWzxODmZgt6vqmruzJ6siNzxJyGNPIDOfBTCEkzIwIX5u40/bVNjbq6zYyyPTTfjnMvOtgiiFSQJVujkF9uuvLfbjCREIhagKzLownbS4tfdAoWO45mUXdsacaVZt7edf4r90+SenJ91sFXyjne4g+hJL/QsziBjCmVnYU4pisW4vlWt8R3IC6Lnf1Po7fl9dM4SEwn98CadldoOp/IfbaCIXUZT1/yOZi7pabDU+oJSx4/npD2okbVOjBEzNBAu06EyIZaKlLiXOCQReyOmCp0qABWfZ7XeyTlzR9yZ184e5z3wKIAYoRTwRlOHDmaC759dZRsg68dDJ+7+hlP5DbHoyVeO/rxFwm6CmHeTmWYnivVXJk4ymvNM3tjOz/7NRsighQIUKLOTnjb/clL/RGhGofZNrKfX6pRmZjAYzs+VQVUDC3Fg3WQyhu5e1Us5visuCbTlNpIvrcI6BsdGIMduhCb7BKj4N6U3+StHLvazSM0WgmB6xZFijAOqc15FFhOrBGFdGVHOgQDP8snadFw34zj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(36756003)(66946007)(316002)(31686004)(8676002)(4326008)(66556008)(54906003)(66476007)(2616005)(186003)(26005)(6512007)(508600001)(6486002)(83380400001)(38100700002)(5660300002)(86362001)(31696002)(6666004)(6506007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGc2T3FsMVRrdHY2NU5wb3ZUMGRvdVdJZXZ5VVJNN0kweGx1MlEwMmpSTldD?=
 =?utf-8?B?VWhycjRxMHZ0RFZJUGFsaGRRTFBMa2Rod2pSWWc2WWgzU01WeXo1STc0d3dZ?=
 =?utf-8?B?eTBrY2V5QWhtRW53dVZ5UTFsbnQ4UC9KM1ZNeWFEeEEvenFtVUJxRE1LM2tw?=
 =?utf-8?B?S2tkUHNsalpWRmVudkVUMWh3UGZZM01BR2gzdWZhNGFtRGRpdDdrUjhaNklV?=
 =?utf-8?B?Ry8rbnZCcjI5NHFKMWljck13RW5KbktoWjZyVllYRVdGbDVrdGNIRUxZSXFH?=
 =?utf-8?B?cVpnbGpqRWNQeElEZU1FQWs3ZVZSamZIL1Q5K3dUYkNSaE5BanFRa1o4YXNo?=
 =?utf-8?B?MVZKejJhVHlQc3dSZEUrcCt1Tm1BODNJMVAyalV1MUxkU09xdGR2UnVPOFR5?=
 =?utf-8?B?ZFFDTzcvVURhS1RPTzh2UjBubFluYTM4MUxMMjFzNTg2Uk5xMDNpYWdHV3hM?=
 =?utf-8?B?K0lCZEFEcGkzTzloMkd0NjdrOHgyMm1kN1l3UnNQQTNaVFVLYjNRQVhLRUUr?=
 =?utf-8?B?a3ZFaUJzTm11a2JmWFVjSHJUczViOURMVFFJR0xzM3RXQklOanB1ZWl1a0tR?=
 =?utf-8?B?QXMrMGZvSzhjaCs2UDJSTVBObUpTVXNlVTBvUDB5a2M3eGhOeG5FOVZPTlp2?=
 =?utf-8?B?M2FydkhmNUV3VWNRTHU1R0NyYVFQbTBScUx2aDhsZlVlNGxGZDBTUXZOLzIz?=
 =?utf-8?B?VVUyNVBnVnlWV3Z0dzcyK1FhOUMxUlE0eFRDQW1KeFUxajBXdjhhUVg1RE5N?=
 =?utf-8?B?bzhLOXdTU2hvMnFzMmd4WmVlbXQvenF0TUZnaWNOQjM3UmxZejRVb0xLUlBk?=
 =?utf-8?B?dnFIK1lEQ0hjTWw2YW1ScWx6bllJN24rNU1MR1cyVE9SNVNHSkwvOFk3dk9G?=
 =?utf-8?B?QTJ6SGtvVWRzV0VCdzRXRkdZMldHeWFlOGhVbTRSKzg4K3NUc2x6bTBjMlRP?=
 =?utf-8?B?bW5jNmlSUXpNWUpBWlRHb1dON2dFemJsbHhHT05zblZSNzRQcEJnQXBqYzNt?=
 =?utf-8?B?T0VXNnBkaDl6S2Q1aGZsVDA2TW5xcGVsTzVrKy9aYkE2SnBrVExVanZ5d1dE?=
 =?utf-8?B?ai9VNXFYZENOZ0gzNE1panFWWldmeVNEbmYvY2xWUTFBUm1oUEEwdjZmOElQ?=
 =?utf-8?B?VHRWWkhoSlo4WTBJQkRKNWtONWxzdE95OHU3OWtJMEJuQVpiZ2pDYVltWHdZ?=
 =?utf-8?B?SUFDaFk2Zyt2emZWTStmMlJUWlRraTY4SVhLc3RncUdQSXlEVmRIRFhtaVg2?=
 =?utf-8?B?RFFYblBXMVRYNkRvdDNUeW12SWdFYWY1dVNrbTZpbjgwZ0wxeFJXdUFVRU9Q?=
 =?utf-8?B?NXBOdW95R2svbjRUUnhVcXN1RWk5NVBlc25nSFptQ0VMbnhrU2phS050b09l?=
 =?utf-8?B?bVEwWm5XSXA1K0t3Vjg2NEFNYUM4cCtFcGNkOStFeE5Cd0pmcUVhVkxSNWwv?=
 =?utf-8?B?dWthOXZLWFdUOG9IdDRZOGY4SU5neU9iNUkzMFJrZjN5a0NXYjlGQ3hHaUpK?=
 =?utf-8?B?NkRMWDhjSkFDWWk4MWNHRlkzS0swVTRMa2duall4bndHVlpzdFNIdXVtcThZ?=
 =?utf-8?B?R1ZpdE92RmNDVE42YmI2Q3JGUGhiN2k5SXFBMUw2S2xiZWJPcmVUR3Y2c2lC?=
 =?utf-8?B?bG1CdEZrOXZsUlFkUDNpWWxYUzg2Qnl5OUViY2VkNkg2UTl2K1JhT05EVEhw?=
 =?utf-8?B?NDBlNFBLZEVGMVlMcXJwdXF6dGZ2YTVScDNUVERnU2toM0djMFFHaG91TkdT?=
 =?utf-8?B?Q3BwNC82VENpTEJYd0dBd3UyNUloY1FHNWgxTGRCL3VFbmRHa0o4dFZEekZr?=
 =?utf-8?B?bXlrVFZ3QjIwcFo5eEJKQWRsVEI4enF3dDZ1ZmZUMHdjaFhWVklLNFg1QWEy?=
 =?utf-8?B?cUhZNXBBM20xSUxRN0dtVXBXN0hEblNNcjQrc2UvRTNORWtEcmxheFZVNVdW?=
 =?utf-8?B?WXpObDNQcnZzWGRwWjZFSVNGamVtWXFZQTNIZ1Q2M2ovN0VCUUViT0toZ2tn?=
 =?utf-8?B?NElXbmZPTHJJK1R2RVlwQ09TQlVaL2ZFK1VaajBSYWFtWlp3R1VnY1puRzkv?=
 =?utf-8?B?MEtETkpnS1hWNnlMN2hPTWtTRkVGRjFVcHQxZmtnUStZb1k5ZjlIT2RzZjlH?=
 =?utf-8?B?NkF6Umh0REY4ME1xeDZ6V1FERFRxZkVOc25ibEhveXhMSk1kVUlFSCs1Yjh0?=
 =?utf-8?B?V1A5dzRoc2RCSEF5VzlnclltaVZOWTNGMDdHU3ZReGdrZ3ZERmI5bUpvR1hG?=
 =?utf-8?B?aWVnQ0d4dG1EazdtcEFjanlUZE11YjBnMXZEL2xMZFdCMlYvcjJXakt6UzMr?=
 =?utf-8?B?azFaTWt5bFhMWmlOM3BkSzdsbkVPNThHWlVzY0d4bXYyZUhaTi9PQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce89370-221c-4c41-2b76-08da2d973dda
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 06:28:03.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0br+K5KtyX45p/jF70HiSmb8uMnsv7uEXHc6YZ+4lSzgVrsGBfhL6JHe4iqpqHI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1430
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
Cc: Huang Rui <ray.huang@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.05.22 um 22:38 schrieb Alex Deucher:
> From: Xiaojian Du <Xiaojian.Du@amd.com>
>
> This patch will handle asics with 1 SDMA instance.
>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 307a1da13557..29acc5573f56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -252,8 +252,9 @@ static int soc21_read_register(struct amdgpu_device *adev, u32 se_num,
>   	*value = 0;
>   	for (i = 0; i < ARRAY_SIZE(soc21_allowed_read_registers); i++) {
>   		en = &soc21_allowed_read_registers[i];
> -		if (reg_offset !=
> -		    (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
> +		if ((i == 7 && (adev->sdma.num_instances == 1)) || /* some asics don't have SDMA1 */
> +			reg_offset !=
> +			(adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))

Hui what? Why do we filter out register reads in the low level function?

>   			continue;
>   
>   		*value = soc21_get_register_value(adev,

