Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D781AC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 19:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB4E60EFD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 19:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BB4E60EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50ECE6E8BA;
	Tue,  3 Aug 2021 19:51:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1EF6E8BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 19:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD4+C1Oa2AnszacnayhqtOenoxXlK2uyg7UtZo91TLNmQQCRfnmMxa/N85T3v+YiAOhtVr3R2EStNyTxLEAMelwtM0agdGUouyqNjtIqbcVB1nS0+vu1GBBKrj8JBCTrecSVFeNI7ffsJJxTgZL99LLmSvQRqEh4kTRMsN3dezq+8Q6d7ovU+bXxJWZ24pHI10TTJiWxYOY+DIJDBYIttC2BOX2CcL/je7+zjj9jsWyGLXTwWvICXxokvQjlAZ6F7dV+ScIRZfVXzoal1JGh6on70WGLiSwvLCNjiZ8BCdCwxb1LNV6FS2nxvR5uR732QUX45mi4p75DO7WsFOjsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxQGRJSwnMb9nk/6X4wOoqqEr6oVDezFj2I5z8eI0RQ=;
 b=ExJUbFrG8sNODHh9eEseBcqrSe45F8PPCQIdQNU5x/O+DF3taZUwardcuKT1qvFFdczFxsDLHrgKRrXeKfteOMtCy/OInbqHB7lEbdV7D4bnyGaou3u3OSyuNe4UWNhyyRPfJbPEL4h2QLhH/UK+8Vq6eTmC5nP5j23FwFsF6ceGQrICnFBzJs5N7fT6zGM+d9CWws3DkEzE1sAoyTS5s6wSNayYvtPzSC60bCerwQvUCM1Xpx0OwLj0z6Tnal0A8IJB1gfqJ7DFIhP9qBHE18f9OG/eSachjAUjcuqb7CjIpmrEcbb0eFH2uqsXv+Xx5S8b0zOPgRl0H6u9x185ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxQGRJSwnMb9nk/6X4wOoqqEr6oVDezFj2I5z8eI0RQ=;
 b=QXdV1HJrwquyWm2rATm9NUJJrZGM/KKNXQtF0ofnTAlQ7EqDmJVmyNVFO64iYwC3H6uGLsN3uObwoZ4LFARWsSHVk19TqG8p7w7bYjzTSNK1k4FLlSlnE64YrfA0bKNQkgTB/sz9n29oysf4fAxAbgXOETnN1irV8W9cxsehNAE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Tue, 3 Aug
 2021 19:51:18 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Tue, 3 Aug 2021
 19:51:18 +0000
Subject: Re: [PATCH] drm/amdkfd: add parameter force in
 kfd_process_evict_queues
To: amd-gfx@lists.freedesktop.org,
 "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
