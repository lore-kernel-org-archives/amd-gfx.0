Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B1FC636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B09EA10E51E;
	Tue,  7 Feb 2023 14:40:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB3410E51E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhOcUCihpiTEZUYP1TthMV6XD6Xueg3PxW0A1YgqQX+kLJH5CkPfa23uie71gtcAZ3Rt0CyFk6rim44CTxvhsq/4/lz3i5E5Md8a9htFQWz57TN7eQ+9ru1iVLYCLgIpx2MsgxvGEDxmSg5FurihA2y3wrjs878vcRRWnH2CwTK5lP018yftXq4SOO6hyirCmuDeuhxQ50Glia3xl6dx+1aHHemQJrHVGa8EDehU5OK2qRUh56tWd6C8ofGjSkV2tNXPuDntnG82Gs6uJOZqub5oe/Q+Ih8wfSLjMm6WKEQXIZbsWHW6D8kvSbijNcyn+acNkdaX4R4jFKwZbjb2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJX6hMhbUX3loXggWexajbQxwOOGr8X8cHk3Z3nNwaI=;
 b=d6fpJoF6Dwn0uU6k9+Bc8heyvyS9tGEoRnvowJu6KwEHxOuvLZ64oVvntk3olQVrbTh1QCx7oPmp1ZXvuALKiH+N/nVnIgVW8tUaMUZnhz0DEn/KZgrwXo8gizwGAHktkM+XCm1jH9ZBhY63QB7hHIL+XkWHymXxT+NzRevV5M7loePyGHIpvCqmMcxxpk7dR4fG6bhO/BT6eYzcy2OQplkCySnJ1+QlcxPHPXMda0pplkdigJUi4xIX8+sTEyQUb1/6+TlBMdpe7oEyy9Zd9gVvevzZNj/6Kk5Bna1akBdlFtn9i6yfdrRcWk2s4Ig+PfMAWu/aRGlJ0rl4o0NGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJX6hMhbUX3loXggWexajbQxwOOGr8X8cHk3Z3nNwaI=;
 b=aZce8BBgo3483iQAcoIvIKKeHbOOm767oqMjhaDpD/MuJk2WqSyka3tYqW8LDhyvSGGU04sa0IqBjt58hsnzX+SQK8XVFJ/XG9vMH1OVf8+1CFweyul7b7K+Ua0nXQQ0YzF36UwSp9FD4ZQwwF9is63eH3s16142luAY3C0YuJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 14:40:22 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 14:40:22 +0000
