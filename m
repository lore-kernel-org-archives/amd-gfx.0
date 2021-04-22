Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A72FC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C7D61077
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C7D61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37F86E231;
	Thu, 22 Apr 2021 15:16:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD26F6E231
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJgLg4WNSd3A3cooOUaM9kYXfHvEv49Ht9Gl0fCjC5TW2UuWK9eKR6ofxEWUs07+owjOqj7NKPFZgkt/hpkqkItWom9PorG1jX49BtphCjkwC+xydmXyE7bNgA+dbzfXZdPCL9tcqLl1CSs4IDcC8bSs4zM0pUuARvTgnqXe3oeFLGgNTauu7fXTjH6M9/az3PHYBoxHBqHYLyW0CYoE7b1gLHd6LxjTL9K1JBgH1Z2zaYGZh3Kk2m/53bw7KD+vZN7Zw/qU1Q1pzjDDGXJa4g2H35Imccyhjn2rWf1tI0r15bHuThz00xVDPds4CU8tSYCEaaXz7YXYODq70qz1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7aJzuF4uT+BgGyYg2wV+/jZ0eYCCFqvtmCT7DqziEY=;
 b=NhK+D3lfrCaNdXzzl7IR0mVdx+FFiq3vYBM6zEdB6RISRECMJZtMF+2+8lo4anskxlyyu7w80Q/BJ2CBBjI3eH0yo1v0lwxI37i4tkPP1umz3lNCZNxi/4QxV/TvwahZJ+b5nftTE9nlZrihpFNVxk/f3LTdwliMbe+gOn9KMb15G+jtZi7haqFUDV8tTZcENXdfGAaKYKMEc+J8B2S2qX6og4HBczatJyqmIBeb7CjG/4RaEJeTwNza94v6ByS7PYIF+7kLqvgkGpdU3OmTI/D08GemW80zaL7WNNpwbPruOIdmoXSfMMcwJN+xsuoVFAhLUAXtJE/qu+YWD8FM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7aJzuF4uT+BgGyYg2wV+/jZ0eYCCFqvtmCT7DqziEY=;
 b=lR+y+48aB/0jG/K+KhOQ1BjsDI5ZLtYCr9AtkVvzXz+RlcBA+VcJRYDX1MsYrbhfUrspb3YXc2E22RM+sWyl3dgEHkdCSAQ7F63iuytKRz0UUu86Mm/VQ4vjj+n7w8Kdvw1nt4SH7TztaWOXHsugIFqY/EKk818ap3Ftg4Vrz1s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Thu, 22 Apr 2021 15:16:33 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Thu, 22 Apr 2021
 15:16:33 +0000
Subject: Re: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Sierra <alex.sierra@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210420015205.9606-1-alex.sierra@amd.com>
 <803e53c6-7268-5521-fd4f-835da994a07e@amd.com>
 <bcd32802-4b03-c7a8-03b6-34e6f3ee0710@amd.com>
 <13fd91b6-473a-984f-6678-b3e3af613e0d@amd.com>
 <5a0dcda1-e270-c109-cfb2-eb882bda0507@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <f04e21b8-0114-62e3-503d-1804b9138697@amd.com>
