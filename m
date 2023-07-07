Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1ECEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A8D10E51A;
	Fri,  7 Jul 2023 07:24:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A3310E51A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/5Id/Py5SkuJRdN59VAd+gGMFLCdCH8zGSNLQ5VZGwaSumlYVP8GJVQwLsUEgVdMo4t7jg1py/UCvJJ66fVXgj26iZdOn3OWXaVM7bQ912UcPobv0+wEb8NMwxKVGwj9PII0HuAyWHRw71oQD0xRse6rgHQlaNfeibOHjc0cknCs+OBqfh0qp3HBAKAmFBnNboiqOS8hX5ednmz3tWIuLpF+aeMftk6gw7fPsJduiAcXhrwNU9F9ee0LqpGsKH7aEqVW9Sc7C7HtvE/05pKdge+PWlcUPjelV/QLq9AeIp1vbVwL3cRpquinU3qkC661HaXOjjpXol0xfKbY5zTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgTgQqO70BoTPFKvtMZXSQCVY/CeVNWtUnwkHFeta4Q=;
 b=YUHeo6zCbgJngtv2Zaf+v7fAn3d7ANQrLmJkZSmhCnG1Ypw87b4sdxv3B83I9FYRjzL2yW77nW5/wJ2vlUzsRg+mXB8CLqDDFfXpyZEEpvUhzUK/rJEBgs6uQwLsoBOUcCJBokTdmWj950Z9oQMOSi1sauk9Nobd6aYRt6J5ymZA+sJAcAzD74tfkMx2zKSNRb01c4M0gvr/g7cH+XB6Yp3xtwIktSMTwyl1SB8f7TvGrMatLn28oin+KHb4EwuZCT0zZeyClZZcDzUL6xG7JItwasY/z3wTt9EjYYVY4zWNWBHX4XcQWIY4oGeTWysx2ITg89oZ/rCNVXLpkt1YUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgTgQqO70BoTPFKvtMZXSQCVY/CeVNWtUnwkHFeta4Q=;
 b=z43if2dhigKPuqK9DxTaC//qvUjq7TkZJjB1OqZa83edxvRpKQwmuGw2l+78kgvL+a8X5DadZnWuX8zH1dyyISlCTPGXnx2OA5gLS70hOhxFRYXjbX6/VbINBjaaE5bent8Of4HQTNbHq6xBAuBMWrxhEQQOb423YeYHpFkcNao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5262.namprd12.prod.outlook.com (2603:10b6:5:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:24:10 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e8c1:b961:25c0:1fb0%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:24:10 +0000
