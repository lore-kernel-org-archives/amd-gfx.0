Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59696C48BC3
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 19:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D237810E531;
	Tue, 20 Feb 2024 19:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dlNIMfAk";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DB710E531
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 19:36:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyOXwXczSzcexbMc15W+FI5EFOb0A1ybfJcoFpS1ilxTee+bBfCjJ13wNAAWufl3taN02UIUDQh8HusYpq9b0QfLCYUG8SuwI4CQpmQ8g4ZhbddTqax1pbBkwonEfO1oLKq2bQCHAKjgjs/nbDwRMhFmCDPMDk6oPo869hHqQE1BCk4REp5mg/FvGSXaiDlWqZzYUEQ6ChGVIM35j707nSCj537HoLs7szJDYdNze7isk/KTe2oei51aYkt6xpCqfG7eis6oMdRuaT7avYy7NkRa+bw9kkHiWQHkBredKxG9iUwxHJ5vwruZ/cxt0iq2wKESJMF2PlDEVEsm4HXMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/It8VYyqCG+UHoXjnERaSRuzjsSEMwglzn5zH02fvY=;
 b=MIvWyZ+r4ObWLXuE5KVIwQDOgSXtKgao0krK2owFkX0bIK5nYb4OlOykfCwNYL0d3UWFfEjK4cRb53N7loww7VA3+3+YB4DbC2GtskRn1FizkL4OKZzU13r+iNFVyw4K0J/kn1QD555E8nxMD4PrrJW2Af39Ikgfrl2NobccX0SbjahkgutG4+SkbCGtp9gzvKBUePeAVzV5HOTB1UMa2w2qBmOGTaihzywo88AQB8vn6/O8fRNBfWgfaGpLmzxWad9ijdbSXWQOJkgSZqd+q/WIHh+FxUzQR5sd9MHEBOIRFrUbiwvZysOjPN71Q1RWkGw/ce9CnC/9uxbEzHmxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/It8VYyqCG+UHoXjnERaSRuzjsSEMwglzn5zH02fvY=;
 b=dlNIMfAkMf8V3Br0Oitptg0kOEFy/sqrsnQrQtWtrujS7EMGIuSqyoZ3NlhStJp7OIX2XrWc7oyIVMeOvo9WSuiAW/Ic8sBdp5Rl8JLiaR4haPyfYD1i/haY4ZuNIahVVqud5ziTNV1oOrgofHNBJNM3YpfQ1wfFkpn0YBotKG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 19:35:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 19:35:59 +0000
