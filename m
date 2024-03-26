Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF833C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 19:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D52C10F207;
	Tue, 26 Mar 2024 19:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FwcCpfKx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2114.outbound.protection.outlook.com [40.107.94.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32EB10F207
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 19:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRwVcQt58l6SF/UxvaGzfRtJKF5YYz93GdaS3gqzeBX3c/UB4MtI4btfRnghkWXLJN1Asji6gyMQvjI1s3In8Y0HQ0J2w/j8TP4jlKgzjNYp7ty5uAo0eGKeh8zJMvZsqhRu5swSyXHBK6adn1rSkubolWOZ/Rlo9qtihUsTioZAvEEfoMJ16fArbvDSjS6uxfOoMamLEUV9tBKg0cSgr6bXOYhM/UpKU1le4W84hBUmsB1OJQCP++dfKDzYUvDunAzyeSTQBoNkWqvZ558VR+MOY+adn8Ngoh0E7+fkYizDnD+pua9TQA4CAvQ/i96OCZXngUNPgUaNYnjaVP3Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzEBGI4WI06cWLFIu55xPgsqWGTX/eqNDvvmuKLkrpw=;
 b=Kheav/vPzbod/RRhes8V/Uk3YISW8wPupLZ+oarNzkKLcyLukbVhIeJqf4o9h6XHvCuV+UbWqH/w3lbP0e3IvHAET+Q+0F3DXNYj/65k0cPaRO6pQg0vg4GIAxVuLoIacCeYWntrM/Y14UhM9hIBF20UO/e6/0XGwraeCrSGZdInYQV4RYpQAs/KWy/k7vKm4WSmk/pAPvTU1QckYVW4Bwf74n08k+afW3mJuUdHf/vJVt8J36UfGbMyHhes5e2FmLIiqLjeyBJHdlXvskTFAiCfurUhOrN7U1pCq04PU0/zVK5qPE5iYFeCa0l754knQipaPxWRKzYocJhCubrFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzEBGI4WI06cWLFIu55xPgsqWGTX/eqNDvvmuKLkrpw=;
 b=FwcCpfKxn62tM1kwyUeVLRLBE3Rk58pKVL7mpIrm93v+jBcFNP6qrz2uqZ5IsqoItsUoldMKWb1CUVtKjir54r+wz0f/+XhWLamAIboNK6MBpVRwOh/6yozsmzysybX9M02W8Seol3hCH0ZL8+j2rLzriO8py+Y3FaiwKgRIFhk=
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Tue, 26 Mar 2024 19:06:16 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c94:963b:9aa0:78c8]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::3c94:963b:9aa0:78c8%3]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 19:06:16 +0000
Content-Type: multipart/alternative;
 boundary="------------NnapKVksXPKv088O81qBUVhG"
