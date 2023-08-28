Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89B6C83F11
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 15:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555EC10E2FD;
	Mon, 28 Aug 2023 15:05:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9CB810E2FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 15:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1/Am62+Prq+OgAn+xXeve0PRuIQDuc5z9jJbf5OEg2iqtGqKkfAP8HYWH3RfSaJX4PSUwDEavbHDY1a04b3/R92/MIpNk1F/g4O5CPRglMd6t4wgxEzBl9S32uIGAcmFznIsz3dCyLWs7ofz5YC79wFPGfKnUc6OrdPACsKwRcRYjg8lMLA84aDJNB4O+IaFrK6bHgQPjart6vPR+spxmzwMUcS6WPn4tGms3aDkBaUCAnUQ2DP/Vj+mcmAxtxDJdhsiFaSLWoLR6igUSrPkjK11R/XIkfUvOrUtvVQWK/+zDNEaBmu5p6T3wMd2ITsaEHNkXHj3aW6Z5PZgjbn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mZZ3/gayYXtFwWdVbK5s9FNv5olRXKsqQoEmTTca4A=;
 b=gLKlZ7E88yeTTFFIpzDTLxq5emppHOyIQ/Syzp9nAfKe38PFOmxmuERRZTuxt9Sl4KvYrLrauxAyYhAQowG19LOQMGK03Rk+nq8jZFnFXY40SDhtTWz6OAYfpfQ+8dppxzDkIGsm6bo8UW96z3VzZ5c1CjWQE9/EmuuhlTOPGGHQ5WWEdblhJPKtQ/8PRF2SIXYlIfiCnnd28VrZQW7FKo/4Ss7koBowcobDVEpP1I+rUvGtvWMTho14Aop/X1ZFbtHHRMrhucb+oS2zgFvLqvNAOGMx9qArQ8IlDIcc5aBwSliR9VvNeAqecASTjHHLGnoULo7l06S8tmArgyuOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mZZ3/gayYXtFwWdVbK5s9FNv5olRXKsqQoEmTTca4A=;
 b=wUtVPl0uDhn1ZVDW6fzbUYZlNbLo+uqpt394vaCUF/UXR7EZ3Nbf3yU61QdgMcM2x502YzlyeIPNa3A/muvC6xWcH/ZYhxUl9Og1IF/fXwOFIY/Jq72NwRyKQrgCqaiJbWcRTC9N2Irs2sleMU3X2Ft83RMv9QoRwMqwT4POHzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:05:30 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:05:30 +0000
