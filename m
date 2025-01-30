Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A701C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 16:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB40210E04B;
	Thu, 30 Jan 2025 16:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P83tKbMP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D1710E04B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 16:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jls98zY8id6tVm4mFDxsHy3C4yWYNwvUuUA860nJL0D8nAovuVerLfbP6D93TzdB2DxOVVkYWU3ikTQJIxWiTA8IvFA2JnkzW3r4wz4yWxYVE3Asr52x9dDpD6WbetkIugymtB4i2YHZknfh6G1njEHb5128IeKZHL0Z26ZBguQyavt+h4NXf6RYLgU+hmQf2wuloUd9TXxpjSCoHvFCQA2eYIN5XBq1w7thzSjYOByyCArCP/GLSULq8S98kNGEM2VePXiRPDqwYcjPeakayGcpbdNgup33C4Imq2nJhA1mj77IImI2rQoRz9vLDLLTwJSxiGH4+2dmgevuj8Mzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuQ2hC8zWY55fGaWpajMdaIS0tAo0Y9wmwlpgBrzPW8=;
 b=deZvZeqyu15uBPnuwJZsRyh4i/W1U+ZRUl7UyZOCcBpxjKctnxngdsRvT+9ucg01e//bbccT7J1VUjdkwswDZqXyKas68FEdkBjDOQ0L9HczDHdORYCu84Sq5KGYzi0Srov2KyXDmvgXJnEVlutpPIM+ig6LkW3ezFUPbAJRWZQYxTE49a5fLwb+aOq2dekV+Q4kjJ2OAG0dR70WqdHdoc1ndxL3dBuGYyq5jHkFNsvFh1MqJxL30mdcPs/07DJCbl67V5y4uOrGcG4oRIwSqx4tKw2Jl7g5rA783+Hsq5K2Ab+He/29+FixTZeR664aMy+SjJTjBjo3IM0iwCKfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuQ2hC8zWY55fGaWpajMdaIS0tAo0Y9wmwlpgBrzPW8=;
 b=P83tKbMPfhyEIihugmM5HcN4LzFaWsY7SwVL32xI1KGapXeC+/+/xo6l/+OLmrn6aYQIfuidZ4SF+rEeL/zqSSQbx6ZeJvBt9WPr3/bT2Rp7pZrNSznbU0dOYuc9upil2QdeASkFHrXvk/OIGp2+awYHW/dapWwHsNHj91zKTeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 16:19:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 16:19:24 +0000
