Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63474C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 15:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A9860E90
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 15:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22A9860E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14B56E8B9;
	Mon,  1 Nov 2021 15:11:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180B36E8B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 15:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYt3e6KupVFC2KUhfwf8IxORB990m+OENV5f8zO6e9k65iACYOUzgajX2xJkDjgTcf1x5IwfWrAbQKiih1M8bS8/J7G0x6fPHcnBrI/mp+0N1pcZQZ1iis8jqqe/6KLaYNGEPqP7s6o/SsLUq9NCeiu7NzGmZ1HlEahvi7rt4w7j9z8hqmcjDeiy7zREaNj233oOp648EXSzYXZTv1uV8LChqq3xKth5Znhafiif8kLj7BIVnMgNiBuW8BmaymTosthI/XtG8eS1zTnxmWITAWiVWT0JLFuA0mxTcy3A8y3j4dovC9quHuHFHSjhMgY5wCvdJmcSXTaXkhYDOESUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUxv/2uJqXnjl4YsMy69N/t57OyCEVJdusMXo8Mlfsw=;
 b=kswLSYOG/0pOytVYWaPZu4Zk4Ypn3ostIlj6GLWYK0dZaxb1+vJCamrSr1uokvQ64NzJvQ1oSJ6PnCqkp7EphfvIlirWopWsxONyH/MrmYkphrbOsXqR+ELNrXb/mW7RNKWXr3mZL3Nn5ypzCAoD1qnLxq+oit+pUSc93BlfsUrjmsyvrkKPuLV0ejdG2AIMqB3GMEoVnr4Fd/VBJka+LrmEjsuP7Mm4UYgIxvEM6kiOZcpqco9zjp7++5/G+J127E3qn49Zq0NEoKpXJhG8UfCSH1p/msQKSkGAsnbjL19M/C3jD3N99gbGQjJGlCWX4iHOkawYtP8hhajDWn1srw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUxv/2uJqXnjl4YsMy69N/t57OyCEVJdusMXo8Mlfsw=;
 b=MSK/iJWl7Tij8tix7Pm+O9JWylSb2Prw3oRmG3Ng6MLDPrT8YhGH/eY61cZVJjF1qonbzFRcyB6zt4SeFP4ZOcWnaHpPGggTDVX/xizl08MU2fYOSOgeE4sqEzkeymxTRQSr9MSoljiMFg1H8IsZ1KV16jD9paLrq2DaC9aAb8E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 15:11:15 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 15:11:15 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Fix SVM_ATTR_PREFERRED_LOC
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211101125513.999187-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <02ae4372-e250-504e-d7dd-5206596e9be5@amd.com>
Date: Mon, 1 Nov 2021 11:11:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211101125513.999187-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0327.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::8) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 LO4P123CA0327.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 15:11:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfec1caa-9730-418e-a8a1-08d99d49d8f7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5247D76CA5A2EF2059353163E68A9@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8J9IUFsO3zEm0mvvFZaHR9pUC92jDFZpuCskvya375qgymOuSmqrKkocMhVFK9qMcDm4Gn6kmxUsg3bnfS1iudazJAKCF6lWEOUqQfhiC/6LcUnGEWRXO1dWa2Ibx9mlIcCFYVzMsLZ5ilopqkyddHjDADd+MNigb2tDmu230ContdsslrFYfXWbH+YxARgHmFWNehIL5v5YM1y1BoRk+IPevPWk0Y9DYVK+Q0X/6RpyE5pz3hbyMtCSrOhLH/+aa4xtbLFPDhNf8i57E3pzDDfKn0zGuAAoUfjqzMs2n6g+lC3+mqKfkF4VX7qK2Emz5QAh2K2kWm5y2CYekPAN6xIPJ6mkoqm+VNwOQ8PKgFgX3ba/B3CicNI2JxTL50d6es85oNbA6nHk5YZDw4u8ONRieMpWLvTNsDBID893paReV9+rYbd8W0h0QT1zHfYiAaw85tWmL1iznrQvAUWAgIKT12wJUV5+eaWPtY303b7XHtNDXRjPJHkbMsGcjWkd8UJkG+j8ARQctW2AjHIk0gvF3VgNeR44uLC7V6TEPdHQF6Pt95c6DDHEoZNzUNNcj5pcimt7OxvQlxZ5coDo7EDXTuHK3lpyxcbHXW5ZSiFJVxopLJ3C7GeEQgysO6mCya5aue8/PHUcLPa/hXAYb+5f3VE94dLkpbGIBZWcfjrLF8WEDvrzxT0Kx3xRY2pdfDkuj8wsr2kv2MVY/BXJI1nmcCSOnyH+2dRQnmExyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(66556008)(6666004)(66946007)(66476007)(8936002)(4326008)(6486002)(31696002)(2616005)(956004)(16576012)(316002)(83380400001)(8676002)(186003)(26005)(31686004)(5660300002)(38100700002)(2906002)(36756003)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnNoZHFyelIrTWtzSmN2VFE3NXJhZkZ4dURkemc4Wkl5Y3JPVEx1TDZMSXQr?=
 =?utf-8?B?QTgvN2EwRk52MFg3Z3k1T1c2NUJ2Y09adkY1OXdXUVg2UTBFWGh6Q3JZbUli?=
 =?utf-8?B?UXhJYXJuRmtDMGpMUTk2cHMzVjU3U0RJQmtqNXRHZVFFU0M4TEU4NUVndWRl?=
 =?utf-8?B?MDUvT3hObDVoM1h0ZjZGTzY2eUowQ0ZXSjR5aktPQ2hnYzluYjUwdnp2WXBO?=
 =?utf-8?B?V3UzaGcwdnQwNWg1d01zWmZQWDYvZ2FvbkRLaFE3UDA0b095N2tFbjlWa1BQ?=
 =?utf-8?B?bjNWM3lmaUlUSlQ4R1pjUW02MG8rN1FoRE9iNlBQa1hLcW9PcEJkUnZpZTli?=
 =?utf-8?B?N2pSdGpwLzk3anBFQVBqL2toeVN6eGhRRkdjbVJVMFdqVHIrWE5MNmQ1WVRo?=
 =?utf-8?B?VFN0czNOTFAvSitKY2N6NTU5NTBnMk1tcGNkdlo0MzFFcC8xRHNDdFBvZWp0?=
 =?utf-8?B?YWYzVDRJTGdoT2NkVlVMY2pmYUdkcUVsZXR1L3VkRmhtYkdvaXAzZDhjNkFV?=
 =?utf-8?B?RVFmY2lLcGk4cFcwbFE5d2l3SlZpWXVLc0k4bmNpSEoxTWYxZXFoNyswZXd5?=
 =?utf-8?B?dXJ4dzlyNk9aLzQ1aENqVzV4VC93em15UGlrL3B4SVFtRFNIcEpIUytGVHky?=
 =?utf-8?B?bTUreXBnd0ZBQStEMkdabWNhdko2eFZSNVNyWlVrNHZDMkpQSU9BNHRzc2hH?=
 =?utf-8?B?QTgrOHFsa2g1MU1tb0QxYmFVNlhha0M0eHpjL2l5R2RpanNvYWdRZGNVVU90?=
 =?utf-8?B?dXN2bnhGVG9uMzdXV1lvNGpkY1pEYTFxdWNZSkkzTUR6ZWhGS0pPbzJWaHI3?=
 =?utf-8?B?Rk15TlFqQVVXVGR6TCtYc3AyYUZGS0RyZDJpenpVT20rL3hidFBqZDlNbnAr?=
 =?utf-8?B?ZG8wZUFpalJFSHdZVFFGVFdZZks1NmMrTkFaZ2haVlAwYmJSVXNkWjNrem42?=
 =?utf-8?B?MExUMHQ2cGplTjREWDB4VUdXeXVGazVIWDZIckxmQ1BTWnFJSnB3QjJBQWha?=
 =?utf-8?B?RHhHamZsMTVRMDd6N0dhdE9ObEsyMWd0K21WTTZLaU1IOXBVM1F4c2JmNEw3?=
 =?utf-8?B?dk5vbll3a3RkakhiY2J2Vlg2OEVhZlRwaHY0UFlsUzVnbk5QUW1GMTdBOVRD?=
 =?utf-8?B?LytQU2NHV0RETWxSNDJJM0xQaHlDMlpJTjhwR2NscUZRcE9UVjNCSDE0eFEw?=
 =?utf-8?B?MWZjdWpLbWpwOGFPNFNsK3NoSDV5SFErdTA1UDBjaFZqL2R6NlVQWXd1cGZ0?=
 =?utf-8?B?SEpsd0tNMFQ5Z3NBZDVETDBNSFRjaERmQTZBOUtsdTdDN3QyT2FsVXBDL2Jp?=
 =?utf-8?B?YTJ2QW5JU3VaYVhXYUwrTGZUUUpaSDd5N3M1ejQxcW80RVpWTUg1WEJYME9s?=
 =?utf-8?B?cnJtSGUreE55MDV5UkRvQjJwYVRyUEY5N0lOb3pnRHZkMHRDTE85R0JVcjNx?=
 =?utf-8?B?eWtCb2xsUmZpZTVlOXpvOS82c01ob05hekhYc3QwQ2k4aXhrQ3REUDRTY3gw?=
 =?utf-8?B?b0kzYXNWdFlrcW9DR2R4MFE2QVY3VDZpUmFva2JjWEZhd2c4K2hOdzExWVlw?=
 =?utf-8?B?cy91eXJHR3k0Q2JqMzliVWkvMitKTWR0TmlpaGtYRHZRQnBrTEF1MkQ2Y1Vl?=
 =?utf-8?B?Si9sL2xHOEEyL29JbDREcUJ2QWtIUEFtT1I4cnpLak0vUUx4T25hcE9zdXlp?=
 =?utf-8?B?SEh0R0lpSDF3V0NFM3FGR0p2THdHUi9HemIyYWgwWkpWWEVSUXd4RWxaU3Q5?=
 =?utf-8?B?cVhsbVVvZk1LcmNMRU9RNDlvVEZSTmIwVmJkSVRuelJlNDVHWWF3UXU0dTYr?=
 =?utf-8?B?YkJmS2ZaSTV1VlNQQjg0VHhEbnBwdjNUdndwZDhhdjVncS9GV3JoR05BQllV?=
 =?utf-8?B?dnVNd01tUVNlNjB0TkFTeDZBZnVML1dqMTBqaXFEaHRNaWwrTXZTdkVISkxB?=
 =?utf-8?B?WU1PdTR5bTFwUjQ3YzlKUEN2N1JwK0xwSUdhU1dUelloL0JuK1pNYXlSWFFU?=
 =?utf-8?B?Tkw4bldjWmtDWDYrZEdTZEpjTEozYVhVczQvazBJWGdvNW11b1ZMUnNRaE1m?=
 =?utf-8?B?anNacWY1MHRhNFdZbDQ4QVFkVWFwYkFuM0Y5NmlIWE11M1BSdTRuWjd3YUw4?=
 =?utf-8?Q?fX/M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfec1caa-9730-418e-a8a1-08d99d49d8f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 15:11:15.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufZnW5Lp44AgQ8q1wrSvngCGpRt5C14WUOmGF6yL0QfHTLRukEjhXN/Oo0/bcUvv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-01 8:55 a.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211101125513.999187-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">The preferred location should be used as the migration destination
