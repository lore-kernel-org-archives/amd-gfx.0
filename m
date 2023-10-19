Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985CDCDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 16:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F0010E525;
	Thu, 19 Oct 2023 16:09:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A5910E525
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 16:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAa8Oo4zr5OpHqiQg9RsV+VNrwwRah90QYS8nYw6iTrZDyjL6T+5yOViMAu6rG9+I5T1B0rP62HVJ6uWp+19EyDOXDiRcaS/6T2BjK+k/DQ77/+gWDvrWGBswI7nv9YZ0KgX6CVHUkU6UxQSVyewfkTFdTlsv3ppaejb401bCM5jkTO3IDI7GSg21YnLA5dMNhMvksJCijRX/yRL7vNWa+ENmp4lb8fYCb4JQzUSsX96LY1rWhr6tUjZk0Jr58hnobb5qrI2EeehsdyLJN8QoTdDnivuxGwOo04usdLyczmkPTUUta+JQLRUFr1Bg/uj5MEO44Kb0YjrIoWDCES9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci8IRR4q2w7VuoA6M57vo0PbuxTITurm8Nd8FoSXlLA=;
 b=VkaG0lN2LSQNuHppMzAvYfFtOj4bn7NEO77+hwc0Z5KGzUez+GSWPONOvcJrremoOMUWb0x0eueKtb+RbJKAue3LA71WWLld4D7SOdeur328Fm3bKD9ow0jC+mVrgw9frbf7rszEcp/uggEPCY4Scc6leMIpVoo6/6yewuGQKB3gfnfACUQNQF8QyOQ/aIKTWiybKHHflIgQALywqnJAKc4rZMKlaIzjcx08MCeTj3lX5iZu1y+NzabV6M1roKM4lt+vGuubNOEALd6TUmynfMcRvnfi0cUTrhZoDBnH5Ls6eK15jlXLfO1RXwSeEYtx4aj40pmM2Stm6wd0hEynmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci8IRR4q2w7VuoA6M57vo0PbuxTITurm8Nd8FoSXlLA=;
 b=nB9EwWY4uE5WgKK4p3wH/cRBxT8c6K3GH8iVvCAjEYr42PcicJJ8rrrEfgPwydRj22cBkAnQHJjepKc1yJryeUN/uj7BGOs3nhIF1+J2QHkUL9vhIeqzWNcH4gm0q3KSX8trHsadXbqlBIpEymKH3IEN/e7msuMRvDmb9Ea6vwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 16:08:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 16:08:59 +0000
