Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EDC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 05:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7546113A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 05:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E7546113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E0D66E95D;
	Fri, 10 Sep 2021 05:10:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789396E95D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 05:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIW0Ob7O3468PXzSCsb2nJS5ciy2oUOZbBJnhOP0FChRbopO2HRSKzpADBNwpbSt7iT9UspFTcDEQivWO6Y00E2kA906w+L6JlUS6+usfqH/ciEPd0RrzbYNdZFXYSzrLDhmIk+o874Zh8LpuiHnLCC1otnfC130km+vEjDwFIoBJvuYX/cgMqH+mKAwCktbNvf8Z4ybCA046xRLxnigqsScr3bx0fPmJe4boauNjSGLM+kTnYljhieohNBzG8sKZyW32ICBFrxjtXJx7F3ieDqMqqHiKUNCKHNgr9KgsRHE5m98WXevqzRgWXZpbaA98O5lWZ0yiLNePPlGe6QDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3QkD7jTppYXrg8JvTgc4xZi0YK0Z5MuCvI+zx3j4LBA=;
 b=ZpThAySqp0ueZJCdBY6gOp/AXx77bsgtEgDIs7CXM+AG3/Dt9zdp7olk0oNuvUJiINY+Q8fQLek7KsMvW86RlSzjC+z42Z4FdQTmdyawJ+v3G5oeC0zwPtcA0rJQmeNqsHi83Hiwadts3DgZTObW+o1l7UdENJya1Db7JzURwNiuC6NKgSKnl7EU2FhwWqB1ueQ8vAQRErGD5xtmvB+45UUJY5eBbw0rVeZ6g5BCdaI8fjN1VVfIm/Y8PAstaf7Ivg1+whjY7+XmLu+0gZVoCiXuVyynsmd+O1YkCpnQH9IKd/5/StoAGkz9ZDFgkizpZXVJ+iFfgKo+C/6bG1FSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QkD7jTppYXrg8JvTgc4xZi0YK0Z5MuCvI+zx3j4LBA=;
 b=QUtIxTshv8jC1ROTshh2BqwdUsy1YTra/VFzQZoGh3bH9hNR0hmSUjXMz2drhGSiKajnL/EwNJTsxseDTQJOPG6D2a49dTzLt00j7BbdWrWh/ptIOZE0/L8HQcP0XMbpz8nG4KRPNQCZEmrzhapsaI5VXu5OscVoSGcWJrpU6eA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Fri, 10 Sep
 2021 05:10:01 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 05:10:01 +0000
