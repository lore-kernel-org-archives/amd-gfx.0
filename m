Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E74CCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 03:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD2210E0CC;
	Tue, 28 Jun 2022 03:22:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8E310E0CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 03:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8WGBdPhHtA5icMj8gvwvVj8JWTjkawPcttXZZ02Xrl2seVa8nItj2EN86y0BWbgmb98b/O2iUhdz/4Y7xsZq71dS5doSUfqR92J3WYPj8VPr0rgRfpkI5yuJ+UgVv+6ucobb9P5iuAB9DeNd6TOt4XKqqyzyuHrPJ99cVLMP4jwozL3sxIK99/kH5sb8bzwooX6a38EAfvCCw/e+xQWp9GUEt+7HnTr/XsqF1LL4wfOsqFSfxzrtAnZ1hyogB29HwJvoJD/DGuaszU+nzflRW4dGpYLq083Y9vwYUVzVmofbKeqdY+PYo8M+exGUQQfclLPXvpjLsynMfjlPIBXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ+5OgoLSfwv9M6Bi/DYc3h5tguMGFPWVRfHcZb8fzA=;
 b=axpqFeMf96ZfyMuIyMt5KY4Nb9ah9agm4BsSFTMmKEz9TRRyFtlGipHuVlgQ47qzlk+H1ObQ/WStlDEHFrvl3sKF8uDfEXitrj4DhIJSoVYP/n9Zw3Okr4Tuwg+BH4mVbU9TKt9NpNQMAGfiq3cQ6ChK6RhGCDJ5BtNUOB4CCN8IpD03ijSknh+jjjj7JY47i2LqYMJ/kpwiFMKXcK7MXEwaNXJRQVrDDOgRmkIk00KUQ8esneTfsIOflzE60HqU8aUFD33a6cn84rwysilpSZm9sVUtu2pwvyqCpNCJjHBJ0p48lGNn7NJX3OFXv+efFw4t5O07kNQhTqDjcfIRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ+5OgoLSfwv9M6Bi/DYc3h5tguMGFPWVRfHcZb8fzA=;
 b=Di8HAucZQzEPwAtVFFSI1vm/Di/ALiQHw5Q5Q0iqnf5Awvz/Vtt4vwq1pFSqNRDpii9QLsBwed7jEULbZXJs4+faRKaqASsNw75eZi/MTAFZSORWLE8xuGAdwLFHNyGtmMqSoBJYcvKwB/JZriD1OZPwpwKL2APmU7BFVW/sfS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 03:22:51 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 03:22:51 +0000
Message-ID: <8f34c880-40a9-fcdd-128d-deb346089e09@amd.com>
Date: Mon, 27 Jun 2022 23:22:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] Revert "drm/amdkfd: Free queue after unmap queue
 success"
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220627173226.8485-1-Philip.Yang@amd.com>
 <BL1PR12MB5144901899EFC626052EBD0AF7B99@BL1PR12MB5144.namprd12.prod.outlook.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <BL1PR12MB5144901899EFC626052EBD0AF7B99@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:208:32d::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d8678c0-3903-489a-fb75-08da58b57b80
