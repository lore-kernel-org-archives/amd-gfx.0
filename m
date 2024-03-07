Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B230C54E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 19:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7A211204A;
	Thu,  7 Mar 2024 19:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LFOhDMdE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED2411204A
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 19:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3hrIIbj26pqHsXwnOlIKxKl/OuZ2TQshELpbezxvuVept92XQhtNEg0NgDO7fCd3hpuNpZrtm8Z3Alhm0HQtp7RM188okCReT59eXjP0iJzbFqgCJWcZkoGuLN9OQTdgYiVfGhzBsMaw+M7M5SFA5N5fDV5kpVp1c5bwoRgBEtP3LXebeXXNx1aVRHI/8HRN4FUAcML1dTALHGzw60MNP7u7reQuliGw8EM9SVaj15Sd7inH3e0ORWnw8LYGflvJKtqaptLg3ds5WK/6BXZcfDtHqbqJCBkY7hn0SSiouX3O0VC5nT1SI2e62P3cbTAbMHAGN/YdbMN0nqtTzEZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMqhkckDHUiF0kdE8ZIrn+5ebbc9xbMD4FVSQyUl0HQ=;
 b=X0taLLoRDblYyfUDBnQ2KRfV2B16RcVlBcqx6BzPE+KVkP9r4paLk2M+gLAEOxxdPWI2GyG6DmxtsfVC06H0BrqCHJjst5cvOy//awMDXupi/gQAz99S6LdcKz7nE4Gus1V0nTk4HvzzCYXkL7OnpEfoyApWPDNnniBvwS3pi0qbnRUgFFsCK6xgPOXEckuG/RFCTCjj6tNP1b6t6rkkMXvM+9IVSpkjbvojm5G8jm5YxX1MQNgkYVLQjTjQmXdxQOmuisS/h1SWoY573FNlSyRQH0+z/seOa2JDe1wqzptG8LOuzoB6dgu6Yuee9EiFsKtIlFVVNy2EJljTeX4nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMqhkckDHUiF0kdE8ZIrn+5ebbc9xbMD4FVSQyUl0HQ=;
 b=LFOhDMdEPVvbuRAXEGSiq5DG7+wQXD00isef+HUK6x3Bl3ZOGsRxrBQ9Hd2qt9USHbcXGSs8n8WUO1FmTWR9rC+84GlyUg0Tisjt5KJyHOfrnrDvK4tUzc2W7reIYesHG+D6Ark/+0w7PnP9Mr4Y2TMzvmosm9mxxtcBRq8IeEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 19:22:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:22:48 +0000
