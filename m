Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4AC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 08:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067212073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 08:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1hCY962n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067212073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE336E247;
	Fri,  3 Apr 2020 08:42:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C40F56E07D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 08:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvQN5Gn6tARooPHd3EBYaWTokPMzU/OQwOYDOvc6MIq/VQLnpNpNkwJx4FOqZXRE0LkjskLmzHaBjQ0MziVNmn6X05tvjDudXmqCt2M55liTR7dc6qXygWK49/rXM4O++zTF/RtUi4Gxs1KFWnQ2az3D83ZCZKjYcPpggo+cW9CJUpwCDC8sOzZuBRvLIbaJitH5NMiyoAW7bQbuPID1OQh0jSInFp4Q8yZ/8lp0M01EoCrhW8EFTnS+1v+kI5br790pJAX3rPpmjMz7OxPJWR3jr7KA8d95cLfSnsvEYcW/19QX+kxabZ0JnLtOVt5UNpJhcM/QIAEZUO8508p22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTe4vKdLEDHY89T6Mv/nkjCpq/FO20YtqVy9YiuPJe8=;
 b=RA7GSoa7LrYYapK1Y3rt0U5LfdBcK6ENd2/GMf+jbGrN0tW+u5fS+ajHUtGNAwNIwdAD4e9ELyO7502JZhR7N3zQOwFMFp0r/MfDtnEzo5CpWeHIEx5EBRFyXWfOGFLuTHagz2ZbYDchROagXyosDdNjwd/tvqbNJnXHRQRBvN2GJvr3YUBWO8Y5L0gBpK8wyIUX1f7ws2jBUWjs3ZHOfmKnoCiX5sjAgkSv+sksqflOb69aiqzKg8qnVZXddS/givBYkc57i7sWpHzW6Y1d7SwlbAzD2u9Cb3+1iEEwXr2bQ0Aoci3TB0kFytHvFmWe47hoZsh9lGZY+TOoaYS1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTe4vKdLEDHY89T6Mv/nkjCpq/FO20YtqVy9YiuPJe8=;
 b=1hCY962nCWpu+TA1TN6NbQD+AbxU5/z0/ccXBRk4yIERGp1BsIqMOXTTsQHKiQHXqodFwl+ZQ31IQt8xePQQcIM3/qKlXt2RNmHQzcxs4/tQQei6yTE+b28wF5Wki8ywub3gmmkcvCJQ3vQThYv7CW35OsVRMNtwn7L/UmpQWl0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 08:42:40 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::d8e1:aec7:6c60:d13c%3]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 08:42:40 +0000
Subject: Re: [PATCH] drm/amd/powerplay: implement the is_dpm_running()
To: amd-gfx@lists.freedesktop.org
References: <1585893812-25475-1-git-send-email-Prike.Liang@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <54785ae2-dc83-841d-2dd4-2770d5caebb5@amd.com>
Date: Fri, 3 Apr 2020 10:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <1585893812-25475-1-git-send-email-Prike.Liang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:404:8e::24) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:1800:3b82:ea90:ab6d:9db3]
 (2003:c5:8f2b:1800:3b82:ea90:ab6d:9db3) by
 BN6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:404:8e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.0 via Frontend Transport; Fri, 3 Apr 2020 08:42:39 +0000
X-Originating-IP: [2003:c5:8f2b:1800:3b82:ea90:ab6d:9db3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0bb5672-19c0-425f-d164-08d7d7aaf7bf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3997E7DDB9DED7F8419B8ED48BC70@MN2PR12MB3997.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39840400004)(16526019)(81166006)(6666004)(8936002)(2616005)(81156014)(31696002)(66556008)(31686004)(66476007)(316002)(52116002)(36756003)(53546011)(5660300002)(186003)(6486002)(66946007)(8676002)(2906002)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4KdPd4g4NfwA6vlI+R9KVTG8s0NlNbki1Ne9vjmbvi+Z/F3UDqIN/NXqeGaZ/Ri6E+KTtilrImA5M76849SgFj9CqWmj7kQkvaCelucDBkOOQ8IDSY06xmwT5f6ZGPx4kF3W7mUDzoj/uCdoRwTDgH80mtYN6gjdF2Xpeg3EL4y1C62cII+zT3GwaU/0mMdbXQUfG7pbgkUAlSPAFQVoa0fRsnFXj0tfgsjjkXn2Ude4J/8EjW+HaWkRQFPfRK5zsmRVjDC50mtoNyiV4G1bhos9N5CKNZ5BzcfWMrN/QptDHyk8I0BjH4OVsUgrkMUtQi5tapWbiLCbxH9GoWzRQlY/gi+vloEvzX4K4K/5eMvA6IpT+WTbUC7EW8xjfI4wKMyCXMgcpgtx96j0qDgscr3cRB6UWZpGM7nGsPWWKeupiDSgxe8ggwqho2qPB7Q
X-MS-Exchange-AntiSpam-MessageData: WR0uadASdimBbATrTEyKcWZwbZe2qqf+wBlDjjyBhv4wSxvy2xcDd5bsz9/nb/DAeNMi6qS5z0mUSP9HH1ITYyZZWZfjHBmGxdf58e5SMPbxBc2/T9S+GnS4mJtpgsOoqzsKLA4w4lStgybhl4A9kusi5y9pvyq9eu1+Um/k/7TuQZRAAaCA8CtoRaeRntvBkvjtL65vPX3UE4cKG5lZHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bb5672-19c0-425f-d164-08d7d7aaf7bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 08:42:39.8749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/K6bAkJBW1ACcnDjVYX3F09k9noRrT0P9W4Bz1GD4tTvJUUABQCbYvIS4UVV2PrdwjDah8OHYdMD4F0A5A1pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3997
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


On 4/3/20 8:03 AM, Prike Liang wrote:
> As the pmfw hasn't exported the interface of SMU feature
> mask to APU SKU so just force on all the features to driver
> inquired interface at early initial stage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index c6b39a7..ff73a73 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -893,6 +893,17 @@ static int renoir_read_sensor(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static bool renoir_is_dpm_running(struct smu_context *smu)
> +{
> +	/*
> +	 * Util now, the pmfw hasn't exported the interface of SMU

small typo:

Util ->Until


> +	 * feature mask to APU SKU so just force on all the feature
> +	 * at early initial stage.
> +	 */
> +	return true;
> +
> +}
> +
>   static const struct pptable_funcs renoir_ppt_funcs = {
>   	.get_smu_msg_index = renoir_get_smu_msg_index,
>   	.get_smu_clk_index = renoir_get_smu_clk_index,
> @@ -933,6 +944,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>   	.mode2_reset = smu_v12_0_mode2_reset,
>   	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
>   	.set_driver_table_location = smu_v12_0_set_driver_table_location,
> +	.is_dpm_running = renoir_is_dpm_running,
>   };
>   
>   void renoir_set_ppt_funcs(struct smu_context *smu)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
