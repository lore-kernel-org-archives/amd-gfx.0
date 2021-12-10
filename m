Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA113C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 21:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7965710E296;
	Fri, 10 Dec 2021 21:07:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D2710E296
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 21:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awsXUzFwtvPhmmXJOMi5af+8YEGKC/94NA2xUoiUSGpafFbWiYofQZP6pKh5ThgUFyZaTvyzTVYQyatPCUvu/unDyuL3MFtdeKzKRhDIv/qJj8SCfAafQoAf7P48i5t9aCL6VJoLX2IAB7q/LmntmxJVgry/sAl9Ky4eBtB2xK7gKJeWroit7jmFJ+WhOMsGZFG1l312XhfKVjsZFkwcCn5la/DoYvNBTrF8C5hBVaBdTid/sti7UeP6t9rWppoMoTN+95gbB5K5ZcRT+omH1Psc+Rfff9KNmpL5bDLyM3d6h28dbsagY+mClVHCbI+0I/M/QrYXqYDU6nnjtFG0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHWSwqX1y3uMtSwY+E66FvYp3uWGVezay3zIqNQqIHc=;
 b=LieS45eg+2BWfabh1RqxexNl7ud8h406I5pj0EdZnVYvd2CuT5/Dnf4Cn7Nf1FDIHx68Gvioybomf/RtxylB6v4jjBjbTu1teILK/W/1SlB/k0XlleixfOWzEBpHC0FVcOXbyWArAptrtyRGE74TG5UObto2LUXwIWki8uan2hJogdUfLQ0SuK3M2nAmgaTbyRKMJIgu6zP2QQX4x0Gs7WQYr18UN3fs27ehI4g2n3rpD++2EXuPN5HTvxekNXZwwY0OupBpvJOeBewFDSjtPw5jRFv650O/Wq94KoBS57ZxanQacO4XQAGceo7l2Iek2cPSo3ZM0UJl9E9VNJqHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHWSwqX1y3uMtSwY+E66FvYp3uWGVezay3zIqNQqIHc=;
 b=wq8hf0OqScnvT8i2lA3brqzJm2BBGZ9p2h5mS0AqcFqvS2uUov9V3Puw11/X5h3jkUAYy8NYbQyly6lFMJGmxO8muMYEGVtm8XIeUgxkwHHVzhmiyg2vEZhO+ES8T/vDxXevJV6qClD3209q9NABjN9zhB4+OVVDZ9ynl7dUFa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 21:07:05 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::9d61:180f:e2e0:2db5]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::9d61:180f:e2e0:2db5%8]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 21:07:05 +0000
Content-Type: multipart/alternative;
 boundary="------------CHtkszt3G9mI3j85zVteH4tq"
