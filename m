Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C013BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 06:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E0C10E580;
	Tue,  8 Mar 2022 06:32:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E3D10E580
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 06:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJM3S17RSZI2aKT1hfA2iFELE1W3zhf/MJDo7YTrfLLZjwhZyjLjiqMrwidsH5RbAO6P5SgwvQjS4vROeb9YlNuFVxy+0jPv/oIFVjQPWxJQyWTQwO2gR0TrGYW+a4HatlkQs4p4K0D8derGGY4i0xKovYL8eII5K0lyWA6nabneY4b6b5d35FAotA2SoZTDP+ObSOw4ZVqe0MaLOjkSIHhiaS0ca+U4ba6rQATliFbsoziMa1/JwTsv9zqsru5F95AxFSXtsSs5VDubq9PQ8CLYqpivQ/uztbDsZykdrzjO8crsSgKOw4H0VnPIthoEeMVgHOsaz/9rcGS7+9cbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwCZbJAMFGIJdsL9knruomgBQGos0NFMZ2Pnc34hfSs=;
 b=Y51ValGjV6PGwymxXS6L1/cLa6j6TUA5qUSPitPtwmM9AdJzvsucwHJQgtWvSF7jhqGdwqmylf03vOxQF9vDBY/Gthl1c5t1EMjiXELIigbbG4WAxBy1sih9AOOSmzYMMgm+MADfC2cVeE09Io66bbtI5I9KZrdFftmjKNJVk4f1/GNLQjazyecBMUuse3xy78Wz62+Yn0MjU0JoAWjbaBxa/7oDNjoERcUCQFYxNvzM0/RQAdwcE90vHcIutooJn7WvnYyp7PpB9wHDlAozzaCCW5+Qv+VxnAr5h1x3jcLQ5JND+2v7DCxnNB6llLaMFsPdxQUdDLO1NNqjpdzuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwCZbJAMFGIJdsL9knruomgBQGos0NFMZ2Pnc34hfSs=;
 b=cdvMKshcLh8unpFMVLeiRFtp3suiS5RdQIfj0x5jFf5WhQ1L/uhQLicDVI2WMfF9oNAr7Uk2pYTi6BHJgGiJT5j6xCxJZVm1T1x8bhKXTEDhIQgX2Kt6ulrL6c047YeZGbCTYxvezTSSpCBCeoqtDWn286tJRbGiQFiWIg8JS8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by SN6PR12MB5696.namprd12.prod.outlook.com (2603:10b6:805:e9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 06:32:45 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::2d51:2dae:ef16:6053%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 06:32:45 +0000
Content-Type: multipart/alternative;
 boundary="------------aFv0OrjS7wcKWTxG0B7guDCE"
Message-ID: <7e72c579-c87d-fe38-fc45-109a6f2ba9a7@amd.com>
Date: Tue, 8 Mar 2022 12:02:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
X-ClientProxiedBy: BM1PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::27) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d894d50b-6761-4852-9337-08da00cd7466
X-MS-TrafficTypeDiagnostic: SN6PR12MB5696:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB569684CD8FBE0D1CBC784AAEF8099@SN6PR12MB5696.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRmlMdoSPTraCN3DYxRAZ4HAS3JSOkAF84xHxy3uAIYsROnaOFDsPJbLqAHYXZrlonQRISvqDqMo0c9tzjjtGdsI9SpgVQ1y2bek9Jol0P5OMe3KFnf7tUoiD5X4/K+TcxuwXr8o74wPtqFHyhuzqLLUDrg31w5xV6OTpqhGE3pGPbcms0Esw2l+1W5wbCdTwQzIPIjNJYjKZ28Saqv+c9n+zlTbPiW+fIkeXcObL/e+DYnsRdWvnJK7+L/Z0WscyBbbwpyWNA5XXMav0UBSD0yNgxbgyLv73FugnIo6oeeHALnfQ7sc29ipSTFDmb70P/znDoN6rzOD82d5BVrNK8+bLdU7sCeArAXcWJQvbk1F06yz/mGueRVm00HT61mUy0tj72+Vm/Ay8TneJcIQSEvYUySaDu7hHJfI0f3YpnrbyffGhBX8MK/u9PQ03j6uvJgatPOdElBoeMVWpOWu4hyOVwmwFH4J+UNbCwDeuJ6ETCkihE/VkehyCSwfigJZP4eLERM9F/oZctJ0l1jGDA7bQgL1+YacEpoUAL2QW0QqV8cJv923omqutODbo+XD8eGPpG3B31EfB77SInBe5rtXJp7P18JYrqPiJ32/ejm0oS59N0TPbT8RnUUJ3aVwCShfJj7iOsOttpt7gJSpRQxY0aJz9fWz415q4wqCGzhe8M3k8qs5I3oeHBLDCRqTfWwD3WeTwLOThY9dCAey9hWp70Jz+HIsSUQ8SHFAQug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(186003)(26005)(31686004)(6506007)(38100700002)(6486002)(2906002)(36756003)(33964004)(53546011)(6666004)(54906003)(66476007)(5660300002)(66556008)(8676002)(4326008)(508600001)(8936002)(66946007)(31696002)(6512007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkIrb2FRR1Z3YkNHaEpTdzFnM2pUMUtVaFdHanI4QU95empBRmluN1NFdExE?=
 =?utf-8?B?dlYzTzVvRWlKR0JwTEZXSjNnOTAvUTFXYVdtQ0QzQnh2N1NlcXFUKytaL1dr?=
 =?utf-8?B?N0ZhOU9IYUVjV3YwL0ZLdEpLZkVvUUtrWEtoM0ZqV0IwQTZmZnNlT1Bkellv?=
 =?utf-8?B?UWlUZnAvY2oyYnVNVmM0bTduUzFobUx0dnJBUTF2Q29VdmR3aTFCQnVQZVlD?=
 =?utf-8?B?eUpndTNPNlk4YU84ZlJSb2d6WS9vdm11UW91aHd5a0psSFRSdk1MeWlxTnh1?=
 =?utf-8?B?OTBoWkFFYm43WGF5d0VpQjJBL1RzOGp6cjFoMSt5TlBxWHF6Q2dKWkE4K2Y0?=
 =?utf-8?B?MG9lU0FlRzc4dmZDUm15amtxc04vRCtySGdFYWdZaFdJUXcyVHNpa1hFaWFV?=
 =?utf-8?B?T2poZ2o1SVplcll3STJKaVBXZlFCNitYZFJ6Y1lUN0RySGcrSjF3bklCWWJK?=
 =?utf-8?B?eTdROVFWaGlRWWVsTzNBdDlVNzJIYTJPZTNlbWVQNHljYTB6SnhGSVpNeFNv?=
 =?utf-8?B?VVBwVUlxTXA2Yk1aQzhram1VR29QOVg2bVYwZGdDKzRnc3RlR0pyQ0lhRktm?=
 =?utf-8?B?akkvTUlOTlZjNXlHalErTmUxWEtPblJIK2xtTnBzQ2dkaUFsL1hoWkw4MnpR?=
 =?utf-8?B?ZFpoTkkwTlQrUGJrTE02MGk2aXpJRThpVk5BcDR1TFdTaVFjQjlFYXhCS09J?=
 =?utf-8?B?OHNCL2s0dnhMS2VXeFlzRS9OTzhyQ1dBY3R0ZzFHS1ZTYUxmckJzU29ubGh1?=
 =?utf-8?B?VU04OEFQMDhuSmFHTENONkdoZ3pFNlhCR01GczdxNnAxNWQ2OU1pcElCQWxD?=
 =?utf-8?B?VUFTK2JlOTRsNmRaQmlpbjN0WFM5OTM1eUUwOGs3SUxxZzlDYXl4L0pGeGcz?=
 =?utf-8?B?ZkltZkViTFErTGNkRGZ6ZWV2Njd6QzhicGJUMGwzbUZqT1ZibGJoRU80R2RI?=
 =?utf-8?B?NHY2cG9LSDVBSFlQN1V5WlI5dXZnazEvWGN6N2FvYVpFMm1DNUpDZE40N3E2?=
 =?utf-8?B?bFJ5NEYveittWU1lelZhOWVrSm01UVY4ZnFvTDhDZTltbjczbEFkNGJneldI?=
 =?utf-8?B?RTdZM3ZsMm1WUnpYdnlkdnZCU0NCZ2tlNXFkZy9xbTN5T2pOek9MTFJRQzlZ?=
 =?utf-8?B?RTViNFlHaGhJWWNGRGF1R3F6azVpYWFKbTVrVjErK0NpYUIydEpQTGpNc0NX?=
 =?utf-8?B?blZ1TnJSOWZIemFWbTJFOFhObHJlb2VHYVRaOXdITUQvR3JzK2VsczVKdHdP?=
 =?utf-8?B?MExKWFdPWUNNZzkwcUdIWndXQXJRMUpOenJDeXZmT0tickN5WFQ3UlR0ZHlw?=
 =?utf-8?B?a0NWUmxhRUlPaHM2SWp5TjRxSTU1d0RSNHIxZUh4N1lIOWV0OHRrbnBjdXhh?=
 =?utf-8?B?Wk9XQk55azU4MEZFR0sxVmV3cDhNVE5ma2p3ZkNWaWxSeG8ySStMN284OERr?=
 =?utf-8?B?Wksrc1YzWG5tU1pYRXhxb1hKODZ0d3ZLMnRTTGdXZ3JlVnlnWThNT3d1UmVJ?=
 =?utf-8?B?SmFLNDh3QTV0SGI1V3hMd3hGWkw5V2ljdjlNYjVUQkZZUXhhY3N6QU9rdlU2?=
 =?utf-8?B?a1Z1OVFaOGJqV1RnMjd0ZitQNmg2dFVjOEVpQStURFpPakNDTGoycVMxRVVk?=
 =?utf-8?B?QWFoRExPQzE4RjM1a2IrRSt1YnRYTlJGWWFsUTIrazNRakgyd21sSGJpUzlB?=
 =?utf-8?B?Nk02SmNvYnlGZ0RWQ3VDVUd1TlZzNG5odThzNWhKdE5iU3Q2ZzRjWXFCd1lR?=
 =?utf-8?B?cU10ZG9NenUzdDBtSFZ1TXJGa2lrNlB4anNJdllxUklSeWpFb0F4TWZjZFNB?=
 =?utf-8?B?WUxPVGtycVJKdDhGdDdDdUN5eE5GbjM5a0pBbWxaMlBVcDl4T1J0ekl5VDN3?=
 =?utf-8?B?R25tOWhMTDJ0UVhVK1UxSUpsd0VLOTBXNVh2MHJHZEhibkZRUkdiUkk3Tllx?=
 =?utf-8?B?QytRY3V0ckVTek1TZ2Vjc1pJYWh1YXNtVVRObmc5MXdFTlR6VVF2THJzeTBr?=
 =?utf-8?B?MStuSDBqVmhHeGpmWmp0c3ozZVZHbzhOQlpWd2hhS2IxYWw2UDJRTzhkOGFY?=
 =?utf-8?B?RG9PaUNWZi9FTlpZNFN0Y2x2NEY4S3JEL0k2T0JMd0pXOEttZHRjUzZBRW96?=
 =?utf-8?B?ZmI4SVdKM3JNNHdIUHhadGpXa0pPcld2eFJkSEFJOHZkRWRlbVg4Z1BlQjNM?=
 =?utf-8?Q?KMIPMTSi3UOWQ6toCZP0CJk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d894d50b-6761-4852-9337-08da00cd7466
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:32:45.0490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +q2lTMCIlBWeDjVyyaILVmJFbwdNTTB1+PMB5oKCwTfb2kmSdZJwRzbCN6jHcWIL3iAyHC2YrSpCabNOkVXGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB5696
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
Cc: Alexandar Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------aFv0OrjS7wcKWTxG0B7guDCE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/7/2022 9:56 PM, Shashank Sharma wrote:
> From: Shashank Sharma<shashank.sharma@amd.com>
>
> This patch adds a new sysfs event, which will indicate
> the userland about a GPU reset, and can also provide
> some information like:
> - which PID was involved in the GPU reset
> - what was the GPU status (using flags)
>
> This patch also introduces the first flag of the flags
> bitmap, which can be appended as and when required.
>
> Cc: Alexandar Deucher<alexander.deucher@amd.com>
> Cc: Christian Koenig<christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>   include/drm/drm_sysfs.h     |  3 +++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 430e00b16eec..52a015161431 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
>   }
>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>   
> +/**
> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
> + * @dev: DRM device
> + * @pid: The process ID involve with the reset
> + * @flags: Any other information about the GPU status
> + *
> + * Send a uevent for the DRM device specified by @dev. This indicates
> + * user that a GPU reset has occurred, so that the interested client
> + * can take any recovery or profiling measure, when required.
> + */
> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t flags)
we need process name
char  process_name[TASK_COMM_LEN];
> +{
> +	unsigned char pid_str[21], flags_str[15];
> +	unsigned char reset_str[] = "RESET=1";
> +	char *envp[] = { reset_str, pid_str, flags_str, NULL };
> +
> +	DRM_DEBUG("generating reset event\n");
> +
> +	snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
> +	snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> +}
> +EXPORT_SYMBOL(drm_sysfs_reset_event);
> +
>   /**
>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any connector
>    * change
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 6273cac44e47..63f00fe8054c 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -2,6 +2,8 @@
>   #ifndef _DRM_SYSFS_H_
>   #define _DRM_SYSFS_H_
>   
> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
> +
>   struct drm_device;
>   struct device;
>   struct drm_connector;
> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>   void drm_class_device_unregister(struct device *dev);
>   
>   void drm_sysfs_hotplug_event(struct drm_device *dev);
> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t reset_flags);
>   void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
>   void drm_sysfs_connector_status_event(struct drm_connector *connector,
>   				      struct drm_property *property);
--------------aFv0OrjS7wcKWTxG0B7guDCE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/7/2022 9:56 PM, Shashank Sharma
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220307162631.2496286-1-contactshashanksharma@gmail.com">
      <pre class="moz-quote-pre" wrap="">From: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>

This patch adds a new sysfs event, which will indicate
the userland about a GPU reset, and can also provide
some information like:
- which PID was involved in the GPU reset
- what was the GPU status (using flags)

This patch also introduces the first flag of the flags
bitmap, which can be appended as and when required.

Cc: Alexandar Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
 include/drm/drm_sysfs.h     |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 430e00b16eec..52a015161431 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_sysfs_hotplug_event);
 
+/**
+ * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
+ * @dev: DRM device
+ * @pid: The process ID involve with the reset
+ * @flags: Any other information about the GPU status
+ *
+ * Send a uevent for the DRM device specified by @dev. This indicates
+ * user that a GPU reset has occurred, so that the interested client
+ * can take any recovery or profiling measure, when required.
+ */
+void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t flags)</pre>
    </blockquote>
    we need process name <br>
    <div style="color: #000000;background-color: #ffffff;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #0000ff;">char</span><span style="color: #000000;"> &nbsp; process_name[</span><span style="color: #098658;">TASK_COMM_LEN</span><span style="color: #000000;">];</span></div></div>
    <blockquote type="cite" cite="mid:20220307162631.2496286-1-contactshashanksharma@gmail.com">
      <pre class="moz-quote-pre" wrap="">
