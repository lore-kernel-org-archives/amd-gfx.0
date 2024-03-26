Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BC0C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 15:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70F010EBE0;
	Tue, 26 Mar 2024 15:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ATfCwHEs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2129.outbound.protection.outlook.com [40.107.223.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09E410EBE0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 15:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpHj/RHgP1MShthGxEwMIPWPuMxgAi05MfDfUjiKDnXcJmE2cMqawB11h3id8rvSBOx/XTOHkJfLddUlGAFIjQcMSAzw5miMfaEstxuSgrVRaBojKUkcF7kc/j0AcxYgX3194U/yQxv+jGlnY/Kmn1tpJS29hi1w+ijh9MXW301N0GJRQCV/qYV1fY86saiLGXl5hUzI6J1ZjT8IXn7gW+R+1Wo1HYPyE3ViOYrLMWMHpDvonN/ShBcsEOVMnukOUWv2CgN0FME01yyzyvj2+Veb9t7LadwPWzbtfUE2d0i/ZXgw6pIaR6MPAlfuBnwwt4zg4IJSuFxukjeo7JHozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67ozKB0f5xPSnhsFUpBOvOF/jbdg05lJtfgywtmb7GU=;
 b=IkkNlHScgB3krTmcpNmPY5Ejp+WtdQBpaA+fV99gCm+pugygi/zMotjf2tJAEdhr61BZuuxR9WZXJcuVsg650sJaQkaSTFK78uDLew2IIdMFntZfXOvHqKln3esX7hvsrd4g2JzcDUElbDtDBaYy/qVYln+/ot8MJD3+9H2nSLn2Ak1oBO6k3wir6CdMQDkGin0g6LbPg83gR0lCiUkfrjOjQNkrwT0c2C+0YfbaHSbCb1UfPm02IfuEkJ0vCSMAhxUFN9dOV7WekqhqAXIEXhqTP+fhavALqKubO/LXnXNgH3IUKFXWpW9QZ0KpazalFIUBq6Pz5wOwCECehunROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67ozKB0f5xPSnhsFUpBOvOF/jbdg05lJtfgywtmb7GU=;
 b=ATfCwHEsp3VQ1ktE9jMIwHq4ZIbnLUVuEGfR1016fXDI97Dr4VrR7NDBoP2LtmfNmChjaASATwnJSc5K+0iFHk58Y8ry3ZvGSuhVwsre61liIjGFH65bgq3R84aEEdpRXDeKLEPPuLoI649zod+3uCiSRbtLbGEgBzEubXteOMQ=
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 15:28:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 15:28:59 +0000
Message-ID: <19bad178-3f2a-bd09-8a95-abe7afd1b743@amd.com>
Date: Tue, 26 Mar 2024 11:28:57 -0400
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
 <4cc67abb-c0e0-414b-353c-9f364cd0888a@amd.com>
 <1bc4dfcd-79ed-48b6-b5c9-9a2d9e5a393a@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <1bc4dfcd-79ed-48b6-b5c9-9a2d9e5a393a@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::39)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN2PR12MB4334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7EOIoRm8JHa8w9fvrdHZ8MstlYdM1bMrysgv2Lb3p80/I3mror0C05lMzxtVKn5zBokqwj6m6+mwD63vD8Mjlk1p+cTD1tZdNtSYlwrPePwsjzf792k7pC37hy6GcYR6stg9PTiFG0baFROEVfVfOMfrJRMuJItFHQM66fCRr9z1TnXkyMm7ssdHrXaI/SdohS8b8DMRHbuIMKMyAIUZoaau7TMH2kWusvAL/Z07o2oUvuHy0QjAdNT6BbMoJ4tiaJ98qk37wKE8RUm/BS1Mrn0IElwO9h6IXfDYiJN359B90auQk7f1JYHKIbNtxoQ4HMUr+ifa8I+1Xt1aKIOPq1+fjKmZzS5hicZO5p2cCOYvpD7nuYv/so3i3jS8elql+k+atkE8PshgWFXvhHQZ2DYI5om6gbHbmOwops7MBaB74JhO+0cTgBPwuj2MllquV/8ZKqjKozHtE1hQ0yWmYs0be7JFMtrkknyuJHnFL/9T9e2L1cwqVUpKIFuRKafXEBrpOSD+9A40Nlm5Wp5APqaUh9DhOB3bv3VI0y9cGOdDC/dEZcjdWgr7TZfsDc/6z2UqvgwE7/2PbnoKEogPS7puCFG9Anj7eitvjQtpv5G/0EN1tneH564xQuxjGiLb0lgSCl6XwW5DZxsezzPOlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FSeDZIRUpuQi9YdXpaeWR6ZFZFYWxLbUdyemJkUFZ5Ty90aXNjRERVaWls?=
 =?utf-8?B?RHJtNlVSdm5YOWRDWk9GcG1JUmIvbzAyUnZJK3EwVFRDMTJ4cVgzTGJzM0Nv?=
 =?utf-8?B?aFFKWFRNUGV0ZFc4UXBtQm9QVG9nR2RYK3NJYjVWbTBDNEcydU9QQjJhU1la?=
 =?utf-8?B?a0JBMFpia3d5c1Q4QnAxeFpTY2NsK3BLRDFndGkvVTFaNnNWYW50VkFXNlU5?=
 =?utf-8?B?UnlRZ05IZmNjaGRQYVR2eGNGVWZsc3h5MkE1TG4xbWhVNTZiTVJjL2pxUGV2?=
 =?utf-8?B?c25sSEh4MHY2Mk5wRDZOV2w2aEpnTVlJNlE5SklaTjFPRkJnSzdXcGkyNEV1?=
 =?utf-8?B?dTJXckhvY0xlYUVoakFtUU1PdHptSENmZVU5NGFSdGpXWlQyQkEvclNhSHh3?=
 =?utf-8?B?OWlKV3BNd0VQcjR2ZTJZUGFIdTUrR3ZabkFYaWd0THM0bHEvUTJWTjV2NHBP?=
 =?utf-8?B?K1dFYTBmN1dXVkJ3emMvQkdTdVpjTWtXNDYwemFJK21CNGJESE5MNGRZaWpX?=
 =?utf-8?B?ZGNUSzQ2RUE1Z21GelJVdk5MM1hrTCtXb1JGZnJ6NkY4T1J1SWVaNnh2blNh?=
 =?utf-8?B?cmJ3Q2M1TzdFaUpRT3FIcnBCNVNaMCtvSmtEN0pRNTZGemc4MFZnK2s1eFVs?=
 =?utf-8?B?cXcxaFhmS1JOWTdTaHRXUFpkMGNKcUNkQmUzcUtHTnZtTGp4a0NmczBBOXdH?=
 =?utf-8?B?WkRXa1ZnVDFvWHhPZnNBMldlRlVZKzk0Qk5BOVBvNktONW9waE9BLzIwNzZm?=
 =?utf-8?B?Z0pZWDNjdStpczVvV1hqVDFMSm9CbTdRUTU5Z1Jwbk9jdGNmb3g3L1NLV3hI?=
 =?utf-8?B?ZE9TZzhDK3JJUkw2clErQklpcEpIT3IzTndsWkg3cWZpdjdVeWFuZmw3WlZL?=
 =?utf-8?B?VHgxdjBVUHcyZmk3R0dNNkdoWVpoMUVFWWFLK2x3V2hwNS9HS0FINFlYd1Bz?=
 =?utf-8?B?ZElPUzcxLzFDVGkzdHdOVXJzenFqYkRFNWk0V2Y3MFU3aExzK1pHcW5WMGFP?=
 =?utf-8?B?OEcrRllVSTA1Wms0U2dzRnZ0aXE4OWdPQXZpN3pnQ25MaVUrQjdDdEFNb002?=
 =?utf-8?B?V3V6QUU5VS9PeUhBUjAzQWp6cXBrR2JWNDdPVkZVaFVOMW05YVFZVitpVUo5?=
 =?utf-8?B?NkVHSmMxWC9wQnMzdm1SZHhmQVlhL1BuZHRnZmVuUW5vV1BXS21kVzN4Z016?=
 =?utf-8?B?VENYTEtkRFNTQWlyNWZFdTcvOHNabi83ZWsxY0RuUVZiRUZqQWJkWTMrVC9P?=
 =?utf-8?B?MlNHdFBYcnE5elB5MUN6TWQraTNRZTRzdGN1ZUdyNlAwcTdDdFlTaFNVT2lM?=
 =?utf-8?B?QXpScjNJQ1NPdGN1WWI4cVBMZkVGU1dWa2pJM2NFbXZrRGNlZi9jSDhnSkxv?=
 =?utf-8?B?NnNDNlR4ZElKaTNKL1lCM3BnNUpwUjRRcURzVXdMa0J5bUE2UldnRXBvK3dt?=
 =?utf-8?B?ZSt0SHJEU3J2L0hIbndxUzVJNG96RmRRTUltZURXQ1lMc2xNaTR6TkRoankx?=
 =?utf-8?B?TnVIMUplTmtLMHkyaURxWHFmQXZmeXVWeGdCUzRhWWt1VDVIYVArK1JlQ05o?=
 =?utf-8?B?RU5EVytMc3k2VzlVS3F4dUdsMG83NzZZUnR0SGJycE83dUM3SHJyUWZoR0w1?=
 =?utf-8?B?cmRqMmhhdFBveGpxMzVZdUlPSStzNWtWZGtESnBuS0pQc0xrRjFKcSs4VHRP?=
 =?utf-8?B?YVZCWmh4MWVFWldMeGMxVEV4QUhreWJ4aGwyTWJqZXk2R0xHVGYwQkFsdlll?=
 =?utf-8?B?bXFmQ1UwNXhsNTdpNU5NMU1nNzNaMGhLUDlWK0lZY1l0VmRtUFBjR3NNMUFJ?=
 =?utf-8?B?V0FleTVYREpzVkQ3SWYzenFMWEFnR2hZaEI5UlUySGlkUldpUmFaTDVwbUpa?=
 =?utf-8?B?K042NUhyNCs1VDlRWFNVejROaWgvOVJ3eEVsYkNJemZSa0lUbVJOeVlUSEd0?=
 =?utf-8?B?bG9ySG8xM1BuQ1NTZVMwQmJtTnFHVktWT0xrTDNsdW9BWGhYRnI3ZkhXYy9H?=
 =?utf-8?B?NXkxMVFpLzFWcTF3N0s3a3AxY3hNVkRlR1M1SUNoRlVXdlBjeFFHOVduTExL?=
 =?utf-8?B?ck5GSmplSjdvMnNlYnZ5SEM3TUZRU0ZJejdkZGJ4dmVXdUFlUmtnWmpITElP?=
 =?utf-8?Q?SU1kWnzi18jJ/QA4+wm4OOHJF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029f96e7-8325-48e9-db17-08dc4da9751d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 15:28:59.1994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjKcN208aPTgjhhI2nFfYDf/Hy2HhBzXeE5IAFufxJJTp9OBUTWw8hcvSGkTEr9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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
    <div class="moz-cite-prefix">On 2024-03-26 11:01, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1bc4dfcd-79ed-48b6-b5c9-9a2d9e5a393a@amd.com">On
      2024-03-26 10:53, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2024-03-25 14:45, Felix Kuehling wrote:
        <br>
        <blockquote type="cite">On 2024-03-22 15:57, Zhigang Luo wrote:
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
          This waits for the processes to be terminated. What would
          cause the processes to be terminated? Why do the processes
          need to be terminated? Isn't it enough if the processes are
          removed from the runlist in pre-reset, so they can no longer
          execute on the GPU?
          <br>
        </blockquote>
        <br>
        mode 1 reset on SRIOV is much faster then BM, kgd2kfd_pre_reset
        sends GPU reset event to user space, don't remove queues from
        the runlist, after mode1 reset is done, there is queue still
        running and generate vm fault because the GPU page table is
        gone.
        <br>
        <br>
      </blockquote>
      I think seeing a page fault during the reset is not a problem.
      Seeing a page fault after the reset would be a bug. The process
      should not be on the runlist after the reset is done.
      <br>
      <br>
      Waiting for the process to terminate first looks like a
      workaround, when the real bug is maybe that we're not updating the
      process state correctly in pre-reset. All currently running
      processes should be put into evicted state, so they are not put
      back on the runlist after the reset.
      <br>
    </blockquote>
    <p>Forgot to mention it is F/W hang issue to trigger GPU reset,
      there is also error message when kgd2kfd_pre_reset -&gt;
      kgd2kfd_suspend to evict queues from the runlist,&nbsp; yes, this seems
      W/A for the real issue related to mode1 reset.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:1bc4dfcd-79ed-48b6-b5c9-9a2d9e5a393a@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          &nbsp; Felix
          <br>
          <br>
          <br>
          <blockquote type="cite">amdgpu_device_stop_pending_resets(adev);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (from_hypervisor)
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
