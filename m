Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BE7CD3427
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 18:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D656010E13B;
	Tue,  5 May 2026 18:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bPZgYs5o";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E6E10E13B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 18:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETVWk/mny4yBeHkVeuddgtJoMOvPBd2/DcUJnE/XgNZxRgPh7wFomq7iU9ybaPEsDT2iXyL45SGyxvoQLMzKdsJ9F1IUnggU+GPQEJ0rMckjWQCidhA5LFyubpTcSeMTmnFiSc69qWPmmlRFnJ1hx5lQQB+4dGBIBY7GVfm2guG+7R69A0ro2tNoS6TtJTncNgxTw3xJKBrBpbvbMVyfqGdaxhXfh7AW7Y29P6xPlni1boPTJbw+q2jq1LKAxQHNTHk1I7E/NU+NG6KreHQuFM+88oQiqXvixZ4ZmTIBZGtjjLHefxoGCMtvuwnBBDzvSvBmh3tvq0b9dMFzhrsMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFLinctbHVeAiEZYI4snVjeur4skFagC9U6+C2ltcOs=;
 b=wN7gccHp7B9QZq7fC0WQxTlnMWe8dKqhcGWpZg5tvKKEaVHXo8+fB/zT0AUN+6CxH9J7XeKaK724zVHQVJ+CscU1Lc5fMfoKY197rR4yqjTbFmSX4CA5fDATaBrq3GH5VQFrZ48AFaI558Q4d/8C/zlbTH+MECR2aUu8qJc0bjQcLrS5ZDUSk4SJ2K7MzTWKDHgMCASqHuoTNdj+ih6t+RW97FmkrrgQoa0EW/GygqQMmTHTDpJ1VpwLPpRb5zXZyS5q038LvreXYByQCSs9had1v8KFEHpeJCEzmjKItxst6EUNUi2nw4Arf9euFJPdDj2G1kd6PhrYk6FfZgqh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFLinctbHVeAiEZYI4snVjeur4skFagC9U6+C2ltcOs=;
 b=bPZgYs5oYSyPKj03fPtcZwoV08/HHOMhv05jgrpOlFa1w1YWuLtxos7ADq0+OIok19mDIM3fR37arr/0P1pdTLZ7SQRwbDeRM4lld54b1/zo6urcriSvdnkz5CCpR2N6REn+DUvajcLa+1zf4eQYqVmyF8k1UxuczgD336zaXUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by EAYPR12MB999134.namprd12.prod.outlook.com (2603:10b6:303:2c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 18:00:11 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 18:00:11 +0000
Message-ID: <3df8b289-2463-48de-a2b9-c287942128f5@amd.com>
Date: Tue, 5 May 2026 14:00:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] drm/amd/display: Tie FRL programming together in
 HWSS
