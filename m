Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A4C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 02:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF6261406
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 02:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF6261406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CB389DA7;
	Wed, 21 Apr 2021 02:08:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB67689DA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 02:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsExN0zBgFnyoXSAFafI1ag1H/8nKfo7jLFy/HWtfJGQWgRXfQ8dkJqL7tSId5wPKeWD+zxJ9hZCOdpSfG6Kr+Rhm7i9aH4432WTgHxDXDg1fn06p24fPEiDcbMlmh26RYxKtQ4qgzDo2AQpR223vC/LoUTWk4zylRq69TuJ7/DmbXVAZGQvQo3nGVJgXzL55Uc1t0UFI1iewY1p8uNXWja4gCdgQegKtSt0HxyzB7sjvk4ldG9TMjmq2Gi7A0sJO2VmC5KcsMwUFkiPkDeA6B2gjIavz7U1eoNguZtAsAY12wTjvfxph0ICJtYQinSlGSMBJLA7/QOuV+w4ahaVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhN2chD3uDDRiaHLR+Z15q5OSXk4S/xBRhinKnggJ80=;
 b=Rfn8IxsBch7dnvjSd0hacCyPLFTCGLRFwFVof1vm/R/POCzW4nEjYeqNk7BxpVtU6bfw319SXMeewAgnnYLOOpF+GB9mVt+iSub9wpaDXPosLGbg7MgoY0cRGVc1Xd1y+cJjVY7DJoU4vI0I6Ol4HfAj7EXbwACVg8obmkeq/BIq8AXvaF4Xr2K4muTmKjx2RJTIbOY2hB3mID5qTD+bltRX5Vd/Vx0dQsW4dzNBHnR9Axq/qndR461S3au4P/tR4DjxCRYEWTS4l4Tn22xHvdhWd4Zl0QIN6sYbcCur60oWouxXCKS9g6XA/yB6TsrNzVTRcOhkmLoJNSN4u2q7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhN2chD3uDDRiaHLR+Z15q5OSXk4S/xBRhinKnggJ80=;
 b=cuXM5QHezSqUjX8Vx93U5MNeRiNk6U+CgWw4BjtBsCl3m+NLZJGSwGt4VYuFJTeIXZIZ0gyTwRHGW1XR8KjTFZxugbdQrwRIBcZmaO2oCGI/E3ypORqX0ERrrWlZ9MgsIdJXwZOZnVDLN/j3TUC10eHTEhT50gyCngrKoWeFc2Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Wed, 21 Apr 2021 02:08:24 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Wed, 21 Apr 2021
 02:08:23 +0000
Subject: Re: [PATCH 5/6] drm/amdkfd: enable subsequent retry fault
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210420202122.4701-1-Philip.Yang@amd.com>
 <20210420202122.4701-5-Philip.Yang@amd.com>
 <8d735d00-1362-4575-2eaf-53ff277e5db1@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <a65fa174-c062-044f-a82a-2134e4197e7b@amd.com>
