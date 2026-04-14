Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B10F9D0D0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 13:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B18710E204;
	Tue, 14 Apr 2026 13:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w8kaF9rW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4628310E204
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 13:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQKp+qAT68Gn/kMK2J65AccDfYHezTmg3HzlmogkCyBt1kCiueILh+aJ/NcTJS126rUqwNQetWqcrjJSgsfMgOGENZ+sxsARz6woFaFsbKX2n0eNPH7kXUtc/CZ0kwhxzaMHnPOe6i6dyw2jgzi8d1MCuX5cHHViNs2o2r4Fs5JNiKZMSLxCw518qcw/rsMmxTRV6ke0NLA0IguPQwmiKqwK2HUQEn/LAEwGDSjviP/jy30lgj9Nw5KE41HLD2Hn1jo2hw1x5BXyNvB6JyVJLQm2g4scQl5zL/P3SWvEDvZIlyRHlevnSFPq3V+QXtWrFfwpU6FfR5bvxBV8fZtElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnZxJrc49f+gtnc9eegFtRx/S+08iq7Ob5V/bELwJko=;
 b=PJojZW9xJvxwdXs6gTmqjIikdGsvJ0DTRgqH0bVJ6yy3DpI8fJja8rjPbuDLnc8b83sniZC00AyP1OPhoOMp/iaoKo5SalrNMISmUkI9G/QcaEamizBeo6KXsz6usGh+gCm8PHr2IVtkoLrX9QTnxwwiU8clAJw1gWbaMf0yiKVfA/YrYYEzc+UKOq/ySCF47GNrqPFgFGUAJTNsTN665ypMb9sbv8bC/Mg5eC0rJ/V9Tqr8URZVX5PkG1eUYADuV1QQZkXM2deeocgwb4YwTcOh3PrOfFBr5F3kmQxRsDl4XamVUJ53lZe8WZ2X0iCYpmiVtS1KZA0v5fbyZlpnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnZxJrc49f+gtnc9eegFtRx/S+08iq7Ob5V/bELwJko=;
 b=w8kaF9rW3MMj3zCPRtN9yohfXCJyowhSsAPE39iCZ4glb9CyZlmPYYiX4aTAqZQACWXvhbxCbap8Z7XArBfDxQWC5Jnm+bw++vks2fSqJTWiRdyhPBKsJOpxJb0ZCQAoycisOj8ETBUnHmb2zk2ZhKtX4vbKhCpHmaYFWxNKeXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 13:51:12 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5%7]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 13:51:12 +0000
Content-Type: multipart/alternative;
 boundary="------------aqXsUk9Ov8S0kprFb0Y7Tfnp"