Date: Thu, 22 Apr 2021 11:16:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <5a0dcda1-e270-c109-cfb2-eb882bda0507@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::26) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19 via Frontend Transport; Thu, 22 Apr 2021 15:16:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 076ac1f3-8fdb-4204-4e0c-08d905a19ced
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB124217F8E40107E7CC9664FAE6469@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GHL/+8hbMo5lr1vafZZTfd9y++xb8EwNyGKtYl/vsPivtMAHCOF3HekcC8rTVApI+/vZkIK1vfc8LxHl39o1sj1Ch3a2H4cSON1lXEM2H5IGtKUcgxiKo1q6X1SG5Seycjjpf3fnv7EHrtb4aDTqEFt9S1N/LmdLD16CVCclMqhFrCc7Z3ZlSWRWqHM8OINuTaRDQrg1x1mYd11+kpA4es+OLoN923TcrCklF0ZX21vS87WbmAjL2ihroUjvJ6Ey6fKJQm6fprhGoeSKKBorumGC4DT3TIbumgDtGK+5Q04TxUA9m4tvxwDz/wYcmvX1EbZwJ4tEMv6nI7IzyLB4hRy+c+axBgg4N5P/QVGKkUUrSrtlar4ebXdb1UM5cSP/8YFWitxbeOOtPimks6gSwSOfr+NQShydP5XAo1y1xayVbbBJG8xTu6FVYD8cqw1qcdoLXVHKFWzHDvBkqsGlmwlgAFFcLJ4NwasjxQODIMxEgIb/yQnPtRtO3Hr+z4OB94t1zEMi8NkxMhhhxeAA3MMDTNNmto0FbB9mn0B8cmFXKmrHL4NEQIX1MF0mAKUUAI8zpUePK5uyD3xQCu2t2JyMpsQsRbrKhRhMOvxwWZk4n+UKnaGiVnFMAL/KCZ/UI/NQfOk9WNVVdeOIJBTP09yn9SOAsjW6Sy799ys2iKX5aSsLfDejx1ZYqVWcgTCQqdnme6YSxmWjNKBBYC5JbkHcIZqtgqBuq+J63O54io=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(36756003)(478600001)(31686004)(966005)(2616005)(66556008)(5660300002)(316002)(38100700002)(2906002)(31696002)(16576012)(83380400001)(8936002)(6636002)(6486002)(8676002)(110136005)(66946007)(66476007)(16526019)(186003)(26005)(166002)(956004)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WHRtaG1rT3FTSXFNL3M2Z0lmNFhuM3p0Smpqa1pvU21pSjdhaHFvVzA0Ty82?=
 =?utf-8?B?U0JpM3cvekdCdTA2YW1iTW1YSFVDbWpaZ0Z2TWN4U3dQVzl6UnhkVWhyWkFy?=
 =?utf-8?B?TExobkNmM0xoUURkcnZoRDlvUTMzMnZrRDk1c25ncVFVbld4L3o5VWt2QVlw?=
 =?utf-8?B?aW03OGxaTFRKckhHa3hyVWRaTnlPYjdPTnRINGxVZldQR3dEU0ZXSVQ1bWJV?=
 =?utf-8?B?YVhtM2x2WExDNUEzZ2pEV0pza3NuZFpZa0ZBaE9uVDFUNXdFRUlQOTZ5bVpU?=
 =?utf-8?B?cDNkQzlrYmR4dm4rc0xaZ1dZaVdmUWYrV3FOcmhIMHJzUm1NV0tWM0F4S0hr?=
 =?utf-8?B?YjBhbmdjM2ZwS1o3MEhHeEJ3RE8vbDRqblpkSms4aUtHbEtiZGI3SGZXOCt0?=
 =?utf-8?B?enZWa2ZMUERCQ1pHRE9PYzUvOFZ3S3ppOFBCOTBTTHczUkFYYUhBU2dhOWx4?=
 =?utf-8?B?SXY3Y202a2J0by9FSGx5ZXFZV2dFbFZJM3BNSlVaVjR4clF2dkh6TTF2ZXor?=
 =?utf-8?B?VTdXUnJZL0xRaUJlNklQRXc2VStzb3IyeklxQlVwbDFtMllCbkpwWkNyOVNi?=
 =?utf-8?B?cE14OTFudjQ1WE9uVEdTMmU3OHd0VFVZbkYvUGw4dXpTaTdYUCthZDd6WmI1?=
 =?utf-8?B?eU41VjBaQktJRThGdXN6cnJWK3RKVEdPRURmVElqOFlxV2IwQ3FVODNiSXRt?=
 =?utf-8?B?T1JFVHh1V0JLa3pVbERocU5VYzNxRWtVQXFyMkRBeXdvLy9ZLzBTazA2TTVS?=
 =?utf-8?B?RWp3U1dINTZzMjhCRHV3aTFtZ3lZMmthRENzTjhxbE9saGVtOE9BMURaZjVt?=
 =?utf-8?B?anppZVhFNm5yZ2FyWlJZMTJ0Vmp6dW5YaUQvYlh5M051cWlQNWZUUGpDdXla?=
 =?utf-8?B?TmNFVTdyR2t6M25kb1ZQelZUMm1HSWRTOUFZeVY5ZjFxTkZ6MUk5ZTEva2hE?=
 =?utf-8?B?Uk91RTRaY1FJaTFUbGVPSWE2VFRZV1poRXNXejVJVVJSK0FpR0VscHBKNnBa?=
 =?utf-8?B?aG5zNmRLRHhFZTlGZlovRWxFdVFZRGtYVU0xVXBJbzBsaGlTekR6eFY4YXEx?=
 =?utf-8?B?YjRNVjZqZnhDQ1piTy9QbVozbnIyWTM1TU5EUDhZTjR1RWpoTnYrbitRZjBC?=
 =?utf-8?B?anJUWkVlZnU5YlZlWHBpckxIcFJqdU40RjFmV2ZMVTBvcVlmVUREdjlOY2xS?=
 =?utf-8?B?RUNmWXhrRHhvLzh5Ly9Rb1FkYXcvMzIvbW5LaEJTUnFiRUFmQXFzeHpxWWJD?=
 =?utf-8?B?U0V0V1dMOHhBVnVVL1pXRUVmTjJyeVNjSjhpL0g2eTBEN3JzUFNqRHRMZVZl?=
 =?utf-8?B?Y0FWcVRBM3F3U2MvZ0FvSk5UTTRoVFhTWE5wNThvRUZrbVVEQlhrY0dwbHFS?=
 =?utf-8?B?YS9wMERabjBiQkFiWk0zSkV2WGpIOVRSVGZZQitGL1dzLzFqOE1JeVdweGhk?=
 =?utf-8?B?cXdGR0ZyRFQ5ckxIa2dNMWNPZGllY2FOQVhPd1BFTFNYTE5aSEJzV0FlN0Zt?=
 =?utf-8?B?UGhWK3hmMUZMWnlnTTdVNVB6QWlzR3pPeTkzYm9hWlZHT2hXaVhLU0d5VmVI?=
 =?utf-8?B?RU56aURRVTFoblgyZkxuZnVFcXNiSlN1R3g2VzhxRzk0RFRFZlRPWWo4c1kv?=
 =?utf-8?B?UXJCRlVON2YvcEhSTlBFdTlZYUMvcGRvdEtrQmZmam9rR1U4RjNGM09uWDU2?=
 =?utf-8?B?ZWU3bUdleVFHTkxHbmNTV2pXV0Z6MldwdGV4c0RuWjJVWC9QRkwzOFJzdXE4?=
 =?utf-8?Q?kBCc5Fsy6Bq1w5pXg4BlcR8xovqqtysugtOwAn5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076ac1f3-8fdb-4204-4e0c-08d905a19ced
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:16:33.2695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wdBCNjCANtPEmmP7A5UgxATsY+r1/9ICWgAmJuBN/KJ6sn8z1vjfCoC3KVbmAi8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
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
Content-Type: multipart/mixed; boundary="===============0215596383=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0215596383==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-22 9:20 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5a0dcda1-e270-c109-cfb2-eb882bda0507@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-04-22 um 9:08 a.m. schrieb philip yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 2021-04-20 9:25 p.m., Felix Kuehling wrote:
@@ -2251,14 +2330,34 @@ svm_range_restore_pages(struct amdgpu_device
*adev, unsigned int pasid,
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap=""> 	}
 
 	mmap_read_lock(mm);
