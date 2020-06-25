Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08330C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 00:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88702078D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 00:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tAFXcYJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88702078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 726FF6E8AA;
	Thu, 25 Jun 2020 00:17:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA946E8AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 00:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJzvLjKS/3To+5bli5MW5BfRhBNJLdNIAOzM6LHvgxhJk16e20G5vkpSLghdFs1xOrVPVTYkzuNP47gkLB5WYusknId9R+3utK+yHg+xmEkL1Y3ySMSwUswVVZt9bT3536zxO2KLtfhM/ustplzi2DwrLQ1CL/55NUTkk7PI9ZwhNhmGGLEcFzZ2nzqiYqYv0MUbaNddt7yNPjUURddpi7mjfHu2OgSNqPpqYpRZ97ftV96wvEeJ/s8bvsKDmqyKP3ycySJuh4Ve657xhUlUZANESAVBq9PrizSEGEUMEt9hnGYN0WbZlv++mtqO1FpQP1WHvdtuaRDVXvEpksBDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTe0naKu2d2o60nx3Fma4GnEzodNN7pXGKQzSTiZHD4=;
 b=YvrYIR28N2hBVkMwWOw2lqKkgTYxFCxzxCLhY3rkJlpbJvBOz80/daYIvVmei27JHvZMNBDOO0T0K0z/DZRjoqhiLpebGsnwVwgJpr8XmJXq2J5qdYQvy123NLNC7kHKDTK/eCUyWwKsuH5h0BExTmKzZ/Z/eZJFqr5SAR9cATIaZZUWrwURkMPecHRH/BaypyI58z8+GioUgCwB+yY3Ho/LN5yT6iIky6NjG2Y4ZZFDD55mZcgx4lRmxLOtZvjW/Ncppg2TlrE/X24TH4uA610KoREaugQ/llKlfOB+9RvxRfFFl5GDGDqhn7jdk82y+d4FUjGEnut7/UvUHcX3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTe0naKu2d2o60nx3Fma4GnEzodNN7pXGKQzSTiZHD4=;
 b=tAFXcYJbq9RwMBvF2uy8ANiUpAUEg7rec6FDxeHiog2yAgkewJF3EMYWogNQQZQopH1D+wUpsYKt44Gv/f+VvI4mratWTgHmIC3yapUPDC48Dn8YGK92ImQA1gvuVbF1tyytVUBudlOxHERUA0KhIArTKpkSYQiFRAajqQi4mqs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 by BN6PR12MB1364.namprd12.prod.outlook.com (2603:10b6:404:1e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Thu, 25 Jun
 2020 00:16:59 +0000
Received: from BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2]) by BN6PR12MB1155.namprd12.prod.outlook.com
 ([fe80::6c17:115:fa26:adf2%12]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 00:16:59 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: rework runtime pm enablement for BACO
To: amd-gfx@lists.freedesktop.org
References: <20200624190519.2378793-1-alexander.deucher@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <93a8f0b2-ea36-b6b7-e613-8d8cc69b24d8@amd.com>
Date: Wed, 24 Jun 2020 20:16:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624190519.2378793-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To BN6PR12MB1155.namprd12.prod.outlook.com
 (2603:10b6:404:1b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.34.178] (165.204.54.211) by
 YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 00:16:58 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e435378-f20d-4360-d17c-08d8189d1364
X-MS-TrafficTypeDiagnostic: BN6PR12MB1364:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1364099A1553430EF83538F0FE920@BN6PR12MB1364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6YmJyZ82A03M6wh1raW2wJiFb1/mGC3lFPQ75xnJ2Mxv6tZnA3A3A0IfkWBv86qG8rK1ALYModfHN4bdYH03+a/svgqtrPFUVXHoLNolHFkhz3ZUblJFZFXyFl1qJcgWFdVYHXGPQYqWABKBUTcTErkdah7dsHGOszRVaA6BJo81R1AOt7QgeS3rZY0s5L0Z3ARpLKyFMA0E17BLaeFbJ11oRJfCPKPbxe9prvq5I/qkQR04ARHa5Qdsy5M7ALVYpz66m6pyW5+dRGJniOD8DZb+fCStNi6k1z86hDEiX2TFWzEf2cWG12GAqRXx5SvGqnnueeVp5gxBFueH8J0dQyvRxcBI4M0dQEValu+pVpPSmViaI26P6O+XeyYlYNyFrAxCnduiybXShYzpBXM+WEokSULX+F4Qxf8ecg6Yg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(36756003)(52116002)(31696002)(53546011)(6916009)(86362001)(8936002)(5660300002)(8676002)(16526019)(186003)(16576012)(966005)(2616005)(83380400001)(31686004)(316002)(26005)(66946007)(66556008)(956004)(66476007)(478600001)(2906002)(45080400002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Fb60hSKP5DdWA6euqrBfWVUhKtQILorTy/4lqK0kDZUrQNQz6sRoXBq4wJjm3KxN4h5oA9eLmrl2LtS4BcTPx+8aRVs+mkdO+h2ptJjRfgG7ooGCwE1z55F/p7FIP9ttIoIl8wVqq/rbJdCkwWKFdoFBkZ7lfv1hJ7aVJUv3aStkD/oR8CZOM4CkcvnhJWbFLjywAmbAUYGm1Uz+UaoRRAgm9q/k9SPftzgq43mjxQWYLxIiuKx43CWSUb5pWymfJjgGf8f+bGdY5wyJJvlrR3qRIYacIanihmldUAuzVlJcM3DQoBOFaXpgmr0wrFIpLyAehauUjVPYJ+9pRic87DcqVV/XKaLdr50w9CbIig+nCA+NguhsmWL0vK9u+FFd9aMOkRuRGRZBRQAnxvHVr0k9aVKwf2YLNTLRVeDHw71b2ZdLDJvmWAEs0lasDPpogSsUGbxh5fvAPcCh5BzZe+CgsmNeJCzhtMC3n9t4msHESx/1Gq9+o7WOdayHXLQt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e435378-f20d-4360-d17c-08d8189d1364
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 00:16:58.9140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEwxQC3wUo+SlwFSFuAhJSvI0Fj4rN06HpxwkwM+fh+0xpHZuTM5syz/Fx6kUPV8hGZnvcyF5i9SgFhV0RvM3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1364
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


On 6/24/2020 3:05 PM, Alex Deucher wrote:
> [CAUTION: External Email]
>
> Add a switch statement to simplify asic checks.  Note
> that BACO is not supported on APUs, so there is no
> need to check them.

why not base this on smu_context to really query the 
SMU_FEATURE_BACO_BIT and then base the below flow on that instead of 
nested logic vs case? I am not sure if there was any issue with 
smu_context earlier?

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 34 ++++++++++++++++---------
>   1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4ec544783a45..0fec39eed164 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -167,19 +167,29 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>          }
>
>          if (amdgpu_device_supports_boco(dev) &&
> -           (amdgpu_runtime_pm != 0)) /* enable runpm by default for boco */
> -               adev->runpm = true;
> -       else if (amdgpu_device_supports_baco(dev) &&
> -                (amdgpu_runtime_pm != 0) &&
> -                (adev->asic_type >= CHIP_TOPAZ) &&
> -                (adev->asic_type != CHIP_VEGA10) &&
> -                (adev->asic_type != CHIP_VEGA20) &&
> -                (adev->asic_type != CHIP_SIENNA_CICHLID) &&
> -                (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
> -               adev->runpm = true;
> -       else if (amdgpu_device_supports_baco(dev) &&
> -                (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=1 on CI */
> +           (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
>                  adev->runpm = true;
> +       } else if (amdgpu_device_supports_baco(dev) &&
> +                  (amdgpu_runtime_pm != 0)) {
> +               switch (adev->asic_type) {
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +               case CHIP_BONAIRE:
> +               case CHIP_HAWAII:
> +#endif
> +               case CHIP_VEGA10:
> +               case CHIP_VEGA20:
> +               case CHIP_ARCTURUS:
> +               case CHIP_SIENNA_CICHLID:
> +                       /* enable runpm if runpm=1 */
> +                       if (amdgpu_runtime_pm > 0)
> +                               adev->runpm = true;
> +                       break;
> +               default:
> +                       /* enable runpm on VI+ */
> +                       adev->runpm = true;
> +                       break;
> +               }
> +       }
>
>          /* Call ACPI methods: require modeset init
>           * but failure is not fatal
> --
> 2.25.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Crajneesh.bhardwaj%40amd.com%7Cd5d794bda2c44e0c902008d818719558%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637286223410087832&amp;sdata=yErSk5DyDDXPX8Y1cXp14QxX9pgwRlIj6%2FuIhNKYN%2Bk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
