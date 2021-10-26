Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FFCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 21:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FD860EB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 21:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69FD860EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0816E49C;
	Tue, 26 Oct 2021 21:30:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5790C6E49C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 21:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+g+HsOmZMZWyfxE332gCLD4g/AKkXA0Fq1kmy+2bFe0Nz8nASVN3KGn0l/3ToCpu3DtMRyH+qpNO4uOCPtrkVMXfIPjrGzn+uhsjx/Fv8e/kd9tRhGb54BUbf2JeHPhFinj/ym+JpEqrf+7M4C8Cim2Lmho/AaA1zKQ90OmUwGfHMFcoUn8pRFBg4OKo6IcvrZvGxb02gQR1JLDkiXz1e4+98ZRpNO7WV3Gpr27+kalYh3DhPdWkzJFlpzPhPFJu2hKND1OIih2X5mcki29aDSxxDXSh6kzA05gSinTpkYewE/Yj6yENYTyb5Ic5RAbq6yRZ5uVGp5N5al8cZ+2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9hsVoRMz0eDUdMsAuoWTlxV3qZwiagfMoiFEAT5u9g=;
 b=T1Zgt9/rmB9PcUhsPbBGJbCoL6RZ3Agw4ssX5Gd7uwJzTPepK/hmeFHuIN8mZSq5VW0NcSc1T/BcmJSzPfQ4uhphMHvMNCfHiaUm2o4jQn2wKpgPcTL117tE2+fFeQSnp2cEvT+gwUOP0S/pVqLqSz3DzVhXpOqVY6d1GG/20nsmZ3vDIher2hJ1b8n2gSI6gpz0wV3UfXo0a+sLV7xkPD8VJ/wBZ9NaXSqRdDeQPx53556aKEB061hU2C6oKFkKLbWkdH6a6oOjX0TzzyoRATU27Xb0FW4UC991XKB2A5uY2a8ondQefl2VDSLrk4ZxwjvI69r/T60D+clH4rgCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9hsVoRMz0eDUdMsAuoWTlxV3qZwiagfMoiFEAT5u9g=;
 b=pLQeTeY8b4sz36yYMul4RjxI2sXMZj+o0eIMCzS0vNt/3ATulTr/MJU2JKFHSlU/rgrrm5B2OU5capxptpJ59i7Pwb2ZV7j5WkFx/5S6vpSBY2dcWfov1E7OPvtO+vKwMpOc385BLiWRNECDMcMaFwI5gyHnqSA1uqp/mzqVTbQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 21:30:51 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 21:30:51 +0000
