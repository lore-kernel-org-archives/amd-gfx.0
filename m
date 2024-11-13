Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96A5D462AF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 14:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918CC10E71C;
	Wed, 13 Nov 2024 14:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YHQQsgNh";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04C310E71B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 14:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDhQnBR1Rn2IeeA3Hf5xptW5xaGxRRoUAvRf6yGLj7axz7To+pFqTNIoYwWG3Suz+deve0IB01KPGTr5h9Y+aie0AUnDt29x+jDgyzH+4mPpOkwN6ICBo0k/upY0SshSvjsGAUEHqCe+uKwGPkCA10bxPUaiAua0A2l+7Tq8N4q74ExO8zcXyEYmHZauhEsVNHXW6j9EKP+dZ6netMSfjurPzc9VzUIzejmKV7nEF36yz7EmA4kbX7GFcXTrd8HtMjVHCayydf3w+seCoFyksKA4BjhOFzGBQEFx6/4Anv+cPtXCOTZ28p8nDQQwf03F11CQfoyA500IB7T1m2Mctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPfI8SUaxUzzuZ5RrPckzha4REyGJuW7UwOigoP+0/g=;
 b=Eo99eNQuTvgI+ZvPkk2sZRUOA+fJXkUg7SVmiRBrglSNey9O24HQFTDkmWxzkVMnzzYUniRHPUpJIHsdzdR/Z8m+qcRnk9Xvycimk+gyr1Gflrs2gd0p2TqIuVPifbjZzWJLgvKmc/KXvWULhRHDVAgtWwhnkrY4egCHDVIIYyr1t6o9p1iIiJIKOnuj434h/lsZZGKCbOIBQYjd95PQGuHPxRCGRQfueVN6EsXlBloVJpgek9w8prqAuYP5nGk8y9es0JIQ0qNSORtxX8hTxJ0+S5v/I81adMTVrn4BtLSmg0slvXVUsVOfhX7/ETeB8/hS5oWWzdIdJJVJj2OLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPfI8SUaxUzzuZ5RrPckzha4REyGJuW7UwOigoP+0/g=;
 b=YHQQsgNhw/n3w4+YGWz5SA30UetKTSqgDYZzipTCUTzp9U5V+tuxsuftBRqB4J4HWLpw6qQM0PTf8QLpiBNOY2g6FhdeM2HpgzD6rvsSyIUZRjntS783lqNCJbF10CaKPF3GliznIS0EGAcu3gk945LJa2g9v12kNrLp3YT21Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:27:25 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8137.022; Wed, 13 Nov 2024
 14:27:25 +0000
Content-Type: multipart/alternative;
 boundary="------------XRTot0vEDWiV00000LUMwJMf"
