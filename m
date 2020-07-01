Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB3C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 16:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA50F207FB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RJ5wC3+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA50F207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FAF6E92C;
	Wed,  1 Jul 2020 16:10:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6356E92C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2020 16:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYuRAPV7OVw6DDjevEsUmf5ajBa+dTo+uQT2UF6nuQLM7dmPKkNU1XNSafjJkPy5loQj5OoJ+chVfX7P5npbjMIHhYFYiJho2oEAp+l+Y13IfN7Xo1fEV24uOkw9uWrDrj9j2/atlzmlS+DyfirWijVUOra+BFvA7ZV1hrzWhaoRfQqCO6443opzjb8KfdxLc4bnoymqUuVUQ5NCUu3iGIyPXdgRomnMa5HY3jvS4303YUV93EjeX6og/rz6tiCblyjrA7SgHtU95MQzlzjiCuGH/uyoQ5/9rRoiNaV6X0rpsm9K6DJ79Rm9B3XhHfqu+zGUIgtRaicMjRDNXIbSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUZ5+3fp1ky1IL38o/zoGWGMJZCYNFL0TzS0FcAjzIg=;
 b=cn352w77/DTaQQaqjwCkUHG7kdxDSzmALSS7PJVPyA0d5w3WWGwZyhk12zKlWLn0zh3EpuogpT9fpb0GFPsJ2RRdY5bCHCWNWIaUl1EILgb59vh/6jD8i5yWoA1mpe/ALDMMJ12ICE9SkTyGaTWD5nEr4L53cZUMW1tT6SE/2o70hIDLL/ceoNa+4OFA5A4KYbV+OCAqYaWXOZMU4tSX6bhauJTsK3mt/At1oinLNhcWedMu+BztjtndjcfvJNwxYMbuoBJmh8go3ruXM4fHEHI2JAtiCnBEziEceV99oiUVfyP2hcA8KfawOscFkSou6GtTkJVs74pJ47HZc6Zp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUZ5+3fp1ky1IL38o/zoGWGMJZCYNFL0TzS0FcAjzIg=;
 b=RJ5wC3+Ru0j7CQEqULDyDgClBQJxtL9fbEShKpRryUEJo621QEHkaLhaQmuhjkN0dbX65/uc89O5vFdnL69PyOuywbWiFwQP8a5APW/C6kvYqBToT5Em/m0An88PToo5OhHfbudc7BuNNsLXO2PHe2yJ4R38U7ytXZpAVkqBzqo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 1 Jul
 2020 16:10:32 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 16:10:32 +0000
Subject: Re: [PATCH] drm/amdgpu: use %u rather than %d for sclk/mclk
To: amd-gfx@lists.freedesktop.org
References: <20200701160210.1127202-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <dd4cc347-eba0-d3d3-70bd-20e0f97132e8@amd.com>
Date: Wed, 1 Jul 2020 18:12:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200701160210.1127202-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::26) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.36.205) by
 AM0P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Wed, 1 Jul 2020 16:10:31 +0000
X-Originating-IP: [93.229.36.205]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4eba403d-8214-4431-5c68-08d81dd9478b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17249F03C706849B6FF65A1A8B6C0@DM5PR12MB1724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:134;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLPlhPOZ6F1/NHCB0tC1/o1Orv6JOZSFsmOsMVCkplTiUEgdPnVFJk3E6c5cuS7keZqj8QI7HLXHbuAGjzmSNaH8zhf4STLAmEvSdggP5COTfHgBkM55Kkhxq3kE0r4QGArFZFEhr8GZ/7Ki/iwCPd46EhIGRFwtHwdQSaVihquttHNVsclKgClhPyit6b21iv6OALqDBIrmTD9l7UagZ3vZwIMquaArR+do5/RPVKwb8dTFtmWu4UhKfqWjjt0npXYVdGoSpedVUF/7B/EntT7HfHOYxiAPyafb0oEEpG/+7Ji+B4c0uE2kho6nPeY5mQfFp4UuXkZ5ubli5nivgGyZ7PjwD0cDOPi2na3XhDKu6UQj0v9/ziGAnDnO/cW7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(36756003)(6486002)(2906002)(6916009)(66946007)(31686004)(6666004)(8936002)(53546011)(2616005)(52116002)(956004)(26005)(16526019)(186003)(316002)(5660300002)(83380400001)(66476007)(16576012)(66556008)(31696002)(8676002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lroKnRZF9z60TDdiOR4Ok0551xauA8OEBSvu8LHDmPhBcTvMB8S9ASZ56LxToy1Bv/SN/TiPTGUeD06htzpXyPydGSKbxrCZKcePwdL9dJPwyFBXnezf+NU1JPIXXQzABxkTwQGS9CX1h86mOAvpfevL3Y4vgUS9l5DTDFL5/9cDYnC2Kxx2Z3bC/nV/Ei7KmZNJv2iTUJmowi9sTcQqWkQa4204sttBPJ9kYi9fQ4Q899ywlKIr8kHqs0Hz1+TKvDqxu23V+lnFzhQ+GEAEtTsvFyWTBk/463jbtv3yXLvRE6INI2V+gOctCdB2p5zW7Q1JkR87FwP3kgp8NH6xqTyhsTgJriirwB37OKTiimMnOIAQ8yJet3VIgGMchNWTURiTlOeqYHFbg/g7B4za2BNjcdttlVdCGi3crEAVauC8obixEYytiQZJjaQY+LKhtaLsTu68qeqS8LwLv4asnBSKSL6xQFkWU8yKF/sTwlw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eba403d-8214-4431-5c68-08d81dd9478b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 16:10:32.0038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juuSh2v7/zPjluYw1wDzc1kAJKxmKWNUkCpztWz1nd6o9C553mCOvRkOzQM70at6POqVxvXY/SzF5i8FyevrkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
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


On 7/1/20 6:02 PM, Alex Deucher wrote:
> Large clock values may overflow and show up as negative.
>
> Reported by prOMiNd on IRC.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 26c8e39a78bd..838d6d51904c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -2960,7 +2960,7 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", sclk * 10 * 1000);
> +	return snprintf(buf, PAGE_SIZE, "%u\n", sclk * 10 * 1000);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_sclk_label(struct device *dev,
> @@ -2997,7 +2997,7 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
>   	if (r)
>   		return r;
>   
> -	return snprintf(buf, PAGE_SIZE, "%d\n", mclk * 10 * 1000);
> +	return snprintf(buf, PAGE_SIZE, "%u\n", mclk * 10 * 1000);
>   }
>   
>   static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
