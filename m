Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325E1CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 18:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EF010E532;
	Thu, 19 Oct 2023 18:13:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD3F10E532
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 18:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQBPauyvwFBGjAzOiaVWj8Zpi+B42BPN89Q5nlIRE3g+/3kRc9MMXzuISPGmvOG4aSlXxA2om9HG/chq9zxwzQstvfymRdJpjNOmtzXH/ZXTuv5h9HOaXNAZZKfvpM+DElY42drQlcrgMF1g3dIfZsa6Va14S/QlcG31WU1yfGHboCvugUYn1XkmnDFk2V0F8Na1CRrOkbnnTPhv5l0UaTulhdT+vvWMExmSZYtZHrTDPtfZALAt4fTGjXyrF3paGSLXyFhoayvEHtQNRditui5dsWHVXSqYDyAfrFOoQbmSKDOCGsUu0mN2oe63h+Hc6w/QpHZm0PwZi89iI9nk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYdwQjqm3j2njn+FDiYNttsX7dskSUeldcl5ApU0tT4=;
 b=c1OCTR1BV/en/p5VdZM0wMU9BHtXbuvbW4H1Iv1QTAq3bi35uzeaDHU8BwbDmoOW9U4tKznXULk19OnUyHzwsR+qVQhHv/mHNf59GoDkGogtEKdLZu87zEQenViq3i1w04jj+rRWQyk5dsTAVPpI8nkuDBu4JE8QciusunPjH0jhSqTWgTOgjaicvQztt6RJ5w//i0aae9KpxEzm9WBbXqRorc2weSjRYEwOztszLin6AntkdfNB++LFoCfA8TGkOrsZRgZKoimHpRVYNG38XcYiDTTY1ZfnVfnGXvLHHJuBC3RVdkYMyT/jwUOy4EUD+itWJ4fhmqAO4M7R2off0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYdwQjqm3j2njn+FDiYNttsX7dskSUeldcl5ApU0tT4=;
 b=cGeMYu6hxixfJnd3UBN+kwiBORwN6cBsdthhpePKDMC3a2u7lvbPsaGnkMvNsHWHD1LsqL8cgfO0Aa+EqLjr7U3Tnp+rlCdIeN/h+QE8ESPpTdgPJtHPaDOlyUPJcXLYekBaLnt+ojPnSOJuCrjNWn73l51bFVwb/ytzlS5L/x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 18:13:07 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 18:13:07 +0000
Message-ID: <56d320ed-ff4e-f644-e7b5-c90574aef9df@amd.com>
Date: Thu, 19 Oct 2023 14:13:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue and remove
 unused code.