Message-ID: <b97b6041-ab67-4dba-87d6-e40d6df095d9@amd.com>
Date: Wed, 13 Nov 2024 09:27:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: add the argument description for inst
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241113090705.741598-1-sunil.khatri@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241113090705.741598-1-sunil.khatri@amd.com>
X-ClientProxiedBy: YQZPR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::20) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4b7521-b021-4767-4ce8-08dd03ef4b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUlpREdhYi9XaWpORkNiZ0Y1ZFk1bHJBcVpVcDhiTHNJQXphbjRqeEFzZzR6?=
 =?utf-8?B?ZjhHNHZLM2JwNCtWME1zcEw2dFV1clkvOWFxMlI2b0Fsc0ZNUXZOL1ZZR1JP?=
 =?utf-8?B?YlJiS0dxZGM2ams4alhXeVAzdURaelE5dStxZjNRVHBZaThOZ1ZjeVBJcllL?=
 =?utf-8?B?VTFuWXhvdHp2QnlTcFpBc3ozci85UHh4aW5odzZrQm1lbjZOSGVQSXQ4Vm9Y?=
 =?utf-8?B?Mm1NYkhDR0JERHBLWTZBaVpPOG0zaElFR0hCbnBIMDJBNk14QWs1UFh5UWtl?=
 =?utf-8?B?TkhONHhBNWQraWw4TG1CQlRDeWN3TGgxNWI2M05jb2ZnRUdSaGU1STRwY1B0?=
 =?utf-8?B?MFd2S1g5bDNwZlJsSlJnNXJMZW9abUdxaFBnUVRXLy9ZZ3NtQ1J5K0toSjlx?=
 =?utf-8?B?MnlJdVdvRXk4R3RJNExROHVWZ3ZCeUw5UUJ3V0hwRXpKbDhNVHV6K3VVWS9D?=
 =?utf-8?B?SVh6azdHeHV5M1R4dGpwYmxaV0JQWjRBbzFiOEdKbXJXY2Q5ZmUzSWlHSll2?=
 =?utf-8?B?SmswdWpreXV3K2gyYWNmVEthZmRNNklpejVIY3ZnOW5uMktXQjdpWExRTmJ1?=
 =?utf-8?B?QU5Bc0lLMm52TmlwNk1KdWNjTG5KTmR4cFRVWlVkaDZUZUtBaGV5MU1OY2Jz?=
 =?utf-8?B?cU05K1puVlhYMDVzSjl0a2phdStOVGp6aVBBN3g2b2VnTmdGR2t0Y0VWSElk?=
 =?utf-8?B?Q0xWRitXdWtMRVBsc2JVTS9meTM5WkRBZEdPd2NIV0luWkNZSlRLaWF4K25G?=
 =?utf-8?B?ZnM3eFlOZ2F0ZHJqeXVlT0M2WTVVbytmQ2N0bDh2a1VOZGZ5Q3ZKRWh0dzFr?=
 =?utf-8?B?M1hhdUJxcGJMS1Y1Qk9jWXMxNGJpVHMxenMzY0hGWWpWaUUrYXZqR1ZVbVI0?=
 =?utf-8?B?VEk5VmJDVC9lQmtQVnBGSDRmQjBCRDhmTjdCRUl4UWZCY2J3dC85YWVUYkp4?=
 =?utf-8?B?YnJ1bXNBSGk5NklTUDF4eEx3dWR5b0xFVDZNZjdrU3JuRE9tNUp3T09GamVS?=
 =?utf-8?B?Kyt5dmJlSnJJT09GMjI5blY4TStpMStLWXd0OFZFYXljQ2poZHQ4TTdIN2Vp?=
 =?utf-8?B?NWdCbXFabzdKMTRscjFtN0psMkpVMURtMGNtbzRXUDRNRHZhMjJwUnNhNnNm?=
 =?utf-8?B?WTVLNytIWXhkdW1xNkVFK3RWWmlNZnUrNkJnazByOG85WEl3TVZWZys2ZjlF?=
 =?utf-8?B?QmdmV04zSDNMSVZHZWN1QWVmVTFZQmRDeWloMEh0dTh4ZXovVzFHaWJHQnF0?=
 =?utf-8?B?ZWE1eXJrN25QY0EwSlR1dzY0Q3Rid2FiQjlkUkltR1ZpNUdOdWlyS1RrNUYz?=
 =?utf-8?B?NHNNSDlKWlovdzJmUlZVeU90YWwwb2pSMXMzTTI4R2Q4Rm9TQ2Z5Q2ZXVWtG?=
 =?utf-8?B?TjVsSFZPWlFoUk9MWTRRQnZDMXU5ZDB6V1V6QmZOZlh1NjYzOUdNL0lPandC?=
 =?utf-8?B?c0ZQVEtNQnpiaFJhV1pIVXVFazlmNVFzM2lJNVNXNUF2YUo3bjVNMDlkUTVJ?=
 =?utf-8?B?ZnRtNm40MVJCYXpYd2NkQytXd25MakFpeGpXTHhGUWxwdHVMZkw0a0NHWmo5?=
 =?utf-8?B?SEpBQ2w3RFJZNzZFTmhEU2FTcFNFZHlZeVZCVmpGNmJBOVZ5b2RQNXRsazVa?=
 =?utf-8?B?QmZlK1lNWVg4MEE4b05xUUlDNW1BTDNGZW5KU0xLL1hVWWZnQmtmQks4UGV3?=
 =?utf-8?B?ejRaaExHWXZqOGVzRVhWSUtOek9pZ1J4TkhzTzJQRzNYamdjdmY2MDcyTGdL?=
 =?utf-8?Q?KOFSX7EnRcB8zXnhQOAF41s6TycKXZWwOLdINAy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9uMjFEd3FBYzV3N0Qyb2RBSXN3NjFuOGlRS1g3bndLeTlmZ2RxL25qYW81?=
 =?utf-8?B?NDVQdVU1aHU0MXZWUXdJYW1tNUNCVXd0dlcvRnNmbm1JaGhYVllVS0tpZnly?=
 =?utf-8?B?REZPdmQ2MnNCOG5YTk16dEpDa2ZmY0JBMXlLYmhiWUMzUmV4VkxKUUYxWnYx?=
 =?utf-8?B?enM3Nmp3OHJCRHAvcE5idmt1c3dyZjRscUVWa0xaUlFrZm1PVVVmOUJBZ243?=
 =?utf-8?B?cER4TW9aS1dCb3ZUVUJZN1RyUkpvTS9QaHJLRng0Wk5QTmUzNXp5bEVBbVpL?=
 =?utf-8?B?QVplTnI2YmdLN3pFMnlTanFZMEJOdTUzMGR5akhDenExVWRrZDBzN3dKdXYr?=
 =?utf-8?B?NXpXL0VleTQ5V1NEQXBTWjRJZnF4ZkF2b1cyTERXNzYzZWVFOEdPYXY0ODJK?=
 =?utf-8?B?Sko1UG83OXNKRHovdmFaZWQ4d1hVT1RCVjFYdjU4WnRxZzV1U29BcksxbTIy?=
 =?utf-8?B?NGdQMDVodDljbHArQWVxRFJQRnhjekJsQVFHOGZsTkI4Vmt4U2w5ZFFGRXVO?=
 =?utf-8?B?VXFoZXMrcG5GbHMvelZhRzgyaTBnYzJyMEpzdjAwVlQyaWdGNWgyWU5jUEZ2?=
 =?utf-8?B?T1F4RCtXeDl0RXpzOFFlMUhtcVgweUd0UWl4MFBRVThHNjBrVjVzTEIyM0R2?=
 =?utf-8?B?THQyZzRWYlo0MFo0QzVOeGx0ZSs2T1dGQ2xXYTFWV0E1VWZxYjJmaHR3bGtB?=
 =?utf-8?B?OExqZTVSdFVZWk4zSnVHa3lXTS9DYWlzK1NpS1ROMzROcElRTEhTclV0UTZy?=
 =?utf-8?B?Mk5SVkthQ3JZeXJpQm5iU1dYdXZ2ZFRvdWtBRUE4cVFLTmp3K1BhZWkrYUVu?=
 =?utf-8?B?UjQ3ZXBlM3FacmJ6MU1PZkdwdGpZcDBYTXgrVTlGSEtObzRqeGduWHZhWTAr?=
 =?utf-8?B?d29mWmk2MEZJaGNzWWVhTE1IWmE0cWZ3bXg3bEdNVUplaHRhOEd5bFdqaWhU?=
 =?utf-8?B?M2Ewc3UvMGY2bFFvSzgwWGorMjZCUklCbVdUNnJ3SEh5UUxneE54Nnk5S2F6?=
 =?utf-8?B?VVBwcG05QkNTVmovYUp6VGZaSzExSGJCelc4R3hmYlhmUzZRSm0xQm1MbkZy?=
 =?utf-8?B?Zjl2T0tWaUI4bzd5Z3V4QjJSOW81N3ZGTTd3d1lBeEk2K1JjVmF1bWF0R1pD?=
 =?utf-8?B?N1ZYc3Q5VUFJdlhXSjlCQXVRTU0xTGxrYWUzNnpUNzF3NHBkNnBhNkxDdDFt?=
 =?utf-8?B?ellUTWRRZWRXK205MTF3QWdORjVLcHYyZHNBZkJzOGlMdG05U2ROa1B5TCto?=
 =?utf-8?B?UEF0cUpuRU95dnZLWjVNWUxrbmJZbEthLytpdmI0UThmTnorMUVPNG1DejJz?=
 =?utf-8?B?M1UxZzBTc015OXVhTTVlRVNla256M2JmV3lCOWZwUmF0dXhYTWZ1U2xoV1dr?=
 =?utf-8?B?Q1dsT0xPeW9hYzFxZDlhZ0tRNE1ldXJnTmFCY0UwOFplM21leFJNSFJvMFJC?=
 =?utf-8?B?dDVJMVpCNWJDVUdUanhuWWZlQm9ZVy96K09pV3VhQ2FZcHVGc1hCSmp5UGww?=
 =?utf-8?B?TmNKZG9VcjhmZC9tNllvc1JKTUVtKzlPbUZxTHp0QlNUVUdDZmFDVVo3NWUw?=
 =?utf-8?B?MzVQUnhjZnh6d0ViVWNEcEZqZkdFYlZTYWhqTHU5Rkh0TmJUYk84bzF3dlBO?=
 =?utf-8?B?ekpGaTBZb3MzRXJOUDRKWnhEY1ZaRzhFRk14bzJRT0I1WmZkZU1TTUh5ckRY?=
 =?utf-8?B?SHBZT2dSQWJwTWFLK3FvSzh6SjlaWlFSWHRQd3N1c0VuRkhhTjVXcHRnM3d4?=
 =?utf-8?B?cVBQMjFCYkg2N05WaVM4NTFsb1VEUWtuM0hHRm4vUE0yUWRlT1ZTQ0NRcVhD?=
 =?utf-8?B?dkEwaTN5c09rbXYyU0FXN0lnOUs1U25CQUJ3MjhqVk8wenB2dWJtMm11K1ZS?=
 =?utf-8?B?WXhnRDB4WnA0dWNtWEh2RndsSFZlR2EwNTNFc0tGTVIwRGFMN0lYUjVNbE50?=
 =?utf-8?B?YjQ0eFl2Q1RMcHdXWHVvOTVjbUxsQk9CY2RnUXVzNUNGclpvQ1JDVnBIbEVr?=
 =?utf-8?B?RTgvdlkvSEl6NTZwblhOVDh4Y3VnTHdhTHdURW1MNkRkY3gwa2JGRTZ0QXFl?=
 =?utf-8?B?em9JNk50UGtNcG5UNW95M2hnUEdXMGcwT09JNWZMWkJTVU1jNXVoNlFXOVQ5?=
 =?utf-8?Q?0DzyY5LfB2KNIJupIMROH0e+g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4b7521-b021-4767-4ce8-08dd03ef4b8e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:27:25.8456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMeny41MbW2sOwSjF2faOp1HGn1/+aJJrQaB6xajWmmkiW6OTHADhClO+cym5FZ28AAZYe97md3ZaF3jxda4cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
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

