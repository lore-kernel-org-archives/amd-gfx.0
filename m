Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F98C636D4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 16:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FB410E1E1;
	Tue,  7 Feb 2023 16:19:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A55010E1E1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 16:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Icql4zlCQlB/ZNb+tFoMRapGIZqEEMBj+UcNDhi39r8uv5S+oCIIv6+iPtZ8J0tiOsrccdCEgohHyrHNu8eayFT6XCZzi6V3CfxA1+h4s/hWbdD52rKATXs6O5GEU4nm3DEScWYNPMo4d6nyLZHfWJm/cQb16WX3NXbWYSuqkQbHAWLw0UfDjlniEmHhnffPt8MKROZuLT1Wg/+iyJFxH4rylI5Ei3tUew+88ZKJKDL1onqzXzec7eaOeIiwdgGHYgHPy5DwyStMrffAbcwONUHHWOuzLSbDyHGpRQVdANYrume7FTIgJxm+MfO07s2rVgWMPKaFRSeP/G4QsYKvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTM5FcikR7AmawaGAqExRjy8zlwH3qDouZ7TE/JZeVw=;
 b=TrZItJu9APOJ7U8FD/9Wu+YY68vJP3QXVUlMa6z+VYQJL2CVr6YRgqK9Jys0H3EJKGfN2UrOxIn06fJrAuH7nJJvdP4JEhbUjrPtUwFhCpfE1pfKrCx1oe5U5IBZObixlWGk2+cJaMr00YSxfCfXeU+vtEd9fyPEJHAHSiuSF8fqn55WTObnQdQ+I4DHtN8HvDs3ogFGf4ROX9LCwjs9mZ/p46mD57z7b3ITRwOlT1eSGCeF+mmi9+Oo7XJfcMlgLUfNf/JnSJlxD3BlTwU1FtvvdaQsf+2B2zUQAYV2ULNSCxtTiSjqew8zc13U0xVZj8pJ6j0P7lZfzFvyoGKaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTM5FcikR7AmawaGAqExRjy8zlwH3qDouZ7TE/JZeVw=;
 b=Wg7pOmDogfmbvBBG1butbwLS+F3vLIcQGrvNFsVab9M/+9HGgGf9VgZE9Ym+6XoQSIYBUnnxdjpl/X3oDMQfMmUESTDF5OA89HweGv4wRaIkjC89k2uh4U4Cl2xu69Tz+0PiVAeLtWjfUEO/bLY7HFnCkSADkPyb1vBU99vImqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 16:19:08 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 16:19:08 +0000