Message-ID: <28e99731-956f-d891-39e3-d8ab8b9e6a7e@amd.com>
Date: Mon, 28 Aug 2023 11:05:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: ratelimited SQ interrupt messages
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230810161346.322949-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20230810161346.322949-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: c5920612-b250-416f-17ba-08dba7d83856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mltNaf6g79MbZMFz3QBPlKD3yr7buVVaA/oyDyA7TA0TL2jLTbye0Ulnyk8NtbaH6F/oFoMdV07DX6UtzSG4Ly131Gc80XYUNzxp6dRv5dqmf1yzUCYG4Yiok/onsJViQYWnkSY0r7G0Qwa2RSM9qpznZH/ulul3+lSXbLW9mUZwg0PjhVM88B57NPORm6hRC47mvJOazQW9itnPfbKCAnaK5LVnd/BchFW3mLSk6+UwNajRJr9iOnVkXhdbEIwHOMpAyuuvBbcxEi9Ex17AfQYtOL8IcgRdRISg7Wan/O67eAO74IWW1vhAPl4RgP26VFsmiFALKpzG7k/hv6iTxbvDzXMs3YgOB3iEadmYUS1M/H5N0Z9k8gWLeZ/ESdPaR8iaDdrGfPAEBwyBTb9kVAQ6gxenflQu9l48DRWRvvCkCbVwU16NljFoHiuVIz5DIkMo31XWDVqlPG9Uu9fXaWVxMNWMhwOT7fNZP7XoDTN/um8kAvwprrYVozG99Tc+Uw5VWP+UZfJHblSs8BiuRLl5n/+7LlADAnV0zy9ykJ47Lb/fo6bHvPbykUvqB7EIlSjQ9pDG9EPvog0PxFVO/9UkL1irm0/BD55GrngCONLEYJgDQf7Ijrh96UYEo9XOAInu+idRKHwi3pYEhLOs+lZZL7Q/PsDMdKGHOeHMkE2cObzB5S6l0S4ZE/gwApKaD9SVNSgJ71xGSy0Q8nhEhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(41300700001)(38100700002)(31696002)(478600001)(83380400001)(2616005)(26005)(6512007)(6506007)(6486002)(53546011)(36756003)(316002)(2906002)(66556008)(66946007)(66476007)(5660300002)(8676002)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0kreTFmcXJjRStESlRMZG1xRDBLRkYxdGdBS1V0UVFMbmo1eE5sZXZTNTBm?=
 =?utf-8?B?WGFvMmtuZlIzdGE3ZVRwcXVwK3hqcWtsbiswWHBRQXM2cDk2YzVmUnZuVUpB?=
 =?utf-8?B?UkppcWdFb2c3SE9Ga0o3VGViNTliN245UXhyeEhrRnBuclltbTBMdHJnTU1L?=
 =?utf-8?B?cEN3d1FPZ2tOVmZOMGUxeHdSclpPbVNMRDg2Q0lxQnhrYUxvcGNBU2N2aXJD?=
 =?utf-8?B?OGdTNzFXcnVpREFNYzAvSTFYZHpVSlNoQVFOLzZyUzFHa0JQeVdZZTl4MXNz?=
 =?utf-8?B?NG8vbVlHNUR1Y1llQ1NtRWNCZHVaV2N6SFdFRlA2bUx2RWRZeEhpKy81WWRN?=
 =?utf-8?B?c3lFZEhTTXhLWjVwVWNKWEV0RllzRGNpMlFJbDNEVnRWblFZeklMTmFyNVg4?=
 =?utf-8?B?d1RjMlpDTmljc0VIMGtTSjR2Yitpb21HSHdPcGd2cDhsQW9sYk9nOG5SdlVO?=
 =?utf-8?B?VGtacHBGN0dSaTV2SHk2a2VnV0NUSXlHS2hPMkl2WW0xdnpzYUtSa21yQ01t?=
 =?utf-8?B?amUwNjJHdkkxODVEdjc3T1REWmN0RHRLU3NxSUhMQTM2cENmQ3JFTjAxamg3?=
 =?utf-8?B?OXJwckluZHdWREduNG9GejgyeWFUV1pzWW1CYitvYk5MUVNtalFza1E5MkFI?=
 =?utf-8?B?Vlh1T2pDeFNrYjk2RnRjSGZHaHprVFN2ZUcyR3ZPK2hDbXJpN1laT1NGYm1u?=
 =?utf-8?B?enNZcytFaTRIZDNsQjBSM29JdGRGRFB1LzUyZGFvSzZnUVR0S1lvS2pWL2dJ?=
 =?utf-8?B?VUlwMzJKUjVFVXEvMks3N2JqbC9IdUpKVFpjdDhkYkJiUFJUdndtUXp2MVRB?=
 =?utf-8?B?YzB6Zlh4MERXSDUxaFZvSUpWT01LVE9nNlErTTBSTndMNXp3c1Vnd3pZTkti?=
 =?utf-8?B?akdYRVpuSmdsN3ZjUEptOC9SVTRySW1zelQyL0xhWGprMExyZG1DYVJKT3U5?=
 =?utf-8?B?MTg1U0JqZG5wdVlwYkxsdDcxeFlDU051R2E0OEw0TXFRNWx5SjcvMUNudmNL?=
 =?utf-8?B?UjYvRTltYmQ0NHVSQlJ6Rm9obnJPVzl1cDRFczFYUXhFZms4L2wzNzl0YVZy?=
 =?utf-8?B?bXZlUm9YY1VaUExsRmdEcHBIbFlmdFQ4emRaMWU5LzJMc0pmVFV1Um92alJC?=
 =?utf-8?B?UlI2L1dpY2JhMFZ5NjlER3NkNC9OditZWngyMlUzaE8zQVZSeisyYjJmS3V4?=
 =?utf-8?B?ZCtQUDdYRndYaTBVbVdSR0p0L0Q1Ynd4NlRiZHJENU52R1RBWmJSL0FQRUl3?=
 =?utf-8?B?UDN0eTBjRmhnNXZhMzl1N253cDNNVkJoWnNSOElzMmxTdnJhSm5TVkdzZlJK?=
 =?utf-8?B?NjV4ckMydGUyZlpQZGNzTUJQd3ZlaW94bjJGcWZteVl4anJTNjY3T2p6WUc1?=
 =?utf-8?B?R2NpaFhzYjRUVWZibUlpMVN1TTN5Vm9jWFpMR3Zsb0tSSzlqZEVOVmtGN3pE?=
 =?utf-8?B?QmUzSEFLSXkvQUZBdTFYbFZIbFFFVTdhQ25QL1JGa1VaNjhJQk4rb0E3TGhR?=
 =?utf-8?B?WG5aNzJmSnI3dS9XcXlNVGh0VlB0Mm9FU0FYb2xqTTFKcmF5K0NNUG5NOVRR?=
 =?utf-8?B?RjdidnRxelFyK3F0RmNGWnBCTU1Bbnplb0ZENTdINE00cEh0UUpGdTFPd0ls?=
 =?utf-8?B?eVU1MlV0NVlaK1FIamNzSEEzMjhkUzNOa0ZTdXRjQUw4Vkg2Q3B2emJUUDVk?=
 =?utf-8?B?UkdJUXBNYUdQS0RWbXpPY0ZMZlVpM1Z2Q2xjUVc4WE1jSGNnVGxJRVRWUWpF?=
 =?utf-8?B?Q1VDREtqeGJVUGFvZ0hjWk5DY2FlVzF4SUlrL01DYUNobml1N1NJVDNYbHlq?=
 =?utf-8?B?b2t2aGQ0TDJhMG5iK1NzdnFVNnk1OVViVC9VbTJpcnNzOU00ZUdLTTJwZUxa?=
 =?utf-8?B?UCtVQU50M2NSVzdaN3BxTURJU1lBeWQxQ2M1V2JHVUMyNFBCTVNUVk0vdGNP?=
 =?utf-8?B?dk5lb0FFWjJ5MHVJK0RnUloreTNjK1pYOU9CZDI4MWpRMEI2c2FnMVdndzBX?=
 =?utf-8?B?ZDdFSjdGY0hPUnA4K0lUa3VGeElYbkNEdG84NmJ6WWJxR1FOTFVwN1VJTElw?=
 =?utf-8?B?Znh6aEZqNW1yR1Y2dHZFYTFsbTMweVRxbjB1WVlnWWtRazcycC9ielpZcWN0?=
 =?utf-8?Q?4PnU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5920612-b250-416f-17ba-08dba7d83856
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:05:30.5154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4G+xvNFmamT4JPeADnOw4wwYMNOmxw5GjYiIDa7cP5vn4oBvDSrcv8u/dKoOejb/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
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
    <div class="moz-cite-prefix">On 2023-08-10 12:13, Harish
      Kasiviswanathan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230810161346.322949-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">No functional change. Use ratelimited version of pr_ to avoid
