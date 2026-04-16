Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F7FF8A14A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 08:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B0110E861;
	Thu, 16 Apr 2026 08:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yFRPlaqd";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5314610E86B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 08:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiyc0kus564LAzxtcpPfVA0T5i03K0YlbH7NcGtR39Sqp1eSf2zCLRrftZfKgsK+qbRsVRSb8Gg/SY+EGbTnyjSE3iggs5OM1aqES2ATnD2uthE1rlnIeuDnccn3G7KKGU7DYWnf5QLdxFi3ALeAqrw2XsO5HgpwHLWJQjnKe3gvEU9PLWFSa80vSLB8Ol+91F7pxMLlNPBGNWL5c6R8RCg4Uwc3if/k5zqCncg0mjNCqDIVfQrXPSBsSowiY6e7kca4iZTKwk0ompwmwo39D9y+PSJQHtTXgoQ3wYW2BEbrfz6I1S8Lhg/14jQh8F/zPajylfXvUj+t513xm0kTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieRh2dk0GIZ3c40Ff3E12lNjGH1ZS88S3stZxlTKBP4=;
 b=SAGfVsdB0QapCRdvOd6vw9U6ojWQoFLaMNDSLAqfQnJbBgkFlChy+e8CAtH2RyvCklqTBZA5AQzlfUCk3coUKgY9d+ZdTzKaoX/vJPqnyIzH+CvfuF2C8Ck3heMJ34VCuxnyFpXJcw9Qoj8aYlS+2p2UoZ7wTDHbVDHGZA9GvjZg4CC+vJys8ONiQwJtngHxGN99Rib9HThn6oiLkLl7mT5nJcRXlZR4CT6Af0RrbJ+4PBeKTlBfufVwcifHKocYgPl/Rmwp18FZwJ31uXunTnGk9tqZ40iwhHgvgaH/9+Zp9mB62nyemmbDdQDx16P2ooAZEyOu1KuZOWqFmwDxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieRh2dk0GIZ3c40Ff3E12lNjGH1ZS88S3stZxlTKBP4=;
 b=yFRPlaqdbhlfgT5BrcfAM3nDYRjVIqIE8K0EWf65tMaoAttbGjAdpmMPRWR1aE69jwYTaMFrX1xdMbv+WE8i/BIU9KS6rKX4U0UE6GReknFYHsG4dUaI622khRMONmWFR0m0hpzpVO+Qxnc+GC300u015+ZV8vod6e2DWI20ST0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 08:49:56 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5%7]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 08:49:55 +0000
