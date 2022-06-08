Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8BEC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 19:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215721123F8;
	Wed,  8 Jun 2022 19:31:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554E2112460
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 19:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFf+nn7iAwo+imwqeMn3GIHuFDf4Ojbn98F9xkkWtLftEfn5kNDFTWYcJFfay81AP2FoKEjH+S6nUPWiuxdXTEMEAvXndtzBCHrwFjY3/um9zZkAq6zGnFiEmetiYJLBI6BhLS8gM6Ao6N/b4Gf8tzYCHbJ2aVfU5rOUYD4SFCrcRQyxOzBoSUsO3Jz07GwHV8m8XmcGEQ6OukRTqt7uV0SkMJ3TM0To1vu/LIS6meN5a0h/ZTA4lbBx1KM9/Nj/8ABFRgep6umtCyeLO95JRXGFSQUBRCXntswDX0GratrGQ/Vt1y3ip3bW7cBdFc0z7pZtsQWgwXsmDCaY3al3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAQX+a9LkUwMgkN5eg/E9Y7QscE7zBF1z96QJTjnX7M=;
 b=mghEnp7UcybnddKSZ/2TiBpRaxViQN+Q7fbAXGLAHPQT5m/otKcXsNZ1WbPsVcBVdZg02ZWJDPF+3wvOVZCzS5TvNNPUwqRD8NgEQH90VpT34Gx1KHEf7n2o5rPw2kiquVj94QeIE5GtxxzgN0vnA3Qeci2g2eb1amekYL+FjFJProDa4WzZpfms6KhLEvl2UFscwvxaPXqWdyDuqFj1M1/jr4dtimRHA2Nr7fbjD+4W+5EsHPWLEvr5h9EHU+8kNitMWNRC9xpZRRGmhc2/Fxh0AWXdTKPHgRm2RWBQGHxJ9Vlf/IATeBL62NSdDXRjjSf3JVSJUc029IWNc3pVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAQX+a9LkUwMgkN5eg/E9Y7QscE7zBF1z96QJTjnX7M=;
 b=iyyQj7troAtuOnW2JjRQF9eFqJDIbLIvlw2G7PY7eZyyCVrK0fFCrITPDtqqBUK9yQA5imz5w8mMnbS11jukZZ++gGQyLoTJTspDY/hePjmO01tNVsxMU0JnsVygaA/3WXMr9dpG6V/wYyFcF8oANn2NcMnMoH833d9bYK5TGE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Wed, 8 Jun
 2022 19:31:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 19:31:19 +0000
