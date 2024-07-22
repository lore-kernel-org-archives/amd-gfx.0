Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A8C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 20:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7767F10E141;
	Mon, 22 Jul 2024 20:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJG0KJni";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC40110E192
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 20:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKsDT+vdSz2biCTt35jBv3yqj6Q+0tNhbXAwMU3EMM2EEL10VhjDeH8MWVydoxeshoUGPN/7NDOmBKbG0MwkrmRilzsMk3v+a+xRgBSMUt+TVXqwOfmIPb/vI0ha1GTSSnlFCkiKoQlkr4bXZYsHHWiVF5YYILjBNbig5ZuUB/uDyGaK3ihVAns9XX8b2Sf69rYAB1c3HDIxoYFkE9ZDkDkeIkYQu4C1s3N13S4OQOuIoXWKa/5oWCrZLvYjHzCgsrLVcwiv84mPYKGSCT8dWodNKi5RcwrpiXMELeEXVLlXuZCnQP8axG0C/GCFY3ZN7vT5cTlqgyGSpUzfx7JRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSYTuNCb40SfSb53tZenap+Z+tQ/wPAl9kbMWxRCqEw=;
 b=zCQMXoNklwyJGo0+7pAy09vMZKY0DynTM2XgXsQQ/C2E3ak8uOitUR6r/3N0QIKRG5CjqjDxR7qgAOeTte2lY+SIHXsRwhhNRMCOJG6VFGZiHL3+P/3VAoxAaLrWaoioseioL0l3oENQ/f/1Fr6zLiOd9WHQfC5+x9GUyNmrQHNjMLTMMAfMnNk37czqV9kPNEYgZjNV/PhWEXgVzvcGssFImT/GfFv+Xl9LbVCFjOgdQXxc9POrtigMk7xmHoj2ALqc1DZMJDYAIyobRt8meLXKVVy5fcrZhss8G7QkqbQ/pcgU8ij7WXrAZpN4Hk4jbkh0LmUbBzM+RJ7xX0j1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSYTuNCb40SfSb53tZenap+Z+tQ/wPAl9kbMWxRCqEw=;
 b=MJG0KJnitD4jAXJDLNC2A98aLE5Yre4gNBX6Hg2p9zcFZsDXxlHRMaCDT8W8fRJl48TpW5pdTOzmEyGZY1FhWGC52FjSvvhwc+coUNkl/c76RSmtrBc44lWJmYmA76g/KUmHfndBe4edctjVYTmk/Ovh//lviOEI7xsuECOS9P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 20:00:35 +0000
