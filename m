Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BA3E7AD77
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 16:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F1B10E2EF;
	Tue,  3 Oct 2023 16:44:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E137010E2EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 16:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwQeSLzytOJMr3tIkdDcZ9ApR8/Bb95JvrfjTzASEahAgp9mkbhwrsdComtwxij6LsBXPtNiV0VYqwZasqzW+kF6ntx/aq442RxgamDuLXc1ZWCp0nHR0z9M89IZGEopq1nsPfQaLYI4XyeM24oubRWhqo75GQNQ7gbLc8YCbYKsUewWwSb83KIyhhtjzhyyjKjToF5zwbowyitnWcbXMdepLQch9/fFN/enJzFXDA3rR1lHsPw3qbIWqxWbZlK2QsjMmRXc5ME2FUB3uEEkuiu9HhRhWVZEA9mtfUO2GB723RdsXo+G+95QJfu22uN7/1OCARmrHI5NRAPeVQtNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBvx1WBuSXHYYZ93F+2D5H9pVDjICuvubMB5hD38WWE=;
 b=UfrKJskcqele+ew3xLBoHpN47/Vk2ytfagximyXxZvoNm176Gmko1aJnpk4EVfL/rF9nZoA5ZSBHLvyR9XrcmYLmymn+SATUquQapE/qaqC3dCgFbNn2CM5Mozn4EMje1vpku1yMlOEdcQtWIV24YnZygQyYw8u5zAv3hqOEgqPgeJZ2G/lpjT0igWU0bBSeSnhBzTIoUchQ67EJxO943eWK4M7Xm3PxQgV8Spa/Q+fTQ8zci2K1XdGiYAbcMRw2pgd5zQ1uuJE+NJsppQ6Jiy5L67+wieTaIIJ0kup4it88qYHCEFTucRdcFpXY7z0RV4+nw1PEA/gwo/m7U5Ou4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBvx1WBuSXHYYZ93F+2D5H9pVDjICuvubMB5hD38WWE=;
 b=Cv0nhXoxo8eLWGdgVVT4Ie3/cCNdsqBkGUPqY49/BjtMz+xTZ7VWpVtQWtjmRkqiSN+pYxcl7X2HTFoH9GqGV3+aiP7CanhxqOhfGg7WXF5NFw7xM7nasRxQM4maC698CGGvnLk4t2jqkrcGAt4KpXV76j7VxZ35DsZSJ4uiEcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 16:44:01 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b%7]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 16:44:01 +0000
Content-Type: multipart/alternative;
 boundary="------------sLJl1qEjSzFnB18npMiU2hAu"
Message-ID: <07ffc69b-d1db-8d73-013b-46ad7321f29d@amd.com>
Date: Tue, 3 Oct 2023 22:13:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: fix ip count query for xcp partitions
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230921124929.1965750-1-sathishkumar.sundararaju@amd.com>
 <CADnq5_NTHMU5OAb_Rw1iWyHB0ksgv8v7C2J7A9TnUdgRt-1_Yg@mail.gmail.com>
 <d96ed183-6806-c2a8-7972-fab3944aa02a@amd.com>
 <CADnq5_MM-_zR6_nDdfejpoC=m0Xv4eM5ZQkoVZH6qnChfcaWCA@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <CADnq5_MM-_zR6_nDdfejpoC=m0Xv4eM5ZQkoVZH6qnChfcaWCA@mail.gmail.com>