Message-ID: <4f49d41f-2bd6-af90-f469-01df9cc43317@amd.com>
Date: Tue, 7 Feb 2023 11:19:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amd/display: Align num_crtc to max_streams
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230207040524.4020763-1-tianci.yin@amd.com>
 <8d9869ff-a674-fef6-5422-db444ec2d125@amd.com>
 <25a2f7fb-f701-fd32-a37d-4222b6242a11@amd.com>
 <803fd250-a96e-96ad-f1f7-4f867e7b74fd@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <803fd250-a96e-96ad-f1f7-4f867e7b74fd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 86296325-1ada-4400-3412-08db092709d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xaQmZ5qTkkFnYuZGvTGUdmk5KioATeixSLZ6HMxpp6xJnhuXt3PCed5+d+MoM9j0xvbNf8uKdwK9Spbb14Ah2yFwagIFBa89k6zPcITf4A69n69IrhqPure7IXoQKO+pZbYpgHZxZ/qvun6nRSGZteCmiKpP1fOO1d+e2kATu6rI7VW75sUlPhVk4IVKLOUCA2I4ppuP1PIghWlNOCDi1Qo3D6GCDW+bIFoyx1wSTtN0AW4nSjshIYJWDIiTG96pWLfCFlediFloUcOhdQoWpBQihkeF/RtzztXpkDHeo5830pSjcvTK/z1RCeTtSN5xsiuKlEFt9uqHMwPYyk23Gmy3LVZVOgAt6ZTu2nplcYqIUebHqZZEl5vtPy8GxEkv6rAXI1mfhsqQaAsfXiNeUCGItAy/4L2MnuOv329WCt8O2UyHBymuGM2dfCOTM51bbqIMlf907dn+iO9pO7/JK1G+Xh6sOPyXEriyTvYoycKaigOeh+DTElMpxQ+21r82dJfNkRijuURiDVm20aypzPKnU4PepoZ9hJjHnKEp3D5EwMUZ5aRVoA8JpQM2Q95CRoMBUVatQI0G+XQH1KHoLqEbrqjHQJbRIFcA/8nl6jr8Q7g1ibh2G5AXr8VEopJCJJTqjTPYBSAJWeQcPctP4WLiFgqYIpiGIdM0Rg4Tl+klO6WhC+v204JklxNdJ5QM4F1B54G/a6M7VmI4hJnOilZN467TWLKZsMJa54tHJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199018)(31696002)(44832011)(26005)(5660300002)(36756003)(6666004)(186003)(2906002)(2616005)(83380400001)(86362001)(6486002)(478600001)(66946007)(6506007)(8936002)(66556008)(66476007)(8676002)(41300700001)(4326008)(31686004)(53546011)(110136005)(54906003)(6512007)(316002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU5hbnpNTlBMZENxMkY1bjQ2WVhnMk0wdzlyR2VaT2JHWWV3TXNDYkY4U2tU?=
 =?utf-8?B?dHdrQkdWV2lFSGN4Mm1UcWFncG1zOTdSWDJzblBYNjFlbTBUSHdBVnlkM0Rp?=
 =?utf-8?B?eGU3dVFWRFZjYWVsV2lNWW1WN2t1S3NXdFFmcjl0YjVvRHhtdXBsZjJQRGRt?=
 =?utf-8?B?U3Z0bHh3eVVNQUFOMXcrZWhhSTRCRjZxT25ITWdYRFFYZjJkRmp1ZlV3L2x3?=
 =?utf-8?B?RjE2WW1hMGVXU0c5QktNd3grSStrenpUZktNdk5pOTl4bXErdC91Z256a215?=
 =?utf-8?B?SlVUZU0yMmgxMEc5VGc0SkR5VDRUSWFtUnNYNHV5bGpFMFh1ekJ2YVFWMlpW?=
 =?utf-8?B?TkdIMVQ4TWxLL0RlWmorbERld0VYVzk2UWZacC9HditXTmI5TFZTWVppQ3lo?=
 =?utf-8?B?UjJRTmJLOU55UDB1SEhlNEszK1JldjlOaGJZSmRpNk1lS1QvdjI4TnNmbGZF?=
 =?utf-8?B?eWJudy9HTzhZajl2UWlWY1U1WldaL1AydnBFZWduc2llZEZtT2JxVFlOQUFW?=
 =?utf-8?B?RHdXdGd1eFd2blFNSTZFcXV1ZnY2bUpNaDNWYW5lZTBaak5YeVptNm1GUjFJ?=
 =?utf-8?B?dnorQysvcXZRV1l4SUhzenNQeldqTUlvNXMzWlFuY1VRdTU5MkFTa1EzdmZE?=
 =?utf-8?B?bkRIaC9CSkZkTFNPSWc3QzlQZDI3UGtOS094NHNiSENwSm5hR00wSmJVSFVt?=
 =?utf-8?B?SVhVR1VQN3k2Y00yd3hIN005TDFvSzdlMkdHYjRWcUhhc3FzZWU2anRDVk5P?=
 =?utf-8?B?OGdtcy9TeHZOYWgyU2ppSFZIdGlmTStGTEpMeEQxb3M3Z1lQeWhnS0RJTndm?=
 =?utf-8?B?c1pnS1NXSGpwd2QzRHRKRTMwVnY4Wkl2VjU4dHJtb1U1YWFNY0RUMU1LS2FD?=
 =?utf-8?B?QTdFSlNXMitSZHo2OTU0L0RKMzR6Z2s1cHltRjUzSTE0ZW01dExPWk1XZGFN?=
 =?utf-8?B?YlRmOXhNUThNaXpLTGdGYUVUdXZjZUhNTHlXK2Zsd3ExaitwS2FNMnFsaWwr?=
 =?utf-8?B?VkpPQi85RCtUZ1prSFJqOXZ6ZG95UUs1WVNDSnNLWlh2VDNaZE9nalhIMmN4?=
 =?utf-8?B?cnYycU96NEdCTEt5SVNTZkw4T0NLZTBaMFZ3SHhnRjJ1MmgzTzhaZy9YZFpV?=
 =?utf-8?B?SEoyUzdIOGw2L0xWZEc0NFprVjdwS1R6S3R2cjRkOFExOWg4WURRd2NEekhr?=
 =?utf-8?B?M3ZmUTNGekI0Ri9SaVRYN3JSbUNUaXEvK21KazdrNmhoYkZiTS9vNlRjcXZY?=
 =?utf-8?B?WHlsUlB4R2NUemRFNlVNdVJ0cWw3Tm9vZlVQUEZyUTFXQVdNbXFZRWdGNWxW?=
 =?utf-8?B?SGM0ZVlCWHRld0lycHV5ZU5FOFRuU1FGb0JmNnRCWEtnZnFDalRPOGxqbERh?=
 =?utf-8?B?Q3RVaWV5b3R5NUdrVENOa3VZQTQ4WDVlbWdyRmQ4NEVUT3lrdDNHQUZ5MlZN?=
 =?utf-8?B?OStoSWdrZWF4cHZIeEZ0cnlHanVjQmpFVm40M3FiaXpWbTkzblNmZ0V0SmV0?=
 =?utf-8?B?cWxtLzNLcktZUlIydFRQdklIdWZ4R2Z6YzVEUVVidlIwamJ2S1dPcVpPMlJT?=
 =?utf-8?B?ZUZBc1F1UHlOd0dqbm9NanJ5Vy80R1FJRGV3Zk1YZ2V4dzdlck9ob3d0S2c3?=
 =?utf-8?B?cDF2Qk1Lc2tka1NUaWxibnVhVlN4OTRGaCswSjBMbUxtVnpGNkRxZHU5VElp?=
 =?utf-8?B?S3RYejRVN29kREZVV0drMkhNK1I0a0VjSnlPZDZNSUpsdnh0YVlVYi84TnN5?=
 =?utf-8?B?cThhVGVVL2FtT1VYVzF0bWNwWVlUcE9Oc0EvWGVCbW11c2Nkc3pnWTRsM3dn?=
 =?utf-8?B?ZitFbndoWDJKemI4a1Z3SzBhL2N0eWJpYytwOEZOdGQ4NTlnSzlXZUV5cXBC?=
 =?utf-8?B?cjl3TUplbWNOSzhYV2MrakpqTHkrU3djaVVlcEd6QlBEZWxBK2ZmbjZ0VXd4?=
 =?utf-8?B?WWR1NVBxZjUzRVNvc0tzVkV2VjIzcklNdnIwcVZvNGI1dXR3MzN0N1FtRFFK?=
 =?utf-8?B?UEpMRlJuckdONGNlUjNXNUF5OE94UlFFWnZHR1Q4OHZSK0RHaEltMURZT3Ar?=
 =?utf-8?B?VVJ3eFlzMXVIQkwyS1VrQTJaM0hubW1CWkZXcUNjU0NKbHJpK2k3K0hIaTlT?=
 =?utf-8?Q?+W1upCUnfnuMk8njgXmyENKNS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86296325-1ada-4400-3412-08db092709d8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 16:19:07.8469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NUPwZj6JoMeH6zP32zvHGXuhzJhubXieEN0t+exK9N3QFNaDFZyuIGnGClazwoHbWC0/lF0iQ4GU4JOaXIU+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/7/23 09:41, Hamza Mahfooz wrote:
> 
> On 2/7/23 09:31, Harry Wentland wrote:
>>
>>
>> On 2/7/23 08:00, Hamza Mahfooz wrote:
>>>
>>> On 2/6/23 23:05, Tianci Yin wrote:
>>>> From: tiancyin <tianci.yin@amd.com>
>>>>
>>>> [Why]
>>>> Display pipe might be harvested on some SKUs, that cause the
>>>> adev->mode_info.num_crtc mismatch with the usable crtc number,
>>>> then below error dmesgs observed after GPU recover.
>>>>
>>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>>
>>>> [How]
>>>> The max_streams is limited number after pipe fuse, align num_crtc
>>>> to max_streams to eliminate the error logs.
>>>>
>>>> Signed-off-by: tiancyin <tianci.yin@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index b31cfda30ff9..87ec2574cc09 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -4285,6 +4285,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>>>            break;
>>>>        }
>>>>    +    /* Adjust the crtc number according to the DCN pipe fuse. */
>>>> +    adev->mode_info.num_crtc = dm->dc->caps.max_streams;
>>>
>>> This would introduce array-out-bounds issues, since there are arrays of
>>> size AMDGPU_MAX_CRTCS that use num_crtc as a bounds check.
>>
>>  From what I can tell max_streams is always <= AMDGPU_MAX_CRTCS (6),
>> though we're not checking. Maybe it'd be good to check and print a
>> DRM_ERROR here if that's ever not the case (e.g., if we ever add
>> any new ASIC that has more streams).
> 
> I have had UBSAN warns before commit d633b7a25fbe ("drm/amd/display: fix
> possible buffer overflow relating to secure display") was applied, so it
> seems to already be the case, maybe due to virtual streams.
> 

Interesting.

On closer look I'm not sure why this patch is needed. We already
do exactly what this patch does at the beginning of
amdgpu_dm_initialize_drm_device:

> 	dm->display_indexes_num = dm->dc->caps.max_streams;
> 	/* Update the actual used number of crtc */
> 	adev->mode_info.num_crtc = adev->dm.display_indexes_num;

Harry

>>
>> Harry
>>
>>>
>>>> +
>>>>        for (i = 0; i < dm->dc->caps.max_streams; i++)
>>>>            if (amdgpu_dm_crtc_init(dm, mode_info->planes[i], i)) {
>>>>                DRM_ERROR("KMS: Failed to initialize crtc\n");
>>>
>>
> 

