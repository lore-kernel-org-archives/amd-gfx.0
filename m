Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0B4C636CC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 07:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B900110E2BB;
	Thu, 16 Feb 2023 07:17:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DF210E2BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 07:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB2T7H6PUZvaME0veRbu4/qJhStCTFWfJ5HG8Gpsc3+vYzWEV1xkt/vbeG/YMVcy2WU+QW+dEz+vaMB2O++7RoLWIluX0G+y7zWJFBwUzfKvnGwLKWx71syACpoqLmGaZePP8uPZLSz80ROWewSc3HE7CTmQZhiCt333PeY4hnu42ly9/i1Mad5kjVfAXMzfeN5utCgeeocvfeVMm/uHuQkQ0oefWE4GCk2tr7A1koXnACBC6i0D4S/GFcv40sQ7Z4qQDrHi0WGyKzkG4d+tR6FTzjm+gbLwNgy7wKB+FqaRsk915U1uzJV/a38Ntez+atgxsvMacusL3kJs8sW0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSTPvNsBkhXmCvzI7zpqQj4hWTJqu3+23+GngulscO0=;
 b=IrZpyr/7nKBx6Dj5TW7bMzxIQqJYlercZhv4uMzKBg/xrkMX/sOxhPXNPrmgs9+HhBsM8Nl18gRoP4ZjOJJ+Bmkx/FULl1kKoSVAyoXsGqag8pAMr+Y5a+jItJinAGsOdjDVzfbcCE30ZHSPtYNX8Zs02ypkzvWxQ6MPxHtxJlM0/1+lQoWgD6hptEbU4zjk5GF0LG59DHCyRy4ujaCjtLd4SCuu4M3Db6zVGabXE43s0fhjdoR83o7COPnqZCmlbHaqGb+xwDo+EQRNokLNmX+Ec4J8PWajc1YPP8jHUXeMk0lGIJlYhnRPcUY9rWY37aHLs20j6LymRpDxPiAkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSTPvNsBkhXmCvzI7zpqQj4hWTJqu3+23+GngulscO0=;
 b=uyGoSgBqlFwrHOugf8Eow28SPJZ3CdCaPQy9lOu25mJ8O5Q6z+oWajsPe7AUpk/rkRzTZjBhYy+dPR+60ea90T8UCqnDbDg72AHFb08R6ldy9eczz1Odj6+epeY25+iOZ9qtrAMpL6usXxHfZoNp+MA1nrgQK747AexN7F2VHCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 07:17:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 07:17:21 +0000
