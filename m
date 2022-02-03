Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8589CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 19:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E554610E26D;
	Thu,  3 Feb 2022 19:11:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E15F10E26D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 19:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyqYm6ZUI+LqwPO2wzpxm56lVgGR+aUfRro/B+XarvgIPoR11ZkJDJQwbfrtb0LIE0i9c9Gx7ARO4VVEIe6OZ7MnUwuNjIVJJ/HAXYG1fQuY7A4QM/b9C5YTEVVy+ZAp50awkFOFTf2tDOaZIP9fwwwJeSCvNUIyl1xd14ouP6Whz70uqo8gZFuLKRtlDXVgSLJX8nyxAyQ0IaJJgoCLMqgiLyDfO68fsF1Sh88myM6GMMZiwncV7Iuvb6OlWEqHS6YEChikBWa9sK13O/FlF2iXK2D04c0hRRCWxz8IBk48C60am6vruesvxQ1eBCFjvLdA1OkM1FAngOwQaLpNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD5RtzYRkXdneivhi9Jfl7gb67Wf+8tOWMoXkdiAe4w=;
 b=XqifhUE2Ealtnp2xfCjuTfNYenDbhzFd0MKuj0vD3nn8GLKE1DSspSDQkgDHmgE6E9GzQIIuXVzswT6CXmtIT8g6sAKofGM7+vLLnEo3pKCo1En9edQrKoXLfuIa5Fb1GYFgVXwrMYYvRxq2xWFQE3w0Cx5gIsVgsZTSsXkeW6G3o2A+cAfHMARCxlQ99vD4DnByA190MIFrjAKfarCzM0eIV1DPOm+rpQRptcNIRQQGW676AzNm/zxkmal1m2e6sUeam0V4Ch5LcvL/dJ45s1m7x3I+mHksAqtC0nJ+Djw4Ed1PcWlPT2mHuD/ZKGQ3LSl8pCEhoJaiU9P2hsJoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD5RtzYRkXdneivhi9Jfl7gb67Wf+8tOWMoXkdiAe4w=;
 b=a54MELtcNmFU3pHSZf/Vj18pJpCqudtF/Jm2nOgPUlksyKXFU/j0x/HjwloUsiuvShOtsSLnKN2qT7PFOxF6qus7QMEdjzLCL2jXs60Lc8XNmei7fKa4GVoqCDCFuyI56iM2APjTz8oAnpYxa+1jNpx3QhEunPV3Td0zH90sNZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN6PR12MB1636.namprd12.prod.outlook.com (2603:10b6:405:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 19:11:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 19:11:10 +0000
Message-ID: <969a23a9-cba3-a39e-7688-9e6078ceff1c@amd.com>
Date: Thu, 3 Feb 2022 14:11:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: drop experimental flag on aldebaran
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220203190905.1476855-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220203190905.1476855-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8da196a9-bd52-48b7-eb3b-08d9e748efde
X-MS-TrafficTypeDiagnostic: BN6PR12MB1636:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16369FB48885E6DA5425DD7192289@BN6PR12MB1636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsYy+xmQFA5raOwEdLu9EbLEwpt1tM9Zmlq+HrIROlweuk2aHsBF3qMWa5zpN4pg3VldzBETXcW0ly4KyfRb0ryV6Ai3CMc2GaqAYBCT0PS6C93DgyCf3z4ZI5M23SH9RidShm+ubT3UNMSH9FtTTIJeL6ziy8fj51EtEsMrrBu7BMVAWOT4zMB+wvOFBR9Gayh2MCQPEki3zaWDDuBNSh68p8YyUyLajUE3V4DODireh6KGfBsw2qy+0LtRAslQCMHA5Jdj6EJfwRa/ewwhX/ONHgYYVimlUjNhLY4VFvxb+MISW+2AiFsABI2jOdf3GtXERaSsZxjOtnVtKx9boIYK8jiYlfI5d+9C10nsiP7fBW2W4dvS1e9DaUi0tuzXceAeGGoQEPDJWZJE8UiiCmjWkVc2C8iJWW/ZYQgWa1mLaa+D/i3qAfD2B1uw53XxTQty093nhcoBdSd/TjJT8DsFK2yPgWzKg7D7ouMnA9VKL4MiyXEeXwIOaSq+3/OAyl5SdlGijLxPrAvP402O0f6ITk0z8yz5W0KFntv/mWy4oN/KyFhjWcGKXjoPjVOOcdddGCWkI1BCXJpVullM4P5KA7rIBCH4D6CRv0AKSjpmo2SYy3jWR5feNVO0hDK0Rbr94mjkvJsyUQRgRTZSCCE5pKvCfoaWnMHpTjA9YTbibSDtZZ0mQ2Laofzi6DAvabXSmfhHaze3NiAzWqY5Acda5HIYwYe5YiKtOqi0bToapN/5hrsAwKhErLUPcKfx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(186003)(26005)(8936002)(2616005)(508600001)(316002)(86362001)(66476007)(66946007)(31696002)(66556008)(8676002)(6506007)(44832011)(6486002)(31686004)(2906002)(38100700002)(83380400001)(36756003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJUZE9odkw4Qjd0Rm5SU2lIN1R3eVBrQ1JIaWpzZWphekpyRE41RGJyZk1T?=
 =?utf-8?B?TklnVEpUVy9YYUQ0a2pSTStGMTlGRkl4Y3pubXZPd3Y0aVI4OGZSbDlpNnJw?=
 =?utf-8?B?UWd2cURxQ0FDZlZGb2pDcWExNU1KWTBKMHV0dVNldkc2OHBKeWlvQjVralg0?=
 =?utf-8?B?d2N3Q1NiajZrcm5mZTFsNStlQ1N6TWtPSlArM2lCZkMzR1ZVbGRlQVdPVjJu?=
 =?utf-8?B?STVGM1JhRUNQMG8rUG1Fdkl2VmJzTS93R21tYW1JTmN3YTJEcllKaHlpZmpC?=
 =?utf-8?B?SE8rQ2tRNVBPVEVCM25pZGd5aDY4RFhOclN6MWhzM2luV3YxTGpPdVZTZGNs?=
 =?utf-8?B?dkdxeURra0V0bnNvVElNUFpEUVFFSXQzSnNIeHVma0F6dWkxYjVoSUluckJS?=
 =?utf-8?B?aWRjd0NvYzhwa25EbUFpNGZUOWRFYmZlcDFqVFhFWldta2h0d2ltT0NYMXUy?=
 =?utf-8?B?VE5wb1B6QXBib1RKRXJtV1htZzh6YWY5dk1HVk9yeTcvYW5vVkRnWWoxMVl5?=
 =?utf-8?B?U0V6RnpaWjhyMCtKT093QmRscDBOT090ZUQwTlFUUEhHNk0vUHJFekIwbHBk?=
 =?utf-8?B?d1lIWjJsa0FxNmtLVG9EVXhOck9uQitQQW8vL3BuaFRNMzg2b1BweWcrSW1l?=
 =?utf-8?B?UDBlRmZqOUhDQi9Obmt5cmNJREVTRHpEclhsc3JXZVl0NUl4aWFmeVlGUVA1?=
 =?utf-8?B?MWl4T1JldnI5blU5YjNYbHRyODUyNVQ1amlkajBibGgwRnNRUmVpZXJrYUp5?=
 =?utf-8?B?Q1lqQ2hUZHpqUTMwcDlOTklKYWtLbGFPNDNLQlhCQUxTOFFQMWxqUFlkUnAz?=
 =?utf-8?B?N1VwUjA3eHRrRDB3cVR4TVl4OUZkMHpwUTdrQ3lzMG5PQWdjRHNWa2dsM1FJ?=
 =?utf-8?B?ZHI2MVFBeGhucFg1ckdwUjU4OE1vZ3VFT3MwL1U3RE52d0FXcUkyVWZDMmV3?=
 =?utf-8?B?Nk5qajUzcTB4SDYvRHBvaVc4dklkMTkweTJGeGY1MmsrVzQrem1RamdBaWh1?=
 =?utf-8?B?bHR5R3JHYmdsc0Y2Y3hmd3JnRWZvb1pJU3NJRTBtVlVFbW5UeE51SUtNekFZ?=
 =?utf-8?B?SFB3dEViaGxoU1ZoaVRIT2tqM0h6WndxekZCYnkvN05CSkVTR1VlUnBiRy9a?=
 =?utf-8?B?YjZqMTlJYUFDZk03cmN4bGlsd3drbVVEWG02R1dxckxwU01kTWVRWHk5TzNB?=
 =?utf-8?B?T0lVaUhqVXp0SnpxUUV6UXFMWEIvcC9PTjc2Tmx4NUdCdlB2ODkvZVUxWnJX?=
 =?utf-8?B?RDFIYzhyTGVSOVBHZlB0TjFUbDJPdXFVYkRxQmtnSjdVUnBCemJaUjZ4RjZM?=
 =?utf-8?B?cHhGVG5KT200VjZDaDU3L1RNSjBiODJwSWFVTlR0UVo3N0hnVjBQSW90aEEv?=
 =?utf-8?B?RGFBTzdMb3R5eHlicGEzcFRLRm1RQUN3Rk9pdU9JU2ExeGVXMWFHRDVkcGJZ?=
 =?utf-8?B?RDBKbmJYOS8ydUR4V2s0NFVPRDF1bEtGeHp6VnNzSklGSmI3VXJzLzcydXhM?=
 =?utf-8?B?NXUwS21LRVlucE1VeXZ2alVwRmMwcnl3OFZkaWViOXFOV2lPWG40N2NBN2ZF?=
 =?utf-8?B?eFAwa3hVTUp4a2RMNEdyZWppYXJDZUdnS0hKVDhmT0tOZHgwZloxbnBzeTdH?=
 =?utf-8?B?QmRkbjRoU1JHYXJ1TVhuWmdseXd1UzRpdVR6TGZKQjNyQmdIR0c1NEZYYity?=
 =?utf-8?B?TnZNclZQYS9Va0RYL2xCSG1LZzM5TlVQRDlFM0ZQN21CcG9zNTQrZnFLaXpq?=
 =?utf-8?B?U1lDMjQ0VFlkanhkK0xPODVaendSS1dkTXdCZWxUdGw5TEJNVjNmVmp3ZDg0?=
 =?utf-8?B?UFFnaWpTVDBZajNTQWsyaEdIcysrMzZZRjNhRk1Zc0Z5Vkc4KzB2WDdpUUxB?=
 =?utf-8?B?TENIdTlZdWlMWG1tcW5xNE5xYnBRUklxK1JUUjl1cjg4TEhCSW5FZ1JKTkRp?=
 =?utf-8?B?S29hV0NvYzYzc0JwV0JHMG85Y0xhcXFmaitIMGtWQ2hmT056YW5MMnNzQUNp?=
 =?utf-8?B?ck9WR1Fma3Uxb0NrZzJleTk2MytqeGppamplZmFtakFMTFZxRkg2MjdmNXNB?=
 =?utf-8?B?Lys4VWxRUC9GVFovWVc5SW0zQ3JmQ251U3VwNWx1bTVaeStlRDZKbHpwUmI5?=
 =?utf-8?B?VDNXakNsbzVSc2FMMUlWZmZZWmdCcXcwdnAwVUR4MVpsZmVNam42Vk5XeHFT?=
 =?utf-8?Q?NuP4FSK3kThRhYd2cSWoiFM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da196a9-bd52-48b7-eb3b-08d9e748efde
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 19:11:09.8754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KM4Laf8cz3J2VwmUokUvA5H4Gxu6Mj9IgDmn+Niv+Zkalb4E3wJJ1Z3ddZTgb+QoZDF7PC89acrCnTWu2yw6Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1636
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

Am 2022-02-03 um 14:09 schrieb Alex Deucher:
> These have been at production level for a while. Drop
> the flag.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 16a47894579d..d7fff876ad13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1916,10 +1916,10 @@ static const struct pci_device_id pciidlist[] = {
>   	{0x1002, 0x73FF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_DIMGREY_CAVEFISH},
>   
>   	/* Aldebaran */
> -	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> -	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> -	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> -	{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> +	{0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> +	{0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> +	{0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
> +	{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
>   
>   	/* CYAN_SKILLFISH */
>   	{0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