To: Dyllan Kobal <dyllan@dyllankobal.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260502140825.705534-1-dyllan@dyllankobal.com>
 <8b617d99-7cfd-4637-997a-dd561d372730@amd.com>
 <zQoDVbkRUq6cOjFHY44CbOhFkxPKc3SsAlIZ32210blOHYO3EoaCw5vf6yI_3-2Ln299E0Ac78o7xSivgNoxHOE8R_mz9R5bu4a6YxbPQI8=@dyllankobal.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <zQoDVbkRUq6cOjFHY44CbOhFkxPKc3SsAlIZ32210blOHYO3EoaCw5vf6yI_3-2Ln299E0Ac78o7xSivgNoxHOE8R_mz9R5bu4a6YxbPQI8=@dyllankobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::26) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|EAYPR12MB999134:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c9b0a1-90c3-4331-ab66-08deaad02698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: g3NiU6lRhMriaUQ+e99VUmAk2/yqNyRvsbi5fFS41mIqA3Nq1+Q1gIndk8rntf5AGZPN5ONCF6GiLrYQKy/3YYsAlsYuG45U7LWEvlIXg3DRLKGrmeAQxzwY3IqnNgaWl+7gnqgEaASGVxgmMdSf1h6oRYv321lgu/DE/UtW2PzOnSCAGYHdsROAu3++W19Kde94WiuCRUsjsOO3VuGiUZB/mYrDF3gifC4Wv40LzZAwaywyXgu9AOIOKh8H/fV/NTK2jWx04ZOMvfE6KWfOG/JoxNSriWHOEBt08z5JrCLi0VvI1r9c+Ht5z/eyH6aE/m1t3xTxacXjHiz0CXeBwudFcfdBQqZhtAkIEHIN4LnzxLiwTEYadoNgFoCP0/YDC8fFL+AlAUNj5aVTNPQvCsBQhEc/zmiTC3K4ENK5Ls1mnFC1lYONf4mPPxG1WwFNiOyI94Wv9KrROrFfqzOfUYA+8c28HCiPiWqfW9ztvhXbJpEUXDjbrUUzaAOQckI3CF3+kNJ19iGHlK2IWZJV+lIDUKTW0ldWSrJ45XBHeU6f8rxMlOmIvVyZM9TThiWnoew48q/mHyFV/dI2QnAOnXYWQvLt1rrT3TJnqIskxDy/QM1U2lZ/4pAjGRsboLB8E2P+dqXdwfrLe8tOw5Oy0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk5JU09DSTEzKyszWk8vZVdqTTg2OTZzaFJPYlhCQlNlb0xBQkZFanRXQkxu?=
 =?utf-8?B?L203WCt6VE9VTkFBOGoraGZwTFpLMUhnd2djYjUvcXBERTE5NTBNWGpPK3pK?=
 =?utf-8?B?TGRzUFd2RzdzdytnT3huYnpheFc1aExNZDVuRk9JVE5lNjQrb0NrOVdmY2Vt?=
 =?utf-8?B?VCthZkVrcWdDTFIrM2FtUmxwWnkxWkorUllsRmw2VTBoakRCYytLTEVOQTEv?=
 =?utf-8?B?NlJWK09HTkpVN0o1OEtFekErUGhGWEZsSHQ0L21MMWt6cldLT3h4NHJ5WFBU?=
 =?utf-8?B?aVhQZUF4MnlZUGdEQXQ2N3gyVEg2UFk3emlaaURRWWZIRVdIU0w2QTJOaFp3?=
 =?utf-8?B?RmNVaFJtZWhWelJnbzEwSi8zR3RHMjZrVE1BWmtDSkIzK0pTVXp1ZXBUajk2?=
 =?utf-8?B?NXgwc25xaE9HS25Vb0pCNVROTzVOZ05iQjkzaGlOQWV4cXZtWk4yNmFuTnA4?=
 =?utf-8?B?VjJwTU51SFRrcXhlTGk5aHByWHllODRhd1IrdGE0c1V4SW5ycXBHRm1qbnV0?=
 =?utf-8?B?SVRJMFVMT29uOEVwODNvVVVGSTVwRTNCUVJna241cDZaYWg3MGxaZ1NWbUNH?=
 =?utf-8?B?Zlh6WXNyVlg4RHhGb2ZLTW1wV0VGbWExN2Y3aHBwL28yZTllRDZ1L2NSUG1z?=
 =?utf-8?B?OTAxWW0zd01SSWNKMld3VmdJTGlnSklVU29mcjZDMHVYSWhraUt5NkhqZlli?=
 =?utf-8?B?RituYUUyQWJGTFoyQ0pYVm5BQVN0OEd4dXplTWp0a3R3TVZjUDFVaFQ5ek5i?=
 =?utf-8?B?cjB1ajZQcFVuQ1Nza2l1ekU3UjRsbDVjUEp5cTlaYmNCRFVacEZvSnI5SUpa?=
 =?utf-8?B?cXY1RTlKL3MwcE5ydFN4ekN1M21jTUo4TDdSbFBGdzNjTVFLZ2p2Tmd4UmFZ?=
 =?utf-8?B?bDJyRVkxYzVMdlJWb2NZRUdlUkY4ZHFvT3VCZnV5cEZaMmN2NGQxUVo3K012?=
 =?utf-8?B?aG5GWDZIT1BYTFU5aU1DT3lTVWZFOWVsSk1CMkZoNnVDSXQ5R1RCWGtQL2ty?=
 =?utf-8?B?T0lHODZ2VklNdGFoWjZmQmxXb3ViejJyMC8xTUtSb3d1eWVERmUvdmxmUElq?=
 =?utf-8?B?NFNETXhDTm00UkRTV0F2SlNydFk2K2RQZWZvbzkvZisva2hPSjdULzVJakpv?=
 =?utf-8?B?dHVsSitGcW54UXBmUWRoUy80cWpsRFdrSnRPQXZiVXZmRW5Ub2NTUEJNb3hu?=
 =?utf-8?B?VWdWb2VlaU0zQ2pYRmFUK0I5T1RZR2dWaEJrNlFuYnF3b0Y0RzF2YlFzaUhs?=
 =?utf-8?B?alFkaVdWS05HUERDd3FGWG9id1V5TWlrQU82eEJ0UndrT0xrYlRTa1NlMVBr?=
 =?utf-8?B?bTBCTjhtYzNZYUJpNlptNkhxazNablkwS3llaFdaUnRhNm45QjN0R29DWmpI?=
 =?utf-8?B?T2dhOE1wZFJBTWcvQVVFbnl1NVRXZWNQY3lydVFTdER6R3hYcGdUNy96MVFk?=
 =?utf-8?B?M1hjTGxrYXBGbTVJQnVQUmtSZW13WVZXQWx6WlRkdzE1eEt3MTFyWFhVS3lJ?=
 =?utf-8?B?eHhJOTVNTHZkb08rVEJaMXEwWnFXdk5wNkpONVl2bjBPbisvL011QlpTMUND?=
 =?utf-8?B?VFhzd3N5RFlkU0JKY2lPSWVCajE0WU1kMWVIbk55L3Jka1hUVXFGWjNBZ2FJ?=
 =?utf-8?B?V0hYOWNSSWdZdG5lNlk5ZXdBVUU4eFZIRE1wMEoxTzlVSWJabHEyTDJlZzky?=
 =?utf-8?B?ZDdENTkxWDBlblAwOGVMZ1VqeXI2bXVqaHVQdE9XSjhXc1RWVTJaMXBTSHFj?=
 =?utf-8?B?NkRSaWQxYTN2bC9WN01LKzV3Q2I3bzB2MGFGamU2WDFvRDBFWHppWXc3dEcy?=
 =?utf-8?B?cVp6VlhlTm1TTVU3MFFOY2prTE10SVhwelNHcklqM3B5QVFDdnF0VFZiMVc5?=
 =?utf-8?B?c3RONnFWR0pwZnJ5K3EwL3VnN0tjVXdvQmp2blhyVERocDRacGQzcDcrNFlx?=
 =?utf-8?B?bmhwbWpkUVJ3c2pzUUh0bVdDZ016Qkd2QURHalF6SkY0SFlYSUhNZjVkNzJR?=
 =?utf-8?B?aVQ1cVdWTmRFcTNzNlZqRXZ4aUpSNkpSSDNZVTJGSVhBVmhRRGtEYkR3c25a?=
 =?utf-8?B?RElPR0tDeTFVQjJUazhNeGdidEY5VzNiNjZqYXBuU3dDT0MzY2pDOEZsZE44?=
 =?utf-8?B?anJqd0x1bXB6Z1h0cXRYUTJNMFpzd2FGRjFITnNHRFl5a1RsdU5DdDM0RjJV?=
 =?utf-8?B?K1o0R1A2N2ZkK0NML2xwRDZ4ZGR4NTV6TXVQT0xIWnozTkFwNTdqVzg4MURM?=
 =?utf-8?B?dHVNY1lmZDI2Tmh6YlhpNmZRZG5RRXdGeFNVSWRaejFlNFpaK2JiYTlvc2pr?=
 =?utf-8?B?bGNYS1ZTWTVmblpNclRBTzV1QmZTTFJwV2k3SU9nMXJIelZJa3ZNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c9b0a1-90c3-4331-ab66-08deaad02698
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 18:00:11.1967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +d9i5ARCioHITv0/1gtA1klEM5bC4l6EnH5T9jT2ivrKX+HeVU7SUaDCalOBZYtOsQbxGuzE+usxJNRIm8yNqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999134
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