Message-ID: <a77b26b4-247d-cf79-c40a-cd9b67114ba9@amd.com>
Date: Thu, 16 Feb 2023 08:17:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/9] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230215184356.2205-1-shashank.sharma@amd.com>
 <20230215184356.2205-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230215184356.2205-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c687ce-0b0f-48e1-49b2-08db0fedd809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66XoHtiMsD9iFMHa72CgKADcgJbH6XtLXmWQdK0eGhw5nvl9UWaVs7r2AOzdYEyohxabRna7iEvsdOxmzHZO/iUCWV1/EHhmajXXvY+Nv0XoGvxyjunXDacVvCkBJpyNQQY+CAlSvD/JfPrzDtVIbIaUja0izB7OOflegSIouPviVphXcJ/hJlcaDUespsm4ZiXh2ZVQG5FIf9NGb40qR4ml/BIT4PY0SikjHYxdDpdFSI9nJ2RzIADR1eVn6CDAuEKMcwIAVQ6p0lmxauuXOruYBH/LapkCKgCg9AKn//VteqEoh5hHV4/eIWrIPvPUhWxkmYnLBjbAEzrs+8kvpnwvQO416DE9nFg0eNYHAZPACvMUHpY3MN3KRz8WdFX5cTxu3+tv8Y0YKOaskJVtEeKjCT3ht2Pl1zt11Pbo3MEqvB4mAUpp7BVQ4h7jIkR9epGoJlhQhaXClNO/aBN4nm2z4c6bWXjff2M1B7NGle05qqUp4DLo0cWu0QM+XmBeJNX6t+d05DYwC6fuZbSztPvlhPq6ne2QQkJmcfPtAeYyr93XZa8Y3y7FhKeTBk1VE1NjCrTCqhySy2/YbA2bbZ0DG1AiUQGWS5i4EGIZGZQO+FwfrEJytkq110NORxAaHWZmg4vlnIRBay3KrYhZKdD7HlevUCq04JITt71Broohrr2O28w56s5AP/QxlNXW8Gd+8T4+8aL/lghMOtOu0MAAhUgEQWgrkec8U5lUhYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199018)(478600001)(6486002)(66574015)(83380400001)(86362001)(31696002)(38100700002)(6506007)(6666004)(26005)(6512007)(186003)(36756003)(2616005)(8676002)(66556008)(66476007)(316002)(8936002)(66946007)(4326008)(31686004)(5660300002)(41300700001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE5KM3o1TitQU0xLc2o4QUNhTCt1VC83OVVHL1Zma1NndHg2K0NvL3BPb2lJ?=
 =?utf-8?B?ZTFYK0pDVlJTeWpZbXhzM01KZk5UV2dON1k4ZXNycXRteFZXM2M3QnYxVUQ0?=
 =?utf-8?B?QnlhRDV0V2lIdHpyR1NDTU1pN1lHczFlMVpESEFPaXNWZTFjQlRtYUh5WHpv?=
 =?utf-8?B?WXIwOVpiUHVqQk9xRWtZckQ0alFLdWxrZWcyN1NCR08zWndlcENWYVVQWG4z?=
 =?utf-8?B?bTdQMWtpMktWZ3NBVXlpcEhIeVRaNHVHUHJ0MHhWZGtrRFQySXZRUDdkL1h5?=
 =?utf-8?B?amtJSklYWHlkNHIzNFNad2xzaWFwTCtkTWphLzcydC9vdkVycEVUWkJCMlVC?=
 =?utf-8?B?QnFMUkpmcXFYakpnY3BNYW5GU3QvaVBXYmVSUXlkU0ZWL01YRitrV0NzVlhy?=
 =?utf-8?B?Umc4SGw5MzFyekxHb2RNWnRnWHM2dXg0SjNXVEpaKzN3cEd3MXFBdUZXenlY?=
 =?utf-8?B?SG9GUXp1WTkzZmU2akNMazAzSkw4djVKOXRFUUhEY3BDbmRqYWJGdjBocFg3?=
 =?utf-8?B?OTRxdEVSdENUdGpKWENJUlBlV29BdW9Gd2dRanNzTEhZUHo2RDJaS29aYnJa?=
 =?utf-8?B?MUgvdFNpTDNBRTJvcVVPdXRiT050UEl0eVVpYXJhMEtvelpiWkZwbWd4aGEy?=
 =?utf-8?B?NzNuK21LRVhjZ1F0eTg3bXVGTHF6K08wMi91eStuQS9KTWJpSWc4QjRGaFFR?=
 =?utf-8?B?dlRYM2tlNWlLK3ZNSmV2SXZIMU85c2hYNUExeFlDQTZhNGdOcUZRaDEvdEdB?=
 =?utf-8?B?VXFZa1JSZzBIOVNBcitLRnhQcWpYYXE2cjhkS2dZdGRjMng3ZDhueCtUOTcw?=
 =?utf-8?B?ZzhiaWM2ZXFLeFZvalgyd3VqVzBIOVZ3aXdsMEorYzZudTFTd2JaOUFOeFhD?=
 =?utf-8?B?anNoTlg1WmZMR0d3WEx0d3BXemxYODlpQWErQmxZRjNVcjBnRmVMSTFYZTdV?=
 =?utf-8?B?OEFoWWRUV3IwZ1o5NTQzQ0lOaWJ3Z016S0t4bGd1cUtocG5VQ0RrZ1FqU243?=
 =?utf-8?B?TmVLSG41VzBnUkJVc3c0dWxONmVQTUp1WENzeSs4ZUoyYk9Xd3Y0MERIR0hD?=
 =?utf-8?B?UlEvTmlHb1hrNVpUTWgzL0FmRmliR2Y3WlF6S3FqaXUwYi9HOTJmekd5YVdj?=
 =?utf-8?B?UENCbUVPMTVDbFp0cllxSlM1cnEwN0toL21zSUd3Tmg0NVZLcnBHeG1ka2hN?=
 =?utf-8?B?VHlkemhlRU5LcUFma1Y3RWx2SVQrTXlPUkdQQnA5U3ZPcHJtOGdwc3VDODMx?=
 =?utf-8?B?N2pPL25TdTFJQXQ1T0YrVWpyUHJxajN6ekxpUFUzeW9vMVZweWp1MXBTTzYw?=
 =?utf-8?B?SE5qVFFLNnBVSnhibmxNMWlQNHQrSlVqWHZUUi91SHY5c3V6ekk2UzhEUy9L?=
 =?utf-8?B?SmFPRmxvV0tSLzdhZlZpbnQzWjNVbjE3M0hudGkzbldoNlo2TDlYaTBXVEZE?=
 =?utf-8?B?bzhnUEhjek5aSXV3Mk9YUFNNdEVxYUFpcURYMkNSZ1dEb3JXZ1k2WkRPSk1M?=
 =?utf-8?B?MzlDckJYZ3N0T1lNT0M2RGVML25Bb0ZJVUh2enBuSUxQY1BjeWlRdS9KeEkx?=
 =?utf-8?B?OTRRb1RsemR2M3hvdFNPTDBLYTdhTlZwdDJhRkt5VjdmNDJTMVM5QnQwdTN1?=
 =?utf-8?B?cjNRbWMxd3QwYnJFenRNVjdxRkVWYzBKV1hBYUdsVllWZlF5WkY0UE9WYnFX?=
 =?utf-8?B?OVFEUk5weThuK0t0WlM5QzYzMURJNDJFQjJSYmRjeWkrSnI0YVpyUjhoS2VP?=
 =?utf-8?B?UnBlL0NkSU5ORys0SURzV1dvcWRRZ0VBU3JMd1FEbmhxSFRiL0xSRGFnYzNp?=
 =?utf-8?B?WHVORnpCUDBjaUVDTVlOQitMRzNsbmdHUXMvdEtHbFhocXMwWVJYbDBuVU50?=
 =?utf-8?B?SDg1cGlXeG5MaW5ZK0xNZEQ1VmlKei9aY0JLcHo1MnBYb3VOcTZncWYrai83?=
 =?utf-8?B?V3B2Sm9OeWYyb1Y3cU1XbXMrNjNBbEt5RE1hL0VGOHR2a3hiT29pY09ac3pp?=
 =?utf-8?B?eEdGbGszY2c2dnhaQnA3L0VDRTRzWUpSbEtLc2d4Zi9ObEUrOVdqR0VIeit3?=
 =?utf-8?B?SkwrNDRHSE5CUWYrOVQrQlEzWUJUeXg5TVJLUGNCdTRIeHltcUNEWko0UnRQ?=
 =?utf-8?Q?BfqnljQBTd96/UQfTsstD+ibI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c687ce-0b0f-48e1-49b2-08db0fedd809
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:17:21.1866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlZVonqdc4m5JtUSiFl7MPZlxdJAMiHGtzRwfVDKp9JVE8Ig2Kmnc9eFgmmkxXIg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.02.23 um 19:43 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch intorduces new UAPI/IOCTL for usermode graphics
> queue. The userspace app will fill this structure and request
> the graphics driver to add a graphics work queue for it. The
> output of this UAPI is a queue id.
>
> This UAPI maps the queue into GPU, so the graphics app can start
> submitting work to the queue as soon as the call returns.
>
> V2: Addressed review comments from Alex and Christian
>      - Make the doorbell offset's comment clearer
>      - Change the output parameter name to queue_id
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 4038abe8505a..2bc4869ee279 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>   #define DRM_AMDGPU_VM			0x13
>   #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
>   #define DRM_AMDGPU_SCHED		0x15
> +#define DRM_AMDGPU_USERQ		0x16
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>   #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>   
>   /**
>    * DOC: memory domains
> @@ -302,6 +304,59 @@ union drm_amdgpu_ctx {
>   	union drm_amdgpu_ctx_out out;
>   };
>   
> +/* user queue IOCTL */
> +#define AMDGPU_USERQ_OP_CREATE	1
> +#define AMDGPU_USERQ_OP_FREE	2
> +
> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE	(1 << 0)
> +#define AMDGPU_USERQ_MQD_FLAGS_AQL	(1 << 1)
> +
> +struct drm_amdgpu_userq_mqd {
> +	/** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> +	__u32	flags;
> +	/** IP type: AMDGPU_HW_IP_* */
> +	__u32	ip_type;
> +	/** GEM object handle */
> +	__u32   doorbell_handle;
> +	/** Doorbell's offset in the doorbell bo */
> +	__u32   doorbell_offset;
> +	/** GPU virtual address of the queue */
> +	__u64   queue_va;
> +	/** Size of the queue in bytes */
> +	__u64   queue_size;
> +	/** GPU virtual address of the rptr */
> +	__u64   rptr_va;
> +	/** GPU virtual address of the wptr */
> +	__u64   wptr_va;
> +	/** GPU virtual address of the shadow context space */
> +	__u64	shadow_va;
> +};
> +
> +struct drm_amdgpu_userq_in {
> +	/** AMDGPU_USERQ_OP_* */
> +	__u32	op;
> +	/** Flags */
> +	__u32	flags;
> +	/** Queue handle to associate the queue free call with,
> +	 * unused for queue create calls */
> +	__u32	queue_id;
> +	__u32	pad;
> +	/** Queue descriptor */
> +	struct drm_amdgpu_userq_mqd mqd;
> +};
> +
> +struct drm_amdgpu_userq_out {
> +	/** Queue handle */
> +	__u32	queue_id;
> +	/** Flags */
> +	__u32	flags;
> +};
> +
> +union drm_amdgpu_userq {
> +	struct drm_amdgpu_userq_in in;
> +	struct drm_amdgpu_userq_out out;
> +};
> +
>   /* vm ioctl */
>   #define AMDGPU_VM_OP_RESERVE_VMID	1
>   #define AMDGPU_VM_OP_UNRESERVE_VMID	2