Message-ID: <503a183f-7b90-47da-9212-52d45cb41a5b@amd.com>
Date: Tue, 26 Mar 2024 14:06:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Cleanup workqueue during module unload
Content-Language: en-CA
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240320225248.754671-1-mukul.joshi@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240320225248.754671-1-mukul.joshi@amd.com>
X-ClientProxiedBy: DM6PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:5:120::38) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|CH3PR12MB9282:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pC2n4v/UOZo2tufz5Rb6CriBCXVH5FLro0gAxz2O/jySBHMka+4P6ATWAQvwaXP+D76qavCfM3CYlwfnYz94nqeGcK3FHAOFZZeGJYX82kvOBC4fPMAPQiuq0e9q2F5y2in1du0clUF2kwTbpcuPT6PoXrYXHg8QlkVPFi03XaTFZxDTazHNerpx614FfXV/jzUBFJpZqeoT7HblxUBbJwvHDB9R2d/Qhd3NvC7GU5IZlIhjN+GleXBddkmbhyngN5e4aW1VLjXRCIrsvmbcj7/bwd8emAmQAv6oWgnEja0MfJiCwhRnP7OJFGtAlWcQaz3JwqPtFeSeVANOzUssDvdsQ0Sx/jKKJBzd8caZTUxTIIcyyu29Q/6ByToUOv0UwGTIZ7osUl3YeSBvQdHuyKtU85IWSX6aVXXNUusCrUV/9Vf9gEVl5r0spHGM+CjSdUDXBRFpLsJ9cymwyN15Sd9Lkw6sLfJ6yebbMR1isqaZ3xGK48ejSTZEcjPuPbmWYvZ+oP1xwvMbm33TiT1yK8XFYLhFiAR8j4jnRXb4NzqIdx/xb38M5dUEoRXp/nHW3ew9+ENw0zs4M9ILJ7kERmsH+OCDlSfux6oHANYNdicE2XhCiNm2GYtY71VTiV3kUmYHkc2rfLTC/dv+TQ4hxcbVqaO2zwQDpe8+Z3qAm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BZanMzemppZFFzNWhoM3c0WnRyYXY4ZnN3SVl2NnY4WnJneGFmUExnbEZZ?=
 =?utf-8?B?WVF4Y3ZvOEptVC9RcWs4dXlManZoM3lvaXp5dTVmRkdITXMzMEJERTdSeEY2?=
 =?utf-8?B?dk9qd1h4NjBEbzQ5UGlRaWFkcmptbm8zbkdFNUxOOVUzb2dFc3BnNDUvK0sx?=
 =?utf-8?B?cmN1SEwyRTVOR1U0WVRmM2hvcWE4RFpaYy9ZRXoxMlQxemhkWEtLYXZEWFJz?=
 =?utf-8?B?ZUxxSjBGWXdRUUoxb0RqSThwZGJnZVhoTldtOWV5Z1VkQ0NKMUQxN3kzcERO?=
 =?utf-8?B?eG0yaEtKUGx2UmIrNHRHZy8yd1M3YlZnWHY5Ty9CTmFXdFllZWlSRnc4TWY1?=
 =?utf-8?B?c05ueTh4c2RDNmxMT2JyQndpekRmZ0o5TDh0NzFwZldVcjNBTW94dWJGMERi?=
 =?utf-8?B?ZzBzbXBXOGNIOGpUaFRFbUdXM1N3TnR3S3BxcURvY1U3bE5ubERiTmt3VC9Z?=
 =?utf-8?B?c0NrMjlOcjgvT0R0eGMyZ3AvWVFBNlN0ajByRzJsQWl1K0g1TlB6WGZ0QkEr?=
 =?utf-8?B?WTZjeU1JVEFSNThrM2x6K28wRW45bHdKb3F5Q3F2VGJ0NzhXb0pRaHcwL3Vn?=
 =?utf-8?B?NmdTZVhTOW42NVB2OWgxK1FtczIvMHBhRHEvRE5mM3ZPcXdFd2o0eTc2RmNo?=
 =?utf-8?B?bERxblpmVEF0Y3Z2RlRDMThDSEpGMHV3Y05VS0EvWE8xV1kzSWVnK2h2SjFk?=
 =?utf-8?B?OEtQL1Nxaitrb2U4VXMycCtaY2IxK003NEhoV3V6bzZyRklXWjEySkYwY2pH?=
 =?utf-8?B?a0UxRlB3d2lLRzhJS3k5NWhjaWo1WHFFY1NESjN3Q3R3NzVNTkxXR3djd3NP?=
 =?utf-8?B?RlFsV0RHMFNtbkZJbHZTaDR6VlVBUlhQbVFPWjlESUpiYVRaa3VmZ3V1ZjFq?=
 =?utf-8?B?K05KKzBxcEIyd1lqeGlydFFDWmNQak1YMUtRM3VENm1NYjdvWkZPdFFjNVBZ?=
 =?utf-8?B?MmEzeTRMd0ZXcHhrcnVhRWlkbUNYOE5FQWtPZURJbFl3VHVhaFBMaTBjTU5m?=
 =?utf-8?B?UVl3MnNoY3Y0RkkxTi9zdVdEdk1sQW1sblE4cklqOVBqV1k4Q3hUa2wySkEv?=
 =?utf-8?B?ZGltcjRSeDNNSnM4TStZS0oxMjBhbHJwNW1qb0RxSVF0VVFTUDVNZjZ3RHZt?=
 =?utf-8?B?UWV4MmhxNWZ0R1RJWGpxTU5ObVBvMDcveEpQbGhhNGpFNkh1ZFNBd2tDdFVL?=
 =?utf-8?B?eXNleC82RlFISHBXQkhPN3h4NXhnNi85cElZNCthQ3dUbEsrL1RoK1U1czJz?=
 =?utf-8?B?WUM4Tm5BY1MrblNyKzlTTzFXcUkxNS9BakM0SUxzaFg1RnF3U0xDUW8wQ3R0?=
 =?utf-8?B?MmhlZkF4OWtDcm4vTXk2RUpwNkhSNEF4S25uRGU5R1RhK1JmUWlzT21NMEV5?=
 =?utf-8?B?V3JVd2NZeDBteTZMTFpDSnBCQnNzT09hNXJHME1wa0pBUEtNQms1YjZ1SjRt?=
 =?utf-8?B?U2NhdUxOTHBPeUZUakxTNWpzK3RTS3hSK3BkcURPMTlzMWozMGRLK0RjcXFl?=
 =?utf-8?B?Uk1HTTd2QlJyeHR2cjRFakpLazZBYTFxNUgwb09ncG1oRVJ5bi9nMUgrdUNz?=
 =?utf-8?B?aEVoQzNOOG5mNVAwSFgvYmNkcjBSNVF2VDU1eElqUkNiekJVQVFsaThrQ2hh?=
 =?utf-8?B?TklNY041TWRBN0NYdGg1bFNYRU9zVW9zNmwweGJzeDMrYmhYQjBsbjluZ3lJ?=
 =?utf-8?B?Z3BxR0RKdlpSVUljWjZtdlRJUDhLYk9vZUhRVG5NenJQQm1pRlF3cUZjMzNO?=
 =?utf-8?B?ekJESWhnbWVDODRuSW9kNEd0SkR2SlBBTHNTcDVkOWJPVllCN2RBd2dtRHMv?=
 =?utf-8?B?cnpuSklJSUQvN2xGbkFVREZITnFQZGs2c200NTkzRVdSOUpSSGNRKzhqTDRX?=
 =?utf-8?B?WnFmTEF4RW1xdWJPNGQwUXBpWDhRaFNaVUQ3ZUpzdjZwc3FzSDhPbGdMczdP?=
 =?utf-8?B?Mm5TNmtadHRvT1RJK09xb3luaVFHeURxcENidjZkNVNQUTZibXVmdXZYWmpI?=
 =?utf-8?B?ZHhqdVlYcElJNTVjaFVNbFk1NDZhQlg4TTJjSUFuakt0M0E4RktTUHlLV0FW?=
 =?utf-8?B?VVpQT0JtM0ZyVEtwQll3TDVtWkFUNnhJRVNJMEk0Q044T0VoZ1NDNzVuaGps?=
 =?utf-8?Q?VbhI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27cac2f-0b09-4a3e-bd3d-08dc4dc7cfc1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 19:06:16.0249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sa6G1LlvuV1HEm2ZTaq4aTDqbsl0R1ygY5AVREYkg9XO4k/paq7nnwcYF9Ez6A6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
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