Message-ID: <803fd250-a96e-96ad-f1f7-4f867e7b74fd@amd.com>
Date: Tue, 7 Feb 2023 09:41:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amd/display: Align num_crtc to max_streams
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, Tianci Yin <tianci.yin@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20230207040524.4020763-1-tianci.yin@amd.com>
 <8d9869ff-a674-fef6-5422-db444ec2d125@amd.com>
 <25a2f7fb-f701-fd32-a37d-4222b6242a11@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <25a2f7fb-f701-fd32-a37d-4222b6242a11@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::12) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffc0899-848f-4791-53c2-08db09193ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Wx5NxzZmpfVjkcfvEVnbCI2dzWwij+0XWbG3FioJ4x/dBh0yFTRwpUrHXAeSsJYLxMhPb662fxb/Xp+kwL3AQVyHVCLKDBWE6ycWGONhYR0xe43zVcSHXHphDoYns0T98jnJoA7BiweKVa6JyafK9xGfvrXECy+DzDHmEZGb4eYfgLsoc7dKYLxjX1x6uHoj71R+L0CCEjfbUmMJcRULA09+fA0hCalLCuinBpQLbhjqNR+ebYoh/Nt2a3VafI6IACrX8+7xyU4fIjN/Ffkmo8UR5jmn7VVlhQRY+yf1KTrXKmtFHuiniDdNgUfwrbF/y5eHKjYbx/u3mMrbTaMb4g2oFC8ViaNdr0be3ha8K4nteWeBOb2cM4xSYGFAbdKP4y7gy2jf63ilI4X+sGULftQUhqiUbrnbCuj3y8m3nj3NAUskVQEtUXT3UiI7v2/bWFtovYBypkYE0aLcfX4nsKZwi+2e2+qIH4amaWkm+s1NQ3nJzWHvG6UoLonW6oWBcq4ZZ4JiSxyAATQgkFVwcJHoFHzRazVmNMh40+vIhIVTs27J+HriKomyF4uZ9GXcvKdr/GmNEeMvwV6Xrqk/nqm33N9A1Bt/h/KlXrXrMYnlf2azuCY4D0yNNrkFjoN6TMraXp6/vC4+UbGweykYNagw+KcXh8hvhg2JPd8Q0CazD1orMOGh5ikbG4uerUTQCTlKb7ZAaEJ87ALfT2sYMu6D5JTYBqGIsO3g6USV54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199018)(38100700002)(316002)(8936002)(66476007)(41300700001)(4326008)(8676002)(66556008)(44832011)(2906002)(66946007)(5660300002)(83380400001)(2616005)(53546011)(6506007)(6486002)(26005)(478600001)(186003)(6512007)(31696002)(86362001)(110136005)(54906003)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K09LTU5FV0xENUJKRFNyako0dklKK2ZTR244ek0wcmttSUVmenR0T3I4d093?=
 =?utf-8?B?eXoyR1pRR3ZZK3Yvc3pSQkpqMlpTZC9XNFpCUW45SmEzOUliMElRdVR0VCts?=
 =?utf-8?B?Qmd1L1IrdVZIODV6NWVwYlEvbGZTZFMvaVA0SVM5djBqNDRDMW5FeDdGYTRo?=
 =?utf-8?B?bXpEN20rQWNIeVZZSTNGS0RyMjNxajlFdFFCS3NqNWxaS3FJUkorUEpDakdN?=
 =?utf-8?B?R0RjVUJGSUM4ejlrQVJFOEdqVGdodEZvYnZmRFRKdFFFbnRnZk1ILzlhaFQz?=
 =?utf-8?B?aFlIV3RwcU9XbzBMampJRDRFZTMrOEE5SGtCTVZ2aUVrMHl3dThtUmlnUHZP?=
 =?utf-8?B?VFZTOS9ENC9zQmRXYjAza21qNDVqQ0V2SE1rUmdmckJ0STFNYkVzb1p0Mytp?=
 =?utf-8?B?bGRTSjdiRTFudHJST3hIdHRlYzBnSXFIeGdNQnE2bmtvMDRYajRzd2VFUnRU?=
 =?utf-8?B?MjBXL3BBenQ5aGRlMjJGMm5MUm1LREZ5OTY1aGg3cko3WDFaM3QvNjk1SHlt?=
 =?utf-8?B?bGFCQTV0VnJRM21TZWx0cEM3VlppZ2lPQ1A4aTdLTWJkMFhFU2h4YU0zN3dG?=
 =?utf-8?B?aERYYzVsZW9ORXVZVWE4SHJxc1VONDE0VE9MMHZjRy9hTGQ5Q283MDlidklH?=
 =?utf-8?B?OW9STW5FN1hYYW42T2o3U2s1aS9Mc09uYjhwYW5XMUdWckRyQy9XOGJzMzdy?=
 =?utf-8?B?ZVFuN2ZNL3JqUGs3T2hTaFZPT3FHdzVzYjJzYWxpdFZrN3R5QUMrYUdBUEl2?=
 =?utf-8?B?WlEyVWlZMnJWb2FPVmRnMjFYWEVheWtRcWQ0c3pYZGVpTE51TmFVVm9kbUNS?=
 =?utf-8?B?UHE2dnV1blNYeDZmTyt6V2lMcnhaTGZVWFlZZEtLcDN1UjZJR29DOFpOQXlH?=
 =?utf-8?B?NVVPSUNKN24zWldKMmtwZVFIWHEvb2VHbUsraDFLTXBuN1I2dStncmVGRlBU?=
 =?utf-8?B?cnJpQ1VsbFUrOE1zRHZwdlcwaHVLWk1BM3VwOHd5Z0dXTW1YMDJmZmJ4QTVw?=
 =?utf-8?B?MnUyVytkU0wrNFUwazBYb0hvWUVCNGRYVjIrWE53VlJvbmoxelg1c2g3bUlQ?=
 =?utf-8?B?TmNPZGZPTE5BWmxFemU2MlVtaG95OTBKQnVWMytxSi9GdmZESmw5NWJkTEFY?=
 =?utf-8?B?SUxuQlprMmJXU1ZJamc4NHVOS1VqMC9CUmtNak15bnBCS3pIQmJiUmFMZms3?=
 =?utf-8?B?N0loVWF1Tk5lekROR0NOL0h5ekw2QlcwMUhDWkh5YWl3ZEhMVm81a2dhKytV?=
 =?utf-8?B?RDYvRUhIaDZnZFJuNHlpWTgvTUQ2MlJ4czNxUklsWGxDaU1ZeVRXVjNZd090?=
 =?utf-8?B?T2pmMWJybnc3L1lPSExHbTRoK1RaUE16dGRkbUlXeEpzcFhzcnFWWFBNdEs3?=
 =?utf-8?B?UFFJeFFVT2hGZTh4YVd5aGJVbCt2bUFqYVRYNVpIenJ6RW9JT2U2QUIzQ0hP?=
 =?utf-8?B?dnIrc0xBRFdha3dobEdHY004Y0xsdzVGODMxS09OZm02bUF3N2lpcmc2ZW1a?=
 =?utf-8?B?TzVLMnRxVjZZQkFUSUcxU2VsaHRYWXdSNHQwN1RjaXVOK00zaXNveExHbGJx?=
 =?utf-8?B?S1RKaDFpTHh3SEQyaE5PR01TSGk5aDZKWFhVdjZQeDV1d1hBSGdmK2tKRHZH?=
 =?utf-8?B?UUtwMm5lRndqS1BUSWZtd0QrcW82NlJ4aGhOMHpzQ3lFU280VU9rSnF5VU1l?=
 =?utf-8?B?ZnNzdEl3SkZsY3BPdG9pQTBjQjhaa21nL2MvbStzVGkyZy9ZNGI5Y0NDWFFa?=
 =?utf-8?B?WUZKMkpMbWorY2VNMzFBSk8xbXZQYjQxK2gvemdsZUdrSmFER21qcHdKanZX?=
 =?utf-8?B?WEIwSlRXOE1MNjE1ckw3bldwWkF5VXlXdm1sRTh5R0ZZNkdMWElPSWhsaWEr?=
 =?utf-8?B?SHpNYnpxRnJyV0JtMHRpU0tvL3paNG9ZWDNaNUo3UmF6UHVESy9CTkJsYTdM?=
 =?utf-8?B?UHVuTkZXeGtBRktPVU9IdmxKcVVDaldnM0M2Vm5YcHYySm4vUlZsM3B3VzNQ?=
 =?utf-8?B?RURLdlk2K2w3RG1jVjZYQXpPUEdqU1MvMVFVQ3loYXJyRU1hZ1Buc3ZBbjdQ?=
 =?utf-8?B?LzU4VWQ3ZXlVNnVRQ3VDY05ucWhMczhsa2lyWjVYUUlyNjRjS05YYWhRWHBV?=
 =?utf-8?Q?5ZgoERNI4RrF7ittDrJhm7PvW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffc0899-848f-4791-53c2-08db09193ddb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:40:22.1548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kz/OlX47PY/LY50Lk3cAiWSR1aXMiJxwlawGblAfqYsAHxh/5hj+SRCewL0H/iu63C450jp7aBaXCU8nIaFuEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035
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