Date: Tue, 20 Apr 2021 22:08:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <8d735d00-1362-4575-2eaf-53ff277e5db1@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend
 Transport; Wed, 21 Apr 2021 02:08:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8823e5e6-35f9-464e-6132-08d9046a57e5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB114523DE10F86B4423273CBCE6479@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STb5fW7uPDbNqsg36CNKGt0Sj/4t/gI43yzTNyV15icXeCabQOfnn1dtiuEii/2QwuoxeXtQnrE8CtsoAVjhOidyOsqQSD2bget1nZrwmus8fN5Tiuss1PbWgrKoj2bFtfWxlrarZSY02LrZ5gK2SPnC0doLo1ceS67B8AYnGnHON2oG8gdUTOw5Clq0wmuUeI25MTc6+ir0DVAaZ4lj/nhJ/M7r85Vqdsvuk3QyHHbGsYoQlghXohbSzlJKJM7eoD9XAIk+ksVguPEOAYcz4oo3V/RjCH35W8K4Ayza1suW1bTUdcIDVP5isQyN9vJo3Lw3iuHDG8/rucGUteHROaZo5ETMuOjo/wxuFS5OQFluI3rfiuJPBTcCeKzVqaJPRQlcLfgtDT29ULOqOTS34FIG5sYVVyckzh2bykxcwGaSGn+/i7UkOii5iat3teq8gNMMUBvUcfPjVb3kENFAOxcHUuDm81ZDuUq2uPYrrOJkBwVpkf3YlLk1pryFhBboSwnOeBBH4lUrl79ax00AVFnbly+EXN4Psx8TuSShIrqTyIdnVFZUyycEW1z+w50dEhwYIwJv5a/Rr2eW+iuAVUwiz62WcaMgnSdOqxG+v96qqQWfsorW8d4lzFKDe7HqxmgCb7oFCtCsAeJD5N9atMg57jMyEu6fwcYwvxSJeVsPyKMj5wdNUR7DX+nJSHRl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(2906002)(16576012)(5660300002)(66556008)(26005)(2616005)(6486002)(31696002)(83380400001)(66476007)(956004)(31686004)(38100700002)(66946007)(110136005)(316002)(8936002)(8676002)(186003)(36756003)(16526019)(53546011)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QlJvNDFKMHQrcjZic3l6VFdTdm91MmpnUGlJN1BsKzdqa25jd0cwZ0xkWlZs?=
 =?utf-8?B?R0RDcW5ZTzFHV3BZR29RQ21zODRJTTJnaFdpcjdXTE5qNFMzUzRYL2w3U2Mx?=
 =?utf-8?B?YyswWmRRUHJSNVJ2WThsamFKNzdKYUIzM0U4TjFPTzZleWg4NmJYTSs1djhY?=
 =?utf-8?B?L0VBM2pvTkFuQjZFZlV1eXkzSVZZSVVFN2FUU0Q3VC9wZ0I0cHJ4M2pJVUlF?=
 =?utf-8?B?K3NHRDVPRStDTzV1N05LTFdoWUhGWXl2YUxEQlZDK0RFeEtQaGU1ejNDL1J1?=
 =?utf-8?B?RVBVVzV2b2lnUytHZDVEMWRTQlJUQzlycmU2MCtsUWE4aWNxQkQwQ0xkdVZi?=
 =?utf-8?B?b3E1eXpCNlErbTdybllFcmh4MHFVRitiRkJweGlybG5GTXZRcEo3WTRVOTd5?=
 =?utf-8?B?b3BSc01BeTllVzV6WHU5ZlNVbGU5U0RYVkV3RE5zS0dick1UaWRJc0IzbDND?=
 =?utf-8?B?aWZWZzJXVC9OSzJSTjNTY0VDSFV6YWZuUmFtR2s5ckFIc29vSjJ1K0NVMzFG?=
 =?utf-8?B?aEdyWnl4dGcvQWxnY0prdk1wWXcwZFl2WkZKdmpQWE5hWVp0b3ptNUk0Q21y?=
 =?utf-8?B?b2RDUWlDWFpkRnhtakVMazZ3QVBONEdOVUp1Y1JKVTk4ZnErL0FPSEJZNVdH?=
 =?utf-8?B?SldTbFZnQkNoME1HT2w2VlNSa05scTBzU0x0b3FISHRtRnF4YzFvS2MyZ21j?=
 =?utf-8?B?aUwwRUZQMk9ILzN4SG5JeSsvbno2R1h2Y1FKYW1BL1RZZ1ZhVHZMam1aazBC?=
 =?utf-8?B?SGdOcDAyTzZlVEgycnU4Z2ZWTjVzRzRBRURBN2V3c09rTU0yaXFCeEQ1cE00?=
 =?utf-8?B?d2tadmZTY0dnTFhNU0pBUUlZQStzcG9rNzROUDZzd2JmcXhCMHNBMXFoYlY4?=
 =?utf-8?B?YjhJVUQ2ek9kZU9QczlaemFUcGNpc09tUWpIS01aeVZtQllPZUwybTVFWWRj?=
 =?utf-8?B?TTNvTDNnZFlPNWc4d09ZUDJDdlI0R0ZQeFVJUWJ1TWIzeDRpSlNsQWNrSUw1?=
 =?utf-8?B?VzVUeGVGR1FvMDdYMGdsMDFGaUlEamd6b3QveVV1QjJ3NkN4MlRVbzVIRmJG?=
 =?utf-8?B?cGxENGwra2Q1SXViVC9qZktUeWp2VFRXcFdMTDlBU1dTdk95S2dYTURxS3hL?=
 =?utf-8?B?c0VGYkJaYklZTXVBVStXVHNpSHh4aHNDVUxsQU9GbjhUL1hVcFJNUjhIRHJP?=
 =?utf-8?B?RVZlWGdwMm1JT0laeERUdEJleXhRMU0xbVpGbkdsdEVEdHNiVnY5YldCTDdS?=
 =?utf-8?B?YURQd29KSlIzamEyVVY2cncyQlFjUXJyZEdpTGlkVnV2UXd1bDg1bFRodUlD?=
 =?utf-8?B?UGRaRmdqK0dxSE1XajgrNW9LazgyZEhPVmFSVmhBWU5RMlVtZzNFWUh2K2FT?=
 =?utf-8?B?bGdPU3BUbTRDek1oWGJuVktvdlErVDFIWTBMMGEwd1hDRWttRmFybUhVRGZH?=
 =?utf-8?B?TEVsNlYrSlJVS3NiQVBsN2pwL0ZFN1NQcEo5R2taZUEzTzlzN0ppQ1Y1TDh6?=
 =?utf-8?B?cm0wU2JYckhEOThCcjF4OThGaUJ1OU9tQ0NLYWQ1Rnd4cVZuNDE4aXZlMjYz?=
 =?utf-8?B?VyszTm11RjJrc05VbDlxazRHamhlQXdub1pvZTcvVzhONGllc1F4cWZRZzRS?=
 =?utf-8?B?ZWNvNkRqdURxRDViaUlyamM5S3h1VElLajYrbExsZW9qWjZwUi9QaTdrMjJX?=
 =?utf-8?B?bW95eVBud0lxY21tbDdlSjFqMUtsdWVYNzc5N3l4K0dIdXhLcTNRdkJudHNu?=
 =?utf-8?Q?vbRbiHnwg5Rc7tbdlGqYJ8mGfd2UzhF3TBEoAV7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8823e5e6-35f9-464e-6132-08d9046a57e5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 02:08:23.9219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdk+zjw3yOCqtijsnV3lZGtaPZSv3gFh2i/uJPpT7SZzoLJwmc33z5XT2v+aB1dM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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