Message-ID: <f1f996f4-0bc3-aa01-f9da-3664b14f7861@amd.com>
Date: Fri, 10 Dec 2021 16:07:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Content-Language: en-CA
To: chen gong <curry.gong@amd.com>, amd-gfx@lists.freedesktop.org
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
X-ClientProxiedBy: CH2PR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:610:4d::28) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0569965-7cad-43d7-e5b0-08d9bc21052d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268FEC27CF4C7F800435B94E4719@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYoET6nndcFIo/J3FEprw+wUyu2FY6JvNPeJkb5oSdrnP0oo6aPYjFWxE6yter7BdZDRfc12OpboMVAhoAuHVRLshDS+RWOK1EFhva3+IBvE9uVUR+iK5vrh+O+88akYwA3UFFO4+lkGYdQOuGG7Dg+azgND/Bv4JlPEEebcW8sd2UYvEQYWOn2HpjljPMMMDKsX2j0rFxB45OG6wlfG/CHZmBKGP+JZlMExX5dTjiSwsqLvnCvChk6etr4I1D+KWAcuxkw21013hafFks5+2BakEjAdXYRvty5B9Vwd6VBPKobwhYMypT/aWF7Fl5SE2u7P3uFKB69MKGQW3/Bb6oQZ0Gpgazq8ks7eq+Tiefovz2Ze8pokEYwVdSbTswuX7BALkWOzsPc4Ae1L/o4Bu1w8As0S5cc2gDNkzVmjSbU4Gxo/yRzIlZNkHsukmPpfdzoOSLqdPfhXg+5lTAAEC7+CNsSV2B77Qzibclx5vUoBefOfuqf6rKq5c/0yXuRP2YjgXTpDzXlBUorlIVaPq4XzJOKLlDm0yg9fxUFLjfbrvyfl943X3dzdvVTWH/ejNPZdb8jAtEz/U0lVhlzT4kodjic7P3dTXZmZHXgy75/vnz/M/UxifijaUsHqLCNvhmDx/O22w1WRvaFe5BMIJKPAJsuR6E+hP3XQU/GaWukI1GsnUEj+YoHfrT26C5i461VyQl4NPLUK7qHDHcAuXVbYwXUhOP19rBUbexM5NXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(31686004)(4326008)(33964004)(6506007)(53546011)(83380400001)(6512007)(36756003)(2616005)(31696002)(6486002)(8936002)(186003)(5660300002)(508600001)(316002)(4001150100001)(26005)(2906002)(15650500001)(66476007)(66946007)(8676002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9oc0lTWEJ5UHpFL3ZqR3RUS1BUbzYyUjRjYW13Y1RRdnVpaTEwQWordjU0?=
 =?utf-8?B?NzJRd2dBTm5kdDRjN2NRZnNERUxLSlhCekpnTTV4MG1DVDQ1VktOazdiQXVz?=
 =?utf-8?B?dk5BU3V1Z2pYSmp1dXhKeHh0VDlONlJFRlZHQzhPWVc1TnhlSzg1bFpZblk0?=
 =?utf-8?B?dVptY1ZmM3dkSmplZFhjSG5yeXVjcFdOR0pLQ2tRdDNLWUhrazRsTTdIbERp?=
 =?utf-8?B?VytRMURQYllDSHY1bHNUVG1kZ0NoYWR4VW5vcTltOGJ5b2RqSnp2VHNNL3Bo?=
 =?utf-8?B?M3kxU2RVN21hc2sram5sQnZmeVErSFNkcDhXOEJSL2ZPNzQza2tTalh5MC8v?=
 =?utf-8?B?V21teEYxNDE2Y01Lcm05Tk1TSjFjekFvbHRERU1KbmhlRytma2pPVFBjZm5W?=
 =?utf-8?B?NVdVanBLNWhaRHljSkRYMWcrNWVCamxFMG1OY0Y3YjJveUZ2cEdRWjVMT1NN?=
 =?utf-8?B?UzBYYnh6MTYrRzRsUC9NWFB1RTZVSWxJNWtMS005dkpJUGpKWlh3aXZBQmRU?=
 =?utf-8?B?UXovL09kcU5oK3VqU3M2cEgwNjhXRGVjdUVYNmVPbjZCQkpqY3UrNGJSK0dE?=
 =?utf-8?B?SUFiYktzNndIM3YvMi9yTXdSSHR6WFJpaFhUUUtIUHNocTJQd05aUUFQakxj?=
 =?utf-8?B?N1EvUldBNVVTVU9VZnZyT0JhYzBpZmUvb1VaZ0NlaDNoRU5FZVNHYm5lOEU1?=
 =?utf-8?B?Y0NtNmozc1h1K1pPWWhqUFNCYlRWRjNIUGN0Smg5YUNQL085LzR0UzQ0Ym1o?=
 =?utf-8?B?U1BOaThQT1JaZ3E2b1RSVnpLTERjMDlYUERBSi9NcmFWUHFudGZJK1RXM0tp?=
 =?utf-8?B?a2s0RGNBZ3RUbm5jWHBnNEo4OVNjK0VuMDN3UUgvazg5TDFEMTdqL21INEJR?=
 =?utf-8?B?UzZFaWhVZGk0V3l6T3VlM1FLQWN0aHE1cjdFL1FpczZBcjBoYXhVYmRGUUNw?=
 =?utf-8?B?dXJvRUV3SmwyTnM3ZmdDbTh1cm1lZzdia1RTQzBXRWpjcGJFcU13QXgrdmVP?=
 =?utf-8?B?ZkM2T1dEbDFqQ2J2Z05OajZMRzd2YkxRYklPblUzQ21ESUF3eUNtUnlKWjN3?=
 =?utf-8?B?S0s4MWwrUkMxRFRLbERJd0VCR1huT2kxNDZsQldBb2ZGYkkyNmlSUkpiVXBK?=
 =?utf-8?B?VWRpRzlubkFZSzZPR0thbTliZHFuazZNeDVxUEIybGRPSlpOeFluZHBIamdW?=
 =?utf-8?B?YUlQcUU1UjlPVThCYThoU1lXeGtLSVRCZ3RiZ25QSDd6OExua0plaVlZblJB?=
 =?utf-8?B?K1IvSjdYdlN6eFZZNmc0SThLbEFrU1NLTUFKaU1yS0ltZStFNlhlSWNuM3dZ?=
 =?utf-8?B?am9kaDlVeG0wTCtBZ1B5cUJ5ME5LeHlWczhZdTlVNHIvTEhpTHFUYnpJM0h4?=
 =?utf-8?B?R0ttZ1FvTlE2MVFuZHNDcEIrd3YrSEVqaXpPL0E1QWJET2JXT2hyWnJBQnNH?=
 =?utf-8?B?T0V6TVRlY1hxOC9qYnIreWJVY2RZdk53NFNqQ25BSnA2cHZLYXZMa1B1eFJr?=
 =?utf-8?B?WXVZS2pDT0J0aTlsbklBZERZTDhQL0JpbVRNT3VYZ1dqa0dwcVlLVytRSEtJ?=
 =?utf-8?B?em9OT21vQ1JBTTVJUER4eWFGWHFDeGxnY1ZNWWUvRkhnMndMY3NMU1NNemJn?=
 =?utf-8?B?RVliSkxJeWdXLzVqSTBQd24zZGVTM2tIcFJ1MTRlL0tXRGJqTnRlaHA3UmZk?=
 =?utf-8?B?UkY2L0VtUVB2M1cxb0NST1F5NG1KQi9BazBYd0hmTTAyaDNSb3llbllhdDFS?=
 =?utf-8?B?aHVQeDhXNG55ejFQZngwS3lkSG5jOXF3RC9XOW5lRHBFRFh4VjcyYWNYVm92?=
 =?utf-8?B?clFCb1ZEUW9BZ1Z1RE5DeHFGRHFEU3ZYRFVUK2N4UkR4K1BXeGw3QWttV0Z4?=
 =?utf-8?B?K1RaS1kwSWJTdEpvM2RmTjJyMVlhaTN6YnJ6VVdWSHh5aXRQdEFLUXVlcU1l?=
 =?utf-8?B?VUw3d3VQMFdibDQ5MGpFeUsvSC9LK1R5YmNCM3ErYWhYcDFWd2Q3aWs0NHJ6?=
 =?utf-8?B?SDQzejQ4bVovblZ3M3p2WTNvblpNaVZVRklzRnFQQUVvTVlFYXR3aE9qeC9n?=
 =?utf-8?B?T1J3R2dNNENTSk9UaS9PaVlsK0t6Q1NSOGY1NWZHQXEwSTVLRlU5dHZvNk1m?=
 =?utf-8?Q?H2GY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0569965-7cad-43d7-e5b0-08d9bc21052d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 21:07:05.7751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Se13ZB0lJ8NAexMqx6rEwRTQ2p/2QgCe6S13k7eP6q+BqD0V9FzSXlf2OnmA3xu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, leo.liu@amd.com,
 evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------CHtkszt3G9mI3j85zVteH4tq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2021-12-10 6:41 a.m., chen gong wrote:
> Play a video on the raven (or PCO, raven2) platform, and then do the S3
> test. When resume, the following error will be reported:
>
> amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
> vcn_dec test failed (-110)
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
> <vcn_v1_0> failed -110
> amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
> PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110
>
> [why]
> When playing the video: The power state flag of the vcn block is set to
> POWER_STATE_ON.
>
> When doing suspend: There is no change to the power state flag of the
> vcn block, it is still POWER_STATE_ON.
>
> When doing resume: Need to open the power gate of the vcn block and set
> the power state flag of the VCN block to POWER_STATE_ON.
> But at this time, the power state flag of the vcn block is already
> POWER_STATE_ON. The power status flag check in the "8f2cdef drm/amd/pm:
> avoid duplicate powergate/ungate setting" patch will return the
> amdgpu_dpm_set_powergating_by_smu function directly.
> As a result, the gate of the power was not opened, causing the
> subsequent ring test to fail.
>
> [how]
> In the suspend function of the vcn block, explicitly change the power
> state flag of the vcn block to POWER_STATE_OFF.
>
> Signed-off-by: chen gong<curry.gong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index d54d720..d73676b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
>   {
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	bool cancel_success;
> +
> +	cancel_success = cancel_delayed_work_sync(&adev->vcn.idle_work);

[JZ] Can you refer to vcn_v3_0_stop , and add 
amdgpu_dpm_enable_uvd(adev, false); to the end of vcn_v1_0_stop?

See if it also can help.

> +	if (cancel_success) {
> +		if (adev->pm.dpm_enabled)
> +			amdgpu_dpm_enable_uvd(adev, false);
> +	}
>   
>   	r = vcn_v1_0_hw_fini(adev);
>   	if (r)
--------------CHtkszt3G9mI3j85zVteH4tq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
</p>
    <div class="moz-cite-prefix">On 2021-12-10 6:41 a.m., chen gong
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1639136511-6357-1-git-send-email-curry.gong@amd.com">
      <pre class="moz-quote-pre" wrap="">Play a video on the raven (or PCO, raven2) platform, and then do the S3
test. When resume, the following error will be reported:

amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
vcn_dec test failed (-110)
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
&lt;vcn_v1_0&gt; failed -110
amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110

[why]
When playing the video: The power state flag of the vcn block is set to
POWER_STATE_ON.

When doing suspend: There is no change to the power state flag of the
vcn block, it is still POWER_STATE_ON.

When doing resume: Need to open the power gate of the vcn block and set
the power state flag of the VCN block to POWER_STATE_ON.
But at this time, the power state flag of the vcn block is already
POWER_STATE_ON. The power status flag check in the &quot;8f2cdef drm/amd/pm:
avoid duplicate powergate/ungate setting&quot; patch will return the
amdgpu_dpm_set_powergating_by_smu function directly.
As a result, the gate of the power was not opened, causing the
subsequent ring test to fail.

[how]
In the suspend function of the vcn block, explicitly change the power
state flag of the vcn block to POWER_STATE_OFF.

Signed-off-by: chen gong <a class="moz-txt-link-rfc2396E" href="mailto:curry.gong@amd.com">&lt;curry.gong@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index d54d720..d73676b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
 {
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool cancel_success;
+
+	cancel_success = cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);</pre>
    </blockquote>
    <p><font color="#288aeb">[JZ] Can you refer to vcn_v3_0_stop , and add amdgpu_dpm_enable_uvd(adev, false); to the end of vcn_v1_0_stop?</font></p>
    <p><font color="#288aeb">See if it also can help.
</font></p>
    <style type="text/css">p, li { white-space: pre-wrap; }</style>
    <blockquote type="cite" cite="mid:1639136511-6357-1-git-send-email-curry.gong@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	if (cancel_success) {
+		if (adev-&gt;pm.dpm_enabled)
+			amdgpu_dpm_enable_uvd(adev, false);
+	}
 
 	r = vcn_v1_0_hw_fini(adev);
 	if (r)
</pre>
    </blockquote>
  </body>
</html>
--------------CHtkszt3G9mI3j85zVteH4tq--
