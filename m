Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B7CC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43636113709;
	Sat, 16 Jul 2022 14:38:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4E510E0E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 15:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g03NwPJmn5dIZTWZxeqmoTi0Z7bcq3uU/FRIl7H1fvGQogIfzoA5RzORhr/AEdzRpbbm9ZGaI+op1GiYeckpNbMBFDvT8641PDYA+zPmoo/eQUncAM88Ecbn/MGnb8Gaaiwt4IBIdseU1/Et7L7qhqHwWoEuBw42+BUVV71YYpulAwgVl9bjXpbLGHgY02p5vP30s0vaMD2nKl8SNtTeoNnlxs9J67Gxw/xvQtmKOt17dzoJBXhlgUzNSsR7yiEDZe98TEx1PEn7oEdf7kHxlpFUYx1QeubSB5uUe64oXLOGIHndd8DejwElEBmhWBiWAfRUcdjoGr1LE9DnOFIVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48KQCk7khR/nQ3CwgythtR1oUA3wkqZGhUqCIzJmDyA=;
 b=gF+eMGM8z4JdfPbZ0V8+58xLKeUTGWbF5MIhXQ+8l8DNrMgWou/wpYxXgtGSsVdXzrTA4YYMiE/rpY3hT8Y06/Gag1oJN+iN+PEXrAqD3vjwtOlTP31+aoDLdvIwKD4llD+GuNbws9f1XcrlenkEupEYnX9Bi/N1pwCGwc/o/P19Snz18ANC4/RyVe8wZszcPoFvcV8WIbVWzfqy07gX2LwG0hZaCCXw7EGHsw5+mIjXt8GwhbOXf/jaYkHUr2n5SSmcjYzG4xSWeHE/od8FwmmqMweYBRFifvLghHjdZrIPkPFibKjrvXpHyMaTxm+RaYjd6BihUc9PaWvA2Q4aow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48KQCk7khR/nQ3CwgythtR1oUA3wkqZGhUqCIzJmDyA=;
 b=WJtysTktiMAadsaWgPn8ppsB+TMDP7/3lIBN21tamCBobUlgf1SLGd0m7xSzUxNvOpMW9WVb9SFcm5ichUAh9B/JAgsPtl7wyj2Vp8hfwog7aH7cLlazreSSoZVHswLhGj8nmZ5DmwF8ECcRDlc4fD8NMCaJhXo6RPXOFe3zrvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB5690.namprd12.prod.outlook.com (2603:10b6:208:82::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 15:28:14 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.013; Fri, 15 Jul 2022
 15:28:14 +0000
Message-ID: <dedfee6a-a870-735b-3272-1f193dac3e8d@amd.com>
Date: Fri, 15 Jul 2022 17:28:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Content-Language: en-US
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220715144453.46786-1-ruijing.dong@amd.com>
 <c06f6582-46aa-9abb-5094-f027cf01c1c6@amd.com>
 <SJ1PR12MB61944BB1E94EA522B4BD67F8958B9@SJ1PR12MB6194.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <SJ1PR12MB61944BB1E94EA522B4BD67F8958B9@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0282.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4513862-f4c2-4a9c-c491-08da6676a232
X-MS-TrafficTypeDiagnostic: BL0PR12MB5690:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjUn8urfrDHxbWiML0R/ic4N+aUbzDQWq2LufcQ66OammQvaIIsQx7LPw8R6D7z4HywXISDuwRsQqp/RntGN/xOn+DzjOtMcOAl8x8sXInZcIxQnrrHYrRmDy8/VFHfcNw8YvPP2DKQZc4p8v+LBPRA/1cPU3UFf/fznPavJy5dcOqtq7xgdhQKH3zQ/9kNq8gnKwiUq5mzKCZhLOJjqRAoBa4Hu0UNuga8b+L1j3LnOjPsrUIkW4HbHhD+dZeCyk1i+lec8qsEQqL5BTuP7Tf3Ghk1sTdfBhSBfLq8bF7J+DsX0QKauDPU169nZfusa14Sxpf1j0sxOwQeVJLlhwdQwgIXVUA3kPhXoNYbzN8qnZDfLXvycWOgUua0r+Bgxb1VSXa8AA9eR/hRidX7jurrL8H9SjeFmHMasyP9YHRlmQWfei+FywxwSRM/Q82XcCl3d7FwaU9g4uvWPpcSxd/y+9CUtkhzufgILW/YeruC18LCH8atPbj09hFCCHcsOSCy/CGGFmQhmmCpAKBAEl25XziGgrFr1cgv0FPnotY+zxxN44WTxyZbmDCSGA2m1SopWIR3xABDwl6kilNGTOErF3YQ6x/JV8uxCfRME9q6GjHcKFTKfFBflqiGTrxRoMSJbECNiOWl1RN34tIQ7HwFwlLIlOJUyxvqY/iM1EMskyLw1xn5TVSK2uli6SDHqrJFfy7GsdfaKb3PaFd3KqcQXpw2AHjv7St6rDkXfnz9rYDWyZ3591XP383x3vpzwr6st+692QzPKNN160Mz6Du4BUHI+RCG1cAKf8zlFeM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(966005)(6512007)(2616005)(6506007)(110136005)(54906003)(86362001)(83380400001)(31696002)(6486002)(2906002)(316002)(41300700001)(478600001)(38100700002)(53546011)(6666004)(186003)(5660300002)(36756003)(66556008)(66476007)(8936002)(31686004)(66946007)(4326008)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c01oNUdGVXV1NXR4bTBkRVlqSVowUzkwMXZXNkVSL3RyeGRYZUhuR1FpbFZp?=
 =?utf-8?B?bUR5QVdaY21TWmxxQStKUW1TMGRWdXN2S2RPMFNMR1h6ZnZoUmtHMTlTd0tS?=
 =?utf-8?B?c2NteUxYZUpXVFdzQ1ZVc2I0WHFiR3JIZk9TeEhhdWxjNHJnaWZxT0J4RTZm?=
 =?utf-8?B?MVBIaFhtczdMajFtaG1pSXlNZG9tNGRRaUdSOWJZVno2NFFvM0FNa0pTWW5o?=
 =?utf-8?B?L1JqS2RVUTNudm9jNExXaVlRRmZsdzBGOGlTTE1OdHdIbkFZRlhSY2Y1Z1cz?=
 =?utf-8?B?RUFoSHduTGtYYWZrbDNpQWhNVW5sS0V6S1prcGdRY3hiYmVpRUdBN2ZEQmI5?=
 =?utf-8?B?dU5qTncyMUJWcytoUEcvdktPWWErNExiVDdxbG90UWxsZnJiak9XUHVDZWlG?=
 =?utf-8?B?N3RyRkFDL3JwRHlMMHZzSUU1TzMwS3JxdGhSRWZkdXJSNVUzOWduOEV0dER1?=
 =?utf-8?B?TDhuejhiVnVYT2czU0drMHR3clFiQ2FtaDRHTjhWK2RIRXBXMzRwTW9uQkVl?=
 =?utf-8?B?YUJwWDZkQzgzMXl1N2N5TFdlTlNLclpuL3JCNktDMGo4WmF0WG5qdmpXYjhl?=
 =?utf-8?B?bFJtUWZvVkdzL21BZWxjQzRRblBiMzI0ZXp1US9VS2UwcUYrRm1XWGlVSW5F?=
 =?utf-8?B?Ly9LS0JQSnRLRmxvNkFOQVhjbXNHY2FzYVdIN2pzNnM5cUswWkxYVVJtd2lm?=
 =?utf-8?B?MlJvUlZyNC8wTXdTQzdjcVJoNjFzMUM5ODBUWXJmazNvZGNqQ1BkcllPWnJh?=
 =?utf-8?B?QnptZWpTZ084LzR0dkNOa1RsZ1pxa1JscHZQK05hSW9PVXNra1BxeDF3dVNh?=
 =?utf-8?B?YklwMlJkbG1FUy9nMEZLWExya3dzZUVQUDQ0cTkrN2hDSDdBMjA1emZVS3FY?=
 =?utf-8?B?Zm94NXFsNkI2VVdHNU1raXF3K1FoclRiZjUyZXIrYlcvU1l2UzhzamlSV2l6?=
 =?utf-8?B?R1dLWTlUdFVabWxuQlEwUS9YL1BUMkRycVBZU0VzZDFKazFnN2tpV1dsZGln?=
 =?utf-8?B?WTNHMTRrQWRhc0tWR01BUDVBTjc2RlBGWUp6NHl2bHpWZkdNVUdCeTFoaldH?=
 =?utf-8?B?eWdmMjVyWHhnVlBpOHZZdGRsUmVIV0d1RWdqNGIzMlpRalRQdDJsNlZYMVhp?=
 =?utf-8?B?MmxkSjl4U2Y5SUwyUVpmMzh1VlhWZ2ZpR096cVk2RVNFMTVGQWQzZU16RmVZ?=
 =?utf-8?B?QXhQQjNqZTU3b2k2WWloSlNwd1ViM2ZqVGxDa0RQSTBRcnhYMkRZU1JjQ1hV?=
 =?utf-8?B?OTgvNmxGY0w2dy9yUzg4M0s4blM4SlZiME0yaWl2ZHFsNElrSlcrTU91Qlhl?=
 =?utf-8?B?U2hlREptUVJSU3RSVi94ZFZCNnNQN2tzQjJEZXJkUXlWRjFNRzVXdWg5TWVV?=
 =?utf-8?B?VjhmcmpHL1QyYTRjMkVkN3BPSzUwWEJ3Q292VXlrYUdjYTlEUFFOSlFsaFBQ?=
 =?utf-8?B?MjdTeEZGZC9SK3lkMnluSzV1djZQQkNucFJEQlBMOWpCRHFOaUkzUVlHcU5V?=
 =?utf-8?B?VTRrZ2FiWjc3ZWorMlUzbjVaZ1pqMnU3MFN6UkNPOW5yVWNBMzZwSndKdSsw?=
 =?utf-8?B?QUw3TlRYMHZ2bnFEYThGRG4zeEwwcUhxaTZ0YnVXYmlDQ0gzZG5TWmF3RzhW?=
 =?utf-8?B?WFdacC9HOFRBT2tUTktvZzh6RU5hVDBxZkVmLzdBQnhmYUVLWVhWeWZKbUF2?=
 =?utf-8?B?NjhmWEVrUmVlcjl0bCtwNkVXeFk0TDgxUytTQm5HMFl0UzJmR2NpSHVNN3Bt?=
 =?utf-8?B?ZVJBUmFUT1dUREY0bVY3NlhTS2xtSy9IdUNYeDVPSE5TQkpkZTgzeExQQ3Vn?=
 =?utf-8?B?NlEyQzZyTEVVTlhiSlk0YTlySEVJYmMxMGI2Rkl6SUhiVlpxemFjM3JxTWor?=
 =?utf-8?B?RjEwRTJyeWM2NWE0Z0h2YjV2dG1mTThaTjJqM0JGc1NzVFBoSVdmQ3hMbkJM?=
 =?utf-8?B?MytXU0ZRNVhKU1FNWkhPM1JaL2NxeDZpZjBVdzNiY1BYV2tRdS9UMVNxYjE5?=
 =?utf-8?B?S1FkMEpDSXBUTlViZGlyQ3hHMFhCd2V1alB1Nm5hMTBKV3pGNThSTGdHLzBs?=
 =?utf-8?B?dS9XRHVrWXRrUVZUYTN3bGxzUklUV1Vka0xreEtIek9VR01SNDlUYzlXTlpO?=
 =?utf-8?B?ZjlsU2NIcExCSnA0elBKYmJpS2NJRmM5MjAwS2x3REVtT1JtWFFoTjhjeEtJ?=
 =?utf-8?Q?UWvntg8khHvandpZB3h5tpO3IylnuEo86ITVDDVR31+P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4513862-f4c2-4a9c-c491-08da6676a232
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 15:28:14.1631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbipdQR68MomN9834grn7II7zW/OqjsVCXliJCLFxlDO12EwGg+xwjEuxa4IJXFj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5690
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.07.22 um 17:25 schrieb Dong, Ruijing:
> [AMD Official Use Only - General]
>
>>> Why exactly do we need a new define for this? Essentially the encode queue is extended with new functionality, isn't it?
>>> So I think we should just stick to AMDGPU_HW_IP_VCN_ENC and not add an alias for it.
> Yes, it extended the encode queue to include new functionality, and that looks little confused when send
> decoding jobs to the encoding queue. Then I assume this bias can reduce the confusion.
>
> Does this change make sense in this regard? certainly we can stick to AMDGPU_HW_IP_VCN_ENC.

I'm a bit on the edge with that.

On the one hand I agree with you that using AMDGPU_HW_IP_VCN_ENC for 
decoding is then a bit confusing, but on the other hand adding another 
enum with the same value as AMDGPU_HW_IP_VCN_ENC might be even more 
confusing.

I think the best middle way would be to at least add a comment 
explaining what's going on.

Regards,
Christian.

>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, July 15, 2022 11:18 AM
> To: Dong, Ruijing <Ruijing.Dong@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: add HW_IP_VCN_UNIFIED type
>
> Am 15.07.22 um 16:44 schrieb Ruijing Dong:
>> Define HW_IP_VCN_UNIFIED type the same as HW_IP_VCN_ENC.
>>
>> VCN4 support for libdrm needs a new definition for the unified queue,
>> so that it can align to the kernel.
>>
>> link:
>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/245/commits
>>
>> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
>> ---
>>    include/uapi/drm/amdgpu_drm.h | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h index 18d3246d636e..fe33db8441bc
>> 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -560,6 +560,7 @@ struct drm_amdgpu_gem_va {
>>    #define AMDGPU_HW_IP_UVD_ENC      5
>>    #define AMDGPU_HW_IP_VCN_DEC      6
>>    #define AMDGPU_HW_IP_VCN_ENC      7
>> +#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
> Why exactly do we need a new define for this? Essentially the encode queue is extended with new functionality, isn't it?
>
> So I think we should just stick to AMDGPU_HW_IP_VCN_ENC and not add an alias for it.
>
> Regards,
> Christian.
>
>>    #define AMDGPU_HW_IP_VCN_JPEG     8
>>    #define AMDGPU_HW_IP_NUM          9
>>