References: <20210803185757.1029578-1-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <6496cd82-5e3b-5ab7-2198-e7ac997443a2@amd.com>
Date: Tue, 3 Aug 2021 15:51:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210803185757.1029578-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::28) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YTXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 19:51:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37bb9e21-32eb-48a1-da41-08d956b80f53
X-MS-TrafficTypeDiagnostic: BN9PR12MB5368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5368E42982B3CE0643D037FC92F09@BN9PR12MB5368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0rfEhVd4aWaLZvjRdjYMpBpNVOkuTHLnjYOGg0rwDNjjBDuktRft3o3iYroGjtyvpkQsX3NeV2TtDXSualRpDrjvIq2uCPR8JKv73P1iYHM1ijP/uVuPfipVKl/04DW5KEvydScf6IKwdq+8wg6igAFSCFC6H5EI9Sq6ucCcMgEh57BlG2fZCt50EZq6VhmsZPDNVCs5hX9WgdCUq/0jJj+Y+L0tliToBIrwSV0zChCqe20bhnil9M6cpB+P89kuOpzumwJkjv66x06SQZfKvCXQkKfrUJ+pLfBea7RqezVjvZGUQYH0SW3mqw0Losq3teT+j2vrw01gGMCBKLKUX6qKM1YOpEdxqHJU0qbjtIaHQoDy68499UyaIN+DKNMAqch+3LdZyhqgPIKW6P4MXPGI+5XY2Yu6K66i3QT8rjJfmOBhR3y5eeqnenRnR+Oa6iVOf0dt+qIVBbClKxqagPgk3JAB4zYFqxlMry9MS3WsYUzXXCWfrCkMuXoOcy/AkwfgiKNs45ZR6y2MiCAUvCkRIr3XDwhZS+p/B3f7gmnQhvL811hLKVKMVnFbtuezHWy9nK2AWvv+Z6x+Ye3/uTA5ZLtLOk36O76bLLwRyww4K97JUP0H328hheNiAYPkMY6bld+Uc7hppV9zVaLlKSc5n+dngeRdRkixeIGANGDC/UjE5aMKbUS8c6tYhJIkKer/0XtBXRiCXQ9skUJFL/lL3VT6MbUmeO0Mt+7WefzW43ZceL12LEnw1EJOdWebhYxI0dYo4VWgBqJR0UGsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(956004)(8676002)(5660300002)(83380400001)(2616005)(44832011)(8936002)(36756003)(31686004)(38100700002)(2906002)(37006003)(16576012)(316002)(478600001)(26005)(6486002)(186003)(66946007)(66476007)(66556008)(6636002)(6862004)(31696002)(86362001)(43740500002)(45980500001)(524014004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCtETVJKbCt4OXNGVGtmVXhHUlJHcDJOWW0xMVBJRk9YM1BXdXUrelRqTUcr?=
 =?utf-8?B?cFJycFRuSEppMjVhWkdyVW9PbHBmMnZOSUd4YllJNENwQW16N2JrMUhoelhC?=
 =?utf-8?B?bWR5YUZETzYzdmFud21Fck10L0thMlhsVWh6UnJvdVFrM1RpRlpRNE5MYTJK?=
 =?utf-8?B?c1U5aFRZWHJQdFdIVExQOXBxRUY1ZDFRV1E3UElSK0dNdGVnSDRkOWJ6YzYr?=
 =?utf-8?B?bUkxOEYxU09ySTg0dUs4VTNhN2F5SmVhT2p1RjA1YkhPYTJiOXJsaFg5QTdX?=
 =?utf-8?B?eFpkSDYzY21ORkxZZndVTHdjN0Nmbk9GNTdXankrSVIzZ0J2cEIzSlBXT3Jx?=
 =?utf-8?B?am5EMktMdTZMTHVac05RWk1VOEsvb2pQVXdwWnhnYk1aS2IzT20vMTFsc0Zm?=
 =?utf-8?B?c2xiYytNNHFCWVg0YU1OYVE3T0lnVlpaWFZPT2p3L252WGY2cnFqemxNODFh?=
 =?utf-8?B?TGFxbFZVSkJ0N3VCUjZ4T0lyZmlmTTJMajY1NkNrZmltcW1lT1R1bFBlNTJG?=
 =?utf-8?B?QTdyU0RSZWJCT0FEWlhzM044N0N1T1AydTJTNHQrTDRDdjlyNy9iQnhIVUZt?=
 =?utf-8?B?UDBtcVBHVERldUlzMVZtV2JCRmFLemZIbEIxRjRjRnJFNWFYS1hFdTZEVmxt?=
 =?utf-8?B?R1BpcDFkWkhIQ1VvKzVjRjJWZlZBQ3kwbTA0Z3FMMEMwZm5oTDY2cTBjRWVt?=
 =?utf-8?B?eEMrNWdZM2doclRQcU82bm1uUDZEM2RaUGpIdFZDS1N6aTc0Rkp2dk9IcnVi?=
 =?utf-8?B?K0JCbUVhU0VDNitiWG5sU3BqUTc4SVZoMW15bDI5SFk3TFlBY0JUWWhoZ1Zh?=
 =?utf-8?B?dk1ITFFaK2tpbC9RTnF5OHdFbXhvMFlaQnF2TG82UnlHdTNWdlM3dTFhWU1i?=
 =?utf-8?B?Yzdpd0JqZUpJbUtVdE9wWFVobkJ6R2xEMUdQU1Zacms5NU1zOTU4V3EwUWlr?=
 =?utf-8?B?Tm0wcGEvRUFkK0VxOHhuWHFybGFrR2UzOE13VUsxR0NvcnFXTXdzbmJNRzFH?=
 =?utf-8?B?dHpHbVUyY0VqMkgvL0ozcTZUTHhoYlZnYkZzS09HVmwzRkR5Z3hEQzNkZHlY?=
 =?utf-8?B?em1uRXI2Y2R6OWRPbCs2V3JWMkY4Z3dEL0NQZTJDNnFlTzQxZndlbGs2UFdp?=
 =?utf-8?B?MEUwUWVTc01FVitCTDUvekJKL3ptZm9wdVJYM3AwU1BrS0NySWNzSlQ0Tldw?=
 =?utf-8?B?bTd6amcxNUxrM1BCT1ZvK2ZCYnpxWjZHRU5EWXQ0Z201UXVaZW0zbnJPTlVQ?=
 =?utf-8?B?VmtZTkhSQ0REUmRkTWV1bWhzNU1KRlZDbUNnb3BBZGhMaGk3MWNyUW16MldO?=
 =?utf-8?B?aGlxZEdUWXliOXJ6STNhVTJNbjRaOEprazhkc1AyUmRYM3ZEQ0VmWjQ4LzB1?=
 =?utf-8?B?ay9Ba3Nla1VSV01OY2FRMGcraXJKZmMrMXR2NjFZa0QzV2p3VzlXaitwUUl1?=
 =?utf-8?B?Q0VZTnZwS0t3SnRFbi9Cd3Y0V1NHN0hEVnI5TjBnS2l0WmJkaEwvK3NDVUNV?=
 =?utf-8?B?QzFYdjJMRjRCTXFPazdYbkQyUUdJZmtXRS9UMDNwL1gxMVJud1A0ejQyZVJ3?=
 =?utf-8?B?MnA1K1JRYlpBUmFWNmRoSW9ocFNqRVo5RWNhUFdlL3JuNEl0ck9LcTJEblVV?=
 =?utf-8?B?K3VNWjIrYUtWOHNKWnEyak1xWFhIN09OUEpWVHpPV2NmYjF3VnRNajBhNmR2?=
 =?utf-8?B?N2NPRDZ6emJLQTRiVUFFLzcrNXh2ZVh3ODFtMW9WbXR6N0ZHaGU0VmVyczBy?=
 =?utf-8?Q?L0LcSD8Sfk8+dFK6Ck3ecv2xsLWkdNRbQ6xHiQx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bb9e21-32eb-48a1-da41-08d956b80f53
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 19:51:18.2453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVHI5AiYIa9qvVhmgLDhvpV9SCPy/oGcUEBivgW89vtUEXGCobS1fkQHNhUqGuI5gqhPDy4L7FkhxmCD7/4caQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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

m 2021-08-03 um 2:57 p.m. schrieb Eric Huang:
> It is to differenciate case scenario for proper behavior when
> calling evict queues, such as GPU reset doesn't need to roll
> back restoring partial evicted queues.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 10 +++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 18 ++++++++++--------
>  5 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 77044e8ba4e6..59ce5a17a834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -190,7 +190,7 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>  {
>  	if (adev->kfd.dev)
> -		kgd2kfd_suspend(adev->kfd.dev, run_pm);
> +		kgd2kfd_suspend(adev->kfd.dev, run_pm, false);

If suspend fails, this should return an error that should be handled in
amdgpu_device_suspend. Maybe this could be fixed in a follow up patch.
This means kgd2kfd_suspend and kfd_suspend_all_processes should not
return void and return an error code on failures at least if force=false.

Otherwise this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>  }
>  
>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm, bool sync)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 332ccba00e69..b7e46ad0507e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -372,7 +372,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  			 struct drm_device *ddev,
>  			 const struct kgd2kfd_shared_resources *gpu_resources);
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
> -void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force);
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm, bool sync);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
> @@ -407,7 +407,7 @@ static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)
>  {
>  }
>  
> -static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> +static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
>  {
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 24b5e0aa1eac..48e51ee8de56 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -940,7 +940,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  void kgd2kfd_device_exit(struct kfd_dev *kfd)
>  {
>  	if (kfd->init_complete) {
> -		kgd2kfd_suspend(kfd, false);
> +		kgd2kfd_suspend(kfd, false, true);
>  		svm_migrate_fini((struct amdgpu_device *)kfd->kgd);
>  		device_queue_manager_uninit(kfd->dqm);
>  		kfd_interrupt_exit(kfd);
> @@ -965,7 +965,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>  
>  	kfd->dqm->ops.pre_reset(kfd->dqm);
>  
> -	kgd2kfd_suspend(kfd, false);
> +	kgd2kfd_suspend(kfd, false, true);
>  
>  	kfd_signal_reset_event(kfd);
>  	return 0;
> @@ -1001,7 +1001,7 @@ bool kfd_is_locked(void)
>  	return  (atomic_read(&kfd_locked) > 0);
>  }
>  
> -void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
>  {
>  	if (!kfd->init_complete)
>  		return;
> @@ -1010,7 +1010,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>  	if (!run_pm) {
>  		/* For first KFD device suspend all the KFD processes */
>  		if (atomic_inc_return(&kfd_locked) == 1)
> -			kfd_suspend_all_processes();
> +			kfd_suspend_all_processes(force);
>  	}
>  
>  	kfd->dqm->ops.stop(kfd->dqm);
> @@ -1122,7 +1122,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
>  		return -ESRCH;
>  
>  	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
> -	r = kfd_process_evict_queues(p);
> +	r = kfd_process_evict_queues(p, true);
>  
>  	kfd_unref_process(p);
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 3d5d3994d8a4..e80fb64a6dcc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1042,9 +1042,9 @@ static inline struct kfd_process_device *kfd_process_device_from_gpuidx(
>  }
>  
>  void kfd_unref_process(struct kfd_process *p);
> -int kfd_process_evict_queues(struct kfd_process *p);
> +int kfd_process_evict_queues(struct kfd_process *p, bool force);
>  int kfd_process_restore_queues(struct kfd_process *p);
> -void kfd_suspend_all_processes(void);
> +void kfd_suspend_all_processes(bool force);
>  /*
>   * kfd_resume_all_processes:
>   *	bool sync: If kfd_resume_all_processes() should wait for the
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 38a9dee40785..a41ece37bc3c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1875,20 +1875,22 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
>   * Eviction is reference-counted per process-device. This means multiple
>   * evictions from different sources can be nested safely.
>   */
> -int kfd_process_evict_queues(struct kfd_process *p)
> +int kfd_process_evict_queues(struct kfd_process *p, bool force)
>  {
> -	int r = 0;
> +	int r = 0, r_tmp = 0;
>  	int i;
>  	unsigned int n_evicted = 0;
>  
>  	for (i = 0; i < p->n_pdds; i++) {
>  		struct kfd_process_device *pdd = p->pdds[i];
>  
> -		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
> +		r_tmp = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
>  							    &pdd->qpd);
> -		if (r) {
> +		if (r_tmp) {
>  			pr_err("Failed to evict process queues\n");
> -			goto fail;
> +			r = r_tmp;
> +			if (!force)
> +				goto fail;
>  		}
>  		n_evicted++;
>  	}
> @@ -2079,7 +2081,7 @@ static void evict_process_worker(struct work_struct *work)
>  	p->last_evict_timestamp = get_jiffies_64();
>  
>  	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
> -	ret = kfd_process_evict_queues(p);
> +	ret = kfd_process_evict_queues(p, false);
>  	if (!ret) {
>  		dma_fence_signal(p->ef);
>  		dma_fence_put(p->ef);
> @@ -2147,7 +2149,7 @@ static void restore_process_worker(struct work_struct *work)
>  		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>  }
>  
> -void kfd_suspend_all_processes(void)
> +void kfd_suspend_all_processes(bool force)
>  {
>  	struct kfd_process *p;
>  	unsigned int temp;
> @@ -2158,7 +2160,7 @@ void kfd_suspend_all_processes(void)
>  		cancel_delayed_work_sync(&p->eviction_work);
>  		cancel_delayed_work_sync(&p->restore_work);
>  
> -		if (kfd_process_evict_queues(p))
> +		if (kfd_process_evict_queues(p, force))
>  			pr_err("Failed to suspend process 0x%x\n", p->pasid);
>  		dma_fence_signal(p->ef);
>  		dma_fence_put(p->ef);