Subject: Re: [PATCH v3 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20210908224822.1500405-1-Felix.Kuehling@amd.com>
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Message-ID: <841d1a5a-8b5a-d8b7-5937-9e35be71548a@amd.com>
Date: Fri, 10 Sep 2021 01:09:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908224822.1500405-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::28) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 05:10:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d340840-a21f-42cf-8873-08d974193def
X-MS-TrafficTypeDiagnostic: BN9PR12MB5384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5384BA4070976658DD4F81A692D69@BN9PR12MB5384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEzQ7bgzahUm/xwsmodur6XcnXrMy1lOlnYgy/DlyYslyDoRPNISI8OCjzbW/5LRAMvT3+IFFENx0SaabC9WMpEym5g7635PyaCzzrdUh6ErjnVYCtGKvwTl97+4MXkeIuI0iGX0ZZhSOeVWpsjeTqpDmLzAuOTiHPDz+s+hYv9hgnmpeITMILhPPSvv6ZVRAJjKXKC0uYhvsRrw0dxi95lFNwcU15X9kNdy4f0UGPZGwT7ySLA1bDSP0j/N0SHh7VDHWxHh/3mF4FezYAEGzpUzOcJ7zx3ZeX28zWYtuSOGEzbdSqdhcRI2P9MR9v8VshHFUXsQyTp3T7/5OrL+20DkhtRyyuQlDkzT1RfQbjLDQ57xzB3J0v4cGXh/Kz/oli6KLQ9JO2ra63vt9wiIIQeCku76yUALzQRZBW8X3gH80OU0BRRNYp1xvqdPXPv+qXJgrSCIMk4YNpYuPaszXX5SWEDSqHI0AT7Pez/2JXataO9xVxoz8vhYKi019onngjvqVIjFqX4Nxf2V9j4Y0quKQUDxLQRem1/1rUMj2SgBrx44NqiKciqMFXGTOJm+PhPdL5vHEd2Gjo5lTsku+A0GPl9PeJtxZxfkumoJapIdz9eOUWZhERjT/aZw3597+j0U7QZl9GWbkhIz2DhTfGYvSTZ8Aon16An+LEPg33U7I9e7QohPMlkzoSnNRpihSef/x+nHbsLESXkHCcFwFMR27kJHSNOsyHSGBU/KIaQ7wfOzxHKcoffFDEeT9x9w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(8936002)(8676002)(6916009)(2906002)(38100700002)(31686004)(316002)(26005)(16576012)(186003)(66476007)(6486002)(83380400001)(478600001)(2616005)(36756003)(5660300002)(66556008)(956004)(86362001)(66946007)(4326008)(31696002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFkeHcwTXMrTkZlOGwydysxaHpiNk5qc24yNTJNeXRKWWVCR1Mza2RodFFk?=
 =?utf-8?B?azRFOHFJWWEyT0VPc2ZNVmtKamprQTNNRXVYaEZOSVArVGRMbW9acjNmVHk3?=
 =?utf-8?B?STBWSVJ4VUIwK0RaNlk0SDRFZk03MkE2NHpyaURwcjRhYy8yWE9reGExMmNX?=
 =?utf-8?B?ak1CMUh6NWdjbXdrUkVGSE16ajVSYUFaZWpFaDYzRnNrVnd5N0VYNjJuenVE?=
 =?utf-8?B?ajZWaDBETHJzZVFCUVc2Q1dDeThuKzNXQm45SGJHdEwzam1HL2cvd3kveHRI?=
 =?utf-8?B?cklBV0ZIZW40d0ZxSnovcnEySWd5QlM2ZDZPVE1xdzhiVHpGdFVvTFUzd0tp?=
 =?utf-8?B?VGl3aFBVYzBQY09EUmVrOHBxZVJPQisrSmdGak0yQzF1YVFaMXVxajU5WGlI?=
 =?utf-8?B?cjh3a0JENEtwaEgydzU0dGVsTm8rRkg3L0tWc0RMR2hBd252N1NWa1kwckt4?=
 =?utf-8?B?SnBxQ3FSQ3ZIelZFOVRZbHRqRWdRTkljNG13TDBpWjlTbTRPMWN0d1VrMzZX?=
 =?utf-8?B?TWNta3dyUzlTRUFONER2NHVnMjJHeGtRY3JkUWZuay9wTnlhTG5TelV4QU81?=
 =?utf-8?B?UGpkRVkxbUp4T3BSV01EQ09GVVpBOXo2NCtUbTJOdHcweHppODVac3Q1UVM5?=
 =?utf-8?B?OTFoMlo2R2Z6RklZUG44Mjk5SGtGNjYrZGtQbGhoTksybnFxVUZVUFBVMG9Y?=
 =?utf-8?B?RUJwOHNKQy81czQvTXpiTm43VDNibGFYRlVjc1RyQVU3WEdpRFlzZmRaNXF0?=
 =?utf-8?B?MzFyVkoxM2t1ZU0wMnpjb0Y4Y1hmeUZwRCtFREVoSTRreVpRaURXZEZOUzB3?=
 =?utf-8?B?T0ljMGs4OHBYREc4eEVia1FtcjNIVXU4ZDVTV2hNczdNd0h6Q2E4T0xwOU1y?=
 =?utf-8?B?bkpkdFhabmZyUndsUWlVR2RCaG5USFJNaGJDazJaTm8zZ3Q1Rm1peitOeU1M?=
 =?utf-8?B?Vi9wa0thNHpWTEVJOHg3TVh3UWQ0RTVRUk1wTUdzbTZrUWsxa1hzMGg5K1Ur?=
 =?utf-8?B?TTBYQk83dkhGNjkzR2dybmFBWC9UblFPYkZHRFdlbVBIa0NJcmtBcW9FQkVj?=
 =?utf-8?B?YkozV3pFMjR6ODRiZncrWksyOVBrcFZUMjVLbTM3MWlmREwwYUVuV05tbEc0?=
 =?utf-8?B?eGdlNjRnaG90SFphZVNhbEE0L3lGK0ljbk82TWYvQUhJcjQ4V2J4T3NSbjhV?=
 =?utf-8?B?a0Z6VTU2WmJnOHlUSkRycUJ4VVhJZkNmbWtrMG1BamN2NndhT0VTTkc0S3F5?=
 =?utf-8?B?TjlzN3N4S3IxZ2xzMU8rY0xkaEdEcUlEYXFwSFVjUDlrUlVFYU5qdEJ4cXZD?=
 =?utf-8?B?TUVsOFZ4aTFMM2MrNkxTbUk0UDZ0Uy90eFQxaGZ2OW5XVUlNYkFiYjRYa3kv?=
 =?utf-8?B?K0pBNVZBQ252Zk93N2ZneE9tZGpQc2k2dGtNa2c3dzNJeXVxRDlwaXhRR2I4?=
 =?utf-8?B?NGp2UUgyTVZETlNsc3dDOEo5ZVh5U1AzWFk4a3VwOHAvMyt1c05UeXlBdnY0?=
 =?utf-8?B?cUEyc0tucldibVd4T1prWVpnMUlPUEtqQlNWVTJrZTMzNC9MY29oZ3Y5T1JL?=
 =?utf-8?B?elNNZFVlYk9OS0xremtYY2g4emcvSUFGNjVjRVNmbUpzYkE5V1Q2VGoxMEFW?=
 =?utf-8?B?U3hEMmxOK0dkNDhPRG5ZbTVYWlgra0JGcFcwZkNacUU4MHlVb0NnMHNuc0JC?=
 =?utf-8?B?OUtrTGtOVGxRUVRwV2hwQ3dCMll1dUdoTW0xWGRjMGk3OGRabzJQaXJnK29J?=
 =?utf-8?Q?CWMBJPGSI2vWBh8CFq4eimIcmT3A8O/6W9R57iJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d340840-a21f-42cf-8873-08d974193def
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 05:10:01.3829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZM0dfcO+ObuwB0iGiitZzL0RO1XSb7l8VRbyRlbyuQUkiU53nBgpl63I5kPHgfHr/QDC92YZFRt/ITtlWbvi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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

Am 2021-09-08 um 6:48 p.m. schrieb Felix Kuehling:
> On some GPUs the PCIe atomic requirement for KFD depends on the MEC
> firmware version. Add a firmware version check for this. The minimum
> firmware version that works without atomics can be updated in the
> device_info structure for each GPU type.
>
> Move PCIe atomic detection from kgf2kfd_probe into kgf2kfd_device_init
> because the MEC firmware is not loaded yet at the probe stage.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
I tested this change on a Sienna Cichlid on a system without PCIe
atomics, both with the old and the new firmware. This version of the
change should be good to go if I can get an R-b.

Thanks,
  Felix


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 44 ++++++++++++++++---------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  1 +
>  2 files changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 16a57b70cc1a..30fde852af19 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -468,6 +468,7 @@ static const struct kfd_device_info navi10_device_info = {
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
>  	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 145,
>  	.num_sdma_engines = 2,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 8,
> @@ -487,6 +488,7 @@ static const struct kfd_device_info navi12_device_info = {
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
>  	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 145,
>  	.num_sdma_engines = 2,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 8,
> @@ -506,6 +508,7 @@ static const struct kfd_device_info navi14_device_info = {
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
>  	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 145,
>  	.num_sdma_engines = 2,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 8,
> @@ -525,6 +528,7 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
>  	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 92,
>  	.num_sdma_engines = 4,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 8,
> @@ -544,6 +548,7 @@ static const struct kfd_device_info navy_flounder_device_info = {
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
>  	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 92,
>  	.num_sdma_engines = 2,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 8,
> @@ -562,7 +567,8 @@ static const struct kfd_device_info vangogh_device_info = {
>  	.mqd_size_aligned = MQD_SIZE_ALIGNED,
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
> -	.needs_pci_atomics = false,
> +	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 92,
>  	.num_sdma_engines = 1,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 2,
> @@ -582,6 +588,7 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
>  	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 92,
>  	.num_sdma_engines = 2,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 8,
> @@ -601,6 +608,7 @@ static const struct kfd_device_info beige_goby_device_info = {
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
>  	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 92,
>  	.num_sdma_engines = 1,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 8,
> @@ -619,7 +627,8 @@ static const struct kfd_device_info yellow_carp_device_info = {
>  	.mqd_size_aligned = MQD_SIZE_ALIGNED,
>  	.needs_iommu_device = false,
>  	.supports_cwsr = true,
> -	.needs_pci_atomics = false,
> +	.needs_pci_atomics = true,
> +	.no_atomic_fw_version = 92,
>  	.num_sdma_engines = 1,
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 2,
> @@ -708,20 +717,6 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>  	if (!kfd)
>  		return NULL;
>  
> -	/* Allow BIF to recode atomics to PCIe 3.0 AtomicOps.
> -	 * 32 and 64-bit requests are possible and must be
> -	 * supported.
> -	 */
> -	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kgd);
> -	if (device_info->needs_pci_atomics &&
> -	    !kfd->pci_atomic_requested) {
> -		dev_info(kfd_device,
> -			 "skipped device %x:%x, PCI rejects atomics\n",
> -			 pdev->vendor, pdev->device);
> -		kfree(kfd);
> -		return NULL;
> -	}
> -
>  	kfd->kgd = kgd;
>  	kfd->device_info = device_info;
>  	kfd->pdev = pdev;
> @@ -821,6 +816,23 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  	kfd->vm_info.vmid_num_kfd = kfd->vm_info.last_vmid_kfd
>  			- kfd->vm_info.first_vmid_kfd + 1;
>  
> +	/* Allow BIF to recode atomics to PCIe 3.0 AtomicOps.
> +	 * 32 and 64-bit requests are possible and must be
> +	 * supported.
> +	 */
> +	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kfd->kgd);
> +	if (!kfd->pci_atomic_requested &&
> +	    kfd->device_info->needs_pci_atomics &&
> +	    (!kfd->device_info->no_atomic_fw_version ||
> +	     kfd->mec_fw_version < kfd->device_info->no_atomic_fw_version)) {
> +		dev_info(kfd_device,
> +			 "skipped device %x:%x, PCI rejects atomics %d<%d\n",
> +			 kfd->pdev->vendor, kfd->pdev->device,
> +			 kfd->mec_fw_version,
> +			 kfd->device_info->no_atomic_fw_version);
> +		return false;
> +	}
> +
>  	/* Verify module parameters regarding mapped process number*/
>  	if ((hws_max_conc_proc < 0)
>  			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ab83b0de6b22..6d8f9bb2d905 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -207,6 +207,7 @@ struct kfd_device_info {
>  	bool supports_cwsr;
>  	bool needs_iommu_device;
>  	bool needs_pci_atomics;
> +	uint32_t no_atomic_fw_version;
>  	unsigned int num_sdma_engines;
>  	unsigned int num_xgmi_sdma_engines;
>  	unsigned int num_sdma_queues_per_engine;