Message-ID: <9ad4a8a9-7888-4634-aa50-15d22e98dc1d@amd.com>
Date: Tue, 14 Apr 2026 19:21:05 +0530
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
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <3e220f91-a89e-42fa-9186-c9658d41839b@mailbox.org>
X-ClientProxiedBy: PN2PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::28) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ca0f13-395d-4170-f561-08de9a2ce36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: ca3Agehywkhj/CazLBDRaq1WXeed43Ik51wh0DvcBXzuP9MH9e7msfl3msl4phcmUyKxL554jUPqnnz3675p9n5N4QZsASAJbw5/JVCFN14A9wMQDlsP3NK6QyO3ljt1j+huCn2HT6xunWPvnPsRkIgl4BYpQAOxZtx1UHt1bO3+Ginv+vaUD9Tpt8JLuRLYbpyeZoFGDSln84kJdSIH+WHGrN+/Xgb/EPVkMpDP3rRMIrrSgQROBEFsazi9dln7X1XYBhWvZ6Asvnh0BXvT7O+/nJpndzYQ0rv32/7WN7uVPLVp7J7Tyscz3Y0+C3sEZa9oN8rYVi1zV2DAlFVXqEGiq0a72hhJzHMRQIEtDnJ6yOmBcigG1txPAJcMnn8m1OB/7nGB9HnIfUHoBJIkE6yWcZoZfwXyUeNwTAGcSupoIUQFNkSynFdg1A+Tp0F3MjaTuBgdo/C1FcZSwj0o9ahrNWuDo0sp3CLhCtCqmC3qTQc8ByJMpgDvid1OGy3BoaSLMHVkRlcbQpx+78iiv7a9uyq5ikDf+j3SQd3bgr36u2JrB7emgf9Yf02ZVwr0cyWN73QvdbcGvfcb4Gb9ZlQOZ+80+f8NlCArLn9jDFycjUSiBI0JX4eJY0q/WHqzxCJX9xk3V6Jw62+9bkrznkQWAvsYeVt2WpBusaQSlbBlE9MQUATYh6/0BwD7hmF9B3kA2IOHsaFHT3Yr40fhNYq5zk7QSTn8/uz2E9A6Gyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ppNzNIdFBaVDFWL0RCMlI4R20xVkVNSEFmbXJGOG5KT2s2R2ZGVUxwVFI5?=
 =?utf-8?B?ZUozdnpidnBONmFiK25KaU1oaHBaQ2NEdWpScllOaHRIbzVad1FadFpNM2ZH?=
 =?utf-8?B?eGQ2V2tXRE5SZmVzRzVOWDhxMUMrNE5oMlpKNDlZZ1BhK2FhdVlGSmg1M1ha?=
 =?utf-8?B?UmNvTUlsNkdpK0tTVVc2bk8vbW01UzdDczAzcDRVT1hhUzhWeGcrbjFkMHZV?=
 =?utf-8?B?SGh5R1NUc2dnL1MweHJnNWc1ck94eWY3Y0s3a3ovQmZDZ0EySFM5dEprN010?=
 =?utf-8?B?bUlDMnEvK25ONWpEWTJCNDA1TGh2SXdWY1JLK1pqWCtHamxWbm9NeDc1YTAz?=
 =?utf-8?B?ZnR2UkEwdkZTU3V0dWFiNlZvSDIvN3QrRUVqMEhaaFIzNVJYRHJPelV0NEQ4?=
 =?utf-8?B?blgzMWtoL2Fob1hhdG1JL3h5T015djgyV0FrNk1hQnRXWVZLbkl3aTZJNmRL?=
 =?utf-8?B?Ujh4VXU4K0tEMEhVQ2F2RGx1TUk1cDRNenVsQndMNG1laWlRYTVJQmg4NW1j?=
 =?utf-8?B?RC9ybWNKdk5xY1pxSzRIeWNYQmphdnV2Q1RQK1ExRG1Nai9iZW9SdUZVV1JL?=
 =?utf-8?B?ZHROakhDWDJDOUFPQVFqeUVLckY1NU9ab2EvZWN5dVJ2OWRHOWNNZmpaazEx?=
 =?utf-8?B?eFp4Mk5rbEtzRFdjL254TCtXSmhhQW5uZG9rZHBpTyswOEtLNGNhU1BVdmcv?=
 =?utf-8?B?Rkl5c3E0Q3I2VG1nNnh5Q2xoV1lvdHZoUms4UlhtTzFyclV5U3Vnd3YxWVpM?=
 =?utf-8?B?N09mK0tPeEhDdStSMWhUNS9TL3Z3QzFvTEFVU005Y1Z6NlBEbFFLc1g5WW9W?=
 =?utf-8?B?bXFCOFBFSStVeWRCb2RIK0Q4ZjJNYzdxVTQ5UjBVZXAxaUZNN1QzdTVzWnlz?=
 =?utf-8?B?engwSzBSR0tTaFhvaGphRnF4eTc4RDZLV2JmMFE2eUdscDZrSnNVWUlNa3B0?=
 =?utf-8?B?UzJRSGxxRG12eEpvZnhDdWo4RG1ZK1Q4bmtHRlp0NVo3blN3K05jN2RsV1NC?=
 =?utf-8?B?ODFIbTFGRnRnZHA0Q01UeHpJQnRXOTRVQWc5VVFsMnk3VGhKYmtkKzQyVm5S?=
 =?utf-8?B?MG5nQjhxbTh5YXFoSHpYaW5ESUVSbTIrUUF2dzd0T2hOd3BMOEZ1YjBXZThy?=
 =?utf-8?B?RkVEN0x4bnMrVWZ2MFhtODNWZEZLV214eURWYTVGZFFBT3RFUFlTVWJGREpD?=
 =?utf-8?B?bHRCNFVtU0NKOXRwUGdtQ3lhK3pMTFZITGYvM2w3VGQzaUNxK0ZzV1JGWHgz?=
 =?utf-8?B?YnNhU1NGQjA0Y3hxSGRiS0g1N0RWQ2NwVS9Md2FiV1VaQmdaSkwrUGxkN3pL?=
 =?utf-8?B?a0NjcjRNQ3Mvc2V1dVIrN0Q0WlVzaG1WTTNwK05XRVZ2Z2prQjNiTVYxRDdn?=
 =?utf-8?B?NGlsR3dsSWtpYWJvd2pmZkwvY2l5b2tTWlNDTFR0L2NYOENUOVM0ejlOaiti?=
 =?utf-8?B?UVN3ZjVyYlpRaU5JR3RoaCt6ZnBrM3M4MEk4K0gyYzFERFdzNWh4bjRNaVVJ?=
 =?utf-8?B?Z3lSdE1CQnpwTGdpTmhmczVjaTRCWjJKdEhYUHRrQWxTWFdFVzdOdHVjeGU4?=
 =?utf-8?B?SXo3WEdQQWdodzk0N3pqTk8vR2VBcENyMVNTZkxmbnZPWXlMSEZLWXdvK2tz?=
 =?utf-8?B?WWY2M0xaYWp6Wkw4eitIaTRyOGgzTVl2aURjQmR0T2JWQUpieW04QjhsQStz?=
 =?utf-8?B?RkdXelhxek51c2M0Uk9JOXd4aXlBS2ZXcEpReTRjTlZKYjFmMFRPM0x6Nk9q?=
 =?utf-8?B?dm5BU0lkcXQyU1c3Z0dCK1gxNWZ1UzVLQlRxdFhuempmY0RaTE9HRFVRUVc0?=
 =?utf-8?B?WWxwWEVIaStGcGVKNXRSWmNBZjlhRGZranNEK2ZQVUdFajJ6Z1JWQ3pyZ2tB?=
 =?utf-8?B?ZkpwY0dhQkFHcUFkRERLZURPYjg2WnNncHZOT3EvTUE3REd4Y1lDUlJxWDRZ?=
 =?utf-8?B?bHJ5bGZRQUdEYzd6a1VDVnFyUHMrTHVtd05zT0lrVDdHWWYwVWNab3lIZDdN?=
 =?utf-8?B?MnYwd243dnVLTTQ1K21KWWpVdmJPcWpIeDBlUkd6NlhsQlBTbmlxNVFTN0R4?=
 =?utf-8?B?N01ONC9oSm1PdjdaUmtPYytpSFJwVGRTNERCMStSdnZXOGdjeWoxZzlZaGFo?=
 =?utf-8?B?bWVEZWVkOG9RakRDZ3VQd1d6a2dvUG1USDJ3aS9ENWFLNEFZdEFaTHdKdFN0?=
 =?utf-8?B?aFVJUFVMNjYwZEVnQ3VNM3Nna0xXcTYyRWdjeFlYZnFTYkhXdk9YNFYzRXRy?=
 =?utf-8?B?cmpmdXFHMi9GV0ppT3YxRmYwVnJEdWkrYlkwSU93emUyMldWcm9wM0Z4eEVs?=
 =?utf-8?B?NXg5NzFzVHA4L0JqN3V2aFJjVDN2ZkJUamVjaERRbWwvSTBUTURZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ca0f13-395d-4170-f561-08de9a2ce36d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:51:12.1091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXg4RxhoTHLSSZH4ZR13KWqG+ziRm3DVlpl2aExaatsHJgt6DyTUAOCWLphaMS3cmETEOwT4McZPZn7JhOZtAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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

