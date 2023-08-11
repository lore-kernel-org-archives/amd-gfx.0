Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221DCC001DB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 14:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F2010E6A0;
	Fri, 11 Aug 2023 14:03:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7885610E69E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 14:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F36zGIok63QYneX5sHT8Qc9FGZ9SlrhJGq9F8eDElLSxbQN6d/DH/Uy/oak/WUFzQX4MbcutzaR3AyqWr29wT9ObnCefUxCfZ4M5jcOi/x/VagxUTAgd/yViRn8diPYz6u28kyae+FAFSoI/+7kl2IuTONSsp4jk5RMECBEfdxJISwv1pqD3477HTAl+onynNKPNyTSo6kEct8ZkM0BssYc1zoSpLXFpkh4HFiCLbT/aeZAZqv3APF1wq83vAkYGb3L0maagqpWqg32yH8tn9kUO7hHDmhcx4ecQbbofYwfpxoBLRYXDhI35L/7/Zv5ZzMkPMOkOJnhrGyre8uV2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaBVHlAYc0DeIKABuSIEuK1LtM10fCIKV+deeV2qsTI=;
 b=GNUiF+MvcYfiRz6XyFRVK7VaBdDTQkmnpqyuXdIdG5U/4HYbuPGijGdXbokGSST9n9Bc3o88h46EprqKQfYwAx5o2H46nZy4ByNIdLi5u4ndt7DiA6mt0a9GIENhCf/8geKxNEb+jYM+7JLXigUZxyGF1KcnnR09dYIIHKKzK4GXaTxl51BTD0ilsFSLzC9iJXJXZ8K+0LfOLNusRciBicRsawFCTQlCyzEXrzH+sbbti5Jx5ImtjXAh/FQ+YTyBI99/veXHwvA11Nn08SQz3GA7XIyaaJb83L3Xvo6yVgsiOroFzLZznHt4xTIiUppe017tTriWeIBFCXF0c67ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaBVHlAYc0DeIKABuSIEuK1LtM10fCIKV+deeV2qsTI=;
 b=dyRvLuNvnHDhfeYotjAGmQ7vRs+wLdtH9YE6q4F7WOpFdvw09GdDzigVuqtDnJT24oOlvsr5Kp4ke46Uu0fohNUAakQmC4V2LFqkBdLj2RO/7D38Y6A2EviuedTOSpdw0SJNF/1ve3v4fszwuXZ5CuiPFDCsZ2yKGvXXvPHk+IA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 14:03:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 14:03:03 +0000