Content-Language: en-US
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231019015609.299859-1-jesse.zhang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231019015609.299859-1-jesse.zhang@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 19783509-0f12-40e1-acfb-08dbd0cf0b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vd5u4ryxwdfXQt1O3o5Lxldk6eW6KYCkklQbMIrZsEjzdVxHuypxOZ/M/hnEgvIm4BsNxE/LrvLkp/yewaz6uNhV8P1b5x3rtIV+McUd0UJqthdlNl5QBeedeptjogh6VY1b1kJN/DucSe+hIz8pHQ2G9JUxL+192iyrDXsWopQaxXJy+WFYN44i2DEGBWuofpNwyCoNZHnVBlNk61z5UhB19X+QlP90pUKH6XrxfiTmXvWy9AP4dMQBGM0oubIcmUsK0j9Hdo8ioArH2EhaBxXbz00QjXQ5wyd/YbwnB5pQeKJMX7gg7DD6YZ5FRJjmkRv/fBr8GzBSTOkhKX0gt5hDUBbS4Z7c+/1L/PAwJ69dtsRZOwpxFABc/Aim5TN6pcSiuoC1yoSKAEOtRluwUM32SiEEyGsJG+MkLZ6zyOGkpftIyLYCdCte+DoaOC3mYsmBx4JIjfbLE0XL/ezUgJUFxtqOulKKIBBRvnqvj+x2ZMsIiWB5GBEQHB96GyWkJc1eImJhKaTsaLjsYhZT3TjMpFAXnJ46hIaX08qcx6mmQCZLh5cMBhl/zygBFzLGwG0pFLUg60FeSHUdWDOioDEtqtAD7n/hIlJZid5OK8aQvwah7vrpzlx4KafNMDDF/DwPYjFNyrtL2GoaGjnwpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(4001150100001)(36756003)(31696002)(2616005)(26005)(6512007)(83380400001)(53546011)(478600001)(6506007)(31686004)(6666004)(38100700002)(4326008)(6486002)(8936002)(8676002)(5660300002)(316002)(66946007)(66556008)(66476007)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0h6QVhLdkF2MkQ5dFhIVzR0QzJ1OG5pZ0FXSlJVbzlTZ3VYM0hBRy82eSt2?=
 =?utf-8?B?eXF2Q0xhNE9lZTNLVi95dFhNUVJnS3FlaEQ4NnphWlFKMWtrdlAwczEwQnZv?=
 =?utf-8?B?RHBpdDJ4cnV4QUhMNXV0eDlDT3dSblREbHI1YkkzUkhPZWxCdVBObmRmTzBl?=
 =?utf-8?B?T3ltZ0JNRERqZkI3VjBzbTJmaGpkTTV5cnk0OEh0MWoyd2JjZ2c1ZHVLMk9B?=
 =?utf-8?B?N3dCdGpZVGJrcm9hSlRQNkpVWXA4a0ZJRTNpTWNEOWsyWEtaeWtPV0ZvMkNR?=
 =?utf-8?B?ZndVdm51ODBZd29kY2dVbFk2VU40RDFVVC81TVpxL1pISUNPVURsWXZ3Rlpp?=
 =?utf-8?B?bmM5QnZnM2NlUmFuV3Y3TVo0dmEvQWhyeHl4SFMrTEdaSnlKQXBYMytiaUgr?=
 =?utf-8?B?M1VaVS9ocTVVMGlRWEl1YXRpellyL1RKdWR0WFFvblgzWFlFK0M3Z2YySXYv?=
 =?utf-8?B?UTBuZSs1OXcvQkNNT1U3RkdrMHVPM0hYSFM3U2s5eHV5cWRyZnl4czFWOWxB?=
 =?utf-8?B?K0c2TGFGc3JPWmdicEVPYit5ODZ3U1M3QlR1T3l5dllGblNldUZPdlU0akVy?=
 =?utf-8?B?WFJ6NWlGQnY2Nml0Lzdicys2S0ZMRmE2WHM1cnU0aUhUSmlvQzN0WFRwdGNE?=
 =?utf-8?B?TjdKcVNGMjBsUitBYWo2RHcxQzV1VUYvUkZtVHRQbnJJWkNkN000S2ppYnZB?=
 =?utf-8?B?YTBNRG8vdzdBdEQ5dVpRSTlvTUVJY1k3amJFTy8xQ3QwYXpPbjkrUlJRSnQr?=
 =?utf-8?B?MGx2ZGVtaDlPZWFQQUhsSGRLVVY0OGdtNm5ZTlpmMnF2VHN5ME02MUw0dlBh?=
 =?utf-8?B?aHg4VmV6ODdGZjNOTnpNc25JbFRwSUhhZURCWlpjTjdXNVhKVG03Wk5qUVFE?=
 =?utf-8?B?SW5OMWZkWUhTY2EvbGhRamRLYXNoMWNhZFFLK3dWa3d5SmY2U3FTNWhBcnBj?=
 =?utf-8?B?UHdTK0VzeXRnLzZrUmpQRkZNdVVIWkpubzJ0amxiQUpIb0lINUZOUnU4NG83?=
 =?utf-8?B?NERjZUNqUDNkRkd2L3h1aVhmcXR2MUZKV2piUklYWnBxbUR1VUFtcFpQeHlT?=
 =?utf-8?B?T3gyWnBZNXhNeDFtU09qMVJ0WFFNa0tiaWlLZ1cxdGFhZmhXMFFmdGVLcHFF?=
 =?utf-8?B?RmsyREpKemdzZVQ4TUJxb0ZMVEQreTNLM3BRL01lWmdlSEV1RHJYUXZSOGFa?=
 =?utf-8?B?aFZ4ZytsNGo2WmZSM3UxZEc3TjliLzJlMllEbFR4Y3ZUWTRURkhBOHJocjFv?=
 =?utf-8?B?THp3eTk1a2c2MGp4b3hranh5Rjl0RVE5elZrQllDdlk3MjRrSTNXYXVXWTN1?=
 =?utf-8?B?VFhMUlBoczlnUDdYTDdSemJkcllrVExQa1p3ci9IQXRJa2JkZjlZbHMrem9v?=
 =?utf-8?B?MnREMnRCTy9xV0pqd1FUOHdLY0h2Uk41cTFYS2R3WGtBa0hxTHZRQUlkNzZT?=
 =?utf-8?B?all1Ymx1L3RUTWRJNlRZc1JNaGtnUVpZT1J3bkg5Y0RPaXV6UWZUa1lDSzRq?=
 =?utf-8?B?RlQwWDNEWDQwNXRPNEtOTHlSUnlZUno0a1FTei95aTREdVh1RDlwV2pBY1V2?=
 =?utf-8?B?SjFzWE5LelhwNy9IL0xIcXFuN0h5Ykd5RjloUS9LMFp1Z09xVmplSVVmdDFm?=
 =?utf-8?B?RFFDcXJLUERHYWFZcko0citkb0xGWXl4aE0xTHFMOU1ybHlCSENhM3RINTVB?=
 =?utf-8?B?OUlaZXNES3JHRG9mMVA2TXNmZ0NQUW12M0tJMDFBUTFHblBuMC83NG1SdWZ2?=
 =?utf-8?B?blJLMTFCbzUrTW5nVWU3SHRpbmJUcXU5cW1lYmpPKzJCQTg5YnM2NkRWcVVp?=
 =?utf-8?B?YUFCQ3FpRzB2bUtjbHVoYlBnVTF2UzlhNEluVEtUTmRaTkl5YVA0N0NPUXNh?=
 =?utf-8?B?ZVFleGZEYWx6SUR5MDRPQlkzMkd5c0pGT3N3bnNRR1dFeFl0VVlVelVNcFFK?=
 =?utf-8?B?bmpUellRRndmVGZPWjhDQnBMMXZqU1FGZHk1VmUxTjNFY0dMK3ZDOGNnQnRM?=
 =?utf-8?B?UDNsbE53aUs2RkM5cXRkT1lhLzlkczM5dVNYTFEzOXlZTzB3WTdZbS8xNkly?=
 =?utf-8?B?aUcrZG93Y2hCUkVIenFVMFNsaW9sTzZrTFRFWUhJZ0ZyTU55Q2lpN0NWZWJ4?=
 =?utf-8?Q?DUEg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19783509-0f12-40e1-acfb-08dbd0cf0b77
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 18:13:07.4035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXE4XvchPmvK6nR1OL5BwPF2Krs4vVR5/kyBXUCRM9ubL3aYgj2Q9shgf3eCO38z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
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
Cc: Alexander.Deucher@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-18 21:56, Jesse Zhang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231019015609.299859-1-jesse.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">[  567.613292] shift exponent 255 is too large for 64-bit type 'long unsigned int'
[  567.614498] CPU: 5 PID: 238 Comm: kworker/5:1 Tainted: G           OE      6.2.0-34-generic #34~22.04.1-Ubuntu
[  567.614502] Hardware name: AMD Splinter/Splinter-RPL, BIOS WS43927N_871 09/25/2023
[  567.614504] Workqueue: events send_exception_work_handler [amdgpu]
[  567.614748] Call Trace:
[  567.614750]  &lt;TASK&gt;
[  567.614753]  dump_stack_lvl+0x48/0x70
[  567.614761]  dump_stack+0x10/0x20
[  567.614763]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
[  567.614769]  ? srso_alias_return_thunk+0x5/0x7f
[  567.614773]  ? update_sd_lb_stats.constprop.0+0xf2/0x3c0
[  567.614780]  svm_range_split_by_granularity.cold+0x2b/0x34 [amdgpu]
[  567.615047]  ? srso_alias_return_thunk+0x5/0x7f
[  567.615052]  svm_migrate_to_ram+0x185/0x4d0 [amdgpu]
[  567.615286]  do_swap_page+0x7b6/0xa30
[  567.615291]  ? srso_alias_return_thunk+0x5/0x7f
[  567.615294]  ? __free_pages+0x119/0x130
[  567.615299]  handle_pte_fault+0x227/0x280
[  567.615303]  __handle_mm_fault+0x3c0/0x720
[  567.615311]  handle_mm_fault+0x119/0x330
[  567.615314]  ? lock_mm_and_find_vma+0x44/0x250
[  567.615318]  do_user_addr_fault+0x1a9/0x640
[  567.615323]  exc_page_fault+0x81/0x1b0
[  567.615328]  asm_exc_page_fault+0x27/0x30
[  567.615332] RIP: 0010:__get_user_8+0x1c/0x30