--------------aqXsUk9Ov8S0kprFb0Y7Tfnp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14-04-2026 07:12 pm, Michel Dänzer wrote:
> On 4/13/26 11:24, Khatri, Sunil wrote:
>> On 13-04-2026 02:32 pm, Christian König wrote:
>>> On 4/13/26 10:49, Sunil Khatri wrote:
>>>> In function amdgpu_userq_priority_permit allow till
>>>> maximum priority i.e 3 which is seen for gnome shell.
>>>>
>>>> This is needed to fix the issue of unable to create queue
>>>> for gnome shell.
>>>>
>>>> logs:
>>>> [drm] *ERROR* comm: gnome-shell pid: 2802 client-id:10 client: Unset ... SK: Priority 3
>>> Clear NAK, as far as I can see the existing code is correct.
>>>
>>> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH is only allowed when you have CAP_SYS_NICE, e.g. you are root.
>>>
>>> That is also documented in the UAPI. Question is why is gnome shell trying to use that?
>> I see, let me add Yogesh for his inputs, @yogesh, why gnome shell is asking for priority AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH. Based on the code seems mesa is getting a flag set flags & PIPE_CONTEXT_HIGH_PRIORITY -> this sets AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH for graphics queue.
> For some background, mutter uses EGL_CONTEXT_PRIORITY_HIGH_IMG when EGL_IMG_context_priority is supported, to try and prevent its GPU work from getting starved by clients.
>
> This works (or at least doesn't fail similarly) with kernel queues, presumably via DRM master status. I'd argue that should suffice with user queues as well.
>
Below is the check that we have for userqueues during queue creation, 
and for gnome it did not hit any of the condition and eventually return 
with -EACCES that is wrong. It has to be maste or CAP_SYS_NICE capable.
if(priority<AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
return0;
if(capable(CAP_SYS_NICE))
return0;
if(drm_is_current_master(filp))
return0;
return-EACCES;


regards
Sunil khatri

>
>
--------------aqXsUk9Ov8S0kprFb0Y7Tfnp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 14-04-2026 07:12 pm, Michel Dänzer
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3e220f91-a89e-42fa-9186-c9658d41839b@mailbox.org">
      <pre wrap="" class="moz-quote-pre">On 4/13/26 11:24, Khatri, Sunil wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 13-04-2026 02:32 pm, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 4/13/26 10:49, Sunil Khatri wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">In function amdgpu_userq_priority_permit allow till
maximum priority i.e 3 which is seen for gnome shell.

This is needed to fix the issue of unable to create queue
for gnome shell.

logs:
[drm] *ERROR* comm: gnome-shell pid: 2802 client-id:10 client: Unset ... SK: Priority 3
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">Clear NAK, as far as I can see the existing code is correct.

AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH is only allowed when you have CAP_SYS_NICE, e.g. you are root.

That is also documented in the UAPI. Question is why is gnome shell trying to use that?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">I see, let me add Yogesh for his inputs, @yogesh, why gnome shell is asking for priority&nbsp;AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH. Based on the code seems mesa is getting a flag set flags &amp; PIPE_CONTEXT_HIGH_PRIORITY -&gt; this sets AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH for graphics queue.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
For some background, mutter uses EGL_CONTEXT_PRIORITY_HIGH_IMG when EGL_IMG_context_priority is supported, to try and prevent its GPU work from getting starved by clients.

This works (or at least doesn't fail similarly) with kernel queues, presumably via DRM master status. I'd argue that should suffice with user queues as well.

</pre>
    </blockquote>
    Below is the check that we have for userqueues during queue
    creation, and for gnome it did not hit any of the condition and
    eventually return with -EACCES that is wrong. It has to be maste or
    CAP_SYS_NICE capable.
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #9cdcfe;">priority</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">&lt;</span><span style="color: #cccccc;"> </span><span style="color: #569cd6;">AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH</span><span style="color: #cccccc;">)</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">return</span><span style="color: #cccccc;"> </span><span style="color: #b5cea8;">0</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #dcdcaa;">capable</span><span style="color: #cccccc;">(</span><span style="color: #569cd6;">CAP_SYS_NICE</span><span style="color: #cccccc;">))</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">return</span><span style="color: #cccccc;"> </span><span style="color: #b5cea8;">0</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">if</span><span style="color: #cccccc;"> (</span><span style="color: #dcdcaa;">drm_is_current_master</span><span style="color: #cccccc;">(</span><span style="color: #9cdcfe;">filp</span><span style="color: #cccccc;">))</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">return</span><span style="color: #cccccc;"> </span><span style="color: #b5cea8;">0</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #c586c0;">return</span><span style="color: #cccccc;"> </span><span style="color: #d4d4d4;">-</span><span style="color: #569cd6;">EACCES</span><span style="color: #cccccc;">;</span></div></div>
    <p><br>
    </p>
    <p>regards<br>
      Sunil khatri</p>
    <blockquote type="cite" cite="mid:3e220f91-a89e-42fa-9186-c9658d41839b@mailbox.org">
      <pre wrap="" class="moz-quote-pre">


</pre>
    </blockquote>
  </body>
</html>

--------------aqXsUk9Ov8S0kprFb0Y7Tfnp--
