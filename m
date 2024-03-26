Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70DBC6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 14:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8293A10F008;
	Tue, 26 Mar 2024 14:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3wxxRkw9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2096.outbound.protection.outlook.com [40.107.244.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C745810F008
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 14:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUQQ3Z0BIms25ABkEmZTJ4K6+lTeNBQ+iLdlu6gFhUJPtLgAeOsm5JzS9FPVleme1lAbReFejHWEBQ5IKErQYtpcywfyWdHCjqdg7iiqNGWjH53Slui+pfoD+Ltq/4HvaDbMrl6EhKM+FIVsn73mYS5PFWkJrCMnWpeS/0mfsGaBYOfSgEHODNZZOD/4nF/nON1jMQCFywqrYkcd+i8uNIc2/5uS+YpyCK4MAf7YeZxoR+NI32p4QtFerQ/fqMDHv+9Ci3pZfEarHGXeCNoqtW7KRfd/sfwBR3dJj98SQamZgZyf+D2TdSeD8+fObnY4CHn86TDtbeumjLrmVWcTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCHGzGEyxaSX6Djrzd2bFYBEQw4pxDsoxmQO+m0Mt1A=;
 b=OHVm22IOE/QI7kLLPGdl6kfh15Pqn/YV7/PfWihJrDVjGX9QU8qfBFQQXNk5dorijOx3WQlJtsYBjVKEc+TfyUXCA/eKDQQ7qnXVUa/Gjd7sM0pmrQS/9OL3pcawJyaTyI1osvyzCFeXJm3XFHkDhswdsHWNpStQ3NFvPwLgXOb6z3vNxeJMsAlyOPO+Ob1xphkrcYaOG/hnMfLw2JcnwV/6XAG2ddgObcLPYoOeFfxXP7KExC+k6XFqDxk70YPi6KE30QBMapfWnmU5XYfvSsz2nMzUmWDHjp4TJfSeR+N+4V5N645HE4tdI5+om/qCG615caCq61d7GEJUl1kfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCHGzGEyxaSX6Djrzd2bFYBEQw4pxDsoxmQO+m0Mt1A=;
 b=3wxxRkw9d8PZUljF+Fu8COCzn9oT0s78x8qIiIv88rppBUtgsOYwAbm+JDMk9HKYu8MMw/U8vV/8xnteK5BP+tIKTlCrqo7tVZPYzlPaFchQmbCQdZ/eR5c8UBK57NA196hhmS1mt7p0SnMPT0F2sjjrnjHFT5jT6e+RQ11y4kA=
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 14:53:35 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 14:53:35 +0000
Message-ID: <4cc67abb-c0e0-414b-353c-9f364cd0888a@amd.com>
Date: Tue, 26 Mar 2024 10:53:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] amd/amdgpu: wait no process running in kfd before
 resuming device
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com, lijo.lazar@amd.com
References: <20240322195737.30795-1-Zhigang.Luo@amd.com>
 <20240322195737.30795-2-Zhigang.Luo@amd.com>
 <4fb3033b-a025-45ea-846c-bf97566d41e0@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <4fb3033b-a025-45ea-846c-bf97566d41e0@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::12)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6130:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reYU1G64WLu6Rk8ev9KlPoOIlGt++CSRO5TZ/mORgzDEHCYrpnqTkTZ97Rb5uO42t4HLJfZ0+WvHxDdUZ0agMX7tAk3PdrQl20c241rs4E6zPraPtaNvrtGD/n3CpZZwnWa68oBp8BwLpDEOdASSsY/j0KSJNACvxKLIYIpofgwNmMzySEsGsvw3Jut3eA4p/aE/fh73GgTRJ3iUr7LVuZttHmwwhkX0pU2uhhNVIWKh5kxpzlsGA6PtFWA2BDg3LOsFbkvWhmvSa3dengowW68S7ExxZp8zyjPIDmsOi6Eb3SS/fG49LWLN9XvS+MJts7Wcxd06CGIPNZqfaAAb+s3E10e49nSAU1hC3Ro7f1o98yYAJN3y02LH5WD8n436Xrr4/aA9VZGbcetliaFLUL21rT1FpoJKJw/yQQ01dbqQ0gPPuzHG0/djEJhfV31ZqgmNk46jwprB9/ajmynolgto0ynsacHXeZTYqRhYZDmrIkKlKPLzITzRIU6EkCZzrem/HS6I5Z3pE2oFkz4Kob+TBvHFRSR2NuxJhqdbZXw3rsaISqZ20vWI9h0oXtaGKO8o7FAxHGnEMas+4/VfcrLfUJCibVAPSL+zgRCcGDH7GgU1zHixIzTwt1zmTfzSU76ZHAvipdpZDwpwZAUDi4zGFTRW3x232kNDQGsNniE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1Eajc2dmlvK1VnTmlVbTZwOUNXVFlyS3I4MjVPN1U2aDEvV0RLaktzZ2tM?=
 =?utf-8?B?Vk12Y3ZhT0M1VXNydWZGMFUwcjRDUitIMmlJY2ZOVEU2NDVGc3F4ZThNbXRi?=
 =?utf-8?B?SWdzbWhPeTJIODlnenRBRldKbGExbjU5ZmZJZ2JqKzhocmhJdTZHMFdRc25h?=
 =?utf-8?B?VHp5TGtVQkFmVGdOTWNONmpFbnRSaTNvR1lIK2hjd1RaTFluWmRMU0llaDls?=
 =?utf-8?B?eFZ2UURMdzlGNzBLVlNQMnluUmVIbkNWK1Zyd0NtT09nZ0IzWmNid1NnSDlh?=
 =?utf-8?B?QitjU0VsL3BEY1NoTWE1RlVMOXRhRGlycXEzTGltMDgyRTZSNlFCQWF2aWtj?=
 =?utf-8?B?VG1xVDBMZEtNKzJpMWlIQkpZa1VUTzFaNGRoZnIvaUxPR2VGczN0U2xIMTEz?=
 =?utf-8?B?a3lnZlBFeGZHMWptUWFFOGh5eVp2aU9Bd0VPdFhsMVdnWVdhVHBheTM1U3Fy?=
 =?utf-8?B?N3lHOGRHNzNVbXBGQXBiZzByWmMwR0laWGNLa2h5dlFSWGhuS2ttRmNpYith?=
 =?utf-8?B?NlJ3SGpjTCtXdi8rT1BvcmpLazFDODNPa2twRXc4dkhZOVBtK2E1SXAwWGlu?=
 =?utf-8?B?MkIyTFh4M0hwQlBkQk85SVowNFdmbU5ZcXhjWENFVjFac2ZkZzlqNFdIODlZ?=
 =?utf-8?B?TEtjbTNkMHhjQmZlWkFLeXVxM05jZzZjeUhmR1pFNHpuL2Y5bXlqMFo1RWF6?=
 =?utf-8?B?Y01TTWVBZUJHb1A5UVY3cXZZMGc2OFpFdUcveFpSbFpsSDFtZk5vOHoyUkwx?=
 =?utf-8?B?VUc0UWhGa0xCTjdjVGZyQ3o5MEcvRFpQY2dQMG8xMmNERUdsVzZhSjM0dDkv?=
 =?utf-8?B?eE0wMFc1VHFRY29pZDMvUStOVnNkR2dySWZQTk9vaGZuQUhDMWE0UnhnSXJr?=
 =?utf-8?B?M1BMT1FvQlNWSUgrcDd3ZVpJQk1KaXcrRFdIRThVeEpEcjVGeWtOcVRxZzZ5?=
 =?utf-8?B?Q1cwZGZVMElyQ3p5V2pPdzQwc3JZZmxvcjJLOTVGU2YvYmdyS2hCWktyRFBG?=
 =?utf-8?B?RjBXTTV1aCsvdklncWVyQ25sN2JHRXg5K0xTQkNBVVY4MEJ3Ym9UYXFZVFFR?=
 =?utf-8?B?MTB2Zy80NW40ckt2R3ZnVGp4OGF0aDJUdXZ0eFU2dWJ4UW5FUkpXZmQxSnRY?=
 =?utf-8?B?TzFBbmNCUy96V1RqNjBMSjNDc2txSms0OFBRd2E2bGVVRDZxZkFMa1V4RGZH?=
 =?utf-8?B?SlVseUFkajRKenZjZXhsVnNWWUJhNE0yVHZhTXlLMS9lR2NXZEZWSFQ0SlMy?=
 =?utf-8?B?ZHZpQUtzZWtyR0Q0TStyU3lHY2E1TmdZbkpreHlrQ0VpYW5BUVQ1OXZRQWZL?=
 =?utf-8?B?RGxMUTFVN1d5KzV6ZHI0QlN5bTdGQ25TVFNUZzBwNnZsTFBjci9TcU1XTkMv?=
 =?utf-8?B?d1g4aTYyVGVLdmxJck1OditWMm55a1ZLYWR6Ykt3TFVXaDZhU3NvNlV6NkpT?=
 =?utf-8?B?RklDUFBacy9JOHJ3YlgwaXkvQWpicW01L3ZKYkxSSDl1TnZsMDhTRk5FUno4?=
 =?utf-8?B?c0M2UUNwOHh4RnYrcHpTRUtkY1ZDK3k0TGVaUTIyejdNdEtnZTMwMFE0VTRx?=
 =?utf-8?B?NEQ3RERPVlR4U2x4UnhWYUowSFY3aXJRd2ROdG8vKzU2bThmd3RPcHZWaFhx?=
 =?utf-8?B?cVN6U3lCS3k1YW1aczNmcmJGRzhPbWdQL0R6TERURGRqdFVCSnM5QjNBZ2U5?=
 =?utf-8?B?b1JMTDl0ZHN5NHhQdVBlM3ZLbmJsdlVMWTBPaXc2bmNJVW1ZUG5WYS91ZWZP?=
 =?utf-8?B?Nk42TExuWE8rY1o3Y01pbi9zSlVBZUFQNCtXKzg2K1pRb3lTaC8rODNkQko3?=
 =?utf-8?B?MHVXYUdSRHZ2SmRHL2tGbzIrNjZrTmZBT2dMZlRjbVgyWGJpdTlQaDlBTDBI?=
 =?utf-8?B?VXRVM2Z3VnhrQ3Z5b1hXWjFjdGZMVzZoV1pGN2dIdGdtZlNNM2VBZGJ5aURH?=
 =?utf-8?B?TjFUak8vazRQdUs4WnJJY2RsN1JOenBhNDBERjJrNCtHME43S0hSdldjRXh5?=
 =?utf-8?B?TXNnelYzUmJINlMrNGxjZzVsc1ZzSDdlK1BWVVRRc0RGRVJ6MHBGd01aNWtU?=
 =?utf-8?B?RjM1RWRtYlVwQURUQ0pWZTJudHpmQjdlb3hzZjFxanVtTlYrZzlYSjZmQitZ?=
 =?utf-8?Q?8eutCBI7FRPml4Lp0layXi4Fc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a20b11-a90e-49a6-d802-08dc4da4830d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:53:34.9869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGAIptRAjTeZDHq3OrQAzhiwJN/yc3p45w29PRWfYYxgwxNJGnNALJCnptAZF9YM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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
    <div class="moz-cite-prefix">On 2024-03-25 14:45, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4fb3033b-a025-45ea-846c-bf97566d41e0@amd.com">On
      2024-03-22 15:57, Zhigang Luo wrote:
      <br>
      <blockquote type="cite">it will cause page fault after device
        recovered if there is a process running.
        <br>
        <br>
        Signed-off-by: Zhigang Luo <a class="moz-txt-link-rfc2396E" href="mailto:Zhigang.Luo@amd.com">&lt;Zhigang.Luo@amd.com&gt;</a>
        <br>
        Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
        <br>
        &nbsp; 1 file changed, 2 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        index 70261eb9b0bb..2867e9186e44 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
        <br>
        @@ -4974,6 +4974,8 @@ static int
        amdgpu_device_reset_sriov(struct amdgpu_device *adev,
        <br>
        &nbsp; retry:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_pre_reset(adev);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_wait_no_process_running(adev);
        <br>
        +
        <br>
      </blockquote>
      <br>
      This waits for the processes to be terminated. What would cause
      the processes to be terminated? Why do the processes need to be
      terminated? Isn't it enough if the processes are removed from the
      runlist in pre-reset, so they can no longer execute on the GPU?
      <br>
    </blockquote>
    <p>mode 1 reset on SRIOV is much faster then BM, kgd2kfd_pre_reset
      sends GPU reset event to user space, don't remove queues from the
      runlist, after mode1 reset is done, there is queue still running
      and generate vm fault because the GPU page table is gone.</p>
    <p>Regards,</p>
    <p>Philip&nbsp; </p>
    <blockquote type="cite" cite="mid:4fb3033b-a025-45ea-846c-bf97566d41e0@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_device_stop_pending_resets(adev);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (from_hypervisor)
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