On 2026-05-05 12:45, Dyllan Kobal wrote:
> [You don't often get email from dyllan@dyllankobal.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> That works for me, thanks.
> 
> I’ve resent the commit with a new hash, https://gitlab.freedesktop.org/dyllan500/linux/-/commit/e1aa6f65150d606299eec5bf5a734e3b7c20c029. The only change is updating the author email to my work address for consistency with future contributions.
> 

Sounds great.

Thanks,
Harry

> Dyllan Kobal
> 
> On Tuesday, May 5th, 2026 at 11:36 AM, Harry Wentland <harry.wentland@amd.com> wrote:
> 
>> Thanks for your fix, Dyllan, and for giving the series a spin.
>>
>> Would you mind if I simply picked up your patch from https://gitlab.freedesktop.org/dyllan500/linux/-/commit/560a1b22e4f764b8325e17f1d8f6dbbfd008e409 when I merge the series?
>>
>> Harry
>>
>> On 2026-05-02 10:08, Dyllan Kobal wrote:
>>> [You don't often get email from dyllan@dyllankobal.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> From: Dyllan Kobal <dk@zetier.com>
>>>
>>> Hi Harry, Rodrigo, Jerry,
>>>
>>> Tested this series on Navi 22 (RX 6700 XT class, DCN 3.0.2) with a
>>> Sony Bravia 8 II as the HDMI sink. Hit a NULL deref at amdgpu probe:
>>>
>>>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>>>   #PF: supervisor instruction fetch in kernel mode
>>>   Oops: Oops: 0010 [#1] SMP NOPTI
>>>   CPU: 14 UID: 0 PID: 568 Comm: (udev-worker) Not tainted 6.19.0+
>>>   RIP: 0010:0x0
>>>   Call Trace:
>>>    <TASK>
>>>    hdmi_frl_perform_link_training_with_fallback+0x64/0x110 [amdgpu]
>>>    hdmi_frl_verify_link_cap+0x24e/0x5d0 [amdgpu]
>>>    link_detect+0x4b4/0x550 [amdgpu]
>>>    amdgpu_dm_initialize_drm_device+0x73f/0xb21 [amdgpu]
>>>    amdgpu_dm_init.cold+0x734/0x86c [amdgpu]
>>>    dm_hw_init+0x1b/0x90 [amdgpu]
>>>    amdgpu_device_ip_init+0x690/0x7fe [amdgpu]
>>>    amdgpu_device_init.cold+0x460/0x781 [amdgpu]
>>>    amdgpu_driver_load_kms+0x19/0x80 [amdgpu]
>>>    amdgpu_pci_probe+0x19b/0x550 [amdgpu]
>>>
>>> Cause: this patch wires .setup_hdmi_frl_link into the dcn314, dcn32,
>>> dcn35, dcn351, dcn401 and dcn42 hwss tables, but not into dcn30's.
>>> The dcn30 family (dcn30/302/303 — Navi 21/22/23) does get FRL
>>> resource creation per patches 16/17, so hdmi_frl_verify_link_cap()
>>> runs on these ASICs and dispatches through the NULL
>>> hwss.setup_hdmi_frl_link inside hdmi_frl_perform_link_training_with_fallback().
>>> amdgpu probe is fatally aborted with no display.
>>>
>>> Fix locally:
>>>
>>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
>>> @@ -105,6 +105,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
>>>         .enable_tmds_link_output = dce110_enable_tmds_link_output,
>>>         .enable_dp_link_output = dce110_enable_dp_link_output,
>>>         .disable_link_output = dce110_disable_link_output,
>>> +       .setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
>>>         .set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
>>>         .get_dcc_en_bits = dcn10_get_dcc_en_bits,
>>>         .update_visual_confirm_color = dcn10_update_visual_confirm_color,
>>>
>>> With that one-line fix folded in, the Bravia comes up at 4K@120Hz
>>> 10bpc RGB native FRL on cold boot. Live register state confirms the
>>> HPO HDMI block is what is driving the link, not legacy TMDS:
>>>
>>>   - All legacy DIG[0-5] show DIG_BE_EN_CNTL.DIG_ENABLE = 0
>>>   - All legacy SYMCLK[A-E] show CLOCK_ENABLE = 0
>>>   - DIG0_HDMI_CONTROL.HDMI_DATA_SCRAMBLE_EN = 0
>>>     (HDMI 2.0 TMDS scramble path is provably idle)
>>>   - HPO_TOP_CLOCK_CONTROL.HPO_HDMISTREAMCLK_GATE_DIS = 1
>>>     (HPO HDMI stream clock is forced on)
>>>   - PHYASYMCLK_CLOCK_CNTL.PHYASYMCLK_FORCE_EN = 1,
>>>     PHYASYMCLK_FORCE_SRC_SEL = 1 (FRL signaling source selected)
>>>
>>> Worth noting: the public dcn_3_0_2 ASIC register headers in tree do
>>> not expose any of the HPO HDMI / HDMI_FRL_ENC / HDMI_LINK_ENC
>>> register offsets — they only define HPO_HDMISTREAMCLK_GATE_DIS as a
>>> single bit field inside HPO_TOP_CLOCK_CONTROL. Despite that, the
>>> silicon clearly decodes the rest of the block (the relative offsets
>>> from dcn_3_1_2 evidently land at usable addresses on dcn_3_0_2).
>>> This is the first time, to my knowledge, that native HDMI 2.1 FRL
>>> has been demonstrated working on a Navi 22-class card on Linux.
>>>
>>> Happy to retest a v2 if you fold the fix in.
>>>
>>> Reported-by: Dyllan Kobal <dk@zetier.com>
>>> Tested-by: Dyllan Kobal <dk@zetier.com>  # Navi 22 + Bravia 8 II, 4K@120 10bpc RGB
>>>
>>> Thanks,
>>> -Dyllan
>>>
>>
>>

