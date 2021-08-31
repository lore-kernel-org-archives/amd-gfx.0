Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0AC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 06:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2344B60F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 06:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2344B60F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C270C898C2;
	Tue, 31 Aug 2021 06:33:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA35898C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 06:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZgiV67YHrTBmlBEPb6XY1bHlfO1IRisxCs0OfdQ+nEih8Udp0dsxWVzIcskZakZ6RASorna+z9Ds22UKLue6MpzRAFaUAFzozP0FN6bTTfxnpok01sRLfpUMJ4CGW29MMOn4KYBlvO94McOFvDCtnhqP02Knvd8lfSTDuVI2YnF53dHD8eZERfo+1C++KCN+d8vWpV09WxPqJbgDcX2of5KyzYNg8wH/JrWlYHp/z3J2mgrbmT5UezYTI+QeT1DRJF49kauOhEt9RRhSS8cTvgtEOU/fYlVEHSwZzHX5U383qh6aParRgy/Ps12odKULlt4w63hJ7aT1fkbWNY+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHN1QeZ1ov1cjKQyJ3l+HioIrIEdgJjFX4fKKfwDPhQ=;
 b=YPflw9rJNoAJ+cnQNtfyEK3RXpcgraS226fyQNTlLJB0BnlXhvHByOpUz1RrzF8R1HaoYhVv7jbqC/ak6g2cXgXL9JxeQn8039vwQkLOVaXbjxxw51/VtTuADouRVvD25UGfa/WCax2LOfj+snOAJyjYh6HmNuQ381lau3UpNEap5kSz5LI2wj+uHLdRQo9cv8ImcGlPwZsbM0IsVNAZ0auQi4OQ3aPehXq8nTzlK4SurQsOPYoBu9JxabBc5O4o+v+jQIexdR80PxwK0QFvCW4UJhgwCqcWWemINmZvP1aUsKFcfT3683exZUFXjx+eFxVr30IeIIoDpfNksxbvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHN1QeZ1ov1cjKQyJ3l+HioIrIEdgJjFX4fKKfwDPhQ=;
 b=bXhZOFwY/kAundZap9C69Sv7qwh/Ye7gwFJ2NSvcs6hj+yuf8nPRJBb1vg1z4R2NzQiL2I62iwe4kQAWBcI3DIyoHIYH4RJdo9nVHiGM8KEdmYQ+pUG5b7IwDKGQBrRnAZ/KDlVRsNCd/q0tCoZwj+ywIpuldJP50X5WtkhWRXg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3903.namprd12.prod.outlook.com (2603:10b6:208:15a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 06:33:23 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 06:33:23 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
References: <1DC31191-52FA-4636-8537-E43B9D8802D7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <588c2d49-413e-94d2-7f44-3329689fc84b@amd.com>
Date: Tue, 31 Aug 2021 08:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1DC31191-52FA-4636-8537-E43B9D8802D7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0177.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR02CA0177.eurprd02.prod.outlook.com (2603:10a6:20b:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Tue, 31 Aug 2021 06:33:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e253bb8c-3021-46f7-c976-08d96c493b25
X-MS-TrafficTypeDiagnostic: MN2PR12MB3903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39035487CD3F103A05E3B87783CC9@MN2PR12MB3903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36QB24XaKoeGNyiVD2WWf7A58nQzRo0JpUmsVtZ7PE4/cDQPFiZwtDSgnav5j0igtGz8gpe6yxTD9Oedf1SkTa9NF74uh+IoOshlS21tCzuF+wNhhGoO2+x1iDaTEEZ5yXYDOtBo+2mzekXEJz9JNZEeqgXIb8zNxjBy6LYn6C4NsRk7gOtwvrdbH1iuXkzCZIbzYTndErhFc8gBv4csjdJuZoET16TttvK+5yDqluE/zciTfurUwagcVvDOOZ8oDTXBzqZe9es5B9h/01o/hefKGIYUOSq9zzZb0u4nTffo5rbhigX9tQkDy+zROv94XgA2F/vM+qDlHPnnV/7rVxHR6KNXKLgatozb4Fd+Iv2NRiXK2BIOzxefGMM90xl+Ck+8KXNmgMs54+wyMVDiWgCZguWAGyer2WoJO4ad/ux1vwV3CyUFsqZukzdR6dF+KyXKr6bbXP75nbb7ZucvDQ5kqTx6fJ9vLnYsKheCCpKDyXppWKLuosbwIJcACf9KbBBJniIEy+oIB4hWBtQFWx7yGM5iLARpKJwmFvHmO28WRxpcTtJiAMSlHYPEiewY714WgEw+t3jPJLeFj9aW+jeqOTSI0GiDkF++P4Ij64ZPg2onRmpHapa2WWC5rVZfVNnWXmM7xb+2MwxuhIuEWQSu0pzvKiBXJyKjNhTK7WtzRJQcKAASCZEy/3avDTVqLST9SQGPeCL+p1Dywc/+L3+ubRia0wC3O8s2pVsKnf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(4326008)(6666004)(86362001)(54906003)(83380400001)(66556008)(66946007)(6486002)(110136005)(5660300002)(66476007)(36756003)(2906002)(16576012)(31686004)(478600001)(38100700002)(2616005)(316002)(26005)(8936002)(4744005)(31696002)(8676002)(956004)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1kwUHNoRTJ3QjNIU2lQUklTWTAvZnR6MWYrNGVZYU5wWHBiT0h1aXQ4Vi9T?=
 =?utf-8?B?ZnNBZmdBMjhvN3FML1k4akRRM2MwZ0xZUStXcDk5aFhjODA5em9PYkg1dEdr?=
 =?utf-8?B?dFBQZFVzZW5rRnhhTExpckNGcFRGUGUzcXpoMUNiR21tZFVQS3FNU0Fma0pz?=
 =?utf-8?B?QmVMRFdWV3hwbWVLMFNyM0U4NlNqbjhDMkxaTzd6YXBPTE1Qb09xZzhCMHYw?=
 =?utf-8?B?aERIcTBMWFNUcE9HL2NEdlg3U0l4NjFhMXNpQzViMEJsQzFQdlBkRDNMSGoz?=
 =?utf-8?B?ZmV0Wmczc0JHeTdNa25UYjRYM2IzQ0JBYXl0Z2FPT0FSalFvWlZ4azVsaXk5?=
 =?utf-8?B?NnZNOE5HYTExQ1R6YjlaUG5EaDFMVnhIUlhkb25NR1VvNGVNcFA5ZGxVMkxl?=
 =?utf-8?B?WG5FbXJDL204VU1pZjE1cTg0TGY3VVhwbEllMldUUjBlZ3lEQUZFN2tOT3hQ?=
 =?utf-8?B?SkphZVA5b0NMQVNiV2pTL1hyVDBXS0JSaXd0NlR6dGVXTXJrM2RCaTRYakw5?=
 =?utf-8?B?UENKVDZOQXlwMnl4Wnp5c0FsSkwySEZsQ3BrY21nbmpXeXBDaVp2U1pPdXBV?=
 =?utf-8?B?VVRpSkF2ZzdXWXdacHh6Z0J1eGkxRWZTTUFmRU9MYklXSFMxSTNsZ0dybkpm?=
 =?utf-8?B?Wml5cDJxWkwwaHRJU09IU3NIc1hVSDAvQWpBejNLL1V2Q0VqK21oSFozUThP?=
 =?utf-8?B?YWswV0VOY1VDTXpNaDFqVlc1REVVVVBzY2RpYnVTL1VONm9wdllJY3IwL3N4?=
 =?utf-8?B?MGo5di9NYlR1TVFlWnlvZExnaTlseHdQdzZKUmR0UnFGeFpCWlJTQWcyL2Rk?=
 =?utf-8?B?Nk1yeFNlT202bnJ1TFRsbGZjTDYvTVl2bCsyNDRTV0VtUVlYSlVzcTRZOUs1?=
 =?utf-8?B?Z2ZRRktQRjlYejVla2srM0hiRnJuZHRuejFXVnh6Y2RrNjdlTmp5TzhLRDBX?=
 =?utf-8?B?Q1FCTUhKVGRhZ2tjV3R1amtCc0JFd29RSFVjK25Yc2RNcUQzcWY4T05uWWto?=
 =?utf-8?B?RnpyWVd1anR0SmhrR1krbGt3cGRTY1kxSHlrYlBsRkk1WEZpQ0FKcWpUZks4?=
 =?utf-8?B?QWhRekJqNDBQRSt0TVlVSlZrRXpuTWlEbWZwNmxVaDZHbVE5aGZkMy9WUmE5?=
 =?utf-8?B?N2ZsWFllY2s1dmVvbnhWSmlicHB2bUNzR2RIcUNLN2pydnIxL0hEOXM4RnUv?=
 =?utf-8?B?dklBQXVoQU5obWg3dVNHL1FEam1XTmg3SnVPcGEwOUhNTW8vVU1JWndrK2Yx?=
 =?utf-8?B?aFkvOTFGYWlJSlBJTk9HMGJ6QlVsUmJLU2lZZERWOHUwc3JBdmRsV1ZPaEhv?=
 =?utf-8?B?M1NNek02Tk90Mm5MN1gvdmhHQ3BWa0VGcGhrZmQ1N3ZLYVVOelZTd29PeTVx?=
 =?utf-8?B?MlRydTlqZVBUK1hYM1pUU3ZmczRkNnhUZ0dmKy81WTAzM0JYWUZNWnRadjU3?=
 =?utf-8?B?WlA1a1NhM0RMcHY2Y1VoTWRJTWZ5TTByK2VLMnBHbFpPb2ViUVZqaVhBd3RG?=
 =?utf-8?B?bi96N3djUWhZRFIxcVZVNTIwRzk5SHdzM3Y1RUJSbDA3dDJpTVNxMWdLN1h6?=
 =?utf-8?B?aUk5KzIvcHNHNGFGUFVSNXB6eTFlT3VMc09zT1d3WjU2VFlUbHJJWHFpN2M0?=
 =?utf-8?B?VUFHcnJxa0FNVUJNWUo0S1BBaFA5allIZnZhRHZwNlBldGkzMkhoc1M4VmM1?=
 =?utf-8?B?cDFycExybUl1V1dqWWpPUzJYVUFiZHZLWkFGS3VOMjRBWnNHVEwxNnFWdzdq?=
 =?utf-8?Q?MYS4aFMLWJXfhEOt/F1NZPZCJ4oEh6p/EuUJApd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e253bb8c-3021-46f7-c976-08d96c493b25
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 06:33:23.2459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i1SdTTrdSdaHw1ivmg9895Uqhp1/BAGMzhZhGFM2CJDXAVhJ4whc9JJsrGm8XXL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3903
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

Am 31.08.21 um 07:55 schrieb Pan, Xinhui:
> Fall through to handle the error instead of return.

Can you also clean up the "if (r) {.. if (r !=..." above?

And please figure out which patch introduced the problem and add a 
Fixes: tag and maybe CC: stable as well.

Thanks for the help,
Christian.

>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 85b292ed5c43..7ddd429052ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -355,7 +355,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   			DRM_DEBUG("Failed to allocate GEM object (%llu, %d, %llu, %d)\n",
>   				  size, initial_domain, args->in.alignment, r);
>   		}
> -		return r;
>   	}
>   
>   	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {

