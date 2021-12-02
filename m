Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72806C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 15:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10396F98D;
	Thu,  2 Dec 2021 15:51:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3B66F995
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 15:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbZVwesvFEj7AwORnAyohXW+8oqbW2u72D1xEin48yN1LOrZKFyzKiTYvr+5INVt1tmQTG4AGTb2rWJVhSc92Tm5Elvuv/VJEjQLXjV/6y2na5qOsEE2qg3w0XC3RQqZkmFRpejsdQUMQyUQjvJnirNIQTb34wkEjMxxET86zBRHu0KvBUogF705DbKTYUyrDyylCI0R+5mKgmkqAvxzaHg7DOnRicjl0YChXGNdlw5aYGjMXijcS+ZQ3uK/0R/2cjnFJR6/gOmB1S4DVQfHp8nQxUX291z7fHmv2U2fgM5DEM1J3B5LFzYUIj1FNtB7ffz+BlLNC1yae3FBjaLmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs8nn+NYOrt4/qiDl8UxB+GozvU6d1DEpzDBjsDzKwI=;
 b=d1fwtelHPbejxkAXb1DdBAj0aKQu13HSu4qoh0XihxY+wxQXgNbRWrArRfDAEQlpFoijM06jSRR+YYf7dUKd1/+ejp+VUeZZUBORZaJMl3UmaozZDCi85speWVuVQKOvH4kr2wZ4wTZ5nEQiX7iN6DvwTwZ7zgkk6Fonr2YuxQZ8nI0JR2E2O7xxIwIYUMdY4yAg59w9HJ7LW+AFbmfQeQEGjuAC/lmtBy189wT2kEwIoJLFIaD41e27qAkB3v9L1yDtpjdkagJjrFrwKC2a4v2ZWF+pIZxod0cPJQe/TGyySBTLKLajedtp7ZqfiMrnSRcXeMWECM3FmNlSByY+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs8nn+NYOrt4/qiDl8UxB+GozvU6d1DEpzDBjsDzKwI=;
 b=gCogS+sNQJ77lZvpKo/rT7NXkMvYl2Ch35EWBEfw+pFtjREZISPU1ZEJKrefXguOE6pkNp6OIa2aUVInp13z6g5Yi+su2HHdkkXxt22JvSSPwDd0yGDd6qAXV2Lv8G9JRf1GjF54pwl5TOj0LhMukUUCoeTaplbnWLj1aKcOA4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Thu, 2 Dec
 2021 15:51:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%5]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 15:51:06 +0000
Subject: Re: [PATCH v8] drm/amdgpu: handle IH ring1 overflow
To: Mike Lothian <mike@fireburn.co.uk>, Felix Kuehling <Felix.Kuehling@amd.com>
References: <20211125203003.18038-1-Philip.Yang@amd.com>
 <d5862808-c97e-a1c2-4429-7d0216425fdf@amd.com>
 <CAHbf0-Eyn9O_hzXa4qfQcQqmme9=nadEnhrWW7fKHAorw3Dr_A@mail.gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <25451610-12c4-7002-71a2-1311e2762bdc@amd.com>
