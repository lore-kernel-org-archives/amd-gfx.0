Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BC7C5478C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 15:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA0110E77C;
	Mon, 26 Feb 2024 15:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGIs3kCO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEE410E777
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 15:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhjBcz0POiKkPJv5IMptH5OGOsfUPH7TaJyM2++XHLN39mHuOCZ2JNFgnveZ2sftJQwSDCMMvkth+BdFxOwwnuJ6jlyLKjrTN7mQ9v5awa6xO3r6iDvmh3nJ9luaxuyEn82oPk57YbzoBohOueQXFjn/E5p6bYuaoWtSgXXH7HrxUe5tnLQ2prhtLJu8lOuEAJC/VPeoUVjhz/C2cuazQHxIW64aAqjC0XSbHXLqyjcgboxoyRRzudquxFhq09LUaHko1bxl23X8sfxc9RjrfbsVRVZ4kSewHkpKsjXCQQG6XGZdLDZXrTofSJxVVyxDbllOTCwLuqaFtBC6A1AoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNNLWqbZuMdsIFY/2mhoyGySFasDk5q7Z3f5jjG38K4=;
 b=ZrqTXeXPjdcn9rGLogRvq4eWRorfuAfwxtJTB6on9Khzb63gIAk+u2nM4cVVEit/tGM/53dTYi4a5F2kZl55vYfnH8naTraK7tWyMSWiqV6a+ZPrkdDrbwfrU2WQNmWxD+HFa+CD444Kxdg+ltUC7YdH1F17qZ5aVNC4cW6QM8PD+rm6+vhqAxHgdQIiW6mD2FjQYuAd7V9P0GEMvbcreF4RudNCCJHIZdsninBgUGsSNVA6PGJP9Qa/Owa43BhiKqFStxVDDHC2IlKnXm98UB5+f/eBNl8UrwMeJSweRRYloedNpTZnacADcgeWJz41sbl7bPs7dcC1Ma4O3KmVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNNLWqbZuMdsIFY/2mhoyGySFasDk5q7Z3f5jjG38K4=;
 b=ZGIs3kCO+p9TghRfaBnfJFNQBFsqNr0uj4tDyG425lKFbrt9W3yAuGYUeT1uT68/6RpwSoWJk/+nXyNy5M3MRsZWT39teHd3CJLP3ttC1W3VoFOq++6OmIPxXkmOJoXwqKBs5tcnisXsmZvbchnEh1vAMWGE4HjG+Q8QOmgAsZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 15:39:25 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 15:39:25 +0000
Message-ID: <00a71077-fcae-ea30-3f89-2a4035d1fcd8@amd.com>
Date: Mon, 26 Feb 2024 10:39:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
 <20240223134206.899-2-shashank.sharma@amd.com>
 <be0a4509-497f-2264-987d-2941ce21d97f@amd.com>
