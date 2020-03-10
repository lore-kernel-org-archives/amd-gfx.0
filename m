Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E80C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A20424655
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JPfGfYHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A20424655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA8F56E1A7;
	Tue, 10 Mar 2020 11:42:52 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28206E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 11:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnlLQpsrbDONGL+gILCfAt3sOyjrcLhvBQ88rtwidfUPCYjHDO6WKNEi40jh1vR0uAVqHku0LW5TQGXQWuMen+POGfP0SJGeiERbrglcdS6mlxBgu0OprI9g9H1s9pu9tUWf3aGvJN2GyhTyRadn5HHL54XzVNeFoUopBXCQdaVNcNP04NdHCP/gDGaJdUL5Isnk1V4JbY7PK5ZIBQvn6Apsjgoij/3Z6f7544j/4gbUWrkrQs8Fpi+vI8IoiYMdE+iPESH18dNshuskpWinhhb72zzDWEunp5Mvffr1Y24bEPY4+1955E+A5vpmd08mwuVezQkPjxUntb4Yv0FvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NJYl26FSIuCRNWxe8b+AWkoWVHZXG9fE/FkWnY1W5s=;
 b=Frt3Ln44dkeuiWYWglZcSyGyopaXBELWvpgkKt3QagmbkR1rA/2GqgqrPL+vrnPg6iEg53wK0CqiDd9FCZqB4ONKJAh9J8rXzXuwqqKS5tcU997/Cmjq1JIaksJe9kon72Gu0MAiD/y/KCw981rplhv0ahkNEmhrPFYdQX7eyph/BHdQPKHbw1PkJVGHr6nVrwtdTghgOLqekKwSRbMRC/V2M072Uk1GhJWJkwrBwh5KJLJnii209UeXHEUYIrVEH9rl1deItUyHMl+3ZpdwqM7GlRp4dQ+wp1ZfUC9/BnWjfb6FoLCm+voEJ89+WfQT57iuE85lFdb/vxu4kcXHXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NJYl26FSIuCRNWxe8b+AWkoWVHZXG9fE/FkWnY1W5s=;
 b=JPfGfYHrzk4AnWn6ETEO3lreI43jMOYrhVKNvK+2S9ImOLwWQXEZ1AtoqvJISEEbRU3Y/O+2ao6YrIDYpci370hOKg0TXES/SYelMrxaxzv9F5PPcaG6jMHaEz59jVkWmfd+wRry35fPkvkUMIbTHoSdZh8grr1r7qP/YCXLr1o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1819.namprd12.prod.outlook.com (2603:10b6:3:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Tue, 10 Mar
 2020 11:42:48 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2793.013; Tue, 10 Mar
 2020 11:42:48 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: fix assigning nil entry in
 compute_prio_sched
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200310112748.4899-1-nirmoy.das@amd.com>
 <20200310112748.4899-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <543deb8d-484e-35bc-064e-0af421b08b64@amd.com>
Date: Tue, 10 Mar 2020 12:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200310112748.4899-3-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0085.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Tue, 10 Mar 2020 11:42:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9375a153-ec19-4b24-b653-08d7c4e82878
X-MS-TrafficTypeDiagnostic: DM5PR12MB1819:|DM5PR12MB1819:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18199526DD43BB18EEFA3C1983FF0@DM5PR12MB1819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(31686004)(316002)(5660300002)(66946007)(478600001)(81166006)(31696002)(81156014)(52116002)(16526019)(36756003)(66556008)(66476007)(6666004)(186003)(8676002)(86362001)(4326008)(6486002)(8936002)(2906002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1819;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEk4yAPGgqfrE+EEC2socxxrSaQiTixRLaUfmDSZ9vyCMng4UNZSLNFVOB+PEeG7Vd0OvICQuC2sEfoqFm7bpYZsPjjDLuzYUWnSiT0RxbLM92/ltACNBWTv+m+FICgp6aQyN87Pr0y6Q4sI6MMOEtmj4IlI/GoTEaQD2nDVkLO5m2AmtylRxG9EgYHcoxlJ6B+F3EaV9ASCILyzgBClztA8zNp7WrVvCaPVFz2V+iGz+tJ3IDTjxtd/DqhEXRipC2EK4Lv2GrDy5SVIjGbIw556UeGnJs0U+hQotYxjUed+FpTQxjowpDIk+GmCF1Fg5JKvrk3uB6H/JOwIkf/dPsho4h0m/fT00y9KsyhOEI+mZZV1ZL61hL/OJuNzscIOF+XyElTd8t2Im3prPyNWuC5SKhu2WPFAGtWktdk+BTTlUO93b086I/Da5wHFW3Mm
X-MS-Exchange-AntiSpam-MessageData: aJPyerIZmD7/9YSNgRtZefLIlDyK/elXhkT+8GGpBnvlWVeZbdtyJNsihUHxxb/Dfvf9XezHuN2kVnNEPRoOseVwrkiC8JQfF0JBCvH+Mjsbf+qnDtJdNRXNuNPHku2nhBjVSP5fqeN0qTUEiWlWDTweCKTEMUrQYY239/5zHbgv43Ce139bDXEaRVyUSYsW9C8MlDc4ltr+9SCZKcfPYg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9375a153-ec19-4b24-b653-08d7c4e82878
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 11:42:48.8250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNn4S/kadJ/AUQeq5lLDzZsqyjZ0DIzBWRkoJ6gQGAtpY6oCvLyVG52ktdUX8jVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1819
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.03.20 um 12:27 schrieb Nirmoy Das:
> If there is no high priority compute queue then set normal
> priority sched array to compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_HIGH]

Please move that patch to the beginning of the series since it is a bug fix.

Thanks,
Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 99875dd633e6..01faeb8b4ef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -478,10 +478,18 @@ static void amdgpu_ring_init_compute_sched(struct amdgpu_device *adev)
>   	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
>   
>   	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -	adev->gfx.compute_prio_sched[i] =
> -		&adev->gfx.compute_sched[num_compute_sched_high - 1];
> -	adev->gfx.num_compute_sched[i] =
> -		adev->gfx.num_compute_rings - num_compute_sched_normal;
> +	if (num_compute_sched_high == (AMDGPU_MAX_COMPUTE_RINGS - 1)) {
> +		/* When compute has no high priority rings then use */
> +		/* normal priority sched array */
> +		adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> +		adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> +	} else {
> +
> +		adev->gfx.compute_prio_sched[i] =
> +			&adev->gfx.compute_sched[num_compute_sched_high - 1];
> +		adev->gfx.num_compute_sched[i] =
> +			adev->gfx.num_compute_rings - num_compute_sched_normal;
> +	}
>   }
>   
>   /**

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