Message-ID: <9e5addf0-9e91-d67d-af6e-e89479572478@amd.com>
Date: Thu, 19 Oct 2023 12:08:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Use partial mapping in GPU page fault recovery
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231019142441.622430-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231019142441.622430-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: e831c9e7-b169-4e06-23d8-08dbd0bdb422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/u/8ZijKd8xWWwmH5PFiGhmb+F1i7mMBBAsNwRtDcsJRliqFyUOYmTgdVAHjsjnZ+jMYcxweH1euh9evpR0nmlIwL9Q83nq/8/o2j1fgw9wWAkElo7gyVnMJDI3ay/xjmldLKT/vGOMQlwiyQJQm310bLfn8Ww7ET9L9x3QSDG8L8Nmcm8WhXC8iV3bNuqnpBqVCxo0Qs54nZxnVffrIPMJrNtV5toNhWeRS9yJB1oK7cwLPBAZLlKJ1JAQGmVby+48qfPMC09Nz+ZQXPXyi73uwec+zXVnkV+rG8k9MaO7x5IBqySCwHpD7j4WUfcgW/kmcWW377DBTniFNZNd31zPwpqvYwhfwGCJEcBxFvlynH3MUoNF7JjvzTfDvrcB3Sc8WfxudvIoKQJ1fhx6fxVkvfnSVDtID8aKuNu+NgjkpBwxtJm3fEB5yZg5v6oD3lUvB6LrVAqFAThpDePU6aV1ONWeObxdccDVAQSfiIByj1PdaTr1e2sLXj9+aC9RM5Ux4Y45Bh8PygvFMQ3sxM5c1LPAhckjidTAmgzEE0pveRgR5S6ycOaEIBkbl8f/mkXiHbxsphD9iNALb35tVnq4Ods1u6ZwsG8sURdSPJXAhwVQpt1SYPU6QfUjrw0tGL2ZrcvdSTx6wO/meP6RhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(31696002)(6506007)(38100700002)(4001150100001)(41300700001)(36756003)(5660300002)(4326008)(2906002)(83380400001)(6512007)(26005)(53546011)(2616005)(6666004)(8676002)(6486002)(478600001)(8936002)(66946007)(66476007)(316002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3lJTGZ0L0hsNDl6MkxlOExQMTUzLzkzSlREc3U1dzByaHEyUnR2SWNDNkdq?=
 =?utf-8?B?RnowazFlR0c0YmtHVW9CSzRtSkhzQkV1aDdoa1BDUDg0YXppbEdldHZPT0lO?=
 =?utf-8?B?eUtaR1hnQnh2RlRJa0xNS2tZa1JpMTAwZUREaWtwbHpSRzFtSjhqT2dOVzU4?=
 =?utf-8?B?ZithSGhjYlV0KzFFR2swZFpYdWNSeXJpQzRIbGt1Z1RURmJoVTRWbnpWWW0z?=
 =?utf-8?B?VERDVG5qVEwrZWx3NTFpNS96eDhjYW5NVW9ldWFUaUNmVmZydVlPVkorM3c4?=
 =?utf-8?B?NmM3UG4xR3FoUjZBUmdKUGhQVXlZb0dMTHAxRzlUdEVPcVFWRFNNSnNKSndI?=
 =?utf-8?B?THE5RlFldjdlN1Z0ak5qeWFBRjJwYi9IR0NQdm5WK09ZZWdXWmVoN1Y5L3RO?=
 =?utf-8?B?TE1ydW1zOVpPaGlVRjBLdWNCRldrNC8zN3ZUZndOUSs1SHF1cUJLdUlsdnRi?=
 =?utf-8?B?MmM0MW4ydDRaRktoWVIzdUpOaXdwL2FqZ1dIblhhWFpCaGlKbDV6clord1lz?=
 =?utf-8?B?YU81UmFYdk5tODYzOENTdnk1NW1La0pOQW1XOHVrZld6QVpPcFZSQjd4dnEz?=
 =?utf-8?B?MWx5OVJXMXN4NjZielBSNEFaTzZra1JtOFdRNUVDakdiL3pJdG8zZHZhTUNN?=
 =?utf-8?B?NnJlV0tGS0dVTis1c1N0aTY1MzNmZDRlVkxUcVJUSCsrdDZteUg2ODNSZUpP?=
 =?utf-8?B?dFhjUlZudWh4TjZzcHVlSFpsVkd1eHl5V3FFOHZVOU1GZXpwQWFXcXZBWHpH?=
 =?utf-8?B?Qmh3aldKdys3VUwwaWUzckdycTVsMVRtbGc5UVEvUVAxRzBBcGZndUlsalBa?=
 =?utf-8?B?Ti9BeksvaEppcjBHZmc2QXpPY2Jad2trYjdNbGlpbEtMb2xCSWJtR2cvZlRC?=
 =?utf-8?B?elNNMCs0UHBwZUJVY0E3dTNxK0NOSm5GUGNsYzZ4VDhnWk4vZUdoandZbE5M?=
 =?utf-8?B?d2V0NE1wTGZIZzZLTFFUZmxndnozY3Niajd6Ulh6Rk1DdUgxaStyb1M2d2x4?=
 =?utf-8?B?cllCcmlFcUxLV3ZGYnhSTzc5bnZUNTVDT1pFS2k4ajZFSU5nMi9uRkdXVmFW?=
 =?utf-8?B?clhrTWt5T1M0U09OSmhnRHlHM3B5eVI1bnZucHdTMzJzaUlVNUg5L1VsSk9z?=
 =?utf-8?B?STBhTjU3K0w5NEVDdDZsU3VUQ1VGcUQvOVVvWk11SHdmaEwyWVkrWENRWnBW?=
 =?utf-8?B?UUs2c2ZRS0RTVnMxUmhYalBGZjU1bVhEaG1hWEV5U1d5dlE3UUxJc1ZHMWhK?=
 =?utf-8?B?L1FhaXhxMTZRTWhpY0tLVkJhbmFzZHowdmh4TVM1dkwzQ3ZUTFp4ZUFRT09J?=
 =?utf-8?B?eUVzRHhqcFdHcktXVmNNa09wakVDZHNUei9pQk1tbjkzSHVkeUptNWlmclhx?=
 =?utf-8?B?Z1FkY2czOUZFM253aXJTb09VV29taHFPNDZmdnhoVUw5aHRxNDFPWDdGaTli?=
 =?utf-8?B?ZGVkbEEva25zRy90ZG1wWnM5WUtFSlh6eEFSZWN5WkFJTlJsNXlKRHBaazlB?=
 =?utf-8?B?UTA4MDhabUJrTjJ1RnlLdW9vbjcxQVFUcXdaQTFOY0F2djNkQWdvTFMvZkNX?=
 =?utf-8?B?U2VZYjBINUhrcnk2M2ZyakpMY2R2U2JETFpqb0xnVWJFS1g1TGhaZWt0bTZ2?=
 =?utf-8?B?VE9HUDBPLytoRnNxaDZuRUQxTVVZb0U1cW5MQWU1VFYzYlZCTVRxZGw5T3lE?=
 =?utf-8?B?Rm1VRG1VZ0dqRGtTRk82clVGM0hjakJzclh5Zm5iRWFkYWNnZDVmUjlRN3lO?=
 =?utf-8?B?STd2MmZhYVg0d2hzTExnMUZ3eTd1TnExYlJ2dlliVlMzMUhYaWdMUjZpazJq?=
 =?utf-8?B?YTdLSVF0WVkzRkxpUzgvT1BvUWM3SjBLMlFPcUw2SXBpODFtczlhc05YcldE?=
 =?utf-8?B?dVRVVmdudHFKTTFYODh4WVpsOFEzMWhLRXVES01uWWpCcTJkSmdjWC9OMS9C?=
 =?utf-8?B?VWpBeXFqaktEOUpDZjZ4ZXFYNEJnSW1RRkthRjRXYWZpOGtKN2pXcTFJOURt?=
 =?utf-8?B?SGliblRKdXVuTHpLTHp3QSt2V3dyUExGSzFJRnQ5aVM5eFJyZHpNTmZNdlJU?=
 =?utf-8?B?cnlQMVlrdFlQTXpDQ3M0OWs0ZUh3Njh5SHRhN3NIUVp2U2F3clczRHAwelNl?=
 =?utf-8?Q?Gh68=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e831c9e7-b169-4e06-23d8-08dbd0bdb422
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 16:08:59.3580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3TAKs1TLN/z8TnCH7ta7hhxknXu8YrWlwKAF9S1UZqvGD3uQm7vzdg6Wwj1TREU
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-19 10:24, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231019142441.622430-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

After partial migration to recover GPU page fault this patch does GPU vm
space mapping for same page range that got migrated instead of mapping all
pages of svm range in which the page fault happened.

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 33 +++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 54af7a2b29f8..81dbcc8a4ccc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct kfd_process *p, int32_t gpuidx)
  * 5. Release page table (and SVM BO) reservation
  */
 static int svm_range_validate_and_map(struct mm_struct *mm,
+				      unsigned long map_start, unsigned long map_last,
 				      struct svm_range *prange, int32_t gpuidx,
 				      bool intr, bool wait, bool flush_tlb)
 {
@@ -1630,6 +1631,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	int32_t idx;
 	int r = 0;
 
+	if (map_start &lt; prange-&gt;start || map_last &gt; prange-&gt;last) {</pre>
    </blockquote>
    This is not needed, as this case should never happen, and you also
    use max/min to limit map_start, map_last below.<br>
    <blockquote type="cite" cite="mid:20231019142441.622430-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		pr_debug(&quot;range [0x%lx 0x%lx] out prange [0x%lx 0x%lx]\n&quot;,
+				 map_start, map_last, prange-&gt;start, prange-&gt;last);
+		return -EFAULT;
+	}
+
 	ctx = kzalloc(sizeof(struct svm_validate_context), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
@@ -1747,9 +1754,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = -EAGAIN;
 		}
 