+retry_write_locked:
 	mutex_lock(&amp;svms-&gt;lock);
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug(&quot;failed to find prange svms 0x%p address [0x%llx]\n&quot;,
 			 svms, addr);
-		r = -EFAULT;
-		goto out_unlock_svms;
+		if (!write_locked) {
+			/* Need the write lock to create new range with MMU notifier.
+			 * Also flush pending deferred work to make sure the interval
+			 * tree is up to date before we add a new range
+			 */
+			mutex_unlock(&amp;svms-&gt;lock);
+			mmap_read_unlock(mm);
+			svm_range_list_lock_and_flush_work(svms, mm);
</pre>
            </blockquote>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I think this can deadlock with a deferred worker trying to drain
interrupts (Philip's patch series). If we cannot flush deferred work
here, we need to be more careful creating new ranges to make sure they
don't conflict with added deferred or child ranges.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
It's impossible to have deadlock with deferred worker to drain
interrupts, because drain interrupt wait for restore_pages without
taking any lock, and restore_pages flush deferred work without taking
any lock too.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">The deadlock does not come from holding or waiting for locks. It comes
from the worker waiting for interrupts to drain and the interrupt
handler waiting for the worker to finish with flush_work in
svm_range_list_lock_and_flush_work. If both are waiting for each other,
neither can make progress and you have a deadlock.
</pre>
    </blockquote>
    <p>yes, you are right, I can repro the deadlock after changing the
      kfdtest. We cannot flush deferred work here.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:5a0dcda1-e270-c109-cfb2-eb882bda0507@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Regards,

Philip

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Regards,
&nbsp; Felix


</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+			write_locked = true;
+			goto retry_write_locked;
+		}
+		prange = svm_range_create_unregistered_range(adev, p, mm, addr);
+		if (!prange) {
+			pr_debug(&quot;failed to create unregisterd range svms 0x%p address [0x%llx]\n&quot;,
+			svms, addr);
+			mmap_write_downgrade(mm);
+			r = -EFAULT;
+			goto out_unlock_svms;
+		}
 	}
+	if (write_locked)
+		mmap_write_downgrade(mm);
 
 	mutex_lock(&amp;prange-&gt;migrate_mutex);
 
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============0215596383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0215596383==--