Message-ID: <dfd92e84-c51a-82cb-5449-b3bb9c1dd3db@amd.com>
Date: Fri, 7 Jul 2023 09:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 04/10] drm/amdgpu: create GFX-gen11 usermode queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-5-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706123602.2331-5-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 050cf943-f36d-4071-779e-08db7ebb283a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gv5k9UnUeJ06qgp/pfU/UziFcp6T3DAO2Tc8CdcHYsVCaGKNKvFv77MWvXIqxXSEpZYMnFJZjw4dtfXLyJEvFdxUO4z1E9qlo0Gk4uaE+OlAyiLK73sO4EhaWE2U+vKlJSo/h86feWDxeNCu2ybnOj6StL5uPW6kXC3gnpP6uNVaJ9i7AqyGpEmcR/d5sil7fHZpn+nd1+bT5Ppv/Ql3uGMi2DA7d/yWo53nlcNBm576sgfTKkNYCeu4pntHFcp5UvleEWcC7P6zKi7aikaZkV/zQuPsdkETd1R6A0JaSKmBaMaKFOjYDhD7X8dH4eSyc3S3lmYu5IFrLZHT3JrZTctVj27/EtATx/ykqYWpgUzNNzE7VBMbavavmMFW3EFuuEstWLgmBvghE+Gbghssv7ktgdsFZ/+WShTQCwvtZiMrMNuRrZB2YUd1k3lakWLh2XjlHxN+C1Y6IJSr2yhQ8UrPvmVn0tbNH6BGBLP7JwIOxgfEXVB40Q+FkOedi3Or8btysYMk3/jI70TNdtl1ULTjaCl76G4+HnmJ9LtCoJFrQuUOkuvXkIVojyJKBzGndHckLANIR9nbOKhNQzHWGDZjwiDYqBnZCliV3pYB8c38paf4Jzs9pqM2sIxzpOMAnwaRBYPQNe3YJI3UeTVEeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(5660300002)(316002)(2906002)(4326008)(66946007)(66556008)(31686004)(66476007)(41300700001)(186003)(6486002)(478600001)(8936002)(8676002)(6506007)(2616005)(83380400001)(6666004)(38100700002)(36756003)(86362001)(6512007)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1UwcmcvYWtFM2FXUHhidWV2cnNJK1NzWWt0RjNSbGNKZU1YQUZKT1RCNlQr?=
 =?utf-8?B?d3NWQSs1SGlZc1lPc3psSWtSWnlpNngwNHVjaFJqNFVFdVFNWGlqSHNFb1B3?=
 =?utf-8?B?OU9XeWp0UlNwMDQxSXlQU3IzVEFtRUh4WTdPWkUyTkhkaGtZUU9XQWRhRzlS?=
 =?utf-8?B?UEp0aVhzbHl0bzNUWCtHem5aY0p4Q0pIMk44TzNRVHNqUnkzaGF0VmVuTTFj?=
 =?utf-8?B?NVQ3MUF0Vk9RTFlwNlZiZlMxclI3dFFtd2RuQnd1MnNqYlF1UEpLMzQ5ZWt6?=
 =?utf-8?B?aDQydlhVbTRncmt5ck1JYk92YzZ5SDN0bThDWTRzRkg3SnZuSVJ2NE43U3Bj?=
 =?utf-8?B?TXNqL1lCWkhUWmlRWXRUMTZrMkZtNzBqcU9ncHdaVGZGazYvMVh0VXhtMys1?=
 =?utf-8?B?MzhsZ2poY3Fsa0Fxc1M5V05HaWc3czliS2lEZndrRjgrQWt3emVNNEQyZkN3?=
 =?utf-8?B?QkVycXFtQXhRanZ1VmdFYytOUFVVeElXZlUrcnpBcGIwU3k0Y1Rodi9mYzgr?=
 =?utf-8?B?M1RDV1Z6dEpCWXZYeU42WHgzN2gxK1dtblVKY1BpL3Fhc2JEeDZ6aWtTKzNS?=
 =?utf-8?B?eHptMmRnU0lYWG9ENjU3V0JDcFZtTHhObzFIL0tXYnlMZHl1b0pJUkdGQ0dN?=
 =?utf-8?B?dzhBTmE0RTFmekdqT0dzTEUrZmY1Um84V2RQNW1TTG43TDlTcDJpazEwbFVE?=
 =?utf-8?B?Q0lzWkh2SWhZZVF2MEo4Um1SMWFPaUF4U3F3MmJyU0RDYnlGa251bDV2em5j?=
 =?utf-8?B?bGlNaCszdmhFZ3dqU1MzWm9LZTJ1cTZBMVpScVRCRXBXNXVKSXRQMXZXWDla?=
 =?utf-8?B?TXVJY1B5cFBJSWd3OEV4TmNSSTVIYVFrbGVhcFcxczRlY0UrbE55ZW94ai95?=
 =?utf-8?B?YitaU1M0c1RoSXFkNU1UYXhBNXhvcEVGUDgxbTNpUnRZdVZRMW12TUtLaVFE?=
 =?utf-8?B?Tll1elRyZ3JmRm9mV2lWT1p3UEtZa0RSYU1pcG01aXlkZHVrd3FSOEg2ODlJ?=
 =?utf-8?B?OXdhRHp5TWtaOC9zdTA1aDN2aTJ2SldaMVc5Yzc1N3JQcHpQbWl2ZVliNmNr?=
 =?utf-8?B?Q2d3RG90aUw1VExFN0VqMHBUMDhoTDZabndLbnRJVnhWTGk3RkI5WnprMDFn?=
 =?utf-8?B?bkhBWUZxR3ZJMk1iaUl5d0czSXMyMWpoTWVLcjJpOGZTcTNVRDBJN3h0bFdh?=
 =?utf-8?B?K1ljaVA1Wk5OQU5lczJkbHlIc2RudXROTVhhQmlzcGZmL21STTBZaHlrM1pP?=
 =?utf-8?B?U2poaktCUG91NmJJeFo5T0w1WlB3KzNHeHRsS2dBNW51aHFaTFcrZWd1UDhl?=
 =?utf-8?B?eHh5TDNkYWkydXFDUW8zMXV2dkZka1doOUJYWGZ2aXE3MDI3NWw1SmJFK3F2?=
 =?utf-8?B?dE5JdUlqZStvWUxHU01VWXhYUnF3engwVDNJSzVEckNzU28yUFM3YXJCL2ZJ?=
 =?utf-8?B?NlJHSkUzUXNaZzBJNS9qRFRiQ3pMNmVDek9ZR0FieTJ4VTZMUlFtdkI3M1Jn?=
 =?utf-8?B?L3dUbW51M3BtdC9jWTNuZTBCMmRJZWRSTlNOek5qL2FqR1FYeGZ5ZCtSRWpJ?=
 =?utf-8?B?K0Q0UnZ3RnprQmZNK0J1UkVaTXlaU1lQTHFWZTEvSklNY3ZBaXBYY1lyVUxw?=
 =?utf-8?B?eWhRZWtxbVI2Wmt4UmVRL0lzNVcvdTY2K0pIU2Y2MnpwaCtrajcrSnkxNHRH?=
 =?utf-8?B?UVpZUURzK3gvNktuQ2MzODV2V05TQytkbkdjVXdOME5BSTBzYlFla1ZFNVlR?=
 =?utf-8?B?bWREOUZRZ3VYcUszZHlPbHpmNUxZNndJRUdCUWJ3cWYzUnFHZUZkRGxlN0d5?=
 =?utf-8?B?N0lMQVl2aWgvdkpURmROWVFkdXdXeHZ4cXFyT2NzbFVVc0NPMDYybEVHY2hk?=
 =?utf-8?B?cWpBZlZqdUxQTFp2OVZJcEk3K2VySHVOSWl3VDZuNWxWYnA0a2lYeGZqZjVK?=
 =?utf-8?B?RUs2U0owRWRKWG9JL200ZHRUOTRpbDFJWm9tMUZmNVBoZkpiSVZxZWwrY1ll?=
 =?utf-8?B?UTNVNFVXWG4wNXlTZzhCMVdsM3VCdUpxOFk1eTF6WEwyQklrZmFUMXBLVWZ2?=
 =?utf-8?B?QzFRdEgrVFM0MHd4RVJiclFva2Jac21odi9DQnZHR0FwR3pZRlhTeTNOR1VV?=
 =?utf-8?B?Uk1lTlUwVlNnMzhLSG1vUVczR1RJVXZtOU1WSXQ1SmVhOVFtdm0ydU5FenhB?=
 =?utf-8?Q?Hh6l/mJ+idF4+hvS1iCZqK3Jkma2LfG2wuUNaEJUdeXn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050cf943-f36d-4071-779e-08db7ebb283a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:24:10.5690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 025amdf+Z+H0FgVJXrnhWt97cO+5gP9v9XXELuodDCKF7uxZGjLACOOwylr9EVkQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5262
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 06.07.23 um 14:35 schrieb Shashank Sharma:
> A Memory queue descriptor (MQD) of a userqueue defines it in
> the hw's context. As MQD format can vary between different
> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>
> This patch:
> - Introduces MQD handler functions for the usermode queues.
> - Adds new functions to create and destroy userqueue MQD for
>    GFX-GEN-11 IP
>
> V1: Worked on review comments from Alex:
>      - Make MQD functions GEN and IP specific
>
> V2: Worked on review comments from Alex:
>      - Reuse the existing adev->mqd[ip] for MQD creation
>      - Formatting and arrangement of code
>
> V3:
>      - Integration with doorbell manager
>
> V4: Review comments addressed:
>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>      - Align name of structure members (Luben)
>      - Don't break up the Cc tag list and the Sob tag list in commit
>        message (Luben)
> V5:
>     - No need to reserve the bo for MQD (Christian).
>     - Some more changes to support IP specific MQD creation.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 73 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>   3 files changed, 96 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index e37b5da5a0d0..bb774144c372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -134,12 +134,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   	return r;
>   }
>   
> +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> +
> +static void
> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	int maj;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	uint32_t version = adev->ip_versions[GC_HWIP][0];
> +
> +	/* We support usermode queue only for GFX V11 as of now */
> +	maj = IP_VERSION_MAJ(version);
> +	if (maj == 11)
> +		uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
> +}
> +
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>   {
>   	mutex_init(&userq_mgr->userq_mutex);
>   	idr_init_base(&userq_mgr->userq_idr, 1);
>   	userq_mgr->adev = adev;
>   
> +	amdgpu_userqueue_setup_gfx(userq_mgr);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index c4940b6ea1c4..e76e1b86b434 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -30,6 +30,7 @@
>   #include "amdgpu_psp.h"
>   #include "amdgpu_smu.h"
>   #include "amdgpu_atomfirmware.h"
> +#include "amdgpu_userqueue.h"
>   #include "imu_v11_0.h"
>   #include "soc21.h"
>   #include "nvd.h"
> @@ -6486,3 +6487,75 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.rev = 0,
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
> +
> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
> +				      struct drm_amdgpu_userq_in *args_in,
> +				      struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_mqd *mqd_gfx_generic = &adev->mqds[AMDGPU_HW_IP_GFX];
> +	struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
> +	struct amdgpu_mqd_prop userq_props;
> +	int r;
> +
> +	/* Incoming MQD parameters from userspace to be saved here */
> +	memset(&mqd_user, 0, sizeof(mqd_user));
> +
> +	/* Structure to initialize MQD for userqueue using generic MQD init function */
> +	memset(&userq_props, 0, sizeof(userq_props));
> +
> +	if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd_gfx_v11_0)) {
> +		DRM_ERROR("MQD size mismatch\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd), args_in->mqd_size)) {
> +		DRM_ERROR("Failed to get user MQD\n");
> +		return -EFAULT;
> +	}

Sorry, I've just seen that now. Please don't have a copy_from_user() in 
the backend!

This is pure front end stuff which we shouldn't do in hw generation 
specific code.

Regards,
Christian.

> +
> +	/* Create BO for actual Userqueue MQD now */
> +	r = amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &queue->mqd.obj,
> +				    &queue->mqd.gpu_addr,
> +				    &queue->mqd.cpu_ptr);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +		return -ENOMEM;
> +	}
> +	memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
> +
> +	/* Initialize the MQD BO with user given values */
> +	userq_props.wptr_gpu_addr = mqd_user.wptr_va;
> +	userq_props.rptr_gpu_addr = mqd_user.rptr_va;
> +	userq_props.queue_size = mqd_user.queue_size;
> +	userq_props.hqd_base_gpu_addr = mqd_user.queue_va;
> +	userq_props.mqd_gpu_addr = queue->mqd.gpu_addr;
> +	userq_props.use_doorbell = true;
> +
> +	r = mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_ptr, &userq_props);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize MQD for userqueue\n");
> +		goto free_mqd;
> +	}
> +
> +	return 0;
> +
> +free_mqd:
> +	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
> +	return r;
> +}
> +
> +static void
> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_userq_obj *mqd = &queue->mqd;
> +
> +	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
> +}
> +
> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
> +	.mqd_create = gfx_v11_0_userq_mqd_create,
> +	.mqd_destroy = gfx_v11_0_userq_mqd_destroy,
> +};
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index 55ed6512a565..240f92796f00 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -29,6 +29,12 @@
>   
>   struct amdgpu_mqd_prop;
>   
> +struct amdgpu_userq_obj {
> +	void		 *cpu_ptr;
> +	uint64_t	 gpu_addr;
> +	struct amdgpu_bo *obj;
> +};
> +
>   struct amdgpu_usermode_queue {
>   	int			queue_type;
>   	uint64_t		doorbell_handle;
> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_mqd_prop	*userq_prop;
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct amdgpu_vm	*vm;
> +	struct amdgpu_userq_obj mqd;
>   };
>   
>   struct amdgpu_userq_funcs {

