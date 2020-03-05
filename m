Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5BC3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 21:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AACE207FD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 21:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q0lhI7qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AACE207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F346E3A8;
	Thu,  5 Mar 2020 21:09:56 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680069.outbound.protection.outlook.com [40.107.68.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EEE56E3A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 21:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpuneHAghee6fytKuoYmoyts0m9VNF9Hm1Cb4m/QVPrrqDJTQaZf+xxHT3IatLIM+ZxPtWNTw4khiTZFfNQOOKMykqyrRPK3QRFvkAeMdwkoYlighnP0171VMZ/hAL38HyX9mfhGuFTItMIo4QKDwIXOWHaOo4f5q8PE66jTvcgqJy9f132cRTefZZQQNCiseO1NuZHH1BBrr5AoqLXhDlgigBv6kojMZrPbH9subX8QFW6VgbrjULEOZ870RtVo+H+VXtEgB3PmQMGzrXoEXjIZ11xSbW3gDNhFgiw+i197x26JBtmpCH2P9BwAqvEJVTTbhm/TDwgj7jNzRbUVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmmO4v63fsjxfKHlAmpia38F62Tph0X6+naAw/D4ah0=;
 b=PdjkP2v8bEIg6oScYBfVoq6543x+ZmlMZ1433tSpPKM3YixjlDGFhx03v/ynD0xWbZ9CEiZ2VkSc997xooUNPSi65foODa5zLhW9DpEXcK1YvUsUaPiTcDU0FQpEsUaQ1QxDvr4U77eoFMVO5K7QLrdjJUBpj1ZFd1EvSDuzWgAguknMpC8J20QQMZZYby2bs96qEKiDrwo8Cg9znruxtk14dtFt2z5QIXylQVEpdjCtfC0antctP/1nv9Z/JAe6yiHYFWQXaqf6ug/72AsmGwKRSddOxzKbn9XjcZhzF+sXtkMRSALaGSS4J4N/80duox2QJDyxbcYW0hI2VH/VpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmmO4v63fsjxfKHlAmpia38F62Tph0X6+naAw/D4ah0=;
 b=Q0lhI7qTykZtIIYSbJ1yqMr1O5pDjaJFOKvkL1yrfqcixSj20/EloqQMOOjqjbCDFXBJ+bvxrNh3D/pqLyw3VMliv0JSDMs0iacMnrwZ9iSH+dKZ/opD39BeIyl8ymLY1OMvU9+CUF2bVBrQQ/beM3rPzZOKBrxyhPejMYiplbg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1209.namprd12.prod.outlook.com (2603:10b6:3:6f::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Thu, 5 Mar 2020 21:09:53 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 21:09:53 +0000
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
To: Luben Tuikov <luben.tuikov@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <2085216f-f82c-3d2e-8f91-b05c2cf76a50@amd.com>
 <8a5a1348-79f7-f7a2-c686-df16726def9b@amd.com>
 <96eb728e-e44a-0d95-0303-f24ec8620df2@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <f4cd66c7-6f7c-0049-27c8-5f70c1a4e999@amd.com>
Date: Thu, 5 Mar 2020 22:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <96eb728e-e44a-0d95-0303-f24ec8620df2@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::16) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2e:a500:1f22:cf19:9085:11a1]
 (2003:c5:8f2e:a500:1f22:cf19:9085:11a1) by
 AM0PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:208:3e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 21:09:51 +0000