Date: Thu, 2 Dec 2021 10:51:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHbf0-Eyn9O_hzXa4qfQcQqmme9=nadEnhrWW7fKHAorw3Dr_A@mail.gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:208:329::16) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BLAPR03CA0071.namprd03.prod.outlook.com (2603:10b6:208:329::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 2 Dec 2021 15:51:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96451565-b11a-4433-c63e-08d9b5ab8ccd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:
X-Microsoft-Antispam-PRVS: <DM4PR12MB529523EB66B535F746E10C1FE6699@DM4PR12MB5295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fqXXdGzaiJBg8CiuvzwCuaQlkNXcZibGFphVPOSwV/hCaUmKG/uqMiQwRlAqb7IbIHCOmh1HpE1XJqVObGRaZ22bPyITqpKe2mYFo5pLKEr2VNx3wOAtUws9rukLJ+Y30AsMxFqtWVB4hA3CkB3rv1+vxThuCQgVjcco/2JrrEIfEHN4B+zSlt48ZpRpwtWVL8lUv2y7iWo/34DP6b+1Fgg4S0CME1J+FBNlD9Lg5lkYp8CDmUd0qX7QmNsUcTvr2tdlIeezWt7c7CFBNg+9I5BzXc+Py9vUaqtZkGu6qgr7G2OTpdDFnorxH6+ptjfXOQmOBCd1n74sx7mG93dLxmeeXiQyeHqUyJIBFv0sFnYWKdiWIYo9U9rvOFvLr7ZOF95MaVGALJYKnB5IQ7XD702RdQ6e5PWJXcaeos+QQTK9xpviD9lWQmIXherVj1uKzBTzJNAmqktWfhWRm6nZFVdZHUSYC12KMl/foF+vAO3fgaCaRaen1f4D3Ij3BvFL519kP1qTbLFhXn0HpEf6Mq+WWvXmMXv8QWXNQvZrJPUsYIVj1YyI8DQC7WlWZTrsue9Faw6lR5UlNWQCAny0Dk7aae8bNyCHfOz9YAhD15xruR3OPwGEhTo+Wyw5M4U//zqbujw7ipyvW31tnqMPuDdV2FGGpFlAYGHWSR4Eg+UHs+xhZwlvBj5P8amGQRrY9tHZBbkmz3wSyKqeZ4vsKv2z6V3pyCEe6fd+SPaWmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(31696002)(36756003)(31686004)(2906002)(16576012)(316002)(66476007)(66556008)(966005)(83380400001)(8676002)(26005)(66946007)(166002)(6636002)(5660300002)(53546011)(6486002)(186003)(956004)(508600001)(110136005)(4326008)(8936002)(45080400002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDdtM29oV2xDRkFickdjQjF2UFo3Z1VybWF5V2JUZlNIaklldVJsOWYrcWRR?=
 =?utf-8?B?cGdMYkF6ZUVodVM0MG83ckVaTmx4cHNEZ3o5Z1Z2MStRRTFXejRpNUhLeUh3?=
 =?utf-8?B?STNIREJCeDZOV3I4cGc1RjJvVENQbHozTlBlMnk4bmJ6NWxvc092VGhJWE9w?=
 =?utf-8?B?Tk1lVE95NFJXdWVoZDVEVWFqUVF1QmI0Y2NhOUJVaUM4c2ZhR2Fqd1V5T3c0?=
 =?utf-8?B?bU85d3B5RWxiVStSYVR6MTBJWWxTTUpBa08wWTVBK3ZOSjBkL2YrNmRLWkh0?=
 =?utf-8?B?SHZWM1ludWlGUlprb2FkbGlGcm43OE9oekd4L1Z2S0lXRHBuT2NsQmwyL1FD?=
 =?utf-8?B?VUNiV0RDUUloRXl1NzRQQkdSeElEZm1xanplS0JOOUpXek9OejFuWDIyTTlt?=
 =?utf-8?B?ajlzcE9jWVBsRUUzWEdZd2lpLytObE1sSGtObktTNjRUWlI5cExJdUsxdEox?=
 =?utf-8?B?Mm1sek1SM2RUbThSNWJQZytFeHQ5M0JCeWgyOGhkZHBSTS9HNUFOUkNQRUdu?=
 =?utf-8?B?UWhyQjhHdGR0VmhEd2FpYzMzS1h6MFdnbEJlU2tYMzJQc3M2ZUZMM3JLME9l?=
 =?utf-8?B?bkpzdkNDNnJ2dEgvczlOTkRwNXJOcUV0ZHNFekk1WG41VmtRb2ovUVpBS01P?=
 =?utf-8?B?YXZ5SzdDQ1pmNXRFeU9VdVc4ZTB4WUt4SWpiOE85ZFNQWDBpODRnWWwxNlU3?=
 =?utf-8?B?RjF1MUExbzFZVnA0aXJQQ2VMUTN3MXlhcmxRd3JkekRhdlk4ZUY3YTJvZlpv?=
 =?utf-8?B?MTN2S2kyRnBEbXN1NzErek1ic0wvdmRTQlpuSUk5NHVtZWtvSXhCWjQyNzB1?=
 =?utf-8?B?SVd3dndLNnFCdjBFRWc5SjRLbVY0WHJvZXlwWitFaUwxN3VmMndSQUxDbHVZ?=
 =?utf-8?B?aXFiVXcvL01LSk5HZ1hJQmp0K0JuNjUzQlNreEJsOXlIN0Y4bzF5OFBrMFQy?=
 =?utf-8?B?RzRtVEpvdEo3b0xETERsdlFSZkV6QkxzMW1PNWlPYUhVTU9qQ3JXMEg3NDdR?=
 =?utf-8?B?NWhrcC9HWXZlZW9HbmpUQWlGMkZYSU12SFdnTlFJUHpDamVtcURodlJBZGVU?=
 =?utf-8?B?Ym1MM0s1MDc0SmZrcmduU1JQRkgxRUkyZFE4bGliSnlVL005QnBiWDZ6c1BH?=
 =?utf-8?B?Wi9yLy9Sa0ZZQks2bVBOWXdpVmlRTmxodlQxU1N6TTljSmRERUtxMzNaNDNt?=
 =?utf-8?B?TFJPZktYSW5HR014T0xlb2hTcllkZHpXbEs2aWVoTFV4VDZOaitsUHlwYjlK?=
 =?utf-8?B?UEZYN3hTa1RaRjZWbVo4YVY3YWdZVXRxMXl5VUlTZkRZNFhxVnJzUEZIam9y?=
 =?utf-8?B?WGtENkV6LzR1RVZYdEQ0MzREelMyaUdZWGJJd0VMMG01OWJoaGdwS0hiUlps?=
 =?utf-8?B?TEpYdjVDTjNibm54b3liV2Z2YzRQNGZiNWZudkprNFMxRFhWVjVpSGc4bStF?=
 =?utf-8?B?bTdndWhmQndtaVBncmNUZGY0R0ZyckQ4YkNJU3hkUUZOdkJuempZOXg5Rjgx?=
 =?utf-8?B?VTZZeG14KzNKVXNjMFVaOHdLeHd2YjhWZStQcE1mZ25Zb2FCZHlzK0twMWhG?=
 =?utf-8?B?VWxoT1huUlVPYUZrWFU0bjd5c3JCTjRRUnJJdndPZkZFcWdKcjNqSk9ZMW4r?=
 =?utf-8?B?cW1HWEZxQTZmdGJ0c3MwaWhHTWhSdXB2MWtvV0NsN0trbDRVNjZXclFUcDRp?=
 =?utf-8?B?bjQ3S3hLUlFtRTlKUkFnQ3RwSExvWFJtYXUvdVA3S1J3L2s5UXRjQUR1bnFF?=
 =?utf-8?B?RHFvMllPTE4vL1U0ZVFWcEdsNlkzYWpGWGJJN2xZdWY2a1JyZm5yNENTR0U5?=
 =?utf-8?B?WkxlSU1BYk5wM01LY3k0OFFkSGVNWFE3ZzlCMGtiT1ZlTzdSMmhMM0h5Ty90?=
 =?utf-8?B?ZUFMNENoRHFJSXNoZGM1V3h2NnJkUHNVWjFBMmhtMU15S2hjTXVheTVCcnV3?=
 =?utf-8?B?ZGZDZkRFNE1YVFp2dURlVTk2NjJTamEzRkptTVZjSUxYWkVzRDA5cWVjbU5R?=
 =?utf-8?B?c2pEeGJYVnNydW5CenZ2cGlrMEVDcUJRZ3FlQW1aay9YbXduTnM2aHNqbW9O?=
 =?utf-8?B?M2Z6WXN3TjFmR2l2MXRjeFRxZnZKZWI1Q3c0STVKOHJ2MlJrRHpNUWIra0Iw?=
 =?utf-8?Q?MPVI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96451565-b11a-4433-c63e-08d9b5ab8ccd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 15:51:05.8575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/FkI/wO640p41QNnOS6DdON948I6oo3P4JBtsEuEJgdB0NIP9vGyABYs2mOQ1P2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
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
Cc: Philip Yang <philip.yang@amd.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-12-02 7:43 a.m., Mike Lothian
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHbf0-Eyn9O_hzXa4qfQcQqmme9=nadEnhrWW7fKHAorw3Dr_A@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Thu, 25 Nov 2021 at 20:42, Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
OK. Dealing with processed timestamp rather than decoded timestamp fixes
the race condition where drain would have returned before the last fault
was processed. But we're still assuming that each interrupt has a unique
timestamp. We haven't seen evidence of the contrary. But I'd like to add
a check to be sure, in case that assumption becomes invalid on future
hardware. Something like this (before updating ih-&gt;processed_timestamp):

    WARN_ONCE(ih-&gt;processed_timestamp == entry.timestamp, &quot;IH timestamps
are not unique&quot;);

With that fixed, the patch is

Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Hi,

I'm seeing this on my machine
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1818&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C770013943b484db418a008d9b5916797%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637740458397477281%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=8a%2B%2FzRA%2F4VMPp%2B3AA0L%2FwJ9oCZxl7QQbvE4535m3HM4%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1818&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C770013943b484db418a008d9b5916797%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637740458397477281%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=8a%2B%2FzRA%2F4VMPp%2B3AA0L%2FwJ9oCZxl7QQbvE4535m3HM4%3D&amp;amp;reserved=0</a>
</pre>
    </blockquote>
    <p>Thanks for the report, the warning is for chip RENOIR, right
      after device init done. The assumption of unique timestamp of IH
      vector is invalid, I will submit another patch to fix the drain
      fault interrupt logic and remove this WARN_ONCE.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:CAHbf0-Eyn9O_hzXa4qfQcQqmme9=nadEnhrWW7fKHAorw3Dr_A@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
Cheers

Mike
</pre>
    </blockquote>
  </body>
</html>