Message-ID: <939a8f23-952f-8993-9c1c-178bb0fd42b5@amd.com>
Date: Thu, 7 Mar 2024 14:22:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240306144115.1007-1-shashank.sharma@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: d92e61e0-3141-4e4d-0a43-08dc3edbf96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksCEnYS13ycbM6T60kftfT1kDj+Un+Twft2TeCzK51lokXq2aH1R8M9jrU5IwEV9krcymMTmFhOIqkFgGpCH/1iKXtGSbjOUX14KvqoG3or9hTBLZE4B6RBIGV9TkVBQMKhLsvcwuqFeV8AjBhlEbuNY85U+VgKX1I8t0u5LaFkD1gipwqa9Edwh/lTZAqswwQ7Xc7AQ/TvR6Y/fjyy2iM9svDQSZ5FsClsBgohuy9juBaIvySkSUIccaPkFkC4W3cVECISYyS4TdqQMoHwIF12ab6SbjZdMw9mPM6a57x1GwP2e29dX8z6SW4WkRJoZJfeqrZW/BJVo/Lot+ERQo0PWRBVehsCn24kkIIfWta0bWk+8fM2pk9uV0dVoDjcVAFzTVvNBAoKEwrF+BYtB/u3CpTXlVoXPyTyl6FcPKgsjMetVJ7wvr5QtpkuqYSqzgpGVikMWbTf6wC5hMxP59ccWAvaaqR/4kvU02h8OpZ8dSmVOYeHveWJqeNI8BmD1hTcwe3Y+VC2+IlI5Bhn2GJlD0GQ457D1/eCfRLh2xTm3MGTKXedqT7VgdzuwBHU53YeQYpAcGbDiPZKm1Ls3o4IpOALIpHO/IKHr7bomnjN+s9F4eCu/YReXF9/KeZndiucDZ/dsr676rBfy10ZQtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzhLSVBWL1VEVmx4K2JCQUUxUVhLOWdYYXBET2NNeWhwbmFrVGlkY0xJeTVw?=
 =?utf-8?B?Y3VrQnZHeXVIRnlvZWRFNFhlNzNqZndjREpRV1hoU1FRdzF3ZWxxSjhiTHNh?=
 =?utf-8?B?Zy91ZFA3UFFHK0RqajBLSStoblBVYmJGOWcyRHdXMVFyS3VRWnppM0JXWHRs?=
 =?utf-8?B?UUR2NGI1QTFsMWtwVExaVDMydUF6V0VQb1RtbmlGRDNVYjMrZGNCSHZlb1Yw?=
 =?utf-8?B?aE9JVXkrcDBGS2F6cDZUZHp3ODljS2JwWWlhN0MrMEdJZVZLbDc5NmNGRG9s?=
 =?utf-8?B?N1Y2UlZ4RVhDeENKa21FbWVQN2RncFdBY2VEQXNCNWdPa2ZzT2dZN2FkV0Nz?=
 =?utf-8?B?NWl1SjY3UnlUVldDZG1ybFd4bmx3SFVvdHIzQmtQWHBFUlRTQUlRLytjUlhL?=
 =?utf-8?B?dGR2UjEwbS91WUw3QytodWlpM0VhYnpEY3dIZzBNQ1JEVUk4Z1kwcDJXdUor?=
 =?utf-8?B?VElHekordUlKMlVzczBucUtmaGZ1QjNKYVZLeXh1blcrTlQzdTZJZDhkcCtl?=
 =?utf-8?B?eWtJckV0U0NUOWh2cGMwZ3VhM1Iva1FoYi94V2g3NTdUVGdoZlkyYUdkNzdS?=
 =?utf-8?B?RzFiN2FkVnVZNTEzMFlMdTZITHdjY1pKeGJQRHpVbE16V00wQlBJSC83UWoy?=
 =?utf-8?B?RmVBbnFtdVlDNXl6K3hxalNSdXl5UzJLM0JJeUFZelJFQ29QQ3pHSnhwS2FP?=
 =?utf-8?B?eWJpeXhLdnNjN1pwY2FWL01oa2pFSExDL2xIVS9RRkp3bjN3cmV5SEZRTGpu?=
 =?utf-8?B?dkJIVU00Lzd1bHhYbzNOMzc4UDdwV3ByQXVUakZYazBGRGt2K2FUS1d1bitI?=
 =?utf-8?B?bGErS0JxQVdVQytLRlJiTzJjL2EwZXphSUllVTRpb1dHU1plYkRlbHNjYUJN?=
 =?utf-8?B?cTh3OUhzVzJxQ1FYRlRkLy9JdHRyYUVPVnREdlJXVkVxRC9UTVkrTVIraUFv?=
 =?utf-8?B?cjB0dlMvazE0Z2lzdnJVdW42WC9VM0JHYXdrS2J1ZmNpWThBRTg0RisyaWl5?=
 =?utf-8?B?YW1BYnJIdXQ2VzZmNTkySjJyT3U5ai9WQzgrWGpNR1JCZWJsak84Tjdwa0Fp?=
 =?utf-8?B?Zi9FTFZJeHdQckZEYmFOR25RdU5TRFQ2Z3VGZUovRnJ1ZVNHTnd4L0dPZnAz?=
 =?utf-8?B?Z2lTT3gwYmRXbU9hcHp5ZVhtTWZhSEpDMTJDUVJoRWNvZGNtNTZwQktpcGNx?=
 =?utf-8?B?TkI0OUpXZlJPRXFYaE9GWTMzSTkyTSttSCtlQmxVQmNQMjFuUTl1QUkzYk94?=
 =?utf-8?B?V25YSVNQVnBqMkRPVlhGZDV3Uk1QUFQ0Uklvemc1c1R0aERxN0ZWek91ZTM3?=
 =?utf-8?B?V1dFR29IY1NteHVEWlZhMVBhdjdUT2FOMjBPMzlvSUNQR1NpbTNwQVNHekl6?=
 =?utf-8?B?L0VlRFlwUHc1YXJEc0FOMzllV0VucUIvSDNtY2htRW1zNnRVejVyZWFieENH?=
 =?utf-8?B?bElMMzFCQ3pRc2JOZG5sSTNnOEtyd2FtdVJiRkpBQWY1Z3QwaHVZalFBMTRt?=
 =?utf-8?B?UGJyRW1RQ040ci92U2dwN0NmTzIxeDVWOGdaZTFVY0Y4OXJJaUh2azRRa0dG?=
 =?utf-8?B?QnozVzdaU0ZXZ1B5Nnl5b09WV2xpSWt3czFTRHpLeTZHOEVjaTdTeVJqZEl5?=
 =?utf-8?B?MlJxMVIvWVJvL3p1c2VPMWJYMzlNQ3BNSVNVYTkzQis0dDZ3S29PK0x6cGxD?=
 =?utf-8?B?T0hwS2o5RGVYcldmcDFGQUFZN1oyL0o4THNNT29GL05yOUVZc1MrNEVYalJm?=
 =?utf-8?B?a2xpMXRKRXQ4TWlxb0RLdzdrSE5yamtGNXpRc3ZYUkxvVS8xSVRlYU1HZzFI?=
 =?utf-8?B?SVArL3Ezd2VPSGFYcld1R3ZKc3BMbXlvRGZYUnJLUlZTQ2I4eGpoU2FJZDYz?=
 =?utf-8?B?Vi9BcDc0OVRmVVhXbzhVdnB5SkZhVlhYTGFMdnc1MkJ1RlhnaEZUNGdSOTli?=
 =?utf-8?B?ZjhGSmdGZG9MZGs3dWR6MVloeVR2NDZUM1dmNmRod0lZQlFiRVE4WnFWVFlu?=
 =?utf-8?B?dkMwcXpVN2hETWxpbFZ1NWs1QzlEbGRycWl3U2VTanVkQy93akZ2b21lYVlz?=
 =?utf-8?B?c0MvUUx0MW1KMUpnRVN4QW0wdG8vOHJIMG5MVHlpNExBVys4K0VreU9JS2dw?=
 =?utf-8?Q?my9E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92e61e0-3141-4e4d-0a43-08dc3edbf96d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:22:48.4637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl9gEg3KORfS9F8mAcGI1uZvrO2OchYona54RdLWIUKIUV/6GiGdunn5ef3VZRlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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
    <div class="moz-cite-prefix">On 2024-03-06 09:41, Shashank Sharma
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240306144115.1007-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>