Message-ID: <00930769-fb36-40c7-9fe7-c12062c3ea9e@amd.com>
Date: Fri, 11 Aug 2023 10:02:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: don't allow userspace to create a doorbell BO
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230809190956.435068-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230809190956.435068-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 45767d94-d68b-454e-0f17-08db9a73adec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvRZyOgJ5/EAATJH75U0i/2drUApb8J7k6NjCq/Vt2rmr8MagEvGeW7MBg/RBxs968a8okwMddUjx01CgpbM29s3D5wh+a07KujE+Eh2BQFwJMOFfXksfJsjQNSBrK5TKY2vHyAsh/5U5HhWBBqDToauivL+oDW9IIJntnR5KR2vwPCCCDS43S7Iu/sMfUJmvoA/21vXnPS0//A72ctiHujlbd/j+UoJwVfJAMWzJlAP7HNb7xL8eKqPhRrWcdIOQTXiypw5ekEAx09oxN8+SjYR3spAndXqifTORQPGVEqUfKoHmwSbuF1Nr/VLcYhhTWvdRoOidMmRtx/zBIW1nGyWNalN9mepaRyhaxhuW8YO8l+iZ/tHnUqpaXastub+/CX9fvLlnOvwdDHZXdc4wCFLnKEZ/YL5stlPNMh/WAGi4VT41Ip6IwDKWxzDjrO0xlelwEG0PE11sT9D7sW23IRTRjT74j5cq70uHqVAHsCia1PP1enrMuvgorco2Gft8y5I1Kn+PtSvCH8x7QnxXkVuubXiNt/uOdPWyKVQ+wrp8qpgxFWLIoz70H2cqXaYPAKk0g10feyKMsF722ok8BMrWG9CSl33b1GLdGquYLeTTvYs3gNpSfbWo/VM6jROkE2FiR7NrMiMgZm/7PNlsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(186006)(1800799006)(451199021)(31686004)(66946007)(6506007)(26005)(66476007)(478600001)(6666004)(36756003)(66556008)(83380400001)(2616005)(41300700001)(44832011)(316002)(6512007)(6486002)(2906002)(31696002)(86362001)(5660300002)(8676002)(8936002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhzenk5b0RPTWN4Ymp4WjNSaXhzNUpob21LNmxwSkQzeCtDV3BIZHUvTWEv?=
 =?utf-8?B?bE95cmVQUjdRdUUwVjZ4YnR0MHZSZzNNcTh4cnNCRGpOV2xiSUdLM0hxRHNZ?=
 =?utf-8?B?WlZJaklhamd4YVY3cnNkUXhncjZpTy9temRNMDYxcG9PdjBSMEpXSzYrV3Zq?=
 =?utf-8?B?TU5LMTFwaG1yaWFjUDVISUpLa1oydG9kNEFXY3h1RHZCeFZmSnJUNndJMHhH?=
 =?utf-8?B?bUk2RmxpN1FHeEthcUlUYk91RjNmZW5GMnlEYmxqejU1UDdaOFN5V083Vnk3?=
 =?utf-8?B?OVgwSEdoMjNPZHFSL2FmWmVGYVk2Y1c0MytEWFhqdnlsR2dDTWZQUmxieWxo?=
 =?utf-8?B?dXZBQ2JJdVp6bG5pazJkUXpRa2dZWG5oYWVZa2dnVnkwaVhKOEU2ZkJrSGJQ?=
 =?utf-8?B?WTFMdjFLU3J3SC94bnJ4VFZDc25yQzBJRFYvTGFicitGS0tFamxWT0pmUHRW?=
 =?utf-8?B?ZVlMVERIWEp6RkRucGlmUXdQZ0xGbi95ZW52QXdHNGRzQXhwVVVQcG8xK1FB?=
 =?utf-8?B?QUdhcnlESlpJQStBOXJkenVBMlhscC9SM2tML3dzeDZYSFJzNyt5L2xodzln?=
 =?utf-8?B?Uk9oTHpyNVFEbTNrZzRTYzZnUGZOUU9SUW1tUzNVZXFiSVl1dUNMaXZEWXJ0?=
 =?utf-8?B?MExJVmZWbFRLQkU3eS85UzNTWGMrNzc4cUhOYlJWN2FiNUI5MHpSSjk4VmEy?=
 =?utf-8?B?S245SjcySmdnYXN3MU40eXVQUG13V0EzVWFOaU9UamdlOXhaYkI1VzhRdkRU?=
 =?utf-8?B?UFluZXNOZEZOdEx3cWZrZkNpemh3aC92MnBEUnV6L2llUWwyRERZYmJQWkll?=
 =?utf-8?B?S1FOWVZWNGlCckIreDkzb1RybVM3QVhOU1RjOENGZllFSmFicGlZYWtQd2JI?=
 =?utf-8?B?cjJKQkh1enk3bU1MdXhwbUxaRVJZZU41bzZCbFk1NGJVeUdTM0pzQ3BtSVly?=
 =?utf-8?B?OU9vSHBUS3lCaGp5ZE9mME95dmV4eElNaGkyanYza2JZSGd1QjdtSHJnY3lD?=
 =?utf-8?B?cE1SSGtKbHFqRnlnUS82d2lNZFoxc3NHNTZMRW5RQmpPWHZHZVBuVk1vVEZX?=
 =?utf-8?B?dHQzUFpZMlo3ZllBbnFXNU40azVTZDRuYUVyREpCZlZObCswZDU5c0dMR25J?=
 =?utf-8?B?cVdLR0RqanR5SlRycEx6VUIvZW9WQ0hTRW9pUEVlWnF6V2FUa0dIUlRDRjg3?=
 =?utf-8?B?OTk2SG5qN3hoZ1hyOTVFTDJRTnFhOGg1VWRGUFdrVjBncmptQi8xeWZZZDVQ?=
 =?utf-8?B?eC80MFBDQUxPVFFmWFZERnpsSmhUTTZTdVVBcXVsMkI0cXVFRC9DZWdCT0Fu?=
 =?utf-8?B?bGY0ZnRDQ2dZaWV3UWtrdzRhaHMxVmhhNkMzRGtMbEZtc0tkenVMU1Q1WVNq?=
 =?utf-8?B?T0I0MUg1QjUzYjNUNnlVLzNscXpKbmEzV3pEcDdLbUE5eHQ3ZjNvK1kzQi9l?=
 =?utf-8?B?alVJY0QxVzZXOVFpRHFHT2hIcWduaXN3VVV5Y2J1NjNOVzVFNXdSMGZJdUZI?=
 =?utf-8?B?YmdlZ1BhSWo0RWJNSDdjc2xlcEpId1NKUFFRZG8vTUlsMHE4aG9zRDVWUE1i?=
 =?utf-8?B?SE9tNXpKUGRZRnhLa1pzbnlFZWtraWFweDZSNVRleWNZRXZsQXBISHBYanJz?=
 =?utf-8?B?ZHl4b09IbXhYRjZzSUNOU2djcXFJUzRVNUdtZXgrQ0NqV1dVdEtIdVArZUgx?=
 =?utf-8?B?b1UxT2hvY1lEY0E5UzdScE1jQzZUd0diQUJvdlAvbjc5RXdvMXBqQi9QTktB?=
 =?utf-8?B?WC9jZHpsellRRFNvK2tvKzNxU0xGd3V1V3lMaWkxbUtUa3BBTHFSQThtTktE?=
 =?utf-8?B?R0ZjV29DSjJ3QXhPSWYvMlpvVWg2bkJiOWp5OE8rSmJOU3FFdUNxMTZqSjRa?=
 =?utf-8?B?Um9qbjZnbUhXZ3REN1dNTXN5OVg2MjNEV2N2T1J2VjMyUUFYL0RNWDFOalZ0?=
 =?utf-8?B?QU1lOGtaSS93KzI5VGxkNDZoaDhJSVkyemdWZGh0cjNiaVN2WXVmVHdGdzdP?=
 =?utf-8?B?Q0JGVWhoOTJCSFU5R3gvRUkvTERYSkQ1ZFgrK2ROYm1rZ25VQU52S01veDlK?=
 =?utf-8?B?Y211T0RtcXBPN1BhYkxRbWppTmd5RGlhdGdIY0s2ekhyb1ZDM1BoaTZRb1ZT?=
 =?utf-8?Q?+NR+T5bTFnBlX4RUjTNLB4hvj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45767d94-d68b-454e-0f17-08db9a73adec
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:03:03.4441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSpa7V4F6YeNOROUVNMZGGjw2j6Pm9R2ui4qg2AsMecewoveLZNK+M6Aih8PQ9yZgW20BGcHhB3s65Rg0mV04w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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

Am 2023-08-09 um 15:09 schrieb Alex Deucher:
> We need the domains in amdgpu_drm.h for the kernel driver to manage
> the pool, but we don't want userspace using it until the code
> is ready.  So reject for now.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 693b1fd1191a..ca4d2d430e28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -289,6 +289,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	uint32_t handle, initial_domain;
>   	int r;
>   
> +	/* reject DOORBELLs until userspace code to use it is available */
> +	if (args->in.domains & AMDGPU_GEM_DOMAIN_DOORBELL)
> +		return -EINVAL;
> +
>   	/* reject invalid gem flags */
>   	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>   		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
