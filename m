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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498D8610F8
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 498D8610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9156EA06;
	Fri, 10 Sep 2021 14:33:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFF96EA06
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 14:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC9qHbz5T4Ufzx7sNp9NpBB47tMqvKK+Fk+lSjvPaPa1jzsyrQ/hH6basuzM3hsI1r9KTpyA/LHm0RMeo1awW7C6UGpAz6Bc7XIz3r0so7y84e1+ohHIC+nmBYHHJSlBNqLvfvCMw7UrNiBV1CwgkEXY58NF491RYZCPP+9gOtk7dh6LsyJUJJxXfO/AayrXfHUeXjqsTela/HbT1STTcrfq0u3mHQY6kdBMFeObfQZvW2s9QbVNvTDROqt72auEh1fGUKuMg8vIaxE1Sy8A3s/1fgG4gXHd22hB6rGLBVR8pmrx1sVxv9r+qki8fXBiJzP2Wa0djf8Az5/gzOPK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=DImLQDCwHO3z3gwO1uQaZAJFTZdXSrEEWxg4PXjMEy0=;
 b=Asvyc+uItlydfB80U7tK88JdpPD+oSmfrDAonWIq+UE99u5PdH0Yp3lY/L4FPJb9eDk85677X4VdcnuwGSLw0b+SgAZFx4azMA8YswRVk4MevF9Df111iQ59OavCJbcxcRFC7CoWs3qVLNBqc+lNaU9IFaPzdfj33gzfCPZJ0llQwiRD4ThHVFFLDnYvRBJUJ8c9N+OdJbY+nu383PDUwu94kdpVs3eF7QqYPg82v6lue+dzm7JtXJhdspOhClsd/K9mqCH+YkMuUB8Ow4IrCcUKVyrSwFtFdeeRjtEaBc57smF1tdJvs9HnLndHPPwdcv8Op5fjcml67B9YW6rv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DImLQDCwHO3z3gwO1uQaZAJFTZdXSrEEWxg4PXjMEy0=;
 b=hNcxFIFfKtlNgUqjLoyK+L5PxIpFJagA4vJIx9IEY1wwXMZFDcQNwfjomBeEeKYRjbcqh+i3ZzNyQ3XliuTnYQKs5naORlAy37d6GN9JAgOcAQz8Vht/frqRICcGsjhZwBSo0h6Dg8D+kp7DXcgDY6uLu+/b8gxs+TKlrZZzquo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 14:33:14 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 14:33:14 +0000