Received: from IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692]) by IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 20:00:35 +0000
Message-ID: <78c7fea5-2794-475f-93eb-06897d39cc6f@amd.com>
Date: Mon, 22 Jul 2024 14:00:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add NULL check for clk_mgr and
 clk_mgr->funcs in dcn30_init_hw
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tom Chung <chiahsuan.chung@amd.com>,
 Roman Li <roman.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
 <20240722105119.3849289-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20240722105119.3849289-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:303:b6::10) To IA1PR12MB8495.namprd12.prod.outlook.com
 (2603:10b6:208:44d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8495:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e99ea1-aed9-4f58-19a5-08dcaa88f2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmoyT2pkYkVEaUxVNmU5ZTFjKzc2T080bkNNemV1R1dLU043blhpdmRPMk55?=
 =?utf-8?B?cjRCc21oTEFpajl2WUMzbTczM1VLT2cwS2duWklWSjU3bEU3aXdqZjQ0SlBV?=
 =?utf-8?B?c0pNUXAwQjAzUklqaXRVeEp5bkFnL0NGcERrZWtuNkZtazZuRDFzUXYvbmpD?=
 =?utf-8?B?OW8ySTFQTXp6VWlqL0ZTSXJkZnprWlFMR0Z2dXVUNGNVWGtHRGs5V3hlamhk?=
 =?utf-8?B?TTJhUUVScWFNMzZQWFloY0JVWG9FcWhLRytjOG41UTlwZG9UNnBxTkRocXdt?=
 =?utf-8?B?Ni9NOEk4R2wzN09TRkNFcHdUT3dNeEpvbHk1SVJjOEoxS09aMmpBSlA1MjI2?=
 =?utf-8?B?QUc4SEhpaHZHQTZkdStFY0MrUDBhK0ZreFNDQnF4M2tmOGQ4WWJyY01Eak5C?=
 =?utf-8?B?czVCa3FFZUE0R2p6M3RZdlBlV254VUx2anRFZjhYRHlsRkhoV0Q5NXNoMEpK?=
 =?utf-8?B?VDBGVjk2VWhQcUt6Vlh3c3RwVE1IOGo4cnRxb2JDL0NVZjc5dml1Nkk0bG8z?=
 =?utf-8?B?QzRwWUtXbWNuV2ErVndvN0RjZzVvcFQwbThCSTNtUlI3YkFrVnZrWXIvREVN?=
 =?utf-8?B?Tm1mS2lGcTIvTjdIdE1VN2pSYzc2T3dhTk5TYTlLZmczWGkxSVhQOUttRHI4?=
 =?utf-8?B?V0JHUHpuVlc1RWl5dU8zZjBBUjVrUnBiU3lTYjdqM2pWR2p3aVFuR1lCRWQx?=
 =?utf-8?B?d1N2TjNoQ3pLZDdkQjBiZmtBcVlvN2Qwc3had3BXNmJETDJVREFaWFZRaU9z?=
 =?utf-8?B?WjNKaXptMzB4YXFWRk1zUWMxUTRnbkowSTd0YXZUcGJrRkx2Vm1SU3FncUQ1?=
 =?utf-8?B?RW42MHZMdkpzS2Z5S1pqa29KZmVXZmNhWVpRRlhoeUdsazVMOFRWRDdGSG9s?=
 =?utf-8?B?ZmhRNXhmRTF0TEY3VmNJb2R2WG0rN2ozVGFXQ0ZxbkN1TFNvRk5maSsvUXhR?=
 =?utf-8?B?WGcxVXVid3lFNm1BQWY5cVgyZ3Zqa29WYUM0NXAwRnZSL0JxYXUvbk1xaU1J?=
 =?utf-8?B?OHRJUTN6cXIxMEJQazd3TElzWFM0NTMrZmNWb2lrelVwQmdYV3c5WG14ZkxG?=
 =?utf-8?B?RmJoeGNSdkJOV0krcW5MVXRYQ2dFVlZQYjNSdGxWcm0xeXVGK0FGOGdkQlJZ?=
 =?utf-8?B?RVIreWRYVHlnZ2krTVVLcWZVQ3FsVlk0aG91K2Q5cmFlREpqNVJwU1lPajFY?=
 =?utf-8?B?dVlrT3Y5T1lwd21BcTlTbzMvYTVqU0ZBK2o0d1lUWU5HSlhVTDc0aURldFpO?=
 =?utf-8?B?N2hpT2gwUjlVYVJkdkZMdW43MEttckRzcE9wcHVGSm5FS3dOWHBDNmZ3NUZ4?=
 =?utf-8?B?TkVHNzNDT2srb2I4cFRZS3NZNTdBbWhldnB2akhDVm5iNXFZNnVyb2UrYnVu?=
 =?utf-8?B?VllOaUJuRm9JQkIxUzkza1FWNklvSFNLTmJjV1JGa0VIcFZKRFRtV2NRblp4?=
 =?utf-8?B?OVZWMkxaMHhsbFg5aWkvV3lRRnh6WDd0ZnVtZUdpMnNqWUFYcWN1dkJlQmpF?=
 =?utf-8?B?YStVRmtqNkNHQmUvaVVIRHJMM0VmRzI2VDhvb1B0cjBqTlIxbGYzS3BnZCtP?=
 =?utf-8?B?RndidENheTNsQ3RKdXA3a0VFVVh1cUVLYXVmbkt0c25BY1BGTTRTdnBJeEJr?=
 =?utf-8?B?N0F4MStlS1VJblBHWE1FWG85NGRETGt0REJIOEJIdkVHLzFBWXZIc0ExNlZy?=
 =?utf-8?B?ZUpjYTA5VjlzeTF6cHU3RUM3ZklFcElaRmxmOTdFeEZUV1MyVmxjc1cvQWRH?=
 =?utf-8?B?NTJ2RU5GVHlGMkhoTUJPUFRxUVpIaFBERGpSeUNJZ1VLT1ZXVjFiYnNMdUd4?=
 =?utf-8?B?ckVRa0wyNEtoZTcrQm9LZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8495.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anMrK3ZHdFByYlpVZnBPZHlqeTF4d3RsUmhrVk1oczJRKzhEVVNmQWYvRlNj?=
 =?utf-8?B?WFJUcFFMeVp3bHpaT1R1MG9lTndtNEphdzdFbFVOM29rM01xdHh0dlR6TVhk?=
 =?utf-8?B?Sm9NVXo3RyswUnFSbHIwbUR3TkxLa3Y0bVhIQmVuMUdYT1ZYYXpQQlg4aUJt?=
 =?utf-8?B?M3JGWERlZzJjRFJtNlp1cmVudmczOENsOXcxakNSeXdtZ09IdmdNb3AxU3Js?=
 =?utf-8?B?ZFZaVE42RmVjNEpNVFlDYXFkbzNJUXd6T0Q1c0srTXQycEkwb2RyVzhudUV5?=
 =?utf-8?B?aHpldUhORVdDQzJ0bFpkZjZiUmtVaHB1cmdSK1ZKem1vdDhYRHlPeEV1cWtZ?=
 =?utf-8?B?Tkc5VFBlUXB4L0pFK0xjelp0T2o2MGMwTkFLR0REMEw4RVJYR3dJZFZLTG1q?=
 =?utf-8?B?SlFJaTR1VkNiaFczVHZFZGNBcTF6MkQrKytta1QwTjlLdEtSalRTcExrREhq?=
 =?utf-8?B?Vk05UTVVQUJVOXJJV0YyVkVKVEIyWDIwMHRkdDlDc2tQYUJ6RjBIbk9pVXE3?=
 =?utf-8?B?aEd2dndtUGRZaS83VDNMcEp3Uk1vL2Yxdnh4TE9BK1BydVliTndoWTB1dzA4?=
 =?utf-8?B?RHB6bmNRNUpOTy95Wkowd201VTFHajY1VTc0U0VrK0RBbjFlVFRVdXd1WmtZ?=
 =?utf-8?B?Z3FEZFg5ZXFrMXF2OEVhZUpKQzZ0TlJOeDU5aGJ5MHgrTnpBMTE4c3pBVFlq?=
 =?utf-8?B?UlpMUHJMM2dLOFZGZjJGYzAwNW9iYkMrbnR4MWpvSGFXUWhxMHpXZ0RoNnBP?=
 =?utf-8?B?cTRzWTFIcTUxSjd0bHFBYlBYd3hXVDBoMWhjb1V1SXNhTTlNUEFmeGlUYUdY?=
 =?utf-8?B?SnQ5ZWNnbW5FT2tZUkM5NTMzaDVuRTMzVC9PRVRIdE1rNjlWNGtrMFVJZ2Ex?=
 =?utf-8?B?M2FOWTVYaENBQjZlQzN6NTB0blE1Nkk2QmtNWmpjU2RMMVpKdVlOVGMwZGdL?=
 =?utf-8?B?ZWRzbUdIb1FCSXpYSU1VTzFrVzhrTzM4ZFpqUHpnQVVtSDRlWUUvc3pJeWpF?=
 =?utf-8?B?TnpwSERSQmNVdjRqc2NTR2ZrNDB0ZE5wd1YxZm1TT21HWU1lbHFCSFRmcTc3?=
 =?utf-8?B?VEFWbW84MzIyRXlKYnV1elhIdmJsa2pmQUh4N2plZTZGeDJUbVBvbEtRZDIv?=
 =?utf-8?B?QmJXRWZJWFFQRTFOdDR2RTZOZEdldXRFQTBsVDczSFRMZEhxOU1ERlh4Q3du?=
 =?utf-8?B?YUZtVDQydGQ2NjZPQ1NzcVJJNmthSVpzb3cvNDh3Y3F2dWdjQXQxeHVaQmpi?=
 =?utf-8?B?dUFvSjBGZUFYUUZ2TEk2dWcrZlplL0p6UUg2NlQ3Z25WMkpuY1F2UEluNHIz?=
 =?utf-8?B?SU1IQk4velZoS0pybVFxV2NQNGtJWmlpUElMemlWUVc4QVVlSVJ6anhnanVY?=
 =?utf-8?B?aUVsL3lKWEhDZzBPUjU0Rm50RFZydmpGSk9pSnFzdU9IYjZjMDVqQTZjeldl?=
 =?utf-8?B?YkJxRGQrNWFBMGtQMWpOMzFVa1lCOHI1Y1FjL0EvT0JtUDhpOUdXblJEb0tv?=
 =?utf-8?B?dmxWS3hBTkJvSmpwZjAzVEU5TDJOMHZnYlNUNEU3Y1ltdURhVFpTRGVDVFJz?=
 =?utf-8?B?aVNjWUNzRnVhQ2lybjFkZEdNRURYZDkrOW1hR0wvR2JRajlrbnRxMFdhUDE3?=
 =?utf-8?B?Qm96eXRvUTBIMFNPWEpiNG9hblF6WkpPVzJOL1ZzOXN4czdjWG5sWlV1Nmk3?=
 =?utf-8?B?L1VtZlI1WFZyRU54akxnOVM1UEMzcWZ5OHZYNE52NkFiZ1JiN0laV0hLMURa?=
 =?utf-8?B?aVFhZW1uZk9FTzNXSzdZNHoyZFQrcVZ2ZE12MCtJbDBCTXV0cWF6L1RSYzlY?=
 =?utf-8?B?Ym1kS29oM3NhV2RicjJJa2cvWmh1eXoyRlUzQ20zcEhCS2RRVHFSNW9oKzFr?=
 =?utf-8?B?RDN1blN6UDZnNGpNQ1pTaGY0MW83Z1U0ZzUzYUx2UzRrNGo5Q3ZYc01iZ29h?=
 =?utf-8?B?azA3OU8zQW1RcmhQdkFJQlBKdUloSDBIU3V3clhvNTJhVm1DU2ZEVTdIU0w1?=
 =?utf-8?B?QmZER2ZMeFE1RDk4OThkQUJ0Q1RFRUR1eFRBU2VQdlVUakpSSU9BSFYrL3FD?=
 =?utf-8?B?K0MzYVFyYmxmY2VhRDdzaGNKT1Q2RWtXTmh4a3JvRTdyZG5JOGJkQmp0aktE?=
 =?utf-8?Q?jokfBrgMszAEvN7WFJgBq561r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e99ea1-aed9-4f58-19a5-08dcaa88f2ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 20:00:34.9452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVqvigK1fmlFKK1NwTYa1F5bhfTYuFB6VLL8q9TSnrdz+LBbTbJ8AT+BDrXUCG2TUYeJp00eDR/S6FpnUS3aYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2024-07-22 04:51, Srinivasan Shanmugam wrote:
> This commit addresses a potential null pointer dereference issue in the
> `dcn30_init_hw` function. The issue could occur when `dc->clk_mgr` or
> `dc->clk_mgr->funcs` is null.
> 
> The fix adds a check to ensure `dc->clk_mgr` and `dc->clk_mgr->funcs` is
> not null before accessing its functions. This prevents a potential null
> pointer dereference.
> 
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:789 dcn30_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 628)
> 
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2: Along with "dc->clk_mgr" add check for even dc->clk_mgr->funcs" (Tom)
> 
>   drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index fc5936460ac2..98a40d46aaae 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -625,7 +625,7 @@ void dcn30_init_hw(struct dc *dc)
>   	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
>   	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
>   
> -	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
> +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
>   		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
>   
>   	// Initialize the dccg
> @@ -786,11 +786,12 @@ void dcn30_init_hw(struct dc *dc)
>   	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
>   		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
>   
> -	if (dc->clk_mgr->funcs->notify_wm_ranges)
> +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
>   		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
>   
>   	//if softmax is enabled then hardmax will be set by a different call
> -	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
> +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
> +	    !dc->clk_mgr->dc_mode_softmax_enabled)
>   		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
>   
>   	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
