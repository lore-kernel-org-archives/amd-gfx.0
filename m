Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A46C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 11:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A7964EC8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 11:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A7964EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50BF289147;
	Mon,  1 Mar 2021 11:52:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A4C89147
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 11:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY3uvN9D6G2jKfORxnnll1rmczjlXsp70fQ7+oJ486WPeHb+S0yA7/Em5wHT7e7XF5mx1iFzfkg3Yb9xoClW8xxrg9Wz43KNCIr2qbwUg8nl5Q3Ll+6EFZxPMteUr+I83mavCGx9oLl6+wAHItqkKyMyZkq18WcciNubcaudl1yaiK0b35zFXJXTe2G1eJl9jfhRNJZDuG69mMNF/M2zIFVVEMJU+gDiBaFU0anLeBtmeHYMMI5+cgXWvYF+Kj4c3663yK9guNFb7ScKLG3qMZp4bGxHcc6aTi2fErYhVRW2TQOqULw/aY+LDwIutncrlCEQsq3I3en+MiduQiYZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQLeU8WoF5XB9Fm22fKsl2QIahS37NTAcfqpLB3qA9Y=;
 b=Sv3u9ZMMYLulL2DZK6qitGHtN6DVhaRs5+xHFkyrTzenUaHBxYSD1GWb/uFcrcBnGczC5Q6ZqD+qLa+zPqd/hfPx5kyqTPSDzj1v7GWWyFsexD6Oa7ePuOLfJAzO5X4r7zoBP+yCi2N4M76tyx3txjFNvuhZPXqjQgSNuWESEF2N3F7WrqmaQUexwU/GoCalnk4Rh3t3Y812oFspDmtQ9thZFbHN73Vvi/f8rpU9aRrm+MDRv81aYuzUpEI3f++vqEyCOM85eSsS9G2B7gfeCDAauB2IyC9fO6aJNe6J2cdVU58J8Yf0etIdQfvgpVLtbmip00vz9jJ0OFeRfETL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQLeU8WoF5XB9Fm22fKsl2QIahS37NTAcfqpLB3qA9Y=;
 b=exVF4Sy0QFLCqhbgpwklPnFybrc3fNXA53UVuIL+s2mpTnay1D7cNYnBNiqXmxpqMToSIA0z2xqw1BU+bMnS4mnb8+Ubj9AfgnPmZO3EEztVC9Bs/wpmY0t45xmDp/eLaGmKWRtuxxqrPSaIm1K3ZDeo/xoBEV4NhTmt7bfjxns=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 11:52:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 11:52:44 +0000