whenever it is accessible by the faulting GPU. System memory is always
accessible. Peer memory is accessible if it's in the same XGMI hive.</pre>
    </blockquote>
    <p>This patch series is</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20211101125513.999187-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9a46ba190ea7..8d37ee755b34 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2250,7 +2250,7 @@ svm_range_from_addr(struct svm_range_list *svms, unsigned long addr,
  * migration if actual loc is not best location, then update GPU page table
  * mapping to the best location.
  *
- * If vm fault gpu is range preferred loc, the best_loc is preferred loc.
+ * If the preferred loc is accessible by faulting GPU, use preferred loc.
  * If vm fault gpu idx is on range ACCESSIBLE bitmap, best_loc is vm fault gpu
  * If vm fault gpu idx is on range ACCESSIBLE_IN_PLACE bitmap, then
  *    if range actual loc is cpu, best_loc is cpu
@@ -2267,7 +2267,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 				struct amdgpu_device *adev,
 				int32_t *gpuidx)
 {
-	struct amdgpu_device *bo_adev;
+	struct amdgpu_device *bo_adev, *preferred_adev;
 	struct kfd_process *p;
 	uint32_t gpuid;
 	int r;
@@ -2280,8 +2280,16 @@ svm_range_best_restore_location(struct svm_range *prange,
 		return -1;
 	}
 
-	if (prange-&gt;preferred_loc == gpuid)
+	if (prange-&gt;preferred_loc == gpuid ||
+	    prange-&gt;preferred_loc == KFD_IOCTL_SVM_LOCATION_SYSMEM) {
 		return prange-&gt;preferred_loc;
+	} else if (prange-&gt;preferred_loc != KFD_IOCTL_SVM_LOCATION_UNDEFINED) {
+		preferred_adev = svm_range_get_adev_by_id(prange,
+							prange-&gt;preferred_loc);
+		if (amdgpu_xgmi_same_hive(adev, preferred_adev))
+			return prange-&gt;preferred_loc;
+		/* fall through */
+	}
 
 	if (test_bit(*gpuidx, prange-&gt;bitmap_access))
 		return gpuid;
</pre>
    </blockquote>
  </body>
</html>