Message-ID: <7a264972-aa82-4e7b-9780-7cbf6359d04a@amd.com>
Date: Thu, 16 Apr 2026 14:19:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: gnome shell uses max priority
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>,
 "Mohan Marimuthu, Yogesh" <yogesh.mohanmarimuthu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413084943.819126-1-sunil.khatri@amd.com>
 <5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com>
 <4e862955-3437-40f4-bf04-2bdab7d84909@amd.com>
 <3e220f91-a89e-42fa-9186-c9658d41839b@mailbox.org>
 <9ad4a8a9-7888-4634-aa50-15d22e98dc1d@amd.com>
 <1cd26979-9b60-48cb-a0fa-308769245e38@mailbox.org>
 <acaac7c3-178b-480c-b11f-3731bd215282@mailbox.org>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <acaac7c3-178b-480c-b11f-3731bd215282@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::7) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfaae54-96f8-4d91-73a1-08de9b9521bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: PzKeLbBnga/0JxGbb7AsCo2LlKmK57vARY8FzzlA6McIbhVsSR8tBbgA2WCXODbVvWUwZ/ZhwPHPqxlfK3cTVn9ruq1Pohjqdfuwb2prUkRMtokL8vp8FyfZoGUA+h9Cz6fAb0FNcX9E2BHgM0J5H50H91xlzaecsXE25dihS7JTX1haBl5HcpfVmHHU/1gPGjlkHhJMAjdnVU6yKbXlfy5UmlhErIDrFUpnS13ijMtwLFtLbzgsuTTBty2hPkf4TCFdiWYRort9Beqg4iYNElwsVuxjYYw5kXCdmJcIg9wcYX/ss68wBJwz7cgjvo2/SJkqGpxgIQ6q2K9LAV8A31ogoggQDpQq+CHF4jJa/Knc5BP6/z3mPh3ZoEwZRaTEEHnBgTPsXaYyazY1dCZQ1En3nKGnT1V52EuU5pA1cNjiKCfzfeuIXI0CwRZEk0qchrBpxaU9pj7a0A/KKBKZcdaAEDPE9ib1owYWOI3b8cJxNgBFXdxLB/o0EtquPeVFh+npd6/AIKruF67og+g9U1PtbQ7lQl9sZim4hqp+n07SugfWEC5TV+dIUNxLafYioLORlpzKx5kjOn/7Jnf1pyUMHWbChczf2WpBHnWLhaQBR6PtSgZAy+G3M5TvVFXMYvHBlt4xO9NK/ScSsYj9shEruHttU9BhSAJwv48Fcn/ATWtE36YRR2Rh/3mC8BRQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1GY1VrMGsrWGdZSHoxVllnMXp4QXdKczZZa2orN0NZTEJDeHlUNDJ3Q1BO?=
 =?utf-8?B?bHhCaGtBbDhndU9ZSno1U1FrdmYwaG1qZ2NSR3pWV0lLWGh5anRCc1ZnSzVQ?=
 =?utf-8?B?ZHl4a2Y4SEN3NCt0cy9DMkJjSVN6Vis1djA3NXMxeHNIM3ZDaUFkazZ1TlY4?=
 =?utf-8?B?ck03cUxGSUJYQ2xSWkdQMXR0UURLOUZYS3lFMnNSS21oR1F3S3ZzSWJ6UGla?=
 =?utf-8?B?YjVUd29JQmtnVGpSWG82YlNuQlA2aFhSUnRQSmxpYUZUVVppYVAyQ1RRS01o?=
 =?utf-8?B?S1NJbjE3WVhLbEIwWUFZMlE2WU42QUJLWEpKMXZ4U2x1akFGbGVwTEE5VGlV?=
 =?utf-8?B?cGR0TE1NcHVaaVVEc1BmSHdFb21XRUttcmtmN2I0WCt5bkUyR01SdjNoczEz?=
 =?utf-8?B?R3JpMnRRaUljcktsSmJqdkhwc0MvM2JQcm1TOVM2eGZvaEpCSUhBT21weUhO?=
 =?utf-8?B?Rm1ZNHhuOS9MOWR6MTJhL1lpdzFaMDRLbVdyZHRzUi9aN2kydWhSV2NNV0Zp?=
 =?utf-8?B?MXRHNlhkZnh6MHFEeUtBM1pzTDBJR0MxSXkrMWxRak1GQWVpRytQM0dnaEFW?=
 =?utf-8?B?ektMZW5yZWE5ZCtkdDRZR1ZEbGp6SXpodTRncW1JWEZMSEhuRkxVcDJVVnlS?=
 =?utf-8?B?T2NVVWprTG9oVnZxRG14aXErZmovMWZjMVphNGI4L203TUdNSkJ3U05RS3cr?=
 =?utf-8?B?RSt0RFdxL1VuQmNIWGVmU3NpSVBJY0JCdCt2Z3luNjRtL3k0TytRaSs1MkZL?=
 =?utf-8?B?RUY4ZW5mcFZSbWxJSDBkbjQ4ZmNXemJ1c1VBRkdzV3NmVnNaTVFQeEw1MkNp?=
 =?utf-8?B?VXdWYjkvdFlGVlVHTFhCTnZweWlXRHEvNjBYRXVIczY0dzFndEQ4cGU1MDdz?=
 =?utf-8?B?RGFYZ2NoQ0lmblN2OUlxSjJ5QUxjeDVrZ3Y0UnNBOWZnZjhNL29KZFNKM25n?=
 =?utf-8?B?NjYvMWdLYTFCN1B5UWttdHpQRGRkQ3VOYkJmZXViZ3FpS2JIb0p4aVRTL3VZ?=
 =?utf-8?B?a2dLVGRMTGx2eU5wUTBxNThYTFBMNDJxM1JmckNCTzI1eEdQQnJaKzEyZEVo?=
 =?utf-8?B?RnRRQTNISDRJNzlwR0tMQ3ljdHJuQ1g0QmdsYm5obW1JeXhkMDBIdGZKNUs2?=
 =?utf-8?B?SEdOL2lLSjJsYzdudTA4TDVFUTJDWTFCN1NUdmd3VE03RnFnbEtVaEkyUURr?=
 =?utf-8?B?VHRsTHhjK3pVMTVXMHFrVk9JZ3hEbm1SZVNkVjdjQVloL0ZvSjhwcE9sMktB?=
 =?utf-8?B?dkRlWjNHVVJMdENWeC9jNjl2OGk5Z0JJek5Cb09MZmdZbGFGTmxXQmRVdkNn?=
 =?utf-8?B?Mm9YZHZwNVpCb1JxUmozMFg3UUdJTHB4Q0JBNlJVUnFQRG8vNXBaUUYrdnJ4?=
 =?utf-8?B?Slh4RHdDa0JoRXRwdUdMNnlvS3JjbmM0M1dvbnBCM0Y4UE5yQWRWemIrUUtG?=
 =?utf-8?B?emgxZERaeFFwU0hqdnYzVWN4V0VJN0VuV0pENFBEY3NTNnBHTFQwckRxcEhT?=
 =?utf-8?B?L2NNQktkYitJY0NhbVQwbjFtTmpRWktCckVqblhocnQzbTVWQXlnTzFkVy96?=
 =?utf-8?B?Yld0QSs2MlhnUytSdUo1bEl2QWVuNjZVRElFdk1MTW13cnZiL3dmbU0vSk9L?=
 =?utf-8?B?VEZxWUh5V2FaUWNmK3VhcHNtUXlENjFLbVJxS01IdnR4dC9rbDkrWUtkTnlu?=
 =?utf-8?B?KzhHNThwMWtlZUlsOVpTK3VKbkF3MTAzN2RKMUpzczFYKzYrVTFUV0NRTjQw?=
 =?utf-8?B?cm1qQVNkUTdjSlJXRHcvSGJoMjBjbEtOL3lyZFI0alh5bURTYVN4WnJEY2Vh?=
 =?utf-8?B?ZGtWUkdFYk9kL0VSL3VvcWtaMTZPRFVZbXl4SXF4Y01VcmQyakcrWTllRU5C?=
 =?utf-8?B?RkVFSlZxeExTWGVrZHp3alR4TTgyU3lZUDJUUEZKZjQ1UGpheDRlTHVVY1U1?=
 =?utf-8?B?Kzd2eG1lQ1R2YzBqTzNUWk5JTndtMTcvbFo1SHdtV0VvU2RYVFpNOUpTNTRV?=
 =?utf-8?B?RGcybm8yTWsxM3V4a0JWb3Nrbks1SXM0QjM0ZW5jV2hOZXZKQ05sZk1EM3FR?=
 =?utf-8?B?TkFUVnVEUk1LanM2N3VFL214QmRPRm1IWWY1MXRFd2cyb1lmblg4NWZ4N3F0?=
 =?utf-8?B?NXpRTk5xNkFvZjIvWFd3NDl5Rzc0NHhucnlKb2IzRlBpUUNuZWJ4eG9IK1Yw?=
 =?utf-8?B?OVZyNUFURHo0UHFqWDBaUHlxY3JqNU1TenR0YnlkMFhqenRTSUwybGdobElh?=
 =?utf-8?B?ZnFBQ3dmMjBtOTZ3ZHdOaVVlWHJMRDJrUCtJREExMnBobFJPdEhRR1RORHdj?=
 =?utf-8?B?RjJ0Y3lzanFpSTAvbSszNHEzaUJ4RUxtaWhMR1NCbjFxUVg1aVEvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfaae54-96f8-4d91-73a1-08de9b9521bc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 08:49:55.6778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhQ6JuxD9psvE/gZwTMiz9kZWN1m+wokOpX2DNeu1PwN07mqah2Ogzvjp0mCtNp658DXWrNojDsu0xA1CAmrGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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

