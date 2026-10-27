Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1C606A322
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K7DrxCoR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4AB10F603;
	Tue, 27 Oct 2026 14:51:43 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010043.outbound.protection.outlook.com
 [52.101.193.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7831F10F603
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 14:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/r+sU4cLvUzOaNMzNNB62TZdBdUoMSzwkEzNGQBIXJGnNcXw0uqQD+J7CKaOkaztIrLENUiiNDex1vaH9YYXNI0mOKURaax3cQ2BwgWZRQgmVKfrQXwXo9CGIMW/DN9NhaiYauarU1NY7HB3fclz8dBAQdveWQ0I2dVv/qHL7yq1U7wBwU3+G2bZ7gs7sygG2I3G0l6msTp4gZ8z+2BnDJQrwyRvqWrv3cMV1IyZlpQ2fTkunKa3Ife8i9uXYlUC/gla1/GnG94amwlFW1xbz/PvjRlqwIEscyY2Bz/C5BQEJWrMn0J4DkJ78xCKlRWAHYqyoYSCJLvdXf1D0eZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3DXw+slQAqcV6wyFIST3sWEYpfV9toB3/J7zeNpLoY=;
 b=UXAr2hMdnwH2BBcp/Uy0UvVn0Nw7ydr+Uini2CN3YiqqoL7GyPrSD8CxwIm21/MdpZXRMnnwpbxf27H+Jli26JSX7hx53Adcy9QDyHonp/Ml8U0ge1aHfLusAe4kgs/oudjlS2Mbr2DEpI2AVu/+HgNs6W2lWPM50iNq28seM6JxdCoVKcFGk1L7zpSB9vswBgC64l2UGInrytsUW+T7AF8V45dGG2KoEyXIe6Gij9iooE7UlovlvjhmpxEA+5H6oukrvofjSagce5j2/orq2lRK6GHhU1iCl/4Ok8PmX//cUJz4xxcYLzOV59CIJbreNgnwrMohodygNhJRSj2/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3DXw+slQAqcV6wyFIST3sWEYpfV9toB3/J7zeNpLoY=;
 b=K7DrxCoRG2vgXoZHp0JXqrIZKQ3fO3wMutBM4AaijDJYwkBc91l86jLhrtguyhaEnfSwkuTuiBB72B638XKPYfcueZ/jM6ieB1E82fNB3/o+t0+sCfwmQUw5dcuJz+bF7czMxs8HYUx8Y3SbGQ+fZisnUNBM4zKbXg1bdbENhNo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:51:32 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:51:32 +0000
Message-ID: <a26991de-7800-4b8d-933b-937abec7d3fc@amd.com>
Date: Tue, 27 Oct 2026 10:51:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Bump version for allowing jpeg type 4
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>,
 David Rosca <david.rosca@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
References: <20261019200726.15262-1-benjamin.cheng@amd.com>
 <20261023132447.1036020-3-benjamin.cheng@amd.com>
 <8cf04fd4-e539-45bb-b17d-ef8f2f1125e6@amd.com>
Content-Language: en-US
In-Reply-To: <8cf04fd4-e539-45bb-b17d-ef8f2f1125e6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::21) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 912098a5-ad7d-4c87-1e6c-08df3439ca3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f4r2+5DMjb+L+qCHfYm7E4GxTEZOTQ4iHnDHj0uNhLR7Xn2hMhDcmdyHmxssym1cFIjg9B/BMKDbkckylXT2TsjmI6GCkv8IgClXYUx5Z6B9z3+ZZTx0If8iwZJIfXN1ki2i41c08psn/uARJqL4k9698SnzrkN/tJ44FEPuQEpOdHFYUjsxbX7+U4TeW14LOKRC6GQD9QbBL2mFJWcFGQS6rKSPHjJZ0aAQPRSTKThzekqNqrh3AA/8R2SVwCUjX4aAIyTDAyAINCqmkSRRa7UIZ0KJjb8mybhgnX4sBcJv1WsxKURkCYSRDkdzJwjHOooyLy0Wn/R0nXfGlQjYsYwrrhznwvLWq1NCvDhyvK9xRs0quxw1GIlF591GL5L/iFtHiq8m/fuJgAEGGTGfXzxQ0cH6ZuyngDxPL4WMhE82pNlFR5J451upNMOPd1trmGCGCJuGIfAASz5yrROksGQ814ZftDw6KsKNGiAQL8stp2WPZeKK9vyhkRsgtpHoMOxR0+J2VY/7IgA+W7Mxxt8DidqNmhsqAFrn+3ZOedp11UTcUMKyT9IhIdqADKnpwYMZTksgvJnRGyl64QI3VfgurhIY7keSO1x8Dwc27uEMAX4E5F8vBds2Gi+SdEic6uMsqYaResxXUTYN/qvZFWW76hKHaJySaPu8J6VQa/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUVHb1FxcUlSWW9wRThYWGMwN0hvTHpYTEFsbFExcXAyaXQxQnV1MzJKZ1Fs?=
 =?utf-8?B?U2NiRjFEODBJQ1g4Y3JURzNCNkVTODY4bjg0dUVXWVZLb0lRZ2xKYWFueVpn?=
 =?utf-8?B?QXZ4VnJTanpQSjR3akFRYmpiQStnN2Z4VUZaZmJqQ2Y4cWR3WEVoU2hFblJS?=
 =?utf-8?B?R0NoVnRSUnpSMXo5anJ0Mzh1RE51eFpkOGk3K2hhWjJsanhQL2lnUUJDekpT?=
 =?utf-8?B?ZWw4N0IwcmtVTlNBazUrSUg0OFRXVGVFZHpzWG5jcExjU1l5SDhPV25MdGdE?=
 =?utf-8?B?KzB5K1EzT2ZDblh2SmtFbDJkc3daKzAyZDlQWVc5aDdPdzJXclpNN05keGlX?=
 =?utf-8?B?TUVHM0tMQzJaTk9ZeDVINk8rTWgrb0lSNFAvaUIxVHhFd1hnV2cxSFEzUDJ6?=
 =?utf-8?B?T2REZ3hYSWRiRXhKamlmc2lwYjU0bDNGVHU1Y1F6N0M0WXh1Mm5YRUpCdU5B?=
 =?utf-8?B?alhSVzRsRnorOVN1REFVU3o1L3JOMG12azN2NkEvSnA4bnFjNTFQcHkxNjAy?=
 =?utf-8?B?Uk0wdjdYbDdHQnU2VUNzZVJhV0xGVlNSMTZ1SzRubUMvbE5BQS9MaHVaaXpP?=
 =?utf-8?B?bkxuSWV2eDMyc3Fvd0s3cXQwMENNWnRjVEMzajNwUm5XTkRaYjdLclR0RDRq?=
 =?utf-8?B?QW1yM1BQNVhEcnVSRTRURnlWWll4cmVwLzFxVkVIemxORzNvaFpFMHFJWGp6?=
 =?utf-8?B?L2RiczBycUlwQkk4Mi9GTkFBMU53U1Buam1vVFlUNXU1RnlUbnBMekd0cjZa?=
 =?utf-8?B?YVRYTlBmdDlvRnNNWm1ZbGdKeWNqeFVrUTNNczk2QklsZUlFSnJ4UGlTWXZh?=
 =?utf-8?B?aXlKRmI3dUR5L3ZGVVJHLzE2citMbVUvT0o5WCtwSWMvdTRYTjZFMitMRGs1?=
 =?utf-8?B?RG5BYkZCSFJBNzF1dklFNDh6aTd4cG5JTmRiRG15MjI4VmQybG1RQ2NVNkN5?=
 =?utf-8?B?NlVkOGppWUFhUU5SUXY1czdneG1xeFBjek4zclFpOWFXNW0yaS9pMlVJbFNT?=
 =?utf-8?B?c1ExNGRyc0JmeUFObU5IQWZyODNPTUxMa3I0UUg4eldzOXVBbEk3YWdOaXBW?=
 =?utf-8?B?NEZPZ0NoZjRvajRleURId1ZRSDdXaVlGY2p6bjRJUExaMlBYZU5VUjhTTlhB?=
 =?utf-8?B?VUxyNDJrWlYyMlpUTFdMLzNRVEF0NkJxUjc0ZnJ1K2ttZGQ2cG9rVCtaaVJp?=
 =?utf-8?B?RDlyd1dHc2J2cU5LaWJaeW1aUHhqNkFybEo0bDZNUXBHeDVpMldYK1lpd1FC?=
 =?utf-8?B?d2dDRE9aTXhrNGNpaFhQV0FZMnJ4djY0UmNQempsQnIzWU0xcDdCak1XcjBC?=
 =?utf-8?B?Y3hTdkJyK1FvT3RDRUZNeWRia1MzOFdWTnFCREhTNVYwVnRpbmFBbzlIYjBp?=
 =?utf-8?B?T0dNL3Fsekt2UGl4TGJJOXl0Z1E5UURET0R5Q3owZDZ1R0p6MVpIVndSNURh?=
 =?utf-8?B?YmpBMmM2TmdqNnpiaElkVHVJbjBKSEZ1RENJbVlHK2FlY0s4YnNVTzhtQkg1?=
 =?utf-8?B?em01M05CeTFFREFoVjNYenU3bkNrTmorUXBhTXF6MU1UY2MwdFA5WU5xUnkw?=
 =?utf-8?B?MGNpQlUrYUZhWU5GcUNmK21tOVJaZ1R4QnBsZmo0Wi85NGd0dlp1TXEydkM3?=
 =?utf-8?B?M2RNZEtuVC9sRnN2MW1Bc05raktWVFBrRUZjQjVQaW9Xc1Y4enR3WlJiYitt?=
 =?utf-8?B?S0o5aThyK3I5NFlza1l4Z0lVZitTL2xmVC9KOUpNQ3Mxenlhb25UeVMwejYv?=
 =?utf-8?B?NCtnVTMzc25pS3Y4YThxdTM3aUpCMStlR0pNd09pMDdKR25FcjEvUVd6QzAr?=
 =?utf-8?B?K2V4OStSSlZkMlFQS081bWdFR3RkeGdLb0RnZUxnSmVVbXpJMUZjRURCU1BW?=
 =?utf-8?B?TjB2ZUZDRWl2S3lFdmN0ckhXR2h2TTArZk1Zc2JnWHU2ckZudXdrKzVXOXRt?=
 =?utf-8?B?MGtHWG9oTFFDWVR6bTB2WkJOcGFHK2dnUE5qVWdSa2s4RXA5VzBBYjFVOStv?=
 =?utf-8?B?MW1aMjBQTEdHM1NHanhCV3lJbjVqdTFIOVpERHBBcDhxOWRtWjdnek5JZkxJ?=
 =?utf-8?B?cng1TytaK0JLVmljNUs1NGRyck54OTdZMnFiL3pPWE1uSjVpa1VPKy8vOHhp?=
 =?utf-8?B?VlIzQnNyUDBwOE1leHI1VVIrQUdaUHJzY2c2NXdSQld5YXZLbnViczRqUE1S?=
 =?utf-8?B?b3Z6WUF1ak4xRmw2V2JJeDFkOEx5VmR5UGFjQU5RaWZxVlBHcGhzVlo1V2Yw?=
 =?utf-8?B?a3FOM1Nhb2QzQkpCQ2RYTVNYQW15a3V2cUUwTWFpSWRBZG82YlNYbWFZaG1x?=
 =?utf-8?B?VE9MNzZCZVVsT0d6TE10WXEydGFiL2EyMnhHZ2l6RWVpVFVZQ1M2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912098a5-ad7d-4c87-1e6c-08df3439ca3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:51:32.2528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wLvm5UhodoD7FypKt9yMiAktdYp4tb8zroSjPTgK/0togTD1+M+yQnwS2dHpKBg0CU4JqK/XG0nkFS34Y6KiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 10:42, Benjamin Cheng wrote:
> Hi Alex/Christian,
>
> Ping on this patch that would be submitted last with the previous 4 patches in this series?


Nevermind, I had a discussion with David Rosca, I will land this series before his VCE series so we can share the same version bump.


>
> Userspace needs a way to know that the type 4 packets won't be rejected.
>
> Thanks,
>
> Ben
>
> On 2026-10-23 09:24, Benjamin Cheng wrote:
>> Allow userspace to know that kernel will not reject type 4 packets.
>>
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 3e5634de077f..1325f9b2b096 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -128,9 +128,10 @@
>>   * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
>>   * - 3.64.0 - Userq IP support query
>>   * - 3.65.0 - Add userq syncobj timeline signaling support
>> + * - 3.66.0 - Allow jpeg type 4 packets
>>   */
>>  #define KMS_DRIVER_MAJOR	3
>> -#define KMS_DRIVER_MINOR	65
>> +#define KMS_DRIVER_MINOR	66
>>  #define KMS_DRIVER_PATCHLEVEL	0
>>  
>>  /*