--------------NnapKVksXPKv088O81qBUVhG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/20/2024 5:52 PM, Mukul Joshi wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Destroy the high priority workqueue that handles interrupts
> during KFD node cleanup.
>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index dd3c43c1ad70..9b6b6e882593 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -104,6 +104,8 @@ void kfd_interrupt_exit(struct kfd_node *node)
>           */
>          flush_workqueue(node->ih_wq);
>
> +       destroy_workqueue(node->ih_wq);
> +

Here I think we should cancel work items that are still in the work 
queue, not flush workqueue node->ih_wq. In this case the kfd functions 
have been terminated, there is no way to handle the left work items. 
That would make work queue flush never finish. I think it is the reason 
there are orphan kernel tasks.

After cancel left work items we can call destroy_workqueue.

Regards

Xiaogang

>          kfifo_free(&node->ih_fifo);
>   }
>
> --
> 2.35.1
>
--------------NnapKVksXPKv088O81qBUVhG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/20/2024 5:52 PM, Mukul Joshi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240320225248.754671-1-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.


Destroy the high priority workqueue that handles interrupts
during KFD node cleanup.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index dd3c43c1ad70..9b6b6e882593 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -104,6 +104,8 @@ void kfd_interrupt_exit(struct kfd_node *node)
         */
        flush_workqueue(node-&gt;ih_wq);

+       destroy_workqueue(node-&gt;ih_wq);
+</pre>
    </blockquote>
    <p>Here I think we should cancel work items that are still in the
      work queue, not flush workqueue node-&gt;ih_wq. In this case the
      kfd functions have been terminated, there is no way to handle the
      left work items. That would make work queue flush never finish. I
      think it is the reason there are orphan kernel tasks.</p>
    <p>After cancel left work items we can call <span style="white-space: pre-wrap">destroy_workqueue.</span></p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:20240320225248.754671-1-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">
        kfifo_free(&amp;node-&gt;ih_fifo);
 }

--
2.35.1

</pre>
    </blockquote>
  </body>
</html>

--------------NnapKVksXPKv088O81qBUVhG--
