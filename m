Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC10C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 16:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48392078E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 16:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="poCwcjzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48392078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1172689FF7;
	Mon, 10 Aug 2020 16:04:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A3889FF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 16:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmISBR0Fpwm+8xJZVk0L4Ksk3WWjvY98RpWcechrM+3hhiGb0ZEGsDAUmWLVWW6vuc0VSOzaH5t6+Dz/ONBEARXJAWw/NuAdQscjQy2huHgvBkGNpJheWfPTpgSPEWnDBJioD/yKfHFTQ6YjJgWXMir67UfUIwTirB7eJ0HiJzggtI4S6wceSnYDMxteJS5p5L2eLbuwAybXElXHVkDtZJSFH1HSK085IaBPYvfq4uYRqmqWHiEyxm2dH4NycchwrphRlozhN5YfyV39djS7RfI9sRSNXgN4a+7LpF71slUGQk5jJvloMXzl1044/OTact/VCA0b4djrkMFT63wsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTfzgjzPgs5d0SAjmQalFI/Usd7KAW7XcO9GcpDh1Gc=;
 b=NVx0OatGRLGibP6LUV1vqrx+wthSbepZZDHNgG9ykLW09YlFKaWKyPRKXe5zZJqTAA4Ldn4bKUjF5D+kYJTIi2bqHxvwUJPFHPunSqIUO27NKXMZkCj9zm0ms+QjonlaA9MoeVjHhJWMLQ5xy/KQqBJx68XFSaGWEJe/ggyF0O9cKGxpsb+SjZfd0cp8vp6JYoffnIZfyIeg3xeU94+UPZWOjULE0dQTbq+LIZ2HqbzT82QTuPPu/rpGSeki6KzFKI/V3S0TVhpKeSk6XOWrlLQ7jI8SoZPludLPiYYoyH3QMw6+QNYdhVDHLSsul9cJz6Rf59VfGgioMXvYsgYNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTfzgjzPgs5d0SAjmQalFI/Usd7KAW7XcO9GcpDh1Gc=;
 b=poCwcjzKlm9aD+Bn1a+RGrTzpRxNQ2cOevfNU6JbzOzgObGSo3kLBFONKLC7yhPCry3JyQdeWrP04xdUDSdzy+Bwf2OOFtrCxqg3XWMzFu6UF1CtElS1o+okRf1PmThNNCZwT6vohJORKZkLLjRHLyk9Sh7tlMXOSM1TkHRlmNQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3161.namprd12.prod.outlook.com (2603:10b6:5:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Mon, 10 Aug
 2020 16:04:56 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 16:04:56 +0000
Subject: Re: [PATCH] drm/amdgpu/display: drop unused function
To: amd-gfx@lists.freedesktop.org
References: <20200810155658.287244-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ffcf28f1-dfd7-1de5-d9ce-93d03172b714@amd.com>
Date: Mon, 10 Aug 2020 18:08:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200810155658.287244-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0123.eurprd04.prod.outlook.com
 (2603:10a6:208:55::28) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.49.195) by
 AM0PR04CA0123.eurprd04.prod.outlook.com (2603:10a6:208:55::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Mon, 10 Aug 2020 16:04:55 +0000
X-Originating-IP: [93.229.49.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d66fd81-afac-4b1a-73d6-08d83d471fc6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3161:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3161C8D0A035DCC89A1C2AAD8B440@DM6PR12MB3161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaxY9YYTmIdheMtVInGBe2USxAIlMjLLbEiEgfWlqoJNmDOrfqBgZ9fbbm9p+K0NSMlrYSlRR7+PCHUketgY7yTlreKLY48rPt2XSNgRP5iowbWekNOfDde+or2R0U/MoYmgchtKVL1m+r8gOueDz7xlg8txYj9eykK8WUqxSMjIVu8LncGEilz3k344BDLW3TG6WukWAzNf2xmwN3faZ8ODtncb37ptIlDJkn+kJY96lHZ9oIM3Zaw970SYq9iEogsp+ozUukwKwZFI5Eal2GfRX8x7/gie9WP322lVXdFk2xLFfP780oZJe8Ko1oftlET5GE0HmNlJsUm2oWJIyA7VD3M5POj3jt48W7n/EnoJzrFXia9QtSWALHF9s/Zu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(31686004)(31696002)(36756003)(5660300002)(52116002)(2906002)(2616005)(956004)(316002)(16576012)(53546011)(478600001)(6666004)(186003)(26005)(16526019)(83380400001)(6916009)(8676002)(6486002)(66946007)(66476007)(8936002)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9Rl2FKYz8loWfinseRFgGN5LYR5hgFtJocD93+kOTHPiBAvr0+leGHaE5gbckpaoXiadJNEpYfXx8Id6E0PZkE4qeooQmMsq2n4EbeTGZWOTyLeFY9EkVzgm6dIh/Y8tCj+arTVTaosxtRWD+3X9PTMcWrIyflvw9AfMT2idmksKUZvSEKTF7RiNOblL2Tep4mvUUOUMmdVXUoSOKPgEoC+Sr41e6B+zPT/Pzd3tgxjPDSb7PK8BkTzH4ipjOyxZQh3d4C6/k5WWWfZuF9fzUXdNk5Jk+XX62ydjPkTDesiPcTbBuoCcTIJEBOJKWRHDxRCr8tRPlerFPocdt5Uxa1ay2DT6E6Hg++eYEk/HnKoUa5tFZRkYvO/KQkrr0eBqp6ht4Ntg35WJxZqgsL6pXayouAH5SaG/vnEw5AS5irTUbE6jk56+l/IJOAAieaswV52Xk6mKGs4X/aLZUL8m2FevF1C2/i9u86BKOdQSeRvEMiCxLyo3Ur56/T5vsyoDbNVGIPWKz/cOsgRGVF75OgAEmkl5elC4LOJpXfisWlA2mYAvrWTMU4qEni5YSAGJINm3GICjmju6oINkM9V67HuNrV7YiFFuCRb3y8XyOEbyY3i25vxanhazIq3TNOGgkMOS+BMWQYKDSA+CuEjqsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d66fd81-afac-4b1a-73d6-08d83d471fc6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 16:04:56.0715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Gg8kEv1nDfUKzK2ph7JMj5AffmndsbMQygsQkYUmDrfMeGqv2ZbJULmXrG4R21SifS23g7+koFtKe6jU2AgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3161
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

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 8/10/20 5:56 PM, Alex Deucher wrote:
> This is not longer used as of the latest rework of this
> code so drop it to avoid a unused function warning.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 ------------------
>   1 file changed, 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0f9d87773fa3..ff5f7f7ceec6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2827,24 +2827,6 @@ dm_atomic_get_new_state(struct drm_atomic_state *state)
>   	return NULL;
>   }
>   
> -static struct dm_atomic_state *
> -dm_atomic_get_old_state(struct drm_atomic_state *state)
> -{
> -	struct drm_device *dev = state->dev;
> -	struct amdgpu_device *adev = dev->dev_private;
> -	struct amdgpu_display_manager *dm = &adev->dm;
> -	struct drm_private_obj *obj;
> -	struct drm_private_state *old_obj_state;
> -	int i;
> -
> -	for_each_old_private_obj_in_state(state, obj, old_obj_state, i) {
> -		if (obj->funcs == dm->atomic_obj.funcs)
> -			return to_dm_atomic_state(old_obj_state);
> -	}
> -
> -	return NULL;
> -}
> -
>   static struct drm_private_state *
>   dm_atomic_duplicate_state(struct drm_private_obj *obj)
>   {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
