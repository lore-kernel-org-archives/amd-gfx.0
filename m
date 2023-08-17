Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5042FC2FC29
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 13:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE1D10E48D;
	Thu, 17 Aug 2023 13:46:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6493510E48E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 13:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFEizOK4e2oaWT/ffYFXamdMQ4h2llD9aCGv5AgYJQGXjsNXDN7JX5TJXkhbdDOR4bBMLAxz0N+bBXJf3YsstqekdbPH+vNJ2Qji1aDfEzMVQYQCtQuczbLJScacW6RhBs2k5pR2PO2BGzE+X5GdoqKrzs2NxA5D9wcunITSOZ04oXBtgwfLhGHLBXaJ2mL1rKq4akGZmVEc1IDMGY88LgQSrpn6wjpZREnyYdb3q6MxpYFxbtNk2TiCVymnTaR/pOm678icIO/bS+/37plBd0+d4LEtWuBT6Dp+wwf8KqYOxXTM9PT/u4SaWRL8eC1Q3ws4LdTlnlam6BjmsdicHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22FSdWYGFdSZO/Z2fHOyOSORsKiG83Gj3PGLedbWy9U=;
 b=ImonkA3IPQ8SZlQegXdwv+WKI89joqKF4CefMjFUfIrVOKTmdXrQchNbZ0+acJRpOV7XMsGBHWBdxRlATrFpThkLDbKInAy7Eo/1aHoAP8+7DMgtlOQ7P9ve+JKv8+Xfl1lQlnBw1LAD/2AORImY1lHudJDJvIjty4YymCz7dUKmFutUg4aoowWcH4tVcrRP8WWzfWnYoiM2+BE7MCBr4qCeJxhdF9KeU4u9B9QZu4YZB9cOrjuhFqwpufRXNdnUrm+wnBD/uV8Bz37cfHyztxqC3WtdbePTxBw8IVjKltOcw+w7uqFMu9JsUJIXINFaM8owKJK3+jyzhqQKT1Qqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22FSdWYGFdSZO/Z2fHOyOSORsKiG83Gj3PGLedbWy9U=;
 b=CqaMZ8AG3O0URvUxLHVBP9ibtmxhV61WTw5Pm9tQo8hCJWWSShPyZhXQQIVSogZdV0em5GDpkwodQoVEy7NYz4vaIyxqFCw2MEdaTvlGzDu5C3yQHUM8XDZagx+mHuCsLxSFJuSd5ivT95lKaStoIClpyJYBjCbFrb0kwQ+HIoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 13:46:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 13:46:48 +0000
Message-ID: <9311891d-bc3e-407b-aab4-4bad1679f5e8@amd.com>
Date: Thu, 17 Aug 2023 09:46:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] amd/display: add cursor rotation check
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
References: <20230817105251.103228-1-contact@emersion.fr>
 <20230817105251.103228-4-contact@emersion.fr>
 <13e88b5a-9db5-4a21-97ae-3bdc910456dd@amd.com>
