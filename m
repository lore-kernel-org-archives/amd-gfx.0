Return-Path: <SRS0=W31V=3Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C31C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 19:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945CA22527
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2020 19:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k+DjZ6Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945CA22527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C81B6E990;
	Mon, 27 Jan 2020 19:54:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9426E987
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2020 19:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oacpB8dOh1P4MPQwwLz+/H3IkLxIVX4iLpFe/x1dHy23ncamOsbO3MVjGjDm459aJ3X2ZY1euVo7SM1+i2jU8oEL/dZhcJvNZ/ECJo4Q9+ktxuthXJplq4H0NKcVaumJM4ShFOUWLdmp0h7oKafzKIO6VX3IH0ndHi8VdKgD+9D7XRjqRyaXwcqwJjbgHURqmxGycJlBHhjaCoJxtrzDDB1ljOke6zW6ah8XnF2CcZL980RfUEZnWxNk/TfCkAUUqqkTh0vc9JK4fctmeMvWaycjAdfJBviMHcyl8SeOLO9a+RQ8UtLCMukA/PkuzEXzBT8+VScgLoc6ymw+3tgbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDPqW+0ZlYB128IcmhAScGGWo7WwTCd9dDeFickZ8l4=;
 b=fvdHRt/3jk7MOmOu8xleH+b4JrCb+oJVNCiTmbAq69m4pbuZO2e/Wgg3YXm2bgMHDqIE9/L0uIQ3tDeVPLYPh0XYh8UMaiGnr1ALd0hEAmf+MzBtuR/AOVSwtUEcNgrlHuwsR2SqMRq1w20QUx+K6DLXHBuGroQkXvVd404d1y7wcwkyYbG/Yi1tw2pfBGIMuEKDRbZbMTTERXjc4YAnpsA6ojSWkmUxoOqG6h/Znqpnr55UluBkA74VgU1yIY6R0rtcjyCtjRKforTXaDAVPjH97xsxFpB4Yhs8XaXNl53i2MQmpZ/ZWLWjOWWKo582w7WGcAE8jHVEqRi4JCpzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDPqW+0ZlYB128IcmhAScGGWo7WwTCd9dDeFickZ8l4=;
 b=k+DjZ6LjvL2Ir4JLm+VR5199UjOCheQhHgIj18OkD8nXBZ6cywBe4v+8xAQQ8npzX2wvk6vn87UT/W1n1eeAQycV+yWniDc2zkCeQrN1kF6Fetv25vSs8ge/kabGMN5bTscbfN7cwiav5+i3wt84brYShbjBeA51RgLDkBQahTk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1741.namprd12.prod.outlook.com (10.175.53.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 19:54:00 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 19:54:00 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable GPU reset by default on renoir
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200127193757.28379-1-alexander.deucher@amd.com>
 <20200127193757.28379-2-alexander.deucher@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <25d4318b-2800-cc1f-86cd-51f07f031bce@amd.com>
Date: Mon, 27 Jan 2020 14:53:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200127193757.28379-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
Received: from [172.27.231.243] (165.204.55.251) by
 YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20 via Frontend Transport; Mon, 27 Jan 2020 19:54:00 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89e74138-bfa3-474f-ec3c-08d7a362a74e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1741:|MWHPR12MB1741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB17412F05815F2411B72E404AEA0B0@MWHPR12MB1741.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 02951C14DC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39850400004)(136003)(346002)(376002)(396003)(199004)(189003)(16576012)(316002)(81166006)(4326008)(81156014)(8676002)(6666004)(6486002)(4744005)(8936002)(5660300002)(16526019)(2616005)(956004)(26005)(186003)(66476007)(66946007)(31686004)(2906002)(52116002)(53546011)(66556008)(478600001)(36756003)(31696002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1741;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOFNsfNJnWtZF5l89A8+j8KmWUb8RDzIJbT4dLvgtNZe8MKHXR/XtQEgUuFJLztXq0o733djtTJ24EcdcW1n0L24RRwTrU7hzU8FzpiRPyPdiA49nak/QQzao2dZBHfA98HkwQ5xoOLoCnacyL2YXMvBBjLDn8LD7r7Kx6JCDw0ZcqyEqfdlcnNUJCZsHKjkHj2PJZ3M7xciYXdjg2zlJQxdWYuJGxMTQI3VPz65DPAXTPDJG0/rFxLhDZ/VdUc1dq9c1TIf0euVkL+eef/utQbHYPc1Tr46ujBxfpm07ZzeToOe5kkzkEgIQ633dXBiiYekbhhcC2IeNxA7eKKP/aPA30blKa0C/hfADvm0nHTRzMV7mBe+KaB3yqaki2Izjs2l6TUdtUM7CJf9wiOpYPlIhflCvlGBfupyfOY6nC89Z30c6g7AFtgjKz5/qhIs
X-MS-Exchange-AntiSpam-MessageData: XcBh3hfj/DdpwvFozaFwejZ+aqRmIKty3biDCvwyDh20jlBaXxU4RL4FFvDHLMRUvVTZRnFkibLxmW3Y8jvP0+yv7b0Rscnuj4t9edX5Ea9MRYDwNEFJJtDlQYZZQAJ6sehdz6B6XRqD+EtHdPTuiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e74138-bfa3-474f-ec3c-08d7a362a74e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 19:54:00.8153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5biuymQ4aubPm9JIHW5dPR6BP1cri8TweJO5V7CGuU+utIgcbX+WMu6cbhtaJCvgYAbRp3G8AN7QXH2Rfz4rUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1741
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 1/27/20 2:37 PM, Alex Deucher wrote:
> Everything is in place.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 69248d1b2417..5030a09babb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3762,6 +3762,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>   		case CHIP_VEGA12:
>   		case CHIP_RAVEN:
>   		case CHIP_ARCTURUS:
> +		case CHIP_RENOIR:
>   		case CHIP_NAVI10:
>   		case CHIP_NAVI14:
>   		case CHIP_NAVI12:
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
