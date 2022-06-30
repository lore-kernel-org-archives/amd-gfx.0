Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB3C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A760511A35E;
	Thu, 30 Jun 2022 14:53:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7978411A35E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB8rdsp61PtvFVPGnPM7WvX4xSNX0xIwyBtOZ8UQ8LPp40DX75xYHtn511OWByRN8sWEEhustLsUyGDkE7qRQlyDKC8Y1HqJhcTPVFkqIwMoVsrp15jOht52QjYAG1MkFWmLKp0tLwnc7+vrylxX2A50CvmlbkVef3RL+Sd01rwPplcEXg+gjMysxBfATE7Jp7Vk1o64iZbbXmbgHVFYLNoLuJwkTFDJrqaFWRV+ZxjRqiAJiwvvpUsMJVFBRGRx5RWtuNndIxZ0QA37/S4Bvcyk6eKswNCLQca2pU4MJO6SzbFfatWEt3Fhs620mkdbacIk84ERGF1ASnQmC/wkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjwT5IamZsI2W29LVvbee76CHL80tBIBs9sLqi0zMhI=;
 b=F8equrRn3PppKUcAUYnQhsHVv9WKEEFeGcZoVGx98AXzPNEMQMKMnIpb4GL3FaRBmajU2C2wN7wvqqxEyvx7R99b7kFjHOMad3pV+obvKRx+IAjgdJlMmV7aehrWyy7jn+2of1++qMU3bz5te1Nba1o0ExcMGNMweqZgG9pN7JYxfV3h1u3PB04A3eC5DjtUP/b4uwD79HKgzbez+iDHlkaEQ/VWpHvFuEM3Nk/tVB6Ow39ul7RR6gcdLd7yCkbDRzOLLaG4RoqalbJS5j3s9ng70FZJisH+xjSnAeVy2DesSoiLwP2lgUs5FwH/PuL6yYqhDu3MTnIDluiWBcoOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjwT5IamZsI2W29LVvbee76CHL80tBIBs9sLqi0zMhI=;
 b=0mqTgyPOfbpQgbYVYOEQPSOLKhrfYDsR30MMIjrYjsVK6+8l9CimlcuxXzwEusDHetdFpnTbead6AmbDBnhB6mBEMSvbgVMIeuO0TvL8L7EIX6n0m9CN+YtKXrr8Z7+CmI3t9RHmrPrP2aefDddK6RsD8/Jv1xkTkotbZ84Wkbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 14:53:54 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 14:53:54 +0000
Message-ID: <1b2b6a97-560f-ddfe-3b03-c360633d13c0@amd.com>
Date: Thu, 30 Jun 2022 10:53:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/11] drm/amdkfd: Add GPU recoverable fault SMI event
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628145020.26925-1-Philip.Yang@amd.com>
 <20220628145020.26925-4-Philip.Yang@amd.com>
 <7c8b25a1-2937-18b6-c329-e901673ae691@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <7c8b25a1-2937-18b6-c329-e901673ae691@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:32d::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26ded6bc-b91e-4552-39e6-08da5aa85a7b