+{
+	unsigned char pid_str[21], flags_str[15];
+	unsigned char reset_str[] = &quot;RESET=1&quot;;
+	char *envp[] = { reset_str, pid_str, flags_str, NULL };
+
+	DRM_DEBUG(&quot;generating reset event\n&quot;);
+
+	snprintf(pid_str, ARRAY_SIZE(pid_str), &quot;PID=%lu&quot;, pid);
+	snprintf(flags_str, ARRAY_SIZE(flags_str), &quot;FLAGS=%u&quot;, flags);
+	kobject_uevent_env(&amp;dev-&gt;primary-&gt;kdev-&gt;kobj, KOBJ_CHANGE, envp);
+}
+EXPORT_SYMBOL(drm_sysfs_reset_event);
+
 /**
  * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any connector
  * change
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index 6273cac44e47..63f00fe8054c 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -2,6 +2,8 @@
 #ifndef _DRM_SYSFS_H_
 #define _DRM_SYSFS_H_
 
+#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 &lt;&lt; 0)
+
 struct drm_device;
 struct device;
 struct drm_connector;
@@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
 void drm_class_device_unregister(struct device *dev);
 
 void drm_sysfs_hotplug_event(struct drm_device *dev);
+void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t reset_flags);
 void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
 void drm_sysfs_connector_status_event(struct drm_connector *connector,
 				      struct drm_property *property);
</pre>
    </blockquote>
  </body>
</html>

--------------aFv0OrjS7wcKWTxG0B7guDCE--
