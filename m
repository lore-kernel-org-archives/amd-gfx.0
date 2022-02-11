Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0FBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 16:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2244910E270;
	Fri, 11 Feb 2022 16:48:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA3010E25C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 16:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibSlLZCM37tvi9NzZJ50A1m292Ruc+++FwVUxzH7TfEio6DfCiuamIKJQySIOjJDsuKC8NM7Gi/RqiRFXNvJmQM5fovcM39MApku1yu8/Q2eHHiR4J2UVuT+NrqkbmQz29qi/rTl5TFoiJ/4+KClMkbX9nYMwwP2ezXzi0QOWR7RAJoBfbOBLCn/OmUY6Jr8GLsLDB4qZacmSK0jRnGghZ9wDymEgAstT4Ov72J6ww6z9n+YYrIPuAe1PNAwWhxeT4KrWOa0fwEj+3xS8VTx4JuhKdALyZ6ztyTHE+qgNdZzCZWVhIHnmo6SPlQEOwB0S2MJJV1LA8cWROHwe2TXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMpXJQ58v8iCSpsTsSy7hu7gqCSU0YFVloSfzhyTQWg=;
 b=kfQ+u/F3DPUFT4VuT2Ki8+Gt5xLQBx+JtnilGhPiEQvcd1Jp8s2NO/bbdKifzZ4R4rBpDNk045F0PNUn4ImmetEpq4P2WOjaGJW2tIvZmRtyzxOdqukkFOobG/bupCUL45L5xY9KvLykceRQ1yotDsrDS3xgzlMabltGnFfeSzWve7heaivhogxF0jJ6oXSCaGXT0kIJiIa07HIrIw3tJ5N/2Fuxsdf9P8/HxpxycNv5VTui3c2oqt0AHH2R2C8d8zlJmhteCgSrirhFOvCSv3zZd34mUci8G82qvxQ7omK0lB19M6FftWJrn2fqDO0Ocov8wyQl1gswPsotBAiNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMpXJQ58v8iCSpsTsSy7hu7gqCSU0YFVloSfzhyTQWg=;
 b=Xeld7uDq+Kx3NeVDyDg+d4UsBfXC3AfWzePRgA0wAjKZPoQZZMxdsUEyE1IkbcX4wSVSg1BAY8lvKF7Ce3DmdJOomuxSuImh0z3MsnhIqK6k3dpfmt2H5RZ4ys+QYCzRgb4+61NnLceyzdrvAaDAlv0ePmbnpoNDhuVt/MeBPkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB4828.namprd12.prod.outlook.com (2603:10b6:5:1f8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 16:48:18 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::ecac:8946:43b0:c1ec]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::ecac:8946:43b0:c1ec%3]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 16:48:18 +0000
Subject: Re: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220210025902.32514-1-alex.sierra@amd.com>
 <20220211161758.29610-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <beb5fe96-51e3-b781-2cad-2d6d4b60465c@amd.com>