In-Reply-To: <be0a4509-497f-2264-987d-2941ce21d97f@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::45) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: be9505c5-587c-41c4-c91c-08dc36e11c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpGToUYRQ+BUXCHjk+PvltMZMQTAbbCCwpJ1J1euzpG4jDqKYVPDmdUMMrUTzwVZ4tVkToogVLZAGOeHrUdSk/kJ9jgzVFpW3trKLMCfQntHotEZwcGo3HY8Ju/YGSO/hQ52pypKVx/pZ0huLTVft40+R3Q8lO1Ood12YMin4NYwdMhaJ3ur6u+yYJBvHd4V1/G8aMBkoUGkQ8fephMcpPNPq01bh/qFDpqWJF/2/IkNwhI/ogh0wm/47RhKxj9Th7Xx89OrqOLS1GpLY/yG1JeQMhaX7FCklkw0W0KOxyK+fBX1UsfkWbFnAtHWvsCXxdcoGxJ/Ee2i9vARxnvYyV35SzEqJBOfdGloiRGpIpa0TdH5suFRkAT2+PNgxE3xaBuHRrILuYVB6kNumWYsTDr6xM5AvQBZw0z0q2q2rBxrAwXopxob/zK3AJQ8nkVlyig9yr5LVb5I5g+CRlxpvNt1DptvY5vrrWfKMN8aJYV4qukiUDyo11VlXle+dkML2+LjI5//A9ylFDkp7tLeprL2t1DpmC19ZQNIhFC00mCzHdhsX4uI7COTog1uBvAwfOd4sxaFBwDM16zq6i+kz7XtSpxs6D6r3ZWobWuTh2yYMSyG7Z9/zLYIcj53CWB6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Kzl5Zi9BSm1qRFFyakwzY251Qk5QdFY1WW9jTWJmOE8rN3dzWW1wZEl3ckxV?=
 =?utf-8?B?Yy85ZDBEdno2RDVIMy9vT3FpYmlzMFRVYjNvY0JrdVZzZEg5M3Uwd2dVVTF2?=
 =?utf-8?B?MHIzckJzRmF3R3dWSUVqMk1Kd2lFU3kwQVYveXd3djBZcVFjTlRycW4xYmRo?=
 =?utf-8?B?ZmErM2RBeHJXZW9sc2hSRGI5R00zVllXeGlVMTVpcUVOVVZ4b3hPTW5wT0R0?=
 =?utf-8?B?Mk9ZeVhYeEZ5U2pBNXl1bSsrN05rYTFkYVJGZ3pLaHVBTlgrQklNK1ltN2NB?=
 =?utf-8?B?VXF5S05qR1VzZVg4MDEvdlhNTnBscEtxV3hpd21iMC82dFA0NHhTLzk0dExi?=
 =?utf-8?B?MmhwN0Rsb3RzT0xpbHpNTVgrVldwUmlKTzBFUzZTR1VpYXVUbmRPd1FVMWsv?=
 =?utf-8?B?Ykx0cm8wbXNOYk1FZjRabi9jczVXY1M5ZFVjQTdlYU5SWnM0UWorbFhZdzV0?=
 =?utf-8?B?ZXlTUFpvaDJrNDVpa3hBWXp3Z1VvRW5JRUFuNkczU3lndVk0dXJ4ZlBHOVFB?=
 =?utf-8?B?UkRMbnplVVNzRThycGsyU2xMSS9tZzk1a3oySk0vajB5RU8yTkRzTVJOYmNr?=
 =?utf-8?B?SDRpRDdsenhycW1kUlViVENnM0QwK1l5S1QvVWlrOTFKeVNTNVBVUmVmQ0w1?=
 =?utf-8?B?bHhOdTBmL2RTUXFzOW0wa09ubVJtZHZzZklMcmxmZTYrU3FhdU1rVEp6WTRu?=
 =?utf-8?B?VERBdXQrVGFxZFhvN1NkMXB4ZW1QSTgvbTFlajBXNXBNNEtaeVdNNVNuZ29u?=
 =?utf-8?B?VVJrQ0UzY01KSlZSSktlQU44MS9zZm13eklTMjJnNHN4Qnl5eXhMTk9yVUQ2?=
 =?utf-8?B?dTlZSDU2ZUpEZVRUaFZDYlB4SnVKbFd1TjZhS3pkWXY3c01Bdy9XMkVENmEr?=
 =?utf-8?B?ejBPaEZWa0VwNXE0YTdsWk1XdWEwL25lcGl4TUl2TGJkYU9mRGxBSjZTSjFi?=
 =?utf-8?B?OHg5bmpJTkFPTnFYMDNGaTFrT21mV0VDaTJRamgxSXc2dXdxY2srR0VLKzNl?=
 =?utf-8?B?N0Y3NkJqY2cxMmEwRmhyZThDbHBrOWduZlZHRWs1aW9PR21aNDlHL1phRnNk?=
 =?utf-8?B?cHZKWGFtWHQ4VGwwM21rTnJEV2FVOXNmZm42emZuS3REbVpvMkVtbDRnUjB0?=
 =?utf-8?B?T05uTklpZEZkZzBvdGVKWTZ5b2F5cUxNM1lnMnpvclRkR29MYUtvWE5rOWJM?=
 =?utf-8?B?QWk3UldKL1EwY0p2NUJLNEdiVWlQK05oaHMyUmVqR3kzeFUyQVgvbE1VRi80?=
 =?utf-8?B?OFBNYm01M0N3Tzk1b1Z2a2UraEhLN2R1d3NUOVlhM2YvcEk5VjVhRnllZ2p2?=
 =?utf-8?B?OFdhb2NBa01aU080UDljY0k4aSswRy9oYi96K0sxV3ppd1FWYkFCUEZ3Tk1x?=
 =?utf-8?B?d1F4THRjWkxST0FNVmZjZzUrV3NQaC81M2VTR0xVeG5Lb1ZsNWx3QWh1UnJq?=
 =?utf-8?B?cVRRdWozdS9RUnZpRUhaR0s3Y1hvemV0RkV4RVVvdHh5cWF0YU5QVE8veUYz?=
 =?utf-8?B?WHRGVENMbmx2OUxacjIrV0Urd09HTzFOTlF1dDg5QzlSVFBKa2dhWHNDZk1Y?=
 =?utf-8?B?ZytGTmhML0ZaV09iZm4xRndQSTBxVkt5bkFYSU1ZUHkrYk14dWVBZERVRzEr?=
 =?utf-8?B?UG8xOXBCd1FvV2U2VXVubFB0MG5QOW5NLzJ2elEzSFdoSEJPQlBuZ3d3UDBF?=
 =?utf-8?B?OVpjNmVaRXN3TldxaFQ4N0JUVzdrU1VaemE0T0c0SXhEcEswc21YMlVUNVk2?=
 =?utf-8?B?YmRibElCcW9RY3ZuQ3ZtWjlDYlc5MGxxYm9VdVdwT0dYTDJPTVpjUkJGTWRt?=
 =?utf-8?B?M1RTTHJLZzlGUVg1NG9jeTZhUFlSTEZienVoVTJLd2l5MEhscEpRTC9QcHFZ?=
 =?utf-8?B?Y0ZEcVY3K3NzSGhnSTJNUmlpVE5oMThQTVY0eFlPZWlTbG1iUEZkTjFJYUdt?=
 =?utf-8?B?Yks3Y0RrYUQwSENaK21tMTV5bDU2bXBlMHd2eXJ2eDd3QlVnbFFwSTR4bEJQ?=
 =?utf-8?B?SXhndkQ0SzhRY084Vk5yZmYyNk1PZFlxRmM4YVRvSGNQY215SWNoam4vTE9r?=
 =?utf-8?B?M3BMczJOTWJlRXVIbVhuWG5ZYUo0alZzak0yMFVpTHkycVV5MUNZVFlvMWlV?=
 =?utf-8?Q?LPKY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9505c5-587c-41c4-c91c-08dc36e11c6c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:39:25.3434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68/ZHmP+7gJW4MYO03mPH09AkUQEtIUzzu3fdaxiLvctg70vt4aReYdVBh58EdPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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
    <div class="moz-cite-prefix">On 2024-02-23 11:58, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:be0a4509-497f-2264-987d-2941ce21d97f@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2024-02-23 08:42, Shashank Sharma
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20240223134206.899-2-shashank.sharma@amd.com">
        <pre class="moz-quote-pre" wrap="">From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>

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

Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com" moz-do-not-send="true">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com" moz-do-not-send="true">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 106 ++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4c989da4d2f3..fdbb3d770c7b 100644
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
index 0960e0a665d3..67c690044b97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -932,6 +932,15 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_unlock;
 