X-MS-TrafficTypeDiagnostic: MN2PR12MB4456:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ic6FOiQ6NGQhFg1OU09t5DGVEJ+ZyIJKVl8eYgkKP2/4UcgkwNdxJdvQ1iN6ac5/qaMayRLP2NrxyUqESuHMON1Xon72y1iP06cz5kln/4xMztwQ0vTMfB7IdgpNWJaVBCH8wEIvyBDm52SDSpF3WqEQeK/2zb2LIalTHCZlWqZTamnD5KrTgRUl8BY6Es1ciLtDFnqFf+uQQLvwK7586ucMRyEdj1FxeEalNeokSvhaMIeUUOpPbd8z/Dp/OVuuJJEnaxUbNhYHcbpS7ktlrd1SE33eHwIK6UWOQ9gHYTrFhP1o3MORy5FUV54VHvVK7zKLKeTgrbTPyagF+XOwpPspZwspXParCO48ATlhazH9LDIeBCnQzn4Rm8eY1KJoLKDZNPYkthXQ/cAqteZv0+Qf+1eOhv5xVhScSqvaSwjEaYHam0koQHYPRZZJb4cqeMY1aegwKzQHkikZhUQzC2MU7ZRTvCQoiYyFoeaOEDFxRqIIY4/qzApH2yzJrEshwuasMIyYo6HmVS1vWFFKzIs4E+g2G3xQZl7SdLR158GFA3BSgK98+IzIxD8KTE54NppKo+4onaTHjCdeePuKz9yjmwmNDlO1m8oDJSeKOkVde1WEXqPbhCP0cZQPBoqjXdFSfUVXljWsIUoVHbR6TgWXCNMiHmnPJjQ0qNSCDlxTV5ox4Db1Vdz0BrskFFgb21A7OIIpMVyLsCCtJcwf72aR0bGWbW19fdtMEnYuYUfLT2n8ruDvczMZ92/WVkIcxmOD7zJKYxCL2lygnAnKINwpcJvHEUHorDRSj421jNrHERyzYZLFjLJg7/JKamsKNQIYMPxCN7Dn3WhOBuXSHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(6512007)(83380400001)(31686004)(6486002)(26005)(316002)(66556008)(110136005)(8676002)(66476007)(66946007)(53546011)(2616005)(2906002)(6506007)(38100700002)(41300700001)(186003)(5660300002)(478600001)(36756003)(31696002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2xPVmFTdjRpNU1McEZPcmIyeGVmdmFyeXBqdnZKeWxSdDQ5R3FFS29ySHZn?=
 =?utf-8?B?VThUT0dqQ0cxLzQ2ZU5qS1FvTHhBSysxS1BFNnVQWUFWZ2Q4Y3NKeSs4djlH?=
 =?utf-8?B?NGVjTithc2RjUktrZ204TkRQMGdTL2drakpjMTFNakNYa3ZtMnltbUJpdm45?=
 =?utf-8?B?OGhrREhCNUcwcEtmOHEyS2dyd0ZPTlg2eTVPT3pWS3NDNVNjMnQ5QXg1RGlv?=
 =?utf-8?B?NUM2YmgxMXBRVWU2L0FVaitrSlJvWTArSDVQRmFScE5wM3c5Y29Jc2twRzQx?=
 =?utf-8?B?cmp0N3pKc1U1ck51RlZSZFVieStBVUNiZklwQW9YcS85bGhVRzVZcklpRlNr?=
 =?utf-8?B?VFplbmJvajgwdnUrdG0zaGs4SC9yUG1GUmRJQmJzUFlFdnVsSWducERySGJh?=
 =?utf-8?B?Q29NbWR1N3h3Q09iQ2FnUHlvNzQzVE1DUlQ2aHFNR1RRTm1nVytjemFvV1Fk?=
 =?utf-8?B?L0E5OC81cW9Rdmw5MFNxZERGMG5ZSlpxVUxsVTYvTktwU2p4a2FXMWxiUVlI?=
 =?utf-8?B?RUhJSUt2VkFhWGhSa3FoSVlXbnIwNklTZXhKemc1eGU2TW8zS0I1cUhLZzZz?=
 =?utf-8?B?OFJzL081d05Kd2s5M0srRHMzWFgzOGZMWU1xbkdvSTJNWG85YUxzR0dnY0ta?=
 =?utf-8?B?alAvMlozSnp0bDM4K1RRZmhPbWI5SW15NE5ucmFVSTUzNGZ6TU9Ub2F5aDZM?=
 =?utf-8?B?SENxdFRIZXZQWjVhMjBMTzc1ZUhJbDFTUWEzZHhQTStYbTNiRTNBZGVMMXNx?=
 =?utf-8?B?M3JKWEoyNTZLZitxZksyN0pRaG43SlJEWWsvbjhKUUZnOUVTNmZHNFVwSjVO?=
 =?utf-8?B?NjVudThGSjNtbmhZN0h4LzNRdmFhUVJERDk3SlhQeGVYY0lqWWFuNVJvVHdN?=
 =?utf-8?B?U25QdkFZNXd4S1VUMUhqVkpoQWZYMVYrNi9DdG1TQ3F5MHZYN0dOdEFEZ01v?=
 =?utf-8?B?NkJNMU53T3NkODVLeXlnS0hyeXdSNXBFZzNzZUVGQ2JLMisvclU2VW9uSmNI?=
 =?utf-8?B?dExCS1FEV25kVEUyV2hEeVNxcE9TeHRxeGJFN2kxa3BuYlh3dW1wR09CaDY2?=
 =?utf-8?B?ZCtQNEEyT3BVeEtGOE9EeEx5YS9NWFoxdlhIY0N5akRCV3hsM2hjTmF5a1ph?=
 =?utf-8?B?K3JwZlYwYSt5RXEzWTFYMDU5YjVqSmNxS1pDbkRKVmRJTDVDRkp1UkVVWlZq?=
 =?utf-8?B?cnJKc2Erc0RLdFVoOVA4cG9hSm1qdG0xbE44Qk52aVFHa25aakRoUXAzN2Ni?=
 =?utf-8?B?eDYzR21tVE5jcVBQRU1iYTJJbDI2Z2Rhbmp5TURvOVB5aWNVN2wyRTl4L1A2?=
 =?utf-8?B?VCsySjJEbWllOU9ic1pqUUt3ZlJERjU0QXZjZzluQ3FjYVI1SS9TQmFVV1Z4?=
 =?utf-8?B?ek5pRjUyN2F1S2NsV21NK2kxdGx5OFpEWmRLU283WUs0ZU5rRGltaFJsTkJa?=
 =?utf-8?B?VXZtL1hoalBKeVVMTkZuYWNvYVdHRDRVRTMwZDBwVW5WeC9yUnp5aUxjbVht?=
 =?utf-8?B?VGlhaGZIMXBLVFZMZlpkaFhqamhTOUx1WXdXSnV2S3Fpd1lvclltdTNONS9v?=
 =?utf-8?B?Zjd1aHMvdDZKRE4wbCtwWGd5aS84aU5rQnk3blpsOFBYZ04rS0FIVmlHY2Jq?=
 =?utf-8?B?anlMYmZGb0JORDBkbjRoLzFVTWNKV2NzTUVya0p2OWhvcnlVOXp2OXFwTXdX?=
 =?utf-8?B?M3lhY3IwNU1ZVjVCc2FuY1o2L0JDaFREQUJBRWUzbEpWVEQ1aHRHaExlcWhP?=
 =?utf-8?B?eC9JL1dYdS81UXZLcmNuMXQwaGZ5TzhUMW5rMGs5akh2a3ZQYmg1amlzNit0?=
 =?utf-8?B?UklTS0NRZjBkbWd2OWdSWlFsbVRSM2JzT1pqY2FPYkl2NnFVV1hCZmxVaERT?=
 =?utf-8?B?N2FvOGdvc25EdlJLQ3NmWGdibzh3MDhpY2w2OXhKanpEYlRhRU82MFE2Mnhk?=
 =?utf-8?B?QVlabDEzMnl1YzFhNUdHc3RNSlNGZGlGRUhXQ2Y5Zmc1bFFsRFlKcmtURFRt?=
 =?utf-8?B?L092Y0NkNHg0TCtMcnFDaEdWbGJEMUdvMmYwdVM3Ymg2b214aWV1YlVRSzQx?=
 =?utf-8?B?ejJ3QlE2OHFoSE1qUjhoMTdaOWVVdkdVOVY3VC9Sb2UvK0FPQlBXcjBkUzdS?=
 =?utf-8?Q?+JTc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8678c0-3903-489a-fb75-08da58b57b80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 03:22:51.2127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHhR+gZKDy7ADDeuGb/sEtWnbBefj8t5caH3E6/zZIam4x3aYx2swr4mCWYS42oV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-06-27 15:05, Deucher, Alexander
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB5144901899EFC626052EBD0AF7B99@BL1PR12MB5144.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[Public]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of Philip
Yang
Sent: Monday, June 27, 2022 1:32 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Subject: [PATCH 1/1] Revert &quot;drm/amdkfd: Free queue after unmap queue
success&quot;

This reverts commit 150c1266d78fbaa0fc5f89461daafae416db1c3e.

This causes KFDTest regression on gfx9, will submit new patch after fixing.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Which test?  Also, missing your s-o-b.  With that fixed:
Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p>I will update commit with KFDMemoryTest.MemoryRegister test
      failed, add s-o-b then push.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:BL1PR12MB5144901899EFC626052EBD0AF7B99@BL1PR12MB5144.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++++++++-----------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 21e451acfa59..93a0b6995430 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1881,22 +1881,6 @@ static int destroy_queue_cpsch(struct
device_queue_manager *dqm,

 	}

-	if (q-&gt;properties.is_active) {
-		if (!dqm-&gt;dev-&gt;shared_resources.enable_mes) {
-			retval = execute_queues_cpsch(dqm,
-
KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
-			if (retval == -ETIME)
-				qpd-&gt;reset_wavefronts = true;
-		} else {
-			retval = remove_queue_mes(dqm, q, qpd);
-		}
-
-		if (retval)
-			goto failed_unmap_queue;
-
-		decrement_queue_count(dqm, qpd, q);
-	}
-
 	mqd_mgr = dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(
 			q-&gt;properties.type)];

@@ -1910,6 +1894,17 @@ static int destroy_queue_cpsch(struct
device_queue_manager *dqm,

 	list_del(&amp;q-&gt;list);
 	qpd-&gt;queue_count--;
+	if (q-&gt;properties.is_active) {
+		if (!dqm-&gt;dev-&gt;shared_resources.enable_mes) {
+			decrement_queue_count(dqm, qpd, q);
+			retval = execute_queues_cpsch(dqm,
+
KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+			if (retval == -ETIME)
+				qpd-&gt;reset_wavefronts = true;
+		} else {
+			retval = remove_queue_mes(dqm, q, qpd);
+		}
+	}

 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
@@ -1926,7 +1921,6 @@ static int destroy_queue_cpsch(struct
device_queue_manager *dqm,

 	return retval;

-failed_unmap_queue:
 failed_try_destroy_debugged_queue:

 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a46e2a37b4a6..c9c205df4a14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -422,6 +422,7 @@ int pqm_destroy_queue(struct
process_queue_manager *pqm, unsigned int qid)
 	}

 	if (pqn-&gt;q) {
+		kfd_procfs_del_queue(pqn-&gt;q);
 		dqm = pqn-&gt;q-&gt;device-&gt;dqm;
 		retval = dqm-&gt;ops.destroy_queue(dqm, &amp;pdd-&gt;qpd, pqn-&gt;q);
 		if (retval) {
@@ -445,7 +446,6 @@ int pqm_destroy_queue(struct
process_queue_manager *pqm, unsigned int qid)
 				amdgpu_amdkfd_free_gtt_mem(dev-&gt;adev,
pqn-&gt;q-&gt;wptr_bo);

 		}
-		kfd_procfs_del_queue(pqn-&gt;q);
 		uninit_queue(pqn-&gt;q);
 	}

--
2.35.1
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
