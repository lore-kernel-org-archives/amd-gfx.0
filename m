Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0DAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 06:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B01610E192;
	Thu, 13 Oct 2022 06:14:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAA310E1BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 06:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk/kcIie9YbeHdQwBnQyQhTsurlXPwmXYrh4eVDD7HrYNaYJziL8dxji7sYbtr9pooIiMoltaKONXRYRJppaNgAzAN1htCgK2rJ5KKaKe6ON7t+Jw3sScfAjqjc94bWpAA/TUWAR5Hfd1vwcZcwrYzBlGLbiXlPj+18vwmS4y4el7rS26AXAExhdBx8OIVtuybzYvyOD5rcbzKinErLoQHm7anChHhuIhaP0DlsR6PVbrre8Er9k89nF7e+jayREac8TRvHRqNXU3YQZi40x6O+HtumGX6SUz5hf5tGP3opGFk21YhOqg4Qctv7ZGPcjE1zxW8CAYCHgOeNKtXcvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS7acsXHum5VA70BmLzHnP1R33UzqapvmDJ9OX2LVvM=;
 b=nNerWwEaCrs4t93pc/drG7j18C7WWKmZk/j41lq6ofELP9LLTfA+04svnh2B8u36Nas6pbu0PElqqM2pVgGqrCgcISCmkiHrGzAY3sG0bknX7/OjiKzVURgFtdw+Wn6syeW0CbQAvOYrsid4sRowpWc2iYLf+raqQzdCyZ+8iq4OiK+cgQuAKn/dqfCL6xh3DTzXU7p640qyOE4ZgypP4ic/KL8j9vVFDkbKTBdPMxXt3Mvj3B6puxl5h7DkV8oI3Wx/GbXdfNbcfjgR7M3yjjjb4iy3SprlDVCpnsvj/Ss/6ytQo2ylESm9xX7jK+PGYxIFaBcGZJr9BdLbEBPp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS7acsXHum5VA70BmLzHnP1R33UzqapvmDJ9OX2LVvM=;
 b=yRO1K4aaulJL8lR0/t2m3eHGdEspR6UF3xlBVHOqQAw+xhUqd2pJtkxf+4oEuBoIYj7p5daIqpJyUwfvVzZEhkfjK/8ykXtHJn+nZBYDg5wudkQD4dFkxC8L5oBm+ZJ0/12y3IF1g9x+GdRC4ho1kCyjByesv4a7ogSEQ5V0qhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 06:14:26 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 06:14:26 +0000
