Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA186C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 19:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F0A60FE8
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 19:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2F0A60FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D0C89DC7;
	Mon, 25 Oct 2021 19:24:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E9E89DC7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 19:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1z/t0dfC5br1cZCxyXkZ+bDDNsT1VEXjH6KmMtyGjN8A/2cqZlh3rTWBJAoZ8wd9+ltnwG9iamQmxjthXcB/2ubpcPauBFANhmGV9BM1pFTfvmlo2511jnchzDDC4kp4TPFvYCjtPs/LdKFiyu5nD99V8tMu/bEGWlcDWo0hYLhXosAfd5wzqJCuJ029JMpiL6EHNIDhN3RIYaoLy+wUruSLfwqAeZQLPEMV/gerzkUEOe5A/xJVt9rpIaGHUM/lllYfwW5bo8w9ixy0CQftNZnGQVWh++a8BmNNClohA3gmJRjcFGh3YwzvQvLyDIlncnUNN8VmkDuAOhiwFwqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VlMhPMIuEUL+S459CmRLk32h0idpDPsrDYyYGjSt04=;
 b=jl1mPfh2APv+pM7HLhY5DzmRO94xfCq0+G1jwuCWVpimLJQJ7974gXw+9tco50JYObWLST8rgapIFq3qtreW3dVGM/Zp8KADAhSBWj70xdbyuKrN43WIkC6YlIG2tbVRsOivtifaNt14JdIjuAYsS6/p2CUYgxqyapRJh4zA3urwvtfRxzBfOhxU9hjQJNwCXyQt3oRGQ92iVQ0SHXXhRoZ0FVegO3WakCgkjHyQ+2kKr3Xe0R7dXXWA4dYZ91qiI4wNHcKPhuyZWvGee8UGqfPVfAU9ccEieETvwNsIoKjHHlGjdz2xrLpc66FOJpcyVoCLr8guCxXNf9eJo4nrQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VlMhPMIuEUL+S459CmRLk32h0idpDPsrDYyYGjSt04=;
 b=Dzoyv1s/4IwlLksJwNzlqgN3yAg9GTTMRqlsIMpHsoqvDjaOyZ1YKxxD49dU0P6gVP7FSsAjgXXRjRuMqm8JputGJIsI1QRyBI+qrYWKKcFnfD9ouXLIKORp3/iTSdCfB37H4bKyCHS0elDxChdsCmDx8OI9z/gEigKXNiQGSR0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 19:24:29 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 19:24:29 +0000