The problem is that when (for example) 4k pages are replaced
with a single 2M page we need to wait for change to be flushed
out by invalidating the TLB before the PT can be freed.

Solve this by moving the TLB flush into a DMA-fence object which
can be used to delay the freeing of the PT BOs until it is signaled.

V2: (Shashank)
    - rebase
    - set dma_fence_error only in case of error
    - add tlb_flush fence only when PT/PD BO is locked (Felix)
    - use vm-&gt;pasid when f is NULL (Mukul)

V4: - add a wait for (f-&gt;dependency) in tlb_fence_work (Christian)
    - move the misplaced fence_create call to the end (Philip)

V5: - free the f-&gt;dependency properly (Christian)

Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Reviewed-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112 ++++++++++++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index fa26a4e3a99d..91ab4cf29b5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
-	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o amdgpu_pll.o \
+	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_vm_tlb_fence.o \
+	amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0960e0a665d3..310aae6fb49b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -988,6 +988,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = vm-&gt;update_funcs-&gt;commit(&amp;params, fence);
 
+	/* Prepare a TLB flush fence to be attached to PTs */
+	if (!unlocked &amp;&amp; params.needs_flush &amp;&amp; vm-&gt;is_compute_context) {
+		amdgpu_vm_tlb_fence_create(adev, vm, fence);
+
+		/* Makes sure no PD/PT is freed before the flush */
+		dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv, *fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+	}
+
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
@@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_init(&amp;vm-&gt;eviction_lock);
 	vm-&gt;evicting = false;