Message-ID: <5b85686d-c673-b5f8-58ec-bba5f794e3a9@amd.com>
Date: Tue, 20 Feb 2024 14:35:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Document and define SVM event tracing
 macro
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240215151830.22416-1-Philip.Yang@amd.com>
 <0e86e558-3d3c-4d24-9de9-7691d3f672e6@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <0e86e558-3d3c-4d24-9de9-7691d3f672e6@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::33) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: a41268e9-8b3d-450f-8ede-08dc324b2a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpwwIjELT9JE9FxGPBjuOxlxp/7PVhQoFr188Vi0pqYSfqZuJbiiRKLWK8y22R3HZH3NRW2YH4CgzilqR24W0HrdgPrm+kI8cEeuwhMgDRT7TPviJD5W7OqCDNtHZA7YPhzhTo0+AHpeRgXRJvPw+gbNPrIz/L5y/om4mRyNkakmmopqvWmp30zY8D+d2KPSjNUVpUPkDO8QDp5j9mLHoody6PgpX8fFnKwsK1ngC8EsvYZ3dfdFue0X9kjDixV91BOzP/sKUUibcMfa0MpbBDt56cMR7QLymwrv3PmsnJs8nofAFXciNA8fxe/cNEXqaD40+VX+lQI3KlO5EzlrK2S6DCnqpDnwKA/Fr3kEhjO+0+H05PDmIY7X3Q8kmsGuUiYznztr1FHghFzuKqmwERu5A6tZlY98zVDHTJA/W5K8oaW/llDOTZ/6XpY9wLeFGlmp/9gwkCGzcn/zEpycabBEcM7/dknTlNZ9qtG1lhQEhrjhX45QE45Y9vbBiEI43gjJo+doO3VvUwZrZ/GHJJjVP2WSLp2+9aVM1dmem6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVk2Y2R0VENXTmhoNlQ1aFc0QjcyOEFleVE4eEZ4NFdpQURpclpWR3BEbTRQ?=
 =?utf-8?B?YmlOZW5IdW5Sc05qVWUvMVZDNm1oYno3NnBjVFR3Y1k1K2Y1MExIN0lZOXAw?=
 =?utf-8?B?SUdpdzZ4RjBBRXJxeERRVytqelA2bGxFVzdrd0h0TGhOVlBkOXFiWk15eDVm?=
 =?utf-8?B?WlFkSnBCalYycGxWWk5LR01naWxZSlhZc1dkbWxwNVJWdnNacEVjS0FEWVcz?=
 =?utf-8?B?MmlaTG8wTURkU1B4MVllZ3l3TFBOeEtMUzRSekRiajFGWVJta2p6eVZ6aEdr?=
 =?utf-8?B?aW4xaVdNUWVJR2JGSDVGREF5RUJwQWVFOXRZUzUxUk0wOGNTZmZPM0Q1bHJM?=
 =?utf-8?B?V1E5dG5PTmVvb016b3haK1hzR0t5c00rOUxZdkZqUm5yd0hQQTVnSGM5aHdO?=
 =?utf-8?B?MERleWVRMnh4RHZSTGJUTnlOQll5TEhMSzdjcmRuNGRNR1pXUnZiUG5ua2d0?=
 =?utf-8?B?WW1mZXNXU3RkWmFpcnVBa0ZFZVRqU2h2c2RSUkVLZUgxWmNmNlJtbFNZUjZC?=
 =?utf-8?B?NEgxb0VXTmpuTWxPSy8zWlRlMEhkN2F1Rno2a0NEUnFDQk9BODFSclF4aWdr?=
 =?utf-8?B?eWZMNHRjWFhNRHJCbHRkUUpIVXU1bjRndXloSVl4UG1XbzlITXcxRFRHMDVF?=
 =?utf-8?B?TnlsVXUxUGwzQ0JMUzJPa0dPQ1cwSEZnc3gvTW1kNCt3U3BnM3ZodFZKZWZk?=
 =?utf-8?B?cGZXRTYyVWdNSyszc1E5dXBKaVhSdWduSUdlbmVlQlprY0hsbktsS0pBY0Rz?=
 =?utf-8?B?bDlTdmN3YkdVSm9Ndm9DWDhBczZLbjFISWxxblRSUVU2Y2xvdlA2QUU5dEtJ?=
 =?utf-8?B?YXVqbUltYy9ZN1lYZmdvaG1SUVZoU2VLL29Qa0dMbUNHMFdpZHB4QkN0b0JQ?=
 =?utf-8?B?TkQzcWZMUkdlUFhKZ055T0M2dWIyOWZHU1U4MitiOSsxRGx3QWZ3Tmw3UHUv?=
 =?utf-8?B?ZXROemdza2hMRjJoNUFoYTdHYjIrZ1d0a3IzZmZRZ1NmYTVjaGZQZlJOc3JJ?=
 =?utf-8?B?QW5QeFplZUxLLy9rb0ZQNFlMNXFZQUgwcEc2dE4vNzc0NDg4cTd1V0xMVzFJ?=
 =?utf-8?B?KzFQVm9acnZ1SFV0aVZCelNDVWR2UllsM0tORHZOWDBrVjh6Y3gyS05nb0tt?=
 =?utf-8?B?OUgrMXVvdnpsUHdkendFWStWS241MzdYZjFWZllibDh0TDM2SllyeXJBcVpZ?=
 =?utf-8?B?UC9aSVVKWTY3RDgvYVBLWUhtdU1aVWtXTWw1ZVBVRzdiLytiUG43U0VlNFJD?=
 =?utf-8?B?OHhhU3Y0SWJiR0JZYXplaHZnRGRzTWJWS0xJNWdTWUhHQ3R0cFZUaXZtdkhU?=
 =?utf-8?B?dE9IOHJjeWVIL2hvNmE2TFBIMHFPV3JUOEMvdDhUOGJlQXdFa1pUaThzMHh1?=
 =?utf-8?B?d2VWanU4MnBDZllHS0NqRVNkOVFWKzRzRDBrV3U1WjRLZE0xdGovbkI2VU1y?=
 =?utf-8?B?Z0FIMytlZGJDV1F6UWhBUG1keGVkQTJFY2Z5MGZqaHZ3M3lzS0FXZVJHbSt6?=
 =?utf-8?B?REtPVUNzMlRBajRxU2ZadGpNY0lOQzU3L0dMa2RQdkJlbUEvRWpwRkFDQ2g3?=
 =?utf-8?B?cmx2c2EyWS9mejYxbzZtS3c2U2UzOEJVRldEV2IvVHhiTXp1cERDQUtvVUxH?=
 =?utf-8?B?OXNXT0NLTVB0aWR6blRaTkJ0WSswZCtmL0k2clY1T25mSXpOeHdpL09UNWhE?=
 =?utf-8?B?ZWNUSU4rbGZ6ZUlSQ0w5cmNGR1ZGT1NGejZwbk9JNkNEMG5sbHNhWU53Y3Z6?=
 =?utf-8?B?aEpPd2d3Z05jUkg5MTRkdXlKOHVWUFU0SEgrMk5nWnUrR1BCckhwU2Y4bkEr?=
 =?utf-8?B?TzlkSkNQM2FiSGx5b2pGTXE0K0xqQU1UMTR3ODBYMm1QL0daalJtdHhRL2xE?=
 =?utf-8?B?cXI1TkZ6Z3JmZWxxdHV2STVnZjVIN2JpMnZZdTJ5MmdNY3djRXNKTVZIcmtM?=
 =?utf-8?B?Zm5GN3NvUlhER0pXamcwNHdNUEFBMG5Bc0p2ZHplRm9WU3NDampaU0lQdkt2?=
 =?utf-8?B?VFJDd2VTMDlKQTBXVTh4bDNEWjJiSHcxbnlwWWd1cWlpYStFQTNwQW5GazlF?=
 =?utf-8?B?Z1BMcjhLa2lOT3dHUjJDTldJZWdYeUI3SmsxSzl3QmVjRkZCdm1mZFAxT1pY?=
 =?utf-8?Q?Az5o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41268e9-8b3d-450f-8ede-08dc324b2a5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:35:59.5542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cccmZX3o3C16ejtxBoxIwbBDQXrBmBwp12lD9EnNYIgAo5IkzZywpOrJqJJO2iZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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
    <div class="moz-cite-prefix">On 2024-02-16 15:16, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:0e86e558-3d3c-4d24-9de9-7691d3f672e6@amd.com">
      <br>
      On 2024-02-15 10:18, Philip Yang wrote:
      <br>
      <blockquote type="cite">Document how to use SMI system management
        interface to receive SVM
        <br>
        events.
        <br>
        <br>
        Define SVM events message string format macro that could use by
        user
        <br>
        mode for sscanf to parse the event. Add it to uAPI header file
        to make
        <br>
        it obvious that is changing uAPI in future.
        <br>
        <br>
        No functional changes.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 51
        +++++++-------
        <br>
        &nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 77
        ++++++++++++++++++++-
        <br>
        &nbsp; 2 files changed, 102 insertions(+), 26 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        index d9953c2b2661..85465eb303a9 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        @@ -225,15 +225,16 @@ void kfd_smi_event_update_gpu_reset(struct
        kfd_node *dev, bool post_reset)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event = KFD_SMI_EVENT_GPU_PRE_RESET;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++(dev-&gt;reset_seq_num);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, event, &quot;%x\n&quot;,
        dev-&gt;reset_seq_num);
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, event,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_UPDATE_GPU_RESET(dev-&gt;reset_seq_num));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_update_thermal_throttling(struct kfd_node
        *dev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t throttle_bitmask)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
        &quot;%llx:%llx\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttle_bitmask,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev));
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(throttle_bitmask,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev)));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_update_vmfault(struct kfd_node *dev,
        uint16_t pasid)
        <br>
        @@ -246,8 +247,8 @@ void kfd_smi_event_update_vmfault(struct
        kfd_node *dev, uint16_t pasid)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!task_info.pid)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT,
        &quot;%x:%s\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info.pid, task_info.task_name);
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_EVENT_FMT_VMFAULT(task_info.pid,
        task_info.task_name));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_page_fault_start(struct kfd_node *node,
        pid_t pid,
        <br>
        @@ -255,16 +256,16 @@ void kfd_smi_event_page_fault_start(struct
        kfd_node *node, pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t ts)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node,
        KFD_SMI_EVENT_PAGE_FAULT_START,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;, ktime_to_ns(ts), pid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address, node-&gt;id, write_fault ? 'W' : 'R');
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts),
        pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address, node-&gt;id, write_fault ? 'W' : 'R'));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_page_fault_end(struct kfd_node *node,
        pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long address, bool migration)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;,
        ktime_get_boottime_ns(),
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, node-&gt;id, migration ? 'M' :
        'U');
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, node-&gt;id, migration ? 'M' :
        'U'));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_migration_start(struct kfd_node *node,
        pid_t pid,
        <br>
        @@ -274,9 +275,9 @@ void kfd_smi_event_migration_start(struct
        kfd_node *node, pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x-&gt;%x %x:%x %d\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_get_boottime_ns(), pid, start, end - start,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from, to, prefetch_loc, preferred_loc, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, start, end - start, from, to, prefetch_loc,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preferred_loc, trigger));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_migration_end(struct kfd_node *node,
        pid_t pid,
        <br>
        @@ -284,24 +285,23 @@ void kfd_smi_event_migration_end(struct
        kfd_node *node, pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t from, uint32_t to, uint32_t trigger)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x-&gt;%x %d\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_get_boottime_ns(), pid, start, end - start,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from, to, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(), pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, end - start, from, to, trigger));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_queue_eviction(struct kfd_node *node,
        pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x %d\n&quot;, ktime_get_boottime_ns(), pid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt;id, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, node-&gt;id, trigger));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_queue_restore(struct kfd_node *node,
        pid_t pid)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x\n&quot;, ktime_get_boottime_ns(), pid,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt;id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, node-&gt;id));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_smi_event_queue_restore_rescheduled(struct
        mm_struct *mm)
        <br>
        @@ -317,9 +317,10 @@ void
        kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = p-&gt;pdds[i];
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(p-&gt;lead_thread-&gt;pid,
        pdd-&gt;dev,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_RESTORE,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x %c\n&quot;, ktime_get_boottime_ns(),
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;lead_thread-&gt;pid,
        pdd-&gt;dev-&gt;id, 'R');
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_get_boottime_ns(),
        p-&gt;lead_thread-&gt;pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id, 'R'));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);
        <br>
        &nbsp; }
        <br>
        @@ -329,8 +330,8 @@ void kfd_smi_event_unmap_from_gpu(struct
        kfd_node *node, pid_t pid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x %d\n&quot;,
        ktime_get_boottime_ns(),
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, last - address + 1, node-&gt;id,
        trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, last - address + 1, node-&gt;id,
        trigger));
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
        <br>
        diff --git a/include/uapi/linux/kfd_ioctl.h
        b/include/uapi/linux/kfd_ioctl.h
        <br>
        index 9ce46edc62a5..430c01f4148b 100644
        <br>
        --- a/include/uapi/linux/kfd_ioctl.h
        <br>
        +++ b/include/uapi/linux/kfd_ioctl.h
        <br>
        @@ -523,7 +523,8 @@ enum kfd_smi_event {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_PAGE_FAULT_END = 8,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_EVICTION = 9,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_RESTORE = 10,
        <br>
        -&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
        <br>
        +&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_RESTORE_RESCHEDULED = 11,
        <br>
        +&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * max event number, as a flag bit to get events from all
        processes,
        <br>
        @@ -564,6 +565,80 @@ struct kfd_ioctl_smi_events_args {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 anon_fd;&nbsp;&nbsp;&nbsp; /* from KFD */
        <br>
        &nbsp; };
        <br>
        &nbsp; +/*
        <br>
        + * SVM event tracing via SMI system management interface
        <br>
        + *
        <br>
        + * Open event file descriptor
        <br>
        + *&nbsp;&nbsp;&nbsp; use ioctl AMDKFD_IOC_SMI_EVENTS, pass in gpuid and return
        a anonymous file
        <br>
        + *&nbsp;&nbsp;&nbsp; descriptor to receive SMI events.
        <br>
        + *&nbsp;&nbsp;&nbsp; If calling with sudo permission, then file descriptor can
        be used to receive
        <br>
        + *&nbsp;&nbsp;&nbsp; SVM events from all processes, otherwise, to only receive
        SVM events of same
        <br>
        + *&nbsp;&nbsp;&nbsp; process.
        <br>
        + *
        <br>
        + * To enable the SVM event
        <br>
        + *&nbsp;&nbsp;&nbsp; Write event file descriptor with
        KFD_SMI_EVENT_MASK_FROM_INDEX(event) bitmap
        <br>
        + *&nbsp;&nbsp;&nbsp; mask to start record the event to the kfifo, use bitmap
        mask combination
        <br>
        + *&nbsp;&nbsp;&nbsp; for multiple events. New event mask will overwrite the
        previous event mask.
        <br>
        + *&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS)
        bit requires sudo
        <br>
        + *&nbsp;&nbsp;&nbsp; permisson to receive SVM events from all process.
        <br>
        + *
        <br>
        + * To receive the event
        <br>
        + *&nbsp;&nbsp;&nbsp; Application can poll file descriptor to wait for the
        events, then read event
        <br>
        + *&nbsp;&nbsp;&nbsp; from the file into a buffer. Each event is one line
        string message, starting
        <br>
        + *&nbsp;&nbsp;&nbsp; with the event id, then the event specific information.
        <br>
        + *
        <br>
        + * To decode event information
        <br>
        + *&nbsp;&nbsp;&nbsp; The following event format string macro can be used with
        sscanf to decode
        <br>
        + *&nbsp;&nbsp;&nbsp; the specific event information.
        <br>
        + *&nbsp;&nbsp;&nbsp; event triggers: the reason to generate the event, defined
        as enum for unmap,
        <br>
        + *&nbsp;&nbsp;&nbsp; eviction and migrate events.
        <br>
        + *&nbsp;&nbsp;&nbsp; node, from, to, prefetch_loc, preferred_loc: GPU ID, or 0
        for system memory.
        <br>
        + *&nbsp;&nbsp;&nbsp; addr: user mode address, in pages
        <br>
        + *&nbsp;&nbsp;&nbsp; size: in pages
        <br>
        + *&nbsp;&nbsp;&nbsp; pid: the process ID to generate the event
        <br>
        + *&nbsp;&nbsp;&nbsp; ns: timestamp in nanosecond-resolution, starts at system
        boot time but
        <br>
        + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stops during suspend
        <br>
        + *&nbsp;&nbsp;&nbsp; migrate_update: the GPU page is recovered by 'M' for
        migrate, 'U' for update
        <br>
        + *&nbsp;&nbsp;&nbsp; rescheduled: 'R' if the queue restore failed and
        rescheduled to try again
        <br>
        + *&nbsp;&nbsp;&nbsp; rw: 'W' for write page fault, 'R' for read page fault
        <br>
        + */
        <br>
        +#define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%x\n&quot;, (reset_seq_num)
        <br>
      </blockquote>
      <br>
      If we want user mode to use this with fscanf or sscanf, and we
      want this to be extensible in the future so we can add new fields
      without breaking user mode using these macros (as you do in patch
      2), then the \n should not be part of the format string here. We
      can add the \n in kfd_smi_event_add instead.
      <br>
    </blockquote>
    <p>Add new fields in the middle of macro will break the user mode,
      if adding new fields at end of the macro but before \n, this does
      not break user mode binary compiled with old macro, the new fields
      added are ignored safely, \n at end of the macro seems reasonable
      as each event is one line string.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:0e86e558-3d3c-4d24-9de9-7691d3f672e6@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +#define KFD_EVENT_FMT_UPDATE_THERMAL_THROTTLING(bitmask,
        counter)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%llx:%llx\n&quot;, (bitmask), (counter)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_VMFAULT(pid, task_name)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%x:%s\n&quot;, (pid), (task_name)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_PAGEFAULT_START(ns, pid, addr, node, rw)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;, (ns), (pid), (addr), (node),
        (rw)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_PAGEFAULT_END(ns, pid, addr, node,
        migrate_update)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;, (ns), (pid), (addr), (node),
        (migrate_update)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_MIGRATE_START(ns, pid, start, size, from,
        to, prefetch_loc,\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preferred_loc, migrate_trigger)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x-&gt;%x %x:%x %d\n&quot;, (ns), (pid),
        (start), (size),\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (from), (to), (prefetch_loc), (preferred_loc),
        (migrate_trigger)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_MIGRATE_END(ns, pid, start, size, from,
        to, migrate_trigger)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x-&gt;%x %d\n&quot;, (ns), (pid),
        (start), (size),\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (from), (to), (migrate_trigger)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_QUEUE_EVICTION(ns, pid, node,
        evict_trigger)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x %d\n&quot;, (ns), (pid), (node),
        (evict_trigger)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_QUEUE_RESTORE(ns, pid, node)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x\n&quot;, (ns), (pid), (node)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_QUEUE_RESTORE_RESCHEDULED(ns, pid, node,
        rescheduled)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d %x %c\n&quot;, (ns), (pid), (node), (rescheduled)
        <br>
        +
        <br>
        +#define KFD_EVENT_FMT_UNMAP_FROM_GPU(ns, pid, addr, size, node,
        unmap_trigger)\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%lx) %x %d\n&quot;, (ns), (pid), (addr),
        (size),\
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (node), (unmap_trigger)
        <br>
        +
        <br>
        &nbsp;
/**************************************************************************************************<br>
        &nbsp;&nbsp; * CRIU IOCTLs (Checkpoint Restore In Userspace)
        <br>
        &nbsp;&nbsp; *
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
