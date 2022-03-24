Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA53C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 03:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89F410E38E;
	Thu, 24 Mar 2022 03:47:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CA510E387
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 03:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUAOyyFfDEtl3V/KuIz1TYJeatbsnwjkAmRqBEyMCn+qyf+zPxXXVWxqJFwg8P7HUfVIeL5aUxwKaBA91KDUwC+BZPInXPi9T5j5tKjMrG5dIDqwxUfWarFNRXCgbASbRTvpVIyPRqyaPpjRG0a8nfS0oiCUrE66khYuoIRTGga3jYkgC6hA0k35frKa4BkGLjqVQ7EsyqlWp62KjID8HG1Y1OdOsdl8sxjlHmEclbKccKcc9M1/de5SOBzt8MJTK+mIy4mjG2Rdik+Qib1V9nykkd8FxINVNQJOSrmw3jcRUJkkKaZogvzdX62OAT+bQsenlVMBdSpcwR4dJdPOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QqXd/U10kEfxim3SU1pm+ozFnJRSFfC8XJRQWBk+e0=;
 b=MD1gnIS96vj5ZIvq4g3u4zoKQ0fHacTwAmea71UPcGXAPJuPuaSMuBp3F6G0Fc13vc58z4+cKme3+bi5Tu4H4DIL7ujURmnvFUaRFq8wsj430b4MesBGqv39Xq0dFezmlf8oKXVrqZx/qFAcsRDMTMNjTBuPo8zc6LfxEfj9K+5JJW4R2uHvTuoDSCAvqTodFTCyn28xGG2+wFfTgASRAMidhTlPLtbRdYLWIrX3Kzk3wPhwtyeXpKAl67Uvxbli5Srz+GsfHoR0/c1vbiOk2R60ncbFIRCdQuCpmSBTyGqQ2UHfoJ+OygBKIRoBOoROi4asXpV0/slQoTxyuOdcIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QqXd/U10kEfxim3SU1pm+ozFnJRSFfC8XJRQWBk+e0=;
 b=mebN0X5yA95XmXb4cFIACWLPtVWrq621FWTfwPRJYwna70AIELGKa7sKd8XgLaHMlrqdkfKYRMdnCXzGE35aW89Iro6lxsD5CBP4UVAYZ8mtmnrxS0gV6kgYvrDfFmtMXC7IUXKW1PRVk7aFbnzhH2Zp/ZGz9YpuCgvGIneSJKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Thu, 24 Mar 2022 03:47:46 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 03:47:46 +0000
