Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E289CC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED262071A
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rmLWwRMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED262071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E974898AA;
	Tue, 31 Mar 2020 14:34:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85376898AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 14:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7+tguONr+CUb4M+y1wPZ7/pIqqkho88xnfw8NsnUZ1A35txvxMhoMeMlL+kiy4P+R6VhVKhcEKqyOK6dphjFxdHpCwSqumCBzWo1vehFubrWUm9ItnpKspkSkjFr6imAEIqkE1EAEpz99KfErLvvj/oI+uIA33lHbsR6Ed+iWDvwPSmyYp9inlxpqZP16EJU0+qoS9EBnz10r5YNWX0+Mghss8lMjPP6S4YCnR0WuR1VJFMX8DQMrmOP5Lw+9ixUtDk8oTOwf/9jlXJSS7/FBZ8jL4bE2HAVAKXDRbY7R4uYI64/kRuLIGVShlq9sY9bpgv95qTMI+NJKH9zFClrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALZrSuYsSlf5HXb3zXLAj5QBz6HF5myQpOrlF1hHDDU=;
 b=M6XOJYJijZ7WixoIkXfusItV+vBYv7lJ1f/CxZMPb+51YfOtkeSvVUaxn4Rl2i6pcrtaIeG73CjUJceiCHwJmynxQ1sQqqVh6aF/RB3iaZ+hjBQRggzO0rJ0JN2QXpHuCcrvitnfFhFjAi8OdKFmK3MP9OAoAh9Ilva6Jv3DJyXMhO8bfY+Wgr3Mq4VawC/ncdXJ98TiNsS0+eR/g90uwyO/PAD0aZpb8kFVtg5i6QMF0TwxK2q8cL7Ixnrl+jHJeZzL5DukUq4Kj4RWcNhxZZs2Oe+DlCFifLkdJHav1D2d2aul2G0dPioQ42XFnydRtraWN/amRLqRHPUo/Is+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALZrSuYsSlf5HXb3zXLAj5QBz6HF5myQpOrlF1hHDDU=;
 b=rmLWwRMGITkkfBEeo6mE1gjNGCH1iy8PbB6uQPznUyhE8OmacCGVgWKB9FSzxPr8+toGQKe2SGSgNVI8s84d27YRhZsMfUg1/h+LQuPYzk7eGNJL92W2jvxqXc318b7pqP8fuMMRRlNkgtt1tYiinr1g64UpDohvy+23jBAFZX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 14:34:53 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 14:34:53 +0000
Subject: Re: [PATCH] drm/amdgpu/sdma5: silence a warning
To: amd-gfx@lists.freedesktop.org
References: <20200331143249.758402-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <e97da958-b681-ea44-3d55-2047e9c524cc@amd.com>
Date: Tue, 31 Mar 2020 16:39:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200331143249.758402-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::42) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2e:7400:298:c664:b0ca:de76]
 (2003:c5:8f2e:7400:298:c664:b0ca:de76) by
 AM0PR01CA0065.eurprd01.prod.exchangelabs.com (2603:10a6:208:e6::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Tue, 31 Mar 2020 14:34:52 +0000
X-Originating-IP: [2003:c5:8f2e:7400:298:c664:b0ca:de76]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d1afe95-a5c3-48e9-b823-08d7d580accc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4422:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4422CC46AA3B336AEF8EE5498BC80@MN2PR12MB4422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(8676002)(36756003)(478600001)(316002)(66556008)(81166006)(66946007)(81156014)(2906002)(66476007)(8936002)(2616005)(6486002)(6916009)(5660300002)(16526019)(31686004)(31696002)(4744005)(52116002)(186003)(6666004)(53546011);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMingajl27saMjuvfYxHMOQXTASzXl+/pDD0SGTs37pjemLctYpqGhjloc7XHqTg7wE9afIUMJXWqcwnKYMK8DD4XiPWm4cxFgQ/M2kpsFpv6+Lfzd9T/EXYCIo1e4rvix90phHzsK5JBP+yk1EYOgq8TZ76Xqg5ZSgi57tgS0s0rt8nehql/2IqZ7+jAt4i2fwFER6GneXcJsTD8W8KGd/U794Zxn4qD7XbsNy27FeyzIIo9VIMxE1Qy0PynvoszJr2xtwmenE46eYoggKH2vKTlXeUj786KeUvSi64aVhR/nGgwk9QpPqqVlGnSki6vuEe2LVeK7V+NCdkMNH9dlrRHeJT8L9uJLqj+RzFblFjc5fJWs0pKo/uNo4u05MXASAu7SgKWGU8roWDRwT5WLAH20pB9x5kc13WHcaIjs3fhOiwkd5AtCrzvvFwFlzL
X-MS-Exchange-AntiSpam-MessageData: QKTlaRlY991YnAp6PiErv9rF5Z34VPGEobvjMfWkrGzwxlOswb4lIduadQT961FNMYs0awQCGYwBZVEXhNKXUSJ9kEbBAvjuQyWexuXeDgURu+oQepHz8Uq3lxZnvYe7CkaweWo8h/qYKfxr70C6KiZmb7vYCEbHZJ8XXk/EEuzkOiAqQg9Ks8GfkAxosr5YeEQk/x6GJanJRjDmIqJ5tQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1afe95-a5c3-48e9-b823-08d7d580accc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 14:34:53.0550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/lIppbaUUe3kXR51F+vMdkon8iZs3yL1exyenyLlhWPC92firYJYKB7fJ+UtGNyTbMENWrQfP+am5tn2h2Tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/31/20 4:32 PM, Alex Deucher wrote:
> This isn't actually a valid warning, but initialize the variable
> to silence the compiler.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


Acked-by: Nirmoy Das <nirmoy.das@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index f485b97ed760..06411fd099ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -554,7 +554,7 @@ static void sdma_v5_0_rlc_stop(struct amdgpu_device *adev)
>    */
>   static void sdma_v5_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>   {
> -	u32 f32_cntl, phase_quantum = 0;
> +	u32 f32_cntl = 0, phase_quantum = 0;
>   	int i;
>   
>   	if (amdgpu_sdma_phase_quantum) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