In-Reply-To: <13e88b5a-9db5-4a21-97ae-3bdc910456dd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: be63a950-eba7-42e8-738c-08db9f2866fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur/o51M8mv0VCEnbOiJvJNnTgLvC65S9f/UKrTjY7yrGDalkEdgMupacXCzxHaT1q+eTGRP6+PCut7WUJHo+HIerUwFhKGLHwnGFnsvOsuFWqJUKb/KM0gbTLZgF6NG4hb68m7L4fqO9ZaSu1RyyEsZoHl3unKbfR4peGn7W7zr1s7GtsSAoWPr8B0Jzsy+BQHX/Ok+4FJtZIXTAlWZNEKFSi5A/Gi88+K2M/dXzaouLH8/EH+IpJfpT1lgjmpuWM2JUL/cqDi++AWTl3a45A/8y3bqAXnyRuFNSYaHYj3W1mjTQj2CmE7OscQlVZUGM/pzWqYt3lTNzSGJOgdKJCzzyAedjw4i84bnC0NLqUiE1oJjv/vfE8U/DQnTUT0Lkq5qlDZaU6C3DEu/cOULMizcvVqYPlNrGqPKvzgiSjrLJ24mHA4vCitplA1kXdjFJdcqOE85yG6hDG9LGZdWbLvyUoTWTTqRXWzwzRUsL+oZk3ZqZbh2Hnpzs0quHKHwYLGAYiriYlxcoSQPrJF0x4PhAU3a2bdI70jv8mM2usR6MVSqkY87/bLRwxNCCAt/5zgp3rfzRWZWx7MmlZhM6u+ARZqWE1aYXnhGCxW3fOvRVVDgdI7zDt+BpxqpWahr0sIh9OUcdZ0nfreLk5rt6Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(26005)(86362001)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBGbXNqbWtrNU5WbzE1WlVBcW5yRXlld1RVdm52RFFVakJyOVJtZEI0VkF3?=
 =?utf-8?B?SVRNVzVuOVRSMWhMTXJ3bjRuNkZQcjEzcXBYR25aNXJrUzYrVTFXY2dCUk1G?=
 =?utf-8?B?cmk1WGV4NXNHWWxxam81aDFLcUx5Ym9QWVM0cVI2UzlmQjFXS2UxM1E0dGUv?=
 =?utf-8?B?clpZemJrT3hzUThkd1JMTXhUcTBtVHhaWHBBTjhFWndaSkswdUNma08yaDhj?=
 =?utf-8?B?Vmo1TmIzWGNZc1VJSjMva0J3Q0ZBbCtNQjZLbFovcGlZdXpNNjloMTk3Nk10?=
 =?utf-8?B?dGgzVnFsUndieUJ4cHpRbW5mSnMyMEpvQnN1bXdEbExsSG5DOVB4TjEzVjFR?=
 =?utf-8?B?Q1dCOHBRbCt4b1R1WXRtb1VaNVk4MFZiWE1QeElLaEZNV1dxRTluSVQ1Z1Jm?=
 =?utf-8?B?em1oZk4wVitoNmVaaVdQKzNwaWt4WEtTNU1wZEFZcjRHZUtkOFBMTkpPNVRT?=
 =?utf-8?B?Rm16SGRkRHhEOXlIQUtqMGZCbGY5dE5rc25sek9Ic0RabWRLRXJCenRUR1V6?=
 =?utf-8?B?bUk4bDFYMEVlY3NSNFpKNXE1RVZzazhYMHRqTmZWVHBTWmhnVlpmeWJxcWpT?=
 =?utf-8?B?YlJzY3hrZjB2ZHg3b1cxVEVJY2FrRnRRU0QyMHdJTHpSaXVCSEo5YklKSkZF?=
 =?utf-8?B?R25JcHRySUhqcmIvMS9oMVBMSEc4S0JONWUra1J2WjB3OTlIWEpid2J5cDFF?=
 =?utf-8?B?blV3SE51b2FNd3RLdW5pU1l3Z1ZmRG1XSEFUb0pieDZra1FVNFJVOWhIaWtl?=
 =?utf-8?B?SlZvNWJTWDFXSEV2aDdmZzVrdGxXdzFza1lNYkZ2Tm1WbFc2bGptNzlRNldY?=
 =?utf-8?B?WjJVTlZCeFFrTjFXQ0J5OE4vQUE1dnhzNWR2UStVaG1pTjVKd1Y3eFpwRW5G?=
 =?utf-8?B?Y3VzSEFENGxKQW91UHgyZWlLOWVlc2R1aEw1TTMwNWpqRGY4Ly9BTFFWN2xx?=
 =?utf-8?B?Nm1pVkVuMFY2clZKSlJaNVVMNWdKSWlnRUNVU3pwZjFPc2VCZEhvS3JOVWlC?=
 =?utf-8?B?Sjg5OHdmcW5xalNQZkJKc0lXaXJTQUlWU2tpSG5IeWxxMWJ1V1B4Rk9uRU5j?=
 =?utf-8?B?dVdDME9FSDhydjhmM3ZzRUJ6YlVkS3ZScktyNkVZcGIxQ2JRS1hRU1c1YjA3?=
 =?utf-8?B?NmludEhaMm54UlBCZ3BramNFckZjZUFWUUUrQVhTcGZYdTVUcGsrQTdobEQw?=
 =?utf-8?B?cWc0dlNiMWh2SEVtVUtSd0NxYjE0Vmd5d245TGxlNmZGYzdNUW5RbVBXMkZu?=
 =?utf-8?B?K3lLNnRrN2JseWh1ZllDOTFhdXI5YTRBM3hRbEJGTXBzWElXQkZwVjlrUkxq?=
 =?utf-8?B?SEVwd3V5Wmt1RjRwYkNPS0hTL2dwYUlFaG1JVEo4VThzUVJXNlJsSy94NXNH?=
 =?utf-8?B?bUJlSm9XamxMSzYvSi8rSzRXa3YwTjZvUXJWY1dIUzFNeVlqRndVSmhDVkcr?=
 =?utf-8?B?bFIrQm1jMFQyZDVYWFNnb2VBMDJNd25xa0Z2eEw5empOZUIvbWtlZUJqaEEz?=
 =?utf-8?B?bE9TN0dDTHlWL01HTTV3UTVuMTFYY3EwUFE2aE5yeG9XZE5iVCt4TitBQTdy?=
 =?utf-8?B?SVE0TVpMa09abFNGUERrMW14YUVZYnk0QWhRNVZoU1pCdXZ0QkxvNGxFRS9v?=
 =?utf-8?B?Mk80RFhvRmtaOTUyMklzVE04ZTd5TzNSaFBaTDJnR3hYL2IybHJndlNOcjVv?=
 =?utf-8?B?SkZHV1BHVHpjOEdZN1AyaUpuZ2VzdmdKd0tnQVNQRDFuMDlxM1BLbmIwS2Fq?=
 =?utf-8?B?RHJMbXdFbEI0UFNaMHRmcVBBcXQ1NDg2TVk4aVdEdnRqY2FNamFaVUMyU3hR?=
 =?utf-8?B?cU5uOFZxNFVYVzFuRzk3OVhpTTd4QnUyZE1WYXpya1V1ZHh6RUs0dWNrUXpx?=
 =?utf-8?B?RXlDaEZiS3NMNytRZVJWS0J3dTc3K3FEYzluMXpNQUFmREYrdGV3WHg3VC83?=
 =?utf-8?B?RmRSZWp5UDljRll3a0V5QzhlVzk4bStWQ3MxcjI5NGpUclJCNUppMTJaaFBQ?=
 =?utf-8?B?T0VnNkpUODVaK3lydERZcm9YWUFlbDhXcGtkbTVrWm9BekoxZmFyQ053ZzFP?=
 =?utf-8?B?L29XKzRSczVXb0lEY01DNC84c2xBU3hwaUNBQzhPeHBleXdkcWI2Zk9QREcy?=
 =?utf-8?Q?+Ow/38P1f8DSEcHqiZlrGn/55?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be63a950-eba7-42e8-738c-08db9f2866fa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:46:48.0055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv0VyIdr75iVdUdSjAEOYIaEyYgait8flONndxf9cUzt3fSPfqzZ3GO/1IvpQq3cx6DW75CKgt8pd77Onx+tmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-08-17 09:44, Harry Wentland wrote:
