Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C753C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 16:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4889510EA7F;
	Wed, 20 Apr 2022 16:51:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DB110EA7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 16:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jnxt58YKGqzcUgoCloWuIRpxNtoSzo/gHAr5pOD48UatdrWQklnIp3itqIH1vzHMSEf1YJv/xA5Oyjjyy8y+yLBdkHBNbVrk0MpDcFV8PUdnxPg3vf1hx2NjccdWPZ0sDgsCM25G4xZxHeFfGD+nOPkRyWDC1WahnGCnW4Dp49KZL2BiGbyQasBWqZ1CVkLVf3pVtZP8p/VxdlrLAdWZdt8XgC8AhHQHsSF5EIVXErGmjKImYwUhwf8obm0CtTP+EM3X3PyJ3MpLR30XQ+CpVaQFdQW4E6/uzQm99XDJCFSxmYLvAd7EZyUGTo9vyo5HrFlNmoyva9gs1Hiyg1efBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOpzomXdD3OBBkVqnaUSNjqqZY9eDe6xyoPAM6+aNMo=;
 b=Hbdl4xtYvMnylNZ1epDF5vPCVtu7+UXIWoO1xCiDbmOyUX7CLJg3O9UQ+yPHEnrkd9ScjB4POMuVy5z6aP2Rx32a9zDW1n5JLlm9OXMpVQ3zV2sCRtNP1N3yBRfRjtBMTzyGfZR2qfNqwz90Ony8XrQxTe9apeMn27dnlWKZVwgw4RabamWvGFZR2AsGPnBmGT3DTNpjN5ZxPbf1/d31rjQLEKIBDsezh0zBPh5wayEBHJwOXEXTCDnNbu0a9AGgHUH7CAUxYeOacr8I5GpONV5uCa1CXv+DP3pWnmBvxmqzv+L++nXhJJYSGpggVrdWlA3WwMNW3tTbw+yCeGzL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOpzomXdD3OBBkVqnaUSNjqqZY9eDe6xyoPAM6+aNMo=;
 b=3//xt3MqSuwpHpUloGcjL0ydIW9+muHdUcSeaLo8ypYu3CiFGwoczMn3Q5/sytmPtKCvkqEsLeq6GvfjcsrT0XTkR/I5WfOyrfnyN8O3U86w6IlGK0pXpscBlqRd3tAVdQcdXtvoBVwFFugDWl5if1xF4p5ccR15fPqChLTnoF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM5PR12MB1673.namprd12.prod.outlook.com (2603:10b6:4:e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.25; Wed, 20 Apr 2022 16:51:02 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f88b:ac30:de18:39df]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f88b:ac30:de18:39df%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 16:51:02 +0000
Message-ID: <da09f641-1a58-ca46-c243-c3cac5891ebe@amd.com>
Date: Wed, 20 Apr 2022 12:51:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Revert "drm/amdkfd: only allow heavy-weight TLB flush on
 some ASICs for SVM too"
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220420023207.1293007-1-Lang.Yu@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220420023207.1293007-1-Lang.Yu@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0443.namprd03.prod.outlook.com
 (2603:10b6:610:10e::7) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6d2e6d-2086-4373-2a84-08da22edf3db