X-ClientProxiedBy: PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::18) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM6PR12MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: 459cc449-09cd-4d76-7db5-08dbc42ff23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDdH3RAoEBkTo/wijSjtymuJX/iUJia/mnGsbIMrUYCAtOk5MuF83Kh3xKyg+oUlT/dPy6Aq1DvInpMvWdKqp+5cJ5lJTyM+N86g4FAeAt+BZtf7xh/+YQKEIbUduO4W/8LjVh04JxoL6h+w1avLrZWEQ2YSoAQNuUYMvuhW6mXjw/cVGWcnaxP7+8BkJTxJF+S11rwMRjl5Z+tZ3x1xSK03FrkAeyIqgzjVgFXCQCv8RwjwUewc4Z42ERsYbisK9ijZjXTaOtmukEP9x7NAAShdHtOM0Xz2tRstBT6hgI4/CnFXxMtFZQwIgO7pnL+rsMZ41jIefcLXpZ1gS+FfyqKYSJD0Bet4qb8V4grYcu+mImIVkqNQzF+3seu/iYwzu7DeL4BX2IrNdB8fNJKwMJp+C3OCKJW2+a0woMs/jk8aNHmdT2XhejkK3TPHAF4t5n8E/jRJsE3XVWp/6rosehI/I2MJvwxTI0t84twhe7F8fiObPFvxo87HhTEOAkG4LnO/ebd/HCUrAV+bbg7xZEaAsJpibpsAoObm3AGGQBonMMAUWK3IyF2QJ+5tWcOtP+7aPwlBPrddRDm+/15nhy9jjRt+51VV/dsqBUICEdTQbr3Mf2XdgB5UW/un7yjBEs2cEE1aGUnK2x2Ga1sEAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(26005)(53546011)(2616005)(6486002)(6506007)(6512007)(6666004)(478600001)(33964004)(83380400001)(2906002)(8936002)(8676002)(54906003)(66476007)(66556008)(66946007)(5660300002)(4326008)(316002)(6916009)(41300700001)(36756003)(31696002)(38100700002)(31686004)(45980500001)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBFUXp6MWd3SGc4eUx0ZGtzUE90L093Z1F3VGxqRmdET1Nucnc2RzE3enVM?=
 =?utf-8?B?a2N4Q1pwZi9Zak5QUytaYW11Qk1mUjVWQ3ltc1NoeEorUFNjcDNVVXhZRDRB?=
 =?utf-8?B?aEZIM0RHWjR4VkszaW9ub25HTW1OeFJHZW40WVNPRTl6QzdjdWs4dFNRb2NP?=
 =?utf-8?B?Qm9zNkFoT0NzdmlOZ254M3JVRlJCRVlMWFN2eGxKODVtTFRhdiswWjMxRFo5?=
 =?utf-8?B?WmpOaFJwZGNQTDRWMjlpY0VKMFg2WWh6Uk5Wa3R2SUJEaXRGb25KNkVQWmZs?=
 =?utf-8?B?TW9qTzhOK2tvdXNPcmFZQ2FkNlBKRGhrQ2t0K2Q1NllkUWJUMSt3NUJxaWh4?=
 =?utf-8?B?SUZGNjFFYXFTVWFEekhXTVVPLzRkRmt4RG9tcE90ak41bmExaHl2d2wxcUFE?=
 =?utf-8?B?dDdjQ0w2NE9NNHVVQlhTQzM1RGJ5dmd6ZnNIOWZMSGF5S0NYU21IQXFxWGN6?=
 =?utf-8?B?bExhckFBdTIwV0VxdEJOeHBlbTBxOGFiL2dpZlFyNytnOW43MDFmSlJvczF4?=
 =?utf-8?B?d2o1MklNNzd5MjZhaEp2dVVySDdaZDlQLyt0Mk5PU01rNGVSRFJNQlRNNjZF?=
 =?utf-8?B?ZHBPMFhUanpzWS8xUndFRHJPdXhhUkNSbS9DT3h5RHRXWThkaFJPRVNMSDVS?=
 =?utf-8?B?NEY2L1V2eTd0aTExT25meUZxSkZaTzJFbkxIaEhtQmw4dlFEdFdSZG5OeHJo?=
 =?utf-8?B?R3A5Yy9sUkYyZGp5L2tRUzdjY0N2TC9yaGd1NG5VamF3TnUybTVFQ0t2dEUw?=
 =?utf-8?B?bEJRU1NkYWFoWUpoc3htZ3JhSVIxcDFNNTljUjVTL29EL0VWME9HVDlCMkNv?=
 =?utf-8?B?MVBrTWRVRmd2UkpIU2lsdmNHRzZ5WjdvL1lQd0wzZHRUTjYzak10SDkvTGxa?=
 =?utf-8?B?NnpSSFl5eHJRUElzeURjU1FZSFB3Wmd4ZXBISEFhVkVTUjh0TnlnbFprdDdN?=
 =?utf-8?B?S2duYnppL2VBYUEwQ0JtUzdTa2N6Uk1PRTd6VEd2UjVBRlBxU3dWWWg5Yk1u?=
 =?utf-8?B?dmtYYTVOaEdsdUNWYUsxdWE2YUR4TzZTV1prcVJSSkRGODNZaDdpVElyRVpz?=
 =?utf-8?B?b0hQS2FUdXRRcVJ2UlR4K09ZS01pL25DNVdsWUZLdjlIeGFWYms0eWpwSkcv?=
 =?utf-8?B?c1M0dEx5MmFheGlETjZvTGJ6RnFXLzlqTnRXcFVrUWRuTGVsMGVYQnR3aEpO?=
 =?utf-8?B?RTZNeDZiR0V4cHdlSWZWcVlUR21JNEsyYkRSK29BMHlQOHNBQkYyTDFmQ0gv?=
 =?utf-8?B?ZzhqZEVCcGNBWG5YMVNGbG5vZjFTZVRZR2RQMHJ0SSt5NXpuRUo4WmNyKzdm?=
 =?utf-8?B?eS91WjZvWUhhVlNENXFMQUlVOWpxcENtVTBDMEJCN2ZnSlpLejFwaWNRWWdO?=
 =?utf-8?B?dHpTWlZhcGRGc2U3d1d3RzdxQW8xS0k2cllaaFlib0psOTl4NWtEVWZMTmNo?=
 =?utf-8?B?U3FoZllHSGNYcUpKdEw4ZWdWZzVMNW5pQzYzdlJIaWF1dVNZQzhabGRyOGlv?=
 =?utf-8?B?YlBVOGZteFV2WHBCN0lSU1BYNWUvMnk4cFNuVHBCWWw2T0N3ZXo2dWRQZEpB?=
 =?utf-8?B?UWU3b01SS3BpYlRyMXVUVEtXZDZhZlZ5UWJwU1crOUl2WXFOVlhyeVh5UTkw?=
 =?utf-8?B?Mzl3eGRGZ1lYOThZMWZkeDJTbTFMZmFFRDY1M1A0SktLR3VtWEt4QlozYmo0?=
 =?utf-8?B?aGZ2L0dXOGV1aWsremVOOEU5ZFVMWjdBY2htNlFRek1xZFZlV0lLaGVyQ0xr?=
 =?utf-8?B?aThaaGcxM2JNL01KN3Z0by9OeU1hYVlsZGM4TDl1N3hxYzltRVg1cDdxNUMx?=
 =?utf-8?B?YkRiREoxWG5memc0Z3pBUlo1UFpxWVlXd3JOS2grSFkvVHBCVDdUUE1Ma3hB?=
 =?utf-8?B?Z3RyWk5BZ2JiNEJsVU5UZW53NnExb2NpMWY5M0NXOGFkYnFyTGZ6SFBUVmRV?=
 =?utf-8?B?ejhtbGd2bU1CMzlwc0xyM3UrZ3R3WmFxWEpIR2pUK3IxWlFxSEpyOFdhcXAv?=
 =?utf-8?B?WTlMUXBGeU9HeENrRFhSTmQ3dmZVTmpEZ1JIaXVYNXp5R0IrU2pOZFJrYkl3?=
 =?utf-8?B?eDBHMS9OWGROY0ZNcGRKNHBuK25QV2ozakJWL3RrcVA2ZGIrMGdsRnJZY0po?=
 =?utf-8?Q?vjWpbm6wF5098TQby//ki0eZ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459cc449-09cd-4d76-7db5-08dbc42ff23c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:44:01.2730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYoKcGMp+AOQtJRP+Y3pi4zeLXGa91YB1l2igv7YRyFNrl4XNCTsH6QQ9YcqDY2uvJoYsPhrkcAQnNdAtz0Igw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
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
Cc: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>, James.Zhu@amd.com, "Liu,
 Leo" <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Srinath Rao <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------sLJl1qEjSzFnB18npMiU2hAu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

