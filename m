Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AFDC3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2334A20870
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X0AYFO1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2334A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE526E59F;
	Tue,  3 Mar 2020 21:57:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFAEE6E59F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 21:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOC9NsuVjWf7omiF60VhYjXDKyLNGaOH+INrgB/FqjitfQm29Bc5oql5X14k/NQ2XqoKnI2y16jzNVzBbCsmzd/l1cpzdfXWhyCQHhX3TBJ+K8yQEWWUQO8oFam+A7hD9qT3YiipFX/uBYpJAmyYxz0lAJU7k4F25/ITw7H7Adj9TrbFLzByb582cqObO6lCMuPpzFRfkYf+Zd8KysvV3PACSXNXHV4AXMq7nhFcCtkiXJR/Eh+H5yHxCYDJtsbzxJRfQqFxCxblNbC4PwAnYOXfHWNtqdObj3eVhS/MLheTt/SRnGq27NOJ71EnkY8+W0ZCgGyV6+V2q5Ww6QmC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuBFa7gramQEQToe/iC/Rw3X0xs1xepQl1LOtmESpxo=;
 b=m67R990VqsvTTTUXS96LTX8ElS9TTucVy1tekhVjd7shufkkpR2lVUMYcinBzYKVT+XUQbwGDK6l6R56LsBQmSnlYpaIdpyS9y3VSILjCBiPPnigWzD/h/o/KCAdlX5TmVw1S7yZs1/qPx90w0EoBiKL7sDsrBxjT31H8ueX9t8GI/jiNUSbGq3GIFnyuSu6qHvFra0QVzrEVsQ5GPa6bBOI/0n+VyciqccE43CDExe+3fV/zMX0kr4vzIp5Dzntya9HzJeycrGTIgQRos6IXfYqQaL8wDzor5t5jb6GFfN9YvRDiiYF9tTXu7wiNcT1PWUkCQJ45B2wnSdyDa/THA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuBFa7gramQEQToe/iC/Rw3X0xs1xepQl1LOtmESpxo=;
 b=X0AYFO1PelEHiEAiHNc2Ftipv2+IAc7mFMIdr0GVEEoYfLZm8reJQQ/viNZkCi4sjozJOa/AJobQFBvQ9o9cNllYzIIaecjhnikLGUYihhRIUDC9vRn1HUfhOzCGmh8Yr58/oA6yst6+JCmD0bjw7Qc2cfz+uWFuCEft6gUFcR8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1647.namprd12.prod.outlook.com (2603:10b6:301:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 21:57:55 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 21:57:55 +0000
Subject: Re: [PATCH v2 0/3] Add support for USBC PD FW download
To: amd-gfx@lists.freedesktop.org
References: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <00420c78-f49e-89ad-8eb6-04eeebd579b0@amd.com>
Date: Tue, 3 Mar 2020 16:57:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 21:57:54 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcb706b8-8153-49c2-bbd4-08d7bfbdeda8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1647:|MWHPR12MB1647:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16476E73BBA0075DBF281C10EAE40@MWHPR12MB1647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(189003)(199004)(36756003)(4326008)(16526019)(26005)(956004)(6486002)(186003)(6916009)(4744005)(478600001)(2616005)(66946007)(2906002)(316002)(86362001)(16576012)(31696002)(8936002)(53546011)(31686004)(66476007)(66556008)(81166006)(8676002)(52116002)(81156014)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1647;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSuxIWVgWDd+eLQwOBoiks9kyecoJePlaZX+B6boDwsy/B2ILbUXijw6b8VuUCYmkd7A0VpTp2Rh7QaC/AyE8hC7OqrY/X4EKxFJQG18PJKCL0RPVvRglFW06BPdrehKX/4SXjDYNHgVrp7qgW1CfUJx1EQ4NeJm6k8JwbLi55vcGIHkOXCoBIMtHBWB03oQVjwsHAVNGLFjuZd8Oip9a9QHkVknmjKFpwIw2sEEpavhkNxxGwjw6tf0WW15PaE/IyjDGn0G1Pbd5ZkQXfOfbk31yQ+vnVHETz0uomopQKeMaQbcZHPESOML5fSYu0Ik/yPhUCZLpxK8o6XNHc8R8po5mtGePNahabAFAvLQ873veflzLfei+WQUbnG08GZ4jYEUWblEfS1qULdVMlW6SkFLBxtDOLbSNyNuMiGWJpMVxFRQSIM5Ql++DS3k3DeT
X-MS-Exchange-AntiSpam-MessageData: lDo6k4I1GlCsVerPKubBmyJCy0j2A4rk2LHRVNIPKIZzdmuzaUrmZ5HPFwm7UuhuQsr4IsBLhSIIjeO4vhql0HG5BtquwVcBK2HybzmiB2WnD8BR0KloW7nJX18fEoQLNY/kaZybjICdHySHOx3Yjw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb706b8-8153-49c2-bbd4-08d7bfbdeda8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 21:57:55.4886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgoYctmds5p2qLGWj8Y5/e74soZHuVdomlmRy53aEcmoPdLuD7Z5RWRHI2mdNab+lmESEhE8ui8o2D0Uo27q5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1647
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com, luben.tuikov@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please ignore this patchset as there is a typo error in second patch, 
will resend fixed V3 in a moment.

Andrey

On 3/3/20 4:54 PM, Andrey Grodzovsky wrote:
> This patchset adds the kernel driver part of supporting USBC power delivery
> firmware downloading to USBC chip on the ASIC. The FW is placed in DMA buffer
> visible to PSP which then proceeds and copies the FW over I2C to the USBC chip.
>
> Andrey Grodzovsky (3):
>    drm/amdgpu: Add USBC PD FW load interface to PSP.
>    drm/amdgpu: Add USBC PD FW load to PSP 11
>    drm/amdgpu: Add support for USBC PD FW download
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 110 +++++++++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  10 +++
>   drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |   3 +
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  |  82 ++++++++++++++++++++++++
>   4 files changed, 204 insertions(+), 1 deletion(-)
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