Seems to work. Not seeing the queue creation failures anymore after i 
used the change.

Regards
Sunil khatri

On 15-04-2026 02:40 pm, Michel Dänzer wrote:
> On 4/14/26 16:50, Michel Dänzer wrote:
>> On 4/14/26 15:51, Khatri, Sunil wrote:
>>> On 14-04-2026 07:12 pm, Michel Dänzer wrote:
>>>> On 4/13/26 11:24, Khatri, Sunil wrote:
>>>>> On 13-04-2026 02:32 pm, Christian König wrote:
>>>>>> On 4/13/26 10:49, Sunil Khatri wrote:
>>>>>>> In function amdgpu_userq_priority_permit allow till
>>>>>>> maximum priority i.e 3 which is seen for gnome shell.
>>>>>>>
>>>>>>> This is needed to fix the issue of unable to create queue
>>>>>>> for gnome shell.
>>>>>>>
>>>>>>> logs:
>>>>>>> [drm] *ERROR* comm: gnome-shell pid: 2802 client-id:10 client: Unset ... SK: Priority 3
>>>>>> Clear NAK, as far as I can see the existing code is correct.
>>>>>>
>>>>>> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH is only allowed when you have CAP_SYS_NICE, e.g. you are root.
>>>>>>
>>>>>> That is also documented in the UAPI. Question is why is gnome shell trying to use that?
>>>>> I see, let me add Yogesh for his inputs, @yogesh, why gnome shell is asking for priority AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH. Based on the code seems mesa is getting a flag set flags & PIPE_CONTEXT_HIGH_PRIORITY -> this sets AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH for graphics queue.
>>>> For some background, mutter uses EGL_CONTEXT_PRIORITY_HIGH_IMG when EGL_IMG_context_priority is supported, to try and prevent its GPU work from getting starved by clients.
>>>>
>>>> This works (or at least doesn't fail similarly) with kernel queues, presumably via DRM master status. I'd argue that should suffice with user queues as well.
>>>>
>>> Below is the check that we have for userqueues during queue creation, and for gnome it did not hit any of the condition and eventually return with -EACCES that is wrong. It has to be maste or CAP_SYS_NICE capable.
>>> if(priority<AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
>>>                  return0;
>>>          if(capable(CAP_SYS_NICE))
>>>                  return0;
>>>          if(drm_is_current_master(filp))
>>>                  return0;
>>>          return-EACCES;
>> Indeed, looks like at least in some cases mutter creates the EGL context before it has DRM master status. I'll look into fixing this in mutter.
> I realized what I'm seeing is a regression from https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40519 , since a render node file description can't have DRM master status.
>
> I created https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40974 to fix that.
>