Suggested-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 62 +---------------------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  3 --
 2 files changed, 1 insertion(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 54af7a2b29f8..ccaf86a4c02a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -781,7 +781,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			prange-&gt;flags &amp;= ~attrs[i].value;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
-			prange-&gt;granularity = attrs[i].value;
+			prange-&gt;granularity = attrs[i].value &amp; 0x3F;</pre>
    </blockquote>
    <p>Thinks again, this should be prange-&gt;granularity =
      min_t(uint32_t, attrs[i].value, 0x3F);</p>
    <p>Please separate to another patch to remove
      svm_range_split_by_granularity.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20231019015609.299859-1-jesse.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">
 			break;
 		default:
 			WARN_ONCE(1, &quot;svm_range_check_attrs wasn't called?&quot;);
@@ -1139,66 +1139,6 @@ svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
 	list_add_tail(&amp;pchild-&gt;child_list, &amp;prange-&gt;child_list);
 }
 
-/**
- * svm_range_split_by_granularity - collect ranges within granularity boundary
- *
- * @p: the process with svms list
- * @mm: mm structure
- * @addr: the vm fault address in pages, to split the prange
- * @parent: parent range if prange is from child list
- * @prange: prange to split
- *
- * Trims @prange to be a single aligned block of prange-&gt;granularity if
- * possible. The head and tail are added to the child_list in @parent.
- *
- * Context: caller must hold mmap_read_lock and prange-&gt;lock
- *
- * Return:
- * 0 - OK, otherwise error code
- */
-int
-svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-			       unsigned long addr, struct svm_range *parent,
-			       struct svm_range *prange)
-{
-	struct svm_range *head, *tail;
-	unsigned long start, last, size;
-	int r;
-
-	/* Align splited range start and size to granularity size, then a single
-	 * PTE will be used for whole range, this reduces the number of PTE
-	 * updated and the L1 TLB space used for translation.
-	 */
-	size = 1UL &lt;&lt; prange-&gt;granularity;
-	start = ALIGN_DOWN(addr, size);
-	last = ALIGN(addr + 1, size) - 1;
-
-	pr_debug(&quot;svms 0x%p split [0x%lx 0x%lx] to [0x%lx 0x%lx] size 0x%lx\n&quot;,
-		 prange-&gt;svms, prange-&gt;start, prange-&gt;last, start, last, size);
-
-	if (start &gt; prange-&gt;start) {
-		r = svm_range_split(prange, start, prange-&gt;last, &amp;head);
-		if (r)
-			return r;
-		svm_range_add_child(parent, mm, head, SVM_OP_ADD_RANGE);
-	}
-
-	if (last &lt; prange-&gt;last) {
-		r = svm_range_split(prange, prange-&gt;start, last, &amp;tail);
-		if (r)
-			return r;
-		svm_range_add_child(parent, mm, tail, SVM_OP_ADD_RANGE);
-	}
-
-	/* xnack on, update mapping on GPUs with ACCESS_IN_PLACE */
-	if (p-&gt;xnack_enabled &amp;&amp; prange-&gt;work_item.op == SVM_OP_ADD_RANGE) {
-		prange-&gt;work_item.op = SVM_OP_ADD_RANGE_AND_MAP;
-		pr_debug(&quot;change prange 0x%p [0x%lx 0x%lx] op %d\n&quot;,
-			 prange, prange-&gt;start, prange-&gt;last,
-			 SVM_OP_ADD_RANGE_AND_MAP);
-	}
-	return 0;
-}
 static bool
 svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index be11ba0c4289..026863a0abcd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -172,9 +172,6 @@ struct kfd_node *svm_range_get_node_by_id(struct svm_range *prange,
 int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
-int svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
-			       unsigned long addr, struct svm_range *parent,
-			       struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			    uint32_t vmid, uint32_t node_id, uint64_t addr,
 			    bool write_fault);
</pre>
    </blockquote>
  </body>
</html>