Date: Fri, 11 Feb 2022 11:48:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220211161758.29610-1-alex.sierra@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0312.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e21bcb2-e420-4f93-10b3-08d9ed7e4e36
X-MS-TrafficTypeDiagnostic: DM6PR12MB4828:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4828E75BDE47F3DBDA2A2782E6309@DM6PR12MB4828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bw1AJcTM/bt1TChVV/wXk+oCxhRnI1VOiusSaV+y7Bs7neEfbsYrgGHK5rF4sX+azle6oXVvy3fGGnYFXFLNyntVHh4354NQ8H/wLZogR3HnHPWAegKL8lqaLsP+sJjlRnyh460XRXQXAqOvKkTrWCZ2QouApVhlT7K8cTT+kYefy3fdLPWo6E0nrwcZO3DXHx3ftVp0y4VMhIjuU8+Ai0WTI2vrj2MDtP6L1ygvhVThi5xy2omzy6Xq3+USF7KOrgZabvhnyL7B8vBMDItKH7PS8cVQ0uJPMoewGJN8S08cLoPq3Q+VmaGtGzkT+ATYH5AoUnAWmQY84zhJRhjv50HF0eGyW21qHRJT5JSEatHN6gXo0w6E58B79q8C9ml/Ka+FHrb4M58A2IxKpomvx30Uepo0p/Ga47XUNIiFP+H5WSBkL42XdS/WNvy2l8NsNe44y0Xo1M08HXkQmx/ZP2bPWaNThjDvWtVNFaPUmiqg/92Y95zuaNI1pd6R/12MpBMg+rQ7u1EMrwegyFfzYqIi6zgzLlxwVTz6F6BmPW5gNoYsi6n4SLwM7YK3vZy/LWHVUQaJ4pIyJVJ0p6A8V5OKz15de4d3gzBorSi10s7/4vpy7DlQgxm3Mlr3YQjIDyaaw/y6AZJJnGXKSj9DtgMTaCxTls/ZhuDa0e0IiyQ4EsaGNxUGqRpMIGeb2gjuDxeXxsJJi7zY9ydiXjE8xk9fvXtvpZLpH8I0IVYiXFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(316002)(8936002)(66556008)(66946007)(8676002)(6506007)(508600001)(4326008)(66476007)(6486002)(53546011)(6512007)(31696002)(38100700002)(5660300002)(2906002)(2616005)(36756003)(186003)(26005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWpxYjdDalNKaDQxTk8yOEFud2FZSllwTUJ2RnVNRWdrWVpMbTVyV2hZOWl4?=
 =?utf-8?B?WldrTlBqY0RHWXRvNFNlNTdyWXFZUW1mUjA1dnVlMnZUUFpHMVRVRUVxTmhX?=
 =?utf-8?B?OVRXdkVZZXhGTTUrYm1wNmJyY04zZ2F1SmIwVGlScjh1V0xDTmVISkNhYmp4?=
 =?utf-8?B?SEVCdTU1c3NpRzlOSkpheGFtRnlSQVFPVlBSVHFnRU13WllQcmFzMXpCNENN?=
 =?utf-8?B?SWtLekE5SmR3amRsZEYvN1RiV2IzdzdPeE1mNEpuNm5hRjVYTVUvV2hmVGZP?=
 =?utf-8?B?Y0RPcGdaa1V3emYrWlAzVjRoZzg1YW9GTnJTZlVZcEtxSHNDU0tSeHZNY0NL?=
 =?utf-8?B?UUNSalBRSk1oczRWQStKUDBEZHhIVjN6a0FvK29nUGE3RkdXRWF2VkMwMWI2?=
 =?utf-8?B?bFd3cDA3RTZDSGVaSUxQUDVNYmFxL3p4UCtsNHdMSmZQeWp6YnFiWGNiQVFy?=
 =?utf-8?B?RzFsQ3RDSmtyaHNpaUl6c0h6MmYyKyt0aVBWRHJUR2llbmZWN21hYUhmc1VX?=
 =?utf-8?B?SU9LaVNBUjNPZy9SM3l6cUN3bC9ONkJHZk9Zbi9vbG13ald0bExCQUprb0hG?=
 =?utf-8?B?b2xQTzcvSXVZb3FzY1YrWVFTTjdaREVzSlROd3RDVWREN0ZUZ1pmbEJMVC9E?=
 =?utf-8?B?K09WY3cvM0JQQkpwNTk1WkEyeDZwSlVVM2RySHNkb0ZzSTZEenBFYzAwSDZ3?=
 =?utf-8?B?a2FIdzl3dlJkeTZVY2JhSXdNS0lFYjY4dks2UUZQd29ZMU9mdjkvVFNENUNK?=
 =?utf-8?B?UCtIcC9hMFVKTC92UzNxb0ZJZWtOUFE0YVJlaU9wMWNabFI4OVpXYjJKTWxu?=
 =?utf-8?B?TVd1N3hFWDZTQVB2QStpd3ZYS3R4YnhQQXJMdDgvYVlOK0NoS05KNCtmRlc0?=
 =?utf-8?B?VFM2Mmk2aUJiZ1Roa3BkWHoxRGdnb0ZRU0M1TUhkb1p0dHlhRGZoQ0FrdWFO?=
 =?utf-8?B?MlFwSUpVcWdRcDJscS9OM2hUY0NlWUFIUzl3U2dqSmFsUUdLME5hVUk0S3Nr?=
 =?utf-8?B?TExUSzI2SldaZ0RTUUFaZmdBK1FIUGlCeVlObFplcmtOd2ZYc2liNnIzQnN2?=
 =?utf-8?B?ZWgralFyeWxnalZQVzFRY2pCbUxraDVQNlhrTFdvUkV1SHJKMThJRU95YkNK?=
 =?utf-8?B?Q29uTmdIdlkzNmQwTWpZYWxTSWYrYmM4OFJ5QStWRVFNRmc4TTcyV1JUb1hm?=
 =?utf-8?B?N3VxMGN1cnNxWERmeVFBeEdoNG9GZzc4ZUhYUjFCSWVlWFZwaW51b0hHNEls?=
 =?utf-8?B?NDM0NENxandTSnFyMHNiZW42WFdhWi9IQXcxakVXODdmeW10RDRybUF1d05M?=
 =?utf-8?B?SDN4R3IwQ28zWjVmNG82cVdtc0tFUDVvaVl2eG85VmZYRXlxQXlhcFNYWlUv?=
 =?utf-8?B?dmtaQmp1czRtUkJDeUdkOVV0NzNLak54Rkpnbkp5SC84MFBadmFoejh6bEQy?=
 =?utf-8?B?bnRDQ09EVmM3NjJPOHJQL1B6Z3F6VEVhVWxQZkxJbVB5cWl6d1ZJZ2xNc2hZ?=
 =?utf-8?B?SDlEVWQxd01WQWxxZkF4U05kRnhrMXZuSEtlWGZRWlIwUkZFbWZZNXBNbW9O?=
 =?utf-8?B?LzZMc3grdFdTbEJwN0VEZVpHQmh3OUpCaXZwaUFGZ1I0c0JKVm1zVldSUFZ0?=
 =?utf-8?B?d1k4M2JSa1dSckxlREYvdmJwQkpaeFBnWkpEaEJObmxZMTMraWpyZTZaNy8z?=
 =?utf-8?B?d0V1S3JBNG0zbm41L0Y5a1dNSklBM0pnV3crMndtSVFTWGVLa2RyV3lEeTlu?=
 =?utf-8?B?ak5yN1BnYzFOZ29Nd21JVUZJZHc5RVVRdU9UUG52MEY2YXphWDZHSkhaaVpX?=
 =?utf-8?B?R2NZOVJGRnZwNjJGUlluaTk1YndjUkJDb1MwLzB1NGVEMnk2bXBaUnNMKzBv?=
 =?utf-8?B?NVlzZ3VkMk5GMVRYdnFrVjVrWkZENTEzSm5LQkZ4MTZnRFQzQ1BVK251YWpI?=
 =?utf-8?B?OVdnQ1liMFdBTEdDclpOc0JERUJON2ZGRURqdHhCOHI1eDVuRUNScUVIcEFl?=
 =?utf-8?B?S1Uzd0xLUHRBVFBJUmpMNk04M3M2bkNTTk1OTU5yVFMrTG10VVlrcUZZSlI2?=
 =?utf-8?B?a1J6bWdUc1ptUHJDeGIyM1d0K0xRU3FrdVhtOVBwSHlJajJCdGZ5Z1ZFcEFP?=
 =?utf-8?Q?EX/g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e21bcb2-e420-4f93-10b3-08d9ed7e4e36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 16:48:18.4713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZDrubZgPV3KCHevFq1YwAeZ7HRMx/NOOoRCISSTt62AKeYFftSXmCFZeyxeulAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4828
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
Cc: Felix.Kuehling@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-02-11 11:17 a.m., Alex Sierra
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220211161758.29610-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">Avoid spam the kernel log on application memory allocation failures.
__func__ argument was also removed from dev_fmt macro due to
parameter conflicts with dynamic_dev_dbg.
</pre>
    </blockquote>
    Looks good to me. Reviewed-by: Philip Yang
    <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20220211161758.29610-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 88db82b3d443..befaadc0e854 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -36,7 +36,7 @@
 #ifdef dev_fmt
 #undef dev_fmt
 #endif
-#define dev_fmt(fmt) &quot;kfd_migrate: %s: &quot; fmt, __func__
+#define dev_fmt(fmt) &quot;kfd_migrate: &quot; fmt
 
 static uint64_t
 svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
@@ -312,7 +312,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 
 	r = svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		dev_err(adev-&gt;dev, &quot;fail %d to alloc vram\n&quot;, r);
+		dev_dbg(adev-&gt;dev, &quot;fail %d dma_map_page\n&quot;, r);
 		goto out;
 	}
 
@@ -332,7 +332,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 					      DMA_TO_DEVICE);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
-				dev_err(adev-&gt;dev, &quot;fail %d dma_map_page\n&quot;, r);
+				dev_err(adev-&gt;dev, &quot;%s: fail %d dma_map_page\n&quot;,
+					__func__, r);
 				goto out_free_vram_pages;
 			}
 		} else {
@@ -612,7 +613,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
-			dev_err(adev-&gt;dev, &quot;fail %d dma_map_page\n&quot;, r);
+			dev_err(adev-&gt;dev, &quot;%s: fail %d dma_map_page\n&quot;, __func__, r);
 			goto out_oom;
 		}
 
</pre>
    </blockquote>
  </body>
</html>