> On 2023-08-17 06:53, Simon Ser wrote:
>> The commit 1347385fe187 ("drm/amd/display: don't expose rotation
>> prop for cursor plane") removed the rotation property for the
>> cursor plane, assuming the cursor would always be displayed without
>> any rotation. However the rotation is inherited from the underlying
>> plane.
>>
>> As a result, if the primary plane is rotated, then the cursor plane
>> will incorrectly be rotated as well even though it doesn't have a
>> rotation property.
>>
>> To fix this, check that the underlying plane isn't rotated.
>>
> 
> HW cursor works with a rotated screen on KDE on AMD HW. This
> looks like it will break that.
> 

Sorry, scrap that. KDE seems to do a SW rotation with HW cursor.

Harry

> Harry
> 
>> Signed-off-by: Simon Ser <contact@emersion.fr>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Harry Wentland <hwentlan@amd.com>
>> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> Cc: Michel Dänzer <michel@daenzer.net>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index df40f74f5a15..aba01255ba12 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -9867,6 +9867,13 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>>  			return -EINVAL;
>>  		}
>>  
>> +		if (new_underlying_state->rotation != DRM_MODE_ROTATE_0) {
>> +			drm_dbg_atomic(crtc->dev,
>> +				       "Cursor [PLANE:%d:%s] can't be used with rotated underlying [PLANE:%d:%s]\n",
>> +				       cursor->base.id, cursor->name, underlying->base.id, underlying->name);
>> +			return -EINVAL;
>> +		}
>> +
>>  		/* If this plane covers the whole CRTC, no need to check planes underneath */
>>  		if (new_underlying_state->crtc_x <= 0 &&
>>  		    new_underlying_state->crtc_y <= 0 &&
> 

