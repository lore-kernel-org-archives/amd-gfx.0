Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D17DC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E637B206D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WLoNGJjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E637B206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04BD6E8E3;
	Thu, 30 Jan 2020 19:06:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431516E8E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 19:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQaaMqsLgEItKR75ZleTn5AgUybcM/iL2VTh38vbqB5olgDqPEhm1Po5sXni5HD1INw1H8rI/ImpVvO+son24fsJLRtStmoau0QdISbm2jvxTW8mSFxMhqTtfuA8cFw/4z9EtXwGHw6fVhwpnImDf2g5+qvCMiV6yx4sgrj4eM4Pi1LlLhggf1PUBJcewc1VmvYVZldktvPfKhnp7RqP67Tzt5j4b9cFnpJtW42j1ch/G+oIe42Fwd44S6pOj0HQo12XvgrXZSVmQrXjdo4eBcnXfIWLNnl+YS8ascZAtSUEdQX149AUPukJHAELrog0CeKc1W/gNFg/7YDIi0arUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpE5ASMO8iCIL/dmBUMhdihrej/1UwGrw0r1KDVb2RY=;
 b=TRbmTDmnTgynab08ATaI2mgva1Whk2ona4ys0hIUZQhmgNd2BQK5hUWbGdPdACyoTPc8zcOrM/k2WqCHHPi2a7mff3V/pcP4E5FbOKxsdXU5H5uPnQNQGW1zoEODZ7yiI/Wz1IgZyojPfKV7Cliykhyvqv15rIjgqh6bzppEoa3rB1APgEtdkGR+JAkhpzvkanZm3vxRjyTzQAqfQrgg7vTvDek2nF3XNN4IIY4iPyWoAfF+wI17FkFEXfpeZVWDAGEqDw+QTwGQGFQPXdiyYTS1Ecl9pXWzsToNTyubVQVZNuHFOzpxaXZS/ZDanFu5Gkwg5pBvs4z7CkK8WLj9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpE5ASMO8iCIL/dmBUMhdihrej/1UwGrw0r1KDVb2RY=;
 b=WLoNGJjc8kXmW735IgwSgMqrpJoRFKyIETdVtNNdcY3V2+rMPw/FheFEf6nNceyhevlBxWS1oWA3/Ns2aQwcEH8l2b30FuhmOYqEt8poYqaRxpjN9j4RV08pB7M2co6k3OpnXvx3v8rLCRqEqQ9lgzy9mVhApP8/XM21nK0qUR0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2575.namprd12.prod.outlook.com (52.132.194.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 30 Jan 2020 19:06:14 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 19:06:14 +0000
Subject: Re: [Patch v1 1/5] drm/amdgpu: always enable runtime power management
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-2-rajneesh.bhardwaj@amd.com>
 <CADnq5_N6vKSpLGBj2TkiCOaOskrT2T4EQ3NmNp0hOLumCLithw@mail.gmail.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <e8717038-7452-1ef1-5eb5-394533c7ef37@amd.com>
Date: Thu, 30 Jan 2020 14:06:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <CADnq5_N6vKSpLGBj2TkiCOaOskrT2T4EQ3NmNp0hOLumCLithw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from [172.27.232.179] (165.204.55.251) by
 YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.28 via Frontend
 Transport; Thu, 30 Jan 2020 19:06:13 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33437403-209f-4ca1-694a-08d7a5b779f8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25755683C67A683E9D42E96DFE040@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(86362001)(31696002)(2616005)(956004)(5660300002)(4326008)(26005)(53546011)(6916009)(66556008)(81166006)(66946007)(31686004)(52116002)(66476007)(81156014)(8936002)(8676002)(16526019)(6486002)(36756003)(16576012)(186003)(54906003)(498600001)(45080400002)(966005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXDXG05gkM4w8QkkofBchDqKcdNpLXwsUwy66eB5ZGlg5jrv9KFsbIxzTJg7QrEHr/aDDUBtuvEZctUsqzb1DJKQ9JgjwhDoZPe3qDW8gImC/YCA4o/ZvqiNKo77OD25jBLx4o1MRqVW5EY7C3D8uqA1ntxzM3BXB4Q9PM85UI3N1z2Tm3MCxpNi9Atn705UIZ7qXePVhyZgtABvF43ONnjSrty6+xBdiqFjQxEpLI/yAkptjwcg0jvQiHxjCgLU0wr7Dy93TWIzCEt+VpH0oOVEU5JMHriQT/3IVANTCLagAxSZbYty3U4rsCPDt7Y4ms0HABIwMkYebzexjTJwnbAUWogbOpDVGjTJAU2i2beb/fUHNPYkGm3AddeoxkUWM2zzFi23SNdKutkEo3LbdW10MZ9afjgffXXwlMwUbRngMYZHBg14T6wXkSfgZufodUTBo10ecbGUEXXpxk15gz3Z2Xs+XUdFibZ1rc97x0RNMbwaS2Lxy+eopjLdgIsm
X-MS-Exchange-AntiSpam-MessageData: W9/u5LjyXhBVCxPaPe/m3tYLQJIiO38+bzBK6iM4vDHBXV69sqbYE/AHToAkA9qzJlsVooGjo/eUIZTP7nYaT4pCITo7CpU0/yztsQJuO9+laToimqr+L1y36nS8OCu+c+MhqZKPT5Q6MC90NSqlYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33437403-209f-4ca1-694a-08d7a5b779f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 19:06:14.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzxGmw5HV4U+O1+0g9/gmvrh7EtFVSh0NRuZCDS8s34Dz9v+es274JcXxnQ9LZwJ2MY6cnvuDd6DEDjvgzRcwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/28/2020 3:14 PM, Alex Deucher wrote:
> [CAUTION: External Email]
>
> On Mon, Jan 27, 2020 at 8:30 PM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@amd.com> wrote:
>> This allows runtime power management to kick in on amdgpu driver when
>> the underlying hardware supports either BOCO or BACO. This can still be
>> avoided if boot arg amdgpu.runpm = 0 is supplied.
>>
>>          BOCO: Bus Off, Chip Off
>>          BACO: Bus Alive, Chip Off
>>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> This patch should be the last one in the series, otherwise we'll
> enable runpm on BACO capable devices before the KFD code is in place.
> Also, it's only supported on VI and newer asics, so we should use this
> patch instead:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.freedesktop.org%2Fpatch%2F335402%2F&amp;data=02%7C01%7Crajneesh.bhardwaj%40amd.com%7C01f67fc720d3423ee6b908d7a42eb68d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637158392852429503&amp;sdata=aU07GE56Vfb0JTSDsVDdyCdhxUkjHEVMAHiBaBC4V7g%3D&amp;reserved=0
>
> Alex

Thanks, Will fix in v2.


>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 3a0ea9096498..7958d508486e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -169,11 +169,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>>                  goto out;
>>          }
>>
>> -       if (amdgpu_device_supports_boco(dev) &&
>> -           (amdgpu_runtime_pm != 0)) /* enable runpm by default */
>> -               adev->runpm = true;
>> -       else if (amdgpu_device_supports_baco(dev) &&
>> -                (amdgpu_runtime_pm > 0)) /* enable runpm if runpm=1 */
>> +       /* always enable runtime power management except when amdgpu.runpm=0 */
>> +       if ((amdgpu_device_supports_boco(dev) ||
>> +                       amdgpu_device_supports_baco(dev))
>> +                       && (amdgpu_runtime_pm != 0))
>>                  adev->runpm = true;
>>
>>          /* Call ACPI methods: require modeset init
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Crajneesh.bhardwaj%40amd.com%7C01f67fc720d3423ee6b908d7a42eb68d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637158392852429503&amp;sdata=%2BXwHkoDeyA9Q%2FwnSyaND6QOc1SxpGuAHkZ4JdaTM3wU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