Message-ID: <2cff3ac0-9f56-aaf9-6c6f-59c69606efec@amd.com>
Date: Thu, 30 Jan 2025 11:19:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Unlocked unmap only clear page table leaves
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250123203931.18867-1-Philip.Yang@amd.com>
 <af4ba8cf-b23e-497e-a5ae-2ae4f3aa24f9@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <af4ba8cf-b23e-497e-a5ae-2ae4f3aa24f9@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7501b7-fef5-46cd-ea87-08dd4149dc98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0R3dUpCWTNFeFpNdVpNZ1hrR3VYQTJSaURCQm1sL2lUTGxscWF2UkZ0N0xa?=
 =?utf-8?B?TnplK2g3TFNYbWlwMDFSaEJ4bzhVTGFEb1NzbnFOS3lITEdtMys1cWhzVjR6?=
 =?utf-8?B?VytHcmVDeFlhU0V0VG45TjFZdnY4c3pucDNrVUZBaFlLaWlrSTVOYUN4RUVH?=
 =?utf-8?B?eDVsVjVVdEpVT3ZTMkltZUlEQ0NmUGMyZ0tVZytyVFJnTVFCKzFoZElRbDUz?=
 =?utf-8?B?Zm5ia3E3Wld0dHJYTk1XMVU0ODZ2Q1Bic3N3WEljUVFINkt4SDNRZWhwQ01I?=
 =?utf-8?B?RHBVemFIVWdyZmdZM1FUL1RSVWliczVnWHR2TklkRktkKzc2bHFtR3IzWXlB?=
 =?utf-8?B?VEs0bzdLWFdLMDhWd3dFbkxiSXNFVTlFOFNYUzF2QjBabmsrNkRGM1NjUE1L?=
 =?utf-8?B?R0JOS3hNSXVZVFFkOXV4dFlzdU5Od3NVeVE2Qmg3RW5pRm4yakxBZmdSeVFh?=
 =?utf-8?B?VTM1Wm1XdWFjZG4wUk9BeUtsdE55eXBmb1ZyeXRQWHBiRjN6S3d3a3V3NzQx?=
 =?utf-8?B?M29OU2RCazN0eGkyTGtzY3U5cDZjSzJDWHYwWi82MHNrbGJwSUdNaGNnRDRE?=
 =?utf-8?B?OWRPMXErbS9MQzRwcE5lT3Exdk4rTkpqYkxtZmNmY3Mybk1vMzlJSHpQbGh3?=
 =?utf-8?B?b2ppdFROUHlybGgxM0hhZW9ucHdQd2FxeFFHTk5qU0llanlpekpFcUFnS29x?=
 =?utf-8?B?RzR4OU5iYkFQNHVpUmpueXdDeEpLV0JTTXUydXgrekh1T0x6dmkraFVZOWF3?=
 =?utf-8?B?MUwrbmUzYzVzVWFWVWE5dXZhalNuRFN3amNYTjhPRGVvNFJzeU1sUmEreWo2?=
 =?utf-8?B?V0tVWmlpU0lUMnVTZEwxSGJQWHpuLy91cUdrZVg5K0tBeUhmcXhUVkU0SFl3?=
 =?utf-8?B?R05Cd014VlNpVkVjYWIzU0F0NDFxTVNPSVFlWjRyQUNCUFBSWkFxeXNHSjV2?=
 =?utf-8?B?UFlpZWUvTFFGbGR0eWRGU2FTbzNicUk1cmlLMHVMS3M3STUxVC9ReVNPSEI0?=
 =?utf-8?B?ZDFHNUcwWkFBdmZsUlVXbDBJRUYyOVJEYW9aMmRqZGJWMXF3eEJEUEpEYmJt?=
 =?utf-8?B?ZTVybzRRRUtyVEliWlpnUDRlOUNsWklWY0NzRFdvTFozU1VIeU55dlZSalls?=
 =?utf-8?B?Yno0Zko4MTJ2dkVYZ1hUdTR0enRReFNoZ0NDejJtcE9zc0dJc0dpQk9VM3dt?=
 =?utf-8?B?YXJWbjF4TXBvT0dRcnlWa0dCZ3d6blR1MzFQcUh6NVhaSzZiVVNiSkJrcyta?=
 =?utf-8?B?bVVLMTVzeTdMQ2ZpT0duMi9veUxrdlkySVVQTjFVWlRBU2h1SkgybzJXcUcr?=
 =?utf-8?B?bU1VeVMvSGdLTnZkZ1V1dXp2OFYxNzl5R1Q1VHRIUEY0ZWZqay9zVmRzcHhB?=
 =?utf-8?B?UTFyUTVUVmtHVGdWejVkNGlhVm5vMHlENzFVcXpGY2xKUE5oZXF4Zm5TVGtJ?=
 =?utf-8?B?TW9TWnI1Z3pRYTh6N1NVTjdSM056TU5XaU54WmpoMFVHWkFVcE9KUkZVcGFV?=
 =?utf-8?B?cFVFTEF3WjBubElGQ0tWaXdWcWJOU1JPUUVmUGlWSHJYN2w0akZ0cG5mZXpR?=
 =?utf-8?B?UlgzVWlVd3JGd0pNNlJtcjNTcjAycytBV0RrKzJnZWhxcnk1RURLdC9YMGpH?=
 =?utf-8?B?R2tFcWZXUEpYc1A1cEdpKzFZQVNKL3YrclA5YjVPRHZEdlhWUkRZdHNwSEo2?=
 =?utf-8?B?SXFXSHltaWMvSktZOFAxN2ZFVzNmTUhSazFpN3hYZnBzQnpob01KYjhtKy81?=
 =?utf-8?B?dysrczJqdmUyajZvNmRnSnE1K0FMaWlqc25EOVVYS3dBcjhMSjk5UktoVk1G?=
 =?utf-8?B?NFdqY0xkQjhkK2FUUHFsZGxueXE2WS9VczFrNzJzeVNISGpHU3JjcUlqSkZ0?=
 =?utf-8?Q?aRnamNSng4wXF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NklGdTcwZCtGUlp5eUl5SmRaSlZEc2ZOWENFYUJEbWQwSlNGSEpUV1hQSmU3?=
 =?utf-8?B?V2tpb1V4WVZDT0tqY3BuSWZObStGY1drYnpGNnA4TGEvbDVadDVIbmZPb1p0?=
 =?utf-8?B?TkpRODRoSjMxbnkySkpIZHZ3dXFVeTdnTkp0dVNwNkdwMXIwWTNieFBQZmor?=
 =?utf-8?B?bU1WU1R5YldWWWUwWjdNTkdhTUhLdGJQM0xQUlFLNm40SkdKcEJRSnVyK1dU?=
 =?utf-8?B?Y2owUzcwU0x0NmlHNWlSN2htTFNZaVdiUlNrZVNjSnNwdmpiZ1NqejhBRDNK?=
 =?utf-8?B?MjA3YzQ1ZTBCSmprZGE1N2cyc1BWdmFYZXBnQXZyeThGNE9rd2xvM1M2WEtF?=
 =?utf-8?B?ck5QLzFOK3R2OS9KeGxNaVp4aEFEQXdNQ2c0UjBmM3hlbnVRMXdqMUs2Q1pO?=
 =?utf-8?B?QUhOZWJTYkZJeEI1MWwrMjhNYm9PQnFEY2xvWVdQcmMwNUN2Z21TTEVVZjlN?=
 =?utf-8?B?OTBXV3JuTkRVQk50b3Q1UDVEMGZrczBMbkJvL3RpZnhYZUxCMDUzTTRxaTBD?=
 =?utf-8?B?QUp4UnF2dGoraUxtNnZ6YUFYNHV5TmYwQjJKRFZOVlM0ZkUwbEJ5WG1GdHla?=
 =?utf-8?B?Slo2Zyt6VmVUMnlrSWZLMTJXMENsMlMzU3o0TDcwbFlwbmJSZmRNTDJFeEM2?=
 =?utf-8?B?ajlyV3hEQitudVZmdWttQklkTk5Dd2hrVXYxeFFxbklTWTVrMU1pUU45b0dM?=
 =?utf-8?B?MVBDcWNvOGdqeGxrNk9xMzdDdDUrQlIwRHRZR1JRcE9rbTB0KzRZaEtoeXpl?=
 =?utf-8?B?aStiRlFNN0c0Rko3TlpCdnFXZEJtQ1F1ZnJnK1dOdnp4SWtKS1BXRktGcURG?=
 =?utf-8?B?ME9Ic1YyY3VKVzJIK01xRmh6Z2xTL1FncXJEdnE0QTNEelhMQXlINFJkYWxu?=
 =?utf-8?B?MUxnRFhreDd6VzdaeXJ4Z2lMdG9SaksrTVA3aWh2d3BwbEJiL2pYTjl3SVZq?=
 =?utf-8?B?RnpLSzYvZ0JNdG55SU42dHA1UytKWnhzMVdwb3JubHlONlVUMmlDZHg2M1Z5?=
 =?utf-8?B?WkFmcmErR2NzNUxNK0o2QUlSV2w1ZVdjR05ld1FMZ1pTcGFxMEF4QkQxeFZa?=
 =?utf-8?B?YlZMVDB6YVdoUUpEK2dJcXlhTGE0UlhMQmhjdHpHbnFsWkF1WDhUbXFyOERI?=
 =?utf-8?B?TzNBcE5QNmJrK3V3L2h1d2x5MW51L1FBbEVSelo4bGtYbi8wSjhHcDZFY0tG?=
 =?utf-8?B?cG8zVHE4NnVVSzVRVkh5cEFrWlg0YWh3SnhRaUtuM1c1cG01dDh5V09DcDg3?=
 =?utf-8?B?blNZWlUwOElFd2N3TlFyV1ZrQW51cFpKL290ZjFlVTBiOHh0ejU3cm5BKzh0?=
 =?utf-8?B?L3JSMnZtbXRRenF5MkhXWEtZVFhwY3JRdXlIZkE3S2hMUmhkR0s5MTdkcy80?=
 =?utf-8?B?M0QrVWJSRUE2TmxWbHRLOW1KYVNKOE5RenRCWWZCemtCUVFCNFcxZmxscGhv?=
 =?utf-8?B?ZnJrWnA3VHhnNHBLWGZDdERtZmpwbmRrYmMwc21EREZtRVVmR2JTeFJhd1Ex?=
 =?utf-8?B?S3BOR3pIT0QwOTZ4ekowZ2d3UHFUdDR1d3RpZEZUeDM3c0RZZHlwd0Y2dElE?=
 =?utf-8?B?eUZJd3BicndoY3lEUWoxYzAvT0JTd1hOL2lwS0pKay9yeUdFSDVKWXNCSmtX?=
 =?utf-8?B?SzgrZUE4Qk83djhaWllDR05nM3kxcmsyVVRlajhrQkp6Y0ZFbWJEWnkvdnhx?=
 =?utf-8?B?YzdSbjhpaVFzeU50UmxzRzh6bGhVVXJpUGJRdVZOazEzbUc1U0hMNkhWelFC?=
 =?utf-8?B?QS9rWDR5ODBkdEdES1dxR2U5dkY1NUR2L0wzRDYwQkxlZEtkSkwwbU9KTmw2?=
 =?utf-8?B?WWt0UEI2RlFHYS9Kc2VnZGl5RW91YWZVWVZGSGZDNG15SGFEQzErbVRhWGJY?=
 =?utf-8?B?VGIwOWZFNkVvaHpsRlBOaVZrNjJKWVE0SThjWEkwYW5aR054OExLOUxmZzJN?=
 =?utf-8?B?UFVQMVFRVTRpYVd0TmZXZ21CMG9xVFlLYTJraFJpaGFGdms5S1pOQW9EaUp0?=
 =?utf-8?B?UGJHWWFQK0taSFNaZnRzZSs0UG0vcGxpN2d5RzFNRFYvbFl4MWN1YTJlcStG?=
 =?utf-8?B?L2lCZGtBcTZrNmo1djJTelhmZDk3Vnh0dEswQTREc1FHeDhRTzR5elM2VHpX?=
 =?utf-8?Q?hABIc2Ui33SuOCO6VPZdWrJtI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7501b7-fef5-46cd-ea87-08dd4149dc98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 16:19:24.7430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gmmm+P44LNDbJaRsxeOH63x4tXYU2dDbNJcCROA1DKjpaTIDhUIw8zjkibBCqvHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-29 11:40, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:af4ba8cf-b23e-497e-a5ae-2ae4f3aa24f9@amd.com">Am
      23.01.25 um 21:39 schrieb Philip Yang:
      <br>
      <blockquote type="cite">SVM migration unmap pages from GPU and
        then update mapping to GPU to
        <br>
        recover page fault. Currently unmap clears the PDE entry for
        range
        <br>
        length &gt;= huge page and may free PTB bo. Then update mapping
        should
        <br>
        alloc new PT bo, but there is race bug that the freed entry bo
        maybe
        <br>
        still on the pt_free list, reused when updating mapping and then
        freed,
        <br>
        leave invalid PDE entry and cause GPU page fault.
        <br>
        <br>
        By setting the update fragment size to 2MB or 1GB, update will
        clear
        <br>
        only one PDE entry or clear PTB, to avoid unmap to free PTE bo.
        This
        <br>
        fixes the race bug and also improve the unmap and map to GPU
        <br>
        performance. Update mapping to huge page will still free the PTB
        bo.
        <br>
        <br>
        With this change, the vm-&gt;pt_freed list and work is not
        needed. Add
        <br>
        WARN_ON(unlocked) in amdgpu_vm_pt_add_list to catch if unmap to
        free the
        <br>
        PTB.
        <br>
        <br>
        v2: Limit update fragment size, not hack entry_end (Christian)
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 --
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp; |&nbsp; 4 --
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 54
        +++++++++--------------
        <br>
        &nbsp; 3 files changed, 21 insertions(+), 41 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        index c9c48b782ec1..48b2c0b3b315 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device
        *adev, struct amdgpu_vm *vm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;vm-&gt;status_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;freed);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;done);
        <br>
        -&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;pt_freed);
        <br>
        -&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;vm-&gt;pt_free_work,
        amdgpu_vm_pt_free_work);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_KFIFO(vm-&gt;faults);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_init_entities(adev, vm);
        <br>
        @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device
        *adev, struct amdgpu_vm *vm)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; flush_work(&amp;vm-&gt;pt_free_work);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(vm-&gt;root.bo);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(root, true);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_put_task_info(vm-&gt;task_info);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        index 5d119ac26c4f..160889e5e64d 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
        <br>
        @@ -369,10 +369,6 @@ struct amdgpu_vm {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BOs which are invalidated, has been updated in the PTs
        */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; /* PT BOs scheduled to free and fill with zero if vm_resv
        is not hold */
        <br>
        -&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp; pt_freed;
        <br>
        -&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp; pt_free_work;
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* contains the page directory */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base&nbsp;&nbsp;&nbsp;&nbsp; root;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *last_update;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        index f78a0434a48f..063d0e0a9f29 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
        <br>
        @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct
        amdgpu_vm_bo_base *entry)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;entry-&gt;bo);
        <br>
        &nbsp; }
        <br>
        &nbsp; -void amdgpu_vm_pt_free_work(struct work_struct *work)
        <br>
        -{
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
        <br>
        -&nbsp;&nbsp;&nbsp; LIST_HEAD(pt_freed);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; vm = container_of(work, struct amdgpu_vm, pt_free_work);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
        <br>
        -&nbsp;&nbsp;&nbsp; list_splice_init(&amp;vm-&gt;pt_freed, &amp;pt_freed);
        <br>
        -&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; /* flush_work in amdgpu_vm_fini ensure vm-&gt;root.bo is
        valid. */
        <br>
        -&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(vm-&gt;root.bo, true);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next, &amp;pt_freed,
        vm_status)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
        <br>
        -}
        <br>
        -
        <br>
        &nbsp; /**
        <br>
        &nbsp;&nbsp; * amdgpu_vm_pt_free_list - free PD/PT levels
        <br>
        &nbsp;&nbsp; *
        <br>
        @@ -579,20 +558,9 @@ void amdgpu_vm_pt_free_list(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params *params)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = params-&gt;vm;
        <br>
        -&nbsp;&nbsp;&nbsp; bool unlocked = params-&gt;unlocked;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;params-&gt;tlb_flush_waitlist))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; if (unlocked) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;params-&gt;tlb_flush_waitlist,
        &amp;vm-&gt;pt_freed);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_work(&amp;vm-&gt;pt_free_work);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next,
        &amp;params-&gt;tlb_flush_waitlist, vm_status)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
        <br>
        &nbsp; }
        <br>
        @@ -611,6 +579,11 @@ static void amdgpu_vm_pt_add_list(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor seek;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * unlocked unmap only clear page table leaves, warning to
        free the page table entry.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; WARN_ON(params-&gt;unlocked);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;params-&gt;vm-&gt;status_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_amdgpu_vm_pt_dfs_safe(params-&gt;adev,
        params-&gt;vm, cursor, seek, entry) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entry &amp;&amp; entry-&gt;bo)
        <br>
        @@ -794,6 +767,21 @@ static void amdgpu_vm_pte_fragment(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This intentionally wraps around if no bit is set */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = min_t(unsigned int, ffs(start) - 1, fls64(end -
        start) - 1);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * MMU notifier callback unlocked unmap only clear PDE or
        PTE leaves by setting fragment
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * size to 2MB, 1GB, 512GB. If leave is PDE entry, only
        clear one entry, next fragment entry
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * will search again for PDE or PTE leaves.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; if (params-&gt;unlocked) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*frag &gt; 9 &amp;&amp; *frag &lt; 18)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = 9;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (*frag &gt; 18 &amp;&amp; *frag &lt; 27)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = 18;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (*frag &gt; 27)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = 27;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
      </blockquote>
      <br>
      That here looks unnecessary, the higher level handling is able to
      pick the right PD/PT level based on the fragment anyway.
      <br>
    </blockquote>
    <p>Thanks for the review, it is very hard to image this case, update
      PDE0 entries, then free PTB bos, as this works fine for locked
      mapping.</p>
    <p>For unlocked unmapping,&nbsp; after updating multiple PDE0 entries, it
      is incorrect to free PTB bo if there is non-huge page mapping,</p>
    <p><br>
    </p>
    <p>For example, below is debug log to unmap d4000 to d4806, address
      d4000, d4200 huge page mapping, d4400 not huge page mapping.<br>
    </p>
    <p>If using fragment 11, it trigger the bug. No issue if we limit
      the fragment to 9</p>
    <p><br>
    </p>
    <p>[&nbsp; 192.084456] amdgpu: 4 cursor pfn 0x7f87d4000 level 3 shift 0
      frag_start 0x7f87d4000 frag_end 0x7f87d4800 frag 11</p>
    <p>move cursor up to walk parent node, as this is huge page mapping,
      no PTB bo<br>
    </p>
    <p>[&nbsp; 192.084463] amdgpu: 5 cursor pfn 0x7f87d4000 level 2 shift 9
      frag_start 0x7f87d4000 frag_end 0x7f87d4800 frag 11</p>
    <p>clean mapping on PDE0, d4000, d4200, d4400, d4600<br>
    </p>
    <p>[&nbsp; 192.084480] amdgpu: 7 cursor pfn 0x7f87d4000 level 2 shift 9
      frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2</p>
    <p>Then if (amdgpu_vm_pt_descendant(adev, &amp;cursor)) is true, <br>
    </p>
    <p>[&nbsp; 192.084487] amdgpu: 8 cursor pfn 0x7f87d4000 level 3 shift 9
      frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2</p>
    <p>This is fine, no PTB bo<br>
    </p>
    <p>[&nbsp; 192.084494] amdgpu: 9 cursor pfn 0x7f87d4200 level 3 shift 9
      frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2</p>
    <p>This is fine, no PTB bo<br>
    </p>
    <p>[&nbsp; 192.084501] amdgpu: 9 cursor pfn 0x7f87d4400 level 3 shift 9
      frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2</p>
    <p>PTB bo found, trigger the WARNING in this patch, to free PTB bo.</p>
    <p><br>
    </p>
    <p>[&nbsp; 192.084525] ------------[ cut here ]------------<br>
      [&nbsp; 192.084531] WARNING: CPU: 9 PID: 3249 at
      drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:585
      amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]<br>
      [&nbsp; 192.084854] Modules linked in: nf_tables nfnetlink ast
      drm_shmem_helper k10temp msr fuse ip_tables x_tables amdgpu amdxcp
      drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched
      drm_suballoc_helper video wmi cec drm_buddy drm_display_helper
      drm_kms_helper drm drm_panel_orientation_quirks i2c_piix4<br>
      [&nbsp; 192.084987] CPU: 9 UID: 1000 PID: 3249 Comm: kfdtest Tainted:
      G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.12.0-kfd-yangp #146<br>
      [&nbsp; 192.084997] Tainted: [W]=WARN<br>
      [&nbsp; 192.085004] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00,
      BIOS F12 08/05/2019<br>
      [&nbsp; 192.085011] RIP: 0010:amdgpu_vm_ptes_update+0xa2c/0xbd0
      [amdgpu]<br>
      [&nbsp; 192.085316] Code: 24 4c 8b 54 24 78 4d 89 f8 48 c7 c7 b0 83 0a
      c1 4c 8b 4c 24 50 50 8b 4c 24 10 e8 8f bc b9 d2 48 8b 74 24 68 5a
      e9 70 fe ff ff &lt;0f&gt; 0b e9 92 fe ff ff 48 bd 00 00 00 00 01
      00 00 00 ba ff ff ff ff<br>
      [&nbsp; 192.085325] RSP: 0018:ffffbed102bf78b8 EFLAGS: 00010202<br>
      [&nbsp; 192.085336] RAX: ffff9f04b654a1f8 RBX: 0000000000000009 RCX:
      0000000000000000<br>
      [&nbsp; 192.085344] RDX: 0000000000000002 RSI: 00000007f87d4400 RDI:
      ffff9f0af6f9cac8<br>
      [&nbsp; 192.085351] RBP: 00000007f87d4806 R08: 0000000000000000 R09:
      c0000000ff7fffff<br>
      [&nbsp; 192.085357] R10: 0000000000000001 R11: ffffbed102bf76e0 R12:
      ffff9f046b100000<br>
      [&nbsp; 192.085364] R13: 0000000000bf4000 R14: ffffbed102bf79e0 R15:
      00000007f87d4800<br>
      [&nbsp; 192.085371] FS:&nbsp; 00007f87d5a515c0(0000)
      GS:ffff9f0af6f80000(0000) knlGS:0000000000000000<br>
      [&nbsp; 192.085379] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>
      [&nbsp; 192.085386] CR2: 000055a190964b78 CR3: 0000000163fca000 CR4:
      00000000003506f0<br>
      [&nbsp; 192.085393] Call Trace:<br>
      [&nbsp; 192.085400]&nbsp; &lt;TASK&gt;<br>
      [&nbsp; 192.085408]&nbsp; ? __warn+0x90/0x190<br>
      [&nbsp; 192.085422]&nbsp; ? amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]<br>
      [&nbsp; 192.085832]&nbsp; ? report_bug+0xfc/0x1e0<br>
      [&nbsp; 192.085849]&nbsp; ? handle_bug+0x55/0x90<br>
      [&nbsp; 192.085860]&nbsp; ? exc_invalid_op+0x17/0x70<br>
      [&nbsp; 192.085871]&nbsp; ? asm_exc_invalid_op+0x1a/0x20<br>
      [&nbsp; 192.085892]&nbsp; ? amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]<br>
      [&nbsp; 192.086199]&nbsp; ? srso_return_thunk+0x5/0x5f<br>
      [&nbsp; 192.086216]&nbsp; amdgpu_vm_update_range+0x242/0x850 [amdgpu]<br>
      [&nbsp; 192.086537]&nbsp; svm_range_unmap_from_gpus+0x117/0x300 [amdgpu]<br>
      [&nbsp; 192.086906]&nbsp; svm_range_cpu_invalidate_pagetables+0x426/0x7a0
      [amdgpu]<br>
      [&nbsp; 192.087259]&nbsp; ? lock_release+0xc8/0x290<br>
      [&nbsp; 192.087276]&nbsp; __mmu_notifier_invalidate_range_start+0x233/0x2a0<br>
      [&nbsp; 192.087292]&nbsp; migrate_vma_setup+0x1a3/0x250<br>
      [&nbsp; 192.087307]&nbsp; svm_migrate_ram_to_vram+0x260/0x710 [amdgpu]<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:af4ba8cf-b23e-497e-a5ae-2ae4f3aa24f9@amd.com">
      <br>
      Apart from that the patch looks good to me.
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*frag &gt;= max_frag) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = max_frag;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag_end = end &amp; ~((1ULL &lt;&lt; max_frag) - 1);
        <br>
        @@ -931,7 +919,7 @@ int amdgpu_vm_ptes_update(struct
        amdgpu_vm_update_params *params,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* figure out the next fragment */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pte_fragment(params, frag_start,
        end,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, &amp;frag,
        &amp;frag_end);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag &lt; shift)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag &lt; shift || (params-&gt;unlocked
        &amp;&amp; shift))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (frag_start &lt; entry_end);
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