Message-ID: <74f62219-6f2c-c4d4-566b-6e0017151e91@amd.com>
Date: Wed, 8 Jun 2022 15:31:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] drm/amdkfd: Pass MES/RS64 information to sysfs
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220607225007.1372343-1-Graham.Sider@amd.com>
 <20220607225007.1372343-2-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220607225007.1372343-2-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:610:5a::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddb7fb62-c681-471f-be21-08da498576aa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3022:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3022E9D943C339F7434FC5EC92A49@MN2PR12MB3022.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 359EezuVfpk3LKobaXpZpxqO4J9Kf2ErJWTZ/pbCg/HV4tJbkC0/M4T7NzBHMs+NJvw8WqXoQBTSgzJGDJPOdDnuEtJY/SARYB4Trdxmu1RMpTX+2qUnthudSNTsi5HhW9EUdQ45os/ZGQiQ2K3q4eDeOBYkTPzYDCweNDNmyXQfxgxtDK8SGBlE6fb8TGuNsr0AwmR3xzU5mjQaW+rvjJRgkzIza5LrhWVCfHE+nS/ppKXahSnALzgbOIhyO0Lx1dyh/ywJB6UueRwmpcmZ3xrd9+HsddkIS1ySdVqrhv2poeAz0TL7Z2g6zyDsI48mNrQLIoujej7EMepVErJuU95JLqwomCrNnq2munNL2cueuNXEQBMMyjBrZo2WDE12RfN23p8QboiZIA82lhF6d4E+Y81Q+cEn7jNQ7UfX945BII5HzP45a2lAK7scWiQ9JBR0vzqLp6/dHlISUPlEhjr4MNKtkOW9wJ/Cq/5DVLlscmmEB/7v3yEJ9540KFAiiRsXg3mVPomblHbr++RdHZOTqVuyToc7bAehF/IoHNxRaxqWKx3DcMXdgz24pUprQ83UJd9wUwSViksSwj7HC3oRn6N7Erz9txMW0wKhVb1neiRc9mIPwXR3KhX4nNVqcEPGgla3F1myHFHPXfqB4JJDFULK+L1Rhx7/Uon0I4ZvoTt2K0Qtlovcl6ECb0AxFvtzdIg2n+djIonKN5EgvRA2W/XFTa0BnxO+sFDeDkNDMWNemtwCcrsyHv+KDTBQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(66556008)(66946007)(8676002)(66476007)(26005)(36916002)(44832011)(6512007)(53546011)(2616005)(6506007)(86362001)(2906002)(508600001)(8936002)(31696002)(316002)(31686004)(36756003)(186003)(5660300002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndBWXhLV3pnYlcxL3BjSmdyU2ZTYlgxUWlscFYzeWUwb2w5d1k5Z3NlRmt0?=
 =?utf-8?B?bzQ2ZTJmVk1SVXdidXRRYlYzRjBwcHlvNHQzNDZwVmVPTTJwTFBCZmtWR09Z?=
 =?utf-8?B?OWNPWFBXL0VvY3pNSU5tK3ZXcEJycS82OGFsL3E3Q2hTZHFld3Zlbm1RdC80?=
 =?utf-8?B?aS9ZbXpQY1ZJQkw4cmpYZzE3b0RIZ05yTm5yTTlWa1BHZG91MThxYXVXTzFi?=
 =?utf-8?B?ZnBVZUVXSjB5bkorcTlvNURqK3FNKzlFQ0VOVGxIQ3U4MXE2anY1cGpBdURR?=
 =?utf-8?B?T2toNHRNR3ZMY1pIVXRGZSt6bEhoL1NkTW9QYmdNbkhKOFJGVXd6a3RHUEdL?=
 =?utf-8?B?KzJIUmZqRGpDWUlPRDZPb2VvU2NxZzhCTTlocU5qS2lrWlJucDRKalB6ZXpC?=
 =?utf-8?B?d3NkVWUzR2c0Sm14NzUycitGQUovZWwrYmRrYU4wczFhc1hGVm5nMjRMb3l2?=
 =?utf-8?B?eHc0U2N3OGFFUXBJck82QUlmUUYxZzN4aTIyR1RkVEdIa2lSdVlxYkVrdUxH?=
 =?utf-8?B?OU4rN08vNnpUZC9uTXozeFlKTDFFYUxMOGxjdmtQbG13dUxzTWQ2Si9CNWxB?=
 =?utf-8?B?bkRMLzZNbExKQnZneVdEWXZocURUVVl2OXJxRDBpZ3lLMmpoaVhqRUNpb2Zo?=
 =?utf-8?B?QVlGM2Y3bHFvalkxMzd0emxYeEFIMjd4dnJGdldIZXJPT28zbE5oQmtSZmxa?=
 =?utf-8?B?cjc0SzN2WG5VU29CWDVxR0g2YjIwUUlnb0M5WGdieEZ3VGdXa0xnSCtHVVNC?=
 =?utf-8?B?aUV6Mmw4MVI5by8wTjVETzJLTVhGWGRXbHBBNTZZaXVMb0RheDdFUjFrOThI?=
 =?utf-8?B?d205cWduNHRLN3IzaE9ibnBzenFoOWt6bUVhUXNGcDdKSHdlWFBLSDJyQjEx?=
 =?utf-8?B?Y05VOXd2ZGYwRG9NdHk3SDlZeVFnUGRUcERRaWRwWmtFaVdiYnpablVPTFVB?=
 =?utf-8?B?b25pbmlHL0xVZlU1WHlUTXE2amE1cEdxUTV5RXROSDNkV1plUElGTHc0cnRa?=
 =?utf-8?B?bURqZFZ3Q0xwaGF5Wlp0S01rN0NPcmMvekxyeDg5eXM2T1p4bHBZY25XdjVD?=
 =?utf-8?B?NHZwMXRZRjRVUHFZdEN2TWsrVndsYUZJODZtUXVKQW8xRU80cWdrb3ZkdlNU?=
 =?utf-8?B?ZGJlMlZ0WGNTaUdWWVliMlUrcmR2MWtPdGhRd3JEUHhvYmFuSjFjSksvMWZj?=
 =?utf-8?B?K3BtOUQxekYvQncrbkE3Mml1aURZbFYzNlRsdmFydDZsZkpVclEzTjJGTkZT?=
 =?utf-8?B?dUNld2VNdXBLZkdzTFdUMmVWcC85WE03ODZmclJtQlFDNElRcXRFRUttTjJa?=
 =?utf-8?B?U3hjTm5YWmRtU1dmWHpxZDdka3RyOWNXNEhqV3VMVmZVSEEyd2trSDBFU2dK?=
 =?utf-8?B?WGFjbDJEL2VYWUoreEZUY29yVUZQMElheU5zbVFHNmh2VVNyZ0lLaGhraXZi?=
 =?utf-8?B?MjZVQjBzdFpzeW0weVVRdmRvVHJOa05weFJjejZkazUyN3ZUK0lURGNOL2o4?=
 =?utf-8?B?dzlmUWhHanFBRkRUbit2SVhoZks0MUxmYWNEeDZQV24xdFRReW82aXM2dVlp?=
 =?utf-8?B?OUZ5YnY2cm1rZ3JWNFlhalRLWUJNMlNXK3ZaNkRXeTc1cnBBSTRhMG4waVJL?=
 =?utf-8?B?UnVFVHMzeUZsbVdJMlBzWjVBcFBlNVpKb1paYU4ydHZNb25tQTBqeldyczhU?=
 =?utf-8?B?ciswelJ5TFBDdnUwV25GeExwSjQ5RW9Wa2tUZWgyTjVFZk1mVnhOYzBzZWJl?=
 =?utf-8?B?SkVCTE1YN1FzV0E5citqdTBJd1p2REo0LzVSY1BwcGZKNnNVSitkelk5cDZY?=
 =?utf-8?B?dUEwYXFLV2hOZWF2RUxrckhoRHBteXZ2S01QUFNhN0VjS3N6Q1lnS25wVUlB?=
 =?utf-8?B?Mk1JMVFoQmlqYkt6VUVxeVJua2ZMNUdwSm1lNEV2ZHl3VnFpQnJWRSszMHlT?=
 =?utf-8?B?REtSZUNma3ozMjBRZTNQcUNRaHR6L0k4RmpYY0p5UERyOHFHWW5EbXU5M0tx?=
 =?utf-8?B?U0t1MjFhbVFaYWZvc1ZQUUZXV2IzRnp6NjdTQTYwTS9QZkR3SlhDOUV0Rzdo?=
 =?utf-8?B?OWtqUGFidTJ6Mk56K3I2UC9hbjBWS0ljenQ2dTZERFVEdG5EbW9uNDYxTTU2?=
 =?utf-8?B?U2pjMm9JeFM3Z3cvNEFabHhMeTd2YkNINktBTU1ocnJCYTZ6QTBsNEM2bENJ?=
 =?utf-8?B?YkZCSXRBVTI0OEtSOERLSEJKVGZuZHZwWXhrK3Q3QW94YWtVUE9qRXF2UWtG?=
 =?utf-8?B?b0E5cWdwM2pOQjhZZ1k3Tm5RNlBFLzV3ZzArWGplSmFxdEhvTWZyVERicnBl?=
 =?utf-8?B?VDlkcVVqZTA4WDM5SkNzaGh3em5kc3dRMG5ydmdRQ3ViTU0vL0plZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb7fb62-c681-471f-be21-08da498576aa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 19:31:19.7975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wQdR8aOK0h0aFP5IIED3DCcClbYdfOefi9PLQt2k1Zj4soeoCnFe+91Sq2WJVtHGGvp+xHFggwr+H+8ix+FpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3022
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
Cc: Philip.Yang@amd.com, Mukul.Joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-07 18:50, Graham Sider wrote:
> Make MES/RS64 CP enablement and MES scheduler/MES KIQ versions available
> through sysfs.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Why do we need to expose this to user mode applications? They don't 
interact directly with the scheduler or the KIQ. I cannot think of any 
reasonable conditions in usermode that would need the scheduler or KIQ 
version number. It may make sense in debugfs, but not here.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 02efae4f5549..51c8a285baaf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -571,6 +571,14 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   				      dev->gpu->sdma_fw_version);
>   		sysfs_show_64bit_prop(buffer, offs, "unique_id",
>   				      dev->gpu->adev->unique_id);
> +		sysfs_show_32bit_prop(buffer, offs, "mes_enabled",
> +				      (uint32_t)dev->gpu->adev->enable_mes);
> +		sysfs_show_32bit_prop(buffer, offs, "rs64_cp_enabled",
> +				      (uint32_t)dev->gpu->adev->gfx.rs64_enable);
> +		sysfs_show_32bit_prop(buffer, offs, "mes_sched_version",
> +				      dev->gpu->adev->mes.sched_version);
> +		sysfs_show_32bit_prop(buffer, offs, "mes_kiq_version",
> +				      dev->gpu->adev->mes.kiq_version);
>   
>   	}
>   
