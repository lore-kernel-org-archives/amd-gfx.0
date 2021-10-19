Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 07:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE976136F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 07:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4BE976136F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1E66EB3B;
	Tue, 19 Oct 2021 07:43:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD486EB3B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 07:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhw42YvG7Whk6i2SMk937GEYtbH9nTGPEN+nDtU5UJHSxPnFQZ9XY+60gDyWSDorO6AU+2Sv4i/5RYB5cBD3GrAMzLblmB8lAxt4YtLAo7H/dhvW4SyJweBuNH1LIW3zdciW0J/pvYbg0PS7kaA7oume9nx2njSD9PRVS0f83m6O4gmHk7qJuaK6SYuFRo4hkSb5N6ZsjXnlY4Yuus8GLUejGMV3hjBeGStbiIR442TXbRaSeuWwzGxHYcEIoYtb/oudT2QqWaB45F8SdJ7aWPRZMnFXPKetpR0t6oHWp9mYRFgkQa0Ssz6/xzt6o5Sn+VpWPsb+FFwUhrCMyaVcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h36stZM+JZu9kCJ6Qz66jfUCbOzoHO3jea3xwM7wa+U=;
 b=hNODUJzKogDaFa8Ndp8NnD0ho+E3RAUtWAXZ4v+JLZgzWFY1wbOmW72MoJiB9icnyath3he4rl1WlliLvjiUEcQ1qY5TF1vEh1hICfb3hGjmJrs0hlpSCBjLxOz7E8HNA8UoJjXsNoQZnnkrkofJIMmY/YU15wcFPvws5M8f3DLfAFmQ0GvSALPzZE/jFaNaKueqeGx6Gygyk8TAYaYD34NpIBrDskQEgP7GmViG0wgR6WElQzpqUL0GluFODAnH7co+mEBkRideg9dI+ctmoFdUv1wuMqRil4onylsya32KnHBEZWuVApVIWiwgAYvOqDenopiqRNvi1bq0m6uUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h36stZM+JZu9kCJ6Qz66jfUCbOzoHO3jea3xwM7wa+U=;
 b=sQvoTg16U8ZH4YuOjSNQ/Hg00fFDxRWF4FIWUR7UM3BayrEo5IiRGu2jaKVyg6nSd30zBgyBnmrzMV2JjI/QDyUB1jgv+hBBpeUTY+vGNt/SE+CmFOSi3LmnKZaebx2LvfOmd0+o1b1vw+qnfxIbl59S9smRhKRSTfUC2jyZSI8=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 07:43:55 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:43:55 +0000
Message-ID: <6ce5dbce-fe8e-3535-d9c3-1a45e0fcb7f0@amd.com>
Date: Tue, 19 Oct 2021 03:43:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 0/5] Remove 0 MHz as a valid current frequency (v4)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
 <a653a699-69a9-9671-4bfd-e02f3d22fc2f@molgen.mpg.de>