X-Originating-IP: [2003:c5:8f2e:a500:1f22:cf19:9085:11a1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c794169b-1c0c-4906-5f48-08d7c1498c8b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1209:|DM5PR12MB1209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1209ECA88078825B7D135E488BE20@DM5PR12MB1209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(4326008)(8936002)(52116002)(110136005)(2906002)(33964004)(53546011)(6666004)(316002)(66946007)(36756003)(66476007)(5660300002)(6486002)(66556008)(81156014)(8676002)(81166006)(31696002)(21615005)(2616005)(31686004)(186003)(16526019)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1209;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8IGRtBnezfht2W0e2/L81Ukc3VIZkE+329lG+ymXljWkp2CgkLbO/d1IDp9a8KrdKnDVWP8/wzkWSf643RHLuCtzqx7/vw32mgcsrpyti7vZg6OYHbKffLk2fPD5G/qHAvxAZPIWop3YsRNq7GBjXdX+ppml9Rzwl6H1DaSF8DNWt696AZ8k+R7ETVUfGCHPppf2s8pKm5nb8K/CXsP5xJFImybm3kwKkOoD1BPtNyVOaCJsST8D0RMjhuAl0fXXX1UqLdnPHGrzfJ11tUX19U7jKmaUrruiazZKo0js4maeb/DIsM6r5Ye1vYPn1E8kYQtPG/OKuVDVoPQiaIeB02WfRDLnyTuBCBQ/lC8bOxIXD9TR19jQTDmQiF3zYs8cyxd35/eY5lkvXYuXD72oRcr17fqkSu8El+p6eFIx9LA2h058L7/t2lmx0IqJuJ8exYZnovIujTo2BxMKxakVHTIi3Bj8QVF9enuwImZFDqTzn63rjlfkFUxU/A1qWs3BL9iu3EnjbH6fK5ygA+mb8Q==
X-MS-Exchange-AntiSpam-MessageData: 50OJxJ+WOeUTIiMOrWjm/mUeCb6csE6+xhvf5uBryyrJn6CvhHQTkaBzuS7KYUaFbHim6Xg3HbB/zuwPy9rC6Ggg/keJsSrIxzXjZI3xDqoXQ0fIAC4LoX26S9WLPRBBnFfUHjmpHVWM9UapksBEPzSQ4zrvVslv9/Ax5mgcGUT1eRz2CqP6OkUmTOqNZq7y/jM8vDAikKS/NGrAWTufZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c794169b-1c0c-4906-5f48-08d7c1498c8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 21:09:53.3130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDy+x1649MxWmJ72X6cbZXrO0gaZ5qWIa2yx3741afzyjBbQxnY89ghw23Vf8qDb8wBco3JgeyQy1/Un5nrd3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1209
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============1840692970=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1840692970==
Content-Type: multipart/alternative;
 boundary="------------58394B1AF8BA8565DEB681F5"
Content-Language: en-US

--------------58394B1AF8BA8565DEB681F5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/5/20 7:42 PM, Luben Tuikov wrote:
>
>> A quick search leads me amdgpu_sched_ioctl() which is using
>> DRM_SCHED_PRIORITY_INVALID
>>
>> to indicate a invalid value from userspace. I don't know much about drm
>> api to suggest any useful
>>
>> changes regarding this. But again this isn't in the scope of this patch
>> series.
> I'm not asking you to eliminate "DRM_SCHED_PRIORITY_INVALID".
> Oh wait! You forgot what I suggested in a previous review on
> how to fix enum drm_sched_priority, did you? :-D Search
> for that email.

Let me quote[1]:

"

Also consider changing to this:


enum drm_sched_priority {
         DRM_SCHED_PRIORITY_UNSET,
--------DRM_SCHED_PRIORITY_INVALID,--------<--- remove
         DRM_SCHED_PRIORITY_MIN,
         DRM_SCHED_PRIORITY_LOW = DRM_SCHED_PRIORITY_MIN,
         DRM_SCHED_PRIORITY_NORMAL,
         DRM_SCHED_PRIORITY_HIGH_SW,
         DRM_SCHED_PRIORITY_HIGH_HW,
         DRM_SCHED_PRIORITY_KERNEL,
         DRM_SCHED_PRIORITY_MAX,
};

We should never have an "invalid priority", just ignored priority. :-)
Second, having 0 as UNSET gives you easy priority when you set
map[0] = normal_priority, as memory usually comes memset to 0.
IOW, you'd not need to check against UNSET, and simply use
the default [0] which you'd set to normal priority.

"

I guess understood it wrong.


[1]https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg45621.html 
<https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg45621.html>


Regards,

Nirmoy


--------------58394B1AF8BA8565DEB681F5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/5/20 7:42 PM, Luben Tuikov wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:96eb728e-e44a-0d95-0303-f24ec8620df2@amd.com"><br>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
A quick search leads me amdgpu_sched_ioctl() which is using 
DRM_SCHED_PRIORITY_INVALID

to indicate a invalid value from userspace. I don't know much about drm 
api to suggest any useful

changes regarding this. But again this isn't in the scope of this patch 
series.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm not asking you to eliminate &quot;DRM_SCHED_PRIORITY_INVALID&quot;.
Oh wait! You forgot what I suggested in a previous review on
how to fix enum drm_sched_priority, did you? :-D Search
for that email.</pre>
    </blockquote>
    <p>Let me quote[1]: <br>
    </p>
    <p>&quot;<br>
    </p>
    <p>Also consider changing to this:</p>
    <br>
    enum drm_sched_priority {<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_SCHED_PRIORITY_UNSET,<br>
    --------DRM_SCHED_PRIORITY_INVALID,--------&lt;--- remove<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_SCHED_PRIORITY_MIN,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_SCHED_PRIORITY_LOW = DRM_SCHED_PRIORITY_MIN,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_SCHED_PRIORITY_NORMAL,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_SCHED_PRIORITY_HIGH_SW,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_SCHED_PRIORITY_HIGH_HW,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_SCHED_PRIORITY_KERNEL,<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_SCHED_PRIORITY_MAX,<br>
    };<br>
    <br>
    We should never have an &quot;invalid priority&quot;, just ignored priority.
    :-)<br>
    Second, having 0 as UNSET gives you easy priority when you set<br>
    map[0] = normal_priority, as memory usually comes memset to 0.<br>
    IOW, you'd not need to check against UNSET, and simply use<br>
    the default [0] which you'd set to normal priority.<br>
    <p>&quot;<br>
    </p>
    <p>I guess understood it wrong.</p>
    <p><br>
    </p>
    <p><a href="https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg45621.html">[1]https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg45621.html</a></p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Nirmoy<br>
    </p>
  </body>
</html>

--------------58394B1AF8BA8565DEB681F5--

--===============1840692970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1840692970==--