+	vm-&gt;tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev-&gt;vm_manager.root_level,
 				false, &amp;root, xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 64b3f69efa57..298f604b8e5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -341,6 +341,7 @@ struct amdgpu_vm {
 	atomic64_t		tlb_seq;
 	uint64_t		tlb_seq_va;
 	uint64_t		*tlb_seq_cpu_addr;
+	uint64_t		tlb_fence_context;
 
 	atomic64_t		kfd_last_flushed_seq;
 
@@ -594,5 +595,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct dma_fence **fence);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
new file mode 100644
index 000000000000..51cddfa3f1e8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the &quot;Software&quot;),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include &lt;linux/dma-fence.h&gt;
+#include &lt;linux/workqueue.h&gt;
+
+#include &quot;amdgpu.h&quot;
+#include &quot;amdgpu_vm.h&quot;
+#include &quot;amdgpu_gmc.h&quot;
+
+struct amdgpu_tlb_fence {
+	struct dma_fence	base;
+	struct amdgpu_device	*adev;
+	struct dma_fence	*dependency;
+	struct work_struct	work;
+	spinlock_t		lock;
+	uint16_t		pasid;
+
+};
+
+static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fence)
+{
+	return &quot;amdgpu tlb fence&quot;;
+}
+
+static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
+{
+	return &quot;amdgpu tlb timeline&quot;;
+}
+
+static void amdgpu_tlb_fence_work(struct work_struct *work)
+{
+	struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
+	int r;
+
+	if (f-&gt;dependency) {
+		dma_fence_wait(f-&gt;dependency, false);
+		dma_fence_put(f-&gt;dependency);
+		f-&gt;dependency = NULL;
+	}
+
+	r = amdgpu_gmc_flush_gpu_tlb_pasid(f-&gt;adev, f-&gt;pasid, 2, true, 0);</pre>
    </blockquote>
    <p>To flush all XCCs, as this is a corner case, we could start with
      this to make it correct for SPX mode for now, with extra flush for
      other modes.<br>
    </p>
    <font face="monospace">&nbsp;&nbsp;&nbsp; int num_xcc = f-&gt;adev-&gt;gfx.xcc_mask
      ? NUM_XCC(f-&gt;adev-&gt;gfx.xcc_mask) : 1;</font><br>
    <font face="monospace">&nbsp;&nbsp;&nbsp; uint32_t xcc_mask = GENMASK(num_xcc - 1,
      0);</font><br>
    <font face="monospace">&nbsp; &nbsp; int i;</font><br>
    <br>
    <font face="monospace">&nbsp;&nbsp;&nbsp; for_each_inst(i, xcc_mask)</font><br>
    <font face="monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
      amdgpu_gmc_flush_gpu_tlb_pasid(f-&gt;adev, f-&gt;pasid,
      TLB_FLUSH_LEGACY, true, i);</font><br>
    <br>
    Regards,<br>
    Philip<br>
    <blockquote type="cite" cite="mid:20240306144115.1007-1-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	if (r) {
+		dev_err(f-&gt;adev-&gt;dev, &quot;TLB flush failed for PASID %d.\n&quot;,
+			f-&gt;pasid);
+		dma_fence_set_error(&amp;f-&gt;base, r);
+	}
+
+	dma_fence_signal(&amp;f-&gt;base);
+	dma_fence_put(&amp;f-&gt;base);
+}
+
+static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_tlb_fence_get_driver_name,
+	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
+};
+
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+				struct dma_fence **fence)
+{
+	struct amdgpu_tlb_fence *f;
+
+	f = kmalloc(sizeof(*f), GFP_KERNEL);
+	if (!f) {
+		/*
+		 * We can't fail since the PDEs and PTEs are already updated, so
+		 * just block for the dependency and execute the TLB flush
+		 */
+		if (*fence)
+			dma_fence_wait(*fence, false);
+
+		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm-&gt;pasid, 2, true, 0);
+		*fence = dma_fence_get_stub();
+		return;
+	}
+
+	f-&gt;adev = adev;
+	f-&gt;dependency = *fence;
+	f-&gt;pasid = vm-&gt;pasid;
+	INIT_WORK(&amp;f-&gt;work, amdgpu_tlb_fence_work);
+	spin_lock_init(&amp;f-&gt;lock);
+
+	dma_fence_init(&amp;f-&gt;base, &amp;amdgpu_tlb_fence_ops, &amp;f-&gt;lock,
+		       vm-&gt;tlb_fence_context, atomic64_read(&amp;vm-&gt;tlb_seq));
+
+	/* TODO: We probably need a separate wq here */
+	dma_fence_get(&amp;f-&gt;base);
+	schedule_work(&amp;f-&gt;work);
+
+	*fence = &amp;f-&gt;base;
+}
</pre>
    </blockquote>
  </body>
</html>