Content-Language: en-CA
In-Reply-To: <a653a699-69a9-9671-4bfd-e02f3d22fc2f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18 via Frontend Transport; Tue, 19 Oct 2021 07:43:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 645aa1e9-1e2b-46ad-c194-08d992d433c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29886A579275F04C51B60BB799BD9@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w737YaZlIUMiU1KwotXiR6Bp2J1/UO0kNvAT/Oa4uYoPE/E8VTjhNBiW9Vt/vlgoRrF/1hi7RChBGAIkrNPiVuBZ+DgcoJgLQ3tO5FyuDxUPP27hDRf3AO3Nupxe4sw/kPRJUDyM3iYAfmWDb4z+r7qE6qvMATOX5EfyKNIPsnQRCAjckz1PAYMbaSFLJnDY+Q1iFWo4L1yv5ThZ+7fByjdgUaP8YG61ipOOCXvZX+0mDR+woDp2HecJxEiu/1LQgzJOV5cSJNnJT+neBVHaB9C6Snt7FZCZlJJElg6/21WE6LjHghIqYH6Go2FHZgXgVVe/mzUt6k3vR6N+aFCG3v2m1xGaaFUjgVFNzItzRednR40dKMQOUepTHzNqLr+Dy4/g/wfNBMJWDTlY9gV5IkIvsY0VJKAZY3pxP8mrwDGJxY7azoIlQ1jb5xRKhKjvZu+kQLSwSsy00DXM5dRUnPBqtxDDDrmew6eD4lMjshYuWmEUJ9pxZIj1KX6wIEAp+z854z+8lFwsDZeWX6oTkLbptQgtNmHcRdZlElRdFBd8iwAy7h5avPNnF2iOQZBnDTT+yH4Xk3zKkFPHvVmuKsw79UkI13kzgm99ZqdEBeyAcPFAm/iGYjusyoXERLifsQz9vEXYGCwuuk5Xm0iJDc+l0Rubn4P4N8bHR+ly0dcKdIRF3UBU1j6L+1nONpS2UXWUqr35SnsWLXqnZPAwqjmX4pl3+tFsRv3fDDbD8hDOe3KgzKUvgqDeJRtiu0Sf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(38100700002)(8936002)(54906003)(36756003)(186003)(26005)(2906002)(4001150100001)(6916009)(44832011)(86362001)(83380400001)(4744005)(956004)(4326008)(6486002)(66556008)(31686004)(316002)(16576012)(31696002)(66476007)(508600001)(5660300002)(2616005)(53546011)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NElUQkF4cXVScldPSDV6clhuZkUyTit1Q1Z2RG12UEFDL1grODhEVk5vd0Jy?=
 =?utf-8?B?SmJ5cG1PaTJ5eWVWNUxybjNKd0xNcGpIanlhV3V5Z0xYNmM5VG5JKzdBQ3ls?=
 =?utf-8?B?aFVpdWZZZHdYbk8wV25mMjdtTTJWeTVmWEMzbkV6alRsd2Jjb0RCMmF3TXRR?=
 =?utf-8?B?RElaUjN3UW12aFk5czhYNjVJQnpyR3JvZVRuZ3M4eFFtTmNZT1NLUmM1TVZu?=
 =?utf-8?B?Q2JzZDZSbHVsOHRnVm9BN1ZtaHhyLzUzL3hoQmlWR3QyUkRac2Ftano5T1JW?=
 =?utf-8?B?d3RZdHAwam5GTGU4SXFqcFhSQjQxMEJrNjNlcm00aFlhTFVHaG85SnNaTDQy?=
 =?utf-8?B?dVUxYXZwWGYzbnhIUjcyQmR0SUIyZ3MvR3VVMUlYdFlnL0RSdDZFR21xWUtM?=
 =?utf-8?B?ZUZubFpDRGdFK1NxUnlhQzFoS3FycWlma21jeVRySFFCcDZLMmJGR3drK1N0?=
 =?utf-8?B?eU5OUFJxWlJPMVRxcFNyK0NxSXgrdFY1OEVaT1BGRGpMaHF3dGlmMm0vZG1S?=
 =?utf-8?B?MFFnUXdRSlA4c3hQU2t3bTh5M2M3M0JONmZRMW1kZXhFSjBtRlF4UXFpZSti?=
 =?utf-8?B?RFBXSFI5VWx5RmllU3NjMnZTMlc4S1pEZDg4UmcrOGI5U0tzQ0VnZkJmOXZD?=
 =?utf-8?B?NVNiZ1BwR3ZVQ1Q4N21MTWhBVk9UWnc2TkNOb29BeFMvV0xTcHNXYWIyb1Rh?=
 =?utf-8?B?M3V2UGZkRkpBUzdOWUtZb203WDBzM3JpK0RMSVZramFTemJJYUF6SXExOHdv?=
 =?utf-8?B?WWs4UXBlZmsydFVHbGIreWErS1llV0hKOEVtaEd3OW1jZzBLNzNQVWdvdFY1?=
 =?utf-8?B?dW9FcEdBVzNLTmdHcEFzMElGcjVSZkx0bG43alZFeGNmbjFra3JtMU1HcG9B?=
 =?utf-8?B?emE5b0FlYTU2SmNwSzZrQnd2cTJpeW5CTzU4WUJ6NnhxTC9JN2liQzhGbWto?=
 =?utf-8?B?cWdVRWc1cUJ1OE1HWFFuOWh4N0JMN1Z5V3JBNjRDd2tPeWxCMUJOMlJ0bE5v?=
 =?utf-8?B?K3F5UGEzVGVJTWZMV1BGZWJQeWYxTXl3dmVZR2p5TkY3dDQ5QnI1ZmoyeDAx?=
 =?utf-8?B?bEptN1JVL0pkU1d5bFF5WGNaWEQza0RqYW5tYXBVQ0Y0T3VaK3AvUWp5OXor?=
 =?utf-8?B?OGU2M2hRTDlNS3JCallTU29MdXVkQXNJeWliZjE1bFE3VUp5aEJJeFcrcncy?=
 =?utf-8?B?V25WRmhKQnZoYUF4VDdkMW5ScnhFejh2VktSSExVL3ZvZFAydDhqM2ZuMkVU?=
 =?utf-8?B?QVo1MVBaMGY5YTI5Sll2Q0pMOFFVbCt3dG1paktaSkFoZWwwZnNZWC80eXRo?=
 =?utf-8?B?Q2FZYmo5V2Zrc3lJNENWaW1tL0J3U0Zva1NaMUc5TmJRdDF0UmlvbHh1Tm54?=
 =?utf-8?B?WkxQcU5mRjNEL2ZXNUo3VmtQZ2lvL2ZEdG1SQnpMN2xTay9zQTVzZmEzRzN6?=
 =?utf-8?B?VnQ0WEo0aXR0am5EUFZqTVRpSWlSaERKZDkyZlpRU0Jkb25sRFAxYTczbzlP?=
 =?utf-8?B?b2kwOS9QSHZQUkUycS9XUVp4eEFVRE9jTkFmbklkK0JZOUpiYmczQ2FXOGFN?=
 =?utf-8?B?bWhtQ0RXUGM1djBGbjViY3VvOHNVNmQ0cXNrRzNKOFdQdGdNYWtxVnVQRTNq?=
 =?utf-8?B?S0NpM0NPOXc2M1dpeXdvMHk3c0xjbkVwYVJSOVphaUFFZVlzTGxMelJSY1RC?=
 =?utf-8?B?cWdwTS9hbHkvTU9HOVZWaThNd0J3ajE1QlJ5Wk93bGpmQXFBY21udEJJclBL?=
 =?utf-8?Q?JqSEm7qzmnvNE4Fj5rhXFXCkPqGKS4o55yDzLOT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645aa1e9-1e2b-46ad-c194-08d992d433c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 07:43:55.1182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpHpbycI7Z19HTXe9sUu+ERt1wa0PRDf49MRpRcvABXhtlqcxi5ffvRDrUyV1pK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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

On 2021-10-19 03:23, Paul Menzel wrote:
> Dear Luben,
>
>
> Sorry, two more style nits.
>
> 1.  Could you please use 75 characters per line for the text width of 
> the commit messages. Currently, especially 4/5, are hard to read being 
> so short.

This is the default we use--I've not made any changes to the wrap. git-log(1) indents the text by 4/8 chars and it looks better if the text doesn't roll past 75 chars per line in git-log.
>
> 2.  No idea, what is done in amd-gfx, but for me it is more common to 
> put the iteration number (reroll count) in the PATCH tag in the 
> beginning. No idea, how Patchwork deals with it.

This is what we do in amd-gfx and particularly in amdgpu, so that the version of the patch is recorded in the title of the patch and in history.

Regards,
Luben

>
>
> Kind regards,
>
> Paul