+	/* Prepare a TLB flush fence to be attached to PTs */
+	if (!unlocked &amp;&amp; params.needs_flush &amp;&amp; vm-&gt;is_compute_context) {
+		amdgpu_vm_tlb_fence_create(adev, vm, fence);
+
+		/* Makes sure no PD/PT is freed before the flush */
+		dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv, *fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
+	}
+
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
 			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &amp;cursor);
 	while (cursor.remaining) {
@@ -2237,6 +2246,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_init(&amp;vm-&gt;eviction_lock);
 	vm-&gt;evicting = false;
+	vm-&gt;tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev-&gt;vm_manager.root_level,
 				false, &amp;root, xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ac9380afcb69..8e6fd25d07b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -332,6 +332,7 @@ struct amdgpu_vm {
 	atomic64_t		tlb_seq;
 	uint64_t		tlb_seq_va;
 	uint64_t		*tlb_seq_cpu_addr;
+	uint64_t		tlb_fence_context;
 
 	atomic64_t		kfd_last_flushed_seq;
 
@@ -585,5 +586,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 struct dma_fence **fence);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
new file mode 100644
index 000000000000..569681badd7c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -0,0 +1,106 @@
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
+	r = amdgpu_gmc_flush_gpu_tlb_pasid(f-&gt;adev, f-&gt;pasid, 2, true, 0);</pre>
      </blockquote>
    </blockquote>
    <p>flush type 2 is HEAVYWEIGHT to flush TLB and cache, because this
      case only happens when mapping to GPU, type 1 LIGHTWEIGHT flush is
      enough, type 2 is used when unmapping from GPU.<br>
    </p>
    <p>xcc inst 0 is incorrect, we should flush all XCCs of the kfd node
      -&gt; xcc_mask, but here we cannot get kfd_node.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:be0a4509-497f-2264-987d-2941ce21d97f@amd.com">
      <blockquote type="cite" cite="mid:20240223134206.899-2-shashank.sharma@amd.com">
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
+	/* TODO: We probably need a separate wq here */</pre>
      </blockquote>
      <p>tlb_fence_work flush tlb, then signal fence to free pt bo, but
        how to guarantee the tlb_fence_work is executed after updating
        page table done? This looks racy to schedule tlb_fence_work
        right after creating fence to attach to pt bo.</p>
      <p>Regards,</p>
      <p>Philip<br>
      </p>
      <blockquote type="cite" cite="mid:20240223134206.899-2-shashank.sharma@amd.com">
        <pre class="moz-quote-pre" wrap="">+	dma_fence_get(&amp;f-&gt;base);
+	schedule_work(&amp;f-&gt;work);
+
+	*fence = &amp;f-&gt;base;
+}
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
