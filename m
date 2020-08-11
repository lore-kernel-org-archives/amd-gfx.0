Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F037BC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 16:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9076F206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LcwZDkqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9076F206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2816E5C0;
	Tue, 11 Aug 2020 16:14:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E858B6E5C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 16:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxOQpbIRbME8+U1VhVgYyUMdn4Tz0Y26iGzvc0f9Cj5qrcGvkEr9Shoxa09n1ZqTClxgPt4oyOYXXyYm2gO0EakODcxhYGdXHGpvsVSD0h51wLrQvQnfrU3fQvskZg1UNpaLQ+hvunlOFd6NNvpA5po5+Fhl2NEzhwLCXHl1nethULZzmm7ARdW10jG4Gw+Y/EI5q+R5m/DoLi1r9ZQVnbhZoIEBv7gcR98G1Sq01Z+1XkK1T6kn4Gf6xvR3+d7uwcYiEvTlpbcT8T7XGFm8iYkO6+0kY4/0hjv+LVZ7yDowlFekLj9OVu8mIwMs1PpAQiFKAnupVcjliAW39QVtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK10fMUnKbywoMNYNlu4V4ACZz9sNRf94tPZhFXvYPk=;
 b=PTK5FR6pSyRxQyYok2IwF22gixAg3QLOkkRST4G9jmwDC0X6FtEHzBhju08UMiBG854zyw38MbKsMqWbhDobryS07Dcm2SLHNPAEfl2p0XRgXY4Y6VI2UuRbsb9SJ7c9QX8QdV2FFYsPFsy8ga6EY0Ag0Lpu8rYQIcJ8Y7PHzo8JrSp33y4UuBd0cHu0Yqqa5GcBVM3hl0SP4umeO+j6ATgRIIFAA1STl+XpyDWBoFRrYUWhBHe5d/52209IoV01Z2ukS8GLXFv8mZbP5IQ7QZfRQtFvhDsnlKCJdqR3YGvU1cqw+KCGQYoOkaKjDflq1gVHCevGVHsrl4aGyOdlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK10fMUnKbywoMNYNlu4V4ACZz9sNRf94tPZhFXvYPk=;
 b=LcwZDkqOCtn5IJJVIS5FJW2MIfZ6/QZ0JYovPj7n7oQaojAFDWEzU8yK42pWXCOXPhJRawOVBVzSahhRq7s41hp0UzH/qHVXLdyTnT5o5y82QUEyLX76AFRhhZUNmAfeWmDSEkqcTvVdM+i9JyNNHCAvtCO+WQG3vglXD27HLaA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 16:14:08 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 16:14:08 +0000
Subject: Re: [PATCH] drm/amdgpu: note what type of reset we are using
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200811160457.1073325-1-alexander.deucher@amd.com>
 <20200811160457.1073325-2-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1579beb2-5cc4-624a-e211-3f2681374be7@amd.com>
Date: Tue, 11 Aug 2020 18:17:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200811160457.1073325-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::25) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.98.104) by
 AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Tue, 11 Aug 2020 16:14:07 +0000