X-MS-TrafficTypeDiagnostic: CY5PR12MB6526:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQqY1je1IDcj83Ich0C8t3ZlVRIVSiLOiOPYBTtWmZ2C34rPMxtJFSngfmwH9CPyHDciX4lC6YfEYf3KaQEfdQbTP2XODlCYHlbv8djGe+pM7pVHIhOMei1aLYT2W30Li1W1oFSqRkiy86NAhfgLsoW7phYZx0UbIB5Ha/wZgebDok0piz8H4ByKS04ikOwj2L/E6tH58LEz+utJjK6F3QkhBdFswfktF8sUyZpqjqhuMh6O1vYdvwr5HSFPB4D9YR1JirLALkk90JE03YuRHz+SqwjVRER3sfxf0s/lEANAcSA60J5mAnGDr6edRBbkPDEh3N8rYf36qItZB2YCniIr0FCfNKmzB0iY+2k8p9Betvs1HS8gW+QpULPPncAYWZryXj+EbIh9t7gkSB/qPwVmlDZkgv04hy0aNrpHSwYr195bVLT/+nl4eM3QeQhd6zs5W3JTemk/XgcD6MXkWRKQY/6cskvYN/d9rXfR0RmGfOn5/Fzd9K6EKM4Si+9jeTA9NZuntcyZH9S6+f0dWGlAuf+TyOAOxQ26Mqap+n9dxid0fLFa0Pt39A/yWFGIBdf28T4hsCKjO6G9fwGPxArTZR7ReXxp9ltHAJCMtucBYiuRsTshZNbhhPxxPFkcfed3/Isn1N+lppV26Hv3730w2uQlj4rUVYDoAQ72r2JXR06pfl+uBfrDh0EEm6DlqTA32VtyRUG+o8HwUBWrUZNLnIPwRVxMzVCbnes7FwU74l8KF4Tn5g3J/GpsGoBst+VJ3Rs0r8RJ7AHojFKQsMO1SFRVFww9YsaZNWAcdf3amGgLsr1FTQpEKCrEFjbzVxOEXvYWpYy0GopiUowtGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(8936002)(83380400001)(31696002)(66476007)(38100700002)(66556008)(66946007)(6506007)(53546011)(5660300002)(26005)(2906002)(41300700001)(6486002)(316002)(186003)(110136005)(2616005)(6512007)(31686004)(478600001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZISDdONmxyL1JRVVZTY2s0L3EyYlJTRFZveFYzbTlGUFdHWTN5RkdvWW4r?=
 =?utf-8?B?ejFTd3BnMXk2THlsOXprRURTMHBjbEFDVzRLZm01SXBDdmxOZ3pwTzNhb2Rh?=
 =?utf-8?B?K2N3ZmZrN0hQWlVCZjM4T09RNnVGYjhjL1lNRXM2cldsUDFhSFhtbnJTOWRw?=
 =?utf-8?B?aFlIakZjN2IwRkJ2eHJRbkViNkc3U2tJb0hSa1NQSFkwQW53RTVvak15Q0Js?=
 =?utf-8?B?S0NVVkd6eVR0ZTFBeHFQQ214ZjQ5V0psUi80L1FURk04WjBGMFZEelEwWXVH?=
 =?utf-8?B?Nkh1ci9ZN2t6UnQxRHN0NWwzZ3V3bnl0cEVtRG9zZVRpMzFJZkQ1SjBZUEFY?=
 =?utf-8?B?bkpZKzV0RUVKcGdaRWlrTnhoMFRQTmtlc2Fwck15aHNvYnNSZ2FYK2RySFU2?=
 =?utf-8?B?YzVFb2VTOTNJbTY1UDBHbEpZOHZXbjZlOHM1ODJad2ZDUWpuQUNqd0lTc0d6?=
 =?utf-8?B?TEwwTHpFV2lleEp6Y1N2ZmR5clh1OVYvVE5QSEpkVnF2eTlJVXZ5S1RuYkQy?=
 =?utf-8?B?L0gvalNIZ1dsRFNHYjZ2WTVJVnJCY2FVSUxTQll4WUxIeThaNkI5YWtCRkxR?=
 =?utf-8?B?c1ZzeWswdDc3RjE5Tk5jdktwcldFWDVGc0ZXZkRoMnhzUU5lajNOaGtFUGtl?=
 =?utf-8?B?eVpUWDhWN3F0R21rNVdESDVPMEI5bXlPdER5SU9KTWpIei9zcEtZVW9nKzZP?=
 =?utf-8?B?SmIzVUx1VjczUldWQUtkZXhzb1ppOTB3WmgwZk8xR21IWmFMclJFdDlTZllZ?=
 =?utf-8?B?TGt0UVZYOE02VEpZWUZrRnN2VUl4VWsxYXVhTjQybVBJbFVTQmczUUxXSklY?=
 =?utf-8?B?ZFVaRXAxUW92NUV3ZVRxMEJ2MEROclJGaGFHQ0JGTG9vTEY1SlViaytqTUJC?=
 =?utf-8?B?RXhab2U2YW9qWXVSUFhYcEZYZnllMXpIQnlER2luQW9JVlAzcEZ2aXYyV3NB?=
 =?utf-8?B?RzhvT1VPTUFVY0lRblU5LzhlbTdtVjBPY094U0hLaWI5UEhTTnE3clNqZ0VB?=
 =?utf-8?B?cDBXRkc5aXl0UkpheWc4K3A5OHloVWMyRHYwbTJ1K2VnWFZtb1R1eXFRK294?=
 =?utf-8?B?OW81ZTRJQm80N2UxcGoxZU5IUnlDRWFXOXEzNzY1Njg4RlVIU1c1M3Z3NEgw?=
 =?utf-8?B?b2NCai9pZVcxQy9yTGhpQzJxTTZBQ0piWFF0YnlhRlo1VzkySHc2eUtrNU1x?=
 =?utf-8?B?VWhEcHQzVDFNQ0VhUHdqVW04ZHY1cUxyZFZoSnMxdEhNd0hJNlNBVUtjODk2?=
 =?utf-8?B?aFN6YXh0dUVqS2s1Q1RLbFBWN21wZEZTdVQ4RFptczNnTXlWb3hFRXdLR2Ns?=
 =?utf-8?B?V0FwSzhvVnhhMHl6OG5MajFUK2VGa05BZnVWTXV0S3QrVlBmTkJxWXNaMjFS?=
 =?utf-8?B?QWxoQXBkL0psb2FBTkltaTBBcy9USVkzd0o5cm0zWDYzNTljS3VCUXduTFll?=
 =?utf-8?B?UjdSWHdCOTE0RnhON2dsYTVZZ1ZHSnE0MlRtNHAyRWROQ0VoYkFyc3M0MUFw?=
 =?utf-8?B?TDNiMnhGOU1ONkd3cTdDYUtPZ1NXN0xwdlRTTDdIUlFwZzRFTjVOMVFuU3BV?=
 =?utf-8?B?dmhUazlCTGMxa2FXTkdLV0EvQ2x2VFI4SlV3c1ZTWmYrSUY5cEN0aDVRU2Qy?=
 =?utf-8?B?UWkycXMvSmhzTmZXTTdJM1Q4VGkxYXpkQ3pMaUU4R2RvdS91V0JCM1NHakEy?=
 =?utf-8?B?WjJwZWQxK0dxdHIwZlJBR2FQL3FyZmp0T1Y0Q2pieE9PMW02V1JYNmZvVTdt?=
 =?utf-8?B?YnFhVEhSK1N2bTcyZjNwN3p1ck5FK2tvaE5tWUhoYWtLYWhiWmRCTWlSWmZV?=
 =?utf-8?B?cDk4UmlSYlVVS0JVMmc1cUdDSDVHSmd1M0ZKQ2RFWHVKRGpGV2pHMWR3Y3M5?=
 =?utf-8?B?emt0RWl5VGJ6QWVITzVVRHh1VTRRc254bzhjSVB3aUx3L3kxcXVxbDN0YlVq?=
 =?utf-8?B?MUkvdnJmZXgrdWI0Skd0YWJuSkcxSEpBRk9DT3VyNEJ2OU9RVlVjWHJDZ29F?=
 =?utf-8?B?RUV4eFBkaWJLUUk0NzB4RWE4K0VOWmdEQUZFQTk1RGsraTJxemxKemlCRXli?=
 =?utf-8?B?ZktpOW1vcURuTVViUGo0Qk9NWEVicVFhQ0NLdlc5U2c0M3lvbmVQRFU1RTFk?=
 =?utf-8?Q?jE8o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ded6bc-b91e-4552-39e6-08da5aa85a7b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 14:53:54.6469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AODAb5zCAh8F+fyLwUMbA/Jw2ltQB2KbQ8ImFKUkrSAsaR8J1A3EQigWCbOIIsCB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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
    <div class="moz-cite-prefix">On 2022-06-30 10:19, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7c8b25a1-2937-18b6-c329-e901673ae691@amd.com">
      <br>
      Am 2022-06-28 um 10:50 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Use ktime_get_boottime_ns() as timestamp
        to correlate with other
        <br>
        APIs. Output timestamp when GPU recoverable fault starts and
        ends to
        <br>
        recover the fault, if migration happened or only GPU page table
        is
        <br>
        updated to recover, fault address, if read or write fault.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 17
        +++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |&nbsp; 6 +++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 17
        +++++++++++++----
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
        <br>
        &nbsp; 4 files changed, 36 insertions(+), 6 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        index 55ed026435e2..b7e68283925f 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
        <br>
        @@ -244,6 +244,23 @@ void kfd_smi_event_update_vmfault(struct
        kfd_dev *dev, uint16_t pasid)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info.pid, task_info.task_name);
        <br>
        &nbsp; }
        <br>
        &nbsp; +void kfd_smi_event_page_fault_start(struct kfd_dev *dev,
        pid_t pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long address, bool write_fault,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t ts)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_START,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;, ktime_to_ns(ts), pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; address, dev-&gt;id, write_fault ? 'W' : 'R');
        <br>
        +}
        <br>
        +
        <br>
        +void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t
        pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long address, bool migration)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_PAGE_FAULT_END,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%lld -%d @%lx(%x) %c\n&quot;,
        ktime_get_boottime_ns(),
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid, address, dev-&gt;id, migration ? 'M' : 'U');
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_smi_client *client;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
        <br>
        index dfe101c21166..7903718cd9eb 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
        <br>
        @@ -29,5 +29,9 @@ void kfd_smi_event_update_vmfault(struct
        kfd_dev *dev, uint16_t pasid);
        <br>
        &nbsp; void kfd_smi_event_update_thermal_throttling(struct kfd_dev
        *dev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t throttle_bitmask);
        <br>
        &nbsp; void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool
        post_reset);
        <br>
        -
        <br>
        +void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t
        pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long address, bool write_fault,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t ts);
        <br>
        +void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t
        pid,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long address, bool migration);
        <br>
        &nbsp; #endif
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index d6fc00d51c8c..2ad08a1f38dd 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -32,6 +32,7 @@
        <br>
        &nbsp; #include &quot;kfd_priv.h&quot;
        <br>
        &nbsp; #include &quot;kfd_svm.h&quot;
        <br>
        &nbsp; #include &quot;kfd_migrate.h&quot;
        <br>
        +#include &quot;kfd_smi_events.h&quot;
        <br>
        &nbsp; &nbsp; #ifdef dev_fmt
        <br>
        &nbsp; #undef dev_fmt
        <br>
        @@ -1617,7 +1618,7 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unreserve_bos(&amp;ctx);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp =
        ktime_to_us(ktime_get());
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp = ktime_get_boottime();
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        @@ -2694,11 +2695,12 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_list *svms;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;
        <br>
        -&nbsp;&nbsp;&nbsp; uint64_t timestamp;
        <br>
        +&nbsp;&nbsp;&nbsp; ktime_t timestamp = ktime_get_boottime();
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t best_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t gpuidx = MAX_GPU_INSTANCE;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool write_locked = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
        <br>
        +&nbsp;&nbsp;&nbsp; bool migration = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!KFD_IS_SVM_API_SUPPORTED(adev-&gt;kfd.dev)) {
        <br>
        @@ -2775,9 +2777,9 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_range;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; timestamp = ktime_to_us(ktime_get()) -
        prange-&gt;validate_timestamp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip duplicate vm fault on different pages of same
        range */
        <br>
        -&nbsp;&nbsp;&nbsp; if (timestamp &lt; AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (ktime_before(timestamp,
        ktime_add_ns(prange-&gt;validate_timestamp,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING))) {
        <br>
      </blockquote>
      <br>
      You changed the timestamp units from us to ns. I think you'll need
      to update AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING (multiply with
      1000) to account for that.
      <br>
    </blockquote>
    <p>Thanks for catching this, the change was in v4, I removed it by
      mistake when updating comments.</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:7c8b25a1-2937-18b6-c329-e901673ae691@amd.com">
      <br>
      Other than that, this patch is
      <br>
      <br>
      Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%lx %lx]
        already restored\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, prange-&gt;start, prange-&gt;last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        @@ -2813,7 +2815,11 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, prange-&gt;start, prange-&gt;last, best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;actual_loc);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; kfd_smi_event_page_fault_start(adev-&gt;kfd.dev,
        p-&gt;lead_thread-&gt;pid, addr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_fault, timestamp);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc != best_loc) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration = true;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (best_loc) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_to_vram(prange, best_loc, mm);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        @@ -2842,6 +2848,9 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map svms 0x%p [0x%lx 0x%lx] to
        gpus\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, svms, prange-&gt;start, prange-&gt;last);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; kfd_smi_event_page_fault_end(adev-&gt;kfd.dev,
        p-&gt;lead_thread-&gt;pid, addr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration);
        <br>
        +
        <br>
        &nbsp; out_unlock_range:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp; out_unlock_svms:
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index 2d54147b4dda..eab7f6d3b13c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -125,7 +125,7 @@ struct svm_range {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; actual_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; granularity;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; invalid;
        <br>
        -&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; validate_timestamp;
        <br>
        +&nbsp;&nbsp;&nbsp; ktime_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; validate_timestamp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmu_interval_notifier&nbsp;&nbsp;&nbsp; notifier;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_work_list_item&nbsp;&nbsp;&nbsp; work_item;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deferred_list;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