X-MS-TrafficTypeDiagnostic: DM5PR12MB1673:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1673A519882885857587B88FE6F59@DM5PR12MB1673.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ7tHP4ftyPim90tX1IKsFZynovdycp+thzSq2TXrXG5exVfY5sn2CfaXkPKWP8PhCBWOLItV0UWdbM8wqAfSMz6xDxgidUNwZ2fgtvpeV+g09KEOQJIGiJxH5Sy+867obG6i3T28kxS/litQ7mawDhlq0ekU07jMM/6DmwtpOXbLyko6F2PaS7B3XUewUWspalkgqYBinO9TwqkaO33F7N+30UtMl+fYDZuLrsybD3F0/wyUu1n7bSn/R54GFueoXIodBKdxLQ2Sf0DKCixwcHtYfQLQohyGTQ5Zd4qPlwOwI9EVN6lqfZSVpUHI9XXcOLK7LCj9bLdl1+RVukENTiqTPIgpQ1A58GmNsxGL6C5JCDzsL6JAcyvSHn5Fpuv3SQUyuP28ywU/6tZW+F7XHfRiCloJqwrpkYMJWr4tvgKmmRJ/LFhF39mv9+KCIBdwGXnc8qqz8QstX87QvfaqIY9afjemHvN9Ii4Avgf578JLNo2sCREbzu6vaPyAWS/XCF+BKZImgtXtysNvkpqQTngTmioiPA/RBarbGz2wvMGOfFcHzaZbQ1UPShoth1VczuFKjJku3KOAUbq3Mimy7f8KDx7UX17RNai9ZrExZIVtNJR7HNeP5u7V5n+l+zS88aIIwJ2Ha2VGLyLGE8cqmt8jDqD/UMoUv9KW0lg0LpuqEG8wvoirpMAAY7f+wlIT4iCm2hMbQLCFqlrCO7/mfqXAEDwU2yy/ZF5r3MM41cCYWZTEi4RLghk4M7F4jMG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(66946007)(4744005)(36756003)(54906003)(66556008)(8676002)(316002)(5660300002)(38100700002)(66476007)(31696002)(2906002)(2616005)(6486002)(31686004)(4326008)(186003)(508600001)(53546011)(26005)(83380400001)(6512007)(6506007)(16393002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUQyS3Y1QkZFS3hvOWFrVDBiSHl2UTBiWU85SXFDOFBVM3AzZGw4UEMwbk1l?=
 =?utf-8?B?a2FjN3hKeXFnVzhscHhQOVBaaEhHdno2M2dtWkJqUW5zMUN0VENvZVhDWDl6?=
 =?utf-8?B?dHd3dGpNRTFiUzNQbDFGSWxsRHdPSENIaFhLWmZQT255SWxudkM0OC9CR3Ax?=
 =?utf-8?B?Q1o2UkRGZmVtcVBVdVBCR3dyQXJQaCtCMWxqSWMyaGpyM2wvNHc3RGJ5QlZq?=
 =?utf-8?B?WGZudWJ2YVZIcndmRGFGYlNsRUpLZU45NWFkUjJNbkNYUmVTSkRZS3krMFZO?=
 =?utf-8?B?WVRjUlVzd1JaOFgzUjl1c0JnK0wyQTlhL1ZoeFRQTy9tV0xPaXNtaW9kVnZB?=
 =?utf-8?B?QXhqZzUrNjR4QWVLWkQ4MUQzWnhSSkJsMEJIT0xEaXVtZ0hPWldMN3h4RVQz?=
 =?utf-8?B?VnQ3RkE4aVVvUyticy85WnNOR2VqT3RvbHI4alpPVmNxZWp3bUZpeXFUbXBj?=
 =?utf-8?B?azlFMWlrQkJaSGEvQkwzc000cmFQdUs0bWNSaG1heW5NL291N0ozNG4xT2to?=
 =?utf-8?B?Qk9Za1RlOHI5dzNVUWs2eHpWa2Y3c2loa25WN24xUWdmU3g4Ty8rd2xXTjFE?=
 =?utf-8?B?NnVZajE4TE9PZ24wbkR6N2R5MFM2NzZ4azExN2NzUlRBSExIeDBPWkxoTVlR?=
 =?utf-8?B?U2JSWFRvWmNjdEs3UExNOVl6dUdaN21iTzBkb2VGdHBmbkVlaVRLMk4rRlBK?=
 =?utf-8?B?RmtKQnBXYjlmNnRUcEs5YUlzMG1EYVo4WEJwQUtlU1F6RmI4VDFvYzJ0OEUz?=
 =?utf-8?B?UVZNRHZMTFdXejFaRUtZVjU5K2M4d2taWSsrTkxDVWxaajZSZGQreEFmU2lP?=
 =?utf-8?B?NWxiWDFaQ0xVYnFpU1MwWCt4WldMcFAwOFFzaXlqL1JGTi9JcTVYT0NIQ1VB?=
 =?utf-8?B?dVdCdnZuRjkrV2J6cnJzUjYwR2k1N1AvWG53ODVsM2VqNE1sbTFxQkJGbVNW?=
 =?utf-8?B?QndzbWJ4YTZncUR6bUJsYWdUcysreGJEZUFmNmpGZDl3OHlQb0JwdGxlVmdr?=
 =?utf-8?B?MzkvTnFWU0lRQmpBdWFCYjVRdkdhMWl1TEFibGdBUjdsM29XcTJENzJOTlJh?=
 =?utf-8?B?eEhOblg5MWdlTXc1bjErYTZrVXVGV3BBZnJVSWRFMmlkZXFGa0NEcDY3NzJK?=
 =?utf-8?B?bm9MUEtablJ1WXMxL0NMNlhNLzlFaE1GaWJscDF4ZDBncE1YSTVwdU9jZGNs?=
 =?utf-8?B?N2xweVBrME5hZUoyUTczMUZ0UzVoOThhNHg0elNhUE5taFg5QUticnY1MnhL?=
 =?utf-8?B?R0dLOEhXQ3NqeUJSeEtoWjNsQVIzWVhjMEdoSUFZVnpoV1VSamFDc0Ric0tL?=
 =?utf-8?B?ZzdmWXNXcWdKNm5PVXFTMms4ZVV4S3l5MmNmcEJVMzJOWG4rVWlLWCt2V1Zx?=
 =?utf-8?B?NTJmeDVweC9oU0ZiNDgwTFdxN3Q4UXNSWWxGckw3SDlxN3VCdDBSRk9UNWJa?=
 =?utf-8?B?bEx2Y0VqVHU1M25XUXEzWkdIWWQwMnhpNm05Q1VUbHhlNGh4ZDR1RTdOTjc3?=
 =?utf-8?B?TStQVEVMQVZzempXRDM1OTBwVDE3WEo2UUdpdy9uSExOMG5zY2NYZHVYMDIy?=
 =?utf-8?B?ZzhQN1laUTdETERNODhKRGVpeVc4YTYxQlRDd0Vnb3hBZGdtQlBuZFA0NEtU?=
 =?utf-8?B?bU9vWXdDY3FRdXpvRDR0OVRRODl6LzZhcDhjdXRlNDNhSnZDdEtCMW5UN3Fi?=
 =?utf-8?B?NWdjK1kxdmtQdGxCRkd0UEh4MXMwUXREY2d2WXc1QkxkYjNXUlJkc2Rpb3Nx?=
 =?utf-8?B?b3N2WjJKVHM5ajROR3NsUDRWVmJjNmFLeXZYOTBDY2lQekhWOG1XTWYxMDY2?=
 =?utf-8?B?V3NSYWswZFY5UFcvSElDZ2tzQSs0ejdlLzMxNWRnZWJjMngyRUlKekQvc0lK?=
 =?utf-8?B?WmVGbEN1Z0hpYmdZM2ZxVzVHdy9wT1pnSDRDVThQWThzcnVQKzhpVzNxUEph?=
 =?utf-8?B?Y3FNL2E4dnloLzNENEVhanZSZGJaRHVjUGFaeDk5cjJsUlFzMkNCQk4yRHVV?=
 =?utf-8?B?YmxxZHdlOHlUNlp4eDJWQXlSWUdyYXo5TS9FVWZwSU9qVXNsSTFTNTdHd2o0?=
 =?utf-8?B?bFc2eWRJWExtS3BFblZSYXI0cks3cElldHkvRDhzRko1NmE0d1dlcnNJTVg3?=
 =?utf-8?B?SjNtY3FGQVZ2dHVpQTM5YWVZU2F2cDBUR1NiQUxiMzd6a1V5WnhrSjRCZnBM?=
 =?utf-8?B?SHhtalgxZEhRUzhBWWNncndwamNEVy9RWm9jWStVSnJjVU5PNlJnUDlwWEJa?=
 =?utf-8?B?dWRMbDNEd2FkMFVMTjNHS3hKamh3bjJQUmN6VjBTeWJHUmJ2eWhBbE9IcFlS?=
 =?utf-8?B?MFU2S1VseFJ5aERYOWNrL2s1cDZiS2l4TGVWVWloMndoYnJWczM0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6d2e6d-2086-4373-2a84-08da22edf3db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 16:51:02.2054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxQrUighvjHmXNkAYi7nFk1DhTLRY3ttfr8lOOlbKhgWbpmNQM5J7XU0K0rFJogQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1673
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-19 22:32, Lang Yu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220420023207.1293007-1-Lang.Yu@amd.com">
      <pre class="moz-quote-pre" wrap="">This reverts commit a129dbca92edaeb5a515a0e5b63ada71cf9b981a.

It causes SVM regressions on Vega10 with XNACK-ON. Just revert it
at the moment.

./kfdtest --gtest_filter=KFDSVMRangeTest.MigratePolicyTest</pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20220420023207.1293007-1-Lang.Yu@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 5afe216cf099..459fa07a3bcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1229,9 +1229,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-
-		if (kfd_flush_tlb_after_unmap(pdd-&gt;dev))
-			kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
 	}
 
 	return r;
</pre>
    </blockquote>
  </body>
</html>