Content-Type: multipart/mixed; boundary="===============2090730721=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2090730721==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-20 9:22 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8d735d00-1362-4575-2eaf-53ff277e5db1@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-04-20 um 4:21 p.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">After draining the stale retry fault, or failed to validate the range
to recover, have to remove the fault address from fault filter ring, to
be able to handle subsequent retry interrupt on same address. Otherwise
the retry fault will not be processed to recover until timeout passed.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Patches 1-3 and patch 5 are

Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>

I didn't see a patch 6. Was the email lost or not send intentionally?
</pre>
    </blockquote>
    <p>6/6 is the patch from Alex to create unregistered range, which is
      under code review. I cherry-pick it on top of my patches to test.<br>
    </p>
    <p>Thanks.</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:8d735d00-1362-4575-2eaf-53ff277e5db1@amd.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 45dd055118eb..d90e0cb6e573 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2262,8 +2262,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	mutex_lock(&amp;prange-&gt;migrate_mutex);
 
-	if (svm_range_skip_recover(prange))
+	if (svm_range_skip_recover(prange)) {
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		goto out_unlock_range;
+	}
 
 	timestamp = ktime_to_us(ktime_get()) - prange-&gt;validate_timestamp;
 	/* skip duplicate vm fault on different pages of same range */
@@ -2325,6 +2327,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (r == -EAGAIN) {
 		pr_debug(&quot;recover vm fault later\n&quot;);
+		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
 		r = 0;
 	}
 	return r;
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============2090730721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2090730721==--