Subject: Re: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
To: amd-gfx@lists.freedesktop.org, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
References: <20210910142607.3182-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f8033336-b049-0f9c-a247-1ffdb9c05df1@amd.com>
Date: Fri, 10 Sep 2021 10:33:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910142607.3182-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::6) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 14:33:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd47b90b-830b-450e-4b5a-08d97467ec4e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5068BCE50C1DACBD114AB30292D69@BN9PR12MB5068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MfYEmP3M8zz2NMvQ9ZlDi8jtb0S4NmeFGc8U3WXQvPQq8VGCYc+H2Jr/eb+C+56TNP0W5Mx7ZhrSkEXdgR1sDc2e1PyL4U73zEREDwOaFMsKfjnggdfzZnRPy8GTOeVXPbiIhqiOVkxmuUxU/hT/jzi+uUs373Ngjl75besNSaCC0TCNk262m2XZkxWCDxVIX3sfsdNzFqbbtEr5oROeigXRIL51UPeoG+U/dJ0KvADCAYVHVXl3xxE/sI91RkbklivkVAFG56gMXH7Lu8dGE30FfkJq673Asti+tXya+vckOnsbpxuQENqOOjxutOs7FoxvmEykdIpMoyIRm1gOPuH9PtCXIPYOvXUAjJKElPa495PdOePaXdGoXNhA+MrVn9qb2uy0BfRx/huLcvnvnRTacJYA6wgekOn5EudhZLBGrINGAx++/jVV37u0Fsmv4HYVZXAA2dE1EvrUpk5QAyXolELz6dppd1U6xTpl2iGRfbfBFOLsuXxQRddk+UBxjdS2HGG3nSOzHiZX3U3AeFPdS6ak9mPHxkUL5HMVho2KQcVZh+r2mBBfmxYbWaZeEE8mWLdkeD4633oTdiRLK5XhLnFVqOPM6hN/tt/ZJP8EFo06ZfZYL+l6XAbB27MjWJjwVuOwu2qkzObqQely9YTf02NGgdluvHf6d3JpJMGhuK4I0o743Q+ftgsHxFGLkkWA61QIbhmuAh5mKUCFUetIhRv3K1TtpKrp6ZTSqoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(6486002)(478600001)(316002)(2616005)(38100700002)(8676002)(36756003)(186003)(6636002)(16576012)(956004)(8936002)(6666004)(5660300002)(66556008)(66476007)(66946007)(26005)(83380400001)(6862004)(31686004)(44832011)(37006003)(86362001)(2906002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGpqNVRmQWxWSjE4WXhSS1hrYU9ObmJpUUt5VzJmYXM4c1JMc21IMUVRQkVw?=
 =?utf-8?B?VFVDNmJ4WDRPNTBORDFzd1VmWS9ZRDJVeXllTFVDL0hGbGZqN3dKV2kwWnoy?=
 =?utf-8?B?YVhLL2RNZlhsaGRsN0c4NGQvSXl5OVR5NFRCZXorY0R1N1lnaDRGcURoQkJD?=
 =?utf-8?B?RVpQZXlCbW13RnAvcDlSTmoxU3JZNnRYWG1XZ1czNlZENjBDRFJSekVpS3dk?=
 =?utf-8?B?OFVVMTJOa2R4c1hlaWM4NnJVUXRoRy9xY3dkbjdPeUtlNk5lYU5aKzlsZkRw?=
 =?utf-8?B?Z1VUZmRTcC9zcjBDTDFOMk9XRjhUWi83eE9wbnY0d1lZbk82ODBUWTZEVnJw?=
 =?utf-8?B?U0pqRnJjNVRGdWRjV09XeVM3ak83TUttNEs2NXR5OUJweTRWbTZnMThyWnlF?=
 =?utf-8?B?M0d1cUlRUVdISlczb3VpR2Fxd2k4SmhsMWRGVDgwWTNEVHRqSkI1SjJ1V25G?=
 =?utf-8?B?TTczd0R0d28yV25DcjZvcmVLaGRNS05mUUxWdi9NbkdjT0xSbnV6WUFUQzQv?=
 =?utf-8?B?WGpiY2EzWDVKSHRtVy9FbXJ3QTl4ZDVYajJMaEhPcGZIU0J1Ylg3MXptRXhH?=
 =?utf-8?B?NmwyTEJyOUhOcDNoYkxKaHFPNXAxaEN1anUvSzkzbjhPS1NiRUNvWW1NZVZJ?=
 =?utf-8?B?M24wRzNIZW9LbnhwNHRHNmx0dERwNFM0QjcwNGUyQ0NtUFdNWS9vR1dMVzF5?=
 =?utf-8?B?Mm45RGNGWjV0d3ZwVVFTTmtIVHUyRWNOQi9tSlBody8vUkJMNE40dmZHdEh4?=
 =?utf-8?B?ak1rUms2cUJCZkZUVVhXYnMzWm0wOURGb2R4dUpaVWtxdGptNDRoZTJIY0V0?=
 =?utf-8?B?emVINm9YZlZwTWZxSUhJSDJSMHRiZmFOMUppM3IvcVRlalZTek00TEcvNVlJ?=
 =?utf-8?B?em1YNVRqdEV0QTVpZlVlTTc3YUZ3L1VoQkZEODR2ckU2WE5VZHFRb3BGQVRp?=
 =?utf-8?B?bnQzKzI0dFdFdHNCaEl1R25UdXRINGJvcjJUUmpDR1dPMTVjNGZJcjlnaXpk?=
 =?utf-8?B?ZE1yb3lVTVhlanBTdlFmcEc4Q2Z6TmtheW1uOFRlUGRnN3M5VzlxNml5N3JY?=
 =?utf-8?B?ektVZHBQZXc5UVc3SnlYVjZqcm8zYjYyZ3R6endLeWphQ2xYS3NMVis4OFB0?=
 =?utf-8?B?dXRPM05EOElwVUMxZVp1aitFOS81eEx1ekhhZ3hNblAvR2dpdmluYVRRZXBj?=
 =?utf-8?B?UWRXZHo1WHdqdUdSSGVjVUZoNG40VWlRMnNrTUF5Kzc1ekZWUFd6RzFrcXBB?=
 =?utf-8?B?RDF1NGd4bFQyemh0QlFYb3Q3SlVpWXNGZmV4WjlpOHdxdGVIWS92a2c4Zmx3?=
 =?utf-8?B?YTlMMHhYZk9wWHpsS0VCd0ZVMjFmV0VqekxwZnhiTGd2Um4zTVlDUzgvb0ZH?=
 =?utf-8?B?cnEyZkxLNnhKYTlidmQrdEQxcUpzSWxpSmtyT0F5VzZ2R01QTVhzSm1seXR1?=
 =?utf-8?B?ZTRqYmtVcVFCOUNCTDBWRDhRTUhRT1EvREZPOFhiUElUUTYvZGhsaUxJMXha?=
 =?utf-8?B?T1NtUHgyK2c4OE5Td1U5OFp1VlBIZGZ6d3h0L1hxLzdVRWk4MkdDT2dmdnJB?=
 =?utf-8?B?UHVjTlpjUnpYK2FvZVhBdk9GVFRwMjErdlJ1UGtPMmpiMmdQRUtSbjFCVHRH?=
 =?utf-8?B?aXJHWFArSEtIamJnUjE1Mkc3U3huWW1lU05nNlFTcCtaMTBQVE15Mk14RGZS?=
 =?utf-8?B?K20xV2JDM29PR1l0NWlFcDRQTEs2dFBpZGlDT3VlZy9kaDN4QVdobFAwZWU2?=
 =?utf-8?Q?lyHkPOoSGgWbcUdmrRvn4c11TvWOC960PC2ekkW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd47b90b-830b-450e-4b5a-08d97467ec4e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 14:33:14.5609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2jslnwHyBrrkPGnvfmz17EH6m4QUzfhHIy73dcXSyFvDq6+hw/a6mx20l1ui0NG73WQMZU7sM/WldfxpQHJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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

Am 2021-09-10 um 10:26 a.m. schrieb shaoyunl:
> The AtomicOp Requester Enable bit is reserved in VFs and the PF value applies to all
> associated VFs. so guest driver can not directly enable the atomicOps for VF, it
> depends on PF to enable it. In current design, amdgpu driver  will get the enabled
> atomicOps bits through private pf2vf data
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: Ifdbcb4396d64e3f3cbf6bcbf7ab9c7b2cb061052

You can disable the generation of ChangeIds for a repository with

    git config gerrit.createChangeId false

Other than that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 24 +++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
>  2 files changed, 16 insertions(+), 12 deletions(-)
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> old mode 100644
> new mode 100755
> index 653bd8fdaa33..3ae1721ca859
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3529,17 +3529,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
>  	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
>  
> -	/* enable PCIE atomic ops */
> -	r = pci_enable_atomic_ops_to_root(adev->pdev,
> -					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> -					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> -	if (r) {
> -		adev->have_atomics_support = false;
> -		DRM_INFO("PCIE atomic ops is not supported\n");
> -	} else {
> -		adev->have_atomics_support = true;
> -	}
> -
>  	amdgpu_device_get_pcie_info(adev);
>  
>  	if (amdgpu_mcbp)
> @@ -3562,6 +3551,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	if (r)
>  		return r;
>  
> +	/* enable PCIE atomic ops */
> +	if (amdgpu_sriov_vf(adev))
> +		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
> +			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
> +			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> +	else
> +		adev->have_atomics_support =
> +			!pci_enable_atomic_ops_to_root(adev->pdev,
> +					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> +	if (!adev->have_atomics_support)
> +		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
> +
>  	/* doorbell bar mapping and doorbell index init*/
>  	amdgpu_device_doorbell_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> old mode 100644
> new mode 100755
> index a434c71fde8e..995899191288
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -204,8 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
>  	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>  	/* UUID info */
>  	struct amd_sriov_msg_uuid_info uuid_info;
> +	/* pcie atomic Ops info */
> +	uint32_t pcie_atomic_ops_enabled_flags;
>  	/* reserved */
> -	uint32_t reserved[256 - 47];
> +	uint32_t reserved[256 - 48];
>  };
>  
>  struct amd_sriov_msg_vf2pf_info_header {