--------------XRTot0vEDWiV00000LUMwJMf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-13 04:07, Sunil Khatri wrote:
> Add argument description for the input argument
> inst for amdgpu_device_ip_set_powergating_state.
>
> Fixes the warning raised by the compiler:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:2182:
> warning: Function parameter or struct member 'inst' not described in 'amdgpu_device_ip_set_powergating_state'
>
> Cc: Boyuan Zhang<Boyuan.Zhang@amd.com>
> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bb530dd2b3e3..b3ca911e55d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2170,6 +2170,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
>    * @dev: amdgpu_device pointer
>    * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
>    * @state: powergating state (gate or ungate)
> + * @inst: Instance id of the specific block_type
>    *
>    * Sets the requested powergating state for all instances of
>    * the hardware IP specified.
--------------XRTot0vEDWiV00000LUMwJMf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-11-13 04:07, Sunil Khatri
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241113090705.741598-1-sunil.khatri@amd.com">
      <pre class="moz-quote-pre" wrap="">Add argument description for the input argument
inst for amdgpu_device_ip_set_powergating_state.

Fixes the warning raised by the compiler:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:2182:
warning: Function parameter or struct member 'inst' not described in 'amdgpu_device_ip_set_powergating_state'

Cc: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Boyuan.Zhang@amd.com">&lt;Boyuan.Zhang@amd.com&gt;</a>
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" class="markz4gub081a" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span>:
          Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Boyuan.Zhang@amd.com">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20241113090705.741598-1-sunil.khatri@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bb530dd2b3e3..b3ca911e55d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2170,6 +2170,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
  * @dev: amdgpu_device pointer
  * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
  * @state: powergating state (gate or ungate)
+ * @inst: Instance id of the specific block_type
  *
  * Sets the requested powergating state for all instances of
  * the hardware IP specified.
</pre>
    </blockquote>
  </body>
</html>

--------------XRTot0vEDWiV00000LUMwJMf--