Message-ID: <66b99175-cc47-6e75-e6f9-6ef68607772e@amd.com>
Date: Thu, 13 Oct 2022 02:14:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/4] drm/amdgpu: Add software ring callbacks for gfx9 (v8)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221010060719.2057386-1-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221010060719.2057386-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0f1f63-6497-463c-feb7-08daace22e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17E+Tn9tvnGJx4+GHLCSbPsi8Bs0LWfwpBcy0Q1wtTqQ1reFg74sGPlKgkawWWUEBXXSszvgH5OKuEHkSbABth11ird8nnbtg0FPSf9579m3VcivtXdgzgzyRbhrbDEhwW+OcZOXhdwoBbnU5naffwSr06joOpP8DaRjE038bQavP2Ncdn+MllnPvLnxUilF1ShTBqSwl/PfKQvhNyxSSjsoenKYRS/6Bn2owcW+DguMFQbk1KVtWSub+Fhoo6TN/Y/rrR3GAPCBFjH5KYa5ALxX03BAmiLSPIFwnU3mPPtDxdu1fSbNogBtonnWNKx9maN5d2jICdFM1MpNvskp2Xp/I1yS03d7QQr9CPyK/Ubu5T1c6WbARZnAkgNPWbO3tk1+cQNUAHBpe4YIOq+7fmT6vile+8FKaujvyKHJWhWqL0qS56JCWBm5bN63WBuyds43vxDuoAbLDy3AVWgs4kEhf2MrIOItRaIZy8HdXFOVGrfW0Xb05IzUjEstwtP+Smg/AB2H55t5GGnnAqwyD9lqeQHbvCwnzm1vPFejf5hWCH62j1scxMHrmK3jGm1ltcEn/FLnnSnwtXrDuccGo795fPth4lCeGOZZbYgbQLOpPQccQWL2DAzpZHhHyLWZA+ISucYJjz4gAgbkETSYeVyJWpUzlZpIksVFunlvqYdr2CbMLwSTq1H0Moch779dpD7PxYV/2giwyo5qBol/KszYT05SulibKSS91uhwz0LSlQzQUWsT5yToJYG8lnQUSdZkji+C4iCLG3T4lbj6oVtObfKBzbwaU0uhe83eVsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(66476007)(6486002)(66946007)(66556008)(2616005)(6506007)(53546011)(6666004)(4326008)(8936002)(36756003)(478600001)(38100700002)(186003)(6512007)(26005)(41300700001)(316002)(66574015)(44832011)(86362001)(54906003)(31696002)(83380400001)(30864003)(8676002)(2906002)(5660300002)(4001150100001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRlR0FHckNyRkFudjBEckNMZzIyYlZyaGpoWmFJYUFOTklWdzRBdzhOL2My?=
 =?utf-8?B?eFl0d3d3Yzd2N0N3QXpBTGxWUEpnV3ZCYzdqdVYxVUdBekhONFhCbjg5L0Y1?=
 =?utf-8?B?ODhBRm1rR00wU3hPd1ZXR0NpRlMraVlpdnhYVFBXZmtaTjNDYXhXOVBKZHN2?=
 =?utf-8?B?ZGErNEExdWhkZHEvd0F5Y3ZQUnlpaXZ6Nm9oZ2xCVFBYTWk4d2ZHczc4blNZ?=
 =?utf-8?B?REl0R2tKa1RCWEsyU2FmcXFic3o2R3ZVVTJwU1hXMEszc3VYM1NtWTFiQ3Fu?=
 =?utf-8?B?dUtZOXZIeS9IRTFJQTZob2ZuWjI3RnY5MVhubkpRdDRRNXhuMnR2Sit6VkM1?=
 =?utf-8?B?V3lsWklGMktUVmpWb2NKZ1A0QzBqMEhoY2MwVHgxQmFxY2tocENGOGMrK0g3?=
 =?utf-8?B?QXI1K1puRm1Lb29qM3VYVWtCVW5yeUZMUURzU0pnWlV4NzRFS3V4MUZvRFVI?=
 =?utf-8?B?Qi9yMEF0WFRpSVMzWjRCakUrWjRyNTBBZG4zQVQxZHdReVFJTXp2eHA5djRH?=
 =?utf-8?B?ZmkwZklETlRKeWtuV1FqLzNGSFRXMzZIQXhWM1ZGTFFveWlUZVRpbkd2VGp3?=
 =?utf-8?B?blc0YW80VTlISUJUT0dTZnd4YVdPa0VlcnUzVXNwYjl1Tk55QlFpbGx0MXdt?=
 =?utf-8?B?R0lNWnowKzQ2aFp0MlpEa01HR0JKY09mWFlIQVFpOU5rVzlCNjJIRElDYTdF?=
 =?utf-8?B?T0tvOXh1TzZBK3kzUWJLRjNzS1lPNms1cHMwek9vS0ptS1llSENLRFdsZWFM?=
 =?utf-8?B?VWdCNWZ5RWJXbytpQnB2R2NCZ05ka212YWxBbUdTREtwMXBGdHFlUmVVYmZD?=
 =?utf-8?B?dTF0YkUxTWZIa052M1FCYjI5cDFic05xTTNVakxNSWErMWpIOXd0L1RHSExx?=
 =?utf-8?B?UGFyS0J1REJ4OUhQc3poTE1vSTJqUHFEWTFuQ0tIbXRPUVZ0MVZmNFVnNjhZ?=
 =?utf-8?B?WXNXUjhYRjRScjQ4bFhyVTlIMDI5M0tLeVJyeUlSWW45N2g0RDhVdDlQRW5k?=
 =?utf-8?B?T2QzV0o2SlMxUy83bGJFUldTd3BIVmUwQ2RQS05HNUNaS2pIcDJ4dUQvTGtp?=
 =?utf-8?B?b0cvaU50YXBxWGxMY3k0SVJhV1h5UmE2OTBDNnp6c1NTRnhLQXVKR3EwaUVP?=
 =?utf-8?B?R2ZJTnJWUE5mR256aFdkZkZLanZVdllRY2JsR3JsalVoYitqT3N1ckU1MkhT?=
 =?utf-8?B?YnRUbTJxTldUYTgvZlE5blVMNzFrNGhKSXc5elM1bEJqNHBvdU9XeXVNaWFK?=
 =?utf-8?B?TTM1NmpNbHBCWGgzelJuWE9CWGIzRkFMZldSa1o0K29ndk5UZElZRjl3L29i?=
 =?utf-8?B?VEtnRmZ5VWMvRkorWkZYMEFhQVNxWTRRNkY0a0pGbExoTXl5SGh2ZjVFclB1?=
 =?utf-8?B?VmF1bmNMcjFzMkdRRXlZNEI1MU9GclQ4dXhqSW1OSHZxeGhTVnR3TnBFclRO?=
 =?utf-8?B?a3VnMlg2QmpuMjcycDBsVWlsZWxXd01OeDFISnVVcjZlL2hKMDBPeEZ2VWdW?=
 =?utf-8?B?REdZdk1FTG9WZFYxTGQ3N2U0UDNnM2l3N1BkSCsyUkxCSHl2ZkljMW9XQ1g1?=
 =?utf-8?B?YjhmOG1XbE1EeEsyd1NHWmZyU0xFSmRhTUp4Zi9GakNnaVhnMDk1aURqSFR6?=
 =?utf-8?B?U2c2dDFUS3pnZG94WCtDT1FwRzhZS1ZXSXUxb0hFQVA0dk9iQzhMUnpIZ2hY?=
 =?utf-8?B?MWNkVXdiZSt2TG5NMU8wV2ZxSGMzbGkyeDBDTFM2UWRDc3Vud2hKWFRoTCt0?=
 =?utf-8?B?cUF0YW8wcEU3YjJ5M1RKbWNVK3lQVW5zWXJJYUZxeU5Ub0ZiUVBpNVlCV21G?=
 =?utf-8?B?am14bk9MQmw4SlFBa3Z1dG9EcjRCd2QxdkhOSHRvQ0VLL0FaME43TW1MelB6?=
 =?utf-8?B?N01mbi9PeWtLNDVBbkNudzBUS2NXKzV4MjZzRFpVOXF6MjJMT0wxYzlSeSts?=
 =?utf-8?B?NGtiZ21hTUo5M3ArZEQzR01jdGxINy8yeXI1clZVckFYYnMyMWVaRklqdG9I?=
 =?utf-8?B?akVuQmNWUmV3L1RGUGprd3diamFYZlVTWWY1MVlDUmE1cVhKL2RxajFrcS9w?=
 =?utf-8?B?cDkvSDV1S3pTak5iSGhVdHVQUVBReXN4ekdDM2tWK2dqT3BiVnJJNFJmWUNv?=
 =?utf-8?Q?we5sSfXMFG/9IePu0gPib7XEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0f1f63-6497-463c-feb7-08daace22e4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 06:14:26.7267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFUTC2TYs6tM+kzcaIiL84U7OZMKxQfDxNo/DJlyoospnP4zlUwpJSbABYJJ2D9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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
Cc: Likun Gao <Likun.Gao@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inlined:

On 2022-10-10 02:07, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> Set ring functions with software ring callbacks on gfx9.
> 
> The software ring could be tested by debugfs_test_ib case.
> 
> v2: Set sw_ring 2 to enable software ring by default.
> v3: Remove the parameter for software ring enablement.
> v4: Use amdgpu_ring_init/fini for software rings.
> v5: Update for code format. Fix conflict.
> v6: Remove unnecessary checks and enable software ring on gfx9 by default.
> v7: Use static array for software ring names and priorities.
> v8: Stop creating software rings if no gfx ring existed.
> 
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Tags appear in chronological order, and thus Acked-by and Reviewed-by tags
appear after your Signed-off-by tag. Please move the Acked-by tag after
your Signed-off-by and thenafter add any subsequent/new tags below it.

I don't see any glaring problems with this patch, but it should be heavily tested.

Regards,
Luben

> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Cc: Likun Gao <Likun.Gao@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c |  20 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 113 ++++++++++++++++++-
>  5 files changed, 136 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 9996dadb39f7..4fdfc3ec134a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -348,6 +348,7 @@ struct amdgpu_gfx {
>  
>  	bool				is_poweron;
>  
> +	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
>  	struct amdgpu_ring_mux          muxer;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 40b1277b4f0c..f08ee1ac281c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -39,6 +39,7 @@ struct amdgpu_vm;
>  #define AMDGPU_MAX_RINGS		28
>  #define AMDGPU_MAX_HWIP_RINGS		8
>  #define AMDGPU_MAX_GFX_RINGS		2
> +#define AMDGPU_MAX_SW_GFX_RINGS         2
>  #define AMDGPU_MAX_COMPUTE_RINGS	8
>  #define AMDGPU_MAX_VCE_RINGS		3
>  #define AMDGPU_MAX_UVD_ENC_RINGS	2
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index 43cab8a37754..2e64ffccc030 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -29,6 +29,14 @@
>  
>  #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
>  
> +static const struct ring_info {
> +	unsigned int hw_pio;
> +	const char *ring_name;
> +} sw_ring_info[] = {
> +	{ AMDGPU_RING_PRIO_DEFAULT, "gfx_low"},
> +	{ AMDGPU_RING_PRIO_2, "gfx_high"},
> +};
> +
>  int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>  			 unsigned int entry_size)
>  {
> @@ -215,3 +223,15 @@ void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>  {
>  	WARN_ON(!ring->is_sw_ring);
>  }
> +
> +const char *amdgpu_sw_ring_name(int idx)
> +{
> +	return idx < ARRAY_SIZE(sw_ring_info) ?
> +		sw_ring_info[idx].ring_name : NULL;
> +}
> +
> +unsigned int amdgpu_sw_ring_priority(int idx)
> +{
> +	return idx < ARRAY_SIZE(sw_ring_info) ?
> +		sw_ring_info[idx].hw_pio : AMDGPU_RING_PRIO_DEFAULT;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> index d91629589577..28399f4b0e5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -73,4 +73,6 @@ void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>  void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
>  void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
>  
> +const char *amdgpu_sw_ring_name(int idx);
> +unsigned int amdgpu_sw_ring_priority(int idx);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 6b609f33261f..8d4fbc9e3fc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -47,6 +47,7 @@
>  
>  #include "amdgpu_ras.h"
>  
> +#include "amdgpu_ring_mux.h"
>  #include "gfx_v9_4.h"
>  #include "gfx_v9_0.h"
>  #include "gfx_v9_4_2.h"
> @@ -56,6 +57,7 @@
>  #include "asic_reg/gc/gc_9_0_default.h"
>  
>  #define GFX9_NUM_GFX_RINGS     1
> +#define GFX9_NUM_SW_GFX_RINGS  2
>  #define GFX9_MEC_HPD_SIZE 4096
>  #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
>  #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
> @@ -2273,6 +2275,7 @@ static int gfx_v9_0_sw_init(void *handle)
>  	struct amdgpu_ring *ring;
>  	struct amdgpu_kiq *kiq;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	unsigned int hw_prio;
>  
>  	switch (adev->ip_versions[GC_HWIP][0]) {
>  	case IP_VERSION(9, 0, 1):
> @@ -2356,6 +2359,9 @@ static int gfx_v9_0_sw_init(void *handle)
>  			sprintf(ring->name, "gfx_%d", i);
>  		ring->use_doorbell = true;
>  		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> +
> +		/* disable scheduler on the real ring */
> +		ring->no_scheduler = true;
>  		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
>  				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
>  				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> @@ -2363,6 +2369,41 @@ static int gfx_v9_0_sw_init(void *handle)
>  			return r;
>  	}
>  
> +	/* set up the software rings */
> +	if (adev->gfx.num_gfx_rings) {
> +		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
> +			ring = &adev->gfx.sw_gfx_ring[i];
> +			ring->ring_obj = NULL;
> +			sprintf(ring->name, amdgpu_sw_ring_name(i));
> +			ring->use_doorbell = true;
> +			ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> +			ring->is_sw_ring = true;
> +			hw_prio = amdgpu_sw_ring_priority(i);
> +			r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
> +					     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP, hw_prio,
> +					     NULL);
> +			if (r)
> +				return r;
> +			ring->wptr = 0;
> +		}
> +
> +		/* init the muxer and add software rings */
> +		r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0],
> +					 GFX9_NUM_SW_GFX_RINGS);
> +		if (r) {
> +			DRM_ERROR("amdgpu_ring_mux_init failed(%d)\n", r);
> +			return r;
> +		}
> +		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
> +			r = amdgpu_ring_mux_add_sw_ring(&adev->gfx.muxer,
> +							&adev->gfx.sw_gfx_ring[i]);
> +			if (r) {
> +				DRM_ERROR("amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
> +				return r;
> +			}
> +		}
> +	}
> +
>  	/* set up the compute queues - allocate horizontally across pipes */
>  	ring_id = 0;
>  	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> @@ -2413,6 +2454,12 @@ static int gfx_v9_0_sw_fini(void *handle)
>  	int i;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> +	if (adev->gfx.num_gfx_rings) {
> +		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
> +			amdgpu_ring_fini(&adev->gfx.sw_gfx_ring[i]);
> +		amdgpu_ring_mux_fini(&adev->gfx.muxer);
> +	}
> +
>  	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>  	for (i = 0; i < adev->gfx.num_compute_rings; i++)
> @@ -5877,7 +5924,11 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>  
>  	switch (me_id) {
>  	case 0:
> -		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> +		/* Fence signals are handled on the software rings*/
> +		if (adev->gfx.num_gfx_rings) {
> +			for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
> +				amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
> +		}
>  		break;
>  	case 1:
>  	case 2:
> @@ -6882,6 +6933,61 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>  	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>  };
>  
> +static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
> +	.type = AMDGPU_RING_TYPE_GFX,
> +	.align_mask = 0xff,
> +	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
> +	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
> +	.vmhub = AMDGPU_GFXHUB_0,
> +	.get_rptr = amdgpu_sw_ring_get_rptr_gfx,
> +	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
> +	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
> +	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 +  /* COND_EXEC */
> +		7 +  /* PIPELINE_SYNC */
> +		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> +		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> +		2 + /* VM_FLUSH */
> +		8 +  /* FENCE for VM_FLUSH */
> +		20 + /* GDS switch */
> +		4 + /* double SWITCH_BUFFER,
> +		     * the first COND_EXEC jump to the place just
> +		     * prior to this double SWITCH_BUFFER
> +		     */
> +		5 + /* COND_EXEC */
> +		7 +	 /*	HDP_flush */
> +		4 +	 /*	VGT_flush */
> +		14 + /*	CE_META */
> +		31 + /*	DE_META */
> +		3 + /* CNTX_CTRL */
> +		5 + /* HDP_INVL */
> +		8 + 8 + /* FENCE x2 */
> +		2 + /* SWITCH_BUFFER */
> +		7, /* gfx_v9_0_emit_mem_sync */
> +	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
> +	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
> +	.emit_fence = gfx_v9_0_ring_emit_fence,
> +	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
> +	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
> +	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
> +	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
> +	.test_ring = gfx_v9_0_ring_test_ring,
> +	.test_ib = gfx_v9_0_ring_test_ib,
> +	.insert_nop = amdgpu_sw_ring_insert_nop,
> +	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.emit_switch_buffer = gfx_v9_ring_emit_sb,
> +	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
> +	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
> +	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
> +	.emit_wreg = gfx_v9_0_ring_emit_wreg,
> +	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> +	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> +	.soft_recovery = gfx_v9_0_ring_soft_recovery,
> +	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +};
> +
>  static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>  	.type = AMDGPU_RING_TYPE_COMPUTE,
>  	.align_mask = 0xff,
> @@ -6959,6 +7065,11 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>  	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>  		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
>  
> +	if (adev->gfx.num_gfx_rings) {
> +		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
> +			adev->gfx.sw_gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
> +	}
> +
>  	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>  		adev->gfx.compute_ring[i].funcs = &gfx_v9_0_ring_funcs_compute;
>  }