Subject: Re: [PATCH] drm/amdgpu: block hardware accessed by other threads when
 doing gpu recovery
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
References: <20210301111225.11330-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2b7c3869-e750-edeb-9b0d-0a4fbd029211@amd.com>
Date: Mon, 1 Mar 2021 12:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210301111225.11330-1-Dennis.Li@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:a93a:2306:54f2:28c4]
X-ClientProxiedBy: AM0PR02CA0165.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:a93a:2306:54f2:28c4]
 (2a02:908:1252:fb60:a93a:2306:54f2:28c4) by
 AM0PR02CA0165.eurprd02.prod.outlook.com (2603:10a6:20b:28d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Mon, 1 Mar 2021 11:52:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c6ce45d-395d-48a9-8153-08d8dca886ab
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4342025745344C4E9FD8DCDE839A9@MN2PR12MB4342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hZUXdL+Z4y4jk2H7YPGMZfWVwylj2+g1cYm9FmG6q2TQAyFHVTADnyh5zvpU6M6ldBpJ07JV0tbpEzto8T/676loPffDYTFavpHfc3i8gJajraGYndH+MYSMcPPLO8GfyCZ2gR7CAtSeqxwPlFljmrJ0foUKizsyWbtNAHWnhxKdsyGs7nc3+UNsZly6QuSIC6yf8IHtwKaiXT4b8FmHEkjavvRfOqS4kIVDpbxgSSYPkBioJSD/0iDTPu4MBD9U0kzfaJljTk8bqdOEXSreJ8wvZVzrKv2SvTlTm4A+fVbI+QyFGTay5ajtUVqWJXXgIZCuIcYHtX6oMJ3DZGeB9sajb9kklJpvnpm8+gRbBsj+cO29cu2xwj6AsdevAFWTDKMVF/SizG3xTOejUZ2DWS4weavHCK8lBU5PSREsTu3zFL5y7U9pyDP5zuPdz1DDFl91ocxLY4X7ILdB7YPyvFCEk/JOHGugos7vbpFnrSOa0JtxU5Pel4lAFaTLIPez5hCnv86VH1f3PvrbmpMBKLBxAGsaLG5YsXg3jWQu23T1yLhOm0ipuVUodPWHY65Lbi0mWCPYBHFizC4Tm0ySmh5X4N/VdmMjqfmG0jVV9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(478600001)(8676002)(6666004)(8936002)(16526019)(52116002)(186003)(66556008)(6486002)(31686004)(110136005)(2616005)(66946007)(36756003)(2906002)(5660300002)(66476007)(31696002)(316002)(83380400001)(86362001)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFQxV0RvWU5BeTlnRTBDbGpVakQwa2NLTUZBb3NiakJkUzB2aXZxSWJzTWhm?=
 =?utf-8?B?RytidHZ5eUlkQVlEMCt3QlkrR1hhMVlrVWFodldKViszTnRyZExHN1hmcXNk?=
 =?utf-8?B?YU0rOVNJcjZzTUxHS0piY1VaUWRqWG1QT1dnUWJ0T2puQ21WZTBNdlUxUWJJ?=
 =?utf-8?B?SWxTb3Z5WHpBQ1NsTlBlUlFoMHh4NkVYSmZqWUtWZEdKRzA4QmR2L1lScm53?=
 =?utf-8?B?S1d1bVo1bTJodEhSMHBsSitpaUh2K1ZleW1XWXdyRkdsK3FZRFk1aVZNR1Jp?=
 =?utf-8?B?TE83am1DZWRDSnVCVE4xRmlvWGR0QnJWaEFiSHYrcEM2VHVuQXo4akN0WlFP?=
 =?utf-8?B?MFpENnQyeXZVc2xoQ1NUTzJzZ2Z4Zms4RHBoWkhHMjQwL2RtL0xmQ2JmeXFD?=
 =?utf-8?B?RDNmdnUwL0tPM1JiV3V4MituTk5EUEU5VEYrU0N1cFNwY0RrMGNQQ0M0M1F2?=
 =?utf-8?B?TERWZ09xeVpkUGNvS0oyMGFESUZhMWxSckpZcEtydVZlajQ5Qks2L3N2enlQ?=
 =?utf-8?B?VkFzcUFMZE9RaEs5L05sTmVjcmxTMmJrSUgzdjJCR21udWtTRis1OUN2cHA2?=
 =?utf-8?B?MEtCUVNuR3VhUG5XSjlFdll0Q3VWUC9JcUoxNmxkUTF2ZkkxMkwrbC80bjZE?=
 =?utf-8?B?SEcwK2NJcktFL2J3M0RqWFc3MzR4aytZWTJVRVFjK0syNy9raTVCdDhHRnBB?=
 =?utf-8?B?a2pmOTFiNFY0Y0liMUdXaUg4UGFRREdrV084VEIzMVVEb09ZcUsxcEgyQkhr?=
 =?utf-8?B?OHg2SXRwY1N1a3dTQ0psRDdLZFAwZ0tZZjZSb0xFSExhcDN6SVZNVTQrSnZz?=
 =?utf-8?B?NjRCNDRRMFdOWEZ5VWVsWFFCWVJlOUJVaVh0SWFDSjBFeERGNGMzZ2NTQjFu?=
 =?utf-8?B?N0hCbkkxUDRHeENuZmpvVy9kaHAyb0Z5NzNDNHU0NEZIVEFac1JpaU8xSngy?=
 =?utf-8?B?TWtPeCtDVFlzQmphZ3ZNajhwVGlzc1NXbWwzbkx0SUhuNGRTVi9DM1pxdkpt?=
 =?utf-8?B?aHp1cUdPamphT1BrbXhQNmhFUGMweTFwYzRoSWVrR2VaNU1ZQk9pN3htcjAx?=
 =?utf-8?B?MHM5RkR4SnBPd1BBMXZsL2wrS2d1b01zditid281aHVsTHdrM0dFRUduTDJj?=
 =?utf-8?B?YlZtTVdsM2t2QSt3c1VsU0xQSnFDeXQwSjhsWjlqOWNvZHZlenVicVNKQlll?=
 =?utf-8?B?TTFvVVVZYnVpTzdldGt6VzZqZ1poQW5LYVNPdXJsdTAxQmlHM3piQi9RT01U?=
 =?utf-8?B?Zlc1YUdMV2xxUTc5aE5KVXNHaEZ6MzJUampJUFZUd1ZzKzliMHJOYm9FQnJv?=
 =?utf-8?B?VDJwbTNIZm4yRTQ5TmhOYnh5ZklkTVR3SlYyUmJxU3o1dktTQnhWUUI1enE1?=
 =?utf-8?B?N01FTDd0T3hKQ0pyUThqQTAzR1YxOFFTVThkanBISW1QcmhUdld1bDBmRVI4?=
 =?utf-8?B?cXZrcDB2c0hIbmJxcE40NkdyODA4d2hVVkVsWnBCVGRERzZLZTVqUHg2YVRC?=
 =?utf-8?B?RFhHc1VtVXU5b1RIVVprbGsvMk1BVldJWCtyMFJZUkZXcFJXeFNJMmZDSW5z?=
 =?utf-8?B?NHI5Q3JoTk55QzM4WFg4YU5OMmZuL0pjOGdmTmhJNzFRbitMYnUrM0M1Ujdw?=
 =?utf-8?B?NTVsVkJvMTdGNU45NFJ6ZzhrKytvVUFxT1JLZDBLTExWNVB6MEZYSUZhSFdN?=
 =?utf-8?B?bmcwVEhwSHJLN3dKaE1IbTZUbmNqa0U5NEJGRGFKbDdiVTJROGJxbjQ3VjdI?=
 =?utf-8?B?eVhVMWFRL1ZGWE01a1ppbVBaY09Nd0N1SVk4bDBUV2NMMitBcUMyRlNoNG9i?=
 =?utf-8?B?a0xVdGsweHlNaW1ST2s0UVFwYkFtRUdlMlZTQUkyZXg4KytDeWJaek9DR0lO?=
 =?utf-8?Q?Lti3hHtNMjxeA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6ce45d-395d-48a9-8153-08d8dca886ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 11:52:44.8236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDH6zS9fmk9KdSW9ZFTukqKesK/+f1U5H6s7fz5+wBcNcZMGiTU5gWeFips0KMTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

Adding Andrey as well. Need to wrap my head around that problem once more.

In general the in_irq/in_interrupt macros should not be used in driver 
code any more and I'm pretty sure we need to block the access at a 
higher level.

Regards,
Christian.

Am 01.03.21 um 12:12 schrieb Dennis Li:
> When GPU recovery thread is doing GPU reset, it is unsafe that other
> threads access hardware concurrently, which could cause GPU reset
> randomly hang.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1624c2bc8285..c71d3bba5f69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1033,6 +1033,7 @@ struct amdgpu_device {
>   	atomic_t 			in_gpu_reset;
>   	enum pp_mp1_state               mp1_state;
>   	struct rw_semaphore reset_sem;
> +	struct thread_info *recovery_thread;
>   	struct amdgpu_doorbell_index doorbell_index;
>   
>   	struct mutex			notifier_lock;
> @@ -1385,4 +1386,13 @@ static inline int amdgpu_in_reset(struct amdgpu_device *adev)
>   {
>   	return atomic_read(&adev->in_gpu_reset);
>   }
> +
> +static inline bool amdgpu_in_recovery_thread(struct amdgpu_device *adev)
> +{
> +	if (unlikely(adev->recovery_thread != NULL) &&
> +		adev->recovery_thread == current_thread_info())
> +		return true;
> +
> +	return false;
> +}
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 71805dfd9e25..7c17a5468d43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -401,13 +401,22 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>    */
>   void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>   {
> +	bool locked;
> +
>   	if (adev->in_pci_err_recovery)
>   		return;
>   
> +	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
> +	if (locked)
> +		down_read(&adev->reset_sem);
> +
>   	if (offset < adev->rmmio_size)
>   		writeb(value, adev->rmmio + offset);
>   	else
>   		BUG();
> +
> +	if (locked)
> +		up_read(&adev->reset_sem);
>   }
>   
>   /**
> @@ -424,15 +433,19 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>   			uint32_t reg, uint32_t v,
>   			uint32_t acc_flags)
>   {
> +	bool locked;
> +
>   	if (adev->in_pci_err_recovery)
>   		return;
>   
> +	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
> +	if (locked)
> +		down_read(&adev->reset_sem);
> +
>   	if ((reg * 4) < adev->rmmio_size) {
>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> -		    amdgpu_sriov_runtime(adev) &&
> -		    down_read_trylock(&adev->reset_sem)) {
> +		    amdgpu_sriov_runtime(adev)) {
>   			amdgpu_kiq_wreg(adev, reg, v);
> -			up_read(&adev->reset_sem);
>   		} else {
>   			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>   		}
> @@ -440,6 +453,9 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>   		adev->pcie_wreg(adev, reg * 4, v);
>   	}
>   
> +	if (locked)
> +		up_read(&adev->reset_sem);
> +
>   	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
>   }
>   
> @@ -451,9 +467,15 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>   void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   			     uint32_t reg, uint32_t v)
>   {
> +	bool locked;
> +
>   	if (adev->in_pci_err_recovery)
>   		return;
>   
> +	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
> +	if (locked)
> +		down_read(&adev->reset_sem);
> +
>   	if (amdgpu_sriov_fullaccess(adev) &&
>   	    adev->gfx.rlc.funcs &&
>   	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
> @@ -462,6 +484,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   	} else {
>   		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>   	}
> +
> +	if (locked)
> +		up_read(&adev->reset_sem);
>   }
>   
>   /**
> @@ -496,15 +521,24 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>    */
>   void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>   {
> +	bool locked;
> +
>   	if (adev->in_pci_err_recovery)
>   		return;
>   
> +	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
> +	if (locked)
> +		down_read(&adev->reset_sem);
> +
>   	if ((reg * 4) < adev->rio_mem_size)
>   		iowrite32(v, adev->rio_mem + (reg * 4));
>   	else {
>   		iowrite32((reg * 4), adev->rio_mem + (mmMM_INDEX * 4));
>   		iowrite32(v, adev->rio_mem + (mmMM_DATA * 4));
>   	}
> +
> +	if (locked)
> +		up_read(&adev->reset_sem);
>   }
>   
>   /**
> @@ -679,6 +713,11 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
>   	unsigned long flags;
>   	void __iomem *pcie_index_offset;
>   	void __iomem *pcie_data_offset;
> +	bool locked;
> +
> +	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
> +	if (locked)
> +		down_read(&adev->reset_sem);
>   
>   	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
>   	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
> @@ -689,6 +728,9 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
>   	writel(reg_data, pcie_data_offset);
>   	readl(pcie_data_offset);
>   	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> +
> +	if (locked)
> +		up_read(&adev->reset_sem);
>   }
>   
>   /**
> @@ -708,6 +750,11 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>   	unsigned long flags;
>   	void __iomem *pcie_index_offset;
>   	void __iomem *pcie_data_offset;
> +	bool locked;
> +
> +	locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
> +	if (locked)
> +		down_read(&adev->reset_sem);
>   
>   	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
>   	pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4;
> @@ -724,6 +771,9 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>   	writel((u32)(reg_data >> 32), pcie_data_offset);
>   	readl(pcie_data_offset);
>   	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> +
> +	if (locked)
> +		up_read(&adev->reset_sem);
>   }
>   
>   /**
> @@ -4459,6 +4509,8 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev,
>   		break;
>   	}
>   
> +	adev->recovery_thread = current_thread_info();
> +
>   	return true;
>   }
>   
> @@ -4467,6 +4519,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>   	amdgpu_vf_error_trans_all(adev);
>   	adev->mp1_state = PP_MP1_STATE_NONE;
>   	atomic_set(&adev->in_gpu_reset, 0);
> +	adev->recovery_thread = NULL;
>   	up_write(&adev->reset_sem);
>   }
>   
> @@ -4609,7 +4662,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   	dev_info(adev->dev, "GPU %s begin!\n",
>   		need_emergency_restart ? "jobs stop":"reset");
> -
>   	/*
>   	 * Here we trylock to avoid chain of resets executing from
>   	 * either trigger by jobs on different adevs in XGMI hive or jobs on

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