overflowing of dmesg buffer

Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20230810161346.322949-1-Harish.Kasiviswanathan@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index c7991e07b6be..a7697ec8188e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -268,7 +268,7 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 						SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
 			switch (encoding) {
 			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-				pr_debug(
+				pr_debug_ratelimited(
 					&quot;sq_intr: auto, se %d, ttrace %d, wlt %d, ttrac_buf0_full %d, ttrac_buf1_full %d, ttrace_utc_err %d\n&quot;,
 					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_AUTO_CTXID1,
 							SE_ID),
@@ -284,7 +284,7 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 							THREAD_TRACE_UTC_ERROR));
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_INST:
-				pr_debug(&quot;sq_intr: inst, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n&quot;,
+				pr_debug_ratelimited(&quot;sq_intr: inst, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n&quot;,
 					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
 							SE_ID),
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
@@ -310,7 +310,7 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				sq_intr_err_type = REG_GET_FIELD(context_id0, KFD_CTXID0,
 								ERR_TYPE);
-				pr_warn(&quot;sq_intr: error, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d, err_type %d\n&quot;,
+				pr_warn_ratelimited(&quot;sq_intr: error, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d, err_type %d\n&quot;,
 					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
 							SE_ID),
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index f933bd231fb9..2a65792fd116 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -150,7 +150,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 
 static void print_sq_intr_info_auto(uint32_t context_id0, uint32_t context_id1)
 {
-	pr_debug(
+	pr_debug_ratelimited(
 		&quot;sq_intr: auto, ttrace %d, wlt %d, ttrace_buf_full %d, reg_tms %d, cmd_tms %d, host_cmd_ovf %d, host_reg_ovf %d, immed_ovf %d, ttrace_utc_err %d\n&quot;,
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, WLT),
@@ -165,7 +165,7 @@ static void print_sq_intr_info_auto(uint32_t context_id0, uint32_t context_id1)
 
 static void print_sq_intr_info_inst(uint32_t context_id0, uint32_t context_id1)
 {
-	pr_debug(
+	pr_debug_ratelimited(
 		&quot;sq_intr: inst, data 0x%08x, sh %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n&quot;,
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, DATA),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, SH_ID),
@@ -177,7 +177,7 @@ static void print_sq_intr_info_inst(uint32_t context_id0, uint32_t context_id1)
 
 static void print_sq_intr_info_error(uint32_t context_id0, uint32_t context_id1)
 {
-	pr_warn(
+	pr_warn_ratelimited(
 		&quot;sq_intr: error, detail 0x%08x, type %d, sh %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n&quot;,
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, DETAIL),
 		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index f0731a6a5306..02695ccd22d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -333,7 +333,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 			encoding = REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, ENCODING);
 			switch (encoding) {
 			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
-				pr_debug(
+				pr_debug_ratelimited(
 					&quot;sq_intr: auto, se %d, ttrace %d, wlt %d, ttrac_buf_full %d, reg_tms %d, cmd_tms %d, host_cmd_ovf %d, host_reg_ovf %d, immed_ovf %d, ttrace_utc_err %d\n&quot;,
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, SE_ID),
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE),
@@ -347,7 +347,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID, THREAD_TRACE_UTC_ERROR));
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_INST:
-				pr_debug(&quot;sq_intr: inst, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, intr_data 0x%x\n&quot;,
+				pr_debug_ratelimited(&quot;sq_intr: inst, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, intr_data 0x%x\n&quot;,
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SE_ID),
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, DATA),
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SH_ID),
@@ -366,7 +366,7 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				sq_intr_err = REG_GET_FIELD(sq_int_data, KFD_SQ_INT_DATA, ERR_TYPE);
-				pr_warn(&quot;sq_intr: error, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, err_type %d\n&quot;,
+				pr_warn_ratelimited(&quot;sq_intr: error, se %d, data 0x%x, sh %d, priv %d, wave_id %d, simd_id %d, cu_id %d, err_type %d\n&quot;,
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SE_ID),
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, DATA),
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SH_ID),
</pre>
    </blockquote>
  </body>
</html>