My apology, I was under the impression that RB is a must. I understand 
now that ACK is good, checked with Leo after your response. Thank you.


Regards,

Sathish


On 10/3/2023 10:01 PM, Alex Deucher wrote:
> On Tue, Oct 3, 2023 at 12:22 PM Sundararaju, Sathishkumar
> <sasundar@amd.com>  wrote:
>> Hi ,
>>
>> Kind request to help review the change. Thank you.
> I acked this change back when you sent it out, but if it didn't come
> through for some reason:
> Acked-by: Alex Deucher<alexander.deucher@amd.com>
>
>> Regards,
>>
>> Sathish
>>
>> On 9/21/2023 8:17 PM, Alex Deucher wrote:
>>> On Thu, Sep 21, 2023 at 9:07 AM Sathishkumar S
>>> <sathishkumar.sundararaju@amd.com>  wrote:
>>>> fix wrong ip count INFO on spatial partitions. update the query
>>>> to return the instance count corresponding to the partition id.
>>>>
>>>> v2:
>>>>    initialize variables only when required to be (Christian)
>>>>    move variable declarations to the beginning of function (Christian)
>>>>
>>>> Signed-off-by: Sathishkumar S<sathishkumar.sundararaju@amd.com>
>>> Acked-by: Alex Deucher<alexander.deucher@amd.com>
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++++-----
>>>>    1 file changed, 36 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index 081bd28e2443..d4ccbe7c78d6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -595,11 +595,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>           struct drm_amdgpu_info *info = data;
>>>>           struct amdgpu_mode_info *minfo = &adev->mode_info;
>>>>           void __user *out = (void __user *)(uintptr_t)info->return_pointer;
>>>> +       struct amdgpu_fpriv *fpriv;
>>>> +       struct amdgpu_ip_block *ip_block;
>>>> +       enum amd_ip_block_type type;
>>>> +       struct amdgpu_xcp *xcp;
>>>> +       uint32_t count, inst_mask;
>>>>           uint32_t size = info->return_size;
>>>>           struct drm_crtc *crtc;
>>>>           uint32_t ui32 = 0;
>>>>           uint64_t ui64 = 0;
>>>> -       int i, found;
>>>> +       int i, found, ret;
>>>>           int ui32_size = sizeof(ui32);
>>>>
>>>>           if (!info->return_size || !info->return_pointer)
>>>> @@ -627,7 +632,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>                   return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
>>>>           case AMDGPU_INFO_HW_IP_INFO: {
>>>>                   struct drm_amdgpu_info_hw_ip ip = {};
>>>> -               int ret;
>>>>
>>>>                   ret = amdgpu_hw_ip_info(adev, info, &ip);
>>>>                   if (ret)
>>>> @@ -637,15 +641,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>                   return ret ? -EFAULT : 0;
>>>>           }
>>>>           case AMDGPU_INFO_HW_IP_COUNT: {
>>>> -               enum amd_ip_block_type type;
>>>> -               struct amdgpu_ip_block *ip_block = NULL;
>>>> -               uint32_t count = 0;
>>>> -
>>>> +               fpriv = (struct amdgpu_fpriv *) filp->driver_priv;
>>>>                   type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
>>>>                   ip_block = amdgpu_device_ip_get_ip_block(adev, type);
>>>> +
>>>>                   if (!ip_block || !ip_block->status.valid)
>>>>                           return -EINVAL;
>>>>
>>>> +               if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
>>>> +                       fpriv->xcp_id >= 0 && fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
>>>> +                       xcp = &adev->xcp_mgr->xcp[fpriv->xcp_id];
>>>> +                       switch (type) {
>>>> +                       case AMD_IP_BLOCK_TYPE_GFX:
>>>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
>>>> +                               count = hweight32(inst_mask);
>>>> +                               break;
>>>> +                       case AMD_IP_BLOCK_TYPE_SDMA:
>>>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &inst_mask);
>>>> +                               count = hweight32(inst_mask);
>>>> +                               break;
>>>> +                       case AMD_IP_BLOCK_TYPE_JPEG:
>>>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
>>>> +                               count = hweight32(inst_mask) * adev->jpeg.num_jpeg_rings;
>>>> +                               break;
>>>> +                       case AMD_IP_BLOCK_TYPE_VCN:
>>>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
>>>> +                               count = hweight32(inst_mask);
>>>> +                               break;
>>>> +                       default:
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +                       if (ret)
>>>> +                               return ret;
>>>> +                       return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>>>> +               }
>>>> +
>>>>                   switch (type) {
>>>>                   case AMD_IP_BLOCK_TYPE_GFX:
>>>>                   case AMD_IP_BLOCK_TYPE_VCE:
>>>> @@ -678,7 +708,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>                   return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>>>           case AMDGPU_INFO_FW_VERSION: {
>>>>                   struct drm_amdgpu_info_firmware fw_info;
>>>> -               int ret;
>>>>
>>>>                   /* We only support one instance of each IP block right now. */
>>>>                   if (info->query_fw.ip_instance != 0)
>>>> @@ -823,7 +852,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>                   struct drm_amdgpu_info_device *dev_info;
>>>>                   uint64_t vm_size;
>>>>                   uint32_t pcie_gen_mask;
>>>> -               int ret;
>>>>
>>>>                   dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
>>>>                   if (!dev_info)
>>>> --
>>>> 2.25.1
>>>>
--------------sLJl1qEjSzFnB18npMiU2hAu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <p class="MsoPlainText">Hi Alex,</p>
    <p class="MsoPlainText">My apology, I was under the impression that
      RB is a must. I understand now that ACK is good, checked with Leo
      after your response. Thank you.</p>
    <p class="MsoPlainText"><br>
    </p>
    <p class="MsoPlainText">Regards,</p>
    <p class="MsoPlainText">Sathish</p>
    <p class="MsoPlainText"><br>
    </p>
    <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
</style>
<![endif]--></p>
    <div class="moz-cite-prefix">On 10/3/2023 10:01 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_MM-_zR6_nDdfejpoC=m0Xv4eM5ZQkoVZH6qnChfcaWCA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Oct 3, 2023 at 12:22 PM Sundararaju, Sathishkumar
<a class="moz-txt-link-rfc2396E" href="mailto:sasundar@amd.com">&lt;sasundar@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Hi ,

Kind request to help review the change. Thank you.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I acked this change back when you sent it out, but if it didn't come
through for some reason:
Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,

Sathish

On 9/21/2023 8:17 PM, Alex Deucher wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Thu, Sep 21, 2023 at 9:07 AM Sathishkumar S
<a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com">&lt;sathishkumar.sundararaju@amd.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">fix wrong ip count INFO on spatial partitions. update the query
to return the instance count corresponding to the partition id.

v2:
  initialize variables only when required to be (Christian)
  move variable declarations to the beginning of function (Christian)

Signed-off-by: Sathishkumar S <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">---
  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++++-----
  1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 081bd28e2443..d4ccbe7c78d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -595,11 +595,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
         struct drm_amdgpu_info *info = data;
         struct amdgpu_mode_info *minfo = &amp;adev-&gt;mode_info;
         void __user *out = (void __user *)(uintptr_t)info-&gt;return_pointer;
+       struct amdgpu_fpriv *fpriv;
+       struct amdgpu_ip_block *ip_block;
+       enum amd_ip_block_type type;
+       struct amdgpu_xcp *xcp;
+       uint32_t count, inst_mask;
         uint32_t size = info-&gt;return_size;
         struct drm_crtc *crtc;
         uint32_t ui32 = 0;
         uint64_t ui64 = 0;
-       int i, found;
+       int i, found, ret;
         int ui32_size = sizeof(ui32);

         if (!info-&gt;return_size || !info-&gt;return_pointer)
@@ -627,7 +632,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
                 return copy_to_user(out, &amp;ui32, min(size, 4u)) ? -EFAULT : 0;
         case AMDGPU_INFO_HW_IP_INFO: {
                 struct drm_amdgpu_info_hw_ip ip = {};
-               int ret;

                 ret = amdgpu_hw_ip_info(adev, info, &amp;ip);
                 if (ret)
@@ -637,15 +641,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
                 return ret ? -EFAULT : 0;
         }
         case AMDGPU_INFO_HW_IP_COUNT: {
-               enum amd_ip_block_type type;
-               struct amdgpu_ip_block *ip_block = NULL;
-               uint32_t count = 0;
-
+               fpriv = (struct amdgpu_fpriv *) filp-&gt;driver_priv;
                 type = amdgpu_ip_get_block_type(adev, info-&gt;query_hw_ip.type);
                 ip_block = amdgpu_device_ip_get_ip_block(adev, type);
+
                 if (!ip_block || !ip_block-&gt;status.valid)
                         return -EINVAL;

+               if (adev-&gt;xcp_mgr &amp;&amp; adev-&gt;xcp_mgr-&gt;num_xcps &gt; 0 &amp;&amp;
+                       fpriv-&gt;xcp_id &gt;= 0 &amp;&amp; fpriv-&gt;xcp_id &lt; adev-&gt;xcp_mgr-&gt;num_xcps) {
+                       xcp = &amp;adev-&gt;xcp_mgr-&gt;xcp[fpriv-&gt;xcp_id];
+                       switch (type) {
+                       case AMD_IP_BLOCK_TYPE_GFX:
+                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &amp;inst_mask);
+                               count = hweight32(inst_mask);
+                               break;
+                       case AMD_IP_BLOCK_TYPE_SDMA:
+                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &amp;inst_mask);
+                               count = hweight32(inst_mask);
+                               break;
+                       case AMD_IP_BLOCK_TYPE_JPEG:
+                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &amp;inst_mask);
+                               count = hweight32(inst_mask) * adev-&gt;jpeg.num_jpeg_rings;
+                               break;
+                       case AMD_IP_BLOCK_TYPE_VCN:
+                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &amp;inst_mask);
+                               count = hweight32(inst_mask);
+                               break;
+                       default:
+                               return -EINVAL;
+                       }
+                       if (ret)
+                               return ret;
+                       return copy_to_user(out, &amp;count, min(size, 4u)) ? -EFAULT : 0;
+               }
+
                 switch (type) {
                 case AMD_IP_BLOCK_TYPE_GFX:
                 case AMD_IP_BLOCK_TYPE_VCE:
@@ -678,7 +708,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
                 return copy_to_user(out, &amp;ui64, min(size, 8u)) ? -EFAULT : 0;
         case AMDGPU_INFO_FW_VERSION: {
                 struct drm_amdgpu_info_firmware fw_info;
-               int ret;

                 /* We only support one instance of each IP block right now. */
                 if (info-&gt;query_fw.ip_instance != 0)
@@ -823,7 +852,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
                 struct drm_amdgpu_info_device *dev_info;
                 uint64_t vm_size;
                 uint32_t pcie_gen_mask;
-               int ret;

                 dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
                 if (!dev_info)
--
2.25.1

</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------sLJl1qEjSzFnB18npMiU2hAu--