Date: Thu, 24 Mar 2022 11:47:24 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu/vcn3: send smu interface type
Message-ID: <YjvpzN8tv9kuyZJ/@amd.com>
References: <20220324025914.718674-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324025914.718674-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 482e4003-a1e3-4a5c-f7f4-08da0d490ec0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5748:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5748F9C1CC85D6B8D9EB3B6EEC199@DM4PR12MB5748.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCDjTewopqB54gzx4yzDjpD5mJjUTCSB9pR6hqmVD77v/TdeTpV1xdaJg4Xbwij4N882HF3MwTbcMxrbhtIgldpTVI2zsw5BT4ecLi1qH4zIv+R69IcdqwH11ZYMYbFgqZzdJdyik+O6xlRi1WtAVadJoZNj7vNoyI4crtGYnqifb2s4s1kdI7oaUDTzQf4nVYr//lnREXlS5mH2m1mAGqk/JfD6J4fH5VaLxY3hI8IQKFJUFEEnLS69uTe1q7DYVOAubhBlfRrYIP9jiqQKJ8lR+3cXSlu0ZVyp7XIm5VG6lTeaPz6MsMSgRgXYr/GvEnhejpQXpjGPRZibcRaNCsjhT4cTaUKc+s462q4Ug4wPA78fry5pwtRd5+ivWN7LTZlhJtk/HgPZYeLPfMI/GM7urUhEnnVJasZuJKLvYFzJMZwUtSYox9cI7yhGbL53aZsvv+ldRdYx+P6cT1F33FuJuy4H1wbhi02I7UZ+OwnD6Un58X3Oig7yo7eY46tqrkbgIJoocrxdfYgbeUKHgmjPNCyD3qAOibP0w0/R3F+155Q6IC93UhAdAo7DAyj0TaJAlGkMVMaU2IV2W9zv0jbrcKQAxiGcC6jpGuqLVSJHmiCJxm4EZeJiR7Tw1yHlATZ1qtWb3ME63b5/9LUoTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6862004)(4326008)(6512007)(8936002)(6506007)(5660300002)(38100700002)(2906002)(6486002)(66946007)(66556008)(66476007)(8676002)(6666004)(2616005)(508600001)(36756003)(54906003)(86362001)(37006003)(316002)(26005)(6636002)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jRFXS43SiyiGVNsLjfu+ipdbNai6b+au1RWgfALhK4vVxTO+Sx6d1VqbbTE?=
 =?us-ascii?Q?UcVcf5Gw1BBxnhfklgsSQKH07+NAPujY0LxneGShv6TvFkAKK5cJMqMift6z?=
 =?us-ascii?Q?a3ImI901zG1emfmmiA0hheCTAEC6NK5jOHn89UriFuDiwTosAWZtaLpW716Y?=
 =?us-ascii?Q?ssVYjbpI/evaSvJ3G8UXGjWi7JFMW2BqedeSsh4I9kro6DSipn2iYWLcc/cj?=
 =?us-ascii?Q?cmGHM/+Hov2AHKQysLNduYjF4IdMbSy5R6PwYCLSQnYmuA2XDrbT6g8Hf+C5?=
 =?us-ascii?Q?YUpZj8fTYNS/J4lv8evf0/D07jt2ab/Qew+18Zr6xwVbvsqpTUR1erL18HRn?=
 =?us-ascii?Q?VuZIRFFQS5FYRI1k7HORREVxkgBIqEbfW73w/ARq26aAkjkVfpwJe7STz/g3?=
 =?us-ascii?Q?VB4DdZD98d/AampwzI3EEaWasftrDapCNt6mcfHnmvxap7J8fGwzMLL5PrX5?=
 =?us-ascii?Q?XUUqcUs4C7ZEk/OxnPIPpfB+WmMkH6zUTUsh4FPLJAmodw6aS5u5Y4DEQ9E7?=
 =?us-ascii?Q?h07lqOlWxuA3Vp2TLVHmtS2RdPVXkcJenJ+Wh+BKranLs5pMHPm2QbaVQoCl?=
 =?us-ascii?Q?MkQ1bIG8QWaDKEjdOiny+ctmP4j/ckhxaIj9Efozhl5D0lF82pIxD8TvA/iu?=
 =?us-ascii?Q?IFCC4acCACDjfgNtW9BhL102Ob2SaBFKnNyd5wXYCqKWnayY6KEz26fgGfZR?=
 =?us-ascii?Q?pUfXfvSxOBlROV1efF26Gv8oeVMEkDB7e1QXZJIdt6NsRpXRQG9DVQ7KhYnu?=
 =?us-ascii?Q?2o2KrT4EharYITRWPfaLswkm5ppWswpLXshywdJdjxYJ4uxH5na6fXsE6zNL?=
 =?us-ascii?Q?xulwP1vM0Wn9QY3Z0n5Hg27/cJ+DAL17jPkXdc+Mm12oGsMctpcnk+Bm3D26?=
 =?us-ascii?Q?ziVfWZYLnQ9Va5gjGpP2jJg1F7cew/oXWJyj5kFLm/pPDbpACvzav27lHn4X?=
 =?us-ascii?Q?W2y6Re1FW7FpptmJidJoC8euxdN6Rlbfc5/FhE797pnvu56oMRViOGq/huvH?=
 =?us-ascii?Q?Qj8FDHhHyczRsKIGfsHHP91Xmv/PQC6eLAvNcvzXgVm04ZX6mTyEV1LtZhRX?=
 =?us-ascii?Q?Wn6VMzvCP0gHhKc8qiUqqq7yP1jr9+9klwJuXsOySWMXef+S2lQhshXC68rc?=
 =?us-ascii?Q?0yAxrPAvWoBj3JKFvRhzkTB7rjYG8qQU2KOBy4ZP6mw3NgnOE7zRLRV3PmWA?=
 =?us-ascii?Q?FteS3+riWLhs7si1N5LKVX9tcIRxsKVTu4wIQc0hprFjrPaBhoLiBr6FYEoy?=
 =?us-ascii?Q?TqJfEdsGHqhV7HD690TAOdpFI0qMRLRPZ1tlYnd3KG1qmPZAtrfHiWleYCr7?=
 =?us-ascii?Q?Kr56WE3UvWDd63gKRF3hVX9JiwHqMfkZCWoXp2j0tMfVTo+Ugfvg7FeIYOVz?=
 =?us-ascii?Q?xG1TgrjkcQlilwkzzw4j+teUvbUapdpjs+i8jhphl+ctMEkACRLSsFfXU2Fy?=
 =?us-ascii?Q?51Ze2oLUKQBm9lTPmLvNvCKuVGd5fMJv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482e4003-a1e3-4a5c-f7f4-08da0d490ec0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 03:47:45.9522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5IRJqFLimxJnGeaOa3oWJgamTFKGqFBPwRGQd1Lhxhl8zKEHJ9JnEfpP6HrD0rPb968FFwiCkN5gVb45Z7V3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Boyuan" <Boyuan.Zhang@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Leo,

On Thu, Mar 24, 2022 at 10:59:14AM +0800, Zhang, Yifan wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
> 
> For VCN FW to detect ASIC type
> 
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 7 +++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e2fde88aaf5e..f06fb7f882e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -159,6 +159,7 @@
>  #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
>  #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
>  #define AMDGPU_VCN_FW_LOGGING_FLAG	(1 << 10)
> +#define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
>  
>  #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
>  #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
> @@ -279,6 +280,11 @@ struct amdgpu_fw_shared_fw_logging {
>  	uint32_t size;
>  };
>  
> +struct amdgpu_fw_shared_smu_interface_info {
> +	uint8_t smu_interface_type;
> +	uint8_t padding[3];
> +};
> +
>  struct amdgpu_fw_shared {
>  	uint32_t present_flag_0;
>  	uint8_t pad[44];
> @@ -287,6 +293,7 @@ struct amdgpu_fw_shared {
>  	struct amdgpu_fw_shared_multi_queue multi_queue;
>  	struct amdgpu_fw_shared_sw_ring sw_ring;
>  	struct amdgpu_fw_shared_fw_logging fw_log;
> +	struct amdgpu_fw_shared_smu_interface_info smu_interface_info;
>  };
>  
>  struct amdgpu_vcn_fwlog {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index b16c56aa2d22..c5bf7cbfa82c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -219,6 +219,13 @@ static int vcn_v3_0_sw_init(void *handle)
>  					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
>  					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
>  		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
> +		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 2)) {
> +			fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> +			fw_shared->smu_interface_info.smu_interface_type = 2;
> +		} else if(adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 1)) {
> +			fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> +			fw_shared->smu_interface_info.smu_interface_type = 1;
> +		}

fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;

This line can be moved out of "if else".

With that fixed, patch is Acked-by: Huang Rui <ray.huang@amd.com>

>  
>  		if (amdgpu_vcnfw_log)
>  			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> -- 
> 2.35.1
> 
