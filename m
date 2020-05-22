Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B0C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A280E20738
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 10:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rWVJoAFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A280E20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612AE6E9B1;
	Fri, 22 May 2020 10:03:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F5766E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 10:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2jWps4KGSgn1q1vzycLcHwParjAMAf2d72HLU7k/f3Q3j+VMeCMU+affybBnHgtgzCO0UxbhM2qfvo6ZD8wIVHYyOj8OosAGnncE7q8MqKh/gjMeR2TL3lSDVwvG+OOTvV+JF34gOHFCfXGj4HaW8LTAtzrRBmLtl5uYr/Bdhz6VgQ+AKLLZ9AYSDUl00Fz/iTiELFvQI2ia3L7y0zvTih4beIDJwdSvUEkGZmdlkvUp0WSsSbzSLcr0rienk7aZuAPleeSMDScwUN0OKd3JfVA+fRPSiAsAfMy6wOJt0ltox6TGG4xqJ6QGOExr8pqBMZaPeSsjGOrAAjHPh7sVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgqX/QAdY+U37/U++CutJtZcyMMjWgYTlxunTxv6b+4=;
 b=WvqEMSfyYmXkUsFipcyGIQQLDRXQSY6s4b5SU35svduMnDIqUgU2lsZxB1XHhcVM4ui9IogN5m7IBEOK+GvqkVY67JEYVN6Eanvb7jUjTk1cIGr0vw2J9m7yGSuoJTPD/ddXDqZmdJ4f3kp4oaKWBENC9il42bebmn5+VmXvnfYfkA+75fEBleoMfgyCfddDDhwZ4rc1l/pKLX0XtYkmU2oi7DIbiF6OhpmXm0cf0dA0J+2Ekgp4rjeQHK6+edb36HiHTPlD5DTkVZu+VMBfQxihJNVJ97/RvkB3oen1HOuVD0EHTDcOhA6pHvduwadBXlGM7Qko1MkDi/yxdxm5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgqX/QAdY+U37/U++CutJtZcyMMjWgYTlxunTxv6b+4=;
 b=rWVJoAFBN1jQPz7BPjiXDQjaC6Bs8hB8P68mDxdCWeqErD0h3TPufTaIbTDE00YP0OusYojPDeCgunazU4LTGaRMPneI36izGJrPumqJbJTKqIA7qcIp0J7ahVTU/vKjFy/Pp+yj0fXmZHUWBf4GCeAMjBx7zhFtx7uOXnCK5KM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3664.namprd12.prod.outlook.com (2603:10b6:208:159::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 10:03:41 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 10:03:41 +0000
Subject: Re: [PATCH] drm/amdgpu: print warning when input address is invalid
To: amd-gfx@lists.freedesktop.org
References: <20200522100033.3813-1-guchun.chen@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <907f93ba-ba2d-064e-0556-ada05e6d8161@amd.com>
Date: Fri, 22 May 2020 12:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200522100033.3813-1-guchun.chen@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::14) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2003:c5:8f21:1d00:c4e6:c55c:319:7815) by
 AM4PR0101CA0046.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 10:03:40 +0000
X-Originating-IP: [2003:c5:8f21:1d00:c4e6:c55c:319:7815]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4dffa77e-4c99-40e1-aa7d-08d7fe376780
X-MS-TrafficTypeDiagnostic: MN2PR12MB3664:
X-Microsoft-Antispam-PRVS: <MN2PR12MB366412303D82CC9C1B919DF78BB40@MN2PR12MB3664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozwkP9gsP9SEDqiqbvEe43qIoqeI3ObXtu88kMcP3BIj4TKCOs8FFP2FmhTN/rA81HBHpOhsoGNs5k3kT/Gq8DTFB/0AO1WXFpzHCrVafguz1KyEga6kGsW/hdXJDqKA2gBRpHFuRhJjUvCl5Ju/u2gGQC4NcnT84fYclbFl535BgsGiF6h+km19liOjSt2Qw9oXjL5E4AtEVttRlz9BygTr/18+1Ms7H3C9+wcW/kaMdS56vB79H6pP2a+FMuWjViB6u3gD2rBup383GhL/hHqQorGvZa6j3guIljb7Bm0XvYtUlweyPZfy3XI64HqMRzhViUENbvXTwAnwRHsydilUpor1Fr6KhFOn0p4zlTPi/t7mfyowjdY0oXSTTJRLIV4DBpQkAy9VhjDpi+QjoQlSlKZ0m3YPkf9V3nUH+/H5E5QKYPwWDRVKrgCR90ChFsqtp33OWcne8HAfPM751p0flA3xgP0CutcMcJDjLYcmffJ8d4IHfObpDrzVLMFz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(2616005)(53546011)(6506007)(66556008)(66476007)(66946007)(52116002)(186003)(6486002)(2906002)(316002)(31696002)(16526019)(478600001)(36756003)(6512007)(6916009)(5660300002)(4744005)(8936002)(6666004)(31686004)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sXyg0PIMe8+YYlJm5F5NxT6QGC6lhKUzzVossQmmjE/Qp5YRswpdVV4SADh6p0GIbnoQQwU9ptm5Ebcb+ajl29auKqf9B/szC14Ly38hUTjzMWTAZdwIeEeIBcr14kz4NuHiLdGtETjGZ9zSWSaVWpXTVNqzsD7mDIw9CIGx5WBJotO0aH9iXYC+uyiwVvCi+hsEq+DiJurgEhth2KDj+JqwcTCmKVVOESZvD9axs4tdWapPUcPH86SGOyNVOYXDCTTJbRrP505/TYhlyx4zckBGZPzZTw6zqHMIE7V5EpVMUpGvPxlW5lL6/1LDL5HjYtMxi6DiwCGuu9WfdfHmJ5IRHzyWKMLRNfthunoyW+Qr0qbGNIYPBzGz6nS8v466eCooZZILHuj9foIMWCnBF34REgbiQTp6Typ5Oamwb3TG7Xa/aoiE6Bi9lBp3EEzV5WhsSGgbi/kqgAn9DSpkUe2CyMz1xgt8K/Ng7zzlMV3fnCSG3pA5CbEpC4Y5ZkYMKItIaxaP/Skw6FKI+maO2ACwfYmzoYkhyaGSzEyS+Xg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dffa77e-4c99-40e1-aa7d-08d7fe376780
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 10:03:41.2214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WXimIYZ1F0xKVO+Ksi8RpfO2Q6hbwzc3KhBuSCCHddlyj2TJ3zLvfxKs0Y4kD0/OKwWy6CUS4UYjrvhfSCUQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3664
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

LGTM

Acked-by: Nirmoy Das <nirmoy.das@amd.com>


On 5/22/20 12:00 PM, Guchun Chen wrote:
> This will assist debug in error injection case.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 50fe08bf2f72..9475891ee989 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -318,6 +318,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
>   	case 2:
>   		if ((data.inject.address >= adev->gmc.mc_vram_size) ||
>   		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
> +			dev_warn(adev->dev, "RAS WARN: input address "
> +					"0x%llx is invalid.",
> +					data.inject.address);
>   			ret = -EINVAL;
>   			break;
>   		}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