Subject: Re: [PATCH 01/13] drm/amdkfd: add amdgpu_device entry to kfd_dev
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
Cc: mukul.joshi@amd.com
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <33533a0e-8d00-cc7d-abc5-a941bc228943@amd.com>
Date: Tue, 26 Oct 2021 17:30:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019211334.1552825-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::30) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YQBPR0101CA0157.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20 via Frontend
 Transport; Tue, 26 Oct 2021 21:30:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a70487-5046-46bb-b10a-08d998c7e226
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1338E54A1CC5E760FD322FC792849@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XV6fTOcOM2I3kcDFeI+7n/7RsnqfM9zrJ+tngoCO7Zpu6ZUQKeMzyNsokE/uhdF3yoxeX82xOY5/mvYboFOXHJH8Jm09eIdU0sRRtnj9Ma6QKlZgtunDdMtObSl9QihKFt0H5rdseMTAOaoOsLjVhTOb10qxVqzFsOi8z6xni/SAJ0EJjK2DxTKJJe0fMgEhOI3zpCYE0Ih00LGyjFdqqVwcBv7eE/Cl+z8prYiaHCDUEBx3EIL48HhSk0Skeuckt3ol1J8+KgfgY9+znRb6/Vc6eMnSm1RmX9+HrMfe9vgyO08eaJ3ClBA14Yqy2bEYfvx6nlHXh0mPf/rzty2Lj03I9OwEU23p8+zgmGk5oEnYc7BMeq1yg+m/TksLw3W37FviZicEwEcDIwxmucEKsVr6N8fzr8qfi7Nqe2122ooZGdGKPAKbyD5AtcRUMjF/TFmVS0FoWtNpxU7MnD8CsQ8B32D+DD2iqKuQDerd97+x7dcHWpdCKpDDZq63/uQvOFkkc6W20/lA+wmuWZQQvpwtNzFW/6BSMk1lqt2DyOKjM31qbQX78Fym5fKdNJJ+6mgM1BITZq8YwiYfrACFYwtHiPeAzlzbM+dQjQu/MOXRX0KAKjt7yBHvO5R2Cf1czrkD/R4b+PZE2O5tBN+gT8UmkG5v4uOhAk8wpEDiX4N2ATOYMwFOnk49WE5QHxX6Y+IbMwRkxtkAXGjsHOvQIG4HENjl3alTtV5rrdbU/3cXsRe7QfGkJ7RmqCusZWp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(26005)(16576012)(31686004)(956004)(4326008)(8936002)(2906002)(2616005)(508600001)(38100700002)(8676002)(36756003)(66476007)(4001150100001)(6486002)(31696002)(66556008)(5660300002)(44832011)(86362001)(316002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0RLN2RLS0ViaVdxS3RmWTVyZWl4dktHY3lMR1F0a3B4TlFyeGZDM2tyRmNV?=
 =?utf-8?B?dmduUUI2WEVHYVJ2VUV3T0tTMGNDNGx3a1QyLzBtc09SVUdPbFJXbUlZUDg0?=
 =?utf-8?B?ZkVSTmpmVlh4ZnRIOTRFOXA4MUIrSlFLaCtIdjFsbCtsV0FXMklyNjRscE9R?=
 =?utf-8?B?NDJPanFlSzBoeEJnL0E3SWNUdVFFQjJBQ0QrYStBSExUUkJKUWpKaGZpY3ZO?=
 =?utf-8?B?bFJNWTF1TjlsanhjeXY0U056V3lIREg3eGN3aWFvM3V2SjZOZitZOEJOLzY3?=
 =?utf-8?B?SGM3Z1dmZzFmNkdoZmhNazZSUlAxSHYrWkR1VUxQTW9UaDR5OWhKREpibFVP?=
 =?utf-8?B?ZlpKa1hQS0IzU2hXMGdSOEkxTjRETnlzem1vak5CYi9VbzVuVW5uMTRJbXNw?=
 =?utf-8?B?aTZyTDhydVB3L1VJbjcxWnZEU1ZiZk00eFlQK1MxaFBMLzJsMUd5UVZQZ0tz?=
 =?utf-8?B?dmlnSDBJM0tHYmxKNzBQSWZtckUxS21JT0dTa2MxRlFDdHgxajVFajIxb0N0?=
 =?utf-8?B?RU5FWVNKaFpXU1NQcGVza1Y0NzZzVXRhR0hVOXMxR3I1ZUY2RWVLNnRzWENy?=
 =?utf-8?B?VnU4U216M1Z0VER4QXdqMCtlay80VWIwSE1MZ29BMkJIWVVoc0pMZWpiRnRX?=
 =?utf-8?B?b1lPcDlZNWRPaWdETzRibHFna1NOcDFFbUZUS3NldzAyZXlldjdnQzFzTVdr?=
 =?utf-8?B?QURSSVM5QlBYVU9qMFdSTUJpL09adWwxNjM0L01WaEZKRFZndlhacmF3d3p5?=
 =?utf-8?B?L3NhMlJZY1A2aW5DWVFWQWZlQmhacWVJTWxCSFlEbXVGaFdYd2E2Z0Z2QkdV?=
 =?utf-8?B?emRqZHlLV2ZLVThIVE5BUlYrKzF0cEhTSFd1WU1ZV09JaXJvZEJxbU54aW9T?=
 =?utf-8?B?NWhlNkt4cEQ0aWszQ0tsN1QxMUUySG5zeVFQdFJXWk5XKzVsUkxvWVlxbzlm?=
 =?utf-8?B?b0MvOW1zRWRZNkZRdVlxcGdRbzVJbndkMkZSczlseStoazZrSG9yZjlrVC9h?=
 =?utf-8?B?TWFYVjBFazc0dTkrSzlvYmNlM3NBQWhyc0N0MG02eFJ6YTZjTDRSdmh0Vlhy?=
 =?utf-8?B?Y0R3RUI0Qlk3d3VleWZ4ZjhsbGZRMlBBZXE3T3RzTzFLaTc5OHJnZDg1dk9h?=
 =?utf-8?B?aFlRZm0rM0hnVVVOcVJqYnVNWjJoZzU3OXN5dVVicGUzSHFzWVM0TnQzTmMw?=
 =?utf-8?B?THlGYy8wUDJIM1JuYXZCZURILzZlY2hIb1pBQUdWR01YN2JxLzQ4WkNVUlFY?=
 =?utf-8?B?Zkt5M1VQb0RVRm1NNXlCR3BzZ0IyNWVxRk45MGNaa3NIcTFFVCtDTFBObCtz?=
 =?utf-8?B?WjFxeVlhMlNGSUg0bTA0SmJtZXE2dWgza25MSEduOWx1b0NMWGMwQlJSTlpm?=
 =?utf-8?B?cVgvQnFMdUdWQ1MrSXZSdm82Yjl2b0JYcTFSaUhjdkZNeWJTOUZNODluQWZ6?=
 =?utf-8?B?NDFVZnVFRHJOTFJGY0RxY3BkeEttbUZDZEpxb2RyT3NubHpmTkJ0S1pwMFJX?=
 =?utf-8?B?OEk3UXVEenhaK1ZnSHVzZS9QRFFKenFBaGVwQW11cy9GR0pzZE5GZ3hBQ01N?=
 =?utf-8?B?eHI3azZvMFo1SlRZYWNNUUtGTzRVTWJkZ05yQ1VDWURQOVk1cTFGK2FtVEti?=
 =?utf-8?B?SFhKZVNPMkFXYmhYQ05Fa0F0M0RVQjVCR0hpOWdiazVuOGlocDBMWnVaTDBB?=
 =?utf-8?B?bzJ5ZlRsZDZPN2QrczNUVmdhV0oyZVdGaUdhS2tNSUVKWS8rdlloZzRXanJQ?=
 =?utf-8?B?dkJjZ3k2Z0UwM0JJeWFNK3U4cHFtdXROOEthMEVFbkxscmZROUpSNGVydzFM?=
 =?utf-8?B?ZTIyTnZQQ2puUVhtUzdOaEE4eUdRaEhQQVphRzdWelBGTTU1L1NjcG1ySDF1?=
 =?utf-8?B?M2ZWb0VsMVZyYkRWb0pOc1YvWlUzaTcyaTRETmFnR2JhcG93QTV2aHBFZld4?=
 =?utf-8?B?elhxQkdMbDFlOVNwUW1sWG9RK3Y4WkxWWDgyZGsvTzRndmhWR0ZBd1FkZFdC?=
 =?utf-8?B?akwyaHFBd1dpRTRPOHFEUVZCeE5WQVl4N1ZBMkFZWTJLN2ZocjBnSmVlQ0lj?=
 =?utf-8?B?OFE0bEM5Z2dQajAvdjltSGxhV3lXWG9YNkRsSUZWYVlVczJrdEwvSVNQUlFk?=
 =?utf-8?B?cjErTkZlMzZCYlFmSW1qdisvUkhlRmxTeEJJK1BaK1RCSWhIK3MvNHZqZy9D?=
 =?utf-8?Q?1K28qEZwsarY4X98an92HzY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a70487-5046-46bb-b10a-08d998c7e226
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 21:30:51.1415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZW10eLshCgqUwae/WS7fhK8ukF+LKFuxrCl0BuxDXXsExJNIGnwyRgzNLvfiBjKv7/hk1OZY6CQeoRCZ3RUq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
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

Am 2021-10-19 um 5:13 p.m. schrieb Graham Sider:
> Patch series to remove kgd_dev struct and replace all instances with
> amdgpu_device objects.
>
> amdgpu_device needs to be declared in kgd_kfd_interface.h to be visible
> to kfd2kgd_calls.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Nice cleanup. I responded with a suggestion for a possible follow-up to
patch 10. The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c         | 1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h           | 1 +
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0fffaf859c59..81ca00d7b3da 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -825,6 +825,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
>  		return NULL;
>  
>  	kfd->kgd = kgd;
> +	kfd->adev = adev;
>  	kfd->device_info = device_info;
>  	kfd->pdev = pdev;
>  	kfd->init_complete = false;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6d8f9bb2d905..c8bd062fb954 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -229,6 +229,7 @@ struct kfd_vmid_info {
>  
>  struct kfd_dev {
>  	struct kgd_dev *kgd;
> +	struct amdgpu_device *adev;
>  
>  	const struct kfd_device_info *device_info;
>  	struct pci_dev *pdev;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index c84bd7b2cf59..ba444cbf9206 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -33,6 +33,7 @@
>  #include <linux/dma-fence.h>
>  
>  struct pci_dev;
> +struct amdgpu_device;
>  
>  #define KGD_MAX_QUEUES 128
>  