X-Originating-IP: [217.86.98.104]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90a18109-6382-47b7-b84a-08d83e11936c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41381B95F23BD64B300554F58B450@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhXZcNS4HbPGJlnMosvue9tH1+jRPber5Pk0cahZfjO54sQvKlvVlb37dtz0o7MLNK7cVh1s4ks5ezWkCtnw1Muf0DeG3baO/8HkHC5dwvOHSp1YnqEBl7j/hkTibWdzAH/Pm4jvMnEcO3Z6VVatEJJsV90RzDF82Gfv4Eg/qINWpyZfhDSEiFKcKB4HSvf/dncfLcSasDHjhGEQMXEsxVDGjj+xOFhM/cv0hxh23H1cPLYDkSC7QIDa/XV4u//LMgC0hKy1NtNsO5SH9YTjHK7c1LbKIdbghsw0UwiKmJETenqIRihk3cDx5nFpUQz0ku/NFIUzoWDREGkW6DsySPPRsilrBs+zAuxvhsc+BYiGnx2F439uH9sJP62DTsMY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(66556008)(66946007)(66476007)(53546011)(8676002)(52116002)(16576012)(2906002)(31696002)(478600001)(83380400001)(36756003)(6666004)(26005)(31686004)(5660300002)(316002)(6486002)(186003)(956004)(2616005)(8936002)(4326008)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qhTeoCQnKov0SqjGTV8G3/IVBEtGOcagOMbaAQn1uQ/6PX8PU8s9AU1JNkZGUUfbKDIty+8oEVV5ZUVh6wMViXRYNfTIT6bSRGxGxS0q5JD6Ta902U1m6GE00q5wLe5LFawqJ3+NtkpsIjXPYk1WnT5vj0NsJ6J3aFboSWZBDtB6q6Z1KLlv6wzM6YVD+dGJ5yI1+3pQTwJr/Wk2p6Na+VrBUVqjYauWpsJjzbZnsII7yU/ADDT0tQWRuW/ooEhLZtzDYSaBYfO7CL0/Y4fyMEUlUQ6/vcOa0I6+/QGEiOBzVpcRpkr7S/1lZe8IOewkTvsPyvrCjeMwlGni79kKLZXNCnQihG9eZBk/konGqA/CTD5pUvkS9NwOf7JDPav8/1j6W+9QAEljZ2mW58zJD0XahQzVMoY6qv+vzw5h/YBBvZEIEv04Y6wfRpadWXRusj9velhaJEIkOaCp2SsB+9LRwWeuW/IS+wfZ7KlIh5akEVdPq8YkJITAVslhbnq23mq4ojQkvVLjb928nABvyEWHP1vLmDca9TL21pajY0g1rGRbtrSYEvfLySlK8uI/2DVky/yP2HM0o4oSOgqP7Rhhs7DoKRjwu0uxf9jTTnopU238WVupzXGam7P8+DlOKafOKt0mEE4Ai8fO8XP5+g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a18109-6382-47b7-b84a-08d83e11936c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:14:08.3955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4GKf1SqENYlbVzYugp424Yykjj/EUX8XPrKRBZ15DAU1Ii6mWiAA6QiGhm+juFgRqJ+2vr+fSLRxxgVG7yUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com> for both patches.

On 8/11/20 6:04 PM, Alex Deucher wrote:
> When we reset the GPU, note what type of reset will be
> used.  This makes debugging different reset scenarios
> more clear as the driver may use different reset
> methods depending on conditions on the system.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/cik.c   | 2 ++
>   drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/si.c    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/vi.c    | 2 ++
>   5 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index c2c67ab68a43..7e71ffbca93d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1366,8 +1366,10 @@ static int cik_asic_reset(struct amdgpu_device *adev)
>   	int r;
>   
>   	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> +		dev_info(adev->dev, "BACO reset\n");
>   		r = amdgpu_dpm_baco_reset(adev);
>   	} else {
> +		dev_info(adev->dev, "PCI CONFIG reset\n");
>   		r = cik_asic_pci_config_reset(adev);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index da8024c2826e..54e941e0db60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -379,7 +379,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>   	struct smu_context *smu = &adev->smu;
>   
>   	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> -		dev_info(adev->dev, "GPU BACO reset\n");
> +		dev_info(adev->dev, "BACO reset\n");
>   
>   		ret = smu_baco_enter(smu);
>   		if (ret)
> @@ -387,8 +387,10 @@ static int nv_asic_reset(struct amdgpu_device *adev)
>   		ret = smu_baco_exit(smu);
>   		if (ret)
>   			return ret;
> -	} else
> +	} else {
> +		dev_info(adev->dev, "MODE1 reset\n");
>   		ret = nv_asic_mode1_reset(adev);
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index e330884edd19..eaa2f071b139 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1302,6 +1302,8 @@ static int si_asic_reset(struct amdgpu_device *adev)
>   {
>   	int r;
>   
> +	dev_info(adev->dev, "PCI CONFIG reset\n");
> +
>   	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
>   
>   	r = si_gpu_pci_config_reset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 84d811b6e48b..3cd98c144bc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -580,10 +580,13 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
>   
>   	switch (soc15_asic_reset_method(adev)) {
>   		case AMD_RESET_METHOD_BACO:
> +			dev_info(adev->dev, "BACO reset\n");
>   			return soc15_asic_baco_reset(adev);
>   		case AMD_RESET_METHOD_MODE2:
> +			dev_info(adev->dev, "MODE2 reset\n");
>   			return amdgpu_dpm_mode2_reset(adev);
>   		default:
> +			dev_info(adev->dev, "MODE1 reset\n");
>   			return soc15_asic_mode1_reset(adev);
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index f6f2ed0830b1..f03314300ae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -752,8 +752,10 @@ static int vi_asic_reset(struct amdgpu_device *adev)
>   	int r;
>   
>   	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
> +		dev_info(adev->dev, "BACO reset\n");
>   		r = amdgpu_dpm_baco_reset(adev);
>   	} else {
> +		dev_info(adev->dev, "PCI CONFIG reset\n");
>   		r = vi_asic_pci_config_reset(adev);
>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