-		if (!r)
-			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-						  ctx-&gt;bitmap, wait, flush_tlb);
+		if (!r) {
+			map_start = max(map_start, prange-&gt;start + offset);
+			map_last = min(map_last, prange-&gt;start + offset + npages);</pre>
    </blockquote>
    <p>This should move forward to outside the for loop, otherwise
      amdgpu_hmm_range_get_pages and svm_range_dma_map still work on the
      entire prange, and then prange-&gt;vram_pages update logic should
      be changed accordingly.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20231019142441.622430-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			if (map_start &lt;= map_last) {
+				offset = map_start - prange-&gt;start;
+				npages = map_last - map_start + 1;
+				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
+							  ctx-&gt;bitmap, wait, flush_tlb);
+			}
+		}
 
 		if (!r &amp;&amp; next == end)
 			prange-&gt;mapped_to_gpu = true;
@@ -1855,8 +1869,8 @@ static void svm_range_restore_work(struct work_struct *work)
 		 */
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
-					       false, true, false);
+		r = svm_range_validate_and_map(mm, prange-&gt;start, prange-&gt;last, prange,
+					       MAX_GPU_INSTANCE, false, true, false);
 		if (r)
 			pr_debug(&quot;failed %d to map 0x%lx to gpus\n&quot;, r,
 				 prange-&gt;start);
@@ -3069,6 +3083,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	kfd_smi_event_page_fault_start(node, p-&gt;lead_thread-&gt;pid, addr,
 				       write_fault, timestamp);
 
+	start = prange-&gt;start;
+	last = prange-&gt;last;
 	if (prange-&gt;actual_loc != 0 || best_loc != 0) {
 		migration = true;
 		/* Align migration range start and size to granularity size */
@@ -3102,10 +3118,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
-	r = svm_range_validate_and_map(mm, prange, gpuidx, false, false, false);
+	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
+				       false, false);
 	if (r)
 		pr_debug(&quot;failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n&quot;,
-			 r, svms, prange-&gt;start, prange-&gt;last);
+			 r, svms, start, last);
 
 	kfd_smi_event_page_fault_end(node, p-&gt;lead_thread-&gt;pid, addr,
 				     migration);
@@ -3650,7 +3667,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; prange-&gt;mapped_to_gpu;
 
-		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
+		r = svm_range_validate_and_map(mm, prange-&gt;start, prange-&gt;last, prange, MAX_GPU_INSTANCE,
 					       true, true, flush_tlb);
 		if (r)
 			pr_debug(&quot;failed %d to map svm range\n&quot;, r);
</pre>
    </blockquote>
  </body>
</html>