On 2/7/23 09:31, Harry Wentland wrote:
> 
> 
> On 2/7/23 08:00, Hamza Mahfooz wrote:
>>
>> On 2/6/23 23:05, Tianci Yin wrote:
>>> From: tiancyin <tianci.yin@amd.com>
>>>
>>> [Why]
>>> Display pipe might be harvested on some SKUs, that cause the
>>> adev->mode_info.num_crtc mismatch with the usable crtc number,
>>> then below error dmesgs observed after GPU recover.
>>>
>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>     *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>>>
>>> [How]
>>> The max_streams is limited number after pipe fuse, align num_crtc
>>> to max_streams to eliminate the error logs.
>>>
>>> Signed-off-by: tiancyin <tianci.yin@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index b31cfda30ff9..87ec2574cc09 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -4285,6 +4285,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>>>            break;
>>>        }
>>>    +    /* Adjust the crtc number according to the DCN pipe fuse. */
>>> +    adev->mode_info.num_crtc = dm->dc->caps.max_streams;
>>
>> This would introduce array-out-bounds issues, since there are arrays of
>> size AMDGPU_MAX_CRTCS that use num_crtc as a bounds check.
> 
>  From what I can tell max_streams is always <= AMDGPU_MAX_CRTCS (6),
> though we're not checking. Maybe it'd be good to check and print a
> DRM_ERROR here if that's ever not the case (e.g., if we ever add
> any new ASIC that has more streams).

I have had UBSAN warns before commit d633b7a25fbe ("drm/amd/display: fix
possible buffer overflow relating to secure display") was applied, so it
seems to already be the case, maybe due to virtual streams.

> 
> Harry
> 
>>
>>> +
>>>        for (i = 0; i < dm->dc->caps.max_streams; i++)
>>>            if (amdgpu_dm_crtc_init(dm, mode_info->planes[i], i)) {
>>>                DRM_ERROR("KMS: Failed to initialize crtc\n");
>>
> 

-- 
Hamza