Message-ID: <4c54222b-9605-8d1b-fd68-838c88cd89c9@amd.com>
Date: Mon, 25 Oct 2021 15:24:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu/display: add quirk handling for stutter mode
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211025185217.97006-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211025185217.97006-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0209.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0209.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 19:24:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fabec3cf-f3bf-4440-3204-08d997ed10c7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54447FC0124BD7A19EE69CC68C839@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LY97HU+w4vprLLeT6LV/Z3+0P3STUzrIDTFhwbCrxQel1u2m9MJuJjmMqwl10uLH3hhSFtL+3EFQUAZdN15oLvFZUY5alDHoyIXcxdsiiFr0sOozyaQJY18t4msQTrmkaeu19pG1W6+2htA+jEZclcf1rY3JRkggHneMU+Pl8o5j/wC+Fi7C99JMEfOnBCu07g2esHxHhlaWqQ6tffr33SWORGrJKF2238CXblkKqMRyIcTKawcsnxgWMhSv9v0d10igTUDl6ORpiY4oekVOyBM03y5P1LsDbEJlzQ5bvCAvXCwEkV174xFQZHHHeud8utn8okcoIHlRvv/m6k0sjieUV5UCtyi9DVqba7ImNrqqfupRx9kNQdiIAEFnYwJobSleYcTfgaTEYTTyJjGvt8nD6ewzgsTKuAqU44GqK/l3mpDBBideUD27iYOVw0UI3YAK2ymtOUXnS1088R/eNBumf+JdwLYAc/t1+eE17R7jETkCRwN78qVWKUGk2B+hS68kXNxSfJbD+fX/Pfyx+OEEo637Honvbw+d2MuTd9Y/DBYlywRb36cPWmecl8BwJ31hFYMAWrzWSzq2dsLLt1Ag9x71raexD749A/TKs7PzTeRvCnyr8yka3be0qIqhgLUX2oM/kD+CMy1oQerJ2vEMyWsxIzBFaNCjP9+WtEpoemgqA4JSNjQeCI/Ddf/TLLCmGXB/GDXupWHDtfqf9aYCVsWAXTIjvIWGTNGlERW+KlqxN2etHfo7ZlcbC1eFP7bLSlSRd75fpUzbV7ylFeghV9Jk6nFqP6qd3l3RM4T1URr2Lh4SK2i6SftTjTlf+T+nW2ElzeAj7CrHX4j4Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(5660300002)(36756003)(44832011)(2616005)(966005)(6486002)(186003)(31686004)(53546011)(16576012)(2906002)(4001150100001)(956004)(66476007)(66946007)(38100700002)(86362001)(316002)(508600001)(31696002)(8936002)(8676002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTQzc3crb1Q5YkdNb0QxeklVQ1RXMVhxcnhyM1h0blVWamRLYnRNZ0VwT2I2?=
 =?utf-8?B?dU1neFRnckp5T0MwY2dXRGpRaUplNzgxb21sdnl6aU5jTHJ4Uk1abHRwUkRn?=
 =?utf-8?B?aGNTRlEyQXZYbEYxeFk3MWVwempGeENNdS8zLzBodzM4a2ZuaGhKeTcvcFVH?=
 =?utf-8?B?TDEzTkt3aXQvM3NjMFV6a0JPVHo0T3hNa2JwNjZDdUc1a1lNUk9yWGNWN0JQ?=
 =?utf-8?B?SEdQd3RtQ09TOC91aHNrMktQOTRIUVhWVGozeXJmMUdzZ1lZVFpDWTIvazJH?=
 =?utf-8?B?TWhKNHNqblBqTlBPelltZlFpcm5nM1NCaDZENkpINkNkMVdPRHI2b0hwaHVu?=
 =?utf-8?B?N21yL04vTnpZN3o0VGhQVGZua09xOEh2YzVIU2QzRDhFKzRIUDh5UmpiRi9q?=
 =?utf-8?B?SjV3RnB0a2YyQlRiVUxpNUtXbXorUDJmd01QTHVQVGtKNGN1eStiTFZZdWdJ?=
 =?utf-8?B?OG9KNkNRNkJ3UjVPYzNrOHhMaTJFUGJ0RE91RFBDYnZCSndHRDQ5dUd6d3Nk?=
 =?utf-8?B?RFEyTm1CRk1uSURvR1hQMnhJQXowZGJvUFUrcTJSYXVTc1BLek5kWENsejIw?=
 =?utf-8?B?U2ZPMmVwRi85UlRNaWpsOTA5UDhmdVR6ek1ETUdSMi9HaGYrUE9oNXgzdEp1?=
 =?utf-8?B?OE5rMEEwVlk1VHlxVVJoU3dkeGEwTmU4K29vMGp0YUtqbGhVdmN3WUpnTEtF?=
 =?utf-8?B?aWwxbnplSEF6cjRSSXZBYXJjVWFHSFRFcm5hWVJDajBDQ1dIRHU2TFEwNTFy?=
 =?utf-8?B?Qm9YQ21Jb29HeFcwY3BRUGlwN1FIMkFDNTlCbzdMSVgvUkllL2dlcGQ4YzEz?=
 =?utf-8?B?UEFSOCtyQktOTjQwNmF4SXZMYlQ1NzRVa1JzeFc5c3dZWEVwbEJwNDVvNmJj?=
 =?utf-8?B?RzhxdzRZaGEzYjJOWEpWQ3hETG5mOWdLdkhoejR4QlhDVmRNVFRDZ0xDVFhJ?=
 =?utf-8?B?SmltUld2Zm5FYjBadGNYQ0xoZGZGUXhtcGJOUmhnUXg3clFUVzFoeWt0OGt3?=
 =?utf-8?B?UFo0YXZObjUwcStUUW82ZjNQakNzUUhLSjZGWnliZ1kwandGV2lDZVdBR1h3?=
 =?utf-8?B?cXBtaUNwMGF1T2x1dDJ1eXQ2d0RRMGVtSmYvQXRnNERGRE8xdEVNQVRncHBB?=
 =?utf-8?B?WFoyVjdic3pOM2Z5d3phUDRseGNBYUEwTmR5dVJhbjFxaHZCSXFYeDRJSlFl?=
 =?utf-8?B?blV4VlhDeGlieitMMTV6Zmc3NC9na2xmeHpLK0RVQ1lVZ1k5YjlRd0YrSk1q?=
 =?utf-8?B?ejBCNzBFVkFFVDhHQUE0bkJvUWc4bWwvamQyUDE5N0xDTmd0dHlvMHBhb2xi?=
 =?utf-8?B?VE1KUWVRTk5IZEZTMmhDY1o4aVJER0tvQlRpTUtOMTZVVDU2UnB4dS9nc0dR?=
 =?utf-8?B?MWRKK0dTcWJpOUlyNmJ1bUZ0Yi9DNFBjMU1WUmZFN0I1NlJpaWt5S2xXQkd2?=
 =?utf-8?B?b3kzVXdKWVVINndUUzB2cWoxcTBBTDI2bUdVYVNuZ2pSQUoyc0ExV0xHSmpq?=
 =?utf-8?B?NllqYzBNMU1yNWZZOWZaaDlnUVZlSnoyTmVESXAvbENRL1BFbENMQ1Fra3By?=
 =?utf-8?B?azFXSzVsM1lvME0zYmRKUTdXSzFsVkE0eXFYRHA3bmZ5K0l2NW5JL1dET0tt?=
 =?utf-8?B?SDY3UURjMUFhRVBseE9JQ0lHOUlYVFJYQXRITnRPYWNPaUE2NlNtRzRpRzJE?=
 =?utf-8?B?eTI2RmNjeTFWcS9ZYmZJaFdPc3h1QUhqK1J3TkhtaloxdExrNGZaNW5PUVQ2?=
 =?utf-8?B?N0crY1JpUEJDdXJsZVJQdko4VlM1N2FTdlZoNEhPb3VXeUlKRkVoOHFaRjNS?=
 =?utf-8?B?U3B1dWpBc0FiNHk4OUN2NmJ6cklPbHpGUnhRUklGWWZheXVZUS9BMThMNXRl?=
 =?utf-8?B?TTIwZThsVEtIVVQ0MnBiRnFuTEc0TkVmWk4rY3NVT0cwTUlZOWF2cDA2YWNt?=
 =?utf-8?B?Q2NVK3JTODFEWERtTDRLcXlTTFdLTHc1bzlmZzFLc2pLb1Zub3VvRklKZnFW?=
 =?utf-8?B?T1dFQUkrcGxCdzI4YkJZcW94VmJ1OER2QnlKS0liS1cva3hRTmt2dDhwMTJN?=
 =?utf-8?B?M0d2UHRKVG5VYVZPOTNYRXBsNGpHd2YxeDVXZEpXNjRKQWVGV1VKSFZYVUZC?=
 =?utf-8?B?cThKYnAzQmdkb1N2b29XOE9WaUYreGdEMnM4NXJNQjFoNndSTlFvTXlSVkdO?=
 =?utf-8?Q?aBBG+4LD6AK0q3fRoYPU4LY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabec3cf-f3bf-4440-3204-08d997ed10c7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 19:24:29.7434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4Iayx47QW/tX8a9FlTFKlp1KZBpWUmiL/DCkLag6Q0m2WypdtmTpOIMY4n+bW/Ay4eyuCAMYKlkm4oCUxl1/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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

On 2021-10-25 14:52, Alex Deucher wrote:
> Stutter mode is a power saving feature on GPUs, however at
> least one early raven system exhibits stability issues with
> it.  Add a quirk to disable it for that system.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=214417
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5b8d1635da5c..b635b893837b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1295,6 +1295,37 @@ static struct hpd_rx_irq_offload_work_queue *hpd_rx_irq_create_workqueue(struct
>  	return hpd_rx_offload_wq;
>  }
>  
> +struct amdgpu_stutter_quirk {
> +	u16 chip_vendor;
> +	u16 chip_device;
> +	u16 subsys_vendor;
> +	u16 subsys_device;
> +	u8 revision;
> +};
> +
> +static const struct amdgpu_stutter_quirk amdgpu_stutter_quirk_list[] = {
> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=214417 */
> +	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
> +	{ 0, 0, 0, 0, 0 },
> +};
> +
> +static bool dm_should_disable_stutter(struct pci_dev *pdev)
> +{
> +	const struct amdgpu_stutter_quirk *p = amdgpu_stutter_quirk_list;
> +
> +	while (p && p->chip_device != 0) {
> +		if (pdev->vendor == p->chip_vendor &&
> +		    pdev->device == p->chip_device &&
> +		    pdev->subsystem_vendor == p->subsys_vendor &&
> +		    pdev->subsystem_device == p->subsys_device &&
> +		    pdev->revision == p->revision) {
> +			return true;
> +		}
> +		++p;
> +	}
> +	return false;
> +}
> +
>  static int amdgpu_dm_init(struct amdgpu_device *adev)
>  {
>  	struct dc_init_data init_data;
> @@ -1406,6 +1437,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  
>  	if (adev->asic_type != CHIP_CARRIZO && adev->asic_type != CHIP_STONEY)
>  		adev->dm.dc->debug.disable_stutter = amdgpu_pp_feature_mask & PP_STUTTER_MODE ? false : true;
> +	if (dm_should_disable_stutter(adev->pdev))
> +		adev->dm.dc->debug.disable_stutter = true;
>  
>  	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
>  		adev->dm.dc->debug.disable_stutter = true;
> 

